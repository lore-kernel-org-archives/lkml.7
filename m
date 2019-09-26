Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D15C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F143222CE
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569458152;
	bh=Jw/xKRyvZjdEoLjy6p+Im9SwuRmgweFnvbJfBxD9z2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O66ldPZ5JXrsxAbxcQnqYScfdg/KX443qDK2vEXI0rcIwsS1gPcJK+KVS6LTX6+eI
	 s5KS8we1uibzoOcIQLvMFaNN45nIo/areM53KzkUu13CBBEj4XdAFwgf38BPf5KSD0
	 HjKOm/lQFJM9j0tkySP8b+jHaTSXnA5nrEoE9ThQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390046AbfIZAfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:35:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389999AbfIZAfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:35:47 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B556222C1;
        Thu, 26 Sep 2019 00:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458145;
        bh=Jw/xKRyvZjdEoLjy6p+Im9SwuRmgweFnvbJfBxD9z2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H/9HKl/1FMW2+iYL3q2jAsGseaQ2EilEm0qZR7CWG11s/DdYCIFbUZ+/15opMe0U5
         fGZH39zabibaeyG+oFQ2+e1LfcyPEO2tSKHE25Gv6DdxsQLS8L+mmzEe29k8rjp0i8
         a5cC3+zyQ8/sYBbZ/IQqw1qyqS+QBdOVRCpTow1A=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 46/66] libperf: Move 'page_size' global variable to libperf
Date:   Wed, 25 Sep 2019 21:32:24 -0300
Message-Id: <20190926003244.13962-47-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

We need the 'page_size' variable in libperf, so move it there.

Add a libperf_init() as a global libperf init function to obtain this
value via sysconf() at tool start.

Committer notes:

Add internal/lib.h to tools/perf/ files using 'page_size', sometimes
replacing util.h with it if that was the only reason for having util.h
included.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-33-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/cs-etm.c     | 2 +-
 tools/perf/arch/arm64/util/arm-spe.c  | 2 +-
 tools/perf/arch/s390/util/machine.c   | 2 +-
 tools/perf/arch/x86/tests/intel-cqm.c | 1 +
 tools/perf/arch/x86/tests/rdpmc.c     | 2 +-
 tools/perf/arch/x86/util/intel-bts.c  | 2 +-
 tools/perf/arch/x86/util/intel-pt.c   | 2 +-
 tools/perf/arch/x86/util/machine.c    | 2 +-
 tools/perf/lib/core.c                 | 7 +++++++
 tools/perf/lib/include/internal/lib.h | 2 ++
 tools/perf/lib/include/perf/core.h    | 1 +
 tools/perf/lib/lib.c                  | 2 ++
 tools/perf/lib/libperf.map            | 1 +
 tools/perf/perf.c                     | 7 ++++---
 tools/perf/tests/mmap-thread-lookup.c | 2 +-
 tools/perf/tests/vmlinux-kallsyms.c   | 2 +-
 tools/perf/util/auxtrace.c            | 1 -
 tools/perf/util/evlist.c              | 2 +-
 tools/perf/util/header.c              | 2 +-
 tools/perf/util/machine.c             | 1 +
 tools/perf/util/mmap.c                | 2 +-
 tools/perf/util/python.c              | 2 +-
 tools/perf/util/session.c             | 1 -
 tools/perf/util/srccode.c             | 2 +-
 tools/perf/util/synthetic-events.c    | 2 +-
 tools/perf/util/trace-event-info.c    | 2 +-
 tools/perf/util/util.c                | 3 +--
 tools/perf/util/util.h                | 2 --
 28 files changed, 36 insertions(+), 25 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 6654bcfc1224..2e4de211d881 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -25,7 +25,7 @@
 #include "../../util/evsel.h"
 #include "../../util/pmu.h"
 #include "../../util/cs-etm.h"
-#include "../../util/util.h" // page_size
+#include <internal/lib.h> // page_size
 #include "../../util/session.h"
 
 #include <errno.h>
diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 745f2d50ee82..eba6541ec0f1 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -16,7 +16,7 @@
 #include "../../util/evsel.h"
 #include "../../util/evlist.h"
 #include "../../util/session.h"
-#include "../../util/util.h" // page_size
+#include <internal/lib.h> // page_size
 #include "../../util/pmu.h"
 #include "../../util/debug.h"
 #include "../../util/auxtrace.h"
