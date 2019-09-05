Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDA8C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 076852137B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390760AbfIEPot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 11:44:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:35528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390510AbfIEPnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 11:43:42 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C73D2137B;
        Thu,  5 Sep 2019 15:43:42 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1i5tvA-0007WX-Rx; Thu, 05 Sep 2019 11:43:40 -0400
Message-Id: <20190905154340.750832943@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 05 Sep 2019 11:43:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 09/25] tracing/uprobe: Add multi-probe per uprobe event support
References: <20190905154258.573706229@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Allow user to define several probes on one uprobe event.
Note that this only support appending method. So deleting
event will delete all probes on the event.

Link: http://lkml.kernel.org/r/156095687876.28024.13840331032234992863.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c        |  2 +-
 kernel/trace/trace_uprobe.c | 60 ++++++++++++++++++++++++++-----------
 2 files changed, 43 insertions(+), 19 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a8505d84b76e..c7797a81a37e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4823,7 +4823,7 @@ static const char readme_msg[] =
 	"\t\t\t  Write into this file to define/undefine new trace events.\n"
 #endif
 #ifdef CONFIG_UPROBE_EVENTS
-	"  uprobe_events\t\t- Add/remove/show the userspace dynamic events\n"
+	"  uprobe_events\t\t- Create/append/remove/show the userspace dynamic events\n"
 	"\t\t\t  Write into this file to define/undefine new trace events.\n"
 #endif
 #if defined(CONFIG_KPROBE_EVENTS) || defined(CONFIG_UPROBE_EVENTS)
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 2862e6829e48..d84e09abb8de 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -364,15 +364,32 @@ static int unregister_trace_uprobe(struct trace_uprobe *tu)
 {
 	int ret;
 
+	if (trace_probe_has_sibling(&tu->tp))
+		goto unreg;
+
 	ret = unregister_uprobe_event(tu);
 	if (ret)
 		return ret;
 
+unreg:
 	dyn_event_remove(&tu->devent);
+	trace_probe_unlink(&tu->tp);
 	free_trace_uprobe(tu);
 	return 0;
 }
 
+static int append_trace_uprobe(struct trace_uprobe *tu, struct trace_uprobe *to)
+{
+	int ret;
+
+	/* Append to existing event */
+	ret = trace_probe_append(&tu->tp, &to->tp);
+	if (!ret)
+		dyn_event_add(&tu->devent);
+
+	return ret;
+}
+
 /*
  * Uprobe with multiple reference counter is not allowed. i.e.
  * If inode and offset matches, reference counter offset *must*
@@ -382,25 +399,21 @@ static int unregister_trace_uprobe(struct trace_uprobe *tu)
  * as the new one does not conflict with any other existing
  * ones.
  */
-static struct trace_uprobe *find_old_trace_uprobe(struct trace_uprobe *new)
+static int validate_ref_ctr_offset(struct trace_uprobe *new)
 {
 	struct dyn_event *pos;
-	struct trace_uprobe *tmp, *old = NULL;
+	struct trace_uprobe *tmp;
 	struct inode *new_inode = d_real_inode(new->path.dentry);
 
-	old = find_probe_event(trace_probe_name(&new->tp),
-				trace_probe_group_name(&new->tp));
-
 	for_each_trace_uprobe(tmp, pos) {
-		if ((old ? old != tmp : true) &&
-		    new_inode == d_real_inode(tmp->path.dentry) &&
+		if (new_inode == d_real_inode(tmp->path.dentry) &&
 		    new->offset == tmp->offset &&
 		    new->ref_ctr_offset != tmp->ref_ctr_offset) {
 			pr_warn("Reference counter offset mismatch.");
-			return ERR_PTR(-EINVAL);
+			return -EINVAL;
 		}
 	}
-	return old;
+	return 0;
 }
 
 /* Register a trace_uprobe and probe_event */
@@ -411,18 +424,29 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
 
 	mutex_lock(&event_mutex);
 
-	/* register as an event */
-	old_tu = find_old_trace_uprobe(tu);
-	if (IS_ERR(old_tu)) {
-		ret = PTR_ERR(old_tu);
+	ret = validate_ref_ctr_offset(tu);
+	if (ret)
 		goto end;
-	}
 
+	/* register as an event */
+	old_tu = find_probe_event(trace_probe_name(&tu->tp),
+				  trace_probe_group_name(&tu->tp));
 	if (old_tu) {
-		/* delete old event */
-		ret = unregister_trace_uprobe(old_tu);
-		if (ret)
-			goto end;
+		if (is_ret_probe(tu) != is_ret_probe(old_tu)) {
+			trace_probe_log_set_index(0);
+			trace_probe_log_err(0, DIFF_PROBE_TYPE);
+			ret = -EEXIST;
+		} else {
+			ret = trace_probe_compare_arg_type(&tu->tp, &old_tu->tp);
+			if (ret) {
+				/* Note that argument starts index = 2 */
+				trace_probe_log_set_index(ret + 1);
+				trace_probe_log_err(0, DIFF_ARG_TYPE);
+				ret = -EEXIST;
+			} else
+				ret = append_trace_uprobe(tu, old_tu);
+		}
+		goto end;
 	}
 
 	ret = register_uprobe_event(tu);
-- 
2.20.1


