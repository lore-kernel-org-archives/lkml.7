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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E79C07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 19:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1A32085A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 19:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="KMnJSlAf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfEYTCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 15:02:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37304 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbfEYTCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 15:02:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id e15so13028893wrs.4
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 12:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hkt/Np1IRlTONH5ji7tqTfAwm8WEpSqR1gunLTp9R3E=;
        b=KMnJSlAfrtHVE6bAvSaTeQUHkXq8tF6jYakZK4zjQScDZc3QKks15L7mb+Ns/SVAka
         YkrjQkupgUS9S3Uzkz0KAuMAASnIINJS/CCnVociy3kPErHETBV2AE8suTQijp9hc/Lg
         BDBMWIUtrxBCHHbrCXuW5kSysGkh61CnuWpIG4zTY5cnviL0TveHQA3Xo21v8P//dxDi
         sDZ8H1DC72sGCh/J6bjE7xQPsBd3h+JmvgNt0fEzYaM2pOQ7DHwm/JoA6E9o9tfXvF7n
         5W8Cgt75fi0ux4rDNdbFg/E+Q5PrSMdzPiv5Nrif1L4FLAwT49Bdo0uPLFyV4+PlZVcA
         dwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hkt/Np1IRlTONH5ji7tqTfAwm8WEpSqR1gunLTp9R3E=;
        b=JZ36UljxaR2QUBusZ9pdbO/cpn7S0+Al8zCBYiYqlUR2EJRZnP5MEmFyGjiUlGxmw/
         D5rcs+NVv69Jz/APuSEDDHdEuSx9GfbQQYdMz4nFfdVrt+mi+0e4vUYf3l17Pgu0IXwG
         7c65LyCer1XoGP3iVoTHsZSK0VO3gWflpZZXSDWf3K5pwuD6Ca4Sc238olafCxbbeg0m
         aMWNGrNKJGkvdbX2+MsK5NROsVUUCmvnSbnDPnn/GKCn4XzZ76mKSC+B64a9i49avjjX
         m/tUpv5oIZjpIQ/kbjiHU2+4GWHqa4yP4/NTrd+ceTKhw8t7UA+uoj5o9TZzaKncy+ej
         jX0Q==
X-Gm-Message-State: APjAAAX6iYvxsV9hiaObagGywPo1mmKafiXgziyak2MMaFVbfM0PWQuV
        1O4bXBUyOBPHuIjq22W43aI=
X-Google-Smtp-Source: APXvYqw/Y4OHw3xenTNmXBR12kuloK8/8HdBN0u9xdKRZykPGp047t6EkSAFYhXJLYS+ZGKxiJpo0Q==
X-Received: by 2002:a5d:4e46:: with SMTP id r6mr68767055wrt.290.1558810932149;
        Sat, 25 May 2019 12:02:12 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA4007CB8841254CD64FD.dip0.t-ipconnect.de. [2003:f1:33dd:a400:7cb8:8412:54cd:64fd])
        by smtp.googlemail.com with ESMTPSA id f2sm6870426wme.12.2019.05.25.12.02.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 12:02:11 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/4] ARM: dts: meson8b: ec100: add the VDDEE regulator
Date:   Sat, 25 May 2019 21:02:02 +0200
Message-Id: <20190525190204.7897-3-martin.blumenstingl@googlemail.com>
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
 arch/arm/boot/dts/meson8b-ec100.dts | 31 ++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/meson8b-ec100.dts b/arch/arm/boot/dts/meson8b-ec100.dts
index 9bf4249cb60d..61a1265064dc 100644
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
@@ -268,6 +289,10 @@
 	};
 };
 
+&mali {
+	mali-supply = <&vddee>;
+};
+
 &saradc {
 	status = "okay";
 	vref-supply = <&vcc_1v8>;
@@ -349,10 +374,10 @@
 
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
2.21.0

