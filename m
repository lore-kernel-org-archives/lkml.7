Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6009ECE588
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FFD820854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QmzymGkd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390855AbfJPHfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:35:16 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37775 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390778AbfJPHfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:35:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id y5so14171654pfo.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 00:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=/kNhWSzT1XF3+/kAR7Dxjp13J1ZI+CyyKCX+EYBQmx8=;
        b=QmzymGkdzTKuxhlQQbG1q+cOpiRxZSL4bdv7TTVHrcS7uAjgk0NhCFOkhZSDoi0agg
         dfs2fDlBES/nfc5WbMchIaqgOFuKZZZ5lnP2maSL3pITe59vcfuNo+veBb7BWXWh9MIN
         elCftBIxAO646pb6sAd0Ej0vLFEYSQITYp6Y1C3BT1toeeScAk8P/zDRxnmDSmdaP4JT
         SDHTUIwg1v6fpMQH3w4yZ5qhnIESZOLl4EL2Q4xdx0dlu1CDgtHge5LJx29Lta020jge
         pnkaZ+gNJ1FCG7Dde3tKXqfEqG87y6g1uMl1gNWmZKMty67hlR5rzQjDrGWHmmnaQV/4
         QLfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=/kNhWSzT1XF3+/kAR7Dxjp13J1ZI+CyyKCX+EYBQmx8=;
        b=X2yGJFXzvCWi65LcjxtD0CKwMuHlaTnt4me2lP18OnZEW/AV0u18ew5WNEUfRC8vqe
         mQq6igfzx27i9EwgJYOfpH1U+we5yH1VaFydC+ivlBokdiRAZhMYia+RbwexYWLiRPz0
         9YfIRDcSPBtsSIPmDFq4F2Mtm8y+ZLBp2mb0j8lvVIi5UYOeqRSdbdC32stgGlulfsap
         zdYeF7NQ/RxFfzGAdH9P2iY+8gkwWblsv8ZBl81kVK8mPJ8bXkSMvOTaPrIroC3QquXf
         JN81fE1oqMJzC4wjdt7Py5M0E45FikzxFgp7Kly3DpIgW5mdKMHWOmNGYz5XSlBmWnZw
         W6rQ==
X-Gm-Message-State: APjAAAUNH5S++o8PLHnzIycFJ7aeZNdy+iGqJO9lyvuF/4YhsLth9XOa
        JaVH8YEPjUAkQsUD/caSa9vqlqf/doWlkA==
X-Google-Smtp-Source: APXvYqzW3Yokr508aGfspxAB1bRkDKPRBSHVECG1pH9ihR8mBDtUA5nnuAE4IIQT+9sNJ6KNK6RUCA==
X-Received: by 2002:aa7:93de:: with SMTP id y30mr42412010pff.98.1571211313730;
        Wed, 16 Oct 2019 00:35:13 -0700 (PDT)
Received: from localhost ([49.248.175.127])
        by smtp.gmail.com with ESMTPSA id v68sm28026272pfv.47.2019.10.16.00.35.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Oct 2019 00:35:13 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        masneyb@onstation.org, swboyd@chromium.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 14/15] drivers: thermal: tsens: Create function to return sign-extended temperature
Date:   Wed, 16 Oct 2019 13:04:13 +0530
Message-Id: <0689917475cf83b7e01f6978504fd37352a5e3ca.1571210269.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571210269.git.amit.kucheria@linaro.org>
References: <cover.1571210269.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1571210269.git.amit.kucheria@linaro.org>
References: <cover.1571210269.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hide the details of how to convert values read from TSENS HW to mCelsius
behind a function. All versions of the IP can be supported as a result.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/thermal/qcom/tsens-common.c | 49 ++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index ea2c46cc6a66..c34a1a26ce29 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -84,13 +84,46 @@ static inline int code_to_degc(u32 adc_code, const struct tsens_sensor *s)
 	return degc;
 }
 
+/**
+ * tsens_hw_to_mC - Return sign-extended temperature in mCelsius.
+ * @s:     Pointer to sensor struct
+ * @field: Index into regmap_field array pointing to temperature data
+ *
+ * This function handles temperature returned in ADC code or deciCelsius
+ * depending on IP version.
+ *
+ * Return: Temperature in milliCelsius on success, a negative errno will
+ * be returned in error cases
+ */
+static int tsens_hw_to_mC(struct tsens_sensor *s, int field)
+{
+	struct tsens_priv *priv = s->priv;
+	u32 resolution;
+	u32 temp = 0;
+	int ret;
+
+	resolution = priv->fields[LAST_TEMP_0].msb -
+		priv->fields[LAST_TEMP_0].lsb;
+
+	ret = regmap_field_read(priv->rf[field], &temp);
+	if (ret)
+		return ret;
+
+	/* Convert temperature from ADC code to milliCelsius */
+	if (priv->feat->adc)
+		return code_to_degc(temp, s) * 1000;
+
+	/* deciCelsius -> milliCelsius along with sign extension */
+	return sign_extend32(temp, resolution) * 100;
+}
+
 int get_temp_tsens_valid(struct tsens_sensor *s, int *temp)
 {
 	struct tsens_priv *priv = s->priv;
 	int hw_id = s->hw_id;
 	u32 temp_idx = LAST_TEMP_0 + hw_id;
 	u32 valid_idx = VALID_0 + hw_id;
-	u32 last_temp = 0, valid, mask;
+	u32 valid;
 	int ret;
 
 	ret = regmap_field_read(priv->rf[valid_idx], &valid);
@@ -108,19 +141,7 @@ int get_temp_tsens_valid(struct tsens_sensor *s, int *temp)
 	}
 
 	/* Valid bit is set, OK to read the temperature */
-	ret = regmap_field_read(priv->rf[temp_idx], &last_temp);
-	if (ret)
-		return ret;
-
-	if (priv->feat->adc) {
-		/* Convert temperature from ADC code to milliCelsius */
-		*temp = code_to_degc(last_temp, s) * 1000;
-	} else {
-		mask = GENMASK(priv->fields[LAST_TEMP_0].msb,
-			       priv->fields[LAST_TEMP_0].lsb);
-		/* Convert temperature from deciCelsius to milliCelsius */
-		*temp = sign_extend32(last_temp, fls(mask) - 1) * 100;
-	}
+	*temp = tsens_hw_to_mC(s, temp_idx);
 
 	return 0;
 }
-- 
2.17.1

