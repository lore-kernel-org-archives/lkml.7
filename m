Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA57C2D0D1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5622468A
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="LbkackB7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfLSUVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 15:21:50 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:12573 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbfLSUVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 15:21:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1576786904;
        s=strato-dkim-0002; d=gerhold.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=rEINu6VIPz1umRHUtN27XG8o9rq4b1mNQMa+TYAiVMU=;
        b=LbkackB7D8pcXF6qYqrHX4YWmOoZbSKDaHB4GME+7n9/q42nKDA++8zxAUHZRcomFS
        CgX3rYARb0KpifmbmsOC26B2QXXUrtetLhv5OHX+P7SUViW8DQxhMF/oxzxewYDa3+9k
        FotsDWQlEJsan6PbEDJ9dXmzP+PG/5bOT+rpgmoXeHFVAPSuxU5Az7QByySn9SsaEdGf
        zHcAO3Cu5DRtE1AT+lNOzBQk2UphmYkwZiz9OD3o0XDpTsKahnspeRq4Vf+PFYr2HPR8
        lzr6AosGIjHo5Nj4Nmi34zqnQRYmA/aIbbA2VNgH6DfVKDgAZHQqKMp4ZFrZiM6VxmTo
        AEBg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQrEOHTIXtszvsxM1"
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 46.1.1 AUTH)
        with ESMTPSA id f021e2vBJKLh3ZC
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 19 Dec 2019 21:21:43 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 5/9] ARM: dts: ux500: samsung-golden: Add IMU (accelerometer + gyroscope)
Date:   Thu, 19 Dec 2019 21:20:48 +0100
Message-Id: <20191219202052.19039-6-stephan@gerhold.net>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219202052.19039-1-stephan@gerhold.net>
References: <20191219202052.19039-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

samsung-golden has a InvenSense MPU-6051M IMU that provides an
accelerometer and gyroscope. It seems to be functionally compatible
with MPU-6050 so we can easily enable it by adding the necessary
device tree nodes.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 .../arm/boot/dts/ste-ux500-samsung-golden.dts | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/ste-ux500-samsung-golden.dts b/arch/arm/boot/dts/ste-ux500-samsung-golden.dts
index 51f2afe42c1c..14a084e1846b 100644
--- a/arch/arm/boot/dts/ste-ux500-samsung-golden.dts
+++ b/arch/arm/boot/dts/ste-ux500-samsung-golden.dts
@@ -6,6 +6,7 @@
 #include "ste-dbx5x0-pinctrl.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 /*
  * Note: This device tree cannot be booted directly with the Samsung bootloader.
@@ -114,6 +115,33 @@ uart@80007000 {
 			pinctrl-1 = <&u2rxtx_c_1_sleep>;
 		};
 
+		i2c@80128000 {
+			status = "okay";
+
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&i2c2_b_2_default>;
+			pinctrl-1 = <&i2c2_b_2_sleep>;
+
+			imu@68 {
+				compatible = "invensense,mpu6050";
+				reg = <0x68>;
+
+				/* GPIO206 (ACC_INT) */
+				interrupt-parent = <&gpio6>;
+				interrupts = <14 IRQ_TYPE_EDGE_RISING>;
+
+				mount-matrix = "0", "1", "0",
+					      "-1", "0", "0",
+					       "0", "0", "1";
+
+				vdd-supply = <&ab8500_ldo_aux1_reg>;
+				vddio-supply = <&ab8500_ldo_aux8_reg>;
+
+				pinctrl-names = "default";
+				pinctrl-0 = <&imu_default>;
+			};
+		};
+
 		prcmu@80157000 {
 			ab8505 {
 				ab8500_usb {
@@ -272,6 +300,15 @@ golden_cfg1 {
 		};
 	};
 
+	imu {
+		imu_default: imu_default {
+			golden_cfg1 {
+				pins = "GPIO206_AG24";	/* ACC_INT */
+				ste,config = <&gpio_in_pd>;
+			};
+		};
+	};
+
 	vibrator {
 		vibrator_default: vibrator_default {
 			golden_cfg1 {
-- 
2.24.1

