Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A00C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C4A207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568989763;
	bh=n5O999ClghpXy0Dihe9FmYOT2NOjGqTqq5+hwRRD0/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YCTsgdEc+9jzMSJmFSkTvZbPPi00bkjteGe8rVKZzgnCom1S3Uqk6odhbL0NS2OWW
	 YdAbyRHE+R98CZB3VFY5Eh6NGeqGz10RpT0k/ZihoJ29IqWXZSf9JtPEeRa/6BhF/p
	 nb5uXpiieAQSn/QuKt9YXgv1PlUvkb8ZIDViBNL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390395AbfITO3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:29:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:38906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389000AbfITO0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:26:23 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 570F021907;
        Fri, 20 Sep 2019 14:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568989581;
        bh=n5O999ClghpXy0Dihe9FmYOT2NOjGqTqq5+hwRRD0/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gl3NNKLQOcu/H5hiD+NQ5W8cZa/QQ6WNLG0YwkSLCFCxb93NCsMg/7i+EplDwQ4X8
         Jtz/BgWVuPW7E0hqTuwG5EwS6eBf72KvAbNvFtGbHwx/myDLPpbOaowWJfOiPZ3Btx
         T4DcSOw48dewkYqpkJwk3g5cZUk+U+VF227K6Mf4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 10/31] perf tools: Remove util.h from where it is not needed
Date:   Fri, 20 Sep 2019 11:25:21 -0300
Message-Id: <20190920142542.12047-11-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190920142542.12047-1-acme@kernel.org>
References: <20190920142542.12047-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Check that it is not needed and remove, fixing up some fallout for
places where it was only serving to get something else.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-9h6dg6lsqe2usyqjh5rrues4@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/cs-etm.c                      | 2 +-
 tools/perf/arch/arm64/util/arm-spe.c                   | 2 +-
 tools/perf/arch/arm64/util/dwarf-regs.c                | 1 -
 tools/perf/arch/powerpc/util/dwarf-regs.c              | 1 -
 tools/perf/arch/powerpc/util/header.c                  | 1 -
 tools/perf/arch/s390/util/machine.c                    | 2 +-
 tools/perf/arch/x86/tests/intel-cqm.c                  | 1 -
 tools/perf/arch/x86/tests/rdpmc.c                      | 2 +-
 tools/perf/arch/x86/util/intel-bts.c                   | 2 +-
 tools/perf/arch/x86/util/intel-pt.c                    | 2 +-
 tools/perf/arch/x86/util/machine.c                     | 2 +-
 tools/perf/bench/sched-messaging.c                     | 1 -
 tools/perf/bench/sched-pipe.c                          | 1 -
 tools/perf/builtin-config.c                            | 1 -
 tools/perf/builtin-evlist.c                            | 2 --
 tools/perf/builtin-report.c                            | 2 +-
 tools/perf/perf.c                                      | 2 +-
 tools/perf/tests/clang.c                               | 1 -
 tools/perf/tests/dso-data.c                            | 1 -
 tools/perf/tests/event-times.c                         | 1 -
 tools/perf/tests/llvm.c                                | 1 -
 tools/perf/tests/mmap-thread-lookup.c                  | 2 +-
 tools/perf/tests/parse-events.c                        | 1 -
 tools/perf/tests/parse-no-sample-id-all.c              | 2 --
 tools/perf/tests/perf-hooks.c                          | 1 -
 tools/perf/tests/pmu.c                                 | 1 -
 tools/perf/tests/sample-parsing.c                      | 1 -
 tools/perf/tests/topology.c                            | 1 -
 tools/perf/tests/vmlinux-kallsyms.c                    | 2 +-
 tools/perf/ui/browser.c                                | 1 -
 tools/perf/ui/browsers/annotate.c                      | 1 -
 tools/perf/ui/browsers/map.c                           | 1 -
 tools/perf/ui/browsers/res_sample.c                    | 2 +-
 tools/perf/ui/browsers/scripts.c                       | 2 +-
 tools/perf/ui/gtk/progress.c                           | 1 -
 tools/perf/ui/helpline.c                               | 1 -
 tools/perf/ui/hist.c                                   | 1 -
 tools/perf/ui/setup.c                                  | 2 +-
 tools/perf/ui/tui/setup.c                              | 2 +-
 tools/perf/util/annotate.c                             | 2 +-
 tools/perf/util/auxtrace.c                             | 4 +++-
 tools/perf/util/branch.c                               | 1 -
 tools/perf/util/branch.h                               | 9 ++++++++-
 tools/perf/util/build-id.c                             | 2 +-
 tools/perf/util/cloexec.c                              | 2 +-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c        | 1 -
 tools/perf/util/cs-etm.c                               | 1 -
 tools/perf/util/data.c                                 | 3 ++-
 tools/perf/util/debug.c                                | 1 -
 tools/perf/util/demangle-rust.c                        | 1 -
 tools/perf/util/dwarf-regs.c                           | 1 -
 tools/perf/util/evlist.c                               | 2 +-
 tools/perf/util/evsel.c                                | 1 +
 tools/perf/util/header.c                               | 3 ++-
 tools/perf/util/jitdump.c                              | 1 -
 tools/perf/util/llvm-utils.c                           | 1 +
 tools/perf/util/lzma.c                                 | 2 +-
 tools/perf/util/perf-hooks.c                           | 1 -
 tools/perf/util/record.c                               | 1 -
 tools/perf/util/rwsem.c                                | 1 +
 tools/perf/util/s390-sample-raw.c                      | 1 -
 tools/perf/util/scripting-engines/trace-event-python.c | 1 -
 tools/perf/util/session.c                              | 1 +
 tools/perf/util/srccode.c                              | 2 +-
 tools/perf/util/symbol-elf.c                           | 2 ++
 tools/perf/util/symbol-minimal.c                       | 3 +--
 tools/perf/util/symbol.c                               | 2 +-
 tools/perf/util/target.c                               | 1 -
 tools/perf/util/trace-event-info.c                     | 2 +-
 tools/perf/util/trace-event-read.c                     | 1 -
 tools/perf/util/trace-event.c                          | 1 -
 tools/perf/util/unwind-libdw.c                         | 1 -
 tools/perf/util/unwind-libunwind-local.c               | 1 -
 tools/perf/util/vdso.c                                 | 2 +-
 tools/perf/util/zlib.c                                 | 2 +-
 75 files changed, 47 insertions(+), 73 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index c32db09baf0d..5d120b1e35ed 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -25,7 +25,7 @@
 #include "../../util/evsel.h"
 #include "../../util/pmu.h"
 #include "../../util/cs-etm.h"
