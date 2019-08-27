Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5048C3A5A4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8951020673
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cp6897F1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbfH0MPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 08:15:18 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45326 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730009AbfH0MPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:15:13 -0400
Received: by mail-pf1-f196.google.com with SMTP id w26so13984408pfq.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 05:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=oICHc/N2fVzNg9SEQ6NvPrxoshVnfXlZhDudW67PQGU=;
        b=Cp6897F1qL6ZQl9NYJzQI0+DCRd0dHQK3Y38hSJNb+Cacsa+FTmIu+DYI3I5U9ZbQ0
         Mgp8BpslWLL5SNJCsPTy5aW8JEnkwER/GyolJxSX30l0RF4UTxEQ4z8SjM/diMLMXDrt
         5I1TiVbi15ciQnGtof3JPw94cZghANLIBmy75WSze+XE7t1gW96FGx+FzKhZeDyy1MpC
         kJ5nEKJ4cZ13x8h7WORXg3ns7nYWu5F26lXoOb+qxt30hgc73Wnc4HUN5xzg07nHArw5
         cbNorbJVFg548rPO7BSxMl//sVXg2KAS38Gm21N5GEg+tcqyFrV4yC74bBWtfsKvjf0r
         rECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=oICHc/N2fVzNg9SEQ6NvPrxoshVnfXlZhDudW67PQGU=;
        b=bG9xa8n6KMumk8FMtFYiBHkfEfuVEkD/3rP2Fju5cMZHf237r9Wdp2CcCKRMU/vUuP
         xry2TKlxY2hPkRFymAVPNzpZ5EzVz7bcK4owdoutnJTOuZzjjDbOHAvmO0w+9jWpTplu
         7pHdPDY6rV8/pKQ6QTzfrc3ifWSKkLzqg6RdhScXEs2AEDvWKZdtGRgKvq/mHeRV/sa4
         tfP/kAigDLB4mTqsCYoF9Hz2fNDnunlr6m3+OZzw4niQ2k6LqvcJFGBcyO2BMa2f8eMX
         wVAdRSQYzNJt0I2Tkp3xjMoOk6m85UKtwX9BinV5LC8H2m3Lq5x48fpasGcOy9us+o8a
         Az7A==
X-Gm-Message-State: APjAAAU+Gl4xMomV2D8uabns22pFmqRfLjkLi+UP/i3Ez3T2HxsaXTNd
        +jwkuBYJF/CPitrjVg+ZHrClsIuRioDI6w==
X-Google-Smtp-Source: APXvYqw08/ZuiQs9CO2XzU2ubVRDh6b0AfuO9ArPxJLQF1TFuaL6QVHqg2guKmzjQPEVJ0liS75zBg==
X-Received: by 2002:aa7:8488:: with SMTP id u8mr26247184pfn.229.1566908112980;
        Tue, 27 Aug 2019 05:15:12 -0700 (PDT)
Received: from localhost ([49.248.54.193])
        by smtp.gmail.com with ESMTPSA id q8sm4785656pje.2.2019.08.27.05.15.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 05:15:12 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        sboyd@kernel.org, masneyb@onstation.org, marc.w.gonzalez@free.fr,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v2 12/15] arm: dts: msm8974: thermal: Add interrupt support
Date:   Tue, 27 Aug 2019 17:44:08 +0530
Message-Id: <383f16c449fb5a36d07ef98c5b071d9a50a86eb7.1566907161.git.amit.kucheria@linaro.org>
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
Tested-by: Brian Masney <masneyb@onstation.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 36 +++++++++++++++--------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index d32f639505f1b..290f7c3827d45 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -139,8 +139,8 @@
 
 	thermal-zones {
 		cpu-thermal0 {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens 5>;
 
@@ -159,8 +159,8 @@
 		};
 
 		cpu-thermal1 {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens 6>;
 
@@ -179,8 +179,8 @@
 		};
 
 		cpu-thermal2 {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens 7>;
 
@@ -199,8 +199,8 @@
 		};
 
 		cpu-thermal3 {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens 8>;
 
@@ -219,8 +219,8 @@
 		};
 
 		q6-dsp-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens 1>;
 
@@ -234,8 +234,8 @@
 		};
 
 		modemtx-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens 2>;
 
@@ -250,7 +250,7 @@
 
 		video-thermal {
 			polling-delay-passive = <0>;
-			polling-delay = <1000>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens 3>;
 
@@ -279,8 +279,8 @@
 		};
 
 		gpu-thermal-top {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens 9>;
 
@@ -294,8 +294,8 @@
 		};
 
 		gpu-thermal-bottom {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens 10>;
 
@@ -531,6 +531,8 @@
 			nvmem-cells = <&tsens_calib>, <&tsens_backup>;
 			nvmem-cell-names = "calib", "calib_backup";
 			#qcom,sensors = <11>;
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow";
 			#thermal-sensor-cells = <1>;
 		};
 
-- 
2.17.1

