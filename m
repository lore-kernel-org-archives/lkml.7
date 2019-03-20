Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E8FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B7CD21850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uRiRyUVT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbfCTNT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:19:26 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43858 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbfCTNTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:19:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id l11so1780402pgq.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 06:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=hnKCIBqLKSdwQJ9vlhhug9tJeolwVOLt4rLlaA/Eryo=;
        b=uRiRyUVTc6/sO336lyIjrdro+0m8gCsB+1nia2+FdzfAJ2nsIEvSdG8ZhuWG1BND5Y
         XAk/bx5UKMcqYmZsaT3D/5BXerongNPtlF0fRSi03RAX4y3WNN7WD/a4yChumoPppIAy
         Fp/2k/ttABVXfyGtcZr77N+WxY+1+MpeMELzIOkYEtopYNvGq6PuyH0SBmTk++IFcnHS
         41H3YRFwFE2fGIRLYm0Uy9YcZINmjwiXo+E/d70JbCcersMuOK0fLd5Yfj7wrl69Ej4H
         GR97e3O79TC5bkbal+FZXXy1PauCMBl3g5//sQD1ZPG/hfTzisWaX8lSAwxtSuW2pQjU
         OIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=hnKCIBqLKSdwQJ9vlhhug9tJeolwVOLt4rLlaA/Eryo=;
        b=Eh1EicPwVS6h1kFstV5+d/3o/hF2rLCglbhJEQZPO1CMYZ6nzzwxWPD4W93C6VNoSf
         NF8gJ0DavcQLGksyBSNk7n3VzlWR+pbWEt/PIFmeqb7rYqNOiKLuaDdv+LRD3uzhVVaD
         KXWWKBBF/YHugTeBXHxs5EN0gM5b+oNoPIsKlpAq3tFVXXvuQyyWwhl2NZzcdeKCoAbm
         PsWmp1yalUDGCqCJcg4iVOXWUv+tOfHc/G2pjtPBTcVEXNeMalCFIxevEKHH1yCccHdB
         YAB/29wU+GXUrs/gZA9yE2rx0EwZPGTIgVASj9TPWLLxYEx5IbbV5qef1Ke79a7T6zim
         oR+A==
X-Gm-Message-State: APjAAAUb8HRq+BOZ+OzAPWdxd6nok//qH6H5gMLJrATtNCQu6PBmNFMN
        MGBTcX2QWy4qSJ6dizRaD5b1l2mCjK4=
X-Google-Smtp-Source: APXvYqyxyVShxT9oTD2/Jx0lUzGsg94t3qAXCQ0csUNcXFWaRmOgj/m+GutZrte6KmnzwDCYNNGdqg==
X-Received: by 2002:a17:902:27a8:: with SMTP id d37mr8013124plb.164.1553087961594;
        Wed, 20 Mar 2019 06:19:21 -0700 (PDT)
Received: from localhost ([114.143.122.221])
        by smtp.gmail.com with ESMTPSA id a24sm2688954pfn.85.2019.03.20.06.19.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 06:19:20 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCHv3 13/23] drivers: thermal: tsens: Add new operation to check if a sensor is enabled
Date:   Wed, 20 Mar 2019 18:47:53 +0530
Message-Id: <4917d603944b606aa3a621ef6731d3dac7cca14c.1553086065.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
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
index 9d7a6c328ae0..c76f8cfb25a2 100644
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
index d171a4a8c454..431255bfd0ef 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -333,6 +333,7 @@ const struct reg_field tsens_v0_1_regfields[MAX_REGFIELDS] = {
 	/* CTRL_OFFSET */
 	[TSENS_EN]     = REG_FIELD(SROT_CTRL_OFF, 0,  0),
 	[TSENS_SW_RST] = REG_FIELD(SROT_CTRL_OFF, 1,  1),
+	[SENSOR_EN]    = REG_FIELD(SROT_CTRL_OFF, 3, 13),
 
 	/* ----- TM ------ */
 	/* INTERRUPT ENABLE */
diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index e15a302f7878..4b98dbe4e3c3 100644
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
index a9390e06b4dd..a3bf7de88ae8 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -307,6 +307,7 @@ char *qfprom_read(struct device *dev, const char *cname);
 void compute_intercept_slope(struct tsens_priv *priv, u32 *pt1, u32 *pt2, u32 mode);
 int init_common(struct tsens_priv *priv);
 int get_temp_common(struct tsens_priv *priv, int i, int *temp);
+bool is_sensor_enabled(struct tsens_priv *priv, u32 hw_id);
 
 /* TSENS target */
 extern const struct tsens_plat_data data_8960;
-- 
2.17.1

