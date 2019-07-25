Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C499CC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 22:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C5BB22C7E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 22:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OJdrO8Nf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfGYWTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 18:19:44 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40318 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfGYWTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 18:19:42 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so23721014pgj.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 15:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=iTUMfB0Wim/a1bz2uuCGtMiuUYFdGiUbnvdD+HL9w8A=;
        b=OJdrO8NfixWF+IfHJd7NkzCiHvqJm5zt41U9YgoUEqvpVfGa6OPD1GxjM6vfwYvCrF
         XYSXsJ2BqjSnZlEd3dP24brGNtsmKEXdi5Nlldeld2mew3YrYN33G2e7hfXoKGCF2wVl
         yT4SZzUxicgQ2bVQs9424GpVZU74Wsl5BW9OpPS0GWn1BrtCJ1ksG3FkUDwlbun+GreU
         u6jhls4NaCCGjj3KDEOk1/On71du2K/CwBGWrTt8c7lOGY9QgDN071p8gf8O4xw26SUg
         0PjFtA+5GPm2ii9otFWj65Bv8DYXcWhidXV3hu5dhZW4hqb92MtcCBxjghS2gEvNdE+L
         l2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=iTUMfB0Wim/a1bz2uuCGtMiuUYFdGiUbnvdD+HL9w8A=;
        b=C4aArdrTIP5nxwMn/uLNoMuCjCMqAZ24Ad94NWtu8pfRbWJy8Ct9IhS+VFeckOoBL4
         pqIMmTT0z4RWiSB6oDfBYV82/h2Kj9Udgxtkm5C33byACSI2sCkKm5MlO/9nijONdwIq
         rR0aDRU/b/GPjrYD211FS0iY3T9SZiado9e+P6PG0Hkih0rJSgINvgsr1WdyMZV1CQLw
         4vUHoFqaurF7jVLG3DVx3MBMuyHnqYAL1rx3UIKUWkFRRz+px8mbn3AADZRD53Sn84wM
         STgpCaOgLb3/bGYs9dF1UZ1rBBHOZ+2mNu7kdXt175MxH2myXVsKNY7JNVAvgytbwh8s
         vdEw==
X-Gm-Message-State: APjAAAWXEAjjQ8WwW688gtE5jv/LN3c1zHqHOEMDURTEhXGOoR5mN+fm
        5IejvfQf1aHS22X8HXKO+vvVZrpvDEj1ow==
X-Google-Smtp-Source: APXvYqzF1V9+SxncxFYk5Y9e1ZK32fvYi3mBx4m9IH+3pz3WMFf5tycnnyww9qSOytMe3gAM46e5Mg==
X-Received: by 2002:aa7:8817:: with SMTP id c23mr19090975pfo.146.1564093181321;
        Thu, 25 Jul 2019 15:19:41 -0700 (PDT)
Received: from localhost ([49.248.170.216])
        by smtp.gmail.com with ESMTPSA id e10sm51975982pfi.173.2019.07.25.15.19.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 15:19:40 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Andy Gross <agross@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     masneyb@onstation.org, devicetree@vger.kernel.org
Subject: [PATCH 12/15] arm64: dts: msm8974: thermal: Add interrupt support
Date:   Fri, 26 Jul 2019 03:48:47 +0530
Message-Id: <ec8205566eb9c015ad51fbb88f0da7ca60b414fd.1564091601.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1564091601.git.amit.kucheria@linaro.org>
References: <cover.1564091601.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1564091601.git.amit.kucheria@linaro.org>
References: <cover.1564091601.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register upper-lower interrupt for the tsens controller.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
Cc: masneyb@onstation.org

 arch/arm/boot/dts/qcom-msm8974.dtsi | 36 +++++++++++++++--------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index d32f639505f1..d10d47d20ab8 100644
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
+			interrupt-names = "tsens";
 			#thermal-sensor-cells = <1>;
 		};
 
-- 
2.17.1

