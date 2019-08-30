Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB5BC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F0523407
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567177822;
	bh=4BB1cEzmD70L5AVjNRNBKOyKeVd7z2yXcehOc9fpF1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pK3g00JSO+uLcP8dzU4AKB6cxOsoD637D7CtgcY6A2bQy0Dv1SQl4iAGNtSAfMgzy
	 ElTmpKj4djp7OF0EYvgiTmLITJZjnOywK2PrH+W3Fe3+egRQ/Y4//PvYjORkxKwjhz
	 rvfR68Eaua5oPMHAsC/p8Qq6IbOtwQwgMSh3Z+Ac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbfH3PKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:10:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:42520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727904AbfH3PJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:09:25 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DA8F23427;
        Fri, 30 Aug 2019 15:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567177764;
        bh=4BB1cEzmD70L5AVjNRNBKOyKeVd7z2yXcehOc9fpF1Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=URGU++uURIftcLkIaUd3c+cMbk5jnsPFKW2EDPzQneDYoUV0YOwPLJ9k+p1yoW7sH
         IJqoG74BLsLq0yNlBH30IeODK4YbpcN3SxH6otcXZNSppypZ6eJ/zxWDUnN89TFnaj
         AmkVR41gsquN+4vgFTw3az/iZhT9BB8kGDkxqAdY=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Tony Lindgren <tony@atomide.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 01/12] clk: gpio: Use DT way of specifying parents
Date:   Fri, 30 Aug 2019 08:09:12 -0700
Message-Id: <20190830150923.259497-2-sboyd@kernel.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190830150923.259497-1-sboyd@kernel.org>
References: <20190830150923.259497-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nobody has used the gpio clk registration functions nor the gpio clk_ops
exposed by the basic gpio clk type. Let's remove all those APIs and move
the gpio clk support into the C file. Since nothing is using the
exported APIs, simplify the driver to be a platform driver that uses
clk_parent_data to pick 0th or 1st cell of the node's clocks property.

Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk-gpio.c       | 171 ++++++++++++-----------------------
 include/linux/clk-provider.h |  38 --------
 2 files changed, 58 insertions(+), 151 deletions(-)

diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
index 9d930edd6516..4da9cf78d28e 100644
--- a/drivers/clk/clk-gpio.c
+++ b/drivers/clk/clk-gpio.c
@@ -28,6 +28,26 @@
  * parent - fixed parent.  No clk_set_parent support
  */
 
+/**
+ * struct clk_gpio - gpio gated clock
+ *
+ * @hw:		handle between common and hardware-specific interfaces
+ * @gpiod:	gpio descriptor
+ *
+ * Clock with a gpio control for enabling and disabling the parent clock
+ * or switching between two parents by asserting or deasserting the gpio.
+ *
+ * Implements .enable, .disable and .is_enabled or
+ * .get_parent, .set_parent and .determine_rate depending on which clk_ops
+ * is used.
+ */
+struct clk_gpio {
+	struct clk_hw	hw;
+	struct gpio_desc *gpiod;
+};
+
+#define to_clk_gpio(_hw) container_of(_hw, struct clk_gpio, hw)
+
 static int clk_gpio_gate_enable(struct clk_hw *hw)
 {
 	struct clk_gpio *clk = to_clk_gpio(hw);
@@ -51,12 +71,11 @@ static int clk_gpio_gate_is_enabled(struct clk_hw *hw)
 	return gpiod_get_value(clk->gpiod);
 }
 
