Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E717C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 18:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95B72464E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 18:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="tD2M7TNf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730347AbfLESFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 13:05:15 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41598 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbfLESFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 13:05:13 -0500
Received: by mail-pf1-f196.google.com with SMTP id s18so1960955pfd.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 10:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wnx8aWFPrdZWJZChkqkTTs9tF6XG+P/6HVuY6YT0MRU=;
        b=tD2M7TNfnbyfVPQALlAdrBpqv5t52tq4bBD89QgBrM7wLdUcYI/1NrXe8pYeaHkA6M
         Qg8lJY5Mkaxbsy/J5nHrofQbP0LoBU803ar7U/JtHUJYkVMpbSjzFz7yNSuz1Ywp9Z4A
         2w6MNeH6YUeku3yvyDxhqkURrZPG9rvpWaTMGAVpLbD185M3zJ2j/Weez5Ryf530gc0n
         IFiH4rQ/OkBz+TYQqOQweBxwawwasjSTPhKMBFoBh0xidYAM/zWJdz9zVWZgY8ebHsXd
         keeQbb6m3cDhtgHQ4OJczQwaTJa7ceA7xDGhzpuHhYZ4KYfF23Q8m8sc/K602U93/m4y
         zmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wnx8aWFPrdZWJZChkqkTTs9tF6XG+P/6HVuY6YT0MRU=;
        b=l2fuaQcVHk5cxPh01cudAu3pfe8VYD9AtiGtkWBOi8zgHapQjH3u8oN2mHrKhLwQ1g
         mvBbbwd7JRdsbLFvKyUcsdh9evIpzAm+b/gWkBWQdgLGEQ2woQ9K90+rqr4BmBCk//od
         X/DjxY2fQvMsm/iG5AySRxTNIE1g/NYIRPuMTBtU3b5q4B9hx6a1k2v1x6+igkzcxD/e
         JAuZRtMPgJfXTisGmaaMWfttomaVDvceSgHp1e9/cSRwqF0KIG/ZKJatnk/nTHWxrOed
         fCmPgi0iEafOMKbvBgRycrx+kbzUPb8PpjWmP77VBlQ7n49bNM2YBibPFdUClxx6gQs5
         TubA==
X-Gm-Message-State: APjAAAUTTV6hfxnWNQG5mI18cRNMxsU2DoAka+JWDHJPJuQkvNLm7nlr
        Z6Ck98e28RhHVBUDtIR53RwmMg==
X-Google-Smtp-Source: APXvYqzGbHYRL7CJ0Ga9/+jWoC95yB5uVapEgVqmZSc+1m1XAr5HrQ1n2q8XPlg2O+doMsU2BdtL+w==
X-Received: by 2002:a63:1f16:: with SMTP id f22mr10225135pgf.2.1575569112047;
        Thu, 05 Dec 2019 10:05:12 -0800 (PST)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id s22sm386918pjr.5.2019.12.05.10.05.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Dec 2019 10:05:10 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        soc@kernel.org, arm@kernel.org, Olof Johansson <olof@lixom.net>
Subject: [GIT PULL 2/4] ARM: SoC-related driver updates
Date:   Thu,  5 Dec 2019 10:04:51 -0800
Message-Id: <20191205180453.14056-2-olof@lixom.net>
X-Mailer: git-send-email 2.22.GIT
In-Reply-To: <20191205180453.14056-1-olof@lixom.net>
References: <20191205180453.14056-1-olof@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various driver updates for platforms:

- A larger set of work on Tegra 2/3 around memory controller and
regulator features, some fuse cleanups, etc..

- MMP platform drivers, in particular for USB PHY, and other smaller
additions.

- Samsung Exynos 5422 driver for DMC (dynamic memory configuration),
and ASV (adaptive voltage), allowing the platform to run at more
optimal operating points.

- Misc refactorings and support for RZ/G2N and R8A774B1 from Renesas

- Clock/reset control driver for TI/OMAP

- Meson-A1 reset controller support

- Qualcomm sdm845 and sda845 SoC IDs for socinfo


Conflicts: None

----------------------------------------------------------------

The following changes since commit 1334a11c1c6f3e5603acfc8d39215110e3087d64:

  Merge tag 'armsoc-soc' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-drivers

