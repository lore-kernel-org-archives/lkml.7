Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E9BC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD1720675
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YGMFMvzm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731960AbfETJIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 05:08:12 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46783 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfETJIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 05:08:10 -0400
Received: by mail-pf1-f194.google.com with SMTP id y11so6891782pfm.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 02:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iobrvkxDT6nYXsPnTycSKoAi+/ZUGwRhXcWR3t2hhKA=;
        b=YGMFMvzmnYk0vgW+1qinWeqho4ZrFohDa91VmDHH0o1w7TGJiw9k3Uv7vQnjo6c6DE
         +wAEgQCxg7/pT/3sX2p1y70F3SiL/Vb6nWGWHQTB1tfe3v0almhqdNOHCpJOEbIT5Dm8
         Rm/nJSjTvc09FlYZ/xB3j0Fci3TvQU+Lwjnd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iobrvkxDT6nYXsPnTycSKoAi+/ZUGwRhXcWR3t2hhKA=;
        b=Uxsiq2Va6Q3FYWGkpWJhhA61MAcuhLsz9T1Bjm7wv+ejVVqFSS/XxSFYGzqye/thAs
         VSOT1rXtIq7hBbOR1zl6zjiDn6EKgmlRAli00ufVU6h+pu5YT2rdIgw4gr4JxkZCUyai
         bLjc4W/Fq6vxOAAFy4DL5JwPa1kZbDhylfwgIOrvBeZn5/tQVw/sbTMWCt2mzuK5PZhD
         8bMPb53KXB1Z2lCwzGCVJAcNceCaCzNH0MR+dGgigPQHmWhMg4EYC7dMW6Q6n1Pd//u1
         +yRVSZMEHbSsDR1XsAbXTtWTKJpq3AnBE35ZuGtmLoH1ehVw2RJIhP6nNgtytMsPiVUj
         v3Ow==
X-Gm-Message-State: APjAAAXRSeg+1xbSxBo++j97sD3jlqi4lJojfDDUOtlNDtQnt9U13Mdk
        JQ4TP/jHaFgqML8Jyy4CmjVfLw==
X-Google-Smtp-Source: APXvYqzDwmf2r63M8wJFjDamN8uTWypMZ/YvvCw1Tdx3AB1+JxAKjRinOny5iplJXhONAKLzQyVDGQ==
X-Received: by 2002:a65:42cd:: with SMTP id l13mr21087709pgp.72.1558343289969;
        Mon, 20 May 2019 02:08:09 -0700 (PDT)
Received: from localhost.localdomain ([183.82.227.193])
        by smtp.gmail.com with ESMTPSA id d15sm51671614pfm.186.2019.05.20.02.08.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 02:08:09 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     bshah@mykolab.com, Vasily Khoruzhick <anarsoul@gmail.com>,
        powerpan@qq.com, michael@amarulasolutions.com,
        linux-amarula@amarulasolutions.com, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [DO NOT MERGE] [PATCH v10 11/11] ARM: dts: sun8i: bananapi-m2m: Enable Bananapi S070WV20-CT16 DSI panel
Date:   Mon, 20 May 2019 14:33:18 +0530
Message-Id: <20190520090318.27570-12-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190520090318.27570-1-jagan@amarulasolutions.com>
References: <20190520090318.27570-1-jagan@amarulasolutions.com>
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

