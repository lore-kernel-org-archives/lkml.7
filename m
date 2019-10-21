Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D06ACA9EB0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 241E62166E
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387629AbfJVAFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 20:05:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38895 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387566AbfJVAFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 20:05:16 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMgwv-0003tO-Nk; Tue, 22 Oct 2019 01:18:54 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2D3381C0489;
        Tue, 22 Oct 2019 01:18:53 +0200 (CEST)
Date:   Mon, 21 Oct 2019 23:18:52 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Move mmap allocation to perf_evlist__mmap_ops::get
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191017105918.20873-3-jolsa@kernel.org>
References: <20191017105918.20873-3-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <157169993270.29376.15194593020616946024.tip-bot2@tip-bot2>
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

Commit-ID:     3805e4f303314c2b53fb217dd8549a5b9eb06b11
Gitweb:        https://git.kernel.org/tip/3805e4f303314c2b53fb217dd8549a5b9eb06b11
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Thu, 17 Oct 2019 12:59:10 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 19 Oct 2019 15:35:01 -03:00

libperf: Move mmap allocation to perf_evlist__mmap_ops::get

Move allocation of the mmap array into perf_evlist__mmap_ops::get, to
centralize the mmap allocation.

Also move nr_mmap setup to perf_evlist__mmap_ops so it's centralized and
shared by both perf and libperf mmap code.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lore.kernel.org/lkml/20191017105918.20873-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evlist.c  | 42 +++++++++++++++++++++++----------------
 tools/perf/util/evlist.c | 24 ++++++++--------------
 2 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 854efff..73aac6b 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -338,10 +338,6 @@ static struct perf_mmap* perf_evlist__alloc_mmap(struct perf_evlist *evlist, boo
 	int i;
 	struct perf_mmap *map;
 
-	evlist->nr_mmaps = perf_cpu_map__nr(evlist->cpus);
-	if (perf_cpu_map__empty(evlist->cpus))
-		evlist->nr_mmaps = perf_thread_map__nr(evlist->threads);
-
 	map = zalloc(evlist->nr_mmaps * sizeof(struct perf_mmap));
 	if (!map)
 		return NULL;
@@ -384,18 +380,22 @@ static void perf_evlist__set_sid_idx(struct perf_evlist *evlist,
 static struct perf_mmap*
 perf_evlist__mmap_cb_get(struct perf_evlist *evlist, bool overwrite, int idx)
 {
-	struct perf_mmap *map = &evlist->mmap[idx];
+	struct perf_mmap *maps;
 
-	if (overwrite) {
-		if (!evlist->mmap_ovw) {
-			evlist->mmap_ovw = perf_evlist__alloc_mmap(evlist, true);
-			if (!evlist->mmap_ovw)
-				return NULL;
-		}
-		map = &evlist->mmap_ovw[idx];
+	maps = overwrite ? evlist->mmap_ovw : evlist->mmap;
+
+	if (!maps) {
+		maps = perf_evlist__alloc_mmap(evlist, overwrite);
+		if (!maps)
+			return NULL;
+
+		if (overwrite)
+			evlist->mmap_ovw = maps;
+		else
+			evlist->mmap = maps;
 	}
 
-	return map;
+	return &maps[idx];
 }
 
 #define FD(e, x, y) (*(int *) xyarray__entry(e->fd, x, y))
@@ -556,6 +556,17 @@ out_unmap:
 	return -1;
 }
 
+static int perf_evlist__nr_mmaps(struct perf_evlist *evlist)
+{
+	int nr_mmaps;
+
+	nr_mmaps = perf_cpu_map__nr(evlist->cpus);
+	if (perf_cpu_map__empty(evlist->cpus))
+		nr_mmaps = perf_thread_map__nr(evlist->threads);
+
+	return nr_mmaps;
+}
+
 int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 			  struct perf_evlist_mmap_ops *ops,
 			  struct perf_mmap_param *mp)
@@ -567,10 +578,7 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 	if (!ops || !ops->get || !ops->mmap)
 		return -EINVAL;
 
-	if (!evlist->mmap)
-		evlist->mmap = perf_evlist__alloc_mmap(evlist, false);
-	if (!evlist->mmap)
-		return -ENOMEM;
+	evlist->nr_mmaps = perf_evlist__nr_mmaps(evlist);
 
 	perf_evlist__for_each_entry(evlist, evsel) {
 		if ((evsel->attr.read_format & PERF_FORMAT_ID) &&
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 6cda5a3..5cded4e 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -599,9 +599,6 @@ static struct mmap *evlist__alloc_mmap(struct evlist *evlist,
 	int i;
 	struct mmap *map;
 
-	evlist->core.nr_mmaps = perf_cpu_map__nr(evlist->core.cpus);
-	if (perf_cpu_map__empty(evlist->core.cpus))
-		evlist->core.nr_mmaps = perf_thread_map__nr(evlist->core.threads);
 	map = zalloc(evlist->core.nr_mmaps * sizeof(struct mmap));
 	if (!map)
 		return NULL;
@@ -639,19 +636,21 @@ static struct perf_mmap*
 perf_evlist__mmap_cb_get(struct perf_evlist *_evlist, bool overwrite, int idx)
 {
 	struct evlist *evlist = container_of(_evlist, struct evlist, core);
-	struct mmap *maps = evlist->mmap;
+	struct mmap *maps;
 
-	if (overwrite) {
-		maps = evlist->overwrite_mmap;
+	maps = overwrite ? evlist->overwrite_mmap : evlist->mmap;
 
-		if (!maps) {
-			maps = evlist__alloc_mmap(evlist, true);
-			if (!maps)
-				return NULL;
+	if (!maps) {
+		maps = evlist__alloc_mmap(evlist, overwrite);
+		if (!maps)
+			return NULL;
 
+		if (overwrite) {
 			evlist->overwrite_mmap = maps;
 			if (evlist->bkw_mmap_state == BKW_MMAP_NOTREADY)
 				perf_evlist__toggle_bkw_mmap(evlist, BKW_MMAP_RUNNING);
+		} else {
+			evlist->mmap = maps;
 		}
 	}
 
@@ -812,11 +811,6 @@ int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 		.mmap = perf_evlist__mmap_cb_mmap,
 	};
 
-	if (!evlist->mmap)
-		evlist->mmap = evlist__alloc_mmap(evlist, false);
-	if (!evlist->mmap)
-		return -ENOMEM;
-
 	evlist->core.mmap_len = evlist__mmap_size(pages);
 	pr_debug("mmap size %zuB\n", evlist->core.mmap_len);
 	mp.core.mask = evlist->core.mmap_len - page_size - 1;
