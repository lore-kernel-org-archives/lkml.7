Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A645CC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F23B21D7A
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qBBp+moh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390540AbfISNvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 09:51:19 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:41530 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388145AbfISNvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 09:51:19 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190919135117euoutp0258c4d2be0b5d3a37b10049b7d378616d~F2zeZUYt-3138131381euoutp02M
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 13:51:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190919135117euoutp0258c4d2be0b5d3a37b10049b7d378616d~F2zeZUYt-3138131381euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568901077;
        bh=OQ5dihOny8v+RbM+6OFkzlYPe0eeXzbYXJ5UblE9aIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qBBp+moh03ulTGgVQL3TzKw+Fjh0CPg2nVLF/DQxwE7Ny+UhinjTbJGkffwW6POEh
         fTHHT72UplGSPT68qzV8UQ6usJgHj5/jqTqQ7l2ciDgcIW5M5YnqATzQfnKMfObigK
         KRMVElpVXARVt8aQhW0JeEsZm0WCU640apE/JIUM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190919135116eucas1p25a4e2b45058fe2cdbfea8d4d6b039909~F2zdvbUNQ1840418404eucas1p2M;
        Thu, 19 Sep 2019 13:51:16 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 33.67.04469.3D7838D5; Thu, 19
        Sep 2019 14:51:16 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190919135115eucas1p2e1c9c090c5a75211e5a137c598721287~F2zc9wPPy1298612986eucas1p2u;
        Thu, 19 Sep 2019 13:51:15 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190919135115eusmtrp1e0184499afe95c7abf5ad6791e5ec02c~F2zcvRnYC1748217482eusmtrp1d;
        Thu, 19 Sep 2019 13:51:15 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-b0-5d8387d30951
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 6F.21.04117.3D7838D5; Thu, 19
        Sep 2019 14:51:15 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190919135114eusmtip2196f037e1518d6cd89fd025403dbbc1e~F2zcThKUp0734307343eusmtip2X;
        Thu, 19 Sep 2019 13:51:14 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Maciej Falkowski <m.falkowski@samsung.com>, krzk@kernel.org,
        mark.rutland@arm.com, robh@kernel.org, a.hajda@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] arm64: dts: exynos: Exynos5433: swap clock order of sysmmu
Date:   Thu, 19 Sep 2019 15:50:53 +0200
Message-Id: <20190919135053.11849-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190919131944.11007-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42LZduzned0r7c2xBvueMlrcWneO1WL+ESBx
        /vwGdovLu+awWcw4v4/J4kHzOjaLtUfuslssvX6RyeL/nh3sDpwea+atYfTYtKqTzaNvyypG
        j8+b5AJYorhsUlJzMstSi/TtErgymuY9Yyr4rFrRtOgGewPjfLkuRk4OCQETie2bZ7F0MXJx
        CAmsYJS4uHwzM4TzhVFidvdOVgjnM6NEw9ImNpiWZxs3sEMkljNKvO16xATX8vflR0aQKjYB
        Q4mut11gHSICiRK3f/eDdTALrGGU+PLtHStIQljAW+LR4algDSwCqhLtZ5eA2bwCthJ7r19j
        hFgnL7F6wwFmEJtTwE5iyrwJYDdJCHxnk+g8/RrqJheJbV//sUDYwhKvjm9hh7BlJE5P7mGB
        aGhmlHh4bi07hNPDKHG5aQbUCmuJw8cvAo3lALpPU2L9Ln2IsKPE+gXb2UDCEgJ8EjfeCoKE
        mYHMSdumM0OEeSU62oQgqtUkZh1fB7f24IVLzBC2h8Sev7DgmggM1PlX2SYwys9CWLaAkXEV
        o3hqaXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYNI4/e/4px2MXy8lHWIU4GBU4uFVKG+OFWJN
        LCuuzD3EKMHBrCTCO8e0KVaINyWxsiq1KD++qDQntfgQozQHi5I4bzXDg2ghgfTEktTs1NSC
        1CKYLBMHp1QDY2Xal9SS6APrg1KXdjT/3GY0c73im9mnOJJURGVbz7Bu2HVBW1JigcQSrRXv
        BXflnjWWtJOfr+/P5WMSpCxx/1TnZN2tEUpq8ntOt1pp3JNTv9Hz/Dvr6kTDKu/aizzrt8w2
        lzx7fu2hHfu3pb9Zf87FqDbK89uD1YenzFrlEa/RE1OZpXB8qhJLcUaioRZzUXEiAN6nVAwW
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsVy+t/xe7qX25tjDaa381ncWneO1WL+ESBx
        /vwGdovLu+awWcw4v4/J4kHzOjaLtUfuslssvX6RyeL/nh3sDpwea+atYfTYtKqTzaNvyypG
        j8+b5AJYovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/Tt
        EvQymuY9Yyr4rFrRtOgGewPjfLkuRk4OCQETiWcbN7B3MXJxCAksZZQ4urObGSIhI3FyWgMr
        hC0s8edaFxtE0SdGif1vrjCBJNgEDCW63oIkODlEBJIlFh/eyQhSxCywiVFi54rLjCAJYQFv
        iUeHp4LZLAKqEu1nl4DZvAK2EnuvX2OE2CAvsXrDAbDNnAJ2ElPmTQDbLARU07nqA9MERr4F
        jAyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAgN427GfW3Ywdr0LPsQowMGoxMOrUN4cK8Sa
        WFZcmXuIUYKDWUmEd45pU6wQb0piZVVqUX58UWlOavEhRlOgoyYyS4km5wOjK68k3tDU0NzC
        0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA+O1lyKzw3Y86Nz55rGr/bbddxce
        X1jwX3/16ellAsemuRdOsD5wdM//sE0MwgzcC97Mtw7ZfWl2evWWYx85qmIetj3bZ6XxsdRP
        Te5JopTUks5CgWsnbaeu1Auav0rkWEvc5jLOpVmbWW9rcgavuRHYpRt1/reQVYE2p8i9y4c3
        3dtzL1ZE+4mEEktxRqKhFnNRcSIAgxtGEHYCAAA=
