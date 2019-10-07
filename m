Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DB8ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1822190F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570452891;
	bh=0HIkFWtrmh6bwtsoOg0f2mg2sK1ng+R/jcWrtgnjbXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ApEy8orR3KSWn6oVsB8GGL+QGexxlxIOTvtAAS/5MIk07bqjDdXMmko1ok7Kg4LPO
	 RIy0woZog4ncsINnLDT9S/C70NOXPbPFakttOKg//ERUxMrktAslTauIal8Y1qsQ6p
	 cOildLlQZjuzEZgMpG6r+yp7eP9HDiyF38OKsIj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbfJGMyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:54:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60950 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728372AbfJGMyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:54:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E14DAA44AD4;
        Mon,  7 Oct 2019 12:54:48 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9FBBD5DA8D;
        Mon,  7 Oct 2019 12:54:46 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 26/36] libperf: Add perf_evlist__filter_pollfd function
Date:   Mon,  7 Oct 2019 14:53:34 +0200
Message-Id: <20191007125344.14268-27-jolsa@kernel.org>
In-Reply-To: <20191007125344.14268-1-jolsa@kernel.org>
References: <20191007125344.14268-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Mon, 07 Oct 2019 12:54:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding perf_evlist__filter_pollfd function and exporting
it in perf/evlist.h header, so libperf users can check if
descriptor is still alive.

Link: http://lkml.kernel.org/n/tip-7lmjzpk6k2wfhh1os8qw1dxz@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/evlist.c              | 15 +++++++++++++++
 tools/perf/lib/include/perf/evlist.h |  2 ++
 tools/perf/lib/libperf.map           |  1 +
 tools/perf/util/evlist.c             | 12 +-----------
 4 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 9534ad9a572f..65045614c938 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -313,6 +313,21 @@ int perf_evlist__add_pollfd(struct perf_evlist *evlist, int fd,
 	return pos;
 }
 
+static void perf_evlist__munmap_filtered(struct fdarray *fda, int fd,
+					 void *arg __maybe_unused)
+{
+	struct perf_mmap *map = fda->priv[fd].ptr;
+
+	if (map)
+		perf_mmap__put(map);
+}
+
+int perf_evlist__filter_pollfd(struct perf_evlist *evlist, short revents_and_mask)
+{
+	return fdarray__filter(&evlist->pollfd, revents_and_mask,
+			       perf_evlist__munmap_filtered, NULL);
+}
+
 int perf_evlist__poll(struct perf_evlist *evlist, int timeout)
 {
 	return fdarray__poll(&evlist->pollfd, timeout);
diff --git a/tools/perf/lib/include/perf/evlist.h b/tools/perf/lib/include/perf/evlist.h
index 28b6a12a8a2b..16f526e74d13 100644
--- a/tools/perf/lib/include/perf/evlist.h
+++ b/tools/perf/lib/include/perf/evlist.h
@@ -32,6 +32,8 @@ LIBPERF_API void perf_evlist__set_maps(struct perf_evlist *evlist,
 				       struct perf_cpu_map *cpus,
 				       struct perf_thread_map *threads);
 LIBPERF_API int perf_evlist__poll(struct perf_evlist *evlist, int timeout);
+LIBPERF_API int perf_evlist__filter_pollfd(struct perf_evlist *evlist,
+					   short revents_and_mask);
 
 LIBPERF_API int perf_evlist__mmap(struct perf_evlist *evlist, int pages);
 LIBPERF_API void perf_evlist__munmap(struct perf_evlist *evlist);
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 5a18fd1aacf2..2184aba36c3f 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -42,6 +42,7 @@ LIBPERF_0.0.1 {
 		perf_evlist__poll;
 		perf_evlist__mmap;
 		perf_evlist__munmap;
+		perf_evlist__filter_pollfd;
 		perf_mmap__consume;
 		perf_mmap__read_init;
 		perf_mmap__read_done;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 3669ca767340..4910ae711b13 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -399,19 +399,9 @@ int evlist__add_pollfd(struct evlist *evlist, int fd)
 	return perf_evlist__add_pollfd(&evlist->core, fd, NULL, POLLIN);
 }
 
-static void perf_evlist__munmap_filtered(struct fdarray *fda, int fd,
-					 void *arg __maybe_unused)
-{
-	struct perf_mmap *map = fda->priv[fd].ptr;
-
-	if (map)
-		perf_mmap__put(map);
-}
-
 int evlist__filter_pollfd(struct evlist *evlist, short revents_and_mask)
 {
-	return fdarray__filter(&evlist->core.pollfd, revents_and_mask,
-			       perf_evlist__munmap_filtered, NULL);
+	return perf_evlist__filter_pollfd(&evlist->core, revents_and_mask);
 }
 
 int evlist__poll(struct evlist *evlist, int timeout)
-- 
2.21.0

