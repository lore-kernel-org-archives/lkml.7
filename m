Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A0CC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 16:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B91520873
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 16:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730777AbfGSQSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 12:18:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727972AbfGSQSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 12:18:16 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D78F20873;
        Fri, 19 Jul 2019 16:18:14 +0000 (UTC)
Date:   Fri, 19 Jul 2019 12:18:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eiichi Tsukata <devel@etsukata.com>
Subject: [GIT PULL] tracing: Fix user stack trace "??" output
Message-ID: <20190719121813.4b113efd@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Eiichi Tsukata found a small bug from the fixup of the stack code

Removing ULONG_MAX as the marker for the user stack trace end
made the tracing code not know where the end is. The end is now
marked with a zero (NULL) pointer. Eiichi fixed this in the tracing
code.


Please pull the latest trace-v5.3-2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.3-2

Tag SHA1: f46c69b1df70d80025590e7780ce0d7572698ad6
Head SHA1: 6d54ceb539aacc3df65c89500e8b045924f3ef81


Eiichi Tsukata (1):
      tracing: Fix user stack trace "??" output

----
 kernel/trace/trace_output.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)
---------------------------
commit 6d54ceb539aacc3df65c89500e8b045924f3ef81
Author: Eiichi Tsukata <devel@etsukata.com>
Date:   Sun Jun 30 17:54:38 2019 +0900

    tracing: Fix user stack trace "??" output
    
    Commit c5c27a0a5838 ("x86/stacktrace: Remove the pointless ULONG_MAX
    marker") removes ULONG_MAX marker from user stack trace entries but
    trace_user_stack_print() still uses the marker and it outputs unnecessary
    "??".
    
    For example:
    
                less-1911  [001] d..2    34.758944: <user stack trace>
       =>  <00007f16f2295910>
       => ??
       => ??
       => ??
       => ??
       => ??
       => ??
       => ??
    
    The user stack trace code zeroes the storage before saving the stack, so if
    the trace is shorter than the maximum number of entries it can terminate
    the print loop if a zero entry is detected.
    
    Link: http://lkml.kernel.org/r/20190630085438.25545-1-devel@etsukata.com
    
    Cc: stable@vger.kernel.org
    Fixes: 4285f2fcef80 ("tracing: Remove the ULONG_MAX stack trace hackery")
    Signed-off-by: Eiichi Tsukata <devel@etsukata.com>
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 54373d93e251..1d6178a188f4 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1109,17 +1109,10 @@ static enum print_line_t trace_user_stack_print(struct trace_iterator *iter,
 	for (i = 0; i < FTRACE_STACK_ENTRIES; i++) {
 		unsigned long ip = field->caller[i];
 
-		if (ip == ULONG_MAX || trace_seq_has_overflowed(s))
+		if (!ip || trace_seq_has_overflowed(s))
 			break;
 
 		trace_seq_puts(s, " => ");
-
-		if (!ip) {
-			trace_seq_puts(s, "??");
-			trace_seq_putc(s, '\n');
-			continue;
-		}
-
 		seq_print_user_ip(s, mm, ip, flags);
 		trace_seq_putc(s, '\n');
 	}
