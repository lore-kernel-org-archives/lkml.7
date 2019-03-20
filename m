Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38717C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08FB02184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mmmgr5nz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbfCTNkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:40:11 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46882 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfCTNkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:40:10 -0400
Received: by mail-pf1-f196.google.com with SMTP id 9so1714048pfj.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 06:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=rvHnmZw/liQW94gjtXrCFd/1cgko4DZ3dzHWakfqGUM=;
        b=Mmmgr5nzfWZXkqiKLKcW8/xIzhnin/O9stc4o0X0c4pxDVgSWz/+JUNeKCHQ+btE0z
         R5/Eum8O/BMMCupBpzyHSPzgrZ6JBumnkFeOKId48En9fLIAKYdkvtUJIlOLkKHB/bZV
         280tgvyeDYQia4MM9bmZuh+RpO7wLelW4/dgS9aSNPbgZVvKZ2bNlm/JkRFbQfGgYA1n
         z7ndOqmmHLSXiVAx83UiHP7BILcfzcSnhmbFeYt9xJXyEPpAHHojgtLI4Bqx1+m1CcqR
         IyV8hiRMHmqO5rlduqbSO0xN8CEe7M+b2SiQ/rO9D25lMELMBufiZUykaPgGLErT68Vv
         VZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=rvHnmZw/liQW94gjtXrCFd/1cgko4DZ3dzHWakfqGUM=;
        b=NtBGST8z3fExO4WSHWax6lSpYRh/JlHcRb4mtv0Y/4uGKSgBlL8QKkR3J3FN3cYeYl
         NpaLuy9rZhoJ1W0nK9fTbyi36cwBATeojo1WpF7hy9C9AvRbU42BILjxaXcqZRYSjFrB
         bZ4hmWWwwcyutCoFvioMDH90BZO7rN/Tce8GClOmNB2AJlPc4dHCruB9UX/qwOUjBMxM
         TEM2uDM0C7JpncHWTg6miCgEwK/RrNj749IS8HUDxeqMjIZUswGDRGfc6rbKKa8HSxb1
         6GcMp6HRuVzZkuZJG/ng4XTxwQEtpSEJf0n4NjDhxkapshBGptmNxOHZ4s3gg28JQtiB
         a4hg==
X-Gm-Message-State: APjAAAXOdDXmmpN+gMN8uFtdXwncCuf2IcX7GOKv6ZtWkNAAmsLFBIXF
        VKn2mn9MfoHyLPS+blrMgMmRt4KTIwY=
X-Google-Smtp-Source: APXvYqycICWNdPqht5aQPZXIKHsNttq38KZmXYoR2e0MAEITbI292UrQFZnhrfWsJ6TO7I7BZA3/EQ==
X-Received: by 2002:a17:902:758b:: with SMTP id j11mr7973368pll.29.1553089209309;
        Wed, 20 Mar 2019 06:40:09 -0700 (PDT)
Received: from localhost ([114.143.122.221])
        by smtp.gmail.com with ESMTPSA id s6sm3579698pfe.37.2019.03.20.06.40.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 06:40:08 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        David Brown <david.brown@linaro.org>
Cc:     devicetree@vger.kernel.org
Subject: [PATCHv1 1/2] arm64: dts: qcom: pms405: calibrate the VADC correctly
Date:   Wed, 20 Mar 2019 19:09:57 +0530
Message-Id: <08751dd65ad76558724ce4d495b2a85d7ea27ca5.1553088982.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1553088982.git.amit.kucheria@linaro.org>
References: <cover.1553088982.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1553088982.git.amit.kucheria@linaro.org>
References: <cover.1553088982.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the qcom,ratiometric property to make the VADC use the VDD reference
(1.875V) and GND for channel calibration of the temperature channels
instead of 1.25V. Allow a 200us delay between the AMUX configuration and
ADC starting conversion using qcom,hw-settle-time as described in
documentation.

Fixes: 041b9a7b9fdb ("arm64: dts: pms405: Export PMIC temperature to thermal framework")
Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/pms405.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pms405.dtsi b/arch/arm64/boot/dts/qcom/pms405.dtsi
index 1bb836d1e8aa..8b6aa2334f56 100644
--- a/arch/arm64/boot/dts/qcom/pms405.dtsi
+++ b/arch/arm64/boot/dts/qcom/pms405.dtsi
@@ -110,16 +110,22 @@
 
 			xo_therm_100k_pu {
 				reg = <ADC5_XO_THERM_100K_PU>;
+				qcom,ratiometric;
+				qcom,hw-settle-time = <200>;
 				qcom,pre-scaling = <1 1>;
 			};
 
 			amux_thm1_100k_pu {
 				reg = <ADC5_AMUX_THM1_100K_PU>;
+				qcom,ratiometric;
+				qcom,hw-settle-time = <200>;
 				qcom,pre-scaling = <1 1>;
 			};
 
 			amux_thm3_100k_pu {
 				reg = <ADC5_AMUX_THM3_100K_PU>;
+				qcom,ratiometric;
+				qcom,hw-settle-time = <200>;
 				qcom,pre-scaling = <1 1>;
 			};
 		};
-- 
2.17.1

