Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230E3C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC04C21848
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbfJOFfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:35:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41973 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728429AbfJOFcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:32:00 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFQt-00007a-EL; Tue, 15 Oct 2019 07:31:43 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0984F1C04CF;
        Tue, 15 Oct 2019 07:31:40 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:39 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Adopt perf_mmap__consume() function from tools/perf
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191007125344.14268-10-jolsa@kernel.org>
References: <20191007125344.14268-10-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <157111749993.12254.3311411983946786547.tip-bot2@tip-bot2>
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

Commit-ID:     7728fa0cfaeb7d25b12c8865c733359cc8e5fb13
Gitweb:        https://git.kernel.org/tip/7728fa0cfaeb7d25b12c8865c733359cc8e5fb13
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Mon, 07 Oct 2019 14:53:17 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 10 Oct 2019 11:43:49 -03:00

libperf: Adopt perf_mmap__consume() function from tools/perf

Move perf_mmap__consume() vrom tools/perf to libperf and export it in
the perf/mmap.h header.

Move also the needed helpers perf_mmap__write_tail(),
perf_mmap__read_head() and perf_mmap__empty().

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191007125344.14268-10-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/tests/perf-time-to-tsc.c |  3 +-
 tools/perf/builtin-kvm.c                     |  5 +--
 tools/perf/builtin-top.c                     |  3 +-
 tools/perf/builtin-trace.c                   |  3 +-
 tools/perf/lib/Makefile                      |  5 +--
 tools/perf/lib/include/internal/mmap.h       |  2 +-
 tools/perf/lib/include/perf/mmap.h           | 11 +++++++-
 tools/perf/lib/libperf.map                   |  1 +-
 tools/perf/lib/mmap.c                        | 32 +++++++++++++++++++-
 tools/perf/tests/backward-ring-buffer.c      |  1 +-
 tools/perf/tests/bpf.c                       |  1 +-
 tools/perf/tests/code-reading.c              |  3 +-
 tools/perf/tests/keep-tracking.c             |  3 +-
 tools/perf/tests/mmap-basic.c                |  3 +-
 tools/perf/tests/openat-syscall-tp-fields.c  |  3 +-
 tools/perf/tests/perf-record.c               |  3 +-
 tools/perf/tests/sw-clock.c                  |  3 +-
 tools/perf/tests/switch-tracking.c           |  3 +-
 tools/perf/tests/task-exit.c                 |  3 +-
 tools/perf/util/evlist.c                     |  3 +-
 tools/perf/util/mmap.c                       | 32 ++++---------------
 tools/perf/util/mmap.h                       | 12 +-------
 tools/perf/util/python.c                     |  3 +-
 23 files changed, 87 insertions(+), 54 deletions(-)
 create mode 100644 tools/perf/lib/include/perf/mmap.h

diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
index fa94795..3397898 100644
--- a/tools/perf/arch/x86/tests/perf-time-to-tsc.c
+++ b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
@@ -9,6 +9,7 @@
 #include <sys/prctl.h>
 #include <perf/cpumap.h>
 #include <perf/evlist.h>
+#include <perf/mmap.h>
 
 #include "debug.h"
 #include "parse-events.h"
@@ -139,7 +140,7 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 				comm2_time = sample.time;
 			}
 next_event:
-			perf_mmap__consume(md);
+			perf_mmap__consume(&md->core);
 		}
 		perf_mmap__read_done(md);
 	}
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 58a9e09..0c04c4c 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -46,6 +46,7 @@
 #include <semaphore.h>
 #include <signal.h>
 #include <math.h>
