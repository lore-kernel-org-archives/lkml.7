Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6A0C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91321208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfDZPyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:54:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726176AbfDZPyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:54:00 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01C902077B;
        Fri, 26 Apr 2019 15:53:58 +0000 (UTC)
Date:   Fri, 26 Apr 2019 11:53:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] tracing: Minor fixes
Message-ID: <20190426115357.3ef86b4a@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

There tracing fixes:

 - Use "nosteal" for ring buffer splice pages
 - Memory leak fix in error path of trace_pid_write()
 - Fix preempt_enable_no_resched() (use preempt_enable()) in ring buffer code


Please pull the latest trace-v5.1-rc6 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.1-rc6

Tag SHA1: 18d3b6ef227e69c4620f9ac687bd5200ce5169bc
Head SHA1: d6097c9e4454adf1f8f2c9547c2fa6060d55d952


Jann Horn (1):
      tracing: Fix buffer_ref pipe ops

Peter Zijlstra (1):
      trace: Fix preempt_enable_no_resched() abuse

Wenwen Wang (1):
      tracing: Fix a memory leak by early error exit in trace_pid_write()

----
 fs/splice.c                |  4 ++--
 include/linux/pipe_fs_i.h  |  1 +
 kernel/trace/ring_buffer.c |  2 +-
 kernel/trace/trace.c       | 33 ++++++++++++++++++---------------
 4 files changed, 22 insertions(+), 18 deletions(-)
---------------------------
diff --git a/fs/splice.c b/fs/splice.c
index 3ee7e82df48f..e75807380caa 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -330,8 +330,8 @@ const struct pipe_buf_operations default_pipe_buf_ops = {
 	.get = generic_pipe_buf_get,
 };
 
-static int generic_pipe_buf_nosteal(struct pipe_inode_info *pipe,
-				    struct pipe_buffer *buf)
+int generic_pipe_buf_nosteal(struct pipe_inode_info *pipe,
+			     struct pipe_buffer *buf)
 {
 	return 1;
 }
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 787d224ff43e..a830e9a00eb9 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -174,6 +174,7 @@ void free_pipe_info(struct pipe_inode_info *);
 void generic_pipe_buf_get(struct pipe_inode_info *, struct pipe_buffer *);
 int generic_pipe_buf_confirm(struct pipe_inode_info *, struct pipe_buffer *);
 int generic_pipe_buf_steal(struct pipe_inode_info *, struct pipe_buffer *);
+int generic_pipe_buf_nosteal(struct pipe_inode_info *, struct pipe_buffer *);
 void generic_pipe_buf_release(struct pipe_inode_info *, struct pipe_buffer *);
 void pipe_buf_mark_unmergeable(struct pipe_buffer *buf);
 
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 41b6f96e5366..4ee8d8aa3d0f 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -762,7 +762,7 @@ u64 ring_buffer_time_stamp(struct ring_buffer *buffer, int cpu)
 
 	preempt_disable_notrace();
 	time = rb_time_stamp(buffer);
-	preempt_enable_no_resched_notrace();
+	preempt_enable_notrace();
 
 	return time;
 }
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 21153e64bf1c..46f68fad6373 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -496,8 +496,10 @@ int trace_pid_write(struct trace_pid_list *filtered_pids,
 	 * not modified.
 	 */
 	pid_list = kmalloc(sizeof(*pid_list), GFP_KERNEL);
-	if (!pid_list)
+	if (!pid_list) {
+		trace_parser_put(&parser);
 		return -ENOMEM;
+	}
 
 	pid_list->pid_max = READ_ONCE(pid_max);
 
@@ -507,6 +509,7 @@ int trace_pid_write(struct trace_pid_list *filtered_pids,
 
 	pid_list->pids = vzalloc((pid_list->pid_max + 7) >> 3);
 	if (!pid_list->pids) {
+		trace_parser_put(&parser);
 		kfree(pid_list);
 		return -ENOMEM;
 	}
@@ -7025,19 +7028,23 @@ struct buffer_ref {
 	struct ring_buffer	*buffer;
 	void			*page;
 	int			cpu;
-	int			ref;
+	refcount_t		refcount;
 };
 
+static void buffer_ref_release(struct buffer_ref *ref)
+{
+	if (!refcount_dec_and_test(&ref->refcount))
+		return;
+	ring_buffer_free_read_page(ref->buffer, ref->cpu, ref->page);
+	kfree(ref);
+}
+
 static void buffer_pipe_buf_release(struct pipe_inode_info *pipe,
 				    struct pipe_buffer *buf)
 {
 	struct buffer_ref *ref = (struct buffer_ref *)buf->private;
 
-	if (--ref->ref)
-		return;
-
-	ring_buffer_free_read_page(ref->buffer, ref->cpu, ref->page);
-	kfree(ref);
+	buffer_ref_release(ref);
 	buf->private = 0;
 }
 
@@ -7046,14 +7053,14 @@ static void buffer_pipe_buf_get(struct pipe_inode_info *pipe,
 {
 	struct buffer_ref *ref = (struct buffer_ref *)buf->private;
 
-	ref->ref++;
+	refcount_inc(&ref->refcount);
 }
 
 /* Pipe buffer operations for a buffer. */
 static const struct pipe_buf_operations buffer_pipe_buf_ops = {
 	.confirm		= generic_pipe_buf_confirm,
 	.release		= buffer_pipe_buf_release,
-	.steal			= generic_pipe_buf_steal,
+	.steal			= generic_pipe_buf_nosteal,
 	.get			= buffer_pipe_buf_get,
 };
 
@@ -7066,11 +7073,7 @@ static void buffer_spd_release(struct splice_pipe_desc *spd, unsigned int i)
 	struct buffer_ref *ref =
 		(struct buffer_ref *)spd->partial[i].private;
 
-	if (--ref->ref)
-		return;
-
-	ring_buffer_free_read_page(ref->buffer, ref->cpu, ref->page);
-	kfree(ref);
+	buffer_ref_release(ref);
 	spd->partial[i].private = 0;
 }
 
@@ -7125,7 +7128,7 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 			break;
 		}
 
-		ref->ref = 1;
+		refcount_set(&ref->refcount, 1);
 		ref->buffer = iter->trace_buffer->buffer;
 		ref->page = ring_buffer_alloc_read_page(ref->buffer, iter->cpu_file);
 		if (IS_ERR(ref->page)) {
