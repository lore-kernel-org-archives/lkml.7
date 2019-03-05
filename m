Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AEEC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 04:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A51B2084D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 04:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FQn9dTUY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfCEEtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 23:49:50 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37630 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbfCEEtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 23:49:45 -0500
Received: by mail-pf1-f196.google.com with SMTP id s22so4707267pfh.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 20:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8X01odutz3vPJQ0+JS1nE7ap7/RwHbCbl03cfhPHZdc=;
        b=FQn9dTUYle1V+FnEg9iKi095FYrzkrPaVn4b+M9ev4zJ0Os6HwUNy4YLwOZl+awmBO
         tjTiKkvncv+a3RGxOcvgmbjl+bQVvP5zE4FfPY/+zqY0B0vSOVfMh5W2J2zbYm/QPOuz
         riSAgIlHqkHuN0uwirpv6juFBb0ftEGi2XkOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8X01odutz3vPJQ0+JS1nE7ap7/RwHbCbl03cfhPHZdc=;
        b=nyjfZgF8+sCPZIdh3CdDyi/XjA6cHES3dpgNG3HItE0BmeAdeN9EpOKcAMAjA7fs7W
         xgR1jkerR+d98/vCkvZz4K6pUtOWvpepBtYDghtKFLi8bXc3wXEbQKbxYpeFRskO1vqM
         RTP9xwLDamfw01ZmpVnYhbOjek8MLmrKGHX6YCrG4S26fujXoSfzgSo035mxjOjVAizG
         CoI0SCdyY0UgWXznQahMCxd2SAb6hDukbnnIRZwLAbI9K9w9Za2G1NgycjVBSEdoBDze
         Gbq3cYvYI/VSoX8A2iAL/QiAJqyQRbcVLZ0xen+920CC6JIdjoCmoDEiftqEes01ii+g
         FpzA==
X-Gm-Message-State: APjAAAUAqkiIZijfSBA7B3Hb4mpi9kTkWwF1s3Cma2JsC62UzGccQYxY
        cBG6wYsU0060e0niyK4IvV53UOmidr8=
X-Google-Smtp-Source: APXvYqx3g9tNsNmso5eebQ6edaVVFjoNjzoEm1iKrF422AlmVyGZoOhDLoNDomTjxVcF4JG8OktGYA==
X-Received: by 2002:a17:902:d214:: with SMTP id t20mr7541633ply.268.1551761383742;
        Mon, 04 Mar 2019 20:49:43 -0800 (PST)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:db8d:8e3f:2514:5db8])
        by smtp.gmail.com with ESMTPSA id z15sm15893883pgc.25.2019.03.04.20.49.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 20:49:43 -0800 (PST)
From:   Derek Basehore <dbasehore@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-doc@vger.kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, heiko@sntech.de,
        aisheng.dong@nxp.com, mchehab+samsung@kernel.org, corbet@lwn.net,
        jbrunet@baylibre.com, Stephen Boyd <sboyd@codeaurora.org>,
        Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH v2 1/6] clk: Remove recursion in clk_core_{prepare,enable}()
Date:   Mon,  4 Mar 2019 20:49:31 -0800
Message-Id: <20190305044936.22267-2-dbasehore@chromium.org>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
In-Reply-To: <20190305044936.22267-1-dbasehore@chromium.org>
References: <20190305044936.22267-1-dbasehore@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <sboyd@codeaurora.org>

Enabling and preparing clocks can be written quite naturally with
recursion. We start at some point in the tree and recurse up the
tree to find the oldest parent clk that needs to be enabled or
prepared. Then we enable/prepare and return to the caller, going
back to the clk we started at and enabling/preparing along the
way. This also unroll the recursion in unprepare,disable which can
just be done in the order of walking up the clk tree.

The problem is recursion isn't great for kernel code where we
have a limited stack size. Furthermore, we may be calling this
code inside clk_set_rate() which also has recursion in it, so
we're really not looking good if we encounter a tall clk tree.

Let's create a stack instead by looping over the parent chain and
collecting clks of interest. Then the enable/prepare becomes as
simple as iterating over that list and calling enable.

Modified verison of https://lore.kernel.org/patchwork/patch/814369/
-Fixed kernel warning
-unrolled recursion in unprepare/disable too

