Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC08CC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B57E12467E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="jZ6Z38o2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfLSUVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 15:21:46 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:12600 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfLSUVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 15:21:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1576786900;
        s=strato-dkim-0002; d=gerhold.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Ctz9sULW//zeldx1653eIVZ0o4EECVJHJLMqzED7g8o=;
        b=jZ6Z38o2r5GhorQv3Zc9juhucbhF5PX37DJ9l9lyrhwpmU35Zu2ilTahtSO1Z8tGYl
        IBnnvQLY/rsEDm4F5WgRLAEsSlHRh/MXrwyzfh7U7nSi1eUkicbzTpSIEq8z+IyvRGot
        883ZPKMCQRDovCOd8yfgUvS7OghH9bhziRnuSwwovO63s1sqHl9HH4QCIKY3UM6CrZsk
        mnFPTG3pZdAKBV8e+WkcugGYfK4fOQKEoj4j4KqdrU7154z71kap9Y9jySxgQz/dhBLr
        REKOrZ5hoq4Bc4jqsuMO+EJLNbfJypGoTgOLVlJGYrmdZ2epHtM8NYN1mb6vHVHwy5U9
        vfZw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQrEOHTIXtszvsxM1"
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 46.1.1 AUTH)
        with ESMTPSA id f021e2vBJKLc3Z8
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 19 Dec 2019 21:21:38 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 1/9] ARM: dts: ux500: Remove unused ste-href-ab8505.dtsi
Date:   Thu, 19 Dec 2019 21:20:44 +0100
Message-Id: <20191219202052.19039-2-stephan@gerhold.net>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219202052.19039-1-stephan@gerhold.net>
References: <20191219202052.19039-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pin configuration for HREF boards with AB8505 was added in
commit 77ad9dfc2c7e ("ARM: ux500: move last AB8505 set-up to DT").
As the commit message notes, it was unused back then and it has
remained so even today, especially considering AB8505 did not have
proper device tree support until recently.

We are now preparing to add support for some Samsung smartphones
that are using AB8505. However, they use different pin configs
because using ste-href-ab8505.dtsi is known to break UART.
There were not many HREFs with AB8505, so at this point it seems
unlikely that we will ever make use of this include. Remove it.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm/boot/dts/ste-href-ab8505.dtsi | 234 -------------------------
 1 file changed, 234 deletions(-)
 delete mode 100644 arch/arm/boot/dts/ste-href-ab8505.dtsi

