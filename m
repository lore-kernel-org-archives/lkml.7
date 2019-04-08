Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7C6C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABFC620880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554742675;
	bh=rfvRyVyri48G4FeUsk3ZLtY6StjikZI04lbV+rRWFoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fUWhUCEocgH2TYh/EaIU+oKzZtZEb8f/8B3LXGfv0/PmYpu8i90JHLu9Q3rK3EUxW
	 gLWQiPCW3kD2CVFCxpZ+j8gubd/qYWAMcwMNhAh8kER21SDgpOb9PCq/HP55EfqaAX
	 k/OieqP5ipsAkLf9GCYOHYWiWegQ4HfdWX3lwukA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbfDHQ5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:57:54 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:43770 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729030AbfDHQ5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:57:51 -0400
Received: by wens.csie.org (Postfix, from userid 1000)
        id D8C1E5FD85; Tue,  9 Apr 2019 00:57:46 +0800 (CST)
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
Subject: [PATCH 6/6] [DO NOT MERGE] ARM: dts: sun8i: a83t: bananapi-m3: Enable BPI OV5640 camera
Date:   Tue,  9 Apr 2019 00:57:44 +0800
Message-Id: <20190408165744.11672-7-wens@kernel.org>
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

Bananapi produces a camera module specifically for the Bananapi M3. This
module has an OV5640 sensor connected via the parallel CSI interface,
and an OV8865 sensor connected via MIPI CSI. I2C2 is the shared control
interface for them. The active-low reset signal is shared by the two
sensors, while each sensor has a dedicated shutdown line. The module's
onboard regulator provide power for the OV5640, while the Bananapi M3
provides power from the PMIC for the OV8865.

There's also a VM149C voice coil motor driver at I2C address 0x0c, and
an unknown device responding on I2C address 0x20. Both are related to
the OV8655 at address 0x36.

Since there is no support for the OV8865, this patch only enables the
OV5640.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts | 101 +++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
index 838be7b3715f..11b27755207a 100644
--- a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
@@ -85,6 +85,33 @@
 		};
 	};
 
+	reg_ov5640_avdd: ov5640-avdd {
+		compatible = "regulator-fixed";
+		regulator-name = "ov5640-avdd";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		/* dldo4 enables this regulator; real supply is PS */
+		vin-supply = <&reg_dldo4>;
+	};
+
+	reg_ov5640_dovdd: ov5640-iovdd {
+		compatible = "regulator-fixed";
+		regulator-name = "ov5640-dovdd";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		/* dldo4 enables this regulator; real supply is PS */
+		vin-supply = <&reg_dldo4>;
+	};
+
+	reg_ov5640_dvdd: ov5640-dvdd {
+		compatible = "regulator-fixed";
+		regulator-name = "ov5640-dvdd";
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <1500000>;
+		/* dldo4 enables this regulator; real supply is PS */
+		vin-supply = <&reg_dldo4>;
+	};
+
 	reg_usb1_vbus: reg-usb1-vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "usb1-vbus";
@@ -115,6 +142,30 @@
 	cpu-supply = <&reg_dcdc3>;
 };
 
+&ccu {
+	/* Use a stable clock source with known fixed rate for MCLK */
+	assigned-clocks = <&ccu CLK_CSI_MCLK>;
+	assigned-clock-parents = <&osc24M>;
+	assigned-clock-rates = <24000000>;
+};
+
+&csi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&csi_8bit_parallel_pins>;
+	status = "okay";
+};
+
+&csi_in {
+	csi_from_ov5640: endpoint {
+		remote-endpoint = <&ov5640_to_csi>;
+		bus-width = <8>;
+		data-shift = <2>;
+		hsync-active = <1>;     /* Active high */
+		vsync-active = <1>;     /* Active high */
+		pclk-sample = <1>;      /* Rising */
+	};
+};
+
 &de {
 	status = "okay";
 };
@@ -147,6 +198,36 @@
 	};
 };
 
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pe_pins>;
+	status = "okay";
+
+	ov5640: camera@3c {
+		compatible = "ovti,ov5640";
+		reg = <0x3c>;
+		clocks = <&ccu CLK_CSI_MCLK>;
+		clock-names = "xclk";
+		AVDD-supply = <&reg_ov5640_avdd>;
+		DOVDD-supply = <&reg_ov5640_dovdd>;
+		DVDD-supply = <&reg_ov5640_dvdd>;
+		powerdown-gpios = <&pio 3 15 GPIO_ACTIVE_HIGH>; /* PD15 */
+		reset-gpios = <&pio 4 16 GPIO_ACTIVE_LOW>; /* PE16 */
+		rotation = <180>;
+
+		port {
+			ov5640_to_csi: endpoint {
+				remote-endpoint = <&csi_from_ov5640>;
+				bus-width = <8>;
+				data-shift = <2>;
+				hsync-active = <1>;     /* Active high */
+				vsync-active = <1>;     /* Active high */
+				pclk-sample = <1>;      /* Rising */
+			};
+		};
+	};
+};
+
 &mdio {
 	rgmii_phy: ethernet-phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
@@ -191,6 +272,12 @@
 	status = "okay";
 };
 
+&pio {
+	/* pinctrl hog: MCLK is shared by both camera sensors */
+	pinctrl-names = "default";
+	pinctrl-0 = <&csi_mclk_pin>;
+};
+
 &r_cir {
 	clock-frequency = <3000000>;
 	status = "okay";
@@ -327,11 +414,25 @@
 	regulator-name = "vcc-pd";
 };
 
+&reg_dldo4 {
+	/* This also powers the pull-ups on the CSI connector */
+	regulator-always-on;
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <2800000>;
+	regulator-name = "avdd-csi";
+};
+
 &reg_drivevbus {
 	regulator-name = "usb0-vbus";
 	status = "okay";
 };
 
+&reg_eldo1 {
+	regulator-min-microvolt = <1200000>;
+	regulator-max-microvolt = <1200000>;
+	regulator-name = "dvdd-csi-r";
+};
+
 &reg_fldo1 {
 	regulator-min-microvolt = <1080000>;
 	regulator-max-microvolt = <1320000>;
-- 
2.20.1

