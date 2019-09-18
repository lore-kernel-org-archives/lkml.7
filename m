Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963E3C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 08:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5441821927
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 08:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568796952;
	bh=vJI8CqYkB4g1gdtg8pl6aQgEGAoGv1QgVujZbG9iJ1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TsL4jUGqe5Zm0bUuBMJNPsrFiXg7rY4Zth20wY9bwfNZciW9jhq6u/NdzD8/LhD4k
	 oYOc9V7gbIGAlV45Zre7zYlH1x+gAcKBrhcfILedPJYFKMbbyCIs0ZE+WGZU8kbCqw
	 qbbRuoCzRL2tHS1ZfI/TzpZqAd3fG/oUziSeZoT0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730700AbfIRIzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 04:55:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:44158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbfIRIzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 04:55:51 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86BC421907;
        Wed, 18 Sep 2019 08:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568796949;
        bh=vJI8CqYkB4g1gdtg8pl6aQgEGAoGv1QgVujZbG9iJ1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u3BXReoJIa2S3eEChm75xqAuz53u0gfRWm05JQVJG/md4Lv3TbHgFT0IKZnx1G4uf
         k55uChSe1Q0dk3njkhtKKMLOqZ/ixl8QDKzQR5zte+YB1wzyy9vqD1JiFBM86nzyn0
         D9mJjj097+FmpTZThGPQUxbmpP+vK+vW2stN817Y=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, mhiramat@kernel.org, mingo@redhat.com
Subject: [PATCH 2/3] tracing/probe: Reject exactly same probe event
Date:   Wed, 18 Sep 2019 17:55:46 +0900
Message-Id: <156879694602.31056.5533024778165036763.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <156879692790.31056.9404391078827158266.stgit@devnote2>
References: <156879692790.31056.9404391078827158266.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reject exactly same probe events as existing probes.

Multiprobe allows user to define multiple probes on same
event. If user appends a probe which exactly same definition
(same probe address and same arguments) on existing event,
the event will record same probe information twice.
That can be confusing users, so reject it.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |   52 ++++++++++++++++++++++++++++++++++++-------
 kernel/trace/trace_probe.h  |    3 ++
 kernel/trace/trace_uprobe.c |   52 ++++++++++++++++++++++++++++++++++++-------
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

