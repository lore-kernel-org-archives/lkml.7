Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C63C10F05
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 741002070B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gy0e/+kA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbfC2KNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:13:45 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54399 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729315AbfC2KNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:13:44 -0400
Received: by mail-wm1-f66.google.com with SMTP id c1so747297wml.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 03:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=WwtyREvJ+UtkrXa1gre5M7056T+QmrB65TrvTpb7eZU=;
        b=gy0e/+kAyAeoBpJjObYYpyULNweOvtWOxFHJJ09TxHS66FQh0TLnslQAhXzAEyDAnF
         38lwaBzZPSTRzkN+dplRa3t1JHqJi5MAwTRP4SchhTVXhGiwwIhgLgNzZARe4xWcrhKz
         qn35XRc8hVaTXhWb/0BL4CCyRpPmDQpIq8WgshN4cwzaAAtYJEN90PAwHpO4soo7Suq8
         2dihz+d/duI35s9NixSWajP4EU5utM4iD8NMZ67dc2DbYfQFoxVuTIh83a+zByKp5xgT
         Nz2lHwlJ/P8uJ/nt6+Oz3RcGmARXxQQAO+9gow/zVUAokEiHTYp23bLEI+/+85lYjWoi
         6erQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=WwtyREvJ+UtkrXa1gre5M7056T+QmrB65TrvTpb7eZU=;
        b=FN4ptjRR0keGplZEaI3XUdzqB20gqS7vhaPc+mThYc+6MNbHCpvEY5GJIkBAfBzTWL
         u9ATHaSz1Plpkc4RMYplAuPM/RaEq2hlUb/UF4bdww8LwEm3Pb2wAoaTneed0/4uJrWX
         rfNf7SOk14TvekkSNHWwic/YV3OWLoHSPHGzg6kzKJmF+e2Yygpd9pRFPgyQQYRp/Xy6
         fkh6uv/xxuav8trkY/eGjs8/DoRR1pozqH9ZsQb22CMQz9XTQSSqkFA965X0G75l8NXZ
         XRizbrs9KKdOww/lj6SiWVjEXDkuseC6RHaHvQzevSuZHKOj+CkO+YR46CJXVg7mpLvw
         y4QA==
X-Gm-Message-State: APjAAAVza4kMWJU7Nq23lvCBnKf5EGyWWs+XRibIJJjJ4bypNWLQTYEl
        3pOqWm9maaFttRwEpIpAC6jwbVizXsk=
X-Google-Smtp-Source: APXvYqz3ZVEx3eCq5XN4xn7apppn8Tb1HTJtoUYJ/u6JQJcBvscHtXK/snO/IvJcnZ1OZjLqpjKTCg==
X-Received: by 2002:a1c:c013:: with SMTP id q19mr3006025wmf.148.1553854422346;
        Fri, 29 Mar 2019 03:13:42 -0700 (PDT)
Received: from localhost ([49.248.196.175])
        by smtp.gmail.com with ESMTPSA id n1sm1404943wmc.19.2019.03.29.03.13.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 03:13:41 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, David Brown <david.brown@linaro.org>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v2 12/13] arm64: dts: msm8996: thermal: Make trip names consistent
Date:   Fri, 29 Mar 2019 15:42:18 +0530
Message-Id: <659854a32b8a92ae564e0f2b08d962d9002a033a.1553853990.git.amit.kucheria@linaro.org>
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
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index e2408ee91184..edcddc74a4fc 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -154,20 +154,20 @@
 	};
 
 	thermal-zones {
-		cpu-thermal0 {
+		cpu0-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 3>;
 
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
@@ -175,20 +175,20 @@
 			};
 		};
 
-		cpu-thermal1 {
+		cpu1-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 5>;
 
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
@@ -196,20 +196,20 @@
 			};
 		};
 
-		cpu-thermal2 {
+		cpu2-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 8>;
 
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
@@ -217,20 +217,20 @@
 			};
 		};
 
-		cpu-thermal3 {
+		cpu3-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 10>;
 
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
-- 
2.17.1

