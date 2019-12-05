Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D853FC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 18:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E70420675
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 18:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="poq9slUM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbfLESFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 13:05:11 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:43958 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbfLESFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 13:05:11 -0500
Received: by mail-pj1-f68.google.com with SMTP id g4so1587344pjs.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 10:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v97x35mcpN8JQ3xNEjelWQZ7gcIwbkYh1aMgJhhWZpo=;
        b=poq9slUM5UFrWvspWWqsQ3Lsf9nfuNepIAWjbcyJJIxIHo1rlExOZnM9HC0dVOIvFQ
         brQQ9mxhT7n2oNzlIfxnV1cE+gW6rr3eudRp79uoNFJKQxJlhrnnwMMrUmaRrAMuluoW
         9A6MZNclwv+KZPuui7NwYZsYr/T/QPK/ObM6Isuh6MGvUh5h3VYx4FaYThwQyXMS5wOW
         hFu+/LPwkDS6XhIHYPYkLX45/kz8U7JPao/00mGgzkQbSUnpBZ8No0F85PLLz572RRh4
         A5RmeNZEdh6rC/4g2QoTi5pwYSBZTC0g9ZfGW36NrApHJWX3cgWEv2rjnQXm3SYNKyde
         bauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v97x35mcpN8JQ3xNEjelWQZ7gcIwbkYh1aMgJhhWZpo=;
        b=ek1g6sFfPLHO1aHbdzCKm+/O3kjyRTYlFQQ3+X5XqjpmIXHazYubGeYusTWfNsKQwM
         NY02pQTCYud5p0PHij5ri1WEExJ7KsrbE4YvmIgGLgXWxkYCziL47yH2Dh1eG5o9BChg
         SZwjHcntyheVZXZ2ae8EEE34WmRVIDV4QpSd6DQc89G68kEn2D7LfkpuAPP2eTo8sjO/
         JGA71NlpmUTeii+TBPwDnNkF/Y9Q/joxMyu0yic7hGkSmP70VqtGC67v2xKw952MQnGl
         CilfB8PY0HBrGXthL6xdGrIrGiSE2v0t5qM+W5rAvFe5o3ZUwpQqNMjfFNuJLRcfb7Od
         +mDg==
X-Gm-Message-State: APjAAAXbWmxNgOetHoEu7T+V24TP/ZxTSZdijya4kWGkBF+/rvasM+IF
        ADEWOaNXe/R4VRPOj4grNdF1PQ==
X-Google-Smtp-Source: APXvYqwu3nB0FGPlKtOCNzKkFM2Ty+s87nejfHhWpj1pojZVwTSYW/34PSqIRjkuCg3mWA77YqYbcg==
X-Received: by 2002:a17:902:700c:: with SMTP id y12mr10026365plk.227.1575569109861;
        Thu, 05 Dec 2019 10:05:09 -0800 (PST)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id s22sm386918pjr.5.2019.12.05.10.05.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Dec 2019 10:05:08 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        soc@kernel.org, arm@kernel.org, Olof Johansson <olof@lixom.net>
Subject: [GIT PULL 1/4] ARM: SoC platform updates
Date:   Thu,  5 Dec 2019 10:04:50 -0800
Message-Id: <20191205180453.14056-1-olof@lixom.net>
X-Mailer: git-send-email 2.22.GIT
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of these are for MMP (seeing a bunch of cleanups and refactorings
for the first time in a while), and for OMAP (a bunch of cleanups and
added support for voltage controller on OMAP4430).

Conflicts:

include/Kbuild: File deleted in mainline, just git rm here as well.

----------------------------------------------------------------

The following changes since commit 2f13437b8917627119d163d62f73e7a78a92303a:

  Merge tag 'trace-v5.5-2' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-soc

for you to fetch changes up to ab818f0999dc73af3f966194d087e9f6650f939f:

  Merge tag 'omap-for-v5.5/maintainers-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into arm/soc

----------------------------------------------------------------

Adam Ford (1):
      MAINTAINERS: Add logicpd-som-lv and logicpd-torpedo to OMAP TREE

Andreas Färber (2):
      MAINTAINERS: Add mailing list for Realtek SoCs
      arm64: realtek: Select reset controller

Andrey Smirnov (1):
      ARM: imx: Drop imx_anatop_usb_chrg_detect_disable()

Anson Huang (1):
      ARM: imx: Add serial number support for i.MX6/7 SoCs

Ben Dooks (6):
      ARM: bcm: include local platsmp.h for bcm2836_smp_ops
      ARM: bcm: fix missing __iomem in bcm_kona_smc.c
      ARM: OMAP2+: do not export am43xx_control functions
      ARM: OMAP2+: make dra7xx_sha0_hwmod static
      ARM: OMAP2+: prm44xx: make prm_{save,restore}_context static
      ARM: OMAP2+: make omap44xx_sha0_hwmod and omap44xx_l3_main_2__des static

Ben Dooks (Codethink) (1):
      OMAP2: fixup doc comments in omap_device

