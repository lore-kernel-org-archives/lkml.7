Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F511C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EDBB222C7
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824715;
	bh=kauCKVqe/8jOkeuELEjCS0Q+C5R+jfzwpWXwNpA5vCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HGaPRPOe+shWB/rUF9Juzs/R9/C/Ej38vGX8IUAJAlI87d/8VxRtEJvHKeZUM0CCW
	 33kk517opLQO2l+311zmhasyTzpwtkec6rlMuOqbMvbRmfaaSzIun6R3TnPCZ06Hnk
	 ayZ0ejsvetINdt+lWzKuuDh3t4vBvxOWlUzdlMws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbfJKULx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:11:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729449AbfJKULv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:11:51 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD6732246B;
        Fri, 11 Oct 2019 20:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824710;
        bh=kauCKVqe/8jOkeuELEjCS0Q+C5R+jfzwpWXwNpA5vCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1IPtMA0LHpjeK7PnGVJMDaP8yubTEzOReFCCi+hQh03N0mZRoABXCyqYy5tyrBnN5
         KR3mEowdpC8biJSu+/TCRoqX9UZHAKhouIsiOnQhCcZRB/RIskj9CkUOqezl3Cicta
         J9Q3TlAkHagFkFFvd93NtlzxyX/v+jb+tD6uaAfM=
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
Subject: [PATCH 67/69] libperf: Adopt perf_evlist__filter_pollfd() from tools/perf
Date:   Fri, 11 Oct 2019 17:05:57 -0300
Message-Id: <20191011200559.7156-68-acme@kernel.org>
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

Introduce the perf_evlist__filter_pollfd function and export it in the
perf/evlist.h header, so that libperf users can check if the descriptor
is still alive.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191007125344.14268-27-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
index 031ace3696a2..21b77efa802c 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -423,19 +423,9 @@ int evlist__add_pollfd(struct evlist *evlist, int fd)
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

