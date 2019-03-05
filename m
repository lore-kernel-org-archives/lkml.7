Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54286C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 04:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EF6D20842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 04:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TyWBhqOu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfCEEt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 23:49:58 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33084 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbfCEEtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 23:49:50 -0500
Received: by mail-pg1-f194.google.com with SMTP id h11so4739543pgl.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 20:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fdKp4SeZVrnoaz4hVASAatvJw1CO/d/GaAm0ZcmjiNs=;
        b=TyWBhqOuVPF7RvuhHm0oWXuvpDHmFJnTpjkD4KSsMV8nUZwuenvbJOhl5AfzlaaZHa
         +zAfT05y4NgAIpLA+tgpIGLmdiAV2Otior/gxqELFPRe+pMTVuyIbKkmG1BXYgylUvfK
         UVXfjl3qDYRMavsY6I/wr5nDfbuTrkgmgqigg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fdKp4SeZVrnoaz4hVASAatvJw1CO/d/GaAm0ZcmjiNs=;
        b=YYjyqA4kj9aLdqX+F4+2aQeHsTDAaKGCJQnNbFfoKhcHmMQeiVN9Kvji24/iAKXeS6
         Si/PkIGQNA+GUXz3iILpp55YAE4UimpdUD8wqUN55MkivJLmE8lrn/PgcrSni+sZ2uEG
         tqNBfDCC5/TUB+7Cb+wYDjuw6KDpOAhP0eGmHC2IaeQ+QTK7wSYBZCLyTqtWwHjoKKw8
         k/klHnv7uNBmbk6asLVakw67+b8ew7gFLSIng0Zp1mXuOMizdoDIfqnzn+j0XeJt+2WF
         2yKjyS7s/75ZmJxzOmfoapqUXAyhJYopyruDccsF80d7TZxUiCqrQK/3EY+kfnWDByUv
         E+Pw==
X-Gm-Message-State: APjAAAVb0nVLBX7OP3n3WY5UmmJyUCpUPLsvppIo3wZZ3Ml/yn+qU/5e
        qbC1ffgcfphGxzWi9K2SImu/EeykTts=
X-Google-Smtp-Source: APXvYqxjNxmIBibbfXwGEZ3X8HICM6JwOufKt6vgg8CrLI9LwK/8bwv7rPLJ/s3R6stFjeFGkACGdg==
X-Received: by 2002:a62:be0b:: with SMTP id l11mr2393pff.52.1551761389105;
        Mon, 04 Mar 2019 20:49:49 -0800 (PST)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:db8d:8e3f:2514:5db8])
        by smtp.gmail.com with ESMTPSA id z15sm15893883pgc.25.2019.03.04.20.49.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 20:49:48 -0800 (PST)
From:   Derek Basehore <dbasehore@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-doc@vger.kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, heiko@sntech.de,
        aisheng.dong@nxp.com, mchehab+samsung@kernel.org, corbet@lwn.net,
        jbrunet@baylibre.com, Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH v2 6/6] clk: rockchip: use pre_rate_req for cpuclk
Date:   Mon,  4 Mar 2019 20:49:36 -0800
Message-Id: <20190305044936.22267-7-dbasehore@chromium.org>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
In-Reply-To: <20190305044936.22267-1-dbasehore@chromium.org>
References: <20190305044936.22267-1-dbasehore@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes the rockchip cpuclk use the pre_rate_req op to change to
the alt parent instead of the clk notifier. This has the benefit of
the clk not changing parents behind the back of the common clk
framework. It also changes the divider setting for the alt parent to
only divide when the alt parent rate is higher than both the old and
new rates.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 drivers/clk/rockchip/clk-cpu.c | 256 ++++++++++++++++++---------------
 1 file changed, 137 insertions(+), 119 deletions(-)

