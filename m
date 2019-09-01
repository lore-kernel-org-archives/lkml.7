Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC52C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2686123429
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567340670;
	bh=XhDYmvRQLfmHt5hZiw8jHIaN7oqa4sOh98PCODz6GpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cUESUJvev3oXQtnqaEUE+H9hbzTvFqU4L+EzhVkiifdiyC8lt1UU5ZknS4PAL1s8O
	 xJyFS0r1ZR4mrY1i+38SFbGRdylc9bSlfaciL63krspRHWZCD9tc6ypCTVUjtjioSw
	 cgPOWWKvnAscmnvSI7CWtyDjdJ8tQHX1yoysl4zY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbfIAMY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 08:24:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:41278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729022AbfIAMY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 08:24:26 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4982F23697;
        Sun,  1 Sep 2019 12:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567340664;
        bh=XhDYmvRQLfmHt5hZiw8jHIaN7oqa4sOh98PCODz6GpY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PongVl3B+1YepIJXVNM1LD9tAsgjqjiv1xsoUC3wLkv6u3wQKeOh7kq91DE0Gr6K0
         4VL3mabT2LF+p8SiAn0boBQGAG2/R5++MrckrGHleyJ3lqNliMQBulDXs+DYEYSlQh
         +Hf3XcnGssA6tp1F3l5wdielXKLGBMM96XPZOr54=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 16/47] perf debug: Remove needless include directives from debug.h
Date:   Sun,  1 Sep 2019 09:22:55 -0300
Message-Id: <20190901122326.5793-17-acme@kernel.org>
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

All we need there is a forward declaration for 'union perf_event', so
remove it from there and add missing header directives in places using
things from this indirect include.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-7ftk0ztstqub1tirjj8o8xbl@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/cs-etm.c           | 1 +
 tools/perf/arch/common.c                    | 2 ++
 tools/perf/arch/x86/tests/bp-modify.c       | 1 +
 tools/perf/arch/x86/tests/insn-x86.c        | 1 +
 tools/perf/arch/x86/tests/rdpmc.c           | 2 ++
 tools/perf/arch/x86/util/perf_regs.c        | 1 +
 tools/perf/builtin-c2c.c                    | 2 ++
 tools/perf/builtin-config.c                 | 1 +
 tools/perf/builtin-data.c                   | 2 ++
 tools/perf/builtin-diff.c                   | 1 +
 tools/perf/builtin-ftrace.c                 | 3 ++-
 tools/perf/builtin-help.c                   | 4 ++++
 tools/perf/builtin-kmem.c                   | 1 +
 tools/perf/builtin-list.c                   | 1 +
 tools/perf/builtin-probe.c                  | 1 +
 tools/perf/builtin-record.c                 | 1 +
 tools/perf/builtin-report.c                 | 2 ++
 tools/perf/builtin-top.c                    | 1 +
 tools/perf/builtin-trace.c                  | 1 +
 tools/perf/perf.c                           | 2 ++
 tools/perf/tests/attr.c                     | 1 +
 tools/perf/tests/backward-ring-buffer.c     | 1 +
 tools/perf/tests/bp_account.c               | 1 +
 tools/perf/tests/bp_signal.c                | 1 +
 tools/perf/tests/bp_signal_overflow.c       | 1 +
 tools/perf/tests/bpf.c                      | 1 +
 tools/perf/tests/event-times.c              | 1 +
 tools/perf/tests/expr.c                     | 1 +
 tools/perf/tests/kmod-path.c                | 2 ++
 tools/perf/tests/mmap-basic.c               | 1 +
 tools/perf/tests/openat-syscall-all-cpus.c  | 1 +
 tools/perf/tests/openat-syscall-tp-fields.c | 1 +
 tools/perf/tests/openat-syscall.c           | 1 +
 tools/perf/tests/perf-record.c              | 1 +
 tools/perf/tests/sample-parsing.c           | 1 +
 tools/perf/tests/task-exit.c                | 1 +
 tools/perf/tests/thread-map.c               | 7 +++++++
 tools/perf/tests/unit_number__scnprintf.c   | 1 +
 tools/perf/tests/wp.c                       | 3 +++
 tools/perf/ui/browsers/scripts.c            | 1 +
 tools/perf/ui/gtk/helpline.c                | 1 +
 tools/perf/ui/gtk/util.c                    | 1 +
 tools/perf/ui/tui/helpline.c                | 1 +
 tools/perf/ui/util.c                        | 2 +-
 tools/perf/util/bpf-prologue.c              | 1 +
 tools/perf/util/branch.c                    | 1 +
 tools/perf/util/callchain.c                 | 1 +
 tools/perf/util/cloexec.c                   | 2 ++
 tools/perf/util/data.c                      | 1 +
 tools/perf/util/debug.c                     | 1 +
 tools/perf/util/debug.h                     | 6 ++----
 tools/perf/util/dwarf-aux.c                 | 1 +
 tools/perf/util/dwarf-aux.h                 | 2 ++
 tools/perf/util/env.c                       | 1 +
 tools/perf/util/evlist.c                    | 1 +
 tools/perf/util/expr.y                      | 2 ++
 tools/perf/util/hist.c                      | 1 +
 tools/perf/util/intel-pt.c                  | 1 +
 tools/perf/util/llvm-utils.c                | 1 +
 tools/perf/util/lzma.c                      | 1 +
 tools/perf/util/machine.c                   | 1 +
 tools/perf/util/map.c                       | 1 +
 tools/perf/util/ordered-events.c            | 1 +
 tools/perf/util/parse-branch-options.c      | 2 ++
 tools/perf/util/perf-hooks.c                | 1 +
 tools/perf/util/probe-finder.c              | 1 +
 tools/perf/util/pstack.c                    | 1 +
 tools/perf/util/sort.c                      | 1 +
 tools/perf/util/strbuf.c                    | 4 ++++
 tools/perf/util/symbol.c                    | 1 +
 tools/perf/util/target.c                    | 3 +++
 tools/perf/util/thread-stack.c              | 1 +
 tools/perf/util/util.c                      | 1 +
 tools/perf/util/values.c                    | 1 +
 tools/perf/util/zlib.c                      | 1 +
 75 files changed, 104 insertions(+), 6 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index b74fd408d496..197041fcba25 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -11,6 +11,7 @@
 #include <linux/coresight-pmu.h>
 #include <linux/kernel.h>
 #include <linux/log2.h>
