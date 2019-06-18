Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5344BC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F25E206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="er4prw9S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbfFRJRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 05:17:35 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40540 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729220AbfFRJRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 05:17:32 -0400
Received: by mail-lf1-f65.google.com with SMTP id a9so8685242lff.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 02:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3TVZIODXW9fTNQP0Nr5jsK6hHZLqYcNyQIOWRyhGq4U=;
        b=er4prw9SvJjN7QKkAxQ3ofJ6n3ul7dept5aTmc3MORFbfctZ3bxJWAtvrazrtqro3M
         VfjdyCKsS0Xryw8sddwONHp8HZdvktIF31vP70JjcfB6PERknwiH05ZTnynSR4yJpdgB
         8frXZSU8j8bFrMiNy+hVpgV6Pp0bFzuM45ai5AZFPYjWI+02uc3yklIRiIZtefTBLJc5
         J2dkt78VUvq4tRohZuPQ+nIIjcebp9uVr729GBC/g5Ex7fPVkLpQ/QxyOg5+ff2xvkxd
         8CosBE/fqQwYAUte2VCmf1Roe//zKbiUSntiahz3CJYOEJaNtk7kYgqfIneBEzlMomoI
         utqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3TVZIODXW9fTNQP0Nr5jsK6hHZLqYcNyQIOWRyhGq4U=;
        b=FFxLIQkUqun8STRiSfdHM8+9kaCsREIsoi1rvsypbTQbePJBjrUWn86cQ1g+PdPzWM
         HMJv7tmcFXxSxJJtCiLElbyYnaeiLJzRRwF0g+DG6HdvcgiVQ4+xm5p/xUIsC9yydzbG
         S0sk82S+3dIOK5Rmw9OrBxTenaunhVB2iclKd2oOle6bgzzfufq7PRhyBGN3/fAQb0RF
         00LNVDkWbCn+XzRcajLrOAIhW+11lI9lehVECt4qQJ0aZbGJKNx7fv/leoERc5U29GSr
         oznx5qtqdwKvf1GXNArc/0Br6k6cNWH5+Cs3mbIsAs97/PBPvrVUX2csei8+PP88tLCk
         sPtA==
X-Gm-Message-State: APjAAAX0ISU25uuZArTN2F6DE/x4PyN9aLcXYn3hwiAhTxamgfGwU7Fz
        BAky7P84WAhTAjmNtTy0tBAUBg==
X-Google-Smtp-Source: APXvYqyuG3e+wTlklwRHcHfXGE4tQWqtvkv5/3Vye+tW3f2kSXPmL4y0/L4TwTjCPSBp+DebkMokog==
X-Received: by 2002:ac2:5467:: with SMTP id e7mr34389176lfn.23.1560849450527;
        Tue, 18 Jun 2019 02:17:30 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id b9sm2497444ljj.92.2019.06.18.02.17.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Jun 2019 02:17:29 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     daidavid1@codeaurora.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        evgreen@chromium.org, dianders@chromium.org,
        seansw@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v2 2/2] interconnect: qcom: Add tagging and wake/sleep support for sdm845
Date:   Tue, 18 Jun 2019 12:17:24 +0300
Message-Id: <20190618091724.28232-3-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190618091724.28232-1-georgi.djakov@linaro.org>
References: <20190618091724.28232-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Dai <daidavid1@codeaurora.org>

Add support for wake and sleep commands by using a tag to indicate
whether or not the aggregate and set requests fall into execution
state specific bucket.

Signed-off-by: David Dai <daidavid1@codeaurora.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/sdm845.c | 129 ++++++++++++++++++++++-------
 1 file changed, 98 insertions(+), 31 deletions(-)

diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index fb526004c82e..c100aab39415 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -66,6 +66,17 @@ struct bcm_db {
 #define SDM845_MAX_BCM_PER_NODE	2
 #define SDM845_MAX_VCD		10
 
+#define QCOM_ICC_BUCKET_AMC		0
+#define QCOM_ICC_BUCKET_WAKE		1
+#define QCOM_ICC_BUCKET_SLEEP		2
+#define QCOM_ICC_NUM_BUCKETS		3
+#define QCOM_ICC_TAG_AMC		BIT(QCOM_ICC_BUCKET_AMC)
+#define QCOM_ICC_TAG_WAKE		BIT(QCOM_ICC_BUCKET_WAKE)
+#define QCOM_ICC_TAG_SLEEP		BIT(QCOM_ICC_BUCKET_SLEEP)
+#define QCOM_ICC_TAG_ACTIVE_ONLY	(QCOM_ICC_TAG_AMC | QCOM_ICC_TAG_WAKE)
+#define QCOM_ICC_TAG_ALWAYS		(QCOM_ICC_TAG_AMC | QCOM_ICC_TAG_WAKE |\
+					 QCOM_ICC_TAG_SLEEP)
+
 /**
  * struct qcom_icc_node - Qualcomm specific interconnect nodes
  * @name: the node name used in debugfs
@@ -75,7 +86,9 @@ struct bcm_db {
  * @channels: num of channels at this node
  * @buswidth: width of the interconnect between a node and the bus
  * @sum_avg: current sum aggregate value of all avg bw requests
+ * @sum_avg_cached: previous sum aggregate value of all avg bw requests
  * @max_peak: current max aggregate value of all peak bw requests
+ * @max_peak_cached: previous max aggregate value of all peak bw requests
  * @bcms: list of bcms associated with this logical node
  * @num_bcms: num of @bcms
  */
