Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F399FC2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 14:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC902072C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 14:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tFow0Sn7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgABOyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 09:54:46 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:35387 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbgABOyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 09:54:45 -0500
Received: by mail-pj1-f65.google.com with SMTP id s7so3447957pjc.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 06:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oi1EZVs7PMYW3ENjMtAVgWjqAjOWibzgib65seKOwXo=;
        b=tFow0Sn7YTiwe2D73xLlEkZ9oIpD8IHksnf4/mF5jN7q6oUqO9/ojjPtotq0cKziKp
         9bwYhbpm/VP7wxPBXWnjanl2/rb2g+wMSoECmUBGonNtDV6KCOo5b2R561AzhFieCE3q
         CJ0kIELidP5ZwgRPZmfscrCXZyurPxioCB2G8C9kJtCquIiJgt+PqJkKEe19IRMuiOoJ
         9sLJvowmoasu4f80Ghf+zhqjORwJVCQgOaj+HnjRfDlBzz5mCwIwyt9BDY81n5nbsVXI
         tlgwdGCGVMKtiU81UzyknIMR3HTgYus+XuSX4JX9ovKDdN/kJxGgR0HQ0pKICt+b5TH2
         gnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oi1EZVs7PMYW3ENjMtAVgWjqAjOWibzgib65seKOwXo=;
        b=PxbVANqSskOvwNZ/RELfWUS+sZMkE9+QLlxyyIINSJ/uIWr0aUjiE3EcQJd8iJmza5
         +J4/oyyjWxDm1VXeiUW7fR4W8abopWLRTVwSoENf441Hn4bP5EUj/UcuZW44Vp6mBEqw
         hDFwcXhhUNFAf7zftECHcrwjEqmhe2k6+pd20n7IW+iuTWE4DxfH/49tPVm5bTBezpYd
         EBsLjR6Mhc8DLbC+BEFgdZ1US8FjYvOY7YWAyeUj7LVEgIJl5J/vbWoYeaAUtztL+k9Q
         4ChzRbpPxyOQaxxkMjIgirrCmbszmf8GiEV4EmX349gbI5TnCHoeWQJelmWDYFJBR9kn
         lGhQ==
X-Gm-Message-State: APjAAAWPolvUdoz2Zdm6AbBcRf8g3IVnOA4bz+yFJYJzbhK6jDtUra7a
        EhlEjVcExNmgOONjf9moQncWzkqJbfbR8g==
X-Google-Smtp-Source: APXvYqy8ZGu+KM0WH5cNzQStEA9QGuI2scj5BCjLtHSS6FnxWlE27OWukvSdYX4iGOT/Vd5TZxuv0Q==
X-Received: by 2002:a17:90a:2486:: with SMTP id i6mr21090473pje.9.1577976884202;
        Thu, 02 Jan 2020 06:54:44 -0800 (PST)
Received: from localhost ([103.195.202.148])
        by smtp.gmail.com with ESMTPSA id c22sm41824155pfo.50.2020.01.02.06.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 06:54:43 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, swboyd@chromium.org,
        sivaa@codeaurora.org, Andy Gross <agross@kernel.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 1/9] drivers: thermal: tsens: De-constify struct tsens_features
Date:   Thu,  2 Jan 2020 20:24:26 +0530
Message-Id: <77dd80eb58f0db29a03097cb442d606f810a849a.1577976221.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1577976221.git.amit.kucheria@linaro.org>
References: <cover.1577976221.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct tsens_features is currently initialized as part of platform data
at compile-time and not modifiable. We now have some usecases in feature
detection across IP versions where it is more flexible to update the
features after probing registers.

Remove const qualifier from tsens_features and the encapsulating
tsens_plat_data.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-8960.c |  2 +-
 drivers/thermal/qcom/tsens-v0_1.c |  6 +++---
 drivers/thermal/qcom/tsens-v1.c   |  6 +++---
 drivers/thermal/qcom/tsens-v2.c   |  6 +++---
 drivers/thermal/qcom/tsens.h      | 12 ++++++------
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index fb77acb8d13b..a383a57cfbbc 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -279,7 +279,7 @@ static const struct tsens_ops ops_8960 = {
 	.resume		= resume_8960,
 };
 