diff --git a/arch/arm/boot/dts/ste-href-ab8505.dtsi b/arch/arm/boot/dts/ste-href-ab8505.dtsi
deleted file mode 100644
index 95cf38a008e9..000000000000
--- a/arch/arm/boot/dts/ste-href-ab8505.dtsi
+++ /dev/null
@@ -1,234 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright 2014 Linaro Ltd.
- */
-
-/ {
-	soc {
-		prcmu@80157000 {
-			ab8505 {
-				ab8505-gpio {
-					/* Hog a few default settings */
-					pinctrl-names = "default";
-					pinctrl-0 = <&gpio2_default_mode>,
-						    <&gpio10_default_mode>,
-						    <&gpio11_default_mode>,
-						    <&gpio13_default_mode>,
-						    <&gpio34_default_mode>,
-						    <&gpio50_default_mode>,
-						    <&pwm_default_mode>,
-						    <&adi2_default_mode>,
-						    <&modsclsda_default_mode>,
-						    <&resethw_default_mode>,
-						    <&service_default_mode>;
-
-					/*
-					 * Pins 2, 10, 11, 13, 34 and 50
-					 * are muxed in as GPIO, and configured as INPUT PULL DOWN
-					 */
-					gpio2 {
-						gpio2_default_mode: gpio2_default {
-							default_mux {
-								function = "gpio";
-								groups = "gpio2_a_1";
-							};
-							default_cfg {
-								pins = "GPIO2_R5";
-								input-enable;
-								bias-pull-down;
-							};
-						};
-					};
-					gpio10 {
-						gpio10_default_mode: gpio10_default {
-							default_mux {
-								function = "gpio";
-								groups = "gpio10_d_1";
-							};
-							default_cfg {
-								pins = "GPIO10_B16";
-								input-enable;
-								bias-pull-down;
-							};
-						};
-					};
-					gpio11 {
-						gpio11_default_mode: gpio11_default {
-							default_mux {
-								function = "gpio";
-								groups = "gpio11_d_1";
-							};
-							default_cfg {
-								pins = "GPIO11_B17";
-								input-enable;
-								bias-pull-down;
-							};
-						};
-					};
-					gpio13 {
-						gpio13_default_mode: gpio13_default {
-							default_mux {
-								function = "gpio";
-								groups = "gpio13_d_1";
-							};
-							default_cfg {
-								pins = "GPIO13_D17";
-								input-enable;
-								bias-disable;
-							};
-						};
-					};
-					gpio34 {
-						gpio34_default_mode: gpio34_default {
-							default_mux {
-								function = "gpio";
-								groups = "gpio34_a_1";
-							};
-							default_cfg {
-								pins = "GPIO34_H14";
-								input-enable;
-								bias-pull-down;
-							};
-						};
-					};
-					gpio50 {
-						gpio50_default_mode: gpio50_default {
-							default_mux {
-								function = "gpio";
-								groups = "gpio50_d_1";
-							};
-							default_cfg {
-								pins = "GPIO50_L4";
-								input-enable;
-								bias-disable;
-							};
-						};
-					};
-					/* This sets up the PWM pin 14 */
-					pwm {
-						pwm_default_mode: pwm_default {
-							default_mux {
-								function = "pwmout";
-								groups = "pwmout1_d_1";
-							};
-							default_cfg {
-								pins = "GPIO14_C16";
-								input-enable;
-								bias-pull-down;
-							};
-						};
-					};
-					/* This sets up audio interface 2 */
-					adi2 {
-						adi2_default_mode: adi2_default {
-							default_mux {
-								function = "adi2";
-								groups = "adi2_d_1";
-							};
-							default_cfg {
-								pins = "GPIO17_P2",
-									 "GPIO18_N3",
-									 "GPIO19_T1",
-									 "GPIO20_P3";
-								input-enable;
-								bias-pull-down;
-							};
-						};
-					};
-					/* Modem I2C setup (SCL and SDA pins) */
-					modsclsda {
-						modsclsda_default_mode: modsclsda_default {
-							default_mux {
-								function = "modsclsda";
-								groups = "modsclsda_d_1";
-							};
-							default_cfg {
-								pins = "GPIO40_J15",
-									"GPIO41_J14";
-								input-enable;
-								bias-pull-down;
-							};
-						};
-					};
-					resethw {
-						resethw_default_mode: resethw_default {
-							default_mux {
-								function = "resethw";
-								groups = "resethw_d_1";
-							};
-							default_cfg {
-								pins = "GPIO52_D16";
-								input-enable;
-								bias-pull-down;
-							};
-						};
-					};
-					service {
-						service_default_mode: service_default {
-							default_mux {
-								function = "service";
-								groups = "service_d_1";
-							};
-							default_cfg {
-								pins = "GPIO53_D15";
-								input-enable;
-								bias-pull-down;
-							};
-						};
-					};
-					/*
-					 * Clock output pins associated with regulators.
-					 */
-					sysclkreq2 {
-						sysclkreq2_default_mode: sysclkreq2_default {
-							default_mux {
-								function = "sysclkreq";
-								groups = "sysclkreq2_d_1";
-							};
-							default_cfg {
-								pins = "GPIO1_N4";
-								input-enable;
-								bias-disable;
-							};
-						};
-						sysclkreq2_sleep_mode: sysclkreq2_sleep {
-							default_mux {
-								function = "gpio";
-								groups = "gpio1_a_1";
-							};
-							default_cfg {
-								pins = "GPIO1_N4";
-								input-enable;
-								bias-pull-down;
-							};
-						};
-					};
-					sysclkreq4 {
-						sysclkreq4_default_mode: sysclkreq4_default {
-							default_mux {
-								function = "sysclkreq";
-								groups = "sysclkreq4_d_1";
-							};
-							default_cfg {
-								pins = "GPIO3_P5";
-								input-enable;
-								bias-disable;
-							};
-						};
-						sysclkreq4_sleep_mode: sysclkreq4_sleep {
-							default_mux {
-								function = "gpio";
-								groups = "gpio3_a_1";
-							};
-							default_cfg {
-								pins = "GPIO3_P5";
-								input-enable;
-								bias-pull-down;
-							};
-						};
-					};
-				};
-			};
-		};
-	};
-};
-- 
2.24.1

