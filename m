Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C57C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 252B3206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390547AbfIEPno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 11:43:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731518AbfIEPnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 11:43:42 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B57FD2145D;
        Thu,  5 Sep 2019 15:43:42 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1i5tvB-0007X1-4K; Thu, 05 Sep 2019 11:43:41 -0400
Message-Id: <20190905154341.021107049@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 05 Sep 2019 11:43:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 10/25] tracing/kprobe: Add per-probe delete from event
References: <20190905154258.573706229@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Allow user to delete a probe from event. This is done by head
match. For example, if we have 2 probes on an event

$ cat kprobe_events
p:kprobes/testprobe _do_fork r1=%ax r2=%dx
p:kprobes/testprobe idle_fork r1=%ax r2=%cx

Then you can remove one of them by passing the head of definition
which identify the probe.

$ echo "-:kprobes/testprobe idle_fork" >> kprobe_events

Link: http://lkml.kernel.org/r/156095688848.28024.15798690082378432435.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_kprobe.c | 25 ++++++++++++++++++++++++-
 kernel/trace/trace_probe.c  | 18 ++++++++++++++++++
 kernel/trace/trace_probe.h  |  2 ++
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index f43098bf62dd..18c4175b6585 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -137,13 +137,36 @@ static bool trace_kprobe_is_busy(struct dyn_event *ev)
 	return trace_probe_is_enabled(&tk->tp);
 }
 
+static bool trace_kprobe_match_command_head(struct trace_kprobe *tk,
+					    int argc, const char **argv)
+{
+	char buf[MAX_ARGSTR_LEN + 1];
+
+	if (!argc)
+		return true;
+
+	if (!tk->symbol)
+		snprintf(buf, sizeof(buf), "0x%p", tk->rp.kp.addr);
+	else if (tk->rp.kp.offset)
+		snprintf(buf, sizeof(buf), "%s+%u",
+			 trace_kprobe_symbol(tk), tk->rp.kp.offset);
+	else
+		snprintf(buf, sizeof(buf), "%s", trace_kprobe_symbol(tk));
+	if (strcmp(buf, argv[0]))
+		return false;
+	argc--; argv++;
+
+	return trace_probe_match_command_args(&tk->tp, argc, argv);
+}
+
 static bool trace_kprobe_match(const char *system, const char *event,
 			int argc, const char **argv, struct dyn_event *ev)
 {
 	struct trace_kprobe *tk = to_trace_kprobe(ev);
 
 	return strcmp(trace_probe_name(&tk->tp), event) == 0 &&
-	    (!system || strcmp(trace_probe_group_name(&tk->tp), system) == 0);
+	    (!system || strcmp(trace_probe_group_name(&tk->tp), system) == 0) &&
+	    trace_kprobe_match_command_head(tk, argc, argv);
 }
 
 static nokprobe_inline unsigned long trace_kprobe_nhit(struct trace_kprobe *tk)
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 651a1449acde..f8c3c65c035d 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1047,3 +1047,21 @@ int trace_probe_compare_arg_type(struct trace_probe *a, struct trace_probe *b)
 
 	return 0;
 }
+
+bool trace_probe_match_command_args(struct trace_probe *tp,
+				    int argc, const char **argv)
+{
+	char buf[MAX_ARGSTR_LEN + 1];
+	int i;
+
+	if (tp->nr_args < argc)
+		return false;
+
+	for (i = 0; i < argc; i++) {
+		snprintf(buf, sizeof(buf), "%s=%s",
+			 tp->args[i].name, tp->args[i].comm);
+		if (strcmp(buf, argv[i]))
+			return false;
+	}
+	return true;
+}
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 39926e8a344b..2dcc4e317787 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -332,6 +332,8 @@ int trace_probe_remove_file(struct trace_probe *tp,
 struct event_file_link *trace_probe_get_file_link(struct trace_probe *tp,
 						struct trace_event_file *file);
 int trace_probe_compare_arg_type(struct trace_probe *a, struct trace_probe *b);
+bool trace_probe_match_command_args(struct trace_probe *tp,
+				    int argc, const char **argv);
 
 #define trace_probe_for_each_link(pos, tp)	\
 	list_for_each_entry(pos, &(tp)->event->files, list)
-- 
2.20.1


