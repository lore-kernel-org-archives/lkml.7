Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47648C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 20:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA0920815
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 20:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbfI2URT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 16:17:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728576AbfI2URT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 16:17:19 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 317FF20815;
        Sun, 29 Sep 2019 20:17:17 +0000 (UTC)
Date:   Sun, 29 Sep 2019 16:17:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] tracing: A few minor fix ups
Message-ID: <20190929161715.17a2b179@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

A few more tracing fixes:

 - Fixed a buffer overflow by checking nr_args correctly in probes

 - Fixed a warning that is reported by clang

 - Fixed a possible memory leak in error path of filter processing

 - Fixed the selftest that checks for failures, but wasn't failing

 - Minor clean up on call site output of a memory trace event


Please pull the latest trace-v5.4-3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.4-3

Tag SHA1: 6bd391b341525bebf22f3fbbaea7ffb35f7cccb6
Head SHA1: 8ed4889eb83179dbc9a105cfed65cc42ecb61097


Changbin Du (1):
      mm, tracing: Print symbol name for call_site in trace events

Masami Hiramatsu (1):
      tracing/probe: Fix to check the difference of nr_args before adding probe

Nathan Chancellor (1):
      tracing: Fix clang -Wint-in-bool-context warnings in IF_ASSIGN macro

Navid Emamdoost (1):
      tracing: Have error path in predicate_parse() free its allocated memory

Steven Rostedt (VMware) (1):
      selftests/ftrace: Fix same probe error test

----
 include/trace/events/kmem.h                              |  7 ++++---
 kernel/trace/trace.h                                     | 10 +++++-----
 kernel/trace/trace_events_filter.c                       |  6 ++++--
 kernel/trace/trace_probe.c                               | 16 ++++++++++++++++
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc         |  2 +-
 5 files changed, 30 insertions(+), 11 deletions(-)
---------------------------
diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index eb57e3037deb..69e8bb8963db 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -35,8 +35,8 @@ DECLARE_EVENT_CLASS(kmem_alloc,
 		__entry->gfp_flags	= gfp_flags;
 	),
 
-	TP_printk("call_site=%lx ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s",
-		__entry->call_site,
+	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s",
+		(void *)__entry->call_site,
 		__entry->ptr,
 		__entry->bytes_req,
 		__entry->bytes_alloc,
@@ -131,7 +131,8 @@ DECLARE_EVENT_CLASS(kmem_free,
 		__entry->ptr		= ptr;
 	),
 
-	TP_printk("call_site=%lx ptr=%p", __entry->call_site, __entry->ptr)
+	TP_printk("call_site=%pS ptr=%p",
+		  (void *)__entry->call_site, __entry->ptr)
 );
 
 DEFINE_EVENT(kmem_free, kfree,
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 26b0a08f3c7d..f801d154ff6a 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -365,11 +365,11 @@ static inline struct trace_array *top_trace_array(void)
 	__builtin_types_compatible_p(typeof(var), type *)
 
 #undef IF_ASSIGN
-#define IF_ASSIGN(var, entry, etype, id)		\
-	if (FTRACE_CMP_TYPE(var, etype)) {		\
-		var = (typeof(var))(entry);		\
-		WARN_ON(id && (entry)->type != id);	\
-		break;					\
+#define IF_ASSIGN(var, entry, etype, id)			\
+	if (FTRACE_CMP_TYPE(var, etype)) {			\
+		var = (typeof(var))(entry);			\
+		WARN_ON(id != 0 && (entry)->type != id);	\
+		break;						\
 	}
 
 /* Will cause compile errors if type is not found. */
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index c773b8fb270c..c9a74f82b14a 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -452,8 +452,10 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
 
 		switch (*next) {
 		case '(':					/* #2 */
-			if (top - op_stack > nr_parens)
-				return ERR_PTR(-EINVAL);
+			if (top - op_stack > nr_parens) {
+				ret = -EINVAL;
+				goto out_free;
+			}
 			*(++top) = invert;
 			continue;
 		case '!':					/* #3 */
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index baf58a3612c0..905b10af5d5c 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -178,6 +178,16 @@ void __trace_probe_log_err(int offset, int err_type)
 	if (!command)
 		return;
 
+	if (trace_probe_log.index >= trace_probe_log.argc) {
+		/**
+		 * Set the error position is next to the last arg + space.
+		 * Note that len includes the terminal null and the cursor
+		 * appaers at pos + 1.
+		 */
+		pos = len;
+		offset = 0;
+	}
+
 	/* And make a command string from argv array */
 	p = command;
 	for (i = 0; i < trace_probe_log.argc; i++) {
@@ -1084,6 +1094,12 @@ int trace_probe_compare_arg_type(struct trace_probe *a, struct trace_probe *b)
 {
 	int i;
 
+	/* In case of more arguments */
+	if (a->nr_args < b->nr_args)
+		return a->nr_args + 1;
+	if (a->nr_args > b->nr_args)
+		return b->nr_args + 1;
+
 	for (i = 0; i < a->nr_args; i++) {
 		if ((b->nr_args <= i) ||
 		    ((a->args[i].type != b->args[i].type) ||
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
index 8a4025e912cb..ef1e9bafb098 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
@@ -95,7 +95,7 @@ echo 'p:kprobes/testevent _do_fork abcd=\1' > kprobe_events
 check_error 'p:kprobes/testevent _do_fork ^bcd=\1'	# DIFF_ARG_TYPE
 check_error 'p:kprobes/testevent _do_fork ^abcd=\1:u8'	# DIFF_ARG_TYPE
 check_error 'p:kprobes/testevent _do_fork ^abcd=\"foo"'	# DIFF_ARG_TYPE
-check_error '^p:kprobes/testevent _do_fork'	# SAME_PROBE
+check_error '^p:kprobes/testevent _do_fork abcd=\1'	# SAME_PROBE
 fi
 
 exit 0
