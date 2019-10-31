Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6772DCA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 18:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E9022173E
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 18:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gFcDJKmd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbfJaSic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 14:38:32 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36016 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729496AbfJaSi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 14:38:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id v19so4966144pfm.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 11:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=4K812X2lC+GYM/4odmaRwgr1rxs2vpAuXCpq25weRAs=;
        b=gFcDJKmdzDCTCrN5Bqc0J9Wxg5iBuZks5LfR8jEOR51AqOkrUdSqL2jW9DO736IDrR
         5kv5ZKmMWMllB9GeqdtlSY8XL+y7S4xPg20W3Ob9XI+/3mrZsHXk/JeF6kMCTbWkL7bC
         jIpqxxlmvlM9gw8JjoECQUwU9rDZT5gWNGBKS2MrHlaT6AKGppA9Txt90Rx3I/D1feJF
         Z15u1LXHS+CPcKr4O+Iac2L4TzMC+V4bzeR83kB/WCL4TzZuw5rr3NHm7C/lUAXFBSbV
         lguSwIuIta+j7mpJ5XPHK6g3yd+NE6JXsZCwEKzpliO3RRCcBLOxggFBIBhLHlS7Gjwn
         MlUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=4K812X2lC+GYM/4odmaRwgr1rxs2vpAuXCpq25weRAs=;
        b=eaCZeOLoLEhmj5MGOIq+t0sPW1ONNvWdypvXoueRli1mz4eUl8tbByyCoyJaRH80xQ
         SbO3/ynqAu34WOopDf8vUaaLdm0r9p1zOb8zdBv4EWFuXvjDkt6x21DK/rkW8N9f7IK7
         XfCq21y8gjOf01V9LYYGmlpaWVkHMoyVIvhYMJwaRQDA3wQs9dUzJUa6T8k6LEpVeN2+
         BXEAlH5+qpB7bEth+vwUrWR6kEca46FXAdzrachT8KHSsntu3xG51W3Ht7XWpGudrB51
         uQq280I6OeGDw9mvIL+LZF99CIix57qkYNss7dWxMwReUVX1PDQO7Mo072cuSP65jYuF
         KKXQ==
X-Gm-Message-State: APjAAAWXuDMwzd7PlXqdyoW3JR8XtiIXc0btlzhhAHZ+5AP/JEFa9dlu
        hIYH0Y1wIg3HYlZFRwQRj5bZh8s1D5+5mw==
X-Google-Smtp-Source: APXvYqyeoW/W8dXSH4nDnIjGLfrMwp0/h37wliaoWJuNcR+4I8coIChV24XnNSEdBVlrcXCcVY8SQA==
X-Received: by 2002:a17:90a:6346:: with SMTP id v6mr9395570pjs.4.1572547108492;
        Thu, 31 Oct 2019 11:38:28 -0700 (PDT)
Received: from localhost ([49.248.58.234])
        by smtp.gmail.com with ESMTPSA id b26sm4073620pfo.179.2019.10.31.11.38.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Oct 2019 11:38:27 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        masneyb@onstation.org, swboyd@chromium.org, julia.lawall@lip6.fr,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v7 09/15] arm64: dts: msm8996: thermal: Add interrupt support
Date:   Fri,  1 Nov 2019 00:07:33 +0530
Message-Id: <b42e18096b81abaaabe1822e75f1882781467c71.1572526427.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1572526427.git.amit.kucheria@linaro.org>
References: <cover.1572526427.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1572526427.git.amit.kucheria@linaro.org>
References: <cover.1572526427.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register upper-lower interrupts for each of the two tsens controllers.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 87f4d9c1b0d4..4ca2e7b44559 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
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

