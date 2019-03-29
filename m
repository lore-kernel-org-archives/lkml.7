Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4519CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111502070B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ptIWrNy3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbfC2KND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:13:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46734 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729082AbfC2KNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:13:01 -0400
Received: by mail-wr1-f66.google.com with SMTP id t17so1823584wrw.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 03:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Et6sor8PU+KdoioSjuhpGkTFWSasdTtvhbgyNeM0Xbk=;
        b=ptIWrNy39lKQlHnJMU7bkY1sU969gX4anhjptaOirIAR61aZCNrI+D7JwpwmRiRG8O
         3/3fgxy7+vxkHgJu3F/GniVGK1yMDUg7IkC1M1rp4H9+PmHkhEsjw2YnWWY3QscPL/e9
         Wr4yuJ24hHs6uFwJn6PQp1pAw90JmzH8b8bcUnNYgVhkng0jJM1FNROjCwpwAdtHK/Ij
         r3CW03FuFNxXbNxF3XatX7LNg3RiJIVsMI6i69hx/MFvKsOPrqg7+TEaAITVSR/G1dw9
         RE+iHvKbbmZ5EPenlCWpeBa8SWrAf6ozpng17mIAX0MvfLw+QvQfrLcvdOi8MehR8DIV
         4ciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Et6sor8PU+KdoioSjuhpGkTFWSasdTtvhbgyNeM0Xbk=;
        b=NVB36M6ZWibUJs+UEp/kaoEQpV6lA/by6LIyRLJplEdHJTBpj3/Mb4dzVXPyHAT65x
         LDjLhUFJHtRhS4iMTf3s8egQm/PcIoUX7U+CiExHkzt0eIyxFLrMGyue9JJVH5aP2bLt
         Iio8I7mrqJt5Wj61sudZRZrlAHLdpMpXOqTdDHsfPifKHd/A7VpIEOqcEt+UGzJk4X+3
         Qh+kdHhwqSjyDkpBsiYPdSM/NmFu20nAFBI/cBjMLO0O4w43aU0EvNPYbduRVM4hsXMM
         R6S69VRl+YE3TjUYi1/ERnpQGIN5no2667Eh458ViFckcA2vQ8TLKgar8Nb0J8YG2CRe
         Fpjw==
X-Gm-Message-State: APjAAAVuXxN8UAdVduOEb0eMEaDvHZNfY3QLymQRfzEyIYMJT2ZVK0kd
        Nx+nKwWYtqjpWAb24iXVjnkqvBvKuIo=
X-Google-Smtp-Source: APXvYqw9AC7+hArUB5RKgMUsCFlHXz+NydnJRAK3NgwBhWLxXy37epiMbxKuPNQoVcjnS/Gyshbrog==
X-Received: by 2002:adf:ba81:: with SMTP id p1mr29163589wrg.192.1553854379291;
        Fri, 29 Mar 2019 03:12:59 -0700 (PDT)
Received: from localhost ([49.248.196.175])
        by smtp.gmail.com with ESMTPSA id g8sm3005774wro.77.2019.03.29.03.12.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 03:12:58 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, David Brown <david.brown@linaro.org>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v2 05/13] arm64: dts: msm8998: thermal: Fix the cpu sensor numbers
Date:   Fri, 29 Mar 2019 15:42:11 +0530
Message-Id: <50441c28c22290ed9df7ab394d773a77603caed5.1553853990.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1553853990.git.amit.kucheria@linaro.org>
References: <cover.1553853990.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1553853990.git.amit.kucheria@linaro.org>
References: <cover.1553853990.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The silver cluster (typically cpu0-3) are monitored by sensor IDs 1-3 on
tsens controller 0. The gold cluster (typically cpu4-7) are monitored by
sensor IDs 7-10 on tsens controller 0.

Fixes: 4449b6f248d9a1 ("arm64: dts: qcom: msm8998: Add tsens and thermal-zones")
Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 0b6de0c29ee8..108a5aa146a2 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -342,7 +342,7 @@
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
-			thermal-sensors = <&tsens0 6>;
+			thermal-sensors = <&tsens0 1>;
 
 			trips {
 				cpu_alert0: trip0 {
@@ -363,7 +363,7 @@
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
-			thermal-sensors = <&tsens0 7>;
+			thermal-sensors = <&tsens0 2>;
 
 			trips {
 				cpu_alert1: trip0 {
@@ -384,7 +384,7 @@
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
-			thermal-sensors = <&tsens0 8>;
+			thermal-sensors = <&tsens0 3>;
 
 			trips {
 				cpu_alert2: trip0 {
@@ -405,7 +405,7 @@
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
-			thermal-sensors = <&tsens0 9>;
+			thermal-sensors = <&tsens0 4>;
 
 			trips {
 				cpu_alert3: trip0 {
@@ -426,7 +426,7 @@
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
-			thermal-sensors = <&tsens0 10>;
+			thermal-sensors = <&tsens0 7>;
 
 			trips {
 				cpu_alert4: trip0 {
@@ -447,7 +447,7 @@
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
-			thermal-sensors = <&tsens0 11>;
+			thermal-sensors = <&tsens0 8>;
 
 			trips {
 				cpu_alert5: trip0 {
@@ -468,7 +468,7 @@
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
-			thermal-sensors = <&tsens1 0>;
+			thermal-sensors = <&tsens0 9>;
 
 			trips {
 				cpu_alert6: trip0 {
@@ -489,7 +489,7 @@
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
-			thermal-sensors = <&tsens1 1>;
+			thermal-sensors = <&tsens0 10>;
 
 			trips {
 				cpu_alert7: trip0 {
-- 
2.17.1

