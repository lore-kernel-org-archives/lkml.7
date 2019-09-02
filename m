Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC58AC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9655215EA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbfIBITX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:19:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56152 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730000AbfIBIQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:16:36 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i4hVm-00080S-Oj; Mon, 02 Sep 2019 10:16:30 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6367E1C0DEC;
        Mon,  2 Sep 2019 10:16:27 +0200 (CEST)
Date:   Mon, 02 Sep 2019 08:16:27 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf tools: Move everything related to
 sys_perf_event_open() to perf-sys.h
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-7b1zvugiwak4ibfa3j6ott7f@git.kernel.org>
References: <tip-7b1zvugiwak4ibfa3j6ott7f@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156741218731.17296.9729982780222418091.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     91854f9a077e18e43ed30ebe9c61f8089bec9166
Gitweb:        https://git.kernel.org/tip/91854f9a077e18e43ed30ebe9c61f8089bec9166
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Thu, 29 Aug 2019 14:59:50 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 29 Aug 2019 17:38:32 -03:00

perf tools: Move everything related to sys_perf_event_open() to perf-sys.h

And remove unneeded include directives from perf-sys.h to prune the
header dependency tree.

Fixup the fallout in places where definitions were being used without
the needed include directives that were being satisfied because they
were in perf-sys.h.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-7b1zvugiwak4ibfa3j6ott7f@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/common.c              |  1 +
 tools/perf/arch/x86/tests/rdpmc.c     |  2 +-
 tools/perf/arch/x86/util/perf_regs.c  |  2 +-
 tools/perf/arch/x86/util/tsc.c        |  1 +
 tools/perf/bench/epoll-ctl.c          |  1 +
 tools/perf/bench/epoll-wait.c         |  1 +
 tools/perf/bench/mem-functions.c      |  3 ++-
 tools/perf/builtin-sched.c            |  1 +
 tools/perf/perf-sys.h                 | 13 ++++++++++---
 tools/perf/perf.c                     |  1 +
 tools/perf/perf.h                     | 12 ------------
 tools/perf/tests/attr.c               |  2 +-
 tools/perf/tests/bp_account.c         |  2 +-
 tools/perf/tests/bp_signal.c          |  2 +-
 tools/perf/tests/bp_signal_overflow.c |  2 +-
 tools/perf/tests/wp.c                 |  2 ++
 tools/perf/util/auxtrace.h            |  1 +
 tools/perf/util/cloexec.c             |  2 +-
 tools/perf/util/evsel.c               |  1 +
 tools/perf/util/genelf.c              |  2 ++
 tools/perf/util/python.c              |  1 +
 tools/perf/util/record.c              |  1 +
 tools/perf/util/strbuf.c              |  1 +
 23 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/tools/perf/arch/common.c b/tools/perf/arch/common.c
index 1a9e22f..a769382 100644
--- a/tools/perf/arch/common.c
+++ b/tools/perf/arch/common.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
+#include <unistd.h>
 #include "common.h"
 #include "../util/env.h"
 #include "../util/debug.h"
diff --git a/tools/perf/arch/x86/tests/rdpmc.c b/tools/perf/arch/x86/tests/rdpmc.c
index 7a11f02..345a6a0 100644
--- a/tools/perf/arch/x86/tests/rdpmc.c
+++ b/tools/perf/arch/x86/tests/rdpmc.c
@@ -7,7 +7,7 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <linux/types.h>
-#include "perf.h"
+#include "perf-sys.h"
 #include "debug.h"
 #include "tests/tests.h"
 #include "cloexec.h"
diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
index 0d7b77f..74a606e 100644
--- a/tools/perf/arch/x86/util/perf_regs.c
+++ b/tools/perf/arch/x86/util/perf_regs.c
@@ -4,7 +4,7 @@
 #include <regex.h>
 #include <linux/zalloc.h>
 
-#include "../../perf.h"
+#include "../../perf-sys.h"
 #include "../../util/perf_regs.h"
 #include "../../util/debug.h"
 
diff --git a/tools/perf/arch/x86/util/tsc.c b/tools/perf/arch/x86/util/tsc.c
index 81720e2..a6ba45d 100644
--- a/tools/perf/arch/x86/util/tsc.c
+++ b/tools/perf/arch/x86/util/tsc.c
@@ -7,6 +7,7 @@
 
 #include "../../../perf.h"
 #include <linux/types.h>
