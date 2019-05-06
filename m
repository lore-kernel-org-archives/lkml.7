Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AFAC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95012206BF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qPWznxSc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfEFKF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 06:05:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35255 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfEFKF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 06:05:57 -0400
Received: by mail-pf1-f196.google.com with SMTP id t87so5920268pfa.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 03:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WKqEBPsoDpTtAdSfNyFLIMHr8olM8ej+c9mYA02GcCA=;
        b=qPWznxScaM12nn3xySR9qMH+ArqYqHs7zb1I5dnOfe5n17nWQ+RDgZ6egeXGBpx8jV
         2PNDhNE9D6uGZM1QTq+XpdQwg/4Ly0RZWY+dFS78niW8M/RGivNwF612wMA5SI11MYCI
         wD1hx9RvUAA6JQJFxW52OuaNp613fGfPv1eG9jI8V4wH2wEEnWlx82lERMz+xBBbveZh
         2Z7QcL4bRjkHZPTGLy3Q9dj/UWI4sqsf6qXrJy888kgl12mR4tOoxbmikstmIxoc8NYx
         Q/0TrWOv32gksWYxshsjOd/iz/Cv9fuavrSKL6/wZjfAu3OBhj791zT4N0g9Yhoi4Zag
         yu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WKqEBPsoDpTtAdSfNyFLIMHr8olM8ej+c9mYA02GcCA=;
        b=kAfRT4uJ+wVNB0Vmm3Fk0/eWAq6iT0qTrcGmYqoMAyINl+WwqzyQREmTiSY7bhN1Af
         ZbRyPFvXzHHHkagr+yU4Y25XkhyyEoWNr5rqkISkoCVoiMko2SZO+xioSRuGZUVICwzs
         ilkukbXptuzpSckMlzlSaYEYn1/ffPnRASeJAHNqVGulzn4Xc+xHE8lES5p6bmkpNDdu
         Q/+sNav9loplrzuWZtIOPw6L3AAwZirCqdmcIEK5JEiu3JvrjRf6r0gf2UzRsOfXOhoP
         v0lVMp/6VVDdPysa0qPz1LXL90F/j2FUYo//n0q/gbjgE3VYv0OSc8OcsIM6jUvO2c8e
         blcw==
X-Gm-Message-State: APjAAAXRuihgWmsk3jjPZI3P/r+m4Zuk018d1PJd0m/aws5lPnDyvPl+
        XgvlbFfhYVZBJhk4Ey2o5OAp
X-Google-Smtp-Source: APXvYqyvyMit260wxAd9y8a+eQMxKEDvoHWY30D7y0aGg8LJY2AhtCFPGP98qESpHbpY5zrFQ53WTA==
X-Received: by 2002:a63:9214:: with SMTP id o20mr30919321pgd.203.1557137156473;
        Mon, 06 May 2019 03:05:56 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:611b:55a4:e119:3b84:2d86:5b07])
        by smtp.gmail.com with ESMTPSA id c137sm16229653pfb.154.2019.05.06.03.05.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 03:05:55 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        robh+dt@kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, loic.pallardy@st.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 2/3] ARM: dts: stm32mp157: Add missing pinctrl definitions
Date:   Mon,  6 May 2019 15:35:33 +0530
Message-Id: <20190506100534.24145-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190506100534.24145-1-manivannan.sadhasivam@linaro.org>
References: <20190506100534.24145-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing pinctrl definitions for STM32MP157 MPU.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 75 +++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
index 85c417d9983b..5efae4b4b37f 100644
--- a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
@@ -241,6 +241,23 @@
 				};
 			};
 
+			i2c1_pins_b: i2c1-2 {
+				pins {
+					pinmux = <STM32_PINMUX('F', 14, AF5)>, /* I2C1_SCL */
+						 <STM32_PINMUX('F', 15, AF5)>; /* I2C1_SDA */
+					bias-disable;
+					drive-open-drain;
+					slew-rate = <0>;
+				};
+			};
+
+			i2c1_pins_sleep_b: i2c1-3 {
+				pins {
+					pinmux = <STM32_PINMUX('F', 14, ANALOG)>, /* I2C1_SCL */
+						 <STM32_PINMUX('F', 15, ANALOG)>; /* I2C1_SDA */
+				};
+			};
+
 			i2c2_pins_a: i2c2-0 {
 				pins {
 					pinmux = <STM32_PINMUX('H', 4, AF4)>, /* I2C2_SCL */
@@ -258,6 +275,21 @@
 				};
 			};
 
+			i2c2_pins_b1: i2c2-2 {
+				pins {
+					pinmux = <STM32_PINMUX('H', 5, AF4)>; /* I2C2_SDA */
+					bias-disable;
+					drive-open-drain;
+					slew-rate = <0>;
+				};
+			};
+
+			i2c2_pins_sleep_b1: i2c2-3 {
+				pins {
+					pinmux = <STM32_PINMUX('H', 5, ANALOG)>; /* I2C2_SDA */
+				};
+			};
+
 			i2c5_pins_a: i2c5-0 {
 				pins {
 					pinmux = <STM32_PINMUX('A', 11, AF4)>, /* I2C5_SCL */
@@ -599,6 +631,34 @@
 					bias-disable;
 				};
 			};
+
+			uart4_pins_b: uart4-1 {
+				pins1 {
+					pinmux = <STM32_PINMUX('D', 1, AF8)>; /* UART4_TX */
+					bias-disable;
+					drive-push-pull;
+					slew-rate = <0>;
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('B', 2, AF8)>; /* UART4_RX */
+					bias-disable;
+				};
+			};
+
+			uart7_pins_a: uart7-0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('E', 8, AF7)>; /* UART4_TX */
+					bias-disable;
+					drive-push-pull;
+					slew-rate = <0>;
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('E', 7, AF7)>, /* UART4_RX */
+						 <STM32_PINMUX('E', 10, AF7)>, /* UART4_CTS */
+						 <STM32_PINMUX('E', 9, AF7)>; /* UART4_RTS */
+					bias-disable;
+				};
+			};
 		};
 
 		pinctrl_z: pin-controller-z@54004000 {
@@ -623,6 +683,21 @@
 				gpio-ranges = <&pinctrl_z 0 400 8>;
 			};
 
+			i2c2_pins_b2: i2c2-0 {
+				pins {
+					pinmux = <STM32_PINMUX('Z', 0, AF3)>; /* I2C2_SCL */
+					bias-disable;
+					drive-open-drain;
+					slew-rate = <0>;
+				};
+			};
+
+			i2c2_pins_sleep_b2: i2c2-1 {
+				pins {
+					pinmux = <STM32_PINMUX('Z', 0, ANALOG)>; /* I2C2_SCL */
+				};
+			};
+
 			i2c4_pins_a: i2c4-0 {
 				pins {
 					pinmux = <STM32_PINMUX('Z', 4, AF6)>, /* I2C4_SCL */
-- 
2.17.1