-const struct clk_ops clk_gpio_gate_ops = {
+static const struct clk_ops clk_gpio_gate_ops = {
 	.enable = clk_gpio_gate_enable,
 	.disable = clk_gpio_gate_disable,
 	.is_enabled = clk_gpio_gate_is_enabled,
 };
-EXPORT_SYMBOL_GPL(clk_gpio_gate_ops);
 
 static int clk_sleeping_gpio_gate_prepare(struct clk_hw *hw)
 {
@@ -111,67 +130,48 @@ static int clk_gpio_mux_set_parent(struct clk_hw *hw, u8 index)
 	return 0;
 }
 
-const struct clk_ops clk_gpio_mux_ops = {
+static const struct clk_ops clk_gpio_mux_ops = {
 	.get_parent = clk_gpio_mux_get_parent,
 	.set_parent = clk_gpio_mux_set_parent,
 	.determine_rate = __clk_mux_determine_rate,
 };
-EXPORT_SYMBOL_GPL(clk_gpio_mux_ops);
 
-static struct clk_hw *clk_register_gpio(struct device *dev, const char *name,
-		const char * const *parent_names, u8 num_parents, struct gpio_desc *gpiod,
-		unsigned long flags, const struct clk_ops *clk_gpio_ops)
+static struct clk_hw *clk_register_gpio(struct device *dev, u8 num_parents,
+					struct gpio_desc *gpiod,
+					const struct clk_ops *clk_gpio_ops)
 {
 	struct clk_gpio *clk_gpio;
 	struct clk_hw *hw;
 	struct clk_init_data init = {};
 	int err;
+	const struct clk_parent_data gpio_parent_data[] = {
+		{ .index = 0 },
+		{ .index = 1 },
+	};
 
-	if (dev)
-		clk_gpio = devm_kzalloc(dev, sizeof(*clk_gpio),	GFP_KERNEL);
-	else
-		clk_gpio = kzalloc(sizeof(*clk_gpio), GFP_KERNEL);
-
+	clk_gpio = devm_kzalloc(dev, sizeof(*clk_gpio),	GFP_KERNEL);
 	if (!clk_gpio)
 		return ERR_PTR(-ENOMEM);
 
-	init.name = name;
+	init.name = dev->of_node->name;
 	init.ops = clk_gpio_ops;
-	init.flags = flags;
-	init.parent_names = parent_names;
+	init.parent_data = gpio_parent_data;
 	init.num_parents = num_parents;
 
 	clk_gpio->gpiod = gpiod;
 	clk_gpio->hw.init = &init;
 
 	hw = &clk_gpio->hw;
-	if (dev)
-		err = devm_clk_hw_register(dev, hw);
-	else
-		err = clk_hw_register(NULL, hw);
-
-	if (!err)
-		return hw;
-
-	if (!dev) {
-		kfree(clk_gpio);
-	}
+	err = devm_clk_hw_register(dev, hw);
+	if (err)
+		return ERR_PTR(err);
 
-	return ERR_PTR(err);
+	return hw;
 }
 
-/**
- * clk_hw_register_gpio_gate - register a gpio clock gate with the clock
- * framework
- * @dev: device that is registering this clock
- * @name: name of this clock
- * @parent_name: name of this clock's parent
- * @gpiod: gpio descriptor to gate this clock
- * @flags: clock flags
- */
-struct clk_hw *clk_hw_register_gpio_gate(struct device *dev, const char *name,
-		const char *parent_name, struct gpio_desc *gpiod,
-		unsigned long flags)
+static struct clk_hw *clk_hw_register_gpio_gate(struct device *dev,
+						int num_parents,
+						struct gpio_desc *gpiod)
 {
 	const struct clk_ops *ops;
 
@@ -180,88 +180,36 @@ struct clk_hw *clk_hw_register_gpio_gate(struct device *dev, const char *name,
 	else
 		ops = &clk_gpio_gate_ops;
 
-	return clk_register_gpio(dev, name,
-			(parent_name ? &parent_name : NULL),
-			(parent_name ? 1 : 0), gpiod, flags, ops);
+	return clk_register_gpio(dev, num_parents, gpiod, ops);
 }
-EXPORT_SYMBOL_GPL(clk_hw_register_gpio_gate);
 
-struct clk *clk_register_gpio_gate(struct device *dev, const char *name,
-		const char *parent_name, struct gpio_desc *gpiod,
-		unsigned long flags)
+static struct clk_hw *clk_hw_register_gpio_mux(struct device *dev,
+					       struct gpio_desc *gpiod)
 {
-	struct clk_hw *hw;
-
-	hw = clk_hw_register_gpio_gate(dev, name, parent_name, gpiod, flags);
-	if (IS_ERR(hw))
-		return ERR_CAST(hw);
-	return hw->clk;
+	return clk_register_gpio(dev, 2, gpiod, &clk_gpio_mux_ops);
 }
-EXPORT_SYMBOL_GPL(clk_register_gpio_gate);
-
-/**
- * clk_hw_register_gpio_mux - register a gpio clock mux with the clock framework
- * @dev: device that is registering this clock
- * @name: name of this clock
- * @parent_names: names of this clock's parents
- * @num_parents: number of parents listed in @parent_names
- * @gpiod: gpio descriptor to gate this clock
- * @flags: clock flags
- */
-struct clk_hw *clk_hw_register_gpio_mux(struct device *dev, const char *name,
-		const char * const *parent_names, u8 num_parents, struct gpio_desc *gpiod,
-		unsigned long flags)
-{
-	if (num_parents != 2) {
-		pr_err("mux-clock %s must have 2 parents\n", name);
-		return ERR_PTR(-EINVAL);
-	}
-
-	return clk_register_gpio(dev, name, parent_names, num_parents,
-			gpiod, flags, &clk_gpio_mux_ops);
-}
-EXPORT_SYMBOL_GPL(clk_hw_register_gpio_mux);
-
-struct clk *clk_register_gpio_mux(struct device *dev, const char *name,
-		const char * const *parent_names, u8 num_parents, struct gpio_desc *gpiod,
-		unsigned long flags)
-{
-	struct clk_hw *hw;
-
-	hw = clk_hw_register_gpio_mux(dev, name, parent_names, num_parents,
-			gpiod, flags);
-	if (IS_ERR(hw))
-		return ERR_CAST(hw);
-	return hw->clk;
-}
-EXPORT_SYMBOL_GPL(clk_register_gpio_mux);
 
 static int gpio_clk_driver_probe(struct platform_device *pdev)
 {
-	struct device_node *node = pdev->dev.of_node;
-	const char **parent_names, *gpio_name;
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
+	const char *gpio_name;
 	unsigned int num_parents;
 	struct gpio_desc *gpiod;
-	struct clk *clk;
+	struct clk_hw *hw;
 	bool is_mux;
 	int ret;
 
+	is_mux = of_device_is_compatible(node, "gpio-mux-clock");
+
 	num_parents = of_clk_get_parent_count(node);
-	if (num_parents) {
-		parent_names = devm_kcalloc(&pdev->dev, num_parents,
-					    sizeof(char *), GFP_KERNEL);
-		if (!parent_names)
-			return -ENOMEM;
-
-		of_clk_parent_fill(node, parent_names, num_parents);
-	} else {
-		parent_names = NULL;
+	if (is_mux && num_parents != 2) {
+		dev_err(dev, "mux-clock must have 2 parents\n");
+		return -EINVAL;
 	}
 
-	is_mux = of_device_is_compatible(node, "gpio-mux-clock");
-
 	gpio_name = is_mux ? "select" : "enable";
-	gpiod = devm_gpiod_get(&pdev->dev, gpio_name, GPIOD_OUT_LOW);
+	gpiod = devm_gpiod_get(dev, gpio_name, GPIOD_OUT_LOW);
 	if (IS_ERR(gpiod)) {
 		ret = PTR_ERR(gpiod);
 		if (ret == -EPROBE_DEFER)
@@ -275,16 +223,13 @@ static int gpio_clk_driver_probe(struct platform_device *pdev)
 	}
 
 	if (is_mux)
-		clk = clk_register_gpio_mux(&pdev->dev, node->name,
-				parent_names, num_parents, gpiod, 0);
+		hw = clk_hw_register_gpio_mux(dev, gpiod);
 	else
-		clk = clk_register_gpio_gate(&pdev->dev, node->name,
-				parent_names ?  parent_names[0] : NULL, gpiod,
-				0);
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
+		hw = clk_hw_register_gpio_gate(dev, num_parents, gpiod);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
 
-	return of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, hw);
 }
 
 static const struct of_device_id gpio_clk_match_table[] = {
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 2ae7604783dd..32beac39e5a3 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -751,44 +751,6 @@ struct clk_hw *clk_hw_register_composite(struct device *dev, const char *name,
 		unsigned long flags);
 void clk_hw_unregister_composite(struct clk_hw *hw);
 
-/**
- * struct clk_gpio - gpio gated clock
- *
- * @hw:		handle between common and hardware-specific interfaces
- * @gpiod:	gpio descriptor
- *
- * Clock with a gpio control for enabling and disabling the parent clock
- * or switching between two parents by asserting or deasserting the gpio.
- *
- * Implements .enable, .disable and .is_enabled or
- * .get_parent, .set_parent and .determine_rate depending on which clk_ops
- * is used.
- */
-struct clk_gpio {
-	struct clk_hw	hw;
-	struct gpio_desc *gpiod;
-};
-
-#define to_clk_gpio(_hw) container_of(_hw, struct clk_gpio, hw)
-
-extern const struct clk_ops clk_gpio_gate_ops;
-struct clk *clk_register_gpio_gate(struct device *dev, const char *name,
-		const char *parent_name, struct gpio_desc *gpiod,
-		unsigned long flags);
-struct clk_hw *clk_hw_register_gpio_gate(struct device *dev, const char *name,
-		const char *parent_name, struct gpio_desc *gpiod,
-		unsigned long flags);
-void clk_hw_unregister_gpio_gate(struct clk_hw *hw);
-
-extern const struct clk_ops clk_gpio_mux_ops;
-struct clk *clk_register_gpio_mux(struct device *dev, const char *name,
-		const char * const *parent_names, u8 num_parents, struct gpio_desc *gpiod,
-		unsigned long flags);
-struct clk_hw *clk_hw_register_gpio_mux(struct device *dev, const char *name,
-		const char * const *parent_names, u8 num_parents, struct gpio_desc *gpiod,
-		unsigned long flags);
-void clk_hw_unregister_gpio_mux(struct clk_hw *hw);
-
 struct clk *clk_register(struct device *dev, struct clk_hw *hw);
 struct clk *devm_clk_register(struct device *dev, struct clk_hw *hw);
 

base-commit: 5f9e832c137075045d15cd6899ab0505cfb2ca4b
-- 
Sent by a computer through tubes

