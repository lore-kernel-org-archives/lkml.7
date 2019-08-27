Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95164C3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EAB021872
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566869816;
	bh=n2E1XJj1cXOpH1b1WNt92e16u5Wwi+9JZ0noMe+lh1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OyqEj3Gl1RFt9QpcGR96KvIRlf0MhJfIiOgv1A9kjZT2fXwELN19rOipp6fwDyI6Y
	 CwB8u+wBTkKdNOuOGzusRXWhoO4lN6B6Iyul6MLw+lmGZWI5C+docsJstvKlwyDGah
	 rxBgH+6l2wmR91B4mvawfpIq5h54Xdjm6G/q4aqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbfH0Bgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 21:36:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:49988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728456AbfH0Bgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 21:36:53 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A682217F5;
        Tue, 27 Aug 2019 01:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566869811;
        bh=n2E1XJj1cXOpH1b1WNt92e16u5Wwi+9JZ0noMe+lh1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xX19haH5oWys3ITEm2k1n12bZKHsKXxnpW/NJ83J5278Kmtp7/LzPdOhiA5v7EvKE
         udix48Lefu7pmV5YbTf0aelKs+aLOz/GU0ctumH8BE2vaIi7syPtvZ5LtZltm1+bH2
         A18nqwDDs8hRvCzkLoBWFqPr7Il+EzHvBsR08zgo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 03/33] perf record: Move record_opts and other record decls out of perf.h
Date:   Mon, 26 Aug 2019 22:36:04 -0300
Message-Id: <20190827013634.3173-4-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190827013634.3173-1-acme@kernel.org>
References: <20190827013634.3173-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
 tools/perf/arch/arm64/util/arm-spe.c         |  1 +
 tools/perf/arch/s390/util/auxtrace.c         |  1 +
 tools/perf/arch/x86/tests/perf-time-to-tsc.c |  2 +
 tools/perf/arch/x86/util/intel-bts.c         |  1 +
 tools/perf/arch/x86/util/intel-pt.c          |  3 +-
 tools/perf/builtin-record.c                  |  4 +-
 tools/perf/builtin-script.c                  |  2 +-
 tools/perf/builtin-stat.c                    |  2 +-
 tools/perf/builtin-trace.c                   |  1 +
 tools/perf/perf.h                            | 62 ----------------
 tools/perf/tests/backward-ring-buffer.c      |  2 +-
 tools/perf/tests/bpf.c                       |  1 +
 tools/perf/tests/code-reading.c              |  1 +
 tools/perf/tests/keep-tracking.c             |  1 +
 tools/perf/tests/openat-syscall-tp-fields.c  |  3 +-
 tools/perf/tests/perf-record.c               |  2 +-
 tools/perf/tests/switch-tracking.c           |  1 +
 tools/perf/tests/task-exit.c                 |  1 +
 tools/perf/util/auxtrace.c                   |  2 +-
 tools/perf/util/bpf-event.c                  |  1 +
 tools/perf/util/evsel.c                      |  1 +
 tools/perf/util/kvm-stat.h                   |  2 +-
 tools/perf/util/machine.c                    |  1 +
 tools/perf/util/machine.h                    |  1 +
 tools/perf/util/record.c                     |  1 +
 tools/perf/util/record.h                     | 74 ++++++++++++++++++++
 tools/perf/util/stat.c                       |  1 +
 tools/perf/util/stat.h                       |  2 +
 tools/perf/util/top.h                        |  1 +
 30 files changed, 107 insertions(+), 73 deletions(-)
 create mode 100644 tools/perf/util/record.h

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index c73da3245b67..a185dab2d903 100644
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
index 00915b8fd05b..cdd5c0c84183 100644
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
index cab46f517b83..f32d7a72d039 100644
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
index 582182d98a7f..02776109ba46 100644
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
index 2d5d8a12dd1f..1f2cf612bc9c 100644
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
index c72a77a82b39..44cfe72c1a4c 100644
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
index f71631f2bcb5..359bb8f33e57 100644
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
index 9b93ddeaeafa..ee05621d3bd6 100644
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
index 8a4f1a7d0cba..6ab13f466827 100644
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
index de126258ca10..8ea62fd2591d 100644
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
index dc0a7a237887..d9e6b8b957b6 100644
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
index 9bdf66139099..b6f27ef9fb02 100644
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
index e16f927f38b6..98642961fc63 100644
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
index e45df0736261..fe671b860086 100644
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
index 0ce5ce33bac4..2af6faf1bbd6 100644
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
index 9c06130d37be..62492106fb5e 100644
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
index 67b388e92cba..3a205f6f9363 100644
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
index e3cee69f6ea2..b63f02768724 100644
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
index 4ca38fd0379a..d79a22e2d8be 100644
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
index 094e6ceb3cf2..12e9b7acbb2c 100644
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
index 5a5dcc6d8f85..5c634bcfea7e 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -14,6 +14,7 @@
 #include "session.h"
 #include "map.h"
 #include "evlist.h"
+#include "record.h"
 
 #define ptr_to_u64(ptr)    ((__u64)(unsigned long)(ptr))
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index e983e721beca..9fadd5857ccc 100644
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
index a09c495f866b..46913637085b 100644
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
index 5734460fc89e..f7c1a7e6c4ba 100644
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
index 8b9d7157276d..7d69119d0b5d 100644
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
index 51bbd0714e6d..574507d46c98 100644
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
index 000000000000..00275afc524d
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
index 0cbfd1eca1dd..f985336b3a22 100644
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
index 9e425ecd82d9..14fe3e548229 100644
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
index dc4bb6e52a83..7367433e767a 100644
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
-- 
2.21.0

