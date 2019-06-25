Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD45C48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E74F7208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733137AbfFYTQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 15:16:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:34514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731505AbfFYTPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 15:15:47 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64FA5214DA;
        Tue, 25 Jun 2019 19:15:46 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hfquv-0002Je-Go; Tue, 25 Jun 2019 15:15:45 -0400
Message-Id: <20190625191545.402754381@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 25 Jun 2019 15:15:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 04/12] tracing/kprobe: Set print format right after parsed command
References: <20190625191510.599310671@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Set event call's print format right after parsed command for
simplifying (un)register_kprobe_event().

Link: http://lkml.kernel.org/r/155931580625.28323.5158822928646225903.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_kprobe.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 7958da2fd922..01fc49f08b70 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -272,6 +272,7 @@ static void free_trace_kprobe(struct trace_kprobe *tk)
 
 	kfree(tk->tp.call.class->system);
 	kfree(tk->tp.call.name);
+	kfree(tk->tp.call.print_fmt);
 	kfree(tk->symbol);
 	free_percpu(tk->nhit);
 	kfree(tk);
@@ -730,6 +731,10 @@ static int trace_kprobe_create(int argc, const char *argv[])
 			goto error;	/* This can be -ENOMEM */
 	}
 
+	ret = traceprobe_set_print_fmt(&tk->tp, is_return);
+	if (ret < 0)
+		goto error;
+
 	ret = register_trace_kprobe(tk);
 	if (ret) {
 		trace_probe_log_set_index(1);
@@ -1416,18 +1421,14 @@ static int register_kprobe_event(struct trace_kprobe *tk)
 
 	init_trace_event_call(tk, call);
 
-	if (traceprobe_set_print_fmt(&tk->tp, trace_kprobe_is_return(tk)) < 0)
-		return -ENOMEM;
 	ret = register_trace_event(&call->event);
-	if (!ret) {
-		kfree(call->print_fmt);
+	if (!ret)
 		return -ENODEV;
-	}
+
 	ret = trace_add_event_call(call);
 	if (ret) {
 		pr_info("Failed to register kprobe event: %s\n",
 			trace_event_name(call));
-		kfree(call->print_fmt);
 		unregister_trace_event(&call->event);
 	}
 	return ret;
@@ -1435,13 +1436,8 @@ static int register_kprobe_event(struct trace_kprobe *tk)
 
 static int unregister_kprobe_event(struct trace_kprobe *tk)
 {
-	int ret;
-
 	/* tp->event is unregistered in trace_remove_event_call() */
-	ret = trace_remove_event_call(&tk->tp.call);
-	if (!ret)
-		kfree(tk->tp.call.print_fmt);
-	return ret;
+	return trace_remove_event_call(&tk->tp.call);
 }
 
 #ifdef CONFIG_PERF_EVENTS
@@ -1479,10 +1475,8 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
 	}
 
 	ret = __register_trace_kprobe(tk);
-	if (ret < 0) {
-		kfree(tk->tp.call.print_fmt);
+	if (ret < 0)
 		goto error;
-	}
 
 	return &tk->tp.call;
 error:
@@ -1503,7 +1497,6 @@ void destroy_local_trace_kprobe(struct trace_event_call *event_call)
 
 	__unregister_trace_kprobe(tk);
 
-	kfree(tk->tp.call.print_fmt);
 	free_trace_kprobe(tk);
 }
 #endif /* CONFIG_PERF_EVENTS */
-- 
2.20.1


