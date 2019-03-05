Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B19EC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 23:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE3720663
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 23:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TMX/eACl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbfCEXcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 18:32:10 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45802 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfCEXcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 18:32:09 -0500
Received: by mail-pg1-f195.google.com with SMTP id 125so6514618pgc.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 15:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gTH0uYPWhAgHTCdnQf0FATVULGKiKFjtSPYUH5y6r1A=;
        b=TMX/eAClwvsyAJOOqWSnko2IovGl8TmG+OSOE6y+N6kOlJGouPjq/ToxxA5jmazR3r
         /VOhAImFjpI8JaIQHmFUMpFiXh9DTREeWdleH52oqCAtn9HwxhYheaN/HwV3gLSluHMV
         OMpdnEaY4hOblCgY66Dxx1x0RkiH8p0awqvaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gTH0uYPWhAgHTCdnQf0FATVULGKiKFjtSPYUH5y6r1A=;
        b=szq7IEzbmHg/oWpegAefoP84DyUiuQbyRgGM16xh6waHCQFTQdJKZcCCCqziE8/m7O
         uCGScpe2F6I77LBbe0Hgl+CX8MzDwj3GtNplSfOS9BzJyZRXbuRnU9J8czPSgOgPI957
         9TrB0VtgNe3P3xXg2kGpq1HVscZEQhMQ+fSrejPY9zCMLvd5RwNqLsl30qrMMGF+uj0F
         DFgr5AZzAJspd9D9f33zLQFmO7R2IJnV2m5Q/Xbxz3ewoGBbsOaND/7viLYTaV+SWgFl
         2e8A+2FxyzS6JxzFrV9/CKo3MQgcwo7iIr/ajfbc92ymArg1EXbeIW2fDgUmQr0Pjle5
         9C7w==
X-Gm-Message-State: APjAAAWtUlA5nYKl85jngs3HwgC1hbXw9awYNjduJ3UiO8W0rYlPtoK3
        UaHaWG0AQcU99/CSkLx3lr121KKZu4Y=
X-Google-Smtp-Source: APXvYqxYXDjsIYToIPKUL5aSP9DyHOJzvjW67falLCp5Xl3H13OMY1f13ucXhZzbGUJAyXI1eJw68A==
X-Received: by 2002:aa7:9099:: with SMTP id i25mr4346098pfa.102.1551828728854;
        Tue, 05 Mar 2019 15:32:08 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id j1sm20345pgp.84.2019.03.05.15.32.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 15:32:08 -0800 (PST)
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
Subject: [PATCH 1/2] tracing: kdb: Fix ftdump to not sleep
Date:   Tue,  5 Mar 2019 15:31:49 -0800
Message-Id: <20190305233150.159633-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported back in 2016-11 [1], the "ftdump" kdb command triggers a
BUG for "sleeping function called from invalid context".

kdb's "ftdump" command wants to call ring_buffer_read_prepare() in
atomic context.  A very simple solution for this is to just provide a
variant of ring_buffer_read_prepare that takes in allocation flags so
kdb can call it without triggering the allocation error.  This patch
does that.

Note that in the original email thread about this, it was suggested
that perhaps the solution for kdb was to either preallocate the buffer
ahead of time or create our own iterator.  I'm hoping that this
alternative of creating a variant of ring_buffer_read_prepare() can be
considered since it means I don't need to duplicate more of the core
trace code into "trace_kdb.c" (for either creating my own iterator or
re-preparing a ring allocator whose memory was already allocated).

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

 include/linux/ring_buffer.h |  2 ++
 kernel/trace/ring_buffer.c  | 42 +++++++++++++++++++++----------------
 kernel/trace/trace_kdb.c    |  6 ++++--
 3 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 5b9ae62272bb..0c8ab8bf4cfb 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -127,6 +127,8 @@ struct ring_buffer_event *
 ring_buffer_consume(struct ring_buffer *buffer, int cpu, u64 *ts,
 		    unsigned long *lost_events);
 
