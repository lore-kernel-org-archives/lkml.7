Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEA8C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C0032075B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UQYNVMkh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfCDNC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:02:28 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45859 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfCDNC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 08:02:27 -0500
Received: by mail-lj1-f194.google.com with SMTP id d24so4230928ljc.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 05:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xUZaNf+FVk7rGO5bVFAeQ9efciXlwnhbecI7r1Ec3Us=;
        b=UQYNVMkhrEQxJxDPo6FZqhBKuu6yFEE62uEfY0oTa/fwM/qUW9npfMqMvmgm/VQ0D9
         O3jdzvKwRH/ThskcAJG4KgC+4G5lui2W11/MzJRfR++HNbAViieiFHfL1aUNA9H+KW9e
         8P5+L7xI8Fv1we7FKzHvW03IogX84tuKMRwBXIf9ymwTCi0EekpFpUP4CzCWQ6SBs/69
         B7LOPOZHMuww8B5rZnZhgy8CCWiuXDuwg4EwmLNfHL2JplWB/tC9ww1cdQ9COZdwtDAz
         z3ssVIeDlzAQgYxf3Z0UcJvXb8DYiUR7LUK3zMOx8IVcOA4QAOQBqnocdKp9X/1TUFqf
         /qbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xUZaNf+FVk7rGO5bVFAeQ9efciXlwnhbecI7r1Ec3Us=;
        b=pAyCJdaJYoHnQa/V4tjC+f28s2b64AnVfQp651DhLG851cvT8tFroxt6TuH/hkIR50
         rMUR6P0NXub6FdovyEvGfbd7q6Z5tcLBfIausd9LHF5cUl22hDlURySIz03tUVUEpMIN
         dpyiZ3l9P7GxG3zjk8lQIIKFwRZmsPGIcqUxZ3Oy2gNuQXtkUeQ8L0v6FDcgJwm36yFZ
         Ma8QLzCMgwlU9oNVXiPK8H778sADW1BolXjNIziO0Te8mlNJrL+NZg3lYE7gg4IatMwn
         YufqRwG4/FIjS8XpgwofqgH1mvNoKJRnQ8zaYcDA3ae/H+i/P9BqprTNx5eTfbGL+M0u
         vU/Q==
X-Gm-Message-State: APjAAAUDCKm/9dCvhP4T9jrgr8kl8QVErA1V9VjP+CPAIMS6T0Foh0bM
        ERm+c/lI0iVymjOqXyETjtAfcw==
X-Google-Smtp-Source: APXvYqxB4V3AP7CxFiDCkqSNv/CGbv+NW11v0YgsWDpvOuBZPl7tUJSPkgXFvpEkT4mueF0xjprR2Q==
X-Received: by 2002:a2e:880a:: with SMTP id x10mr10507293ljh.12.1551704544331;
        Mon, 04 Mar 2019 05:02:24 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id q123-v6sm1496445ljb.60.2019.03.04.05.02.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 05:02:23 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC updates for v5.1
