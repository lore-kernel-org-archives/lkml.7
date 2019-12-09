Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24607C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB43C2073D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmryHUei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfLIQun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 11:50:43 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:36836 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfLIQum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 11:50:42 -0500
Received: by mail-pj1-f68.google.com with SMTP id n96so6148259pjc.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 08:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=etbkgpiNShv5Cytt/jCJtMGgQu7+VxY2ZKOwE9HC8iY=;
        b=LmryHUei0D0PMsmqoiA0cnhC0s0Bh7PIls560OGF8S/keUhUPXJSerLgvFf94h5KRi
         26NENu4/vOKlQNTDBVegnYwlNEwfIXt6hjrtG0cOpK1wfhWPlAclt9HQgUGVLropdX4M
         HEep4fG7UKTrBObaJQYF5/i1FOvfUrLfHpPlYjvC3/PJ+80WeQDedUZJW2WCRTaOrhFv
         qguE6ISXHo8AkO7T4dv/L45JXaNokn9XKz52I447nWsMMG1eF9E48ZLAaleq1sQcF6Qm
         We+O6T29Ak3QL+NoITcxy3e7nrP8VomYNxqM6DL993gLTGXRHRwuQEs0RCXWgiZMnn7W
         Qh2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=etbkgpiNShv5Cytt/jCJtMGgQu7+VxY2ZKOwE9HC8iY=;
        b=txaO6AuEO20yDGJHOJJwcBROWAEPMcgFi0M7VMrcoCXG0PHTbLA/bhfRUtN4bLrC/K
         2uxGPr0i1wBBqMRB3UTRZM5RrBn6NA638xk7uPMKd/X9xbklwHhSNrjY2Sc+AneFpVL4
         9fEe1b2zgsqBfuffzUSuR2N0i2Eu0wEa9Eq2r/amCG1zUGoD2/4GaxEnHacQhwqBuY0d
         iveyi2oEDtw+B7zcAFEyfGwsSwLtmcubBTp6h1gTzXjVfcalERnd4+43KMPnbVIc/2u6
         +p658e7bqjVSCwJHdO90uNwqF6JHf90GjrwMuRIbMR2mJAKQ/onLfRbtwI434ryEhJf9
         71zg==
X-Gm-Message-State: APjAAAWxyJAZW+mCAqhuMoaIQFcaOm+LpdQIMaPSXLNYizpTA26y9xU/
        xiScVRLtQ4hASx36MQeYt3o=
X-Google-Smtp-Source: APXvYqyvDySvpOZ47zirv38B2yVsexxZWO+tz0/xVInQrwd4MezOaWncApQWqSq5tWn8FXzGRvQdJA==
X-Received: by 2002:a17:90a:5d04:: with SMTP id s4mr7621515pji.120.1575910241646;
        Mon, 09 Dec 2019 08:50:41 -0800 (PST)
Received: from localhost.localdomain (c-67-165-113-11.hsd1.wa.comcast.net. [67.165.113.11])
        by smtp.gmail.com with ESMTPSA id c19sm18299294pfc.144.2019.12.09.08.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 08:50:40 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] ARM: dts: imx6: rdu2: Add node for UCS1002 USB charger chip
Date:   Mon,  9 Dec 2019 08:50:16 -0800
Message-Id: <20191209165018.21794-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add node for UCS1002 USB charger chip connected to front panel USB and
replace "regulator-fixed" previously used to control VBUS.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---

Changes since [v2]:

    - Rebased on recent linux-next (12/05/2019)

Changes since [v1]

    - Added GPIO hog configuration to put UCS1002 into correct mode
      even before its driver takes over. The code for that is taken
      from similar patch from Lucas, so I added his Signed-off-by as
      well.

[v2] https://lore.kernel.org/lkml/20190529071843.24767-1-andrew.smirnov@gmail.com/
[v1] lore.kernel.org/r/20190522071227.31488-1-andrew.smirnov@gmail.com

 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 77 +++++++++++++++++++------
 1 file changed, 59 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
index ee364215fb9d..7531f0595bd1 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -60,18 +60,6 @@
 		regulator-always-on;
 	};
 
-	reg_5p0v_user_usb: regulator-5p0v-user-usb {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_user_usb>;
-		vin-supply = <&reg_5p0v_main>;
-		regulator-name = "5V_USER_USB";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		gpio = <&gpio3 22 GPIO_ACTIVE_LOW>;
-		startup-delay-us = <1000>;
-	};
-
 	reg_3p3v_pmic: regulator-3p3v-pmic {
 		compatible = "regulator-fixed";
 		vin-supply = <&reg_12p0v>;
@@ -406,6 +394,39 @@
 	};
 };
 
+&gpio3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio3_hog>;
+
+	usb-emulation {
+		gpio-hog;
+		gpios = <19 GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "usb-emulation";
+	};
+
+	usb-mode1 {
+		gpio-hog;
+		gpios = <20 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "usb-mode1";
+	};
+
+	usb-pwr {
+		gpio-hog;
+		gpios = <22 GPIO_ACTIVE_LOW>;
+		output-high;
+		line-name = "usb-pwr-ctrl-en-n";
+	};
+
+	usb-mode2 {
+		gpio-hog;
+		gpios = <23 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "usb-mode2";
+	};
+};
+
 &i2c1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c1>;
@@ -675,6 +696,16 @@
 		status = "disabled";
 	};
 
+	reg_5p0v_user_usb: charger@32 {
+		compatible = "microchip,ucs1002";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ucs1002_pins>;
+		reg = <0x32>;
+		interrupts-extended = <&gpio5 2 IRQ_TYPE_EDGE_BOTH>,
+				      <&gpio3 21 IRQ_TYPE_EDGE_BOTH>;
+		interrupt-names = "a_det", "alert";
+	};
+
 	hpa1: amp@60 {
 		compatible = "ti,tpa6130a2";
 		pinctrl-names = "default";
@@ -1019,6 +1050,15 @@
 		>;
 	};
 
+	pinctrl_gpio3_hog: gpio3hoggrp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D19__GPIO3_IO19		0x1b0b0
+			MX6QDL_PAD_EIM_D20__GPIO3_IO20		0x1b0b0
+			MX6QDL_PAD_EIM_D22__GPIO3_IO22		0x1b0b0
+			MX6QDL_PAD_EIM_D23__GPIO3_IO23		0x1b0b0
+		>;
+	};
+
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
 			MX6QDL_PAD_CSI0_DAT8__I2C1_SDA		0x4001b8b1
@@ -1066,12 +1106,6 @@
 		>;
 	};
 
-	pinctrl_reg_user_usb: usbotggrp {
-		fsl,pins = <
-			MX6QDL_PAD_EIM_D22__GPIO3_IO22		0x40000038
-		>;
-	};
-
 	pinctrl_rmii_phy_irq: phygrp {
 		fsl,pins = <
 			MX6QDL_PAD_EIM_D30__GPIO3_IO30		0x40010000
@@ -1131,6 +1165,13 @@
 		>;
 	};
 
+	pinctrl_ucs1002_pins: ucs1002grp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_A25__GPIO5_IO02  	0x1b0b0
+			MX6QDL_PAD_EIM_D21__GPIO3_IO21  	0x1b0b0
+		>;
+	};
+
 	pinctrl_usdhc2: usdhc2grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD2_CMD__SD2_CMD		0x10059
-- 
2.21.0

