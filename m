Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13183C7618E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 07:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C936E20838
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 07:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kcaGto+k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbfGOHsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 03:48:42 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50377 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfGOHsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 03:48:42 -0400
Received: by mail-wm1-f66.google.com with SMTP id v15so14097435wml.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 00:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=i0QXQRrN6RhRZnvaWbhvCAiXQYTHsysyFi/snkm39ak=;
        b=kcaGto+kb9nUbbxwEavJfBH3qyZm9rw+VNpXaASRkcEB4IXpBx3vmUgOwWuEZzk+EO
         lLrF8t+KpC/4UqhyVfJ/uGdU+7ih3PYqzbUyjBAbk1rRckLgvgK5HnpvBFsJC/qDv8k4
         FVfs3DIPll2BnKW3WIbbBhDdfmRdzid4a/AuXhAhk90tAxsZG5jWRo7/lP7SsUtubpyh
         HLOtRIB2Q0lszvFTZjj1si9h7FpSqUqorLRN1Rk20jFc4F+XTukwKta2A5+E2zlQISow
         xkJwZbgfjl/21P/Z+1sEv9XfiOhFWiG+mc5uquwE2ltT6eErdTkP7Uc7FRKkVLciJGVc
         4Hpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=i0QXQRrN6RhRZnvaWbhvCAiXQYTHsysyFi/snkm39ak=;
        b=rNiZmke2VSt20so+7FrIbJTHW1WOo/zLAmFaa1xQuIAkAPgwsEDwj77th0BJh0Wiy2
         X8pWG8d98k69reEB1ruRex6gqcHHpb45l+IVLcopmWcOXxvY+AzfyQAaUxhHXEXFhZvT
         Z2ZhnwFu5L+RlLkv8NT2USryNw843UKELt+gSbp2p1zrrvWuB7P4oU0wBI+A9uvgaxMs
         VUz3M2a6f3VBIiUSlGrrBI9j/DCf7ah5iBu3idBvI/gBjPuV1BqkVyc6S8kwZD8iNqim
         XRrNOqTJbSFsfwHueB24DUX41OHopeBei+i3A+TfVLNvGBtzIA4ihrtvqPgubxGgVoy4
         swjg==
X-Gm-Message-State: APjAAAXNdQLB51ZbDpRJUuk5zC6TjBb1dLbmkHlfFwMM3g5DwXXbjaTJ
        Gl0g3uFdVjg36MM/pMPvUGuh/n3+B1s=
X-Google-Smtp-Source: APXvYqyM0OwqhVewvK73SoHG/lt5PyqsSZfbnVCcxLuOXYa89/B768jLb6hQ7yr44nd5fPJKGs88uA==
X-Received: by 2002:a1c:a5c2:: with SMTP id o185mr22564776wme.172.1563176918143;
        Mon, 15 Jul 2019 00:48:38 -0700 (PDT)
Received: from dell ([2.27.35.164])
        by smtp.gmail.com with ESMTPSA id b5sm12753689wru.69.2019.07.15.00.48.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Jul 2019 00:48:37 -0700 (PDT)
Date:   Mon, 15 Jul 2019 08:48:35 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] MFD for v5.3
Message-ID: <20190715074835.GC4401@dell>
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

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-5.3

for you to fetch changes up to 7efd105c27fd2323789b41b64763a0e33ed79c08:

  mfd: hi655x-pmic: Fix missing return value check for devm_regmap_init_mmio_clk (2019-07-02 12:11:31 +0100)

----------------------------------------------------------------
 - Core Frameworks
   - Set 'struct device' fwnode when registering a new device

 - New Drivers
   - Add support for ROHM BD70528 PMIC

 - New Device Support
   - Add support for LP87561 4-Phase Regulator to TI LP87565 PMIC
   - Add support for RK809 and RK817 to Rockchip RK808
   - Add support for Lid Angle to ChromeOS core
   - Add support for CS47L15 CODEC to Madera core
   - Add support for CS47L92 CODEC to Madera core
   - Add support for ChromeOS (legacy) Accelerometers in ChromeOS core
   - Add support for Add Intel Elkhart Lake PCH to Intel LPSS

 - New Functionality
   - Provide regulator supply information when registering; madera-core
   - Additional Device Tree support; lp87565, madera, cros-ec, rohm,bd71837-pmic
   - Allow over-riding power button press via Device Tree; rohm-bd718x7
   - Differentiate between running processors; cros_ec_dev

 - Fix-ups
   - Big header file update; cros_ec_commands.h
   - Split header per-subsystem; rohm-bd718x7
   - Remove superfluous code; menelaus, cs5535-mfd, cs47lXX-tables
   - Trivial; sorting, coding style; intel-lpss-pci
   - Only remove Power Off functionality if set locally; rk808
   - Make use for Power Off Prepare(); rk808
   - Fix spelling mistake in header guards; stmfx
   - Properly free IDA resources
   - SPDX fixups; cs47lXX-tables, madera
   - Error path fixups; hi655x-pmic

 - Bug Fixes
   - Add missing break in case() statement
   - Repair undefined behaviour when not initialising variables; arizona-core, madera-core
   - Fix reference to Device Tree documentation; madera

