Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F7DC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0557820673
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rNYuNnkt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbfH0MPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 08:15:23 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40415 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730015AbfH0MPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:15:18 -0400
Received: by mail-pl1-f195.google.com with SMTP id h3so11698764pls.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 05:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=X1C1wuLpaATs6Y4OlN6hIu56jXxXInO37XE+mmtb07c=;
        b=rNYuNnktdEgs/Igxq0AjJmX1QTMrz9hWnybCHl+0TPcfozu+U8NzY5JOcWQtMOE2GL
         2SYeBJB+LszgzXgips9HGnqCJ/KW5l20CvwubqC2McdZFKg1dndf9XV1E2ZJ5U3VRQzV
         UsuIAB2/I4w5tw6XKFgeqxEgEFXZPptZPaU0HTmirTKQA/F2xeVXFlw3pXFeO4z5YQsm
         rMqwTXYqa+VqoETpmjdTLHeacjJEZEdQW2lJbmdJ3aBjqZDcMQ9/vw5qrN3iXtna4NAw
         QpwLJgz8WZhdYEM0pXxX0BFgmFnQMoS5ZEC22UjgXQd/4bQG8JXUN5dRS3Uv1Xcjqp8g
         gx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=X1C1wuLpaATs6Y4OlN6hIu56jXxXInO37XE+mmtb07c=;
        b=m1IfXhjUKXKcLOYBWTPPnHvF79L7vWh30i7lFwLhwiwCz761Dze3UhG138Fqbe/FFp
         LAqBpO+k/SxV05nA8D4FYXd+xeaIzHeOFFP7KiP5OHa2NpT567c6jcV5COUW/+9gXn5w
         1XqJdITvKs1eZh0PAmgpEpEllFpJllr7jQ2nn9CMyaZF2dQ6SABXFhkup+e45CRy+4qx
         jSbIyQ1rgEyf2W0lfzkHO4sadWPEQFsW5tauB7knOJN5uFYAovKHlYRA/0ReJxxm0OxY
         MfhzmsRfbE9B34qz+6hVnugU4QLqWEnXNIpgK1xnXhXBhxMGWOY+PBAteWsYYQqJXgUx
         rrqA==
X-Gm-Message-State: APjAAAXW8iKqn46Hjnu6lkYlw3Ya4mu6DuOOCgsCRixAG556vsvS/UY8
        C9Yp0TpoGcZ060UvJK1/poUNKaRDvkLt9A==
X-Google-Smtp-Source: APXvYqx/hNWE4nn6DV6gHnrucR81zd5daH4/skNEXcW/Z07C49C4lAbqYfCunzwuye2WpB7FkGyoqw==
X-Received: by 2002:a17:902:7c0b:: with SMTP id x11mr22630033pll.73.1566908116911;
        Tue, 27 Aug 2019 05:15:16 -0700 (PDT)
Received: from localhost ([49.248.54.193])
        by smtp.gmail.com with ESMTPSA id a1sm13719777pgh.61.2019.08.27.05.15.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 05:15:16 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        sboyd@kernel.org, masneyb@onstation.org, marc.w.gonzalez@free.fr,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v2 13/15] arm64: dts: msm8916: thermal: Add interrupt support
Date:   Tue, 27 Aug 2019 17:44:09 +0530
Message-Id: <e9edaeb7b65f98abd226b94e8487dff24e55b44a.1566907161.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1566907161.git.amit.kucheria@linaro.org>
References: <cover.1566907161.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1566907161.git.amit.kucheria@linaro.org>
References: <cover.1566907161.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register upper-lower interrupt for the tsens controller.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 8686e101905cc..c0d0492d90ec0 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -176,8 +176,8 @@
 
 	thermal-zones {
 		cpu0_1-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens 5>;
 
@@ -206,8 +206,8 @@
 		};
 
 		cpu2_3-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens 4>;
 
@@ -236,8 +236,8 @@
 		};
 
 		gpu-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens 2>;
 
@@ -256,8 +256,8 @@
 		};
 
 		camera-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens 1>;
 
@@ -271,8 +271,8 @@
 		};
 
 		modem-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens 0>;
 
@@ -816,6 +816,8 @@
 			nvmem-cells = <&tsens_caldata>, <&tsens_calsel>;
 			nvmem-cell-names = "calib", "calib_sel";
 			#qcom,sensors = <5>;
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow";
 			#thermal-sensor-cells = <1>;
 		};
 
-- 
2.17.1

