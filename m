Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7021CC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5113920665
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730862AbfG3O4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 10:56:18 -0400
Received: from mxout012.mail.hostpoint.ch ([217.26.49.172]:64475 "EHLO
        mxout012.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727129AbfG3O4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:56:17 -0400
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
        by mxout012.mail.hostpoint.ch with esmtp (Exim 4.92 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1hsTXy-0000wf-FR; Tue, 30 Jul 2019 16:56:14 +0200
Received: from [46.140.72.82] (helo=philippe-pc.toradex.int)
        by asmtp013.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1hsTPA-000Mva-Sd; Tue, 30 Jul 2019 16:47:08 +0200
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
Subject: [PATCH 22/22] ARM: dts: imx6ull-colibri: Add touchscreens used with Eval Board
Date:   Tue, 30 Jul 2019 16:46:49 +0200
Message-Id: <20190730144649.19022-23-dev@pschenker.ch>
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

This adds the common touchscreens that are used with Toradex's
Eval Boards.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

---

 .../arm/boot/dts/imx6ull-colibri-eval-v3.dtsi | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi b/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
index d3c4809f140e..cd72d3decf6a 100644
--- a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
@@ -112,6 +112,34 @@
 &i2c1 {
 	status = "okay";
 
+	/*
+	 * the PCAPs use SODIMM 28/30, also used for PWM<B>, PWM<C>, aka pwm5,
+	 * pwm6. so if you enable one of the PCAP controllers disable the pwms
+	 */
+	atmel_mxt_ts: atmel_mxt_ts@4a {
+		compatible = "atmel,maxtouch";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpiotouch>;
+		reg = <0x4a>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <16 IRQ_TYPE_EDGE_FALLING>; /* SODIMM 28 */
+		reset-gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>; /* SODIMM 30 */
+		status = "disabled";
+	};
+
+	touch: touchrevf0710a@10 {
+		compatible = "touchrevolution,fusion-f0710a";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpiotouch>;
+		reg = <0x10>;
+			/* SODIMM 28, Pen down interrupt */
+		gpios = <&gpio4 16 GPIO_ACTIVE_HIGH
+			/* SODIMM 30, Reset interrupt */
+			 &gpio2 5 GPIO_ACTIVE_LOW
+			>;
+		status = "disabled";
+	};
+
 	/* M41T0M6 real time clock on carrier board */
 	m41t0m6: rtc@68 {
 		compatible = "st,m41t0";
@@ -188,3 +216,12 @@
 	sd-uhs-sdr104;
 	status = "okay";
 };
+
+&iomuxc {
+	pinctrl_gpiotouch: touchgpios {
+		fsl,pins = <
+			MX6UL_PAD_NAND_DQS__GPIO4_IO16		0x74
+			MX6UL_PAD_ENET1_TX_EN__GPIO2_IO05	0x14
+		>;
+	};
+};
-- 
2.22.0

