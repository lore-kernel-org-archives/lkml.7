Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C085C73C56
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F4EE216C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562697169;
	bh=EIoD0PbUix/W/kisd/QUvH9q/xHwqqJQ7FyM9w9/X/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sqy8EMhBn5XqpJUYOgwdzAfcpFNJD01IpL7eh/wDL0x2BRK/g9uX/4YPFanu9gXEG
	 GgCv83xKYQWkFRodqK/ST8Se+Wyn28xmD9a2yEtSIjxt9LuSctJ/ZX7/PdFkFuLY2i
	 dV0RU7FCK7e29WTuWBqwttzsM4MGH4SmkHKvjOms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbfGIScr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:32:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729166AbfGIScq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:32:46 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5193120665;
        Tue,  9 Jul 2019 18:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562697165;
        bh=EIoD0PbUix/W/kisd/QUvH9q/xHwqqJQ7FyM9w9/X/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=egsQx1fHvCs4ivXdvJScPqzlTyeGL4P9oq991ZegKks5SsGz5akq7gW5GH9+0Dt6f
         aTN0w4pi0tubjiZM5hiWHp6g2aPAn3Lt8H53FmW9KF94gZCytPOVTpST9Tb7ET4vFB
         YUbg9Nhmi6dHzbbJXgzDYe+zFc0vn6XZ4GZyRH6Y=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 14/25] perf tools: Use zfree() where applicable
Date:   Tue,  9 Jul 2019 15:31:15 -0300
Message-Id: <20190709183126.30257-15-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190709183126.30257-1-acme@kernel.org>
References: <20190709183126.30257-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

In places where the equivalent was already being done, i.e.:

   free(a);
   a = NULL;

And in placs where struct members are being freed so that if we have
some erroneous reference to its struct, then accesses to freed members
will result in segfaults, which we can detect faster than use after free
to areas that may still have something seemingly valid.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-jatyoofo5boc1bsvoig6bb6i@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/bench/futex-hash.c            |  3 +-
 tools/perf/bench/futex-lock-pi.c         |  3 +-
 tools/perf/builtin-record.c              |  4 +-
 tools/perf/builtin-stat.c                |  4 +-
 tools/perf/tests/dwarf-unwind.c          |  5 ++-
 tools/perf/tests/expr.c                  |  3 +-
 tools/perf/tests/mem2node.c              |  3 +-
 tools/perf/tests/thread-map.c            |  3 +-
 tools/perf/ui/browsers/res_sample.c      |  6 +--
 tools/perf/ui/browsers/scripts.c         |  4 +-
 tools/perf/util/annotate.c               |  3 +-
 tools/perf/util/auxtrace.c               |  5 +--
 tools/perf/util/cgroup.c                 |  2 +-
 tools/perf/util/cputopo.c                |  2 +-
 tools/perf/util/cs-etm.c                 |  5 +--
 tools/perf/util/data-convert-bt.c        |  2 +-
 tools/perf/util/data.c                   |  2 +-
 tools/perf/util/env.c                    |  8 ++--
 tools/perf/util/event.c                  |  2 +-
 tools/perf/util/header.c                 |  6 +--
 tools/perf/util/hist.c                   | 14 +++----
 tools/perf/util/jitdump.c                |  7 ++--
 tools/perf/util/llvm-utils.c             |  3 +-
 tools/perf/util/machine.c                |  4 +-
 tools/perf/util/metricgroup.c            |  9 +++--
 tools/perf/util/probe-event.c            | 51 +++++++++++-------------
 tools/perf/util/s390-cpumsf.c            |  7 ++--
 tools/perf/util/srccode.c                |  9 +++--
 tools/perf/util/stat-shadow.c            |  3 +-
 tools/perf/util/stat.c                   |  2 +-
 tools/perf/util/symbol-elf.c             | 10 ++---
 tools/perf/util/thread_map.c             |  2 +-
 tools/perf/util/unwind-libunwind-local.c |  3 +-
 33 files changed, 100 insertions(+), 99 deletions(-)

diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
index 9aa3a674829b..a80797763e1f 100644
--- a/tools/perf/bench/futex-hash.c
+++ b/tools/perf/bench/futex-hash.c
@@ -18,6 +18,7 @@
 #include <stdlib.h>
 #include <linux/compiler.h>
 #include <linux/kernel.h>
+#include <linux/zalloc.h>
 #include <sys/time.h>
 
 #include "../util/stat.h"
@@ -214,7 +215,7 @@ int bench_futex_hash(int argc, const char **argv)
 				       &worker[i].futex[nfutexes-1], t);
 		}
 
-		free(worker[i].futex);
+		zfree(&worker[i].futex);
 	}
 
 	print_summary();
diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lock-pi.c
index 8e9c4753e304..d02330a69745 100644
--- a/tools/perf/bench/futex-lock-pi.c
+++ b/tools/perf/bench/futex-lock-pi.c
@@ -12,6 +12,7 @@
 #include <subcmd/parse-options.h>
 #include <linux/compiler.h>
 #include <linux/kernel.h>
+#include <linux/zalloc.h>
 #include <errno.h>
 #include "bench.h"
 #include "futex.h"
@@ -217,7 +218,7 @@ int bench_futex_lock_pi(int argc, const char **argv)
 			       worker[i].tid, worker[i].futex, t);
 
 		if (multi)
-			free(worker[i].futex);
+			zfree(&worker[i].futex);
 	}
 
 	print_summary();
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index dca55997934e..8779cee58185 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -11,7 +11,6 @@
 #include "perf.h"
 
 #include "util/build-id.h"
-#include "util/util.h"
 #include <subcmd/parse-options.h>
 #include "util/parse-events.h"
 #include "util/config.h"
@@ -54,6 +53,7 @@
 #include <sys/mman.h>
 #include <sys/wait.h>
 #include <linux/time64.h>
+#include <linux/zalloc.h>
 
 struct switch_output {
 	bool		 enabled;
@@ -1110,7 +1110,7 @@ record__switch_output(struct record *rec, bool at_exit)
 		rec->switch_output.cur_file = n;
 		if (rec->switch_output.filenames[n]) {
 			remove(rec->switch_output.filenames[n]);
-			free(rec->switch_output.filenames[n]);
+			zfree(&rec->switch_output.filenames[n]);
 		}
 		rec->switch_output.filenames[n] = new_filename;
 	} else {
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index c72f4a0831a8..b55a534b4de0 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1586,7 +1586,7 @@ static void runtime_stat_delete(struct perf_stat_config *config)
 	for (i = 0; i < config->stats_num; i++)
 		runtime_stat__exit(&config->stats[i]);
 
-	free(config->stats);
+	zfree(&config->stats);
 }
 
 static const char * const stat_report_usage[] = {
@@ -2003,7 +2003,7 @@ int cmd_stat(int argc, const char **argv)
 	perf_stat__exit_aggr_mode();
 	perf_evlist__free_stats(evsel_list);
 out:
-	free(stat_config.walltime_run);
+	zfree(&stat_config.walltime_run);
 
 	if (smi_cost && smi_reset)
 		sysfs__write_int(FREEZE_ON_SMI_PATH, 0);
diff --git a/tools/perf/tests/dwarf-unwind.c b/tools/perf/tests/dwarf-unwind.c
index 077c306c1cae..f33709a79335 100644
--- a/tools/perf/tests/dwarf-unwind.c
+++ b/tools/perf/tests/dwarf-unwind.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/compiler.h>
 #include <linux/types.h>
+#include <linux/zalloc.h>
 #include <inttypes.h>
 #include <unistd.h>
 #include "tests.h"
@@ -115,8 +116,8 @@ noinline int test_dwarf_unwind__thread(struct thread *thread)
 	}
 
  out:
-	free(sample.user_stack.data);
-	free(sample.user_regs.regs);
+	zfree(&sample.user_stack.data);
+	zfree(&sample.user_regs.regs);
 	return err;
 }
 
diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 9acc1e80b936..ee1d88650e69 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -3,6 +3,7 @@
 #include "util/expr.h"
 #include "tests.h"
 #include <stdlib.h>
