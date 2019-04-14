Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B548C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F0C20850
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfDNUor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 16:44:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47089 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfDNUoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 16:44:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3EKiGYw2691730
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 14 Apr 2019 13:44:16 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3EKiGuk2691725;
        Sun, 14 Apr 2019 13:44:16 -0700
Date:   Sun, 14 Apr 2019 13:44:16 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-4285f2fcef8001ead0f1c9315ba50302cab68cda@git.kernel.org>
Cc:     rostedt@goodmis.org, glider@google.com, tglx@linutronix.de,
        peterz@infradead.org, mingo@kernel.org, luto@kernel.org,
        jpoimboe@redhat.com, linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: rostedt@goodmis.org, tglx@linutronix.de, glider@google.com,
          peterz@infradead.org, mingo@kernel.org, luto@kernel.org,
          jpoimboe@redhat.com, linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <20190410103645.048761764@linutronix.de>
References: <20190410103645.048761764@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/stacktrace] tracing: Remove the ULONG_MAX stack trace
 hackery
Git-Commit-ID: 4285f2fcef8001ead0f1c9315ba50302cab68cda
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  4285f2fcef8001ead0f1c9315ba50302cab68cda
Gitweb:     https://git.kernel.org/tip/4285f2fcef8001ead0f1c9315ba50302cab68cda
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 10 Apr 2019 12:28:10 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 14 Apr 2019 19:58:32 +0200

tracing: Remove the ULONG_MAX stack trace hackery

No architecture terminates the stack trace with ULONG_MAX anymore. As the
code checks the number of entries stored anyway there is no point in
keeping all that ULONG_MAX magic around.

The histogram code zeroes the storage before saving the stack, so if the
trace is shorter than the maximum number of entries it can terminate the
print loop if a zero entry is detected.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexander Potapenko <glider@google.com>
Link: https://lkml.kernel.org/r/20190410103645.048761764@linutronix.de

---
 kernel/trace/trace_events_hist.c |  2 +-
 kernel/trace/trace_stack.c       | 20 +++++---------------
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 795aa2038377..21ceae299f7e 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5246,7 +5246,7 @@ static void hist_trigger_stacktrace_print(struct seq_file *m,
 	unsigned int i;
 
 	for (i = 0; i < max_entries; i++) {
-		if (stacktrace_entries[i] == ULONG_MAX)
+		if (!stacktrace_entries[i])
 			return;
 
 		seq_printf(m, "%*c", 1 + spaces, ' ');
diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index eec648a0d673..c6e54ff25cae 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -18,8 +18,7 @@
 
 #include "trace.h"
 
-static unsigned long stack_dump_trace[STACK_TRACE_ENTRIES+1] =
-	 { [0 ... (STACK_TRACE_ENTRIES)] = ULONG_MAX };
+static unsigned long stack_dump_trace[STACK_TRACE_ENTRIES + 1];
 unsigned stack_trace_index[STACK_TRACE_ENTRIES];
 
 /*
@@ -52,10 +51,7 @@ void stack_trace_print(void)
 			   stack_trace_max.nr_entries);
 
 	for (i = 0; i < stack_trace_max.nr_entries; i++) {
-		if (stack_dump_trace[i] == ULONG_MAX)
-			break;
-		if (i+1 == stack_trace_max.nr_entries ||
-				stack_dump_trace[i+1] == ULONG_MAX)
+		if (i + 1 == stack_trace_max.nr_entries)
 			size = stack_trace_index[i];
 		else
 			size = stack_trace_index[i] - stack_trace_index[i+1];
@@ -150,8 +146,6 @@ check_stack(unsigned long ip, unsigned long *stack)
 		p = start;
 
 		for (; p < top && i < stack_trace_max.nr_entries; p++) {
-			if (stack_dump_trace[i] == ULONG_MAX)
-				break;
 			/*
 			 * The READ_ONCE_NOCHECK is used to let KASAN know that
 			 * this is not a stack-out-of-bounds error.
@@ -183,8 +177,6 @@ check_stack(unsigned long ip, unsigned long *stack)
 	}
 
 	stack_trace_max.nr_entries = x;
-	for (; x < i; x++)
-		stack_dump_trace[x] = ULONG_MAX;
 
 	if (task_stack_end_corrupted(current)) {
 		stack_trace_print();
@@ -286,7 +278,7 @@ __next(struct seq_file *m, loff_t *pos)
 {
 	long n = *pos - 1;
 
-	if (n >= stack_trace_max.nr_entries || stack_dump_trace[n] == ULONG_MAX)
+	if (n >= stack_trace_max.nr_entries)
 		return NULL;
 
 	m->private = (void *)n;
@@ -360,12 +352,10 @@ static int t_show(struct seq_file *m, void *v)
 
 	i = *(long *)v;
 
-	if (i >= stack_trace_max.nr_entries ||
-	    stack_dump_trace[i] == ULONG_MAX)
+	if (i >= stack_trace_max.nr_entries)
 		return 0;
 
-	if (i+1 == stack_trace_max.nr_entries ||
-	    stack_dump_trace[i+1] == ULONG_MAX)
+	if (i + 1 == stack_trace_max.nr_entries)
 		size = stack_trace_index[i];
 	else
 		size = stack_trace_index[i] - stack_trace_index[i+1];
