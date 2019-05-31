Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8480C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A201726B94
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559315933;
	bh=9qNloy3orXbIG5wjABvKYf6XLEJI255TfgG8m65O2OM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F/Xji7fibCwvp5eqTlnXRyEmNsB66/fzKi7G6JU/KXaWoSnfZvrz+tRRNZmrlcCzr
	 1X43JMXxHgRPziz7zVQ9fnwYkm6MX7fNDlh01rBi/XD8reUxFpm7mtv/wfR2/YH3a3
	 qBFiCOPYXZ7QrOQ52q+MyFYHFNBYQwnFN+YiDwnI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfEaPSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 11:18:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbfEaPSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 11:18:52 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81BCA26B93;
        Fri, 31 May 2019 15:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559315931;
        bh=9qNloy3orXbIG5wjABvKYf6XLEJI255TfgG8m65O2OM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vDqvul7maFbf2U1ceD4Xo4SuwBvN+SYuYF7FWCvQA3FWNGeLQnhgU5I5MV+mt3DL/
         R+PQ3MWZf3kdqh0uUlqjTLVDohR1ISPdT8SdLNqXTSY8dokv8OBvUtM4gp48TG20tY
         MxdCJVE0RxG3Kg0sgPifBzVv04cJ6mptHxbC5MnY=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/21] tracing/kprobe: Add multi-probe per event support
Date:   Sat,  1 Jun 2019 00:18:47 +0900
Message-Id: <155931592697.28323.5867084248553766978.stgit@devnote2>
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

Add multi-probe per one event support to kprobe events.
User can define several different probes on one trace event
if those events have same "event signature",
e.g.

  # echo p:testevent _do_fork > kprobe_events
  # echo p:testevent fork_idle >> kprobe_events
  # kprobe_events
  p:kprobes/testevent _do_fork
  p:kprobes/testevent fork_idle

The event signature is defined by kprobe type (retprobe or not),
the number of args, argument names, and argument types.

Note that this only support appending method. Delete event
operation will delete all probes on the event.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace.c        |    4 +--
 kernel/trace/trace_kprobe.c |   52 ++++++++++++++++++++++++++++++++++----
 kernel/trace/trace_probe.c  |   59 ++++++++++++++++++++++++++++++++++++-------
 kernel/trace/trace_probe.h  |   14 +++++++++-
 4 files changed, 111 insertions(+), 18 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 77b9c4ca5faa..8f5455046504 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4813,11 +4813,11 @@ static const char readme_msg[] =
 #endif
 #endif /* CONFIG_STACK_TRACER */
 #ifdef CONFIG_DYNAMIC_EVENTS
-	"  dynamic_events\t\t- Add/remove/show the generic dynamic events\n"
+	"  dynamic_events\t\t- Create/append/remove/show the generic dynamic events\n"
 	"\t\t\t  Write into this file to define/undefine new trace events.\n"
 #endif
 #ifdef CONFIG_KPROBE_EVENTS
-	"  kprobe_events\t\t- Add/remove/show the kernel dynamic events\n"
+	"  kprobe_events\t\t- Create/append/remove/show the kernel dynamic events\n"
 	"\t\t\t  Write into this file to define/undefine new trace events.\n"
 #endif
 #ifdef CONFIG_UPROBE_EVENTS
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index b340bbc9a965..84a164559a47 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -464,6 +464,10 @@ static void __unregister_trace_kprobe(struct trace_kprobe *tk)
 /* Unregister a trace_probe and probe_event */
 static int unregister_trace_kprobe(struct trace_kprobe *tk)
 {
+	/* If other probes are on the event, just unregister kprobe */
+	if (trace_probe_has_sibling(&tk->tp))
+		goto unreg;
+
 	/* Enabled event can not be unregistered */
 	if (trace_probe_is_enabled(&tk->tp))
 		return -EBUSY;
@@ -472,12 +476,38 @@ static int unregister_trace_kprobe(struct trace_kprobe *tk)
 	if (unregister_kprobe_event(tk))
 		return -EBUSY;
 
+unreg:
 	__unregister_trace_kprobe(tk);
 	dyn_event_remove(&tk->devent);
+	trace_probe_unlink(&tk->tp);
 
 	return 0;
 }
 
+static int append_trace_kprobe(struct trace_kprobe *tk, struct trace_kprobe *to)
+{
+	int ret;
+
+	/* Append to existing event */
+	ret = trace_probe_append(&tk->tp, &to->tp);
+	if (ret)
+		return ret;
+
+	/* Register k*probe */
+	ret = __register_trace_kprobe(tk);
+	if (ret == -ENOENT && !trace_kprobe_module_exist(tk)) {
+		pr_warn("This probe might be able to register after target module is loaded. Continue.\n");
+		ret = 0;
+	}
+
+	if (ret)
+		trace_probe_unlink(&tk->tp);
+	else
+		dyn_event_add(&tk->devent);
+
+	return ret;
+}
+
 /* Register a trace_probe and probe_event */
 static int register_trace_kprobe(struct trace_kprobe *tk)
 {
@@ -486,14 +516,24 @@ static int register_trace_kprobe(struct trace_kprobe *tk)
 
 	mutex_lock(&event_mutex);
 
-	/* Delete old (same name) event if exist */
 	old_tk = find_trace_kprobe(trace_probe_name(&tk->tp),
 				   trace_probe_group_name(&tk->tp));
 	if (old_tk) {
-		ret = unregister_trace_kprobe(old_tk);
-		if (ret < 0)
-			goto end;
-		free_trace_kprobe(old_tk);
+		if (trace_kprobe_is_return(tk) != trace_kprobe_is_return(old_tk)) {
+			trace_probe_log_set_index(0);
+			trace_probe_log_err(0, DIFF_PROBE_TYPE);
+			ret = -EEXIST;
+		} else {
+			ret = trace_probe_compare_arg_type(&tk->tp, &old_tk->tp);
+			if (ret) {
+				/* Note that argument starts index = 2 */
+				trace_probe_log_set_index(ret + 1);
+				trace_probe_log_err(0, DIFF_ARG_TYPE);
+				ret = -EEXIST;
+			} else
+				ret = append_trace_kprobe(tk, old_tk);
+		}
+		goto end;
 	}
 
 	/* Register new event */
@@ -727,7 +767,7 @@ static int trace_kprobe_create(int argc, const char *argv[])
 			trace_probe_log_err(0, BAD_INSN_BNDRY);
 		else if (ret == -ENOENT)
 			trace_probe_log_err(0, BAD_PROBE_ADDR);
-		else if (ret != -ENOMEM)
+		else if (ret != -ENOMEM && ret != -EEXIST)
 			trace_probe_log_err(0, FAIL_REG_PROBE);
 		goto error;
 	}
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 28733bd6b607..651a1449acde 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -886,6 +886,35 @@ int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	return 0;
 }
 
