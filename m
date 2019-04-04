Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0A5C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF7F217D4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554414845;
	bh=TU3kq3JEWEz++kRBNGTe+axsRuD/dRWgXb2HL8JqLuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KpD8Cu4ar49fHWFDDMeB+nFBZmbhi2wNC72qJmZEeHdK0jjMY/BZUQImHKoclZb1k
	 uSsE4YxPIAU/TS1d4KaLqWY5OZ1//UbxRPlIYtBXZTbvoSCDmVYANUsq6WLgwbSdJQ
	 gOVlBX1B+14Abc9SSnBg4gQCch9y6HCPxyj5i034=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbfDDVxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 17:53:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729714AbfDDVxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 17:53:48 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A12BF2184B;
        Thu,  4 Apr 2019 21:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554414826;
        bh=TU3kq3JEWEz++kRBNGTe+axsRuD/dRWgXb2HL8JqLuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=my+dS+DF65zix17tNefCfo7aPo6wBifAqRk6x1PZ0KXhXBV45pCR9LQlndYxrFl0s
         CSoAZMrmf38yHjxwBSvfUyfD8YAgMDuema7B02qNgwISV4W3+///OpVs0pU+dPEowb
         rUVaKu4Kdeko5RqytS1MSUYivxUetlle38a3iuG8=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 3/7] clk: Add of_clk_hw_register() API for early clk drivers
Date:   Thu,  4 Apr 2019 14:53:40 -0700
Message-Id: <20190404215344.6330-4-sboyd@kernel.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190404215344.6330-1-sboyd@kernel.org>
References: <20190404215344.6330-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some circumstances drivers register clks early and don't have access
to a struct device because the device model isn't initialized yet. Add
an API to let drivers register clks associated with a struct device_node
so that these drivers can participate in getting parent clks through DT.

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Jeffrey Hugo <jhugo@codeaurora.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk.c            | 26 +++++++++++++++++++++++---
 include/linux/clk-provider.h |  1 +
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index d27775a73e67..4971e9651ca5 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -45,6 +45,7 @@ struct clk_core {
 	struct clk_hw		*hw;
 	struct module		*owner;
 	struct device		*dev;
+	struct device_node	*of_node;
 	struct clk_core		*parent;
 	const char		**parent_names;
 	struct clk_core		**parents;
@@ -3313,7 +3314,8 @@ struct clk *clk_hw_create_clk(struct device *dev, struct clk_hw *hw,
 	return clk;
 }
 
-static struct clk *__clk_register(struct device *dev, struct clk_hw *hw)
+static struct clk *
+__clk_register(struct device *dev, struct device_node *np, struct clk_hw *hw)
 {
 	int i, ret;
 	struct clk_core *core;
@@ -3339,6 +3341,7 @@ static struct clk *__clk_register(struct device *dev, struct clk_hw *hw)
 	if (dev && pm_runtime_enabled(dev))
 		core->rpm_enabled = true;
 	core->dev = dev;
+	core->of_node = np;
 	if (dev && dev->driver)
 		core->owner = dev->driver->owner;
 	core->hw = hw;
@@ -3429,7 +3432,7 @@ static struct clk *__clk_register(struct device *dev, struct clk_hw *hw)
  */
 struct clk *clk_register(struct device *dev, struct clk_hw *hw)
 {
-	return __clk_register(dev, hw);
+	return __clk_register(dev, dev->of_node, hw);
 }
 EXPORT_SYMBOL_GPL(clk_register);
 
@@ -3445,10 +3448,27 @@ EXPORT_SYMBOL_GPL(clk_register);
  */
 int clk_hw_register(struct device *dev, struct clk_hw *hw)
 {
-	return PTR_ERR_OR_ZERO(__clk_register(dev, hw));
+	return PTR_ERR_OR_ZERO(__clk_register(dev, dev->of_node, hw));
 }
 EXPORT_SYMBOL_GPL(clk_hw_register);
 
+/*
+ * of_clk_hw_register - register a clk_hw and return an error code
+ * @node: device_node of device that is registering this clock
+ * @hw: link to hardware-specific clock data
+ *
+ * of_clk_hw_register() is the primary interface for populating the clock tree
+ * with new clock nodes when a struct device is not available, but a struct
+ * device_node is. It returns an integer equal to zero indicating success or
+ * less than zero indicating failure. Drivers must test for an error code after
+ * calling of_clk_hw_register().
+ */
+int of_clk_hw_register(struct device_node *node, struct clk_hw *hw)
+{
+	return PTR_ERR_OR_ZERO(__clk_register(NULL, node, hw));
+}
+EXPORT_SYMBOL_GPL(of_clk_hw_register);
+
 /* Free memory allocated for a clock. */
 static void __clk_release(struct kref *ref)
 {
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index b7cf80a71293..7d2d97e15b76 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -773,6 +773,7 @@ struct clk *devm_clk_register(struct device *dev, struct clk_hw *hw);
 
 int __must_check clk_hw_register(struct device *dev, struct clk_hw *hw);
 int __must_check devm_clk_hw_register(struct device *dev, struct clk_hw *hw);
+int __must_check of_clk_hw_register(struct device_node *node, struct clk_hw *hw);
 
 void clk_unregister(struct clk *clk);
 void devm_clk_unregister(struct device *dev, struct clk *clk);
-- 
Sent by a computer through tubes

