Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E80C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685B6217AB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w7KZ1TIq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfK1Neq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 08:34:46 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34288 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfK1Nen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:34:43 -0500
Received: by mail-wm1-f68.google.com with SMTP id j18so7441366wmk.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 05:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8VrphYeqahrQ5kATlO0grU5q+TZ5g96u9ghQO6Q2fFc=;
        b=w7KZ1TIqRorqFk6V1hPTFmPCV+1JsZnF6guXwmyWEmd2W7y9YMCY2uwvxnvykWSA6f
         OsOSqJsju0xA5ElMwpLTwVTRv+KgcOwVqfZccUsaSaxCRkyLOSj0qvii+PazYdpeCffQ
         IC4Xunj4UuQIFPzmkkZANHwXqAB64nMhMa+ixovKeNQUyJtjA9TjeYonMCz20PF1aonP
         A33R5BIWPqXSNyxyGTgTP0WYofOi2L1YNjBeTEXqgCAJH7ZCXxOuZP13AGhJLI9pqIqn
         ZeNR8Op/b22RzqQAWtf4p1HVMSovwHjxeyFFkV0+fLXM6lwm21OXN5OetG6ysGEnCuc/
         o80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8VrphYeqahrQ5kATlO0grU5q+TZ5g96u9ghQO6Q2fFc=;
        b=UB70TO9DqaJImU6nZmUQ9SkZ7mEhjNk2cY8zpip88Teuvm8opMxF1/d2l6HLxsmcju
         5BOOrdBFn5GuIEtgndpn4B1xqQX6mYkF3OO1HK4hINPmBb0to9v9ztzysj4gtrT11GzT
         7fuKxhxLiDu2xQG1i9scrgRtf2pIe7PVIy8aqtxO4OGn72lIB21uIdzeU8CmARcwnOFp
         XqYtZ0iy5odauF2Y0MmHKw0VTEok4yG9h3HRZTUHZzIZVZ0h7V5rmBvs+MWhg9N/6z7Y
         st0RuOtbOfuESPLYvM2xlJMkgtWd2aLTod9Ny4PfBHXQA788tbYYkxJwKEgZjpd1GMQi
         hh+g==
X-Gm-Message-State: APjAAAU4LNWXuZ7JiPcy6GKVJbXiri/Lf4WZn1aajExH1srQkBTzbR6G
        P47gIxdAKm1s1qcgkOXsZ91yOQ==
X-Google-Smtp-Source: APXvYqyDndcOfTmJ55lnby2VAYUUKyUwBpprxa7XtgXE/tKbSY5omtNvM2XPx2ePvPyTj7Mg+KyTJQ==
X-Received: by 2002:a1c:1b88:: with SMTP id b130mr8979340wmb.4.1574948082044;
        Thu, 28 Nov 2019 05:34:42 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id y20sm2220451wmi.25.2019.11.28.05.34.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Nov 2019 05:34:41 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, digetx@gmail.com,
        evgreen@chromium.org, daidavid1@codeaurora.org,
        masneyb@onstation.org, sibis@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH 5/5] interconnect: qcom: Use the new common helper for node removal
Date:   Thu, 28 Nov 2019 15:34:35 +0200
Message-Id: <20191128133435.25667-5-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191128133435.25667-1-georgi.djakov@linaro.org>
References: <20191128133435.25667-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a new helper function for removing all nodes. Let's use it instead
of duplicating the code.

In addition to the above, instead of duplicating the code, simplify the
probe function error path by calling driver removal function directly.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/msm8974.c | 40 ++++++++++-------------------
 drivers/interconnect/qcom/qcs404.c  | 31 ++++++++--------------
 drivers/interconnect/qcom/sdm845.c  | 29 +++++++--------------
 3 files changed, 33 insertions(+), 67 deletions(-)

diff --git a/drivers/interconnect/qcom/msm8974.c b/drivers/interconnect/qcom/msm8974.c
index 0a1a8ba6afa7..8823dce811c3 100644
--- a/drivers/interconnect/qcom/msm8974.c
+++ b/drivers/interconnect/qcom/msm8974.c
@@ -644,6 +644,15 @@ static int msm8974_icc_set(struct icc_node *src, struct icc_node *dst)
 	return 0;
 }
 
