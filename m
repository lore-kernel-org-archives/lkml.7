Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEFEC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218A720640
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381304;
	bh=4W2+IzquqlAbSI6+hcTiRvtQvtOj7vuFwL7B+wiJ+To=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=epjHRv4PH7eUNM98i2xZEjeFmu3y5HFT5jcneCsFsY+XvvsqUiak7ykQhPoudwx/e
	 urH4OsSx11bEHzOORmudY0XWGdlIneRRByG1l3lv2jPTTlUaV4aasN413RLzBDtA+t
	 Kv081gJHy5Bwzq83mYSnEjw2499ltjYcDsw5Bq70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391304AbfIMNZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:25:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60806 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391289AbfIMNZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:25:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C444151EE4;
        Fri, 13 Sep 2019 13:25:06 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ED0935C1D4;
        Fri, 13 Sep 2019 13:25:03 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 26/73] libperf: Move heads from struct evlist to struct perf_evlist
Date:   Fri, 13 Sep 2019 15:23:08 +0200
Message-Id: <20190913132355.21634-27-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 13 Sep 2019 13:25:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move heads hash from struct evlist to struct perf_evlist.

Link: http://lkml.kernel.org/n/tip-4y1fuw43ave7y32ypc9epthv@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/evlist.c                  |  4 ++++
 tools/perf/lib/include/internal/evlist.h |  4 ++++
 tools/perf/util/evlist.c                 | 10 +++-------
 tools/perf/util/evlist.h                 |  4 ----
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index f4dc9a208332..2bdd9d2c79d9 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -11,6 +11,10 @@
 
 void perf_evlist__init(struct perf_evlist *evlist)
 {
+	int i;
+
+	for (i = 0; i < PERF_EVLIST__HLIST_SIZE; ++i)
+		INIT_HLIST_HEAD(&evlist->heads[i]);
 	INIT_LIST_HEAD(&evlist->entries);
 	evlist->nr_entries = 0;
 }
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index 8a4eb66fbf3a..c5a06890fd6a 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -5,6 +5,9 @@
 #include <linux/list.h>
 #include <api/fd/array.h>
 
+#define PERF_EVLIST__HLIST_BITS 8
+#define PERF_EVLIST__HLIST_SIZE (1 << PERF_EVLIST__HLIST_BITS)
+
 struct perf_cpu_map;
 struct perf_thread_map;
 
@@ -17,6 +20,7 @@ struct perf_evlist {
 	int			 nr_mmaps;
 	size_t			 mmap_len;
 	struct fdarray		 pollfd;
+	struct hlist_head	 heads[PERF_EVLIST__HLIST_SIZE];
 };
 
 /**
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 9dcecb5e05a0..2f883db7c8e7 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -54,10 +54,6 @@ int sigqueue(pid_t pid, int sig, const union sigval value);
 void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
 		  struct perf_thread_map *threads)
 {
-	int i;
-
-	for (i = 0; i < PERF_EVLIST__HLIST_SIZE; ++i)
-		INIT_HLIST_HEAD(&evlist->heads[i]);
 	perf_evlist__init(&evlist->core);
 	perf_evlist__set_maps(&evlist->core, cpus, threads);
 	fdarray__init(&evlist->core.pollfd, 64);
@@ -474,7 +470,7 @@ static void perf_evlist__id_hash(struct evlist *evlist,
 	sid->id = id;
 	sid->evsel = evsel;
 	hash = hash_64(sid->id, PERF_EVLIST__HLIST_BITS);
-	hlist_add_head(&sid->node, &evlist->heads[hash]);
+	hlist_add_head(&sid->node, &evlist->core.heads[hash]);
 }
 
 void perf_evlist__id_add(struct evlist *evlist, struct evsel *evsel,
@@ -548,7 +544,7 @@ struct perf_sample_id *perf_evlist__id2sid(struct evlist *evlist, u64 id)
 	int hash;
 
 	hash = hash_64(id, PERF_EVLIST__HLIST_BITS);
-	head = &evlist->heads[hash];
+	head = &evlist->core.heads[hash];
 
 	hlist_for_each_entry(sid, head, node)
 		if (sid->id == id)
@@ -634,7 +630,7 @@ struct evsel *perf_evlist__event2evsel(struct evlist *evlist,
 		return first;
 
 	hash = hash_64(id, PERF_EVLIST__HLIST_BITS);
-	head = &evlist->heads[hash];
+	head = &evlist->core.heads[hash];
 
 	hlist_for_each_entry(sid, head, node) {
 		if (sid->id == id)
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index b8f03452196f..7306a0677171 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -20,12 +20,8 @@ struct thread_map;
 struct perf_cpu_map;
 struct record_opts;
 
-#define PERF_EVLIST__HLIST_BITS 8
-#define PERF_EVLIST__HLIST_SIZE (1 << PERF_EVLIST__HLIST_BITS)
-
 struct evlist {
 	struct perf_evlist core;
-	struct hlist_head heads[PERF_EVLIST__HLIST_SIZE];
 	int		 nr_groups;
 	bool		 enabled;
 	int		 id_pos;
-- 
2.21.0

