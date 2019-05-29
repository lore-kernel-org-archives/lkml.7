Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89401C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 600F7217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="gdGxlLlL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfE2K5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 06:57:15 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33309 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfE2K5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 06:57:13 -0400
Received: by mail-pl1-f196.google.com with SMTP id g21so922723plq.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 03:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2ZQ8G0W1S9OmrPavif11lWWMbohgMuBG92FhjQ0hCpY=;
        b=gdGxlLlLsfXGohWiydB6LjurSsdfuFwPeks8QxffA0jURX8ULCrSOR2YiO7hgtpsji
         pRmU5gTaS68DtWTDZ+9jgfF86+uStkqc1uiYAY/md8Bxjem8cy01t+D3dbrvS2sRyZYA
         bx3Xe8a04d+GpRGxmn/E53y2kaBxnnVJcM0zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ZQ8G0W1S9OmrPavif11lWWMbohgMuBG92FhjQ0hCpY=;
        b=JGLE7j9V1eDa9Xg0cxTBXb6yPvJhj+SZ+gYqzN5wHJ/OOptfcx0zWRvF4IDjtv+fSX
         1vU8dyAXjE/5KIzPkO2dRajdcKGdIcsC0vgc29lUGaDIYWjm25mc/NxdFb58CY11q4kI
         3Wjjw4ox+hK7iA1uA3sjsMovJtCtG7Vw5mruwEk5/mVSTDCO1GtuLWGOTj+XU35REk2a
         huzq5etB9yPy2fvV9VmcjbwETvD2YYkOb8V/jYgJpz7yR33bbQlb2fyQwdxxlvkLokWy
         ooPucQbmCK8kVJyiWxZD78rK4ZriCt6pL50WRXpZUjqXiwZaOevwyf/m48UwU53DehG5
         wdag==
X-Gm-Message-State: APjAAAXYl24uVe4mssR3ieQQvuBcRdKRAieDddOtSjVyF8aLk4qYaSZN
        byV0xOVO2fMXCqljbv8tNwyW/Q==
X-Google-Smtp-Source: APXvYqxJAVroZSxkWNSASs009+W1R6iWdZWK44wcz1sc8TL7INu/U1qlJ65ThlWxirmvQ5tEXda/FA==
X-Received: by 2002:a17:902:a982:: with SMTP id bh2mr35644829plb.224.1559127432704;
        Wed, 29 May 2019 03:57:12 -0700 (PDT)
Received: from localhost.localdomain ([49.206.202.218])
        by smtp.gmail.com with ESMTPSA id 184sm18974479pfa.48.2019.05.29.03.57.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 03:57:12 -0700 (PDT)
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
Subject: [DO NOT MERGE] [PATCH v9 7/9] arm64: dts: allwinner: bananapi-m64: Enable Bananapi S070WV20-CT16 DSI panel
Date:   Wed, 29 May 2019 16:26:13 +0530
Message-Id: <20190529105615.14027-8-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190529105615.14027-1-jagan@amarulasolutions.com>
References: <20190529105615.14027-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add support for Bananapi S070WV20-CT16 DSI panel to
BPI-M64 board.

DSI panel connected via board DSI port with,
- DLDO1 as VCC-DSI supply
- DCDC1 as VDD supply
- PD7 gpio for lcd enable pin
- PD6 gpio for lcd reset pin
- PD5 gpio for backlight enable pin

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
index c2a6b73b17cf..166b9761ca83 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
@@ -45,6 +45,7 @@
 #include "sun50i-a64.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "BananaPi-M64";
@@ -56,6 +57,14 @@
 		serial1 = &uart1;
 	};
 
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&r_pwm 0 50000 PWM_POLARITY_INVERTED>;
+		brightness-levels = <1 2 4 8 16 32 64 128 255>;
+		default-brightness-level = <2>;
+		enable-gpios = <&pio 3 5 GPIO_ACTIVE_HIGH>; /* LCD-BL-EN: PD5 */
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
@@ -116,6 +125,24 @@
 	status = "okay";
 };
 
+&dphy {
+	status = "okay";
+};
+
+&dsi {
+	vcc-dsi-supply = <&reg_dldo1>;		/* VCC3V3-DSI */
+	status = "okay";
+
+	panel@0 {
+		compatible = "bananapi,s070wv20-ct16-icn6211";
+		reg = <0>;
+		enable-gpios = <&pio 3 7 GPIO_ACTIVE_HIGH>; /* LCD-PWR-EN: PD7 */
+		reset-gpios = <&pio 3 6 GPIO_ACTIVE_HIGH>; /* LCD-RST: PD6 */
+		vdd-supply = <&reg_dcdc1>;
+		backlight = <&backlight>;
+	};
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -206,6 +233,10 @@
 	status = "okay";
 };
 
+&r_pwm {
+	status = "okay";
+};
+
 &r_rsb {
 	status = "okay";
 
-- 
2.18.0.321.gffc6fa0e3

