Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBF2C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62AB8206BB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381137;
	bh=fPkJDt3p3d2m4v4nBCALB1JYMrD9cqPGSq5NOJI3LAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ILkAk6nRELjVxKkYZokUtb9C9R4Mlm93el3YjMEA/1laTVO5/HeB3+pjnk77nPHCK
	 mT5nHMeuL4L4r5W/YaBfQe47CiUT/CKzb4LgRa00CL82cdPbbO/tqHajzfGUq7lbTd
	 93sSQiTpNOhVCqp3rkeBJDDEJyzMHvz7n2zP+qm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391397AbfIMNZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:25:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46934 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391387AbfIMNZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:25:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5011310C092F;
        Fri, 13 Sep 2019 13:25:33 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC1715C1D4;
        Fri, 13 Sep 2019 13:25:31 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 37/73] libperf: Add perf_evlist__add_pollfd function
Date:   Fri, 13 Sep 2019 15:23:19 +0200
Message-Id: <20190913132355.21634-38-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Fri, 13 Sep 2019 13:25:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move perf_evlist__add_pollfd function under libperf,
it will be used in following patches.

Also renaming perf's perf_evlist__add_pollfd/perf_evlist__filter_pollfd
to evlist__add_pollfd/evlist__filter_pollfd.

Link: http://lkml.kernel.org/n/tip-ak1oqlj43qsbioo7q9m5fg9t@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-kvm.c                 |  4 ++--
 tools/perf/builtin-record.c              |  2 +-
 tools/perf/builtin-trace.c               |  2 +-
 tools/perf/lib/evlist.c                  | 16 +++++++++++++++
 tools/perf/lib/include/internal/evlist.h |  2 ++
 tools/perf/util/evlist.c                 | 25 ++++--------------------
 tools/perf/util/evlist.h                 |  4 ++--
 7 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 66acac16bcb2..a90c7d4302b9 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -964,10 +964,10 @@ static int kvm_events_live_report(struct perf_kvm_stat *kvm)
 		goto out;
 	}
 
-	if (perf_evlist__add_pollfd(kvm->evlist, kvm->timerfd) < 0)
+	if (evlist__add_pollfd(kvm->evlist, kvm->timerfd) < 0)
 		goto out;
 
-	nr_stdin = perf_evlist__add_pollfd(kvm->evlist, fileno(stdin));
+	nr_stdin = evlist__add_pollfd(kvm->evlist, fileno(stdin));
 	if (nr_stdin < 0)
 		goto out;
 
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index efad7e6a2dca..cb5d750cbbdf 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1619,7 +1619,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 				err = 0;
 			waking++;
 
-			if (perf_evlist__filter_pollfd(rec->evlist, POLLERR | POLLHUP) == 0)
+			if (evlist__filter_pollfd(rec->evlist, POLLERR | POLLHUP) == 0)
 				draining = true;
 		}
 
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 0dc35aa624c5..685935b533f4 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3473,7 +3473,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		int timeout = done ? 100 : -1;
 
 		if (!draining && perf_evlist__poll(evlist, timeout) > 0) {
-			if (perf_evlist__filter_pollfd(evlist, POLLERR | POLLHUP | POLLNVAL) == 0)
+			if (evlist__filter_pollfd(evlist, POLLERR | POLLHUP | POLLNVAL) == 0)
 				draining = true;
 
 			goto again;
diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 0f84f5dc519f..a2c01dcec5ae 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -11,6 +11,9 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <unistd.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <poll.h>
 #include <perf/cpumap.h>
 #include <perf/threadmap.h>
 
@@ -258,3 +261,16 @@ int perf_evlist__alloc_pollfd(struct perf_evlist *evlist)
 
 	return 0;
 }
+
+int perf_evlist__add_pollfd(struct perf_evlist *evlist, int fd,
+			    void *ptr, short revent)
+{
+	int pos = fdarray__add(&evlist->pollfd, fd, revent | POLLERR | POLLHUP);
+
+	if (pos >= 0) {
+		evlist->pollfd.priv[pos].ptr = ptr;
+		fcntl(fd, F_SETFL, O_NONBLOCK);
+	}
+
+	return pos;
+}
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index 88c0dfaf0ddc..9f440ab12b76 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -25,6 +25,8 @@ struct perf_evlist {
 };
 
 int perf_evlist__alloc_pollfd(struct perf_evlist *evlist);
+int perf_evlist__add_pollfd(struct perf_evlist *evlist, int fd,
+			    void *ptr, short revent);
 
 /**
  * __perf_evlist__for_each_entry - iterate thru all the evsels
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 664c8e87ec96..449425d9a033 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -397,26 +397,9 @@ int perf_evlist__enable_event_idx(struct evlist *evlist,
 		return perf_evlist__enable_event_thread(evlist, evsel, idx);
 }
 
-static int __perf_evlist__add_pollfd(struct evlist *evlist, int fd,
-				     struct mmap *map, short revent)
+int evlist__add_pollfd(struct evlist *evlist, int fd)
 {
-	int pos = fdarray__add(&evlist->core.pollfd, fd, revent | POLLERR | POLLHUP);
-	/*
-	 * Save the idx so that when we filter out fds POLLHUP'ed we can
-	 * close the associated evlist->mmap[] entry.
-	 */
-	if (pos >= 0) {
-		evlist->core.pollfd.priv[pos].ptr = map;
-
-		fcntl(fd, F_SETFL, O_NONBLOCK);
-	}
-
-	return pos;
-}
-
-int perf_evlist__add_pollfd(struct evlist *evlist, int fd)
-{
-	return __perf_evlist__add_pollfd(evlist, fd, NULL, POLLIN);
+	return perf_evlist__add_pollfd(&evlist->core, fd, NULL, POLLIN);
 }
 
 static void perf_evlist__munmap_filtered(struct fdarray *fda, int fd,
@@ -428,7 +411,7 @@ static void perf_evlist__munmap_filtered(struct fdarray *fda, int fd,
 		perf_mmap__put(map);
 }
 
-int perf_evlist__filter_pollfd(struct evlist *evlist, short revents_and_mask)
+int evlist__filter_pollfd(struct evlist *evlist, short revents_and_mask)
 {
 	return fdarray__filter(&evlist->core.pollfd, revents_and_mask,
 			       perf_evlist__munmap_filtered, NULL);
@@ -707,7 +690,7 @@ static int evlist__mmap_per_evsel(struct evlist *evlist, int idx,
 		 * Therefore don't add it for polling.
 		 */
 		if (!evsel->core.system_wide &&
-		    __perf_evlist__add_pollfd(evlist, fd, &maps[idx], revent) < 0) {
+		     perf_evlist__add_pollfd(&evlist->core, fd, &maps[idx], revent) < 0) {
 			perf_mmap__put(&maps[idx]);
 			return -1;
 		}
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 9c90df51ce08..6c5455cf5829 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -113,8 +113,8 @@ struct evsel *
 perf_evlist__find_tracepoint_by_name(struct evlist *evlist,
 				     const char *name);
 
-int perf_evlist__add_pollfd(struct evlist *evlist, int fd);
-int perf_evlist__filter_pollfd(struct evlist *evlist, short revents_and_mask);
+int evlist__add_pollfd(struct evlist *evlist, int fd);
+int evlist__filter_pollfd(struct evlist *evlist, short revents_and_mask);
 
 int perf_evlist__poll(struct evlist *evlist, int timeout);
 
-- 
2.21.0

