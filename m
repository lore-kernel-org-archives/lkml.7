Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86649C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 598422147A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733086AbfFYTP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 15:15:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:34658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732699AbfFYTPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 15:15:48 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F20621479;
        Tue, 25 Jun 2019 19:15:47 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hfquw-0002Me-GX; Tue, 25 Jun 2019 15:15:46 -0400
Message-Id: <20190625191546.402099665@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 25 Jun 2019 15:15:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 10/12] tracing/probe: Add probe event name and group name accesses APIs
References: <20190625191510.599310671@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add trace_probe_name() and trace_probe_group_name() functions
for accessing probe name and group name of trace_probe.

Link: http://lkml.kernel.org/r/155931586717.28323.8738615064952254761.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_kprobe.c | 24 ++++++++++++------------
 kernel/trace/trace_probe.h  | 10 ++++++++++
 kernel/trace/trace_uprobe.c | 22 +++++++++++-----------
 3 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index c3ab84cb25c8..3cf8cee4f276 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -142,8 +142,8 @@ static bool trace_kprobe_match(const char *system, const char *event,
 {
 	struct trace_kprobe *tk = to_trace_kprobe(ev);
 
-	return strcmp(trace_event_name(&tk->tp.call), event) == 0 &&
-	    (!system || strcmp(tk->tp.call.class->system, system) == 0);
+	return strcmp(trace_probe_name(&tk->tp), event) == 0 &&
+	    (!system || strcmp(trace_probe_group_name(&tk->tp), system) == 0);
 }
 
 static nokprobe_inline unsigned long trace_kprobe_nhit(struct trace_kprobe *tk)
@@ -263,8 +263,8 @@ static struct trace_kprobe *find_trace_kprobe(const char *event,
 	struct trace_kprobe *tk;
 
 	for_each_trace_kprobe(tk, pos)
-		if (strcmp(trace_event_name(&tk->tp.call), event) == 0 &&
-		    strcmp(tk->tp.call.class->system, group) == 0)
+		if (strcmp(trace_probe_name(&tk->tp), event) == 0 &&
+		    strcmp(trace_probe_group_name(&tk->tp), group) == 0)
 			return tk;
 	return NULL;
 }
@@ -453,8 +453,8 @@ static int register_trace_kprobe(struct trace_kprobe *tk)
 	mutex_lock(&event_mutex);
 
 	/* Delete old (same name) event if exist */
-	old_tk = find_trace_kprobe(trace_event_name(&tk->tp.call),
-			tk->tp.call.class->system);
+	old_tk = find_trace_kprobe(trace_probe_name(&tk->tp),
+				   trace_probe_group_name(&tk->tp));
 	if (old_tk) {
 		ret = unregister_trace_kprobe(old_tk);
 		if (ret < 0)
@@ -507,7 +507,7 @@ static int trace_kprobe_module_callback(struct notifier_block *nb,
 			ret = __register_trace_kprobe(tk);
 			if (ret)
 				pr_warn("Failed to re-register probe %s on %s: %d\n",
-					trace_event_name(&tk->tp.call),
+					trace_probe_name(&tk->tp),
 					mod->name, ret);
 		}
 	}
@@ -737,8 +737,8 @@ static int trace_kprobe_show(struct seq_file *m, struct dyn_event *ev)
 	int i;
 
 	seq_putc(m, trace_kprobe_is_return(tk) ? 'r' : 'p');
-	seq_printf(m, ":%s/%s", tk->tp.call.class->system,
-			trace_event_name(&tk->tp.call));
+	seq_printf(m, ":%s/%s", trace_probe_group_name(&tk->tp),
+				trace_probe_name(&tk->tp));
 
 	if (!tk->symbol)
 		seq_printf(m, " 0x%p", tk->rp.kp.addr);
@@ -812,7 +812,7 @@ static int probes_profile_seq_show(struct seq_file *m, void *v)
 
 	tk = to_trace_kprobe(ev);
 	seq_printf(m, "  %-44s %15lu %15lu\n",
-		   trace_event_name(&tk->tp.call),
+		   trace_probe_name(&tk->tp),
 		   trace_kprobe_nhit(tk),
 		   tk->rp.kp.nmissed);
 
@@ -1084,7 +1084,7 @@ print_kprobe_event(struct trace_iterator *iter, int flags,
 	field = (struct kprobe_trace_entry_head *)iter->ent;
 	tp = container_of(event, struct trace_probe, call.event);
 
-	trace_seq_printf(s, "%s: (", trace_event_name(&tp->call));
+	trace_seq_printf(s, "%s: (", trace_probe_name(tp));
 
 	if (!seq_print_ip_sym(s, field->ip, flags | TRACE_ITER_SYM_OFFSET))
 		goto out;
@@ -1111,7 +1111,7 @@ print_kretprobe_event(struct trace_iterator *iter, int flags,
 	field = (struct kretprobe_trace_entry_head *)iter->ent;
 	tp = container_of(event, struct trace_probe, call.event);
 
-	trace_seq_printf(s, "%s: (", trace_event_name(&tp->call));
+	trace_seq_printf(s, "%s: (", trace_probe_name(tp));
 
 	if (!seq_print_ip_sym(s, field->ret_ip, flags | TRACE_ITER_SYM_OFFSET))
 		goto out;
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 87d48d850b63..67424cb5d5d6 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -266,6 +266,16 @@ static inline bool trace_probe_is_registered(struct trace_probe *tp)
 	return trace_probe_test_flag(tp, TP_FLAG_REGISTERED);
 }
 
+static inline const char *trace_probe_name(struct trace_probe *tp)
+{
+	return trace_event_name(&tp->call);
+}
+
+static inline const char *trace_probe_group_name(struct trace_probe *tp)
+{
+	return tp->call.class->system;
+}
+
 static inline int trace_probe_unregister_event_call(struct trace_probe *tp)
 {
 	/* tp->event is unregistered in trace_remove_event_call() */
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index f8e23ed47823..09fdba3ee9d9 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -289,8 +289,8 @@ static bool trace_uprobe_match(const char *system, const char *event,
 {
 	struct trace_uprobe *tu = to_trace_uprobe(ev);
 
-	return strcmp(trace_event_name(&tu->tp.call), event) == 0 &&
-		(!system || strcmp(tu->tp.call.class->system, system) == 0);
+	return strcmp(trace_probe_name(&tu->tp), event) == 0 &&
+	    (!system || strcmp(trace_probe_group_name(&tu->tp), system) == 0);
 }
 
 /*
@@ -340,8 +340,8 @@ static struct trace_uprobe *find_probe_event(const char *event, const char *grou
 	struct trace_uprobe *tu;
 
 	for_each_trace_uprobe(tu, pos)
-		if (strcmp(trace_event_name(&tu->tp.call), event) == 0 &&
-		    strcmp(tu->tp.call.class->system, group) == 0)
+		if (strcmp(trace_probe_name(&tu->tp), event) == 0 &&
+		    strcmp(trace_probe_group_name(&tu->tp), group) == 0)
 			return tu;
 
 	return NULL;
@@ -376,8 +376,8 @@ static struct trace_uprobe *find_old_trace_uprobe(struct trace_uprobe *new)
 	struct trace_uprobe *tmp, *old = NULL;
 	struct inode *new_inode = d_real_inode(new->path.dentry);
 
-	old = find_probe_event(trace_event_name(&new->tp.call),
-				new->tp.call.class->system);
+	old = find_probe_event(trace_probe_name(&new->tp),
+				trace_probe_group_name(&new->tp));
 
 	for_each_trace_uprobe(tmp, pos) {
 		if ((old ? old != tmp : true) &&
@@ -624,8 +624,8 @@ static int trace_uprobe_show(struct seq_file *m, struct dyn_event *ev)
 	char c = is_ret_probe(tu) ? 'r' : 'p';
 	int i;
 
-	seq_printf(m, "%c:%s/%s %s:0x%0*lx", c, tu->tp.call.class->system,
-			trace_event_name(&tu->tp.call), tu->filename,
+	seq_printf(m, "%c:%s/%s %s:0x%0*lx", c, trace_probe_group_name(&tu->tp),
+			trace_probe_name(&tu->tp), tu->filename,
 			(int)(sizeof(void *) * 2), tu->offset);
 
 	if (tu->ref_ctr_offset)
@@ -695,7 +695,7 @@ static int probes_profile_seq_show(struct seq_file *m, void *v)
 
 	tu = to_trace_uprobe(ev);
 	seq_printf(m, "  %s %-44s %15lu\n", tu->filename,
-			trace_event_name(&tu->tp.call), tu->nhit);
+			trace_probe_name(&tu->tp), tu->nhit);
 	return 0;
 }
 
@@ -896,12 +896,12 @@ print_uprobe_event(struct trace_iterator *iter, int flags, struct trace_event *e
 
 	if (is_ret_probe(tu)) {
 		trace_seq_printf(s, "%s: (0x%lx <- 0x%lx)",
-				 trace_event_name(&tu->tp.call),
+				 trace_probe_name(&tu->tp),
 				 entry->vaddr[1], entry->vaddr[0]);
 		data = DATAOF_TRACE_ENTRY(entry, true);
 	} else {
 		trace_seq_printf(s, "%s: (0x%lx)",
-				 trace_event_name(&tu->tp.call),
+				 trace_probe_name(&tu->tp),
 				 entry->vaddr[0]);
 		data = DATAOF_TRACE_ENTRY(entry, false);
 	}
-- 
2.20.1


