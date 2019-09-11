Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D11ECDE27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 07:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF9E222BE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 07:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ahSGl97f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfIKHRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 03:17:30 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36373 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfIKHR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 03:17:28 -0400
Received: by mail-pf1-f195.google.com with SMTP id y22so13116142pfr.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 00:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=IJ4n28SxZJ7IvqWaQtHl+XJExCPSVNY+ailM0rBB2SU=;
        b=ahSGl97fGWSaYEP376oOKRUvzQemigNFfYzPJEDbyo9WNAIjnvccVhzpgfcoFx6tCj
         Kjnz0OJXrlo8BX4DpWjSq2xtErHTYecQSlFmkSrscP/EJUJ9nBRAnHb2C2OE6i1FrD95
         5m4FwSD2bdglb78BkdowdMcQnQ8YmBOBUY0hzfnyrk3bZI/13MVhuooetfyH4I0+R3JN
         bbvAyhoOwZU8N4laiXBsxCKVRJ3JhqLT7/S8bNbKhFZsHgQYMlWarHv0VmNCgkq5R6ZB
         eKhl7/FLRzAv/fFJQHdkdLFXM+nm0TWEFOnGPSZYSl0unAz3CmLjLQhFoNHYBk7li1CL
         KLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=IJ4n28SxZJ7IvqWaQtHl+XJExCPSVNY+ailM0rBB2SU=;
        b=s8rekK2Ma9Vg5lA5Qp8oAZHFxQxV9mCt5RdtO2G8+VYx3GSQP/qbDwoNCbqN2wavSb
         siZU36l8teRQCOK6f547XTLazXUzJCtAnshp1DYMy/Gn7jNzElb6cMhcuOmts7EzDkPb
         fRIkLhyYTqHwOZCD28FaTTcxJpgc0RBDoDICV4LiTyAManC8Uh5LWdEd2U3t8vHz+/PL
         PYVNxwkrahHHbiiQ8HX3/jV6UTcJG4VvSSKRKWFgn47+NR0s5wMrMxJuStDvylMs6sZ8
         uvpMisQBa5PT1IIxddHCQF1ZnbVc7IKgRs1kMl6KffGF2hOeL/MvNcJzRyugoF4atmkQ
         vfsg==
X-Gm-Message-State: APjAAAXI+E6YRCexzL7/CkRF6Nv0d20N3AMZdTQLqnFheMNkHo7rfRwM
        FxgFfAL5HDZC2N9er1ZcYsLaGo3ceQdQmw==
X-Google-Smtp-Source: APXvYqzdkGbLor2RIpKZHz8i39vyE1koinH0m5Pnx17Qg2qLyzSTtigbxB8dtrLdmL2k02u+fYeXLw==
X-Received: by 2002:a63:dd17:: with SMTP id t23mr981886pgg.295.1568186247507;
        Wed, 11 Sep 2019 00:17:27 -0700 (PDT)
Received: from localhost ([49.248.201.118])
        by smtp.gmail.com with ESMTPSA id s97sm1680031pjc.4.2019.09.11.00.17.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Sep 2019 00:17:26 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        masneyb@onstation.org, swboyd@chromium.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v3 13/15] arm64: dts: msm8916: thermal: Add interrupt support
Date:   Wed, 11 Sep 2019 12:46:30 +0530
Message-Id: <29a78d620007af45ed94fa9f3a2199142bae5683.1568185732.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1568185732.git.amit.kucheria@linaro.org>
References: <cover.1568185732.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1568185732.git.amit.kucheria@linaro.org>
References: <cover.1568185732.git.amit.kucheria@linaro.org>
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
index 8686e101905c..c0d0492d90ec 100644
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

