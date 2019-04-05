Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE76C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E975421855
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfDEU6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 16:58:10 -0400
Received: from hermes.aosc.io ([199.195.250.187]:37008 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726547AbfDEU6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 16:58:08 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id AE9FC6CDF8;
        Fri,  5 Apr 2019 20:58:04 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v5 4/5] arm64: allwinner: dts: h6: add USB3 device nodes
Date:   Sat,  6 Apr 2019 04:57:35 +0800
Message-Id: <20190405205736.55177-5-icenowy@aosc.io>
In-Reply-To: <20190405205736.55177-1-icenowy@aosc.io>
References: <20190405205736.55177-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner H6 SoC features USB3 functionality, with a DWC3 controller and
a custom PHY.

Add device tree nodes for them.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
No changes in v4, v5.

Changes in v3:
- Changed the dwc3 clock according to the user manual.
- Added Chen-Yu's Review tag. arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 32 ++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 91fecab58836..4fcd4c0f470d 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -426,6 +426,38 @@
 			status = "disabled";
 		};
 
+		dwc3: dwc3@5200000 {
+			compatible = "snps,dwc3";
+			reg = <0x05200000 0x10000>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_XHCI>,
+				 <&ccu CLK_BUS_XHCI>,
+				 <&osc32k>;
+			clock-names = "ref", "bus_early", "suspend";
+			resets = <&ccu RST_BUS_XHCI>;
+			/*
+			 * The datasheet of the chip doesn't declare the
+			 * peripheral function, and there's no boards known
+			 * to have a USB Type-B port routed to the port.
+			 * In addition, no one has tested the peripheral
+			 * function yet.
+			 * So set the dr_mode to "host" in the DTSI file.
+			 */
+			dr_mode = "host";
+			phys = <&usb3phy>;
+			phy-names = "usb3-phy";
+			status = "disabled";
+		};
+
+		usb3phy: phy@5210000 {
+			compatible = "allwinner,sun50i-h6-usb3-phy";
+			reg = <0x5210000 0x10000>;
+			clocks = <&ccu CLK_USB_PHY1>;
+			resets = <&ccu RST_USB_PHY1>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
 		ehci3: usb@5311000 {
 			compatible = "allwinner,sun50i-h6-ehci", "generic-ehci";
 			reg = <0x05311000 0x100>;
-- 
2.18.1

