Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25164ECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA24206CD
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824729;
	bh=agsyZn+ES1JZTA8JfcuFgPSKqI240swWPRPUbd18kHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xNdrzcxN060mnMNqmTjuYpE7lOS9D8wJox11MAn8JvZCGIArv8sn6b7BlA10/LKH5
	 5koXamDcXnZBiQp1U1EJILiod10cbAXxNgCAQLIHitmGuVIHe65nZGSzXIXt6fzMXS
	 6UVD25jyYTngZqcLPVlr0QC80E+CpEqJz2HsdAFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbfJKUMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:12:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729421AbfJKULd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:11:33 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4321E2246B;
        Fri, 11 Oct 2019 20:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824691;
        bh=agsyZn+ES1JZTA8JfcuFgPSKqI240swWPRPUbd18kHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=luGdbaWwFF2aKWPLZShCf/ovEdizLNAengL7KMbgcdkUrhf1QTGQpRlrr8bB0+iq6
         dUQzbzTB2x0eK5GGs/YzKNB3T+0qzTijz4mTCfupQu1Lx0dXH8bp8k7uVy6lPuPmn0
         eW2gUh4FcZa/T+0ntmEUYrFGm6PjBB7ETu99ssvI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 62/69] perf evlist: Switch to libperf's mmap interface
Date:   Fri, 11 Oct 2019 17:05:52 -0300
Message-Id: <20191011200559.7156-63-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
index d57b684b4b7b..3f4f11f27b94 100644
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
-- 
2.21.0

