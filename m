Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7660C32764
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 01:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF022192A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 01:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbgABB1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 20:27:22 -0500
Received: from foss.arm.com ([217.140.110.172]:43530 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgABB1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 20:27:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BE6A1045;
        Wed,  1 Jan 2020 17:27:21 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1540E3F703;
        Wed,  1 Jan 2020 17:27:19 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 2/3] ARM: dts: sun8i: R40: Add PMU node
Date:   Thu,  2 Jan 2020 01:26:56 +0000
Message-Id: <20200102012657.9278-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20200102012657.9278-1-andre.przywara@arm.com>
References: <20200102012657.9278-1-andre.przywara@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARM Cortex-A7 cores used in the Allwinner R40 SoC have their usual
Performance Monitoring Unit (PMU), which allows perf to use hardware
events.
The SoC integrator just needs to connect each per-core interrupt line
to the GIC. The R40 manual does not really mention those IRQ lines, but
experimentation in U-Boot shows that interrupts 152-155 are connected to
the four cores (similar to the A20).

Tested on a Bananapi M2 Berry, with perf and taskset to confirm the
association between cores and interrupts.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index 768dffb37117..8dcbc4465fbb 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -78,25 +78,25 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu@0 {
+		cpu0: cpu@0 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <0>;
 		};
 
-		cpu@1 {
+		cpu1: cpu@1 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <1>;
 		};
 
-		cpu@2 {
+		cpu2: cpu@2 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <2>;
 		};
 
-		cpu@3 {
+		cpu3: cpu@3 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <3>;
@@ -884,6 +884,15 @@
 		};
 	};
 
+	pmu {
+		compatible = "arm,cortex-a7-pmu";
+		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
+	};
+
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-- 
2.14.5

