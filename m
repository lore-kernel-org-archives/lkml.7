Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1FFC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6223D20882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368082;
	bh=u72A8cBaNpYyedVBgFYuD2kxUKN/xp1FQq6Aryct6sQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GOM/H319kkzlpZloAi6a75gFLf7wjYqGzFufQqlroVBkCOohwFm7C6VvxKwEDZ63P
	 9HK5mgTuOQ/uPsCjkDCV2o1NxPnFIhLrN2Q2WHEVYtIKFoQAVJnoibt/jTffu112aj
	 ZiB263ePu8l4E2YdgKPCgLFQ4386aCGXQhR2WBh0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbfDDIyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:54:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730053AbfDDIyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:54:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9478F217D4;
        Thu,  4 Apr 2019 08:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368071;
        bh=u72A8cBaNpYyedVBgFYuD2kxUKN/xp1FQq6Aryct6sQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0ko5QDf6NlrSKeAgEXeNUmH2QTJ2PWnBAYK70Vt5uoWxrTV7/OxPz/5KRo4z38pP2
         xtUv5HuHR2QcMv35QETakMHHyvZ3y9TiDhdEjK+M7CNp+RTRLGaebrO8gsMTkoC6RR
         HhWcePKDQ5rNWLjuTiy30vVq1U6VJfLxalm4mGOE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 010/121] tracing: kdb: Fix ftdump to not sleep
Date:   Thu,  4 Apr 2019 10:46:38 +0200
Message-Id: <20190404084545.856754972@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084545.245659903@linuxfoundation.org>
References: <20190404084545.245659903@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 31b265b3baaf55f209229888b7ffea523ddab366 ]

As reported back in 2016-11 [1], the "ftdump" kdb command triggers a
BUG for "sleeping function called from invalid context".

kdb's "ftdump" command wants to call ring_buffer_read_prepare() in
atomic context.  A very simple solution for this is to add allocation
flags to ring_buffer_read_prepare() so kdb can call it without
triggering the allocation error.  This patch does that.

Note that in the original email thread about this, it was suggested
that perhaps the solution for kdb was to either preallocate the buffer
ahead of time or create our own iterator.  I'm hoping that this
alternative of adding allocation flags to ring_buffer_read_prepare()
can be considered since it means I don't need to duplicate more of the
core trace code into "trace_kdb.c" (for either creating my own
iterator or re-preparing a ring allocator whose memory was already
allocated).

