Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6934BC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3578622ADA
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="hZjRVsOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfE3INH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 04:13:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52471 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfE3ING (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:13:06 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4U8Cff82904613
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 30 May 2019 01:12:41 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4U8Cff82904613
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559203962;
        bh=aAZ8BRG+yeRcO4aQFz1TniPOkjFLVk+Loti+j3Al4EM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=hZjRVsOhEjzAig0Kl6APrw6DaoHPLUJGuzbNvxABWkBiIlOG+Ykptr28edgl5Es4Q
         otTfViIv5RiowgL612IKnSE9EpZTkZVktJ/Tm9k1pSCm3ozV55QP9KhBI02w/LzpaZ
         dQUx6Fo6sl3mlbTOKGNL+KXuBrF8tsoTaBF6W21PVlyKR+LuSuaWdk5PLrqhksN0dl
         vVCf6PptqC4muiV2DRqOdh0LCZTIh6vw3OPlL92frN8eai+4e5yzq8neJpKIBkj3bL
         xh9Hg5SdNhTnYNCNuGPZFZJCKnBvW8vS4nI3b0q7yshe3c1YGO59heUHMQbmjHALdy
         OSD9l0tmkGQvg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4U8CfMa2904610;
        Thu, 30 May 2019 01:12:41 -0700
Date:   Thu, 30 May 2019 01:12:41 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-490c8cc949eca14bfdbee0ad1cd1c6d3ddf46b77@git.kernel.org>
Cc:     ak@linux.intel.com, peterz@infradead.org, sdf@google.com,
        adrian.hunter@intel.com, mingo@kernel.org, acme@redhat.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        songliubraving@fb.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, hpa@zytor.com, jolsa@kernel.org
Reply-To: mingo@kernel.org, acme@redhat.com, peterz@infradead.org,
          ak@linux.intel.com, adrian.hunter@intel.com, sdf@google.com,
          alexander.shishkin@linux.intel.com, songliubraving@fb.com,
          jolsa@kernel.org, hpa@zytor.com, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <20190508132010.14512-11-jolsa@kernel.org>
References: <20190508132010.14512-11-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf script: Add --show-bpf-events to show eBPF
 related events
Git-Commit-ID: 490c8cc949eca14bfdbee0ad1cd1c6d3ddf46b77
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

Commit-ID:  490c8cc949eca14bfdbee0ad1cd1c6d3ddf46b77
Gitweb:     https://git.kernel.org/tip/490c8cc949eca14bfdbee0ad1cd1c6d3ddf46b77
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 8 May 2019 15:20:08 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 18:37:44 -0300

perf script: Add --show-bpf-events to show eBPF related events

Add the --show-bpf-events command line option to show the eBPF related events:

  PERF_RECORD_KSYMBOL
  PERF_RECORD_BPF_EVENT

Usage:

  # perf record -a
  ...
  # perf script --show-bpf-events
  ...
  swapper     0 [000]     0.000000: PERF_RECORD_KSYMBOL ksymbol event with addr ffffffffc0ef971d len 229 type 1 flags 0x0 name bpf_prog_2a142ef67aaad174
  swapper     0 [000]     0.000000: PERF_RECORD_BPF_EVENT bpf event with type 1, flags 0, id 36
  ...