+#include <asm/barrier.h>
 #include "../../../util/debug.h"
 #include "../../../util/tsc.h"
 
diff --git a/tools/perf/bench/epoll-ctl.c b/tools/perf/bench/epoll-ctl.c
index 84658d4..d1caa4a 100644
--- a/tools/perf/bench/epoll-ctl.c
+++ b/tools/perf/bench/epoll-ctl.c
@@ -14,6 +14,7 @@
 #include <inttypes.h>
 #include <signal.h>
 #include <stdlib.h>
+#include <unistd.h>
 #include <linux/compiler.h>
 #include <linux/kernel.h>
 #include <sys/time.h>
diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
index c27a656..f6b4472 100644
--- a/tools/perf/bench/epoll-wait.c
+++ b/tools/perf/bench/epoll-wait.c
@@ -63,6 +63,7 @@
 /* For the CLR_() macros */
 #include <string.h>
 #include <pthread.h>
+#include <unistd.h>
 
 #include <errno.h>
 #include <inttypes.h>
diff --git a/tools/perf/bench/mem-functions.c b/tools/perf/bench/mem-functions.c
index 64dc994..9235b76 100644
--- a/tools/perf/bench/mem-functions.c
+++ b/tools/perf/bench/mem-functions.c
@@ -8,7 +8,7 @@
  */
 
 #include "debug.h"
-#include "../perf.h"
+#include "../perf-sys.h"
 #include <subcmd/parse-options.h>
 #include "../util/header.h"
 #include "../util/cloexec.h"
@@ -20,6 +20,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <unistd.h>
 #include <sys/time.h>
 #include <errno.h>
 #include <linux/time64.h>
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 025151d..91d0a9b 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "builtin.h"
 #include "perf.h"
+#include "perf-sys.h"
 
 #include "util/evlist.h"
 #include "util/cache.h"
diff --git a/tools/perf/perf-sys.h b/tools/perf/perf-sys.h
index 6ffb0fb..63e4349 100644
--- a/tools/perf/perf-sys.h
+++ b/tools/perf/perf-sys.h
@@ -5,10 +5,17 @@
 #include <unistd.h>
 #include <sys/types.h>
 #include <sys/syscall.h>
-#include <linux/types.h>
 #include <linux/compiler.h>
