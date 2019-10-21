Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6F6CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF72E214B2
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BuiQwH1N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbfJUKgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 06:36:36 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38295 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728397AbfJUKgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 06:36:33 -0400
Received: by mail-pl1-f193.google.com with SMTP id w8so6423821plq.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 03:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=0WsTUto1EYkvMJZ+e6vQdDqYayMlmhgUas0MuLlp+q8=;
        b=BuiQwH1NuI9rAQ1fNEk95k5s7p7HCgQHuiuf4lSnqToB9zfnVQdTxIWcYh+AzYJSgi
         6DZcFpM5mQXM44D1usVII25lesoY3vJwT6lG85Waj5JbOt1YjwX76iaevWi1k0gnAatK
         CemNiPO51im7lMFWfCPsXl00qbm4xeNUKbEFuCnTlIQuLYTLTvQBMxhIZl9dteKECikG
         Zd5tv/df2quGJ+fm4aHBG99HtO8UwW4+HWLe8zO3gHPDaRTEYCsX1+LimJXozZcZ8aiz
         AOttS8XF14h9IVT+9Rwpb5GOtd62RRHXezu86KXVDqW/xqhsej+GFW/fzWyuCgy9HhB7
         2OZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=0WsTUto1EYkvMJZ+e6vQdDqYayMlmhgUas0MuLlp+q8=;
        b=eUc1dJ/3qjPtLP8UXltbUmS1WBIYLRWp9wDLdcNaoDfRcF8u3Gp6c+Z+oF/3CPraWH
         9PpCHj3yuZFwfAeGQuXHQHOC6Sa9oHKjscN3055qM1xqUY1VMJGkWlXX/BotL99hmPDC
         7r6pdTGu/0AlBtxRwb59KSjseC77u/w6FAZqxIvcHpaPl98+bdCENOvjYjDurycmL2I1
         MuZKcK/BkVIemSbHyoLakkIByRepYFhiIqrnkRa2EoD52lfmcFAz1A899Q/q+6C9EISq
         8Y51z+SvRN13xMSQvgVbcXceBneTi7pFXtrsyWiGQ1Yk1tIITMRGkacpwGbfpXT2uDhV
         1Jgw==
X-Gm-Message-State: APjAAAWiKDm6ikvJSeE3eAdN3jGxu/sbPSf/DAj9f5nHSt/0IaY4DcLQ
        lIs+H6kM1OUV/stlusXG4LGNMhn7hVNYAw==
X-Google-Smtp-Source: APXvYqz4qY1pzInsqF+/DLgEGRbW7/FZgMPVWcaEtlgxH519WfQrnOuiWr5pEtx/dCuGz95VNs3wkw==
X-Received: by 2002:a17:902:a618:: with SMTP id u24mr23620577plq.112.1571654192631;
        Mon, 21 Oct 2019 03:36:32 -0700 (PDT)
Received: from localhost ([49.248.62.222])
        by smtp.gmail.com with ESMTPSA id p36sm6572055pgm.55.2019.10.21.03.36.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 03:36:32 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        masneyb@onstation.org, swboyd@chromium.org, julia.lawall@lip6.fr,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v6 14/15] drivers: thermal: tsens: Create function to return sign-extended temperature
Date:   Mon, 21 Oct 2019 16:05:33 +0530
Message-Id: <0689917475cf83b7e01f6978504fd37352a5e3ca.1571652874.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571652874.git.amit.kucheria@linaro.org>
References: <cover.1571652874.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1571652874.git.amit.kucheria@linaro.org>
References: <cover.1571652874.git.amit.kucheria@linaro.org>
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
index ea2c46cc6a66a..c34a1a26ce298 100644
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

