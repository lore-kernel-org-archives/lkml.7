Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18934C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCD7D2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vHdkqr/m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729200AbfC2KNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:13:16 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52621 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729173AbfC2KNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:13:14 -0400
Received: by mail-wm1-f65.google.com with SMTP id a184so1908299wma.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 03:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=NNvC9n1z8PdtdpApwkNWkA8fQEaFhqvpx19ozcs0aPs=;
        b=vHdkqr/mXHVgwz2jYU0rz/ISRvP7xzfrHDVcrzth1TTCpJ+lChaTFzhMD5HIouKLD0
         N1r9W30df22N2U8lVsALu4ygogSwzZ0D9zJ6Bk71W5Rs0eTtYUsrHAmfQGegETYqnEJK
         qWKRuhqFwZhC/ACoM1e3FE6CDolu4y1+bnoGYZZH2oWs7x9knJOzS0efd12qaC4oWd/g
         XAtke53kyTq1TEQMEaYH5iaV2g/T7lG9sBmpQ25KCW6s13k/93Hszb1Z8FVtJoW4n1Pw
         yWgIdyWnzUt6O6a21jz6YliK4P+XzhPj46uTb1h1EI0aRnCyKO+rsi1gBobicrmz0JA+
         yIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=NNvC9n1z8PdtdpApwkNWkA8fQEaFhqvpx19ozcs0aPs=;
        b=pi1IXV3+HJrbiYxHasQ/dFmfxDCjRcVD9Fr5FNLPxI7NRlJCAgYD418RUrkccgdHjR
         LDaadTdN1L6nyTBtUTVeBgdnDuU89wfRa100imTfxTfePsiEHgEWJ5xiBNK9tMOkKp4N
         BgzNg6jcxYTpyXIKfUiEZRIR2Og6WRlyp21T/WNpEZJmQ+CFBZ8XsucLMhKt4noY8oNk
         4HaHudienThuaBZMe3oT07L8Uz+BRpLPYS9UQFjvjwv2aV+3t27cZ5203ZGl9HSgnbAE
         u2wTqWWZW7kp32jejkdO3DCqUGOIstTHiOuyb1rycworPdHAN0nPlllMPejxsBBI1K2z
         V+sw==
X-Gm-Message-State: APjAAAU1/yCvTrJ+3VBXQP9edG8Uco1EJNHBDClvEzDWbcVtrL++IBDx
        wOfDigaleq+7wYzRUgvsQUp+14zQzPw=
X-Google-Smtp-Source: APXvYqzye2FJMjtTrJ/KGXxcO1kz091v2GTbmA0lRV/q5hH0or1UZy7a3FrZO4eBj3STT2bRtMxnfQ==
X-Received: by 2002:a1c:1d81:: with SMTP id d123mr2862060wmd.59.1553854391757;
        Fri, 29 Mar 2019 03:13:11 -0700 (PDT)
Received: from localhost ([49.248.196.175])
        by smtp.gmail.com with ESMTPSA id d7sm1648941wmf.31.2019.03.29.03.13.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 03:13:11 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, David Brown <david.brown@linaro.org>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v2 07/13] arm64: dts: msm8998: thermal: GPU has two sensors, add the second
Date:   Fri, 29 Mar 2019 15:42:13 +0530
Message-Id: <7af19b6468b6e10f0a24c40b7a467a71ae9bee65.1553853990.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1553853990.git.amit.kucheria@linaro.org>
References: <cover.1553853990.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1553853990.git.amit.kucheria@linaro.org>
References: <cover.1553853990.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first sensor is on top and the second sensor below the GPU

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 56ca9ecdb0bf..b368da235663 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -506,11 +506,34 @@
 			};
 		};
 
-		gpu-thermal {
+		gpu-thermal-bottom {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 12>;
+
+			trips {
+				gpu1_alert0: trip-point@0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		gpu-thermal-top {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 13>;
+
+			trips {
+				gpu2_alert0: trip-point@0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
 		};
 	};
 
-- 
2.17.1

