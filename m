Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7785DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A8A421903
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbfDAQnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:43:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:60052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728019AbfDAQno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:43:44 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEF0B21900;
        Mon,  1 Apr 2019 16:43:43 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hB02B-0004qo-2v; Mon, 01 Apr 2019 12:43:43 -0400
Message-Id: <20190401164342.976554023@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 01 Apr 2019 12:43:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>
Subject: [PATCH 02/15] tools/lib/traceevent: Add mono clocks to be parsed in seconds
References: <20190401164305.359125441@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The mono clocks can display in seconds instead of whole numbers:

       trace-cmd-521   [001] 99176715281005: sched_waking:         comm=kworker/u16:2 pid=32118 prio=120 target_cpu=002
       trace-cmd-521   [001] 99176715286349: sched_wake_idle_without_ipi: cpu=2
       trace-cmd-521   [001] 99176715288047: sched_wakeup:         kworker/u16:2:32118 [120] success=1 CPU:002
       trace-cmd-521   [001] 99176715290022: sched_waking:         comm=trace-cmd pid=523 prio=120 target_cpu=000
       trace-cmd-521   [001] 99176715292332: sched_wake_idle_without_ipi: cpu=0
       trace-cmd-521   [001] 99176715292855: sched_wakeup:         trace-cmd:523 [120] success=1 CPU:000
       trace-cmd-521   [001] 99176715300697: sched_stat_runtime:   comm=trace-cmd pid=521 runtime=80233 [ns] vruntime=66705540554 [ns

Break it up in seconds:

       trace-cmd-521   [001] 99176.715281: sched_waking:         comm=kworker/u16:2 pid=32118 prio=120 target_cpu=002
       trace-cmd-521   [001] 99176.715286: sched_wake_idle_without_ipi: cpu=2
       trace-cmd-521   [001] 99176.715288: sched_wakeup:         kworker/u16:2:32118 [120] success=1 CPU:002
       trace-cmd-521   [001] 99176.715290: sched_waking:         comm=trace-cmd pid=523 prio=120 target_cpu=000
       trace-cmd-521   [001] 99176.715292: sched_wake_idle_without_ipi: cpu=0
       trace-cmd-521   [001] 99176.715293: sched_wakeup:         trace-cmd:523 [120] success=1 CPU:000
       trace-cmd-521   [001] 99176.715301: sched_stat_runtime:   comm=trace-cmd pid=521 runtime=80233 [ns] vruntime=66705540554 [ns]

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/lib/traceevent/event-parse.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 2ebb257ce7ba..666e23ded6ed 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -5445,7 +5445,8 @@ static bool is_timestamp_in_us(char *trace_clock, bool use_trace_clock)
 		return true;
 
 	if (!strcmp(trace_clock, "local") || !strcmp(trace_clock, "global")
-	    || !strcmp(trace_clock, "uptime") || !strcmp(trace_clock, "perf"))
+	    || !strcmp(trace_clock, "uptime") || !strcmp(trace_clock, "perf")
+	    || !strncmp(trace_clock, "mono", 4))
 		return true;
 
 	/* trace_clock is setting in tsc or counter mode */
-- 
2.20.1