Dmitry Osipenko (2):
      ARM: tegra: Fix FLOW_CTLR_HALT register clobbering by tegra_resume()
      ARM: tegra: Use WFE for power-gating on Tegra30

Florian Fainelli (1):
      Merge tag 'tags/bcm2835-soc-next-2019-10-15' into soc/next

Geert Uytterhoeven (1):
      ARM: shmobile: rcar-gen2: Drop legacy DT clock support

Jonathan Neuschäfer (1):
      ARM: OMAP1: ams-delta FIQ: Fix a typo ("Initiaize")

Kefeng Wang (1):
      ARM: hisi: drop useless depend on ARCH_MULTI_V7

Krzysztof Kozlowski (2):
      ARM: s3c: Rename s3c64xx_spi_setname() function
      ARM: s3c: Rename s5p_usb_phy functions

Lubomir Rintel (10):
      ARM: l2c: add definition for FWA in PL310 aux register
      ARM: mmp: don't select CACHE_TAUROS2 on all ARCH_MMP
      ARM: mmp: map the PGU as well
      ARM: mmp: DT: convert timer driver to use TIMER_OF_DECLARE
      ARM: mmp: define MMP_CHIPID by the means of CIU_REG()
      ARM: mmp: add support for MMP3 SoC
      ARM: mmp: add SMP support
      ARM: mmp: move cputype.h to include/linux/soc/
      ARM: mmp: remove MMP3 USB PHY registers from regs-usb.h
      MAINTAINERS: mmp: add Git repository

Markus Elfring (1):
      ARM: OMAP2+: Add missing put_device() call in omapdss_init_of()

Mihaela Martinas (1):
      arm64: Introduce config for S32

Olof Johansson (11):
      Merge tag 'mmp-soc-for-v5.5-2' of git://git.kernel.org/.../lkundrak/linux-mmp into arm/soc
      Merge tag 'arm-soc/for-5.5/soc' of https://github.com/Broadcom/stblinux into arm/soc
      Merge tag 'omap-for-v5.5/soc-signed' of git://git.kernel.org/.../tmlind/linux-omap into arm/soc
      Merge tag 'realtek-arm64-soc-for-5.5' of git://git.kernel.org/.../afaerber/linux-realtek into arm/soc
      Merge tag 'hisi-armv7-soc-for-5.5' of git://github.com/hisilicon/linux-hisi into arm/soc
      Merge tag 'renesas-arm-soc-for-v5.5-tag1' of git://git.kernel.org/.../geert/renesas-devel into arm/soc
      Merge tag 'tegra-for-5.5-arm-core' of git://git.kernel.org/.../tegra/linux into arm/soc
      Merge tag 'samsung-soc-5.5' of https://git.kernel.org/.../krzk/linux into arm/soc
      Merge tag 'imx-soc-5.5' of git://git.kernel.org/.../shawnguo/linux into arm/soc
      Merge tag 'omap-for-v5.5/soc-late-signed' of git://git.kernel.org/.../tmlind/linux-omap into arm/soc
      Merge tag 'omap-for-v5.5/maintainers-signed' of git://git.kernel.org/.../tmlind/linux-omap into arm/soc

Sebastian Reichel (1):
      ARM: OMAP2+: pdata-quirks: drop TI_ST/KIM support

Stefan Agner (1):
      ARM: imx: use generic function to exit coherency

Stefan Wahren (1):
      ARM: bcm: Add support for BCM2711 SoC

Sylwester Nawrocki (1):
      ARM: exynos: Enable exynos-asv driver for ARCH_EXYNOS

Tao Ren (1):
      ARM: ASPEED: update default ARCH_NR_GPIO for ARCH_ASPEED

Tony Lindgren (14):
      ARM: OMAP2+: Remove unused wakeup_cpu
      ARM: OMAP2+: Drop bogus wkup domain oswr setting
      ARM: OMAP2+: Remove bogus warnings for machines without twl PMIC
      ARM: OMAP2+: Update 4430 voltage controller operating points
      ARM: OMAP2+: Configure voltage controller for cpcap
      ARM: OMAP2+: Allow per oswr for omap4
      ARM: OMAP2+: Allow core oswr for omap4
      ARM: OMAP2+: Initialize voltage controller for omap4
      ARM: OMAP2+: Drop unused enable_wakeup and disable_wakeup
      ARM: OMAP2+: Simplify code for clkdm_clock_enable and disable
      ARM: OMAP2+: Configure voltage controller for retention
      ARM: OMAP2+: Configure voltage controller for cpcap to low-speed
      Merge branch 'omap-for-v5.5/pm' into omap-for-v5.5/soc
      Merge branch 'omap-for-v5.5/omap1' into omap-for-v5.5/soc

Uwe Kleine-König (1):
      ARM: OMAP1: drop duplicated dependency on ARCH_OMAP1

