Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00A6C76194
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 05:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B55072238E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 05:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PjeA4UGX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfGWFOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 01:14:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34757 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfGWFOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 01:14:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id b13so18503659pfo.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 22:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=g82NP5kE6vDBcz0wRx3HQUPY+qpp2eV2hYfp3Uv8Vuo=;
        b=PjeA4UGXWrX7eWxBKCqRGmYrPvlnc4Bc0zcv0AXulqxA13EAD5I6W1Ktegac4R8rd6
         nqTUr59Y1cBaq2k5PsjAGgvvnd8+z2GDbhDRnvz0yhIpwiR10yY3ZczBOANft1O02EI3
         YyMt9iV7PaFFWCcnbU3kl+A9jkJk3y6kjqTFTswd0Y0P3Rr5yCHC+VtY99tR+fmQfkQ8
         QYz5Dqpan8whgAnXJmUkWJTHKQs2U6j2zK9U7z+zl1Q/ZklGFxcRNLmsRkSQ8XWpbRS+
         psQHHJC3x4F8OqHl+YpZv32+3kFNTljWvL6+wz8F5UkLYDWdsj7FYp0gzepeFDhRxpuI
         qADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=g82NP5kE6vDBcz0wRx3HQUPY+qpp2eV2hYfp3Uv8Vuo=;
        b=MlwQo7io4IwnyICxpGwiTT1EIhP75Bz9e8NVl4+gQB4BsWyQ+3vuxDorwqX9j+3dvM
         FHqiB5a0YDcV//ZQ9VPNWXgcgAydG50b8Mzu2mSMdAsEx2U2MNbsVt71eZZnnFwDHiFt
         avSl3FXyae/RIAuDAdgfRhqeF8ksz4pucjZNNTTSP3XtkDn8Wdnu8lPjuPRM8XrW1rpE
         yRMG0qZj6VjJshbG0uaxdOaBHeRf5aH/DprssV2WgBjKXsdCchHxPwjJwXrJ/0y5jAtH
         Qc5rsfVxYsy4y9PYGceEDFF76zkg7FjDgyHToybnMi7ouWzdjb2kOM5zLIgQ+fE3TJss
         gY4g==
X-Gm-Message-State: APjAAAVSNjyIhR/Sj2CR7k6AH2XqCNYWYhHm4khuYvKPoIHmf7qjEwLA
        SXcfbbzQATdQ/H10pji1v5ybTA==
X-Google-Smtp-Source: APXvYqzkV5mF55GBnujgmB5DhZBig4ykpvvwizIq6zr0p86mQc67qRs9Si4/HU58xo1Fk2BC6VTxTw==
X-Received: by 2002:a62:834d:: with SMTP id h74mr4077651pfe.254.1563858890244;
        Mon, 22 Jul 2019 22:14:50 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id a3sm33729999pfc.70.2019.07.22.22.14.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 22:14:49 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>
Subject: [RFC] clk: Remove cached cores in parent map during unregister
Date:   Mon, 22 Jul 2019 22:14:46 -0700
Message-Id: <20190723051446.20013-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As clocks are registered their parents are resolved and the parent_map
is updated to cache the clk_core objects of each existing parent.
But in the event of a clock being unregistered this cache will carry
dangling pointers if not invalidated, so do this for all children of the
clock being unregistered.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

This resolves the issue seen where the DSI PLL (and it's provided clocks) is
being registered and unregistered multiple times due to probe deferral.

Marking it RFC because I don't fully understand the life of the clock yet.

 drivers/clk/clk.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index c0990703ce54..8cd1ad977c50 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2423,11 +2423,14 @@ bool clk_has_parent(struct clk *clk, struct clk *parent)
 EXPORT_SYMBOL_GPL(clk_has_parent);
 
 static int clk_core_set_parent_nolock(struct clk_core *core,
-				      struct clk_core *parent)
+				      struct clk_core *parent,
+				      bool invalidate_parent)
 {
+	struct clk_core *old_parent = core->parent;
 	int ret = 0;
 	int p_index = 0;
 	unsigned long p_rate = 0;
+	int i;
 
 	lockdep_assert_held(&prepare_lock);
 
@@ -2481,6 +2484,14 @@ static int clk_core_set_parent_nolock(struct clk_core *core,
 		__clk_recalc_accuracies(core);
 	}
 
+	/* invalidate the parent cache */
+	if (!parent && invalidate_parent) {
+		for (i = 0; i < core->num_parents; i++) {
+			if (core->parents[i].core == old_parent)
+				core->parents[i].core = NULL;
+		}
+	}
+
 runtime_put:
 	clk_pm_runtime_put(core);
 
@@ -2517,7 +2528,8 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 		clk_core_rate_unprotect(clk->core);
 
 	ret = clk_core_set_parent_nolock(clk->core,
-					 parent ? parent->core : NULL);
+					 parent ? parent->core : NULL,
+					 false);
 
 	if (clk->exclusive_count)
 		clk_core_rate_protect(clk->core);
@@ -3772,7 +3784,7 @@ void clk_unregister(struct clk *clk)
 		/* Reparent all children to the orphan list. */
 		hlist_for_each_entry_safe(child, t, &clk->core->children,
 					  child_node)
-			clk_core_set_parent_nolock(child, NULL);
+			clk_core_set_parent_nolock(child, NULL, true);
 	}
 
 	hlist_del_init(&clk->core->child_node);
-- 
2.18.0