-#include "../../util/util.h"
+#include "../../util/util.h" // page_size
 #include "../../util/session.h"
 
 #include <errno.h>
diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 4b364692da67..eebbf31f995c 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -16,7 +16,7 @@
 #include "../../util/evsel.h"
 #include "../../util/evlist.h"
 #include "../../util/session.h"
-#include "../../util/util.h"
+#include "../../util/util.h" // page_size
 #include "../../util/pmu.h"
 #include "../../util/debug.h"
 #include "../../util/auxtrace.h"
diff --git a/tools/perf/arch/arm64/util/dwarf-regs.c b/tools/perf/arch/arm64/util/dwarf-regs.c
index b047b882c5b1..917b97d7c5d3 100644
--- a/tools/perf/arch/arm64/util/dwarf-regs.c
+++ b/tools/perf/arch/arm64/util/dwarf-regs.c
@@ -11,7 +11,6 @@
 #include <dwarf-regs.h>
 #include <linux/ptrace.h> /* for struct user_pt_regs */
 #include <linux/stringify.h>
-#include "util.h"
 
 struct pt_regs_dwarfnum {
 	const char *name;
diff --git a/tools/perf/arch/powerpc/util/dwarf-regs.c b/tools/perf/arch/powerpc/util/dwarf-regs.c
index 4952890b9428..0c4f4caf53ac 100644
--- a/tools/perf/arch/powerpc/util/dwarf-regs.c
+++ b/tools/perf/arch/powerpc/util/dwarf-regs.c
@@ -12,7 +12,6 @@
 #include <linux/ptrace.h>
 #include <linux/kernel.h>
 #include <linux/stringify.h>
-#include "util.h"
 
 struct pt_regs_dwarfnum {
 	const char *name;
diff --git a/tools/perf/arch/powerpc/util/header.c b/tools/perf/arch/powerpc/util/header.c
index 0b242664f5ea..b6b7bc7e31a1 100644
--- a/tools/perf/arch/powerpc/util/header.c
+++ b/tools/perf/arch/powerpc/util/header.c
@@ -6,7 +6,6 @@
 #include <string.h>
 #include <linux/stringify.h>
 #include "header.h"
-#include "util.h"
 
 #define mfspr(rn)       ({unsigned long rval; \
 			 asm volatile("mfspr %0," __stringify(rn) \
diff --git a/tools/perf/arch/s390/util/machine.c b/tools/perf/arch/s390/util/machine.c
index c8c86a0c9b79..df099d6cc3f5 100644
--- a/tools/perf/arch/s390/util/machine.c
+++ b/tools/perf/arch/s390/util/machine.c
@@ -2,7 +2,7 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <string.h>
-#include "util.h"
+#include "util.h" // page_size
 #include "machine.h"
 #include "api/fs/fs.h"
 #include "debug.h"
diff --git a/tools/perf/arch/x86/tests/intel-cqm.c b/tools/perf/arch/x86/tests/intel-cqm.c
index 3b5cc3373821..111c0ab2e7b5 100644
--- a/tools/perf/arch/x86/tests/intel-cqm.c
+++ b/tools/perf/arch/x86/tests/intel-cqm.c
@@ -5,7 +5,6 @@
 #include "evlist.h"
 #include "evsel.h"
 #include "arch-tests.h"
-#include "util.h"
 
 #include <signal.h>
 #include <sys/mman.h>
diff --git a/tools/perf/arch/x86/tests/rdpmc.c b/tools/perf/arch/x86/tests/rdpmc.c
index 6e67cee792b1..e7640fb047de 100644
--- a/tools/perf/arch/x86/tests/rdpmc.c
+++ b/tools/perf/arch/x86/tests/rdpmc.c
@@ -13,7 +13,7 @@
 #include "tests/tests.h"
 #include "cloexec.h"
 #include "event.h"
-#include "util.h"
+#include "util.h" // page_size
 #include "arch-tests.h"
 
 static u64 rdpmc(unsigned int counter)
diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index d263430c045f..090d90e093df 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -22,7 +22,7 @@
 #include "../../util/tsc.h"
 #include "../../util/auxtrace.h"
 #include "../../util/intel-bts.h"
-#include "../../util/util.h"
+#include "../../util/util.h" // page_size
 
 #define KiB(x) ((x) * 1024)
 #define MiB(x) ((x) * 1024 * 1024)
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index cb7cf16af79c..3d041b89f018 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -26,7 +26,7 @@
 #include "../../util/record.h"
 #include "../../util/target.h"
 #include "../../util/tsc.h"
-#include "../../util/util.h"
+#include "../../util/util.h" // page_size
 #include "../../util/intel-pt.h"
 
 #define KiB(x) ((x) * 1024)
diff --git a/tools/perf/arch/x86/util/machine.c b/tools/perf/arch/x86/util/machine.c
index 1e9ec783b9a1..42418040bc07 100644
--- a/tools/perf/arch/x86/util/machine.c
+++ b/tools/perf/arch/x86/util/machine.c
@@ -3,7 +3,7 @@
 #include <linux/string.h>
 #include <stdlib.h>
 
-#include "../../util/util.h"
+#include "../../util/util.h" // page_size
 #include "../../util/machine.h"
 #include "../../util/map.h"
 #include "../../util/symbol.h"
diff --git a/tools/perf/bench/sched-messaging.c b/tools/perf/bench/sched-messaging.c
index 6e499b32bf00..97e4a4fb3362 100644
--- a/tools/perf/bench/sched-messaging.c
+++ b/tools/perf/bench/sched-messaging.c
@@ -10,7 +10,6 @@
  *
  */
 
-#include "../util/util.h"
 #include <subcmd/parse-options.h>
 #include "bench.h"
 
diff --git a/tools/perf/bench/sched-pipe.c b/tools/perf/bench/sched-pipe.c
index edd40aafa318..3c88d1f201f1 100644
--- a/tools/perf/bench/sched-pipe.c
+++ b/tools/perf/bench/sched-pipe.c
@@ -9,7 +9,6 @@
  *  http://people.redhat.com/mingo/cfs-scheduler/tools/pipe-test-1m.c
  * Ported to perf by Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
  */
-#include "../util/util.h"
 #include <subcmd/parse-options.h>
 #include "bench.h"
 
diff --git a/tools/perf/builtin-config.c b/tools/perf/builtin-config.c
index 42d8157e047a..2603015f98be 100644
--- a/tools/perf/builtin-config.c
+++ b/tools/perf/builtin-config.c
@@ -9,7 +9,6 @@
 
 #include "util/cache.h"
 #include <subcmd/parse-options.h>
-#include "util/util.h"
 #include "util/debug.h"
 #include "util/config.h"
 #include <linux/string.h>
diff --git a/tools/perf/builtin-evlist.c b/tools/perf/builtin-evlist.c
index 238fa3876805..294494e60e48 100644
--- a/tools/perf/builtin-evlist.c
+++ b/tools/perf/builtin-evlist.c
@@ -5,8 +5,6 @@
  */
 #include "builtin.h"
 
-#include "util/util.h"
-
 #include <linux/list.h>
 
 #include "perf.h"
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index b18fab94d38d..3047e5169d9d 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -48,7 +48,7 @@
 #include "util/auxtrace.h"
 #include "util/units.h"
 #include "util/branch.h"
-#include "util/util.h"
+#include "util/util.h" // perf_tip()
 #include "ui/ui.h"
 #include "ui/progress.h"
 
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 1193b923e801..bb40a108b8f7 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -20,7 +20,7 @@
 #include "util/bpf-loader.h"
 #include "util/debug.h"
 #include "util/event.h"
-#include "util/util.h"
+#include "util/util.h" // page_size, usage()
 #include "ui/ui.h"
 #include "perf-sys.h"
 #include <api/fs/fs.h>
diff --git a/tools/perf/tests/clang.c b/tools/perf/tests/clang.c
index ff2711a40940..2577d3ed1531 100644
--- a/tools/perf/tests/clang.c
+++ b/tools/perf/tests/clang.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "tests.h"
-#include "util.h"
 #include "c++/clang-c.h"
 #include <linux/kernel.h>
 
diff --git a/tools/perf/tests/dso-data.c b/tools/perf/tests/dso-data.c
index a4874d4ce7ef..627c1aaf1c9e 100644
--- a/tools/perf/tests/dso-data.c
+++ b/tools/perf/tests/dso-data.c
@@ -10,7 +10,6 @@
 #include <sys/resource.h>
 #include <api/fs/fs.h>
 #include "dso.h"
-#include "util.h"
 #include "machine.h"
 #include "symbol.h"
 #include "tests.h"
diff --git a/tools/perf/tests/event-times.c b/tools/perf/tests/event-times.c
index d824a726906c..0228ba435a2a 100644
--- a/tools/perf/tests/event-times.c
+++ b/tools/perf/tests/event-times.c
@@ -9,7 +9,6 @@
 #include "tests.h"
 #include "evlist.h"
 #include "evsel.h"
-#include "util.h"
 #include "debug.h"
 #include "parse-events.h"
 #include "thread_map.h"
diff --git a/tools/perf/tests/llvm.c b/tools/perf/tests/llvm.c
index 022e4c9cf092..ae6cda81c209 100644
--- a/tools/perf/tests/llvm.c
+++ b/tools/perf/tests/llvm.c
@@ -7,7 +7,6 @@
 #include "llvm.h"
 #include "tests.h"
 #include "debug.h"
-#include "util.h"
 
 #ifdef HAVE_LIBBPF_SUPPORT
 static int test__bpf_parsing(void *obj_buf, size_t obj_buf_sz)
diff --git a/tools/perf/tests/mmap-thread-lookup.c b/tools/perf/tests/mmap-thread-lookup.c
index 360d70deb855..f72889c13538 100644
--- a/tools/perf/tests/mmap-thread-lookup.c
+++ b/tools/perf/tests/mmap-thread-lookup.c
@@ -14,7 +14,7 @@
 #include "map.h"
 #include "symbol.h"
 #include "thread.h"
-#include "util.h"
+#include "util.h" // page_size
 
 #define THREADS 4
 
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 02ba696fb87f..c25c8e7b41e5 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -6,7 +6,6 @@
 #include "tests.h"
 #include "debug.h"
 #include "pmu.h"
-#include "util.h"
 #include <dirent.h>
 #include <errno.h>
 #include <sys/types.h>
diff --git a/tools/perf/tests/parse-no-sample-id-all.c b/tools/perf/tests/parse-no-sample-id-all.c
index 8284752a60c8..adf3c9c4a416 100644
--- a/tools/perf/tests/parse-no-sample-id-all.c
+++ b/tools/perf/tests/parse-no-sample-id-all.c
@@ -1,4 +1,3 @@
-// SPDX-License-Identifier: GPL-2.0
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <stddef.h>
@@ -8,7 +7,6 @@
 #include "event.h"
 #include "evlist.h"
 #include "header.h"
-#include "util.h"
 #include "debug.h"
 
 static int process_event(struct evlist **pevlist, union perf_event *event)
diff --git a/tools/perf/tests/perf-hooks.c b/tools/perf/tests/perf-hooks.c
index a693bcf017ea..dbc27199c65e 100644
--- a/tools/perf/tests/perf-hooks.c
+++ b/tools/perf/tests/perf-hooks.c
@@ -4,7 +4,6 @@
 
 #include "tests.h"
 #include "debug.h"
-#include "util.h"
 #include "perf-hooks.h"
 
 static void sigsegv_handler(int sig __maybe_unused)
diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index 14a78898d79e..74379ff1f7fa 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "parse-events.h"
 #include "pmu.h"
-#include "util.h"
 #include "tests.h"
 #include <errno.h>
 #include <stdio.h>
diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index 5fcc06817076..e3b965e7a233 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -9,7 +9,6 @@
 
 #include "map_symbol.h"
 #include "branch.h"
-#include "util.h"
 #include "event.h"
 #include "evsel.h"
 #include "debug.h"
diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index a4f9f5182b47..c963f301d15e 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -4,7 +4,6 @@
 #include <stdio.h>
 #include <perf/cpumap.h>
 #include "tests.h"
-#include "util.h"
 #include "session.h"
 #include "evlist.h"
 #include "debug.h"
diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 01f434c067c6..7f28775875c2 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -7,7 +7,7 @@
 #include "dso.h"
 #include "map.h"
 #include "symbol.h"
-#include "util.h"
+#include "util.h" // page_size
 #include "tests.h"
 #include "debug.h"
 #include "machine.h"
diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
index f93d40b1c203..781afe42e90e 100644
--- a/tools/perf/ui/browser.c
+++ b/tools/perf/ui/browser.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "../util/util.h"
 #include "../util/string2.h"
 #include "../util/config.h"
 #include "libslang.h"
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index ac74ed2c23a0..82207db8f97c 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -2,7 +2,6 @@
 #include "../browser.h"
 #include "../helpline.h"
 #include "../ui.h"
-#include "../util.h"
 #include "../../util/annotate.h"
 #include "../../util/debug.h"
 #include "../../util/dso.h"
diff --git a/tools/perf/ui/browsers/map.c b/tools/perf/ui/browsers/map.c
index 893b065971f6..3d49b916c9e4 100644
--- a/tools/perf/ui/browsers/map.c
+++ b/tools/perf/ui/browsers/map.c
@@ -5,7 +5,6 @@
 #include <stdlib.h>
 #include <string.h>
 #include <linux/bitops.h>
-#include "../../util/util.h"
 #include "../../util/debug.h"
 #include "../../util/map.h"
 #include "../../util/dso.h"
diff --git a/tools/perf/ui/browsers/res_sample.c b/tools/perf/ui/browsers/res_sample.c
index f16a38fea45e..76d356a18790 100644
--- a/tools/perf/ui/browsers/res_sample.c
+++ b/tools/perf/ui/browsers/res_sample.c
@@ -7,7 +7,7 @@
 #include "config.h"
 #include "time-utils.h"
 #include "../util.h"
-#include "../../util/util.h"
+#include "../../util/util.h" // perf_exe()
 #include "../../perf.h"
 #include <stdlib.h>
 #include <string.h>
diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
index 3b81075b8da8..fc733a6354d4 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "../../builtin.h"
 #include "../../perf.h"
-#include "../../util/util.h"
+#include "../../util/util.h" // perf_exe()
 #include "../util.h"
 #include "../../util/hist.h"
 #include "../../util/debug.h"
diff --git a/tools/perf/ui/gtk/progress.c b/tools/perf/ui/gtk/progress.c
index b6ad8857da78..eea6fcde518a 100644
--- a/tools/perf/ui/gtk/progress.c
+++ b/tools/perf/ui/gtk/progress.c
@@ -3,7 +3,6 @@
 
 #include "gtk.h"
 #include "../progress.h"
-#include "util.h"
 
 static GtkWidget *dialog;
 static GtkWidget *progress;
diff --git a/tools/perf/ui/helpline.c b/tools/perf/ui/helpline.c
index e00901450f91..911182b3f5e6 100644
--- a/tools/perf/ui/helpline.c
+++ b/tools/perf/ui/helpline.c
@@ -5,7 +5,6 @@
 
 #include "helpline.h"
 #include "ui.h"
-#include "../util/util.h"
 
 char ui_helpline__current[512];
 
diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index 3e533de7d852..f73675500061 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -8,7 +8,6 @@
 #include "../util/callchain.h"
 #include "../util/debug.h"
 #include "../util/hist.h"
-#include "../util/util.h"
 #include "../util/sort.h"
 #include "../util/evsel.h"
 #include "../util/evlist.h"
diff --git a/tools/perf/ui/setup.c b/tools/perf/ui/setup.c
index c7a86b4be9f5..700335cde618 100644
--- a/tools/perf/ui/setup.c
+++ b/tools/perf/ui/setup.c
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <pthread.h>
 #include <dlfcn.h>
+#include <unistd.h>
 
 #include <subcmd/pager.h>
 #include "../util/debug.h"
 #include "../util/hist.h"
-#include "../util/util.h"
 #include "ui.h"
 
 pthread_mutex_t ui__lock = PTHREAD_MUTEX_INITIALIZER;
diff --git a/tools/perf/ui/tui/setup.c b/tools/perf/ui/tui/setup.c
index 56651a4f5aa0..e9bfe856a5de 100644
--- a/tools/perf/ui/tui/setup.c
+++ b/tools/perf/ui/tui/setup.c
@@ -2,13 +2,13 @@
 #include <signal.h>
 #include <stdbool.h>
 #include <stdlib.h>
+#include <unistd.h>
 #include <linux/kernel.h>
 #ifdef HAVE_BACKTRACE_SUPPORT
 #include <execinfo.h>
 #endif
 
 #include "../../util/debug.h"
-#include "../../util/util.h"
 #include "../../perf.h"
 #include "../browser.h"
 #include "../helpline.h"
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 1748f528b6e9..d441cca6a517 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -14,7 +14,7 @@
 #include <bpf/btf.h>
 #include <bpf/libbpf.h>
 #include <linux/btf.h>
-#include "util.h"
+#include "util.h" // hex_width()
 #include "ui/ui.h"
 #include "sort.h"
 #include "build-id.h"
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 6f25224a3def..7ec0a6caa6cd 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -50,10 +50,12 @@
 #include "intel-bts.h"
 #include "arm-spe.h"
 #include "s390-cpumsf.h"
-#include "util.h"
+#include "util.h" // page_size
 
 #include <linux/ctype.h>
+#include <linux/kernel.h>
 #include "symbol/kallsyms.h"
+#include <internal/lib.h>
 
 static bool auxtrace__dont_decode(struct perf_session *session)
 {
diff --git a/tools/perf/util/branch.c b/tools/perf/util/branch.c
index 52261e5f718a..2285b1eb3128 100644
--- a/tools/perf/util/branch.c
+++ b/tools/perf/util/branch.c
@@ -1,4 +1,3 @@
-#include "util/util.h"
 #include "util/map_symbol.h"
 #include "util/branch.h"
 #include <linux/kernel.h>
diff --git a/tools/perf/util/branch.h b/tools/perf/util/branch.h
index 06f66dad0b79..88e00d268f6f 100644
--- a/tools/perf/util/branch.h
+++ b/tools/perf/util/branch.h
@@ -1,8 +1,15 @@
 #ifndef _PERF_BRANCH_H
 #define _PERF_BRANCH_H 1
-
+/*
+ * The linux/stddef.h isn't need here, but is needed for __always_inline used
+ * in files included from uapi/linux/perf_event.h such as
+ * /usr/include/linux/swab.h and /usr/include/linux/byteorder/little_endian.h,
+ * detected in at least musl libc, used in Alpine Linux. -acme
+ */
 #include <stdio.h>
 #include <stdint.h>
+#include <linux/compiler.h>
+#include <linux/stddef.h>
 #include <linux/perf_event.h>
 #include <linux/types.h>
 
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index e5fb77755d9e..7928c398a063 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -7,7 +7,7 @@
  * Copyright (C) 2009, 2010 Red Hat Inc.
  * Copyright (C) 2009, 2010 Arnaldo Carvalho de Melo <acme@redhat.com>
  */
-#include "util.h"
+#include "util.h" // copyfile_ns(), lsdir(), mkdir_p(), rm_rf()
 #include <dirent.h>
 #include <errno.h>
 #include <stdio.h>
diff --git a/tools/perf/util/cloexec.c b/tools/perf/util/cloexec.c
index 4e904fcb2783..a12872f2856a 100644
--- a/tools/perf/util/cloexec.c
+++ b/tools/perf/util/cloexec.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
 #include <sched.h>
-#include "util.h"
+#include "util.h" // for sched_getcpu()
 #include "../perf-sys.h"
 #include "cloexec.h"
 #include "event.h"
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 37d7c492b155..cd92a99eb89d 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -17,7 +17,6 @@
 #include "cs-etm.h"
 #include "cs-etm-decoder.h"
 #include "intlist.h"
-#include "util.h"
 
 /* use raw logging */
 #ifdef CS_DEBUG_RAW
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 707afdbd9529..f87b9c1c9f9a 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -35,7 +35,6 @@
 #include "thread.h"
 #include "thread-stack.h"
 #include <tools/libc_compat.h>
-#include "util.h"
 
 #define MAX_TIMESTAMP (~0ULL)
 
diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index e75c3a279fe8..88fba2ba549f 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -13,9 +13,10 @@
 #include <dirent.h>
 
 #include "data.h"
-#include "util.h"
+#include "util.h" // rm_rf_perf_data()
 #include "debug.h"
 #include "header.h"
+#include <internal/lib.h>
 
 static void close_dir(struct perf_data_file *files, int nr)
 {
diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index a1b59bd35519..e55114f0336f 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -17,7 +17,6 @@
 #include "event.h"
 #include "debug.h"
 #include "print_binary.h"
-#include "util.h"
 #include "target.h"
 #include "ui/helpline.h"
 #include "ui/ui.h"
diff --git a/tools/perf/util/demangle-rust.c b/tools/perf/util/demangle-rust.c
index 423afbbd386b..a659fc69f73a 100644
--- a/tools/perf/util/demangle-rust.c
+++ b/tools/perf/util/demangle-rust.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <string.h>
-#include "util.h"
 #include "debug.h"
 
 #include "demangle-rust.h"
diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index db55eddce8cd..1b49ecee5aff 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -5,7 +5,6 @@
  * Written by: Masami Hiramatsu <mhiramat@kernel.org>
  */
 
-#include <util.h>
 #include <debug.h>
 #include <dwarf-regs.h>
 #include <elf.h>
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 095924aa186b..ea9517d506d8 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -16,7 +16,7 @@
 #include "evsel.h"
 #include "debug.h"
 #include "units.h"
-#include "util.h"
+#include "util.h" // page_size
 #include "../perf.h"
 #include "asm/bug.h"
 #include "bpf-event.h"
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 85825384f9e8..c194ec787f96 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -45,6 +45,7 @@
 #include "../perf-sys.h"
 #include "util/parse-branch-options.h"
 #include <internal/xyarray.h>
+#include <internal/lib.h>
 
 #include <linux/ctype.h>
 
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index b0c34dda30a0..d85827de1b60 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -42,11 +42,12 @@
 #include "tool.h"
 #include "time-utils.h"
 #include "units.h"
-#include "util.h"
+#include "util.h" // page_size, perf_exe()
 #include "cputopo.h"
 #include "bpf-event.h"
 
 #include <linux/ctype.h>
+#include <internal/lib.h>
 
 /*
  * magic2 = "PERFILE2"
diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 00db9957fdb0..9f9c6c6a2fd3 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -15,7 +15,6 @@
 #include <linux/stringify.h>
 
 #include "build-id.h"
-#include "util.h"
 #include "event.h"
 #include "debug.h"
 #include "evlist.h"
diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
index 55fb4b3b1157..8d04e3d070b1 100644
--- a/tools/perf/util/llvm-utils.c
+++ b/tools/perf/util/llvm-utils.c
@@ -8,6 +8,7 @@
 #include <limits.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <unistd.h>
 #include <linux/err.h>
 #include <linux/string.h>
 #include <linux/zalloc.h>
diff --git a/tools/perf/util/lzma.c b/tools/perf/util/lzma.c
index 397447066033..39062df02629 100644
--- a/tools/perf/util/lzma.c
+++ b/tools/perf/util/lzma.c
@@ -7,10 +7,10 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include "compress.h"
-#include "util.h"
 #include "debug.h"
 #include <string.h>
 #include <unistd.h>
+#include <internal/lib.h>
 
 #define BUFSIZE 8192
 
diff --git a/tools/perf/util/perf-hooks.c b/tools/perf/util/perf-hooks.c
index e635c594f773..7a0ab3507bd5 100644
--- a/tools/perf/util/perf-hooks.c
+++ b/tools/perf/util/perf-hooks.c
@@ -12,7 +12,6 @@
 #include <setjmp.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
-#include "util/util.h"
 #include "util/debug.h"
 #include "util/perf-hooks.h"
 
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index 286fe816c0f3..860c48895ab6 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -10,7 +10,6 @@
 #include <api/fs/fs.h>
 #include <subcmd/parse-options.h>
 #include <perf/cpumap.h>
-#include "util.h"
 #include "cloexec.h"
 #include "record.h"
 #include "../perf-sys.h"
diff --git a/tools/perf/util/rwsem.c b/tools/perf/util/rwsem.c
index 5e52e7baa7b6..f3d29d8ddc99 100644
--- a/tools/perf/util/rwsem.c
+++ b/tools/perf/util/rwsem.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include "util.h"
 #include "rwsem.h"
 
diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
index 4d9593e331ea..05b43ab4eeef 100644
--- a/tools/perf/util/s390-sample-raw.c
+++ b/tools/perf/util/s390-sample-raw.c
@@ -22,7 +22,6 @@
 #include <asm/byteorder.h>
 
 #include "debug.h"
-#include "util.h"
 #include "session.h"
 #include "evlist.h"
 #include "color.h"
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 666a56e88d8e..bb6828532741 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -37,7 +37,6 @@
 #include "../dso.h"
 #include "../callchain.h"
 #include "../evsel.h"
-#include "../util.h"
 #include "../event.h"
 #include "../thread.h"
 #include "../comm.h"
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index e9e4a04f15db..2b133bc22caa 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -34,6 +34,7 @@
 #include "ui/progress.h"
 #include "../perf.h"
 #include "arch/common.h"
+#include <internal/lib.h>
 
 #ifdef HAVE_ZSTD_SUPPORT
 static int perf_session__process_compressed_event(struct perf_session *session,
diff --git a/tools/perf/util/srccode.c b/tools/perf/util/srccode.c
index adfcf1ff464c..b402f9ca89ab 100644
--- a/tools/perf/util/srccode.c
+++ b/tools/perf/util/srccode.c
@@ -15,7 +15,7 @@
 #include <string.h>
 #include "srccode.h"
 #include "debug.h"
-#include "util.h"
+#include "util.h" // page_size
 
 #define MAXSRCCACHE (32*1024*1024)
 #define MAXSRCFILES     64
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 9428639872a6..8b9199c343dd 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -18,8 +18,10 @@
 #include "debug.h"
 #include "util.h"
 #include <linux/ctype.h>
+#include <linux/kernel.h>
 #include <linux/zalloc.h>
 #include <symbol/kallsyms.h>
+#include <internal/lib.h>
 
 #ifndef EM_AARCH64
 #define EM_AARCH64	183  /* ARM 64 bit */
diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
index 7e2813ec9498..d6e99af263ec 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -1,8 +1,6 @@
-// SPDX-License-Identifier: GPL-2.0
 #include "dso.h"
 #include "symbol.h"
 #include "symsrc.h"
-#include "util.h"
 
 #include <errno.h>
 #include <unistd.h>
@@ -13,6 +11,7 @@
 #include <byteswap.h>
 #include <sys/stat.h>
 #include <linux/zalloc.h>
+#include <internal/lib.h>
 
 static bool check_need_swap(int file_endian)
 {
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 765c75df2904..a8f80e427674 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -19,7 +19,7 @@
 #include "build-id.h"
 #include "cap.h"
 #include "dso.h"
-#include "util.h"
+#include "util.h" // lsdir()
 #include "debug.h"
 #include "event.h"
 #include "machine.h"
diff --git a/tools/perf/util/target.c b/tools/perf/util/target.c
index e152d2bbe3a3..a3db13dea937 100644
--- a/tools/perf/util/target.c
+++ b/tools/perf/util/target.c
@@ -6,7 +6,6 @@
  */
 
 #include "target.h"
-#include "util.h"
 
 #include <pwd.h>
 #include <stdio.h>
diff --git a/tools/perf/util/trace-event-info.c b/tools/perf/util/trace-event-info.c
index d63d542b2cde..fe07e7550930 100644
--- a/tools/perf/util/trace-event-info.c
+++ b/tools/perf/util/trace-event-info.c
@@ -2,7 +2,7 @@
 /*
  * Copyright (C) 2008,2009, Steven Rostedt <srostedt@redhat.com>
  */
-#include "util.h"
+#include "util.h" // page_size
 #include <dirent.h>
 #include <mntent.h>
 #include <stdio.h>
diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
index b6c0db068be0..8593d3c200c6 100644
--- a/tools/perf/util/trace-event-read.c
+++ b/tools/perf/util/trace-event-read.c
@@ -15,7 +15,6 @@
 #include <unistd.h>
 #include <errno.h>
 
-#include "util.h"
 #include "trace-event.h"
 #include "debug.h"
 
diff --git a/tools/perf/util/trace-event.c b/tools/perf/util/trace-event.c
index 01b9d89bf5bf..b3ee651e3d91 100644
--- a/tools/perf/util/trace-event.c
+++ b/tools/perf/util/trace-event.c
@@ -14,7 +14,6 @@
 #include <api/fs/fs.h>
 #include "trace-event.h"
 #include "machine.h"
-#include "util.h"
 
 /*
  * global trace_event object used by trace_event__tp_format
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 9ece188ae48a..15f6e46d7124 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -17,7 +17,6 @@
 #include "event.h"
 #include "perf_regs.h"
 #include "callchain.h"
-#include "util.h"
 
 static char *debuginfo_path;
 
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index ebdbb056510c..1800887b2255 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -37,7 +37,6 @@
 #include "unwind.h"
 #include "map.h"
 #include "symbol.h"
-#include "util.h"
 #include "debug.h"
 #include "asm/bug.h"
 #include "dso.h"
diff --git a/tools/perf/util/vdso.c b/tools/perf/util/vdso.c
index e5e6599603f4..ba4b4395f35d 100644
--- a/tools/perf/util/vdso.c
+++ b/tools/perf/util/vdso.c
@@ -11,7 +11,7 @@
 
 #include "vdso.h"
 #include "dso.h"
-#include "util.h"
+#include <internal/lib.h>
 #include "map.h"
 #include "symbol.h"
 #include "machine.h"
diff --git a/tools/perf/util/zlib.c b/tools/perf/util/zlib.c
index deb6e69adb5a..78d2297c1b67 100644
--- a/tools/perf/util/zlib.c
+++ b/tools/perf/util/zlib.c
@@ -7,9 +7,9 @@
 #include <sys/mman.h>
 #include <zlib.h>
 #include <linux/compiler.h>
+#include <internal/lib.h>
 
 #include "util/compress.h"
-#include "util/util.h"
 
 #define CHUNK_SIZE  16384
 
-- 
2.21.0

