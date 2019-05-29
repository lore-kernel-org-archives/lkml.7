Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53FCC04AB6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 02:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA08821721
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 02:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfE2C6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 22:58:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbfE2C6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 22:58:37 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3552C21721;
        Wed, 29 May 2019 02:58:36 +0000 (UTC)
Date:   Tue, 28 May 2019 22:58:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tomas Bortoli <tomasbortoli@gmail.com>
Subject: [GIT PULL] tracing: Avoid memory leak in predicate_parse()
Message-ID: <20190528225834.7428baf9@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

This fixes a memory leak from the error path in the event filter logic.


Please pull the latest trace-v5.2-rc2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.2-rc2

Tag SHA1: 0658b13d1bfd40bda1c2bd1ef3738857e1bf4000
Head SHA1: dfb4a6f2191a80c8b790117d0ff592fd712d3296


Tomas Bortoli (1):
      tracing: Avoid memory leak in predicate_parse()

----
 kernel/trace/trace_events_filter.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)
---------------------------
commit dfb4a6f2191a80c8b790117d0ff592fd712d3296
Author: Tomas Bortoli <tomasbortoli@gmail.com>
Date:   Tue May 28 17:43:38 2019 +0200

    tracing: Avoid memory leak in predicate_parse()
    
    In case of errors, predicate_parse() goes to the out_free label
    to free memory and to return an error code.
    
    However, predicate_parse() does not free the predicates of the
    temporary prog_stack array, thence leaking them.
    
    Link: http://lkml.kernel.org/r/20190528154338.29976-1-tomasbortoli@gmail.com
    
    Cc: stable@vger.kernel.org
    Fixes: 80765597bc587 ("tracing: Rewrite filter logic to be simpler and faster")
    Reported-by: syzbot+6b8e0fb820e570c59e19@syzkaller.appspotmail.com
    Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
    [ Added protection around freeing prog_stack[i].pred ]
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index d3e59312ef40..5079d1db3754 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -428,7 +428,7 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
 	op_stack = kmalloc_array(nr_parens, sizeof(*op_stack), GFP_KERNEL);
 	if (!op_stack)
 		return ERR_PTR(-ENOMEM);
-	prog_stack = kmalloc_array(nr_preds, sizeof(*prog_stack), GFP_KERNEL);
+	prog_stack = kcalloc(nr_preds, sizeof(*prog_stack), GFP_KERNEL);
 	if (!prog_stack) {
 		parse_error(pe, -ENOMEM, 0);
 		goto out_free;
@@ -579,7 +579,11 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
 out_free:
 	kfree(op_stack);
 	kfree(inverts);
-	kfree(prog_stack);
+	if (prog_stack) {
+		for (i = 0; prog_stack[i].pred; i++)
+			kfree(prog_stack[i].pred);
+		kfree(prog_stack);
+	}
 	return ERR_PTR(ret);
 }
 
