Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEB5C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C777E23FA2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559315905;
	bh=rP48wLaw6Jyr/+5rPazrP3JcS6kxA8MrE8bTAWVIaOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zBdbcyjrvXlb6O8miC0ndKagOmoOVva+mryvpX/ow7WeomxS+V7OYDa/Z+eg/Hhki
	 58tKK3/+EPX0TFLd9xg32/4k9tjCp9cpJlPqGsvPoZDaxG/0JbQ69w9JrWzqzTyV+k
	 s/OvCaJ8huDlU2nHiIyamtXk82ZtXXBrJlurQ194=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfEaPSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 11:18:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:35636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbfEaPSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 11:18:23 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3679523DD8;
        Fri, 31 May 2019 15:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559315901;
        bh=rP48wLaw6Jyr/+5rPazrP3JcS6kxA8MrE8bTAWVIaOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UEPcYmcK7OKK2cJVVuIhe/dC4xuOXHkRm5VydYsws0laHzUeFCL3whrAVWEds4C6K
         GVPzPB/IPPzbAq7bDxowrgwco3/G0e+WyNBkQFgJK3zn7rFtnpe2iOgayCalx0rlBR
         V9dltPsxtX/4d/+kDsU+vrTTR6HFNh9BxjIN27rE=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/21] tracing/probe: Split trace_event related data from trace_probe
Date:   Sat,  1 Jun 2019 00:18:16 +0900
Message-Id: <155931589667.28323.6107724588059072406.stgit@devnote2>
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

Split the trace_event related data from trace_probe data structure
and introduce trace_probe_event data structure for its folder.
This trace_probe_event data structure can have multiple trace_probe.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |   99 ++++++++++++++++++++++-------------
 kernel/trace/trace_probe.c  |   53 +++++++++++++------
 kernel/trace/trace_probe.h  |   48 +++++++++++++----
 kernel/trace/trace_uprobe.c |  123 +++++++++++++++++++++++++++++--------------
 4 files changed, 221 insertions(+), 102 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 9d483ad9bb6c..633edb88cd0e 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -180,9 +180,17 @@ unsigned long trace_kprobe_address(struct trace_kprobe *tk)
 	return addr;
 }
 
