Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1646C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 10:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB8421537
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 10:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i+YtsegY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfENKim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 06:38:42 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53740 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfENKil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 06:38:41 -0400
Received: by mail-wm1-f68.google.com with SMTP id 198so2309404wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 03:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=afgAsp3OHLskWRF4JuM2O22vSIWZRkOoOxaQv9fTMyQ=;
        b=i+YtsegYppRRbBa7rqLDP66TbuOOUqQGrh+VNFZa/0dmarNSdg79iUjrslQBjvUsdG
         2fDMz2ogq/xNnWwagbzd9wwtqwMMpmCOE6ojPEPC5Ps9x7pVpCdIE1WS8Y8+8JwUBd7j
         fZLgTNuoCvnSyC2nqt065+ZBacUbjS+pzCudhGwRcbMawi5B/EvzyrzQzFtikokhLzMf
         TPVMwdR/Jy+aRsLI14QBWoilCdn9S1Cx61QZUaeZqFvOlTXSX+ur7jw0Sf9a3HIBgCwh
         OK+vTpllUCkRpK1QW3qZdxGV+Q/M5UaVJp8jqkXy7js3+meW9ZsTG3lhbXsngLNaOBww
         BNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=afgAsp3OHLskWRF4JuM2O22vSIWZRkOoOxaQv9fTMyQ=;
        b=Gsj8Sqey8EoxS5elx4cACOwlshm9+m5bgkwZF8H4sHHb1grgvgEfKdIMwmUducRFR7
         eomCgXUrfSjTbnZQmuGZazNzvjDnPCMszQGP7R0fXryM6wQwyS5ekG8AY7R/Skd7v+ID
         y68LAbq7+aNTJlOXTGVmQOHxE8HvXA5l3yihpNPE6eer3vzwWm7puSKHr14iKu9UP+PX
         MseQ8yj5aLlLP8crek9vxzA4RjtZE9H2+zgpv+WSyH7OeorbGp5U4mbBP52aXyU8RKML
         O7Wgs8bSUjoY1rYgcdMaXOK1FIyBcMFrWlsCNffA24nzRs1PdnV/p9+selOWwn9MawWt
         iSOw==
X-Gm-Message-State: APjAAAXSX5I8JFJnCrX5BIPDzoMD6zFDqy09qE9aOKG/HaaX/zmx4SfM
        jkmGQ+/DQ4SA4PdAnnKSJvYdSAC/4Mo=
X-Google-Smtp-Source: APXvYqwQudfIfmdrTaL35oJSPWsBhs++Y9UFsLZK1X5GEhHOIhWu/LgoFGvNwUEH0CJXavN95jccHA==
X-Received: by 2002:a1c:a846:: with SMTP id r67mr9012536wme.24.1557830318424;
        Tue, 14 May 2019 03:38:38 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id o8sm33795954wra.4.2019.05.14.03.38.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 03:38:37 -0700 (PDT)
Date:   Tue, 14 May 2019 11:38:36 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] MFD for v5.2
Message-ID: <20190514103836.GM4319@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enjoy!

