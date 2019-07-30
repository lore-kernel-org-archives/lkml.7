Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2273C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650F320578
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455838;
	bh=wCibZumDHMekB7YpyVIk34Ih10MHrRN5VjNOPu7lnYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XeoLB75vaTSR5VoQbJC0cYMcy7lILev2NyRn/yQbqIkCFNBWLHhoAposNQzAr41A+
	 mJpInklLKdyJSJyyxK7s963dWiQ7jUHJ3cltOYqYB7zk0IaQ3L5pd+VwVQYHulEUAP
	 fRuZPnOYWw7JBQ3uO7vGnvyEpEUrlxdvzZ/pajZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732878AbfG3DD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 23:03:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:47608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731928AbfG3C6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:58:12 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBC8C21773;
        Tue, 30 Jul 2019 02:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455490;
        bh=wCibZumDHMekB7YpyVIk34Ih10MHrRN5VjNOPu7lnYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nZhyPxKx4HkAv0I+2Fw/GnzS8g9fy9016+OhUX43vZpWcodz6gVNt8bOHGnjDq75q
         wUC+QZO5ZTjt4nUBckyH8oKoDuRFSXqJMrYfT5I1XEjh0k3jJbXvlLFq3FqxHQGsSg
         m6DBA4i8oliBhJpwfJGogrTn7bHIQMPoEHYwIjHw=
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
Subject: [PATCH 035/107] perf evlist: Rename perf_evlist__new() to evlist__new()
Date:   Mon, 29 Jul 2019 23:54:58 -0300
Message-Id: <20190730025610.22603-36-acme@kernel.org>
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

Rename perf_evlist__new() to evlist__new(), so we don't have a name
clash when we add perf_evlist__new() in libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-9-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/util/kvm-stat.c      | 2 +-
 tools/perf/arch/x86/tests/intel-cqm.c        | 2 +-
 tools/perf/arch/x86/tests/perf-time-to-tsc.c | 2 +-
 tools/perf/builtin-ftrace.c                  | 2 +-
 tools/perf/builtin-kvm.c                     | 2 +-
 tools/perf/builtin-record.c                  | 2 +-
 tools/perf/builtin-stat.c                    | 2 +-
 tools/perf/builtin-top.c                     | 2 +-
 tools/perf/builtin-trace.c                   | 2 +-
 tools/perf/tests/backward-ring-buffer.c      | 2 +-
 tools/perf/tests/bpf.c                       | 2 +-
 tools/perf/tests/code-reading.c              | 2 +-
 tools/perf/tests/event-times.c               | 2 +-
 tools/perf/tests/evsel-roundtrip-name.c      | 4 ++--
 tools/perf/tests/hists_cumulate.c            | 2 +-
 tools/perf/tests/hists_filter.c              | 2 +-
 tools/perf/tests/hists_link.c                | 2 +-
 tools/perf/tests/hists_output.c              | 2 +-
 tools/perf/tests/keep-tracking.c             | 2 +-
 tools/perf/tests/mmap-basic.c                | 2 +-
 tools/perf/tests/openat-syscall-tp-fields.c  | 2 +-
 tools/perf/tests/parse-events.c              | 2 +-
 tools/perf/tests/sw-clock.c                  | 4 ++--
 tools/perf/tests/switch-tracking.c           | 4 ++--
 tools/perf/util/evlist.c                     | 8 ++++----
 tools/perf/util/evlist.h                     | 2 +-
 tools/perf/util/header.c                     | 4 ++--
 tools/perf/util/record.c                     | 4 ++--
 28 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/kvm-stat.c b/tools/perf/arch/powerpc/util/kvm-stat.c
