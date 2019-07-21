Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC92C76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE432085A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563708369;
	bh=XcsXMPKTvcfMfeutsuOaakS+vk9iukBWbQZqiu3ZRko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gBTRdxKPBb98ucTRIJ+CEcJ4aQRMtvvHJGjA8O13bELPBS5hs4CLSywmlAWguOK/K
	 gTzQmuK6XDTr/RSWDXcvixIGsQr4QSZt12pgC7GVyiwrP0W4CwHPW6oD3S6jcprTvA
	 ch26k7YZ1UUD7gzaEipF8V0Ff46vIMdsStRFDayI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfGUL0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:26:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53284 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726475AbfGUL0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:26:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 18EA53086262;
        Sun, 21 Jul 2019 11:26:02 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 57C165D9D3;
        Sun, 21 Jul 2019 11:25:39 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 04/79] perf tools: Rename struct perf_evsel to struct evsel
Date:   Sun, 21 Jul 2019 13:23:51 +0200
Message-Id: <20190721112506.12306-5-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Sun, 21 Jul 2019 11:26:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renaming struct perf_evsel to struct evsel, so we don't
have a name clash when we add struct perf_evsel in libperf.

Link: http://lkml.kernel.org/n/tip-1edw2wq100919lffp35h3snp@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/arch/arm/util/auxtrace.c           |   2 +-
 tools/perf/arch/arm/util/cs-etm.c             |  14 +-
 tools/perf/arch/powerpc/util/kvm-stat.c       |   6 +-
 tools/perf/arch/s390/util/auxtrace.c          |   2 +-
 tools/perf/arch/s390/util/kvm-stat.c          |   8 +-
 tools/perf/arch/x86/tests/intel-cqm.c         |   2 +-
 tools/perf/arch/x86/tests/perf-time-to-tsc.c  |   2 +-
 tools/perf/arch/x86/util/auxtrace.c           |   2 +-
 tools/perf/arch/x86/util/intel-bts.c          |  10 +-
 tools/perf/arch/x86/util/intel-pt.c           |  20 +--
 tools/perf/arch/x86/util/kvm-stat.c           |  12 +-
 tools/perf/builtin-annotate.c                 |  16 +-
 tools/perf/builtin-c2c.c                      |   4 +-
 tools/perf/builtin-diff.c                     |  12 +-
 tools/perf/builtin-evlist.c                   |   2 +-
 tools/perf/builtin-inject.c                   |  30 ++--
 tools/perf/builtin-kmem.c                     |  24 +--
 tools/perf/builtin-kvm.c                      |  20 +--
 tools/perf/builtin-lock.c                     |  30 ++--
 tools/perf/builtin-mem.c                      |   2 +-
 tools/perf/builtin-record.c                   |   4 +-
 tools/perf/builtin-report.c                   |  22 +--
 tools/perf/builtin-sched.c                    |  74 ++++----
 tools/perf/builtin-script.c                   |  90 +++++-----
 tools/perf/builtin-stat.c                     |  18 +-
 tools/perf/builtin-timechart.c                |  44 ++---
 tools/perf/builtin-top.c                      |  30 ++--
 tools/perf/builtin-trace.c                    |  76 ++++----
 tools/perf/tests/backward-ring-buffer.c       |   2 +-
 tools/perf/tests/code-reading.c               |   2 +-
 tools/perf/tests/event-times.c                |  14 +-
 tools/perf/tests/event_update.c               |   2 +-
 tools/perf/tests/evsel-roundtrip-name.c       |   4 +-
 tools/perf/tests/evsel-tp-sched.c             |   4 +-
 tools/perf/tests/hists_cumulate.c             |  14 +-
 tools/perf/tests/hists_filter.c               |   4 +-
 tools/perf/tests/hists_link.c                 |   4 +-
 tools/perf/tests/hists_output.c               |  16 +-
 tools/perf/tests/keep-tracking.c              |   2 +-
 tools/perf/tests/mmap-basic.c                 |   2 +-
 tools/perf/tests/openat-syscall-all-cpus.c    |   2 +-
 tools/perf/tests/openat-syscall-tp-fields.c   |   2 +-
 tools/perf/tests/openat-syscall.c             |   2 +-
 tools/perf/tests/parse-events.c               | 120 ++++++-------
 tools/perf/tests/perf-record.c                |   2 +-
 tools/perf/tests/sample-parsing.c             |   2 +-
 tools/perf/tests/sw-clock.c                   |   2 +-
 tools/perf/tests/switch-tracking.c            |  10 +-
 tools/perf/tests/task-exit.c                  |   2 +-
 tools/perf/ui/browsers/annotate.c             |  14 +-
 tools/perf/ui/browsers/hists.c                |  40 ++---
 tools/perf/ui/browsers/res_sample.c           |   2 +-
 tools/perf/ui/browsers/scripts.c              |   4 +-
 tools/perf/ui/gtk/annotate.c                  |   6 +-
 tools/perf/ui/gtk/gtk.h                       |   4 +-
 tools/perf/ui/gtk/hists.c                     |   2 +-
 tools/perf/ui/hist.c                          |   8 +-
 tools/perf/util/annotate.c                    |  32 ++--
 tools/perf/util/annotate.h                    |  26 +--
 tools/perf/util/auxtrace.c                    |   8 +-
 tools/perf/util/bpf-loader.c                  |  12 +-
 tools/perf/util/bpf-loader.h                  |   6 +-
 tools/perf/util/build-id.c                    |   2 +-
 tools/perf/util/build-id.h                    |   2 +-
 tools/perf/util/callchain.c                   |   2 +-
 tools/perf/util/callchain.h                   |   2 +-
 tools/perf/util/cgroup.c                      |  10 +-
 tools/perf/util/counts.c                      |   6 +-
 tools/perf/util/counts.h                      |   6 +-
 tools/perf/util/cs-etm.c                      |   4 +-
 tools/perf/util/data-convert-bt.c             |  18 +-
 tools/perf/util/db-export.c                   |   6 +-
 tools/perf/util/db-export.h                   |  10 +-
 tools/perf/util/evlist.c                      | 142 +++++++--------
 tools/perf/util/evlist.h                      |  46 ++---
 tools/perf/util/evsel.c                       | 168 +++++++++---------
 tools/perf/util/evsel.h                       | 146 +++++++--------
 tools/perf/util/evsel_fprintf.c               |   4 +-
 tools/perf/util/header.c                      |  58 +++---
 tools/perf/util/header.h                      |   8 +-
 tools/perf/util/hist.c                        |  26 +--
 tools/perf/util/hist.h                        |  28 +--
 tools/perf/util/intel-bts.c                   |   2 +-
 tools/perf/util/intel-pt.c                    |  36 ++--
 tools/perf/util/jitdump.c                     |   4 +-
 tools/perf/util/kvm-stat.h                    |  18 +-
 tools/perf/util/machine.c                     |   6 +-
 tools/perf/util/machine.h                     |   4 +-
 tools/perf/util/map.h                         |   2 +-
 tools/perf/util/metricgroup.c                 |  22 +--
 tools/perf/util/metricgroup.h                 |   6 +-
 tools/perf/util/parse-events.c                |  48 ++---
 tools/perf/util/parse-events.h                |   2 +-
 tools/perf/util/python.c                      |  14 +-
 tools/perf/util/record.c                      |  16 +-
 tools/perf/util/s390-cpumsf.c                 |   2 +-
 tools/perf/util/s390-sample-raw.c             |   2 +-
 .../util/scripting-engines/trace-event-perl.c |   8 +-
 .../scripting-engines/trace-event-python.c    |  22 +--
 tools/perf/util/session.c                     |  30 ++--
 tools/perf/util/session.h                     |   8 +-
 tools/perf/util/sort.c                        |  28 +--
 tools/perf/util/stat-display.c                |  60 +++----
 tools/perf/util/stat-shadow.c                 |  38 ++--
 tools/perf/util/stat.c                        |  38 ++--
 tools/perf/util/stat.h                        |  14 +-
 tools/perf/util/tool.h                        |   4 +-
 tools/perf/util/top.c                         |   2 +-
 tools/perf/util/top.h                         |   4 +-
 tools/perf/util/trace-event-info.c            |   4 +-
 tools/perf/util/trace-event-scripting.c       |   2 +-
 tools/perf/util/trace-event.h                 |   4 +-
 112 files changed, 1050 insertions(+), 1050 deletions(-)

diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
index 02014740a1aa..fd17dccfcb0b 100644
--- a/tools/perf/arch/arm/util/auxtrace.c
+++ b/tools/perf/arch/arm/util/auxtrace.c
@@ -53,7 +53,7 @@ struct auxtrace_record
 *auxtrace_record__init(struct perf_evlist *evlist, int *err)
 {
 	struct perf_pmu	*cs_etm_pmu;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	bool found_etm = false;
 	bool found_spe = false;
 	static struct perf_pmu **arm_spe_pmus = NULL;
diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 4208974c24f8..49dda28023e4 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -208,7 +208,7 @@ static int cs_etm_parse_snapshot_options(struct auxtrace_record *itr,
 }
 
 static int cs_etm_set_sink_attr(struct perf_pmu *pmu,
-				struct perf_evsel *evsel)
+				struct evsel *evsel)
 {
 	char msg[BUFSIZ], path[PATH_MAX], *sink;
 	struct perf_evsel_config_term *term;
@@ -252,7 +252,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	struct cs_etm_recording *ptr =
 				container_of(itr, struct cs_etm_recording, itr);
 	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
-	struct perf_evsel *evsel, *cs_etm_evsel = NULL;
+	struct evsel *evsel, *cs_etm_evsel = NULL;
 	struct cpu_map *cpus = evlist->cpus;
 	bool privileged = (geteuid() == 0 || perf_event_paranoid() < 0);
 	int err = 0;
@@ -407,7 +407,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 
 	/* Add dummy event to keep tracking */
 	if (opts->full_auxtrace) {
-		struct perf_evsel *tracking_evsel;
+		struct evsel *tracking_evsel;
 
 		err = parse_events(evlist, "dummy:u", NULL);
 		if (err)
@@ -435,7 +435,7 @@ static u64 cs_etm_get_config(struct auxtrace_record *itr)
 			container_of(itr, struct cs_etm_recording, itr);
 	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
 	struct perf_evlist *evlist = ptr->evlist;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (evsel->attr.type == cs_etm_pmu->type) {
@@ -817,7 +817,7 @@ static int cs_etm_snapshot_start(struct auxtrace_record *itr)
 {
 	struct cs_etm_recording *ptr =
 			container_of(itr, struct cs_etm_recording, itr);
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	evlist__for_each_entry(ptr->evlist, evsel) {
 		if (evsel->attr.type == ptr->cs_etm_pmu->type)
@@ -830,7 +830,7 @@ static int cs_etm_snapshot_finish(struct auxtrace_record *itr)
 {
 	struct cs_etm_recording *ptr =
 			container_of(itr, struct cs_etm_recording, itr);
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	evlist__for_each_entry(ptr->evlist, evsel) {
 		if (evsel->attr.type == ptr->cs_etm_pmu->type)
@@ -858,7 +858,7 @@ static int cs_etm_read_finish(struct auxtrace_record *itr, int idx)
 {
 	struct cs_etm_recording *ptr =
 			container_of(itr, struct cs_etm_recording, itr);
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	evlist__for_each_entry(ptr->evlist, evsel) {
 		if (evsel->attr.type == ptr->cs_etm_pmu->type)
diff --git a/tools/perf/arch/powerpc/util/kvm-stat.c b/tools/perf/arch/powerpc/util/kvm-stat.c
index f9db341c47b6..557c474f0a4b 100644
--- a/tools/perf/arch/powerpc/util/kvm-stat.c
+++ b/tools/perf/arch/powerpc/util/kvm-stat.c
@@ -32,7 +32,7 @@ const char *ppc_book3s_hv_kvm_tp[] = {
 const char *kvm_events_tp[NR_TPS + 1];
 const char *kvm_exit_reason;
 
-static void hcall_event_get_key(struct perf_evsel *evsel,
+static void hcall_event_get_key(struct evsel *evsel,
 				struct perf_sample *sample,
 				struct event_key *key)
 {
@@ -55,14 +55,14 @@ static const char *get_hcall_exit_reason(u64 exit_code)
 	return "UNKNOWN";
 }
 
-static bool hcall_event_end(struct perf_evsel *evsel,
+static bool hcall_event_end(struct evsel *evsel,
 			    struct perf_sample *sample __maybe_unused,
 			    struct event_key *key __maybe_unused)
 {
 	return (!strcmp(evsel->name, kvm_events_tp[3]));
 }
 
-static bool hcall_event_begin(struct perf_evsel *evsel,
+static bool hcall_event_begin(struct evsel *evsel,
 			      struct perf_sample *sample, struct event_key *key)
 {
 	if (!strcmp(evsel->name, kvm_events_tp[2])) {
diff --git a/tools/perf/arch/s390/util/auxtrace.c b/tools/perf/arch/s390/util/auxtrace.c
index 0fe1be93f375..aec819b945c5 100644
--- a/tools/perf/arch/s390/util/auxtrace.c
+++ b/tools/perf/arch/s390/util/auxtrace.c
@@ -86,7 +86,7 @@ struct auxtrace_record *auxtrace_record__init(struct perf_evlist *evlist,
 					      int *err)
 {
 	struct auxtrace_record *aux;
-	struct perf_evsel *pos;
+	struct evsel *pos;
 	int diagnose = 0;
 
 	*err = 0;
diff --git a/tools/perf/arch/s390/util/kvm-stat.c b/tools/perf/arch/s390/util/kvm-stat.c
index f852f2a77e0a..dac78441338c 100644
--- a/tools/perf/arch/s390/util/kvm-stat.c
+++ b/tools/perf/arch/s390/util/kvm-stat.c
@@ -23,7 +23,7 @@ const char *kvm_exit_reason = "icptcode";
 const char *kvm_entry_trace = "kvm:kvm_s390_sie_enter";
 const char *kvm_exit_trace = "kvm:kvm_s390_sie_exit";
 
-static void event_icpt_insn_get_key(struct perf_evsel *evsel,
+static void event_icpt_insn_get_key(struct evsel *evsel,
 				    struct perf_sample *sample,
 				    struct event_key *key)
 {
@@ -34,7 +34,7 @@ static void event_icpt_insn_get_key(struct perf_evsel *evsel,
 	key->exit_reasons = sie_icpt_insn_codes;
 }
 
-static void event_sigp_get_key(struct perf_evsel *evsel,
+static void event_sigp_get_key(struct evsel *evsel,
 			       struct perf_sample *sample,
 			       struct event_key *key)
 {
@@ -42,7 +42,7 @@ static void event_sigp_get_key(struct perf_evsel *evsel,
 	key->exit_reasons = sie_sigp_order_codes;
 }
 
-static void event_diag_get_key(struct perf_evsel *evsel,
+static void event_diag_get_key(struct evsel *evsel,
 			       struct perf_sample *sample,
 			       struct event_key *key)
 {
@@ -50,7 +50,7 @@ static void event_diag_get_key(struct perf_evsel *evsel,
 	key->exit_reasons = sie_diagnose_codes;
 }
 
-static void event_icpt_prog_get_key(struct perf_evsel *evsel,
+static void event_icpt_prog_get_key(struct evsel *evsel,
 				    struct perf_sample *sample,
 				    struct event_key *key)
 {
diff --git a/tools/perf/arch/x86/tests/intel-cqm.c b/tools/perf/arch/x86/tests/intel-cqm.c
index 94aa0b673b7f..b88ed71b2e3f 100644
--- a/tools/perf/arch/x86/tests/intel-cqm.c
+++ b/tools/perf/arch/x86/tests/intel-cqm.c
@@ -41,7 +41,7 @@ static pid_t spawn(void)
 int test__intel_cqm_count_nmi_context(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct perf_evlist *evlist = NULL;
-	struct perf_evsel *evsel = NULL;
+	struct evsel *evsel = NULL;
 	struct perf_event_attr pe;
 	int i, fd[2], flag, ret;
 	size_t mmap_len;
diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
index f542b878bdb5..43fc7d426d93 100644
--- a/tools/perf/arch/x86/tests/perf-time-to-tsc.c
+++ b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
@@ -52,7 +52,7 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 	struct perf_thread_map *threads = NULL;
 	struct perf_cpu_map *cpus = NULL;
 	struct perf_evlist *evlist = NULL;
-	struct perf_evsel *evsel = NULL;
+	struct evsel *evsel = NULL;
 	int err = -1, ret, i;
 	const char *comm1, *comm2;
 	struct perf_tsc_conversion tc;
diff --git a/tools/perf/arch/x86/util/auxtrace.c b/tools/perf/arch/x86/util/auxtrace.c
index d711268af330..02f192114448 100644
--- a/tools/perf/arch/x86/util/auxtrace.c
+++ b/tools/perf/arch/x86/util/auxtrace.c
@@ -21,7 +21,7 @@ struct auxtrace_record *auxtrace_record__init_intel(struct perf_evlist *evlist,
 {
 	struct perf_pmu *intel_pt_pmu;
 	struct perf_pmu *intel_bts_pmu;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	bool found_pt = false;
 	bool found_bts = false;
 
diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index da1583d27efd..59685a19c3b9 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -105,7 +105,7 @@ static int intel_bts_recording_options(struct auxtrace_record *itr,
 	struct intel_bts_recording *btsr =
 			container_of(itr, struct intel_bts_recording, itr);
 	struct perf_pmu *intel_bts_pmu = btsr->intel_bts_pmu;
-	struct perf_evsel *evsel, *intel_bts_evsel = NULL;
+	struct evsel *evsel, *intel_bts_evsel = NULL;
 	const struct perf_cpu_map *cpus = evlist->cpus;
 	bool privileged = geteuid() == 0 || perf_event_paranoid() < 0;
 
@@ -220,7 +220,7 @@ static int intel_bts_recording_options(struct auxtrace_record *itr,
 
 	/* Add dummy event to keep tracking */
 	if (opts->full_auxtrace) {
-		struct perf_evsel *tracking_evsel;
+		struct evsel *tracking_evsel;
 		int err;
 
 		err = parse_events(evlist, "dummy:u", NULL);
@@ -313,7 +313,7 @@ static int intel_bts_snapshot_start(struct auxtrace_record *itr)
 {
 	struct intel_bts_recording *btsr =
 			container_of(itr, struct intel_bts_recording, itr);
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	evlist__for_each_entry(btsr->evlist, evsel) {
 		if (evsel->attr.type == btsr->intel_bts_pmu->type)
@@ -326,7 +326,7 @@ static int intel_bts_snapshot_finish(struct auxtrace_record *itr)
 {
 	struct intel_bts_recording *btsr =
 			container_of(itr, struct intel_bts_recording, itr);
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	evlist__for_each_entry(btsr->evlist, evsel) {
 		if (evsel->attr.type == btsr->intel_bts_pmu->type)
@@ -408,7 +408,7 @@ static int intel_bts_read_finish(struct auxtrace_record *itr, int idx)
 {
 	struct intel_bts_recording *btsr =
 			container_of(itr, struct intel_bts_recording, itr);
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	evlist__for_each_entry(btsr->evlist, evsel) {
 		if (evsel->attr.type == btsr->intel_bts_pmu->type)
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 69a23e40abc9..b42df73fd7ff 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -112,7 +112,7 @@ static u64 intel_pt_masked_bits(u64 mask, u64 bits)
 static int intel_pt_read_config(struct perf_pmu *intel_pt_pmu, const char *str,
 				struct perf_evlist *evlist, u64 *res)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	u64 mask;
 
 	*res = 0;
@@ -271,7 +271,7 @@ intel_pt_pmu_default_config(struct perf_pmu *intel_pt_pmu)
 static const char *intel_pt_find_filter(struct perf_evlist *evlist,
 					struct perf_pmu *intel_pt_pmu)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (evsel->attr.type == intel_pt_pmu->type)
@@ -401,7 +401,7 @@ static int intel_pt_info_fill(struct auxtrace_record *itr,
 static int intel_pt_track_switches(struct perf_evlist *evlist)
 {
 	const char *sched_switch = "sched:sched_switch";
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	int err;
 
 	if (!perf_evlist__can_select_event(evlist, sched_switch))
@@ -513,7 +513,7 @@ static int intel_pt_val_config_term(struct perf_pmu *intel_pt_pmu,
 }
 
 static int intel_pt_validate_config(struct perf_pmu *intel_pt_pmu,
-				    struct perf_evsel *evsel)
+				    struct evsel *evsel)
 {
 	int err;
 	char c;
@@ -556,7 +556,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 			container_of(itr, struct intel_pt_recording, itr);
 	struct perf_pmu *intel_pt_pmu = ptr->intel_pt_pmu;
 	bool have_timing_info, need_immediate = false;
-	struct perf_evsel *evsel, *intel_pt_evsel = NULL;
+	struct evsel *evsel, *intel_pt_evsel = NULL;
 	const struct perf_cpu_map *cpus = evlist->cpus;
 	bool privileged = geteuid() == 0 || perf_event_paranoid() < 0;
 	u64 tsc_bit;
@@ -685,7 +685,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 					!target__has_task(&opts->target);
 
 			if (!cpu_wide && perf_can_record_cpu_wide()) {
-				struct perf_evsel *switch_evsel;
+				struct evsel *switch_evsel;
 
 				err = parse_events(evlist, "dummy:u", NULL);
 				if (err)
@@ -743,7 +743,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 
 	/* Add dummy event to keep tracking */
 	if (opts->full_auxtrace) {
-		struct perf_evsel *tracking_evsel;
+		struct evsel *tracking_evsel;
 
 		err = parse_events(evlist, "dummy:u", NULL);
 		if (err)
@@ -784,7 +784,7 @@ static int intel_pt_snapshot_start(struct auxtrace_record *itr)
 {
 	struct intel_pt_recording *ptr =
 			container_of(itr, struct intel_pt_recording, itr);
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	evlist__for_each_entry(ptr->evlist, evsel) {
 		if (evsel->attr.type == ptr->intel_pt_pmu->type)
@@ -797,7 +797,7 @@ static int intel_pt_snapshot_finish(struct auxtrace_record *itr)
 {
 	struct intel_pt_recording *ptr =
 			container_of(itr, struct intel_pt_recording, itr);
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	evlist__for_each_entry(ptr->evlist, evsel) {
 		if (evsel->attr.type == ptr->intel_pt_pmu->type)
@@ -1070,7 +1070,7 @@ static int intel_pt_read_finish(struct auxtrace_record *itr, int idx)
 {
 	struct intel_pt_recording *ptr =
 			container_of(itr, struct intel_pt_recording, itr);
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	evlist__for_each_entry(ptr->evlist, evsel) {
 		if (evsel->attr.type == ptr->intel_pt_pmu->type)
diff --git a/tools/perf/arch/x86/util/kvm-stat.c b/tools/perf/arch/x86/util/kvm-stat.c
index 865a9762f22e..54a3f2373c35 100644
--- a/tools/perf/arch/x86/util/kvm-stat.c
+++ b/tools/perf/arch/x86/util/kvm-stat.c
@@ -27,7 +27,7 @@ const char *kvm_exit_trace = "kvm:kvm_exit";
  * the time of MMIO write: kvm_mmio(KVM_TRACE_MMIO_WRITE...) -> kvm_entry
  * the time of MMIO read: kvm_exit -> kvm_mmio(KVM_TRACE_MMIO_READ...).
  */
-static void mmio_event_get_key(struct perf_evsel *evsel, struct perf_sample *sample,
+static void mmio_event_get_key(struct evsel *evsel, struct perf_sample *sample,
 			       struct event_key *key)
 {
 	key->key  = perf_evsel__intval(evsel, sample, "gpa");
@@ -38,7 +38,7 @@ static void mmio_event_get_key(struct perf_evsel *evsel, struct perf_sample *sam
 #define KVM_TRACE_MMIO_READ 1
 #define KVM_TRACE_MMIO_WRITE 2
 
-static bool mmio_event_begin(struct perf_evsel *evsel,
+static bool mmio_event_begin(struct evsel *evsel,
 			     struct perf_sample *sample, struct event_key *key)
 {
 	/* MMIO read begin event in kernel. */
@@ -55,7 +55,7 @@ static bool mmio_event_begin(struct perf_evsel *evsel,
 	return false;
 }
 
-static bool mmio_event_end(struct perf_evsel *evsel, struct perf_sample *sample,
+static bool mmio_event_end(struct evsel *evsel, struct perf_sample *sample,
 			   struct event_key *key)
 {
 	/* MMIO write end event in kernel. */
@@ -89,7 +89,7 @@ static struct kvm_events_ops mmio_events = {
 };
 
  /* The time of emulation pio access is from kvm_pio to kvm_entry. */
-static void ioport_event_get_key(struct perf_evsel *evsel,
+static void ioport_event_get_key(struct evsel *evsel,
 				 struct perf_sample *sample,
 				 struct event_key *key)
 {
@@ -97,7 +97,7 @@ static void ioport_event_get_key(struct perf_evsel *evsel,
 	key->info = perf_evsel__intval(evsel, sample, "rw");
 }
 
-static bool ioport_event_begin(struct perf_evsel *evsel,
+static bool ioport_event_begin(struct evsel *evsel,
 			       struct perf_sample *sample,
 			       struct event_key *key)
 {
@@ -109,7 +109,7 @@ static bool ioport_event_begin(struct perf_evsel *evsel,
 	return false;
 }
 
-static bool ioport_event_end(struct perf_evsel *evsel,
+static bool ioport_event_end(struct evsel *evsel,
 			     struct perf_sample *sample __maybe_unused,
 			     struct event_key *key __maybe_unused)
 {
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index e0aa14faf2b5..9bb637165bf9 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -156,7 +156,7 @@ static int hist_iter__branch_callback(struct hist_entry_iter *iter,
 	struct hist_entry *he = iter->he;
 	struct branch_info *bi;
 	struct perf_sample *sample = iter->sample;
-	struct perf_evsel *evsel = iter->evsel;
+	struct evsel *evsel = iter->evsel;
 	int err;
 
 	bi = he->branch_info;
@@ -171,7 +171,7 @@ static int hist_iter__branch_callback(struct hist_entry_iter *iter,
 	return err;
 }
 
-static int process_branch_callback(struct perf_evsel *evsel,
+static int process_branch_callback(struct evsel *evsel,
 				   struct perf_sample *sample,
 				   struct addr_location *al __maybe_unused,
 				   struct perf_annotate *ann,
@@ -208,7 +208,7 @@ static bool has_annotation(struct perf_annotate *ann)
 	return ui__has_annotation() || ann->use_stdio2;
 }
 
-static int perf_evsel__add_sample(struct perf_evsel *evsel,
+static int perf_evsel__add_sample(struct evsel *evsel,
 				  struct perf_sample *sample,
 				  struct addr_location *al,
 				  struct perf_annotate *ann,
@@ -257,7 +257,7 @@ static int perf_evsel__add_sample(struct perf_evsel *evsel,
 static int process_sample_event(struct perf_tool *tool,
 				union perf_event *event,
 				struct perf_sample *sample,
-				struct perf_evsel *evsel,
+				struct evsel *evsel,
 				struct machine *machine)
 {
 	struct perf_annotate *ann = container_of(tool, struct perf_annotate, tool);
@@ -293,7 +293,7 @@ static int process_feature_event(struct perf_session *session,
 }
 
 static int hist_entry__tty_annotate(struct hist_entry *he,
-				    struct perf_evsel *evsel,
+				    struct evsel *evsel,
 				    struct perf_annotate *ann)
 {
 	if (!ann->use_stdio2)
@@ -303,7 +303,7 @@ static int hist_entry__tty_annotate(struct hist_entry *he,
 }
 
 static void hists__find_annotations(struct hists *hists,
-				    struct perf_evsel *evsel,
+				    struct evsel *evsel,
 				    struct perf_annotate *ann)
 {
 	struct rb_node *nd = rb_first_cached(&hists->entries), *next;
@@ -333,7 +333,7 @@ static void hists__find_annotations(struct hists *hists,
 		if (use_browser == 2) {
 			int ret;
 			int (*annotate)(struct hist_entry *he,
-					struct perf_evsel *evsel,
+					struct evsel *evsel,
 					struct hist_browser_timer *hbt);
 
 			annotate = dlsym(perf_gtk_handle,
@@ -387,7 +387,7 @@ static int __cmd_annotate(struct perf_annotate *ann)
 {
 	int ret;
 	struct perf_session *session = ann->session;
-	struct perf_evsel *pos;
+	struct evsel *pos;
 	u64 total_nr_samples;
 
 	if (ann->cpu_list) {
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 52035dacf253..d251a486f329 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -248,7 +248,7 @@ static void compute_stats(struct c2c_hist_entry *c2c_he,
 static int process_sample_event(struct perf_tool *tool __maybe_unused,
 				union perf_event *event,
 				struct perf_sample *sample,
-				struct perf_evsel *evsel,
+				struct evsel *evsel,
 				struct machine *machine)
 {
 	struct c2c_hists *c2c_hists = &c2c.hists;
@@ -2237,7 +2237,7 @@ static void print_pareto(FILE *out)
 static void print_c2c_info(FILE *out, struct perf_session *session)
 {
 	struct perf_evlist *evlist = session->evlist;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	bool first = true;
 
 	fprintf(out, "=================================================\n");
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index f6f5dd15bea7..c3b4b8196e00 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -376,7 +376,7 @@ struct hist_entry_ops block_hist_ops = {
 static int diff__process_sample_event(struct perf_tool *tool,
 				      union perf_event *event,
 				      struct perf_sample *sample,
-				      struct perf_evsel *evsel,
+				      struct evsel *evsel,
 				      struct machine *machine)
 {
 	struct perf_diff *pdiff = container_of(tool, struct perf_diff, tool);
@@ -448,10 +448,10 @@ static struct perf_diff pdiff = {
 	},
 };
 
-static struct perf_evsel *evsel_match(struct perf_evsel *evsel,
+static struct evsel *evsel_match(struct evsel *evsel,
 				      struct perf_evlist *evlist)
 {
-	struct perf_evsel *e;
+	struct evsel *e;
 
 	evlist__for_each_entry(evlist, e) {
 		if (perf_evsel__match2(evsel, e))
@@ -463,7 +463,7 @@ static struct perf_evsel *evsel_match(struct perf_evsel *evsel,
 
 static void perf_evlist__collapse_resort(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel) {
 		struct hists *hists = evsel__hists(evsel);
@@ -1010,7 +1010,7 @@ static void data__fprintf(void)
 static void data_process(void)
 {
 	struct perf_evlist *evlist_base = data__files[0].session->evlist;
-	struct perf_evsel *evsel_base;
+	struct evsel *evsel_base;
 	bool first = true;
 
 	evlist__for_each_entry(evlist_base, evsel_base) {
@@ -1020,7 +1020,7 @@ static void data_process(void)
 
 		data__for_each_file_new(i, d) {
 			struct perf_evlist *evlist = d->session->evlist;
-			struct perf_evsel *evsel;
+			struct evsel *evsel;
 			struct hists *hists;
 
 			evsel = evsel_match(evsel_base, evlist);
diff --git a/tools/perf/builtin-evlist.c b/tools/perf/builtin-evlist.c
index 6e4f63b0da4a..e4cb61dc6315 100644
--- a/tools/perf/builtin-evlist.c
+++ b/tools/perf/builtin-evlist.c
@@ -21,7 +21,7 @@
 static int __cmd_evlist(const char *file_name, struct perf_attr_details *details)
 {
 	struct perf_session *session;
-	struct perf_evsel *pos;
+	struct evsel *pos;
 	struct perf_data data = {
 		.path      = file_name,
 		.mode      = PERF_DATA_MODE_READ,
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index f4591a1438b4..646a1bf790fc 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -215,13 +215,13 @@ static int perf_event__drop_aux(struct perf_tool *tool,
 typedef int (*inject_handler)(struct perf_tool *tool,
 			      union perf_event *event,
 			      struct perf_sample *sample,
-			      struct perf_evsel *evsel,
+			      struct evsel *evsel,
 			      struct machine *machine);
 
 static int perf_event__repipe_sample(struct perf_tool *tool,
 				     union perf_event *event,
 				     struct perf_sample *sample,
-				     struct perf_evsel *evsel,
+				     struct evsel *evsel,
 				     struct machine *machine)
 {
 	if (evsel && evsel->handler) {
@@ -424,7 +424,7 @@ static int dso__inject_build_id(struct dso *dso, struct perf_tool *tool,
 static int perf_event__inject_buildid(struct perf_tool *tool,
 				      union perf_event *event,
 				      struct perf_sample *sample,
-				      struct perf_evsel *evsel __maybe_unused,
+				      struct evsel *evsel __maybe_unused,
 				      struct machine *machine)
 {
 	struct addr_location al;
@@ -465,7 +465,7 @@ static int perf_event__inject_buildid(struct perf_tool *tool,
 static int perf_inject__sched_process_exit(struct perf_tool *tool,
 					   union perf_event *event __maybe_unused,
 					   struct perf_sample *sample,
-					   struct perf_evsel *evsel __maybe_unused,
+					   struct evsel *evsel __maybe_unused,
 					   struct machine *machine __maybe_unused)
 {
 	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
@@ -485,7 +485,7 @@ static int perf_inject__sched_process_exit(struct perf_tool *tool,
 static int perf_inject__sched_switch(struct perf_tool *tool,
 				     union perf_event *event,
 				     struct perf_sample *sample,
-				     struct perf_evsel *evsel,
+				     struct evsel *evsel,
 				     struct machine *machine)
 {
 	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
@@ -509,7 +509,7 @@ static int perf_inject__sched_switch(struct perf_tool *tool,
 static int perf_inject__sched_stat(struct perf_tool *tool,
 				   union perf_event *event __maybe_unused,
 				   struct perf_sample *sample,
-				   struct perf_evsel *evsel,
+				   struct evsel *evsel,
 				   struct machine *machine)
 {
 	struct event_entry *ent;
@@ -541,7 +541,7 @@ static void sig_handler(int sig __maybe_unused)
 	session_done = 1;
 }
 
-static int perf_evsel__check_stype(struct perf_evsel *evsel,
+static int perf_evsel__check_stype(struct evsel *evsel,
 				   u64 sample_type, const char *sample_msg)
 {
 	struct perf_event_attr *attr = &evsel->attr;
@@ -559,7 +559,7 @@ static int perf_evsel__check_stype(struct perf_evsel *evsel,
 static int drop_sample(struct perf_tool *tool __maybe_unused,
 		       union perf_event *event __maybe_unused,
 		       struct perf_sample *sample __maybe_unused,
-		       struct perf_evsel *evsel __maybe_unused,
+		       struct evsel *evsel __maybe_unused,
 		       struct machine *machine __maybe_unused)
 {
 	return 0;
@@ -568,7 +568,7 @@ static int drop_sample(struct perf_tool *tool __maybe_unused,
 static void strip_init(struct perf_inject *inject)
 {
 	struct perf_evlist *evlist = inject->session->evlist;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	inject->tool.context_switch = perf_event__drop;
 
@@ -576,7 +576,7 @@ static void strip_init(struct perf_inject *inject)
 		evsel->handler = drop_sample;
 }
 
-static bool has_tracking(struct perf_evsel *evsel)
+static bool has_tracking(struct evsel *evsel)
 {
 	return evsel->attr.mmap || evsel->attr.mmap2 || evsel->attr.comm ||
 	       evsel->attr.task;
@@ -591,9 +591,9 @@ static bool has_tracking(struct perf_evsel *evsel)
  * and it has a compatible sample type.
  */
 static bool ok_to_remove(struct perf_evlist *evlist,
-			 struct perf_evsel *evsel_to_remove)
+			 struct evsel *evsel_to_remove)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	int cnt = 0;
 	bool ok = false;
 
@@ -615,7 +615,7 @@ static bool ok_to_remove(struct perf_evlist *evlist,
 static void strip_fini(struct perf_inject *inject)
 {
 	struct perf_evlist *evlist = inject->session->evlist;
-	struct perf_evsel *evsel, *tmp;
+	struct evsel *evsel, *tmp;
 
 	/* Remove non-synthesized evsels if possible */
 	evlist__for_each_entry_safe(evlist, tmp, evsel) {
@@ -651,7 +651,7 @@ static int __cmd_inject(struct perf_inject *inject)
 	if (inject->build_ids) {
 		inject->tool.sample = perf_event__inject_buildid;
 	} else if (inject->sched_stat) {
-		struct perf_evsel *evsel;
+		struct evsel *evsel;
 
 		evlist__for_each_entry(session->evlist, evsel) {
 			const char *name = perf_evsel__name(evsel);
@@ -712,7 +712,7 @@ static int __cmd_inject(struct perf_inject *inject)
 		 * remove the evsel.
 		 */
 		if (inject->itrace_synth_opts.set) {
-			struct perf_evsel *evsel;
+			struct evsel *evsel;
 
 			perf_header__clear_feat(&session->header,
 						HEADER_AUXTRACE);
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 9e5e60898083..46f828936120 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -166,7 +166,7 @@ static int insert_caller_stat(unsigned long call_site,
 	return 0;
 }
 
-static int perf_evsel__process_alloc_event(struct perf_evsel *evsel,
+static int perf_evsel__process_alloc_event(struct evsel *evsel,
 					   struct perf_sample *sample)
 {
 	unsigned long ptr = perf_evsel__intval(evsel, sample, "ptr"),
@@ -185,7 +185,7 @@ static int perf_evsel__process_alloc_event(struct perf_evsel *evsel,
 	return 0;
 }
 
-static int perf_evsel__process_alloc_node_event(struct perf_evsel *evsel,
+static int perf_evsel__process_alloc_node_event(struct evsel *evsel,
 						struct perf_sample *sample)
 {
 	int ret = perf_evsel__process_alloc_event(evsel, sample);
@@ -229,7 +229,7 @@ static struct alloc_stat *search_alloc_stat(unsigned long ptr,
 	return NULL;
 }
 
-static int perf_evsel__process_free_event(struct perf_evsel *evsel,
+static int perf_evsel__process_free_event(struct evsel *evsel,
 					  struct perf_sample *sample)
 {
 	unsigned long ptr = perf_evsel__intval(evsel, sample, "ptr");
@@ -381,7 +381,7 @@ static int build_alloc_func_list(void)
  * Find first non-memory allocation function from callchain.
  * The allocation functions are in the 'alloc_func_list'.
  */
-static u64 find_callsite(struct perf_evsel *evsel, struct perf_sample *sample)
+static u64 find_callsite(struct evsel *evsel, struct perf_sample *sample)
 {
 	struct addr_location al;
 	struct machine *machine = &kmem_session->machines.host;
@@ -728,7 +728,7 @@ static char *compact_gfp_string(unsigned long gfp_flags)
 	return NULL;
 }
 
-static int parse_gfp_flags(struct perf_evsel *evsel, struct perf_sample *sample,
+static int parse_gfp_flags(struct evsel *evsel, struct perf_sample *sample,
 			   unsigned int gfp_flags)
 {
 	struct tep_record record = {
@@ -779,7 +779,7 @@ static int parse_gfp_flags(struct perf_evsel *evsel, struct perf_sample *sample,
 	return 0;
 }
 
-static int perf_evsel__process_page_alloc_event(struct perf_evsel *evsel,
+static int perf_evsel__process_page_alloc_event(struct evsel *evsel,
 						struct perf_sample *sample)
 {
 	u64 page;
@@ -852,7 +852,7 @@ static int perf_evsel__process_page_alloc_event(struct perf_evsel *evsel,
 	return 0;
 }
 
-static int perf_evsel__process_page_free_event(struct perf_evsel *evsel,
+static int perf_evsel__process_page_free_event(struct evsel *evsel,
 						struct perf_sample *sample)
 {
 	u64 page;
@@ -930,13 +930,13 @@ static bool perf_kmem__skip_sample(struct perf_sample *sample)
 	return false;
 }
 
-typedef int (*tracepoint_handler)(struct perf_evsel *evsel,
+typedef int (*tracepoint_handler)(struct evsel *evsel,
 				  struct perf_sample *sample);
 
 static int process_sample_event(struct perf_tool *tool __maybe_unused,
 				union perf_event *event,
 				struct perf_sample *sample,
-				struct perf_evsel *evsel,
+				struct evsel *evsel,
 				struct machine *machine)
 {
 	int err = 0;
@@ -1363,8 +1363,8 @@ static void sort_result(void)
 static int __cmd_kmem(struct perf_session *session)
 {
 	int err = -EINVAL;
-	struct perf_evsel *evsel;
-	const struct perf_evsel_str_handler kmem_tracepoints[] = {
+	struct evsel *evsel;
+	const struct evsel_str_handler kmem_tracepoints[] = {
 		/* slab allocator */
 		{ "kmem:kmalloc",		perf_evsel__process_alloc_event, },
     		{ "kmem:kmem_cache_alloc",	perf_evsel__process_alloc_event, },
@@ -1967,7 +1967,7 @@ int cmd_kmem(int argc, const char **argv)
 	}
 
 	if (kmem_page) {
-		struct perf_evsel *evsel;
+		struct evsel *evsel;
 
 		evsel = perf_evlist__find_tracepoint_by_name(session->evlist,
 							     "kmem:mm_page_alloc");
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index b33c83489120..cf8f27d05296 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -57,7 +57,7 @@ static const char *get_filename_for_perf_kvm(void)
 #ifdef HAVE_KVM_STAT_SUPPORT
 #include "util/kvm-stat.h"
 
-void exit_event_get_key(struct perf_evsel *evsel,
+void exit_event_get_key(struct evsel *evsel,
 			struct perf_sample *sample,
 			struct event_key *key)
 {
@@ -65,12 +65,12 @@ void exit_event_get_key(struct perf_evsel *evsel,
 	key->key = perf_evsel__intval(evsel, sample, kvm_exit_reason);
 }
 
-bool kvm_exit_event(struct perf_evsel *evsel)
+bool kvm_exit_event(struct evsel *evsel)
 {
 	return !strcmp(evsel->name, kvm_exit_trace);
 }
 
-bool exit_event_begin(struct perf_evsel *evsel,
+bool exit_event_begin(struct evsel *evsel,
 		      struct perf_sample *sample, struct event_key *key)
 {
 	if (kvm_exit_event(evsel)) {
@@ -81,12 +81,12 @@ bool exit_event_begin(struct perf_evsel *evsel,
 	return false;
 }
 
-bool kvm_entry_event(struct perf_evsel *evsel)
+bool kvm_entry_event(struct evsel *evsel)
 {
 	return !strcmp(evsel->name, kvm_entry_trace);
 }
 
-bool exit_event_end(struct perf_evsel *evsel,
+bool exit_event_end(struct evsel *evsel,
 		    struct perf_sample *sample __maybe_unused,
 		    struct event_key *key __maybe_unused)
 {
@@ -286,7 +286,7 @@ static bool update_kvm_event(struct kvm_event *event, int vcpu_id,
 }
 
 static bool is_child_event(struct perf_kvm_stat *kvm,
-			   struct perf_evsel *evsel,
+			   struct evsel *evsel,
 			   struct perf_sample *sample,
 			   struct event_key *key)
 {
@@ -396,7 +396,7 @@ static bool handle_end_event(struct perf_kvm_stat *kvm,
 
 static
 struct vcpu_event_record *per_vcpu_record(struct thread *thread,
-					  struct perf_evsel *evsel,
+					  struct evsel *evsel,
 					  struct perf_sample *sample)
 {
 	/* Only kvm_entry records vcpu id. */
@@ -419,7 +419,7 @@ struct vcpu_event_record *per_vcpu_record(struct thread *thread,
 
 static bool handle_kvm_event(struct perf_kvm_stat *kvm,
 			     struct thread *thread,
-			     struct perf_evsel *evsel,
+			     struct evsel *evsel,
 			     struct perf_sample *sample)
 {
 	struct vcpu_event_record *vcpu_record;
@@ -672,7 +672,7 @@ static bool skip_sample(struct perf_kvm_stat *kvm,
 static int process_sample_event(struct perf_tool *tool,
 				union perf_event *event,
 				struct perf_sample *sample,
-				struct perf_evsel *evsel,
+				struct evsel *evsel,
 				struct machine *machine)
 {
 	int err = 0;
@@ -1011,7 +1011,7 @@ static int kvm_events_live_report(struct perf_kvm_stat *kvm)
 static int kvm_live_open_events(struct perf_kvm_stat *kvm)
 {
 	int err, rc = -1;
-	struct perf_evsel *pos;
+	struct evsel *pos;
 	struct perf_evlist *evlist = kvm->evlist;
 	char sbuf[STRERR_BUFSIZE];
 
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 574e30ec6d7c..38500bff4423 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -347,16 +347,16 @@ static struct lock_stat *lock_stat_findnew(void *addr, const char *name)
 }
 
 struct trace_lock_handler {
-	int (*acquire_event)(struct perf_evsel *evsel,
+	int (*acquire_event)(struct evsel *evsel,
 			     struct perf_sample *sample);
 
-	int (*acquired_event)(struct perf_evsel *evsel,
+	int (*acquired_event)(struct evsel *evsel,
 			      struct perf_sample *sample);
 
-	int (*contended_event)(struct perf_evsel *evsel,
+	int (*contended_event)(struct evsel *evsel,
 			       struct perf_sample *sample);
 
-	int (*release_event)(struct perf_evsel *evsel,
+	int (*release_event)(struct evsel *evsel,
 			     struct perf_sample *sample);
 };
 
@@ -396,7 +396,7 @@ enum acquire_flags {
 	READ_LOCK = 2,
 };
 
-static int report_lock_acquire_event(struct perf_evsel *evsel,
+static int report_lock_acquire_event(struct evsel *evsel,
 				     struct perf_sample *sample)
 {
 	void *addr;
@@ -468,7 +468,7 @@ static int report_lock_acquire_event(struct perf_evsel *evsel,
 	return 0;
 }
 
-static int report_lock_acquired_event(struct perf_evsel *evsel,
+static int report_lock_acquired_event(struct evsel *evsel,
 				      struct perf_sample *sample)
 {
 	void *addr;
@@ -531,7 +531,7 @@ static int report_lock_acquired_event(struct perf_evsel *evsel,
 	return 0;
 }
 
-static int report_lock_contended_event(struct perf_evsel *evsel,
+static int report_lock_contended_event(struct evsel *evsel,
 				       struct perf_sample *sample)
 {
 	void *addr;
@@ -586,7 +586,7 @@ static int report_lock_contended_event(struct perf_evsel *evsel,
 	return 0;
 }
 
-static int report_lock_release_event(struct perf_evsel *evsel,
+static int report_lock_release_event(struct evsel *evsel,
 				     struct perf_sample *sample)
 {
 	void *addr;
@@ -656,7 +656,7 @@ static struct trace_lock_handler report_lock_ops  = {
 
 static struct trace_lock_handler *trace_handler;
 
-static int perf_evsel__process_lock_acquire(struct perf_evsel *evsel,
+static int perf_evsel__process_lock_acquire(struct evsel *evsel,
 					     struct perf_sample *sample)
 {
 	if (trace_handler->acquire_event)
@@ -664,7 +664,7 @@ static int perf_evsel__process_lock_acquire(struct perf_evsel *evsel,
 	return 0;
 }
 
-static int perf_evsel__process_lock_acquired(struct perf_evsel *evsel,
+static int perf_evsel__process_lock_acquired(struct evsel *evsel,
 					      struct perf_sample *sample)
 {
 	if (trace_handler->acquired_event)
@@ -672,7 +672,7 @@ static int perf_evsel__process_lock_acquired(struct perf_evsel *evsel,
 	return 0;
 }
 
-static int perf_evsel__process_lock_contended(struct perf_evsel *evsel,
+static int perf_evsel__process_lock_contended(struct evsel *evsel,
 					      struct perf_sample *sample)
 {
 	if (trace_handler->contended_event)
@@ -680,7 +680,7 @@ static int perf_evsel__process_lock_contended(struct perf_evsel *evsel,
 	return 0;
 }
 
-static int perf_evsel__process_lock_release(struct perf_evsel *evsel,
+static int perf_evsel__process_lock_release(struct evsel *evsel,
 					    struct perf_sample *sample)
 {
 	if (trace_handler->release_event)
@@ -806,13 +806,13 @@ static int dump_info(void)
 	return rc;
 }
 
-typedef int (*tracepoint_handler)(struct perf_evsel *evsel,
+typedef int (*tracepoint_handler)(struct evsel *evsel,
 				  struct perf_sample *sample);
 
 static int process_sample_event(struct perf_tool *tool __maybe_unused,
 				union perf_event *event,
 				struct perf_sample *sample,
-				struct perf_evsel *evsel,
+				struct evsel *evsel,
 				struct machine *machine)
 {
 	int err = 0;
@@ -847,7 +847,7 @@ static void sort_result(void)
 	}
 }
 
-static const struct perf_evsel_str_handler lock_tracepoints[] = {
+static const struct evsel_str_handler lock_tracepoints[] = {
 	{ "lock:lock_acquire",	 perf_evsel__process_lock_acquire,   }, /* CONFIG_LOCKDEP */
 	{ "lock:lock_acquired",	 perf_evsel__process_lock_acquired,  }, /* CONFIG_LOCKDEP, CONFIG_LOCK_STAT */
 	{ "lock:lock_contended", perf_evsel__process_lock_contended, }, /* CONFIG_LOCKDEP, CONFIG_LOCK_STAT */
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index f45c8b502f63..9e60eda9297d 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -230,7 +230,7 @@ dump_raw_samples(struct perf_tool *tool,
 static int process_sample_event(struct perf_tool *tool,
 				union perf_event *event,
 				struct perf_sample *sample,
-				struct perf_evsel *evsel __maybe_unused,
+				struct evsel *evsel __maybe_unused,
 				struct machine *machine)
 {
 	return dump_raw_samples(tool, event, sample, machine);
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index bcfc16450608..7ba3a2c32e54 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -713,7 +713,7 @@ static int record__mmap(struct record *rec)
 static int record__open(struct record *rec)
 {
 	char msg[BUFSIZ];
-	struct perf_evsel *pos;
+	struct evsel *pos;
 	struct perf_evlist *evlist = rec->evlist;
 	struct perf_session *session = rec->session;
 	struct record_opts *opts = &rec->opts;
@@ -782,7 +782,7 @@ static int record__open(struct record *rec)
 static int process_sample_event(struct perf_tool *tool,
 				union perf_event *event,
 				struct perf_sample *sample,
-				struct perf_evsel *evsel,
+				struct evsel *evsel,
 				struct machine *machine)
 {
 	struct record *rec = container_of(tool, struct record, tool);
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index abf0b9b8f566..96a506f0d4c1 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -128,7 +128,7 @@ static int hist_iter__report_callback(struct hist_entry_iter *iter,
 	int err = 0;
 	struct report *rep = arg;
 	struct hist_entry *he = iter->he;
-	struct perf_evsel *evsel = iter->evsel;
+	struct evsel *evsel = iter->evsel;
 	struct perf_sample *sample = iter->sample;
 	struct mem_info *mi;
 	struct branch_info *bi;
@@ -172,7 +172,7 @@ static int hist_iter__branch_callback(struct hist_entry_iter *iter,
 	struct report *rep = arg;
 	struct branch_info *bi;
 	struct perf_sample *sample = iter->sample;
-	struct perf_evsel *evsel = iter->evsel;
+	struct evsel *evsel = iter->evsel;
 	int err;
 
 	if (!ui__has_annotation() && !rep->symbol_ipc)
@@ -225,7 +225,7 @@ static int process_feature_event(struct perf_session *session,
 static int process_sample_event(struct perf_tool *tool,
 				union perf_event *event,
 				struct perf_sample *sample,
-				struct perf_evsel *evsel,
+				struct evsel *evsel,
 				struct machine *machine)
 {
 	struct report *rep = container_of(tool, struct report, tool);
@@ -292,7 +292,7 @@ static int process_sample_event(struct perf_tool *tool,
 static int process_read_event(struct perf_tool *tool,
 			      union perf_event *event,
 			      struct perf_sample *sample __maybe_unused,
-			      struct perf_evsel *evsel,
+			      struct evsel *evsel,
 			      struct machine *machine __maybe_unused)
 {
 	struct report *rep = container_of(tool, struct report, tool);
@@ -400,7 +400,7 @@ static size_t hists__fprintf_nr_sample_events(struct hists *hists, struct report
 	char unit;
 	unsigned long nr_samples = hists->stats.nr_events[PERF_RECORD_SAMPLE];
 	u64 nr_events = hists->stats.total_period;
-	struct perf_evsel *evsel = hists_to_evsel(hists);
+	struct evsel *evsel = hists_to_evsel(hists);
 	char buf[512];
 	size_t size = sizeof(buf);
 	int socked_id = hists->socket_filter;
@@ -414,7 +414,7 @@ static size_t hists__fprintf_nr_sample_events(struct hists *hists, struct report
 	}
 
 	if (perf_evsel__is_group_event(evsel)) {
-		struct perf_evsel *pos;
+		struct evsel *pos;
 
 		perf_evsel__group_desc(evsel, buf, size);
 		evname = buf;
@@ -463,7 +463,7 @@ static int perf_evlist__tty_browse_hists(struct perf_evlist *evlist,
 					 struct report *rep,
 					 const char *help)
 {
-	struct perf_evsel *pos;
+	struct evsel *pos;
 
 	if (!quiet) {
 		fprintf(stdout, "#\n# Total Lost Samples: %" PRIu64 "\n#\n",
@@ -586,7 +586,7 @@ static int report__browse_hists(struct report *rep)
 static int report__collapse_hists(struct report *rep)
 {
 	struct ui_progress prog;
-	struct perf_evsel *pos;
+	struct evsel *pos;
 	int ret = 0;
 
 	ui_progress__init(&prog, rep->nr_entries, "Merging related events...");
@@ -623,7 +623,7 @@ static int hists__resort_cb(struct hist_entry *he, void *arg)
 	struct symbol *sym = he->ms.sym;
 
 	if (rep->symbol_ipc && sym && !sym->annotate2) {
-		struct perf_evsel *evsel = hists_to_evsel(he->hists);
+		struct evsel *evsel = hists_to_evsel(he->hists);
 
 		symbol__annotate2(sym, he->ms.map, evsel,
 				  &annotation__default_options, NULL);
@@ -635,7 +635,7 @@ static int hists__resort_cb(struct hist_entry *he, void *arg)
 static void report__output_resort(struct report *rep)
 {
 	struct ui_progress prog;
-	struct perf_evsel *pos;
+	struct evsel *pos;
 
 	ui_progress__init(&prog, rep->nr_entries, "Sorting events for output...");
 
@@ -818,7 +818,7 @@ static int __cmd_report(struct report *rep)
 {
 	int ret;
 	struct perf_session *session = rep->session;
-	struct perf_evsel *pos;
+	struct evsel *pos;
 	struct perf_data *data = session->data;
 
 	signal(SIGINT, sig_handler);
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index ac6a0c5d6d6b..55779f496d27 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -133,13 +133,13 @@ typedef int (*sort_fn_t)(struct work_atoms *, struct work_atoms *);
 struct perf_sched;
 
 struct trace_sched_handler {
-	int (*switch_event)(struct perf_sched *sched, struct perf_evsel *evsel,
+	int (*switch_event)(struct perf_sched *sched, struct evsel *evsel,
 			    struct perf_sample *sample, struct machine *machine);
 
-	int (*runtime_event)(struct perf_sched *sched, struct perf_evsel *evsel,
+	int (*runtime_event)(struct perf_sched *sched, struct evsel *evsel,
 			     struct perf_sample *sample, struct machine *machine);
 
-	int (*wakeup_event)(struct perf_sched *sched, struct perf_evsel *evsel,
+	int (*wakeup_event)(struct perf_sched *sched, struct evsel *evsel,
 			    struct perf_sample *sample, struct machine *machine);
 
 	/* PERF_RECORD_FORK event, not sched_process_fork tracepoint */
@@ -147,7 +147,7 @@ struct trace_sched_handler {
 			  struct machine *machine);
 
 	int (*migrate_task_event)(struct perf_sched *sched,
-				  struct perf_evsel *evsel,
+				  struct evsel *evsel,
 				  struct perf_sample *sample,
 				  struct machine *machine);
 };
@@ -799,7 +799,7 @@ static void test_calibrations(struct perf_sched *sched)
 
 static int
 replay_wakeup_event(struct perf_sched *sched,
-		    struct perf_evsel *evsel, struct perf_sample *sample,
+		    struct evsel *evsel, struct perf_sample *sample,
 		    struct machine *machine __maybe_unused)
 {
 	const char *comm = perf_evsel__strval(evsel, sample, "comm");
@@ -820,7 +820,7 @@ replay_wakeup_event(struct perf_sched *sched,
 }
 
 static int replay_switch_event(struct perf_sched *sched,
-			       struct perf_evsel *evsel,
+			       struct evsel *evsel,
 			       struct perf_sample *sample,
 			       struct machine *machine __maybe_unused)
 {
@@ -1093,7 +1093,7 @@ add_sched_in_event(struct work_atoms *atoms, u64 timestamp)
 }
 
 static int latency_switch_event(struct perf_sched *sched,
-				struct perf_evsel *evsel,
+				struct evsel *evsel,
 				struct perf_sample *sample,
 				struct machine *machine)
 {
@@ -1163,7 +1163,7 @@ static int latency_switch_event(struct perf_sched *sched,
 }
 
 static int latency_runtime_event(struct perf_sched *sched,
-				 struct perf_evsel *evsel,
+				 struct evsel *evsel,
 				 struct perf_sample *sample,
 				 struct machine *machine)
 {
@@ -1198,7 +1198,7 @@ static int latency_runtime_event(struct perf_sched *sched,
 }
 
 static int latency_wakeup_event(struct perf_sched *sched,
-				struct perf_evsel *evsel,
+				struct evsel *evsel,
 				struct perf_sample *sample,
 				struct machine *machine)
 {
@@ -1259,7 +1259,7 @@ static int latency_wakeup_event(struct perf_sched *sched,
 }
 
 static int latency_migrate_task_event(struct perf_sched *sched,
-				      struct perf_evsel *evsel,
+				      struct evsel *evsel,
 				      struct perf_sample *sample,
 				      struct machine *machine)
 {
@@ -1470,7 +1470,7 @@ static void perf_sched__sort_lat(struct perf_sched *sched)
 }
 
 static int process_sched_wakeup_event(struct perf_tool *tool,
-				      struct perf_evsel *evsel,
+				      struct evsel *evsel,
 				      struct perf_sample *sample,
 				      struct machine *machine)
 {
@@ -1514,7 +1514,7 @@ map__findnew_thread(struct perf_sched *sched, struct machine *machine, pid_t pid
 	return thread;
 }
 
-static int map_switch_event(struct perf_sched *sched, struct perf_evsel *evsel,
+static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 			    struct perf_sample *sample, struct machine *machine)
 {
 	const u32 next_pid = perf_evsel__intval(evsel, sample, "next_pid");
@@ -1655,7 +1655,7 @@ static int map_switch_event(struct perf_sched *sched, struct perf_evsel *evsel,
 }
 
 static int process_sched_switch_event(struct perf_tool *tool,
-				      struct perf_evsel *evsel,
+				      struct evsel *evsel,
 				      struct perf_sample *sample,
 				      struct machine *machine)
 {
@@ -1681,7 +1681,7 @@ static int process_sched_switch_event(struct perf_tool *tool,
 }
 
 static int process_sched_runtime_event(struct perf_tool *tool,
-				       struct perf_evsel *evsel,
+				       struct evsel *evsel,
 				       struct perf_sample *sample,
 				       struct machine *machine)
 {
@@ -1711,7 +1711,7 @@ static int perf_sched__process_fork_event(struct perf_tool *tool,
 }
 
 static int process_sched_migrate_task_event(struct perf_tool *tool,
-					    struct perf_evsel *evsel,
+					    struct evsel *evsel,
 					    struct perf_sample *sample,
 					    struct machine *machine)
 {
@@ -1724,14 +1724,14 @@ static int process_sched_migrate_task_event(struct perf_tool *tool,
 }
 
 typedef int (*tracepoint_handler)(struct perf_tool *tool,
-				  struct perf_evsel *evsel,
+				  struct evsel *evsel,
 				  struct perf_sample *sample,
 				  struct machine *machine);
 
 static int perf_sched__process_tracepoint_sample(struct perf_tool *tool __maybe_unused,
 						 union perf_event *event __maybe_unused,
 						 struct perf_sample *sample,
-						 struct perf_evsel *evsel,
+						 struct evsel *evsel,
 						 struct machine *machine)
 {
 	int err = 0;
@@ -1777,7 +1777,7 @@ static int perf_sched__process_comm(struct perf_tool *tool __maybe_unused,
 
 static int perf_sched__read_events(struct perf_sched *sched)
 {
-	const struct perf_evsel_str_handler handlers[] = {
+	const struct evsel_str_handler handlers[] = {
 		{ "sched:sched_switch",	      process_sched_switch_event, },
 		{ "sched:sched_stat_runtime", process_sched_runtime_event, },
 		{ "sched:sched_wakeup",	      process_sched_wakeup_event, },
@@ -1839,7 +1839,7 @@ static inline void print_sched_time(unsigned long long nsecs, int width)
  * returns runtime data for event, allocating memory for it the
  * first time it is used.
  */
-static struct evsel_runtime *perf_evsel__get_runtime(struct perf_evsel *evsel)
+static struct evsel_runtime *perf_evsel__get_runtime(struct evsel *evsel)
 {
 	struct evsel_runtime *r = evsel->priv;
 
@@ -1854,7 +1854,7 @@ static struct evsel_runtime *perf_evsel__get_runtime(struct perf_evsel *evsel)
 /*
  * save last time event was seen per cpu
  */
-static void perf_evsel__save_time(struct perf_evsel *evsel,
+static void perf_evsel__save_time(struct evsel *evsel,
 				  u64 timestamp, u32 cpu)
 {
 	struct evsel_runtime *r = perf_evsel__get_runtime(evsel);
@@ -1881,7 +1881,7 @@ static void perf_evsel__save_time(struct perf_evsel *evsel,
 }
 
 /* returns last time this event was seen on the given cpu */
-static u64 perf_evsel__get_time(struct perf_evsel *evsel, u32 cpu)
+static u64 perf_evsel__get_time(struct evsel *evsel, u32 cpu)
 {
 	struct evsel_runtime *r = perf_evsel__get_runtime(evsel);
 
@@ -1988,7 +1988,7 @@ static char task_state_char(struct thread *thread, int state)
 }
 
 static void timehist_print_sample(struct perf_sched *sched,
-				  struct perf_evsel *evsel,
+				  struct evsel *evsel,
 				  struct perf_sample *sample,
 				  struct addr_location *al,
 				  struct thread *thread,
@@ -2121,7 +2121,7 @@ static void timehist_update_runtime_stats(struct thread_runtime *r,
 }
 
 static bool is_idle_sample(struct perf_sample *sample,
-			   struct perf_evsel *evsel)
+			   struct evsel *evsel)
 {
 	/* pid 0 == swapper == idle task */
 	if (strcmp(perf_evsel__name(evsel), "sched:sched_switch") == 0)
@@ -2132,7 +2132,7 @@ static bool is_idle_sample(struct perf_sample *sample,
 
 static void save_task_callchain(struct perf_sched *sched,
 				struct perf_sample *sample,
-				struct perf_evsel *evsel,
+				struct evsel *evsel,
 				struct machine *machine)
 {
 	struct callchain_cursor *cursor = &callchain_cursor;
@@ -2286,7 +2286,7 @@ static void save_idle_callchain(struct perf_sched *sched,
 static struct thread *timehist_get_thread(struct perf_sched *sched,
 					  struct perf_sample *sample,
 					  struct machine *machine,
-					  struct perf_evsel *evsel)
+					  struct evsel *evsel)
 {
 	struct thread *thread;
 
@@ -2332,7 +2332,7 @@ static struct thread *timehist_get_thread(struct perf_sched *sched,
 
 static bool timehist_skip_sample(struct perf_sched *sched,
 				 struct thread *thread,
-				 struct perf_evsel *evsel,
+				 struct evsel *evsel,
 				 struct perf_sample *sample)
 {
 	bool rc = false;
@@ -2354,7 +2354,7 @@ static bool timehist_skip_sample(struct perf_sched *sched,
 }
 
 static void timehist_print_wakeup_event(struct perf_sched *sched,
-					struct perf_evsel *evsel,
+					struct evsel *evsel,
 					struct perf_sample *sample,
 					struct machine *machine,
 					struct thread *awakened)
@@ -2389,7 +2389,7 @@ static void timehist_print_wakeup_event(struct perf_sched *sched,
 
 static int timehist_sched_wakeup_event(struct perf_tool *tool,
 				       union perf_event *event __maybe_unused,
-				       struct perf_evsel *evsel,
+				       struct evsel *evsel,
 				       struct perf_sample *sample,
 				       struct machine *machine)
 {
@@ -2419,7 +2419,7 @@ static int timehist_sched_wakeup_event(struct perf_tool *tool,
 }
 
 static void timehist_print_migration_event(struct perf_sched *sched,
-					struct perf_evsel *evsel,
+					struct evsel *evsel,
 					struct perf_sample *sample,
 					struct machine *machine,
 					struct thread *migrated)
@@ -2473,7 +2473,7 @@ static void timehist_print_migration_event(struct perf_sched *sched,
 
 static int timehist_migrate_task_event(struct perf_tool *tool,
 				       union perf_event *event __maybe_unused,
-				       struct perf_evsel *evsel,
+				       struct evsel *evsel,
 				       struct perf_sample *sample,
 				       struct machine *machine)
 {
@@ -2501,7 +2501,7 @@ static int timehist_migrate_task_event(struct perf_tool *tool,
 
 static int timehist_sched_change_event(struct perf_tool *tool,
 				       union perf_event *event,
-				       struct perf_evsel *evsel,
+				       struct evsel *evsel,
 				       struct perf_sample *sample,
 				       struct machine *machine)
 {
@@ -2627,7 +2627,7 @@ static int timehist_sched_change_event(struct perf_tool *tool,
 
 static int timehist_sched_switch_event(struct perf_tool *tool,
 			     union perf_event *event,
-			     struct perf_evsel *evsel,
+			     struct evsel *evsel,
 			     struct perf_sample *sample,
 			     struct machine *machine __maybe_unused)
 {
@@ -2897,14 +2897,14 @@ static void timehist_print_summary(struct perf_sched *sched,
 
 typedef int (*sched_handler)(struct perf_tool *tool,
 			  union perf_event *event,
-			  struct perf_evsel *evsel,
+			  struct evsel *evsel,
 			  struct perf_sample *sample,
 			  struct machine *machine);
 
 static int perf_timehist__process_sample(struct perf_tool *tool,
 					 union perf_event *event,
 					 struct perf_sample *sample,
-					 struct perf_evsel *evsel,
+					 struct evsel *evsel,
 					 struct machine *machine)
 {
 	struct perf_sched *sched = container_of(tool, struct perf_sched, tool);
@@ -2926,7 +2926,7 @@ static int perf_timehist__process_sample(struct perf_tool *tool,
 static int timehist_check_attr(struct perf_sched *sched,
 			       struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	struct evsel_runtime *er;
 
 	list_for_each_entry(evsel, &evlist->entries, node) {
@@ -2948,12 +2948,12 @@ static int timehist_check_attr(struct perf_sched *sched,
 
 static int perf_sched__timehist(struct perf_sched *sched)
 {
-	const struct perf_evsel_str_handler handlers[] = {
+	const struct evsel_str_handler handlers[] = {
 		{ "sched:sched_switch",       timehist_sched_switch_event, },
 		{ "sched:sched_wakeup",	      timehist_sched_wakeup_event, },
 		{ "sched:sched_wakeup_new",   timehist_sched_wakeup_event, },
 	};
-	const struct perf_evsel_str_handler migrate_handlers[] = {
+	const struct evsel_str_handler migrate_handlers[] = {
 		{ "sched:sched_migrate_task", timehist_migrate_task_event, },
 	};
 	struct perf_data data = {
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index fccc960df92b..4f9c8bb7620d 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -242,7 +242,7 @@ static struct {
 	},
 };
 
-struct perf_evsel_script {
+struct evsel_script {
        char *filename;
        FILE *fp;
        u64  samples;
@@ -251,15 +251,15 @@ struct perf_evsel_script {
        int  gnum;
 };
 
-static inline struct perf_evsel_script *evsel_script(struct perf_evsel *evsel)
+static inline struct evsel_script *evsel_script(struct evsel *evsel)
 {
-	return (struct perf_evsel_script *)evsel->priv;
+	return (struct evsel_script *)evsel->priv;
 }
 
-static struct perf_evsel_script *perf_evsel_script__new(struct perf_evsel *evsel,
+static struct evsel_script *perf_evsel_script__new(struct evsel *evsel,
 							struct perf_data *data)
 {
-	struct perf_evsel_script *es = zalloc(sizeof(*es));
+	struct evsel_script *es = zalloc(sizeof(*es));
 
 	if (es != NULL) {
 		if (asprintf(&es->filename, "%s.%s.dump", data->file.path, perf_evsel__name(evsel)) < 0)
@@ -277,7 +277,7 @@ static struct perf_evsel_script *perf_evsel_script__new(struct perf_evsel *evsel
 	return NULL;
 }
 
-static void perf_evsel_script__delete(struct perf_evsel_script *es)
+static void perf_evsel_script__delete(struct evsel_script *es)
 {
 	zfree(&es->filename);
 	fclose(es->fp);
@@ -285,7 +285,7 @@ static void perf_evsel_script__delete(struct perf_evsel_script *es)
 	free(es);
 }
 
-static int perf_evsel_script__fprintf(struct perf_evsel_script *es, FILE *fp)
+static int perf_evsel_script__fprintf(struct evsel_script *es, FILE *fp)
 {
 	struct stat st;
 
@@ -340,7 +340,7 @@ static const char *output_field2str(enum perf_output_field field)
 
 #define PRINT_FIELD(x)  (output[output_type(attr->type)].fields & PERF_OUTPUT_##x)
 
-static int perf_evsel__do_check_stype(struct perf_evsel *evsel,
+static int perf_evsel__do_check_stype(struct evsel *evsel,
 				      u64 sample_type, const char *sample_msg,
 				      enum perf_output_field field,
 				      bool allow_user_set)
@@ -372,7 +372,7 @@ static int perf_evsel__do_check_stype(struct perf_evsel *evsel,
 	return 0;
 }
 
-static int perf_evsel__check_stype(struct perf_evsel *evsel,
+static int perf_evsel__check_stype(struct evsel *evsel,
 				   u64 sample_type, const char *sample_msg,
 				   enum perf_output_field field)
 {
@@ -380,7 +380,7 @@ static int perf_evsel__check_stype(struct perf_evsel *evsel,
 					  false);
 }
 
-static int perf_evsel__check_attr(struct perf_evsel *evsel,
+static int perf_evsel__check_attr(struct evsel *evsel,
 				  struct perf_session *session)
 {
 	struct perf_event_attr *attr = &evsel->attr;
@@ -507,7 +507,7 @@ static void set_print_ip_opts(struct perf_event_attr *attr)
 static int perf_session__check_output_opt(struct perf_session *session)
 {
 	unsigned int j;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	for (j = 0; j < OUTPUT_TYPE_MAX; ++j) {
 		evsel = perf_session__find_first_evtype(session, attr_type(j));
@@ -614,7 +614,7 @@ static int perf_sample__fprintf_uregs(struct perf_sample *sample,
 
 static int perf_sample__fprintf_start(struct perf_sample *sample,
 				      struct thread *thread,
-				      struct perf_evsel *evsel,
+				      struct evsel *evsel,
 				      u32 type, FILE *fp)
 {
 	struct perf_event_attr *attr = &evsel->attr;
@@ -1162,7 +1162,7 @@ static int perf_sample__fprintf_addr(struct perf_sample *sample,
 }
 
 static const char *resolve_branch_sym(struct perf_sample *sample,
-				      struct perf_evsel *evsel,
+				      struct evsel *evsel,
 				      struct thread *thread,
 				      struct addr_location *al,
 				      u64 *ip)
@@ -1191,7 +1191,7 @@ static const char *resolve_branch_sym(struct perf_sample *sample,
 }
 
 static int perf_sample__fprintf_callindent(struct perf_sample *sample,
-					   struct perf_evsel *evsel,
+					   struct evsel *evsel,
 					   struct thread *thread,
 					   struct addr_location *al, FILE *fp)
 {
@@ -1285,7 +1285,7 @@ static int perf_sample__fprintf_ipc(struct perf_sample *sample,
 }
 
 static int perf_sample__fprintf_bts(struct perf_sample *sample,
-				    struct perf_evsel *evsel,
+				    struct evsel *evsel,
 				    struct thread *thread,
 				    struct addr_location *al,
 				    struct machine *machine, FILE *fp)
@@ -1593,7 +1593,7 @@ static int perf_sample__fprintf_synth_cbr(struct perf_sample *sample, FILE *fp)
 }
 
 static int perf_sample__fprintf_synth(struct perf_sample *sample,
-				      struct perf_evsel *evsel, FILE *fp)
+				      struct evsel *evsel, FILE *fp)
 {
 	switch (evsel->attr.config) {
 	case PERF_SYNTH_INTEL_PTWRITE:
@@ -1638,7 +1638,7 @@ struct perf_script {
 
 static int perf_evlist__max_name_len(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	int max = 0;
 
 	evlist__for_each_entry(evlist, evsel) {
@@ -1670,7 +1670,7 @@ static int data_src__fprintf(u64 data_src, FILE *fp)
 struct metric_ctx {
 	struct perf_sample	*sample;
 	struct thread		*thread;
-	struct perf_evsel	*evsel;
+	struct evsel	*evsel;
 	FILE 			*fp;
 };
 
@@ -1705,7 +1705,7 @@ static void script_new_line(struct perf_stat_config *config __maybe_unused,
 
 static void perf_sample__fprint_metric(struct perf_script *script,
 				       struct thread *thread,
-				       struct perf_evsel *evsel,
+				       struct evsel *evsel,
 				       struct perf_sample *sample,
 				       FILE *fp)
 {
@@ -1720,7 +1720,7 @@ static void perf_sample__fprint_metric(struct perf_script *script,
 			 },
 		.force_header = false,
 	};
-	struct perf_evsel *ev2;
+	struct evsel *ev2;
 	u64 val;
 
 	if (!evsel->stats)
@@ -1747,7 +1747,7 @@ static void perf_sample__fprint_metric(struct perf_script *script,
 }
 
 static bool show_event(struct perf_sample *sample,
-		       struct perf_evsel *evsel,
+		       struct evsel *evsel,
 		       struct thread *thread,
 		       struct addr_location *al)
 {
@@ -1788,14 +1788,14 @@ static bool show_event(struct perf_sample *sample,
 }
 
 static void process_event(struct perf_script *script,
-			  struct perf_sample *sample, struct perf_evsel *evsel,
+			  struct perf_sample *sample, struct evsel *evsel,
 			  struct addr_location *al,
 			  struct machine *machine)
 {
 	struct thread *thread = al->thread;
 	struct perf_event_attr *attr = &evsel->attr;
 	unsigned int type = output_type(attr->type);
-	struct perf_evsel_script *es = evsel->priv;
+	struct evsel_script *es = evsel->priv;
 	FILE *fp = es->fp;
 
 	if (output[type].fields == 0)
@@ -1897,7 +1897,7 @@ static void process_event(struct perf_script *script,
 
 static struct scripting_ops	*scripting_ops;
 
-static void __process_stat(struct perf_evsel *counter, u64 tstamp)
+static void __process_stat(struct evsel *counter, u64 tstamp)
 {
 	int nthreads = thread_map__nr(counter->threads);
 	int ncpus = perf_evsel__nr_cpus(counter);
@@ -1931,7 +1931,7 @@ static void __process_stat(struct perf_evsel *counter, u64 tstamp)
 	}
 }
 
-static void process_stat(struct perf_evsel *counter, u64 tstamp)
+static void process_stat(struct evsel *counter, u64 tstamp)
 {
 	if (scripting_ops && scripting_ops->process_stat)
 		scripting_ops->process_stat(&stat_config, counter, tstamp);
@@ -1973,7 +1973,7 @@ static bool filter_cpu(struct perf_sample *sample)
 static int process_sample_event(struct perf_tool *tool,
 				union perf_event *event,
 				struct perf_sample *sample,
-				struct perf_evsel *evsel,
+				struct evsel *evsel,
 				struct machine *machine)
 {
 	struct perf_script *scr = container_of(tool, struct perf_script, tool);
@@ -2022,9 +2022,9 @@ static int process_attr(struct perf_tool *tool, union perf_event *event,
 {
 	struct perf_script *scr = container_of(tool, struct perf_script, tool);
 	struct perf_evlist *evlist;
-	struct perf_evsel *evsel, *pos;
+	struct evsel *evsel, *pos;
 	int err;
-	static struct perf_evsel_script *es;
+	static struct evsel_script *es;
 
 	err = perf_event__process_attr(tool, event, pevlist);
 	if (err)
@@ -2071,7 +2071,7 @@ static int process_comm_event(struct perf_tool *tool,
 	struct thread *thread;
 	struct perf_script *script = container_of(tool, struct perf_script, tool);
 	struct perf_session *session = script->session;
-	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
+	struct evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
 	int ret = -1;
 
 	thread = machine__findnew_thread(machine, event->comm.pid, event->comm.tid);
@@ -2108,7 +2108,7 @@ static int process_namespaces_event(struct perf_tool *tool,
 	struct thread *thread;
 	struct perf_script *script = container_of(tool, struct perf_script, tool);
 	struct perf_session *session = script->session;
-	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
+	struct evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
 	int ret = -1;
 
 	thread = machine__findnew_thread(machine, event->namespaces.pid,
@@ -2146,7 +2146,7 @@ static int process_fork_event(struct perf_tool *tool,
 	struct thread *thread;
 	struct perf_script *script = container_of(tool, struct perf_script, tool);
 	struct perf_session *session = script->session;
-	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
+	struct evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
 
 	if (perf_event__process_fork(tool, event, sample, machine) < 0)
 		return -1;
@@ -2181,7 +2181,7 @@ static int process_exit_event(struct perf_tool *tool,
 	struct thread *thread;
 	struct perf_script *script = container_of(tool, struct perf_script, tool);
 	struct perf_session *session = script->session;
-	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
+	struct evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
 
 	thread = machine__findnew_thread(machine, event->fork.pid, event->fork.tid);
 	if (thread == NULL) {
@@ -2216,7 +2216,7 @@ static int process_mmap_event(struct perf_tool *tool,
 	struct thread *thread;
 	struct perf_script *script = container_of(tool, struct perf_script, tool);
 	struct perf_session *session = script->session;
-	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
+	struct evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
 
 	if (perf_event__process_mmap(tool, event, sample, machine) < 0)
 		return -1;
@@ -2250,7 +2250,7 @@ static int process_mmap2_event(struct perf_tool *tool,
 	struct thread *thread;
 	struct perf_script *script = container_of(tool, struct perf_script, tool);
 	struct perf_session *session = script->session;
-	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
+	struct evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
 
 	if (perf_event__process_mmap2(tool, event, sample, machine) < 0)
 		return -1;
@@ -2284,7 +2284,7 @@ static int process_switch_event(struct perf_tool *tool,
 	struct thread *thread;
 	struct perf_script *script = container_of(tool, struct perf_script, tool);
 	struct perf_session *session = script->session;
-	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
+	struct evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
 
 	if (perf_event__process_switch(tool, event, sample, machine) < 0)
 		return -1;
@@ -2319,7 +2319,7 @@ process_lost_event(struct perf_tool *tool,
 {
 	struct perf_script *script = container_of(tool, struct perf_script, tool);
 	struct perf_session *session = script->session;
-	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
+	struct evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
 	struct thread *thread;
 
 	thread = machine__findnew_thread(machine, sample->pid,
@@ -2355,7 +2355,7 @@ process_bpf_events(struct perf_tool *tool __maybe_unused,
 	struct thread *thread;
 	struct perf_script *script = container_of(tool, struct perf_script, tool);
 	struct perf_session *session = script->session;
-	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
+	struct evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
 
 	if (machine__process_ksymbol(machine, event, sample) < 0)
 		return -1;
@@ -2389,7 +2389,7 @@ static void sig_handler(int sig __maybe_unused)
 static void perf_script__fclose_per_event_dump(struct perf_script *script)
 {
 	struct perf_evlist *evlist = script->session->evlist;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (!evsel->priv)
@@ -2401,7 +2401,7 @@ static void perf_script__fclose_per_event_dump(struct perf_script *script)
 
 static int perf_script__fopen_per_event_dump(struct perf_script *script)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	evlist__for_each_entry(script->session->evlist, evsel) {
 		/*
@@ -2428,8 +2428,8 @@ static int perf_script__fopen_per_event_dump(struct perf_script *script)
 
 static int perf_script__setup_per_event_dump(struct perf_script *script)
 {
-	struct perf_evsel *evsel;
-	static struct perf_evsel_script es_stdout;
+	struct evsel *evsel;
+	static struct evsel_script es_stdout;
 
 	if (script->per_event_dump)
 		return perf_script__fopen_per_event_dump(script);
@@ -2444,10 +2444,10 @@ static int perf_script__setup_per_event_dump(struct perf_script *script)
 
 static void perf_script__exit_per_event_dump_stats(struct perf_script *script)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	evlist__for_each_entry(script->session->evlist, evsel) {
-		struct perf_evsel_script *es = evsel->priv;
+		struct evsel_script *es = evsel->priv;
 
 		perf_evsel_script__fprintf(es, stdout);
 		perf_evsel_script__delete(es);
@@ -3003,7 +3003,7 @@ static int check_ev_match(char *dir_name, char *scriptname,
 {
 	char filename[MAXPATHLEN], evname[128];
 	char line[BUFSIZ], *p;
-	struct perf_evsel *pos;
+	struct evsel *pos;
 	int match, len;
 	FILE *fp;
 
@@ -3236,7 +3236,7 @@ static int process_stat_round_event(struct perf_session *session,
 				    union perf_event *event)
 {
 	struct stat_round_event *round = &event->stat_round;
-	struct perf_evsel *counter;
+	struct evsel *counter;
 
 	evlist__for_each_entry(session->evlist, counter) {
 		perf_stat_process_counter(&stat_config, counter);
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 2b9518a38baf..e0ba97018ad7 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -234,7 +234,7 @@ static int write_stat_round_event(u64 tm, u64 type)
 #define SID(e, x, y) xyarray__entry(e->sample_id, x, y)
 
 static int
-perf_evsel__write_stat_event(struct perf_evsel *counter, u32 cpu, u32 thread,
+perf_evsel__write_stat_event(struct evsel *counter, u32 cpu, u32 thread,
 			     struct perf_counts_values *count)
 {
 	struct perf_sample_id *sid = SID(counter, cpu, thread);
@@ -243,7 +243,7 @@ perf_evsel__write_stat_event(struct perf_evsel *counter, u32 cpu, u32 thread,
 					   process_synthesized_event, NULL);
 }
 
-static int read_single_counter(struct perf_evsel *counter, int cpu,
+static int read_single_counter(struct evsel *counter, int cpu,
 			       int thread, struct timespec *rs)
 {
 	if (counter->tool_event == PERF_TOOL_DURATION_TIME) {
@@ -261,7 +261,7 @@ static int read_single_counter(struct perf_evsel *counter, int cpu,
  * Read out the results of a single counter:
  * do not aggregate counts across CPUs in system-wide mode
  */
-static int read_counter(struct perf_evsel *counter, struct timespec *rs)
+static int read_counter(struct evsel *counter, struct timespec *rs)
 {
 	int nthreads = thread_map__nr(evsel_list->threads);
 	int ncpus, cpu, thread;
@@ -319,7 +319,7 @@ static int read_counter(struct perf_evsel *counter, struct timespec *rs)
 
 static void read_counters(struct timespec *rs)
 {
-	struct perf_evsel *counter;
+	struct evsel *counter;
 	int ret;
 
 	evlist__for_each_entry(evsel_list, counter) {
@@ -389,7 +389,7 @@ static void workload_exec_failed_signal(int signo __maybe_unused, siginfo_t *inf
 	workload_exec_errno = info->si_value.sival_int;
 }
 
-static bool perf_evsel__should_store_id(struct perf_evsel *counter)
+static bool perf_evsel__should_store_id(struct evsel *counter)
 {
 	return STAT_RECORD || counter->attr.read_format & PERF_FORMAT_ID;
 }
@@ -423,7 +423,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	int timeout = stat_config.timeout;
 	char msg[BUFSIZ];
 	unsigned long long t0, t1;
-	struct perf_evsel *counter;
+	struct evsel *counter;
 	struct timespec ts;
 	size_t l;
 	int status = 0;
@@ -868,7 +868,7 @@ static int perf_stat__get_core_cached(struct perf_stat_config *config,
 
 static bool term_percore_set(void)
 {
-	struct perf_evsel *counter;
+	struct evsel *counter;
 
 	evlist__for_each_entry(evsel_list, counter) {
 		if (counter->percore)
@@ -1462,7 +1462,7 @@ static int process_stat_round_event(struct perf_session *session,
 				    union perf_event *event)
 {
 	struct stat_round_event *stat_round = &event->stat_round;
-	struct perf_evsel *counter;
+	struct evsel *counter;
 	struct timespec tsh, *ts = NULL;
 	const char **argv = session->header.env.cmdline_argv;
 	int argc = session->header.env.nr_cmdline;
@@ -1676,7 +1676,7 @@ static void setup_system_wide(int forks)
 	if (!forks)
 		target.system_wide = true;
 	else {
-		struct perf_evsel *counter;
+		struct evsel *counter;
 
 		evlist__for_each_entry(evsel_list, counter) {
 			if (!counter->system_wide)
diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 4bde3fa245d1..f5f70c83d304 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -545,14 +545,14 @@ static const char *cat_backtrace(union perf_event *event,
 }
 
 typedef int (*tracepoint_handler)(struct timechart *tchart,
-				  struct perf_evsel *evsel,
+				  struct evsel *evsel,
 				  struct perf_sample *sample,
 				  const char *backtrace);
 
 static int process_sample_event(struct perf_tool *tool,
 				union perf_event *event,
 				struct perf_sample *sample,
-				struct perf_evsel *evsel,
+				struct evsel *evsel,
 				struct machine *machine)
 {
 	struct timechart *tchart = container_of(tool, struct timechart, tool);
@@ -575,7 +575,7 @@ static int process_sample_event(struct perf_tool *tool,
 
 static int
 process_sample_cpu_idle(struct timechart *tchart __maybe_unused,
-			struct perf_evsel *evsel,
+			struct evsel *evsel,
 			struct perf_sample *sample,
 			const char *backtrace __maybe_unused)
 {
@@ -591,7 +591,7 @@ process_sample_cpu_idle(struct timechart *tchart __maybe_unused,
 
 static int
 process_sample_cpu_frequency(struct timechart *tchart,
-			     struct perf_evsel *evsel,
+			     struct evsel *evsel,
 			     struct perf_sample *sample,
 			     const char *backtrace __maybe_unused)
 {
@@ -604,7 +604,7 @@ process_sample_cpu_frequency(struct timechart *tchart,
 
 static int
 process_sample_sched_wakeup(struct timechart *tchart,
-			    struct perf_evsel *evsel,
+			    struct evsel *evsel,
 			    struct perf_sample *sample,
 			    const char *backtrace)
 {
@@ -618,7 +618,7 @@ process_sample_sched_wakeup(struct timechart *tchart,
 
 static int
 process_sample_sched_switch(struct timechart *tchart,
-			    struct perf_evsel *evsel,
+			    struct evsel *evsel,
 			    struct perf_sample *sample,
 			    const char *backtrace)
 {
@@ -634,7 +634,7 @@ process_sample_sched_switch(struct timechart *tchart,
 #ifdef SUPPORT_OLD_POWER_EVENTS
 static int
 process_sample_power_start(struct timechart *tchart __maybe_unused,
-			   struct perf_evsel *evsel,
+			   struct evsel *evsel,
 			   struct perf_sample *sample,
 			   const char *backtrace __maybe_unused)
 {
@@ -647,7 +647,7 @@ process_sample_power_start(struct timechart *tchart __maybe_unused,
 
 static int
 process_sample_power_end(struct timechart *tchart,
-			 struct perf_evsel *evsel __maybe_unused,
+			 struct evsel *evsel __maybe_unused,
 			 struct perf_sample *sample,
 			 const char *backtrace __maybe_unused)
 {
@@ -657,7 +657,7 @@ process_sample_power_end(struct timechart *tchart,
 
 static int
 process_sample_power_frequency(struct timechart *tchart,
-			       struct perf_evsel *evsel,
+			       struct evsel *evsel,
 			       struct perf_sample *sample,
 			       const char *backtrace __maybe_unused)
 {
@@ -840,7 +840,7 @@ static int pid_end_io_sample(struct timechart *tchart, int pid, int type,
 
 static int
 process_enter_read(struct timechart *tchart,
-		   struct perf_evsel *evsel,
+		   struct evsel *evsel,
 		   struct perf_sample *sample)
 {
 	long fd = perf_evsel__intval(evsel, sample, "fd");
@@ -850,7 +850,7 @@ process_enter_read(struct timechart *tchart,
 
 static int
 process_exit_read(struct timechart *tchart,
-		  struct perf_evsel *evsel,
+		  struct evsel *evsel,
 		  struct perf_sample *sample)
 {
 	long ret = perf_evsel__intval(evsel, sample, "ret");
@@ -860,7 +860,7 @@ process_exit_read(struct timechart *tchart,
 
 static int
 process_enter_write(struct timechart *tchart,
-		    struct perf_evsel *evsel,
+		    struct evsel *evsel,
 		    struct perf_sample *sample)
 {
 	long fd = perf_evsel__intval(evsel, sample, "fd");
@@ -870,7 +870,7 @@ process_enter_write(struct timechart *tchart,
 
 static int
 process_exit_write(struct timechart *tchart,
-		   struct perf_evsel *evsel,
+		   struct evsel *evsel,
 		   struct perf_sample *sample)
 {
 	long ret = perf_evsel__intval(evsel, sample, "ret");
@@ -880,7 +880,7 @@ process_exit_write(struct timechart *tchart,
 
 static int
 process_enter_sync(struct timechart *tchart,
-		   struct perf_evsel *evsel,
+		   struct evsel *evsel,
 		   struct perf_sample *sample)
 {
 	long fd = perf_evsel__intval(evsel, sample, "fd");
@@ -890,7 +890,7 @@ process_enter_sync(struct timechart *tchart,
 
 static int
 process_exit_sync(struct timechart *tchart,
-		  struct perf_evsel *evsel,
+		  struct evsel *evsel,
 		  struct perf_sample *sample)
 {
 	long ret = perf_evsel__intval(evsel, sample, "ret");
@@ -900,7 +900,7 @@ process_exit_sync(struct timechart *tchart,
 
 static int
 process_enter_tx(struct timechart *tchart,
-		 struct perf_evsel *evsel,
+		 struct evsel *evsel,
 		 struct perf_sample *sample)
 {
 	long fd = perf_evsel__intval(evsel, sample, "fd");
@@ -910,7 +910,7 @@ process_enter_tx(struct timechart *tchart,
 
 static int
 process_exit_tx(struct timechart *tchart,
-		struct perf_evsel *evsel,
+		struct evsel *evsel,
 		struct perf_sample *sample)
 {
 	long ret = perf_evsel__intval(evsel, sample, "ret");
@@ -920,7 +920,7 @@ process_exit_tx(struct timechart *tchart,
 
 static int
 process_enter_rx(struct timechart *tchart,
-		 struct perf_evsel *evsel,
+		 struct evsel *evsel,
 		 struct perf_sample *sample)
 {
 	long fd = perf_evsel__intval(evsel, sample, "fd");
@@ -930,7 +930,7 @@ process_enter_rx(struct timechart *tchart,
 
 static int
 process_exit_rx(struct timechart *tchart,
-		struct perf_evsel *evsel,
+		struct evsel *evsel,
 		struct perf_sample *sample)
 {
 	long ret = perf_evsel__intval(evsel, sample, "ret");
@@ -940,7 +940,7 @@ process_exit_rx(struct timechart *tchart,
 
 static int
 process_enter_poll(struct timechart *tchart,
-		   struct perf_evsel *evsel,
+		   struct evsel *evsel,
 		   struct perf_sample *sample)
 {
 	long fd = perf_evsel__intval(evsel, sample, "fd");
@@ -950,7 +950,7 @@ process_enter_poll(struct timechart *tchart,
 
 static int
 process_exit_poll(struct timechart *tchart,
-		  struct perf_evsel *evsel,
+		  struct evsel *evsel,
 		  struct perf_sample *sample)
 {
 	long ret = perf_evsel__intval(evsel, sample, "ret");
@@ -1534,7 +1534,7 @@ static int process_header(struct perf_file_section *section __maybe_unused,
 
 static int __cmd_timechart(struct timechart *tchart, const char *output_name)
 {
-	const struct perf_evsel_str_handler power_tracepoints[] = {
+	const struct evsel_str_handler power_tracepoints[] = {
 		{ "power:cpu_idle",		process_sample_cpu_idle },
 		{ "power:cpu_frequency",	process_sample_cpu_frequency },
 		{ "sched:sched_wakeup",		process_sample_sched_wakeup },
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index b46b3c9f57a0..2f22f313985e 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -101,7 +101,7 @@ static void perf_top__resize(struct perf_top *top)
 
 static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	struct symbol *sym;
 	struct annotation *notes;
 	struct map *map;
@@ -186,7 +186,7 @@ static void ui__warn_map_erange(struct map *map, struct symbol *sym, u64 ip)
 static void perf_top__record_precise_ip(struct perf_top *top,
 					struct hist_entry *he,
 					struct perf_sample *sample,
-					struct perf_evsel *evsel, u64 ip)
+					struct evsel *evsel, u64 ip)
 {
 	struct annotation *notes;
 	struct symbol *sym = he->ms.sym;
@@ -228,7 +228,7 @@ static void perf_top__record_precise_ip(struct perf_top *top,
 static void perf_top__show_details(struct perf_top *top)
 {
 	struct hist_entry *he = top->sym_filter_entry;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	struct annotation *notes;
 	struct symbol *symbol;
 	int more;
@@ -270,7 +270,7 @@ static void perf_top__print_sym_table(struct perf_top *top)
 	char bf[160];
 	int printed = 0;
 	const int win_width = top->winsize.ws_col - 1;
-	struct perf_evsel *evsel = top->sym_evsel;
+	struct evsel *evsel = top->sym_evsel;
 	struct hists *hists = evsel__hists(evsel);
 
 	puts(CONSOLE_CLEAR);
@@ -554,7 +554,7 @@ static bool perf_top__handle_keypress(struct perf_top *top, int c)
 static void perf_top__sort_new_samples(void *arg)
 {
 	struct perf_top *t = arg;
-	struct perf_evsel *evsel = t->sym_evsel;
+	struct evsel *evsel = t->sym_evsel;
 	struct hists *hists;
 
 	if (t->evlist->selected != NULL)
@@ -586,7 +586,7 @@ static void stop_top(void)
 
 static void *display_thread_tui(void *arg)
 {
-	struct perf_evsel *pos;
+	struct evsel *pos;
 	struct perf_top *top = arg;
 	const char *help = "For a higher level overview, try: perf top --sort comm,dso";
 	struct hist_browser_timer hbt = {
@@ -693,7 +693,7 @@ static int hist_iter__top_callback(struct hist_entry_iter *iter,
 {
 	struct perf_top *top = arg;
 	struct hist_entry *he = iter->he;
-	struct perf_evsel *evsel = iter->evsel;
+	struct evsel *evsel = iter->evsel;
 
 	if (perf_hpp_list.sym && single)
 		perf_top__record_precise_ip(top, he, iter->sample, evsel, al->addr);
@@ -705,7 +705,7 @@ static int hist_iter__top_callback(struct hist_entry_iter *iter,
 
 static void perf_event__process_sample(struct perf_tool *tool,
 				       const union perf_event *event,
-				       struct perf_evsel *evsel,
+				       struct evsel *evsel,
 				       struct perf_sample *sample,
 				       struct machine *machine)
 {
@@ -813,7 +813,7 @@ static void perf_event__process_sample(struct perf_tool *tool,
 
 static void
 perf_top__process_lost(struct perf_top *top, union perf_event *event,
-		       struct perf_evsel *evsel)
+		       struct evsel *evsel)
 {
 	struct hists *hists = evsel__hists(evsel);
 
@@ -825,7 +825,7 @@ perf_top__process_lost(struct perf_top *top, union perf_event *event,
 static void
 perf_top__process_lost_samples(struct perf_top *top,
 			       union perf_event *event,
-			       struct perf_evsel *evsel)
+			       struct evsel *evsel)
 {
 	struct hists *hists = evsel__hists(evsel);
 
@@ -912,7 +912,7 @@ static int perf_top__overwrite_check(struct perf_top *top)
 	struct perf_evlist *evlist = top->evlist;
 	struct perf_evsel_config_term *term;
 	struct list_head *config_terms;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	int set, overwrite = -1;
 
 	evlist__for_each_entry(evlist, evsel) {
@@ -952,11 +952,11 @@ static int perf_top__overwrite_check(struct perf_top *top)
 }
 
 static int perf_top_overwrite_fallback(struct perf_top *top,
-				       struct perf_evsel *evsel)
+				       struct evsel *evsel)
 {
 	struct record_opts *opts = &top->record_opts;
 	struct perf_evlist *evlist = top->evlist;
-	struct perf_evsel *counter;
+	struct evsel *counter;
 
 	if (!opts->overwrite)
 		return 0;
@@ -975,7 +975,7 @@ static int perf_top_overwrite_fallback(struct perf_top *top,
 static int perf_top__start_counters(struct perf_top *top)
 {
 	char msg[BUFSIZ];
-	struct perf_evsel *counter;
+	struct evsel *counter;
 	struct perf_evlist *evlist = top->evlist;
 	struct record_opts *opts = &top->record_opts;
 
@@ -1104,7 +1104,7 @@ static int deliver_event(struct ordered_events *qe,
 	struct perf_session *session = top->session;
 	union perf_event *event = qevent->event;
 	struct perf_sample sample;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	struct machine *machine;
 	int ret = -1;
 
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 9f927ca5eb0b..506351d74cbc 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -87,7 +87,7 @@ struct trace {
 					*sys_exit;
 		}		prog_array;
 		struct {
-			struct perf_evsel *sys_enter,
+			struct evsel *sys_enter,
 					  *sys_exit,
 					  *augmented;
 		}		events;
@@ -243,7 +243,7 @@ struct syscall_tp {
 	};
 };
 
-static int perf_evsel__init_tp_uint_field(struct perf_evsel *evsel,
+static int perf_evsel__init_tp_uint_field(struct evsel *evsel,
 					  struct tp_field *field,
 					  const char *name)
 {
@@ -259,7 +259,7 @@ static int perf_evsel__init_tp_uint_field(struct perf_evsel *evsel,
 	({ struct syscall_tp *sc = evsel->priv;\
 	   perf_evsel__init_tp_uint_field(evsel, &sc->name, #name); })
 
-static int perf_evsel__init_tp_ptr_field(struct perf_evsel *evsel,
+static int perf_evsel__init_tp_ptr_field(struct evsel *evsel,
 					 struct tp_field *field,
 					 const char *name)
 {
@@ -275,13 +275,13 @@ static int perf_evsel__init_tp_ptr_field(struct perf_evsel *evsel,
 	({ struct syscall_tp *sc = evsel->priv;\
 	   perf_evsel__init_tp_ptr_field(evsel, &sc->name, #name); })
 
-static void perf_evsel__delete_priv(struct perf_evsel *evsel)
+static void perf_evsel__delete_priv(struct evsel *evsel)
 {
 	zfree(&evsel->priv);
 	perf_evsel__delete(evsel);
 }
 
-static int perf_evsel__init_syscall_tp(struct perf_evsel *evsel)
+static int perf_evsel__init_syscall_tp(struct evsel *evsel)
 {
 	struct syscall_tp *sc = evsel->priv = malloc(sizeof(struct syscall_tp));
 
@@ -298,7 +298,7 @@ static int perf_evsel__init_syscall_tp(struct perf_evsel *evsel)
 	return -ENOENT;
 }
 
-static int perf_evsel__init_augmented_syscall_tp(struct perf_evsel *evsel, struct perf_evsel *tp)
+static int perf_evsel__init_augmented_syscall_tp(struct evsel *evsel, struct evsel *tp)
 {
 	struct syscall_tp *sc = evsel->priv = malloc(sizeof(struct syscall_tp));
 
@@ -320,21 +320,21 @@ static int perf_evsel__init_augmented_syscall_tp(struct perf_evsel *evsel, struc
 	return -EINVAL;
 }
 
-static int perf_evsel__init_augmented_syscall_tp_args(struct perf_evsel *evsel)
+static int perf_evsel__init_augmented_syscall_tp_args(struct evsel *evsel)
 {
 	struct syscall_tp *sc = evsel->priv;
 
 	return __tp_field__init_ptr(&sc->args, sc->id.offset + sizeof(u64));
 }
 
-static int perf_evsel__init_augmented_syscall_tp_ret(struct perf_evsel *evsel)
+static int perf_evsel__init_augmented_syscall_tp_ret(struct evsel *evsel)
 {
 	struct syscall_tp *sc = evsel->priv;
 
 	return __tp_field__init_uint(&sc->ret, sizeof(u64), sc->id.offset + sizeof(u64), evsel->needs_swap);
 }
 
-static int perf_evsel__init_raw_syscall_tp(struct perf_evsel *evsel, void *handler)
+static int perf_evsel__init_raw_syscall_tp(struct evsel *evsel, void *handler)
 {
 	evsel->priv = malloc(sizeof(struct syscall_tp));
 	if (evsel->priv != NULL) {
@@ -352,9 +352,9 @@ static int perf_evsel__init_raw_syscall_tp(struct perf_evsel *evsel, void *handl
 	return -ENOENT;
 }
 
-static struct perf_evsel *perf_evsel__raw_syscall_newtp(const char *direction, void *handler)
+static struct evsel *perf_evsel__raw_syscall_newtp(const char *direction, void *handler)
 {
-	struct perf_evsel *evsel = perf_evsel__newtp("raw_syscalls", direction);
+	struct evsel *evsel = perf_evsel__newtp("raw_syscalls", direction);
 
 	/* older kernel (e.g., RHEL6) use syscalls:{enter,exit} */
 	if (IS_ERR(evsel))
@@ -1787,12 +1787,12 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 	return printed;
 }
 
-typedef int (*tracepoint_handler)(struct trace *trace, struct perf_evsel *evsel,
+typedef int (*tracepoint_handler)(struct trace *trace, struct evsel *evsel,
 				  union perf_event *event,
 				  struct perf_sample *sample);
 
 static struct syscall *trace__syscall_info(struct trace *trace,
-					   struct perf_evsel *evsel, int id)
+					   struct evsel *evsel, int id)
 {
 	int err = 0;
 
@@ -1898,7 +1898,7 @@ static int trace__printf_interrupted_entry(struct trace *trace)
 	return printed;
 }
 
-static int trace__fprintf_sample(struct trace *trace, struct perf_evsel *evsel,
+static int trace__fprintf_sample(struct trace *trace, struct evsel *evsel,
 				 struct perf_sample *sample, struct thread *thread)
 {
 	int printed = 0;
@@ -1941,7 +1941,7 @@ static void *syscall__augmented_args(struct syscall *sc, struct perf_sample *sam
 	return augmented_args;
 }
 
-static int trace__sys_enter(struct trace *trace, struct perf_evsel *evsel,
+static int trace__sys_enter(struct trace *trace, struct evsel *evsel,
 			    union perf_event *event __maybe_unused,
 			    struct perf_sample *sample)
 {
@@ -2020,7 +2020,7 @@ static int trace__sys_enter(struct trace *trace, struct perf_evsel *evsel,
 	return err;
 }
 
-static int trace__fprintf_sys_enter(struct trace *trace, struct perf_evsel *evsel,
+static int trace__fprintf_sys_enter(struct trace *trace, struct evsel *evsel,
 				    struct perf_sample *sample)
 {
 	struct thread_trace *ttrace;
@@ -2053,7 +2053,7 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct perf_evsel *evse
 	return err;
 }
 
-static int trace__resolve_callchain(struct trace *trace, struct perf_evsel *evsel,
+static int trace__resolve_callchain(struct trace *trace, struct evsel *evsel,
 				    struct perf_sample *sample,
 				    struct callchain_cursor *cursor)
 {
@@ -2081,7 +2081,7 @@ static int trace__fprintf_callchain(struct trace *trace, struct perf_sample *sam
 	return sample__fprintf_callchain(sample, 38, print_opts, &callchain_cursor, trace->output);
 }
 
-static const char *errno_to_name(struct perf_evsel *evsel, int err)
+static const char *errno_to_name(struct evsel *evsel, int err)
 {
 	struct perf_env *env = perf_evsel__env(evsel);
 	const char *arch_name = perf_env__arch(env);
@@ -2089,7 +2089,7 @@ static const char *errno_to_name(struct perf_evsel *evsel, int err)
 	return arch_syscalls__strerrno(arch_name, err);
 }
 
-static int trace__sys_exit(struct trace *trace, struct perf_evsel *evsel,
+static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
 			   union perf_event *event __maybe_unused,
 			   struct perf_sample *sample)
 {
@@ -2223,7 +2223,7 @@ errno_print: {
 	return err;
 }
 
-static int trace__vfs_getname(struct trace *trace, struct perf_evsel *evsel,
+static int trace__vfs_getname(struct trace *trace, struct evsel *evsel,
 			      union perf_event *event __maybe_unused,
 			      struct perf_sample *sample)
 {
@@ -2284,7 +2284,7 @@ static int trace__vfs_getname(struct trace *trace, struct perf_evsel *evsel,
 	return 0;
 }
 
-static int trace__sched_stat_runtime(struct trace *trace, struct perf_evsel *evsel,
+static int trace__sched_stat_runtime(struct trace *trace, struct evsel *evsel,
 				     union perf_event *event __maybe_unused,
 				     struct perf_sample *sample)
 {
@@ -2346,7 +2346,7 @@ static void bpf_output__fprintf(struct trace *trace,
 	++trace->nr_events_printed;
 }
 
-static int trace__event_handler(struct trace *trace, struct perf_evsel *evsel,
+static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 				union perf_event *event __maybe_unused,
 				struct perf_sample *sample)
 {
@@ -2448,7 +2448,7 @@ static void print_location(FILE *f, struct perf_sample *sample,
 }
 
 static int trace__pgfault(struct trace *trace,
-			  struct perf_evsel *evsel,
+			  struct evsel *evsel,
 			  union perf_event *event __maybe_unused,
 			  struct perf_sample *sample)
 {
@@ -2523,7 +2523,7 @@ static int trace__pgfault(struct trace *trace,
 }
 
 static void trace__set_base_time(struct trace *trace,
-				 struct perf_evsel *evsel,
+				 struct evsel *evsel,
 				 struct perf_sample *sample)
 {
 	/*
@@ -2542,7 +2542,7 @@ static void trace__set_base_time(struct trace *trace,
 static int trace__process_sample(struct perf_tool *tool,
 				 union perf_event *event,
 				 struct perf_sample *sample,
-				 struct perf_evsel *evsel,
+				 struct evsel *evsel,
 				 struct machine *machine __maybe_unused)
 {
 	struct trace *trace = container_of(tool, struct trace, tool);
@@ -2631,7 +2631,7 @@ static size_t trace__fprintf_thread_summary(struct trace *trace, FILE *fp);
 static bool perf_evlist__add_vfs_getname(struct perf_evlist *evlist)
 {
 	bool found = false;
-	struct perf_evsel *evsel, *tmp;
+	struct evsel *evsel, *tmp;
 	struct parse_events_error err = { .idx = 0, };
 	int ret = parse_events(evlist, "probe:vfs_getname*", &err);
 
@@ -2656,9 +2656,9 @@ static bool perf_evlist__add_vfs_getname(struct perf_evlist *evlist)
 	return found;
 }
 
-static struct perf_evsel *perf_evsel__new_pgfault(u64 config)
+static struct evsel *perf_evsel__new_pgfault(u64 config)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	struct perf_event_attr attr = {
 		.type = PERF_TYPE_SOFTWARE,
 		.mmap_data = 1,
@@ -2679,7 +2679,7 @@ static struct perf_evsel *perf_evsel__new_pgfault(u64 config)
 static void trace__handle_event(struct trace *trace, union perf_event *event, struct perf_sample *sample)
 {
 	const u32 type = event->header.type;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	if (type != PERF_RECORD_SAMPLE) {
 		trace__process_event(trace, trace->host, event, sample);
@@ -2712,7 +2712,7 @@ static int trace__add_syscall_newtp(struct trace *trace)
 {
 	int ret = -1;
 	struct perf_evlist *evlist = trace->evlist;
-	struct perf_evsel *sys_enter, *sys_exit;
+	struct evsel *sys_enter, *sys_exit;
 
 	sys_enter = perf_evsel__raw_syscall_newtp("sys_enter", trace__sys_enter);
 	if (sys_enter == NULL)
@@ -2760,7 +2760,7 @@ static int trace__add_syscall_newtp(struct trace *trace)
 static int trace__set_ev_qualifier_tp_filter(struct trace *trace)
 {
 	int err = -1;
-	struct perf_evsel *sys_exit;
+	struct evsel *sys_exit;
 	char *filter = asprintf_expr_inout_ints("id", !trace->not_ev_qualifier,
 						trace->ev_qualifier_ids.nr,
 						trace->ev_qualifier_ids.entries);
@@ -3250,7 +3250,7 @@ static int ordered_events__deliver_event(struct ordered_events *oe,
 static int trace__run(struct trace *trace, int argc, const char **argv)
 {
 	struct perf_evlist *evlist = trace->evlist;
-	struct perf_evsel *evsel, *pgfault_maj = NULL, *pgfault_min = NULL;
+	struct evsel *evsel, *pgfault_maj = NULL, *pgfault_min = NULL;
 	int err = -1, i;
 	unsigned long before;
 	const bool forks = argc > 0;
@@ -3542,7 +3542,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 
 static int trace__replay(struct trace *trace)
 {
-	const struct perf_evsel_str_handler handlers[] = {
+	const struct evsel_str_handler handlers[] = {
 		{ "probe:vfs_getname",	     trace__vfs_getname, },
 	};
 	struct perf_data data = {
@@ -3551,7 +3551,7 @@ static int trace__replay(struct trace *trace)
 		.force = trace->force,
 	};
 	struct perf_session *session;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	int err = -1;
 
 	trace->tool.sample	  = trace__process_sample;
@@ -3844,7 +3844,7 @@ static int parse_pagefaults(const struct option *opt, const char *str,
 
 static void evlist__set_evsel_handler(struct perf_evlist *evlist, void *handler)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel)
 		evsel->handler = handler;
@@ -3852,7 +3852,7 @@ static void evlist__set_evsel_handler(struct perf_evlist *evlist, void *handler)
 
 static int evlist__set_syscall_tp_fields(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (evsel->priv || !evsel->tp_format)
@@ -4163,7 +4163,7 @@ int cmd_trace(int argc, const char **argv)
 	};
 	bool __maybe_unused max_stack_user_set = true;
 	bool mmap_pages_user_set = true;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	const char * const trace_subcommands[] = { "record", NULL };
 	int err = -1;
 	char bf[BUFSIZ];
@@ -4307,7 +4307,7 @@ int cmd_trace(int argc, const char **argv)
 
 			if (trace.syscalls.events.augmented->priv == NULL &&
 			    strstr(perf_evsel__name(evsel), "syscalls:sys_enter")) {
-				struct perf_evsel *augmented = trace.syscalls.events.augmented;
+				struct evsel *augmented = trace.syscalls.events.augmented;
 				if (perf_evsel__init_augmented_syscall_tp(augmented, evsel) ||
 				    perf_evsel__init_augmented_syscall_tp_args(augmented))
 					goto out;
diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
index 1a9c3becf5ff..921af318507c 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -83,7 +83,7 @@ int test__backward_ring_buffer(struct test *test __maybe_unused, int subtest __m
 	int ret = TEST_SKIP, err, sample_count = 0, comm_count = 0;
 	char pid[16], sbuf[STRERR_BUFSIZE];
 	struct perf_evlist *evlist;
-	struct perf_evsel *evsel __maybe_unused;
+	struct evsel *evsel __maybe_unused;
 	struct parse_events_error parse_error;
 	struct record_opts opts = {
 		.target = {
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 88c218eacc43..062d23bba2df 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -555,7 +555,7 @@ static int do_test_code_reading(bool try_kcore)
 	struct perf_thread_map *threads = NULL;
 	struct perf_cpu_map *cpus = NULL;
 	struct perf_evlist *evlist = NULL;
-	struct perf_evsel *evsel = NULL;
+	struct evsel *evsel = NULL;
 	int err = -1, ret;
 	pid_t pid;
 	struct map *map;
diff --git a/tools/perf/tests/event-times.c b/tools/perf/tests/event-times.c
index 684ad56f7b0f..45fe674233d7 100644
--- a/tools/perf/tests/event-times.c
+++ b/tools/perf/tests/event-times.c
@@ -14,7 +14,7 @@
 
 static int attach__enable_on_exec(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__last(evlist);
+	struct evsel *evsel = perf_evlist__last(evlist);
 	struct target target = {
 		.uid = UINT_MAX,
 	};
@@ -56,7 +56,7 @@ static int detach__enable_on_exec(struct perf_evlist *evlist)
 
 static int attach__current_disabled(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__last(evlist);
+	struct evsel *evsel = perf_evlist__last(evlist);
 	struct perf_thread_map *threads;
 	int err;
 
@@ -82,7 +82,7 @@ static int attach__current_disabled(struct perf_evlist *evlist)
 
 static int attach__current_enabled(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__last(evlist);
+	struct evsel *evsel = perf_evlist__last(evlist);
 	struct perf_thread_map *threads;
 	int err;
 
@@ -102,14 +102,14 @@ static int attach__current_enabled(struct perf_evlist *evlist)
 
 static int detach__disable(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__last(evlist);
+	struct evsel *evsel = perf_evlist__last(evlist);
 
 	return perf_evsel__enable(evsel);
 }
 
 static int attach__cpu_disabled(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__last(evlist);
+	struct evsel *evsel = perf_evlist__last(evlist);
 	struct perf_cpu_map *cpus;
 	int err;
 
@@ -138,7 +138,7 @@ static int attach__cpu_disabled(struct perf_evlist *evlist)
 
 static int attach__cpu_enabled(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__last(evlist);
+	struct evsel *evsel = perf_evlist__last(evlist);
 	struct perf_cpu_map *cpus;
 	int err;
 
@@ -163,7 +163,7 @@ static int test_times(int (attach)(struct perf_evlist *),
 {
 	struct perf_counts_values count;
 	struct perf_evlist *evlist = NULL;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	int err = -1, i;
 
 	evlist = perf_evlist__new();
diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
index b5042f019ec4..0e5a2e8195e4 100644
--- a/tools/perf/tests/event_update.c
+++ b/tools/perf/tests/event_update.c
@@ -80,7 +80,7 @@ static int process_event_cpus(struct perf_tool *tool __maybe_unused,
 int test__event_update(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct perf_evlist *evlist;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	struct event_name tmp;
 
 	evlist = perf_evlist__new_default();
diff --git a/tools/perf/tests/evsel-roundtrip-name.c b/tools/perf/tests/evsel-roundtrip-name.c
index a104728ebf25..bb38489eda1e 100644
--- a/tools/perf/tests/evsel-roundtrip-name.c
+++ b/tools/perf/tests/evsel-roundtrip-name.c
@@ -11,7 +11,7 @@ static int perf_evsel__roundtrip_cache_name_test(void)
 {
 	char name[128];
 	int type, op, err = 0, ret = 0, i, idx;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	struct perf_evlist *evlist = perf_evlist__new();
 
         if (evlist == NULL)
@@ -67,7 +67,7 @@ static int perf_evsel__roundtrip_cache_name_test(void)
 static int __perf_evsel__name_array_test(const char *names[], int nr_names)
 {
 	int i, err;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	struct perf_evlist *evlist = perf_evlist__new();
 
         if (evlist == NULL)
diff --git a/tools/perf/tests/evsel-tp-sched.c b/tools/perf/tests/evsel-tp-sched.c
index 71f60c0f9faa..0170e9d2e329 100644
--- a/tools/perf/tests/evsel-tp-sched.c
+++ b/tools/perf/tests/evsel-tp-sched.c
@@ -5,7 +5,7 @@
 #include "tests.h"
 #include "debug.h"
 
-static int perf_evsel__test_field(struct perf_evsel *evsel, const char *name,
+static int perf_evsel__test_field(struct evsel *evsel, const char *name,
 				  int size, bool should_be_signed)
 {
 	struct tep_format_field *field = perf_evsel__field(evsel, name);
@@ -35,7 +35,7 @@ static int perf_evsel__test_field(struct perf_evsel *evsel, const char *name,
 
 int test__perf_evsel__tp_sched_test(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
-	struct perf_evsel *evsel = perf_evsel__newtp("sched", "sched_switch");
+	struct evsel *evsel = perf_evsel__newtp("sched", "sched_switch");
 	int ret = 0;
 
 	if (IS_ERR(evsel)) {
diff --git a/tools/perf/tests/hists_cumulate.c b/tools/perf/tests/hists_cumulate.c
index 7a2eed6c783e..b62bf7c3bea2 100644
--- a/tools/perf/tests/hists_cumulate.c
+++ b/tools/perf/tests/hists_cumulate.c
@@ -80,7 +80,7 @@ static u64 fake_callchains[][10] = {
 static int add_hist_entries(struct hists *hists, struct machine *machine)
 {
 	struct addr_location al;
-	struct perf_evsel *evsel = hists_to_evsel(hists);
+	struct evsel *evsel = hists_to_evsel(hists);
 	struct perf_sample sample = { .period = 1000, };
 	size_t i;
 
@@ -147,7 +147,7 @@ static void del_hist_entries(struct hists *hists)
 	}
 }
 
-typedef int (*test_fn_t)(struct perf_evsel *, struct machine *);
+typedef int (*test_fn_t)(struct evsel *, struct machine *);
 
 #define COMM(he)  (thread__comm_str(he->thread))
 #define DSO(he)   (he->ms.map->dso->short_name)
@@ -247,7 +247,7 @@ static int do_test(struct hists *hists, struct result *expected, size_t nr_expec
 }
 
 /* NO callchain + NO children */
-static int test1(struct perf_evsel *evsel, struct machine *machine)
+static int test1(struct evsel *evsel, struct machine *machine)
 {
 	int err;
 	struct hists *hists = evsel__hists(evsel);
@@ -298,7 +298,7 @@ static int test1(struct perf_evsel *evsel, struct machine *machine)
 }
 
 /* callcain + NO children */
-static int test2(struct perf_evsel *evsel, struct machine *machine)
+static int test2(struct evsel *evsel, struct machine *machine)
 {
 	int err;
 	struct hists *hists = evsel__hists(evsel);
@@ -446,7 +446,7 @@ static int test2(struct perf_evsel *evsel, struct machine *machine)
 }
 
 /* NO callchain + children */
-static int test3(struct perf_evsel *evsel, struct machine *machine)
+static int test3(struct evsel *evsel, struct machine *machine)
 {
 	int err;
 	struct hists *hists = evsel__hists(evsel);
@@ -503,7 +503,7 @@ static int test3(struct perf_evsel *evsel, struct machine *machine)
 }
 
 /* callchain + children */
-static int test4(struct perf_evsel *evsel, struct machine *machine)
+static int test4(struct evsel *evsel, struct machine *machine)
 {
 	int err;
 	struct hists *hists = evsel__hists(evsel);
@@ -694,7 +694,7 @@ int test__hists_cumulate(struct test *test __maybe_unused, int subtest __maybe_u
 	int err = TEST_FAIL;
 	struct machines machines;
 	struct machine *machine;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	struct perf_evlist *evlist = perf_evlist__new();
 	size_t i;
 	test_fn_t testcases[] = {
diff --git a/tools/perf/tests/hists_filter.c b/tools/perf/tests/hists_filter.c
index 975844807fe2..3e679bb8da7f 100644
--- a/tools/perf/tests/hists_filter.c
+++ b/tools/perf/tests/hists_filter.c
@@ -50,7 +50,7 @@ static struct sample fake_samples[] = {
 static int add_hist_entries(struct perf_evlist *evlist,
 			    struct machine *machine)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	struct addr_location al;
 	struct perf_sample sample = { .period = 100, };
 	size_t i;
@@ -108,7 +108,7 @@ int test__hists_filter(struct test *test __maybe_unused, int subtest __maybe_unu
 	int err = TEST_FAIL;
 	struct machines machines;
 	struct machine *machine;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	struct perf_evlist *evlist = perf_evlist__new();
 
 	TEST_ASSERT_VAL("No memory", evlist);
diff --git a/tools/perf/tests/hists_link.c b/tools/perf/tests/hists_link.c
index af633db63f4d..078ee9876980 100644
--- a/tools/perf/tests/hists_link.c
+++ b/tools/perf/tests/hists_link.c
@@ -64,7 +64,7 @@ static struct sample fake_samples[][5] = {
 
 static int add_hist_entries(struct perf_evlist *evlist, struct machine *machine)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	struct addr_location al;
 	struct hist_entry *he;
 	struct perf_sample sample = { .period = 1, .weight = 1, };
@@ -271,7 +271,7 @@ int test__hists_link(struct test *test __maybe_unused, int subtest __maybe_unuse
 	struct hists *hists, *first_hists;
 	struct machines machines;
 	struct machine *machine = NULL;
-	struct perf_evsel *evsel, *first;
+	struct evsel *evsel, *first;
 	struct perf_evlist *evlist = perf_evlist__new();
 
 	if (evlist == NULL)
diff --git a/tools/perf/tests/hists_output.c b/tools/perf/tests/hists_output.c
index 0a510c524a5d..5cd4b1baa9d1 100644
--- a/tools/perf/tests/hists_output.c
+++ b/tools/perf/tests/hists_output.c
@@ -50,7 +50,7 @@ static struct sample fake_samples[] = {
 static int add_hist_entries(struct hists *hists, struct machine *machine)
 {
 	struct addr_location al;
-	struct perf_evsel *evsel = hists_to_evsel(hists);
+	struct evsel *evsel = hists_to_evsel(hists);
 	struct perf_sample sample = { .period = 100, };
 	size_t i;
 
@@ -113,7 +113,7 @@ static void del_hist_entries(struct hists *hists)
 	}
 }
 
-typedef int (*test_fn_t)(struct perf_evsel *, struct machine *);
+typedef int (*test_fn_t)(struct evsel *, struct machine *);
 
 #define COMM(he)  (thread__comm_str(he->thread))
 #define DSO(he)   (he->ms.map->dso->short_name)
@@ -122,7 +122,7 @@ typedef int (*test_fn_t)(struct perf_evsel *, struct machine *);
 #define PID(he)   (he->thread->tid)
 
 /* default sort keys (no field) */
-static int test1(struct perf_evsel *evsel, struct machine *machine)
+static int test1(struct evsel *evsel, struct machine *machine)
 {
 	int err;
 	struct hists *hists = evsel__hists(evsel);
@@ -224,7 +224,7 @@ static int test1(struct perf_evsel *evsel, struct machine *machine)
 }
 
 /* mixed fields and sort keys */
-static int test2(struct perf_evsel *evsel, struct machine *machine)
+static int test2(struct evsel *evsel, struct machine *machine)
 {
 	int err;
 	struct hists *hists = evsel__hists(evsel);
@@ -280,7 +280,7 @@ static int test2(struct perf_evsel *evsel, struct machine *machine)
 }
 
 /* fields only (no sort key) */
-static int test3(struct perf_evsel *evsel, struct machine *machine)
+static int test3(struct evsel *evsel, struct machine *machine)
 {
 	int err;
 	struct hists *hists = evsel__hists(evsel);
@@ -354,7 +354,7 @@ static int test3(struct perf_evsel *evsel, struct machine *machine)
 }
 
 /* handle duplicate 'dso' field */
-static int test4(struct perf_evsel *evsel, struct machine *machine)
+static int test4(struct evsel *evsel, struct machine *machine)
 {
 	int err;
 	struct hists *hists = evsel__hists(evsel);
@@ -456,7 +456,7 @@ static int test4(struct perf_evsel *evsel, struct machine *machine)
 }
 
 /* full sort keys w/o overhead field */
-static int test5(struct perf_evsel *evsel, struct machine *machine)
+static int test5(struct evsel *evsel, struct machine *machine)
 {
 	int err;
 	struct hists *hists = evsel__hists(evsel);
@@ -580,7 +580,7 @@ int test__hists_output(struct test *test __maybe_unused, int subtest __maybe_unu
 	int err = TEST_FAIL;
 	struct machines machines;
 	struct machine *machine;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	struct perf_evlist *evlist = perf_evlist__new();
 	size_t i;
 	test_fn_t testcases[] = {
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index e1e5e32cbb53..8ada3e63f1ba 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -68,7 +68,7 @@ int test__keep_tracking(struct test *test __maybe_unused, int subtest __maybe_un
 	struct perf_thread_map *threads = NULL;
 	struct perf_cpu_map *cpus = NULL;
 	struct perf_evlist *evlist = NULL;
-	struct perf_evsel *evsel = NULL;
+	struct evsel *evsel = NULL;
 	int found, err = -1;
 	const char *comm;
 
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index c1e2fe087b67..76ee42eb1355 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -36,7 +36,7 @@ int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unuse
 #define nsyscalls ARRAY_SIZE(syscall_names)
 	unsigned int nr_events[nsyscalls],
 		     expected_nr_events[nsyscalls], i, j;
-	struct perf_evsel *evsels[nsyscalls], *evsel;
+	struct evsel *evsels[nsyscalls], *evsel;
 	char sbuf[STRERR_BUFSIZE];
 	struct perf_mmap *md;
 
diff --git a/tools/perf/tests/openat-syscall-all-cpus.c b/tools/perf/tests/openat-syscall-all-cpus.c
index 9cd5bf63bec1..4bf73896695a 100644
--- a/tools/perf/tests/openat-syscall-all-cpus.c
+++ b/tools/perf/tests/openat-syscall-all-cpus.c
@@ -21,7 +21,7 @@ int test__openat_syscall_event_on_all_cpus(struct test *test __maybe_unused, int
 {
 	int err = -1, fd, cpu;
 	struct perf_cpu_map *cpus;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	unsigned int nr_openat_calls = 111, i;
 	cpu_set_t cpu_set;
 	struct perf_thread_map *threads = thread_map__new(-1, getpid(), UINT_MAX);
diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index 344dc3ac2469..2e467448e220 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -33,7 +33,7 @@ int test__syscall_openat_tp_fields(struct test *test __maybe_unused, int subtest
 	const char *filename = "/etc/passwd";
 	int flags = O_RDONLY | O_DIRECTORY;
 	struct perf_evlist *evlist = perf_evlist__new();
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	int err = -1, i, nr_events = 0, nr_polls = 0;
 	char sbuf[STRERR_BUFSIZE];
 
diff --git a/tools/perf/tests/openat-syscall.c b/tools/perf/tests/openat-syscall.c
index 652b8328ca93..f3efadd05863 100644
--- a/tools/perf/tests/openat-syscall.c
+++ b/tools/perf/tests/openat-syscall.c
@@ -14,7 +14,7 @@
 int test__openat_syscall_event(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	int err = -1, fd;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	unsigned int nr_openat_calls = 111, i;
 	struct perf_thread_map *threads = thread_map__new(-1, getpid(), UINT_MAX);
 	char sbuf[STRERR_BUFSIZE];
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 8f3c80e13584..f55ab43d51bd 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -46,7 +46,7 @@ static bool kvm_s390_create_vm_valid(void)
 
 static int test__checkevent_tracepoint(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->nr_entries);
 	TEST_ASSERT_VAL("wrong number of groups", 0 == evlist->nr_groups);
@@ -59,7 +59,7 @@ static int test__checkevent_tracepoint(struct perf_evlist *evlist)
 
 static int test__checkevent_tracepoint_multi(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	TEST_ASSERT_VAL("wrong number of entries", evlist->nr_entries > 1);
 	TEST_ASSERT_VAL("wrong number of groups", 0 == evlist->nr_groups);
@@ -77,7 +77,7 @@ static int test__checkevent_tracepoint_multi(struct perf_evlist *evlist)
 
 static int test__checkevent_raw(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->attr.type);
@@ -87,7 +87,7 @@ static int test__checkevent_raw(struct perf_evlist *evlist)
 
 static int test__checkevent_numeric(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->nr_entries);
 	TEST_ASSERT_VAL("wrong type", 1 == evsel->attr.type);
@@ -97,7 +97,7 @@ static int test__checkevent_numeric(struct perf_evlist *evlist)
 
 static int test__checkevent_symbolic_name(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->attr.type);
@@ -108,7 +108,7 @@ static int test__checkevent_symbolic_name(struct perf_evlist *evlist)
 
 static int test__checkevent_symbolic_name_config(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->attr.type);
@@ -129,7 +129,7 @@ static int test__checkevent_symbolic_name_config(struct perf_evlist *evlist)
 
 static int test__checkevent_symbolic_alias(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->attr.type);
@@ -140,7 +140,7 @@ static int test__checkevent_symbolic_alias(struct perf_evlist *evlist)
 
 static int test__checkevent_genhw(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HW_CACHE == evsel->attr.type);
@@ -150,7 +150,7 @@ static int test__checkevent_genhw(struct perf_evlist *evlist)
 
 static int test__checkevent_breakpoint(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->attr.type);
@@ -164,7 +164,7 @@ static int test__checkevent_breakpoint(struct perf_evlist *evlist)
 
 static int test__checkevent_breakpoint_x(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->attr.type);
@@ -177,7 +177,7 @@ static int test__checkevent_breakpoint_x(struct perf_evlist *evlist)
 
 static int test__checkevent_breakpoint_r(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->nr_entries);
 	TEST_ASSERT_VAL("wrong type",
@@ -192,7 +192,7 @@ static int test__checkevent_breakpoint_r(struct perf_evlist *evlist)
 
 static int test__checkevent_breakpoint_w(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->nr_entries);
 	TEST_ASSERT_VAL("wrong type",
@@ -207,7 +207,7 @@ static int test__checkevent_breakpoint_w(struct perf_evlist *evlist)
 
 static int test__checkevent_breakpoint_rw(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->nr_entries);
 	TEST_ASSERT_VAL("wrong type",
@@ -222,7 +222,7 @@ static int test__checkevent_breakpoint_rw(struct perf_evlist *evlist)
 
 static int test__checkevent_tracepoint_modifier(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong exclude_user", evsel->attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->attr.exclude_kernel);
@@ -235,7 +235,7 @@ static int test__checkevent_tracepoint_modifier(struct perf_evlist *evlist)
 static int
 test__checkevent_tracepoint_multi_modifier(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	TEST_ASSERT_VAL("wrong number of entries", evlist->nr_entries > 1);
 
@@ -253,7 +253,7 @@ test__checkevent_tracepoint_multi_modifier(struct perf_evlist *evlist)
 
 static int test__checkevent_raw_modifier(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong exclude_user", evsel->attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->attr.exclude_kernel);
@@ -265,7 +265,7 @@ static int test__checkevent_raw_modifier(struct perf_evlist *evlist)
 
 static int test__checkevent_numeric_modifier(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong exclude_user", evsel->attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->attr.exclude_kernel);
@@ -277,7 +277,7 @@ static int test__checkevent_numeric_modifier(struct perf_evlist *evlist)
 
 static int test__checkevent_symbolic_name_modifier(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong exclude_user", evsel->attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->attr.exclude_kernel);
@@ -289,7 +289,7 @@ static int test__checkevent_symbolic_name_modifier(struct perf_evlist *evlist)
 
 static int test__checkevent_exclude_host_modifier(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong exclude guest", !evsel->attr.exclude_guest);
 	TEST_ASSERT_VAL("wrong exclude host", evsel->attr.exclude_host);
@@ -299,7 +299,7 @@ static int test__checkevent_exclude_host_modifier(struct perf_evlist *evlist)
 
 static int test__checkevent_exclude_guest_modifier(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong exclude guest", evsel->attr.exclude_guest);
 	TEST_ASSERT_VAL("wrong exclude host", !evsel->attr.exclude_host);
@@ -309,7 +309,7 @@ static int test__checkevent_exclude_guest_modifier(struct perf_evlist *evlist)
 
 static int test__checkevent_symbolic_alias_modifier(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->attr.exclude_kernel);
@@ -321,7 +321,7 @@ static int test__checkevent_symbolic_alias_modifier(struct perf_evlist *evlist)
 
 static int test__checkevent_genhw_modifier(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong exclude_user", evsel->attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->attr.exclude_kernel);
@@ -333,7 +333,7 @@ static int test__checkevent_genhw_modifier(struct perf_evlist *evlist)
 
 static int test__checkevent_exclude_idle_modifier(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong exclude idle", evsel->attr.exclude_idle);
 	TEST_ASSERT_VAL("wrong exclude guest", !evsel->attr.exclude_guest);
@@ -348,7 +348,7 @@ static int test__checkevent_exclude_idle_modifier(struct perf_evlist *evlist)
 
 static int test__checkevent_exclude_idle_modifier_1(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong exclude idle", evsel->attr.exclude_idle);
 	TEST_ASSERT_VAL("wrong exclude guest", !evsel->attr.exclude_guest);
@@ -363,7 +363,7 @@ static int test__checkevent_exclude_idle_modifier_1(struct perf_evlist *evlist)
 
 static int test__checkevent_breakpoint_modifier(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->attr.exclude_user);
@@ -378,7 +378,7 @@ static int test__checkevent_breakpoint_modifier(struct perf_evlist *evlist)
 
 static int test__checkevent_breakpoint_x_modifier(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong exclude_user", evsel->attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->attr.exclude_kernel);
@@ -392,7 +392,7 @@ static int test__checkevent_breakpoint_x_modifier(struct perf_evlist *evlist)
 
 static int test__checkevent_breakpoint_r_modifier(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong exclude_user", evsel->attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->attr.exclude_kernel);
@@ -406,7 +406,7 @@ static int test__checkevent_breakpoint_r_modifier(struct perf_evlist *evlist)
 
 static int test__checkevent_breakpoint_w_modifier(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->attr.exclude_kernel);
@@ -420,7 +420,7 @@ static int test__checkevent_breakpoint_w_modifier(struct perf_evlist *evlist)
 
 static int test__checkevent_breakpoint_rw_modifier(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong exclude_user", evsel->attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->attr.exclude_kernel);
@@ -435,7 +435,7 @@ static int test__checkevent_breakpoint_rw_modifier(struct perf_evlist *evlist)
 static int test__checkevent_pmu(struct perf_evlist *evlist)
 {
 
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->attr.type);
@@ -453,7 +453,7 @@ static int test__checkevent_pmu(struct perf_evlist *evlist)
 
 static int test__checkevent_list(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong number of entries", 3 == evlist->nr_entries);
 
@@ -492,7 +492,7 @@ static int test__checkevent_list(struct perf_evlist *evlist)
 
 static int test__checkevent_pmu_name(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 	/* cpu/config=1,name=krava/u */
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->nr_entries);
@@ -513,7 +513,7 @@ static int test__checkevent_pmu_name(struct perf_evlist *evlist)
 
 static int test__checkevent_pmu_partial_time_callgraph(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 	/* cpu/config=1,call-graph=fp,time,period=100000/ */
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->nr_entries);
@@ -546,7 +546,7 @@ static int test__checkevent_pmu_partial_time_callgraph(struct perf_evlist *evlis
 
 static int test__checkevent_pmu_events(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->attr.type);
@@ -564,7 +564,7 @@ static int test__checkevent_pmu_events(struct perf_evlist *evlist)
 
 static int test__checkevent_pmu_events_mix(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 	/* pmu-event:u */
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->nr_entries);
@@ -636,7 +636,7 @@ static int test__checkterms_simple(struct list_head *terms)
 
 static int test__group1(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel, *leader;
+	struct evsel *evsel, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->nr_entries);
 	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist->nr_groups);
@@ -678,7 +678,7 @@ static int test__group1(struct perf_evlist *evlist)
 
 static int test__group2(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel, *leader;
+	struct evsel *evsel, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries", 3 == evlist->nr_entries);
 	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist->nr_groups);
@@ -733,7 +733,7 @@ static int test__group2(struct perf_evlist *evlist)
 
 static int test__group3(struct perf_evlist *evlist __maybe_unused)
 {
-	struct perf_evsel *evsel, *leader;
+	struct evsel *evsel, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries", 5 == evlist->nr_entries);
 	TEST_ASSERT_VAL("wrong number of groups", 2 == evlist->nr_groups);
@@ -825,7 +825,7 @@ static int test__group3(struct perf_evlist *evlist __maybe_unused)
 
 static int test__group4(struct perf_evlist *evlist __maybe_unused)
 {
-	struct perf_evsel *evsel, *leader;
+	struct evsel *evsel, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->nr_entries);
 	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist->nr_groups);
@@ -869,7 +869,7 @@ static int test__group4(struct perf_evlist *evlist __maybe_unused)
 
 static int test__group5(struct perf_evlist *evlist __maybe_unused)
 {
-	struct perf_evsel *evsel, *leader;
+	struct evsel *evsel, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries", 5 == evlist->nr_entries);
 	TEST_ASSERT_VAL("wrong number of groups", 2 == evlist->nr_groups);
@@ -955,7 +955,7 @@ static int test__group5(struct perf_evlist *evlist __maybe_unused)
 
 static int test__group_gh1(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel, *leader;
+	struct evsel *evsel, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->nr_entries);
 	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist->nr_groups);
@@ -995,7 +995,7 @@ static int test__group_gh1(struct perf_evlist *evlist)
 
 static int test__group_gh2(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel, *leader;
+	struct evsel *evsel, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->nr_entries);
 	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist->nr_groups);
@@ -1035,7 +1035,7 @@ static int test__group_gh2(struct perf_evlist *evlist)
 
 static int test__group_gh3(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel, *leader;
+	struct evsel *evsel, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->nr_entries);
 	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist->nr_groups);
@@ -1075,7 +1075,7 @@ static int test__group_gh3(struct perf_evlist *evlist)
 
 static int test__group_gh4(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel, *leader;
+	struct evsel *evsel, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->nr_entries);
 	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist->nr_groups);
@@ -1115,7 +1115,7 @@ static int test__group_gh4(struct perf_evlist *evlist)
 
 static int test__leader_sample1(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel, *leader;
+	struct evsel *evsel, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries", 3 == evlist->nr_entries);
 
@@ -1168,7 +1168,7 @@ static int test__leader_sample1(struct perf_evlist *evlist)
 
 static int test__leader_sample2(struct perf_evlist *evlist __maybe_unused)
 {
-	struct perf_evsel *evsel, *leader;
+	struct evsel *evsel, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->nr_entries);
 
@@ -1207,7 +1207,7 @@ static int test__leader_sample2(struct perf_evlist *evlist __maybe_unused)
 
 static int test__checkevent_pinned_modifier(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->attr.exclude_kernel);
@@ -1220,7 +1220,7 @@ static int test__checkevent_pinned_modifier(struct perf_evlist *evlist)
 
 static int test__pinned_group(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel, *leader;
+	struct evsel *evsel, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries", 3 == evlist->nr_entries);
 
@@ -1251,7 +1251,7 @@ static int test__pinned_group(struct perf_evlist *evlist)
 
 static int test__checkevent_breakpoint_len(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->attr.type);
@@ -1266,7 +1266,7 @@ static int test__checkevent_breakpoint_len(struct perf_evlist *evlist)
 
 static int test__checkevent_breakpoint_len_w(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->attr.type);
@@ -1282,7 +1282,7 @@ static int test__checkevent_breakpoint_len_w(struct perf_evlist *evlist)
 static int
 test__checkevent_breakpoint_len_rw_modifier(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->attr.exclude_kernel);
@@ -1294,7 +1294,7 @@ test__checkevent_breakpoint_len_rw_modifier(struct perf_evlist *evlist)
 
 static int test__checkevent_precise_max_modifier(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->attr.type);
@@ -1305,7 +1305,7 @@ static int test__checkevent_precise_max_modifier(struct perf_evlist *evlist)
 
 static int test__checkevent_config_symbol(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "insn") == 0);
 	return 0;
@@ -1313,7 +1313,7 @@ static int test__checkevent_config_symbol(struct perf_evlist *evlist)
 
 static int test__checkevent_config_raw(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "rawpmu") == 0);
 	return 0;
@@ -1321,7 +1321,7 @@ static int test__checkevent_config_raw(struct perf_evlist *evlist)
 
 static int test__checkevent_config_num(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "numpmu") == 0);
 	return 0;
@@ -1329,7 +1329,7 @@ static int test__checkevent_config_num(struct perf_evlist *evlist)
 
 static int test__checkevent_config_cache(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "cachepmu") == 0);
 	return 0;
@@ -1342,7 +1342,7 @@ static bool test__intel_pt_valid(void)
 
 static int test__intel_pt(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "intel_pt//u") == 0);
 	return 0;
@@ -1350,7 +1350,7 @@ static int test__intel_pt(struct perf_evlist *evlist)
 
 static int test__checkevent_complex_name(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong complex name parsing", strcmp(evsel->name, "COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks") == 0);
 	return 0;
@@ -1358,7 +1358,7 @@ static int test__checkevent_complex_name(struct perf_evlist *evlist)
 
 static int test__sym_event_slash(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong type", evsel->attr.type == PERF_TYPE_HARDWARE);
 	TEST_ASSERT_VAL("wrong config", evsel->attr.config == PERF_COUNT_HW_CPU_CYCLES);
@@ -1368,7 +1368,7 @@ static int test__sym_event_slash(struct perf_evlist *evlist)
 
 static int test__sym_event_dc(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = perf_evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong type", evsel->attr.type == PERF_TYPE_HARDWARE);
 	TEST_ASSERT_VAL("wrong config", evsel->attr.config == PERF_COUNT_HW_CPU_CYCLES);
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index 07f6bd8ed719..7e576c2db941 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -51,7 +51,7 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 	cpu_set_t cpu_mask;
 	size_t cpu_mask_size = sizeof(cpu_mask);
 	struct perf_evlist *evlist = perf_evlist__new_dummy();
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	struct perf_sample sample;
 	const char *cmd = "sleep";
 	const char *argv[] = { cmd, "1", NULL, };
diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index 361714e2583c..a8cd3ed3c116 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -153,7 +153,7 @@ static bool samples_same(const struct perf_sample *s1,
 
 static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
 {
-	struct perf_evsel evsel = {
+	struct evsel evsel = {
 		.needs_swap = false,
 		.attr = {
 			.sample_type = sample_type,
diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index d57b8d9c1575..620a99aad1e3 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -27,7 +27,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 	int nr_samples = 0;
 	char sbuf[STRERR_BUFSIZE];
 	union perf_event *event;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	struct perf_evlist *evlist;
 	struct perf_event_attr attr = {
 		.type = PERF_TYPE_SOFTWARE,
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 3652c548cc22..a946b9fa60dd 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -52,8 +52,8 @@ static int spin_sleep(void)
 }
 
 struct switch_tracking {
-	struct perf_evsel *switch_evsel;
-	struct perf_evsel *cycles_evsel;
+	struct evsel *switch_evsel;
+	struct evsel *cycles_evsel;
 	pid_t *tids;
 	int nr_tids;
 	int comm_seen[4];
@@ -118,7 +118,7 @@ static int process_sample_event(struct perf_evlist *evlist,
 				struct switch_tracking *switch_tracking)
 {
 	struct perf_sample sample;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	pid_t next_tid, prev_tid;
 	int cpu, err;
 
@@ -330,8 +330,8 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 	struct perf_thread_map *threads = NULL;
 	struct perf_cpu_map *cpus = NULL;
 	struct perf_evlist *evlist = NULL;
-	struct perf_evsel *evsel, *cpu_clocks_evsel, *cycles_evsel;
-	struct perf_evsel *switch_evsel, *tracking_evsel;
+	struct evsel *evsel, *cpu_clocks_evsel, *cycles_evsel;
+	struct evsel *switch_evsel, *tracking_evsel;
 	const char *comm;
 	int err = -1;
 
diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index 9602ff91a3c7..e6fb4b8d8bc2 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -37,7 +37,7 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 {
 	int err = -1;
 	union perf_event *event;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	struct perf_evlist *evlist;
 	struct target target = {
 		.uid		= UINT_MAX,
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index e67880bf1efe..64cc650c4543 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -299,7 +299,7 @@ static void annotate_browser__set_rb_top(struct annotate_browser *browser,
 }
 
 static void annotate_browser__calc_percent(struct annotate_browser *browser,
-					   struct perf_evsel *evsel)
+					   struct evsel *evsel)
 {
 	struct map_symbol *ms = browser->b.priv;
 	struct symbol *sym = ms->sym;
@@ -406,7 +406,7 @@ static int sym_title(struct symbol *sym, struct map *map, char *title,
  * to the calling function.
  */
 static bool annotate_browser__callq(struct annotate_browser *browser,
-				    struct perf_evsel *evsel,
+				    struct evsel *evsel,
 				    struct hist_browser_timer *hbt)
 {
 	struct map_symbol *ms = browser->b.priv;
@@ -455,7 +455,7 @@ struct disasm_line *annotate_browser__find_offset(struct annotate_browser *brows
 }
 
 static bool annotate_browser__jump(struct annotate_browser *browser,
-				   struct perf_evsel *evsel,
+				   struct evsel *evsel,
 				   struct hist_browser_timer *hbt)
 {
 	struct disasm_line *dl = disasm_line(browser->selection);
@@ -656,7 +656,7 @@ switch_percent_type(struct annotation_options *opts, bool base)
 }
 
 static int annotate_browser__run(struct annotate_browser *browser,
-				 struct perf_evsel *evsel,
+				 struct evsel *evsel,
 				 struct hist_browser_timer *hbt)
 {
 	struct rb_node *nd = NULL;
@@ -869,14 +869,14 @@ static int annotate_browser__run(struct annotate_browser *browser,
 	return key;
 }
 
-int map_symbol__tui_annotate(struct map_symbol *ms, struct perf_evsel *evsel,
+int map_symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
 			     struct hist_browser_timer *hbt,
 			     struct annotation_options *opts)
 {
 	return symbol__tui_annotate(ms->sym, ms->map, evsel, hbt, opts);
 }
 
-int hist_entry__tui_annotate(struct hist_entry *he, struct perf_evsel *evsel,
+int hist_entry__tui_annotate(struct hist_entry *he, struct evsel *evsel,
 			     struct hist_browser_timer *hbt,
 			     struct annotation_options *opts)
 {
@@ -888,7 +888,7 @@ int hist_entry__tui_annotate(struct hist_entry *he, struct perf_evsel *evsel,
 }
 
 int symbol__tui_annotate(struct symbol *sym, struct map *map,
-			 struct perf_evsel *evsel,
+			 struct evsel *evsel,
 			 struct hist_browser_timer *hbt,
 			 struct annotation_options *opts)
 {
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index a94eb0755e8b..9bc818621eb6 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2187,7 +2187,7 @@ struct hist_browser *hist_browser__new(struct hists *hists)
 }
 
 static struct hist_browser *
-perf_evsel_browser__new(struct perf_evsel *evsel,
+perf_evsel_browser__new(struct evsel *evsel,
 			struct hist_browser_timer *hbt,
 			struct perf_env *env,
 			struct annotation_options *annotation_opts)
@@ -2352,7 +2352,7 @@ struct popup_action {
 	struct thread 		*thread;
 	struct map_symbol 	ms;
 	int			socket;
-	struct perf_evsel	*evsel;
+	struct evsel	*evsel;
 	enum rstype		rstype;
 
 	int (*fn)(struct hist_browser *browser, struct popup_action *act);
@@ -2361,7 +2361,7 @@ struct popup_action {
 static int
 do_annotate(struct hist_browser *browser, struct popup_action *act)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	struct annotation *notes;
 	struct hist_entry *he;
 	int err;
@@ -2596,7 +2596,7 @@ static int
 add_script_opt_2(struct hist_browser *browser __maybe_unused,
 	       struct popup_action *act, char **optstr,
 	       struct thread *thread, struct symbol *sym,
-	       struct perf_evsel *evsel, const char *tstr)
+	       struct evsel *evsel, const char *tstr)
 {
 
 	if (thread) {
@@ -2623,7 +2623,7 @@ static int
 add_script_opt(struct hist_browser *browser,
 	       struct popup_action *act, char **optstr,
 	       struct thread *thread, struct symbol *sym,
-	       struct perf_evsel *evsel)
+	       struct evsel *evsel)
 {
 	int n, j;
 	struct hist_entry *he;
@@ -2653,7 +2653,7 @@ static int
 add_res_sample_opt(struct hist_browser *browser __maybe_unused,
 		   struct popup_action *act, char **optstr,
 		   struct res_sample *res_sample,
-		   struct perf_evsel *evsel,
+		   struct evsel *evsel,
 		   enum rstype type)
 {
 	if (!res_sample)
@@ -2814,7 +2814,7 @@ static void hist_browser__update_percent_limit(struct hist_browser *hb,
 	}
 }
 
-static int perf_evsel__hists_browse(struct perf_evsel *evsel, int nr_events,
+static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
 				    const char *helpline,
 				    bool left_exits,
 				    struct hist_browser_timer *hbt,
@@ -3198,9 +3198,9 @@ static int perf_evsel__hists_browse(struct perf_evsel *evsel, int nr_events,
 	return key;
 }
 
-struct perf_evsel_menu {
+struct evsel_menu {
 	struct ui_browser b;
-	struct perf_evsel *selection;
+	struct evsel *selection;
 	struct annotation_options *annotation_opts;
 	bool lost_events, lost_events_warned;
 	float min_pcnt;
@@ -3210,9 +3210,9 @@ struct perf_evsel_menu {
 static void perf_evsel_menu__write(struct ui_browser *browser,
 				   void *entry, int row)
 {
-	struct perf_evsel_menu *menu = container_of(browser,
-						    struct perf_evsel_menu, b);
-	struct perf_evsel *evsel = list_entry(entry, struct perf_evsel, node);
+	struct evsel_menu *menu = container_of(browser,
+						    struct evsel_menu, b);
+	struct evsel *evsel = list_entry(entry, struct evsel, node);
 	struct hists *hists = evsel__hists(evsel);
 	bool current_entry = ui_browser__is_current_entry(browser, row);
 	unsigned long nr_events = hists->stats.nr_events[PERF_RECORD_SAMPLE];
@@ -3225,7 +3225,7 @@ static void perf_evsel_menu__write(struct ui_browser *browser,
 						       HE_COLORSET_NORMAL);
 
 	if (perf_evsel__is_group_event(evsel)) {
-		struct perf_evsel *pos;
+		struct evsel *pos;
 
 		ev_name = perf_evsel__group_name(evsel);
 
@@ -3257,13 +3257,13 @@ static void perf_evsel_menu__write(struct ui_browser *browser,
 		menu->selection = evsel;
 }
 
-static int perf_evsel_menu__run(struct perf_evsel_menu *menu,
+static int perf_evsel_menu__run(struct evsel_menu *menu,
 				int nr_events, const char *help,
 				struct hist_browser_timer *hbt,
 				bool warn_lost_event)
 {
 	struct perf_evlist *evlist = menu->b.priv;
-	struct perf_evsel *pos;
+	struct evsel *pos;
 	const char *title = "Available samples";
 	int delay_secs = hbt ? hbt->refresh : 0;
 	int key;
@@ -3351,7 +3351,7 @@ static int perf_evsel_menu__run(struct perf_evsel_menu *menu,
 static bool filter_group_entries(struct ui_browser *browser __maybe_unused,
 				 void *entry)
 {
-	struct perf_evsel *evsel = list_entry(entry, struct perf_evsel, node);
+	struct evsel *evsel = list_entry(entry, struct evsel, node);
 
 	if (symbol_conf.event_group && !perf_evsel__is_group_leader(evsel))
 		return true;
@@ -3367,8 +3367,8 @@ static int __perf_evlist__tui_browse_hists(struct perf_evlist *evlist,
 					   bool warn_lost_event,
 					   struct annotation_options *annotation_opts)
 {
-	struct perf_evsel *pos;
-	struct perf_evsel_menu menu = {
+	struct evsel *pos;
+	struct evsel_menu menu = {
 		.b = {
 			.entries    = &evlist->entries,
 			.refresh    = ui_browser__list_head_refresh,
@@ -3408,7 +3408,7 @@ int perf_evlist__tui_browse_hists(struct perf_evlist *evlist, const char *help,
 
 single_entry:
 	if (nr_entries == 1) {
-		struct perf_evsel *first = perf_evlist__first(evlist);
+		struct evsel *first = perf_evlist__first(evlist);
 
 		return perf_evsel__hists_browse(first, nr_entries, help,
 						false, hbt, min_pcnt,
@@ -3417,7 +3417,7 @@ int perf_evlist__tui_browse_hists(struct perf_evlist *evlist, const char *help,
 	}
 
 	if (symbol_conf.event_group) {
-		struct perf_evsel *pos;
+		struct evsel *pos;
 
 		nr_entries = 0;
 		evlist__for_each_entry(evlist, pos) {
diff --git a/tools/perf/ui/browsers/res_sample.c b/tools/perf/ui/browsers/res_sample.c
index 8aa3547bb9ff..7f3576deafd7 100644
--- a/tools/perf/ui/browsers/res_sample.c
+++ b/tools/perf/ui/browsers/res_sample.c
@@ -24,7 +24,7 @@ void res_sample_init(void)
 }
 
 int res_sample_browse(struct res_sample *res_samples, int num_res,
-		      struct perf_evsel *evsel, enum rstype rstype)
+		      struct evsel *evsel, enum rstype rstype)
 {
 	char **names;
 	int i, n;
diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
index 4d565cc14076..c0462457e9f9 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -78,7 +78,7 @@ static int scripts_config(const char *var, const char *value, void *data)
  * Return -1 on failure.
  */
 static int list_scripts(char *script_name, bool *custom,
-			struct perf_evsel *evsel)
+			struct evsel *evsel)
 {
 	char *buf, *paths[SCRIPT_MAX_NO], *names[SCRIPT_MAX_NO];
 	int i, num, choice;
@@ -162,7 +162,7 @@ void run_script(char *cmd)
 	SLsmg_refresh();
 }
 
-int script_browse(const char *script_opt, struct perf_evsel *evsel)
+int script_browse(const char *script_opt, struct evsel *evsel)
 {
 	char *cmd, script_name[SCRIPT_FULLPATH_LEN];
 	bool custom = false;
diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
index 3af87c18a914..40e263a730e4 100644
--- a/tools/perf/ui/gtk/annotate.c
+++ b/tools/perf/ui/gtk/annotate.c
@@ -91,7 +91,7 @@ static int perf_gtk__get_line(char *buf, size_t size, struct disasm_line *dl)
 }
 
 static int perf_gtk__annotate_symbol(GtkWidget *window, struct symbol *sym,
-				struct map *map, struct perf_evsel *evsel,
+				struct map *map, struct evsel *evsel,
 				struct hist_browser_timer *hbt __maybe_unused)
 {
 	struct disasm_line *pos, *n;
@@ -160,7 +160,7 @@ static int perf_gtk__annotate_symbol(GtkWidget *window, struct symbol *sym,
 }
 
 static int symbol__gtk_annotate(struct symbol *sym, struct map *map,
-				struct perf_evsel *evsel,
+				struct evsel *evsel,
 				struct hist_browser_timer *hbt)
 {
 	GtkWidget *window;
@@ -238,7 +238,7 @@ static int symbol__gtk_annotate(struct symbol *sym, struct map *map,
 }
 
 int hist_entry__gtk_annotate(struct hist_entry *he,
-			     struct perf_evsel *evsel,
+			     struct evsel *evsel,
 			     struct hist_browser_timer *hbt)
 {
 	return symbol__gtk_annotate(he->ms.sym, he->ms.map, evsel, hbt);
diff --git a/tools/perf/ui/gtk/gtk.h b/tools/perf/ui/gtk/gtk.h
index 9846ea5c831b..e2f5fbef3c9a 100644
--- a/tools/perf/ui/gtk/gtk.h
+++ b/tools/perf/ui/gtk/gtk.h
@@ -52,7 +52,7 @@ static inline GtkWidget *perf_gtk__setup_info_bar(void)
 }
 #endif
 
-struct perf_evsel;
+struct evsel;
 struct perf_evlist;
 struct hist_entry;
 struct hist_browser_timer;
@@ -61,7 +61,7 @@ int perf_evlist__gtk_browse_hists(struct perf_evlist *evlist, const char *help,
 				  struct hist_browser_timer *hbt,
 				  float min_pcnt);
 int hist_entry__gtk_annotate(struct hist_entry *he,
-			     struct perf_evsel *evsel,
+			     struct evsel *evsel,
 			     struct hist_browser_timer *hbt);
 void perf_gtk__show_annotations(void);
 
diff --git a/tools/perf/ui/gtk/hists.c b/tools/perf/ui/gtk/hists.c
index 3955ed1d1bd9..d5c9fe230632 100644
--- a/tools/perf/ui/gtk/hists.c
+++ b/tools/perf/ui/gtk/hists.c
@@ -595,7 +595,7 @@ int perf_evlist__gtk_browse_hists(struct perf_evlist *evlist,
 				  struct hist_browser_timer *hbt __maybe_unused,
 				  float min_pcnt)
 {
-	struct perf_evsel *pos;
+	struct evsel *pos;
 	GtkWidget *vbox;
 	GtkWidget *notebook;
 	GtkWidget *info_bar;
diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index 412d6f1626e3..214af526901b 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -25,7 +25,7 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct hist_entry *he,
 {
 	int ret;
 	struct hists *hists = he->hists;
-	struct perf_evsel *evsel = hists_to_evsel(hists);
+	struct evsel *evsel = hists_to_evsel(hists);
 	char *buf = hpp->buf;
 	size_t size = hpp->size;
 
@@ -153,7 +153,7 @@ static int __hpp__sort(struct hist_entry *a, struct hist_entry *b,
 {
 	s64 ret;
 	int i, nr_members;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	struct hist_entry *pair;
 	u64 *fields_a, *fields_b;
 
@@ -223,7 +223,7 @@ static int hpp__width_fn(struct perf_hpp_fmt *fmt,
 			 struct hists *hists)
 {
 	int len = fmt->user_len ?: fmt->len;
-	struct perf_evsel *evsel = hists_to_evsel(hists);
+	struct evsel *evsel = hists_to_evsel(hists);
 
 	if (symbol_conf.event_group)
 		len = max(len, evsel->nr_members * fmt->len);
@@ -797,7 +797,7 @@ static int add_hierarchy_fmt(struct hists *hists, struct perf_hpp_fmt *fmt)
 int perf_hpp__setup_hists_formats(struct perf_hpp_list *list,
 				  struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	struct perf_hpp_fmt *fmt;
 	struct hists *hists;
 	int ret;
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index ac9ad2330f93..6ea5d678a81c 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -929,7 +929,7 @@ struct annotated_source *symbol__hists(struct symbol *sym, int nr_hists)
 }
 
 static int symbol__inc_addr_samples(struct symbol *sym, struct map *map,
-				    struct perf_evsel *evsel, u64 addr,
+				    struct evsel *evsel, u64 addr,
 				    struct perf_sample *sample)
 {
 	struct annotated_source *src;
@@ -1080,13 +1080,13 @@ void annotation__compute_ipc(struct annotation *notes, size_t size)
 }
 
 int addr_map_symbol__inc_samples(struct addr_map_symbol *ams, struct perf_sample *sample,
-				 struct perf_evsel *evsel)
+				 struct evsel *evsel)
 {
 	return symbol__inc_addr_samples(ams->sym, ams->map, evsel, ams->al_addr, sample);
 }
 
 int hist_entry__inc_addr_samples(struct hist_entry *he, struct perf_sample *sample,
-				 struct perf_evsel *evsel, u64 ip)
+				 struct evsel *evsel, u64 ip)
 {
 	return symbol__inc_addr_samples(he->ms.sym, he->ms.map, evsel, ip, sample);
 }
@@ -1134,7 +1134,7 @@ struct annotate_args {
 	size_t			 privsize;
 	struct arch		*arch;
 	struct map_symbol	 ms;
-	struct perf_evsel	*evsel;
+	struct evsel	*evsel;
 	struct annotation_options *options;
 	s64			 offset;
 	char			*line;
@@ -1165,7 +1165,7 @@ static struct annotation_line *
 annotation_line__new(struct annotate_args *args, size_t privsize)
 {
 	struct annotation_line *al;
-	struct perf_evsel *evsel = args->evsel;
+	struct evsel *evsel = args->evsel;
 	size_t size = privsize + sizeof(*al);
 	int nr = 1;
 
@@ -1359,7 +1359,7 @@ static int disasm_line__print(struct disasm_line *dl, u64 start, int addr_fmt_wi
 
 static int
 annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start,
-		       struct perf_evsel *evsel, u64 len, int min_pcnt, int printed,
+		       struct evsel *evsel, u64 len, int min_pcnt, int printed,
 		       int max_lines, struct annotation_line *queue, int addr_fmt_width,
 		       int percent_type)
 {
@@ -2011,10 +2011,10 @@ static void calc_percent(struct sym_hist *sym_hist,
 }
 
 static void annotation__calc_percent(struct annotation *notes,
-				     struct perf_evsel *leader, s64 len)
+				     struct evsel *leader, s64 len)
 {
 	struct annotation_line *al, *next;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	list_for_each_entry(al, &notes->src->source, node) {
 		s64 end;
@@ -2041,7 +2041,7 @@ static void annotation__calc_percent(struct annotation *notes,
 	}
 }
 
-void symbol__calc_percent(struct symbol *sym, struct perf_evsel *evsel)
+void symbol__calc_percent(struct symbol *sym, struct evsel *evsel)
 {
 	struct annotation *notes = symbol__annotation(sym);
 
@@ -2049,7 +2049,7 @@ void symbol__calc_percent(struct symbol *sym, struct perf_evsel *evsel)
 }
 
 int symbol__annotate(struct symbol *sym, struct map *map,
-		     struct perf_evsel *evsel, size_t privsize,
+		     struct evsel *evsel, size_t privsize,
 		     struct annotation_options *options,
 		     struct arch **parch)
 {
@@ -2214,7 +2214,7 @@ static void print_summary(struct rb_root *root, const char *filename)
 	}
 }
 
-static void symbol__annotate_hits(struct symbol *sym, struct perf_evsel *evsel)
+static void symbol__annotate_hits(struct symbol *sym, struct evsel *evsel)
 {
 	struct annotation *notes = symbol__annotation(sym);
 	struct sym_hist *h = annotation__histogram(notes, evsel->idx);
@@ -2241,7 +2241,7 @@ static int annotated_source__addr_fmt_width(struct list_head *lines, u64 start)
 }
 
 int symbol__annotate_printf(struct symbol *sym, struct map *map,
-			    struct perf_evsel *evsel,
+			    struct evsel *evsel,
 			    struct annotation_options *opts)
 {
 	struct dso *dso = map->dso;
@@ -2405,7 +2405,7 @@ static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp,
 	return 0;
 }
 
-int map_symbol__annotation_dump(struct map_symbol *ms, struct perf_evsel *evsel,
+int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evsel,
 				struct annotation_options *opts)
 {
 	const char *ev_name = perf_evsel__name(evsel);
@@ -2657,7 +2657,7 @@ static void symbol__calc_lines(struct symbol *sym, struct map *map,
 }
 
 int symbol__tty_annotate2(struct symbol *sym, struct map *map,
-			  struct perf_evsel *evsel,
+			  struct evsel *evsel,
 			  struct annotation_options *opts)
 {
 	struct dso *dso = map->dso;
@@ -2685,7 +2685,7 @@ int symbol__tty_annotate2(struct symbol *sym, struct map *map,
 }
 
 int symbol__tty_annotate(struct symbol *sym, struct map *map,
-			 struct perf_evsel *evsel,
+			 struct evsel *evsel,
 			 struct annotation_options *opts)
 {
 	struct dso *dso = map->dso;
@@ -2956,7 +2956,7 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
 				 wops->write_graph);
 }
 
-int symbol__annotate2(struct symbol *sym, struct map *map, struct perf_evsel *evsel,
+int symbol__annotate2(struct symbol *sym, struct map *map, struct evsel *evsel,
 		      struct annotation_options *options, struct arch **parch)
 {
 	struct annotation *notes = symbol__annotation(sym);
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 5bc0cf655d37..7c42f320efa2 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -20,7 +20,7 @@ struct map_symbol;
 struct addr_map_symbol;
 struct option;
 struct perf_sample;
-struct perf_evsel;
+struct evsel;
 struct symbol;
 
 struct ins {
@@ -216,12 +216,12 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
 
 int __annotation__scnprintf_samples_period(struct annotation *notes,
 					   char *bf, size_t size,
-					   struct perf_evsel *evsel,
+					   struct evsel *evsel,
 					   bool show_freq);
 
 int disasm_line__scnprintf(struct disasm_line *dl, char *bf, size_t size, bool raw, int max_ins_name);
 size_t disasm__fprintf(struct list_head *head, FILE *fp);
-void symbol__calc_percent(struct symbol *sym, struct perf_evsel *evsel);
+void symbol__calc_percent(struct symbol *sym, struct evsel *evsel);
 
 struct sym_hist {
 	u64		      nr_samples;
@@ -335,24 +335,24 @@ static inline struct annotation *symbol__annotation(struct symbol *sym)
 }
 
 int addr_map_symbol__inc_samples(struct addr_map_symbol *ams, struct perf_sample *sample,
-				 struct perf_evsel *evsel);
+				 struct evsel *evsel);
 
 int addr_map_symbol__account_cycles(struct addr_map_symbol *ams,
 				    struct addr_map_symbol *start,
 				    unsigned cycles);
 
 int hist_entry__inc_addr_samples(struct hist_entry *he, struct perf_sample *sample,
-				 struct perf_evsel *evsel, u64 addr);
+				 struct evsel *evsel, u64 addr);
 
 struct annotated_source *symbol__hists(struct symbol *sym, int nr_hists);
 void symbol__annotate_zero_histograms(struct symbol *sym);
 
 int symbol__annotate(struct symbol *sym, struct map *map,
-		     struct perf_evsel *evsel, size_t privsize,
+		     struct evsel *evsel, size_t privsize,
 		     struct annotation_options *options,
 		     struct arch **parch);
 int symbol__annotate2(struct symbol *sym, struct map *map,
-		      struct perf_evsel *evsel,
+		      struct evsel *evsel,
 		      struct annotation_options *options,
 		      struct arch **parch);
 
@@ -378,32 +378,32 @@ int symbol__strerror_disassemble(struct symbol *sym, struct map *map,
 				 int errnum, char *buf, size_t buflen);
 
 int symbol__annotate_printf(struct symbol *sym, struct map *map,
-			    struct perf_evsel *evsel,
+			    struct evsel *evsel,
 			    struct annotation_options *options);
 void symbol__annotate_zero_histogram(struct symbol *sym, int evidx);
 void symbol__annotate_decay_histogram(struct symbol *sym, int evidx);
 void annotated_source__purge(struct annotated_source *as);
 
-int map_symbol__annotation_dump(struct map_symbol *ms, struct perf_evsel *evsel,
+int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evsel,
 				struct annotation_options *opts);
 
 bool ui__has_annotation(void);
 
 int symbol__tty_annotate(struct symbol *sym, struct map *map,
-			 struct perf_evsel *evsel, struct annotation_options *opts);
+			 struct evsel *evsel, struct annotation_options *opts);
 
 int symbol__tty_annotate2(struct symbol *sym, struct map *map,
-			  struct perf_evsel *evsel, struct annotation_options *opts);
+			  struct evsel *evsel, struct annotation_options *opts);
 
 #ifdef HAVE_SLANG_SUPPORT
 int symbol__tui_annotate(struct symbol *sym, struct map *map,
-			 struct perf_evsel *evsel,
+			 struct evsel *evsel,
 			 struct hist_browser_timer *hbt,
 			 struct annotation_options *opts);
 #else
 static inline int symbol__tui_annotate(struct symbol *sym __maybe_unused,
 				struct map *map __maybe_unused,
-				struct perf_evsel *evsel  __maybe_unused,
+				struct evsel *evsel  __maybe_unused,
 				struct hist_browser_timer *hbt __maybe_unused,
 				struct annotation_options *opts __maybe_unused)
 {
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index ec0af36697c4..98b151bc9a36 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -2084,7 +2084,7 @@ static char *addr_filter__to_str(struct addr_filter *filt)
 	return err < 0 ? NULL : filter;
 }
 
-static int parse_addr_filter(struct perf_evsel *evsel, const char *filter,
+static int parse_addr_filter(struct evsel *evsel, const char *filter,
 			     int max_nr)
 {
 	struct addr_filters filts;
@@ -2135,7 +2135,7 @@ static int parse_addr_filter(struct perf_evsel *evsel, const char *filter,
 	return err;
 }
 
-static struct perf_pmu *perf_evsel__find_pmu(struct perf_evsel *evsel)
+static struct perf_pmu *perf_evsel__find_pmu(struct evsel *evsel)
 {
 	struct perf_pmu *pmu = NULL;
 
@@ -2147,7 +2147,7 @@ static struct perf_pmu *perf_evsel__find_pmu(struct perf_evsel *evsel)
 	return pmu;
 }
 
-static int perf_evsel__nr_addr_filter(struct perf_evsel *evsel)
+static int perf_evsel__nr_addr_filter(struct evsel *evsel)
 {
 	struct perf_pmu *pmu = perf_evsel__find_pmu(evsel);
 	int nr_addr_filters = 0;
@@ -2162,7 +2162,7 @@ static int perf_evsel__nr_addr_filter(struct perf_evsel *evsel)
 
 int auxtrace_parse_filters(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	char *filter;
 	int err, max_nr;
 
diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 6d0dfb777a79..594ea279e25b 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -817,7 +817,7 @@ struct bpf_map_op {
 	} k;
 	union {
 		u64 value;
-		struct perf_evsel *evsel;
+		struct evsel *evsel;
 	} v;
 };
 
@@ -1063,7 +1063,7 @@ __bpf_map__config_event(struct bpf_map *map,
 			struct parse_events_term *term,
 			struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	const struct bpf_map_def *def;
 	struct bpf_map_op *op;
 	const char *map_name = bpf_map__name(map);
@@ -1401,7 +1401,7 @@ apply_config_value_for_key(int map_fd, void *pkey,
 
 static int
 apply_config_evsel_for_key(const char *name, int map_fd, void *pkey,
-			   struct perf_evsel *evsel)
+			   struct evsel *evsel)
 {
 	struct xyarray *xy = evsel->fd;
 	struct perf_event_attr *attr;
@@ -1523,11 +1523,11 @@ int bpf__apply_obj_config(void)
 			(strcmp(name, 			\
 				bpf_map__name(pos)) == 0))
 
-struct perf_evsel *bpf__setup_output_event(struct perf_evlist *evlist, const char *name)
+struct evsel *bpf__setup_output_event(struct perf_evlist *evlist, const char *name)
 {
 	struct bpf_map_priv *tmpl_priv = NULL;
 	struct bpf_object *obj, *tmp;
-	struct perf_evsel *evsel = NULL;
+	struct evsel *evsel = NULL;
 	struct bpf_map *map;
 	int err;
 	bool need_init = false;
@@ -1602,7 +1602,7 @@ struct perf_evsel *bpf__setup_output_event(struct perf_evlist *evlist, const cha
 
 int bpf__setup_stdout(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = bpf__setup_output_event(evlist, "__bpf_stdout__");
+	struct evsel *evsel = bpf__setup_output_event(evlist, "__bpf_stdout__");
 	return PTR_ERR_OR_ZERO(evsel);
 }
 
diff --git a/tools/perf/util/bpf-loader.h b/tools/perf/util/bpf-loader.h
index 8c3441a4b72c..e2048c978a24 100644
--- a/tools/perf/util/bpf-loader.h
+++ b/tools/perf/util/bpf-loader.h
@@ -39,7 +39,7 @@ enum bpf_loader_errno {
 	__BPF_LOADER_ERRNO__END,
 };
 
-struct perf_evsel;
+struct evsel;
 struct perf_evlist;
 struct bpf_object;
 struct parse_events_term;
@@ -80,7 +80,7 @@ int bpf__apply_obj_config(void);
 int bpf__strerror_apply_obj_config(int err, char *buf, size_t size);
 
 int bpf__setup_stdout(struct perf_evlist *evlist);
-struct perf_evsel *bpf__setup_output_event(struct perf_evlist *evlist, const char *name);
+struct evsel *bpf__setup_output_event(struct perf_evlist *evlist, const char *name);
 int bpf__strerror_setup_output_event(struct perf_evlist *evlist, int err, char *buf, size_t size);
 #else
 #include <errno.h>
@@ -137,7 +137,7 @@ bpf__setup_stdout(struct perf_evlist *evlist __maybe_unused)
 	return 0;
 }
 
-static inline struct perf_evsel *
+static inline struct evsel *
 bpf__setup_output_event(struct perf_evlist *evlist __maybe_unused, const char *name __maybe_unused)
 {
 	return NULL;
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index f1abfab7aa8c..b98754863de9 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -37,7 +37,7 @@ static bool no_buildid_cache;
 int build_id__mark_dso_hit(struct perf_tool *tool __maybe_unused,
 			   union perf_event *event,
 			   struct perf_sample *sample,
-			   struct perf_evsel *evsel __maybe_unused,
+			   struct evsel *evsel __maybe_unused,
 			   struct machine *machine)
 {
 	struct addr_location al;
diff --git a/tools/perf/util/build-id.h b/tools/perf/util/build-id.h
index 93668f38f1ed..aad419bb165c 100644
--- a/tools/perf/util/build-id.h
+++ b/tools/perf/util/build-id.h
@@ -24,7 +24,7 @@ char *dso__build_id_filename(const struct dso *dso, char *bf, size_t size,
 			     bool is_debug);
 
 int build_id__mark_dso_hit(struct perf_tool *tool, union perf_event *event,
-			   struct perf_sample *sample, struct perf_evsel *evsel,
+			   struct perf_sample *sample, struct evsel *evsel,
 			   struct machine *machine);
 
 int dsos__hit_all(struct perf_session *session);
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 8d7d8f62fcca..d077704f9afa 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1077,7 +1077,7 @@ int callchain_cursor_append(struct callchain_cursor *cursor,
 
 int sample__resolve_callchain(struct perf_sample *sample,
 			      struct callchain_cursor *cursor, struct symbol **parent,
-			      struct perf_evsel *evsel, struct addr_location *al,
+			      struct evsel *evsel, struct addr_location *al,
 			      int max_stack)
 {
 	if (sample->callchain == NULL && !symbol_conf.show_branchflag_count)
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index 80e056a3d882..45b9ed49e2b1 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -236,7 +236,7 @@ int record_opts__parse_callchain(struct record_opts *record,
 
 int sample__resolve_callchain(struct perf_sample *sample,
 			      struct callchain_cursor *cursor, struct symbol **parent,
-			      struct perf_evsel *evsel, struct addr_location *al,
+			      struct evsel *evsel, struct addr_location *al,
 			      int max_stack);
 int hist_entry__append_callchain(struct hist_entry *he, struct perf_sample *sample);
 int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *node,
diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index 484c29830a81..4f5c326a9477 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -92,7 +92,7 @@ static int open_cgroup(const char *name)
 
 static struct cgroup *evlist__find_cgroup(struct perf_evlist *evlist, const char *str)
 {
-	struct perf_evsel *counter;
+	struct evsel *counter;
 	/*
 	 * check if cgrp is already defined, if so we reuse it
 	 */
@@ -139,7 +139,7 @@ struct cgroup *evlist__findnew_cgroup(struct perf_evlist *evlist, const char *na
 
 static int add_cgroup(struct perf_evlist *evlist, const char *str)
 {
-	struct perf_evsel *counter;
+	struct evsel *counter;
 	struct cgroup *cgrp = evlist__findnew_cgroup(evlist, str);
 	int n;
 
@@ -184,7 +184,7 @@ struct cgroup *cgroup__get(struct cgroup *cgroup)
        return cgroup;
 }
 
-static void evsel__set_default_cgroup(struct perf_evsel *evsel, struct cgroup *cgroup)
+static void evsel__set_default_cgroup(struct evsel *evsel, struct cgroup *cgroup)
 {
 	if (evsel->cgrp == NULL)
 		evsel->cgrp = cgroup__get(cgroup);
@@ -192,7 +192,7 @@ static void evsel__set_default_cgroup(struct perf_evsel *evsel, struct cgroup *c
 
 void evlist__set_default_cgroup(struct perf_evlist *evlist, struct cgroup *cgroup)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel)
 		evsel__set_default_cgroup(evsel, cgroup);
@@ -202,7 +202,7 @@ int parse_cgroups(const struct option *opt, const char *str,
 		  int unset __maybe_unused)
 {
 	struct perf_evlist *evlist = *(struct perf_evlist **)opt->value;
-	struct perf_evsel *counter;
+	struct evsel *counter;
 	struct cgroup *cgrp = NULL;
 	const char *p, *e, *eos = str + strlen(str);
 	char *s;
diff --git a/tools/perf/util/counts.c b/tools/perf/util/counts.c
index 01ee81df3fe5..f94e1a23dad6 100644
--- a/tools/perf/util/counts.c
+++ b/tools/perf/util/counts.c
@@ -48,18 +48,18 @@ static void perf_counts__reset(struct perf_counts *counts)
 	xyarray__reset(counts->values);
 }
 
-void perf_evsel__reset_counts(struct perf_evsel *evsel)
+void perf_evsel__reset_counts(struct evsel *evsel)
 {
 	perf_counts__reset(evsel->counts);
 }
 
-int perf_evsel__alloc_counts(struct perf_evsel *evsel, int ncpus, int nthreads)
+int perf_evsel__alloc_counts(struct evsel *evsel, int ncpus, int nthreads)
 {
 	evsel->counts = perf_counts__new(ncpus, nthreads);
 	return evsel->counts != NULL ? 0 : -ENOMEM;
 }
 
-void perf_evsel__free_counts(struct perf_evsel *evsel)
+void perf_evsel__free_counts(struct evsel *evsel)
 {
 	perf_counts__delete(evsel->counts);
 	evsel->counts = NULL;
diff --git a/tools/perf/util/counts.h b/tools/perf/util/counts.h
index 460b56ce3252..0f0cb2d8f70d 100644
--- a/tools/perf/util/counts.h
+++ b/tools/perf/util/counts.h
@@ -44,8 +44,8 @@ perf_counts__set_loaded(struct perf_counts *counts, int cpu, int thread, bool lo
 struct perf_counts *perf_counts__new(int ncpus, int nthreads);
 void perf_counts__delete(struct perf_counts *counts);
 
-void perf_evsel__reset_counts(struct perf_evsel *evsel);
-int perf_evsel__alloc_counts(struct perf_evsel *evsel, int ncpus, int nthreads);
-void perf_evsel__free_counts(struct perf_evsel *evsel);
+void perf_evsel__reset_counts(struct evsel *evsel);
+int perf_evsel__alloc_counts(struct evsel *evsel, int ncpus, int nthreads);
+void perf_evsel__free_counts(struct evsel *evsel);
 
 #endif /* __PERF_COUNTS_H */
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 3d1c34fc4d68..5a9fcb60ec88 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1223,7 +1223,7 @@ static int cs_etm__synth_events(struct cs_etm_auxtrace *etm,
 				struct perf_session *session)
 {
 	struct perf_evlist *evlist = session->evlist;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	struct perf_event_attr attr;
 	bool found = false;
 	u64 id;
@@ -2294,7 +2294,7 @@ static int cs_etm__process_auxtrace_event(struct perf_session *session,
 
 static bool cs_etm__is_timeless_decoding(struct cs_etm_auxtrace *etm)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	struct perf_evlist *evlist = etm->session->evlist;
 	bool timeless_decoding = true;
 
diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index ddbcd59f2d9b..042ee5b6f9f1 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -413,7 +413,7 @@ static int add_tracepoint_fields_values(struct ctf_writer *cw,
 static int add_tracepoint_values(struct ctf_writer *cw,
 				 struct bt_ctf_event_class *event_class,
 				 struct bt_ctf_event *event,
-				 struct perf_evsel *evsel,
+				 struct evsel *evsel,
 				 struct perf_sample *sample)
 {
 	struct tep_format_field *common_fields = evsel->tp_format->format.common_fields;
@@ -584,7 +584,7 @@ add_callchain_output_values(struct bt_ctf_event_class *event_class,
 
 static int add_generic_values(struct ctf_writer *cw,
 			      struct bt_ctf_event *event,
-			      struct perf_evsel *evsel,
+			      struct evsel *evsel,
 			      struct perf_sample *sample)
 {
 	u64 type = evsel->attr.sample_type;
@@ -753,7 +753,7 @@ static struct ctf_stream *ctf_stream(struct ctf_writer *cw, int cpu)
 }
 
 static int get_sample_cpu(struct ctf_writer *cw, struct perf_sample *sample,
-			  struct perf_evsel *evsel)
+			  struct evsel *evsel)
 {
 	int cpu = 0;
 
@@ -785,7 +785,7 @@ static bool is_flush_needed(struct ctf_stream *cs)
 static int process_sample_event(struct perf_tool *tool,
 				union perf_event *_event,
 				struct perf_sample *sample,
-				struct perf_evsel *evsel,
+				struct evsel *evsel,
 				struct machine *machine __maybe_unused)
 {
 	struct convert *c = container_of(tool, struct convert, tool);
@@ -1051,7 +1051,7 @@ static int add_tracepoint_fields_types(struct ctf_writer *cw,
 }
 
 static int add_tracepoint_types(struct ctf_writer *cw,
-				struct perf_evsel *evsel,
+				struct evsel *evsel,
 				struct bt_ctf_event_class *class)
 {
 	struct tep_format_field *common_fields = evsel->tp_format->format.common_fields;
@@ -1084,7 +1084,7 @@ static int add_bpf_output_types(struct ctf_writer *cw,
 	return bt_ctf_event_class_add_field(class, seq_type, "raw_data");
 }
 
-static int add_generic_types(struct ctf_writer *cw, struct perf_evsel *evsel,
+static int add_generic_types(struct ctf_writer *cw, struct evsel *evsel,
 			     struct bt_ctf_event_class *event_class)
 {
 	u64 type = evsel->attr.sample_type;
@@ -1150,7 +1150,7 @@ static int add_generic_types(struct ctf_writer *cw, struct perf_evsel *evsel,
 	return 0;
 }
 
-static int add_event(struct ctf_writer *cw, struct perf_evsel *evsel)
+static int add_event(struct ctf_writer *cw, struct evsel *evsel)
 {
 	struct bt_ctf_event_class *event_class;
 	struct evsel_priv *priv;
@@ -1202,7 +1202,7 @@ static int add_event(struct ctf_writer *cw, struct perf_evsel *evsel)
 static int setup_events(struct ctf_writer *cw, struct perf_session *session)
 {
 	struct perf_evlist *evlist = session->evlist;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	int ret;
 
 	evlist__for_each_entry(evlist, evsel) {
@@ -1309,7 +1309,7 @@ static int setup_non_sample_events(struct ctf_writer *cw,
 static void cleanup_events(struct perf_session *session)
 {
 	struct perf_evlist *evlist = session->evlist;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel) {
 		struct evsel_priv *priv;
diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index ffbb3e7d3288..dc2d4de772e3 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -32,7 +32,7 @@ void db_export__exit(struct db_export *dbe)
 	dbe->crp = NULL;
 }
 
-int db_export__evsel(struct db_export *dbe, struct perf_evsel *evsel)
+int db_export__evsel(struct db_export *dbe, struct evsel *evsel)
 {
 	if (evsel->db_id)
 		return 0;
@@ -209,7 +209,7 @@ static struct call_path *call_path_from_sample(struct db_export *dbe,
 					       struct machine *machine,
 					       struct thread *thread,
 					       struct perf_sample *sample,
-					       struct perf_evsel *evsel)
+					       struct evsel *evsel)
 {
 	u64 kernel_start = machine__kernel_start(machine);
 	struct call_path *current = &dbe->cpr->call_path;
@@ -341,7 +341,7 @@ static int db_export__threads(struct db_export *dbe, struct thread *thread,
 }
 
 int db_export__sample(struct db_export *dbe, union perf_event *event,
-		      struct perf_sample *sample, struct perf_evsel *evsel,
+		      struct perf_sample *sample, struct evsel *evsel,
 		      struct addr_location *al)
 {
 	struct thread *thread = al->thread;
diff --git a/tools/perf/util/db-export.h b/tools/perf/util/db-export.h
index ba1f62a5fe10..9c3d38f5a40d 100644
--- a/tools/perf/util/db-export.h
+++ b/tools/perf/util/db-export.h
@@ -10,7 +10,7 @@
 #include <linux/types.h>
 #include <linux/list.h>
 
-struct perf_evsel;
+struct evsel;
 struct machine;
 struct thread;
 struct comm;
@@ -25,7 +25,7 @@ struct call_return;
 struct export_sample {
 	union perf_event	*event;
 	struct perf_sample	*sample;
-	struct perf_evsel	*evsel;
+	struct evsel		*evsel;
 	struct addr_location	*al;
 	u64			db_id;
 	u64			comm_db_id;
@@ -39,7 +39,7 @@ struct export_sample {
 };
 
 struct db_export {
-	int (*export_evsel)(struct db_export *dbe, struct perf_evsel *evsel);
+	int (*export_evsel)(struct db_export *dbe, struct evsel *evsel);
 	int (*export_machine)(struct db_export *dbe, struct machine *machine);
 	int (*export_thread)(struct db_export *dbe, struct thread *thread,
 			     u64 main_thread_db_id, struct machine *machine);
@@ -79,7 +79,7 @@ struct db_export {
 
 int db_export__init(struct db_export *dbe);
 void db_export__exit(struct db_export *dbe);
-int db_export__evsel(struct db_export *dbe, struct perf_evsel *evsel);
+int db_export__evsel(struct db_export *dbe, struct evsel *evsel);
 int db_export__machine(struct db_export *dbe, struct machine *machine);
 int db_export__thread(struct db_export *dbe, struct thread *thread,
 		      struct machine *machine, struct thread *main_thread);
@@ -96,7 +96,7 @@ int db_export__symbol(struct db_export *dbe, struct symbol *sym,
 int db_export__branch_type(struct db_export *dbe, u32 branch_type,
 			   const char *name);
 int db_export__sample(struct db_export *dbe, union perf_event *event,
-		      struct perf_sample *sample, struct perf_evsel *evsel,
+		      struct perf_sample *sample, struct evsel *evsel,
 		      struct addr_location *al);
 
 int db_export__branch_types(struct db_export *dbe);
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index a95d0461f718..7e6066cb525b 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -98,7 +98,7 @@ struct perf_evlist *perf_evlist__new_dummy(void)
  */
 void perf_evlist__set_id_pos(struct perf_evlist *evlist)
 {
-	struct perf_evsel *first = perf_evlist__first(evlist);
+	struct evsel *first = perf_evlist__first(evlist);
 
 	evlist->id_pos = first->id_pos;
 	evlist->is_pos = first->is_pos;
@@ -106,7 +106,7 @@ void perf_evlist__set_id_pos(struct perf_evlist *evlist)
 
 static void perf_evlist__update_id_pos(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel)
 		perf_evsel__calc_id_pos(evsel);
@@ -116,7 +116,7 @@ static void perf_evlist__update_id_pos(struct perf_evlist *evlist)
 
 static void perf_evlist__purge(struct perf_evlist *evlist)
 {
-	struct perf_evsel *pos, *n;
+	struct evsel *pos, *n;
 
 	evlist__for_each_entry_safe(evlist, n, pos) {
 		list_del_init(&pos->node);
@@ -151,7 +151,7 @@ void perf_evlist__delete(struct perf_evlist *evlist)
 }
 
 static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
-					  struct perf_evsel *evsel)
+					  struct evsel *evsel)
 {
 	/*
 	 * We already have cpus for evsel (via PMU sysfs) so
@@ -171,13 +171,13 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
 
 static void perf_evlist__propagate_maps(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel)
 		__perf_evlist__propagate_maps(evlist, evsel);
 }
 
-void perf_evlist__add(struct perf_evlist *evlist, struct perf_evsel *entry)
+void perf_evlist__add(struct perf_evlist *evlist, struct evsel *entry)
 {
 	entry->evlist = evlist;
 	list_add_tail(&entry->node, &evlist->entries);
@@ -190,7 +190,7 @@ void perf_evlist__add(struct perf_evlist *evlist, struct perf_evsel *entry)
 	__perf_evlist__propagate_maps(evlist, entry);
 }
 
-void perf_evlist__remove(struct perf_evlist *evlist, struct perf_evsel *evsel)
+void perf_evlist__remove(struct perf_evlist *evlist, struct evsel *evsel)
 {
 	evsel->evlist = NULL;
 	list_del_init(&evsel->node);
@@ -200,7 +200,7 @@ void perf_evlist__remove(struct perf_evlist *evlist, struct perf_evsel *evsel)
 void perf_evlist__splice_list_tail(struct perf_evlist *evlist,
 				   struct list_head *list)
 {
-	struct perf_evsel *evsel, *temp;
+	struct evsel *evsel, *temp;
 
 	__evlist__for_each_entry_safe(list, temp, evsel) {
 		list_del_init(&evsel->node);
@@ -210,10 +210,10 @@ void perf_evlist__splice_list_tail(struct perf_evlist *evlist,
 
 void __perf_evlist__set_leader(struct list_head *list)
 {
-	struct perf_evsel *evsel, *leader;
+	struct evsel *evsel, *leader;
 
-	leader = list_entry(list->next, struct perf_evsel, node);
-	evsel = list_entry(list->prev, struct perf_evsel, node);
+	leader = list_entry(list->next, struct evsel, node);
+	evsel = list_entry(list->prev, struct evsel, node);
 
 	leader->nr_members = evsel->idx - leader->idx + 1;
 
@@ -232,7 +232,7 @@ void perf_evlist__set_leader(struct perf_evlist *evlist)
 
 int __perf_evlist__add_default(struct perf_evlist *evlist, bool precise)
 {
-	struct perf_evsel *evsel = perf_evsel__new_cycles(precise);
+	struct evsel *evsel = perf_evsel__new_cycles(precise);
 
 	if (evsel == NULL)
 		return -ENOMEM;
@@ -248,7 +248,7 @@ int perf_evlist__add_dummy(struct perf_evlist *evlist)
 		.config = PERF_COUNT_SW_DUMMY,
 		.size	= sizeof(attr), /* to capture ABI version */
 	};
-	struct perf_evsel *evsel = perf_evsel__new_idx(&attr, evlist->nr_entries);
+	struct evsel *evsel = perf_evsel__new_idx(&attr, evlist->nr_entries);
 
 	if (evsel == NULL)
 		return -ENOMEM;
@@ -260,7 +260,7 @@ int perf_evlist__add_dummy(struct perf_evlist *evlist)
 static int perf_evlist__add_attrs(struct perf_evlist *evlist,
 				  struct perf_event_attr *attrs, size_t nr_attrs)
 {
-	struct perf_evsel *evsel, *n;
+	struct evsel *evsel, *n;
 	LIST_HEAD(head);
 	size_t i;
 
@@ -292,10 +292,10 @@ int __perf_evlist__add_default_attrs(struct perf_evlist *evlist,
 	return perf_evlist__add_attrs(evlist, attrs, nr_attrs);
 }
 
-struct perf_evsel *
+struct evsel *
 perf_evlist__find_tracepoint_by_id(struct perf_evlist *evlist, int id)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (evsel->attr.type   == PERF_TYPE_TRACEPOINT &&
@@ -306,11 +306,11 @@ perf_evlist__find_tracepoint_by_id(struct perf_evlist *evlist, int id)
 	return NULL;
 }
 
-struct perf_evsel *
+struct evsel *
 perf_evlist__find_tracepoint_by_name(struct perf_evlist *evlist,
 				     const char *name)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel) {
 		if ((evsel->attr.type == PERF_TYPE_TRACEPOINT) &&
@@ -324,7 +324,7 @@ perf_evlist__find_tracepoint_by_name(struct perf_evlist *evlist,
 int perf_evlist__add_newtp(struct perf_evlist *evlist,
 			   const char *sys, const char *name, void *handler)
 {
-	struct perf_evsel *evsel = perf_evsel__newtp(sys, name);
+	struct evsel *evsel = perf_evsel__newtp(sys, name);
 
 	if (IS_ERR(evsel))
 		return -1;
@@ -335,7 +335,7 @@ int perf_evlist__add_newtp(struct perf_evlist *evlist,
 }
 
 static int perf_evlist__nr_threads(struct perf_evlist *evlist,
-				   struct perf_evsel *evsel)
+				   struct evsel *evsel)
 {
 	if (evsel->system_wide)
 		return 1;
@@ -345,7 +345,7 @@ static int perf_evlist__nr_threads(struct perf_evlist *evlist,
 
 void perf_evlist__disable(struct perf_evlist *evlist)
 {
-	struct perf_evsel *pos;
+	struct evsel *pos;
 
 	evlist__for_each_entry(evlist, pos) {
 		if (pos->disabled || !perf_evsel__is_group_leader(pos) || !pos->fd)
@@ -358,7 +358,7 @@ void perf_evlist__disable(struct perf_evlist *evlist)
 
 void perf_evlist__enable(struct perf_evlist *evlist)
 {
-	struct perf_evsel *pos;
+	struct evsel *pos;
 
 	evlist__for_each_entry(evlist, pos) {
 		if (!perf_evsel__is_group_leader(pos) || !pos->fd)
@@ -375,7 +375,7 @@ void perf_evlist__toggle_enable(struct perf_evlist *evlist)
 }
 
 static int perf_evlist__enable_event_cpu(struct perf_evlist *evlist,
-					 struct perf_evsel *evsel, int cpu)
+					 struct evsel *evsel, int cpu)
 {
 	int thread;
 	int nr_threads = perf_evlist__nr_threads(evlist, evsel);
@@ -392,7 +392,7 @@ static int perf_evlist__enable_event_cpu(struct perf_evlist *evlist,
 }
 
 static int perf_evlist__enable_event_thread(struct perf_evlist *evlist,
-					    struct perf_evsel *evsel,
+					    struct evsel *evsel,
 					    int thread)
 {
 	int cpu;
@@ -410,7 +410,7 @@ static int perf_evlist__enable_event_thread(struct perf_evlist *evlist,
 }
 
 int perf_evlist__enable_event_idx(struct perf_evlist *evlist,
-				  struct perf_evsel *evsel, int idx)
+				  struct evsel *evsel, int idx)
 {
 	bool per_cpu_mmaps = !cpu_map__empty(evlist->cpus);
 
@@ -425,7 +425,7 @@ int perf_evlist__alloc_pollfd(struct perf_evlist *evlist)
 	int nr_cpus = cpu_map__nr(evlist->cpus);
 	int nr_threads = thread_map__nr(evlist->threads);
 	int nfds = 0;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (evsel->system_wide)
@@ -484,7 +484,7 @@ int perf_evlist__poll(struct perf_evlist *evlist, int timeout)
 }
 
 static void perf_evlist__id_hash(struct perf_evlist *evlist,
-				 struct perf_evsel *evsel,
+				 struct evsel *evsel,
 				 int cpu, int thread, u64 id)
 {
 	int hash;
@@ -496,7 +496,7 @@ static void perf_evlist__id_hash(struct perf_evlist *evlist,
 	hlist_add_head(&sid->node, &evlist->heads[hash]);
 }
 
-void perf_evlist__id_add(struct perf_evlist *evlist, struct perf_evsel *evsel,
+void perf_evlist__id_add(struct perf_evlist *evlist, struct evsel *evsel,
 			 int cpu, int thread, u64 id)
 {
 	perf_evlist__id_hash(evlist, evsel, cpu, thread, id);
@@ -504,7 +504,7 @@ void perf_evlist__id_add(struct perf_evlist *evlist, struct perf_evsel *evsel,
 }
 
 int perf_evlist__id_add_fd(struct perf_evlist *evlist,
-			   struct perf_evsel *evsel,
+			   struct evsel *evsel,
 			   int cpu, int thread, int fd)
 {
 	u64 read_data[4] = { 0, };
@@ -545,7 +545,7 @@ int perf_evlist__id_add_fd(struct perf_evlist *evlist,
 }
 
 static void perf_evlist__set_sid_idx(struct perf_evlist *evlist,
-				     struct perf_evsel *evsel, int idx, int cpu,
+				     struct evsel *evsel, int idx, int cpu,
 				     int thread)
 {
 	struct perf_sample_id *sid = SID(evsel, cpu, thread);
@@ -576,7 +576,7 @@ struct perf_sample_id *perf_evlist__id2sid(struct perf_evlist *evlist, u64 id)
 	return NULL;
 }
 
-struct perf_evsel *perf_evlist__id2evsel(struct perf_evlist *evlist, u64 id)
+struct evsel *perf_evlist__id2evsel(struct perf_evlist *evlist, u64 id)
 {
 	struct perf_sample_id *sid;
 
@@ -593,7 +593,7 @@ struct perf_evsel *perf_evlist__id2evsel(struct perf_evlist *evlist, u64 id)
 	return NULL;
 }
 
-struct perf_evsel *perf_evlist__id2evsel_strict(struct perf_evlist *evlist,
+struct evsel *perf_evlist__id2evsel_strict(struct perf_evlist *evlist,
 						u64 id)
 {
 	struct perf_sample_id *sid;
@@ -629,10 +629,10 @@ static int perf_evlist__event2id(struct perf_evlist *evlist,
 	return 0;
 }
 
-struct perf_evsel *perf_evlist__event2evsel(struct perf_evlist *evlist,
+struct evsel *perf_evlist__event2evsel(struct perf_evlist *evlist,
 					    union perf_event *event)
 {
-	struct perf_evsel *first = perf_evlist__first(evlist);
+	struct evsel *first = perf_evlist__first(evlist);
 	struct hlist_head *head;
 	struct perf_sample_id *sid;
 	int hash;
@@ -744,7 +744,7 @@ static struct perf_mmap *perf_evlist__alloc_mmap(struct perf_evlist *evlist,
 
 static bool
 perf_evlist__should_poll(struct perf_evlist *evlist __maybe_unused,
-			 struct perf_evsel *evsel)
+			 struct evsel *evsel)
 {
 	if (evsel->attr.write_backward)
 		return false;
@@ -755,7 +755,7 @@ static int perf_evlist__mmap_per_evsel(struct perf_evlist *evlist, int idx,
 				       struct mmap_params *mp, int cpu_idx,
 				       int thread, int *_output, int *_output_overwrite)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	int revent;
 	int evlist_cpu = cpu_map__cpu(evlist->cpus, cpu_idx);
 
@@ -1011,7 +1011,7 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 			 bool auxtrace_overwrite, int nr_cblocks, int affinity, int flush,
 			 int comp_level)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	const struct perf_cpu_map *cpus = evlist->cpus;
 	const struct perf_thread_map *threads = evlist->threads;
 	/*
@@ -1130,7 +1130,7 @@ void perf_evlist__set_maps(struct perf_evlist *evlist, struct perf_cpu_map *cpus
 void __perf_evlist__set_sample_bit(struct perf_evlist *evlist,
 				   enum perf_event_sample_format bit)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel)
 		__perf_evsel__set_sample_bit(evsel, bit);
@@ -1139,15 +1139,15 @@ void __perf_evlist__set_sample_bit(struct perf_evlist *evlist,
 void __perf_evlist__reset_sample_bit(struct perf_evlist *evlist,
 				     enum perf_event_sample_format bit)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel)
 		__perf_evsel__reset_sample_bit(evsel, bit);
 }
 
-int perf_evlist__apply_filters(struct perf_evlist *evlist, struct perf_evsel **err_evsel)
+int perf_evlist__apply_filters(struct perf_evlist *evlist, struct evsel **err_evsel)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	int err = 0;
 
 	evlist__for_each_entry(evlist, evsel) {
@@ -1170,7 +1170,7 @@ int perf_evlist__apply_filters(struct perf_evlist *evlist, struct perf_evsel **e
 
 int perf_evlist__set_tp_filter(struct perf_evlist *evlist, const char *filter)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	int err = 0;
 
 	evlist__for_each_entry(evlist, evsel) {
@@ -1219,7 +1219,7 @@ int perf_evlist__set_tp_filter_pid(struct perf_evlist *evlist, pid_t pid)
 
 bool perf_evlist__valid_sample_type(struct perf_evlist *evlist)
 {
-	struct perf_evsel *pos;
+	struct evsel *pos;
 
 	if (evlist->nr_entries == 1)
 		return true;
@@ -1238,7 +1238,7 @@ bool perf_evlist__valid_sample_type(struct perf_evlist *evlist)
 
 u64 __perf_evlist__combined_sample_type(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	if (evlist->combined_sample_type)
 		return evlist->combined_sample_type;
@@ -1257,7 +1257,7 @@ u64 perf_evlist__combined_sample_type(struct perf_evlist *evlist)
 
 u64 perf_evlist__combined_branch_type(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	u64 branch_type = 0;
 
 	evlist__for_each_entry(evlist, evsel)
@@ -1267,7 +1267,7 @@ u64 perf_evlist__combined_branch_type(struct perf_evlist *evlist)
 
 bool perf_evlist__valid_read_format(struct perf_evlist *evlist)
 {
-	struct perf_evsel *first = perf_evlist__first(evlist), *pos = first;
+	struct evsel *first = perf_evlist__first(evlist), *pos = first;
 	u64 read_format = first->attr.read_format;
 	u64 sample_type = first->attr.sample_type;
 
@@ -1287,13 +1287,13 @@ bool perf_evlist__valid_read_format(struct perf_evlist *evlist)
 
 u64 perf_evlist__read_format(struct perf_evlist *evlist)
 {
-	struct perf_evsel *first = perf_evlist__first(evlist);
+	struct evsel *first = perf_evlist__first(evlist);
 	return first->attr.read_format;
 }
 
 u16 perf_evlist__id_hdr_size(struct perf_evlist *evlist)
 {
-	struct perf_evsel *first = perf_evlist__first(evlist);
+	struct evsel *first = perf_evlist__first(evlist);
 	struct perf_sample *data;
 	u64 sample_type;
 	u16 size = 0;
@@ -1326,7 +1326,7 @@ u16 perf_evlist__id_hdr_size(struct perf_evlist *evlist)
 
 bool perf_evlist__valid_sample_id_all(struct perf_evlist *evlist)
 {
-	struct perf_evsel *first = perf_evlist__first(evlist), *pos = first;
+	struct evsel *first = perf_evlist__first(evlist), *pos = first;
 
 	evlist__for_each_entry_continue(evlist, pos) {
 		if (first->attr.sample_id_all != pos->attr.sample_id_all)
@@ -1338,19 +1338,19 @@ bool perf_evlist__valid_sample_id_all(struct perf_evlist *evlist)
 
 bool perf_evlist__sample_id_all(struct perf_evlist *evlist)
 {
-	struct perf_evsel *first = perf_evlist__first(evlist);
+	struct evsel *first = perf_evlist__first(evlist);
 	return first->attr.sample_id_all;
 }
 
 void perf_evlist__set_selected(struct perf_evlist *evlist,
-			       struct perf_evsel *evsel)
+			       struct evsel *evsel)
 {
 	evlist->selected = evsel;
 }
 
 void perf_evlist__close(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	evlist__for_each_entry_reverse(evlist, evsel)
 		perf_evsel__close(evsel);
@@ -1389,7 +1389,7 @@ static int perf_evlist__create_syswide_maps(struct perf_evlist *evlist)
 
 int perf_evlist__open(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	int err;
 
 	/*
@@ -1553,7 +1553,7 @@ int perf_evlist__start_workload(struct perf_evlist *evlist)
 int perf_evlist__parse_sample(struct perf_evlist *evlist, union perf_event *event,
 			      struct perf_sample *sample)
 {
-	struct perf_evsel *evsel = perf_evlist__event2evsel(evlist, event);
+	struct evsel *evsel = perf_evlist__event2evsel(evlist, event);
 
 	if (!evsel)
 		return -EFAULT;
@@ -1564,7 +1564,7 @@ int perf_evlist__parse_sample_timestamp(struct perf_evlist *evlist,
 					union perf_event *event,
 					u64 *timestamp)
 {
-	struct perf_evsel *evsel = perf_evlist__event2evsel(evlist, event);
+	struct evsel *evsel = perf_evlist__event2evsel(evlist, event);
 
 	if (!evsel)
 		return -EFAULT;
@@ -1573,7 +1573,7 @@ int perf_evlist__parse_sample_timestamp(struct perf_evlist *evlist,
 
 size_t perf_evlist__fprintf(struct perf_evlist *evlist, FILE *fp)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	size_t printed = 0;
 
 	evlist__for_each_entry(evlist, evsel) {
@@ -1613,7 +1613,7 @@ int perf_evlist__strerror_open(struct perf_evlist *evlist,
 				    "Hint:\tThe current value is %d.", value);
 		break;
 	case EINVAL: {
-		struct perf_evsel *first = perf_evlist__first(evlist);
+		struct evsel *first = perf_evlist__first(evlist);
 		int max_freq;
 
 		if (sysctl__read_int("kernel/perf_event_max_sample_rate", &max_freq) < 0)
@@ -1670,9 +1670,9 @@ int perf_evlist__strerror_mmap(struct perf_evlist *evlist, int err, char *buf, s
 }
 
 void perf_evlist__to_front(struct perf_evlist *evlist,
-			   struct perf_evsel *move_evsel)
+			   struct evsel *move_evsel)
 {
-	struct perf_evsel *evsel, *n;
+	struct evsel *evsel, *n;
 	LIST_HEAD(move);
 
 	if (move_evsel == perf_evlist__first(evlist))
@@ -1687,9 +1687,9 @@ void perf_evlist__to_front(struct perf_evlist *evlist,
 }
 
 void perf_evlist__set_tracking_event(struct perf_evlist *evlist,
-				     struct perf_evsel *tracking_evsel)
+				     struct evsel *tracking_evsel)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	if (tracking_evsel->tracking)
 		return;
@@ -1702,11 +1702,11 @@ void perf_evlist__set_tracking_event(struct perf_evlist *evlist,
 	tracking_evsel->tracking = true;
 }
 
-struct perf_evsel *
+struct evsel *
 perf_evlist__find_evsel_by_str(struct perf_evlist *evlist,
 			       const char *str)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (!evsel->name)
@@ -1778,7 +1778,7 @@ void perf_evlist__toggle_bkw_mmap(struct perf_evlist *evlist,
 
 bool perf_evlist__exclude_kernel(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (!evsel->attr.exclude_kernel)
@@ -1796,17 +1796,17 @@ bool perf_evlist__exclude_kernel(struct perf_evlist *evlist)
 void perf_evlist__force_leader(struct perf_evlist *evlist)
 {
 	if (!evlist->nr_groups) {
-		struct perf_evsel *leader = perf_evlist__first(evlist);
+		struct evsel *leader = perf_evlist__first(evlist);
 
 		perf_evlist__set_leader(evlist);
 		leader->forced_leader = true;
 	}
 }
 
-struct perf_evsel *perf_evlist__reset_weak_group(struct perf_evlist *evsel_list,
-						 struct perf_evsel *evsel)
+struct evsel *perf_evlist__reset_weak_group(struct perf_evlist *evsel_list,
+						 struct evsel *evsel)
 {
-	struct perf_evsel *c2, *leader;
+	struct evsel *c2, *leader;
 	bool is_open = true;
 
 	leader = evsel->leader;
@@ -1835,7 +1835,7 @@ int perf_evlist__add_sb_event(struct perf_evlist **evlist,
 			      perf_evsel__sb_cb_t cb,
 			      void *data)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	bool new_evlist = (*evlist) == NULL;
 
 	if (*evlist == NULL)
@@ -1887,7 +1887,7 @@ static void *perf_evlist__poll_thread(void *arg)
 			if (perf_mmap__read_init(map))
 				continue;
 			while ((event = perf_mmap__read_event(map)) != NULL) {
-				struct perf_evsel *evsel = perf_evlist__event2evsel(evlist, event);
+				struct evsel *evsel = perf_evlist__event2evsel(evlist, event);
 
 				if (evsel && evsel->side_band.cb)
 					evsel->side_band.cb(event, evsel->side_band.data);
@@ -1909,7 +1909,7 @@ static void *perf_evlist__poll_thread(void *arg)
 int perf_evlist__start_sb_thread(struct perf_evlist *evlist,
 				 struct target *target)
 {
-	struct perf_evsel *counter;
+	struct evsel *counter;
 
 	if (!evlist)
 		return 0;
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index ab2f0b6c7640..576d59a0d8cf 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -46,7 +46,7 @@ struct perf_evlist {
 	struct perf_mmap *overwrite_mmap;
 	struct perf_thread_map *threads;
 	struct perf_cpu_map *cpus;
-	struct perf_evsel *selected;
+	struct evsel *selected;
 	struct events_stats stats;
 	struct perf_env	*env;
 	void (*trace_event_sample_raw)(struct perf_evlist *evlist,
@@ -60,7 +60,7 @@ struct perf_evlist {
 	} thread;
 };
 
-struct perf_evsel_str_handler {
+struct evsel_str_handler {
 	const char *name;
 	void	   *handler;
 };
@@ -73,8 +73,8 @@ void perf_evlist__init(struct perf_evlist *evlist, struct perf_cpu_map *cpus,
 void perf_evlist__exit(struct perf_evlist *evlist);
 void perf_evlist__delete(struct perf_evlist *evlist);
 
-void perf_evlist__add(struct perf_evlist *evlist, struct perf_evsel *entry);
-void perf_evlist__remove(struct perf_evlist *evlist, struct perf_evsel *evsel);
+void perf_evlist__add(struct perf_evlist *evlist, struct evsel *entry);
+void perf_evlist__remove(struct perf_evlist *evlist, struct evsel *evsel);
 
 int __perf_evlist__add_default(struct perf_evlist *evlist, bool precise);
 
@@ -117,17 +117,17 @@ int perf_evlist__set_tp_filter(struct perf_evlist *evlist, const char *filter);
 int perf_evlist__set_tp_filter_pid(struct perf_evlist *evlist, pid_t pid);
 int perf_evlist__set_tp_filter_pids(struct perf_evlist *evlist, size_t npids, pid_t *pids);
 
-struct perf_evsel *
+struct evsel *
 perf_evlist__find_tracepoint_by_id(struct perf_evlist *evlist, int id);
 
-struct perf_evsel *
+struct evsel *
 perf_evlist__find_tracepoint_by_name(struct perf_evlist *evlist,
 				     const char *name);
 
-void perf_evlist__id_add(struct perf_evlist *evlist, struct perf_evsel *evsel,
+void perf_evlist__id_add(struct perf_evlist *evlist, struct evsel *evsel,
 			 int cpu, int thread, u64 id);
 int perf_evlist__id_add_fd(struct perf_evlist *evlist,
-			   struct perf_evsel *evsel,
+			   struct evsel *evsel,
 			   int cpu, int thread, int fd);
 
 int perf_evlist__add_pollfd(struct perf_evlist *evlist, int fd);
@@ -136,8 +136,8 @@ int perf_evlist__filter_pollfd(struct perf_evlist *evlist, short revents_and_mas
 
 int perf_evlist__poll(struct perf_evlist *evlist, int timeout);
 
-struct perf_evsel *perf_evlist__id2evsel(struct perf_evlist *evlist, u64 id);
-struct perf_evsel *perf_evlist__id2evsel_strict(struct perf_evlist *evlist,
+struct evsel *perf_evlist__id2evsel(struct perf_evlist *evlist, u64 id);
+struct evsel *perf_evlist__id2evsel_strict(struct perf_evlist *evlist,
 						u64 id);
 
 struct perf_sample_id *perf_evlist__id2sid(struct perf_evlist *evlist, u64 id);
@@ -189,15 +189,15 @@ void perf_evlist__enable(struct perf_evlist *evlist);
 void perf_evlist__toggle_enable(struct perf_evlist *evlist);
 
 int perf_evlist__enable_event_idx(struct perf_evlist *evlist,
-				  struct perf_evsel *evsel, int idx);
+				  struct evsel *evsel, int idx);
 
 void perf_evlist__set_selected(struct perf_evlist *evlist,
-			       struct perf_evsel *evsel);
+			       struct evsel *evsel);
 
 void perf_evlist__set_maps(struct perf_evlist *evlist, struct perf_cpu_map *cpus,
 			   struct perf_thread_map *threads);
 int perf_evlist__create_maps(struct perf_evlist *evlist, struct target *target);
-int perf_evlist__apply_filters(struct perf_evlist *evlist, struct perf_evsel **err_evsel);
+int perf_evlist__apply_filters(struct perf_evlist *evlist, struct evsel **err_evsel);
 
 void __perf_evlist__set_leader(struct list_head *list);
 void perf_evlist__set_leader(struct perf_evlist *evlist);
@@ -228,14 +228,14 @@ static inline bool perf_evlist__empty(struct perf_evlist *evlist)
 	return list_empty(&evlist->entries);
 }
 
-static inline struct perf_evsel *perf_evlist__first(struct perf_evlist *evlist)
+static inline struct evsel *perf_evlist__first(struct perf_evlist *evlist)
 {
-	return list_entry(evlist->entries.next, struct perf_evsel, node);
+	return list_entry(evlist->entries.next, struct evsel, node);
 }
 
-static inline struct perf_evsel *perf_evlist__last(struct perf_evlist *evlist)
+static inline struct evsel *perf_evlist__last(struct perf_evlist *evlist)
 {
-	return list_entry(evlist->entries.prev, struct perf_evsel, node);
+	return list_entry(evlist->entries.prev, struct evsel, node);
 }
 
 size_t perf_evlist__fprintf(struct perf_evlist *evlist, FILE *fp);
@@ -245,7 +245,7 @@ int perf_evlist__strerror_mmap(struct perf_evlist *evlist, int err, char *buf, s
 
 bool perf_evlist__can_select_event(struct perf_evlist *evlist, const char *str);
 void perf_evlist__to_front(struct perf_evlist *evlist,
-			   struct perf_evsel *move_evsel);
+			   struct evsel *move_evsel);
 
 /**
  * __evlist__for_each_entry - iterate thru all the evsels
@@ -314,18 +314,18 @@ void perf_evlist__to_front(struct perf_evlist *evlist,
 	__evlist__for_each_entry_safe(&(evlist)->entries, tmp, evsel)
 
 void perf_evlist__set_tracking_event(struct perf_evlist *evlist,
-				     struct perf_evsel *tracking_evsel);
+				     struct evsel *tracking_evsel);
 
-struct perf_evsel *
+struct evsel *
 perf_evlist__find_evsel_by_str(struct perf_evlist *evlist, const char *str);
 
-struct perf_evsel *perf_evlist__event2evsel(struct perf_evlist *evlist,
+struct evsel *perf_evlist__event2evsel(struct perf_evlist *evlist,
 					    union perf_event *event);
 
 bool perf_evlist__exclude_kernel(struct perf_evlist *evlist);
 
 void perf_evlist__force_leader(struct perf_evlist *evlist);
 
-struct perf_evsel *perf_evlist__reset_weak_group(struct perf_evlist *evlist,
-						 struct perf_evsel *evsel);
+struct evsel *perf_evlist__reset_weak_group(struct perf_evlist *evlist,
+						 struct evsel *evsel);
 #endif /* __PERF_EVLIST_H */
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ab66d65b7968..44421bbebd64 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -45,30 +45,30 @@ struct perf_missing_features perf_missing_features;
 
 static clockid_t clockid;
 
-static int perf_evsel__no_extra_init(struct perf_evsel *evsel __maybe_unused)
+static int perf_evsel__no_extra_init(struct evsel *evsel __maybe_unused)
 {
 	return 0;
 }
 
 void __weak test_attr__ready(void) { }
 
-static void perf_evsel__no_extra_fini(struct perf_evsel *evsel __maybe_unused)
+static void perf_evsel__no_extra_fini(struct evsel *evsel __maybe_unused)
 {
 }
 
 static struct {
 	size_t	size;
-	int	(*init)(struct perf_evsel *evsel);
-	void	(*fini)(struct perf_evsel *evsel);
+	int	(*init)(struct evsel *evsel);
+	void	(*fini)(struct evsel *evsel);
 } perf_evsel__object = {
-	.size = sizeof(struct perf_evsel),
+	.size = sizeof(struct evsel),
 	.init = perf_evsel__no_extra_init,
 	.fini = perf_evsel__no_extra_fini,
 };
 
 int perf_evsel__object_config(size_t object_size,
-			      int (*init)(struct perf_evsel *evsel),
-			      void (*fini)(struct perf_evsel *evsel))
+			      int (*init)(struct evsel *evsel),
+			      void (*fini)(struct evsel *evsel))
 {
 
 	if (object_size == 0)
@@ -167,13 +167,13 @@ static int __perf_evsel__calc_is_pos(u64 sample_type)
 	return idx;
 }
 
-void perf_evsel__calc_id_pos(struct perf_evsel *evsel)
+void perf_evsel__calc_id_pos(struct evsel *evsel)
 {
 	evsel->id_pos = __perf_evsel__calc_id_pos(evsel->attr.sample_type);
 	evsel->is_pos = __perf_evsel__calc_is_pos(evsel->attr.sample_type);
 }
 
-void __perf_evsel__set_sample_bit(struct perf_evsel *evsel,
+void __perf_evsel__set_sample_bit(struct evsel *evsel,
 				  enum perf_event_sample_format bit)
 {
 	if (!(evsel->attr.sample_type & bit)) {
@@ -183,7 +183,7 @@ void __perf_evsel__set_sample_bit(struct perf_evsel *evsel,
 	}
 }
 
-void __perf_evsel__reset_sample_bit(struct perf_evsel *evsel,
+void __perf_evsel__reset_sample_bit(struct evsel *evsel,
 				    enum perf_event_sample_format bit)
 {
 	if (evsel->attr.sample_type & bit) {
@@ -193,7 +193,7 @@ void __perf_evsel__reset_sample_bit(struct perf_evsel *evsel,
 	}
 }
 
-void perf_evsel__set_sample_id(struct perf_evsel *evsel,
+void perf_evsel__set_sample_id(struct evsel *evsel,
 			       bool can_sample_identifier)
 {
 	if (can_sample_identifier) {
@@ -213,7 +213,7 @@ void perf_evsel__set_sample_id(struct perf_evsel *evsel,
  *
  * Return %true if event is function trace event
  */
-bool perf_evsel__is_function_event(struct perf_evsel *evsel)
+bool perf_evsel__is_function_event(struct evsel *evsel)
 {
 #define FUNCTION_EVENT "ftrace:function"
 
@@ -223,7 +223,7 @@ bool perf_evsel__is_function_event(struct perf_evsel *evsel)
 #undef FUNCTION_EVENT
 }
 
-void perf_evsel__init(struct perf_evsel *evsel,
+void perf_evsel__init(struct evsel *evsel,
 		      struct perf_event_attr *attr, int idx)
 {
 	evsel->idx	   = idx;
@@ -249,9 +249,9 @@ void perf_evsel__init(struct perf_evsel *evsel,
 	evsel->pmu_name      = NULL;
 }
 
-struct perf_evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx)
+struct evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx)
 {
-	struct perf_evsel *evsel = zalloc(perf_evsel__object.size);
+	struct evsel *evsel = zalloc(perf_evsel__object.size);
 
 	if (!evsel)
 		return NULL;
@@ -282,14 +282,14 @@ static bool perf_event_can_profile_kernel(void)
 	return geteuid() == 0 || perf_event_paranoid() == -1;
 }
 
-struct perf_evsel *perf_evsel__new_cycles(bool precise)
+struct evsel *perf_evsel__new_cycles(bool precise)
 {
 	struct perf_event_attr attr = {
 		.type	= PERF_TYPE_HARDWARE,
 		.config	= PERF_COUNT_HW_CPU_CYCLES,
 		.exclude_kernel	= !perf_event_can_profile_kernel(),
 	};
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	event_attr_init(&attr);
 
@@ -324,9 +324,9 @@ struct perf_evsel *perf_evsel__new_cycles(bool precise)
 /*
  * Returns pointer with encoded error via <linux/err.h> interface.
  */
-struct perf_evsel *perf_evsel__newtp_idx(const char *sys, const char *name, int idx)
+struct evsel *perf_evsel__newtp_idx(const char *sys, const char *name, int idx)
 {
-	struct perf_evsel *evsel = zalloc(perf_evsel__object.size);
+	struct evsel *evsel = zalloc(perf_evsel__object.size);
 	int err = -ENOMEM;
 
 	if (evsel == NULL) {
@@ -383,7 +383,7 @@ static const char *__perf_evsel__hw_name(u64 config)
 	return "unknown-hardware";
 }
 
-static int perf_evsel__add_modifiers(struct perf_evsel *evsel, char *bf, size_t size)
+static int perf_evsel__add_modifiers(struct evsel *evsel, char *bf, size_t size)
 {
 	int colon = 0, r = 0;
 	struct perf_event_attr *attr = &evsel->attr;
@@ -419,7 +419,7 @@ static int perf_evsel__add_modifiers(struct perf_evsel *evsel, char *bf, size_t
 	return r;
 }
 
-static int perf_evsel__hw_name(struct perf_evsel *evsel, char *bf, size_t size)
+static int perf_evsel__hw_name(struct evsel *evsel, char *bf, size_t size)
 {
 	int r = scnprintf(bf, size, "%s", __perf_evsel__hw_name(evsel->attr.config));
 	return r + perf_evsel__add_modifiers(evsel, bf + r, size - r);
@@ -445,7 +445,7 @@ static const char *__perf_evsel__sw_name(u64 config)
 	return "unknown-software";
 }
 
-static int perf_evsel__sw_name(struct perf_evsel *evsel, char *bf, size_t size)
+static int perf_evsel__sw_name(struct evsel *evsel, char *bf, size_t size)
 {
 	int r = scnprintf(bf, size, "%s", __perf_evsel__sw_name(evsel->attr.config));
 	return r + perf_evsel__add_modifiers(evsel, bf + r, size - r);
@@ -469,7 +469,7 @@ static int __perf_evsel__bp_name(char *bf, size_t size, u64 addr, u64 type)
 	return r;
 }
 
-static int perf_evsel__bp_name(struct perf_evsel *evsel, char *bf, size_t size)
+static int perf_evsel__bp_name(struct evsel *evsel, char *bf, size_t size)
 {
 	struct perf_event_attr *attr = &evsel->attr;
 	int r = __perf_evsel__bp_name(bf, size, attr->bp_addr, attr->bp_type);
@@ -569,13 +569,13 @@ static int __perf_evsel__hw_cache_name(u64 config, char *bf, size_t size)
 	return scnprintf(bf, size, "%s", err);
 }
 
-static int perf_evsel__hw_cache_name(struct perf_evsel *evsel, char *bf, size_t size)
+static int perf_evsel__hw_cache_name(struct evsel *evsel, char *bf, size_t size)
 {
 	int ret = __perf_evsel__hw_cache_name(evsel->attr.config, bf, size);
 	return ret + perf_evsel__add_modifiers(evsel, bf + ret, size - ret);
 }
 
-static int perf_evsel__raw_name(struct perf_evsel *evsel, char *bf, size_t size)
+static int perf_evsel__raw_name(struct evsel *evsel, char *bf, size_t size)
 {
 	int ret = scnprintf(bf, size, "raw 0x%" PRIx64, evsel->attr.config);
 	return ret + perf_evsel__add_modifiers(evsel, bf + ret, size - ret);
@@ -587,7 +587,7 @@ static int perf_evsel__tool_name(char *bf, size_t size)
 	return ret;
 }
 
-const char *perf_evsel__name(struct perf_evsel *evsel)
+const char *perf_evsel__name(struct evsel *evsel)
 {
 	char bf[128];
 
@@ -639,7 +639,7 @@ const char *perf_evsel__name(struct perf_evsel *evsel)
 	return "unknown";
 }
 
-const char *perf_evsel__group_name(struct perf_evsel *evsel)
+const char *perf_evsel__group_name(struct evsel *evsel)
 {
 	return evsel->group_name ?: "anon group";
 }
@@ -654,10 +654,10 @@ const char *perf_evsel__group_name(struct perf_evsel *evsel)
  *  For record -e 'cycles,instructions' and report --group
  *    'cycles:u, instructions:u'
  */
-int perf_evsel__group_desc(struct perf_evsel *evsel, char *buf, size_t size)
+int perf_evsel__group_desc(struct evsel *evsel, char *buf, size_t size)
 {
 	int ret = 0;
-	struct perf_evsel *pos;
+	struct evsel *pos;
 	const char *group_name = perf_evsel__group_name(evsel);
 
 	if (!evsel->forced_leader)
@@ -676,7 +676,7 @@ int perf_evsel__group_desc(struct perf_evsel *evsel, char *buf, size_t size)
 	return ret;
 }
 
-static void __perf_evsel__config_callchain(struct perf_evsel *evsel,
+static void __perf_evsel__config_callchain(struct evsel *evsel,
 					   struct record_opts *opts,
 					   struct callchain_param *param)
 {
@@ -735,7 +735,7 @@ static void __perf_evsel__config_callchain(struct perf_evsel *evsel,
 	}
 }
 
-void perf_evsel__config_callchain(struct perf_evsel *evsel,
+void perf_evsel__config_callchain(struct evsel *evsel,
 				  struct record_opts *opts,
 				  struct callchain_param *param)
 {
@@ -744,7 +744,7 @@ void perf_evsel__config_callchain(struct perf_evsel *evsel,
 }
 
 static void
-perf_evsel__reset_callgraph(struct perf_evsel *evsel,
+perf_evsel__reset_callgraph(struct evsel *evsel,
 			    struct callchain_param *param)
 {
 	struct perf_event_attr *attr = &evsel->attr;
@@ -761,7 +761,7 @@ perf_evsel__reset_callgraph(struct perf_evsel *evsel,
 	}
 }
 
-static void apply_config_terms(struct perf_evsel *evsel,
+static void apply_config_terms(struct evsel *evsel,
 			       struct record_opts *opts, bool track)
 {
 	struct perf_evsel_config_term *term;
@@ -886,7 +886,7 @@ static void apply_config_terms(struct perf_evsel *evsel,
 	}
 }
 
-static bool is_dummy_event(struct perf_evsel *evsel)
+static bool is_dummy_event(struct evsel *evsel)
 {
 	return (evsel->attr.type == PERF_TYPE_SOFTWARE) &&
 	       (evsel->attr.config == PERF_COUNT_SW_DUMMY);
@@ -920,10 +920,10 @@ static bool is_dummy_event(struct perf_evsel *evsel)
  *     enable/disable events specifically, as there's no
  *     initial traced exec call.
  */
-void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
+void perf_evsel__config(struct evsel *evsel, struct record_opts *opts,
 			struct callchain_param *callchain)
 {
-	struct perf_evsel *leader = evsel->leader;
+	struct evsel *leader = evsel->leader;
 	struct perf_event_attr *attr = &evsel->attr;
 	int track = evsel->tracking;
 	bool per_cpu = opts->target.default_per_cpu && !opts->target.per_thread;
@@ -1153,7 +1153,7 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 		perf_evsel__reset_sample_bit(evsel, BRANCH_STACK);
 }
 
-static int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads)
+static int perf_evsel__alloc_fd(struct evsel *evsel, int ncpus, int nthreads)
 {
 	evsel->fd = xyarray__new(ncpus, nthreads, sizeof(int));
 
@@ -1169,7 +1169,7 @@ static int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthread
 	return evsel->fd != NULL ? 0 : -ENOMEM;
 }
 
-static int perf_evsel__run_ioctl(struct perf_evsel *evsel,
+static int perf_evsel__run_ioctl(struct evsel *evsel,
 			  int ioc,  void *arg)
 {
 	int cpu, thread;
@@ -1187,14 +1187,14 @@ static int perf_evsel__run_ioctl(struct perf_evsel *evsel,
 	return 0;
 }
 
-int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter)
+int perf_evsel__apply_filter(struct evsel *evsel, const char *filter)
 {
 	return perf_evsel__run_ioctl(evsel,
 				     PERF_EVENT_IOC_SET_FILTER,
 				     (void *)filter);
 }
 
-int perf_evsel__set_filter(struct perf_evsel *evsel, const char *filter)
+int perf_evsel__set_filter(struct evsel *evsel, const char *filter)
 {
 	char *new_filter = strdup(filter);
 
@@ -1207,7 +1207,7 @@ int perf_evsel__set_filter(struct perf_evsel *evsel, const char *filter)
 	return -1;
 }
 
-static int perf_evsel__append_filter(struct perf_evsel *evsel,
+static int perf_evsel__append_filter(struct evsel *evsel,
 				     const char *fmt, const char *filter)
 {
 	char *new_filter;
@@ -1224,17 +1224,17 @@ static int perf_evsel__append_filter(struct perf_evsel *evsel,
 	return -1;
 }
 
-int perf_evsel__append_tp_filter(struct perf_evsel *evsel, const char *filter)
+int perf_evsel__append_tp_filter(struct evsel *evsel, const char *filter)
 {
 	return perf_evsel__append_filter(evsel, "(%s) && (%s)", filter);
 }
 
-int perf_evsel__append_addr_filter(struct perf_evsel *evsel, const char *filter)
+int perf_evsel__append_addr_filter(struct evsel *evsel, const char *filter)
 {
 	return perf_evsel__append_filter(evsel, "%s,%s", filter);
 }
 
-int perf_evsel__enable(struct perf_evsel *evsel)
+int perf_evsel__enable(struct evsel *evsel)
 {
 	int err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, 0);
 
@@ -1244,7 +1244,7 @@ int perf_evsel__enable(struct perf_evsel *evsel)
 	return err;
 }
 
-int perf_evsel__disable(struct perf_evsel *evsel)
+int perf_evsel__disable(struct evsel *evsel)
 {
 	int err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, 0);
 	/*
@@ -1259,7 +1259,7 @@ int perf_evsel__disable(struct perf_evsel *evsel)
 	return err;
 }
 
-int perf_evsel__alloc_id(struct perf_evsel *evsel, int ncpus, int nthreads)
+int perf_evsel__alloc_id(struct evsel *evsel, int ncpus, int nthreads)
 {
 	if (ncpus == 0 || nthreads == 0)
 		return 0;
@@ -1281,13 +1281,13 @@ int perf_evsel__alloc_id(struct perf_evsel *evsel, int ncpus, int nthreads)
 	return 0;
 }
 
-static void perf_evsel__free_fd(struct perf_evsel *evsel)
+static void perf_evsel__free_fd(struct evsel *evsel)
 {
 	xyarray__delete(evsel->fd);
 	evsel->fd = NULL;
 }
 
-static void perf_evsel__free_id(struct perf_evsel *evsel)
+static void perf_evsel__free_id(struct evsel *evsel)
 {
 	xyarray__delete(evsel->sample_id);
 	evsel->sample_id = NULL;
@@ -1295,7 +1295,7 @@ static void perf_evsel__free_id(struct perf_evsel *evsel)
 	evsel->ids = 0;
 }
 
-static void perf_evsel__free_config_terms(struct perf_evsel *evsel)
+static void perf_evsel__free_config_terms(struct evsel *evsel)
 {
 	struct perf_evsel_config_term *term, *h;
 
@@ -1305,7 +1305,7 @@ static void perf_evsel__free_config_terms(struct perf_evsel *evsel)
 	}
 }
 
-void perf_evsel__close_fd(struct perf_evsel *evsel)
+void perf_evsel__close_fd(struct evsel *evsel)
 {
 	int cpu, thread;
 
@@ -1316,7 +1316,7 @@ void perf_evsel__close_fd(struct perf_evsel *evsel)
 		}
 }
 
-void perf_evsel__exit(struct perf_evsel *evsel)
+void perf_evsel__exit(struct evsel *evsel)
 {
 	assert(list_empty(&evsel->node));
 	assert(evsel->evlist == NULL);
@@ -1333,13 +1333,13 @@ void perf_evsel__exit(struct perf_evsel *evsel)
 	perf_evsel__object.fini(evsel);
 }
 
-void perf_evsel__delete(struct perf_evsel *evsel)
+void perf_evsel__delete(struct evsel *evsel)
 {
 	perf_evsel__exit(evsel);
 	free(evsel);
 }
 
-void perf_evsel__compute_deltas(struct perf_evsel *evsel, int cpu, int thread,
+void perf_evsel__compute_deltas(struct evsel *evsel, int cpu, int thread,
 				struct perf_counts_values *count)
 {
 	struct perf_counts_values tmp;
@@ -1379,7 +1379,7 @@ void perf_counts_values__scale(struct perf_counts_values *count,
 		*pscaled = scaled;
 }
 
-static int perf_evsel__read_size(struct perf_evsel *evsel)
+static int perf_evsel__read_size(struct evsel *evsel)
 {
 	u64 read_format = evsel->attr.read_format;
 	int entry = sizeof(u64); /* value */
@@ -1404,7 +1404,7 @@ static int perf_evsel__read_size(struct perf_evsel *evsel)
 	return size;
 }
 
-int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
+int perf_evsel__read(struct evsel *evsel, int cpu, int thread,
 		     struct perf_counts_values *count)
 {
 	size_t size = perf_evsel__read_size(evsel);
@@ -1421,7 +1421,7 @@ int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
 }
 
 static int
-perf_evsel__read_one(struct perf_evsel *evsel, int cpu, int thread)
+perf_evsel__read_one(struct evsel *evsel, int cpu, int thread)
 {
 	struct perf_counts_values *count = perf_counts(evsel->counts, cpu, thread);
 
@@ -1429,7 +1429,7 @@ perf_evsel__read_one(struct perf_evsel *evsel, int cpu, int thread)
 }
 
 static void
-perf_evsel__set_count(struct perf_evsel *counter, int cpu, int thread,
+perf_evsel__set_count(struct evsel *counter, int cpu, int thread,
 		      u64 val, u64 ena, u64 run)
 {
 	struct perf_counts_values *count;
@@ -1444,7 +1444,7 @@ perf_evsel__set_count(struct perf_evsel *counter, int cpu, int thread,
 }
 
 static int
-perf_evsel__process_group_data(struct perf_evsel *leader,
+perf_evsel__process_group_data(struct evsel *leader,
 			       int cpu, int thread, u64 *data)
 {
 	u64 read_format = leader->attr.read_format;
@@ -1468,7 +1468,7 @@ perf_evsel__process_group_data(struct perf_evsel *leader,
 			      v[0].value, ena, run);
 
 	for (i = 1; i < nr; i++) {
-		struct perf_evsel *counter;
+		struct evsel *counter;
 
 		counter = perf_evlist__id2evsel(leader->evlist, v[i].id);
 		if (!counter)
@@ -1482,7 +1482,7 @@ perf_evsel__process_group_data(struct perf_evsel *leader,
 }
 
 static int
-perf_evsel__read_group(struct perf_evsel *leader, int cpu, int thread)
+perf_evsel__read_group(struct evsel *leader, int cpu, int thread)
 {
 	struct perf_stat_evsel *ps = leader->stats;
 	u64 read_format = leader->attr.read_format;
@@ -1512,7 +1512,7 @@ perf_evsel__read_group(struct perf_evsel *leader, int cpu, int thread)
 	return perf_evsel__process_group_data(leader, cpu, thread, data);
 }
 
-int perf_evsel__read_counter(struct perf_evsel *evsel, int cpu, int thread)
+int perf_evsel__read_counter(struct evsel *evsel, int cpu, int thread)
 {
 	u64 read_format = evsel->attr.read_format;
 
@@ -1522,7 +1522,7 @@ int perf_evsel__read_counter(struct perf_evsel *evsel, int cpu, int thread)
 		return perf_evsel__read_one(evsel, cpu, thread);
 }
 
-int __perf_evsel__read_on_cpu(struct perf_evsel *evsel,
+int __perf_evsel__read_on_cpu(struct evsel *evsel,
 			      int cpu, int thread, bool scale)
 {
 	struct perf_counts_values count;
@@ -1543,9 +1543,9 @@ int __perf_evsel__read_on_cpu(struct perf_evsel *evsel,
 	return 0;
 }
 
-static int get_group_fd(struct perf_evsel *evsel, int cpu, int thread)
+static int get_group_fd(struct evsel *evsel, int cpu, int thread)
 {
-	struct perf_evsel *leader = evsel->leader;
+	struct evsel *leader = evsel->leader;
 	int fd;
 
 	if (perf_evsel__is_group_leader(evsel))
@@ -1708,7 +1708,7 @@ static int __open_attr__fprintf(FILE *fp, const char *name, const char *val,
 	return fprintf(fp, "  %-32s %s\n", name, val);
 }
 
-static void perf_evsel__remove_fd(struct perf_evsel *pos,
+static void perf_evsel__remove_fd(struct evsel *pos,
 				  int nr_cpus, int nr_threads,
 				  int thread_idx)
 {
@@ -1717,11 +1717,11 @@ static void perf_evsel__remove_fd(struct perf_evsel *pos,
 			FD(pos, cpu, thread) = FD(pos, cpu, thread + 1);
 }
 
-static int update_fds(struct perf_evsel *evsel,
+static int update_fds(struct evsel *evsel,
 		      int nr_cpus, int cpu_idx,
 		      int nr_threads, int thread_idx)
 {
-	struct perf_evsel *pos;
+	struct evsel *pos;
 
 	if (cpu_idx >= nr_cpus || thread_idx >= nr_threads)
 		return -EINVAL;
@@ -1741,7 +1741,7 @@ static int update_fds(struct perf_evsel *evsel,
 	return 0;
 }
 
-static bool ignore_missing_thread(struct perf_evsel *evsel,
+static bool ignore_missing_thread(struct evsel *evsel,
 				  int nr_cpus, int cpu,
 				  struct perf_thread_map *threads,
 				  int thread, int err)
@@ -1788,7 +1788,7 @@ static void display_attr(struct perf_event_attr *attr)
 	}
 }
 
-static int perf_event_open(struct perf_evsel *evsel,
+static int perf_event_open(struct evsel *evsel,
 			   pid_t pid, int cpu, int group_fd,
 			   unsigned long flags)
 {
@@ -1825,7 +1825,7 @@ static int perf_event_open(struct perf_evsel *evsel,
 	return fd;
 }
 
-int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
+int perf_evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 		     struct perf_thread_map *threads)
 {
 	int cpu, thread, nthreads;
@@ -2073,7 +2073,7 @@ int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
 	return err;
 }
 
-void perf_evsel__close(struct perf_evsel *evsel)
+void perf_evsel__close(struct evsel *evsel)
 {
 	if (evsel->fd == NULL)
 		return;
@@ -2083,19 +2083,19 @@ void perf_evsel__close(struct perf_evsel *evsel)
 	perf_evsel__free_id(evsel);
 }
 
-int perf_evsel__open_per_cpu(struct perf_evsel *evsel,
+int perf_evsel__open_per_cpu(struct evsel *evsel,
 			     struct perf_cpu_map *cpus)
 {
 	return perf_evsel__open(evsel, cpus, NULL);
 }
 
-int perf_evsel__open_per_thread(struct perf_evsel *evsel,
+int perf_evsel__open_per_thread(struct evsel *evsel,
 				struct perf_thread_map *threads)
 {
 	return perf_evsel__open(evsel, NULL, threads);
 }
 
-static int perf_evsel__parse_id_sample(const struct perf_evsel *evsel,
+static int perf_evsel__parse_id_sample(const struct evsel *evsel,
 				       const union perf_event *event,
 				       struct perf_sample *sample)
 {
@@ -2185,7 +2185,7 @@ perf_event__check_size(union perf_event *event, unsigned int sample_size)
 	return 0;
 }
 
-int perf_evsel__parse_sample(struct perf_evsel *evsel, union perf_event *event,
+int perf_evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 			     struct perf_sample *data)
 {
 	u64 type = evsel->attr.sample_type;
@@ -2464,7 +2464,7 @@ int perf_evsel__parse_sample(struct perf_evsel *evsel, union perf_event *event,
 	return 0;
 }
 
-int perf_evsel__parse_sample_timestamp(struct perf_evsel *evsel,
+int perf_evsel__parse_sample_timestamp(struct evsel *evsel,
 				       union perf_event *event,
 				       u64 *timestamp)
 {
@@ -2785,12 +2785,12 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type,
 	return 0;
 }
 
-struct tep_format_field *perf_evsel__field(struct perf_evsel *evsel, const char *name)
+struct tep_format_field *perf_evsel__field(struct evsel *evsel, const char *name)
 {
 	return tep_find_field(evsel->tp_format, name);
 }
 
-void *perf_evsel__rawptr(struct perf_evsel *evsel, struct perf_sample *sample,
+void *perf_evsel__rawptr(struct evsel *evsel, struct perf_sample *sample,
 			 const char *name)
 {
 	struct tep_format_field *field = perf_evsel__field(evsel, name);
@@ -2848,7 +2848,7 @@ u64 format_field__intval(struct tep_format_field *field, struct perf_sample *sam
 	return 0;
 }
 
-u64 perf_evsel__intval(struct perf_evsel *evsel, struct perf_sample *sample,
+u64 perf_evsel__intval(struct evsel *evsel, struct perf_sample *sample,
 		       const char *name)
 {
 	struct tep_format_field *field = perf_evsel__field(evsel, name);
@@ -2859,7 +2859,7 @@ u64 perf_evsel__intval(struct perf_evsel *evsel, struct perf_sample *sample,
 	return field ? format_field__intval(field, sample, evsel->needs_swap) : 0;
 }
 
-bool perf_evsel__fallback(struct perf_evsel *evsel, int err,
+bool perf_evsel__fallback(struct evsel *evsel, int err,
 			  char *msg, size_t msgsize)
 {
 	int paranoid;
@@ -2946,7 +2946,7 @@ static bool find_process(const char *name)
 	return ret ? false : true;
 }
 
-int perf_evsel__open_strerror(struct perf_evsel *evsel, struct target *target,
+int perf_evsel__open_strerror(struct evsel *evsel, struct target *target,
 			      int err, char *msg, size_t size)
 {
 	char sbuf[STRERR_BUFSIZE];
@@ -3037,14 +3037,14 @@ int perf_evsel__open_strerror(struct perf_evsel *evsel, struct target *target,
 			 perf_evsel__name(evsel));
 }
 
-struct perf_env *perf_evsel__env(struct perf_evsel *evsel)
+struct perf_env *perf_evsel__env(struct evsel *evsel)
 {
 	if (evsel && evsel->evlist)
 		return evsel->evlist->env;
 	return NULL;
 }
 
-static int store_evsel_ids(struct perf_evsel *evsel, struct perf_evlist *evlist)
+static int store_evsel_ids(struct evsel *evsel, struct perf_evlist *evlist)
 {
 	int cpu, thread;
 
@@ -3062,7 +3062,7 @@ static int store_evsel_ids(struct perf_evsel *evsel, struct perf_evlist *evlist)
 	return 0;
 }
 
-int perf_evsel__store_ids(struct perf_evsel *evsel, struct perf_evlist *evlist)
+int perf_evsel__store_ids(struct evsel *evsel, struct perf_evlist *evlist)
 {
 	struct perf_cpu_map *cpus = evsel->cpus;
 	struct perf_thread_map *threads = evsel->threads;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index ba2385f22e28..2c31c5e99524 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -12,7 +12,7 @@
 #include "cpumap.h"
 #include "counts.h"
 
-struct perf_evsel;
+struct evsel;
 
 /*
  * Per fd, to map back from PERF_SAMPLE_ID to evsel, only used when there are
@@ -21,7 +21,7 @@ struct perf_evsel;
 struct perf_sample_id {
 	struct hlist_node 	node;
 	u64		 	id;
-	struct perf_evsel	*evsel;
+	struct evsel		*evsel;
 	int			idx;
 	int			cpu;
 	pid_t			tid;
@@ -84,7 +84,7 @@ enum perf_tool_event {
 
 struct bpf_object;
 
-/** struct perf_evsel - event selector
+/** struct evsel - event selector
  *
  * @evlist - evlist this evsel is in, if it is in one.
  * @node - To insert it into evlist->entries or in other list_heads, say in
@@ -100,7 +100,7 @@ struct bpf_object;
  *          is used there is an id sample appended to non-sample events
  * @priv:   And what is in its containing unnamed union are tool specific
  */
-struct perf_evsel {
+struct evsel {
 	struct list_head	node;
 	struct perf_evlist	*evlist;
 	struct perf_event_attr	attr;
@@ -150,7 +150,7 @@ struct perf_evsel {
 	int			nr_members;
 	int			sample_read;
 	unsigned long		*per_pkg_mask;
-	struct perf_evsel	*leader;
+	struct evsel		*leader;
 	char			*group_name;
 	bool			cmdline_group_boundary;
 	struct list_head	config_terms;
@@ -160,7 +160,7 @@ struct perf_evsel {
 	bool			merged_stat;
 	const char *		metric_expr;
 	const char *		metric_name;
-	struct perf_evsel	**metric_events;
+	struct evsel		**metric_events;
 	bool			collect_stat;
 	bool			weak_group;
 	bool			percore;
@@ -197,12 +197,12 @@ struct target;
 struct thread_map;
 struct record_opts;
 
-static inline struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel)
+static inline struct perf_cpu_map *perf_evsel__cpus(struct evsel *evsel)
 {
 	return evsel->cpus;
 }
 
-static inline int perf_evsel__nr_cpus(struct perf_evsel *evsel)
+static inline int perf_evsel__nr_cpus(struct evsel *evsel)
 {
 	return perf_evsel__cpus(evsel)->nr;
 }
@@ -210,50 +210,50 @@ static inline int perf_evsel__nr_cpus(struct perf_evsel *evsel)
 void perf_counts_values__scale(struct perf_counts_values *count,
 			       bool scale, s8 *pscaled);
 
-void perf_evsel__compute_deltas(struct perf_evsel *evsel, int cpu, int thread,
+void perf_evsel__compute_deltas(struct evsel *evsel, int cpu, int thread,
 				struct perf_counts_values *count);
 
 int perf_evsel__object_config(size_t object_size,
-			      int (*init)(struct perf_evsel *evsel),
-			      void (*fini)(struct perf_evsel *evsel));
+			      int (*init)(struct evsel *evsel),
+			      void (*fini)(struct evsel *evsel));
 
-struct perf_evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx);
+struct evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx);
 
-static inline struct perf_evsel *perf_evsel__new(struct perf_event_attr *attr)
+static inline struct evsel *perf_evsel__new(struct perf_event_attr *attr)
 {
 	return perf_evsel__new_idx(attr, 0);
 }
 
-struct perf_evsel *perf_evsel__newtp_idx(const char *sys, const char *name, int idx);
+struct evsel *perf_evsel__newtp_idx(const char *sys, const char *name, int idx);
 
 /*
  * Returns pointer with encoded error via <linux/err.h> interface.
  */
-static inline struct perf_evsel *perf_evsel__newtp(const char *sys, const char *name)
+static inline struct evsel *perf_evsel__newtp(const char *sys, const char *name)
 {
 	return perf_evsel__newtp_idx(sys, name, 0);
 }
 
-struct perf_evsel *perf_evsel__new_cycles(bool precise);
+struct evsel *perf_evsel__new_cycles(bool precise);
 
 struct tep_event *event_format__new(const char *sys, const char *name);
 
-void perf_evsel__init(struct perf_evsel *evsel,
+void perf_evsel__init(struct evsel *evsel,
 		      struct perf_event_attr *attr, int idx);
-void perf_evsel__exit(struct perf_evsel *evsel);
-void perf_evsel__delete(struct perf_evsel *evsel);
+void perf_evsel__exit(struct evsel *evsel);
+void perf_evsel__delete(struct evsel *evsel);
 
 struct callchain_param;
 
-void perf_evsel__config(struct perf_evsel *evsel,
+void perf_evsel__config(struct evsel *evsel,
 			struct record_opts *opts,
 			struct callchain_param *callchain);
-void perf_evsel__config_callchain(struct perf_evsel *evsel,
+void perf_evsel__config_callchain(struct evsel *evsel,
 				  struct record_opts *opts,
 				  struct callchain_param *callchain);
 
 int __perf_evsel__sample_size(u64 sample_type);
-void perf_evsel__calc_id_pos(struct perf_evsel *evsel);
+void perf_evsel__calc_id_pos(struct evsel *evsel);
 
 bool perf_evsel__is_cache_op_valid(u8 type, u8 op);
 
@@ -269,17 +269,17 @@ extern const char *perf_evsel__hw_names[PERF_COUNT_HW_MAX];
 extern const char *perf_evsel__sw_names[PERF_COUNT_SW_MAX];
 int __perf_evsel__hw_cache_type_op_res_name(u8 type, u8 op, u8 result,
 					    char *bf, size_t size);
-const char *perf_evsel__name(struct perf_evsel *evsel);
+const char *perf_evsel__name(struct evsel *evsel);
 
-const char *perf_evsel__group_name(struct perf_evsel *evsel);
-int perf_evsel__group_desc(struct perf_evsel *evsel, char *buf, size_t size);
+const char *perf_evsel__group_name(struct evsel *evsel);
+int perf_evsel__group_desc(struct evsel *evsel, char *buf, size_t size);
 
-int perf_evsel__alloc_id(struct perf_evsel *evsel, int ncpus, int nthreads);
-void perf_evsel__close_fd(struct perf_evsel *evsel);
+int perf_evsel__alloc_id(struct evsel *evsel, int ncpus, int nthreads);
+void perf_evsel__close_fd(struct evsel *evsel);
 
-void __perf_evsel__set_sample_bit(struct perf_evsel *evsel,
+void __perf_evsel__set_sample_bit(struct evsel *evsel,
 				  enum perf_event_sample_format bit);
-void __perf_evsel__reset_sample_bit(struct perf_evsel *evsel,
+void __perf_evsel__reset_sample_bit(struct evsel *evsel,
 				    enum perf_event_sample_format bit);
 
 #define perf_evsel__set_sample_bit(evsel, bit) \
@@ -288,33 +288,33 @@ void __perf_evsel__reset_sample_bit(struct perf_evsel *evsel,
 #define perf_evsel__reset_sample_bit(evsel, bit) \
 	__perf_evsel__reset_sample_bit(evsel, PERF_SAMPLE_##bit)
 
-void perf_evsel__set_sample_id(struct perf_evsel *evsel,
+void perf_evsel__set_sample_id(struct evsel *evsel,
 			       bool use_sample_identifier);
 
-int perf_evsel__set_filter(struct perf_evsel *evsel, const char *filter);
-int perf_evsel__append_tp_filter(struct perf_evsel *evsel, const char *filter);
-int perf_evsel__append_addr_filter(struct perf_evsel *evsel,
+int perf_evsel__set_filter(struct evsel *evsel, const char *filter);
+int perf_evsel__append_tp_filter(struct evsel *evsel, const char *filter);
+int perf_evsel__append_addr_filter(struct evsel *evsel,
 				   const char *filter);
-int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter);
-int perf_evsel__enable(struct perf_evsel *evsel);
-int perf_evsel__disable(struct perf_evsel *evsel);
+int perf_evsel__apply_filter(struct evsel *evsel, const char *filter);
+int perf_evsel__enable(struct evsel *evsel);
+int perf_evsel__disable(struct evsel *evsel);
 
-int perf_evsel__open_per_cpu(struct perf_evsel *evsel,
+int perf_evsel__open_per_cpu(struct evsel *evsel,
 			     struct perf_cpu_map *cpus);
-int perf_evsel__open_per_thread(struct perf_evsel *evsel,
+int perf_evsel__open_per_thread(struct evsel *evsel,
 				struct perf_thread_map *threads);
-int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
+int perf_evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 		     struct perf_thread_map *threads);
-void perf_evsel__close(struct perf_evsel *evsel);
+void perf_evsel__close(struct evsel *evsel);
 
 struct perf_sample;
 
-void *perf_evsel__rawptr(struct perf_evsel *evsel, struct perf_sample *sample,
+void *perf_evsel__rawptr(struct evsel *evsel, struct perf_sample *sample,
 			 const char *name);
-u64 perf_evsel__intval(struct perf_evsel *evsel, struct perf_sample *sample,
+u64 perf_evsel__intval(struct evsel *evsel, struct perf_sample *sample,
 		       const char *name);
 
-static inline char *perf_evsel__strval(struct perf_evsel *evsel,
+static inline char *perf_evsel__strval(struct evsel *evsel,
 				       struct perf_sample *sample,
 				       const char *name)
 {
@@ -325,14 +325,14 @@ struct tep_format_field;
 
 u64 format_field__intval(struct tep_format_field *field, struct perf_sample *sample, bool needs_swap);
 
-struct tep_format_field *perf_evsel__field(struct perf_evsel *evsel, const char *name);
+struct tep_format_field *perf_evsel__field(struct evsel *evsel, const char *name);
 
 #define perf_evsel__match(evsel, t, c)		\
 	(evsel->attr.type == PERF_TYPE_##t &&	\
 	 evsel->attr.config == PERF_COUNT_##c)
 
-static inline bool perf_evsel__match2(struct perf_evsel *e1,
-				      struct perf_evsel *e2)
+static inline bool perf_evsel__match2(struct evsel *e1,
+				      struct evsel *e2)
 {
 	return (e1->attr.type == e2->attr.type) &&
 	       (e1->attr.config == e2->attr.config);
@@ -344,12 +344,12 @@ static inline bool perf_evsel__match2(struct perf_evsel *e1,
 	 (a)->attr.type == (b)->attr.type &&	\
 	 (a)->attr.config == (b)->attr.config)
 
-int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
+int perf_evsel__read(struct evsel *evsel, int cpu, int thread,
 		     struct perf_counts_values *count);
 
-int perf_evsel__read_counter(struct perf_evsel *evsel, int cpu, int thread);
+int perf_evsel__read_counter(struct evsel *evsel, int cpu, int thread);
 
-int __perf_evsel__read_on_cpu(struct perf_evsel *evsel,
+int __perf_evsel__read_on_cpu(struct evsel *evsel,
 			      int cpu, int thread, bool scale);
 
 /**
@@ -359,7 +359,7 @@ int __perf_evsel__read_on_cpu(struct perf_evsel *evsel,
  * @cpu - CPU of interest
  * @thread - thread of interest
  */
-static inline int perf_evsel__read_on_cpu(struct perf_evsel *evsel,
+static inline int perf_evsel__read_on_cpu(struct evsel *evsel,
 					  int cpu, int thread)
 {
 	return __perf_evsel__read_on_cpu(evsel, cpu, thread, false);
@@ -372,27 +372,27 @@ static inline int perf_evsel__read_on_cpu(struct perf_evsel *evsel,
  * @cpu - CPU of interest
  * @thread - thread of interest
  */
-static inline int perf_evsel__read_on_cpu_scaled(struct perf_evsel *evsel,
+static inline int perf_evsel__read_on_cpu_scaled(struct evsel *evsel,
 						 int cpu, int thread)
 {
 	return __perf_evsel__read_on_cpu(evsel, cpu, thread, true);
 }
 
-int perf_evsel__parse_sample(struct perf_evsel *evsel, union perf_event *event,
+int perf_evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 			     struct perf_sample *sample);
 
-int perf_evsel__parse_sample_timestamp(struct perf_evsel *evsel,
+int perf_evsel__parse_sample_timestamp(struct evsel *evsel,
 				       union perf_event *event,
 				       u64 *timestamp);
 
-static inline struct perf_evsel *perf_evsel__next(struct perf_evsel *evsel)
+static inline struct evsel *perf_evsel__next(struct evsel *evsel)
 {
-	return list_entry(evsel->node.next, struct perf_evsel, node);
+	return list_entry(evsel->node.next, struct evsel, node);
 }
 
-static inline struct perf_evsel *perf_evsel__prev(struct perf_evsel *evsel)
+static inline struct evsel *perf_evsel__prev(struct evsel *evsel)
 {
-	return list_entry(evsel->node.prev, struct perf_evsel, node);
+	return list_entry(evsel->node.prev, struct evsel, node);
 }
 
 /**
@@ -402,7 +402,7 @@ static inline struct perf_evsel *perf_evsel__prev(struct perf_evsel *evsel)
  *
  * Return %true if @evsel is a group leader or a stand-alone event
  */
-static inline bool perf_evsel__is_group_leader(const struct perf_evsel *evsel)
+static inline bool perf_evsel__is_group_leader(const struct evsel *evsel)
 {
 	return evsel->leader == evsel;
 }
@@ -415,7 +415,7 @@ static inline bool perf_evsel__is_group_leader(const struct perf_evsel *evsel)
  * Return %true iff event group view is enabled and @evsel is a actual group
  * leader which has other members in the group
  */
-static inline bool perf_evsel__is_group_event(struct perf_evsel *evsel)
+static inline bool perf_evsel__is_group_event(struct evsel *evsel)
 {
 	if (!symbol_conf.event_group)
 		return false;
@@ -423,14 +423,14 @@ static inline bool perf_evsel__is_group_event(struct perf_evsel *evsel)
 	return perf_evsel__is_group_leader(evsel) && evsel->nr_members > 1;
 }
 
-bool perf_evsel__is_function_event(struct perf_evsel *evsel);
+bool perf_evsel__is_function_event(struct evsel *evsel);
 
-static inline bool perf_evsel__is_bpf_output(struct perf_evsel *evsel)
+static inline bool perf_evsel__is_bpf_output(struct evsel *evsel)
 {
 	return perf_evsel__match(evsel, SOFTWARE, SW_BPF_OUTPUT);
 }
 
-static inline bool perf_evsel__is_clock(struct perf_evsel *evsel)
+static inline bool perf_evsel__is_clock(struct evsel *evsel)
 {
 	return perf_evsel__match(evsel, SOFTWARE, SW_CPU_CLOCK) ||
 	       perf_evsel__match(evsel, SOFTWARE, SW_TASK_CLOCK);
@@ -444,7 +444,7 @@ struct perf_attr_details {
 	bool trace_fields;
 };
 
-int perf_evsel__fprintf(struct perf_evsel *evsel,
+int perf_evsel__fprintf(struct evsel *evsel,
 			struct perf_attr_details *details, FILE *fp);
 
 #define EVSEL__PRINT_IP			(1<<0)
@@ -467,34 +467,34 @@ int sample__fprintf_sym(struct perf_sample *sample, struct addr_location *al,
 			int left_alignment, unsigned int print_opts,
 			struct callchain_cursor *cursor, FILE *fp);
 
-bool perf_evsel__fallback(struct perf_evsel *evsel, int err,
+bool perf_evsel__fallback(struct evsel *evsel, int err,
 			  char *msg, size_t msgsize);
-int perf_evsel__open_strerror(struct perf_evsel *evsel, struct target *target,
+int perf_evsel__open_strerror(struct evsel *evsel, struct target *target,
 			      int err, char *msg, size_t size);
 
-static inline int perf_evsel__group_idx(struct perf_evsel *evsel)
+static inline int perf_evsel__group_idx(struct evsel *evsel)
 {
 	return evsel->idx - evsel->leader->idx;
 }
 
 /* Iterates group WITHOUT the leader. */
 #define for_each_group_member(_evsel, _leader) 					\
-for ((_evsel) = list_entry((_leader)->node.next, struct perf_evsel, node); 	\
+for ((_evsel) = list_entry((_leader)->node.next, struct evsel, node); 	\
      (_evsel) && (_evsel)->leader == (_leader);					\
-     (_evsel) = list_entry((_evsel)->node.next, struct perf_evsel, node))
+     (_evsel) = list_entry((_evsel)->node.next, struct evsel, node))
 
 /* Iterates group WITH the leader. */
 #define for_each_group_evsel(_evsel, _leader) 					\
 for ((_evsel) = _leader; 							\
      (_evsel) && (_evsel)->leader == (_leader);					\
-     (_evsel) = list_entry((_evsel)->node.next, struct perf_evsel, node))
+     (_evsel) = list_entry((_evsel)->node.next, struct evsel, node))
 
-static inline bool perf_evsel__has_branch_callstack(const struct perf_evsel *evsel)
+static inline bool perf_evsel__has_branch_callstack(const struct evsel *evsel)
 {
 	return evsel->attr.branch_sample_type & PERF_SAMPLE_BRANCH_CALL_STACK;
 }
 
-static inline bool evsel__has_callchain(const struct perf_evsel *evsel)
+static inline bool evsel__has_callchain(const struct evsel *evsel)
 {
 	return (evsel->attr.sample_type & PERF_SAMPLE_CALLCHAIN) != 0;
 }
@@ -504,7 +504,7 @@ typedef int (*attr__fprintf_f)(FILE *, const char *, const char *, void *);
 int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 			     attr__fprintf_f attr__fprintf, void *priv);
 
-struct perf_env *perf_evsel__env(struct perf_evsel *evsel);
+struct perf_env *perf_evsel__env(struct evsel *evsel);
 
-int perf_evsel__store_ids(struct perf_evsel *evsel, struct perf_evlist *evlist);
+int perf_evsel__store_ids(struct evsel *evsel, struct perf_evlist *evlist);
 #endif /* __PERF_EVSEL_H */
diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index 95ea147f9e18..1fddb7da4b51 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -33,14 +33,14 @@ static int __print_attr__fprintf(FILE *fp, const char *name, const char *val, vo
 	return comma_fprintf(fp, (bool *)priv, " %s: %s", name, val);
 }
 
-int perf_evsel__fprintf(struct perf_evsel *evsel,
+int perf_evsel__fprintf(struct evsel *evsel,
 			struct perf_attr_details *details, FILE *fp)
 {
 	bool first = true;
 	int printed = 0;
 
 	if (details->event_group) {
-		struct perf_evsel *pos;
+		struct evsel *pos;
 
 		if (!perf_evsel__is_group_leader(evsel))
 			return 0;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 496c0ab851ca..60c1d89a404b 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -74,7 +74,7 @@ struct feat_fd {
 	void			*buf;	/* Either buf != NULL or fd >= 0 */
 	ssize_t			offset;
 	size_t			size;
-	struct perf_evsel	*events;
+	struct evsel	*events;
 };
 
 void perf_header__set_feat(struct perf_header *header, int feat)
@@ -472,7 +472,7 @@ static int write_nrcpus(struct feat_fd *ff,
 static int write_event_desc(struct feat_fd *ff,
 			    struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	u32 nre, nri, sz;
 	int ret;
 
@@ -762,7 +762,7 @@ static int write_group_desc(struct feat_fd *ff,
 			    struct perf_evlist *evlist)
 {
 	u32 nr_groups = evlist->nr_groups;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	int ret;
 
 	ret = do_write(ff, &nr_groups, sizeof(nr_groups));
@@ -1568,9 +1568,9 @@ static void print_bpf_btf(struct feat_fd *ff, FILE *fp)
 	up_read(&env->bpf_progs.lock);
 }
 
-static void free_event_desc(struct perf_evsel *events)
+static void free_event_desc(struct evsel *events)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	if (!events)
 		return;
@@ -1583,9 +1583,9 @@ static void free_event_desc(struct perf_evsel *events)
 	free(events);
 }
 
-static struct perf_evsel *read_event_desc(struct feat_fd *ff)
+static struct evsel *read_event_desc(struct feat_fd *ff)
 {
-	struct perf_evsel *evsel, *events = NULL;
+	struct evsel *evsel, *events = NULL;
 	u64 *id;
 	void *buf = NULL;
 	u32 nre, sz, nr, i, j;
@@ -1669,7 +1669,7 @@ static int __desc_attr__fprintf(FILE *fp, const char *name, const char *val,
 
 static void print_event_desc(struct feat_fd *ff, FILE *fp)
 {
-	struct perf_evsel *evsel, *events;
+	struct evsel *evsel, *events;
 	u32 j;
 	u64 *id;
 
@@ -1804,7 +1804,7 @@ static void print_pmu_mappings(struct feat_fd *ff, FILE *fp)
 static void print_group_desc(struct feat_fd *ff, FILE *fp)
 {
 	struct perf_session *session;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	u32 nr = 0;
 
 	session = container_of(ff->ph, struct perf_session, header);
@@ -2089,10 +2089,10 @@ static int process_total_mem(struct feat_fd *ff, void *data __maybe_unused)
 	return 0;
 }
 
-static struct perf_evsel *
+static struct evsel *
 perf_evlist__find_by_index(struct perf_evlist *evlist, int idx)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (evsel->idx == idx)
@@ -2104,9 +2104,9 @@ perf_evlist__find_by_index(struct perf_evlist *evlist, int idx)
 
 static void
 perf_evlist__set_event_name(struct perf_evlist *evlist,
-			    struct perf_evsel *event)
+			    struct evsel *event)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	if (!event->name)
 		return;
@@ -2125,7 +2125,7 @@ static int
 process_event_desc(struct feat_fd *ff, void *data __maybe_unused)
 {
 	struct perf_session *session;
-	struct perf_evsel *evsel, *events = read_event_desc(ff);
+	struct evsel *evsel, *events = read_event_desc(ff);
 
 	if (!events)
 		return 0;
@@ -2415,7 +2415,7 @@ static int process_group_desc(struct feat_fd *ff, void *data __maybe_unused)
 	size_t ret = -1;
 	u32 i, nr, nr_groups;
 	struct perf_session *session;
-	struct perf_evsel *evsel, *leader = NULL;
+	struct evsel *evsel, *leader = NULL;
 	struct group_desc {
 		char *name;
 		u32 leader_idx;
@@ -3050,7 +3050,7 @@ int perf_session__write_header(struct perf_session *session,
 	struct perf_file_header f_header;
 	struct perf_file_attr   f_attr;
 	struct perf_header *header = &session->header;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	struct feat_fd ff;
 	u64 attr_offset;
 	int err;
@@ -3479,7 +3479,7 @@ static int read_attr(int fd, struct perf_header *ph,
 	return ret <= 0 ? -1 : 0;
 }
 
-static int perf_evsel__prepare_tracepoint_event(struct perf_evsel *evsel,
+static int perf_evsel__prepare_tracepoint_event(struct evsel *evsel,
 						struct tep_handle *pevent)
 {
 	struct tep_event *event;
@@ -3514,7 +3514,7 @@ static int perf_evsel__prepare_tracepoint_event(struct perf_evsel *evsel,
 static int perf_evlist__prepare_tracepoint_events(struct perf_evlist *evlist,
 						  struct tep_handle *pevent)
 {
-	struct perf_evsel *pos;
+	struct evsel *pos;
 
 	evlist__for_each_entry(evlist, pos) {
 		if (pos->attr.type == PERF_TYPE_TRACEPOINT &&
@@ -3563,7 +3563,7 @@ int perf_session__read_header(struct perf_session *session)
 	lseek(fd, f_header.attrs.offset, SEEK_SET);
 
 	for (i = 0; i < nr_attrs; i++) {
-		struct perf_evsel *evsel;
+		struct evsel *evsel;
 		off_t tmp;
 
 		if (read_attr(fd, header, &f_attr) < 0)
@@ -3787,7 +3787,7 @@ event_update_event__new(size_t size, u64 type, u64 id)
 
 int
 perf_event__synthesize_event_update_unit(struct perf_tool *tool,
-					 struct perf_evsel *evsel,
+					 struct evsel *evsel,
 					 perf_event__handler_t process)
 {
 	struct event_update_event *ev;
@@ -3806,7 +3806,7 @@ perf_event__synthesize_event_update_unit(struct perf_tool *tool,
 
 int
 perf_event__synthesize_event_update_scale(struct perf_tool *tool,
-					  struct perf_evsel *evsel,
+					  struct evsel *evsel,
 					  perf_event__handler_t process)
 {
 	struct event_update_event *ev;
@@ -3826,7 +3826,7 @@ perf_event__synthesize_event_update_scale(struct perf_tool *tool,
 
 int
 perf_event__synthesize_event_update_name(struct perf_tool *tool,
-					 struct perf_evsel *evsel,
+					 struct evsel *evsel,
 					 perf_event__handler_t process)
 {
 	struct event_update_event *ev;
@@ -3845,7 +3845,7 @@ perf_event__synthesize_event_update_name(struct perf_tool *tool,
 
 int
 perf_event__synthesize_event_update_cpus(struct perf_tool *tool,
-					struct perf_evsel *evsel,
+					struct evsel *evsel,
 					perf_event__handler_t process)
 {
 	size_t size = sizeof(struct event_update_event);
@@ -3917,7 +3917,7 @@ int perf_event__synthesize_attrs(struct perf_tool *tool,
 				 struct perf_evlist *evlist,
 				 perf_event__handler_t process)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	int err = 0;
 
 	evlist__for_each_entry(evlist, evsel) {
@@ -3932,12 +3932,12 @@ int perf_event__synthesize_attrs(struct perf_tool *tool,
 	return err;
 }
 
-static bool has_unit(struct perf_evsel *counter)
+static bool has_unit(struct evsel *counter)
 {
 	return counter->unit && *counter->unit;
 }
 
-static bool has_scale(struct perf_evsel *counter)
+static bool has_scale(struct evsel *counter)
 {
 	return counter->scale != 1;
 }
@@ -3947,7 +3947,7 @@ int perf_event__synthesize_extra_attr(struct perf_tool *tool,
 				      perf_event__handler_t process,
 				      bool is_pipe)
 {
-	struct perf_evsel *counter;
+	struct evsel *counter;
 	int err;
 
 	/*
@@ -4005,7 +4005,7 @@ int perf_event__process_attr(struct perf_tool *tool __maybe_unused,
 			     struct perf_evlist **pevlist)
 {
 	u32 i, ids, n_ids;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	struct perf_evlist *evlist = *pevlist;
 
 	if (evlist == NULL) {
@@ -4046,7 +4046,7 @@ int perf_event__process_event_update(struct perf_tool *tool __maybe_unused,
 	struct event_update_event_scale *ev_scale;
 	struct event_update_event_cpus *ev_cpus;
 	struct perf_evlist *evlist;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	struct perf_cpu_map *map;
 
 	if (!pevlist || *pevlist == NULL)
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 5b3abe4172e2..437d8617de27 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -135,16 +135,16 @@ int perf_event__synthesize_attrs(struct perf_tool *tool,
 				 struct perf_evlist *evlist,
 				 perf_event__handler_t process);
 int perf_event__synthesize_event_update_unit(struct perf_tool *tool,
-					     struct perf_evsel *evsel,
+					     struct evsel *evsel,
 					     perf_event__handler_t process);
 int perf_event__synthesize_event_update_scale(struct perf_tool *tool,
-					      struct perf_evsel *evsel,
+					      struct evsel *evsel,
 					      perf_event__handler_t process);
 int perf_event__synthesize_event_update_name(struct perf_tool *tool,
-					     struct perf_evsel *evsel,
+					     struct evsel *evsel,
 					     perf_event__handler_t process);
 int perf_event__synthesize_event_update_cpus(struct perf_tool *tool,
-					     struct perf_evsel *evsel,
+					     struct evsel *evsel,
 					     perf_event__handler_t process);
 int perf_event__process_attr(struct perf_tool *tool, union perf_event *event,
 			     struct perf_evlist **pevlist);
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index f24fd1954f6c..3da49c479880 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -816,7 +816,7 @@ static int
 iter_finish_mem_entry(struct hist_entry_iter *iter,
 		      struct addr_location *al __maybe_unused)
 {
-	struct perf_evsel *evsel = iter->evsel;
+	struct evsel *evsel = iter->evsel;
 	struct hists *hists = evsel__hists(evsel);
 	struct hist_entry *he = iter->he;
 	int err = -EINVAL;
@@ -886,7 +886,7 @@ static int
 iter_add_next_branch_entry(struct hist_entry_iter *iter, struct addr_location *al)
 {
 	struct branch_info *bi;
-	struct perf_evsel *evsel = iter->evsel;
+	struct evsel *evsel = iter->evsel;
 	struct hists *hists = evsel__hists(evsel);
 	struct perf_sample *sample = iter->sample;
 	struct hist_entry *he = NULL;
@@ -938,7 +938,7 @@ iter_prepare_normal_entry(struct hist_entry_iter *iter __maybe_unused,
 static int
 iter_add_single_normal_entry(struct hist_entry_iter *iter, struct addr_location *al)
 {
-	struct perf_evsel *evsel = iter->evsel;
+	struct evsel *evsel = iter->evsel;
 	struct perf_sample *sample = iter->sample;
 	struct hist_entry *he;
 
@@ -956,7 +956,7 @@ iter_finish_normal_entry(struct hist_entry_iter *iter,
 			 struct addr_location *al __maybe_unused)
 {
 	struct hist_entry *he = iter->he;
-	struct perf_evsel *evsel = iter->evsel;
+	struct evsel *evsel = iter->evsel;
 	struct perf_sample *sample = iter->sample;
 
 	if (he == NULL)
@@ -996,7 +996,7 @@ static int
 iter_add_single_cumulative_entry(struct hist_entry_iter *iter,
 				 struct addr_location *al)
 {
-	struct perf_evsel *evsel = iter->evsel;
+	struct evsel *evsel = iter->evsel;
 	struct hists *hists = evsel__hists(evsel);
 	struct perf_sample *sample = iter->sample;
 	struct hist_entry **he_cache = iter->priv;
@@ -1041,7 +1041,7 @@ static int
 iter_add_next_cumulative_entry(struct hist_entry_iter *iter,
 			       struct addr_location *al)
 {
-	struct perf_evsel *evsel = iter->evsel;
+	struct evsel *evsel = iter->evsel;
 	struct perf_sample *sample = iter->sample;
 	struct hist_entry **he_cache = iter->priv;
 	struct hist_entry *he;
@@ -1873,7 +1873,7 @@ static void output_resort(struct hists *hists, struct ui_progress *prog,
 	}
 }
 
-void perf_evsel__output_resort_cb(struct perf_evsel *evsel, struct ui_progress *prog,
+void perf_evsel__output_resort_cb(struct evsel *evsel, struct ui_progress *prog,
 				  hists__resort_cb_t cb, void *cb_arg)
 {
 	bool use_callchain;
@@ -1888,7 +1888,7 @@ void perf_evsel__output_resort_cb(struct perf_evsel *evsel, struct ui_progress *
 	output_resort(evsel__hists(evsel), prog, use_callchain, cb, cb_arg);
 }
 
-void perf_evsel__output_resort(struct perf_evsel *evsel, struct ui_progress *prog)
+void perf_evsel__output_resort(struct evsel *evsel, struct ui_progress *prog)
 {
 	return perf_evsel__output_resort_cb(evsel, prog, NULL, NULL);
 }
@@ -2575,7 +2575,7 @@ void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
 
 size_t perf_evlist__fprintf_nr_events(struct perf_evlist *evlist, FILE *fp)
 {
-	struct perf_evsel *pos;
+	struct evsel *pos;
 	size_t ret = 0;
 
 	evlist__for_each_entry(evlist, pos) {
@@ -2602,7 +2602,7 @@ int __hists__scnprintf_title(struct hists *hists, char *bf, size_t size, bool sh
 	int socket_id = hists->socket_filter;
 	unsigned long nr_samples = hists->stats.nr_events[PERF_RECORD_SAMPLE];
 	u64 nr_events = hists->stats.total_period;
-	struct perf_evsel *evsel = hists_to_evsel(hists);
+	struct evsel *evsel = hists_to_evsel(hists);
 	const char *ev_name = perf_evsel__name(evsel);
 	char buf[512], sample_freq_str[64] = "";
 	size_t buflen = sizeof(buf);
@@ -2615,7 +2615,7 @@ int __hists__scnprintf_title(struct hists *hists, char *bf, size_t size, bool sh
 	}
 
 	if (perf_evsel__is_group_event(evsel)) {
-		struct perf_evsel *pos;
+		struct evsel *pos;
 
 		perf_evsel__group_desc(evsel, buf, buflen);
 		ev_name = buf;
@@ -2731,7 +2731,7 @@ static void hists__delete_all_entries(struct hists *hists)
 	hists__delete_remaining_entries(&hists->entries_collapsed);
 }
 
-static void hists_evsel__exit(struct perf_evsel *evsel)
+static void hists_evsel__exit(struct evsel *evsel)
 {
 	struct hists *hists = evsel__hists(evsel);
 	struct perf_hpp_fmt *fmt, *pos;
@@ -2749,7 +2749,7 @@ static void hists_evsel__exit(struct perf_evsel *evsel)
 	}
 }
 
-static int hists_evsel__init(struct perf_evsel *evsel)
+static int hists_evsel__init(struct evsel *evsel)
 {
 	struct hists *hists = evsel__hists(evsel);
 
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 24635f36148d..9bf247c638b8 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -116,7 +116,7 @@ struct hist_entry_iter {
 
 	bool hide_unresolved;
 
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	struct perf_sample *sample;
 	struct hist_entry *he;
 	struct symbol *parent;
@@ -171,9 +171,9 @@ void hist_entry__delete(struct hist_entry *he);
 
 typedef int (*hists__resort_cb_t)(struct hist_entry *he, void *arg);
 
-void perf_evsel__output_resort_cb(struct perf_evsel *evsel, struct ui_progress *prog,
+void perf_evsel__output_resort_cb(struct evsel *evsel, struct ui_progress *prog,
 				  hists__resort_cb_t cb, void *cb_arg);
-void perf_evsel__output_resort(struct perf_evsel *evsel, struct ui_progress *prog);
+void perf_evsel__output_resort(struct evsel *evsel, struct ui_progress *prog);
 void hists__output_resort(struct hists *hists, struct ui_progress *prog);
 void hists__output_resort_cb(struct hists *hists, struct ui_progress *prog,
 			     hists__resort_cb_t cb);
@@ -219,17 +219,17 @@ void hists__match(struct hists *leader, struct hists *other);
 int hists__link(struct hists *leader, struct hists *other);
 
 struct hists_evsel {
-	struct perf_evsel evsel;
+	struct evsel evsel;
 	struct hists	  hists;
 };
 
-static inline struct perf_evsel *hists_to_evsel(struct hists *hists)
+static inline struct evsel *hists_to_evsel(struct hists *hists)
 {
 	struct hists_evsel *hevsel = container_of(hists, struct hists_evsel, hists);
 	return &hevsel->evsel;
 }
 
-static inline struct hists *evsel__hists(struct perf_evsel *evsel)
+static inline struct hists *evsel__hists(struct evsel *evsel)
 {
 	struct hists_evsel *hevsel = (struct hists_evsel *)evsel;
 	return &hevsel->hists;
@@ -453,11 +453,11 @@ enum rstype {
 #include "../ui/keysyms.h"
 void attr_to_script(char *buf, struct perf_event_attr *attr);
 
-int map_symbol__tui_annotate(struct map_symbol *ms, struct perf_evsel *evsel,
+int map_symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
 			     struct hist_browser_timer *hbt,
 			     struct annotation_options *annotation_opts);
 
-int hist_entry__tui_annotate(struct hist_entry *he, struct perf_evsel *evsel,
+int hist_entry__tui_annotate(struct hist_entry *he, struct evsel *evsel,
 			     struct hist_browser_timer *hbt,
 			     struct annotation_options *annotation_opts);
 
@@ -468,11 +468,11 @@ int perf_evlist__tui_browse_hists(struct perf_evlist *evlist, const char *help,
 				  bool warn_lost_event,
 				  struct annotation_options *annotation_options);
 
-int script_browse(const char *script_opt, struct perf_evsel *evsel);
+int script_browse(const char *script_opt, struct evsel *evsel);
 
 void run_script(char *cmd);
 int res_sample_browse(struct res_sample *res_samples, int num_res,
-		      struct perf_evsel *evsel, enum rstype rstype);
+		      struct evsel *evsel, enum rstype rstype);
 void res_sample_init(void);
 #else
 static inline
@@ -487,7 +487,7 @@ int perf_evlist__tui_browse_hists(struct perf_evlist *evlist __maybe_unused,
 	return 0;
 }
 static inline int map_symbol__tui_annotate(struct map_symbol *ms __maybe_unused,
-					   struct perf_evsel *evsel __maybe_unused,
+					   struct evsel *evsel __maybe_unused,
 					   struct hist_browser_timer *hbt __maybe_unused,
 					   struct annotation_options *annotation_options __maybe_unused)
 {
@@ -495,7 +495,7 @@ static inline int map_symbol__tui_annotate(struct map_symbol *ms __maybe_unused,
 }
 
 static inline int hist_entry__tui_annotate(struct hist_entry *he __maybe_unused,
-					   struct perf_evsel *evsel __maybe_unused,
+					   struct evsel *evsel __maybe_unused,
 					   struct hist_browser_timer *hbt __maybe_unused,
 					   struct annotation_options *annotation_opts __maybe_unused)
 {
@@ -503,14 +503,14 @@ static inline int hist_entry__tui_annotate(struct hist_entry *he __maybe_unused,
 }
 
 static inline int script_browse(const char *script_opt __maybe_unused,
-				struct perf_evsel *evsel __maybe_unused)
+				struct evsel *evsel __maybe_unused)
 {
 	return 0;
 }
 
 static inline int res_sample_browse(struct res_sample *res_samples __maybe_unused,
 				    int num_res __maybe_unused,
-				    struct perf_evsel *evsel __maybe_unused,
+				    struct evsel *evsel __maybe_unused,
 				    enum rstype rstype __maybe_unused)
 {
 	return 0;
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 5560e95afdda..8fd46d5f4b39 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -761,7 +761,7 @@ static int intel_bts_synth_events(struct intel_bts *bts,
 				  struct perf_session *session)
 {
 	struct perf_evlist *evlist = session->evlist;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	struct perf_event_attr attr;
 	bool found = false;
 	u64 id;
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index df061599fef4..f1595b86d7c7 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -56,7 +56,7 @@ struct intel_pt {
 	u32 auxtrace_type;
 	struct perf_session *session;
 	struct machine *machine;
-	struct perf_evsel *switch_evsel;
+	struct evsel *switch_evsel;
 	struct thread *unknown_thread;
 	bool timeless_decoding;
 	bool sampling_mode;
@@ -104,7 +104,7 @@ struct intel_pt {
 	u64 cbr_id;
 
 	bool sample_pebs;
-	struct perf_evsel *pebs_evsel;
+	struct evsel *pebs_evsel;
 
 	u64 tsc_bit;
 	u64 mtc_bit;
@@ -723,7 +723,7 @@ static bool intel_pt_get_config(struct intel_pt *pt,
 
 static bool intel_pt_exclude_kernel(struct intel_pt *pt)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	evlist__for_each_entry(pt->session->evlist, evsel) {
 		if (intel_pt_get_config(pt, &evsel->attr, NULL) &&
@@ -735,7 +735,7 @@ static bool intel_pt_exclude_kernel(struct intel_pt *pt)
 
 static bool intel_pt_return_compression(struct intel_pt *pt)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	u64 config;
 
 	if (!pt->noretcomp_bit)
@@ -751,7 +751,7 @@ static bool intel_pt_return_compression(struct intel_pt *pt)
 
 static bool intel_pt_branch_enable(struct intel_pt *pt)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	u64 config;
 
 	evlist__for_each_entry(pt->session->evlist, evsel) {
@@ -764,7 +764,7 @@ static bool intel_pt_branch_enable(struct intel_pt *pt)
 
 static unsigned int intel_pt_mtc_period(struct intel_pt *pt)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	unsigned int shift;
 	u64 config;
 
@@ -783,7 +783,7 @@ static unsigned int intel_pt_mtc_period(struct intel_pt *pt)
 
 static bool intel_pt_timeless_decoding(struct intel_pt *pt)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	bool timeless_decoding = true;
 	u64 config;
 
@@ -805,7 +805,7 @@ static bool intel_pt_timeless_decoding(struct intel_pt *pt)
 
 static bool intel_pt_tracing_kernel(struct intel_pt *pt)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	evlist__for_each_entry(pt->session->evlist, evsel) {
 		if (intel_pt_get_config(pt, &evsel->attr, NULL) &&
@@ -817,7 +817,7 @@ static bool intel_pt_tracing_kernel(struct intel_pt *pt)
 
 static bool intel_pt_have_tsc(struct intel_pt *pt)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	bool have_tsc = false;
 	u64 config;
 
@@ -1702,7 +1702,7 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 	struct perf_sample sample = { .ip = 0, };
 	union perf_event *event = ptq->event_buf;
 	struct intel_pt *pt = ptq->pt;
-	struct perf_evsel *evsel = pt->pebs_evsel;
+	struct evsel *evsel = pt->pebs_evsel;
 	u64 sample_type = evsel->attr.sample_type;
 	u64 id = evsel->id[0];
 	u8 cpumode;
@@ -2401,7 +2401,7 @@ static int intel_pt_sync_switch(struct intel_pt *pt, int cpu, pid_t tid,
 static int intel_pt_process_switch(struct intel_pt *pt,
 				   struct perf_sample *sample)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	pid_t tid;
 	int cpu, ret;
 
@@ -2716,7 +2716,7 @@ static int intel_pt_synth_event(struct perf_session *session, const char *name,
 static void intel_pt_set_event_name(struct perf_evlist *evlist, u64 id,
 				    const char *name)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (evsel->id && evsel->id[0] == id) {
@@ -2728,10 +2728,10 @@ static void intel_pt_set_event_name(struct perf_evlist *evlist, u64 id,
 	}
 }
 
-static struct perf_evsel *intel_pt_evsel(struct intel_pt *pt,
+static struct evsel *intel_pt_evsel(struct intel_pt *pt,
 					 struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (evsel->attr.type == pt->pmu_type && evsel->ids)
@@ -2745,7 +2745,7 @@ static int intel_pt_synth_events(struct intel_pt *pt,
 				 struct perf_session *session)
 {
 	struct perf_evlist *evlist = session->evlist;
-	struct perf_evsel *evsel = intel_pt_evsel(pt, evlist);
+	struct evsel *evsel = intel_pt_evsel(pt, evlist);
 	struct perf_event_attr attr;
 	u64 id;
 	int err;
@@ -2894,9 +2894,9 @@ static int intel_pt_synth_events(struct intel_pt *pt,
 	return 0;
 }
 
-static struct perf_evsel *intel_pt_find_sched_switch(struct perf_evlist *evlist)
+static struct evsel *intel_pt_find_sched_switch(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	evlist__for_each_entry_reverse(evlist, evsel) {
 		const char *name = perf_evsel__name(evsel);
@@ -2910,7 +2910,7 @@ static struct perf_evsel *intel_pt_find_sched_switch(struct perf_evlist *evlist)
 
 static bool intel_pt_find_switch(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (evsel->attr.context_switch)
diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 18c34f0c1966..8df60703411a 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -118,7 +118,7 @@ jit_close(struct jit_buf_desc *jd)
 static int
 jit_validate_events(struct perf_session *session)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	/*
 	 * check that all events use CLOCK_MONOTONIC
@@ -758,7 +758,7 @@ jit_process(struct perf_session *session,
 	    pid_t pid,
 	    u64 *nbytes)
 {
-	struct perf_evsel *first;
+	struct evsel *first;
 	struct jit_buf_desc jd;
 	int ret;
 
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index 1403dec189b4..299edd32d3d4 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -6,7 +6,7 @@
 #include "tool.h"
 #include "stat.h"
 
-struct perf_evsel;
+struct evsel;
 struct perf_evlist;
 struct perf_session;
 
@@ -45,17 +45,17 @@ struct kvm_event_key {
 struct perf_kvm_stat;
 
 struct child_event_ops {
-	void (*get_key)(struct perf_evsel *evsel,
+	void (*get_key)(struct evsel *evsel,
 			struct perf_sample *sample,
 			struct event_key *key);
 	const char *name;
 };
 
 struct kvm_events_ops {
-	bool (*is_begin_event)(struct perf_evsel *evsel,
+	bool (*is_begin_event)(struct evsel *evsel,
 			       struct perf_sample *sample,
 			       struct event_key *key);
-	bool (*is_end_event)(struct perf_evsel *evsel,
+	bool (*is_end_event)(struct evsel *evsel,
 			     struct perf_sample *sample, struct event_key *key);
 	struct child_event_ops *child_ops;
 	void (*decode_key)(struct perf_kvm_stat *kvm, struct event_key *key,
@@ -109,21 +109,21 @@ struct kvm_reg_events_ops {
 	struct kvm_events_ops *ops;
 };
 
-void exit_event_get_key(struct perf_evsel *evsel,
+void exit_event_get_key(struct evsel *evsel,
 			struct perf_sample *sample,
 			struct event_key *key);
-bool exit_event_begin(struct perf_evsel *evsel,
+bool exit_event_begin(struct evsel *evsel,
 		      struct perf_sample *sample,
 		      struct event_key *key);
-bool exit_event_end(struct perf_evsel *evsel,
+bool exit_event_end(struct evsel *evsel,
 		    struct perf_sample *sample,
 		    struct event_key *key);
 void exit_event_decode_key(struct perf_kvm_stat *kvm,
 			   struct event_key *key,
 			   char *decode);
 
-bool kvm_exit_event(struct perf_evsel *evsel);
-bool kvm_entry_event(struct perf_evsel *evsel);
+bool kvm_exit_event(struct evsel *evsel);
+bool kvm_entry_event(struct evsel *evsel);
 int setup_kvm_events_tp(struct perf_kvm_stat *kvm);
 
 #define define_exit_reasons_table(name, symbols)	\
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index a2359a33c748..ec0675b0caa8 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2287,7 +2287,7 @@ static int find_prev_cpumode(struct ip_callchain *chain, struct thread *thread,
 
 static int thread__resolve_callchain_sample(struct thread *thread,
 					    struct callchain_cursor *cursor,
-					    struct perf_evsel *evsel,
+					    struct evsel *evsel,
 					    struct perf_sample *sample,
 					    struct symbol **parent,
 					    struct addr_location *root_al,
@@ -2493,7 +2493,7 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
 
 static int thread__resolve_callchain_unwind(struct thread *thread,
 					    struct callchain_cursor *cursor,
-					    struct perf_evsel *evsel,
+					    struct evsel *evsel,
 					    struct perf_sample *sample,
 					    int max_stack)
 {
@@ -2513,7 +2513,7 @@ static int thread__resolve_callchain_unwind(struct thread *thread,
 
 int thread__resolve_callchain(struct thread *thread,
 			      struct callchain_cursor *cursor,
-			      struct perf_evsel *evsel,
+			      struct evsel *evsel,
 			      struct perf_sample *sample,
 			      struct symbol **parent,
 			      struct addr_location *root_al,
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 7f64016758e0..ef803f08ae12 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -11,7 +11,7 @@
 
 struct addr_location;
 struct branch_stack;
-struct perf_evsel;
+struct evsel;
 struct perf_sample;
 struct symbol;
 struct thread;
@@ -175,7 +175,7 @@ struct callchain_cursor;
 
 int thread__resolve_callchain(struct thread *thread,
 			      struct callchain_cursor *cursor,
-			      struct perf_evsel *evsel,
+			      struct evsel *evsel,
 			      struct perf_sample *sample,
 			      struct symbol **parent,
 			      struct addr_location *root_al,
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index dc93787c74f0..c3614195ddc7 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -16,7 +16,7 @@ struct ip_callchain;
 struct ref_reloc_sym;
 struct map_groups;
 struct machine;
-struct perf_evsel;
+struct evsel;
 
 struct map {
 	union {
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 416a9015405e..14c423974d63 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -21,7 +21,7 @@
 #include <linux/zalloc.h>
 
 struct metric_event *metricgroup__lookup(struct rblist *metric_events,
-					 struct perf_evsel *evsel,
+					 struct evsel *evsel,
 					 bool create)
 {
 	struct rb_node *nd;
@@ -86,10 +86,10 @@ struct egroup {
 	const char *metric_expr;
 };
 
-static bool record_evsel(int *ind, struct perf_evsel **start,
+static bool record_evsel(int *ind, struct evsel **start,
 			 int idnum,
-			 struct perf_evsel **metric_events,
-			 struct perf_evsel *ev)
+			 struct evsel **metric_events,
+			 struct evsel *ev)
 {
 	metric_events[*ind] = ev;
 	if (*ind == 0)
@@ -101,12 +101,12 @@ static bool record_evsel(int *ind, struct perf_evsel **start,
 	return false;
 }
 
-static struct perf_evsel *find_evsel_group(struct perf_evlist *perf_evlist,
-					   const char **ids,
-					   int idnum,
-					   struct perf_evsel **metric_events)
+static struct evsel *find_evsel_group(struct perf_evlist *perf_evlist,
+				      const char **ids,
+				      int idnum,
+				      struct evsel **metric_events)
 {
-	struct perf_evsel *ev, *start = NULL;
+	struct evsel *ev, *start = NULL;
 	int ind = 0;
 
 	evlist__for_each_entry (perf_evlist, ev) {
@@ -148,10 +148,10 @@ static int metricgroup__setup_events(struct list_head *groups,
 	int i = 0;
 	int ret = 0;
 	struct egroup *eg;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	list_for_each_entry (eg, groups, nd) {
-		struct perf_evsel **metric_events;
+		struct evsel **metric_events;
 
 		metric_events = calloc(sizeof(void *), eg->idnum + 1);
 		if (!metric_events) {
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 5c52097a5c63..500e828533f8 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -9,7 +9,7 @@
 
 struct metric_event {
 	struct rb_node nd;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	struct list_head head; /* list of metric_expr */
 };
 
@@ -17,11 +17,11 @@ struct metric_expr {
 	struct list_head nd;
 	const char *metric_expr;
 	const char *metric_name;
-	struct perf_evsel **metric_events;
+	struct evsel **metric_events;
 };
 
 struct metric_event *metricgroup__lookup(struct rblist *metric_events,
-					 struct perf_evsel *evsel,
+					 struct evsel *evsel,
 					 bool create);
 int metricgroup__parse_groups(const struct option *opt,
 			const char *str,
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 352c5198b453..dfde9cb31562 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -314,14 +314,14 @@ static char *get_config_name(struct list_head *head_terms)
 	return NULL;
 }
 
-static struct perf_evsel *
+static struct evsel *
 __add_event(struct list_head *list, int *idx,
 	    struct perf_event_attr *attr,
 	    char *name, struct perf_pmu *pmu,
 	    struct list_head *config_terms, bool auto_merge_stats,
 	    const char *cpu_list)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	struct perf_cpu_map *cpus = pmu ? pmu->cpus :
 			       cpu_list ? cpu_map__new(cpu_list) : NULL;
 
@@ -357,7 +357,7 @@ static int add_event(struct list_head *list, int *idx,
 static int add_event_tool(struct list_head *list, int *idx,
 			  enum perf_tool_event tool_event)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	struct perf_event_attr attr = {
 		.type = PERF_TYPE_SOFTWARE,
 		.config = PERF_COUNT_SW_DUMMY,
@@ -510,7 +510,7 @@ static int add_tracepoint(struct list_head *list, int *idx,
 			  struct parse_events_error *err,
 			  struct list_head *head_config)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	evsel = perf_evsel__newtp_idx(sys_name, evt_name, (*idx)++);
 	if (IS_ERR(evsel)) {
@@ -637,7 +637,7 @@ static int add_bpf_event(const char *group, const char *event, int fd, struct bp
 	struct __add_bpf_event_param *param = _param;
 	struct parse_events_state *parse_state = param->parse_state;
 	struct list_head *list = param->list;
-	struct perf_evsel *pos;
+	struct evsel *pos;
 	int err;
 	/*
 	 * Check if we should add the event, i.e. if it is a TP but starts with a '!',
@@ -656,7 +656,7 @@ static int add_bpf_event(const char *group, const char *event, int fd, struct bp
 					  event, parse_state->error,
 					  param->head_config);
 	if (err) {
-		struct perf_evsel *evsel, *tmp;
+		struct evsel *evsel, *tmp;
 
 		pr_debug("Failed to add BPF event %s:%s\n",
 			 group, event);
@@ -1306,7 +1306,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 	struct perf_event_attr attr;
 	struct perf_pmu_info info;
 	struct perf_pmu *pmu;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	struct parse_events_error *err = parse_state->error;
 	bool use_uncore_alias;
 	LIST_HEAD(config_terms);
@@ -1453,13 +1453,13 @@ static int
 parse_events__set_leader_for_uncore_aliase(char *name, struct list_head *list,
 					   struct parse_events_state *parse_state)
 {
-	struct perf_evsel *evsel, *leader;
+	struct evsel *evsel, *leader;
 	uintptr_t *leaders;
 	bool is_leader = true;
 	int i, nr_pmu = 0, total_members, ret = 0;
 
-	leader = list_first_entry(list, struct perf_evsel, node);
-	evsel = list_last_entry(list, struct perf_evsel, node);
+	leader = list_first_entry(list, struct evsel, node);
+	evsel = list_last_entry(list, struct evsel, node);
 	total_members = evsel->idx - leader->idx + 1;
 
 	leaders = calloc(total_members, sizeof(uintptr_t));
@@ -1521,12 +1521,12 @@ parse_events__set_leader_for_uncore_aliase(char *name, struct list_head *list,
 	__evlist__for_each_entry(list, evsel) {
 		if (i >= nr_pmu)
 			i = 0;
-		evsel->leader = (struct perf_evsel *) leaders[i++];
+		evsel->leader = (struct evsel *) leaders[i++];
 	}
 
 	/* The number of members and group name are same for each group */
 	for (i = 0; i < nr_pmu; i++) {
-		evsel = (struct perf_evsel *) leaders[i];
+		evsel = (struct evsel *) leaders[i];
 		evsel->nr_members = total_members / nr_pmu;
 		evsel->group_name = name ? strdup(name) : NULL;
 	}
@@ -1544,7 +1544,7 @@ parse_events__set_leader_for_uncore_aliase(char *name, struct list_head *list,
 void parse_events__set_leader(char *name, struct list_head *list,
 			      struct parse_events_state *parse_state)
 {
-	struct perf_evsel *leader;
+	struct evsel *leader;
 
 	if (list_empty(list)) {
 		WARN_ONCE(true, "WARNING: failed to set leader: empty list");
@@ -1555,7 +1555,7 @@ void parse_events__set_leader(char *name, struct list_head *list,
 		return;
 
 	__perf_evlist__set_leader(list);
-	leader = list_entry(list->next, struct perf_evsel, node);
+	leader = list_entry(list->next, struct evsel, node);
 	leader->group_name = name ? strdup(name) : NULL;
 }
 
@@ -1588,7 +1588,7 @@ struct event_modifier {
 };
 
 static int get_event_modifier(struct event_modifier *mod, char *str,
-			       struct perf_evsel *evsel)
+			       struct evsel *evsel)
 {
 	int eu = evsel ? evsel->attr.exclude_user : 0;
 	int ek = evsel ? evsel->attr.exclude_kernel : 0;
@@ -1701,7 +1701,7 @@ static int check_modifier(char *str)
 
 int parse_events__modifier_event(struct list_head *list, char *str, bool add)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	struct event_modifier mod;
 
 	if (str == NULL)
@@ -1738,7 +1738,7 @@ int parse_events__modifier_event(struct list_head *list, char *str, bool add)
 
 int parse_events_name(struct list_head *list, char *name)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	__evlist__for_each_entry(list, evsel) {
 		if (!evsel->name)
@@ -1918,7 +1918,7 @@ int parse_events(struct perf_evlist *evlist, const char *str,
 	ret = parse_events__scanner(str, &parse_state, PE_START_EVENTS);
 	perf_pmu__parse_cleanup();
 	if (!ret) {
-		struct perf_evsel *last;
+		struct evsel *last;
 
 		if (list_empty(&parse_state.list)) {
 			WARN_ONCE(true, "WARNING: event parser found nothing\n");
@@ -2027,11 +2027,11 @@ int parse_events_option(const struct option *opt, const char *str,
 
 static int
 foreach_evsel_in_last_glob(struct perf_evlist *evlist,
-			   int (*func)(struct perf_evsel *evsel,
+			   int (*func)(struct evsel *evsel,
 				       const void *arg),
 			   const void *arg)
 {
-	struct perf_evsel *last = NULL;
+	struct evsel *last = NULL;
 	int err;
 
 	/*
@@ -2052,13 +2052,13 @@ foreach_evsel_in_last_glob(struct perf_evlist *evlist,
 
 		if (last->node.prev == &evlist->entries)
 			return 0;
-		last = list_entry(last->node.prev, struct perf_evsel, node);
+		last = list_entry(last->node.prev, struct evsel, node);
 	} while (!last->cmdline_group_boundary);
 
 	return 0;
 }
 
-static int set_filter(struct perf_evsel *evsel, const void *arg)
+static int set_filter(struct evsel *evsel, const void *arg)
 {
 	const char *str = arg;
 	bool found = false;
@@ -2115,7 +2115,7 @@ int parse_filter(const struct option *opt, const char *str,
 					  (const void *)str);
 }
 
-static int add_exclude_perf_filter(struct perf_evsel *evsel,
+static int add_exclude_perf_filter(struct evsel *evsel,
 				   const void *arg __maybe_unused)
 {
 	char new_filter[64];
@@ -2307,7 +2307,7 @@ static bool is_event_supported(u8 type, unsigned config)
 {
 	bool ret = true;
 	int open_return;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	struct perf_event_attr attr = {
 		.type = type,
 		.config = config,
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index f7139e1a2fd3..99e206598b60 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -12,7 +12,7 @@
 #include <string.h>
 
 struct list_head;
-struct perf_evsel;
+struct evsel;
 struct perf_evlist;
 struct parse_events_error;
 
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 62dda70227e5..beafbd469b0c 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -93,7 +93,7 @@ PyMODINIT_FUNC PyInit_perf(void);
 
 struct pyrf_event {
 	PyObject_HEAD
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	struct perf_sample sample;
 	union perf_event   event;
 };
@@ -383,7 +383,7 @@ static PyObject*
 get_tracepoint_field(struct pyrf_event *pevent, PyObject *attr_name)
 {
 	const char *str = _PyUnicode_AsString(PyObject_Str(attr_name));
-	struct perf_evsel *evsel = pevent->evsel;
+	struct evsel *evsel = pevent->evsel;
 	struct tep_format_field *field;
 
 	if (!evsel->tp_format) {
@@ -674,7 +674,7 @@ static int pyrf_thread_map__setup_types(void)
 struct pyrf_evsel {
 	PyObject_HEAD
 
-	struct perf_evsel evsel;
+	struct evsel evsel;
 };
 
 static int pyrf_evsel__init(struct pyrf_evsel *pevsel,
@@ -795,7 +795,7 @@ static void pyrf_evsel__delete(struct pyrf_evsel *pevsel)
 static PyObject *pyrf_evsel__open(struct pyrf_evsel *pevsel,
 				  PyObject *args, PyObject *kwargs)
 {
-	struct perf_evsel *evsel = &pevsel->evsel;
+	struct evsel *evsel = &pevsel->evsel;
 	struct perf_cpu_map *cpus = NULL;
 	struct perf_thread_map *threads = NULL;
 	PyObject *pcpus = NULL, *pthreads = NULL;
@@ -966,7 +966,7 @@ static PyObject *pyrf_evlist__add(struct pyrf_evlist *pevlist,
 {
 	struct perf_evlist *evlist = &pevlist->evlist;
 	PyObject *pevsel;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	if (!PyArg_ParseTuple(args, "O", &pevsel))
 		return NULL;
@@ -1018,7 +1018,7 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 	if (event != NULL) {
 		PyObject *pyevent = pyrf_event__new(event);
 		struct pyrf_event *pevent = (struct pyrf_event *)pyevent;
-		struct perf_evsel *evsel;
+		struct evsel *evsel;
 
 		if (pyevent == NULL)
 			return PyErr_NoMemory();
@@ -1118,7 +1118,7 @@ static Py_ssize_t pyrf_evlist__length(PyObject *obj)
 static PyObject *pyrf_evlist__item(PyObject *obj, Py_ssize_t i)
 {
 	struct pyrf_evlist *pevlist = (void *)obj;
-	struct perf_evsel *pos;
+	struct evsel *pos;
 
 	if (i >= pevlist->evlist.nr_entries)
 		return NULL;
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index 051c67f82548..ef8f686729fd 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -9,12 +9,12 @@
 #include "util.h"
 #include "cloexec.h"
 
-typedef void (*setup_probe_fn_t)(struct perf_evsel *evsel);
+typedef void (*setup_probe_fn_t)(struct evsel *evsel);
 
 static int perf_do_probe_api(setup_probe_fn_t fn, int cpu, const char *str)
 {
 	struct perf_evlist *evlist;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	unsigned long flags = perf_event_open_cloexec_flag();
 	int err = -EAGAIN, fd;
 	static pid_t pid = -1;
@@ -78,17 +78,17 @@ static bool perf_probe_api(setup_probe_fn_t fn)
 	return false;
 }
 
-static void perf_probe_sample_identifier(struct perf_evsel *evsel)
+static void perf_probe_sample_identifier(struct evsel *evsel)
 {
 	evsel->attr.sample_type |= PERF_SAMPLE_IDENTIFIER;
 }
 
-static void perf_probe_comm_exec(struct perf_evsel *evsel)
+static void perf_probe_comm_exec(struct evsel *evsel)
 {
 	evsel->attr.comm_exec = 1;
 }
 
-static void perf_probe_context_switch(struct perf_evsel *evsel)
+static void perf_probe_context_switch(struct evsel *evsel)
 {
 	evsel->attr.context_switch = 1;
 }
@@ -135,7 +135,7 @@ bool perf_can_record_cpu_wide(void)
 void perf_evlist__config(struct perf_evlist *evlist, struct record_opts *opts,
 			 struct callchain_param *callchain)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	bool use_sample_identifier = false;
 	bool use_comm_exec;
 	bool sample_id = opts->sample_id;
@@ -167,7 +167,7 @@ void perf_evlist__config(struct perf_evlist *evlist, struct record_opts *opts,
 		use_sample_identifier = perf_can_sample_identifier();
 		sample_id = true;
 	} else if (evlist->nr_entries > 1) {
-		struct perf_evsel *first = perf_evlist__first(evlist);
+		struct evsel *first = perf_evlist__first(evlist);
 
 		evlist__for_each_entry(evlist, evsel) {
 			if (evsel->attr.sample_type == first->attr.sample_type)
@@ -259,7 +259,7 @@ int record_opts__config(struct record_opts *opts)
 bool perf_evlist__can_select_event(struct perf_evlist *evlist, const char *str)
 {
 	struct perf_evlist *temp_evlist;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	int err, fd, cpu;
 	bool ret = false;
 	pid_t pid = -1;
diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index 83d2e149ef19..59d78a9fe703 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -918,7 +918,7 @@ s390_cpumsf_process_event(struct perf_session *session,
 					      struct s390_cpumsf,
 					      auxtrace);
 	u64 timestamp = sample->time;
-	struct perf_evsel *ev_bc000;
+	struct evsel *ev_bc000;
 
 	int err = 0;
 
diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
index 6650f599ed9c..159a08220947 100644
--- a/tools/perf/util/s390-sample-raw.c
+++ b/tools/perf/util/s390-sample-raw.c
@@ -203,7 +203,7 @@ static void s390_cpumcfdg_dump(struct perf_sample *sample)
 void perf_evlist__s390_sample_raw(struct perf_evlist *evlist, union perf_event *event,
 				  struct perf_sample *sample)
 {
-	struct perf_evsel *ev_bc000;
+	struct evsel *ev_bc000;
 
 	if (event->header.type != PERF_RECORD_SAMPLE)
 		return;
diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
index 61aa7f3df915..98dcdb9a79a4 100644
--- a/tools/perf/util/scripting-engines/trace-event-perl.c
+++ b/tools/perf/util/scripting-engines/trace-event-perl.c
@@ -258,7 +258,7 @@ static void define_event_symbols(struct tep_event *event,
 }
 
 static SV *perl_process_callchain(struct perf_sample *sample,
-				  struct perf_evsel *evsel,
+				  struct evsel *evsel,
 				  struct addr_location *al)
 {
 	AV *list;
@@ -336,7 +336,7 @@ static SV *perl_process_callchain(struct perf_sample *sample,
 }
 
 static void perl_process_tracepoint(struct perf_sample *sample,
-				    struct perf_evsel *evsel,
+				    struct evsel *evsel,
 				    struct addr_location *al)
 {
 	struct thread *thread = al->thread;
@@ -431,7 +431,7 @@ static void perl_process_tracepoint(struct perf_sample *sample,
 
 static void perl_process_event_generic(union perf_event *event,
 				       struct perf_sample *sample,
-				       struct perf_evsel *evsel)
+				       struct evsel *evsel)
 {
 	dSP;
 
@@ -455,7 +455,7 @@ static void perl_process_event_generic(union perf_event *event,
 
 static void perl_process_event(union perf_event *event,
 			       struct perf_sample *sample,
-			       struct perf_evsel *evsel,
+			       struct evsel *evsel,
 			       struct addr_location *al)
 {
 	perl_process_tracepoint(sample, evsel, al);
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 0a7e662036b4..106aec31c07c 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -392,7 +392,7 @@ static const char *get_dsoname(struct map *map)
 }
 
 static PyObject *python_process_callchain(struct perf_sample *sample,
-					 struct perf_evsel *evsel,
+					 struct evsel *evsel,
 					 struct addr_location *al)
 {
 	PyObject *pylist;
@@ -634,7 +634,7 @@ static PyObject *get_sample_value_as_tuple(struct sample_read_value *value)
 
 static void set_sample_read_in_dict(PyObject *dict_sample,
 					 struct perf_sample *sample,
-					 struct perf_evsel *evsel)
+					 struct evsel *evsel)
 {
 	u64 read_format = evsel->attr.read_format;
 	PyObject *values;
@@ -705,7 +705,7 @@ static int regs_map(struct regs_dump *regs, uint64_t mask, char *bf, int size)
 
 static void set_regs_in_dict(PyObject *dict,
 			     struct perf_sample *sample,
-			     struct perf_evsel *evsel)
+			     struct evsel *evsel)
 {
 	struct perf_event_attr *attr = &evsel->attr;
 	char bf[512];
@@ -722,7 +722,7 @@ static void set_regs_in_dict(PyObject *dict,
 }
 
 static PyObject *get_perf_sample_dict(struct perf_sample *sample,
-					 struct perf_evsel *evsel,
+					 struct evsel *evsel,
 					 struct addr_location *al,
 					 PyObject *callchain)
 {
@@ -790,7 +790,7 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 }
 
 static void python_process_tracepoint(struct perf_sample *sample,
-				      struct perf_evsel *evsel,
+				      struct evsel *evsel,
 				      struct addr_location *al)
 {
 	struct tep_event *event = evsel->tp_format;
@@ -955,7 +955,7 @@ static int tuple_set_bytes(PyObject *t, unsigned int pos, void *bytes,
 	return PyTuple_SetItem(t, pos, _PyBytes_FromStringAndSize(bytes, sz));
 }
 
-static int python_export_evsel(struct db_export *dbe, struct perf_evsel *evsel)
+static int python_export_evsel(struct db_export *dbe, struct evsel *evsel)
 {
 	struct tables *tables = container_of(dbe, struct tables, dbe);
 	PyObject *t;
@@ -1275,7 +1275,7 @@ static int python_process_call_return(struct call_return *cr, u64 *parent_db_id,
 }
 
 static void python_process_general_event(struct perf_sample *sample,
-					 struct perf_evsel *evsel,
+					 struct evsel *evsel,
 					 struct addr_location *al)
 {
 	PyObject *handler, *t, *dict, *callchain;
@@ -1311,7 +1311,7 @@ static void python_process_general_event(struct perf_sample *sample,
 
 static void python_process_event(union perf_event *event,
 				 struct perf_sample *sample,
-				 struct perf_evsel *evsel,
+				 struct evsel *evsel,
 				 struct addr_location *al)
 {
 	struct tables *tables = &tables_global;
@@ -1340,7 +1340,7 @@ static void python_process_switch(union perf_event *event,
 }
 
 static void get_handler_name(char *str, size_t size,
-			     struct perf_evsel *evsel)
+			     struct evsel *evsel)
 {
 	char *p = str;
 
@@ -1353,7 +1353,7 @@ static void get_handler_name(char *str, size_t size,
 }
 
 static void
-process_stat(struct perf_evsel *counter, int cpu, int thread, u64 tstamp,
+process_stat(struct evsel *counter, int cpu, int thread, u64 tstamp,
 	     struct perf_counts_values *count)
 {
 	PyObject *handler, *t;
@@ -1390,7 +1390,7 @@ process_stat(struct perf_evsel *counter, int cpu, int thread, u64 tstamp,
 }
 
 static void python_process_stat(struct perf_stat_config *config,
-				struct perf_evsel *counter, u64 tstamp)
+				struct evsel *counter, u64 tstamp)
 {
 	struct perf_thread_map *threads = counter->threads;
 	struct perf_cpu_map *cpus = counter->cpus;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 69d1d158a610..e9d1cf8eb274 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -151,7 +151,7 @@ static void perf_session__destroy_kernel_maps(struct perf_session *session)
 
 static bool perf_session__has_comm_exec(struct perf_session *session)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	evlist__for_each_entry(session->evlist, evsel) {
 		if (evsel->attr.comm_exec)
@@ -322,7 +322,7 @@ static int process_event_synth_event_update_stub(struct perf_tool *tool __maybe_
 static int process_event_sample_stub(struct perf_tool *tool __maybe_unused,
 				     union perf_event *event __maybe_unused,
 				     struct perf_sample *sample __maybe_unused,
-				     struct perf_evsel *evsel __maybe_unused,
+				     struct evsel *evsel __maybe_unused,
 				     struct machine *machine __maybe_unused)
 {
 	dump_printf(": unhandled!\n");
@@ -1033,7 +1033,7 @@ static void callchain__lbr_callstack_printf(struct perf_sample *sample)
 	}
 }
 
-static void callchain__printf(struct perf_evsel *evsel,
+static void callchain__printf(struct evsel *evsel,
 			      struct perf_sample *sample)
 {
 	unsigned int i;
@@ -1198,7 +1198,7 @@ static void dump_event(struct perf_evlist *evlist, union perf_event *event,
 	       event->header.size, perf_event__name(event->header.type));
 }
 
-static void dump_sample(struct perf_evsel *evsel, union perf_event *event,
+static void dump_sample(struct evsel *evsel, union perf_event *event,
 			struct perf_sample *sample)
 {
 	u64 sample_type;
@@ -1243,7 +1243,7 @@ static void dump_sample(struct perf_evsel *evsel, union perf_event *event,
 		sample_read__printf(sample, evsel->attr.read_format);
 }
 
-static void dump_read(struct perf_evsel *evsel, union perf_event *event)
+static void dump_read(struct evsel *evsel, union perf_event *event)
 {
 	struct read_event *read_event = &event->read;
 	u64 read_format;
@@ -1351,7 +1351,7 @@ static int
 			     struct perf_tool *tool,
 			     union  perf_event *event,
 			     struct perf_sample *sample,
-			     struct perf_evsel *evsel,
+			     struct evsel *evsel,
 			     struct machine *machine)
 {
 	/* We know evsel != NULL. */
@@ -1377,7 +1377,7 @@ static int machines__deliver_event(struct machines *machines,
 				   struct perf_sample *sample,
 				   struct perf_tool *tool, u64 file_offset)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	struct machine *machine;
 
 	dump_event(evlist, event, file_offset, sample);
@@ -1705,7 +1705,7 @@ static void
 perf_session__warn_order(const struct perf_session *session)
 {
 	const struct ordered_events *oe = &session->ordered_events;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	bool should_warn = true;
 
 	evlist__for_each_entry(session->evlist, evsel) {
@@ -2183,7 +2183,7 @@ int perf_session__process_events(struct perf_session *session)
 
 bool perf_session__has_traces(struct perf_session *session, const char *msg)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	evlist__for_each_entry(session->evlist, evsel) {
 		if (evsel->attr.type == PERF_TYPE_TRACEPOINT)
@@ -2257,10 +2257,10 @@ size_t perf_session__fprintf(struct perf_session *session, FILE *fp)
 	return machine__fprintf(&session->machines.host, fp);
 }
 
-struct perf_evsel *perf_session__find_first_evtype(struct perf_session *session,
+struct evsel *perf_session__find_first_evtype(struct perf_session *session,
 					      unsigned int type)
 {
-	struct perf_evsel *pos;
+	struct evsel *pos;
 
 	evlist__for_each_entry(session->evlist, pos) {
 		if (pos->attr.type == type)
@@ -2276,7 +2276,7 @@ int perf_session__cpu_bitmap(struct perf_session *session,
 	struct perf_cpu_map *map;
 
 	for (i = 0; i < PERF_TYPE_MAX; ++i) {
-		struct perf_evsel *evsel;
+		struct evsel *evsel;
 
 		evsel = perf_session__find_first_evtype(session, i);
 		if (!evsel)
@@ -2327,10 +2327,10 @@ void perf_session__fprintf_info(struct perf_session *session, FILE *fp,
 
 
 int __perf_session__set_tracepoints_handlers(struct perf_session *session,
-					     const struct perf_evsel_str_handler *assocs,
+					     const struct evsel_str_handler *assocs,
 					     size_t nr_assocs)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	size_t i;
 	int err;
 
@@ -2397,7 +2397,7 @@ int perf_event__synthesize_id_index(struct perf_tool *tool,
 				    struct machine *machine)
 {
 	union perf_event *ev;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	size_t nr = 0, i = 0, sz, max_nr, n;
 	int err;
 
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index 863dbad87849..2b2427c4c0b9 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -73,7 +73,7 @@ int perf_session__queue_event(struct perf_session *s, union perf_event *event,
 void perf_tool__fill_defaults(struct perf_tool *tool);
 
 int perf_session__resolve_callchain(struct perf_session *session,
-				    struct perf_evsel *evsel,
+				    struct evsel *evsel,
 				    struct thread *thread,
 				    struct ip_callchain *chain,
 				    struct symbol **parent);
@@ -110,7 +110,7 @@ size_t perf_session__fprintf_dsos_buildid(struct perf_session *session, FILE *fp
 
 size_t perf_session__fprintf_nr_events(struct perf_session *session, FILE *fp);
 
-struct perf_evsel *perf_session__find_first_evtype(struct perf_session *session,
+struct evsel *perf_session__find_first_evtype(struct perf_session *session,
 					    unsigned int type);
 
 int perf_session__cpu_bitmap(struct perf_session *session,
@@ -118,10 +118,10 @@ int perf_session__cpu_bitmap(struct perf_session *session,
 
 void perf_session__fprintf_info(struct perf_session *s, FILE *fp, bool full);
 
-struct perf_evsel_str_handler;
+struct evsel_str_handler;
 
 int __perf_session__set_tracepoints_handlers(struct perf_session *session,
-					     const struct perf_evsel_str_handler *assocs,
+					     const struct evsel_str_handler *assocs,
 					     size_t nr_assocs);
 
 #define perf_session__set_tracepoints_handlers(session, array) \
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 5d2518e89fc4..133d3a45997f 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -698,7 +698,7 @@ struct sort_entry sort_time = {
 static char *get_trace_output(struct hist_entry *he)
 {
 	struct trace_seq seq;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	struct tep_record rec = {
 		.data = he->raw_data,
 		.size = he->raw_size,
@@ -723,7 +723,7 @@ static char *get_trace_output(struct hist_entry *he)
 static int64_t
 sort__trace_cmp(struct hist_entry *left, struct hist_entry *right)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	evsel = hists_to_evsel(left->hists);
 	if (evsel->attr.type != PERF_TYPE_TRACEPOINT)
@@ -740,7 +740,7 @@ sort__trace_cmp(struct hist_entry *left, struct hist_entry *right)
 static int hist_entry__trace_snprintf(struct hist_entry *he, char *bf,
 				    size_t size, unsigned int width)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	evsel = hists_to_evsel(he->hists);
 	if (evsel->attr.type != PERF_TYPE_TRACEPOINT)
@@ -1984,7 +1984,7 @@ static int __sort_dimension__add_hpp_output(struct sort_dimension *sd,
 
 struct hpp_dynamic_entry {
 	struct perf_hpp_fmt hpp;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	struct tep_format_field *field;
 	unsigned dynamic_len;
 	bool raw_trace;
@@ -2218,7 +2218,7 @@ static void hde_free(struct perf_hpp_fmt *fmt)
 }
 
 static struct hpp_dynamic_entry *
-__alloc_dynamic_entry(struct perf_evsel *evsel, struct tep_format_field *field,
+__alloc_dynamic_entry(struct evsel *evsel, struct tep_format_field *field,
 		      int level)
 {
 	struct hpp_dynamic_entry *hde;
@@ -2313,10 +2313,10 @@ static int parse_field_name(char *str, char **event, char **field, char **opt)
  *   2. full event name (e.g. sched:sched_switch)
  *   3. partial event name (should not contain ':')
  */
-static struct perf_evsel *find_evsel(struct perf_evlist *evlist, char *event_name)
+static struct evsel *find_evsel(struct perf_evlist *evlist, char *event_name)
 {
-	struct perf_evsel *evsel = NULL;
-	struct perf_evsel *pos;
+	struct evsel *evsel = NULL;
+	struct evsel *pos;
 	bool full_name;
 
 	/* case 1 */
@@ -2352,7 +2352,7 @@ static struct perf_evsel *find_evsel(struct perf_evlist *evlist, char *event_nam
 	return evsel;
 }
 
-static int __dynamic_dimension__add(struct perf_evsel *evsel,
+static int __dynamic_dimension__add(struct evsel *evsel,
 				    struct tep_format_field *field,
 				    bool raw_trace, int level)
 {
@@ -2368,7 +2368,7 @@ static int __dynamic_dimension__add(struct perf_evsel *evsel,
 	return 0;
 }
 
-static int add_evsel_fields(struct perf_evsel *evsel, bool raw_trace, int level)
+static int add_evsel_fields(struct evsel *evsel, bool raw_trace, int level)
 {
 	int ret;
 	struct tep_format_field *field;
@@ -2388,7 +2388,7 @@ static int add_all_dynamic_fields(struct perf_evlist *evlist, bool raw_trace,
 				  int level)
 {
 	int ret;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (evsel->attr.type != PERF_TYPE_TRACEPOINT)
@@ -2405,7 +2405,7 @@ static int add_all_matching_fields(struct perf_evlist *evlist,
 				   char *field_name, bool raw_trace, int level)
 {
 	int ret = -ESRCH;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	struct tep_format_field *field;
 
 	evlist__for_each_entry(evlist, evsel) {
@@ -2427,7 +2427,7 @@ static int add_dynamic_entry(struct perf_evlist *evlist, const char *tok,
 			     int level)
 {
 	char *str, *event_name, *field_name, *opt_name;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	struct tep_format_field *field;
 	bool raw_trace = symbol_conf.raw_trace;
 	int ret = 0;
@@ -2720,7 +2720,7 @@ static const char *get_default_sort_order(struct perf_evlist *evlist)
 		default_tracepoint_sort_order,
 	};
 	bool use_trace = true;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	BUG_ON(sort__mode >= ARRAY_SIZE(default_sort_orders));
 
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 58df6a0dbb9f..8da4ddcb2e44 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -45,7 +45,7 @@ static void print_noise_pct(struct perf_stat_config *config,
 }
 
 static void print_noise(struct perf_stat_config *config,
-			struct perf_evsel *evsel, double avg)
+			struct evsel *evsel, double avg)
 {
 	struct perf_stat_evsel *ps;
 
@@ -56,7 +56,7 @@ static void print_noise(struct perf_stat_config *config,
 	print_noise_pct(config, stddev_stats(&ps->res_stats[0]), avg);
 }
 
-static void print_cgroup(struct perf_stat_config *config, struct perf_evsel *evsel)
+static void print_cgroup(struct perf_stat_config *config, struct evsel *evsel)
 {
 	if (nr_cgroups) {
 		const char *cgrp_name = evsel->cgrp ? evsel->cgrp->name  : "";
@@ -66,7 +66,7 @@ static void print_cgroup(struct perf_stat_config *config, struct perf_evsel *evs
 
 
 static void aggr_printout(struct perf_stat_config *config,
-			  struct perf_evsel *evsel, int id, int nr)
+			  struct evsel *evsel, int id, int nr)
 {
 	switch (config->aggr_mode) {
 	case AGGR_CORE:
@@ -134,7 +134,7 @@ struct outstate {
 	const char *prefix;
 	int  nfields;
 	int  id, nr;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 };
 
 #define METRIC_LEN  35
@@ -233,7 +233,7 @@ static bool valid_only_metric(const char *unit)
 	return true;
 }
 
-static const char *fixunit(char *buf, struct perf_evsel *evsel,
+static const char *fixunit(char *buf, struct evsel *evsel,
 			   const char *unit)
 {
 	if (!strncmp(unit, "of all", 6)) {
@@ -310,7 +310,7 @@ static void print_metric_header(struct perf_stat_config *config,
 }
 
 static int first_shadow_cpu(struct perf_stat_config *config,
-			    struct perf_evsel *evsel, int id)
+			    struct evsel *evsel, int id)
 {
 	struct perf_evlist *evlist = evsel->evlist;
 	int i;
@@ -334,7 +334,7 @@ static int first_shadow_cpu(struct perf_stat_config *config,
 }
 
 static void abs_printout(struct perf_stat_config *config,
-			 int id, int nr, struct perf_evsel *evsel, double avg)
+			 int id, int nr, struct evsel *evsel, double avg)
 {
 	FILE *output = config->output;
 	double sc =  evsel->scale;
@@ -363,11 +363,11 @@ static void abs_printout(struct perf_stat_config *config,
 	print_cgroup(config, evsel);
 }
 
-static bool is_mixed_hw_group(struct perf_evsel *counter)
+static bool is_mixed_hw_group(struct evsel *counter)
 {
 	struct perf_evlist *evlist = counter->evlist;
 	u32 pmu_type = counter->attr.type;
-	struct perf_evsel *pos;
+	struct evsel *pos;
 
 	if (counter->nr_members < 2)
 		return false;
@@ -388,7 +388,7 @@ static bool is_mixed_hw_group(struct perf_evsel *counter)
 }
 
 static void printout(struct perf_stat_config *config, int id, int nr,
-		     struct perf_evsel *counter, double uval,
+		     struct evsel *counter, double uval,
 		     char *prefix, u64 run, u64 ena, double noise,
 		     struct runtime_stat *st)
 {
@@ -493,7 +493,7 @@ static void aggr_update_shadow(struct perf_stat_config *config,
 {
 	int cpu, s2, id, s;
 	u64 val;
-	struct perf_evsel *counter;
+	struct evsel *counter;
 
 	for (s = 0; s < config->aggr_map->nr; s++) {
 		id = config->aggr_map->map[s];
@@ -512,7 +512,7 @@ static void aggr_update_shadow(struct perf_stat_config *config,
 	}
 }
 
-static void uniquify_event_name(struct perf_evsel *counter)
+static void uniquify_event_name(struct evsel *counter)
 {
 	char *new_name;
 	char *config;
@@ -540,13 +540,13 @@ static void uniquify_event_name(struct perf_evsel *counter)
 	counter->uniquified_name = true;
 }
 
-static void collect_all_aliases(struct perf_stat_config *config, struct perf_evsel *counter,
-			    void (*cb)(struct perf_stat_config *config, struct perf_evsel *counter, void *data,
+static void collect_all_aliases(struct perf_stat_config *config, struct evsel *counter,
+			    void (*cb)(struct perf_stat_config *config, struct evsel *counter, void *data,
 				       bool first),
 			    void *data)
 {
 	struct perf_evlist *evlist = counter->evlist;
-	struct perf_evsel *alias;
+	struct evsel *alias;
 
 	alias = list_prepare_entry(counter, &(evlist->entries), node);
 	list_for_each_entry_continue (alias, &evlist->entries, node) {
@@ -562,8 +562,8 @@ static void collect_all_aliases(struct perf_stat_config *config, struct perf_evs
 	}
 }
 
-static bool collect_data(struct perf_stat_config *config, struct perf_evsel *counter,
-			    void (*cb)(struct perf_stat_config *config, struct perf_evsel *counter, void *data,
+static bool collect_data(struct perf_stat_config *config, struct evsel *counter,
+			    void (*cb)(struct perf_stat_config *config, struct evsel *counter, void *data,
 				       bool first),
 			    void *data)
 {
@@ -585,7 +585,7 @@ struct aggr_data {
 };
 
 static void aggr_cb(struct perf_stat_config *config,
-		    struct perf_evsel *counter, void *data, bool first)
+		    struct evsel *counter, void *data, bool first)
 {
 	struct aggr_data *ad = data;
 	int cpu, s2;
@@ -616,7 +616,7 @@ static void aggr_cb(struct perf_stat_config *config,
 }
 
 static void print_counter_aggrdata(struct perf_stat_config *config,
-				   struct perf_evsel *counter, int s,
+				   struct evsel *counter, int s,
 				   char *prefix, bool metric_only,
 				   bool *first)
 {
@@ -656,7 +656,7 @@ static void print_aggr(struct perf_stat_config *config,
 {
 	bool metric_only = config->metric_only;
 	FILE *output = config->output;
-	struct perf_evsel *counter;
+	struct evsel *counter;
 	int s;
 	bool first;
 
@@ -691,7 +691,7 @@ static int cmp_val(const void *a, const void *b)
 }
 
 static struct perf_aggr_thread_value *sort_aggr_thread(
-					struct perf_evsel *counter,
+					struct evsel *counter,
 					int nthreads, int ncpus,
 					int *ret,
 					struct target *_target)
@@ -741,7 +741,7 @@ static struct perf_aggr_thread_value *sort_aggr_thread(
 
 static void print_aggr_thread(struct perf_stat_config *config,
 			      struct target *_target,
-			      struct perf_evsel *counter, char *prefix)
+			      struct evsel *counter, char *prefix)
 {
 	FILE *output = config->output;
 	int nthreads = thread_map__nr(counter->threads);
@@ -779,7 +779,7 @@ struct caggr_data {
 };
 
 static void counter_aggr_cb(struct perf_stat_config *config __maybe_unused,
-			    struct perf_evsel *counter, void *data,
+			    struct evsel *counter, void *data,
 			    bool first __maybe_unused)
 {
 	struct caggr_data *cd = data;
@@ -795,7 +795,7 @@ static void counter_aggr_cb(struct perf_stat_config *config __maybe_unused,
  * aggregated counts in system-wide mode
  */
 static void print_counter_aggr(struct perf_stat_config *config,
-			       struct perf_evsel *counter, char *prefix)
+			       struct evsel *counter, char *prefix)
 {
 	bool metric_only = config->metric_only;
 	FILE *output = config->output;
@@ -816,7 +816,7 @@ static void print_counter_aggr(struct perf_stat_config *config,
 }
 
 static void counter_cb(struct perf_stat_config *config __maybe_unused,
-		       struct perf_evsel *counter, void *data,
+		       struct evsel *counter, void *data,
 		       bool first __maybe_unused)
 {
 	struct aggr_data *ad = data;
@@ -831,7 +831,7 @@ static void counter_cb(struct perf_stat_config *config __maybe_unused,
  * does not use aggregated count in system-wide
  */
 static void print_counter(struct perf_stat_config *config,
-			  struct perf_evsel *counter, char *prefix)
+			  struct evsel *counter, char *prefix)
 {
 	FILE *output = config->output;
 	u64 ena, run, val;
@@ -864,7 +864,7 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 {
 	int cpu;
 	int nrcpus = 0;
-	struct perf_evsel *counter;
+	struct evsel *counter;
 	u64 ena, run, val;
 	double uval;
 
@@ -914,7 +914,7 @@ static void print_metric_headers(struct perf_stat_config *config,
 				 const char *prefix, bool no_indent)
 {
 	struct perf_stat_output_ctx out;
-	struct perf_evsel *counter;
+	struct evsel *counter;
 	struct outstate os = {
 		.fh = config->output
 	};
@@ -1132,7 +1132,7 @@ static void print_footer(struct perf_stat_config *config)
 }
 
 static void print_percore(struct perf_stat_config *config,
-			  struct perf_evsel *counter, char *prefix)
+			  struct evsel *counter, char *prefix)
 {
 	bool metric_only = config->metric_only;
 	FILE *output = config->output;
@@ -1164,7 +1164,7 @@ perf_evlist__print_counters(struct perf_evlist *evlist,
 {
 	bool metric_only = config->metric_only;
 	int interval = config->interval;
-	struct perf_evsel *counter;
+	struct evsel *counter;
 	char buf[64], *prefix = NULL;
 
 	if (interval)
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index accb1bf1cfd8..8c19f3149f34 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -25,7 +25,7 @@ struct stats walltime_nsecs_stats;
 
 struct saved_value {
 	struct rb_node rb_node;
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	enum stat_type type;
 	int ctx;
 	int cpu;
@@ -94,7 +94,7 @@ static void saved_value_delete(struct rblist *rblist __maybe_unused,
 	free(v);
 }
 
-static struct saved_value *saved_value_lookup(struct perf_evsel *evsel,
+static struct saved_value *saved_value_lookup(struct evsel *evsel,
 					      int cpu,
 					      bool create,
 					      enum stat_type type,
@@ -146,7 +146,7 @@ void perf_stat__init_shadow_stats(void)
 	runtime_stat__init(&rt_stat);
 }
 
-static int evsel_context(struct perf_evsel *evsel)
+static int evsel_context(struct evsel *evsel)
 {
 	int ctx = 0;
 
@@ -207,7 +207,7 @@ static void update_runtime_stat(struct runtime_stat *st,
  * more semantic information such as miss/hit ratios,
  * instruction rates, etc:
  */
-void perf_stat__update_shadow_stats(struct perf_evsel *counter, u64 count,
+void perf_stat__update_shadow_stats(struct evsel *counter, u64 count,
 				    int cpu, struct runtime_stat *st)
 {
 	int ctx = evsel_context(counter);
@@ -299,10 +299,10 @@ static const char *get_ratio_color(enum grc_type type, double ratio)
 	return color;
 }
 
-static struct perf_evsel *perf_stat__find_event(struct perf_evlist *evsel_list,
+static struct evsel *perf_stat__find_event(struct perf_evlist *evsel_list,
 						const char *name)
 {
-	struct perf_evsel *c2;
+	struct evsel *c2;
 
 	evlist__for_each_entry (evsel_list, c2) {
 		if (!strcasecmp(c2->name, name) && !c2->collect_stat)
@@ -314,7 +314,7 @@ static struct perf_evsel *perf_stat__find_event(struct perf_evlist *evsel_list,
 /* Mark MetricExpr target events and link events using them to them. */
 void perf_stat__collect_metric_expr(struct perf_evlist *evsel_list)
 {
-	struct perf_evsel *counter, *leader, **metric_events, *oc;
+	struct evsel *counter, *leader, **metric_events, *oc;
 	bool found;
 	const char **metric_names;
 	int i;
@@ -332,7 +332,7 @@ void perf_stat__collect_metric_expr(struct perf_evlist *evsel_list)
 						&metric_names, &num_metric_names) < 0)
 				continue;
 
-			metric_events = calloc(sizeof(struct perf_evsel *),
+			metric_events = calloc(sizeof(struct evsel *),
 					       num_metric_names + 1);
 			if (!metric_events)
 				return;
@@ -415,7 +415,7 @@ static double runtime_stat_n(struct runtime_stat *st,
 
 static void print_stalled_cycles_frontend(struct perf_stat_config *config,
 					  int cpu,
-					  struct perf_evsel *evsel, double avg,
+					  struct evsel *evsel, double avg,
 					  struct perf_stat_output_ctx *out,
 					  struct runtime_stat *st)
 {
@@ -439,7 +439,7 @@ static void print_stalled_cycles_frontend(struct perf_stat_config *config,
 
 static void print_stalled_cycles_backend(struct perf_stat_config *config,
 					 int cpu,
-					 struct perf_evsel *evsel, double avg,
+					 struct evsel *evsel, double avg,
 					 struct perf_stat_output_ctx *out,
 					 struct runtime_stat *st)
 {
@@ -459,7 +459,7 @@ static void print_stalled_cycles_backend(struct perf_stat_config *config,
 
 static void print_branch_misses(struct perf_stat_config *config,
 				int cpu,
-				struct perf_evsel *evsel,
+				struct evsel *evsel,
 				double avg,
 				struct perf_stat_output_ctx *out,
 				struct runtime_stat *st)
@@ -480,7 +480,7 @@ static void print_branch_misses(struct perf_stat_config *config,
 
 static void print_l1_dcache_misses(struct perf_stat_config *config,
 				   int cpu,
-				   struct perf_evsel *evsel,
+				   struct evsel *evsel,
 				   double avg,
 				   struct perf_stat_output_ctx *out,
 				   struct runtime_stat *st)
@@ -502,7 +502,7 @@ static void print_l1_dcache_misses(struct perf_stat_config *config,
 
 static void print_l1_icache_misses(struct perf_stat_config *config,
 				   int cpu,
-				   struct perf_evsel *evsel,
+				   struct evsel *evsel,
 				   double avg,
 				   struct perf_stat_output_ctx *out,
 				   struct runtime_stat *st)
@@ -523,7 +523,7 @@ static void print_l1_icache_misses(struct perf_stat_config *config,
 
 static void print_dtlb_cache_misses(struct perf_stat_config *config,
 				    int cpu,
-				    struct perf_evsel *evsel,
+				    struct evsel *evsel,
 				    double avg,
 				    struct perf_stat_output_ctx *out,
 				    struct runtime_stat *st)
@@ -543,7 +543,7 @@ static void print_dtlb_cache_misses(struct perf_stat_config *config,
 
 static void print_itlb_cache_misses(struct perf_stat_config *config,
 				    int cpu,
-				    struct perf_evsel *evsel,
+				    struct evsel *evsel,
 				    double avg,
 				    struct perf_stat_output_ctx *out,
 				    struct runtime_stat *st)
@@ -563,7 +563,7 @@ static void print_itlb_cache_misses(struct perf_stat_config *config,
 
 static void print_ll_cache_misses(struct perf_stat_config *config,
 				  int cpu,
-				  struct perf_evsel *evsel,
+				  struct evsel *evsel,
 				  double avg,
 				  struct perf_stat_output_ctx *out,
 				  struct runtime_stat *st)
@@ -686,7 +686,7 @@ static double td_be_bound(int ctx, int cpu, struct runtime_stat *st)
 }
 
 static void print_smi_cost(struct perf_stat_config *config,
-			   int cpu, struct perf_evsel *evsel,
+			   int cpu, struct evsel *evsel,
 			   struct perf_stat_output_ctx *out,
 			   struct runtime_stat *st)
 {
@@ -712,7 +712,7 @@ static void print_smi_cost(struct perf_stat_config *config,
 
 static void generic_metric(struct perf_stat_config *config,
 			   const char *metric_expr,
-			   struct perf_evsel **metric_events,
+			   struct evsel **metric_events,
 			   char *name,
 			   const char *metric_name,
 			   double avg,
@@ -780,7 +780,7 @@ static void generic_metric(struct perf_stat_config *config,
 }
 
 void perf_stat__print_shadow_stats(struct perf_stat_config *config,
-				   struct perf_evsel *evsel,
+				   struct evsel *evsel,
 				   double avg, int cpu,
 				   struct perf_stat_output_ctx *out,
 				   struct rblist *metric_events,
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 62791c063f7a..7acb9a6730fe 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -68,7 +68,7 @@ double rel_stddev_stats(double stddev, double avg)
 	return pct;
 }
 
-bool __perf_evsel_stat__is(struct perf_evsel *evsel,
+bool __perf_evsel_stat__is(struct evsel *evsel,
 			   enum perf_stat_evsel_id id)
 {
 	struct perf_stat_evsel *ps = evsel->stats;
@@ -93,7 +93,7 @@ static const char *id_str[PERF_STAT_EVSEL_ID__MAX] = {
 };
 #undef ID
 
-static void perf_stat_evsel_id_init(struct perf_evsel *evsel)
+static void perf_stat_evsel_id_init(struct evsel *evsel)
 {
 	struct perf_stat_evsel *ps = evsel->stats;
 	int i;
@@ -108,7 +108,7 @@ static void perf_stat_evsel_id_init(struct perf_evsel *evsel)
 	}
 }
 
-static void perf_evsel__reset_stat_priv(struct perf_evsel *evsel)
+static void perf_evsel__reset_stat_priv(struct evsel *evsel)
 {
 	int i;
 	struct perf_stat_evsel *ps = evsel->stats;
@@ -119,7 +119,7 @@ static void perf_evsel__reset_stat_priv(struct perf_evsel *evsel)
 	perf_stat_evsel_id_init(evsel);
 }
 
-static int perf_evsel__alloc_stat_priv(struct perf_evsel *evsel)
+static int perf_evsel__alloc_stat_priv(struct evsel *evsel)
 {
 	evsel->stats = zalloc(sizeof(struct perf_stat_evsel));
 	if (evsel->stats == NULL)
@@ -128,7 +128,7 @@ static int perf_evsel__alloc_stat_priv(struct perf_evsel *evsel)
 	return 0;
 }
 
-static void perf_evsel__free_stat_priv(struct perf_evsel *evsel)
+static void perf_evsel__free_stat_priv(struct evsel *evsel)
 {
 	struct perf_stat_evsel *ps = evsel->stats;
 
@@ -137,7 +137,7 @@ static void perf_evsel__free_stat_priv(struct perf_evsel *evsel)
 	zfree(&evsel->stats);
 }
 
-static int perf_evsel__alloc_prev_raw_counts(struct perf_evsel *evsel,
+static int perf_evsel__alloc_prev_raw_counts(struct evsel *evsel,
 					     int ncpus, int nthreads)
 {
 	struct perf_counts *counts;
@@ -149,13 +149,13 @@ static int perf_evsel__alloc_prev_raw_counts(struct perf_evsel *evsel,
 	return counts ? 0 : -ENOMEM;
 }
 
-static void perf_evsel__free_prev_raw_counts(struct perf_evsel *evsel)
+static void perf_evsel__free_prev_raw_counts(struct evsel *evsel)
 {
 	perf_counts__delete(evsel->prev_raw_counts);
 	evsel->prev_raw_counts = NULL;
 }
 
-static int perf_evsel__alloc_stats(struct perf_evsel *evsel, bool alloc_raw)
+static int perf_evsel__alloc_stats(struct evsel *evsel, bool alloc_raw)
 {
 	int ncpus = perf_evsel__nr_cpus(evsel);
 	int nthreads = thread_map__nr(evsel->threads);
@@ -170,7 +170,7 @@ static int perf_evsel__alloc_stats(struct perf_evsel *evsel, bool alloc_raw)
 
 int perf_evlist__alloc_stats(struct perf_evlist *evlist, bool alloc_raw)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (perf_evsel__alloc_stats(evsel, alloc_raw))
@@ -186,7 +186,7 @@ int perf_evlist__alloc_stats(struct perf_evlist *evlist, bool alloc_raw)
 
 void perf_evlist__free_stats(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel) {
 		perf_evsel__free_stat_priv(evsel);
@@ -197,7 +197,7 @@ void perf_evlist__free_stats(struct perf_evlist *evlist)
 
 void perf_evlist__reset_stats(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel) {
 		perf_evsel__reset_stat_priv(evsel);
@@ -205,13 +205,13 @@ void perf_evlist__reset_stats(struct perf_evlist *evlist)
 	}
 }
 
-static void zero_per_pkg(struct perf_evsel *counter)
+static void zero_per_pkg(struct evsel *counter)
 {
 	if (counter->per_pkg_mask)
 		memset(counter->per_pkg_mask, 0, MAX_NR_CPUS);
 }
 
-static int check_per_pkg(struct perf_evsel *counter,
+static int check_per_pkg(struct evsel *counter,
 			 struct perf_counts_values *vals, int cpu, bool *skip)
 {
 	unsigned long *mask = counter->per_pkg_mask;
@@ -254,7 +254,7 @@ static int check_per_pkg(struct perf_evsel *counter,
 }
 
 static int
-process_counter_values(struct perf_stat_config *config, struct perf_evsel *evsel,
+process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
 		       int cpu, int thread,
 		       struct perf_counts_values *count)
 {
@@ -306,7 +306,7 @@ process_counter_values(struct perf_stat_config *config, struct perf_evsel *evsel
 }
 
 static int process_counter_maps(struct perf_stat_config *config,
-				struct perf_evsel *counter)
+				struct evsel *counter)
 {
 	int nthreads = thread_map__nr(counter->threads);
 	int ncpus = perf_evsel__nr_cpus(counter);
@@ -327,7 +327,7 @@ static int process_counter_maps(struct perf_stat_config *config,
 }
 
 int perf_stat_process_counter(struct perf_stat_config *config,
-			      struct perf_evsel *counter)
+			      struct evsel *counter)
 {
 	struct perf_counts_values *aggr = &counter->counts->aggr;
 	struct perf_stat_evsel *ps = counter->stats;
@@ -381,7 +381,7 @@ int perf_event__process_stat_event(struct perf_session *session,
 {
 	struct perf_counts_values count;
 	struct stat_event *st = &event->stat;
-	struct perf_evsel *counter;
+	struct evsel *counter;
 
 	count.val = st->val;
 	count.ena = st->ena;
@@ -437,12 +437,12 @@ size_t perf_event__fprintf_stat_config(union perf_event *event, FILE *fp)
 	return ret;
 }
 
-int create_perf_stat_counter(struct perf_evsel *evsel,
+int create_perf_stat_counter(struct evsel *evsel,
 			     struct perf_stat_config *config,
 			     struct target *target)
 {
 	struct perf_event_attr *attr = &evsel->attr;
-	struct perf_evsel *leader = evsel->leader;
+	struct evsel *leader = evsel->leader;
 
 	attr->read_format = PERF_FORMAT_TOTAL_TIME_ENABLED |
 			    PERF_FORMAT_TOTAL_TIME_RUNNING;
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index fa675d09febd..b64cf0177a91 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -143,11 +143,11 @@ static inline void init_stats(struct stats *stats)
 	stats->max  = 0;
 }
 
-struct perf_evsel;
+struct evsel;
 struct perf_evlist;
 
 struct perf_aggr_thread_value {
-	struct perf_evsel *counter;
+	struct evsel *counter;
 	int id;
 	double uval;
 	u64 val;
@@ -155,7 +155,7 @@ struct perf_aggr_thread_value {
 	u64 ena;
 };
 
-bool __perf_evsel_stat__is(struct perf_evsel *evsel,
+bool __perf_evsel_stat__is(struct evsel *evsel,
 			   enum perf_stat_evsel_id id);
 
 #define perf_stat_evsel__is(evsel, id) \
@@ -174,7 +174,7 @@ void runtime_stat__exit(struct runtime_stat *st);
 void perf_stat__init_shadow_stats(void);
 void perf_stat__reset_shadow_stats(void);
 void perf_stat__reset_shadow_per_stat(struct runtime_stat *st);
-void perf_stat__update_shadow_stats(struct perf_evsel *counter, u64 count,
+void perf_stat__update_shadow_stats(struct evsel *counter, u64 count,
 				    int cpu, struct runtime_stat *st);
 struct perf_stat_output_ctx {
 	void *ctx;
@@ -184,7 +184,7 @@ struct perf_stat_output_ctx {
 };
 
 void perf_stat__print_shadow_stats(struct perf_stat_config *config,
-				   struct perf_evsel *evsel,
+				   struct evsel *evsel,
 				   double avg, int cpu,
 				   struct perf_stat_output_ctx *out,
 				   struct rblist *metric_events,
@@ -196,7 +196,7 @@ void perf_evlist__free_stats(struct perf_evlist *evlist);
 void perf_evlist__reset_stats(struct perf_evlist *evlist);
 
 int perf_stat_process_counter(struct perf_stat_config *config,
-			      struct perf_evsel *counter);
+			      struct evsel *counter);
 struct perf_tool;
 union perf_event;
 struct perf_session;
@@ -207,7 +207,7 @@ size_t perf_event__fprintf_stat(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_stat_round(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_stat_config(union perf_event *event, FILE *fp);
 
-int create_perf_stat_counter(struct perf_evsel *evsel,
+int create_perf_stat_counter(struct evsel *evsel,
 			     struct perf_stat_config *config,
 			     struct target *target);
 int perf_stat_synthesize_config(struct perf_stat_config *config,
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index 9096a6e3de59..5d880a6f0a34 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -9,7 +9,7 @@
 struct perf_session;
 union perf_event;
 struct perf_evlist;
-struct perf_evsel;
+struct evsel;
 struct perf_sample;
 struct perf_tool;
 struct machine;
@@ -17,7 +17,7 @@ struct ordered_events;
 
 typedef int (*event_sample)(struct perf_tool *tool, union perf_event *event,
 			    struct perf_sample *sample,
-			    struct perf_evsel *evsel, struct machine *machine);
+			    struct evsel *evsel, struct machine *machine);
 
 typedef int (*event_op)(struct perf_tool *tool, union perf_event *event,
 			struct perf_sample *sample, struct machine *machine);
diff --git a/tools/perf/util/top.c b/tools/perf/util/top.c
index 251bbf124fb0..9f098db76e3c 100644
--- a/tools/perf/util/top.c
+++ b/tools/perf/util/top.c
@@ -71,7 +71,7 @@ size_t perf_top__header_snprintf(struct perf_top *top, char *bf, size_t size)
 	}
 
 	if (top->evlist->nr_entries == 1) {
-		struct perf_evsel *first = perf_evlist__first(top->evlist);
+		struct evsel *first = perf_evlist__first(top->evlist);
 		ret += SNPRINTF(bf + ret, size - ret, "%" PRIu64 "%s ",
 				(uint64_t)first->attr.sample_period,
 				opts->freq ? "Hz" : "");
diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
index 19f95eaf75c8..7e0f363c0658 100644
--- a/tools/perf/util/top.h
+++ b/tools/perf/util/top.h
@@ -10,7 +10,7 @@
 #include <sys/ioctl.h>
 
 struct perf_evlist;
-struct perf_evsel;
+struct evsel;
 struct perf_session;
 
 struct perf_top {
@@ -33,7 +33,7 @@ struct perf_top {
 	bool		   vmlinux_warned;
 	bool		   dump_symtab;
 	struct hist_entry  *sym_filter_entry;
-	struct perf_evsel  *sym_evsel;
+	struct evsel 	   *sym_evsel;
 	struct perf_session *session;
 	struct winsize	   winsize;
 	int		   realtime_prio;
diff --git a/tools/perf/util/trace-event-info.c b/tools/perf/util/trace-event-info.c
index 4550015b9d5d..d7ae0627ac47 100644
--- a/tools/perf/util/trace-event-info.c
+++ b/tools/perf/util/trace-event-info.c
@@ -405,7 +405,7 @@ static struct tracepoint_path *
 get_tracepoints_path(struct list_head *pattrs)
 {
 	struct tracepoint_path path, *ppath = &path;
-	struct perf_evsel *pos;
+	struct evsel *pos;
 	int nr_tracepoints = 0;
 
 	list_for_each_entry(pos, pattrs, node) {
@@ -441,7 +441,7 @@ get_tracepoints_path(struct list_head *pattrs)
 
 bool have_tracepoints(struct list_head *pattrs)
 {
-	struct perf_evsel *pos;
+	struct evsel *pos;
 
 	list_for_each_entry(pos, pattrs, node)
 		if (pos->attr.type == PERF_TYPE_TRACEPOINT)
diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
index ba58f69777a1..dfd2640c763a 100644
--- a/tools/perf/util/trace-event-scripting.c
+++ b/tools/perf/util/trace-event-scripting.c
@@ -29,7 +29,7 @@ static int stop_script_unsupported(void)
 
 static void process_event_unsupported(union perf_event *event __maybe_unused,
 				      struct perf_sample *sample __maybe_unused,
-				      struct perf_evsel *evsel __maybe_unused,
+				      struct evsel *evsel __maybe_unused,
 				      struct addr_location *al __maybe_unused)
 {
 }
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index c7002fe11673..258d79071d81 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -79,13 +79,13 @@ struct scripting_ops {
 	int (*stop_script) (void);
 	void (*process_event) (union perf_event *event,
 			       struct perf_sample *sample,
-			       struct perf_evsel *evsel,
+			       struct evsel *evsel,
 			       struct addr_location *al);
 	void (*process_switch)(union perf_event *event,
 			       struct perf_sample *sample,
 			       struct machine *machine);
 	void (*process_stat)(struct perf_stat_config *config,
-			     struct perf_evsel *evsel, u64 tstamp);
+			     struct evsel *evsel, u64 tstamp);
 	void (*process_stat_interval)(u64 tstamp);
 	int (*generate_script) (struct tep_handle *pevent, const char *outfile);
 };
-- 
2.21.0

