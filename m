Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6F4C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B1EA26B7B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559315884;
	bh=VMbvqDnoydnz/OcfWZhrP6QB+aT+LqWrOS5adrgDk0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F2MBcmLfD9oQh/Bi38fOf6TwLX1sd+C3jjAJsS0h42SQwytInYAWKHSfCqxJN59fV
	 qZgrbG8Ehwej42JrF/VDmDT+mdFaD7IchgJVOPCf9bwmQcK5k+DRvaqN45+w3VYHD3
	 If4nFpBSl3L353YwhqtFGlkjgODk6WdhfbJhFYRo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfEaPSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 11:18:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:35454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726956AbfEaPSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 11:18:03 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A238C23DD8;
        Fri, 31 May 2019 15:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559315881;
        bh=VMbvqDnoydnz/OcfWZhrP6QB+aT+LqWrOS5adrgDk0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qbOfxjQrdsI/V1a8+1bhaZ2/PgmrHYLTILVt1SGe7pE2dQ8FON2INrXZMT9FmWI64
         vecuhMCojkWDRIhlw8GUy7jpIzHwO+9cYsvEOX2i2z6mkw6xYX9K7HKdVvcNUh7E1T
         jyY9mr2Ypsc7nT1+tA2LbxWvy9yQPP9xKiD48X9A=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/21] tracing/probe: Add trace_event_call accesses APIs