Date:   Mon,  4 Mar 2019 14:02:22 +0100
Message-Id: <20190304130222.18534-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's the PR with MMC updates for v5.1. Details about the highlights are as
usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit e30be063d6dbcc0f18b1eb25fa709fdef89201fb:

  mmc: sdhci-esdhc-imx: correct the fix of ERR004536 (2019-02-28 12:18:31 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.1

for you to fetch changes up to d4721339dcca7def04909a8e60da43c19a24d8bf:

  mmc:fix a bug when max_discard is 0 (2019-03-01 09:50:10 +0100)

----------------------------------------------------------------
MMC core:
 - mmc: core: Fixup max_discard/trim calculations
 - mmc: core: Announce SD specs greater than 4.0
 - mmc: core: Add discard support for SD cards
 - mmc: core: Don't do retries for CMD6 (SWITCH command)
 - mmc: core: Various cleanups and re-structuring

MMC host:
 - cqhci: Add maintainers for eMMC CQHCI driver
 - sdhci: Consolidate WP GPIO code
 - sdhci: Add ADMA3 DMA support for V4 enabled host
 - sdhci-pci-o2micro: Fixup card detect support
 - sdhci-tegra: Add support for CMDQ
 - sdhci-tegra: Support SDMMC pads auto-calibration
 - sdhci-esdhc-imx: Add DCMD support and CMDQ support
 - sdhci-esdhc-imx: Add support for i.MX6ULL variant
 - sdhci-esdhc-imx: Fixup HS400 timing issue
 - sdhci-esdhc-imx: Add HS400_ES support for i.MX8QXP
 - renesas_sdhi: Avoid CRC errors by adjusting settings to speed mode
 - renesas_sdhi: Fixup card initialization for high speed mode
 - omap: Fixup timeout settings
 - atmel-mci: Enable 8 bits bus-width support
 - jz4740: Convert some legacy code to use modern APIs
 - mmci: Send a CMD12 to clear DPSM at errors for STM32 sdmmc

----------------------------------------------------------------
Aaro Koskinen (1):
      mmc: omap: fix the maximum timeout setting

Andrey Smirnov (1):
      mmc: sdhci-esdhc-imx: Constify driver data

Avri Altman (4):
      mmc: core: Calculate the discard arg only once
      mmc: core: Indicate SD specs higher than 4.0
      mmc: core: Add discard support to sd
      mmc: core: Add sd discard timeout

BOUGH CHEN (13):
      mmc: sdhci-esdhc-imx: clear ESDHC_STD_TUNING_EN for manual tuning method
      mmc: sdhci: usdhc: do not do tuning for DDR50 mode.
      mmc: sdhci-esdhc-imx: fix HS400 timing issue
      dt-bindings: mmc: fsl-imx-esdhc: add imx6ull compatible string
      mmc: sdhci-esdhc-imx: add SD clock limitation for imx6ull
      mmc: sdhci-esdhc-imx: add delay between tuning cycles
      mmc: sdhci: add delay after the last tuning command
      mmc: sdhci-esdhc-imx: remove the 100MHz limitation for Strobe DLL
      mmc: sdhci-esdhc-imx: add HS400_ES support for i.MX8QXP
      mmc: sdhci: correct the maximum timeout when enable CMDQ
      mmc: sdhci-esdhc-imx: add CMDQ support
      mmc: sdhci-esdhc-imx: add DCMD support for CMDQ
      mmc: sdhci-esdhc-imx: clear the HALT bit when enable CQE

Chaotian Jing (1):
      mmc: core: do not retry CMD6 in __mmc_switch()

Colin Ian King (1):
      mmc: cb710: fix indentation issue in if block

Ernest Zhang(WH) (3):
      mmc: sdhci: Moving sdhci_o2 into sdhci-pci-o2micro.c
      mmc: sdhci: Fix O2 Host PLL and card detect issue
      mmc: sdhci: Remove unneeded quirk2 flag of O2 SD host controller

Gustavo A. R. Silva (1):
      mmc: sdhci-xenon: Fixup already marked switch fall-through

Jiong Wu (1):
      mmc:fix a bug when max_discard is 0

Linus Walleij (7):
      mmc: slot-gpio: Remove override_active_level on WP
      mmc: mxcmmc: Drop unused includes
      mmc: mxs-mmc: Drop unused includes
      mmc: sdhci-bcm-kona: Drop unused includes
      mmc: sdhci-pxav2: Drop unused include
      mmc: sunxi-mmc: Drop unused includes
      mmc: wmt-sdmmc: Drop unused include

Lukas Wunner (3):
      mmc: bcm2835: Drop DMA channel error pointer check
      mmc: bcm2835: Drop pointer to mmc_host from bcm2835_host
      mmc: bcm2835: Deduplicate reset of driver data on remove

Mathieu Malaterre (2):
      mmc: core: annotate implicit fall through
      mmc: jz4740: Annotate implicit fall through

Mike Maslenkin (1):
      mmc: dt-bindings: omap: Remove duplicate documentation paragraphs

Nicolas Ferre (1):
      mmc: atmel-mci: enable 8 bits buswidth support

Niklas Söderlund (2):
      mmc: tmio: fix typo in tmio_mmc_init_ocr()
      mmc: tmio: undo PM autosuspend when removing the host

Paul Cercueil (1):
      mmc: jz4740: Remove platform data and use standard APIs

Sowjanya Komatineni (5):
      dt-bindings: mmc: tegra: Add pinctrl for SDMMC drive strengths
      mmc: tegra: SDMMC pads auto-calibration
      dt-bindings: mmc: Add supports-cqe property
      mmc: sdhci: Add ADMA3 DMA support for V4 enabled host
      mmc: tegra: HW Command Queue Support for Tegra SDMMC

Stefan Wahren (1):
      mmc: sdhci-brcmstb: handle mmc_of_parse() errors during probe

Takeshi Saito (2):
      mmc: renesas_sdhi: Fix card initialization failure in high speed mode
      mmc: renesas_sdhi: Change HW adjustment register according to speed mode

Thomas Petazzoni (3):
      mmc: sdhci: use WP GPIO in sdhci_check_ro()
      mmc: sdhci-omap: drop ->get_ro() implementation
      mmc: sdhci-tegra: drop ->get_ro() implementation

Ulf Hansson (12):
      MAINTAINERS: Add maintainers for eMMC CQHCI driver
      MAINTAINERS: Drop link to git for SDHCI
      mmc: mmci: Send a CMD12 to clear the DPSM at errors
      mmc: core: Convert mmc_wait_for_app_cmd() to static
      mmc: core: Drop retries as in-parameter to mmc_wait_for_app_cmd()
      mmc: of_mmc_spi: Convert to mmc_of_parse_voltage()
      mmc: core: Move regulator helpers to separate file
      mmc: core: Convert mmc_regulator_get_ocrmask() to static
      mmc: core: Move mmc_of_parse_voltage() to host.c
      mmc: core: Convert mmc_align_data_size() into an SDIO specific function
      Merge branch 'fixes' into next
      Merge branch 'fixes' into next

Wei Yongjun (2):
      mmc: sdhci_am654: Make symbol 'sdhci_am654_ops' static
      mmc: sdhci-esdhc-imx: fix return value check in sdhci_esdhc_imx_probe()

YueHaibing (1):
      mmc: block: fix debugfs_simple_attr.cocci warnings

hongjiefang (1):
      mmc: core: Add a debug print when the card may have been replaced

wangbo (1):
      mmc:sdio: Remove unneeded variable ret

 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |   1 +
 Documentation/devicetree/bindings/mmc/mmc.txt      |   2 +
 .../bindings/mmc/nvidia,tegra20-sdhci.txt          |   6 +-
 Documentation/devicetree/bindings/mmc/ti-omap.txt  |  28 --
 MAINTAINERS                                        |   9 +-
 drivers/mmc/core/Makefile                          |   2 +-
 drivers/mmc/core/block.c                           |  21 +-
 drivers/mmc/core/core.c                            | 336 +--------------------
 drivers/mmc/core/core.h                            |   1 +
 drivers/mmc/core/host.c                            |  48 ++-
 drivers/mmc/core/mmc.c                             |  10 +
 drivers/mmc/core/mmc_ops.c                         |   2 +-
 drivers/mmc/core/regulator.c                       | 260 ++++++++++++++++
 drivers/mmc/core/sd.c                              |  20 +-
 drivers/mmc/core/sd_ops.c                          |  33 +-
 drivers/mmc/core/sd_ops.h                          |   3 -
 drivers/mmc/core/sdio.c                            |   9 +-
 drivers/mmc/core/sdio_bus.c                        |   3 +-
 drivers/mmc/core/sdio_io.c                         |  29 +-
 drivers/mmc/core/sdio_ops.h                        |   1 -
 drivers/mmc/core/slot-gpio.c                       |   9 +-
 drivers/mmc/host/Kconfig                           |   2 +
 drivers/mmc/host/atmel-mci.c                       |   8 +-
 drivers/mmc/host/bcm2835.c                         |  23 +-
 drivers/mmc/host/cb710-mmc.c                       |  42 +--
 drivers/mmc/host/davinci_mmc.c                     |   2 +-
 drivers/mmc/host/jz4740_mmc.c                      |  73 +----
 drivers/mmc/host/mmc_spi.c                         |   2 +-
 drivers/mmc/host/mmci.c                            |  27 +-
 drivers/mmc/host/mmci.h                            |   1 +
 drivers/mmc/host/mxcmmc.c                          |   2 -
 drivers/mmc/host/mxs-mmc.c                         |   2 -
 drivers/mmc/host/of_mmc_spi.c                      |  22 +-
 drivers/mmc/host/omap.c                            |   2 +-
 drivers/mmc/host/pxamci.c                          |   2 +-
 drivers/mmc/host/renesas_sdhi.h                    |   2 +
 drivers/mmc/host/renesas_sdhi_core.c               |  19 +-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      |   1 +
 drivers/mmc/host/s3cmci.c                          |   2 +-
 drivers/mmc/host/sdhci-bcm-kona.c                  |   2 -
 drivers/mmc/host/sdhci-brcmstb.c                   |   4 +-
 drivers/mmc/host/sdhci-esdhc-imx.c                 | 301 +++++++++++++++---
 drivers/mmc/host/sdhci-omap.c                      |   1 -
 drivers/mmc/host/sdhci-pci-core.c                  |  10 -
 drivers/mmc/host/sdhci-pci-o2micro.c               | 140 ++++++++-
 drivers/mmc/host/sdhci-pci.h                       |   6 +-
 drivers/mmc/host/sdhci-pxav2.c                     |   1 -
 drivers/mmc/host/sdhci-tegra.c                     | 286 ++++++++++++++----
 drivers/mmc/host/sdhci-xenon-phy.c                 |   2 +-
 drivers/mmc/host/sdhci.c                           |  27 +-
 drivers/mmc/host/sdhci.h                           |   6 +
 drivers/mmc/host/sdhci_am654.c                     |   2 +-
 drivers/mmc/host/sunxi-mmc.c                       |   2 -
 drivers/mmc/host/tmio_mmc_core.c                   |   3 +-
 drivers/mmc/host/wmt-sdmmc.c                       |   1 -
 include/linux/mmc/card.h                           |   3 +
 include/linux/mmc/host.h                           |  12 +-
 include/linux/mmc/sd.h                             |   6 +
 include/linux/mmc/slot-gpio.h                      |   2 +-
 59 files changed, 1198 insertions(+), 686 deletions(-)
 create mode 100644 drivers/mmc/core/regulator.c
