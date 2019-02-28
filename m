Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04093C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8A42171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G2rzRguJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731912AbfB1M1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:27:50 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36846 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731883AbfB1M1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 07:27:48 -0500
Received: by mail-wm1-f67.google.com with SMTP id j125so8756967wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 04:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=kuDa3PTq6kESR0Oy4w3BK/UNqfJyke/AMtphy3RDuRw=;
        b=G2rzRguJ3gSkHxStd9Hzh9TnP7wdGK0BT/re/M7y8nb5Kmp0RYg5plB/PC6lJ+b35b
         iNi2n3RM51MzyZbM7lAlJjIF015FLLqbyANSaSOP5eph6jtvH8BpjQf+PmD/Dmss6T+9
         NzxeBm7Iq8Nu/Y6brXSe1MuYcW2rFIvHPRYRKyFYdA3fQxCFLElc0yipzOZj0u9986ib
         1EPptnNYp80fmYFoE7AI2SvxjY0MOLOtUmu/4ili7PLq48LZS3e3OM3euatfeibY6AYA
         QOg1efn+zC3YTPo78TtCaGr5ohO3PC878b3fGBzU4yFRkLjJb7kC3P6yt6+3FujJNZtp
         pjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=kuDa3PTq6kESR0Oy4w3BK/UNqfJyke/AMtphy3RDuRw=;
        b=Jl0YP2FPfNJofGNF9iEkwx2AJ50BOrp6K84+eMM1/B3R+Ns5WpVeW+sM4Bx7v7a1ly
         meBByYHOpMNmtW5yShMBwvWJ+3u3e8nNrumvm/vTM8vvTI4UXrIQFok9rLebCn6YQpPu
         dTyq/weoZLBc5b0KmdjVJoFXXR/PImHwNqWsQ6+MQ8u03fziKXpFKaYC9xt47WdLS58K
         C6iKT+2w0sbgFo6R8SWcazjuNtmnMNMoSsJlbZOdqAPjZufxsyVXH5f8pLm+r+qmKVvj
         UDw5+6rHloTzOKtYfUurD0EG8q5yae+Jagr3TpOpbHLHD6zcWXX8Cp13i6c036y+KRn/
         2Ang==
X-Gm-Message-State: AHQUAuY/bJ00jGBX8ajRQVm55kUJhvci/r3ckxo9gsXIsA4k24MVMxYU
        GE7UZOcfrO2OxDThf3ICJmgH8BZJpkI=
X-Google-Smtp-Source: APXvYqw01hiHpZ1TeQjC/Onu9XdUEh4grpO/jSuyRPqWdSc7EVN8EmYCerrrLrkLVCnMgixvgWpAVA==
X-Received: by 2002:a7b:c929:: with SMTP id h9mr2791511wml.106.1551356865071;
        Thu, 28 Feb 2019 04:27:45 -0800 (PST)
Received: from localhost ([49.248.54.130])
        by smtp.gmail.com with ESMTPSA id a8sm5723653wmh.26.2019.02.28.04.27.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 04:27:44 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v2 18/24] drivers: thermal: tsens: Move get_temp_tsens_v2 to allow sharing
Date:   Thu, 28 Feb 2019 17:51:08 +0530
Message-Id: <30911f4ce9cd5094d4dea29d1e92da3cca6f7537.1551355503.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
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
index 5f838fd798c3..7bab0e640806 100644
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
index e180e80f533c..2e2331f5c248 100644
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
@@ -114,7 +79,7 @@ const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
 
 static const struct tsens_ops ops_generic_v2 = {
 	.init		= init_common,
-	.get_temp	= get_temp_tsens_v2,
+	.get_temp	= get_temp_tsens_valid,
 };
 
 const struct tsens_plat_data data_tsens_v2 = {
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index eb988c1d17c4..1cef2b8431eb 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -363,6 +363,7 @@ struct tsens_priv {
 char *qfprom_read(struct device *dev, const char *cname);
 void compute_intercept_slope(struct tsens_priv *priv, u32 *pt1, u32 *pt2, u32 mode);
 int init_common(struct tsens_priv *priv);
+int get_temp_tsens_valid(struct tsens_priv *priv, int i, int *temp);
 int get_temp_common(struct tsens_priv *priv, int i, int *temp);
 bool is_sensor_enabled(struct tsens_priv *priv, u32 hw_id);
 
-- 
2.17.1

