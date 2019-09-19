Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE17DC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 23:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F1221920
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 23:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406521AbfISXYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 19:24:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405760AbfISXYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 19:24:02 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61EF621928;
        Thu, 19 Sep 2019 23:24:01 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1iB5mK-0000i3-Ii; Thu, 19 Sep 2019 19:24:00 -0400
Message-Id: <20190919232400.470062819@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 19 Sep 2019 19:23:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 7/8] tracing/probe: Reject exactly same probe event
References: <20190919232313.198902049@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Reject exactly same probe events as existing probes.

Multiprobe allows user to define multiple probes on same
event. If user appends a probe which exactly same definition
(same probe address and same arguments) on existing event,
the event will record same probe information twice.
That can be confusing users, so reject it.

Link: http://lkml.kernel.org/r/156879694602.31056.5533024778165036763.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_kprobe.c | 52 +++++++++++++++++++++++++++++++------
 kernel/trace/trace_probe.h  |  3 ++-
 kernel/trace/trace_uprobe.c | 52 +++++++++++++++++++++++++++++++------
 3 files changed, 90 insertions(+), 17 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 0ba3239c0270..a6697e28ddda 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -528,10 +528,53 @@ static int unregister_trace_kprobe(struct trace_kprobe *tk)
 	return 0;
 }
 
+static bool trace_kprobe_has_same_kprobe(struct trace_kprobe *orig,
+					 struct trace_kprobe *comp)
+{
+	struct trace_probe_event *tpe = orig->tp.event;
+	struct trace_probe *pos;
+	int i;
+
+	list_for_each_entry(pos, &tpe->probes, list) {
+		orig = container_of(pos, struct trace_kprobe, tp);
+		if (strcmp(trace_kprobe_symbol(orig),
+			   trace_kprobe_symbol(comp)) ||
+		    trace_kprobe_offset(orig) != trace_kprobe_offset(comp))
+			continue;
+
+		/*
+		 * trace_probe_compare_arg_type() ensured that nr_args and
+		 * each argument name and type are same. Let's compare comm.
+		 */
+		for (i = 0; i < orig->tp.nr_args; i++) {
+			if (strcmp(orig->tp.args[i].comm,
+				   comp->tp.args[i].comm))
+				continue;
+		}
+
+		return true;
+	}
+
+	return false;
+}
+
 static int append_trace_kprobe(struct trace_kprobe *tk, struct trace_kprobe *to)
 {
 	int ret;
 
+	ret = trace_probe_compare_arg_type(&tk->tp, &to->tp);
+	if (ret) {
+		/* Note that argument starts index = 2 */
+		trace_probe_log_set_index(ret + 1);
+		trace_probe_log_err(0, DIFF_ARG_TYPE);
+		return -EEXIST;
+	}
+	if (trace_kprobe_has_same_kprobe(to, tk)) {
+		trace_probe_log_set_index(0);
+		trace_probe_log_err(0, SAME_PROBE);
+		return -EEXIST;
+	}
+
 	/* Append to existing event */
 	ret = trace_probe_append(&tk->tp, &to->tp);
 	if (ret)
@@ -568,14 +611,7 @@ static int register_trace_kprobe(struct trace_kprobe *tk)
 			trace_probe_log_err(0, DIFF_PROBE_TYPE);
 			ret = -EEXIST;
 		} else {
-			ret = trace_probe_compare_arg_type(&tk->tp, &old_tk->tp);
-			if (ret) {
-				/* Note that argument starts index = 2 */
-				trace_probe_log_set_index(ret + 1);
-				trace_probe_log_err(0, DIFF_ARG_TYPE);
-				ret = -EEXIST;
-			} else
-				ret = append_trace_kprobe(tk, old_tk);
+			ret = append_trace_kprobe(tk, old_tk);
 		}
 		goto end;
 	}
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index f805cc4cbe7c..4ee703728aec 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -436,7 +436,8 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(BAD_INSN_BNDRY,	"Probe point is not an instruction boundary"),\
 	C(FAIL_REG_PROBE,	"Failed to register probe event"),\
 	C(DIFF_PROBE_TYPE,	"Probe type is different from existing probe"),\
-	C(DIFF_ARG_TYPE,	"Argument type or name is different from existing probe"),
+	C(DIFF_ARG_TYPE,	"Argument type or name is different from existing probe"),\
+	C(SAME_PROBE,		"There is already the exact same probe event"),
 
 #undef C
 #define C(a, b)		TP_ERR_##a
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index cbf4da4bf367..34dd6d0016a3 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -410,10 +410,53 @@ static int unregister_trace_uprobe(struct trace_uprobe *tu)
 	return 0;
 }
 
+static bool trace_uprobe_has_same_uprobe(struct trace_uprobe *orig,
+					 struct trace_uprobe *comp)
+{
+	struct trace_probe_event *tpe = orig->tp.event;
+	struct trace_probe *pos;
+	struct inode *comp_inode = d_real_inode(comp->path.dentry);
+	int i;
+
+	list_for_each_entry(pos, &tpe->probes, list) {
+		orig = container_of(pos, struct trace_uprobe, tp);
+		if (comp_inode != d_real_inode(orig->path.dentry) ||
+		    comp->offset != orig->offset)
+			continue;
+
+		/*
+		 * trace_probe_compare_arg_type() ensured that nr_args and
+		 * each argument name and type are same. Let's compare comm.
+		 */
+		for (i = 0; i < orig->tp.nr_args; i++) {
+			if (strcmp(orig->tp.args[i].comm,
+				   comp->tp.args[i].comm))
+				continue;
+		}
+
+		return true;
+	}
+
+	return false;
+}
+
 static int append_trace_uprobe(struct trace_uprobe *tu, struct trace_uprobe *to)
 {
 	int ret;
 
+	ret = trace_probe_compare_arg_type(&tu->tp, &to->tp);
+	if (ret) {
+		/* Note that argument starts index = 2 */
+		trace_probe_log_set_index(ret + 1);
+		trace_probe_log_err(0, DIFF_ARG_TYPE);
+		return -EEXIST;
+	}
+	if (trace_uprobe_has_same_uprobe(to, tu)) {
+		trace_probe_log_set_index(0);
+		trace_probe_log_err(0, SAME_PROBE);
+		return -EEXIST;
+	}
+
 	/* Append to existing event */
 	ret = trace_probe_append(&tu->tp, &to->tp);
 	if (!ret)
@@ -469,14 +512,7 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
 			trace_probe_log_err(0, DIFF_PROBE_TYPE);
 			ret = -EEXIST;
 		} else {
-			ret = trace_probe_compare_arg_type(&tu->tp, &old_tu->tp);
-			if (ret) {
-				/* Note that argument starts index = 2 */
-				trace_probe_log_set_index(ret + 1);
-				trace_probe_log_err(0, DIFF_ARG_TYPE);
-				ret = -EEXIST;
-			} else
-				ret = append_trace_uprobe(tu, old_tu);
+			ret = append_trace_uprobe(tu, old_tu);
 		}
 		goto end;
 	}
-- 
2.20.1