----------------------------------------------------------------
Alexandre Belloni (1):
      mfd: menelaus: Remove superfluous error message

Andy Shevchenko (4):
      mfd: intel-lpss: Keep device tables sorted by ID
      MAINAINERS: Swap words in INTEL PMIC MULTIFUNCTION DEVICE DRIVERS
      mfd: intel-lpss: Add Intel Elkhart Lake PCH PCI IDs
      mfd: intel-lpss: Release IDA resources

Arnd Bergmann (1):
      mfd: arizona: Fix undefined behavior

Axel Lin (1):
      mfd: hi655x-pmic: Fix missing return value check for devm_regmap_init_mmio_clk

Charles Keepax (3):
      mfd: madera: Add supply mapping for MICVDD
      mfd: madera: Remove some unused registers and fix some defaults
      mfd: madera: Fixup SPDX headers

Colin Ian King (1):
      regulator: lp87565: Fix missing break in switch statement

Daniel Gomez (1):
      mfd: madera: Add missing of table registration

Gwendal Grignou (32):
      mfd: cros_ec: Update license term
      mfd: cros_ec: Zero BUILD_ macro
      mfd: cros_ec: set comments properly
      mfd: cros_ec: add ec_align macros
      mfd: cros_ec: Define commands as 4-digit UPPER CASE hex values
      mfd: cros_ec: use BIT macro
      mfd: cros_ec: Update ACPI interface definition
      mfd: cros_ec: move HDMI CEC API definition
      mfd: cros_ec: Remove zero-size structs
      mfd: cros_ec: Add Flash V2 commands API
      mfd: cros_ec: Add PWM_SET_DUTY API
      mfd: cros_ec: Add lightbar v2 API
      mfd: cros_ec: Expand hash API
      mfd: cros_ec: Add EC transport protocol v4
      mfd: cros_ec: Complete MEMS sensor API
      mfd: cros_ec: Fix event processing API
      mfd: cros_ec: Add fingerprint API
      mfd: cros_ec: Fix temperature API
      mfd: cros_ec: Complete Power and USB PD API
      mfd: cros_ec: Add API for keyboard testing
      mfd: cros_ec: Add Hibernate API
      mfd: cros_ec: Add Smart Battery Firmware update API
      mfd: cros_ec: Add I2C passthru protection API
      mfd: cros_ec: Add API for EC-EC communication
      mfd: cros_ec: Add API for Touchpad support
      mfd: cros_ec: Add API for Fingerprint support
      mfd: cros_ec: Add API for rwsig
      mfd: cros_ec: Add SKU ID and Secure storage API
      mfd: cros_ec: Add Management API entry points
      mfd: cros_ec: Update I2S API
      mfd: cros_ec: Register cros_ec_lid_angle driver when presented
      mfd: cros_ec_dev: Register cros_ec_accel_legacy driver as a subdevice

Heiko Stuebner (1):
      regulator: rk808: Add RK809 and RK817 support.

Keerthy (3):
      dt-bindings: mfd: lp87565: Add LP87561 configuration
      mfd: lp87565: Add support for 4-phase LP87561 combination
      regulator: lp87565: Add 4-phase lp87561 regulator support

Lee Jones (1):
      Merge branches 'ib-mfd-clk-gpio-power-regulator-rtc-5.3', 'ib-mfd-clk-regulator-rtc-5.3', 'ib-mfd-cros-5.3' and 'ib-mfd-regulator-5.3' into ibs-for-mfd-merged

Leonard Crestez (3):
      mfd: bd718x7: Remove hardcoded config for button press duration
      dt-bindings: mfd: Document short/long press duration for BD718X7
      mfd: bd718x7: Make power button press duration configurable

Lubomir Rintel (1):
      mfd: cs5535-mfd: Remove ifdef OLPC noise

Matti Vaittinen (8):
      mfd: regulator: clk: Split rohm-bd718x7.h
      mfd: bd70528: Support ROHM bd70528 PMIC core
      clk: bd718x7: Support ROHM BD70528 clk block
      dt-bindings: mfd: Document first ROHM BD70528 bindings
      gpio: Initial support for ROHM bd70528 GPIO block
      rtc: bd70528: Initial support for ROHM bd70528 RTC
      power: supply: Initial support for ROHM BD70528 PMIC charger block
      dt-bindings: mfd: Add link to ROHM BD71847 Datasheet

Nathan Chancellor (1):
      mfd: stmfx: Fix macro definition spelling

Otto Sabart (1):
      mfd: madera: Fix bad reference to pinctrl.txt file

Pi-Hsun Shih (2):
      dt-bindings: Add binding for cros-ec-rpmsg
      mfd: cros_ec: differentiate SCP from EC by feature bit

Richard Fitzgerald (3):
      mfd: madera: Update DT bindings to add additional CODECs
      mfd: madera: Add Madera core support for CS47L15
      mfd: madera: Add Madera core support for CS47L92

