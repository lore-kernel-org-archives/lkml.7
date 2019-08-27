Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0669C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A26205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730334AbfH0I2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:28:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42676 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbfH0I0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:26:19 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2Wnq-0007ln-B0; Tue, 27 Aug 2019 10:26:10 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DE58D1C07DC;
        Tue, 27 Aug 2019 10:26:09 +0200 (CEST)
Date:   Tue, 27 Aug 2019 08:26:09 -0000
From:   tip-bot2 for Arnaldo Carvalho de Melo <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf record: Move record_opts and other record decls
 out of perf.h
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-31q8mei1qkh74qvkl9nwidfq@git.kernel.org>
References: <tip-31q8mei1qkh74qvkl9nwidfq@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156689436973.24476.4094047241371600064.tip-bot2@tip-bot2>
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

Commit-ID:     aeb00b1aeab6dadd72c24f93bea51a46e109c2ba
Gitweb:        https://git.kernel.org/tip/aeb00b1aeab6dadd72c24f93bea51a46e109c2ba
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Thu, 22 Aug 2019 15:40:29 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 26 Aug 2019 11:58:22 -03:00

perf record: Move record_opts and other record decls out of perf.h

And into a separate util/record.h, to better isolate things and make
sure that those who use record_opts and the other moved declarations
are explicitly including the necessary header.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-31q8mei1qkh74qvkl9nwidfq@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/cs-etm.c            |  2 +-
 tools/perf/arch/arm64/util/arm-spe.c         |  1 +-
 tools/perf/arch/s390/util/auxtrace.c         |  1 +-
 tools/perf/arch/x86/tests/perf-time-to-tsc.c |  2 +-
 tools/perf/arch/x86/util/intel-bts.c         |  1 +-
 tools/perf/arch/x86/util/intel-pt.c          |  3 +-
 tools/perf/builtin-record.c                  |  4 +-
 tools/perf/builtin-script.c                  |  2 +-
 tools/perf/builtin-stat.c                    |  2 +-
 tools/perf/builtin-trace.c                   |  1 +-
 tools/perf/perf.h                            | 62 +----------------
 tools/perf/tests/backward-ring-buffer.c      |  2 +-
 tools/perf/tests/bpf.c                       |  1 +-
 tools/perf/tests/code-reading.c              |  1 +-
 tools/perf/tests/keep-tracking.c             |  1 +-
 tools/perf/tests/openat-syscall-tp-fields.c  |  3 +-
 tools/perf/tests/perf-record.c               |  2 +-
 tools/perf/tests/switch-tracking.c           |  1 +-
 tools/perf/tests/task-exit.c                 |  1 +-
 tools/perf/util/auxtrace.c                   |  2 +-
 tools/perf/util/bpf-event.c                  |  1 +-
 tools/perf/util/evsel.c                      |  1 +-
 tools/perf/util/kvm-stat.h                   |  2 +-
 tools/perf/util/machine.c                    |  1 +-
 tools/perf/util/machine.h                    |  1 +-
 tools/perf/util/record.c                     |  1 +-
 tools/perf/util/record.h                     | 74 +++++++++++++++++++-
 tools/perf/util/stat.c                       |  1 +-
 tools/perf/util/stat.h                       |  2 +-
 tools/perf/util/top.h                        |  1 +-
 30 files changed, 107 insertions(+), 73 deletions(-)
 create mode 100644 tools/perf/util/record.h

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index c73da32..a185dab 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -15,7 +15,7 @@
 #include <linux/zalloc.h>
 
 #include "cs-etm.h"
-#include "../../perf.h"
+#include "../../util/record.h"
 #include "../../util/auxtrace.h"
 #include "../../util/cpumap.h"
 #include "../../util/evlist.h"
diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 00915b8..cdd5c0c 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -19,6 +19,7 @@
 #include "../../util/pmu.h"
 #include "../../util/debug.h"
 #include "../../util/auxtrace.h"
+#include "../../util/record.h"
 #include "../../util/arm-spe.h"
 
 #define KiB(x) ((x) * 1024)
diff --git a/tools/perf/arch/s390/util/auxtrace.c b/tools/perf/arch/s390/util/auxtrace.c
index cab46f5..f32d7a7 100644
--- a/tools/perf/arch/s390/util/auxtrace.c
+++ b/tools/perf/arch/s390/util/auxtrace.c
@@ -8,6 +8,7 @@
 #include "../../util/evlist.h"
 #include "../../util/auxtrace.h"
 #include "../../util/evsel.h"
