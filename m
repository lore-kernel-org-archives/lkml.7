Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00ACEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B978F2184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N3dqw6dv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbfCTNSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:18:31 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33493 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728077AbfCTNSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:18:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id b12so1821866pgk.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 06:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=zy0Ocp2xe2rob5f0FFseaWF46iQU7ldkZ5vVgEtDGww=;
        b=N3dqw6dvSir0+OFpz8pTP+++GEysAzMXQHTc9vrc85ZKFxfOy1+wgeN/rPF+tvtmE/
         DWsCiGg2Q1+bFUr5qP7gJcBmScObPv9ZwYLk1kSWtfYELghCJAJv7RvvOEj3tFogM9XG
         +LtA5BVgEYtJFuABasddQS8q8Vybzom+HxiMxxJTG+lhn0EHyEuCiw6hZg2oGJr87K4A
         dDQR/4Gvc5TL0VtKPG+k10gZsPbjqae8z3bAvavuoM2qxf7Z91uKl82WnDiCHg4J4GgH
         ZBuwjJ61jDrEvbESixDRHH6Ktzt/gaEhDx33LivKUzjsLLLIJ+C4QsjVMT76auGmQT7I
         qRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=zy0Ocp2xe2rob5f0FFseaWF46iQU7ldkZ5vVgEtDGww=;
        b=TphS+izjPaSrGq3u1KJaa9UtQMZoBdgkLExe+8CDg8CgTlTS54YkqkI7XWm3GaLjm2
         zi6mafHEPs8PVY8f/nEoHvu2WPQb+QduALPgru8NRyApvMzptp3R6bHsV5nBbt+GQVzg
         Cqg5af/+iVYZny0PWkczjfOzeqiGYL2KpjuGdkFmDVkI+M5oElMeUBoL4WHqheEkI6S/
         3mvnWVkBUxxOoFpKsSM/i6deA3ighe+nbCJtoItYuK8Aqgd2Nmz6H60cOjQdGsq/netj
         hjDwoXX+FFs13jW5cHZPe3IgBrE1Bh+U4e7M1Hv5ytHOqjQC/LqjW3LpR5QyRlwqaZ9i
         RHOQ==
X-Gm-Message-State: APjAAAXJcVC4LGeyeRp4U67PZm/fu+9DOUDR4VNrqTdoX7GKgATl2k1q
        5t+nzEzvgWVkOLmveJbM4dYNkOwJEtg=
X-Google-Smtp-Source: APXvYqwp94sHTu6a88y5Q25AVoUjQQx14J/lRBVW+Mt8Hde9NyzIbEOHGDB0+n3ToAwj5mcZv3haKA==
X-Received: by 2002:a63:6e4c:: with SMTP id j73mr7942189pgc.276.1553087909240;
        Wed, 20 Mar 2019 06:18:29 -0700 (PDT)
Received: from localhost ([114.143.122.221])
        by smtp.gmail.com with ESMTPSA id l5sm3652798pfi.97.2019.03.20.06.18.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 06:18:28 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCHv3 02/23] drivers: thermal: tsens: Rename tsens_data
Date:   Wed, 20 Mar 2019 18:47:42 +0530
Message-Id: <286b40e37f26cad44f54dcb9420f1e7fb589a396.1553086065.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename to tsens_plat_data to denote that it is platform-data passed in
at compile-time.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-8916.c | 2 +-
 drivers/thermal/qcom/tsens-8960.c | 2 +-
 drivers/thermal/qcom/tsens-8974.c | 2 +-
 drivers/thermal/qcom/tsens-v2.c   | 4 ++--
 drivers/thermal/qcom/tsens.c      | 2 +-
 drivers/thermal/qcom/tsens.h      | 8 ++++----
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8916.c b/drivers/thermal/qcom/tsens-8916.c
index c6dd620ac029..66edcfca1526 100644
--- a/drivers/thermal/qcom/tsens-8916.c
+++ b/drivers/thermal/qcom/tsens-8916.c
@@ -97,7 +97,7 @@ static const struct tsens_ops ops_8916 = {
 	.get_temp	= get_temp_common,
 };
 