Robert Hancock (1):
      mfd: core: Set fwnode for created devices

Stefan Mavrodiev (2):
      mfd: rk808: Check pm_power_off pointer
      mfd: rk808: Prepare rk805 for poweroff

Stuart Henderson (1):
      mfd: madera: Fix potential uninitialised use of variable

Tony Xie (4):
      mfd: rk808: Add RK817 and RK809 support
      dt-bindings: mfd: rk808: Add binding information for RK809 and RK817.
      rtc: rk808: Add RK809 and RK817 support.
      clk: RK808: Add RK809 and RK817 support.

 Documentation/devicetree/bindings/mfd/cros-ec.txt  |    5 +-
 Documentation/devicetree/bindings/mfd/lp87565.txt  |   36 +
 Documentation/devicetree/bindings/mfd/madera.txt   |    8 +-
 Documentation/devicetree/bindings/mfd/rk808.txt    |   44 +
 .../devicetree/bindings/mfd/rohm,bd70528-pmic.txt  |  102 +
 .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  |   10 +
 MAINTAINERS                                        |    2 +-
 drivers/clk/Kconfig                                |   15 +-
 drivers/clk/clk-bd718x7.c                          |   24 +-
 drivers/clk/clk-rk808.c                            |   64 +-
 drivers/gpio/Kconfig                               |   11 +
 drivers/gpio/Makefile                              |    1 +
 drivers/gpio/gpio-bd70528.c                        |  232 ++
 drivers/mfd/Kconfig                                |   37 +-
 drivers/mfd/Makefile                               |    8 +
 drivers/mfd/arizona-core.c                         |    2 +-
 drivers/mfd/cros_ec_dev.c                          |   92 +-
 drivers/mfd/cs47l15-tables.c                       | 1299 +++++++
 drivers/mfd/cs47l35-tables.c                       |   60 +-
 drivers/mfd/cs47l85-tables.c                       |  128 +-
 drivers/mfd/cs47l90-tables.c                       |   82 +-
 drivers/mfd/cs47l92-tables.c                       | 1947 +++++++++++
 drivers/mfd/cs5535-mfd.c                           |   24 +-
 drivers/mfd/hi655x-pmic.c                          |    2 +
 drivers/mfd/intel-lpss-pci.c                       |   21 +-
 drivers/mfd/intel-lpss.c                           |    1 +
 drivers/mfd/lp87565.c                              |    4 +
 drivers/mfd/madera-core.c                          |  129 +-
 drivers/mfd/madera-i2c.c                           |   24 +-
 drivers/mfd/madera-spi.c                           |   24 +-
 drivers/mfd/madera.h                               |   13 +
 drivers/mfd/menelaus.c                             |    2 -
 drivers/mfd/mfd-core.c                             |    1 +
 drivers/mfd/rk808.c                                |  257 +-
 drivers/mfd/rohm-bd70528.c                         |  316 ++
 drivers/mfd/rohm-bd718x7.c                         |   80 +-
 drivers/power/supply/Kconfig                       |    9 +
 drivers/power/supply/Makefile                      |    1 +
 drivers/power/supply/bd70528-charger.c             |  743 ++++
 drivers/regulator/Kconfig                          |    4 +-
 drivers/regulator/bd718x7-regulator.c              |   25 +-
 drivers/regulator/lp87565-regulator.c              |   18 +-
 drivers/regulator/rk808-regulator.c                |  646 +++-
 drivers/rtc/Kconfig                                |   12 +-
 drivers/rtc/Makefile                               |    1 +
 drivers/rtc/rtc-bd70528.c                          |  500 +++
 drivers/rtc/rtc-rk808.c                            |   68 +-
 include/linux/mfd/cros_ec.h                        |    1 +
 include/linux/mfd/cros_ec_commands.h               | 3658 ++++++++++++++++----
 include/linux/mfd/lp87565.h                        |    2 +
 include/linux/mfd/madera/core.h                    |   12 +-
 include/linux/mfd/madera/pdata.h                   |    9 +-
 include/linux/mfd/madera/registers.h               |  286 +-
 include/linux/mfd/rk808.h                          |  177 +
 include/linux/mfd/rohm-bd70528.h                   |  408 +++
 include/linux/mfd/rohm-bd718x7.h                   |   22 +-
 include/linux/mfd/rohm-generic.h                   |   20 +
 include/linux/mfd/stmfx.h                          |    2 +-
 sound/soc/codecs/cros_ec_codec.c                   |    8 +-
 59 files changed, 10439 insertions(+), 1300 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
 create mode 100644 drivers/gpio/gpio-bd70528.c
 create mode 100644 drivers/mfd/cs47l15-tables.c
 create mode 100644 drivers/mfd/cs47l92-tables.c
 create mode 100644 drivers/mfd/rohm-bd70528.c
 create mode 100644 drivers/power/supply/bd70528-charger.c
 create mode 100644 drivers/rtc/rtc-bd70528.c
 create mode 100644 include/linux/mfd/rohm-bd70528.h
 create mode 100644 include/linux/mfd/rohm-generic.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
