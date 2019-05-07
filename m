Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B129C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1989320B7C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z7byc17K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfEGGgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 02:36:42 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35412 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfEGGgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 02:36:39 -0400
Received: by mail-lj1-f196.google.com with SMTP id m20so4005812lji.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 23:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=nlc3oZR7WiKy7YxKM9XNkiVLgRr7nzZBeBG7jq1nN28=;
        b=Z7byc17KsWdnVM6Pc/OvcuQTyIf7Ll51Xw1KlKw6c2YMKbfeJvDvMhWBd4ID45mp4a
         QJ30Q/In4V0dsqQsQnUcWbWq4PhVoq0bxPVOzcgo1STHMPbe1QbHTSueetH5r5R6v8N+
         /Stl4JCG6djqkneMFZjplkzYWY3pykZcROoIxRT/Q4nRqVfppuKcN2TVnZTTWz7WDr8O
         iyuFNSOMCqtuiPfN8m8C1vGKRvH0dH1+M0MiVOYYG5Bf9xsZK+sFm057x8zSnEfGX9eA
         Yt9R9eEKR+wc85yQVL4E4GuzT+uc3lnjDYyCLtV5N9JoemxXGK3hzweIY2EQQq9Dhr69
         Hk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nlc3oZR7WiKy7YxKM9XNkiVLgRr7nzZBeBG7jq1nN28=;
        b=ERUmWVQmRTcqu5rpkKwFu6nJkzERSkyh7uYTLj2G1Qp0vDWjCTvfu2C2nIsd7pOcTC
         s7KQuYC08YzyBRSL1x/2x6rDG56jLMpRGQlPYXXOzzM3ojSOf+vVaqUr9HP+SqscqSMx
         MZqYyO6Ph3jxIdriH3xi2iedi5Di51nlvMLiy3ffD0MPY7//td2zuTtsqxG+wD29Rc8Q
         PEsm/XJHcwnSOMwVJyRVELdqzvhV2NhbqKcc7Em9he7GGtAyzca5pPOr7+53OUaM2cW0
         jfxILgL7wK+DDBXjsnrArxpxxoUe7kn6ua7jOEdwqNX+gFTyYSYRNIJaSvvBdREGHIcS
         tvIQ==
X-Gm-Message-State: APjAAAWysTS5lbHMBgE7uUj5Fu6cPsD/1ozWeIxWNh9Jz0sBrJfA+Amq
        EazeHQGFrRfbVfNkqDMUpxK3HA==
X-Google-Smtp-Source: APXvYqxpBu3WdgL8OSw4treG1De9vDfbQEOUPPx21quIyGc4CKQ3OHmg/Jea/oobf9ZdCGUBphfiFg==
X-Received: by 2002:a2e:9713:: with SMTP id r19mr16556330lji.189.1557210996732;
        Mon, 06 May 2019 23:36:36 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id v6sm1379197lfg.96.2019.05.06.23.36.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 23:36:36 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC and MEMSTICK updates for v5.2