X-CMS-MailID: 20190919135115eucas1p2e1c9c090c5a75211e5a137c598721287
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190919135115eucas1p2e1c9c090c5a75211e5a137c598721287
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190919135115eucas1p2e1c9c090c5a75211e5a137c598721287
References: <20190919131944.11007-1-m.szyprowski@samsung.com>
        <CGME20190919135115eucas1p2e1c9c090c5a75211e5a137c598721287@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maciej Falkowski <m.falkowski@samsung.com>

dt-schema supports only order of names "aclk", "pclk".
Swap some sysmmu definitions to make them compatible with schema.

Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 54 +++++++++++-----------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index a76f620f7f35..ba66ea906f60 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -1179,9 +1179,9 @@
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x13a00000 0x1000>;
 			interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
-			clock-names = "pclk", "aclk";
-			clocks = <&cmu_disp CLK_PCLK_SMMU_DECON0X>,
-				<&cmu_disp CLK_ACLK_SMMU_DECON0X>;
+			clock-names = "aclk", "pclk";
+			clocks = <&cmu_disp CLK_ACLK_SMMU_DECON0X>,
+				<&cmu_disp CLK_PCLK_SMMU_DECON0X>;
 			power-domains = <&pd_disp>;
 			#iommu-cells = <0>;
 		};
@@ -1190,9 +1190,9 @@
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x13a10000 0x1000>;
 			interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
-			clock-names = "pclk", "aclk";
-			clocks = <&cmu_disp CLK_PCLK_SMMU_DECON1X>,
-				<&cmu_disp CLK_ACLK_SMMU_DECON1X>;
+			clock-names = "aclk", "pclk";
+			clocks = <&cmu_disp CLK_ACLK_SMMU_DECON1X>,
+				<&cmu_disp CLK_PCLK_SMMU_DECON1X>;
 			#iommu-cells = <0>;
 			power-domains = <&pd_disp>;
 		};
@@ -1201,9 +1201,9 @@
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x13a20000 0x1000>;
 			interrupts = <GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>;
-			clock-names = "pclk", "aclk";
-			clocks = <&cmu_disp CLK_PCLK_SMMU_TV0X>,
-				<&cmu_disp CLK_ACLK_SMMU_TV0X>;
+			clock-names = "aclk", "pclk";
+			clocks = <&cmu_disp CLK_ACLK_SMMU_TV0X>,
+				<&cmu_disp CLK_PCLK_SMMU_TV0X>;
 			#iommu-cells = <0>;
 			power-domains = <&pd_disp>;
 		};
