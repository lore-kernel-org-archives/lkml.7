Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8883C33C9A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7917524679
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578300165;
	bh=VJ4ImZ00cxy3xkCVmZ6KZaFMceyqzh4UVXc9csKCJc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XTvIJPPtC6Nok0/cs57zwObXb8jzpO5uOLteBQOnNP4vyn4yovu60/aBXT++A6Up9
	 oiLEPnlZssG3tor6k5XS0RUI3trZ1L+SmEOaWP3L1vvucJS/Ul8hRjC9XDYr74OQX8
	 8leRCpsQeTgLVfRTVsNpRGIVLoPuduKoTfzTU3KY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgAFImo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 03:42:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:40106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgAFImo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 03:42:44 -0500
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 605E221734;
        Mon,  6 Jan 2020 08:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578300163;
        bh=VJ4ImZ00cxy3xkCVmZ6KZaFMceyqzh4UVXc9csKCJc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jy2xk/me0XoytAHWGwDMuBVDqNtR7ItKlG980kKOeHCSXvb2oamlqMb0VFYEZSkSz
         aIC0LdHDay20/0Goe6o4x3cmR22PzfOLbioj2kyxn6laabk1Mfbqa71O+p2cq19vLv
         ibfxE/BxKLtWTGhQzVmyv6hEe8hWINX4ZnJAQdws=
Received: by wens.tw (Postfix, from userid 1000)
        id 60F0D5FD64; Mon,  6 Jan 2020 16:42:41 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] ARM: dts: sun8i: r40: Add device node for CSI0
Date:   Mon,  6 Jan 2020 16:42:37 +0800
Message-Id: <20200106084240.1076-5-wens@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106084240.1076-1-wens@kernel.org>
References: <20200106084240.1076-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The CSI0 and CSI1 blocks are the same as found on the A20. However only
CSI0 is supported upstream right now.

Add a device node for CSI0 using the A20 compatible as a fallback, and
the standard pinctrl options. Also add the MBUS interconnect.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 36 ++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index 7c940b20b81c..84d240c39f0f 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -181,6 +181,20 @@ nmi_intc: interrupt-controller@1c00030 {
 			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		csi0: csi@1c09000 {
+			compatible = "allwinner,sun8i-r40-csi0",
+				     "allwinner,sun7i-a20-csi0";
+			reg = <0x01c09000 0x1000>;
+			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_CSI0>, <&ccu CLK_CSI_SCLK>,
+				 <&ccu CLK_DRAM_CSI0>;
+			clock-names = "bus", "isp", "ram";
+			resets = <&ccu RST_BUS_CSI0>;
+			interconnects = <&mbus 5>;
+			interconnect-names = "dma-mem";
+			status = "disabled";
+		};
+
 		mmc0: mmc@1c0f000 {
 			compatible = "allwinner,sun8i-r40-mmc",
 				     "allwinner,sun50i-a64-mmc";
@@ -356,6 +370,20 @@ clk_out_a_pin: clk-out-a-pin {
 				function = "clk_out_a";
 			};
 
+			/omit-if-no-ref/
+			csi0_8bits_pins: csi0-8bits-pins {
+				pins = "PE0", "PE2", "PE3", "PE4", "PE5",
+				       "PE6", "PE7", "PE8", "PE9", "PE10",
+				       "PE11";
+				function = "csi0";
+			};
+
+			/omit-if-no-ref/
+			csi0_mclk_pin: csi0-mclk-pin {
+				pins = "PE1";
+				function = "csi0";
+			};
+
 			gmac_rgmii_pins: gmac-rgmii-pins {
 				pins = "PA0", "PA1", "PA2", "PA3",
 				       "PA4", "PA5", "PA6", "PA7",
@@ -625,6 +653,14 @@ gmac_mdio: mdio {
 			};
 		};
 
+		mbus: dram-controller@1c62000 {
+			compatible = "allwinner,sun8i-r40-mbus";
+			reg = <0x01c62000 0x1000>;
+			clocks = <&ccu 155>;
+			dma-ranges = <0x00000000 0x40000000 0x80000000>;
+			#interconnect-cells = <1>;
+		};
+
 		tcon_top: tcon-top@1c70000 {
 			compatible = "allwinner,sun8i-r40-tcon-top";
 			reg = <0x01c70000 0x1000>;
-- 
2.24.1

