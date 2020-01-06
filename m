Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A010C33C9B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E5221734
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578301177;
	bh=+xN2ZWTp443STxyJTpKaiqk0aiJnRo7N2aSPxx6FD+4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=X7h2d7j8Hej+l+20zcS6LSmQR5K+UUVjdtMc/Cy6pk0e+FE9S+rX4ZTvs7VJFT2MN
	 t6hOp6VEozbVWQ5Zb2G0ZCF3wRGHNFKNfsQ57Ae894YYF54DY6pLfLHBcQ1JQyYYWk
	 yeLyBwWKppmIsqKxCdgIpFUFUJX5KA1tbuF84iks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgAFI7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 03:59:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:36596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgAFI7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 03:59:36 -0500
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57A5020848;
        Mon,  6 Jan 2020 08:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578301175;
        bh=+xN2ZWTp443STxyJTpKaiqk0aiJnRo7N2aSPxx6FD+4=;
        h=From:To:Cc:Subject:Date:From;
        b=kkFtEM6sFIV+cv5vdVPOxrusKs+9p0cbvYoGSjh1NGIS56vVzUtUynmesIeOMcj+J
         MYawpmbCdrOK4i86m3grRJ9mpyO1JQSLSw7yus2CN/a80MpmQ3vbVPkxz5HvQInF76
         cDSIpMc7Nli2Hw1ft22EisUz2gC9lTyyOUHdzP1Y=
Received: by wens.tw (Postfix, from userid 1000)
        id 49A065FC12; Mon,  6 Jan 2020 16:59:34 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: sunxi: Use macros for references to CCU clocks
Date:   Mon,  6 Jan 2020 16:59:33 +0800
Message-Id: <20200106085933.9102-1-wens@kernel.org>
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
 arch/arm/boot/dts/sun5i.dtsi       | 2 +-
 arch/arm/boot/dts/sun8i-a83t.dtsi  | 6 +++---
 arch/arm/boot/dts/sun8i-r40.dtsi   | 2 +-
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 7 ++++---
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 9f0b645fd45e..0b526e6e5a95 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -185,7 +185,7 @@ ve_sram: sram-section@0 {
 		mbus: dram-controller@1c01000 {
 			compatible = "allwinner,sun5i-a13-mbus";
 			reg = <0x01c01000 0x1000>;
-			clocks = <&ccu 99>;
+			clocks = <&ccu CLK_MBUS>;
 			dma-ranges = <0x00000000 0x40000000 0x20000000>;
 			#interconnect-cells = <1>;
 		};
diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 93a6df11cb18..74ac7ee9383c 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -1006,9 +1006,9 @@ emac: ethernet@1c30000 {
 			reg = <0x01c30000 0x104>;
 			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
-			resets = <&ccu 13>;
+			resets = <&ccu CLK_BUS_EMAC>;
 			reset-names = "stmmaceth";
-			clocks = <&ccu 27>;
+			clocks = <&ccu RST_BUS_EMAC>;
 			clock-names = "stmmaceth";
 			status = "disabled";
 
@@ -1102,7 +1102,7 @@ r_ccu: clock@1f01400 {
 			compatible = "allwinner,sun8i-a83t-r-ccu";
 			reg = <0x01f01400 0x400>;
 			clocks = <&osc24M>, <&osc16Md512>, <&osc16M>,
-				 <&ccu 6>;
+				 <&ccu CLK_PLL_PERIPH>;
 			clock-names = "hosc", "losc", "iosc", "pll-periph";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index 84d240c39f0f..40e2f9b710cd 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -913,7 +913,7 @@ hdmi_phy: hdmi-phy@1ef0000 {
 			compatible = "allwinner,sun8i-r40-hdmi-phy";
 			reg = <0x01ef0000 0x10000>;
 			clocks = <&ccu CLK_BUS_HDMI1>, <&ccu CLK_HDMI_SLOW>,
-				 <&ccu 7>, <&ccu 16>;
+				 <&ccu CLK_PLL_VIDEO0>, <&ccu CLK_PLL_VIDEO1>;
 			clock-names = "bus", "mod", "pll-0", "pll-1";
 			resets = <&ccu RST_BUS_HDMI0>;
 			reset-names = "phy";
diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 6e68ed831015..5e9c3060aa08 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -559,7 +559,7 @@ external_mdio: mdio@2 {
 		mbus: dram-controller@1c62000 {
 			compatible = "allwinner,sun8i-h3-mbus";
 			reg = <0x01c62000 0x1000>;
-			clocks = <&ccu 113>;
+			clocks = <&ccu CLK_MBUS>;
 			dma-ranges = <0x00000000 0x40000000 0xc0000000>;
 			#interconnect-cells = <1>;
 		};
@@ -817,7 +817,7 @@ hdmi_phy: hdmi-phy@1ef0000 {
 			compatible = "allwinner,sun8i-h3-hdmi-phy";
 			reg = <0x01ef0000 0x10000>;
 			clocks = <&ccu CLK_BUS_HDMI>, <&ccu CLK_HDMI_DDC>,
-				 <&ccu 6>;
+				 <&ccu CLK_PLL_VIDEO>;
 			clock-names = "bus", "mod", "pll-0";
 			resets = <&ccu RST_BUS_HDMI0>;
 			reset-names = "phy";
@@ -837,7 +837,8 @@ rtc: rtc@1f00000 {
 		r_ccu: clock@1f01400 {
 			compatible = "allwinner,sun8i-h3-r-ccu";
 			reg = <0x01f01400 0x100>;
-			clocks = <&osc24M>, <&rtc 0>, <&rtc 2>, <&ccu 9>;
+			clocks = <&osc24M>, <&rtc 0>, <&rtc 2>,
+				 <&ccu CLK_PLL_PERIPH0>;
 			clock-names = "hosc", "losc", "iosc", "pll-periph";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
-- 
2.24.1