+#include <perf/mmap.h>
 
 static const char *get_filename_for_perf_kvm(void)
 {
@@ -766,7 +767,7 @@ static s64 perf_kvm__mmap_read_idx(struct perf_kvm_stat *kvm, int idx,
 	while ((event = perf_mmap__read_event(md)) != NULL) {
 		err = perf_evlist__parse_sample_timestamp(evlist, event, &timestamp);
 		if (err) {
-			perf_mmap__consume(md);
+			perf_mmap__consume(&md->core);
 			pr_err("Failed to parse sample\n");
 			return -1;
 		}
@@ -776,7 +777,7 @@ static s64 perf_kvm__mmap_read_idx(struct perf_kvm_stat *kvm, int idx,
 		 * FIXME: Here we can't consume the event, as perf_session__queue_event will
 		 *        point to it, and it'll get possibly overwritten by the kernel.
 		 */
-		perf_mmap__consume(md);
+		perf_mmap__consume(&md->core);
 
 		if (err) {
 			pr_err("Failed to enqueue sample: %d\n", err);
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 611d030..5fcf157 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -82,6 +82,7 @@
 #include <linux/err.h>
 
 #include <linux/ctype.h>
+#include <perf/mmap.h>
 
 static volatile int done;
 static volatile int resize;
@@ -883,7 +884,7 @@ static void perf_top__mmap_read_idx(struct perf_top *top, int idx)
 		if (ret)
 			break;
 
-		perf_mmap__consume(md);
+		perf_mmap__consume(&md->core);
 
 		if (top->qe.rotate) {
 			pthread_mutex_lock(&top->qe.mutex);
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index b627975..6a57084 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -77,6 +77,7 @@
 #include <sys/sysmacros.h>
 
 #include <linux/ctype.h>
+#include <perf/mmap.h>
 
 #ifndef O_CLOEXEC
 # define O_CLOEXEC		02000000
@@ -3810,7 +3811,7 @@ again:
 			if (err)
 				goto out_disable;
 
-			perf_mmap__consume(md);
+			perf_mmap__consume(&md->core);
 
 			if (interrupted)
 				goto out_disable;
diff --git a/tools/perf/lib/Makefile b/tools/perf/lib/Makefile
index 85ccb8c..0889c9c 100644
--- a/tools/perf/lib/Makefile
+++ b/tools/perf/lib/Makefile
@@ -172,8 +172,9 @@ install_headers:
 		$(call do_install,include/perf/cpumap.h,$(prefix)/include/perf,644); \
 		$(call do_install,include/perf/threadmap.h,$(prefix)/include/perf,644); \
 		$(call do_install,include/perf/evlist.h,$(prefix)/include/perf,644); \
-		$(call do_install,include/perf/evsel.h,$(prefix)/include/perf,644);
-		$(call do_install,include/perf/event.h,$(prefix)/include/perf,644);
+		$(call do_install,include/perf/evsel.h,$(prefix)/include/perf,644); \
+		$(call do_install,include/perf/event.h,$(prefix)/include/perf,644); \
+		$(call do_install,include/perf/mmap.h,$(prefix)/include/perf,644);
 
 install_pkgconfig: $(LIBPERF_PC)
 	$(call QUIET_INSTALL, $(LIBPERF_PC)) \
diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
index bf9cc7d..ee536c4 100644
--- a/tools/perf/lib/include/internal/mmap.h
+++ b/tools/perf/lib/include/internal/mmap.h
@@ -49,4 +49,6 @@ void perf_mmap__munmap(struct perf_mmap *map);
 void perf_mmap__get(struct perf_mmap *map);
 void perf_mmap__put(struct perf_mmap *map);
 
+u64 perf_mmap__read_head(struct perf_mmap *map);
+
 #endif /* __LIBPERF_INTERNAL_MMAP_H */
diff --git a/tools/perf/lib/include/perf/mmap.h b/tools/perf/lib/include/perf/mmap.h
new file mode 100644
index 0000000..d3678d1
--- /dev/null
+++ b/tools/perf/lib/include/perf/mmap.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_MMAP_H
+#define __LIBPERF_MMAP_H
+
+#include <perf/core.h>
+
+struct perf_mmap;
+
+LIBPERF_API void perf_mmap__consume(struct perf_mmap *map);
+
+#endif /* __LIBPERF_MMAP_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index ab8dbde..d7b327f 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -40,6 +40,7 @@ LIBPERF_0.0.1 {
 		perf_evlist__next;
 		perf_evlist__set_maps;
 		perf_evlist__poll;
+		perf_mmap__consume;
 	local:
 		*;
 };
diff --git a/tools/perf/lib/mmap.c b/tools/perf/lib/mmap.c
index 89c1e0e..4cada1c 100644
--- a/tools/perf/lib/mmap.c
+++ b/tools/perf/lib/mmap.c
@@ -1,5 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <sys/mman.h>
+#include <linux/ring_buffer.h>
+#include <linux/perf_event.h>
+#include <perf/mmap.h>
 #include <internal/mmap.h>
 #include <internal/lib.h>
 #include <linux/kernel.h>
@@ -59,3 +62,32 @@ void perf_mmap__put(struct perf_mmap *map)
 	if (refcount_dec_and_test(&map->refcnt))
 		perf_mmap__munmap(map);
 }
+
+static inline void perf_mmap__write_tail(struct perf_mmap *md, u64 tail)
+{
+	ring_buffer_write_tail(md->base, tail);
+}
+
+u64 perf_mmap__read_head(struct perf_mmap *map)
+{
+	return ring_buffer_read_head(map->base);
+}
+
+static bool perf_mmap__empty(struct perf_mmap *map)
+{
+	struct perf_event_mmap_page *pc = map->base;
+
+	return perf_mmap__read_head(map) == map->prev && !pc->aux_size;
+}
+
+void perf_mmap__consume(struct perf_mmap *map)
+{
+	if (!map->overwrite) {
+		u64 old = map->prev;
+
+		perf_mmap__write_tail(map, old);
+	}
+
+	if (refcount_read(&map->refcnt) == 1 && perf_mmap__empty(map))
+		perf_mmap__put(map);
+}
diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
index 338cd9f..13f9a06 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -13,6 +13,7 @@
 #include "util/mmap.h"
 #include <errno.h>
 #include <linux/string.h>
+#include <perf/mmap.h>
 
 #define NR_ITERS 111
 
diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index 1eb0bff..6f0d239 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -15,6 +15,7 @@
 #include <linux/string.h>
 #include <api/fs/fs.h>
 #include <bpf/bpf.h>
+#include <perf/mmap.h>
 #include "tests.h"
 #include "llvm.h"
 #include "debug.h"
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index f5764a3..b5a57bb 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -10,6 +10,7 @@
 #include <sys/param.h>
 #include <perf/cpumap.h>
 #include <perf/evlist.h>
+#include <perf/mmap.h>
 
 #include "debug.h"
 #include "dso.h"
@@ -430,7 +431,7 @@ static int process_events(struct machine *machine, struct evlist *evlist,
 
 		while ((event = perf_mmap__read_event(md)) != NULL) {
 			ret = process_event(machine, evlist, event, state);
-			perf_mmap__consume(md);
+			perf_mmap__consume(&md->core);
 			if (ret < 0)
 				return ret;
 		}
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index 92c7d59..31c005e 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -5,6 +5,7 @@
 #include <sys/prctl.h>
 #include <perf/cpumap.h>
 #include <perf/evlist.h>
+#include <perf/mmap.h>
 
 #include "debug.h"
 #include "parse-events.h"
@@ -46,7 +47,7 @@ static int find_comm(struct evlist *evlist, const char *comm)
 			    (pid_t)event->comm.tid == getpid() &&
 			    strcmp(event->comm.comm, comm) == 0)
 				found += 1;
-			perf_mmap__consume(md);
+			perf_mmap__consume(&md->core);
 		}
 		perf_mmap__read_done(md);
 	}
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 3a22dce..b176acc 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <perf/evlist.h>
+#include <perf/mmap.h>
 
 /*
  * This test will generate random numbers of calls to some getpid syscalls,
@@ -139,7 +140,7 @@ int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unuse
 			goto out_delete_evlist;
 		}
 		nr_events[evsel->idx]++;
-		perf_mmap__consume(md);
+		perf_mmap__consume(&md->core);
 	}
 	perf_mmap__read_done(md);
 
diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index 2b5c468..bbf8ba3 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -13,6 +13,7 @@
 #include "debug.h"
 #include "util/mmap.h"
 #include <errno.h>
+#include <perf/mmap.h>
 
 #ifndef O_DIRECTORY
 #define O_DIRECTORY    00200000
@@ -103,7 +104,7 @@ int test__syscall_openat_tp_fields(struct test *test __maybe_unused, int subtest
 				++nr_events;
 
 				if (type != PERF_RECORD_SAMPLE) {
-					perf_mmap__consume(md);
+					perf_mmap__consume(&md->core);
 					continue;
 				}
 
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index 437426b..6ebbcc6 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -6,6 +6,7 @@
 #include <pthread.h>
 
 #include <sched.h>
+#include <perf/mmap.h>
 #include "evlist.h"
 #include "evsel.h"
 #include "debug.h"
@@ -276,7 +277,7 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 					++errs;
 				}
 
-				perf_mmap__consume(md);
+				perf_mmap__consume(&md->core);
 			}
 			perf_mmap__read_done(md);
 		}
diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index 84519df..1aeb558 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -15,6 +15,7 @@
 #include "util/mmap.h"
 #include "util/thread_map.h"
 #include <perf/evlist.h>
+#include <perf/mmap.h>
 
 #define NR_LOOPS  10000000
 
@@ -117,7 +118,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 		total_periods += sample.period;
 		nr_samples++;
 next_event:
-		perf_mmap__consume(md);
+		perf_mmap__consume(&md->core);
 	}
 	perf_mmap__read_done(md);
 
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index ffa592e..55728b3 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -8,6 +8,7 @@
 #include <linux/zalloc.h>
 #include <perf/cpumap.h>
 #include <perf/evlist.h>
+#include <perf/mmap.h>
 
 #include "debug.h"
 #include "parse-events.h"
@@ -275,7 +276,7 @@ static int process_events(struct evlist *evlist,
 		while ((event = perf_mmap__read_event(md)) != NULL) {
 			cnt += 1;
 			ret = add_event(evlist, &events, event);
-			 perf_mmap__consume(md);
+			 perf_mmap__consume(&md->core);
 			if (ret < 0)
 				goto out_free_nodes;
 		}
diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index bce3a4c..a0f6895 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -12,6 +12,7 @@
 #include <linux/string.h>
 #include <perf/cpumap.h>
 #include <perf/evlist.h>
+#include <perf/mmap.h>
 
 static int exited;
 static int nr_exit;
@@ -124,7 +125,7 @@ retry:
 		if (event->header.type == PERF_RECORD_EXIT)
 			nr_exit++;
 
-		perf_mmap__consume(md);
+		perf_mmap__consume(&md->core);
 	}
 	perf_mmap__read_done(md);
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 4394a5a..34ba47b 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -42,6 +42,7 @@
 #include <perf/evlist.h>
 #include <perf/evsel.h>
 #include <perf/cpumap.h>
+#include <perf/mmap.h>
 
 #include <internal/xyarray.h>
 
@@ -1818,7 +1819,7 @@ static void *perf_evlist__poll_thread(void *arg)
 				else
 					pr_warning("cannot locate proper evsel for the side band event\n");
 
-				perf_mmap__consume(map);
+				perf_mmap__consume(&map->core);
 				got_data = true;
 			}
 			perf_mmap__read_done(map);
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index f246dd4..abe7cbe 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -13,6 +13,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h> // sysconf()
+#include <perf/mmap.h>
 #ifdef HAVE_LIBNUMA_SUPPORT
 #include <numaif.h>
 #endif
@@ -95,7 +96,7 @@ union perf_event *perf_mmap__read_event(struct mmap *map)
 
 	/* non-overwirte doesn't pause the ringbuffer */
 	if (!map->core.overwrite)
-		map->core.end = perf_mmap__read_head(map);
+		map->core.end = perf_mmap__read_head(&map->core);
 
 	event = perf_mmap__read(map, &map->core.start, map->core.end);
 
@@ -105,25 +106,6 @@ union perf_event *perf_mmap__read_event(struct mmap *map)
 	return event;
 }
 
-static bool perf_mmap__empty(struct mmap *map)
-{
-	struct perf_event_mmap_page *pc = map->core.base;
-
-	return perf_mmap__read_head(map) == map->core.prev && !pc->aux_size;
-}
-
-void perf_mmap__consume(struct mmap *map)
-{
-	if (!map->core.overwrite) {
-		u64 old = map->core.prev;
-
-		perf_mmap__write_tail(map, old);
-	}
-
-	if (refcount_read(&map->core.refcnt) == 1 && perf_mmap__empty(map))
-		perf_mmap__put(&map->core);
-}
-
 int __weak auxtrace_mmap__mmap(struct auxtrace_mmap *mm __maybe_unused,
 			       struct auxtrace_mmap_params *mp __maybe_unused,
 			       void *userpg __maybe_unused,
@@ -420,7 +402,7 @@ static int overwrite_rb_find_range(void *buf, int mask, u64 *start, u64 *end)
  */
 static int __perf_mmap__read_init(struct mmap *md)
 {
-	u64 head = perf_mmap__read_head(md);
+	u64 head = perf_mmap__read_head(&md->core);
 	u64 old = md->core.prev;
 	unsigned char *data = md->core.base + page_size;
 	unsigned long size;
@@ -437,7 +419,7 @@ static int __perf_mmap__read_init(struct mmap *md)
 			WARN_ONCE(1, "failed to keep up with mmap data. (warn only once)\n");
 
 			md->core.prev = head;
-			perf_mmap__consume(md);
+			perf_mmap__consume(&md->core);
 			return -EAGAIN;
 		}
 
@@ -466,7 +448,7 @@ int perf_mmap__read_init(struct mmap *map)
 int perf_mmap__push(struct mmap *md, void *to,
 		    int push(struct mmap *map, void *to, void *buf, size_t size))
 {
-	u64 head = perf_mmap__read_head(md);
+	u64 head = perf_mmap__read_head(&md->core);
 	unsigned char *data = md->core.base + page_size;
 	unsigned long size;
 	void *buf;
@@ -499,7 +481,7 @@ int perf_mmap__push(struct mmap *md, void *to,
 	}
 
 	md->core.prev = head;
-	perf_mmap__consume(md);
+	perf_mmap__consume(&md->core);
 out:
 	return rc;
 }
@@ -518,5 +500,5 @@ void perf_mmap__read_done(struct mmap *map)
 	if (!refcount_read(&map->core.refcnt))
 		return;
 
-	map->core.prev = perf_mmap__read_head(map);
+	map->core.prev = perf_mmap__read_head(&map->core);
 }
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 78e3c44..89fb932 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -45,18 +45,6 @@ struct mmap_params {
 int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu);
 void mmap__munmap(struct mmap *map);
 
-void perf_mmap__consume(struct mmap *map);
-
-static inline u64 perf_mmap__read_head(struct mmap *mm)
-{
-	return ring_buffer_read_head(mm->core.base);
-}
-
-static inline void perf_mmap__write_tail(struct mmap *md, u64 tail)
-{
-	ring_buffer_write_tail(md->core.base, tail);
-}
-
 union perf_event *perf_mmap__read_forward(struct mmap *map);
 
 union perf_event *perf_mmap__read_event(struct mmap *map);
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 0246036..82a4fa6 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -6,6 +6,7 @@
 #include <linux/err.h>
 #include <perf/cpumap.h>
 #include <traceevent/event-parse.h>
+#include <perf/mmap.h>
 #include "evlist.h"
 #include "callchain.h"
 #include "evsel.h"
@@ -1045,7 +1046,7 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 		err = perf_evsel__parse_sample(evsel, event, &pevent->sample);
 
 		/* Consume the even only after we parsed it out. */
-		perf_mmap__consume(md);
+		perf_mmap__consume(&md->core);
 
 		if (err)
 			return PyErr_Format(PyExc_OSError,
