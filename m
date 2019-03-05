Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6217BC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 04:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D44920842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 04:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dhOM8GHe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfCEEuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 23:50:14 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35278 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfCEEts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 23:49:48 -0500
Received: by mail-pg1-f194.google.com with SMTP id e17so4735703pgd.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 20:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LdV83d8MFPa7bfUk4tFoQz+LkmIOaD9tdBFkjZXd4sg=;
        b=dhOM8GHe1gqrDJo8sMP2RTlLIit4R1l+TYkDJSVBG5fyaFeyc3qj1l50Wr1SiA39GO
         dlKdhnCQ8hDYKx9Cl2bSeT2MshjLc2BCH/DxFQ7qfMgyqF/zi9IugTb7kE0XVmogwcRc
         RJWGEZnBHTStbo+brlADzPPtTj9WqjRATVVSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LdV83d8MFPa7bfUk4tFoQz+LkmIOaD9tdBFkjZXd4sg=;
        b=E2lGHVRG0iZHXk2ZHzOrIDumo+IU8d5D+PmkIse//aBoO8OJFkWR9XKOBfoNa92b0w
         ucIAGHo04C9/hzGp6k8rursiiJ9XCz2+6/63Ne/6GDQEMAOYqzYxRXwwnd+1mUZxoJ2J
         NzhvW4C3bREV+BXZQRe4GPIDE8gm1zqv6+wL++NlGr2W2Avzoqqf5rQyFzcmPnwGLsrc
         vFCrZ07YTxHQY4zzfG16sYwNxyI0XHI9luDJUGovwi4VYc5HGxD7sbwpzZmCULLgcmOX
         JVh6bIz9R4edCczpoJSksepE0aU2JhbSV9Zeq8tJWePsjX9bUQJ1iDlCikw+P0WEcMe/
         hjqQ==
X-Gm-Message-State: APjAAAUGXrwmAcLY26/DQcNlbmP+VdqxoZLBAtprh27gZjvHqac+BRZu
        wq9rhtBD5HAeuL3rbgoMzAU8kDAMPCA=
X-Google-Smtp-Source: APXvYqwipCVMjkP6u0eG7qg1X/G88cb0tHBRjm4PZeDnyUybGcAsuQR1ocP0J7prBcqxLf10wYAr4Q==
X-Received: by 2002:a62:64c6:: with SMTP id y189mr24013311pfb.103.1551761386967;
        Mon, 04 Mar 2019 20:49:46 -0800 (PST)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:db8d:8e3f:2514:5db8])
        by smtp.gmail.com with ESMTPSA id z15sm15893883pgc.25.2019.03.04.20.49.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 20:49:46 -0800 (PST)
From:   Derek Basehore <dbasehore@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-doc@vger.kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, heiko@sntech.de,
        aisheng.dong@nxp.com, mchehab+samsung@kernel.org, corbet@lwn.net,
        jbrunet@baylibre.com, Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH v2 4/6] clk: add coordinated clk changes support
