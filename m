Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777ABECE58E
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BEF021925
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbfJOFbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:31:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41878 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbfJOFbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:31:49 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFQo-0008Sp-CY; Tue, 15 Oct 2019 07:31:38 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 17A8C1C0450;
        Tue, 15 Oct 2019 07:31:38 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:37 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Introduce perf_evlist_mmap_ops::mmap callback
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191007125344.14268-18-jolsa@kernel.org>
References: <20191007125344.14268-18-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <157111749790.12254.16074880570008173641.tip-bot2@tip-bot2>
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

Commit-ID:     b5911e7ac28cb34f21b7380915ce98518078f114
Gitweb:        https://git.kernel.org/tip/b5911e7ac28cb34f21b7380915ce98518078f114
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Mon, 07 Oct 2019 14:53:25 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 10 Oct 2019 12:22:21 -03:00

libperf: Introduce perf_evlist_mmap_ops::mmap callback

Add the perf_evlist_mmap_ops::mmap callback to be called in
mmap_per_evsel() to actually mmap the map.

Add libperf's perf_evlist__mmap_cb_mmap() function as libperf's mmap
callback.

New mmaped map gets refcount set to 2 in mmap__mmap(), we follow that in
mmap callback. We will move this to common place after we switch to
perf_evlist__mmap().

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191007125344.14268-18-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evlist.c                  | 29 ++++++++++++++++++++---
 tools/perf/lib/include/internal/evlist.h |  3 ++-
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 4f49de5..b697226 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -359,6 +359,28 @@ perf_evlist__mmap_cb_get(struct perf_evlist *evlist, bool overwrite, int idx)
 #define FD(e, x, y) (*(int *) xyarray__entry(e->fd, x, y))
 
 static int
+perf_evlist__mmap_cb_mmap(struct perf_mmap *map, struct perf_mmap_param *mp,
+			  int output, int cpu)
+{
+	/*
+	 * The last one will be done at perf_mmap__consume(), so that we
+	 * make sure we don't prevent tools from consuming every last event in
+	 * the ring buffer.
+	 *
+	 * I.e. we can get the POLLHUP meaning that the fd doesn't exist
+	 * anymore, but the last events for it are still in the ring buffer,
+	 * waiting to be consumed.
+	 *
+	 * Tools can chose to ignore this at their own discretion, but the
+	 * evlist layer can't just drop it when filtering events in
+	 * perf_evlist__filter_pollfd().
+	 */
+	refcount_set(&map->refcnt, 2);
+
+	return perf_mmap__mmap(map, mp, output, cpu);
+}
+
+static int
 mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 	       int idx, struct perf_mmap_param *mp, int cpu_idx,
 	       int thread, int *_output, int *_output_overwrite)
@@ -396,7 +418,7 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 		if (*output == -1) {
 			*output = fd;
 
-			if (perf_mmap__mmap(map, mp, *output, evlist_cpu) < 0)
+			if (ops->mmap(map, mp, *output, evlist_cpu) < 0)
 				return -1;
 		} else {
 			if (ioctl(fd, PERF_EVENT_IOC_SET_OUTPUT, *output) != 0)
@@ -488,7 +510,7 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 	const struct perf_cpu_map *cpus = evlist->cpus;
 	const struct perf_thread_map *threads = evlist->threads;
 
-	if (!ops || !ops->get)
+	if (!ops || !ops->get || !ops->mmap)
 		return -EINVAL;
 
 	if (!evlist->mmap)
@@ -513,7 +535,8 @@ int perf_evlist__mmap(struct perf_evlist *evlist, int pages)
 {
 	struct perf_mmap_param mp;
 	struct perf_evlist_mmap_ops ops = {
-		.get = perf_evlist__mmap_cb_get,
+		.get  = perf_evlist__mmap_cb_get,
+		.mmap = perf_evlist__mmap_cb_mmap,
 	};
 
 	evlist->mmap_len = (pages + 1) * page_size;
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index 9bc3a21..b201970 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -31,10 +31,13 @@ typedef void
 (*perf_evlist_mmap__cb_idx_t)(struct perf_evlist*, struct perf_mmap_param*, int, bool);
 typedef struct perf_mmap*
 (*perf_evlist_mmap__cb_get_t)(struct perf_evlist*, bool, int);
+typedef int
+(*perf_evlist_mmap__cb_mmap_t)(struct perf_mmap*, struct perf_mmap_param*, int, int);
 
 struct perf_evlist_mmap_ops {
 	perf_evlist_mmap__cb_idx_t	idx;
 	perf_evlist_mmap__cb_get_t	get;
+	perf_evlist_mmap__cb_mmap_t	mmap;
 };
 
 int perf_evlist__alloc_pollfd(struct perf_evlist *evlist);