-#include <linux/perf_event.h>
-#include <asm/barrier.h>
+
+struct perf_event_attr;
+
+extern bool test_attr__enabled;
+void test_attr__ready(void);
+void test_attr__init(void);
+void test_attr__open(struct perf_event_attr *attr, pid_t pid, int cpu,
+		     int fd, int group_fd, unsigned long flags);
+
+#define HAVE_ATTR_TEST
 
 static inline int
 sys_perf_event_open(struct perf_event_attr *attr,
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 34763a9..a95a248 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -19,6 +19,7 @@
 #include "util/debug.h"
 #include "util/event.h"
 #include "util/util.h"
+#include "perf-sys.h"
 #include <api/fs/fs.h>
 #include <api/fs/tracing_path.h>
 #include <errno.h>
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index d9e6b8b..7a1a921 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -4,18 +4,6 @@
 
 #include <time.h>
 #include <stdbool.h>
-#include <linux/types.h>
-#include <linux/stddef.h>
-#include <linux/perf_event.h>
-
-extern bool test_attr__enabled;
-void test_attr__ready(void);
-void test_attr__init(void);
-void test_attr__open(struct perf_event_attr *attr, pid_t pid, int cpu,
-		     int fd, int group_fd, unsigned long flags);
-
-#define HAVE_ATTR_TEST
-#include "perf-sys.h"
 
 static inline unsigned long long rdclock(void)
 {
diff --git a/tools/perf/tests/attr.c b/tools/perf/tests/attr.c
index d842654..87dc3e1 100644
--- a/tools/perf/tests/attr.c
+++ b/tools/perf/tests/attr.c
@@ -30,7 +30,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
-#include "../perf.h"
+#include "../perf-sys.h"
 #include <subcmd/exec-cmd.h>
 #include "tests.h"
 
diff --git a/tools/perf/tests/bp_account.c b/tools/perf/tests/bp_account.c
index 153624e..c4a3031 100644
--- a/tools/perf/tests/bp_account.c
+++ b/tools/perf/tests/bp_account.c
@@ -19,7 +19,7 @@
 
 #include "tests.h"
 #include "debug.h"
-#include "perf.h"
+#include "../perf-sys.h"
 #include "cloexec.h"
 
 volatile long the_var;
diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
index 910e25e..2d292f8 100644
--- a/tools/perf/tests/bp_signal.c
+++ b/tools/perf/tests/bp_signal.c
@@ -25,7 +25,7 @@
 
 #include "tests.h"
 #include "debug.h"
-#include "perf.h"
+#include "perf-sys.h"
 #include "cloexec.h"
 
 static int fd1;
diff --git a/tools/perf/tests/bp_signal_overflow.c b/tools/perf/tests/bp_signal_overflow.c
index ca96255..101315a 100644
--- a/tools/perf/tests/bp_signal_overflow.c
+++ b/tools/perf/tests/bp_signal_overflow.c
@@ -24,7 +24,7 @@
 
 #include "tests.h"
 #include "debug.h"
-#include "perf.h"
+#include "../perf-sys.h"
 #include "cloexec.h"
 
 static int overflows;
diff --git a/tools/perf/tests/wp.c b/tools/perf/tests/wp.c
index f89e680..982ac55 100644
--- a/tools/perf/tests/wp.c
+++ b/tools/perf/tests/wp.c
@@ -1,10 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdlib.h>
+#include <unistd.h>
 #include <sys/ioctl.h>
 #include <linux/hw_breakpoint.h>
 #include "tests.h"
 #include "debug.h"
 #include "cloexec.h"
+#include "../perf-sys.h"
 
 #define WP_TEST_ASSERT_VAL(fd, text, val)       \
 do {                                            \
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index b213e64..1fa8a96 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -15,6 +15,7 @@
 #include <linux/perf_event.h>
 #include <linux/types.h>
 #include <asm/bitsperlong.h>
+#include <asm/barrier.h>
 
 #include "../perf.h"
 #include "event.h"
diff --git a/tools/perf/util/cloexec.c b/tools/perf/util/cloexec.c
index 06f4831..92d0819 100644
--- a/tools/perf/util/cloexec.c
+++ b/tools/perf/util/cloexec.c
@@ -2,7 +2,7 @@
 #include <errno.h>
 #include <sched.h>
 #include "util.h"
-#include "../perf.h"
+#include "../perf-sys.h"
 #include "cloexec.h"
 #include "asm/bug.h"
 #include "debug.h"
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index dbc04e1..b6b406a 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -41,6 +41,7 @@
 #include "string2.h"
 #include "memswap.h"
 #include "util.h"
+#include "../perf-sys.h"
 #include "util/parse-branch-options.h"
 #include <internal/xyarray.h>
 
diff --git a/tools/perf/util/genelf.c b/tools/perf/util/genelf.c
index 7001247..bc32f40 100644
--- a/tools/perf/util/genelf.c
+++ b/tools/perf/util/genelf.c
@@ -14,6 +14,7 @@
 #include <libelf.h>
 #include <string.h>
 #include <stdlib.h>
+#include <unistd.h>
 #include <inttypes.h>
 #include <limits.h>
 #include <fcntl.h>
@@ -25,6 +26,7 @@
 #include "perf.h"
 #include "genelf.h"
 #include "../util/jitdump.h"
+#include <linux/compiler.h>
 
 #ifndef NT_GNU_BUILD_ID
 #define NT_GNU_BUILD_ID 3
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 11479a7..9dd8387 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -14,6 +14,7 @@
 #include "thread_map.h"
 #include "mmap.h"
 #include "util.h"
+#include "../perf-sys.h"
 
 #if PY_MAJOR_VERSION < 3
 #define _PyUnicode_FromString(arg) \
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index 574507d..c67a513 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -10,6 +10,7 @@
 #include "util.h"
 #include "cloexec.h"
 #include "record.h"
+#include "../perf-sys.h"
 
 typedef void (*setup_probe_fn_t)(struct evsel *evsel);
 
diff --git a/tools/perf/util/strbuf.c b/tools/perf/util/strbuf.c
index 2ce0dc8..0afdbf3 100644
--- a/tools/perf/util/strbuf.c
+++ b/tools/perf/util/strbuf.c
@@ -4,6 +4,7 @@
 #include <linux/zalloc.h>
 #include <errno.h>
 #include <stdlib.h>
+#include <unistd.h>
 
 /*
  * Used as the default ->buf value, so that people can always assume
