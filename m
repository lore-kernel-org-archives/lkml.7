Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BC0C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBBF520693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="AnI1bx/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbfG3S2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:28:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40351 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfG3S2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:28:08 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIRueh3330138
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:27:56 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIRueh3330138
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564511277;
        bh=dxJbtl4/otJ2aQWWJR0CyGiTiB2QSntuTNV6GbD5jeI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=AnI1bx/dO9IxBczSj2/iQMsNQ4ED54UOcW7lZXdELBt8R+vw/JxnX9E6TXWOJ00mj
         /qLNPGo0nsfFfi++CcFp6EjSr6M2MfCYEngNEog0MRTWuDd3mDn77Y7nS1owagVfb4
         8dUb5DLybu2PQN8LP+RCd9UHfDY/ABBgiHgw15mHcNM1W3wEplDKIIu3yMCs+YhGfT
         zkK9zD88DiD51XPIphPHaGYdLEA/qWK1UG+LhhCzcu4gK6z9621CDZz6ep4OrJCjFo
         mVKtTZeyznz1L8wi3sYx+wKbHj2sfNy1xOZFQ68YwY8XJZlZX87u5qdx0T8TDwvZBr
         GLUnzuP/G87Nw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIRtd93330134;
        Tue, 30 Jul 2019 11:27:55 -0700
Date:   Tue, 30 Jul 2019 11:27:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-959b83c769389b24d64759f60e64c4c62620ff02@git.kernel.org>
Cc:     jolsa@kernel.org, acme@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mpetlan@redhat.com,
        tglx@linutronix.de, alexey.budankov@linux.intel.com,
        mingo@kernel.org, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        peterz@infradead.org
Reply-To: alexey.budankov@linux.intel.com, ak@linux.intel.com,
          alexander.shishkin@linux.intel.com, peterz@infradead.org,
          namhyung@kernel.org, mingo@kernel.org, tglx@linutronix.de,
          mpetlan@redhat.com, jolsa@kernel.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, acme@redhat.com
In-Reply-To: <20190721112506.12306-29-jolsa@kernel.org>
References: <20190721112506.12306-29-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Add perf_cpu_map struct
Git-Commit-ID: 959b83c769389b24d64759f60e64c4c62620ff02
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

Commit-ID:  959b83c769389b24d64759f60e64c4c62620ff02
Gitweb:     https://git.kernel.org/tip/959b83c769389b24d64759f60e64c4c62620ff02
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:15 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:44 -0300

libperf: Add perf_cpu_map struct

Add perf_cpu_map struct to libperf.

It's added as a declaration into:

  include/perf/cpumap.h

which will be included by users.

The perf_cpu_map struct definition is added into:

  include/internal/cpumap.h

which is not to be included by users, but shared within perf and
libperf.

We tried the total separation of the perf_cpu_map struct in libperf, but
it lead to complications and much bigger changes in perf code, so we
decided to share the declaration.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-29-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/Build                     |  1 +
 tools/perf/lib/cpumap.c                  |  5 +++++
 tools/perf/lib/include/internal/cpumap.h | 13 +++++++++++++
 tools/perf/lib/include/perf/cpumap.h     |  7 +++++++
 tools/perf/util/cpumap.h                 |  7 +------
 5 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/tools/perf/lib/Build b/tools/perf/lib/Build
index 5196958cec01..195b274db49a 100644
--- a/tools/perf/lib/Build
+++ b/tools/perf/lib/Build
@@ -1 +1,2 @@
 libperf-y += core.o
+libperf-y += cpumap.o
diff --git a/tools/perf/lib/cpumap.c b/tools/perf/lib/cpumap.c
new file mode 100644
index 000000000000..86a199c26f20
--- /dev/null
+++ b/tools/perf/lib/cpumap.c
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <perf/cpumap.h>
+#include <stdlib.h>
+#include <linux/refcount.h>
+#include <internal/cpumap.h>
diff --git a/tools/perf/lib/include/internal/cpumap.h b/tools/perf/lib/include/internal/cpumap.h
new file mode 100644
index 000000000000..53ce95374b05
--- /dev/null
+++ b/tools/perf/lib/include/internal/cpumap.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_INTERNAL_CPUMAP_H
+#define __LIBPERF_INTERNAL_CPUMAP_H
+
+#include <linux/refcount.h>
+
+struct perf_cpu_map {
+	refcount_t	refcnt;
+	int		nr;
+	int		map[];
+};
+
+#endif /* __LIBPERF_INTERNAL_CPUMAP_H */
diff --git a/tools/perf/lib/include/perf/cpumap.h b/tools/perf/lib/include/perf/cpumap.h
new file mode 100644
index 000000000000..8355d3ce7d0c
--- /dev/null
+++ b/tools/perf/lib/include/perf/cpumap.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_CPUMAP_H
+#define __LIBPERF_CPUMAP_H
+
+struct perf_cpu_map;
+
+#endif /* __LIBPERF_CPUMAP_H */
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 22729beae959..c2ba9ae195f7 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -5,16 +5,11 @@
 #include <stdio.h>
 #include <stdbool.h>
 #include <linux/refcount.h>
+#include <internal/cpumap.h>
 
 #include "perf.h"
 #include "util/debug.h"
 
-struct perf_cpu_map {
-	refcount_t refcnt;
-	int nr;
-	int map[];
-};
-
 struct perf_cpu_map *cpu_map__new(const char *cpu_list);
 struct perf_cpu_map *cpu_map__empty_new(int nr);
 struct perf_cpu_map *cpu_map__dummy_new(void);
