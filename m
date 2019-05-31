Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18240C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D405726B8A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559315923;
	bh=x57AQX3w/ooD32kSCm+ZGw4XJPc9XXJWP8K/eaMINOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ddRhduCw0iPcny+xdPcfYgDJYQqnthb1eAPQ1dtSjidM8txhcCpKpvDefypnUULTv
	 U6F4xPTCREUwlv5YVt+dnEaiSHUuFMR9WRpCDSK/JhVr5da8YCSZ08/BLQZw7TWVdu
	 5++xAJmx5kUtTxsWXG1mUhCL7lUhVC1laZh5zjXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfEaPSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 11:18:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:35854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbfEaPSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 11:18:42 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6095223DD8;
        Fri, 31 May 2019 15:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559315921;
        bh=x57AQX3w/ooD32kSCm+ZGw4XJPc9XXJWP8K/eaMINOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lcco/obLLiEJuPu0BjZ3Gi7kfuwH8aSLPmhCqeN6lOqhHwHoT8cmQddekWtGjlGE8
         q5M73f/p9lumJIIAT/Wp31L/SHlrXI2S5PQy17u5gaue141Kc3aTnfhncALPVJFyFm
         RAp10brmS0p9i/V5Kremcuu/b/oiJydrmqGmFQ3k=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/21] tracing/dynevent: Pass extra arguments to match operation
Date:   Sat,  1 Jun 2019 00:18:37 +0900
Message-Id: <155931591694.28323.8136061436136770279.stgit@devnote2>
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

Pass extra arguments to match operation for checking
exact match. If the event doesn't support exact match,
it will be ignored.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_dynevent.c    |    4 +++-
 kernel/trace/trace_dynevent.h    |    7 ++++---
 kernel/trace/trace_events_hist.c |    4 ++--
 kernel/trace/trace_kprobe.c      |    4 ++--
 kernel/trace/trace_uprobe.c      |    4 ++--
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
index 633edb88cd0e..b340bbc9a965 100644
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
index 3a9a7582400d..b83cb38657ed 100644
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
 

