Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EB7ECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEDEB21D71
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbfJOFcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:32:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42012 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728451AbfJOFcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:32:00 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFQz-0000B2-Kb; Tue, 15 Oct 2019 07:31:49 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9D24F1C04D5;
        Tue, 15 Oct 2019 07:31:41 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:41 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Add 'struct perf_mmap_param'
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191007125344.14268-3-jolsa@kernel.org>
References: <20191007125344.14268-3-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <157111750156.12254.16255019235178745239.tip-bot2@tip-bot2>
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

Commit-ID:     e440979faf6ac8048e1792af383df6af78dd1cb0
Gitweb:        https://git.kernel.org/tip/e440979faf6ac8048e1792af383df6af78dd1cb0
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Mon, 07 Oct 2019 14:53:10 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 10 Oct 2019 09:40:00 -03:00

libperf: Add 'struct perf_mmap_param'

Add libperf's version of mmap params 'struct perf_mmap_param' object
with the basics: 'prot' and 'mask'.  Encapsulate it in the current
'struct mmap_params' object.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191007125344.14268-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/internal/mmap.h |  5 +++++
 tools/perf/util/evlist.c               | 14 +++++++++-----
 tools/perf/util/mmap.c                 |  4 ++--
 tools/perf/util/mmap.h                 |  3 ++-
 4 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
index e25890d..b26806b 100644
--- a/tools/perf/lib/include/internal/mmap.h
+++ b/tools/perf/lib/include/internal/mmap.h
@@ -29,6 +29,11 @@ struct perf_mmap {
 	char		 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
 };
 
+struct perf_mmap_param {
+	int	prot;
+	int	mask;
+};
+
 void perf_mmap__init(struct perf_mmap *map, bool overwrite);
 
 #endif /* __LIBPERF_INTERNAL_MMAP_H */
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 6c8de08..3a19a7c 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -667,7 +667,7 @@ static int evlist__mmap_per_evsel(struct evlist *evlist, int idx,
 		int fd;
 		int cpu;
 
-		mp->prot = PROT_READ | PROT_WRITE;
+		mp->core.prot = PROT_READ | PROT_WRITE;
 		if (evsel->core.attr.write_backward) {
 			output = _output_overwrite;
 			maps = evlist->overwrite_mmap;
@@ -680,7 +680,7 @@ static int evlist__mmap_per_evsel(struct evlist *evlist, int idx,
 				if (evlist->bkw_mmap_state == BKW_MMAP_NOTREADY)
 					perf_evlist__toggle_bkw_mmap(evlist, BKW_MMAP_RUNNING);
 			}
-			mp->prot &= ~PROT_WRITE;
+			mp->core.prot &= ~PROT_WRITE;
 		}
 
 		if (evsel->core.system_wide && thread)
@@ -921,8 +921,12 @@ int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 	 * Its value is decided by evsel's write_backward.
 	 * So &mp should not be passed through const pointer.
 	 */
-	struct mmap_params mp = { .nr_cblocks = nr_cblocks, .affinity = affinity, .flush = flush,
-				  .comp_level = comp_level };
+	struct mmap_params mp = {
+		.nr_cblocks	= nr_cblocks,
+		.affinity	= affinity,
+		.flush		= flush,
+		.comp_level	= comp_level
+	};
 
 	if (!evlist->mmap)
 		evlist->mmap = evlist__alloc_mmap(evlist, false);
@@ -934,7 +938,7 @@ int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 
 	evlist->core.mmap_len = evlist__mmap_size(pages);
 	pr_debug("mmap size %zuB\n", evlist->core.mmap_len);
-	mp.mask = evlist->core.mmap_len - page_size - 1;
+	mp.core.mask = evlist->core.mmap_len - page_size - 1;
 
 	auxtrace_mmap_params__init(&mp.auxtrace_mp, evlist->core.mmap_len,
 				   auxtrace_pages, auxtrace_overwrite);
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index a35dc57..a496ced 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -370,8 +370,8 @@ int perf_mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
 	 */
 	refcount_set(&map->core.refcnt, 2);
 	map->core.prev = 0;
-	map->core.mask = mp->mask;
-	map->core.base = mmap(NULL, perf_mmap__mmap_len(map), mp->prot,
+	map->core.mask = mp->core.mask;
+	map->core.base = mmap(NULL, perf_mmap__mmap_len(map), mp->core.prot,
 			 MAP_SHARED, fd, 0);
 	if (map->core.base == MAP_FAILED) {
 		pr_debug2("failed to mmap perf event ring buffer, error %d\n",
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index e567c1c..4ff75d8 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -37,7 +37,8 @@ struct mmap {
 };
 
 struct mmap_params {
-	int prot, mask, nr_cblocks, affinity, flush, comp_level;
+	struct perf_mmap_param core;
+	int nr_cblocks, affinity, flush, comp_level;
 	struct auxtrace_mmap_params auxtrace_mp;
 };
 
