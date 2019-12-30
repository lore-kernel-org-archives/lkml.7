Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFB0C2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 17:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D00B7206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 17:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577726700;
	bh=xProeiYu5vgPcHmICU4n7eaHiDoR3FPz703liMheMto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fWD4h+KXwlE8dQug7wvE/PHiH97ugF4JQA7LZllbjJVnlOHloDW7kIYHYk1iIrEyV
	 QK1E8eKk//Gp8aOwMBtsePOIkEHb3HW6O3pvBERIKlxnxXyrOlmh/2TfDOqbMqDZXU
	 lxYcB7TgXEUCpeExyoXLuXztjCBCcxna7Up0j2bI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfL3RZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 12:25:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:59190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727510AbfL3RY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 12:24:58 -0500
Received: from localhost.localdomain (unknown [194.230.155.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BFF520730;
        Mon, 30 Dec 2019 17:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577726698;
        bh=xProeiYu5vgPcHmICU4n7eaHiDoR3FPz703liMheMto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M/iW3Rcz/4DoY3fZmnSbrQkVyMj4c6mIzOHR1F6sj7ISyJa57elsEm4m3F+caG5X2
         CCcx6H4fWRiAsUkiFm4GBjTiFXZDyPAwFwjM2FbviltfSK9ys1dFWtCdoWBx75AGXo
         CECjIh+MP5aYHYK+bEdSUoMO9r9ve651NzGX4XkY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/2] phy: Enable compile testing for some of drivers
Date:   Mon, 30 Dec 2019 18:24:49 +0100
Message-Id: <20191230172449.17648-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191230172449.17648-1-krzk@kernel.org>
References: <20191230172449.17648-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the phy drivers can be compile tested to increase build
coverage.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/phy/allwinner/Kconfig | 3 ++-
 drivers/phy/marvell/Kconfig   | 8 +++++---
 drivers/phy/mediatek/Kconfig  | 9 ++++++---
 drivers/phy/samsung/Kconfig   | 8 ++++----
 drivers/phy/ti/Kconfig        | 4 ++--
 5 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/phy/allwinner/Kconfig b/drivers/phy/allwinner/Kconfig
index 3dab79e9d52b..e760d89d3976 100644
--- a/drivers/phy/allwinner/Kconfig
+++ b/drivers/phy/allwinner/Kconfig
@@ -48,7 +48,8 @@ config PHY_SUN9I_USB
 
 config PHY_SUN50I_USB3
 	tristate "Allwinner H6 SoC USB3 PHY driver"
-	depends on ARCH_SUNXI && HAS_IOMEM && OF
+	depends on ARCH_SUNXI || COMPILE_TEST
+	depends on HAS_IOMEM && OF
 	depends on RESET_CONTROLLER
 	select GENERIC_PHY
 	help
diff --git a/drivers/phy/marvell/Kconfig b/drivers/phy/marvell/Kconfig
index 005e02dd4a91..8f6273c837ec 100644
--- a/drivers/phy/marvell/Kconfig
+++ b/drivers/phy/marvell/Kconfig
@@ -10,14 +10,16 @@ config ARMADA375_USBCLUSTER_PHY
 
 config PHY_BERLIN_SATA
 	tristate "Marvell Berlin SATA PHY driver"
-	depends on ARCH_BERLIN && HAS_IOMEM && OF
+	depends on ARCH_BERLIN || COMPILE_TEST
+	depends on OF && HAS_IOMEM
 	select GENERIC_PHY
 	help
 	  Enable this to support the SATA PHY on Marvell Berlin SoCs.
 
 config PHY_BERLIN_USB
 	tristate "Marvell Berlin USB PHY Driver"
-	depends on ARCH_BERLIN && RESET_CONTROLLER && HAS_IOMEM && OF
+	depends on ARCH_BERLIN || COMPILE_TEST
+	depends on OF && HAS_IOMEM && RESET_CONTROLLER
 	select GENERIC_PHY
 	help
 	  Enable this to support the USB PHY on Marvell Berlin SoCs.
@@ -95,7 +97,7 @@ config PHY_PXA_28NM_USB2
 
 config PHY_PXA_USB
 	tristate "Marvell PXA USB PHY Driver"
-	depends on ARCH_PXA || ARCH_MMP
+	depends on ARCH_PXA || ARCH_MMP || COMPILE_TEST
 	select GENERIC_PHY
 	help
 	  Enable this to support Marvell PXA USB PHY driver for Marvell
diff --git a/drivers/phy/mediatek/Kconfig b/drivers/phy/mediatek/Kconfig
index 7d19134c6b7c..dee757c957f2 100644
--- a/drivers/phy/mediatek/Kconfig
+++ b/drivers/phy/mediatek/Kconfig
@@ -4,7 +4,8 @@
 #
 config PHY_MTK_TPHY
 	tristate "MediaTek T-PHY Driver"
-	depends on ARCH_MEDIATEK && OF
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	depends on OF
 	select GENERIC_PHY
 	help
 	  Say 'Y' here to add support for MediaTek T-PHY driver,
@@ -16,7 +17,8 @@ config PHY_MTK_TPHY
 
 config PHY_MTK_UFS
 	tristate "MediaTek UFS M-PHY driver"
-	depends on ARCH_MEDIATEK && OF
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	depends on OF
 	select GENERIC_PHY
 	help
 	  Support for UFS M-PHY on MediaTek chipsets.
@@ -26,7 +28,8 @@ config PHY_MTK_UFS
 
 config PHY_MTK_XSPHY
 	tristate "MediaTek XS-PHY Driver"
-	depends on ARCH_MEDIATEK && OF
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	depends on OF
 	select GENERIC_PHY
 	help
 	  Enable this to support the SuperSpeedPlus XS-PHY transceiver for
diff --git a/drivers/phy/samsung/Kconfig b/drivers/phy/samsung/Kconfig
index 290a6c70f570..349fcb23e5f3 100644
--- a/drivers/phy/samsung/Kconfig
+++ b/drivers/phy/samsung/Kconfig
@@ -32,7 +32,7 @@ config PHY_EXYNOS_PCIE
 config PHY_SAMSUNG_USB2
 	tristate "Samsung USB 2.0 PHY driver"
 	depends on HAS_IOMEM
-	depends on USB_EHCI_EXYNOS || USB_OHCI_EXYNOS || USB_DWC2
+	depends on USB_EHCI_EXYNOS || USB_OHCI_EXYNOS || USB_DWC2 || COMPILE_TEST
 	select GENERIC_PHY
 	select MFD_SYSCON
 	default ARCH_EXYNOS
@@ -60,7 +60,7 @@ config PHY_EXYNOS5250_USB2
 config PHY_S5PV210_USB2
 	bool "Support for S5PV210"
 	depends on PHY_SAMSUNG_USB2
-	depends on ARCH_S5PV210
+	depends on ARCH_S5PV210 || COMPILE_TEST
 	help
 	  Enable USB PHY support for S5PV210. This option requires that Samsung
 	  USB 2.0 PHY driver is enabled and means that support for this
@@ -69,7 +69,7 @@ config PHY_S5PV210_USB2
 
 config PHY_EXYNOS5_USBDRD
 	tristate "Exynos5 SoC series USB DRD PHY driver"
-	depends on ARCH_EXYNOS && OF
+	depends on (ARCH_EXYNOS && OF) || COMPILE_TEST
 	depends on HAS_IOMEM
 	depends on USB_DWC3_EXYNOS
 	select GENERIC_PHY
@@ -82,7 +82,7 @@ config PHY_EXYNOS5_USBDRD
 
 config PHY_EXYNOS5250_SATA
 	tristate "Exynos5250 Sata SerDes/PHY driver"
-	depends on SOC_EXYNOS5250
+	depends on SOC_EXYNOS5250 || COMPILE_TEST
 	depends on HAS_IOMEM
 	depends on OF
 	select GENERIC_PHY
diff --git a/drivers/phy/ti/Kconfig b/drivers/phy/ti/Kconfig
index 174888609779..e231c0e369c5 100644
--- a/drivers/phy/ti/Kconfig
+++ b/drivers/phy/ti/Kconfig
@@ -4,7 +4,7 @@
 #
 config PHY_DA8XX_USB
 	tristate "TI DA8xx USB PHY Driver"
-	depends on ARCH_DAVINCI_DA8XX
+	depends on ARCH_DAVINCI_DA8XX || COMPILE_TEST
 	select GENERIC_PHY
 	select MFD_SYSCON
 	help
@@ -14,7 +14,7 @@ config PHY_DA8XX_USB
 
 config PHY_DM816X_USB
 	tristate "TI dm816x USB PHY driver"
-	depends on ARCH_OMAP2PLUS
+	depends on ARCH_OMAP2PLUS || COMPILE_TEST
 	depends on USB_SUPPORT
 	select GENERIC_PHY
 	select USB_PHY
-- 
2.17.1

