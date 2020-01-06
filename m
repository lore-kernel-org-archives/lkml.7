Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C777DC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 09:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973892467C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 09:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578301235;
	bh=vQyBywdReqFFBKgdcXyrug3COE2qkfjhTUa8UfiyK4o=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=GbKAL7KrsJpwdz63d0+r/Mio+WKmgm13tk5Z+H0Huqv6nf26jOtLHdPFC7ZNueMkM
	 y2XE2GPXbsfCHSDApWg5z+OSbuwmF4nHDjX9/KHZsu3bYfV0K5a4RGNRsRjrG6Wa+M
	 0jwVVHr7h2NjBYazzy7/vXD0u0ZSEsBcVdt2zp+s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgAFJAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 04:00:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:37370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgAFJAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 04:00:34 -0500
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F17F320848;
        Mon,  6 Jan 2020 09:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578301234;
        bh=vQyBywdReqFFBKgdcXyrug3COE2qkfjhTUa8UfiyK4o=;
        h=From:To:Cc:Subject:Date:From;
        b=w46tN5kAiqSuaX0ajqvmx8wQw/Nx2eAOWF4NO+0j4/P9Y8otmSdz/PqG2VV15OIOP
         zD19L0rsREe3T8cVPZYxFKXNPElV4HTcQxAkDQ0jlI3/NY/LGJaM8I9BzvVeUiOyCa
         NAAjcCvEwgIfcdvZQrAPxykh4kpMcCSl8nqUm1/4=
Received: by wens.tw (Postfix, from userid 1000)
        id A9E705FC12; Mon,  6 Jan 2020 17:00:32 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: allwinner: sun50i-a64: Use macros for newly exported clocks
Date:   Mon,  6 Jan 2020 17:00:30 +0800
Message-Id: <20200106090030.9165-1-wens@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

A few clocks from the CCU were exported later, and references to them in
the device tree were using raw numbers.

Now that the DT binding header changes are in as well, switch to the
macros for more clarity.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 92688b89c2a4..293059ffbbf6 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -590,7 +590,7 @@ pio: pinctrl@1c20800 {
 			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu 58>, <&osc24M>, <&rtc 0>;
+			clocks = <&ccu CLK_BUS_PIO>, <&osc24M>, <&rtc 0>;
 			clock-names = "apb", "hosc", "losc";
 			gpio-controller;
 			#gpio-cells = <3>;
@@ -1091,7 +1091,7 @@ hdmi_phy: hdmi-phy@1ef0000 {
 			compatible = "allwinner,sun50i-a64-hdmi-phy";
 			reg = <0x01ef0000 0x10000>;
 			clocks = <&ccu CLK_BUS_HDMI>, <&ccu CLK_HDMI_DDC>,
-				 <&ccu 7>;
+				 <&ccu CLK_PLL_VIDEO0>;
 			clock-names = "bus", "mod", "pll-0";
 			resets = <&ccu RST_BUS_HDMI0>;
 			reset-names = "phy";
@@ -1121,7 +1121,8 @@ r_intc: interrupt-controller@1f00c00 {
 		r_ccu: clock@1f01400 {
 			compatible = "allwinner,sun50i-a64-r-ccu";
 			reg = <0x01f01400 0x100>;
-			clocks = <&osc24M>, <&rtc 0>, <&rtc 2>, <&ccu 11>;
+			clocks = <&osc24M>, <&rtc 0>, <&rtc 2>,
+				 <&ccu CLK_PLL_PERIPH0>;
 			clock-names = "hosc", "losc", "iosc", "pll-periph";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
-- 
2.24.1