+#include "../../util/record.h"
 
 #define PERF_EVENT_CPUM_SF		0xB0000 /* Event: Basic-sampling */
 #define PERF_EVENT_CPUM_SF_DIAG		0xBD000 /* Event: Combined-sampling */
diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
index 582182d..0277610 100644
--- a/tools/perf/arch/x86/tests/perf-time-to-tsc.c
+++ b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
 #include <inttypes.h>
+#include <stdbool.h>
 #include <stdio.h>
 #include <unistd.h>
 #include <linux/types.h>
@@ -13,6 +14,7 @@
 #include "evsel.h"
 #include "thread_map.h"
 #include "cpumap.h"
+#include "record.h"
 #include "tsc.h"
 #include "tests/tests.h"
 
diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index 2d5d8a1..1f2cf61 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -17,6 +17,7 @@
 #include "../../util/session.h"
 #include "../../util/pmu.h"
 #include "../../util/debug.h"
+#include "../../util/record.h"
 #include "../../util/tsc.h"
 #include "../../util/auxtrace.h"
 #include "../../util/intel-bts.h"
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index c72a77a..44cfe72 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -13,7 +13,6 @@
 #include <linux/zalloc.h>
 #include <cpuid.h>
 
-#include "../../perf.h"
 #include "../../util/session.h"
 #include "../../util/event.h"
 #include "../../util/evlist.h"
@@ -24,6 +23,8 @@
 #include "../../util/pmu.h"
 #include "../../util/debug.h"
 #include "../../util/auxtrace.h"
+#include "../../util/record.h"
+#include "../../util/target.h"
 #include "../../util/tsc.h"
 #include "../../util/intel-pt.h"
 
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index f71631f..359bb8f 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -8,8 +8,6 @@
  */
 #include "builtin.h"
 
-#include "perf.h"
-
 #include "util/build-id.h"
 #include <subcmd/parse-options.h>
 #include "util/parse-events.h"
@@ -22,9 +20,11 @@
 #include "util/evlist.h"
 #include "util/evsel.h"
 #include "util/debug.h"
+#include "util/target.h"
 #include "util/session.h"
 #include "util/tool.h"
 #include "util/symbol.h"
+#include "util/record.h"
 #include "util/cpumap.h"
 #include "util/thread_map.h"
 #include "util/data.h"
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 9b93dde..ee05621 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "builtin.h"
 
-#include "perf.h"
 #include "util/cache.h"
 #include "util/counts.h"
 #include "util/debug.h"
@@ -51,6 +50,7 @@
 #include <unistd.h>
 #include <subcmd/pager.h>
 #include <perf/evlist.h>
+#include "util/record.h"
 
 #include <linux/ctype.h>
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 8a4f1a7..6ab13f4 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -40,7 +40,6 @@
  *   Jaswinder Singh Rajput <jaswinder@kernel.org>
  */
 
-#include "perf.h"
 #include "builtin.h"
 #include "util/cgroup.h"
 #include <subcmd/parse-options.h>
@@ -62,6 +61,7 @@
 #include "util/tool.h"
 #include "util/string2.h"
 #include "util/metricgroup.h"
+#include "util/target.h"
 #include "util/top.h"
 #include "asm/bug.h"
 
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index de12625..8ea62fd 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -14,6 +14,7 @@
  * http://lwn.net/Articles/415728/ ("Announcing a new utility: 'trace'")
  */
 
+#include "util/record.h"
 #include <traceevent/event-parse.h>
 #include <api/fs/tracing_path.h>
 #include <bpf/bpf.h>
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index dc0a7a2..d9e6b8b 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -35,63 +35,6 @@ extern const char perf_version_string[];
 
 void pthread__unblock_sigwinch(void);
 
