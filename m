Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71124C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F17D4214DE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390592AbfIEPnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 11:43:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:35646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390521AbfIEPnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 11:43:42 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5903218AC;
        Thu,  5 Sep 2019 15:43:42 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1i5tvB-0007XV-Dw; Thu, 05 Sep 2019 11:43:41 -0400
Message-Id: <20190905154341.321813231@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 05 Sep 2019 11:43:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 11/25] tracing/uprobe: Add per-probe delete from event
References: <20190905154258.573706229@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add per-probe delete method from one event passing the head of
definition. In other words, the events which match the head
N parameters are deleted.

Link: http://lkml.kernel.org/r/156095689811.28024.221706761151739433.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_uprobe.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index d84e09abb8de..84925b5b6db5 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -284,13 +284,42 @@ static bool trace_uprobe_is_busy(struct dyn_event *ev)
 	return trace_probe_is_enabled(&tu->tp);
 }
 
+static bool trace_uprobe_match_command_head(struct trace_uprobe *tu,
+					    int argc, const char **argv)
+{
+	char buf[MAX_ARGSTR_LEN + 1];
+	int len;
+
+	if (!argc)
+		return true;
+
+	len = strlen(tu->filename);
+	if (strncmp(tu->filename, argv[0], len) || argv[0][len] != ':')
+		return false;
+
+	if (tu->ref_ctr_offset == 0)
+		snprintf(buf, sizeof(buf), "0x%0*lx",
+				(int)(sizeof(void *) * 2), tu->offset);
+	else
+		snprintf(buf, sizeof(buf), "0x%0*lx(0x%lx)",
+				(int)(sizeof(void *) * 2), tu->offset,
+				tu->ref_ctr_offset);
+	if (strcmp(buf, &argv[0][len + 1]))
+		return false;
+
+	argc--; argv++;
+
+	return trace_probe_match_command_args(&tu->tp, argc, argv);
+}
+
 static bool trace_uprobe_match(const char *system, const char *event,
 			int argc, const char **argv, struct dyn_event *ev)
 {
 	struct trace_uprobe *tu = to_trace_uprobe(ev);
 
 	return strcmp(trace_probe_name(&tu->tp), event) == 0 &&
-	    (!system || strcmp(trace_probe_group_name(&tu->tp), system) == 0);
+	   (!system || strcmp(trace_probe_group_name(&tu->tp), system) == 0) &&
+	   trace_uprobe_match_command_head(tu, argc, argv);
 }
 
 static nokprobe_inline struct trace_uprobe *
-- 
2.20.1