YueHaibing (2):
      ARM: OMAP2+: Make some functions static
      ARM: OMAP2+: Remove duplicated include from pmic-cpcap.c


 MAINTAINERS                                     |   5 +
 arch/arm/Kconfig                                |   2 +-
 arch/arm/include/asm/hardware/cache-l2x0.h      |   2 +
 arch/arm/mach-bcm/Kconfig                       |   4 +-
 arch/arm/mach-bcm/Makefile                      |   3 +-
 arch/arm/mach-bcm/bcm2711.c                     |  24 ++
 arch/arm/mach-bcm/bcm_kona_smc.c                |   2 +-
 arch/arm/mach-bcm/platsmp.c                     |   2 +
 arch/arm/mach-exynos/Kconfig                    |   1 +
 arch/arm/mach-hisi/Kconfig                      |  16 +-
 arch/arm/mach-imx/anatop.c                      |  20 +-
 arch/arm/mach-imx/cpu.c                         |  38 ++-
 arch/arm/mach-imx/hotplug.c                     |  24 +-
 arch/arm/mach-mmp/Kconfig                       |  22 +-
 arch/arm/mach-mmp/Makefile                      |   4 +
 arch/arm/mach-mmp/addr-map.h                    |   7 +
 arch/arm/mach-mmp/common.c                      |  19 +-
 arch/arm/mach-mmp/common.h                      |   1 +
 arch/arm/mach-mmp/devices.c                     |   2 +-
 arch/arm/mach-mmp/mmp-dt.c                      |   5 +-
 arch/arm/mach-mmp/mmp2-dt.c                     |   7 +-
 arch/arm/mach-mmp/mmp2.c                        |   2 +-
 arch/arm/mach-mmp/mmp3.c                        |  29 ++
 arch/arm/mach-mmp/platsmp.c                     |  32 +++
 arch/arm/mach-mmp/pm-mmp2.c                     |   2 +-
 arch/arm/mach-mmp/pm-pxa910.c                   |   2 +-
 arch/arm/mach-mmp/pxa168.c                      |   2 +-
 arch/arm/mach-mmp/pxa910.c                      |   2 +-
 arch/arm/mach-mmp/regs-usb.h                    |  94 -------
 arch/arm/mach-mmp/time.c                        |  43 +--
 arch/arm/mach-omap1/Kconfig                     |  33 +--
 arch/arm/mach-omap1/ams-delta-fiq.c             |   2 +-
 arch/arm/mach-omap2/Makefile                    |   5 +
 arch/arm/mach-omap2/clockdomain.c               |  78 ++----
 arch/arm/mach-omap2/control.c                   |   4 +-
 arch/arm/mach-omap2/control.h                   |   1 +
 arch/arm/mach-omap2/display.c                   |   1 +
 arch/arm/mach-omap2/omap-mpuss-lowpower.c       |   2 -
 arch/arm/mach-omap2/omap_device.c               |  19 +-
 arch/arm/mach-omap2/omap_hwmod.c                |  97 -------
 arch/arm/mach-omap2/omap_hwmod.h                |   3 -
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c      |   4 +-
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c       |   2 +-
 arch/arm/mach-omap2/omap_twl.c                  |   8 +-
 arch/arm/mach-omap2/opp4xxx_data.c              |  16 +-
 arch/arm/mach-omap2/pdata-quirks.c              |  52 ----
 arch/arm/mach-omap2/pm.c                        |   1 +
 arch/arm/mach-omap2/pm.h                        |  14 +
 arch/arm/mach-omap2/pm44xx.c                    |  13 +-
 arch/arm/mach-omap2/pmic-cpcap.c                | 271 +++++++++++++++++++
 arch/arm/mach-omap2/prm44xx.c                   |   4 +-
 arch/arm/mach-omap2/vc.c                        |  57 +++-
 arch/arm/mach-omap2/vc.h                        |   2 +-
 arch/arm/mach-s3c24xx/s3c2416.c                 |   2 +-
 arch/arm/mach-s3c24xx/s3c2443.c                 |   2 +-
 arch/arm/mach-s3c24xx/spi-core.h                |   2 +-
 arch/arm/mach-s3c64xx/setup-usb-phy.c           |   4 +-
 arch/arm/mach-shmobile/setup-rcar-gen2.c        |   1 -
 arch/arm/mach-tegra/reset-handler.S             |   6 +-
 arch/arm/mach-tegra/sleep-tegra30.S             |   4 +-
 arch/arm/mm/Kconfig                             |   2 +-
 arch/arm/plat-samsung/devs.c                    |   4 +-
 arch/arm/plat-samsung/include/plat/usb-phy.h    |   4 +-
 arch/arm64/Kconfig.platforms                    |  11 +-
 drivers/clk/Kconfig                             |   5 +
 drivers/clk/mmp/Makefile                        |   2 +-
 drivers/soc/tegra/flowctrl.c                    |  19 +-
 .../linux/soc/mmp}/cputype.h                    |  27 ++
 68 files changed, 708 insertions(+), 494 deletions(-)
 create mode 100644 arch/arm/mach-bcm/bcm2711.c
 create mode 100644 arch/arm/mach-mmp/mmp3.c
 create mode 100644 arch/arm/mach-mmp/platsmp.c
 create mode 100644 arch/arm/mach-omap2/pmic-cpcap.c
 rename {arch/arm/mach-mmp => include/linux/soc/mmp}/cputype.h (71%)
