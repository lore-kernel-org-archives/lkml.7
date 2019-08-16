Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC95C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC8F2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565986683;
	bh=imbtHHy7FTe558siEhaa/uGPs/mpd1peQXhe/ZOPVNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Oag/djDx99ps+yxv+7MxYRI8b7x9hlp6N2603qdo0R1/dbNFtHnMDl5MDldI2ri+e
	 HnJQBZEit9EY4h7HjUlWwHqGWn6cBscRHPp7SPNrIGMkVVAKvvS6l8N1WKPhZZTUxq
	 tzENJYvpGdVfdQWqCQl4mF5TQdUbjdSIMcBj3DKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfHPUSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 16:18:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:58836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727604AbfHPUSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 16:18:00 -0400
Received: from quaco.ghostprotocols.net (unknown [179.182.221.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AA7921721;
        Fri, 16 Aug 2019 20:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565986679;
        bh=imbtHHy7FTe558siEhaa/uGPs/mpd1peQXhe/ZOPVNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O+2h0nMNxIsL0DkOacfsV/TvlI3zKcGevdy434YgYTyCLTYn+lRVHRZZsmmWzu0nb
         nsbswtJia8fozRHM8r92f93amnVruX8NXTMwqtLW7EwAIvViufq4rPbqGmEHpwsMVI
         If9mXNxeQboT8+GarKMMtpAnqWRij6sfYQ2iJIQQ=
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
Subject: [PATCH 12/17] perf trace: Add --switch-on/--switch-off events
Date:   Fri, 16 Aug 2019 17:16:48 -0300
Message-Id: <20190816201653.19332-13-acme@kernel.org>
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

Just like with 'perf script':

  # perf trace -e sched:*,syscalls:*sleep* sleep 1
       0.000 :28345/28345 sched:sched_waking:comm=perf pid=28346 prio=120 target_cpu=005
       0.005 :28345/28345 sched:sched_wakeup:perf:28346 [120] success=1 CPU:005
       0.383 sleep/28346 sched:sched_process_exec:filename=/usr/bin/sleep pid=28346 old_pid=28346
       0.613 sleep/28346 sched:sched_stat_runtime:comm=sleep pid=28346 runtime=607375 [ns] vruntime=23289041218 [ns]
       0.689 sleep/28346 syscalls:sys_enter_nanosleep:rqtp: 0x7ffc491789b0
       0.693 sleep/28346 sched:sched_stat_runtime:comm=sleep pid=28346 runtime=72021 [ns] vruntime=23289113239 [ns]
       0.694 sleep/28346 sched:sched_switch:sleep:28346 [120] S ==> swapper/5:0 [120]
    1000.787 :0/0 sched:sched_waking:comm=sleep pid=28346 prio=120 target_cpu=005
    1000.824 :0/0 sched:sched_wakeup:sleep:28346 [120] success=1 CPU:005
    1000.908 sleep/28346 syscalls:sys_exit_nanosleep:0x0
    1001.218 sleep/28346 sched:sched_process_exit:comm=sleep pid=28346 prio=120
  # perf trace -e sched:*,syscalls:*sleep* --switch-on=syscalls:sys_enter_nanosleep sleep 1
       0.000 sleep/28349 sched:sched_stat_runtime:comm=sleep pid=28349 runtime=603036 [ns] vruntime=23873537697 [ns]
       0.001 sleep/28349 sched:sched_switch:sleep:28349 [120] S ==> swapper/4:0 [120]
    1000.392 :0/0 sched:sched_waking:comm=sleep pid=28349 prio=120 target_cpu=004
    1000.443 :0/0 sched:sched_wakeup:sleep:28349 [120] success=1 CPU:004
    1000.540 sleep/28349 syscalls:sys_exit_nanosleep:0x0
    1000.852 sleep/28349 sched:sched_process_exit:comm=sleep pid=28349 prio=120
  # perf trace -e sched:*,syscalls:*sleep* --switch-on=syscalls:sys_enter_nanosleep --switch-off=syscalls:sys_exit_nanosleep sleep 1
       0.000 sleep/28352 sched:sched_stat_runtime:comm=sleep pid=28352 runtime=610543 [ns] vruntime=24811686681 [ns]
       0.001 sleep/28352 sched:sched_switch:sleep:28352 [120] S ==> swapper/0:0 [120]
    1000.397 :0/0 sched:sched_waking:comm=sleep pid=28352 prio=120 target_cpu=000
    1000.440 :0/0 sched:sched_wakeup:sleep:28352 [120] success=1 CPU:000
  #
  # perf trace -e sched:*,syscalls:*sleep* --switch-on=syscalls:sys_enter_nanosleep --switch-off=syscalls:sys_exit_nanosleep --show-on-off sleep 1
       0.000 sleep/28367 syscalls:sys_enter_nanosleep:rqtp: 0x7fffd1a25fc0
       0.004 sleep/28367 sched:sched_stat_runtime:comm=sleep pid=28367 runtime=628760 [ns] vruntime=22170052672 [ns]
       0.005 sleep/28367 sched:sched_switch:sleep:28367 [120] S ==> swapper/2:0 [120]
    1000.367 :0/0 sched:sched_waking:comm=sleep pid=28367 prio=120 target_cpu=002
    1000.412 :0/0 sched:sched_wakeup:sleep:28367 [120] success=1 CPU:002
    1000.512 sleep/28367 syscalls:sys_exit_nanosleep:0x0
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: William Cohen <wcohen@redhat.com>
Link: https://lkml.kernel.org/n/tip-t3ngpt1brcc1fm9gep9gxm4q@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-trace.txt |  9 +++++++++
 tools/perf/builtin-trace.c              | 10 ++++++++++
 2 files changed, 19 insertions(+)

diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
index fc6e43262c41..25b74fdb36fa 100644
--- a/tools/perf/Documentation/perf-trace.txt
+++ b/tools/perf/Documentation/perf-trace.txt
@@ -176,6 +176,15 @@ the thread executes on the designated CPUs. Default is to monitor all CPUs.
 	only at exit time or when a syscall is interrupted, i.e. in those cases this
 	option is equivalent to the number of lines printed.
 
+--switch-on EVENT_NAME::
+	Only consider events after this event is found.
+
+--switch-off EVENT_NAME::
+	Stop considering events after this event is found.
+
+--show-on-off-events::
+	Show the --switch-on/off events too.
+
 --max-stack::
         Set the stack depth limit when parsing the callchain, anything
         beyond the specified depth will be ignored. Note that at this point
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d553d06a9aeb..bc44ed29e05a 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -27,6 +27,7 @@
 #include "util/env.h"
 #include "util/event.h"
 #include "util/evlist.h"
+#include "util/evswitch.h"
 #include <subcmd/exec-cmd.h>
 #include "util/machine.h"
 #include "util/map.h"
@@ -106,6 +107,7 @@ struct trace {
 	unsigned long		nr_events;
 	unsigned long		nr_events_printed;
 	unsigned long		max_events;
+	struct evswitch		evswitch;
 	struct strlist		*ev_qualifier;
 	struct {
 		size_t		nr;
@@ -2680,6 +2682,9 @@ static void trace__handle_event(struct trace *trace, union perf_event *event, st
 		return;
 	}
 
+	if (evswitch__discard(&trace->evswitch, evsel))
+		return;
+
 	trace__set_base_time(trace, evsel, sample);
 
 	if (evsel->core.attr.type == PERF_TYPE_TRACEPOINT &&
@@ -4157,6 +4162,7 @@ int cmd_trace(int argc, const char **argv)
 	OPT_UINTEGER('D', "delay", &trace.opts.initial_delay,
 		     "ms to wait before starting measurement after program "
 		     "start"),
+	OPTS_EVSWITCH(&trace.evswitch),
 	OPT_END()
 	};
 	bool __maybe_unused max_stack_user_set = true;
@@ -4380,6 +4386,10 @@ int cmd_trace(int argc, const char **argv)
 		}
 	}
 
+	err = evswitch__init(&trace.evswitch, trace.evlist, stderr);
+	if (err)
+		goto out_close;
+
 	err = target__validate(&trace.opts.target);
 	if (err) {
 		target__strerror(&trace.opts.target, err, bf, sizeof(bf));
-- 
2.21.0

