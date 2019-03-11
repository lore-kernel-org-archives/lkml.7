Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211A2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D40206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="YqUa5DEP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfCKJ42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:56:28 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35724 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfCKJ4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 05:56:22 -0400
Received: by mail-wm1-f68.google.com with SMTP id y15so3595755wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 02:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dlQmJsnensphSeHI2BxNKgmtHpRyagMWL7c5fX6N84g=;
        b=YqUa5DEPEbi8cm7SdOSEYeTYKPqw2gtnHok/BuxEl/Xvxr0dSCJDrGkriKlgsQK3Qs
         k60gH+H+xtVB0ApI/4+XAm/xtBF42Kf1RoIVGBUsIUwQvZqABdfIddINY6IZDh7SK/V7
         jChE7/FFUnHx9NyZdvAIaLZqf0ldauqTRFe7DpYysZ+wmZ10bw6ajDOeEJustqxlo83N
         bidUhgtICIwna7n/42eHfrI0/A7qlyh49LybeyRzpBDZ3nz6xzto9fQfAdJW/25IxlHf
         G2DOj6DJ5a0tOEu/IrlLI8JoCj52R2dZyZHI+R6wWcvhGjNPf4dNuzUljOvxz0ND40eo
         T0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dlQmJsnensphSeHI2BxNKgmtHpRyagMWL7c5fX6N84g=;
        b=c1Q4+UX/d4jfXB9pZnlNgY2VOMovsu7NZnc+IAU2QWiBpuqvlemFD0eXaWXv+m6wv7
         GY11ZTo4yp88TfHEWFlNulEepjrbW1JImDJJkErEWz4j8g2CyUVHpZBDg8if8HAG9ByV
         yNV13p9Nr0qkjqm/RtQ618oShUqCCN0u/eDWTG3JUgTFcYApklNdxbKaKQUcVDuLwzJY
         PpeVBQxyQHIITyMw9u8OeHE9IS7+2APFtOnEe4JbrRviiuusPiF5R4gFSUYn16F+nW8f
         9zrUiWV1y4KKJBUaLz7Ja0Yb/4ASAdnUk9Q4rzcSp9TNoXHvBs/oiiZPtyi5Xin81xtx
         ZuZw==
X-Gm-Message-State: APjAAAX1Ny2fbmbDGFLyWAa5rDu3s2RyRWY3ZeGN4uAENPPSUB8ZLt1v
        Ra4jco9ml9evV9VCmXvo4hdQCw==
X-Google-Smtp-Source: APXvYqzFnPCm7pP6aZLD3dgEH/TMQKJKZkJE4UY6ET4IF6Krgpq2OQH9Gz56QJgYLgkpcsfc+BqvoQ==
X-Received: by 2002:a1c:7906:: with SMTP id l6mr16117566wme.83.1552298180112;
        Mon, 11 Mar 2019 02:56:20 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e12sm4764737wrs.91.2019.03.11.02.56.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Mar 2019 02:56:19 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 04/11] arm64: dts: meson-g12a-u200: add regulators
Date:   Mon, 11 Mar 2019 10:56:06 +0100
Message-Id: <20190311095613.11371-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190311095613.11371-1-narmstrong@baylibre.com>
References: <20190311095613.11371-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerome Brunet <jbrunet@baylibre.com>

Add system regulators for the S905D2 U200 reference design.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12a-u200.dts      | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
index f2afd0bf3e28..17696f356ff2 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
@@ -14,13 +14,92 @@
 	aliases {
 		serial0 = &uart_AO;
 	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
 	memory@0 {
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

