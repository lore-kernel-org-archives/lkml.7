Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07C0ECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 07:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2560222C1
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 07:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L3wGd7LB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbfIKHRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 03:17:05 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36339 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbfIKHRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 03:17:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id y22so13115419pfr.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 00:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=3aqllZnhirWen18NJ9rLavBCP+/YOWA9zZa8CCtZyTg=;
        b=L3wGd7LB0bierPG9sbQdy13pJdxcVz2jCSo3BbxJYYWTs+0POADWJOxwUle/17TUzo
         nqLzYwD7X/sDwdnvK0tGeWCUrP5jVynB9yFyIiRf+/k46QIGkYxJmLeiedtivkGraazl
         i3nqMnWRkTPMiDBcLXyLkP+HbwVzO+u2wLRHtnzRxLKNkO5MHbk/k2q9v118eDi/ikPt
         zHlHdbNtsXVBE0hkfKlWJsAG5RlNxGxH72czlbwKJBqh0gVWQDsB+dVFrNhRiVqgmu0c
         +Z1d9pdiyZA+uVLxRAKVFrGN1NJohaQMQlasvruHAqtTBXLiFWOBJKSD6X+8gUiKo/NS
         ZBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=3aqllZnhirWen18NJ9rLavBCP+/YOWA9zZa8CCtZyTg=;
        b=JSmyxLYfQnr69a/p4Db1ScGRIK+43aZFX5fQ3mqrNQ4G8MByXyU0Q77vv21vRr9kZs
         ugbXCrRryhUb+i8JaUKd+ZEyGvX8UKXQltRAZk0C0LSyHmqVimMmvbvhPtZkGKuJyduk
         XZcOLQ2DTsykeNhIB+75VEW4ZblEITdZseawADtZQLw/Av4CQ1wmFJtjfQZYUMPwrIqZ
         UADdl5obGCVJHX6ix7AZ4rZSVoAstW1QZEgo36fFkzl/92gx+d99BKUcwtjQOc9jK8ru
         OffplNdQp9y66XybnzuSVB7G+ctPKbdwVcIvswIsdBdqDsK31PoJjKYZYmcvHpLSMisc
         L9+Q==
X-Gm-Message-State: APjAAAXSVJYE7gRR6BJDGcUmrOrya9BxuFrl8CqeskGRMnSY+YEBHlh1
        R00m6EgzLOHJ5olZEnKdERAZFAG76KdAKw==
X-Google-Smtp-Source: APXvYqwLGTmWnztX3+l4zBFHblSob682uzYu6tFIpr+t1m6e9BiXASPtmZln57+ZOh2b7p1jNtkysg==
X-Received: by 2002:a62:15c7:: with SMTP id 190mr39946864pfv.107.1568186222731;
        Wed, 11 Sep 2019 00:17:02 -0700 (PDT)
Received: from localhost ([49.248.201.118])
        by smtp.gmail.com with ESMTPSA id b10sm152893pjo.1.2019.09.11.00.17.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Sep 2019 00:17:02 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        masneyb@onstation.org, swboyd@chromium.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v3 06/15] arm64: dts: msm8916: thermal: Fixup HW ids for cpu sensors
Date:   Wed, 11 Sep 2019 12:46:23 +0530
Message-Id: <47305ec06a4b76a79aa073e4c0202a27a853a700.1568185732.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1568185732.git.amit.kucheria@linaro.org>
References: <cover.1568185732.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1568185732.git.amit.kucheria@linaro.org>
References: <cover.1568185732.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

msm8916 uses sensors 0, 1, 2, 4 and 5. Sensor 3 is NOT used. Fixup the
device tree so that the correct sensor ID is used and as a result we can
actually check the temperature for the cpu2_3 sensor.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 5ea9fb8f2f87..8686e101905c 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -179,7 +179,7 @@
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
-			thermal-sensors = <&tsens 4>;
+			thermal-sensors = <&tsens 5>;
 
 			trips {
 				cpu0_1_alert0: trip-point@0 {
@@ -209,7 +209,7 @@
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
-			thermal-sensors = <&tsens 3>;
+			thermal-sensors = <&tsens 4>;
 
 			trips {
 				cpu2_3_alert0: trip-point@0 {
-- 
2.17.1

