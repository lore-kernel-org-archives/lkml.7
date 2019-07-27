Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA87CC761A8
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 12:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA6C2070B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 12:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="EQ90Eqq2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387527AbfG0MNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 08:13:20 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52199 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfG0MNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 08:13:06 -0400
Received: by mail-wm1-f66.google.com with SMTP id 207so50058334wma.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 05:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zjlCoClPn+D5FtsYbuSMIRYDvq5CiGUidcCupd7dJ90=;
        b=EQ90Eqq29nsB2bd9Ao/E9BDvc34M6m2OUORIMOGkQInOkxt8F+vZTze3ALhPN5U//z
         5qZBaZBl0IU8hJ2gVN9KoZUdQAJyXmclk/HW3+ofk3eSJ2D6fBbtiaHaSWVdCZ4Qi/Av
         l4RpXo7W6Sbnp0CXOPaTF5oB5lopksyqVTJRzoBhzMmyZURS2Nh2VIzThcxLAXao3rmr
         O3VCe4SngwbQ/Fu0F6YnPW+zpQ5iy2Pci0LOX5czlku5Bst/8Wx94aPop6LCYzYr6p2P
         dDVieoEWxHr+pTdw7DHK1YdGBtL2d/KywrovVKbCvqk/Xa1cuZAe4Rj1o8YXoSGjPDcf
         y2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zjlCoClPn+D5FtsYbuSMIRYDvq5CiGUidcCupd7dJ90=;
        b=hGFQh/mfXqRANPEmAVUELCr5EHJ67G4WSidTVQaz0jeLr85al3xik2u4fI7X5dG5FK
         G+sr2gWqLbeFg8hmZQDyXJdb7Gcv+nknKYuUl1QiKcGY8joQtagbJASkIEbLit6qT7Zl
         7PhJZyYcJBa+gT9M3cIxXibWFLtyFA8DPSiT+HYqxo5FqW/vWGCO/RGaPQyrP3NkXB87
         9xz3LrDOKygXu9FsC++GfSDDMTK0h/bgp5UReOJuQt9UXalkMoshXZUzVGjz21jPxRaR
         Jq/lpkPmaAQNPNkyQcjIhYHjzbyf8Hh0a2EZS7h+QsQ1qafYTabltZ6ZXaZUHbnKNmPH
         S0hw==
X-Gm-Message-State: APjAAAUqX3FhEEFHQupJkbo+ZbOzErVXZjkM3iCLUErPVvifautRZ3Tj
        wCnp200xazEPCrzeIFsgn5Q=
X-Google-Smtp-Source: APXvYqy+qq3YOx5KKzeDY893qKSGWhvt8/1aA0TqVr6FY9sy46M3iJUKGQzpmPYsEiqOHSu6EZKLJw==
X-Received: by 2002:a1c:acc8:: with SMTP id v191mr92720425wme.177.1564229585104;
        Sat, 27 Jul 2019 05:13:05 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133C65C00B418D0F4A25A19EC.dip0.t-ipconnect.de. [2003:f1:33c6:5c00:b418:d0f4:a25a:19ec])
        by smtp.googlemail.com with ESMTPSA id o26sm111786569wro.53.2019.07.27.05.13.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 27 Jul 2019 05:13:04 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 2/4] ARM: dts: meson8b: ec100: add the VDDEE regulator
Date:   Sat, 27 Jul 2019 14:12:55 +0200
Message-Id: <20190727121257.18017-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190727121257.18017-1-martin.blumenstingl@googlemail.com>
References: <20190727121257.18017-1-martin.blumenstingl@googlemail.com>
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
 arch/arm/boot/dts/meson8b-ec100.dts | 31 ++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/meson8b-ec100.dts b/arch/arm/boot/dts/meson8b-ec100.dts
index 96d239d8334e..bed1dfef1985 100644
--- a/arch/arm/boot/dts/meson8b-ec100.dts
+++ b/arch/arm/boot/dts/meson8b-ec100.dts
@@ -219,6 +219,27 @@
 		 */
 		vin-supply = <&vcc_3v3>;
 	};
+
+	vddee: regulator-vddee {
+		/*
+		 * Silergy SY8089AAC-GP 2A continuous, 3A peak, 1MHz
+		 * Synchronous Step Down Regulator. Also called VDDAO
+		 * in a part of the schematics.
+		 */
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
@@ -269,6 +290,10 @@
 	};
 };
 
+&mali {
+	mali-supply = <&vddee>;
+};
+
 &saradc {
 	status = "okay";
 	vref-supply = <&vcc_1v8>;
@@ -350,10 +375,10 @@
 
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
 
 &rtc {
-- 
2.22.0

