Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D950CC76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4F72147A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563708397;
	bh=jzhXi2qYLSA+6cTzMtNCNIpTW40KUrGzETxqJjkDn3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X02v2r9UXV+VetBaByqdKi+hkHt4vGKjnnz4PS8bGotZguezyOO8Ys/8whrVGGdm4
	 ZxMdQUi6r5uReWazdoMA7KX47grRiAqk7Va6vSjfOC/asIgxJS48qjDRixkZawEMQd
	 7z6NVCl9D/BoPFy1hWbLZ+/E06PG//U5M0IxcsZY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfGUL0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:26:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41642 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726429AbfGUL0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:26:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 70CB23083363;
        Sun, 21 Jul 2019 11:26:33 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E2AE55D9D3;
        Sun, 21 Jul 2019 11:26:02 +0000 (UTC)
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
Subject: [PATCH 05/79] perf tools: Rename struct perf_evlist to struct evlist
Date:   Sun, 21 Jul 2019 13:23:52 +0200
Message-Id: <20190721112506.12306-6-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Sun, 21 Jul 2019 11:26:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renaming struct perf_evlist to struct evlist, so we don't
have a name clash when we add struct perf_evlist in libperf.

Link: http://lkml.kernel.org/n/tip-1yzah7o004o6ih6kv75kvrp2@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/arch/arm/util/auxtrace.c          |   2 +-
 tools/perf/arch/arm/util/cs-etm.c            |   8 +-
 tools/perf/arch/arm64/util/arm-spe.c         |   6 +-
 tools/perf/arch/powerpc/util/kvm-stat.c      |   6 +-
 tools/perf/arch/s390/util/auxtrace.c         |   6 +-
 tools/perf/arch/x86/tests/intel-cqm.c        |   2 +-
 tools/perf/arch/x86/tests/perf-time-to-tsc.c |   2 +-
 tools/perf/arch/x86/util/auxtrace.c          |   4 +-
 tools/perf/arch/x86/util/intel-bts.c         |   6 +-
 tools/perf/arch/x86/util/intel-pt.c          |  14 +-
 tools/perf/builtin-c2c.c                     |   4 +-
 tools/perf/builtin-diff.c                    |   8 +-
 tools/perf/builtin-ftrace.c                  |   2 +-
 tools/perf/builtin-inject.c                  |   8 +-
 tools/perf/builtin-kvm.c                     |   8 +-
 tools/perf/builtin-record.c                  |  14 +-
 tools/perf/builtin-report.c                  |   8 +-
 tools/perf/builtin-sched.c                   |   4 +-
 tools/perf/builtin-script.c                  |  10 +-
 tools/perf/builtin-stat.c                    |   2 +-
 tools/perf/builtin-top.c                     |  14 +-
 tools/perf/builtin-trace.c                   |  16 +-
 tools/perf/tests/backward-ring-buffer.c      |   6 +-
 tools/perf/tests/bpf.c                       |   2 +-
 tools/perf/tests/code-reading.c              |   8 +-
 tools/perf/tests/event-times.c               |  20 +-
 tools/perf/tests/event_update.c              |   2 +-
 tools/perf/tests/evsel-roundtrip-name.c      |   4 +-
 tools/perf/tests/hists_cumulate.c            |   2 +-
 tools/perf/tests/hists_filter.c              |   4 +-
 tools/perf/tests/hists_link.c                |   4 +-
 tools/perf/tests/hists_output.c              |   2 +-
 tools/perf/tests/keep-tracking.c             |   4 +-
 tools/perf/tests/mmap-basic.c                |   2 +-
 tools/perf/tests/openat-syscall-tp-fields.c  |   2 +-
 tools/perf/tests/parse-events.c              | 126 ++++++------
 tools/perf/tests/parse-no-sample-id-all.c    |   4 +-
 tools/perf/tests/perf-record.c               |   2 +-
 tools/perf/tests/sw-clock.c                  |   2 +-
 tools/perf/tests/switch-tracking.c           |  10 +-
 tools/perf/tests/task-exit.c                 |   2 +-
 tools/perf/tests/time-utils-test.c           |   2 +-
 tools/perf/ui/browsers/hists.c               |   6 +-
 tools/perf/ui/gtk/gtk.h                      |   4 +-
 tools/perf/ui/gtk/hists.c                    |   2 +-
 tools/perf/ui/hist.c                         |   2 +-
 tools/perf/util/auxtrace.c                   |  10 +-
 tools/perf/util/auxtrace.h                   |  24 +--
 tools/perf/util/bpf-event.c                  |   2 +-
 tools/perf/util/bpf-event.h                  |   4 +-
 tools/perf/util/bpf-loader.c                 |  20 +-
 tools/perf/util/bpf-loader.h                 |  24 +--
 tools/perf/util/cgroup.c                     |  10 +-
 tools/perf/util/cgroup.h                     |   6 +-
 tools/perf/util/data-convert-bt.c            |   4 +-
 tools/perf/util/evlist.c                     | 194 +++++++++----------
 tools/perf/util/evlist.h                     | 160 +++++++--------
 tools/perf/util/evsel.c                      |   4 +-
 tools/perf/util/evsel.h                      |   4 +-
 tools/perf/util/header.c                     |  86 ++++----
 tools/perf/util/header.h                     |  16 +-
 tools/perf/util/hist.c                       |   2 +-
 tools/perf/util/hist.h                       |  10 +-
 tools/perf/util/intel-bts.c                  |   2 +-
 tools/perf/util/intel-pt.c                   |  10 +-
 tools/perf/util/kvm-stat.h                   |   4 +-
 tools/perf/util/metricgroup.c                |   6 +-
 tools/perf/util/mmap.c                       |   2 +-
 tools/perf/util/parse-events.c               |  10 +-
 tools/perf/util/parse-events.h               |   6 +-
 tools/perf/util/python.c                     |  16 +-
 tools/perf/util/record.c                     |   8 +-
 tools/perf/util/s390-sample-raw.c            |   2 +-
 tools/perf/util/sample-raw.c                 |   2 +-
 tools/perf/util/sample-raw.h                 |   6 +-
 tools/perf/util/session.c                    |  24 +--
 tools/perf/util/session.h                    |   4 +-
 tools/perf/util/sort.c                       |  20 +-
 tools/perf/util/sort.h                       |   6 +-
 tools/perf/util/stat-display.c               |  18 +-
 tools/perf/util/stat-shadow.c                |   4 +-
 tools/perf/util/stat.c                       |   8 +-
 tools/perf/util/stat.h                       |  14 +-
 tools/perf/util/tool.h                       |   4 +-
 tools/perf/util/top.h                        |   4 +-
 85 files changed, 569 insertions(+), 569 deletions(-)

diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
index fd17dccfcb0b..306a54185438 100644
--- a/tools/perf/arch/arm/util/auxtrace.c
+++ b/tools/perf/arch/arm/util/auxtrace.c
@@ -50,7 +50,7 @@ static struct perf_pmu **find_all_arm_spe_pmus(int *nr_spes, int *err)
 }
 
 struct auxtrace_record