+#include <linux/zalloc.h>
 
 static int test(struct parse_ctx *ctx, const char *e, double val2)
 {
@@ -58,7 +59,7 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 	TEST_ASSERT_VAL("find other", other[3] == NULL);
 
 	for (i = 0; i < num_other; i++)
-		free((void *)other[i]);
+		zfree(&other[i]);
 	free((void *)other);
 
 	return 0;
diff --git a/tools/perf/tests/mem2node.c b/tools/perf/tests/mem2node.c
index d23ff1b68eba..520cc91af256 100644
--- a/tools/perf/tests/mem2node.c
+++ b/tools/perf/tests/mem2node.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/compiler.h>
 #include <linux/bitmap.h>
+#include <linux/zalloc.h>
 #include "cpumap.h"
 #include "mem2node.h"
 #include "tests.h"
@@ -67,7 +68,7 @@ int test__mem2node(struct test *t __maybe_unused, int subtest __maybe_unused)
 	T("failed: mem2node__node", -1 == mem2node__node(&map, 0x1050));
 
 	for (i = 0; i < ARRAY_SIZE(nodes); i++)
-		free(nodes[i].set);
+		zfree(&nodes[i].set);
 
 	mem2node__exit(&map);
 	return 0;
diff --git a/tools/perf/tests/thread-map.c b/tools/perf/tests/thread-map.c
index 4de1939b58ba..ccc17aced49e 100644
--- a/tools/perf/tests/thread-map.c
+++ b/tools/perf/tests/thread-map.c
@@ -6,6 +6,7 @@
 #include "tests.h"
 #include "thread_map.h"
 #include "debug.h"
+#include <linux/zalloc.h>
 
 #define NAME	(const char *) "perf"
 #define NAMEUL	(unsigned long) NAME
@@ -133,7 +134,7 @@ int test__thread_map_remove(struct test *test __maybe_unused, int subtest __mayb
 			thread_map__remove(threads, 0));
 
 	for (i = 0; i < threads->nr; i++)
-		free(threads->map[i].comm);
+		zfree(&threads->map[i].comm);
 
 	free(threads);
 	return 0;
diff --git a/tools/perf/ui/browsers/res_sample.c b/tools/perf/ui/browsers/res_sample.c
index c0dd73176d42..8aa3547bb9ff 100644
--- a/tools/perf/ui/browsers/res_sample.c
+++ b/tools/perf/ui/browsers/res_sample.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Display a menu with individual samples to browse with perf script */
-#include "util.h"
 #include "hist.h"
 #include "evsel.h"
 #include "hists.h"
@@ -8,6 +7,7 @@
 #include "config.h"
 #include "time-utils.h"
 #include <linux/time64.h>
+#include <linux/zalloc.h>
 
 static u64 context_len = 10 * NSEC_PER_MSEC;
 
@@ -46,14 +46,14 @@ int res_sample_browse(struct res_sample *res_samples, int num_res,
 		if (asprintf(&names[i], "%s: CPU %d tid %d", tbuf,
 			     res_samples[i].cpu, res_samples[i].tid) < 0) {
 			while (--i >= 0)
-				free(names[i]);
+				zfree(&names[i]);
 			free(names);
 			return -1;
 		}
 	}
 	choice = ui__popup_menu(num_res, names);
 	for (i = 0; i < num_res; i++)
-		free(names[i]);
+		zfree(&names[i]);
 	free(names);
 
 	if (choice < 0 || choice >= num_res)
diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
index 27cf3ab88d13..4d565cc14076 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -1,12 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "../../util/sort.h"
-#include "../../util/util.h"
 #include "../../util/hist.h"
 #include "../../util/debug.h"
 #include "../../util/symbol.h"
 #include "../browser.h"
 #include "../libslang.h"
 #include "config.h"
+#include <linux/zalloc.h>
 
 #define SCRIPT_NAMELEN	128
 #define SCRIPT_MAX_NO	64
@@ -142,7 +142,7 @@ static int list_scripts(char *script_name, bool *custom,
 out:
 	free(buf);
 	for (i = 0; i < max_std; i++)
-		free(paths[i]);
+		zfree(&paths[i]);
 	return ret;
 }
 
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 944a6507a5e3..ef0e6028684c 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1235,8 +1235,7 @@ void disasm_line__free(struct disasm_line *dl)
 		dl->ins.ops->free(&dl->ops);
 	else
 		ins__delete(&dl->ops);
-	free((void *)dl->ins.name);
-	dl->ins.name = NULL;
+	zfree(&dl->ins.name);
 	annotation_line__delete(&dl->al);
 }
 
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 0812a11a0dbe..b033a43dfe3b 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1413,7 +1413,7 @@ void auxtrace_cache__free(struct auxtrace_cache *c)
 		return;
 
 	auxtrace_cache__drop(c);
