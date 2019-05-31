Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E86C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C75D26B7F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559315813;
	bh=cP0ayFbhfeGBhs9vyU/qHBRhb0bQklmskydYO4Sh9qw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Aug8FDRVMWsE3BYt89cub8yGAOu+HiHumce4WS3/9ao4z79i/unf5G3JvCHfhXAr/
	 zNqzUAWmnvQangWxsETmVHiImwcFz+yTs/aiU2+tDddry+GDmO7IHVXLEUKqk0nY2a
	 9eD6H25yl9f88N+jugd+dhJyxSaRE31sA/JdNSa4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfEaPQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 11:16:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:33010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbfEaPQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 11:16:51 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 344A226B7B;
        Fri, 31 May 2019 15:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559315811;
        bh=cP0ayFbhfeGBhs9vyU/qHBRhb0bQklmskydYO4Sh9qw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xGIlOb1mR59BLjYksDJfN6UoVWVuZ06+TAj+KSx6N1MiqBgz+VI1JyhpbHPOSp5iW
         4bepLJSkDJ15Zo5jDX+Y9H3AI9oY9CT9BAor3C6VGJPcbQYXCpXcnw6K4GWpgP03Qk
         9QfKgzDoQm0j2Zmkt8apsmmL9dOI8U+Q2ycnrzw0=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/21] tracing/kprobe: Set print format right after parsed command
Date:   Sat,  1 Jun 2019 00:16:46 +0900
Message-Id: <155931580625.28323.5158822928646225903.stgit@devnote2>
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
simplifying (un)register_kprobe_event().

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |   25 +++++++++----------------
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

