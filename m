Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0718C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F93826B91
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559315854;
	bh=oZBjrDviSkkQREIfE2wn+WHEa16K8pNhD30w83Yo450=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1QTkLVUD73R1Ata3e8ru6S2R1jYwQ2KAQvlf3YJ82pwrqcs5u6yv1mU523OJeOIph
	 WARZ4b14kzpzrecAC3/qsTMhLrjYv5JtNhlZtOG4T4eTSwN0AP3Jtq4Kev5NrM3EqM
	 TrrlQ3Bc6PCikz+6CoGt9eARE+hGITNi7zSmJSOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfEaPRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 11:17:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:34648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfEaPRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 11:17:32 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F59325432;
        Fri, 31 May 2019 15:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559315851;
        bh=oZBjrDviSkkQREIfE2wn+WHEa16K8pNhD30w83Yo450=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mUMpz9nreDIU0F1jNvLWzazYoUn6oMxD0F6vhqu4AnCkpe87QOjKSgrn42RU8Nfp2
         2wWdFl3RazUDH4sz/xARYc7V5H71l9DhGgTu7+dF532/dpIY/Fm+kDSnXsP/JSFT/4
         teLiykuPSwj04+mD3j2Ap5noOFig8Ev62EUtk/so=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/21] tracing/probe: Add trace_event_file access APIs for trace_probe
Date:   Sat,  1 Jun 2019 00:17:26 +0900
Message-Id: <155931584587.28323.372301976283354629.stgit@devnote2>
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

Add trace_event_file access APIs for trace_probe data structure.
This simplifies enabling/disabling operations in uprobe and kprobe
events so that those don't touch deep inside the trace_probe.

This also removing a redundant synchronization when the
kprobe event is used from perf, since the perf itself uses
tracepoint_synchronize_unregister() after disabling (ftrace-
defined) event, thus we don't have to synchronize in that
path. Also we don't need to identify local trace_kprobe too
anymore.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |   85 +++++++++++++++----------------------------
 kernel/trace/trace_probe.c  |   47 ++++++++++++++++++++++++
 kernel/trace/trace_probe.h  |   36 ++++++++++--------
 kernel/trace/trace_uprobe.c |   42 +++++++--------------
 4 files changed, 109 insertions(+), 101 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 7f802ee27266..87a52094378c 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -290,34 +290,27 @@ static inline int __enable_trace_kprobe(struct trace_kprobe *tk)
 static int
 enable_trace_kprobe(struct trace_kprobe *tk, struct trace_event_file *file)
 {
-	struct event_file_link *link;
+	bool enabled = trace_probe_is_enabled(&tk->tp);
 	int ret = 0;
 
 	if (file) {
-		link = kmalloc(sizeof(*link), GFP_KERNEL);
-		if (!link) {
-			ret = -ENOMEM;
-			goto out;
-		}
-
-		link->file = file;
-		list_add_tail_rcu(&link->list, &tk->tp.files);
+		ret = trace_probe_add_file(&tk->tp, file);
+		if (ret)
+			return ret;
+	} else
+		tk->tp.flags |= TP_FLAG_PROFILE;
 
-		tk->tp.flags |= TP_FLAG_TRACE;
-		ret = __enable_trace_kprobe(tk);
-		if (ret) {
-			list_del_rcu(&link->list);
-			kfree(link);
-			tk->tp.flags &= ~TP_FLAG_TRACE;
-		}
+	if (enabled)
+		return 0;
 
-	} else {
-		tk->tp.flags |= TP_FLAG_PROFILE;
-		ret = __enable_trace_kprobe(tk);
-		if (ret)
+	ret = __enable_trace_kprobe(tk);
+	if (ret) {
+		if (file)
+			trace_probe_remove_file(&tk->tp, file);
+		else
 			tk->tp.flags &= ~TP_FLAG_PROFILE;
 	}
- out:
+
 	return ret;
 }
 
