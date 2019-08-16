Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FB0C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E18842171F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565986679;
	bh=MQsnsP6cE0pUKWTXzXrB2hgVt154coRoPxRGhDLBeo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EBJB+zol5W0Zk03NluS3/t1agjKuZtEY7CKC3L+V9YsLoFNkoCYn1u7dOIOon6BpV
	 bGlzdISe9NFBoLHsv7fMtcx6WTWRmuGkgOZaNOjuS/Uc2QflkU6BdSlNLE35LOfxJX
	 a3w/UMLKXp1Iy25FRSumtqo+HSnPK7m4vfgoYUjo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfHPUR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 16:17:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:58754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727548AbfHPURz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 16:17:55 -0400
Received: from quaco.ghostprotocols.net (unknown [179.182.221.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C60C62133F;
        Fri, 16 Aug 2019 20:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565986674;
        bh=MQsnsP6cE0pUKWTXzXrB2hgVt154coRoPxRGhDLBeo0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F/zzp124nBooQTwNQvZssqINgXqf/hvVpVxxmQG3WW2NXFyp292IJSUU6dssOHM0M
         L8PDmLkiExUOAp6rCwzSYksHk/HZXGTrNcPi3nyi3nIXEo2rQenb+IooRm3yRIrL5m
         O7OurjDidc82CcP/qf729WAxOX5JEE+gltmLS3bY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        William Cohen <wcohen@redhat.com>
Subject: [PATCH 11/17] perf evswitch: Add hint when not finding specified on/off events
Date:   Fri, 16 Aug 2019 17:16:47 -0300
Message-Id: <20190816201653.19332-12-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190816201653.19332-1-acme@kernel.org>
References: <20190816201653.19332-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

If the user specifies a on or off switch event and it isn't in the
perf.data file, provide a hint about how to see the events in the
perf.data evlist:

  # perf script --switch-on=syscall:sys_enter_nanosleep --switch-off=syscalls:sys_exit_nanosleep
  ERROR: event_on event not found (syscall:sys_enter_nanosleep)
  HINT:  use 'perf evlist' to see the available event names
  #
  # perf evlist
  sched:sched_kthread_stop
  sched:sched_kthread_stop_ret
  sched:sched_waking
  sched:sched_wakeup
  sched:sched_wakeup_new
  sched:sched_switch
  sched:sched_migrate_task
  sched:sched_process_free
  sched:sched_process_exit
  sched:sched_wait_task
  sched:sched_process_wait
  sched:sched_process_fork
  sched:sched_process_exec
  sched:sched_stat_wait
  sched:sched_stat_sleep
  sched:sched_stat_iowait
  sched:sched_stat_blocked
  sched:sched_stat_runtime
  sched:sched_pi_setprio
  sched:sched_move_numa
  sched:sched_stick_numa
  sched:sched_swap_numa
  sched:sched_wake_idle_without_ipi
  syscalls:sys_enter_clock_nanosleep
  syscalls:sys_exit_clock_nanosleep
  syscalls:sys_enter_nanosleep
  syscalls:sys_exit_nanosleep
  # Tip: use 'perf evlist --trace-fields' to show fields for tracepoint events
  #
  # perf script --switch-on=syscalls:sys_enter_nanosleep --switch-off=syscalls:sys_exit_nanosleep
       sleep 20919 [001] 109866.144411:  sched:sched_stat_runtime: comm=sleep pid=20919 runtime=521249 [ns] vruntime=202919398131 [ns]
       sleep 20919 [001] 109866.144412:        sched:sched_switch: sleep:20919 [120] S ==> swapper/1:0 [120]
     swapper     0 [001] 109867.144568:        sched:sched_waking: comm=sleep pid=20919 prio=120 target_cpu=001
     swapper     0 [001] 109867.144586:        sched:sched_wakeup: sleep:20919 [120] success=1 CPU:001
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: William Cohen <wcohen@redhat.com>
Link: https://lkml.kernel.org/n/tip-iijjvdlyad973oskdq8gmi5w@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evswitch.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evswitch.c b/tools/perf/util/evswitch.c
index 71daed615a2c..3ba72f743d3c 100644
--- a/tools/perf/util/evswitch.c
+++ b/tools/perf/util/evswitch.c
@@ -33,7 +33,9 @@ bool evswitch__discard(struct evswitch *evswitch, struct evsel *evsel)
 
 static int evswitch__fprintf_enoent(FILE *fp, const char *evtype, const char *evname)
 {
-	return fprintf(fp, "ERROR: switch-%s event not found (%s)\n", evtype, evname);
+	int printed = fprintf(fp, "ERROR: switch-%s event not found (%s)\n", evtype, evname);
+
+	return printed += fprintf(fp, "HINT:  use 'perf evlist' to see the available event names\n");
 }
 
 int evswitch__init(struct evswitch *evswitch, struct evlist *evlist, FILE *fp)
-- 
2.21.0

