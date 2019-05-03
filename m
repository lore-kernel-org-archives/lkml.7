Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3CBC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 05:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04E02081C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 05:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HMBjz4Vx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfECFbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 01:31:49 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46213 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfECFbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 01:31:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id n2so2153882pgg.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 22:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o2KnYtWi5SLktJn2op8zkW2H4ncbiGRKRjw+VMEkUnU=;
        b=HMBjz4VxsRY0GQSmLRIjcd/LPfpLc9xSHhYK+CETWHZGNTwq8RwHcbROkiHwm+6Ghi
         EDy0OWzoxVBy78gHvt5bKH9BZYqXNeXa3khB1qmIh/wgfyptgf1NEurtoc+Y9Ey4uEsW
         HVOWDx7mFk+nhWnVsunMPSj+1aYqaVbeRyUloYlht+SgOoLtw3TSpsDEFOn1rdSh0mRN
         l7RUjBmSJ+Yg04dgR7S12gOyQzgSYKqHCTkXY0rL5w+3tvpAPh9yWZT8QVEJivWTJPee
         N1umIS//rg3Drebciyt+JRxHGe2eUrLIPVHz1ys0xSsXqm2TndPy1/gDWRybFpTVpCfl
         V8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o2KnYtWi5SLktJn2op8zkW2H4ncbiGRKRjw+VMEkUnU=;
        b=Q5vGFtI0R6wWKVSWuwhQZGlTftJ2PHs+B431BiBj2uQRe//eDuJWJJ+hyJKkc2vuzr
         O6ToTQIouGbcOvv5iephvCUCA5kDtvZ1kfJX19He1lou5s3WpVtwvKOfis/P/JDhUtcC
         /TnJnYgPZnoE7aKu0xfU9DjYzqaKts5FvyV1MzoBdOSFL3jTK5iq0/l+SlFxhugIVgph
         418xj+2ese51sKntSdQTa2SrmMkgWVFkeB89HTod+zNO9/dsPsdhnLO0NwUzAuqrCsMg
         JL/JEHmnaxgJX7ap5XDq97BM/jIiO0zRfmDEoFUHw8+9VpalU4FRepFcQopWqSDfwJdN
         5pgQ==
X-Gm-Message-State: APjAAAUV7sP+rUwxz0lnsDTVv2l5xci6WHm33+kqs5jRACQzz2OE59XL
        WmuemSu8VT29nxfV7W1tNF7EzkN5NQ==
X-Google-Smtp-Source: APXvYqxABA9lxDSm2LKatJUanyxVDJb7MJrFiBSyTE90tiesPer2oZLAcR7IjsvsZ4bxW1EYHkaDog==
X-Received: by 2002:a63:6fc1:: with SMTP id k184mr8099288pgc.239.1556861508351;
        Thu, 02 May 2019 22:31:48 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:72c7:3835:31df:f367:f70b:ed86])
        by smtp.gmail.com with ESMTPSA id l15sm1152226pgb.71.2019.05.02.22.31.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 22:31:47 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        robh+dt@kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, loic.pallardy@st.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/3] ARM: dts: stm32mp157: Add missing pinctrl definitions
Date:   Fri,  3 May 2019 11:01:22 +0530
Message-Id: <20190503053123.6828-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190503053123.6828-1-manivannan.sadhasivam@linaro.org>
References: <20190503053123.6828-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing pinctrl definitions for STM32MP157 MPU.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 62 +++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
index 85c417d9983b..0b5bcf6a7c97 100644
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
@@ -258,6 +275,23 @@
 				};
 			};
 
+			i2c2_pins_b: i2c2-2 {
+				pins {
+					pinmux = <STM32_PINMUX('Z', 0, AF3)>, /* I2C2_SCL */
+						 <STM32_PINMUX('H', 5, AF4)>; /* I2C2_SDA */
+					bias-disable;
+					drive-open-drain;
+					slew-rate = <0>;
+				};
+			};
+
+			i2c2_pins_sleep_b: i2c2-3 {
+				pins {
+					pinmux = <STM32_PINMUX('Z', 0, ANALOG)>, /* I2C2_SCL */
+						 <STM32_PINMUX('H', 5, ANALOG)>; /* I2C2_SDA */
+				};
+			};
+
 			i2c5_pins_a: i2c5-0 {
 				pins {
 					pinmux = <STM32_PINMUX('A', 11, AF4)>, /* I2C5_SCL */
@@ -599,6 +633,34 @@
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
-- 
2.17.1

