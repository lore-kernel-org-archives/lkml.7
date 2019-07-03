Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDC0C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ABE321882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfGCOzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:55:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:47208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfGCOzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:55:14 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2ED3121882;
        Wed,  3 Jul 2019 14:55:13 +0000 (UTC)
Date:   Wed, 3 Jul 2019 10:55:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] tracing: A few fixes for this rc release
Message-ID: <20190703105511.263ffd56@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

This includes three fixes:

 - Fixes a deadlock from a previous fix to keep module loading
   and function tracing text modifications from stepping on each other.
   (this has a few patches to help document the issue in comments)

 - Fix a crash when the snapshot buffer gets out of sync with the
   main ring buffer.

 - Fix a memory leak when reading the memory logs


Please pull the latest trace-v5.2-rc5 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.2-rc5

Tag SHA1: e2d01e8f26e849e0e45742a46727ba0da8af7c55
Head SHA1: 074376ac0e1d1fcd4fafebca86ee6158e7c20680


Eiichi Tsukata (1):
      tracing/snapshot: Resize spare buffer if size changed

Jiri Kosina (1):
      ftrace/x86: Anotate text_mutex split between ftrace_arch_code_modify_post_process() and ftrace_arch_code_modify_prepare()

Petr Mladek (1):
      ftrace/x86: Remove possible deadlock between register_kprobe() and ftrace_run_update_code()

Steven Rostedt (VMware) (1):
      ftrace/x86: Add a comment to why we take text_mutex in ftrace_arch_code_modify_prepare()

Takeshi Misawa (1):
      tracing: Fix memory leak in tracing_err_log_open()

----
 arch/x86/kernel/ftrace.c | 10 ++++++++++
 kernel/trace/ftrace.c    | 10 +---------
 kernel/trace/trace.c     | 24 +++++++++++++++++++-----
 3 files changed, 30 insertions(+), 14 deletions(-)
---------------------------
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 0927bb158ffc..76228525acd0 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -22,6 +22,7 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/module.h>
+#include <linux/memory.h>
 
 #include <trace/syscall.h>
 
@@ -34,16 +35,25 @@
 #ifdef CONFIG_DYNAMIC_FTRACE
 
 int ftrace_arch_code_modify_prepare(void)
+    __acquires(&text_mutex)
 {
+	/*
+	 * Need to grab text_mutex to prevent a race from module loading
+	 * and live kernel patching from changing the text permissions while
+	 * ftrace has it set to "read/write".
+	 */
+	mutex_lock(&text_mutex);
 	set_kernel_text_rw();
 	set_all_modules_text_rw();
 	return 0;
 }
 
 int ftrace_arch_code_modify_post_process(void)
+    __releases(&text_mutex)
 {
 	set_all_modules_text_ro();
 	set_kernel_text_ro();
+	mutex_unlock(&text_mutex);
 	return 0;
 }
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 38277af44f5c..576c41644e77 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -34,7 +34,6 @@
 #include <linux/hash.h>
 #include <linux/rcupdate.h>
 #include <linux/kprobes.h>
-#include <linux/memory.h>
 
 #include <trace/events/sched.h>
 
@@ -2611,12 +2610,10 @@ static void ftrace_run_update_code(int command)
 {
 	int ret;
 
-	mutex_lock(&text_mutex);
-
 	ret = ftrace_arch_code_modify_prepare();
 	FTRACE_WARN_ON(ret);
 	if (ret)
-		goto out_unlock;
+		return;
 
 	/*
 	 * By default we use stop_machine() to modify the code.
@@ -2628,9 +2625,6 @@ static void ftrace_run_update_code(int command)
 
 	ret = ftrace_arch_code_modify_post_process();
 	FTRACE_WARN_ON(ret);
-
-out_unlock:
-	mutex_unlock(&text_mutex);
 }
 
 static void ftrace_run_modify_code(struct ftrace_ops *ops, int command,
@@ -5784,7 +5778,6 @@ void ftrace_module_enable(struct module *mod)
 	struct ftrace_page *pg;
 
 	mutex_lock(&ftrace_lock);
-	mutex_lock(&text_mutex);
 
 	if (ftrace_disabled)
 		goto out_unlock;
@@ -5846,7 +5839,6 @@ void ftrace_module_enable(struct module *mod)
 		ftrace_arch_code_modify_post_process();
 
  out_unlock:
-	mutex_unlock(&text_mutex);
 	mutex_unlock(&ftrace_lock);
 
 	process_cached_mods(mod->name);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 83e08b78dbee..c3aabb576fe5 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6719,11 +6719,13 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
 			break;
 		}
 #endif
-		if (!tr->allocated_snapshot) {
+		if (tr->allocated_snapshot)
+			ret = resize_buffer_duplicate_size(&tr->max_buffer,
+					&tr->trace_buffer, iter->cpu_file);
+		else
 			ret = tracing_alloc_snapshot_instance(tr);
-			if (ret < 0)
-				break;
-		}
+		if (ret < 0)
+			break;
 		local_irq_disable();
 		/* Now, we're going to swap */
 		if (iter->cpu_file == RING_BUFFER_ALL_CPUS)
@@ -7126,12 +7128,24 @@ static ssize_t tracing_err_log_write(struct file *file,
 	return count;
 }
 
+static int tracing_err_log_release(struct inode *inode, struct file *file)
+{
+	struct trace_array *tr = inode->i_private;
+
+	trace_array_put(tr);
+
+	if (file->f_mode & FMODE_READ)
+		seq_release(inode, file);
+
+	return 0;
+}
+
 static const struct file_operations tracing_err_log_fops = {
 	.open           = tracing_err_log_open,
 	.write		= tracing_err_log_write,
 	.read           = seq_read,
 	.llseek         = seq_lseek,
-	.release	= tracing_release_generic_tr,
+	.release        = tracing_err_log_release,
 };
 
 static int tracing_buffers_open(struct inode *inode, struct file *filp)
