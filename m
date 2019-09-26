Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0597C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B75222C1
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569458067;
	bh=/1jo93XhOCEpM/XiKQQLeIGoe2LnIkg2t68hfeGrYLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H3sCnM5faVxi4924TOJ1nBLc+bBLr5vHUk9e1AAXrPloADn1/w4xVp0GZjvjw+8f2
	 N9FXeOtPzek65sOEPvxJ+PT7xnP3yYFBkukbXFBeLG/jQzmeIPH8bZHf4u71kX51DE
	 els4kqzWHQvMtQ3npZoayv9y6cnWzWN4xPOzlDOY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388595AbfIZAe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:34:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388464AbfIZAeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:34:23 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C91F222C4;
        Thu, 26 Sep 2019 00:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458062;
        bh=/1jo93XhOCEpM/XiKQQLeIGoe2LnIkg2t68hfeGrYLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kzlK8wQKbjSO+3o/xsqFb9UTLtmvoZGkP3ZjaBLJXBLxs33AuLnJW1mdOxD56gy8F
         GXbmeHqvWP/li6JzsQ+MaMP/qIFrqtVJjNsAKHWYO1CfvDIQ81jMfuz69xzVEuRRa+
         BTJLxkdf+PuVaQ9rYvvXA1CmXolEkMsATlw6o2r0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 22/66] perf evlist: Adopt backwards ring buffer state enum
Date:   Wed, 25 Sep 2019 21:32:00 -0300
Message-Id: <20190926003244.13962-23-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As this isn't used at all in mmap.h but in evlist.h, so to cut down the
header dependency tree, move it to where it is used.

Also add mmap.h to the places using it but previously getting it
indirectly via evlist.h.

Add missing pthread.h to evlist.h, as it has a pthread_t struct member
and was getting the header via mmap.h.

Noticed while processing a Jiri's libperf batch touching mmap.h, where
almost everything gets rebuilt because evlist.h is so popular, so cut
down't this rebuild the world party.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Link: https://lkml.kernel.org/n/tip-he0uljeftl0xfveh3d6vtode@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/s390/util/auxtrace.c         |  1 +
 tools/perf/arch/x86/tests/perf-time-to-tsc.c |  1 +
 tools/perf/arch/x86/util/intel-bts.c         |  1 +
 tools/perf/arch/x86/util/intel-pt.c          |  1 +
 tools/perf/builtin-kvm.c                     |  1 +
 tools/perf/builtin-record.c                  |  1 +
 tools/perf/builtin-top.c                     |  1 +
 tools/perf/builtin-trace.c                   |  1 +
 tools/perf/tests/backward-ring-buffer.c      |  1 +
 tools/perf/tests/bpf.c                       |  1 +
 tools/perf/tests/code-reading.c              |  1 +
 tools/perf/tests/hists_link.c                |  1 +
 tools/perf/tests/keep-tracking.c             |  1 +
 tools/perf/tests/mmap-basic.c                |  1 +
 tools/perf/tests/openat-syscall-tp-fields.c  |  1 +
 tools/perf/tests/perf-record.c               |  1 +
 tools/perf/tests/sw-clock.c                  |  1 +
 tools/perf/tests/switch-tracking.c           |  1 +
 tools/perf/tests/task-exit.c                 |  1 +
 tools/perf/ui/gtk/hists.c                    |  1 +
 tools/perf/util/annotate.c                   |  1 +
 tools/perf/util/auxtrace.c                   |  1 +
 tools/perf/util/evlist.c                     |  1 +
 tools/perf/util/evlist.h                     | 30 +++++++++++++++++++-
 tools/perf/util/mmap.h                       | 28 ------------------
 tools/perf/util/parse-events.c               |  1 +
 26 files changed, 53 insertions(+), 29 deletions(-)

diff --git a/tools/perf/arch/s390/util/auxtrace.c b/tools/perf/arch/s390/util/auxtrace.c
index b0fb70e38960..0db5c58c98e8 100644
--- a/tools/perf/arch/s390/util/auxtrace.c
+++ b/tools/perf/arch/s390/util/auxtrace.c
@@ -1,4 +1,5 @@
 #include <stdbool.h>
+#include <stdlib.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/bitops.h>
diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
index 42ae47525a76..e1dd5f8894ba 100644
--- a/tools/perf/arch/x86/tests/perf-time-to-tsc.c
+++ b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
@@ -17,6 +17,7 @@
 #include "thread_map.h"
 #include "record.h"
 #include "tsc.h"
+#include "util/mmap.h"
 #include "tests/tests.h"
 
 #include "arch-tests.h"
diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index 090d90e093df..64b409dad6e2 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -15,6 +15,7 @@
 #include "../../util/event.h"
 #include "../../util/evsel.h"
 #include "../../util/evlist.h"