@@ -86,8 +99,10 @@ struct qcom_icc_node {
 	u16 num_links;
 	u16 channels;
 	u16 buswidth;
-	u64 sum_avg;
-	u64 max_peak;
+	u64 sum_avg[QCOM_ICC_NUM_BUCKETS];
+	u64 sum_avg_cached[QCOM_ICC_NUM_BUCKETS];
+	u64 max_peak[QCOM_ICC_NUM_BUCKETS];
+	u64 max_peak_cached[QCOM_ICC_NUM_BUCKETS];
 	struct qcom_icc_bcm *bcms[SDM845_MAX_BCM_PER_NODE];
 	size_t num_bcms;
 };
@@ -112,8 +127,8 @@ struct qcom_icc_bcm {
 	const char *name;
 	u32 type;
 	u32 addr;
-	u64 vote_x;
-	u64 vote_y;
+	u64 vote_x[QCOM_ICC_NUM_BUCKETS];
+	u64 vote_y[QCOM_ICC_NUM_BUCKETS];
 	bool dirty;
 	bool keepalive;
 	struct bcm_db aux_data;
@@ -555,7 +570,7 @@ inline void tcs_cmd_gen(struct tcs_cmd *cmd, u64 vote_x, u64 vote_y,
 		cmd->wait = true;
 }
 
-static void tcs_list_gen(struct list_head *bcm_list,
+static void tcs_list_gen(struct list_head *bcm_list, int bucket,
 			 struct tcs_cmd tcs_list[SDM845_MAX_VCD],
 			 int n[SDM845_MAX_VCD])
 {
@@ -573,8 +588,8 @@ static void tcs_list_gen(struct list_head *bcm_list,
 			commit = true;
 			cur_vcd_size = 0;
 		}
-		tcs_cmd_gen(&tcs_list[idx], bcm->vote_x, bcm->vote_y,
-			    bcm->addr, commit);
+		tcs_cmd_gen(&tcs_list[idx], bcm->vote_x[bucket],
+			    bcm->vote_y[bucket], bcm->addr, commit);
 		idx++;
 		n[batch]++;
 		/*
@@ -595,32 +610,39 @@ static void tcs_list_gen(struct list_head *bcm_list,
 
 static void bcm_aggregate(struct qcom_icc_bcm *bcm)
 {
-	size_t i;
-	u64 agg_avg = 0;
-	u64 agg_peak = 0;
+	size_t i, bucket;
+	u64 agg_avg[QCOM_ICC_NUM_BUCKETS] = {0};
+	u64 agg_peak[QCOM_ICC_NUM_BUCKETS] = {0};
 	u64 temp;
 
-	for (i = 0; i < bcm->num_nodes; i++) {
-		temp = bcm->nodes[i]->sum_avg * bcm->aux_data.width;
-		do_div(temp, bcm->nodes[i]->buswidth * bcm->nodes[i]->channels);
-		agg_avg = max(agg_avg, temp);
+	for (bucket = 0; bucket < QCOM_ICC_NUM_BUCKETS; bucket++) {
+		for (i = 0; i < bcm->num_nodes; i++) {
+			temp = bcm->nodes[i]->sum_avg_cached[bucket] * bcm->aux_data.width;
+			do_div(temp, bcm->nodes[i]->buswidth * bcm->nodes[i]->channels);
+			agg_avg[bucket] = max(agg_avg[bucket], temp);
 
-		temp = bcm->nodes[i]->max_peak * bcm->aux_data.width;
-		do_div(temp, bcm->nodes[i]->buswidth);
-		agg_peak = max(agg_peak, temp);
-	}
+			temp = bcm->nodes[i]->max_peak_cached[bucket] * bcm->aux_data.width;
+			do_div(temp, bcm->nodes[i]->buswidth);
+			agg_peak[bucket] = max(agg_peak[bucket], temp);
 
-	temp = agg_avg * 1000ULL;
-	do_div(temp, bcm->aux_data.unit);
-	bcm->vote_x = temp;
+			bcm->nodes[i]->sum_avg[bucket] = 0;
+			bcm->nodes[i]->max_peak[bucket] = 0;
+		}
 
-	temp = agg_peak * 1000ULL;
-	do_div(temp, bcm->aux_data.unit);
-	bcm->vote_y = temp;
+		temp = agg_avg[bucket] * 1000ULL;
+		do_div(temp, bcm->aux_data.unit);
+		bcm->vote_x[bucket] = temp;
 
-	if (bcm->keepalive && bcm->vote_x == 0 && bcm->vote_y == 0) {
-		bcm->vote_x = 1;
-		bcm->vote_y = 1;
+		temp = agg_peak[bucket] * 1000ULL;
+		do_div(temp, bcm->aux_data.unit);
+		bcm->vote_y[bucket] = temp;
+	}
+
+	if (bcm->keepalive && bcm->vote_x[0] == 0 && bcm->vote_y[0] == 0) {
+		bcm->vote_x[QCOM_ICC_BUCKET_AMC] = 1;
+		bcm->vote_x[QCOM_ICC_BUCKET_WAKE] = 1;
+		bcm->vote_y[QCOM_ICC_BUCKET_AMC] = 1;
+		bcm->vote_y[QCOM_ICC_BUCKET_WAKE] = 1;
 	}
 
 	bcm->dirty = false;
@@ -631,15 +653,25 @@ static int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
 {
 	size_t i;
 	struct qcom_icc_node *qn;
+	unsigned long tag_word = (unsigned long)tag;
 
 	qn = node->data;
 
+	if (!tag)
+		tag_word = QCOM_ICC_TAG_ALWAYS;
+
+	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
+		if (test_bit(i, &tag_word)) {
+			qn->sum_avg[i] += avg_bw;
+			qn->max_peak[i] = max_t(u32, qn->max_peak[i], peak_bw);
+			qn->sum_avg_cached[i] = qn->sum_avg[i];
+			qn->max_peak_cached[i] = qn->max_peak[i];
+		}
+	}
+
 	*agg_avg += avg_bw;
 	*agg_peak = max_t(u32, *agg_peak, peak_bw);
 
-	qn->sum_avg = *agg_avg;
-	qn->max_peak = *agg_peak;
-
 	for (i = 0; i < qn->num_bcms; i++)
 		qn->bcms[i]->dirty = true;
 
@@ -675,7 +707,7 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 	 * Construct the command list based on a pre ordered list of BCMs
 	 * based on VCD.
 	 */
-	tcs_list_gen(&commit_list, cmds, commit_idx);
+	tcs_list_gen(&commit_list, QCOM_ICC_BUCKET_AMC, cmds, commit_idx);
 
 	if (!commit_idx[0])
 		return ret;
@@ -693,6 +725,41 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 		return ret;
 	}
 
+	INIT_LIST_HEAD(&commit_list);
+
+	for (i = 0; i < qp->num_bcms; i++) {
+		/*
+		 * Only generate WAKE and SLEEP commands if a resource's
+		 * requirements change as the execution environment transitions
+		 * between different power states.
+		 */
+		if (qp->bcms[i]->vote_x[QCOM_ICC_BUCKET_WAKE] !=
+		    qp->bcms[i]->vote_x[QCOM_ICC_BUCKET_SLEEP] ||
+		    qp->bcms[i]->vote_y[QCOM_ICC_BUCKET_WAKE] !=
+		    qp->bcms[i]->vote_y[QCOM_ICC_BUCKET_SLEEP]) {
+			list_add_tail(&qp->bcms[i]->list, &commit_list);
+		}
+	}
+
+	if (list_empty(&commit_list))
+		return ret;
+
+	tcs_list_gen(&commit_list, QCOM_ICC_BUCKET_WAKE, cmds, commit_idx);
+
+	ret = rpmh_write_batch(qp->dev, RPMH_WAKE_ONLY_STATE, cmds, commit_idx);
+	if (ret) {
+		pr_err("Error sending WAKE RPMH requests (%d)\n", ret);
+		return ret;
+	}
+
+	tcs_list_gen(&commit_list, QCOM_ICC_BUCKET_SLEEP, cmds, commit_idx);
+
+	ret = rpmh_write_batch(qp->dev, RPMH_SLEEP_STATE, cmds, commit_idx);
+	if (ret) {
+		pr_err("Error sending SLEEP RPMH requests (%d)\n", ret);
+		return ret;
+	}
+
 	return ret;
 }
 
