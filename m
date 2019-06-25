Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888ADC48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 699502086D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733114AbfFYTQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 15:16:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731906AbfFYTPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 15:15:47 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D73AC213F2;
        Tue, 25 Jun 2019 19:15:46 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hfquv-0002LC-W0; Tue, 25 Jun 2019 15:15:46 -0400
Message-Id: <20190625191545.875539622@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 25 Jun 2019 15:15:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 07/12] tracing/probe: Add trace_event_call register API for trace_probe
References: <20190625191510.599310671@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Since trace_event_call is a field of trace_probe, these
operations should be done in trace_probe.c. trace_kprobe
and trace_uprobe use new functions to register/unregister
trace_event_call.

Link: http://lkml.kernel.org/r/155931583643.28323.14828411185591538876.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_kprobe.c | 20 +++-----------------
 kernel/trace/trace_probe.c  | 16 ++++++++++++++++
 kernel/trace/trace_probe.h  |  6 ++++++
 kernel/trace/trace_uprobe.c | 22 +++-------------------
 4 files changed, 28 insertions(+), 36 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index c43c2d419ded..7f802ee27266 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1393,28 +1393,14 @@ static inline void init_trace_event_call(struct trace_kprobe *tk,
 
 static int register_kprobe_event(struct trace_kprobe *tk)
 {
-	struct trace_event_call *call = &tk->tp.call;
-	int ret = 0;
-
-	init_trace_event_call(tk, call);
-
-	ret = register_trace_event(&call->event);
-	if (!ret)
-		return -ENODEV;
+	init_trace_event_call(tk, &tk->tp.call);
 
-	ret = trace_add_event_call(call);
-	if (ret) {
-		pr_info("Failed to register kprobe event: %s\n",
-			trace_event_name(call));
-		unregister_trace_event(&call->event);
-	}
-	return ret;
+	return trace_probe_register_event_call(&tk->tp);
 }
 
 static int unregister_kprobe_event(struct trace_kprobe *tk)
 {
-	/* tp->event is unregistered in trace_remove_event_call() */
-	return trace_remove_event_call(&tk->tp.call);
+	return trace_probe_unregister_event_call(&tk->tp);
 }
 
 #ifdef CONFIG_PERF_EVENTS
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index fe4ee2e73d92..509a26024b4f 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -920,3 +920,19 @@ int trace_probe_init(struct trace_probe *tp, const char *event,
 
 	return 0;
 }
+
+int trace_probe_register_event_call(struct trace_probe *tp)
+{
+	struct trace_event_call *call = &tp->call;
+	int ret;
+
+	ret = register_trace_event(&call->event);
+	if (!ret)
+		return -ENODEV;
+
+	ret = trace_add_event_call(call);
+	if (ret)
+		unregister_trace_event(&call->event);
+
+	return ret;
+}
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 818b1d7693ba..01d7b222e004 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -251,6 +251,12 @@ static inline bool trace_probe_is_registered(struct trace_probe *tp)
 int trace_probe_init(struct trace_probe *tp, const char *event,
 		     const char *group);
 void trace_probe_cleanup(struct trace_probe *tp);
+int trace_probe_register_event_call(struct trace_probe *tp);
+static inline int trace_probe_unregister_event_call(struct trace_probe *tp)
+{
+	/* tp->event is unregistered in trace_remove_event_call() */
+	return trace_remove_event_call(&tp->call);
+}
 
 /* Check the name is good for event/group/fields */
 static inline bool is_good_name(const char *name)
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index b18b7eb1a76f..c262494fa793 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1345,30 +1345,14 @@ static inline void init_trace_event_call(struct trace_uprobe *tu,
 
 static int register_uprobe_event(struct trace_uprobe *tu)
 {
-	struct trace_event_call *call = &tu->tp.call;
-	int ret = 0;
-
-	init_trace_event_call(tu, call);
-
-	ret = register_trace_event(&call->event);
-	if (!ret)
-		return -ENODEV;
-
-	ret = trace_add_event_call(call);
-
-	if (ret) {
-		pr_info("Failed to register uprobe event: %s\n",
-			trace_event_name(call));
-		unregister_trace_event(&call->event);
-	}
+	init_trace_event_call(tu, &tu->tp.call);
 
-	return ret;
+	return trace_probe_register_event_call(&tu->tp);
 }
 
 static int unregister_uprobe_event(struct trace_uprobe *tu)
 {
-	/* tu->event is unregistered in trace_remove_event_call() */
-	return trace_remove_event_call(&tu->tp.call);
+	return trace_probe_unregister_event_call(&tu->tp);
 }
 
 #ifdef CONFIG_PERF_EVENTS
-- 
2.20.1


