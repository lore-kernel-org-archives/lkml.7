Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAADECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE3DF2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfJOFgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:36:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41903 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728254AbfJOFbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:31:51 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFQs-00005L-6N; Tue, 15 Oct 2019 07:31:42 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DF2961C0494;
        Tue, 15 Oct 2019 07:31:38 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:38 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Introduce perf_evlist__mmap_ops()
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20191007125344.14268-15-jolsa@kernel.org>
References: <20191007125344.14268-15-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <157111749880.12254.1536799430986791776.tip-bot2@tip-bot2>
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

Commit-ID:     0b5ea10d4c312f5b17af9d09187efb9418517bec
Gitweb:        https://git.kernel.org/tip/0b5ea10d4c312f5b17af9d09187efb9418517bec
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Mon, 07 Oct 2019 14:53:22 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 10 Oct 2019 12:18:00 -03:00

libperf: Introduce perf_evlist__mmap_ops()

To be able to pass specific callbacks to evlist's mmap.

There will be a specific call to this function from perf's
evlist__mmap() and libperf's perf_evlist__mmap() functions in following
changes.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191007125344.14268-15-jolsa@kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/evlist.c                  | 24 +++++++++++++++++------
 tools/perf/lib/include/internal/evlist.h |  8 ++++++++-
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 250ad57..88d63f5 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -472,12 +472,16 @@ out_unmap:
 	return -1;
 }
 
-int perf_evlist__mmap(struct perf_evlist *evlist, int pages)
+int perf_evlist__mmap_ops(struct perf_evlist *evlist,
+			  struct perf_evlist_mmap_ops *ops,
+			  struct perf_mmap_param *mp)
 {
 	struct perf_evsel *evsel;
 	const struct perf_cpu_map *cpus = evlist->cpus;
 	const struct perf_thread_map *threads = evlist->threads;
-	struct perf_mmap_param mp;
+
+	if (!ops)
+		return -EINVAL;
 
 	if (!evlist->mmap)
 		evlist->mmap = perf_evlist__alloc_mmap(evlist, false);
@@ -491,13 +495,21 @@ int perf_evlist__mmap(struct perf_evlist *evlist, int pages)
 			return -ENOMEM;
 	}
 
+	if (perf_cpu_map__empty(cpus))
+		return mmap_per_thread(evlist, mp);
+
+	return mmap_per_cpu(evlist, mp);
+}
+
+int perf_evlist__mmap(struct perf_evlist *evlist, int pages)
+{
+	struct perf_mmap_param mp;
+	struct perf_evlist_mmap_ops ops;
+
 	evlist->mmap_len = (pages + 1) * page_size;
 	mp.mask = evlist->mmap_len - page_size - 1;
 
-	if (perf_cpu_map__empty(cpus))
-		return mmap_per_thread(evlist, &mp);
-
-	return mmap_per_cpu(evlist, &mp);
+	return perf_evlist__mmap_ops(evlist, &ops, &mp);
 }
 
 void perf_evlist__munmap(struct perf_evlist *evlist)
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index 4438a19..e5f092f 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -11,6 +11,7 @@
 
 struct perf_cpu_map;
 struct perf_thread_map;
+struct perf_mmap_param;
 
 struct perf_evlist {
 	struct list_head	 entries;
@@ -26,10 +27,17 @@ struct perf_evlist {
 	struct perf_mmap	*mmap_ovw;
 };
 
+struct perf_evlist_mmap_ops {
+};
+
 int perf_evlist__alloc_pollfd(struct perf_evlist *evlist);
 int perf_evlist__add_pollfd(struct perf_evlist *evlist, int fd,
 			    void *ptr, short revent);
 
+int perf_evlist__mmap_ops(struct perf_evlist *evlist,
+			  struct perf_evlist_mmap_ops *ops,
+			  struct perf_mmap_param *mp);
+
 /**
  * __perf_evlist__for_each_entry - iterate thru all the evsels
  * @list: list_head instance to iterate
