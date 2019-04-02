Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7D3C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D172133D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554221204;
	bh=gri8YOgmw5Bj4N72FX25SeD/91TE2LGyspKeS3nR1hQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gn47SIsxrqXBG2NjMrHc1QagXUzS9CvffD6tdZdlDFnyH6HAmCVtUWnIagEah6v+6
	 3jibe6hxJdCFTIbbnb0Q3hoF2EVQXCgU7f7K+E1eaA71JoRnQ0CUc+0SBXGFw+qaKp
	 tXYDzhI7yt06L8xhdsrSj8Fq0ifHI3oVZpu03OgY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730928AbfDBQGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:06:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:44430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730698AbfDBQGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:06:41 -0400
Received: from quaco.ghostprotocols.net (unknown [187.65.94.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AA6A20857;
        Tue,  2 Apr 2019 16:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554221200;
        bh=gri8YOgmw5Bj4N72FX25SeD/91TE2LGyspKeS3nR1hQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=flQwf9MG5S0stGjmQKhCQ+7cKxbUDfpVAAwRgNNgmK925vK3d/yliMbRmlORBil/i
         LSvAFwYcHhHk0bbn60QMK2n5U09Gwct5vr9VsO4KINdmAiovC6gSIEB281HpBQhE85
         whBjZ3Ym2b7SrcsimnynIvOBqKOdkRkhzl855yaQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 12/44] tools lib traceevent: Add mono clocks to be parsed in seconds
Date:   Tue,  2 Apr 2019 13:05:17 -0300
Message-Id: <20190402160549.13544-13-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190402160549.13544-1-acme@kernel.org>
References: <20190402160549.13544-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
-- 
2.20.1

