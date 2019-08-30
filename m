Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC3DC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 074052341B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567177802;
	bh=gPc/gXXvhkdZcNdV/tpp9QV+Fne66INUUXutvz1cy2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FlqsiPdt5HyuXeKmLPflxX182n5DWWEWk5ehzS0jxY0UPX6/lUqFjUMDv8ufq6qsP
	 WrzQCYIRf7w5yV0i6vObBXur8FdPmpfH1CbsNsf+QAidWpr2svLtma6TBW1scv9RYe
	 Et98Vou/n5s4vd9E6V/LkS5WNq2v3JJb2sHANLqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbfH3PKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:10:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:42540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728188AbfH3PJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:09:27 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AA702342C;
        Fri, 30 Aug 2019 15:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567177766;
        bh=gPc/gXXvhkdZcNdV/tpp9QV+Fne66INUUXutvz1cy2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ONOdy23tLZpS9OyFB2D2XfUl7Bf9ZWa3+XpyBs/9sgMsj0llEbKpbQzfuQBBCql3N
         PwN4s97KGWaebvRx8tnafTp2HcErHaWfmiXwHpreinvqWVoLqguoDBrlU2CO9T1qm7
         8zBNa76eE0/7yzhsLhbERXeyD3HQKm+WG6zI4oYk=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 06/12] clk: fixed-rate: Add support for specifying parents via DT/pointers
