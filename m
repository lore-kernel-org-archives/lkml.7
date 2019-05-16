Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14144C04E87
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 06:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C51582082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 06:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="KSFrgJ/v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfEPGng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 02:43:36 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39773 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbfEPGnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 02:43:33 -0400
Received: by mail-pg1-f196.google.com with SMTP id w22so1052292pgi.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 23:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eudT3vsEM795Lbvjs0cdxoXjtBI0kzUE/FC72SqRuXQ=;
        b=KSFrgJ/vykPmhSCJx9obevBCsHBFm4ILVS7YNKaLbyXwimysIw0BI0I7Rt3ZKMkQUg
         M5E9NsoZ+8Xq2fbIM1EVkcH7gIkpuTJKdDHW081EH8cgvRLsJ6pOx0vCHcZ+skoeGG0G
         eMOJ1B8wVQiZOhS4HBhbovasEVOE/IOB7iKvwFF07cunVKnzeC5Gp1BOjq73rzIwfiKi
         RtpjgarEEmUnUmWU7DwwYBst08eUDK8A9JMWvKJZE0npza57yJILZZFFm7GM+aumz3D3
         elaFwbTL6gat9I+oMXI6sfhgl5558dAfyhz+2KzUDihpSwX0zV9zuZiBGo3TXzeu+Plc
         b6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eudT3vsEM795Lbvjs0cdxoXjtBI0kzUE/FC72SqRuXQ=;
        b=BYPqxYekOOtsAqr7EoORkfCLCTqcbyPL+6iyCxUJvoEhptr+df0wQmHn2090Y+ZeHM
         GzQfyIE/HD4g6ENVCyIEVj928WFPhkD6LW8cv0C5JEDdu7KdlmXQknOd6pNMRzKNio9e
         Xa6UAnnpxjtGKfpVp1SluYggkBwEg8jnHa723oC+THHxtBYb1pLiU+hx/CHzzfycGGTs
         q0eBz+GaRrIdcn7xoYS7Vs1RwF8mMkvQONlnTlLpVpW52FP+LJcRoK+CzeMTdOu5VYHc
         xZEnh2bhZg1amJDuIBDeZNW1iUXdNkU5H3+tDBbtxP+1yoQ8jBaO4WRWxdMLkPWsejum
         HzRw==
X-Gm-Message-State: APjAAAV3yumOjyGU0Fvgzmoe9hel2/KjsKHDR2AGTKlOsZW/ud5oqIf2
        Zoi70tlBgaj3ykmu6wqsevzUa+jdOuQ=
X-Google-Smtp-Source: APXvYqzhKUeXoLNL8f6Wi4ZWAEG3AE1zzWc/iu9E6e2wzBK/qhh6vUyp7Rx0zC1/23R2f0ypFSqiNQ==
X-Received: by 2002:a65:56cb:: with SMTP id w11mr28607830pgs.236.1557989012737;
        Wed, 15 May 2019 23:43:32 -0700 (PDT)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id w194sm11196050pfd.56.2019.05.15.23.43.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 23:43:31 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     arm@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Olof Johansson <olof@lixom.net>
Subject: [GIT PULL 3/4] ARM: SoC-related driver updates
Date:   Wed, 15 May 2019 23:43:03 -0700
Message-Id: <20190516064304.24057-4-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190516064304.24057-1-olof@lixom.net>
References: <20190516064304.24057-1-olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various driver updates for platforms and a couple of the small driver
subsystems we merge through our tree:

Among the larger pieces:

- Power management improvements for TI am335x and am437x (RTC suspend/wake)
- Misc new additions for Amlogic (socinfo updates)
- ZynqMP FPGA manager
- Nvidia improvements for reset/powergate handling
- PMIC wrapper for Mediatek MT8516
- Misc fixes/improvements for ARM SCMI, TEE, NXP i.MX SCU drivers

Conflicts:

drivers/misc/{Makefile,Kconfig} (Move/Add):
 - Remove ASPEED_LPC* entries, keep the P2A_CTRL ones.

drivers/rtc: (Change/Change):
 - Keep the HEAD person of conflict, code was refactored to not need
   return checking on tm2bcd() call.

----------------------------------------------------------------

The following changes since commit 6254d0b7c3d30694a230c6885a7f11534fb2da3f:

  Merge tag 'armsoc-dt' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-drivers

