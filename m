Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354BEC5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 02:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16BDA20678
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 02:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbfILCko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 22:40:44 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:55010 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726952AbfILCko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 22:40:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id D8DCBFB02;
        Thu, 12 Sep 2019 04:40:40 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VqZf75Uf_RKR; Thu, 12 Sep 2019 04:40:38 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 5495846CBF; Wed, 11 Sep 2019 19:40:36 -0700 (PDT)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     "To : Lucas Stach" <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Carlo Caione <ccaione@baylibre.com>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/2] dts: arm64: imx8mq: Enable gpu passive throttling
Date:   Wed, 11 Sep 2019 19:40:35 -0700
Message-Id: <0ab2ee7de9c2e24f6de860ffcbcdfc25b72c2c61.1568255903.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <cover.1568255903.git.agx@sigxcpu.org>
References: <cover.1568255903.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Temperature and hysteresis were picked after the CPU.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 4fdd60f2c51e..5023a0e5068d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -235,12 +235,26 @@
 			thermal-sensors = <&tmu 1>;
 
 			trips {
+				gpu_alert: gpu-alert {
+					temperature = <80000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
 				gpu-crit {
 					temperature = <90000>;
 					hysteresis = <2000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpu_alert>;
+					cooling-device =
+						<&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		vpu-thermal {
@@ -912,6 +926,7 @@
 			         <&clk IMX8MQ_CLK_GPU_AXI>,
 			         <&clk IMX8MQ_CLK_GPU_AHB>;
 			clock-names = "core", "shader", "bus", "reg";
+			#cooling-cells = <2>;
 			assigned-clocks = <&clk IMX8MQ_CLK_GPU_CORE_SRC>,
 			                  <&clk IMX8MQ_CLK_GPU_SHADER_SRC>,
 			                  <&clk IMX8MQ_CLK_GPU_AXI>,
-- 
2.23.0.rc1

