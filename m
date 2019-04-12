Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCE3C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD43218C3
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555093931;
	bh=HcIechYl/c6FVy1DBpjkLY6E2a4oNKzK9h0x6CXvb6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H9bfyyflkrUU8MykgebDHSt5zEKzF9UbnmpGnmlVZgjj/Ho3uioiflLiFCpfy88kA
	 lOM1xDbGMUgw3Jbxhe0O60Yzvj/Dt0vtYmH6ysodAxqbayRXkZA8gsvw1KvXVzxbbZ
	 TriuFRXu3zj077s2FxoyQogPkUPNAw7Jeq9w9jCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfDLSb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 14:31:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbfDLSb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 14:31:56 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 476EA218FD;
        Fri, 12 Apr 2019 18:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555093915;
        bh=HcIechYl/c6FVy1DBpjkLY6E2a4oNKzK9h0x6CXvb6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I5LVaitt0gaP9Kgq/jQq6EjSMNPxDolCIh2FYdQEkRl1dmXI1sr03GhxZ7hIDuK3a
         63fD2KVZFKqGwVYOx9PUoTcSUR/nAUBhrMegibf8LE1MkFA+ml/bkDu3UiLHMjk1Vy
         N6JbNZ5Di9f2ErAysLQx11oQKlNJazUKrD2p9EZU=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v4 9/9] clk: fixed-factor: Let clk framework find parent
Date:   Fri, 12 Apr 2019 11:31:50 -0700
Message-Id: <20190412183150.102131-10-sboyd@kernel.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190412183150.102131-1-sboyd@kernel.org>
References: <20190412183150.102131-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert this driver to a more modern way of specifying parents now that
we have a way to specify clk parents by DT index. This lets us nicely
avoid a problem where a parent clk name isn't know because the parent
clk hasn't been registered yet.

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Jeffrey Hugo <jhugo@codeaurora.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk-fixed-factor.c | 53 +++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
index 241b3f8c61a9..67cc7e515e42 100644
--- a/drivers/clk/clk-fixed-factor.c
+++ b/drivers/clk/clk-fixed-factor.c
@@ -64,12 +64,14 @@ const struct clk_ops clk_fixed_factor_ops = {
 };
 EXPORT_SYMBOL_GPL(clk_fixed_factor_ops);
 
-struct clk_hw *clk_hw_register_fixed_factor(struct device *dev,
-		const char *name, const char *parent_name, unsigned long flags,
-		unsigned int mult, unsigned int div)
+static struct clk_hw *
+__clk_hw_register_fixed_factor(struct device *dev, struct device_node *np,
+		const char *name, const char *parent_name, int index,
+		unsigned long flags, unsigned int mult, unsigned int div)
 {
 	struct clk_fixed_factor *fix;
 	struct clk_init_data init;
+	struct clk_parent_data pdata = { .index = index };
 	struct clk_hw *hw;
 	int ret;
 
@@ -85,11 +87,17 @@ struct clk_hw *clk_hw_register_fixed_factor(struct device *dev,
 	init.name = name;
 	init.ops = &clk_fixed_factor_ops;
 	init.flags = flags | CLK_IS_BASIC;
-	init.parent_names = &parent_name;
+	if (parent_name)
+		init.parent_names = &parent_name;
+	else
+		init.parent_data = &pdata;
 	init.num_parents = 1;
 
 	hw = &fix->hw;
-	ret = clk_hw_register(dev, hw);
+	if (dev)
+		ret = clk_hw_register(dev, hw);
+	else
+		ret = of_clk_hw_register(np, hw);
 	if (ret) {
 		kfree(fix);
 		hw = ERR_PTR(ret);
@@ -97,6 +105,14 @@ struct clk_hw *clk_hw_register_fixed_factor(struct device *dev,
 
 	return hw;
 }
+
+struct clk_hw *clk_hw_register_fixed_factor(struct device *dev,
+		const char *name, const char *parent_name, unsigned long flags,
+		unsigned int mult, unsigned int div)
+{
+	return __clk_hw_register_fixed_factor(dev, NULL, name, parent_name, -1, flags,
+					      mult, div);
+}
 EXPORT_SYMBOL_GPL(clk_hw_register_fixed_factor);
 
 struct clk *clk_register_fixed_factor(struct device *dev, const char *name,
@@ -143,11 +159,10 @@ static const struct of_device_id set_rate_parent_matches[] = {
 	{ /* Sentinel */ },
 };
 
-static struct clk *_of_fixed_factor_clk_setup(struct device_node *node)
+static struct clk_hw *_of_fixed_factor_clk_setup(struct device_node *node)
 {
-	struct clk *clk;
+	struct clk_hw *hw;
 	const char *clk_name = node->name;
-	const char *parent_name;
 	unsigned long flags = 0;
 	u32 div, mult;
 	int ret;
@@ -165,30 +180,28 @@ static struct clk *_of_fixed_factor_clk_setup(struct device_node *node)
 	}
 
 	of_property_read_string(node, "clock-output-names", &clk_name);
-	parent_name = of_clk_get_parent_name(node, 0);
 
 	if (of_match_node(set_rate_parent_matches, node))
 		flags |= CLK_SET_RATE_PARENT;
 
-	clk = clk_register_fixed_factor(NULL, clk_name, parent_name, flags,
-					mult, div);
-	if (IS_ERR(clk)) {
+	hw = __clk_hw_register_fixed_factor(NULL, node, clk_name, NULL, 0,
+					    flags, mult, div);
+	if (IS_ERR(hw)) {
 		/*
-		 * If parent clock is not registered, registration would fail.
 		 * Clear OF_POPULATED flag so that clock registration can be
 		 * attempted again from probe function.
 		 */
 		of_node_clear_flag(node, OF_POPULATED);
-		return clk;
+		return ERR_CAST(hw);
 	}
 
-	ret = of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	ret = of_clk_add_hw_provider(node, of_clk_hw_simple_get, hw);
 	if (ret) {
-		clk_unregister(clk);
+		clk_hw_unregister_fixed_factor(hw);
 		return ERR_PTR(ret);
 	}
 
-	return clk;
+	return hw;
 }
 
 /**
@@ -203,17 +216,17 @@ CLK_OF_DECLARE(fixed_factor_clk, "fixed-factor-clock",
 
 static int of_fixed_factor_clk_remove(struct platform_device *pdev)
 {
-	struct clk *clk = platform_get_drvdata(pdev);
+	struct clk_hw *clk = platform_get_drvdata(pdev);
 
 	of_clk_del_provider(pdev->dev.of_node);
-	clk_unregister_fixed_factor(clk);
+	clk_hw_unregister_fixed_factor(clk);
 
 	return 0;
 }
 
 static int of_fixed_factor_clk_probe(struct platform_device *pdev)
 {
-	struct clk *clk;
+	struct clk_hw *clk;
 
 	/*
 	 * This function is not executed when of_fixed_factor_clk_setup
-- 
Sent by a computer through tubes