for you to fetch changes up to 3f6939aec712a15152c32516c1c543a91ac1e717:

  Merge tag 'scmi-fix-5.5' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into arm/drivers

----------------------------------------------------------------

Andreas Färber (2):
      reset: simple: Keep alphabetical order
      reset: simple: Add Realtek RTD1195/RTD1295

Andy Shevchenko (2):
      firmware: meson_sm: use %*ph to print small buffer
      reset: Remove copy'n'paste redundancy in the comments

Angelo G. Del Regno (2):
      soc: qcom: smd-rpm: Add MSM8976 compatible
      dt-bindings: power: Add missing rpmpd smd performance level

AngeloGioacchino Del Regno (1):
      soc: qcom: rpmpd: Add rpm power domains for msm8976

Anson Huang (3):
      firmware: imx: Skip return value check for some special SCU firmware APIs
      soc: imx8: Using existing serial_number instead of UID
      soc: imx-scu: Using existing serial_number instead of UID

Ben Dooks (Codethink) (1):
      firmware: imx: add missing include of <linux/firmware/imx/sci.h>

Biju Das (4):
      soc: renesas: Add Renesas R8A774B1 config option
      soc: renesas: Identify RZ/G2N
      soc: renesas: rcar-rst: Add support for RZ/G2N
      soc: renesas: rcar-sysc: Add r8a774b1 support

Bjorn Andersson (1):
      MAINTAINERS: Add myself as co-maintainer for QCOM

Carlo Caione (3):
      firmware: meson_sm: Mark chip struct as static const
      nvmem: meson-efuse: bindings: Add secure-monitor phandle
      firmware: meson_sm: Rework driver as a proper platform driver

Christian Hewitt (2):
      soc: amlogic: meson-gx-socinfo: Add S905X3 ID for VIM3L
      soc: amlogic: meson-gx-socinfo: Fix S905D3 ID for VIM3L

Colin Ian King (1):
      memory: samsung: exynos5422-dmc: Fix spelling mistake "counld" -> "could"

Dan Carpenter (1):
      soc: samsung: exynos-asv: Potential NULL dereference in exynos_asv_update_opps()

Daniel Baluta (1):
      firmware: imx: Remove call to devm_of_platform_populate

Dinh Nguyen (1):
      reset: build simple reset controller driver for Agilex

Dmitry Osipenko (14):
      soc/tegra: regulators: Add regulators coupler for Tegra20
      soc/tegra: regulators: Add regulators coupler for Tegra30
      soc/tegra: pmc: Query PCLK clock rate at probe time
      soc/tegra: pmc: Remove unnecessary memory barrier
      memory: tegra: Don't set EMC rate to maximum on probe for Tegra20
      memory: tegra: Adapt for Tegra20 clock driver changes
      memory: tegra: Include io.h instead of iopoll.h
      memory: tegra: Pre-configure debug register on Tegra20
      memory: tegra: Print a brief info message about EMC timings
      memory: tegra: Increase handshake timeout on Tegra20
      memory: tegra: Do not handle error from wait_for_completion_timeout()
      memory: tegra: Introduce Tegra30 EMC driver
      memory: tegra: Ensure timing control debug features are disabled
      memory: tegra: Consolidate registers definition into common header

Florian Fainelli (2):
      memory: brcmstb: dpfe: Compute checksum at __send_command() time
      memory: brcmstb: dpfe: Fixup API version/commands for 7211

Geert Uytterhoeven (17):
      soc: renesas: rcar-sysc: Prepare for fixing power request conflicts
      soc: renesas: r8a7795-sysc: Fix power request conflicts
      soc: renesas: r8a7796-sysc: Fix power request conflicts
      soc: renesas: r8a77965-sysc: Fix power request conflicts
      soc: renesas: r8a77970-sysc: Fix power request conflicts
      soc: renesas: r8a77980-sysc: Fix power request conflicts
      soc: renesas: r8a77990-sysc: Fix power request conflicts
      soc: renesas: r8a774c0-sysc: Fix power request conflicts
      soc: renesas: rcar-sysc: Remove unneeded inclusion of <linux/bug.h>
      soc: renesas: Add missing check for non-zero product register address
      Merge tag 'renesas-r8a77961-dt-binding-defs-tag' into renesas-drivers-for-v5.5
      soc: renesas: Rename SYSC_R8A7796 to SYSC_R8A77960
      soc: renesas: Add ARCH_R8A77960 for existing R-Car M3-W
      soc: renesas: Add ARCH_R8A77961 for new R-Car M3-W+
      soc: renesas: Identify R-Car M3-W+
      soc: renesas: rcar-rst: Add R8A77961 support
      soc: renesas: rcar-sysc: Add R8A77961 support

