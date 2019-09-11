Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6565AECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 07:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF2921928
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 07:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GJlxsZb2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfIKHRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 03:17:33 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38315 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbfIKHRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 03:17:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id h195so13099239pfe.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 00:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=3XLPlhPImWAomUfs/g8BXhfm3lVXoZB+dL/zQw9KVyY=;
        b=GJlxsZb21zDn7otYAc58zN7PyahcMkAX7EQUNWffJZs6M0x8PWTmcZ1KKAhmuxa7/v
         ue70ggqmS5flX5o6oKsh1Yz/o9isB7U1Q3arBhYZJUbO9XqYbFzYbdN35eDe8QaTjGvp
         tUPhdIgxrboTihBK+X6FS+TpH+nZkcLCRz45g2Mlk3LqqkhmthATiA41Bw20vGxFJbIc
         MBXQvVkz7jJ0GrBYNYyZOy6cQc9epnmjzyWMhWZ9AMKHyiYXXrk7TZrfRuLmxWtBBz5j
         i1H1Q4fuYCbQgJ4p+8GfZQLgM5HRg7nrOmYVRS+chWO1JrYsfTnRUS0G5WIPkBXF9PbX
         z7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=3XLPlhPImWAomUfs/g8BXhfm3lVXoZB+dL/zQw9KVyY=;
        b=o9avzmV/nQ1eXF5NYuRqjDyhv0XQQkKUYgc7H821bjjgVvL14v+0jzav4/36kDYURz
         jenLzuSTUsMtHX8ozlRf9FkxXU9sYSu5bNS2tbM3+c+P4VNkTYRE6j8oeXXpHXsQhHLO
         P1eYeI7I1eXaXkbGXAimtoVLA9aRSnOlbAPjXlZ5CTw+8E8b5RZFKvFxvDgeRwfZ0jGp
         zKPA0DZTj5N1obnDzd+WBbr2YYFiADgj3GKSzoM33U5fuRybhwAqMs8U+sPq0BlO/avI
         QWw0x8r6a51S8T4vFSX+MH9EqXGuofT0UuejBI15NLGxHs4xXZhEKdvHptDPEHigok08
         5Fyw==
X-Gm-Message-State: APjAAAXpnbpYWLiPFhcGACURvVvtE9yt8MHTwqnywGoSr7xAHnbL4e6t
        QMVbgnDLV7bVfF/pnXbgPRj7UwtgA8kcDw==
X-Google-Smtp-Source: APXvYqzN60HuYuLCnJPEkqZsm/s5+WhfDQTCtn2qAVU9cHJ5lsnpY3WrGzuMoIBnXeqqNrV8oFi6FQ==
X-Received: by 2002:a65:6097:: with SMTP id t23mr31510470pgu.357.1568186251210;
        Wed, 11 Sep 2019 00:17:31 -0700 (PDT)
Received: from localhost ([49.248.201.118])
        by smtp.gmail.com with ESMTPSA id h3sm833961pgb.13.2019.09.11.00.17.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Sep 2019 00:17:30 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        masneyb@onstation.org, swboyd@chromium.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v3 14/15] drivers: thermal: tsens: Create function to return sign-extended temperature
Date:   Wed, 11 Sep 2019 12:46:31 +0530
Message-Id: <a70e3fd63774f87d24374c12f63c2f311d6d4ba5.1568185732.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1568185732.git.amit.kucheria@linaro.org>
References: <cover.1568185732.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1568185732.git.amit.kucheria@linaro.org>
References: <cover.1568185732.git.amit.kucheria@linaro.org>
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

