Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AB7C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F2B20673
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="whhOKA68"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbfH0MPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 08:15:04 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42334 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729916AbfH0MPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:15:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id i30so14000281pfk.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 05:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Z0Le2PAu5WlIzLrzHU7A+NgFGbrzrQB5/n7YQK779lQ=;
        b=whhOKA68YptOYkj4IkTgoOPKKfPHlSFwGl1urwiruMkzIGkYQcY4eGQH+oGLL0o3FR
         ah28jbdMtX56fl5LBfgovM3UL/CJujI5CG9fGDDCydwezhToV+s2eeFjLd6vRDKIZJJ0
         5W9Dlgmk8HcUoOE1NyXRGQwEv1+kv5F3O/pGbVzSVV4AJrQqbLqKdhW8YUUGSmB0HzFS
         +LfAdgaWNiFJTeCfG1A75xlQX47dZs4oPCcaTBA/J7wc8lQs08aQzczYk8ogKGbcFlcJ
         u6d8NjmjO7pRMrMZZ9CK/SPQ1MRXKEdzPO8lI8LnF1Q3aG5ELhfAVAo9z6Z90nglQMX/
         G/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Z0Le2PAu5WlIzLrzHU7A+NgFGbrzrQB5/n7YQK779lQ=;
        b=i8RxfdxEBthYupCjWCATlR/RnRRoc4Jd92+UBPq4XUORSIOq9sxa4izMuwjzampo4b
         2GBr5iBf7OakW4dcn5ZH1y4/XyUxzxzCHY/MHeeLW8pNjZs+OLo5j+sq7GRKemLqYWEA
         cBNC4euw1YEY9Mj4ZBTDGN6EtRoSU9pdMXPFiYVqqRUgKhXmIXILtBARsSgF45+xXiEL
         cwNLLY1MS9Lp/+Eixy0ZL/1pN1W8lwBJIt5d4obQ6PR/PEOZiyphz6m1Q+egtXTaQU3y
         GYmuq5aoGWHa8r4iwAhvYtqhYjYUO2q2adhFntx5o/HsApTfMGwLyCXRs5QljqY2jVyb
         797A==
X-Gm-Message-State: APjAAAVwV/PzyxuEJZZNWoOp3vLWIvzKKcPlN3l4+R8HoV41iQAfjy+k
        ZRsFuHZJrcR4qFygr/r/B3PLBn1SqU1CBQ==
X-Google-Smtp-Source: APXvYqwR5Z4DUxKPLxASjWsJ5oNhCB+0ZlPjeppJbKLwKGycGmhiMP0rCNHydyMr50Xd0+l4A5B1TQ==
X-Received: by 2002:a17:90a:bf0e:: with SMTP id c14mr8812038pjs.140.1566908100794;
        Tue, 27 Aug 2019 05:15:00 -0700 (PDT)
Received: from localhost ([49.248.54.193])
        by smtp.gmail.com with ESMTPSA id o3sm4426355pje.1.2019.08.27.05.14.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 05:15:00 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        sboyd@kernel.org, masneyb@onstation.org, marc.w.gonzalez@free.fr,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v2 09/15] arm64: dts: msm8996: thermal: Add interrupt support
Date:   Tue, 27 Aug 2019 17:44:05 +0530
Message-Id: <1cb5ab682bce53d32f3a73b5b29cc6c3e800bfcc.1566907161.git.amit.kucheria@linaro.org>
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
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 60 ++++++++++++++-------------
 1 file changed, 32 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 96c0a481f454e..bb763b362c162 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -175,8 +175,8 @@
 
 	thermal-zones {
 		cpu0-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 3>;
 
@@ -196,8 +196,8 @@
 		};
 
 		cpu1-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 5>;
 
@@ -217,8 +217,8 @@
 		};
 
 		cpu2-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 8>;
 
@@ -238,8 +238,8 @@
 		};
 
 		cpu3-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 10>;
 
@@ -259,8 +259,8 @@
 		};
 
 		gpu-thermal-top {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens1 6>;
 
@@ -274,8 +274,8 @@
 		};
 
 		gpu-thermal-bottom {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens1 7>;
 
@@ -289,8 +289,8 @@
 		};
 
 		m4m-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 1>;
 
@@ -304,8 +304,8 @@
 		};
 
 		l3-or-venus-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 2>;
 
@@ -319,8 +319,8 @@
 		};
 
 		cluster0-l2-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 7>;
 
@@ -334,8 +334,8 @@
 		};
 
 		cluster1-l2-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 12>;
 
@@ -349,8 +349,8 @@
 		};
 
 		camera-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens1 1>;
 
@@ -364,8 +364,8 @@
 		};
 
 		q6-dsp-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens1 2>;
 
@@ -379,8 +379,8 @@
 		};
 
 		mem-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens1 3>;
 
@@ -394,8 +394,8 @@
 		};
 
 		modemtx-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens1 4>;
 
@@ -591,6 +591,8 @@
 			reg = <0x4a9000 0x1000>, /* TM */
 			      <0x4a8000 0x1000>; /* SROT */
 			#qcom,sensors = <13>;
+			interrupts = <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow";
 			#thermal-sensor-cells = <1>;
 		};
 
@@ -599,6 +601,8 @@
 			reg = <0x4ad000 0x1000>, /* TM */
 			      <0x4ac000 0x1000>; /* SROT */
 			#qcom,sensors = <8>;
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow";
 			#thermal-sensor-cells = <1>;
 		};
 
-- 
2.17.1

