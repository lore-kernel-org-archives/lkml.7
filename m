Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE20BC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 10:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A7D21773
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 10:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BGrk88fa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387703AbfGaKBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 06:01:01 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44534 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387682AbfGaKA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 06:00:59 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so31715890pgl.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 03:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=vuwg/qLthBT40Ca2xrbvcRHyZdgOFkkkM28IonKKxd4=;
        b=BGrk88fawYJnzHlTqSp6jAcbVl4MvCckvfC8RgMr9Iq0piEiaZ2vyikaRxDhM9fLSn
         xlRwXhOZymwnuqLXEXZCVXGakJTqcBwfe9pSQxJQs9tFf3b/btbIEU6bWd7a22pHa1FX
         XnbKJaf5d6QeBvS6a2hJi6b7eYrlKLuT+vR5nw85UjKNJF5NAg2AvIgaN0qfUq9KW+H1
         D+86lngDkbCc9sND22axjQyz0lGSDKqA/KvdbbGuRQLdSkH2iJCYhFVAMrLM5vvqeIaY
         1uy4NRxiurckC0uiTQF7DYa0lIdvjQPzWAUMdCLG6DdM+/QmJSMk4+8tPDCW8GLhIrqw
         JCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=vuwg/qLthBT40Ca2xrbvcRHyZdgOFkkkM28IonKKxd4=;
        b=RooFe60vA/909sYnRSyu2kJtGQpJ7WQqkV4CBe8nVDve3C1J1GOHxBYtkiZk4GumFr
         huChf0zFLTZl7lvKF/VjW4lIfDpL7ZCDPV8LXy+10V3gZFYCZdjSpcrnAQLJf3r2KFfh
         pgplgzms7Y/bkBu6CpJs6a+ZcSjWkbkAOrSru069JvIBg35K1ZWkChEfR8MP6wVQw3UN
         sGfJCBdSpXDzuE+DV4FaZsPGivHXn605d8KOCW0ccfA3kR3s8Hs0Qk1EHaEIr9o8vLJP
         hHqsiYFh7fPwITlpKfaTcbvBtDavKtUeacwnjoMcd27R3aK7e81yUR0f5KDTSoP9oZC8
         4cVQ==
X-Gm-Message-State: APjAAAUN10EvNQqduMSlPex7X/yfsTCOGPgLj+2TXODd/ZkwbMj2S5LX
        tkNdycdmS264pjFXcyP/1BK+TA==
X-Google-Smtp-Source: APXvYqydg9TR+BiV/Pz9CW9e98/wdHVGKxLK9oxylari74O6XN92CBconFgW3aaqYn1XtdjKzu52bg==
X-Received: by 2002:a63:ee08:: with SMTP id e8mr59564051pgi.70.1564567258256;
        Wed, 31 Jul 2019 03:00:58 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id m6sm68611352pfb.151.2019.07.31.03.00.56
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 Jul 2019 03:00:57 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, vincent.guittot@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] power: supply: sc27xx: Fix the the accuracy issue of coulomb calculation
Date:   Wed, 31 Jul 2019 18:00:25 +0800
Message-Id: <0e86ed1f992d2eb99fd4abb9e0c51ca2c4ccd4eb.1564566425.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1564566425.git.baolin.wang@linaro.org>
References: <cover.1564566425.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1564566425.git.baolin.wang@linaro.org>
References: <cover.1564566425.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuanjiang Yu <yuanjiang.yu@unisoc.com>

The Spreadtrum fuel gauge will multiply by 2 for counting the coulomb
counter to improve the accuracy, which means the value saved in fuel
gauge is: coulomb counter * 2 * 1000ma_adc. Thus fix the conversion
formular to improve the accuracy of calculating the battery capacity.

Signed-off-by: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/sc27xx_fuel_gauge.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index ca7b73e..ab3afa1 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -326,8 +326,6 @@ static int sc27xx_fgu_set_clbcnt(struct sc27xx_fgu_data *data, int clbcnt)
 {
 	int ret;
 
-	clbcnt *= SC27XX_FGU_SAMPLE_HZ;
-
 	ret = regmap_update_bits(data->regmap,
 				 data->base + SC27XX_FGU_CLBCNT_SETL,
 				 SC27XX_FGU_CLBCNT_MASK, clbcnt);
@@ -362,7 +360,6 @@ static int sc27xx_fgu_get_clbcnt(struct sc27xx_fgu_data *data, int *clb_cnt)
 
 	*clb_cnt = ccl & SC27XX_FGU_CLBCNT_MASK;
 	*clb_cnt |= (cch & SC27XX_FGU_CLBCNT_MASK) << SC27XX_FGU_CLBCNT_SHIFT;
-	*clb_cnt /= SC27XX_FGU_SAMPLE_HZ;
 
 	return 0;
 }
@@ -380,10 +377,10 @@ static int sc27xx_fgu_get_capacity(struct sc27xx_fgu_data *data, int *cap)
 
 	/*
 	 * Convert coulomb counter to delta capacity (mAh), and set multiplier
-	 * as 100 to improve the precision.
+	 * as 10 to improve the precision.
 	 */
-	temp = DIV_ROUND_CLOSEST(delta_clbcnt, 360);
-	temp = sc27xx_fgu_adc_to_current(data, temp);
+	temp = DIV_ROUND_CLOSEST(delta_clbcnt * 10, 36 * SC27XX_FGU_SAMPLE_HZ);
+	temp = sc27xx_fgu_adc_to_current(data, temp / 1000);
 
 	/*
 	 * Convert to capacity percent of the battery total capacity,
@@ -790,7 +787,7 @@ static int sc27xx_fgu_cap_to_clbcnt(struct sc27xx_fgu_data *data, int capacity)
 	 * Convert current capacity (mAh) to coulomb counter according to the
 	 * formula: 1 mAh =3.6 coulomb.
 	 */
-	return DIV_ROUND_CLOSEST(cur_cap * 36 * data->cur_1000ma_adc, 10);
+	return DIV_ROUND_CLOSEST(cur_cap * 36 * data->cur_1000ma_adc * SC27XX_FGU_SAMPLE_HZ, 10);
 }
 
 static int sc27xx_fgu_calibration(struct sc27xx_fgu_data *data)
-- 
1.7.9.5

