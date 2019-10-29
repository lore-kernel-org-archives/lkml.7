Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C452CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 10:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72DCC2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 10:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QabNL/6f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbfJ2KSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 06:18:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41649 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729072AbfJ2KSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 06:18:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id p4so12963041wrm.8;
        Tue, 29 Oct 2019 03:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rdcY2ECIRCmFNWGhaSPQ65IkYHqSS3k5QdhNJoXorB0=;
        b=QabNL/6f25IZI1ng0rsdZtS27z7/5MueUVWzGN0nIXuIGc7XjiRdNe+CZ7rdQu0BQw
         QYP5ODMEiiKECKM4KrTeQuKDyNfnTVx7l8x5WJt2FT85gYVdaWsCQNQlo0jT/gJPG7zE
         l2KqVJq9/tb83oEOEnJXtE39XGB0fnHFRMhTwQlGbfWlyHDHb2VB2jdpTnuFZLk1MTrJ
         GLWWw8Yp711qIj2LDrfJVxf+lfXgdH0QQ2KlqtPEryiIZrcvDzmLjh6hD6wog3iq4l54
         aJGZPv05f/EwEtqOZ9BzhQ+i41OHdG8BImAHF1OCeBH3o0rDm7sASOBG4yMX7jQMPK3h
         5o6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rdcY2ECIRCmFNWGhaSPQ65IkYHqSS3k5QdhNJoXorB0=;
        b=pynskgT+25kZxxPqSohcgFdftxbgdfvQcf4rcZIMv+nr4C9esVk9hJr3nr+G9/bRRJ
         gQxP800eR0EyfX1xEj5CAsg45AtVVF1HPPTZsyXjn08S2Qc2ESm+fULiYEutb8PkWCxs
         EiENANy3n4guJ7qPj8ge8U4Lb/L7OAbd2IBzXtTSYihphhy6Hz760lG5wPlfi4aTJFDp
         AYtlWacWjQSYxPGzkkFZlHBerPrjwl5yHaBvnzLMgatERtwVSrEN8puh9OB+/JDJ/ios
         NnNTOi8lPMWWfeDm57v19v3YSo6M1NtAw1os8JquxkpkXV+nkWJFzHJqme2vpTWE7H7I
         eV/Q==
X-Gm-Message-State: APjAAAXRqsez/fkVjBfVPOitOgjYRE3aYaGTZzDPG90jVLjzsNM2Os0Q
        ym61km5mCJ7hLB40u0y4zWo=
X-Google-Smtp-Source: APXvYqy0rZyubHlTn40+nBhraeCSuQzoCQIiILb+7EsI9wSAEpgxKYZlLZQXE4zZaXWry8fl8nP1tA==
X-Received: by 2002:adf:b1d1:: with SMTP id r17mr19026591wra.201.1572344290868;
        Tue, 29 Oct 2019 03:18:10 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb19:16b:9900:d1e3:f193:b14:d626])
        by smtp.gmail.com with ESMTPSA id i71sm16175411wri.68.2019.10.29.03.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 03:18:10 -0700 (PDT)
From:   Joris Offouga <offougajoris@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Fabio Estevam <festevam@gmail.com>,
        Otavio Salvador <otavio@ossystems.com.br>,
        Joris Offouga <offougajoris@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V3] ARM: dts: imx7d-pico: Add LCD support
Date:   Tue, 29 Oct 2019 11:17:41 +0100
Message-Id: <20191029101742.9100-1-offougajoris@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@gmail.com>

Add support for the VXT VL050-8048NT-C01 panel connected through
the 24 bit parallel LCDIF interface.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
Signed-off-by: Joris Offouga <offougajoris@gmail.com>
---
 Changes v2 -> v3 
	rename pintcrl_backlight to pinctrl_pwm4
	sort the nodes alphabetical

 Changes v1 -> v2
 	change "From:" Joris Offouga to Fabio Estevam
	set Joris Offouga signed-off to the last one

 arch/arm/boot/dts/imx7d-pico.dtsi | 82 +++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-pico.dtsi b/arch/arm/boot/dts/imx7d-pico.dtsi
index 6f50ebf31a0a..9c7c2c45e6aa 100644
--- a/arch/arm/boot/dts/imx7d-pico.dtsi
+++ b/arch/arm/boot/dts/imx7d-pico.dtsi
@@ -7,12 +7,40 @@
 #include "imx7d.dtsi"
 
 / {
+        backlight: backlight {
+                compatible = "pwm-backlight";
+                pwms = <&pwm4 0 50000 0>;
+                brightness-levels = <0 36 72 108 144 180 216 255>;
+                default-brightness-level = <6>;
+        };
+
 	/* Will be filled by the bootloader */
 	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0>;
 	};
 
