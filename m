Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A28C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64969218A1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555353294;
	bh=+sCfjG74JGs7xbwFPNw6ZPP3o1n4Pxw58RMWDLf9TlM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=FPUE2ASm/xBxnkPm+9FkIZbZVlBvZXotaiSdil739BE+aRJRyQTrtv/6Z3okeoNtT
	 diUAk7kM/HlCq4XFNdYyLgUTMjfPVvdmRg6QrXu0jQTEDvkSOvSwjZ5z5Ld25Kxtd/
	 +25/pNmvH69Arik2mizvlVIeDHScXK7fBEFBvU7Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfDOSex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:34:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbfDOSex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:34:53 -0400
Received: from localhost.localdomain (unknown [194.230.158.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 614BA2087C;
        Mon, 15 Apr 2019 18:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555353292;
        bh=+sCfjG74JGs7xbwFPNw6ZPP3o1n4Pxw58RMWDLf9TlM=;
        h=From:To:Cc:Subject:Date:From;
        b=odmWyhwL+rZiPo1rT1ranLpYFUdtyL5jDuwQ54S5ZyAuOsd2kQH+hAMOJhVCCJfv2
         r44yVqn85VEZZuzknMDOkUZXs3fCdgxi7UVn8ueDvKnfuBCqmdjl/bUxnUOJ4z+BhP
         OR3IR82BIczAfFDP7J004nFJ1WFZWQcorWRSyUvc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sylwester Nawrocki <snawrocki@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 1/2] arm64: dts: exynos: Move pmu and timer nodes out of soc
Date:   Mon, 15 Apr 2019 20:34:39 +0200
Message-Id: <20190415183440.19697-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARM PMU and ARM architected timer nodes are part of ARM CPU design
therefore they should not be inside the soc node.  This also fixes DTC
W=1 warnings like:

    arch/arm64/boot/dts/exynos/exynos7.dtsi:472.11-480.5:
        Warning (simple_bus_reg): /soc/arm-pmu: missing or empty reg/ranges property
    arch/arm64/boot/dts/exynos/exynos7.dtsi:482.9-492.5:
        Warning (simple_bus_reg): /soc/timer: missing or empty reg/ranges property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 36 +++++++++---------
 arch/arm64/boot/dts/exynos/exynos7.dtsi    | 44 +++++++++++-----------
 2 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 41ecbc49c61e..62cedf9855cf 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -23,6 +23,24 @@
 
 	interrupt-parent = <&gic>;
 
+	arm_a53_pmu {
+		compatible = "arm,cortex-a53-pmu", "arm,armv8-pmuv3";
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
+	};
+
+	arm_a57_pmu {
+		compatible = "arm,cortex-a57-pmu", "arm,armv8-pmuv3";
+		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu4>, <&cpu5>, <&cpu6>, <&cpu7>;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -237,24 +255,6 @@
 		#size-cells = <1>;
 		ranges;
 
-		arm_a53_pmu {
-			compatible = "arm,cortex-a53-pmu", "arm,armv8-pmuv3";
-			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
-		};
-
-		arm_a57_pmu {
-			compatible = "arm,cortex-a57-pmu", "arm,armv8-pmuv3";
-			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-affinity = <&cpu4>, <&cpu5>, <&cpu6>, <&cpu7>;
-		};
-
 		chipid@10000000 {
 			compatible = "samsung,exynos4210-chipid";
 			reg = <0x10000000 0x100>;
diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index 967558a93d82..f83ad4c491f2 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -28,6 +28,16 @@
 		tmuctrl0 = &tmuctrl_0;
 	};
 
+	arm-pmu {
+		compatible = "arm,cortex-a57-pmu", "arm,armv8-pmuv3";
+		interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu_atlas0>, <&cpu_atlas1>,
+				     <&cpu_atlas2>, <&cpu_atlas3>;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -469,28 +479,6 @@
 			status = "disabled";
 		};
 
-		arm-pmu {
-			compatible = "arm,cortex-a57-pmu", "arm,armv8-pmuv3";
-			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-affinity = <&cpu_atlas0>, <&cpu_atlas1>,
-					     <&cpu_atlas2>, <&cpu_atlas3>;
-		};
-
-		timer {
-			compatible = "arm,armv8-timer";
-			interrupts = <GIC_PPI 13
-					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
-				     <GIC_PPI 14
-					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
-				     <GIC_PPI 11
-					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
-				     <GIC_PPI 10
-					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
-		};
-
 		pmu_system_controller: system-controller@105c0000 {
 			compatible = "samsung,exynos7-pmu", "syscon";
 			reg = <0x105c0000 0x5000>;
@@ -635,6 +623,18 @@
 			};
 		};
 	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13
+				(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14
+				(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11
+				(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10
+				(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
+	};
 };
 
 #include "exynos7-pinctrl.dtsi"
-- 
2.17.1

