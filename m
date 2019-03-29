Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57187C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B0322070B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xacPfH2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbfC2KNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:13:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37826 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729257AbfC2KNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:13:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id w10so1870300wrm.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 03:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=OujNZc42kCq7zUXMisag/ClKHZpikAp2j81GdH4F8c8=;
        b=xacPfH2G5Gwha82agXR2eh+YYw351Qi7DUx8/wuwk4IRijVMSYTz0vWKDawvLVK3zl
         WTE0wzo9RljBbwJme/revgCSuLovGwQ35BRfzapRaXdnkoGlMBF7OQ8OdTNWEprzsE9d
         ZFnQ6rQIECfrN4u3qddbkwUJ2WJjjuDur1nhVRCRm5T5h2bD+EwMcHx81pEFSePwk7cE
         2u7ivr2eaohJupE+otV4g/FxdCXfpDP3WktKRTOKusFFBnbNtGUsrvAhCtrefDUvKtWv
         eC1QVfqQqyMbpMNk35FNcdSB+vGPgsc/kdbDaFyhp/s60g6GX5sagDaMdIEURaZf4dHI
         ymbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=OujNZc42kCq7zUXMisag/ClKHZpikAp2j81GdH4F8c8=;
        b=dc25HMEWUOQ/gsmpZL62Mbe0LMOqpEki7DFDG9fSjhAPQuDNusKYzyS0ZTdeEBHzkw
         yh3qg/vbK/Ue29YEotAbVRjh/NPxRG4WA6IBtpYYGxF80K/vyaDjpKKJXbgGYE5GXmC7
         q9i4LbjbN7Oa/+VESLvHT5PmvbO5pgFbYxUqbwkDnRrhuYXUPirNL0s5vKLZjNkx/HbC
         8rflKWytKECTqO0VpSI4+blJSi6oRgsXuJ4/uoi1YEECBGoRvgDV4YTR2QCql8/fh9L/
         YgDhyUION9HFnOs2gaLytSr5iquxFOXDYNB3UnJniPkfcigExgTGGFuOq5o3nmI6Cpxf
         ybhQ==
X-Gm-Message-State: APjAAAW9qBGTsMr0sMbp3fscHGNAFhK65Mkds5JEYxWpDg4PeEZ4Y/zj
        IFYM9DaE7jEHb1gcSnOZXcvknrlFus0=
X-Google-Smtp-Source: APXvYqw2B2MxFkZycud6NYFGKfZk2DCf618bP1nWJ6zy7KC92ePs1kWhsIvaQ+PMjEPgQAOBBcSPHw==
X-Received: by 2002:adf:e487:: with SMTP id i7mr31150308wrm.264.1553854410139;
        Fri, 29 Mar 2019 03:13:30 -0700 (PDT)
Received: from localhost ([49.248.196.175])
        by smtp.gmail.com with ESMTPSA id y127sm1595565wmg.29.2019.03.29.03.13.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 03:13:29 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, David Brown <david.brown@linaro.org>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v2 10/13] arm64: dts: msm8998: thermal: Make trip names consistent
Date:   Fri, 29 Mar 2019 15:42:16 +0530
Message-Id: <ba15d6f24f555999fe14aa8bd370123f6a7ecd96.1553853990.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1553853990.git.amit.kucheria@linaro.org>
References: <cover.1553853990.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1553853990.git.amit.kucheria@linaro.org>
References: <cover.1553853990.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maintain naming consistency with what was landed for sdm845. Simplifies
parsing for test tools.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 48 +++++++++++++--------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 26e476078cb6..998017d4d847 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -338,20 +338,20 @@
 	};
 
 	thermal-zones {
-		cpu-thermal0 {
+		cpu0-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 1>;
 
 			trips {
-				cpu_alert0: trip0 {
+				cpu0_alert0: trip-point@0 {
 					temperature = <75000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit0: trip1 {
+				cpu0_crit: cpu_crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -359,20 +359,20 @@
 			};
 		};
 
-		cpu-thermal1 {
+		cpu1-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 2>;
 
 			trips {
-				cpu_alert1: trip0 {
+				cpu1_alert0: trip-point@0 {
 					temperature = <75000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit1: trip1 {
+				cpu1_crit: cpu_crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -380,20 +380,20 @@
 			};
 		};
 
-		cpu-thermal2 {
+		cpu2-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 3>;
 
 			trips {
-				cpu_alert2: trip0 {
+				cpu2_alert0: trip-point@0 {
 					temperature = <75000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit2: trip1 {
+				cpu2_crit: cpu_crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -401,20 +401,20 @@
 			};
 		};
 
-		cpu-thermal3 {
+		cpu3-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 4>;
 
 			trips {
-				cpu_alert3: trip0 {
+				cpu3_alert0: trip-point@0 {
 					temperature = <75000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit3: trip1 {
+				cpu3_crit: cpu_crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -422,20 +422,20 @@
 			};
 		};
 
-		cpu-thermal4 {
+		cpu4-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 7>;
 
 			trips {
-				cpu_alert4: trip0 {
+				cpu4_alert0: trip-point@0 {
 					temperature = <75000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit4: trip1 {
+				cpu4_crit: cpu_crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -443,20 +443,20 @@
 			};
 		};
 
-		cpu-thermal5 {
+		cpu5-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 8>;
 
 			trips {
-				cpu_alert5: trip0 {
+				cpu5_alert0: trip-point@0 {
 					temperature = <75000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit5: trip1 {
+				cpu5_crit: cpu_crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -464,20 +464,20 @@
 			};
 		};
 
-		cpu-thermal6 {
+		cpu6-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 9>;
 
 			trips {
-				cpu_alert6: trip0 {
+				cpu6_alert0: trip-point@0 {
 					temperature = <75000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit6: trip1 {
+				cpu6_crit: cpu_crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -485,20 +485,20 @@
 			};
 		};
 
-		cpu-thermal7 {
+		cpu7-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 10>;
 
 			trips {
-				cpu_alert7: trip0 {
+				cpu7_alert0: trip-point@0 {
 					temperature = <75000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit7: trip1 {
+				cpu7_crit: cpu_crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
-- 
2.17.1

