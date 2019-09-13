Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01C8C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B59820830
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381114;
	bh=7yWC2T+l6OZRLsVYJHCjFXLEiIOUcPE2B+CTCtnzw3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rOZLPflJmhn/z+MO4TcCACpgHWvpUBUry/LHvmLBBOLP63jrU2Pe7B6mtptl4ljvZ
	 6A7Qm1bfj2wokYJrGtCNWMuUWTCkpTAR7eHTI4Xzjhe42fvNFmmELavvAznnmzBUDI
	 BGmOe6Uke1f0v2nFtfkeo+PJlkv28zrtzGqktkAw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391315AbfIMNZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:25:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60896 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391301AbfIMNZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:25:11 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B2CB83082E06;
        Fri, 13 Sep 2019 13:25:10 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 120FF5C219;
        Fri, 13 Sep 2019 13:25:08 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 28/73] libperf: Add perf_evlist__first/last functions
Date:   Fri, 13 Sep 2019 15:23:10 +0200
Message-Id: <20190913132355.21634-29-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 13 Sep 2019 13:25:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding perf_evlist__first/last functions to libperf,
as internal functions and renaming perf's origins
to evlist__first/last.

Link: http://lkml.kernel.org/n/tip-r8nr8crc812sdt37nu9qp2kb@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/arch/arm/util/cs-etm.c            |   2 +-
 tools/perf/arch/arm64/util/arm-spe.c         |   2 +-
 tools/perf/arch/x86/tests/intel-cqm.c        |   4 +-
 tools/perf/arch/x86/tests/perf-time-to-tsc.c |   2 +-
 tools/perf/arch/x86/util/intel-bts.c         |   2 +-
 tools/perf/arch/x86/util/intel-pt.c          |   6 +-
 tools/perf/builtin-record.c                  |   4 +-
 tools/perf/builtin-script.c                  |   2 +-
 tools/perf/builtin-top.c                     |  10 +-
 tools/perf/builtin-trace.c                   |   2 +-
 tools/perf/lib/include/internal/evlist.h     |  11 ++
 tools/perf/tests/code-reading.c              |   2 +-
 tools/perf/tests/event-times.c               |  14 +--
 tools/perf/tests/event_update.c              |   2 +-
 tools/perf/tests/evsel-roundtrip-name.c      |   2 +-
 tools/perf/tests/hists_cumulate.c            |   2 +-
 tools/perf/tests/hists_link.c                |   4 +-
 tools/perf/tests/hists_output.c              |   2 +-
 tools/perf/tests/keep-tracking.c             |   4 +-
 tools/perf/tests/parse-events.c              | 116 +++++++++----------
 tools/perf/tests/perf-record.c               |   2 +-
 tools/perf/tests/switch-tracking.c           |  14 +--
 tools/perf/tests/task-exit.c                 |   2 +-
 tools/perf/ui/browsers/hists.c               |   6 +-
 tools/perf/util/bpf-loader.c                 |   2 +-
 tools/perf/util/evlist.c                     |  24 ++--
 tools/perf/util/evlist.h                     |  13 ++-
 tools/perf/util/jitdump.c                    |   2 +-
 tools/perf/util/parse-events.c               |   4 +-
 tools/perf/util/record.c                     |   6 +-
 tools/perf/util/sort.c                       |   2 +-
 tools/perf/util/top.c                        |   2 +-
 32 files changed, 145 insertions(+), 129 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 6407edf72edd..f95e52b84991 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -416,7 +416,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 		if (err)
 			goto out;
 
-		tracking_evsel = perf_evlist__last(evlist);
+		tracking_evsel = evlist__last(evlist);
 		perf_evlist__set_tracking_event(evlist, tracking_evsel);
 
 		tracking_evsel->core.attr.freq = 0;
diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 2fcabddd87b5..685dcc43223a 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -129,7 +129,7 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 	if (err)
 		return err;
 
-	tracking_evsel = perf_evlist__last(evlist);
+	tracking_evsel = evlist__last(evlist);
 	perf_evlist__set_tracking_event(evlist, tracking_evsel);
 
 	tracking_evsel->core.attr.freq = 0;
diff --git a/tools/perf/arch/x86/tests/intel-cqm.c b/tools/perf/arch/x86/tests/intel-cqm.c
index 3b5cc3373821..1eed126a1a7b 100644
--- a/tools/perf/arch/x86/tests/intel-cqm.c
+++ b/tools/perf/arch/x86/tests/intel-cqm.c
@@ -63,9 +63,9 @@ int test__intel_cqm_count_nmi_context(struct test *test __maybe_unused, int subt
 		goto out;
 	}
 
-	evsel = perf_evlist__first(evlist);
+	evsel = evlist__first(evlist);
 	if (!evsel) {
-		pr_debug("perf_evlist__first failed\n");
+		pr_debug("evlist__first failed\n");
 		goto out;
 	}
 
diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
index 185bdbf8cb9d..0aa96f531653 100644
--- a/tools/perf/arch/x86/tests/perf-time-to-tsc.c
+++ b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
@@ -83,7 +83,7 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 
 	perf_evlist__config(evlist, &opts, NULL);
 
-	evsel = perf_evlist__first(evlist);
+	evsel = evlist__first(evlist);
 
 	evsel->core.attr.comm = 1;
 	evsel->core.attr.disabled = 1;
diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index 5dd42e6d22f9..c521fd8acddc 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -230,7 +230,7 @@ static int intel_bts_recording_options(struct auxtrace_record *itr,
 		if (err)
 			return err;
 
-		tracking_evsel = perf_evlist__last(evlist);
+		tracking_evsel = evlist__last(evlist);
 
 		perf_evlist__set_tracking_event(evlist, tracking_evsel);
 
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 42f111323c31..a6e8db467c4c 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -416,7 +416,7 @@ static int intel_pt_track_switches(struct evlist *evlist)
 		return err;
 	}
 
-	evsel = perf_evlist__last(evlist);
+	evsel = evlist__last(evlist);
 
 	perf_evsel__set_sample_bit(evsel, CPU);
 	perf_evsel__set_sample_bit(evsel, TIME);
@@ -716,7 +716,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 				if (err)
 					return err;
 
-				switch_evsel = perf_evlist__last(evlist);
+				switch_evsel = evlist__last(evlist);
 
 				switch_evsel->core.attr.freq = 0;
 				switch_evsel->core.attr.sample_period = 1;
@@ -774,7 +774,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 		if (err)
 			return err;
 
-		tracking_evsel = perf_evlist__last(evlist);
+		tracking_evsel = evlist__last(evlist);
 
 		perf_evlist__set_tracking_event(evlist, tracking_evsel);
 
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 68091f3773a8..efad7e6a2dca 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -753,9 +753,9 @@ static int record__open(struct record *rec)
 		if (perf_evlist__add_dummy(evlist))
 			return -ENOMEM;
 
-		pos = perf_evlist__first(evlist);
+		pos = evlist__first(evlist);
 		pos->tracking = 0;
