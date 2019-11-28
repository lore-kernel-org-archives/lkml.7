Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F65BC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5AAC208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="byvcCgVZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfK1OsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:48:24 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51383 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfK1OsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:48:23 -0500
Received: by mail-wm1-f65.google.com with SMTP id g206so11257033wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 06:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=fwsV1lUBaH712UoSWSftV7v2W4F52UFOO1pDpAi3wfY=;
        b=byvcCgVZS6gL8QkAK2NBfaVDPyZhrbB/I0OqF3e3SI5nItPE3IJztLQpAtLyLFI5WL
         2Skldc5GqWHpzGKyzVg6mat4kT0a78st2l4CEeYLNL12S09MqsaYpyut3cyUmjt54n6L
         92q07VQkhZXgiFZ0MDceKliIAR2WM5Uih7r4tMjph0NKUondXRpNv4cT4+uHDqpwd5WF
         eDS1J95VPKzhOQ6/QSb32LMYDMQCvVfpglcfkI60idT22gW26XU673AJe9u3fhbNGpBV
         bo67A/JYuOBi3Bulx9NKe+HOtiub/uViu1R0MUFQJvaBC5yk0Ha9UOrACtLzc4SaKkhV
         rTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=fwsV1lUBaH712UoSWSftV7v2W4F52UFOO1pDpAi3wfY=;
        b=G9J1g4l5GlUL4KI+W9mN1MPoaLQYQZRqV7JHaIpDq6fOWcKWD7k0ANs0nSa6oM3QvN
         ueRYSE/zKrnkdADUrLzuRw1oAde+qrIek774XEtLUmvb3s0E7rerpfjyC8waa4KlQj2Q
         zf0JMnyA+NJq67aPN/667LRxuSGoQ/plfFCpgLnR964pS9SVaIoJ1ODkgG8ReuceaEwc
         8iZBIzEYHPDP3ceIyNYaioniuQxPK7KX2bDb4g/mnVxqbqw347x9XDHrlBUwhBD14kQg
         XkB4d9zWA8eSfZOYmDjJpbzu8TFQBXf3pfBUdIA9wg9TW7oBdsKshsWj07kqH4uE83XS
         s6HA==
X-Gm-Message-State: APjAAAWFMA9YSjIiPvHDrZdx1n4ZDsJ58SPSSvBwkir6EyFH9WTNT3dB
        4GZ+EBwCt5kPWhhcD/pA0kQb8XFqSp4=
X-Google-Smtp-Source: APXvYqx+wcfxiJN6fImx9a5jv7PiR4NZu3MOQJZZybOssP3B3HwLKxa3SYQJQGFBnNrFddXrESIVVw==
X-Received: by 2002:a1c:a5c8:: with SMTP id o191mr9689023wme.168.1574952500260;
        Thu, 28 Nov 2019 06:48:20 -0800 (PST)
Received: from dell ([2.31.167.254])
        by smtp.gmail.com with ESMTPSA id u16sm23667159wrr.65.2019.11.28.06.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 06:48:19 -0800 (PST)
Date:   Thu, 28 Nov 2019 14:48:07 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] MFD for v5.5
Message-ID: <20191128144807.GB14416@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon Linus,

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-5.5

for you to fetch changes up to edfaeaf742b4c3ee6f58e0b8be95b5296a3375e8:

  Revert "mfd: syscon: Set name of regmap_config" (2019-11-13 11:07:40 +0000)

