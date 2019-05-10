Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215BBC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E864920881
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="AgQ7ISjc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfEJPxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 11:53:35 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39312 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfEJPxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 11:53:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id w8so6050058wrl.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 08:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o/ZrOKrVBiCPmSKNzKkVtl6ee0CJpkJsgmldCOTIdwo=;
        b=AgQ7ISjcLMgxyeSNtilo9vaG226u/TyFK085WpRbybJu93anjOumklGMP++48zV6wz
         4FI/78ShZkC5z26GPsWzhch6CjlZKcZfQ8CAVRGjK624SyJlhPWjmSMRcb6iJ4WLxOKu
         sgwrR2WWtmnm42nw6iDsAbSB3PFyMYUIXfqnZsaikAf3DaQTRLbBhcYc7WeT+gtscOrD
         rnd/+rDltSJyCM9Hh9KP268I/GVppUxmHa8DBcbnsYVnLyqH10XtAbQyQW55qsSUtuce
         EbIFE+YDbuqUzGL5volDIAl91chm5apGQon07CKClUk97CMKR4RQodmM/29hhhTcPzkK
         +Szg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o/ZrOKrVBiCPmSKNzKkVtl6ee0CJpkJsgmldCOTIdwo=;
        b=No0t7ZSipOdUJNz/k6I2wmdA+HTL23f1j3CsPsyki7c3yVEvOo3rhfRk7nkMfFYgGl
         L/61bZgwq27DLSLHcIIBl80ls1gWFQmzHqgY1tRwCL7iEU0zdxFEasnOVQucO1wmgHNV
         a6iA9y4iDqS99scmJWnndCLao5fG/np+UQxOqkHQhvcZcrhWTlCV+HfmtuivfpaUtloz
         8F+5rfqzP+yKrlq7/uWUV1gtX2LDfhJVvohZf7J9i+rMBggnO8je6bbUwaxEDuMQY8a6
         k1+4Aw7SrApCexDow4m7NXiBkqXbNPB3Q6p9gojnzlwP0LQVPzwFhH+GDNz7m7PMgS/C
         Q8ag==
X-Gm-Message-State: APjAAAXnZJeMi2t+QeEmOBluq4cr/Snms4hDTAk7nJqVq2V9cbs5yhdP
        KjIRDiJGOh+aXvej4984kmnLSMf4ZPA=
X-Google-Smtp-Source: APXvYqwrXeX4zkdcF+luK5aZ8i5L32YJZSkhlWj5pwMryd3fLogSEAt2LHeSq6RuguZbssX+EVNPHw==
X-Received: by 2002:a5d:668f:: with SMTP id l15mr7959140wru.125.1557503612459;
        Fri, 10 May 2019 08:53:32 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id u14sm5333860wrn.30.2019.05.10.08.53.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 08:53:31 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: meson: u200: consistently order nodes
Date:   Fri, 10 May 2019 17:53:27 +0200
Message-Id: <20190510155327.5759-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190510155327.5759-1-jbrunet@baylibre.com>
References: <20190510155327.5759-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like order boards, order nodes by address then node names then aliases.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12a-u200.dts      | 50 ++++++++++---------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
index e91201809abf..7cc3e2d6a4f1 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
@@ -16,13 +16,10 @@
 	aliases {
 		serial0 = &uart_AO;
 	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
-	memory@0 {
-		device_type = "memory";
-		reg = <0x0 0x0 0x0 0x40000000>;
-	};
 
 	cvbs-connector {
 		compatible = "composite-video-connector";
@@ -34,15 +31,6 @@
 		};
 	};
 
-	flash_1v8: regulator-flash_1v8 {
-		compatible = "regulator-fixed";
-		regulator-name = "FLASH_1V8";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		vin-supply = <&vcc_3v3>;
-		regulator-always-on;
-	};
-
 	hdmi-connector {
 		compatible = "hdmi-connector";
 		type = "a";
@@ -54,6 +42,20 @@
 		};
 	};
 
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x40000000>;
+	};
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
 	main_12v: regulator-main_12v {
 		compatible = "regulator-fixed";
 		regulator-name = "12V";
@@ -62,6 +64,17 @@
 		regulator-always-on;
 	};
 
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
 	vcc_1v8: regulator-vcc_1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "VCC_1V8";
@@ -92,17 +105,6 @@
 		enable-active-high;
 	};
 
-	usb_pwr_en: regulator-usb_pwr_en {
-		compatible = "regulator-fixed";
-		regulator-name = "USB_PWR_EN";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		vin-supply = <&vcc_5v>;
-
-		gpio = <&gpio GPIOH_6 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
 	vddao_1v8: regulator-vddao_1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "VDDAO_1V8";
-- 
2.20.1

