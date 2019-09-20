Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6F7C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 162D2207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568989675;
	bh=p3gQtvFeBuqjaHXEyfZFMOh2HXCQaqIFtUouNZm0N4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iPG0CxH/jK1+VSxiIsOYeNcS2HBBrGh+x8Q9H0e5rCE70XKuKjeef3ESMondQN0jL
	 hkTXbvzCxtEuf4h0/ohpZ6pc+L6Y2Lu1NdOAEi0l8ryycFWJb+8GJvzi5kG/ZbcKle
	 jcA0+jhuZOF7ymJJed9P+xOrjlohxkmualRRV1AY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389794AbfITO1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:27:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387845AbfITO0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:26:53 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1502217F5;
        Fri, 20 Sep 2019 14:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568989611;
        bh=p3gQtvFeBuqjaHXEyfZFMOh2HXCQaqIFtUouNZm0N4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U9u9juiya9OByFJs9kMd+g57gt4dBCWg6Huq0c/qsB/c/HzVjK8oLV6x2rwcYMq9K
         Co6oEjV3vcvMgAqnb2sXzBMkienN4IHc100NH6412fuE0yHDXpy9Vvg1ENFVtjada6
         C9iY/EB2Gt6PEi/wYDQyl+4/lrBraw/v3lWpGBMU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 22/31] perf tools: Move event synthesizing routines to separate header
Date:   Fri, 20 Sep 2019 11:25:33 -0300
Message-Id: <20190920142542.12047-23-acme@kernel.org>
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

Those are the only routines using the perf_event__handler_t typedef and
are all related, so move to a separate header to reduce the header
dependency tree, lots of places were getting event.h and even stdio.h,
limits.h indirectly, so fix those as well.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-yvx9u1mf7baq6cu1abfhbqgs@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/util/archinsn.c   |   1 +
 tools/perf/arch/x86/util/event.c      |   2 +
 tools/perf/arch/x86/util/machine.c    |   1 +
 tools/perf/arch/x86/util/tsc.c        |   2 +
 tools/perf/builtin-inject.c           |   1 +
 tools/perf/builtin-kvm.c              |   1 +
 tools/perf/builtin-record.c           |   1 +
 tools/perf/builtin-stat.c             |   1 +
 tools/perf/builtin-top.c              |   1 +
 tools/perf/builtin-trace.c            |   1 +
 tools/perf/tests/code-reading.c       |   1 +
 tools/perf/tests/cpumap.c             |   1 +
 tools/perf/tests/dwarf-unwind.c       |   1 +
 tools/perf/tests/event_update.c       |   1 +
 tools/perf/tests/hists_common.c       |   2 +
 tools/perf/tests/mmap-thread-lookup.c |   2 +
 tools/perf/tests/sample-parsing.c     |   1 +
 tools/perf/tests/stat.c               |   1 +
 tools/perf/tests/thread-map.c         |   1 +
 tools/perf/ui/stdio/hist.c            |   1 +
 tools/perf/util/auxtrace.c            |   1 +
 tools/perf/util/auxtrace.h            |  17 +---
 tools/perf/util/bpf-event.c           |   1 +
 tools/perf/util/bpf-event.h           |  15 +---
 tools/perf/util/callchain.c           |   1 +
 tools/perf/util/event.c               |   1 +
 tools/perf/util/event.h               | 118 +-------------------------
 tools/perf/util/evsel.c               |   1 +
 tools/perf/util/header.c              |   1 +
 tools/perf/util/intel-bts.c           |   1 +
 tools/perf/util/intel-pt.c            |   1 +
 tools/perf/util/machine.c             |  10 +++
 tools/perf/util/machine.h             |  15 ----
 tools/perf/util/session.c             |   1 +
 tools/perf/util/session.h             |   5 --
 tools/perf/util/stat.c                |   1 +
 tools/perf/util/synthetic-events.h    | 103 ++++++++++++++++++++++
 tools/perf/util/tsc.h                 |  14 +--
 38 files changed, 154 insertions(+), 177 deletions(-)
 create mode 100644 tools/perf/util/synthetic-events.h

diff --git a/tools/perf/arch/x86/util/archinsn.c b/tools/perf/arch/x86/util/archinsn.c
index 9876c7a7ed7c..3e6791531ca5 100644
--- a/tools/perf/arch/x86/util/archinsn.c
+++ b/tools/perf/arch/x86/util/archinsn.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "../../../../arch/x86/include/asm/insn.h"
 #include "archinsn.h"
