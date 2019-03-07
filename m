Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04A6C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96DD920675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vQftHpEv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfCGJih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 04:38:37 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34563 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCGJig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 04:38:36 -0500
Received: by mail-wm1-f68.google.com with SMTP id o10so6296201wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 01:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=7q5E30T5lr/SLgqbqob+PXqVZeBTm6O56cUjq2pxl5A=;
        b=vQftHpEv2N0oueuNlPtvBgjUkOXX90kwVDRaCgZggqnQO0S2E+odeI41++tyH4m7an
         apB03gwz3Ms4F29BUtu5TBePp1QZdEkeIrYq6g5MreVHJCwHOdocmDLyFXdJxFcxdF2x
         R/m+TRlmNf/Xjri6zqA0FPVScW85hbhVzsd5pTLQSiucn/BdHul2++IV3dDfBvqGViZg
         Bl0ftm4/Sghe6JuTEJ0QYLzPrOX6OCDy2H7H9kG6Xospxz4L7LCbcnfc+WePkEMc7ARy
         lPxPbXM2H0NEnFvuIQfMOP7tqMRGv5qwA6kvet+A4mxBgwvI41bfQmm21zv+EzrRMMno
         AL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=7q5E30T5lr/SLgqbqob+PXqVZeBTm6O56cUjq2pxl5A=;
        b=EFTgP0Ky1zTet/lRn9XV3765VKp/+TSpWmu62+0H+qsahVza6LQv48FcG4nFISnICh
         UScbVrPrZ6UyWJHPw4SsvlzJ74QkDTiTIvdF+WvzXxT3EYUu46I3F4cFmciMmlECSfa6
         CQEywyfMzQhuCCGUGQyLwGAhZqG3WQGTYmkXntSkCkZIVrd94uTsjxhBQIjiOu2dtRds
         J7bf/hGWqnlsc5kaX/jEktz9oI7K9asq2kkadT2VbqN//EPnC0i7e7A8mX9Tyz7U7YJJ
         z7T72exyl0RsNQFj78/1CgyimCmifgyslKE69DmxK+kFNczFq8XoK7DaM1p/uClZ9AEM
         u1jQ==
X-Gm-Message-State: APjAAAX4r0paW4nO00aDjXiAH+gDsjbVI3yx/BRTSKNEnxSzevHMcpoC
        7lWgQHI0s9TD27Zc/gjNprJb/O6jV+I=
X-Google-Smtp-Source: APXvYqzqW2jv2YVP3jUaOek1oxEFq9mNpHShGpITcm1khjqGcJ4jmIXadgfoXSp89CHe/DmVWZxCsQ==
X-Received: by 2002:a1c:1a86:: with SMTP id a128mr5092944wma.67.1551951511428;
        Thu, 07 Mar 2019 01:38:31 -0800 (PST)
Received: from dell ([2.27.35.194])
        by smtp.gmail.com with ESMTPSA id o5sm2659009wmh.12.2019.03.07.01.38.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 01:38:30 -0800 (PST)
Date:   Thu, 7 Mar 2019 09:38:28 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] MFD for v5.1
Message-ID: <20190307093828.GD4634@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning Linus,

Enjoy!

