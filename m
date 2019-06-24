Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A547FC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 17:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E0C20665
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 17:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcATPe/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732615AbfFXRkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 13:40:52 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45243 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732515AbfFXRkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 13:40:51 -0400
Received: by mail-ed1-f68.google.com with SMTP id a14so22882356edv.12;
        Mon, 24 Jun 2019 10:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7G9hz19DpQMOp6xUIOTV29RIVUvIs4RqyPOZnJ3+kuc=;
        b=QcATPe/q75AXCQpILZkSYxvxZuX+nvVMhHyIKaH257464XhpoWfF1kA0yKxKPWGtV1
         C/xpC8cZdNkATT1TkazXzSvP5HPhbssuDiua8vWJ+Abh78C749y0G5BNu0NV8Wma1ODb
         pRroFTr0cWs1pAMNIM7wZM1FDLVcaiLEdcrkwVSo2rdDBujTz/d+7cTSz01rRA32oOXe
         3/4SO/cjKdBadss1eJEEML/PpeDIGZwkGRTt1bHRrqZVrqwLivQS5QYrUzwz9lmGdx2m
         bVGOxuvHLpCa+MzDPW5+8s1ES4u/XuKP99nj3RGDh9Kapj+BvdTz0nNeIMujPeoZoloa
         KBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7G9hz19DpQMOp6xUIOTV29RIVUvIs4RqyPOZnJ3+kuc=;
        b=TVs2VOKIiMS5lblEMpEwG43sHfYp5Iz4gysdUDdySSSMaS64xWM7qcpgdinkadp5O3
         wdqZUcUb9t2p0nTFzk6wdMBiOimoNayJvxETd26GDU1C+/jvaLedpnKMRyqGPjntclvf
         exGy9PJuOa5WQR+YqzRfZAcwVTUt23aPobPaeelJsZUGcY84On9iV9xfUj0+SA5JW8AL
         ib9fjCUeijC9mWgxTnSYiHbpmp5hzW31cs1r04yPl5JIt5QaiIFEjHASSfczB8GpCC0O
         e7qeqRxqVdvvtX9L7bHnHm6fNqsossFx7udQ6eI5f8V0d2T5ttHc3lDEABnrb6BoKeau
         QnDw==
X-Gm-Message-State: APjAAAVWkWf2EsPXsmhNwLpU3M46VQDuGD868TnsF7WL2/KL5RTWDozH
        +OwVSgEt3jaDd2brMeRfW1w=
X-Google-Smtp-Source: APXvYqx9X3oE8Zq3qnLXcp2vY0GKoHOdc0iFgpRY1QX/Odw7afke/4A7u4dYcN3iqnYOne65JA59vQ==
X-Received: by 2002:a17:906:e282:: with SMTP id gg2mr24192530ejb.38.1561398048655;
        Mon, 24 Jun 2019 10:40:48 -0700 (PDT)
Received: from localhost (ip1f10d6e1.dynamic.kabel-deutschland.de. [31.16.214.225])
        by smtp.gmail.com with ESMTPSA id b25sm4068315eda.38.2019.06.24.10.40.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 10:40:48 -0700 (PDT)
From:   Oliver Graute <oliver.graute@gmail.com>
To:     oliver.graute@gmail.com
Cc:     narmstrong@baylibre.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] ARM: dts: Add support for i.MX6 UltraLite DART Variscite Customboard
Date:   Mon, 24 Jun 2019 19:40:13 +0200
Message-Id: <1561398017-10548-3-git-send-email-oliver.graute@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561398017-10548-1-git-send-email-oliver.graute@gmail.com>
References: <1561398017-10548-1-git-send-email-oliver.graute@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds DeviceTree Source for the i.MX6 UltraLite DART NAND/WIFI

Signed-off-by: Oliver Graute <oliver.graute@gmail.com>
---
 arch/arm/boot/dts/Makefile                      |   1 +
 arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts | 203 ++++++++++++++++++++++++
 2 files changed, 204 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index c4742af..5dc3fbf 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -577,6 +577,7 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ul-tx6ul-0010.dtb \
 	imx6ul-tx6ul-0011.dtb \
 	imx6ul-tx6ul-mainboard.dtb \
+	imx6ul-var-6ulcustomboard.dtb \
 	imx6ull-14x14-evk.dtb \
 	imx6ull-colibri-eval-v3.dtb \
 	imx6ull-colibri-wifi-eval-v3.dtb \