+#include "event.h"
 #include "machine.h"
 #include "thread.h"
 #include "symbol.h"
diff --git a/tools/perf/arch/x86/util/event.c b/tools/perf/arch/x86/util/event.c
index a3a0b6884779..d357c625c09f 100644
--- a/tools/perf/arch/x86/util/event.c
+++ b/tools/perf/arch/x86/util/event.c
@@ -3,6 +3,8 @@
 #include <linux/string.h>
 #include <linux/zalloc.h>
 
+#include "../../util/event.h"
+#include "../../util/synthetic-events.h"
 #include "../../util/machine.h"
 #include "../../util/tool.h"
 #include "../../util/map.h"
diff --git a/tools/perf/arch/x86/util/machine.c b/tools/perf/arch/x86/util/machine.c
index 42418040bc07..f0c289862f9f 100644
--- a/tools/perf/arch/x86/util/machine.c
+++ b/tools/perf/arch/x86/util/machine.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/types.h>
 #include <linux/string.h>
+#include <limits.h>
 #include <stdlib.h>
 
 #include "../../util/util.h" // page_size
diff --git a/tools/perf/arch/x86/util/tsc.c b/tools/perf/arch/x86/util/tsc.c
index c5197a15119b..2f55afb14e1f 100644
--- a/tools/perf/arch/x86/util/tsc.c
+++ b/tools/perf/arch/x86/util/tsc.c
@@ -8,6 +8,8 @@
 #include <linux/types.h>
 #include <asm/barrier.h>
 #include "../../../util/debug.h"
