Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466BEC04AAD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 13:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E370B2054F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 13:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lygkjVgB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbfEFNUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 09:20:54 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42223 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfEFNUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 09:20:54 -0400
Received: by mail-pg1-f196.google.com with SMTP id p6so6448067pgh.9;
        Mon, 06 May 2019 06:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=wSgdQKxbVEf/9RlWTstQXMqlPYT/VG8xhqWwz60qSxA=;
        b=lygkjVgBeXN8/Buh0KADQvnrzmgiAnswhout6Xi3bQvsNCNIMF0LEqKFEDiTGjfzAO
         8p9bYlJd3ew1CY06W971PHUXXSroEqrklLx94DAZFw1LN+h7/EUdgNJMaai32mz+vfzG
         hwCozrF0g9THeJSVHefBIpUQQm8OfK/IOdT4P5NkbJ0MWrVERKAEuscY/bJD+FDIa2K/
         7W7Dxy70Ih29oVrVG5H7t8OhZdxKNICdCejatHDh1rHQ679bH6xInI09te+6UfsTDXoB
         SPTFCy6a9wo5qQHUmYNZ1AK3all1G/4mzuQ3dyvo+i66zBtI8kNrefjJCaG1Lwiya2oE
         sFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=wSgdQKxbVEf/9RlWTstQXMqlPYT/VG8xhqWwz60qSxA=;
        b=p/xMKi3TuvdxEePeQC+Gd3s7E1tYzlsnb6y53lndG2yFBYT4X21hpmNlYiZpkAL0C/
         CMb/5sV8eFXxW8UFbZqWqXMDpuN8TdsrcAwhRJ3tglRipI6L3+fLqtS2EYrevwwqih1f
         ySx9cWvbaLzp+M0lwIb4ptei35SSzRuoZUrPmw+rPLiuHpAiVHdwBtSGFeF/ysnK0TpP
         lxjh+fr5EdraCUmL6OwGNTZSb5lR5u/LVqn2nPUMsWCjzhKtMV9LIsc6ps2XZ2KGGkEe
         CJlt1m/djK3mtPUT89wQ8foUwrUIqDrk81FAR+LlUnqrEl4ueckhQUBDpJzmBrK8Li1d
         s3yQ==
X-Gm-Message-State: APjAAAUWJKlbdKTHGRBdWQzXgNW9CD6sGwV+dbS1/SD0yXVbMDiZkzbK
        AU+nUS17GiOceePHtTjLUv1Jhxbc
X-Google-Smtp-Source: APXvYqx4b3YSlq0ttdHTShBK0H6EMvB7iPxrUfZP7nZLJsx4djwAR1Fr8jpxd8ohvlAeHdNGPBewvg==
X-Received: by 2002:a65:56c5:: with SMTP id w5mr13915801pgs.434.1557148852066;
        Mon, 06 May 2019 06:20:52 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a129sm13302296pfa.152.2019.05.06.06.20.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 06:20:49 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon updates for hwmon-for-v5.2
Date:   Mon,  6 May 2019 06:20:47 -0700
Message-Id: <1557148847-18835-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon updates for Linux hwmon-for-v5.2 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.2

Thanks,
Guenter
------

