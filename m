Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1184AC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5820206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731763AbfG3O5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 10:57:53 -0400
Received: from mxout013.mail.hostpoint.ch ([217.26.49.173]:35536 "EHLO
        mxout013.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731710AbfG3O5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:57:48 -0400
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
        by mxout013.mail.hostpoint.ch with esmtp (Exim 4.92 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1hsTZR-000FlJ-G7; Tue, 30 Jul 2019 16:57:45 +0200
Received: from [46.140.72.82] (helo=philippe-pc.toradex.int)
        by asmtp013.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1hsTP4-000Mva-Od; Tue, 30 Jul 2019 16:47:02 +0200
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
Subject: [PATCH 12/22] ARM: dts: imx6: Add touchscreens used on Toradex eval boards
Date:   Tue, 30 Jul 2019 16:46:39 +0200
Message-Id: <20190730144649.19022-13-dev@pschenker.ch>
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

This commit adds the touchscreens from Toradex so one can enable it.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts  | 44 +++++++++++++++++++
 arch/arm/boot/dts/imx6q-apalis-eval.dts       | 19 ++++++++
 arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts | 19 ++++++++
 arch/arm/boot/dts/imx6q-apalis-ixora.dts      | 19 ++++++++
 4 files changed, 101 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
index 9a5d6c94cca4..63d4f9ca9ad8 100644
--- a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
@@ -168,6 +168,34 @@
 &i2c3 {
 	status = "okay";
 
+	/* Atmel maxtouch controller */
+	atmel_mxt_ts: atmel_mxt_ts@4a {
+		compatible = "atmel,maxtouch";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pcap_1>;
+		reg = <0x4a>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <9 IRQ_TYPE_EDGE_FALLING>; /* SODIMM 28 */
+		reset-gpios = <&gpio2 10 GPIO_ACTIVE_HIGH>; /* SODIMM 30 */
+		status = "disabled";
+	};
+
+	/*
+	 * the PCAPs use SODIMM 28/30, also used for PWM<B>, PWM<C>, aka pwm1,
+	 * pwm4. So if you enable one of the PCAP controllers disable the pwms.
+	 */
+	pcap: pcap@10 {
+		/* TouchRevolution Fusion 7 and 10 multi-touch controller */
+		compatible = "touchrevolution,fusion-f0710a";
+		reg = <0x10>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pcap_1>;
+		gpios = <&gpio1  9 0 /* SODIMM 28, Pen down interrupt */
+			 &gpio2 10 0 /* SODIMM 30, Reset */
+			>;
+		status = "disabled";
+	};
+
 	/* M41T0M6 real time clock on carrier board */
 	rtc_i2c: rtc@68 {
 		compatible = "st,m41t0";
@@ -175,6 +203,22 @@
 	};
 };
 
+&iomuxc {
+	pinctrl_pcap_1: pcap-1 {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_9__GPIO1_IO09	0x1b0b0 /* SODIMM 28 */
+			MX6QDL_PAD_SD4_DAT2__GPIO2_IO10	0x1b0b0 /* SODIMM 30 */
+		>;
+	};
+
+	pinctrl_mxt_ts: mxt-ts {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_CS1__GPIO2_IO24	0x130b0 /* SODIMM 107 */
+			MX6QDL_PAD_SD2_DAT1__GPIO1_IO14	0x130b0 /* SODIMM 106 */
+		>;
+	};
+};
+
 &ipu1_di0_disp0 {
 	remote-endpoint = <&lcd_display_in>;
 };
diff --git a/arch/arm/boot/dts/imx6q-apalis-eval.dts b/arch/arm/boot/dts/imx6q-apalis-eval.dts
index 0edd3043d9c1..60ec5e89d215 100644
--- a/arch/arm/boot/dts/imx6q-apalis-eval.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-eval.dts
@@ -167,6 +167,25 @@
 &i2c1 {
 	status = "okay";
 
+	/* Atmel maxtouch controller */
+	atmel_mxt_ts: atmel_mxt_ts@4a {
+		compatible = "atmel,maxtouch";
+		reg = <0x4a>;
+		interrupt-parent = <&gpio6>;
+		interrupts = <10 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&gpio6 9 GPIO_ACTIVE_HIGH>; /* SODIMM 13 */
+		status = "disabled";
+	};
+
+	pcap@10 {
+		/* TouchRevolution Fusion 7 and 10 multi-touch controller */
+		compatible = "touchrevolution,fusion-f0710a";
+		reg = <0x10>;
+		gpios = <&gpio6 10 0 /* MXM3 11, Pen down interrupt */
+			 &gpio6  9 0 /* MXM3 13, Reset */
+			>;
+	};
+
 	pcie-switch@58 {
 		compatible = "plx,pex8605";
 		reg = <0x58>;
diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts b/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
index b94bb687be6b..98a8ae20b1f2 100644
--- a/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
@@ -172,6 +172,25 @@
 &i2c1 {
 	status = "okay";
 
+	/* Atmel maxtouch controller */
+	atmel_mxt_ts: atmel_mxt_ts@4a {
+		compatible = "atmel,maxtouch";
+		reg = <0x4a>;
+		interrupt-parent = <&gpio6>;
+		interrupts = <10 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&gpio6 9 GPIO_ACTIVE_HIGH>; /* SODIMM 13 */
+		status = "disabled";
+	};
+
+	pcap@10 {
+		/* TouchRevolution Fusion 7 and 10 multi-touch controller */
+		compatible = "touchrevolution,fusion-f0710a";
+		reg = <0x10>;
+		gpios = <&gpio6 10 GPIO_ACTIVE_HIGH /* MXM3 11, Pen down interrupt */
+			 &gpio6  9 GPIO_ACTIVE_HIGH /* MXM3 13, Reset */
+			>;
+	};
+
 	/* M41T0M6 real time clock on carrier board */
 	rtc_i2c: rtc@68 {
 		compatible = "st,m41t0";
diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora.dts b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
index 302fd6adc8a7..67f6b36e6f94 100644
--- a/arch/arm/boot/dts/imx6q-apalis-ixora.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
@@ -171,6 +171,25 @@
 &i2c1 {
 	status = "okay";
 
+	/* Atmel maxtouch controller */
+	atmel_mxt_ts: atmel_mxt_ts@4a {
+		compatible = "atmel,maxtouch";
+		reg = <0x4a>;
+		interrupt-parent = <&gpio6>;
+		interrupts = <10 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&gpio6 9 GPIO_ACTIVE_HIGH>; /* SODIMM 13 */
+		status = "disabled";
+	};
+
+	pcap@10 {
+		/* TouchRevolution Fusion 7 and 10 multi-touch controller */
+		compatible = "touchrevolution,fusion-f0710a";
+		reg = <0x10>;
+		gpios = <&gpio6 10 GPIO_ACTIVE_HIGH /* MXM3 11, Pen down interrupt */
+			 &gpio6  9 GPIO_ACTIVE_HIGH /* MXM3 13, Reset */
+			>;
+	};
+
 	eeprom@50 {
 		compatible = "atmel,24c02";
 		reg = <0x50>;
-- 
2.22.0

