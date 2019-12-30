Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E84AC2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 17:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F55206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 17:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577726545;
	bh=+KQwNq1Y/RjQXnx3nXcDvZm9kdw7ojpjO2CwlX2HNgY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=RMxQaBo+7RrWmzcQcWE4gi+3zeCPl+eEB70N3tBvd6IxYS5Q5OEVOqStDatv8bXHN
	 VwgPgsN6PpdGPAR7ifeBOcz7tvZdcY7/EsgUX6vQ5rxfy+WUrQHK0DyN+U/QUTdNAC
	 7s8PD5z7o+wkN9g79JXhmlMgMRrVFhqhhKMIKpQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfL3RWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 12:22:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:57110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727207AbfL3RWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 12:22:23 -0500
Received: from localhost.localdomain (unknown [194.230.155.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD423206DB;
        Mon, 30 Dec 2019 17:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577726542;
        bh=+KQwNq1Y/RjQXnx3nXcDvZm9kdw7ojpjO2CwlX2HNgY=;
        h=From:To:Cc:Subject:Date:From;
        b=BjPjsubFm5Hu4kug+I7rcHipqLO1Xe2NpQKmC6/IuFR5t9GwXfiICfH8HB/4rPbjm
         3mJNlGzv29b+FL49Hw4Fi5ivuOY84DhnGdW+14YBrUC4GPAodwLVkiio7eeN6Px0sW
         8OeYd6ENvR4MjbGXL4q4YVWYzf7fFqbuxjxBeURQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/2] usb: host: Enable compile testing for some of drivers
Date:   Mon, 30 Dec 2019 18:22:14 +0100
Message-Id: <20191230172215.17370-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the USB host drivers can be compile tested to increase build
coverage.  Add 'if' conditional to 'default y' so they will not get
enabled by default on all other architectures.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/usb/host/Kconfig | 54 ++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 8d730180db06..da14a3d16b57 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -186,7 +186,7 @@ config USB_EHCI_FSL
 
 config USB_EHCI_MXC
 	tristate "Support for Freescale i.MX on-chip EHCI USB controller"
-	depends on ARCH_MXC
+	depends on ARCH_MXC || COMPILE_TEST
 	select USB_EHCI_ROOT_HUB_TT
 	---help---
 	  Variation of ARC USB block used in some Freescale chips.
@@ -210,8 +210,8 @@ config USB_EHCI_HCD_OMAP
 
 config USB_EHCI_HCD_ORION
 	tristate  "Support for Marvell EBU on-chip EHCI USB controller"
-	depends on USB_EHCI_HCD && (PLAT_ORION || ARCH_MVEBU)
-	default y
+	depends on USB_EHCI_HCD && (PLAT_ORION || ARCH_MVEBU || COMPILE_TEST)
+	default y if (PLAT_ORION || ARCH_MVEBU)
 	---help---
 	  Enables support for the on-chip EHCI controller on Marvell's
 	  embedded ARM SoCs, including Orion, Kirkwood, Dove, Armada XP,
@@ -221,15 +221,15 @@ config USB_EHCI_HCD_ORION
 
 config USB_EHCI_HCD_SPEAR
 	tristate "Support for ST SPEAr on-chip EHCI USB controller"
-	depends on USB_EHCI_HCD && PLAT_SPEAR
-	default y
+	depends on USB_EHCI_HCD && (PLAT_SPEAR || COMPILE_TEST)
+	default y if PLAT_SPEAR
 	---help---
 	  Enables support for the on-chip EHCI controller on
 	  ST SPEAr chips.
 
 config USB_EHCI_HCD_STI
 	tristate "Support for ST STiHxxx on-chip EHCI USB controller"
-	depends on ARCH_STI && OF
+	depends on (ARCH_STI || COMPILE_TEST) && OF
 	select GENERIC_PHY
 	select USB_EHCI_HCD_PLATFORM
 	help
@@ -238,8 +238,8 @@ config USB_EHCI_HCD_STI
 
 config USB_EHCI_HCD_AT91
 	tristate  "Support for Atmel on-chip EHCI USB controller"
-	depends on USB_EHCI_HCD && ARCH_AT91
-	default y
+	depends on USB_EHCI_HCD && (ARCH_AT91 || COMPILE_TEST)
+	default y if ARCH_AT91
 	---help---
 	  Enables support for the on-chip EHCI controller on
 	  Atmel chips.
@@ -263,20 +263,20 @@ config USB_EHCI_HCD_PPC_OF
 
 config USB_EHCI_SH
 	bool "EHCI support for SuperH USB controller"
-	depends on SUPERH
+	depends on SUPERH || COMPILE_TEST
 	---help---
 	  Enables support for the on-chip EHCI controller on the SuperH.
 	  If you use the PCI EHCI controller, this option is not necessary.
 
 config USB_EHCI_EXYNOS
 	tristate "EHCI support for Samsung S5P/EXYNOS SoC Series"
-	depends on ARCH_S5PV210 || ARCH_EXYNOS
+	depends on ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
 	help
 	  Enable support for the Samsung Exynos SOC's on-chip EHCI controller.
 
 config USB_EHCI_MV
 	tristate "EHCI support for Marvell PXA/MMP USB controller"
-	depends on (ARCH_PXA || ARCH_MMP)
+	depends on ARCH_PXA || ARCH_MMP || COMPILE_TEST
 	select USB_EHCI_ROOT_HUB_TT
 	---help---
 	  Enables support for Marvell (including PXA and MMP series) on-chip
@@ -289,7 +289,7 @@ config USB_EHCI_MV
 
 config USB_CNS3XXX_EHCI
 	bool "Cavium CNS3XXX EHCI Module (DEPRECATED)"
-	depends on ARCH_CNS3XXX
+	depends on ARCH_CNS3XXX || COMPILE_TEST
 	select USB_EHCI_HCD_PLATFORM
 	---help---
 	  This option is deprecated now and the driver was removed, use
@@ -309,7 +309,7 @@ config USB_EHCI_HCD_PLATFORM
 
 config USB_OCTEON_EHCI
 	bool "Octeon on-chip EHCI support (DEPRECATED)"
-	depends on CAVIUM_OCTEON_SOC
+	depends on CAVIUM_OCTEON_SOC || COMPILE_TEST
 	select USB_EHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
 	select USB_EHCI_HCD_PLATFORM
 	help
@@ -410,15 +410,15 @@ config USB_OHCI_HCD_OMAP1
 
 config USB_OHCI_HCD_SPEAR
 	tristate "Support for ST SPEAr on-chip OHCI USB controller"
-	depends on USB_OHCI_HCD && PLAT_SPEAR
-	default y
+	depends on USB_OHCI_HCD && (PLAT_SPEAR || COMPILE_TEST)
+	default y if PLAT_SPEAR
 	---help---
 	  Enables support for the on-chip OHCI controller on
 	  ST SPEAr chips.
 
 config USB_OHCI_HCD_STI
 	tristate "Support for ST STiHxxx on-chip OHCI USB controller"
-	depends on ARCH_STI && OF
+	depends on (ARCH_STI || COMPILE_TEST) && OF
 	select GENERIC_PHY
 	select USB_OHCI_HCD_PLATFORM
 	help
@@ -427,8 +427,8 @@ config USB_OHCI_HCD_STI
 
 config USB_OHCI_HCD_S3C2410
 	tristate "OHCI support for Samsung S3C24xx/S3C64xx SoC series"
-	depends on USB_OHCI_HCD && (ARCH_S3C24XX || ARCH_S3C64XX)
-	default y
+	depends on USB_OHCI_HCD && (ARCH_S3C24XX || ARCH_S3C64XX || COMPILE_TEST)
+	default y if (ARCH_S3C24XX || ARCH_S3C64XX)
 	---help---
 	  Enables support for the on-chip OHCI controller on
 	  S3C24xx/S3C64xx chips.
@@ -453,17 +453,17 @@ config USB_OHCI_HCD_PXA27X
 
 config USB_OHCI_HCD_AT91
 	tristate "Support for Atmel on-chip OHCI USB controller"
-	depends on USB_OHCI_HCD && ARCH_AT91 && OF
-	default y
+	depends on USB_OHCI_HCD && (ARCH_AT91 || COMPILE_TEST) && OF
+	default y if ARCH_AT91
 	---help---
 	  Enables support for the on-chip OHCI controller on
 	  Atmel chips.
 
 config USB_OHCI_HCD_OMAP3
 	tristate "OHCI support for OMAP3 and later chips"
-	depends on (ARCH_OMAP3 || ARCH_OMAP4 || SOC_OMAP5)
+	depends on ARCH_OMAP3 || ARCH_OMAP4 || SOC_OMAP5 || COMPILE_TEST
 	select USB_OHCI_HCD_PLATFORM
-	default y
+	default y if ARCH_OMAP3 || ARCH_OMAP4 || SOC_OMAP5
 	help
 	  This option is deprecated now and the driver was removed, use
 	  USB_OHCI_HCD_PLATFORM instead.
@@ -473,10 +473,10 @@ config USB_OHCI_HCD_OMAP3
 
 config USB_OHCI_HCD_DAVINCI
 	tristate "OHCI support for TI DaVinci DA8xx"
-	depends on ARCH_DAVINCI_DA8XX
+	depends on ARCH_DAVINCI_DA8XX || COMPILE_TEST
 	depends on USB_OHCI_HCD
 	select PHY_DA8XX_USB
-	default y
+	default y if ARCH_DAVINCI_DA8XX
 	help
 	  Enables support for the DaVinci DA8xx integrated OHCI
 	  controller. This driver cannot currently be a loadable
@@ -532,7 +532,7 @@ config USB_OHCI_HCD_SSB
 
 config USB_OHCI_SH
 	bool "OHCI support for SuperH USB controller (DEPRECATED)"
-	depends on SUPERH
+	depends on SUPERH || COMPILE_TEST
 	select USB_OHCI_HCD_PLATFORM
 	---help---
 	  This option is deprecated now and the driver was removed, use
@@ -543,13 +543,13 @@ config USB_OHCI_SH
 
 config USB_OHCI_EXYNOS
 	tristate "OHCI support for Samsung S5P/EXYNOS SoC Series"
-	depends on ARCH_S5PV210 || ARCH_EXYNOS
+	depends on ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
 	help
 	  Enable support for the Samsung Exynos SOC's on-chip OHCI controller.
 
 config USB_CNS3XXX_OHCI
 	bool "Cavium CNS3XXX OHCI Module (DEPRECATED)"
-	depends on ARCH_CNS3XXX
+	depends on ARCH_CNS3XXX || COMPILE_TEST
 	select USB_OHCI_HCD_PLATFORM
 	---help---
 	  This option is deprecated now and the driver was removed, use
-- 
2.17.1

