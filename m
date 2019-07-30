Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BC3C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A0522064A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="cLnq71dQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbfG3Sad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:30:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45909 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfG3Sac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:30:32 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIUKim3330552
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:30:21 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIUKim3330552
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564511421;
        bh=1HgJcWLOdJ+UCBdx68Zt7Je8ZcaCRiLexzxRyOM7HIc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=cLnq71dQREW//MsgYZjstC+y+fRQZnsU46ei2AqfkeGMedMDVleLy6Fs92VdL/MtP
         o8VEH+kfWJf5cW+Otc5rhLnqwCthNjuikx6FvzRuYr1diHoPwaLQO+WAJ8z2DVuOL5
         P6UMoiix5R8huwvjIcZNHvmaKx3Ex2UeX60lwBXV/IoMDZjUY4EjqhFxS7hOAS9ooI
         QdrrGBjYxFcPmFcF3xF/4LH0S/YuEGrV9Fi/fUnHWd4GdWFQq3/XHh1gKcsgMMbK3U
         E/IsEtfKR2zTPeDXKun2yLaHVNkPv9z6z0WleFTelQLxxLdl0c7J+7HULq9dGpKm+P
         OqlX3s/gKpLlA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIUK783330547;
        Tue, 30 Jul 2019 11:30:20 -0700
Date:   Tue, 30 Jul 2019 11:30:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-07acd22677ac6bb2db404d1d258e8c7d06ca7706@git.kernel.org>
Cc:     peterz@infradead.org, acme@redhat.com, jolsa@kernel.org,
        mpetlan@redhat.com, tglx@linutronix.de,
        alexey.budankov@linux.intel.com, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, hpa@zytor.com,
        namhyung@kernel.org, ak@linux.intel.com,
        linux-kernel@vger.kernel.org
Reply-To: mpetlan@redhat.com, alexey.budankov@linux.intel.com,
          peterz@infradead.org, acme@redhat.com, jolsa@kernel.org,
          tglx@linutronix.de, mingo@kernel.org,
          alexander.shishkin@linux.intel.com, hpa@zytor.com,
          namhyung@kernel.org, ak@linux.intel.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190721112506.12306-32-jolsa@kernel.org>
References: <20190721112506.12306-32-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Add perf_thread_map struct
Git-Commit-ID: 07acd22677ac6bb2db404d1d258e8c7d06ca7706
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

Commit-ID:  07acd22677ac6bb2db404d1d258e8c7d06ca7706
Gitweb:     https://git.kernel.org/tip/07acd22677ac6bb2db404d1d258e8c7d06ca7706
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:18 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:44 -0300

libperf: Add perf_thread_map struct

Add perf_thread_map struct to libperf.

It's added as a declaration into into:

  include/perf/threadmap.h

which will be included by users.

The perf_thread_map struct definition is added into:

  include/internal/threadmap.h

which is not to be included by users, but shared within perf and
libperf.

We tried the total separation of the perf_thread_map struct in libperf,
but it lead to complications and much bigger changes in perf code, so we
decided to share the declaration.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-32-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/Build                        |  1 +
 tools/perf/lib/include/internal/threadmap.h | 21 +++++++++++++++++++++
 tools/perf/lib/include/perf/threadmap.h     |  7 +++++++
 tools/perf/lib/threadmap.c                  |  5 +++++
 tools/perf/util/thread_map.h                | 13 +------------
 5 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/tools/perf/lib/Build b/tools/perf/lib/Build
index 195b274db49a..9beadfc81a71 100644
--- a/tools/perf/lib/Build
+++ b/tools/perf/lib/Build
@@ -1,2 +1,3 @@
 libperf-y += core.o
 libperf-y += cpumap.o
+libperf-y += threadmap.o
diff --git a/tools/perf/lib/include/internal/threadmap.h b/tools/perf/lib/include/internal/threadmap.h
new file mode 100644
index 000000000000..c8088005a9ab
--- /dev/null
+++ b/tools/perf/lib/include/internal/threadmap.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_INTERNAL_THREADMAP_H
+#define __LIBPERF_INTERNAL_THREADMAP_H
+
+#include <linux/refcount.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+struct thread_map_data {
+	pid_t	 pid;
+	char	*comm;
+};
+
+struct perf_thread_map {
+	refcount_t	refcnt;
+	int		nr;
+	int		err_thread;
+	struct thread_map_data map[];
+};
+
+#endif /* __LIBPERF_INTERNAL_THREADMAP_H */
diff --git a/tools/perf/lib/include/perf/threadmap.h b/tools/perf/lib/include/perf/threadmap.h
new file mode 100644
index 000000000000..dc3a3837b56f
--- /dev/null
+++ b/tools/perf/lib/include/perf/threadmap.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_THREADMAP_H
+#define __LIBPERF_THREADMAP_H
+
+struct perf_thread_map;
+
+#endif /* __LIBPERF_THREADMAP_H */
diff --git a/tools/perf/lib/threadmap.c b/tools/perf/lib/threadmap.c
new file mode 100644
index 000000000000..163dc609b909
--- /dev/null
+++ b/tools/perf/lib/threadmap.c
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <perf/threadmap.h>
+#include <stdlib.h>
+#include <linux/refcount.h>
+#include <internal/threadmap.h>
diff --git a/tools/perf/util/thread_map.h b/tools/perf/util/thread_map.h
index 9358b1b6e657..5a7be6f8934f 100644
--- a/tools/perf/util/thread_map.h
+++ b/tools/perf/util/thread_map.h
@@ -5,18 +5,7 @@
 #include <sys/types.h>
 #include <stdio.h>
 #include <linux/refcount.h>
-
-struct thread_map_data {
-	pid_t    pid;
-	char	*comm;
-};
-
-struct perf_thread_map {
-	refcount_t refcnt;
-	int nr;
-	int err_thread;
-	struct thread_map_data map[];
-};
+#include <internal/threadmap.h>
 
 struct thread_map_event;
 
