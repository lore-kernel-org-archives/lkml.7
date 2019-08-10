Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FCDC32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 20:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EDDA2085B
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 20:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfHJUIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 16:08:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58356 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfHJUIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 16:08:06 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hwXek-0007tU-BR; Sat, 10 Aug 2019 22:08:02 +0200
Date:   Sat, 10 Aug 2019 20:01:51 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] perf/urgent for 5.3-rc4
References: <156546731194.17538.17422312639927927426.tglx@nanos.tec.linutronix.de>
Message-ID: <156546731194.17538.13243528151904723193.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

up to:  d7731b8133ad: Merge tag 'perf-urgent-for-mingo-5.3-20190808' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent

Perf tooling fixes all over the place:

 - Fix the selection of the main thread COMM in db-export

 - Fix the disassemmbly display for BPF in annotate

 - Fix cpumap mask setup in perf ftrace when only one CPU is present

 - Add the missing 'cpu_clk_unhalted.core' event

 - Fix CPU 0 bindings in NUMA benchmarks

 - Fix the module size calculations for s390

 - Handle the gap between kernel end and module start on s390 correctly

 - Build and typo fixes

Thanks,

	tglx

------------------>
Adrian Hunter (1):
      perf db-export: Fix thread__exec_comm()

Arnaldo Carvalho de Melo (1):
      perf annotate: Fix printing of unaugmented disassembled instructions from BPF

He Zhe (2):
      perf ftrace: Fix failure to set cpumask when only one cpu is present
      perf cpumap: Fix writing to illegal memory in handling cpumap mask

Ian Rogers (1):
      perf tools: Fix include paths in ui directory

Jin Yao (1):
      perf pmu-events: Fix missing "cpu_clk_unhalted.core" event

Jiri Olsa (1):
      perf bench numa: Fix cpu0 binding

Masanari Iida (1):
      perf tools: Fix a typo in a variable name in the Documentation Makefile

Thomas Richter (2):
      perf record: Fix module size on s390
      perf annotate: Fix s390 gap between kernel end and module start


 tools/perf/Documentation/Makefile   |  2 +-
 tools/perf/arch/s390/util/machine.c | 31 ++++++++++++++++++++++++++++++-
 tools/perf/bench/numa.c             |  6 ++++--
 tools/perf/builtin-ftrace.c         |  2 +-
 tools/perf/pmu-events/jevents.c     |  1 +
 tools/perf/ui/browser.c             |  9 +++++----
 tools/perf/ui/tui/progress.c        |  2 +-
 tools/perf/util/annotate.c          |  2 +-
 tools/perf/util/cpumap.c            |  5 ++++-
 tools/perf/util/machine.c           |  3 ++-
 tools/perf/util/machine.h           |  2 +-
 tools/perf/util/symbol.c            |  7 ++++++-
 tools/perf/util/symbol.h            |  1 +
 tools/perf/util/thread.c            | 12 +++++++++++-
 14 files changed, 69 insertions(+), 16 deletions(-)

diff --git a/tools/perf/Documentation/Makefile b/tools/perf/Documentation/Makefile
index 6d148a40551c..adc5a7e44b98 100644
--- a/tools/perf/Documentation/Makefile
+++ b/tools/perf/Documentation/Makefile
@@ -242,7 +242,7 @@ $(OUTPUT)doc.dep : $(wildcard *.txt) build-docdep.perl
 	$(PERL_PATH) ./build-docdep.perl >$@+ $(QUIET_STDERR) && \
 	mv $@+ $@
 
--include $(OUPTUT)doc.dep
+-include $(OUTPUT)doc.dep
 
 _cmds_txt = cmds-ancillaryinterrogators.txt \
 	cmds-ancillarymanipulators.txt \
diff --git a/tools/perf/arch/s390/util/machine.c b/tools/perf/arch/s390/util/machine.c
index a19690a17291..c8c86a0c9b79 100644
--- a/tools/perf/arch/s390/util/machine.c
+++ b/tools/perf/arch/s390/util/machine.c
@@ -6,8 +6,9 @@
 #include "machine.h"
 #include "api/fs/fs.h"
 #include "debug.h"
+#include "symbol.h"
 
