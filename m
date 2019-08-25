Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C8CC3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 18:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BEA32173E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 18:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566757082;
	bh=3sTXO3k7KG6vnC06rcCPCEg+Jhr6QKTdPQ4vTCksLYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TE0k2572xKd9KW/D5hin4oORYwHK/ZYEg/361xnsj6L7inZAiB1oJ9s+1sUR/fQ4V
	 NxWa+8doOe+7Vi+aCnzXv5XAvOdi2pHANNmKWFa8ogysAzxdyPTzbnIQUlBbWovQ59
	 ADx4eyc0JCc6/5w3tlccq3CXF/6YK2DSaVMvh0zw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbfHYSSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 14:18:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43718 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728360AbfHYSR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 14:17:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 70A97A28883;
        Sun, 25 Aug 2019 18:17:58 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-45.brq.redhat.com [10.40.204.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7BE205D9C3;
        Sun, 25 Aug 2019 18:17:56 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 01/12] libperf: Add mmap_event to perf/event.h
Date:   Sun, 25 Aug 2019 20:17:41 +0200
Message-Id: <20190825181752.722-2-jolsa@kernel.org>
In-Reply-To: <20190825181752.722-1-jolsa@kernel.org>
References: <20190825181752.722-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Sun, 25 Aug 2019 18:17:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving mmap_event event definition into libperf's event.h
header include.

In order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Perf added 'u*' types mainly to ease up printing __u64 values
as stated in the linux/types.h comment:

  /*
   * We define u64 as uint64_t for every architecture
   * so that we can print it with "%"PRIx64 without getting warnings.
   *
   * typedef __u64 u64;
   * typedef __s64 s64;
   */

Adding and using new PRI_lu64 and PRI_lx64 macros to be used for
that.  Using extra '_' to ease up the reading and differentiate
them from standard PRI*64 macros.

Link: http://lkml.kernel.org/n/tip-8d1478x1wpj2ongy6t8ttn3j@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/include/perf/event.h | 18 ++++++++++++++++++
 tools/perf/util/event.c             |  2 +-
 tools/perf/util/event.h             | 11 +++--------
 tools/perf/util/python.c            |  4 ++--
 4 files changed, 24 insertions(+), 11 deletions(-)
 create mode 100644 tools/perf/lib/include/perf/event.h

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
new file mode 100644
index 000000000000..8eeba16e3ff7
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
+	__u32 pid, tid;
+	__u64 start;
+	__u64 len;
+	__u64 pgoff;
+	char filename[PATH_MAX];
+};
+
+#endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 332edef8d394..43c86257e7fa 100644
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
index 0e164e8ae28d..b244f9e77fa8 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -7,19 +7,14 @@
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
+#define PRI_lu64 "l" PRIu64
+#define PRI_lx64 "l" PRIx64
 
 struct mmap2_event {
 	struct perf_event_header header;
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 75ecc32a4427..55ff0c3182d6 100644
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
-- 
2.21.0

