Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2649CC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D4C24679
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="cB0VKW/3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfLSUWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 15:22:17 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.84]:16079 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbfLSUVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 15:21:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1576786905;
        s=strato-dkim-0002; d=gerhold.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=TdmaWHXYZcW1R+/Rup5KpwyfgOBgzcXrSUBNzmQYpiw=;
        b=cB0VKW/3YlaGJcw5TFpwBq5vbSQ++veq6MdY53dSvjY510MkGzpvXElPhWE1V1iuTq
        NNnkkQYxriDvZ6FlCBvrnfR6s4PHJ4heq5ppg1QzsRnL1UIr4yVW3fTpl4SLCQfRGrN+
        K1Y0Bhg1aNlNP3yvXyDjlKfTs3v3CXltlX4f2b1OZ88Q06YF1dh1RvuZc0RVnWKGc4yt
        oILZt00GG2JLAxaFj5fsaeV7/HUoiH517sivRcicO+9/wC1z6bWxXYd+Yfw2Pj3ErXcD
        iArLlxde2NoG+4qvo9whX/PKhcXZfHvlZXm5owQ1A5HxvnwsLJFtKbjcxxiPfyPVElD/
        MAeA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQrEOHTIXtszvsxM1"
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 46.1.1 AUTH)
        with ESMTPSA id f021e2vBJKLi3ZD
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 19 Dec 2019 21:21:44 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 6/9] ARM: dts: ux500: samsung-golden: Add touch screen
Date:   Thu, 19 Dec 2019 21:20:49 +0100
Message-Id: <20191219202052.19039-7-stephan@gerhold.net>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219202052.19039-1-stephan@gerhold.net>
References: <20191219202052.19039-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

samsung-golden has an Atmel mXT224S touch controller connected to I2C.
It is supported by the existing driver for atmel,maxtouch, so all we
need to do to make it work is to define the necessary device tree nodes.

The atmel_mxt_ts driver does not support controlling regulators yet,
so add regulator-always-on for now to turn on the necessary regulators.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 .../arm/boot/dts/ste-ux500-samsung-golden.dts | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/ste-ux500-samsung-golden.dts b/arch/arm/boot/dts/ste-ux500-samsung-golden.dts
index 14a084e1846b..e75a425d177e 100644
--- a/arch/arm/boot/dts/ste-ux500-samsung-golden.dts
+++ b/arch/arm/boot/dts/ste-ux500-samsung-golden.dts
@@ -142,6 +142,26 @@ imu@68 {
 			};
 		};
 
+		i2c@80110000 {
+			status = "okay";
+
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&i2c3_c_2_default>;
+			pinctrl-1 = <&i2c3_c_2_sleep>;
+
+			touchscreen@4a {
+				compatible = "atmel,maxtouch";
+				reg = <0x4a>;
+
+				/* GPIO218 (TSP_INT_1V8) */
+				interrupt-parent = <&gpio6>;
+				interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
+
+				pinctrl-names = "default";
+				pinctrl-0 = <&tsp_default>;
+			};
+		};
+
 		prcmu@80157000 {
 			ab8505 {
 				ab8500_usb {
@@ -161,6 +181,7 @@ ab8500_ldo_aux2 {
 						regulator-name = "vreg_tsp_a3v3";
 						regulator-min-microvolt = <3300000>;
 						regulator-max-microvolt = <3300000>;
+						regulator-always-on; /* FIXME */
 					};
 
 					ab8500_ldo_aux3 {
@@ -177,6 +198,7 @@ ab8500_ldo_aux5 {
 						regulator-name = "vreg_tsp_1v8";
 						regulator-min-microvolt = <1800000>;
 						regulator-max-microvolt = <1800000>;
+						regulator-always-on; /* FIXME */
 					};
 
 					ab8500_ldo_aux6 {
@@ -309,6 +331,15 @@ golden_cfg1 {
 		};
 	};
 
+	tsp {
+		tsp_default: tsp_default {
+			golden_cfg1 {
+				pins = "GPIO218_AH11";	/* TSP_INT_1V8 */
+				ste,config = <&gpio_in_nopull>;
+			};
+		};
+	};
+
 	vibrator {
 		vibrator_default: vibrator_default {
 			golden_cfg1 {
-- 
2.24.1