+#include "../../../util/event.h"
+#include "../../../util/synthetic-events.h"
 #include "../../../util/tsc.h"
 
 int perf_read_tsc_conversion(const struct perf_event_mmap_page *pc,
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index c14f40b858bc..23a76cf3846f 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -21,6 +21,7 @@
 #include "util/auxtrace.h"
 #include "util/jit.h"
 #include "util/symbol.h"
+#include "util/synthetic-events.h"
 #include "util/thread.h"
 
 #include <subcmd/parse-options.h>
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 0a4fcbe32bf6..ac6d6e061dc5 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -17,6 +17,7 @@
 #include "util/debug.h"
 #include "util/tool.h"
 #include "util/stat.h"
+#include "util/synthetic-events.h"
 #include "util/top.h"
 #include "util/data.h"
 #include "util/ordered-events.h"
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 1447004eee8a..907d4d4677a3 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -38,6 +38,7 @@
 #include "util/trigger.h"
 #include "util/perf-hooks.h"
 #include "util/cpu-set-sched.h"
+#include "util/synthetic-events.h"
 #include "util/time-utils.h"
 #include "util/units.h"
 #include "util/bpf-event.h"
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index b55e8060810b..eece3d1e429a 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -61,6 +61,7 @@
 #include "util/tool.h"
 #include "util/string2.h"
 #include "util/metricgroup.h"
+#include "util/synthetic-events.h"
 #include "util/target.h"
 #include "util/time-utils.h"
 #include "util/top.h"
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 726e3f2dd8c7..b052470f89b4 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -32,6 +32,7 @@
 #include "util/map.h"
 #include "util/session.h"
 #include "util/symbol.h"
+#include "util/synthetic-events.h"
 #include "util/top.h"
 #include "util/util.h"
 #include <linux/rbtree.h>
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 0f633f0d6be8..f0f735093e21 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -28,6 +28,7 @@
 #include "util/dso.h"
 #include "util/env.h"
 #include "util/event.h"
+#include "util/synthetic-events.h"
 #include "util/evlist.h"
 #include "util/evswitch.h"
 #include <subcmd/pager.h>
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 8d9020c46ca9..fd02c1f1d976 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -24,6 +24,7 @@
 #include "symbol.h"
 #include "event.h"
 #include "record.h"
+#include "util/synthetic-events.h"
 #include "thread.h"
 
 #include "tests.h"
diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
index 39493de50117..8a0d236202b0 100644
--- a/tools/perf/tests/cpumap.c
+++ b/tools/perf/tests/cpumap.c
@@ -3,6 +3,7 @@
 #include <stdio.h>
 #include "cpumap.h"
 #include "event.h"
+#include "util/synthetic-events.h"
 #include <string.h>
 #include <linux/bitops.h>
 #include <perf/cpumap.h>
diff --git a/tools/perf/tests/dwarf-unwind.c b/tools/perf/tests/dwarf-unwind.c
index 4125255ff637..4f4ecbcbe87e 100644
--- a/tools/perf/tests/dwarf-unwind.c
+++ b/tools/perf/tests/dwarf-unwind.c
@@ -15,6 +15,7 @@
 #include "symbol.h"
 #include "thread.h"
 #include "callchain.h"
+#include "util/synthetic-events.h"
 
 #if defined (__x86_64__) || defined (__i386__) || defined (__powerpc__)
 #include "arch-tests.h"
diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
index 317eb8c5ccd4..4bb772e2b73d 100644
--- a/tools/perf/tests/event_update.c
+++ b/tools/perf/tests/event_update.c
@@ -7,6 +7,7 @@
 #include "evsel.h"
 #include "header.h"
 #include "machine.h"
+#include "util/synthetic-events.h"
 #include "tool.h"
 #include "tests.h"
 #include "debug.h"
diff --git a/tools/perf/tests/hists_common.c b/tools/perf/tests/hists_common.c
index de110d8f169b..6f34d08b84e5 100644
--- a/tools/perf/tests/hists_common.c
+++ b/tools/perf/tests/hists_common.c
@@ -2,6 +2,7 @@
 #include <inttypes.h>
 #include "util/debug.h"
 #include "util/dso.h"
+#include "util/event.h" // struct perf_sample
 #include "util/map.h"
 #include "util/symbol.h"
 #include "util/sort.h"
@@ -10,6 +11,7 @@
 #include "util/thread.h"
 #include "tests/hists_common.h"
 #include <linux/kernel.h>
+#include <linux/perf_event.h>
 
 static struct {
 	u32 pid;
diff --git a/tools/perf/tests/mmap-thread-lookup.c b/tools/perf/tests/mmap-thread-lookup.c
index f72889c13538..33b496d194f4 100644
--- a/tools/perf/tests/mmap-thread-lookup.c
+++ b/tools/perf/tests/mmap-thread-lookup.c
@@ -8,11 +8,13 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include "debug.h"
+#include "event.h"
 #include "tests.h"
 #include "machine.h"
 #include "thread_map.h"
 #include "map.h"
 #include "symbol.h"
+#include "util/synthetic-events.h"
 #include "thread.h"
 #include "util.h" // page_size
 
diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index e3b965e7a233..3a02426db9a6 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -12,6 +12,7 @@
 #include "event.h"
 #include "evsel.h"
 #include "debug.h"
+#include "util/synthetic-events.h"
 
 #include "tests.h"
 
diff --git a/tools/perf/tests/stat.c b/tools/perf/tests/stat.c
index cc10b4116c9f..c1911501c39c 100644
--- a/tools/perf/tests/stat.c
+++ b/tools/perf/tests/stat.c
@@ -5,6 +5,7 @@
 #include "stat.h"
 #include "counts.h"
 #include "debug.h"
+#include "util/synthetic-events.h"
 
 static bool has_term(struct perf_record_stat_config *config,
 		     u64 tag, u64 val)
diff --git a/tools/perf/tests/thread-map.c b/tools/perf/tests/thread-map.c
index 39168c57943b..28f51c4bd373 100644
--- a/tools/perf/tests/thread-map.c
+++ b/tools/perf/tests/thread-map.c
@@ -8,6 +8,7 @@
 #include "thread_map.h"
 #include "debug.h"
 #include "event.h"
+#include "util/synthetic-events.h"
 #include <linux/zalloc.h>
 #include <perf/event.h>
 
diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index 832ca6cfbe30..5365606e9dad 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -5,6 +5,7 @@
 
 #include "../../util/callchain.h"
 #include "../../util/debug.h"
+#include "../../util/event.h"
 #include "../../util/hist.h"
 #include "../../util/map.h"
 #include "../../util/map_groups.h"
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 1c0ff5acff83..0e8c89cf7cad 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -32,6 +32,7 @@
 #include "pmu.h"
 #include "evsel.h"
 #include "symbol.h"
+#include "util/synthetic-events.h"
 #include "thread_map.h"
 #include "asm/bug.h"
 #include "auxtrace.h"
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 1ed902a24a39..b110aec1da4d 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -11,14 +11,13 @@
 #include <errno.h>
 #include <stdbool.h>
 #include <stddef.h>
+#include <stdio.h> // FILE
 #include <linux/list.h>
 #include <linux/perf_event.h>
 #include <linux/types.h>
 #include <asm/bitsperlong.h>
 #include <asm/barrier.h>
 
-#include "event.h"
-
 union perf_event;
 struct perf_session;
 struct evlist;
@@ -27,6 +26,7 @@ struct perf_mmap;
 struct perf_sample;
 struct option;
 struct record_opts;
+struct perf_record_auxtrace_error;
 struct perf_record_auxtrace_info;
 struct events_stats;
 
@@ -525,10 +525,6 @@ void auxtrace_synth_error(struct perf_record_auxtrace_error *auxtrace_error, int
 			  int code, int cpu, pid_t pid, pid_t tid, u64 ip,
 			  const char *msg, u64 timestamp);
 
-int perf_event__synthesize_auxtrace_info(struct auxtrace_record *itr,
-					 struct perf_tool *tool,
-					 struct perf_session *session,
-					 perf_event__handler_t process);
 int perf_event__process_auxtrace_info(struct perf_session *session,
 				      union perf_event *event);
 s64 perf_event__process_auxtrace(struct perf_session *session,
@@ -605,15 +601,6 @@ void auxtrace_record__free(struct auxtrace_record *itr __maybe_unused)
 {
 }
 
-static inline int
-perf_event__synthesize_auxtrace_info(struct auxtrace_record *itr __maybe_unused,
-				     struct perf_tool *tool __maybe_unused,
-				     struct perf_session *session __maybe_unused,
-				     perf_event__handler_t process __maybe_unused)
-{
-	return -EINVAL;
-}
-
 static inline
 int auxtrace_record__options(struct auxtrace_record *itr __maybe_unused,
 			     struct evlist *evlist __maybe_unused,
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 7a3d4b125323..f7ed5d122e22 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -16,6 +16,7 @@
 #include "map.h"
 #include "evlist.h"
 #include "record.h"
+#include "util/synthetic-events.h"
 
 #define ptr_to_u64(ptr)    ((__u64)(unsigned long)(ptr))
 
diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
index a01c2fd68c03..81fdc88e6c1a 100644
--- a/tools/perf/util/bpf-event.h
+++ b/tools/perf/util/bpf-event.h
@@ -6,9 +6,9 @@
 #include <linux/rbtree.h>
 #include <pthread.h>
 #include <api/fd/array.h>
-#include "event.h"
 #include <stdio.h>
 
+struct bpf_prog_info;
 struct machine;
 union perf_event;
 struct perf_env;
@@ -33,11 +33,6 @@ struct btf_node {
 #ifdef HAVE_LIBBPF_SUPPORT
 int machine__process_bpf(struct machine *machine, union perf_event *event,
 			 struct perf_sample *sample);
-
-int perf_event__synthesize_bpf_events(struct perf_session *session,
-				      perf_event__handler_t process,
-				      struct machine *machine,
-				      struct record_opts *opts);
 int bpf_event__add_sb_event(struct evlist **evlist,
 				 struct perf_env *env);
 void bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
@@ -51,14 +46,6 @@ static inline int machine__process_bpf(struct machine *machine __maybe_unused,
 	return 0;
 }
 
-static inline int perf_event__synthesize_bpf_events(struct perf_session *session __maybe_unused,
-						    perf_event__handler_t process __maybe_unused,
-						    struct machine *machine __maybe_unused,
-						    struct record_opts *opts __maybe_unused)
-{
-	return 0;
-}
-
 static inline int bpf_event__add_sb_event(struct evlist **evlist __maybe_unused,
 					  struct perf_env *env __maybe_unused)
 {
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index c14646c1f2eb..9a9b56ed3f0a 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -23,6 +23,7 @@
 
 #include "debug.h"
 #include "dso.h"
+#include "event.h"
 #include "hist.h"
 #include "sort.h"
 #include "machine.h"
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index d65ae7cf9316..043a08fc7398 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -32,6 +32,7 @@
 #include "stat.h"
 #include "session.h"
 #include "bpf-event.h"
+#include "synthetic-events.h"
 #include "tool.h"
 #include "../perf.h"
 
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 89a2404170a0..a0a0c91cde4a 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -279,95 +279,13 @@ enum {
 
 void perf_event__print_totals(void);
 
-struct evlist;
-struct evsel;
-struct perf_session;
-struct perf_tool;
-struct perf_thread_map;
 struct perf_cpu_map;
+struct perf_record_stat_config;
 struct perf_stat_config;
-struct perf_counts_values;
-
-typedef int (*perf_event__handler_t)(struct perf_tool *tool,
-				     union perf_event *event,
-				     struct perf_sample *sample,
-				     struct machine *machine);
+struct perf_tool;
 
-int perf_event__synthesize_stat_events(struct perf_stat_config *config,
-				       struct perf_tool *tool,
-				       struct evlist *evlist,
-				       perf_event__handler_t process,
-				       bool attrs);
-int perf_event__synthesize_attr(struct perf_tool *tool,
-				struct perf_event_attr *attr, u32 ids, u64 *id,
-				perf_event__handler_t process);
-int perf_event__synthesize_attrs(struct perf_tool *tool,
-				 struct evlist *evlist,
-				 perf_event__handler_t process);
-int perf_event__synthesize_build_id(struct perf_tool *tool,
-				    struct dso *pos, u16 misc,
-				    perf_event__handler_t process,
-				    struct machine *machine);
-int perf_event__synthesize_extra_attr(struct perf_tool *tool,
-				      struct evlist *evsel_list,
-				      perf_event__handler_t process,
-				      bool is_pipe);
-int perf_event__synthesize_event_update_cpus(struct perf_tool *tool,
-					     struct evsel *evsel,
-					     perf_event__handler_t process);
-int perf_event__synthesize_event_update_name(struct perf_tool *tool,
-					     struct evsel *evsel,
-					     perf_event__handler_t process);
-int perf_event__synthesize_event_update_scale(struct perf_tool *tool,
-					      struct evsel *evsel,
-					      perf_event__handler_t process);
-int perf_event__synthesize_event_update_unit(struct perf_tool *tool,
-					     struct evsel *evsel,
-					     perf_event__handler_t process);
-int perf_event__synthesize_features(struct perf_tool *tool,
-				    struct perf_session *session,
-				    struct evlist *evlist,
-				    perf_event__handler_t process);
-int perf_event__synthesize_tracing_data(struct perf_tool *tool,
-					int fd, struct evlist *evlist,
-					perf_event__handler_t process);
-int perf_event__synthesize_thread_map(struct perf_tool *tool,
-				      struct perf_thread_map *threads,
-				      perf_event__handler_t process,
-				      struct machine *machine, bool mmap_data);
-int perf_event__synthesize_thread_map2(struct perf_tool *tool,
-				      struct perf_thread_map *threads,
-				      perf_event__handler_t process,
-				      struct machine *machine);
-int perf_event__synthesize_cpu_map(struct perf_tool *tool,
-				   struct perf_cpu_map *cpus,
-				   perf_event__handler_t process,
-				   struct machine *machine);
-int perf_event__synthesize_threads(struct perf_tool *tool,
-				   perf_event__handler_t process,
-				   struct machine *machine, bool mmap_data,
-				   unsigned int nr_threads_synthesize);
-int perf_event__synthesize_kernel_mmap(struct perf_tool *tool,
-				       perf_event__handler_t process,
-				       struct machine *machine);
-int perf_event__synthesize_stat_config(struct perf_tool *tool,
-				       struct perf_stat_config *config,
-				       perf_event__handler_t process,
-				       struct machine *machine);
 void perf_event__read_stat_config(struct perf_stat_config *config,
 				  struct perf_record_stat_config *event);
-int perf_event__synthesize_stat(struct perf_tool *tool,
-				u32 cpu, u32 thread, u64 id,
-				struct perf_counts_values *count,
-				perf_event__handler_t process,
-				struct machine *machine);
-int perf_event__synthesize_stat_round(struct perf_tool *tool,
-				      u64 time, u64 type,
-				      perf_event__handler_t process,
-				      struct machine *machine);
-int perf_event__synthesize_modules(struct perf_tool *tool,
-				   perf_event__handler_t process,
-				   struct machine *machine);
 
 int perf_event__process_comm(struct perf_tool *tool,
 			     union perf_event *event,
@@ -421,10 +339,6 @@ int perf_event__process_bpf(struct perf_tool *tool,
 			    union perf_event *event,
 			    struct perf_sample *sample,
 			    struct machine *machine);
-int perf_tool__process_synth_event(struct perf_tool *tool,
-				   union perf_event *event,
-				   struct machine *machine,
-				   perf_event__handler_t process);
 int perf_event__process(struct perf_tool *tool,
 			union perf_event *event,
 			struct perf_sample *sample,
@@ -446,34 +360,6 @@ void thread__resolve(struct thread *thread, struct addr_location *al,
 
 const char *perf_event__name(unsigned int id);
 
-size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
-				     u64 read_format);
-int perf_event__synthesize_sample(union perf_event *event, u64 type,
-				  u64 read_format,
-				  const struct perf_sample *sample);
-
-pid_t perf_event__synthesize_comm(struct perf_tool *tool,
-				  union perf_event *event, pid_t pid,
-				  perf_event__handler_t process,
-				  struct machine *machine);
-
-int perf_event__synthesize_namespaces(struct perf_tool *tool,
-				      union perf_event *event,
-				      pid_t pid, pid_t tgid,
-				      perf_event__handler_t process,
-				      struct machine *machine);
-
-int perf_event__synthesize_mmap_events(struct perf_tool *tool,
-				       union perf_event *event,
-				       pid_t pid, pid_t tgid,
-				       perf_event__handler_t process,
-				       struct machine *machine,
-				       bool mmap_data);
-
-int perf_event__synthesize_extra_kmaps(struct perf_tool *tool,
-				       perf_event__handler_t process,
-				       struct machine *machine);
-
 size_t perf_event__fprintf_comm(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_mmap(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_mmap2(union perf_event *event, FILE *fp);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 5b40b840624c..5af025c80ec5 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -40,6 +40,7 @@
 #include "trace-event.h"
 #include "stat.h"
 #include "string2.h"
+#include "util/synthetic-events.h"
 #include "memswap.h"
 #include "util.h"
 #include "../perf-sys.h"
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index d85827de1b60..a4a8342eba98 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -45,6 +45,7 @@
 #include "util.h" // page_size, perf_exe()
 #include "cputopo.h"
 #include "bpf-event.h"
+#include "util/synthetic-events.h"
 
 #include <linux/ctype.h>
 #include <internal/lib.h>
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 15f87a09f4fe..3888d4cd3ed1 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -28,6 +28,7 @@
 #include "auxtrace.h"
 #include "intel-pt-decoder/intel-pt-insn-decoder.h"
 #include "intel-bts.h"
+#include "util/synthetic-events.h"
 
 #define MAX_TIMESTAMP (~0ULL)
 
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 9b56fb74bedf..bcdc0359f7cf 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -33,6 +33,7 @@
 #include "tsc.h"
 #include "intel-pt.h"
 #include "config.h"
+#include "util/synthetic-events.h"
 #include "time-utils.h"
 
 #include "../arch/x86/include/uapi/asm/perf_regs.h"
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index b4749d3eed08..132de5cfb9b9 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -20,6 +20,7 @@
 #include "symbol.h"
 #include "sort.h"
 #include "strlist.h"
+#include "util/synthetic-events.h"
 #include "target.h"
 #include "thread.h"
 #include "util.h"
@@ -2624,6 +2625,15 @@ int __machine__synthesize_threads(struct machine *machine, struct perf_tool *too
 	return 0;
 }
 
+int machine__synthesize_threads(struct machine *machine, struct target *target,
+				struct perf_thread_map *threads, bool data_mmap,
+				unsigned int nr_threads_synthesize)
+{
+	return __machine__synthesize_threads(machine, NULL, target, threads,
+					     perf_event__process, data_mmap,
+					     nr_threads_synthesize);
+}
+
 pid_t machine__get_current_tid(struct machine *machine, int cpu)
 {
 	int nr_cpus = min(machine->env->nr_cpus_online, MAX_NR_CPUS);
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index ffd391a925a6..18e13c0ccd6a 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -6,7 +6,6 @@
 #include <linux/rbtree.h>
 #include "map_groups.h"
 #include "dsos.h"
-#include "event.h"
 #include "rwsem.h"
 
 struct addr_location;
@@ -252,20 +251,6 @@ int machines__for_each_thread(struct machines *machines,
 			      int (*fn)(struct thread *thread, void *p),
 			      void *priv);
 
-int __machine__synthesize_threads(struct machine *machine, struct perf_tool *tool,
-				  struct target *target, struct perf_thread_map *threads,
-				  perf_event__handler_t process, bool data_mmap,
-				  unsigned int nr_threads_synthesize);
-static inline
-int machine__synthesize_threads(struct machine *machine, struct target *target,
-				struct perf_thread_map *threads, bool data_mmap,
-				unsigned int nr_threads_synthesize)
-{
-	return __machine__synthesize_threads(machine, NULL, target, threads,
-					     perf_event__process, data_mmap,
-					     nr_threads_synthesize);
-}
-
 pid_t machine__get_current_tid(struct machine *machine, int cpu);
 int machine__set_current_tid(struct machine *machine, int cpu, pid_t pid,
 			     pid_t tid);
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 2b583e6adb49..6267613b551d 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -29,6 +29,7 @@
 #include "thread-stack.h"
 #include "sample-raw.h"
 #include "stat.h"
+#include "util/synthetic-events.h"
 #include "util.h"
 #include "ui/progress.h"
 #include "../perf.h"
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index b7aa076ab6fd..b4c9428c18f0 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -138,9 +138,4 @@ int perf_session__deliver_synth_event(struct perf_session *session,
 int perf_event__process_id_index(struct perf_session *session,
 				 union perf_event *event);
 
-int perf_event__synthesize_id_index(struct perf_tool *tool,
-				    perf_event__handler_t process,
-				    struct evlist *evlist,
-				    struct machine *machine);
-
 #endif /* __PERF_SESSION_H */
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 2e318d95c528..46c8a5027e12 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -12,6 +12,7 @@
 #include "target.h"
 #include "evlist.h"
 #include "evsel.h"
+#include "util/synthetic-events.h"
 #include "thread_map.h"
 #include <linux/zalloc.h>
 
diff --git a/tools/perf/util/synthetic-events.h b/tools/perf/util/synthetic-events.h
new file mode 100644
index 000000000000..baead0cdc381
--- /dev/null
+++ b/tools/perf/util/synthetic-events.h
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_SYNTHETIC_EVENTS_H
+#define __PERF_SYNTHETIC_EVENTS_H
+
+#include <stdbool.h>
+#include <sys/types.h> // pid_t
+#include <linux/compiler.h>
+#include <linux/types.h>
+
+struct auxtrace_record;
+struct dso;
+struct evlist;
+struct evsel;
+struct machine;
+struct perf_counts_values;
+struct perf_cpu_map;
+struct perf_event_attr;
+struct perf_event_mmap_page;
+struct perf_sample;
+struct perf_session;
+struct perf_stat_config;
+struct perf_thread_map;
+struct perf_tool;
+struct record_opts;
+struct target;
+
+union perf_event;
+
+typedef int (*perf_event__handler_t)(struct perf_tool *tool, union perf_event *event,
+				     struct perf_sample *sample, struct machine *machine);
+
+int perf_event__synthesize_attrs(struct perf_tool *tool, struct evlist *evlist, perf_event__handler_t process);
+int perf_event__synthesize_attr(struct perf_tool *tool, struct perf_event_attr *attr, u32 ids, u64 *id, perf_event__handler_t process);
+int perf_event__synthesize_build_id(struct perf_tool *tool, struct dso *pos, u16 misc, perf_event__handler_t process, struct machine *machine);
+int perf_event__synthesize_cpu_map(struct perf_tool *tool, struct perf_cpu_map *cpus, perf_event__handler_t process, struct machine *machine);
+int perf_event__synthesize_event_update_cpus(struct perf_tool *tool, struct evsel *evsel, perf_event__handler_t process);
+int perf_event__synthesize_event_update_name(struct perf_tool *tool, struct evsel *evsel, perf_event__handler_t process);
+int perf_event__synthesize_event_update_scale(struct perf_tool *tool, struct evsel *evsel, perf_event__handler_t process);
+int perf_event__synthesize_event_update_unit(struct perf_tool *tool, struct evsel *evsel, perf_event__handler_t process);
+int perf_event__synthesize_extra_attr(struct perf_tool *tool, struct evlist *evsel_list, perf_event__handler_t process, bool is_pipe);
+int perf_event__synthesize_extra_kmaps(struct perf_tool *tool, perf_event__handler_t process, struct machine *machine);
+int perf_event__synthesize_features(struct perf_tool *tool, struct perf_session *session, struct evlist *evlist, perf_event__handler_t process);
+int perf_event__synthesize_id_index(struct perf_tool *tool, perf_event__handler_t process, struct evlist *evlist, struct machine *machine);
+int perf_event__synthesize_kernel_mmap(struct perf_tool *tool, perf_event__handler_t process, struct machine *machine);
+int perf_event__synthesize_mmap_events(struct perf_tool *tool, union perf_event *event, pid_t pid, pid_t tgid, perf_event__handler_t process, struct machine *machine, bool mmap_data);
+int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t process, struct machine *machine);
+int perf_event__synthesize_namespaces(struct perf_tool *tool, union perf_event *event, pid_t pid, pid_t tgid, perf_event__handler_t process, struct machine *machine);
+int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_format, const struct perf_sample *sample);
+int perf_event__synthesize_stat_config(struct perf_tool *tool, struct perf_stat_config *config, perf_event__handler_t process, struct machine *machine);
+int perf_event__synthesize_stat_events(struct perf_stat_config *config, struct perf_tool *tool, struct evlist *evlist, perf_event__handler_t process, bool attrs);
+int perf_event__synthesize_stat_round(struct perf_tool *tool, u64 time, u64 type, perf_event__handler_t process, struct machine *machine);
+int perf_event__synthesize_stat(struct perf_tool *tool, u32 cpu, u32 thread, u64 id, struct perf_counts_values *count, perf_event__handler_t process, struct machine *machine);
+int perf_event__synthesize_thread_map2(struct perf_tool *tool, struct perf_thread_map *threads, perf_event__handler_t process, struct machine *machine);
+int perf_event__synthesize_thread_map(struct perf_tool *tool, struct perf_thread_map *threads, perf_event__handler_t process, struct machine *machine, bool mmap_data);
+int perf_event__synthesize_threads(struct perf_tool *tool, perf_event__handler_t process, struct machine *machine, bool mmap_data, unsigned int nr_threads_synthesize);
+int perf_event__synthesize_tracing_data(struct perf_tool *tool, int fd, struct evlist *evlist, perf_event__handler_t process);
+int perf_event__synth_time_conv(const struct perf_event_mmap_page *pc, struct perf_tool *tool, perf_event__handler_t process, struct machine *machine);
+pid_t perf_event__synthesize_comm(struct perf_tool *tool, union perf_event *event, pid_t pid, perf_event__handler_t process, struct machine *machine);
+
+int perf_tool__process_synth_event(struct perf_tool *tool, union perf_event *event, struct machine *machine, perf_event__handler_t process);
+
+size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type, u64 read_format);
+
+int __machine__synthesize_threads(struct machine *machine, struct perf_tool *tool,
+				  struct target *target, struct perf_thread_map *threads,
+				  perf_event__handler_t process, bool data_mmap,
+				  unsigned int nr_threads_synthesize);
+int machine__synthesize_threads(struct machine *machine, struct target *target,
+				struct perf_thread_map *threads, bool data_mmap,
+				unsigned int nr_threads_synthesize);
+
+#ifdef HAVE_AUXTRACE_SUPPORT
+int perf_event__synthesize_auxtrace_info(struct auxtrace_record *itr, struct perf_tool *tool,
+					 struct perf_session *session, perf_event__handler_t process);
+
+#else // HAVE_AUXTRACE_SUPPORT
+
+#include <errno.h>
+
+static inline int
+perf_event__synthesize_auxtrace_info(struct auxtrace_record *itr __maybe_unused,
+				     struct perf_tool *tool __maybe_unused,
+				     struct perf_session *session __maybe_unused,
+				     perf_event__handler_t process __maybe_unused)
+{
+	return -EINVAL;
+}
+#endif // HAVE_AUXTRACE_SUPPORT
+
+#ifdef HAVE_LIBBPF_SUPPORT
+int perf_event__synthesize_bpf_events(struct perf_session *session, perf_event__handler_t process,
+				      struct machine *machine, struct record_opts *opts);
+#else // HAVE_LIBBPF_SUPPORT
+static inline int perf_event__synthesize_bpf_events(struct perf_session *session __maybe_unused,
+						    perf_event__handler_t process __maybe_unused,
+						    struct machine *machine __maybe_unused,
+						    struct record_opts *opts __maybe_unused)
+{
+	return 0;
+}
+#endif // HAVE_LIBBPF_SUPPORT
+
+#endif // __PERF_SYNTHETIC_EVENTS_H
diff --git a/tools/perf/util/tsc.h b/tools/perf/util/tsc.h
index e0c3af34ac8d..3c5a632ee57c 100644
--- a/tools/perf/util/tsc.h
+++ b/tools/perf/util/tsc.h
@@ -4,13 +4,12 @@
 
 #include <linux/types.h>
 
-#include "event.h"
-
 struct perf_tsc_conversion {
 	u16 time_shift;
 	u32 time_mult;
 	u64 time_zero;
 };
+
 struct perf_event_mmap_page;
 
 int perf_read_tsc_conversion(const struct perf_event_mmap_page *pc,
@@ -20,13 +19,4 @@ u64 perf_time_to_tsc(u64 ns, struct perf_tsc_conversion *tc);
 u64 tsc_to_perf_time(u64 cyc, struct perf_tsc_conversion *tc);
 u64 rdtsc(void);
 
-struct perf_event_mmap_page;
-struct perf_tool;
-struct machine;
-
-int perf_event__synth_time_conv(const struct perf_event_mmap_page *pc,
-				struct perf_tool *tool,
-				perf_event__handler_t process,
-				struct machine *machine);
-
-#endif
+#endif // __PERF_TSC_H
-- 
2.21.0