The following changes since commit e93c9c99a629c61837d5a7fc2120cd2b6c70dbdd:

  Linux 5.1 (2019-05-05 17:42:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-5.2

for you to fetch changes up to ed835136ee679dc528333c454ca4d1543c5aab76:

  mfd: Use dev_get_drvdata() directly (2019-05-14 08:13:28 +0100)

----------------------------------------------------------------
 - Core Frameworks
   - Document (kerneldoc) core mfd_add_devices() API

 - New Drivers
   - Add support for Altera SOCFPGA System Manager
   - Add support for Maxim MAX77650/77651 PMIC
   - Add support for Maxim MAX77663 PMIC
   - Add support for ST Multi-Function eXpander (STMFX)

 - New Device Support
   - Add support for LEDs to Intel Cherry Trail Whiskey Cove PMIC
   - Add support for RTC to SAMSUNG Electronics S2MPA01 PMIC
   - Add support for SAM9X60 to Atmel HLCDC (High-end LCD Controller)
   - Add support for USB X-Powers AXP 8xx PMICs
   - Add support for Integrated Sensor Hub (ISH) to ChromeOS EC
   - Add support for USB PD Logger to ChromeOS EC
   - Add support for AXP223 to X-Powers AXP series PMICs
   - Add support for Power Supply to X-Powers AXP 803 PMICs
   - Add support for Comet Lake to Intel Low Power Subsystem
   - Add support for Fingerprint MCU to ChromeOS EC
   - Add support for Touchpad MCU to ChromeOS EC
   - Move TI LM3532 support to LED

 - New Functionality
   - Add/extend DT support; max77650, max77620
   - Add support for power-off; max77620
   - Add support for clocking; syscon
   - Add support for host sleep event; cros_ec

 - Fix-ups
   - Trivial; Formatting, spelling, etc; Kconfig, sec-core, ab8500-debugfs
   - Remove unused functionality; rk808, da9063-*
   - SPDX conversion; da9063-*, atmel-*,
   - Adapt/add new register definitions; cs47l35-tables, cs47l90-tables, imx6q-iomuxc-gpr
   - Fix-up DT bindings; ti-lmu, cirrus,lochnagar
   - Simply obtaining driver data; ssbi, t7l66xb, tc6387xb, tc6393xb

 - Bug Fixes
   - Fix incorrect defined values; max77620, da9063
   - Fix device initialisation; twl6040
   - Reset device on init; intel-lpss
   - Fix build warnings when !OF; sun6i-prcm
   - Register OF match tables; tps65912-spi
   - Fix DMI matching; intel_quark_i2c_gpio

----------------------------------------------------------------
Ajit Pandey (1):
      mfd: cs47l90: Make DAC_AEC_CONTROL_2 readable

Amelie Delaunay (5):
      dt-bindings: mfd: Add ST Multi-Function eXpander (STMFX) core bindings
      mfd: Add ST Multi-Function eXpander (STMFX) core driver
      dt-bindings: pinctrl: document the STMFX pinctrl bindings
      pinctrl: Add STMFX GPIO expander Pinctrl/GPIO driver
      pinctrl: Kconfig: Fix STMFX GPIO expander Pinctrl/GPIO driver dependencies

Andy Shevchenko (1):
      mfd: intel-lpss: Add Intel Comet Lake PCI IDs

Arnd Bergmann (1):
      mfd: sun6i-prcm: Fix build warning for non-OF configurations

Bartosz Golaszewski (11):
      dt-bindings: mfd: Add DT bindings for max77650
      dt-bindings: power: supply: Add DT bindings for max77650
      dt-bindings: leds: Add DT bindings for max77650
      dt-bindings: input: Add DT bindings for max77650
      mfd: mfd-core: Document mfd_add_devices()
      mfd: Add new driver for MAX77650 PMIC
      power: supply: max77650: Add support for battery charger
      gpio: max77650: Add GPIO support
      leds: max77650: Add LEDs support
      input: max77650: Add onkey support
      MAINTAINERS: Add an entry for MAX77650 PMIC driver

Binbin Wu (1):
      mfd: intel-lpss: Set the device in reset state when init

Charles Keepax (1):
      mfd: lochnagar: Add links to binding docs for sound and hwmon

Chen-Yu Tsai (1):
      mfd: axp20x: Add USB power supply mfd cell to AXP803

Claudiu Beznea (2):
      mfd: atmel-hlcdc: Add compatible for SAM9X60 HLCD controller
      dt-bindings: mfd: Add bindings for SAM9X60 HLCD controller

Dan Murphy (5):
      dt: lm3532: Add lm3532 dt doc and update ti_lmu doc
      ARM: dts: omap4-droid4: Update backlight dt properties
      mfd: ti-lmu: Remove LM3532 backlight driver references
      leds: lm3532: Introduce the lm3532 LED driver
      dt-bindings: mfd: LMU: Fix lm3632 dt binding example

Daniel Gomez (1):
      mfd: tps65912-spi: Add missing of table registration

Dmitry Osipenko (5):
      dt-bindings: mfd: max77620: Add compatible for Maxim 77663
      dt-bindings: mfd: max77620: Add system-power-controller property
      mfd: max77620: Fix swapped FPS_PERIOD_MAX_US values
      mfd: max77620: Support Maxim 77663
      mfd: max77620: Provide system power-off functionality

Enric Balletbo i Serra (4):
      mfd: cros_ec: Instantiate the CrOS USB PD logger driver
      mfd: cros_ec: Update the EC feature codes
      mfd: cros_ec: Instantiate properly CrOS FP MCU device
      mfd: cros_ec: Instantiate properly CrOS Touchpad MCU device

Enrico Weigelt, metux IT consult (1):
      mfd: Kconfig: Pedantic formatting

Evan Green (2):
      mfd: cros_ec: Add host_sleep_event_v1 command
      platform/chrome: Add support for v1 of host sleep event

Fabrice Gasnier (2):
      dt-bindings: stm32: syscon: Add clock support
      mfd: syscon: Add optional clock support

Jonathan Neuschäfer (1):
      mfd: ab8500-debugfs: Fix a typo ("deubgfs")

Kefeng Wang (1):
      mfd: Use dev_get_drvdata() directly

Lee Jones (3):
      pinctrl: stmfx: Fix 'warn: unsigned <VAR> is never less than zero'
      pinctrl: stmfx: Fix 'warn: bitwise AND condition is false here'
      Merge branches 'ib-mfd-arm-leds-5.2', 'ib-mfd-gpio-input-leds-power-5.2', 'ib-mfd-pinctrl-5.2-2' and 'ib-mfd-regulator-5.2', tag 'ib-mfd-arm-net-5.2' into ibs-for-mfd-merged

Maxime Ripard (1):
      mfd: axp20x: Allow the AXP223 to be probed by I2C

Quentin Schulz (1):
      mfd: axp20x: Add USB power supply mfd cell to AXP813

Richard Fitzgerald (1):
      mfd: cs47l35: Make DAC_AEC_CONTROL_2 readable

Rushikesh S Kadam (1):
      mfd: cros_ec: Instantiate properly CrOS ISH MCU device

S.j. Wang (1):
      mfd: imx6sx: Add MQS register definition for iomuxc gpr

Steve Twiss (1):
      mfd: da9063: Fix OTP control register names to match datasheets for DA9063/63L

Stuart Menefy (2):
      mfd: sec: Put one element structure initialisation on one line
      mfd: sec: Add support for the RTC on S2MPA01

Su Bao Cheng (1):
      mfd: intel_quark_i2c_gpio: Adjust IOT2000 matching

Thor Thayer (6):
      mfd: altera-sysmgr: Add SOCFPGA System Manager
      dt-bindings: arm: socfpga: Add S10 System Manager binding
      ARM: socfpga_defconfig: Enable CONFIG_MTD_ALTERA_SYSMGR
      arm64: defconfig: Enable CONFIG_MTD_ALTERA_SYSMGR
      net: stmmac: socfpga: Use shared System Manager driver
      arm64: dts: stratix10: New System Manager compatible

Tony Lindgren (1):
      mfd: twl6040: Fix device init errors for ACCCTL register

Tony Xie (1):
      mfd: rk808: Remove the id_table

Tudor Ambarus (1):
      mfd: syscon: atmel: Switch to SPDX license identifiers

Wolfram Sang (2):
      mfd: da9063: Convert headers to SPDX
      mfd: da9063: Remove platform_data support

Yauhen Kharuzhy (1):
      mfd: intel_soc_pmic_chtwc: Register LED child device

 .../bindings/arm/altera/socfpga-system.txt         |  12 +
 .../devicetree/bindings/arm/stm32/stm32-syscon.txt |   2 +
 .../devicetree/bindings/input/max77650-onkey.txt   |  26 +
 .../devicetree/bindings/leds/leds-lm3532.txt       | 101 +++
 .../devicetree/bindings/leds/leds-max77650.txt     |  57 ++
 .../devicetree/bindings/mfd/atmel-hlcdc.txt        |   1 +
 .../devicetree/bindings/mfd/cirrus,lochnagar.txt   |  17 +
 Documentation/devicetree/bindings/mfd/max77620.txt |   9 +-
 Documentation/devicetree/bindings/mfd/max77650.txt |  46 ++
 Documentation/devicetree/bindings/mfd/stmfx.txt    |  28 +
 Documentation/devicetree/bindings/mfd/ti-lmu.txt   |  24 +-
 .../devicetree/bindings/pinctrl/pinctrl-stmfx.txt  | 116 +++
 .../bindings/power/supply/max77650-charger.txt     |  28 +
 MAINTAINERS                                        |  20 +
 arch/arm/boot/dts/omap4-droid4-xt894.dts           |  27 +-
 arch/arm/configs/socfpga_defconfig                 |   1 +
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |   2 +-
 arch/arm64/configs/defconfig                       |   1 +
 drivers/gpio/Kconfig                               |   7 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-max77650.c                       | 190 +++++
 drivers/input/misc/Kconfig                         |   9 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/max77650-onkey.c                | 121 +++
 drivers/leds/Kconfig                               |  16 +
 drivers/leds/Makefile                              |   2 +
 drivers/leds/leds-lm3532.c                         | 683 +++++++++++++++++
 drivers/leds/leds-max77650.c                       | 147 ++++
 drivers/mfd/Kconfig                                |  99 ++-
 drivers/mfd/Makefile                               |   4 +-
 drivers/mfd/ab8500-debugfs.c                       |   2 +-
 drivers/mfd/altera-sysmgr.c                        | 211 ++++++
 drivers/mfd/atmel-hlcdc.c                          |   1 +
 drivers/mfd/axp20x-i2c.c                           |   2 +
 drivers/mfd/axp20x.c                               |  16 +
 drivers/mfd/cros_ec.c                              |  39 +-
 drivers/mfd/cros_ec_dev.c                          |  36 +-
 drivers/mfd/cs47l35-tables.c                       |   2 +
 drivers/mfd/cs47l90-tables.c                       |   2 +
 drivers/mfd/da9063-core.c                          |  28 +-
 drivers/mfd/da9063-i2c.c                           |  10 +-
 drivers/mfd/da9063-irq.c                           |  10 +-
 drivers/mfd/intel-lpss-pci.c                       |  13 +
 drivers/mfd/intel-lpss.c                           |   3 +
 drivers/mfd/intel_quark_i2c_gpio.c                 |  10 -
 drivers/mfd/intel_soc_pmic_chtwc.c                 |   1 +
 drivers/mfd/max77620.c                             |  87 ++-
 drivers/mfd/max77650.c                             | 232 ++++++
 drivers/mfd/mfd-core.c                             |  13 +
 drivers/mfd/rk808.c                                |   9 -
 drivers/mfd/sec-core.c                             |  59 +-
 drivers/mfd/sec-irq.c                              |   3 +
 drivers/mfd/ssbi.c                                 |   6 +-
 drivers/mfd/stmfx.c                                | 545 ++++++++++++++
 drivers/mfd/sun6i-prcm.c                           |   3 +-
 drivers/mfd/syscon.c                               |  19 +
 drivers/mfd/t7l66xb.c                              |  12 +-
 drivers/mfd/tc6387xb.c                             |  12 +-
 drivers/mfd/tc6393xb.c                             |  23 +-
 drivers/mfd/ti-lmu.c                               |  11 -
 drivers/mfd/tps65912-spi.c                         |   1 +
 drivers/mfd/twl6040.c                              |  13 +-
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |   5 +-
 drivers/pinctrl/Kconfig                            |  14 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-stmfx.c                    | 819 +++++++++++++++++++++
 drivers/platform/chrome/cros_ec_proto.c            |   6 +
 drivers/power/supply/Kconfig                       |   7 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/max77650-charger.c            | 368 +++++++++
 include/linux/mfd/altera-sysmgr.h                  |  29 +
 include/linux/mfd/cros_ec.h                        |   5 +
 include/linux/mfd/cros_ec_commands.h               |  91 ++-
 include/linux/mfd/da9063/core.h                    |   7 +-
 include/linux/mfd/da9063/registers.h               |  13 +-
 include/linux/mfd/max77620.h                       |   5 +-
 include/linux/mfd/max77650.h                       |  59 ++
 include/linux/mfd/stmfx.h                          | 123 ++++
 include/linux/mfd/syscon/atmel-matrix.h            |   6 +-
 include/linux/mfd/syscon/atmel-mc.h                |   6 +-
 include/linux/mfd/syscon/atmel-smc.h               |   5 +-
 include/linux/mfd/syscon/atmel-st.h                |   6 +-
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h        |   9 +
 include/linux/mfd/ti-lmu-register.h                |  44 --
 include/linux/mfd/ti-lmu.h                         |   1 -
 85 files changed, 4558 insertions(+), 304 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/max77650-onkey.txt
 create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3532.txt
 create mode 100644 Documentation/devicetree/bindings/leds/leds-max77650.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/max77650.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/stmfx.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-stmfx.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/max77650-charger.txt
 create mode 100644 drivers/gpio/gpio-max77650.c
 create mode 100644 drivers/input/misc/max77650-onkey.c
 create mode 100644 drivers/leds/leds-lm3532.c
 create mode 100644 drivers/leds/leds-max77650.c
 create mode 100644 drivers/mfd/altera-sysmgr.c
 create mode 100644 drivers/mfd/max77650.c
 create mode 100644 drivers/mfd/stmfx.c
 create mode 100644 drivers/pinctrl/pinctrl-stmfx.c
 create mode 100644 drivers/power/supply/max77650-charger.c
 create mode 100644 include/linux/mfd/altera-sysmgr.h
 create mode 100644 include/linux/mfd/max77650.h
 create mode 100644 include/linux/mfd/stmfx.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