+        panel {
+                compatible = "vxt,vl050-8048nt-c01";
+                backlight = <&backlight>;
+                power-supply = <&reg_lcd_3v3>;
+
+                port {
+                        panel_in: endpoint {
+                                remote-endpoint = <&display_out>;
+                        };
+                };
+        };
+
+	reg_lcd_3v3: regulator-lcd-3v3 {
+                compatible = "regulator-fixed";
+                regulator-name = "lcd-3v3";
+                regulator-min-microvolt = <3300000>;
+                regulator-max-microvolt = <3300000>;
+                gpio = <&gpio1 6 GPIO_ACTIVE_HIGH>;
+                enable-active-high;
+        };
+
 	reg_wlreg_on: regulator-wlreg_on {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -230,6 +258,18 @@
 	};
 };
 
+&lcdif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lcdif>;
+	status = "okay";
+
+	port {
+		display_out: endpoint {
+			remote-endpoint = <&panel_in>;
+		};
+	};
+};
+
 &sai1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sai1>;
@@ -260,6 +300,8 @@
 };
 
 &pwm4 { /* Backlight */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm4>;
 	status = "okay";
 };
 
@@ -413,6 +455,40 @@
 		>;
 	};
 
+	pinctrl_lcdif: lcdifgrp {
+		fsl,pins = <
+			MX7D_PAD_LCD_DATA00__LCD_DATA0		0x79
+			MX7D_PAD_LCD_DATA01__LCD_DATA1		0x79
+			MX7D_PAD_LCD_DATA02__LCD_DATA2		0x79
+			MX7D_PAD_LCD_DATA03__LCD_DATA3		0x79
+			MX7D_PAD_LCD_DATA04__LCD_DATA4		0x79
+			MX7D_PAD_LCD_DATA05__LCD_DATA5		0x79
+			MX7D_PAD_LCD_DATA06__LCD_DATA6		0x79
+			MX7D_PAD_LCD_DATA07__LCD_DATA7		0x79
+			MX7D_PAD_LCD_DATA08__LCD_DATA8		0x79
+			MX7D_PAD_LCD_DATA09__LCD_DATA9		0x79
+			MX7D_PAD_LCD_DATA10__LCD_DATA10		0x79
+			MX7D_PAD_LCD_DATA11__LCD_DATA11		0x79
+			MX7D_PAD_LCD_DATA12__LCD_DATA12		0x79
+			MX7D_PAD_LCD_DATA13__LCD_DATA13		0x79
+			MX7D_PAD_LCD_DATA14__LCD_DATA14		0x79
+			MX7D_PAD_LCD_DATA15__LCD_DATA15		0x79
+			MX7D_PAD_LCD_DATA16__LCD_DATA16		0x79
+			MX7D_PAD_LCD_DATA17__LCD_DATA17		0x79
+			MX7D_PAD_LCD_DATA18__LCD_DATA18		0x79
+			MX7D_PAD_LCD_DATA19__LCD_DATA19		0x79
+			MX7D_PAD_LCD_DATA20__LCD_DATA20		0x79
+			MX7D_PAD_LCD_DATA21__LCD_DATA21		0x79
+			MX7D_PAD_LCD_DATA22__LCD_DATA22		0x79
+			MX7D_PAD_LCD_DATA23__LCD_DATA23		0x79
+			MX7D_PAD_LCD_CLK__LCD_CLK		0x79
+			MX7D_PAD_LCD_ENABLE__LCD_ENABLE		0x78
+			MX7D_PAD_LCD_VSYNC__LCD_VSYNC		0x78
+			MX7D_PAD_LCD_HSYNC__LCD_HSYNC		0x78
+			MX7D_PAD_LCD_RESET__GPIO3_IO4		0x14
+		>;
+	};
+
 	pinctrl_pwm1: pwm1 {
 		fsl,pins = <
 			MX7D_PAD_GPIO1_IO08__PWM1_OUT   0x7f
@@ -431,6 +507,12 @@
 		>;
 	};
 
+	pinctrl_pwm4: pwm4grp{
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO11__PWM4_OUT	0x0
+		>;
+	};
+
 	pinctrl_reg_wlreg_on: regregongrp {
 		fsl,pins = <
 			MX7D_PAD_ECSPI1_SCLK__GPIO4_IO16	0x59
-- 
2.17.1