+#include "../../util/mmap.h"
 #include "../../util/session.h"
 #include "../../util/pmu.h"
 #include "../../util/debug.h"
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 3d041b89f018..6c139611d231 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -18,6 +18,7 @@
 #include "../../util/evlist.h"
 #include "../../util/evsel.h"
 #include "../../util/cpumap.h"
+#include "../../util/mmap.h"
 #include <subcmd/parse-options.h>
 #include "../../util/parse-events.h"
 #include "../../util/pmu.h"
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 72debb7bd20d..30852848ed9c 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -5,6 +5,7 @@
 #include "util/build-id.h"
 #include "util/evsel.h"
 #include "util/evlist.h"
+#include "util/mmap.h"
 #include "util/term.h"
 #include "util/symbol.h"
 #include "util/thread.h"
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 093d9ab5633e..1bb3d91c6599 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -20,6 +20,7 @@
 #include "util/evlist.h"
 #include "util/evsel.h"
 #include "util/debug.h"
+#include "util/mmap.h"
 #include "util/target.h"
 #include "util/session.h"
 #include "util/tool.h"
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 771b3ff47dc3..e637a08655db 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -30,6 +30,7 @@
 #include "util/event.h"
 #include "util/machine.h"
 #include "util/map.h"
+#include "util/mmap.h"
 #include "util/session.h"
 #include "util/symbol.h"
 #include "util/synthetic-events.h"
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index ff989351567d..c44280358e58 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -31,6 +31,7 @@
 #include "util/synthetic-events.h"
 #include "util/evlist.h"
 #include "util/evswitch.h"
+#include "util/mmap.h"
 #include <subcmd/pager.h>
 #include <subcmd/exec-cmd.h>
 #include "util/machine.h"
diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
index 3073a68d17b9..c59d3752d48d 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -10,6 +10,7 @@
 #include "tests.h"
 #include "debug.h"
 #include "parse-events.h"
+#include "util/mmap.h"
 #include <errno.h>
 #include <linux/string.h>
 
diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index 964731915498..3c8533fdbce5 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -19,6 +19,7 @@
 #include "llvm.h"
 #include "debug.h"
 #include "parse-events.h"
+#include "util/mmap.h"
 #define NR_ITERS       111
 #define PERF_TEST_BPF_PATH "/sys/fs/bpf/perf_test"
 
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 413783b69006..bc6db3e7a1c5 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -24,6 +24,7 @@
 #include "symbol.h"
 #include "event.h"
 #include "record.h"
+#include "util/mmap.h"
 #include "util/synthetic-events.h"
 #include "thread.h"
 
diff --git a/tools/perf/tests/hists_link.c b/tools/perf/tests/hists_link.c
index 8be4d0b61e3a..1a3bdc0a2d14 100644
--- a/tools/perf/tests/hists_link.c
+++ b/tools/perf/tests/hists_link.c
@@ -8,6 +8,7 @@
 #include "machine.h"
 #include "parse-events.h"
 #include "hists_common.h"
+#include "util/mmap.h"
 #include <errno.h>
 #include <linux/kernel.h>
 
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index 8e2ec5f72042..c6030fdf7d4c 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -13,6 +13,7 @@
 #include "record.h"
 #include "thread_map.h"
 #include "tests.h"
