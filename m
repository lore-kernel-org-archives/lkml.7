Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F341C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26EF32086D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733127AbfFYTQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 15:16:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:34604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731803AbfFYTPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 15:15:47 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE491216E3;
        Tue, 25 Jun 2019 19:15:46 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hfquv-0002Kc-Qc; Tue, 25 Jun 2019 15:15:45 -0400
Message-Id: <20190625191545.714876166@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 25 Jun 2019 15:15:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 06/12] tracing/probe: Add trace_probe init and free functions
References: <20190625191510.599310671@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add common trace_probe init and cleanup function in
trace_probe.c, and use it from trace_kprobe.c and trace_uprobe.c

Link: http://lkml.kernel.org/r/155931582664.28323.5934870189034740822.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_kprobe.c | 49 ++++++++++---------------------------
 kernel/trace/trace_probe.c  | 36 +++++++++++++++++++++++++++
 kernel/trace/trace_probe.h  |  4 +++
 kernel/trace/trace_uprobe.c | 27 ++++----------------
 4 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 01fc49f08b70..c43c2d419ded 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -197,6 +197,16 @@ static int kprobe_dispatcher(struct kprobe *kp, struct pt_regs *regs);
 static int kretprobe_dispatcher(struct kretprobe_instance *ri,
 				struct pt_regs *regs);
 
+static void free_trace_kprobe(struct trace_kprobe *tk)
+{
+	if (tk) {
+		trace_probe_cleanup(&tk->tp);
+		kfree(tk->symbol);
+		free_percpu(tk->nhit);
+		kfree(tk);
+	}
+}
+
 /*
  * Allocate new trace_probe and initialize it (including kprobes).
  */
@@ -235,49 +245,17 @@ static struct trace_kprobe *alloc_trace_kprobe(const char *group,
 
 	tk->rp.maxactive = maxactive;
 
-	if (!event || !group) {
-		ret = -EINVAL;
-		goto error;
-	}
-
-	tk->tp.call.class = &tk->tp.class;
-	tk->tp.call.name = kstrdup(event, GFP_KERNEL);
-	if (!tk->tp.call.name)
-		goto error;
-
-	tk->tp.class.system = kstrdup(group, GFP_KERNEL);
-	if (!tk->tp.class.system)
+	ret = trace_probe_init(&tk->tp, event, group);
+	if (ret < 0)
 		goto error;
 
 	dyn_event_init(&tk->devent, &trace_kprobe_ops);
-	INIT_LIST_HEAD(&tk->tp.files);
 	return tk;
 error:
-	kfree(tk->tp.call.name);
-	kfree(tk->symbol);
-	free_percpu(tk->nhit);
-	kfree(tk);
+	free_trace_kprobe(tk);
 	return ERR_PTR(ret);
 }
 
