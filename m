Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75659C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F1621D6C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569458251;
	bh=DdFGY1Nc7O2X1X4wDkd4Lbm/hV2on+UomiaNO5SFHWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mLDlAN/SpDUDdYTp6qZyltvbUw86B2GIwbzIRMW6iGlnX70kYxNbT2cZUSSx+grlV
	 kcPBN3jgtJ6eEFeUTpF5XjaCkE0q0bmG+ilpwdIFrC6hmh4QulriFTzQkaFt1vlY2H
	 iho8CO2pkiMqxxdwmVeDS5zpfyiR+Kqkdgi1/DK8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391113AbfIZAha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:37:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390278AbfIZAgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:36:08 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D49221D7B;
        Thu, 26 Sep 2019 00:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458166;
        bh=DdFGY1Nc7O2X1X4wDkd4Lbm/hV2on+UomiaNO5SFHWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sVSgDvElGCgg8vq8J+4Fa+Mm9P0oEemj0rVcTDyh6cXnSGbt2J10WEcJlkITNL0p8
         eGZFLbxWwULLfJJO1Qcwn6K4ybHfhFlnZcVEw6jSqaXlfeIa19rf1QVexQoBk3ZAoY
         7CGi8/mCJxhYjgu4NXfmCC/jccd/q9OpEZmWoiB4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 52/66] libperf: Add perf_evlist__alloc_pollfd() function
Date:   Wed, 25 Sep 2019 21:32:30 -0300
Message-Id: <20190926003244.13962-53-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move perf_evlist__alloc_pollfd() from tools/perf to libperf, it will be
used in the following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-37-jolsa@kernel.org
[ Added api/fd/array.h include to the lib/evlist.c file ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evlist.c                  | 22 ++++++++++++++++++++++
 tools/perf/lib/include/internal/evlist.h |  2 ++
 tools/perf/util/evlist.c                 | 23 +----------------------
 tools/perf/util/evlist.h                 |  1 -
 4 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 3a16dd0c044f..3c3b97f40be0 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -14,6 +14,7 @@
 #include <unistd.h>
 #include <perf/cpumap.h>
 #include <perf/threadmap.h>
+#include <api/fd/array.h>
 
 void perf_evlist__init(struct perf_evlist *evlist)
 {
@@ -238,3 +239,24 @@ int perf_evlist__id_add_fd(struct perf_evlist *evlist,
 	perf_evlist__id_add(evlist, evsel, cpu, thread, id);
 	return 0;
 }
+
+int perf_evlist__alloc_pollfd(struct perf_evlist *evlist)
+{
+	int nr_cpus = perf_cpu_map__nr(evlist->cpus);
+	int nr_threads = perf_thread_map__nr(evlist->threads);
+	int nfds = 0;
+	struct perf_evsel *evsel;
+
+	perf_evlist__for_each_entry(evlist, evsel) {
+		if (evsel->system_wide)
+			nfds += nr_cpus;
+		else
+			nfds += nr_cpus * nr_threads;
+	}
+
+	if (fdarray__available_entries(&evlist->pollfd) < nfds &&
+	    fdarray__grow(&evlist->pollfd, nfds) < 0)
+		return -ENOMEM;
+
+	return 0;
+}
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index 7d64185cfabd..88c0dfaf0ddc 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -24,6 +24,8 @@ struct perf_evlist {
 	struct hlist_head	 heads[PERF_EVLIST__HLIST_SIZE];
 };
 
+int perf_evlist__alloc_pollfd(struct perf_evlist *evlist);
+
 /**
  * __perf_evlist__for_each_entry - iterate thru all the evsels
  * @list: list_head instance to iterate
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 6069fb52661f..c47f23e7f3c8 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -398,27 +398,6 @@ int perf_evlist__enable_event_idx(struct evlist *evlist,
 		return perf_evlist__enable_event_thread(evlist, evsel, idx);
 }
 
-int perf_evlist__alloc_pollfd(struct evlist *evlist)
-{
-	int nr_cpus = perf_cpu_map__nr(evlist->core.cpus);
-	int nr_threads = perf_thread_map__nr(evlist->core.threads);
-	int nfds = 0;
-	struct evsel *evsel;
-
-	evlist__for_each_entry(evlist, evsel) {
-		if (evsel->core.system_wide)
-			nfds += nr_cpus;
-		else
-			nfds += nr_cpus * nr_threads;
-	}
-
-	if (fdarray__available_entries(&evlist->core.pollfd) < nfds &&
-	    fdarray__grow(&evlist->core.pollfd, nfds) < 0)
-		return -ENOMEM;
-
-	return 0;
-}
-
 static int __perf_evlist__add_pollfd(struct evlist *evlist, int fd,
 				     struct mmap *map, short revent)
 {
@@ -944,7 +923,7 @@ int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 	if (!evlist->mmap)
 		return -ENOMEM;
 
-	if (evlist->core.pollfd.entries == NULL && perf_evlist__alloc_pollfd(evlist) < 0)
+	if (evlist->core.pollfd.entries == NULL && perf_evlist__alloc_pollfd(&evlist->core) < 0)
 		return -ENOMEM;
 
 	evlist->core.mmap_len = evlist__mmap_size(pages);
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 80b3361613e5..bebbaa9b6325 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -142,7 +142,6 @@ perf_evlist__find_tracepoint_by_name(struct evlist *evlist,
 				     const char *name);
 
 int perf_evlist__add_pollfd(struct evlist *evlist, int fd);
-int perf_evlist__alloc_pollfd(struct evlist *evlist);
 int perf_evlist__filter_pollfd(struct evlist *evlist, short revents_and_mask);
 
 int perf_evlist__poll(struct evlist *evlist, int timeout);
-- 
2.21.0

