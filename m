Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D8BC004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 01:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF31C20C01
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 01:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfEHBwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 21:52:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbfEHBvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 21:51:55 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C7F321479;
        Wed,  8 May 2019 01:51:54 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hOBkP-0005l8-Ip; Tue, 07 May 2019 21:51:53 -0400
Message-Id: <20190508015153.469614024@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 07 May 2019 21:51:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [for-next][PATCH 1/3] tracing: kdb: The skip_lines parameter should have been skip_entries
References: <20190508015112.818966506@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

The things skipped by kdb's "ftdump" command when you pass it a
parameter has always been entries, not lines.  The difference usually
doesn't matter but when the trace buffer has multi-line entries (like
a stack dump) it can matter.

Let's fix this both in the help text for ftdump and also in the local
variable names.

Link: http://lkml.kernel.org/r/20190319171206.97107-1-dianders@chromium.org

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_kdb.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_kdb.c b/kernel/trace/trace_kdb.c
index 810d78a8d14c..4b666643d69f 100644
--- a/kernel/trace/trace_kdb.c
+++ b/kernel/trace/trace_kdb.c
@@ -17,7 +17,7 @@
 #include "trace.h"
 #include "trace_output.h"
 
-static void ftrace_dump_buf(int skip_lines, long cpu_file)
+static void ftrace_dump_buf(int skip_entries, long cpu_file)
 {
 	/* use static because iter can be a bit big for the stack */
 	static struct trace_iterator iter;
@@ -70,11 +70,11 @@ static void ftrace_dump_buf(int skip_lines, long cpu_file)
 			kdb_printf("---------------------------------\n");
 		cnt++;
 
-		if (!skip_lines) {
+		if (!skip_entries) {
 			print_trace_line(&iter);
 			trace_printk_seq(&iter.seq);
 		} else {
-			skip_lines--;
+			skip_entries--;
 		}
 
 		if (KDB_FLAG(CMD_INTERRUPT))
@@ -106,7 +106,7 @@ static void ftrace_dump_buf(int skip_lines, long cpu_file)
  */
 static int kdb_ftdump(int argc, const char **argv)
 {
-	int skip_lines = 0;
+	int skip_entries = 0;
 	long cpu_file;
 	char *cp;
 
@@ -114,9 +114,9 @@ static int kdb_ftdump(int argc, const char **argv)
 		return KDB_ARGCOUNT;
 
 	if (argc) {
-		skip_lines = simple_strtol(argv[1], &cp, 0);
+		skip_entries = simple_strtol(argv[1], &cp, 0);
 		if (*cp)
-			skip_lines = 0;
+			skip_entries = 0;
 	}
 
 	if (argc == 2) {
@@ -129,7 +129,7 @@ static int kdb_ftdump(int argc, const char **argv)
 	}
 
 	kdb_trap_printk++;
-	ftrace_dump_buf(skip_lines, cpu_file);
+	ftrace_dump_buf(skip_entries, cpu_file);
 	kdb_trap_printk--;
 
 	return 0;
@@ -137,7 +137,7 @@ static int kdb_ftdump(int argc, const char **argv)
 
 static __init int kdb_ftrace_register(void)
 {
-	kdb_register_flags("ftdump", kdb_ftdump, "[skip_#lines] [cpu]",
+	kdb_register_flags("ftdump", kdb_ftdump, "[skip_#entries] [cpu]",
 			    "Dump ftrace log", 0, KDB_ENABLE_ALWAYS_SAFE);
 	return 0;
 }
-- 
2.20.1


