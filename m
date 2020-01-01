Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A50C2D0DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 23:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A5E20722
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 23:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzPHqwEG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbgAAX6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 18:58:05 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:47042 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbgAAX6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 18:58:05 -0500
Received: by mail-wr1-f66.google.com with SMTP id z7so37755502wrl.13;
        Wed, 01 Jan 2020 15:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1u0XUFsbVMoqQAb5aADvF/uT/DLlkjgZL56Wrrzd6xs=;
        b=ZzPHqwEGodnAsXq1pC4nPntUuQtCki7IYKWkgY1OmDk4Bk+Pgcd+Lkb8TBbUbQsks8
         ycVvml9NeZJwsnnB4As2FplNXmCBw8t8Io1bo896yYejlf+FSjBqSZzZCntlVcV2kZ4b
         1euAh/VM3biC8yFd7wc6RKJWRNeyqqwePDi/+ZnQOvlMzV89yeu/iGBoEh5mW1gBcmNx
         aBQMQC66fWLJYu7hdjomwDCvuUomkNZXDJTyH9V4lW5pEdVvlR6QJ+8ZzmjNnTNdl+3r
         Ltlj0QK/N2r8dIiUcOPLXP7HTsNjJr8MqHZaL+aGKvfghp2x3FusBHkDp1s3h/Fgp9r7
         UcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1u0XUFsbVMoqQAb5aADvF/uT/DLlkjgZL56Wrrzd6xs=;
        b=FE7vSzuQiMJTAZ5oudi0Kfqj269567nURdC0K1J8QwM6jL2J1jWtzcO2BdKlCspkpY
         HJUgSqyaoNQGYi7rp0l3KEJkzakT2kXRyz0mcfHmSZ8lxjMm7/pE0bPLA1MZRvet7oiY
         mHhvjkoOpJXli7NgnKIKEt4pP3owuvT9Xa5UX90667OcLYJmYR8YZJZDNCeMgQ5jRCg6
         nG6I//ABWs2mqo0EOvjGW7LLK9F0btwejjEkcj2L7dOjL1ubl5Xx+lInXnghtw4wLyuu
         SUsx2CFkuh1P6msZ7EFhy+DBtXFxu2eQYmomJiFnNQnWqVtcTnYMZ9Zo+0/8BHDl6tcA
         rK+A==
X-Gm-Message-State: APjAAAWubtPFapigb1Q81U23OVEfe3uaCvn0VND/lN3LORdUYB2YwOAZ
        CZEvMUtRjN8v4/l6W+jV3fk=
X-Google-Smtp-Source: APXvYqxiRHFzYAiWgYVsq87/RMZ71Oj/IUrRfUaAV58MHtG3+PrFH0Wt8A7TZLFutIJjXykaInBPug==
X-Received: by 2002:a5d:4983:: with SMTP id r3mr79769065wrq.134.1577923082584;
        Wed, 01 Jan 2020 15:58:02 -0800 (PST)
Received: from XPS-15-7590.home ([2a01:cb19:16b:9900:21b2:eaec:d723:ee6e])
        by smtp.gmail.com with ESMTPSA id h2sm58869289wrt.45.2020.01.01.15.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 15:58:02 -0800 (PST)
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
Subject: [PATCH V4] ARM: dts: imx7d-pico: Add LCD support
Date:   Thu,  2 Jan 2020 00:57:18 +0100
Message-Id: <20200101235719.21466-1-offougajoris@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 Changes v3 -> v4
	declare pinmux for lcd 
	fix muxing value for pwm

 Changes v2 -> v3 
	rename pintcrl_backlight to pinctrl_pwm4
	sort the nodes alphabetical

 Changes v1 -> v2
 	change "From:" Joris Offouga to Fabio Estevam
	set Joris Offouga signed-off to the last one

 arch/arm/boot/dts/imx7d-pico.dtsi | 90 +++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-pico.dtsi b/arch/arm/boot/dts/imx7d-pico.dtsi
index 6f50ebf31a0a..e57da0d32b98 100644
--- a/arch/arm/boot/dts/imx7d-pico.dtsi
+++ b/arch/arm/boot/dts/imx7d-pico.dtsi
@@ -7,12 +7,42 @@
 #include "imx7d.dtsi"
 
 / {
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm4 0 50000 0>;
+		brightness-levels = <0 36 72 108 144 180 216 255>;
+		default-brightness-level = <6>;
+	};
+
 	/* Will be filled by the bootloader */
 	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0>;
 	};
 
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
+
+	reg_lcd_3v3: regulator-lcd-3v3 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_lcdreg_on>;
+		regulator-name = "lcd-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio1 6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+        };
+
 	reg_wlreg_on: regulator-wlreg_on {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -230,6 +260,18 @@
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
@@ -260,6 +302,8 @@
 };
 
 &pwm4 { /* Backlight */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm4>;
 	status = "okay";
 };
 
@@ -413,6 +457,40 @@
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
@@ -431,6 +509,12 @@
 		>;
 	};
 
+	pinctrl_pwm4: pwm4grp{
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO11__PWM4_OUT	0x7f
+		>;
+	};
+
 	pinctrl_reg_wlreg_on: regregongrp {
 		fsl,pins = <
 			MX7D_PAD_ECSPI1_SCLK__GPIO4_IO16	0x59
@@ -577,6 +661,12 @@
 		>;
 	};
 
+	pinctrl_reg_lcdreg_on: reglcdongrp {
+	fsl,pins = <
+			MX7D_PAD_LPSR_GPIO1_IO06__GPIO1_IO6	0x59
+		>;
+	};
+
 	pinctrl_wdog: wdoggrp {
 		fsl,pins = <
 			MX7D_PAD_LPSR_GPIO1_IO00__WDOG1_WDOG_B	0x74
-- 
2.20.1

