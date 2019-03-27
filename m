Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E33C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3884B2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388147AbfC0TYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:24:13 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34198 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731942AbfC0TYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 15:24:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37CAC374;
        Wed, 27 Mar 2019 12:24:11 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4B19E3F557;
        Wed, 27 Mar 2019 12:24:10 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     balbi@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc3: of-simple: Convert to bulk clk API
Date:   Wed, 27 Mar 2019 19:24:06 +0000
Message-Id: <d651d591711dc0c7ffed8dc51a1ab066225f5120.1553714400.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.21.0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the bulk API has a "get all of the clocks" helper to match
what this code wants, there's little reason not to switch over.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/usb/dwc3/dwc3-of-simple.c | 95 ++++++-------------------------
 1 file changed, 17 insertions(+), 78 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
index 4c2771c5e727..c4da82dd15c7 100644
--- a/drivers/usb/dwc3/dwc3-of-simple.c
+++ b/drivers/usb/dwc3/dwc3-of-simple.c
@@ -24,59 +24,13 @@
 
 struct dwc3_of_simple {
 	struct device		*dev;
-	struct clk		**clks;
+	struct clk_bulk_data	*clks;
 	int			num_clocks;
 	struct reset_control	*resets;
 	bool			pulse_resets;
 	bool			need_reset;
 };
 
-static int dwc3_of_simple_clk_init(struct dwc3_of_simple *simple, int count)
-{
-	struct device		*dev = simple->dev;
-	struct device_node	*np = dev->of_node;
-	int			i;
-
-	simple->num_clocks = count;
-
-	if (!count)
-		return 0;
-
-	simple->clks = devm_kcalloc(dev, simple->num_clocks,
-			sizeof(struct clk *), GFP_KERNEL);
-	if (!simple->clks)
-		return -ENOMEM;
-
-	for (i = 0; i < simple->num_clocks; i++) {
-		struct clk	*clk;
-		int		ret;
-
-		clk = of_clk_get(np, i);
-		if (IS_ERR(clk)) {
-			while (--i >= 0) {
-				clk_disable_unprepare(simple->clks[i]);
-				clk_put(simple->clks[i]);
-			}
-			return PTR_ERR(clk);
-		}
-
-		ret = clk_prepare_enable(clk);
-		if (ret < 0) {
-			while (--i >= 0) {
-				clk_disable_unprepare(simple->clks[i]);
-				clk_put(simple->clks[i]);
-			}
-			clk_put(clk);
-
-			return ret;
-		}
-
-		simple->clks[i] = clk;
-	}
-
-	return 0;
-}
-
 static int dwc3_of_simple_probe(struct platform_device *pdev)
 {
 	struct dwc3_of_simple	*simple;
@@ -84,7 +38,6 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
 	struct device_node	*np = dev->of_node;
 
 	int			ret;
-	int			i;
 	bool			shared_resets = false;
 
 	simple = devm_kzalloc(dev, sizeof(*simple), GFP_KERNEL);
@@ -124,20 +77,18 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
 			goto err_resetc_put;
 	}
 
-	ret = dwc3_of_simple_clk_init(simple, of_count_phandle_with_args(np,
-						"clocks", "#clock-cells"));
+	ret = clk_bulk_get_all(simple->dev, &simple->clks);
+	if (ret < 0)
+		goto err_resetc_assert;
+
+	simple->num_clocks = ret;
+	ret = clk_bulk_prepare_enable(simple->num_clocks, simple->clks);
 	if (ret)
 		goto err_resetc_assert;
 
 	ret = of_platform_populate(np, NULL, NULL, dev);
-	if (ret) {
-		for (i = 0; i < simple->num_clocks; i++) {
-			clk_disable_unprepare(simple->clks[i]);
-			clk_put(simple->clks[i]);
-		}
-
-		goto err_resetc_assert;
-	}
+	if (ret)
+		goto err_clk_put;
 
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
@@ -145,6 +96,10 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_clk_put:
+	clk_bulk_disable_unprepare(simple->num_clocks, simple->clks);
+	clk_bulk_put_all(simple->num_clocks, simple->clks);
+
 err_resetc_assert:
 	if (!simple->pulse_resets)
 		reset_control_assert(simple->resets);
@@ -158,14 +113,11 @@ static int dwc3_of_simple_remove(struct platform_device *pdev)
 {
 	struct dwc3_of_simple	*simple = platform_get_drvdata(pdev);
 	struct device		*dev = &pdev->dev;
-	int			i;
 
 	of_platform_depopulate(dev);
 
-	for (i = 0; i < simple->num_clocks; i++) {
-		clk_disable_unprepare(simple->clks[i]);
-		clk_put(simple->clks[i]);
-	}
+	clk_bulk_disable_unprepare(simple->num_clocks, simple->clks);
+	clk_bulk_put_all(simple->num_clocks, simple->clks);
 	simple->num_clocks = 0;
 
 	if (!simple->pulse_resets)
@@ -183,10 +135,8 @@ static int dwc3_of_simple_remove(struct platform_device *pdev)
 static int __maybe_unused dwc3_of_simple_runtime_suspend(struct device *dev)
 {
 	struct dwc3_of_simple	*simple = dev_get_drvdata(dev);
-	int			i;
 
-	for (i = 0; i < simple->num_clocks; i++)
-		clk_disable(simple->clks[i]);
+	clk_bulk_disable(simple->num_clocks, simple->clks);
 
 	return 0;
 }
@@ -194,19 +144,8 @@ static int __maybe_unused dwc3_of_simple_runtime_suspend(struct device *dev)
 static int __maybe_unused dwc3_of_simple_runtime_resume(struct device *dev)
 {
 	struct dwc3_of_simple	*simple = dev_get_drvdata(dev);
-	int			ret;
-	int			i;
 
-	for (i = 0; i < simple->num_clocks; i++) {
-		ret = clk_enable(simple->clks[i]);
-		if (ret < 0) {
-			while (--i >= 0)
-				clk_disable(simple->clks[i]);
-			return ret;
-		}
-	}
-
-	return 0;
+	return clk_bulk_enable(simple->num_clocks, simple->clks);
 }
 
 static int __maybe_unused dwc3_of_simple_suspend(struct device *dev)
-- 
2.21.0.dirty