@@ -328,54 +321,34 @@ enable_trace_kprobe(struct trace_kprobe *tk, struct trace_event_file *file)
 static int
 disable_trace_kprobe(struct trace_kprobe *tk, struct trace_event_file *file)
 {
-	struct event_file_link *link = NULL;
-	int wait = 0;
+	struct trace_probe *tp = &tk->tp;
 	int ret = 0;
 
 	if (file) {
-		link = find_event_file_link(&tk->tp, file);
-		if (!link) {
-			ret = -EINVAL;
-			goto out;
-		}
-
-		list_del_rcu(&link->list);
-		wait = 1;
-		if (!list_empty(&tk->tp.files))
+		if (!trace_probe_get_file_link(tp, file))
+			return -ENOENT;
+		if (!trace_probe_has_single_file(tp))
 			goto out;
-
-		tk->tp.flags &= ~TP_FLAG_TRACE;
+		tp->flags &= ~TP_FLAG_TRACE;
 	} else
-		tk->tp.flags &= ~TP_FLAG_PROFILE;
+		tp->flags &= ~TP_FLAG_PROFILE;
 
-	if (!trace_probe_is_enabled(&tk->tp) && trace_probe_is_registered(&tk->tp)) {
+	if (!trace_probe_is_enabled(tp) && trace_probe_is_registered(tp)) {
 		if (trace_kprobe_is_return(tk))
 			disable_kretprobe(&tk->rp);
 		else
 			disable_kprobe(&tk->rp.kp);
-		wait = 1;
 	}
 
-	/*
-	 * if tk is not added to any list, it must be a local trace_kprobe
-	 * created with perf_event_open. We don't need to wait for these
-	 * trace_kprobes
-	 */
-	if (list_empty(&tk->devent.list))
-		wait = 0;
  out:
-	if (wait) {
+	if (file)
 		/*
-		 * Synchronize with kprobe_trace_func/kretprobe_trace_func
-		 * to ensure disabled (all running handlers are finished).
-		 * This is not only for kfree(), but also the caller,
-		 * trace_remove_event_call() supposes it for releasing
-		 * event_call related objects, which will be accessed in
-		 * the kprobe_trace_func/kretprobe_trace_func.
+		 * Synchronization is done in below function. For perf event,
+		 * file == NULL and perf_trace_event_unreg() calls
+		 * tracepoint_synchronize_unregister() to ensure synchronize
+		 * event. We don't need to care about it.
 		 */
-		synchronize_rcu();
-		kfree(link);	/* Ignored if link == NULL */
-	}
+		trace_probe_remove_file(tp, file);
 
 	return ret;
 }
@@ -1044,7 +1017,7 @@ kprobe_trace_func(struct trace_kprobe *tk, struct pt_regs *regs)
 {
 	struct event_file_link *link;
 
-	list_for_each_entry_rcu(link, &tk->tp.files, list)
+	trace_probe_for_each_link_rcu(link, &tk->tp)
 		__kprobe_trace_func(tk, regs, link->file);
 }
 NOKPROBE_SYMBOL(kprobe_trace_func);
@@ -1094,7 +1067,7 @@ kretprobe_trace_func(struct trace_kprobe *tk, struct kretprobe_instance *ri,
 {
 	struct event_file_link *link;
 
-	list_for_each_entry_rcu(link, &tk->tp.files, list)
+	trace_probe_for_each_link_rcu(link, &tk->tp)
 		__kretprobe_trace_func(tk, ri, regs, link->file);
 }
 NOKPROBE_SYMBOL(kretprobe_trace_func);
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 509a26024b4f..abb05608a09d 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -936,3 +936,50 @@ int trace_probe_register_event_call(struct trace_probe *tp)
 
 	return ret;
 }
+
+int trace_probe_add_file(struct trace_probe *tp, struct trace_event_file *file)
+{
+	struct event_file_link *link;
+
+	link = kmalloc(sizeof(*link), GFP_KERNEL);
+	if (!link)
+		return -ENOMEM;
+
+	link->file = file;
+	INIT_LIST_HEAD(&link->list);
+	list_add_tail_rcu(&link->list, &tp->files);
+	tp->flags |= TP_FLAG_TRACE;
+	return 0;
+}
+
+struct event_file_link *trace_probe_get_file_link(struct trace_probe *tp,
+						  struct trace_event_file *file)
+{
+	struct event_file_link *link;
+
+	trace_probe_for_each_link(link, tp) {
+		if (link->file == file)
+			return link;
+	}
+
+	return NULL;
+}
+
+int trace_probe_remove_file(struct trace_probe *tp,
+			    struct trace_event_file *file)
+{
+	struct event_file_link *link;
+
+	link = trace_probe_get_file_link(tp, file);
+	if (!link)
+		return -ENOENT;
+
+	list_del_rcu(&link->list);
+	synchronize_rcu();
+	kfree(link);
+
+	if (list_empty(&tp->files))
+		tp->flags &= ~TP_FLAG_TRACE;
+
+	return 0;
+}
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 01d7b222e004..ab02007e131d 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -248,16 +248,32 @@ static inline bool trace_probe_is_registered(struct trace_probe *tp)
 	return !!(tp->flags & TP_FLAG_REGISTERED);
 }
 
-int trace_probe_init(struct trace_probe *tp, const char *event,
-		     const char *group);
-void trace_probe_cleanup(struct trace_probe *tp);
-int trace_probe_register_event_call(struct trace_probe *tp);
 static inline int trace_probe_unregister_event_call(struct trace_probe *tp)
 {
 	/* tp->event is unregistered in trace_remove_event_call() */
 	return trace_remove_event_call(&tp->call);
 }
 
