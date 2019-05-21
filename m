Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8207FC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 12:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4441E2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 12:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dOB7MgmL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbfEUMDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 08:03:36 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47361 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfEUMDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 08:03:34 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190521120331euoutp02e7a318470726c807ea3186a5ae4f2025~gsR2U-V3G2223422234euoutp02i
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 12:03:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190521120331euoutp02e7a318470726c807ea3186a5ae4f2025~gsR2U-V3G2223422234euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1558440211;
        bh=7tDTcPVWFmS86CkqkusrjjX7zb8niTkVNSvXSIqdS6U=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=dOB7MgmLMIvXZS9TdLFIVeMvaHRkX733QhXm1n0C3gKUPZ2RO/ojjCDS+DDkPhgf4
         4vUgWPojUttyWJi6BHycHB9fXAEhTP05ahucRMkAm16OvgwdUExNHmSy5upHogMVCe
         Hzi9qejK5A9q7NcD/A2Ty7H3FoWc3plAhJLoEZX8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190521120330eucas1p2da95802eb79b05ada8097a202256a5f8~gsR1k3Myt2818228182eucas1p2X;
        Tue, 21 May 2019 12:03:30 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 0F.E0.04325.219E3EC5; Tue, 21
        May 2019 13:03:30 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190521120330eucas1p21d9704bfd16f286ae764d20e456ef6b3~gsR066utZ2818228182eucas1p2U;
        Tue, 21 May 2019 12:03:30 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-d5-5ce3e91216af
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 2C.72.04146.219E3EC5; Tue, 21
        May 2019 13:03:30 +0100 (BST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from AMDC2765.DIGITAL.local ([106.120.51.73]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PRU006F4RY90T20@eusync4.samsung.com>;
        Tue, 21 May 2019 13:03:30 +0100 (BST)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        =?UTF-8?q?M=C3=A5ns=20Rullg=C3=A5rd?= <mans@mansr.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Peter Chen <peter.chen@nxp.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 4/5] ARM: dts: exynos: Remove obsolete port sub-nodes from
 EHCI/OHCI devices
Date:   Tue, 21 May 2019 13:58:48 +0200
Message-id: <20190521115849.9882-5-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190521115849.9882-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7djP87pCLx/HGMx7rmSxccZ6Vov5R86x
        WjQvXs9mcf78BnaLy7vmsFnMOL+PyWLRslZmi5dHfjBarD1yl93ix8PpTBZ/7t1htWjde4Td
        YsLvC2wOvB637tR7bFrVyeaxf+4ado83p0+xe2x8t4PJY/bdH4wefVtWMXp83iQXwBHFZZOS
        mpNZllqkb5fAlfGpfSlbwUSdihuXXzE3MB5S6mLk4JAQMJFoeJbRxcjFISSwglFi1q2XTBDO
        Z0aJ5l3L2LsYOcGKvnT3s0IkljFK/Jh/jhkkwSsgKPFj8j0WkEnMAvISRy5lg4SZBTQltu5e
        zw5R/59R4sb0VWCD2AQMJbredrGB2CICDhJLlt5hAyliFjjHLLH4ZwcTSEJYIE5i+d1JYAtY
        BFQlDk55xASxzEbi/fMTUBfJS6zecACshlPAVmJ+03NmkEESAv/ZJLpn9LJBFLlInNnSCGXL
        SHR2HGSCKGpmlHh4bi07hNPDKHG5aQYjRJW1xOHjF1khnuCTmLRtOjMklHglOtqEIEo8JBZe
        +MwM8dsERokPc1azTGCUnoUUHLMQwTELKTgWMDKvYhRPLS3OTU8tNs5LLdcrTswtLs1L10vO
        z93ECEwop/8d/7qDcd+fpEOMAhyMSjy8Fg8fxwixJpYVV+YeYpTgYFYS4T196lGMEG9KYmVV
        alF+fFFpTmrxIUZpDhYlcd5qhgfRQgLpiSWp2ampBalFMFkmDk6pBkbn4NW1n1SL1KW5xKNP
        Hvl5cKuDwkUxWy3zqzJtkUmbN7NsdVs4bconv0I+doEPnw8leVUUuvwWWXbjCnfMr7PcFXIs
        OvMSnUpbjDMWXE/oCp17mV//tfa6mkL5xLmsEiall62LNjxfOC3091vzSoPuaV7PVJ2aWHfr
        no6bv/OJ8/N7YRa175VYijMSDbWYi4oTASylQmUkAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsVy+t/xa7pCLx/HGCy5yG6xccZ6Vov5R86x
        WjQvXs9mcf78BnaLy7vmsFnMOL+PyWLRslZmi5dHfjBarD1yl93ix8PpTBZ/7t1htWjde4Td
        YsLvC2wOvB637tR7bFrVyeaxf+4ado83p0+xe2x8t4PJY/bdH4wefVtWMXp83iQXwBHFZZOS
        mpNZllqkb5fAlfGpfSlbwUSdihuXXzE3MB5S6mLk5JAQMJH40t3P2sXIxSEksIRR4uLO3ewg
        CV4BQYkfk++xdDFycDALyEscuZQNEmYWUJeYNG8RM4gtJNDIJDHlvDSIzSZgKNH1tosNxBYR
        cJBYsvQOG8hMZoELzBKdO/6AzRQWiJNYfncSWDOLgKrEwSmPmCB22Ui8f36CHeIgeYnVGw6A
        1XAK2ErMb3oOtcxG4tWMDuYJjPyzkJw3C+G8WUjOW8DIvIpRJLW0ODc9t9hQrzgxt7g0L10v
        OT93EyMwQrYd+7l5B+OljcGHGAU4GJV4eB/cexwjxJpYVlyZe4hRgoNZSYT39KlHMUK8KYmV
        ValF+fFFpTmpxYcYpTlYlMR5OwQOxggJpCeWpGanphakFsFkmTg4pRoYJ9+S2+7zTzJ96nTt
        RRmtgdMChZZOevprBfc6seMnT+V2TJiX9YSNuXbOl+7s3JXGaqUysU5xKZMCGbu8IxutHm69
        v3R7qKpEOqfqVTmdDIH8Q/PsfD9O6psUvOCm0wefgAMXzWfsFWWSnBcxJXHPs8VSbv5vT4Uc
        /6K+J2zjRAtxjfmskWHXlFiKMxINtZiLihMBfxp30IwCAAA=
X-CMS-MailID: 20190521120330eucas1p21d9704bfd16f286ae764d20e456ef6b3
CMS-TYPE: 201P
X-CMS-RootMailID: 20190521120330eucas1p21d9704bfd16f286ae764d20e456ef6b3
References: <20190521115849.9882-1-m.szyprowski@samsung.com>
        <CGME20190521120330eucas1p21d9704bfd16f286ae764d20e456ef6b3@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove custom port sub-nodes from EHCI/OHCI devices. This way boards can
define sub-nodes for the USB devices using generic USB device bindings.

Suggested-by: Måns Rullgård <mans@mansr.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi                | 24 -------------------
 .../boot/dts/exynos4210-universal_c210.dts    |  6 -----
 arch/arm/boot/dts/exynos4412-itop-elite.dts   |  7 ------
 arch/arm/boot/dts/exynos4412-odroidu3.dts     |  6 -----
 arch/arm/boot/dts/exynos4412-odroidx.dts      |  3 ---
 arch/arm/boot/dts/exynos4412-origen.dts       |  7 ------
 arch/arm/boot/dts/exynos5250.dtsi             | 12 ----------
 arch/arm/boot/dts/exynos54xx.dtsi             | 14 -----------
 8 files changed, 79 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 7b94fbd9ed6c..09cae6a0ca77 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -382,23 +382,6 @@
 			status = "disabled";
 			phys = <&exynos_usbphy 1>, <&exynos_usbphy 2>, <&exynos_usbphy 3>;
 			phy-names = "host", "hsic0", "hsic1";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			port@0 {
-				reg = <0>;
-				phys = <&exynos_usbphy 1>;
-				status = "disabled";
-			};
-			port@1 {
-				reg = <1>;
-				phys = <&exynos_usbphy 2>;
-				status = "disabled";
-			};
-			port@2 {
-				reg = <2>;
-				phys = <&exynos_usbphy 3>;
-				status = "disabled";
-			};
 		};
 
 		ohci: ohci@12590000 {
@@ -410,13 +393,6 @@
 			status = "disabled";
 			phys = <&exynos_usbphy 1>;
 			phy-names = "host";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			port@0 {
-				reg = <0>;
-				phys = <&exynos_usbphy 1>;
-				status = "disabled";
-			};
 		};
 
 		i2s1: i2s@13960000 {
diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
index dbd6b43dbe52..c1c2fd537333 100644
--- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
+++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
@@ -206,9 +206,6 @@
 	status = "okay";
 	phys = <&exynos_usbphy 1>;
 	phy-names = "host";
-	port@0 {
-		status = "okay";
-	};
 };
 
 &exynos_usbphy {
@@ -517,9 +514,6 @@
 
 &ohci {
 	status = "okay";
-	port@0 {
-		status = "okay";
-	};
 };
 
 &pinctrl_1 {
diff --git a/arch/arm/boot/dts/exynos4412-itop-elite.dts b/arch/arm/boot/dts/exynos4412-itop-elite.dts
index 1763b42c01cb..f6d0a5f5d339 100644
--- a/arch/arm/boot/dts/exynos4412-itop-elite.dts
+++ b/arch/arm/boot/dts/exynos4412-itop-elite.dts
@@ -148,13 +148,6 @@
 
 	phys = <&exynos_usbphy 1>, <&exynos_usbphy 3>;
 	phy-names = "host", "hsic1";
-	port@0 {
-		status = "okay";
-	};
-
-	port@2 {
-		status = "okay";
-	};
 };
 
 &exynos_usbphy {
diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
index 5bbaccffc9be..8ff243ba4542 100644
--- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
@@ -107,12 +107,6 @@
 &ehci {
 	phys = <&exynos_usbphy 2>, <&exynos_usbphy 3>;
 	phy-names = "hsic0", "hsic1";
-	port@1 {
-		status = "okay";
-	};
-	port@2 {
-		status = "okay";
-	};
 };
 
 &sound {
diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts b/arch/arm/boot/dts/exynos4412-odroidx.dts
index 306dd9365a91..3ea2a0101e80 100644
--- a/arch/arm/boot/dts/exynos4412-odroidx.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
@@ -74,9 +74,6 @@
 &ehci {
 	phys = <&exynos_usbphy 2>;
 	phy-names = "hsic0";
-	port@1 {
-		status = "okay";
-	};
 };
 
 &mshc_0 {
diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
index e609e2af22d1..ecd14b283a6b 100644
--- a/arch/arm/boot/dts/exynos4412-origen.dts
+++ b/arch/arm/boot/dts/exynos4412-origen.dts
@@ -90,13 +90,6 @@
 	status = "okay";
 	phys = <&exynos_usbphy 2>, <&exynos_usbphy 3>;
 	phy-names = "hsic0", "hsic1";
-
-	port@1 {
-		status = "okay";
-	};
-	port@2 {
-		status = "okay";
-	};
 };
 
 &fimd {
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 2d23e99985e1..c5584f40ebfb 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -619,12 +619,6 @@
 			clock-names = "usbhost";
 			phys = <&usb2_phy_gen 1>;
 			phy-names = "host";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			port@0 {
-				reg = <0>;
-				phys = <&usb2_phy_gen 1>;
-			};
 		};
 
 		ohci: usb@12120000 {
@@ -636,12 +630,6 @@
 			clock-names = "usbhost";
 			phys = <&usb2_phy_gen 1>;
 			phy-names = "host";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			port@0 {
-				reg = <0>;
-				phys = <&usb2_phy_gen 1>;
-			};
 		};
 
 		usb2_phy_gen: phy@12130000 {
diff --git a/arch/arm/boot/dts/exynos54xx.dtsi b/arch/arm/boot/dts/exynos54xx.dtsi
index ab1642cf0428..97746a68791a 100644
--- a/arch/arm/boot/dts/exynos54xx.dtsi
+++ b/arch/arm/boot/dts/exynos54xx.dtsi
@@ -182,13 +182,6 @@
 			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 			phys = <&usb2_phy 1>;
 			phy-names = "host";
-
-			#address-cells = <1>;
-			#size-cells = <0>;
-			port@0 {
-				reg = <0>;
-				phys = <&usb2_phy 1>;
-			};
 		};
 
 		usbhost1: usb@12120000 {
@@ -197,13 +190,6 @@
 			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 			phys = <&usb2_phy 1>;
 			phy-names = "host";
-
-			#address-cells = <1>;
-			#size-cells = <0>;
-			port@0 {
-				reg = <0>;
-				phys = <&usb2_phy 1>;
-			};
 		};
 
 		usb2_phy: phy@12130000 {
-- 
2.17.1