Date:   Fri, 30 Aug 2019 08:09:17 -0700
Message-Id: <20190830150923.259497-7-sboyd@kernel.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190830150923.259497-1-sboyd@kernel.org>
References: <20190830150923.259497-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit fc0c209c147f ("clk: Allow parents to be specified without
string names") we can use DT or direct clk_hw pointers to specify
parents. Create a generic function that shouldn't be used very often to
encode the multitude of ways of registering a fixed rate clk with
different parent information. Then add a bunch of wrapper macros that
only pass down what needs to be passed down to the generic function to
support this with less arguments.

Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk-fixed-rate.c |  56 +++++++-------------
 include/linux/clk-provider.h | 100 ++++++++++++++++++++++++++++++++---
 2 files changed, 114 insertions(+), 42 deletions(-)

diff --git a/drivers/clk/clk-fixed-rate.c b/drivers/clk/clk-fixed-rate.c
index ba626661535b..6ee25e2dae76 100644
--- a/drivers/clk/clk-fixed-rate.c
+++ b/drivers/clk/clk-fixed-rate.c
@@ -44,24 +44,17 @@ const struct clk_ops clk_fixed_rate_ops = {
 };
 EXPORT_SYMBOL_GPL(clk_fixed_rate_ops);
 
-/**
- * clk_hw_register_fixed_rate_with_accuracy - register fixed-rate clock with
- * the clock framework
- * @dev: device that is registering this clock
- * @name: name of this clock
- * @parent_name: name of clock's parent
- * @flags: framework-specific flags
- * @fixed_rate: non-adjustable clock rate
- * @fixed_accuracy: non-adjustable clock rate
- */
-struct clk_hw *clk_hw_register_fixed_rate_with_accuracy(struct device *dev,
-		const char *name, const char *parent_name, unsigned long flags,
-		unsigned long fixed_rate, unsigned long fixed_accuracy)
+struct clk_hw *__clk_hw_register_fixed_rate(struct device *dev,
+		struct device_node *np, const char *name,
+		const char *parent_name, const struct clk_hw *parent_hw,
+		const struct clk_parent_data *parent_data, unsigned long flags,
+		unsigned long fixed_rate, unsigned long fixed_accuracy,
+		unsigned long clk_fixed_flags)
 {
 	struct clk_fixed_rate *fixed;
 	struct clk_hw *hw;
 	struct clk_init_data init;
-	int ret;
+	int ret = -EINVAL;
 
 	/* allocate fixed-rate clock */
 	fixed = kzalloc(sizeof(*fixed), GFP_KERNEL);
@@ -71,17 +64,26 @@ struct clk_hw *clk_hw_register_fixed_rate_with_accuracy(struct device *dev,
 	init.name = name;
 	init.ops = &clk_fixed_rate_ops;
 	init.flags = flags;
-	init.parent_names = (parent_name ? &parent_name: NULL);
-	init.num_parents = (parent_name ? 1 : 0);
+	init.parent_names = parent_name ? &parent_name : NULL;
+	init.parent_hws = parent_hw ? &parent_hw : NULL;
+	init.parent_data = parent_data;
+	if (parent_name || parent_hw || parent_data)
+		init.num_parents = 1;
+	else
+		init.num_parents = 0;
 
 	/* struct clk_fixed_rate assignments */
+	fixed->flags = clk_fixed_flags;
 	fixed->fixed_rate = fixed_rate;
 	fixed->fixed_accuracy = fixed_accuracy;
 	fixed->hw.init = &init;
 
 	/* register the clock */
 	hw = &fixed->hw;
-	ret = clk_hw_register(dev, hw);
+	if (dev || !np)
+		ret = clk_hw_register(dev, hw);
+	else if (np)
+		ret = of_clk_hw_register(np, hw);
 	if (ret) {
 		kfree(fixed);
 		hw = ERR_PTR(ret);
@@ -89,25 +91,7 @@ struct clk_hw *clk_hw_register_fixed_rate_with_accuracy(struct device *dev,
 
 	return hw;
 }
-EXPORT_SYMBOL_GPL(clk_hw_register_fixed_rate_with_accuracy);
-
-/**
- * clk_hw_register_fixed_rate - register fixed-rate clock with the clock
- * framework
- * @dev: device that is registering this clock
- * @name: name of this clock
- * @parent_name: name of clock's parent
- * @flags: framework-specific flags
- * @fixed_rate: non-adjustable clock rate
- */
-struct clk_hw *clk_hw_register_fixed_rate(struct device *dev, const char *name,
-		const char *parent_name, unsigned long flags,
-		unsigned long fixed_rate)
-{
-	return clk_hw_register_fixed_rate_with_accuracy(dev, name, parent_name,
-						     flags, fixed_rate, 0);
-}
-EXPORT_SYMBOL_GPL(clk_hw_register_fixed_rate);
+EXPORT_SYMBOL_GPL(__clk_hw_register_fixed_rate);
 
 struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 473e9d85bac0..9acafd9de216 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -321,24 +321,112 @@ struct clk_hw {
  * @hw:		handle between common and hardware-specific interfaces
  * @fixed_rate:	constant frequency of clock
  * @fixed_accuracy: constant accuracy of clock in ppb (parts per billion)
+ * @flags:	hardware specific flags
  */
 struct clk_fixed_rate {
 	struct		clk_hw hw;
 	unsigned long	fixed_rate;
 	unsigned long	fixed_accuracy;
+	unsigned long	flags;
 };
 
 extern const struct clk_ops clk_fixed_rate_ops;
+struct clk_hw *__clk_hw_register_fixed_rate(struct device *dev,
+		struct device_node *np, const char *name,
+		const char *parent_name, const struct clk_hw *parent_hw,
+		const struct clk_parent_data *parent_data, unsigned long flags,
+		unsigned long fixed_rate, unsigned long fixed_accuracy,
+		unsigned long clk_fixed_flags);
 struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		unsigned long fixed_rate);
-struct clk_hw *clk_hw_register_fixed_rate(struct device *dev, const char *name,
-		const char *parent_name, unsigned long flags,
-		unsigned long fixed_rate);
+/**
+ * clk_hw_register_fixed_rate - register fixed-rate clock with the clock
+ * framework
+ * @dev: device that is registering this clock
+ * @name: name of this clock
+ * @parent_name: name of clock's parent
+ * @flags: framework-specific flags
+ * @fixed_rate: non-adjustable clock rate
+ */
+#define clk_hw_register_fixed_rate(dev, name, parent_name, flags, fixed_rate)  \
+	__clk_hw_register_fixed_rate((dev), NULL, (name), (parent_name), NULL, \
+				     NULL, (flags), (fixed_rate), 0, 0)
+/**
+ * clk_hw_register_fixed_rate_parent_hw - register fixed-rate clock with
+ * the clock framework
+ * @dev: device that is registering this clock
+ * @name: name of this clock
+ * @parent_hw: pointer to parent clk
+ * @flags: framework-specific flags
+ * @fixed_rate: non-adjustable clock rate
+ */
+#define clk_hw_register_fixed_rate_parent_hw(dev, name, parent_hw, flags,     \
+					     fixed_rate)		      \
+	__clk_hw_register_fixed_rate((dev), NULL, (name), NULL, (parent_hw),  \
+				     NULL, (flags), (fixed_rate), 0, 0)
+/**
+ * clk_hw_register_fixed_rate_parent_data - register fixed-rate clock with
+ * the clock framework
+ * @dev: device that is registering this clock
+ * @name: name of this clock
+ * @parent_data: parent clk data
+ * @flags: framework-specific flags
+ * @fixed_rate: non-adjustable clock rate
+ */
+#define clk_hw_register_fixed_rate_parent_data(dev, name, parent_hw, flags,   \
+					     fixed_rate)		      \
+	__clk_hw_register_fixed_rate((dev), NULL, (name), NULL, NULL,	      \
+				     (parent_data), (flags), (fixed_rate), 0, \
+				     0)
+/**
+ * clk_hw_register_fixed_rate_with_accuracy - register fixed-rate clock with
+ * the clock framework
+ * @dev: device that is registering this clock
+ * @name: name of this clock
+ * @parent_name: name of clock's parent
+ * @flags: framework-specific flags
+ * @fixed_rate: non-adjustable clock rate
+ * @fixed_accuracy: non-adjustable clock rate
+ */
+#define clk_hw_register_fixed_rate_with_accuracy(dev, name, parent_name,      \
+						 flags, fixed_rate,	      \
+						 fixed_accuracy)	      \
+	__clk_hw_register_fixed_rate((dev), NULL, (name), (parent_name),      \
+				     NULL, NULL, (flags), (fixed_rate),       \
+				     (fixed_accuracy), 0)
+/**
+ * clk_hw_register_fixed_rate_with_accuracy_parent_hw - register fixed-rate
+ * clock with the clock framework
+ * @dev: device that is registering this clock
+ * @name: name of this clock
+ * @parent_hw: pointer to parent clk
+ * @flags: framework-specific flags
+ * @fixed_rate: non-adjustable clock rate
+ * @fixed_accuracy: non-adjustable clock accuracy
+ */
+#define clk_hw_register_fixed_rate_with_accuracy_parent_hw(dev, name,	      \
+		parent_hw, flags, fixed_rate, fixed_accuracy)		      \
+	__clk_hw_register_fixed_rate((dev), NULL, (name), NULL, (parent_hw)   \
+				     NULL, NULL, (flags), (fixed_rate),	      \
+				     (fixed_accuracy), 0)
+/**
+ * clk_hw_register_fixed_rate_with_accuracy_parent_data - register fixed-rate
+ * clock with the clock framework
+ * @dev: device that is registering this clock
+ * @name: name of this clock
+ * @parent_name: name of clock's parent
+ * @flags: framework-specific flags
+ * @fixed_rate: non-adjustable clock rate
+ * @fixed_accuracy: non-adjustable clock accuracy
+ */
+#define clk_hw_register_fixed_rate_with_accuracy_parent_data(dev, name,	      \
+		parent_data, flags, fixed_rate, fixed_accuracy)		      \
+	__clk_hw_register_fixed_rate((dev), NULL, (name), NULL, NULL,	      \
+				     (parent_data), NULL, (flags),	      \
+				     (fixed_rate), (fixed_accuracy), 0)
+
 void clk_unregister_fixed_rate(struct clk *clk);
-struct clk_hw *clk_hw_register_fixed_rate_with_accuracy(struct device *dev,
-		const char *name, const char *parent_name, unsigned long flags,
-		unsigned long fixed_rate, unsigned long fixed_accuracy);
 void clk_hw_unregister_fixed_rate(struct clk_hw *hw);
 
 void of_fixed_clk_setup(struct device_node *np);
-- 
Sent by a computer through tubes

