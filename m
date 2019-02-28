Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36683C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E322083D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="liqYSAAa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732281AbfB1M2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:28:14 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50320 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732069AbfB1M2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 07:28:12 -0500
Received: by mail-wm1-f65.google.com with SMTP id x7so9004535wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 04:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=aLsMVwtpgSOaGBz4AILnRl4PUyhZEZVIsjfHxCwTaGk=;
        b=liqYSAAaRLAxjf7E18Jg20APdR6ztu6B4pKk1U3HBLgv6nlh82wSfLAPzNfPn/zgSi
         aTPD4d2HPqVKHIp6PhSxktLepegSGSCiD8kgxm1kH8Xj8wxaJS9Y43ilCOYL1n2CSqjA
         G/uRdoLH2fRFpLmOC7YDy/JE0RhpyZGEfAs5NrJREEAe8LiOzfoQOG4hlktWsfnd8B0T
         PGiU5zU/0hpe2RNmDadTp4XyhJVisjZ6RghX9Nu3hJyU6PnZ2uAwMoZbWy0PnnEIiHgZ
         lc8ov+A5efgF9rCl9e6fZ801rasqNGRSa9mIvrHbSdOCacsPxPYAQ714sMebcCExcM2L
         uwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=aLsMVwtpgSOaGBz4AILnRl4PUyhZEZVIsjfHxCwTaGk=;
        b=acNyHe7ii4H10A1DIXlYvVv8QgVyI9JZRDLOrX1mUOkvt1v/XN1m09u4ZrY+zyeUyH
         7yUC/dN2KkixXcN6C8p4FpY8Yiyw5ahNQs8oT+ZzlFXqsPwOTnj1iwyNcP/VXhbAP7XA
         6bWqr2BzfkjXhtrjkG9DtavSQv7DvP0eh2gxwOykTY9KABGZ69EBNIDhs2oB/Fj65bDk
         O/ZfFL5IM5+sihwyC+357mZQFLNyz+xS6WE0bsdoyZNtSEvrH0vT2ztvDxBZ/LO0VEDK
         ehNyNtNP4p5Cm1tbPQLDRDospc84zhcIRckUp0uBAeTRr1CN78ntcUXLW4OGXkb1fLn4
         /xeA==
X-Gm-Message-State: AHQUAuYt9Ho8hh2A0zKuHYNPsoJAqsjL6KABFjULx/KV5Io6EJHpaw7N
        4VUkvf/atxn8a1WNVBWgMUkZ3aX6VtY=
X-Google-Smtp-Source: APXvYqy5lSppSZKs9iS6iPx8zAHounSgwtuTkG7qMc4oqyzBOJlxs/K59JS9oIFk/ffQcR1/weNmRQ==
X-Received: by 2002:a1c:2947:: with SMTP id p68mr2789122wmp.104.1551356889992;
        Thu, 28 Feb 2019 04:28:09 -0800 (PST)
Received: from localhost ([49.248.54.130])
        by smtp.gmail.com with ESMTPSA id h62sm4760705wmf.11.2019.02.28.04.28.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 04:28:09 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v2 22/24] arm64: dts: qcom: qcs404: Add tsens controller
Date:   Thu, 28 Feb 2019 17:51:12 +0530
Message-Id: <59921d5433cb82e79e5ef9d70218beb5230f80ea.1551355503.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qcs404 has a single TSENS IP block with 10 sensors. The calibration data
is stored in an eeprom (qfprom) that is accessed through the nvmem
framework. We add the qfprom node to allow the tsens sensors to be
calibrated correctly.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 9b5c16562bbe..57d14d8f0c90 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -253,6 +253,16 @@
 			reg = <0x00060000 0x6000>;
 		};
 
+		qfprom: qfprom@a4000 {
+			compatible = "qcom,qfprom";
+			reg = <0x000a4000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			tsens_caldata: caldata@d0 {
+				reg = <0x1f8 0x14>;
+			};
+		};
+
 		rng: rng@e3000 {
 			compatible = "qcom,prng-ee";
 			reg = <0x000e3000 0x1000>;
@@ -260,6 +270,16 @@
 			clock-names = "core";
 		};
 
+		tsens: thermal-sensor@4a9000 {
+			compatible = "qcom,qcs404-tsens", "qcom,tsens-v1";
+			reg = <0x004a9000 0x1000>, /* TM */
+			      <0x004a8000 0x1000>; /* SROT */
+			nvmem-cells = <&tsens_caldata>;
+			nvmem-cell-names = "calib";
+			#qcom,sensors = <10>;
+			#thermal-sensor-cells = <1>;
+		};
+
 		tlmm: pinctrl@1000000 {
 			compatible = "qcom,qcs404-pinctrl";
 			reg = <0x01000000 0x200000>,
-- 
2.17.1

