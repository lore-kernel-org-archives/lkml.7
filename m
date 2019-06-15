Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29389C31E47
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 12:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E942921841
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 12:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfFOMtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 08:49:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfFOMtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 08:49:06 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21A8B21841;
        Sat, 15 Jun 2019 12:49:05 +0000 (UTC)
Date:   Sat, 15 Jun 2019 08:49:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] tracing: A few fixes for 5.2-rc4
Message-ID: <20190615084903.763883c5@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

This includes the following fixes:

 - Out of range read of stack trace output
 - Fix for NULL pointer dereference in trace_uprobe_create()
 - Fix to a livepatching / ftrace permission race in the module code
 - Fix for NULL pointer dereference in free_ftrace_func_mapper()
 - A couple of build warning clean ups


Please pull the latest trace-v5.2-rc4 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.2-rc4

Tag SHA1: 2aca81205fbb41cbe4a9cfb017f0cddc08773d00
Head SHA1: 04e03d9a616c19a47178eaca835358610e63a1dd


Eiichi Tsukata (3):
      tracing: Fix out-of-range read in trace_stack_print()
      tracing/uprobe: Fix NULL pointer dereference in trace_uprobe_create()
      tracing/uprobe: Fix obsolete comment on trace_uprobe_create()

Josh Poimboeuf (1):
      module: Fix livepatch/ftrace module text permissions race

Vasily Gorbik (1):
      tracing: avoid build warning with HAVE_NOP_MCOUNT

Wei Li (1):
      ftrace: Fix NULL pointer dereference in free_ftrace_func_mapper()

YueHaibing (1):
      tracing: Make two symbols static

----
 kernel/livepatch/core.c     |  6 ++++++
 kernel/trace/ftrace.c       | 22 ++++++++++++++++------
 kernel/trace/trace.c        |  4 ++--
 kernel/trace/trace_output.c |  2 +-
 kernel/trace/trace_uprobe.c | 15 ++++++++++-----
 5 files changed, 35 insertions(+), 14 deletions(-)
---------------------------
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 91cd519756d3..2d17e6e364b5 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -30,6 +30,7 @@
 #include <linux/elf.h>
 #include <linux/moduleloader.h>
 #include <linux/completion.h>
+#include <linux/memory.h>
 #include <asm/cacheflush.h>
 #include "core.h"
 #include "patch.h"