-	free(c->hashtable);
+	zfree(&c->hashtable);
 	free(c);
 }
 
@@ -1459,12 +1459,11 @@ void *auxtrace_cache__lookup(struct auxtrace_cache *c, u32 key)
 
 static void addr_filter__free_str(struct addr_filter *filt)
 {
-	free(filt->str);
+	zfree(&filt->str);
 	filt->action   = NULL;
 	filt->sym_from = NULL;
 	filt->sym_to   = NULL;
 	filt->filename = NULL;
-	filt->str      = NULL;
 }
 
 static struct addr_filter *addr_filter__new(void)
diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index f505d78f059b..484c29830a81 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -124,7 +124,7 @@ static struct cgroup *cgroup__new(const char *name)
 	return cgroup;
 
 out_free_name:
-	free(cgroup->name);
+	zfree(&cgroup->name);
 out_err:
 	free(cgroup);
 	return NULL;
diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
index fa1778aee5d6..64336a280967 100644
--- a/tools/perf/util/cputopo.c
+++ b/tools/perf/util/cputopo.c
@@ -344,7 +344,7 @@ void numa_topology__delete(struct numa_topology *tp)
 	u32 i;
 
 	for (i = 0; i < tp->nr; i++)
-		free(tp->nodes[i].cpus);
+		zfree(&tp->nodes[i].cpus);
 
 	free(tp);
 }
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index d92516edbead..508e4a3ddc8c 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -555,8 +555,7 @@ static void cs_etm__free_traceid_queues(struct cs_etm_queue *etmq)
 	etmq->traceid_queues_list = NULL;
 
 	/* finally free the traceid_queues array */
-	free(etmq->traceid_queues);
-	etmq->traceid_queues = NULL;
+	zfree(&etmq->traceid_queues);
 }
 
 static void cs_etm__free_queue(void *priv)
@@ -2569,7 +2568,7 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 err_free_metadata:
 	/* No need to check @metadata[j], free(NULL) is supported */
 	for (j = 0; j < num_cpu; j++)
-		free(metadata[j]);
+		zfree(&metadata[j]);
 	zfree(&metadata);
 err_free_traceid_list:
 	intlist__delete(traceid_list);
diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index 1e93f2e94c40..ddbcd59f2d9b 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -1353,7 +1353,7 @@ static void free_streams(struct ctf_writer *cw)
 	for (cpu = 0; cpu < cw->stream_cnt; cpu++)
 		ctf_stream__delete(cw->stream[cpu]);
 
-	free(cw->stream);
+	zfree(&cw->stream);
 }
 
 static int ctf_writer__setup_env(struct ctf_writer *cw,
diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index df7e000e19ea..1d1b97a92c3f 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -21,7 +21,7 @@ static void close_dir(struct perf_data_file *files, int nr)
 {
 	while (--nr >= 1) {
 		close(files[nr].fd);
-		free(files[nr].path);
+		zfree(&files[nr].path);
 	}
 	free(files);
 }
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index f92d992bd2db..9909ec40c6d2 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -187,7 +187,7 @@ void perf_env__exit(struct perf_env *env)
 	zfree(&env->caches);
 
 	for (i = 0; i < env->nr_memory_nodes; i++)
-		free(env->memory_nodes[i].set);
+		zfree(&env->memory_nodes[i].set);
 	zfree(&env->memory_nodes);
 }
 
