Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CF5C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06BCE206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731800AbfG3O55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 10:57:57 -0400
Received: from mxout017.mail.hostpoint.ch ([217.26.49.177]:30486 "EHLO
        mxout017.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731739AbfG3O5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:57:52 -0400
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
        by mxout017.mail.hostpoint.ch with esmtp (Exim 4.92 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1hsTZV-000Exc-TP; Tue, 30 Jul 2019 16:57:49 +0200
Received: from [46.140.72.82] (helo=philippe-pc.toradex.int)
        by asmtp013.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1hsTP6-000Mva-0X; Tue, 30 Jul 2019 16:47:04 +0200
X-Authenticated-Sender-Id: dev@pschenker.ch
From:   Philippe Schenker <dev@pschenker.ch>
To:     marcel.ziswiler@toradex.com, max.krummenacher@toradex.com,
        stefan@agner.ch, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 14/22] ARM: dts: apalis-imx6: Add some example I2C devices
Date:   Tue, 30 Jul 2019 16:46:41 +0200
Message-Id: <20190730144649.19022-15-dev@pschenker.ch>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730144649.19022-1-dev@pschenker.ch>
References: <20190730144649.19022-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

Those devices are used in conjunction with Toradex's evalboard.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

 arch/arm/boot/dts/imx6q-apalis-eval.dts | 95 +++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-apalis-eval.dts b/arch/arm/boot/dts/imx6q-apalis-eval.dts
index 60ec5e89d215..33193d6137c0 100644
--- a/arch/arm/boot/dts/imx6q-apalis-eval.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-eval.dts
@@ -140,6 +140,30 @@
 		regulator-max-microvolt = <3300000>;
 		regulator-always-on;
 	};
+
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "1P8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+
+	reg_2p5v: regulator-2p5v {
+		compatible = "regulator-fixed";
+		regulator-name = "2P5V";
+		regulator-min-microvolt = <2500000>;
+		regulator-max-microvolt = <2500000>;
+		regulator-always-on;
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
 };
 
 &backlight {
@@ -204,6 +228,77 @@
  */
 &i2c3 {
 	status = "okay";
+
+	adv7280: adv7280@21 {
+		compatible = "adv7280";
+		reg = <0x21>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ipu1_csi0 &pinctrl_cam_mclk>;
+		clocks = <&clks 200>;
+		clock-names = "csi_mclk";
+		DOVDD-supply = <&reg_3p3v>;
+		AVDD-supply = <&reg_3p3v>;
+		DVDD-supply = <&reg_3p3v>;
+		PVDD-supply = <&reg_3p3v>;
+		csi_id = <0>;
+		mclk = <24000000>;
+		mclk_source = <1>;
+		status = "okay";
+	};
+
+	/* Video ADC on Analog Camera Module */
+	adv7180: adv7180@21 {
+		compatible = "adv,adv7180";
+		reg = <0x21>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ipu1_csi0 &pinctrl_cam_mclk>;
+		clocks = <&clks 200>;
+		clock-names = "csi_mclk";
+		DOVDD-supply = <&reg_3p3v>; /* 3.3v */
+		AVDD-supply = <&reg_3p3v>;  /* 1.8v */
+		DVDD-supply = <&reg_3p3v>;  /* 1.8v */
+		PVDD-supply = <&reg_3p3v>;  /* 1.8v */
+		csi_id = <0>;
+		mclk = <24000000>;
+		mclk_source = <1>;
+		cvbs = <1>;
+		status = "disabled";
+	};
+
+	max9526: max9526@20 {
+		compatible = "maxim,max9526";
+		reg = <0x20>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ipu1_csi0 &pinctrl_cam_mclk>;
+		clocks = <&clks 200>;
+		clock-names = "csi_mclk";
+		DVDDIO-supply = <&reg_3p3v>; /* 3.3v */
+		AVDD-supply = <&reg_3p3v>;  /* 1.8v */
+		DVDD-supply = <&reg_3p3v>;  /* 1.8v */
+		csi_id = <0>;
+		mclk = <24000000>;
+		mclk_source = <1>;
+		cvbs = <1>;
+		status = "okay";
+	};
+
+	ov5640_mipi@3c {
+		compatible = "ovti,ov564x_mipi";
+		reg = <0x3c>;
+		clocks = <&clks 147>;
+		clock-names = "csi_mclk";
+		DOVDD-supply = <&reg_1p8v>;
+		AVDD-supply = <&reg_2p5v>;
+		DVDD-supply = <&reg_1p8v>;
+		pwn-gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>;
+		rst-gpios = <&gpio2 4 GPIO_ACTIVE_LOW>;
+		ipu_id = <0>;
+		csi_id = <1>;
+		mclk = <22000000>;
+		mclk_source = <0>;
+		pwms = <&pwm3 0 45 0>;
+		status = "okay";
+	};
 };
 
 &ipu1_di1_disp1 {
-- 
2.22.0

