Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61705C04AAB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 01:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38CB620C01
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 01:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfEHBwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 21:52:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726378AbfEHBv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 21:51:56 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B30F821530;
        Wed,  8 May 2019 01:51:54 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hOBkP-0005m7-Rq; Tue, 07 May 2019 21:51:53 -0400
Message-Id: <20190508015153.754938632@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 07 May 2019 21:51:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [for-next][PATCH 3/3] tracing: kdb: Allow ftdump to skip all but the last few entries
References: <20190508015112.818966506@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

The 'ftdump' command in kdb is currently a bit of a last resort, at
least if you have lots of traces turned on.  It's going to print a
whole boatload of data out your serial port which is probably running
at 115200.  This could easily take many, many minutes.

Usually you're most interested in what's at the _end_ of the ftrace
buffer, AKA what happened most recently.  That means you've got to
wait the full time for the dump.  The 'ftdump' command does attempt to
help you a little bit by allowing you to skip a fixed number of
entries.  Unfortunately it provides no way for you to know how many
entries you should skip.

Let's do similar to python and allow you to use a negative number to
indicate that you want to skip all entries except the last few.  This
allows you to quickly see what you want.

Note that we also change the printout in ftdump to print the
(positive) number of entries actually skipped since that could be
helpful to know when you've specified a negative skip count.

Link: http://lkml.kernel.org/r/20190319171206.97107-3-dianders@chromium.org

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_kdb.c | 45 +++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/trace_kdb.c b/kernel/trace/trace_kdb.c
index 4b666643d69f..6c1ae6b752d1 100644
--- a/kernel/trace/trace_kdb.c
+++ b/kernel/trace/trace_kdb.c
@@ -17,29 +17,25 @@
 #include "trace.h"
 #include "trace_output.h"
 
+static struct trace_iterator iter;
+static struct ring_buffer_iter *buffer_iter[CONFIG_NR_CPUS];
+
 static void ftrace_dump_buf(int skip_entries, long cpu_file)
 {
-	/* use static because iter can be a bit big for the stack */
-	static struct trace_iterator iter;
-	static struct ring_buffer_iter *buffer_iter[CONFIG_NR_CPUS];
 	struct trace_array *tr;
 	unsigned int old_userobj;
 	int cnt = 0, cpu;
 
-	trace_init_global_iter(&iter);
-	iter.buffer_iter = buffer_iter;
 	tr = iter.tr;
 
-	for_each_tracing_cpu(cpu) {
-		atomic_inc(&per_cpu_ptr(iter.trace_buffer->data, cpu)->disabled);
-	}
-
 	old_userobj = tr->trace_flags;
 
 	/* don't look at user memory in panic mode */
 	tr->trace_flags &= ~TRACE_ITER_SYM_USEROBJ;
 
 	kdb_printf("Dumping ftrace buffer:\n");
+	if (skip_entries)
+		kdb_printf("(skipping %d entries)\n", skip_entries);
 
 	/* reset all but tr, trace, and overruns */
 	memset(&iter.seq, 0,
@@ -89,10 +85,6 @@ static void ftrace_dump_buf(int skip_entries, long cpu_file)
 out:
 	tr->trace_flags = old_userobj;
 
-	for_each_tracing_cpu(cpu) {
-		atomic_dec(&per_cpu_ptr(iter.trace_buffer->data, cpu)->disabled);
-	}
-
 	for_each_tracing_cpu(cpu) {
 		if (iter.buffer_iter[cpu]) {
 			ring_buffer_read_finish(iter.buffer_iter[cpu]);
@@ -109,6 +101,8 @@ static int kdb_ftdump(int argc, const char **argv)
 	int skip_entries = 0;
 	long cpu_file;
 	char *cp;
+	int cnt;
+	int cpu;
 
 	if (argc > 2)
 		return KDB_ARGCOUNT;
@@ -129,7 +123,29 @@ static int kdb_ftdump(int argc, const char **argv)
 	}
 
 	kdb_trap_printk++;
+
+	trace_init_global_iter(&iter);
+	iter.buffer_iter = buffer_iter;
+
+	for_each_tracing_cpu(cpu) {
+		atomic_inc(&per_cpu_ptr(iter.trace_buffer->data, cpu)->disabled);
+	}
+
+	/* A negative skip_entries means skip all but the last entries */
+	if (skip_entries < 0) {
+		if (cpu_file == RING_BUFFER_ALL_CPUS)
+			cnt = trace_total_entries(NULL);
+		else
+			cnt = trace_total_entries_cpu(NULL, cpu_file);
+		skip_entries = max(cnt + skip_entries, 0);
+	}
+
 	ftrace_dump_buf(skip_entries, cpu_file);
+
+	for_each_tracing_cpu(cpu) {
+		atomic_dec(&per_cpu_ptr(iter.trace_buffer->data, cpu)->disabled);
+	}
+
 	kdb_trap_printk--;
 
 	return 0;
@@ -138,7 +154,8 @@ static int kdb_ftdump(int argc, const char **argv)
 static __init int kdb_ftrace_register(void)
 {
 	kdb_register_flags("ftdump", kdb_ftdump, "[skip_#entries] [cpu]",
-			    "Dump ftrace log", 0, KDB_ENABLE_ALWAYS_SAFE);
+			    "Dump ftrace log; -skip dumps last #entries", 0,
+			    KDB_ENABLE_ALWAYS_SAFE);
 	return 0;
 }
 
-- 
2.20.1


