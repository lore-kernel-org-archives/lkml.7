Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898EBCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 05:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B4C42089C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 05:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uD4BkpkN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfJUFN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 01:13:28 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46523 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfJUFN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 01:13:27 -0400
Received: by mail-pf1-f195.google.com with SMTP id q5so7623795pfg.13
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 22:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G/DyGblyYd1ilcsqKJpKOSx8FxKWJ7BemMzFbdnwqIE=;
        b=uD4BkpkNw7CXoCJ3inCuVjy53/AcUUKpYDea2UyAItozmhZtgp3+8hCdXoYo5goVJ5
         3FQ9Ema1vF16mzung5fuaK+sENhDb0YMAxjtoZgstbtNMyadwtbMWOetnvKn1U31FG8y
         n75RdHjyGygE/pRmIeqksfPHfur4D3yJpSGBh/d7k0MtGZpowxZgMBMn+syXuEsnSEJW
         I7Zx0elpJ78ipkabbG9eLOJWlRO7tQoCwZ6BhKjsPFTCCI+skvzNDqzTuwdJC1/uZ1r/
         4pmNErMYzjol6zimBK0+LXQOo59kfL5kTb5KVexadGcOpa1DlYgsJcrG2bva2NS6eh9T
         dS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G/DyGblyYd1ilcsqKJpKOSx8FxKWJ7BemMzFbdnwqIE=;
        b=jMGgXxTR4FH2ZIpmEkRb+Y+vVfBTeIaxwDplPjILRvE74DSdRegkaQ8b+QD3pVfliD
         IOd1HruTMRJ3eL7feFCpFPtiuTMIKTvGMQLo8ClnU4EaF8OZJa6LIkWZYC3UQVbi2jHR
         73Lr68xnhlj6089VaFNf2zRK3KNCkC3OBG534VDD3W0O6LxrwK8i1ZsSBqT/Tvz12NyI
         6QKedlSkenmB3CATEUJ0GyvoXoI9NISK+AKUvdekfWjjHs/OmTbOJmZQlL9MsMq/KFwJ
         e9rxwOW3LL1HLduQ6XwMzDYVADlQ7bJXK2dp5o41oAksOrJru71151YH68+QtPS/0qYK
         o++g==
X-Gm-Message-State: APjAAAUPoYP0vgTECqL/HHogscCU6z0vbK/J8tPW/z+lxmvP4VoZTNeA
        9tUNOpGD4MyxgA9S8QsH+vxWfw==
X-Google-Smtp-Source: APXvYqywumhuD9k4R4nUizbQWvEm8WzLTXVrDY9n8sBd07gokPv6ESH3aMg4K5XWF4LLbErD77Adug==
X-Received: by 2002:a63:5f52:: with SMTP id t79mr7354842pgb.311.1571634806955;
        Sun, 20 Oct 2019 22:13:26 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h68sm15716862pfb.149.2019.10.20.22.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2019 22:13:26 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] arm64: dts: qcom: db820c: Move non-soc entries out of /soc
Date:   Sun, 20 Oct 2019 22:13:12 -0700
Message-Id: <20191021051322.297560-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191021051322.297560-1-bjorn.andersson@linaro.org>
References: <20191021051322.297560-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB id pins and wlan regulator are not platform devices, so move
them out of /soc

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 58 ++++++++++----------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index dba3488492f1..da2f01eb3be2 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -399,13 +399,6 @@
 			};
 		};
 
-		usb3_id: usb3-id {
-			compatible = "linux,extcon-usb-gpio";
-			id-gpio = <&pm8994_gpios 22 GPIO_ACTIVE_HIGH>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&usb3_vbus_det_gpio>;
-		};
-
 		usb@76f8800 {
 			status = "okay";
 			extcon = <&usb2_id>;
@@ -417,28 +410,6 @@
 			};
 		};
 
-		usb2_id: usb2-id {
-			compatible = "linux,extcon-usb-gpio";
-			id-gpio = <&pmi8994_gpios 6 GPIO_ACTIVE_HIGH>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&usb2_vbus_det_gpio>;
-		};
-
-		wlan_en: wlan-en-1-8v {
-			pinctrl-names = "default";
-			pinctrl-0 = <&wlan_en_gpios>;
-			compatible = "regulator-fixed";
-			regulator-name = "wlan-en-regulator";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-
-			gpio = <&pm8994_gpios 8 0>;
-
-			/* WLAN card specific delay */
-			startup-delay-us = <70000>;
-			enable-active-high;
-		};
-
 		agnoc@0 {
 			pcie@600000 {
 				status = "okay";
@@ -667,6 +638,35 @@
 			};
 		};
 	};
+
+	usb2_id: usb2-id {
+		compatible = "linux,extcon-usb-gpio";
+		id-gpio = <&pmi8994_gpios 6 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb2_vbus_det_gpio>;
+	};
+
+	usb3_id: usb3-id {
+		compatible = "linux,extcon-usb-gpio";
+		id-gpio = <&pm8994_gpios 22 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb3_vbus_det_gpio>;
+	};
+
+	wlan_en: wlan-en-1-8v {
+		pinctrl-names = "default";
+		pinctrl-0 = <&wlan_en_gpios>;
+		compatible = "regulator-fixed";
+		regulator-name = "wlan-en-regulator";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+
+		gpio = <&pm8994_gpios 8 0>;
+
+		/* WLAN card specific delay */
+		startup-delay-us = <70000>;
+		enable-active-high;
+	};
 };
 
 &spmi_bus {
-- 
2.23.0

