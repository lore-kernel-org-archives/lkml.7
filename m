Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45730C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFDE1218C3
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555093926;
	bh=jiLNbmEM7Idc3pt65bEuMUpgmufpjAZ+SN1eZ0ORQxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zm0fv+OKXeNUyZ0ruyUacliBTvv1asOeXe0YmEXUZdKOYkqfR9izb809YyiY81716
	 g0i8WKLpsGxgwRI4mshy22RVM4CnV0kRa50objKpvcvW1aK8QZoGdouzEzGS0jOcyr
	 i5wgqA7p1Swp4y1nuwoWSBD0F9LKRy4aoZmrCqc0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfDLScA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 14:32:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:50350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727065AbfDLSbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 14:31:55 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5849218D9;
        Fri, 12 Apr 2019 18:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555093915;
        bh=jiLNbmEM7Idc3pt65bEuMUpgmufpjAZ+SN1eZ0ORQxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iWs6oxVhXKz3fFxukKWnf06n7xo5ktMhKIBrgqEQmix2dt51VxdWw8zInpXBCPJow
         0Bu04UTV+Yh6W88D236c7BgiZ88E+VnG6Tb7zVWrEmMUY+b/+HbuVeOSSbD2xQO8CT
         IO3GMq/XwqSl3c5JP3/CgFVDtHsuJyLdHySGm0nU=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v4 8/9] clk: Allow parents to be specified via clkspec index
Date:   Fri, 12 Apr 2019 11:31:49 -0700
Message-Id: <20190412183150.102131-9-sboyd@kernel.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190412183150.102131-1-sboyd@kernel.org>
References: <20190412183150.102131-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some clk providers are simple DT nodes that only have a 'clocks'
property without having an associated 'clock-names' property. In these
cases, we want to let these clk providers point to their parent clks
without having to dereference the 'clocks' property at probe time to
figure out the parent's globally unique clk name. Let's add an 'index'
property to the parent_data structure so that clk providers can indicate
that their parent is a particular index in the 'clocks' DT property.

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Jeffrey Hugo <jhugo@codeaurora.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk.c            | 18 +++++++++++-------
 include/linux/clk-provider.h |  2 ++
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 42f29fd6bfd8..65fe50b139ea 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -44,6 +44,7 @@ struct clk_parent_map {
 	struct clk_core		*core;
 	const char	 	*fw_name;
 	const char	 	*name;
+	int			index;
 };
 
 struct clk_core {
@@ -326,7 +327,8 @@ static struct clk_core *clk_core_lookup(const char *name)
 /**
  * clk_core_get - Find the clk_core parent of a clk
  * @core: clk to find parent of
- * @name: name to search for
+ * @name: name to search for (if string based)
+ * @index: index to use for search (if DT index based)
  *
  * This is the preferred method for clk providers to find the parent of a
  * clk when that parent is external to the clk controller. The parent_names
@@ -358,22 +360,23 @@ static struct clk_core *clk_core_lookup(const char *name)
  * provider knows about the clk but it isn't provided on this system.
  * A valid clk_core pointer when the clk can be found in the provider.
  */
-static struct clk_core *clk_core_get(struct clk_core *core, const char *name)
+static struct clk_core *clk_core_get(struct clk_core *core, const char *name,
+				     int index)
 {
 	struct clk_hw *hw = ERR_PTR(-ENOENT);
 	struct device *dev = core->dev;
 	const char *dev_id = dev ? dev_name(dev) : NULL;
 	struct device_node *np = core->of_node;
 
-	if (np)
-		hw = of_clk_get_hw(np, -1, name);
+	if (np && index >= 0)
+		hw = of_clk_get_hw(np, index, name);
 
 	/*
 	 * If the DT search above couldn't find the provider or the provider
 	 * didn't know about this clk, fallback to looking up via clkdev based
 	 * clk_lookups
 	 */
-	if (PTR_ERR(hw) == -ENOENT)
+	if (PTR_ERR(hw) == -ENOENT && name)
 		hw = clk_find_hw(dev_id, name);
 
 	if (IS_ERR(hw))
@@ -397,8 +400,7 @@ static void clk_core_fill_parent_index(struct clk_core *core, u8 index)
 		if (!parent)
 			parent = ERR_PTR(-EPROBE_DEFER);
 	} else {
-		if (entry->fw_name)
-			parent = clk_core_get(core, entry->fw_name);
+		parent = clk_core_get(core, entry->fw_name, entry->index);
 		if (IS_ERR(parent) && PTR_ERR(parent) == -ENOENT)
 			parent = clk_core_lookup(entry->name);
 	}
@@ -3443,6 +3445,7 @@ static int clk_core_populate_parent_map(struct clk_core *core)
 
 	/* Copy everything over because it might be __initdata */
 	for (i = 0, parent = parents; i < num_parents; i++, parent++) {
+		parent->index = -1;
 		if (parent_names) {
 			/* throw a WARN if any entries are NULL */
 			WARN(!parent_names[i],
@@ -3452,6 +3455,7 @@ static int clk_core_populate_parent_map(struct clk_core *core)
 					   true);
 		} else if (parent_data) {
 			parent->hw = parent_data[i].hw;
+			parent->index = parent_data[i].index;
 			ret = clk_cpy_name(&parent->fw_name,
 					   parent_data[i].fw_name, false);
 			if (!ret)
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 95d5a9d4e8c3..12fef24b740f 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -255,11 +255,13 @@ struct clk_ops {
  * @hw: parent clk_hw pointer (used for clk providers with internal clks)
  * @fw_name: parent name local to provider registering clk
  * @name: globally unique parent name (used as a fallback)
+ * @index: parent index local to provider registering clk (if @fw_name absent)
  */
 struct clk_parent_data {
 	const struct clk_hw 	*hw;
 	const char		*fw_name;
 	const char		*name;
+	int			index;
 };
 
 /**
-- 
Sent by a computer through tubes