+#include <linux/string.h>
 #include <linux/types.h>
 #include <linux/zalloc.h>
 
diff --git a/tools/perf/arch/common.c b/tools/perf/arch/common.c
index a769382fb644..59dd875fd5e4 100644
--- a/tools/perf/arch/common.c
+++ b/tools/perf/arch/common.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <limits.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <unistd.h>
 #include "common.h"
 #include "../util/env.h"
diff --git a/tools/perf/arch/x86/tests/bp-modify.c b/tools/perf/arch/x86/tests/bp-modify.c
index f53e4406709f..adcacf1b6609 100644
--- a/tools/perf/arch/x86/tests/bp-modify.c
+++ b/tools/perf/arch/x86/tests/bp-modify.c
@@ -7,6 +7,7 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <sys/ptrace.h>
 #include <asm/ptrace.h>
 #include <errno.h>
diff --git a/tools/perf/arch/x86/tests/insn-x86.c b/tools/perf/arch/x86/tests/insn-x86.c
index c3e5f4ab0d3e..d67bc0ffb70a 100644
--- a/tools/perf/arch/x86/tests/insn-x86.c
+++ b/tools/perf/arch/x86/tests/insn-x86.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/types.h>
+#include <string.h>
 
 #include "debug.h"
 #include "tests/tests.h"
diff --git a/tools/perf/arch/x86/tests/rdpmc.c b/tools/perf/arch/x86/tests/rdpmc.c
index 345a6a0a328b..6e67cee792b1 100644
--- a/tools/perf/arch/x86/tests/rdpmc.c
+++ b/tools/perf/arch/x86/tests/rdpmc.c
@@ -6,11 +6,13 @@
 #include <sys/mman.h>
 #include <sys/types.h>
 #include <sys/wait.h>
+#include <linux/string.h>
 #include <linux/types.h>
 #include "perf-sys.h"
 #include "debug.h"
 #include "tests/tests.h"
 #include "cloexec.h"
+#include "event.h"
 #include "util.h"
 #include "arch-tests.h"
 
diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
index 74a606ea42d3..99ea60211e16 100644
--- a/tools/perf/arch/x86/util/perf_regs.c
+++ b/tools/perf/arch/x86/util/perf_regs.c
@@ -7,6 +7,7 @@
 #include "../../perf-sys.h"
 #include "../../util/perf_regs.h"
 #include "../../util/debug.h"
