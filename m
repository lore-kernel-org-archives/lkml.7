Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6F6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE0F2083D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="itToNH34"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731808AbfB1M1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:27:37 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40327 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731675AbfB1M1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 07:27:34 -0500
Received: by mail-wm1-f66.google.com with SMTP id g20so7975692wmh.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 04:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=CfWghgV1RK0L2tcup/p41zKc8qLLDQNa3EIDdIC0c4k=;
        b=itToNH34dv/FNuiFrwtUZfaVgZuc6mR6JycBLuO6WmYYwFlLdWCap+YxOkoiIvL/Cm
         Rmbslj+pfTiLu6OYKKMPx6qD/3Gw/dfrFRdlbDFanlqVvGCUsuVvnaFk4pi+mRGObHUX
         X2Y5/7Xyg49pG++0IPgeF/spcTfhQmG8vuWsz8W2cv0TjmywdHZnEmkhrLWEUjIhe0dO
         EEJIysryMBqRAyDFXkk2vCMzR/X21/3omezosBN2rsnfsh3P3VdTpMi2DBGtVSUkgZAx
         ep07YZJ8QWvUHVFwvtq3TTZZ8XYFYMDLY+uoKzeUr84ui7CdoTal9a5eom1F43bZazzi
         dGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=CfWghgV1RK0L2tcup/p41zKc8qLLDQNa3EIDdIC0c4k=;
        b=Y1+sow2P8TRyHQWNO35IbTI6Q1eaQV1078nkWMljMP43e6ycT9JtbyYie1EIZRjRm6
         9dzBZ+Eb/810sLxb3QZQ4aaVy/QSUgbIrz4hYcDDp64hBs3S9IwJkG7YjUo4X4jD9uBY
         X23DO5QKwIkTZRxZliYEyUSPJ4Tvhn9BL7jVgYqr2jnl/pwLoRm0oAJnTjCIVUMl6+FF
         a6g1DsfhLzmt9JlGlcFA/BjfDXViywyH01B8+BXOWrea32i9Z/zsgsIRoz2Bl7TM/nUU
         xQ5H124yKe/ei0ZwcA2XdXmcDLsWxR5nqePdmnatDauKq+5Sy/3nF75Co6JS5w/cRYRv
         PncQ==
X-Gm-Message-State: AHQUAuYcTXQuaKOZWRYmLzDRl1hftfbZ/MDHdNXJA3FmmF2hOZNzeh1T
        BwGlOvck/PMR427Hs4328HLeZKZkM60=
X-Google-Smtp-Source: AHgI3IYaqGtafzzyrzp1ANso5Ig9dc7sZ9IW5lFkCUg3X1u7zjmMnXseHATTDA1jHN3x+vZj9TH38g==
X-Received: by 2002:a1c:790b:: with SMTP id l11mr2711318wme.54.1551356852837;
        Thu, 28 Feb 2019 04:27:32 -0800 (PST)
Received: from localhost ([49.248.54.130])
        by smtp.gmail.com with ESMTPSA id d9sm20694097wrn.72.2019.02.28.04.27.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 04:27:32 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v2 16/24] drivers: thermal: tsens: Introduce IP-specific max_sensor count
Date:   Thu, 28 Feb 2019 17:51:06 +0530
Message-Id: <ffe64aeed1eccd7ce5271611b5fed2b2d32dfbfc.1551355503.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IP can support 'm' sensors while the platform can enable 'n' sensors
of the 'm' where n <= m.

Track maximum sensors supported by the IP so that we can correctly track
what subset of the sensors are supported on the platform.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 4 ++--
 drivers/thermal/qcom/tsens-v0_1.c   | 1 +
 drivers/thermal/qcom/tsens-v2.c     | 1 +
 drivers/thermal/qcom/tsens.h        | 2 ++
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index c58ba4c200bc..5f838fd798c3 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -197,13 +197,13 @@ int __init init_common(struct tsens_priv *priv)
 		return PTR_ERR(priv->rf[SENSOR_EN]);
 
 	/* now alloc regmap_fields in tm_map */
-	for (i = 0, j = LAST_TEMP_0; i < priv->num_sensors; i++, j++) {
+	for (i = 0, j = LAST_TEMP_0; i < priv->feat->max_sensors; i++, j++) {
 		priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
 						      priv->fields[j]);
 		if (IS_ERR(priv->rf[j]))
 			return PTR_ERR(priv->rf[j]);
 	}
-	for (i = 0, j = VALID_0; i < priv->num_sensors; i++, j++) {
+	for (i = 0, j = VALID_0; i < priv->feat->max_sensors; i++, j++) {
 		priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
 						      priv->fields[j]);
 		if (IS_ERR(priv->rf[j]))
diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index 837e7872e512..03c0f2e11eaf 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -324,6 +324,7 @@ const struct tsens_features tsens_v0_1_feat = {
 	.crit_int	= 0,
 	.adc		= 1,
 	.srot_split	= 1,
+	.max_sensors	= 11,
 };
 
 /* v0.1: 8916, 8974 */
diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 7346bfc9efe6..55fe00f90b22 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -88,6 +88,7 @@ const struct tsens_features tsens_v2_feat = {
 	.crit_int	= 1,
 	.adc		= 0,
 	.srot_split	= 1,
+	.max_sensors	= 16,
 };
 
 const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index a20725b1cc67..eb988c1d17c4 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -297,12 +297,14 @@ enum regfield_ids {
  * @adc:      do the sensors only output adc code (instead of temperature)?
  * @srot_split: does the IP neatly splits the register space into SROT and TM,
  *              with SROT only being available to secure boot firmware?
+ * @max_sensors: maximum sensors supported by this version of the IP
  */
 struct tsens_features {
 	unsigned int ver_info:1;
 	unsigned int crit_int:1;
 	unsigned int adc:1;
 	unsigned int srot_split:1;
+	unsigned int max_sensors;
 };
 
 /**
-- 
2.17.1

