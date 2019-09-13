Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C70C4CEC7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFAC5214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381054;
	bh=+HevxbgccFOpk+kC8Dy3UpIzY7r38Q7KIpMxLMlVKZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YuENVXl5LYgiCACyW8Jdaob+C+/TwThISCqO0E7qcnxb4ur0V7dDOKtqfZ5csL4Tv
	 djz7vDIIy7E8fiREt0DyphbegoMEL81ONUUoj/e8hsoLk1X94gaoSJTKe5o9eKsF4G
	 ZV7Zd8yTcyHuHH4m7coGCKcuKB0kbFE8xFFxImVc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391114AbfIMNYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:24:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44748 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391101AbfIMNYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:24:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E19BD8980E1;
        Fri, 13 Sep 2019 13:24:09 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E21D85C1D4;
        Fri, 13 Sep 2019 13:24:06 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 04/73] perf tools: Rename perf_evlist__mmap() to evlist__mmap()
Date:   Fri, 13 Sep 2019 15:22:46 +0200
Message-Id: <20190913132355.21634-5-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Fri, 13 Sep 2019 13:24:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename perf_evlist__mmap() to evlist__mmap(), so we don't have a
name clash when we add perf_evlist__mmap() in libperf.

Link: http://lkml.kernel.org/n/tip-ur6h65mwigegj4aanmubwtz2@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
index 181e76dc597a..3644ebd45a46 100644
--- a/tools/perf/arch/x86/tests/perf-time-to-tsc.c
+++ b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
@@ -91,7 +91,7 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 
 	CHECK__(evlist__open(evlist));
 
-	CHECK__(perf_evlist__mmap(evlist, UINT_MAX));
+	CHECK__(evlist__mmap(evlist, UINT_MAX));
 
 	pc = evlist->mmap[0].base;
 	ret = perf_read_tsc_conversion(pc, &tc);
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index cb40c5c38b44..da16349f2808 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1058,7 +1058,7 @@ static int kvm_live_open_events(struct perf_kvm_stat *kvm)
 		goto out;
 	}
 
-	if (perf_evlist__mmap(evlist, kvm->opts.mmap_pages) < 0) {
+	if (evlist__mmap(evlist, kvm->opts.mmap_pages) < 0) {
 		ui__error("Failed to mmap the events: %s\n",
 			  str_error_r(errno, sbuf, sizeof(sbuf)));
 		evlist__close(evlist);
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 949ea29fae66..df16e1ca1f36 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -437,7 +437,7 @@ static int record__mmap_flush_parse(const struct option *opt,
 	if (!opts->mmap_flush)
 		opts->mmap_flush = MMAP_FLUSH_DEFAULT;
 
-	flush_max = perf_evlist__mmap_size(opts->mmap_pages);
+	flush_max = evlist__mmap_size(opts->mmap_pages);
 	flush_max /= 4;
 	if (opts->mmap_flush > flush_max)
 		opts->mmap_flush = flush_max;
@@ -705,7 +705,7 @@ static int record__mmap_evlist(struct record *rec,
 	if (opts->affinity != PERF_AFFINITY_SYS)
 		cpu__setup_cpunode_map();
 
-	if (perf_evlist__mmap_ex(evlist, opts->mmap_pages,
+	if (evlist__mmap_ex(evlist, opts->mmap_pages,
 				 opts->auxtrace_mmap_pages,
 				 opts->auxtrace_snapshot_mode,
 				 opts->nr_cblocks, opts->affinity,
@@ -1976,7 +1976,7 @@ static int record__parse_mmap_pages(const struct option *opt,
 
 static void switch_output_size_warn(struct record *rec)
 {
-	u64 wakeup_size = perf_evlist__mmap_size(rec->opts.mmap_pages);
+	u64 wakeup_size = evlist__mmap_size(rec->opts.mmap_pages);
 	struct switch_output *s = &rec->switch_output;
 
 	wakeup_size /= 2;
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 5802ca9ca849..9adc91d06e16 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1040,7 +1040,7 @@ static int perf_top__start_counters(struct perf_top *top)
 		}
 	}
 
-	if (perf_evlist__mmap(evlist, opts->mmap_pages) < 0) {
+	if (evlist__mmap(evlist, opts->mmap_pages) < 0) {
 		ui__error("Failed to mmap with %d (%s)\n",
 			    errno, str_error_r(errno, msg, sizeof(msg)));
 		goto out_err;
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index fa813187fb0d..c2e842a6467b 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3408,7 +3408,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
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
index 1e755c4f066d..2c2400d93813 100644
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
index 0c10d992d815..ba77eaa215b3 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -105,7 +105,7 @@ int test__keep_tracking(struct test *test __maybe_unused, int subtest __maybe_un
 		goto out_err;
 	}
 
-	CHECK__(perf_evlist__mmap(evlist, UINT_MAX));
+	CHECK__(evlist__mmap(evlist, UINT_MAX));
 
 	/*
 	 * First, test that a 'comm' event can be found when the event is
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 1bca796ac2bd..9b3b11702850 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -100,7 +100,7 @@ int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unuse
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
index 8374979ceb22..f6c2c026988a 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -461,9 +461,9 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
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
index c7e87c588c25..76c1a8417da9 100644
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
index 9a5c90392951..5ca726c15cce 100644
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
index e22013b08337..9b0eaf83212f 100644
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