----------------------------------------------------------------
 - Core Frameworks
   - Add support for a "resource managed strongly uncachable ioremap" call
   - Provide a collection of MFD helper macros
   - Remove mfd_clone_cell() from MFD core
   - Add NULL de-reference protection in MFD core
   - Remove superfluous function fd_platform_add_cell() from MFD core
   - Honour Device Tree's request to disable a device

 - New Drivers
   - Add support for MediaTek MT6323 PMIC

 - New Device Support
   - Add support for Gemini Lake to Intel LPSS PCI
   - Add support for Cherry Trail Crystal Cover PMIC to Intel SoC PMIC CRC
   - Add support for PM{I}8950 to Qualcomm SPMI PMIC
   - Add support for U8420 to ST-Ericsson DB8500
   - Add support for Comet Lake PCH-H to Intel LPSS PCI

 - New Functionality
   - Add support for requested supply clocks; madera-core

 - Fix-ups
   - Lower interrupt priority; rk808
   - Use provided helpers (macros, group functions, defines); rk808,
		ipaq-micro, ab8500-core, db8500-prcmu, mt6397-core, cs5535-mfd
   - Only allocate IRQs on request; max77620
   - Use simplified API; arizona-core
   - Remove redundant and/or duplicated code; wm8998-tables, arizona, syscon
   - Device Tree binding fix-ups; madera, max77650, max77693
   - Remove mfd_cell->id abuse hack; cs5535-mfd
   - Remove only user of mfd_clone_cell(); cs5535-mfd
   - Make resources static; rohm-bd70528

 - Bug Fixes
   - Fix product ID for RK818; rk808
   - Fix Power Key; rk808
   - Fix booting on the BananaPi; mt6397-core
   - Endian fix-ups; twl.h
   - Fix static error checker warnings; ti_am335x_tscadc

----------------------------------------------------------------
Andy Shevchenko (2):
      mfd: intel-lpss: Add Intel Comet Lake PCH-H PCI IDs
      Revert "mfd: syscon: Set name of regmap_config"

Angelo G. Del Regno (1):
      mfd: qcom-spmi-pmic: Add support for PM/PMI8950

Bartosz Golaszewski (1):
      dt-bindings: mfd: max77650: Convert the binding document to yaml

Charles Keepax (3):
      mfd: wm8998: Remove some unused registers
      mfd: madera: Update DT binding document to support clock supplies
      mfd: madera: Add support for requesting the supply clocks

Daniel Schultz (1):
      mfd: rk808: Fix RK818 ID template

Dmitry Torokhov (1):
      mfd: arizona: Switch to using devm_gpiod_get()

Fabien Parent (1):
      mfd: mt6397: Use PLATFORM_DEVID_NONE macro instead of -1

Frank Wunderlich (1):
      mfd: mt6397: Fix probe after changing mt6397-core

Hans de Goede (1):
      mfd: intel_soc_pmic_crc: Add "cht_crystal_cove_pmic" cell to CHT cells

Heiko Stuebner (3):
      mfd: rk808: Fix RK817 powerkey integration
      mfd: rk808: Set RK817 interrupt polarity to low
      mfd: rk808: Use DEFINE_RES_IRQ for rk808 RTC alarm IRQ

Jarkko Nikula (1):
      mfd: intel-lpss: Add default I2C device properties for Gemini Lake

Jonathan Cameron (1):
      mfd: twl: Endian fixups in i2c write and read wrappers

Josef Friedl (6):
      dt-bindings: rtc: mediatek: add missing mt6397 rtc
      rtc: mt6397: move some common definitions into rtc.h
      rtc: mt6397: improvements of rtc driver
      rtc: mt6397: add compatible for mt6323
      power: reset: add driver for mt6323 poweroff
      MAINTAINERS: add Mediatek shutdown drivers

Lee Jones (15):
      Merge branches 'ib-mfd-doc-sparc-libdevres-5.5' and 'ib-mfd-power-rtc-5.5' into ibs-for-mfd-merged
      mfd: Provide MACRO to declare commonly defined MFD cell attributes
      mfd: ab8500: Example using new OF_MFD_CELL MACRO
      mfd: db8500-prcmu: Example using new OF_MFD_CELL/MFD_CELL_BASIC MACROs
      mfd: cs5535-mfd: Use PLATFORM_DEVID_* defines and tidy error message
      mfd: cs5535-mfd: Remove mfd_cell->id hack
      mfd: cs5535-mfd: Request shared IO regions centrally
      mfd: cs5535-mfd: Register clients using their own dedicated MFD cell entries
      mfd: mfd-core: Protect against NULL call-back function pointer
      mfd: mfd-core: Remove mfd_clone_cell()
      x86: olpc-xo1-pm: Remove invocation of MFD's .enable()/.disable() call-backs
      x86: olpc-xo1-sci: Remove invocation of MFD's .enable()/.disable() call-backs
      mfd: mfd-core: Remove usage counting for .{en,dis}able() call-backs
      mfd: mfd-core: Move pdev->mfd_cell creation back into mfd_add_device()
      mfd: mfd-core: Honour Device Tree's request to disable a child-device

