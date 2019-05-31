Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0680C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970682190E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559315842;
	bh=uR8ywa47DHwrCepjyLVAOzHztpof3IS3z5bu9pkyJ7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a0epkow1FR6mLHD4qUDkoX/MVSHmOmlTqbBWaNGjzap8xz4lkW9TND1cf4cXVEb58
	 nLjf55ambkjn51ZNNfiWBj4Q5C1psGrcI8KVZep1wEVoPxbnGXfUlBGPcz+bBAsfVA
	 SjA46L1VhjNq20vHfZx2yNoHRScA/vIK7DSCV6A4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfEaPRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 11:17:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfEaPRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 11:17:21 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C505126B7B;
        Fri, 31 May 2019 15:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559315840;
        bh=uR8ywa47DHwrCepjyLVAOzHztpof3IS3z5bu9pkyJ7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ui0KXA1fpcc8H9ltxBwJ1g5cd7E+zYutbgBAd6YxuQnV+3tLpSdlLS1LkxyyaIi+4
         oRWVnL+f15PRxLBC96kCMGcCu8D2hdDudDRgajUe+EB7Ka6rRJoayICTzn+fD4HACt
         12LjlQZDdc68IGWFFEfkTqwc70GjArsT5+V9oIFI=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/21] tracing/probe: Add trace_event_call register API for trace_probe
Date:   Sat,  1 Jun 2019 00:17:16 +0900
Message-Id: <155931583643.28323.14828411185591538876.stgit@devnote2>
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

Since trace_event_call is a field of trace_probe, these
operations should be done in trace_probe.c. trace_kprobe
and trace_uprobe use new functions to register/unregister
trace_event_call.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |   20 +++-----------------
 kernel/trace/trace_probe.c  |   16 ++++++++++++++++
 kernel/trace/trace_probe.h  |    6 ++++++
 kernel/trace/trace_uprobe.c |   22 +++-------------------
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

