Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57949C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2475C2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455589;
	bh=2BYc+E4VgrhgfU6ObjairTrNQSoyDUWkTI/nxArXl0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R03iT2RD+vpkAxywcVSTS2o81d7/Yj6KcRRDzCvmjM8e7tO3bxntCTd0/If/CYMph
	 hJMDg7iTe24jTD4tyHQlGpjbRk2WZs94btYjjOd6kVoSPuGHndQWAMB5Ps3doInDsZ
	 AIMtGQP8BjiZh5xyL4k8mWP4xLGFhoRaX6VltxOA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732282AbfG3C7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 22:59:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732273AbfG3C7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:59:43 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B147C216C8;
        Tue, 30 Jul 2019 02:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455582;
        bh=2BYc+E4VgrhgfU6ObjairTrNQSoyDUWkTI/nxArXl0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jXYrP0ngyFiEk5LR4XeGb+VGZJLDpMtjBqGDQlYv0dbn3ZLHgIdeNCvzp7aaqBTcz
         cq3I+DpN9VY29dVrSoJng58FAjyHZknD/34Uzh9K7LvS5+XsnS+iGoEXf1mYvFiBch
         eOW6U2rzXyVK1KOKpb1D2U22NKSwPg2z01f8Wc+8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 061/107] libperf: Add perf_evlist and perf_evsel structs
Date:   Mon, 29 Jul 2019 23:55:24 -0300
Message-Id: <20190730025610.22603-62-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
 create mode 100644 tools/perf/lib/evlist.c
 create mode 100644 tools/perf/lib/evsel.c
 create mode 100644 tools/perf/lib/include/internal/evlist.h
 create mode 100644 tools/perf/lib/include/internal/evsel.h
 create mode 100644 tools/perf/lib/include/perf/evlist.h
 create mode 100644 tools/perf/lib/include/perf/evsel.h

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
-- 
2.21.0