for you to fetch changes up to 80d0c649244253d8cb3ba32d708c1431e7ac8fbf:

  soc: aspeed: fix Kconfig

----------------------------------------------------------------

Abel Vesa (1):
      soc: imx: Add generic i.MX8 SoC driver

Aditya Pakki (1):
      firmware: arm_scmi: replace of_match_device->data with of_device_get_match_data()

Aisheng Dong (3):
      firmware: imx: scu-pd: use bool to set postfix
      firmware: imx: scu-pd: add specifying the base of domain name index support
      firmware: imx: scu-pd: decouple the SS information from domain names

Andrey Smirnov (1):
      soc: imx: gpcv2: Make use of regmap_read_poll_timeout()

Andy Gross (1):
      MAINTAINERS: Update email for Qualcomm SoC maintainer

Ankit Jain (1):
      soc: qcom: rmtfs: Add support for mmap functionality

Anson Huang (3):
      soc: imx: gpc: use devm_platform_ioremap_resource() to simplify code
      soc: imx: gpcv2: use devm_platform_ioremap_resource() to simplify code
      firmware: imx: enable imx scu general irq function

Chris Lew (1):
      soc: qcom: qmi: Change txn wait to non-interruptible

Dan Carpenter (1):
      soc: qcom: cmd-db: Fix an error code in cmd_db_dev_probe()

Dave Gerlach (2):
      memory: ti-emif-sram: Add ti_emif_run_hw_leveling for DDR3 hardware leveling
      ARM: OMAP2+: sleep43xx: Run EMIF HW leveling on resume path

Dmitry Osipenko (5):
      ARM: tegra: cpuidle: Handle tick broadcasting within cpuidle core on Tegra20/30
      memory: tegra: Fix missed registers values latching
      memory: tegra: Fix integer overflow on tick value calculation
      memory: tegra: Replace readl-writel with mc_readl-mc_writel
      Revert "ARM: tegra: Restore memory arbitration on resume from LP1 on Tegra30+"

Douglas Anderson (1):
      soc: rockchip: Set the proper PWM for rk3288

Edward Cragg (1):
      memory: tegra: Fix a typos for "fdcdwr2" mc client

Fabien Parent (3):
      dt-bindings: pwrap: mediatek: add pwrap support for MT8516
      soc: mediatek: pwrap: add missing check on rstc
      soc: mediatek: pwrap: add support for MT8516 pwrap

Jann Horn (1):
      firmware: xilinx: fix debugfs write handler

Jon Hunter (3):
      soc/tegra: pmc: Fix reset sources and levels
      soc/tegra: pmc: Remove reset sysfs entries on error
      soc/tegra: pmc: Move powergate initialisation to probe

Julia Lawall (1):
      meson-gx-socinfo: add missing of_node_put after of_device_is_available

Keerthy (4):
      rtc: OMAP: Add support for rtc-only mode
      ARM: OMAP2+: pm33xx: Add support for rtc+ddr in self refresh mode
      soc: ti: pm33xx: Move the am33xx_push_sram_idle to the top
      soc: ti: pm33xx: AM437X: Add rtc_only with ddr in self-refresh support

Maulik Shah (1):
      drivers: soc: qcom: rpmh-rsc: Correct check for slot number

Nathan Chancellor (1):
      soc: mediatek: pwrap: Zero initialize rdata in pwrap_init_cipher

Nava kishore Manne (3):
      firmware: xilinx: Add fpga API's
      dt-bindings: fpga: Add bindings for ZynqMP fpga driver
      fpga manager: Adding FPGA Manager support for Xilinx zynqmp

Neil Armstrong (4):
      soc: amlogic: gx-socinfo: Add mask for each SoC packages
      soc: amlogic: gx-socinfo: Add new SoC IDs and Packages IDs
      soc: amlogic: meson-gx-pwrc-vpu: Fix power on/off register bitmask
      soc: amlogic: meson-gx-pwrc-vpu: Add support for G12A

