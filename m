Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DF1C76195
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E429B2147A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563708681;
	bh=d1YlIDkZ7imK0KzFgf6IO5Xg4dIs8Swlegj5orSPLxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YJ4nrCwGs71ghVbosgArSBLhf2mo1ZiKx3R2nHc9WT4WFvE6jvsQigYahR8bqDPYR
	 zuEqkvpuGT4f0vh07IbhJK+VZSi6LNwEglXb/AK13KcKytQk3oIBRGBH7XN67dnSpL
	 MbH0a5m4y2QiKfRNJI4xw0+gxfoA//UAoeWrl1JA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfGULbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:31:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56290 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbfGULbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:31:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A254130821B3;
        Sun, 21 Jul 2019 11:31:17 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 833405D9D3;
        Sun, 21 Jul 2019 11:31:13 +0000 (UTC)
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
Subject: [PATCH 55/79] libperf: Add threads to struct perf_evlist
Date:   Sun, 21 Jul 2019 13:24:42 +0200
Message-Id: <20190721112506.12306-56-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Sun, 21 Jul 2019 11:31:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving threads from evlist into perf_evlist struct.

Link: http://lkml.kernel.org/n/tip-w959dr22jjbwti6b54zqkytb@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-ftrace.c                 |  4 +--
 tools/perf/builtin-kvm.c                    |  2 +-
 tools/perf/builtin-record.c                 |  4 +--
 tools/perf/builtin-stat.c                   | 18 +++++------
 tools/perf/builtin-top.c                    |  4 +--
 tools/perf/builtin-trace.c                  |  8 ++---
 tools/perf/lib/include/internal/evlist.h    |  2 ++
 tools/perf/tests/openat-syscall-tp-fields.c |  2 +-
 tools/perf/util/auxtrace.c                  |  6 ++--
 tools/perf/util/evlist.c                    | 36 ++++++++++-----------
 tools/perf/util/evlist.h                    |  1 -
 tools/perf/util/stat.c                      |  2 +-
 12 files changed, 45 insertions(+), 44 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index f481a870e728..ae1466aa3b26 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -156,9 +156,9 @@ static int set_tracing_pid(struct perf_ftrace *ftrace)
 	if (target__has_cpu(&ftrace->target))
 		return 0;
 
-	for (i = 0; i < thread_map__nr(ftrace->evlist->threads); i++) {
+	for (i = 0; i < thread_map__nr(ftrace->evlist->core.threads); i++) {
 		scnprintf(buf, sizeof(buf), "%d",
-			  ftrace->evlist->threads->map[i]);
+			  ftrace->evlist->core.threads->map[i]);
 		if (append_tracing_file("set_ftrace_pid", buf) < 0)
 			return -1;
 	}
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index b9c58a5c1ba6..69d16ac852c3 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1450,7 +1450,7 @@ static int kvm_events_live(struct perf_kvm_stat *kvm,
 	perf_session__set_id_hdr_size(kvm->session);
 	ordered_events__set_copy_on_queue(&kvm->session->ordered_events, true);
 	machine__synthesize_threads(&kvm->session->machines.host, &kvm->opts.target,
-				    kvm->evlist->threads, false, 1);
+				    kvm->evlist->core.threads, false, 1);
 	err = kvm_live_open_events(kvm);
 	if (err)
 		goto out;
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index d4f0430c2f49..d31d7a5a1be3 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1275,7 +1275,7 @@ static int record__synthesize(struct record *rec, bool tail)
 	if (err)
 		goto out;
 
