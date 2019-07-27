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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC7AC76190
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 12:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53CE92070B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 12:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bOyXsaOD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfG0MNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 08:13:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56314 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728874AbfG0MNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 08:13:08 -0400
Received: by mail-wm1-f67.google.com with SMTP id a15so50041046wmj.5
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 05:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M5VJ77HzSYMyOnNSU34/RgfTpL1VyZ0UT5tc7uiCpts=;
        b=bOyXsaODj+oGFDXnUUVuZUhUfBLQL2o2uw0ObAXJqabol6/LNMKy8PQiUMWDezAeCm
         nKDX37UApFaq3ykUpHVBNKpdBHdVxNdepU+1Kz+PAc9IyUonr7WqJ/WjaPFFp9cjZFfr
         yiF2qlYqsHcSyPsCYJFFGLl2QmtMnP7PDb7yoSq/RBvOAlyrcAvHOvgIaq7eUwXnz/lr
         FlTlDq/5INFPHfh1mo0p+hBWYKge9eD8+6TuZ4CoCQALMq3GbE6/gkzAIyfucXPeanSn
         tQk6BFgv1mrjIAdChmyHzQTLqH/Hzs5e1spOAfENPe1+UCYPF318Ee3AagW4taHmsnWr
         18xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M5VJ77HzSYMyOnNSU34/RgfTpL1VyZ0UT5tc7uiCpts=;
        b=o2o4jkOyzc/h3o6IZA+RmdcDmp5/mTaoh76hO4PfxDIxP0mTx44gJ0EH+E+5TNFEpJ
         /mt6kwMK8jF280X4qmLUn9mDVMFLHARt1vPBvWkODZ8x2Pq9ro4lmNhMLuwkroKxL1nJ
         aqaBRXp8t33BPRC1ro0DtciKqkoGoSH0ckODNcpf1rv4egGJ3PZfRWCNkm6+sBTh9U9l
         O3ntXaxYvDwloAeXpQR/3Chz00CIub/LcRNaSyk86Mcy8r89wp391P08sZFa/4knvybv
         1zwnTic7hgxVpjPRL/4d9h3dU4zgsThgN8IvDtS/q3+isvUp7y/Mp7ws3h2DlVfEHJbv
         6gCA==
X-Gm-Message-State: APjAAAUdsYvxLjqY8uyRqzStREw+DjXJpuxM20vKXNMJVHHnSJx3gCdF
        VTxfUtMSkMU9nLpQyqp9Ljo=
X-Google-Smtp-Source: APXvYqxbZtZTQGMBIkUPVU7HbCAa3FLI7lq62O0oi2gTvqH7vtlDPfKNmRXpqxz193SKwUhMWl7l/g==
X-Received: by 2002:a1c:544d:: with SMTP id p13mr93863021wmi.78.1564229586042;
        Sat, 27 Jul 2019 05:13:06 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133C65C00B418D0F4A25A19EC.dip0.t-ipconnect.de. [2003:f1:33c6:5c00:b418:d0f4:a25a:19ec])
        by smtp.googlemail.com with ESMTPSA id o26sm111786569wro.53.2019.07.27.05.13.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 27 Jul 2019 05:13:05 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 3/4] ARM: dts: meson8b: odroidc1: add the VDDEE regulator
Date:   Sat, 27 Jul 2019 14:12:56 +0200
Message-Id: <20190727121257.18017-4-martin.blumenstingl@googlemail.com>
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
 arch/arm/boot/dts/meson8b-odroidc1.dts | 27 +++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index 86c4614e0a38..90f66dc45115 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -154,6 +154,23 @@
 		vin-supply = <&p5v0>;
 	};
 
+	vddee: regulator-vddee {
+		/* Monolithic Power Systems MP2161 */
+		compatible = "pwm-regulator";
+
+		regulator-name = "VDDEE";
+		regulator-min-microvolt = <860000>;
+		regulator-max-microvolt = <1140000>;
+
+		vin-supply = <&p5v0>;
+
+		pwms = <&pwm_cd 1 12218 0>;
+		pwm-dutycycle-range = <91 0>;
+
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
 	vdd_rtc: regulator-vdd-rtc {
 		/*
 		 * Torex Semiconductor XC6215 configured for a fixed output of
@@ -276,6 +293,10 @@
 	pinctrl-names = "default";
 };
 
+&mali {
+	mali-supply = <&vddee>;
+};
+
 &saradc {
 	status = "okay";
 	vref-supply = <&vcc_1v8>;
@@ -308,10 +329,10 @@
 
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

