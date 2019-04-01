Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B896CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 02:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8825F20872
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 02:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uxxkJGz9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731782AbfDACYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 22:24:44 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33514 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731692AbfDACYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 22:24:36 -0400
Received: by mail-pl1-f195.google.com with SMTP id t16so1810978plo.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 19:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xHMP4rCUzzpWtWj8JgBXHEt54oo0bcr1bpWR5iBfCNs=;
        b=uxxkJGz9CDZucQMOITlIEG57bISuU86xctje5mNRKeCVX/WazKJvo0KzpO4aejBsY/
         Ec0eBzgHnMFCnecJTIJD71uJE9ukWcZ6+sVaFvehGIAYo9nVqxWKnjhbpNjwzmEL3lxg
         m+ITD5Swc0MYvPepN0PVdulaDZ8KzDK11+vTL22rwBETC2eZUpkU2ur0h98vSAsE/sRy
         1fHXdYkyae1hJWq0wmcI0V8Hq394drgFFBmD/04qMSEM2NwdPjNgdKqPwGEpBieEz48f
         Lq/2EL3DRR+xPdFromAAmcLxx0iBi1BOPfZBNYu+ZtmQLmGvmwtG3aDGppMHFoXTWgGu
         Rleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xHMP4rCUzzpWtWj8JgBXHEt54oo0bcr1bpWR5iBfCNs=;
        b=jc+7B9IwXY+kafKe3R6vwl8zol/zpAx17DywcqSGMS0itfk1kf9PU7F7nk0pwM/4i6
         cwNt+2jHR5C2xPDrJo5//QB5bjAht0XwmVAgC8wKuu5oNtdMGTtY4zSiF72dsruqqZ78
         69HyCYR4pDYbamYAtFCNnY1Jz8c5TCD6hm0bN5CMOzJBqnpZrLlrDj1YCkxOzu1tRTBM
         ADTDR1zNatsUHKO3fEq3+zyy0v4Git+3OEduzDfbuvaaa1Mwe4A424THt8/sqFEZ3f1c
         t+2hek/LHu6p/30KXU+4S3o68A/zPukvwPGirmSJUseI039xj/Tdtf70BNPZqAClnSoF
         xUUA==
X-Gm-Message-State: APjAAAUIC90AFS/omGHlvxPPIAMWGr0GY3yPXwSzZl0XSPYGPmLfpQNk
        BbrojslTDPnAMZn9f0IJESo=
X-Google-Smtp-Source: APXvYqwHoHPD7zL1rJEgRRBMcshKlLSyU/ZyTEiHg3AD8HRWNwUgZxXzLUZVBm17mx+D6c+aryvZ1Q==
X-Received: by 2002:a17:902:bd82:: with SMTP id q2mr32025583pls.201.1554085475460;
        Sun, 31 Mar 2019 19:24:35 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id n82sm13597289pfi.63.2019.03.31.19.24.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 19:24:34 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/5] arm64: dts: imx8mq-evk: Enable PCIE0 interface
Date:   Sun, 31 Mar 2019 19:24:13 -0700
Message-Id: <20190401022413.6682-6-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401022413.6682-1-andrew.smirnov@gmail.com>
References: <20190401022413.6682-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable PCIE0 interface connected to BCM4356 WiFi/Bluetooth module.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
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