diff --git a/tools/perf/arch/s390/util/machine.c b/tools/perf/arch/s390/util/machine.c
index df099d6cc3f5..724efb2d842d 100644
--- a/tools/perf/arch/s390/util/machine.c
+++ b/tools/perf/arch/s390/util/machine.c
@@ -2,7 +2,7 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <string.h>
-#include "util.h" // page_size
+#include <internal/lib.h> // page_size
 #include "machine.h"
 #include "api/fs/fs.h"
 #include "debug.h"
diff --git a/tools/perf/arch/x86/tests/intel-cqm.c b/tools/perf/arch/x86/tests/intel-cqm.c
index 0329b9168fae..3ec562a2aaba 100644
--- a/tools/perf/arch/x86/tests/intel-cqm.c
+++ b/tools/perf/arch/x86/tests/intel-cqm.c
@@ -5,6 +5,7 @@
 #include "evlist.h"
 #include "evsel.h"
 #include "arch-tests.h"
+#include <internal/lib.h> // page_size
 
 #include <signal.h>
 #include <sys/mman.h>
diff --git a/tools/perf/arch/x86/tests/rdpmc.c b/tools/perf/arch/x86/tests/rdpmc.c
index e7640fb047de..1ea916656a2d 100644
--- a/tools/perf/arch/x86/tests/rdpmc.c
+++ b/tools/perf/arch/x86/tests/rdpmc.c
@@ -13,7 +13,7 @@
 #include "tests/tests.h"
 #include "cloexec.h"
 #include "event.h"
-#include "util.h" // page_size
+#include <internal/lib.h> // page_size
 #include "arch-tests.h"
 
 static u64 rdpmc(unsigned int counter)
diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index e2c7095327db..f7f68a50a5cd 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -23,7 +23,7 @@
 #include "../../util/tsc.h"
 #include "../../util/auxtrace.h"
 #include "../../util/intel-bts.h"
-#include "../../util/util.h" // page_size
+#include <internal/lib.h> // page_size
 
 #define KiB(x) ((x) * 1024)
 #define MiB(x) ((x) * 1024 * 1024)
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 84a65524c418..d6d26256915f 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -27,7 +27,7 @@
 #include "../../util/record.h"
 #include "../../util/target.h"
 #include "../../util/tsc.h"
-#include "../../util/util.h" // page_size
+#include <internal/lib.h> // page_size
 #include "../../util/intel-pt.h"
 
 #define KiB(x) ((x) * 1024)
diff --git a/tools/perf/arch/x86/util/machine.c b/tools/perf/arch/x86/util/machine.c
index f0c289862f9f..e17e080e76f4 100644
--- a/tools/perf/arch/x86/util/machine.c
+++ b/tools/perf/arch/x86/util/machine.c
@@ -4,7 +4,7 @@
 #include <limits.h>
 #include <stdlib.h>
 
-#include "../../util/util.h" // page_size
+#include <internal/lib.h> // page_size
 #include "../../util/machine.h"
 #include "../../util/map.h"
 #include "../../util/symbol.h"
diff --git a/tools/perf/lib/core.c b/tools/perf/lib/core.c
index 29d5e3348718..6689d593c2d1 100644
--- a/tools/perf/lib/core.c
+++ b/tools/perf/lib/core.c
@@ -4,7 +4,9 @@
 
 #include <stdio.h>
 #include <stdarg.h>
+#include <unistd.h>
 #include <perf/core.h>
+#include <internal/lib.h>
 #include "internal.h"
 
 static int __base_pr(enum libperf_print_level level, const char *format,
@@ -32,3 +34,8 @@ void libperf_print(enum libperf_print_level level, const char *format, ...)
 	__libperf_pr(level, format, args);
 	va_end(args);
 }
+
+void libperf_init(void)
+{
+	page_size = sysconf(_SC_PAGE_SIZE);
+}
diff --git a/tools/perf/lib/include/internal/lib.h b/tools/perf/lib/include/internal/lib.h
index 0b56f1201dc9..9168b7d2a7e1 100644
--- a/tools/perf/lib/include/internal/lib.h
+++ b/tools/perf/lib/include/internal/lib.h
@@ -4,6 +4,8 @@
 
 #include <unistd.h>
 
+extern unsigned int page_size;
+
 ssize_t readn(int fd, void *buf, size_t n);
 ssize_t writen(int fd, const void *buf, size_t n);
 
