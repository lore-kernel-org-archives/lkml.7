Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED448C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3DBA21744
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557321650;
	bh=ShqODtTONotPEZu0Fk7Uk4ZcJxUQxh2QoXT5ZfuStl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lqnS+6zc+z5+ajVT2Huor2vMNDq6yqFbP5Waw3puNaGbG2Y5JuRhemmiIq5aDz8CJ
	 4RDxr0v4ZCpqWjqxFVeAUYI2sqqyxpVw65u5k385e2t+F+4veKU8l5se/+fdy8+Ff9
	 ajHkeaOCbmwIzifGkPZIliUugWcqvAfZIbvAmQd0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbfEHNUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 09:20:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58142 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727964AbfEHNUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 09:20:47 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1204E8046D;
        Wed,  8 May 2019 13:20:47 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-49.brq.redhat.com [10.40.204.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7FB7C10027D5;
        Wed,  8 May 2019 13:20:44 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 10/12] perf script: Add --show-bpf-events to show eBPF related events
Date:   Wed,  8 May 2019 15:20:08 +0200
Message-Id: <20190508132010.14512-11-jolsa@kernel.org>
In-Reply-To: <20190508132010.14512-1-jolsa@kernel.org>
References: <20190508132010.14512-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 08 May 2019 13:20:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding --show-bpf-events to show eBPF related events:
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

Link: http://lkml.kernel.org/n/tip-9kvkcw7z4i1464jb7gasv4lb@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Documentation/perf-script.txt |  3 ++
 tools/perf/builtin-script.c              | 42 ++++++++++++++++++++++++
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
-- 
2.20.1