+#include "util/mmap.h"
 
 #define CHECK__(x) {				\
 	while ((x) < 0) {			\
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 4d42e455feb7..3a22dce991ba 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -11,6 +11,7 @@
 #include "evsel.h"
 #include "thread_map.h"
 #include "tests.h"
+#include "util/mmap.h"
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index 5c2576174ae9..e20eaadb1a35 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -11,6 +11,7 @@
 #include "record.h"
 #include "tests.h"
 #include "debug.h"
+#include "util/mmap.h"
 #include <errno.h>
 
 #ifndef O_DIRECTORY
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index 669fd88e7f30..ea8bcaa13ea5 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -11,6 +11,7 @@
 #include "debug.h"
 #include "record.h"
 #include "tests.h"
+#include "util/mmap.h"
 
 static int sched__get_first_possible_cpu(pid_t pid, cpu_set_t *maskp)
 {
diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index fbff60815be8..84519df87f30 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -12,6 +12,7 @@
 #include "util/evsel.h"
 #include "util/evlist.h"
 #include "util/cpumap.h"
+#include "util/mmap.h"
 #include "util/thread_map.h"
 #include <perf/evlist.h>
 
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index c92e287e0f53..e5c3f2ee223a 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -16,6 +16,7 @@
 #include "thread_map.h"
 #include "record.h"
 #include "tests.h"
+#include "util/mmap.h"
 
 static int spin_sleep(void)
 {
diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index 718838b5e724..7fc39af48a76 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -5,6 +5,7 @@
 #include "target.h"
 #include "thread_map.h"
 #include "tests.h"
+#include "util/mmap.h"
 
 #include <errno.h>
 #include <signal.h>
diff --git a/tools/perf/ui/gtk/hists.c b/tools/perf/ui/gtk/hists.c
index 6c2efc10bf5c..ed1a97b2c4b0 100644
--- a/tools/perf/ui/gtk/hists.c
+++ b/tools/perf/ui/gtk/hists.c
@@ -8,6 +8,7 @@
 #include "../string2.h"
 #include "gtk.h"
 #include <signal.h>
+#include <stdlib.h>
 #include <linux/string.h>
 
 #define MAX_COLUMNS			32
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index d441cca6a517..69d0a1991b29 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -34,6 +34,7 @@
 #include "bpf-event.h"
 #include "block-range.h"
 #include "string2.h"
+#include "util/mmap.h"
 #include "arch/common.h"
 #include <regex.h>
 #include <pthread.h>
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 1d22ffd972ac..4bd92f5bfb5f 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -51,6 +51,7 @@
 #include "arm-spe.h"
 #include "s390-cpumsf.h"
 #include "util.h" // page_size
+#include "util/mmap.h"
 
 #include <linux/ctype.h>
 #include <linux/kernel.h>
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index c96c743cc1d2..f700dbe043b7 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -10,6 +10,7 @@
 #include <inttypes.h>
 #include <poll.h>
 #include "cpumap.h"
+#include "util/mmap.h"
 #include "thread_map.h"
 #include "target.h"
 #include "evlist.h"
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index b33c5d67410a..8b9c35efea67 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -11,7 +11,7 @@
 #include <internal/evlist.h>
 #include "events_stats.h"
 #include "evsel.h"
-#include "mmap.h"
+#include <pthread.h>
 #include <signal.h>
 #include <unistd.h>
 
@@ -20,6 +20,34 @@ struct thread_map;
 struct perf_cpu_map;
 struct record_opts;
 
+/*
+ * State machine of bkw_mmap_state:
+ *
+ *                     .________________(forbid)_____________.
+ *                     |                                     V
+ * NOTREADY --(0)--> RUNNING --(1)--> DATA_PENDING --(2)--> EMPTY
+ *                     ^  ^              |   ^               |
+ *                     |  |__(forbid)____/   |___(forbid)___/|
+ *                     |                                     |
+ *                      \_________________(3)_______________/
+ *
+ * NOTREADY     : Backward ring buffers are not ready
+ * RUNNING      : Backward ring buffers are recording
+ * DATA_PENDING : We are required to collect data from backward ring buffers
+ * EMPTY        : We have collected data from backward ring buffers.
+ *
+ * (0): Setup backward ring buffer
+ * (1): Pause ring buffers for reading
+ * (2): Read from ring buffers
+ * (3): Resume ring buffers for recording
+ */
+enum bkw_mmap_state {
+	BKW_MMAP_NOTREADY,
+	BKW_MMAP_RUNNING,
+	BKW_MMAP_DATA_PENDING,
+	BKW_MMAP_EMPTY,
+};
+
 #define PERF_EVLIST__HLIST_BITS 8
 #define PERF_EVLIST__HLIST_SIZE (1 << PERF_EVLIST__HLIST_BITS)
 
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 01524608a984..ab086ede044a 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -45,34 +45,6 @@ struct mmap {
 	int		comp_level;
 };
 
-/*
- * State machine of bkw_mmap_state:
- *
- *                     .________________(forbid)_____________.
- *                     |                                     V
- * NOTREADY --(0)--> RUNNING --(1)--> DATA_PENDING --(2)--> EMPTY
- *                     ^  ^              |   ^               |
- *                     |  |__(forbid)____/   |___(forbid)___/|
- *                     |                                     |
- *                      \_________________(3)_______________/
- *
- * NOTREADY     : Backward ring buffers are not ready
- * RUNNING      : Backward ring buffers are recording
- * DATA_PENDING : We are required to collect data from backward ring buffers
- * EMPTY        : We have collected data from backward ring buffers.
- *
- * (0): Setup backward ring buffer
- * (1): Pause ring buffers for reading
- * (2): Read from ring buffers
- * (3): Resume ring buffers for recording
- */
-enum bkw_mmap_state {
-	BKW_MMAP_NOTREADY,
-	BKW_MMAP_RUNNING,
-	BKW_MMAP_DATA_PENDING,
-	BKW_MMAP_EMPTY,
-};
-
 struct mmap_params {
 	int prot, mask, nr_cblocks, affinity, flush, comp_level;
 	struct auxtrace_mmap_params auxtrace_mp;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index a33a1d5059a2..9cf1371c90a3 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -34,6 +34,7 @@
 #include "asm/bug.h"
 #include "util/parse-branch-options.h"
 #include "metricgroup.h"
+#include "util/mmap.h"
 
 #define MAX_NAME_LEN 100
 
-- 
2.21.0