Date:   Tue,  7 May 2019 08:36:34 +0200
Message-Id: <20190507063634.8389-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's the PR with MMC updates for v5.1. This time and onwards I will continue
to include changes also for the MEMSTICK subsystem in the PR, please tell me if
you prefer another setup.

Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit dc4060a5dc2557e6b5aa813bf5b73677299d62d2:

  Linux 5.1-rc5 (2019-04-14 15:17:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.2

for you to fetch changes up to 0a49a619e7e1aeb3f5f5511ca59314423c83dae2:

  mmc: sdhci-pci: Fix BYT OCP setting (2019-05-06 12:33:03 +0200)

----------------------------------------------------------------
MMC core:
 - Fix a few memoryleaks
 - Minor improvements to the card initialization sequence
 - Partially support sleepy GPIO controllers for pwrseq eMMC

MMC host:
 - alcor: Work with multiple-entry sglists
 - alcor: Enable DMA for writes
 - meson-gx: Improve tuning support
 - meson-gx: Avoid clock glitch when switching to DDR modes
 - meson-gx: Disable unreliable HS400 mode
 - mmci: Minor updates for support of HW busy detection
 - mmci: Support data transfers for the stm32_sdmmc variant
 - mmci: Restructure code to better support different variants
 - mtk-sd: Add support for version found on MT7620 family SOCs
 - mtk-sd: Add support for the MT8516 version
 - mtk-sd: Add Chaotian Jing as the maintainer
 - sdhci: Reorganize request-code to convert from tasklet to workqueue
 - sdhci_am654: Stabilize support for lower speed modes
 - sdhci-esdhc-imx: Add HS400 support for iMX7ULP
 - sdhci-esdhc-imx: Add support for iMX7ULP version
 - sdhci-of-arasan: Allow to disable DCMDs via DT for CQE
 - sdhci-of-esdhc: Add support for the ls1028a version
 - sdhci-of-esdhc: Several fixups for errata
 - sdhci-pci: Fix BYT OCP setting
 - sdhci-pci: Add support for Intel CML
 - sdhci-tegra: Add support for system suspend/resume
 - sdhci-tegra: Add CQE support for Tegra186 WAR
 - sdhci-tegra: Add support for Tegra194
 - sdhci-tegra: Update HW tuning process

MEMSTICK:
 - I volunteered to help as a maintainer for the memstick subsystem, which is
   reflected by an update to the MAINTAINERS file. Changes are funneled through
   my MMC git and we will use the linux-mmc mailing list.

MEMSTICK host:
 - A few minor cleanups

----------------------------------------------------------------
Adrian Hunter (7):
      mmc: sdhci-pci: Add support for Intel CML
      mmc: sdhci: Reorganize sdhci_finish_mrq() and __sdhci_finish_mrq()
      mmc: sdhci: Move timer and has_requests functions
      mmc: sdhci: Move some processing to __sdhci_finish_mrq()
      mmc: sdhci: Call mmc_request_done() from IRQ handler if possible
      mmc: sdhci: Remove finish_tasklet
      mmc: sdhci-pci: Fix BYT OCP setting

Andrea Merello (1):
      mmc: core: make pwrseq_emmc (partially) support sleepy GPIO controllers

Andy Shevchenko (5):
      mmc: mmc_spi: Remove redundant dev_set_drvdata()
      mmc: mmc_spi: Remove useless NULL check at ->remove()
      mmc: mmc_spi: Join string literals back
      mmc: mmc_spi: Indentation fixes
      mmc: mmc_spi: Convert to use SPDX identifier

BOUGH CHEN (3):
      dt-bindings: mmc: fsl-imx-esdhc: add imx7ulp compatible string
      mmc: sdhci-esdhc-imx: add pm_qos to interact with cpuidle
      mmc: sdhci-esdhc-imx: Add HS400 support for iMX7ULP

Christoph Muellner (2):
      dt-bindings: mmc: Add disable-cqe-dcmd property.
      mmc: sdhci-of-arasan: Add DTS property to disable DCMDs.

Daniel Drake (4):
      mmc: alcor: enable DMA for writes
      mmc: alcor: enable DMA transfer of large buffers
      Revert "mmc: alcor: enable DMA transfer of large buffers"
      mmc: alcor: work with multiple-entry sglists

Enrico Weigelt, metux IT consult (1):
      mmc: host: Pedantic cleanups to Kconfig

Fabien Parent (3):
      mmc: mtk-sd: add support for MT8516
      mmc: mtk-sd: check for valid optional memory resource
      dt-bindings: mmc: Add support for MT8516 to mtk-sd

Faiz Abbas (1):
      mmc: sdhci_am654: Clear HISPD_ENA in some lower speed modes

Gustavo A. R. Silva (1):
      mmc: usdhi6rol0: mark expected switch fall-throughs

Jerome Brunet (7):
      mmc: meson-gx: remove open coded read with timeout
      mmc: meson-gx: ack only raised irq
      mmc: meson-gx: correct irq flag
      mmc: meson-gx: disable HS400
      mmc: meson-gx: avoid clock glitch when switching to DDR modes
      mmc: meson-gx: remove Rx phase tuning
      mmc: meson-gx: add signal resampling tuning

Kamlesh Gurudasani (1):
      mmc: alcor: Drop pointer to mmc_host from alcor_sdmmc_host

Kangjie Lu (1):
      mmc_spi: add a status check for spi_sync_locked

Kefeng Wang (1):
      mmc: omap_hsmmc: Use dev_get_drvdata()

Ludovic Barre (7):
      mmc: mmci: add get_datactrl_cfg callback and helper functions
      mmc: mmci: define get_dctrl_cfg for legacy variant
      mmc: mmci: qcom: define get_dctrl_cfg
      mmc: mmci: stm32: define get_dctrl_cfg
      mmc: mmci: replace blksz_datactrlXX by get_datactrl_cfg callback
      mmc: mmci: Cleanup mmci_cmd_irq() for busy detect
      mmc: mmci: Prevent polling for busy detection in IRQ context

NeilBrown (4):
      mmc: mtk-sd: don't hard-code interrupt trigger type
      mmc: mtk-sd: add support for config found in mt7620 family SOCs.
      mmc: mtk-sd: enable internal card-detect logic.
      mmc: mtk-sd: select REGULATOR

Pan Bian (1):
      mmc: core: fix possible use after free of host

Pavel Machek (1):
      mmc: core: Fix warning and undefined behavior in mmc voltage handling

Raul E Rangel (2):
      mmc: core: Verify SD bus width
      mmc: core: Fix tag set memory leak

Sowjanya Komatineni (9):
      mmc: tegra: fix ddr signaling for non-ddr modes
      mmc: sdhci: allow host to specify maximum tuning loops
      mmc: tegra: update hw tuning process
      dt-bindings: mmc: tegra: document Tegra194 compatible string
      mmc: cqhci: allow hosts to update dcmd cmd desc
      mmc: tegra: add Tegra186 WAR for CQE
      mmc: cqhci: add CQHCI_SSC1 register CBC field mask
      mmc: tegra: fix CQE enable and resume sequence
      mmc: tegra: add sdhci tegra suspend and resume

Stefan Wahren (1):
      mmc: mxs-mmc: Enable MMC_CAP_ERASE

Ulf Hansson (9):
      mmc: mmci: Don't share un-implemented DMA functions
      mmc: mmci: Drop unnecessary clear of variant->qcom_dml flag
      mmc: mmci: Re-work code starting DMA for the qcom variant
      mmc: mmci: Drop qcom specific header file
      mmc: mmci: Share sdmmc_variant_init() via the common header file
      mmc: mmci: Make mmci_variant_init() static
      MAINTAINERS: Collect TI FLASH MEDIA drivers into one section
      MAINTAINERS: Add Ulf Hansson to the MEMORYSTICK section
      MAINTAINERS: Add section for MediaTek MMC/SD/SDIO driver

Wolfram Sang (4):
      mmc: renesas_sdhi: update copyright information
      mmc: tmio: introduce macro for max block size
      mmc: renesas_sdhi: prevent overflow for max_req_size
      mmc: renesas_sdhi: set CBSY flag before probing TMIO host

Yangbo Lu (1):
      mmc: sdhci-of-esdhc: add quirk to ignore command inhibit for data

Yinbo Zhu (6):
      mmc: sdhci-of-esdhc: add erratum A011334 support in lx2160 2.0 SoC
      mmc: sdhci-of-esdhc: add erratum eSDHC5 support
      mmc: sdhci-of-esdhc: add erratum eSDHC-A001 and A-008358 support
      mmc: sdhci-of-esdhc: add erratum A-009204 support
      mmc: sdhci-of-esdhc: add erratum eSDHC7 support
      dt-bindings: mmc: add DT bindings for ls1028a eSDHC host controller

Yoshihiro Shimoda (1):
      mmc: core: retry CMD1 in mmc_send_op_cond() even if the ocr = 0

YueHaibing (3):
      mmc: sdhci-omap: Make sdhci_omap_reset static
      memstick: jmb38x_ms: remove set but not used variable 'data'
      memstick: tifm: remove set but not used variable 'data'

 .../devicetree/bindings/mmc/fsl-esdhc.txt          |   1 +
 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |   1 +
 Documentation/devicetree/bindings/mmc/mmc.txt      |   2 +
 Documentation/devicetree/bindings/mmc/mtk-sd.txt   |   2 +
 .../bindings/mmc/nvidia,tegra20-sdhci.txt          |   1 +
 MAINTAINERS                                        |  25 +-
 drivers/memstick/host/jmb38x_ms.c                  |   3 -
 drivers/memstick/host/tifm_ms.c                    |   3 -
 drivers/mmc/core/host.c                            |   4 +-
 drivers/mmc/core/mmc_ops.c                         |  16 +-
 drivers/mmc/core/pwrseq_emmc.c                     |  38 +-
 drivers/mmc/core/queue.c                           |   1 +
 drivers/mmc/core/sd.c                              |   8 +
 drivers/mmc/host/Kconfig                           |  46 +--
 drivers/mmc/host/alcor.c                           |  72 ++--
 drivers/mmc/host/cqhci.c                           |   2 +
 drivers/mmc/host/cqhci.h                           |   4 +
 drivers/mmc/host/meson-gx-mmc.c                    | 419 ++++++---------------
 drivers/mmc/host/mmc_spi.c                         |  98 ++---
 drivers/mmc/host/mmci.c                            |  82 ++--
 drivers/mmc/host/mmci.h                            |  32 +-
 drivers/mmc/host/mmci_qcom_dml.c                   |  17 +-
 drivers/mmc/host/mmci_qcom_dml.h                   |  30 --
 drivers/mmc/host/mmci_stm32_sdmmc.c                |  18 +
 drivers/mmc/host/mtk-sd.c                          |  97 ++++-
 drivers/mmc/host/mxs-mmc.c                         |   3 +-
 drivers/mmc/host/of_mmc_spi.c                      |   6 +-
 drivers/mmc/host/omap_hsmmc.c                      |   4 +-
 drivers/mmc/host/renesas_sdhi.h                    |   2 +-
 drivers/mmc/host/renesas_sdhi_core.c               |  12 +-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      |  11 +-
 drivers/mmc/host/renesas_sdhi_sys_dmac.c           |   6 +-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |  41 +-
 drivers/mmc/host/sdhci-of-arasan.c                 |   5 +-
 drivers/mmc/host/sdhci-of-esdhc.c                  |  47 +++
 drivers/mmc/host/sdhci-omap.c                      |   2 +-
 drivers/mmc/host/sdhci-pci-core.c                  |  98 +++++
 drivers/mmc/host/sdhci-pci.h                       |   2 +
 drivers/mmc/host/sdhci-tegra.c                     | 362 +++++++++++++++++-
 drivers/mmc/host/sdhci.c                           | 164 +++++---
 drivers/mmc/host/sdhci.h                           |   4 +-
 drivers/mmc/host/sdhci_am654.c                     |  22 ++
 drivers/mmc/host/tmio_mmc.h                        |   6 +-
 drivers/mmc/host/tmio_mmc_core.c                   |   6 +-
 drivers/mmc/host/usdhi6rol0.c                      |   9 +-
 include/linux/alcor_pci.h                          |   2 +-
 46 files changed, 1170 insertions(+), 666 deletions(-)
 delete mode 100644 drivers/mmc/host/mmci_qcom_dml.h
