Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB41C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C37B22077C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="DJNkMm1c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbfHPUut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 16:50:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56179 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbfHPUut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 16:50:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7GKofFA2958997
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 16 Aug 2019 13:50:41 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7GKofFA2958997
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565988642;
        bh=xci7dRlXmGX4WpR6UyNIbIZzjAfQfEyUKts1osbF8rA=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=DJNkMm1cO0o2w7iRijSqV1iqA+kBmyZQqFcsWGaOYdTE3HS+VaRsNjfJY7q+4cgim
         zvelEvej0QmLtmCiLVSyrwEGYEMk0NN+Qv8TkSfIVILOwXWdvvT4LRJ5AbL9ElYm3x
         vrNLGLV/CIlZVr87Zibnc6+Vrt36FaSSbfCWyZL/yCua6u9dSu7Di3BDs1C+LDjRYq
         FVuebHgr2NFJ4SAP1ZJofO9/BZNVchC+N0TwWqHFCdcksW5L5NVImNZXKhDXy5B+WK
         hY1muKCOmjLYNdFCEomn4hBxst1p0vaLtPtsuwneiYU9MWX3YD/KpSrOSeKEVKtNQ/
         Fn3593DXj7kDA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7GKofHC2958994;
        Fri, 16 Aug 2019 13:50:41 -0700
Date:   Fri, 16 Aug 2019 13:50:41 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-0omwwoywj1v63gu8cz0tr0cy@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, jolsa@kernel.org, hpa@zytor.com,
        wcohen@redhat.com, acme@redhat.com, namhyung@kernel.org,
        mingo@kernel.org, fweimer@redhat.com
Reply-To: fweimer@redhat.com, mingo@kernel.org, adrian.hunter@intel.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          acme@redhat.com, namhyung@kernel.org, wcohen@redhat.com,
          hpa@zytor.com, jolsa@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf script: Allow showing the --switch-on event
Git-Commit-ID: 6469eb6dffeb44edfa3d4ca496b044b4a9c643b9
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

Commit-ID:  6469eb6dffeb44edfa3d4ca496b044b4a9c643b9
Gitweb:     https://git.kernel.org/tip/6469eb6dffeb44edfa3d4ca496b044b4a9c643b9
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 14 Aug 2019 16:40:58 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 15 Aug 2019 12:24:08 -0300

perf script: Allow showing the --switch-on event

One may want to see the --switch-on event as well, allow for that, using
the previous cset example:

  # perf script --switch-on syscalls:sys_enter_nanosleep --show-on-off
        sleep 13638 [001] 108237.582286: syscalls:sys_enter_nanosleep: rqtp: 0x7fff1948ac40, rmtp: 0x00000000
        sleep 13638 [001] 108237.582289:     sched:sched_stat_runtime: comm=sleep pid=13638 runtime=578104 [ns] vruntime=202889459556 [ns]
        sleep 13638 [001] 108237.582291:           sched:sched_switch: sleep:13638 [120] S ==> swapper/1:0 [120]
      swapper     0 [001] 108238.582428:           sched:sched_waking: comm=sleep pid=13638 prio=120 target_cpu=001
      swapper     0 [001] 108238.582458:           sched:sched_wakeup: sleep:13638 [120] success=1 CPU:001
        sleep 13638 [001] 108238.582698:     sched:sched_stat_runtime: comm=sleep pid=13638 runtime=173915 [ns] vruntime=202889633471 [ns]
        sleep 13638 [001] 108238.582782:     sched:sched_process_exit: comm=sleep pid=13638 prio=120
  #
  # perf script --switch-on syscalls:sys_enter_nanosleep
        sleep 13638 [001] 108237.582289:     sched:sched_stat_runtime: comm=sleep pid=13638 runtime=578104 [ns] vruntime=202889459556 [ns]
        sleep 13638 [001] 108237.582291:           sched:sched_switch: sleep:13638 [120] S ==> swapper/1:0 [120]
      swapper     0 [001] 108238.582428:           sched:sched_waking: comm=sleep pid=13638 prio=120 target_cpu=001
      swapper     0 [001] 108238.582458:           sched:sched_wakeup: sleep:13638 [120] success=1 CPU:001
        sleep 13638 [001] 108238.582698:     sched:sched_stat_runtime: comm=sleep pid=13638 runtime=173915 [ns] vruntime=202889633471 [ns]
        sleep 13638 [001] 108238.582782:     sched:sched_process_exit: comm=sleep pid=13638 prio=120
  #

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: William Cohen <wcohen@redhat.com>
Cc: Florian Weimer <fweimer@redhat.com>
Link: https://lkml.kernel.org/n/tip-0omwwoywj1v63gu8cz0tr0cy@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-script.txt | 3 +++
 tools/perf/builtin-script.c              | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 9936819aae1c..24eea68ee829 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -420,6 +420,9 @@ include::itrace.txt[]
 --switch-on EVENT_NAME::
 	Only consider events after this event is found.
 
+--show-on-off-events::
+	Show the --switch-on event too.
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-script-perl[1],
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index d0bc7ccaf7bf..fa0cc8b0eccc 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1619,6 +1619,7 @@ static int perf_sample__fprintf_synth(struct perf_sample *sample,
 struct evswitch {
 	struct evsel *on;
 	bool	     discarding;
+	bool	     show_on_off_events;
 };
 
 struct perf_script {
@@ -1816,6 +1817,9 @@ static void process_event(struct perf_script *script,
 			return;
 
 		script->evswitch.discarding = false;
+
+		if (!script->evswitch.show_on_off_events)
+			return;
 	}
 
 	++es->samples;
@@ -3554,6 +3558,8 @@ int cmd_script(int argc, const char **argv)
 		   "file", "file saving guest os /proc/modules"),
 	OPT_STRING(0, "switch-on", &event_switch_on,
 		   "event", "Consider events from the first ocurrence of this event"),
+	OPT_BOOLEAN(0, "show-on-off-events", &script.evswitch.show_on_off_events,
+		    "Show the on/off switch events, used with --switch-on"),
 	OPT_END()
 	};
 	const char * const script_subcommands[] = { "record", "report", NULL };
