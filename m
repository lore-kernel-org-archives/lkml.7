Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F010C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC96222C2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570201254;
	bh=srz/G3g4vAsJ7LR4lngT/m3wMVhgs2KbQZv4VWu4ZeQ=;
	h=From:To:Subject:Date:List-ID:From;
	b=vH1jogywYBSyY5PC+XTAwxPzcDYXAIkKDn5+Mtuv7XOaOdcWedG4DCKvkr2ypchmu
	 CaO0Bd3eadK4CisVj1OlUHVw9Cj+RbW2rOtN39caoDY45/vfFXIieHlw2bM+qGHDIc
	 znbKa8PQqXRIImXnKPo+OC/5RujcpvrgJmECA84w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389650AbfJDPAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 11:00:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:48530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388802AbfJDPAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 11:00:54 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B7472084D;
        Fri,  4 Oct 2019 15:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570201252;
        bh=srz/G3g4vAsJ7LR4lngT/m3wMVhgs2KbQZv4VWu4ZeQ=;
        h=From:To:Subject:Date:From;
        b=oEeqIaLtC24JwafZS1jGPISfbYVJhCOJwDWDYiNCVEFT8JqkyLJZtwlJ0ALZ60j/M
         iUto/HMCtz4IlaeIsd5Wrvpy2zRZawDpj3qXXLQiWCUmCAMCeP85tKTv8Ll9npCu3k
         vbbVvP60LRzdyU2b7rntvSFjc32Gp4bD3+tDcFC4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 1/2] ARM: multi_v7_defconfig: Enable options for boards with Exynos SoC
Date:   Fri,  4 Oct 2019 17:00:39 +0200
Message-Id: <20191004150040.5833-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sync with exynos_defconfig and enable following options for Samsung
Exynos SoC based boards:
1. NFC_S3FWRN5_I2C (with NFC stack): Samsung S3FWRN5 NCI NFC Controller,
   used for example on Exynos5433 (if booted in 32-bit mode),
2. S3C2410_WATCHDOG: watchdog driver used on S3C, S5P and Exynos SoCs,
3. REGULATOR_S2MPA01: Samsung S2MPA01 regulators driver present on
   Exynos5260 RexNos REX-RED board,
4. SND_SOC_ARNDALE: sound support on Arndale boards,
5. EXYNOS_IOMMU: IOMMU driver used on all Exynos SocS,,
6. EXTCON_MAX14577, EXTCON_MAX77693 and EXTCON_MAX8997: extcon drivers
   for handling micro USB on mobile Samsung boards (Trats, Trats2,
   Rinato),
7. PHY_EXYNOS5250_SATA: SATA phy for Exynos5250 present on Arndale and
   SMDK5250 boards.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

SND_SOC_ARNDALE is in progress (not yet applied)
---
 arch/arm/configs/multi_v7_defconfig | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 198de8e36d92..7f7978dba8ab 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -168,6 +168,14 @@ CONFIG_MAC80211=m
 CONFIG_RFKILL=y
 CONFIG_RFKILL_INPUT=y
 CONFIG_RFKILL_GPIO=y
+CONFIG_NFC=m
+CONFIG_NFC_DIGITAL=m
+CONFIG_NFC_NCI=m
+CONFIG_NFC_NCI_SPI=m
+CONFIG_NFC_NCI_UART=m
+CONFIG_NFC_HCI=m
+CONFIG_NFC_SHDLC=y
+CONFIG_NFC_S3FWRN5_I2C=m
 CONFIG_PCIEPORTBUS=y
 CONFIG_PCI_MVEBU=y
 CONFIG_PCI_TEGRA=y
@@ -491,12 +499,12 @@ CONFIG_BCM2835_THERMAL=m
 CONFIG_BRCMSTB_THERMAL=m
 CONFIG_ST_THERMAL_MEMMAP=y
 CONFIG_UNIPHIER_THERMAL=y
-CONFIG_WATCHDOG=y
 CONFIG_DA9063_WATCHDOG=m
 CONFIG_XILINX_WATCHDOG=y
 CONFIG_ARM_SP805_WATCHDOG=y
 CONFIG_AT91SAM9X_WATCHDOG=y
 CONFIG_SAMA5D4_WATCHDOG=y
+CONFIG_S3C2410_WATCHDOG=m
 CONFIG_DW_WATCHDOG=y
 CONFIG_DAVINCI_WATCHDOG=m
 CONFIG_ORION_WATCHDOG=y
@@ -581,6 +589,7 @@ CONFIG_REGULATOR_QCOM_RPM=y
 CONFIG_REGULATOR_QCOM_SMD_RPM=m
 CONFIG_REGULATOR_RK808=y
 CONFIG_REGULATOR_RN5T618=y
+CONFIG_REGULATOR_S2MPA01=m
 CONFIG_REGULATOR_S2MPS11=y
 CONFIG_REGULATOR_S5M8767=y
 CONFIG_REGULATOR_STM32_BOOSTER=m
@@ -711,6 +720,7 @@ CONFIG_SND_SOC_SAMSUNG_SMDK_WM8994=m
 CONFIG_SND_SOC_SMDK_WM8994_PCM=m
 CONFIG_SND_SOC_SNOW=m
 CONFIG_SND_SOC_ODROID=m
+CONFIG_SND_SOC_ARNDALE=m
 CONFIG_SND_SOC_SH4_FSI=m
 CONFIG_SND_SOC_RCAR=m
 CONFIG_SND_SOC_STI=m
@@ -933,7 +943,7 @@ CONFIG_BCM2835_MBOX=y
 CONFIG_ROCKCHIP_IOMMU=y
 CONFIG_TEGRA_IOMMU_GART=y
 CONFIG_TEGRA_IOMMU_SMMU=y
-CONFIG_REMOTEPROC=y
+CONFIG_EXYNOS_IOMMU=y
 CONFIG_ST_REMOTEPROC=m
 CONFIG_RPMSG_VIRTIO=m
 CONFIG_ASPEED_LPC_CTRL=m
@@ -968,6 +978,9 @@ CONFIG_ARCH_TEGRA_3x_SOC=y
 CONFIG_ARCH_TEGRA_114_SOC=y
 CONFIG_ARCH_TEGRA_124_SOC=y
 CONFIG_ARM_TEGRA_DEVFREQ=m
+CONFIG_EXTCON_MAX14577=m
+CONFIG_EXTCON_MAX77693=m
+CONFIG_EXTCON_MAX8997=m
 CONFIG_TI_AEMIF=y
 CONFIG_IIO=y
 CONFIG_IIO_SW_TRIGGER=y
@@ -1026,6 +1039,7 @@ CONFIG_PHY_RCAR_GEN2=m
 CONFIG_PHY_ROCKCHIP_DP=m
 CONFIG_PHY_ROCKCHIP_USB=y
 CONFIG_PHY_SAMSUNG_USB2=m
+CONFIG_PHY_EXYNOS5250_SATA=m
 CONFIG_PHY_UNIPHIER_USB2=y
 CONFIG_PHY_UNIPHIER_USB3=y
 CONFIG_PHY_MIPHY28LP=y
-- 
2.17.1