Georgi Djakov (1):
      soc: qcom: smd-rpm: Create RPM interconnect proxy child device

Jerome Brunet (2):
      reset: dt-bindings: meson: update arb bindings for sm1
      reset: meson-audio-arb: add sm1 support

Jianxin Pan (1):
      soc: amlogic: meson-gx-socinfo: Add A1 and A113L IDs

John Garry (5):
      lib: logic_pio: Enforce LOGIC_PIO_INDIRECT region ops are set at registration
      logic_pio: Define PIO_INDIRECT_SIZE for !CONFIG_INDIRECT_PIO
      bus: hisi_lpc: Clean some types
      bus: hisi_lpc: Expand build test coverage
      logic_pio: Build into a library

Jolly Shah (2):
      dt-bindings: firmware: Add bindings for Versal firmware
      firmware: xilinx: Add support for versal soc

Kamel Bouhara (1):
      soc: at91: Add Atmel SFR SN (Serial Number) support

Krzysztof Kozlowski (1):
      Merge tag 'opp-5.4-support-adjust-voltages' of https://git.kernel.org/.../vireshk/pm into next/drivers

Kunihiko Hayashi (1):
      reset: uniphier-glue: Add Pro5 USB3 support

Leonard Crestez (2):
      firmware: imx: warn on unexpected RX
      soc: imx8mq: Read SOC revision from TF-A

Lubomir Rintel (2):
      phy: Add USB2 PHY driver for Marvell MMP3 SoC
      MAINTAINERS: phy: add entry for USB PHY drivers on MMP SoCs

Lukasz Luba (4):
      memory: Extend of_memory with LPDDR3 support
      memory: Add DMC driver for Exynos5422
      memory: samsung: exynos5422-dmc: Fix kfree() of devm-allocated memory and missing static
      memory: samsung: exynos5422-dmc: Add support for interrupt from performance counters

Markus Mayer (6):
      memory: brcmstb: dpfe: rename struct private_data
      memory: brcmstb: dpfe: initialize priv->dev
      memory: brcmstb: dpfe: add locking around DCPU enable/disable
      memory: brcmstb: dpfe: move init_data into brcmstb_dpfe_download_firmware()
      memory: brcmstb: dpfe: pass *priv as argument to brcmstb_dpfe_download_firmware()
      memory: brcmstb: dpfe: support for deferred firmware download

Nagarjuna Kristam (1):
      soc/tegra: fuse: Add FUSE clock check in tegra_fuse_readl()

Nicolas Ferre (1):
      ARM: at91: Documentation: update the sama5d3 and armv7m datasheets

Olof Johansson (22):
      Merge tag 'renesas-drivers-for-v5.5-tag1' of git://git.kernel.org/.../geert/renesas-devel into arm/drivers
      Merge tag 'samsung-drivers-dmc-5.5' of https://git.kernel.org/.../krzk/linux into arm/drivers
      Merge tag 'mmp-drivers-for-v5.5' of git://git.kernel.org/.../lkundrak/linux-mmp into arm/drivers
      soc: mmp: guard include of asm/cputype.h with CONFIG_ARM{,64}
      Merge tag 'omap-for-v5.5/ti-sysc-signed' of git://git.kernel.org/.../tmlind/linux-omap into arm/drivers
      Merge tag 'arm-soc/for-5.5/drivers' of https://github.com/Broadcom/stblinux into arm/drivers
      Merge tag 'reset-for-v5.5' of git://git.pengutronix.de/git/pza/linux into arm/drivers
      Merge branch 'for_5.5/driver-soc' of git://git.kernel.org/.../ssantosh/linux-keystone into arm/drivers
      Merge tag 'renesas-drivers-for-v5.5-tag2' of git://git.kernel.org/.../geert/renesas-devel into arm/drivers
      Merge tag 'tegra-for-5.5-firmware' of git://git.kernel.org/.../tegra/linux into arm/drivers
      Merge tag 'tegra-for-5.5-soc' of git://git.kernel.org/.../tegra/linux into arm/drivers
      Merge tag 'samsung-drivers-5.5' of https://git.kernel.org/.../krzk/linux into arm/drivers
      Merge tag 'imx-drivers-5.5' of git://git.kernel.org/.../shawnguo/linux into arm/drivers
      Merge tag 'qcom-drivers-for-5.5' of git://git.kernel.org/.../qcom/linux into arm/drivers
      Merge tag 'zynqmp-soc-for-v5.5' of https://github.com/Xilinx/linux-xlnx into arm/drivers
      Merge tag 'at91-5.5-drivers' of git://git.kernel.org/.../at91/linux into arm/drivers
      Merge tag 'amlogic-drivers' of https://git.kernel.org/.../khilman/linux-amlogic into arm/drivers
      Merge tag 'v5.4-next-soc' of https://git.kernel.org/.../matthias.bgg/linux into arm/drivers
      Merge tag 'hisi-drivers-for-5.5' of git://github.com/hisilicon/linux-hisi into arm/drivers
      Merge tag 'tegra-for-5.5-memory-v2' of git://git.kernel.org/.../tegra/linux into arm/drivers
      Merge tag 'soc-fsl-next-v5.5' of git://git.kernel.org/.../leo/linux into arm/drivers
      Merge tag 'scmi-fix-5.5' of git://git.kernel.org/.../sudeep.holla/linux into arm/drivers