@@ -730,16 +731,21 @@ static int klp_init_object_loaded(struct klp_patch *patch,
 	struct klp_func *func;
 	int ret;
 
+	mutex_lock(&text_mutex);
+
 	module_disable_ro(patch->mod);
 	ret = klp_write_object_relocations(patch->mod, obj);
 	if (ret) {
 		module_enable_ro(patch->mod, true);
+		mutex_unlock(&text_mutex);
 		return ret;
 	}
 
 	arch_klp_init_object_loaded(patch, obj);
 	module_enable_ro(patch->mod, true);
 
+	mutex_unlock(&text_mutex);
+
 	klp_for_each_func(obj, func) {
 		ret = klp_find_object_symbol(obj->name, func->old_name,
 					     func->old_sympos,
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index a12aff849c04..38277af44f5c 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -34,6 +34,7 @@
 #include <linux/hash.h>
 #include <linux/rcupdate.h>
 #include <linux/kprobes.h>
+#include <linux/memory.h>
 
 #include <trace/events/sched.h>
 
@@ -2610,10 +2611,12 @@ static void ftrace_run_update_code(int command)
 {
 	int ret;
 
+	mutex_lock(&text_mutex);
+
 	ret = ftrace_arch_code_modify_prepare();
 	FTRACE_WARN_ON(ret);
 	if (ret)
-		return;
+		goto out_unlock;
 
 	/*
 	 * By default we use stop_machine() to modify the code.
@@ -2625,6 +2628,9 @@ static void ftrace_run_update_code(int command)
 
 	ret = ftrace_arch_code_modify_post_process();
 	FTRACE_WARN_ON(ret);
+
+out_unlock:
+	mutex_unlock(&text_mutex);
 }
 
 static void ftrace_run_modify_code(struct ftrace_ops *ops, int command,
@@ -2935,14 +2941,13 @@ static int ftrace_update_code(struct module *mod, struct ftrace_page *new_pgs)
 			p = &pg->records[i];
 			p->flags = rec_flags;
 
-#ifndef CC_USING_NOP_MCOUNT
 			/*
 			 * Do the initial record conversion from mcount jump
 			 * to the NOP instructions.
 			 */
-			if (!ftrace_code_disable(mod, p))
+			if (!__is_defined(CC_USING_NOP_MCOUNT) &&
+			    !ftrace_code_disable(mod, p))
 				break;
-#endif
 
 			update_cnt++;
 		}
@@ -4221,10 +4226,13 @@ void free_ftrace_func_mapper(struct ftrace_func_mapper *mapper,
 	struct ftrace_func_entry *entry;
 	struct ftrace_func_map *map;
 	struct hlist_head *hhd;
-	int size = 1 << mapper->hash.size_bits;
-	int i;
+	int size, i;
+
+	if (!mapper)
+		return;
 
 	if (free_func && mapper->hash.count) {
+		size = 1 << mapper->hash.size_bits;
 		for (i = 0; i < size; i++) {
 			hhd = &mapper->hash.buckets[i];
 			hlist_for_each_entry(entry, hhd, hlist) {
@@ -5776,6 +5784,7 @@ void ftrace_module_enable(struct module *mod)
 	struct ftrace_page *pg;
 
 	mutex_lock(&ftrace_lock);
+	mutex_lock(&text_mutex);
 
 	if (ftrace_disabled)
 		goto out_unlock;
@@ -5837,6 +5846,7 @@ void ftrace_module_enable(struct module *mod)
 		ftrace_arch_code_modify_post_process();
 
  out_unlock:
+	mutex_unlock(&text_mutex);
 	mutex_unlock(&ftrace_lock);
 
 	process_cached_mods(mod->name);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1c80521fd436..83e08b78dbee 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6923,7 +6923,7 @@ struct tracing_log_err {
 
 static DEFINE_MUTEX(tracing_err_log_lock);
 
-struct tracing_log_err *get_tracing_log_err(struct trace_array *tr)
+static struct tracing_log_err *get_tracing_log_err(struct trace_array *tr)
 {
 	struct tracing_log_err *err;
 
@@ -8192,7 +8192,7 @@ static const struct file_operations buffer_percent_fops = {
 	.llseek		= default_llseek,
 };
 
-struct dentry *trace_instance_dir;
+static struct dentry *trace_instance_dir;
 
 static void
 init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer);
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 54373d93e251..ba751f993c3b 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1057,7 +1057,7 @@ static enum print_line_t trace_stack_print(struct trace_iterator *iter,
 
 	trace_seq_puts(s, "<stack trace>\n");
 
-	for (p = field->caller; p && *p != ULONG_MAX && p < end; p++) {
+	for (p = field->caller; p && p < end && *p != ULONG_MAX; p++) {
 
 		if (trace_seq_has_overflowed(s))
 			break;
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index eb7e06b54741..b55906c77ce0 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -426,8 +426,6 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
 /*
  * Argument syntax:
  *  - Add uprobe: p|r[:[GRP/]EVENT] PATH:OFFSET [FETCHARGS]
- *
- *  - Remove uprobe: -:[GRP/]EVENT
  */
 static int trace_uprobe_create(int argc, const char **argv)
 {
@@ -443,10 +441,17 @@ static int trace_uprobe_create(int argc, const char **argv)
 	ret = 0;
 	ref_ctr_offset = 0;
 
-	/* argc must be >= 1 */
-	if (argv[0][0] == 'r')
+	switch (argv[0][0]) {
+	case 'r':
 		is_return = true;
-	else if (argv[0][0] != 'p' || argc < 2)
+		break;
+	case 'p':
+		break;
+	default:
+		return -ECANCELED;
+	}
+
+	if (argc < 2)
 		return -ECANCELED;
 
 	if (argv[0][1] == ':')
