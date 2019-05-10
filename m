Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE42C04AB3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 11:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D820217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 11:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ymL3BlSn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfEJLaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 07:30:10 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41757 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbfEJLaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 07:30:09 -0400
Received: by mail-pl1-f193.google.com with SMTP id f12so693932plt.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 04:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=QX6d+2j5rTo6SXyWxTv7coh+9aY0FrKtm56hn7CHowI=;
        b=ymL3BlSnyQUw4ZwTZIV68bfcJZez4YPfZ7fbb46ka4OALV9P1C8awhm1QWKQcNNAkI
         /FKXdVCZROLk4hqWuF2XbVHBttz41l1Sh6/JUhLqbICU4tSpxLpxgLIfNdF7qzlpUtf0
         pu3W+QLbwSiUE8BjQzWRuMCP4teo0eVkBtA2k7MH++Jh6s3yIEJTSBOecJb/Ee4Lzmbz
         X6AgGCHdu3ptcKnxhYuc4syExlnS8PZpT6vLVJWpfCaUMIZaI23zH1rKjeZzFCkljiLi
         KUKaSeg/6sKY99p+h/Lz/WC4CtmsAqs2/ATPyfWkIUjyw3p6HfQD2y0tiZYbakHagI0y
         SvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=QX6d+2j5rTo6SXyWxTv7coh+9aY0FrKtm56hn7CHowI=;
        b=ss6oUm39O2+URgZNFm7JC7JtEK9NAyGO9/SCoDRV3ZAurF3PeYwOnzBpM0M/h3L+7u
         05cWmdm5SmlX0cLLMe+H1tYRTtSMjzgPgL8vznBMTdol1NHquYNkI6Hpet/3MWFxDGLY
         FMv+Ti1UELWD/KyybWxr9T8fyZTtgUIa8/NS4T8etN6LIQKP611qGWwKndgWNXVo9mqA
         tTZJJVJDnQyjRhAy6iLaBm9C7SaTjhnIxKsDpqRXjcn1dtUm2p/mhK0Ramyju/Ou0YrW
         NNleYPMuYbdjhfFS14SQRBF0NUW1JB0jfuNH/8uxOqj0b+4HiMYbbditEejUXJigTRkB
         rzOA==
X-Gm-Message-State: APjAAAWcQNMN49LbxoeGh65bakpOu/EzI4bc00sr8FtZDTZn04bNrCrO
        1KjdGH6wrQ35v0o5h+jt/DyyJBcpsAk=
X-Google-Smtp-Source: APXvYqwVFyUQNGSTFCnt5pCdMiU+jr9xhkNVSK1jl4WxMHv+dE8Y701YC8NfFCk8t9Y08kBmTnCsSw==
X-Received: by 2002:a17:902:7682:: with SMTP id m2mr11970974pll.68.1557487808815;
        Fri, 10 May 2019 04:30:08 -0700 (PDT)
Received: from localhost ([103.8.150.7])
        by smtp.gmail.com with ESMTPSA id g72sm13935671pfg.63.2019.05.10.04.30.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 04:30:08 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        David Brown <david.brown@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Cc:     devicetree@vger.kernel.org
Subject: [PATCHv1 4/8] arm64: dts: qcom: msm8916: Use more generic idle state names
Date:   Fri, 10 May 2019 16:59:42 +0530
Message-Id: <2a0626da4d8d5a1018c351b24b63e5e0d7a45a10.1557486950.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1557486950.git.amit.kucheria@linaro.org>
References: <cover.1557486950.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1557486950.git.amit.kucheria@linaro.org>
References: <cover.1557486950.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using Qualcomm-specific terminology, use generic node names
for the idle states that are easier to understand. Move the description
into the "idle-state-name" property.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index ded1052e5693..400b609bb3fd 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -110,7 +110,7 @@
 			reg = <0x0>;
 			next-level-cache = <&L2_0>;
 			enable-method = "psci";
-			cpu-idle-states = <&CPU_SPC>;
+			cpu-idle-states = <&CPU_SLEEP_0>;
 			clocks = <&apcs>;
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>;
@@ -122,7 +122,7 @@
 			reg = <0x1>;
 			next-level-cache = <&L2_0>;
 			enable-method = "psci";
-			cpu-idle-states = <&CPU_SPC>;
+			cpu-idle-states = <&CPU_SLEEP_0>;
 			clocks = <&apcs>;
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>;
@@ -134,7 +134,7 @@
 			reg = <0x2>;
 			next-level-cache = <&L2_0>;
 			enable-method = "psci";
-			cpu-idle-states = <&CPU_SPC>;
+			cpu-idle-states = <&CPU_SLEEP_0>;
 			clocks = <&apcs>;
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>;
@@ -146,7 +146,7 @@
 			reg = <0x3>;
 			next-level-cache = <&L2_0>;
 			enable-method = "psci";
-			cpu-idle-states = <&CPU_SPC>;
+			cpu-idle-states = <&CPU_SLEEP_0>;
 			clocks = <&apcs>;
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>;
@@ -160,8 +160,9 @@
 		idle-states {
 			entry-method="psci";
 
-			CPU_SPC: spc {
+			CPU_SLEEP_0: cpu-sleep-0 {
 				compatible = "arm,idle-state";
+				idle-state-name = "standalone-power-collapse";
 				arm,psci-suspend-param = <0x40000002>;
 				entry-latency-us = <130>;
 				exit-latency-us = <150>;
-- 
2.17.1

