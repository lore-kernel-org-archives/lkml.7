Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2A3C2D0C3
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 21:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DAA3206A5
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 21:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfLUVf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 16:35:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:57230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbfLUVf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 16:35:59 -0500
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 375B7206C3;
        Sat, 21 Dec 2019 21:35:57 +0000 (UTC)
Date:   Sat, 21 Dec 2019 16:35:55 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] tracing: A few fixes for v5.5
Message-ID: <20191221163555.29d65de5@rorschach.local.home>
X-Mailer: Claws Mail 3.17.4git76 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Various tracing fixes:

 - Fix memory leak on error path of process_system_preds()
 - Lock inversion fix with updating tgid recording option
 - Fix histogram compare function on big endian machines
 - Fix histogram trigger function on big endian machines
 - Make trace_printk() irq sync on init for kprobe selftest correctness


Please pull the latest trace-v5.5-rc2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.5-rc2

Tag SHA1: fae7f7f1c6c0640798deb85f464b7effdfb54f8d
Head SHA1: fe6e096a5bbf73a142f09c72e7aa2835026eb1a3


Keita Suzuki (1):
      tracing: Avoid memory leak in process_system_preds()

Prateek Sood (1):
      tracing: Fix lock inversion in trace_event_enable_tgid_record()

Steven Rostedt (VMware) (1):
      tracing: Have the histogram compare functions convert to u64 first

Sven Schnelle (2):
      samples/trace_printk: Wait for IRQ work to finish
      tracing: Fix endianness bug in histogram trigger

----
 kernel/trace/trace.c                |  8 ++++++++
 kernel/trace/trace_events.c         |  8 ++++----
 kernel/trace/trace_events_filter.c  |  2 +-
 kernel/trace/trace_events_hist.c    | 21 ++++++++++++++++++++-
 kernel/trace/tracing_map.c          |  4 ++--
 samples/trace_printk/trace-printk.c |  1 +
 6 files changed, 36 insertions(+), 8 deletions(-)
---------------------------
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6c75410f9698..ddb7e7f5fe8d 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4685,6 +4685,10 @@ int trace_keep_overwrite(struct tracer *tracer, u32 mask, int set)
 
 int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled)
 {
+	if ((mask == TRACE_ITER_RECORD_TGID) ||
+	    (mask == TRACE_ITER_RECORD_CMD))
+		lockdep_assert_held(&event_mutex);
+
 	/* do nothing if flag is already set */
 	if (!!(tr->trace_flags & mask) == !!enabled)
 		return 0;
@@ -4752,6 +4756,7 @@ static int trace_set_options(struct trace_array *tr, char *option)
 
 	cmp += len;
 
+	mutex_lock(&event_mutex);
 	mutex_lock(&trace_types_lock);
 
 	ret = match_string(trace_options, -1, cmp);
@@ -4762,6 +4767,7 @@ static int trace_set_options(struct trace_array *tr, char *option)
 		ret = set_tracer_flag(tr, 1 << ret, !neg);
 
 	mutex_unlock(&trace_types_lock);
+	mutex_unlock(&event_mutex);
 
 	/*
 	 * If the first trailing whitespace is replaced with '\0' by strstrip,
@@ -8076,9 +8082,11 @@ trace_options_core_write(struct file *filp, const char __user *ubuf, size_t cnt,
 	if (val != 0 && val != 1)
 		return -EINVAL;
 
+	mutex_lock(&event_mutex);
 	mutex_lock(&trace_types_lock);
 	ret = set_tracer_flag(tr, 1 << index, val);
 	mutex_unlock(&trace_types_lock);
+	mutex_unlock(&event_mutex);
 
 	if (ret < 0)
 		return ret;
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index c6de3cebc127..a5b614cc3887 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -320,7 +320,8 @@ void trace_event_enable_cmd_record(bool enable)
 	struct trace_event_file *file;
 	struct trace_array *tr;
 
-	mutex_lock(&event_mutex);
+	lockdep_assert_held(&event_mutex);
+
 	do_for_each_event_file(tr, file) {
 
 		if (!(file->flags & EVENT_FILE_FL_ENABLED))
@@ -334,7 +335,6 @@ void trace_event_enable_cmd_record(bool enable)
 			clear_bit(EVENT_FILE_FL_RECORDED_CMD_BIT, &file->flags);
 		}
 	} while_for_each_event_file();
-	mutex_unlock(&event_mutex);
 }
 
 void trace_event_enable_tgid_record(bool enable)
@@ -342,7 +342,8 @@ void trace_event_enable_tgid_record(bool enable)
 	struct trace_event_file *file;
 	struct trace_array *tr;
 
-	mutex_lock(&event_mutex);
+	lockdep_assert_held(&event_mutex);
+
 	do_for_each_event_file(tr, file) {
 		if (!(file->flags & EVENT_FILE_FL_ENABLED))
 			continue;
@@ -356,7 +357,6 @@ void trace_event_enable_tgid_record(bool enable)
 				  &file->flags);
 		}
 	} while_for_each_event_file();
-	mutex_unlock(&event_mutex);
 }
 
 static int __ftrace_event_enable_disable(struct trace_event_file *file,
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index c9a74f82b14a..bf44f6bbd0c3 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1662,7 +1662,7 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 	parse_error(pe, FILT_ERR_BAD_SUBSYS_FILTER, 0);
 	return -EINVAL;
  fail_mem:
-	kfree(filter);
+	__free_filter(filter);
 	/* If any call succeeded, we still need to sync */
 	if (!fail)
 		tracepoint_synchronize_unregister();
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index f49d1a36d3ae..f62de5f43e79 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -911,7 +911,26 @@ static notrace void trace_event_raw_event_synth(void *__data,
 			strscpy(str_field, str_val, STR_VAR_LEN_MAX);
 			n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
 		} else {
-			entry->fields[n_u64] = var_ref_vals[var_ref_idx + i];
+			struct synth_field *field = event->fields[i];
+			u64 val = var_ref_vals[var_ref_idx + i];
+
+			switch (field->size) {
+			case 1:
+				*(u8 *)&entry->fields[n_u64] = (u8)val;
+				break;
+
+			case 2:
+				*(u16 *)&entry->fields[n_u64] = (u16)val;
+				break;
+
+			case 4:
+				*(u32 *)&entry->fields[n_u64] = (u32)val;
+				break;
+
+			default:
+				entry->fields[n_u64] = val;
+				break;
+			}
 			n_u64++;
 		}
 	}
diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index 9a1c22310323..9e31bfc818ff 100644
--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -148,8 +148,8 @@ static int tracing_map_cmp_atomic64(void *val_a, void *val_b)
 #define DEFINE_TRACING_MAP_CMP_FN(type)					\
 static int tracing_map_cmp_##type(void *val_a, void *val_b)		\
 {									\
-	type a = *(type *)val_a;					\
-	type b = *(type *)val_b;					\
+	type a = (type)(*(u64 *)val_a);					\
+	type b = (type)(*(u64 *)val_b);					\
 									\
 	return (a > b) ? 1 : ((a < b) ? -1 : 0);			\
 }
diff --git a/samples/trace_printk/trace-printk.c b/samples/trace_printk/trace-printk.c
index 7affc3b50b61..cfc159580263 100644
--- a/samples/trace_printk/trace-printk.c
+++ b/samples/trace_printk/trace-printk.c
@@ -36,6 +36,7 @@ static int __init trace_printk_init(void)
 
 	/* Kick off printing in irq context */
 	irq_work_queue(&irqwork);
+	irq_work_sync(&irqwork);
 
 	trace_printk("This is a %s that will use trace_bprintk()\n",
 		     "static string");
