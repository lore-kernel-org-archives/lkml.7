Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC97C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685E92173E
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565986649;
	bh=yRS+dFo0j187s1Bd0C1C9rWkrLt6WIa5GpBChcSMaA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Paj04CLSXxW5FGtcZz5M2XpAdrIWILbYLne+2F7nVAUV5vri4rdw7tSOXB6mWCKTn
	 BiW/0VafiDOE2qisWjFmmDM2wNOhXsjrHcvKAFN/IuetEepcyY9MZr3RZxEDp/ks8o
	 SzPb4qqn+ppMOI7HeO4MdiYI2DygJU+YJS2OxjjE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbfHPUR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 16:17:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:58112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727569AbfHPURP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 16:17:15 -0400
Received: from quaco.ghostprotocols.net (unknown [179.182.221.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D15ED21721;
        Fri, 16 Aug 2019 20:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565986633;
        bh=yRS+dFo0j187s1Bd0C1C9rWkrLt6WIa5GpBChcSMaA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QyPhYTUafmhcdtLS39WKVlJD1O55Fi8SLoVj57ouBZ2/ZdrRNOE5F2UUAP9Evn+1F
         O6W7DpwxQ0kN2ysfh9ss4tBWQUq8nFPcvhv117kfJUJ7CVyIhh4N8ni2M8JGukHGjA
         Vf6f6H4W0JFoLYVW7uJsv2g6ZMzJwckTFvOI9HuA=
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
Subject: [PATCH 02/17] perf script: Allow specifying event to switch on processing of other events
Date:   Fri, 16 Aug 2019 17:16:38 -0300
Message-Id: <20190816201653.19332-3-acme@kernel.org>
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
 tools/perf/builtin-script.c              | 26 ++++++++++++++++++++++++
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
-- 
2.21.0

