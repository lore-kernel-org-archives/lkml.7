Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F19CC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F54E218DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555351524;
	bh=2WzjGWG/IuZjdiWRfgwSv89YnhMwA3Iqa1iAqPLab9U=;
	h=From:To:Subject:Date:List-ID:From;
	b=iViCb0EflOBkZ6RlWdVCQ5a1T/T9QzwHfXxp1ItZslz6GzdX0Auo5fy0gPUuKmeJV
	 +xvOsqrJwIFitO2blG6uQhQJReq61rGFQjVZGMuKcFSv91Nm982rxlmWXX17ROEqcU
	 J9n+A1PuXL4RUbZx/IQ+egY/nl+DwzmlfaKz4HOo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbfDOSFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:05:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbfDOSFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:05:23 -0400
Received: from localhost.localdomain (unknown [194.230.158.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78738218A1;
        Mon, 15 Apr 2019 18:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555351521;
        bh=2WzjGWG/IuZjdiWRfgwSv89YnhMwA3Iqa1iAqPLab9U=;
        h=From:To:Subject:Date:From;
        b=WamA2y8M+9vMWU+NYKA10XH0qATIybeOBg5fRfB+HNxnxBqkN5EhefZshV8eNBp6g
         8THiKkO0cNp62Yi+5nUXE+Y4OA9ld+XencN4PmNAtcE2PwW8tD1aChpPAYpo4pcfGO
         JcNxZvaNaFj0yeofyC2N2ltp+1seBYT1MLJb4KLY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] ARM: dts: exynos: Move pmu and timer nodes out of soc
Date:   Mon, 15 Apr 2019 20:05:07 +0200
Message-Id: <20190415180510.6044-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARM PMU and ARM architected timer nodes are part of ARM CPU design
therefore they should not be inside the soc node.  This also fixes DTC
W=1 warnings like:

    arch/arm/boot/dts/exynos3250.dtsi:106.21-135.5:
        Warning (simple_bus_reg): /soc/fixed-rate-clocks: missing or empty reg/ranges property
    arch/arm/boot/dts/exynos3250.dtsi:676.7-680.5:
        Warning (simple_bus_reg): /soc/pmu: missing or empty reg/ranges property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos3250.dtsi | 12 +++++-----
 arch/arm/boot/dts/exynos4.dtsi    | 12 +++++-----
 arch/arm/boot/dts/exynos5250.dtsi | 40 +++++++++++++++----------------
 arch/arm/boot/dts/exynos54xx.dtsi | 38 ++++++++++++++---------------
 4 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 5892a9f7622f..af54b306204b 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -97,6 +97,12 @@
 		};
 	};
 
+	pmu {
+		compatible = "arm,cortex-a7-pmu";
+		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	soc: soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -673,12 +679,6 @@
 			status = "disabled";
 		};
 
-		pmu {
-			compatible = "arm,cortex-a7-pmu";
-			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
 		ppmu_dmc0: ppmu_dmc0@106a0000 {
 			compatible = "samsung,exynos-ppmu";
 			reg = <0x106a0000 0x2000>;
diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 6085e92ac2d7..1c21627e3c3c 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -51,6 +51,12 @@
 		serial3 = &serial_3;
 	};
 
+	pmu: pmu {
+		compatible = "arm,cortex-a9-pmu";
+		interrupt-parent = <&combiner>;
+		interrupts = <2 2>, <3 2>;
+	};
+
 	soc: soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -169,12 +175,6 @@
 			reg = <0x10440000 0x1000>;
 		};
 
-		pmu: pmu {
-			compatible = "arm,cortex-a9-pmu";
-			interrupt-parent = <&combiner>;
-			interrupts = <2 2>, <3 2>;
-		};
-
 		sys_reg: syscon@10010000 {
 			compatible = "samsung,exynos4-sysreg", "syscon";
 			reg = <0x10010000 0x400>;
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 80986b97dfe5..96ace6a5e2f9 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -157,6 +157,26 @@
 		};
 	};
 
+	pmu {
+		compatible = "arm,cortex-a15-pmu";
+		interrupt-parent = <&combiner>;
+		interrupts = <1 2>, <22 4>;
+	};
+
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+		/*
+		 * Unfortunately we need this since some versions
+		 * of U-Boot on Exynos don't set the CNTFRQ register,
+		 * so we need the value from DT.
+		 */
+		clock-frequency = <24000000>;
+	};
+
 	soc: soc {
 		sysram@2020000 {
 			compatible = "mmio-sram";
@@ -227,20 +247,6 @@
 			power-domains = <&pd_mau>;
 		};
 
-		timer {
-			compatible = "arm,armv7-timer";
-			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-				     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-				     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-				     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
-			/*
-			 * Unfortunately we need this since some versions
-			 * of U-Boot on Exynos don't set the CNTFRQ register,
-			 * so we need the value from DT.
-			 */
-			clock-frequency = <24000000>;
-		};
-
 		mct@101c0000 {
 			compatible = "samsung,exynos4210-mct";
 			reg = <0x101C0000 0x800>;
@@ -265,12 +271,6 @@
 			};
 		};
 
-		pmu {
-			compatible = "arm,cortex-a15-pmu";
-			interrupt-parent = <&combiner>;
-			interrupts = <1 2>, <22 4>;
-		};
-
 		pinctrl_0: pinctrl@11400000 {
 			compatible = "samsung,exynos5250-pinctrl";
 			reg = <0x11400000 0x1000>;
diff --git a/arch/arm/boot/dts/exynos54xx.dtsi b/arch/arm/boot/dts/exynos54xx.dtsi
index de26e5ee0d2d..ae866bcc30c4 100644
--- a/arch/arm/boot/dts/exynos54xx.dtsi
+++ b/arch/arm/boot/dts/exynos54xx.dtsi
@@ -25,27 +25,27 @@
 		usbdrdphy1 = &usbdrd_phy1;
 	};
 
-	soc: soc {
-		arm_a7_pmu: arm-a7-pmu {
-			compatible = "arm,cortex-a7-pmu";
-			interrupt-parent = <&gic>;
-			interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
-			status = "disabled";
-		};
+	arm_a7_pmu: arm-a7-pmu {
+		compatible = "arm,cortex-a7-pmu";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
 
-		arm_a15_pmu: arm-a15-pmu {
-			compatible = "arm,cortex-a15-pmu";
-			interrupt-parent = <&combiner>;
-			interrupts = <1 2>,
-				     <7 0>,
-				     <16 6>,
-				     <19 2>;
-			status = "disabled";
-		};
+	arm_a15_pmu: arm-a15-pmu {
+		compatible = "arm,cortex-a15-pmu";
+		interrupt-parent = <&combiner>;
+		interrupts = <1 2>,
+			     <7 0>,
+			     <16 6>,
+			     <19 2>;
+		status = "disabled";
+	};
 
+	soc: soc {
 		sysram@2020000 {
 			compatible = "mmio-sram";
 			reg = <0x02020000 0x54000>;
-- 
2.17.1