Date:   Sat,  1 Jun 2019 00:17:57 +0900
Message-Id: <155931587711.28323.8335129014686133120.stgit@devnote2>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <155931578555.28323.16360245959211149678.stgit@devnote2>
References: <155931578555.28323.16360245959211149678.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add trace_event_call access APIs for trace_probe.
Instead of accessing trace_probe.call directly, use those
accesses by trace_probe_event_call() method. This hides
the relationship of trace_event_call and trace_probe from
trace_kprobe and trace_uprobe.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |   23 ++++++++++++-----------
 kernel/trace/trace_probe.c  |   24 ++++++++++++++----------
 kernel/trace/trace_probe.h  |    6 ++++++
 kernel/trace/trace_uprobe.c |   15 ++++++++-------
 4 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 3cf8cee4f276..62362ad1ad98 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -985,7 +985,7 @@ __kprobe_trace_func(struct trace_kprobe *tk, struct pt_regs *regs,
 	struct ring_buffer *buffer;
 	int size, dsize, pc;
 	unsigned long irq_flags;
-	struct trace_event_call *call = &tk->tp.call;
+	struct trace_event_call *call = trace_probe_event_call(&tk->tp);
 
 	WARN_ON(call != trace_file->event_call);
 
@@ -1033,7 +1033,7 @@ __kretprobe_trace_func(struct trace_kprobe *tk, struct kretprobe_instance *ri,
 	struct ring_buffer *buffer;
 	int size, pc, dsize;
 	unsigned long irq_flags;
-	struct trace_event_call *call = &tk->tp.call;
+	struct trace_event_call *call = trace_probe_event_call(&tk->tp);
 
 	WARN_ON(call != trace_file->event_call);
 
@@ -1163,7 +1163,7 @@ static int kretprobe_event_define_fields(struct trace_event_call *event_call)
 static int
 kprobe_perf_func(struct trace_kprobe *tk, struct pt_regs *regs)
 {
-	struct trace_event_call *call = &tk->tp.call;
+	struct trace_event_call *call = trace_probe_event_call(&tk->tp);
 	struct kprobe_trace_entry_head *entry;
 	struct hlist_head *head;
 	int size, __size, dsize;
@@ -1213,7 +1213,7 @@ static void
 kretprobe_perf_func(struct trace_kprobe *tk, struct kretprobe_instance *ri,
 		    struct pt_regs *regs)
 {
-	struct trace_event_call *call = &tk->tp.call;
+	struct trace_event_call *call = trace_probe_event_call(&tk->tp);
 	struct kretprobe_trace_entry_head *entry;
 	struct hlist_head *head;
 	int size, __size, dsize;
@@ -1348,9 +1348,10 @@ static struct trace_event_functions kprobe_funcs = {
 	.trace		= print_kprobe_event
 };
 
-static inline void init_trace_event_call(struct trace_kprobe *tk,
-					 struct trace_event_call *call)
+static inline void init_trace_event_call(struct trace_kprobe *tk)
 {
+	struct trace_event_call *call = trace_probe_event_call(&tk->tp);
+
 	if (trace_kprobe_is_return(tk)) {
 		call->event.funcs = &kretprobe_funcs;
 		call->class->define_fields = kretprobe_event_define_fields;
@@ -1366,7 +1367,7 @@ static inline void init_trace_event_call(struct trace_kprobe *tk,
 
 static int register_kprobe_event(struct trace_kprobe *tk)
 {
-	init_trace_event_call(tk, &tk->tp.call);
+	init_trace_event_call(tk);
 
 	return trace_probe_register_event_call(&tk->tp);
 }
@@ -1403,7 +1404,7 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
 		return ERR_CAST(tk);
 	}
 
-	init_trace_event_call(tk, &tk->tp.call);
+	init_trace_event_call(tk);
 
 	if (traceprobe_set_print_fmt(&tk->tp, trace_kprobe_is_return(tk)) < 0) {
 		ret = -ENOMEM;
@@ -1414,7 +1415,7 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
 	if (ret < 0)
 		goto error;
 
-	return &tk->tp.call;
+	return trace_probe_event_call(&tk->tp);
 error:
 	free_trace_kprobe(tk);
 	return ERR_PTR(ret);
@@ -1447,7 +1448,7 @@ static __init void enable_boot_kprobe_events(void)
 	mutex_lock(&event_mutex);
 	for_each_trace_kprobe(tk, pos) {
 		list_for_each_entry(file, &tr->events, list)
-			if (file->event_call == &tk->tp.call)
+			if (file->event_call == trace_probe_event_call(&tk->tp))
 				trace_event_enable_disable(file, 1, 0);
 	}
 	mutex_unlock(&event_mutex);
@@ -1523,7 +1524,7 @@ find_trace_probe_file(struct trace_kprobe *tk, struct trace_array *tr)
 	struct trace_event_file *file;
 
 	list_for_each_entry(file, &tr->events, list)
-		if (file->event_call == &tk->tp.call)
+		if (file->event_call == trace_probe_event_call(&tk->tp))
 			return file;
 
 	return NULL;
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 323a11ad1dad..dbef0d135075 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -844,6 +844,7 @@ static int __set_print_fmt(struct trace_probe *tp, char *buf, int len,
 
 int traceprobe_set_print_fmt(struct trace_probe *tp, bool is_return)
 {
+	struct trace_event_call *call = trace_probe_event_call(tp);
 	int len;
 	char *print_fmt;
 
@@ -855,7 +856,7 @@ int traceprobe_set_print_fmt(struct trace_probe *tp, bool is_return)
 
 	/* Second: actually write the @print_fmt */
 	__set_print_fmt(tp, print_fmt, len + 1, is_return);
-	tp->call.print_fmt = print_fmt;
+	call->print_fmt = print_fmt;
 
 	return 0;
 }
@@ -888,31 +889,34 @@ int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 
 void trace_probe_cleanup(struct trace_probe *tp)
 {
+	struct trace_event_call *call = trace_probe_event_call(tp);
 	int i;
 
 	for (i = 0; i < tp->nr_args; i++)
 		traceprobe_free_probe_arg(&tp->args[i]);
 
-	kfree(tp->call.class->system);
-	kfree(tp->call.name);
-	kfree(tp->call.print_fmt);
+	kfree(call->class->system);
+	kfree(call->name);
+	kfree(call->print_fmt);
 }
 
 int trace_probe_init(struct trace_probe *tp, const char *event,
 		     const char *group)
 {
+	struct trace_event_call *call = trace_probe_event_call(tp);
+
 	if (!event || !group)
 		return -EINVAL;
 
-	tp->call.class = &tp->class;
-	tp->call.name = kstrdup(event, GFP_KERNEL);
-	if (!tp->call.name)
+	call->class = &tp->class;
+	call->name = kstrdup(event, GFP_KERNEL);
+	if (!call->name)
 		return -ENOMEM;
 
 	tp->class.system = kstrdup(group, GFP_KERNEL);
 	if (!tp->class.system) {
-		kfree(tp->call.name);
-		tp->call.name = NULL;
+		kfree(call->name);
+		call->name = NULL;
 		return -ENOMEM;
 	}
 	INIT_LIST_HEAD(&tp->files);
@@ -923,7 +927,7 @@ int trace_probe_init(struct trace_probe *tp, const char *event,
 
 int trace_probe_register_event_call(struct trace_probe *tp)
 {
-	struct trace_event_call *call = &tp->call;
+	struct trace_event_call *call = trace_probe_event_call(tp);
 	int ret;
 
 	ret = register_trace_event(&call->event);
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 67424cb5d5d6..6c33d4aa36c3 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -276,6 +276,12 @@ static inline const char *trace_probe_group_name(struct trace_probe *tp)
 	return tp->call.class->system;
 }
 
+static inline struct trace_event_call *
+	trace_probe_event_call(struct trace_probe *tp)
+{
+	return &tp->call;
+}
+
 static inline int trace_probe_unregister_event_call(struct trace_probe *tp)
 {
 	/* tp->event is unregistered in trace_remove_event_call() */
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 09fdba3ee9d9..7fb9353b47d9 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -821,7 +821,7 @@ static void __uprobe_trace_func(struct trace_uprobe *tu,
 	struct ring_buffer *buffer;
 	void *data;
 	int size, esize;
-	struct trace_event_call *call = &tu->tp.call;
+	struct trace_event_call *call = trace_probe_event_call(&tu->tp);
 
 	WARN_ON(call != trace_file->event_call);
 
@@ -1113,7 +1113,7 @@ static void __uprobe_perf_func(struct trace_uprobe *tu,
 			       unsigned long func, struct pt_regs *regs,
 			       struct uprobe_cpu_buffer *ucb, int dsize)
 {
-	struct trace_event_call *call = &tu->tp.call;
+	struct trace_event_call *call = trace_probe_event_call(&tu->tp);
 	struct uprobe_trace_entry_head *entry;
 	struct hlist_head *head;
 	void *data;
@@ -1316,9 +1316,10 @@ static struct trace_event_functions uprobe_funcs = {
 	.trace		= print_uprobe_event
 };
 
-static inline void init_trace_event_call(struct trace_uprobe *tu,
-					 struct trace_event_call *call)
+static inline void init_trace_event_call(struct trace_uprobe *tu)
 {
+	struct trace_event_call *call = trace_probe_event_call(&tu->tp);
+
 	call->event.funcs = &uprobe_funcs;
 	call->class->define_fields = uprobe_event_define_fields;
 
@@ -1329,7 +1330,7 @@ static inline void init_trace_event_call(struct trace_uprobe *tu,
 
 static int register_uprobe_event(struct trace_uprobe *tu)
 {
-	init_trace_event_call(tu, &tu->tp.call);
+	init_trace_event_call(tu);
 
 	return trace_probe_register_event_call(&tu->tp);
 }
@@ -1376,14 +1377,14 @@ create_local_trace_uprobe(char *name, unsigned long offs,
 	tu->path = path;
 	tu->ref_ctr_offset = ref_ctr_offset;
 	tu->filename = kstrdup(name, GFP_KERNEL);
-	init_trace_event_call(tu, &tu->tp.call);
+	init_trace_event_call(tu);
 
 	if (traceprobe_set_print_fmt(&tu->tp, is_ret_probe(tu)) < 0) {
 		ret = -ENOMEM;
 		goto error;
 	}
 
-	return &tu->tp.call;
+	return trace_probe_event_call(&tu->tp);
 error:
 	free_trace_uprobe(tu);
 	return ERR_PTR(ret);