diff --git a/tools/perf/lib/include/perf/core.h b/tools/perf/lib/include/perf/core.h
index c341a7b2c874..ba2f4e76a3e2 100644
--- a/tools/perf/lib/include/perf/core.h
+++ b/tools/perf/lib/include/perf/core.h
@@ -18,5 +18,6 @@ typedef int (*libperf_print_fn_t)(enum libperf_print_level level,
 				  const char *, va_list ap);
 
 LIBPERF_API void libperf_set_print(libperf_print_fn_t fn);
+LIBPERF_API void libperf_init(void);
 
 #endif /* __LIBPERF_CORE_H */
diff --git a/tools/perf/lib/lib.c b/tools/perf/lib/lib.c
index 2a81819c3b8c..18658931fc71 100644
--- a/tools/perf/lib/lib.c
+++ b/tools/perf/lib/lib.c
@@ -5,6 +5,8 @@
 #include <linux/kernel.h>
 #include <internal/lib.h>
 
+unsigned int page_size;
+
 static ssize_t ion(bool is_read, int fd, void *buf, size_t n)
 {
 	void *buf_start = buf;
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index cd0d17b996c8..724da66776ef 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -1,5 +1,6 @@
 LIBPERF_0.0.1 {
 	global:
+		libperf_init;
 		libperf_set_print;
 		perf_cpu_map__dummy_new;
 		perf_cpu_map__get;
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index bb40a108b8f7..c012ceb64ff9 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -12,6 +12,7 @@
 #include "util/build-id.h"
 #include "util/cache.h"
 #include "util/env.h"
+#include <internal/lib.h> // page_size
 #include <subcmd/exec-cmd.h>
 #include "util/config.h"
 #include <subcmd/run-command.h>
@@ -20,11 +21,12 @@
 #include "util/bpf-loader.h"
 #include "util/debug.h"
 #include "util/event.h"
-#include "util/util.h" // page_size, usage()
+#include "util/util.h" // usage()
 #include "ui/ui.h"
 #include "perf-sys.h"
 #include <api/fs/fs.h>
 #include <api/fs/tracing_path.h>
+#include <perf/core.h>
 #include <errno.h>
 #include <pthread.h>
 #include <signal.h>
@@ -438,8 +440,7 @@ int main(int argc, const char **argv)
 	exec_cmd_init("perf", PREFIX, PERF_EXEC_PATH, EXEC_PATH_ENVIRONMENT);
 	pager_init(PERF_PAGER_ENVIRONMENT);
 
-	/* The page_size is placed in util object. */
-	page_size = sysconf(_SC_PAGE_SIZE);
+	libperf_init();
 
 	cmd = extract_argv0_path(argv[0]);
 	if (!cmd)
diff --git a/tools/perf/tests/mmap-thread-lookup.c b/tools/perf/tests/mmap-thread-lookup.c
index 33b496d194f4..8d9d4cbff76d 100644
--- a/tools/perf/tests/mmap-thread-lookup.c
+++ b/tools/perf/tests/mmap-thread-lookup.c
@@ -16,7 +16,7 @@
 #include "symbol.h"
 #include "util/synthetic-events.h"
 #include "thread.h"
-#include "util.h" // page_size
+#include <internal/lib.h> // page_size
 
 #define THREADS 4
 
diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 7f28775875c2..aa296ffea6d1 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -7,7 +7,7 @@
 #include "dso.h"
 #include "map.h"
 #include "symbol.h"
-#include "util.h" // page_size
+#include <internal/lib.h> // page_size
 #include "tests.h"
 #include "debug.h"
 #include "machine.h"
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 4bd92f5bfb5f..8470dfe9fe97 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -50,7 +50,6 @@
 #include "intel-bts.h"
 #include "arm-spe.h"
 #include "s390-cpumsf.h"
-#include "util.h" // page_size
 #include "util/mmap.h"
 
 #include <linux/ctype.h>
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index a37eccf65eae..6069fb52661f 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -17,7 +17,7 @@
 #include "evsel.h"
 #include "debug.h"
 #include "units.h"
-#include "util.h" // page_size
+#include <internal/lib.h> // page_size
 #include "../perf.h"
 #include "asm/bug.h"
 #include "bpf-event.h"
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 02602bc8cabf..3b24b4974c5f 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -42,7 +42,7 @@
 #include "tool.h"
 #include "time-utils.h"
 #include "units.h"
-#include "util.h" // page_size, perf_exe()
+#include "util/util.h" // perf_exe()
 #include "cputopo.h"
 #include "bpf-event.h"
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 0535338f2d7a..70a9f8716a4b 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -32,6 +32,7 @@
 #include "linux/hash.h"
 #include "asm/bug.h"
 #include "bpf-event.h"
+#include <internal/lib.h> // page_size
 
 #include <linux/ctype.h>
 #include <symbol/kallsyms.h>
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 4cc3b54b2f73..12671d089748 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -20,7 +20,7 @@
 #include "event.h"
 #include "mmap.h"
 #include "../perf.h"
-#include "util.h" /* page_size */
+#include <internal/lib.h> /* page_size */
 
 size_t perf_mmap__mmap_len(struct mmap *map)
 {
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index fcbafb1e8d9d..6c46d7dbd263 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -14,7 +14,7 @@
 #include "thread_map.h"
 #include "trace-event.h"
 #include "mmap.h"
-#include "util.h"
+#include <internal/lib.h>
 #include "../perf-sys.h"
 
 #if PY_MAJOR_VERSION < 3
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 84a30ff3968a..061bb4d6a3f5 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -29,7 +29,6 @@
 #include "thread-stack.h"
 #include "sample-raw.h"
 #include "stat.h"
-#include "util.h"
 #include "ui/progress.h"
 #include "../perf.h"
 #include "arch/common.h"
diff --git a/tools/perf/util/srccode.c b/tools/perf/util/srccode.c
index b402f9ca89ab..d84ed8b6caaa 100644
--- a/tools/perf/util/srccode.c
+++ b/tools/perf/util/srccode.c
@@ -15,7 +15,7 @@
 #include <string.h>
 #include "srccode.h"
 #include "debug.h"
-#include "util.h" // page_size
+#include <internal/lib.h> // page_size
 
 #define MAXSRCCACHE (32*1024*1024)
 #define MAXSRCFILES     64
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 96ed008c2775..807cbca403a7 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -16,7 +16,6 @@
 #include "util/synthetic-events.h"
 #include "util/target.h"
 #include "util/time-utils.h"
-#include "util/util.h"
 #include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
@@ -26,6 +25,7 @@
 #include <perf/evsel.h>
 #include <internal/cpumap.h>
 #include <perf/cpumap.h>
+#include <internal/lib.h> // page_size
 #include <internal/threadmap.h>
 #include <perf/threadmap.h>
 #include <symbol/kallsyms.h>
diff --git a/tools/perf/util/trace-event-info.c b/tools/perf/util/trace-event-info.c
index fe07e7550930..086e98ff42a3 100644
--- a/tools/perf/util/trace-event-info.c
+++ b/tools/perf/util/trace-event-info.c
@@ -2,7 +2,6 @@
 /*
  * Copyright (C) 2008,2009, Steven Rostedt <srostedt@redhat.com>
  */
-#include "util.h" // page_size
 #include <dirent.h>
 #include <mntent.h>
 #include <stdio.h>
@@ -19,6 +18,7 @@
 #include <linux/list.h>
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
+#include <internal/lib.h> // page_size
 
 #include "trace-event.h"
 #include <api/fs/tracing_path.h>
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 32322a20a68b..cb6fa4c98470 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -3,6 +3,7 @@
 #include "debug.h"
 #include "event.h"
 #include "namespaces.h"
+#include <internal/lib.h>
 #include <api/fs/fs.h>
 #include <sys/mman.h>
 #include <sys/stat.h>
@@ -41,8 +42,6 @@ void perf_set_multithreaded(void)
 	perf_singlethreaded = false;
 }
 
-unsigned int page_size;
-
 int sysctl_perf_event_max_stack = PERF_MAX_STACK_DEPTH;
 int sysctl_perf_event_max_contexts_per_stack = PERF_MAX_CONTEXTS_PER_STACK;
 
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 45a5c6f20197..d6ae394e67c4 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -33,8 +33,6 @@ int copyfile_offset(int ifd, loff_t off_in, int ofd, loff_t off_out, u64 size);
 
 size_t hex_width(u64 v);
 
-extern unsigned int page_size;
-
 int sysctl__max_stack(void);
 
 int fetch_kernel_version(unsigned int *puint,
-- 
2.21.0

