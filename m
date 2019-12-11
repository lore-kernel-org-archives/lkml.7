Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063F8C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9EF208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729933AbfLKOmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 09:42:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:42424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727554AbfLKOmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 09:42:53 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D183B208C3;
        Wed, 11 Dec 2019 14:42:51 +0000 (UTC)
Date:   Wed, 11 Dec 2019 09:42:49 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [GIT PULL] tracing: More fixes for 5.5
Message-ID: <20191211094249.2013d32a@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

This contains 3 changes:

 - Removal of code I accidentally applied when doing a minor fix up
   to a patch, and then using "git commit -a --amend", which pulled
   in some other changes I was playing with.

 - Remove an used variable in trace_events_inject code

 - Fix to function graph tracer when it traces a ftrace direct function.
   It will now ignore tracing a function that has a ftrace direct
   tramploine attached. This is needed for eBPF to use the ftrace direct
   code.

Please pull the latest trace-v5.5-3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.5-3

Tag SHA1: 2f96b90660986979a6bbca1e8738b9aeb5e7eeff
Head SHA1: ff205766dbbee024a4a716638868d98ffb17748a


Alexei Starovoitov (1):
      ftrace: Fix function_graph tracer interaction with BPF trampoline

Steven Rostedt (VMware) (1):
      module: Remove accidental change of module_enable_x()

YueHaibing (1):
      tracing: remove set but not used variable 'buffer'

----
 arch/x86/kernel/ftrace.c           | 14 --------------
 include/linux/ftrace.h             |  5 +++++
 kernel/module.c                    |  6 +-----
 kernel/trace/fgraph.c              |  9 +++++++++
 kernel/trace/ftrace.c              | 19 +++++++------------
 kernel/trace/trace_events_inject.c |  2 --
 6 files changed, 22 insertions(+), 33 deletions(-)
---------------------------
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 060a361d9d11..024c3053dbba 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -1042,20 +1042,6 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
 		return;
 
-	/*
-	 * If the return location is actually pointing directly to
-	 * the start of a direct trampoline (if we trace the trampoline
-	 * it will still be offset by MCOUNT_INSN_SIZE), then the
-	 * return address is actually off by one word, and we
-	 * need to adjust for that.
-	 */
-	if (ftrace_direct_func_count) {
-		if (ftrace_find_direct_func(self_addr + MCOUNT_INSN_SIZE)) {
-			self_addr = *parent;
-			parent++;
-		}
-	}
-
 	/*
 	 * Protect against fault, even if it shouldn't
 	 * happen. This tool is too much intrusive to
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 232806d5689d..987c2dc55bde 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -264,6 +264,7 @@ int ftrace_modify_direct_caller(struct ftrace_func_entry *entry,
 				struct dyn_ftrace *rec,
 				unsigned long old_addr,
 				unsigned long new_addr);
+unsigned long ftrace_find_rec_direct(unsigned long ip);
 #else
 # define ftrace_direct_func_count 0
 static inline int register_ftrace_direct(unsigned long ip, unsigned long addr)
@@ -290,6 +291,10 @@ static inline int ftrace_modify_direct_caller(struct ftrace_func_entry *entry,
 {
 	return -ENODEV;
 }
+static inline unsigned long ftrace_find_rec_direct(unsigned long ip)
+{
+	return 0;
+}
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
 #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
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
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 67e0c462b059..a2659735db73 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -101,6 +101,15 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 {
 	struct ftrace_graph_ent trace;
 
+	/*
+	 * Skip graph tracing if the return location is served by direct trampoline,
+	 * since call sequence and return addresses is unpredicatable anymore.
+	 * Ex: BPF trampoline may call original function and may skip frame
+	 * depending on type of BPF programs attached.
+	 */
+	if (ftrace_direct_func_count &&
+	    ftrace_find_rec_direct(ret - MCOUNT_INSN_SIZE))
+		return -EBUSY;
 	trace.func = func;
 	trace.depth = ++current->curr_ret_depth;
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index caae523f4ef3..57477dc683db 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2364,7 +2364,7 @@ int ftrace_direct_func_count;
  * Search the direct_functions hash to see if the given instruction pointer
  * has a direct caller attached to it.
  */
