Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80A4C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 06:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A0C820842
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 06:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="BbR+yL4/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbfJCGqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 02:46:31 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43517 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfJCGq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 02:46:29 -0400
Received: by mail-pl1-f195.google.com with SMTP id f21so1007104plj.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 23:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iobrvkxDT6nYXsPnTycSKoAi+/ZUGwRhXcWR3t2hhKA=;
        b=BbR+yL4/NsJS6oq8dISWlmaxqoJMqhGGQQrHj/DXx0JxzwaRpUMfB67TpNUdfMxSRQ
         Y5jAi2gX0HtVv2AzJ9/rhyF1R8Tg8UjZPUZVId+PWfKDV7x39UZd8tfqQ9jdB3f4ekFE
         1SWwRZxEpM2V8SKNccS20fxk03vYwq9NPBNnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iobrvkxDT6nYXsPnTycSKoAi+/ZUGwRhXcWR3t2hhKA=;
        b=fBuWCp6WKnoSyMX5FPsuOOJSLt0GtyByx2DLZCLWc01S40UCpLGP/O1It9ft9HnudD
         2IbcC3bmfFjbe3Ak97qDgMhlbk5RHN1n5cUM/1j9Xdyg+81oeBcvq2NGh/hPiFOsVSuW
         VUdRzFmQzszDeDBu+H2QCPON5lNorVZ+VnvwALkj5P31gOt8yEEq1/L9eUOg1Cri1w2f
         XW8jlrm1Bkn5y8kq6pnn6bF46ABlSuQGzWEZc7RCmjOfZ/OFl6cVi70GkNVKKa7yi/OQ
         ZcC+0fmQLiRBYFSsZOxOBtAiAOgN9Tk0Gdzbv55tHZVEnbvYgnbUXFeWSh4Ndat/uXQ4
         pcrA==
X-Gm-Message-State: APjAAAUpL8fpxjFC/i2sL3ETInnu2Bn9uMYRZWHpJ4a0n9mGpcV9BZK6
        Tk9B1hizybSLv+LkasB49vHLyQ==
X-Google-Smtp-Source: APXvYqwKEdQV435b9tSwO3qAvnE6681+TvxHs5yQQv8hXNnuD+sMc/trfjszHwABt44RSpWlAeprZg==
X-Received: by 2002:a17:902:8f88:: with SMTP id z8mr8195034plo.232.1570085188176;
        Wed, 02 Oct 2019 23:46:28 -0700 (PDT)
Received: from localhost.localdomain ([49.206.203.121])
        by smtp.gmail.com with ESMTPSA id b18sm1423294pfi.157.2019.10.02.23.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 23:46:27 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     michael@amarulasolutions.com, Icenowy Zheng <icenowy@aosc.io>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v11 7/7] ARM: dts: sun8i: bananapi-m2m: Enable Bananapi S070WV20-CT16 DSI panel
Date:   Thu,  3 Oct 2019 12:15:27 +0530
Message-Id: <20191003064527.15128-8-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191003064527.15128-1-jagan@amarulasolutions.com>
References: <20191003064527.15128-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add support for Bananapi S070WV20-CT16 DSI panel to
BPI-M2M board.

DSI panel connected via board DSI port with,
- DCDC1 as VCC-DSI supply
- DLDO1 as VDD supply
- PL5 gpio for lcd reset gpio pin
- PB7 gpio for lcd enable gpio pin
- PL4 gpio for backlight enable pin

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts | 40 ++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts b/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
index e1c75f7fa3ca..4e71e81d2bad 100644
--- a/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
+++ b/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
@@ -44,6 +44,7 @@
 #include "sun8i-a33.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "BananaPi M2 Magic";
@@ -61,6 +62,14 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm 0 50000 PWM_POLARITY_INVERTED>;
+		brightness-levels = <1 2 4 8 16 32 64 128 255>;
+		default-brightness-level = <8>;
+		enable-gpios = <&r_pio 0 4 GPIO_ACTIVE_HIGH>; /* LCD-BL-EN: PL4 */
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -122,6 +131,27 @@
 	status = "okay";
 };
 
+&de {
+	status = "okay";
+};
+
+&dphy {
+	status = "okay";
+};
+
+&dsi {
+	vcc-dsi-supply = <&reg_dcdc1>;		/* VCC3V3-DSI */
+	status = "okay";
+
+	panel@0 {
+		compatible = "bananapi,s070wv20-ct16-icn6211";
+		reg = <0>;
+		enable-gpios = <&pio 1 7 GPIO_ACTIVE_HIGH>; /* LCD-PWR-EN: PB7 */
+		reset-gpios = <&r_pio 0 5 GPIO_ACTIVE_HIGH>; /* LCD-RST: PL5 */
+		backlight = <&backlight>;
+	};
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -157,6 +187,12 @@
 	status = "okay";
 };
 
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm0_pin>;
+	status = "okay";
+};
+
 &r_rsb {
 	status = "okay";
 
@@ -269,6 +305,10 @@
 	status = "okay";
 };
 
+&tcon0 {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pb_pins>;
-- 
2.18.0.321.gffc6fa0e3