Philipp Zabel (5):
      reset: hisilicon: hi3660: Make reset_control_ops const
      reset: zynqmp: Make reset_control_ops const
      MAINTAINERS: add reset controller framework keywords
      reset: improve of_xlate documentation
      reset: document (devm_)reset_control_get_optional variants

Ran Wang (3):
      PM: wakeup: Add routine to help fetch wakeup source object.
      dt-bindings: fsl: rcpm: Add 'little-endian' and update Chassis definition
      soc: fsl: add RCPM driver

Sai Prakash Ranjan (2):
      dt-bindings: msm: Convert LLCC bindings to YAML
      dt-bindings: msm: Add LLCC for SC7180

Sibi Sankar (2):
      dt-bindings: reset: aoss: Convert AOSS reset bindings to yaml
      dt-bindings: reset: pdc: Convert PDC Global bindings to yaml

Sowjanya Komatineni (4):
      soc/tegra: pmc: Support wake events on more Tegra SoCs
      soc/tegra: pmc: Add wake event support on Tegra210
      soc/tegra: pmc: Configure core power request polarity
      soc/tegra: pmc: Configure deep sleep control settings

Srinivas Kandagatla (1):
      soc: qcom: socinfo: add sdm845 and sda845 soc ids

Stephen Boyd (3):
      soc: qcom: llcc: Name regmaps to avoid collisions
      soc: qcom: llcc: Move regmap config to local variable
      PM / OPP: Support adjusting OPP voltages at runtime

Sudeep Holla (1):
      firmware: arm_scmi: Fix doorbell ring logic for !CONFIG_64BIT

Sylwester Nawrocki (3):
      soc: samsung: chipid: Make exynos_chipid_early_init() static
      soc: samsung: Add Exynos Adaptive Supply Voltage driver
      soc: samsung: chipid: Drop "syscon" compatible requirement

Tejas Patel (1):
      soc: xilinx: Set CAP_UNUSABLE requirement for versal while powering down domain

Tero Kristo (12):
      bus: ti-sysc: re-order reset and main clock controls
      bus: ti-sysc: drop the extra hardreset during init
      bus: ti-sysc: avoid toggling power state of module during probe
      dt-bindings: omap: add new binding for PRM instances
      soc: ti: add initial PRM driver with reset control support
      soc: ti: omap-prm: poll for reset complete during de-assert
      soc: ti: omap-prm: add support for denying idle for reset clockdomain
      soc: ti: omap-prm: add omap4 PRM data
      soc: ti: omap-prm: add data for am33xx
      soc: ti: omap-prm: add dra7 PRM data
      soc: ti: omap-prm: add am4 PRM data
      soc: ti: omap-prm: add omap5 PRM data

