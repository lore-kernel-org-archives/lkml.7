Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0580CA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E1521872
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rs9/yPIg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408213AbfJYIWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:22:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45121 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405453AbfJYIWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:22:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id q13so1214698wrs.12;
        Fri, 25 Oct 2019 01:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=37i8eBc6ddm1zMQ4dydB4CeeK+rpB2qpcoxItFvqsEA=;
        b=rs9/yPIgMdAo4Nu8/mqRSvxA7++X2qklkRzyT2KbW1kjkWFu2RiJcjm+fwIeQ327+K
         Y5q+kO3LzN+1Qw8+VZvGC8FjZEvVlaRcR24FMjawdPs2fuI4lplXuJmpddn09fOdvNEK
         4KwALV56wZtKBQ3WoXm5jdn3X1GbPMYJi2sNs7H3qtgmsxDDwoeiUVuHGG6WxDfI1etJ
         /b4bJGjeAjomPW/ZD4YuUlDq5/S1fCfZp4TcbjjWJfEbJQyNsEB+NQ8DPhf2U0ObLWsZ
         bZT4I6Ue8DOcyfAn2D3pJKNG7Jf7oZxNV03+cfxYdq2K9w9WliF1vGGC2ugpwIga/QDm
         3XJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=37i8eBc6ddm1zMQ4dydB4CeeK+rpB2qpcoxItFvqsEA=;
        b=ofg3qODK+LImVNSMtxrE54f+ICMfQXsix1gr15hfWFg/FG2pct7LjvwOkz/uFVlHZl
         orfJ74NXWpj2lATM7j/rcPa0ZImU402skFbmVNmUEs5/Ko+Gm2lFl6g0KzWHqHTik+e2
         JZBmImGviPuMgMikQ4IIl7n/kgLx4gKNxVbji2T9mGABmBxjJgPZSBjLPhXNFoZmNCIc
         RRuXd+uOUBOGXMzclLB80YOYIuhZqtx6Lsugj7Gt7sfwoG6F9O3RxLMRXalDdTqWx7iS
         1JsiXeQgVgVArz5pBpqZf5t+T2zZINGbY3754yg+L5/3Cu8Wpfzl1Ed+EFuGWXyr5Rq5
         9VyA==
X-Gm-Message-State: APjAAAWVbKyEU+Vsv2QmPzs3dEpCKbb84Vu7mSB3BCgemmm5RtUYoohE
        lX02gov/0GOKTWUVtA0GZx0=
X-Google-Smtp-Source: APXvYqzWPwJdsAHo+0PorxM0hXL1AYbzSE6ZX/QNMDBPYdfnhwQCX5Q0wx3r+TL7nAiggYVTQ7Dq3g==
X-Received: by 2002:a5d:4885:: with SMTP id g5mr1872097wrq.219.1571991770492;
        Fri, 25 Oct 2019 01:22:50 -0700 (PDT)
Received: from furher.auvence.co ([92.103.174.138])
        by smtp.gmail.com with ESMTPSA id x8sm1612194wrr.43.2019.10.25.01.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 01:22:49 -0700 (PDT)
From:   Joris Offouga <offougajoris@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Joris Offouga <offougajoris@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Otavio Salvador <otavio@ossystems.com.br>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: dts: imx7d-pico: Add LCD support
Date:   Fri, 25 Oct 2019 10:22:38 +0200
Message-Id: <20191025082247.3371-1-offougajoris@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the VXT VL050-8048NT-C01 panel connected through
the 24 bit parallel LCDIF interface.

Signed-off-by: Joris Offouga <offougajoris@gmail.com>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---
 arch/arm/boot/dts/imx7d-pico.dtsi | 84 +++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-pico.dtsi b/arch/arm/boot/dts/imx7d-pico.dtsi
index 6f50ebf31a0a..9042b1e6f1db 100644
--- a/arch/arm/boot/dts/imx7d-pico.dtsi
+++ b/arch/arm/boot/dts/imx7d-pico.dtsi
@@ -69,6 +69,37 @@
 		clocks = <&clks IMX7D_CLKO2_ROOT_DIV>;
 		clock-names = "ext_clock";
 	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_backlight>;
+		pwms = <&pwm4 0 50000 0>;
+		brightness-levels = <0 36 72 108 144 180 216 255>;
+		default-brightness-level = <6>;
+		status = "okay";
+	};
+
+	reg_lcd_3v3: regulator-lcd-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "lcd-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio1 6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	panel {
+		compatible = "vxt,vl050-8048nt-c01";
+		backlight = <&backlight>;
+		power-supply = <&reg_lcd_3v3>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&display_out>;
+			};
+		};
+	};
 };
 
 &clks {
@@ -230,6 +261,18 @@
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
@@ -349,6 +392,13 @@
 };
 
 &iomuxc {
+
+	pinctrl_backlight: backlight {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO11__PWM4_OUT		0x0
+		>;
+	};
+
 	pinctrl_ecspi3: ecspi3grp {
 		fsl,pins = <
 			MX7D_PAD_I2C1_SCL__ECSPI3_MISO		0x2
@@ -413,6 +463,40 @@
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
-- 
2.17.1

