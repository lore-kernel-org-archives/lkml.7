Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE25FC76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 22:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6BA222CBB
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 22:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R4IbPtu1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfGYWTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 18:19:47 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40574 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbfGYWTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 18:19:45 -0400
Received: by mail-pl1-f196.google.com with SMTP id a93so23882650pla.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 15:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=aNjPKzyo6hMwnV5/FxL6BFlsZjKINMXfLX+sOTPPGgw=;
        b=R4IbPtu14lVzwjLml/VV6llOaDJhPxOcQxNKK86jt7NrYwJQMEAeOm+pk0fnHP8ZGk
         Vg6OSP3yGlD1/8MRMWr0UyRW22EUlpB2Ic0BuiUqGwucMK6nXrDsDptzQBbBfx1LbYzx
         JS9Dqw5nTqzk3aFcTsjt/CK7055SaTSfb1pQDtfF+Gw8wXGxcmJp+3mvj01yD4b6Xpaq
         OWMQDFfEFZWJ1CU92Y1W5wn5YHLxMFiKyB5VeC73xdYXVAlhXr7fTS+Gt0Go+9Fu0Q8+
         TkdRBkWCVODWrRiQWIPa0k2G9HflNBloEcWA1ebIQCcReoBLKBI/JyyK6Op1TKIJ6bmW
         O8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=aNjPKzyo6hMwnV5/FxL6BFlsZjKINMXfLX+sOTPPGgw=;
        b=UqNeQ1pj9aw+/K3Y5vDUwbLNtsLOxtXgr4wiEkKQ52O4L8t9M9wEUG5MeKQB1aMNu/
         gVJDPp9Dk7uBOs3sXeLKUkOkqYWaB1/ncHVGbKvszvSvl48lGygQW22QVc2Y6tyj8ZO0
         XEmauY5y8PPbsLCCfJqMKS9JNUVrxzlc9atE1zUG1vBlIF1giE2TzL7+tEpLLG0fdwgO
         iD/MWRg8Az1HF4oBLz3orwDT5+TGw2K7nsTZFCQ9yyjeVzFHUZlylx0w5AkEbcdoof3K
         ilhlfiT6xhIvej0B/0lPd9qSUEjd+dU1/9v+9uMT6pJw5oC/4TCdQQmQdKdLBqq8JHEz
         RkKA==
X-Gm-Message-State: APjAAAWXND+qt3/EY2uKDVLuBfrcpiowPbWbFKqN8we9qjVklEIaoY2v
        Ll8l0yU34D47G/ZFI/IawQOhhYQsVL7n9g==
X-Google-Smtp-Source: APXvYqxuB1RRysz+k/guHccaq+T0RlG93QbmWhv3mHmu7KtPSwMjgwcHIGftzmLG3/9gLbntE7AVAw==
X-Received: by 2002:a17:902:8d92:: with SMTP id v18mr94249402plo.211.1564093184755;
        Thu, 25 Jul 2019 15:19:44 -0700 (PDT)
Received: from localhost ([49.248.170.216])
        by smtp.gmail.com with ESMTPSA id t26sm39405317pgu.43.2019.07.25.15.19.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 15:19:44 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Andy Gross <agross@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH 13/15] arm64: dts: msm8916: thermal: Add interrupt support
Date:   Fri, 26 Jul 2019 03:48:48 +0530
Message-Id: <380196111ac2b6faa6dfb27f26189ddaa1e6e606.1564091601.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1564091601.git.amit.kucheria@linaro.org>
References: <cover.1564091601.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1564091601.git.amit.kucheria@linaro.org>
References: <cover.1564091601.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register upper-lower interrupt for the tsens controller.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 8686e101905c..400045a100ca 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -176,8 +176,8 @@
 
 	thermal-zones {
 		cpu0_1-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens 5>;
 
@@ -206,8 +206,8 @@
 		};
 
 		cpu2_3-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens 4>;
 
@@ -236,8 +236,8 @@
 		};
 
 		gpu-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens 2>;
 
@@ -256,8 +256,8 @@
 		};
 
 		camera-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens 1>;
 
@@ -271,8 +271,8 @@
 		};
 
 		modem-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens 0>;
 
@@ -816,6 +816,8 @@
 			nvmem-cells = <&tsens_caldata>, <&tsens_calsel>;
 			nvmem-cell-names = "calib", "calib_sel";
 			#qcom,sensors = <5>;
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tsens";
 			#thermal-sensor-cells = <1>;
 		};
 
-- 
2.17.1