-		pos = perf_evlist__last(evlist);
+		pos = evlist__last(evlist);
 		pos->tracking = 1;
 		pos->core.attr.enable_on_exec = 1;
 	}
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index c602793d5483..e3c7013099c6 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2042,7 +2042,7 @@ static int process_attr(struct perf_tool *tool, union perf_event *event,
 		return err;
 
 	evlist = *pevlist;
-	evsel = perf_evlist__last(*pevlist);
+	evsel = evlist__last(*pevlist);
 
 	if (!evsel->priv) {
 		if (scr->per_event_dump) {
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 5698234cef88..0942e8d4c93b 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -528,7 +528,7 @@ static bool perf_top__handle_keypress(struct perf_top *top, int c)
 				prompt_integer(&counter, "Enter details event counter");
 
 				if (counter >= top->evlist->core.nr_entries) {
-					top->sym_evsel = perf_evlist__first(top->evlist);
+					top->sym_evsel = evlist__first(top->evlist);
 					fprintf(stderr, "Sorry, no such event, using %s.\n", perf_evsel__name(top->sym_evsel));
 					sleep(1);
 					break;
@@ -537,7 +537,7 @@ static bool perf_top__handle_keypress(struct perf_top *top, int c)
 					if (top->sym_evsel->idx == counter)
 						break;
 			} else
-				top->sym_evsel = perf_evlist__first(top->evlist);
+				top->sym_evsel = evlist__first(top->evlist);
 			break;
 		case 'f':
 			prompt_integer(&top->count_filter, "Enter display event count filter");
@@ -959,7 +959,7 @@ static int perf_top__overwrite_check(struct perf_top *top)
 		/* has term for current event */
 		if ((overwrite < 0) && (set >= 0)) {
 			/* if it's first event, set overwrite */
-			if (evsel == perf_evlist__first(evlist))
+			if (evsel == evlist__first(evlist))
 				overwrite = set;
 			else
 				return -1;
@@ -983,7 +983,7 @@ static int perf_top_overwrite_fallback(struct perf_top *top,
 		return 0;
 
 	/* only fall back when first event fails */
-	if (evsel != perf_evlist__first(evlist))
+	if (evsel != evlist__first(evlist))
 		return 0;
 
 	evlist__for_each_entry(evlist, counter)
@@ -1641,7 +1641,7 @@ int cmd_top(int argc, const char **argv)
 		goto out_delete_evlist;
 	}
 
-	top.sym_evsel = perf_evlist__first(top.evlist);
+	top.sym_evsel = evlist__first(top.evlist);
 
 	if (!callchain_param.enabled) {
 		symbol_conf.cumulate_callchain = false;
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 6e9797d85d54..0dc35aa624c5 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3425,7 +3425,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 
 	trace->multiple_threads = perf_thread_map__pid(evlist->core.threads, 0) == -1 ||
 				  evlist->core.threads->nr > 1 ||
-				  perf_evlist__first(evlist)->core.attr.inherit;
+				  evlist__first(evlist)->core.attr.inherit;
 
 	/*
 	 * Now that we already used evsel->core.attr to ask the kernel to setup the
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index c5a06890fd6a..16ae6d6cfb39 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -4,6 +4,7 @@
 
 #include <linux/list.h>
 #include <api/fd/array.h>
+#include <internal/evsel.h>
 
 #define PERF_EVLIST__HLIST_BITS 8
 #define PERF_EVLIST__HLIST_SIZE (1 << PERF_EVLIST__HLIST_BITS)
@@ -55,4 +56,14 @@ struct perf_evlist {
 #define perf_evlist__for_each_entry_reverse(evlist, evsel) \
 	__perf_evlist__for_each_entry_reverse(&(evlist)->entries, evsel)
 
+static inline struct perf_evsel *perf_evlist__first(struct perf_evlist *evlist)
+{
+	return list_entry(evlist->entries.next, struct perf_evsel, node);
+}
+
+static inline struct perf_evsel *perf_evlist__last(struct perf_evlist *evlist)
+{
+	return list_entry(evlist->entries.prev, struct perf_evsel, node);
+}
+
 #endif /* __LIBPERF_INTERNAL_EVLIST_H */
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 72ae94be686e..77dc68a23b70 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -651,7 +651,7 @@ static int do_test_code_reading(bool try_kcore)
 
 		perf_evlist__config(evlist, &opts, NULL);
 
-		evsel = perf_evlist__first(evlist);
+		evsel = evlist__first(evlist);
 
 		evsel->core.attr.comm = 1;
 		evsel->core.attr.disabled = 1;
diff --git a/tools/perf/tests/event-times.c b/tools/perf/tests/event-times.c
index d824a726906c..afba710b2591 100644
--- a/tools/perf/tests/event-times.c
+++ b/tools/perf/tests/event-times.c
@@ -17,7 +17,7 @@
 
 static int attach__enable_on_exec(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__last(evlist);
+	struct evsel *evsel = evlist__last(evlist);
 	struct target target = {
 		.uid = UINT_MAX,
 	};
@@ -59,7 +59,7 @@ static int detach__enable_on_exec(struct evlist *evlist)
 
 static int attach__current_disabled(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__last(evlist);
+	struct evsel *evsel = evlist__last(evlist);
 	struct perf_thread_map *threads;
 	int err;
 
@@ -85,7 +85,7 @@ static int attach__current_disabled(struct evlist *evlist)
 
 static int attach__current_enabled(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__last(evlist);
+	struct evsel *evsel = evlist__last(evlist);
 	struct perf_thread_map *threads;
 	int err;
 
@@ -105,14 +105,14 @@ static int attach__current_enabled(struct evlist *evlist)
 
 static int detach__disable(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__last(evlist);
+	struct evsel *evsel = evlist__last(evlist);
 
 	return evsel__enable(evsel);
 }
 
 static int attach__cpu_disabled(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__last(evlist);
+	struct evsel *evsel = evlist__last(evlist);
 	struct perf_cpu_map *cpus;
 	int err;
 
@@ -141,7 +141,7 @@ static int attach__cpu_disabled(struct evlist *evlist)
 
 static int attach__cpu_enabled(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__last(evlist);
+	struct evsel *evsel = evlist__last(evlist);
 	struct perf_cpu_map *cpus;
 	int err;
 
@@ -181,7 +181,7 @@ static int test_times(int (attach)(struct evlist *),
 		goto out_err;
 	}
 
-	evsel = perf_evlist__last(evlist);
+	evsel = evlist__last(evlist);
 	evsel->core.attr.read_format |=
 		PERF_FORMAT_TOTAL_TIME_ENABLED |
 		PERF_FORMAT_TOTAL_TIME_RUNNING;
diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
index dce929c83062..0c982550799c 100644
--- a/tools/perf/tests/event_update.c
+++ b/tools/perf/tests/event_update.c
@@ -90,7 +90,7 @@ int test__event_update(struct test *test __maybe_unused, int subtest __maybe_unu
 	evlist = perf_evlist__new_default();
 	TEST_ASSERT_VAL("failed to get evlist", evlist);
 
-	evsel = perf_evlist__first(evlist);
+	evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("failed to allos ids",
 			!perf_evsel__alloc_id(&evsel->core, 1, 1));
diff --git a/tools/perf/tests/evsel-roundtrip-name.c b/tools/perf/tests/evsel-roundtrip-name.c
index 5330f106a6ee..956205bf9326 100644
--- a/tools/perf/tests/evsel-roundtrip-name.c
+++ b/tools/perf/tests/evsel-roundtrip-name.c
@@ -34,7 +34,7 @@ static int perf_evsel__roundtrip_cache_name_test(void)
 	}
 
 	idx = 0;
-	evsel = perf_evlist__first(evlist);
+	evsel = evlist__first(evlist);
 
 	for (type = 0; type < PERF_COUNT_HW_CACHE_MAX; type++) {
 		for (op = 0; op < PERF_COUNT_HW_CACHE_OP_MAX; op++) {
diff --git a/tools/perf/tests/hists_cumulate.c b/tools/perf/tests/hists_cumulate.c
index fa55b7bad3af..6367c8f6ca22 100644
--- a/tools/perf/tests/hists_cumulate.c
+++ b/tools/perf/tests/hists_cumulate.c
@@ -721,7 +721,7 @@ int test__hists_cumulate(struct test *test __maybe_unused, int subtest __maybe_u
 	if (verbose > 1)
 		machine__fprintf(machine, stderr);
 
-	evsel = perf_evlist__first(evlist);
+	evsel = evlist__first(evlist);
 
 	for (i = 0; i < ARRAY_SIZE(testcases); i++) {
 		err = testcases[i](evsel, machine);
diff --git a/tools/perf/tests/hists_link.c b/tools/perf/tests/hists_link.c
index 8be4d0b61e3a..a6d9126cf9b6 100644
--- a/tools/perf/tests/hists_link.c
+++ b/tools/perf/tests/hists_link.c
@@ -310,8 +310,8 @@ int test__hists_link(struct test *test __maybe_unused, int subtest __maybe_unuse
 			print_hists_in(hists);
 	}
 
-	first = perf_evlist__first(evlist);
-	evsel = perf_evlist__last(evlist);
+	first = evlist__first(evlist);
+	evsel = evlist__last(evlist);
 
 	first_hists = evsel__hists(first);
 	hists = evsel__hists(evsel);
diff --git a/tools/perf/tests/hists_output.c b/tools/perf/tests/hists_output.c
index 3f6dfa212260..38f804ff6452 100644
--- a/tools/perf/tests/hists_output.c
+++ b/tools/perf/tests/hists_output.c
@@ -608,7 +608,7 @@ int test__hists_output(struct test *test __maybe_unused, int subtest __maybe_unu
 	if (verbose > 1)
 		machine__fprintf(machine, stderr);
 
-	evsel = perf_evlist__first(evlist);
+	evsel = evlist__first(evlist);
 
 	for (i = 0; i < ARRAY_SIZE(testcases); i++) {
 		err = testcases[i](evsel, machine);
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index ac44d72e39c3..2623b925b87f 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -93,7 +93,7 @@ int test__keep_tracking(struct test *test __maybe_unused, int subtest __maybe_un
 
 	perf_evlist__config(evlist, &opts, NULL);
 
-	evsel = perf_evlist__first(evlist);
+	evsel = evlist__first(evlist);
 
 	evsel->core.attr.comm = 1;
 	evsel->core.attr.disabled = 1;
@@ -132,7 +132,7 @@ int test__keep_tracking(struct test *test __maybe_unused, int subtest __maybe_un
 
 	evlist__enable(evlist);
 
-	evsel = perf_evlist__last(evlist);
+	evsel = evlist__last(evlist);
 
 	CHECK__(evsel__disable(evsel));
 
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 02ba696fb87f..c95e2a46911a 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -47,7 +47,7 @@ static bool kvm_s390_create_vm_valid(void)
 
 static int test__checkevent_tracepoint(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong number of groups", 0 == evlist->nr_groups);
@@ -78,7 +78,7 @@ static int test__checkevent_tracepoint_multi(struct evlist *evlist)
 
 static int test__checkevent_raw(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
@@ -88,7 +88,7 @@ static int test__checkevent_raw(struct evlist *evlist)
 
 static int test__checkevent_numeric(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", 1 == evsel->core.attr.type);
@@ -98,7 +98,7 @@ static int test__checkevent_numeric(struct evlist *evlist)
 
 static int test__checkevent_symbolic_name(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
@@ -109,7 +109,7 @@ static int test__checkevent_symbolic_name(struct evlist *evlist)
 
 static int test__checkevent_symbolic_name_config(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
@@ -130,7 +130,7 @@ static int test__checkevent_symbolic_name_config(struct evlist *evlist)
 
 static int test__checkevent_symbolic_alias(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
@@ -141,7 +141,7 @@ static int test__checkevent_symbolic_alias(struct evlist *evlist)
 
 static int test__checkevent_genhw(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HW_CACHE == evsel->core.attr.type);
@@ -151,7 +151,7 @@ static int test__checkevent_genhw(struct evlist *evlist)
 
 static int test__checkevent_breakpoint(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
@@ -165,7 +165,7 @@ static int test__checkevent_breakpoint(struct evlist *evlist)
 
 static int test__checkevent_breakpoint_x(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
@@ -178,7 +178,7 @@ static int test__checkevent_breakpoint_x(struct evlist *evlist)
 
 static int test__checkevent_breakpoint_r(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type",
@@ -193,7 +193,7 @@ static int test__checkevent_breakpoint_r(struct evlist *evlist)
 
 static int test__checkevent_breakpoint_w(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type",
@@ -208,7 +208,7 @@ static int test__checkevent_breakpoint_w(struct evlist *evlist)
 
 static int test__checkevent_breakpoint_rw(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type",
@@ -223,7 +223,7 @@ static int test__checkevent_breakpoint_rw(struct evlist *evlist)
 
 static int test__checkevent_tracepoint_modifier(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
@@ -254,7 +254,7 @@ test__checkevent_tracepoint_multi_modifier(struct evlist *evlist)
 
 static int test__checkevent_raw_modifier(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
@@ -266,7 +266,7 @@ static int test__checkevent_raw_modifier(struct evlist *evlist)
 
 static int test__checkevent_numeric_modifier(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
@@ -278,7 +278,7 @@ static int test__checkevent_numeric_modifier(struct evlist *evlist)
 
 static int test__checkevent_symbolic_name_modifier(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
@@ -290,7 +290,7 @@ static int test__checkevent_symbolic_name_modifier(struct evlist *evlist)
 
 static int test__checkevent_exclude_host_modifier(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 	TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
@@ -300,7 +300,7 @@ static int test__checkevent_exclude_host_modifier(struct evlist *evlist)
 
 static int test__checkevent_exclude_guest_modifier(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
 	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
@@ -310,7 +310,7 @@ static int test__checkevent_exclude_guest_modifier(struct evlist *evlist)
 
 static int test__checkevent_symbolic_alias_modifier(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
@@ -322,7 +322,7 @@ static int test__checkevent_symbolic_alias_modifier(struct evlist *evlist)
 
 static int test__checkevent_genhw_modifier(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
@@ -334,7 +334,7 @@ static int test__checkevent_genhw_modifier(struct evlist *evlist)
 
 static int test__checkevent_exclude_idle_modifier(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong exclude idle", evsel->core.attr.exclude_idle);
 	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
@@ -349,7 +349,7 @@ static int test__checkevent_exclude_idle_modifier(struct evlist *evlist)
 
 static int test__checkevent_exclude_idle_modifier_1(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong exclude idle", evsel->core.attr.exclude_idle);
 	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
@@ -364,7 +364,7 @@ static int test__checkevent_exclude_idle_modifier_1(struct evlist *evlist)
 
 static int test__checkevent_breakpoint_modifier(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
@@ -379,7 +379,7 @@ static int test__checkevent_breakpoint_modifier(struct evlist *evlist)
 
 static int test__checkevent_breakpoint_x_modifier(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
@@ -393,7 +393,7 @@ static int test__checkevent_breakpoint_x_modifier(struct evlist *evlist)
 
 static int test__checkevent_breakpoint_r_modifier(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
@@ -407,7 +407,7 @@ static int test__checkevent_breakpoint_r_modifier(struct evlist *evlist)
 
 static int test__checkevent_breakpoint_w_modifier(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
@@ -421,7 +421,7 @@ static int test__checkevent_breakpoint_w_modifier(struct evlist *evlist)
 
 static int test__checkevent_breakpoint_rw_modifier(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
@@ -436,7 +436,7 @@ static int test__checkevent_breakpoint_rw_modifier(struct evlist *evlist)
 static int test__checkevent_pmu(struct evlist *evlist)
 {
 
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
@@ -454,7 +454,7 @@ static int test__checkevent_pmu(struct evlist *evlist)
 
 static int test__checkevent_list(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong number of entries", 3 == evlist->core.nr_entries);
 
@@ -493,7 +493,7 @@ static int test__checkevent_list(struct evlist *evlist)
 
 static int test__checkevent_pmu_name(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 	/* cpu/config=1,name=krava/u */
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
@@ -514,7 +514,7 @@ static int test__checkevent_pmu_name(struct evlist *evlist)
 
 static int test__checkevent_pmu_partial_time_callgraph(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 	/* cpu/config=1,call-graph=fp,time,period=100000/ */
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
@@ -547,7 +547,7 @@ static int test__checkevent_pmu_partial_time_callgraph(struct evlist *evlist)
 
 static int test__checkevent_pmu_events(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
@@ -565,7 +565,7 @@ static int test__checkevent_pmu_events(struct evlist *evlist)
 
 static int test__checkevent_pmu_events_mix(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 	/* pmu-event:u */
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
@@ -643,7 +643,7 @@ static int test__group1(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist->nr_groups);
 
 	/* instructions:k */
-	evsel = leader = perf_evlist__first(evlist);
+	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_INSTRUCTIONS == evsel->core.attr.config);
@@ -685,7 +685,7 @@ static int test__group2(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist->nr_groups);
 
 	/* faults + :ku modifier */
-	evsel = leader = perf_evlist__first(evlist);
+	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_SW_PAGE_FAULTS == evsel->core.attr.config);
@@ -740,7 +740,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong number of groups", 2 == evlist->nr_groups);
 
 	/* group1 syscalls:sys_enter_openat:H */
-	evsel = leader = perf_evlist__first(evlist);
+	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_TRACEPOINT == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong sample_type",
 		PERF_TP_SAMPLE_TYPE == evsel->core.attr.sample_type);
@@ -832,7 +832,7 @@ static int test__group4(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist->nr_groups);
 
 	/* cycles:u + p */
-	evsel = leader = perf_evlist__first(evlist);
+	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
@@ -876,7 +876,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong number of groups", 2 == evlist->nr_groups);
 
 	/* cycles + G */
-	evsel = leader = perf_evlist__first(evlist);
+	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
@@ -962,7 +962,7 @@ static int test__group_gh1(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist->nr_groups);
 
 	/* cycles + :H group modifier */
-	evsel = leader = perf_evlist__first(evlist);
+	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
@@ -1002,7 +1002,7 @@ static int test__group_gh2(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist->nr_groups);
 
 	/* cycles + :G group modifier */
-	evsel = leader = perf_evlist__first(evlist);
+	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
@@ -1042,7 +1042,7 @@ static int test__group_gh3(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist->nr_groups);
 
 	/* cycles:G + :u group modifier */
-	evsel = leader = perf_evlist__first(evlist);
+	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
@@ -1082,7 +1082,7 @@ static int test__group_gh4(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist->nr_groups);
 
 	/* cycles:G + :uG group modifier */
-	evsel = leader = perf_evlist__first(evlist);
+	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
@@ -1121,7 +1121,7 @@ static int test__leader_sample1(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong number of entries", 3 == evlist->core.nr_entries);
 
 	/* cycles - sampling group leader */
-	evsel = leader = perf_evlist__first(evlist);
+	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
@@ -1174,7 +1174,7 @@ static int test__leader_sample2(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 
 	/* instructions - sampling group leader */
-	evsel = leader = perf_evlist__first(evlist);
+	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_INSTRUCTIONS == evsel->core.attr.config);
@@ -1208,7 +1208,7 @@ static int test__leader_sample2(struct evlist *evlist __maybe_unused)
 
 static int test__checkevent_pinned_modifier(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
@@ -1226,7 +1226,7 @@ static int test__pinned_group(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong number of entries", 3 == evlist->core.nr_entries);
 
 	/* cycles - group leader */
-	evsel = leader = perf_evlist__first(evlist);
+	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
@@ -1252,7 +1252,7 @@ static int test__pinned_group(struct evlist *evlist)
 
 static int test__checkevent_breakpoint_len(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
@@ -1267,7 +1267,7 @@ static int test__checkevent_breakpoint_len(struct evlist *evlist)
 
 static int test__checkevent_breakpoint_len_w(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
@@ -1283,7 +1283,7 @@ static int test__checkevent_breakpoint_len_w(struct evlist *evlist)
 static int
 test__checkevent_breakpoint_len_rw_modifier(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
@@ -1295,7 +1295,7 @@ test__checkevent_breakpoint_len_rw_modifier(struct evlist *evlist)
 
 static int test__checkevent_precise_max_modifier(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
@@ -1306,7 +1306,7 @@ static int test__checkevent_precise_max_modifier(struct evlist *evlist)
 
 static int test__checkevent_config_symbol(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "insn") == 0);
 	return 0;
@@ -1314,7 +1314,7 @@ static int test__checkevent_config_symbol(struct evlist *evlist)
 
 static int test__checkevent_config_raw(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "rawpmu") == 0);
 	return 0;
@@ -1322,7 +1322,7 @@ static int test__checkevent_config_raw(struct evlist *evlist)
 
 static int test__checkevent_config_num(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "numpmu") == 0);
 	return 0;
@@ -1330,7 +1330,7 @@ static int test__checkevent_config_num(struct evlist *evlist)
 
 static int test__checkevent_config_cache(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "cachepmu") == 0);
 	return 0;
@@ -1343,7 +1343,7 @@ static bool test__intel_pt_valid(void)
 
 static int test__intel_pt(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "intel_pt//u") == 0);
 	return 0;
@@ -1351,7 +1351,7 @@ static int test__intel_pt(struct evlist *evlist)
 
 static int test__checkevent_complex_name(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong complex name parsing", strcmp(evsel->name, "COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks") == 0);
 	return 0;
@@ -1359,7 +1359,7 @@ static int test__checkevent_complex_name(struct evlist *evlist)
 
 static int test__sym_event_slash(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong type", evsel->core.attr.type == PERF_TYPE_HARDWARE);
 	TEST_ASSERT_VAL("wrong config", evsel->core.attr.config == PERF_COUNT_HW_CPU_CYCLES);
@@ -1369,7 +1369,7 @@ static int test__sym_event_slash(struct evlist *evlist)
 
 static int test__sym_event_dc(struct evlist *evlist)
 {
-	struct evsel *evsel = perf_evlist__first(evlist);
+	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong type", evsel->core.attr.type == PERF_TYPE_HARDWARE);
 	TEST_ASSERT_VAL("wrong config", evsel->core.attr.config == PERF_COUNT_HW_CPU_CYCLES);
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index dbecc66712af..80da5b2c6bdc 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -103,7 +103,7 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 	/*
 	 * Config the evsels, setting attr->comm on the first one, etc.
 	 */
-	evsel = perf_evlist__first(evlist);
+	evsel = evlist__first(evlist);
 	perf_evsel__set_sample_bit(evsel, CPU);
 	perf_evsel__set_sample_bit(evsel, TID);
 	perf_evsel__set_sample_bit(evsel, TIME);
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 115eae0f45f1..29f503820a1e 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -367,7 +367,7 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 		goto out_err;
 	}
 
-	cpu_clocks_evsel = perf_evlist__last(evlist);
+	cpu_clocks_evsel = evlist__last(evlist);
 
 	/* Second event */
 	err = parse_events(evlist, "cycles:u", NULL);
@@ -376,7 +376,7 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 		goto out_err;
 	}
 
-	cycles_evsel = perf_evlist__last(evlist);
+	cycles_evsel = evlist__last(evlist);
 
 	/* Third event */
 	if (!perf_evlist__can_select_event(evlist, sched_switch)) {
@@ -391,7 +391,7 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 		goto out_err;
 	}
 
-	switch_evsel = perf_evlist__last(evlist);
+	switch_evsel = evlist__last(evlist);
 
 	perf_evsel__set_sample_bit(switch_evsel, CPU);
 	perf_evsel__set_sample_bit(switch_evsel, TIME);
@@ -401,12 +401,12 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 	switch_evsel->immediate = true;
 
 	/* Test moving an event to the front */
-	if (cycles_evsel == perf_evlist__first(evlist)) {
+	if (cycles_evsel == evlist__first(evlist)) {
 		pr_debug("cycles event already at front");
 		goto out_err;
 	}
 	perf_evlist__to_front(evlist, cycles_evsel);
-	if (cycles_evsel != perf_evlist__first(evlist)) {
+	if (cycles_evsel != evlist__first(evlist)) {
 		pr_debug("Failed to move cycles event to front");
 		goto out_err;
 	}
@@ -421,7 +421,7 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 		goto out_err;
 	}
 
-	tracking_evsel = perf_evlist__last(evlist);
+	tracking_evsel = evlist__last(evlist);
 
 	perf_evlist__set_tracking_event(evlist, tracking_evsel);
 
@@ -434,7 +434,7 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 	perf_evlist__config(evlist, &opts, NULL);
 
 	/* Check moved event is still at the front */
-	if (cycles_evsel != perf_evlist__first(evlist)) {
+	if (cycles_evsel != evlist__first(evlist)) {
 		pr_debug("Front event no longer at front");
 		goto out_err;
 	}
diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index 76c1a8417da9..81c57a6b627f 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -87,7 +87,7 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 		goto out_delete_evlist;
 	}
 
-	evsel = perf_evlist__first(evlist);
+	evsel = evlist__first(evlist);
 	evsel->core.attr.task = 1;
 #ifdef __s390x__
 	evsel->core.attr.sample_freq = 1000000;
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 589168ca9f62..7a7187e069b4 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3319,13 +3319,13 @@ static int perf_evsel_menu__run(struct evsel_menu *menu,
 			switch (key) {
 			case K_TAB:
 				if (pos->core.node.next == &evlist->core.entries)
-					pos = perf_evlist__first(evlist);
+					pos = evlist__first(evlist);
 				else
 					pos = perf_evsel__next(pos);
 				goto browse_hists;
 			case K_UNTAB:
 				if (pos->core.node.prev == &evlist->core.entries)
-					pos = perf_evlist__last(evlist);
+					pos = evlist__last(evlist);
 				else
 					pos = perf_evsel__prev(pos);
 				goto browse_hists;
@@ -3417,7 +3417,7 @@ int perf_evlist__tui_browse_hists(struct evlist *evlist, const char *help,
 
 single_entry:
 	if (nr_entries == 1) {
-		struct evsel *first = perf_evlist__first(evlist);
+		struct evsel *first = evlist__first(evlist);
 
 		return perf_evsel__hists_browse(first, nr_entries, help,
 						false, hbt, min_pcnt,
diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 37283e865352..10c187b8b8ea 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -1568,7 +1568,7 @@ struct evsel *bpf__setup_output_event(struct evlist *evlist, const char *name)
 			return ERR_PTR(-err);
 		}
 
-		evsel = perf_evlist__last(evlist);
+		evsel = evlist__last(evlist);
 	}
 
 	bpf__for_each_map_named(map, obj, tmp, name) {
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 472cbb47272a..a57e2f9c6e6d 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -104,7 +104,7 @@ struct evlist *perf_evlist__new_dummy(void)
  */
 void perf_evlist__set_id_pos(struct evlist *evlist)
 {
-	struct evsel *first = perf_evlist__first(evlist);
+	struct evsel *first = evlist__first(evlist);
 
 	evlist->id_pos = first->id_pos;
 	evlist->is_pos = first->is_pos;
@@ -558,14 +558,14 @@ struct evsel *perf_evlist__id2evsel(struct evlist *evlist, u64 id)
 	struct perf_sample_id *sid;
 
 	if (evlist->core.nr_entries == 1 || !id)
-		return perf_evlist__first(evlist);
+		return evlist__first(evlist);
 
 	sid = perf_evlist__id2sid(evlist, id);
 	if (sid)
 		return container_of(sid->evsel, struct evsel, core);
 
 	if (!perf_evlist__sample_id_all(evlist))
-		return perf_evlist__first(evlist);
+		return evlist__first(evlist);
 
 	return NULL;
 }
@@ -609,7 +609,7 @@ static int perf_evlist__event2id(struct evlist *evlist,
 struct evsel *perf_evlist__event2evsel(struct evlist *evlist,
 					    union perf_event *event)
 {
-	struct evsel *first = perf_evlist__first(evlist);
+	struct evsel *first = evlist__first(evlist);
 	struct hlist_head *head;
 	struct perf_sample_id *sid;
 	int hash;
@@ -1221,7 +1221,7 @@ u64 perf_evlist__combined_branch_type(struct evlist *evlist)
 
 bool perf_evlist__valid_read_format(struct evlist *evlist)
 {
-	struct evsel *first = perf_evlist__first(evlist), *pos = first;
+	struct evsel *first = evlist__first(evlist), *pos = first;
 	u64 read_format = first->core.attr.read_format;
 	u64 sample_type = first->core.attr.sample_type;
 
@@ -1241,13 +1241,13 @@ bool perf_evlist__valid_read_format(struct evlist *evlist)
 
 u64 perf_evlist__read_format(struct evlist *evlist)
 {
-	struct evsel *first = perf_evlist__first(evlist);
+	struct evsel *first = evlist__first(evlist);
 	return first->core.attr.read_format;
 }
 
 u16 perf_evlist__id_hdr_size(struct evlist *evlist)
 {
-	struct evsel *first = perf_evlist__first(evlist);
+	struct evsel *first = evlist__first(evlist);
 	struct perf_sample *data;
 	u64 sample_type;
 	u16 size = 0;
@@ -1280,7 +1280,7 @@ u16 perf_evlist__id_hdr_size(struct evlist *evlist)
 
 bool perf_evlist__valid_sample_id_all(struct evlist *evlist)
 {
-	struct evsel *first = perf_evlist__first(evlist), *pos = first;
+	struct evsel *first = evlist__first(evlist), *pos = first;
 
 	evlist__for_each_entry_continue(evlist, pos) {
 		if (first->core.attr.sample_id_all != pos->core.attr.sample_id_all)
@@ -1292,7 +1292,7 @@ bool perf_evlist__valid_sample_id_all(struct evlist *evlist)
 
 bool perf_evlist__sample_id_all(struct evlist *evlist)
 {
-	struct evsel *first = perf_evlist__first(evlist);
+	struct evsel *first = evlist__first(evlist);
 	return first->core.attr.sample_id_all;
 }
 
@@ -1567,7 +1567,7 @@ int perf_evlist__strerror_open(struct evlist *evlist,
 				    "Hint:\tThe current value is %d.", value);
 		break;
 	case EINVAL: {
-		struct evsel *first = perf_evlist__first(evlist);
+		struct evsel *first = evlist__first(evlist);
 		int max_freq;
 
 		if (sysctl__read_int("kernel/perf_event_max_sample_rate", &max_freq) < 0)
@@ -1629,7 +1629,7 @@ void perf_evlist__to_front(struct evlist *evlist,
 	struct evsel *evsel, *n;
 	LIST_HEAD(move);
 
-	if (move_evsel == perf_evlist__first(evlist))
+	if (move_evsel == evlist__first(evlist))
 		return;
 
 	evlist__for_each_entry_safe(evlist, n, evsel) {
@@ -1750,7 +1750,7 @@ bool perf_evlist__exclude_kernel(struct evlist *evlist)
 void perf_evlist__force_leader(struct evlist *evlist)
 {
 	if (!evlist->nr_groups) {
-		struct evsel *leader = perf_evlist__first(evlist);
+		struct evsel *leader = evlist__first(evlist);
 
 		perf_evlist__set_leader(evlist);
 		leader->forced_leader = true;
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 7306a0677171..88890e6a3ac7 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -9,6 +9,7 @@
 #include <api/fd/array.h>
 #include <stdio.h>
 #include <internal/evlist.h>
+#include <internal/evsel.h>
 #include "events_stats.h"
 #include "evsel.h"
 #include "mmap.h"
@@ -214,14 +215,18 @@ static inline bool perf_evlist__empty(struct evlist *evlist)
 	return list_empty(&evlist->core.entries);
 }
 
-static inline struct evsel *perf_evlist__first(struct evlist *evlist)
+static inline struct evsel *evlist__first(struct evlist *evlist)
 {
-	return list_entry(evlist->core.entries.next, struct evsel, core.node);
+	struct perf_evsel *evsel = perf_evlist__first(&evlist->core);
+
+	return container_of(evsel, struct evsel, core);
 }
 
-static inline struct evsel *perf_evlist__last(struct evlist *evlist)
+static inline struct evsel *evlist__last(struct evlist *evlist)
 {
-	return list_entry(evlist->core.entries.prev, struct evsel, core.node);
+	struct perf_evsel *evsel = perf_evlist__last(&evlist->core);
+
+	return container_of(evsel, struct evsel, core);
 }
 
 size_t perf_evlist__fprintf(struct evlist *evlist, FILE *fp);
diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index b80f29bfc7bb..c5945068b9c6 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -779,7 +779,7 @@ jit_process(struct perf_session *session,
 	 * track sample_type to compute id_all layout
 	 * perf sets the same sample type to all events as of now
 	 */
-	first = perf_evlist__first(session->evlist);
+	first = evlist__first(session->evlist);
 	jd.sample_type = first->core.attr.sample_type;
 
 	*nbytes = 0;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 403fb5e05108..e2db348639f6 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1936,7 +1936,7 @@ int parse_events(struct evlist *evlist, const char *str,
 
 		perf_evlist__splice_list_tail(evlist, &parse_state.list);
 		evlist->nr_groups += parse_state.nr_groups;
-		last = perf_evlist__last(evlist);
+		last = evlist__last(evlist);
 		last->cmdline_group_boundary = true;
 
 		return 0;
@@ -2050,7 +2050,7 @@ foreach_evsel_in_last_glob(struct evlist *evlist,
 	 * So no need to WARN here, let *func do this.
 	 */
 	if (evlist->core.nr_entries > 0)
-		last = perf_evlist__last(evlist);
+		last = evlist__last(evlist);
 
 	do {
 		err = (*func)(last, arg);
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index 286fe816c0f3..60b29e6e005b 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -32,7 +32,7 @@ static int perf_do_probe_api(setup_probe_fn_t fn, int cpu, const char *str)
 	if (parse_events(evlist, str, NULL))
 		goto out_delete;
 
-	evsel = perf_evlist__first(evlist);
+	evsel = evlist__first(evlist);
 
 	while (1) {
 		fd = sys_perf_event_open(&evsel->core.attr, pid, cpu, -1, flags);
@@ -173,7 +173,7 @@ void perf_evlist__config(struct evlist *evlist, struct record_opts *opts,
 		use_sample_identifier = perf_can_sample_identifier();
 		sample_id = true;
 	} else if (evlist->core.nr_entries > 1) {
-		struct evsel *first = perf_evlist__first(evlist);
+		struct evsel *first = evlist__first(evlist);
 
 		evlist__for_each_entry(evlist, evsel) {
 			if (evsel->core.attr.sample_type == first->core.attr.sample_type)
@@ -278,7 +278,7 @@ bool perf_evlist__can_select_event(struct evlist *evlist, const char *str)
 	if (err)
 		goto out_delete;
 
-	evsel = perf_evlist__last(temp_evlist);
+	evsel = evlist__last(temp_evlist);
 
 	if (!evlist || perf_cpu_map__empty(evlist->core.cpus)) {
 		struct perf_cpu_map *cpus = perf_cpu_map__new(NULL);
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index a2308eb77681..43d1d410854a 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2329,7 +2329,7 @@ static struct evsel *find_evsel(struct evlist *evlist, char *event_name)
 		if (nr > evlist->core.nr_entries)
 			return NULL;
 
-		evsel = perf_evlist__first(evlist);
+		evsel = evlist__first(evlist);
 		while (--nr > 0)
 			evsel = perf_evsel__next(evsel);
 
diff --git a/tools/perf/util/top.c b/tools/perf/util/top.c
index 51fb574998bb..e588194428e8 100644
--- a/tools/perf/util/top.c
+++ b/tools/perf/util/top.c
@@ -72,7 +72,7 @@ size_t perf_top__header_snprintf(struct perf_top *top, char *bf, size_t size)
 	}
 
 	if (top->evlist->core.nr_entries == 1) {
-		struct evsel *first = perf_evlist__first(top->evlist);
+		struct evsel *first = evlist__first(top->evlist);
 		ret += SNPRINTF(bf + ret, size - ret, "%" PRIu64 "%s ",
 				(uint64_t)first->core.attr.sample_period,
 				opts->freq ? "Hz" : "");
-- 
2.21.0