@@ -1212,9 +1212,9 @@
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x13a30000 0x1000>;
 			interrupts = <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>;
-			clock-names = "pclk", "aclk";
-			clocks = <&cmu_disp CLK_PCLK_SMMU_TV1X>,
-				<&cmu_disp CLK_ACLK_SMMU_TV1X>;
+			clock-names = "aclk", "pclk";
+			clocks = <&cmu_disp CLK_ACLK_SMMU_TV1X>,
+				<&cmu_disp CLK_PCLK_SMMU_TV1X>;
 			#iommu-cells = <0>;
 			power-domains = <&pd_disp>;
 		};
@@ -1256,9 +1256,9 @@
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x15040000 0x1000>;
 			interrupts = <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>;
-			clock-names = "pclk", "aclk";
-			clocks = <&cmu_mscl CLK_PCLK_SMMU_M2MSCALER0>,
-				 <&cmu_mscl CLK_ACLK_SMMU_M2MSCALER0>;
+			clock-names = "aclk", "pclk";
+			clocks = <&cmu_mscl CLK_ACLK_SMMU_M2MSCALER0>,
+				<&cmu_mscl CLK_PCLK_SMMU_M2MSCALER0>;
 			#iommu-cells = <0>;
 			power-domains = <&pd_mscl>;
 		};
@@ -1267,9 +1267,9 @@
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x15050000 0x1000>;
 			interrupts = <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>;
-			clock-names = "pclk", "aclk";
-			clocks = <&cmu_mscl CLK_PCLK_SMMU_M2MSCALER1>,
-				 <&cmu_mscl CLK_ACLK_SMMU_M2MSCALER1>;
+			clock-names = "aclk", "pclk";
+			clocks = <&cmu_mscl CLK_ACLK_SMMU_M2MSCALER1>,
+				<&cmu_mscl CLK_PCLK_SMMU_M2MSCALER1>;
 			#iommu-cells = <0>;
 			power-domains = <&pd_mscl>;
 		};
@@ -1278,9 +1278,9 @@
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x15060000 0x1000>;
 			interrupts = <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>;
-			clock-names = "pclk", "aclk";
-			clocks = <&cmu_mscl CLK_PCLK_SMMU_JPEG>,
-				 <&cmu_mscl CLK_ACLK_SMMU_JPEG>;
+			clock-names = "aclk", "pclk";
+			clocks = <&cmu_mscl CLK_ACLK_SMMU_JPEG>,
+				<&cmu_mscl CLK_PCLK_SMMU_JPEG>;
 			#iommu-cells = <0>;
 			power-domains = <&pd_mscl>;
 		};
@@ -1289,9 +1289,9 @@
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x15200000 0x1000>;
 			interrupts = <GIC_SPI 352 IRQ_TYPE_LEVEL_HIGH>;
-			clock-names = "pclk", "aclk";
-			clocks = <&cmu_mfc CLK_PCLK_SMMU_MFC_0>,
-				 <&cmu_mfc CLK_ACLK_SMMU_MFC_0>;
+			clock-names = "aclk", "pclk";
+			clocks = <&cmu_mfc CLK_ACLK_SMMU_MFC_0>,
+				<&cmu_mfc CLK_PCLK_SMMU_MFC_0>;
 			#iommu-cells = <0>;
 			power-domains = <&pd_mfc>;
 		};
@@ -1300,9 +1300,9 @@
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x15210000 0x1000>;
 			interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
-			clock-names = "pclk", "aclk";
-			clocks = <&cmu_mfc CLK_PCLK_SMMU_MFC_1>,
-				 <&cmu_mfc CLK_ACLK_SMMU_MFC_1>;
+			clock-names = "aclk", "pclk";
+			clocks = <&cmu_mfc CLK_ACLK_SMMU_MFC_1>,
+				<&cmu_mfc CLK_PCLK_SMMU_MFC_1>;
 			#iommu-cells = <0>;
 			power-domains = <&pd_mfc>;
 		};
-- 
2.17.1



