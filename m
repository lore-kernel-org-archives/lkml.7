Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4886C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 852062184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aZkY1Ivl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfCTNTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:19:17 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32839 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbfCTNTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:19:13 -0400
Received: by mail-pf1-f193.google.com with SMTP id i19so1942034pfd.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 06:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=VhHcZVSBRtsAuReEPdrQAjR3KZZmXdu2lzzS3zScaAA=;
        b=aZkY1Ivl6KfG4R9fP3oGBO6uKKN5O5mzkyWOFX8mhBiOLBVRHy6aoXtn3F+odCHGzr
         trUXiN0hFog5QI7l/LxUCAfNUo3ui3/KgdFZKDoEvN3Og93iweybpi2+1mqMw5AYSYS5
         HyqkDVVIZq2V/s9PStYPNZBudk/dZCgiaZjLJZBGFo1M2YzRKEGFpRbMq1Ik+36QjNIt
         5NObXQoneODcBinX2/koefYT6hSuDUyFLrB94ZuHy/MgvdrM7q5LpLDtXvdYVmv9Z3Cc
         K3y3/kcRJIYRTfaQjDk3mxCcPKf1R2A3M7XpyIDXWgCbb8duuUNf4pfJrv+LDYb8chrL
         sFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=VhHcZVSBRtsAuReEPdrQAjR3KZZmXdu2lzzS3zScaAA=;
        b=mmt5H1UIl2PEcmbsfEBtqpewmxC97UnnjU2yYUXSB+DMH9PCJJZ1pi778TApO0gEV/
         f6wvlVe3LPEdzBOHax9Xk3nGrRKsfuHk7InmUrT76dgFqNWGmmYvQOfvhVGvf79r76lO
         dEaMwZpNB3neDrCjv4XHHwDoclLceToqEQ6csjX7YVkmWgarPd3DkE1un5xQMZOcbRH3
         uykx7ob6Sxmye0F9VV4/0yob3vL/xRQ8uL8f55wuarZOtqutl377nVr5Zooh1VCTakD+
         gUpO0tCQQDcfqZ4Dd1LZPT7/uGL4kG3gwWufv6pp+K99NMEJhw7XSqHJGuR0HVpjyFwF
         g3VQ==
X-Gm-Message-State: APjAAAXyTXHaEh1esbmYSwtBUyrNTm5CCS+XssuAxq23X11ZplbPVCWJ
        9lPcoPHR93sG+ESkz1BifY0cQ0mIjMA=
X-Google-Smtp-Source: APXvYqywZpAUoBP9jdZORIidvhkdZPQC+2FNPWJqQUrlb0yIEt8T1SUNNH9vbw6KWkNnuYvLx5IKmg==
X-Received: by 2002:a17:902:b687:: with SMTP id c7mr7997450pls.270.1553087952682;
        Wed, 20 Mar 2019 06:19:12 -0700 (PDT)
Received: from localhost ([114.143.122.221])
        by smtp.gmail.com with ESMTPSA id z77sm4975215pfi.155.2019.03.20.06.19.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 06:19:12 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCHv3 11/23] drivers: thermal: tsens: Save reference to the device pointer and use it
Date:   Wed, 20 Mar 2019 18:47:51 +0530
Message-Id: <8d368c678b3985cc58a0c314ee14756921d33746.1553086065.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
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
index 0f9deec2517a..9d7a6c328ae0 100644
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
@@ -137,7 +138,7 @@ int __init init_common(struct tsens_priv *priv)
 			goto err_put_device;
 		}
 
-		priv->srot_map = devm_regmap_init_mmio(priv->dev, srot_base,
+		priv->srot_map = devm_regmap_init_mmio(dev, srot_base,
 							&tsens_srot_config);
 		if (IS_ERR(priv->srot_map)) {
 			ret = PTR_ERR(priv->srot_map);
@@ -155,13 +156,13 @@ int __init init_common(struct tsens_priv *priv)
 		goto err_put_device;
 	}
 
-	priv->tm_map = devm_regmap_init_mmio(priv->dev, tm_base, &tsens_config);
+	priv->tm_map = devm_regmap_init_mmio(dev, tm_base, &tsens_config);
 	if (IS_ERR(priv->tm_map)) {
 		ret = PTR_ERR(priv->tm_map);
 		goto err_put_device;
 	}
 
-	priv->rf[TSENS_EN] = devm_regmap_field_alloc(priv->dev, priv->srot_map,
+	priv->rf[TSENS_EN] = devm_regmap_field_alloc(dev, priv->srot_map,
 						     priv->fields[TSENS_EN]);
 	if (IS_ERR(priv->rf[TSENS_EN])) {
 		ret = PTR_ERR(priv->rf[TSENS_EN]);
@@ -171,12 +172,12 @@ int __init init_common(struct tsens_priv *priv)
 	if (ret)
 		goto err_put_device;
 	if (!enabled) {
-		dev_err(priv->dev, "tsens device is not enabled\n");
+		dev_err(dev, "tsens device is not enabled\n");
 		ret = -ENODEV;
 		goto err_put_device;
 	}
 
-	priv->rf[SENSOR_EN] = devm_regmap_field_alloc(priv->dev, priv->srot_map,
+	priv->rf[SENSOR_EN] = devm_regmap_field_alloc(dev, priv->srot_map,
 						      priv->fields[SENSOR_EN]);
 	if (IS_ERR(priv->rf[SENSOR_EN])) {
 		ret = PTR_ERR(priv->rf[SENSOR_EN]);
@@ -184,7 +185,7 @@ int __init init_common(struct tsens_priv *priv)
 	}
 	/* now alloc regmap_fields in tm_map */
 	for (i = 0, j = LAST_TEMP_0; i < priv->num_sensors; i++, j++) {
-		priv->rf[j] = devm_regmap_field_alloc(priv->dev, priv->tm_map,
+		priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
 						      priv->fields[j]);
 		if (IS_ERR(priv->rf[j])) {
 			ret = PTR_ERR(priv->rf[j]);
@@ -192,7 +193,7 @@ int __init init_common(struct tsens_priv *priv)
 		}
 	}
 	for (i = 0, j = VALID_0; i < priv->num_sensors; i++, j++) {
-		priv->rf[j] = devm_regmap_field_alloc(priv->dev, priv->tm_map,
+		priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
 						      priv->fields[j]);
 		if (IS_ERR(priv->rf[j])) {
 			ret = PTR_ERR(priv->rf[j]);
-- 
2.17.1