Committer testing:

  # perf script --show-bpf-events | egrep -i 'PERF_RECORD_(BPF|KSY)'
    0 PERF_RECORD_KSYMBOL ksymbol event with addr ffffffffc029a6c3 len 229 type 1 flags 0x0 name bpf_prog_7be49e3934a125ba
    0 PERF_RECORD_BPF_EVENT bpf event with type 1, flags 0, id 47
    0 PERF_RECORD_KSYMBOL ksymbol event with addr ffffffffc029c1ae len 229 type 1 flags 0x0 name bpf_prog_2a142ef67aaad174
    0 PERF_RECORD_BPF_EVENT bpf event with type 1, flags 0, id 48
    0 PERF_RECORD_KSYMBOL ksymbol event with addr ffffffffc02ddd1c len 229 type 1 flags 0x0 name bpf_prog_7be49e3934a125ba
    0 PERF_RECORD_BPF_EVENT bpf event with type 1, flags 0, id 49
    0 PERF_RECORD_KSYMBOL ksymbol event with addr ffffffffc02dfc11 len 229 type 1 flags 0x0 name bpf_prog_2a142ef67aaad174
    0 PERF_RECORD_BPF_EVENT bpf event with type 1, flags 0, id 50
    0 PERF_RECORD_KSYMBOL ksymbol event with addr ffffffffc045da0a len 229 type 1 flags 0x0 name bpf_prog_7be49e3934a125ba
    0 PERF_RECORD_BPF_EVENT bpf event with type 1, flags 0, id 51
    0 PERF_RECORD_KSYMBOL ksymbol event with addr ffffffffc04ef4b4 len 229 type 1 flags 0x0 name bpf_prog_2a142ef67aaad174
    0 PERF_RECORD_BPF_EVENT bpf event with type 1, flags 0, id 52
    0 PERF_RECORD_KSYMBOL ksymbol event with addr ffffffffc09e15da len 229 type 1 flags 0x0 name bpf_prog_7be49e3934a125ba
    0 PERF_RECORD_BPF_EVENT bpf event with type 1, flags 0, id 53
    0 PERF_RECORD_KSYMBOL ksymbol event with addr ffffffffc0d2b1a3 len 229 type 1 flags 0x0 name bpf_prog_2a142ef67aaad174
    0 PERF_RECORD_BPF_EVENT bpf event with type 1, flags 0, id 54
    0 PERF_RECORD_KSYMBOL ksymbol event with addr ffffffffc0fd9850 len 381 type 1 flags 0x0 name bpf_prog_819967866022f1e1_sys_enter
    0 PERF_RECORD_BPF_EVENT bpf event with type 1, flags 0, id 179
    0 PERF_RECORD_KSYMBOL ksymbol event with addr ffffffffc0feb1ec len 191 type 1 flags 0x0 name bpf_prog_c1bd85c092d6e4aa_sys_exit
    0 PERF_RECORD_BPF_EVENT bpf event with type 1, flags 0, id 180
  ^C[root@quaco pt]# perf evlist
  intel_pt//ku
  dummy:u
  #

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Song Liu <songliubraving@fb.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stanislav Fomichev <sdf@google.com>
Link: http://lkml.kernel.org/r/20190508132010.14512-11-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-script.txt |  3 +++
 tools/perf/builtin-script.c              | 42 ++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 9b0d04dd2a61..af8282782911 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -313,6 +313,9 @@ OPTIONS
 --show-round-events
 	Display finished round events i.e. events of type PERF_RECORD_FINISHED_ROUND.
 
+--show-bpf-events
+	Display bpf events i.e. events of type PERF_RECORD_KSYMBOL and PERF_RECORD_BPF_EVENT.
+
 --demangle::
 	Demangle symbol names to human readable form. It's enabled by default,
 	disable with --no-demangle.
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 7adaa6c63a0b..3a48a2627670 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1606,6 +1606,7 @@ struct perf_script {
 	bool			show_namespace_events;
 	bool			show_lost_events;
 	bool			show_round_events;
+	bool			show_bpf_events;
 	bool			allocated;
 	bool			per_event_dump;
 	struct cpu_map		*cpus;
@@ -2318,6 +2319,41 @@ process_finished_round_event(struct perf_tool *tool __maybe_unused,
 	return 0;
 }
 
+static int
+process_bpf_events(struct perf_tool *tool __maybe_unused,
+		   union perf_event *event,
+		   struct perf_sample *sample,
+		   struct machine *machine)
+{
+	struct thread *thread;
+	struct perf_script *script = container_of(tool, struct perf_script, tool);
+	struct perf_session *session = script->session;
+	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
+
+	if (machine__process_ksymbol(machine, event, sample) < 0)
+		return -1;
+
+	if (!evsel->attr.sample_id_all) {
+		perf_event__fprintf(event, stdout);
+		return 0;
+	}
+
+	thread = machine__findnew_thread(machine, sample->pid, sample->tid);
+	if (thread == NULL) {
+		pr_debug("problem processing MMAP event, skipping it.\n");
+		return -1;
+	}
+
+	if (!filter_cpu(sample)) {
+		perf_sample__fprintf_start(sample, thread, evsel,
+					   event->header.type, stdout);
+		perf_event__fprintf(event, stdout);
+	}
+
+	thread__put(thread);
+	return 0;
+}
+
 static void sig_handler(int sig __maybe_unused)
 {
 	session_done = 1;
@@ -2420,6 +2456,10 @@ static int __cmd_script(struct perf_script *script)
 		script->tool.ordered_events = false;
 		script->tool.finished_round = process_finished_round_event;
 	}
+	if (script->show_bpf_events) {
+		script->tool.ksymbol   = process_bpf_events;
+		script->tool.bpf_event = process_bpf_events;
+	}
 
 	if (perf_script__setup_per_event_dump(script)) {
 		pr_err("Couldn't create the per event dump files\n");
@@ -3439,6 +3479,8 @@ int cmd_script(int argc, const char **argv)
 		    "Show lost events (if recorded)"),
 	OPT_BOOLEAN('\0', "show-round-events", &script.show_round_events,
 		    "Show round events (if recorded)"),
+	OPT_BOOLEAN('\0', "show-bpf-events", &script.show_bpf_events,
+		    "Show bpf related events (if recorded)"),
 	OPT_BOOLEAN('\0', "per-event-dump", &script.per_event_dump,
 		    "Dump trace output to files named by the monitored events"),
 	OPT_BOOLEAN('f', "force", &symbol_conf.force, "don't complain, do it"),
