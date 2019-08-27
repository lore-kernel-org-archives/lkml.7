Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE34C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1975B21881
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OQ9KIMH2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbfH0MPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 08:15:11 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42347 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729946AbfH0MPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:15:06 -0400
Received: by mail-pf1-f196.google.com with SMTP id i30so14000426pfk.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 05:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=jsacasSdR4EmC5KykVj3gAAOQ3NwmmFKtHpE2Pab4bk=;
        b=OQ9KIMH25tS/wRGr8LPMqixT/2rRHQEbcKive4WxsloxddJVXVgHXGwkBL0BOLaXtN
         B2PjLpp/zt+OQv+WAubAnIQNxVbGahPYvoycwVda61RFfQsRedVuNBgopQvwFFiJB+K6
         ltNvtf/BpeD9W2ZMKd8Cgz6OIlGiwWl3F3ndlQe138nQA18C/4tqk1+yeSGUNbYy43Wd
         oE1W0UrMoGPOBVM8hd1TiJ5ApUE8J7VmS71mdP6tx2pS3+Eet0Pqfu7tBYKpa8CaLqFc
         13SRQI3qq3MpBWR055LKUYw5C9Lv1nQ43f2KBF56WwjSZu6J3IJ0QEkDKrF480FF172Y
         NAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=jsacasSdR4EmC5KykVj3gAAOQ3NwmmFKtHpE2Pab4bk=;
        b=qvNGvm8T698bik13BuQOV97fjoup5nVwFxfwb9cf9eqoW79tw4QcocRSyAACvvsIfq
         uBH/kTvSbkbjetfb7yiB91zIVnDwFErGBU/j/sVZKwXpVaztiDBohvnqQghywpmA3kdp
         G6JmN4ItLn3L3Am4QpO2TUdgcnuzrafTthjS1jBHjIis3XMN9B8p6o5mqUPpKXO1AsuC
         QJ2XgvOkzyJ11QABI21QFahIaNHtH8adysdOevmxxxpz5O9bWiiF7WuFG9D2MFTkc+1i
         Hni9gQID8DiAlid9tPW2jXfB+sJOUGZZo56yOkLa1IHUwRKrHXxM1ImTaJLVxh3MGKKi
         +q/Q==
X-Gm-Message-State: APjAAAUc88idxycCSwJMQXp4qT2dS8aLbDarOQl/g5h8zWpJ6APCEfZW
        M/VuRxQKyWEXQ6Ax74xMjc/F+9ol70V1xQ==
X-Google-Smtp-Source: APXvYqzITno8rb9WHG8gdazskoLWPmlIhvPy5jS6jbxepwt78a8TKjZTAFMXKMT9O27kljon2c1ZaA==
X-Received: by 2002:a63:d84e:: with SMTP id k14mr21037638pgj.234.1566908104765;
        Tue, 27 Aug 2019 05:15:04 -0700 (PDT)
Received: from localhost ([49.248.54.193])
        by smtp.gmail.com with ESMTPSA id y188sm15124199pfb.115.2019.08.27.05.15.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 05:15:04 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        sboyd@kernel.org, masneyb@onstation.org, marc.w.gonzalez@free.fr,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v2 10/15] arm64: dts: msm8998: thermal: Add interrupt support
Date:   Tue, 27 Aug 2019 17:44:06 +0530
Message-Id: <d6a0d6888e334888198963aec167cffc104c0a4f.1566907161.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1566907161.git.amit.kucheria@linaro.org>
References: <cover.1566907161.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1566907161.git.amit.kucheria@linaro.org>
References: <cover.1566907161.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register upper-lower interrupts for each of the two tsens controllers.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 82 ++++++++++++++-------------
 1 file changed, 42 insertions(+), 40 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index c13ed7aeb1e0c..1e2f77b38f2c1 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -440,8 +440,8 @@
 
 	thermal-zones {
 		cpu0-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 1>;
 
@@ -461,8 +461,8 @@
 		};
 
 		cpu1-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 2>;
 
@@ -482,8 +482,8 @@
 		};
 
 		cpu2-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 3>;
 
@@ -503,8 +503,8 @@
 		};
 
 		cpu3-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 4>;
 
@@ -524,8 +524,8 @@
 		};
 
 		cpu4-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 7>;
 
@@ -545,8 +545,8 @@
 		};
 
 		cpu5-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 8>;
 
@@ -566,8 +566,8 @@
 		};
 
 		cpu6-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 9>;
 
@@ -587,8 +587,8 @@
 		};
 
 		cpu7-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 10>;
 
@@ -608,8 +608,8 @@
 		};
 
 		gpu-thermal-bottom {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 12>;
 
@@ -623,8 +623,8 @@
 		};
 
 		gpu-thermal-top {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 13>;
 
@@ -638,8 +638,8 @@
 		};
 
 		clust0-mhm-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 5>;
 
@@ -653,8 +653,8 @@
 		};
 
 		clust1-mhm-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 6>;
 
@@ -668,8 +668,8 @@
 		};
 
 		cluster1-l2-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 11>;
 
@@ -683,8 +683,8 @@
 		};
 
 		modem-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens1 1>;
 
@@ -698,8 +698,8 @@
 		};
 
 		mem-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens1 2>;
 
@@ -713,8 +713,8 @@
 		};
 
 		wlan-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens1 3>;
 
@@ -728,8 +728,8 @@
 		};
 
 		q6-dsp-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens1 4>;
 
@@ -743,8 +743,8 @@
 		};
 
 		camera-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens1 5>;
 
@@ -758,8 +758,8 @@
 		};
 
 		multimedia-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens1 6>;
 
@@ -845,8 +845,9 @@
 			compatible = "qcom,msm8998-tsens", "qcom,tsens-v2";
 			reg = <0x10ab000 0x1000>, /* TM */
 			      <0x10aa000 0x1000>; /* SROT */
-
 			#qcom,sensors = <14>;
+			interrupts = <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow";
 			#thermal-sensor-cells = <1>;
 		};
 
@@ -854,8 +855,9 @@
 			compatible = "qcom,msm8998-tsens", "qcom,tsens-v2";
 			reg = <0x10ae000 0x1000>, /* TM */
 			      <0x10ad000 0x1000>; /* SROT */
-
 			#qcom,sensors = <8>;
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow";
 			#thermal-sensor-cells = <1>;
 		};
 
-- 
2.17.1

