Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C0AC76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07202171F
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563708537;
	bh=anluvrGdl5Aglru9VmzO5Yo9y5hQfoMaGsH+95A7T/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pe29NA7SBughuvmWDUljSUx4pBXt0UpmFyC+iNotGoZIIES6QgFKg31ZSrYraJIqE
	 LFmESUvoAFBrk+D//V0jNnM75qd0HBczNdyR7LRHqaoI2H9T472AALYX9AD/Tw15vX
	 RNymMe23QUl++bG6XWZ9OzBn37ezLD+mxOOd1ZIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfGUL24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:28:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53676 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbfGUL24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:28:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EFBC23086262;
        Sun, 21 Jul 2019 11:28:55 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A48F35D9D3;
        Sun, 21 Jul 2019 11:28:51 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 31/79] libperf: Add perf_thread_map struct
Date:   Sun, 21 Jul 2019 13:24:18 +0200
Message-Id: <20190721112506.12306-32-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Sun, 21 Jul 2019 11:28:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding perf_thread_map struct into libperf.

It's added as a declaration into into:
  include/perf/threadmap.h
which will be included by users.

The perf_thread_map struct definition is added into:
  include/internal/threadmap.h

which is not to be included by users, but shared
within perf and libperf.

We tried the total separation of the perf_thread_map struct
in libperf, but it lead to complications and much bigger
changes in perf code, so we decided to share the declaration.

Link: http://lkml.kernel.org/n/tip-vhtr6a8apr7vkh2tou0r8896@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/Build                        |  1 +
 tools/perf/lib/include/internal/threadmap.h | 21 +++++++++++++++++++++
 tools/perf/lib/include/perf/threadmap.h     |  7 +++++++
 tools/perf/lib/threadmap.c                  |  5 +++++
 tools/perf/util/thread_map.h                | 13 +------------
 5 files changed, 35 insertions(+), 12 deletions(-)
 create mode 100644 tools/perf/lib/include/internal/threadmap.h
 create mode 100644 tools/perf/lib/include/perf/threadmap.h
 create mode 100644 tools/perf/lib/threadmap.c

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
 
-- 
2.21.0