-const struct tsens_data data_8916 = {
+const struct tsens_plat_data data_8916 = {
 	.num_sensors	= 5,
 	.ops		= &ops_8916,
 	.reg_offsets	= { [SROT_CTRL_OFFSET] = 0x0 },
diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index 0f0adb302a7b..f3c3820e6e8e 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -277,7 +277,7 @@ static const struct tsens_ops ops_8960 = {
 	.resume		= resume_8960,
 };
 
-const struct tsens_data data_8960 = {
+const struct tsens_plat_data data_8960 = {
 	.num_sensors	= 11,
 	.ops		= &ops_8960,
 };
diff --git a/drivers/thermal/qcom/tsens-8974.c b/drivers/thermal/qcom/tsens-8974.c
index 3d3fda3d731b..5023f20afc14 100644
--- a/drivers/thermal/qcom/tsens-8974.c
+++ b/drivers/thermal/qcom/tsens-8974.c
@@ -229,7 +229,7 @@ static const struct tsens_ops ops_8974 = {
 	.get_temp	= get_temp_common,
 };
 
-const struct tsens_data data_8974 = {
+const struct tsens_plat_data data_8974 = {
 	.num_sensors	= 11,
 	.ops		= &ops_8974,
 	.reg_offsets	= { [SROT_CTRL_OFFSET] = 0x0 },
diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 381a212872bf..cc98a61e093b 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -66,13 +66,13 @@ static const struct tsens_ops ops_generic_v2 = {
 	.get_temp	= get_temp_tsens_v2,
 };
 
-const struct tsens_data data_tsens_v2 = {
+const struct tsens_plat_data data_tsens_v2 = {
 	.ops            = &ops_generic_v2,
 	.reg_offsets	= { [SROT_CTRL_OFFSET] = 0x4 },
 };
 
 /* Kept around for backward compatibility with old msm8996.dtsi */
-const struct tsens_data data_8996 = {
+const struct tsens_plat_data data_8996 = {
 	.num_sensors	= 13,
 	.ops		= &ops_generic_v2,
 	.reg_offsets	= { [SROT_CTRL_OFFSET] = 0x4 },
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index f1ec9bbe4717..065ec2189bd3 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -102,7 +102,7 @@ static int tsens_probe(struct platform_device *pdev)
 	struct device *dev;
 	struct device_node *np;
 	struct tsens_device *tmdev;
-	const struct tsens_data *data;
+	const struct tsens_plat_data *data;
 	const struct of_device_id *id;
 	u32 num_sensors;
 
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 89318523c848..232376c690cc 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -65,13 +65,13 @@ enum reg_list {
 };
 
 /**
- * struct tsens_data - tsens platform data
+ * struct tsens_plat_data - tsens compile-time platform data
  * @num_sensors: Number of sensors supported by platform
  * @ops: operations the tsens instance supports
  * @hw_ids: Subset of sensors ids supported by platform, if not the first n
  * @reg_offsets: Register offsets for commonly used registers
  */
-struct tsens_data {
+struct tsens_plat_data {
 	const u32		num_sensors;
 	const struct tsens_ops	*ops;
 	const u16		reg_offsets[REG_ARRAY_SIZE];
@@ -117,8 +117,8 @@ int init_common(struct tsens_device *);
 int get_temp_common(struct tsens_device *, int, int *);
 
 /* TSENS v1 targets */
-extern const struct tsens_data data_8916, data_8974, data_8960;
+extern const struct tsens_plat_data data_8916, data_8974, data_8960;
 /* TSENS v2 targets */
-extern const struct tsens_data data_8996, data_tsens_v2;
+extern const struct tsens_plat_data data_8996, data_tsens_v2;
 
 #endif /* __QCOM_TSENS_H__ */
-- 
2.17.1

