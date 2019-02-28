Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CD0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4292C2083D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FEtnL2+z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731556AbfB1M1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:27:25 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55379 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731487AbfB1M1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 07:27:22 -0500
Received: by mail-wm1-f66.google.com with SMTP id q187so9082250wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 04:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=/1gd8IKg0q3LX4r6cAyTmT7v/j8x/tNCsc6wFDx80aM=;
        b=FEtnL2+zEr1y4zaaSepprM7ePpRRUD5cagUQjg1rd3c7yC0S+8GoZzEkEhs7tPrOd6
         Dhg16OAHXf+azPP9cZc6M/5Z4ydJI4orAHoFMEvFNa/OCy0bNazmakxaIvxnx72j5OHj
         rFINWiNYW4HZp/oK9u3KFSB65iGOBiewYd3/ApmrEhldqEiRprG5wVXpHIUdy6wU/LdG
         AWIJmo4+BFphq1TzKml9Ow+346gSFmvLHapF3I3wnrzGhvzCW4cUfYfRHrO/V+a1QU6w
         FkdIXDmfa7OqOlDGbl1ODVXdai+mapQtmMVuHgChIkSJerxgMAfW7NyRAfwRsPix6Nf9
         Ehgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=/1gd8IKg0q3LX4r6cAyTmT7v/j8x/tNCsc6wFDx80aM=;
        b=UXrCGPG9PSH7giqsunrsDTP4vYpqO7EwvHP6ZnbnqPkkXMewZkEl2e8JHPEkP6j5JR
         tqraSS0nSNVVF6w+cZV8dgvbPOEISjqvJChnHLWqlRCGBxCyHsyBT531dOgutUxBvteJ
         ML5LRb98+doL+Lz2jPqskApd2HMt1KmYELHMu8h7L44QCASt9TY4Huihl0Drc8VAVMyV
         3paz02TqN++A7qPHAuj41MpeM82IYC8nDUCnWcd9OV2ipXNs3eN+UW4sLo/jLHQXUSQn
         4p8gTlXuMDqDOdjjqptd2pY33MOs0iGSAQ9EzOad+dJglaC26ZfsI1uo4hOsCJ28QNAC
         rPzQ==
X-Gm-Message-State: AHQUAuY/OyphlIkeagG96SzwSl+Y8pqz6B9/DNkyjB3ZCA3C2NRuzTdW
        FnPQtB15hE+sSs18UIS5wLGeRxVZ650=
X-Google-Smtp-Source: APXvYqzgjDFwWH5UaXNObGASyERMmyyMXi2HYY1tI1m9+MaLwnpJM5BzdykMce1UleEWS+3lxb3epw==
X-Received: by 2002:a1c:101:: with SMTP id 1mr2800221wmb.128.1551356840423;
        Thu, 28 Feb 2019 04:27:20 -0800 (PST)
Received: from localhost ([49.248.54.130])
        by smtp.gmail.com with ESMTPSA id t133sm4333009wmf.3.2019.02.28.04.27.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 04:27:19 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v2 14/24] drivers: thermal: tsens: Add new operation to check if a sensor is enabled
Date:   Thu, 28 Feb 2019 17:51:04 +0530
Message-Id: <6d377f9e12f513edde6e82ed28803172c45731ab.1551355503.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

is_sensor_enabled() checks if the sensors are enabled on this platform.
It is possible that the SoC might choose not to enable all the sensors
that the IP block is capable of supporting.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 14 ++++++++++++++
 drivers/thermal/qcom/tsens-v0_1.c   |  1 +
 drivers/thermal/qcom/tsens-v2.c     |  1 +
 drivers/thermal/qcom/tsens.c        |  5 +++++
 drivers/thermal/qcom/tsens.h        |  1 +
 5 files changed, 22 insertions(+)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 8d632de2c7f8..c58ba4c200bc 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -69,6 +69,20 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *p1,
 	}
 }
 
+bool is_sensor_enabled(struct tsens_priv *priv, u32 hw_id)
+{
+	u32 val;
+	int ret;
+
+	if ((hw_id > (priv->num_sensors - 1)) || (hw_id < 0))
+		return -EINVAL;
+	ret = regmap_field_read(priv->rf[SENSOR_EN], &val);
+	if (ret)
+		return ret;
+
+	return val & (1 << hw_id);
+}
+
 static inline int code_to_degc(u32 adc_code, const struct tsens_sensor *s)
 {
 	int degc, num, den;
diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index 1c0428daa9c4..837e7872e512 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -332,6 +332,7 @@ const struct reg_field tsens_v0_1_regfields[MAX_REGFIELDS] = {
 	/* CTRL_OFFSET */
 	[TSENS_EN]     = REG_FIELD(SROT_CTRL_OFF, 0,  0),
 	[TSENS_SW_RST] = REG_FIELD(SROT_CTRL_OFF, 1,  1),
+	[SENSOR_EN]    = REG_FIELD(SROT_CTRL_OFF, 3, 13),
 
 	/* ----- TM ------ */
 	/* UPPER_LOWER_INTERRUPT_CTRL */
diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index e021b6dd2420..7346bfc9efe6 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -99,6 +99,7 @@ const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
 	/* CTRL_OFF */
 	[TSENS_EN]     = REG_FIELD(SROT_CTRL_OFF,    0,  0),
 	[TSENS_SW_RST] = REG_FIELD(SROT_CTRL_OFF,    1,  1),
+	[SENSOR_EN]    = REG_FIELD(SROT_CTRL_OFF,    3, 18),
 
 	/* ----- TM ------ */
 	/* INTERRUPT ENABLE */
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 057b33353ba3..fc44cac31fa5 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -82,6 +82,11 @@ static int tsens_register(struct tsens_priv *priv)
 	struct thermal_zone_device *tzd;
 
 	for (i = 0;  i < priv->num_sensors; i++) {
+		if (!is_sensor_enabled(priv, priv->sensor[i].hw_id)) {
+			dev_err(priv->dev, "sensor %d: disabled\n",
+				priv->sensor[i].hw_id);
+			continue;
+		}
 		priv->sensor[i].priv = priv;
 		priv->sensor[i].id = i;
 		tzd = devm_thermal_zone_of_sensor_register(priv->dev, i,
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index a93d14dee69b..023fed3352e3 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -362,6 +362,7 @@ char *qfprom_read(struct device *dev, const char *cname);
 void compute_intercept_slope(struct tsens_priv *priv, u32 *pt1, u32 *pt2, u32 mode);
 int init_common(struct tsens_priv *priv);
 int get_temp_common(struct tsens_priv *priv, int i, int *temp);
+bool is_sensor_enabled(struct tsens_priv *priv, u32 hw_id);
 
 /* TSENS target */
 extern const struct tsens_plat_data data_8960;
-- 
2.17.1

