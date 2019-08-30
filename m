Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBC9C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9388F23427
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567177787;
	bh=MJlkPCYkMD+Y4plwpCnKgMza3JHPd1xCzxfWRQinRPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BfcRI8ZUHPbTG6WksLuB8AsOLEsPJro0xHIrz1dPcRDOm5jTowq6ER0NKZI4ByS9j
	 k7dPY3NJb/i3VNATrvTSj+RCGqnwDa/vECdxcmqOX/iLZB81gvTuDLz+e8Gu8+8tRX
	 JSP9th/X89R9inonVnFvBa/0dY4Aro4S+uuboe34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbfH3PJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:09:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:42540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728236AbfH3PJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:09:29 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1B622342C;
        Fri, 30 Aug 2019 15:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567177767;
        bh=MJlkPCYkMD+Y4plwpCnKgMza3JHPd1xCzxfWRQinRPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A3eaj/gfSXqT12nTZlrstVUXIce3wQVBSETDlIcLybRHyum1IS0MDZytDZzrmdGap
         ygOu1zJMWe26WMuwznYqEpAY9a9qNRxyD6n29sLtduHMhNu1IlEcxXgoha27ZqZziG
         xVwIs+TyMxvMjyEU0NiQ9Ac50T+Ihxw4mtm3bs+Q=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 11/12] clk: gate: Add support for specifying parents via DT/pointers
Date:   Fri, 30 Aug 2019 08:09:22 -0700
Message-Id: <20190830150923.259497-12-sboyd@kernel.org>
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
encode the multitude of ways of registering a gate clk with different
parent information. Then add a bunch of wrapper macros that only pass
down what needs to be passed down to the generic function to support
this with less arguments.

Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---

I'm debating having the multiplexer function take a DT index, clk_hw
pointer, fw_name and name as different parameters. Then we can just
always use the parent_data approach and cover all bases.

 drivers/clk/clk-gate.c       | 35 ++++++++++-----------
 include/linux/clk-provider.h | 59 ++++++++++++++++++++++++++++++++++--
 2 files changed, 74 insertions(+), 20 deletions(-)

diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
index 1b99fc962745..4296bb012abf 100644
--- a/drivers/clk/clk-gate.c
+++ b/drivers/clk/clk-gate.c
@@ -123,26 +123,18 @@ const struct clk_ops clk_gate_ops = {
 };
 EXPORT_SYMBOL_GPL(clk_gate_ops);
 
