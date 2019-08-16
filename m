Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24531C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D4521743
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565986691;
	bh=EFHhySAKhOufzUanLX7gBckG/407kAq6XJLODX2eRpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n294yPr7vbysqD1JG6tBXeWspU+giiEUPtth4BWld7CZ8GI7pye4EB2vKer5AoHpt
	 p+BpUf79iLxI1REX4aIolBIgHgCDl2qGVd9bVPtZ7g7q7Zkduc1Q3BdwiG5BkH+Til
	 sohrXmG85GPuWE81BC6CK/MtJ/hTBLbcniITFogI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbfHPUSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 16:18:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:58254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727705AbfHPURZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 16:17:25 -0400
Received: from quaco.ghostprotocols.net (unknown [179.182.221.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7EF82133F;
        Fri, 16 Aug 2019 20:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565986643;
        bh=EFHhySAKhOufzUanLX7gBckG/407kAq6XJLODX2eRpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r0y7HtmRInVICxhqcBHPfQgGotjau0j/sXVDVzUQ676AWnrZWcZCiGC1ejgD+K5KJ
         k+1SMlGqeazttoNi0X8BZtzA3ExCOP6tjrjGWZhyOE6pFZh0YeAO6eVGn0auAyLnE3
         jpemYyqb+qrhoSXp2n8mEPPITGVRGjhHM+KYR5Y8=
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
Subject: [PATCH 04/17] perf script: Allow specifying event to switch off processing of other events
Date:   Fri, 16 Aug 2019 17:16:40 -0300
Message-Id: <20190816201653.19332-5-acme@kernel.org>
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

Counterpart of --switch-on:

  # perf record -e sched:*,syscalls:sys_*_nanosleep sleep 1
  [ perf record: Woken up 36 times to write data ]
  [ perf record: Captured and wrote 0.032 MB perf.data (10 samples) ]
  #
  # perf script
      :20918 20918 [002] 109866.143696:            sched:sched_waking: comm=perf pid=20919 prio=120 target_cpu=001
      :20918 20918 [002] 109866.143702:            sched:sched_wakeup: perf:20919 [120] success=1 CPU:001
       sleep 20919 [001] 109866.144081:      sched:sched_process_exec: filename=/usr/bin/sleep pid=20919 old_pid=20919
       sleep 20919 [001] 109866.144408:  syscalls:sys_enter_nanosleep: rqtp: 0x7ffc2384fef0, rmtp: 0x00000000
       sleep 20919 [001] 109866.144411:      sched:sched_stat_runtime: comm=sleep pid=20919 runtime=521249 [ns] vruntime=202919398131 [n>
       sleep 20919 [001] 109866.144412:            sched:sched_switch: sleep:20919 [120] S ==> swapper/1:0 [120]
     swapper     0 [001] 109867.144568:            sched:sched_waking: comm=sleep pid=20919 prio=120 target_cpu=001
     swapper     0 [001] 109867.144586:            sched:sched_wakeup: sleep:20919 [120] success=1 CPU:001
       sleep 20919 [001] 109867.144614:   syscalls:sys_exit_nanosleep: 0x0
       sleep 20919 [001] 109867.144753:      sched:sched_process_exit: comm=sleep pid=20919 prio=120
  #
  # perf script --switch-off syscalls:sys_exit_nanosleep
      :20918 20918 [002] 109866.143696:            sched:sched_waking: comm=perf pid=20919 prio=120 target_cpu=001
      :20918 20918 [002] 109866.143702:            sched:sched_wakeup: perf:20919 [120] success=1 CPU:001
       sleep 20919 [001] 109866.144081:      sched:sched_process_exec: filename=/usr/bin/sleep pid=20919 old_pid=20919
       sleep 20919 [001] 109866.144408:  syscalls:sys_enter_nanosleep: rqtp: 0x7ffc2384fef0, rmtp: 0x00000000
       sleep 20919 [001] 109866.144411:      sched:sched_stat_runtime: comm=sleep pid=20919 runtime=521249 [ns] vruntime=202919398131 [n>
       sleep 20919 [001] 109866.144412:            sched:sched_switch: sleep:20919 [120] S ==> swapper/1:0 [120]
     swapper     0 [001] 109867.144568:            sched:sched_waking: comm=sleep pid=20919 prio=120 target_cpu=001
     swapper     0 [001] 109867.144586:            sched:sched_wakeup: sleep:20919 [120] success=1 CPU:001
       sleep 20919 [001] 109867.144753:      sched:sched_process_exit: comm=sleep pid=20919 prio=120
  #
  # perf script --switch-on syscalls:sys_enter_nanosleep --switch-off syscalls:sys_exit_nanosleep
       sleep 20919 [001] 109866.144411:      sched:sched_stat_runtime: comm=sleep pid=20919 runtime=521249 [ns] vruntime=202919398131 [n>
       sleep 20919 [001] 109866.144412:            sched:sched_switch: sleep:20919 [120] S ==> swapper/1:0 [120]
     swapper     0 [001] 109867.144568:            sched:sched_waking: comm=sleep pid=20919 prio=120 target_cpu=001
     swapper     0 [001] 109867.144586:            sched:sched_wakeup: sleep:20919 [120] success=1 CPU:001
  #
  # perf script --switch-on syscalls:sys_enter_nanosleep --switch-off syscalls:sys_exit_nanosleep --show-on-off
       sleep 20919 [001] 109866.144408:  syscalls:sys_enter_nanosleep: rqtp: 0x7ffc2384fef0, rmtp: 0x00000000
       sleep 20919 [001] 109866.144411:      sched:sched_stat_runtime: comm=sleep pid=20919 runtime=521249 [ns] vruntime=202919398131 [n>
       sleep 20919 [001] 109866.144412:            sched:sched_switch: sleep:20919 [120] S ==> swapper/1:0 [120]
     swapper     0 [001] 109867.144568:            sched:sched_waking: comm=sleep pid=20919 prio=120 target_cpu=001
     swapper     0 [001] 109867.144586:            sched:sched_wakeup: sleep:20919 [120] success=1 CPU:001
       sleep 20919 [001] 109867.144614:   syscalls:sys_exit_nanosleep: 0x0
  #

Now think about using this together with 'perf probe' to create custom on/off
events in your app :-)

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: William Cohen <wcohen@redhat.com>
Link: https://lkml.kernel.org/n/tip-li3j01c4tmj9kw6ydsl8swej@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-script.txt |  5 +++-
 tools/perf/builtin-script.c              | 31 +++++++++++++++++++++---
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 24eea68ee829..2599b057e47b 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -420,8 +420,11 @@ include::itrace.txt[]
 --switch-on EVENT_NAME::
 	Only consider events after this event is found.
 
+--switch-off EVENT_NAME::
+	Stop considering events after this event is found.
+
 --show-on-off-events::
-	Show the --switch-on event too.
+	Show the --switch-on/off events too.
 
 SEE ALSO
 --------
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index fa0cc8b0eccc..b6eed0f7e835 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1617,7 +1617,8 @@ static int perf_sample__fprintf_synth(struct perf_sample *sample,
 }
 
 struct evswitch {
-	struct evsel *on;
+	struct evsel *on,
+		     *off;
 	bool	     discarding;
 	bool	     show_on_off_events;
 };
@@ -1820,8 +1821,20 @@ static void process_event(struct perf_script *script,
 
 		if (!script->evswitch.show_on_off_events)
 			return;
+
+		goto print_it;
 	}
 
+	if (script->evswitch.off && !script->evswitch.discarding) {
+		if (script->evswitch.off != evsel)
+			goto print_it;
+
+		script->evswitch.discarding = true;
+
+		if (!script->evswitch.show_on_off_events)
+			return;
+	}
+print_it:
 	++es->samples;
 
 	perf_sample__fprintf_start(sample, thread, evsel,
@@ -3412,7 +3425,8 @@ int cmd_script(int argc, const char **argv)
 	struct utsname uts;
 	char *script_path = NULL;
 	const char **__argv;
-	const char *event_switch_on = NULL;
+	const char *event_switch_on  = NULL,
+		   *event_switch_off = NULL;
 	int i, j, err = 0;
 	struct perf_script script = {
 		.tool = {
@@ -3557,7 +3571,9 @@ int cmd_script(int argc, const char **argv)
 	OPT_STRING(0, "guestmodules", &symbol_conf.default_guest_modules,
 		   "file", "file saving guest os /proc/modules"),
 	OPT_STRING(0, "switch-on", &event_switch_on,
-		   "event", "Consider events from the first ocurrence of this event"),
+		   "event", "Consider events after the ocurrence of this event"),
+	OPT_STRING(0, "switch-off", &event_switch_off,
+		   "event", "Stop considering events after the ocurrence of this event"),
 	OPT_BOOLEAN(0, "show-on-off-events", &script.evswitch.show_on_off_events,
 		    "Show the on/off switch events, used with --switch-on"),
 	OPT_END()
@@ -3894,6 +3910,15 @@ int cmd_script(int argc, const char **argv)
 		script.evswitch.discarding = true;
 	}
 
+	if (event_switch_off) {
+		script.evswitch.off = perf_evlist__find_evsel_by_str(session->evlist, event_switch_off);
+		if (script.evswitch.off == NULL) {
+			fprintf(stderr, "switch-off event not found (%s)\n", event_switch_off);
+			err = -ENOENT;
+			goto out_delete;
+		}
+	}
+
 	err = __cmd_script(&script);
 
 	flush_scripting();
-- 
2.21.0

