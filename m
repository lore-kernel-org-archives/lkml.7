Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE04C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8193320854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="LUf21l/i";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="DgDpBw3e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbfCRPzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:55:51 -0400
Received: from node.akkea.ca ([192.155.83.177]:39658 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbfCRPzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:55:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 821C04E204D;
        Mon, 18 Mar 2019 15:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1552924548; bh=ZKmIXL7hZ7vrBz7fILjhXBL4biuzNFFbNx7IX9/DXkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=LUf21l/ik2WbL/qKmuEMUXx8ZRuGjdHJdKDdiscowf7afIUJ7It478aUnfXF3VN1N
         r6JKhnWSc1RyfzSHqZ6p8wUgXQKdiLRBvKX3TugJWHgK+xIhfei1TJVBppm1rxo0om
         hgGPVt+ToC5TtgfB0c7Y4KF9MEsqHIy3M4pPPDRI=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Yg8XH0DzW2-W; Mon, 18 Mar 2019 15:55:47 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 39A934E204B;
        Mon, 18 Mar 2019 15:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1552924547; bh=ZKmIXL7hZ7vrBz7fILjhXBL4biuzNFFbNx7IX9/DXkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=DgDpBw3eG0RFcr+b2a0MO8hBSYGLU0Y/o6vKYZzu603+iT6Tym3Wnyw+jWG+iTTlN
         KrNTpPpFzNjMkLNvuHDoBM0pQZQ0il4kqfAFIJCGlCmfkSEGG+h0RiEf7kqkpXa0Ag
         L9CtBJ+G+lc7umrsKSEi4X5AJxYDdSqh8e+OMvXQ=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus@akkea.ca, andrew.smirnov@gmail.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Carlo Caione <ccaione@baylibre.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Baruch Siach <baruch@tkos.co.il>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: fsl: imx8mq: enable the thermal management unit (TMU)
Date:   Mon, 18 Mar 2019 08:48:49 -0700
Message-Id: <20190318154849.25456-1-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190311213124.29325-1-angus@akkea.ca>
References: <20190311213124.29325-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the TMU node for the CPU

Changes since v1:

Fixed the muber of sensor cells to work with or without the multi
sensors patch.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 90 +++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 9155bd4784eb..d367aa0023c4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/power/imx8mq-power.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/thermal/thermal.h>
 #include "imx8mq-pinfunc.h"
 
 / {
@@ -89,6 +90,7 @@
 			reg = <0x0>;
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
+			#cooling-cells = <2>;
 		};
 
 		A53_1: cpu@1 {
@@ -97,6 +99,7 @@
 			reg = <0x1>;
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
+			#cooling-cells = <2>;
 		};
 
 		A53_2: cpu@2 {
@@ -105,6 +108,7 @@
 			reg = <0x2>;
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
+			#cooling-cells = <2>;
 		};
 
 		A53_3: cpu@3 {
@@ -113,6 +117,7 @@
 			reg = <0x3>;
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
+			#cooling-cells = <2>;
 		};
 
 		A53_L2: l2-cache0 {
@@ -210,6 +215,91 @@
 				#interrupt-cells = <2>;
 			};
 
+			tmu: tmu@30260000 {
+				compatible = "fsl,imx8mq-tmu";
+				reg = <0x30260000 0x10000>;
+				interrupt = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+				little-endian;
+				fsl,tmu-range = <0xb0000 0xa0026 0x80048 0x70061>;
+				fsl,tmu-calibration = <0x00000000 0x00000023
+						       0x00000001 0x00000029
+						       0x00000002 0x0000002f
+						       0x00000003 0x00000035
+						       0x00000004 0x0000003d
+						       0x00000005 0x00000043
+						       0x00000006 0x0000004b
+						       0x00000007 0x00000051
+						       0x00000008 0x00000057
+						       0x00000009 0x0000005f
+						       0x0000000a 0x00000067
+						       0x0000000b 0x0000006f
+
+						       0x00010000 0x0000001b
+						       0x00010001 0x00000023
+						       0x00010002 0x0000002b
+						       0x00010003 0x00000033
+						       0x00010004 0x0000003b
+						       0x00010005 0x00000043
+						       0x00010006 0x0000004b
+						       0x00010007 0x00000055
+						       0x00010008 0x0000005d
+						       0x00010009 0x00000067
+						       0x0001000a 0x00000070
+
+						       0x00020000 0x00000017
+						       0x00020001 0x00000023
+						       0x00020002 0x0000002d
+						       0x00020003 0x00000037
+						       0x00020004 0x00000041
+						       0x00020005 0x0000004b
+						       0x00020006 0x00000057
+						       0x00020007 0x00000063
+						       0x00020008 0x0000006f
+
+						       0x00030000 0x00000015
+						       0x00030001 0x00000021
+						       0x00030002 0x0000002d
+						       0x00030003 0x00000039
+						       0x00030004 0x00000045
+						       0x00030005 0x00000053
+						       0x00030006 0x0000005f
+						       0x00030007 0x00000071>;
+				#thermal-sensor-cells =  <1>;
+			};
+
+			thermal-zones {
+				cpu-thermal {
+					polling-delay-passive = <250>;
+					polling-delay = <2000>;
+					thermal-sensors = <&tmu 0>;
+
+					trips {
+						cpu_alert: cpu-alert {
+							temperature = <85000>;
+							hysteresis = <2000>;
+							type = "passive";
+						};
+
+						cpu_crit {
+							temperature = <95000>;
+							hysteresis = <2000>;
+							type = "critical";
+						};
+					};
+
+					cooling-maps {
+						map0 {
+							trip = <&cpu_alert>;
+							cooling-device =
+								<&A53_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								<&A53_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								<&A53_2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								<&A53_3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+						};
+					};
+				};
+			};
+
 			wdog1: watchdog@30280000 {
 				compatible = "fsl,imx8mq-wdt", "fsl,imx21-wdt";
 				reg = <0x30280000 0x10000>;
-- 
2.17.1