Cc: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 drivers/clk/clk.c | 191 ++++++++++++++++++++++++++--------------------
 1 file changed, 107 insertions(+), 84 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index d2477a5058ac..94b3ac783d90 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -68,6 +68,8 @@ struct clk_core {
 	struct hlist_head	children;
 	struct hlist_node	child_node;
 	struct hlist_head	clks;
+	struct list_head	prepare_list;
+	struct list_head	enable_list;
 	unsigned int		notifier_count;
 #ifdef CONFIG_DEBUG_FS
 	struct dentry		*dentry;
@@ -677,34 +679,34 @@ static void clk_core_unprepare(struct clk_core *core)
 {
 	lockdep_assert_held(&prepare_lock);
 
-	if (!core)
-		return;
-
-	if (WARN(core->prepare_count == 0,
-	    "%s already unprepared\n", core->name))
-		return;
-
-	if (WARN(core->prepare_count == 1 && core->flags & CLK_IS_CRITICAL,
-	    "Unpreparing critical %s\n", core->name))
-		return;
+	while (core) {
+		if (WARN(core->prepare_count == 0,
+		    "%s already unprepared\n", core->name))
+			return;
 
-	if (core->flags & CLK_SET_RATE_GATE)
-		clk_core_rate_unprotect(core);
+		if (WARN(core->prepare_count == 1 &&
+			 core->flags & CLK_IS_CRITICAL,
+			 "Unpreparing critical %s\n", core->name))
+			return;
 
-	if (--core->prepare_count > 0)
-		return;
+		if (core->flags & CLK_SET_RATE_GATE)
+			clk_core_rate_unprotect(core);
 
-	WARN(core->enable_count > 0, "Unpreparing enabled %s\n", core->name);
+		if (--core->prepare_count > 0)
+			return;
 
-	trace_clk_unprepare(core);
+		WARN(core->enable_count > 0, "Unpreparing enabled %s\n",
+		     core->name);
+		trace_clk_unprepare(core);
 
-	if (core->ops->unprepare)
-		core->ops->unprepare(core->hw);
+		if (core->ops->unprepare)
+			core->ops->unprepare(core->hw);
 
-	clk_pm_runtime_put(core);
+		clk_pm_runtime_put(core);
 
-	trace_clk_unprepare_complete(core);
-	clk_core_unprepare(core->parent);
+		trace_clk_unprepare_complete(core);
+		core = core->parent;
+	}
 }
 
 static void clk_core_unprepare_lock(struct clk_core *core)
@@ -737,49 +739,57 @@ EXPORT_SYMBOL_GPL(clk_unprepare);
 static int clk_core_prepare(struct clk_core *core)
 {
 	int ret = 0;
+	LIST_HEAD(head);
 
 	lockdep_assert_held(&prepare_lock);
 
-	if (!core)
-		return 0;
+	while (core) {
+		list_add(&core->prepare_list, &head);
+		/*
+		 * Stop once we see a clk that is already prepared. Adding a clk
+		 * to the list with a non-zero prepare count (or reaching NULL)
+		 * makes error handling work as implemented.
+		 */
+		if (core->prepare_count)
+			break;
+		core = core->parent;
+	}
 
-	if (core->prepare_count == 0) {
-		ret = clk_pm_runtime_get(core);
-		if (ret)
-			return ret;
+	/* First entry has either a prepare_count of 0 or a NULL parent. */
+	list_for_each_entry(core, &head, prepare_list) {
+		if (core->prepare_count == 0) {
+			ret = clk_pm_runtime_get(core);
+			if (ret)
+				goto unprepare_parent;
 
-		ret = clk_core_prepare(core->parent);
-		if (ret)
-			goto runtime_put;
+			trace_clk_prepare(core);
 
-		trace_clk_prepare(core);
+			if (core->ops->prepare)
+				ret = core->ops->prepare(core->hw);
 
-		if (core->ops->prepare)
-			ret = core->ops->prepare(core->hw);
+			trace_clk_prepare_complete(core);
 
-		trace_clk_prepare_complete(core);
+			if (ret)
+				goto runtime_put;
+		}
+		core->prepare_count++;
 
-		if (ret)
-			goto unprepare;
+		/*
+		 * CLK_SET_RATE_GATE is a special case of clock protection
+		 * Instead of a consumer claiming exclusive rate control, it is
+		 * actually the provider which prevents any consumer from making
+		 * any operation which could result in a rate change or rate
+		 * glitch while the clock is prepared.
+		 */
+		if (core->flags & CLK_SET_RATE_GATE)
+			clk_core_rate_protect(core);
 	}
 
-	core->prepare_count++;
-
-	/*
-	 * CLK_SET_RATE_GATE is a special case of clock protection
-	 * Instead of a consumer claiming exclusive rate control, it is
-	 * actually the provider which prevents any consumer from making any
-	 * operation which could result in a rate change or rate glitch while
-	 * the clock is prepared.
-	 */
-	if (core->flags & CLK_SET_RATE_GATE)
-		clk_core_rate_protect(core);
-
 	return 0;
-unprepare:
-	clk_core_unprepare(core->parent);
 runtime_put:
 	clk_pm_runtime_put(core);
+unprepare_parent:
+	clk_core_unprepare(core->parent);
 	return ret;
 }
 
@@ -819,27 +829,27 @@ static void clk_core_disable(struct clk_core *core)
 {
 	lockdep_assert_held(&enable_lock);
 
-	if (!core)
-		return;
-
-	if (WARN(core->enable_count == 0, "%s already disabled\n", core->name))
-		return;
-
-	if (WARN(core->enable_count == 1 && core->flags & CLK_IS_CRITICAL,
-	    "Disabling critical %s\n", core->name))
-		return;
+	while (core) {
+		if (WARN(core->enable_count == 0, "%s already disabled\n",
+			 core->name))
+			return;
 
-	if (--core->enable_count > 0)
-		return;
+		if (--core->enable_count > 0)
+			return;
 
-	trace_clk_disable_rcuidle(core);
+		if (WARN(core->enable_count == 1 &&
+			 core->flags & CLK_IS_CRITICAL,
+			 "Disabling critical %s\n", core->name))
+			return;
 
-	if (core->ops->disable)
-		core->ops->disable(core->hw);
+		trace_clk_disable_rcuidle(core);
 
-	trace_clk_disable_complete_rcuidle(core);
+		if (core->ops->disable)
+			core->ops->disable(core->hw);
 
-	clk_core_disable(core->parent);
+		trace_clk_disable_complete_rcuidle(core);
+		core = core->parent;
+	}
 }
 
 static void clk_core_disable_lock(struct clk_core *core)
@@ -875,37 +885,48 @@ EXPORT_SYMBOL_GPL(clk_disable);
 static int clk_core_enable(struct clk_core *core)
 {
 	int ret = 0;
+	LIST_HEAD(head);
 
 	lockdep_assert_held(&enable_lock);
 
-	if (!core)
-		return 0;
+	while (core) {
+		if (WARN(core->prepare_count == 0,
+			 "Enabling unprepared %s\n", core->name))
+			return -ESHUTDOWN;
 
-	if (WARN(core->prepare_count == 0,
-	    "Enabling unprepared %s\n", core->name))
-		return -ESHUTDOWN;
-
-	if (core->enable_count == 0) {
-		ret = clk_core_enable(core->parent);
+		list_add(&core->enable_list, &head);
+		/*
+		 * Stop once we see a clk that is already enabled. Adding a clk
+		 * to the list with a non-zero prepare count (or reaching NULL)
+		 * makes error handling work as implemented.
+		 */
+		if (core->enable_count)
+			break;
 
-		if (ret)
-			return ret;
+		core = core->parent;
+	}
 
-		trace_clk_enable_rcuidle(core);
+	/* First entry has either an enable_count of 0 or a NULL parent. */
+	list_for_each_entry(core, &head, enable_list) {
+		if (core->enable_count == 0) {
+			trace_clk_enable_rcuidle(core);
 
-		if (core->ops->enable)
-			ret = core->ops->enable(core->hw);
+			if (core->ops->enable)
+				ret = core->ops->enable(core->hw);
 
-		trace_clk_enable_complete_rcuidle(core);
+			trace_clk_enable_complete_rcuidle(core);
 
-		if (ret) {
-			clk_core_disable(core->parent);
-			return ret;
+			if (ret)
+				goto err;
 		}
+
+		core->enable_count++;
 	}
 
-	core->enable_count++;
 	return 0;
+err:
+	clk_core_disable(core->parent);
+	return ret;
 }
 
 static int clk_core_enable_lock(struct clk_core *core)
@@ -3288,6 +3309,8 @@ struct clk *clk_register(struct device *dev, struct clk_hw *hw)
 	core->num_parents = hw->init->num_parents;
 	core->min_rate = 0;
 	core->max_rate = ULONG_MAX;
+	INIT_LIST_HEAD(&core->prepare_list);
+	INIT_LIST_HEAD(&core->enable_list);
 	hw->core = core;
 
 	/* allocate local copy in case parent_names is __initdata */
-- 
2.21.0.352.gf09ad66450-goog

