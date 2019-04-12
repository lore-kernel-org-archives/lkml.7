Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54324C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 216B0218D9
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555093914;
	bh=HyBqBJLbHWUeQWX+cb/C4Wl/25IHsJuOK2Xzn81HSvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YUTxFGaq5D0DWgyT7mFCQiY8jINO07NqbHcnYFBIMu8MSS2nJtJeXt0GmZ1/c4Zka
	 KUQKdqWVtqBu0QHqaYGGDvE4IwFJpQDFwCHhNvjZf0GMS5gJlkWtaXFo1DkkI5hp+6
	 jLTjGh6OQPzSPrhCFXXNz6XcAGPjP64YNqv+AAMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfDLSbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 14:31:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbfDLSbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 14:31:52 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F938218CD;
        Fri, 12 Apr 2019 18:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555093912;
        bh=HyBqBJLbHWUeQWX+cb/C4Wl/25IHsJuOK2Xzn81HSvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QMXmOtwPTjD3kYgTbLxwvmjtmR2Oh8CWSUl52Dngr7bq+iyhKqnvaIxOIzVXhv7gL
         ms0+qyKR37MOnzXVeYeWvB+fShmPKMgL01WWk+/PJhMRyKyUMhzNA1v/bOjJ7YB9/h
         GAeJxlt3FdmcRWL0LXoXEFIfJa4Zqdnsm9Rc1zac=
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
Subject: [PATCH v4 1/9] clkdev: Hold clocks_mutex while iterating clocks list
Date:   Fri, 12 Apr 2019 11:31:42 -0700
Message-Id: <20190412183150.102131-2-sboyd@kernel.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190412183150.102131-1-sboyd@kernel.org>
References: <20190412183150.102131-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We recently introduced a change to support devm clk lookups. That change
introduced a code-path that used clk_find() without holding the
'clocks_mutex'. Unfortunately, clk_find() iterates over the 'clocks'
list and so we need to prevent the list from being modified at the same
time. Do this by holding the mutex and checking to make sure it's held
while iterating the list.

Note, we don't really care if the lookup is freed after we find it with
clk_find() because we're just doing a pointer comparison, but if we did
care we would need to keep holding the mutex while we dereference the
clk_lookup pointer.

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

I plan to take this through clk-fixes for v5.1-rc series.

 drivers/clk/clkdev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 8c4435c53f09..6e787cc9e5b9 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -46,6 +46,8 @@ static struct clk_lookup *clk_find(const char *dev_id, const char *con_id)
 	if (con_id)
 		best_possible += 1;
 
+	lockdep_assert_held(&clocks_mutex);
+
 	list_for_each_entry(p, &clocks, node) {
 		match = 0;
 		if (p->dev_id) {
@@ -402,7 +404,10 @@ void devm_clk_release_clkdev(struct device *dev, const char *con_id,
 	struct clk_lookup *cl;
 	int rval;
 
+	mutex_lock(&clocks_mutex);
 	cl = clk_find(dev_id, con_id);
+	mutex_unlock(&clocks_mutex);
+
 	WARN_ON(!cl);
 	rval = devres_release(dev, devm_clkdev_release,
 			      devm_clk_match_clkdev, cl);
-- 
Sent by a computer through tubes

