Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DF2C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A928218A6
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731059AbfDELmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:42:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41669 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730283AbfDELmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:42:36 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x35Bg0Hn2734970
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 5 Apr 2019 04:42:00 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x35Bg0sD2734965;
        Fri, 5 Apr 2019 04:42:00 -0700
Date:   Fri, 5 Apr 2019 04:42:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Steven Rostedt (VMware)" <tipbot@zytor.com>
Message-ID: <tip-fed33e905c4beea96a066686f8be2b489eb5068e@git.kernel.org>
Cc:     hpa@zytor.com, jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, acme@redhat.com, mingo@kernel.org,
        akpm@linux-foundation.org, tglx@linutronix.de, rostedt@goodmis.org,
        tstoyanov@vmware.com
Reply-To: mingo@kernel.org, akpm@linux-foundation.org, tglx@linutronix.de,
          rostedt@goodmis.org, tstoyanov@vmware.com, hpa@zytor.com,
          jolsa@redhat.com, namhyung@kernel.org, acme@redhat.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190401164342.976554023@goodmis.org>
References: <20190401164342.976554023@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib traceevent: Add mono clocks to be parsed
 in seconds
Git-Commit-ID: fed33e905c4beea96a066686f8be2b489eb5068e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  fed33e905c4beea96a066686f8be2b489eb5068e
Gitweb:     https://git.kernel.org/tip/fed33e905c4beea96a066686f8be2b489eb5068e
Author:     Steven Rostedt (VMware) <rostedt@goodmis.org>
AuthorDate: Mon, 1 Apr 2019 12:43:07 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 1 Apr 2019 15:18:08 -0300

tools lib traceevent: Add mono clocks to be parsed in seconds

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
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Link: http://lkml.kernel.org/r/20190401164342.976554023@goodmis.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