index 28fc0bab370f..f0dbf7b075c8 100644
--- a/tools/perf/arch/powerpc/util/kvm-stat.c
+++ b/tools/perf/arch/powerpc/util/kvm-stat.c
@@ -146,7 +146,7 @@ static int ppc__setup_book3s_hv(struct perf_kvm_stat *kvm,
 /* Wrapper to setup kvm tracepoints */
 static int ppc__setup_kvm_tp(struct perf_kvm_stat *kvm)
 {
-	struct evlist *evlist = perf_evlist__new();
+	struct evlist *evlist = evlist__new();
 
 	if (evlist == NULL)
 		return -ENOMEM;
diff --git a/tools/perf/arch/x86/tests/intel-cqm.c b/tools/perf/arch/x86/tests/intel-cqm.c
index 333b2f0d61e4..8089a33c6c16 100644
--- a/tools/perf/arch/x86/tests/intel-cqm.c
+++ b/tools/perf/arch/x86/tests/intel-cqm.c
@@ -51,7 +51,7 @@ int test__intel_cqm_count_nmi_context(struct test *test __maybe_unused, int subt
 
 	flag = perf_event_open_cloexec_flag();
 
-	evlist = perf_evlist__new();
+	evlist = evlist__new();
 	if (!evlist) {
 		pr_debug("perf_evlist__new failed\n");
 		return TEST_FAIL;
diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
index d7092fc00e3b..da9a3302d8e6 100644
--- a/tools/perf/arch/x86/tests/perf-time-to-tsc.c
+++ b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
@@ -68,7 +68,7 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 	cpus = cpu_map__new(NULL);
 	CHECK_NOT_NULL__(cpus);
 
-	evlist = perf_evlist__new();
+	evlist = evlist__new();
 	CHECK_NOT_NULL__(evlist);
 
 	perf_evlist__set_maps(evlist, cpus, threads);
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 1263987c291a..b8bdc593e5b8 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -495,7 +495,7 @@ int cmd_ftrace(int argc, const char **argv)
 		goto out_delete_filters;
 	}
 
-	ftrace.evlist = perf_evlist__new();
+	ftrace.evlist = evlist__new();
 	if (ftrace.evlist == NULL) {
 		ret = -ENOMEM;
 		goto out_delete_filters;
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 963dddc5853d..ee896b8a9fe8 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1290,7 +1290,7 @@ static struct evlist *kvm_live_event_list(void)
 	int err = -1;
 	const char * const *events_tp;
 
-	evlist = perf_evlist__new();
+	evlist = evlist__new();
 	if (evlist == NULL)
 		return NULL;
 
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index f08d1e6a1651..e8aa8a078dff 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2265,7 +2265,7 @@ int cmd_record(int argc, const char **argv)
 	CPU_ZERO(&rec->affinity_mask);
 	rec->opts.affinity = PERF_AFFINITY_SYS;
 
-	rec->evlist = perf_evlist__new();
+	rec->evlist = evlist__new();
 	if (rec->evlist == NULL)
 		return -ENOMEM;
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 4e61f8a1d22b..ee0dc8088ac0 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1702,7 +1702,7 @@ int cmd_stat(int argc, const char **argv)
 
 	setlocale(LC_ALL, "");
 
-	evsel_list = perf_evlist__new();
+	evsel_list = evlist__new();
 	if (evsel_list == NULL)
 		return -ENOMEM;
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index c29fa1de854f..e4b7146cd666 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1524,7 +1524,7 @@ int cmd_top(int argc, const char **argv)
 	top.annotation_opts.min_pcnt = 5;
 	top.annotation_opts.context  = 4;
 
-	top.evlist = perf_evlist__new();
+	top.evlist = evlist__new();
 	if (top.evlist == NULL)
 		return -ENOMEM;
 
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index f7e7daac3cbe..767b04eaaf45 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4169,7 +4169,7 @@ int cmd_trace(int argc, const char **argv)
 	signal(SIGSEGV, sighandler_dump_stack);
 	signal(SIGFPE, sighandler_dump_stack);
 
-	trace.evlist = perf_evlist__new();
+	trace.evlist = evlist__new();
 	trace.sctbl = syscalltbl__new();
 
 	if (trace.evlist == NULL || trace.sctbl == NULL) {
diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
index 3f9c931069b0..3883b315b25b 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -99,7 +99,7 @@ int test__backward_ring_buffer(struct test *test __maybe_unused, int subtest __m
 	pid[sizeof(pid) - 1] = '\0';
 	opts.target.tid = opts.target.pid = pid;
 
-	evlist = perf_evlist__new();
+	evlist = evlist__new();
 	if (!evlist) {
 		pr_debug("Not enough memory to create evlist\n");
 		return TEST_FAIL;
diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index 95a15b51f95c..d15f62dc4261 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -140,7 +140,7 @@ static int do_test(struct bpf_object *obj, int (*func)(void),
 	opts.target.tid = opts.target.pid = pid;
 
 	/* Instead of perf_evlist__new_default, don't add default events */
-	evlist = perf_evlist__new();
+	evlist = evlist__new();
 	if (!evlist) {
 		pr_debug("Not enough memory to create evlist\n");
 		return TEST_FAIL;
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 168deb9c563e..dd0325eabc25 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -622,7 +622,7 @@ static int do_test_code_reading(bool try_kcore)
 	while (1) {
 		const char *str;
 
-		evlist = perf_evlist__new();
+		evlist = evlist__new();
 		if (!evlist) {
 			pr_debug("perf_evlist__new failed\n");
 			goto out_put;
diff --git a/tools/perf/tests/event-times.c b/tools/perf/tests/event-times.c
index c3545a6efcbc..8d3cf9792d9e 100644
--- a/tools/perf/tests/event-times.c
+++ b/tools/perf/tests/event-times.c
@@ -166,7 +166,7 @@ static int test_times(int (attach)(struct evlist *),
 	struct evsel *evsel;
 	int err = -1, i;
 
-	evlist = perf_evlist__new();
+	evlist = evlist__new();
 	if (!evlist) {
 		pr_debug("failed to create event list\n");
 		goto out_err;
diff --git a/tools/perf/tests/evsel-roundtrip-name.c b/tools/perf/tests/evsel-roundtrip-name.c
index 6cc408b23026..74e79d6b7e96 100644
--- a/tools/perf/tests/evsel-roundtrip-name.c
+++ b/tools/perf/tests/evsel-roundtrip-name.c
@@ -12,7 +12,7 @@ static int perf_evsel__roundtrip_cache_name_test(void)
 	char name[128];
 	int type, op, err = 0, ret = 0, i, idx;
 	struct evsel *evsel;
-	struct evlist *evlist = perf_evlist__new();
+	struct evlist *evlist = evlist__new();
 
         if (evlist == NULL)
                 return -ENOMEM;
@@ -68,7 +68,7 @@ static int __perf_evsel__name_array_test(const char *names[], int nr_names)
 {
 	int i, err;
 	struct evsel *evsel;
-	struct evlist *evlist = perf_evlist__new();
+	struct evlist *evlist = evlist__new();
 
         if (evlist == NULL)
                 return -ENOMEM;
diff --git a/tools/perf/tests/hists_cumulate.c b/tools/perf/tests/hists_cumulate.c
index d7a6b97683d6..897e74b5ed1f 100644
--- a/tools/perf/tests/hists_cumulate.c
+++ b/tools/perf/tests/hists_cumulate.c
@@ -695,7 +695,7 @@ int test__hists_cumulate(struct test *test __maybe_unused, int subtest __maybe_u
 	struct machines machines;
 	struct machine *machine;
 	struct evsel *evsel;
-	struct evlist *evlist = perf_evlist__new();
+	struct evlist *evlist = evlist__new();
 	size_t i;
 	test_fn_t testcases[] = {
 		test1,
diff --git a/tools/perf/tests/hists_filter.c b/tools/perf/tests/hists_filter.c
index 9f0d6af839e9..b0468db74ca3 100644
--- a/tools/perf/tests/hists_filter.c
+++ b/tools/perf/tests/hists_filter.c
@@ -109,7 +109,7 @@ int test__hists_filter(struct test *test __maybe_unused, int subtest __maybe_unu
 	struct machines machines;
 	struct machine *machine;
 	struct evsel *evsel;
-	struct evlist *evlist = perf_evlist__new();
+	struct evlist *evlist = evlist__new();
 
 	TEST_ASSERT_VAL("No memory", evlist);
 
diff --git a/tools/perf/tests/hists_link.c b/tools/perf/tests/hists_link.c
index 6ab27dd3bf3f..878cb5bfbe78 100644
--- a/tools/perf/tests/hists_link.c
+++ b/tools/perf/tests/hists_link.c
@@ -272,7 +272,7 @@ int test__hists_link(struct test *test __maybe_unused, int subtest __maybe_unuse
 	struct machines machines;
 	struct machine *machine = NULL;
 	struct evsel *evsel, *first;
-	struct evlist *evlist = perf_evlist__new();
+	struct evlist *evlist = evlist__new();
 
 	if (evlist == NULL)
                 return -ENOMEM;
diff --git a/tools/perf/tests/hists_output.c b/tools/perf/tests/hists_output.c
index cd36e51cdf3b..87a05e7afb7e 100644
--- a/tools/perf/tests/hists_output.c
+++ b/tools/perf/tests/hists_output.c
@@ -581,7 +581,7 @@ int test__hists_output(struct test *test __maybe_unused, int subtest __maybe_unu
 	struct machines machines;
 	struct machine *machine;
 	struct evsel *evsel;
-	struct evlist *evlist = perf_evlist__new();
+	struct evlist *evlist = evlist__new();
 	size_t i;
 	test_fn_t testcases[] = {
 		test1,
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index e0779f2a340c..4c73377bfccb 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -78,7 +78,7 @@ int test__keep_tracking(struct test *test __maybe_unused, int subtest __maybe_un
 	cpus = cpu_map__new(NULL);
 	CHECK_NOT_NULL__(cpus);
 
-	evlist = perf_evlist__new();
+	evlist = evlist__new();
 	CHECK_NOT_NULL__(evlist);
 
 	perf_evlist__set_maps(evlist, cpus, threads);
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 749b580e9a92..8d1be34fd951 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -61,7 +61,7 @@ int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unuse
 		goto out_free_cpus;
 	}
 
-	evlist = perf_evlist__new();
+	evlist = evlist__new();
 	if (evlist == NULL) {
 		pr_debug("perf_evlist__new\n");
 		goto out_free_cpus;
diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index 69bf0ec2fe5f..141592437520 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -32,7 +32,7 @@ int test__syscall_openat_tp_fields(struct test *test __maybe_unused, int subtest
 	};
 	const char *filename = "/etc/passwd";
 	int flags = O_RDONLY | O_DIRECTORY;
-	struct evlist *evlist = perf_evlist__new();
+	struct evlist *evlist = evlist__new();
 	struct evsel *evsel;
 	int err = -1, i, nr_events = 0, nr_polls = 0;
 	char sbuf[STRERR_BUFSIZE];
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 7409eed11b65..6e81a930b224 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1777,7 +1777,7 @@ static int test_event(struct evlist_test *e)
 		return 0;
 	}
 
-	evlist = perf_evlist__new();
+	evlist = evlist__new();
 	if (evlist == NULL)
 		return -ENOMEM;
 
diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index 69b997eeb639..88a75cbae230 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -43,9 +43,9 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 
 	attr.sample_freq = 500;
 
-	evlist = perf_evlist__new();
+	evlist = evlist__new();
 	if (evlist == NULL) {
-		pr_debug("perf_evlist__new\n");
+		pr_debug("evlist__new\n");
 		return -1;
 	}
 
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 3e26ea36ec29..89bc20b2178a 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -347,9 +347,9 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 		goto out_err;
 	}
 
-	evlist = perf_evlist__new();
+	evlist = evlist__new();
 	if (!evlist) {
-		pr_debug("perf_evlist__new failed!\n");
+		pr_debug("evlist__new failed!\n");
 		goto out_err;
 	}
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 4fcd55c8a8d5..317b2d64ba6d 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -55,7 +55,7 @@ void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
 	evlist->bkw_mmap_state = BKW_MMAP_NOTREADY;
 }
 
-struct evlist *perf_evlist__new(void)
+struct evlist *evlist__new(void)
 {
 	struct evlist *evlist = zalloc(sizeof(*evlist));
 
@@ -67,7 +67,7 @@ struct evlist *perf_evlist__new(void)
 
 struct evlist *perf_evlist__new_default(void)
 {
-	struct evlist *evlist = perf_evlist__new();
+	struct evlist *evlist = evlist__new();
 
 	if (evlist && perf_evlist__add_default(evlist)) {
 		perf_evlist__delete(evlist);
@@ -79,7 +79,7 @@ struct evlist *perf_evlist__new_default(void)
 
 struct evlist *perf_evlist__new_dummy(void)
 {
-	struct evlist *evlist = perf_evlist__new();
+	struct evlist *evlist = evlist__new();
 
 	if (evlist && perf_evlist__add_dummy(evlist)) {
 		perf_evlist__delete(evlist);
@@ -1839,7 +1839,7 @@ int perf_evlist__add_sb_event(struct evlist **evlist,
 	bool new_evlist = (*evlist) == NULL;
 
 	if (*evlist == NULL)
-		*evlist = perf_evlist__new();
+		*evlist = evlist__new();
 	if (*evlist == NULL)
 		return -1;
 
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index d6a3fa461566..60e1c9268e9e 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -65,7 +65,7 @@ struct evsel_str_handler {
 	void	   *handler;
 };
 
-struct evlist *perf_evlist__new(void);
+struct evlist *evlist__new(void);
 struct evlist *perf_evlist__new_default(void);
 struct evlist *perf_evlist__new_dummy(void);
 void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 692fe8ac12ae..5b90786a8436 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3535,7 +3535,7 @@ int perf_session__read_header(struct perf_session *session)
 	int nr_attrs, nr_ids, i, j;
 	int fd = perf_data__fd(data);
 
-	session->evlist = perf_evlist__new();
+	session->evlist = evlist__new();
 	if (session->evlist == NULL)
 		return -ENOMEM;
 
@@ -4016,7 +4016,7 @@ int perf_event__process_attr(struct perf_tool *tool __maybe_unused,
 	struct evlist *evlist = *pevlist;
 
 	if (evlist == NULL) {
-		*pevlist = evlist = perf_evlist__new();
+		*pevlist = evlist = evlist__new();
 		if (evlist == NULL)
 			return -ENOMEM;
 	}
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index a550d78a0b4d..a23c69137dfc 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -19,7 +19,7 @@ static int perf_do_probe_api(setup_probe_fn_t fn, int cpu, const char *str)
 	int err = -EAGAIN, fd;
 	static pid_t pid = -1;
 
-	evlist = perf_evlist__new();
+	evlist = evlist__new();
 	if (!evlist)
 		return -ENOMEM;
 
@@ -264,7 +264,7 @@ bool perf_evlist__can_select_event(struct evlist *evlist, const char *str)
 	bool ret = false;
 	pid_t pid = -1;
 
-	temp_evlist = perf_evlist__new();
+	temp_evlist = evlist__new();
 	if (!temp_evlist)
 		return false;
 
-- 
2.21.0

