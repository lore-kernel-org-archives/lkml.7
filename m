Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9111CC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD262077C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jncSkvNA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387713AbfDYTx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:53:26 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41308 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387650AbfDYTxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:53:21 -0400
Received: by mail-pl1-f194.google.com with SMTP id d9so308867pls.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+evSfPq/EpzLzSpYOE5j/ZH7ptSILdbaPSbrFFcipmg=;
        b=jncSkvNAfpRfIxPhI51gENuBI4h79pz1l9Rt0NTeUSmWRWt5VKuYnHL/lOVCBKGXmm
         sgwhQ0BaVoSTHPc6AaqEO5uxs1QjdvxmpicvfcX+Xw18xWKT2OvIpLNezD+jBc0uueQq
         BpdBbEeSu97qcu9p+0kki2v3XUzLU5DIR+ZBtIxGjbLAB8YQIbMIKdHAsmxiaRGucoQS
         gKuWRab6TDUIeJjarhra0zGleVm1q7GBNlOp4cb79WTF4Qy8UAcCL4AJRONPhAWG444R
         C4gJGCRW63FYtZd4XeNs9S72GA7tDKcydqdoo/YytcXzYPK47zhLWAonSjaaTtQLZlyd
         lIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+evSfPq/EpzLzSpYOE5j/ZH7ptSILdbaPSbrFFcipmg=;
        b=JKPTxFwdHG3vAKSj8SMToAS22PGDaKOd96WoebFtUsqgEOedILFwIdnZkeRHl8eAOx
         bJIVwedZe7jf6SWIbKoMgBoHaz1D4p+ASqXXVa5+njSKC75V50tlyPv5/aUk4LUC8+bA
         CIbT00Q0xlDB91lDTa2hoJv4tmGkLd55a4ZWwArVvzPagpz6X5LCMONvOd5dZAr62TDn
         uDvYaoxhmYIBuwOMXQabGwPjEtPONqiGaLhv7i+1Tj6PhoruEbDkIt5TuJWwsTjq9CWH
         V99esOlJvx5oSKrny9P6Z5jQyhGIrzm8wNmHFGxSQ8xVZC6MM584hM+LX0RdoQ0BxOT+
         3Xtw==
X-Gm-Message-State: APjAAAUvkfpBX+BOFbs5eH8KI0sBAIYAu/2tnBl9xG37il7Lo3Bg/qi/
        D7PnaMD4Q6d/ukdfn16rR3yXl1L0ROM=
X-Google-Smtp-Source: APXvYqxl//4SWmLJnbJ+QkmlAf5dX1mv8zNQZZJsvFDCEO7jzoC7u4NdJfOHhgmQHa9fBXxGX3plBA==
X-Received: by 2002:a17:902:9b92:: with SMTP id y18mr33037768plp.187.1556222000252;
        Thu, 25 Apr 2019 12:53:20 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t64sm47261961pfa.86.2019.04.25.12.53.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:53:19 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/32] coresight: dynamic-replicator: Prepare for merging with static replicator
Date:   Thu, 25 Apr 2019 13:52:44 -0600
Message-Id: <20190425195310.31562-7-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190425195310.31562-1-mathieu.poirier@linaro.org>
References: <20190425195310.31562-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Rename the dynamic replicator specific routines for merging with the
replicator driver. Also re-arrange the probe routine to make it easier
to merge.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../coresight/coresight-dynamic-replicator.c  | 104 +++++++++++-------
 1 file changed, 63 insertions(+), 41 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
index fe176b987685..b7d7c4146f9a 100644
--- a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
@@ -21,13 +21,13 @@
 #define REPLICATOR_IDFILTER1		0x004
 
 /**
- * struct replicator_state - specifics associated to a replicator component
+ * struct replicator_drvdata - specifics associated to a replicator component
  * @base:	memory mapped base address for this component.
  * @dev:	the device entity associated with this component
  * @atclk:	optional clock for the core parts of the replicator.
  * @csdev:	component vitals needed by the framework
  */
