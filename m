Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557ADC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 246532186A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="BTB4zVgu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbfCONJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 09:09:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42549 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729143AbfCONJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 09:09:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id b2so6426721pgl.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 06:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fgjvITMSu4P9dEIyxGHg+50sb9yJF4/343qaf5B+0M4=;
        b=BTB4zVgub30H5MtT6pq8TsVFBePGZEx5YhRKZGDqnCan9mHIf4Nf9ntbuNLWrMnCNP
         UZXuk3m3T73k7UuXMkeGkEPq7xUGm5i6aswJRXmBp5prmiBa3VgnDq/pUVd5m8wIKckT
         30fG/0/QtZ1VcM3c6j6xmBgz8ZDGLqNvODj0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fgjvITMSu4P9dEIyxGHg+50sb9yJF4/343qaf5B+0M4=;
        b=EBK7nxDt+K7rvJ5messMEq/tkRiDGZfGNWsm2c7nB98vTbv9pLFNxG+Xk2YwVX2yvy
         ooFAX/ogC8mZS42MqfuidXaT5KbX0E5lgdiOS5mw0xgSXFsaHK4aSQ7G5Mu+xkFA9cuo
         YcbQ7cSFYAXsaFpRUA/2iMtoHc2GmHoWD7adoPyO69jQCOok5nOI1LmCwkjWeG/3IIGx
         2rw95Byr3A5JFYSElOW9bMyjA+sLtc6lhSAWHkZKYoHYwozkODjLErdVO453LAOYuzXG
         mG83r5+F1m7oYCcPmhXQPOXvjs5sMwBFy+3QZbAo0JVQrhgNK+IfNRmWdOXCklFdbKzy
         /LrQ==
X-Gm-Message-State: APjAAAXTCgKJp/xLMG4/0g+N4W5juXey+rlYZ6CZ234eWKlCS4lRc388
        nYF59pggAW0uayoh1FPP56w+iw==
X-Google-Smtp-Source: APXvYqxVc/fKWezAMXctlfIKXy+8b2DkfDBT/ADV0Gwx2+8aTtr1GEODEGakDg6K+Luj6lxZ1BZEmA==
X-Received: by 2002:aa7:9102:: with SMTP id 2mr3913621pfh.179.1552655346407;
        Fri, 15 Mar 2019 06:09:06 -0700 (PDT)
Received: from localhost.localdomain ([183.82.230.185])
        by smtp.gmail.com with ESMTPSA id e2sm854008pfa.64.2019.03.15.06.09.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 06:09:05 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 6/6] arm64: dts: allwinner: bananapi-m64: Enable S070WV20-CT16 DSI panel
Date:   Fri, 15 Mar 2019 18:38:25 +0530
Message-Id: <20190315130825.9005-7-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190315130825.9005-1-jagan@amarulasolutions.com>
References: <20190315130825.9005-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add support for Bananapi S070WV20-CT16 DSI panel to
BPI-M64 board.

Bananapi S070WV20-CT16 is a pure RGB output panel with ICN6211 DSI/RGB
convertor bridge, so enable bridge along with associated panel.

DSI panel connected via board DSI port with,
- DLDO1 as VCC-DSI supply
- PD6 gpio for reset pin
- PD5 gpio for backlight enable pin
- PD7 gpio for backlight vdd supply

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
index 7793ebb5d2b8..f31083aa4521 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
@@ -45,6 +45,7 @@
 #include "sun50i-a64.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "BananaPi-M64";
@@ -56,6 +57,15 @@
 		serial1 = &uart1;
 	};
 
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&r_pwm 0 50000 PWM_POLARITY_INVERTED>;
+		brightness-levels = <1 2 4 8 16 32 64 128 512>;
+		default-brightness-level = <2>;
+		enable-gpios = <&pio 3 5 GPIO_ACTIVE_HIGH>; /* LCD-BL-EN: PD5 */
+		power-supply = <&reg_vdd_backlight>;
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
@@ -91,6 +101,26 @@
 		};
 	};
 
+	panel-connector {
+		compatible = "bananapi,s070wv20-ct16", "simple-panel";
+
+		port {
+			backlight = <&backlight>;
+			panel_ep: endpoint {
+				remote-endpoint = <&bridge_out_ep>;
+			};
+		};
+	};
+
+	reg_vdd_backlight: vdd-backlight {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd-backlight";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pio 3 7 GPIO_ACTIVE_HIGH>; /* LCD-PWR-EN: PD7 */
+		enable-active-high;
+	};
+
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
@@ -116,6 +146,33 @@
 	status = "okay";
 };
 
+&dphy {
+	status = "okay";
+};
+
+&dsi {
+	vcc-dsi-supply = <&reg_dldo1>;		/* VCC3V3-DSI */
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	bridge@0 {
+		compatible = "bananapi,icn6211", "chipone, icn6211";
+		reg = <0>;
+		reset-gpios = <&pio 3 6 GPIO_ACTIVE_HIGH>; /* LCD-RST: PD6 */
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@1 {
+			reg = <1>;
+
+			bridge_out_ep: endpoint {
+				remote-endpoint = <&panel_ep>;
+			};
+		};
+	};
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -208,6 +265,12 @@
 	status = "okay";
 };
 
+&r_pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&r_pwm_pin>;
+	status = "okay";
+};
+
 &r_rsb {
 	status = "okay";
 
-- 
2.18.0.321.gffc6fa0e3

