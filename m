Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B744C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46CE22184B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Y6/TPr4d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390847AbfEXKoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 06:44:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34405 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390829AbfEXKoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 06:44:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id h2so1806157pgg.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 03:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I2TZuRmi80hep26TN0kzkhgc7I9J5j9G8LP4vdObAKA=;
        b=Y6/TPr4dAmAWl0yxUzh38/rCmUtxW/omfCTV8dq+RbcPTsSd1HVRkatTyfzFAii57t
         BfV8WUcypTvaCp1oLLG4kiNKbi+JR8xOtbHkYZcjheeMGA/rjVkHysCYMbacTc90AFcy
         Acb53tu8z0vw5pIclEFWVobYO75ZD5L0bTcFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I2TZuRmi80hep26TN0kzkhgc7I9J5j9G8LP4vdObAKA=;
        b=g0lI1g5SfXKGroyWZ2OE1Gs0iuEOnrOP1kWfsmXOj/XBfQT7EQgXbfQY+frbQMg1aj
         ghZI3XEkvv1idQbPC83wx89MUxzqVLwVyYKNm3eUzrOMiohE/pQS/F/eHFJvGwKPxUma
         lylcCluc+1OqsegGU0BU3bshxas44Wg9JOFRnl7ykIwzYKU4uXaiSdOz3hosdTo47WbJ
         st/Ehs0afoPhImpm9i3BlCmC/meQeX5P6/vG8sRbTVvaOLxQCjxc+JHOtX//gKXenHO9
         KY0gzdmRW/3z69plvuqOVzJ+sSz8nhfCLBbGv+Z1gqm9khWxEg63Z7SkwC2W0DTVTzrA
         Ulyw==
X-Gm-Message-State: APjAAAUeKcSx+SxePpPEt4EkJTG3OBRy16UP9cNqC5F+bE3ryCYTR9mo
        F6zFYXk0vn56qGnZdyCzsR+QsA==
X-Google-Smtp-Source: APXvYqxLSs8iO1m115oUyVnrdwFq0cnEzH565uo/USlTwFKMKyOMBAIiY/kx7gcZIlu2j9RZRIsZCw==
X-Received: by 2002:a62:582:: with SMTP id 124mr112332112pff.209.1558694656864;
        Fri, 24 May 2019 03:44:16 -0700 (PDT)
Received: from localhost.localdomain ([183.82.227.60])
        by smtp.gmail.com with ESMTPSA id h11sm2303416pfn.170.2019.05.24.03.44.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 03:44:16 -0700 (PDT)
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
Subject: [DO NOT MERGE] [PATCH v2 6/6] ARM: dts: sun8i: bananapi-m2m: Enable Bananapi S070WV20-CT16 DSI panel
Date:   Fri, 24 May 2019 16:13:17 +0530
Message-Id: <20190524104317.20287-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190524104317.20287-1-jagan@amarulasolutions.com>
References: <20190524104317.20287-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add support for Bananapi S070WV20-CT16 DSI panel to
BPI-M2M board.

Bananapi S070WV20-CT16 is a pure RGB output panel with ICN6211 DSI/RGB
convertor bridge, so enable bridge along with associated panel.

DSI panel connected via board DSI port with,
- DCDC1 as VCC-DSI supply
- PL5 gpio for bridge reset gpio pin
- PB7 gpio for lcd enable gpio pin
- PL4 gpio for backlight enable pin

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts | 86 ++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts b/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
index e1c75f7fa3ca..5f3f9523a03e 100644
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
 
@@ -81,6 +90,18 @@
 		};
 	};
 
+	panel {
+		compatible = "bananapi,s070wv20-ct16", "simple-panel";
+		enable-gpios = <&pio 1 7 GPIO_ACTIVE_HIGH>; /* LCD-PWR-EN: PB7 */
+		backlight = <&backlight>;
+
+		port {
+			panel_out_bridge: endpoint {
+				remote-endpoint = <&bridge_out_panel>;
+			};
+		};
+	};
+
 	reg_vcc5v0: vcc5v0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0";
@@ -122,6 +143,61 @@
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
+	vcc-dsi-supply = <&reg_dcdc1>;		/* VCC-DSI */
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		dsi_out: port@0 {
+			reg = <0>;
+
+			dsi_out_bridge: endpoint {
+				remote-endpoint = <&bridge_out_dsi>;
+			};
+		};
+	};
+
+	bridge@0 {
+		compatible = "chipone,icn6211";
+		reg = <0>;
+		reset-gpios = <&r_pio 0 5 GPIO_ACTIVE_HIGH>; /* LCD-RST: PL5 */
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			bridge_in: port@0 {
+				reg = <0>;
+
+				bridge_out_dsi: endpoint {
+					remote-endpoint = <&dsi_out_bridge>;
+				};
+			};
+
+			bridge_out: port@1 {
+				reg = <1>;
+
+				bridge_out_panel: endpoint {
+					remote-endpoint = <&panel_out_bridge>;
+				};
+			};
+		};
+	};
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -157,6 +233,12 @@
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
 
@@ -269,6 +351,10 @@
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