The following changes since commit 49a57857aeea06ca831043acbb0fa5e0f50602fd:

  Linux 5.0-rc3 (2019-01-21 13:14:44 +1300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-next-5.1

for you to fetch changes up to d2d833e0bf2bad221a955626b942b38312630894:

  mfd: mxs-lradc: Mark expected switch fall-through (2019-02-18 09:07:22 +0000)

----------------------------------------------------------------
 - New Drivers
   - Add STMPE ADC Input driver
   - Add STMicroelectronics STPMIC1 Parent driver
   - Add STMicroelectronics STPMIC1 OnKey Misc driver
   - Add STMicroelectronics STPMIC1 Watchdog driver
   - Add Cirrus Logic Lochnagar Parent driver
   - Add TQ-Systems TQMX86 Parent driver

 - New Device Support
   - Add support for ADC to STMPE

 - New (or moved) Functionality
   - Move Lightbar functionality to its own driver; cros_ec_lightbar
   - Move VBC functionality to its own driver; cros_ec_vbc
   - Move VBC functionality to its own driver; cros_ec_vbc
   - Move DebugFS functionality to its own driver; cros_ec_debugfs
   - Move SYSFS functionality to its own driver; cros_ec_sysfs
   - Add support for input voltage options; tps65218

 - Fix-ups
   - Use devm_* managed resources; cros_ec
   - Device Tree documentation; stmpe, aspeed-lpc, lochnagar
   - Trivial Clean-ups; stmpe
   - Rip out broken modular code; aat2870-core, adp5520, as3711,
         db8500-prcmu, htc-i2cpld, max8925-core, rc5t583, sta2x11-mfd,
	 syscon, tps65090, tps65910, tps68470 tps80031, wm831x-spi,
	 wm831x-i2c, wm831x-core, wm8350-i2c, wm8350-core, wm8400-core
   - Kconfig fixups; INTEL_SOC_PMIC
   - Improve error path; sm501, sec-core
   - Use struct_size() helper; sm501
   - Constify; at91-usart
   - Use pointers instead of copying data; at91-usart
   - Deliver proper return value; cros_ec_dev
   - Trivial formatting/whitespace; sec-core

----------------------------------------------------------------
Andrew Lunn (1):
      mfd: tqmx86: IO controller with I2C, Wachdog and GPIO

Andy Shevchenko (1):
      mfd: intel-lpss: Move linux/pm.h to the local header

Axel Lin (2):
      mfd: at91-usart: Constify at91_usart_spi_subdev and at91_usart_serial_subdev
      mfd: at91-usart: No need to copy mfd_cell in probe

Charles Keepax (2):
      mfd: lochnagar: Add initial binding documentation
      mfd: lochnagar: Add support for the Cirrus Logic Lochnagar

Christian Hohnstaedt (1):
      mfd: tps65218.c: Add input voltage options

Enric Balletbo i Serra (7):
      mfd / platform: cros_ec: Use devm_mfd_add_devices
      mfd / platform: cros_ec: Move lightbar attributes to its own driver
      mfd / platform: cros_ec: Move vbc attributes to its own driver
      mfd / platform: cros_ec: Move debugfs attributes to its own driver
      mfd / platform: cros_ec: Move device sysfs attributes to its own driver
      mfd / platform: cros_ec_vbc: Instantiate only if the EC has a VBC NVRAM
      platform/chrome: cros_ec_lightbar: Instantiate only if the EC has a lightbar

Guenter Roeck (1):
      mfd: cros_ec_dev: Return number of bytes read with CROS_EC_DEV_IOCRDMEM

Gustavo A. R. Silva (3):
      mfd: sm501: Fix potential NULL pointer dereference
      mfd: sm501: Use struct_size() in devm_kzalloc()
      mfd: mxs-lradc: Mark expected switch fall-through

Jarkko Nikula (1):
      mfd: Kconfig: Fix I2C_DESIGNWARE_PLATFORM dependencies

Krzysztof Kozlowski (2):
      mfd: sec-core: Return gracefully instead of BUG() if device cannot match
      mfd: sec-core: Cleanup formatting to a consistent style

Lee Jones (1):
      Merge branches 'ib-mfd-iio-input-5.1', 'ib-mfd-input-watchdog-5.1' and 'ib-mfd-platform-5.1' into ibs-for-mfd-merged

Pascal PAILLET-LME (6):
      dt-bindings: mfd: Document STPMIC1
      mfd: stpmic1: Add STPMIC1 driver
      dt-bindings: input: Document STPMIC1 PMIC onkey
      input: stpmic1: Add STPMIC1 onkey driver
      dt-bindings: watchdog: document STPMIC1 PMIC watchdog
      watchdog: stpmic1: Add STPMIC1 watchdog driver

Paul Gortmaker (19):
      mfd: aat2870-core: Make it explicitly non-modular
      mfd: adp5520: Make it explicitly non-modular
      mfd: as3711: Make it explicitly non-modular
      mfd: db8500-prcmu: Drop unused MODULE_ tags from non-modular code
      mfd: htc-i2cpld: Make it explicitly non-modular
      mfd: max8925-core: Drop unused MODULE_ tags from non-modular code
      mfd: rc5t583: Make it explicitly non-modular
      mfd: sta2x11: Drop unused MODULE_ tags from non-modular code
      mfd: syscon: Make it explicitly non-modular
      mfd: tps65090: Make it explicitly non-modular
      mfd: tps65910: Make it explicitly non-modular
      mfd: tps80031: Make it explicitly non-modular
      mfd: wm831x-spi: Make it explicitly non-modular
      mfd: wm831x-i2c: Make it explicitly non-modular
      mfd: wm831x-core: Drop unused module infrastructure from non-modular code
      mfd: wm8350-i2c: Make it explicitly non-modular
      mfd: wm8350-core: Drop unused module infrastructure from non-modular code
      mfd: wm8400-core: Make it explicitly non-modular
      mfd: tps68470: Drop unused MODULE_DEVICE_TABLE

Philippe Schenker (3):
      dt-bindings: stmpe: Reformatting parameter list and use tabs only
      mfd: stmpe: Move ADC related defines to MFD header
      Input: stmpe-ts: preparations for STMPE ADC driver

Stefan Agner (3):
      mfd: stmpe: Preparations for STMPE ADC driver
      iio: adc: add STMPE ADC driver using IIO framework
      iio: adc: add STMPE ADC devicetree bindings

Vijay Khemka (1):
      dt-bindings: mfd: aspeed-lpc: Make parameter optional

 Documentation/ABI/testing/sysfs-class-chromeos     |  32 ++
 .../sysfs-class-chromeos-driver-cros-ec-lightbar   |  74 ++++
 .../sysfs-class-chromeos-driver-cros-ec-vbc        |   6 +
 .../devicetree/bindings/iio/adc/stmpe-adc.txt      |  21 ++
 .../devicetree/bindings/input/st,stpmic1-onkey.txt |  28 ++
 .../bindings/input/touchscreen/stmpe.txt           | 116 ++++--
 .../devicetree/bindings/mfd/aspeed-lpc.txt         |   2 +
 .../devicetree/bindings/mfd/cirrus,lochnagar.txt   |  68 ++++
 .../devicetree/bindings/mfd/st,stpmic1.txt         |  61 ++++
 Documentation/devicetree/bindings/mfd/stmpe.txt    |  28 +-
 .../bindings/watchdog/st,stpmic1-wdt.txt           |  11 +
 MAINTAINERS                                        |  17 +
 drivers/iio/adc/Kconfig                            |   7 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/stmpe-adc.c                        | 363 +++++++++++++++++++
 drivers/input/misc/Kconfig                         |  11 +
 drivers/input/misc/Makefile                        |   2 +
 drivers/input/misc/stpmic1_onkey.c                 | 198 ++++++++++
 drivers/input/touchscreen/stmpe-ts.c               |  66 +---
 drivers/mfd/Kconfig                                |  42 ++-
 drivers/mfd/Makefile                               |   4 +
 drivers/mfd/aat2870-core.c                         |  40 +--
 drivers/mfd/adp5520.c                              |  30 +-
 drivers/mfd/as3711.c                               |  14 -
 drivers/mfd/at91-usart.c                           |  24 +-
 drivers/mfd/cros_ec.c                              |  14 +-
 drivers/mfd/cros_ec_dev.c                          |  91 ++---
 drivers/mfd/cros_ec_dev.h                          |   6 -
 drivers/mfd/db8500-prcmu.c                         |  10 +-
 drivers/mfd/htc-i2cpld.c                           |  18 +-
 drivers/mfd/intel-lpss-acpi.c                      |   1 -
 drivers/mfd/intel-lpss-pci.c                       |   1 -
 drivers/mfd/intel-lpss.h                           |   2 +
 drivers/mfd/lochnagar-i2c.c                        | 398 +++++++++++++++++++++
 drivers/mfd/max8925-core.c                         |   7 +-
 drivers/mfd/mxs-lradc.c                            |   2 +-
 drivers/mfd/rc5t583.c                              |  14 -
 drivers/mfd/sec-core.c                             |  16 +-
 drivers/mfd/sm501.c                                |   6 +-
 drivers/mfd/sta2x11-mfd.c                          |  10 +-
 drivers/mfd/stmpe.c                                |  68 ++++
 drivers/mfd/stpmic1.c                              | 213 +++++++++++
 drivers/mfd/syscon.c                               |  12 +-
 drivers/mfd/tps65090.c                             |  30 +-
 drivers/mfd/tps65218.c                             |  89 +++++
 drivers/mfd/tps65910.c                             |  18 +-
 drivers/mfd/tps68470.c                             |   1 -
 drivers/mfd/tps80031.c                             |  37 +-
 drivers/mfd/tqmx86.c                               | 281 +++++++++++++++
 drivers/mfd/wm831x-core.c                          |  15 +-
 drivers/mfd/wm831x-i2c.c                           |  20 +-
 drivers/mfd/wm831x-spi.c                           |  24 +-
 drivers/mfd/wm8350-core.c                          |  30 +-
 drivers/mfd/wm8350-i2c.c                           |  24 +-
 drivers/mfd/wm8400-core.c                          |  18 +-
 drivers/platform/chrome/Kconfig                    |  47 ++-
 drivers/platform/chrome/Makefile                   |   7 +-
 drivers/platform/chrome/cros_ec_debugfs.c          |  62 ++--
 drivers/platform/chrome/cros_ec_i2c.c              |  10 -
 drivers/platform/chrome/cros_ec_lightbar.c         | 126 ++++---
 drivers/platform/chrome/cros_ec_lpc.c              |   4 -
 drivers/platform/chrome/cros_ec_spi.c              |  11 -
 drivers/platform/chrome/cros_ec_sysfs.c            |  36 +-
 drivers/platform/chrome/cros_ec_vbc.c              |  59 ++-
 drivers/watchdog/Kconfig                           |  12 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/stpmic1_wdt.c                     | 139 +++++++
 include/dt-bindings/clk/lochnagar.h                |  26 ++
 include/dt-bindings/mfd/st,stpmic1.h               |  50 +++
 include/dt-bindings/pinctrl/lochnagar.h            | 132 +++++++
 include/linux/mfd/cros_ec.h                        |  21 --
 include/linux/mfd/lochnagar.h                      |  55 +++
 include/linux/mfd/lochnagar1_regs.h                | 157 ++++++++
 include/linux/mfd/lochnagar2_regs.h                | 291 +++++++++++++++
 include/linux/mfd/stmpe.h                          |  21 ++
 include/linux/mfd/stpmic1.h                        | 212 +++++++++++
 include/linux/mfd/tps65218.h                       |   4 +
 include/linux/mfd/wm831x/core.h                    |   1 -
 include/linux/mfd/wm8350/core.h                    |   1 -
 79 files changed, 3571 insertions(+), 656 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-chromeos
 create mode 100644 Documentation/ABI/testing/sysfs-class-chromeos-driver-cros-ec-lightbar
 create mode 100644 Documentation/ABI/testing/sysfs-class-chromeos-driver-cros-ec-vbc
 create mode 100644 Documentation/devicetree/bindings/iio/adc/stmpe-adc.txt
 create mode 100644 Documentation/devicetree/bindings/input/st,stpmic1-onkey.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/cirrus,lochnagar.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/st,stpmic1.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/st,stpmic1-wdt.txt
 create mode 100644 drivers/iio/adc/stmpe-adc.c
 create mode 100644 drivers/input/misc/stpmic1_onkey.c
 create mode 100644 drivers/mfd/lochnagar-i2c.c
 create mode 100644 drivers/mfd/stpmic1.c
 create mode 100644 drivers/mfd/tqmx86.c
 create mode 100644 drivers/watchdog/stpmic1_wdt.c
 create mode 100644 include/dt-bindings/clk/lochnagar.h
 create mode 100644 include/dt-bindings/mfd/st,stpmic1.h
 create mode 100644 include/dt-bindings/pinctrl/lochnagar.h
 create mode 100644 include/linux/mfd/lochnagar.h
 create mode 100644 include/linux/mfd/lochnagar1_regs.h
 create mode 100644 include/linux/mfd/lochnagar2_regs.h
 create mode 100644 include/linux/mfd/stpmic1.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