Date:   Mon,  4 Mar 2019 20:49:34 -0800
Message-Id: <20190305044936.22267-5-dbasehore@chromium.org>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
In-Reply-To: <20190305044936.22267-1-dbasehore@chromium.org>
References: <20190305044936.22267-1-dbasehore@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a new clk_op, pre_rate_req. It allows clks to setup an
intermediate state when clk rates are changed. One use case for this
is when a clk needs to switch to a safe parent when its PLL ancestor
changes rates. This is needed when a PLL cannot guarantee that it will
not exceed the new rate before it locks. The set_rate, set_parent, and
set_rate_and_parent callbacks are used with the pre_rate_req callback.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 drivers/clk/clk.c            | 207 ++++++++++++++++++++++++++++++++---
 include/linux/clk-provider.h |  10 ++
 2 files changed, 200 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 1637dc262884..b86940ca3c81 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -59,6 +59,7 @@ struct clk_core {
 	unsigned long		rate;
 	unsigned long		req_rate;
 	struct clk_change	change;
+	struct clk_change	pre_change;
 	struct clk_core		*new_child;
 	unsigned long		flags;
 	bool			orphan;
@@ -1920,6 +1921,141 @@ static struct clk_core *clk_propagate_rate_change(struct clk_core *core,
 	return fail_clk;
 }
 
+static void clk_add_change(struct list_head *changes,
+			       struct clk_change *change,
+			       struct clk_core *parent,
+			       unsigned long rate)
+{
+	change->parent = parent;
+	change->rate = rate;
+	list_add(&change->change_list, changes);
+}
+
+static int clk_prepare_pre_changes(struct list_head *pre_changes,
+				   struct list_head *post_changes,
+				   struct clk_core *core,
+				   unsigned long rate)
+{
+	while (core) {
+		struct clk_core *parent = core->parent;
+		unsigned long new_rate, min_rate, max_rate, best_parent_rate;
+		int ret;
+
+		clk_core_get_boundaries(core, &min_rate, &max_rate);
+			/* TODO: change to clk_core_can_round() */
+			if (clk_core_can_round(core)) {
+			struct clk_rate_request req;
+
+			req.rate = rate;
+			req.min_rate = min_rate;
+			req.max_rate = max_rate;
+
+			clk_core_init_rate_req(core, &req);
+
+			ret = clk_core_determine_round_nolock(core, &req);
+			if (ret < 0)
+				return -EINVAL;
+
+			best_parent_rate = req.best_parent_rate;
+			new_rate = req.rate;
+			parent = req.best_parent_hw ? req.best_parent_hw->core : NULL;
+
+			if (new_rate < min_rate || new_rate > max_rate)
+				return -EINVAL;
+		} else if (!parent || !(core->flags & CLK_SET_RATE_PARENT)) {
+			/* pass-through clock without adjustable parent */
+			return -EINVAL;
+		} else {
+			core = parent;
+			continue;
+		}
+
+		if (parent != core->parent || new_rate != core->rate) {
+			clk_add_change(pre_changes, &core->pre_change, parent,
+				       new_rate);
+			if (list_empty(&core->change.change_list))
+				clk_add_change(post_changes, &core->change,
+					       core->parent, core->rate);
+		}
+
+		core = parent;
+	}
+
+	return -EINVAL;
+}
+
+static int clk_pre_rate_req(struct list_head *pre_changes,
+			    struct list_head *post_changes,
+			    struct clk_core *core)
+{
+	struct clk_core *child, *parent = core->parent;
+	struct clk_rate_request next, pre;
+	struct clk_change *change, *tmp;
+	LIST_HEAD(tmp_list);
+	int ret;
+
+	/* The change list needs to be prepared already. */
+	WARN_ON(list_empty(&core->change.change_list));
+
+	if (!list_empty(&core->pre_change.change_list))
+		return -EINVAL;
+
+	list_add(&core->pre_change.change_list, &tmp_list);
+	while (!list_empty(&tmp_list)) {
+		change = list_first_entry(&tmp_list, struct clk_change,
+					  change_list);
+		core = change->core;
+		list_del_init(&core->pre_change.change_list);
+		hlist_for_each_entry(child, &core->children, child_node) {
+			if (!list_empty(&core->pre_change.change_list)) {
+				ret = -EINVAL;
+				goto err;
+			}
+
+			list_add(&child->pre_change.change_list, &tmp_list);
+		}
+
+		if (!core->ops->pre_rate_req)
+			continue;
+
+		parent = core->change.parent ? core->change.parent :
+			core->parent;
+		if (parent) {
+			next.best_parent_hw = parent->hw;
+			next.best_parent_rate = parent->change.rate;
+		}
+
+		next.rate = core->change.rate;
+		clk_core_get_boundaries(core, &next.min_rate, &next.max_rate);
+		ret = core->ops->pre_rate_req(core->hw, &next, &pre);
+		if (ret < 0)
+			goto err;
+
+		/*
+		 * A return value of 0 means that no pre_rate_req change is
+		 * needed.
+		 */
+		if (ret == 0)
+			continue;
+
+		parent = pre.best_parent_hw ? pre.best_parent_hw->core : NULL;
+		clk_add_change(pre_changes, &core->pre_change, parent,
+			       pre.rate);
+		if (parent != core->parent &&
+		    pre.best_parent_rate != parent->rate)
+			ret = clk_prepare_pre_changes(pre_changes, post_changes,
+						      parent,
+						      pre.best_parent_rate);
+	}
+
+	return 0;
+err:
+	list_for_each_entry_safe(change, tmp, &tmp_list, change_list)
+		list_del_init(&change->core->pre_change.change_list);
+
+	return ret;
+}
+
 /*
  * walk down a subtree and set the new rates notifying the rate
  * change on the way
@@ -2028,7 +2164,7 @@ static int clk_change_rate(struct clk_change *change)
 
 static int clk_change_rates(struct list_head *list)
 {
-	struct clk_change *change, *tmp;
+	struct clk_change *change;
 	int ret = 0;
 
 	/*
@@ -2099,13 +2235,25 @@ static unsigned long clk_core_req_round_rate_nolock(struct clk_core *core,
 	return ret ? 0 : req.rate;
 }
 
+static void clk_del_change_list_entries(struct list_head *changes)
+{
+	struct clk_change *change, *tmp;
+
+	list_for_each_entry_safe(change, tmp, changes, change_list) {
+		change->rate = 0;
+		change->parent = NULL;
+		list_del_init(&change->change_list);
+	}
+}
+
 static int clk_core_set_rate_nolock(struct clk_core *core,
 				    unsigned long req_rate)
 {
 	struct clk_core *top, *fail_clk, *child;
-	struct clk_change *change, *tmp;
 	unsigned long rate;
+	LIST_HEAD(pre_changes);
 	LIST_HEAD(changes);
+	LIST_HEAD(post_changes);
 	int ret = 0;
 
 	if (!core)
@@ -2133,7 +2281,7 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
 	if (top != core) {
 		/* change.parent cannot be NULL in this case */
 		hlist_for_each_entry(child, &core->change.parent->children,
-				child_node)
+				     child_node)
 			clk_calc_subtree(child);
 	} else {
 		clk_calc_subtree(core);
@@ -2142,33 +2290,54 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
 	/* Construct the list of changes */
 	clk_prepare_changes(&changes, top);
 
+	/* We need a separate list for these changes due to error handling. */
+	ret = clk_pre_rate_req(&pre_changes, &post_changes, top);
+	if (ret) {
+		pr_debug("%s: failed pre_rate_req via top clk %s: %d\n",
+			 __func__, top->name, ret);
+		goto pre_rate_req;
+	}
+
 	/* notify that we are about to change rates */
 	fail_clk = clk_propagate_rate_change(top, PRE_RATE_CHANGE);
 	if (fail_clk) {
 		pr_debug("%s: failed to set %s rate\n", __func__,
-				fail_clk->name);
-		clk_propagate_rate_change(top, ABORT_RATE_CHANGE);
+			 fail_clk->name);
 		ret = -EBUSY;
-		goto err;
+		goto prop_rate;
 	}
 