-const struct tsens_plat_data data_8960 = {
+struct tsens_plat_data data_8960 = {
 	.num_sensors	= 11,
 	.ops		= &ops_8960,
 };
diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index 4b8dd6de02ce..959a9371d205 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -327,7 +327,7 @@ static int calibrate_8974(struct tsens_priv *priv)
 
 /* v0.1: 8916, 8974 */
 
-static const struct tsens_features tsens_v0_1_feat = {
+static struct tsens_features tsens_v0_1_feat = {
 	.ver_major	= VER_0_1,
 	.crit_int	= 0,
 	.adc		= 1,
@@ -377,7 +377,7 @@ static const struct tsens_ops ops_8916 = {
 	.get_temp	= get_temp_common,
 };
 
-const struct tsens_plat_data data_8916 = {
+struct tsens_plat_data data_8916 = {
 	.num_sensors	= 5,
 	.ops		= &ops_8916,
 	.hw_ids		= (unsigned int []){0, 1, 2, 4, 5 },
@@ -392,7 +392,7 @@ static const struct tsens_ops ops_8974 = {
 	.get_temp	= get_temp_common,
 };
 
-const struct tsens_plat_data data_8974 = {
+struct tsens_plat_data data_8974 = {
 	.num_sensors	= 11,
 	.ops		= &ops_8974,
 	.feat		= &tsens_v0_1_feat,
diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index bd2ddb684a45..b682a4df0081 100644
--- a/drivers/thermal/qcom/tsens-v1.c
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -299,7 +299,7 @@ static int calibrate_8976(struct tsens_priv *priv)
 
 /* v1.x: msm8956,8976,qcs404,405 */
 
-static const struct tsens_features tsens_v1_feat = {
+static struct tsens_features tsens_v1_feat = {
 	.ver_major	= VER_1_X,
 	.crit_int	= 0,
 	.adc		= 1,
@@ -368,7 +368,7 @@ static const struct tsens_ops ops_generic_v1 = {
 	.get_temp	= get_temp_tsens_valid,
 };
 
-const struct tsens_plat_data data_tsens_v1 = {
+struct tsens_plat_data data_tsens_v1 = {
 	.ops		= &ops_generic_v1,
 	.feat		= &tsens_v1_feat,
 	.fields	= tsens_v1_regfields,
@@ -381,7 +381,7 @@ static const struct tsens_ops ops_8976 = {
 };
 
 /* Valid for both MSM8956 and MSM8976. Sensor ID 3 is unused. */
-const struct tsens_plat_data data_8976 = {
+struct tsens_plat_data data_8976 = {
 	.num_sensors	= 11,
 	.ops		= &ops_8976,
 	.hw_ids		= (unsigned int[]){0, 1, 2, 4, 5, 6, 7, 8, 9, 10},
diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index a4d15e1abfdd..f1c8ec62e69f 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -27,7 +27,7 @@
 
 /* v2.x: 8996, 8998, sdm845 */
 
-static const struct tsens_features tsens_v2_feat = {
+static struct tsens_features tsens_v2_feat = {
 	.ver_major	= VER_2_X,
 	.crit_int	= 1,
 	.adc		= 0,
@@ -81,14 +81,14 @@ static const struct tsens_ops ops_generic_v2 = {
 	.get_temp	= get_temp_tsens_valid,
 };
 
-const struct tsens_plat_data data_tsens_v2 = {
+struct tsens_plat_data data_tsens_v2 = {
 	.ops		= &ops_generic_v2,
 	.feat		= &tsens_v2_feat,
 	.fields	= tsens_v2_regfields,
 };
 
 /* Kept around for backward compatibility with old msm8996.dtsi */
-const struct tsens_plat_data data_8996 = {
+struct tsens_plat_data data_8996 = {
 	.num_sensors	= 13,
 	.ops		= &ops_generic_v2,
 	.feat		= &tsens_v2_feat,
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index e24a865fbc34..be364bf1d5a6 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -440,7 +440,7 @@ struct tsens_plat_data {
 	const u32		num_sensors;
 	const struct tsens_ops	*ops;
 	unsigned int		*hw_ids;
-	const struct tsens_features	*feat;
+	struct tsens_features	*feat;
 	const struct reg_field		*fields;
 };
 
@@ -481,7 +481,7 @@ struct tsens_priv {
 
 	struct regmap_field		*rf[MAX_REGFIELDS];
 	struct tsens_context		ctx;
-	const struct tsens_features	*feat;
+	struct tsens_features		*feat;
 	const struct reg_field		*fields;
 	const struct tsens_ops		*ops;
 
@@ -502,15 +502,15 @@ int tsens_set_trips(void *_sensor, int low, int high);
 irqreturn_t tsens_irq_thread(int irq, void *data);
 
 /* TSENS target */
-extern const struct tsens_plat_data data_8960;
+extern struct tsens_plat_data data_8960;
 
 /* TSENS v0.1 targets */
-extern const struct tsens_plat_data data_8916, data_8974;
+extern struct tsens_plat_data data_8916, data_8974;
 
 /* TSENS v1 targets */
-extern const struct tsens_plat_data data_tsens_v1, data_8976;
+extern struct tsens_plat_data data_tsens_v1, data_8976;
 
 /* TSENS v2 targets */
-extern const struct tsens_plat_data data_8996, data_tsens_v2;
+extern struct tsens_plat_data data_8996, data_tsens_v2;
 
 #endif /* __QCOM_TSENS_H__ */
-- 
2.20.1

