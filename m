Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFB5C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC8A222CB
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569458177;
	bh=HxsYnc3vkSuwPLiv5SOWZ+3c4ai7exTZxPGAgK+nH7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TR4C38MqhA0mE1PlHwzM3iIwbznuFL/V9NMEZM8P/WcwuEWszzMNHqYNRRZlBNj9D
	 iXZ+Xfb6035lfJi9P8CLnO1lz41vmhBJ9fWRia1OaALBkyB1Tf3duTP0oVBDaFxzar
	 ZutIAILQ3BIrQPyFtKnpKcr2m8KA075RNxz/z79g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390401AbfIZAgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:36:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390321AbfIZAgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:36:11 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20A8F217F4;
        Thu, 26 Sep 2019 00:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458170;
        bh=HxsYnc3vkSuwPLiv5SOWZ+3c4ai7exTZxPGAgK+nH7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aBHVTH3UVIiIFVHq0S8xZNHvKe2kh2Q3pJ0pbZQ8NWwZ1Yr4zZGlHEUbQeNT8ilfW
         AMAJzDYesebdkiA9EZBfl3UJ3n4EgTwhEL//LeSDltR6Ul7Iu04RVmrMVNtK+a3GLU
         684uHH9zgRnJ/q7vyKNP47WEulzYY92IDrVL/ed4=
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
Subject: [PATCH 53/66] libperf: Add perf_evlist__add_pollfd() function
Date:   Wed, 25 Sep 2019 21:32:31 -0300
Message-Id: <20190926003244.13962-54-acme@kernel.org>
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

Move perf_evlist__add_pollfd() from tools/perf to libperf, it will be
used in the following patches.

Also rename perf's perf_evlist__add_pollfd()/perf_evlist__filter_pollfd()
to evlist__add_pollfd()/evlist__filter_pollfd().

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-38-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
index 710a2898ed6c..2227e2f42c09 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -967,10 +967,10 @@ static int kvm_events_live_report(struct perf_kvm_stat *kvm)
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
index 48600c90cc7e..d6daaad348b5 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1624,7 +1624,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 				err = 0;
 			waking++;
 
-			if (perf_evlist__filter_pollfd(rec->evlist, POLLERR | POLLHUP) == 0)
+			if (evlist__filter_pollfd(rec->evlist, POLLERR | POLLHUP) == 0)
 				draining = true;
 		}
 
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 97667287f573..8d9784b5d028 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3475,7 +3475,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		int timeout = done ? 100 : -1;
 
 		if (!draining && perf_evlist__poll(evlist, timeout) > 0) {
-			if (perf_evlist__filter_pollfd(evlist, POLLERR | POLLHUP | POLLNVAL) == 0)
+			if (evlist__filter_pollfd(evlist, POLLERR | POLLHUP | POLLNVAL) == 0)
 				draining = true;
 
 			goto again;
diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 3c3b97f40be0..e4d8b3b7b8fc 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -12,6 +12,9 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <unistd.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <poll.h>
 #include <perf/cpumap.h>
 #include <perf/threadmap.h>
 #include <api/fd/array.h>
@@ -260,3 +263,16 @@ int perf_evlist__alloc_pollfd(struct perf_evlist *evlist)
 
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
index c47f23e7f3c8..051be9a31db9 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -398,26 +398,9 @@ int perf_evlist__enable_event_idx(struct evlist *evlist,
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
@@ -429,7 +412,7 @@ static void perf_evlist__munmap_filtered(struct fdarray *fda, int fd,
 		perf_mmap__put(map);
 }
 
-int perf_evlist__filter_pollfd(struct evlist *evlist, short revents_and_mask)
+int evlist__filter_pollfd(struct evlist *evlist, short revents_and_mask)
 {
 	return fdarray__filter(&evlist->core.pollfd, revents_and_mask,
 			       perf_evlist__munmap_filtered, NULL);
@@ -708,7 +691,7 @@ static int evlist__mmap_per_evsel(struct evlist *evlist, int idx,
 		 * Therefore don't add it for polling.
 		 */
 		if (!evsel->core.system_wide &&
-		    __perf_evlist__add_pollfd(evlist, fd, &maps[idx], revent) < 0) {
+		     perf_evlist__add_pollfd(&evlist->core, fd, &maps[idx], revent) < 0) {
 			perf_mmap__put(&maps[idx]);
 			return -1;
 		}
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index bebbaa9b6325..2eac8aab24a3 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -141,8 +141,8 @@ struct evsel *
 perf_evlist__find_tracepoint_by_name(struct evlist *evlist,
 				     const char *name);
 
-int perf_evlist__add_pollfd(struct evlist *evlist, int fd);
-int perf_evlist__filter_pollfd(struct evlist *evlist, short revents_and_mask);
+int evlist__add_pollfd(struct evlist *evlist, int fd);
+int evlist__filter_pollfd(struct evlist *evlist, short revents_and_mask);
 
 int perf_evlist__poll(struct evlist *evlist, int timeout);
 
-- 
2.21.0

