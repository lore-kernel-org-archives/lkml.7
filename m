Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36813C07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 19:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C0F92085A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 19:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="athd6wnv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfEYTCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 15:02:22 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42279 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbfEYTCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 15:02:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id l2so13017079wrb.9
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 12:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wwuYv3aJc+Jn6CC+ws46Y8JvxBizBD22MAUJcAPoAWs=;
        b=athd6wnvzMFvUabNQ5m23SBnvwwo2uiQkJ3YFUL8HHiVgS4lEYg6Ehj1l7FuqSYAIy
         o98L0uICFvssWTZYMTW/Doe9uC+xur1WNzSrjeEQHUmG/d1v6jTGYFink/Xl3TR3U/iw
         lF4ZleVNnzs6AlkJGWSjMCpo+YG+U8pxgBmuwel5k8rVrgRYmyv9DJ34SRLmcXKksFUk
         fmr+ka5pylHD/8r+x1yyl6fzKXZa9r/E6bZ7L/CmXtMj2mUjtNP5Sa9Jtu0v3EwyqW4H
         dTCjunvDz/QeyqxwI+vYuE3dXHKPWRhTnPJ1pYBkwrAumt7SwU00e3qP6qEpAahTC5qS
         h9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wwuYv3aJc+Jn6CC+ws46Y8JvxBizBD22MAUJcAPoAWs=;
        b=qZXjZoez1LbJF7P3ExRJlAV3ThB7IOzr02hWBG4UOI282rWNIggWKtn1twFZ/quWa2
         67QcKR+Obu1JGs/66TuKNFUaTk9H8vTL0O0L6vnmsKcaVGC465OMm9P+gXn+/H3KRYNs
         k7bHAyDK+LfT01+8deGg/I4o20l2KWoY1PlV+SLGAhNkjWu+1Wy5QVwBUV7gJKaM7iLd
         ShWXy8yvZsYoupNwfFPah7c2NOj1OnbKqMsKZsxxVJiY37j/W8noMUBc2EjWD32lVFsp
         5qNtzUe5yh5wKgZkcGWUvkMSeizgIi1tioA01R3RSS8MwbRtwIqxGRikyeMZ5a7lRtrB
         JVVg==
X-Gm-Message-State: APjAAAUAwoQCQ2b/ssJQoKUskPa8N3gKECsa+a7dptVPa8CUibq8qDsi
        15JZquj5mRWJZAzAugKOuz0=
X-Google-Smtp-Source: APXvYqy52Xb3yRcwFLGBRb8J5DjY31vTTOpWN18I1HEqnnydCPU1mcr8g4nguQ6yCFdL8ZnffvoBmA==
X-Received: by 2002:adf:9c8e:: with SMTP id d14mr15880942wre.215.1558810934037;
        Sat, 25 May 2019 12:02:14 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA4007CB8841254CD64FD.dip0.t-ipconnect.de. [2003:f1:33dd:a400:7cb8:8412:54cd:64fd])
        by smtp.googlemail.com with ESMTPSA id f2sm6870426wme.12.2019.05.25.12.02.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 12:02:13 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 4/4] ARM: dts: meson8b: mxq: add the VDDEE regulator
Date:   Sat, 25 May 2019 21:02:04 +0200
Message-Id: <20190525190204.7897-5-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190525190204.7897-1-martin.blumenstingl@googlemail.com>
References: <20190525190204.7897-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VDDEE regulator is basically a copy of the VCCK regulator. VDDEE
supplies for example the Mali GPU and is controlled by PWM_D instead of
PWM_C.

Add the VDDEE PWM regulator and make it the supply of the Mali GPU.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b-mxq.dts | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/meson8b-mxq.dts b/arch/arm/boot/dts/meson8b-mxq.dts
index 07f1cc513f8a..8f7a02c1e27b 100644
--- a/arch/arm/boot/dts/meson8b-mxq.dts
+++ b/arch/arm/boot/dts/meson8b-mxq.dts
@@ -116,6 +116,22 @@
 		regulator-boot-on;
 		regulator-always-on;
 	};
+
+	vddee: regulator-vddee {
+		compatible = "pwm-regulator";
+
+		regulator-name = "VDDEE";
+		regulator-min-microvolt = <860000>;
+		regulator-max-microvolt = <1140000>;
+
+		vin-supply = <&vcc_5v>;
+
+		pwms = <&pwm_cd 1 1148 0>;
+		pwm-dutycycle-range = <100 0>;
+
+		regulator-boot-on;
+		regulator-always-on;
+	};
 };
 
 &cpu0 {
@@ -151,6 +167,10 @@
 	};
 };
 
+&mali {
+	mali-supply = <&vddee>;
+};
+
 &saradc {
 	status = "okay";
 	vref-supply = <&vcc_1v8>;
@@ -182,10 +202,10 @@
 
 &pwm_cd {
 	status = "okay";
-	pinctrl-0 = <&pwm_c1_pins>;
+	pinctrl-0 = <&pwm_c1_pins>, <&pwm_d_pins>;
 	pinctrl-names = "default";
-	clocks = <&clkc CLKID_XTAL>;
-	clock-names = "clkin0";
+	clocks = <&clkc CLKID_XTAL>, <&clkc CLKID_XTAL>;
+	clock-names = "clkin0", "clkin1";
 };
 
 &uart_AO {
-- 
2.21.0

