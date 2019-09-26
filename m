Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A444C4360D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F66E21D6C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569458047;
	bh=Lb/QpzW+HecqAC1shjrO+OUhwo+OcE8yZmivo2wC58o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KbmPVtFR2KJXoCh6yyueZAyQZ9MAIyUGTOrNmAx4UBYehNFJgl+zGk154pg0KV0Al
	 AyyIQUXmecvlBnxtyC0YonSAoBGI3cMNZf4exAZRmiJCtChFOGLAuHGfacDWw6rHpe
	 usxN+TJ7RxW+JMivub7KWDEguNsv7D4IuNa8LUG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388314AbfIZAeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:34:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388263AbfIZAeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:34:04 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DCFD222C5;
        Thu, 26 Sep 2019 00:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458042;
        bh=Lb/QpzW+HecqAC1shjrO+OUhwo+OcE8yZmivo2wC58o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E5i2/tiRIhTUEY3em/gAwmBeOYC+JifM+KwKYAXbe0xKEWh/Ij4IkZsI7v71xmt3f
         CGDi8HZatJzDVzm5ntPW/LTAdPhgOnHJYem9lNARhZJYNd3R3DdK6Z3lojnyJZP6TH
         gp2qkRdmPQ0xSeDyn2oo1JpaZatO3YiN0jVLzV2U=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 16/66] perf tools: Rename perf_evlist__mmap() to evlist__mmap()
Date:   Wed, 25 Sep 2019 21:31:54 -0300
Message-Id: <20190926003244.13962-17-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Rename perf_evlist__mmap() to evlist__mmap(), so we don't have a name
clash when we add perf_evlist__mmap() in libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/tests/perf-time-to-tsc.c |  2 +-
 tools/perf/builtin-kvm.c                     |  2 +-
 tools/perf/builtin-record.c                  |  6 ++--
 tools/perf/builtin-top.c                     |  2 +-
 tools/perf/builtin-trace.c                   |  2 +-
 tools/perf/tests/backward-ring-buffer.c      |  4 +--
 tools/perf/tests/bpf.c                       |  4 +--
 tools/perf/tests/code-reading.c              |  4 +--
 tools/perf/tests/keep-tracking.c             |  2 +-
 tools/perf/tests/mmap-basic.c                |  2 +-
 tools/perf/tests/openat-syscall-tp-fields.c  |  4 +--
 tools/perf/tests/perf-record.c               |  4 +--
 tools/perf/tests/sw-clock.c                  |  2 +-
 tools/perf/tests/switch-tracking.c           |  4 +--
 tools/perf/tests/task-exit.c                 |  2 +-
 tools/perf/util/evlist.c                     | 30 ++++++++++----------
 tools/perf/util/evlist.h                     |  8 +++---
 tools/perf/util/python.c                     |  2 +-
 18 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
index c83abb1ed0ff..42ae47525a76 100644
--- a/tools/perf/arch/x86/tests/perf-time-to-tsc.c
+++ b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
@@ -90,7 +90,7 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 
 	CHECK__(evlist__open(evlist));
 
-	CHECK__(perf_evlist__mmap(evlist, UINT_MAX));
+	CHECK__(evlist__mmap(evlist, UINT_MAX));
 
 	pc = evlist->mmap[0].base;
 	ret = perf_read_tsc_conversion(pc, &tc);
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 7354b77e9137..72debb7bd20d 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1060,7 +1060,7 @@ static int kvm_live_open_events(struct perf_kvm_stat *kvm)
 		goto out;
 	}
 
