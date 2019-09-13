Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E8FC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01CE920717
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381099;
	bh=HCW1o+vAyykWFZJUC3XNiXGzGDTP2I3cpG7Huhq9HJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Oo0+MgU1bkdo0Ul5pASNqoAG+gQHZpHSG2MiYn3L09A1HLx3DBAobVFaxU37tD7No
	 jdJ9JI8EVw25j+efdvkvAbFxN8zFdG6b6g0M181ZPG0Wk4fP9YjWz6WbKVWA/8BkoY
	 7w+aLqEi3QaSaEkLHx3TkEz7y3+RFVDnJKN83B10=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391261AbfIMNY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:24:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59056 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391246AbfIMNYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:24:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 19D8C307D853;
        Fri, 13 Sep 2019 13:24:54 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C0D05C22F;
        Fri, 13 Sep 2019 13:24:51 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 22/73] libperf: Move pollfd from struct evlist to struct perf_evlist
Date:   Fri, 13 Sep 2019 15:23:04 +0200
Message-Id: <20190913132355.21634-23-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 13 Sep 2019 13:24:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving pollfd from struct evlist to struct perf_evlist
it will be used in following patches.

Link: http://lkml.kernel.org/n/tip-g6auuaej31nsusuevuhcgxli@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-kvm.c                 |  2 +-
 tools/perf/lib/include/internal/evlist.h |  2 ++
 tools/perf/util/evlist.c                 | 18 +++++++++---------
 tools/perf/util/evlist.h                 |  1 -
 tools/perf/util/python.c                 |  6 +++---
 5 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 2b8e71d0a722..66acac16bcb2 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -978,7 +978,7 @@ static int kvm_events_live_report(struct perf_kvm_stat *kvm)
 	evlist__enable(kvm->evlist);
 
 	while (!done) {
-		struct fdarray *fda = &kvm->evlist->pollfd;
+		struct fdarray *fda = &kvm->evlist->core.pollfd;
 		int rc;
 
 		rc = perf_kvm__mmap_read(kvm);
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index 01b813616440..8a4eb66fbf3a 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -3,6 +3,7 @@
 #define __LIBPERF_INTERNAL_EVLIST_H
 
 #include <linux/list.h>
+#include <api/fd/array.h>
 
 struct perf_cpu_map;
 struct perf_thread_map;
@@ -15,6 +16,7 @@ struct perf_evlist {
 	struct perf_thread_map	*threads;
 	int			 nr_mmaps;
 	size_t			 mmap_len;
+	struct fdarray		 pollfd;
 };
 
 /**
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 07f02afa3407..8f5b28eefde7 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -60,7 +60,7 @@ void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
 		INIT_HLIST_HEAD(&evlist->heads[i]);
 	perf_evlist__init(&evlist->core);
 	perf_evlist__set_maps(&evlist->core, cpus, threads);
-	fdarray__init(&evlist->pollfd, 64);
+	fdarray__init(&evlist->core.pollfd, 64);
 	evlist->workload.pid = -1;
 	evlist->bkw_mmap_state = BKW_MMAP_NOTREADY;
 }
@@ -141,7 +141,7 @@ void evlist__exit(struct evlist *evlist)
 {
 	zfree(&evlist->mmap);
 	zfree(&evlist->overwrite_mmap);
-	fdarray__exit(&evlist->pollfd);
+	fdarray__exit(&evlist->core.pollfd);
 }
 
 void evlist__delete(struct evlist *evlist)
@@ -415,8 +415,8 @@ int perf_evlist__alloc_pollfd(struct evlist *evlist)
 			nfds += nr_cpus * nr_threads;
 	}
 
-	if (fdarray__available_entries(&evlist->pollfd) < nfds &&
-	    fdarray__grow(&evlist->pollfd, nfds) < 0)
+	if (fdarray__available_entries(&evlist->core.pollfd) < nfds &&
+	    fdarray__grow(&evlist->core.pollfd, nfds) < 0)
 		return -ENOMEM;
 
 	return 0;
@@ -425,13 +425,13 @@ int perf_evlist__alloc_pollfd(struct evlist *evlist)
 static int __perf_evlist__add_pollfd(struct evlist *evlist, int fd,
 				     struct mmap *map, short revent)
 {
-	int pos = fdarray__add(&evlist->pollfd, fd, revent | POLLERR | POLLHUP);
+	int pos = fdarray__add(&evlist->core.pollfd, fd, revent | POLLERR | POLLHUP);
 	/*
 	 * Save the idx so that when we filter out fds POLLHUP'ed we can
 	 * close the associated evlist->mmap[] entry.
 	 */
 	if (pos >= 0) {
-		evlist->pollfd.priv[pos].ptr = map;
+		evlist->core.pollfd.priv[pos].ptr = map;
 
 		fcntl(fd, F_SETFL, O_NONBLOCK);
 	}
@@ -455,13 +455,13 @@ static void perf_evlist__munmap_filtered(struct fdarray *fda, int fd,
 
 int perf_evlist__filter_pollfd(struct evlist *evlist, short revents_and_mask)
 {
-	return fdarray__filter(&evlist->pollfd, revents_and_mask,
+	return fdarray__filter(&evlist->core.pollfd, revents_and_mask,
 			       perf_evlist__munmap_filtered, NULL);
 }
 
 int perf_evlist__poll(struct evlist *evlist, int timeout)
 {
-	return fdarray__poll(&evlist->pollfd, timeout);
+	return fdarray__poll(&evlist->core.pollfd, timeout);
 }
 
 static void perf_evlist__id_hash(struct evlist *evlist,
@@ -1008,7 +1008,7 @@ int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 	if (!evlist->mmap)
 		return -ENOMEM;
 
-	if (evlist->pollfd.entries == NULL && perf_evlist__alloc_pollfd(evlist) < 0)
+	if (evlist->core.pollfd.entries == NULL && perf_evlist__alloc_pollfd(evlist) < 0)
 		return -ENOMEM;
 
 	evlist->core.mmap_len = evlist__mmap_size(pages);
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 3767866e98c1..b8f03452196f 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -36,7 +36,6 @@ struct evlist {
 		int	cork_fd;
 		pid_t	pid;
 	} workload;
-	struct fdarray	 pollfd;
 	struct mmap *mmap;
 	struct mmap *overwrite_mmap;
 	struct evsel *selected;
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index b71b899407df..fdc787cfa9f7 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -935,17 +935,17 @@ static PyObject *pyrf_evlist__get_pollfd(struct pyrf_evlist *pevlist,
         PyObject *list = PyList_New(0);
 	int i;
 
-	for (i = 0; i < evlist->pollfd.nr; ++i) {
+	for (i = 0; i < evlist->core.pollfd.nr; ++i) {
 		PyObject *file;
 #if PY_MAJOR_VERSION < 3
-		FILE *fp = fdopen(evlist->pollfd.entries[i].fd, "r");
+		FILE *fp = fdopen(evlist->core.pollfd.entries[i].fd, "r");
 
 		if (fp == NULL)
 			goto free_list;
 
 		file = PyFile_FromFile(fp, "perf", "r", NULL);
 #else
-		file = PyFile_FromFd(evlist->pollfd.entries[i].fd, "perf", "r", -1,
+		file = PyFile_FromFd(evlist->core.pollfd.entries[i].fd, "perf", "r", -1,
 				     NULL, NULL, NULL, 0);
 #endif
 		if (file == NULL)
-- 
2.21.0

