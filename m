Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0D8C4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E6D206BB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381085;
	bh=VaQRb2WemRS6EFiLntwQzD+NWp/m1bvslcgzanxQqxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=upnsbRZFUNfurUSEfzZiNW/XX2QxTgeXw2aYkueD4WXnJgOWGX07G20DVlMWAFTnE
	 3KWRosj8990/24FoTzNIpJG5rg7eNMHmiRzR86+FHj2NA4aTOf2ZHvoYQhBaqKCwev
	 NcTb//3ogoZQQiZoPqGfHv0OfxbcSOX18YB+b20g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391211AbfIMNYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:24:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58978 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391202AbfIMNYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:24:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 77AE3307D847;
        Fri, 13 Sep 2019 13:24:39 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CCC855C1D4;
        Fri, 13 Sep 2019 13:24:37 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 16/73] libperf: Add overwrite to struct perf_mmap
Date:   Fri, 13 Sep 2019 15:22:58 +0200
Message-Id: <20190913132355.21634-17-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 13 Sep 2019 13:24:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move overwrite from tools/perf's mmap to libperf's perf_mmap struct.

Link: http://lkml.kernel.org/n/tip-5vhlcccldyoa0qceqrnm8pk0@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/include/internal/mmap.h |  1 +
 tools/perf/util/evlist.c               |  2 +-
 tools/perf/util/mmap.c                 | 12 ++++++------
 tools/perf/util/mmap.h                 |  1 -
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
index 5af28668913c..631e58dbc9e6 100644
--- a/tools/perf/lib/include/internal/mmap.h
+++ b/tools/perf/lib/include/internal/mmap.h
@@ -21,6 +21,7 @@ struct perf_mmap {
 	u64		 prev;
 	u64		 start;
 	u64		 end;
+	bool		 overwrite;
 };
 
 #endif /* __LIBPERF_INTERNAL_MMAP_H */
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index f6e0bceec156..98827df5a40a 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -708,7 +708,7 @@ static struct mmap *evlist__alloc_mmap(struct evlist *evlist,
 
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
index 16e4a5ca773d..1dea2abe1de5 100644
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

