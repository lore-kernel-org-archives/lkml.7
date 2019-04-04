Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C8BC10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A614D206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554414848;
	bh=xjPB9a00FxHgJzIN50j1f9PNVneVM2xL4EeIQGBBIuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kEQCO5i8g61FJJ29oE2ts2dveUjuAFatHfGroBapXLtoxozOtlh+jsVpwBD6B2pAl
	 iCkUMQPGvsX02PfWenVOhX+r8zV7JtZPge26UYGUzY5auFlTrB5QLmbWeokKe4Xzx4
	 Lrb08uTiVQJTUFyzJ1RrbSv5h5+whS25odRChZpU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbfDDVxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 17:53:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:48034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730307AbfDDVxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 17:53:47 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B81AA217D4;
        Thu,  4 Apr 2019 21:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554414826;
        bh=xjPB9a00FxHgJzIN50j1f9PNVneVM2xL4EeIQGBBIuw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wg+Q2YHzwXMDAnonntiFd9k50Mqr57b3YWtCaOihjGoThHYMxbC0d2CRDYGTFw01J
         kta2yTPdE3rAyxlUPT7c5jDv92AVTFRvUGr+Bpmq9qY5XTzgQtTJk1jd3XPwMqxYhq
         nIhwWuMwxJhL1xeRhTglTznP0+9/TZL4h2x+tp2E=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: [PATCH v3 1/7] clkdev: Hold clocks_mutex while iterating clocks list
Date:   Thu,  4 Apr 2019 14:53:38 -0700
Message-Id: <20190404215344.6330-2-sboyd@kernel.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190404215344.6330-1-sboyd@kernel.org>
References: <20190404215344.6330-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We recently introduced a change to support devm clk lookups. That change
introduced a code-path that used clk_find() without holding the
'clocks_mutex'. Unfortunately, clk_find() iterates over the 'clocks'
list and so we need to prevent the list from being modified while
iterating over it by holding the mutex. Similarly, we don't need to hold
the 'clocks_mutex' besides when we're dereferencing the clk_lookup
pointer we find or while we're modifying/iterating the 'clocks' list.

Let's ensure that we have the mutex held while iterating the list and
fix the callers of clk_find() to only hold the mutex as long as they
need to. This should fix this race and also nicely move clk creation
outside of the 'clocks_mutex'.

Fixes: 3eee6c7d119c ("clkdev: add managed clkdev lookup registration")
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Jeffrey Hugo <jhugo@codeaurora.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clkdev.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 8c4435c53f09..db82eee8e209 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -36,7 +36,7 @@ static DEFINE_MUTEX(clocks_mutex);
  * Then we take the most specific entry - with the following
  * order of precedence: dev+con > dev only > con only.
  */
-static struct clk_lookup *clk_find(const char *dev_id, const char *con_id)
+static struct clk_lookup *__clk_find(const char *dev_id, const char *con_id)
 {
 	struct clk_lookup *p, *cl = NULL;
 	int match, best_found = 0, best_possible = 0;
@@ -46,6 +46,8 @@ static struct clk_lookup *clk_find(const char *dev_id, const char *con_id)
 	if (con_id)
 		best_possible += 1;
 
+	lockdep_assert_held(&clocks_mutex);
+
 	list_for_each_entry(p, &clocks, node) {
 		match = 0;
 		if (p->dev_id) {
@@ -70,25 +72,37 @@ static struct clk_lookup *clk_find(const char *dev_id, const char *con_id)
 	return cl;
 }
 
-static struct clk *__clk_get_sys(struct device *dev, const char *dev_id,
-				 const char *con_id)
+static struct clk_hw *clk_find_hw(const char *dev_id, const char *con_id)
 {
 	struct clk_lookup *cl;
-	struct clk *clk = NULL;
+	struct clk_hw *hw = ERR_PTR(-ENOENT);
 
 	mutex_lock(&clocks_mutex);
+	cl = __clk_find(dev_id, con_id);
+	if (cl)
+		hw = cl->clk_hw;
+	mutex_unlock(&clocks_mutex);
 
-	cl = clk_find(dev_id, con_id);
-	if (!cl)
-		goto out;
+	return hw;
+}
 
-	clk = clk_hw_create_clk(dev, cl->clk_hw, dev_id, con_id);
-	if (IS_ERR(clk))
-		cl = NULL;
-out:
+static struct clk_lookup *clk_find(const char *dev_id, const char *con_id)
+{
+	struct clk_lookup *cl;
+
+	mutex_lock(&clocks_mutex);
+	cl = __clk_find(dev_id, con_id);
 	mutex_unlock(&clocks_mutex);
 
-	return cl ? clk : ERR_PTR(-ENOENT);
+	return cl;
+}
+
+static struct clk *__clk_get_sys(struct device *dev, const char *dev_id,
+				 const char *con_id)
+{
+	struct clk_hw *hw = clk_find_hw(dev_id, con_id);
+
+	return clk_hw_create_clk(dev, hw, dev_id, con_id);
 }
 
 struct clk *clk_get_sys(const char *dev_id, const char *con_id)
-- 
Sent by a computer through tubes

