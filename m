Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C0CECE58E
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B2102086A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbfJOFgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:36:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41936 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbfJOFby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:31:54 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFQq-00004r-Lr; Tue, 15 Oct 2019 07:31:40 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A171F1C0450;
        Tue, 15 Oct 2019 07:31:38 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:38 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Introduce perf_evlist_mmap_ops::idx callback
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191007125344.14268-16-jolsa@kernel.org>
References: <20191007125344.14268-16-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <157111749856.12254.3251239305894313360.tip-bot2@tip-bot2>
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

Commit-ID:     1fcbb75cc574072ab457dbbaa74fc7064b691e86
Gitweb:        https://git.kernel.org/tip/1fcbb75cc574072ab457dbbaa74fc7064b691e86
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Mon, 07 Oct 2019 14:53:23 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 10 Oct 2019 12:20:08 -03:00

libperf: Introduce perf_evlist_mmap_ops::idx callback

Add the perf_evlist_mmap_ops::idx callback to be called in
mmap_per_cpu() and mmap_per_thread() with current cpu and thread
indexes.

It's used by current aux code, so perf will use this callback to set the
aux index.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191007125344.14268-16-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evlist.c                  | 18 +++++++++++++-----
 tools/perf/lib/include/internal/evlist.h |  4 ++++
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 88d63f5..3832d3e 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -426,7 +426,8 @@ mmap_per_evsel(struct perf_evlist *evlist, int idx,
 }
 
 static int
-mmap_per_thread(struct perf_evlist *evlist, struct perf_mmap_param *mp)
+mmap_per_thread(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
+		struct perf_mmap_param *mp)
 {
 	int thread;
 	int nr_threads = perf_thread_map__nr(evlist->threads);
@@ -435,6 +436,9 @@ mmap_per_thread(struct perf_evlist *evlist, struct perf_mmap_param *mp)
 		int output = -1;
 		int output_overwrite = -1;
 
+		if (ops->idx)
+			ops->idx(evlist, mp, thread, false);
+
 		if (mmap_per_evsel(evlist, thread, mp, 0, thread,
 				   &output, &output_overwrite))
 			goto out_unmap;
@@ -448,7 +452,8 @@ out_unmap:
 }
 
 static int
-mmap_per_cpu(struct perf_evlist *evlist, struct perf_mmap_param *mp)
+mmap_per_cpu(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
+	     struct perf_mmap_param *mp)
 {
 	int nr_threads = perf_thread_map__nr(evlist->threads);
 	int nr_cpus    = perf_cpu_map__nr(evlist->cpus);
@@ -458,6 +463,9 @@ mmap_per_cpu(struct perf_evlist *evlist, struct perf_mmap_param *mp)
 		int output = -1;
 		int output_overwrite = -1;
 
+		if (ops->idx)
+			ops->idx(evlist, mp, cpu, true);
+
 		for (thread = 0; thread < nr_threads; thread++) {
 			if (mmap_per_evsel(evlist, cpu, mp, cpu,
 					   thread, &output, &output_overwrite))
@@ -496,15 +504,15 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 	}
 
 	if (perf_cpu_map__empty(cpus))
-		return mmap_per_thread(evlist, mp);
+		return mmap_per_thread(evlist, ops, mp);
 
-	return mmap_per_cpu(evlist, mp);
+	return mmap_per_cpu(evlist, ops, mp);
 }
 
 int perf_evlist__mmap(struct perf_evlist *evlist, int pages)
 {
 	struct perf_mmap_param mp;
-	struct perf_evlist_mmap_ops ops;
+	struct perf_evlist_mmap_ops ops = { 0 };
 
 	evlist->mmap_len = (pages + 1) * page_size;
 	mp.mask = evlist->mmap_len - page_size - 1;
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index e5f092f..053f620 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -27,7 +27,11 @@ struct perf_evlist {
 	struct perf_mmap	*mmap_ovw;
 };
 
+typedef void
+(*perf_evlist_mmap__cb_idx_t)(struct perf_evlist*, struct perf_mmap_param*, int, bool);
+
 struct perf_evlist_mmap_ops {
+	perf_evlist_mmap__cb_idx_t	idx;
 };
 
 int perf_evlist__alloc_pollfd(struct perf_evlist *evlist);
