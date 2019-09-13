Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F89EC4CEC7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 12:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BA8D2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 12:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387547AbfIMMC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 08:02:28 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:47043 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726771AbfIMMC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 08:02:28 -0400
X-Greylist: delayed 363 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Sep 2019 08:02:26 EDT
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 13 Sep 2019 04:56:23 -0700
Received: from gokulsri-linux.qualcomm.com ([10.201.2.207])
  by ironmsg05-sd.qualcomm.com with ESMTP; 13 Sep 2019 04:56:18 -0700
Received: by gokulsri-linux.qualcomm.com (Postfix, from userid 432570)
        id BB3DA3729; Fri, 13 Sep 2019 17:26:11 +0530 (IST)
From:   Gokul Sriram Palanisamy <gokulsri@codeaurora.org>
To:     gokulsri@codeaurora.org, sboyd@kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, david.brown@linaro.org,
        devicetree@vger.kernel.org, jassisinghbrar@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com, ohad@wizery.com,
        robh+dt@kernel.org, sricharan@codeaurora.org,
        nprakash@codeaurora.org
Subject: [PATCH V2 01/12] remoteproc: qcom: Add PRNG proxy clock
Date:   Fri, 13 Sep 2019 17:26:00 +0530
Message-Id: <1568375771-22933-2-git-send-email-gokulsri@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1568375771-22933-1-git-send-email-gokulsri@codeaurora.org>
References: <1568375771-22933-1-git-send-email-gokulsri@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PRNG clock is needed by the secure PIL, support for the same
is added in subsequent patches.

Signed-off-by: Gokul Sriram Palanisamy <gokulsri@codeaurora.org>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
Signed-off-by: Nikhil Prakash V <nprakash@codeaurora.org>
---
 drivers/remoteproc/qcom_q6v5_wcss.c | 63 +++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 17 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_wcss.c b/drivers/remoteproc/qcom_q6v5_wcss.c
index 0821c94..dc2bae4 100644
--- a/drivers/remoteproc/qcom_q6v5_wcss.c
+++ b/drivers/remoteproc/qcom_q6v5_wcss.c
@@ -88,18 +88,6 @@ enum {
 	WCSS_QCS404,
 };
 
-struct wcss_data {
-	const char *firmware_name;
-	int crash_reason_smem;
-	u8 version;
-	bool aon_reset_required;
-	const char *ssr_name;
-	const char *sysmon_name;
-	int ssctl_id;
-	const struct rproc_ops *ops;
-	bool requires_force_stop;
-};
-
 struct q6v5_wcss {
 	struct device *dev;
 
@@ -124,6 +112,7 @@ struct q6v5_wcss {
 	struct clk *qdsp6ss_xo_cbcr;
 	struct clk *qdsp6ss_core_gfmux;
 	struct clk *wcss_bcr_cbcr;
+	struct clk *prng_clk;
 	struct regulator *cx_supply;
 
 	struct qcom_rproc_glink glink_subdev;
@@ -146,6 +135,20 @@ struct q6v5_wcss {
 	bool requires_force_stop;
 };
 
+struct wcss_data {
+	int (*init_clock)(struct q6v5_wcss *wcss);
+	int (*init_regulator)(struct q6v5_wcss *wcss);
+	const char *firmware_name;
+	int crash_reason_smem;
+	u8 version;
+	bool aon_reset_required;
+	const char *ssr_name;
+	const char *sysmon_name;
+	int ssctl_id;
+	const struct rproc_ops *ops;
+	bool requires_force_stop;
+};
+
 static int q6v5_wcss_reset(struct q6v5_wcss *wcss)
 {
 	int ret;
@@ -235,6 +238,12 @@ static int q6v5_wcss_start(struct rproc *rproc)
 	struct q6v5_wcss *wcss = rproc->priv;
 	int ret;
 
+	ret = clk_prepare_enable(wcss->prng_clk);
+	if (ret) {
+		dev_err(wcss->dev, "prng clock enable failed\n");
+		return ret;
+	}
+
 	qcom_q6v5_prepare(&wcss->q6v5);
 
 	/* Release Q6 and WCSS reset */
@@ -703,6 +712,7 @@ static int q6v5_wcss_stop(struct rproc *rproc)
 			return ret;
 	}
 
+	clk_disable_unprepare(wcss->prng_clk);
 	qcom_q6v5_unprepare(&wcss->q6v5);
 
 	return 0;
@@ -858,7 +868,21 @@ static int q6v5_alloc_memory_region(struct q6v5_wcss *wcss)
 	return 0;
 }
 
-static int q6v5_wcss_init_clock(struct q6v5_wcss *wcss)
+static int ipq8074_init_clock(struct q6v5_wcss *wcss)
+{
+	int ret;
+
+	wcss->prng_clk = devm_clk_get(wcss->dev, "prng");
+	if (IS_ERR(wcss->prng_clk)) {
+		ret = PTR_ERR(wcss->prng_clk);
+		if (ret != -EPROBE_DEFER)
+			dev_err(wcss->dev, "Failed to get prng clock\n");
+		return ret;
+	}
+	return 0;
+}
+
+static int qcs404_init_clock(struct q6v5_wcss *wcss)
 {
 	int ret;
 
@@ -973,7 +997,7 @@ static int q6v5_wcss_init_clock(struct q6v5_wcss *wcss)
 	return 0;
 }
 
-static int q6v5_wcss_init_regulator(struct q6v5_wcss *wcss)
+static int qcs404_init_regulator(struct q6v5_wcss *wcss)
 {
 	wcss->cx_supply = devm_regulator_get(wcss->dev, "cx");
 	if (IS_ERR(wcss->cx_supply))
@@ -1017,12 +1041,14 @@ static int q6v5_wcss_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_rproc;
 
-	if (wcss->version == WCSS_QCS404) {
-		ret = q6v5_wcss_init_clock(wcss);
+	if (desc->init_clock) {
+		ret = desc->init_clock(wcss);
 		if (ret)
 			goto free_rproc;
+	}
 
-		ret = q6v5_wcss_init_regulator(wcss);
+	if (desc->init_regulator) {
+		ret = desc->init_regulator(wcss);
 		if (ret)
 			goto free_rproc;
 	}
@@ -1067,6 +1093,7 @@ static int q6v5_wcss_remove(struct platform_device *pdev)
 }
 
 static const struct wcss_data wcss_ipq8074_res_init = {
+	.init_clock = ipq8074_init_clock,
 	.firmware_name = "IPQ8074/q6_fw.mdt",
 	.crash_reason_smem = 421,
 	.aon_reset_required = true,
@@ -1075,6 +1102,8 @@ static int q6v5_wcss_remove(struct platform_device *pdev)
 };
 
 static const struct wcss_data wcss_qcs404_res_init = {
+	.init_clock = qcs404_init_clock,
+	.init_regulator = qcs404_init_regulator,
 	.crash_reason_smem = 421,
 	.firmware_name = "wcnss.mdt",
 	.version = WCSS_QCS404,
-- 
1.9.1

