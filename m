Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B936C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D1C621850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JhRspOZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbfCTNkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:40:16 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41732 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbfCTNkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:40:14 -0400
Received: by mail-pf1-f193.google.com with SMTP id d25so1951475pfn.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 06:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=fgiU/0dqWjtse4FbfTHlaH8yAxiZGqRsWDi7TBKqC9M=;
        b=JhRspOZMc5FFF9igH6w2uCwBPyvRofTruPQtA06/nSwKC68SPbG1+3F3R4EqZoKRih
         addYByJye4kgqE/CNxHRSQzYBatiml+ETvntHlwPdt04GKeRFl/xYhlAUWJHEPsU0wk8
         ouTWRU5lDqDoL0ZnqG6JhzUZxmq4WuR3cBQVLBgsojSWNxIqkXvroQO7o7H2PtR6iDc9
         C2hY/0cESFUORFwwlegm45ccHfhIKB56sbov4MenSLCW1TEGiAsSS3VJXACW4k6MDqoU
         x1U8AZfUZv7zKAVJk47xRI3s4Rno7fhMfxWt6vsC3JWQwbkL4ltHt3Mt0U5kBc6CwnIZ
         W3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=fgiU/0dqWjtse4FbfTHlaH8yAxiZGqRsWDi7TBKqC9M=;
        b=hmuuUL95gl4Wm6qplCN+BcL2EGYwHuLPTjlzi4zvHiW7aVMwO00HXe/7N8LGVKcjHz
         hKRahORw5gkNFm8cVsbIz7W7QEfj2Gss6GdR5PRonfTqBQqL2Athqw76xinD+0sFwbRc
         RDKul0hyAPswxdmErqAR6pUN8EslUS5xRd8yMAK9rAmvJKkCMP9BOh59cwf1FAZwvCfx
         itdtU/HvqFWEeggWkBolhpFG3ZrSBvoyPpqcu2TqakKPlwCdnh7+4pk0eI1JWGssZARy
         uycocWJoe6kA5BNxI7uC+87DKKiw8zN/4gpX3JW+AlYQDT5G7/t+4/cJ7a9ip+txiy9L
         XHTQ==
X-Gm-Message-State: APjAAAUB8cOMxakzmkMmm5md9PYabRE0hDcGGw9J7B6Fto2yJeE+P0sN
        WoxdRj7SJkZfgLf8Uh+kPfkOfNuPie0=
X-Google-Smtp-Source: APXvYqy93JVevMVKDIgSf2cquyfs8WvOUazTZFLJZVW37UEU7nrCkgKFmLBOX7t1q+4J5fiWkqqDTA==
X-Received: by 2002:a63:2158:: with SMTP id s24mr7293746pgm.156.1553089213585;
        Wed, 20 Mar 2019 06:40:13 -0700 (PDT)
Received: from localhost ([114.143.122.221])
        by smtp.gmail.com with ESMTPSA id z128sm4375573pfz.107.2019.03.20.06.40.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 06:40:12 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        David Brown <david.brown@linaro.org>
Cc:     devicetree@vger.kernel.org
Subject: [PATCHv1 2/2] arm64: dts: qcom: pms405: Rename adc outputs as per schematics
Date:   Wed, 20 Mar 2019 19:09:58 +0530
Message-Id: <65fdb9213591901d30c9af89102c22a730fb2745.1553088982.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1553088982.git.amit.kucheria@linaro.org>
References: <cover.1553088982.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1553088982.git.amit.kucheria@linaro.org>
References: <cover.1553088982.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The adc outputs shouldn't contain information about their configuration
e.g. 100K pull-up, but just reflect the name of the signal in the
schematics.

Making them labels also allows us to overwrite their configuration in
board-specific DTs.

Sort them by order as used in adc5_chans_rev2, while we're at it.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/pms405.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pms405.dtsi b/arch/arm64/boot/dts/qcom/pms405.dtsi
index 8b6aa2334f56..37c8bea24796 100644
--- a/arch/arm64/boot/dts/qcom/pms405.dtsi
+++ b/arch/arm64/boot/dts/qcom/pms405.dtsi
@@ -98,7 +98,7 @@
 				qcom,pre-scaling = <1 1>;
 			};
 
-			vph_pwr {
+			pon_1: vph_pwr {
 				reg = <ADC5_VPH_PWR>;
 				qcom,pre-scaling = <1 3>;
 			};
@@ -108,22 +108,22 @@
 				qcom,pre-scaling = <1 1>;
 			};
 
-			xo_therm_100k_pu {
-				reg = <ADC5_XO_THERM_100K_PU>;
+			pa_therm1: thermistor1 {
+				reg = <ADC5_AMUX_THM1_100K_PU>;
 				qcom,ratiometric;
 				qcom,hw-settle-time = <200>;
 				qcom,pre-scaling = <1 1>;
 			};
 
-			amux_thm1_100k_pu {
-				reg = <ADC5_AMUX_THM1_100K_PU>;
+			pa_therm3: thermistor3 {
+				reg = <ADC5_AMUX_THM3_100K_PU>;
 				qcom,ratiometric;
 				qcom,hw-settle-time = <200>;
 				qcom,pre-scaling = <1 1>;
 			};
 
-			amux_thm3_100k_pu {
-				reg = <ADC5_AMUX_THM3_100K_PU>;
+			xo_therm: xo_temp {
+				reg = <ADC5_XO_THERM_100K_PU>;
 				qcom,ratiometric;
 				qcom,hw-settle-time = <200>;
 				qcom,pre-scaling = <1 1>;
-- 
2.17.1

