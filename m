Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0C0ECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835922086A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbfJOFbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:31:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41905 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbfJOFbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:31:50 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFQp-0008W1-Q6; Tue, 15 Oct 2019 07:31:39 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5D3601C0493;
        Tue, 15 Oct 2019 07:31:38 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:38 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Add perf_evlist_mmap_ops::get callback
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191007125344.14268-17-jolsa@kernel.org>
References: <20191007125344.14268-17-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <157111749830.12254.18260942331882675353.tip-bot2@tip-bot2>
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

Commit-ID:     3a8bb58121987a8405d6f96cd8815025e564605d
Gitweb:        https://git.kernel.org/tip/3a8bb58121987a8405d6f96cd8815025e564605d
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Mon, 07 Oct 2019 14:53:24 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 10 Oct 2019 12:21:11 -03:00

libperf: Add perf_evlist_mmap_ops::get callback

Add the perf_evlist_mmap_ops::get callback to be called in
mmap_per_evsel() to get/allocate the 'struct perf_mmap' object.

Add the libperf's perf_evlist__mmap_cb_get() function as libperf's get
callback.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191007125344.14268-17-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evlist.c                  | 18 ++++++++++--------
 tools/perf/lib/include/internal/evlist.h |  3 +++
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 3832d3e..4f49de5 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -340,7 +340,7 @@ static void perf_evlist__set_sid_idx(struct perf_evlist *evlist,
 }
 
 static struct perf_mmap*
-perf_evlist__map_get(struct perf_evlist *evlist, bool overwrite, int idx)
+perf_evlist__mmap_cb_get(struct perf_evlist *evlist, bool overwrite, int idx)
 {
 	struct perf_mmap *map = &evlist->mmap[idx];
 
@@ -359,8 +359,8 @@ perf_evlist__map_get(struct perf_evlist *evlist, bool overwrite, int idx)
 #define FD(e, x, y) (*(int *) xyarray__entry(e->fd, x, y))
 
 static int
-mmap_per_evsel(struct perf_evlist *evlist, int idx,
-	       struct perf_mmap_param *mp, int cpu_idx,
+mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
+	       int idx, struct perf_mmap_param *mp, int cpu_idx,
 	       int thread, int *_output, int *_output_overwrite)
 {
 	int evlist_cpu = perf_cpu_map__cpu(evlist->cpus, cpu_idx);
@@ -379,7 +379,7 @@ mmap_per_evsel(struct perf_evlist *evlist, int idx,
 		if (cpu == -1)
 			continue;
 
-		map = perf_evlist__map_get(evlist, overwrite, idx);
+		map = ops->get(evlist, overwrite, idx);
 		if (map == NULL)
 			return -ENOMEM;
 
@@ -439,7 +439,7 @@ mmap_per_thread(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 		if (ops->idx)
 			ops->idx(evlist, mp, thread, false);
 
-		if (mmap_per_evsel(evlist, thread, mp, 0, thread,
+		if (mmap_per_evsel(evlist, ops, thread, mp, 0, thread,
 				   &output, &output_overwrite))
 			goto out_unmap;
 	}
@@ -467,7 +467,7 @@ mmap_per_cpu(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 			ops->idx(evlist, mp, cpu, true);
 
 		for (thread = 0; thread < nr_threads; thread++) {
-			if (mmap_per_evsel(evlist, cpu, mp, cpu,
+			if (mmap_per_evsel(evlist, ops, cpu, mp, cpu,
 					   thread, &output, &output_overwrite))
 				goto out_unmap;
 		}
@@ -488,7 +488,7 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 	const struct perf_cpu_map *cpus = evlist->cpus;
 	const struct perf_thread_map *threads = evlist->threads;
 
-	if (!ops)
+	if (!ops || !ops->get)
 		return -EINVAL;
 
 	if (!evlist->mmap)
@@ -512,7 +512,9 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 int perf_evlist__mmap(struct perf_evlist *evlist, int pages)
 {
 	struct perf_mmap_param mp;
-	struct perf_evlist_mmap_ops ops = { 0 };
+	struct perf_evlist_mmap_ops ops = {
+		.get = perf_evlist__mmap_cb_get,
+	};
 
 	evlist->mmap_len = (pages + 1) * page_size;
 	mp.mask = evlist->mmap_len - page_size - 1;
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index 053f620..9bc3a21 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -29,9 +29,12 @@ struct perf_evlist {
 
 typedef void
 (*perf_evlist_mmap__cb_idx_t)(struct perf_evlist*, struct perf_mmap_param*, int, bool);
+typedef struct perf_mmap*
+(*perf_evlist_mmap__cb_get_t)(struct perf_evlist*, bool, int);
 
 struct perf_evlist_mmap_ops {
 	perf_evlist_mmap__cb_idx_t	idx;
+	perf_evlist_mmap__cb_get_t	get;
 };
 
 int perf_evlist__alloc_pollfd(struct perf_evlist *evlist);
