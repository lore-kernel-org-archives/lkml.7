Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B63ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB8E20679
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569951882;
	bh=JqxdV6NYhU77pQazbiewDwxfL6Hh0WUAJEAGUDhXxMg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=P4Xtg/kHLUqKFCyXq/FCwr91vr6+om45WYkQtA1jth8vzb90x6X3ni/rm7zeeT8cn
	 rw+Ff+ONg3KR6p9mKX6vdEpSzl+B84r5SaJJqQl+LED0EmEhV/nqkPtSf6wxjLngxt
	 CY+gwqFQMSiqJks14MJRGtYlrZJw5sdUbbSuiTgo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbfJARol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 13:44:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:41396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbfJARol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 13:44:41 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A493620679;
        Tue,  1 Oct 2019 17:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569951879;
        bh=JqxdV6NYhU77pQazbiewDwxfL6Hh0WUAJEAGUDhXxMg=;
        h=From:To:Cc:Subject:Date:From;
        b=VeigWmb26aUfLQhz4uBwN3dXdxhVCmleDtryzr38oidFffuYtBWvhKI47SWR3BsGp
         zHTextgzXppA6NG1an+1a4/bOOWrFMw0/xAqhxS6B6TltCnUpBwXIHgJXPP660MPz4
         XwjOrVL7OU8a57TtzymSsXKApavncI1asW6YQqMw=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH] clk: Don't cache errors from clk_ops::get_phase()
Date:   Tue,  1 Oct 2019 10:44:39 -0700
Message-Id: <20191001174439.182435-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't check for errors from clk_ops::get_phase() before storing away
the result into the clk_core::phase member. This can lead to some fairly
confusing debugfs information if these ops do return an error. Let's
skip the store when this op fails to fix this. While we're here, move
the locking outside of clk_core_get_phase() to simplify callers from
the debugfs side.

Cc: Douglas Anderson <dianders@chromium.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---

Resending because I couldn't find this anywhere.

 drivers/clk/clk.c | 44 +++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 1c677d7f7f53..16add5626dfa 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2640,14 +2640,14 @@ EXPORT_SYMBOL_GPL(clk_set_phase);
 
 static int clk_core_get_phase(struct clk_core *core)
 {
-	int ret;
+	int ret = 0;
 
-	clk_prepare_lock();
+	lockdep_assert_held(&prepare_lock);
 	/* Always try to update cached phase if possible */
 	if (core->ops->get_phase)
-		core->phase = core->ops->get_phase(core->hw);
-	ret = core->phase;
-	clk_prepare_unlock();
+		ret = core->ops->get_phase(core->hw);
+	if (ret >= 0)
+		core->phase = ret;
 
 	return ret;
 }
@@ -2661,10 +2661,16 @@ static int clk_core_get_phase(struct clk_core *core)
  */
 int clk_get_phase(struct clk *clk)
 {
+	int ret;
+
 	if (!clk)
 		return 0;
 
-	return clk_core_get_phase(clk->core);
+	clk_prepare_unlock();
+	ret = clk_core_get_phase(clk->core);
+	clk_prepare_unlock();
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(clk_get_phase);
 
@@ -2878,13 +2884,21 @@ static struct hlist_head *orphan_list[] = {
 static void clk_summary_show_one(struct seq_file *s, struct clk_core *c,
 				 int level)
 {
-	seq_printf(s, "%*s%-*s %7d %8d %8d %11lu %10lu %5d %6d\n",
+	int phase;
+
+	seq_printf(s, "%*s%-*s %7d %8d %8d %11lu %10lu ",
 		   level * 3 + 1, "",
 		   30 - level * 3, c->name,
 		   c->enable_count, c->prepare_count, c->protect_count,
-		   clk_core_get_rate(c), clk_core_get_accuracy(c),
-		   clk_core_get_phase(c),
-		   clk_core_get_scaled_duty_cycle(c, 100000));
+		   clk_core_get_rate(c), clk_core_get_accuracy(c));
+
+	phase = clk_core_get_phase(c);
+	if (phase >= 0)
+		seq_printf(s, "%5d", phase);
+	else
+		seq_puts(s, "-----");
+
+	seq_printf(s, " %6d\n", clk_core_get_scaled_duty_cycle(c, 100000));
 }
 
 static void clk_summary_show_subtree(struct seq_file *s, struct clk_core *c,
@@ -2921,6 +2935,7 @@ DEFINE_SHOW_ATTRIBUTE(clk_summary);
 
 static void clk_dump_one(struct seq_file *s, struct clk_core *c, int level)
 {
+	int phase;
 	unsigned long min_rate, max_rate;
 
 	clk_core_get_boundaries(c, &min_rate, &max_rate);
@@ -2934,7 +2949,9 @@ static void clk_dump_one(struct seq_file *s, struct clk_core *c, int level)
 	seq_printf(s, "\"min_rate\": %lu,", min_rate);
 	seq_printf(s, "\"max_rate\": %lu,", max_rate);
 	seq_printf(s, "\"accuracy\": %lu,", clk_core_get_accuracy(c));
-	seq_printf(s, "\"phase\": %d,", clk_core_get_phase(c));
+	phase = clk_core_get_phase(c);
+	if (phase >= 0)
+		seq_printf(s, "\"phase\": %d,", phase);
 	seq_printf(s, "\"duty_cycle\": %u",
 		   clk_core_get_scaled_duty_cycle(c, 100000));
 }
@@ -3349,10 +3366,7 @@ static int __clk_core_init(struct clk_core *core)
 	 * Since a phase is by definition relative to its parent, just
 	 * query the current clock phase, or just assume it's in phase.
 	 */
-	if (core->ops->get_phase)
-		core->phase = core->ops->get_phase(core->hw);
-	else
-		core->phase = 0;
+	clk_core_get_phase(core);
 
 	/*
 	 * Set clk's duty cycle.
-- 
Sent by a computer through tubes

