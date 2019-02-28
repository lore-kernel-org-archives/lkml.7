Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14ACC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2F42083D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WeJ0+5wX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731876AbfB1M1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:27:42 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42042 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731827AbfB1M1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 07:27:41 -0500
Received: by mail-wr1-f67.google.com with SMTP id r5so21719556wrg.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 04:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=x3C+xygM5AZc31GHOzRn3x57Ju5ms6bQCpVgVpS9orM=;
        b=WeJ0+5wXhx7ep5PjD4X66XTyI5JDkTe/c+xrYHVHXaVchsvtfACf6yMby2KVCoUyTl
         Ca7zhMJPvkvbigD8s+437oEx0lNvuFmXd6yxrPblmX42QjHKaUmF7TGjzb5Q/J50D/Ht
         hWdEtRJfy6jMVf9gCflQC4Spahbd2u8mUgOELuW7NVRKNMKCrUtyGMArjOKrCLFOCdJT
         DMctVN86V3m0an9vUbj+eykDQvsUOW0Bwu7i3usRZuDJ9EYGSzpa57fUODoaL7wiol4Z
         HJNbDBbzDOFMU0jTnXaKemWwHhI/Q9Evm5ZMdIxSwR4vLbkL5X/HvojRPVA3q43BP8jh
         1Vew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=x3C+xygM5AZc31GHOzRn3x57Ju5ms6bQCpVgVpS9orM=;
        b=gwAaLIcifOlcdMwHkjhMrFkxs4GemnbTvXyDzsZpN9VPtQdXaPBYTdymPoe8Z/fYEu
         W5xuIMPgTqjdCEqXjABjORgDHa9HcUnHvIA0I9rs20uShMfMO0u/K76HiH5igWqu/zEe
         YLw7rQ6rx2LcKWBklpeKOrxo9T1+gWkIBm+5fFRt6iShmt9f9fbmGzovtU4xjKdLL1qY
         7ENoz2XsVEaoHJBEZ5bUB44cF9aJhNQlbVOQxYQ6N7dnCMHunrrrPkzrXVnnOFen3ZBN
         0oS6l++030O/blbmzRbj+3DA0H733YAOcIIiPnZoU/KK1msKLkeqCB6Jd8gXfMEhv1SN
         lVyQ==
X-Gm-Message-State: APjAAAW/MT/FF8kpuUl0VQNQFp8zTkSIRlMV9Ns3ZBdKj6QOn7CG1Swj
        knvPpe9oeFTSijIWK/hkehxseYeAgfE=
X-Google-Smtp-Source: APXvYqwTuVyAxxJxvjSMQ7RR+qyzQnZScHeHxpDTTjZ2SV4T6xylMK60W7n8fSynxkDB/0OCsMGbug==
X-Received: by 2002:adf:9d85:: with SMTP id p5mr6067417wre.215.1551356858934;
        Thu, 28 Feb 2019 04:27:38 -0800 (PST)
Received: from localhost ([49.248.54.130])
        by smtp.gmail.com with ESMTPSA id f6sm20292598wrt.87.2019.02.28.04.27.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 04:27:38 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v2 17/24] drivers: thermal: tsens: simplify get_temp_tsens_v2 routine
Date:   Thu, 28 Feb 2019 17:51:07 +0530
Message-Id: <854ae4178dffabaec0274127fca1fe59a3be1199.1551355503.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
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
index 55fe00f90b22..e180e80f533c 100644
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

