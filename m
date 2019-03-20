Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B76AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF5B2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uvKqXscz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbfCTNTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:19:12 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38064 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728221AbfCTNTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:19:10 -0400
Received: by mail-pf1-f196.google.com with SMTP id 10so1930308pfo.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 06:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=000Nxomj5cH53K32Cb+mEu91Zlm2VgiYrpJwNJqpAWg=;
        b=uvKqXsczGmwSKkjXFbEqWfPy1F7V2ws5ViC7A+wQQq2gWM+t3K+t97n7EQcb9bYNUQ
         Zu7VgcS7+JdUOb8I7fQvpCqt3j7Q61pxu5AZQq27WxzKRl1UzMLnTcnBmk+lGw+qkYMV
         iqpzq/2vW7KNLDAv6VU+UVsl+hWcHBs8ygkQx3VY3EjpCEqw//6aNmgFlA2X1MNz7+Lj
         kS2Yzby5MIdfNXOBce59wKeglAJUeUdTJhxx4ZJjILJi3u621l9ncGDUFiIyykfcpgEQ
         XDpve7MI3m4ueEbQwqNErtItTrI1bjPbAAbhKpsBSRBzNxaIWRICnzkZ7WAaHRhOYDuw
         R53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=000Nxomj5cH53K32Cb+mEu91Zlm2VgiYrpJwNJqpAWg=;
        b=rYZHX24YfVvlhA6F2YEaB9oRbGJst35jSBfbYT3I5II5C0kyPTrRs/V04I3P7XwXT1
         91xm/lWuKbO1zsXZEbjxFQIwprxUexM9PjvXGQS5KFpLZxlSJr4RlAv1wXaPBftTfaCg
         QaseU5Wlr/y22hMB+SZPBCA+jHgdPzB/ybLe9GSDNOqtgsU0Kqi6xqqsNK3E1caUH09q
         jh8iV4TCF06zgQhVb1AIMRtpEdeJ5vaplP0jxLhu//Kb5c6n/6gjkFoSWNcGNFRFDG5E
         Hnt3ON5mldN4zjvhoszs3YjTxtv6+0tpJXOhXweG3rV5N1olCgenZBLzoiN6qhsyQUIA
         TUzA==
X-Gm-Message-State: APjAAAWnggG/udh9ZbY3KRdPSG4dMh8zeqs6CvppCSv30b5mz6e8onsz
        6E2BMigi2x7JqZV569WeUBeLuQiLQtg=
X-Google-Smtp-Source: APXvYqwYbkpGsZKDn8GK19cK8KkO1c4cA5alD9JxD99cBZ/QHV47zYenOA3PDvAnfb4glwZaMH4vIA==
X-Received: by 2002:a63:c84c:: with SMTP id l12mr7396138pgi.287.1553087948548;
        Wed, 20 Mar 2019 06:19:08 -0700 (PDT)
Received: from localhost ([114.143.122.221])
        by smtp.gmail.com with ESMTPSA id m13sm4739305pff.175.2019.03.20.06.19.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 06:19:07 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCHv3 10/23] drivers: thermal: tsens: Introduce reg_fields to deal with register description
Date:   Wed, 20 Mar 2019 18:47:50 +0530
Message-Id: <008c9fa480dbeaf512ecccfbbc117176d570ded6.1553086065.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we add support for newer versions of the TSENS IP, the current
approach isn't scaling because registers and bitfields get moved around,
requiring platform-specific hacks in the code. By moving to regmap, we
can hide the register level differences away from the code.

Define a common set of registers and bit-fields that we care about
across the various tsens IP versions.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c |  62 +++++----
 drivers/thermal/qcom/tsens-v0_1.c   |  50 ++++++-
 drivers/thermal/qcom/tsens-v2.c     | 105 ++++++++++----
 drivers/thermal/qcom/tsens.c        |   5 +-
 drivers/thermal/qcom/tsens.h        | 206 +++++++++++++++++++++++++++-
 5 files changed, 370 insertions(+), 58 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index f0ef4e3cf7f9..0f9deec2517a 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -12,13 +12,6 @@
 #include <linux/regmap.h>
 #include "tsens.h"
 