diff --git a/drivers/clk/rockchip/clk-cpu.c b/drivers/clk/rockchip/clk-cpu.c
index 32c19c0f1e14..3829e8e75c9e 100644
--- a/drivers/clk/rockchip/clk-cpu.c
+++ b/drivers/clk/rockchip/clk-cpu.c
@@ -45,8 +45,6 @@
  * @alt_parent:	alternate parent clock to use when switching the speed
  *		of the primary parent clock.
  * @reg_base:	base register for cpu-clock values.
- * @clk_nb:	clock notifier registered for changes in clock speed of the
- *		primary parent clock.
  * @rate_count:	number of rates in the rate_table
  * @rate_table:	pll-rates and their associated dividers
  * @reg_data:	cpu-specific register settings
@@ -60,7 +58,6 @@ struct rockchip_cpuclk {
 
 	struct clk				*alt_parent;
 	void __iomem				*reg_base;
-	struct notifier_block			clk_nb;
 	unsigned int				rate_count;
 	struct rockchip_cpuclk_rate_table	*rate_table;
 	const struct rockchip_cpuclk_reg_data	*reg_data;
@@ -78,12 +75,21 @@ static const struct rockchip_cpuclk_rate_table *rockchip_get_cpuclk_settings(
 							cpuclk->rate_table;
 	int i;
 
+	/*
+	 * Find the lowest rate settings for which the prate is greater than or
+	 * equal to the rate. Final rates should match exactly, but some
+	 * intermediate rates from pre_rate_req will not exactly match, but the
+	 * settings for a higher prate will work.
+	 */
 	for (i = 0; i < cpuclk->rate_count; i++) {
-		if (rate == rate_table[i].prate)
-			return &rate_table[i];
+		if (rate > rate_table[i].prate)
+			break;
 	}
 
-	return NULL;
+	if (i == 0 || i == cpuclk->rate_count)
+		return NULL;
+
+	return &rate_table[i - 1];
 }
 
 static unsigned long rockchip_cpuclk_recalc_rate(struct clk_hw *hw,
@@ -98,9 +104,70 @@ static unsigned long rockchip_cpuclk_recalc_rate(struct clk_hw *hw,
 	return parent_rate / (clksel0 + 1);
 }
 
-static const struct clk_ops rockchip_cpuclk_ops = {
-	.recalc_rate = rockchip_cpuclk_recalc_rate,
-};
+static int rockchip_cpuclk_pre_rate_req(struct clk_hw *hw,
+					const struct clk_rate_request *next,
+					struct clk_rate_request *pre)
+{
+	struct rockchip_cpuclk *cpuclk = container_of(hw,
+			struct rockchip_cpuclk, hw);
+	const struct rockchip_cpuclk_reg_data *reg_data = cpuclk->reg_data;
+	unsigned long alt_prate, alt_div, hi_rate;
+
+	pre->best_parent_hw = __clk_get_hw(cpuclk->alt_parent);
+	alt_prate = clk_get_rate(cpuclk->alt_parent);
+	pre->best_parent_rate = alt_prate;
+	hi_rate = max_t(unsigned long, next->rate, clk_hw_get_rate(hw));
+
+	/* Set dividers if we would go above the current or next rate. */
+	if (alt_prate > hi_rate) {
+		alt_div =  DIV_ROUND_UP(alt_prate, hi_rate);
+		if (alt_div > reg_data->div_core_mask) {
+			pr_warn("%s: limiting alt-divider %lu to %d\n",
+				__func__, alt_div, reg_data->div_core_mask);
+			alt_div = reg_data->div_core_mask;
+		}
+
+		pre->rate = alt_prate / alt_div;
+	} else {
+		pre->rate = alt_prate;
+	}
+
+	return 1;
+}
+
+static int rockchip_cpuclk_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct rockchip_cpuclk *cpuclk = container_of(hw,
+			struct rockchip_cpuclk, hw);
+	const struct rockchip_cpuclk_reg_data *reg_data = cpuclk->reg_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(cpuclk->lock, flags);
+	writel(HIWORD_UPDATE(index,
+			     reg_data->mux_core_mask,
+			     reg_data->mux_core_shift),
+	       cpuclk->reg_base + reg_data->core_reg);
+	spin_unlock_irqrestore(cpuclk->lock, flags);
+
+	return 0;
+}
+
+static u8 rockchip_cpuclk_get_parent(struct clk_hw *hw)
+{
+	struct rockchip_cpuclk *cpuclk = container_of(hw,
+			struct rockchip_cpuclk, hw);
+	const struct rockchip_cpuclk_reg_data *reg_data = cpuclk->reg_data;
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(cpuclk->lock, flags);
+	val = readl_relaxed(cpuclk->reg_base + reg_data->core_reg);
+	val >>= reg_data->mux_core_shift;
+	val &= reg_data->mux_core_mask;
+	spin_unlock_irqrestore(cpuclk->lock, flags);
+
+	return val;
+}
 
 static void rockchip_cpuclk_set_dividers(struct rockchip_cpuclk *cpuclk,
 				const struct rockchip_cpuclk_rate_table *rate)
@@ -120,131 +187,92 @@ static void rockchip_cpuclk_set_dividers(struct rockchip_cpuclk *cpuclk,
 	}
 }
 
