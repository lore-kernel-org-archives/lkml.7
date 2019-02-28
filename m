Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA69C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59959214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="irnNzAIp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731283AbfB1M1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:27:04 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46581 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731218AbfB1M1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 07:27:03 -0500
Received: by mail-wr1-f65.google.com with SMTP id i16so21692587wrs.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 04:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=DhOH74k9WLUHZ9bc4R59OvEiqm0NxoNRQ6D2mdU8GNA=;
        b=irnNzAIpeG/Q0pGh4DtzlM80WIT9F4seVwCL3A8RRCFJVmt2gq1QdrN4ogqjZVYHxD
         JaXpo4aoM3Du5s+zM4S9d5qsO5gRFlhz7XR71CvRD1yq8VcHxrhZWXtsG3HmvZ1pmJYU
         OCfK4t+P4tp5rgtjmCv+xjtwt8WcEuvLIk92fpDZE7N2Sk5AiqcKKpg4HUxIa0blo0OM
         6Ar/pHmQIrbfDeVEM6Kbl8ZtzsQVB3gvINqvMfDPq8/929hpTT7RurhmrWAHKvUD5RVD
         o/+qx9wN4YDVteKjc+i2+LdOJxhHIxi5FHDQPnnwW5kq+1Fhqsyy08PJrUdXsgtFMHzq
         6OAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=DhOH74k9WLUHZ9bc4R59OvEiqm0NxoNRQ6D2mdU8GNA=;
        b=Ki88HRjoWKnCcQnogNNBAL621qEv+1CR1rr8nuX2NhxEq8qDCLiN6hN57jB/br/pcJ
         bFYaFgvVU/8zw+beJwRNpk6DdiySUAeQgyfHtQZ8I7KOyWxoxSVqHeUgiJRTrd929SFB
         yxJtqLZZVZ+hCD2/+UR7lfhqb1WMR4+hygDMDIKu6bognLMlAphPcp4AJS7490UUh4aU
         MrbEaLJFkyEMxyYsIogH9sYJWOnvDQCSvekxy1TTBEMCPEdld2gBERmqfi7k1Tzbe23D
         zLyElRzGmThK8ApOkjmRBuYTeiBd1yMwnb2DC7NMKnM8WltgcPcyYMIorvHq5ZkvHqrg
         6ANA==
X-Gm-Message-State: APjAAAUG9E3YP/wELk3jPlDs+35C9bgqRms2MjcHRczrgho7vUgzLwKR
        sCa86hCR/inhQD+SPJxBAiFlurso9aY=
X-Google-Smtp-Source: APXvYqzpGNun1JhC1FD+F4k3rpkW72/KAODbc5co4UvHpiEeL91z7FsN00xhK+VMJz9tIAkZMmkmNw==
X-Received: by 2002:a5d:4702:: with SMTP id y2mr6683446wrq.149.1551356821348;
        Thu, 28 Feb 2019 04:27:01 -0800 (PST)
Received: from localhost ([49.248.54.130])
        by smtp.gmail.com with ESMTPSA id c2sm25070024wrt.93.2019.02.28.04.26.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 04:27:00 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v2 11/24] drivers: thermal: tsens: Save reference to the device pointer and use it
Date:   Thu, 28 Feb 2019 17:51:01 +0530
Message-Id: <a2b7af050624a222c82584d1237cba46e5fff4f3.1551355503.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code cleanup making it easier to read

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index a82e4c928a78..aae3d71d7eed 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -119,6 +119,7 @@ static const struct regmap_config tsens_srot_config = {
 int __init init_common(struct tsens_priv *priv)
 {
 	void __iomem *tm_base, *srot_base;
+	struct device *dev = priv->dev;
 	struct resource *res;
 	u32 enabled;
 	int ret, i, j;
@@ -135,7 +136,7 @@ int __init init_common(struct tsens_priv *priv)
 		if (IS_ERR(srot_base))
 			return PTR_ERR(srot_base);
 
-		priv->srot_map = devm_regmap_init_mmio(priv->dev, srot_base,
+		priv->srot_map = devm_regmap_init_mmio(dev, srot_base,
 							&tsens_srot_config);
 		if (IS_ERR(priv->srot_map))
 			return PTR_ERR(priv->srot_map);
@@ -150,11 +151,11 @@ int __init init_common(struct tsens_priv *priv)
 	if (IS_ERR(tm_base))
 		return PTR_ERR(tm_base);
 
-	priv->tm_map = devm_regmap_init_mmio(priv->dev, tm_base, &tsens_config);
+	priv->tm_map = devm_regmap_init_mmio(dev, tm_base, &tsens_config);
 	if (IS_ERR(priv->tm_map))
 		return PTR_ERR(priv->tm_map);
 
-	priv->rf[TSENS_EN] = devm_regmap_field_alloc(priv->dev, priv->srot_map,
+	priv->rf[TSENS_EN] = devm_regmap_field_alloc(dev, priv->srot_map,
 						     priv->fields[TSENS_EN]);
 	if (IS_ERR(priv->rf[TSENS_EN]))
 		return PTR_ERR(priv->rf[TSENS_EN]);
@@ -162,24 +163,24 @@ int __init init_common(struct tsens_priv *priv)
 	if (ret)
 		return ret;
 	if (!enabled) {
-		dev_err(priv->dev, "tsens device is not enabled\n");
+		dev_err(dev, "tsens device is not enabled\n");
 		return -ENODEV;
 	}
 
-	priv->rf[SENSOR_EN] = devm_regmap_field_alloc(priv->dev, priv->srot_map,
+	priv->rf[SENSOR_EN] = devm_regmap_field_alloc(dev, priv->srot_map,
 						      priv->fields[SENSOR_EN]);
 	if (IS_ERR(priv->rf[SENSOR_EN]))
 		return PTR_ERR(priv->rf[SENSOR_EN]);
 
 	/* now alloc regmap_fields in tm_map */
 	for (i = 0, j = LAST_TEMP_0; i < priv->num_sensors; i++, j++) {
-		priv->rf[j] = devm_regmap_field_alloc(priv->dev, priv->tm_map,
+		priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
 						      priv->fields[j]);
 		if (IS_ERR(priv->rf[j]))
 			return PTR_ERR(priv->rf[j]);
 	}
 	for (i = 0, j = VALID_0; i < priv->num_sensors; i++, j++) {
-		priv->rf[j] = devm_regmap_field_alloc(priv->dev, priv->tm_map,
+		priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
 						      priv->fields[j]);
 		if (IS_ERR(priv->rf[j]))
 			return PTR_ERR(priv->rf[j]);
-- 
2.17.1