-/* SROT */
-#define TSENS_EN		BIT(0)
-
-/* TM */
-#define STATUS_OFFSET		0x30
-#define SN_ADDR_OFFSET		0x4
-#define SN_ST_TEMP_MASK		0x3ff
 #define CAL_DEGC_PT1		30
 #define CAL_DEGC_PT2		120
 #define SLOPE_FACTOR		1000
@@ -95,18 +88,14 @@ static inline int code_to_degc(u32 adc_code, const struct tsens_sensor *s)
 	return degc;
 }
 
-int get_temp_common(struct tsens_priv *priv, int id, int *temp)
+int get_temp_common(struct tsens_priv *priv, int i, int *temp)
 {
-	struct tsens_sensor *s = &priv->sensor[id];
-	u32 code;
-	unsigned int status_reg;
+	struct tsens_sensor *s = &priv->sensor[i];
 	int last_temp = 0, ret;
 
-	status_reg = priv->tm_offset + STATUS_OFFSET + s->hw_id * SN_ADDR_OFFSET;
-	ret = regmap_read(priv->tm_map, status_reg, &code);
+	ret = regmap_field_read(priv->rf[LAST_TEMP_0 + s->hw_id], &last_temp);
 	if (ret)
 		return ret;
-	last_temp = code & SN_ST_TEMP_MASK;
 
 	*temp = code_to_degc(last_temp, s) * 1000;
 
@@ -131,10 +120,9 @@ int __init init_common(struct tsens_priv *priv)
 {
 	void __iomem *tm_base, *srot_base;
 	struct resource *res;
-	u32 code;
-	int ret;
+	u32 enabled;
+	int ret, i, j;
 	struct platform_device *op = of_find_device_by_node(priv->dev->of_node);
-	u16 ctrl_offset = priv->reg_offsets[SROT_CTRL_OFFSET];
 
 	if (!op)
 		return -EINVAL;
@@ -173,13 +161,41 @@ int __init init_common(struct tsens_priv *priv)
 		goto err_put_device;
 	}
 
-	if (priv->srot_map) {
-		ret = regmap_read(priv->srot_map, ctrl_offset, &code);
-		if (ret)
+	priv->rf[TSENS_EN] = devm_regmap_field_alloc(priv->dev, priv->srot_map,
+						     priv->fields[TSENS_EN]);
+	if (IS_ERR(priv->rf[TSENS_EN])) {
+		ret = PTR_ERR(priv->rf[TSENS_EN]);
+		goto err_put_device;
+	}
+	ret = regmap_field_read(priv->rf[TSENS_EN], &enabled);
+	if (ret)
+		goto err_put_device;
+	if (!enabled) {
+		dev_err(priv->dev, "tsens device is not enabled\n");
+		ret = -ENODEV;
+		goto err_put_device;
+	}
+
+	priv->rf[SENSOR_EN] = devm_regmap_field_alloc(priv->dev, priv->srot_map,
+						      priv->fields[SENSOR_EN]);
+	if (IS_ERR(priv->rf[SENSOR_EN])) {
+		ret = PTR_ERR(priv->rf[SENSOR_EN]);
+		goto err_put_device;
+	}
+	/* now alloc regmap_fields in tm_map */
+	for (i = 0, j = LAST_TEMP_0; i < priv->num_sensors; i++, j++) {
+		priv->rf[j] = devm_regmap_field_alloc(priv->dev, priv->tm_map,
+						      priv->fields[j]);
+		if (IS_ERR(priv->rf[j])) {
+			ret = PTR_ERR(priv->rf[j]);
 			goto err_put_device;
-		if (!(code & TSENS_EN)) {
-			dev_err(priv->dev, "tsens device is not enabled\n");
-			ret = -ENODEV;
+		}
+	}
+	for (i = 0, j = VALID_0; i < priv->num_sensors; i++, j++) {
+		priv->rf[j] = devm_regmap_field_alloc(priv->dev, priv->tm_map,
+						      priv->fields[j]);
+		if (IS_ERR(priv->rf[j])) {
+			ret = PTR_ERR(priv->rf[j]);
 			goto err_put_device;
 		}
 	}
diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index a6e26be1234f..d171a4a8c454 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -6,6 +6,15 @@
 #include <linux/platform_device.h>
 #include "tsens.h"
 
+/* ----- SROT ------ */
+#define SROT_CTRL_OFF 0x0000
+
+/* ----- TM ------ */
+#define TM_INT_EN_OFF				0x0000
+#define TM_Sn_UPPER_LOWER_STATUS_CTRL_OFF	0x0004
+#define TM_Sn_STATUS_OFF			0x0030
+#define TM_TRDY_OFF				0x005c
+
 /* eeprom layout data for 8916 */
 #define MSM8916_BASE0_MASK	0x0000007f
 #define MSM8916_BASE1_MASK	0xfe000000
@@ -308,6 +317,40 @@ static int calibrate_8974(struct tsens_priv *priv)
 	return 0;
 }
 
+/* v0.1: 8916, 8974 */
+
+const struct tsens_features tsens_v0_1_feat = {
+	.ver_major	= VER_0_1,
+	.crit_int	= 0,
+	.adc		= 1,
+	.srot_split	= 1,
+};
+
+const struct reg_field tsens_v0_1_regfields[MAX_REGFIELDS] = {
+	/* ----- SROT ------ */
+	/* No VERSION information */
+
+	/* CTRL_OFFSET */
+	[TSENS_EN]     = REG_FIELD(SROT_CTRL_OFF, 0,  0),
+	[TSENS_SW_RST] = REG_FIELD(SROT_CTRL_OFF, 1,  1),
+
+	/* ----- TM ------ */
+	/* INTERRUPT ENABLE */
+	[INT_EN] = REG_FIELD(TM_INT_EN_OFF, 0, 0),
+
+	/* Sn_STATUS */
+	REG_FIELD_FOR_EACH_SENSOR11(LAST_TEMP,    TM_Sn_STATUS_OFF,  0,  9),
+	/* No VALID field on v0.1 */
+	REG_FIELD_FOR_EACH_SENSOR11(MIN_STATUS,   TM_Sn_STATUS_OFF, 10, 10),
+	REG_FIELD_FOR_EACH_SENSOR11(LOWER_STATUS, TM_Sn_STATUS_OFF, 11, 11),
+	REG_FIELD_FOR_EACH_SENSOR11(UPPER_STATUS, TM_Sn_STATUS_OFF, 12, 12),
+	/* No CRITICAL field on v0.1 */
+	REG_FIELD_FOR_EACH_SENSOR11(MAX_STATUS,   TM_Sn_STATUS_OFF, 13, 13),
+
+	/* TRDY: 1=ready, 0=in progress */
+	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
+};
+
 static const struct tsens_ops ops_8916 = {
 	.init		= init_common,
 	.calibrate	= calibrate_8916,
@@ -317,8 +360,10 @@ static const struct tsens_ops ops_8916 = {
 const struct tsens_plat_data data_8916 = {
 	.num_sensors	= 5,
 	.ops		= &ops_8916,
-	.reg_offsets	= { [SROT_CTRL_OFFSET] = 0x0 },
 	.hw_ids		= (unsigned int []){0, 1, 2, 4, 5 },
+
+	.feat		= &tsens_v0_1_feat,
+	.fields	= tsens_v0_1_regfields,
 };
 
 static const struct tsens_ops ops_8974 = {
@@ -330,5 +375,6 @@ static const struct tsens_ops ops_8974 = {
 const struct tsens_plat_data data_8974 = {
 	.num_sensors	= 11,
 	.ops		= &ops_8974,
-	.reg_offsets	= { [SROT_CTRL_OFFSET] = 0x0 },
+	.feat		= &tsens_v0_1_feat,
+	.fields	= tsens_v0_1_regfields,
 };
diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 8b700772d903..e15a302f7878 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -4,50 +4,70 @@
  * Copyright (c) 2018, Linaro Limited
  */
 
-#include <linux/regmap.h>
 #include <linux/bitops.h>
+#include <linux/regmap.h>
 #include "tsens.h"
 
-#define STATUS_OFFSET		0xa0
+/* ----- SROT ------ */
+#define SROT_HW_VER_OFF	0x0000
+#define SROT_CTRL_OFF		0x0004
+
+/* ----- TM ------ */
+#define TM_INT_EN_OFF			0x0004
+#define TM_UPPER_LOWER_INT_STATUS_OFF	0x0008
+#define TM_UPPER_LOWER_INT_CLEAR_OFF	0x000c
+#define TM_UPPER_LOWER_INT_MASK_OFF	0x0010
+#define TM_CRITICAL_INT_STATUS_OFF	0x0014
+#define TM_CRITICAL_INT_CLEAR_OFF	0x0018
+#define TM_CRITICAL_INT_MASK_OFF	0x001c
+#define TM_Sn_UPPER_LOWER_THRESHOLD_OFF 0x0020
+#define TM_Sn_CRITICAL_THRESHOLD_OFF	0x0060
+#define TM_Sn_STATUS_OFF		0x00a0
+#define TM_TRDY_OFF			0x00e4
+
 #define LAST_TEMP_MASK		0xfff
-#define STATUS_VALID_BIT	BIT(21)
 
 static int get_temp_tsens_v2(struct tsens_priv *priv, int id, int *temp)
 {
 	struct tsens_sensor *s = &priv->sensor[id];
-	u32 code;
-	unsigned int status_reg;
-	u32 last_temp = 0, last_temp2 = 0, last_temp3 = 0;
+	u32 temp_idx = LAST_TEMP_0 + s->hw_id;
+	u32 valid_idx = VALID_0 + s->hw_id;
+	u32 last_temp = 0, last_temp2 = 0, last_temp3 = 0, valid;
 	int ret;
 
-	status_reg = priv->tm_offset + STATUS_OFFSET + s->hw_id * 4;
-	ret = regmap_read(priv->tm_map, status_reg, &code);
+	ret = regmap_field_read(priv->rf[temp_idx], &last_temp);
+	if (ret)
+		return ret;
+
+	ret = regmap_field_read(priv->rf[valid_idx], &valid);
 	if (ret)
 		return ret;
-	last_temp = code & LAST_TEMP_MASK;
-	if (code & STATUS_VALID_BIT)
+
+	if (valid)
 		goto done;
 
 	/* Try a second time */
-	ret = regmap_read(priv->tm_map, status_reg, &code);
+	ret = regmap_field_read(priv->rf[valid_idx], &valid);
+	if (ret)
+		return ret;
+	ret = regmap_field_read(priv->rf[temp_idx], &last_temp2);
 	if (ret)
 		return ret;
-	if (code & STATUS_VALID_BIT) {
-		last_temp = code & LAST_TEMP_MASK;
+	if (valid) {
+		last_temp = last_temp2;
 		goto done;
-	} else {
-		last_temp2 = code & LAST_TEMP_MASK;
 	}
 
 	/* Try a third/last time */
-	ret = regmap_read(priv->tm_map, status_reg, &code);
+	ret = regmap_field_read(priv->rf[valid_idx], &valid);
 	if (ret)
 		return ret;
-	if (code & STATUS_VALID_BIT) {
-		last_temp = code & LAST_TEMP_MASK;
+	ret = regmap_field_read(priv->rf[temp_idx], &last_temp3);
+	if (ret)
+		return ret;
+	if (valid) {
+		last_temp = last_temp3;
 		goto done;
-	} else {
-		last_temp3 = code & LAST_TEMP_MASK;
 	}
 
 	if (last_temp == last_temp2)
@@ -61,19 +81,58 @@ static int get_temp_tsens_v2(struct tsens_priv *priv, int id, int *temp)
 	return 0;
 }
 
+/* v2.x: 8996, 8998, sdm845 */
+
+const struct tsens_features tsens_v2_feat = {
+	.ver_major	= VER_2_X,
+	.crit_int	= 1,
+	.adc		= 0,
+	.srot_split	= 1,
+};
+
+const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
+	/* ----- SROT ------ */
+	/* VERSION */
+	[VER_MAJOR] = REG_FIELD(SROT_HW_VER_OFF, 28, 31),
+	[VER_MINOR] = REG_FIELD(SROT_HW_VER_OFF, 16, 27),
+	[VER_STEP]  = REG_FIELD(SROT_HW_VER_OFF,  0, 15),
+	/* CTRL_OFF */
+	[TSENS_EN]     = REG_FIELD(SROT_CTRL_OFF,    0,  0),
+	[TSENS_SW_RST] = REG_FIELD(SROT_CTRL_OFF,    1,  1),
+
+	/* ----- TM ------ */
+	/* INTERRUPT ENABLE */
+	/* v2 has separate enables for UPPER/LOWER/CRITICAL interrupts */
+	[INT_EN]  = REG_FIELD(TM_INT_EN_OFF, 0, 2),
+
+	/* Sn_STATUS */
+	REG_FIELD_FOR_EACH_SENSOR16(LAST_TEMP,       TM_Sn_STATUS_OFF,  0,  11),
+	REG_FIELD_FOR_EACH_SENSOR16(VALID,           TM_Sn_STATUS_OFF, 21,  21),
+	REG_FIELD_FOR_EACH_SENSOR16(MIN_STATUS,      TM_Sn_STATUS_OFF, 16,  16),
+	REG_FIELD_FOR_EACH_SENSOR16(LOWER_STATUS,    TM_Sn_STATUS_OFF, 17,  17),
+	REG_FIELD_FOR_EACH_SENSOR16(UPPER_STATUS,    TM_Sn_STATUS_OFF, 18,  18),
+	REG_FIELD_FOR_EACH_SENSOR16(CRITICAL_STATUS, TM_Sn_STATUS_OFF, 19,  19),
+	REG_FIELD_FOR_EACH_SENSOR16(MAX_STATUS,      TM_Sn_STATUS_OFF, 20,  20),
+
+	/* TRDY: 1=ready, 0=in progress */
+	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
+};
+
 static const struct tsens_ops ops_generic_v2 = {
 	.init		= init_common,
 	.get_temp	= get_temp_tsens_v2,
 };
 
 const struct tsens_plat_data data_tsens_v2 = {
-	.ops            = &ops_generic_v2,
-	.reg_offsets	= { [SROT_CTRL_OFFSET] = 0x4 },
+	.ops		= &ops_generic_v2,
+	.feat		= &tsens_v2_feat,
+	.fields	= tsens_v2_regfields,
 };
 
 /* Kept around for backward compatibility with old msm8996.dtsi */
 const struct tsens_plat_data data_8996 = {
 	.num_sensors	= 13,
 	.ops		= &ops_generic_v2,
-	.reg_offsets	= { [SROT_CTRL_OFFSET] = 0x4 },
+	.feat		= &tsens_v2_feat,
+	.fields	= tsens_v2_regfields,
 };
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 0b5be08d515f..b91a0b88d33c 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -144,9 +144,8 @@ static int tsens_probe(struct platform_device *pdev)
 		else
 			priv->sensor[i].hw_id = i;
 	}
-	for (i = 0; i < REG_ARRAY_SIZE; i++) {
-		priv->reg_offsets[i] = data->reg_offsets[i];
-	}
+	priv->feat = data->feat;
+	priv->fields = data->fields;
 
 	if (!priv->ops || !priv->ops->init || !priv->ops->get_temp)
 		return -EINVAL;
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 27b8f74829d9..a9390e06b4dd 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -11,9 +11,16 @@
 #define TWO_PT_CALIB		0x3
 
 #include <linux/thermal.h>
+#include <linux/regmap.h>
 
 struct tsens_priv;
 
+enum tsens_ver {
+	VER_0_1 = 0,
+	VER_1_X,
+	VER_2_X,
+};
+
 /**
  * struct tsens_sensor - data for each sensor connected to the tsens device
  * @priv: tsens device instance that this sensor is connected to
@@ -58,10 +65,189 @@ struct tsens_ops {
 	int (*get_trend)(struct tsens_priv *priv, int i, enum thermal_trend *trend);
 };
 
-enum reg_list {
-	SROT_CTRL_OFFSET,
+#define REG_FIELD_FOR_EACH_SENSOR11(_name, _offset, _startbit, _stopbit) \
+	[_name##_##0]  = REG_FIELD(_offset,      _startbit, _stopbit),	\
+	[_name##_##1]  = REG_FIELD(_offset +  4, _startbit, _stopbit), \
+	[_name##_##2]  = REG_FIELD(_offset +  8, _startbit, _stopbit), \
+	[_name##_##3]  = REG_FIELD(_offset + 12, _startbit, _stopbit), \
+	[_name##_##4]  = REG_FIELD(_offset + 16, _startbit, _stopbit), \
+	[_name##_##5]  = REG_FIELD(_offset + 20, _startbit, _stopbit), \
+	[_name##_##6]  = REG_FIELD(_offset + 24, _startbit, _stopbit), \
+	[_name##_##7]  = REG_FIELD(_offset + 28, _startbit, _stopbit), \
+	[_name##_##8]  = REG_FIELD(_offset + 32, _startbit, _stopbit), \
+	[_name##_##9]  = REG_FIELD(_offset + 36, _startbit, _stopbit), \
+	[_name##_##10] = REG_FIELD(_offset + 40, _startbit, _stopbit)
+
+#define REG_FIELD_FOR_EACH_SENSOR16(_name, _offset, _startbit, _stopbit) \
+	[_name##_##0]  = REG_FIELD(_offset,      _startbit, _stopbit),	\
+	[_name##_##1]  = REG_FIELD(_offset +  4, _startbit, _stopbit), \
+	[_name##_##2]  = REG_FIELD(_offset +  8, _startbit, _stopbit), \
+	[_name##_##3]  = REG_FIELD(_offset + 12, _startbit, _stopbit), \
+	[_name##_##4]  = REG_FIELD(_offset + 16, _startbit, _stopbit), \
+	[_name##_##5]  = REG_FIELD(_offset + 20, _startbit, _stopbit), \
+	[_name##_##6]  = REG_FIELD(_offset + 24, _startbit, _stopbit), \
+	[_name##_##7]  = REG_FIELD(_offset + 28, _startbit, _stopbit), \
+	[_name##_##8]  = REG_FIELD(_offset + 32, _startbit, _stopbit), \
+	[_name##_##9]  = REG_FIELD(_offset + 36, _startbit, _stopbit), \
+	[_name##_##10] = REG_FIELD(_offset + 40, _startbit, _stopbit), \
+	[_name##_##11] = REG_FIELD(_offset + 44, _startbit, _stopbit), \
+	[_name##_##12] = REG_FIELD(_offset + 48, _startbit, _stopbit), \
+	[_name##_##13] = REG_FIELD(_offset + 52, _startbit, _stopbit), \
+	[_name##_##14] = REG_FIELD(_offset + 56, _startbit, _stopbit), \
+	[_name##_##15] = REG_FIELD(_offset + 60, _startbit, _stopbit)
+
+/* reg_field IDs to use as an index into an array */
+enum regfield_ids {
+	/* ----- SROT ------ */
+	/* HW_VER */
+	VER_MAJOR = 0,
+	VER_MINOR,
+	VER_STEP,
+	/* CTRL_OFFSET */
+	TSENS_EN =  3,
+	TSENS_SW_RST,
+	SENSOR_EN,
+	CODE_OR_TEMP,
+
+	/* ----- TM ------ */
+	/* STATUS */
+	LAST_TEMP_0 = 7,	/* Last temperature reading */
+	LAST_TEMP_1,
+	LAST_TEMP_2,
+	LAST_TEMP_3,
+	LAST_TEMP_4,
+	LAST_TEMP_5,
+	LAST_TEMP_6,
+	LAST_TEMP_7,
+	LAST_TEMP_8,
+	LAST_TEMP_9,
+	LAST_TEMP_10,
+	LAST_TEMP_11,
+	LAST_TEMP_12,
+	LAST_TEMP_13,
+	LAST_TEMP_14,
+	LAST_TEMP_15,
+	VALID_0 = 23,		/* VALID reading or not */
+	VALID_1,
+	VALID_2,
+	VALID_3,
+	VALID_4,
+	VALID_5,
+	VALID_6,
+	VALID_7,
+	VALID_8,
+	VALID_9,
+	VALID_10,
+	VALID_11,
+	VALID_12,
+	VALID_13,
+	VALID_14,
+	VALID_15,
+	MIN_STATUS_0,		/* MIN threshold violated */
+	MIN_STATUS_1,
+	MIN_STATUS_2,
+	MIN_STATUS_3,
+	MIN_STATUS_4,
+	MIN_STATUS_5,
+	MIN_STATUS_6,
+	MIN_STATUS_7,
+	MIN_STATUS_8,
+	MIN_STATUS_9,
+	MIN_STATUS_10,
+	MIN_STATUS_11,
+	MIN_STATUS_12,
+	MIN_STATUS_13,
+	MIN_STATUS_14,
+	MIN_STATUS_15,
+	MAX_STATUS_0,		/* MAX threshold violated */
+	MAX_STATUS_1,
+	MAX_STATUS_2,
+	MAX_STATUS_3,
+	MAX_STATUS_4,
+	MAX_STATUS_5,
+	MAX_STATUS_6,
+	MAX_STATUS_7,
+	MAX_STATUS_8,
+	MAX_STATUS_9,
+	MAX_STATUS_10,
+	MAX_STATUS_11,
+	MAX_STATUS_12,
+	MAX_STATUS_13,
+	MAX_STATUS_14,
+	MAX_STATUS_15,
+	LOWER_STATUS_0,	/* LOWER threshold violated */
+	LOWER_STATUS_1,
+	LOWER_STATUS_2,
+	LOWER_STATUS_3,
+	LOWER_STATUS_4,
+	LOWER_STATUS_5,
+	LOWER_STATUS_6,
+	LOWER_STATUS_7,
+	LOWER_STATUS_8,
+	LOWER_STATUS_9,
+	LOWER_STATUS_10,
+	LOWER_STATUS_11,
+	LOWER_STATUS_12,
+	LOWER_STATUS_13,
+	LOWER_STATUS_14,
+	LOWER_STATUS_15,
+	UPPER_STATUS_0,	/* UPPER threshold violated */
+	UPPER_STATUS_1,
+	UPPER_STATUS_2,
+	UPPER_STATUS_3,
+	UPPER_STATUS_4,
+	UPPER_STATUS_5,
+	UPPER_STATUS_6,
+	UPPER_STATUS_7,
+	UPPER_STATUS_8,
+	UPPER_STATUS_9,
+	UPPER_STATUS_10,
+	UPPER_STATUS_11,
+	UPPER_STATUS_12,
+	UPPER_STATUS_13,
+	UPPER_STATUS_14,
+	UPPER_STATUS_15,
+	CRITICAL_STATUS_0,	/* CRITICAL threshold violated */
+	CRITICAL_STATUS_1,
+	CRITICAL_STATUS_2,
+	CRITICAL_STATUS_3,
+	CRITICAL_STATUS_4,
+	CRITICAL_STATUS_5,
+	CRITICAL_STATUS_6,
+	CRITICAL_STATUS_7,
+	CRITICAL_STATUS_8,
+	CRITICAL_STATUS_9,
+	CRITICAL_STATUS_10,
+	CRITICAL_STATUS_11,
+	CRITICAL_STATUS_12,
+	CRITICAL_STATUS_13,
+	CRITICAL_STATUS_14,
+	CRITICAL_STATUS_15,
+	/* TRDY */
+	TRDY,
+	/* INTERRUPT ENABLE */
+	INT_EN,	/* Pre-V1, V1.x */
+	LOW_INT_EN,	/* V2.x */
+	UP_INT_EN,	/* V2.x */
+	CRIT_INT_EN,	/* V2.x */
 
-	REG_ARRAY_SIZE,
+	/* Keep last */
+	MAX_REGFIELDS
+};
+
+/**
+ * struct tsens_features - Features supported by the IP
+ * @ver_major: Major number of IP version
+ * @crit_int: does the IP support critical interrupts?
+ * @adc:      do the sensors only output adc code (instead of temperature)?
+ * @srot_split: does the IP neatly splits the register space into SROT and TM,
+ *              with SROT only being available to secure boot firmware?
+ */
+struct tsens_features {
+	unsigned int ver_major;
+	unsigned int crit_int:1;
+	unsigned int adc:1;
+	unsigned int srot_split:1;
 };
 
 /**
@@ -69,13 +255,15 @@ enum reg_list {
  * @num_sensors: Number of sensors supported by platform
  * @ops: operations the tsens instance supports
  * @hw_ids: Subset of sensors ids supported by platform, if not the first n
- * @reg_offsets: Register offsets for commonly used registers
+ * @feat: features of the IP
+ * @fields: bitfield locations
  */
 struct tsens_plat_data {
 	const u32		num_sensors;
 	const struct tsens_ops	*ops;
-	const u16		reg_offsets[REG_ARRAY_SIZE];
 	unsigned int		*hw_ids;
+	const struct tsens_features	*feat;
+	const struct reg_field		*fields;
 };
 
 /**
@@ -94,8 +282,10 @@ struct tsens_context {
  * @srot_map: pointer to SROT register address space
  * @tm_offset: deal with old device trees that don't address TM and SROT
  *             address space separately
- * @reg_offsets: array of offsets to important regs for this version of IP
+ * @rf: array of regmap_fields used to store value of the field
  * @ctx: registers to be saved and restored during suspend/resume
+ * @feat: features of the IP
+ * @fields: bitfield locations
  * @ops: pointer to list of callbacks supported by this device
  * @sensor: list of sensors attached to this device
  */
@@ -105,8 +295,10 @@ struct tsens_priv {
 	struct regmap			*tm_map;
 	struct regmap			*srot_map;
 	u32				tm_offset;
-	u16				reg_offsets[REG_ARRAY_SIZE];
+	struct regmap_field		*rf[MAX_REGFIELDS];
 	struct tsens_context		ctx;
+	const struct tsens_features	*feat;
+	const struct reg_field		*fields;
 	const struct tsens_ops		*ops;
 	struct tsens_sensor		sensor[0];
 };
-- 
2.17.1