-static int rockchip_cpuclk_pre_rate_change(struct rockchip_cpuclk *cpuclk,
-					   struct clk_notifier_data *ndata)
+static int rockchip_cpuclk_set_rate(struct clk_hw *hw, unsigned long rate,
+					unsigned long parent_rate)
 {
+	struct rockchip_cpuclk *cpuclk = container_of(hw,
+			struct rockchip_cpuclk, hw);
 	const struct rockchip_cpuclk_reg_data *reg_data = cpuclk->reg_data;
-	const struct rockchip_cpuclk_rate_table *rate;
-	unsigned long alt_prate, alt_div;
-	unsigned long flags;
+	const struct rockchip_cpuclk_rate_table *rate_divs;
+	unsigned long div = (parent_rate / rate) - 1;
+	unsigned long old_rate, flags;
 
-	/* check validity of the new rate */
-	rate = rockchip_get_cpuclk_settings(cpuclk, ndata->new_rate);
-	if (!rate) {
-		pr_err("%s: Invalid rate : %lu for cpuclk\n",
-		       __func__, ndata->new_rate);
+	if (div > reg_data->div_core_mask || rate > parent_rate) {
+		pr_err("%s: Invalid rate : %lu %lu for cpuclk\n", __func__,
+				rate, parent_rate);
 		return -EINVAL;
 	}
 
-	alt_prate = clk_get_rate(cpuclk->alt_parent);
-
+	old_rate = clk_hw_get_rate(hw);
+	rate_divs = rockchip_get_cpuclk_settings(cpuclk, rate);
 	spin_lock_irqsave(cpuclk->lock, flags);
+	if (old_rate < rate)
+		rockchip_cpuclk_set_dividers(cpuclk, rate_divs);
 
-	/*
-	 * If the old parent clock speed is less than the clock speed
-	 * of the alternate parent, then it should be ensured that at no point
-	 * the armclk speed is more than the old_rate until the dividers are
-	 * set.
-	 */
-	if (alt_prate > ndata->old_rate) {
-		/* calculate dividers */
-		alt_div =  DIV_ROUND_UP(alt_prate, ndata->old_rate) - 1;
-		if (alt_div > reg_data->div_core_mask) {
-			pr_warn("%s: limiting alt-divider %lu to %d\n",
-				__func__, alt_div, reg_data->div_core_mask);
-			alt_div = reg_data->div_core_mask;
-		}
-
-		/*
-		 * Change parents and add dividers in a single transaction.
-		 *
-		 * NOTE: we do this in a single transaction so we're never
-		 * dividing the primary parent by the extra dividers that were
-		 * needed for the alt.
-		 */
-		pr_debug("%s: setting div %lu as alt-rate %lu > old-rate %lu\n",
-			 __func__, alt_div, alt_prate, ndata->old_rate);
-
-		writel(HIWORD_UPDATE(alt_div, reg_data->div_core_mask,
-					      reg_data->div_core_shift) |
-		       HIWORD_UPDATE(reg_data->mux_core_alt,
-				     reg_data->mux_core_mask,
-				     reg_data->mux_core_shift),
-		       cpuclk->reg_base + reg_data->core_reg);
-	} else {
-		/* select alternate parent */
-		writel(HIWORD_UPDATE(reg_data->mux_core_alt,
-				     reg_data->mux_core_mask,
-				     reg_data->mux_core_shift),
-		       cpuclk->reg_base + reg_data->core_reg);
-	}
+	writel(HIWORD_UPDATE(div,
+			     reg_data->div_core_mask,
+			     reg_data->div_core_shift),
+	       cpuclk->reg_base + reg_data->core_reg);
+	if (old_rate > rate)
+		rockchip_cpuclk_set_dividers(cpuclk, rate_divs);
 
 	spin_unlock_irqrestore(cpuclk->lock, flags);
+
 	return 0;
 }
 
-static int rockchip_cpuclk_post_rate_change(struct rockchip_cpuclk *cpuclk,
-					    struct clk_notifier_data *ndata)
+static int rockchip_cpuclk_set_rate_and_parent(struct clk_hw *hw,
+					unsigned long rate,
+					unsigned long parent_rate,
+					u8 index)
 {
+	struct rockchip_cpuclk *cpuclk = container_of(hw,
+			struct rockchip_cpuclk, hw);
 	const struct rockchip_cpuclk_reg_data *reg_data = cpuclk->reg_data;
-	const struct rockchip_cpuclk_rate_table *rate;
-	unsigned long flags;
+	const struct rockchip_cpuclk_rate_table *rate_divs;
+	unsigned long div = (parent_rate / rate) - 1;
+	unsigned long old_rate, flags;
 
-	rate = rockchip_get_cpuclk_settings(cpuclk, ndata->new_rate);
-	if (!rate) {
-		pr_err("%s: Invalid rate : %lu for cpuclk\n",
-		       __func__, ndata->new_rate);
+	if (div > reg_data->div_core_mask || rate > parent_rate) {
+		pr_err("%s: Invalid rate : %lu %lu for cpuclk\n", __func__,
+				rate, parent_rate);
 		return -EINVAL;
 	}
 
+	old_rate = clk_hw_get_rate(hw);
+	rate_divs = rockchip_get_cpuclk_settings(cpuclk, rate);
 	spin_lock_irqsave(cpuclk->lock, flags);
-
-	if (ndata->old_rate < ndata->new_rate)
-		rockchip_cpuclk_set_dividers(cpuclk, rate);
-
 	/*
-	 * post-rate change event, re-mux to primary parent and remove dividers.
-	 *
-	 * NOTE: we do this in a single transaction so we're never dividing the
-	 * primary parent by the extra dividers that were needed for the alt.
+	 * TODO: This ain't great... Should change the get_cpuclk_settings code
+	 * to work with inexact matches to work with alt parent rates.
 	 */
-
-	writel(HIWORD_UPDATE(0, reg_data->div_core_mask,
-				reg_data->div_core_shift) |
-	       HIWORD_UPDATE(reg_data->mux_core_main,
-				reg_data->mux_core_mask,
-				reg_data->mux_core_shift),
+	if (old_rate < rate)
+		rockchip_cpuclk_set_dividers(cpuclk, rate_divs);
+
+	writel(HIWORD_UPDATE(div,
+			     reg_data->div_core_mask,
+			     reg_data->div_core_shift) |
+	       HIWORD_UPDATE(index,
+			     reg_data->mux_core_mask,
+			     reg_data->mux_core_shift),
 	       cpuclk->reg_base + reg_data->core_reg);
-
-	if (ndata->old_rate > ndata->new_rate)
-		rockchip_cpuclk_set_dividers(cpuclk, rate);
+	/* Not technically correct */
+	if (old_rate > rate)
+		rockchip_cpuclk_set_dividers(cpuclk, rate_divs);
 
 	spin_unlock_irqrestore(cpuclk->lock, flags);
+
 	return 0;
 }
 
-/*
- * This clock notifier is called when the frequency of the parent clock
- * of cpuclk is to be changed. This notifier handles the setting up all
- * the divider clocks, remux to temporary parent and handling the safe
- * frequency levels when using temporary parent.
- */
-static int rockchip_cpuclk_notifier_cb(struct notifier_block *nb,
-					unsigned long event, void *data)
-{
-	struct clk_notifier_data *ndata = data;
-	struct rockchip_cpuclk *cpuclk = to_rockchip_cpuclk_nb(nb);
-	int ret = 0;
-
-	pr_debug("%s: event %lu, old_rate %lu, new_rate: %lu\n",
-		 __func__, event, ndata->old_rate, ndata->new_rate);
-	if (event == PRE_RATE_CHANGE)
-		ret = rockchip_cpuclk_pre_rate_change(cpuclk, ndata);
-	else if (event == POST_RATE_CHANGE)
-		ret = rockchip_cpuclk_post_rate_change(cpuclk, ndata);
-
-	return notifier_from_errno(ret);
-}
+static const struct clk_ops rockchip_cpuclk_ops = {
+	.recalc_rate = rockchip_cpuclk_recalc_rate,
+	.pre_rate_req = rockchip_cpuclk_pre_rate_req,
+	.set_parent = rockchip_cpuclk_set_parent,
+	.get_parent = rockchip_cpuclk_get_parent,
+	.set_rate = rockchip_cpuclk_set_rate,
+	.set_rate_and_parent = rockchip_cpuclk_set_rate_and_parent,
+};
 
 struct clk *rockchip_clk_register_cpuclk(const char *name,
 			const char *const *parent_names, u8 num_parents,
@@ -267,8 +295,8 @@ struct clk *rockchip_clk_register_cpuclk(const char *name,
 		return ERR_PTR(-ENOMEM);
 
 	init.name = name;
-	init.parent_names = &parent_names[reg_data->mux_core_main];
-	init.num_parents = 1;
+	init.parent_names = parent_names;
+	init.num_parents = num_parents;
 	init.ops = &rockchip_cpuclk_ops;
 
 	/* only allow rate changes when we have a rate table */
@@ -282,7 +310,6 @@ struct clk *rockchip_clk_register_cpuclk(const char *name,
 	cpuclk->reg_base = reg_base;
 	cpuclk->lock = lock;
 	cpuclk->reg_data = reg_data;
-	cpuclk->clk_nb.notifier_call = rockchip_cpuclk_notifier_cb;
 	cpuclk->hw.init = &init;
 
 	cpuclk->alt_parent = __clk_lookup(parent_names[reg_data->mux_core_alt]);
@@ -309,13 +336,6 @@ struct clk *rockchip_clk_register_cpuclk(const char *name,
 		goto free_alt_parent;
 	}
 
-	ret = clk_notifier_register(clk, &cpuclk->clk_nb);
-	if (ret) {
-		pr_err("%s: failed to register clock notifier for %s\n",
-				__func__, name);
-		goto free_alt_parent;
-	}
-
 	if (nrates > 0) {
 		cpuclk->rate_count = nrates;
 		cpuclk->rate_table = kmemdup(rates,
@@ -323,7 +343,7 @@ struct clk *rockchip_clk_register_cpuclk(const char *name,
 					     GFP_KERNEL);
 		if (!cpuclk->rate_table) {
 			ret = -ENOMEM;
-			goto unregister_notifier;
+			goto free_alt_parent;
 		}
 	}
 
@@ -338,8 +358,6 @@ struct clk *rockchip_clk_register_cpuclk(const char *name,
 
 free_rate_table:
 	kfree(cpuclk->rate_table);
-unregister_notifier:
-	clk_notifier_unregister(clk, &cpuclk->clk_nb);
 free_alt_parent:
 	clk_disable_unprepare(cpuclk->alt_parent);
 free_cpuclk:
-- 
2.21.0.352.gf09ad66450-goog

