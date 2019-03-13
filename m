Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B79C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 04:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8DEA2173C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 04:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="X4JUvKCY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfCMEmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 00:42:07 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14053 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfCMEmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 00:42:06 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c888a100000>; Tue, 12 Mar 2019 21:41:52 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 12 Mar 2019 21:42:04 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 12 Mar 2019 21:42:04 -0700
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 Mar
 2019 04:42:04 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 13 Mar 2019 04:42:04 +0000
Received: from linux.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c888a1a0007>; Tue, 12 Mar 2019 21:42:03 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <treding@nvidia.com>, <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v2 1/2] bus: tegra-aconnect: use devm_clk_*() helpers
Date:   Wed, 13 Mar 2019 10:11:58 +0530
Message-ID: <1552452119-6574-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1552452113; bh=ACKj7l6XHkEXydbunQpyzCvAITUcQhTNkWhjqjJbPls=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=X4JUvKCYCG25RAxl/KP+s+X1z9OkG2o4P7afa6Yii9M6ZyRlJhFUp/SOfqs7Klhsx
         ZviBE4msYfFZZhwEfG5OJGvfDDA9EZJdHISrfAM4GKMSDv7Ym4u1Xx0cw20WsJ6nMZ
         pbM90V4amzGziXJqGYBuBwAd7Q7GHXTXEbLAi0eZPyUwrjK2zqMYqNoPbe9bHhNuV2
         L/+fP2OvLYH4yaRC8Fji3RldwcLIKkvwrSgKByJ10fNvv87s6OSdjHFxfVyZ7+PT3h
         rKzdOtd3FMOlyMePU+Y97eqjiEi6/kn6Vm+4f7e7MVrxdvmIUJRq1eFaJ7yZBOwkCy
         Yj7cDuYf39cpg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aconnect bus driver is using pm_clk_*() interface for managing clocks.
With this, clocks seem to be always ON. This happens on Tegra devices
which use BPMP co-processor to manage clock resources, where clocks
are enabled during prepare phase. This is necessary because calls to
BPMP are always blocking. When pm_clk_*() interface is used on such
Tegra devices, clock prepare count is not balanced till driver remove()
gets executed and hence clocks are seen ON always. Thus this patch
replaces pm_clk_*() with devm_clk_*() framework.

Suggested-by: Mohan Kumar D <mkumard@nvidia.com>
Reviewed-by: Jonathan Hunter <jonathanh@nvidia.com>
Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 drivers/bus/tegra-aconnect.c | 64 ++++++++++++++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 20 deletions(-)

diff --git a/drivers/bus/tegra-aconnect.c b/drivers/bus/tegra-aconnect.c
index 084ae28..9349157 100644
--- a/drivers/bus/tegra-aconnect.c
+++ b/drivers/bus/tegra-aconnect.c
@@ -12,28 +12,38 @@
 #include <linux/module.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
-#include <linux/pm_clock.h>
 #include <linux/pm_runtime.h>
 
+struct tegra_aconnect {
+	struct clk	*ape_clk;
+	struct clk	*apb2ape_clk;
+};
+
 static int tegra_aconnect_probe(struct platform_device *pdev)
 {
-	int ret;
+	struct tegra_aconnect *aconnect;
 
 	if (!pdev->dev.of_node)
 		return -EINVAL;
 
-	ret = pm_clk_create(&pdev->dev);
-	if (ret)
-		return ret;
+	aconnect = devm_kzalloc(&pdev->dev, sizeof(struct tegra_aconnect),
+				GFP_KERNEL);
+	if (!aconnect)
+		return -ENOMEM;
 
-	ret = of_pm_clk_add_clk(&pdev->dev, "ape");
-	if (ret)
-		goto clk_destroy;
+	aconnect->ape_clk = devm_clk_get(&pdev->dev, "ape");
+	if (IS_ERR(aconnect->ape_clk)) {
+		dev_err(&pdev->dev, "Can't retrieve ape clock\n");
+		return PTR_ERR(aconnect->ape_clk);
+	}
 
-	ret = of_pm_clk_add_clk(&pdev->dev, "apb2ape");
-	if (ret)
-		goto clk_destroy;
+	aconnect->apb2ape_clk = devm_clk_get(&pdev->dev, "apb2ape");
+	if (IS_ERR(aconnect->apb2ape_clk)) {
+		dev_err(&pdev->dev, "Can't retrieve apb2ape clock\n");
+		return PTR_ERR(aconnect->apb2ape_clk);
+	}
 
+	dev_set_drvdata(&pdev->dev, aconnect);
 	pm_runtime_enable(&pdev->dev);
 
 	of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
@@ -41,30 +51,44 @@ static int tegra_aconnect_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "Tegra ACONNECT bus registered\n");
 
 	return 0;
-
-clk_destroy:
-	pm_clk_destroy(&pdev->dev);
-
-	return ret;
 }
 
 static int tegra_aconnect_remove(struct platform_device *pdev)
 {
 	pm_runtime_disable(&pdev->dev);
 
-	pm_clk_destroy(&pdev->dev);
-
 	return 0;
 }
 
 static int tegra_aconnect_runtime_resume(struct device *dev)
 {
-	return pm_clk_resume(dev);
+	struct tegra_aconnect *aconnect = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(aconnect->ape_clk);
+	if (ret) {
+		dev_err(dev, "ape clk_enable failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(aconnect->apb2ape_clk);
+	if (ret) {
+		clk_disable_unprepare(aconnect->ape_clk);
+		dev_err(dev, "apb2ape clk_enable failed: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
 }
 
 static int tegra_aconnect_runtime_suspend(struct device *dev)
 {
-	return pm_clk_suspend(dev);
+	struct tegra_aconnect *aconnect = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(aconnect->ape_clk);
+	clk_disable_unprepare(aconnect->apb2ape_clk);
+
+	return 0;
 }
 
 static const struct dev_pm_ops tegra_aconnect_pm_ops = {
-- 
2.7.4