+#include "../../util/event.h"
 
 const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG(AX, PERF_REG_X86_AX),
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 25a5f186dfde..d1ad694c67a2 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -20,6 +20,7 @@
 #include <sys/param.h>
 #include "debug.h"
 #include "builtin.h"
+#include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
 #include "mem-events.h"
 #include "session.h"
@@ -35,6 +36,7 @@
 #include "thread.h"
 #include "mem2node.h"
 #include "symbol.h"
+#include "ui/ui.h"
 #include "../perf.h"
 
 struct c2c_hists {
diff --git a/tools/perf/builtin-config.c b/tools/perf/builtin-config.c
index edfc8f76f1bd..42d8157e047a 100644
--- a/tools/perf/builtin-config.c
+++ b/tools/perf/builtin-config.c
@@ -13,6 +13,7 @@
 #include "util/debug.h"
 #include "util/config.h"
 #include <linux/string.h>
+#include <stdio.h>
 #include <stdlib.h>
 
 static bool use_system_config, use_user_config;
diff --git a/tools/perf/builtin-data.c b/tools/perf/builtin-data.c
index dde25d4ca56d..ca2fb44874e4 100644
--- a/tools/perf/builtin-data.c
+++ b/tools/perf/builtin-data.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/compiler.h>
+#include <stdio.h>
+#include <string.h>
 #include "builtin.h"
 #include "perf.h"
 #include "debug.h"
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index ae4a8ebf90d2..827e4800d862 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -24,6 +24,7 @@
 #include "util/annotate.h"
 #include "util/map.h"
 #include <linux/zalloc.h>
+#include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
 
 #include <errno.h>
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 7374f86833fd..2f8ea44c00c4 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -13,8 +13,10 @@
 #include <fcntl.h>
 #include <poll.h>
 #include <linux/capability.h>
+#include <linux/string.h>
 
 #include "debug.h"
+#include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
 #include <api/fs/tracing_path.h>
 #include "evlist.h"
@@ -24,7 +26,6 @@
 #include "util/cap.h"
 #include "util/config.h"
 
-
 #define DEFAULT_TRACER  "function_graph"
 
 struct perf_ftrace {
diff --git a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
index 641d4a3f93c3..3976aebe3677 100644
--- a/tools/perf/builtin-help.c
+++ b/tools/perf/builtin-help.c
@@ -4,7 +4,9 @@
  *
  * Builtin help command
  */
+#include "util/cache.h"
 #include "util/config.h"
+#include "util/strbuf.h"
 #include "builtin.h"
 #include <subcmd/exec-cmd.h>
 #include "common-cmds.h"
@@ -13,10 +15,12 @@
 #include <subcmd/help.h>
 #include "util/debug.h"
 #include <linux/kernel.h>
+#include <linux/string.h>
 #include <linux/zalloc.h>
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 46f828936120..7eec0da64c46 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -14,6 +14,7 @@
 #include "util/callchain.h"
 #include "util/time-utils.h"
 
+#include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
 #include "util/trace-event.h"
 #include "util/data.h"
diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index dca0d33c1343..11afb760616b 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -16,6 +16,7 @@
 #include "util/debug.h"
 #include "util/metricgroup.h"
 #include <subcmd/parse-options.h>
+#include <stdio.h>
 
 static bool desc_flag = true;
 static bool details_flag;
diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index f45fd7e9723e..8950c05ef8fd 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -26,6 +26,7 @@
 #include "util/probe-finder.h"
 #include "util/probe-event.h"
 #include "util/probe-file.h"
+#include <linux/string.h>
 #include <linux/zalloc.h>
 
 #define DEFAULT_VAR_FILTER "!__k???tab_* & !__crc_*"
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 56705d2a6bec..1447004eee8a 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -53,6 +53,7 @@
 #include <signal.h>
 #include <sys/mman.h>
 #include <sys/wait.h>
+#include <linux/string.h>
 #include <linux/time64.h>
 #include <linux/zalloc.h>
 
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 33c20e26b290..94e7e354cb16 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -45,6 +45,7 @@
 #include "util/units.h"
 #include "util/branch.h"
 #include "util/util.h"
+#include "ui/ui.h"
 
 #include <dlfcn.h>
 #include <errno.h>
@@ -53,6 +54,7 @@
 #include <linux/ctype.h>
 #include <signal.h>
 #include <linux/bitmap.h>
+#include <linux/string.h>
 #include <linux/stringify.h>
 #include <linux/time64.h>
 #include <sys/types.h>
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index c3f95440e99c..5538b5886e35 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -45,6 +45,7 @@
 #include "util/intlist.h"
 #include "util/parse-branch-options.h"
 #include "arch/common.h"
+#include "ui/ui.h"
 
 #include "util/debug.h"
 #include "util/ordered-events.h"
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 105695033ebc..b1ec8ff52740 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -29,6 +29,7 @@
 #include "util/event.h"
 #include "util/evlist.h"
 #include "util/evswitch.h"
+#include <subcmd/pager.h>
 #include <subcmd/exec-cmd.h>
 #include "util/machine.h"
 #include "util/map.h"
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 237b9b3a1bf1..e0910637a82d 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -10,6 +10,7 @@
 #include "builtin.h"
 #include "perf.h"
 
+#include "util/cache.h"
 #include "util/env.h"
 #include <subcmd/exec-cmd.h>
 #include "util/config.h"
@@ -32,6 +33,7 @@
 #include <sys/stat.h>
 #include <unistd.h>
 #include <linux/kernel.h>
+#include <linux/string.h>
 #include <linux/zalloc.h>
 
 const char perf_usage_string[] =
diff --git a/tools/perf/tests/attr.c b/tools/perf/tests/attr.c
index 87dc3e1174af..a9599ab8c471 100644
--- a/tools/perf/tests/attr.c
+++ b/tools/perf/tests/attr.c
@@ -32,6 +32,7 @@
 #include <unistd.h>
 #include "../perf-sys.h"
 #include <subcmd/exec-cmd.h>
+#include "event.h"
 #include "tests.h"
 
 #define ENV "PERF_TEST_ATTR"
diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
index b6f27ef9fb02..512288e9f547 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -10,6 +10,7 @@
 #include "tests.h"
 #include "debug.h"
 #include <errno.h>
+#include <linux/string.h>
 
 #define NR_ITERS 111
 
diff --git a/tools/perf/tests/bp_account.c b/tools/perf/tests/bp_account.c
index c4a30318d7e0..016bba2c142d 100644
--- a/tools/perf/tests/bp_account.c
+++ b/tools/perf/tests/bp_account.c
@@ -19,6 +19,7 @@
 
 #include "tests.h"
 #include "debug.h"
+#include "event.h"
 #include "../perf-sys.h"
 #include "cloexec.h"
 
diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
index 2d292f8fb3dd..c1c2c13de254 100644
--- a/tools/perf/tests/bp_signal.c
+++ b/tools/perf/tests/bp_signal.c
@@ -25,6 +25,7 @@
 
 #include "tests.h"
 #include "debug.h"
+#include "event.h"
 #include "perf-sys.h"
 #include "cloexec.h"
 
diff --git a/tools/perf/tests/bp_signal_overflow.c b/tools/perf/tests/bp_signal_overflow.c
index 101315a3b34f..eb4dbbddf4ff 100644
--- a/tools/perf/tests/bp_signal_overflow.c
+++ b/tools/perf/tests/bp_signal_overflow.c
@@ -24,6 +24,7 @@
 
 #include "tests.h"
 #include "debug.h"
+#include "event.h"
 #include "../perf-sys.h"
 #include "cloexec.h"
 
diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index 98642961fc63..9fc163b2acbb 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -12,6 +12,7 @@
 #include <linux/bpf.h>
 #include <linux/filter.h>
 #include <linux/kernel.h>
+#include <linux/string.h>
 #include <api/fs/fs.h>
 #include <bpf/bpf.h>
 #include "tests.h"
diff --git a/tools/perf/tests/event-times.c b/tools/perf/tests/event-times.c
index 714e3611352c..228d1618cf7d 100644
--- a/tools/perf/tests/event-times.c
+++ b/tools/perf/tests/event-times.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/compiler.h>
+#include <linux/string.h>
 #include <errno.h>
 #include <inttypes.h>
 #include <string.h>
diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index ee1d88650e69..87843af4c118 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -3,6 +3,7 @@
 #include "util/expr.h"
 #include "tests.h"
 #include <stdlib.h>
+#include <string.h>
 #include <linux/zalloc.h>
 
 static int test(struct parse_ctx *ctx, const char *e, double val2)
diff --git a/tools/perf/tests/kmod-path.c b/tools/perf/tests/kmod-path.c
index 0579a70bbbff..e483210b176b 100644
--- a/tools/perf/tests/kmod-path.c
+++ b/tools/perf/tests/kmod-path.c
@@ -1,9 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdbool.h>
 #include <stdlib.h>
+#include <string.h>
 #include "tests.h"
 #include "dso.h"
 #include "debug.h"
+#include "event.h"
 
 static int test(const char *path, bool alloc_name, bool kmod,
 		int comp, const char *name)
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index fe91350fd5ab..bdf77bfe1b80 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -13,6 +13,7 @@
 #include "tests.h"
 #include <linux/err.h>
 #include <linux/kernel.h>
+#include <linux/string.h>
 #include <perf/evlist.h>
 
 /*
diff --git a/tools/perf/tests/openat-syscall-all-cpus.c b/tools/perf/tests/openat-syscall-all-cpus.c
index 4ae4dea07466..9171f77cd9cd 100644
--- a/tools/perf/tests/openat-syscall-all-cpus.c
+++ b/tools/perf/tests/openat-syscall-all-cpus.c
@@ -9,6 +9,7 @@
 #include <fcntl.h>
 #include <api/fs/fs.h>
 #include <linux/err.h>
+#include <linux/string.h>
 #include <api/fs/tracing_path.h>
 #include "evsel.h"
 #include "tests.h"
diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index 62492106fb5e..b71167b43dda 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdbool.h>
 #include <linux/err.h>
+#include <linux/string.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
diff --git a/tools/perf/tests/openat-syscall.c b/tools/perf/tests/openat-syscall.c
index 58df4bda5e12..5ebffae18605 100644
--- a/tools/perf/tests/openat-syscall.c
+++ b/tools/perf/tests/openat-syscall.c
@@ -3,6 +3,7 @@
 #include <inttypes.h>
 #include <api/fs/tracing_path.h>
 #include <linux/err.h>
+#include <linux/string.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index 3a205f6f9363..e1b42292cf7f 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
 #include <inttypes.h>
+#include <linux/string.h>
 /* For the CLR_() macros */
 #include <pthread.h>
 
diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index a8ca29fe172b..0c09dc15a059 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -2,6 +2,7 @@
 #include <stdbool.h>
 #include <inttypes.h>
 #include <stdlib.h>
+#include <string.h>
 #include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index 0e0e0627184e..f610e8c0a083 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -9,6 +9,7 @@
 
 #include <errno.h>
 #include <signal.h>
+#include <linux/string.h>
 #include <perf/evlist.h>
 
 static int exited;
diff --git a/tools/perf/tests/thread-map.c b/tools/perf/tests/thread-map.c
index c19ec8849e77..39168c57943b 100644
--- a/tools/perf/tests/thread-map.c
+++ b/tools/perf/tests/thread-map.c
@@ -1,12 +1,19 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdlib.h>
+#include <string.h>
 #include <sys/types.h>
 #include <unistd.h>
 #include <sys/prctl.h>
 #include "tests.h"
 #include "thread_map.h"
 #include "debug.h"
+#include "event.h"
 #include <linux/zalloc.h>
+#include <perf/event.h>
+
+struct perf_sample;
+struct perf_tool;
+struct machine;
 
 #define NAME	(const char *) "perf"
 #define NAMEUL	(unsigned long) NAME
diff --git a/tools/perf/tests/unit_number__scnprintf.c b/tools/perf/tests/unit_number__scnprintf.c
index 2bb8cb0039c1..3721757435da 100644
--- a/tools/perf/tests/unit_number__scnprintf.c
+++ b/tools/perf/tests/unit_number__scnprintf.c
@@ -2,6 +2,7 @@
 #include <inttypes.h>
 #include <linux/compiler.h>
 #include <linux/types.h>
+#include <string.h>
 #include "tests.h"
 #include "units.h"
 #include "debug.h"
diff --git a/tools/perf/tests/wp.c b/tools/perf/tests/wp.c
index 982ac55d69ea..d262d6639829 100644
--- a/tools/perf/tests/wp.c
+++ b/tools/perf/tests/wp.c
@@ -1,10 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdlib.h>
+#include <string.h>
 #include <unistd.h>
 #include <sys/ioctl.h>
 #include <linux/hw_breakpoint.h>
+#include <linux/kernel.h>
 #include "tests.h"
 #include "debug.h"
+#include "event.h"
 #include "cloexec.h"
 #include "../perf-sys.h"
 
diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
index e63f3778d75c..77809c0fad02 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -9,6 +9,7 @@
 #include "../browser.h"
 #include "../libslang.h"
 #include "config.h"
+#include <linux/string.h>
 #include <linux/zalloc.h>
 
 #define SCRIPT_NAMELEN	128
diff --git a/tools/perf/ui/gtk/helpline.c b/tools/perf/ui/gtk/helpline.c
index fbf1ea9ce9a2..e166da9ec767 100644
--- a/tools/perf/ui/gtk/helpline.c
+++ b/tools/perf/ui/gtk/helpline.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <string.h>
+#include <linux/kernel.h>
 
 #include "gtk.h"
 #include "../ui.h"
diff --git a/tools/perf/ui/gtk/util.c b/tools/perf/ui/gtk/util.c
index c28bdb7517ac..c2c558958b9c 100644
--- a/tools/perf/ui/gtk/util.c
+++ b/tools/perf/ui/gtk/util.c
@@ -3,6 +3,7 @@
 #include "../../util/debug.h"
 #include "gtk.h"
 
+#include <stdlib.h>
 #include <string.h>
 #include <linux/zalloc.h>
 
diff --git a/tools/perf/ui/tui/helpline.c b/tools/perf/ui/tui/helpline.c
index 93d6b7240285..1793c98653a5 100644
--- a/tools/perf/ui/tui/helpline.c
+++ b/tools/perf/ui/tui/helpline.c
@@ -3,6 +3,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <pthread.h>
+#include <linux/kernel.h>
 
 #include "../../util/debug.h"
 #include "../helpline.h"
diff --git a/tools/perf/ui/util.c b/tools/perf/ui/util.c
index 9ed76e88a3e4..689b27c34246 100644
--- a/tools/perf/ui/util.c
+++ b/tools/perf/ui/util.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "util.h"
 #include "../util/debug.h"
-
+#include <stdio.h>
 
 /*
  * Default error logging functions
diff --git a/tools/perf/util/bpf-prologue.c b/tools/perf/util/bpf-prologue.c
index 09e6c76e1c3b..b020a8678eb9 100644
--- a/tools/perf/util/bpf-prologue.c
+++ b/tools/perf/util/bpf-prologue.c
@@ -13,6 +13,7 @@
 #include "bpf-prologue.h"
 #include "probe-finder.h"
 #include <errno.h>
+#include <stdlib.h>
 #include <dwarf-regs.h>
 #include <linux/filter.h>
 
diff --git a/tools/perf/util/branch.c b/tools/perf/util/branch.c
index 02d6d839ff24..30642e1f2b1b 100644
--- a/tools/perf/util/branch.c
+++ b/tools/perf/util/branch.c
@@ -1,6 +1,7 @@
 #include "util/util.h"
 #include "util/debug.h"
 #include "util/branch.h"
+#include <linux/kernel.h>
 
 static bool cross_area(u64 addr1, u64 addr2, int size)
 {
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index a47d0e8c2434..76bf05b26d3b 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -16,6 +16,7 @@
 #include <stdbool.h>
 #include <errno.h>
 #include <math.h>
+#include <linux/string.h>
 #include <linux/zalloc.h>
 
 #include "asm/bug.h"
diff --git a/tools/perf/util/cloexec.c b/tools/perf/util/cloexec.c
index 92d08198e64a..4e904fcb2783 100644
--- a/tools/perf/util/cloexec.c
+++ b/tools/perf/util/cloexec.c
@@ -4,10 +4,12 @@
 #include "util.h"
 #include "../perf-sys.h"
 #include "cloexec.h"
+#include "event.h"
 #include "asm/bug.h"
 #include "debug.h"
 #include <unistd.h>
 #include <sys/syscall.h>
+#include <linux/string.h>
 
 static unsigned long flag = PERF_FLAG_FD_CLOEXEC;
 
diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 74aafe0df506..e75c3a279fe8 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/compiler.h>
 #include <linux/kernel.h>
+#include <linux/string.h>
 #include <linux/zalloc.h>
 #include <sys/types.h>
 #include <sys/stat.h>
diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index c822c5943340..522887ee4c02 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -19,6 +19,7 @@
 #include "print_binary.h"
 #include "util.h"
 #include "target.h"
+#include "ui/helpline.h"
 
 #include <linux/ctype.h>
 
diff --git a/tools/perf/util/debug.h b/tools/perf/util/debug.h
index 77445dfc5c7d..b2deee987ffa 100644
--- a/tools/perf/util/debug.h
+++ b/tools/perf/util/debug.h
@@ -4,11 +4,7 @@
 #define __PERF_DEBUG_H
 
 #include <stdbool.h>
-#include <string.h>
 #include <linux/compiler.h>
-#include "event.h"
-#include "../ui/helpline.h"
-#include "../ui/progress.h"
 #include "../ui/util.h"
 
 extern int verbose;
@@ -42,6 +38,8 @@ extern int debug_data_convert;
 
 #define STRERR_BUFSIZE	128	/* For the buffer size of str_error_r */
 
+union perf_event;
+
 int dump_printf(const char *fmt, ...) __printf(1, 2);
 void trace_event(union perf_event *event);
 
diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 03b2de1f5a35..df6cee5c071f 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -9,6 +9,7 @@
 #include <stdlib.h>
 #include "debug.h"
 #include "dwarf-aux.h"
+#include "strbuf.h"
 #include "string2.h"
 
 /**
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index 0489b0cf8e2c..f204e5892403 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -10,6 +10,8 @@
 #include <elfutils/libdwfl.h>
 #include <elfutils/version.h>
 
+struct strbuf;
+
 /* Find the realpath of the target file */
 const char *cu_find_realpath(Dwarf_Die *cu_die, const char *fname);
 
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 571efb4f0351..3baca06786fb 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -9,6 +9,7 @@
 #include <sys/utsname.h>
 #include <bpf/libbpf.h>
 #include <stdlib.h>
+#include <string.h>
 
 struct perf_env perf_env;
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 71b231c7097f..b5d6d6ec9a9b 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -35,6 +35,7 @@
 #include <linux/hash.h>
 #include <linux/log2.h>
 #include <linux/err.h>
+#include <linux/string.h>
 #include <linux/zalloc.h>
 #include <perf/evlist.h>
 #include <perf/evsel.h>
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 432b8560cf51..f9a20a39b64a 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -2,9 +2,11 @@
 %{
 #include "util.h"
 #include "util/debug.h"
+#include <stdlib.h> // strtod()
 #define IN_EXPR_Y 1
 #include "expr.h"
 #include "smt.h"
+#include <assert.h>
 #include <string.h>
 
 #define MAXIDLEN 256
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index adae4134e972..02ea2ee62814 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -19,6 +19,7 @@
 #include <math.h>
 #include <inttypes.h>
 #include <sys/param.h>
+#include <linux/string.h>
 #include <linux/time64.h>
 #include <linux/zalloc.h>
 
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 825e3690940d..9b56fb74bedf 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -9,6 +9,7 @@
 #include <stdbool.h>
 #include <errno.h>
 #include <linux/kernel.h>
+#include <linux/string.h>
 #include <linux/types.h>
 #include <linux/zalloc.h>
 
diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
index 9f0470ecbca9..55fb4b3b1157 100644
--- a/tools/perf/util/llvm-utils.c
+++ b/tools/perf/util/llvm-utils.c
@@ -9,6 +9,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <linux/err.h>
+#include <linux/string.h>
 #include <linux/zalloc.h>
 #include "debug.h"
 #include "llvm-utils.h"
diff --git a/tools/perf/util/lzma.c b/tools/perf/util/lzma.c
index b1dd29a9d915..397447066033 100644
--- a/tools/perf/util/lzma.c
+++ b/tools/perf/util/lzma.c
@@ -9,6 +9,7 @@
 #include "compress.h"
 #include "util.h"
 #include "debug.h"
+#include <string.h>
 #include <unistd.h>
 
 #define BUFSIZE 8192
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index a1542b4c047b..6e9afe4e55dd 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -30,6 +30,7 @@
 #include <linux/ctype.h>
 #include <symbol/kallsyms.h>
 #include <linux/mman.h>
+#include <linux/string.h>
 #include <linux/zalloc.h>
 
 static void __machine__remove_thread(struct machine *machine, struct thread *th, bool lock);
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 27b7b102e4a2..c75b20b93820 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -20,6 +20,7 @@
 #include "namespaces.h"
 #include "unwind.h"
 #include "srccode.h"
+#include "ui/ui.h"
 
 static void __maps__insert(struct maps *maps, struct map *map);
 static void __maps__insert_name(struct maps *maps, struct map *map);
diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index bb5f34b7ab44..359db2b1fcef 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -8,6 +8,7 @@
 #include "session.h"
 #include "asm/bug.h"
 #include "debug.h"
+#include "ui/progress.h"
 
 #define pr_N(n, fmt, ...) \
 	eprintf(n, debug_ordered_events, fmt, ##__VA_ARGS__)
diff --git a/tools/perf/util/parse-branch-options.c b/tools/perf/util/parse-branch-options.c
index 1430437b9d51..bb4aa88c50a8 100644
--- a/tools/perf/util/parse-branch-options.c
+++ b/tools/perf/util/parse-branch-options.c
@@ -1,8 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "util/debug.h"
+#include "util/event.h"
 #include <subcmd/parse-options.h>
 #include "util/parse-branch-options.h"
 #include <stdlib.h>
+#include <string.h>
 
 #define BRANCH_OPT(n, m) \
 	{ .name = n, .mode = (m) }
diff --git a/tools/perf/util/perf-hooks.c b/tools/perf/util/perf-hooks.c
index 4f3aa8d99ef4..e635c594f773 100644
--- a/tools/perf/util/perf-hooks.c
+++ b/tools/perf/util/perf-hooks.c
@@ -8,6 +8,7 @@
 
 #include <errno.h>
 #include <stdlib.h>
+#include <string.h>
 #include <setjmp.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 025fc4491993..505905fc21c5 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -24,6 +24,7 @@
 #include "dso.h"
 #include "debug.h"
 #include "intlist.h"
+#include "strbuf.h"
 #include "strlist.h"
 #include "symbol.h"
 #include "probe-finder.h"
diff --git a/tools/perf/util/pstack.c b/tools/perf/util/pstack.c
index 28de8a4c2ce8..80ff41fc45be 100644
--- a/tools/perf/util/pstack.c
+++ b/tools/perf/util/pstack.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
 #include <stdlib.h>
+#include <string.h>
 
 struct pstack {
 	unsigned short	top;
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 23d0ab7c801c..035355a9945e 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -22,6 +22,7 @@
 #include "annotate.h"
 #include "time-utils.h"
 #include <linux/kernel.h>
+#include <linux/string.h>
 
 regex_t		parent_regex;
 const char	default_parent_pattern[] = "^sys_|^do_page_fault";
diff --git a/tools/perf/util/strbuf.c b/tools/perf/util/strbuf.c
index 0afdbf38a2b2..a64a37628f12 100644
--- a/tools/perf/util/strbuf.c
+++ b/tools/perf/util/strbuf.c
@@ -1,8 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "cache.h"
 #include "debug.h"
+#include "strbuf.h"
 #include <linux/kernel.h>
+#include <linux/string.h>
 #include <linux/zalloc.h>
 #include <errno.h>
+#include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
 
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 035f2e75728c..c37cca690864 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -7,6 +7,7 @@
 #include <linux/capability.h>
 #include <linux/kernel.h>
 #include <linux/mman.h>
+#include <linux/string.h>
 #include <linux/time64.h>
 #include <sys/types.h>
 #include <sys/stat.h>
diff --git a/tools/perf/util/target.c b/tools/perf/util/target.c
index 3adc65480349..565f7aef7e6c 100644
--- a/tools/perf/util/target.c
+++ b/tools/perf/util/target.c
@@ -10,8 +10,11 @@
 #include "debug.h"
 
 #include <pwd.h>
+#include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
 
 enum target_errno target__validate(struct target *target)
 {
diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index 15134ac9b8f1..cd8a948d03ec 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -10,6 +10,7 @@
 #include <linux/zalloc.h>
 #include <errno.h>
 #include <stdlib.h>
+#include <string.h>
 #include "thread.h"
 #include "event.h"
 #include "machine.h"
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 607daec22943..32322a20a68b 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "util.h"
 #include "debug.h"
+#include "event.h"
 #include "namespaces.h"
 #include <api/fs/fs.h>
 #include <sys/mman.h>
diff --git a/tools/perf/util/values.c b/tools/perf/util/values.c
index c59154e2d124..b9823f414f10 100644
--- a/tools/perf/util/values.c
+++ b/tools/perf/util/values.c
@@ -2,6 +2,7 @@
 #include <inttypes.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <errno.h>
 #include <linux/zalloc.h>
 
diff --git a/tools/perf/util/zlib.c b/tools/perf/util/zlib.c
index 512ad7c09b13..59d456f716e9 100644
--- a/tools/perf/util/zlib.c
+++ b/tools/perf/util/zlib.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <fcntl.h>
 #include <stdio.h>
+#include <string.h>
 #include <unistd.h>
 #include <sys/stat.h>
 #include <sys/mman.h>
-- 
2.21.0

