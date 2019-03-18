Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12F2C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 707A920854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Q6IPGYW5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbfCRKFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:05:55 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37224 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbfCRKFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:05:06 -0400
Received: by mail-wm1-f65.google.com with SMTP id v14so3538187wmf.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 03:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ka0M5kZ6v8ySNByodqf/V1Upid5BsB19/rCuYJ69Io0=;
        b=Q6IPGYW5JnzybV9eCeTUZGpZ1t+QYBOReq0nmki/vqAM6f2toL/vrjpXSqtdC6EdSF
         V6fjdzkqiS2uvJrNUUQ0+07LUcjVsxVryt2prNRQOCFNI487A+sUZNIobOq2WGvbnYvM
         WGrLRHx/AyYg6H6sbX34SDMQ9WuZvHLvOuPYgBaj8dBj0X0lkNcSuNAC1HTkGRZQGYc8
         51zwHFpnmae1ea6bpf6ZMRy1Oqj52erjsGJSxbxKO31+qO59w8B1h7d/+NByJu2/LdS7
         nG20pLv2QUQR3TW8Bb9eSNg4cr6/oErqroHmxvqP4I0K4Y0jiPgravFcQGekEt5/A5Is
         4I8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ka0M5kZ6v8ySNByodqf/V1Upid5BsB19/rCuYJ69Io0=;
        b=WA4CgEjwGHak+G6sTGdLCeUUDqbTY7C6OZOAzFfInSM/hJV6QOjXYIWAzT+cwUkijF
         UjpsQjzl5jshvzPEGxjv9wwkYMiKGnKskg3QWsqVcmLWa2hdB74zvoyooX9LpdbxlxUT
         1TjID6bbWC9XHAM6GkdZomsLwhsu6DVzdyWXdrh9IfufzQGJsVm1D6rzQIFBhGR7g2HW
         7TyDi3ix/ct8WHCiVxdoVS/L7F0d9cle7BKFCfIKylE/cGXLkrrBxPd6wp024ZqsatTa
         BH7Ua9MMrCTUTTwAwRgtKD7fxFo/s9ItYg+8jaVIxplYHcbUGYffrDCDZE3EK0MmwT5V
         /7DQ==
X-Gm-Message-State: APjAAAV8PsF0uHqrfM9VMu5Y7jTrDVIuZ3UIr77p54ZORT1x5HeXl2GR
        c+fdzJvljcZSYi7cX53NxOr1sQ==
X-Google-Smtp-Source: APXvYqzauSS7+U5mbKeWJsPQvpH05dphmAXYiE8cM/k4iZwv2zyyZWyaecnUIJJttDGlsL1iTuLYEw==
X-Received: by 2002:a1c:d189:: with SMTP id i131mr3139666wmg.151.1552903504114;
        Mon, 18 Mar 2019 03:05:04 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id i11sm5216800wrp.40.2019.03.18.03.05.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 03:05:03 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 04/11] arm64: dts: meson-g12a-u200: add regulators
Date:   Mon, 18 Mar 2019 11:04:51 +0100
Message-Id: <20190318100458.5619-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318100458.5619-1-narmstrong@baylibre.com>
References: <20190318100458.5619-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerome Brunet <jbrunet@baylibre.com>

Add system regulators for the S905D U200 reference design.

Add some regulators. Still missing
* VDD_EE (0.8V - PWM controlled)
* VDD_CPU (PWM controlled)

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12a-u200.dts      | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
index f2afd0bf3e28..c69328d16333 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
@@ -6,6 +6,8 @@
 /dts-v1/;
 
 #include "meson-g12a.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/gpio/meson-g12a-gpio.h>
 
 / {
 	compatible = "amlogic,u200", "amlogic,g12a";
@@ -21,6 +23,83 @@
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x40000000>;
 	};
+
+	flash_1v8: regulator-flash_1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "FLASH_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_3v3>;
+		regulator-always-on;
+	};
+
+	main_12v: regulator-main_12v {
+		compatible = "regulator-fixed";
+		regulator-name = "12V";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		regulator-always-on;
+	};
+
+	vcc_1v8: regulator-vcc_1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_3v3>;
+		regulator-always-on;
+	};
+
+	vcc_3v3: regulator-vcc_3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vddao_3v3>;
+		regulator-always-on;
+		/* FIXME: actually controlled by VDDCPU_B_EN */
+	};
+
+	vcc_5v: regulator-vcc_5v {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&main_12v>;
+
+		gpio = <&gpio GPIOH_8 GPIO_OPEN_DRAIN>;
+		enable-active-high;
+	};
+
+	usb_pwr_en: regulator-usb_pwr_en {
+		compatible = "regulator-fixed";
+		regulator-name = "USB_PWR_EN";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc_5v>;
+
+		gpio = <&gpio GPIOH_6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vddao_1v8: regulator-vddao_1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDAO_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vddao_3v3>;
+		regulator-always-on;
+	};
+
+	vddao_3v3: regulator-vddao_3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDAO_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&main_12v>;
+		regulator-always-on;
+	};
+
 };
 
 &uart_AO {
-- 
2.20.1

