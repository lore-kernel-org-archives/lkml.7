Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75279C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E2B2176D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZeoJzVb9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfK1Nsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 08:48:47 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55966 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfK1Nsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:48:45 -0500
Received: by mail-wm1-f67.google.com with SMTP id a131so6708579wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 05:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2+9lLzA6tYXl6Vs9wqUuF2Bk1fla14D0jQAd3Lh6NWE=;
        b=ZeoJzVb9ioAAkeIhCTK8cIY6q3updyUVGelzHsYoR1wl03/0dEVMtb6UDeUP1sX/55
         SxLFvJ5x1b79o2X4gs1K3n/3NzKn1zTm2A0RyoWwGwTfT2a6aOKxJLFaA/RYnGixcqpG
         SR/EowZJO0/P9f9uYhS3MSkTKM8OwZOVdrw++9+gZPTaEaI7qt9wveKIzRxnt1m6aP1c
         WyKq8qmYwoyINdTyqulOCXkM+2kg5T/awkMiRN6aXV0BivBCpcIip+ieUtOTRIdXF9Yr
         y+2qubfrqtJYBblSJZwU4GnqQkPjKEGuwAejEsFBVaF3gUJ0B2XRVFeBg6jhsoMbq3iU
         U8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2+9lLzA6tYXl6Vs9wqUuF2Bk1fla14D0jQAd3Lh6NWE=;
        b=TLGHnIB8vn9viMTzZPYQBsy0141XdA82eh8B7VZwtowI33BWjOAB7R49cYDL3pEfvt
         zIg4GiOiIvp8Wm/9W7aYnfZxs/2cStmQ1m7rDEGnC8Ebm+ZDyTbfPeBb9itaJPniM2ch
         oQdn5bHoRlXdQcog2Mk6LWE8cMST8O3Ak92M7GSs9TPL4gGpk4DbwGq1HRQ0uisvjB6v
         gLf/Px4nC9FeUwEmFbDglNDzU1ErTomLHIYeATYccE2JdNBpceWEJjtEVUq6L291tMJt
         Brfn5ze4MmJWAYJQV3a0aM99YtvnqJb6EQBit9q4Q7lunnNwJQPwLNc2NqC6MELHdb2H
         vldw==
X-Gm-Message-State: APjAAAVZNzifG730G6JXMJ6MVFnf3r2Y6C+pywoVnz7IfromMTv6+Xkq
        uQZZgEfnL9YkadK+28ITe6SdQA==
X-Google-Smtp-Source: APXvYqx893KX5X1qljg2pe226q0Tjt5gya+f21cHdySFX/8fWZ2rys9ahSyS/AlO16MbDm+lV2dAdA==
X-Received: by 2002:a7b:c5d9:: with SMTP id n25mr9861214wmk.8.1574948922009;
        Thu, 28 Nov 2019 05:48:42 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id m3sm8523734wrs.53.2019.11.28.05.48.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Nov 2019 05:48:41 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     evgreen@chromium.org, bjorn.andersson@linaro.org,
        agross@kernel.org, daidavid1@codeaurora.org, masneyb@onstation.org,
        sibis@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH 2/2] interconnect: qcom: Use the standard aggregate function
Date:   Thu, 28 Nov 2019 15:48:39 +0200
Message-Id: <20191128134839.27606-2-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191128134839.27606-1-georgi.djakov@linaro.org>
References: <20191128134839.27606-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now we have a common function for standard aggregation, so let's use it,
instead of duplicating the code.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/msm8974.c | 15 +++------------
 drivers/interconnect/qcom/qcs404.c  | 15 +++------------
 2 files changed, 6 insertions(+), 24 deletions(-)

diff --git a/drivers/interconnect/qcom/msm8974.c b/drivers/interconnect/qcom/msm8974.c
index 8823dce811c3..bf724c2ca02b 100644
--- a/drivers/interconnect/qcom/msm8974.c
+++ b/drivers/interconnect/qcom/msm8974.c
@@ -550,15 +550,6 @@ static struct msm8974_icc_desc msm8974_snoc = {
 	.num_nodes = ARRAY_SIZE(msm8974_snoc_nodes),
 };
 
-static int msm8974_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
-				 u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
-{
-	*agg_avg += avg_bw;
-	*agg_peak = max(*agg_peak, peak_bw);
-
-	return 0;
-}
-
 static void msm8974_icc_rpm_smd_send(struct device *dev, int rsc_type,
 				     char *name, int id, u64 val)
 {
@@ -603,8 +594,8 @@ static int msm8974_icc_set(struct icc_node *src, struct icc_node *dst)
 	qp = to_msm8974_icc_provider(provider);
 
 	list_for_each_entry(n, &provider->nodes, node_list)
-		msm8974_icc_aggregate(n, 0, n->avg_bw, n->peak_bw,
-				      &agg_avg, &agg_peak);
+		provider->aggregate(n, 0, n->avg_bw, n->peak_bw,
+				    &agg_avg, &agg_peak);
 
 	sum_bw = icc_units_to_bps(agg_avg);
 	max_peak_bw = icc_units_to_bps(agg_peak);
@@ -703,7 +694,7 @@ static int msm8974_icc_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&provider->nodes);
 	provider->dev = dev;
 	provider->set = msm8974_icc_set;
-	provider->aggregate = msm8974_icc_aggregate;
+	provider->aggregate = icc_std_aggregate;
 	provider->xlate = of_icc_xlate_onecell;
 	provider->data = data;
 
diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
index a4c6ba715f61..ce2e6faa3a79 100644
--- a/drivers/interconnect/qcom/qcs404.c
+++ b/drivers/interconnect/qcom/qcs404.c
@@ -327,15 +327,6 @@ static struct qcom_icc_desc qcs404_snoc = {
 	.num_nodes = ARRAY_SIZE(qcs404_snoc_nodes),
 };
 
-static int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
-			      u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
-{
-	*agg_avg += avg_bw;
-	*agg_peak = max(*agg_peak, peak_bw);
-
-	return 0;
-}
-
 static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 {
 	struct qcom_icc_provider *qp;
@@ -354,8 +345,8 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 	qp = to_qcom_provider(provider);
 
 	list_for_each_entry(n, &provider->nodes, node_list)
-		qcom_icc_aggregate(n, 0, n->avg_bw, n->peak_bw,
-				   &agg_avg, &agg_peak);
+		provider->aggregate(n, 0, n->avg_bw, n->peak_bw,
+				    &agg_avg, &agg_peak);
 
 	sum_bw = icc_units_to_bps(agg_avg);
 	max_peak_bw = icc_units_to_bps(agg_peak);
@@ -465,7 +456,7 @@ static int qnoc_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&provider->nodes);
 	provider->dev = dev;
 	provider->set = qcom_icc_set;
-	provider->aggregate = qcom_icc_aggregate;
+	provider->aggregate = icc_std_aggregate;
 	provider->xlate = of_icc_xlate_onecell;
 	provider->data = data;
 
