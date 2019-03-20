Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0B8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D1492184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d5w7gFx+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbfCTNTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:19:37 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34948 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727625AbfCTNTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:19:35 -0400
Received: by mail-pg1-f194.google.com with SMTP id g8so1815571pgf.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 06:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=M+ri0/t8z+fxO1Ckfy5EpkjgMAx02hieB7076U60UDM=;
        b=d5w7gFx+s6qEhPWnyeJ50nwZRlljAtcyHQH3+Bqw1x7yrPSK4dgon1Ns8xBU0HqNBn
         fQXwMdPrAU6UJzoT4Mc2BblS/cmGX1ozJY7h46Kh/6/Az/T34lZsmBPQamUwr04OH6WC
         spn6F+RRmMgmZYIst/odl5A+WxCmSLusToJ2tKWpAcrLD22BQ0v0gmUXw3B7A+canCO5
         tbvFlmmYcapUoqyeUvdFNA8VBj7/Iuo7MrxdYKWh8Fdgvrwgk8vztU9LSG5k7ux1zeYO
         irMTwluddlSF4W6l9uezv9QH9Xa1/O1FOnwe50FtUkBqxAxiQ7KVnvCNp8oCVUKe48wr
         Um8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=M+ri0/t8z+fxO1Ckfy5EpkjgMAx02hieB7076U60UDM=;
        b=oQPwOxA8CDdJ99kQ5FkB+Ib8EiPQcrTVFwUbmvXzjZwrg5fWahPKsZaq2BtshodWjw
         OYkJwmFEvNLzkm0CPkKnrbXjxXjHmUE9gW2mAhy/E9zIeUzOkttPqsflhG3Xx6qdGItb
         Ob4n0mtPbLIOFqc4Cvi4a3g20sdvLJQ1IHQeu6Nu+mAcdc5XpDyrO7+rc/FHzruD5KAE
         JmWmC20Akm04v9stqbdYuUubeaC8q357AVrscXjHjw9/x5AwQlnKvtCXtdOqwqhnJw6m
         PSRUI9O4vkeWyfQ/Tf5RP9bGjxN5KPcTKPyPXmH/i+5Gs56MeJiC+LRcLogUq4UcVZ6j
         9xSA==
X-Gm-Message-State: APjAAAWZVTvqQXD+z0QYXXkBBP2TOPTUXMbj43q101C4JuhaQjFiBFat
        nn9piUfSIlUv+WyEws/DJPczdajRcLA=
X-Google-Smtp-Source: APXvYqy3SLutOmrb7MyL/K385uvWHZXFVOUa5pSwonEs3HN437R7plhgzJUJWjC6xlXQnRZlRHWvOw==
X-Received: by 2002:a17:902:8c8a:: with SMTP id t10mr32048360plo.160.1553087974103;
        Wed, 20 Mar 2019 06:19:34 -0700 (PDT)
Received: from localhost ([114.143.122.221])
        by smtp.gmail.com with ESMTPSA id 17sm2716025pgt.0.2019.03.20.06.19.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 06:19:33 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCHv3 16/23] drivers: thermal: tsens: simplify get_temp_tsens_v2 routine
Date:   Wed, 20 Mar 2019 18:47:56 +0530
Message-Id: <5646f7e3bd90e4644718f380b28c6115c01bcb7a.1553086065.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation is based on an algorithm published in the
docs. Instead of reading the temperature thrice w/o any explanation,
improve the algorithm.

This will become the basis for a common get_temp routine in the future.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-v2.c | 55 ++++++++++-----------------------
 1 file changed, 17 insertions(+), 38 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index f3eb8661cf7a..716d7f827459 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -25,58 +25,37 @@
 #define TM_Sn_STATUS_OFF		0x00a0
 #define TM_TRDY_OFF			0x00e4
 
-#define LAST_TEMP_MASK		0xfff
-
-static int get_temp_tsens_v2(struct tsens_priv *priv, int id, int *temp)
+static int get_temp_tsens_v2(struct tsens_priv *priv, int i, int *temp)
 {
-	struct tsens_sensor *s = &priv->sensor[id];
+	struct tsens_sensor *s = &priv->sensor[i];
 	u32 temp_idx = LAST_TEMP_0 + s->hw_id;
 	u32 valid_idx = VALID_0 + s->hw_id;
-	u32 last_temp = 0, last_temp2 = 0, last_temp3 = 0, valid;
+	u32 last_temp = 0, valid, mask;
 	int ret;
 
-	ret = regmap_field_read(priv->rf[temp_idx], &last_temp);
-	if (ret)
-		return ret;
-
 	ret = regmap_field_read(priv->rf[valid_idx], &valid);
 	if (ret)
 		return ret;
-
-	if (valid)
-		goto done;
-
-	/* Try a second time */
-	ret = regmap_field_read(priv->rf[valid_idx], &valid);
-	if (ret)
-		return ret;
-	ret = regmap_field_read(priv->rf[temp_idx], &last_temp2);
-	if (ret)
-		return ret;
-	if (valid) {
-		last_temp = last_temp2;
-		goto done;
+	while (!valid) {
+		/* Valid bit is 0 for 6 AHB clock cycles.
+		 * At 19.2MHz, 1 AHB clock is ~60ns.
+		 * We should enter this loop very, very rarely.
+		 */
+		ndelay(400);
+		ret = regmap_field_read(priv->rf[valid_idx], &valid);
+		if (ret)
+			return ret;
 	}
 
-	/* Try a third/last time */
-	ret = regmap_field_read(priv->rf[valid_idx], &valid);
-	if (ret)
-		return ret;
-	ret = regmap_field_read(priv->rf[temp_idx], &last_temp3);
+	/* Valid bit is set, OK to read the temperature */
+	ret = regmap_field_read(priv->rf[temp_idx], &last_temp);
 	if (ret)
 		return ret;
-	if (valid) {
-		last_temp = last_temp3;
-		goto done;
-	}
 
-	if (last_temp == last_temp2)
-		last_temp = last_temp2;
-	else if (last_temp2 == last_temp3)
-		last_temp = last_temp3;
-done:
+	mask = GENMASK(priv->fields[LAST_TEMP_0].msb,
+		       priv->fields[LAST_TEMP_0].lsb);
 	/* Convert temperature from deciCelsius to milliCelsius */
-	*temp = sign_extend32(last_temp, fls(LAST_TEMP_MASK) - 1) * 100;
+	*temp = sign_extend32(last_temp, fls(mask) - 1) * 100;
 
 	return 0;
 }
-- 
2.17.1

