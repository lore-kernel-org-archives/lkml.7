Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B713C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51DEF2184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I8+sJ+LP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbfCTNTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:19:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37641 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728324AbfCTNTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:19:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id 8so1934128pfr.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 06:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=a0G0N6buTKooxPqu5bVGNMmItUQCR7PXXaszMXTU5cY=;
        b=I8+sJ+LP+z4on0Uy7pXj2R9M+FReLV/2w9thUCSidfJHSBpo7al8y2XT+1ohkAdBpM
         A/wue3RfnTj51CzjrLNnJjLAyvJKcs28vQYPDhiZtdXJTQzn6PQ8z5As8IG4nth1WZRA
         BL+0Nnm2c2ClYyfTCyS+TO7hijxBhREfmeUjRtnXNhgmL6yOvRlSGQ5rru0Ix+LUULiy
         5pVjLvUJFYdWAZzzJ9R5h8dS8GhGWV35M+ccQRLZPy6fOLCOt45GM370e6QIe2RGbK5V
         ErO+VnHcMl23ffRV4PF+JmyZcSsJt4rgdNI6q3MXdyE1uMFz5tTay7NCOtfQf9Mmdvm/
         dZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=a0G0N6buTKooxPqu5bVGNMmItUQCR7PXXaszMXTU5cY=;
        b=rJaamutgB7svSgvKQQC+fsTbj58UkOYfkjf6bJEcGggW5o0u+0KCOpUs2BH+N/W4dG
         CdKgC2QpxRfpacBfw3KtpqzlhBJ35fTJ/+DB6Fb8GHpVqnWOZux4x3YD+6Ub1/uFRFQq
         dyxG1SR6MnNOQ4zWj58KmATDJOPRJHMzBKHSKgY2CuTIh8wiEW/UDRJo5PAJSa/Pd0KR
         rsEs8Vh9xuznIi3UO/C3ylA5Z7Q/2w5rbePVfnLJ0plHTiJ9v1Uou3r8z96qSD1nlkWB
         2ZtDI2GU4NOaYPBY0+lZH+4o/3EAyK6mHPj7EVynLIBfC07zU+AED367Dgt2FGw7xuHd
         5ayA==
X-Gm-Message-State: APjAAAWUBrVtEMVxS6KFyaWmg2IOQOkmormo9Rp0CnTTsNNMuPLRl2eJ
        4g2HU7qGJP4vmCvnsAgO+3ybW0M0rzk=
X-Google-Smtp-Source: APXvYqwLI6vqL98LuRTLBSp3a+Ilff2FY8DtkepVCSdE+SzNRPPuyYNYPhHYbFPuJlUyS4Qroj8smA==
X-Received: by 2002:a62:2e07:: with SMTP id u7mr7444855pfu.176.1553087978358;
        Wed, 20 Mar 2019 06:19:38 -0700 (PDT)
Received: from localhost ([114.143.122.221])
        by smtp.gmail.com with ESMTPSA id h3sm2361211pgv.38.2019.03.20.06.19.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 06:19:37 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCHv3 17/23] drivers: thermal: tsens: Move get_temp_tsens_v2 to allow sharing
Date:   Wed, 20 Mar 2019 18:47:57 +0530
Message-Id: <eedfe8325f1dac06c538cb0355af0d9769a02069.1553086065.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just rename the function and move it to allow code sharing with future
versions of TSENS IP

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 35 +++++++++++++++++++++++++++
 drivers/thermal/qcom/tsens-v2.c     | 37 +----------------------------
 drivers/thermal/qcom/tsens.h        |  1 +
 3 files changed, 37 insertions(+), 36 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 5607c5cc635c..5adbf1a2e0fb 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -102,6 +102,41 @@ static inline int code_to_degc(u32 adc_code, const struct tsens_sensor *s)
 	return degc;
 }
 
