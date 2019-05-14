Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED71AC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 16:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB7420863
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 16:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfENQDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 12:03:03 -0400
Received: from verein.lst.de ([213.95.11.211]:46661 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbfENQDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 12:03:02 -0400
Received: by newverein.lst.de (Postfix, from userid 2005)
        id 9EAC768C7B; Tue, 14 May 2019 18:02:41 +0200 (CEST)
From:   Torsten Duwe <duwe@lst.de>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Harald Geyer <harald@ccbib.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm64: DTS: allwinner: a64: enable ANX6345 bridge on Teres-I
References: <20190514155911.6C0AC68B05@newverein.lst.de>
Message-Id: <20190514160241.9EAC768C7B@newverein.lst.de>
Date:   Tue, 14 May 2019 18:02:41 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

TERES-I has an ANX6345 bridge connected to the RGB666 LCD output, and
the I2C controlling signals are connected to I2C0 bus.

Enable it in the device tree.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Torsten Duwe <duwe@suse.de>
---

originally: patchwork.kernel.org/patch/10646867

Changed the reset polarity, which is active low,
according to the (terse) datasheet, Teres-I and pinebook schematics,
and the confusing parts of the linux driver code (not yet included here).
Active low -> no more confusion.

---
 .../boot/dts/allwinner/sun50i-a64-teres-i.dts | 40 +++++++++++++++++--
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
index c455b24dd079..bc1d0d6c0672 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
@@ -72,20 +72,38 @@
 	};
 };
 
+&de {
+	status = "okay";
+};
+
 &ehci1 {
 	status = "okay";
 };
 
 
-/* The ANX6345 eDP-bridge is on i2c0. There is no linux (mainline)
- * driver for this chip at the moment, the bootloader initializes it.
- * However it can be accessed with the i2c-dev driver from user space.
- */
 &i2c0 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
+
+	anx6345: anx6345@38 {
+		compatible = "analogix,anx6345";
+		reg = <0x38>;
+		reset-gpios = <&pio 3 24 GPIO_ACTIVE_LOW>; /* PD24 */
+		dvdd25-supply = <&reg_dldo2>;
+		dvdd12-supply = <&reg_dldo3>;
+
+		port {
+			anx6345_in: endpoint {
+				remote-endpoint = <&tcon0_out_anx6345>;
+			};
+		};
+	};
+};
+
+&mixer0 {
+	status = "okay";
 };
 
 &mmc0 {
@@ -258,6 +276,20 @@
 	vcc-hdmi-supply = <&reg_dldo1>;
 };
 
+&tcon0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&lcd_rgb666_pins>;
+
+	status = "okay";
+};
+
+&tcon0_out {
+	tcon0_out_anx6345: endpoint@0 {
+		reg = <0>;
+		remote-endpoint = <&anx6345_in>;
+	};
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pb_pins>;