Linus Walleij (1):
      mfd: db8500-prcmu: Support U8420-sysclk firmware

Markus Elfring (1):
      mfd: ipaq-micro: Use devm_platform_ioremap_resource() in micro_probe()

Matti Vaittinen (2):
      dt-bindings: mfd: max77693: Fix missing curly brace
      mfd: bd70528: Staticize bit value definitions

Thierry Reding (1):
      mfd: max77620: Do not allocate IRQs upfront

Tuowen Zhao (4):
      sparc64: implement ioremap_uc
      lib: devres: add a helper function for ioremap_uc
      mfd: intel-lpss: Use devm_ioremap_uc for MMIO
      docs: driver-model: add devm_ioremap_uc

Vignesh Raghavendra (1):
      mfd: ti_am335x_tscadc: Fix static checker warning

 Documentation/devicetree/bindings/mfd/madera.txt   |   8 ++
 Documentation/devicetree/bindings/mfd/max77650.txt |  46 -------
 .../devicetree/bindings/mfd/max77650.yaml          | 149 +++++++++++++++++++++
 Documentation/devicetree/bindings/mfd/max77693.txt |   1 +
 .../devicetree/bindings/mfd/qcom,spmi-pmic.txt     |   2 +
 .../devicetree/bindings/rtc/rtc-mt6397.txt         |  29 ++++
 Documentation/driver-api/driver-model/devres.rst   |   1 +
 MAINTAINERS                                        |   7 +
 arch/arm/mach-ux500/cpu-db8500.c                   |   2 +-
 arch/sparc/include/asm/io_64.h                     |   1 +
 arch/x86/platform/olpc/olpc-xo1-pm.c               |   8 --
 arch/x86/platform/olpc/olpc-xo1-sci.c              |   6 -
 drivers/mfd/ab8500-core.c                          | 138 ++++++-------------
 drivers/mfd/arizona-core.c                         |   6 +-
 drivers/mfd/cs5535-mfd.c                           | 108 +++++++--------
 drivers/mfd/db8500-prcmu.c                         |  84 +++++++-----
 drivers/mfd/intel-lpss-pci.c                       |  41 ++++--
 drivers/mfd/intel-lpss.c                           |   2 +-
 drivers/mfd/intel_soc_pmic_crc.c                   |   3 +
 drivers/mfd/ipaq-micro.c                           |   6 +-
 drivers/mfd/madera-core.c                          |  27 +++-
 drivers/mfd/max77620.c                             |   5 +-
 drivers/mfd/mfd-core.c                             | 118 ++++------------
 drivers/mfd/mt6397-core.c                          |  76 ++++++-----
 drivers/mfd/qcom-spmi-pmic.c                       |   4 +
 drivers/mfd/rk808.c                                |  22 +--
 drivers/mfd/rohm-bd70528.c                         |  17 ++-
 drivers/mfd/syscon.c                               |   1 -
 drivers/mfd/ti_am335x_tscadc.c                     |   2 +-
 drivers/mfd/wm8998-tables.c                        |  12 --
 drivers/power/reset/Kconfig                        |  10 ++
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/mt6323-poweroff.c              |  97 ++++++++++++++
 drivers/rtc/rtc-mt6397.c                           | 107 +++------------
 include/linux/io.h                                 |   2 +
 include/linux/mfd/arizona/registers.h              |   7 -
 include/linux/mfd/core.h                           |  49 ++++---
 include/linux/mfd/db8500-prcmu.h                   |   4 +-
 include/linux/mfd/dbx500-prcmu.h                   |   7 +-
 include/linux/mfd/madera/core.h                    |  11 ++
 include/linux/mfd/max77620.h                       |   1 -
 include/linux/mfd/mt6397/rtc.h                     |  71 ++++++++++
 include/linux/mfd/rk808.h                          |   2 +-
 include/linux/mfd/twl.h                            |  12 +-
 lib/devres.c                                       |  19 +++
 45 files changed, 770 insertions(+), 562 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/max77650.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/max77650.yaml
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
 create mode 100644 drivers/power/reset/mt6323-poweroff.c
 create mode 100644 include/linux/mfd/mt6397/rtc.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
