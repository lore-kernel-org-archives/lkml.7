Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B8BECE588
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD86E217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lODSxo7Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389843AbfJPHfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:35:00 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33683 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389616AbfJPHey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:34:54 -0400
Received: by mail-pg1-f194.google.com with SMTP id i76so13769111pgc.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 00:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=G1RY5BCmh8InAkONRa9lruWuMsHWqlSh2+WDeebx0SM=;
        b=lODSxo7ZxvWcubnc5SEpK4ryfBPwi14FfHXfQYhOaxz7Brdfim0EBj1fVz5tZRhKoq
         NA1lLeVAB09CXo88wcCR6NXmhZb358RV5aBo/W05sbX3efRkG9aW+EoJh8Ma1PK2fQPn
         oZ1Cybsyd6aLYDMX9C7ttP2XslA5YHLQ+d9UFntN8RdHxS4wKzbJH3aJCbr7bVu1cBDj
         WXIshUbBK99+48KKckgm0HKdk+5v+fvruQ5ZK82wP4Drb442Z0EEeK3KGVxJuwABQ1h6
         htgqxn6HFmQ4NRAEaNLNz8kRy60QQB6Y2H7E24BvlIgAv4v4+tXnneYZ4dugwjUVDM4O
         ggjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=G1RY5BCmh8InAkONRa9lruWuMsHWqlSh2+WDeebx0SM=;
        b=Cv+faeAUqq6P7+7uKs8tycqqb76CNDVJEHa4nR6nSfbp8hqwdCA1XQEZ5U4nfEBb+t
         dxHToKWpTLl+RCOw70Bu2JL8r00jmMBVONxKmEaQ3+M6gw4C7/FvQ2m6gFCgu3HGZcKh
         Q2LTHXDXEsdZpdRX1cN0Xs2UD0OuD0GXNj+ieICJtVE6u+HK8W1G/SJAv9BWZL0RTDen
         T2FBqa5VexgV81V4qq9QoR3V8iheaYJz+bzRtVicodI1vJIUCX/PdyOv+judXxH5JoPh
         MB4vojiycSSFcKOOVZx711+41GgM+OM/kLshAZrtd8vwEl1nF4cfPbUfMdas8ezmcaeZ
         ygAA==
X-Gm-Message-State: APjAAAXYXFDHne3lyRE/pOFR4FQRB5hihd69N9xYzYgAxG9CvgJCdMER
        wiBjokPHZ2OhrvnWkEMDKebBr6cYiWD/yw==
X-Google-Smtp-Source: APXvYqx6ALer2hP+7QwyzwctNf2eyTUeZT1Wmtj/R9DCSe21NV7few4ITXC31vMMCodxgq0uplxdpw==
X-Received: by 2002:a17:90a:266e:: with SMTP id l101mr3329480pje.104.1571211292153;
        Wed, 16 Oct 2019 00:34:52 -0700 (PDT)
Received: from localhost ([49.248.175.127])
        by smtp.gmail.com with ESMTPSA id s3sm1536452pjq.32.2019.10.16.00.34.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Oct 2019 00:34:51 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        masneyb@onstation.org, swboyd@chromium.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH 08/15] arm64: dts: sdm845: thermal: Add interrupt support
Date:   Wed, 16 Oct 2019 13:04:07 +0530
Message-Id: <5a96df48e546576f90081bbde218e7cff88ae8ce.1571210269.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571210269.git.amit.kucheria@linaro.org>
References: <cover.1571210269.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1571210269.git.amit.kucheria@linaro.org>
References: <cover.1571210269.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register upper-lower interrupts for each of the two tsens controllers.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index f406a4340b05..0990d5761860 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2950,6 +2950,8 @@
 			reg = <0 0x0c263000 0 0x1ff>, /* TM */
 			      <0 0x0c222000 0 0x1ff>; /* SROT */
 			#qcom,sensors = <13>;
+			interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow";
 			#thermal-sensor-cells = <1>;
 		};
 
@@ -2958,6 +2960,8 @@
 			reg = <0 0x0c265000 0 0x1ff>, /* TM */
 			      <0 0x0c223000 0 0x1ff>; /* SROT */
 			#qcom,sensors = <8>;
+			interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow";
 			#thermal-sensor-cells = <1>;
 		};
 
-- 
2.17.1

