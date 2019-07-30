Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AAFC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB0CF2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455545;
	bh=m/a20KNWoCXtca7vNyQiktIATRYTnzmJ3vh6Srvm4qg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z5WMQU7Nfy0cvxwZweJwOGDeh6pr3hAewbpq8iEl/O0whZneFWyMaYUGvHKlNfU94
	 2Bpcl5iqFkiXZnw3r5zMIg02XVNs3qg6cPNfq1Ee5prUtNwbfaKxK7k4+y84SWa7aj
	 hcyWOeu4ZEEoD3UQDTBEDDbBGPvCcE8XkVHfHCBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732133AbfG3C7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 22:59:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:48452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732116AbfG3C7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:59:01 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57EAD21726;
        Tue, 30 Jul 2019 02:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455540;
        bh=m/a20KNWoCXtca7vNyQiktIATRYTnzmJ3vh6Srvm4qg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0vDicmet17r2O4/j2zdNZAf21N4GNs+N/i8jd9UwTkxQVVk+9nTWz+G5D7VPitt7B
         aqhKl89RYGGJqK+s3yEOBZxq0zo3gJk1D5EWyS+4WkXlK0BPYrrKpiSqfURgo/WaWr
         vkMNahVMgycBh9sfXNktx3+2hqaS0zTZ4+g0V4YM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 049/107] perf evlist: Rename perf_evlist__disable() to evlist__disable()
Date:   Mon, 29 Jul 2019 23:55:12 -0300
Message-Id: <20190730025610.22603-50-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Rename perf_evlist__disable() to evlist__disable(), so we don't have a
name clash when we add perf_evlist__disable() in libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-23-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/tests/perf-time-to-tsc.c | 2 +-
 tools/perf/builtin-kvm.c                     | 2 +-
 tools/perf/builtin-record.c                  | 2 +-
 tools/perf/builtin-stat.c                    | 2 +-
 tools/perf/builtin-trace.c                   | 4 ++--
 tools/perf/tests/backward-ring-buffer.c      | 2 +-
 tools/perf/tests/bpf.c                       | 2 +-
 tools/perf/tests/code-reading.c              | 2 +-
 tools/perf/tests/keep-tracking.c             | 6 +++---
 tools/perf/tests/sw-clock.c                  | 2 +-
 tools/perf/tests/switch-tracking.c           | 4 ++--
 tools/perf/util/evlist.c                     | 4 ++--
 tools/perf/util/evlist.h                     | 2 +-
 13 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
index aa5a5c972ce5..8b70e9ee341a 100644
--- a/tools/perf/arch/x86/tests/perf-time-to-tsc.c
+++ b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
@@ -107,7 +107,7 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 	comm2 = "Test COMM 2";
 	CHECK__(prctl(PR_SET_NAME, (unsigned long)comm2, 0, 0, 0));
 
-	perf_evlist__disable(evlist);
+	evlist__disable(evlist);
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
 		md = &evlist->mmap[i];
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 9207bd49583e..3370eba0d3f3 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -993,7 +993,7 @@ static int kvm_events_live_report(struct perf_kvm_stat *kvm)
 			err = fdarray__poll(fda, 100);
 	}
 
-	perf_evlist__disable(kvm->evlist);
+	evlist__disable(kvm->evlist);
 
 	if (err == 0) {
 		sort_result(kvm);
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 8e20ead0ddbe..c0962ddfad04 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1605,7 +1605,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		 */
 		if (done && !disabled && !target__none(&opts->target)) {
 			trigger_off(&auxtrace_snapshot_trigger);
-			perf_evlist__disable(rec->evlist);
+			evlist__disable(rec->evlist);
 			disabled = true;
 		}
 	}
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index c0e9d94b6dd5..36e66a4f3c57 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -373,7 +373,7 @@ static void disable_counters(void)
 	 * from counting before reading their constituent counters.
 	 */
 	if (!target__none(&target))
-		perf_evlist__disable(evsel_list);
+		evlist__disable(evsel_list);
 }
 
 static volatile int workload_exec_errno;
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 46fab1ff92dc..51d142594a12 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3451,7 +3451,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 				goto out_disable;
 
 			if (done && !draining) {
-				perf_evlist__disable(evlist);
+				evlist__disable(evlist);
 				draining = true;
 			}
 		}
@@ -3477,7 +3477,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 out_disable:
 	thread__zput(trace->current);
 
-	perf_evlist__disable(evlist);
+	evlist__disable(evlist);
 
 	if (trace->sort_events)
 		ordered_events__flush(&trace->oe.data, OE_FLUSH__FINAL);
diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
index f4b45702821d..9bdf66139099 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -70,7 +70,7 @@ static int do_test(struct evlist *evlist, int mmap_pages,
 
 	evlist__enable(evlist);
 	testcase();
-	perf_evlist__disable(evlist);
+	evlist__disable(evlist);
 
 	err = count_samples(evlist, sample_count, comm_count);
 	perf_evlist__munmap(evlist);
diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index 92fed94f4b6c..e16f927f38b6 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -173,7 +173,7 @@ static int do_test(struct bpf_object *obj, int (*func)(void),
 
 	evlist__enable(evlist);
 	(*func)();
-	perf_evlist__disable(evlist);
+	evlist__disable(evlist);
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
 		union perf_event *event;
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 8d38e001160d..ec4b0bf28270 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -684,7 +684,7 @@ static int do_test_code_reading(bool try_kcore)
 
 	do_something();
 
-	perf_evlist__disable(evlist);
+	evlist__disable(evlist);
 
 	ret = process_events(machine, evlist, &state);
 	if (ret < 0)
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index c333b9c765e8..7bfc859971e5 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -112,7 +112,7 @@ int test__keep_tracking(struct test *test __maybe_unused, int subtest __maybe_un
 	comm = "Test COMM 1";
 	CHECK__(prctl(PR_SET_NAME, (unsigned long)comm, 0, 0, 0));
 
-	perf_evlist__disable(evlist);
+	evlist__disable(evlist);
 
 	found = find_comm(evlist, comm);
 	if (found != 1) {
@@ -134,7 +134,7 @@ int test__keep_tracking(struct test *test __maybe_unused, int subtest __maybe_un
 	comm = "Test COMM 2";
 	CHECK__(prctl(PR_SET_NAME, (unsigned long)comm, 0, 0, 0));
 
-	perf_evlist__disable(evlist);
+	evlist__disable(evlist);
 
 	found = find_comm(evlist, comm);
 	if (found != 1) {
@@ -146,7 +146,7 @@ int test__keep_tracking(struct test *test __maybe_unused, int subtest __maybe_un
 
 out_err:
 	if (evlist) {
-		perf_evlist__disable(evlist);
+		evlist__disable(evlist);
 		evlist__delete(evlist);
 	} else {
 		cpu_map__put(cpus);
diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index 4ab316c04ce7..ba033a6e6c0f 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -92,7 +92,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 	for (i = 0; i < NR_LOOPS; i++)
 		tmp++;
 
-	perf_evlist__disable(evlist);
+	evlist__disable(evlist);
 
 	md = &evlist->mmap[0];
 	if (perf_mmap__read_init(md) < 0)
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index ea214313f22b..d5537edb47db 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -528,7 +528,7 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 		goto out_err;
 	}
 
-	perf_evlist__disable(evlist);
+	evlist__disable(evlist);
 
 	switch_tracking.switch_evsel = switch_evsel;
 	switch_tracking.cycles_evsel = cycles_evsel;
@@ -566,7 +566,7 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 	}
 out:
 	if (evlist) {
-		perf_evlist__disable(evlist);
+		evlist__disable(evlist);
 		evlist__delete(evlist);
 	} else {
 		cpu_map__put(cpus);
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 94825c37a35f..1bedec28e58f 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -343,7 +343,7 @@ static int perf_evlist__nr_threads(struct evlist *evlist,
 		return thread_map__nr(evlist->threads);
 }
 
-void perf_evlist__disable(struct evlist *evlist)
+void evlist__disable(struct evlist *evlist)
 {
 	struct evsel *pos;
 
@@ -371,7 +371,7 @@ void evlist__enable(struct evlist *evlist)
 
 void perf_evlist__toggle_enable(struct evlist *evlist)
 {
-	(evlist->enabled ? perf_evlist__disable : evlist__enable)(evlist);
+	(evlist->enabled ? evlist__disable : evlist__enable)(evlist);
 }
 
 static int perf_evlist__enable_event_cpu(struct evlist *evlist,
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index ab48bbfbca41..99621c056d09 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -184,7 +184,7 @@ void perf_evlist__munmap(struct evlist *evlist);
 
 size_t perf_evlist__mmap_size(unsigned long pages);
 
-void perf_evlist__disable(struct evlist *evlist);
+void evlist__disable(struct evlist *evlist);
 void evlist__enable(struct evlist *evlist);
 void perf_evlist__toggle_enable(struct evlist *evlist);
 
-- 
2.21.0

