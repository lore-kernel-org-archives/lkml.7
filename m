Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC65DCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 05:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA6020830
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 05:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TQTYIIQL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfJUFOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 01:14:06 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45029 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbfJUFNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 01:13:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id e10so7002681pgd.11
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 22:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=neUH3MpZ6PzcWK0pI8MqCIfgDTXdx3TfQP/vFsVjZuw=;
        b=TQTYIIQLHyyoWDFFQE3HbGxwyCsLxnLfL6DqshMYHmbiSg575HP2B2jVQOaiIh2UtJ
         ReLVblQ/fsUHV7TqldzwD5rFZD8hq2prUNnoxWDB+6M143NZHEcgppbzszDRWLS28Kt/
         eQjHkYoI2DVEeczj51q9cjWlj6tw1xfL+YeuSqu6eAe33uA5GAEdu171xBGHv91r3m8e
         BHn6vbAY7mFi5nDeQWlpSimh0oK5bbcu/FYBh+oTu56MbvnJYMGqEKSJJHaEhp9qew6m
         EMMKcZgHp1bvd3yyhB/o2sMBJgsZfQltuzyTf/XplUBVFDlqUF5SLVsePC7CbOT4ryrb
         YOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=neUH3MpZ6PzcWK0pI8MqCIfgDTXdx3TfQP/vFsVjZuw=;
        b=G4PKx1O5F2mUqxyMwN0DUm5MXl8h8Ggk/YwyjLVx5+8hnnv0F8pEAv2XX+pLezpuOm
         XoEdNmyq7sCKYK5IdnDOR3U4L32pRGzsltVcZacHo1/ZS52x51QMRsnBAzLkD0vdXaax
         /UIUZoJhvBbGsoX2OGJN38J0OOTKEoHy4ed+tc0W0Ik2Erjj29kiwiYwBuBca0NQ9ZFI
         Ib7isQQOcGi7OtAVgm4UdfKnxs5Ogfgt4XaYZAQj/en08/3UfnrIDWWX01ISv8l2030b
         zwmSdhgxXnET3OgTRfUuK359cQNrO65YPqKqrdfTChO50rNZ/5J/yw85DDshl+s8cmK7
         BAyw==
X-Gm-Message-State: APjAAAVdcEchBa6cTaP6iK5T20CWw5c2SZ+aCKlQvFB0IfMyOOZPMXAq
        LCQc/KH3LTpA01+/3qVySq29zw==
X-Google-Smtp-Source: APXvYqxhL5IxCG/H/X8ULwVjGleXRGgoJK4b4LyFFbqE/lSNwphVUv7K4sFiE5tTX7VdAKNbpYDMFg==
X-Received: by 2002:a65:49ca:: with SMTP id t10mr4612088pgs.310.1571634815362;
        Sun, 20 Oct 2019 22:13:35 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h68sm15716862pfb.149.2019.10.20.22.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2019 22:13:34 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] arm64: dts: qcom: db820c: Remove pin specific files
Date:   Sun, 20 Oct 2019 22:13:18 -0700
Message-Id: <20191021051322.297560-8-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191021051322.297560-1-bjorn.andersson@linaro.org>
References: <20191021051322.297560-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than scattering pinctrl definitions in various files, merge the
nodes into db820c.dtsi to make it easier to navigate.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../boot/dts/qcom/apq8096-db820c-pins.dtsi    | 109 ----------
 .../dts/qcom/apq8096-db820c-pmic-pins.dtsi    |  92 ---------
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi  | 192 +++++++++++++++++-
 3 files changed, 190 insertions(+), 203 deletions(-)
 delete mode 100644 arch/arm64/boot/dts/qcom/apq8096-db820c-pins.dtsi
 delete mode 100644 arch/arm64/boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c-pins.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c-pins.dtsi
