Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02663C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF42F218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfCOSps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 14:45:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbfCOSpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 14:45:39 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A766218E0;
        Fri, 15 Mar 2019 18:45:38 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1h4rpp-0000BS-Ap; Fri, 15 Mar 2019 14:45:37 -0400
Message-Id: <20190315184537.226266150@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 15 Mar 2019 14:45:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 7/8] tracing/probe: Check event/group naming rule at parsing
References: <20190315184505.655928086@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Check event and group naming rule at parsing it instead
of allocating probes.

Link: http://lkml.kernel.org/r/155253784064.14922.2336893061156236237.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_kprobe.c | 7 +------
 kernel/trace/trace_probe.c  | 8 ++++++++
 kernel/trace/trace_uprobe.c | 5 +----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index a14837545295..5265117ad7e8 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -221,7 +221,7 @@ static struct trace_kprobe *alloc_trace_kprobe(const char *group,
 
 	tk->rp.maxactive = maxactive;
 
-	if (!event || !is_good_name(event)) {
+	if (!event || !group) {
 		ret = -EINVAL;
 		goto error;
 	}
@@ -231,11 +231,6 @@ static struct trace_kprobe *alloc_trace_kprobe(const char *group,
 	if (!tk->tp.call.name)
 		goto error;
 
-	if (!group || !is_good_name(group)) {
-		ret = -EINVAL;
-		goto error;
-	}
-
 	tk->tp.class.system = kstrdup(group, GFP_KERNEL);
 	if (!tk->tp.class.system)
 		goto error;
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index bf9d3d7e0c9d..8f8411e7835f 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -172,6 +172,10 @@ int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
 			return -E2BIG;
 		}
 		strlcpy(buf, event, slash - event + 1);
+		if (!is_good_name(buf)) {
+			pr_info("Group name must follow the same rules as C identifiers\n");
+			return -EINVAL;
+		}
 		*pgroup = buf;
 		*pevent = slash + 1;
 		event = *pevent;
@@ -184,6 +188,10 @@ int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
 		pr_info("Event name is too long\n");
 		return -E2BIG;
 	}
+	if (!is_good_name(event)) {
+		pr_info("Event name must follow the same rules as C identifiers\n");
+		return -EINVAL;
+	}
 	return 0;
 }
 
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index e335576b9411..52f033489377 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -266,10 +266,7 @@ alloc_trace_uprobe(const char *group, const char *event, int nargs, bool is_ret)
 {
 	struct trace_uprobe *tu;
 
-	if (!event || !is_good_name(event))
-		return ERR_PTR(-EINVAL);
-
-	if (!group || !is_good_name(group))
+	if (!event || !group)
 		return ERR_PTR(-EINVAL);
 
 	tu = kzalloc(SIZEOF_TRACE_UPROBE(nargs), GFP_KERNEL);
-- 
2.20.1


