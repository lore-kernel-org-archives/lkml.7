Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E34DC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFFCF2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="3erIjJ6t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbfG3Sf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:35:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46025 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfG3Sf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:35:57 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIZi323331323
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:35:44 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIZi323331323
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564511745;
        bh=npuACoJxIYTaW7MxgHZFD4DXjT7DkJ/GX8gPDyO1gKg=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=3erIjJ6tbAgRdUsC3ws2r+M9Z6ekDr/t76dT26tDXcvbgRT4DBpRrsCzxTrhj6tBs
         afeto7eBqV1qY1qbuZ7pP6VhUybb10LM4buAfejjIFsfv3YXwg9NhDBssycqRpM9wV
         VC8D0HBshAHgUmFNEMffw4OdaLabuDET5NfUw5CEGTQgflmdj4m8LLVziqSqO0l/H4
         wpEcI325a8I23gX8e9Ffs3JBiJjVUZFCo+zY+eRz9wlZCfw2rI3MUk3AU1DylDOm5c
         X3wNetT7DMSRGFFjKs3tMu0MR+fg4s4tLA1UrMTdnpZoey6r0M13oa4iWzZUHVDzhs
         E8ZD35RHDeO2g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIZhms3331320;
        Tue, 30 Jul 2019 11:35:43 -0700
Date:   Tue, 30 Jul 2019 11:35:43 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-4562a7393996bb28bf629277903a561bfefea177@git.kernel.org>
Cc:     tglx@linutronix.de, acme@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, hpa@zytor.com, jolsa@kernel.org,
        namhyung@kernel.org, ak@linux.intel.com,
        alexey.budankov@linux.intel.com, mingo@kernel.org,
        mpetlan@redhat.com, alexander.shishkin@linux.intel.com
Reply-To: ak@linux.intel.com, jolsa@kernel.org, peterz@infradead.org,
          acme@redhat.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, mingo@kernel.org, mpetlan@redhat.com,
          alexander.shishkin@linux.intel.com,
          alexey.budankov@linux.intel.com, namhyung@kernel.org,
          hpa@zytor.com
In-Reply-To: <20190721112506.12306-39-jolsa@kernel.org>
References: <20190721112506.12306-39-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Add perf_evlist__init() function
Git-Commit-ID: 4562a7393996bb28bf629277903a561bfefea177
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  4562a7393996bb28bf629277903a561bfefea177
Gitweb:     https://git.kernel.org/tip/4562a7393996bb28bf629277903a561bfefea177
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:25 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:44 -0300

libperf: Add perf_evlist__init() function

Add the perf_evlist__init() function to initialize a perf_evlist struct.

Committer testing:

