Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA9CC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EDD021773
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKDMGdIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731944AbfDERa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:30:28 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37341 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731634AbfDERaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:30:25 -0400
Received: by mail-pl1-f194.google.com with SMTP id w23so3386631ply.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 10:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nKaup1QFRyqB2UWi1CmJR0ba/ZVD9gxM37jUs9M0u4g=;
        b=AKDMGdIkWiUWq2xQWoq39HeKqXJu9nbmOxfbeHIuutRh3+Py069kFSzu4YvcVCRL8/
         yDA0mOF/Y0kJlSckzjINAvmD+Ucw/BrYqx9mZrw9SUP6S4ajB5WXNWowgji6XjtXedwP
         de2Rz0VqmTAI+doUb4WbLV7QiYl6dhQJ0CE/09LqbNxzARr7IOO0K1ZMVvRipU2gXiU1
         ffzBdwf20UFqSSqu4uIWCVXtBHlchohMJnnoUe9mgAWBNuklremY02tWAYykGKMxMdFh
         JBLA0zJ9EIwkKr4UsqiBbCwoyozmC7km1oaE6snNqLhUWVbSszqLK/2yZ0AHOqD4Etfd
         iiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nKaup1QFRyqB2UWi1CmJR0ba/ZVD9gxM37jUs9M0u4g=;
        b=pM3dO200MM3sCeYwTYrLu58+16iIRqpep3pA7wB2lqYKhRRmldGcp0oF9VhFPdrfO7
         PxXhnQfBJo4UZfW3zAzf2ntns9XPV9T4CMwAIag9SDWa1Nu135jBG09x6JrVIJoVQ0Lj
         4VBIl9EmMphhxu1X6HBDQK+BTcG444reVDk2Ig6+OtJqczE+kcwkC+URCZNE+kENjpN3
         wX1HvJ4TmpuJS4jBAg7CNXEmkwczcqDhKRsCDBCLIYpAHq3i+SWoeQQ7CCPbAnEl3Nrn
         vWa0LEzV2yQiEzaIUj3jaBMnOyYqmWL3Zlum/f5TJ3CGWIUJI57LRMSDNq+/82PCVJ4F
         huYA==
X-Gm-Message-State: APjAAAVwtQNVJuWrH0i84s1Fgz816uwsqJ2J7bxA5sQnkDwzG/b0TbFH
        4CAPkNfpT3+0Hxirv6K/d2x4NWQb
X-Google-Smtp-Source: APXvYqwpkL2Nsulu533mBb1sguvPuHWyexSWARTdXAHI7aO7ARI8AyfPsx7czKFhPwHfcdEaoQnD+A==
X-Received: by 2002:a17:902:9006:: with SMTP id a6mr13817153plp.259.1554485424931;
        Fri, 05 Apr 2019 10:30:24 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id 17sm49206730pfw.65.2019.04.05.10.30.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 10:30:24 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/5] arm64: dts: imx8mq-evk: Enable PCIE0 interface
Date:   Fri,  5 Apr 2019 10:30:04 -0700
Message-Id: <20190405173004.13277-6-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190405173004.13277-1-andrew.smirnov@gmail.com>
References: <20190405173004.13277-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable PCIE0 interface connected to BCM4356 WiFi/Bluetooth module.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 42 ++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index 304c28034ddf..b25f775e8889 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -21,6 +21,12 @@
 		reg = <0x00000000 0x40000000 0 0xc0000000>;
 	};
 
+	pcie0_refclk: pcie0-refclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+
 	reg_usdhc2_vmmc: regulator-vsd-3v3 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_reg_usdhc2>;
@@ -118,6 +124,17 @@
 	status = "okay";
 };
 
+&gpio5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wifi_reset>;
+
+ 	wl-reg-on {
+		gpio-hog;
+		gpios = <29 GPIO_ACTIVE_HIGH>;
+		output-high;
+	};
+};
+
 &i2c1 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
@@ -209,6 +226,18 @@
 	};
 };
 
+&pcie0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie0>;
+	reset-gpio = <&gpio5 28 GPIO_ACTIVE_LOW>;
+	clocks = <&clk IMX8MQ_CLK_PCIE1_ROOT>,
+		 <&clk IMX8MQ_CLK_PCIE1_AUX>,
+		 <&clk IMX8MQ_CLK_PCIE1_PHY>,
+		 <&pcie0_refclk>;
+	clock-names = "pcie", "pcie_aux", "pcie_phy", "pcie_bus";
+	status = "okay";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
@@ -303,6 +332,13 @@
 		>;
 	};
 
+	pinctrl_pcie0: pcie0grp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_I2C4_SCL_PCIE1_CLKREQ_B		0x76
+			MX8MQ_IOMUXC_UART4_RXD_GPIO5_IO28		0x16
+		>;
+	};
+
 	pinctrl_qspi: qspigrp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_NAND_ALE_QSPI_A_SCLK	0x82
@@ -430,4 +466,10 @@
 			MX8MQ_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B		0xc6
 		>;
 	};
+
+	pinctrl_wifi_reset: wifiresetgrp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_UART4_TXD_GPIO5_IO29		0x16
+		>;
+	};
 };
-- 
2.20.1

