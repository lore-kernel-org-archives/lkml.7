Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B4BC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 20:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1589320856
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 20:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxXRp+dc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfH1U1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 16:27:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40589 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfH1U1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 16:27:41 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so315743pgj.7;
        Wed, 28 Aug 2019 13:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H3TaHXh40u3n0F6bWhwXE55sOEX1gdGCs8//Mjl/cgg=;
        b=pxXRp+dcAPOvuhrpBRPj5rojusM/4Vly9II1NcRAZGMd7ZusoIKA+YW6WSJQxQBcoF
         uAKGIOYaR8sm7NuchZcMQfS9fJGG0Qne5p2jRa1oZRpTSLu/BzMWQeLfBusjDeZYu9Cw
         3AYd5oZ3K4sy/FIqt1RpvROQ547qCJbZ9kIa1WwQIj82hGsg1dw6u3hscx6SqrWeKKuf
         Gw5+fQMtg3RshRohp4Aq5Gc2MySfbU0TdjUf6nZyalzleND/LJAXg0thhg/3bGVCK6Uc
         2hRBMlZtBc+6HxqiIf/xXfAZNOy3334VN5VL9joc+W3hz5p9VfFGO9VMTY7mNI2Dhb3Z
         C62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H3TaHXh40u3n0F6bWhwXE55sOEX1gdGCs8//Mjl/cgg=;
        b=ppJvhVpd2lXh3zRLtHMDKkAGMWtA23SkQsRvxyLMjPDdm0AtxmE23gGctuzFr5hvVL
         qeXHmHgJIwBpw+FSndscTrmydWclJghGFI7nyI0Or4F6/mTA33zhQuVGGK6ciXfTjXbB
         Hxy9sXGGu2pqMg3uwCtIKbZZzaY/DEfKVqajqCPkSbbvJn6wLag/aNUEly79TlgnIsZ8
         d5fkRAQ4uRL6d6/czZJgKuj8kaiuHvabi9Y6UTYGx49JoV0E0OUDpEU15vjFbkw6rcjQ
         C0Fz2j/ZERuVpIPsDRtqBpzffrtMw2z1/cuy8XJufiiwvi4G8nU1L4vkNpP6Vo0v9sqX
         JjHg==
X-Gm-Message-State: APjAAAWFkI30jAG5XN6C1Y1ftgxVf75QFJKPm5Ojovt6NlwiBBhNC3Tj
        0Xw+LX687/fTvmpdSpgjxno=
X-Google-Smtp-Source: APXvYqwqw9qfMbfRLhRue8n6CaEGwwbgj25iyHQoNwY/e/7uyTMd0ancltVyPHK2aj7xm/j3Lbz0zg==
X-Received: by 2002:a17:90a:5d98:: with SMTP id t24mr6082984pji.94.1567024061115;
        Wed, 28 Aug 2019 13:27:41 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.111])
        by smtp.gmail.com with ESMTPSA id g2sm253373pfq.88.2019.08.28.13.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 13:27:40 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCHv1 2/3] arm64: dts: meson: odroid-c2: Add missing regulator linked to VDDIO_AO3V3 regulator
Date:   Wed, 28 Aug 2019 20:27:22 +0000
Message-Id: <20190828202723.1145-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190828202723.1145-1-linux.amoon@gmail.com>
References: <20190828202723.1145-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per shematics TFLASH_VDD, TF_IO, VCC3V3 fixed regulator output which
is supplied by VDDIO_AO3V3.

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 98e742bf44c1..a078a1ee5004 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -67,17 +67,19 @@
 	};
 
 	tflash_vdd: regulator-tflash_vdd {
-		/*
-		 * signal name from schematics: TFLASH_VDD_EN
-		 */
 		compatible = "regulator-fixed";
 
 		regulator-name = "TFLASH_VDD";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 
+		/*
+		 * signal name from schematics: TFLASH_VDD_EN
+		 */
 		gpio = <&gpio GPIOY_12 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
+		/* U16 RT9179GB */
+		vin-supply = <&vddio_ao3v3>;
 	};
 
 	tf_io: gpio-regulator-tf_io {
@@ -95,6 +97,8 @@
 
 		states = <3300000 0
 			  1800000 1>;
+		/* U12/U13 RT9179GB */
+		vin-supply = <&vddio_ao3v3>;
 	};
 
 	vcc1v8: regulator-vcc1v8 {
@@ -102,6 +106,9 @@
 		regulator-name = "VCC1V8";
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+		/* U18 RT9179GB */
+		vin-supply = <&vddio_ao3v3>;
 	};
 
 	vddio_ao1v8: regulator-vddio-ao1v8 {
-- 
2.23.0

