Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D81C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 09:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B3520693
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 09:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwzUTKuO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfFFJGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 05:06:16 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54738 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbfFFJGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 05:06:16 -0400
Received: by mail-wm1-f65.google.com with SMTP id g135so1574744wme.4;
        Thu, 06 Jun 2019 02:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KMQQNwJBTgO7c7d14ttHpXY/GIsLIp6HS6MARbf/Q9A=;
        b=gwzUTKuOOxDM5N4gR9q7gZ8bOecepQqD08QgZ0yVijx0Ju/rYVGf7KjDftPfukMR7t
         QFUBNjMFtH2/QoRb5hYPRakga4cmgfl3W+/4mNT7vNH2BtAYAlSZgpzK3JW9dxM0GT9o
         +g+kPZXyHE9ciXaUcbD1hxywy58F7xskKtQ+sJS6OR/DWBrDi5QgvcqiZsXbWVgYAut/
         mAIeswCbfTqvKMbSlJJ7hk/sjgaOLtQh4oGpZENf/+2jT7Dino9ekpD8QVLzOY7Ltx7u
         Q8i8xAh2UaxtRLCMBnkUqNLiGG9LsB8FzY294nXm4rhtB18/24bMYE+Di1iyoe5FkSFZ
         StlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KMQQNwJBTgO7c7d14ttHpXY/GIsLIp6HS6MARbf/Q9A=;
        b=Euuv5HjJS8EJyC1u6yHtqz6f497jNbbF48LgAHfFcqgXvvkh9Xma1rBZJp04aiaJd8
         F+djuOrCBhsWKEJ46OXtm/2FlLqYTT/TvKEWHrLnmqrvDb9zyEodkx0ycw+pyhHaGnZD
         0crUXUPq7JS+D69N4a/uPZaynoH+fzbXRGIQK1xkrkwmj9m/pvO3A6+2v9AqewMzFdmi
         XtZesnUffQ/j0o+dAeWgG/OY+SD5kxMllEXPdy21ZvRgj3jcCmbKiIdHflpkaN+nqB5a
         H8oPlw3Le1BcD3sDbijx6w88bq4WBz/lcboSodSKv2Zb7uHO2gaFLfhh2IeeSEJmysH4
         SirA==
X-Gm-Message-State: APjAAAW597yEmKKlksn/9wIKHvq06+Z5xIfWZQvBjfvoE+e2RZ4fjL9D
        XOekmHRuN3BZABigpaAVR82wbmXc
X-Google-Smtp-Source: APXvYqyjBaJBEW6wEaIDQT6j7Ydz173felu88CUjXOpFlw3YjbC8P7qVoxTgBEZeOFdEoQ2P/QTknA==
X-Received: by 2002:a1c:f001:: with SMTP id a1mr17028447wmb.130.1559811973647;
        Thu, 06 Jun 2019 02:06:13 -0700 (PDT)
Received: from localhost ([194.105.145.90])
        by smtp.gmail.com with ESMTPSA id k10sm1026662wmj.37.2019.06.06.02.06.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 02:06:13 -0700 (PDT)
From:   Igor Opaniuk <igor.opaniuk@gmail.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, marcel@ziswiler.com,
        marcel.ziswiler@toradex.com, stefan@agner.ch
Subject: [PATCH 1/1] ARM: dts: imx6ull-colibri: enable UHS-I for USDHC1
Date:   Thu,  6 Jun 2019 12:06:12 +0300
Message-Id: <20190606090612.16685-1-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Opaniuk <igor.opaniuk@toradex.com>

Allows to use the SD interface at a higher speed mode if the card
supports it. For this the signaling voltage is switched from 3.3V to
1.8V under the usdhc1's drivers control.

Signed-off-by: Igor Opaniuk <igor.opaniuk@toradex.com>
---
 arch/arm/boot/dts/imx6ul.dtsi                  |  4 ++++
 arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi | 11 +++++++++--
 arch/arm/boot/dts/imx6ull-colibri.dtsi         |  6 ++++++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index fc388b84bf22..91a0ced44e27 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -857,6 +857,8 @@
 					 <&clks IMX6UL_CLK_USDHC1>,
 					 <&clks IMX6UL_CLK_USDHC1>;
 				clock-names = "ipg", "ahb", "per";
+				fsl,tuning-step= <2>;
+				fsl,tuning-start-tap = <20>;
 				bus-width = <4>;
 				status = "disabled";
 			};
@@ -870,6 +872,8 @@
 					 <&clks IMX6UL_CLK_USDHC2>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
+				fsl,tuning-step= <2>;
+				fsl,tuning-start-tap = <20>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi b/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
index 006690ea98c0..7dc7770cf52c 100644
--- a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
@@ -145,13 +145,20 @@
 };
 
 &usdhc1 {
-	pinctrl-names = "default";
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
 	pinctrl-0 = <&pinctrl_usdhc1 &pinctrl_snvs_usdhc1_cd>;
-	no-1-8-v;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz &pinctrl_snvs_usdhc1_cd>;
+	pinctrl-2 = <&pinctrl_usdhc1_100mhz &pinctrl_snvs_usdhc1_cd>;
+	pinctrl-3 = <&pinctrl_usdhc1 &pinctrl_snvs_usdhc1_sleep_cd>;
 	cd-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
 	disable-wp;
 	wakeup-source;
 	keep-power-in-suspend;
 	vmmc-supply = <&reg_3v3>;
+	vqmmc-supply = <&reg_sd1_vmmc>;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx6ull-colibri.dtsi
index 9ad1da159768..d56728f03c35 100644
--- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
@@ -545,6 +545,12 @@
 		>;
 	};
 
+	pinctrl_snvs_usdhc1_sleep_cd: snvs-usdhc1-cd-grp-slp {
+		fsl,pins = <
+			MX6ULL_PAD_SNVS_TAMPER0__GPIO5_IO00	0x0
+		>;
+	};
+
 	pinctrl_snvs_wifi_pdn: snvs-wifi-pdn-grp {
 		fsl,pins = <
 			MX6ULL_PAD_BOOT_MODE1__GPIO5_IO11	0x14
-- 
2.17.1

