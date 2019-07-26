Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C6CC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A050021880
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TGH88jOQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfGZIPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 04:15:16 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40295 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfGZIPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 04:15:09 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190726081508euoutp02a9345115c13fd291158742f57c064b18~05vRz4y5A0206102061euoutp02T
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 08:15:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190726081508euoutp02a9345115c13fd291158742f57c064b18~05vRz4y5A0206102061euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1564128908;
        bh=nupSiFsT5yy8+L2dB5gm6N0NcU+S+TTvT8bj9kaAqE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TGH88jOQiVeNBloV7MwYsZIVWReBDwb3kyAWjAEpGUmaq6VEWTD+tybwoWYrPzURP
         q2oNjEU5Gx1xsbTO3JCZMHKoaRP6dUMKAA+t0i/hqlTdnroFZDHvkv2G/nFUGGQX9h
         gSKJkdltkr1kOYztiEp8OqJl6YoiRvE0NLxmNCKc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190726081507eucas1p11396e7b33a62f9047b080fd036027fcf~05vRC-CVR2125221252eucas1p1o;
        Fri, 26 Jul 2019 08:15:07 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id DA.C1.04325.B86BA3D5; Fri, 26
        Jul 2019 09:15:07 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190726081506eucas1p20e7e633e89529b862952fe9f783f72e5~05vQUUhY92724627246eucas1p20;
        Fri, 26 Jul 2019 08:15:06 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190726081506eusmtrp2bac053102a57f227f356df2b2ebc961c~05vQGNc_O3187231872eusmtrp2t;
        Fri, 26 Jul 2019 08:15:06 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-41-5d3ab68a8e78
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 1D.84.04140.A86BA3D5; Fri, 26
        Jul 2019 09:15:06 +0100 (BST)
Received: from AMDC2765.DIGITAL.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190726081505eusmtip25bfe43a5d6730b026b3327de952e0286~05vPfVDeR3050330503eusmtip2t;
        Fri, 26 Jul 2019 08:15:05 +0000 (GMT)
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
Subject: [PATCH v2 3/3] ARM: dts: exynos: Use standard arrays of generic
 PHYs for EHCI/OHCI devices
Date:   Fri, 26 Jul 2019 10:14:53 +0200
Message-Id: <20190726081453.9456-4-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726081453.9456-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfyyUcRzH+z7P3T0PdfY4Nt8k1m2Jyq9+2JNoyB/Pwmb90xbG4QnLHd35
        kUzMpelSo9mIonHJroQbwnZ+XDdHDFEJp3FZS/mxojmL6h6Pyn+v7+f7+nw/7+93XxwV9HHt
        8URJKi2ViJKEPEtOa+/6kNvtVp9IT+NnhGwqa+CSVbohLimvaeCRw8ONGDnW8YBHlg13ImR1
        bT5KzutMgKzXTWOkabYUITc+GLhkvkaHkUU/R3j+fGrSkEOpVbd4VNfDZxi1MPAKo5qW2hCq
        YtoEqLvNKkCtqB3D8IuWvnF0UmI6LfU4E22ZMD34FaT0eF2tKypBcoHRWQEscEicgN03tByG
        BUQdgN1z3iyvAlgxFasAlmZeAbBkasIs4VsN66azrPMEwMpCLuuY/fHRdpTZ4BFeULGo4DFs
        S/hD5WMDj5FQYgiFNesFCHOQDUHDigIR43CIg3C5bwYwzCd84WaxDmXDOcGnjd1bbEH4wTuf
        6hHWsYb99+e2QqNmR95SgTLnQ8KIQWXX2nZzENRsargs28Av+maMZQf4u70KYRvkAM4O1WPs
        ohDAsbwywFqn4Uv9ay6TFCVcYUOHB1sOgMaP1Qj7Elbw/aI1G8IK3mstRdkyHxbcFLC2MyzX
        P/83tmdkdDsaBRe+9yBF4ED5juuU77hO+f+5jwCqAnZ0mkwcT8uOS+gMd5lILEuTxLvHJovV
        wPy/Bn7pf7SBzo0YLSBwINzDd1GdihRwRemyTLEWQBwV2vJb2swlfpwo8xotTY6SpiXRMi3Y
        h3OEdvysXTPhAiJelEpfpukUWvp3F8Et7HNB8HL9W6crIcHvsEp1mKE4EDnk+s2ejPBT6l1a
        +MbGgahl+WLgi/NRu03eg8HjtTb7lQnOaKPnhElDGHNU4rVJxTnp3pOKwejQgksGFM248Ga+
        Xxl6Pcu+VLMU0uE4/mBRArKPbBKjQTDctlhR4lzikxfQG+OwevSYPDvCLU/IkSWIvA6jUpno
        D06GCB1bAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsVy+t/xe7pd26xiDW71C1hsnLGe1WL+kXOs
        Fs2L17NZnD+/gd3i8q45bBYzzu9jsli0rJXZ4uWRH4wWa4/cZbf48XA6k8Wfe3dYLVr3HmG3
        mPD7ApsDr8etO/Uem1Z1snnsn7uG3ePN6VPsHhvf7WDymH33B6NH35ZVjB6fN8kFcETp2RTl
        l5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZdw985qx4KBh
        xYoJU5gaGB+pdTFycEgImEj8/OHcxcjFISSwlFHi1OotzF2MnEBxGYmT0xpYIWxhiT/Xutgg
        ij4xSvz69J8JJMEmYCjR9RYkwckhIuAk0bn2NFgRs8A1ZokdFzvBEsICyRJnlz1kBLFZBFQl
        3p94AGbzCthI/J14BGqbvMTqDQfAbE4BW4neZ2vBFggB1ez/tZsNol5Q4uTMJywgVzMLqEus
        nycEEmYGam3eOpt5AqPgLCRVsxCqZiGpWsDIvIpRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMw
        Mrcd+7llB2PXu+BDjAIcjEo8vBeWW8YKsSaWFVfmHmKU4GBWEuHdugMoxJuSWFmVWpQfX1Sa
        k1p8iNEU6LWJzFKiyfnApJFXEm9oamhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaP
        iYNTqoFx53lWJw7xmtLpDVwV8uKyITO7fgt22SV4G3Sea+WcyXlk6q2NN/Ze6XUtLJD41rFB
        fndqTPZcjnIRwal7LPfbzT7pFCdk/vbP5XtmEtt3HP505k/ljhPNF9/c6jBsz5/k2+HBcNrb
        viop8J1P58Gp/zUZH0ZOfClfYnCPecbb7U0hZ1V6n4YrsRRnJBpqMRcVJwIAFnq9A+ICAAA=
