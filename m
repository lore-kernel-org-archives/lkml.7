Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C57C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B3B218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfCOSqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 14:46:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbfCOSpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 14:45:38 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D719F218EA;
        Fri, 15 Mar 2019 18:45:37 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1h4rpp-0000AP-0d; Fri, 15 Mar 2019 14:45:37 -0400
Message-Id: <20190315184536.904473843@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 15 Mar 2019 14:45:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 5/8] tracing/probe: Check event name length correctly
References: <20190315184505.655928086@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Ensure given name of event is not too long when parsing it,
and fix to update event name offset correctly when the group
name is given. For example, this makes probe event to check
the "p:foo/" error case correctly.

Link: http://lkml.kernel.org/r/155253782046.14922.14724124823730168629.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_probe.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index cfcf77e6fb19..0dc13bff2847 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -159,6 +159,7 @@ int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
 				char *buf)
 {
 	const char *slash, *event = *pevent;
+	int len;
 
 	slash = strchr(event, '/');
 	if (slash) {
@@ -173,10 +174,15 @@ int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
 		strlcpy(buf, event, slash - event + 1);
 		*pgroup = buf;
 		*pevent = slash + 1;
+		event = *pevent;
 	}
-	if (strlen(event) == 0) {
+	len = strlen(event);
+	if (len == 0) {
 		pr_info("Event name is not specified\n");
 		return -EINVAL;
+	} else if (len > MAX_EVENT_NAME_LEN) {
+		pr_info("Event name is too long\n");
+		return -E2BIG;
 	}
 	return 0;
 }
-- 
2.20.1


