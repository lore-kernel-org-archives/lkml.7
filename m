Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E9EC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 10:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BDE921530
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 10:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BhwJiYLV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfENKMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 06:12:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44552 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfENKMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 06:12:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id c5so18482226wrs.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 03:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Atf8xTduPRCjHaXk5dCgP7q9YSDsKO5FSEd0MFVYX1Y=;
        b=BhwJiYLVrHp0f/xqZZSNWoay0tbstdkSlIs6prGA+SI3lltcaTNCegPX6mmnazAjux
         hUiIgZZIZd25bQGz/xHRuV+R4JE7TsiuqDekrQhlLgbMU8qkz6BYd0fnpQv49pYkLQki
         yXKJDabVln4yUT/LaIzA92sF1sGfYSqtm9UC4nBAv6n3/7/aNc0Aw04hPbGOrCqmXdpp
         b6xfEHfju50RBn0Og7uJhFVm7aiwLuw1D2atAbSAFtgZlztFgB9YB0BcPmzraj6EfMqC
         Zzp2u50Rn7ihBD5+EzKn8k3Z8vPLJ42sDh4WrSPWM84qBifGep2j0izZJtdHxgiyWx2H
         q3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Atf8xTduPRCjHaXk5dCgP7q9YSDsKO5FSEd0MFVYX1Y=;
        b=fvaAIpeiHUIO4s8ARh7ZPd2xJuk1uonqslPSy3DaNJBHKUTod1Ao9u8NIalnUrGz8F
         9AFZEOB8uu+cIAeTpOpwWTZg1HGQybuqDS76r/na0Yus+QHOpl7/JdCFaDq7DM8j+spi
         ran2HBpLocrkUcYTcokZnVwFDhGGLyZcwa1CTwzOxOxddEmku8Y6iTO2G8Lok3FAkuxZ
         TIY6Oz/WNcbFeLr/9KThp3PpxFzU5ycSIwmw/DpKHUJtQNunSw/+H+rmaeLXaia+p0xy
         pCBpXG2iFto20Lr/Sto2Jy1WFo14YDel7OKlJ8HvLkClcIBPmh3auCg7KyC84sBkt2XG
         EaBA==
X-Gm-Message-State: APjAAAUUuaDr07MeUFkakog2WELkQEjFEcwGf8bHf5NqtbMBXIqNmZSH
        6rtyo+i/5NDZmbb3C6t5xlP36Q==
X-Google-Smtp-Source: APXvYqycdgP46dGvov7Qs/H3XUTJIeYdFqMSfT6eFoH0Mj6MOif7X082m+VcRCv04QbmJbI343elZw==
X-Received: by 2002:adf:81a2:: with SMTP id 31mr20914699wra.165.1557828768534;
        Tue, 14 May 2019 03:12:48 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id r23sm2219564wmh.29.2019.05.14.03.12.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 03:12:47 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Guillaume La Roque <glaroque@baylibre.com>,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 1/3] arm64: dts: meson: g12a: add i2c nodes
Date:   Tue, 14 May 2019 12:12:35 +0200
Message-Id: <20190514101237.13969-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190514101237.13969-1-jbrunet@baylibre.com>
References: <20190514101237.13969-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guillaume La Roque <glaroque@baylibre.com>

Add pinctrl and nodes for i2c support on amlogic g12a

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 268 ++++++++++++++++++++
 1 file changed, 268 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index ca01064a771a..e6c0c19b3223 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -244,6 +244,188 @@
 						};
 					};
 
