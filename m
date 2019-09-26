Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1A9C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3508222C1
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569458089;
	bh=BgKHlue3ej7r7sBj8nD2uHouEO54tcXhoKnC/ib4uZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dp+WHQFA7OmoLXNlLhWEYomayinYHK8CDjza0tm+hiC6fyLV/nR6bO3/yaMZ+Y2dc
	 eY4OiFCPz4NryGtBrore9E+WF8wdjowql0wAD78B46IKvaTVbaF1PJpFRSJYUs8Fv7
	 bvBfhhv69PfwjkmKP2nAyVHD58lEt7eN999bGLh8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388884AbfIZAes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:34:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:37476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388841AbfIZAeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:34:46 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DE9F222C7;
        Thu, 26 Sep 2019 00:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458085;
        bh=BgKHlue3ej7r7sBj8nD2uHouEO54tcXhoKnC/ib4uZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VASyHql9ta8404OIzFDzCPgP5aWv4F8ZqIOTd20aQ3sjXWq4u184dLmKGDM96Qc7K
         f7u+4TFdFiIMNTWEtRr8ukV9zhpFvDDyFXe6mvUy/XGWj6Rd682R62FTmRhnHn+K3a
         nnn0DligrvLYznCz3i08RYhjOqDMgHpKEt2kub3s=
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
Subject: [PATCH 29/66] libperf: Add 'overwrite' to 'struct perf_mmap'
Date:   Wed, 25 Sep 2019 21:32:07 -0300
Message-Id: <20190926003244.13962-30-acme@kernel.org>
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

Move 'overwrite' from tools/perf's mmap to libperf's perf_mmap struct.

Committer notes:

Add stdbool.h as we start using 'bool'.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-17-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/internal/mmap.h |  2 ++
 tools/perf/util/evlist.c               |  2 +-
 tools/perf/util/mmap.c                 | 12 ++++++------
 tools/perf/util/mmap.h                 |  1 -
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
index ebf5b93754fd..47c09f375fb6 100644
--- a/tools/perf/lib/include/internal/mmap.h
+++ b/tools/perf/lib/include/internal/mmap.h
@@ -4,6 +4,7 @@
 
 #include <linux/refcount.h>
 #include <linux/types.h>
+#include <stdbool.h>
 
 /**
  * struct perf_mmap - perf's ring buffer mmap details
@@ -19,6 +20,7 @@ struct perf_mmap {
 	u64		 prev;
 	u64		 start;
 	u64		 end;
+	bool		 overwrite;
 };
 
 #endif /* __LIBPERF_INTERNAL_MMAP_H */
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index d987e0e5d62b..16d47a420bc2 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -709,7 +709,7 @@ static struct mmap *evlist__alloc_mmap(struct evlist *evlist,
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
 		map[i].core.fd = -1;
-		map[i].overwrite = overwrite;
+		map[i].core.overwrite = overwrite;
 		/*
 		 * When the perf_mmap() call is made we grab one refcount, plus
 		 * one extra to let perf_mmap__consume() get the last
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 6ce70ff005cb..a8850ce2c2ff 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -93,12 +93,12 @@ union perf_event *perf_mmap__read_event(struct mmap *map)
 		return NULL;
 
 	/* non-overwirte doesn't pause the ringbuffer */
-	if (!map->overwrite)
+	if (!map->core.overwrite)
 		map->core.end = perf_mmap__read_head(map);
 
 	event = perf_mmap__read(map, &map->core.start, map->core.end);
 
-	if (!map->overwrite)
+	if (!map->core.overwrite)
 		map->core.prev = map->core.start;
 
 	return event;
@@ -124,7 +124,7 @@ void perf_mmap__put(struct mmap *map)
 
 void perf_mmap__consume(struct mmap *map)
 {
-	if (!map->overwrite) {
+	if (!map->core.overwrite) {
 		u64 old = map->core.prev;
 
 		perf_mmap__write_tail(map, old);
@@ -447,15 +447,15 @@ static int __perf_mmap__read_init(struct mmap *md)
 	unsigned char *data = md->core.base + page_size;
 	unsigned long size;
 
-	md->core.start = md->overwrite ? head : old;
-	md->core.end = md->overwrite ? old : head;
+	md->core.start = md->core.overwrite ? head : old;
+	md->core.end = md->core.overwrite ? old : head;
 
 	if ((md->core.end - md->core.start) < md->flush)
 		return -EAGAIN;
 
 	size = md->core.end - md->core.start;
 	if (size > (unsigned long)(md->core.mask) + 1) {
-		if (!md->overwrite) {
+		if (!md->core.overwrite) {
 			WARN_ONCE(1, "failed to keep up with mmap data. (warn only once)\n");
 
 			md->core.prev = head;
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index a3dd53f2bfb8..d3e74c8da51a 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -22,7 +22,6 @@ struct aiocb;
  */
 struct mmap {
 	struct perf_mmap	core;
-	bool		 overwrite;
 	struct auxtrace_mmap auxtrace_mmap;
 	char		 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
 #ifdef HAVE_AIO_SUPPORT
-- 
2.21.0

