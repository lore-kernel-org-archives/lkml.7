Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4726EC3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 066312339D
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567340655;
	bh=7q2FZGmiql2rfLIK450rQPnklnH0AyJwdN7FKwelHDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TUnOwsSHI23wVsGrClJo2pIeizbeXTD2ZpKrRbg/THPYGEBCvd4uXhwcjx+UfRvZ2
	 WwbDqRFmaOAdiLGpPZfqhTGrvISzgmHeaXrtHQ0xrcEBlMsAvcHbTUxYKs+hXb80Xg
	 T2twhcNYdnRc2tLN3aDmHoVmY04KX9GxsKG9v4PA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbfIAMYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 08:24:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:40930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728967AbfIAMYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 08:24:12 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2A652377F;
        Sun,  1 Sep 2019 12:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567340651;
        bh=7q2FZGmiql2rfLIK450rQPnklnH0AyJwdN7FKwelHDE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NRGaOVuP4Z+tg8pMkisDXh2QWAHZXR7qTkn8wH/GgJ25smtWRR4tAp8jpJyz6i2gB
         M+hpdgK1Esr7aWgxdx5m7sUFjYX4hfSZNqmIm9sKu5mV+ge+Xn8i2XELXPERQbx6iC
         QP0W/vnM50X/Tw8eco9uq5QeOyx0Qdyh3CtsSnJA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 11/47] perf tools: Move everything related to sys_perf_event_open() to perf-sys.h
Date:   Sun,  1 Sep 2019 09:22:50 -0300
Message-Id: <20190901122326.5793-12-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190901122326.5793-1-acme@kernel.org>
References: <20190901122326.5793-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
index 1a9e22f78c22..a769382fb644 100644
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
index 7a11f02d6c6c..345a6a0a328b 100644
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
index 0d7b77ff0ae6..74a606ea42d3 100644
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
index 81720e27f8a3..a6ba45d0db6e 100644
--- a/tools/perf/arch/x86/util/tsc.c
+++ b/tools/perf/arch/x86/util/tsc.c
@@ -7,6 +7,7 @@
 
 #include "../../../perf.h"
 #include <linux/types.h>
+#include <asm/barrier.h>
 #include "../../../util/debug.h"
 #include "../../../util/tsc.h"
 
diff --git a/tools/perf/bench/epoll-ctl.c b/tools/perf/bench/epoll-ctl.c
index 84658d45f349..d1caa4a0a12a 100644
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
index c27a65639cfb..f6b4472847d2 100644
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
index 64dc994c72ea..9235b76501be 100644
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
index 025151dcb651..91d0a9b10581 100644
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
index 6ffb0fbd6237..63e4349a772a 100644
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
index 34763a9b873d..a95a248a7421 100644
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
index d9e6b8b957b6..7a1a92127b9b 100644
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
index d8426547219b..87dc3e1174af 100644
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
index 153624e2d0f5..c4a30318d7e0 100644
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
index 910e25e64188..2d292f8fb3dd 100644
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
index ca962559e845..101315a3b34f 100644
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
index f89e6806557b..982ac55d69ea 100644
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
index b213e6431d88..1fa8a965b03f 100644
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
index 06f48312c5ed..92d08198e64a 100644
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
index dbc04e1053a9..b6b406a1678f 100644
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
index 7001247ebbd6..bc32f405b26e 100644
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
index 11479a7ad1c7..9dd83871aafe 100644
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
index 574507d46c98..c67a51397bc7 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -10,6 +10,7 @@
 #include "util.h"
 #include "cloexec.h"
 #include "record.h"
+#include "../perf-sys.h"
 
 typedef void (*setup_probe_fn_t)(struct evsel *evsel);
 
diff --git a/tools/perf/util/strbuf.c b/tools/perf/util/strbuf.c
index 2ce0dc887364..0afdbf38a2b2 100644
--- a/tools/perf/util/strbuf.c
+++ b/tools/perf/util/strbuf.c
@@ -4,6 +4,7 @@
 #include <linux/zalloc.h>
 #include <errno.h>
 #include <stdlib.h>
+#include <unistd.h>
 
 /*
  * Used as the default ->buf value, so that people can always assume
-- 
2.21.0