X-CMS-MailID: 20190726081506eucas1p20e7e633e89529b862952fe9f783f72e5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190726081506eucas1p20e7e633e89529b862952fe9f783f72e5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190726081506eucas1p20e7e633e89529b862952fe9f783f72e5
References: <20190726081453.9456-1-m.szyprowski@samsung.com>
        <CGME20190726081506eucas1p20e7e633e89529b862952fe9f783f72e5@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move USB PHYs to a standard arrays for Exynos EHCI/OHCI devices. This
resolves the conflict between Exynos EHCI/OHCI sub-nodes and generic USB
device bindings. Once the Exynos EHCI/OHCI sub-nodes are removed, the
boards can finally provide sub-nodes for the USB devices using generic USB
device bindings.

Suggested-by: Måns Rullgård <mans@mansr.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi                | 28 +++----------------
 .../boot/dts/exynos4210-universal_c210.dts    |  8 ++----
 arch/arm/boot/dts/exynos4412-itop-elite.dts   |  9 ++----
 arch/arm/boot/dts/exynos4412-odroidu3.dts     |  8 ++----
 arch/arm/boot/dts/exynos4412-odroidx.dts      |  5 ++--
 arch/arm/boot/dts/exynos4412-origen.dts       |  9 ++----
 arch/arm/boot/dts/exynos5250.dtsi             | 16 +++--------
 arch/arm/boot/dts/exynos54xx.dtsi             | 18 +++---------
 8 files changed, 22 insertions(+), 79 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 1264cc431ff6..433f109d97ca 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -380,23 +380,8 @@
 			clocks = <&clock CLK_USB_HOST>;
 			clock-names = "usbhost";
 			status = "disabled";
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
+			phys = <&exynos_usbphy 1>, <&exynos_usbphy 2>, <&exynos_usbphy 3>;
+			phy-names = "host", "hsic0", "hsic1";
 		};
 
 		ohci: ohci@12590000 {
@@ -406,13 +391,8 @@
 			clocks = <&clock CLK_USB_HOST>;
 			clock-names = "usbhost";
 			status = "disabled";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			port@0 {
-				reg = <0>;
-				phys = <&exynos_usbphy 1>;
-				status = "disabled";
-			};
+			phys = <&exynos_usbphy 1>;
+			phy-names = "host";
 		};
 
 		gpu: gpu@13000000 {
diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
index 82a8b5449978..09d3d54d09ff 100644
--- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
+++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
@@ -204,9 +204,8 @@
 
 &ehci {
 	status = "okay";
-	port@0 {
-		status = "okay";
-	};
+	phys = <&exynos_usbphy 1>;
+	phy-names = "host";
 };
 
 &exynos_usbphy {
@@ -520,9 +519,6 @@
 
 &ohci {
 	status = "okay";
-	port@0 {
-		status = "okay";
-	};
 };
 
 &pinctrl_1 {
diff --git a/arch/arm/boot/dts/exynos4412-itop-elite.dts b/arch/arm/boot/dts/exynos4412-itop-elite.dts
index 0dedeba89b5f..f6d0a5f5d339 100644
--- a/arch/arm/boot/dts/exynos4412-itop-elite.dts
+++ b/arch/arm/boot/dts/exynos4412-itop-elite.dts
@@ -146,13 +146,8 @@
 	/* In order to reset USB ethernet */
 	samsung,vbus-gpio = <&gpc0 1 GPIO_ACTIVE_HIGH>;
 
-	port@0 {
-		status = "okay";
-	};
-
-	port@2 {
-		status = "okay";
-	};
+	phys = <&exynos_usbphy 1>, <&exynos_usbphy 3>;
+	phy-names = "host", "hsic1";
 };
 
 &exynos_usbphy {
diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
index 96d99887bceb..8ff243ba4542 100644
--- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
@@ -105,12 +105,8 @@
 };
 
 &ehci {
-	port@1 {
-		status = "okay";
-	};
-	port@2 {
-		status = "okay";
-	};
+	phys = <&exynos_usbphy 2>, <&exynos_usbphy 3>;
+	phy-names = "hsic0", "hsic1";
 };
 
 &sound {
diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts b/arch/arm/boot/dts/exynos4412-odroidx.dts
index a2251581f6b6..3ea2a0101e80 100644
--- a/arch/arm/boot/dts/exynos4412-odroidx.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
@@ -72,9 +72,8 @@
 };
 
 &ehci {
-	port@1 {
-		status = "okay";
-	};
+	phys = <&exynos_usbphy 2>;
+	phy-names = "hsic0";
 };
 
 &mshc_0 {
diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
index 698de4345d16..ecd14b283a6b 100644
--- a/arch/arm/boot/dts/exynos4412-origen.dts
+++ b/arch/arm/boot/dts/exynos4412-origen.dts
@@ -88,13 +88,8 @@
 &ehci {
 	samsung,vbus-gpio = <&gpx3 5 1>;
 	status = "okay";
-
-	port@1 {
-		status = "okay";
-	};
-	port@2 {
-		status = "okay";
-	};
+	phys = <&exynos_usbphy 2>, <&exynos_usbphy 3>;
+	phy-names = "hsic0", "hsic1";
 };
 
 &fimd {
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index d5e0392b409e..c5584f40ebfb 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -617,12 +617,8 @@
 
 			clocks = <&clock CLK_USB2>;
 			clock-names = "usbhost";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			port@0 {
-				reg = <0>;
-				phys = <&usb2_phy_gen 1>;
-			};
+			phys = <&usb2_phy_gen 1>;
+			phy-names = "host";
 		};
 
 		ohci: usb@12120000 {
@@ -632,12 +628,8 @@
 
 			clocks = <&clock CLK_USB2>;
 			clock-names = "usbhost";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			port@0 {
-				reg = <0>;
-				phys = <&usb2_phy_gen 1>;
-			};
+			phys = <&usb2_phy_gen 1>;
+			phy-names = "host";
 		};
 
 		usb2_phy_gen: phy@12130000 {
diff --git a/arch/arm/boot/dts/exynos54xx.dtsi b/arch/arm/boot/dts/exynos54xx.dtsi
index 0b27bebf9528..9c3b63b7cac6 100644
--- a/arch/arm/boot/dts/exynos54xx.dtsi
+++ b/arch/arm/boot/dts/exynos54xx.dtsi
@@ -189,26 +189,16 @@
 			compatible = "samsung,exynos4210-ehci";
 			reg = <0x12110000 0x100>;
 			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
-
-			#address-cells = <1>;
-			#size-cells = <0>;
-			port@0 {
-				reg = <0>;
-				phys = <&usb2_phy 1>;
-			};
+			phys = <&usb2_phy 1>;
+			phy-names = "host";
 		};
 
 		usbhost1: usb@12120000 {
 			compatible = "samsung,exynos4210-ohci";
 			reg = <0x12120000 0x100>;
 			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
-
-			#address-cells = <1>;
-			#size-cells = <0>;
-			port@0 {
-				reg = <0>;
-				phys = <&usb2_phy 1>;
-			};
+			phys = <&usb2_phy 1>;
+			phy-names = "host";
 		};
 
 		usb2_phy: phy@12130000 {
-- 
2.17.1