-*auxtrace_record__init(struct perf_evlist *evlist, int *err)
+*auxtrace_record__init(struct evlist *evlist, int *err)
 {
 	struct perf_pmu	*cs_etm_pmu;
 	struct evsel *evsel;
diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 49dda28023e4..48159b62f651 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -32,7 +32,7 @@
 struct cs_etm_recording {
 	struct auxtrace_record	itr;
 	struct perf_pmu		*cs_etm_pmu;
-	struct perf_evlist	*evlist;
+	struct evlist		*evlist;
 	int			wrapped_cnt;
 	bool			*wrapped;
 	bool			snapshot_mode;
@@ -245,7 +245,7 @@ static int cs_etm_set_sink_attr(struct perf_pmu *pmu,
 }
 
 static int cs_etm_recording_options(struct auxtrace_record *itr,
-				    struct perf_evlist *evlist,
+				    struct evlist *evlist,
 				    struct record_opts *opts)
 {
 	int ret;
@@ -434,7 +434,7 @@ static u64 cs_etm_get_config(struct auxtrace_record *itr)
 	struct cs_etm_recording *ptr =
 			container_of(itr, struct cs_etm_recording, itr);
 	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
-	struct perf_evlist *evlist = ptr->evlist;
+	struct evlist *evlist = ptr->evlist;
 	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel) {
@@ -485,7 +485,7 @@ static u64 cs_etmv4_get_config(struct auxtrace_record *itr)
 
 static size_t
 cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
-		      struct perf_evlist *evlist __maybe_unused)
+		      struct evlist *evlist __maybe_unused)
 {
 	int i;
 	int etmv3 = 0, etmv4 = 0;
diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 2c009aa74633..e0be366f72b3 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -27,12 +27,12 @@
 struct arm_spe_recording {
 	struct auxtrace_record		itr;
 	struct perf_pmu			*arm_spe_pmu;
-	struct perf_evlist		*evlist;
+	struct evlist		*evlist;
 };
 
 static size_t
 arm_spe_info_priv_size(struct auxtrace_record *itr __maybe_unused,
-		       struct perf_evlist *evlist __maybe_unused)
+		       struct evlist *evlist __maybe_unused)
 {
 	return ARM_SPE_AUXTRACE_PRIV_SIZE;
 }
@@ -59,7 +59,7 @@ static int arm_spe_info_fill(struct auxtrace_record *itr,
 }
 
 static int arm_spe_recording_options(struct auxtrace_record *itr,
-				     struct perf_evlist *evlist,
+				     struct evlist *evlist,
 				     struct record_opts *opts)
 {
 	struct arm_spe_recording *sper =
diff --git a/tools/perf/arch/powerpc/util/kvm-stat.c b/tools/perf/arch/powerpc/util/kvm-stat.c
index 557c474f0a4b..28fc0bab370f 100644
--- a/tools/perf/arch/powerpc/util/kvm-stat.c
+++ b/tools/perf/arch/powerpc/util/kvm-stat.c
@@ -106,7 +106,7 @@ const char * const kvm_skip_events[] = {
 };
 
 
-static int is_tracepoint_available(const char *str, struct perf_evlist *evlist)
+static int is_tracepoint_available(const char *str, struct evlist *evlist)
 {
 	struct parse_events_error err;
 	int ret;
@@ -119,7 +119,7 @@ static int is_tracepoint_available(const char *str, struct perf_evlist *evlist)
 }
 
 static int ppc__setup_book3s_hv(struct perf_kvm_stat *kvm,
-				struct perf_evlist *evlist)
+				struct evlist *evlist)
 {
 	const char **events_ptr;
 	int i, nr_tp = 0, err = -1;
@@ -146,7 +146,7 @@ static int ppc__setup_book3s_hv(struct perf_kvm_stat *kvm,
 /* Wrapper to setup kvm tracepoints */
 static int ppc__setup_kvm_tp(struct perf_kvm_stat *kvm)
 {
-	struct perf_evlist *evlist = perf_evlist__new();
+	struct evlist *evlist = perf_evlist__new();
 
 	if (evlist == NULL)
 		return -ENOMEM;
diff --git a/tools/perf/arch/s390/util/auxtrace.c b/tools/perf/arch/s390/util/auxtrace.c
index aec819b945c5..833f60fa9c5a 100644
--- a/tools/perf/arch/s390/util/auxtrace.c
+++ b/tools/perf/arch/s390/util/auxtrace.c
@@ -20,7 +20,7 @@ static void cpumsf_free(struct auxtrace_record *itr)
 }
 
 static size_t cpumsf_info_priv_size(struct auxtrace_record *itr __maybe_unused,
-				    struct perf_evlist *evlist __maybe_unused)
+				    struct evlist *evlist __maybe_unused)
 {
 	return 0;
 }
@@ -43,7 +43,7 @@ cpumsf_reference(struct auxtrace_record *itr __maybe_unused)
 
 static int
 cpumsf_recording_options(struct auxtrace_record *ar __maybe_unused,
-			 struct perf_evlist *evlist __maybe_unused,
+			 struct evlist *evlist __maybe_unused,
 			 struct record_opts *opts)
 {
 	unsigned int factor = 1;
@@ -82,7 +82,7 @@ cpumsf_parse_snapshot_options(struct auxtrace_record *itr __maybe_unused,
  * auxtrace_record__init is called when perf record
  * check if the event really need auxtrace
  */
-struct auxtrace_record *auxtrace_record__init(struct perf_evlist *evlist,
+struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
 					      int *err)
 {
 	struct auxtrace_record *aux;
diff --git a/tools/perf/arch/x86/tests/intel-cqm.c b/tools/perf/arch/x86/tests/intel-cqm.c
index b88ed71b2e3f..333b2f0d61e4 100644
--- a/tools/perf/arch/x86/tests/intel-cqm.c
+++ b/tools/perf/arch/x86/tests/intel-cqm.c
@@ -40,7 +40,7 @@ static pid_t spawn(void)
  */
 int test__intel_cqm_count_nmi_context(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
-	struct perf_evlist *evlist = NULL;
+	struct evlist *evlist = NULL;
 	struct evsel *evsel = NULL;
 	struct perf_event_attr pe;
 	int i, fd[2], flag, ret;
diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
index 43fc7d426d93..d7092fc00e3b 100644
--- a/tools/perf/arch/x86/tests/perf-time-to-tsc.c
+++ b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
@@ -51,7 +51,7 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 	};
 	struct perf_thread_map *threads = NULL;
 	struct perf_cpu_map *cpus = NULL;
-	struct perf_evlist *evlist = NULL;
+	struct evlist *evlist = NULL;
 	struct evsel *evsel = NULL;
 	int err = -1, ret, i;
 	const char *comm1, *comm2;
diff --git a/tools/perf/arch/x86/util/auxtrace.c b/tools/perf/arch/x86/util/auxtrace.c
index 02f192114448..6b3ad5c826fd 100644
--- a/tools/perf/arch/x86/util/auxtrace.c
+++ b/tools/perf/arch/x86/util/auxtrace.c
@@ -16,7 +16,7 @@
 #include "../../util/evlist.h"
 
 static
-struct auxtrace_record *auxtrace_record__init_intel(struct perf_evlist *evlist,
+struct auxtrace_record *auxtrace_record__init_intel(struct evlist *evlist,
 						    int *err)
 {
 	struct perf_pmu *intel_pt_pmu;
@@ -50,7 +50,7 @@ struct auxtrace_record *auxtrace_record__init_intel(struct perf_evlist *evlist,
 	return NULL;
 }
 
-struct auxtrace_record *auxtrace_record__init(struct perf_evlist *evlist,
+struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
 					      int *err)
 {
 	char buffer[64];
diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index 59685a19c3b9..c845531d383a 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -35,7 +35,7 @@ struct intel_bts_snapshot_ref {
 struct intel_bts_recording {
 	struct auxtrace_record		itr;
 	struct perf_pmu			*intel_bts_pmu;
-	struct perf_evlist		*evlist;
+	struct evlist		*evlist;
 	bool				snapshot_mode;
 	size_t				snapshot_size;
 	int				snapshot_ref_cnt;
@@ -50,7 +50,7 @@ struct branch {
 
 static size_t
 intel_bts_info_priv_size(struct auxtrace_record *itr __maybe_unused,
-			 struct perf_evlist *evlist __maybe_unused)
+			 struct evlist *evlist __maybe_unused)
 {
 	return INTEL_BTS_AUXTRACE_PRIV_SIZE;
 }
@@ -99,7 +99,7 @@ static int intel_bts_info_fill(struct auxtrace_record *itr,
 }
 
 static int intel_bts_recording_options(struct auxtrace_record *itr,
-				       struct perf_evlist *evlist,
+				       struct evlist *evlist,
 				       struct record_opts *opts)
 {
 	struct intel_bts_recording *btsr =
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index b42df73fd7ff..e4dfe8c3d5c3 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -44,7 +44,7 @@ struct intel_pt_recording {
 	struct auxtrace_record		itr;
 	struct perf_pmu			*intel_pt_pmu;
 	int				have_sched_switch;
-	struct perf_evlist		*evlist;
+	struct evlist		*evlist;
 	bool				snapshot_mode;
 	bool				snapshot_init_done;
 	size_t				snapshot_size;
@@ -110,7 +110,7 @@ static u64 intel_pt_masked_bits(u64 mask, u64 bits)
 }
 
 static int intel_pt_read_config(struct perf_pmu *intel_pt_pmu, const char *str,
-				struct perf_evlist *evlist, u64 *res)
+				struct evlist *evlist, u64 *res)
 {
 	struct evsel *evsel;
 	u64 mask;
@@ -132,7 +132,7 @@ static int intel_pt_read_config(struct perf_pmu *intel_pt_pmu, const char *str,
 }
 
 static size_t intel_pt_psb_period(struct perf_pmu *intel_pt_pmu,
-				  struct perf_evlist *evlist)
+				  struct evlist *evlist)
 {
 	u64 val;
 	int err, topa_multiple_entries;
@@ -268,7 +268,7 @@ intel_pt_pmu_default_config(struct perf_pmu *intel_pt_pmu)
 	return attr;
 }
 
-static const char *intel_pt_find_filter(struct perf_evlist *evlist,
+static const char *intel_pt_find_filter(struct evlist *evlist,
 					struct perf_pmu *intel_pt_pmu)
 {
 	struct evsel *evsel;
@@ -289,7 +289,7 @@ static size_t intel_pt_filter_bytes(const char *filter)
 }
 
 static size_t
-intel_pt_info_priv_size(struct auxtrace_record *itr, struct perf_evlist *evlist)
+intel_pt_info_priv_size(struct auxtrace_record *itr, struct evlist *evlist)
 {
 	struct intel_pt_recording *ptr =
 			container_of(itr, struct intel_pt_recording, itr);
@@ -398,7 +398,7 @@ static int intel_pt_info_fill(struct auxtrace_record *itr,
 	return 0;
 }
 
-static int intel_pt_track_switches(struct perf_evlist *evlist)
+static int intel_pt_track_switches(struct evlist *evlist)
 {
 	const char *sched_switch = "sched:sched_switch";
 	struct evsel *evsel;
@@ -549,7 +549,7 @@ static int intel_pt_validate_config(struct perf_pmu *intel_pt_pmu,
 }
 
 static int intel_pt_recording_options(struct auxtrace_record *itr,
-				      struct perf_evlist *evlist,
+				      struct evlist *evlist,
 				      struct record_opts *opts)
 {
 	struct intel_pt_recording *ptr =
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index d251a486f329..f0aae6e13a33 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2236,7 +2236,7 @@ static void print_pareto(FILE *out)
 
 static void print_c2c_info(FILE *out, struct perf_session *session)
 {
-	struct perf_evlist *evlist = session->evlist;
+	struct evlist *evlist = session->evlist;
 	struct evsel *evsel;
 	bool first = true;
 
@@ -2567,7 +2567,7 @@ parse_callchain_opt(const struct option *opt, const char *arg, int unset)
 	return parse_callchain_report_opt(arg);
 }
 
-static int setup_callchain(struct perf_evlist *evlist)
+static int setup_callchain(struct evlist *evlist)
 {
 	u64 sample_type = perf_evlist__combined_sample_type(evlist);
 	enum perf_call_graph_mode mode = CALLCHAIN_NONE;
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index c3b4b8196e00..e91c0d798181 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -449,7 +449,7 @@ static struct perf_diff pdiff = {
 };
 
 static struct evsel *evsel_match(struct evsel *evsel,
-				      struct perf_evlist *evlist)
+				      struct evlist *evlist)
 {
 	struct evsel *e;
 
@@ -461,7 +461,7 @@ static struct evsel *evsel_match(struct evsel *evsel,
 	return NULL;
 }
 
-static void perf_evlist__collapse_resort(struct perf_evlist *evlist)
+static void perf_evlist__collapse_resort(struct evlist *evlist)
 {
 	struct evsel *evsel;
 
@@ -1009,7 +1009,7 @@ static void data__fprintf(void)
 
 static void data_process(void)
 {
-	struct perf_evlist *evlist_base = data__files[0].session->evlist;
+	struct evlist *evlist_base = data__files[0].session->evlist;
 	struct evsel *evsel_base;
 	bool first = true;
 
@@ -1019,7 +1019,7 @@ static void data_process(void)
 		int i;
 
 		data__for_each_file_new(i, d) {
-			struct perf_evlist *evlist = d->session->evlist;
+			struct evlist *evlist = d->session->evlist;
 			struct evsel *evsel;
 			struct hists *hists;
 
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 3e81e0b6628f..1263987c291a 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -27,7 +27,7 @@
 #define DEFAULT_TRACER  "function_graph"
 
 struct perf_ftrace {
-	struct perf_evlist	*evlist;
+	struct evlist		*evlist;
 	struct target		target;
 	const char		*tracer;
 	struct list_head	filters;
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 646a1bf790fc..d2131fc863be 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -96,7 +96,7 @@ static int perf_event__repipe_op2_synth(struct perf_session *session,
 
 static int perf_event__repipe_attr(struct perf_tool *tool,
 				   union perf_event *event,
-				   struct perf_evlist **pevlist)
+				   struct evlist **pevlist)
 {
 	struct perf_inject *inject = container_of(tool, struct perf_inject,
 						  tool);
@@ -567,7 +567,7 @@ static int drop_sample(struct perf_tool *tool __maybe_unused,
 
 static void strip_init(struct perf_inject *inject)
 {
-	struct perf_evlist *evlist = inject->session->evlist;
+	struct evlist *evlist = inject->session->evlist;
 	struct evsel *evsel;
 
 	inject->tool.context_switch = perf_event__drop;
@@ -590,7 +590,7 @@ static bool has_tracking(struct evsel *evsel)
  * their selected event to exist, except if there is only 1 selected event left
  * and it has a compatible sample type.
  */
-static bool ok_to_remove(struct perf_evlist *evlist,
+static bool ok_to_remove(struct evlist *evlist,
 			 struct evsel *evsel_to_remove)
 {
 	struct evsel *evsel;
@@ -614,7 +614,7 @@ static bool ok_to_remove(struct perf_evlist *evlist,
 
 static void strip_fini(struct perf_inject *inject)
 {
-	struct perf_evlist *evlist = inject->session->evlist;
+	struct evlist *evlist = inject->session->evlist;
 	struct evsel *evsel, *tmp;
 
 	/* Remove non-synthesized evsels if possible */
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index cf8f27d05296..963dddc5853d 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -743,7 +743,7 @@ static bool verify_vcpu(int vcpu)
 static s64 perf_kvm__mmap_read_idx(struct perf_kvm_stat *kvm, int idx,
 				   u64 *mmap_time)
 {
-	struct perf_evlist *evlist = kvm->evlist;
+	struct evlist *evlist = kvm->evlist;
 	union perf_event *event;
 	struct perf_mmap *md;
 	u64 timestamp;
@@ -1012,7 +1012,7 @@ static int kvm_live_open_events(struct perf_kvm_stat *kvm)
 {
 	int err, rc = -1;
 	struct evsel *pos;
-	struct perf_evlist *evlist = kvm->evlist;
+	struct evlist *evlist = kvm->evlist;
 	char sbuf[STRERR_BUFSIZE];
 
 	perf_evlist__config(evlist, &kvm->opts, NULL);
@@ -1283,9 +1283,9 @@ kvm_events_report(struct perf_kvm_stat *kvm, int argc, const char **argv)
 }
 
 #ifdef HAVE_TIMERFD_SUPPORT
-static struct perf_evlist *kvm_live_event_list(void)
+static struct evlist *kvm_live_event_list(void)
 {
-	struct perf_evlist *evlist;
+	struct evlist *evlist;
 	char *tp, *name, *sys;
 	int err = -1;
 	const char * const *events_tp;
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 7ba3a2c32e54..f08d1e6a1651 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -73,7 +73,7 @@ struct record {
 	u64			bytes_written;
 	struct perf_data	data;
 	struct auxtrace_record	*itr;
-	struct perf_evlist	*evlist;
+	struct evlist	*evlist;
 	struct perf_session	*session;
 	int			realtime_prio;
 	bool			no_buildid;
@@ -346,7 +346,7 @@ static void record__aio_set_pos(int trace_fd, off_t pos)
 static void record__aio_mmap_read_sync(struct record *rec)
 {
 	int i;
-	struct perf_evlist *evlist = rec->evlist;
+	struct evlist *evlist = rec->evlist;
 	struct perf_mmap *maps = evlist->mmap;
 
 	if (!record__aio_enabled(rec))
@@ -672,7 +672,7 @@ static int record__auxtrace_init(struct record *rec __maybe_unused)
 #endif
 
 static int record__mmap_evlist(struct record *rec,
-			       struct perf_evlist *evlist)
+			       struct evlist *evlist)
 {
 	struct record_opts *opts = &rec->opts;
 	char msg[512];
@@ -714,7 +714,7 @@ static int record__open(struct record *rec)
 {
 	char msg[BUFSIZ];
 	struct evsel *pos;
-	struct perf_evlist *evlist = rec->evlist;
+	struct evlist *evlist = rec->evlist;
 	struct perf_session *session = rec->session;
 	struct record_opts *opts = &rec->opts;
 	int rc = 0;
@@ -904,7 +904,7 @@ static size_t zstd_compress(struct perf_session *session, void *dst, size_t dst_
 	return compressed;
 }
 
-static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evlist,
+static int record__mmap_read_evlist(struct record *rec, struct evlist *evlist,
 				    bool overwrite, bool synch)
 {
 	u64 bytes_written = rec->bytes_written;
@@ -1165,7 +1165,7 @@ perf_event__synth_time_conv(const struct perf_event_mmap_page *pc __maybe_unused
 }
 
 static const struct perf_event_mmap_page *
-perf_evlist__pick_pc(struct perf_evlist *evlist)
+perf_evlist__pick_pc(struct evlist *evlist)
 {
 	if (evlist) {
 		if (evlist->mmap && evlist->mmap[0].base)
@@ -1313,7 +1313,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	struct perf_data *data = &rec->data;
 	struct perf_session *session;
 	bool disabled = false, draining = false;
-	struct perf_evlist *sb_evlist = NULL;
+	struct evlist *sb_evlist = NULL;
 	int fd;
 	float ratio = 0;
 
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 96a506f0d4c1..e258e988c55b 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -193,7 +193,7 @@ static int hist_iter__branch_callback(struct hist_entry_iter *iter,
 }
 
 static void setup_forced_leader(struct report *report,
-				struct perf_evlist *evlist)
+				struct evlist *evlist)
 {
 	if (report->group_set)
 		perf_evlist__force_leader(evlist);
@@ -459,7 +459,7 @@ static size_t hists__fprintf_nr_sample_events(struct hists *hists, struct report
 	return ret + fprintf(fp, "\n#\n");
 }
 
-static int perf_evlist__tty_browse_hists(struct perf_evlist *evlist,
+static int perf_evlist__tty_browse_hists(struct evlist *evlist,
 					 struct report *rep,
 					 const char *help)
 {
@@ -532,7 +532,7 @@ static void report__warn_kptr_restrict(const struct report *rep)
 
 static int report__gtk_browse_hists(struct report *rep, const char *help)
 {
-	int (*hist_browser)(struct perf_evlist *evlist, const char *help,
+	int (*hist_browser)(struct evlist *evlist, const char *help,
 			    struct hist_browser_timer *timer, float min_pcnt);
 
 	hist_browser = dlsym(perf_gtk_handle, "perf_evlist__gtk_browse_hists");
@@ -549,7 +549,7 @@ static int report__browse_hists(struct report *rep)
 {
 	int ret;
 	struct perf_session *session = rep->session;
-	struct perf_evlist *evlist = session->evlist;
+	struct evlist *evlist = session->evlist;
 	const char *help = perf_tip(system_path(TIPDIR));
 
 	if (help == NULL) {
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 55779f496d27..c02ecb295f23 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2924,7 +2924,7 @@ static int perf_timehist__process_sample(struct perf_tool *tool,
 }
 
 static int timehist_check_attr(struct perf_sched *sched,
-			       struct perf_evlist *evlist)
+			       struct evlist *evlist)
 {
 	struct evsel *evsel;
 	struct evsel_runtime *er;
@@ -2963,7 +2963,7 @@ static int perf_sched__timehist(struct perf_sched *sched)
 	};
 
 	struct perf_session *session;
-	struct perf_evlist *evlist;
+	struct evlist *evlist;
 	int err = -1;
 
 	/*
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 4f9c8bb7620d..d741c0aa2750 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1636,7 +1636,7 @@ struct perf_script {
 	int			range_num;
 };
 
-static int perf_evlist__max_name_len(struct perf_evlist *evlist)
+static int perf_evlist__max_name_len(struct evlist *evlist)
 {
 	struct evsel *evsel;
 	int max = 0;
@@ -2018,10 +2018,10 @@ static int process_sample_event(struct perf_tool *tool,
 }
 
 static int process_attr(struct perf_tool *tool, union perf_event *event,
-			struct perf_evlist **pevlist)
+			struct evlist **pevlist)
 {
 	struct perf_script *scr = container_of(tool, struct perf_script, tool);
-	struct perf_evlist *evlist;
+	struct evlist *evlist;
 	struct evsel *evsel, *pos;
 	int err;
 	static struct evsel_script *es;
@@ -2388,7 +2388,7 @@ static void sig_handler(int sig __maybe_unused)
 
 static void perf_script__fclose_per_event_dump(struct perf_script *script)
 {
-	struct perf_evlist *evlist = script->session->evlist;
+	struct evlist *evlist = script->session->evlist;
 	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel) {
@@ -3256,7 +3256,7 @@ static int process_stat_config_event(struct perf_session *session __maybe_unused
 
 static int set_maps(struct perf_script *script)
 {
-	struct perf_evlist *evlist = script->session->evlist;
+	struct evlist *evlist = script->session->evlist;
 
 	if (!script->cpus || !script->threads)
 		return 0;
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index e0ba97018ad7..4e61f8a1d22b 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -130,7 +130,7 @@ static const char *smi_cost_attrs = {
 	"}"
 };
 
-static struct perf_evlist	*evsel_list;
+static struct evlist	*evsel_list;
 
 static struct target target = {
 	.uid	= UINT_MAX,
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 2f22f313985e..c29fa1de854f 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -839,7 +839,7 @@ static u64 last_timestamp;
 static void perf_top__mmap_read_idx(struct perf_top *top, int idx)
 {
 	struct record_opts *opts = &top->record_opts;
-	struct perf_evlist *evlist = top->evlist;
+	struct evlist *evlist = top->evlist;
 	struct perf_mmap *md;
 	union perf_event *event;
 
@@ -874,7 +874,7 @@ static void perf_top__mmap_read_idx(struct perf_top *top, int idx)
 static void perf_top__mmap_read(struct perf_top *top)
 {
 	bool overwrite = top->record_opts.overwrite;
-	struct perf_evlist *evlist = top->evlist;
+	struct evlist *evlist = top->evlist;
 	int i;
 
 	if (overwrite)
@@ -909,7 +909,7 @@ static void perf_top__mmap_read(struct perf_top *top)
 static int perf_top__overwrite_check(struct perf_top *top)
 {
 	struct record_opts *opts = &top->record_opts;
-	struct perf_evlist *evlist = top->evlist;
+	struct evlist *evlist = top->evlist;
 	struct perf_evsel_config_term *term;
 	struct list_head *config_terms;
 	struct evsel *evsel;
@@ -955,7 +955,7 @@ static int perf_top_overwrite_fallback(struct perf_top *top,
 				       struct evsel *evsel)
 {
 	struct record_opts *opts = &top->record_opts;
-	struct perf_evlist *evlist = top->evlist;
+	struct evlist *evlist = top->evlist;
 	struct evsel *counter;
 
 	if (!opts->overwrite)
@@ -976,7 +976,7 @@ static int perf_top__start_counters(struct perf_top *top)
 {
 	char msg[BUFSIZ];
 	struct evsel *counter;
-	struct perf_evlist *evlist = top->evlist;
+	struct evlist *evlist = top->evlist;
 	struct record_opts *opts = &top->record_opts;
 
 	if (perf_top__overwrite_check(top)) {
@@ -1100,7 +1100,7 @@ static int deliver_event(struct ordered_events *qe,
 			 struct ordered_event *qevent)
 {
 	struct perf_top *top = qe->data;
-	struct perf_evlist *evlist = top->evlist;
+	struct evlist *evlist = top->evlist;
 	struct perf_session *session = top->session;
 	union perf_event *event = qevent->event;
 	struct perf_sample sample;
@@ -1511,7 +1511,7 @@ int cmd_top(int argc, const char **argv)
 		    "Record namespaces events"),
 	OPT_END()
 	};
-	struct perf_evlist *sb_evlist = NULL;
+	struct evlist *sb_evlist = NULL;
 	const char * const top_usage[] = {
 		"perf top [<options>]",
 		NULL
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 506351d74cbc..dffff18f74cd 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -97,7 +97,7 @@ struct trace {
 		struct bpf_map *map;
 	} dump;
 	struct record_opts	opts;
-	struct perf_evlist	*evlist;
+	struct evlist	*evlist;
 	struct machine		*host;
 	struct thread		*current;
 	struct bpf_object	*bpf_obj;
@@ -1389,7 +1389,7 @@ static char *trace__machine__resolve_kernel_addr(void *vmachine, unsigned long l
 	return machine__resolve_kernel_addr(vmachine, addrp, modp);
 }
 
-static int trace__symbols_init(struct trace *trace, struct perf_evlist *evlist)
+static int trace__symbols_init(struct trace *trace, struct evlist *evlist)
 {
 	int err = symbol__init(NULL);
 
@@ -2628,7 +2628,7 @@ static int trace__record(struct trace *trace, int argc, const char **argv)
 
 static size_t trace__fprintf_thread_summary(struct trace *trace, FILE *fp);
 
-static bool perf_evlist__add_vfs_getname(struct perf_evlist *evlist)
+static bool perf_evlist__add_vfs_getname(struct evlist *evlist)
 {
 	bool found = false;
 	struct evsel *evsel, *tmp;
@@ -2711,7 +2711,7 @@ static void trace__handle_event(struct trace *trace, union perf_event *event, st
 static int trace__add_syscall_newtp(struct trace *trace)
 {
 	int ret = -1;
-	struct perf_evlist *evlist = trace->evlist;
+	struct evlist *evlist = trace->evlist;
 	struct evsel *sys_enter, *sys_exit;
 
 	sys_enter = perf_evsel__raw_syscall_newtp("sys_enter", trace__sys_enter);
@@ -3191,7 +3191,7 @@ static int trace__set_filter_pids(struct trace *trace)
 
 static int __trace__deliver_event(struct trace *trace, union perf_event *event)
 {
-	struct perf_evlist *evlist = trace->evlist;
+	struct evlist *evlist = trace->evlist;
 	struct perf_sample sample;
 	int err;
 
@@ -3249,7 +3249,7 @@ static int ordered_events__deliver_event(struct ordered_events *oe,
 
 static int trace__run(struct trace *trace, int argc, const char **argv)
 {
-	struct perf_evlist *evlist = trace->evlist;
+	struct evlist *evlist = trace->evlist;
 	struct evsel *evsel, *pgfault_maj = NULL, *pgfault_min = NULL;
 	int err = -1, i;
 	unsigned long before;
@@ -3842,7 +3842,7 @@ static int parse_pagefaults(const struct option *opt, const char *str,
 	return 0;
 }
 
-static void evlist__set_evsel_handler(struct perf_evlist *evlist, void *handler)
+static void evlist__set_evsel_handler(struct evlist *evlist, void *handler)
 {
 	struct evsel *evsel;
 
@@ -3850,7 +3850,7 @@ static void evlist__set_evsel_handler(struct perf_evlist *evlist, void *handler)
 		evsel->handler = handler;
 }
 
-static int evlist__set_syscall_tp_fields(struct perf_evlist *evlist)
+static int evlist__set_syscall_tp_fields(struct evlist *evlist)
 {
 	struct evsel *evsel;
 
diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
index 921af318507c..3f9c931069b0 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -25,7 +25,7 @@ static void testcase(void)
 	}
 }
 
-static int count_samples(struct perf_evlist *evlist, int *sample_count,
+static int count_samples(struct evlist *evlist, int *sample_count,
 			 int *comm_count)
 {
 	int i;
@@ -55,7 +55,7 @@ static int count_samples(struct perf_evlist *evlist, int *sample_count,
 	return TEST_OK;
 }
 
-static int do_test(struct perf_evlist *evlist, int mmap_pages,
+static int do_test(struct evlist *evlist, int mmap_pages,
 		   int *sample_count, int *comm_count)
 {
 	int err;
@@ -82,7 +82,7 @@ int test__backward_ring_buffer(struct test *test __maybe_unused, int subtest __m
 {
 	int ret = TEST_SKIP, err, sample_count = 0, comm_count = 0;
 	char pid[16], sbuf[STRERR_BUFSIZE];
-	struct perf_evlist *evlist;
+	struct evlist *evlist;
 	struct evsel *evsel __maybe_unused;
 	struct parse_events_error parse_error;
 	struct record_opts opts = {
diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index c9e4cdc4c9c8..95a15b51f95c 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -118,7 +118,7 @@ static int do_test(struct bpf_object *obj, int (*func)(void),
 
 	char pid[16];
 	char sbuf[STRERR_BUFSIZE];
-	struct perf_evlist *evlist;
+	struct evlist *evlist;
 	int i, ret = TEST_FAIL, err = 0, count = 0;
 
 	struct parse_events_state parse_state;
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 062d23bba2df..168deb9c563e 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -362,7 +362,7 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 }
 
 static int process_sample_event(struct machine *machine,
-				struct perf_evlist *evlist,
+				struct evlist *evlist,
 				union perf_event *event, struct state *state)
 {
 	struct perf_sample sample;
@@ -385,7 +385,7 @@ static int process_sample_event(struct machine *machine,
 	return ret;
 }
 
-static int process_event(struct machine *machine, struct perf_evlist *evlist,
+static int process_event(struct machine *machine, struct evlist *evlist,
 			 union perf_event *event, struct state *state)
 {
 	if (event->header.type == PERF_RECORD_SAMPLE)
@@ -408,7 +408,7 @@ static int process_event(struct machine *machine, struct perf_evlist *evlist,
 	return 0;
 }
 
-static int process_events(struct machine *machine, struct perf_evlist *evlist,
+static int process_events(struct machine *machine, struct evlist *evlist,
 			  struct state *state)
 {
 	union perf_event *event;
@@ -554,7 +554,7 @@ static int do_test_code_reading(bool try_kcore)
 	};
 	struct perf_thread_map *threads = NULL;
 	struct perf_cpu_map *cpus = NULL;
-	struct perf_evlist *evlist = NULL;
+	struct evlist *evlist = NULL;
 	struct evsel *evsel = NULL;
 	int err = -1, ret;
 	pid_t pid;
diff --git a/tools/perf/tests/event-times.c b/tools/perf/tests/event-times.c
index 45fe674233d7..c3545a6efcbc 100644
--- a/tools/perf/tests/event-times.c
+++ b/tools/perf/tests/event-times.c
@@ -12,7 +12,7 @@
 #include "thread_map.h"
 #include "target.h"
 
-static int attach__enable_on_exec(struct perf_evlist *evlist)
+static int attach__enable_on_exec(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__last(evlist);
 	struct target target = {
@@ -48,13 +48,13 @@ static int attach__enable_on_exec(struct perf_evlist *evlist)
 	return perf_evlist__start_workload(evlist) == 1 ? TEST_OK : TEST_FAIL;
 }
 
-static int detach__enable_on_exec(struct perf_evlist *evlist)
+static int detach__enable_on_exec(struct evlist *evlist)
 {
 	waitpid(evlist->workload.pid, NULL, 0);
 	return 0;
 }
 
-static int attach__current_disabled(struct perf_evlist *evlist)
+static int attach__current_disabled(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__last(evlist);
 	struct perf_thread_map *threads;
@@ -80,7 +80,7 @@ static int attach__current_disabled(struct perf_evlist *evlist)
 	return perf_evsel__enable(evsel) == 0 ? TEST_OK : TEST_FAIL;
 }
 
-static int attach__current_enabled(struct perf_evlist *evlist)
+static int attach__current_enabled(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__last(evlist);
 	struct perf_thread_map *threads;
@@ -100,14 +100,14 @@ static int attach__current_enabled(struct perf_evlist *evlist)
 	return err == 0 ? TEST_OK : TEST_FAIL;
 }
 
-static int detach__disable(struct perf_evlist *evlist)
+static int detach__disable(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__last(evlist);
 
 	return perf_evsel__enable(evsel);
 }
 
-static int attach__cpu_disabled(struct perf_evlist *evlist)
+static int attach__cpu_disabled(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__last(evlist);
 	struct perf_cpu_map *cpus;
@@ -136,7 +136,7 @@ static int attach__cpu_disabled(struct perf_evlist *evlist)
 	return perf_evsel__enable(evsel);
 }
 
-static int attach__cpu_enabled(struct perf_evlist *evlist)
+static int attach__cpu_enabled(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__last(evlist);
 	struct perf_cpu_map *cpus;
@@ -158,11 +158,11 @@ static int attach__cpu_enabled(struct perf_evlist *evlist)
 	return err ? TEST_FAIL : TEST_OK;
 }
 
-static int test_times(int (attach)(struct perf_evlist *),
-		      int (detach)(struct perf_evlist *))
+static int test_times(int (attach)(struct evlist *),
+		      int (detach)(struct evlist *))
 {
 	struct perf_counts_values count;
-	struct perf_evlist *evlist = NULL;
+	struct evlist *evlist = NULL;
 	struct evsel *evsel;
 	int err = -1, i;
 
diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
index 0e5a2e8195e4..eb0dd359762d 100644
--- a/tools/perf/tests/event_update.c
+++ b/tools/perf/tests/event_update.c
@@ -79,7 +79,7 @@ static int process_event_cpus(struct perf_tool *tool __maybe_unused,
 
 int test__event_update(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
-	struct perf_evlist *evlist;
+	struct evlist *evlist;
 	struct evsel *evsel;
 	struct event_name tmp;
 
diff --git a/tools/perf/tests/evsel-roundtrip-name.c b/tools/perf/tests/evsel-roundtrip-name.c
index bb38489eda1e..6cc408b23026 100644
--- a/tools/perf/tests/evsel-roundtrip-name.c
+++ b/tools/perf/tests/evsel-roundtrip-name.c
@@ -12,7 +12,7 @@ static int perf_evsel__roundtrip_cache_name_test(void)
 	char name[128];
 	int type, op, err = 0, ret = 0, i, idx;
 	struct evsel *evsel;
-	struct perf_evlist *evlist = perf_evlist__new();
+	struct evlist *evlist = perf_evlist__new();
 
         if (evlist == NULL)
                 return -ENOMEM;
@@ -68,7 +68,7 @@ static int __perf_evsel__name_array_test(const char *names[], int nr_names)
 {
 	int i, err;
 	struct evsel *evsel;
-	struct perf_evlist *evlist = perf_evlist__new();
+	struct evlist *evlist = perf_evlist__new();
 
         if (evlist == NULL)
                 return -ENOMEM;
diff --git a/tools/perf/tests/hists_cumulate.c b/tools/perf/tests/hists_cumulate.c
index b62bf7c3bea2..d7a6b97683d6 100644
--- a/tools/perf/tests/hists_cumulate.c
+++ b/tools/perf/tests/hists_cumulate.c
@@ -695,7 +695,7 @@ int test__hists_cumulate(struct test *test __maybe_unused, int subtest __maybe_u
 	struct machines machines;
 	struct machine *machine;
 	struct evsel *evsel;
-	struct perf_evlist *evlist = perf_evlist__new();
+	struct evlist *evlist = perf_evlist__new();
 	size_t i;
 	test_fn_t testcases[] = {
 		test1,
diff --git a/tools/perf/tests/hists_filter.c b/tools/perf/tests/hists_filter.c
index 3e679bb8da7f..9f0d6af839e9 100644
--- a/tools/perf/tests/hists_filter.c
+++ b/tools/perf/tests/hists_filter.c
@@ -47,7 +47,7 @@ static struct sample fake_samples[] = {
 	{ .pid = FAKE_PID_BASH,  .ip = FAKE_IP_KERNEL_PAGE_FAULT, .socket = 3 },
 };
 
-static int add_hist_entries(struct perf_evlist *evlist,
+static int add_hist_entries(struct evlist *evlist,
 			    struct machine *machine)
 {
 	struct evsel *evsel;
@@ -109,7 +109,7 @@ int test__hists_filter(struct test *test __maybe_unused, int subtest __maybe_unu
 	struct machines machines;
 	struct machine *machine;
 	struct evsel *evsel;
-	struct perf_evlist *evlist = perf_evlist__new();
+	struct evlist *evlist = perf_evlist__new();
 
 	TEST_ASSERT_VAL("No memory", evlist);
 
diff --git a/tools/perf/tests/hists_link.c b/tools/perf/tests/hists_link.c
index 078ee9876980..6ab27dd3bf3f 100644
--- a/tools/perf/tests/hists_link.c
+++ b/tools/perf/tests/hists_link.c
@@ -62,7 +62,7 @@ static struct sample fake_samples[][5] = {
 	},
 };
 
-static int add_hist_entries(struct perf_evlist *evlist, struct machine *machine)
+static int add_hist_entries(struct evlist *evlist, struct machine *machine)
 {
 	struct evsel *evsel;
 	struct addr_location al;
@@ -272,7 +272,7 @@ int test__hists_link(struct test *test __maybe_unused, int subtest __maybe_unuse
 	struct machines machines;
 	struct machine *machine = NULL;
 	struct evsel *evsel, *first;
-	struct perf_evlist *evlist = perf_evlist__new();
+	struct evlist *evlist = perf_evlist__new();
 
 	if (evlist == NULL)
                 return -ENOMEM;
diff --git a/tools/perf/tests/hists_output.c b/tools/perf/tests/hists_output.c
index 5cd4b1baa9d1..cd36e51cdf3b 100644
--- a/tools/perf/tests/hists_output.c
+++ b/tools/perf/tests/hists_output.c
@@ -581,7 +581,7 @@ int test__hists_output(struct test *test __maybe_unused, int subtest __maybe_unu
 	struct machines machines;
 	struct machine *machine;
 	struct evsel *evsel;
-	struct perf_evlist *evlist = perf_evlist__new();
+	struct evlist *evlist = perf_evlist__new();
 	size_t i;
 	test_fn_t testcases[] = {
 		test1,
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index 8ada3e63f1ba..e0779f2a340c 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -24,7 +24,7 @@
 	}					\
 }
 
-static int find_comm(struct perf_evlist *evlist, const char *comm)
+static int find_comm(struct evlist *evlist, const char *comm)
 {
 	union perf_event *event;
 	struct perf_mmap *md;
@@ -67,7 +67,7 @@ int test__keep_tracking(struct test *test __maybe_unused, int subtest __maybe_un
 	};
 	struct perf_thread_map *threads = NULL;
 	struct perf_cpu_map *cpus = NULL;
-	struct perf_evlist *evlist = NULL;
+	struct evlist *evlist = NULL;
 	struct evsel *evsel = NULL;
 	int found, err = -1;
 	const char *comm;
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 76ee42eb1355..749b580e9a92 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -29,7 +29,7 @@ int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unuse
 	union perf_event *event;
 	struct perf_thread_map *threads;
 	struct perf_cpu_map *cpus;
-	struct perf_evlist *evlist;
+	struct evlist *evlist;
 	cpu_set_t cpu_set;
 	const char *syscall_names[] = { "getsid", "getppid", "getpgid", };
 	pid_t (*syscalls[])(void) = { (void *)getsid, getppid, (void*)getpgid };
diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index 2e467448e220..69bf0ec2fe5f 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -32,7 +32,7 @@ int test__syscall_openat_tp_fields(struct test *test __maybe_unused, int subtest
 	};
 	const char *filename = "/etc/passwd";
 	int flags = O_RDONLY | O_DIRECTORY;
-	struct perf_evlist *evlist = perf_evlist__new();
+	struct evlist *evlist = perf_evlist__new();
 	struct evsel *evsel;
 	int err = -1, i, nr_events = 0, nr_polls = 0;
 	char sbuf[STRERR_BUFSIZE];
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index f55ab43d51bd..7409eed11b65 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -44,7 +44,7 @@ static bool kvm_s390_create_vm_valid(void)
 }
 #endif
 
-static int test__checkevent_tracepoint(struct perf_evlist *evlist)
+static int test__checkevent_tracepoint(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
@@ -57,7 +57,7 @@ static int test__checkevent_tracepoint(struct perf_evlist *evlist)
 	return 0;
 }
 
-static int test__checkevent_tracepoint_multi(struct perf_evlist *evlist)
+static int test__checkevent_tracepoint_multi(struct evlist *evlist)
 {
 	struct evsel *evsel;
 
@@ -75,7 +75,7 @@ static int test__checkevent_tracepoint_multi(struct perf_evlist *evlist)
 	return 0;
 }
 
-static int test__checkevent_raw(struct perf_evlist *evlist)
+static int test__checkevent_raw(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
@@ -85,7 +85,7 @@ static int test__checkevent_raw(struct perf_evlist *evlist)
 	return 0;
 }
 
-static int test__checkevent_numeric(struct perf_evlist *evlist)
+static int test__checkevent_numeric(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
@@ -95,7 +95,7 @@ static int test__checkevent_numeric(struct perf_evlist *evlist)
 	return 0;
 }
 
-static int test__checkevent_symbolic_name(struct perf_evlist *evlist)
+static int test__checkevent_symbolic_name(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
@@ -106,7 +106,7 @@ static int test__checkevent_symbolic_name(struct perf_evlist *evlist)
 	return 0;
 }
 
-static int test__checkevent_symbolic_name_config(struct perf_evlist *evlist)
+static int test__checkevent_symbolic_name_config(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
@@ -127,7 +127,7 @@ static int test__checkevent_symbolic_name_config(struct perf_evlist *evlist)
 	return 0;
 }
 
-static int test__checkevent_symbolic_alias(struct perf_evlist *evlist)
+static int test__checkevent_symbolic_alias(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
@@ -138,7 +138,7 @@ static int test__checkevent_symbolic_alias(struct perf_evlist *evlist)
 	return 0;
 }
 
-static int test__checkevent_genhw(struct perf_evlist *evlist)
+static int test__checkevent_genhw(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
@@ -148,7 +148,7 @@ static int test__checkevent_genhw(struct perf_evlist *evlist)
 	return 0;
 }
 
-static int test__checkevent_breakpoint(struct perf_evlist *evlist)
+static int test__checkevent_breakpoint(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
@@ -162,7 +162,7 @@ static int test__checkevent_breakpoint(struct perf_evlist *evlist)
 	return 0;
 }
 
-static int test__checkevent_breakpoint_x(struct perf_evlist *evlist)
+static int test__checkevent_breakpoint_x(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
@@ -175,7 +175,7 @@ static int test__checkevent_breakpoint_x(struct perf_evlist *evlist)
 	return 0;
 }
 
-static int test__checkevent_breakpoint_r(struct perf_evlist *evlist)
+static int test__checkevent_breakpoint_r(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
@@ -190,7 +190,7 @@ static int test__checkevent_breakpoint_r(struct perf_evlist *evlist)
 	return 0;
 }
 
-static int test__checkevent_breakpoint_w(struct perf_evlist *evlist)
+static int test__checkevent_breakpoint_w(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
@@ -205,7 +205,7 @@ static int test__checkevent_breakpoint_w(struct perf_evlist *evlist)
 	return 0;
 }
 
-static int test__checkevent_breakpoint_rw(struct perf_evlist *evlist)
+static int test__checkevent_breakpoint_rw(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
@@ -220,7 +220,7 @@ static int test__checkevent_breakpoint_rw(struct perf_evlist *evlist)
 	return 0;
 }
 
-static int test__checkevent_tracepoint_modifier(struct perf_evlist *evlist)
+static int test__checkevent_tracepoint_modifier(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
@@ -233,7 +233,7 @@ static int test__checkevent_tracepoint_modifier(struct perf_evlist *evlist)
 }
 
 static int
-test__checkevent_tracepoint_multi_modifier(struct perf_evlist *evlist)
+test__checkevent_tracepoint_multi_modifier(struct evlist *evlist)
 {
 	struct evsel *evsel;
 
@@ -251,7 +251,7 @@ test__checkevent_tracepoint_multi_modifier(struct perf_evlist *evlist)
 	return test__checkevent_tracepoint_multi(evlist);
 }
 
-static int test__checkevent_raw_modifier(struct perf_evlist *evlist)
+static int test__checkevent_raw_modifier(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
@@ -263,7 +263,7 @@ static int test__checkevent_raw_modifier(struct perf_evlist *evlist)
 	return test__checkevent_raw(evlist);
 }
 
-static int test__checkevent_numeric_modifier(struct perf_evlist *evlist)
+static int test__checkevent_numeric_modifier(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
@@ -275,7 +275,7 @@ static int test__checkevent_numeric_modifier(struct perf_evlist *evlist)
 	return test__checkevent_numeric(evlist);
 }
 
-static int test__checkevent_symbolic_name_modifier(struct perf_evlist *evlist)
+static int test__checkevent_symbolic_name_modifier(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
@@ -287,7 +287,7 @@ static int test__checkevent_symbolic_name_modifier(struct perf_evlist *evlist)
 	return test__checkevent_symbolic_name(evlist);
 }
 
-static int test__checkevent_exclude_host_modifier(struct perf_evlist *evlist)
+static int test__checkevent_exclude_host_modifier(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
@@ -297,7 +297,7 @@ static int test__checkevent_exclude_host_modifier(struct perf_evlist *evlist)
 	return test__checkevent_symbolic_name(evlist);
 }
 
-static int test__checkevent_exclude_guest_modifier(struct perf_evlist *evlist)
+static int test__checkevent_exclude_guest_modifier(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
@@ -307,7 +307,7 @@ static int test__checkevent_exclude_guest_modifier(struct perf_evlist *evlist)
 	return test__checkevent_symbolic_name(evlist);
 }
 
-static int test__checkevent_symbolic_alias_modifier(struct perf_evlist *evlist)
+static int test__checkevent_symbolic_alias_modifier(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
@@ -319,7 +319,7 @@ static int test__checkevent_symbolic_alias_modifier(struct perf_evlist *evlist)
 	return test__checkevent_symbolic_alias(evlist);
 }
 
-static int test__checkevent_genhw_modifier(struct perf_evlist *evlist)
+static int test__checkevent_genhw_modifier(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
@@ -331,7 +331,7 @@ static int test__checkevent_genhw_modifier(struct perf_evlist *evlist)
 	return test__checkevent_genhw(evlist);
 }
 
-static int test__checkevent_exclude_idle_modifier(struct perf_evlist *evlist)
+static int test__checkevent_exclude_idle_modifier(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
@@ -346,7 +346,7 @@ static int test__checkevent_exclude_idle_modifier(struct perf_evlist *evlist)
 	return test__checkevent_symbolic_name(evlist);
 }
 
-static int test__checkevent_exclude_idle_modifier_1(struct perf_evlist *evlist)
+static int test__checkevent_exclude_idle_modifier_1(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
@@ -361,7 +361,7 @@ static int test__checkevent_exclude_idle_modifier_1(struct perf_evlist *evlist)
 	return test__checkevent_symbolic_name(evlist);
 }
 
-static int test__checkevent_breakpoint_modifier(struct perf_evlist *evlist)
+static int test__checkevent_breakpoint_modifier(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
@@ -376,7 +376,7 @@ static int test__checkevent_breakpoint_modifier(struct perf_evlist *evlist)
 	return test__checkevent_breakpoint(evlist);
 }
 
-static int test__checkevent_breakpoint_x_modifier(struct perf_evlist *evlist)
+static int test__checkevent_breakpoint_x_modifier(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
@@ -390,7 +390,7 @@ static int test__checkevent_breakpoint_x_modifier(struct perf_evlist *evlist)
 	return test__checkevent_breakpoint_x(evlist);
 }
 
-static int test__checkevent_breakpoint_r_modifier(struct perf_evlist *evlist)
+static int test__checkevent_breakpoint_r_modifier(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
@@ -404,7 +404,7 @@ static int test__checkevent_breakpoint_r_modifier(struct perf_evlist *evlist)
 	return test__checkevent_breakpoint_r(evlist);
 }
 
-static int test__checkevent_breakpoint_w_modifier(struct perf_evlist *evlist)
+static int test__checkevent_breakpoint_w_modifier(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
@@ -418,7 +418,7 @@ static int test__checkevent_breakpoint_w_modifier(struct perf_evlist *evlist)
 	return test__checkevent_breakpoint_w(evlist);
 }
 
-static int test__checkevent_breakpoint_rw_modifier(struct perf_evlist *evlist)
+static int test__checkevent_breakpoint_rw_modifier(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
@@ -432,7 +432,7 @@ static int test__checkevent_breakpoint_rw_modifier(struct perf_evlist *evlist)
 	return test__checkevent_breakpoint_rw(evlist);
 }
 
-static int test__checkevent_pmu(struct perf_evlist *evlist)
+static int test__checkevent_pmu(struct evlist *evlist)
 {
 
 	struct evsel *evsel = perf_evlist__first(evlist);
@@ -451,7 +451,7 @@ static int test__checkevent_pmu(struct perf_evlist *evlist)
 	return 0;
 }
 
-static int test__checkevent_list(struct perf_evlist *evlist)
+static int test__checkevent_list(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
@@ -490,7 +490,7 @@ static int test__checkevent_list(struct perf_evlist *evlist)
 	return 0;
 }
 
-static int test__checkevent_pmu_name(struct perf_evlist *evlist)
+static int test__checkevent_pmu_name(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
@@ -511,7 +511,7 @@ static int test__checkevent_pmu_name(struct perf_evlist *evlist)
 	return 0;
 }
 
-static int test__checkevent_pmu_partial_time_callgraph(struct perf_evlist *evlist)
+static int test__checkevent_pmu_partial_time_callgraph(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
@@ -544,7 +544,7 @@ static int test__checkevent_pmu_partial_time_callgraph(struct perf_evlist *evlis
 	return 0;
 }
 
-static int test__checkevent_pmu_events(struct perf_evlist *evlist)
+static int test__checkevent_pmu_events(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
@@ -562,7 +562,7 @@ static int test__checkevent_pmu_events(struct perf_evlist *evlist)
 }
 
 
-static int test__checkevent_pmu_events_mix(struct perf_evlist *evlist)
+static int test__checkevent_pmu_events_mix(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
@@ -634,7 +634,7 @@ static int test__checkterms_simple(struct list_head *terms)
 	return 0;
 }
 
-static int test__group1(struct perf_evlist *evlist)
+static int test__group1(struct evlist *evlist)
 {
 	struct evsel *evsel, *leader;
 
@@ -676,7 +676,7 @@ static int test__group1(struct perf_evlist *evlist)
 	return 0;
 }
 
-static int test__group2(struct perf_evlist *evlist)
+static int test__group2(struct evlist *evlist)
 {
 	struct evsel *evsel, *leader;
 
@@ -731,7 +731,7 @@ static int test__group2(struct perf_evlist *evlist)
 	return 0;
 }
 
-static int test__group3(struct perf_evlist *evlist __maybe_unused)
+static int test__group3(struct evlist *evlist __maybe_unused)
 {
 	struct evsel *evsel, *leader;
 
@@ -823,7 +823,7 @@ static int test__group3(struct perf_evlist *evlist __maybe_unused)
 	return 0;
 }
 
-static int test__group4(struct perf_evlist *evlist __maybe_unused)
+static int test__group4(struct evlist *evlist __maybe_unused)
 {
 	struct evsel *evsel, *leader;
 
@@ -867,7 +867,7 @@ static int test__group4(struct perf_evlist *evlist __maybe_unused)
 	return 0;
 }
 
-static int test__group5(struct perf_evlist *evlist __maybe_unused)
+static int test__group5(struct evlist *evlist __maybe_unused)
 {
 	struct evsel *evsel, *leader;
 
@@ -953,7 +953,7 @@ static int test__group5(struct perf_evlist *evlist __maybe_unused)
 	return 0;
 }
 
-static int test__group_gh1(struct perf_evlist *evlist)
+static int test__group_gh1(struct evlist *evlist)
 {
 	struct evsel *evsel, *leader;
 
@@ -993,7 +993,7 @@ static int test__group_gh1(struct perf_evlist *evlist)
 	return 0;
 }
 
-static int test__group_gh2(struct perf_evlist *evlist)
+static int test__group_gh2(struct evlist *evlist)
 {
 	struct evsel *evsel, *leader;
 
@@ -1033,7 +1033,7 @@ static int test__group_gh2(struct perf_evlist *evlist)
 	return 0;
 }
 
-static int test__group_gh3(struct perf_evlist *evlist)
+static int test__group_gh3(struct evlist *evlist)
 {
 	struct evsel *evsel, *leader;
 
@@ -1073,7 +1073,7 @@ static int test__group_gh3(struct perf_evlist *evlist)
 	return 0;
 }
 
-static int test__group_gh4(struct perf_evlist *evlist)
+static int test__group_gh4(struct evlist *evlist)
 {
 	struct evsel *evsel, *leader;
 
@@ -1113,7 +1113,7 @@ static int test__group_gh4(struct perf_evlist *evlist)
 	return 0;
 }
 
-static int test__leader_sample1(struct perf_evlist *evlist)
+static int test__leader_sample1(struct evlist *evlist)
 {
 	struct evsel *evsel, *leader;
 
@@ -1166,7 +1166,7 @@ static int test__leader_sample1(struct perf_evlist *evlist)
 	return 0;
 }
 
-static int test__leader_sample2(struct perf_evlist *evlist __maybe_unused)
+static int test__leader_sample2(struct evlist *evlist __maybe_unused)
 {
 	struct evsel *evsel, *leader;
 
@@ -1205,7 +1205,7 @@ static int test__leader_sample2(struct perf_evlist *evlist __maybe_unused)
 	return 0;
 }
 
-static int test__checkevent_pinned_modifier(struct perf_evlist *evlist)
+static int test__checkevent_pinned_modifier(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
@@ -1218,7 +1218,7 @@ static int test__checkevent_pinned_modifier(struct perf_evlist *evlist)
 	return test__checkevent_symbolic_name(evlist);
 }
 
-static int test__pinned_group(struct perf_evlist *evlist)
+static int test__pinned_group(struct evlist *evlist)
 {
 	struct evsel *evsel, *leader;
 
@@ -1249,7 +1249,7 @@ static int test__pinned_group(struct perf_evlist *evlist)
 	return 0;
 }
 
-static int test__checkevent_breakpoint_len(struct perf_evlist *evlist)
+static int test__checkevent_breakpoint_len(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
@@ -1264,7 +1264,7 @@ static int test__checkevent_breakpoint_len(struct perf_evlist *evlist)
 	return 0;
 }
 
-static int test__checkevent_breakpoint_len_w(struct perf_evlist *evlist)
+static int test__checkevent_breakpoint_len_w(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
@@ -1280,7 +1280,7 @@ static int test__checkevent_breakpoint_len_w(struct perf_evlist *evlist)
 }
 
 static int
-test__checkevent_breakpoint_len_rw_modifier(struct perf_evlist *evlist)
+test__checkevent_breakpoint_len_rw_modifier(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
@@ -1292,7 +1292,7 @@ test__checkevent_breakpoint_len_rw_modifier(struct perf_evlist *evlist)
 	return test__checkevent_breakpoint_rw(evlist);
 }
 
-static int test__checkevent_precise_max_modifier(struct perf_evlist *evlist)
+static int test__checkevent_precise_max_modifier(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
@@ -1303,7 +1303,7 @@ static int test__checkevent_precise_max_modifier(struct perf_evlist *evlist)
 	return 0;
 }
 
-static int test__checkevent_config_symbol(struct perf_evlist *evlist)
+static int test__checkevent_config_symbol(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
@@ -1311,7 +1311,7 @@ static int test__checkevent_config_symbol(struct perf_evlist *evlist)
 	return 0;
 }
 
-static int test__checkevent_config_raw(struct perf_evlist *evlist)
+static int test__checkevent_config_raw(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
@@ -1319,7 +1319,7 @@ static int test__checkevent_config_raw(struct perf_evlist *evlist)
 	return 0;
 }
 
-static int test__checkevent_config_num(struct perf_evlist *evlist)
+static int test__checkevent_config_num(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
@@ -1327,7 +1327,7 @@ static int test__checkevent_config_num(struct perf_evlist *evlist)
 	return 0;
 }
 
-static int test__checkevent_config_cache(struct perf_evlist *evlist)
+static int test__checkevent_config_cache(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
@@ -1340,7 +1340,7 @@ static bool test__intel_pt_valid(void)
 	return !!perf_pmu__find("intel_pt");
 }
 
-static int test__intel_pt(struct perf_evlist *evlist)
+static int test__intel_pt(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
@@ -1348,7 +1348,7 @@ static int test__intel_pt(struct perf_evlist *evlist)
 	return 0;
 }
 
-static int test__checkevent_complex_name(struct perf_evlist *evlist)
+static int test__checkevent_complex_name(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
@@ -1356,7 +1356,7 @@ static int test__checkevent_complex_name(struct perf_evlist *evlist)
 	return 0;
 }
 
-static int test__sym_event_slash(struct perf_evlist *evlist)
+static int test__sym_event_slash(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
@@ -1366,7 +1366,7 @@ static int test__sym_event_slash(struct perf_evlist *evlist)
 	return 0;
 }
 
-static int test__sym_event_dc(struct perf_evlist *evlist)
+static int test__sym_event_dc(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__first(evlist);
 
@@ -1422,7 +1422,7 @@ static int count_tracepoints(void)
 	return cnt;
 }
 
-static int test__all_tracepoints(struct perf_evlist *evlist)
+static int test__all_tracepoints(struct evlist *evlist)
 {
 	TEST_ASSERT_VAL("wrong events count",
 			count_tracepoints() == evlist->nr_entries);
@@ -1435,7 +1435,7 @@ struct evlist_test {
 	__u32 type;
 	const int id;
 	bool (*valid)(void);
-	int (*check)(struct perf_evlist *evlist);
+	int (*check)(struct evlist *evlist);
 };
 
 static struct evlist_test test__events[] = {
@@ -1769,7 +1769,7 @@ static struct terms_test test__terms[] = {
 static int test_event(struct evlist_test *e)
 {
 	struct parse_events_error err = { .idx = 0, };
-	struct perf_evlist *evlist;
+	struct evlist *evlist;
 	int ret;
 
 	if (e->valid && !e->valid()) {
diff --git a/tools/perf/tests/parse-no-sample-id-all.c b/tools/perf/tests/parse-no-sample-id-all.c
index 2196d1497c0c..fc0213246aaf 100644
--- a/tools/perf/tests/parse-no-sample-id-all.c
+++ b/tools/perf/tests/parse-no-sample-id-all.c
@@ -11,7 +11,7 @@
 #include "util.h"
 #include "debug.h"
 
-static int process_event(struct perf_evlist **pevlist, union perf_event *event)
+static int process_event(struct evlist **pevlist, union perf_event *event)
 {
 	struct perf_sample sample;
 
@@ -39,7 +39,7 @@ static int process_event(struct perf_evlist **pevlist, union perf_event *event)
 
 static int process_events(union perf_event **events, size_t count)
 {
-	struct perf_evlist *evlist = NULL;
+	struct evlist *evlist = NULL;
 	int err = 0;
 	size_t i;
 
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index 7e576c2db941..99b2d26881f9 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -50,7 +50,7 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 	};
 	cpu_set_t cpu_mask;
 	size_t cpu_mask_size = sizeof(cpu_mask);
-	struct perf_evlist *evlist = perf_evlist__new_dummy();
+	struct evlist *evlist = perf_evlist__new_dummy();
 	struct evsel *evsel;
 	struct perf_sample sample;
 	const char *cmd = "sleep";
diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index 620a99aad1e3..69b997eeb639 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -28,7 +28,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 	char sbuf[STRERR_BUFSIZE];
 	union perf_event *event;
 	struct evsel *evsel;
-	struct perf_evlist *evlist;
+	struct evlist *evlist;
 	struct perf_event_attr attr = {
 		.type = PERF_TYPE_SOFTWARE,
 		.config = clock_id,
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index a946b9fa60dd..3e26ea36ec29 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -113,7 +113,7 @@ static int check_cpu(struct switch_tracking *switch_tracking, int cpu)
 	return 0;
 }
 
-static int process_sample_event(struct perf_evlist *evlist,
+static int process_sample_event(struct evlist *evlist,
 				union perf_event *event,
 				struct switch_tracking *switch_tracking)
 {
@@ -163,7 +163,7 @@ static int process_sample_event(struct perf_evlist *evlist,
 	return 0;
 }
 
-static int process_event(struct perf_evlist *evlist, union perf_event *event,
+static int process_event(struct evlist *evlist, union perf_event *event,
 			 struct switch_tracking *switch_tracking)
 {
 	if (event->header.type == PERF_RECORD_SAMPLE)
@@ -203,7 +203,7 @@ struct event_node {
 	u64 event_time;
 };
 
-static int add_event(struct perf_evlist *evlist, struct list_head *events,
+static int add_event(struct evlist *evlist, struct list_head *events,
 		     union perf_event *event)
 {
 	struct perf_sample sample;
@@ -252,7 +252,7 @@ static int compar(const void *a, const void *b)
 	return cmp;
 }
 
-static int process_events(struct perf_evlist *evlist,
+static int process_events(struct evlist *evlist,
 			  struct switch_tracking *switch_tracking)
 {
 	union perf_event *event;
@@ -329,7 +329,7 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 	};
 	struct perf_thread_map *threads = NULL;
 	struct perf_cpu_map *cpus = NULL;
-	struct perf_evlist *evlist = NULL;
+	struct evlist *evlist = NULL;
 	struct evsel *evsel, *cpu_clocks_evsel, *cycles_evsel;
 	struct evsel *switch_evsel, *tracking_evsel;
 	const char *comm;
diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index e6fb4b8d8bc2..5c2cdb0ccb96 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -38,7 +38,7 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 	int err = -1;
 	union perf_event *event;
 	struct evsel *evsel;
-	struct perf_evlist *evlist;
+	struct evlist *evlist;
 	struct target target = {
 		.uid		= UINT_MAX,
 		.uses_mmap	= true,
diff --git a/tools/perf/tests/time-utils-test.c b/tools/perf/tests/time-utils-test.c
index 4f53006233a1..fe57ca3b6e54 100644
--- a/tools/perf/tests/time-utils-test.c
+++ b/tools/perf/tests/time-utils-test.c
@@ -69,7 +69,7 @@ struct test_data {
 
 static bool test__perf_time__parse_for_ranges(struct test_data *d)
 {
-	struct perf_evlist evlist = {
+	struct evlist evlist = {
 		.first_sample_time = d->first,
 		.last_sample_time = d->last,
 	};
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 9bc818621eb6..b83258bece05 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3262,7 +3262,7 @@ static int perf_evsel_menu__run(struct evsel_menu *menu,
 				struct hist_browser_timer *hbt,
 				bool warn_lost_event)
 {
-	struct perf_evlist *evlist = menu->b.priv;
+	struct evlist *evlist = menu->b.priv;
 	struct evsel *pos;
 	const char *title = "Available samples";
 	int delay_secs = hbt ? hbt->refresh : 0;
@@ -3359,7 +3359,7 @@ static bool filter_group_entries(struct ui_browser *browser __maybe_unused,
 	return false;
 }
 
-static int __perf_evlist__tui_browse_hists(struct perf_evlist *evlist,
+static int __perf_evlist__tui_browse_hists(struct evlist *evlist,
 					   int nr_entries, const char *help,
 					   struct hist_browser_timer *hbt,
 					   float min_pcnt,
@@ -3397,7 +3397,7 @@ static int __perf_evlist__tui_browse_hists(struct perf_evlist *evlist,
 				    hbt, warn_lost_event);
 }
 
-int perf_evlist__tui_browse_hists(struct perf_evlist *evlist, const char *help,
+int perf_evlist__tui_browse_hists(struct evlist *evlist, const char *help,
 				  struct hist_browser_timer *hbt,
 				  float min_pcnt,
 				  struct perf_env *env,
diff --git a/tools/perf/ui/gtk/gtk.h b/tools/perf/ui/gtk/gtk.h
index e2f5fbef3c9a..a9563932fa04 100644
--- a/tools/perf/ui/gtk/gtk.h
+++ b/tools/perf/ui/gtk/gtk.h
@@ -53,11 +53,11 @@ static inline GtkWidget *perf_gtk__setup_info_bar(void)
 #endif
 
 struct evsel;
-struct perf_evlist;
+struct evlist;
 struct hist_entry;
 struct hist_browser_timer;
 
-int perf_evlist__gtk_browse_hists(struct perf_evlist *evlist, const char *help,
+int perf_evlist__gtk_browse_hists(struct evlist *evlist, const char *help,
 				  struct hist_browser_timer *hbt,
 				  float min_pcnt);
 int hist_entry__gtk_annotate(struct hist_entry *he,
diff --git a/tools/perf/ui/gtk/hists.c b/tools/perf/ui/gtk/hists.c
index d5c9fe230632..1b181d8ea953 100644
--- a/tools/perf/ui/gtk/hists.c
+++ b/tools/perf/ui/gtk/hists.c
@@ -590,7 +590,7 @@ static void perf_gtk__show_hierarchy(GtkWidget *window, struct hists *hists,
 	gtk_container_add(GTK_CONTAINER(window), view);
 }
 
-int perf_evlist__gtk_browse_hists(struct perf_evlist *evlist,
+int perf_evlist__gtk_browse_hists(struct evlist *evlist,
 				  const char *help,
 				  struct hist_browser_timer *hbt __maybe_unused,
 				  float min_pcnt)
diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index 214af526901b..8c7fb11edc60 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -795,7 +795,7 @@ static int add_hierarchy_fmt(struct hists *hists, struct perf_hpp_fmt *fmt)
 }
 
 int perf_hpp__setup_hists_formats(struct perf_hpp_list *list,
-				  struct perf_evlist *evlist)
+				  struct evlist *evlist)
 {
 	struct evsel *evsel;
 	struct perf_hpp_fmt *fmt;
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 98b151bc9a36..9ec2841ddec4 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -124,7 +124,7 @@ void auxtrace_mmap_params__init(struct auxtrace_mmap_params *mp,
 }
 
 void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
-				   struct perf_evlist *evlist, int idx,
+				   struct evlist *evlist, int idx,
 				   bool per_cpu)
 {
 	mp->idx = idx;
@@ -503,7 +503,7 @@ void auxtrace_heap__pop(struct auxtrace_heap *heap)
 }
 
 size_t auxtrace_record__info_priv_size(struct auxtrace_record *itr,
-				       struct perf_evlist *evlist)
+				       struct evlist *evlist)
 {
 	if (itr)
 		return itr->info_priv_size(itr, evlist);
@@ -556,7 +556,7 @@ int auxtrace_record__find_snapshot(struct auxtrace_record *itr, int idx,
 }
 
 int auxtrace_record__options(struct auxtrace_record *itr,
-			     struct perf_evlist *evlist,
+			     struct evlist *evlist,
 			     struct record_opts *opts)
 {
 	if (itr)
@@ -585,7 +585,7 @@ int auxtrace_parse_snapshot_options(struct auxtrace_record *itr,
 }
 
 struct auxtrace_record *__weak
-auxtrace_record__init(struct perf_evlist *evlist __maybe_unused, int *err)
+auxtrace_record__init(struct evlist *evlist __maybe_unused, int *err)
 {
 	*err = 0;
 	return NULL;
@@ -2160,7 +2160,7 @@ static int perf_evsel__nr_addr_filter(struct evsel *evsel)
 	return nr_addr_filters;
 }
 
-int auxtrace_parse_filters(struct perf_evlist *evlist)
+int auxtrace_parse_filters(struct evlist *evlist)
 {
 	struct evsel *evsel;
 	char *filter;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index e9b4c5edf78b..17eb04a1da4d 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -23,7 +23,7 @@
 
 union perf_event;
 struct perf_session;
-struct perf_evlist;
+struct evlist;
 struct perf_tool;
 struct perf_mmap;
 struct option;
@@ -309,10 +309,10 @@ struct auxtrace_mmap_params {
  */
 struct auxtrace_record {
 	int (*recording_options)(struct auxtrace_record *itr,
-				 struct perf_evlist *evlist,
+				 struct evlist *evlist,
 				 struct record_opts *opts);
 	size_t (*info_priv_size)(struct auxtrace_record *itr,
-				 struct perf_evlist *evlist);
+				 struct evlist *evlist);
 	int (*info_fill)(struct auxtrace_record *itr,
 			 struct perf_session *session,
 			 struct auxtrace_info_event *auxtrace_info,
@@ -432,7 +432,7 @@ void auxtrace_mmap_params__init(struct auxtrace_mmap_params *mp,
 				unsigned int auxtrace_pages,
 				bool auxtrace_overwrite);
 void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
-				   struct perf_evlist *evlist, int idx,
+				   struct evlist *evlist, int idx,
 				   bool per_cpu);
 
 typedef int (*process_auxtrace_t)(struct perf_tool *tool,
@@ -482,17 +482,17 @@ int auxtrace_cache__add(struct auxtrace_cache *c, u32 key,
 			struct auxtrace_cache_entry *entry);
 void *auxtrace_cache__lookup(struct auxtrace_cache *c, u32 key);
 
-struct auxtrace_record *auxtrace_record__init(struct perf_evlist *evlist,
+struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
 					      int *err);
 
 int auxtrace_parse_snapshot_options(struct auxtrace_record *itr,
 				    struct record_opts *opts,
 				    const char *str);
 int auxtrace_record__options(struct auxtrace_record *itr,
-			     struct perf_evlist *evlist,
+			     struct evlist *evlist,
 			     struct record_opts *opts);
 size_t auxtrace_record__info_priv_size(struct auxtrace_record *itr,
-				       struct perf_evlist *evlist);
+				       struct evlist *evlist);
 int auxtrace_record__info_fill(struct auxtrace_record *itr,
 			       struct perf_session *session,
 			       struct auxtrace_info_event *auxtrace_info,
@@ -540,7 +540,7 @@ void addr_filters__init(struct addr_filters *filts);
 void addr_filters__exit(struct addr_filters *filts);
 int addr_filters__parse_bare_filter(struct addr_filters *filts,
 				    const char *filter);
-int auxtrace_parse_filters(struct perf_evlist *evlist);
+int auxtrace_parse_filters(struct evlist *evlist);
 
 static inline int auxtrace__process_event(struct perf_session *session,
 					  union perf_event *event,
@@ -613,7 +613,7 @@ void itrace_synth_opts__clear_time_range(struct itrace_synth_opts *opts)
 #else
 
 static inline struct auxtrace_record *
-auxtrace_record__init(struct perf_evlist *evlist __maybe_unused,
+auxtrace_record__init(struct evlist *evlist __maybe_unused,
 		      int *err)
 {
 	*err = 0;
@@ -636,7 +636,7 @@ perf_event__synthesize_auxtrace_info(struct auxtrace_record *itr __maybe_unused,
 
 static inline
 int auxtrace_record__options(struct auxtrace_record *itr __maybe_unused,
-			     struct perf_evlist *evlist __maybe_unused,
+			     struct evlist *evlist __maybe_unused,
 			     struct record_opts *opts __maybe_unused)
 {
 	return 0;
@@ -733,7 +733,7 @@ void auxtrace_index__free(struct list_head *head __maybe_unused)
 }
 
 static inline
-int auxtrace_parse_filters(struct perf_evlist *evlist __maybe_unused)
+int auxtrace_parse_filters(struct evlist *evlist __maybe_unused)
 {
 	return 0;
 }
@@ -747,7 +747,7 @@ void auxtrace_mmap_params__init(struct auxtrace_mmap_params *mp,
 				unsigned int auxtrace_pages,
 				bool auxtrace_overwrite);
 void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
-				   struct perf_evlist *evlist, int idx,
+				   struct evlist *evlist, int idx,
 				   bool per_cpu);
 
 #define ITRACE_HELP ""
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 2a4a0da35632..5a5dcc6d8f85 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -418,7 +418,7 @@ static int bpf_event__sb_cb(union perf_event *event, void *data)
 	return 0;
 }
 
-int bpf_event__add_sb_event(struct perf_evlist **evlist,
+int bpf_event__add_sb_event(struct evlist **evlist,
 			    struct perf_env *env)
 {
 	struct perf_event_attr attr = {
diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
index 04c33b3bfe28..26ab9239f986 100644
--- a/tools/perf/util/bpf-event.h
+++ b/tools/perf/util/bpf-event.h
@@ -37,7 +37,7 @@ int perf_event__synthesize_bpf_events(struct perf_session *session,
 				      perf_event__handler_t process,
 				      struct machine *machine,
 				      struct record_opts *opts);
-int bpf_event__add_sb_event(struct perf_evlist **evlist,
+int bpf_event__add_sb_event(struct evlist **evlist,
 				 struct perf_env *env);
 void bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
 				    struct perf_env *env,
@@ -58,7 +58,7 @@ static inline int perf_event__synthesize_bpf_events(struct perf_session *session
 	return 0;
 }
 
-static inline int bpf_event__add_sb_event(struct perf_evlist **evlist __maybe_unused,
+static inline int bpf_event__add_sb_event(struct evlist **evlist __maybe_unused,
 					  struct perf_env *env __maybe_unused)
 {
 	return 0;
diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 594ea279e25b..b0696726ab76 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -1043,7 +1043,7 @@ __bpf_map__config_value(struct bpf_map *map,
 static int
 bpf_map__config_value(struct bpf_map *map,
 		      struct parse_events_term *term,
-		      struct perf_evlist *evlist __maybe_unused)
+		      struct evlist *evlist __maybe_unused)
 {
 	if (!term->err_val) {
 		pr_debug("Config value not set\n");
@@ -1061,7 +1061,7 @@ bpf_map__config_value(struct bpf_map *map,
 static int
 __bpf_map__config_event(struct bpf_map *map,
 			struct parse_events_term *term,
-			struct perf_evlist *evlist)
+			struct evlist *evlist)
 {
 	struct evsel *evsel;
 	const struct bpf_map_def *def;
@@ -1103,7 +1103,7 @@ __bpf_map__config_event(struct bpf_map *map,
 static int
 bpf_map__config_event(struct bpf_map *map,
 		      struct parse_events_term *term,
-		      struct perf_evlist *evlist)
+		      struct evlist *evlist)
 {
 	if (!term->err_val) {
 		pr_debug("Config value not set\n");
@@ -1121,7 +1121,7 @@ bpf_map__config_event(struct bpf_map *map,
 struct bpf_obj_config__map_func {
 	const char *config_opt;
 	int (*config_func)(struct bpf_map *, struct parse_events_term *,
-			   struct perf_evlist *);
+			   struct evlist *);
 };
 
 struct bpf_obj_config__map_func bpf_obj_config__map_funcs[] = {
@@ -1169,7 +1169,7 @@ config_map_indices_range_check(struct parse_events_term *term,
 static int
 bpf__obj_config_map(struct bpf_object *obj,
 		    struct parse_events_term *term,
-		    struct perf_evlist *evlist,
+		    struct evlist *evlist,
 		    int *key_scan_pos)
 {
 	/* key is "map:<mapname>.<config opt>" */
@@ -1228,7 +1228,7 @@ bpf__obj_config_map(struct bpf_object *obj,
 
 int bpf__config_obj(struct bpf_object *obj,
 		    struct parse_events_term *term,
-		    struct perf_evlist *evlist,
+		    struct evlist *evlist,
 		    int *error_pos)
 {
 	int key_scan_pos = 0;
@@ -1523,7 +1523,7 @@ int bpf__apply_obj_config(void)
 			(strcmp(name, 			\
 				bpf_map__name(pos)) == 0))
 
-struct evsel *bpf__setup_output_event(struct perf_evlist *evlist, const char *name)
+struct evsel *bpf__setup_output_event(struct evlist *evlist, const char *name)
 {
 	struct bpf_map_priv *tmpl_priv = NULL;
 	struct bpf_object *obj, *tmp;
@@ -1600,7 +1600,7 @@ struct evsel *bpf__setup_output_event(struct perf_evlist *evlist, const char *na
 	return evsel;
 }
 
-int bpf__setup_stdout(struct perf_evlist *evlist)
+int bpf__setup_stdout(struct evlist *evlist)
 {
 	struct evsel *evsel = bpf__setup_output_event(evlist, "__bpf_stdout__");
 	return PTR_ERR_OR_ZERO(evsel);
@@ -1756,7 +1756,7 @@ int bpf__strerror_load(struct bpf_object *obj,
 
 int bpf__strerror_config_obj(struct bpf_object *obj __maybe_unused,
 			     struct parse_events_term *term __maybe_unused,
-			     struct perf_evlist *evlist __maybe_unused,
+			     struct evlist *evlist __maybe_unused,
 			     int *error_pos __maybe_unused, int err,
 			     char *buf, size_t size)
 {
@@ -1780,7 +1780,7 @@ int bpf__strerror_apply_obj_config(int err, char *buf, size_t size)
 	return 0;
 }
 
-int bpf__strerror_setup_output_event(struct perf_evlist *evlist __maybe_unused,
+int bpf__strerror_setup_output_event(struct evlist *evlist __maybe_unused,
 				     int err, char *buf, size_t size)
 {
 	bpf__strerror_head(err, buf, size);
diff --git a/tools/perf/util/bpf-loader.h b/tools/perf/util/bpf-loader.h
index e2048c978a24..25251d63164c 100644
--- a/tools/perf/util/bpf-loader.h
+++ b/tools/perf/util/bpf-loader.h
@@ -40,7 +40,7 @@ enum bpf_loader_errno {
 };
 
 struct evsel;
-struct perf_evlist;
+struct evlist;
 struct bpf_object;
 struct parse_events_term;
 #define PERF_BPF_PROBE_GROUP "perf_bpf_probe"
@@ -70,18 +70,18 @@ int bpf__foreach_event(struct bpf_object *obj,
 		       bpf_prog_iter_callback_t func, void *arg);
 
 int bpf__config_obj(struct bpf_object *obj, struct parse_events_term *term,
-		    struct perf_evlist *evlist, int *error_pos);
+		    struct evlist *evlist, int *error_pos);
 int bpf__strerror_config_obj(struct bpf_object *obj,
 			     struct parse_events_term *term,
-			     struct perf_evlist *evlist,
+			     struct evlist *evlist,
 			     int *error_pos, int err, char *buf,
 			     size_t size);
 int bpf__apply_obj_config(void);
 int bpf__strerror_apply_obj_config(int err, char *buf, size_t size);
 
-int bpf__setup_stdout(struct perf_evlist *evlist);
-struct evsel *bpf__setup_output_event(struct perf_evlist *evlist, const char *name);
-int bpf__strerror_setup_output_event(struct perf_evlist *evlist, int err, char *buf, size_t size);
+int bpf__setup_stdout(struct evlist *evlist);
+struct evsel *bpf__setup_output_event(struct evlist *evlist, const char *name);
+int bpf__strerror_setup_output_event(struct evlist *evlist, int err, char *buf, size_t size);
 #else
 #include <errno.h>
 #include <string.h>
@@ -119,7 +119,7 @@ bpf__foreach_event(struct bpf_object *obj __maybe_unused,
 static inline int
 bpf__config_obj(struct bpf_object *obj __maybe_unused,
 		struct parse_events_term *term __maybe_unused,
-		struct perf_evlist *evlist __maybe_unused,
+		struct evlist *evlist __maybe_unused,
 		int *error_pos __maybe_unused)
 {
 	return 0;
@@ -132,13 +132,13 @@ bpf__apply_obj_config(void)
 }
 
 static inline int
-bpf__setup_stdout(struct perf_evlist *evlist __maybe_unused)
+bpf__setup_stdout(struct evlist *evlist __maybe_unused)
 {
 	return 0;
 }
 
 static inline struct evsel *
-bpf__setup_output_event(struct perf_evlist *evlist __maybe_unused, const char *name __maybe_unused)
+bpf__setup_output_event(struct evlist *evlist __maybe_unused, const char *name __maybe_unused)
 {
 	return NULL;
 }
@@ -182,7 +182,7 @@ static inline int bpf__strerror_load(struct bpf_object *obj __maybe_unused,
 static inline int
 bpf__strerror_config_obj(struct bpf_object *obj __maybe_unused,
 			 struct parse_events_term *term __maybe_unused,
-			 struct perf_evlist *evlist __maybe_unused,
+			 struct evlist *evlist __maybe_unused,
 			 int *error_pos __maybe_unused,
 			 int err __maybe_unused,
 			 char *buf, size_t size)
@@ -198,7 +198,7 @@ bpf__strerror_apply_obj_config(int err __maybe_unused,
 }
 
 static inline int
-bpf__strerror_setup_output_event(struct perf_evlist *evlist __maybe_unused,
+bpf__strerror_setup_output_event(struct evlist *evlist __maybe_unused,
 				 int err __maybe_unused, char *buf, size_t size)
 {
 	return __bpf_strerror(buf, size);
@@ -206,7 +206,7 @@ bpf__strerror_setup_output_event(struct perf_evlist *evlist __maybe_unused,
 
 #endif
 
-static inline int bpf__strerror_setup_stdout(struct perf_evlist *evlist, int err, char *buf, size_t size)
+static inline int bpf__strerror_setup_stdout(struct evlist *evlist, int err, char *buf, size_t size)
 {
 	return bpf__strerror_setup_output_event(evlist, err, buf, size);
 }
diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index 4f5c326a9477..deb87ecd3671 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -90,7 +90,7 @@ static int open_cgroup(const char *name)
 	return fd;
 }
 
-static struct cgroup *evlist__find_cgroup(struct perf_evlist *evlist, const char *str)
+static struct cgroup *evlist__find_cgroup(struct evlist *evlist, const char *str)
 {
 	struct evsel *counter;
 	/*
@@ -130,14 +130,14 @@ static struct cgroup *cgroup__new(const char *name)
 	return NULL;
 }
 
-struct cgroup *evlist__findnew_cgroup(struct perf_evlist *evlist, const char *name)
+struct cgroup *evlist__findnew_cgroup(struct evlist *evlist, const char *name)
 {
 	struct cgroup *cgroup = evlist__find_cgroup(evlist, name);
 
 	return cgroup ?: cgroup__new(name);
 }
 
-static int add_cgroup(struct perf_evlist *evlist, const char *str)
+static int add_cgroup(struct evlist *evlist, const char *str)
 {
 	struct evsel *counter;
 	struct cgroup *cgrp = evlist__findnew_cgroup(evlist, str);
@@ -190,7 +190,7 @@ static void evsel__set_default_cgroup(struct evsel *evsel, struct cgroup *cgroup
 		evsel->cgrp = cgroup__get(cgroup);
 }
 
-void evlist__set_default_cgroup(struct perf_evlist *evlist, struct cgroup *cgroup)
+void evlist__set_default_cgroup(struct evlist *evlist, struct cgroup *cgroup)
 {
 	struct evsel *evsel;
 
@@ -201,7 +201,7 @@ void evlist__set_default_cgroup(struct perf_evlist *evlist, struct cgroup *cgrou
 int parse_cgroups(const struct option *opt, const char *str,
 		  int unset __maybe_unused)
 {
-	struct perf_evlist *evlist = *(struct perf_evlist **)opt->value;
+	struct evlist *evlist = *(struct evlist **)opt->value;
 	struct evsel *counter;
 	struct cgroup *cgrp = NULL;
 	const char *p, *e, *eos = str + strlen(str);
diff --git a/tools/perf/util/cgroup.h b/tools/perf/util/cgroup.h
index f033a80c1b14..2ec11f01090d 100644
--- a/tools/perf/util/cgroup.h
+++ b/tools/perf/util/cgroup.h
@@ -18,11 +18,11 @@ extern int nr_cgroups; /* number of explicit cgroups defined */
 struct cgroup *cgroup__get(struct cgroup *cgroup);
 void cgroup__put(struct cgroup *cgroup);
 
-struct perf_evlist;
+struct evlist;
 
-struct cgroup *evlist__findnew_cgroup(struct perf_evlist *evlist, const char *name);
+struct cgroup *evlist__findnew_cgroup(struct evlist *evlist, const char *name);
 
-void evlist__set_default_cgroup(struct perf_evlist *evlist, struct cgroup *cgroup);
+void evlist__set_default_cgroup(struct evlist *evlist, struct cgroup *cgroup);
 
 int parse_cgroups(const struct option *opt, const char *str, int unset);
 
diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index 042ee5b6f9f1..083101ae7b77 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -1201,7 +1201,7 @@ static int add_event(struct ctf_writer *cw, struct evsel *evsel)
 
 static int setup_events(struct ctf_writer *cw, struct perf_session *session)
 {
-	struct perf_evlist *evlist = session->evlist;
+	struct evlist *evlist = session->evlist;
 	struct evsel *evsel;
 	int ret;
 
@@ -1308,7 +1308,7 @@ static int setup_non_sample_events(struct ctf_writer *cw,
 
 static void cleanup_events(struct perf_session *session)
 {
-	struct perf_evlist *evlist = session->evlist;
+	struct evlist *evlist = session->evlist;
 	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel) {
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 7e6066cb525b..c234fa4ba92a 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -41,7 +41,7 @@ int sigqueue(pid_t pid, int sig, const union sigval value);
 #define FD(e, x, y) (*(int *)xyarray__entry(e->fd, x, y))
 #define SID(e, x, y) xyarray__entry(e->sample_id, x, y)
 
-void perf_evlist__init(struct perf_evlist *evlist, struct perf_cpu_map *cpus,
+void perf_evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
 		       struct perf_thread_map *threads)
 {
 	int i;
@@ -55,9 +55,9 @@ void perf_evlist__init(struct perf_evlist *evlist, struct perf_cpu_map *cpus,
 	evlist->bkw_mmap_state = BKW_MMAP_NOTREADY;
 }
 
-struct perf_evlist *perf_evlist__new(void)
+struct evlist *perf_evlist__new(void)
 {
-	struct perf_evlist *evlist = zalloc(sizeof(*evlist));
+	struct evlist *evlist = zalloc(sizeof(*evlist));
 
 	if (evlist != NULL)
 		perf_evlist__init(evlist, NULL, NULL);
@@ -65,9 +65,9 @@ struct perf_evlist *perf_evlist__new(void)
 	return evlist;
 }
 
-struct perf_evlist *perf_evlist__new_default(void)
+struct evlist *perf_evlist__new_default(void)
 {
-	struct perf_evlist *evlist = perf_evlist__new();
+	struct evlist *evlist = perf_evlist__new();
 
 	if (evlist && perf_evlist__add_default(evlist)) {
 		perf_evlist__delete(evlist);
@@ -77,9 +77,9 @@ struct perf_evlist *perf_evlist__new_default(void)
 	return evlist;
 }
 
-struct perf_evlist *perf_evlist__new_dummy(void)
+struct evlist *perf_evlist__new_dummy(void)
 {
-	struct perf_evlist *evlist = perf_evlist__new();
+	struct evlist *evlist = perf_evlist__new();
 
 	if (evlist && perf_evlist__add_dummy(evlist)) {
 		perf_evlist__delete(evlist);
@@ -96,7 +96,7 @@ struct perf_evlist *perf_evlist__new_dummy(void)
  * Events with compatible sample types all have the same id_pos
  * and is_pos.  For convenience, put a copy on evlist.
  */
-void perf_evlist__set_id_pos(struct perf_evlist *evlist)
+void perf_evlist__set_id_pos(struct evlist *evlist)
 {
 	struct evsel *first = perf_evlist__first(evlist);
 
@@ -104,7 +104,7 @@ void perf_evlist__set_id_pos(struct perf_evlist *evlist)
 	evlist->is_pos = first->is_pos;
 }
 
-static void perf_evlist__update_id_pos(struct perf_evlist *evlist)
+static void perf_evlist__update_id_pos(struct evlist *evlist)
 {
 	struct evsel *evsel;
 
@@ -114,7 +114,7 @@ static void perf_evlist__update_id_pos(struct perf_evlist *evlist)
 	perf_evlist__set_id_pos(evlist);
 }
 
-static void perf_evlist__purge(struct perf_evlist *evlist)
+static void perf_evlist__purge(struct evlist *evlist)
 {
 	struct evsel *pos, *n;
 
@@ -127,14 +127,14 @@ static void perf_evlist__purge(struct perf_evlist *evlist)
 	evlist->nr_entries = 0;
 }
 
-void perf_evlist__exit(struct perf_evlist *evlist)
+void perf_evlist__exit(struct evlist *evlist)
 {
 	zfree(&evlist->mmap);
 	zfree(&evlist->overwrite_mmap);
 	fdarray__exit(&evlist->pollfd);
 }
 
-void perf_evlist__delete(struct perf_evlist *evlist)
+void perf_evlist__delete(struct evlist *evlist)
 {
 	if (evlist == NULL)
 		return;
@@ -150,7 +150,7 @@ void perf_evlist__delete(struct perf_evlist *evlist)
 	free(evlist);
 }
 
-static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
+static void __perf_evlist__propagate_maps(struct evlist *evlist,
 					  struct evsel *evsel)
 {
 	/*
@@ -169,7 +169,7 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
 	evsel->threads = thread_map__get(evlist->threads);
 }
 
-static void perf_evlist__propagate_maps(struct perf_evlist *evlist)
+static void perf_evlist__propagate_maps(struct evlist *evlist)
 {
 	struct evsel *evsel;
 
@@ -177,7 +177,7 @@ static void perf_evlist__propagate_maps(struct perf_evlist *evlist)
 		__perf_evlist__propagate_maps(evlist, evsel);
 }
 
-void perf_evlist__add(struct perf_evlist *evlist, struct evsel *entry)
+void perf_evlist__add(struct evlist *evlist, struct evsel *entry)
 {
 	entry->evlist = evlist;
 	list_add_tail(&entry->node, &evlist->entries);
@@ -190,14 +190,14 @@ void perf_evlist__add(struct perf_evlist *evlist, struct evsel *entry)
 	__perf_evlist__propagate_maps(evlist, entry);
 }
 
-void perf_evlist__remove(struct perf_evlist *evlist, struct evsel *evsel)
+void perf_evlist__remove(struct evlist *evlist, struct evsel *evsel)
 {
 	evsel->evlist = NULL;
 	list_del_init(&evsel->node);
 	evlist->nr_entries -= 1;
 }
 
-void perf_evlist__splice_list_tail(struct perf_evlist *evlist,
+void perf_evlist__splice_list_tail(struct evlist *evlist,
 				   struct list_head *list)
 {
 	struct evsel *evsel, *temp;
@@ -222,7 +222,7 @@ void __perf_evlist__set_leader(struct list_head *list)
 	}
 }
 
-void perf_evlist__set_leader(struct perf_evlist *evlist)
+void perf_evlist__set_leader(struct evlist *evlist)
 {
 	if (evlist->nr_entries) {
 		evlist->nr_groups = evlist->nr_entries > 1 ? 1 : 0;
@@ -230,7 +230,7 @@ void perf_evlist__set_leader(struct perf_evlist *evlist)
 	}
 }
 
-int __perf_evlist__add_default(struct perf_evlist *evlist, bool precise)
+int __perf_evlist__add_default(struct evlist *evlist, bool precise)
 {
 	struct evsel *evsel = perf_evsel__new_cycles(precise);
 
@@ -241,7 +241,7 @@ int __perf_evlist__add_default(struct perf_evlist *evlist, bool precise)
 	return 0;
 }
 
-int perf_evlist__add_dummy(struct perf_evlist *evlist)
+int perf_evlist__add_dummy(struct evlist *evlist)
 {
 	struct perf_event_attr attr = {
 		.type	= PERF_TYPE_SOFTWARE,
@@ -257,7 +257,7 @@ int perf_evlist__add_dummy(struct perf_evlist *evlist)
 	return 0;
 }
 
-static int perf_evlist__add_attrs(struct perf_evlist *evlist,
+static int perf_evlist__add_attrs(struct evlist *evlist,
 				  struct perf_event_attr *attrs, size_t nr_attrs)
 {
 	struct evsel *evsel, *n;
@@ -281,7 +281,7 @@ static int perf_evlist__add_attrs(struct perf_evlist *evlist,
 	return -1;
 }
 
-int __perf_evlist__add_default_attrs(struct perf_evlist *evlist,
+int __perf_evlist__add_default_attrs(struct evlist *evlist,
 				     struct perf_event_attr *attrs, size_t nr_attrs)
 {
 	size_t i;
@@ -293,7 +293,7 @@ int __perf_evlist__add_default_attrs(struct perf_evlist *evlist,
 }
 
 struct evsel *
-perf_evlist__find_tracepoint_by_id(struct perf_evlist *evlist, int id)
+perf_evlist__find_tracepoint_by_id(struct evlist *evlist, int id)
 {
 	struct evsel *evsel;
 
@@ -307,7 +307,7 @@ perf_evlist__find_tracepoint_by_id(struct perf_evlist *evlist, int id)
 }
 
 struct evsel *
-perf_evlist__find_tracepoint_by_name(struct perf_evlist *evlist,
+perf_evlist__find_tracepoint_by_name(struct evlist *evlist,
 				     const char *name)
 {
 	struct evsel *evsel;
@@ -321,7 +321,7 @@ perf_evlist__find_tracepoint_by_name(struct perf_evlist *evlist,
 	return NULL;
 }
 
-int perf_evlist__add_newtp(struct perf_evlist *evlist,
+int perf_evlist__add_newtp(struct evlist *evlist,
 			   const char *sys, const char *name, void *handler)
 {
 	struct evsel *evsel = perf_evsel__newtp(sys, name);
@@ -334,7 +334,7 @@ int perf_evlist__add_newtp(struct perf_evlist *evlist,
 	return 0;
 }
 
-static int perf_evlist__nr_threads(struct perf_evlist *evlist,
+static int perf_evlist__nr_threads(struct evlist *evlist,
 				   struct evsel *evsel)
 {
 	if (evsel->system_wide)
@@ -343,7 +343,7 @@ static int perf_evlist__nr_threads(struct perf_evlist *evlist,
 		return thread_map__nr(evlist->threads);
 }
 
-void perf_evlist__disable(struct perf_evlist *evlist)
+void perf_evlist__disable(struct evlist *evlist)
 {
 	struct evsel *pos;
 
@@ -356,7 +356,7 @@ void perf_evlist__disable(struct perf_evlist *evlist)
 	evlist->enabled = false;
 }
 
-void perf_evlist__enable(struct perf_evlist *evlist)
+void perf_evlist__enable(struct evlist *evlist)
 {
 	struct evsel *pos;
 
@@ -369,12 +369,12 @@ void perf_evlist__enable(struct perf_evlist *evlist)
 	evlist->enabled = true;
 }
 
-void perf_evlist__toggle_enable(struct perf_evlist *evlist)
+void perf_evlist__toggle_enable(struct evlist *evlist)
 {
 	(evlist->enabled ? perf_evlist__disable : perf_evlist__enable)(evlist);
 }
 
-static int perf_evlist__enable_event_cpu(struct perf_evlist *evlist,
+static int perf_evlist__enable_event_cpu(struct evlist *evlist,
 					 struct evsel *evsel, int cpu)
 {
 	int thread;
@@ -391,7 +391,7 @@ static int perf_evlist__enable_event_cpu(struct perf_evlist *evlist,
 	return 0;
 }
 
-static int perf_evlist__enable_event_thread(struct perf_evlist *evlist,
+static int perf_evlist__enable_event_thread(struct evlist *evlist,
 					    struct evsel *evsel,
 					    int thread)
 {
@@ -409,7 +409,7 @@ static int perf_evlist__enable_event_thread(struct perf_evlist *evlist,
 	return 0;
 }
 
-int perf_evlist__enable_event_idx(struct perf_evlist *evlist,
+int perf_evlist__enable_event_idx(struct evlist *evlist,
 				  struct evsel *evsel, int idx)
 {
 	bool per_cpu_mmaps = !cpu_map__empty(evlist->cpus);
@@ -420,7 +420,7 @@ int perf_evlist__enable_event_idx(struct perf_evlist *evlist,
 		return perf_evlist__enable_event_thread(evlist, evsel, idx);
 }
 
-int perf_evlist__alloc_pollfd(struct perf_evlist *evlist)
+int perf_evlist__alloc_pollfd(struct evlist *evlist)
 {
 	int nr_cpus = cpu_map__nr(evlist->cpus);
 	int nr_threads = thread_map__nr(evlist->threads);
@@ -441,7 +441,7 @@ int perf_evlist__alloc_pollfd(struct perf_evlist *evlist)
 	return 0;
 }
 
-static int __perf_evlist__add_pollfd(struct perf_evlist *evlist, int fd,
+static int __perf_evlist__add_pollfd(struct evlist *evlist, int fd,
 				     struct perf_mmap *map, short revent)
 {
 	int pos = fdarray__add(&evlist->pollfd, fd, revent | POLLERR | POLLHUP);
@@ -458,7 +458,7 @@ static int __perf_evlist__add_pollfd(struct perf_evlist *evlist, int fd,
 	return pos;
 }
 
-int perf_evlist__add_pollfd(struct perf_evlist *evlist, int fd)
+int perf_evlist__add_pollfd(struct evlist *evlist, int fd)
 {
 	return __perf_evlist__add_pollfd(evlist, fd, NULL, POLLIN);
 }
@@ -472,18 +472,18 @@ static void perf_evlist__munmap_filtered(struct fdarray *fda, int fd,
 		perf_mmap__put(map);
 }
 
-int perf_evlist__filter_pollfd(struct perf_evlist *evlist, short revents_and_mask)
+int perf_evlist__filter_pollfd(struct evlist *evlist, short revents_and_mask)
 {
 	return fdarray__filter(&evlist->pollfd, revents_and_mask,
 			       perf_evlist__munmap_filtered, NULL);
 }
 
-int perf_evlist__poll(struct perf_evlist *evlist, int timeout)
+int perf_evlist__poll(struct evlist *evlist, int timeout)
 {
 	return fdarray__poll(&evlist->pollfd, timeout);
 }
 
-static void perf_evlist__id_hash(struct perf_evlist *evlist,
+static void perf_evlist__id_hash(struct evlist *evlist,
 				 struct evsel *evsel,
 				 int cpu, int thread, u64 id)
 {
@@ -496,14 +496,14 @@ static void perf_evlist__id_hash(struct perf_evlist *evlist,
 	hlist_add_head(&sid->node, &evlist->heads[hash]);
 }
 
-void perf_evlist__id_add(struct perf_evlist *evlist, struct evsel *evsel,
+void perf_evlist__id_add(struct evlist *evlist, struct evsel *evsel,
 			 int cpu, int thread, u64 id)
 {
 	perf_evlist__id_hash(evlist, evsel, cpu, thread, id);
 	evsel->id[evsel->ids++] = id;
 }
 
-int perf_evlist__id_add_fd(struct perf_evlist *evlist,
+int perf_evlist__id_add_fd(struct evlist *evlist,
 			   struct evsel *evsel,
 			   int cpu, int thread, int fd)
 {
@@ -544,7 +544,7 @@ int perf_evlist__id_add_fd(struct perf_evlist *evlist,
 	return 0;
 }
 
-static void perf_evlist__set_sid_idx(struct perf_evlist *evlist,
+static void perf_evlist__set_sid_idx(struct evlist *evlist,
 				     struct evsel *evsel, int idx, int cpu,
 				     int thread)
 {
@@ -560,7 +560,7 @@ static void perf_evlist__set_sid_idx(struct perf_evlist *evlist,
 		sid->tid = -1;
 }
 
-struct perf_sample_id *perf_evlist__id2sid(struct perf_evlist *evlist, u64 id)
+struct perf_sample_id *perf_evlist__id2sid(struct evlist *evlist, u64 id)
 {
 	struct hlist_head *head;
 	struct perf_sample_id *sid;
@@ -576,7 +576,7 @@ struct perf_sample_id *perf_evlist__id2sid(struct perf_evlist *evlist, u64 id)
 	return NULL;
 }
 
-struct evsel *perf_evlist__id2evsel(struct perf_evlist *evlist, u64 id)
+struct evsel *perf_evlist__id2evsel(struct evlist *evlist, u64 id)
 {
 	struct perf_sample_id *sid;
 
@@ -593,7 +593,7 @@ struct evsel *perf_evlist__id2evsel(struct perf_evlist *evlist, u64 id)
 	return NULL;
 }
 
-struct evsel *perf_evlist__id2evsel_strict(struct perf_evlist *evlist,
+struct evsel *perf_evlist__id2evsel_strict(struct evlist *evlist,
 						u64 id)
 {
 	struct perf_sample_id *sid;
@@ -608,7 +608,7 @@ struct evsel *perf_evlist__id2evsel_strict(struct perf_evlist *evlist,
 	return NULL;
 }
 
-static int perf_evlist__event2id(struct perf_evlist *evlist,
+static int perf_evlist__event2id(struct evlist *evlist,
 				 union perf_event *event, u64 *id)
 {
 	const u64 *array = event->sample.array;
@@ -629,7 +629,7 @@ static int perf_evlist__event2id(struct perf_evlist *evlist,
 	return 0;
 }
 
-struct evsel *perf_evlist__event2evsel(struct perf_evlist *evlist,
+struct evsel *perf_evlist__event2evsel(struct evlist *evlist,
 					    union perf_event *event)
 {
 	struct evsel *first = perf_evlist__first(evlist);
@@ -662,7 +662,7 @@ struct evsel *perf_evlist__event2evsel(struct perf_evlist *evlist,
 	return NULL;
 }
 
-static int perf_evlist__set_paused(struct perf_evlist *evlist, bool value)
+static int perf_evlist__set_paused(struct evlist *evlist, bool value)
 {
 	int i;
 
@@ -682,17 +682,17 @@ static int perf_evlist__set_paused(struct perf_evlist *evlist, bool value)
 	return 0;
 }
 
-static int perf_evlist__pause(struct perf_evlist *evlist)
+static int perf_evlist__pause(struct evlist *evlist)
 {
 	return perf_evlist__set_paused(evlist, true);
 }
 
-static int perf_evlist__resume(struct perf_evlist *evlist)
+static int perf_evlist__resume(struct evlist *evlist)
 {
 	return perf_evlist__set_paused(evlist, false);
 }
 
-static void perf_evlist__munmap_nofree(struct perf_evlist *evlist)
+static void perf_evlist__munmap_nofree(struct evlist *evlist)
 {
 	int i;
 
@@ -705,14 +705,14 @@ static void perf_evlist__munmap_nofree(struct perf_evlist *evlist)
 			perf_mmap__munmap(&evlist->overwrite_mmap[i]);
 }
 
-void perf_evlist__munmap(struct perf_evlist *evlist)
+void perf_evlist__munmap(struct evlist *evlist)
 {
 	perf_evlist__munmap_nofree(evlist);
 	zfree(&evlist->mmap);
 	zfree(&evlist->overwrite_mmap);
 }
 
-static struct perf_mmap *perf_evlist__alloc_mmap(struct perf_evlist *evlist,
+static struct perf_mmap *perf_evlist__alloc_mmap(struct evlist *evlist,
 						 bool overwrite)
 {
 	int i;
@@ -743,7 +743,7 @@ static struct perf_mmap *perf_evlist__alloc_mmap(struct perf_evlist *evlist,
 }
 
 static bool
-perf_evlist__should_poll(struct perf_evlist *evlist __maybe_unused,
+perf_evlist__should_poll(struct evlist *evlist __maybe_unused,
 			 struct evsel *evsel)
 {
 	if (evsel->attr.write_backward)
@@ -751,7 +751,7 @@ perf_evlist__should_poll(struct perf_evlist *evlist __maybe_unused,
 	return true;
 }
 
-static int perf_evlist__mmap_per_evsel(struct perf_evlist *evlist, int idx,
+static int perf_evlist__mmap_per_evsel(struct evlist *evlist, int idx,
 				       struct mmap_params *mp, int cpu_idx,
 				       int thread, int *_output, int *_output_overwrite)
 {
@@ -829,7 +829,7 @@ static int perf_evlist__mmap_per_evsel(struct perf_evlist *evlist, int idx,
 	return 0;
 }
 
-static int perf_evlist__mmap_per_cpu(struct perf_evlist *evlist,
+static int perf_evlist__mmap_per_cpu(struct evlist *evlist,
 				     struct mmap_params *mp)
 {
 	int cpu, thread;
@@ -858,7 +858,7 @@ static int perf_evlist__mmap_per_cpu(struct perf_evlist *evlist,
 	return -1;
 }
 
-static int perf_evlist__mmap_per_thread(struct perf_evlist *evlist,
+static int perf_evlist__mmap_per_thread(struct evlist *evlist,
 					struct mmap_params *mp)
 {
 	int thread;
@@ -1006,7 +1006,7 @@ int perf_evlist__parse_mmap_pages(const struct option *opt, const char *str,
  *
  * Return: %0 on success, negative error code otherwise.
  */
-int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
+int perf_evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 			 unsigned int auxtrace_pages,
 			 bool auxtrace_overwrite, int nr_cblocks, int affinity, int flush,
 			 int comp_level)
@@ -1050,12 +1050,12 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 	return perf_evlist__mmap_per_cpu(evlist, &mp);
 }
 
-int perf_evlist__mmap(struct perf_evlist *evlist, unsigned int pages)
+int perf_evlist__mmap(struct evlist *evlist, unsigned int pages)
 {
 	return perf_evlist__mmap_ex(evlist, pages, 0, false, 0, PERF_AFFINITY_SYS, 1, 0);
 }
 
-int perf_evlist__create_maps(struct perf_evlist *evlist, struct target *target)
+int perf_evlist__create_maps(struct evlist *evlist, struct target *target)
 {
 	bool all_threads = (target->per_thread && target->system_wide);
 	struct perf_cpu_map *cpus;
@@ -1104,7 +1104,7 @@ int perf_evlist__create_maps(struct perf_evlist *evlist, struct target *target)
 	return -1;
 }
 
-void perf_evlist__set_maps(struct perf_evlist *evlist, struct perf_cpu_map *cpus,
+void perf_evlist__set_maps(struct evlist *evlist, struct perf_cpu_map *cpus,
 			   struct perf_thread_map *threads)
 {
 	/*
@@ -1127,7 +1127,7 @@ void perf_evlist__set_maps(struct perf_evlist *evlist, struct perf_cpu_map *cpus
 	perf_evlist__propagate_maps(evlist);
 }
 
-void __perf_evlist__set_sample_bit(struct perf_evlist *evlist,
+void __perf_evlist__set_sample_bit(struct evlist *evlist,
 				   enum perf_event_sample_format bit)
 {
 	struct evsel *evsel;
@@ -1136,7 +1136,7 @@ void __perf_evlist__set_sample_bit(struct perf_evlist *evlist,
 		__perf_evsel__set_sample_bit(evsel, bit);
 }
 
-void __perf_evlist__reset_sample_bit(struct perf_evlist *evlist,
+void __perf_evlist__reset_sample_bit(struct evlist *evlist,
 				     enum perf_event_sample_format bit)
 {
 	struct evsel *evsel;
@@ -1145,7 +1145,7 @@ void __perf_evlist__reset_sample_bit(struct perf_evlist *evlist,
 		__perf_evsel__reset_sample_bit(evsel, bit);
 }
 
-int perf_evlist__apply_filters(struct perf_evlist *evlist, struct evsel **err_evsel)
+int perf_evlist__apply_filters(struct evlist *evlist, struct evsel **err_evsel)
 {
 	struct evsel *evsel;
 	int err = 0;
@@ -1168,7 +1168,7 @@ int perf_evlist__apply_filters(struct perf_evlist *evlist, struct evsel **err_ev
 	return err;
 }
 
-int perf_evlist__set_tp_filter(struct perf_evlist *evlist, const char *filter)
+int perf_evlist__set_tp_filter(struct evlist *evlist, const char *filter)
 {
 	struct evsel *evsel;
 	int err = 0;
@@ -1185,7 +1185,7 @@ int perf_evlist__set_tp_filter(struct perf_evlist *evlist, const char *filter)
 	return err;
 }
 
-int perf_evlist__set_tp_filter_pids(struct perf_evlist *evlist, size_t npids, pid_t *pids)
+int perf_evlist__set_tp_filter_pids(struct evlist *evlist, size_t npids, pid_t *pids)
 {
 	char *filter;
 	int ret = -1;
@@ -1212,12 +1212,12 @@ int perf_evlist__set_tp_filter_pids(struct perf_evlist *evlist, size_t npids, pi
 	return ret;
 }
 
-int perf_evlist__set_tp_filter_pid(struct perf_evlist *evlist, pid_t pid)
+int perf_evlist__set_tp_filter_pid(struct evlist *evlist, pid_t pid)
 {
 	return perf_evlist__set_tp_filter_pids(evlist, 1, &pid);
 }
 
-bool perf_evlist__valid_sample_type(struct perf_evlist *evlist)
+bool perf_evlist__valid_sample_type(struct evlist *evlist)
 {
 	struct evsel *pos;
 
@@ -1236,7 +1236,7 @@ bool perf_evlist__valid_sample_type(struct perf_evlist *evlist)
 	return true;
 }
 
-u64 __perf_evlist__combined_sample_type(struct perf_evlist *evlist)
+u64 __perf_evlist__combined_sample_type(struct evlist *evlist)
 {
 	struct evsel *evsel;
 
@@ -1249,13 +1249,13 @@ u64 __perf_evlist__combined_sample_type(struct perf_evlist *evlist)
 	return evlist->combined_sample_type;
 }
 
-u64 perf_evlist__combined_sample_type(struct perf_evlist *evlist)
+u64 perf_evlist__combined_sample_type(struct evlist *evlist)
 {
 	evlist->combined_sample_type = 0;
 	return __perf_evlist__combined_sample_type(evlist);
 }
 
-u64 perf_evlist__combined_branch_type(struct perf_evlist *evlist)
+u64 perf_evlist__combined_branch_type(struct evlist *evlist)
 {
 	struct evsel *evsel;
 	u64 branch_type = 0;
@@ -1265,7 +1265,7 @@ u64 perf_evlist__combined_branch_type(struct perf_evlist *evlist)
 	return branch_type;
 }
 
-bool perf_evlist__valid_read_format(struct perf_evlist *evlist)
+bool perf_evlist__valid_read_format(struct evlist *evlist)
 {
 	struct evsel *first = perf_evlist__first(evlist), *pos = first;
 	u64 read_format = first->attr.read_format;
@@ -1285,13 +1285,13 @@ bool perf_evlist__valid_read_format(struct perf_evlist *evlist)
 	return true;
 }
 
-u64 perf_evlist__read_format(struct perf_evlist *evlist)
+u64 perf_evlist__read_format(struct evlist *evlist)
 {
 	struct evsel *first = perf_evlist__first(evlist);
 	return first->attr.read_format;
 }
 
-u16 perf_evlist__id_hdr_size(struct perf_evlist *evlist)
+u16 perf_evlist__id_hdr_size(struct evlist *evlist)
 {
 	struct evsel *first = perf_evlist__first(evlist);
 	struct perf_sample *data;
@@ -1324,7 +1324,7 @@ u16 perf_evlist__id_hdr_size(struct perf_evlist *evlist)
 	return size;
 }
 
-bool perf_evlist__valid_sample_id_all(struct perf_evlist *evlist)
+bool perf_evlist__valid_sample_id_all(struct evlist *evlist)
 {
 	struct evsel *first = perf_evlist__first(evlist), *pos = first;
 
@@ -1336,19 +1336,19 @@ bool perf_evlist__valid_sample_id_all(struct perf_evlist *evlist)
 	return true;
 }
 
-bool perf_evlist__sample_id_all(struct perf_evlist *evlist)
+bool perf_evlist__sample_id_all(struct evlist *evlist)
 {
 	struct evsel *first = perf_evlist__first(evlist);
 	return first->attr.sample_id_all;
 }
 
-void perf_evlist__set_selected(struct perf_evlist *evlist,
+void perf_evlist__set_selected(struct evlist *evlist,
 			       struct evsel *evsel)
 {
 	evlist->selected = evsel;
 }
 
-void perf_evlist__close(struct perf_evlist *evlist)
+void perf_evlist__close(struct evlist *evlist)
 {
 	struct evsel *evsel;
 
@@ -1356,7 +1356,7 @@ void perf_evlist__close(struct perf_evlist *evlist)
 		perf_evsel__close(evsel);
 }
 
-static int perf_evlist__create_syswide_maps(struct perf_evlist *evlist)
+static int perf_evlist__create_syswide_maps(struct evlist *evlist)
 {
 	struct perf_cpu_map *cpus;
 	struct perf_thread_map *threads;
@@ -1387,7 +1387,7 @@ static int perf_evlist__create_syswide_maps(struct perf_evlist *evlist)
 	goto out;
 }
 
-int perf_evlist__open(struct perf_evlist *evlist)
+int perf_evlist__open(struct evlist *evlist)
 {
 	struct evsel *evsel;
 	int err;
@@ -1417,7 +1417,7 @@ int perf_evlist__open(struct perf_evlist *evlist)
 	return err;
 }
 
-int perf_evlist__prepare_workload(struct perf_evlist *evlist, struct target *target,
+int perf_evlist__prepare_workload(struct evlist *evlist, struct target *target,
 				  const char *argv[], bool pipe_output,
 				  void (*exec_error)(int signo, siginfo_t *info, void *ucontext))
 {
@@ -1531,7 +1531,7 @@ int perf_evlist__prepare_workload(struct perf_evlist *evlist, struct target *tar
 	return -1;
 }
 
-int perf_evlist__start_workload(struct perf_evlist *evlist)
+int perf_evlist__start_workload(struct evlist *evlist)
 {
 	if (evlist->workload.cork_fd > 0) {
 		char bf = 0;
@@ -1550,7 +1550,7 @@ int perf_evlist__start_workload(struct perf_evlist *evlist)
 	return 0;
 }
 
-int perf_evlist__parse_sample(struct perf_evlist *evlist, union perf_event *event,
+int perf_evlist__parse_sample(struct evlist *evlist, union perf_event *event,
 			      struct perf_sample *sample)
 {
 	struct evsel *evsel = perf_evlist__event2evsel(evlist, event);
@@ -1560,7 +1560,7 @@ int perf_evlist__parse_sample(struct perf_evlist *evlist, union perf_event *even
 	return perf_evsel__parse_sample(evsel, event, sample);
 }
 
-int perf_evlist__parse_sample_timestamp(struct perf_evlist *evlist,
+int perf_evlist__parse_sample_timestamp(struct evlist *evlist,
 					union perf_event *event,
 					u64 *timestamp)
 {
@@ -1571,7 +1571,7 @@ int perf_evlist__parse_sample_timestamp(struct perf_evlist *evlist,
 	return perf_evsel__parse_sample_timestamp(evsel, event, timestamp);
 }
 
-size_t perf_evlist__fprintf(struct perf_evlist *evlist, FILE *fp)
+size_t perf_evlist__fprintf(struct evlist *evlist, FILE *fp)
 {
 	struct evsel *evsel;
 	size_t printed = 0;
@@ -1584,7 +1584,7 @@ size_t perf_evlist__fprintf(struct perf_evlist *evlist, FILE *fp)
 	return printed + fprintf(fp, "\n");
 }
 
-int perf_evlist__strerror_open(struct perf_evlist *evlist,
+int perf_evlist__strerror_open(struct evlist *evlist,
 			       int err, char *buf, size_t size)
 {
 	int printed, value;
@@ -1638,7 +1638,7 @@ int perf_evlist__strerror_open(struct perf_evlist *evlist,
 	return 0;
 }
 
-int perf_evlist__strerror_mmap(struct perf_evlist *evlist, int err, char *buf, size_t size)
+int perf_evlist__strerror_mmap(struct evlist *evlist, int err, char *buf, size_t size)
 {
 	char sbuf[STRERR_BUFSIZE], *emsg = str_error_r(err, sbuf, sizeof(sbuf));
 	int pages_attempted = evlist->mmap_len / 1024, pages_max_per_user, printed = 0;
@@ -1669,7 +1669,7 @@ int perf_evlist__strerror_mmap(struct perf_evlist *evlist, int err, char *buf, s
 	return 0;
 }
 
-void perf_evlist__to_front(struct perf_evlist *evlist,
+void perf_evlist__to_front(struct evlist *evlist,
 			   struct evsel *move_evsel)
 {
 	struct evsel *evsel, *n;
@@ -1686,7 +1686,7 @@ void perf_evlist__to_front(struct perf_evlist *evlist,
 	list_splice(&move, &evlist->entries);
 }
 
-void perf_evlist__set_tracking_event(struct perf_evlist *evlist,
+void perf_evlist__set_tracking_event(struct evlist *evlist,
 				     struct evsel *tracking_evsel)
 {
 	struct evsel *evsel;
@@ -1703,7 +1703,7 @@ void perf_evlist__set_tracking_event(struct perf_evlist *evlist,
 }
 
 struct evsel *
-perf_evlist__find_evsel_by_str(struct perf_evlist *evlist,
+perf_evlist__find_evsel_by_str(struct evlist *evlist,
 			       const char *str)
 {
 	struct evsel *evsel;
@@ -1718,7 +1718,7 @@ perf_evlist__find_evsel_by_str(struct perf_evlist *evlist,
 	return NULL;
 }
 
-void perf_evlist__toggle_bkw_mmap(struct perf_evlist *evlist,
+void perf_evlist__toggle_bkw_mmap(struct evlist *evlist,
 				  enum bkw_mmap_state state)
 {
 	enum bkw_mmap_state old_state = evlist->bkw_mmap_state;
@@ -1776,7 +1776,7 @@ void perf_evlist__toggle_bkw_mmap(struct perf_evlist *evlist,
 	return;
 }
 
-bool perf_evlist__exclude_kernel(struct perf_evlist *evlist)
+bool perf_evlist__exclude_kernel(struct evlist *evlist)
 {
 	struct evsel *evsel;
 
@@ -1793,7 +1793,7 @@ bool perf_evlist__exclude_kernel(struct perf_evlist *evlist)
  * the group display. Set the artificial group and set the leader's
  * forced_leader flag to notify the display code.
  */
-void perf_evlist__force_leader(struct perf_evlist *evlist)
+void perf_evlist__force_leader(struct evlist *evlist)
 {
 	if (!evlist->nr_groups) {
 		struct evsel *leader = perf_evlist__first(evlist);
@@ -1803,7 +1803,7 @@ void perf_evlist__force_leader(struct perf_evlist *evlist)
 	}
 }
 
-struct evsel *perf_evlist__reset_weak_group(struct perf_evlist *evsel_list,
+struct evsel *perf_evlist__reset_weak_group(struct evlist *evsel_list,
 						 struct evsel *evsel)
 {
 	struct evsel *c2, *leader;
@@ -1830,7 +1830,7 @@ struct evsel *perf_evlist__reset_weak_group(struct perf_evlist *evsel_list,
 	return leader;
 }
 
-int perf_evlist__add_sb_event(struct perf_evlist **evlist,
+int perf_evlist__add_sb_event(struct evlist **evlist,
 			      struct perf_event_attr *attr,
 			      perf_evsel__sb_cb_t cb,
 			      void *data)
@@ -1867,7 +1867,7 @@ int perf_evlist__add_sb_event(struct perf_evlist **evlist,
 
 static void *perf_evlist__poll_thread(void *arg)
 {
-	struct perf_evlist *evlist = arg;
+	struct evlist *evlist = arg;
 	bool draining = false;
 	int i, done = 0;
 
@@ -1906,7 +1906,7 @@ static void *perf_evlist__poll_thread(void *arg)
 	return NULL;
 }
 
-int perf_evlist__start_sb_thread(struct perf_evlist *evlist,
+int perf_evlist__start_sb_thread(struct evlist *evlist,
 				 struct target *target)
 {
 	struct evsel *counter;
@@ -1943,7 +1943,7 @@ int perf_evlist__start_sb_thread(struct perf_evlist *evlist,
 	return -1;
 }
 
-void perf_evlist__stop_sb_thread(struct perf_evlist *evlist)
+void perf_evlist__stop_sb_thread(struct evlist *evlist)
 {
 	if (!evlist)
 		return;
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 576d59a0d8cf..54f1c3e2b721 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -24,7 +24,7 @@ struct record_opts;
 #define PERF_EVLIST__HLIST_BITS 8
 #define PERF_EVLIST__HLIST_SIZE (1 << PERF_EVLIST__HLIST_BITS)
 
-struct perf_evlist {
+struct evlist {
 	struct list_head entries;
 	struct hlist_head heads[PERF_EVLIST__HLIST_SIZE];
 	int		 nr_entries;
@@ -49,7 +49,7 @@ struct perf_evlist {
 	struct evsel *selected;
 	struct events_stats stats;
 	struct perf_env	*env;
-	void (*trace_event_sample_raw)(struct perf_evlist *evlist,
+	void (*trace_event_sample_raw)(struct evlist *evlist,
 				       union perf_event *event,
 				       struct perf_sample *sample);
 	u64		first_sample_time;
@@ -65,46 +65,46 @@ struct evsel_str_handler {
 	void	   *handler;
 };
 
-struct perf_evlist *perf_evlist__new(void);
-struct perf_evlist *perf_evlist__new_default(void);
-struct perf_evlist *perf_evlist__new_dummy(void);
-void perf_evlist__init(struct perf_evlist *evlist, struct perf_cpu_map *cpus,
+struct evlist *perf_evlist__new(void);
+struct evlist *perf_evlist__new_default(void);
+struct evlist *perf_evlist__new_dummy(void);
+void perf_evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
 		       struct perf_thread_map *threads);
-void perf_evlist__exit(struct perf_evlist *evlist);
-void perf_evlist__delete(struct perf_evlist *evlist);
+void perf_evlist__exit(struct evlist *evlist);
+void perf_evlist__delete(struct evlist *evlist);
 
-void perf_evlist__add(struct perf_evlist *evlist, struct evsel *entry);
-void perf_evlist__remove(struct perf_evlist *evlist, struct evsel *evsel);
+void perf_evlist__add(struct evlist *evlist, struct evsel *entry);
+void perf_evlist__remove(struct evlist *evlist, struct evsel *evsel);
 
-int __perf_evlist__add_default(struct perf_evlist *evlist, bool precise);
+int __perf_evlist__add_default(struct evlist *evlist, bool precise);
 
-static inline int perf_evlist__add_default(struct perf_evlist *evlist)
+static inline int perf_evlist__add_default(struct evlist *evlist)
 {
 	return __perf_evlist__add_default(evlist, true);
 }
 
-int __perf_evlist__add_default_attrs(struct perf_evlist *evlist,
+int __perf_evlist__add_default_attrs(struct evlist *evlist,
 				     struct perf_event_attr *attrs, size_t nr_attrs);
 
 #define perf_evlist__add_default_attrs(evlist, array) \
 	__perf_evlist__add_default_attrs(evlist, array, ARRAY_SIZE(array))
 
-int perf_evlist__add_dummy(struct perf_evlist *evlist);
+int perf_evlist__add_dummy(struct evlist *evlist);
 
-int perf_evlist__add_sb_event(struct perf_evlist **evlist,
+int perf_evlist__add_sb_event(struct evlist **evlist,
 			      struct perf_event_attr *attr,
 			      perf_evsel__sb_cb_t cb,
 			      void *data);
-int perf_evlist__start_sb_thread(struct perf_evlist *evlist,
+int perf_evlist__start_sb_thread(struct evlist *evlist,
 				 struct target *target);
-void perf_evlist__stop_sb_thread(struct perf_evlist *evlist);
+void perf_evlist__stop_sb_thread(struct evlist *evlist);
 
-int perf_evlist__add_newtp(struct perf_evlist *evlist,
+int perf_evlist__add_newtp(struct evlist *evlist,
 			   const char *sys, const char *name, void *handler);
 
-void __perf_evlist__set_sample_bit(struct perf_evlist *evlist,
+void __perf_evlist__set_sample_bit(struct evlist *evlist,
 				   enum perf_event_sample_format bit);
-void __perf_evlist__reset_sample_bit(struct perf_evlist *evlist,
+void __perf_evlist__reset_sample_bit(struct evlist *evlist,
 				     enum perf_event_sample_format bit);
 
 #define perf_evlist__set_sample_bit(evlist, bit) \
@@ -113,58 +113,58 @@ void __perf_evlist__reset_sample_bit(struct perf_evlist *evlist,
 #define perf_evlist__reset_sample_bit(evlist, bit) \
 	__perf_evlist__reset_sample_bit(evlist, PERF_SAMPLE_##bit)
 
-int perf_evlist__set_tp_filter(struct perf_evlist *evlist, const char *filter);
-int perf_evlist__set_tp_filter_pid(struct perf_evlist *evlist, pid_t pid);
-int perf_evlist__set_tp_filter_pids(struct perf_evlist *evlist, size_t npids, pid_t *pids);
+int perf_evlist__set_tp_filter(struct evlist *evlist, const char *filter);
+int perf_evlist__set_tp_filter_pid(struct evlist *evlist, pid_t pid);
+int perf_evlist__set_tp_filter_pids(struct evlist *evlist, size_t npids, pid_t *pids);
 
 struct evsel *
-perf_evlist__find_tracepoint_by_id(struct perf_evlist *evlist, int id);
+perf_evlist__find_tracepoint_by_id(struct evlist *evlist, int id);
 
 struct evsel *
-perf_evlist__find_tracepoint_by_name(struct perf_evlist *evlist,
+perf_evlist__find_tracepoint_by_name(struct evlist *evlist,
 				     const char *name);
 
-void perf_evlist__id_add(struct perf_evlist *evlist, struct evsel *evsel,
+void perf_evlist__id_add(struct evlist *evlist, struct evsel *evsel,
 			 int cpu, int thread, u64 id);
-int perf_evlist__id_add_fd(struct perf_evlist *evlist,
+int perf_evlist__id_add_fd(struct evlist *evlist,
 			   struct evsel *evsel,
 			   int cpu, int thread, int fd);
 
-int perf_evlist__add_pollfd(struct perf_evlist *evlist, int fd);
-int perf_evlist__alloc_pollfd(struct perf_evlist *evlist);
-int perf_evlist__filter_pollfd(struct perf_evlist *evlist, short revents_and_mask);
+int perf_evlist__add_pollfd(struct evlist *evlist, int fd);
+int perf_evlist__alloc_pollfd(struct evlist *evlist);
+int perf_evlist__filter_pollfd(struct evlist *evlist, short revents_and_mask);
 
-int perf_evlist__poll(struct perf_evlist *evlist, int timeout);
+int perf_evlist__poll(struct evlist *evlist, int timeout);
 
-struct evsel *perf_evlist__id2evsel(struct perf_evlist *evlist, u64 id);
-struct evsel *perf_evlist__id2evsel_strict(struct perf_evlist *evlist,
+struct evsel *perf_evlist__id2evsel(struct evlist *evlist, u64 id);
+struct evsel *perf_evlist__id2evsel_strict(struct evlist *evlist,
 						u64 id);
 
-struct perf_sample_id *perf_evlist__id2sid(struct perf_evlist *evlist, u64 id);
+struct perf_sample_id *perf_evlist__id2sid(struct evlist *evlist, u64 id);
 
-void perf_evlist__toggle_bkw_mmap(struct perf_evlist *evlist, enum bkw_mmap_state state);
+void perf_evlist__toggle_bkw_mmap(struct evlist *evlist, enum bkw_mmap_state state);
 
-void perf_evlist__mmap_consume(struct perf_evlist *evlist, int idx);
+void perf_evlist__mmap_consume(struct evlist *evlist, int idx);
 
-int perf_evlist__open(struct perf_evlist *evlist);
-void perf_evlist__close(struct perf_evlist *evlist);
+int perf_evlist__open(struct evlist *evlist);
+void perf_evlist__close(struct evlist *evlist);
 
 struct callchain_param;
 
-void perf_evlist__set_id_pos(struct perf_evlist *evlist);
+void perf_evlist__set_id_pos(struct evlist *evlist);
 bool perf_can_sample_identifier(void);
 bool perf_can_record_switch_events(void);
 bool perf_can_record_cpu_wide(void);
-void perf_evlist__config(struct perf_evlist *evlist, struct record_opts *opts,
+void perf_evlist__config(struct evlist *evlist, struct record_opts *opts,
 			 struct callchain_param *callchain);
 int record_opts__config(struct record_opts *opts);
 
-int perf_evlist__prepare_workload(struct perf_evlist *evlist,
+int perf_evlist__prepare_workload(struct evlist *evlist,
 				  struct target *target,
 				  const char *argv[], bool pipe_output,
 				  void (*exec_error)(int signo, siginfo_t *info,
 						     void *ucontext));
-int perf_evlist__start_workload(struct perf_evlist *evlist);
+int perf_evlist__start_workload(struct evlist *evlist);
 
 struct option;
 
@@ -175,76 +175,76 @@ int perf_evlist__parse_mmap_pages(const struct option *opt,
 
 unsigned long perf_event_mlock_kb_in_pages(void);
 
-int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
+int perf_evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 			 unsigned int auxtrace_pages,
 			 bool auxtrace_overwrite, int nr_cblocks,
 			 int affinity, int flush, int comp_level);
-int perf_evlist__mmap(struct perf_evlist *evlist, unsigned int pages);
-void perf_evlist__munmap(struct perf_evlist *evlist);
+int perf_evlist__mmap(struct evlist *evlist, unsigned int pages);
+void perf_evlist__munmap(struct evlist *evlist);
 
 size_t perf_evlist__mmap_size(unsigned long pages);
 
-void perf_evlist__disable(struct perf_evlist *evlist);
-void perf_evlist__enable(struct perf_evlist *evlist);
-void perf_evlist__toggle_enable(struct perf_evlist *evlist);
+void perf_evlist__disable(struct evlist *evlist);
+void perf_evlist__enable(struct evlist *evlist);
+void perf_evlist__toggle_enable(struct evlist *evlist);
 
-int perf_evlist__enable_event_idx(struct perf_evlist *evlist,
+int perf_evlist__enable_event_idx(struct evlist *evlist,
 				  struct evsel *evsel, int idx);
 
-void perf_evlist__set_selected(struct perf_evlist *evlist,
+void perf_evlist__set_selected(struct evlist *evlist,
 			       struct evsel *evsel);
 
-void perf_evlist__set_maps(struct perf_evlist *evlist, struct perf_cpu_map *cpus,
+void perf_evlist__set_maps(struct evlist *evlist, struct perf_cpu_map *cpus,
 			   struct perf_thread_map *threads);
-int perf_evlist__create_maps(struct perf_evlist *evlist, struct target *target);
-int perf_evlist__apply_filters(struct perf_evlist *evlist, struct evsel **err_evsel);
+int perf_evlist__create_maps(struct evlist *evlist, struct target *target);
+int perf_evlist__apply_filters(struct evlist *evlist, struct evsel **err_evsel);
 
 void __perf_evlist__set_leader(struct list_head *list);
-void perf_evlist__set_leader(struct perf_evlist *evlist);
+void perf_evlist__set_leader(struct evlist *evlist);
 
-u64 perf_evlist__read_format(struct perf_evlist *evlist);
-u64 __perf_evlist__combined_sample_type(struct perf_evlist *evlist);
-u64 perf_evlist__combined_sample_type(struct perf_evlist *evlist);
-u64 perf_evlist__combined_branch_type(struct perf_evlist *evlist);
-bool perf_evlist__sample_id_all(struct perf_evlist *evlist);
-u16 perf_evlist__id_hdr_size(struct perf_evlist *evlist);
+u64 perf_evlist__read_format(struct evlist *evlist);
+u64 __perf_evlist__combined_sample_type(struct evlist *evlist);
+u64 perf_evlist__combined_sample_type(struct evlist *evlist);
+u64 perf_evlist__combined_branch_type(struct evlist *evlist);
+bool perf_evlist__sample_id_all(struct evlist *evlist);
+u16 perf_evlist__id_hdr_size(struct evlist *evlist);
 
-int perf_evlist__parse_sample(struct perf_evlist *evlist, union perf_event *event,
+int perf_evlist__parse_sample(struct evlist *evlist, union perf_event *event,
 			      struct perf_sample *sample);
 
-int perf_evlist__parse_sample_timestamp(struct perf_evlist *evlist,
+int perf_evlist__parse_sample_timestamp(struct evlist *evlist,
 					union perf_event *event,
 					u64 *timestamp);
 
-bool perf_evlist__valid_sample_type(struct perf_evlist *evlist);
-bool perf_evlist__valid_sample_id_all(struct perf_evlist *evlist);
-bool perf_evlist__valid_read_format(struct perf_evlist *evlist);
+bool perf_evlist__valid_sample_type(struct evlist *evlist);
+bool perf_evlist__valid_sample_id_all(struct evlist *evlist);
+bool perf_evlist__valid_read_format(struct evlist *evlist);
 
-void perf_evlist__splice_list_tail(struct perf_evlist *evlist,
+void perf_evlist__splice_list_tail(struct evlist *evlist,
 				   struct list_head *list);
 
-static inline bool perf_evlist__empty(struct perf_evlist *evlist)
+static inline bool perf_evlist__empty(struct evlist *evlist)
 {
 	return list_empty(&evlist->entries);
 }
 
-static inline struct evsel *perf_evlist__first(struct perf_evlist *evlist)
+static inline struct evsel *perf_evlist__first(struct evlist *evlist)
 {
 	return list_entry(evlist->entries.next, struct evsel, node);
 }
 
-static inline struct evsel *perf_evlist__last(struct perf_evlist *evlist)
+static inline struct evsel *perf_evlist__last(struct evlist *evlist)
 {
 	return list_entry(evlist->entries.prev, struct evsel, node);
 }
 
-size_t perf_evlist__fprintf(struct perf_evlist *evlist, FILE *fp);
+size_t perf_evlist__fprintf(struct evlist *evlist, FILE *fp);
 
-int perf_evlist__strerror_open(struct perf_evlist *evlist, int err, char *buf, size_t size);
-int perf_evlist__strerror_mmap(struct perf_evlist *evlist, int err, char *buf, size_t size);
+int perf_evlist__strerror_open(struct evlist *evlist, int err, char *buf, size_t size);
+int perf_evlist__strerror_mmap(struct evlist *evlist, int err, char *buf, size_t size);
 
-bool perf_evlist__can_select_event(struct perf_evlist *evlist, const char *str);
-void perf_evlist__to_front(struct perf_evlist *evlist,
+bool perf_evlist__can_select_event(struct evlist *evlist, const char *str);
+void perf_evlist__to_front(struct evlist *evlist,
 			   struct evsel *move_evsel);
 
 /**
@@ -313,19 +313,19 @@ void perf_evlist__to_front(struct perf_evlist *evlist,
 #define evlist__for_each_entry_safe(evlist, tmp, evsel) \
 	__evlist__for_each_entry_safe(&(evlist)->entries, tmp, evsel)
 
-void perf_evlist__set_tracking_event(struct perf_evlist *evlist,
+void perf_evlist__set_tracking_event(struct evlist *evlist,
 				     struct evsel *tracking_evsel);
 
 struct evsel *
-perf_evlist__find_evsel_by_str(struct perf_evlist *evlist, const char *str);
+perf_evlist__find_evsel_by_str(struct evlist *evlist, const char *str);
 
-struct evsel *perf_evlist__event2evsel(struct perf_evlist *evlist,
+struct evsel *perf_evlist__event2evsel(struct evlist *evlist,
 					    union perf_event *event);
 
-bool perf_evlist__exclude_kernel(struct perf_evlist *evlist);
+bool perf_evlist__exclude_kernel(struct evlist *evlist);
 
-void perf_evlist__force_leader(struct perf_evlist *evlist);
+void perf_evlist__force_leader(struct evlist *evlist);
 
-struct evsel *perf_evlist__reset_weak_group(struct perf_evlist *evlist,
+struct evsel *perf_evlist__reset_weak_group(struct evlist *evlist,
 						 struct evsel *evsel);
 #endif /* __PERF_EVLIST_H */
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 44421bbebd64..f7f97ca6e96d 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3044,7 +3044,7 @@ struct perf_env *perf_evsel__env(struct evsel *evsel)
 	return NULL;
 }
 
-static int store_evsel_ids(struct evsel *evsel, struct perf_evlist *evlist)
+static int store_evsel_ids(struct evsel *evsel, struct evlist *evlist)
 {
 	int cpu, thread;
 
@@ -3062,7 +3062,7 @@ static int store_evsel_ids(struct evsel *evsel, struct perf_evlist *evlist)
 	return 0;
 }
 
-int perf_evsel__store_ids(struct evsel *evsel, struct perf_evlist *evlist)
+int perf_evsel__store_ids(struct evsel *evsel, struct evlist *evlist)
 {
 	struct perf_cpu_map *cpus = evsel->cpus;
 	struct perf_thread_map *threads = evsel->threads;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 2c31c5e99524..3caabd8a4aa6 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -102,7 +102,7 @@ struct bpf_object;
  */
 struct evsel {
 	struct list_head	node;
-	struct perf_evlist	*evlist;
+	struct evlist	*evlist;
 	struct perf_event_attr	attr;
 	char			*filter;
 	struct xyarray		*fd;
@@ -506,5 +506,5 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 
 struct perf_env *perf_evsel__env(struct evsel *evsel);
 
-int perf_evsel__store_ids(struct evsel *evsel, struct perf_evlist *evlist);
+int perf_evsel__store_ids(struct evsel *evsel, struct evlist *evlist);
 #endif /* __PERF_EVSEL_H */
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 60c1d89a404b..23a24fff4d7e 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -299,7 +299,7 @@ static int do_read_bitmap(struct feat_fd *ff, unsigned long **pset, u64 *psize)
 }
 
 static int write_tracing_data(struct feat_fd *ff,
-			      struct perf_evlist *evlist)
+			      struct evlist *evlist)
 {
 	if (WARN(ff->buf, "Error: calling %s in pipe-mode.\n", __func__))
 		return -1;
@@ -308,7 +308,7 @@ static int write_tracing_data(struct feat_fd *ff,
 }
 
 static int write_build_id(struct feat_fd *ff,
-			  struct perf_evlist *evlist __maybe_unused)
+			  struct evlist *evlist __maybe_unused)
 {
 	struct perf_session *session;
 	int err;
@@ -332,7 +332,7 @@ static int write_build_id(struct feat_fd *ff,
 }
 
 static int write_hostname(struct feat_fd *ff,
-			  struct perf_evlist *evlist __maybe_unused)
+			  struct evlist *evlist __maybe_unused)
 {
 	struct utsname uts;
 	int ret;
@@ -345,7 +345,7 @@ static int write_hostname(struct feat_fd *ff,
 }
 
 static int write_osrelease(struct feat_fd *ff,
-			   struct perf_evlist *evlist __maybe_unused)
+			   struct evlist *evlist __maybe_unused)
 {
 	struct utsname uts;
 	int ret;
@@ -358,7 +358,7 @@ static int write_osrelease(struct feat_fd *ff,
 }
 
 static int write_arch(struct feat_fd *ff,
-		      struct perf_evlist *evlist __maybe_unused)
+		      struct evlist *evlist __maybe_unused)
 {
 	struct utsname uts;
 	int ret;
@@ -371,7 +371,7 @@ static int write_arch(struct feat_fd *ff,
 }
 
 static int write_version(struct feat_fd *ff,
-			 struct perf_evlist *evlist __maybe_unused)
+			 struct evlist *evlist __maybe_unused)
 {
 	return do_write_string(ff, perf_version_string);
 }
@@ -432,7 +432,7 @@ static int __write_cpudesc(struct feat_fd *ff, const char *cpuinfo_proc)
 }
 
 static int write_cpudesc(struct feat_fd *ff,
-		       struct perf_evlist *evlist __maybe_unused)
+		       struct evlist *evlist __maybe_unused)
 {
 	const char *cpuinfo_procs[] = CPUINFO_PROC;
 	unsigned int i;
@@ -448,7 +448,7 @@ static int write_cpudesc(struct feat_fd *ff,
 
 
 static int write_nrcpus(struct feat_fd *ff,
-			struct perf_evlist *evlist __maybe_unused)
+			struct evlist *evlist __maybe_unused)
 {
 	long nr;
 	u32 nrc, nra;
@@ -470,7 +470,7 @@ static int write_nrcpus(struct feat_fd *ff,
 }
 
 static int write_event_desc(struct feat_fd *ff,
-			    struct perf_evlist *evlist)
+			    struct evlist *evlist)
 {
 	struct evsel *evsel;
 	u32 nre, nri, sz;
@@ -526,7 +526,7 @@ static int write_event_desc(struct feat_fd *ff,
 }
 
 static int write_cmdline(struct feat_fd *ff,
-			 struct perf_evlist *evlist __maybe_unused)
+			 struct evlist *evlist __maybe_unused)
 {
 	char pbuf[MAXPATHLEN], *buf;
 	int i, ret, n;
@@ -555,7 +555,7 @@ static int write_cmdline(struct feat_fd *ff,
 
 
 static int write_cpu_topology(struct feat_fd *ff,
-			      struct perf_evlist *evlist __maybe_unused)
+			      struct evlist *evlist __maybe_unused)
 {
 	struct cpu_topology *tp;
 	u32 i;
@@ -627,7 +627,7 @@ static int write_cpu_topology(struct feat_fd *ff,
 
 
 static int write_total_mem(struct feat_fd *ff,
-			   struct perf_evlist *evlist __maybe_unused)
+			   struct evlist *evlist __maybe_unused)
 {
 	char *buf = NULL;
 	FILE *fp;
@@ -656,7 +656,7 @@ static int write_total_mem(struct feat_fd *ff,
 }
 
 static int write_numa_topology(struct feat_fd *ff,
-			       struct perf_evlist *evlist __maybe_unused)
+			       struct evlist *evlist __maybe_unused)
 {
 	struct numa_topology *tp;
 	int ret = -1;
@@ -710,7 +710,7 @@ static int write_numa_topology(struct feat_fd *ff,
  */
 
 static int write_pmu_mappings(struct feat_fd *ff,
-			      struct perf_evlist *evlist __maybe_unused)
+			      struct evlist *evlist __maybe_unused)
 {
 	struct perf_pmu *pmu = NULL;
 	u32 pmu_num = 0;
@@ -759,7 +759,7 @@ static int write_pmu_mappings(struct feat_fd *ff,
  * };
  */
 static int write_group_desc(struct feat_fd *ff,
-			    struct perf_evlist *evlist)
+			    struct evlist *evlist)
 {
 	u32 nr_groups = evlist->nr_groups;
 	struct evsel *evsel;
@@ -841,7 +841,7 @@ int __weak get_cpuid(char *buffer __maybe_unused, size_t sz __maybe_unused)
 }
 
 static int write_cpuid(struct feat_fd *ff,
-		       struct perf_evlist *evlist __maybe_unused)
+		       struct evlist *evlist __maybe_unused)
 {
 	char buffer[64];
 	int ret;
@@ -854,13 +854,13 @@ static int write_cpuid(struct feat_fd *ff,
 }
 
 static int write_branch_stack(struct feat_fd *ff __maybe_unused,
-			      struct perf_evlist *evlist __maybe_unused)
+			      struct evlist *evlist __maybe_unused)
 {
 	return 0;
 }
 
 static int write_auxtrace(struct feat_fd *ff,
-			  struct perf_evlist *evlist __maybe_unused)
+			  struct evlist *evlist __maybe_unused)
 {
 	struct perf_session *session;
 	int err;
@@ -877,14 +877,14 @@ static int write_auxtrace(struct feat_fd *ff,
 }
 
 static int write_clockid(struct feat_fd *ff,
-			 struct perf_evlist *evlist __maybe_unused)
+			 struct evlist *evlist __maybe_unused)
 {
 	return do_write(ff, &ff->ph->env.clockid_res_ns,
 			sizeof(ff->ph->env.clockid_res_ns));
 }
 
 static int write_dir_format(struct feat_fd *ff,
-			    struct perf_evlist *evlist __maybe_unused)
+			    struct evlist *evlist __maybe_unused)
 {
 	struct perf_session *session;
 	struct perf_data *data;
@@ -900,7 +900,7 @@ static int write_dir_format(struct feat_fd *ff,
 
 #ifdef HAVE_LIBBPF_SUPPORT
 static int write_bpf_prog_info(struct feat_fd *ff,
-			       struct perf_evlist *evlist __maybe_unused)
+			       struct evlist *evlist __maybe_unused)
 {
 	struct perf_env *env = &ff->ph->env;
 	struct rb_root *root;
@@ -942,14 +942,14 @@ static int write_bpf_prog_info(struct feat_fd *ff,
 }
 #else // HAVE_LIBBPF_SUPPORT
 static int write_bpf_prog_info(struct feat_fd *ff __maybe_unused,
-			       struct perf_evlist *evlist __maybe_unused)
+			       struct evlist *evlist __maybe_unused)
 {
 	return 0;
 }
 #endif // HAVE_LIBBPF_SUPPORT
 
 static int write_bpf_btf(struct feat_fd *ff,
-			 struct perf_evlist *evlist __maybe_unused)
+			 struct evlist *evlist __maybe_unused)
 {
 	struct perf_env *env = &ff->ph->env;
 	struct rb_root *root;
@@ -1123,7 +1123,7 @@ static int build_caches(struct cpu_cache_level caches[], u32 size, u32 *cntp)
 #define MAX_CACHES (MAX_NR_CPUS * 4)
 
 static int write_cache(struct feat_fd *ff,
-		       struct perf_evlist *evlist __maybe_unused)
+		       struct evlist *evlist __maybe_unused)
 {
 	struct cpu_cache_level caches[MAX_CACHES];
 	u32 cnt = 0, i, version = 1;
@@ -1175,13 +1175,13 @@ static int write_cache(struct feat_fd *ff,
 }
 
 static int write_stat(struct feat_fd *ff __maybe_unused,
-		      struct perf_evlist *evlist __maybe_unused)
+		      struct evlist *evlist __maybe_unused)
 {
 	return 0;
 }
 
 static int write_sample_time(struct feat_fd *ff,
-			     struct perf_evlist *evlist)
+			     struct evlist *evlist)
 {
 	int ret;
 
@@ -1315,7 +1315,7 @@ static int build_mem_topology(struct memory_node *nodes, u64 size, u64 *cntp)
  * 48 - bitmap           | bitmap of memory indexes that belongs to node
  */
 static int write_mem_topology(struct feat_fd *ff __maybe_unused,
-			      struct perf_evlist *evlist __maybe_unused)
+			      struct evlist *evlist __maybe_unused)
 {
 	static struct memory_node nodes[MAX_MEMORY_NODES];
 	u64 bsize, version = 1, i, nr;
@@ -1365,7 +1365,7 @@ static int write_mem_topology(struct feat_fd *ff __maybe_unused,
 }
 
 static int write_compressed(struct feat_fd *ff __maybe_unused,
-			    struct perf_evlist *evlist __maybe_unused)
+			    struct evlist *evlist __maybe_unused)
 {
 	int ret;
 
@@ -2090,7 +2090,7 @@ static int process_total_mem(struct feat_fd *ff, void *data __maybe_unused)
 }
 
 static struct evsel *
-perf_evlist__find_by_index(struct perf_evlist *evlist, int idx)
+perf_evlist__find_by_index(struct evlist *evlist, int idx)
 {
 	struct evsel *evsel;
 
@@ -2103,7 +2103,7 @@ perf_evlist__find_by_index(struct perf_evlist *evlist, int idx)
 }
 
 static void
-perf_evlist__set_event_name(struct perf_evlist *evlist,
+perf_evlist__set_event_name(struct evlist *evlist,
 			    struct evsel *event)
 {
 	struct evsel *evsel;
@@ -2801,7 +2801,7 @@ static int process_compressed(struct feat_fd *ff,
 }
 
 struct feature_ops {
-	int (*write)(struct feat_fd *ff, struct perf_evlist *evlist);
+	int (*write)(struct feat_fd *ff, struct evlist *evlist);
 	void (*print)(struct feat_fd *ff, FILE *fp);
 	int (*process)(struct feat_fd *ff, void *data);
 	const char *name;
@@ -2946,7 +2946,7 @@ int perf_header__fprintf_info(struct perf_session *session, FILE *fp, bool full)
 
 static int do_write_feat(struct feat_fd *ff, int type,
 			 struct perf_file_section **p,
-			 struct perf_evlist *evlist)
+			 struct evlist *evlist)
 {
 	int err;
 	int ret = 0;
@@ -2976,7 +2976,7 @@ static int do_write_feat(struct feat_fd *ff, int type,
 }
 
 static int perf_header__adds_write(struct perf_header *header,
-				   struct perf_evlist *evlist, int fd)
+				   struct evlist *evlist, int fd)
 {
 	int nr_sections;
 	struct feat_fd ff;
@@ -3044,7 +3044,7 @@ int perf_header__write_pipe(int fd)
 }
 
 int perf_session__write_header(struct perf_session *session,
-			       struct perf_evlist *evlist,
+			       struct evlist *evlist,
 			       int fd, bool at_exit)
 {
 	struct perf_file_header f_header;
@@ -3511,7 +3511,7 @@ static int perf_evsel__prepare_tracepoint_event(struct evsel *evsel,
 	return 0;
 }
 
-static int perf_evlist__prepare_tracepoint_events(struct perf_evlist *evlist,
+static int perf_evlist__prepare_tracepoint_events(struct evlist *evlist,
 						  struct tep_handle *pevent)
 {
 	struct evsel *pos;
@@ -3662,7 +3662,7 @@ int perf_event__synthesize_attr(struct perf_tool *tool,
 
 int perf_event__synthesize_features(struct perf_tool *tool,
 				    struct perf_session *session,
-				    struct perf_evlist *evlist,
+				    struct evlist *evlist,
 				    perf_event__handler_t process)
 {
 	struct perf_header *header = &session->header;
@@ -3914,7 +3914,7 @@ size_t perf_event__fprintf_event_update(union perf_event *event, FILE *fp)
 }
 
 int perf_event__synthesize_attrs(struct perf_tool *tool,
-				 struct perf_evlist *evlist,
+				 struct evlist *evlist,
 				 perf_event__handler_t process)
 {
 	struct evsel *evsel;
@@ -3943,7 +3943,7 @@ static bool has_scale(struct evsel *counter)
 }
 
 int perf_event__synthesize_extra_attr(struct perf_tool *tool,
-				      struct perf_evlist *evsel_list,
+				      struct evlist *evsel_list,
 				      perf_event__handler_t process,
 				      bool is_pipe)
 {
@@ -4002,11 +4002,11 @@ int perf_event__synthesize_extra_attr(struct perf_tool *tool,
 
 int perf_event__process_attr(struct perf_tool *tool __maybe_unused,
 			     union perf_event *event,
-			     struct perf_evlist **pevlist)
+			     struct evlist **pevlist)
 {
 	u32 i, ids, n_ids;
 	struct evsel *evsel;
-	struct perf_evlist *evlist = *pevlist;
+	struct evlist *evlist = *pevlist;
 
 	if (evlist == NULL) {
 		*pevlist = evlist = perf_evlist__new();
@@ -4040,12 +4040,12 @@ int perf_event__process_attr(struct perf_tool *tool __maybe_unused,
 
 int perf_event__process_event_update(struct perf_tool *tool __maybe_unused,
 				     union perf_event *event,
-				     struct perf_evlist **pevlist)
+				     struct evlist **pevlist)
 {
 	struct event_update_event *ev = &event->event_update;
 	struct event_update_event_scale *ev_scale;
 	struct event_update_event_cpus *ev_cpus;
-	struct perf_evlist *evlist;
+	struct evlist *evlist;
 	struct evsel *evsel;
 	struct perf_cpu_map *map;
 
@@ -4085,7 +4085,7 @@ int perf_event__process_event_update(struct perf_tool *tool __maybe_unused,
 }
 
 int perf_event__synthesize_tracing_data(struct perf_tool *tool, int fd,
-					struct perf_evlist *evlist,
+					struct evlist *evlist,
 					perf_event__handler_t process)
 {
 	union perf_event ev;
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 437d8617de27..3e48ae3c49b1 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -92,12 +92,12 @@ struct perf_header {
 	struct perf_env 	env;
 };
 
-struct perf_evlist;
+struct evlist;
 struct perf_session;
 
 int perf_session__read_header(struct perf_session *session);
 int perf_session__write_header(struct perf_session *session,
-			       struct perf_evlist *evlist,
+			       struct evlist *evlist,
 			       int fd, bool at_exit);
 int perf_header__write_pipe(int fd);
 
@@ -117,11 +117,11 @@ int perf_header__fprintf_info(struct perf_session *s, FILE *fp, bool full);
 
 int perf_event__synthesize_features(struct perf_tool *tool,
 				    struct perf_session *session,
-				    struct perf_evlist *evlist,
+				    struct evlist *evlist,
 				    perf_event__handler_t process);
 
 int perf_event__synthesize_extra_attr(struct perf_tool *tool,
-				      struct perf_evlist *evsel_list,
+				      struct evlist *evsel_list,
 				      perf_event__handler_t process,
 				      bool is_pipe);
 
@@ -132,7 +132,7 @@ int perf_event__synthesize_attr(struct perf_tool *tool,
 				struct perf_event_attr *attr, u32 ids, u64 *id,
 				perf_event__handler_t process);
 int perf_event__synthesize_attrs(struct perf_tool *tool,
-				 struct perf_evlist *evlist,
+				 struct evlist *evlist,
 				 perf_event__handler_t process);
 int perf_event__synthesize_event_update_unit(struct perf_tool *tool,
 					     struct evsel *evsel,
@@ -147,14 +147,14 @@ int perf_event__synthesize_event_update_cpus(struct perf_tool *tool,
 					     struct evsel *evsel,
 					     perf_event__handler_t process);
 int perf_event__process_attr(struct perf_tool *tool, union perf_event *event,
-			     struct perf_evlist **pevlist);
+			     struct evlist **pevlist);
 int perf_event__process_event_update(struct perf_tool *tool,
 				     union perf_event *event,
-				     struct perf_evlist **pevlist);
+				     struct evlist **pevlist);
 size_t perf_event__fprintf_event_update(union perf_event *event, FILE *fp);
 
 int perf_event__synthesize_tracing_data(struct perf_tool *tool,
-					int fd, struct perf_evlist *evlist,
+					int fd, struct evlist *evlist,
 					perf_event__handler_t process);
 int perf_event__process_tracing_data(struct perf_session *session,
 				     union perf_event *event);
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 3da49c479880..bb5437f549b6 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2573,7 +2573,7 @@ void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
 	}
 }
 
-size_t perf_evlist__fprintf_nr_events(struct perf_evlist *evlist, FILE *fp)
+size_t perf_evlist__fprintf_nr_events(struct evlist *evlist, FILE *fp)
 {
 	struct evsel *pos;
 	size_t ret = 0;
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 9bf247c638b8..83d5fc15429c 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -196,7 +196,7 @@ size_t events_stats__fprintf(struct events_stats *stats, FILE *fp);
 size_t hists__fprintf(struct hists *hists, bool show_header, int max_rows,
 		      int max_cols, float min_pcnt, FILE *fp,
 		      bool ignore_callchains);
-size_t perf_evlist__fprintf_nr_events(struct perf_evlist *evlist, FILE *fp);
+size_t perf_evlist__fprintf_nr_events(struct evlist *evlist, FILE *fp);
 
 void hists__filter_by_dso(struct hists *hists);
 void hists__filter_by_thread(struct hists *hists);
@@ -367,7 +367,7 @@ void perf_hpp__setup_output_field(struct perf_hpp_list *list);
 void perf_hpp__reset_output_field(struct perf_hpp_list *list);
 void perf_hpp__append_sort_keys(struct perf_hpp_list *list);
 int perf_hpp__setup_hists_formats(struct perf_hpp_list *list,
-				  struct perf_evlist *evlist);
+				  struct evlist *evlist);
 
 
 bool perf_hpp__is_sort_entry(struct perf_hpp_fmt *format);
@@ -432,7 +432,7 @@ static inline size_t perf_hpp__color_overhead(void)
 	       : 0;
 }
 
-struct perf_evlist;
+struct evlist;
 
 struct hist_browser_timer {
 	void (*timer)(void *arg);
@@ -461,7 +461,7 @@ int hist_entry__tui_annotate(struct hist_entry *he, struct evsel *evsel,
 			     struct hist_browser_timer *hbt,
 			     struct annotation_options *annotation_opts);
 
-int perf_evlist__tui_browse_hists(struct perf_evlist *evlist, const char *help,
+int perf_evlist__tui_browse_hists(struct evlist *evlist, const char *help,
 				  struct hist_browser_timer *hbt,
 				  float min_pcnt,
 				  struct perf_env *env,
@@ -476,7 +476,7 @@ int res_sample_browse(struct res_sample *res_samples, int num_res,
 void res_sample_init(void);
 #else
 static inline
-int perf_evlist__tui_browse_hists(struct perf_evlist *evlist __maybe_unused,
+int perf_evlist__tui_browse_hists(struct evlist *evlist __maybe_unused,
 				  const char *help __maybe_unused,
 				  struct hist_browser_timer *hbt __maybe_unused,
 				  float min_pcnt __maybe_unused,
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 8fd46d5f4b39..849a5b713b04 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -760,7 +760,7 @@ static int intel_bts_synth_event(struct perf_session *session,
 static int intel_bts_synth_events(struct intel_bts *bts,
 				  struct perf_session *session)
 {
-	struct perf_evlist *evlist = session->evlist;
+	struct evlist *evlist = session->evlist;
 	struct evsel *evsel;
 	struct perf_event_attr attr;
 	bool found = false;
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index f1595b86d7c7..c88e3d1ee9c7 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -2713,7 +2713,7 @@ static int intel_pt_synth_event(struct perf_session *session, const char *name,
 	return err;
 }
 
-static void intel_pt_set_event_name(struct perf_evlist *evlist, u64 id,
+static void intel_pt_set_event_name(struct evlist *evlist, u64 id,
 				    const char *name)
 {
 	struct evsel *evsel;
@@ -2729,7 +2729,7 @@ static void intel_pt_set_event_name(struct perf_evlist *evlist, u64 id,
 }
 
 static struct evsel *intel_pt_evsel(struct intel_pt *pt,
-					 struct perf_evlist *evlist)
+					 struct evlist *evlist)
 {
 	struct evsel *evsel;
 
@@ -2744,7 +2744,7 @@ static struct evsel *intel_pt_evsel(struct intel_pt *pt,
 static int intel_pt_synth_events(struct intel_pt *pt,
 				 struct perf_session *session)
 {
-	struct perf_evlist *evlist = session->evlist;
+	struct evlist *evlist = session->evlist;
 	struct evsel *evsel = intel_pt_evsel(pt, evlist);
 	struct perf_event_attr attr;
 	u64 id;
@@ -2894,7 +2894,7 @@ static int intel_pt_synth_events(struct intel_pt *pt,
 	return 0;
 }
 
-static struct evsel *intel_pt_find_sched_switch(struct perf_evlist *evlist)
+static struct evsel *intel_pt_find_sched_switch(struct evlist *evlist)
 {
 	struct evsel *evsel;
 
@@ -2908,7 +2908,7 @@ static struct evsel *intel_pt_find_sched_switch(struct perf_evlist *evlist)
 	return NULL;
 }
 
-static bool intel_pt_find_switch(struct perf_evlist *evlist)
+static bool intel_pt_find_switch(struct evlist *evlist)
 {
 	struct evsel *evsel;
 
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index 299edd32d3d4..a09c495f866b 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -7,7 +7,7 @@
 #include "stat.h"
 
 struct evsel;
-struct perf_evlist;
+struct evlist;
 struct perf_session;
 
 struct event_key {
@@ -74,7 +74,7 @@ struct exit_reasons_table {
 struct perf_kvm_stat {
 	struct perf_tool    tool;
 	struct record_opts  opts;
-	struct perf_evlist  *evlist;
+	struct evlist  *evlist;
 	struct perf_session *session;
 
 	const char *file_name;
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 14c423974d63..fdb0d1c5c5cf 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -101,7 +101,7 @@ static bool record_evsel(int *ind, struct evsel **start,
 	return false;
 }
 
-static struct evsel *find_evsel_group(struct perf_evlist *perf_evlist,
+static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 				      const char **ids,
 				      int idnum,
 				      struct evsel **metric_events)
@@ -140,7 +140,7 @@ static struct evsel *find_evsel_group(struct perf_evlist *perf_evlist,
 }
 
 static int metricgroup__setup_events(struct list_head *groups,
-				     struct perf_evlist *perf_evlist,
+				     struct evlist *perf_evlist,
 				     struct rblist *metric_events_list)
 {
 	struct metric_event *me;
@@ -502,7 +502,7 @@ int metricgroup__parse_groups(const struct option *opt,
 			   struct rblist *metric_events)
 {
 	struct parse_events_error parse_error;
-	struct perf_evlist *perf_evlist = *(struct perf_evlist **)opt->value;
+	struct evlist *perf_evlist = *(struct evlist **)opt->value;
 	struct strbuf extra_events;
 	LIST_HEAD(group_list);
 	int ret;
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 177c41fc9842..42a5971146ae 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -150,7 +150,7 @@ void __weak auxtrace_mmap_params__init(struct auxtrace_mmap_params *mp __maybe_u
 }
 
 void __weak auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp __maybe_unused,
-					  struct perf_evlist *evlist __maybe_unused,
+					  struct evlist *evlist __maybe_unused,
 					  int idx __maybe_unused,
 					  bool per_cpu __maybe_unused)
 {
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index dfde9cb31562..d341b11fb141 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1904,7 +1904,7 @@ int parse_events_terms(struct list_head *terms, const char *str)
 	return ret;
 }
 
-int parse_events(struct perf_evlist *evlist, const char *str,
+int parse_events(struct evlist *evlist, const char *str,
 		 struct parse_events_error *err)
 {
 	struct parse_events_state parse_state = {
@@ -2013,7 +2013,7 @@ void parse_events_print_error(struct parse_events_error *err,
 int parse_events_option(const struct option *opt, const char *str,
 			int unset __maybe_unused)
 {
-	struct perf_evlist *evlist = *(struct perf_evlist **)opt->value;
+	struct evlist *evlist = *(struct evlist **)opt->value;
 	struct parse_events_error err = { .idx = 0, };
 	int ret = parse_events(evlist, str, &err);
 
@@ -2026,7 +2026,7 @@ int parse_events_option(const struct option *opt, const char *str,
 }
 
 static int
-foreach_evsel_in_last_glob(struct perf_evlist *evlist,
+foreach_evsel_in_last_glob(struct evlist *evlist,
 			   int (*func)(struct evsel *evsel,
 				       const void *arg),
 			   const void *arg)
@@ -2109,7 +2109,7 @@ static int set_filter(struct evsel *evsel, const void *arg)
 int parse_filter(const struct option *opt, const char *str,
 		 int unset __maybe_unused)
 {
-	struct perf_evlist *evlist = *(struct perf_evlist **)opt->value;
+	struct evlist *evlist = *(struct evlist **)opt->value;
 
 	return foreach_evsel_in_last_glob(evlist, set_filter,
 					  (const void *)str);
@@ -2141,7 +2141,7 @@ int exclude_perf(const struct option *opt,
 		 const char *arg __maybe_unused,
 		 int unset __maybe_unused)
 {
-	struct perf_evlist *evlist = *(struct perf_evlist **)opt->value;
+	struct evlist *evlist = *(struct evlist **)opt->value;
 
 	return foreach_evsel_in_last_glob(evlist, add_exclude_perf_filter,
 					  NULL);
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 99e206598b60..48111b8fc232 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -13,7 +13,7 @@
 
 struct list_head;
 struct evsel;
-struct perf_evlist;
+struct evlist;
 struct parse_events_error;
 
 struct option;
@@ -31,7 +31,7 @@ bool have_tracepoints(struct list_head *evlist);
 const char *event_type(int type);
 
 int parse_events_option(const struct option *opt, const char *str, int unset);
-int parse_events(struct perf_evlist *evlist, const char *str,
+int parse_events(struct evlist *evlist, const char *str,
 		 struct parse_events_error *error);
 int parse_events_terms(struct list_head *terms, const char *str);
 int parse_filter(const struct option *opt, const char *str, int unset);
@@ -119,7 +119,7 @@ struct parse_events_state {
 	int			   idx;
 	int			   nr_groups;
 	struct parse_events_error *error;
-	struct perf_evlist	  *evlist;
+	struct evlist	  *evlist;
 	struct list_head	  *terms;
 };
 
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index beafbd469b0c..ed57b6b5ed91 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -858,7 +858,7 @@ static int pyrf_evsel__setup_types(void)
 struct pyrf_evlist {
 	PyObject_HEAD
 
-	struct perf_evlist evlist;
+	struct evlist evlist;
 };
 
 static int pyrf_evlist__init(struct pyrf_evlist *pevlist,
@@ -886,7 +886,7 @@ static void pyrf_evlist__delete(struct pyrf_evlist *pevlist)
 static PyObject *pyrf_evlist__mmap(struct pyrf_evlist *pevlist,
 				   PyObject *args, PyObject *kwargs)
 {
-	struct perf_evlist *evlist = &pevlist->evlist;
+	struct evlist *evlist = &pevlist->evlist;
 	static char *kwlist[] = { "pages", "overwrite", NULL };
 	int pages = 128, overwrite = false;
 
@@ -906,7 +906,7 @@ static PyObject *pyrf_evlist__mmap(struct pyrf_evlist *pevlist,
 static PyObject *pyrf_evlist__poll(struct pyrf_evlist *pevlist,
 				   PyObject *args, PyObject *kwargs)
 {
-	struct perf_evlist *evlist = &pevlist->evlist;
+	struct evlist *evlist = &pevlist->evlist;
 	static char *kwlist[] = { "timeout", NULL };
 	int timeout = -1, n;
 
@@ -926,7 +926,7 @@ static PyObject *pyrf_evlist__get_pollfd(struct pyrf_evlist *pevlist,
 					 PyObject *args __maybe_unused,
 					 PyObject *kwargs __maybe_unused)
 {
-	struct perf_evlist *evlist = &pevlist->evlist;
+	struct evlist *evlist = &pevlist->evlist;
         PyObject *list = PyList_New(0);
 	int i;
 
@@ -964,7 +964,7 @@ static PyObject *pyrf_evlist__add(struct pyrf_evlist *pevlist,
 				  PyObject *args,
 				  PyObject *kwargs __maybe_unused)
 {
-	struct perf_evlist *evlist = &pevlist->evlist;
+	struct evlist *evlist = &pevlist->evlist;
 	PyObject *pevsel;
 	struct evsel *evsel;
 
@@ -979,7 +979,7 @@ static PyObject *pyrf_evlist__add(struct pyrf_evlist *pevlist,
 	return Py_BuildValue("i", evlist->nr_entries);
 }
 
-static struct perf_mmap *get_md(struct perf_evlist *evlist, int cpu)
+static struct perf_mmap *get_md(struct evlist *evlist, int cpu)
 {
 	int i;
 
@@ -996,7 +996,7 @@ static struct perf_mmap *get_md(struct perf_evlist *evlist, int cpu)
 static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 					  PyObject *args, PyObject *kwargs)
 {
-	struct perf_evlist *evlist = &pevlist->evlist;
+	struct evlist *evlist = &pevlist->evlist;
 	union perf_event *event;
 	int sample_id_all = 1, cpu;
 	static char *kwlist[] = { "cpu", "sample_id_all", NULL };
@@ -1049,7 +1049,7 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 static PyObject *pyrf_evlist__open(struct pyrf_evlist *pevlist,
 				   PyObject *args, PyObject *kwargs)
 {
-	struct perf_evlist *evlist = &pevlist->evlist;
+	struct evlist *evlist = &pevlist->evlist;
 	int group = 0;
 	static char *kwlist[] = { "group", NULL };
 
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index ef8f686729fd..a550d78a0b4d 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -13,7 +13,7 @@ typedef void (*setup_probe_fn_t)(struct evsel *evsel);
 
 static int perf_do_probe_api(setup_probe_fn_t fn, int cpu, const char *str)
 {
-	struct perf_evlist *evlist;
+	struct evlist *evlist;
 	struct evsel *evsel;
 	unsigned long flags = perf_event_open_cloexec_flag();
 	int err = -EAGAIN, fd;
@@ -132,7 +132,7 @@ bool perf_can_record_cpu_wide(void)
 	return true;
 }
 
-void perf_evlist__config(struct perf_evlist *evlist, struct record_opts *opts,
+void perf_evlist__config(struct evlist *evlist, struct record_opts *opts,
 			 struct callchain_param *callchain)
 {
 	struct evsel *evsel;
@@ -256,9 +256,9 @@ int record_opts__config(struct record_opts *opts)
 	return record_opts__config_freq(opts);
 }
 
-bool perf_evlist__can_select_event(struct perf_evlist *evlist, const char *str)
+bool perf_evlist__can_select_event(struct evlist *evlist, const char *str)
 {
-	struct perf_evlist *temp_evlist;
+	struct evlist *temp_evlist;
 	struct evsel *evsel;
 	int err, fd, cpu;
 	bool ret = false;
diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
index 159a08220947..6c709647cd8e 100644
--- a/tools/perf/util/s390-sample-raw.c
+++ b/tools/perf/util/s390-sample-raw.c
@@ -200,7 +200,7 @@ static void s390_cpumcfdg_dump(struct perf_sample *sample)
  * its raw data.
  * The function is only invoked when the dump flag -D is set.
  */
-void perf_evlist__s390_sample_raw(struct perf_evlist *evlist, union perf_event *event,
+void perf_evlist__s390_sample_raw(struct evlist *evlist, union perf_event *event,
 				  struct perf_sample *sample)
 {
 	struct evsel *ev_bc000;
diff --git a/tools/perf/util/sample-raw.c b/tools/perf/util/sample-raw.c
index c21e1311fb0f..e84bbe0e441a 100644
--- a/tools/perf/util/sample-raw.c
+++ b/tools/perf/util/sample-raw.c
@@ -9,7 +9,7 @@
  * Check platform the perf data file was created on and perform platform
  * specific interpretation.
  */
-void perf_evlist__init_trace_event_sample_raw(struct perf_evlist *evlist)
+void perf_evlist__init_trace_event_sample_raw(struct evlist *evlist)
 {
 	const char *arch_pf = perf_env__arch(evlist->env);
 
diff --git a/tools/perf/util/sample-raw.h b/tools/perf/util/sample-raw.h
index 95d445c87e93..afe1491a117e 100644
--- a/tools/perf/util/sample-raw.h
+++ b/tools/perf/util/sample-raw.h
@@ -2,13 +2,13 @@
 #ifndef __SAMPLE_RAW_H
 #define __SAMPLE_RAW_H 1
 
-struct perf_evlist;
+struct evlist;
 union perf_event;
 struct perf_sample;
 
-void perf_evlist__s390_sample_raw(struct perf_evlist *evlist,
+void perf_evlist__s390_sample_raw(struct evlist *evlist,
 				  union perf_event *event,
 				  struct perf_sample *sample);
 
-void perf_evlist__init_trace_event_sample_raw(struct perf_evlist *evlist);
+void perf_evlist__init_trace_event_sample_raw(struct evlist *evlist);
 #endif /* __PERF_EVLIST_H */
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index e9d1cf8eb274..c191dc152175 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -300,7 +300,7 @@ static int process_event_synth_tracing_data_stub(struct perf_session *session
 
 static int process_event_synth_attr_stub(struct perf_tool *tool __maybe_unused,
 					 union perf_event *event __maybe_unused,
-					 struct perf_evlist **pevlist
+					 struct evlist **pevlist
 					 __maybe_unused)
 {
 	dump_printf(": unhandled!\n");
@@ -309,7 +309,7 @@ static int process_event_synth_attr_stub(struct perf_tool *tool __maybe_unused,
 
 static int process_event_synth_event_update_stub(struct perf_tool *tool __maybe_unused,
 						 union perf_event *event __maybe_unused,
-						 struct perf_evlist **pevlist
+						 struct evlist **pevlist
 						 __maybe_unused)
 {
 	if (dump_trace)
@@ -1129,7 +1129,7 @@ static void stack_user__printf(struct stack_dump *dump)
 	       dump->size, dump->offset);
 }
 
-static void perf_evlist__print_tstamp(struct perf_evlist *evlist,
+static void perf_evlist__print_tstamp(struct evlist *evlist,
 				       union perf_event *event,
 				       struct perf_sample *sample)
 {
@@ -1178,7 +1178,7 @@ static void sample_read__printf(struct perf_sample *sample, u64 read_format)
 			sample->read.one.id, sample->read.one.value);
 }
 
-static void dump_event(struct perf_evlist *evlist, union perf_event *event,
+static void dump_event(struct evlist *evlist, union perf_event *event,
 		       u64 file_offset, struct perf_sample *sample)
 {
 	if (!dump_trace)
@@ -1296,7 +1296,7 @@ static struct machine *machines__find_for_cpumode(struct machines *machines,
 	return &machines->host;
 }
 
-static int deliver_sample_value(struct perf_evlist *evlist,
+static int deliver_sample_value(struct evlist *evlist,
 				struct perf_tool *tool,
 				union perf_event *event,
 				struct perf_sample *sample,
@@ -1326,7 +1326,7 @@ static int deliver_sample_value(struct perf_evlist *evlist,
 	return tool->sample(tool, event, sample, sid->evsel, machine);
 }
 
-static int deliver_sample_group(struct perf_evlist *evlist,
+static int deliver_sample_group(struct evlist *evlist,
 				struct perf_tool *tool,
 				union  perf_event *event,
 				struct perf_sample *sample,
@@ -1347,7 +1347,7 @@ static int deliver_sample_group(struct perf_evlist *evlist,
 }
 
 static int
- perf_evlist__deliver_sample(struct perf_evlist *evlist,
+ perf_evlist__deliver_sample(struct evlist *evlist,
 			     struct perf_tool *tool,
 			     union  perf_event *event,
 			     struct perf_sample *sample,
@@ -1372,7 +1372,7 @@ static int
 }
 
 static int machines__deliver_event(struct machines *machines,
-				   struct perf_evlist *evlist,
+				   struct evlist *evlist,
 				   union perf_event *event,
 				   struct perf_sample *sample,
 				   struct perf_tool *tool, u64 file_offset)
@@ -1553,7 +1553,7 @@ int perf_session__deliver_synth_event(struct perf_session *session,
 				      union perf_event *event,
 				      struct perf_sample *sample)
 {
-	struct perf_evlist *evlist = session->evlist;
+	struct evlist *evlist = session->evlist;
 	struct perf_tool *tool = session->tool;
 
 	events_stats__inc(&evlist->stats, event->header.type);
@@ -1631,7 +1631,7 @@ int perf_session__peek_event(struct perf_session *session, off_t file_offset,
 static s64 perf_session__process_event(struct perf_session *session,
 				       union perf_event *event, u64 file_offset)
 {
-	struct perf_evlist *evlist = session->evlist;
+	struct evlist *evlist = session->evlist;
 	struct perf_tool *tool = session->tool;
 	int ret;
 
@@ -2357,7 +2357,7 @@ int __perf_session__set_tracepoints_handlers(struct perf_session *session,
 int perf_event__process_id_index(struct perf_session *session,
 				 union perf_event *event)
 {
-	struct perf_evlist *evlist = session->evlist;
+	struct evlist *evlist = session->evlist;
 	struct id_index_event *ie = &event->id_index;
 	size_t i, nr, max_nr;
 
@@ -2393,7 +2393,7 @@ int perf_event__process_id_index(struct perf_session *session,
 
 int perf_event__synthesize_id_index(struct perf_tool *tool,
 				    perf_event__handler_t process,
-				    struct perf_evlist *evlist,
+				    struct evlist *evlist,
 				    struct machine *machine)
 {
 	union perf_event *ev;
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index 2b2427c4c0b9..79e97d17ea04 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -23,7 +23,7 @@ struct itrace_synth_opts;
 struct perf_session {
 	struct perf_header	header;
 	struct machines		machines;
-	struct perf_evlist	*evlist;
+	struct evlist	*evlist;
 	struct auxtrace		*auxtrace;
 	struct itrace_synth_opts *itrace_synth_opts;
 	struct list_head	auxtrace_index;
@@ -140,7 +140,7 @@ int perf_event__process_id_index(struct perf_session *session,
 
 int perf_event__synthesize_id_index(struct perf_tool *tool,
 				    perf_event__handler_t process,
-				    struct perf_evlist *evlist,
+				    struct evlist *evlist,
 				    struct machine *machine);
 
 #endif /* __PERF_SESSION_H */
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 133d3a45997f..d8e4392d6e18 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2313,7 +2313,7 @@ static int parse_field_name(char *str, char **event, char **field, char **opt)
  *   2. full event name (e.g. sched:sched_switch)
  *   3. partial event name (should not contain ':')
  */
-static struct evsel *find_evsel(struct perf_evlist *evlist, char *event_name)
+static struct evsel *find_evsel(struct evlist *evlist, char *event_name)
 {
 	struct evsel *evsel = NULL;
 	struct evsel *pos;
@@ -2384,7 +2384,7 @@ static int add_evsel_fields(struct evsel *evsel, bool raw_trace, int level)
 	return 0;
 }
 
-static int add_all_dynamic_fields(struct perf_evlist *evlist, bool raw_trace,
+static int add_all_dynamic_fields(struct evlist *evlist, bool raw_trace,
 				  int level)
 {
 	int ret;
@@ -2401,7 +2401,7 @@ static int add_all_dynamic_fields(struct perf_evlist *evlist, bool raw_trace,
 	return 0;
 }
 
-static int add_all_matching_fields(struct perf_evlist *evlist,
+static int add_all_matching_fields(struct evlist *evlist,
 				   char *field_name, bool raw_trace, int level)
 {
 	int ret = -ESRCH;
@@ -2423,7 +2423,7 @@ static int add_all_matching_fields(struct perf_evlist *evlist,
 	return ret;
 }
 
-static int add_dynamic_entry(struct perf_evlist *evlist, const char *tok,
+static int add_dynamic_entry(struct evlist *evlist, const char *tok,
 			     int level)
 {
 	char *str, *event_name, *field_name, *opt_name;
@@ -2567,7 +2567,7 @@ int hpp_dimension__add_output(unsigned col)
 }
 
 int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
-			struct perf_evlist *evlist,
+			struct evlist *evlist,
 			int level)
 {
 	unsigned int i;
@@ -2663,7 +2663,7 @@ int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
 }
 
 static int setup_sort_list(struct perf_hpp_list *list, char *str,
-			   struct perf_evlist *evlist)
+			   struct evlist *evlist)
 {
 	char *tmp, *tok;
 	int ret = 0;
@@ -2709,7 +2709,7 @@ static int setup_sort_list(struct perf_hpp_list *list, char *str,
 	return ret;
 }
 
-static const char *get_default_sort_order(struct perf_evlist *evlist)
+static const char *get_default_sort_order(struct evlist *evlist)
 {
 	const char *default_sort_orders[] = {
 		default_sort_order,
@@ -2743,7 +2743,7 @@ static const char *get_default_sort_order(struct perf_evlist *evlist)
 	return default_sort_orders[sort__mode];
 }
 
-static int setup_sort_order(struct perf_evlist *evlist)
+static int setup_sort_order(struct evlist *evlist)
 {
 	char *new_sort_order;
 
@@ -2804,7 +2804,7 @@ static char *setup_overhead(char *keys)
 	return keys;
 }
 
-static int __setup_sorting(struct perf_evlist *evlist)
+static int __setup_sorting(struct evlist *evlist)
 {
 	char *str;
 	const char *sort_keys;
@@ -3057,7 +3057,7 @@ static int __setup_output_field(void)
 	return ret;
 }
 
-int setup_sorting(struct perf_evlist *evlist)
+int setup_sorting(struct evlist *evlist)
 {
 	int err;
 
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index a0f232151d6f..5e34676a98e8 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -301,9 +301,9 @@ struct block_hist {
 extern struct sort_entry sort_thread;
 extern struct list_head hist_entry__sort_list;
 
-struct perf_evlist;
+struct evlist;
 struct tep_handle;
-int setup_sorting(struct perf_evlist *evlist);
+int setup_sorting(struct evlist *evlist);
 int setup_output_field(void);
 void reset_output_field(void);
 void sort__setup_elide(FILE *fp);
@@ -318,7 +318,7 @@ bool is_strict_order(const char *order);
 int hpp_dimension__add_output(unsigned col);
 void reset_dimensions(void);
 int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
-			struct perf_evlist *evlist,
+			struct evlist *evlist,
 			int level);
 int output_field_add(struct perf_hpp_list *list, char *tok);
 int64_t
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 8da4ddcb2e44..cdfceb5b4d72 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -312,7 +312,7 @@ static void print_metric_header(struct perf_stat_config *config,
 static int first_shadow_cpu(struct perf_stat_config *config,
 			    struct evsel *evsel, int id)
 {
-	struct perf_evlist *evlist = evsel->evlist;
+	struct evlist *evlist = evsel->evlist;
 	int i;
 
 	if (!config->aggr_get_id)
@@ -365,7 +365,7 @@ static void abs_printout(struct perf_stat_config *config,
 
 static bool is_mixed_hw_group(struct evsel *counter)
 {
-	struct perf_evlist *evlist = counter->evlist;
+	struct evlist *evlist = counter->evlist;
 	u32 pmu_type = counter->attr.type;
 	struct evsel *pos;
 
@@ -489,7 +489,7 @@ static void printout(struct perf_stat_config *config, int id, int nr,
 }
 
 static void aggr_update_shadow(struct perf_stat_config *config,
-			       struct perf_evlist *evlist)
+			       struct evlist *evlist)
 {
 	int cpu, s2, id, s;
 	u64 val;
@@ -545,7 +545,7 @@ static void collect_all_aliases(struct perf_stat_config *config, struct evsel *c
 				       bool first),
 			    void *data)
 {
-	struct perf_evlist *evlist = counter->evlist;
+	struct evlist *evlist = counter->evlist;
 	struct evsel *alias;
 
 	alias = list_prepare_entry(counter, &(evlist->entries), node);
@@ -651,7 +651,7 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 }
 
 static void print_aggr(struct perf_stat_config *config,
-		       struct perf_evlist *evlist,
+		       struct evlist *evlist,
 		       char *prefix)
 {
 	bool metric_only = config->metric_only;
@@ -859,7 +859,7 @@ static void print_counter(struct perf_stat_config *config,
 }
 
 static void print_no_aggr_metric(struct perf_stat_config *config,
-				 struct perf_evlist *evlist,
+				 struct evlist *evlist,
 				 char *prefix)
 {
 	int cpu;
@@ -910,7 +910,7 @@ static const char *aggr_header_csv[] = {
 };
 
 static void print_metric_headers(struct perf_stat_config *config,
-				 struct perf_evlist *evlist,
+				 struct evlist *evlist,
 				 const char *prefix, bool no_indent)
 {
 	struct perf_stat_output_ctx out;
@@ -949,7 +949,7 @@ static void print_metric_headers(struct perf_stat_config *config,
 }
 
 static void print_interval(struct perf_stat_config *config,
-			   struct perf_evlist *evlist,
+			   struct evlist *evlist,
 			   char *prefix, struct timespec *ts)
 {
 	bool metric_only = config->metric_only;
@@ -1156,7 +1156,7 @@ static void print_percore(struct perf_stat_config *config,
 }
 
 void
-perf_evlist__print_counters(struct perf_evlist *evlist,
+perf_evlist__print_counters(struct evlist *evlist,
 			    struct perf_stat_config *config,
 			    struct target *_target,
 			    struct timespec *ts,
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 8c19f3149f34..d81bcab2e64c 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -299,7 +299,7 @@ static const char *get_ratio_color(enum grc_type type, double ratio)
 	return color;
 }
 
-static struct evsel *perf_stat__find_event(struct perf_evlist *evsel_list,
+static struct evsel *perf_stat__find_event(struct evlist *evsel_list,
 						const char *name)
 {
 	struct evsel *c2;
@@ -312,7 +312,7 @@ static struct evsel *perf_stat__find_event(struct perf_evlist *evsel_list,
 }
 
 /* Mark MetricExpr target events and link events using them to them. */
-void perf_stat__collect_metric_expr(struct perf_evlist *evsel_list)
+void perf_stat__collect_metric_expr(struct evlist *evsel_list)
 {
 	struct evsel *counter, *leader, **metric_events, *oc;
 	bool found;
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 7acb9a6730fe..efd934ec02c3 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -168,7 +168,7 @@ static int perf_evsel__alloc_stats(struct evsel *evsel, bool alloc_raw)
 	return 0;
 }
 
-int perf_evlist__alloc_stats(struct perf_evlist *evlist, bool alloc_raw)
+int perf_evlist__alloc_stats(struct evlist *evlist, bool alloc_raw)
 {
 	struct evsel *evsel;
 
@@ -184,7 +184,7 @@ int perf_evlist__alloc_stats(struct perf_evlist *evlist, bool alloc_raw)
 	return -1;
 }
 
-void perf_evlist__free_stats(struct perf_evlist *evlist)
+void perf_evlist__free_stats(struct evlist *evlist)
 {
 	struct evsel *evsel;
 
@@ -195,7 +195,7 @@ void perf_evlist__free_stats(struct perf_evlist *evlist)
 	}
 }
 
-void perf_evlist__reset_stats(struct perf_evlist *evlist)
+void perf_evlist__reset_stats(struct evlist *evlist)
 {
 	struct evsel *evsel;
 
@@ -490,7 +490,7 @@ int create_perf_stat_counter(struct evsel *evsel,
 
 int perf_stat_synthesize_config(struct perf_stat_config *config,
 				struct perf_tool *tool,
-				struct perf_evlist *evlist,
+				struct evlist *evlist,
 				perf_event__handler_t process,
 				bool attrs)
 {
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index b64cf0177a91..95b4de7a9d51 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -144,7 +144,7 @@ static inline void init_stats(struct stats *stats)
 }
 
 struct evsel;
-struct perf_evlist;
+struct evlist;
 
 struct perf_aggr_thread_value {
 	struct evsel *counter;
@@ -189,11 +189,11 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 				   struct perf_stat_output_ctx *out,
 				   struct rblist *metric_events,
 				   struct runtime_stat *st);
-void perf_stat__collect_metric_expr(struct perf_evlist *);
+void perf_stat__collect_metric_expr(struct evlist *);
 
-int perf_evlist__alloc_stats(struct perf_evlist *evlist, bool alloc_raw);
-void perf_evlist__free_stats(struct perf_evlist *evlist);
-void perf_evlist__reset_stats(struct perf_evlist *evlist);
+int perf_evlist__alloc_stats(struct evlist *evlist, bool alloc_raw);
+void perf_evlist__free_stats(struct evlist *evlist);
+void perf_evlist__reset_stats(struct evlist *evlist);
 
 int perf_stat_process_counter(struct perf_stat_config *config,
 			      struct evsel *counter);
@@ -212,11 +212,11 @@ int create_perf_stat_counter(struct evsel *evsel,
 			     struct target *target);
 int perf_stat_synthesize_config(struct perf_stat_config *config,
 				struct perf_tool *tool,
-				struct perf_evlist *evlist,
+				struct evlist *evlist,
 				perf_event__handler_t process,
 				bool attrs);
 void
-perf_evlist__print_counters(struct perf_evlist *evlist,
+perf_evlist__print_counters(struct evlist *evlist,
 			    struct perf_stat_config *config,
 			    struct target *_target,
 			    struct timespec *ts,
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index 5d880a6f0a34..7f95dd1d6883 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -8,7 +8,7 @@
 
 struct perf_session;
 union perf_event;
-struct perf_evlist;
+struct evlist;
 struct evsel;
 struct perf_sample;
 struct perf_tool;
@@ -24,7 +24,7 @@ typedef int (*event_op)(struct perf_tool *tool, union perf_event *event,
 
 typedef int (*event_attr_op)(struct perf_tool *tool,
 			     union perf_event *event,
-			     struct perf_evlist **pevlist);
+			     struct evlist **pevlist);
 
 typedef int (*event_op2)(struct perf_session *session, union perf_event *event);
 typedef s64 (*event_op3)(struct perf_session *session, union perf_event *event);
diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
index 7e0f363c0658..2023e0bf6165 100644
--- a/tools/perf/util/top.h
+++ b/tools/perf/util/top.h
@@ -9,13 +9,13 @@
 #include <stdbool.h>
 #include <sys/ioctl.h>
 
-struct perf_evlist;
+struct evlist;
 struct evsel;
 struct perf_session;
 
 struct perf_top {
 	struct perf_tool   tool;
-	struct perf_evlist *evlist;
+	struct evlist *evlist;
 	struct record_opts record_opts;
 	struct annotation_options annotation_opts;
 	/*
-- 
2.21.0

