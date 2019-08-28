Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3697C3A5A4
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 16:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC282173E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 16:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCOO+UNR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfH1QUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 12:20:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46162 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfH1QUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 12:20:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id z1so361250wru.13;
        Wed, 28 Aug 2019 09:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6CPxEzCPe+o9sMen7nYO3ZlJyfdH9Q3b+f/rFJ1T2pI=;
        b=QCOO+UNRCCvVuf4EKPxQXeLZNKvq6i7ZUgCu4UpsHCrkUUPaF1N3SfADgtadxUiTq/
         AFQhnV52+KXMbzRxV/MvikLx7u5un+e99BgMaguyHcPqwrUQ/845bFI6VWRlih9yxs0w
         yZ4Fd/mYo+9ZZ5APmZMTW0c6nn7vXi9QjlUEyItj6mx8HCpvXzMQZjKQHjjNu9AqXv/v
         mWNGRmsBieyMGSTstp1SEC3FlbPxh5pJeMLl0Tyr/9r4KPlNQuwN5yLIpYeBPrHmw95/
         /kxJzPkTd5OV3mWd3UIIfvrxeSxjXP0LbFn7I5zLwQq+9icQDqlHiymtR8D24jPUef9q
         hl7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6CPxEzCPe+o9sMen7nYO3ZlJyfdH9Q3b+f/rFJ1T2pI=;
        b=OLIq/Pu3RjYblN57KXIHLDuKPhE6ZUL3i9dTJfQ46eI6zX9Y6hNahkRTl+9LSVvDgb
         6LDoov1LH6V89z2qdXN0ZXFC/gQbEFed6ZX0bNYi73VPuxVinM5pvsU1PlJTmYzTiUWF
         QBcLnj8ILBAruPBwLfNytDKUvW6hVzVadxjySikULxMRyBjC7TtEp2GIAgjE3bbYMMg9
         i50xtQ/dfux6Dz86JcLZyaYL4qnhH6mgsLehM7oU9f1LHxjUjXsk0yL2gURAR9A7ed3E
         qxEhPkHqceV/wG3Ord6UZQTY2NS/CaHdrz3eKD26bPawB9ITKX6cGhMRGszBYkVI4Ysr
         zerA==
X-Gm-Message-State: APjAAAVTpguyANDv5Dn0XEblXaShYohwvjfqCNvBlF9kM5g35cDl3pRm
        9tmjIY72eeB1S2zXfcIPEiQ=
X-Google-Smtp-Source: APXvYqz4mvANLqBJ6iYHhOnO7VYRJGveLbT37oi03HXIbLORmhrAG/UL+NaIAThvSHk2ydukz4ZAcw==
X-Received: by 2002:adf:efd2:: with SMTP id i18mr5591882wrp.145.1567009202563;
        Wed, 28 Aug 2019 09:20:02 -0700 (PDT)
Received: from localhost ([31.16.217.87])
        by smtp.gmail.com with ESMTPSA id c21sm1927627wml.48.2019.08.28.09.20.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 09:20:01 -0700 (PDT)
From:   Oliver Graute <oliver.graute@gmail.com>
To:     shawnguo@kernel.org
Cc:     oliver.graute@gmail.com, narmstrong@baylibre.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCHv5 2/2] ARM: dts: Add support for i.MX6 UltraLite DART Variscite Customboard
Date:   Wed, 28 Aug 2019 18:19:18 +0200
Message-Id: <1567009160-21965-3-git-send-email-oliver.graute@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567009160-21965-1-git-send-email-oliver.graute@gmail.com>
References: <1567009160-21965-1-git-send-email-oliver.graute@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds DeviceTree Source for the i.MX6 UltraLite DART NAND/WIFI

Signed-off-by: Oliver Graute <oliver.graute@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/boot/dts/Makefile                      |   1 +
 arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts | 196 ++++++++++++++++++++++++
 2 files changed, 197 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index a24a6a1..a2a69e4 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -579,6 +579,7 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ul-tx6ul-0010.dtb \
 	imx6ul-tx6ul-0011.dtb \
 	imx6ul-tx6ul-mainboard.dtb \
+	imx6ul-var-6ulcustomboard.dtb \
 	imx6ull-14x14-evk.dtb \
 	imx6ull-colibri-eval-v3.dtb \
 	imx6ull-colibri-wifi-eval-v3.dtb \
diff --git a/arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts b/arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts
new file mode 100644
index 00000000..1861b34
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts
@@ -0,0 +1,196 @@
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