-int arch__fix_module_text_start(u64 *start, const char *name)
+int arch__fix_module_text_start(u64 *start, u64 *size, const char *name)
 {
 	u64 m_start = *start;
 	char path[PATH_MAX];
@@ -17,7 +18,35 @@ int arch__fix_module_text_start(u64 *start, const char *name)
 	if (sysfs__read_ull(path, (unsigned long long *)start) < 0) {
 		pr_debug2("Using module %s start:%#lx\n", path, m_start);
 		*start = m_start;
+	} else {
+		/* Successful read of the modules segment text start address.
+		 * Calculate difference between module start address
+		 * in memory and module text segment start address.
+		 * For example module load address is 0x3ff8011b000
+		 * (from /proc/modules) and module text segment start
+		 * address is 0x3ff8011b870 (from file above).
+		 *
+		 * Adjust the module size and subtract the GOT table
+		 * size located at the beginning of the module.
+		 */
+		*size -= (*start - m_start);
 	}
 
 	return 0;
 }
+
+/* On s390 kernel text segment start is located at very low memory addresses,
+ * for example 0x10000. Modules are located at very high memory addresses,
+ * for example 0x3ff xxxx xxxx. The gap between end of kernel text segment
+ * and beginning of first module's text segment is very big.
+ * Therefore do not fill this gap and do not assign it to the kernel dso map.
+ */
+void arch__symbols__fixup_end(struct symbol *p, struct symbol *c)
+{
+	if (strchr(p->name, '[') == NULL && strchr(c->name, '['))
+		/* Last kernel symbol mapped to end of page */
+		p->end = roundup(p->end, page_size);
+	else
+		p->end = c->start;
+	pr_debug4("%s sym:%s end:%#lx\n", __func__, p->name, p->end);
+}
diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index a640ca7aaada..513cb2f2fa32 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -379,8 +379,10 @@ static u8 *alloc_data(ssize_t bytes0, int map_flags,
 
 	/* Allocate and initialize all memory on CPU#0: */
 	if (init_cpu0) {
-		orig_mask = bind_to_node(0);
-		bind_to_memnode(0);
+		int node = numa_node_of_cpu(0);
+
+		orig_mask = bind_to_node(node);
+		bind_to_memnode(node);
 	}
 
 	bytes = bytes0 + HPSIZE;
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 66d5a6658daf..019312810405 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -173,7 +173,7 @@ static int set_tracing_cpumask(struct cpu_map *cpumap)
 	int last_cpu;
 
 	last_cpu = cpu_map__cpu(cpumap, cpumap->nr - 1);
-	mask_size = (last_cpu + 3) / 4 + 1;
+	mask_size = last_cpu / 4 + 2; /* one more byte for EOS */
 	mask_size += last_cpu / 32; /* ',' is needed for every 32th cpus */
 
 	cpumask = malloc(mask_size);
diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 1a91a197cafb..d413761621b0 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -453,6 +453,7 @@ static struct fixed {
 	{ "inst_retired.any_p", "event=0xc0" },
 	{ "cpu_clk_unhalted.ref", "event=0x0,umask=0x03" },
 	{ "cpu_clk_unhalted.thread", "event=0x3c" },
+	{ "cpu_clk_unhalted.core", "event=0x3c" },
 	{ "cpu_clk_unhalted.thread_any", "event=0x3c,any=1" },
 	{ NULL, NULL},
 };
diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
index f80c51d53565..d227d74b28f8 100644
--- a/tools/perf/ui/browser.c
+++ b/tools/perf/ui/browser.c
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "../string2.h"
-#include "../config.h"
-#include "../../perf.h"
+#include "../util/util.h"
+#include "../util/string2.h"
+#include "../util/config.h"
+#include "../perf.h"
 #include "libslang.h"
 #include "ui.h"
 #include "util.h"
@@ -14,7 +15,7 @@
 #include "browser.h"
 #include "helpline.h"
 #include "keysyms.h"
-#include "../color.h"
+#include "../util/color.h"
 #include <linux/ctype.h>
 #include <linux/zalloc.h>
 
diff --git a/tools/perf/ui/tui/progress.c b/tools/perf/ui/tui/progress.c
index bc134b82829d..5a24dd3ce4db 100644
--- a/tools/perf/ui/tui/progress.c
+++ b/tools/perf/ui/tui/progress.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/kernel.h>
-#include "../cache.h"
+#include "../../util/cache.h"
 #include "../progress.h"
 #include "../libslang.h"
 #include "../ui.h"
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index ac9ad2330f93..163536720149 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1122,7 +1122,7 @@ static int disasm_line__parse(char *line, const char **namep, char **rawp)
 		goto out;
 
 	(*rawp)[0] = tmp;
-	*rawp = skip_spaces(*rawp);
+	*rawp = strim(*rawp);
 
 	return 0;
 
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 3acfbe34ebaf..39cce66b4ebc 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -751,7 +751,10 @@ size_t cpu_map__snprint_mask(struct cpu_map *map, char *buf, size_t size)
 	unsigned char *bitmap;
 	int last_cpu = cpu_map__cpu(map, map->nr - 1);
 
-	bitmap = zalloc((last_cpu + 7) / 8);
+	if (buf == NULL)
+		return 0;
+
+	bitmap = zalloc(last_cpu / 8 + 1);
 	if (bitmap == NULL) {
 		buf[0] = '\0';
 		return 0;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index cf826eca3aaf..83b2fbbeeb90 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1378,6 +1378,7 @@ static int machine__set_modules_path(struct machine *machine)
 	return map_groups__set_modules_path_dir(&machine->kmaps, modules_path, 0);
 }
 int __weak arch__fix_module_text_start(u64 *start __maybe_unused,
+				u64 *size __maybe_unused,
 				const char *name __maybe_unused)
 {
 	return 0;
@@ -1389,7 +1390,7 @@ static int machine__create_module(void *arg, const char *name, u64 start,
 	struct machine *machine = arg;
 	struct map *map;
 
-	if (arch__fix_module_text_start(&start, name) < 0)
+	if (arch__fix_module_text_start(&start, &size, name) < 0)
 		return -1;
 
 	map = machine__findnew_module_map(machine, start, name);
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index f70ab98a7bde..7aa38da26427 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -222,7 +222,7 @@ struct symbol *machine__find_kernel_symbol_by_name(struct machine *machine,
 
 struct map *machine__findnew_module_map(struct machine *machine, u64 start,
 					const char *filename);
-int arch__fix_module_text_start(u64 *start, const char *name);
+int arch__fix_module_text_start(u64 *start, u64 *size, const char *name);
 
 int machine__load_kallsyms(struct machine *machine, const char *filename);
 
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 173f3378aaa0..4efde7879474 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -92,6 +92,11 @@ static int prefix_underscores_count(const char *str)
 	return tail - str;
 }
 
+void __weak arch__symbols__fixup_end(struct symbol *p, struct symbol *c)
+{
+	p->end = c->start;
+}
+
 const char * __weak arch__normalize_symbol_name(const char *name)
 {
 	return name;
@@ -218,7 +223,7 @@ void symbols__fixup_end(struct rb_root_cached *symbols)
 		curr = rb_entry(nd, struct symbol, rb_node);
 
 		if (prev->end == prev->start && prev->end != curr->start)
-			prev->end = curr->start;
+			arch__symbols__fixup_end(prev, curr);
 	}
 
 	/* Last entry */
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 12755b42ea93..183f630cb5f1 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -288,6 +288,7 @@ const char *arch__normalize_symbol_name(const char *name);
 #define SYMBOL_A 0
 #define SYMBOL_B 1
 
+void arch__symbols__fixup_end(struct symbol *p, struct symbol *c);
 int arch__compare_symbol_names(const char *namea, const char *nameb);
 int arch__compare_symbol_names_n(const char *namea, const char *nameb,
 				 unsigned int n);
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 873ab505ca80..590793cc5142 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -214,14 +214,24 @@ struct comm *thread__comm(const struct thread *thread)
 
 struct comm *thread__exec_comm(const struct thread *thread)
 {
-	struct comm *comm, *last = NULL;
+	struct comm *comm, *last = NULL, *second_last = NULL;
 
 	list_for_each_entry(comm, &thread->comm_list, list) {
 		if (comm->exec)
 			return comm;
+		second_last = last;
 		last = comm;
 	}
 
+	/*
+	 * 'last' with no start time might be the parent's comm of a synthesized
+	 * thread (created by processing a synthesized fork event). For a main
+	 * thread, that is very probably wrong. Prefer a later comm to avoid
+	 * that case.
+	 */
+	if (second_last && !last->start && thread->pid_ == thread->tid)
+		return second_last;
+
 	return last;
 }
 