@@ -287,9 +287,9 @@ int perf_env__nr_cpus_avail(struct perf_env *env)
 
 void cpu_cache_level__free(struct cpu_cache_level *cache)
 {
-	free(cache->type);
-	free(cache->map);
-	free(cache->size);
+	zfree(&cache->type);
+	zfree(&cache->map);
+	zfree(&cache->size);
 }
 
 /*
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 7524bda5140b..f1f4848947ce 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -856,7 +856,7 @@ int perf_event__synthesize_threads(struct perf_tool *tool,
 	free(synthesize_threads);
 free_dirent:
 	for (i = 0; i < n; i++)
-		free(dirent[i]);
+		zfree(&dirent[i]);
 	free(dirent);
 
 	return err;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 4e2efaa50c2f..c24db7f4909c 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1052,7 +1052,7 @@ static int cpu_cache_level__read(struct cpu_cache_level *cache, u32 cpu, u16 lev
 
 	scnprintf(file, PATH_MAX, "%s/size", path);
 	if (sysfs__read_str(file, &cache->size, &len)) {
-		free(cache->type);
+		zfree(&cache->type);
 		return -1;
 	}
 
@@ -1061,8 +1061,8 @@ static int cpu_cache_level__read(struct cpu_cache_level *cache, u32 cpu, u16 lev
 
 	scnprintf(file, PATH_MAX, "%s/shared_cpu_list", path);
 	if (sysfs__read_str(file, &cache->map, &len)) {
-		free(cache->map);
-		free(cache->type);
+		zfree(&cache->map);
+		zfree(&cache->type);
 		return -1;
 	}
 
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index bb1d77331add..9b0ee0ef0f44 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -472,16 +472,16 @@ static int hist_entry__init(struct hist_entry *he,
 	return 0;
 
 err_srcline:
-	free(he->srcline);
+	zfree(&he->srcline);
 
 err_rawdata:
-	free(he->raw_data);
+	zfree(&he->raw_data);
 
 err_infos:
 	if (he->branch_info) {
 		map__put(he->branch_info->from.map);
 		map__put(he->branch_info->to.map);
-		free(he->branch_info);
+		zfree(&he->branch_info);
 	}
 	if (he->mem_info) {
 		map__put(he->mem_info->iaddr.map);
@@ -489,7 +489,7 @@ static int hist_entry__init(struct hist_entry *he,
 	}
 err:
 	map__zput(he->ms.map);
-	free(he->stat_acc);
+	zfree(&he->stat_acc);
 	return -ENOMEM;
 }
 
@@ -1254,10 +1254,10 @@ void hist_entry__delete(struct hist_entry *he)
 	zfree(&he->stat_acc);
 	free_srcline(he->srcline);
 	if (he->srcfile && he->srcfile[0])
-		free(he->srcfile);
+		zfree(&he->srcfile);
 	free_callchain(he->callchain);
-	free(he->trace_output);
-	free(he->raw_data);
+	zfree(&he->trace_output);
+	zfree(&he->raw_data);
 	ops->free(he);
 }
 
diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 28908afedec4..18c34f0c1966 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -29,6 +29,7 @@
 #include "../builtin.h"
 
 #include <linux/ctype.h>
+#include <linux/zalloc.h>
 
 struct jit_buf_desc {
 	struct perf_data *output;
@@ -431,14 +432,12 @@ static int jit_repipe_code_load(struct jit_buf_desc *jd, union jr_entry *jr)
 			   jd->unwinding_data, jd->eh_frame_hdr_size, jd->unwinding_size);
 
 	if (jd->debug_data && jd->nr_debug_entries) {
-		free(jd->debug_data);
-		jd->debug_data = NULL;
+		zfree(&jd->debug_data);
 		jd->nr_debug_entries = 0;
 	}
 
 	if (jd->unwinding_data && jd->eh_frame_hdr_size) {
-		free(jd->unwinding_data);
-		jd->unwinding_data = NULL;
+		zfree(&jd->unwinding_data);
 		jd->eh_frame_hdr_size = 0;
 		jd->unwinding_mapped_size = 0;
 		jd->unwinding_size = 0;
diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
index b9fddb809d58..9f0470ecbca9 100644
--- a/tools/perf/util/llvm-utils.c
+++ b/tools/perf/util/llvm-utils.c
@@ -353,8 +353,7 @@ void llvm__get_kbuild_opts(char **kbuild_dir, char **kbuild_include_opts)
 "     \toption in [llvm] to \"\" to suppress this detection.\n\n",
 			*kbuild_dir);
 
-		free(*kbuild_dir);
-		*kbuild_dir = NULL;
+		zfree(kbuild_dir);
 		goto errout;
 	}
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index f523da3009e4..cf826eca3aaf 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -810,7 +810,7 @@ struct map *machine__findnew_module_map(struct machine *machine, u64 start,
 out:
 	/* put the dso here, corresponding to  machine__findnew_module_dso */
 	dso__put(dso);