Olof Johansson (18):
      Merge tag 'amlogic-drivers' of https://git.kernel.org/.../khilman/linux-amlogic into arm/drivers
      Merge tag 'omap-for-v5.2/am4-pm-v2-signed' of git://git.kernel.org/.../tmlind/linux-omap into arm/drivers
      Merge tag 'zynqmp-soc-for-v5.2' of https://github.com/Xilinx/linux-xlnx into arm/drivers
      Merge tag 'scmi-fixes-5.2' of git://git.kernel.org/.../sudeep.holla/linux into arm/drivers
      Merge tag 'tee-optee-for-5.2' of http://git.linaro.org:/people/jens.wiklander/linux-tee into arm/drivers
      Merge tag 'tegra-for-5.2-bus' of git://git.kernel.org/.../tegra/linux into arm/drivers
      Merge tag 'tegra-for-5.2-soc' of git://git.kernel.org/.../tegra/linux into arm/drivers
      Merge tag 'tegra-for-5.2-memory' of git://git.kernel.org/.../tegra/linux into arm/drivers
      Merge tag 'tegra-for-5.2-arm-soc' of git://git.kernel.org/.../tegra/linux into arm/drivers
      Merge tag 'renesas-drivers-for-v5.2' of https://git.kernel.org/.../horms/renesas into arm/drivers
      Merge tag 'amlogic-drivers-2' of https://git.kernel.org/.../khilman/linux-amlogic into arm/drivers
      spi: zynqmp: Fix build break
      Merge tag 'imx-drivers-5.2' of git://git.kernel.org/.../shawnguo/linux into arm/drivers
      Merge tag 'qcom-drivers-for-5.2' of git://git.kernel.org/.../agross/linux into arm/drivers
      Merge tag 'v5.1-next-soc' of https://git.kernel.org/.../matthias.bgg/linux into arm/drivers
      Merge tag 'reset-for-5.2' of git://git.pengutronix.de/pza/linux into arm/drivers
      Merge tag 'v5.2-rockchip-drivers-1' of git://git.kernel.org/.../mmind/linux-rockchip into arm/drivers
      soc: aspeed: fix Kconfig

Patrick Venture (1):
      soc: add aspeed folder and misc drivers

Rajan Vaja (1):
      drivers: Defer probe if firmware is not ready

Randy Dunlap (1):
      reset: fix linux/reset.h errors

Sameer Pujar (3):
      ARM: tegra: enforce PM requirement
      bus: tegra-aconnect: use devm_clk_*() helpers
      bus: tegra-aconnect: add system sleep callbacks

Steven Price (1):
      firmware: arm_scmi: fix of_node leak in scmi_mailbox_check

Takeshi Kihara (1):
      soc: renesas: Identify R-Car M3-W ES1.3

Thierry Reding (3):
      Merge branch 'reset/acquire' of git://git.pengutronix.de/git/pza/linux into for-5.2/soc
      soc/tegra: pmc: Implement acquire/release for resets
      memory: tegra: Properly spell "tegra"

Tony Lindgren (1):
      Merge branch 'omap-for-v5.2/am4-ddr3' into omap-for-v5.2/am4-pm-v2

Volodymyr Babchuk (1):
      optee: allow to work without static shared memory

