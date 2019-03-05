Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423F7C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 04:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1BE62082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 04:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SN3+Ny9M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfCEEtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 23:49:49 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32908 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfCEEtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 23:49:46 -0500
Received: by mail-pf1-f193.google.com with SMTP id i19so4712079pfd.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 20:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XW9u00gqF+VQkOHiAdDCZCu3GFv7vefH7f1kWrnMso4=;
        b=SN3+Ny9MGa1ekRvQ5YA1Av6352InetdZtx5Ubjat2cT7QlJz/lKGlegpWWgtKD+ZfU
         36E2+U/Fz16MYLe/3Do3v7Bll3m4QqyLxDPaboNav+tIl8QkJwRmHXYmDHj4qtmITg58
         8PBcO4DYBMYu6jRhNJgNxYIncdvw5il6hyCvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XW9u00gqF+VQkOHiAdDCZCu3GFv7vefH7f1kWrnMso4=;
        b=q2kMh9+oxqUPWuygldR1I/q5uTrqTzxGx41pOQDRrGWtjjuqNHVlGauU2/V7VhuMzf
         SooFhq/3rIkn6cdFGSgMEYANIk6so2DqR1k+fMuXRVmWomqMImxXm1Y+02aHX3tB+S1U
         OVMyTvXEDXQhbPXWqpGqI1gpg9p7bZqynwTQI2EiCv0dG+tegQ0QoqAxZeUwviXM5cKe
         NiLmLJpD23gJLpxq+SZ1MX8IFTxFNf99w2rK18BkSSLDGs7kOeaoWcVV3gvrrad1rlnf
         yrWajdZncsA936zPCSptIY8auowtBRmt016a8AgDe29ze3GhNehZuCWcSOGyEPicedVW
         Uvgw==
X-Gm-Message-State: APjAAAXT5CBdS+Hlvbln0pvsoY9uiJukBQhRQTEMY6M8IMvNoKa598NU
        9W99OAgg0mPgdXttgZkOUmjbTVBrfcw=
X-Google-Smtp-Source: APXvYqwa/kkbZvMxHk+1iiUNJApYCJBUzUfSqzOx9LMXXbQaWNbvZC6nZp9FjO6/QNoYcZXwYu5H8w==
X-Received: by 2002:a63:7e0e:: with SMTP id z14mr21987642pgc.436.1551761384745;
        Mon, 04 Mar 2019 20:49:44 -0800 (PST)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:db8d:8e3f:2514:5db8])
        by smtp.gmail.com with ESMTPSA id z15sm15893883pgc.25.2019.03.04.20.49.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 20:49:44 -0800 (PST)
From:   Derek Basehore <dbasehore@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-doc@vger.kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, heiko@sntech.de,
        aisheng.dong@nxp.com, mchehab+samsung@kernel.org, corbet@lwn.net,
        jbrunet@baylibre.com, Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH v2 2/6] clk: fix clk_calc_subtree compute duplications
Date:   Mon,  4 Mar 2019 20:49:32 -0800
Message-Id: <20190305044936.22267-3-dbasehore@chromium.org>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
In-Reply-To: <20190305044936.22267-1-dbasehore@chromium.org>
References: <20190305044936.22267-1-dbasehore@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_calc_subtree was called at every step up the clk tree in
clk_calc_new_rates. Since it recursively calls itself for its
children, this means it would be called once on each clk for each
step above the top clk is.

This fixes this by breaking the subtree calculation into two parts.
The first part recalcs the rate for each child of the parent clk in
clk_calc_new_rates. This part is not recursive itself. The second part
recursively calls a new clk_calc_subtree on the clk_core that was
passed into clk_set_rate.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 drivers/clk/clk.c | 49 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 38 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 94b3ac783d90..e20364812b54 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1732,11 +1732,19 @@ static int __clk_speculate_rates(struct clk_core *core,
 	return ret;
 }
 
-static void clk_calc_subtree(struct clk_core *core, unsigned long new_rate,
-			     struct clk_core *new_parent, u8 p_index)
+static void clk_calc_subtree(struct clk_core *core)
 {
 	struct clk_core *child;
 
+	hlist_for_each_entry(child, &core->children, child_node) {
+		child->new_rate = clk_recalc(child, core->new_rate);
+		clk_calc_subtree(child);
+	}
+}
+
+static void clk_set_change(struct clk_core *core, unsigned long new_rate,
+			   struct clk_core *new_parent, u8 p_index)
+{
 	core->new_rate = new_rate;
 	core->new_parent = new_parent;
 	core->new_parent_index = p_index;
@@ -1744,11 +1752,6 @@ static void clk_calc_subtree(struct clk_core *core, unsigned long new_rate,
 	core->new_child = NULL;
 	if (new_parent && new_parent != core->parent)
 		new_parent->new_child = core;
-
-	hlist_for_each_entry(child, &core->children, child_node) {
-		child->new_rate = clk_recalc(child, new_rate);
-		clk_calc_subtree(child, child->new_rate, NULL, 0);
-	}
 }
 
 /*
@@ -1759,7 +1762,7 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *core,
 					   unsigned long rate)
 {
 	struct clk_core *top = core;
-	struct clk_core *old_parent, *parent;
+	struct clk_core *old_parent, *parent, *child;
 	unsigned long best_parent_rate = 0;
 	unsigned long new_rate;
 	unsigned long min_rate;
@@ -1806,6 +1809,13 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *core,
 		/* pass-through clock with adjustable parent */
 		top = clk_calc_new_rates(parent, rate);
 		new_rate = parent->new_rate;
+		hlist_for_each_entry(child, &parent->children, child_node) {
+			if (child == core)
+				continue;
+
+			child->new_rate = clk_recalc(child, new_rate);
+			clk_calc_subtree(child);
+		}
 		goto out;
 	}
 
@@ -1828,11 +1838,19 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *core,
 	}
 
 	if ((core->flags & CLK_SET_RATE_PARENT) && parent &&
-	    best_parent_rate != parent->rate)
+	    best_parent_rate != parent->rate) {
 		top = clk_calc_new_rates(parent, best_parent_rate);
+		hlist_for_each_entry(child, &parent->children, child_node) {
+			if (child == core)
+				continue;
+
+			child->new_rate = clk_recalc(child, parent->new_rate);
+			clk_calc_subtree(child);
+		}
+	}
 
 out:
-	clk_calc_subtree(core, new_rate, parent, p_index);
+	clk_set_change(core, new_rate, parent, p_index);
 
 	return top;
 }
@@ -2007,7 +2025,7 @@ static unsigned long clk_core_req_round_rate_nolock(struct clk_core *core,
 static int clk_core_set_rate_nolock(struct clk_core *core,
 				    unsigned long req_rate)
 {
-	struct clk_core *top, *fail_clk;
+	struct clk_core *top, *fail_clk, *child;
 	unsigned long rate;
 	int ret = 0;
 
@@ -2033,6 +2051,15 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
 	if (ret)
 		return ret;
 
+	if (top != core) {
+		/* new_parent cannot be NULL in this case */
+		hlist_for_each_entry(child, &core->new_parent->children,
+				child_node)
+			clk_calc_subtree(child);
+	} else {
+		clk_calc_subtree(core);
+	}
+
 	/* notify that we are about to change rates */
 	fail_clk = clk_propagate_rate_change(top, PRE_RATE_CHANGE);
 	if (fail_clk) {
-- 
2.21.0.352.gf09ad66450-goog

