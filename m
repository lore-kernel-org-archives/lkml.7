Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B324DC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72334216C8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455542;
	bh=1Y7VwLxKsONsjNLN89M47bH/pdGcX0LOXy/gopZszUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M+CqJhyY0TgelzwEv0K4/KRaiy+IsbTYSHalsHwdvqUl9Gc6jj2H1bHC2ImCYhG4h
	 LK/gq735fPwbX/ThDOMXj1mfMLU9EbrgPShKIqllxI8hHhdcHNhrYfFglpmRo96IMg
	 aMZxXKBjwbLd23IxauGPUJT8RcmKzX+He2wk+VWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732120AbfG3C7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 22:59:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732091AbfG3C65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:58:57 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC5862070B;
        Tue, 30 Jul 2019 02:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455536;
        bh=1Y7VwLxKsONsjNLN89M47bH/pdGcX0LOXy/gopZszUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ktjZ6kBmU5FTYr41rsvo1zqX5a8CNrotdXQ/73KV3e74siWRsAh62ytl9/+V5S9St
         1aUK4GnIYk6yM83FNlwrakK0eCgi7ifFe0DFxsqxcfAtHVNTkujs3hnYdkrenUGatK
         MXQ0y3bnI+EwAYoO0vswXqlBq/bRE3S9y3YhZ84U=
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
Subject: [PATCH 048/107] perf evlist: Rename perf_evlist__enable() to evlist__enable()
Date:   Mon, 29 Jul 2019 23:55:11 -0300
Message-Id: <20190730025610.22603-49-acme@kernel.org>
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

Rename perf_evlist__enable() to evlist__enable(), so we don't have a
name clash when we add perf_evlist__enable() in libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-22-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/tests/perf-time-to-tsc.c | 2 +-
 tools/perf/builtin-kvm.c                     | 2 +-
 tools/perf/builtin-record.c                  | 4 ++--
 tools/perf/builtin-stat.c                    | 2 +-
 tools/perf/builtin-top.c                     | 2 +-
 tools/perf/builtin-trace.c                   | 4 ++--
 tools/perf/tests/backward-ring-buffer.c      | 2 +-
 tools/perf/tests/bpf.c                       | 2 +-
 tools/perf/tests/code-reading.c              | 2 +-
 tools/perf/tests/keep-tracking.c             | 4 ++--
 tools/perf/tests/openat-syscall-tp-fields.c  | 2 +-
 tools/perf/tests/perf-record.c               | 2 +-
 tools/perf/tests/sw-clock.c                  | 2 +-
 tools/perf/tests/switch-tracking.c           | 2 +-
 tools/perf/util/evlist.c                     | 4 ++--
 tools/perf/util/evlist.h                     | 2 +-
 16 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
index ea4cf1d367a6..aa5a5c972ce5 100644
--- a/tools/perf/arch/x86/tests/perf-time-to-tsc.c
+++ b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
@@ -97,7 +97,7 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 		goto out_err;
 	}
 
-	perf_evlist__enable(evlist);
+	evlist__enable(evlist);
 
 	comm1 = "Test COMM 1";
 	CHECK__(prctl(PR_SET_NAME, (unsigned long)comm1, 0, 0, 0));
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 6a0573a9c16b..9207bd49583e 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -972,7 +972,7 @@ static int kvm_events_live_report(struct perf_kvm_stat *kvm)
 		goto out;
 
 	/* everything is good - enable the events and process */
-	perf_evlist__enable(kvm->evlist);
+	evlist__enable(kvm->evlist);
 
 	while (!done) {
 		struct fdarray *fda = &kvm->evlist->pollfd;
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 7f933997b6d0..8e20ead0ddbe 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1453,7 +1453,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	 * so don't spoil it by prematurely enabling them.
 	 */
 	if (!target__none(&opts->target) && !opts->initial_delay)
-		perf_evlist__enable(rec->evlist);
+		evlist__enable(rec->evlist);
 
 	/*
 	 * Let the child rip
@@ -1506,7 +1506,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 
 	if (opts->initial_delay) {
 		usleep(opts->initial_delay * USEC_PER_MSEC);
-		perf_evlist__enable(rec->evlist);
+		evlist__enable(rec->evlist);
 	}
 
 	trigger_ready(&auxtrace_snapshot_trigger);
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index bdfe138f7aed..c0e9d94b6dd5 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -362,7 +362,7 @@ static void enable_counters(void)
 	 * - we have initial delay configured
 	 */
 	if (!target__none(&target) || stat_config.initial_delay)
-		perf_evlist__enable(evsel_list);
+		evlist__enable(evsel_list);
 }
 
 static void disable_counters(void)
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 5886389f6a40..b103f1ba01cb 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1255,7 +1255,7 @@ static int __cmd_top(struct perf_top *top)
 	 * so leave the check here.
 	 */
         if (!target__none(&opts->target))