-struct replicator_state {
+struct replicator_drvdata {
 	void __iomem		*base;
 	struct device		*dev;
 	struct clk		*atclk;
@@ -35,9 +35,9 @@ struct replicator_state {
 };
 
 /*
- * replicator_reset : Reset the replicator configuration to sane values.
+ * dynamic_replicator_reset : Reset the replicator configuration to sane values.
  */
-static void replicator_reset(struct replicator_state *drvdata)
+static void dynamic_replicator_reset(struct replicator_drvdata *drvdata)
 {
 	CS_UNLOCK(drvdata->base);
 
@@ -50,12 +50,11 @@ static void replicator_reset(struct replicator_state *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
-static int replicator_enable(struct coresight_device *csdev, int inport,
-			      int outport)
+static int dynamic_replicator_enable(struct replicator_drvdata *drvdata,
+				     int inport, int outport)
 {
 	int rc = 0;
 	u32 reg;
-	struct replicator_state *drvdata = dev_get_drvdata(csdev->dev.parent);
 
 	switch (outport) {
 	case 0:
@@ -76,21 +75,28 @@ static int replicator_enable(struct coresight_device *csdev, int inport,
 		rc = coresight_claim_device_unlocked(drvdata->base);
 
 	/* Ensure that the outport is enabled. */
-	if (!rc) {
+	if (!rc)
 		writel_relaxed(0x00, drvdata->base + reg);
-		dev_dbg(drvdata->dev, "REPLICATOR enabled\n");
-	}
-
 	CS_LOCK(drvdata->base);
 
 	return rc;
 }
 
-static void replicator_disable(struct coresight_device *csdev, int inport,
-				int outport)
+static int replicator_enable(struct coresight_device *csdev, int inport,
+			     int outport)
+{
+	int rc = 0;
+	struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	rc = dynamic_replicator_enable(drvdata, inport, outport);
+	dev_dbg(drvdata->dev, "REPLICATOR enabled\n");
+	return rc;
+}
+
+static void dynamic_replicator_disable(struct replicator_drvdata *drvdata,
+				       int inport, int outport)
 {
 	u32 reg;
-	struct replicator_state *drvdata = dev_get_drvdata(csdev->dev.parent);
 
 	switch (outport) {
 	case 0:
@@ -113,7 +119,14 @@ static void replicator_disable(struct coresight_device *csdev, int inport,
 	    (readl_relaxed(drvdata->base + REPLICATOR_IDFILTER1) == 0xff))
 		coresight_disclaim_device_unlocked(drvdata->base);
 	CS_LOCK(drvdata->base);
+}
+
+static void replicator_disable(struct coresight_device *csdev, int inport,
+			       int outport)
+{
+	struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
+	dynamic_replicator_disable(drvdata, inport, outport);
 	dev_dbg(drvdata->dev, "REPLICATOR disabled\n");
 }
 
@@ -127,7 +140,7 @@ static const struct coresight_ops replicator_cs_ops = {
 };
 
 #define coresight_replicator_reg(name, offset) \
-	coresight_simple_reg32(struct replicator_state, name, offset)
+	coresight_simple_reg32(struct replicator_drvdata, name, offset)
 
 coresight_replicator_reg(idfilter0, REPLICATOR_IDFILTER0);
 coresight_replicator_reg(idfilter1, REPLICATOR_IDFILTER1);
@@ -148,52 +161,55 @@ static const struct attribute_group *replicator_groups[] = {
 	NULL,
 };
 
-static int replicator_probe(struct amba_device *adev, const struct amba_id *id)
+static int replicator_probe(struct device *dev, struct resource *res)
 {
 	int ret = 0;
-	struct device *dev = &adev->dev;
-	struct resource *res = &adev->res;
 	struct coresight_platform_data *pdata = NULL;
-	struct replicator_state *drvdata;
+	struct replicator_drvdata *drvdata;
 	struct coresight_desc desc = { 0 };
-	struct device_node *np = adev->dev.of_node;
+	struct device_node *np = dev->of_node;
 	void __iomem *base;
 
 	if (np) {
 		pdata = of_get_coresight_platform_data(dev, np);
 		if (IS_ERR(pdata))
 			return PTR_ERR(pdata);
-		adev->dev.platform_data = pdata;
+		dev->platform_data = pdata;
 	}
 
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
 		return -ENOMEM;
 
-	drvdata->dev = &adev->dev;
-	drvdata->atclk = devm_clk_get(&adev->dev, "atclk"); /* optional */
+	drvdata->dev = dev;
+	drvdata->atclk = devm_clk_get(dev, "atclk"); /* optional */
 	if (!IS_ERR(drvdata->atclk)) {
 		ret = clk_prepare_enable(drvdata->atclk);
 		if (ret)
 			return ret;
 	}
 
-	/* Validity for the resource is already checked by the AMBA core */
-	base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(base)) {
-		ret = PTR_ERR(base);
-		goto out_disable_clk;
+	/*
+	 * Map the device base for dynamic-replicator, which has been
+	 * validated by AMBA core
+	 */
+	if (res) {
+		base = devm_ioremap_resource(dev, res);
+		if (IS_ERR(base)) {
+			ret = PTR_ERR(base);
+			goto out_disable_clk;
+		}
+		drvdata->base = base;
+		desc.groups = replicator_groups;
 	}
 
-	drvdata->base = base;
 	dev_set_drvdata(dev, drvdata);
 
 	desc.type = CORESIGHT_DEV_TYPE_LINK;
 	desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_SPLIT;
 	desc.ops = &replicator_cs_ops;
-	desc.pdata = adev->dev.platform_data;
-	desc.dev = &adev->dev;
-	desc.groups = replicator_groups;
+	desc.pdata = dev->platform_data;
+	desc.dev = dev;
 	drvdata->csdev = coresight_register(&desc);
 
 	if (IS_ERR(drvdata->csdev)) {
@@ -201,8 +217,8 @@ static int replicator_probe(struct amba_device *adev, const struct amba_id *id)
 		goto out_disable_clk;
 	}
 
-	replicator_reset(drvdata);
-	pm_runtime_put(&adev->dev);
+	dynamic_replicator_reset(drvdata);
+	pm_runtime_put(dev);
 
 out_disable_clk:
 	if (ret && !IS_ERR_OR_NULL(drvdata->atclk))
@@ -210,10 +226,16 @@ static int replicator_probe(struct amba_device *adev, const struct amba_id *id)
 	return ret;
 }
 
+static int dynamic_replicator_probe(struct amba_device *adev,
+				    const struct amba_id *id)
+{
+	return replicator_probe(&adev->dev, &adev->res);
+}
+
 #ifdef CONFIG_PM
 static int replicator_runtime_suspend(struct device *dev)
 {
-	struct replicator_state *drvdata = dev_get_drvdata(dev);
+	struct replicator_drvdata *drvdata = dev_get_drvdata(dev);
 
 	if (drvdata && !IS_ERR(drvdata->atclk))
 		clk_disable_unprepare(drvdata->atclk);
@@ -223,7 +245,7 @@ static int replicator_runtime_suspend(struct device *dev)
 
 static int replicator_runtime_resume(struct device *dev)
 {
-	struct replicator_state *drvdata = dev_get_drvdata(dev);
+	struct replicator_drvdata *drvdata = dev_get_drvdata(dev);
 
 	if (drvdata && !IS_ERR(drvdata->atclk))
 		clk_prepare_enable(drvdata->atclk);
@@ -238,7 +260,7 @@ static const struct dev_pm_ops replicator_dev_pm_ops = {
 			   NULL)
 };
 
-static const struct amba_id replicator_ids[] = {
+static const struct amba_id dynamic_replicator_ids[] = {
 	{
 		.id     = 0x000bb909,
 		.mask   = 0x000fffff,
@@ -251,13 +273,13 @@ static const struct amba_id replicator_ids[] = {
 	{ 0, 0 },
 };
 
-static struct amba_driver replicator_driver = {
+static struct amba_driver dynamic_replicator_driver = {
 	.drv = {
 		.name	= "coresight-dynamic-replicator",
 		.pm	= &replicator_dev_pm_ops,
 		.suppress_bind_attrs = true,
 	},
-	.probe		= replicator_probe,
-	.id_table	= replicator_ids,
+	.probe		= dynamic_replicator_probe,
+	.id_table	= dynamic_replicator_ids,
 };
-builtin_amba_driver(replicator_driver);
+builtin_amba_driver(dynamic_replicator_driver);
-- 
2.17.1

