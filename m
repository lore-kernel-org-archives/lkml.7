Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2720C2D0DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 16:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A9632080A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 16:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="hp+dQqpa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbgAAQbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 11:31:45 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36182 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbgAAQbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 11:31:44 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so3827036wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 08:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0FtJRvYoh9q2xNKRzVf3Zc+0eiYysgU3x6WIKkWsIjw=;
        b=hp+dQqpauRcTWXe7d7Bs+XBu7BAh1P7y4cscKHejI9NSq3wYic3U/SvcPZZlP5RRtI
         GymzFS+BeeC2vL0nLX95WlZ1939z9jrVJsiawpHveS/VOEvQbrLEBxvvTzkuXeVr0arh
         xVWvmQXQykzAxTV/NXHpnyw8Rv0DVRC5pLrsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0FtJRvYoh9q2xNKRzVf3Zc+0eiYysgU3x6WIKkWsIjw=;
        b=jhmE2nGhQK5PpPi87QpJFUqm7TVaBD39oHZus+sjJwuF8NONuOXOIpLcqAUw1fdGJH
         LjDU0m0WLVAaVjF13GB/ELsSJMcGdl9KnEXXxqKm/P1wsQ7NNOpQRstfS9Ljgvf893pN
         IowQY3xv40bKUCp3eoUW1nqk0ehY2FyHKuA5MSxL/UGnVdWVUtQ1eHbVpUbeRgXrllht
         W+D3sBOhiOKJHVMiZPpF7FvkX/NjA+WW6/g/eaM7vh0Hjmr+3y06r+Up2Yz2bR2jSXEX
         A8NGl4zaXn/WsXe6SH0LLPcowroVfgHLrZ8Q8dz8DuyqjSwOhXyeTt1WeDbQNq6VnU1K
         glUQ==
X-Gm-Message-State: APjAAAU2mb1ADrK/CAY3T4i/Vnzf2rj8WdmWv5g2yoo9sjnjdU96skHP
        FFNP0YcPdhbj/LGUgzZcdAzFBg==
X-Google-Smtp-Source: APXvYqwnzMEJJ+SPGaqW/TD6mWsxkHENHtRUYQ8D7TWsJAz4BFnTHQ45khvMiDb7JM9kBxIMPqa9Kw==
X-Received: by 2002:a7b:cfc9:: with SMTP id f9mr10515511wmm.1.1577896301541;
        Wed, 01 Jan 2020 08:31:41 -0800 (PST)
Received: from panicking.lan (93-46-124-24.ip107.fastwebnet.it. [93.46.124.24])
        by smtp.gmail.com with ESMTPSA id u13sm6108580wmd.36.2020.01.01.08.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 08:31:41 -0800 (PST)
From:   Michael Trimarchi <michael@amarulasolutions.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-amarula@amarulasolutions.com
Subject: [PATCH 3/3] arm64: dts: imx8mm: properly describe IRQ hierarchy
Date:   Wed,  1 Jan 2020 17:31:36 +0100
Message-Id: <20200101163136.1586-4-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200101163136.1586-1-michael@amarulasolutions.com>
References: <20200101163136.1586-1-michael@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPCv2 sits between most of the peripherals and the GIC and
functions as a wakeup controller for the CPU cores. Add already
two power domains. Those domains was tested on imx8mm board

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 31 ++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 6edbdfe2d0d7..7360dc0685eb 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/clock/imx8mm-clock.h>
+#include <dt-bindings/power/imx8mm-power.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -12,7 +13,7 @@
 #include "imx8mm-pinfunc.h"
 
 / {
-	interrupt-parent = <&gic>;
+	interrupt-parent = <&gpc>;
 	#address-cells = <2>;
 	#size-cells = <2>;
 
@@ -197,6 +198,7 @@
 		interrupts = <GIC_PPI 7
 			     (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_HIGH)>;
 		interrupt-affinity = <&A53_0>, <&A53_1>, <&A53_2>, <&A53_3>;
+		interrupt-parent = <&gic>;
 	};
 
 	timer {
@@ -206,6 +208,7 @@
 			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>, /* Virtual */
 			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>; /* Hypervisor */
 		clock-frequency = <8000000>;
+		interrupt-parent = <&gic>;
 		arm,no-tick-in-suspend;
 	};
 
@@ -498,6 +501,29 @@
 				interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 				#reset-cells = <1>;
 			};
+
+			gpc: gpc@303a0000 {
+				compatible = "fsl,imx8mm-gpc";
+				reg = <0x303a0000 0x10000>;
+				interrupt-parent = <&gic>;
+				interrupt-controller;
+				#interrupt-cells = <3>;
+
+				pgc {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					pgc_otg1: power-domain@2 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MM_POWER_DOMAIN_USB_OTG1>;
+					};
+
+					pgc_otg2: power-domain@3 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MM_POWER_DOMAIN_USB_OTG2>;
+					};
+				};
+			};
 		};
 
 		aips2: bus@30400000 {
@@ -790,6 +816,7 @@
 				assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_500M>;
 				fsl,usbphy = <&usbphynop1>;
 				fsl,usbmisc = <&usbmisc1 0>;
+				power-domains = <&pgc_otg1>;
 				status = "disabled";
 			};
 
@@ -809,6 +836,7 @@
 				assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_500M>;
 				fsl,usbphy = <&usbphynop2>;
 				fsl,usbmisc = <&usbmisc2 0>;
+				power-domains = <&pgc_otg2>;
 				status = "disabled";
 			};
 
@@ -856,6 +884,7 @@
 			#interrupt-cells = <3>;
 			interrupt-controller;
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&gic>;
 		};
 
 		ddr-pmu@3d800000 {
-- 
2.17.1

