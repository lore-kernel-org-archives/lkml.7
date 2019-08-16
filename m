Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F54C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305202077C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="5EVivdH1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfHPUuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 16:50:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50885 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbfHPUuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 16:50:05 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7GKnvBK2958901
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 16 Aug 2019 13:49:57 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7GKnvBK2958901
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565988597;
        bh=YVELSXVdFXEpDCXIROX12BRXFS3DA40uo7JL2ukPZjI=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=5EVivdH1YUe+lQ5H8IsCWPMTGUd2u2UxqDRhF6s1NYNJMGlflE1Jq7l0MriAuR5xB
         MrLUfpVkRG18PW90czE5FQpQLZYtRjh8lYBzUDdJ2gkkj64UjgTgIAjMB3TlGT7W2M
         gC9Q/uIcANKB68CzXnfqeF6tX7fquA5HuJf3MEdpPBK824v3ETtI80GTCSTF4QQYLk
         DMuHNWhjUh84Bw+W7ScXHHm4HvyNi82l2yutJ7dhul8xGHI8zWbDC8Vs3Z3FU9A+yg
         WNPRngkQpooUEsIIe47tkofEBWdip4uWEyh5LXWuXTx+oy9vpnC47ly2JhADQOo2vu
         0iNiXRZSj9wOg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7GKnuKm2958898;
        Fri, 16 Aug 2019 13:49:56 -0700
Date:   Fri, 16 Aug 2019 13:49:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-f1oo0ufdhrkx6nhy2lj1ierm@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, namhyung@kernel.org, acme@redhat.com,
        hpa@zytor.com, jolsa@kernel.org, fweimer@redhat.com,
        adrian.hunter@intel.com, mingo@kernel.org, tglx@linutronix.de,
        wcohen@redhat.com
Reply-To: wcohen@redhat.com, tglx@linutronix.de, mingo@kernel.org,
          adrian.hunter@intel.com, fweimer@redhat.com, jolsa@kernel.org,
          hpa@zytor.com, acme@redhat.com, namhyung@kernel.org,
          linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf script: Allow specifying event to switch on
 processing of other events
Git-Commit-ID: f90a24171a8179a29e5e1532fd5bb94e59b5380e
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

Commit-ID:  f90a24171a8179a29e5e1532fd5bb94e59b5380e
Gitweb:     https://git.kernel.org/tip/f90a24171a8179a29e5e1532fd5bb94e59b5380e
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 14 Aug 2019 16:20:13 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 15 Aug 2019 12:23:58 -0300

perf script: Allow specifying event to switch on processing of other events

Sometime we want to only consider events after something happens, so
allow discarding events till such events is found, e.g.:

Record all scheduler tracepoints and the sys_enter_nanosleep syscall
event for the 'sleep 1' workload:

  # perf record -e sched:*,syscalls:sys_enter_nanosleep sleep 1
  [ perf record: Woken up 31 times to write data ]
  [ perf record: Captured and wrote 0.032 MB perf.data (10 samples) ]
  #

So we have these events in the generated perf data file:

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
  syscalls:sys_enter_nanosleep
  # Tip: use 'perf evlist --trace-fields' to show fields for tracepoint events
  #

Then show all of the events that actually took place in this 'perf record' session:

  # perf script
          :13637 13637 [002] 108237.581529:            sched:sched_waking: comm=perf pid=13638 prio=120 target_cpu=001
          :13637 13637 [002] 108237.581537:            sched:sched_wakeup: perf:13638 [120] success=1 CPU:001
           sleep 13638 [001] 108237.581992:      sched:sched_process_exec: filename=/usr/bin/sleep pid=13638 old_pid=13638
           sleep 13638 [001] 108237.582286:  syscalls:sys_enter_nanosleep: rqtp: 0x7fff1948ac40, rmtp: 0x00000000
           sleep 13638 [001] 108237.582289:      sched:sched_stat_runtime: comm=sleep pid=13638 runtime=578104 [ns] vruntime=202889459556 [ns]
           sleep 13638 [001] 108237.582291:            sched:sched_switch: sleep:13638 [120] S ==> swapper/1:0 [120]
         swapper     0 [001] 108238.582428:            sched:sched_waking: comm=sleep pid=13638 prio=120 target_cpu=001
         swapper     0 [001] 108238.582458:            sched:sched_wakeup: sleep:13638 [120] success=1 CPU:001
           sleep 13638 [001] 108238.582698:      sched:sched_stat_runtime: comm=sleep pid=13638 runtime=173915 [ns] vruntime=202889633471 [ns]
           sleep 13638 [001] 108238.582782:      sched:sched_process_exit: comm=sleep pid=13638 prio=120
  #