deleted file mode 100644
index a5cc80d6e82f..000000000000
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c-pins.dtsi
+++ /dev/null
@@ -1,109 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (c) 2013-2016, The Linux Foundation. All rights reserved.
- */
-&msmgpio {
-	sdc2_cd_on: sdc2_cd_on {
-		mux {
-			pins = "gpio38";
-			function = "gpio";
-		};
-
-		config {
-			pins = "gpio38";
-			bias-pull-up;		/* pull up */
-			drive-strength = <16>;	/* 16 MA */
-		};
-	};
-
-	sdc2_cd_off: sdc2_cd_off {
-		mux {
-			pins = "gpio38";
-			function = "gpio";
-		};
-
-		config {
-			pins = "gpio38";
-			bias-pull-up;		/* pull up */
-			drive-strength = <2>;	/* 2 MA */
-		};
-	};
-
-	blsp1_uart1_default: blsp1_uart1_default {
-		mux {
-			pins = "gpio41", "gpio42", "gpio43", "gpio44";
-			function = "blsp_uart2";
-		};
-
-		config {
-			pins = "gpio41", "gpio42", "gpio43", "gpio44";
-			drive-strength = <16>;
-			bias-disable;
-		};
-	};
-
-	blsp1_uart1_sleep: blsp1_uart1_sleep {
-		mux {
-			pins = "gpio41", "gpio42", "gpio43", "gpio44";
-			function = "gpio";
-		};
-
-		config {
-			pins = "gpio41", "gpio42", "gpio43", "gpio44";
-			drive-strength = <2>;
-			bias-disable;
-		};
-	};
-
-	hdmi_hpd_active: hdmi_hpd_active {
-		mux {
-			pins = "gpio34";
-			function = "hdmi_hot";
-		};
-
-		config {
-			pins = "gpio34";
-			bias-pull-down;
-			drive-strength = <16>;
-		};
-	};
-
-	hdmi_hpd_suspend: hdmi_hpd_suspend {
-		mux {
-			pins = "gpio34";
-			function = "hdmi_hot";
-		};
-
-		config {
-			pins = "gpio34";
-			bias-pull-down;
-			drive-strength = <2>;
-		};
-	};
-
-	hdmi_ddc_active: hdmi_ddc_active {
-		mux {
-			pins = "gpio32", "gpio33";
-			function = "hdmi_ddc";
-		};
-
-		config {
-			pins = "gpio32", "gpio33";
-			drive-strength = <2>;
-			bias-pull-up;
-		};
-	};
-
-	hdmi_ddc_suspend: hdmi_ddc_suspend {
-		mux {
-			pins = "gpio32", "gpio33";
-			function = "hdmi_ddc";
-		};
-
-		config {
-			pins = "gpio32", "gpio33";
-			drive-strength = <2>;
-			bias-pull-down;
-		};
-	};
-};
diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi
deleted file mode 100644
index 31a3e3311ad5..000000000000
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi
+++ /dev/null
@@ -1,92 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
-&pm8994_gpios {
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&ls_exp_gpio_f &bt_en_gpios>;
-
-	ls_exp_gpio_f: pm8994_gpio5 {
-		pinconf {
-			pins = "gpio5";
-			output-low;
-			power-source = <2>; // PM8994_GPIO_S4, 1.8V
-		};
-	};
-
-	bt_en_gpios: bt_en_gpios {
-		pinconf {
-			pins = "gpio19";
-			function = PMIC_GPIO_FUNC_NORMAL;
-			output-low;
-			power-source = <PM8994_GPIO_S4>; // 1.8V
-			qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
-			bias-pull-down;
-		};
-	};
-
-	wlan_en_gpios: wlan_en_gpios {
-		pinconf {
-			pins = "gpio8";
-			function = PMIC_GPIO_FUNC_NORMAL;
-			output-low;
-			power-source = <PM8994_GPIO_S4>; // 1.8V
-			qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
-			bias-pull-down;
-		};
-	};
-
-	audio_mclk: clk_div1 {
-		pinconf {
-			pins = "gpio15";
-			function = "func1";
-			power-source = <PM8994_GPIO_S4>; // 1.8V
-		};
-	};
-
-	volume_up_gpio: pm8996_gpio2 {
-		pinconf {
-			pins = "gpio2";
-			function = "normal";
-			input-enable;
-			drive-push-pull;
-			bias-pull-up;
-			qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
-			power-source = <PM8994_GPIO_S4>; // 1.8V
-		};
-	};
-
-	divclk4_pin_a: divclk4 {
-		pinconf {
-			pins = "gpio18";
-			function = PMIC_GPIO_FUNC_FUNC2;
-
-			bias-disable;
-			power-source = <PM8994_GPIO_S4>;
-		};
-	};
-
-	usb3_vbus_det_gpio: pm8996_gpio22 {
-		pinconf {
-			pins = "gpio22";
-			function = PMIC_GPIO_FUNC_NORMAL;
-			input-enable;
-			bias-pull-down;
-			qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
-			power-source = <PM8994_GPIO_S4>; // 1.8V
-		};
-	};
-};
-
-&pmi8994_gpios {
-	usb2_vbus_det_gpio: pmi8996_gpio6 {
-		pinconf {
-			pins = "gpio6";
-			function = PMIC_GPIO_FUNC_NORMAL;
-			input-enable;
-			bias-pull-down;
-			qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
-			power-source = <PM8994_GPIO_S4>; // 1.8V
-		};
-	};
-};
diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index 99990a139938..6c64deecf950 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -6,10 +6,9 @@
 #include "msm8996.dtsi"
 #include "pm8994.dtsi"
 #include "pmi8994.dtsi"
-#include "apq8096-db820c-pins.dtsi"
-#include "apq8096-db820c-pmic-pins.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/sound/qcom,q6afe.h>
 #include <dt-bindings/sound/qcom,q6asm.h>
 
@@ -384,6 +383,110 @@
 		"NC", /* GPIO_147 */
 		"NC", /* GPIO_148 */
 		"NC"; /* GPIO_149 */