-	free(m.name);
+	zfree(&m.name);
 	return map;
 }
 
@@ -1350,7 +1350,7 @@ static int map_groups__set_modules_path_dir(struct map_groups *mg,
 			if (m.kmod)
 				ret = map_groups__set_module_path(mg, path, &m);
 
-			free(m.name);
+			zfree(&m.name);
 
 			if (ret)
 				goto out;
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index d8164574cb16..0d8c840f88c0 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -18,6 +18,7 @@
 #include "strlist.h"
 #include <assert.h>
 #include <linux/ctype.h>
+#include <linux/zalloc.h>
 
 struct metric_event *metricgroup__lookup(struct rblist *metric_events,
 					 struct perf_evsel *evsel,
@@ -235,7 +236,7 @@ static struct rb_node *mep_new(struct rblist *rl __maybe_unused,
 		goto out_name;
 	return &me->nd;
 out_name:
-	free((char *)me->name);
+	zfree(&me->name);
 out_me:
 	free(me);
 	return NULL;
@@ -263,7 +264,7 @@ static void mep_delete(struct rblist *rl __maybe_unused,
 	struct mep *me = container_of(nd, struct mep, nd);
 
 	strlist__delete(me->metrics);
-	free((void *)me->name);
+	zfree(&me->name);
 	free(me);
 }
 
@@ -489,8 +490,8 @@ static void metricgroup__free_egroups(struct list_head *group_list)
 
 	list_for_each_entry_safe (eg, egtmp, group_list, nd) {
 		for (i = 0; i < eg->idnum; i++)
-			free((char *)eg->ids[i]);
-		free(eg->ids);
+			zfree(&eg->ids[i]);
+		zfree(&eg->ids);
 		free(eg);
 	}
 }
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 80c0eca0f1ee..0a57b316c4dd 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -214,9 +214,9 @@ static int convert_exec_to_group(const char *exec, char **result)
 
 static void clear_perf_probe_point(struct perf_probe_point *pp)
 {
-	free(pp->file);
-	free(pp->function);
-	free(pp->lazy_line);
+	zfree(&pp->file);
+	zfree(&pp->function);
+	zfree(&pp->lazy_line);
 }
 
 static void clear_probe_trace_events(struct probe_trace_event *tevs, int ntevs)
@@ -1175,12 +1175,11 @@ int show_available_vars(struct perf_probe_event *pevs __maybe_unused,
 
 void line_range__clear(struct line_range *lr)
 {
-	free(lr->function);
-	free(lr->file);
-	free(lr->path);
-	free(lr->comp_dir);
+	zfree(&lr->function);
+	zfree(&lr->file);
+	zfree(&lr->path);
+	zfree(&lr->comp_dir);
 	intlist__delete(lr->line_list);
-	memset(lr, 0, sizeof(*lr));
 }
 
 int line_range__init(struct line_range *lr)
@@ -2203,15 +2202,15 @@ void clear_perf_probe_event(struct perf_probe_event *pev)
 	struct perf_probe_arg_field *field, *next;
 	int i;
 
-	free(pev->event);
-	free(pev->group);
-	free(pev->target);
+	zfree(&pev->event);
+	zfree(&pev->group);
+	zfree(&pev->target);
 	clear_perf_probe_point(&pev->point);
 
 	for (i = 0; i < pev->nargs; i++) {
-		free(pev->args[i].name);
-		free(pev->args[i].var);
-		free(pev->args[i].type);
+		zfree(&pev->args[i].name);
+		zfree(&pev->args[i].var);
+		zfree(&pev->args[i].type);
 		field = pev->args[i].field;
 		while (field) {
 			next = field->next;
@@ -2220,8 +2219,7 @@ void clear_perf_probe_event(struct perf_probe_event *pev)
 			field = next;
 		}
 	}
-	free(pev->args);
-	memset(pev, 0, sizeof(*pev));
+	zfree(&pev->args);
 }
 
 #define strdup_or_goto(str, label)	\
@@ -2302,15 +2300,15 @@ void clear_probe_trace_event(struct probe_trace_event *tev)
 	struct probe_trace_arg_ref *ref, *next;
 	int i;
 
-	free(tev->event);
-	free(tev->group);
-	free(tev->point.symbol);
-	free(tev->point.realname);
-	free(tev->point.module);
+	zfree(&tev->event);
+	zfree(&tev->group);
+	zfree(&tev->point.symbol);
+	zfree(&tev->point.realname);
+	zfree(&tev->point.module);
 	for (i = 0; i < tev->nargs; i++) {
-		free(tev->args[i].name);
-		free(tev->args[i].value);
-		free(tev->args[i].type);
+		zfree(&tev->args[i].name);
+		zfree(&tev->args[i].value);
+		zfree(&tev->args[i].type);
 		ref = tev->args[i].ref;
 		while (ref) {
 			next = ref->next;
@@ -2318,8 +2316,7 @@ void clear_probe_trace_event(struct probe_trace_event *tev)
 			ref = next;
 		}
 	}
-	free(tev->args);
-	memset(tev, 0, sizeof(*tev));
+	zfree(&tev->args);
 }
 
 struct kprobe_blacklist_node {
@@ -2337,7 +2334,7 @@ static void kprobe_blacklist__delete(struct list_head *blacklist)
 		node = list_first_entry(blacklist,
 					struct kprobe_blacklist_node, list);
 		list_del(&node->list);
-		free(node->symbol);
+		zfree(&node->symbol);
 		free(node);
 	}
 }
diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index ea669702825d..cca9cb851d02 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -1044,7 +1044,7 @@ static void s390_cpumsf_free(struct perf_session *session)
 	auxtrace_heap__free(&sf->heap);
 	s390_cpumsf_free_queues(session);
 	session->auxtrace = NULL;
-	free(sf->logdir);
+	zfree(&sf->logdir);
 	free(sf);
 }
 
@@ -1101,8 +1101,7 @@ static int s390_cpumsf__config(const char *var, const char *value, void *cb)
 	if (rc == -1 || !S_ISDIR(stbuf.st_mode)) {
 		pr_err("Missing auxtrace log directory %s,"
 		       " continue with current directory...\n", value);
-		free(sf->logdir);
-		sf->logdir = NULL;
+		zfree(&sf->logdir);
 	}
 	return 1;
 }
@@ -1162,7 +1161,7 @@ int s390_cpumsf_process_auxtrace_info(union perf_event *event,
 	auxtrace_queues__free(&sf->queues);
 	session->auxtrace = NULL;
 err_free:
-	free(sf->logdir);
+	zfree(&sf->logdir);
 	free(sf);
 	return err;
 }
diff --git a/tools/perf/util/srccode.c b/tools/perf/util/srccode.c
index 684b155c222a..688a85a3d454 100644
--- a/tools/perf/util/srccode.c
+++ b/tools/perf/util/srccode.c
@@ -4,7 +4,8 @@
  * Copyright (c) 2017, Intel Corporation.
  * Author: Andi Kleen
  */
-#include "linux/list.h"
+#include <linux/list.h>
+#include <linux/zalloc.h>
 #include <stdlib.h>
 #include <sys/mman.h>
 #include <sys/stat.h>