-/**
- * clk_hw_register_gate - register a gate clock with the clock framework
- * @dev: device that is registering this clock
- * @name: name of this clock
- * @parent_name: name of this clock's parent
- * @flags: framework-specific flags for this clock
- * @reg: register address to control gating of this clock
- * @bit_idx: which bit in the register controls gating of this clock
- * @clk_gate_flags: gate-specific flags for this clock
- * @lock: shared register lock for this clock
- */
-struct clk_hw *clk_hw_register_gate(struct device *dev, const char *name,
-		const char *parent_name, unsigned long flags,
+struct clk_hw *__clk_hw_register_gate(struct device *dev,
+		struct device_node *np, const char *name,
+		const char *parent_name, const struct clk_hw *parent_hw,
+		const struct clk_parent_data *parent_data,
+		unsigned long flags,
 		void __iomem *reg, u8 bit_idx,
 		u8 clk_gate_flags, spinlock_t *lock)
 {
 	struct clk_gate *gate;
 	struct clk_hw *hw;
 	struct clk_init_data init;
-	int ret;
+	int ret = -EINVAL;
 
 	if (clk_gate_flags & CLK_GATE_HIWORD_MASK) {
 		if (bit_idx > 15) {
@@ -160,7 +152,12 @@ struct clk_hw *clk_hw_register_gate(struct device *dev, const char *name,
 	init.ops = &clk_gate_ops;
 	init.flags = flags;
 	init.parent_names = parent_name ? &parent_name : NULL;
-	init.num_parents = parent_name ? 1 : 0;
+	init.parent_hws = parent_hw ? &parent_hw : NULL;
+	init.parent_data = parent_data;
+	if (parent_name || parent_hw || parent_data)
+		init.num_parents = 1;
+	else
+		init.num_parents = 0;
 
 	/* struct clk_gate assignments */
 	gate->reg = reg;
@@ -170,15 +167,19 @@ struct clk_hw *clk_hw_register_gate(struct device *dev, const char *name,
 	gate->hw.init = &init;
 
 	hw = &gate->hw;
-	ret = clk_hw_register(dev, hw);
+	if (dev || !np)
+		ret = clk_hw_register(dev, hw);
+	else if (np)
+		ret = of_clk_hw_register(np, hw);
 	if (ret) {
 		kfree(gate);
 		hw = ERR_PTR(ret);
 	}
 
 	return hw;
+
 }
-EXPORT_SYMBOL_GPL(clk_hw_register_gate);
+EXPORT_SYMBOL_GPL(__clk_hw_register_gate);
 
 struct clk *clk_register_gate(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 47dd0efce416..04576a7a0f37 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -475,14 +475,67 @@ struct clk_gate {
 #define CLK_GATE_BIG_ENDIAN		BIT(2)
 
 extern const struct clk_ops clk_gate_ops;
-struct clk *clk_register_gate(struct device *dev, const char *name,
-		const char *parent_name, unsigned long flags,
+struct clk_hw *__clk_hw_register_gate(struct device *dev,
+		struct device_node *np, const char *name,
+		const char *parent_name, const struct clk_hw *parent_hw,
+		const struct clk_parent_data *parent_data,
+		unsigned long flags,
 		void __iomem *reg, u8 bit_idx,
 		u8 clk_gate_flags, spinlock_t *lock);
-struct clk_hw *clk_hw_register_gate(struct device *dev, const char *name,
+struct clk *clk_register_gate(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 bit_idx,
 		u8 clk_gate_flags, spinlock_t *lock);
+/**
+ * clk_hw_register_gate - register a gate clock with the clock framework
+ * @dev: device that is registering this clock
+ * @name: name of this clock
+ * @parent_name: name of this clock's parent
+ * @flags: framework-specific flags for this clock
+ * @reg: register address to control gating of this clock
+ * @bit_idx: which bit in the register controls gating of this clock
+ * @clk_gate_flags: gate-specific flags for this clock
+ * @lock: shared register lock for this clock
+ */
+#define clk_hw_register_gate(dev, name, parent_name, flags, reg, bit_idx,     \
+			     clk_gate_flags, lock)			      \
+	__clk_hw_register_gate((dev), NULL, (name), (parent_name), NULL,      \
+			       NULL, (flags), (reg), (bit_idx),		      \
+			       (clk_gate_flags), (lock))
+/**
+ * clk_hw_register_gate_parent_hw - register a gate clock with the clock
+ * framework
+ * @dev: device that is registering this clock
+ * @name: name of this clock
+ * @parent_hw: pointer to parent clk
+ * @flags: framework-specific flags for this clock
+ * @reg: register address to control gating of this clock
+ * @bit_idx: which bit in the register controls gating of this clock
+ * @clk_gate_flags: gate-specific flags for this clock
+ * @lock: shared register lock for this clock
+ */
+#define clk_hw_register_gate_parent_hw(dev, name, parent_name, flags, reg,    \
+				       bit_idx, clk_gate_flags, lock)	      \
+	__clk_hw_register_gate((dev), NULL, (name), (parent_name), NULL,      \
+			       NULL, (flags), (reg), (bit_idx),		      \
+			       (clk_gate_flags), (lock))
+/**
+ * clk_hw_register_gate_parent_data - register a gate clock with the clock
+ * framework
+ * @dev: device that is registering this clock
+ * @name: name of this clock
+ * @parent_data: parent clk data
+ * @flags: framework-specific flags for this clock
+ * @reg: register address to control gating of this clock
+ * @bit_idx: which bit in the register controls gating of this clock
+ * @clk_gate_flags: gate-specific flags for this clock
+ * @lock: shared register lock for this clock
+ */
+#define clk_hw_register_gate_parent_data(dev, name, parent_name, flags, reg,  \
+				       bit_idx, clk_gate_flags, lock)	      \
+	__clk_hw_register_gate((dev), NULL, (name), (parent_name), NULL,      \
+			       NULL, (flags), (reg), (bit_idx),		      \
+			       (clk_gate_flags), (lock))
 void clk_unregister_gate(struct clk *clk);
 void clk_hw_unregister_gate(struct clk_hw *hw);
 int clk_gate_is_enabled(struct clk_hw *hw);
-- 
Sent by a computer through tubes

