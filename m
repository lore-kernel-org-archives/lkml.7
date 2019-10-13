Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF20C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 19:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1AB20679
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 19:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbfJMTHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 15:07:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728481AbfJMTHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 15:07:07 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A09920679;
        Sun, 13 Oct 2019 19:07:05 +0000 (UTC)
Date:   Sun, 13 Oct 2019 15:07:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] tracing: Fixes for v5.4-rc2
Message-ID: <20191013150702.183320d9@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

A few tracing fixes:

 - Removed locked down from tracefs itself and moved it to the trace
   directory. Having the open functions there do the lockdown checks.

 - Fixed a few races with opening an instance file and the instance being
   deleted (Discovered during the locked down updates). Kept separate
   from the clean up code such that they can be backported to stable
   easier.

 - Cleaned up and consolidated the checks done when opening a trace
   file, as there were multiple checks that need to be done, and it
   did not make sense having them done in each open instance.

 - Fixed a regression in the record mcount code.

 - Small hw_lat detector tracer fixes.

 - A trace_pipe read fix due to not initializing trace_seq.


Please pull the latest trace-v5.4-rc2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.4-rc2

Tag SHA1: c79f12f50e68ee99f36c061f128b0a1411a96f5f
Head SHA1: d303de1fcf344ff7c15ed64c3f48a991c9958775


Petr Mladek (1):
      tracing: Initialize iter->seq after zeroing in tracing_read_pipe()

Srivatsa S. Bhat (VMware) (2):
      tracing/hwlat: Report total time spent in all NMIs during the sample
      tracing/hwlat: Don't ignore outer-loop duration when calculating max_latency

Steven Rostedt (VMware) (8):
      tracefs: Revert ccbd54ff54e8 ("tracefs: Restrict tracefs when the kernel is locked down")
      ftrace: Get a reference counter for the trace_array on filter files
      tracing: Get trace_array reference for available_tracers files
      tracing: Have trace events system open call tracing_open_generic_tr()
      tracing: Add tracing_check_open_get_tr()
      tracing: Add locked_down checks to the open calls of files created for tracefs
      tracing: Do not create tracefs files if tracefs lockdown is in effect
      recordmcount: Fix nop_mcount() function

----
 fs/tracefs/inode.c                  |  46 ++----------
 kernel/trace/ftrace.c               |  55 ++++++++++----
 kernel/trace/trace.c                | 139 ++++++++++++++++++++++--------------
 kernel/trace/trace.h                |   2 +
 kernel/trace/trace_dynevent.c       |   4 ++
 kernel/trace/trace_events.c         |  35 +++++----
 kernel/trace/trace_events_hist.c    |  13 +++-
 kernel/trace/trace_events_trigger.c |   8 ++-
 kernel/trace/trace_hwlat.c          |   4 +-
 kernel/trace/trace_kprobe.c         |  12 +++-
 kernel/trace/trace_printk.c         |   7 ++
 kernel/trace/trace_stack.c          |   8 +++
 kernel/trace/trace_stat.c           |   6 +-
 kernel/trace/trace_uprobe.c         |  11 +++
 scripts/recordmcount.h              |   5 +-
 15 files changed, 223 insertions(+), 132 deletions(-)
---------------------------
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 9fc14e38927f..0caa151cae4e 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -16,11 +16,11 @@
 #include <linux/namei.h>
 #include <linux/tracefs.h>
 #include <linux/fsnotify.h>
+#include <linux/security.h>
 #include <linux/seq_file.h>
 #include <linux/parser.h>
 #include <linux/magic.h>
 #include <linux/slab.h>
-#include <linux/security.h>
 
 #define TRACEFS_DEFAULT_MODE	0700
 
@@ -28,25 +28,6 @@ static struct vfsmount *tracefs_mount;
 static int tracefs_mount_count;
 static bool tracefs_registered;
 
