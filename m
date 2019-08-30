Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F330EC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B417D23427
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567177776;
	bh=xIhLZ5nQAJ+eSeWsA3OmkjA5SXsmQHdnjxdh2RGML7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I/nhp9iV4XjYdP9LnJZ8dT2gdBzZ2Dip/TUuT36skHuygz20GgaVobzXoX5tPsXF/
	 fxfnN91MGYdR9lYOk3V0NS8/ul4Mv8euuZOr913b8MRQG/fd6f2BkzLlSc5fyzA5//
	 vSKgwXEVN4nZbZ8pyqsCIo70yUYiQeAtmThBbLdU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfH3PJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:09:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728247AbfH3PJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:09:30 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1936823429;
        Fri, 30 Aug 2019 15:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567177768;
        bh=xIhLZ5nQAJ+eSeWsA3OmkjA5SXsmQHdnjxdh2RGML7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OtZLu7qaPx+EwM2gwRVjpwQjD49FHn/UzbEhMD766q53R7KqhcEYXT1glEhSScCxO
         Du+TtUrzcCkzxJut/QF1Kgh8DKfxcYLElcUEAi2RGJqC+vvOJPWOJHULNyLswiFPr3
         KmqQCdbtM2RFmEuCGJ8lW5dFhvS9mRAImfdGvOfc=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 12/12] clk: divider: Add support for specifying parents via DT/pointers
