Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E1FC43140
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA1221925
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390604AbfIEPns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 11:43:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390487AbfIEPnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 11:43:42 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AF5320CC7;
        Thu,  5 Sep 2019 15:43:42 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1i5tvA-0007VZ-HY; Thu, 05 Sep 2019 11:43:40 -0400
Message-Id: <20190905154340.431505424@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 05 Sep 2019 11:43:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 07/25] tracing/dynevent: Pass extra arguments to match operation
References: <20190905154258.573706229@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Pass extra arguments to match operation for checking
exact match. If the event doesn't support exact match,
it will be ignored.

Link: http://lkml.kernel.org/r/156095685930.28024.10405547027475590975.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_dynevent.c    | 4 +++-
 kernel/trace/trace_dynevent.h    | 7 ++++---
 kernel/trace/trace_events_hist.c | 4 ++--
 kernel/trace/trace_kprobe.c      | 4 ++--
 kernel/trace/trace_uprobe.c      | 4 ++--
 5 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index 1cc55c50c491..a41fed46c285 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -47,6 +47,7 @@ int dyn_event_release(int argc, char **argv, struct dyn_event_operations *type)
 			return -EINVAL;
 		event++;
 	}
+	argc--; argv++;
 
 	p = strchr(event, '/');
 	if (p) {
@@ -61,7 +62,8 @@ int dyn_event_release(int argc, char **argv, struct dyn_event_operations *type)
 	for_each_dyn_event_safe(pos, n) {
 		if (type && type != pos->ops)
 			continue;
-		if (!pos->ops->match(system, event, pos))
+		if (!pos->ops->match(system, event,
+				argc, (const char **)argv, pos))
 			continue;
 
 		ret = pos->ops->free(pos);
diff --git a/kernel/trace/trace_dynevent.h b/kernel/trace/trace_dynevent.h
index 8c334064e4d6..46898138d2df 100644
--- a/kernel/trace/trace_dynevent.h
+++ b/kernel/trace/trace_dynevent.h
@@ -31,8 +31,9 @@ struct dyn_event;
  * @is_busy: Check whether given event is busy so that it can not be deleted.
  *  Return true if it is busy, otherwides false.
  * @free: Delete the given event. Return 0 if success, otherwides error.
- * @match: Check whether given event and system name match this event.
- *  Return true if it matches, otherwides false.
+ * @match: Check whether given event and system name match this event. The argc
+ *  and argv is used for exact match. Return true if it matches, otherwides
+ *  false.
  *
  * Except for @create, these methods are called under holding event_mutex.
  */
@@ -43,7 +44,7 @@ struct dyn_event_operations {
 	bool (*is_busy)(struct dyn_event *ev);
 	int (*free)(struct dyn_event *ev);
 	bool (*match)(const char *system, const char *event,
-			struct dyn_event *ev);
+		      int argc, const char **argv, struct dyn_event *ev);
 };
 
 /* Register new dyn_event type -- must be called at first */
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index ca6b0dff60c5..65e7d071ed28 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -374,7 +374,7 @@ static int synth_event_show(struct seq_file *m, struct dyn_event *ev);
 static int synth_event_release(struct dyn_event *ev);
 static bool synth_event_is_busy(struct dyn_event *ev);
 static bool synth_event_match(const char *system, const char *event,
-			      struct dyn_event *ev);
+			int argc, const char **argv, struct dyn_event *ev);
 
 static struct dyn_event_operations synth_event_ops = {
 	.create = synth_event_create,
@@ -422,7 +422,7 @@ static bool synth_event_is_busy(struct dyn_event *ev)
 }
 
 static bool synth_event_match(const char *system, const char *event,
-			      struct dyn_event *ev)
+			int argc, const char **argv, struct dyn_event *ev)
 {
 	struct synth_event *sev = to_synth_event(ev);
 
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index eac6344a2e7c..e8f72431b866 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -39,7 +39,7 @@ static int trace_kprobe_show(struct seq_file *m, struct dyn_event *ev);
 static int trace_kprobe_release(struct dyn_event *ev);
 static bool trace_kprobe_is_busy(struct dyn_event *ev);
 static bool trace_kprobe_match(const char *system, const char *event,
-			       struct dyn_event *ev);
+			int argc, const char **argv, struct dyn_event *ev);
 
 static struct dyn_event_operations trace_kprobe_ops = {
 	.create = trace_kprobe_create,
@@ -138,7 +138,7 @@ static bool trace_kprobe_is_busy(struct dyn_event *ev)
 }
 
 static bool trace_kprobe_match(const char *system, const char *event,
-			       struct dyn_event *ev)
+			int argc, const char **argv, struct dyn_event *ev)
 {
 	struct trace_kprobe *tk = to_trace_kprobe(ev);
 
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index ac799abb7da9..2862e6829e48 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -44,7 +44,7 @@ static int trace_uprobe_show(struct seq_file *m, struct dyn_event *ev);
 static int trace_uprobe_release(struct dyn_event *ev);
 static bool trace_uprobe_is_busy(struct dyn_event *ev);
 static bool trace_uprobe_match(const char *system, const char *event,
-			       struct dyn_event *ev);
+			int argc, const char **argv, struct dyn_event *ev);
 
 static struct dyn_event_operations trace_uprobe_ops = {
 	.create = trace_uprobe_create,
@@ -285,7 +285,7 @@ static bool trace_uprobe_is_busy(struct dyn_event *ev)
 }
 
 static bool trace_uprobe_match(const char *system, const char *event,
-			       struct dyn_event *ev)
+			int argc, const char **argv, struct dyn_event *ev)
 {
 	struct trace_uprobe *tu = to_trace_uprobe(ev);
 
-- 
2.20.1


