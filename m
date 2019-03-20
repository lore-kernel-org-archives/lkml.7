Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC38C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9042184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jY9OC/Z6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbfCTNT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:19:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43454 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbfCTNT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:19:56 -0400
Received: by mail-pf1-f193.google.com with SMTP id c8so1915148pfd.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 06:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=qKXF150NnoD6hcYF3ZEcLMoM6yEN8jPT+N985toWhiQ=;
        b=jY9OC/Z6mfCscuQwlqSkewP82zJgv7CWpnTSmleHgo2FrKtoV3ptvqL97VpzbiTwEI
         ZNtbTifHoKSXeXij9/9HwZGFezGjtWGbq2cJgvaTGy4ZpiLfigLW/70WimfaARhyo/Tv
         DoLuBoAtMHC7QhoxFwIa2LbT9vu3KKfgWxwyEqEUwtU8YpIz0xoOhquRmFMCUDyRl3gD
         49xzbj/gIgkrfZGuLZkJsrWJ/i5Cls0T5e5rTzc4GSsxpmTSQhhnby4J06X9vHyg7XCF
         osz+lzlU3BQG7zX0twU7PFkPIOdcgTbksCs3zCE7Qoz5D25kt2Xd8af64qsViQzh4ZAX
         AaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=qKXF150NnoD6hcYF3ZEcLMoM6yEN8jPT+N985toWhiQ=;
        b=hHKp4n/W0Rw1JBd8Edh9Sar2hIdcBJ/0zbDdzkDhX7kd2wDgPtiZyti170hb7mVeNb
         cg0syfp18lxV6W9VJSxpsbtvJhOhHoRKssRmEX9LdpBDWBg3jJdJLgjpe5/hc6mxAooG
         NjlOZ2tgdqRhQPh58H2Ui+c0O7wh51Zt3OQK7tg8iLUi1ul1XVBpI+2G6eBkSrBmIW6r
         icKrzGCtFswAN4aY0R5F/LgTUNiRELN/DDNx3thccUbqn4xQTCB4SaHV8U+oEsjIutTa
         WIxfjDkCQy92NpPthnRqC7I/GJmXUEW+yBAfdxvrnvv1qNNqnE+1e/ySjkDbVYm55tsq
         5GWw==
X-Gm-Message-State: APjAAAVaDOmwYSETYu7M+Y67JEAbfFNU9PSUFXWnL8qDbrdGxExKQA39
        MIatwJ9aAkv3Wej+ILmcaw3F2KduG20=
X-Google-Smtp-Source: APXvYqxz0UegrVHveHgDSEx6nF8KGAopmxtg/BvzmMacHjUpaKd19eBkAjlC5JCXR4AXC8c9DeGqWg==
X-Received: by 2002:aa7:9088:: with SMTP id i8mr6087166pfa.118.1553087995113;
        Wed, 20 Mar 2019 06:19:55 -0700 (PDT)
Received: from localhost ([114.143.122.221])
        by smtp.gmail.com with ESMTPSA id l28sm6945655pfi.186.2019.03.20.06.19.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 06:19:54 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org
Subject: [PATCHv3 21/23] arm64: dts: qcom: qcs404: Add tsens controller
Date:   Wed, 20 Mar 2019 18:48:01 +0530
Message-Id: <9108372823aba9288b98b1c8a003c21b578d1e13.1553086065.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
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
index e8fd26633d57..7881792980b8 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -259,6 +259,16 @@
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
@@ -266,6 +276,16 @@
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

