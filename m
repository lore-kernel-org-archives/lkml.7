Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12790C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BCB9206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381230;
	bh=mALGsTevCUazf6XAF7PmxXR83AJgoqKrui7HH/OqZP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WI21TdvR6eeCnS23iSlaqVXVCPg6ub0hl7Ec2atXOfprX3GnpETsLE57g6uoogtZC
	 gNg3tyIgrCrdj6tBTm7qgVsn1XUzXJNycWFMrgJEdxevQrqOPxystEium0xiow6HzW
	 OFRXLzAkdSRg+R0BRsVpKQ8gGmhktv5uEsUMZsQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403827AbfIMN0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:26:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56018 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391568AbfIMN0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:26:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6B99FCCFE6;
        Fri, 13 Sep 2019 13:26:35 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C3EFE5C1D4;
        Fri, 13 Sep 2019 13:26:33 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 65/73] libperf: Add perf_evlist__filter_pollfd function
Date:   Fri, 13 Sep 2019 15:23:47 +0200
Message-Id: <20190913132355.21634-66-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 13 Sep 2019 13:26:35 +0000 (UTC)
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
index 8920833afa9e..ee1d364460e6 100644
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
index 198dcf305356..90aee2a635b2 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -41,6 +41,7 @@ LIBPERF_0.0.1 {
 		perf_evlist__poll;
 		perf_evlist__mmap;
 		perf_evlist__munmap;
+		perf_evlist__filter_pollfd;
 		perf_mmap__consume;
 		perf_mmap__read_init;
 		perf_mmap__read_done;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 0c69621e2b2e..9edb0855f711 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -398,19 +398,9 @@ int evlist__add_pollfd(struct evlist *evlist, int fd)
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

