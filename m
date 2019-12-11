Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C713C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B0072464B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbfLKOe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 09:34:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:38570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbfLKOe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 09:34:58 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3602D222C4;
        Wed, 11 Dec 2019 14:34:58 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.3)
        (envelope-from <rostedt@goodmis.org>)
        id 1if34q-0010bq-Qq; Wed, 11 Dec 2019 09:34:56 -0500
Message-Id: <20191211143456.714869660@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 11 Dec 2019 09:34:23 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Divya Indi <divya.indi@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [for-linus][PATCH 1/3] module: Remove accidental change of module_enable_x()
References: <20191211143422.570348522@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

When pulling in Divya Indi's patch, I made a minor fix to remove unneeded
braces. I commited my fix up via "git commit -a --amend". Unfortunately, I
didn't realize I had some changes I was testing in the module code, and
those changes were applied to Divya's patch as well.

This reverts the accidental updates to the module code.

Cc: Jessica Yu <jeyu@kernel.org>
Cc: Divya Indi <divya.indi@oracle.com>
Reported-by: Peter Zijlstra <peterz@infradead.org>
Fixes: e585e6469d6f ("tracing: Verify if trace array exists before destroying it.")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/module.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 6e2fd40a6ed9..ff2d7359a418 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3728,6 +3728,7 @@ static int complete_formation(struct module *mod, struct load_info *info)
 
 	module_enable_ro(mod, false);
 	module_enable_nx(mod);
+	module_enable_x(mod);
 
 	/* Mark state as coming so strong_try_module_get() ignores us,
 	 * but kallsyms etc. can see us. */
@@ -3750,11 +3751,6 @@ static int prepare_coming_module(struct module *mod)
 	if (err)
 		return err;
 
-	/* Make module executable after ftrace is enabled */
-	mutex_lock(&module_mutex);
-	module_enable_x(mod);
-	mutex_unlock(&module_mutex);
-
 	blocking_notifier_call_chain(&module_notify_list,
 				     MODULE_STATE_COMING, mod);
 	return 0;
-- 
2.24.0


