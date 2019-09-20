Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665A3C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 21:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B8720B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 21:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UkPMAcEz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730363AbfITVxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 17:53:22 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41423 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730286AbfITVxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 17:53:09 -0400
Received: by mail-pl1-f193.google.com with SMTP id t10so3791002plr.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 14:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=IJ4n28SxZJ7IvqWaQtHl+XJExCPSVNY+ailM0rBB2SU=;
        b=UkPMAcEzknmPEobUG1m2ht5TVb4w78FLI2j/Af1Wr3vK764lh5geyboC9LAdp5eiRN
         F5ZGZkGbwuEaDCfSm1eI9Mj57RlLf5x1hMhb9uFWJbIgbDPVWRpKES2f0wik07jyzbTa
         UJLl5shheFc/rt8fz1CDmLD397PCBXGNFg/UuSE5vKo6bdA0isg3kqA6NI65VSMNNUn6
         GtxXbLp3nwCTZYPsKMZjs27//U4GZmoQczgzrtF3ODLiUnmOr6WZAlFNsNuwlKlcFvLo
         i7VUbfsEBAzi50canqRVxcl5gpYvpP7WrAa2+KPoGhzedD8mbSzYWoWrH8SMtkwzGjmM
         Fc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=IJ4n28SxZJ7IvqWaQtHl+XJExCPSVNY+ailM0rBB2SU=;
        b=pOzBCN8Pco870PsSch1f9dMogwElp4RlPQ6elHvrpgGok5TUKTH48tKo8MQE6ISl2Z
         ue79rjWuq0ILUuzbCZzj5Q8jAMxfkfZimpWJ2Eq3ECvTgFDa3WyWALuMkzGT3HySzeFN
         VbmGP78LVawZyc0tDrVAfYl/7Ij6RTVVK2tf5X1jYADhefbXodhYKnzruJjBCjqojAln
         Kj0L8ptJOlbX9UkCLqBvlObd8fIU2alja+BGQcujNrkOX2Kd01lt/zqZariBu4pHHPUR
         UI6aaCrHvdSEurJ5k4pJtsYieZ5j7LbK0Sj3SE9Ge9CGE/XVsCO/QBRzEERiwjhkltkV
         hm8w==
X-Gm-Message-State: APjAAAWJPggNlom9YlNoMq7pJ44YghUjLLsVtlawdwlZ6aM241wmPAwG
        h7eF6+sJcWE0He9c2erE59a80+FGuJEfmQ==
X-Google-Smtp-Source: APXvYqzG7U1aL8tIVAvBMs6yk5P49LjNAvfvYTQh5PyzsYoymOxO58Ob+qhrVNRVfkS9+je+PRAKkQ==
X-Received: by 2002:a17:902:7886:: with SMTP id q6mr19843551pll.323.1569016388887;
        Fri, 20 Sep 2019 14:53:08 -0700 (PDT)
Received: from localhost (wsip-98-175-107-49.sd.sd.cox.net. [98.175.107.49])
        by smtp.gmail.com with ESMTPSA id f6sm2910546pga.50.2019.09.20.14.53.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Sep 2019 14:53:08 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        masneyb@onstation.org, swboyd@chromium.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v4 13/15] arm64: dts: msm8916: thermal: Add interrupt support
Date:   Fri, 20 Sep 2019 14:52:28 -0700
Message-Id: <ad7330500865ad0015baac52cbedc0abd3929841.1569015835.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1569015835.git.amit.kucheria@linaro.org>
References: <cover.1569015835.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1569015835.git.amit.kucheria@linaro.org>
References: <cover.1569015835.git.amit.kucheria@linaro.org>
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

