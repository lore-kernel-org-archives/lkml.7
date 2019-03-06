Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E64C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4613620661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="hXP+Yies"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbfCFKlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:41:31 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:18526 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729223AbfCFKlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:41:31 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c7fa3d90002>; Wed, 06 Mar 2019 02:41:29 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 06 Mar 2019 02:41:28 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 06 Mar 2019 02:41:28 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 6 Mar
 2019 10:41:28 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 6 Mar 2019 10:41:28 +0000
Received: from linux.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c7fa3d50000>; Wed, 06 Mar 2019 02:41:27 -0800
From:   Sameer Pujar <spujar@nvidia.com>
To:     <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <mkumard@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 1/3] bus: tegra-aconnect: use devm_clk_*() helpers
Date:   Wed, 6 Mar 2019 16:11:16 +0530
Message-ID: <1551868878-1131-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551868889; bh=2P8UBw6vXPbZ7oSbE4OEK5sJXWd0pcAkC41A42Jcnic=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=hXP+Yies2msM77JGhBBBQgLwuQ9FFvAz6qmEeJlb2vOczKnlNTgamFTwgGb7F7S1Q
         NXFgnt6gqjnqUQIEGBl9JNfItWn6SsQ764DnScwyRKCHTwI7JYBR9WMAE0sNrjVlDG
         ZyXEcu+Eq4sfs2q6AVNbkVxKYfrLVnHv+DBjvTtMplunZFWy1X4mUDHwvA/+pjM0Wf
         mx6AhZ085IKPnUiPFw5uNF9S0Wbom3zVSBho6QCjHZi0qyOHCCJHmVUyuKuCOnnWCf
         wLrYDLo9W6iyppN3EC2jVZoJ3593A355pyWZgvbcYxzxYjaJhzeDxuGeUWz6vGLhhj
         wtwEDZiq6WyKg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aconnect bus driver is using pm_clk_*() for managing required clocks. With
this, clocks seem to be always ON. This happens because, the clock prepare
count is incremented in pm_clock_acquire() which is called during device
probe(). The count is decremented during remove(). Hence the prepare_count
for the clock is non-zero till the remove() gets executed. This is true for
BPMP managed clock sources, where clock enable and disable happens during
prepare and unprepare phases respectively. Thus clocks remain ON always and
that is why pm_clk_*() cannot be used on Tegra.

This patch replaces pm_clk_*() with devm_clk_*() and runtime PM callbacks
reflect this. System suspend/resume can use pm_runtime_force_suspend/resume

Suggested-by: Mohan Kumar D <mkumard@nvidia.com>
Reviewed-by: Jonathan Hunter <jonathanh@nvidia.com>
Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 drivers/bus/tegra-aconnect.c | 66 ++++++++++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 20 deletions(-)

diff --git a/drivers/bus/tegra-aconnect.c b/drivers/bus/tegra-aconnect.c
index 084ae28..ac58142 100644
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
@@ -41,35 +51,51 @@ static int tegra_aconnect_probe(struct platform_device *pdev)
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
 	SET_RUNTIME_PM_OPS(tegra_aconnect_runtime_suspend,
 			   tegra_aconnect_runtime_resume, NULL)
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				      pm_runtime_force_resume)
 };
 
 static const struct of_device_id tegra_aconnect_of_match[] = {
-- 
2.7.4

