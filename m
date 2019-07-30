Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86368C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488E22064A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="B4nUYjh7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbfG3Scs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:32:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48139 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfG3Scs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:32:48 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIWZMu3330742
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:32:35 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIWZMu3330742
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564511556;
        bh=c2LKswjlz4Flc2ecqtZLxkKTd5lg0UkMZEQqDETt2pQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=B4nUYjh7Rm3tGoubhIyb1/FCRdOYXkwioNxzwb2gYHLlhX+5ERqQnHynKj+TFmaG9
         VX1+5U4+K+cE6j7/iL3Y1CY7TlxQsaY53WW2vag5VYqAl9nZk+sjqmx0N6PQwRLRNJ
         7imUeukQ9QBUdnDVUAZlK+o3ri0iuGyeTt69BGP/W+az+OnIuCCnlwtm2Jt/2azJ5d
         EPdBMOGXYImrJBZ9oaN4tAc+Ci8VeeWRM1KNuwu0kNEkNLFhErJtb4/5bY3nHmSZ03
         RXAHKi2whzy1GmNz3ospNas3wr1juJSaCut0DRmthCMY64oatIGHgyxmoozYkRLh4C
         z9f+Z5XrzDTqA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIWZhl3330739;
        Tue, 30 Jul 2019 11:32:35 -0700
Date:   Tue, 30 Jul 2019 11:32:35 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-285a30c36d1e18e7e2afa24dae50ba5596be45e7@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@kernel.org,
        alexey.budankov@linux.intel.com, hpa@zytor.com,
        alexander.shishkin@linux.intel.com, mpetlan@redhat.com,
        acme@redhat.com, namhyung@kernel.org, ak@linux.intel.com,
        jolsa@kernel.org
Reply-To: hpa@zytor.com, tglx@linutronix.de, peterz@infradead.org,
          mingo@kernel.org, linux-kernel@vger.kernel.org,
          alexey.budankov@linux.intel.com, acme@redhat.com,
          namhyung@kernel.org, jolsa@kernel.org, ak@linux.intel.com,
          alexander.shishkin@linux.intel.com, mpetlan@redhat.com
In-Reply-To: <20190721112506.12306-35-jolsa@kernel.org>
References: <20190721112506.12306-35-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Add perf_evlist and perf_evsel structs
Git-Commit-ID: 285a30c36d1e18e7e2afa24dae50ba5596be45e7
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

Commit-ID:  285a30c36d1e18e7e2afa24dae50ba5596be45e7
Gitweb:     https://git.kernel.org/tip/285a30c36d1e18e7e2afa24dae50ba5596be45e7
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:21 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:44 -0300

libperf: Add perf_evlist and perf_evsel structs

Add the perf_evlist and perf_evsel structs to libperf.

It's added as a declarations into:

  include/perf/evlist.h
  include/perf/evsel.h

which will be included by users.

The definitions are added into:

  include/internal/evlist.h
  include/internal/evsel.h

which is not to be included by users, but shared
within perf and libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-35-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/Build                     | 2 ++
 tools/perf/lib/evlist.c                  | 4 ++++
 tools/perf/lib/evsel.c                   | 4 ++++
 tools/perf/lib/include/internal/evlist.h | 9 +++++++++
 tools/perf/lib/include/internal/evsel.h  | 9 +++++++++
 tools/perf/lib/include/perf/evlist.h     | 7 +++++++
 tools/perf/lib/include/perf/evsel.h      | 7 +++++++
 7 files changed, 42 insertions(+)

diff --git a/tools/perf/lib/Build b/tools/perf/lib/Build
index 9beadfc81a71..b27c1543b046 100644
--- a/tools/perf/lib/Build
+++ b/tools/perf/lib/Build
@@ -1,3 +1,5 @@
 libperf-y += core.o
 libperf-y += cpumap.o
 libperf-y += threadmap.o
+libperf-y += evsel.o
+libperf-y += evlist.o
diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
new file mode 100644
index 000000000000..646bdd518793
--- /dev/null
+++ b/tools/perf/lib/evlist.c
@@ -0,0 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <perf/evlist.h>
+#include <linux/list.h>
+#include <internal/evlist.h>
diff --git a/tools/perf/lib/evsel.c b/tools/perf/lib/evsel.c
new file mode 100644
index 000000000000..12e86de1994b
--- /dev/null
+++ b/tools/perf/lib/evsel.c
@@ -0,0 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <perf/evsel.h>
+#include <linux/list.h>
+#include <internal/evsel.h>
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
new file mode 100644
index 000000000000..7fbfe5716652
--- /dev/null
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_INTERNAL_EVLIST_H
+#define __LIBPERF_INTERNAL_EVLIST_H
+
+struct perf_evlist {
+	struct list_head	entries;
+};
+
+#endif /* __LIBPERF_INTERNAL_EVLIST_H */
diff --git a/tools/perf/lib/include/internal/evsel.h b/tools/perf/lib/include/internal/evsel.h
new file mode 100644
index 000000000000..690943d0408a
--- /dev/null
+++ b/tools/perf/lib/include/internal/evsel.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_INTERNAL_EVSEL_H
+#define __LIBPERF_INTERNAL_EVSEL_H
+
+struct perf_evsel {
+	struct list_head	node;
+};
+
+#endif /* __LIBPERF_INTERNAL_EVSEL_H */
diff --git a/tools/perf/lib/include/perf/evlist.h b/tools/perf/lib/include/perf/evlist.h
new file mode 100644
index 000000000000..92b0eb39caec
--- /dev/null
+++ b/tools/perf/lib/include/perf/evlist.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_EVLIST_H
+#define __LIBPERF_EVLIST_H
+
+struct perf_evlist;
+
+#endif /* __LIBPERF_EVLIST_H */
diff --git a/tools/perf/lib/include/perf/evsel.h b/tools/perf/lib/include/perf/evsel.h
new file mode 100644
index 000000000000..162bffd43409
--- /dev/null
+++ b/tools/perf/lib/include/perf/evsel.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_EVSEL_H
+#define __LIBPERF_EVSEL_H
+
+struct perf_evsel;
+
+#endif /* __LIBPERF_EVSEL_H */
