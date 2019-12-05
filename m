Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B574C2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 21:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 703AE2245C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 21:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbfLEVQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 16:16:07 -0500
Received: from 68-189-91-139.static.snlo.ca.charter.com ([68.189.91.139]:54727
        "EHLO rjones.pdc.gateworks.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729430AbfLEVQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 16:16:07 -0500
Received: by rjones.pdc.gateworks.com (Postfix, from userid 1002)
        id AF5F11A43088; Thu,  5 Dec 2019 13:08:29 -0800 (PST)
From:   Robert Jones <rjones@gateworks.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Tim Harvey <tharvey@gateworks.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Robert Jones <rjones@gateworks.com>
Subject: [PATCH] ARM: dts: imx: imx6qdl-gw553x.dtsi: add lsm9ds1 iio imu/magn support
Date:   Thu,  5 Dec 2019 13:07:52 -0800
Message-Id: <20191205210752.21146-1-rjones@gateworks.com>
X-Mailer: git-send-email 2.9.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add one node for the accel/gyro i2c device and another for the separate
magnetometer device in the lsm9ds1.

Signed-off-by: Robert Jones <rjones@gateworks.com>
---
 arch/arm/boot/dts/imx6qdl-gw553x.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-gw553x.dtsi b/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
index a106689..305b2f0 100644
--- a/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
@@ -173,6 +173,25 @@
 	pinctrl-0 = <&pinctrl_i2c2>;
 	status = "okay";
 
+	lsm9ds1_m@1c {
+		compatible = "st,lsm9ds1-magn";
+		reg = <0x1c>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_mag>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <2 IRQ_TYPE_EDGE_RISING>;
+	};
+
+	lsm9ds1_ag@6a {
+		compatible = "st,lsm9ds1-imu";
+		reg = <0x6a>;
+		st,drdy-int-pin = <1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_acc_gyro>;
+		interrupt-parent = <&gpio7>;
+		interrupts = <13 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	ltc3676: pmic@3c {
 		compatible = "lltc,ltc3676";
 		reg = <0x3c>;
@@ -462,6 +481,18 @@
 		>;
 	};
 
+	pinctrl_mag: maggrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_2__GPIO1_IO02		0x1b0b0
+		>;
+	};
+
+	pinctrl_acc_gyro: acc_gyrogrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_18__GPIO7_IO13		0x1b0b0
+		>;
+	};
+
 	pinctrl_pps: ppsgrp {
 		fsl,pins = <
 			MX6QDL_PAD_ENET_RXD1__GPIO1_IO26	0x1b0b1
-- 
2.9.2

