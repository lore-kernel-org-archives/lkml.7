Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22563C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D24205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565732511;
	bh=y45ppmo8H+UmFsR8Vr5BLhr0iRlrjbJItfa6nYWO1EE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=KdXpD+ytaK+Cn2o5H8GDNhMJsEmKEA6AdF5A7xdbnoz2qac3DEq2aTrrdZGHWAC1e
	 Wr+k9Ef6PrUyn1lVPOrZ7iKW88R8CNJiRtwNKch3CgsEvleMx3gOWq2cNJLDZnn7qm
	 J2H01tYTfHOepwH2ZVTIxNW3USwIVf2U9uYtPf2I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfHMVlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 17:41:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbfHMVlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 17:41:49 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E737F205F4;
        Tue, 13 Aug 2019 21:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565732508;
        bh=y45ppmo8H+UmFsR8Vr5BLhr0iRlrjbJItfa6nYWO1EE=;
        h=From:To:Cc:Subject:Date:From;
        b=dH+wk20EowqzGbtKF3+eSJz7f7ntqtM9l/SYajpf4JehQIfZ5+1Kx6NNn9aH0ePh7
         9gQoBmo8DAdrNZke6J9DaiEvEDbVjrLLJXC/wYlMAfHol+AnBOLOWWXVnlw5X0+lAm
         J7DXfszZEA/rx9sCDwUQmFs4hplpA7eq0bnObK/c=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v2] clk: Fix falling back to legacy parent string matching
Date:   Tue, 13 Aug 2019 14:41:47 -0700
Message-Id: <20190813214147.34394-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calls to clk_core_get() will return ERR_PTR(-EINVAL) if we've started
migrating a clk driver to use the DT based style of specifying parents
but we haven't made any DT updates yet. This happens when we pass a
non-NULL value as the 'name' argument of of_parse_clkspec(). That
function returns -EINVAL in such a situation, instead of -ENOENT like we
expected. The return value comes back up to clk_core_fill_parent_index()
which proceeds to skip calling clk_core_lookup() because the error
pointer isn't equal to -ENOENT, it's -EINVAL.

Furthermore, we blindly overwrite the error pointer returned by
clk_core_get() with NULL when there isn't a legacy .name member
specified in the parent map. This isn't too bad right now because we
don't really care to differentiate NULL from an error, but in the future
we should only try to do a legacy lookup if we know we might find
something. This way DT lookups that fail don't try to lookup based on
strings when there isn't any string to match, hiding the error from DT
parsing.

Fix both these problems so that clk provider drivers can use the new
style of parent mapping without having to also update their DT at the
same time. This patch is based on an earlier patch from Taniya Das which
checked for -EINVAL in addition to -ENOENT return values from
clk_core_get().

Fixes: 601b6e93304a ("clk: Allow parents to be specified via clkspec index")
Cc: Taniya Das <tdas@codeaurora.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Reported-by: Taniya Das <tdas@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---

Changes from v1:
 * Don't trust error values from of_clk_get_hw() anymore, instead 
   look for parsing errors and only proceed if the parsing doesn't
   fail.
 * Leave the -ENOENT check in place so that EPROBE_DEFER returned
   from clk_core_lookup() doesn't try to do a global string search
   if parsing succeeded.

 drivers/clk/clk.c | 46 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index c0990703ce54..8bce6bb4a965 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -324,6 +324,25 @@ static struct clk_core *clk_core_lookup(const char *name)
 	return NULL;
 }
 
+#ifdef CONFIG_OF
+static int of_parse_clkspec(const struct device_node *np, int index,
+			    const char *name, struct of_phandle_args *out_args);
+static struct clk_hw *
+of_clk_get_hw_from_clkspec(struct of_phandle_args *clkspec);
+#else
+static inline int of_parse_clkspec(const struct device_node *np, int index,
+				   const char *name,
+				   struct of_phandle_args *out_args)
+{
+	return -ENOENT;
+}
+static inline struct clk_hw *
+of_clk_get_hw_from_clkspec(struct of_phandle_args *clkspec)
+{
+	return ERR_PTR(-ENOENT);
+}
+#endif
+
 /**
  * clk_core_get - Find the clk_core parent of a clk
  * @core: clk to find parent of
@@ -355,8 +374,9 @@ static struct clk_core *clk_core_lookup(const char *name)
  *      };
  *
  * Returns: -ENOENT when the provider can't be found or the clk doesn't
- * exist in the provider. -EINVAL when the name can't be found. NULL when the
- * provider knows about the clk but it isn't provided on this system.
+ * exist in the provider or the name can't be found in the DT node or
+ * in a clkdev lookup. NULL when the provider knows about the clk but it
+ * isn't provided on this system.
  * A valid clk_core pointer when the clk can be found in the provider.
  */
 static struct clk_core *clk_core_get(struct clk_core *core, u8 p_index)
@@ -367,17 +387,19 @@ static struct clk_core *clk_core_get(struct clk_core *core, u8 p_index)
 	struct device *dev = core->dev;
 	const char *dev_id = dev ? dev_name(dev) : NULL;
 	struct device_node *np = core->of_node;
+	struct of_phandle_args clkspec;
 
-	if (np && (name || index >= 0))
-		hw = of_clk_get_hw(np, index, name);
-
-	/*
-	 * If the DT search above couldn't find the provider or the provider
-	 * didn't know about this clk, fallback to looking up via clkdev based
-	 * clk_lookups
-	 */
-	if (PTR_ERR(hw) == -ENOENT && name)
+	if (np && (name || index >= 0) &&
+	    !of_parse_clkspec(np, index, name, &clkspec)) {
+		hw = of_clk_get_hw_from_clkspec(&clkspec);
+		of_node_put(clkspec.np);
+	} else if (name) {
+		/*
+		 * If the DT search above couldn't find the provider fallback to
+		 * looking up via clkdev based clk_lookups.
+		 */
 		hw = clk_find_hw(dev_id, name);
+	}
 
 	if (IS_ERR(hw))
 		return ERR_CAST(hw);
@@ -401,7 +423,7 @@ static void clk_core_fill_parent_index(struct clk_core *core, u8 index)
 			parent = ERR_PTR(-EPROBE_DEFER);
 	} else {
 		parent = clk_core_get(core, index);
-		if (IS_ERR(parent) && PTR_ERR(parent) == -ENOENT)
+		if (IS_ERR(parent) && PTR_ERR(parent) == -ENOENT && entry->name)
 			parent = clk_core_lookup(entry->name);
 	}
 
-- 
Sent by a computer through tubes