+struct ring_buffer_iter *
+_ring_buffer_read_prepare(struct ring_buffer *buffer, int cpu, gfp_t flags);
 struct ring_buffer_iter *
 ring_buffer_read_prepare(struct ring_buffer *buffer, int cpu);
 void ring_buffer_read_prepare_sync(void);
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 06e864a334bb..fd60007aa7a1 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -4201,6 +4201,29 @@ ring_buffer_consume(struct ring_buffer *buffer, int cpu, u64 *ts,
 }
 EXPORT_SYMBOL_GPL(ring_buffer_consume);
 
+struct ring_buffer_iter *
+_ring_buffer_read_prepare(struct ring_buffer *buffer, int cpu, gfp_t flags)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+	struct ring_buffer_iter *iter;
+
+	if (!cpumask_test_cpu(cpu, buffer->cpumask))
+		return NULL;
+
+	iter = kmalloc(sizeof(*iter), flags);
+	if (!iter)
+		return NULL;
+
+	cpu_buffer = buffer->buffers[cpu];
+
+	iter->cpu_buffer = cpu_buffer;
+
+	atomic_inc(&buffer->resize_disabled);
+	atomic_inc(&cpu_buffer->record_disabled);
+
+	return iter;
+}
+
 /**
  * ring_buffer_read_prepare - Prepare for a non consuming read of the buffer
  * @buffer: The ring buffer to read from
@@ -4224,24 +4247,7 @@ EXPORT_SYMBOL_GPL(ring_buffer_consume);
 struct ring_buffer_iter *
 ring_buffer_read_prepare(struct ring_buffer *buffer, int cpu)
 {
-	struct ring_buffer_per_cpu *cpu_buffer;
-	struct ring_buffer_iter *iter;
-
-	if (!cpumask_test_cpu(cpu, buffer->cpumask))
-		return NULL;
-
-	iter = kmalloc(sizeof(*iter), GFP_KERNEL);
-	if (!iter)
-		return NULL;
-
-	cpu_buffer = buffer->buffers[cpu];
-
-	iter->cpu_buffer = cpu_buffer;
-
-	atomic_inc(&buffer->resize_disabled);
-	atomic_inc(&cpu_buffer->record_disabled);
-
-	return iter;
+	return _ring_buffer_read_prepare(buffer, cpu, GFP_KERNEL);
 }
 EXPORT_SYMBOL_GPL(ring_buffer_read_prepare);
 
diff --git a/kernel/trace/trace_kdb.c b/kernel/trace/trace_kdb.c
index d953c163a079..be84fa1ded35 100644
--- a/kernel/trace/trace_kdb.c
+++ b/kernel/trace/trace_kdb.c
@@ -51,14 +51,16 @@ static void ftrace_dump_buf(int skip_lines, long cpu_file)
 	if (cpu_file == RING_BUFFER_ALL_CPUS) {
 		for_each_tracing_cpu(cpu) {
 			iter.buffer_iter[cpu] =
-			ring_buffer_read_prepare(iter.trace_buffer->buffer, cpu);
+			_ring_buffer_read_prepare(iter.trace_buffer->buffer,
+						  cpu, GFP_ATOMIC);
 			ring_buffer_read_start(iter.buffer_iter[cpu]);
 			tracing_iter_reset(&iter, cpu);
 		}
 	} else {
 		iter.cpu_file = cpu_file;
 		iter.buffer_iter[cpu_file] =
-			ring_buffer_read_prepare(iter.trace_buffer->buffer, cpu_file);
+			_ring_buffer_read_prepare(iter.trace_buffer->buffer,
+						  cpu_file, GFP_ATOMIC);
 		ring_buffer_read_start(iter.buffer_iter[cpu_file]);
 		tracing_iter_reset(&iter, cpu_file);
 	}
-- 
2.21.0.352.gf09ad66450-goog