-	/* change the rates */
-	ret = clk_change_rates(&changes);
-	list_for_each_entry_safe(change, tmp, &changes, change_list) {
-		change->rate = 0;
-		change->parent = NULL;
-		list_del_init(&change->change_list);
+	ret = clk_change_rates(&pre_changes);
+	if (ret) {
+		pr_debug("%s: rate rate changes failed via top clk %s: %d\n",
+			 __func__, top->name, ret);
+		goto pre_rate_req;
 	}
 
+	/* change the rates */
+	ret = clk_change_rates(&changes);
+	clk_del_change_list_entries(&changes);
 	if (ret) {
 		pr_debug("%s: failed to set %s rate via top clk %s\n", __func__,
-				core->name, top->name);
-		clk_propagate_rate_change(top, ABORT_RATE_CHANGE);
-		goto err;
+			 core->name, top->name);
+		goto change_rates;
 	}
 
+	ret = clk_change_rates(&post_changes);
+	clk_del_change_list_entries(&post_changes);
+
+	clk_del_change_list_entries(&pre_changes);
 	core->req_rate = req_rate;
-err:
+
+	return 0;
+
+change_rates:
+	WARN_ON(clk_change_rates(&pre_changes));
+prop_rate:
+	clk_propagate_rate_change(top, ABORT_RATE_CHANGE);
+pre_rate_req:
+	clk_del_change_list_entries(&pre_changes);
+	clk_del_change_list_entries(&changes);
 	clk_pm_runtime_put(core);
 
 	return ret;
@@ -3186,7 +3355,9 @@ static int __clk_core_init(struct clk_core *core)
 
 	/* check that clk_ops are sane.  See Documentation/driver-api/clk.rst */
 	if (core->ops->set_rate &&
-	    !((core->ops->round_rate || core->ops->determine_rate) &&
+	    !((core->ops->round_rate ||
+	       core->ops->determine_rate ||
+	       core->ops->pre_rate_req) &&
 	      core->ops->recalc_rate)) {
 		pr_err("%s: %s must implement .round_rate or .determine_rate in addition to .recalc_rate\n",
 		       __func__, core->name);
@@ -3433,7 +3604,9 @@ struct clk *clk_register(struct device *dev, struct clk_hw *hw)
 	INIT_LIST_HEAD(&core->prepare_list);
 	INIT_LIST_HEAD(&core->enable_list);
 	INIT_LIST_HEAD(&core->change.change_list);
+	INIT_LIST_HEAD(&core->pre_change.change_list);
 	core->change.core = core;
+	core->pre_change.core = core;
 	hw->core = core;
 
 	/* allocate local copy in case parent_names is __initdata */
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index e443fa9fa859..c11ca22e2089 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -133,6 +133,13 @@ struct clk_duty {
  *		actually supported by the clock, and optionally the parent clock
  *		that should be used to provide the clock rate.
  *
+ * @pre_rate_req: Given the next state that the clk will enter via a
+ * 		clk_rate_request struct, next, fill in another clk_rate_request
+ * 		struct, pre, with any desired intermediate state to change to
+ * 		before the state in next is applied. Returns positive to request
+ * 		an intermediate state transition, 0 for no transition, and
+ * 		-EERROR otherwise.
+ *
  * @set_parent:	Change the input source of this clock; for clocks with multiple
  *		possible parents specify a new parent by passing in the index
  *		as a u8 corresponding to the parent in either the .parent_names
@@ -231,6 +238,9 @@ struct clk_ops {
 					unsigned long *parent_rate);
 	int		(*determine_rate)(struct clk_hw *hw,
 					  struct clk_rate_request *req);
+	int		(*pre_rate_req)(struct clk_hw *hw,
+					const struct clk_rate_request *next,
+					struct clk_rate_request *pre);
 	int		(*set_parent)(struct clk_hw *hw, u8 index);
 	u8		(*get_parent)(struct clk_hw *hw);
 	int		(*set_rate)(struct clk_hw *hw, unsigned long rate,
-- 
2.21.0.352.gf09ad66450-goog