Yue Haibing (1):
      memory: tegra: Make terga20_mc_reset_ops static


 .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt     |  25 ++
 .../devicetree/bindings/soc/mediatek/pwrap.txt  |   1 +
 Documentation/xilinx/eemi.txt                   |   4 +-
 MAINTAINERS                                     |   2 +-
 arch/arm/mach-omap2/pm33xx-core.c               |  76 +++++-
 arch/arm/mach-omap2/sleep43xx.S                 |   3 +
 arch/arm/mach-tegra/Kconfig                     |   1 +
 arch/arm/mach-tegra/cpuidle-tegra20.c           |  11 +-
 arch/arm/mach-tegra/cpuidle-tegra30.c           |   9 +-
 arch/arm/mach-tegra/iomap.h                     |   9 -
 arch/arm/mach-tegra/sleep-tegra30.S             |  21 --
 drivers/bus/tegra-aconnect.c                    |  66 +++--
 drivers/clk/zynqmp/clkc.c                       |   4 +-
 drivers/firmware/arm_scmi/driver.c              |   8 +-
 drivers/firmware/imx/Makefile                   |   2 +-
 drivers/firmware/imx/imx-scu-irq.c              | 168 ++++++++++++
 drivers/firmware/imx/imx-scu.c                  |   6 +
 drivers/firmware/imx/scu-pd.c                   | 121 ++++----
 drivers/firmware/xilinx/zynqmp-debug.c          |  18 +-
 drivers/firmware/xilinx/zynqmp.c                |  56 +++-
 drivers/fpga/Kconfig                            |   9 +
 drivers/fpga/Makefile                           |   1 +
 drivers/fpga/zynqmp-fpga.c                      | 159 +++++++++++
 drivers/memory/emif.h                           |   4 +
 drivers/memory/tegra/mc.c                       |  34 ++-
 drivers/memory/tegra/mc.h                       |   2 +-
 drivers/memory/tegra/tegra114.c                 |   4 +-
 drivers/memory/tegra/tegra124.c                 |   4 +-
 drivers/memory/tegra/tegra20.c                  |  28 +-
 drivers/memory/tegra/tegra210.c                 |   2 +-
 drivers/memory/tegra/tegra30.c                  |   4 +-
 drivers/memory/ti-emif-pm.c                     |   3 +
 drivers/memory/ti-emif-sram-pm.S                |  41 +++
 drivers/misc/Kconfig                            |  16 --
 drivers/misc/Makefile                           |   2 -
 drivers/nvmem/zynqmp_nvmem.c                    |  10 +-
 drivers/reset/reset-zynqmp.c                    |   8 +-
 drivers/rtc/rtc-omap.c                          |  49 +++-
 drivers/soc/Kconfig                             |   1 +
 drivers/soc/Makefile                            |   1 +
 drivers/soc/amlogic/meson-gx-pwrc-vpu.c         | 160 +++++++++--
 drivers/soc/amlogic/meson-gx-socinfo.c          |  43 +--
 drivers/soc/aspeed/Kconfig                      |  20 ++
 drivers/soc/aspeed/Makefile                     |   2 +
 drivers/{misc => soc/aspeed}/aspeed-lpc-ctrl.c  |   0
 drivers/{misc => soc/aspeed}/aspeed-lpc-snoop.c |   0
 drivers/soc/imx/Makefile                        |   1 +
 drivers/soc/imx/gpc.c                           |   4 +-
 drivers/soc/imx/gpcv2.c                         |  43 +--
 drivers/soc/imx/soc-imx8.c                      | 115 ++++++++
 drivers/soc/mediatek/mtk-pmic-wrap.c            | 111 +++++++-
 drivers/soc/qcom/cmd-db.c                       |   4 +-
 drivers/soc/qcom/qmi_interface.c                |   7 +-
 drivers/soc/qcom/rmtfs_mem.c                    |  21 ++
 drivers/soc/qcom/rpmh-rsc.c                     |   2 +-
 drivers/soc/renesas/renesas-soc.c               |   3 +
 drivers/soc/rockchip/grf.c                      |   2 +
 drivers/soc/tegra/pmc.c                         | 171 +++++++++---
 drivers/soc/ti/Kconfig                          |   5 +-
 drivers/soc/ti/pm33xx.c                         | 273 +++++++++++++++----
 drivers/soc/xilinx/zynqmp_pm_domains.c          |  18 +-
 drivers/soc/xilinx/zynqmp_power.c               |  10 +-
 drivers/spi/spi-zynqmp-gqspi.c                  |   6 +
 drivers/tee/optee/core.c                        |  80 +++---
 include/linux/firmware/imx/sci.h                |   5 +
 include/linux/firmware/xlnx-zynqmp.h            |  14 +-
 include/linux/platform_data/pm33xx.h            |   5 +
 include/linux/reset.h                           |   2 +
 include/linux/rtc/rtc-omap.h                    |   7 +
 include/linux/ti-emif-sram.h                    |   3 +
 70 files changed, 1705 insertions(+), 425 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
 create mode 100644 drivers/firmware/imx/imx-scu-irq.c
 create mode 100644 drivers/fpga/zynqmp-fpga.c
 create mode 100644 drivers/soc/aspeed/Kconfig
 create mode 100644 drivers/soc/aspeed/Makefile
 rename drivers/{misc => soc/aspeed}/aspeed-lpc-ctrl.c (100%)
 rename drivers/{misc => soc/aspeed}/aspeed-lpc-snoop.c (100%)
 create mode 100644 drivers/soc/imx/soc-imx8.c
 create mode 100644 include/linux/rtc/rtc-omap.h
