Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91004C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 720A821848
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733091AbfHZPiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 11:38:54 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33691 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729289AbfHZPir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 11:38:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id p77so298598wme.0;
        Mon, 26 Aug 2019 08:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oRnNY4JLf7ZTy3fdUTm9bEVVoWS6JMbuHY/wh8kGwgE=;
        b=q4CGZPONOr9Q0DX6Zis1euL7cluDx0OH+bmvlrNwH0wSdPcmZLdUU26nlEwqDCreho
         8Ta7Kxd75Vimmz2DlN8GDB7IDRpRXS7C7PRRqWbU0yu46Nx3x27QXH/WkzAASlnlf0AQ
         cHpRyM/I/hAgGO3DjbyxHrzCuV1iNT07wsYBxqFvwYuL5FdelGMqeQlsXa6c2wyzr682
         iVygu4Weizf7MEV0XGu1/eGD2Ffagj+qfuz1UzoSfURh93fLx429i3zwVFK6KDHppf76
         rThRJxjM+9Ktp8EW4AwLiq/OUFM5JfMFdQZK8gL2zAR7Ticn/zBc70ChMilg28WZoxW5
         noFg==
X-Gm-Message-State: APjAAAUZIDVa5WgS5/AeqbGzf+LfV2s9VMvXNTKKgOiDfU9wEB91cb1f
        OusyjvbB9vyJk/S+WDuPmdJQW8ilTA4=
X-Google-Smtp-Source: APXvYqxyyoXPftbW6GeJwx4yF6wo2uOK6DKbLk1+l/KNCdpLBNfpM76u9knFOkAdArEhuytwOMmhtg==
X-Received: by 2002:a1c:804b:: with SMTP id b72mr22413166wmd.139.1566833925797;
        Mon, 26 Aug 2019 08:38:45 -0700 (PDT)
Received: from 1aq-andre.garage.tyco.com ([77.107.218.170])
        by smtp.gmail.com with ESMTPSA id z8sm11580798wru.13.2019.08.26.08.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 08:38:45 -0700 (PDT)
From:   =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>,
        Ilya Ledvich <ilya@compulab.co.il>,
        Igor Grinberg <grinberg@compulab.co.il>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 03/12] ARM: dts: imx7d: cl-som-imx7: fix i2c2
Date:   Mon, 26 Aug 2019 16:37:51 +0100
Message-Id: <20190826153800.35400-3-git@andred.net>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190826153800.35400-1-git@andred.net>
References: <20190826153800.35400-1-git@andred.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I2C2 is configured incorrectly at the moment:
* update i2c2 to actually work (fix incorrect pinctrl assignments)
* add the i2c2 bus recovery information [1]

[1] Note that scl is being marked as GPIO_OPEN_DRAIN even
though the i.MX pinctrl driver does not support enabling
open drain directly - it is enabled by the fixed pinmux
entry.
So while this flag has no effect in practice, it needs
to be there purely so as to fix the following warning
from gpiolib:
    gpio-6 (scl): enforced open drain please flag it properly in DT/ACPI DSDT/board file
as that is the mode requested by i2c-imx.c

Signed-off-by: André Draszik <git@andred.net>
Cc: Ilya Ledvich <ilya@compulab.co.il>
Cc: Igor Grinberg <grinberg@compulab.co.il>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 26 +++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index e0432a3aa36f..ec82f4738c4f 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -72,8 +72,11 @@
 };
 
 &i2c2 {
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c2>;
+	pinctrl-1 = <&pinctrl_i2c2_recovery>;
+	sda-gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
+	scl-gpios = <&gpio1 6 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
 
 	pmic: pmic@8 {
@@ -236,13 +239,6 @@
 		>;
 	};
 
-	pinctrl_i2c2: i2c2grp {
-		fsl,pins = <
-			MX7D_PAD_I2C2_SDA__I2C2_SDA		0x4000007f
-			MX7D_PAD_I2C2_SCL__I2C2_SCL		0x4000007f
-		>;
-	};
-
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX	0x79
@@ -273,4 +269,18 @@
 			MX7D_PAD_LPSR_GPIO1_IO04__GPIO1_IO4	0x34
 		>;
 	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX7D_PAD_LPSR_GPIO1_IO07__I2C2_SDA	0x4000000f
+			MX7D_PAD_LPSR_GPIO1_IO06__I2C2_SCL	0x4000000f
+		>;
+	};
+
+	pinctrl_i2c2_recovery: i2c2recoverygrp {
+		fsl,pins = <
+			MX7D_PAD_LPSR_GPIO1_IO07__GPIO1_IO7	0x4000007f
+			MX7D_PAD_LPSR_GPIO1_IO06__GPIO1_IO6	0x4000007f
+		>;
+	};
 };
-- 
2.23.0.rc1

