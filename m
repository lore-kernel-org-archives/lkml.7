Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB0AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1781720854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="QVRF2D/b";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="RiOBGNC9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfCRQFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:05:01 -0400
Received: from node.akkea.ca ([192.155.83.177]:40008 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbfCRQFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 12:05:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 956C44E204E;
        Mon, 18 Mar 2019 16:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1552925100; bh=Y4s3rTi45hYW1BAwIm13E+o6Xq2NadakOYNOH8Yg6LE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=QVRF2D/bw8KYDvB8JjGhaffCHdm8QfBammBjJggTiY9cKw3JczTvas+AnkfbNRgeL
         dnZ2qqPoQtLMFJGXpROgfbmlPzCAuGRdWp+7gyud0akuEncSstBXIcMc+Aj9KK5mNE
         jx9MA3TmsNQaj65JqiJI1KV3WvX58AEX2ppSowoI=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id N2gzWnvMTJTR; Mon, 18 Mar 2019 16:05:00 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 5246F4E204B;
        Mon, 18 Mar 2019 16:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1552925099; bh=Y4s3rTi45hYW1BAwIm13E+o6Xq2NadakOYNOH8Yg6LE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=RiOBGNC9smM76SBxiHHDsLsXt4nKyKHqXb1LZzHYYVdUzUXS006/dB4GzcVGSRekI
         vRHazOZw31q6K3CZw/fiFJ+HuzcU4ld/eH4NNCfFJVu7UzDhZYZ0Xhr9sjyxIFmlPE
         w4wasQopSwPW8+Z0P9/EKgNrm2bogcEt4mNvye8c=
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
Subject: [PATCH] arm64: dts: fsl: imx8mq: enable the multi sensor TMU
Date:   Mon, 18 Mar 2019 09:04:48 -0700
Message-Id: <20190318160448.28964-1-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190311213124.29325-1-angus@akkea.ca>
References: <20190311213124.29325-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the imx8mq TMU (Thermal mannagement unit) nodes for CPU,
GPU, and VPU.

This patch requires that the multi sensor patch is already applied

https://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git/patch/?id=7797ff424818c975b59c35880dbc90fe08350204

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 118 ++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 9155bd4784eb..885395e74452 100644
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
@@ -210,6 +215,119 @@
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
+
+				gpu-thermal {
+					polling-delay-passive = <250>;
+					polling-delay = <2000>;
+					thermal-sensors = <&tmu 1>;
+
+					trips {
+						cpu-crit {
+							temperature = <95000>;
+							hysteresis = <2000>;
+							type = "critical";
+						};
+					};
+				};
+
+				vpu-thermal {
+					polling-delay-passive = <250>;
+					polling-delay = <2000>;
+					thermal-sensors = <&tmu 2>;
+
+					trips {
+						cpu-crit {
+							temperature = <95000>;
+							hysteresis = <2000>;
+							type = "critical";
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

