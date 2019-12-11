Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D04C00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D24322B48
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730040AbfLKOfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 09:35:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:38606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729790AbfLKOe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 09:34:59 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33F64214AF;
        Wed, 11 Dec 2019 14:34:58 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.3)
        (envelope-from <rostedt@goodmis.org>)
        id 1if34r-0010cn-46; Wed, 11 Dec 2019 09:34:57 -0500
Message-Id: <20191211143457.001730161@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 11 Dec 2019 09:34:25 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [for-linus][PATCH 3/3] ftrace: Fix function_graph tracer interaction with BPF trampoline
References: <20191211143422.570348522@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Depending on type of BPF programs served by BPF trampoline it can call original
function. In such case the trampoline will skip one stack frame while
returning. That will confuse function_graph tracer and will cause crashes with
bad RIP. Teach graph tracer to skip functions that have BPF trampoline attached.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/x86/kernel/ftrace.c | 14 --------------
 include/linux/ftrace.h   |  5 +++++
 kernel/trace/fgraph.c    |  9 +++++++++
 kernel/trace/ftrace.c    | 19 +++++++------------
 4 files changed, 21 insertions(+), 26 deletions(-)

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
 
-- 
2.24.0


