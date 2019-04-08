Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9ADBC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B182214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554742690;
	bh=TwN7Oy5iVlWfQyWMfX4zx8Ea6uKwPpmBH/7ucAWtBnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fYkXGtwCwSwytzMym/W+YJy1/oVMsvYFVPY8o+12th/oQIM+OWOOncJ9/LVaT5a84
	 UQqgKrpCF/paQvPLqq99V+BWgr1/AT/tlFqb1Y2IUxuN14k1ywFW2QLk11WWccxhDQ
	 7QbuqWiDU9dbxOazpeTQVqZzEhbyzKp8czWRtRIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbfDHQ6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:58:09 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:43738 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728523AbfDHQ5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:57:49 -0400
Received: by wens.csie.org (Postfix, from userid 1000)
        id B46EA5FC63; Tue,  9 Apr 2019 00:57:46 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH 4/6] ARM: dts: sun8i: a83t: Add device node for CSI (Camera Sensor Interface)
Date:   Tue,  9 Apr 2019 00:57:42 +0800
Message-Id: <20190408165744.11672-5-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190408165744.11672-1-wens@kernel.org>
References: <20190408165744.11672-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The A83T SoC has a camera sensor interface (known as CSI in Allwinner
lingo), which is similar to the one found on the A64 and H3. The only
difference seems to be that support of MIPI CSI through a connected
MIPI CSI-2 bridge.

Add a device node for it, and pinctrl nodes for the commonly used MCLK
and 8-bit parallel interface. The property /omit-if-no-ref/ is added to
the pinctrl nodes to keep the device tree blob size down if they are
unused.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index f739b88efb53..0c52f945fd5f 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -682,6 +682,20 @@
 			#interrupt-cells = <3>;
 			#gpio-cells = <3>;
 
+			/omit-if-no-ref/
+			csi_8bit_parallel_pins: csi-8bit-parallel-pins {
+				pins = "PE0", "PE2", "PE3", "PE6", "PE7",
+				       "PE8", "PE9", "PE10", "PE11",
+				       "PE12", "PE13";
+				function = "csi";
+			};
+
+			/omit-if-no-ref/
+			csi_mclk_pin: csi-mclk-pin {
+				pins = "PE1";
+				function = "csi";
+			};
+
 			emac_rgmii_pins: emac-rgmii-pins {
 				pins = "PD2", "PD3", "PD4", "PD5", "PD6", "PD7",
 				       "PD11", "PD12", "PD13", "PD14", "PD18",
@@ -994,6 +1008,23 @@
 			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
+		csi: camera@1cb0000 {
+			compatible = "allwinner,sun8i-a83t-csi";
+			reg = <0x01cb0000 0x1000>;
+			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_CSI>,
+				 <&ccu CLK_CSI_SCLK>,
+				 <&ccu CLK_DRAM_CSI>;
+			clock-names = "bus", "mod", "ram";
+			resets = <&ccu RST_BUS_CSI>;
+			status = "disabled";
+
+			csi_in: port {
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
 		hdmi: hdmi@1ee0000 {
 			compatible = "allwinner,sun8i-a83t-dw-hdmi";
 			reg = <0x01ee0000 0x10000>;
-- 
2.20.1

