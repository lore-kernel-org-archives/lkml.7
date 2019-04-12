Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC871C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA9820818
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555093921;
	bh=J/xGoKvpAn8VN6F0LRcxO6cDYVGFyNVvjKQEpBW6ETw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TiMa4k2YkprvEUp2hzh72zPwDYNN5jN2DlKzMkhhfsTtMMLZVOcltJnWh7GF2F8ko
	 LZptpqAFnSKAti8Cyc3aLMkPaZKM6asJkixS67Mmc4qIWdn75cqbFcEQRWeOVXlVd8
	 AxF2zAGOos7qdJVjVepVZTf0ptFobzczeIDv4f0k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfDLScA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 14:32:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:50478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbfDLSbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 14:31:55 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DCFA218FF;
        Fri, 12 Apr 2019 18:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555093914;
        bh=J/xGoKvpAn8VN6F0LRcxO6cDYVGFyNVvjKQEpBW6ETw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VBVd1KvYbclyKAO7npK8PM617+Ss03DjRysOi2b1hVNA0ZrNqpw7wlHtVoJCMdA9Q
         0p4IxcYXtjrXRZ2TDdV0h8p6zVLh2rwnCL9Wdbrs42LFJ38LCBRoLw9qiL+NVjtDxg
         kjxJDzkM6Ep2j3nvP3vt6jGY3cBPZyvXNcUGGDpc=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v4 7/9] clk: Look for parents with clkdev based clk_lookups
Date:   Fri, 12 Apr 2019 11:31:48 -0700
Message-Id: <20190412183150.102131-8-sboyd@kernel.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190412183150.102131-1-sboyd@kernel.org>
References: <20190412183150.102131-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to looking for DT based parents, support clkdev based
clk_lookups. This should allow non-DT based clk drivers to participate
in the parent lookup process.

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Jeffrey Hugo <jhugo@codeaurora.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk.c    | 27 ++++++++++++++++++---------
 drivers/clk/clk.h    |  2 ++
 drivers/clk/clkdev.c |  2 +-
 3 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index de49a7c4214b..42f29fd6bfd8 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -324,14 +324,15 @@ static struct clk_core *clk_core_lookup(const char *name)
 }
 
 /**
- * clk_core_get - Find the parent of a clk using a clock specifier in DT
+ * clk_core_get - Find the clk_core parent of a clk
  * @core: clk to find parent of
- * @name: name to search for in 'clock-names' of device providing clk
+ * @name: name to search for
  *
  * This is the preferred method for clk providers to find the parent of a
  * clk when that parent is external to the clk controller. The parent_names
  * array is indexed and treated as a local name matching a string in the device
- * node's 'clock-names' property. This allows clk providers to use their own
+ * node's 'clock-names' property or as the 'con_id' matching the device's
+ * dev_name() in a clk_lookup. This allows clk providers to use their own
  * namespace instead of looking for a globally unique parent string.
  *
  * For example the following DT snippet would allow a clock registered by the
@@ -359,15 +360,23 @@ static struct clk_core *clk_core_lookup(const char *name)
  */
 static struct clk_core *clk_core_get(struct clk_core *core, const char *name)
 {
-	struct clk_hw *hw;
+	struct clk_hw *hw = ERR_PTR(-ENOENT);
+	struct device *dev = core->dev;
+	const char *dev_id = dev ? dev_name(dev) : NULL;
 	struct device_node *np = core->of_node;
 
-	if (!np)
-		return ERR_PTR(-ENOENT);
+	if (np)
+		hw = of_clk_get_hw(np, -1, name);
 
-	/* TODO: Support clkdev clk_lookups */
-	hw = of_clk_get_hw(np, -1, name);
-	if (IS_ERR_OR_NULL(hw))
+	/*
+	 * If the DT search above couldn't find the provider or the provider
+	 * didn't know about this clk, fallback to looking up via clkdev based
+	 * clk_lookups
+	 */
+	if (PTR_ERR(hw) == -ENOENT)
+		hw = clk_find_hw(dev_id, name);
+
+	if (IS_ERR(hw))
 		return ERR_CAST(hw);
 
 	return hw->core;
diff --git a/drivers/clk/clk.h b/drivers/clk/clk.h
index 553f531cc232..d8400d623b34 100644
--- a/drivers/clk/clk.h
+++ b/drivers/clk/clk.h
@@ -19,6 +19,8 @@ static inline struct clk_hw *of_clk_get_hw(struct device_node *np,
 }
 #endif
 
+struct clk_hw *clk_find_hw(const char *dev_id, const char *con_id);
+
 #ifdef CONFIG_COMMON_CLK
 struct clk *clk_hw_create_clk(struct device *dev, struct clk_hw *hw,
 			      const char *dev_id, const char *con_id);
diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 6f65bde696da..2afc8df8acff 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -72,7 +72,7 @@ static struct clk_lookup *clk_find(const char *dev_id, const char *con_id)
 	return cl;
 }
 
-static struct clk_hw *clk_find_hw(const char *dev_id, const char *con_id)
+struct clk_hw *clk_find_hw(const char *dev_id, const char *con_id)
 {
 	struct clk_lookup *cl;
 	struct clk_hw *hw = ERR_PTR(-ENOENT);
-- 
Sent by a computer through tubes