Fix a change in init ordering that was causing this backtrace:

  (gdb) run stat sleep 1
  Starting program: /root/bin/perf stat sleep 1
  Program received signal SIGSEGV, Segmentation fault.
  0x00000000004f6b55 in __perf_evlist__propagate_maps (evlist=0xbb34c0, evsel=0x0) at util/evlist.c:161
  161		if (!evsel->own_cpus || evlist->has_user_cpus) {
  Missing separate debuginfos, use: dnf debuginfo-install bzip2-libs-1.0.6-29.fc30.x86_64 elfutils-libelf-0.176-3.fc30.x86_64 elfutils-libs-0.176-3.fc30.x86_64 glib2-2.60.4-1.fc30.x86_64 libbabeltrace-1.5.6-2.fc30.x86_64 libgcc-9.1.1-1.fc30.x86_64 libunwind-1.3.1-2.fc30.x86_64 libuuid-2.33.2-1.fc30.x86_64 libxcrypt-4.4.6-2.fc30.x86_64 libzstd-1.4.0-1.fc30.x86_64 numactl-libs-2.0.12-2.fc30.x86_64 pcre-8.43-2.fc30.x86_64 perl-libs-5.28.2-436.fc30.x86_64 popt-1.16-17.fc30.x86_64 python2-libs-2.7.16-2.fc30.x86_64 slang-2.3.2-5.fc30.x86_64 xz-libs-5.2.4-5.fc30.x86_64 zlib-1.2.11-15.fc30.x86_64
  (gdb) bt
  #0  0x00000000004f6b55 in __perf_evlist__propagate_maps (evlist=0xbb34c0, evsel=0x0) at util/evlist.c:161
  #1  0x00000000004f6c7a in perf_evlist__propagate_maps (evlist=0xbb34c0) at util/evlist.c:178
  #2  0x00000000004f955e in perf_evlist__set_maps (evlist=0xbb34c0, cpus=0x0, threads=0x0) at util/evlist.c:1128
  #3  0x00000000004f66f8 in evlist__init (evlist=0xbb34c0, cpus=0x0, threads=0x0) at util/evlist.c:52
  #4  0x00000000004f6790 in evlist__new () at util/evlist.c:64
  #5  0x0000000000456071 in cmd_stat (argc=3, argv=0x7fffffffd670) at builtin-stat.c:1705
  #6  0x00000000004dd0fa in run_builtin (p=0xa21e00 <commands+288>, argc=3, argv=0x7fffffffd670) at perf.c:304
  #7  0x00000000004dd367 in handle_internal_command (argc=3, argv=0x7fffffffd670) at perf.c:356
  #8  0x00000000004dd4ae in run_argv (argcp=0x7fffffffd4cc, argv=0x7fffffffd4c0) at perf.c:400
  #9  0x00000000004dd81a in main (argc=3, argv=0x7fffffffd670) at perf.c:522
  (gdb) bt

So move the initialization of the core evlist (calling
perf_evlist__init()) to before perf_evlist__set_maps() in
evlist__init().

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-39-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evlist.c              | 5 +++++
 tools/perf/lib/include/perf/evlist.h | 4 ++++
 tools/perf/lib/libperf.map           | 1 +
 tools/perf/util/evlist.c             | 3 ++-
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 646bdd518793..fdc8c1894b37 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -2,3 +2,8 @@
 #include <perf/evlist.h>
 #include <linux/list.h>
 #include <internal/evlist.h>
+
+void perf_evlist__init(struct perf_evlist *evlist)
+{
+	INIT_LIST_HEAD(&evlist->entries);
+}
diff --git a/tools/perf/lib/include/perf/evlist.h b/tools/perf/lib/include/perf/evlist.h
index 92b0eb39caec..1ddfcca0bd01 100644
--- a/tools/perf/lib/include/perf/evlist.h
+++ b/tools/perf/lib/include/perf/evlist.h
@@ -2,6 +2,10 @@
 #ifndef __LIBPERF_EVLIST_H
 #define __LIBPERF_EVLIST_H
 
+#include <perf/core.h>
+
 struct perf_evlist;
 
+LIBPERF_API void perf_evlist__init(struct perf_evlist *evlist);
+
 #endif /* __LIBPERF_EVLIST_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 54f8503c6d82..5ca6ff6fcdfa 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -10,6 +10,7 @@ LIBPERF_0.0.1 {
 		perf_thread_map__get;
 		perf_thread_map__put;
 		perf_evsel__init;
+		perf_evlist__init;
 	local:
 		*;
 };
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index faf3ffd81d4c..f4aa6cf80559 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -33,6 +33,7 @@
 #include <linux/log2.h>
 #include <linux/err.h>
 #include <linux/zalloc.h>
+#include <perf/evlist.h>
 
 #ifdef LACKS_SIGQUEUE_PROTOTYPE
 int sigqueue(pid_t pid, int sig, const union sigval value);
@@ -48,7 +49,7 @@ void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
 
 	for (i = 0; i < PERF_EVLIST__HLIST_SIZE; ++i)
 		INIT_HLIST_HEAD(&evlist->heads[i]);
-	INIT_LIST_HEAD(&evlist->core.entries);
+	perf_evlist__init(&evlist->core);
 	perf_evlist__set_maps(evlist, cpus, threads);
 	fdarray__init(&evlist->pollfd, 64);
 	evlist->workload.pid = -1;
