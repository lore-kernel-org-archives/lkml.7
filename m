Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADD3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3572070B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KkLs4yE4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbfC2KMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:12:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38987 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729000AbfC2KMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:12:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id j9so1870317wrn.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 03:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=/lEw2WJIQYdMZsFOVD8QtaZ94Qz62D3Eglt9Vc/R/YE=;
        b=KkLs4yE4PyAr+Yl1regGK7dtXQO096QUH7ZsFUL/hY034MN4bhzXJlWdS+nA2ZD2R6
         XGhjd5+Ak3r17le6xL59ByNnqVO0czpMJMlma2BaKZQ5ALm+C5KlAFsx3eEXCV+vjjh8
         4G8P/GtqMAq368GPHCzUmuzUcPikcQS0/+ndm0OxZYNGgR+d7FYDHTxwuDfR832rJk+b
         s5CvoCGf9zm8wyLtravwWTre6C50nunJnLcpQh/WEkiYyLW46gedIf+yrG9W5GwJDbUM
         H5OcHfcleHY11r2iFkROF1cyPicEenEHNL9E0vLYXlWJOTWhk78urdhZYRoDcgSNhDAQ
         Au+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=/lEw2WJIQYdMZsFOVD8QtaZ94Qz62D3Eglt9Vc/R/YE=;
        b=EDhDZVHKjTGPXn8nwrOjgoeE8SsZhcyVW7Xoj0NoGJiicGGUKXm9EOxOgVdJzj3ONK
         aeUjm2CMXZ7KAKtg25rWs+CXOUtcfmB0WtTYdxmI7WHVIiT9gT0NoMMJiz/UgNCaz33U
         9hOa0dMggZTimGgaYsXhxdTLy/m8IO67fg5eOi3eXYAUmbC3pSMx/eAF4/6ma3zfIAfo
         +14Wj09PfI8u14MSJEOA/i67inKZkJel+a+uSC2SdZL/qPukajbqDrkDVw8tTBjFSQLB
         A3OhalluoVLGwt1zLVtZZTOpsBESJCJeW6klc+pPhz2rPdgq4qc8gtcvigQ1lr5qPmDe
         jIHA==
X-Gm-Message-State: APjAAAXfUtQp5amcbQ0Iu5bEkrZq0zfLyW+KCrtD5RJccX/5CB1z3Q0U
        50AQWAMjTE+76iyJ2yGz40piGuIwT/I=
X-Google-Smtp-Source: APXvYqwwJ/LLEGH1Pr0MC/8BeRkg0z3t4Yplbrq4oxIxl6Bm7aLpmnzh4KEydM7ATwLyek0jyWG6zw==
X-Received: by 2002:a5d:4081:: with SMTP id o1mr5840015wrp.241.1553854366992;
        Fri, 29 Mar 2019 03:12:46 -0700 (PDT)
Received: from localhost ([49.248.196.175])
        by smtp.gmail.com with ESMTPSA id z14sm2072519wrv.78.2019.03.29.03.12.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 03:12:46 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, David Brown <david.brown@linaro.org>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v2 03/13] arm64: dts: msm8916: thermal: Add sensor for modem
Date:   Fri, 29 Mar 2019 15:42:09 +0530
Message-Id: <0f5d5623be3c60efde8a98b45b2e5808190d3675.1553853990.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1553853990.git.amit.kucheria@linaro.org>
References: <cover.1553853990.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1553853990.git.amit.kucheria@linaro.org>
References: <cover.1553853990.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On platforms that have a modem, sensor 0 monitors the modem.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 0803ca8c02da..c8aa9a0986d2 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -278,7 +278,21 @@
 					type = "critical";
 				};
 			};
+		};
+
+		modem-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 0>;
 
+			trips {
+				modem_alert0: trip-point@0 {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
 		};
 
 	};
-- 
2.17.1

