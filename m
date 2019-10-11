Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D81ECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C58222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824707;
	bh=sGNdLLhuEVZysxBhv0Nqac2JO+y3rWu2YqnWwnaSSFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0Dcxp5758Ky43fHteMfErWckZ23vV1UMoMxWVUbPCHvmV0e8q1ubBVwjK0LYX8f7O
	 2r1ytkmFsHlccIaH9yXKue5M2SIhsVgva7BTSj2O26aFJI8H2WqUQfGqE976DO1sAB
	 pQ+gaQf5zXLUWm0sblyq7mPKoeEWECYYB1EwHcAc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbfJKULq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:11:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729449AbfJKULo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:11:44 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56D302196E;
        Fri, 11 Oct 2019 20:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824703;
        bh=sGNdLLhuEVZysxBhv0Nqac2JO+y3rWu2YqnWwnaSSFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e8zVfp6cbULxL9fBKKeWi5Kun7Ie7+K/hUfrbUp6SGqpQZpf8vFZNcvIbI5tv7AtF
         znSK57/KCTex2dXeKueN1U2qbRccIdW8XzeCp1Iax4XpaV/eszrZ+MEp5M7wQZIkDF
         gev/vjG9hzpfZwgQcBBGAmxjCfetg/ptUql/Kfzo=
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
Subject: [PATCH 65/69] libperf: Introduce perf_evlist__exit()
Date:   Fri, 11 Oct 2019 17:05:55 -0300
Message-Id: <20191011200559.7156-66-acme@kernel.org>
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

Add the perf_evlist__exit() function, so far it's not exported and added
only for internal use for perf and libperf.

USe it to release cpus/threads and pollfd array.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191007125344.14268-25-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evlist.c                  | 12 +++++++++++-
 tools/perf/lib/include/internal/evlist.h |  2 ++
 tools/perf/util/evlist.c                 |  6 +-----
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 5ae1da97d2e6..7ba98f0e6365 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -109,13 +109,23 @@ perf_evlist__next(struct perf_evlist *evlist, struct perf_evsel *prev)
 	return next;
 }
 
+void perf_evlist__exit(struct perf_evlist *evlist)
+{
+	perf_cpu_map__put(evlist->cpus);
+	perf_thread_map__put(evlist->threads);
+	evlist->cpus = NULL;
+	evlist->threads = NULL;
+	fdarray__exit(&evlist->pollfd);
+}
+
 void perf_evlist__delete(struct perf_evlist *evlist)
 {
 	if (evlist == NULL)
 		return;
 
 	perf_evlist__munmap(evlist);
-	fdarray__exit(&evlist->pollfd);
+	perf_evlist__close(evlist);
+	perf_evlist__exit(evlist);
 	free(evlist);
 }
 
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index b2019700cdc0..0721512ffb19 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -48,6 +48,8 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 			  struct perf_evlist_mmap_ops *ops,
 			  struct perf_mmap_param *mp);
 
+void perf_evlist__exit(struct perf_evlist *evlist);
+
 /**
  * __perf_evlist__for_each_entry - iterate thru all the evsels
  * @list: list_head instance to iterate
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 5192c6583c96..031ace3696a2 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -138,7 +138,7 @@ void evlist__exit(struct evlist *evlist)
 {
 	zfree(&evlist->mmap);
 	zfree(&evlist->overwrite_mmap);
-	fdarray__exit(&evlist->core.pollfd);
+	perf_evlist__exit(&evlist->core);
 }
 
 void evlist__delete(struct evlist *evlist)
@@ -148,10 +148,6 @@ void evlist__delete(struct evlist *evlist)
 
 	evlist__munmap(evlist);
 	evlist__close(evlist);
-	perf_cpu_map__put(evlist->core.cpus);
-	perf_thread_map__put(evlist->core.threads);
-	evlist->core.cpus = NULL;
-	evlist->core.threads = NULL;
 	evlist__purge(evlist);
 	evlist__exit(evlist);
 	free(evlist);
-- 
2.21.0

