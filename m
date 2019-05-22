Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1249C072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 07:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA8621479
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 07:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DytbhWq6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbfEVHMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 03:12:54 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:39257 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfEVHMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 03:12:54 -0400
Received: by mail-pf1-f171.google.com with SMTP id z26so829270pfg.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 00:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y+ikAHe5H6cJDxQps6RFExVZnEaf5yDl3L1XyAXd3r8=;
        b=DytbhWq6ySi9MXbobO4HIqFBhETJGWOMaCVPI4FKxn3XahvFeqhGvSWvU2RmWBl5Jj
         n0d+uXAP9T2U9FY09AKJ7zamTwGoUUqZDqFoNyyfBItjEqRlbAd3H+oDj1WK5QIfHOjY
         y2AjoN581iXYsLVwkusI6KmL3cm6oLyz0inTHPtfAX4qCwrZYaAQw0Nyjhti6TdCE9PR
         5MbHUFx9uvDz3mdoOTEMaKn9BPfwpRvJzT668QMimRMg2HOwweNMVA7T0XgxK9qfEXf+
         nqYga7skasjjPKIpenrl9wkwKK75E7YqaYlmb4Tdr5jCjwPVIBL/6uMwDWeaORMwgdGF
         Wuxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y+ikAHe5H6cJDxQps6RFExVZnEaf5yDl3L1XyAXd3r8=;
        b=h2i9lz9UyHfxVeGuOQctkH77Yl98L2BxFdnWwVTbmDy0pYzrbkVqOATnbSvM896HDW
         /dAmEaSYYv/KilRsIx6I8p3dcKLHCWjh7lsvREa+QWQswOOFEByBhQ5WlON4tjqHc1Dl
         WyV6voQjYUfeH6V9bKlzIFi+tSrUIW8Z+gOHi1nGyXq6t2K4N3s8xvBC+dqJgaa4Gmbn
         8HFN5vBmIROpQv0kCJQvBK5OeIXXpwq4yhv23MXd3BKZHl7Ra5BuMAkQ28LH85v4p9DH
         M3Huyx4Zf0ExiCEZT3wfG46nutkn5HUUL5e1rsQDJdns2l020PZ+P88cfUaR+BGMO/nj
         Jmjw==
X-Gm-Message-State: APjAAAXG7zpuwaetX2Z1bbMYEfBJQgxtyn3neXkSagGakUEt0B3d/p26
        yXTHsijRD0Uwct4WUk6PkfQ=
X-Google-Smtp-Source: APXvYqwFQRFV81l6ZNeI96JS1jb5yClap1R4nZqkP37ckSpuR9djAaEF6jzS4FbQdZ2vuTfHVCcfMw==
X-Received: by 2002:a62:3381:: with SMTP id z123mr95435958pfz.42.1558509172976;
        Wed, 22 May 2019 00:12:52 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id n127sm22750178pga.57.2019.05.22.00.12.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 00:12:52 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ARM: dts: imx6: rdu2: Add node for UCS1002 USB charger chip
Date:   Wed, 22 May 2019 00:12:25 -0700
Message-Id: <20190522071227.31488-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add node for UCS1002 USB charger chip connected to front panel USB and
replace "regulator-fixed" previously used to control VBUS.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 35 ++++++++++++-------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
index 93be00a60c88..977d923e35df 100644
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
@@ -590,6 +578,16 @@
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
@@ -982,12 +980,6 @@
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
@@ -1047,6 +1039,13 @@
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

