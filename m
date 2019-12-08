Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8660CC43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 18:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 576A4205ED
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 18:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="M+IM/CZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfLHSFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 13:05:46 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38584 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfLHSFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 13:05:45 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so12443804wmi.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 10:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nX/VsdwReAfzTgHRbYFywSS+wSQOYA7q3n8LLMhpENQ=;
        b=M+IM/CZMNAv/GLSrwNVOVXeNAE3U5NXW2PwmrdSO7qvWyrkgcNne4CCCFYLp2hV9L7
         w/qcMoIPjMVgxHXipW8jTtJ5CZG+cPYUtC3hEB43zO0P9SG6WfpPKgG+3fWe3btmiYfA
         Xj9MdcVefMDO7d7FaBR7Urex281bd/1BRsDv3lyxMLp5ZyeeenOFhAUqubO++XWLVO8b
         dHvwhW1A/omX7isXGqyiHPaQcK48mdOKqdtLjw+58Zj57G2wHaLVN9Vshsol5t2R6BIX
         AMlZnEKKt9geotWZLR9MDKRK5tCerLGpEuQZvuffEsG32LqS2lrCK1RL7uXzTzv7etRA
         peSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nX/VsdwReAfzTgHRbYFywSS+wSQOYA7q3n8LLMhpENQ=;
        b=I32lVzTuIqDVj2ZPd1RxRL/1DHnCZhXmrU9SUbC7zN81PQ+nKPKZOXuL2FQRmqg1Py
         agC3g61it/cQJNdWmchMAjrXRm42N7FR9LqvR5T8Rzd28LzzSUcY6Sh+dJhEIm+mM9iC
         NOWRZOpJbKML8+54FbwG+z1nUPRIh8xjELcD8lQyI9Kjwq4QNsg50BBLTLZ4L7ZMlbk9
         2ySOX5FZijCxlOwvlYjUINX2zNO6nHIKL6GhYChJYpJgP4irS/rFqFDZqoOrsa7G5CvW
         WKE5e+sPm9l3mCYSXoznpcNGzyfp6xoUW7pKo5ku7W6ceJFlPz2nQfQZoLBoWlQ5kk+2
         5iLQ==
X-Gm-Message-State: APjAAAVCGOva+9oOokl8aVvqw3hk9nFYbi4OFbhdOMUgcVXMHuUhEgw+
        oEADcfXZOdzj+ham/Yw39QMuA6Wg
X-Google-Smtp-Source: APXvYqxeUzJvpPTRlQfa6b/Q+Z5o7aJhPwmHURMUapB5D4Ut6mzjK9ve5sA05s2aZjaIfSrBz7uttQ==
X-Received: by 2002:a1c:6884:: with SMTP id d126mr21569473wmc.135.1575828342623;
        Sun, 08 Dec 2019 10:05:42 -0800 (PST)
Received: from localhost.localdomain (p200300F1371AD700428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:371a:d700:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id a64sm11797687wmc.18.2019.12.08.10.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2019 10:05:42 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com,
        jbrunet@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/3] ARM: dts: meson: provide the XTAL clock using a fixed-clock
Date:   Sun,  8 Dec 2019 19:05:23 +0100
Message-Id: <20191208180525.1076152-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191208180525.1076152-1-martin.blumenstingl@googlemail.com>
References: <20191208180525.1076152-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock controller driver has provided the XTAL clock so far. This
does not match how the hardware actually works because the XTAL clock is
an actual crystal which is mounted on the PCB.

Add the "xtal" clock to meson.dtsi and replace all references to the
clock controller's CLKID_XTAL with the new xtal clock node.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson.dtsi           |  7 +++++++
 arch/arm/boot/dts/meson6.dtsi          |  7 -------
 arch/arm/boot/dts/meson8.dtsi          | 15 ++++++++-------
 arch/arm/boot/dts/meson8b-ec100.dts    |  2 +-
 arch/arm/boot/dts/meson8b-mxq.dts      |  2 +-
 arch/arm/boot/dts/meson8b-odroidc1.dts |  2 +-
 arch/arm/boot/dts/meson8b.dtsi         | 15 ++++++++-------
 7 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
index c4447f6c8b2c..5d198309058a 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -282,4 +282,11 @@ efuse: nvmem@0 {
 			};
 		};
 	};
