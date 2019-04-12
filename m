Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF18C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D5732186A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="tIs3Z8P4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbfDLMHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:07:45 -0400
Received: from vps.xff.cz ([195.181.215.36]:36314 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727853AbfDLMHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:07:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1555070852; bh=DlgRb649mljlYFMMyH4qWotJiy+ctlKPT9WxhNBfniE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tIs3Z8P4Iz3pZKxzAP7rxxh534VVXOaV6Ri8GMAPK9TK6i0ty5JJRz07GGVmasor3
         v6593OJ/5dNlT9y7BHZgJFAuvessYnsZw9Z263SzAhumRvKy0pmj7ozdhC1mXjza0G
         6ZhI7LiQ5ZLEUdVoKVUZxVT3gbT+wvrDUd74aFE0=
From:   megous@megous.com
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Ondrej Jirman <megous@megous.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH 3/3] arm64: dts: sun50i-h6: Add support for RTC and fix the clock tree
Date:   Fri, 12 Apr 2019 14:07:30 +0200
Message-Id: <20190412120730.473-4-megous@megous.com>
In-Reply-To: <20190412120730.473-1-megous@megous.com>
References: <20190412120730.473-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

This patch adds RTC node and fixes the clock properties and nodes
to reflect the real clock tree.

The device nodes for the internal oscillator and osc32k are removed,
as these clocks are now provided by the RTC device. Clock references
are fixed accordingly, too.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 30 +++++++++++---------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index e0dc4a05c1ba..ba0f45b6f743 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -56,14 +56,6 @@
 		status = "disabled";
 	};
 
-	iosc: internal-osc-clk {
-		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		clock-frequency = <16000000>;
-		clock-accuracy = <300000000>;
-		clock-output-names = "iosc";
-	};
-
 	osc24M: osc24M_clk {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
@@ -71,11 +63,11 @@
 		clock-output-names = "osc24M";
 	};
 
-	osc32k: osc32k_clk {
+	ext_osc32k: ext_osc32k_clk {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <32768>;
-		clock-output-names = "osc32k";
+		clock-output-names = "ext_osc32k";
 	};
 
 	psci {
@@ -197,7 +189,7 @@
 		ccu: clock@3001000 {
 			compatible = "allwinner,sun50i-h6-ccu";
 			reg = <0x03001000 0x1000>;
-			clocks = <&osc24M>, <&osc32k>, <&iosc>;
+			clocks = <&osc24M>, <&rtc 0>, <&rtc 2>;
 			clock-names = "hosc", "losc", "iosc";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
@@ -215,7 +207,7 @@
 				     <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_APB1>, <&osc24M>, <&osc32k>;
+			clocks = <&ccu CLK_APB1>, <&osc24M>, <&rtc 0>;
 			clock-names = "apb", "hosc", "losc";
 			gpio-controller;
 			#gpio-cells = <3>;
@@ -603,10 +595,20 @@
 			};
 		};
 
+		rtc: rtc@7000000 {
+			compatible = "allwinner,sun50i-h6-rtc";
+			reg = <0x07000000 0x400>;
+			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+			clock-output-names = "osc32k", "osc32k-out", "iosc";
+			clocks = <&ext_osc32k>;
+			#clock-cells = <1>;
+		};
+
 		r_ccu: clock@7010000 {
 			compatible = "allwinner,sun50i-h6-r-ccu";
 			reg = <0x07010000 0x400>;
-			clocks = <&osc24M>, <&osc32k>, <&iosc>,
+			clocks = <&osc24M>, <&rtc 0>, <&rtc 2>,
 				 <&ccu CLK_PLL_PERIPH0>;
 			clock-names = "hosc", "losc", "iosc", "pll-periph";
 			#clock-cells = <1>;
@@ -627,7 +629,7 @@
 			reg = <0x07022000 0x400>;
 			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&r_ccu CLK_R_APB1>, <&osc24M>, <&osc32k>;
+			clocks = <&r_ccu CLK_R_APB1>, <&osc24M>, <&rtc 0>;
 			clock-names = "apb", "hosc", "losc";
 			gpio-controller;
 			#gpio-cells = <3>;
-- 
2.21.0