-static void free_trace_kprobe(struct trace_kprobe *tk)
-{
-	int i;
-
-	if (!tk)
-		return;
-
-	for (i = 0; i < tk->tp.nr_args; i++)
-		traceprobe_free_probe_arg(&tk->tp.args[i]);
-
-	kfree(tk->tp.call.class->system);
-	kfree(tk->tp.call.name);
-	kfree(tk->tp.call.print_fmt);
-	kfree(tk->symbol);
-	free_percpu(tk->nhit);
-	kfree(tk);
-}
-
 static struct trace_kprobe *find_trace_kprobe(const char *event,
 					      const char *group)
 {
@@ -1400,7 +1378,6 @@ static struct trace_event_functions kprobe_funcs = {
 static inline void init_trace_event_call(struct trace_kprobe *tk,
 					 struct trace_event_call *call)
 {
-	INIT_LIST_HEAD(&call->class->fields);
 	if (trace_kprobe_is_return(tk)) {
 		call->event.funcs = &kretprobe_funcs;
 		call->class->define_fields = kretprobe_event_define_fields;
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index b6b0593844cd..fe4ee2e73d92 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -884,3 +884,39 @@ int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	}
 	return 0;
 }
+
+
+void trace_probe_cleanup(struct trace_probe *tp)
+{
+	int i;
+
+	for (i = 0; i < tp->nr_args; i++)
+		traceprobe_free_probe_arg(&tp->args[i]);
+
+	kfree(tp->call.class->system);
+	kfree(tp->call.name);
+	kfree(tp->call.print_fmt);
+}
+
+int trace_probe_init(struct trace_probe *tp, const char *event,
+		     const char *group)
+{
+	if (!event || !group)
+		return -EINVAL;
+
+	tp->call.class = &tp->class;
+	tp->call.name = kstrdup(event, GFP_KERNEL);
+	if (!tp->call.name)
+		return -ENOMEM;
+
+	tp->class.system = kstrdup(group, GFP_KERNEL);
+	if (!tp->class.system) {
+		kfree(tp->call.name);
+		tp->call.name = NULL;
+		return -ENOMEM;
+	}
+	INIT_LIST_HEAD(&tp->files);
+	INIT_LIST_HEAD(&tp->class.fields);
+
+	return 0;
+}
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 42816358dd48..818b1d7693ba 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -248,6 +248,10 @@ static inline bool trace_probe_is_registered(struct trace_probe *tp)
 	return !!(tp->flags & TP_FLAG_REGISTERED);
 }
 
+int trace_probe_init(struct trace_probe *tp, const char *event,
+		     const char *group);
+void trace_probe_cleanup(struct trace_probe *tp);
+
 /* Check the name is good for event/group/fields */
 static inline bool is_good_name(const char *name)
 {
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 34ce671b6080..b18b7eb1a76f 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -300,25 +300,17 @@ static struct trace_uprobe *
 alloc_trace_uprobe(const char *group, const char *event, int nargs, bool is_ret)
 {
 	struct trace_uprobe *tu;
-
-	if (!event || !group)
-		return ERR_PTR(-EINVAL);
+	int ret;
 
 	tu = kzalloc(SIZEOF_TRACE_UPROBE(nargs), GFP_KERNEL);
 	if (!tu)
 		return ERR_PTR(-ENOMEM);
 
-	tu->tp.call.class = &tu->tp.class;
-	tu->tp.call.name = kstrdup(event, GFP_KERNEL);
-	if (!tu->tp.call.name)
-		goto error;
-
-	tu->tp.class.system = kstrdup(group, GFP_KERNEL);
-	if (!tu->tp.class.system)
+	ret = trace_probe_init(&tu->tp, event, group);
+	if (ret < 0)
 		goto error;
 
 	dyn_event_init(&tu->devent, &trace_uprobe_ops);
-	INIT_LIST_HEAD(&tu->tp.files);
 	tu->consumer.handler = uprobe_dispatcher;
 	if (is_ret)
 		tu->consumer.ret_handler = uretprobe_dispatcher;
@@ -326,26 +318,18 @@ alloc_trace_uprobe(const char *group, const char *event, int nargs, bool is_ret)
 	return tu;
 
 error:
-	kfree(tu->tp.call.name);
 	kfree(tu);
 
-	return ERR_PTR(-ENOMEM);
+	return ERR_PTR(ret);
 }
 
 static void free_trace_uprobe(struct trace_uprobe *tu)
 {
-	int i;
-
 	if (!tu)
 		return;
 
-	for (i = 0; i < tu->tp.nr_args; i++)
-		traceprobe_free_probe_arg(&tu->tp.args[i]);
-
 	path_put(&tu->path);
-	kfree(tu->tp.call.class->system);
-	kfree(tu->tp.call.name);
-	kfree(tu->tp.call.print_fmt);
+	trace_probe_cleanup(&tu->tp);
 	kfree(tu->filename);
 	kfree(tu);
 }
@@ -1351,7 +1335,6 @@ static struct trace_event_functions uprobe_funcs = {
 static inline void init_trace_event_call(struct trace_uprobe *tu,
 					 struct trace_event_call *call)
 {
-	INIT_LIST_HEAD(&call->class->fields);
 	call->event.funcs = &uprobe_funcs;
 	call->class->define_fields = uprobe_event_define_fields;
 
-- 
2.20.1