NOTE: another option for kdb is to actually figure out how to make it
reuse the existing ftrace_dump() function and totally eliminate the
duplication.  This sounds very appealing and actually works (the "sr
z" command can be seen to properly dump the ftrace buffer).  The
downside here is that ftrace_dump() fully consumes the trace buffer.
Unless that is changed I'd rather not use it because it means "ftdump
| grep xyz" won't be very useful to search the ftrace buffer since it
will throw away the whole trace on the first grep.  A future patch to
dump only the last few lines of the buffer will also be hard to
implement.

[1] https://lkml.kernel.org/r/20161117191605.GA21459@google.com

Link: http://lkml.kernel.org/r/20190308193205.213659-1-dianders@chromium.org

Reported-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/ring_buffer.h | 2 +-
 kernel/trace/ring_buffer.c  | 5 +++--
 kernel/trace/trace.c        | 6 ++++--
 kernel/trace/trace_kdb.c    | 6 ++++--
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 5caa062a02b2..ca52b82128df 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -123,7 +123,7 @@ ring_buffer_consume(struct ring_buffer *buffer, int cpu, u64 *ts,
 		    unsigned long *lost_events);
 
 struct ring_buffer_iter *
-ring_buffer_read_prepare(struct ring_buffer *buffer, int cpu);
+ring_buffer_read_prepare(struct ring_buffer *buffer, int cpu, gfp_t flags);
 void ring_buffer_read_prepare_sync(void);
 void ring_buffer_read_start(struct ring_buffer_iter *iter);
 void ring_buffer_read_finish(struct ring_buffer_iter *iter);
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index a1d5e0949dcf..5f7f4f07499f 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -4010,6 +4010,7 @@ EXPORT_SYMBOL_GPL(ring_buffer_consume);
  * ring_buffer_read_prepare - Prepare for a non consuming read of the buffer
  * @buffer: The ring buffer to read from
  * @cpu: The cpu buffer to iterate over
+ * @flags: gfp flags to use for memory allocation
  *
  * This performs the initial preparations necessary to iterate
  * through the buffer.  Memory is allocated, buffer recording
@@ -4027,7 +4028,7 @@ EXPORT_SYMBOL_GPL(ring_buffer_consume);
  * This overall must be paired with ring_buffer_read_finish.
  */
 struct ring_buffer_iter *
-ring_buffer_read_prepare(struct ring_buffer *buffer, int cpu)
+ring_buffer_read_prepare(struct ring_buffer *buffer, int cpu, gfp_t flags)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
 	struct ring_buffer_iter *iter;
@@ -4035,7 +4036,7 @@ ring_buffer_read_prepare(struct ring_buffer *buffer, int cpu)
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return NULL;
 
-	iter = kmalloc(sizeof(*iter), GFP_KERNEL);
+	iter = kmalloc(sizeof(*iter), flags);
 	if (!iter)
 		return NULL;
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 287e61aba57c..ffddb5ac255c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3901,7 +3901,8 @@ __tracing_open(struct inode *inode, struct file *file, bool snapshot)
 	if (iter->cpu_file == RING_BUFFER_ALL_CPUS) {
 		for_each_tracing_cpu(cpu) {
 			iter->buffer_iter[cpu] =
-				ring_buffer_read_prepare(iter->trace_buffer->buffer, cpu);
+				ring_buffer_read_prepare(iter->trace_buffer->buffer,
+							 cpu, GFP_KERNEL);
 		}
 		ring_buffer_read_prepare_sync();
 		for_each_tracing_cpu(cpu) {
@@ -3911,7 +3912,8 @@ __tracing_open(struct inode *inode, struct file *file, bool snapshot)
 	} else {
 		cpu = iter->cpu_file;
 		iter->buffer_iter[cpu] =
-			ring_buffer_read_prepare(iter->trace_buffer->buffer, cpu);
+			ring_buffer_read_prepare(iter->trace_buffer->buffer,
+						 cpu, GFP_KERNEL);
 		ring_buffer_read_prepare_sync();
 		ring_buffer_read_start(iter->buffer_iter[cpu]);
 		tracing_iter_reset(iter, cpu);
diff --git a/kernel/trace/trace_kdb.c b/kernel/trace/trace_kdb.c
index d953c163a079..810d78a8d14c 100644
--- a/kernel/trace/trace_kdb.c
+++ b/kernel/trace/trace_kdb.c
@@ -51,14 +51,16 @@ static void ftrace_dump_buf(int skip_lines, long cpu_file)
 	if (cpu_file == RING_BUFFER_ALL_CPUS) {
 		for_each_tracing_cpu(cpu) {
 			iter.buffer_iter[cpu] =
-			ring_buffer_read_prepare(iter.trace_buffer->buffer, cpu);
+			ring_buffer_read_prepare(iter.trace_buffer->buffer,
+						 cpu, GFP_ATOMIC);
 			ring_buffer_read_start(iter.buffer_iter[cpu]);
 			tracing_iter_reset(&iter, cpu);
 		}
 	} else {
 		iter.cpu_file = cpu_file;
 		iter.buffer_iter[cpu_file] =
-			ring_buffer_read_prepare(iter.trace_buffer->buffer, cpu_file);
+			ring_buffer_read_prepare(iter.trace_buffer->buffer,
+						 cpu_file, GFP_ATOMIC);
 		ring_buffer_read_start(iter.buffer_iter[cpu_file]);
 		tracing_iter_reset(&iter, cpu_file);
 	}
-- 
2.19.1



