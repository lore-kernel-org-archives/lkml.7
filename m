Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E2BC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8134F217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="FIQa332o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfE2K5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 06:57:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41644 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfE2K5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 06:57:09 -0400
Received: by mail-pf1-f193.google.com with SMTP id q17so1385997pfq.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 03:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Eyb7BIHD01D0smmXOe136462okq/ItEJbzuGD038kxU=;
        b=FIQa332or/0Y1ihVrB9DQXuCYYKeiS+pyF7rdfe8C0OzeJp99VOjecrS9ERaWdyVXf
         7bK/db+J15eGqgaawGHN477aDbYL3WV8yTui0G9QwX/KRSwGN10+p4RYIesJdz97KHNS
         5f7DEignN1y0LolDRlIT9+q3S4g1+yyh2Z7bY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Eyb7BIHD01D0smmXOe136462okq/ItEJbzuGD038kxU=;
        b=lFTDIfmmZlkBZjVrF1dWM/I6rTPfbsJoJCMb0ngKNrZaUhzNUWVz06VE3n+gwc0mQ2
         I2STYm4XUjKmWTXPpLwbIPktR8oDEnBStH7BY4FMD/AVNM7kcyBdyk6A4BRSBetv3QWq
         0Wb0WfUxYjpJA7DT72aKjQdVA/hrEBeKrV84QpZs/T/xBBgmy+O1BLdtnKI+Hn+8XokR
         SJJNzn5LWRuVKg5Uyef70Y78PUPWLc/IytQ6HSZofebDrFUXq61DzffG+DK1J1wkyViN
         3EZtr3NG2MxywfWSiPyol88lps22IcndUe23Hcff01gOxFCD7PPRSTlahaaOFBDAKBWa
         IUAQ==
X-Gm-Message-State: APjAAAXwjH+12KbI719LBn1z7hRPG04NiVTjPSrkMkf+Vei+esOjLkRO
        x2ahQ18F1Pej4anWNjvP2pA/xA==
X-Google-Smtp-Source: APXvYqysDuO1NSzDIF/g5QolZWZtMoiyhlFCesQaeB1NIziQuIwb/NkDrYa0ajLyvG4RW+9rEWIuPA==
X-Received: by 2002:a63:c20c:: with SMTP id b12mr1312582pgd.3.1559127428328;
        Wed, 29 May 2019 03:57:08 -0700 (PDT)
Received: from localhost.localdomain ([49.206.202.218])
        by smtp.gmail.com with ESMTPSA id 184sm18974479pfa.48.2019.05.29.03.57.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 03:57:07 -0700 (PDT)
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
Subject: [PATCH v9 6/9] arm64: dts: allwinner: a64-amarula-relic: Add Techstar TS8550B MIPI-DSI panel
Date:   Wed, 29 May 2019 16:26:12 +0530
Message-Id: <20190529105615.14027-7-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190529105615.14027-1-jagan@amarulasolutions.com>
References: <20190529105615.14027-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amarula A64-Relic board by default bound with Techstar TS8550B
MIPI-DSI panel, add support for it.

DSI panel connected via board DSI port with,
- DLDO1 as VCC-DSI supply
- DLDO2 as VCC supply
- DLDO2 as IOVCC supply
- PD24 gpio for reset pin
- PD23 gpio for backlight enable pin

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../allwinner/sun50i-a64-amarula-relic.dts    | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
index 5634245d11db..5109c3258a2f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
@@ -9,6 +9,7 @@
 #include "sun50i-a64.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "Amarula A64-Relic";
@@ -18,6 +19,14 @@
 		serial0 = &uart0;
 	};
 
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm 0 50000 PWM_POLARITY_INVERTED>;
+		brightness-levels = <1 2 4 8 16 32 64 128 255>;
+		default-brightness-level = <2>;
+		enable-gpios = <&pio 3 23 GPIO_ACTIVE_HIGH>; /* LCD-BL-EN: PD23 */
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
@@ -80,6 +89,28 @@
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
+		compatible = "techstar,ts8550b", "sitronix,st7701";
+		reg = <0>;
+		VCC-supply = <&reg_dldo2>;	/* VCC-MIPI */
+		IOVCC-supply = <&reg_dldo2>;	/* VCC-MIPI */
+		reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* LCD-RST: PD24 */
+		backlight = <&backlight>;
+	};
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -151,6 +182,10 @@
 	status = "okay";
 };
 
+&pwm {
+	status = "okay";
+};
+
 &r_rsb {
 	status = "okay";
 
-- 
2.18.0.321.gffc6fa0e3

