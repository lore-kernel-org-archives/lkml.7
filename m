Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F3CC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACCA3205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CPnCXH5w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388006AbfDYT4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:56:01 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38454 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387648AbfDYTxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:53:20 -0400
Received: by mail-pf1-f195.google.com with SMTP id 10so438549pfo.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bgGGBhw0+vDHwgRg8Lg3/ie77JvSZeI8JjKHAU8cgFw=;
        b=CPnCXH5wv5s81Bmkz/8nI8XhRVwekiRbWHgD9nnyYlY2/Jec/MMGJZzKpHhvCa00rI
         eyW8G9UkqbFo7R81IWY66MsHBgyZRS06wgiuLqMmRpE5kKgnKbgmP5PDL2VTWwdNxjwo
         2Q1STDGyQQAohFPmQWIC8+Q7YvgX/WGjV1NI69pMCwL5jChkrtwnDtaTpOikhBGgnOHC
         BuVyvJ10bWA4DX3f1+pA2zySpnmjbnRDpIXqECoLBBOLLPR2lEyl9R+Bt9lKcYjTimxH
         rfzhVbXOGMaixnTIu+caylqN183Uw9n36xNK2OlMt0psyOSe3vfLFGsLBSD6FTNtairq
         0rhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bgGGBhw0+vDHwgRg8Lg3/ie77JvSZeI8JjKHAU8cgFw=;
        b=Wl/FezMeOtUk5R2+P8DFdXYeNA91nsH8mcPjkcU4qVRNdZc8EJh44EUcq5IHXLUcHo
         mP63WugzFLMNXUDLtM0hZsochi7LPBw6WcKm7tG6orIEe613a1jLDPcGsdVTEAF7pku8
         d6AOZq2MOQH9xoGr4dxFDhjYE8H/5dO8iDMojon02cZmTfllVlg9FdtHAIkquVvMEVIT
         CLPREkuHo9iMVUHmDZzbElt0epOOdp3vK+F1VMVtj19yDlfXYSiEPqqMCeYCxHgJ3QD5
         duXtUX4Rg8My21idiEGXt2ojC4m93GsctEXNLHcAy91ztq756ncOAFml+IdZevyq1ONN
         C6Mw==
X-Gm-Message-State: APjAAAXkZWcegiXQTyfmUbAP7BwFqUNvp1uNlViQyNnfmsw818IarNKg
        MqRw7R2MrweHy6/MxyRVfYzbUg==
X-Google-Smtp-Source: APXvYqwAyO7XaKwfEVuZ2QDMyExW3v/1N/bP7mphwS45UyE9QC+p5Eo50AS2lvYWjPT5TtN0v9zeKA==
X-Received: by 2002:a63:cd50:: with SMTP id a16mr20239491pgj.394.1556221998950;
        Thu, 25 Apr 2019 12:53:18 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t64sm47261961pfa.86.2019.04.25.12.53.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:53:18 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/32] coresight: replicator: Prepare for merging with dynamic-replicator
Date:   Thu, 25 Apr 2019 13:52:43 -0600
Message-Id: <20190425195310.31562-6-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190425195310.31562-1-mathieu.poirier@linaro.org>
References: <20190425195310.31562-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

As a preparatory step to merge the separate drivers for static and
dynamic replicators, annotate the static replicator specific details.
Also refactor the probe routine to make it generic in order to merge
the drivers easily.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../coresight/coresight-replicator.c          | 62 +++++++++++--------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index feac98315471..43cbcf1e7be8 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -56,58 +56,68 @@ static const struct coresight_ops replicator_cs_ops = {
 	.link_ops	= &replicator_link_ops,
 };
 
-static int replicator_probe(struct platform_device *pdev)
+static int replicator_probe(struct device *dev)
 {
-	int ret;
-	struct device *dev = &pdev->dev;
+	int ret = 0;
 	struct coresight_platform_data *pdata = NULL;
 	struct replicator_drvdata *drvdata;
 	struct coresight_desc desc = { 0 };
-	struct device_node *np = pdev->dev.of_node;
+	struct device_node *np = dev->of_node;
 
 	if (np) {
 		pdata = of_get_coresight_platform_data(dev, np);
 		if (IS_ERR(pdata))
 			return PTR_ERR(pdata);
-		pdev->dev.platform_data = pdata;
+		dev->platform_data = pdata;
 	}
 
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
 		return -ENOMEM;
 
-	drvdata->dev = &pdev->dev;
-	drvdata->atclk = devm_clk_get(&pdev->dev, "atclk"); /* optional */
+	drvdata->dev = dev;
+	drvdata->atclk = devm_clk_get(dev, "atclk"); /* optional */
 	if (!IS_ERR(drvdata->atclk)) {
 		ret = clk_prepare_enable(drvdata->atclk);
 		if (ret)
 			return ret;
 	}
-	pm_runtime_get_noresume(&pdev->dev);
-	pm_runtime_set_active(&pdev->dev);
-	pm_runtime_enable(&pdev->dev);
-	platform_set_drvdata(pdev, drvdata);
+
+	dev_set_drvdata(dev, drvdata);
 
 	desc.type = CORESIGHT_DEV_TYPE_LINK;
 	desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_SPLIT;
 	desc.ops = &replicator_cs_ops;
-	desc.pdata = pdev->dev.platform_data;
-	desc.dev = &pdev->dev;
+	desc.pdata = dev->platform_data;
+	desc.dev = dev;
 	drvdata->csdev = coresight_register(&desc);
 	if (IS_ERR(drvdata->csdev)) {
 		ret = PTR_ERR(drvdata->csdev);
-		goto out_disable_pm;
+		goto out_disable_clk;
 	}
 
-	pm_runtime_put(&pdev->dev);
+	pm_runtime_put(dev);
 
-	return 0;
-
-out_disable_pm:
-	if (!IS_ERR(drvdata->atclk))
+out_disable_clk:
+	if (ret && !IS_ERR_OR_NULL(drvdata->atclk))
 		clk_disable_unprepare(drvdata->atclk);
-	pm_runtime_put_noidle(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
+	return ret;
+}
+
+static int static_replicator_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
+	ret = replicator_probe(&pdev->dev);
+
+	if (ret) {
+		pm_runtime_put_noidle(&pdev->dev);
+		pm_runtime_disable(&pdev->dev);
+	}
 
 	return ret;
 }
@@ -139,18 +149,18 @@ static const struct dev_pm_ops replicator_dev_pm_ops = {
 			   replicator_runtime_resume, NULL)
 };
 
-static const struct of_device_id replicator_match[] = {
+static const struct of_device_id static_replicator_match[] = {
 	{.compatible = "arm,coresight-replicator"},
 	{}
 };
 
-static struct platform_driver replicator_driver = {
-	.probe          = replicator_probe,
+static struct platform_driver static_replicator_driver = {
+	.probe          = static_replicator_probe,
 	.driver         = {
 		.name   = "coresight-replicator",
-		.of_match_table = replicator_match,
+		.of_match_table = static_replicator_match,
 		.pm	= &replicator_dev_pm_ops,
 		.suppress_bind_attrs = true,
 	},
 };
-builtin_platform_driver(replicator_driver);
+builtin_platform_driver(static_replicator_driver);
-- 
2.17.1