Thierry Reding (8):
      soc/tegra: pmc: Fix crashes for hierarchical interrupts
      soc/tegra: fuse: Restore base on sysfs failure
      soc/tegra: fuse: Implement nvmem device
      soc/tegra: fuse: Add cell information
      soc/tegra: fuse: Register cell lookups for compatibility
      Merge branch 'for-5.5/clk' into for-5.5/memory
      memory: tegra: Set DMA mask based on supported address bits
      memory: tegra: Add gr2d and gr3d to DRM IOMMU group

Tony Lindgren (3):
      Merge branch 'watchdog-fix' into omap-for-v5.5/ti-sysc
      bus: ti-sysc: Handle mstandby quirk and use it for musb
      bus: ti-sysc: Use swsup quirks also for am335x musb

Tudor Ambarus (2):
      memory: atmel-ebi: move NUM_CS definition inside EBI driver
      memory: atmel-ebi: switch to SPDX license identifiers

Vidya Sagar (1):
      firmware: tegra: Move BPMP resume to noirq phase

Vivek Gautam (4):
      soc: qcom: llcc cleanup to get rid of sdm845 specific driver file
      soc: qcom: Rename llcc-slice to llcc-qcom
      soc: qcom: Make llcc-qcom a generic driver
      soc: qcom: llcc: Add configuration data for SC7180

Wei Yongjun (1):
      soc: ti: omap-prm: fix return value check in omap_prm_probe()

Weiyi Lu (5):
      soc: mediatek: Refactor polling timeout and documentation
      soc: mediatek: Refactor regulator control
      soc: mediatek: Refactor clock control
      soc: mediatek: Refactor sram control
      soc: mediatek: Refactor bus protection control

Xingyu Chen (2):
      dt-bindings: reset: add bindings for the Meson-A1 SoC Reset Controller
      reset: add support for the Meson-A1 SoC Reset Controller

