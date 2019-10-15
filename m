Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1A0ECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 592AE21848
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbfJOFcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:32:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41909 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbfJOFbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:31:52 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFQs-0008SK-1r; Tue, 15 Oct 2019 07:31:42 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B912D1C03AB;
        Tue, 15 Oct 2019 07:31:36 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:36 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf evlist: Switch to libperf's mmap interface
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191007125344.14268-22-jolsa@kernel.org>
References: <20191007125344.14268-22-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <157111749668.12254.16904392613515629785.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     923d0f1868cb331d660fb569ecd00c39889905f6
Gitweb:        https://git.kernel.org/tip/923d0f1868cb331d660fb569ecd00c39889905f6
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Mon, 07 Oct 2019 14:53:29 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 10 Oct 2019 12:46:04 -03:00

perf evlist: Switch to libperf's mmap interface

Switch to the libperf mmap interface by calling directly
perf_evlist__mmap_ops() and removing perf's evlist__mmap_per_*
functions.

By switching to libperf perf_evlist__mmap() we need to operate over
'struct perf_mmap' in evlist__add_pollfd, so make the related changes
there.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191007125344.14268-22-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 179 +--------------------------------------
 1 file changed, 4 insertions(+), 175 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index d57b684..3f4f11f 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -431,10 +431,10 @@ int evlist__add_pollfd(struct evlist *evlist, int fd)
 static void perf_evlist__munmap_filtered(struct fdarray *fda, int fd,
 					 void *arg __maybe_unused)
 {
-	struct mmap *map = fda->priv[fd].ptr;
+	struct perf_mmap *map = fda->priv[fd].ptr;
 
 	if (map)
-		perf_mmap__put(&map->core);
+		perf_mmap__put(map);
 }
 
 int evlist__filter_pollfd(struct evlist *evlist, short revents_and_mask)
@@ -448,22 +448,6 @@ int evlist__poll(struct evlist *evlist, int timeout)
 	return perf_evlist__poll(&evlist->core, timeout);
 }
 