-	err = perf_event__synthesize_thread_map2(&rec->tool, rec->evlist->threads,
+	err = perf_event__synthesize_thread_map2(&rec->tool, rec->evlist->core.threads,
 						 process_synthesized_event,
 						NULL);
 	if (err < 0) {
@@ -1295,7 +1295,7 @@ static int record__synthesize(struct record *rec, bool tail)
 	if (err < 0)
 		pr_warning("Couldn't synthesize bpf events.\n");
 
-	err = __machine__synthesize_threads(machine, tool, &opts->target, rec->evlist->threads,
+	err = __machine__synthesize_threads(machine, tool, &opts->target, rec->evlist->core.threads,
 					    process_synthesized_event, opts->sample_address,
 					    1);
 out:
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d81b0b1ef514..4a94ca131d56 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -263,7 +263,7 @@ static int read_single_counter(struct evsel *counter, int cpu,
  */
 static int read_counter(struct evsel *counter, struct timespec *rs)
 {
-	int nthreads = thread_map__nr(evsel_list->threads);
+	int nthreads = thread_map__nr(evsel_list->core.threads);
 	int ncpus, cpu, thread;
 
 	if (target__has_cpu(&target) && !target__has_per_thread(&target))
@@ -485,15 +485,15 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
                                         ui__warning("%s\n", msg);
                                 goto try_again;
 			} else if (target__has_per_thread(&target) &&
-				   evsel_list->threads &&
-				   evsel_list->threads->err_thread != -1) {
+				   evsel_list->core.threads &&
+				   evsel_list->core.threads->err_thread != -1) {
 				/*
 				 * For global --per-thread case, skip current
 				 * error thread.
 				 */
-				if (!thread_map__remove(evsel_list->threads,
-							evsel_list->threads->err_thread)) {
-					evsel_list->threads->err_thread = -1;
+				if (!thread_map__remove(evsel_list->core.threads,
+							evsel_list->core.threads->err_thread)) {
+					evsel_list->core.threads->err_thread = -1;
 					goto try_again;
 				}
 			}
@@ -579,7 +579,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		enable_counters();
 		while (!done) {
 			nanosleep(&ts, NULL);
-			if (!is_target_alive(&target, evsel_list->threads))
+			if (!is_target_alive(&target, evsel_list->core.threads))
 				break;
 			if (timeout)
 				break;
@@ -1889,10 +1889,10 @@ int cmd_stat(int argc, const char **argv)
 	 * so we could print it out on output.
 	 */
 	if (stat_config.aggr_mode == AGGR_THREAD) {
-		thread_map__read_comms(evsel_list->threads);
+		thread_map__read_comms(evsel_list->core.threads);
 		if (target.system_wide) {
 			if (runtime_stat_new(&stat_config,
-				thread_map__nr(evsel_list->threads))) {
+				thread_map__nr(evsel_list->core.threads))) {
 				goto out;
 			}
 		}
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 947f83e53272..c69ddc67c672 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -990,7 +990,7 @@ static int perf_top__start_counters(struct perf_top *top)
 	evlist__for_each_entry(evlist, counter) {
 try_again:
 		if (evsel__open(counter, top->evlist->core.cpus,
-				     top->evlist->threads) < 0) {
+				     top->evlist->core.threads) < 0) {
 
 			/*
 			 * Specially handle overwrite fall back.
@@ -1222,7 +1222,7 @@ static int __cmd_top(struct perf_top *top)
 		pr_debug("Couldn't synthesize BPF events: Pre-existing BPF programs won't have symbols resolved.\n");
 
 	machine__synthesize_threads(&top->session->machines.host, &opts->target,
-				    top->evlist->threads, false,
+				    top->evlist->core.threads, false,
 				    top->nr_threads_synthesize);
 
 	if (top->nr_threads_synthesize > 1)
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index fdd72aee7817..df7e4979ae72 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1405,7 +1405,7 @@ static int trace__symbols_init(struct trace *trace, struct evlist *evlist)
 		goto out;
 
 	err = __machine__synthesize_threads(trace->host, &trace->tool, &trace->opts.target,
-					    evlist->threads, trace__tool_process, false,
+					    evlist->core.threads, trace__tool_process, false,
 					    1);
 out:
 	if (err)
@@ -3182,7 +3182,7 @@ static int trace__set_filter_pids(struct trace *trace)
 			err = bpf_map__set_filter_pids(trace->filter_pids.map, trace->filter_pids.nr,
 						       trace->filter_pids.entries);
 		}
-	} else if (thread_map__pid(trace->evlist->threads, 0) == -1) {
+	} else if (thread_map__pid(trace->evlist->core.threads, 0) == -1) {
 		err = trace__set_filter_loop_pids(trace);
 	}
 
@@ -3411,8 +3411,8 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		evlist__enable(evlist);
 	}
 
-	trace->multiple_threads = thread_map__pid(evlist->threads, 0) == -1 ||
-				  evlist->threads->nr > 1 ||
+	trace->multiple_threads = thread_map__pid(evlist->core.threads, 0) == -1 ||
+				  evlist->core.threads->nr > 1 ||
 				  perf_evlist__first(evlist)->core.attr.inherit;
 
 	/*
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index f9caab1fe3c3..b7b43dbc9b82 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -3,12 +3,14 @@
 #define __LIBPERF_INTERNAL_EVLIST_H
 
 struct perf_cpu_map;
+struct perf_thread_map;
 
 struct perf_evlist {
 	struct list_head	 entries;
 	int			 nr_entries;
 	bool			 has_user_cpus;
 	struct perf_cpu_map	*cpus;
+	struct perf_thread_map	*threads;
 };
 
 #endif /* __LIBPERF_INTERNAL_EVLIST_H */
diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index 1de79208e690..9c06130d37be 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -58,7 +58,7 @@ int test__syscall_openat_tp_fields(struct test *test __maybe_unused, int subtest
 
 	perf_evsel__config(evsel, &opts, NULL);
 
-	perf_thread_map__set_pid(evlist->threads, 0, getpid());
+	perf_thread_map__set_pid(evlist->core.threads, 0, getpid());
 
 	err = evlist__open(evlist);
 	if (err < 0) {
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 67a2afc5d964..65728cdeefb6 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -131,13 +131,13 @@ void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
 
 	if (per_cpu) {
 		mp->cpu = evlist->core.cpus->map[idx];
-		if (evlist->threads)
-			mp->tid = thread_map__pid(evlist->threads, 0);
+		if (evlist->core.threads)
+			mp->tid = thread_map__pid(evlist->core.threads, 0);
 		else
 			mp->tid = -1;
 	} else {
 		mp->cpu = -1;
-		mp->tid = thread_map__pid(evlist->threads, idx);
+		mp->tid = thread_map__pid(evlist->core.threads, idx);
 	}
 }
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index c568e64e10ce..53eb96d8355d 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -144,9 +144,9 @@ void evlist__delete(struct evlist *evlist)
 	perf_evlist__munmap(evlist);
 	evlist__close(evlist);
 	perf_cpu_map__put(evlist->core.cpus);
-	perf_thread_map__put(evlist->threads);
+	perf_thread_map__put(evlist->core.threads);
 	evlist->core.cpus = NULL;
-	evlist->threads = NULL;
+	evlist->core.threads = NULL;
 	perf_evlist__purge(evlist);
 	perf_evlist__exit(evlist);
 	free(evlist);
@@ -168,7 +168,7 @@ static void __perf_evlist__propagate_maps(struct evlist *evlist,
 	}
 
 	perf_thread_map__put(evsel->core.threads);
-	evsel->core.threads = perf_thread_map__get(evlist->threads);
+	evsel->core.threads = perf_thread_map__get(evlist->core.threads);
 }
 
 static void perf_evlist__propagate_maps(struct evlist *evlist)
@@ -342,7 +342,7 @@ static int perf_evlist__nr_threads(struct evlist *evlist,
 	if (evsel->system_wide)
 		return 1;
 	else
-		return thread_map__nr(evlist->threads);
+		return thread_map__nr(evlist->core.threads);
 }
 
 void evlist__disable(struct evlist *evlist)
@@ -425,7 +425,7 @@ int perf_evlist__enable_event_idx(struct evlist *evlist,
 int perf_evlist__alloc_pollfd(struct evlist *evlist)
 {
 	int nr_cpus = cpu_map__nr(evlist->core.cpus);
-	int nr_threads = thread_map__nr(evlist->threads);
+	int nr_threads = thread_map__nr(evlist->core.threads);
 	int nfds = 0;
 	struct evsel *evsel;
 
@@ -556,8 +556,8 @@ static void perf_evlist__set_sid_idx(struct evlist *evlist,
 		sid->cpu = evlist->core.cpus->map[cpu];
 	else
 		sid->cpu = -1;
-	if (!evsel->system_wide && evlist->threads && thread >= 0)
-		sid->tid = thread_map__pid(evlist->threads, thread);
+	if (!evsel->system_wide && evlist->core.threads && thread >= 0)
+		sid->tid = thread_map__pid(evlist->core.threads, thread);
 	else
 		sid->tid = -1;
 }
@@ -722,7 +722,7 @@ static struct perf_mmap *perf_evlist__alloc_mmap(struct evlist *evlist,
 
 	evlist->nr_mmaps = cpu_map__nr(evlist->core.cpus);
 	if (cpu_map__empty(evlist->core.cpus))
-		evlist->nr_mmaps = thread_map__nr(evlist->threads);
+		evlist->nr_mmaps = thread_map__nr(evlist->core.threads);
 	map = zalloc(evlist->nr_mmaps * sizeof(struct perf_mmap));
 	if (!map)
 		return NULL;
@@ -836,7 +836,7 @@ static int perf_evlist__mmap_per_cpu(struct evlist *evlist,
 {
 	int cpu, thread;
 	int nr_cpus = cpu_map__nr(evlist->core.cpus);
-	int nr_threads = thread_map__nr(evlist->threads);
+	int nr_threads = thread_map__nr(evlist->core.threads);
 
 	pr_debug2("perf event ring buffer mmapped per cpu\n");
 	for (cpu = 0; cpu < nr_cpus; cpu++) {
@@ -864,7 +864,7 @@ static int perf_evlist__mmap_per_thread(struct evlist *evlist,
 					struct mmap_params *mp)
 {
 	int thread;
-	int nr_threads = thread_map__nr(evlist->threads);
+	int nr_threads = thread_map__nr(evlist->core.threads);
 
 	pr_debug2("perf event ring buffer mmapped per thread\n");
 	for (thread = 0; thread < nr_threads; thread++) {
@@ -1015,7 +1015,7 @@ int perf_evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 {
 	struct evsel *evsel;
 	const struct perf_cpu_map *cpus = evlist->core.cpus;
-	const struct perf_thread_map *threads = evlist->threads;
+	const struct perf_thread_map *threads = evlist->core.threads;
 	/*
 	 * Delay setting mp.prot: set it before calling perf_mmap__mmap.
 	 * Its value is decided by evsel's write_backward.
@@ -1121,9 +1121,9 @@ void perf_evlist__set_maps(struct evlist *evlist, struct perf_cpu_map *cpus,
 		evlist->core.cpus = perf_cpu_map__get(cpus);
 	}
 
-	if (threads != evlist->threads) {
-		perf_thread_map__put(evlist->threads);
-		evlist->threads = perf_thread_map__get(threads);
+	if (threads != evlist->core.threads) {
+		perf_thread_map__put(evlist->core.threads);
+		evlist->core.threads = perf_thread_map__get(threads);
 	}
 
 	perf_evlist__propagate_maps(evlist);
@@ -1398,7 +1398,7 @@ int evlist__open(struct evlist *evlist)
 	 * Default: one fd per CPU, all threads, aka systemwide
 	 * as sys_perf_event_open(cpu = -1, thread = -1) is EINVAL
 	 */
-	if (evlist->threads == NULL && evlist->core.cpus == NULL) {
+	if (evlist->core.threads == NULL && evlist->core.cpus == NULL) {
 		err = perf_evlist__create_syswide_maps(evlist);
 		if (err < 0)
 			goto out_err;
@@ -1501,12 +1501,12 @@ int perf_evlist__prepare_workload(struct evlist *evlist, struct target *target,
 	}
 
 	if (target__none(target)) {
-		if (evlist->threads == NULL) {
+		if (evlist->core.threads == NULL) {
 			fprintf(stderr, "FATAL: evlist->threads need to be set at this point (%s:%d).\n",
 				__func__, __LINE__);
 			goto out_close_pipes;
 		}
-		perf_thread_map__set_pid(evlist->threads, 0, evlist->workload.pid);
+		perf_thread_map__set_pid(evlist->core.threads, 0, evlist->workload.pid);
 	}
 
 	close(child_ready_pipe[1]);
@@ -1921,7 +1921,7 @@ int perf_evlist__start_sb_thread(struct evlist *evlist,
 
 	evlist__for_each_entry(evlist, counter) {
 		if (evsel__open(counter, evlist->core.cpus,
-				     evlist->threads) < 0)
+				     evlist->core.threads) < 0)
 			goto out_delete_evlist;
 	}
 
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index fdd8f83eac2d..de2025d198d4 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -43,7 +43,6 @@ struct evlist {
 	struct fdarray	 pollfd;
 	struct perf_mmap *mmap;
 	struct perf_mmap *overwrite_mmap;
-	struct perf_thread_map *threads;
 	struct evsel *selected;
 	struct events_stats stats;
 	struct perf_env	*env;
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 24c9c3015983..799f3c0a9050 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -507,7 +507,7 @@ int perf_stat_synthesize_config(struct perf_stat_config *config,
 	err = perf_event__synthesize_extra_attr(tool, evlist, process,
 						attrs);
 
-	err = perf_event__synthesize_thread_map2(tool, evlist->threads,
+	err = perf_event__synthesize_thread_map2(tool, evlist->core.threads,
 						 process, NULL);
 	if (err < 0) {
 		pr_err("Couldn't synthesize thread map.\n");
-- 
2.21.0

