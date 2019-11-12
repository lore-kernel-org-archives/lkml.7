Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764D3C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 19:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4517B20818
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 19:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hh49R1v4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfKLTWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 14:22:31 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35573 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbfKLTW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 14:22:29 -0500
Received: by mail-wm1-f68.google.com with SMTP id 8so4232756wmo.0;
        Tue, 12 Nov 2019 11:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aH1KMPZgNfW13tjgH/Mjyuhb4HbQXqtVP7JK7qnKLUQ=;
        b=Hh49R1v4qgT5G9zVSqGPkkoGwTdKbPT/8QEce3N2qRbucv+oBoqw8qBy7aX+HZDYfD
         96KJYhKv9Fo3RpllxT/wuZwUiBGZUANO16SrrVeS7GqQ0qgAVbhr4vFSfM4f8EhjG55p
         Rrxf7I4oeED5DGOm38aDbBqS/4P/+giRZ+e46/Ck7b81vHbKT9Y4nEpeUJxhgyZGU58T
         wwQ/4rFV1AMnto66oTr6/Jc6MmIFwMKu4F3vyZ9o6yt5fMbAXnJ5UhK3l7V0tjnTJ4CS
         GuiItArtU4CuCu06drabaOws7dRoavKQpA91B/wQuv2DCDCkNKnyBFM5Q0TAybQv8mEm
         occw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aH1KMPZgNfW13tjgH/Mjyuhb4HbQXqtVP7JK7qnKLUQ=;
        b=h68PeSE2VBrvS0Y40eAcAwu3RxjSkbpeIUyd3gi4P8vaYnw6EJ/jaP5Q9rv3AFQnf9
         9MA1mYs1lH77HA4j2QkHEHP8zjUXurx4bIksb/7AbSueAg3h/AQOkZX/8EWnfuJCMa+4
         E291qpmHRAYDrh3vOHWYpKgXWRzASg58TPR3mtbOfPQJfNFt1GhJzuap5IHjLvJMEz/a
         RUbT1NaZrMJseo3guCZYD8tnJ+r2gdC2gDW+H+JkTlyPQKDwf9GK0TDi9/HbT+3ivFfA
         C39sm7HSXRa+FegH31p71H3T2Wf4VM2XmzDjg0qHTDGGIjaMOxkxrS/s62JY14gA0YG5
         Ptew==
X-Gm-Message-State: APjAAAW/QmzDyun0avXhmV5odOopx3B4fTdXr8EL7Nn69BWm6Dk+hTa2
        inRRWmXP8HBg0t+gAPHCm5E=
X-Google-Smtp-Source: APXvYqx/bG7Sy2XPzjDpZ6ya2g/f84eSiTXKEfYg84M3FoSwUQSCYbJw3vjFHpMrSWlez3Fo2lsWbA==
X-Received: by 2002:a1c:6146:: with SMTP id v67mr5618275wmb.102.1573586546945;
        Tue, 12 Nov 2019 11:22:26 -0800 (PST)
Received: from localhost (ip1f113d5e.dynamic.kabel-deutschland.de. [31.17.61.94])
        by smtp.gmail.com with ESMTPSA id z9sm12525687wrv.35.2019.11.12.11.22.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 11:22:26 -0800 (PST)
From:   Oliver Graute <oliver.graute@gmail.com>
To:     shawnguo@kernel.org
Cc:     oliver.graute@gmail.com, m.felsch@pengutronix.de,
        narmstrong@baylibre.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCHv7 2/3] ARM: dts: Add support for i.MX6 UltraLite DART Variscite Customboard
Date:   Tue, 12 Nov 2019 20:22:02 +0100
Message-Id: <1573586526-15007-3-git-send-email-oliver.graute@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573586526-15007-1-git-send-email-oliver.graute@gmail.com>
References: <1573586526-15007-1-git-send-email-oliver.graute@gmail.com>
X-Patchwork-Bot: notify
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds DeviceTree Source for the i.MX6 UltraLite DART NAND/WIFI

Signed-off-by: Oliver Graute <oliver.graute@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Marco Felsch <m.felsch@pengutronix.de>
---
Changelog:

v7
 - fixed wakeup-source

v6:
 - added some muxing
 - added codec in sound node
 - added adc1 node

 arch/arm/boot/dts/Makefile                      |   1 +
 arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts | 221 ++++++++++++++++++++++++
 2 files changed, 222 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index df2e1f2..65fac53 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -583,6 +583,7 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ul-tx6ul-0010.dtb \
 	imx6ul-tx6ul-0011.dtb \
 	imx6ul-tx6ul-mainboard.dtb \
+	imx6ul-var-6ulcustomboard.dtb \
 	imx6ull-14x14-evk.dtb \
 	imx6ull-colibri-eval-v3.dtb \
 	imx6ull-colibri-wifi-eval-v3.dtb \
diff --git a/arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts b/arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts
new file mode 100644
index 00000000..5b88aad
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts
@@ -0,0 +1,221 @@
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
+	compatible = "variscite,6ulcustomboard", "fsl,imx6ul";
+
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm1 0 20000>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+		status = "okay";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_keys>;
+
+		user {
+			gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_BACK>;
+			wakeup-source;
+		};
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_leds>;
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
+		simple-audio-card,bitclock-master = <&codec_dai>;
+		simple-audio-card,frame-master = <&codec_dai>;
+
+		cpu_dai: simple-audio-card,cpu {
+			sound-dai = <&sai2>;
+		};
+
+		codec_dai: simple-audio-card,codec {
+			sound-dai = <&wm8731>;
+			system-clock-frequency = <12288000>;
+		};
+	};
+};
+
+&adc1 {
+	vref-supply = <&reg_touch_3v3>;
+	status = "okay";
+};
+
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	status = "okay";
+};
+
+&can2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan2>;
+	status = "okay";
+};
+
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet1>;
+	status = "okay";
+};
+
+&fec2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet2>;
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
+		compatible = "wlf,wm8731";
+		reg = <0x1a>;
+		#sound-dai-cells = <0>;
+		clocks = <&clks IMX6UL_CLK_SAI2>;
+		clock-names = "mclk";
+	};
+
+	touchscreen@38 {
+		compatible = "edt,edt-ft5x06";
+		reg = <0x38>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <4 IRQ_TYPE_NONE>;
+		touchscreen-size-x = <800>;
+		touchscreen-size-y = <480>;
+		touchscreen-inverted-x;
+		touchscreen-inverted-y;
+		wakeup-source;
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
+	pinctrl-0 = <&pinctrl_lcdif>;
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
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1>;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&usbotg1 {
+	disable-over-current;
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usbotg2 {
+	disable-over-current;
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