+static int msm8974_icc_remove(struct platform_device *pdev)
+{
+	struct msm8974_icc_provider *qp = platform_get_drvdata(pdev);
+
+	icc_nodes_remove(&qp->provider);
+	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
+	return icc_provider_del(&qp->provider);
+}
+
 static int msm8974_icc_probe(struct platform_device *pdev)
 {
 	const struct msm8974_icc_desc *desc;
@@ -701,7 +710,8 @@ static int msm8974_icc_probe(struct platform_device *pdev)
 	ret = icc_provider_add(provider);
 	if (ret) {
 		dev_err(dev, "error adding interconnect provider: %d\n", ret);
-		goto err_disable_clks;
+		clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
+		return ret;
 	}
 
 	for (i = 0; i < num_nodes; i++) {
@@ -710,7 +720,7 @@ static int msm8974_icc_probe(struct platform_device *pdev)
 		node = icc_node_create(qnodes[i]->id);
 		if (IS_ERR(node)) {
 			ret = PTR_ERR(node);
-			goto err_del_icc;
+			goto err;
 		}
 
 		node->name = qnodes[i]->name;
@@ -731,34 +741,12 @@ static int msm8974_icc_probe(struct platform_device *pdev)
 
 	return 0;
 
-err_del_icc:
-	list_for_each_entry_safe(node, &provider->nodes, node_list) {
-		icc_node_del(node);
-		icc_node_destroy(node->id);
-	}
-	icc_provider_del(provider);
-
-err_disable_clks:
-	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
+err:
+	msm8974_icc_remove(pdev);
 
 	return ret;
 }
 
-static int msm8974_icc_remove(struct platform_device *pdev)
-{
-	struct msm8974_icc_provider *qp = platform_get_drvdata(pdev);
-	struct icc_provider *provider = &qp->provider;
-	struct icc_node *n;
-
-	list_for_each_entry_safe(n, &provider->nodes, node_list) {
-		icc_node_del(n);
-		icc_node_destroy(n->id);
-	}
-	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
-
-	return icc_provider_del(provider);
-}
-
 static const struct of_device_id msm8974_noc_of_match[] = {
 	{ .compatible = "qcom,msm8974-bimc", .data = &msm8974_bimc},
 	{ .compatible = "qcom,msm8974-cnoc", .data = &msm8974_cnoc},
diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
index d2b455021416..a4c6ba715f61 100644
--- a/drivers/interconnect/qcom/qcs404.c
+++ b/drivers/interconnect/qcom/qcs404.c
@@ -406,6 +406,15 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 	return 0;
 }
 
+static int qnoc_remove(struct platform_device *pdev)
+{
+	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
+
+	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
+	icc_nodes_remove(&qp->provider);
+	return icc_provider_del(&qp->provider);
+}
+
 static int qnoc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -494,31 +503,11 @@ static int qnoc_probe(struct platform_device *pdev)
 
 	return 0;
 err:
-	list_for_each_entry_safe(node, &provider->nodes, node_list) {
-		icc_node_del(node);
-		icc_node_destroy(node->id);
-	}
-	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
-	icc_provider_del(provider);
+	qnoc_remove(pdev);
 
 	return ret;
 }
 
-static int qnoc_remove(struct platform_device *pdev)
-{
-	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
-	struct icc_provider *provider = &qp->provider;
-	struct icc_node *n;
-
-	list_for_each_entry_safe(n, &provider->nodes, node_list) {
-		icc_node_del(n);
-		icc_node_destroy(n->id);
-	}
-	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
-
-	return icc_provider_del(provider);
-}
-
 static const struct of_device_id qcs404_noc_of_match[] = {
 	{ .compatible = "qcom,qcs404-bimc", .data = &qcs404_bimc },
 	{ .compatible = "qcom,qcs404-pcnoc", .data = &qcs404_pcnoc },
diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index 924c2d056d85..2b8f13e78471 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -768,6 +768,14 @@ static int cmp_vcd(const void *_l, const void *_r)
 		return 1;
 }
 
+static int qnoc_remove(struct platform_device *pdev)
+{
+	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
+
+	icc_nodes_remove(&qp->provider);
+	return icc_provider_del(&qp->provider);
+}
+
 static int qnoc_probe(struct platform_device *pdev)
 {
 	const struct qcom_icc_desc *desc;
@@ -855,29 +863,10 @@ static int qnoc_probe(struct platform_device *pdev)
 
 	return ret;
 err:
-	list_for_each_entry(node, &provider->nodes, node_list) {
-		icc_node_del(node);
-		icc_node_destroy(node->id);
-	}
-
-	icc_provider_del(provider);
+	qnoc_remove(pdev);
 	return ret;
 }
 
-static int qnoc_remove(struct platform_device *pdev)
-{
-	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
-	struct icc_provider *provider = &qp->provider;
-	struct icc_node *n;
-
-	list_for_each_entry_safe(n, &provider->nodes, node_list) {
-		icc_node_del(n);
-		icc_node_destroy(n->id);
-	}
-
-	return icc_provider_del(provider);
-}
-
 static const struct of_device_id qnoc_of_match[] = {
 	{ .compatible = "qcom,sdm845-rsc-hlos", .data = &sdm845_rsc_hlos },
 	{ },
