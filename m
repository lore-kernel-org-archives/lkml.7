Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A1DC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D9E20B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KwCs5fOw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfE2K5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 06:57:24 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46664 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfE2K5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 06:57:22 -0400
Received: by mail-pl1-f193.google.com with SMTP id bb3so893463plb.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 03:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lMfuNcsK6tuVz7vC7aYS5UVf9NSaVZRFtcoyHVQ3R8M=;
        b=KwCs5fOwghwsU5zqVfivfYLGzuV2zoFcgXvqpGrFf4v+qrweHmIqI0lJmPNL4epz5f
         bMMAXr+tuk70/z4UYM5UxW/zi770+a2NqzhFNfecL2Sa4PWCiHz5H6EUHkB0fy4ge9Bq
         8jK10Q21ii1l1Z/AYeX41oTpqgi372oJT7KSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lMfuNcsK6tuVz7vC7aYS5UVf9NSaVZRFtcoyHVQ3R8M=;
        b=QHH5k/nthey5EAAkNUPQ9uDppUlcG4Qt8zM89wqYDN7R3DDzjSeuepBIDZgfXDzV4X
         WQIVLCqvE6SlHGaY6HRo1g6RxlO9EBOLyJuDbmB18CxpWPR/ovwGghah6Z4vo+5m7t/y
         KeU8VkWHQTPIiKAH8h62PKZu0BgyQUQ5Iw0h073dZuaVU4c2DrkPL8FMLOzP9ZVUVy/9
         0a2LXHSBVneyj9j0I5GyZ7WwzJGDGWiFGauWMQ1CYSdkfb6tBCL/1Oh7EO083O+rP6Ss
         xzJHBhopQ+KZhJ4xRKC/vyxvdCRouuJKEjviEdd7yDsg62MX5iWW4TOvhGmvRcsGYQ9F
         zBBQ==
X-Gm-Message-State: APjAAAW+QnbZq7+ucVx1OsghYoy1FjtI1Lv/wYeEZ07xi+L4tB5mmVDd
        slyvUnuY9jEgMpcs+oRHx8cm5w==
X-Google-Smtp-Source: APXvYqwXHj5uVm2t/AeGvWcmeixCbqNTC6/9vS/5OT5LWc4yeua8wWhsULIPjXFvzVGVBE3iOaNS5Q==
X-Received: by 2002:a17:902:b713:: with SMTP id d19mr79658807pls.123.1559127441569;
        Wed, 29 May 2019 03:57:21 -0700 (PDT)
Received: from localhost.localdomain ([49.206.202.218])
        by smtp.gmail.com with ESMTPSA id 184sm18974479pfa.48.2019.05.29.03.57.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 03:57:21 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-amarula@amarulasolutions.com,
        Sergey Suloev <ssuloev@orpaltech.com>,
        Ryan Pannell <ryan@osukl.com>, bshah@mykolab.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [DO NOT MERGE] [PATCH v9 9/9] arm64: dts: allwinner: oceanic-5205-5inmfd: Enable Microtech MTF050FHDI-03 panel
Date:   Wed, 29 May 2019 16:26:15 +0530
Message-Id: <20190529105615.14027-10-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190529105615.14027-1-jagan@amarulasolutions.com>
References: <20190529105615.14027-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Microtech MTF050FHDI-03 is 1080x1920, 4-lane MIPI DSI LCD panel which
has inbuilt NT35596 IC chip.

DSI panel connected to board via 39-pin FPC port with,
- DLDO1 as VCC-DSI supply
- DLDO2 as DVDD supply
- DC1SW as AVDD supply
- DC1SW as AVEE supply
- PD24 gpio for reset pin
- PH10 gpio for backlight enable pin

Tested-by: Tamas Papp <tamas@osukl.com>
Signed-off-by: Ryan Pannell <ryan@osukl.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../sun50i-a64-oceanic-5205-5inmfd.dts        | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts
index a4ddc0b9664c..ab9ee10ba6a2 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include "sun50i-a64-sopine.dtsi"
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "Oceanic 5205 5inMFD";
@@ -22,6 +23,15 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&r_pwm 0 50000 PWM_POLARITY_INVERTED>;
+		brightness-levels = <412 512>;
+		num-interpolated-steps = <100>;
+		default-brightness-level = <100>;
+		enable-gpios = <&pio 7 10 GPIO_ACTIVE_HIGH>; /* LCD-BL-EN: PH10 */
+	};
+
 	can_osc: can-osc {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -40,6 +50,29 @@
 	};
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
+	vcc-dsi-supply = <&reg_dldo1>;		/* VCC-DSI */
+	status = "okay";
+
+	panel@0 {
+		compatible = "microtech,mtf050fhdi-03", "novatek,nt35596";
+		reg = <0>;
+		dvdd-supply = <&reg_dldo2>;			/* VCC-MIPI */
+		avdd-supply = <&reg_dc1sw>;			/* AVDD_5V0 */
+		avee-supply = <&reg_dc1sw>;			/* AVEE_5V */
+		reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>;	/* LCD-RST: PD24 */
+		backlight = <&backlight>;
+	};
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -81,10 +114,26 @@
 	status = "okay";
 };
 
+&r_pwm {
+	status = "okay";
+};
+
 &reg_dc1sw {
 	regulator-name = "vcc-phy";
 };
 
+&reg_dldo1 {
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-dsi";
+};
+
+&reg_dldo2 {
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-name = "vcc-mipi";
+};
+
 &reg_ldo_io0 {
 	regulator-min-microvolt = <2800000>;
 	regulator-max-microvolt = <2800000>;
-- 
2.18.0.321.gffc6fa0e3