-#include "util/target.h"
-
-struct record_opts {
-	struct target target;
-	bool	     group;
-	bool	     inherit_stat;
-	bool	     no_buffering;
-	bool	     no_inherit;
-	bool	     no_inherit_set;
-	bool	     no_samples;
-	bool	     raw_samples;
-	bool	     sample_address;
-	bool	     sample_phys_addr;
-	bool	     sample_weight;
-	bool	     sample_time;
-	bool	     sample_time_set;
-	bool	     sample_cpu;
-	bool	     period;
-	bool	     period_set;
-	bool	     running_time;
-	bool	     full_auxtrace;
-	bool	     auxtrace_snapshot_mode;
-	bool	     auxtrace_snapshot_on_exit;
-	bool	     record_namespaces;
-	bool	     record_switch_events;
-	bool	     all_kernel;
-	bool	     all_user;
-	bool	     kernel_callchains;
-	bool	     user_callchains;
-	bool	     tail_synthesize;
-	bool	     overwrite;
-	bool	     ignore_missing_thread;
-	bool	     strict_freq;
-	bool	     sample_id;
-	bool	     no_bpf_event;
-	unsigned int freq;
-	unsigned int mmap_pages;
-	unsigned int auxtrace_mmap_pages;
-	unsigned int user_freq;
-	u64          branch_stack;
-	u64	     sample_intr_regs;
-	u64	     sample_user_regs;
-	u64	     default_interval;
-	u64	     user_interval;
-	size_t	     auxtrace_snapshot_size;
-	const char   *auxtrace_snapshot_opts;
-	bool	     sample_transaction;
-	unsigned     initial_delay;
-	bool         use_clockid;
-	clockid_t    clockid;
-	u64          clockid_res_ns;
-	int	     nr_cblocks;
-	int	     affinity;
-	int	     mmap_flush;
-	unsigned int comp_level;
-};
-
 enum perf_affinity {
 	PERF_AFFINITY_SYS = 0,
 	PERF_AFFINITY_NODE,
@@ -99,10 +42,5 @@ enum perf_affinity {
 	PERF_AFFINITY_MAX
 };
 
-struct option;
-extern const char * const *record_usage;
-extern struct option *record_options;
 extern int version_verbose;
-
-int record__parse_freq(const struct option *opt, const char *str, int unset);
 #endif
diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
index 9bdf661..b6f27ef 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -4,9 +4,9 @@
  * beginning
  */
 
-#include <perf.h>
 #include <evlist.h>
 #include <sys/prctl.h>
+#include "record.h"
 #include "tests.h"
 #include "debug.h"
 #include <errno.h>
diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index e16f927..9864296 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -5,6 +5,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
+#include <util/record.h>
 #include <util/util.h>
 #include <util/bpf-loader.h>
 #include <util/evlist.h>
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index e45df07..fe671b8 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -20,6 +20,7 @@
 #include "map.h"
 #include "symbol.h"
 #include "event.h"
+#include "record.h"
 #include "thread.h"
 
 #include "tests.h"
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index 0ce5ce3..2af6faf 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -8,6 +8,7 @@
 #include "parse-events.h"
 #include "evlist.h"
 #include "evsel.h"
+#include "record.h"
 #include "thread_map.h"
 #include "cpumap.h"
 #include "tests.h"
diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index 9c06130..6249210 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -1,12 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <stdbool.h>
 #include <linux/err.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
-#include "perf.h"
 #include "evlist.h"
 #include "evsel.h"
 #include "thread_map.h"
+#include "record.h"
 #include "tests.h"
 #include "debug.h"
 #include <errno.h>
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index 67b388e..3a205f6 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -7,8 +7,8 @@
 #include <sched.h>
 #include "evlist.h"
 #include "evsel.h"
-#include "perf.h"
 #include "debug.h"
+#include "record.h"
 #include "tests.h"
 
 static int sched__get_first_possible_cpu(pid_t pid, cpu_set_t *maskp)
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index e3cee69..b63f027 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -13,6 +13,7 @@
 #include "evsel.h"
 #include "thread_map.h"
 #include "cpumap.h"
+#include "record.h"
 #include "tests.h"
 
 static int spin_sleep(void)
diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index 4ca38fd..d79a22e 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "evlist.h"
 #include "evsel.h"
+#include "target.h"
 #include "thread_map.h"
 #include "cpumap.h"
 #include "tests.h"
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 094e6ce..12e9b7a 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -26,7 +26,6 @@
 #include <linux/list.h>
 #include <linux/zalloc.h>
 
-#include "../perf.h"
 #include "evlist.h"
 #include "dso.h"
 #include "map.h"
@@ -41,6 +40,7 @@
 #include <linux/hash.h>
 
 #include "event.h"
+#include "record.h"
 #include "session.h"
 #include "debug.h"
 #include <subcmd/parse-options.h>
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 5a5dcc6..5c634bc 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -14,6 +14,7 @@
 #include "session.h"
 #include "map.h"
 #include "evlist.h"
+#include "record.h"
 
 #define ptr_to_u64(ptr)    ((__u64)(unsigned long)(ptr))
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index e983e72..9fadd58 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -34,6 +34,7 @@
 #include "thread_map.h"
 #include "target.h"
 #include "perf_regs.h"
+#include "record.h"
 #include "debug.h"
 #include "trace-event.h"
 #include "stat.h"
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index a09c495..4691363 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -2,9 +2,9 @@
 #ifndef __PERF_KVM_STAT_H
 #define __PERF_KVM_STAT_H
 
-#include "../perf.h"
 #include "tool.h"
 #include "stat.h"
+#include "record.h"
 
 struct evsel;
 struct evlist;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 5734460..f7c1a7e 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -13,6 +13,7 @@
 #include "symbol.h"
 #include "sort.h"
 #include "strlist.h"
+#include "target.h"
 #include "thread.h"
 #include "vdso.h"
 #include <stdbool.h>
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 8b9d715..7d69119 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -14,6 +14,7 @@ struct branch_stack;
 struct evsel;
 struct perf_sample;
 struct symbol;
+struct target;
 struct thread;
 union perf_event;
 
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index 51bbd07..574507d 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -9,6 +9,7 @@
 #include <perf/cpumap.h>
 #include "util.h"
 #include "cloexec.h"
+#include "record.h"
 
 typedef void (*setup_probe_fn_t)(struct evsel *evsel);
 
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
new file mode 100644
index 0000000..00275af
--- /dev/null
+++ b/tools/perf/util/record.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _PERF_RECORD_H
+#define _PERF_RECORD_H
+
+#include <time.h>
+#include <stdbool.h>
+#include <linux/types.h>
+#include <linux/stddef.h>
+#include <linux/perf_event.h>
+#include "util/target.h"
+
+struct option;
+
+struct record_opts {
+	struct target target;
+	bool	      group;
+	bool	      inherit_stat;
+	bool	      no_buffering;
+	bool	      no_inherit;
+	bool	      no_inherit_set;
+	bool	      no_samples;
+	bool	      raw_samples;
+	bool	      sample_address;
+	bool	      sample_phys_addr;
+	bool	      sample_weight;
+	bool	      sample_time;
+	bool	      sample_time_set;
+	bool	      sample_cpu;
+	bool	      period;
+	bool	      period_set;
+	bool	      running_time;
+	bool	      full_auxtrace;
+	bool	      auxtrace_snapshot_mode;
+	bool	      auxtrace_snapshot_on_exit;
+	bool	      record_namespaces;
+	bool	      record_switch_events;
+	bool	      all_kernel;
+	bool	      all_user;
+	bool	      kernel_callchains;
+	bool	      user_callchains;
+	bool	      tail_synthesize;
+	bool	      overwrite;
+	bool	      ignore_missing_thread;
+	bool	      strict_freq;
+	bool	      sample_id;
+	bool	      no_bpf_event;
+	unsigned int  freq;
+	unsigned int  mmap_pages;
+	unsigned int  auxtrace_mmap_pages;
+	unsigned int  user_freq;
+	u64	      branch_stack;
+	u64	      sample_intr_regs;
+	u64	      sample_user_regs;
+	u64	      default_interval;
+	u64	      user_interval;
+	size_t	      auxtrace_snapshot_size;
+	const char    *auxtrace_snapshot_opts;
+	bool	      sample_transaction;
+	unsigned      initial_delay;
+	bool	      use_clockid;
+	clockid_t     clockid;
+	u64	      clockid_res_ns;
+	int	      nr_cblocks;
+	int	      affinity;
+	int	      mmap_flush;
+	unsigned int  comp_level;
+};
+
+extern const char * const *record_usage;
+extern struct option *record_options;
+
+int record__parse_freq(const struct option *opt, const char *str, int unset);
+
+#endif // _PERF_RECORD_H
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 0cbfd1e..f985336 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -4,6 +4,7 @@
 #include <math.h>
 #include "counts.h"
 #include "stat.h"
+#include "target.h"
 #include "evlist.h"
 #include "evsel.h"
 #include "thread_map.h"
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 9e425ec..14fe3e5 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -198,6 +198,8 @@ int perf_stat_process_counter(struct perf_stat_config *config,
 struct perf_tool;
 union perf_event;
 struct perf_session;
+struct target;
+
 int perf_event__process_stat_event(struct perf_session *session,
 				   union perf_event *event);
 
diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
index dc4bb6e..7367433 100644
--- a/tools/perf/util/top.h
+++ b/tools/perf/util/top.h
@@ -5,6 +5,7 @@
 #include "tool.h"
 #include "evswitch.h"
 #include "annotate.h"
+#include "record.h"
 #include <linux/types.h>
 #include <stddef.h>
 #include <stdbool.h>
