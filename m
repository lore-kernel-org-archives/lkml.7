Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A8CC48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C9452086D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733152AbfFYTQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 15:16:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731775AbfFYTPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 15:15:47 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AD2621670;
        Tue, 25 Jun 2019 19:15:46 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hfquv-0002K8-Lj; Tue, 25 Jun 2019 15:15:45 -0400
Message-Id: <20190625191545.564190445@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 25 Jun 2019 15:15:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 05/12] tracing/uprobe: Set print format when parsing command
References: <20190625191510.599310671@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Set event call's print format right after parsed command for
simplifying (un)register_uprobe_event().

Link: http://lkml.kernel.org/r/155931581659.28323.5404667166417404076.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_uprobe.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 3d6b868830f3..34ce671b6080 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -345,6 +345,7 @@ static void free_trace_uprobe(struct trace_uprobe *tu)
 	path_put(&tu->path);
 	kfree(tu->tp.call.class->system);
 	kfree(tu->tp.call.name);
+	kfree(tu->tp.call.print_fmt);
 	kfree(tu->filename);
 	kfree(tu);
 }
@@ -592,6 +593,10 @@ static int trace_uprobe_create(int argc, const char **argv)
 			goto error;
 	}
 
+	ret = traceprobe_set_print_fmt(&tu->tp, is_ret_probe(tu));
+	if (ret < 0)
+		goto error;
+
 	ret = register_trace_uprobe(tu);
 	if (!ret)
 		goto out;
@@ -1362,21 +1367,15 @@ static int register_uprobe_event(struct trace_uprobe *tu)
 
 	init_trace_event_call(tu, call);
 
-	if (traceprobe_set_print_fmt(&tu->tp, is_ret_probe(tu)) < 0)
-		return -ENOMEM;
-
 	ret = register_trace_event(&call->event);
-	if (!ret) {
-		kfree(call->print_fmt);
+	if (!ret)
 		return -ENODEV;
-	}
 
 	ret = trace_add_event_call(call);
 
 	if (ret) {
 		pr_info("Failed to register uprobe event: %s\n",
 			trace_event_name(call));
-		kfree(call->print_fmt);
 		unregister_trace_event(&call->event);
 	}
 
@@ -1385,15 +1384,8 @@ static int register_uprobe_event(struct trace_uprobe *tu)
 
 static int unregister_uprobe_event(struct trace_uprobe *tu)
 {
-	int ret;
-
 	/* tu->event is unregistered in trace_remove_event_call() */
-	ret = trace_remove_event_call(&tu->tp.call);
-	if (ret)
-		return ret;
-	kfree(tu->tp.call.print_fmt);
-	tu->tp.call.print_fmt = NULL;
-	return 0;
+	return trace_remove_event_call(&tu->tp.call);
 }
 
 #ifdef CONFIG_PERF_EVENTS
@@ -1452,9 +1444,6 @@ void destroy_local_trace_uprobe(struct trace_event_call *event_call)
 
 	tu = container_of(event_call, struct trace_uprobe, tp.call);
 
-	kfree(tu->tp.call.print_fmt);
-	tu->tp.call.print_fmt = NULL;
-
 	free_trace_uprobe(tu);
 }
 #endif /* CONFIG_PERF_EVENTS */
-- 
2.20.1