-static int default_open_file(struct inode *inode, struct file *filp)
-{
-	struct dentry *dentry = filp->f_path.dentry;
-	struct file_operations *real_fops;
-	int ret;
-
-	if (!dentry)
-		return -EINVAL;
-
-	ret = security_locked_down(LOCKDOWN_TRACEFS);
-	if (ret)
-		return ret;
-
-	real_fops = dentry->d_fsdata;
-	if (!real_fops->open)
-		return 0;
-	return real_fops->open(inode, filp);
-}
-
 static ssize_t default_read_file(struct file *file, char __user *buf,
 				 size_t count, loff_t *ppos)
 {
@@ -241,12 +222,6 @@ static int tracefs_apply_options(struct super_block *sb)
 	return 0;
 }
 
-static void tracefs_destroy_inode(struct inode *inode)
-{
-	if (S_ISREG(inode->i_mode))
-		kfree(inode->i_fop);
-}
-
 static int tracefs_remount(struct super_block *sb, int *flags, char *data)
 {
 	int err;
@@ -283,7 +258,6 @@ static int tracefs_show_options(struct seq_file *m, struct dentry *root)
 static const struct super_operations tracefs_super_operations = {
 	.statfs		= simple_statfs,
 	.remount_fs	= tracefs_remount,
-	.destroy_inode  = tracefs_destroy_inode,
 	.show_options	= tracefs_show_options,
 };
 
@@ -414,10 +388,12 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
 				   struct dentry *parent, void *data,
 				   const struct file_operations *fops)
 {
-	struct file_operations *proxy_fops;
 	struct dentry *dentry;
 	struct inode *inode;
 
+	if (security_locked_down(LOCKDOWN_TRACEFS))
+		return NULL;
+
 	if (!(mode & S_IFMT))
 		mode |= S_IFREG;
 	BUG_ON(!S_ISREG(mode));
@@ -430,20 +406,8 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
 	if (unlikely(!inode))
 		return failed_creating(dentry);
 
-	proxy_fops = kzalloc(sizeof(struct file_operations), GFP_KERNEL);
-	if (unlikely(!proxy_fops)) {
-		iput(inode);
-		return failed_creating(dentry);
-	}
-
-	if (!fops)
-		fops = &tracefs_file_operations;
-
-	dentry->d_fsdata = (void *)fops;
-	memcpy(proxy_fops, fops, sizeof(*proxy_fops));
-	proxy_fops->open = default_open_file;
 	inode->i_mode = mode;
-	inode->i_fop = proxy_fops;
+	inode->i_fop = fops ? fops : &tracefs_file_operations;
 	inode->i_private = data;
 	d_instantiate(dentry, inode);
 	fsnotify_create(dentry->d_parent->d_inode, dentry);
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 62a50bf399d6..f296d89be757 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -18,6 +18,7 @@
 #include <linux/clocksource.h>
 #include <linux/sched/task.h>
 #include <linux/kallsyms.h>
+#include <linux/security.h>
 #include <linux/seq_file.h>
 #include <linux/tracefs.h>
 #include <linux/hardirq.h>
@@ -3486,6 +3487,11 @@ static int
 ftrace_avail_open(struct inode *inode, struct file *file)
 {
 	struct ftrace_iterator *iter;
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
 
 	if (unlikely(ftrace_disabled))
 		return -ENODEV;
@@ -3505,6 +3511,15 @@ ftrace_enabled_open(struct inode *inode, struct file *file)
 {
 	struct ftrace_iterator *iter;
 
+	/*
+	 * This shows us what functions are currently being
+	 * traced and by what. Not sure if we want lockdown
+	 * to hide such critical information for an admin.
+	 * Although, perhaps it can show information we don't
+	 * want people to see, but if something is tracing
+	 * something, we probably want to know about it.
+	 */
+
 	iter = __seq_open_private(file, &show_ftrace_seq_ops, sizeof(*iter));
 	if (!iter)
 		return -ENOMEM;
@@ -3540,21 +3555,22 @@ ftrace_regex_open(struct ftrace_ops *ops, int flag,
 	struct ftrace_hash *hash;
 	struct list_head *mod_head;
 	struct trace_array *tr = ops->private;
-	int ret = 0;
+	int ret = -ENOMEM;
 
 	ftrace_ops_init(ops);
 
 	if (unlikely(ftrace_disabled))
 		return -ENODEV;
 
+	if (tracing_check_open_get_tr(tr))
+		return -ENODEV;
+
 	iter = kzalloc(sizeof(*iter), GFP_KERNEL);
 	if (!iter)
-		return -ENOMEM;
+		goto out;
 
-	if (trace_parser_get_init(&iter->parser, FTRACE_BUFF_MAX)) {
-		kfree(iter);
-		return -ENOMEM;
-	}
+	if (trace_parser_get_init(&iter->parser, FTRACE_BUFF_MAX))
+		goto out;
 
 	iter->ops = ops;
 	iter->flags = flag;
@@ -3584,13 +3600,13 @@ ftrace_regex_open(struct ftrace_ops *ops, int flag,
 
 		if (!iter->hash) {
 			trace_parser_put(&iter->parser);
-			kfree(iter);
-			ret = -ENOMEM;
 			goto out_unlock;
 		}
 	} else
 		iter->hash = hash;
 
+	ret = 0;
+
 	if (file->f_mode & FMODE_READ) {
 		iter->pg = ftrace_pages_start;
 
@@ -3602,7 +3618,6 @@ ftrace_regex_open(struct ftrace_ops *ops, int flag,
 			/* Failed */
 			free_ftrace_hash(iter->hash);
 			trace_parser_put(&iter->parser);
-			kfree(iter);
 		}
 	} else
 		file->private_data = iter;
@@ -3610,6 +3625,13 @@ ftrace_regex_open(struct ftrace_ops *ops, int flag,
  out_unlock:
 	mutex_unlock(&ops->func_hash->regex_lock);
 
+ out:
+	if (ret) {
+		kfree(iter);
+		if (tr)
+			trace_array_put(tr);
+	}
+
 	return ret;
 }
 
@@ -3618,6 +3640,7 @@ ftrace_filter_open(struct inode *inode, struct file *file)
 {
 	struct ftrace_ops *ops = inode->i_private;
 
+	/* Checks for tracefs lockdown */
 	return ftrace_regex_open(ops,
 			FTRACE_ITER_FILTER | FTRACE_ITER_DO_PROBES,
 			inode, file);
@@ -3628,6 +3651,7 @@ ftrace_notrace_open(struct inode *inode, struct file *file)
 {
 	struct ftrace_ops *ops = inode->i_private;
 
+	/* Checks for tracefs lockdown */
 	return ftrace_regex_open(ops, FTRACE_ITER_NOTRACE,
 				 inode, file);
 }
@@ -5037,6 +5061,8 @@ int ftrace_regex_release(struct inode *inode, struct file *file)
 
 	mutex_unlock(&iter->ops->func_hash->regex_lock);
 	free_ftrace_hash(iter->hash);
+	if (iter->tr)
+		trace_array_put(iter->tr);
 	kfree(iter);
 
 	return 0;
@@ -5194,9 +5220,13 @@ static int
 __ftrace_graph_open(struct inode *inode, struct file *file,
 		    struct ftrace_graph_data *fgd)
 {
-	int ret = 0;
+	int ret;
 	struct ftrace_hash *new_hash = NULL;
 
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	if (file->f_mode & FMODE_WRITE) {
 		const int size_bits = FTRACE_HASH_DEFAULT_BITS;
 
@@ -6537,8 +6567,9 @@ ftrace_pid_open(struct inode *inode, struct file *file)
 	struct seq_file *m;
 	int ret = 0;
 
-	if (trace_array_get(tr) < 0)
-		return -ENODEV;
+	ret = tracing_check_open_get_tr(tr);
+	if (ret)
+		return ret;
 
 	if ((file->f_mode & FMODE_WRITE) &&
 	    (file->f_flags & O_TRUNC))
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 252f79c435f8..6a0ee9178365 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -17,6 +17,7 @@
 #include <linux/stacktrace.h>
 #include <linux/writeback.h>
 #include <linux/kallsyms.h>
+#include <linux/security.h>
 #include <linux/seq_file.h>
 #include <linux/notifier.h>
 #include <linux/irqflags.h>
@@ -304,6 +305,23 @@ void trace_array_put(struct trace_array *this_tr)
 	mutex_unlock(&trace_types_lock);
 }
 
+int tracing_check_open_get_tr(struct trace_array *tr)
+{
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
+	if (tracing_disabled)
+		return -ENODEV;
+
+	if (tr && trace_array_get(tr) < 0)
+		return -ENODEV;
+
+	return 0;
+}
+
 int call_filter_check_discard(struct trace_event_call *call, void *rec,
 			      struct ring_buffer *buffer,
 			      struct ring_buffer_event *event)
@@ -4140,8 +4158,11 @@ __tracing_open(struct inode *inode, struct file *file, bool snapshot)
 
 int tracing_open_generic(struct inode *inode, struct file *filp)
 {
-	if (tracing_disabled)
-		return -ENODEV;
+	int ret;
+
+	ret = tracing_check_open_get_tr(NULL);
+	if (ret)
+		return ret;
 
 	filp->private_data = inode->i_private;
 	return 0;
@@ -4156,15 +4177,14 @@ bool tracing_is_disabled(void)
  * Open and update trace_array ref count.
  * Must have the current trace_array passed to it.
  */
-static int tracing_open_generic_tr(struct inode *inode, struct file *filp)
+int tracing_open_generic_tr(struct inode *inode, struct file *filp)
 {
 	struct trace_array *tr = inode->i_private;
+	int ret;
 
-	if (tracing_disabled)
-		return -ENODEV;
-
-	if (trace_array_get(tr) < 0)
-		return -ENODEV;
+	ret = tracing_check_open_get_tr(tr);
+	if (ret)
+		return ret;
 
 	filp->private_data = inode->i_private;
 
@@ -4233,10 +4253,11 @@ static int tracing_open(struct inode *inode, struct file *file)
 {
 	struct trace_array *tr = inode->i_private;
 	struct trace_iterator *iter;
-	int ret = 0;
+	int ret;
 
-	if (trace_array_get(tr) < 0)
-		return -ENODEV;
+	ret = tracing_check_open_get_tr(tr);
+	if (ret)
+		return ret;
 
 	/* If this file was open for write, then erase contents */
 	if ((file->f_mode & FMODE_WRITE) && (file->f_flags & O_TRUNC)) {
@@ -4352,12 +4373,15 @@ static int show_traces_open(struct inode *inode, struct file *file)
 	struct seq_file *m;
 	int ret;
 
-	if (tracing_disabled)
-		return -ENODEV;
+	ret = tracing_check_open_get_tr(tr);
+	if (ret)
+		return ret;
 
 	ret = seq_open(file, &show_traces_seq_ops);
-	if (ret)
+	if (ret) {
+		trace_array_put(tr);
 		return ret;
+	}
 
 	m = file->private_data;
 	m->private = tr;
@@ -4365,6 +4389,14 @@ static int show_traces_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static int show_traces_release(struct inode *inode, struct file *file)
+{
+	struct trace_array *tr = inode->i_private;
+
+	trace_array_put(tr);
+	return seq_release(inode, file);
+}
+
 static ssize_t
 tracing_write_stub(struct file *filp, const char __user *ubuf,
 		   size_t count, loff_t *ppos)
@@ -4395,8 +4427,8 @@ static const struct file_operations tracing_fops = {
 static const struct file_operations show_traces_fops = {
 	.open		= show_traces_open,
 	.read		= seq_read,
-	.release	= seq_release,
 	.llseek		= seq_lseek,
+	.release	= show_traces_release,
 };
 
 static ssize_t
@@ -4697,11 +4729,9 @@ static int tracing_trace_options_open(struct inode *inode, struct file *file)
 	struct trace_array *tr = inode->i_private;
 	int ret;
 
-	if (tracing_disabled)
-		return -ENODEV;
-
-	if (trace_array_get(tr) < 0)
-		return -ENODEV;
+	ret = tracing_check_open_get_tr(tr);
+	if (ret)
+		return ret;
 
 	ret = single_open(file, tracing_trace_options_show, inode->i_private);
 	if (ret < 0)
@@ -5038,8 +5068,11 @@ static const struct seq_operations tracing_saved_tgids_seq_ops = {
 
 static int tracing_saved_tgids_open(struct inode *inode, struct file *filp)
 {
-	if (tracing_disabled)
-		return -ENODEV;
+	int ret;
+
+	ret = tracing_check_open_get_tr(NULL);
+	if (ret)
+		return ret;
 
 	return seq_open(filp, &tracing_saved_tgids_seq_ops);
 }
@@ -5115,8 +5148,11 @@ static const struct seq_operations tracing_saved_cmdlines_seq_ops = {
 
 static int tracing_saved_cmdlines_open(struct inode *inode, struct file *filp)
 {
-	if (tracing_disabled)
-		return -ENODEV;
+	int ret;
+
+	ret = tracing_check_open_get_tr(NULL);
+	if (ret)
+		return ret;
 
 	return seq_open(filp, &tracing_saved_cmdlines_seq_ops);
 }
@@ -5280,8 +5316,11 @@ static const struct seq_operations tracing_eval_map_seq_ops = {
 
 static int tracing_eval_map_open(struct inode *inode, struct file *filp)
 {
-	if (tracing_disabled)
-		return -ENODEV;
+	int ret;
+
+	ret = tracing_check_open_get_tr(NULL);
+	if (ret)
+		return ret;
 
 	return seq_open(filp, &tracing_eval_map_seq_ops);
 }
@@ -5804,13 +5843,11 @@ static int tracing_open_pipe(struct inode *inode, struct file *filp)
 {
 	struct trace_array *tr = inode->i_private;
 	struct trace_iterator *iter;
-	int ret = 0;
-
-	if (tracing_disabled)
-		return -ENODEV;
+	int ret;
 
-	if (trace_array_get(tr) < 0)
-		return -ENODEV;
+	ret = tracing_check_open_get_tr(tr);
+	if (ret)
+		return ret;
 
 	mutex_lock(&trace_types_lock);
 
@@ -5999,6 +6036,7 @@ tracing_read_pipe(struct file *filp, char __user *ubuf,
 	       sizeof(struct trace_iterator) -
 	       offsetof(struct trace_iterator, seq));
 	cpumask_clear(iter->started);
+	trace_seq_init(&iter->seq);
 	iter->pos = -1;
 
 	trace_event_read_lock();
@@ -6547,11 +6585,9 @@ static int tracing_clock_open(struct inode *inode, struct file *file)
 	struct trace_array *tr = inode->i_private;
 	int ret;
 
-	if (tracing_disabled)
-		return -ENODEV;
-
-	if (trace_array_get(tr))
-		return -ENODEV;
+	ret = tracing_check_open_get_tr(tr);
+	if (ret)
+		return ret;
 
 	ret = single_open(file, tracing_clock_show, inode->i_private);
 	if (ret < 0)
@@ -6581,11 +6617,9 @@ static int tracing_time_stamp_mode_open(struct inode *inode, struct file *file)
 	struct trace_array *tr = inode->i_private;
 	int ret;
 
-	if (tracing_disabled)
-		return -ENODEV;
-
-	if (trace_array_get(tr))
-		return -ENODEV;
+	ret = tracing_check_open_get_tr(tr);
+	if (ret)
+		return ret;
 
 	ret = single_open(file, tracing_time_stamp_mode_show, inode->i_private);
 	if (ret < 0)
@@ -6638,10 +6672,11 @@ static int tracing_snapshot_open(struct inode *inode, struct file *file)
 	struct trace_array *tr = inode->i_private;
 	struct trace_iterator *iter;
 	struct seq_file *m;
-	int ret = 0;
+	int ret;
 
-	if (trace_array_get(tr) < 0)
-		return -ENODEV;
+	ret = tracing_check_open_get_tr(tr);
+	if (ret)
+		return ret;
 
 	if (file->f_mode & FMODE_READ) {
 		iter = __tracing_open(inode, file, true);
@@ -6786,6 +6821,7 @@ static int snapshot_raw_open(struct inode *inode, struct file *filp)
 	struct ftrace_buffer_info *info;
 	int ret;
 
+	/* The following checks for tracefs lockdown */
 	ret = tracing_buffers_open(inode, filp);
 	if (ret < 0)
 		return ret;
@@ -7105,8 +7141,9 @@ static int tracing_err_log_open(struct inode *inode, struct file *file)
 	struct trace_array *tr = inode->i_private;
 	int ret = 0;
 
-	if (trace_array_get(tr) < 0)
-		return -ENODEV;
+	ret = tracing_check_open_get_tr(tr);
+	if (ret)
+		return ret;
 
 	/* If this file was opened for write, then erase contents */
 	if ((file->f_mode & FMODE_WRITE) && (file->f_flags & O_TRUNC))
@@ -7157,11 +7194,9 @@ static int tracing_buffers_open(struct inode *inode, struct file *filp)
 	struct ftrace_buffer_info *info;
 	int ret;
 
-	if (tracing_disabled)
-		return -ENODEV;
-
-	if (trace_array_get(tr) < 0)
-		return -ENODEV;
+	ret = tracing_check_open_get_tr(tr);
+	if (ret)
+		return ret;
 
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info) {
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index f801d154ff6a..d685c61085c0 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -338,6 +338,7 @@ extern struct mutex trace_types_lock;
 
 extern int trace_array_get(struct trace_array *tr);
 extern void trace_array_put(struct trace_array *tr);
+extern int tracing_check_open_get_tr(struct trace_array *tr);
 
 extern int tracing_set_time_stamp_abs(struct trace_array *tr, bool abs);
 extern int tracing_set_clock(struct trace_array *tr, const char *clockstr);
@@ -681,6 +682,7 @@ void tracing_reset_online_cpus(struct trace_buffer *buf);
 void tracing_reset_current(int cpu);
 void tracing_reset_all_online_cpus(void);
 int tracing_open_generic(struct inode *inode, struct file *filp);
+int tracing_open_generic_tr(struct inode *inode, struct file *filp);
 bool tracing_is_disabled(void);
 bool tracer_tracing_is_on(struct trace_array *tr);
 void tracer_tracing_on(struct trace_array *tr);
diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index a41fed46c285..89779eb84a07 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -174,6 +174,10 @@ static int dyn_event_open(struct inode *inode, struct file *file)
 {
 	int ret;
 
+	ret = tracing_check_open_get_tr(NULL);
+	if (ret)
+		return ret;
+
 	if ((file->f_mode & FMODE_WRITE) && (file->f_flags & O_TRUNC)) {
 		ret = dyn_events_release_all(NULL);
 		if (ret < 0)
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index b89cdfe20bc1..fba87d10f0c1 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -12,6 +12,7 @@
 #define pr_fmt(fmt) fmt
 
 #include <linux/workqueue.h>
+#include <linux/security.h>
 #include <linux/spinlock.h>
 #include <linux/kthread.h>
 #include <linux/tracefs.h>
@@ -1294,6 +1295,8 @@ static int trace_format_open(struct inode *inode, struct file *file)
 	struct seq_file *m;
 	int ret;
 
+	/* Do we want to hide event format files on tracefs lockdown? */
+
 	ret = seq_open(file, &trace_format_seq_ops);
 	if (ret < 0)
 		return ret;
@@ -1440,28 +1443,17 @@ static int system_tr_open(struct inode *inode, struct file *filp)
 	struct trace_array *tr = inode->i_private;
 	int ret;
 
-	if (tracing_is_disabled())
-		return -ENODEV;
-
-	if (trace_array_get(tr) < 0)
-		return -ENODEV;
-
 	/* Make a temporary dir that has no system but points to tr */
 	dir = kzalloc(sizeof(*dir), GFP_KERNEL);
-	if (!dir) {
-		trace_array_put(tr);
+	if (!dir)
 		return -ENOMEM;
-	}
 
-	dir->tr = tr;
-
-	ret = tracing_open_generic(inode, filp);
+	ret = tracing_open_generic_tr(inode, filp);
 	if (ret < 0) {
-		trace_array_put(tr);
 		kfree(dir);
 		return ret;
 	}
-
+	dir->tr = tr;
 	filp->private_data = dir;
 
 	return 0;
@@ -1771,6 +1763,10 @@ ftrace_event_open(struct inode *inode, struct file *file,
 	struct seq_file *m;
 	int ret;
 
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	ret = seq_open(file, seq_ops);
 	if (ret < 0)
 		return ret;
@@ -1795,6 +1791,7 @@ ftrace_event_avail_open(struct inode *inode, struct file *file)
 {
 	const struct seq_operations *seq_ops = &show_event_seq_ops;
 
+	/* Checks for tracefs lockdown */
 	return ftrace_event_open(inode, file, seq_ops);
 }
 
@@ -1805,8 +1802,9 @@ ftrace_event_set_open(struct inode *inode, struct file *file)
 	struct trace_array *tr = inode->i_private;
 	int ret;
 
-	if (trace_array_get(tr) < 0)
-		return -ENODEV;
+	ret = tracing_check_open_get_tr(tr);
+	if (ret)
+		return ret;
 
 	if ((file->f_mode & FMODE_WRITE) &&
 	    (file->f_flags & O_TRUNC))
@@ -1825,8 +1823,9 @@ ftrace_event_set_pid_open(struct inode *inode, struct file *file)
 	struct trace_array *tr = inode->i_private;
 	int ret;
 
-	if (trace_array_get(tr) < 0)
-		return -ENODEV;
+	ret = tracing_check_open_get_tr(tr);
+	if (ret)
+		return ret;
 
 	if ((file->f_mode & FMODE_WRITE) &&
 	    (file->f_flags & O_TRUNC))
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 9468bd8d44a2..57648c5aa679 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -7,6 +7,7 @@
 
 #include <linux/module.h>
 #include <linux/kallsyms.h>
+#include <linux/security.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/stacktrace.h>
@@ -1448,6 +1449,10 @@ static int synth_events_open(struct inode *inode, struct file *file)
 {
 	int ret;
 
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	if ((file->f_mode & FMODE_WRITE) && (file->f_flags & O_TRUNC)) {
 		ret = dyn_events_release_all(&synth_event_ops);
 		if (ret < 0)
@@ -1680,7 +1685,7 @@ static int save_hist_vars(struct hist_trigger_data *hist_data)
 	if (var_data)
 		return 0;
 
-	if (trace_array_get(tr) < 0)
+	if (tracing_check_open_get_tr(tr))
 		return -ENODEV;
 
 	var_data = kzalloc(sizeof(*var_data), GFP_KERNEL);
@@ -5515,6 +5520,12 @@ static int hist_show(struct seq_file *m, void *v)
 
 static int event_hist_open(struct inode *inode, struct file *file)
 {
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	return single_open(file, hist_show, file);
 }
 
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 2a2912cb4533..2cd53ca21b51 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2013 Tom Zanussi <tom.zanussi@linux.intel.com>
  */
 
+#include <linux/security.h>
 #include <linux/module.h>
 #include <linux/ctype.h>
 #include <linux/mutex.h>
@@ -173,7 +174,11 @@ static const struct seq_operations event_triggers_seq_ops = {
 
 static int event_trigger_regex_open(struct inode *inode, struct file *file)
 {
-	int ret = 0;
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
 
 	mutex_lock(&event_mutex);
 
@@ -292,6 +297,7 @@ event_trigger_write(struct file *filp, const char __user *ubuf,
 static int
 event_trigger_open(struct inode *inode, struct file *filp)
 {
+	/* Checks for tracefs lockdown */
 	return event_trigger_regex_open(inode, filp);
 }
 
diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index fa95139445b2..862f4b0139fc 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -150,7 +150,7 @@ void trace_hwlat_callback(bool enter)
 		if (enter)
 			nmi_ts_start = time_get();
 		else
-			nmi_total_ts = time_get() - nmi_ts_start;
+			nmi_total_ts += time_get() - nmi_ts_start;
 	}
 
 	if (enter)
@@ -256,6 +256,8 @@ static int get_sample(void)
 		/* Keep a running maximum ever recorded hardware latency */
 		if (sample > tr->max_latency)
 			tr->max_latency = sample;
+		if (outer_sample > tr->max_latency)
+			tr->max_latency = outer_sample;
 	}
 
 out:
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 324ffbea3556..1552a95c743b 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -7,11 +7,11 @@
  */
 #define pr_fmt(fmt)	"trace_kprobe: " fmt
 
+#include <linux/security.h>
 #include <linux/module.h>
 #include <linux/uaccess.h>
 #include <linux/rculist.h>
 #include <linux/error-injection.h>
-#include <linux/security.h>
 
 #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
 
@@ -936,6 +936,10 @@ static int probes_open(struct inode *inode, struct file *file)
 {
 	int ret;
 
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	if ((file->f_mode & FMODE_WRITE) && (file->f_flags & O_TRUNC)) {
 		ret = dyn_events_release_all(&trace_kprobe_ops);
 		if (ret < 0)
@@ -988,6 +992,12 @@ static const struct seq_operations profile_seq_op = {
 
 static int profile_open(struct inode *inode, struct file *file)
 {
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	return seq_open(file, &profile_seq_op);
 }
 
diff --git a/kernel/trace/trace_printk.c b/kernel/trace/trace_printk.c
index c3fd849d4a8f..d4e31e969206 100644
--- a/kernel/trace/trace_printk.c
+++ b/kernel/trace/trace_printk.c
@@ -6,6 +6,7 @@
  *
  */
 #include <linux/seq_file.h>
+#include <linux/security.h>
 #include <linux/uaccess.h>
 #include <linux/kernel.h>
 #include <linux/ftrace.h>
@@ -348,6 +349,12 @@ static const struct seq_operations show_format_seq_ops = {
 static int
 ftrace_formats_open(struct inode *inode, struct file *file)
 {
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	return seq_open(file, &show_format_seq_ops);
 }
 
diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index ec9a34a97129..4df9a209f7ca 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -5,6 +5,7 @@
  */
 #include <linux/sched/task_stack.h>
 #include <linux/stacktrace.h>
+#include <linux/security.h>
 #include <linux/kallsyms.h>
 #include <linux/seq_file.h>
 #include <linux/spinlock.h>
@@ -470,6 +471,12 @@ static const struct seq_operations stack_trace_seq_ops = {
 
 static int stack_trace_open(struct inode *inode, struct file *file)
 {
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	return seq_open(file, &stack_trace_seq_ops);
 }
 
@@ -487,6 +494,7 @@ stack_trace_filter_open(struct inode *inode, struct file *file)
 {
 	struct ftrace_ops *ops = inode->i_private;
 
+	/* Checks for tracefs lockdown */
 	return ftrace_regex_open(ops, FTRACE_ITER_FILTER,
 				 inode, file);
 }
diff --git a/kernel/trace/trace_stat.c b/kernel/trace/trace_stat.c
index 75bf1bcb4a8a..9ab0a1a7ad5e 100644
--- a/kernel/trace/trace_stat.c
+++ b/kernel/trace/trace_stat.c
@@ -9,7 +9,7 @@
  *
  */
 
-
+#include <linux/security.h>
 #include <linux/list.h>
 #include <linux/slab.h>
 #include <linux/rbtree.h>
@@ -238,6 +238,10 @@ static int tracing_stat_open(struct inode *inode, struct file *file)
 	struct seq_file *m;
 	struct stat_session *session = inode->i_private;
 
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	ret = stat_seq_init(session);
 	if (ret)
 		return ret;
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index dd884341f5c5..352073d36585 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -7,6 +7,7 @@
  */
 #define pr_fmt(fmt)	"trace_uprobe: " fmt
 
+#include <linux/security.h>
 #include <linux/ctype.h>
 #include <linux/module.h>
 #include <linux/uaccess.h>
@@ -769,6 +770,10 @@ static int probes_open(struct inode *inode, struct file *file)
 {
 	int ret;
 
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	if ((file->f_mode & FMODE_WRITE) && (file->f_flags & O_TRUNC)) {
 		ret = dyn_events_release_all(&trace_uprobe_ops);
 		if (ret)
@@ -818,6 +823,12 @@ static const struct seq_operations profile_seq_op = {
 
 static int profile_open(struct inode *inode, struct file *file)
 {
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	return seq_open(file, &profile_seq_op);
 }
 
diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
index 8f0a278ce0af..74eab03e31d4 100644
--- a/scripts/recordmcount.h
+++ b/scripts/recordmcount.h
@@ -389,11 +389,8 @@ static int nop_mcount(Elf_Shdr const *const relhdr,
 			mcountsym = get_mcountsym(sym0, relp, str0);
 
 		if (mcountsym == Elf_r_sym(relp) && !is_fake_mcount(relp)) {
-			if (make_nop) {
+			if (make_nop)
 				ret = make_nop((void *)ehdr, _w(shdr->sh_offset) + _w(relp->r_offset));
-				if (ret < 0)
-					return -1;
-			}
 			if (warn_on_notrace_sect && !once) {
 				printf("Section %s has mcount callers being ignored\n",
 				       txtname);
