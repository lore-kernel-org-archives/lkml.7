Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDD5C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E948E20851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AjNNFgfj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfCHTcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 14:32:20 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35933 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfCHTcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 14:32:20 -0500
Received: by mail-pg1-f195.google.com with SMTP id r124so14903548pgr.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 11:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NayMJ0Rb+Jll5QCyAjFsYetr7VuNE9LRVNLrmhontas=;
        b=AjNNFgfjz9/BfZwSDF9isAwzr60R0MnsYCDEGoYW2zAJ1W03zN4sDQnGPpvTWkiPWX
         QDmY9AVgUlpmdZ6HmM5mCP5HjgZFCxP+KmhZOLLCqPRODVQ7ox56PfBhk4lZ0Zp9z9sB
         5no8rRRLP3X/Jhk8uZd7judLVNLn1izRUBIao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NayMJ0Rb+Jll5QCyAjFsYetr7VuNE9LRVNLrmhontas=;
        b=MjuYcnpk20yw6hv/kHDTa9iJaWgK6zOEXGIs+IOdBtY9viQnfg+yGXV87dTu77nHND
         lkHLZr45fWFkKc533GY6NnXwtMPgzF7aeT4PYQ0VuKu2l4RJ3xr0aYK7rZBMqUSOllrO
         gUqGB0VQM4HWLzRRaCyvIHuaj6oF8ZusHY1N5fSsTmVHIeB4FTt7j33JaxQBUnH+h0YV
         tetRnDrFFtEZOEBKBvQhPaJp380I7m8q0TmoaBPqsAuh3aGQJexh2gTKaZKv/uZsJiE9
         M4VqCimM/X1EtAd8VKCEpv6Mvuf5Ucm3WKA2+QPqGjIOHGlT8rwgUH5gHr/mNzvHh3yD
         fHcw==
X-Gm-Message-State: APjAAAWuyId1V/93H4BSW42Ly6ypUWdG5Ucp7/1lnYyznWcAvC90m20E
        U4JE/tYK9SX7FS1D8TA8athBfQ==
X-Google-Smtp-Source: APXvYqyv4zkBo1AiJMGxRPf1O48YxOTNeksygGq5gGMFRZ9+qfplrsZuneqC0i+BViLrECc+AXbODQ==
X-Received: by 2002:a17:902:7682:: with SMTP id m2mr20803085pll.311.1552073538695;
        Fri, 08 Mar 2019 11:32:18 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id s18sm10845724pfh.71.2019.03.08.11.32.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 11:32:18 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Vasyl Gomonovych <gomonovych@gmail.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-kernel@vger.kernel.org, Baohong Liu <baohong.liu@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 1/2] tracing: kdb: Fix ftdump to not sleep
Date:   Fri,  8 Mar 2019 11:32:04 -0800
Message-Id: <20190308193205.213659-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Reported-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Don't introduce _ring_buffer_read_prepare(), just change args

 include/linux/ring_buffer.h | 2 +-
 kernel/trace/ring_buffer.c  | 5 +++--
 kernel/trace/trace.c        | 6 ++++--
 kernel/trace/trace_kdb.c    | 6 ++++--
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 5b9ae62272bb..503778920448 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -128,7 +128,7 @@ ring_buffer_consume(struct ring_buffer *buffer, int cpu, u64 *ts,
 		    unsigned long *lost_events);
 
 struct ring_buffer_iter *
-ring_buffer_read_prepare(struct ring_buffer *buffer, int cpu);
+ring_buffer_read_prepare(struct ring_buffer *buffer, int cpu, gfp_t flags);
 void ring_buffer_read_prepare_sync(void);
 void ring_buffer_read_start(struct ring_buffer_iter *iter);
 void ring_buffer_read_finish(struct ring_buffer_iter *iter);
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 06e864a334bb..b49affb4666b 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -4205,6 +4205,7 @@ EXPORT_SYMBOL_GPL(ring_buffer_consume);
  * ring_buffer_read_prepare - Prepare for a non consuming read of the buffer
  * @buffer: The ring buffer to read from
  * @cpu: The cpu buffer to iterate over
+ * @flags: gfp flags to use for memory allocation
  *
  * This performs the initial preparations necessary to iterate
  * through the buffer.  Memory is allocated, buffer recording
@@ -4222,7 +4223,7 @@ EXPORT_SYMBOL_GPL(ring_buffer_consume);
  * This overall must be paired with ring_buffer_read_finish.
  */
 struct ring_buffer_iter *
-ring_buffer_read_prepare(struct ring_buffer *buffer, int cpu)
+ring_buffer_read_prepare(struct ring_buffer *buffer, int cpu, gfp_t flags)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
 	struct ring_buffer_iter *iter;
@@ -4230,7 +4231,7 @@ ring_buffer_read_prepare(struct ring_buffer *buffer, int cpu)
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return NULL;
 
-	iter = kmalloc(sizeof(*iter), GFP_KERNEL);
+	iter = kmalloc(sizeof(*iter), flags);
 	if (!iter)
 		return NULL;
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c4238b441624..8867a93246d6 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3904,7 +3904,8 @@ __tracing_open(struct inode *inode, struct file *file, bool snapshot)
 	if (iter->cpu_file == RING_BUFFER_ALL_CPUS) {
 		for_each_tracing_cpu(cpu) {
 			iter->buffer_iter[cpu] =
-				ring_buffer_read_prepare(iter->trace_buffer->buffer, cpu);
+				ring_buffer_read_prepare(iter->trace_buffer->buffer,
+							 cpu, GFP_KERNEL);
 		}
 		ring_buffer_read_prepare_sync();
 		for_each_tracing_cpu(cpu) {
@@ -3914,7 +3915,8 @@ __tracing_open(struct inode *inode, struct file *file, bool snapshot)
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
2.21.0.360.g471c308f928-goog