+
+					i2c0_sda_c_pins: i2c0-sda-c {
+						mux {
+							groups = "i2c0_sda_c";
+							function = "i2c0";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+
+						};
+					};
+
+					i2c0_sck_c_pins: i2c0-sck-c {
+						mux {
+							groups = "i2c0_sck_c";
+							function = "i2c0";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					i2c0_sda_z0_pins: i2c0-sda-z0 {
+						mux {
+							groups = "i2c0_sda_z0";
+							function = "i2c0";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					i2c0_sck_z1_pins: i2c0-sck-z1 {
+						mux {
+							groups = "i2c0_sck_z1";
+							function = "i2c0";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					i2c0_sda_z7_pins: i2c0-sda-z7 {
+						mux {
+							groups = "i2c0_sda_z7";
+							function = "i2c0";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					i2c0_sda_z8_pins: i2c0-sda-z8 {
+						mux {
+							groups = "i2c0_sda_z8";
+							function = "i2c0";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					i2c1_sda_x_pins: i2c1-sda-x {
+						mux {
+							groups = "i2c1_sda_x";
+							function = "i2c1";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					i2c1_sck_x_pins: i2c1-sck-x {
+						mux {
+							groups = "i2c1_sck_x";
+							function = "i2c1";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					i2c1_sda_h2_pins: i2c1-sda-h2 {
+						mux {
+							groups = "i2c1_sda_h2";
+							function = "i2c1";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					i2c1_sck_h3_pins: i2c1-sck-h3 {
+						mux {
+							groups = "i2c1_sck_h3";
+							function = "i2c1";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					i2c1_sda_h6_pins: i2c1-sda-h6 {
+						mux {
+							groups = "i2c1_sda_h6";
+							function = "i2c1";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					i2c1_sck_h7_pins: i2c1-sck-h7 {
+						mux {
+							groups = "i2c1_sck_h7";
+							function = "i2c1";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					i2c2_sda_x_pins: i2c2-sda-x {
+						mux {
+							groups = "i2c2_sda_x";
+							function = "i2c2";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					i2c2_sck_x_pins: i2c2-sck-x {
+						mux {
+							groups = "i2c2_sck_x";
+							function = "i2c2";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					i2c2_sda_z_pins: i2c2-sda-z {
+						mux {
+							groups = "i2c2_sda_z";
+							function = "i2c2";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					i2c2_sck_z_pins: i2c2-sck-z {
+						mux {
+							groups = "i2c2_sck_z";
+							function = "i2c2";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					i2c3_sda_h_pins: i2c3-sda-h {
+						mux {
+							groups = "i2c3_sda_h";
+							function = "i2c3";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					i2c3_sck_h_pins: i2c3-sck-h {
+						mux {
+							groups = "i2c3_sck_h";
+							function = "i2c3";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					i2c3_sda_a_pins: i2c3-sda-a {
+						mux {
+							groups = "i2c3_sda_a";
+							function = "i2c3";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					i2c3_sck_a_pins: i2c3-sck-a {
+						mux {
+							groups = "i2c3_sck_a";
+							function = "i2c3";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
 					pwm_a_pins: pwm-a {
 						mux {
 							groups = "pwm_a";
@@ -589,6 +771,42 @@
 						gpio-ranges = <&ao_pinctrl 0 0 15>;
 					};
 
+					i2c_ao_sck_pins: i2c_ao_sck_pins {
+						mux {
+							groups = "i2c_ao_sck";
+							function = "i2c_ao";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					i2c_ao_sda_pins: i2c_ao_sda {
+						mux {
+							groups = "i2c_ao_sda";
+							function = "i2c_ao";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					i2c_ao_sck_e_pins: i2c_ao_sck_e {
+						mux {
+							groups = "i2c_ao_sck_e";
+							function = "i2c_ao";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					i2c_ao_sda_e_pins: i2c_ao_sda_e {
+						mux {
+							groups = "i2c_ao_sda_e";
+							function = "i2c_ao";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
 					uart_ao_a_pins: uart-a-ao {
 						mux {
 							groups = "uart_ao_a_tx",
@@ -723,6 +941,16 @@
 				status = "disabled";
 			};
 
+			i2c_AO: i2c@5000 {
+				compatible = "amlogic,meson-axg-i2c";
+				status = "disabled";
+				reg = <0x0 0x05000 0x0 0x20>;
+				interrupts = <GIC_SPI 195 IRQ_TYPE_EDGE_RISING>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&clkc CLKID_I2C>;
+			};
+
 			pwm_AO_ab: pwm@7000 {
 				compatible = "amlogic,meson-g12a-ao-pwm-ab";
 				reg = <0x0 0x7000 0x0 0x20>;
@@ -826,6 +1054,46 @@
 				status = "disabled";
 			};
 
+			i2c3: i2c@1c000 {
+				compatible = "amlogic,meson-axg-i2c";
+				status = "disabled";
+				reg = <0x0 0x1c000 0x0 0x20>;
+				interrupts = <GIC_SPI 39 IRQ_TYPE_EDGE_RISING>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&clkc CLKID_I2C>;
+			};
+
+			i2c2: i2c@1d000 {
+				compatible = "amlogic,meson-axg-i2c";
+				status = "disabled";
+				reg = <0x0 0x1d000 0x0 0x20>;
+				interrupts = <GIC_SPI 215 IRQ_TYPE_EDGE_RISING>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&clkc CLKID_I2C>;
+			};
+
+			i2c1: i2c@1e000 {
+				compatible = "amlogic,meson-axg-i2c";
+				status = "disabled";
+				reg = <0x0 0x1e000 0x0 0x20>;
+				interrupts = <GIC_SPI 214 IRQ_TYPE_EDGE_RISING>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&clkc CLKID_I2C>;
+			};
+
+			i2c0: i2c@1f000 {
+				compatible = "amlogic,meson-axg-i2c";
+				status = "disabled";
+				reg = <0x0 0x1f000 0x0 0x20>;
+				interrupts = <GIC_SPI 21 IRQ_TYPE_EDGE_RISING>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&clkc CLKID_I2C>;
+			};
+
 			clk_msr: clock-measure@18000 {
 				compatible = "amlogic,meson-g12a-clk-measure";
 				reg = <0x0 0x18000 0x0 0x10>;
-- 
2.20.1