The following changes since commit 15ade5d2e7775667cf191cf2f94327a4889f8b9d:

  Linux 5.1-rc4 (2019-04-07 14:09:59 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.2

for you to fetch changes up to 39abe9d88b30a51029b0b29a708a4f4459034565:

  hwmon: (lm75) Add support for TMP75B (2019-05-03 13:16:18 -0700)

----------------------------------------------------------------
hwmon updates for v5.2

- Add driver for Intersil ISL68137 PWM Controller
- Add driver for Lochnagar 2
- Add driver for Infineon IR38064 Voltage Regulator
- Add support for TMP75B to lm75 driver
- Convert documentation to ReST format
- Use request_muxed_region for Super-IO accesses in several drivers
- Add 'samples' attribute to ABI, and start using it
- Add support for custom sysfs attributes to pmbus drivers
  (used in ISL68137 driver)
- Introduce HWMON_CHANNEL_INFO macro
- Automated changes:
 - Use permission specific [SENSOR_][DEVICE_]ATTR variants
 - Fix build warnings due to unused of_device_id structures
 - Use HWMON_CHANNEL_INFO macro
- Various minor improvements and fixes

----------------------------------------------------------------
Adamski, Krzysztof (Nokia - PL/Wroclaw) (3):
      hwmon: (pmbus) Introduce PMBUS_VIRT_*_SAMPLES registers
      hwmon: Document the samples attributes
      hwmon: (lm25066) Support SAMPLES_FOR_AVG register

Andrey Smirnov (1):
      hwmon: (iio_hwmon) Simplify attr.name generation in iio_hwmon_probe()

Charles Keepax (2):
      hwmon: Add convience macro to define simple static sensors
      hwmon: lochnagar: Add device tree binding document

Eddie James (3):
      hwmon: (occ) Store error condition for rate-limited polls
      hwmon: (occ) Prevent sysfs error attribute from returning error
      hwmon: (occ) Add more details to Kconfig help text

Guenter Roeck (71):
      hwmon: (ntc_thermistor) Use new HWMON_CHANNEL_INFO() macro
      hwmon: (nct7904) Use new HWMON_CHANNEL_INFO() macro
      hwmon: Documentation: Add usage example for HWMON_CHANNEL_INFO
      hwmon: (adt7411) Use HWMON_CHANNEL_INFO macro
      hwmon: (ina3221) Use HWMON_CHANNEL_INFO macro
      hwmon: (jc42) Use HWMON_CHANNEL_INFO macro
      hwmon: (lm75) Use HWMON_CHANNEL_INFO macro
      hwmon: (lm90) Use HWMON_CHANNEL_INFO macro
      hwmon: (lm95241) Use HWMON_CHANNEL_INFO macro
      hwmon: (lm95245) Use HWMON_CHANNEL_INFO macro
      hwmon: (ltc4245) Use HWMON_CHANNEL_INFO macro
      hwmon: (ltq-cputemp) Use HWMON_CHANNEL_INFO macro
      hwmon: (max31790) Use HWMON_CHANNEL_INFO macro
      hwmon: (max6621) Use HWMON_CHANNEL_INFO macro
      hwmon: (mlxreg-fan) Use HWMON_CHANNEL_INFO macro
      hwmon: (npcm750-pwm-fan) Use HWMON_CHANNEL_INFO macro
      hwmon: (raspberrypi-hwmon) Use HWMON_CHANNEL_INFO macro
      hwmon: (tmp102) Use HWMON_CHANNEL_INFO macro
      hwmon: (tmp108) Use HWMON_CHANNEL_INFO macro
      hwmon: (w83773g) Use HWMON_CHANNEL_INFO macro
      hwmon: (jz4740) Use devm_platform_ioremap_resource
      hwmon: (pmbus/ucd9200): Mark ucd9200_of_match as maybe_unused
      hwmon: (pmbus/tps53679) Fix build warning
      hwmon: (pmbus/ucd900) Fix build warning
      hwmon: (ltc4151) Fix build warning
      hwmon: (lm90) Fix build warning
      hwmon: (adc128d818) Fix build warning
      hwmon: (ad7414) Fix build warning
      hwmon: (tmp102) Fix build warning
      hwmon: (tmp103) Fix build warning
      hwmon: (ads1015) Fix build warning
      hwmon: (adt7475) Fix build warning
      hwmon: (hih6130) Fix build warning
      hwmon: (ads7828) Fix build warning
      hwmon: (w83773g) Fix build warning
      hwmon: (lm75) Fix build warning
      hwmon: (ina209) Fix build warning
      hwmon: (max6697) Fix build warning
      hwmon: (max6650) Fix build warning
      hwmon: (lm85) Fix build warning
      hwmon: (max6621) Fix build warning
      hwmon: (stts751) Fix build warning
      hwmon: (tmp421) Fix build warning
      hwmon: lm95245: Fix build warnings
      hwmon: (lm63) Fix build warning
      hwmon: (ina2xx) Fix build warning
      hwmon: (f71805f) Use request_muxed_region for Super-IO accesses
      hwmon: (pc87427) Use request_muxed_region for Super-IO accesses
      hwmon: (smsc47b397) Use request_muxed_region for Super-IO accesses
      hwmon: (adm1025) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (adm1026) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (adm9240) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (thmc50) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (adm1031) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (lm87) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (lm78) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (lm85) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (via686a) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (menf21bmc_hwmon) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (sis5595) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (vt8231) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (smsc47m192) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (smsc47m1) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (w83627hf) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (adm1029) Use permission specific [SENSOR_][DEVICE_]ATTR variants
      hwmon: (smsc47m1) Use request_muxed_region for Super-IO accesses
      hwmon: (w83627hf) Use request_muxed_region for Super-IO accesses
      hwmon: (vt1211) Use request_muxed_region for Super-IO accesses
      hwmon: (pmbus_core) Replace S_<PERMS> with octal values
      hwmon: Add support for samples attributes
      hwmon: (max6650) Drop call to thermal_cdev_update

Iker Perez del Palomar Sustatxa (2):
      dt-bindings: hwmon: Add tmp75b to lm75.txt
      hwmon: (lm75) Add support for TMP75B

Jean Delvare (2):
      hwmon: (occ) Move common code to a separate module
      hwmon: OCC drivers are ARM-only

Jean-Francois Dagenais (1):
      hwmon: (max6650) add thermal cooling device capability

Kefeng Wang (1):
      hwmon: (s3c) Use dev_get_drvdata()

Lei YU (1):
      hwmon: (occ) Fix extended status bits

Lucas Tanure (1):
      hwmon: lochnagar: Add Lochnagar 2 hardware monitoring driver

Mauro Carvalho Chehab (23):
      docs: hwmon: k10temp: convert to ReST format
      docs: hwmon: vexpress: convert to ReST format
      docs: hwmon: menf21bmc: convert to ReST format
      docs: hwmon: sch5627: convert to ReST format
      docs: hwmon: emc2103: convert to ReST format
      docs: hwmon: pc87360: convert to ReST format
      docs: hwmon: fam15h_power: convert to ReST format
      docs: hwmon: w83791d: convert to ReST format
      docs: hwmon: coretemp: convert to ReST format
      docs: hwmon: aspeed-pwm-tacho: convert to ReST format
      docs: hwmon: ibmpowernv: convert to ReST format
      docs: hwmon: asc7621: convert to ReST format
      docs: hwmon: ads1015: convert to ReST format
      docs: hwmon: dme1737, vt1211: convert to ReST format
      docs: hwmon: wm831x, wm8350: convert to ReST format
      docs: hwmon: da9052, da9055: convert to ReST format
      docs: hwmon: k8temp, w83793: convert to ReST format
      docs: hwmon: pmbus files: convert to ReST format
      docs: hwmon: misc files: convert to ReST format
      docs: hwmon: convert remaining files to ReST format
      docs: hwmon: Add an index file and rename docs to *.rst
      docs: hwmon: convert three docs to ReST format
      docs: hwmon: remove the extension from .rst files

Maxim Sloyko (2):
      hwmon: (pmbus/ir38064) Add driver for Infineon IR38064 Voltage Regulator
      hwmon: (pmbus/isl68137) Add driver for Intersil ISL68137 PWM Controller

Nicolin Chen (3):
      hwmon: (ina3221) Add averaging mode support
      hwmon: (ina3221) Do not read-back to cache reg_config
      hwmon: (ina3221) Add voltage conversion time settings

Patrick Venture (2):
      hwmon: (ir35221) fix company name
      hwmon: (ir38064) delete incorrect line

Robin Murphy (1):
      hwmon: (pwm-fan) Report probe errors consistently

Stefan Wahren (4):
      hwmon: (pwm-fan) Disable PWM if fetching cooling data fails
      dt-bindings: hwmon: (pwm-fan) Add tachometer interrupt
      Documentation: pwm-fan: Add description for RPM support
      hwmon: (pwm-fan) Add RPM support via external interrupt

Vadim Pasternak (1):
      hwmon: (mlxreg-fan) Add support for fan capability registers

krzysztof.adamski@nokia.com (1):
      pmbus: support for custom sysfs attributes

 .../devicetree/bindings/hwmon/cirrus,lochnagar.txt |  26 +
 Documentation/devicetree/bindings/hwmon/g762.txt   |   2 +-
 Documentation/devicetree/bindings/hwmon/lm75.txt   |   1 +
 .../devicetree/bindings/hwmon/pwm-fan.txt          |  21 +-
 Documentation/hwmon/{ab8500 => ab8500.rst}         |  10 +-
 Documentation/hwmon/abituguru                      |  92 ---
 ...abituguru-datasheet => abituguru-datasheet.rst} | 160 +++--
 Documentation/hwmon/abituguru.rst                  | 113 ++++
 Documentation/hwmon/{abituguru3 => abituguru3.rst} |  36 +-
 Documentation/hwmon/{abx500 => abx500.rst}         |   8 +-
 .../{acpi_power_meter => acpi_power_meter.rst}     |  25 +-
 Documentation/hwmon/{ad7314 => ad7314.rst}         |   9 +
 Documentation/hwmon/{adc128d818 => adc128d818.rst} |   7 +-
 Documentation/hwmon/{adm1021 => adm1021.rst}       |  44 +-
 Documentation/hwmon/{adm1025 => adm1025.rst}       |  13 +-
 Documentation/hwmon/{adm1026 => adm1026.rst}       |  24 +-
 Documentation/hwmon/{adm1031 => adm1031.rst}       |  16 +-
 Documentation/hwmon/{adm1275 => adm1275.rst}       |  30 +-
 Documentation/hwmon/{adm9240 => adm9240.rst}       |  50 +-
 Documentation/hwmon/{ads1015 => ads1015.rst}       |  74 ++-
 Documentation/hwmon/{ads7828 => ads7828.rst}       |  29 +-
 Documentation/hwmon/{adt7410 => adt7410.rst}       |  49 +-
 Documentation/hwmon/{adt7411 => adt7411.rst}       |  20 +-
 Documentation/hwmon/{adt7462 => adt7462.rst}       |  11 +-
 Documentation/hwmon/{adt7470 => adt7470.rst}       |   8 +-
 Documentation/hwmon/{adt7475 => adt7475.rst}       |  38 +-
 Documentation/hwmon/{amc6821 => amc6821.rst}       |  18 +-
 Documentation/hwmon/{asb100 => asb100.rst}         |  55 +-
 Documentation/hwmon/{asc7621 => asc7621.rst}       | 146 +++--
 .../{aspeed-pwm-tacho => aspeed-pwm-tacho.rst}     |   2 +
 Documentation/hwmon/{coretemp => coretemp.rst}     |  46 +-
 Documentation/hwmon/{da9052 => da9052.rst}         |  41 +-
 Documentation/hwmon/{da9055 => da9055.rst}         |  20 +-
 Documentation/hwmon/{dme1737 => dme1737.rst}       |  88 ++-
 Documentation/hwmon/{ds1621 => ds1621.rst}         | 156 +++--
 Documentation/hwmon/{ds620 => ds620.rst}           |  12 +-
 Documentation/hwmon/{emc1403 => emc1403.rst}       |  33 +-
 Documentation/hwmon/{emc2103 => emc2103.rst}       |   6 +-
 Documentation/hwmon/{emc6w201 => emc6w201.rst}     |   5 +
 Documentation/hwmon/{f71805f => f71805f.rst}       |  36 +-
 Documentation/hwmon/{f71882fg => f71882fg.rst}     |  56 +-
 .../hwmon/{fam15h_power => fam15h_power.rst}       |  85 ++-
 .../hwmon/{ftsteutates => ftsteutates.rst}         |  14 +-
 Documentation/hwmon/{g760a => g760a.rst}           |   4 +
 Documentation/hwmon/{g762 => g762.rst}             |  51 +-
 Documentation/hwmon/{gl518sm => gl518sm.rst}       |  21 +-
 Documentation/hwmon/{hih6130 => hih6130.rst}       |  14 +-
 .../{hwmon-kernel-api.txt => hwmon-kernel-api.rst} | 337 +++++-----
 Documentation/hwmon/{ibm-cffps => ibm-cffps.rst}   |   3 +
 Documentation/hwmon/{ibmaem => ibmaem.rst}         |  10 +-
 Documentation/hwmon/{ibmpowernv => ibmpowernv.rst} |  31 +-
 Documentation/hwmon/{ina209 => ina209.rst}         |  18 +-
 Documentation/hwmon/{ina2xx => ina2xx.rst}         |  41 +-
 Documentation/hwmon/{ina3221 => ina3221.rst}       |  35 +-
 Documentation/hwmon/index.rst                      | 182 ++++++
 Documentation/hwmon/{ir35221 => ir35221.rst}       |  13 +-
 Documentation/hwmon/ir38064.rst                    |  66 ++
 Documentation/hwmon/isl68137.rst                   |  80 +++
 Documentation/hwmon/{it87 => it87.rst}             | 102 ++-
 Documentation/hwmon/{jc42 => jc42.rst}             |  55 +-
 Documentation/hwmon/{k10temp => k10temp.rst}       |  37 +-
 Documentation/hwmon/{k8temp => k8temp.rst}         |  17 +-
 .../hwmon/{lineage-pem => lineage-pem.rst}         |  16 +-
 Documentation/hwmon/{lm25066 => lm25066.rst}       |  32 +-
 Documentation/hwmon/{lm63 => lm63.rst}             |  24 +-
 Documentation/hwmon/{lm70 => lm70.rst}             |  13 +-
 Documentation/hwmon/{lm73 => lm73.rst}             |  16 +-
 Documentation/hwmon/{lm75 => lm75.rst}             | 102 ++-
 Documentation/hwmon/{lm77 => lm77.rst}             |   9 +-
 Documentation/hwmon/{lm78 => lm78.rst}             |  20 +-
 Documentation/hwmon/{lm80 => lm80.rst}             |  19 +-
 Documentation/hwmon/{lm83 => lm83.rst}             |  16 +-
 Documentation/hwmon/{lm85 => lm85.rst}             |  97 ++-
 Documentation/hwmon/{lm87 => lm87.rst}             |  23 +-
 Documentation/hwmon/{lm90 => lm90.rst}             | 174 ++++-
 Documentation/hwmon/{lm92 => lm92.rst}             |  17 +-
 Documentation/hwmon/{lm93 => lm93.rst}             | 157 ++---
 Documentation/hwmon/{lm95234 => lm95234.rst}       |  11 +-
 Documentation/hwmon/{lm95245 => lm95245.rst}       |  13 +-
 Documentation/hwmon/lochnagar.rst                  |  83 +++
 Documentation/hwmon/{ltc2945 => ltc2945.rst}       |  16 +-
 Documentation/hwmon/{ltc2978 => ltc2978.rst}       | 267 ++++++--
 Documentation/hwmon/{ltc2990 => ltc2990.rst}       |  23 +-
 Documentation/hwmon/{ltc3815 => ltc3815.rst}       |  12 +-
 Documentation/hwmon/{ltc4151 => ltc4151.rst}       |  16 +-
 Documentation/hwmon/{ltc4215 => ltc4215.rst}       |  16 +-
 Documentation/hwmon/{ltc4245 => ltc4245.rst}       |  17 +-
 Documentation/hwmon/{ltc4260 => ltc4260.rst}       |  16 +-
 Documentation/hwmon/{ltc4261 => ltc4261.rst}       |  16 +-
 Documentation/hwmon/{max16064 => max16064.rst}     |  17 +-
 Documentation/hwmon/{max16065 => max16065.rst}     |  24 +-
 Documentation/hwmon/{max1619 => max1619.rst}       |  12 +-
 Documentation/hwmon/{max1668 => max1668.rst}       |  14 +-
 Documentation/hwmon/{max197 => max197.rst}         |  36 +-
 Documentation/hwmon/{max20751 => max20751.rst}     |   9 +-
 Documentation/hwmon/{max31722 => max31722.rst}     |  12 +
 Documentation/hwmon/{max31785 => max31785.rst}     |   6 +
 Documentation/hwmon/{max31790 => max31790.rst}     |   6 +
 Documentation/hwmon/{max34440 => max34440.rst}     |  90 ++-
 Documentation/hwmon/{max6639 => max6639.rst}       |  16 +-
 Documentation/hwmon/{max6642 => max6642.rst}       |  10 +-
 Documentation/hwmon/{max6650 => max6650.rst}       |  17 +-
 Documentation/hwmon/{max6697 => max6697.rst}       |  33 +
 Documentation/hwmon/{max8688 => max8688.rst}       |  20 +-
 .../hwmon/{mc13783-adc => mc13783-adc.rst}         |  27 +-
 Documentation/hwmon/{mcp3021 => mcp3021.rst}       |  15 +-
 Documentation/hwmon/{menf21bmc => menf21bmc.rst}   |   5 +
 Documentation/hwmon/{mlxreg-fan => mlxreg-fan.rst} |  60 +-
 Documentation/hwmon/{nct6683 => nct6683.rst}       |  11 +-
 Documentation/hwmon/{nct6775 => nct6775.rst}       | 114 +++-
 Documentation/hwmon/{nct7802 => nct7802.rst}       |  11 +-
 Documentation/hwmon/{nct7904 => nct7904.rst}       |   9 +-
 .../hwmon/{npcm750-pwm-fan => npcm750-pwm-fan.rst} |   4 +
 Documentation/hwmon/{nsa320 => nsa320.rst}         |  15 +-
 .../hwmon/{ntc_thermistor => ntc_thermistor.rst}   | 123 ++--
 Documentation/hwmon/{occ => occ.rst}               |  93 ++-
 Documentation/hwmon/{pc87360 => pc87360.rst}       |  38 +-
 Documentation/hwmon/{pc87427 => pc87427.rst}       |   4 +
 Documentation/hwmon/{pcf8591 => pcf8591.rst}       |  52 +-
 Documentation/hwmon/{pmbus-core => pmbus-core.rst} | 173 +++--
 Documentation/hwmon/{pmbus => pmbus.rst}           |  90 ++-
 Documentation/hwmon/{powr1220 => powr1220.rst}     |  12 +-
 Documentation/hwmon/{pwm-fan => pwm-fan.rst}       |   3 +
 .../{raspberrypi-hwmon => raspberrypi-hwmon.rst}   |   3 +
 Documentation/hwmon/{sch5627 => sch5627.rst}       |   4 +
 Documentation/hwmon/{sch5636 => sch5636.rst}       |   3 +
 Documentation/hwmon/{scpi-hwmon => scpi-hwmon.rst} |   7 +-
 Documentation/hwmon/{sht15 => sht15.rst}           |  28 +-
 Documentation/hwmon/{sht21 => sht21.rst}           |  24 +-
 Documentation/hwmon/{sht3x => sht3x.rst}           |  42 +-
 Documentation/hwmon/{shtc1 => shtc1.rst}           |  19 +-
 Documentation/hwmon/{sis5595 => sis5595.rst}       |  41 +-
 Documentation/hwmon/{smm665 => smm665.rst}         |  42 +-
 Documentation/hwmon/{smsc47b397 => smsc47b397.rst} | 162 +++--
 Documentation/hwmon/{smsc47m1 => smsc47m1.rst}     |  43 +-
 Documentation/hwmon/smsc47m192                     | 103 ---
 Documentation/hwmon/smsc47m192.rst                 | 116 ++++
 .../{submitting-patches => submitting-patches.rst} |  21 +-
 .../hwmon/{sysfs-interface => sysfs-interface.rst} | 721 ++++++++++++++-------
 Documentation/hwmon/{tc654 => tc654.rst}           |   9 +-
 Documentation/hwmon/{tc74 => tc74.rst}             |   3 +
 Documentation/hwmon/{thmc50 => thmc50.rst}         |  37 +-
 Documentation/hwmon/{tmp102 => tmp102.rst}         |   7 +-
 Documentation/hwmon/{tmp103 => tmp103.rst}         |   7 +-
 Documentation/hwmon/{tmp108 => tmp108.rst}         |   7 +-
 Documentation/hwmon/{tmp401 => tmp401.rst}         |  32 +-
 Documentation/hwmon/{tmp421 => tmp421.rst}         |  26 +-
 Documentation/hwmon/{tps40422 => tps40422.rst}     |  25 +-
 .../{twl4030-madc-hwmon => twl4030-madc-hwmon.rst} |   8 +-
 Documentation/hwmon/{ucd9000 => ucd9000.rst}       |  35 +-
 Documentation/hwmon/{ucd9200 => ucd9200.rst}       |  46 +-
 .../hwmon/{userspace-tools => userspace-tools.rst} |   3 +
 Documentation/hwmon/{vexpress => vexpress.rst}     |  13 +-
 Documentation/hwmon/{via686a => via686a.rst}       |  30 +-
 Documentation/hwmon/{vt1211 => vt1211.rst}         |  84 ++-
 Documentation/hwmon/{w83627ehf => w83627ehf.rst}   | 162 +++--
 Documentation/hwmon/{w83627hf => w83627hf.rst}     |  65 +-
 Documentation/hwmon/{w83773g => w83773g.rst}       |  12 +-
 Documentation/hwmon/{w83781d => w83781d.rst}       | 330 ++++++----
 Documentation/hwmon/{w83791d => w83791d.rst}       | 123 ++--
 Documentation/hwmon/{w83792d => w83792d.rst}       | 112 ++--
 Documentation/hwmon/w83793                         | 106 ---
 Documentation/hwmon/w83793.rst                     | 113 ++++
 Documentation/hwmon/w83795                         | 127 ----
 Documentation/hwmon/w83795.rst                     | 142 ++++
 Documentation/hwmon/{w83l785ts => w83l785ts.rst}   |   9 +-
 Documentation/hwmon/{w83l786ng => w83l786ng.rst}   |  42 +-
 Documentation/hwmon/{wm831x => wm831x.rst}         |   9 +-
 Documentation/hwmon/{wm8350 => wm8350.rst}         |  10 +-
 .../hwmon/{xgene-hwmon => xgene-hwmon.rst}         |  24 +-
 Documentation/hwmon/{zl6100 => zl6100.rst}         |  71 +-
 Documentation/index.rst                            |   1 +
 Documentation/thermal/sysfs-api.txt                |   2 +-
 MAINTAINERS                                        | 111 ++--
 drivers/hwmon/Kconfig                              |  19 +-
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/ad7414.c                             |   2 +-
 drivers/hwmon/adc128d818.c                         |   2 +-
 drivers/hwmon/adm1025.c                            |  98 +--
 drivers/hwmon/adm1026.c                            | 416 ++++++------
 drivers/hwmon/adm1029.c                            |  41 +-
 drivers/hwmon/adm1031.c                            | 201 +++---
 drivers/hwmon/adm9240.c                            | 135 ++--
 drivers/hwmon/ads1015.c                            |   2 +-
 drivers/hwmon/ads7828.c                            |   4 +-
 drivers/hwmon/adt7411.c                            |  48 +-
 drivers/hwmon/adt7475.c                            |   2 +-
 drivers/hwmon/f71805f.c                            |  15 +-
 drivers/hwmon/hih6130.c                            |   2 +-
 drivers/hwmon/hwmon.c                              |   5 +
 drivers/hwmon/iio_hwmon.c                          |  27 +-
 drivers/hwmon/ina209.c                             |   2 +-
 drivers/hwmon/ina2xx.c                             |   2 +-
 drivers/hwmon/ina3221.c                            | 176 +++--
 drivers/hwmon/jc42.c                               |  18 +-
 drivers/hwmon/jz4740-hwmon.c                       |   4 +-
 drivers/hwmon/lm63.c                               |   2 +-
 drivers/hwmon/lm75.c                               |  45 +-
 drivers/hwmon/lm78.c                               | 114 ++--
 drivers/hwmon/lm85.c                               | 342 +++++-----
 drivers/hwmon/lm87.c                               | 165 ++---
 drivers/hwmon/lm90.c                               |  15 +-
 drivers/hwmon/lm95241.c                            |  34 +-
 drivers/hwmon/lm95245.c                            |  49 +-
 drivers/hwmon/lochnagar-hwmon.c                    | 412 ++++++++++++
 drivers/hwmon/ltc4151.c                            |   2 +-
 drivers/hwmon/ltc4245.c                            |  73 +--
 drivers/hwmon/ltq-cputemp.c                        |  26 +-
 drivers/hwmon/max197.c                             |   2 +-
 drivers/hwmon/max31790.c                           |  58 +-
 drivers/hwmon/max6621.c                            |  44 +-
 drivers/hwmon/max6650.c                            |  90 ++-
 drivers/hwmon/max6697.c                            |   2 +-
 drivers/hwmon/menf21bmc_hwmon.c                    |  43 +-
 drivers/hwmon/mlxreg-fan.c                         | 121 ++--
 drivers/hwmon/nct7904.c                            | 128 ++--
 drivers/hwmon/npcm750-pwm-fan.c                    |  70 +-
 drivers/hwmon/ntc_thermistor.c                     |  24 +-
 drivers/hwmon/occ/Kconfig                          |  17 +-
 drivers/hwmon/occ/Makefile                         |   6 +-
 drivers/hwmon/occ/common.c                         |  11 +
 drivers/hwmon/occ/common.h                         |   3 +-
 drivers/hwmon/occ/sysfs.c                          |  29 +-
 drivers/hwmon/pc87427.c                            |  14 +-
 drivers/hwmon/pmbus/Kconfig                        |  18 +
 drivers/hwmon/pmbus/Makefile                       |   2 +
 drivers/hwmon/pmbus/ir38064.c                      |  65 ++
 drivers/hwmon/pmbus/isl68137.c                     | 169 +++++
 drivers/hwmon/pmbus/lm25066.c                      |  17 +-
 drivers/hwmon/pmbus/pmbus.h                        |  18 +
 drivers/hwmon/pmbus/pmbus_core.c                   | 129 +++-
 drivers/hwmon/pmbus/tps53679.c                     |   2 +-
 drivers/hwmon/pmbus/ucd9000.c                      |   2 +-
 drivers/hwmon/pmbus/ucd9200.c                      |   2 +-
 drivers/hwmon/pwm-fan.c                            | 116 +++-
 drivers/hwmon/raspberrypi-hwmon.c                  |  13 +-
 drivers/hwmon/s3c-hwmon.c                          |   4 +-
 drivers/hwmon/sht15.c                              |   2 +-
 drivers/hwmon/sis5595.c                            |  92 ++-
 drivers/hwmon/smsc47b397.c                         |  13 +-
 drivers/hwmon/smsc47m1.c                           | 106 +--
 drivers/hwmon/smsc47m192.c                         | 146 +++--
 drivers/hwmon/stts751.c                            |   2 +-
 drivers/hwmon/thmc50.c                             |  83 ++-
 drivers/hwmon/tmp102.c                             |  28 +-
 drivers/hwmon/tmp103.c                             |   2 +-
 drivers/hwmon/tmp108.c                             |  29 +-
 drivers/hwmon/tmp421.c                             |   2 +-
 drivers/hwmon/via686a.c                            | 148 +++--
 drivers/hwmon/vt1211.c                             |  15 +-
 drivers/hwmon/vt8231.c                             | 166 ++---
 drivers/hwmon/w83627hf.c                           | 299 ++++-----
 drivers/hwmon/w83773g.c                            |  32 +-
 include/linux/hwmon.h                              |  18 +
 include/linux/platform_data/ads7828.h              |   2 +-
 include/linux/platform_data/ds620.h                |   2 +-
 include/linux/platform_data/ina2xx.h               |   2 +-
 include/linux/platform_data/max197.h               |   2 +-
 include/linux/platform_data/ntc_thermistor.h       |   2 +-
 259 files changed, 8914 insertions(+), 4595 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/cirrus,lochnagar.txt
 rename Documentation/hwmon/{ab8500 => ab8500.rst} (69%)
 delete mode 100644 Documentation/hwmon/abituguru
 rename Documentation/hwmon/{abituguru-datasheet => abituguru-datasheet.rst} (69%)
 create mode 100644 Documentation/hwmon/abituguru.rst
 rename Documentation/hwmon/{abituguru3 => abituguru3.rst} (75%)
 rename Documentation/hwmon/{abx500 => abx500.rst} (89%)
 rename Documentation/hwmon/{acpi_power_meter => acpi_power_meter.rst} (65%)
 rename Documentation/hwmon/{ad7314 => ad7314.rst} (98%)
 rename Documentation/hwmon/{adc128d818 => adc128d818.rst} (95%)
 rename Documentation/hwmon/{adm1021 => adm1021.rst} (97%)
 rename Documentation/hwmon/{adm1025 => adm1025.rst} (96%)
 rename Documentation/hwmon/{adm1026 => adm1026.rst} (89%)
 rename Documentation/hwmon/{adm1031 => adm1031.rst} (80%)
 rename Documentation/hwmon/{adm1275 => adm1275.rst} (93%)
 rename Documentation/hwmon/{adm9240 => adm9240.rst} (85%)
 rename Documentation/hwmon/{ads1015 => ads1015.rst} (64%)
 rename Documentation/hwmon/{ads7828 => ads7828.rst} (68%)
 rename Documentation/hwmon/{adt7410 => adt7410.rst} (70%)
 rename Documentation/hwmon/{adt7411 => adt7411.rst} (67%)
 rename Documentation/hwmon/{adt7462 => adt7462.rst} (94%)
 rename Documentation/hwmon/{adt7470 => adt7470.rst} (95%)
 rename Documentation/hwmon/{adt7475 => adt7475.rst} (89%)
 rename Documentation/hwmon/{amc6821 => amc6821.rst} (90%)
 rename Documentation/hwmon/{asb100 => asb100.rst} (69%)
 rename Documentation/hwmon/{asc7621 => asc7621.rst} (80%)
 rename Documentation/hwmon/{aspeed-pwm-tacho => aspeed-pwm-tacho.rst} (79%)
 rename Documentation/hwmon/{coretemp => coretemp.rst} (78%)
 rename Documentation/hwmon/{da9052 => da9052.rst} (66%)
 rename Documentation/hwmon/{da9055 => da9055.rst} (80%)
 rename Documentation/hwmon/{dme1737 => dme1737.rst} (89%)
 rename Documentation/hwmon/{ds1621 => ds1621.rst} (68%)
 rename Documentation/hwmon/{ds620 => ds620.rst} (88%)
 rename Documentation/hwmon/{emc1403 => emc1403.rst} (83%)
 rename Documentation/hwmon/{emc2103 => emc2103.rst} (95%)
 rename Documentation/hwmon/{emc6w201 => emc6w201.rst} (99%)
 rename Documentation/hwmon/{f71805f => f71805f.rst} (88%)
 rename Documentation/hwmon/{f71882fg => f71882fg.rst} (97%)
 rename Documentation/hwmon/{fam15h_power => fam15h_power.rst} (63%)
 rename Documentation/hwmon/{ftsteutates => ftsteutates.rst} (65%)
 rename Documentation/hwmon/{g760a => g760a.rst} (99%)
 rename Documentation/hwmon/{g762 => g762.rst} (59%)
 rename Documentation/hwmon/{gl518sm => gl518sm.rst} (89%)
 rename Documentation/hwmon/{hih6130 => hih6130.rst} (85%)
 rename Documentation/hwmon/{hwmon-kernel-api.txt => hwmon-kernel-api.rst} (58%)
 rename Documentation/hwmon/{ibm-cffps => ibm-cffps.rst} (90%)
 rename Documentation/hwmon/{ibmaem => ibmaem.rst} (92%)
 rename Documentation/hwmon/{ibmpowernv => ibmpowernv.rst} (86%)
 rename Documentation/hwmon/{ina209 => ina209.rst} (90%)
 rename Documentation/hwmon/{ina2xx => ina2xx.rst} (81%)
 rename Documentation/hwmon/{ina3221 => ina3221.rst} (50%)
 create mode 100644 Documentation/hwmon/index.rst
 rename Documentation/hwmon/{ir35221 => ir35221.rst} (88%)
 create mode 100644 Documentation/hwmon/ir38064.rst
 create mode 100644 Documentation/hwmon/isl68137.rst
 rename Documentation/hwmon/{it87 => it87.rst} (92%)
 rename Documentation/hwmon/{jc42 => jc42.rst} (92%)
 rename Documentation/hwmon/{k10temp => k10temp.rst} (98%)
 rename Documentation/hwmon/{k8temp => k8temp.rst} (83%)
 rename Documentation/hwmon/{lineage-pem => lineage-pem.rst} (88%)
 rename Documentation/hwmon/{lm25066 => lm25066.rst} (91%)
 rename Documentation/hwmon/{lm63 => lm63.rst} (95%)
 rename Documentation/hwmon/{lm70 => lm70.rst} (96%)
 rename Documentation/hwmon/{lm73 => lm73.rst} (92%)
 rename Documentation/hwmon/{lm75 => lm75.rst} (79%)
 rename Documentation/hwmon/{lm77 => lm77.rst} (97%)
 rename Documentation/hwmon/{lm78 => lm78.rst} (95%)
 rename Documentation/hwmon/{lm80 => lm80.rst} (94%)
 rename Documentation/hwmon/{lm83 => lm83.rst} (95%)
 rename Documentation/hwmon/{lm85 => lm85.rst} (86%)
 rename Documentation/hwmon/{lm87 => lm87.rst} (89%)
 rename Documentation/hwmon/{lm90 => lm90.rst} (85%)
 rename Documentation/hwmon/{lm92 => lm92.rst} (90%)
 rename Documentation/hwmon/{lm93 => lm93.rst} (80%)
 rename Documentation/hwmon/{lm95234 => lm95234.rst} (94%)
 rename Documentation/hwmon/{lm95245 => lm95245.rst} (91%)
 create mode 100644 Documentation/hwmon/lochnagar.rst
 rename Documentation/hwmon/{ltc2945 => ltc2945.rst} (89%)
 rename Documentation/hwmon/{ltc2978 => ltc2978.rst} (58%)
 rename Documentation/hwmon/{ltc2990 => ltc2990.rst} (76%)
 rename Documentation/hwmon/{ltc3815 => ltc3815.rst} (83%)
 rename Documentation/hwmon/{ltc4151 => ltc4151.rst} (80%)
 rename Documentation/hwmon/{ltc4215 => ltc4215.rst} (78%)
 rename Documentation/hwmon/{ltc4245 => ltc4245.rst} (89%)
 rename Documentation/hwmon/{ltc4260 => ltc4260.rst} (85%)
 rename Documentation/hwmon/{ltc4261 => ltc4261.rst} (88%)
 rename Documentation/hwmon/{max16064 => max16064.rst} (88%)
 rename Documentation/hwmon/{max16065 => max16065.rst} (95%)
 rename Documentation/hwmon/{max1619 => max1619.rst} (82%)
 rename Documentation/hwmon/{max1668 => max1668.rst} (85%)
 rename Documentation/hwmon/{max197 => max197.rst} (59%)
 rename Documentation/hwmon/{max20751 => max20751.rst} (89%)
 rename Documentation/hwmon/{max31722 => max31722.rst} (83%)
 rename Documentation/hwmon/{max31785 => max31785.rst} (92%)
 rename Documentation/hwmon/{max31790 => max31790.rst} (88%)
 rename Documentation/hwmon/{max34440 => max34440.rst} (77%)
 rename Documentation/hwmon/{max6639 => max6639.rst} (83%)
 rename Documentation/hwmon/{max6642 => max6642.rst} (82%)
 rename Documentation/hwmon/{max6650 => max6650.rst} (86%)
 rename Documentation/hwmon/{max6697 => max6697.rst} (91%)
 rename Documentation/hwmon/{max8688 => max8688.rst} (85%)
 rename Documentation/hwmon/{mc13783-adc => mc13783-adc.rst} (82%)
 rename Documentation/hwmon/{mcp3021 => mcp3021.rst} (90%)
 rename Documentation/hwmon/{menf21bmc => menf21bmc.rst} (93%)
 rename Documentation/hwmon/{mlxreg-fan => mlxreg-fan.rst} (53%)
 rename Documentation/hwmon/{nct6683 => nct6683.rst} (89%)
 rename Documentation/hwmon/{nct6775 => nct6775.rst} (86%)
 rename Documentation/hwmon/{nct7802 => nct7802.rst} (73%)
 rename Documentation/hwmon/{nct7904 => nct7904.rst} (88%)
 rename Documentation/hwmon/{npcm750-pwm-fan => npcm750-pwm-fan.rst} (79%)
 rename Documentation/hwmon/{nsa320 => nsa320.rst} (93%)
 rename Documentation/hwmon/{ntc_thermistor => ntc_thermistor.rst} (52%)
 rename Documentation/hwmon/{occ => occ.rst} (67%)
 rename Documentation/hwmon/{pc87360 => pc87360.rst} (88%)
 rename Documentation/hwmon/{pc87427 => pc87427.rst} (99%)
 rename Documentation/hwmon/{pcf8591 => pcf8591.rst} (62%)
 rename Documentation/hwmon/{pmbus-core => pmbus-core.rst} (68%)
 rename Documentation/hwmon/{pmbus => pmbus.rst} (88%)
 rename Documentation/hwmon/{powr1220 => powr1220.rst} (90%)
 rename Documentation/hwmon/{pwm-fan => pwm-fan.rst} (79%)
 rename Documentation/hwmon/{raspberrypi-hwmon => raspberrypi-hwmon.rst} (85%)
 rename Documentation/hwmon/{sch5627 => sch5627.rst} (99%)
 rename Documentation/hwmon/{sch5636 => sch5636.rst} (99%)
 rename Documentation/hwmon/{scpi-hwmon => scpi-hwmon.rst} (96%)
 rename Documentation/hwmon/{sht15 => sht15.rst} (74%)
 rename Documentation/hwmon/{sht21 => sht21.rst} (92%)
 rename Documentation/hwmon/{sht3x => sht3x.rst} (75%)
 rename Documentation/hwmon/{shtc1 => shtc1.rst} (94%)
 rename Documentation/hwmon/{sis5595 => sis5595.rst} (80%)
 rename Documentation/hwmon/{smm665 => smm665.rst} (92%)
 rename Documentation/hwmon/{smsc47b397 => smsc47b397.rst} (62%)
 rename Documentation/hwmon/{smsc47m1 => smsc47m1.rst} (77%)
 delete mode 100644 Documentation/hwmon/smsc47m192
 create mode 100644 Documentation/hwmon/smsc47m192.rst
 rename Documentation/hwmon/{submitting-patches => submitting-patches.rst} (93%)
 rename Documentation/hwmon/{sysfs-interface => sysfs-interface.rst} (67%)
 rename Documentation/hwmon/{tc654 => tc654.rst} (81%)
 rename Documentation/hwmon/{tc74 => tc74.rst} (99%)
 rename Documentation/hwmon/{thmc50 => thmc50.rst} (84%)
 rename Documentation/hwmon/{tmp102 => tmp102.rst} (92%)
 rename Documentation/hwmon/{tmp103 => tmp103.rst} (91%)
 rename Documentation/hwmon/{tmp108 => tmp108.rst} (95%)
 rename Documentation/hwmon/{tmp401 => tmp401.rst} (92%)
 rename Documentation/hwmon/{tmp421 => tmp421.rst} (96%)
 rename Documentation/hwmon/{tps40422 => tps40422.rst} (75%)
 rename Documentation/hwmon/{twl4030-madc-hwmon => twl4030-madc-hwmon.rst} (82%)
 rename Documentation/hwmon/{ucd9000 => ucd9000.rst} (87%)
 rename Documentation/hwmon/{ucd9200 => ucd9200.rst} (80%)
 rename Documentation/hwmon/{userspace-tools => userspace-tools.rst} (97%)
 rename Documentation/hwmon/{vexpress => vexpress.rst} (85%)
 rename Documentation/hwmon/{via686a => via686a.rst} (79%)
 rename Documentation/hwmon/{vt1211 => vt1211.rst} (73%)
 rename Documentation/hwmon/{w83627ehf => w83627ehf.rst} (64%)
 rename Documentation/hwmon/{w83627hf => w83627hf.rst} (73%)
 rename Documentation/hwmon/{w83773g => w83773g.rst} (91%)
 rename Documentation/hwmon/{w83781d => w83781d.rst} (66%)
 rename Documentation/hwmon/{w83791d => w83791d.rst} (59%)
 rename Documentation/hwmon/{w83792d => w83792d.rst} (78%)
 delete mode 100644 Documentation/hwmon/w83793
 create mode 100644 Documentation/hwmon/w83793.rst
 delete mode 100644 Documentation/hwmon/w83795
 create mode 100644 Documentation/hwmon/w83795.rst
 rename Documentation/hwmon/{w83l785ts => w83l785ts.rst} (91%)
 rename Documentation/hwmon/{w83l786ng => w83l786ng.rst} (64%)
 rename Documentation/hwmon/{wm831x => wm831x.rst} (86%)
 rename Documentation/hwmon/{wm8350 => wm8350.rst} (81%)
 rename Documentation/hwmon/{xgene-hwmon => xgene-hwmon.rst} (51%)
 rename Documentation/hwmon/{zl6100 => zl6100.rst} (83%)
 create mode 100644 drivers/hwmon/lochnagar-hwmon.c
 create mode 100644 drivers/hwmon/pmbus/ir38064.c
 create mode 100644 drivers/hwmon/pmbus/isl68137.c