-static unsigned long find_rec_direct(unsigned long ip)
+unsigned long ftrace_find_rec_direct(unsigned long ip)
 {
 	struct ftrace_func_entry *entry;
 
@@ -2380,7 +2380,7 @@ static void call_direct_funcs(unsigned long ip, unsigned long pip,
 {
 	unsigned long addr;
 
-	addr = find_rec_direct(ip);
+	addr = ftrace_find_rec_direct(ip);
 	if (!addr)
 		return;
 
@@ -2393,11 +2393,6 @@ struct ftrace_ops direct_ops = {
 			  | FTRACE_OPS_FL_DIRECT | FTRACE_OPS_FL_SAVE_REGS
 			  | FTRACE_OPS_FL_PERMANENT,
 };
-#else
-static inline unsigned long find_rec_direct(unsigned long ip)
-{
-	return 0;
-}
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
 /**
@@ -2417,7 +2412,7 @@ unsigned long ftrace_get_addr_new(struct dyn_ftrace *rec)
 
 	if ((rec->flags & FTRACE_FL_DIRECT) &&
 	    (ftrace_rec_count(rec) == 1)) {
-		addr = find_rec_direct(rec->ip);
+		addr = ftrace_find_rec_direct(rec->ip);
 		if (addr)
 			return addr;
 		WARN_ON_ONCE(1);
@@ -2458,7 +2453,7 @@ unsigned long ftrace_get_addr_curr(struct dyn_ftrace *rec)
 
 	/* Direct calls take precedence over trampolines */
 	if (rec->flags & FTRACE_FL_DIRECT_EN) {
-		addr = find_rec_direct(rec->ip);
+		addr = ftrace_find_rec_direct(rec->ip);
 		if (addr)
 			return addr;
 		WARN_ON_ONCE(1);
@@ -3604,7 +3599,7 @@ static int t_show(struct seq_file *m, void *v)
 		if (rec->flags & FTRACE_FL_DIRECT) {
 			unsigned long direct;
 
-			direct = find_rec_direct(rec->ip);
+			direct = ftrace_find_rec_direct(rec->ip);
 			if (direct)
 				seq_printf(m, "\n\tdirect-->%pS", (void *)direct);
 		}
@@ -5008,7 +5003,7 @@ int register_ftrace_direct(unsigned long ip, unsigned long addr)
 	mutex_lock(&direct_mutex);
 
 	/* See if there's a direct function at @ip already */
-	if (find_rec_direct(ip))
+	if (ftrace_find_rec_direct(ip))
 		goto out_unlock;
 
 	ret = -ENODEV;
@@ -5027,7 +5022,7 @@ int register_ftrace_direct(unsigned long ip, unsigned long addr)
 	if (ip != rec->ip) {
 		ip = rec->ip;
 		/* Need to check this ip for a direct. */
-		if (find_rec_direct(ip))
+		if (ftrace_find_rec_direct(ip))
 			goto out_unlock;
 	}
 
diff --git a/kernel/trace/trace_events_inject.c b/kernel/trace/trace_events_inject.c
index d43710718ee5..d45079ee62f8 100644
--- a/kernel/trace/trace_events_inject.c
+++ b/kernel/trace/trace_events_inject.c
@@ -17,12 +17,10 @@ static int
 trace_inject_entry(struct trace_event_file *file, void *rec, int len)
 {
 	struct trace_event_buffer fbuffer;
-	struct ring_buffer *buffer;
 	int written = 0;
 	void *entry;
 
 	rcu_read_lock_sched();
-	buffer = file->tr->trace_buffer.buffer;
 	entry = trace_event_buffer_reserve(&fbuffer, file, len);
 	if (entry) {
 		memcpy(entry, rec, len);
