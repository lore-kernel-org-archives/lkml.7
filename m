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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EE2C41517
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 12:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8015B2085A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 12:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="n+YubnUJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbfG0MNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 08:13:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46546 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbfG0MNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 08:13:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id z1so57001895wru.13
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 05:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M1c63JSwpgOze8F8pCPA5/iXGFnYX96rO0PJN0uiLng=;
        b=n+YubnUJE+3ya51GU0gCWEFmN2Is8esPm9su1SzC4xFK2t/5X/wRmg4kKVBOiLOVXE
         SeMTz7HfovTyx8cTWHpiKksKrNa9RopkYILmSMsXboAXIMbICg4pZNgv/K1DRI8sjaj9
         sdj2zbjZeVsLZkw5sjzOUHOZGRC6Fm6U0H9zft11utfOR3n6gCTvr5edK0t35WP8OOth
         wcP5R5xj11f9DdVfL81GywWBwFQlvAGEBvXhwrG9UleZpVCTcTZ399h9+PTP0YcLctem
         IXcjnqg0qSwZmmjGYr/1JAqYdwx3F5XMIofanMlm2aoHg1kvW3MCylPy4WzUzy8SGp5c
         crgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M1c63JSwpgOze8F8pCPA5/iXGFnYX96rO0PJN0uiLng=;
        b=MwxTHabyZ3foQTRQ42lqSbPAg4aOTu2XQUplaFES7VWcU3tlSZQcj7ynXevLfsGD30
         KsYTQUqvWJY37wokxTMT+1nui+76SxuC1nfPM77U7SVBd8acG2iX/QKgaGRRZXD4Ilfx
         J2KKVI48J6vJErfveXjsb82vFne2Vwos8Cgl37GUwelcTQ5Nyubpux+7YzmiOaNerCKq
         lTusm9PcpU0QjL+Zv/Uw4/WFe8TSa5aUBsVxg+e40/8cdZvGFtILJE33C8GttIuHp3gn
         Zz7hZkosvGCXcnTRkSsJ6OtFQ5qt1j/lr3nfyMGwUihnQgmpg5kbHhzoUXoBOs2KV+V3
         nnjw==
X-Gm-Message-State: APjAAAX434OLM7/cgGWV32CumfUxlP5B0mOYppmWGkJ2hKHuoMIb4HWg
        Ksn85ujKG6ePtVWVEhEtNT0=
X-Google-Smtp-Source: APXvYqyr7nirAJDTRhfEZh2/V2yjDVaRoaLfSaO5Fn4FmWl+IwT2T2//0bdNuTazUIEuHY9BVvNKrA==
X-Received: by 2002:a5d:4ec1:: with SMTP id s1mr101413995wrv.19.1564229587054;
        Sat, 27 Jul 2019 05:13:07 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133C65C00B418D0F4A25A19EC.dip0.t-ipconnect.de. [2003:f1:33c6:5c00:b418:d0f4:a25a:19ec])
        by smtp.googlemail.com with ESMTPSA id o26sm111786569wro.53.2019.07.27.05.13.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 27 Jul 2019 05:13:06 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 4/4] ARM: dts: meson8b: mxq: add the VDDEE regulator
Date:   Sat, 27 Jul 2019 14:12:57 +0200
Message-Id: <20190727121257.18017-5-martin.blumenstingl@googlemail.com>
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
 arch/arm/boot/dts/meson8b-mxq.dts | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/meson8b-mxq.dts b/arch/arm/boot/dts/meson8b-mxq.dts
index bb27b34eb346..6e39ad52e42d 100644
--- a/arch/arm/boot/dts/meson8b-mxq.dts
+++ b/arch/arm/boot/dts/meson8b-mxq.dts
@@ -76,6 +76,22 @@
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
@@ -112,6 +128,10 @@
 	};
 };
 
+&mali {
+	mali-supply = <&vddee>;
+};
+
 &saradc {
 	status = "okay";
 	vref-supply = <&vcc_1v8>;
@@ -143,10 +163,10 @@
 
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
2.22.0

