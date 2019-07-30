Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFA9C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA8892089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731961AbfG3PBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 11:01:15 -0400
Received: from mxout014.mail.hostpoint.ch ([217.26.49.174]:38541 "EHLO
        mxout014.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731351AbfG3PBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:01:13 -0400
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
        by mxout014.mail.hostpoint.ch with esmtp (Exim 4.92 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1hsTP0-0005LY-Gc; Tue, 30 Jul 2019 16:46:58 +0200
Received: from [46.140.72.82] (helo=philippe-pc.toradex.int)
        by asmtp013.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1hsTP0-000Mva-BD; Tue, 30 Jul 2019 16:46:58 +0200
X-Authenticated-Sender-Id: dev@pschenker.ch
From:   Philippe Schenker <dev@pschenker.ch>
To:     marcel.ziswiler@toradex.com, max.krummenacher@toradex.com,
        stefan@agner.ch, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 05/22] ARM: dts: add recovery for I2C for iMX7
Date:   Tue, 30 Jul 2019 16:46:32 +0200
Message-Id: <20190730144649.19022-6-dev@pschenker.ch>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730144649.19022-1-dev@pschenker.ch>
References: <20190730144649.19022-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

- add recovery mode for applicable i2c buses for
  Colibri iMX7 module.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

 arch/arm/boot/dts/imx7-colibri.dtsi | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index a8d992f3e897..2480623c92ff 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -140,8 +140,12 @@
 
 &i2c1 {
 	clock-frequency = <100000>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c1 &pinctrl_i2c1_int>;
+	pinctrl-1 = <&pinctrl_i2c1_recovery &pinctrl_i2c1_int>;
+	scl-gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
+	sda-gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>;
+
 	status = "okay";
 
 	codec: sgtl5000@a {
@@ -242,8 +246,11 @@
 
 &i2c4 {
 	clock-frequency = <100000>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c4>;
+	pinctrl-1 = <&pinctrl_i2c4_recovery>;
+	scl-gpios = <&gpio7 8 GPIO_ACTIVE_HIGH>;
+	sda-gpios = <&gpio7 9 GPIO_ACTIVE_HIGH>;
 };
 
 &lcdif {
@@ -540,6 +547,13 @@
 		>;
 	};
 
+	pinctrl_i2c4_recovery: i2c4-recoverygrp {
+		fsl,pins = <
+			MX7D_PAD_ENET1_RGMII_TD2__GPIO7_IO8	0x4000007f
+			MX7D_PAD_ENET1_RGMII_TD3__GPIO7_IO9	0x4000007f
+		>;
+	};
+
 	pinctrl_lcdif_dat: lcdif-dat-grp {
 		fsl,pins = <
 			MX7D_PAD_LCD_DATA00__LCD_DATA0		0x79
@@ -740,6 +754,13 @@
 		>;
 	};
 
+	pinctrl_i2c1_recovery: i2c1-recoverygrp {
+		fsl,pins = <
+			MX7D_PAD_LPSR_GPIO1_IO04__GPIO1_IO4	0x4000007f
+			MX7D_PAD_LPSR_GPIO1_IO05__GPIO1_IO5	0x4000007f
+		>;
+	};
+
 	pinctrl_cd_usdhc1: usdhc1-cd-grp {
 		fsl,pins = <
 			MX7D_PAD_LPSR_GPIO1_IO00__GPIO1_IO0	0x59 /* CD */
-- 
2.22.0