+
+	sdc2_cd_on: sdc2_cd_on {
+		mux {
+			pins = "gpio38";
+			function = "gpio";
+		};
+
+		config {
+			pins = "gpio38";
+			bias-pull-up;		/* pull up */
+			drive-strength = <16>;	/* 16 MA */
+		};
+	};
+
+	sdc2_cd_off: sdc2_cd_off {
+		mux {
+			pins = "gpio38";
+			function = "gpio";
+		};
+
+		config {
+			pins = "gpio38";
+			bias-pull-up;		/* pull up */
+			drive-strength = <2>;	/* 2 MA */
+		};
+	};
+
+	blsp1_uart1_default: blsp1_uart1_default {
+		mux {
+			pins = "gpio41", "gpio42", "gpio43", "gpio44";
+			function = "blsp_uart2";
+		};
+
+		config {
+			pins = "gpio41", "gpio42", "gpio43", "gpio44";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	blsp1_uart1_sleep: blsp1_uart1_sleep {
+		mux {
+			pins = "gpio41", "gpio42", "gpio43", "gpio44";
+			function = "gpio";
+		};
+
+		config {
+			pins = "gpio41", "gpio42", "gpio43", "gpio44";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
+	hdmi_hpd_active: hdmi_hpd_active {
+		mux {
+			pins = "gpio34";
+			function = "hdmi_hot";
+		};
+
+		config {
+			pins = "gpio34";
+			bias-pull-down;
+			drive-strength = <16>;
+		};
+	};
+
+	hdmi_hpd_suspend: hdmi_hpd_suspend {
+		mux {
+			pins = "gpio34";
+			function = "hdmi_hot";
+		};
+
+		config {
+			pins = "gpio34";
+			bias-pull-down;
+			drive-strength = <2>;
+		};
+	};
+
+	hdmi_ddc_active: hdmi_ddc_active {
+		mux {
+			pins = "gpio32", "gpio33";
+			function = "hdmi_ddc";
+		};
+
+		config {
+			pins = "gpio32", "gpio33";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
+	hdmi_ddc_suspend: hdmi_ddc_suspend {
+		mux {
+			pins = "gpio32", "gpio33";
+			function = "hdmi_ddc";
+		};
+
+		config {
+			pins = "gpio32", "gpio33";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+	};
 };
 
 &pcie0 {
@@ -436,6 +539,80 @@
 		"PMIC_SLB",
 		"PMIC_BUA",
 		"USB_VBUS_DET";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&ls_exp_gpio_f &bt_en_gpios>;
+
+	ls_exp_gpio_f: pm8994_gpio5 {
+		pinconf {
+			pins = "gpio5";
+			output-low;
+			power-source = <2>; // PM8994_GPIO_S4, 1.8V
+		};
+	};
+
+	bt_en_gpios: bt_en_gpios {
+		pinconf {
+			pins = "gpio19";
+			function = PMIC_GPIO_FUNC_NORMAL;
+			output-low;
+			power-source = <PM8994_GPIO_S4>; // 1.8V
+			qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
+			bias-pull-down;
+		};
+	};
+
+	wlan_en_gpios: wlan_en_gpios {
+		pinconf {
+			pins = "gpio8";
+			function = PMIC_GPIO_FUNC_NORMAL;
+			output-low;
+			power-source = <PM8994_GPIO_S4>; // 1.8V
+			qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
+			bias-pull-down;
+		};
+	};
+
+	audio_mclk: clk_div1 {
+		pinconf {
+			pins = "gpio15";
+			function = "func1";
+			power-source = <PM8994_GPIO_S4>; // 1.8V
+		};
+	};
+
+	volume_up_gpio: pm8996_gpio2 {
+		pinconf {
+			pins = "gpio2";
+			function = "normal";
+			input-enable;
+			drive-push-pull;
+			bias-pull-up;
+			qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
+			power-source = <PM8994_GPIO_S4>; // 1.8V
+		};
+	};
+
+	divclk4_pin_a: divclk4 {
+		pinconf {
+			pins = "gpio18";
+			function = PMIC_GPIO_FUNC_FUNC2;
+
+			bias-disable;
+			power-source = <PM8994_GPIO_S4>;
+		};
+	};
+
+	usb3_vbus_det_gpio: pm8996_gpio22 {
+		pinconf {
+			pins = "gpio22";
+			function = PMIC_GPIO_FUNC_NORMAL;
+			input-enable;
+			bias-pull-down;
+			qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
+			power-source = <PM8994_GPIO_S4>; // 1.8V
+		};
+	};
 };
 
 &pm8994_mpps {
@@ -462,6 +639,17 @@
 		"NC",
 		"NC",
 		"NC";
+
+	usb2_vbus_det_gpio: pmi8996_gpio6 {
+		pinconf {
+			pins = "gpio6";
+			function = PMIC_GPIO_FUNC_NORMAL;
+			input-enable;
+			bias-pull-down;
+			qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
+			power-source = <PM8994_GPIO_S4>; // 1.8V
+		};
+	};
 };
 
 &rpm_requests {
-- 
2.23.0

