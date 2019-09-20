Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8536C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 21:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99CD020B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 21:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lEv2wwv0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730381AbfITVx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 17:53:26 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44147 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730305AbfITVxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 17:53:13 -0400
Received: by mail-pl1-f194.google.com with SMTP id q15so3784397pll.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 14:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=3XLPlhPImWAomUfs/g8BXhfm3lVXoZB+dL/zQw9KVyY=;
        b=lEv2wwv0SVuY/tTqDvXJSzksXwIRavTm9n2Rm3hSLNHJUGWIlejeRUEPY6e7vxqoTO
         QzS1uexKLsb/OFZ4LMMCx+wOmVjSQSKugPd55NX+3OIbRWvhfwfuMGqPxZH/7toTIDLY
         9aIApMHudMQPQuRIAJB1bQAlQ5w6wnBBFnTo5lRViTCi6DbPEP2j7csIdp/myh69+iP0
         3lQytGe46/oPFUcNaASXHAf4K3fYYaoA/Q/25txOFfi5I/WqoOXeaZ8vWk2MAkxpKvTr
         ob0tfgetkAZKjhxdJv3AAoGj9UF/Mew8l1Ilf7lv+UXuOXuAcJZTXAA3ugSTDvoVLIcq
         TjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=3XLPlhPImWAomUfs/g8BXhfm3lVXoZB+dL/zQw9KVyY=;
        b=nHpxtrN+U0ZD1E/2O4HfQc6TjzZDUQ6ElF6wZ8OT8pOraRyc2szLlg156ajEZCqzYX
         HVI9jv3EONGvKtljj8gQln15U2okh9pGWAnvGtvPek2XqsXJf1x6NjH+0+qWR2m2i9zc
         QgymWd3vkMpVudJj6jzPHX8pZqZL9tENPqPK/Ynl/zN0FM5B6cYfxQZCsqhBnRxyRgyD
         L5Je9d2sv9Je2CjjVOizzOD13M8WcQX5ND4/Zr6IDc7BITfZb461LET+yUB5+d+Ui7mq
         b9IJw5/xqAnjIhafdsvqp5CREztEAAoChMHo9kubkvjqeoQOJA/2JFowgqY8ZItm7uy8
         lBJw==
X-Gm-Message-State: APjAAAVqiC5i3aXACKg3gnENy1z4uG9d8APZ0FWKNHIAw/N2qHXAiuGH
        plcFM7yVADQrr29wMzUzKvjLNK+nY0PT8w==
X-Google-Smtp-Source: APXvYqwjSjGlS9koWFrlkYzxbkZfKLnxgo2Qm2BB1kef2ig3XHyGmZjDbh9c5nguvIbMITmCk5E7DQ==
X-Received: by 2002:a17:902:aa03:: with SMTP id be3mr19569285plb.84.1569016391020;
        Fri, 20 Sep 2019 14:53:11 -0700 (PDT)
Received: from localhost (wsip-98-175-107-49.sd.sd.cox.net. [98.175.107.49])
        by smtp.gmail.com with ESMTPSA id b196sm35326pga.56.2019.09.20.14.53.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Sep 2019 14:53:10 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        masneyb@onstation.org, swboyd@chromium.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v4 14/15] drivers: thermal: tsens: Create function to return sign-extended temperature
Date:   Fri, 20 Sep 2019 14:52:29 -0700
Message-Id: <aa318f9ba4aa3fd13b05201743acc1ab2c1a0db1.1569015835.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1569015835.git.amit.kucheria@linaro.org>
References: <cover.1569015835.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1569015835.git.amit.kucheria@linaro.org>
References: <cover.1569015835.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hide the details of how to convert values read from TSENS HW to mCelsius
behind a function. All versions of the IP can be supported as a result.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 50 +++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index ea2c46cc6a66..6b6b3841c2d0 100644
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
@@ -310,6 +331,7 @@ int __init init_common(struct tsens_priv *priv)
 			goto err_put_device;
 		}
 	}
+
 	for (i = 0, j = VALID_0; i < priv->feat->max_sensors; i++, j++) {
 		priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
 						      priv->fields[j]);
-- 
2.17.1

