Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C66C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BCFF218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555093918;
	bh=9nrE2eN80xxKdJ9WieNmrYl4QLOjjhrAG6XUmVRgGZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wv1N1mUjYxvaMoKoc2urlqUdpptnLxI3f0VJHkWWBpf6XVfCD2abW9G10bE1WHG/C
	 MvPTrFoyBGsicxt3Tv+IT02yCx2Z2LF1cYbWCqmVPaW8VUrB2jDFMXvQdV/lJSuOor
	 F70qubSLCrDz0c0aWvW+0STXpBFOIiwH553mwJs4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfDLSb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 14:31:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726914AbfDLSbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 14:31:53 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26064218C3;
        Fri, 12 Apr 2019 18:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555093912;
        bh=9nrE2eN80xxKdJ9WieNmrYl4QLOjjhrAG6XUmVRgGZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DclFyroe13Qb1lWk3Qx7ERAxnNpTSQ0uc2RtGeQxHrgB+l7h7OArWZ0ydeVjIAZ10
         woko8Z0r7yUL+hrH2NsIqPX4R0FwtASEo2c8h9aJyblqCrMUtcGl7amsJcCW032pEI
         FA5H72WRpQs89ZhySCLtBBiVQCz9nUFkL2rgNMd4=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v4 2/9] clkdev: Move clk creation outside of 'clocks_mutex'
Date:   Fri, 12 Apr 2019 11:31:43 -0700
Message-Id: <20190412183150.102131-3-sboyd@kernel.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190412183150.102131-1-sboyd@kernel.org>
References: <20190412183150.102131-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need to hold the 'clocks_mutex' here when we're creating a clk
pointer from a clk_lookup structure. Instead, we just need to make sure
that the lookup doesn't go away while we dereference the lookup pointer
to extract the clk_hw pointer out of it. Let's move things around
slightly so that we have a new function to get the clk_hw out of the
lookup with the right locking and then chain the two together for what
used to be __clk_get_sys().

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Jeffrey Hugo <jhugo@codeaurora.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clkdev.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 6e787cc9e5b9..6f65bde696da 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -72,25 +72,26 @@ static struct clk_lookup *clk_find(const char *dev_id, const char *con_id)
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
-
 	cl = clk_find(dev_id, con_id);
-	if (!cl)
-		goto out;
-
-	clk = clk_hw_create_clk(dev, cl->clk_hw, dev_id, con_id);
-	if (IS_ERR(clk))
-		cl = NULL;
-out:
+	if (cl)
+		hw = cl->clk_hw;
 	mutex_unlock(&clocks_mutex);
 
-	return cl ? clk : ERR_PTR(-ENOENT);
+	return hw;
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

