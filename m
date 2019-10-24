Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AA9CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D68621872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="oq65D8PR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436949AbfJXKzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 06:55:19 -0400
Received: from vps.xff.cz ([195.181.215.36]:33888 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393302AbfJXKzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 06:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1571914508; bh=HFSrXSPJyZ/r/g3KvWIYj4ef7s1MoOfxTtkAX4wXq50=;
        h=From:To:Cc:Subject:Date:References:From;
        b=oq65D8PRWktFv0x9bU7Jk6SEk/wEqhbyf0qhYKLyGZ3fN8tymjHYEswyGtFyeicY0
         GBVembdw4qlbzN6MTq7X9UFylMmHcO3RE0t7aOSZ1iaw4pvjJ7gpBDAjBZJgksLdet
         3XrR2P/fL7oiH59N/e6zC5+JbjN9eo2ZJHzox0i0=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ondrej Jirman <megous@megous.com>
Subject: [PATCH v2 3/4] arm64: dts: allwinner: h6: add USB3 device nodes
Date:   Thu, 24 Oct 2019 12:54:59 +0200
Message-Id: <20191024105500.2252707-4-megous@megous.com>
In-Reply-To: <20191024105500.2252707-1-megous@megous.com>
References: <20191024105500.2252707-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

Allwinner H6 SoC features USB3 functionality, with a DWC3 controller and
a custom PHY.

Add device tree nodes for them.

Signed-off-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 32 ++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 0d5ea19336a1..80233db478e6 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -537,6 +537,38 @@
 			status = "disabled";
 		};
 
+		dwc3: dwc3@5200000 {
+			compatible = "snps,dwc3";
+			reg = <0x05200000 0x10000>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_XHCI>,
+				 <&ccu CLK_BUS_XHCI>,
+				 <&rtc 0>;
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
2.23.0