+static void trace_probe_event_free(struct trace_probe_event *tpe)
+{
+	kfree(tpe->class.system);
+	kfree(tpe->call.name);
+	kfree(tpe->call.print_fmt);
+	kfree(tpe);
+}
+
+int trace_probe_append(struct trace_probe *tp, struct trace_probe *to)
+{
+	if (trace_probe_has_sibling(tp))
+		return -EBUSY;
+
+	list_del_init(&tp->list);
+	trace_probe_event_free(tp->event);
+
+	tp->event = to->event;
+	list_add_tail(&tp->list, trace_probe_probe_list(to));
+
+	return 0;
+}
+
+void trace_probe_unlink(struct trace_probe *tp)
+{
+	list_del_init(&tp->list);
+	if (list_empty(trace_probe_probe_list(tp)))
+		trace_probe_event_free(tp->event);
+	tp->event = NULL;
+}
 
 void trace_probe_cleanup(struct trace_probe *tp)
 {
@@ -894,15 +923,8 @@ void trace_probe_cleanup(struct trace_probe *tp)
 	for (i = 0; i < tp->nr_args; i++)
 		traceprobe_free_probe_arg(&tp->args[i]);
 
-	if (tp->event) {
-		struct trace_event_call *call = trace_probe_event_call(tp);
-
-		kfree(tp->event->class.system);
-		kfree(call->name);
-		kfree(call->print_fmt);
-		kfree(tp->event);
-		tp->event = NULL;
-	}
+	if (tp->event)
+		trace_probe_unlink(tp);
 }
 
 int trace_probe_init(struct trace_probe *tp, const char *event,
@@ -1006,3 +1028,22 @@ int trace_probe_remove_file(struct trace_probe *tp,
 
 	return 0;
 }
+
+/*
+ * Return the smallest index of different type argument (start from 1).
+ * If all argument types and name are same, return 0.
+ */
+int trace_probe_compare_arg_type(struct trace_probe *a, struct trace_probe *b)
+{
+	int i;
+
+	for (i = 0; i < a->nr_args; i++) {
+		if ((b->nr_args <= i) ||
+		    ((a->args[i].type != b->args[i].type) ||
+		     (a->args[i].count != b->args[i].count) ||
+		     strcmp(a->args[i].name, b->args[i].name)))
+			return i + 1;
+	}
+
+	return 0;
+}
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 0b84abb884c2..39926e8a344b 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -302,6 +302,13 @@ static inline struct list_head *trace_probe_probe_list(struct trace_probe *tp)
 	return &tp->event->probes;
 }
 
+static inline bool trace_probe_has_sibling(struct trace_probe *tp)
+{
+	struct list_head *list = trace_probe_probe_list(tp);
+
+	return !list_empty(list) && !list_is_singular(list);
+}
+
 static inline int trace_probe_unregister_event_call(struct trace_probe *tp)
 {
 	/* tp->event is unregistered in trace_remove_event_call() */
@@ -316,12 +323,15 @@ static inline bool trace_probe_has_single_file(struct trace_probe *tp)
 int trace_probe_init(struct trace_probe *tp, const char *event,
 		     const char *group);
 void trace_probe_cleanup(struct trace_probe *tp);
+int trace_probe_append(struct trace_probe *tp, struct trace_probe *to);
+void trace_probe_unlink(struct trace_probe *tp);
 int trace_probe_register_event_call(struct trace_probe *tp);
 int trace_probe_add_file(struct trace_probe *tp, struct trace_event_file *file);
 int trace_probe_remove_file(struct trace_probe *tp,
 			    struct trace_event_file *file);
 struct event_file_link *trace_probe_get_file_link(struct trace_probe *tp,
 						struct trace_event_file *file);
+int trace_probe_compare_arg_type(struct trace_probe *a, struct trace_probe *b);
 
 #define trace_probe_for_each_link(pos, tp)	\
 	list_for_each_entry(pos, &(tp)->event->files, list)
@@ -419,7 +429,9 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(ARG_TOO_LONG,		"Argument expression is too long"),	\
 	C(NO_ARG_BODY,		"No argument expression"),		\
 	C(BAD_INSN_BNDRY,	"Probe point is not an instruction boundary"),\
-	C(FAIL_REG_PROBE,	"Failed to register probe event"),
+	C(FAIL_REG_PROBE,	"Failed to register probe event"),\
+	C(DIFF_PROBE_TYPE,	"Probe type is different from existing probe"),\
+	C(DIFF_ARG_TYPE,	"Argument type or name is different from existing probe"),
 
 #undef C
 #define C(a, b)		TP_ERR_##a