Now lets see only the ones that took place after a certain "marker":

  # perf script --switch-on syscalls:sys_enter_nanosleep
           sleep 13638 [001] 108237.582289:      sched:sched_stat_runtime: comm=sleep pid=13638 runtime=578104 [ns] vruntime=202889459556 [ns]
           sleep 13638 [001] 108237.582291:            sched:sched_switch: sleep:13638 [120] S ==> swapper/1:0 [120]
         swapper     0 [001] 108238.582428:            sched:sched_waking: comm=sleep pid=13638 prio=120 target_cpu=001
         swapper     0 [001] 108238.582458:            sched:sched_wakeup: sleep:13638 [120] success=1 CPU:001
           sleep 13638 [001] 108238.582698:      sched:sched_stat_runtime: comm=sleep pid=13638 runtime=173915 [ns] vruntime=202889633471 [ns]
           sleep 13638 [001] 108238.582782:      sched:sched_process_exit: comm=sleep pid=13638 prio=120
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: William Cohen <wcohen@redhat.com>
Link: https://lkml.kernel.org/n/tip-f1oo0ufdhrkx6nhy2lj1ierm@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-script.txt |  3 +++
 tools/perf/builtin-script.c              | 26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index caaab28f8400..9936819aae1c 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -417,6 +417,9 @@ include::itrace.txt[]
 	For itrace only show specified functions and their callees for
 	itrace. Multiple functions can be separated by comma.
 
+--switch-on EVENT_NAME::
+	Only consider events after this event is found.
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-script-perl[1],
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 31a529ec139f..d0bc7ccaf7bf 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1616,6 +1616,11 @@ static int perf_sample__fprintf_synth(struct perf_sample *sample,
 	return 0;
 }
 
+struct evswitch {
+	struct evsel *on;
+	bool	     discarding;
+};
+
 struct perf_script {
 	struct perf_tool	tool;
 	struct perf_session	*session;
@@ -1628,6 +1633,7 @@ struct perf_script {
 	bool			show_bpf_events;
 	bool			allocated;
 	bool			per_event_dump;
+	struct evswitch		evswitch;
 	struct perf_cpu_map	*cpus;
 	struct perf_thread_map *threads;
 	int			name_width;
@@ -1805,6 +1811,13 @@ static void process_event(struct perf_script *script,
 	if (!show_event(sample, evsel, thread, al))
 		return;
 
+	if (script->evswitch.on && script->evswitch.discarding) {
+		if (script->evswitch.on != evsel)
+			return;
+
+		script->evswitch.discarding = false;
+	}
+
 	++es->samples;
 
 	perf_sample__fprintf_start(sample, thread, evsel,
@@ -3395,6 +3408,7 @@ int cmd_script(int argc, const char **argv)
 	struct utsname uts;
 	char *script_path = NULL;
 	const char **__argv;
+	const char *event_switch_on = NULL;
 	int i, j, err = 0;
 	struct perf_script script = {
 		.tool = {
@@ -3538,6 +3552,8 @@ int cmd_script(int argc, const char **argv)
 		   "file", "file saving guest os /proc/kallsyms"),
 	OPT_STRING(0, "guestmodules", &symbol_conf.default_guest_modules,
 		   "file", "file saving guest os /proc/modules"),
+	OPT_STRING(0, "switch-on", &event_switch_on,
+		   "event", "Consider events from the first ocurrence of this event"),
 	OPT_END()
 	};
 	const char * const script_subcommands[] = { "record", "report", NULL };
@@ -3862,6 +3878,16 @@ int cmd_script(int argc, const char **argv)
 						  script.range_num);
 	}
 
+	if (event_switch_on) {
+		script.evswitch.on = perf_evlist__find_evsel_by_str(session->evlist, event_switch_on);
+		if (script.evswitch.on == NULL) {
+			fprintf(stderr, "switch-on event not found (%s)\n", event_switch_on);
+			err = -ENOENT;
+			goto out_delete;
+		}
+		script.evswitch.discarding = true;
+	}
+
 	err = __cmd_script(&script);
 
 	flush_scripting();
