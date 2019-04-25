Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9CFC282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49917217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbfDYIeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:34:23 -0400
Received: from inva021.nxp.com ([92.121.34.21]:57836 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbfDYIeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:34:22 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D5AE72000C4;
        Thu, 25 Apr 2019 10:34:19 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 52994200069;
        Thu, 25 Apr 2019 10:34:14 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 869E3402D8;
        Thu, 25 Apr 2019 16:34:07 +0800 (SGT)
From:   Yuantian Tang <andy.tang@nxp.com>
To:     shawnguo@kernel.org
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com, Yuantian Tang <andy.tang@nxp.com>
Subject: [PATCH] arm64: dts: ls1028a: Add Thermal Monitor Unit node
Date:   Thu, 25 Apr 2019 16:26:40 +0800
Message-Id: <20190425082640.37982-1-andy.tang@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Thermal Monitoring Unit (TMU) monitors and reports the
temperature from 2 remote temperature measurement sites
located on ls1028a chip.
Add TMU dts node to enable this feature.

Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi |  114 ++++++++++++++++++++++++
 1 files changed, 114 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index b045812..a25f5fc 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -29,6 +29,7 @@
 			clocks = <&clockgen 1 0>;
 			next-level-cache = <&l2>;
 			cpu-idle-states = <&CPU_PH20>;
+			#cooling-cells = <2>;
 		};
 
 		cpu1: cpu@1 {
@@ -39,6 +40,7 @@
 			clocks = <&clockgen 1 0>;
 			next-level-cache = <&l2>;
 			cpu-idle-states = <&CPU_PH20>;
+			#cooling-cells = <2>;
 		};
 
 		l2: l2-cache {
@@ -398,6 +400,118 @@
 			status = "disabled";
 		};
 
+		tmu: tmu@1f00000 {
+			compatible = "fsl,qoriq-tmu";
+			reg = <0x0 0x1f80000 0x0 0x10000>;
+			interrupts = <0 23 0x4>;
+			fsl,tmu-range = <0xb0000 0xa0026 0x80048 0x70061>;
+			fsl,tmu-calibration = <0x00000000 0x00000024
+					       0x00000001 0x0000002b
+					       0x00000002 0x00000031
+					       0x00000003 0x00000038
+					       0x00000004 0x0000003f
+					       0x00000005 0x00000045
+					       0x00000006 0x0000004c
+					       0x00000007 0x00000053
+					       0x00000008 0x00000059
+					       0x00000009 0x00000060
+					       0x0000000a 0x00000066
+					       0x0000000b 0x0000006d
+
+					       0x00010000 0x0000001c
+					       0x00010001 0x00000024
+					       0x00010002 0x0000002c
+					       0x00010003 0x00000035
+					       0x00010004 0x0000003d
+					       0x00010005 0x00000045
+					       0x00010006 0x0000004d
+					       0x00010007 0x00000045
+					       0x00010008 0x0000005e
+					       0x00010009 0x00000066
+					       0x0001000a 0x0000006e
+
+					       0x00020000 0x00000018
+					       0x00020001 0x00000022
+					       0x00020002 0x0000002d
+					       0x00020003 0x00000038
+					       0x00020004 0x00000043
+					       0x00020005 0x0000004d
+					       0x00020006 0x00000058
+					       0x00020007 0x00000063
+					       0x00020008 0x0000006e
+
+					       0x00030000 0x00000010
+					       0x00030001 0x0000001c
+					       0x00030002 0x00000029
+					       0x00030003 0x00000036
+					       0x00030004 0x00000042
+					       0x00030005 0x0000004f
+					       0x00030006 0x0000005b
+					       0x00030007 0x00000068>;
+			little-endian;
+			#thermal-sensor-cells = <1>;
+		};
+
+		thermal-zones {
+			core-cluster {
+				polling-delay-passive = <1000>;
+				polling-delay = <5000>;
+				thermal-sensors = <&tmu 0>;
+
+				trips {
+					core_cluster_alert: core-cluster-alert {
+						temperature = <85000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
+
+					core_cluster_crit: core-cluster-crit {
+						temperature = <95000>;
+						hysteresis = <2000>;
+						type = "critical";
+					};
+				};
+
+				cooling-maps {
+					map0 {
+						trip = <&core_cluster_alert>;
+						cooling-device =
+							<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					};
+				};
+			};
+
+			ddr-controller {
+				polling-delay-passive = <1000>;
+				polling-delay = <5000>;
+				thermal-sensors = <&tmu 1>;
+
+				trips {
+					ddr_controller_alert: ddr-controller-alert {
+						temperature = <85000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
+
+					ddr_controller_crit: ddr-controller-crit {
+						temperature = <95000>;
+						hysteresis = <2000>;
+						type = "critical";
+					};
+				};
+
+				cooling-maps {
+					map0 {
+						trip = <&ddr_controller_alert>;
+						cooling-device =
+							<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					};
+				};
+			};
+		};
+
 		pcie@1f0000000 { /* Integrated Endpoint Root Complex */
 			compatible = "pci-host-ecam-generic";
 			reg = <0x01 0xf0000000 0x0 0x100000>;
-- 
1.7.1

