Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC47C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F8A217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbfH0I1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:27:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42816 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729879AbfH0I0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:26:30 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2Wo1-0007rF-Rh; Tue, 27 Aug 2019 10:26:21 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7AECD1C0DDF;
        Tue, 27 Aug 2019 10:26:18 +0200 (CEST)
Date:   Tue, 27 Aug 2019 08:26:18 -0000
From:   tip-bot2 for Jiri Olsa <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Add PERF_RECORD_MMAP 'struct mmap_event' to
 perf/event.h
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190825181752.722-2-jolsa@kernel.org>
References: <20190825181752.722-2-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <156689437839.24521.1370616781309040716.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     1345e2ee87a83c758f336f03f7fb305bc5e24490
Gitweb:        https://git.kernel.org/tip/1345e2ee87a83c758f336f03f7fb305bc5e24490
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Sun, 25 Aug 2019 20:17:41 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 26 Aug 2019 19:38:04 -03:00

libperf: Add PERF_RECORD_MMAP 'struct mmap_event' to perf/event.h

Move the mmap_event event definition to libperf's event.h header
include.

In order to keep libperf simple, we switch 'u64/u32/u16/u8' types used
events to their generic '__u*' versions.

Perf added 'u*' types mainly to ease up printing __u64 values as stated
in the linux/types.h comment:

  /*
   * We define u64 as uint64_t for every architecture
   * so that we can print it with "%"PRIx64 without getting warnings.
   *
   * typedef __u64 u64;
   * typedef __s64 s64;
   */

Add  and use new PRI_lu64 and PRI_lx64 macros for that.  Use extra '_'
to ease up reading and differentiate them from standard PRI*64 macros.

Committer notes:

Fixup the PRI_l[ux]64 macros on 32-bit arches, conditionally defining it
with that extra 'l' modifier only on arches where __u64 is long long,
leaving it aside on 32-bit arches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190825181752.722-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 18 ++++++++++++++++++
 tools/perf/util/event.c             |  2 +-
 tools/perf/util/event.h             | 22 ++++++++++++++--------
 tools/perf/util/python.c            |  4 ++--
 4 files changed, 35 insertions(+), 11 deletions(-)
 create mode 100644 tools/perf/lib/include/perf/event.h

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
new file mode 100644
index 0000000..13fe15a
--- /dev/null
+++ b/tools/perf/lib/include/perf/event.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_EVENT_H
+#define __LIBPERF_EVENT_H
+
+#include <linux/perf_event.h>
+#include <linux/types.h>
+#include <linux/limits.h>
+
+struct mmap_event {
+	struct perf_event_header header;
+	__u32			 pid, tid;
+	__u64			 start;
+	__u64			 len;
+	__u64			 pgoff;
+	char			 filename[PATH_MAX];
+};
+
+#endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 332edef..43c8625 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1353,7 +1353,7 @@ int perf_event__process_bpf_event(struct perf_tool *tool __maybe_unused,
 
 size_t perf_event__fprintf_mmap(union perf_event *event, FILE *fp)
 {
-	return fprintf(fp, " %d/%d: [%#" PRIx64 "(%#" PRIx64 ") @ %#" PRIx64 "]: %c %s\n",
+	return fprintf(fp, " %d/%d: [%#" PRI_lx64 "(%#" PRI_lx64 ") @ %#" PRI_lx64 "]: %c %s\n",
 		       event->mmap.pid, event->mmap.tid, event->mmap.start,
 		       event->mmap.len, event->mmap.pgoff,
 		       (event->header.misc & PERF_RECORD_MISC_MMAP_DATA) ? 'r' : 'x',
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 0e164e8..f43eff2 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -7,19 +7,25 @@
 #include <linux/kernel.h>
 #include <linux/bpf.h>
 #include <linux/perf_event.h>
+#include <perf/event.h>
 
 #include "../perf.h"
 #include "build-id.h"
 #include "perf_regs.h"
 
-struct mmap_event {
-	struct perf_event_header header;
-	u32 pid, tid;
-	u64 start;
-	u64 len;
-	u64 pgoff;
-	char filename[PATH_MAX];
-};
+#ifdef __LP64__
+/*
+ * /usr/include/inttypes.h uses just 'lu' for PRIu64, but we end up defining
+ * __u64 as long long unsigned int, and then -Werror=format= kicks in and
+ * complains of the mismatched types, so use these two special extra PRI
+ * macros to overcome that.
+ */
+#define PRI_lu64 "l" PRIu64
+#define PRI_lx64 "l" PRIx64
+#else
+#define PRI_lu64 PRIu64
+#define PRI_lx64 PRIx64
+#endif
 
 struct mmap2_event {
 	struct perf_event_header header;
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 75ecc32..55ff0c3 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -130,8 +130,8 @@ static PyObject *pyrf_mmap_event__repr(struct pyrf_event *pevent)
 	PyObject *ret;
 	char *s;
 
-	if (asprintf(&s, "{ type: mmap, pid: %u, tid: %u, start: %#" PRIx64 ", "
-			 "length: %#" PRIx64 ", offset: %#" PRIx64 ", "
+	if (asprintf(&s, "{ type: mmap, pid: %u, tid: %u, start: %#" PRI_lx64 ", "
+			 "length: %#" PRI_lx64 ", offset: %#" PRI_lx64 ", "
 			 "filename: %s }",
 		     pevent->event.mmap.pid, pevent->event.mmap.tid,
 		     pevent->event.mmap.start, pevent->event.mmap.len,
