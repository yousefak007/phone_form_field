import 'package:circle_flags/circle_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_country_selector/flutter_country_selector.dart';

@Deprecated('Use [CountryButton] instead')
typedef CountryChip = CountryButton;

enum CountryButtonSide {
  prefix,
  suffix,
}

class CountryButton extends StatelessWidget {
  final Function()? onTap;
  final IsoCode isoCode;
  final bool showFlag;
  final bool showDialCode;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry padding;
  final double flagSize;
  final TextDirection? textDirection;
  final bool showIsoCode;
  final bool enabled;

  const CountryButton({
    super.key,
    required this.isoCode,
    required this.onTap,
    this.textStyle,
    this.showFlag = true,
    this.showDialCode = true,
    this.padding = const EdgeInsets.fromLTRB(12, 16, 4, 16),
    this.flagSize = 20,
    this.textDirection,
    this.showIsoCode = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = this.textStyle ??
        Theme.of(context).textTheme.labelMedium ??
        const TextStyle();
    final countryLocalization = CountrySelectorLocalization.of(context) ??
        CountrySelectorLocalizationEn();
    final countryDialCode = '+ ${countryLocalization.countryDialCode(isoCode)}';

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (showIsoCode) ...[
              Text(
                isoCode.name,
                style: textStyle.copyWith(
                  color: enabled ? null : Theme.of(context).disabledColor,
                ),
              ),
              const SizedBox(width: 8),
            ],
            if (showFlag) ...[
              ExcludeSemantics(
                child: CircleFlag(
                  isoCode.name,
                  size: flagSize,
                ),
              ),
              const SizedBox(width: 8),
            ],
            if (showDialCode) ...[
              Text(
                countryDialCode,
                style: textStyle.copyWith(
                  color: enabled ? null : Theme.of(context).disabledColor,
                ),
                textDirection: textDirection,
              ),
            ],
            const ExcludeSemantics(child: Icon(Icons.arrow_drop_down)),
          ],
        ),
      ),
    );
  }
}