+static inline bool trace_probe_has_single_file(struct trace_probe *tp)
+{
+	return !!list_is_singular(&tp->files);
+}
+
+int trace_probe_init(struct trace_probe *tp, const char *event,
+		     const char *group);
+void trace_probe_cleanup(struct trace_probe *tp);
+int trace_probe_register_event_call(struct trace_probe *tp);
+int trace_probe_add_file(struct trace_probe *tp, struct trace_event_file *file);
+int trace_probe_remove_file(struct trace_probe *tp,
+			    struct trace_event_file *file);
+struct event_file_link *trace_probe_get_file_link(struct trace_probe *tp,
+						struct trace_event_file *file);
+
+#define trace_probe_for_each_link(pos, tp)	\
+	list_for_each_entry(pos, &(tp)->files, list)
+#define trace_probe_for_each_link_rcu(pos, tp)	\
+	list_for_each_entry_rcu(pos, &(tp)->files, list)
+
 /* Check the name is good for event/group/fields */
 static inline bool is_good_name(const char *name)
 {
@@ -270,18 +286,6 @@ static inline bool is_good_name(const char *name)
 	return true;
 }
 
-static inline struct event_file_link *
-find_event_file_link(struct trace_probe *tp, struct trace_event_file *file)
-{
-	struct event_file_link *link;
-
-	list_for_each_entry(link, &tp->files, list)
-		if (link->file == file)
-			return link;
-
-	return NULL;
-}
-
 #define TPARG_FL_RETURN BIT(0)
 #define TPARG_FL_KERNEL BIT(1)
 #define TPARG_FL_FENTRY BIT(2)
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index c262494fa793..a9f8045b6695 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -863,7 +863,7 @@ static int uprobe_trace_func(struct trace_uprobe *tu, struct pt_regs *regs,
 		return 0;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(link, &tu->tp.files, list)
+	trace_probe_for_each_link_rcu(link, &tu->tp)
 		__uprobe_trace_func(tu, 0, regs, ucb, dsize, link->file);
 	rcu_read_unlock();
 
@@ -877,7 +877,7 @@ static void uretprobe_trace_func(struct trace_uprobe *tu, unsigned long func,
 	struct event_file_link *link;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(link, &tu->tp.files, list)
+	trace_probe_for_each_link_rcu(link, &tu->tp)
 		__uprobe_trace_func(tu, func, regs, ucb, dsize, link->file);
 	rcu_read_unlock();
 }
@@ -924,21 +924,15 @@ probe_event_enable(struct trace_uprobe *tu, struct trace_event_file *file,
 		   filter_func_t filter)
 {
 	bool enabled = trace_probe_is_enabled(&tu->tp);
-	struct event_file_link *link = NULL;
 	int ret;
 
 	if (file) {
 		if (tu->tp.flags & TP_FLAG_PROFILE)
 			return -EINTR;
 
-		link = kmalloc(sizeof(*link), GFP_KERNEL);
-		if (!link)
-			return -ENOMEM;
-
-		link->file = file;
-		list_add_tail_rcu(&link->list, &tu->tp.files);
-
-		tu->tp.flags |= TP_FLAG_TRACE;
+		ret = trace_probe_add_file(&tu->tp, file);
+		if (ret < 0)
+			return ret;
 	} else {
 		if (tu->tp.flags & TP_FLAG_TRACE)
 			return -EINTR;
@@ -973,13 +967,11 @@ probe_event_enable(struct trace_uprobe *tu, struct trace_event_file *file,
 	uprobe_buffer_disable();
 
  err_flags:
-	if (file) {
-		list_del(&link->list);
-		kfree(link);
-		tu->tp.flags &= ~TP_FLAG_TRACE;
-	} else {
+	if (file)
+		trace_probe_remove_file(&tu->tp, file);
+	else
 		tu->tp.flags &= ~TP_FLAG_PROFILE;
-	}
+
 	return ret;
 }
 
@@ -990,26 +982,18 @@ probe_event_disable(struct trace_uprobe *tu, struct trace_event_file *file)
 		return;
 
 	if (file) {
-		struct event_file_link *link;
-
-		link = find_event_file_link(&tu->tp, file);
-		if (!link)
+		if (trace_probe_remove_file(&tu->tp, file) < 0)
 			return;
 
-		list_del_rcu(&link->list);
-		/* synchronize with u{,ret}probe_trace_func */
-		synchronize_rcu();
-		kfree(link);
-
-		if (!list_empty(&tu->tp.files))
+		if (trace_probe_is_enabled(&tu->tp))
 			return;
-	}
+	} else
+		tu->tp.flags &= ~TP_FLAG_PROFILE;
 
 	WARN_ON(!uprobe_filter_is_empty(&tu->filter));
 
 	uprobe_unregister(tu->inode, tu->offset, &tu->consumer);
 	tu->inode = NULL;
-	tu->tp.flags &= file ? ~TP_FLAG_TRACE : ~TP_FLAG_PROFILE;
 
 	uprobe_buffer_disable();
 }