@@ -86,8 +87,8 @@ static void free_srcfile(struct srcfile *sf)
 	hlist_del(&sf->hash_nd);
 	map_total_sz -= sf->maplen;
 	munmap(sf->map, sf->maplen);
-	free(sf->lines);
-	free(sf->fn);
+	zfree(&sf->lines);
+	zfree(&sf->fn);
 	free(sf);
 	num_srcfiles--;
 }
@@ -153,7 +154,7 @@ static struct srcfile *find_srcfile(char *fn)
 out_map:
 	munmap(h->map, sz);
 out_fn:
-	free(h->fn);
+	zfree(&h->fn);
 out_h:
 	free(h);
 	return NULL;
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index cb891e5c2969..656065af4971 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -8,6 +8,7 @@
 #include "evlist.h"
 #include "expr.h"
 #include "metricgroup.h"
+#include <linux/zalloc.h>
 
 /*
  * AGGR_GLOBAL: Use CPU 0
@@ -775,7 +776,7 @@ static void generic_metric(struct perf_stat_config *config,
 		print_metric(config, ctxp, NULL, NULL, "", 0);
 
 	for (i = 1; i < pctx.num_ids; i++)
-		free((void *)pctx.ids[i].name);
+		zfree(&pctx.ids[i].name);
 }
 
 void perf_stat__print_shadow_stats(struct perf_stat_config *config,
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index c967715c1d4c..db8a6cf336be 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -133,7 +133,7 @@ static void perf_evsel__free_stat_priv(struct perf_evsel *evsel)
 	struct perf_stat_evsel *ps = evsel->stats;
 
 	if (ps)
-		free(ps->group_data);
+		zfree(&ps->group_data);
 	zfree(&evsel->stats);
 }
 
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index ad683fbe9678..1d5447594f5d 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -2133,11 +2133,11 @@ static int populate_sdt_note(Elf **elf, const char *data, size_t len,
 	return 0;
 
 out_free_args:
-	free(tmp->args);
+	zfree(&tmp->args);
 out_free_name:
-	free(tmp->name);
+	zfree(&tmp->name);
 out_free_prov:
-	free(tmp->provider);
+	zfree(&tmp->provider);
 out_free_note:
 	free(tmp);
 out_err:
@@ -2253,8 +2253,8 @@ int cleanup_sdt_note_list(struct list_head *sdt_notes)
 
 	list_for_each_entry_safe(pos, tmp, sdt_notes, note_list) {
 		list_del(&pos->note_list);
-		free(pos->name);
-		free(pos->provider);
+		zfree(&pos->name);
+		zfree(&pos->provider);
 		free(pos);
 		nr_free++;
 	}
diff --git a/tools/perf/util/thread_map.c b/tools/perf/util/thread_map.c
index c291874352cf..5b3511f2b6b1 100644
--- a/tools/perf/util/thread_map.c
+++ b/tools/perf/util/thread_map.c
@@ -480,7 +480,7 @@ int thread_map__remove(struct thread_map *threads, int idx)
 	/*
 	 * Free the 'idx' item and shift the rest up.
 	 */
-	free(threads->map[idx].comm);
+	zfree(&threads->map[idx].comm);
 
 	for (i = idx; i < threads->nr - 1; i++)
 		threads->map[i] = threads->map[i + 1];
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index 25e1406b1f8b..71a788921b62 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -25,6 +25,7 @@
 #include <unistd.h>
 #include <sys/mman.h>
 #include <linux/list.h>
+#include <linux/zalloc.h>
 #ifndef REMOTE_UNWIND_LIBUNWIND
 #include <libunwind.h>
 #include <libunwind-ptrace.h>
@@ -345,7 +346,7 @@ static int read_unwind_spec_debug_frame(struct dso *dso,
 							__func__,
 							dso->symsrc_filename,
 							debuglink);
-					free(dso->symsrc_filename);
+					zfree(&dso->symsrc_filename);
 				}
 				dso->symsrc_filename = debuglink;
 			} else {
-- 
2.21.0