YueHaibing (2):
      soc: qcom: Fix llcc-qcom definitions to include
      memory: emif: remove set but not used variables 'cs1_used' and 'custom_configs'


 Documentation/arm/microchip.rst                 |    4 +-
 .../devicetree/bindings/arm/msm/qcom,llcc.txt   |   41 -
 .../devicetree/bindings/arm/msm/qcom,llcc.yaml  |   55 +
 .../devicetree/bindings/arm/omap/prm-inst.txt   |   29 +
 .../firmware/xilinx/xlnx,zynqmp-firmware.txt    |   16 +-
 .../devicetree/bindings/nvmem/amlogic-efuse.txt |    6 +
 .../devicetree/bindings/power/qcom,rpmpd.txt    |    1 +
 .../reset/amlogic,meson-axg-audio-arb.txt       |    3 +-
 .../bindings/reset/amlogic,meson-reset.yaml     |    1 +
 .../bindings/reset/qcom,aoss-reset.txt          |   52 -
 .../bindings/reset/qcom,aoss-reset.yaml         |   47 +
 .../bindings/reset/qcom,pdc-global.txt          |   52 -
 .../bindings/reset/qcom,pdc-global.yaml         |   47 +
 .../bindings/reset/uniphier-reset.txt           |    5 +-
 .../devicetree/bindings/soc/fsl/rcpm.txt        |   14 +-
 .../bindings/soc/qcom/qcom,smd-rpm.txt          |    1 +
 MAINTAINERS                                     |   17 +
 arch/arm/mach-omap2/Kconfig                     |    1 +
 drivers/base/power/wakeup.c                     |   54 +
 drivers/bus/Kconfig                             |    5 +-
 drivers/bus/hisi_lpc.c                          |    9 +-
 drivers/bus/ti-sysc.c                           |   87 +-
 drivers/firmware/arm_scmi/perf.c                |    2 +-
 drivers/firmware/imx/imx-dsp.c                  |    2 +-
 drivers/firmware/imx/imx-scu-irq.c              |    1 +
 drivers/firmware/imx/imx-scu.c                  |   24 +-
 drivers/firmware/meson/meson_sm.c               |  110 +-
 drivers/firmware/tegra/bpmp.c                   |    2 +-
 drivers/firmware/xilinx/zynqmp.c                |    8 +-
 drivers/memory/atmel-ebi.c                      |   11 +-
 drivers/memory/brcmstb_dpfe.c                   |  164 +-
 drivers/memory/emif.c                           |    5 +-
 drivers/memory/jedec_ddr.h                      |   61 +
 drivers/memory/of_memory.c                      |  149 ++
 drivers/memory/of_memory.h                      |   18 +
 drivers/memory/samsung/Kconfig                  |   13 +
 drivers/memory/samsung/Makefile                 |    1 +
 drivers/memory/samsung/exynos5422-dmc.c         | 1550 ++++++++++++++++++
 drivers/memory/tegra/Kconfig                    |   10 +
 drivers/memory/tegra/Makefile                   |    1 +
 drivers/memory/tegra/mc.c                       |   52 +-
 drivers/memory/tegra/mc.h                       |   74 +-
 drivers/memory/tegra/tegra114.c                 |   10 +-
 drivers/memory/tegra/tegra124.c                 |   30 +-
 drivers/memory/tegra/tegra20-emc.c              |  134 +-
 drivers/memory/tegra/tegra30-emc.c              | 1232 ++++++++++++++
 drivers/memory/tegra/tegra30.c                  |   34 +-
 drivers/nvmem/meson-efuse.c                     |   24 +-
 drivers/phy/marvell/Kconfig                     |   11 +
 drivers/phy/marvell/Makefile                    |    1 +
 drivers/phy/marvell/phy-mmp3-usb.c              |  291 ++++
 drivers/reset/Kconfig                           |    5 +-
 drivers/reset/core.c                            |    8 +-
 drivers/reset/hisilicon/reset-hi3660.c          |    2 +-
 drivers/reset/reset-meson-audio-arb.c           |   43 +-
 drivers/reset/reset-meson.c                     |   35 +-
 drivers/reset/reset-uniphier-glue.c             |    4 +
 drivers/reset/reset-zynqmp.c                    |    2 +-
 drivers/soc/amlogic/meson-gx-socinfo.c          |    3 +
 drivers/soc/atmel/Kconfig                       |   11 +
 drivers/soc/atmel/Makefile                      |    1 +
 drivers/soc/atmel/sfr.c                         |   99 ++
 drivers/soc/fsl/Kconfig                         |   10 +
 drivers/soc/fsl/Makefile                        |    1 +
 drivers/soc/fsl/rcpm.c                          |  151 ++
 drivers/soc/imx/soc-imx-scu.c                   |   34 +-
 drivers/soc/imx/soc-imx8.c                      |   49 +-
 drivers/soc/mediatek/mtk-scpsys.c               |  214 ++-
 drivers/soc/qcom/Kconfig                        |   14 +-
 drivers/soc/qcom/Makefile                       |    3 +-
 drivers/soc/qcom/{llcc-slice.c => llcc-qcom.c}  |  130 +-
 drivers/soc/qcom/llcc-sdm845.c                  |  100 --
 drivers/soc/qcom/rpmpd.c                        |   23 +
 drivers/soc/qcom/smd-rpm.c                      |   18 +-
 drivers/soc/qcom/socinfo.c                      |    2 +
 drivers/soc/renesas/Kconfig                     |   32 +-
 drivers/soc/renesas/Makefile                    |    4 +-
 drivers/soc/renesas/r8a7743-sysc.c              |    1 -
 drivers/soc/renesas/r8a7745-sysc.c              |    1 -
 drivers/soc/renesas/r8a77470-sysc.c             |    1 -
 drivers/soc/renesas/r8a774a1-sysc.c             |    1 -
 drivers/soc/renesas/r8a774b1-sysc.c             |   37 +
 drivers/soc/renesas/r8a774c0-sysc.c             |    4 +-
 drivers/soc/renesas/r8a7779-sysc.c              |    1 -
 drivers/soc/renesas/r8a7790-sysc.c              |    1 -
 drivers/soc/renesas/r8a7791-sysc.c              |    1 -
 drivers/soc/renesas/r8a7792-sysc.c              |    1 -
 drivers/soc/renesas/r8a7794-sysc.c              |    1 -
 drivers/soc/renesas/r8a7795-sysc.c              |   33 +-
 drivers/soc/renesas/r8a7796-sysc.c              |   30 +-
 drivers/soc/renesas/r8a77965-sysc.c             |    4 +-
 drivers/soc/renesas/r8a77970-sysc.c             |    4 +-
 drivers/soc/renesas/r8a77980-sysc.c             |    4 +-
 drivers/soc/renesas/r8a77990-sysc.c             |    4 +-
 drivers/soc/renesas/r8a77995-sysc.c             |    1 -
 drivers/soc/renesas/rcar-rst.c                  |    2 +
 drivers/soc/renesas/rcar-sysc.c                 |   26 +-
 drivers/soc/renesas/rcar-sysc.h                 |    9 +-
 drivers/soc/renesas/renesas-soc.c               |   15 +-
 drivers/soc/samsung/Kconfig                     |   10 +
 drivers/soc/samsung/Makefile                    |    3 +
 drivers/soc/samsung/exynos-asv.c                |  177 ++
 drivers/soc/samsung/exynos-asv.h                |   71 +
 drivers/soc/samsung/exynos-chipid.c             |   12 +-
 drivers/soc/samsung/exynos5422-asv.c            |  505 ++++++
 drivers/soc/samsung/exynos5422-asv.h            |   31 +
 drivers/soc/tegra/Kconfig                       |   10 +
 drivers/soc/tegra/Makefile                      |    2 +
 drivers/soc/tegra/fuse/fuse-tegra.c             |  198 ++-
 drivers/soc/tegra/fuse/fuse-tegra30.c           |  154 ++
 drivers/soc/tegra/fuse/fuse.h                   |    8 +
 drivers/soc/tegra/pmc.c                         |  232 ++-
 drivers/soc/tegra/regulators-tegra20.c          |  365 +++++
 drivers/soc/tegra/regulators-tegra30.c          |  317 ++++
 drivers/soc/ti/Makefile                         |    1 +
 drivers/soc/ti/omap_prm.c                       |  391 +++++
 drivers/soc/xilinx/zynqmp_pm_domains.c          |   10 +-
 include/dt-bindings/power/qcom-rpmpd.h          |    9 +
 .../dt-bindings/reset/amlogic,meson-a1-reset.h  |   74 +
 .../reset/amlogic,meson-axg-audio-arb.h         |    2 +
 include/linux/firmware/meson/meson_sm.h         |   15 +-
 include/linux/firmware/xlnx-zynqmp.h            |    3 +-
 include/linux/logic_pio.h                       |    4 +-
 include/linux/mfd/syscon/atmel-matrix.h         |    1 -
 include/linux/platform_data/ti-prm.h            |   21 +
 include/linux/pm_wakeup.h                       |    9 +
 include/linux/reset-controller.h                |    3 +-
 include/linux/reset.h                           |   46 +
 include/linux/soc/mmp/cputype.h                 |    2 +
 include/linux/soc/qcom/llcc-qcom.h              |   94 +-
 include/soc/tegra/mc.h                          |    2 +-
 lib/Makefile                                    |    2 +-
 lib/logic_pio.c                                 |   14 +-
 133 files changed, 7611 insertions(+), 939 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/omap/prm-inst.txt
 delete mode 100644 Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt
 create mode 100644 Documentation/devicetree/bindings/reset/qcom,aoss-reset.yaml
 delete mode 100644 Documentation/devicetree/bindings/reset/qcom,pdc-global.txt
 create mode 100644 Documentation/devicetree/bindings/reset/qcom,pdc-global.yaml
 create mode 100644 drivers/memory/samsung/exynos5422-dmc.c
 create mode 100644 drivers/memory/tegra/tegra30-emc.c
 create mode 100644 drivers/phy/marvell/phy-mmp3-usb.c
 create mode 100644 drivers/soc/atmel/sfr.c
 create mode 100644 drivers/soc/fsl/rcpm.c
 rename drivers/soc/qcom/{llcc-slice.c => llcc-qcom.c} (68%)
 delete mode 100644 drivers/soc/qcom/llcc-sdm845.c
 create mode 100644 drivers/soc/renesas/r8a774b1-sysc.c
 create mode 100644 drivers/soc/samsung/exynos-asv.c
 create mode 100644 drivers/soc/samsung/exynos-asv.h
 create mode 100644 drivers/soc/samsung/exynos5422-asv.c
 create mode 100644 drivers/soc/samsung/exynos5422-asv.h
 create mode 100644 drivers/soc/tegra/regulators-tegra20.c
 create mode 100644 drivers/soc/tegra/regulators-tegra30.c
 create mode 100644 drivers/soc/ti/omap_prm.c
 create mode 100644 include/dt-bindings/reset/amlogic,meson-a1-reset.h
 create mode 100644 include/linux/platform_data/ti-prm.h