-static void perf_evlist__set_sid_idx(struct evlist *evlist,
-				     struct evsel *evsel, int idx, int cpu,
-				     int thread)
-{
-	struct perf_sample_id *sid = SID(evsel, cpu, thread);
-	sid->idx = idx;
-	if (evlist->core.cpus && cpu >= 0)
-		sid->cpu = evlist->core.cpus->map[cpu];
-	else
-		sid->cpu = -1;
-	if (!evsel->core.system_wide && evlist->core.threads && thread >= 0)
-		sid->tid = perf_thread_map__pid(evlist->core.threads, thread);
-	else
-		sid->tid = -1;
-}
-
 struct perf_sample_id *perf_evlist__id2sid(struct evlist *evlist, u64 id)
 {
 	struct hlist_head *head;
@@ -652,93 +636,6 @@ static struct mmap *evlist__alloc_mmap(struct evlist *evlist,
 	return map;
 }
 
-static bool
-perf_evlist__should_poll(struct evlist *evlist __maybe_unused,
-			 struct evsel *evsel)
-{
-	if (evsel->core.attr.write_backward)
-		return false;
-	return true;
-}
-
-static int evlist__mmap_per_evsel(struct evlist *evlist, int idx,
-				       struct mmap_params *mp, int cpu_idx,
-				       int thread, int *_output, int *_output_overwrite)
-{
-	struct evsel *evsel;
-	int revent;
-	int evlist_cpu = cpu_map__cpu(evlist->core.cpus, cpu_idx);
-
-	evlist__for_each_entry(evlist, evsel) {
-		struct mmap *maps = evlist->mmap;
-		int *output = _output;
-		int fd;
-		int cpu;
-
-		mp->core.prot = PROT_READ | PROT_WRITE;
-		if (evsel->core.attr.write_backward) {
-			output = _output_overwrite;
-			maps = evlist->overwrite_mmap;
-
-			if (!maps) {
-				maps = evlist__alloc_mmap(evlist, true);
-				if (!maps)
-					return -1;
-				evlist->overwrite_mmap = maps;
-				if (evlist->bkw_mmap_state == BKW_MMAP_NOTREADY)
-					perf_evlist__toggle_bkw_mmap(evlist, BKW_MMAP_RUNNING);
-			}
-			mp->core.prot &= ~PROT_WRITE;
-		}
-
-		if (evsel->core.system_wide && thread)
-			continue;
-
-		cpu = perf_cpu_map__idx(evsel->core.cpus, evlist_cpu);
-		if (cpu == -1)
-			continue;
-
-		fd = FD(evsel, cpu, thread);
-
-		if (*output == -1) {
-			*output = fd;
-
-			if (mmap__mmap(&maps[idx], mp, *output, evlist_cpu) < 0)
-				return -1;
-		} else {
-			if (ioctl(fd, PERF_EVENT_IOC_SET_OUTPUT, *output) != 0)
-				return -1;
-
-			perf_mmap__get(&maps[idx].core);
-		}
-
-		revent = perf_evlist__should_poll(evlist, evsel) ? POLLIN : 0;
-
-		/*
-		 * The system_wide flag causes a selected event to be opened
-		 * always without a pid.  Consequently it will never get a
-		 * POLLHUP, but it is used for tracking in combination with
-		 * other events, so it should not need to be polled anyway.
-		 * Therefore don't add it for polling.
-		 */
-		if (!evsel->core.system_wide &&
-		     perf_evlist__add_pollfd(&evlist->core, fd, &maps[idx], revent) < 0) {
-			perf_mmap__put(&maps[idx].core);
-			return -1;
-		}
-
-		if (evsel->core.attr.read_format & PERF_FORMAT_ID) {
-			if (perf_evlist__id_add_fd(&evlist->core, &evsel->core, cpu, thread,
-						   fd) < 0)
-				return -1;
-			perf_evlist__set_sid_idx(evlist, evsel, idx, cpu,
-						 thread);
-		}
-	}
-
-	return 0;
-}
-
 static void
 perf_evlist__mmap_cb_idx(struct perf_evlist *_evlist,
 			 struct perf_mmap_param *_mp,
@@ -783,61 +680,6 @@ perf_evlist__mmap_cb_mmap(struct perf_mmap *_map, struct perf_mmap_param *_mp,
 	return mmap__mmap(map, mp, output, cpu);
 }
 
-static int evlist__mmap_per_cpu(struct evlist *evlist,
-				     struct mmap_params *mp)
-{
-	int cpu, thread;
-	int nr_cpus = perf_cpu_map__nr(evlist->core.cpus);
-	int nr_threads = perf_thread_map__nr(evlist->core.threads);
-
-	pr_debug2("perf event ring buffer mmapped per cpu\n");
-	for (cpu = 0; cpu < nr_cpus; cpu++) {
-		int output = -1;
-		int output_overwrite = -1;
-
-		auxtrace_mmap_params__set_idx(&mp->auxtrace_mp, evlist, cpu,
-					      true);
-
-		for (thread = 0; thread < nr_threads; thread++) {
-			if (evlist__mmap_per_evsel(evlist, cpu, mp, cpu,
-							thread, &output, &output_overwrite))
-				goto out_unmap;
-		}
-	}
-
-	return 0;
-
-out_unmap:
-	evlist__munmap_nofree(evlist);
-	return -1;
-}
-
-static int evlist__mmap_per_thread(struct evlist *evlist,
-					struct mmap_params *mp)
-{
-	int thread;
-	int nr_threads = perf_thread_map__nr(evlist->core.threads);
-
-	pr_debug2("perf event ring buffer mmapped per thread\n");
-	for (thread = 0; thread < nr_threads; thread++) {
-		int output = -1;
-		int output_overwrite = -1;
-
-		auxtrace_mmap_params__set_idx(&mp->auxtrace_mp, evlist, thread,
-					      false);
-
-		if (evlist__mmap_per_evsel(evlist, thread, mp, 0, thread,
-						&output, &output_overwrite))
-			goto out_unmap;
-	}
-
-	return 0;
-
-out_unmap:
-	evlist__munmap_nofree(evlist);
-	return -1;
-}
-
 unsigned long perf_event_mlock_kb_in_pages(void)
 {
 	unsigned long pages;
@@ -965,9 +807,6 @@ int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 			 bool auxtrace_overwrite, int nr_cblocks, int affinity, int flush,
 			 int comp_level)
 {
-	struct evsel *evsel;
-	const struct perf_cpu_map *cpus = evlist->core.cpus;
-	const struct perf_thread_map *threads = evlist->core.threads;
 	/*
 	 * Delay setting mp.prot: set it before calling perf_mmap__mmap.
 	 * Its value is decided by evsel's write_backward.
@@ -979,7 +818,7 @@ int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 		.flush		= flush,
 		.comp_level	= comp_level
 	};
-	struct perf_evlist_mmap_ops ops __maybe_unused = {
+	struct perf_evlist_mmap_ops ops = {
 		.idx  = perf_evlist__mmap_cb_idx,
 		.get  = perf_evlist__mmap_cb_get,
 		.mmap = perf_evlist__mmap_cb_mmap,
@@ -1000,17 +839,7 @@ int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 	auxtrace_mmap_params__init(&mp.auxtrace_mp, evlist->core.mmap_len,
 				   auxtrace_pages, auxtrace_overwrite);
 
-	evlist__for_each_entry(evlist, evsel) {
-		if ((evsel->core.attr.read_format & PERF_FORMAT_ID) &&
-		    evsel->core.sample_id == NULL &&
-		    perf_evsel__alloc_id(&evsel->core, perf_cpu_map__nr(cpus), threads->nr) < 0)
-			return -ENOMEM;
-	}
-
-	if (perf_cpu_map__empty(cpus))
-		return evlist__mmap_per_thread(evlist, &mp);
-
-	return evlist__mmap_per_cpu(evlist, &mp);
+	return perf_evlist__mmap_ops(&evlist->core, &ops, &mp.core);
 }
 
 int evlist__mmap(struct evlist *evlist, unsigned int pages)