diff --git a/arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts b/arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts
new file mode 100644
index 0000000..59354e6
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts
@@ -0,0 +1,203 @@
+// SPDX-License-Identifier: (GPL-2.0)
+/*
+ * Support for Variscite DART-6UL Module
+ *
+ * Copyright (C) 2015 Freescale Semiconductor, Inc.
+ * Copyright (C) 2015-2016 Variscite Ltd. - http://www.variscite.com
+ * Copyright (C) 2018-2019 Oliver Graute <oliver.graute@gmail.com>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include "imx6ul-imx6ull-var-dart-common.dtsi"
+
+/ {
+	model = "Variscite i.MX6 UltraLite Carrier-board";
+	compatible = "fsl,6ulcustomboard", "fsl,imx6ul";
+
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm1 0 20000>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		user {
+			gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_BACK>;
+			gpio-key,wakeup;
+		};
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+
+		d16-led {
+			gpios = <&gpio4 20 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "wm8731audio";
+		simple-audio-card,widgets =
+			"Headphone", "Headphone Jack",
+			"Line", "Line Jack",
+			"Microphone", "Mic Jack";
+		simple-audio-card,routing =
+			"Headphone Jack", "RHPOUT",
+			"Headphone Jack", "LHPOUT",
+			"LLINEIN", "Line Jack",
+			"RLINEIN", "Line Jack",
+			"MICIN", "Mic Bias",
+			"Mic Bias", "Mic Jack";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&sound_master>;
+		simple-audio-card,frame-master = <&sound_master>;
+
+		sound_master: simple-audio-card,cpu {
+				sound-dai = <&sai2>;
+		};
+	};
+};
+
+&can1 {
+	status = "okay";
+};
+
+&can2 {
+	status = "okay";
+};
+
+&gpc {
+	fsl,cpu_pupscr_sw2iso = <0x2>;
+	fsl,cpu_pupscr_sw = <0x1>;
+	fsl,cpu_pdnscr_iso2sw = <0x1>;
+	fsl,cpu_pdnscr_iso = <0x1>;
+	fsl,ldo-bypass = <0>; /* DCDC, ldo-enable */
+};
+
+&fec1 {
+	phy-mode = "rgmii";
+	phy-reset-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
+	phy-handle = <&ethphy0>;
+	status = "okay";
+};
+
+&fec2 {
+	phy-mode = "rgmii";
+	phy-reset-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
+	phy-handle = <&ethphy1>;
+	status = "okay";
+};
+
+&i2c1 {
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&i2c2 {
+	clock_frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	wm8731: audio-codec@1a {
+		#sound-dai-cells = <0>;
+		compatible = "wlf,wm8731";
+		reg = <0x1a>;
+		clocks = <&clks IMX6UL_CLK_SAI2>;
+		clock-names = "mclk";
+	};
+
+	touchscreen@38 {
+		compatible = "edt,edt-ft5x06";
+		reg = <0x38>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <4 0>;
+		touchscreen-size-x = <800>;
+		touchscreen-size-y = <480>;
+		touchscreen-inverted-x;
+		touchscreen-inverted-y;
+	};
+
+	rtc@68 {
+		compatible = "dallas,ds1337";
+		reg = <0x68>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_rtc>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+	};
+};
+
+&lcdif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lcdif_dat
+		     &pinctrl_lcdif_ctrl>;
+	display = <&display0>;
+	status = "okay";
+
+	display0: display0 {
+		bits-per-pixel = <16>;
+		bus-width = <24>;
+
+		display-timings {
+			native-mode = <&timing0>;
+			timing0: timing0 {
+				clock-frequency =<35000000>;
+				hactive = <800>;
+				vactive = <480>;
+				hfront-porch = <40>;
+				hback-porch = <40>;
+				hsync-len = <48>;
+				vback-porch = <29>;
+				vfront-porch = <13>;
+				vsync-len = <3>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+		};
+	};
+};
+
+&pwm1 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
+};
+
+&usbotg1 {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usbotg2 {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_rtc: rtcgrp {
+		fsl,pins = <
+			MX6UL_PAD_SNVS_TAMPER7__GPIO5_IO07	0x1b0b0
+		>;
+	};
+};
-- 
2.7.4