Date:   Fri, 30 Aug 2019 08:09:23 -0700
Message-Id: <20190830150923.259497-13-sboyd@kernel.org>
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
encode the multitude of ways of registering a divider clk with different
parent information. Then add a bunch of wrapper macros that only pass
down what needs to be passed down to the generic function to support
this with less arguments.

Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk-divider.c    |  84 ++-----------------
 include/linux/clk-provider.h | 153 ++++++++++++++++++++++++++++++++---
 2 files changed, 147 insertions(+), 90 deletions(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index 3f9ff78c4a2a..b2ecf7ebdbe4 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -463,8 +463,9 @@ const struct clk_ops clk_divider_ro_ops = {
 };
 EXPORT_SYMBOL_GPL(clk_divider_ro_ops);
 
-static struct clk_hw *_register_divider(struct device *dev, const char *name,
-		const char *parent_name, unsigned long flags,
+struct clk_hw *__clk_hw_register_divider(struct device *dev, struct device_node *np,
+		const char *name, const char *parent_name, const struct clk_hw *parent_hw,
+		const struct clk_parent_data *parent_data, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
 		u8 clk_divider_flags, const struct clk_div_table *table,
 		spinlock_t *lock)
@@ -515,55 +516,6 @@ static struct clk_hw *_register_divider(struct device *dev, const char *name,
 	return hw;
 }
 
-/**
- * clk_register_divider - register a divider clock with the clock framework
- * @dev: device registering this clock
- * @name: name of this clock
- * @parent_name: name of clock's parent
- * @flags: framework-specific flags
- * @reg: register address to adjust divider
- * @shift: number of bits to shift the bitfield
- * @width: width of the bitfield
- * @clk_divider_flags: divider-specific flags for this clock
- * @lock: shared register lock for this clock
- */
-struct clk *clk_register_divider(struct device *dev, const char *name,
-		const char *parent_name, unsigned long flags,
-		void __iomem *reg, u8 shift, u8 width,
-		u8 clk_divider_flags, spinlock_t *lock)
-{
-	struct clk_hw *hw;
-
-	hw =  _register_divider(dev, name, parent_name, flags, reg, shift,
-			width, clk_divider_flags, NULL, lock);
-	if (IS_ERR(hw))
-		return ERR_CAST(hw);
-	return hw->clk;
-}
-EXPORT_SYMBOL_GPL(clk_register_divider);
-
-/**
- * clk_hw_register_divider - register a divider clock with the clock framework
- * @dev: device registering this clock
- * @name: name of this clock
- * @parent_name: name of clock's parent
- * @flags: framework-specific flags
- * @reg: register address to adjust divider
- * @shift: number of bits to shift the bitfield
- * @width: width of the bitfield
- * @clk_divider_flags: divider-specific flags for this clock
- * @lock: shared register lock for this clock
- */
-struct clk_hw *clk_hw_register_divider(struct device *dev, const char *name,
-		const char *parent_name, unsigned long flags,
-		void __iomem *reg, u8 shift, u8 width,
-		u8 clk_divider_flags, spinlock_t *lock)
-{
-	return _register_divider(dev, name, parent_name, flags, reg, shift,
-			width, clk_divider_flags, NULL, lock);
-}
-EXPORT_SYMBOL_GPL(clk_hw_register_divider);
-
 /**
  * clk_register_divider_table - register a table based divider clock with
  * the clock framework
@@ -586,39 +538,15 @@ struct clk *clk_register_divider_table(struct device *dev, const char *name,
 {
 	struct clk_hw *hw;
 
-	hw =  _register_divider(dev, name, parent_name, flags, reg, shift,
-			width, clk_divider_flags, table, lock);
+	hw =  __clk_hw_register_divider(dev, NULL, name, parent_name, NULL,
+			NULL, flags, reg, shift, width, clk_divider_flags,
+			table, lock);
 	if (IS_ERR(hw))
 		return ERR_CAST(hw);
 	return hw->clk;
 }
 EXPORT_SYMBOL_GPL(clk_register_divider_table);
 
-/**
- * clk_hw_register_divider_table - register a table based divider clock with
- * the clock framework
- * @dev: device registering this clock
- * @name: name of this clock
- * @parent_name: name of clock's parent
- * @flags: framework-specific flags
- * @reg: register address to adjust divider
- * @shift: number of bits to shift the bitfield
- * @width: width of the bitfield
- * @clk_divider_flags: divider-specific flags for this clock
- * @table: array of divider/value pairs ending with a div set to 0
- * @lock: shared register lock for this clock
- */
-struct clk_hw *clk_hw_register_divider_table(struct device *dev,
-		const char *name, const char *parent_name, unsigned long flags,
-		void __iomem *reg, u8 shift, u8 width,
-		u8 clk_divider_flags, const struct clk_div_table *table,
-		spinlock_t *lock)
-{
-	return _register_divider(dev, name, parent_name, flags, reg, shift,
-			width, clk_divider_flags, table, lock);
-}
-EXPORT_SYMBOL_GPL(clk_hw_register_divider_table);
-
 void clk_unregister_divider(struct clk *clk)
 {
 	struct clk_divider *div;
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 04576a7a0f37..728b20708ab2 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -625,24 +625,153 @@ int divider_get_val(unsigned long rate, unsigned long parent_rate,
 		const struct clk_div_table *table, u8 width,
 		unsigned long flags);
 
-struct clk *clk_register_divider(struct device *dev, const char *name,
-		const char *parent_name, unsigned long flags,
-		void __iomem *reg, u8 shift, u8 width,
-		u8 clk_divider_flags, spinlock_t *lock);
-struct clk_hw *clk_hw_register_divider(struct device *dev, const char *name,
-		const char *parent_name, unsigned long flags,
-		void __iomem *reg, u8 shift, u8 width,
-		u8 clk_divider_flags, spinlock_t *lock);
-struct clk *clk_register_divider_table(struct device *dev, const char *name,
-		const char *parent_name, unsigned long flags,
+struct clk_hw *__clk_hw_register_divider(struct device *dev, struct device_node *np,
+		const char *name, const char *parent_name, const struct clk_hw *parent_hw,
+		const struct clk_parent_data *parent_data, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
 		u8 clk_divider_flags, const struct clk_div_table *table,
 		spinlock_t *lock);
-struct clk_hw *clk_hw_register_divider_table(struct device *dev,
-		const char *name, const char *parent_name, unsigned long flags,
+struct clk *clk_register_divider_table(struct device *dev, const char *name,
+		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
 		u8 clk_divider_flags, const struct clk_div_table *table,
 		spinlock_t *lock);
+/**
+ * clk_register_divider - register a divider clock with the clock framework
+ * @dev: device registering this clock
+ * @name: name of this clock
+ * @parent_name: name of clock's parent
+ * @flags: framework-specific flags
+ * @reg: register address to adjust divider
+ * @shift: number of bits to shift the bitfield
+ * @width: width of the bitfield
+ * @clk_divider_flags: divider-specific flags for this clock
+ * @lock: shared register lock for this clock
+ */
+#define clk_register_divider(dev, name, parent_name, flags, reg, shift, width, \
+			     clk_divider_flags, lock)			       \
+	clk_register_divider_table((dev), (name), (parent_name), (flags),      \
+				   (reg), (shift), (width),		       \
+				   (clk_divider_flags), NULL, (lock))
+/**
+ * clk_hw_register_divider - register a divider clock with the clock framework
+ * @dev: device registering this clock
+ * @name: name of this clock
+ * @parent_name: name of clock's parent
+ * @flags: framework-specific flags
+ * @reg: register address to adjust divider
+ * @shift: number of bits to shift the bitfield
+ * @width: width of the bitfield
+ * @clk_divider_flags: divider-specific flags for this clock
+ * @lock: shared register lock for this clock
+ */
+#define clk_hw_register_divider(dev, name, parent_name, flags, reg, shift,    \
+			        width, clk_divider_flags, lock)		      \
+	__clk_hw_register_divider((dev), NULL, (name), (parent_name), NULL,   \
+				  NULL, (flags), (reg), (shift), (width),     \
+				  (clk_divider_flags), NULL, (lock))
+/**
+ * clk_hw_register_divider_parent_hw - register a divider clock with the clock
+ * framework
+ * @dev: device registering this clock
+ * @name: name of this clock
+ * @parent_hw: pointer to parent clk
+ * @flags: framework-specific flags
+ * @reg: register address to adjust divider
+ * @shift: number of bits to shift the bitfield
+ * @width: width of the bitfield
+ * @clk_divider_flags: divider-specific flags for this clock
+ * @lock: shared register lock for this clock
+ */
+#define clk_hw_register_divider_parent_hw(dev, name, parent_hw, flags, reg,   \
+					  shift, width, clk_divider_flags,    \
+					  lock)				      \
+	__clk_hw_register_divider((dev), NULL, (name), NULL, (parent_hw),     \
+				  NULL, (flags), (reg), (shift), (width),     \
+				  (clk_divider_flags), NULL, (lock))
+/**
+ * clk_hw_register_divider_parent_data - register a divider clock with the clock
+ * framework
+ * @dev: device registering this clock
+ * @name: name of this clock
+ * @parent_data: parent clk data
+ * @flags: framework-specific flags
+ * @reg: register address to adjust divider
+ * @shift: number of bits to shift the bitfield
+ * @width: width of the bitfield
+ * @clk_divider_flags: divider-specific flags for this clock
+ * @lock: shared register lock for this clock
+ */
+#define clk_hw_register_divider_parent_data(dev, name, parent_data, flags,    \
+					    reg, shift, width,		      \
+					    clk_divider_flags, lock)	      \
+	__clk_hw_register_divider((dev), NULL, (name), NULL, NULL,	      \
+				  (parent_data), (flags), (reg), (shift),     \
+				  (width), (clk_divider_flags), NULL, (lock))
+/**
+ * clk_hw_register_divider_table - register a table based divider clock with
+ * the clock framework
+ * @dev: device registering this clock
+ * @name: name of this clock
+ * @parent_name: name of clock's parent
+ * @flags: framework-specific flags
+ * @reg: register address to adjust divider
+ * @shift: number of bits to shift the bitfield
+ * @width: width of the bitfield
+ * @clk_divider_flags: divider-specific flags for this clock
+ * @table: array of divider/value pairs ending with a div set to 0
+ * @lock: shared register lock for this clock
+ */
+#define clk_hw_register_divider_table(dev, name, parent_name, flags, reg,     \
+				      shift, width, clk_divider_flags, table, \
+				      lock)				      \
+	__clk_hw_register_divider((dev), NULL, (name), (parent_name), NULL,   \
+				  NULL, (flags), (reg), (shift), (width),     \
+				  (clk_divider_flags), (table), (lock))
+/**
+ * clk_hw_register_divider_table_parent_hw - register a table based divider
+ * clock with the clock framework
+ * @dev: device registering this clock
+ * @name: name of this clock
+ * @parent_hw: pointer to parent clk
+ * @flags: framework-specific flags
+ * @reg: register address to adjust divider
+ * @shift: number of bits to shift the bitfield
+ * @width: width of the bitfield
+ * @clk_divider_flags: divider-specific flags for this clock
+ * @table: array of divider/value pairs ending with a div set to 0
+ * @lock: shared register lock for this clock
+ */
+#define clk_hw_register_divider_table_parent_hw(dev, name, parent_hw, flags,  \
+						reg, shift, width,	      \
+						clk_divider_flags, table,     \
+						lock)			      \
+	__clk_hw_register_divider((dev), NULL, (name), NULL, (parent_hw),     \
+				  NULL, (flags), (reg), (shift), (width),     \
+				  (clk_divider_flags), (table), (lock))
+/**
+ * clk_hw_register_divider_table_parent_data - register a table based divider
+ * clock with the clock framework
+ * @dev: device registering this clock
+ * @name: name of this clock
+ * @parent_data: parent clk data
+ * @flags: framework-specific flags
+ * @reg: register address to adjust divider
+ * @shift: number of bits to shift the bitfield
+ * @width: width of the bitfield
+ * @clk_divider_flags: divider-specific flags for this clock
+ * @table: array of divider/value pairs ending with a div set to 0
+ * @lock: shared register lock for this clock
+ */
+#define clk_hw_register_divider_table_parent_data(dev, name, parent_data,     \
+						  flags, reg, shift, width,   \
+						  clk_divider_flags, table,   \
+						  lock)			      \
+	__clk_hw_register_divider((dev), NULL, (name), NULL, NULL,	      \
+				  (parent_data), (flags), (reg), (shift),     \
+				  (width), (clk_divider_flags), (table),      \
+				  (lock))
+
 void clk_unregister_divider(struct clk *clk);
 void clk_hw_unregister_divider(struct clk_hw *hw);
 
-- 
Sent by a computer through tubes