+int get_temp_tsens_valid(struct tsens_priv *priv, int i, int *temp)
+{
+	struct tsens_sensor *s = &priv->sensor[i];
+	u32 temp_idx = LAST_TEMP_0 + s->hw_id;
+	u32 valid_idx = VALID_0 + s->hw_id;
+	u32 last_temp = 0, valid, mask;
+	int ret;
+
+	ret = regmap_field_read(priv->rf[valid_idx], &valid);
+	if (ret)
+		return ret;
+	while (!valid) {
+		/* Valid bit is 0 for 6 AHB clock cycles.
+		 * At 19.2MHz, 1 AHB clock is ~60ns.
+		 * We should enter this loop very, very rarely.
+		 */
+		ndelay(400);
+		ret = regmap_field_read(priv->rf[valid_idx], &valid);
+		if (ret)
+			return ret;
+	}
+
+	/* Valid bit is set, OK to read the temperature */
+	ret = regmap_field_read(priv->rf[temp_idx], &last_temp);
+	if (ret)
+		return ret;
+
+	mask = GENMASK(priv->fields[LAST_TEMP_0].msb,
+		       priv->fields[LAST_TEMP_0].lsb);
+	/* Convert temperature from deciCelsius to milliCelsius */
+	*temp = sign_extend32(last_temp, fls(mask) - 1) * 100;
+
+	return 0;
+}
+
 int get_temp_common(struct tsens_priv *priv, int i, int *temp)
 {
 	struct tsens_sensor *s = &priv->sensor[i];
diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 716d7f827459..36fbfa6a471e 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -25,41 +25,6 @@
 #define TM_Sn_STATUS_OFF		0x00a0
 #define TM_TRDY_OFF			0x00e4
 
-static int get_temp_tsens_v2(struct tsens_priv *priv, int i, int *temp)
-{
-	struct tsens_sensor *s = &priv->sensor[i];
-	u32 temp_idx = LAST_TEMP_0 + s->hw_id;
-	u32 valid_idx = VALID_0 + s->hw_id;
-	u32 last_temp = 0, valid, mask;
-	int ret;
-
-	ret = regmap_field_read(priv->rf[valid_idx], &valid);
-	if (ret)
-		return ret;
-	while (!valid) {
-		/* Valid bit is 0 for 6 AHB clock cycles.
-		 * At 19.2MHz, 1 AHB clock is ~60ns.
-		 * We should enter this loop very, very rarely.
-		 */
-		ndelay(400);
-		ret = regmap_field_read(priv->rf[valid_idx], &valid);
-		if (ret)
-			return ret;
-	}
-
-	/* Valid bit is set, OK to read the temperature */
-	ret = regmap_field_read(priv->rf[temp_idx], &last_temp);
-	if (ret)
-		return ret;
-
-	mask = GENMASK(priv->fields[LAST_TEMP_0].msb,
-		       priv->fields[LAST_TEMP_0].lsb);
-	/* Convert temperature from deciCelsius to milliCelsius */
-	*temp = sign_extend32(last_temp, fls(mask) - 1) * 100;
-
-	return 0;
-}
-
 /* v2.x: 8996, 8998, sdm845 */
 
 const struct tsens_features tsens_v2_feat = {
@@ -101,7 +66,7 @@ const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
 
 static const struct tsens_ops ops_generic_v2 = {
 	.init		= init_common,
-	.get_temp	= get_temp_tsens_v2,
+	.get_temp	= get_temp_tsens_valid,
 };
 
 const struct tsens_plat_data data_tsens_v2 = {
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 080e15a09ac2..f14a87aa1a47 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -308,6 +308,7 @@ struct tsens_priv {
 char *qfprom_read(struct device *dev, const char *cname);
 void compute_intercept_slope(struct tsens_priv *priv, u32 *pt1, u32 *pt2, u32 mode);
 int init_common(struct tsens_priv *priv);
+int get_temp_tsens_valid(struct tsens_priv *priv, int i, int *temp);
 int get_temp_common(struct tsens_priv *priv, int i, int *temp);
 bool is_sensor_enabled(struct tsens_priv *priv, u32 hw_id);
 
-- 
2.17.1