+
+	xtal: xtal-clk {
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+		clock-output-names = "xtal";
+		#clock-cells = <0>;
+	};
 }; /* end of / */
diff --git a/arch/arm/boot/dts/meson6.dtsi b/arch/arm/boot/dts/meson6.dtsi
index 2d31b7ce3f8c..4716030a48d0 100644
--- a/arch/arm/boot/dts/meson6.dtsi
+++ b/arch/arm/boot/dts/meson6.dtsi
@@ -36,13 +36,6 @@ apb2: bus@d0000000 {
 		ranges = <0x0 0xd0000000 0x40000>;
 	};
 
-	xtal: xtal-clk {
-		compatible = "fixed-clock";
-		clock-frequency = <24000000>;
-		clock-output-names = "xtal";
-		#clock-cells = <0>;
-	};
-
 	clk81: clk@0 {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index 3c534cd50ee3..add6d7991fdf 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -455,6 +455,8 @@ &gpio_intc {
 &hhi {
 	clkc: clock-controller {
 		compatible = "amlogic,meson8-clkc";
+		clocks = <&xtal>;
+		clock-names = "xtal";
 		#clock-cells = <1>;
 		#reset-cells = <1>;
 	};
@@ -529,8 +531,7 @@ &rtc {
 
 &saradc {
 	compatible = "amlogic,meson8-saradc", "amlogic,meson-saradc";
-	clocks = <&clkc CLKID_XTAL>,
-		<&clkc CLKID_SAR_ADC>;
+	clocks = <&xtal>, <&clkc CLKID_SAR_ADC>;
 	clock-names = "clkin", "core";
 	amlogic,hhi-sysctrl = <&hhi>;
 	nvmem-cells = <&temperature_calib>;
@@ -548,31 +549,31 @@ &spifc {
 };
 
 &timer_abcde {
-	clocks = <&clkc CLKID_XTAL>, <&clkc CLKID_CLK81>;
+	clocks = <&xtal>, <&clkc CLKID_CLK81>;
 	clock-names = "xtal", "pclk";
 };
 
 &uart_AO {
 	compatible = "amlogic,meson8-uart", "amlogic,meson-uart";
-	clocks = <&clkc CLKID_CLK81>, <&clkc CLKID_XTAL>, <&clkc CLKID_CLK81>;
+	clocks = <&clkc CLKID_CLK81>, <&xtal>, <&clkc CLKID_CLK81>;
 	clock-names = "baud", "xtal", "pclk";
 };
 
 &uart_A {
 	compatible = "amlogic,meson8-uart", "amlogic,meson-uart";
-	clocks = <&clkc CLKID_CLK81>, <&clkc CLKID_XTAL>, <&clkc CLKID_UART0>;
+	clocks = <&clkc CLKID_CLK81>, <&xtal>, <&clkc CLKID_UART0>;
 	clock-names = "baud", "xtal", "pclk";
 };
 
 &uart_B {
 	compatible = "amlogic,meson8-uart", "amlogic,meson-uart";
-	clocks = <&clkc CLKID_CLK81>, <&clkc CLKID_XTAL>, <&clkc CLKID_UART1>;
+	clocks = <&clkc CLKID_CLK81>, <&xtal>, <&clkc CLKID_UART1>;
 	clock-names = "baud", "xtal", "pclk";
 };
 
 &uart_C {
 	compatible = "amlogic,meson8-uart", "amlogic,meson-uart";
-	clocks = <&clkc CLKID_CLK81>, <&clkc CLKID_XTAL>, <&clkc CLKID_UART2>;
+	clocks = <&clkc CLKID_CLK81>, <&xtal>, <&clkc CLKID_UART2>;
 	clock-names = "baud", "xtal", "pclk";
 };
 
diff --git a/arch/arm/boot/dts/meson8b-ec100.dts b/arch/arm/boot/dts/meson8b-ec100.dts
index bed1dfef1985..163a200d5a7b 100644
--- a/arch/arm/boot/dts/meson8b-ec100.dts
+++ b/arch/arm/boot/dts/meson8b-ec100.dts
@@ -377,7 +377,7 @@ &pwm_cd {
 	status = "okay";
 	pinctrl-0 = <&pwm_c1_pins>, <&pwm_d_pins>;
 	pinctrl-names = "default";
-	clocks = <&clkc CLKID_XTAL>, <&clkc CLKID_XTAL>;
+	clocks = <&xtal>, <&xtal>;
 	clock-names = "clkin0", "clkin1";
 };
 
diff --git a/arch/arm/boot/dts/meson8b-mxq.dts b/arch/arm/boot/dts/meson8b-mxq.dts
index 6e39ad52e42d..33037ef62d0a 100644
--- a/arch/arm/boot/dts/meson8b-mxq.dts
+++ b/arch/arm/boot/dts/meson8b-mxq.dts
@@ -165,7 +165,7 @@ &pwm_cd {
 	status = "okay";
 	pinctrl-0 = <&pwm_c1_pins>, <&pwm_d_pins>;
 	pinctrl-names = "default";
-	clocks = <&clkc CLKID_XTAL>, <&clkc CLKID_XTAL>;
+	clocks = <&xtal>, <&xtal>;
 	clock-names = "clkin0", "clkin1";
 };
 
diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index a24eccc354b9..a2a47804fc4a 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -340,7 +340,7 @@ &pwm_cd {
 	status = "okay";
 	pinctrl-0 = <&pwm_c1_pins>, <&pwm_d_pins>;
 	pinctrl-names = "default";
-	clocks = <&clkc CLKID_XTAL>, <&clkc CLKID_XTAL>;
+	clocks = <&xtal>, <&xtal>;
 	clock-names = "clkin0", "clkin1";
 };
 
diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 099bf8e711c9..1934666ff60f 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -434,6 +434,8 @@ &gpio_intc {
 &hhi {
 	clkc: clock-controller {
 		compatible = "amlogic,meson8-clkc";
+		clocks = <&xtal>;
+		clock-names = "xtal";
 		#clock-cells = <1>;
 		#reset-cells = <1>;
 	};
@@ -508,8 +510,7 @@ &rtc {
 
 &saradc {
 	compatible = "amlogic,meson8b-saradc", "amlogic,meson-saradc";
-	clocks = <&clkc CLKID_XTAL>,
-		<&clkc CLKID_SAR_ADC>;
+	clocks = <&xtal>, <&clkc CLKID_SAR_ADC>;
 	clock-names = "clkin", "core";
 	amlogic,hhi-sysctrl = <&hhi>;
 	nvmem-cells = <&temperature_calib>;
@@ -523,31 +524,31 @@ &sdio {
 };
 
 &timer_abcde {
-	clocks = <&clkc CLKID_XTAL>, <&clkc CLKID_CLK81>;
+	clocks = <&xtal>, <&clkc CLKID_CLK81>;
 	clock-names = "xtal", "pclk";
 };
 
 &uart_AO {
 	compatible = "amlogic,meson8b-uart", "amlogic,meson-uart";
-	clocks = <&clkc CLKID_CLK81>, <&clkc CLKID_XTAL>, <&clkc CLKID_CLK81>;
+	clocks = <&clkc CLKID_CLK81>, <&xtal>, <&clkc CLKID_CLK81>;
 	clock-names = "baud", "xtal", "pclk";
 };
 
 &uart_A {
 	compatible = "amlogic,meson8b-uart", "amlogic,meson-uart";
-	clocks = <&clkc CLKID_CLK81>, <&clkc CLKID_XTAL>, <&clkc CLKID_UART0>;
+	clocks = <&clkc CLKID_CLK81>, <&xtal>, <&clkc CLKID_UART0>;
 	clock-names = "baud", "xtal", "pclk";
 };
 
 &uart_B {
 	compatible = "amlogic,meson8b-uart", "amlogic,meson-uart";
-	clocks = <&clkc CLKID_CLK81>, <&clkc CLKID_XTAL>, <&clkc CLKID_UART1>;
+	clocks = <&clkc CLKID_CLK81>, <&xtal>, <&clkc CLKID_UART1>;
 	clock-names = "baud", "xtal", "pclk";
 };
 
 &uart_C {
 	compatible = "amlogic,meson8b-uart", "amlogic,meson-uart";
-	clocks = <&clkc CLKID_CLK81>, <&clkc CLKID_XTAL>, <&clkc CLKID_UART2>;
+	clocks = <&clkc CLKID_CLK81>, <&xtal>, <&clkc CLKID_UART2>;
 	clock-names = "baud", "xtal", "pclk";
 };
 
-- 
2.24.0

