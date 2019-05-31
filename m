Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF15C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7605626B87
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559315823;
	bh=jumnE2XTGYsY/OMmQ8EnJYFquAjEcij5ll6HOKaJ2kk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZRiQmG0m9H9vMKCn2ElwfHNUoMIrGZwYtKg21xLYaekoc41bLD4HdESyrZ1eBc5si
	 1iCbW1CcUCkisfAY2nxbUZLj3ZTz0NVZc+vXM+jlRABb/Ekbbkt8Hojj1s6FyKBgY0
	 6KZTNyIVfThivcEuGz5XUAc9PQGVMCEfWNvJMFPs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfEaPRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 11:17:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfEaPRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 11:17:02 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C9E726B7F;
        Fri, 31 May 2019 15:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559315821;
        bh=jumnE2XTGYsY/OMmQ8EnJYFquAjEcij5ll6HOKaJ2kk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sEZPYCSy+wUY/0o6mKJ8AolA/Cq+95L4qB4qG9KKUlloiMNtX0XDc2bVMqqIR0Vtv
         de2brZnLdEx46pUFUfvZB1iJ77cpQ+NGvlMGTHx5ZenhSyHnLq5aBVMuHeSx0TJdKb
         yyO1FQOr7CNBP/Aiw3e2C5SPxuWQeO7OQ2PVBGRw=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/21] tracing/uprobe: Set print format when parsing command
Date:   Sat,  1 Jun 2019 00:16:56 +0900
Message-Id: <155931581659.28323.5404667166417404076.stgit@devnote2>
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

Set event call's print format right after parsed command for
simplifying (un)register_uprobe_event().

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_uprobe.c |   25 +++++++------------------
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

