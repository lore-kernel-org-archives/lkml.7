Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFD2C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F7C23430
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567177790;
	bh=RILJflNJ5mDBzGYY/ADbLlIE/PJaU8KzdXSJ7NiVjTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fvUwqmrE7AnfZV+633AfOjj+r/K6v78n5J6AscA/Ds66Uvk4d7gZY7zsx+ZUwrEUP
	 xfD0rReLfaFTn66UpdP14u1TCGKz883ZXiLnBZvhpNdgtli1XTLtL6JlS/aWxbztlc
	 mjAwH7vTwxblqMOc5Vm6Y2B5JahPgfvZ9w/kX82o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfH3PJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:09:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:42530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727938AbfH3PJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:09:26 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2EC023429;
        Fri, 30 Aug 2019 15:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567177765;
        bh=RILJflNJ5mDBzGYY/ADbLlIE/PJaU8KzdXSJ7NiVjTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KRb3iD3pSLS3VXWhSQb4uFGSE1thomPJ3NTp7bvotm/5Mufk8KL1Bm/yMRzraI4zO
         xjhIvvaEwVQiCjA9qwRQQlkoKRNADGZaBnNIjR/kMjvEwMcJe5z+Spvl+a4BwdZKqs
         VpfCpXmr6Y3myQ5ff5bnN8fqjpB9pd0MY4gWKhVE=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 02/12] clk: fixed-rate: Convert to clk_hw based APIs
Date:   Fri, 30 Aug 2019 08:09:13 -0700
Message-Id: <20190830150923.259497-3-sboyd@kernel.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190830150923.259497-1-sboyd@kernel.org>
References: <20190830150923.259497-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code still uses struct clk to register clks from the probe path.
Migrate this to the clk_hw based APIs to modernize the code. Also, this
isn't a module and it can't be one because the driver is always builtin
so drop the module table.

Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk-fixed-rate.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/clk-fixed-rate.c b/drivers/clk/clk-fixed-rate.c
index a7e4aef7a376..eed0be664c07 100644
--- a/drivers/clk/clk-fixed-rate.c
+++ b/drivers/clk/clk-fixed-rate.c
@@ -155,9 +155,9 @@ void clk_hw_unregister_fixed_rate(struct clk_hw *hw)
 EXPORT_SYMBOL_GPL(clk_hw_unregister_fixed_rate);
 
 #ifdef CONFIG_OF
-static struct clk *_of_fixed_clk_setup(struct device_node *node)
+static struct clk_hw *_of_fixed_clk_setup(struct device_node *node)
 {
-	struct clk *clk;
+	struct clk_hw *hw;
 	const char *clk_name = node->name;
 	u32 rate;
 	u32 accuracy = 0;
@@ -170,18 +170,18 @@ static struct clk *_of_fixed_clk_setup(struct device_node *node)
 
 	of_property_read_string(node, "clock-output-names", &clk_name);
 
-	clk = clk_register_fixed_rate_with_accuracy(NULL, clk_name, NULL,
+	hw = clk_hw_register_fixed_rate_with_accuracy(NULL, clk_name, NULL,
 						    0, rate, accuracy);
-	if (IS_ERR(clk))
-		return clk;
+	if (IS_ERR(hw))
+		return hw;
 
-	ret = of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	ret = of_clk_add_hw_provider(node, of_clk_hw_simple_get, hw);
 	if (ret) {
-		clk_unregister(clk);
+		clk_hw_unregister_fixed_rate(hw);
 		return ERR_PTR(ret);
 	}
 
-	return clk;
+	return hw;
 }
 
 /**
@@ -195,27 +195,27 @@ CLK_OF_DECLARE(fixed_clk, "fixed-clock", of_fixed_clk_setup);
 
 static int of_fixed_clk_remove(struct platform_device *pdev)
 {
-	struct clk *clk = platform_get_drvdata(pdev);
+	struct clk_hw *hw = platform_get_drvdata(pdev);
 
 	of_clk_del_provider(pdev->dev.of_node);
-	clk_unregister_fixed_rate(clk);
+	clk_hw_unregister_fixed_rate(hw);
 
 	return 0;
 }
 
 static int of_fixed_clk_probe(struct platform_device *pdev)
 {
-	struct clk *clk;
+	struct clk_hw *hw;
 
 	/*
 	 * This function is not executed when of_fixed_clk_setup
 	 * succeeded.
 	 */
-	clk = _of_fixed_clk_setup(pdev->dev.of_node);
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
+	hw = _of_fixed_clk_setup(pdev->dev.of_node);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
 
-	platform_set_drvdata(pdev, clk);
+	platform_set_drvdata(pdev, hw);
 
 	return 0;
 }
@@ -224,7 +224,6 @@ static const struct of_device_id of_fixed_clk_ids[] = {
 	{ .compatible = "fixed-clock" },
 	{ }
 };
-MODULE_DEVICE_TABLE(of, of_fixed_clk_ids);
 
 static struct platform_driver of_fixed_clk_driver = {
 	.driver = {
-- 
Sent by a computer through tubes

