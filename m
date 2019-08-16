Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523DDC3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E152171F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="3vpa13Q0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfHPU4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 16:56:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50129 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbfHPU4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 16:56:44 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7GKubVn2960027
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 16 Aug 2019 13:56:37 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7GKubVn2960027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565988998;
        bh=IyyP5rdo7OPZojXg/zhDntT2ooHpcghOo2ovC939KYc=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=3vpa13Q0Y5YWTkL3UeyR5BaFqTMk05+5baCU7X+1oPa5xceCSFGiFkv/VPlLMmtUI
         0h+MxqxjTThmZ4riFh3ReLvKK4CCZTRo+0FNsY0ZPRDpwmB0Gl9qGF/hm0FmEbSnQh
         NzP638UXPstZbzu7LJrQhZwLHwYShyKhQOwSO90ywEtv3YRK3FNt84HdA/8Fkzg3I8
         G8pyOqsYy/Xn9i65FXjSYBrr8KLOqoI1ry6qaCp5PwoqNdFuNAF7gzzLjUdVugXTgI
         rkHqzh7cwOytE12ZBE3hH4GiFRrYQTL6fdIfxM1ibkFEHVLhDD/Wkxgv2GKPz/KMuI
         RW6hwbmeixKVQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7GKubm72960024;
        Fri, 16 Aug 2019 13:56:37 -0700
Date:   Fri, 16 Aug 2019 13:56:37 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-iijjvdlyad973oskdq8gmi5w@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        tglx@linutronix.de, wcohen@redhat.com, jolsa@kernel.org,
        hpa@zytor.com, mingo@kernel.org, acme@redhat.com,
        namhyung@kernel.org, fweimer@redhat.com
Reply-To: tglx@linutronix.de, adrian.hunter@intel.com,
          linux-kernel@vger.kernel.org, wcohen@redhat.com,
          jolsa@kernel.org, namhyung@kernel.org, acme@redhat.com,
          mingo@kernel.org, hpa@zytor.com, fweimer@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf evswitch: Add hint when not finding specified
 on/off events
Git-Commit-ID: 8b3c9ea7bf8f50ead6787c084cfc6d3a0b1e38aa
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

Commit-ID:  8b3c9ea7bf8f50ead6787c084cfc6d3a0b1e38aa
Gitweb:     https://git.kernel.org/tip/8b3c9ea7bf8f50ead6787c084cfc6d3a0b1e38aa
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 15 Aug 2019 12:02:13 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 15 Aug 2019 12:26:13 -0300

perf evswitch: Add hint when not finding specified on/off events

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
