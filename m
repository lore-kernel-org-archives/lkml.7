Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963EAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682B92070B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ssaX2K4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbfC2KNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:13:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45043 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729137AbfC2KNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:13:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id y7so1834329wrn.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 03:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=7Xe7EiqZq0M1Qyy2HtL4P1xMmE3v1eI2RJwikfAYNmQ=;
        b=ssaX2K4+U8rP7Q0pUqz/wu/qqNVlJBHWFdV4egfy2k2mRv2xucCpxxCRAGCcL8+Wzw
         SLMh/yNAYdd78yj4chO0L9Pv3OuiKQgS9ndmefToa6SECQ++tYmdCogLBYpsJcoDwTvE
         WGIq4zSI606OVoGUogBr46guvmnbcZIWDbmA4dopKQwx/d8tjuyD3uM0TmnugnP7bt+v
         E9Y2Kgqr9VB59WnRnzEO67oCL4KhUwy1H85pOthhyjF9QdVCwUDA+0VUXGnWruz2q/s+
         9A3sRN0cjaeV2ULaiGz9S/vVsG/ntpLMKfufDPzXoB4vpJ+z8t6JEW0gmmsdmjgKPooR
         qLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=7Xe7EiqZq0M1Qyy2HtL4P1xMmE3v1eI2RJwikfAYNmQ=;
        b=hqL1W1TAH3y83tsnHTi571d/zq+KWM2qbfSxEXVUWv0DaaaFu+RswYBZP/m+8hM9zY
         /pNEEzusf79DmCGuOyDjcGufNCMXtvKyODN9NP8RtOw3VCNXLd2dpB1XzKq2fQv7hqjf
         qw40Xn/cW0ljqpIo6/29h/hxeIHcR2eZHv/QXf++cbhL4gLtoof9o4nqsmfHgx+6Tv3f
         SRiL08uIEifELR9zl5nPM17+M7gdwTdRsDyPBSsRQDCTzwMakf/r5Wc/sQKhEYhDp68I
         BcXFvD7dH4sCHFm4NXMliWVy0vh+VyWeCooLTUxokP5jdNRqJfywlKMwgWeDS0/1KW/3
         DA7Q==
X-Gm-Message-State: APjAAAUgx8J/b6Mnm0zTEnGpQBTxwN5tIweaOw+//inBuRgKjb1fXppd
        vCEai7WOvtzJm2NV3qJ8OTc5PLlcXVo=
X-Google-Smtp-Source: APXvYqxEPuNMZA2EZDE/DBYQwT/FVDcTcO2WDZv5VIk2yd4cFRqC1bONiH8jqWEMSItLbQLGXPZwSw==
X-Received: by 2002:adf:82f0:: with SMTP id 103mr30601778wrc.260.1553854416276;
        Fri, 29 Mar 2019 03:13:36 -0700 (PDT)
Received: from localhost ([49.248.196.175])
        by smtp.gmail.com with ESMTPSA id n189sm2557811wmb.28.2019.03.29.03.13.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 03:13:35 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, David Brown <david.brown@linaro.org>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v2 11/13] arm64: dts: msm8916: thermal: Make trip names consistent
Date:   Fri, 29 Mar 2019 15:42:17 +0530
Message-Id: <83bd84ec3a4ed9c4758f1c9bdf5168048e1f3b39.1553853990.git.amit.kucheria@linaro.org>
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
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index c8aa9a0986d2..ea734b98ec96 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -180,19 +180,19 @@
 	};
 
 	thermal-zones {
-		cpu-thermal0 {
+		cpu0_1-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens 4>;
 
 			trips {
-				cpu_alert0: trip0 {
+				cpu0_1_alert0: trip-point@0 {
 					temperature = <75000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
-				cpu_crit0: trip1 {
+				cpu0_1_crit: cpu_crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -201,7 +201,7 @@
 
 			cooling-maps {
 				map0 {
-					trip = <&cpu_alert0>;
+					trip = <&cpu0_1_alert0>;
 					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
 							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
 							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
@@ -210,19 +210,19 @@
 			};
 		};
 
-		cpu-thermal1 {
+		cpu2_3-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens 3>;
 
 			trips {
-				cpu_alert1: trip0 {
+				cpu2_3_alert0: trip-point@0 {
 					temperature = <75000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
-				cpu_crit1: trip1 {
+				cpu2_3_crit: cpu_crit {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -231,7 +231,7 @@
 
 			cooling-maps {
 				map0 {
-					trip = <&cpu_alert1>;
+					trip = <&cpu2_3_alert0>;
 					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
 							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
 							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
@@ -247,12 +247,12 @@
 			thermal-sensors = <&tsens 2>;
 
 			trips {
-				gpu_alert: trip0 {
+				gpu_alert0: trip-point@0 {
 					temperature = <75000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
-				gpu_crit: trip1 {
+				gpu_crit: gpu_crit {
 					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -267,12 +267,12 @@
 			thermal-sensors = <&tsens 1>;
 
 			trips {
-				cam_alert: trip0 {
+				cam_alert0: trip-point@0 {
 					temperature = <75000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
-				cam_crit: trip1 {
+				cam_crit: cam_crit {
 					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "critical";
-- 
2.17.1

