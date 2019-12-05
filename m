Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA4FC47409
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 18:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C245C2464F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 18:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="QVRdaMgi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730364AbfLESFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 13:05:18 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:40715 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730348AbfLESFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 13:05:17 -0500
Received: by mail-pf1-f181.google.com with SMTP id q8so1964612pfh.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 10:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4VfcySzacf9Mk4uPexIJL7qLBciOB9N9FiYTKJsLj+c=;
        b=QVRdaMgiO3BViNe0tsyF0qgnhAHOEg4eF9dh1TmzLTMNyAuV3i3zIUiIFmlGAeP2q3
         M3c6uvCF5e6cIQ7MmscE8N5GBJRcVsII6yMmBI7aohIbz9RJ7l+9AaiOoj2GGmhb5z93
         5IT50W9a/3uh7+NQ/jNy4icQuiC557QJiZhGDMBDd5hufjiUhNv2/tE1+9b3mm08rJUe
         MOSZuVHKKGLgTR2Ie/KMQF73O0OHfwAF8IfRL0ey1szFBSQY4zsvGIQWialzDIa1qf5S
         7hMRCgI2D7IP4lL8N9wKI+VP9O9Zj+HSiXFX7Ezjwj/79VIj3NJtWyarRG7ElUdrNKzL
         O8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4VfcySzacf9Mk4uPexIJL7qLBciOB9N9FiYTKJsLj+c=;
        b=qs1jMfpb3Vbr7u4A+PwxSYm7maRb57Tlz0QtA4utb22bVmee4Hnjue5LPXX25/js61
         V2SOfVjg+FIK+k4ElrsavwKlsRtRkgZ/Mmvo0qQxknrWSRtzwBFKTtVlDb7w8Zeqvcw8
         SfzlyGGmKqo9QXdwd+tm51Pu5V9NaQXEJXPOc+1Fe7OXdjEg6F+KzhQlu+31jJuKs9qf
         IY19Nv8YRO3sfYSv0jtFm5g2BohycLjI4ELzRCD8D5yQTxEczy9EOK10qfTtVIXrMWY4
         YdrLEIQCfOjqEBPNOCJq5ZIsq9aAs0fobT2qdP5NKqX7goryGcvB2ASMHVnxjJ163HcX
         Tc9w==
X-Gm-Message-State: APjAAAUcWpK3S7t57iCxCJK2qfdcvPhzAe2zRPA/aw1o5anU0APqAdK1
        wPNqR8X6zm5gndxDy1kkGazG8Q==
X-Google-Smtp-Source: APXvYqw0USXf88dB3EAi4gOUu2U6f56QPN/w1SKWlAb5nvhpOcANg+fGkfUbMsiA6cH++g9/WTcAMA==
X-Received: by 2002:a62:2ccf:: with SMTP id s198mr10278665pfs.42.1575569116250;
        Thu, 05 Dec 2019 10:05:16 -0800 (PST)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id s22sm386918pjr.5.2019.12.05.10.05.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Dec 2019 10:05:14 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        soc@kernel.org, arm@kernel.org, Olof Johansson <olof@lixom.net>
Subject: [GIT PULL 4/4] ARM: SoC defconfig updates
Date:   Thu,  5 Dec 2019 10:04:53 -0800
Message-Id: <20191205180453.14056-4-olof@lixom.net>
X-Mailer: git-send-email 2.22.GIT
In-Reply-To: <20191205180453.14056-1-olof@lixom.net>
References: <20191205180453.14056-1-olof@lixom.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We keep this in a separate branch to avoid cross-branch conflicts, but
most of the material here is fairly boring -- some new drivers turned on
for hardware since they were merged, and some refreshed files due to
time having moved a lot of entries around.


Conflicts: None

----------------------------------------------------------------

The following changes since commit 77dde8ce535d53cab7ff0655db6e00735e52b41c:

  Merge branch 'arm/dt' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-defconfig

for you to fetch changes up to a235f803dbc878d1db83cbaabf6963ca9ef3a1a2:

  Merge tag 'aspeed-5.5-defconfig' of git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed into arm/defconfig

----------------------------------------------------------------

Adam Ford (4):
      ARM: omap2plus_defconfig: Update for removed items
      ARM: omap2plus_defconfig: Update for moved item
      ARM: omap2plus_defconfig: Enable HW Crypto engine modules
      configs: omap2plus: Enable VIDEO_MT9P031 module

Alexandre Belloni (1):
      ARM: configs: at91: unselect PIT

Anson Huang (2):
      ARM: imx_v6_v7_defconfig: Enable CONFIG_IMX7ULP_WDT by default
      arm64: defconfig: Enable CONFIG_KEYBOARD_IMX_SC_KEY as module

Biju Das (1):
      arm64: defconfig: Enable R8A774B1 SoC

Brian Masney (1):
      ARM: qcom_defconfig: add ocmem support

Corentin Labbe (2):
      ARM: configs: sunxi: add new Allwinner crypto options
      arm64: defconfig: add new Allwinner crypto options

Dinh Nguyen (2):
      arm64: defconfig: enable the Cadence QSPI controller
      arm64: defconfig: enable Altera GPIO controller

Dmitry Osipenko (1):
      ARM: tegra: Enable Tegra VDE driver in tegra_defconfig