-                perf_evlist__enable(top->evlist);
+		evlist__enable(top->evlist);
 
 	ret = -1;
 	if (pthread_create(&thread_process, NULL, process_thread, top)) {
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index e508fdb77099..46fab1ff92dc 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3402,14 +3402,14 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		goto out_error_mmap;
 
 	if (!target__none(&trace->opts.target) && !trace->opts.initial_delay)
-		perf_evlist__enable(evlist);
+		evlist__enable(evlist);
 
 	if (forks)
 		perf_evlist__start_workload(evlist);
 
 	if (trace->opts.initial_delay) {
 		usleep(trace->opts.initial_delay * 1000);
-		perf_evlist__enable(evlist);
+		evlist__enable(evlist);
 	}
 
 	trace->multiple_threads = thread_map__pid(evlist->threads, 0) == -1 ||
diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
index 8de2d6ad93ce..f4b45702821d 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -68,7 +68,7 @@ static int do_test(struct evlist *evlist, int mmap_pages,
 		return TEST_FAIL;
 	}
 
-	perf_evlist__enable(evlist);
+	evlist__enable(evlist);
 	testcase();
 	perf_evlist__disable(evlist);
 
diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index b41c41482283..92fed94f4b6c 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -171,7 +171,7 @@ static int do_test(struct bpf_object *obj, int (*func)(void),
 		goto out_delete_evlist;
 	}
 
-	perf_evlist__enable(evlist);
+	evlist__enable(evlist);
 	(*func)();
 	perf_evlist__disable(evlist);
 
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 23abc775a69c..8d38e001160d 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -680,7 +680,7 @@ static int do_test_code_reading(bool try_kcore)
 		goto out_put;
 	}
 
-	perf_evlist__enable(evlist);
+	evlist__enable(evlist);
 
 	do_something();
 
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index c55bc062e200..c333b9c765e8 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -107,7 +107,7 @@ int test__keep_tracking(struct test *test __maybe_unused, int subtest __maybe_un
 	 * enabled.
 	 */
 
-	perf_evlist__enable(evlist);
+	evlist__enable(evlist);
 
 	comm = "Test COMM 1";
 	CHECK__(prctl(PR_SET_NAME, (unsigned long)comm, 0, 0, 0));
@@ -125,7 +125,7 @@ int test__keep_tracking(struct test *test __maybe_unused, int subtest __maybe_un
 	 * disabled with the dummy event still enabled.
 	 */
 
-	perf_evlist__enable(evlist);
+	evlist__enable(evlist);
 
 	evsel = perf_evlist__last(evlist);
 
diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index 233447af9d03..c7182b7840e5 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -74,7 +74,7 @@ int test__syscall_openat_tp_fields(struct test *test __maybe_unused, int subtest
 		goto out_delete_evlist;
 	}
 
-	perf_evlist__enable(evlist);
+	evlist__enable(evlist);
 
 	/*
 	 * Generate the event:
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index f5d1e7f1b58b..67b388e92cba 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -153,7 +153,7 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 	 * Now that all is properly set up, enable the events, they will
 	 * count just on workload.pid, which will start...
 	 */
-	perf_evlist__enable(evlist);
+	evlist__enable(evlist);
 
 	/*
 	 * Now!
diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index 528a2dff06e0..4ab316c04ce7 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -86,7 +86,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 		goto out_delete_evlist;
 	}
 
-	perf_evlist__enable(evlist);
+	evlist__enable(evlist);
 
 	/* collect samples */
 	for (i = 0; i < NR_LOOPS; i++)
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 47f9895ba807..ea214313f22b 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -462,7 +462,7 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 		goto out_err;
 	}
 
-	perf_evlist__enable(evlist);
+	evlist__enable(evlist);
 
 	err = evsel__disable(cpu_clocks_evsel);
 	if (err) {
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 67c288f467f6..94825c37a35f 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -356,7 +356,7 @@ void perf_evlist__disable(struct evlist *evlist)
 	evlist->enabled = false;
 }
 
-void perf_evlist__enable(struct evlist *evlist)
+void evlist__enable(struct evlist *evlist)
 {
 	struct evsel *pos;
 
@@ -371,7 +371,7 @@ void perf_evlist__enable(struct evlist *evlist)
 
 void perf_evlist__toggle_enable(struct evlist *evlist)
 {
-	(evlist->enabled ? perf_evlist__disable : perf_evlist__enable)(evlist);
+	(evlist->enabled ? perf_evlist__disable : evlist__enable)(evlist);
 }
 
 static int perf_evlist__enable_event_cpu(struct evlist *evlist,
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 47e9d26b6774..ab48bbfbca41 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -185,7 +185,7 @@ void perf_evlist__munmap(struct evlist *evlist);
 size_t perf_evlist__mmap_size(unsigned long pages);
 
 void perf_evlist__disable(struct evlist *evlist);
-void perf_evlist__enable(struct evlist *evlist);
+void evlist__enable(struct evlist *evlist);
 void perf_evlist__toggle_enable(struct evlist *evlist);
 
 int perf_evlist__enable_event_idx(struct evlist *evlist,
-- 
2.21.0