+static nokprobe_inline struct trace_kprobe *
+trace_kprobe_primary_from_call(struct trace_event_call *call)
+{
+	struct trace_probe *tp = trace_probe_primary_from_call(call);
+
+	return container_of(tp, struct trace_kprobe, tp);
+}
+
 bool trace_kprobe_on_func_entry(struct trace_event_call *call)
 {
-	struct trace_kprobe *tk = (struct trace_kprobe *)call->data;
+	struct trace_kprobe *tk = trace_kprobe_primary_from_call(call);
 
 	return kprobe_on_func_entry(tk->rp.kp.addr,
 			tk->rp.kp.addr ? NULL : tk->rp.kp.symbol_name,
@@ -191,7 +199,7 @@ bool trace_kprobe_on_func_entry(struct trace_event_call *call)
 
 bool trace_kprobe_error_injectable(struct trace_event_call *call)
 {
-	struct trace_kprobe *tk = (struct trace_kprobe *)call->data;
+	struct trace_kprobe *tk = trace_kprobe_primary_from_call(call);
 
 	return within_error_injection_list(trace_kprobe_address(tk));
 }
@@ -295,28 +303,40 @@ static inline int __enable_trace_kprobe(struct trace_kprobe *tk)
  * Enable trace_probe
  * if the file is NULL, enable "perf" handler, or enable "trace" handler.
  */
-static int
-enable_trace_kprobe(struct trace_kprobe *tk, struct trace_event_file *file)
+static int enable_trace_kprobe(struct trace_event_call *call,
+				struct trace_event_file *file)
 {
-	bool enabled = trace_probe_is_enabled(&tk->tp);
-	int ret = 0;
+	struct trace_probe *pos, *tp = trace_probe_primary_from_call(call);
+	struct trace_kprobe *tk;
+	bool enabled = trace_probe_is_enabled(tp);
+	int ret = 0, ecode;
 
 	if (file) {
-		ret = trace_probe_add_file(&tk->tp, file);
+		ret = trace_probe_add_file(tp, file);
 		if (ret)
 			return ret;
 	} else
-		trace_probe_set_flag(&tk->tp, TP_FLAG_PROFILE);
+		trace_probe_set_flag(tp, TP_FLAG_PROFILE);
 
 	if (enabled)
 		return 0;
 
-	ret = __enable_trace_kprobe(tk);
-	if (ret) {
+	enabled = false;
+	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
+		tk = container_of(pos, struct trace_kprobe, tp);
+		ecode = __enable_trace_kprobe(tk);
+		if (ecode)
+			ret = ecode;	/* Save the last error code */
+		else
+			enabled = true;
+	}
+
+	if (!enabled) {
+		/* No probe is enabled. Roll back */
 		if (file)
-			trace_probe_remove_file(&tk->tp, file);
+			trace_probe_remove_file(tp, file);
 		else
-			trace_probe_clear_flag(&tk->tp, TP_FLAG_PROFILE);
+			trace_probe_clear_flag(tp, TP_FLAG_PROFILE);
 	}
 
 	return ret;
@@ -326,10 +346,11 @@ enable_trace_kprobe(struct trace_kprobe *tk, struct trace_event_file *file)
  * Disable trace_probe
  * if the file is NULL, disable "perf" handler, or disable "trace" handler.
  */
-static int
-disable_trace_kprobe(struct trace_kprobe *tk, struct trace_event_file *file)
+static int disable_trace_kprobe(struct trace_event_call *call,
+				struct trace_event_file *file)
 {
-	struct trace_probe *tp = &tk->tp;
+	struct trace_probe *pos, *tp = trace_probe_primary_from_call(call);
+	struct trace_kprobe *tk;
 	int ret = 0;
 
 	if (file) {
@@ -341,7 +362,13 @@ disable_trace_kprobe(struct trace_kprobe *tk, struct trace_event_file *file)
 	} else
 		trace_probe_clear_flag(tp, TP_FLAG_PROFILE);
 
-	if (!trace_probe_is_enabled(tp) && trace_kprobe_is_registered(tk)) {
+	if (trace_probe_is_enabled(tp))
+		goto out;
+
+	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
+		tk = container_of(pos, struct trace_kprobe, tp);
+		if (!trace_kprobe_is_registered(tk))
+			continue;
 		if (trace_kprobe_is_return(tk))
 			disable_kretprobe(&tk->rp);
 		else
@@ -1089,7 +1116,8 @@ print_kprobe_event(struct trace_iterator *iter, int flags,
 	struct trace_probe *tp;
 
 	field = (struct kprobe_trace_entry_head *)iter->ent;
-	tp = container_of(event, struct trace_probe, call.event);
+	tp = trace_probe_primary_from_call(
+		container_of(event, struct trace_event_call, event));
 
 	trace_seq_printf(s, "%s: (", trace_probe_name(tp));
 
@@ -1116,7 +1144,8 @@ print_kretprobe_event(struct trace_iterator *iter, int flags,
 	struct trace_probe *tp;
 
 	field = (struct kretprobe_trace_entry_head *)iter->ent;
-	tp = container_of(event, struct trace_probe, call.event);
+	tp = trace_probe_primary_from_call(
+		container_of(event, struct trace_event_call, event));
 
 	trace_seq_printf(s, "%s: (", trace_probe_name(tp));
 
@@ -1145,23 +1174,23 @@ static int kprobe_event_define_fields(struct trace_event_call *event_call)
 {
 	int ret;
 	struct kprobe_trace_entry_head field;
-	struct trace_kprobe *tk = (struct trace_kprobe *)event_call->data;
+	struct trace_probe *tp = trace_probe_primary_from_call(event_call);
 
 	DEFINE_FIELD(unsigned long, ip, FIELD_STRING_IP, 0);
 
-	return traceprobe_define_arg_fields(event_call, sizeof(field), &tk->tp);
+	return traceprobe_define_arg_fields(event_call, sizeof(field), tp);
 }
 
 static int kretprobe_event_define_fields(struct trace_event_call *event_call)
 {
 	int ret;
 	struct kretprobe_trace_entry_head field;
-	struct trace_kprobe *tk = (struct trace_kprobe *)event_call->data;
+	struct trace_probe *tp = trace_probe_primary_from_call(event_call);
 
 	DEFINE_FIELD(unsigned long, func, FIELD_STRING_FUNC, 0);
 	DEFINE_FIELD(unsigned long, ret_ip, FIELD_STRING_RETIP, 0);
 
-	return traceprobe_define_arg_fields(event_call, sizeof(field), &tk->tp);
+	return traceprobe_define_arg_fields(event_call, sizeof(field), tp);
 }
 
 #ifdef CONFIG_PERF_EVENTS
@@ -1289,20 +1318,19 @@ int bpf_get_kprobe_info(const struct perf_event *event, u32 *fd_type,
 static int kprobe_register(struct trace_event_call *event,
 			   enum trace_reg type, void *data)
 {
-	struct trace_kprobe *tk = (struct trace_kprobe *)event->data;
 	struct trace_event_file *file = data;
 
 	switch (type) {
 	case TRACE_REG_REGISTER:
-		return enable_trace_kprobe(tk, file);
+		return enable_trace_kprobe(event, file);
 	case TRACE_REG_UNREGISTER:
-		return disable_trace_kprobe(tk, file);
+		return disable_trace_kprobe(event, file);
 
 #ifdef CONFIG_PERF_EVENTS
 	case TRACE_REG_PERF_REGISTER:
-		return enable_trace_kprobe(tk, NULL);
+		return enable_trace_kprobe(event, NULL);
 	case TRACE_REG_PERF_UNREGISTER:
-		return disable_trace_kprobe(tk, NULL);
+		return disable_trace_kprobe(event, NULL);
 	case TRACE_REG_PERF_OPEN:
 	case TRACE_REG_PERF_CLOSE:
 	case TRACE_REG_PERF_ADD:
@@ -1369,7 +1397,6 @@ static inline void init_trace_event_call(struct trace_kprobe *tk)
 
 	call->flags = TRACE_EVENT_FL_KPROBE;
 	call->class->reg = kprobe_register;
-	call->data = tk;
 }
 
 static int register_kprobe_event(struct trace_kprobe *tk)
@@ -1430,9 +1457,7 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
 
 void destroy_local_trace_kprobe(struct trace_event_call *event_call)
 {
-	struct trace_kprobe *tk;
-
-	tk = container_of(event_call, struct trace_kprobe, tp.call);
+	struct trace_kprobe *tk = trace_kprobe_primary_from_call(event_call);
 
 	if (trace_probe_is_enabled(&tk->tp)) {
 		WARN_ON(1);
@@ -1577,7 +1602,8 @@ static __init int kprobe_trace_self_tests_init(void)
 				pr_warn("error on getting probe file.\n");
 				warn++;
 			} else
-				enable_trace_kprobe(tk, file);
+				enable_trace_kprobe(
+					trace_probe_event_call(&tk->tp), file);
 		}
 	}
 
@@ -1598,7 +1624,8 @@ static __init int kprobe_trace_self_tests_init(void)
 				pr_warn("error on getting probe file.\n");
 				warn++;
 			} else
-				enable_trace_kprobe(tk, file);
+				enable_trace_kprobe(
+					trace_probe_event_call(&tk->tp), file);
 		}
 	}
 
@@ -1631,7 +1658,8 @@ static __init int kprobe_trace_self_tests_init(void)
 			pr_warn("error on getting probe file.\n");
 			warn++;
 		} else
-			disable_trace_kprobe(tk, file);
+			disable_trace_kprobe(
+				trace_probe_event_call(&tk->tp), file);
 	}
 
 	tk = find_trace_kprobe("testprobe2", KPROBE_EVENT_SYSTEM);
@@ -1649,7 +1677,8 @@ static __init int kprobe_trace_self_tests_init(void)
 			pr_warn("error on getting probe file.\n");
 			warn++;
 		} else
-			disable_trace_kprobe(tk, file);
+			disable_trace_kprobe(
+				trace_probe_event_call(&tk->tp), file);
 	}
 
 	ret = trace_run_command("-:testprobe", create_or_delete_trace_kprobe);
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index dbef0d135075..28733bd6b607 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -889,40 +889,59 @@ int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 
 void trace_probe_cleanup(struct trace_probe *tp)
 {
-	struct trace_event_call *call = trace_probe_event_call(tp);
 	int i;
 
 	for (i = 0; i < tp->nr_args; i++)
 		traceprobe_free_probe_arg(&tp->args[i]);
 
-	kfree(call->class->system);
-	kfree(call->name);
-	kfree(call->print_fmt);
+	if (tp->event) {
+		struct trace_event_call *call = trace_probe_event_call(tp);
+
+		kfree(tp->event->class.system);
+		kfree(call->name);
+		kfree(call->print_fmt);
+		kfree(tp->event);
+		tp->event = NULL;
+	}
 }
 
 int trace_probe_init(struct trace_probe *tp, const char *event,
 		     const char *group)
 {
-	struct trace_event_call *call = trace_probe_event_call(tp);
+	struct trace_event_call *call;
+	int ret = 0;
 
 	if (!event || !group)
 		return -EINVAL;
 
-	call->class = &tp->class;
-	call->name = kstrdup(event, GFP_KERNEL);
-	if (!call->name)
+	tp->event = kzalloc(sizeof(struct trace_probe_event), GFP_KERNEL);
+	if (!tp->event)
 		return -ENOMEM;
 
-	tp->class.system = kstrdup(group, GFP_KERNEL);
-	if (!tp->class.system) {
-		kfree(call->name);
-		call->name = NULL;
-		return -ENOMEM;
+	call = trace_probe_event_call(tp);
+	call->class = &tp->event->class;
+	call->name = kstrdup(event, GFP_KERNEL);
+	if (!call->name) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	tp->event->class.system = kstrdup(group, GFP_KERNEL);
+	if (!tp->event->class.system) {
+		ret = -ENOMEM;
+		goto error;
 	}
-	INIT_LIST_HEAD(&tp->files);
-	INIT_LIST_HEAD(&tp->class.fields);
+	INIT_LIST_HEAD(&tp->event->files);
+	INIT_LIST_HEAD(&tp->event->class.fields);
+	INIT_LIST_HEAD(&tp->event->probes);
+	INIT_LIST_HEAD(&tp->list);
+	list_add(&tp->event->probes, &tp->list);
 
 	return 0;
+
+error:
+	trace_probe_cleanup(tp);
+	return ret;
 }
 
 int trace_probe_register_event_call(struct trace_probe *tp)
@@ -951,7 +970,7 @@ int trace_probe_add_file(struct trace_probe *tp, struct trace_event_file *file)
 
 	link->file = file;
 	INIT_LIST_HEAD(&link->list);
-	list_add_tail_rcu(&link->list, &tp->files);
+	list_add_tail_rcu(&link->list, &tp->event->files);
 	trace_probe_set_flag(tp, TP_FLAG_TRACE);
 	return 0;
 }
@@ -982,7 +1001,7 @@ int trace_probe_remove_file(struct trace_probe *tp,
 	synchronize_rcu();
 	kfree(link);
 
-	if (list_empty(&tp->files))
+	if (list_empty(&tp->event->files))
 		trace_probe_clear_flag(tp, TP_FLAG_TRACE);
 
 	return 0;
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index d1714820efe1..0b84abb884c2 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -222,11 +222,18 @@ struct probe_arg {
 	const struct fetch_type	*type;	/* Type of this argument */
 };
 
-struct trace_probe {
+/* Event call and class holder */
+struct trace_probe_event {
 	unsigned int			flags;	/* For TP_FLAG_* */
 	struct trace_event_class	class;
 	struct trace_event_call		call;
 	struct list_head 		files;
+	struct list_head		probes;
+};
+
+struct trace_probe {
+	struct list_head		list;
+	struct trace_probe_event	*event;
 	ssize_t				size;	/* trace entry size */
 	unsigned int			nr_args;
 	struct probe_arg		args[];
@@ -240,19 +247,19 @@ struct event_file_link {
 static inline bool trace_probe_test_flag(struct trace_probe *tp,
 					 unsigned int flag)
 {
-	return !!(tp->flags & flag);
+	return !!(tp->event->flags & flag);
 }
 
 static inline void trace_probe_set_flag(struct trace_probe *tp,
 					unsigned int flag)
 {
-	tp->flags |= flag;
+	tp->event->flags |= flag;
 }
 
 static inline void trace_probe_clear_flag(struct trace_probe *tp,
 					  unsigned int flag)
 {
-	tp->flags &= ~flag;
+	tp->event->flags &= ~flag;
 }
 
 static inline bool trace_probe_is_enabled(struct trace_probe *tp)
@@ -262,29 +269,48 @@ static inline bool trace_probe_is_enabled(struct trace_probe *tp)
 
 static inline const char *trace_probe_name(struct trace_probe *tp)
 {
-	return trace_event_name(&tp->call);
+	return trace_event_name(&tp->event->call);
 }
 
 static inline const char *trace_probe_group_name(struct trace_probe *tp)
 {
-	return tp->call.class->system;
+	return tp->event->call.class->system;
 }
 
 static inline struct trace_event_call *
 	trace_probe_event_call(struct trace_probe *tp)
 {
-	return &tp->call;
+	return &tp->event->call;
+}
+
+static inline struct trace_probe_event *
+trace_probe_event_from_call(struct trace_event_call *event_call)
+{
+	return container_of(event_call, struct trace_probe_event, call);
+}
+
+static inline struct trace_probe *
+trace_probe_primary_from_call(struct trace_event_call *call)
+{
+	struct trace_probe_event *tpe = trace_probe_event_from_call(call);
+
+	return list_first_entry(&tpe->probes, struct trace_probe, list);
+}
+
+static inline struct list_head *trace_probe_probe_list(struct trace_probe *tp)
+{
+	return &tp->event->probes;
 }
 
 static inline int trace_probe_unregister_event_call(struct trace_probe *tp)
 {
 	/* tp->event is unregistered in trace_remove_event_call() */
-	return trace_remove_event_call(&tp->call);
+	return trace_remove_event_call(&tp->event->call);
 }
 
 static inline bool trace_probe_has_single_file(struct trace_probe *tp)
 {
-	return !!list_is_singular(&tp->files);
+	return !!list_is_singular(&tp->event->files);
 }
 
 int trace_probe_init(struct trace_probe *tp, const char *event,
@@ -298,9 +324,9 @@ struct event_file_link *trace_probe_get_file_link(struct trace_probe *tp,
 						struct trace_event_file *file);
 
 #define trace_probe_for_each_link(pos, tp)	\
-	list_for_each_entry(pos, &(tp)->files, list)
+	list_for_each_entry(pos, &(tp)->event->files, list)
 #define trace_probe_for_each_link_rcu(pos, tp)	\
-	list_for_each_entry_rcu(pos, &(tp)->files, list)
+	list_for_each_entry_rcu(pos, &(tp)->event->files, list)
 
 /* Check the name is good for event/group/fields */
 static inline bool is_good_name(const char *name)
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 7fb9353b47d9..3a9a7582400d 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -293,6 +293,14 @@ static bool trace_uprobe_match(const char *system, const char *event,
 	    (!system || strcmp(trace_probe_group_name(&tu->tp), system) == 0);
 }
 
+static nokprobe_inline struct trace_uprobe *
+trace_uprobe_primary_from_call(struct trace_event_call *call)
+{
+	struct trace_probe *tp = trace_probe_primary_from_call(call);
+
+	return container_of(tp, struct trace_uprobe, tp);
+}
+
 /*
  * Allocate new trace_uprobe and initialize it (including uprobes).
  */
@@ -892,7 +900,8 @@ print_uprobe_event(struct trace_iterator *iter, int flags, struct trace_event *e
 	u8 *data;
 
 	entry = (struct uprobe_trace_entry_head *)iter->ent;
-	tu = container_of(event, struct trace_uprobe, tp.call.event);
+	tu = trace_uprobe_primary_from_call(
+		container_of(event, struct trace_event_call, event));
 
 	if (is_ret_probe(tu)) {
 		trace_seq_printf(s, "%s: (0x%lx <- 0x%lx)",
@@ -919,27 +928,41 @@ typedef bool (*filter_func_t)(struct uprobe_consumer *self,
 				enum uprobe_filter_ctx ctx,
 				struct mm_struct *mm);
 
-static int
-probe_event_enable(struct trace_uprobe *tu, struct trace_event_file *file,
-		   filter_func_t filter)
+static int trace_uprobe_enable(struct trace_uprobe *tu, filter_func_t filter)
 {
-	bool enabled = trace_probe_is_enabled(&tu->tp);
-	int ret;
+	tu->consumer.filter = filter;
+	tu->inode = d_real_inode(tu->path.dentry);
+
+	if (tu->ref_ctr_offset)
+		return uprobe_register_refctr(tu->inode, tu->offset,
+				tu->ref_ctr_offset, &tu->consumer);
+	else
+		return uprobe_register(tu->inode, tu->offset, &tu->consumer);
+}
+
+static int probe_event_enable(struct trace_event_call *call,
+			struct trace_event_file *file, filter_func_t filter)
+{
+	struct trace_probe *pos, *tp = trace_probe_primary_from_call(call);
+	struct trace_uprobe *tu;
+	bool enabled = trace_probe_is_enabled(tp);
+	int ret = 0, ecode;
 
 	if (file) {
-		if (trace_probe_test_flag(&tu->tp, TP_FLAG_PROFILE))
+		if (trace_probe_test_flag(tp, TP_FLAG_PROFILE))
 			return -EINTR;
 
-		ret = trace_probe_add_file(&tu->tp, file);
+		ret = trace_probe_add_file(tp, file);
 		if (ret < 0)
 			return ret;
 	} else {
-		if (trace_probe_test_flag(&tu->tp, TP_FLAG_TRACE))
+		if (trace_probe_test_flag(tp, TP_FLAG_TRACE))
 			return -EINTR;
 
-		trace_probe_set_flag(&tu->tp, TP_FLAG_PROFILE);
+		trace_probe_set_flag(tp, TP_FLAG_PROFILE);
 	}
 
+	tu = container_of(tp, struct trace_uprobe, tp);
 	WARN_ON(!uprobe_filter_is_empty(&tu->filter));
 
 	if (enabled)
@@ -949,16 +972,16 @@ probe_event_enable(struct trace_uprobe *tu, struct trace_event_file *file,
 	if (ret)
 		goto err_flags;
 
-	tu->consumer.filter = filter;
-	tu->inode = d_real_inode(tu->path.dentry);
-	if (tu->ref_ctr_offset) {
-		ret = uprobe_register_refctr(tu->inode, tu->offset,
-				tu->ref_ctr_offset, &tu->consumer);
-	} else {
-		ret = uprobe_register(tu->inode, tu->offset, &tu->consumer);
+	enabled = false;
+	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
+		tu = container_of(pos, struct trace_uprobe, tp);
+		ecode = trace_uprobe_enable(tu, filter);
+		if (ecode)
+			ret = ecode;
+		else
+			enabled = true;
 	}
-
-	if (ret)
+	if (!enabled)
 		goto err_buffer;
 
 	return 0;
@@ -968,32 +991,39 @@ probe_event_enable(struct trace_uprobe *tu, struct trace_event_file *file,
 
  err_flags:
 	if (file)
-		trace_probe_remove_file(&tu->tp, file);
+		trace_probe_remove_file(tp, file);
 	else
-		trace_probe_clear_flag(&tu->tp, TP_FLAG_PROFILE);
+		trace_probe_clear_flag(tp, TP_FLAG_PROFILE);
 
 	return ret;
 }
 
-static void
-probe_event_disable(struct trace_uprobe *tu, struct trace_event_file *file)
+static void probe_event_disable(struct trace_event_call *call,
+				struct trace_event_file *file)
 {
-	if (!trace_probe_is_enabled(&tu->tp))
+	struct trace_probe *pos, *tp = trace_probe_primary_from_call(call);
+	struct trace_uprobe *tu;
+
+	if (!trace_probe_is_enabled(tp))
 		return;
 
 	if (file) {
-		if (trace_probe_remove_file(&tu->tp, file) < 0)
+		if (trace_probe_remove_file(tp, file) < 0)
 			return;
 
-		if (trace_probe_is_enabled(&tu->tp))
+		if (trace_probe_is_enabled(tp))
 			return;
 	} else
-		trace_probe_clear_flag(&tu->tp, TP_FLAG_PROFILE);
+		trace_probe_clear_flag(tp, TP_FLAG_PROFILE);
 
+	tu = container_of(tp, struct trace_uprobe, tp);
 	WARN_ON(!uprobe_filter_is_empty(&tu->filter));
 
-	uprobe_unregister(tu->inode, tu->offset, &tu->consumer);
-	tu->inode = NULL;
+	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
+		tu = container_of(pos, struct trace_uprobe, tp);
+		uprobe_unregister(tu->inode, tu->offset, &tu->consumer);
+		tu->inode = NULL;
+	}
 
 	uprobe_buffer_disable();
 }
@@ -1002,7 +1032,7 @@ static int uprobe_event_define_fields(struct trace_event_call *event_call)
 {
 	int ret, size;
 	struct uprobe_trace_entry_head field;
-	struct trace_uprobe *tu = event_call->data;
+	struct trace_uprobe *tu = trace_uprobe_primary_from_call(event_call);
 
 	if (is_ret_probe(tu)) {
 		DEFINE_FIELD(unsigned long, vaddr[0], FIELD_STRING_FUNC, 0);
@@ -1095,6 +1125,23 @@ static int uprobe_perf_open(struct trace_uprobe *tu, struct perf_event *event)
 	return err;
 }
 
+static int uprobe_perf_multi_call(struct trace_event_call *call,
+				  struct perf_event *event,
+		int (*op)(struct trace_uprobe *tu, struct perf_event *event))
+{
+	struct trace_probe *pos, *tp = trace_probe_primary_from_call(call);
+	struct trace_uprobe *tu;
+	int ret = 0;
+
+	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
+		tu = container_of(pos, struct trace_uprobe, tp);
+		ret = op(tu, event);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
 static bool uprobe_perf_filter(struct uprobe_consumer *uc,
 				enum uprobe_filter_ctx ctx, struct mm_struct *mm)
 {
@@ -1208,30 +1255,29 @@ static int
 trace_uprobe_register(struct trace_event_call *event, enum trace_reg type,
 		      void *data)
 {
-	struct trace_uprobe *tu = event->data;
 	struct trace_event_file *file = data;
 
 	switch (type) {
 	case TRACE_REG_REGISTER:
-		return probe_event_enable(tu, file, NULL);
+		return probe_event_enable(event, file, NULL);
 
 	case TRACE_REG_UNREGISTER:
-		probe_event_disable(tu, file);
+		probe_event_disable(event, file);
 		return 0;
 
 #ifdef CONFIG_PERF_EVENTS
 	case TRACE_REG_PERF_REGISTER:
-		return probe_event_enable(tu, NULL, uprobe_perf_filter);
+		return probe_event_enable(event, NULL, uprobe_perf_filter);
 
 	case TRACE_REG_PERF_UNREGISTER:
-		probe_event_disable(tu, NULL);
+		probe_event_disable(event, NULL);
 		return 0;
 
 	case TRACE_REG_PERF_OPEN:
-		return uprobe_perf_open(tu, data);
+		return uprobe_perf_multi_call(event, data, uprobe_perf_open);
 
 	case TRACE_REG_PERF_CLOSE:
-		return uprobe_perf_close(tu, data);
+		return uprobe_perf_multi_call(event, data, uprobe_perf_close);
 
 #endif
 	default:
@@ -1325,7 +1371,6 @@ static inline void init_trace_event_call(struct trace_uprobe *tu)
 
 	call->flags = TRACE_EVENT_FL_UPROBE;
 	call->class->reg = trace_uprobe_register;
-	call->data = tu;
 }
 
 static int register_uprobe_event(struct trace_uprobe *tu)
@@ -1394,7 +1439,7 @@ void destroy_local_trace_uprobe(struct trace_event_call *event_call)
 {
 	struct trace_uprobe *tu;
 
-	tu = container_of(event_call, struct trace_uprobe, tp.call);
+	tu = trace_uprobe_primary_from_call(event_call);
 
 	free_trace_uprobe(tu);
 }