-	if (perf_evlist__mmap(evlist, kvm->opts.mmap_pages) < 0) {
+	if (evlist__mmap(evlist, kvm->opts.mmap_pages) < 0) {
 		ui__error("Failed to mmap the events: %s\n",
 			  str_error_r(errno, sbuf, sizeof(sbuf)));
 		evlist__close(evlist);
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 1528fb686f96..093d9ab5633e 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -439,7 +439,7 @@ static int record__mmap_flush_parse(const struct option *opt,
 	if (!opts->mmap_flush)
 		opts->mmap_flush = MMAP_FLUSH_DEFAULT;
 
-	flush_max = perf_evlist__mmap_size(opts->mmap_pages);
+	flush_max = evlist__mmap_size(opts->mmap_pages);
 	flush_max /= 4;
 	if (opts->mmap_flush > flush_max)
 		opts->mmap_flush = flush_max;
@@ -707,7 +707,7 @@ static int record__mmap_evlist(struct record *rec,
 	if (opts->affinity != PERF_AFFINITY_SYS)
 		cpu__setup_cpunode_map();
 
-	if (perf_evlist__mmap_ex(evlist, opts->mmap_pages,
+	if (evlist__mmap_ex(evlist, opts->mmap_pages,
 				 opts->auxtrace_mmap_pages,
 				 opts->auxtrace_snapshot_mode,
 				 opts->nr_cblocks, opts->affinity,
@@ -1980,7 +1980,7 @@ static int record__parse_mmap_pages(const struct option *opt,
 
 static void switch_output_size_warn(struct record *rec)
 {
-	u64 wakeup_size = perf_evlist__mmap_size(rec->opts.mmap_pages);
+	u64 wakeup_size = evlist__mmap_size(rec->opts.mmap_pages);
 	struct switch_output *s = &rec->switch_output;
 
 	wakeup_size /= 2;
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 834a927107c4..771b3ff47dc3 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1042,7 +1042,7 @@ static int perf_top__start_counters(struct perf_top *top)
 		}
 	}
 
-	if (perf_evlist__mmap(evlist, opts->mmap_pages) < 0) {
+	if (evlist__mmap(evlist, opts->mmap_pages) < 0) {
 		ui__error("Failed to mmap with %d (%s)\n",
 			    errno, str_error_r(errno, msg, sizeof(msg)));
 		goto out_err;
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 2f853870d68d..ff989351567d 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3409,7 +3409,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	if (trace->dump.map)
 		bpf_map__fprintf(trace->dump.map, trace->output);
 
-	err = perf_evlist__mmap(evlist, trace->opts.mmap_pages);
+	err = evlist__mmap(evlist, trace->opts.mmap_pages);
 	if (err < 0)
 		goto out_error_mmap;
 
diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
index 0a046096e6f4..f1eb7e9c1d7d 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -63,9 +63,9 @@ static int do_test(struct evlist *evlist, int mmap_pages,
 	int err;
 	char sbuf[STRERR_BUFSIZE];
 
-	err = perf_evlist__mmap(evlist, mmap_pages);
+	err = evlist__mmap(evlist, mmap_pages);
 	if (err < 0) {
-		pr_debug("perf_evlist__mmap: %s\n",
+		pr_debug("evlist__mmap: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
 		return TEST_FAIL;
 	}
diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index cf9776aceb82..964731915498 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -167,9 +167,9 @@ static int do_test(struct bpf_object *obj, int (*func)(void),
 		goto out_delete_evlist;
 	}
 
-	err = perf_evlist__mmap(evlist, opts.mmap_pages);
+	err = evlist__mmap(evlist, opts.mmap_pages);
 	if (err < 0) {
-		pr_debug("perf_evlist__mmap: %s\n",
+		pr_debug("evlist__mmap: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
 		goto out_delete_evlist;
 	}
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index df96cbb9ffe5..413783b69006 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -685,9 +685,9 @@ static int do_test_code_reading(bool try_kcore)
 		break;
 	}
 
-	ret = perf_evlist__mmap(evlist, UINT_MAX);
+	ret = evlist__mmap(evlist, UINT_MAX);
 	if (ret < 0) {
-		pr_debug("perf_evlist__mmap failed\n");
+		pr_debug("evlist__mmap failed\n");
 		goto out_put;
 	}
 
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index 67a87f507bbd..8e2ec5f72042 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -104,7 +104,7 @@ int test__keep_tracking(struct test *test __maybe_unused, int subtest __maybe_un
 		goto out_err;
 	}
 
-	CHECK__(perf_evlist__mmap(evlist, UINT_MAX));
+	CHECK__(evlist__mmap(evlist, UINT_MAX));
 
 	/*
 	 * First, test that a 'comm' event can be found when the event is
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index accca3d78fa3..4d42e455feb7 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -99,7 +99,7 @@ int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unuse
 		expected_nr_events[i] = 1 + rand() % 127;
 	}
 
-	if (perf_evlist__mmap(evlist, 128) < 0) {
+	if (evlist__mmap(evlist, 128) < 0) {
 		pr_debug("failed to mmap events: %d (%s)\n", errno,
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
 		goto out_delete_evlist;
diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index e5ef74d4e925..5c2576174ae9 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -69,9 +69,9 @@ int test__syscall_openat_tp_fields(struct test *test __maybe_unused, int subtest
 		goto out_delete_evlist;
 	}
 
-	err = perf_evlist__mmap(evlist, UINT_MAX);
+	err = evlist__mmap(evlist, UINT_MAX);
 	if (err < 0) {
-		pr_debug("perf_evlist__mmap: %s\n",
+		pr_debug("evlist__mmap: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
 		goto out_delete_evlist;
 	}
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index 49d2d4c5956d..669fd88e7f30 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -143,9 +143,9 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 	 * fds in the same CPU to be injected in the same mmap ring buffer
 	 * (using ioctl(PERF_EVENT_IOC_SET_OUTPUT)).
 	 */
-	err = perf_evlist__mmap(evlist, opts.mmap_pages);
+	err = evlist__mmap(evlist, opts.mmap_pages);
 	if (err < 0) {
-		pr_debug("perf_evlist__mmap: %s\n",
+		pr_debug("evlist__mmap: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
 		goto out_delete_evlist;
 	}
diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index 7abe0b6aabb7..fbff60815be8 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -82,7 +82,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 		goto out_delete_evlist;
 	}
 
-	err = perf_evlist__mmap(evlist, 128);
+	err = evlist__mmap(evlist, 128);
 	if (err < 0) {
 		pr_debug("failed to mmap event: %d (%s)\n", errno,
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index e7888ddd69a3..c92e287e0f53 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -460,9 +460,9 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 		goto out;
 	}
 
-	err = perf_evlist__mmap(evlist, UINT_MAX);
+	err = evlist__mmap(evlist, UINT_MAX);
 	if (err) {
-		pr_debug("perf_evlist__mmap failed!\n");
+		pr_debug("evlist__mmap failed!\n");
 		goto out_err;
 	}
 
diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index cff99707cc9d..718838b5e724 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -106,7 +106,7 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 		goto out_delete_evlist;
 	}
 
-	if (perf_evlist__mmap(evlist, 128) < 0) {
+	if (evlist__mmap(evlist, 128) < 0) {
 		pr_debug("failed to mmap events: %d (%s)\n", errno,
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
 		goto out_delete_evlist;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index ceab9fb7f7f9..e8afe4fdc1b2 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -732,7 +732,7 @@ perf_evlist__should_poll(struct evlist *evlist __maybe_unused,
 	return true;
 }
 
-static int perf_evlist__mmap_per_evsel(struct evlist *evlist, int idx,
+static int evlist__mmap_per_evsel(struct evlist *evlist, int idx,
 				       struct mmap_params *mp, int cpu_idx,
 				       int thread, int *_output, int *_output_overwrite)
 {
@@ -810,7 +810,7 @@ static int perf_evlist__mmap_per_evsel(struct evlist *evlist, int idx,
 	return 0;
 }
 
-static int perf_evlist__mmap_per_cpu(struct evlist *evlist,
+static int evlist__mmap_per_cpu(struct evlist *evlist,
 				     struct mmap_params *mp)
 {
 	int cpu, thread;
@@ -826,7 +826,7 @@ static int perf_evlist__mmap_per_cpu(struct evlist *evlist,
 					      true);
 
 		for (thread = 0; thread < nr_threads; thread++) {
-			if (perf_evlist__mmap_per_evsel(evlist, cpu, mp, cpu,
+			if (evlist__mmap_per_evsel(evlist, cpu, mp, cpu,
 							thread, &output, &output_overwrite))
 				goto out_unmap;
 		}
@@ -839,7 +839,7 @@ static int perf_evlist__mmap_per_cpu(struct evlist *evlist,
 	return -1;
 }
 
-static int perf_evlist__mmap_per_thread(struct evlist *evlist,
+static int evlist__mmap_per_thread(struct evlist *evlist,
 					struct mmap_params *mp)
 {
 	int thread;
@@ -853,7 +853,7 @@ static int perf_evlist__mmap_per_thread(struct evlist *evlist,
 		auxtrace_mmap_params__set_idx(&mp->auxtrace_mp, evlist, thread,
 					      false);
 
-		if (perf_evlist__mmap_per_evsel(evlist, thread, mp, 0, thread,
+		if (evlist__mmap_per_evsel(evlist, thread, mp, 0, thread,
 						&output, &output_overwrite))
 			goto out_unmap;
 	}
@@ -888,7 +888,7 @@ unsigned long perf_event_mlock_kb_in_pages(void)
 	return pages;
 }
 
-size_t perf_evlist__mmap_size(unsigned long pages)
+size_t evlist__mmap_size(unsigned long pages)
 {
 	if (pages == UINT_MAX)
 		pages = perf_event_mlock_kb_in_pages();
@@ -971,7 +971,7 @@ int perf_evlist__parse_mmap_pages(const struct option *opt, const char *str,
 }
 
 /**
- * perf_evlist__mmap_ex - Create mmaps to receive events.
+ * evlist__mmap_ex - Create mmaps to receive events.
  * @evlist: list of events
  * @pages: map length in pages
  * @overwrite: overwrite older events?
@@ -979,7 +979,7 @@ int perf_evlist__parse_mmap_pages(const struct option *opt, const char *str,
  * @auxtrace_overwrite - overwrite older auxtrace data?
  *
  * If @overwrite is %false the user needs to signal event consumption using
- * perf_mmap__write_tail().  Using perf_evlist__mmap_read() does this
+ * perf_mmap__write_tail().  Using evlist__mmap_read() does this
  * automatically.
  *
  * Similarly, if @auxtrace_overwrite is %false the user needs to signal data
@@ -987,7 +987,7 @@ int perf_evlist__parse_mmap_pages(const struct option *opt, const char *str,
  *
  * Return: %0 on success, negative error code otherwise.
  */
-int perf_evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
+int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 			 unsigned int auxtrace_pages,
 			 bool auxtrace_overwrite, int nr_cblocks, int affinity, int flush,
 			 int comp_level)
@@ -1011,7 +1011,7 @@ int perf_evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 	if (evlist->pollfd.entries == NULL && perf_evlist__alloc_pollfd(evlist) < 0)
 		return -ENOMEM;
 
-	evlist->mmap_len = perf_evlist__mmap_size(pages);
+	evlist->mmap_len = evlist__mmap_size(pages);
 	pr_debug("mmap size %zuB\n", evlist->mmap_len);
 	mp.mask = evlist->mmap_len - page_size - 1;
 
@@ -1026,14 +1026,14 @@ int perf_evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 	}
 
 	if (perf_cpu_map__empty(cpus))
-		return perf_evlist__mmap_per_thread(evlist, &mp);
+		return evlist__mmap_per_thread(evlist, &mp);
 
-	return perf_evlist__mmap_per_cpu(evlist, &mp);
+	return evlist__mmap_per_cpu(evlist, &mp);
 }
 
-int perf_evlist__mmap(struct evlist *evlist, unsigned int pages)
+int evlist__mmap(struct evlist *evlist, unsigned int pages)
 {
-	return perf_evlist__mmap_ex(evlist, pages, 0, false, 0, PERF_AFFINITY_SYS, 1, 0);
+	return evlist__mmap_ex(evlist, pages, 0, false, 0, PERF_AFFINITY_SYS, 1, 0);
 }
 
 int perf_evlist__create_maps(struct evlist *evlist, struct target *target)
@@ -1889,7 +1889,7 @@ int perf_evlist__start_sb_thread(struct evlist *evlist,
 			goto out_delete_evlist;
 	}
 
-	if (perf_evlist__mmap(evlist, UINT_MAX))
+	if (evlist__mmap(evlist, UINT_MAX))
 		goto out_delete_evlist;
 
 	evlist__for_each_entry(evlist, counter) {
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 129786361572..aaf06182c1b8 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -139,7 +139,7 @@ struct perf_sample_id *perf_evlist__id2sid(struct evlist *evlist, u64 id);
 
 void perf_evlist__toggle_bkw_mmap(struct evlist *evlist, enum bkw_mmap_state state);
 
-void perf_evlist__mmap_consume(struct evlist *evlist, int idx);
+void evlist__mmap_consume(struct evlist *evlist, int idx);
 
 int evlist__open(struct evlist *evlist);
 void evlist__close(struct evlist *evlist);
@@ -170,14 +170,14 @@ int perf_evlist__parse_mmap_pages(const struct option *opt,
 
 unsigned long perf_event_mlock_kb_in_pages(void);
 
-int perf_evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
+int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 			 unsigned int auxtrace_pages,
 			 bool auxtrace_overwrite, int nr_cblocks,
 			 int affinity, int flush, int comp_level);
-int perf_evlist__mmap(struct evlist *evlist, unsigned int pages);
+int evlist__mmap(struct evlist *evlist, unsigned int pages);
 void perf_evlist__munmap(struct evlist *evlist);
 
-size_t perf_evlist__mmap_size(unsigned long pages);
+size_t evlist__mmap_size(unsigned long pages);
 
 void evlist__disable(struct evlist *evlist);
 void evlist__enable(struct evlist *evlist);
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 1e1247cffea8..b102d174b868 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -899,7 +899,7 @@ static PyObject *pyrf_evlist__mmap(struct pyrf_evlist *pevlist,
 					 &pages, &overwrite))
 		return NULL;
 
-	if (perf_evlist__mmap(evlist, pages) < 0) {
+	if (evlist__mmap(evlist, pages) < 0) {
 		PyErr_SetFromErrno(PyExc_OSError);
 		return NULL;
 	}
-- 
2.21.0

