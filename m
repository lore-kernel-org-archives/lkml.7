Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C66C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 16:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EDDA2072C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 16:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578070048;
	bh=0EbHuDwbJtOyAKJ4kjsuQeHIvJ6lBpEAcs8h0JgJUZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YdHYcMHaQA07qgO9n1d7hh9PX3KHV7lldHWdHGoJRvYXEDtWX3Ug5ND3BRnVwnez+
	 9SfPk0HOCsW9QYhhHD5H/oEmm5hEI2VrIlUXkPPa51RVjWNNR2XraSj3Z47KPz7TBl
	 BuGcvC2+XkkLmuCQM0P1qYhTCeHT5fMwcsU4ULb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgACQr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 11:47:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:33406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727912AbgACQrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 11:47:24 -0500
Received: from localhost.localdomain (unknown [194.230.155.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB174217F4;
        Fri,  3 Jan 2020 16:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578070043;
        bh=0EbHuDwbJtOyAKJ4kjsuQeHIvJ6lBpEAcs8h0JgJUZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xZXOe4I66n+Tnqy66CURLhv+G7Nq8DHCkh+Tf8tim9ZSzjTEXtxmafg9bGp+6lrum
         YpKcmI/KvtoVDMTWJL2PQMBiD7/NJBbECK8PBjfyixfiLHnr/1ne185nDgy9dP1x5A
         n3bkajaM08ZJqoJDWas/r8Vw1pUYC8InNRvzyj/I=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 2/2] phy: Enable compile testing for some of drivers
Date:   Fri,  3 Jan 2020 17:47:10 +0100
Message-Id: <20200103164710.4829-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103164710.4829-1-krzk@kernel.org>
References: <20200103164710.4829-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the phy drivers can be compile tested to increase build
coverage.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Add COMPILE_TEST to two Broadcom drivers.
---
 drivers/phy/allwinner/Kconfig | 3 ++-
 drivers/phy/broadcom/Kconfig  | 4 ++--
 drivers/phy/marvell/Kconfig   | 8 +++++---
 drivers/phy/mediatek/Kconfig  | 9 ++++++---
 drivers/phy/samsung/Kconfig   | 8 ++++----
 drivers/phy/ti/Kconfig        | 4 ++--
 6 files changed, 21 insertions(+), 15 deletions(-)

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
diff --git a/drivers/phy/broadcom/Kconfig b/drivers/phy/broadcom/Kconfig
index d3d983c128ea..b29f11c19155 100644
--- a/drivers/phy/broadcom/Kconfig
+++ b/drivers/phy/broadcom/Kconfig
@@ -50,7 +50,7 @@ config PHY_BCM_NS_USB3
 
 config PHY_NS2_PCIE
 	tristate "Broadcom Northstar2 PCIe PHY driver"
-	depends on OF && MDIO_BUS_MUX_BCM_IPROC
+	depends on (OF && MDIO_BUS_MUX_BCM_IPROC) || (COMPILE_TEST && MDIO_BUS)
 	select GENERIC_PHY
 	default ARCH_BCM_IPROC
 	help
@@ -83,7 +83,7 @@ config PHY_BRCM_SATA
 
 config PHY_BRCM_USB
 	tristate "Broadcom STB USB PHY driver"
-	depends on ARCH_BRCMSTB
+	depends on ARCH_BRCMSTB || COMPILE_TEST
 	depends on OF
 	select GENERIC_PHY
 	select SOC_BRCMSTB
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

