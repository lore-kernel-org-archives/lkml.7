Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F341DC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA3FD21D7B
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569458125;
	bh=tnhA8jaHtBYiA9k7J6CKhzDE4WXU+dgk4IudbuRfp/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=elD6DfcOe38H5vQBw9zJZkt3Tq7o1TYo2GuDoQ9MvxVh/a8tn/bwFu9AOWd5nnjEt
	 l9WFRbP6DTXGGMXcHFOG89tlAE+WahFz+mu+Orjz0VZH5gYlNlwI9fXYpKVdlo5v+7
	 p9rDtsrKcLG4hDdIIUKBBeE/aq+OsJ53c+YwjXOI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389665AbfIZAfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:35:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:38208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388739AbfIZAfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:35:23 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B577222C1;
        Thu, 26 Sep 2019 00:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458122;
        bh=tnhA8jaHtBYiA9k7J6CKhzDE4WXU+dgk4IudbuRfp/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HkLHWV7+HFiG34E5DJDVQb1WmxtXIXhlxop7Y5CRBYkVpHdsl1im4bxdM9yxlUOcy
         RApUWyOGxXSR1LCjdbNkZiX6RidDCuh60mrpdNDm/J2GGd8PtoYh+GmGMIbmL9gMPb
         3tWjFUrFLBe8gOpgmPYSiGrBueeudqo3HqCZ0RBM=
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
Subject: [PATCH 40/66] libperf: Move 'heads' from 'struct evlist' to 'struct perf_evlist'
Date:   Wed, 25 Sep 2019 21:32:18 -0300
Message-Id: <20190926003244.13962-41-acme@kernel.org>
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

Move 'heads' hash table from 'struct evlist' to 'struct perf_evlist'.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-27-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
index 5e43fb9da359..c6af7c622612 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -55,10 +55,6 @@ int sigqueue(pid_t pid, int sig, const union sigval value);
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
@@ -475,7 +471,7 @@ static void perf_evlist__id_hash(struct evlist *evlist,
 	sid->id = id;
 	sid->evsel = evsel;
 	hash = hash_64(sid->id, PERF_EVLIST__HLIST_BITS);
-	hlist_add_head(&sid->node, &evlist->heads[hash]);
+	hlist_add_head(&sid->node, &evlist->core.heads[hash]);
 }
 
 void perf_evlist__id_add(struct evlist *evlist, struct evsel *evsel,
@@ -549,7 +545,7 @@ struct perf_sample_id *perf_evlist__id2sid(struct evlist *evlist, u64 id)
 	int hash;
 
 	hash = hash_64(id, PERF_EVLIST__HLIST_BITS);
-	head = &evlist->heads[hash];
+	head = &evlist->core.heads[hash];
 
 	hlist_for_each_entry(sid, head, node)
 		if (sid->id == id)
@@ -635,7 +631,7 @@ struct evsel *perf_evlist__event2evsel(struct evlist *evlist,
 		return first;
 
 	hash = hash_64(id, PERF_EVLIST__HLIST_BITS);
-	head = &evlist->heads[hash];
+	head = &evlist->core.heads[hash];
 
 	hlist_for_each_entry(sid, head, node) {
 		if (sid->id == id)
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 4fcdf93eb19c..ad9c0ba57a91 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -48,12 +48,8 @@ enum bkw_mmap_state {
 	BKW_MMAP_EMPTY,
 };
 
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