Fabio Estevam (1):
      ARM: imx_v6_v7_defconfig: Enable CONFIG_TOUCHSCREEN_DA9052

Geert Uytterhoeven (2):
      arm64: defconfig: Enable R8A77961 SoC
      ARM: shmobile: defconfig: Refresh for v5.4-rc1

Joel Stanley (5):
      ARM: config: aspeed-g5: Enable 8250_DW quirks
      ARM: config: aspeed-g5: Add SGPIO and FSI drivers
      ARM: config: aspeed-g4: Add MMC, and cleanup
      ARM: configs: multi_v7: ASPEED network, gpio, FSI
      ARM: config: multi_v5: ASPEED SDHCI, SGPIO

Krzysztof Kozlowski (2):
      ARM: multi_v7_defconfig: Enable options for boards with Exynos SoC
      ARM: multi_v7_defconfig: Enable Exynos bus and memory frequency scaling (devfreq)

Leonard Crestez (1):
      ARM: imx_v6_v7_defconfig: Build USB_CONFIGFS into kernel

Lubomir Rintel (1):
      ARM: multi_v7_defconfig: enable MMP platforms

Lukasz Luba (1):
      ARM: exynos_defconfig: Enable DMC driver

Manivannan Sadhasivam (1):
      arm64: configs: Enable Actions Semi platform in defconfig

Mihaela Martinas (1):
      arm64: defconfig: Enable configs for S32V234

Olivier Moysan (1):
      ARM: multi_v7_defconfig: Enable audio support for stm32mp157

Olof Johansson (15):
      Merge tag 'renesas-arm64-defconfig-for-v5.5-tag1' of git://git.kernel.org/.../geert/renesas-devel into arm/defconfig
      Merge tag 'samsung-defconfig-5.5' of https://git.kernel.org/.../krzk/linux into arm/defconfig
      Merge tag 'omap-for-v5.4/fixes-rc3-signed' of git://git.kernel.org/.../tmlind/linux-omap into arm/fixes
      Merge tag 'omap-for-v5.5/defconfig-signed' of git://git.kernel.org/.../tmlind/linux-omap into arm/defconfig
      Merge tag 'arm64_defconfig_for_v5.5' of git://git.kernel.org/.../dinguyen/linux into arm/defconfig
      Merge tag 'hisi-arm64-defconfig-for-5.5' of git://github.com/hisilicon/linux-hisi into arm/defconfig
      Merge tag 'renesas-arm-defconfig-for-v5.5-tag1' of git://git.kernel.org/.../geert/renesas-devel into arm/defconfig
      Merge tag 'renesas-arm64-defconfig-for-v5.5-tag2' of git://git.kernel.org/.../geert/renesas-devel into arm/defconfig
      Merge tag 'sunxi-config-for-5.5-2' of https://git.kernel.org/.../sunxi/linux into arm/defconfig
      Merge tag 'sunxi-config64-for-5.5-1' of https://git.kernel.org/.../sunxi/linux into arm/defconfig
      Merge tag 'tegra-for-5.5-arm-defconfig' of git://git.kernel.org/.../tegra/linux into arm/defconfig
      Merge tag 'imx-defconfig-5.5' of git://git.kernel.org/.../shawnguo/linux into arm/defconfig
      Merge tag 'qcom-defconfig-for-5.5' of git://git.kernel.org/.../qcom/linux into arm/defconfig
      Merge tag 'at91-5.5-defconfig' of git://git.kernel.org/.../at91/linux into arm/defconfig
      Merge tag 'aspeed-5.5-defconfig' of git://git.kernel.org/.../joel/aspeed into arm/defconfig

Peng Fan (1):
      arm64: defconfig: Change CONFIG_AT803X_PHY from m to y

Priit Laes (1):
      ARM: configs: sunxi: Enable MICREL_PHY

Richard Gong (1):
      arm64: defconfig: enable rsu driver

Sylwester Nawrocki (1):
      ARM: exynos_defconfig: Enable Arndale audio driver

Zhou Wang (2):
      arm64: defconfig: Enable HiSilicon ZIP controller
      arm64: defconfig: Enable SMMU v3 PMCG


 arch/arm/configs/aspeed_g4_defconfig | 18 ++++++++-----
 arch/arm/configs/aspeed_g5_defconfig |  4 +++
 arch/arm/configs/at91_dt_defconfig   |  1 +
 arch/arm/configs/exynos_defconfig    |  2 ++
 arch/arm/configs/imx_v6_v7_defconfig |  4 ++-
 arch/arm/configs/multi_v5_defconfig  |  4 +++
 arch/arm/configs/multi_v7_defconfig  | 45 ++++++++++++++++++++++++++++++-
 arch/arm/configs/omap2plus_defconfig | 10 ++++---
 arch/arm/configs/qcom_defconfig      |  1 +
 arch/arm/configs/sama5_defconfig     |  1 +
 arch/arm/configs/shmobile_defconfig  |  3 ---
 arch/arm/configs/sunxi_defconfig     |  3 +++
 arch/arm/configs/tegra_defconfig     |  2 ++
 arch/arm64/configs/defconfig         | 16 ++++++++++-
 14 files changed, 98 insertions(+), 16 deletions(-)
