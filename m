Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9E0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA2AE2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="bndJ8EPl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbfCKNia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:38:30 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46314 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727940AbfCKNi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:38:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id a22so4050299pgg.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 06:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9PxoL5qRhhi9/8I/MxsRIxkuMzLQLSJqsW5+iDKE8rA=;
        b=bndJ8EPlGei0VqAmSKeefIugVP1+1mzrI/1sjt8TC2fThx0cXpvQszvo0hPOIVkhIi
         70haJK/LkjV2SWLNBV9nk0HUXA8AYBRRPSq54sRyABBL9mUy/jcugpQn6DP4XkXFo29Q
         3bHcmLcHsD4FOdDPklPtE+O8/dMOji25u8aT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9PxoL5qRhhi9/8I/MxsRIxkuMzLQLSJqsW5+iDKE8rA=;
        b=eHN1eWeaDQykw54/mbKH2YhfX3pFbzjkHB6WzbLDp8DKNDm2gjHJuN5aCBxx/ysK5t
         I2w6fnkoFf7rx4dVBCR9E5GDIlr5/kAA1jIha/X1PkwvHvEdqg1bcIC/wbOg/NlQMRyE
         +zcEyD6XRZRBhG3ZCzeRC5w+SaU3kK36GVqP0ktKA4WR+wjmgX4OOyLBAHZ7CttzmHrD
         DFOshQuaQdknenlCBzi66EmhqGJ23WIdQIpz50rCFSgI3AHJeLb8vbJu443lxz5AhUCu
         xqlMMsCxLWzstDx43NNNRmSHoGYisaO569iwdrRdyEB5RplB/U+RMb9vpyxRmcg6qjrC
         QI9w==
X-Gm-Message-State: APjAAAVLE7XDtoR5Viok0ltaF/fxlwtvVcbfJMt5/9Uv/3lh6hFTuxsR
        sGLzSYuOGT/XH46nLdrkfdF5lg==
X-Google-Smtp-Source: APXvYqzmhTmep4xHmLO/7cx5/kp3S6tQWFg9A9tSuN6B3MX1yJy12Gn1cdhV11E/TzCHAIvNu2PBAQ==
X-Received: by 2002:a65:5c41:: with SMTP id v1mr24606300pgr.404.1552311508420;
        Mon, 11 Mar 2019 06:38:28 -0700 (PDT)
Received: from localhost.localdomain ([183.82.224.199])
        by smtp.gmail.com with ESMTPSA id s79sm9960397pfa.61.2019.03.11.06.38.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 06:38:27 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [DO NOT MERGE] [PATCH v8 14/15] arm64: dts: allwinner: a64-pine64-lts: Enable Feiyang FY07024DI26A30-D DSI panel
Date:   Mon, 11 Mar 2019 19:06:36 +0530
Message-Id: <20190311133637.18334-15-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190311133637.18334-1-jagan@amarulasolutions.com>
References: <20190311133637.18334-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Feiyang FY07024DI26A30-D MIPI_DSI panel is desiged to attach with
DSI connector on pine64 boards, enable the same for pine64 LTS.

DSI panel connected via board DSI port with,
- DC1SW as AVDD supply
- DLDO2 as DVDD supply
- DLDO1 as VCC-DSI supply
- PD24 gpio for reset pin
- PH10 gpio for backlight enable pin

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
 .../dts/allwinner/sun50i-a64-pine64-lts.dts   | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts
index 72d6961dc312..341b1c035604 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts
@@ -5,9 +5,48 @@
  */
 
 #include "sun50i-a64-sopine-baseboard.dts"
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "Pine64 LTS";
 	compatible = "pine64,pine64-lts", "allwinner,sun50i-r18",
 		     "allwinner,sun50i-a64";
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&r_pwm 0 50000 PWM_POLARITY_INVERTED>;
+		brightness-levels = <1 2 4 8 16 32 64 128 512>;
+		default-brightness-level = <8>;
+		enable-gpios = <&pio 7 10 GPIO_ACTIVE_HIGH>; /* LCD-BL-EN: PH10 */
+	};
+};
+
+&de {
+	status = "okay";
+};
+
+&dphy {
+	status = "okay";
+};
+
+&dsi {
+	vcc-dsi-supply = <&reg_dldo1>;		/* VCC3V3-DSI */
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	panel@0 {
+		compatible = "feiyang,fy07024di26a30d";
+		reg = <0>;
+		avdd-supply = <&reg_dc1sw>;	/* VCC-LCD */
+		dvdd-supply = <&reg_dldo2>;	/* VCC-MIPI */
+		reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* LCD-RST: PD24 */
+		backlight = <&backlight>;
+	};
+};
+
+&r_pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&r_pwm_pin>;
+	status = "okay";
 };
-- 
2.18.0.321.gffc6fa0e3

