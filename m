Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3856C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07F72070B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MgnTj6v8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbfC2KMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:12:42 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33165 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728907AbfC2KMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:12:42 -0400
Received: by mail-wm1-f68.google.com with SMTP id z6so9323032wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 03:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=yMk7UlBf/9xSKlIqns7qRwCnHRkwDfcRdV2w4dM4dNo=;
        b=MgnTj6v8T9TOquiXtlbl+r4u2teiTGEDT+R3C/rt+OVrMN4mFSn9AJG4LIIThTeNFU
         vAaO9JB+e9R6PSoKSy8NR/GZzswo6soZXPmjl3yQQ0CLj+yheeRuZa6ExnOV9YDPSBmT
         59Xq+C3lYC61lPdaSf8dZhjug3I6SQ6TF1mYxcUNmrij9OZtTstqeWRo7pbsGdna4729
         aomgKCd8ZPvyDCV5jRGvGu+UmrRi+a1scLIGqLSLPDF2uyXztsgzu4g9twt7HEYDameY
         zw11VSDY+oKcnEpipI2I0ELtEUbz87q6dnhS6MScHslkKwpnxhHJg93K+wZRqRNAwvSI
         c1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=yMk7UlBf/9xSKlIqns7qRwCnHRkwDfcRdV2w4dM4dNo=;
        b=DVBdxPO9f/UfbTyvYGC1FXVq/Ko0I7CmWRnrf60vrLQtQpb835fUtnaCV4fjkZr8xM
         PAUvjSCs0aBAk99OkiI+5hZ2qxcJLcyLaXHqQ20FB9IzkMny6Je46SM8PxM2Alhi/8/k
         TRqDuORcfnk0SRuGfef1+ydy6jdfRH6OMqs2wi9l05jtHkOmxR1kBvqusynpF/h2T1Q6
         ktFmlNc6+xlNVyFspcB1jopgSZsBGK+Gq8eqqO8DIZiLXN1Cn7w2od7yPONg6RpPmtDt
         1xxsQ0xrkTwkx/kNK4zm6U/WlVzGIvI2OKemrKtmfkcZj+hpxhiKHm1ICSQ5reB3WMPS
         6bRg==
X-Gm-Message-State: APjAAAW2TU32RXhTcEXkuSacLo6tPLBMUoODcAkzjtHWqoqCYcs2UXXi
        /CwtzvqbPIV29CmfkAAyG4YtuDKoSu8=
X-Google-Smtp-Source: APXvYqz+8DZWYx1Z63Pc78Qy1vI3IAW585QzX1p4p77EWVdrWMsrw+VVxHkLwMxu8sPsQhLiBwZWyg==
X-Received: by 2002:a1c:9a41:: with SMTP id c62mr2943482wme.108.1553854360434;
        Fri, 29 Mar 2019 03:12:40 -0700 (PDT)
Received: from localhost ([49.248.196.175])
        by smtp.gmail.com with ESMTPSA id e1sm2904064wrw.66.2019.03.29.03.12.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 03:12:39 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, David Brown <david.brown@linaro.org>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v2 02/13] arm64: dts: msm8998: efficiency is not valid property
Date:   Fri, 29 Mar 2019 15:42:08 +0530
Message-Id: <ccc5ea963b75ce613a11ae77dd4fb42e12bc1507.1553853990.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1553853990.git.amit.kucheria@linaro.org>
References: <cover.1553853990.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1553853990.git.amit.kucheria@linaro.org>
References: <cover.1553853990.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

efficiency comes from downstream. The valid upstream property is
capacity-dmips-mhz but until we can come up with those numbers, remove
this property.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index ac25e9142cbd..0b6de0c29ee8 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -78,7 +78,6 @@
 			compatible = "arm,armv8";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
-			efficiency = <1024>;
 			next-level-cache = <&L2_0>;
 			L2_0: l2-cache {
 				compatible = "arm,arch-cache";
@@ -97,7 +96,6 @@
 			compatible = "arm,armv8";
 			reg = <0x0 0x1>;
 			enable-method = "psci";
-			efficiency = <1024>;
 			next-level-cache = <&L2_0>;
 			L1_I_1: l1-icache {
 				compatible = "arm,arch-cache";
@@ -112,7 +110,6 @@
 			compatible = "arm,armv8";
 			reg = <0x0 0x2>;
 			enable-method = "psci";
-			efficiency = <1024>;
 			next-level-cache = <&L2_0>;
 			L1_I_2: l1-icache {
 				compatible = "arm,arch-cache";
@@ -127,7 +124,6 @@
 			compatible = "arm,armv8";
 			reg = <0x0 0x3>;
 			enable-method = "psci";
-			efficiency = <1024>;
 			next-level-cache = <&L2_0>;
 			L1_I_3: l1-icache {
 				compatible = "arm,arch-cache";
@@ -142,7 +138,6 @@
 			compatible = "arm,armv8";
 			reg = <0x0 0x100>;
 			enable-method = "psci";
-			efficiency = <1536>;
 			next-level-cache = <&L2_1>;
 			L2_1: l2-cache {
 				compatible = "arm,arch-cache";
@@ -161,7 +156,6 @@
 			compatible = "arm,armv8";
 			reg = <0x0 0x101>;
 			enable-method = "psci";
-			efficiency = <1536>;
 			next-level-cache = <&L2_1>;
 			L1_I_101: l1-icache {
 				compatible = "arm,arch-cache";
@@ -176,7 +170,6 @@
 			compatible = "arm,armv8";
 			reg = <0x0 0x102>;
 			enable-method = "psci";
-			efficiency = <1536>;
 			next-level-cache = <&L2_1>;
 			L1_I_102: l1-icache {
 				compatible = "arm,arch-cache";
@@ -191,7 +184,6 @@
 			compatible = "arm,armv8";
 			reg = <0x0 0x103>;
 			enable-method = "psci";
-			efficiency = <1536>;
 			next-level-cache = <&L2_1>;
 			L1_I_103: l1-icache {
 				compatible = "arm,arch-cache";
-- 
2.17.1

