Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A1AC10F05
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D472183E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H57jkGuk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbfC2KNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:13:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34097 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729106AbfC2KNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:13:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id p10so1896023wrq.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 03:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=vvH6TxvABMt17Q7J8MfZHqwxVAuEjNaW4KGdEaboHS0=;
        b=H57jkGuk0D29CiXmW88I/aT2HO823+vuj3EiitBm7MLZeWixvlewjVEx3WSCzbGUwY
         O8wT03ne/Nb6t4+uH+csM0WRuQPFdGBpHx3JNFtsErUCsLU4qLpbCvf6d7hxEBpNYJUm
         6ujVwHEf14wKZTaR4cLaWYbB8DbhjOoWuQT7H8371bpu41H2Atr6KO5joHrdAthOyHFi
         LZBSmLrIqVzEuedms/zbPlAYL9+/2q+hmHjyToJ/TJ6ELD4gCGuGv8WiQHGDsI4qthZc
         uKMTRUGFlOjzCxznxTvF3YoIw+T2koUdqpudEHE8GY5aH2xtqIy4bg9EDGsxoqjJvamn
         zIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=vvH6TxvABMt17Q7J8MfZHqwxVAuEjNaW4KGdEaboHS0=;
        b=sv8327Cj0iuGQYeocOHcpozX9IXQxMkuwDWJw4AAT1boupHSwPKIbb+80//WZzS6wb
         zp2WkwROgrm8PHL35rNmMWnP8seuVUnjsjfhOSYNJ3pupU/xSgWCGrKUi6ThyVsOTWfA
         nyy4KdPP6XgaDc/NysJjkC7qhXUquHKgUfT9lIRtJboaTzf7ZzyyfWwBp2id/lsTyA1y
         21MFojZmOGP5IxIigQKlqq3qNiDdrpPIPy8vVkT105K0Ri3LlMk2pVRIGM0KCECVP/8w
         DAIV4jzR2NvqzYbH8eNvpdN99WlLX67P4/c5dkLL/nwDLQfmJ0Y/Qor7iiVUcmcwto8g
         2HLA==
X-Gm-Message-State: APjAAAW45HUdtkfylyuAPsBIvJJ05ELFb//SsBTV1ZGJTHlf6HpxnV5h
        o7wpk3OrBEttqbqVNNc6mzgSYqIRfBg=
X-Google-Smtp-Source: APXvYqzR392m7p/Q6WhJ0sidAsA/06uDhwjuzaMkQrqni+fnkpz+quvufSHFbgdJWZGDYM6ByM7wMA==
X-Received: by 2002:a5d:5190:: with SMTP id k16mr13275120wrv.10.1553854385649;
        Fri, 29 Mar 2019 03:13:05 -0700 (PDT)
Received: from localhost ([49.248.196.175])
        by smtp.gmail.com with ESMTPSA id h84sm2260804wmf.15.2019.03.29.03.13.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 03:13:04 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, David Brown <david.brown@linaro.org>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v2 06/13] arm64: dts: msm8998: thermal: Fix the gpu sensor number
Date:   Fri, 29 Mar 2019 15:42:12 +0530
Message-Id: <bd149a8d65febe5ef1e98c3db38536039764fa89.1553853990.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1553853990.git.amit.kucheria@linaro.org>
References: <cover.1553853990.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1553853990.git.amit.kucheria@linaro.org>
References: <cover.1553853990.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPU sensor is sensor ID 13 on controller 0

Fixes: 4449b6f248d9a1 ("arm64: dts: qcom: msm8998: Add tsens and thermal-zones")
Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 108a5aa146a2..56ca9ecdb0bf 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -510,7 +510,7 @@
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
-			thermal-sensors = <&tsens1 3>;
+			thermal-sensors = <&tsens0 13>;
 		};
 	};
 
-- 
2.17.1

