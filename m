Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421E7C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 11:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D05F0207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 11:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbfCJLeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 07:34:09 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36409 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbfCJLeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 07:34:07 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h2wiC-000065-GG; Sun, 10 Mar 2019 12:33:49 +0100
Subject: [GIT pull] perf updates for 5.1
Message-ID: <155221755097.13878.7644048900738327284.tglx@nanos.tec.linutronix.de>
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
References: <155221755096.13878.3370977359110476046.tglx@nanos.tec.linutronix.de>
Date:   Sun, 10 Mar 2019 12:33:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

Perf updates and fixes:

 Kernel:
 - Handle events which have the bpf_event attribute set as side band events
   as they carry information about BPF programs.
 - Add missing switch-case fall-through comments

 Libraries:
 - Fix leaks and double frees in error code paths.
 - Prevent buffer overflows in libtraceevent

 Tools:
 - Improvements in handling Intel BT/PTS
 - Add BTF ELF markers to perf trace BPF programs to improve output
 - Support --time, --cpu, --pid and --tid filters for perf diff
 - Calculate the column width in perf annotate as the hardcoded 6 characters
   for the instruction are not sufficient
 - Small fixes all over the place

Thanks,

	tglx

------------------>
Adrian Hunter (10):
      perf auxtrace: Improve address filter error message when there is no DSO
      perf intel-pt: Fix divide by zero when TSC is not available
      perf db-export: Add calls parent_id to enable creation of call trees
      perf scripts python: export-to-sqlite.py: Export calls parent_id
      perf scripts python: export-to-postgresql.py: Fix invalid input syntax for integer error
      perf scripts python: export-to-postgresql.py: Export calls parent_id
      perf scripts python: exported-sql-viewer.py: Factor out TreeWindowBase
      perf scripts python: exported-sql-viewer.py: Improve TreeModel abstraction
      perf scripts python: exported-sql-viewer.py: Factor out CallGraphModelBase
      perf scripts python: exported-sql-viewer.py: Add call tree

Alexander Shishkin (1):
      perf/ring_buffer: Use high order allocations for AUX buffers optimistically

Andi Kleen (1):
      perf thread: Generalize function to copy from thread addr space from intel-bts code

Arnaldo Carvalho de Melo (4):
      perf probe: Clarify error message about not finding kernel modules debuginfo
      perf beauty msg_flags: Add missing %s lost when adding prefix suppression logic
      perf bpf: Automatically add BTF ELF markers
      perf annotate: Calculate the max instruction name, align column to that

Gustavo A. R. Silva (2):
      perf: Mark expected switch fall-through
      perf/core: Mark expected switch fall-through

Jin Yao (4):
      perf time-utils: Refactor time range parsing code
      perf diff: Support --time filter option
      perf diff: Support --cpu filter option
      perf diff: Support --pid/--tid filter options

Jiri Olsa (7):
      perf c2c: Fix c2c report for empty numa node
      perf hist: Add error path into hist_entry__init
      perf hist: Fix memory leak of srcline
      perf tools: Read and store caps/max_precise in perf_pmu
      perf evsel: Probe for precise_ip with simple attr
      perf session: Fix double free in perf_data__close
      perf data: Force perf_data__open|close zero data->file.path

Kan Liang (1):
      perf/x86/intel/uncore: Fix client IMC events return huge result

Song Liu (1):
      perf, bpf: Consider events with attr.bpf_event as side-band events

Tony Jones (6):
      tools lib traceevent: Fix buffer overflow in arg_eval
      perf script python: Remove mixed indentation
      perf script python: Add Python3 support to futex-contention.py
      perf script python: add Python3 support to check-perf-trace.py
      perf script python: Add Python3 support to event_analyzing_sample.py
      perf script python: Add Python3 support to intel-pt-events.py

Yang Wei (1):
      perf clang: Remove needless extra semicolon


 arch/x86/events/intel/uncore.c                     |   1 +
 arch/x86/events/intel/uncore.h                     |  12 +-
 arch/x86/events/intel/uncore_snb.c                 |   4 +-
 kernel/events/core.c                               |   4 +-
 kernel/events/ring_buffer.c                        |  32 +-
 tools/lib/traceevent/event-parse.c                 |   2 +-
 tools/perf/Documentation/perf-diff.txt             |  56 ++++
 tools/perf/arch/arm64/annotate/instructions.c      |   2 +-
 tools/perf/arch/s390/annotate/instructions.c       |   2 +-
 tools/perf/builtin-c2c.c                           |   8 +-
 tools/perf/builtin-diff.c                          | 168 +++++++++-
 tools/perf/builtin-report.c                        |  38 +--
 tools/perf/builtin-script.c                        |  39 +--
 tools/perf/include/bpf/bpf.h                       |   8 +-
 tools/perf/scripts/python/check-perf-trace.py      |  76 ++---
 tools/perf/scripts/python/compaction-times.py      |   8 +-
 .../perf/scripts/python/event_analyzing_sample.py  |  48 +--
 tools/perf/scripts/python/export-to-postgresql.py  |  16 +-
 tools/perf/scripts/python/export-to-sqlite.py      |  12 +-
 tools/perf/scripts/python/exported-sql-viewer.py   | 354 ++++++++++++++++-----
 .../perf/scripts/python/failed-syscalls-by-pid.py  |  38 +--
 tools/perf/scripts/python/futex-contention.py      |  10 +-
 tools/perf/scripts/python/intel-pt-events.py       |  60 ++--
 tools/perf/scripts/python/mem-phys-addr.py         |   7 +-
 tools/perf/scripts/python/net_dropmonitor.py       |   2 +-
 tools/perf/scripts/python/netdev-times.py          |  12 +-
 tools/perf/scripts/python/sched-migration.py       |   6 +-
 tools/perf/scripts/python/sctop.py                 |  13 +-
 tools/perf/scripts/python/stackcollapse.py         |   2 +-
 tools/perf/scripts/python/syscall-counts-by-pid.py |  47 ++-
 tools/perf/scripts/python/syscall-counts.py        |  31 +-
 tools/perf/trace/beauty/msg_flags.c                |   2 +-
 tools/perf/util/annotate.c                         |  74 +++--
 tools/perf/util/annotate.h                         |   7 +-
 tools/perf/util/auxtrace.c                         |   3 +-
 tools/perf/util/c++/clang.cpp                      |   2 +-
 tools/perf/util/data.c                             |   4 +-
 tools/perf/util/db-export.c                        |  15 +-
 tools/perf/util/db-export.h                        |   3 +-
 tools/perf/util/evlist.c                           |  25 +-
 tools/perf/util/evsel.c                            |   8 -
 tools/perf/util/hist.c                             |  51 +--
 tools/perf/util/intel-bts.c                        |  20 +-
 tools/perf/util/intel-pt.c                         |   2 +
 tools/perf/util/pmu.c                              |  14 +
 tools/perf/util/pmu.h                              |   1 +
 tools/perf/util/probe-event.c                      |   9 +-
 .../util/scripting-engines/trace-event-python.c    |   8 +-
 tools/perf/util/session.c                          |   4 +-
 tools/perf/util/thread-stack.c                     |  16 +-
 tools/perf/util/thread-stack.h                     |   6 +-
 tools/perf/util/thread.c                           |  23 ++
 tools/perf/util/thread.h                           |   3 +
 tools/perf/util/time-utils.c                       |  51 ++-
 tools/perf/util/time-utils.h                       |   6 +
 55 files changed, 1003 insertions(+), 472 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index d516161c00c4..9fe64c01a2e5 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -732,6 +732,7 @@ static int uncore_pmu_event_init(struct perf_event *event)
 		/* fixed counters have event field hardcoded to zero */
 		hwc->config = 0ULL;
 	} else if (is_freerunning_event(event)) {
+		hwc->config = event->attr.config;
 		if (!check_valid_freerunning_event(box, event))
 			return -EINVAL;
 		event->hw.idx = UNCORE_PMC_IDX_FREERUNNING;
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index cb46d602a6b8..853a49a8ccf6 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -292,8 +292,8 @@ static inline
 unsigned int uncore_freerunning_counter(struct intel_uncore_box *box,
 					struct perf_event *event)
 {
-	unsigned int type = uncore_freerunning_type(event->attr.config);
-	unsigned int idx = uncore_freerunning_idx(event->attr.config);
+	unsigned int type = uncore_freerunning_type(event->hw.config);
+	unsigned int idx = uncore_freerunning_idx(event->hw.config);
 	struct intel_uncore_pmu *pmu = box->pmu;
 
 	return pmu->type->freerunning[type].counter_base +
@@ -377,7 +377,7 @@ static inline
 unsigned int uncore_freerunning_bits(struct intel_uncore_box *box,
 				     struct perf_event *event)
 {
-	unsigned int type = uncore_freerunning_type(event->attr.config);
+	unsigned int type = uncore_freerunning_type(event->hw.config);
 
 	return box->pmu->type->freerunning[type].bits;
 }
@@ -385,7 +385,7 @@ unsigned int uncore_freerunning_bits(struct intel_uncore_box *box,
 static inline int uncore_num_freerunning(struct intel_uncore_box *box,
 					 struct perf_event *event)
 {
-	unsigned int type = uncore_freerunning_type(event->attr.config);
+	unsigned int type = uncore_freerunning_type(event->hw.config);
 
 	return box->pmu->type->freerunning[type].num_counters;
 }
@@ -399,8 +399,8 @@ static inline int uncore_num_freerunning_types(struct intel_uncore_box *box,
 static inline bool check_valid_freerunning_event(struct intel_uncore_box *box,
 						 struct perf_event *event)
 {
-	unsigned int type = uncore_freerunning_type(event->attr.config);
-	unsigned int idx = uncore_freerunning_idx(event->attr.config);
+	unsigned int type = uncore_freerunning_type(event->hw.config);
+	unsigned int idx = uncore_freerunning_idx(event->hw.config);
 
 	return (type < uncore_num_freerunning_types(box, event)) &&
 	       (idx < uncore_num_freerunning(box, event));
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index b12517fae77a..13493f43b247 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -442,9 +442,11 @@ static int snb_uncore_imc_event_init(struct perf_event *event)
 
 	/* must be done before validate_group */
 	event->hw.event_base = base;
-	event->hw.config = cfg;
 	event->hw.idx = idx;
 
+	/* Convert to standard encoding format for freerunning counters */
+	event->hw.config = ((cfg - 1) << 8) | 0x10ff;
+
 	/* no group validation needed, we have free running counters */
 
 	return 0;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5f59d848171e..6fb27b564730 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4238,7 +4238,8 @@ static bool is_sb_event(struct perf_event *event)
 	if (attr->mmap || attr->mmap_data || attr->mmap2 ||
 	    attr->comm || attr->comm_exec ||
 	    attr->task || attr->ksymbol ||
-	    attr->context_switch)
+	    attr->context_switch ||
+	    attr->bpf_event)
 		return true;
 	return false;
 }
@@ -9174,6 +9175,7 @@ perf_event_parse_addr_filter(struct perf_event *event, char *fstr,
 		case IF_SRC_KERNELADDR:
 		case IF_SRC_KERNEL:
 			kernel = 1;
+			/* fall through */
 
 		case IF_SRC_FILEADDR:
 		case IF_SRC_FILE:
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 678ccec60d8f..a4047321d7d8 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -598,29 +598,27 @@ int rb_alloc_aux(struct ring_buffer *rb, struct perf_event *event,
 {
 	bool overwrite = !(flags & RING_BUFFER_WRITABLE);
 	int node = (event->cpu == -1) ? -1 : cpu_to_node(event->cpu);
-	int ret = -ENOMEM, max_order = 0;
+	int ret = -ENOMEM, max_order;
 
 	if (!has_aux(event))
 		return -EOPNOTSUPP;
 
-	if (event->pmu->capabilities & PERF_PMU_CAP_AUX_NO_SG) {
-		/*
-		 * We need to start with the max_order that fits in nr_pages,
-		 * not the other way around, hence ilog2() and not get_order.
-		 */
-		max_order = ilog2(nr_pages);
+	/*
+	 * We need to start with the max_order that fits in nr_pages,
+	 * not the other way around, hence ilog2() and not get_order.
+	 */
+	max_order = ilog2(nr_pages);
 
-		/*
-		 * PMU requests more than one contiguous chunks of memory
-		 * for SW double buffering
-		 */
-		if ((event->pmu->capabilities & PERF_PMU_CAP_AUX_SW_DOUBLEBUF) &&
-		    !overwrite) {
-			if (!max_order)
-				return -EINVAL;
+	/*
+	 * PMU requests more than one contiguous chunks of memory
+	 * for SW double buffering
+	 */
+	if ((event->pmu->capabilities & PERF_PMU_CAP_AUX_SW_DOUBLEBUF) &&
+	    !overwrite) {
+		if (!max_order)
+			return -EINVAL;
 
-			max_order--;
-		}
+		max_order--;
 	}
 
 	rb->aux_pages = kcalloc_node(nr_pages, sizeof(void *), GFP_KERNEL,
diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index abd4fa5d3088..87494c7c619d 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -2457,7 +2457,7 @@ static int arg_num_eval(struct tep_print_arg *arg, long long *val)
 static char *arg_eval (struct tep_print_arg *arg)
 {
 	long long val;
-	static char buf[20];
+	static char buf[24];
 
 	switch (arg->type) {
 	case TEP_PRINT_ATOM:
diff --git a/tools/perf/Documentation/perf-diff.txt b/tools/perf/Documentation/perf-diff.txt
index a79c84ae61aa..da7809b15cc9 100644
--- a/tools/perf/Documentation/perf-diff.txt
+++ b/tools/perf/Documentation/perf-diff.txt
@@ -118,6 +118,62 @@ OPTIONS
 	sum of shown entries will be always 100%.  "absolute" means it retains
 	the original value before and after the filter is applied.
 
+--time::
+	Analyze samples within given time window. It supports time
+	percent with multiple time ranges. Time string is 'a%/n,b%/m,...'
+	or 'a%-b%,c%-%d,...'.
+
+	For example:
+
+	Select the second 10% time slice to diff:
+
+	  perf diff --time 10%/2
+
+	Select from 0% to 10% time slice to diff:
+
+	  perf diff --time 0%-10%
+
+	Select the first and the second 10% time slices to diff:
+
+	  perf diff --time 10%/1,10%/2
+
+	Select from 0% to 10% and 30% to 40% slices to diff:
+
+	  perf diff --time 0%-10%,30%-40%
+
+	It also supports analyzing samples within a given time window
+	<start>,<stop>. Times have the format seconds.microseconds. If 'start'
+	is not given (i.e., time string is ',x.y') then analysis starts at
+	the beginning of the file. If stop time is not given (i.e, time
+	string is 'x.y,') then analysis goes to the end of the file. Time string is
+	'a1.b1,c1.d1:a2.b2,c2.d2'. Use ':' to separate timestamps for different
+	perf.data files.
+
+	For example, we get the timestamp information from 'perf script'.
+
+	  perf script -i perf.data.old
+	    mgen 13940 [000]  3946.361400: ...
+
+	  perf script -i perf.data
+	    mgen 13940 [000]  3971.150589 ...
+
+	  perf diff --time 3946.361400,:3971.150589,
+
+	It analyzes the perf.data.old from the timestamp 3946.361400 to
+	the end of perf.data.old and analyzes the perf.data from the
+	timestamp 3971.150589 to the end of perf.data.
+
+--cpu:: Only diff samples for the list of CPUs provided. Multiple CPUs can
+	be provided as a comma-separated list with no space: 0,1. Ranges of
+	CPUs are specified with -: 0-2. Default is to report samples on all
+	CPUs.
+
+--pid=::
+	Only diff samples for given process ID (comma separated list).
+
+--tid=::
+	Only diff samples for given thread ID (comma separated list).
+
 COMPARISON
 ----------
 The comparison is governed by the baseline file. The baseline perf.data
diff --git a/tools/perf/arch/arm64/annotate/instructions.c b/tools/perf/arch/arm64/annotate/instructions.c
index 76c6345a57d5..8f70a1b282df 100644
--- a/tools/perf/arch/arm64/annotate/instructions.c
+++ b/tools/perf/arch/arm64/annotate/instructions.c
@@ -58,7 +58,7 @@ static int arm64_mov__parse(struct arch *arch __maybe_unused,
 }
 
 static int mov__scnprintf(struct ins *ins, char *bf, size_t size,
-			  struct ins_operands *ops);
+			  struct ins_operands *ops, int max_ins_name);
 
 static struct ins_ops arm64_mov_ops = {
 	.parse	   = arm64_mov__parse,
diff --git a/tools/perf/arch/s390/annotate/instructions.c b/tools/perf/arch/s390/annotate/instructions.c
index de0dd66dbb48..89bb8f2c54ce 100644
--- a/tools/perf/arch/s390/annotate/instructions.c
+++ b/tools/perf/arch/s390/annotate/instructions.c
@@ -46,7 +46,7 @@ static int s390_call__parse(struct arch *arch, struct ins_operands *ops,
 }
 
 static int call__scnprintf(struct ins *ins, char *bf, size_t size,
-			   struct ins_operands *ops);
+			   struct ins_operands *ops, int max_ins_name);
 
 static struct ins_ops s390_call_ops = {
 	.parse	   = s390_call__parse,
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 4272763a5e96..9e6cc868bdb4 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2056,6 +2056,12 @@ static int setup_nodes(struct perf_session *session)
 		if (!set)
 			return -ENOMEM;
 
+		nodes[node] = set;
+
+		/* empty node, skip */
+		if (cpu_map__empty(map))
+			continue;
+
 		for (cpu = 0; cpu < map->nr; cpu++) {
 			set_bit(map->map[cpu], set);
 
@@ -2064,8 +2070,6 @@ static int setup_nodes(struct perf_session *session)
 
 			cpu2node[map->map[cpu]] = node;
 		}
-
-		nodes[node] = set;
 	}
 
 	setup_nodes_header();
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 58fe0e88215c..6e7920793729 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -19,12 +19,21 @@
 #include "util/util.h"
 #include "util/data.h"
 #include "util/config.h"
+#include "util/time-utils.h"
 
 #include <errno.h>
 #include <inttypes.h>
 #include <stdlib.h>
 #include <math.h>
 
+struct perf_diff {
+	struct perf_tool		 tool;
+	const char			*time_str;
+	struct perf_time_interval	*ptime_range;
+	int				 range_size;
+	int				 range_num;
+};
+
 /* Diff command specific HPP columns. */
 enum {
 	PERF_HPP_DIFF__BASELINE,
@@ -74,6 +83,9 @@ static unsigned int sort_compute = 1;
 static s64 compute_wdiff_w1;
 static s64 compute_wdiff_w2;
 
+static const char		*cpu_list;
+static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
+
 enum {
 	COMPUTE_DELTA,
 	COMPUTE_RATIO,
@@ -323,22 +335,33 @@ static int formula_fprintf(struct hist_entry *he, struct hist_entry *pair,
 	return -1;
 }
 
-static int diff__process_sample_event(struct perf_tool *tool __maybe_unused,
+static int diff__process_sample_event(struct perf_tool *tool,
 				      union perf_event *event,
 				      struct perf_sample *sample,
 				      struct perf_evsel *evsel,
 				      struct machine *machine)
 {
+	struct perf_diff *pdiff = container_of(tool, struct perf_diff, tool);
 	struct addr_location al;
 	struct hists *hists = evsel__hists(evsel);
 	int ret = -1;
 
+	if (perf_time__ranges_skip_sample(pdiff->ptime_range, pdiff->range_num,
+					  sample->time)) {
+		return 0;
+	}
+
 	if (machine__resolve(machine, &al, sample) < 0) {
 		pr_warning("problem processing %d event, skipping it.\n",
 			   event->header.type);
 		return -1;
 	}
 
+	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap)) {
+		ret = 0;
+		goto out_put;
+	}
+
 	if (!hists__add_entry(hists, &al, NULL, NULL, NULL, sample, true)) {
 		pr_warning("problem incrementing symbol period, skipping event\n");
 		goto out_put;
@@ -359,17 +382,19 @@ static int diff__process_sample_event(struct perf_tool *tool __maybe_unused,
 	return ret;
 }
 
-static struct perf_tool tool = {
-	.sample	= diff__process_sample_event,
-	.mmap	= perf_event__process_mmap,
-	.mmap2	= perf_event__process_mmap2,
-	.comm	= perf_event__process_comm,
-	.exit	= perf_event__process_exit,
-	.fork	= perf_event__process_fork,
-	.lost	= perf_event__process_lost,
-	.namespaces = perf_event__process_namespaces,
-	.ordered_events = true,
-	.ordering_requires_timestamps = true,
+static struct perf_diff pdiff = {
+	.tool = {
+		.sample	= diff__process_sample_event,
+		.mmap	= perf_event__process_mmap,
+		.mmap2	= perf_event__process_mmap2,
+		.comm	= perf_event__process_comm,
+		.exit	= perf_event__process_exit,
+		.fork	= perf_event__process_fork,
+		.lost	= perf_event__process_lost,
+		.namespaces = perf_event__process_namespaces,
+		.ordered_events = true,
+		.ordering_requires_timestamps = true,
+	},
 };
 
 static struct perf_evsel *evsel_match(struct perf_evsel *evsel,
@@ -771,19 +796,117 @@ static void data__free(struct data__file *d)
 	}
 }
 
+static int abstime_str_dup(char **pstr)
+{
+	char *str = NULL;
+
+	if (pdiff.time_str && strchr(pdiff.time_str, ':')) {
+		str = strdup(pdiff.time_str);
+		if (!str)
+			return -ENOMEM;
+	}
+
+	*pstr = str;
+	return 0;
+}
+
+static int parse_absolute_time(struct data__file *d, char **pstr)
+{
+	char *p = *pstr;
+	int ret;
+
+	/*
+	 * Absolute timestamp for one file has the format: a.b,c.d
+	 * For multiple files, the format is: a.b,c.d:a.b,c.d
+	 */
+	p = strchr(*pstr, ':');
+	if (p) {
+		if (p == *pstr) {
+			pr_err("Invalid time string\n");
+			return -EINVAL;
+		}
+
+		*p = 0;
+		p++;
+		if (*p == 0) {
+			pr_err("Invalid time string\n");
+			return -EINVAL;
+		}
+	}
+
+	ret = perf_time__parse_for_ranges(*pstr, d->session,
+					  &pdiff.ptime_range,
+					  &pdiff.range_size,
+					  &pdiff.range_num);
+	if (ret < 0)
+		return ret;
+
+	if (!p || *p == 0)
+		*pstr = NULL;
+	else
+		*pstr = p;
+
+	return ret;
+}
+
+static int parse_percent_time(struct data__file *d)
+{
+	int ret;
+
+	ret = perf_time__parse_for_ranges(pdiff.time_str, d->session,
+					  &pdiff.ptime_range,
+					  &pdiff.range_size,
+					  &pdiff.range_num);
+	return ret;
+}
+
+static int parse_time_str(struct data__file *d, char *abstime_ostr,
+			   char **pabstime_tmp)
+{
+	int ret = 0;
+
+	if (abstime_ostr)
+		ret = parse_absolute_time(d, pabstime_tmp);
+	else if (pdiff.time_str)
+		ret = parse_percent_time(d);
+
+	return ret;
+}
+
 static int __cmd_diff(void)
 {
 	struct data__file *d;
-	int ret = -EINVAL, i;
+	int ret, i;
+	char *abstime_ostr, *abstime_tmp;
+
+	ret = abstime_str_dup(&abstime_ostr);
+	if (ret)
+		return ret;
+
+	abstime_tmp = abstime_ostr;
+	ret = -EINVAL;
 
 	data__for_each_file(i, d) {
-		d->session = perf_session__new(&d->data, false, &tool);
+		d->session = perf_session__new(&d->data, false, &pdiff.tool);
 		if (!d->session) {
 			pr_err("Failed to open %s\n", d->data.path);
 			ret = -1;
 			goto out_delete;
 		}
 
+		if (pdiff.time_str) {
+			ret = parse_time_str(d, abstime_ostr, &abstime_tmp);
+			if (ret < 0)
+				goto out_delete;
+		}
+
+		if (cpu_list) {
+			ret = perf_session__cpu_bitmap(d->session, cpu_list,
+						       cpu_bitmap);
+			if (ret < 0)
+				goto out_delete;
+		}
+
 		ret = perf_session__process_events(d->session);
 		if (ret) {
 			pr_err("Failed to process %s\n", d->data.path);
@@ -791,6 +914,9 @@ static int __cmd_diff(void)
 		}
 
 		perf_evlist__collapse_resort(d->session->evlist);
+
+		if (pdiff.ptime_range)
+			zfree(&pdiff.ptime_range);
 	}
 
 	data_process();
@@ -802,6 +928,13 @@ static int __cmd_diff(void)
 	}
 
 	free(data__files);
+
+	if (pdiff.ptime_range)
+		zfree(&pdiff.ptime_range);
+
+	if (abstime_ostr)
+		free(abstime_ostr);
+
 	return ret;
 }
 
@@ -849,6 +982,13 @@ static const struct option options[] = {
 	OPT_UINTEGER('o', "order", &sort_compute, "Specify compute sorting."),
 	OPT_CALLBACK(0, "percentage", NULL, "relative|absolute",
 		     "How to display percentage of filtered entries", parse_filter_percentage),
+	OPT_STRING(0, "time", &pdiff.time_str, "str",
+		   "Time span (time percent or absolute timestamp)"),
+	OPT_STRING(0, "cpu", &cpu_list, "cpu", "list of cpus to profile"),
+	OPT_STRING(0, "pid", &symbol_conf.pid_list_str, "pid[,pid...]",
+		   "only consider symbols in these pids"),
+	OPT_STRING(0, "tid", &symbol_conf.tid_list_str, "tid[,tid...]",
+		   "only consider symbols in these tids"),
 	OPT_END()
 };
 
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 1532ebde6c4b..ee93c18a6685 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1375,36 +1375,13 @@ int cmd_report(int argc, const char **argv)
 	if (symbol__init(&session->header.env) < 0)
 		goto error;
 
-	report.ptime_range = perf_time__range_alloc(report.time_str,
-						    &report.range_size);
-	if (!report.ptime_range) {
-		ret = -ENOMEM;
-		goto error;
-	}
-
-	if (perf_time__parse_str(report.ptime_range, report.time_str) != 0) {
-		if (session->evlist->first_sample_time == 0 &&
-		    session->evlist->last_sample_time == 0) {
-			pr_err("HINT: no first/last sample time found in perf data.\n"
-			       "Please use latest perf binary to execute 'perf record'\n"
-			       "(if '--buildid-all' is enabled, please set '--timestamp-boundary').\n");
-			ret = -EINVAL;
-			goto error;
-		}
-
-		report.range_num = perf_time__percent_parse_str(
-					report.ptime_range, report.range_size,
-					report.time_str,
-					session->evlist->first_sample_time,
-					session->evlist->last_sample_time);
-
-		if (report.range_num < 0) {
-			pr_err("Invalid time string\n");
-			ret = -EINVAL;
+	if (report.time_str) {
+		ret = perf_time__parse_for_ranges(report.time_str, session,
+						  &report.ptime_range,
+						  &report.range_size,
+						  &report.range_num);
+		if (ret < 0)
 			goto error;
-		}
-	} else {
-		report.range_num = 1;
 	}
 
 	if (session->tevent.pevent &&
@@ -1426,7 +1403,8 @@ int cmd_report(int argc, const char **argv)
 		ret = 0;
 
 error:
-	zfree(&report.ptime_range);
+	if (report.ptime_range)
+		zfree(&report.ptime_range);
 
 	perf_session__delete(session);
 	return ret;
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 2d8cb1d1682c..53f78cf3113f 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3699,37 +3699,13 @@ int cmd_script(int argc, const char **argv)
 	if (err < 0)
 		goto out_delete;
 
-	script.ptime_range = perf_time__range_alloc(script.time_str,
-						    &script.range_size);
-	if (!script.ptime_range) {
-		err = -ENOMEM;
-		goto out_delete;
-	}
-
-	/* needs to be parsed after looking up reference time */
-	if (perf_time__parse_str(script.ptime_range, script.time_str) != 0) {
-		if (session->evlist->first_sample_time == 0 &&
-		    session->evlist->last_sample_time == 0) {
-			pr_err("HINT: no first/last sample time found in perf data.\n"
-			       "Please use latest perf binary to execute 'perf record'\n"
-			       "(if '--buildid-all' is enabled, please set '--timestamp-boundary').\n");
-			err = -EINVAL;
-			goto out_delete;
-		}
-
-		script.range_num = perf_time__percent_parse_str(
-					script.ptime_range, script.range_size,
-					script.time_str,
-					session->evlist->first_sample_time,
-					session->evlist->last_sample_time);
-
-		if (script.range_num < 0) {
-			pr_err("Invalid time string\n");
-			err = -EINVAL;
+	if (script.time_str) {
+		err = perf_time__parse_for_ranges(script.time_str, session,
+						  &script.ptime_range,
+						  &script.range_size,
+						  &script.range_num);
+		if (err < 0)
 			goto out_delete;
-		}
-	} else {
-		script.range_num = 1;
 	}
 
 	err = __cmd_script(&script);
@@ -3737,7 +3713,8 @@ int cmd_script(int argc, const char **argv)
 	flush_scripting();
 
 out_delete:
-	zfree(&script.ptime_range);
+	if (script.ptime_range)
+		zfree(&script.ptime_range);
 
 	perf_evlist__free_stats(session->evlist);
 	perf_session__delete(session);
diff --git a/tools/perf/include/bpf/bpf.h b/tools/perf/include/bpf/bpf.h
index 5df7ed9d9020..2eac6d804b2d 100644
--- a/tools/perf/include/bpf/bpf.h
+++ b/tools/perf/include/bpf/bpf.h
@@ -24,7 +24,13 @@ struct bpf_map SEC("maps") name = {				\
 	.key_size    = sizeof(type_key),			\
 	.value_size  = sizeof(type_val),			\
 	.max_entries = _max_entries,				\
-}
+};								\
+struct ____btf_map_##name {					\
+	type_key key;						\
+	type_val value;                                 	\
+};								\
+struct ____btf_map_##name __attribute__((section(".maps." #name), used)) \
+	____btf_map_##name = { }
 
 /*
  * FIXME: this should receive .max_entries as a parameter, as careful
diff --git a/tools/perf/scripts/python/check-perf-trace.py b/tools/perf/scripts/python/check-perf-trace.py
index 334599c6032c..d2c22954800d 100644
--- a/tools/perf/scripts/python/check-perf-trace.py
+++ b/tools/perf/scripts/python/check-perf-trace.py
@@ -7,6 +7,8 @@
 # events, etc.  Basically, if this script runs successfully and
 # displays expected results, Python scripting support should be ok.
 
+from __future__ import print_function
+
 import os
 import sys
 
@@ -19,64 +21,64 @@ from perf_trace_context import *
 unhandled = autodict()
 
 def trace_begin():
-	print "trace_begin"
+	print("trace_begin")
 	pass
 
 def trace_end():
-        print_unhandled()
+	print_unhandled()
 
 def irq__softirq_entry(event_name, context, common_cpu,
-	common_secs, common_nsecs, common_pid, common_comm,
-	common_callchain, vec):
-		print_header(event_name, common_cpu, common_secs, common_nsecs,
-			common_pid, common_comm)
+		       common_secs, common_nsecs, common_pid, common_comm,
+		       common_callchain, vec):
+	print_header(event_name, common_cpu, common_secs, common_nsecs,
+		common_pid, common_comm)
 
-                print_uncommon(context)
+	print_uncommon(context)
 
-		print "vec=%s\n" % \
-		(symbol_str("irq__softirq_entry", "vec", vec)),
+	print("vec=%s" % (symbol_str("irq__softirq_entry", "vec", vec)))
 
 def kmem__kmalloc(event_name, context, common_cpu,
-	common_secs, common_nsecs, common_pid, common_comm,
-	common_callchain, call_site, ptr, bytes_req, bytes_alloc,
-	gfp_flags):
-		print_header(event_name, common_cpu, common_secs, common_nsecs,
-			common_pid, common_comm)
+		  common_secs, common_nsecs, common_pid, common_comm,
+		  common_callchain, call_site, ptr, bytes_req, bytes_alloc,
+		  gfp_flags):
+	print_header(event_name, common_cpu, common_secs, common_nsecs,
+		common_pid, common_comm)
 
-                print_uncommon(context)
+	print_uncommon(context)
 
-		print "call_site=%u, ptr=%u, bytes_req=%u, " \
-		"bytes_alloc=%u, gfp_flags=%s\n" % \
+	print("call_site=%u, ptr=%u, bytes_req=%u, "
+		"bytes_alloc=%u, gfp_flags=%s" %
 		(call_site, ptr, bytes_req, bytes_alloc,
-
-		flag_str("kmem__kmalloc", "gfp_flags", gfp_flags)),
+		flag_str("kmem__kmalloc", "gfp_flags", gfp_flags)))
 
 def trace_unhandled(event_name, context, event_fields_dict):
-    try:
-        unhandled[event_name] += 1
-    except TypeError:
-        unhandled[event_name] = 1
+	try:
+		unhandled[event_name] += 1
+	except TypeError:
+		unhandled[event_name] = 1
 
 def print_header(event_name, cpu, secs, nsecs, pid, comm):
-	print "%-20s %5u %05u.%09u %8u %-20s " % \
-	(event_name, cpu, secs, nsecs, pid, comm),
+	print("%-20s %5u %05u.%09u %8u %-20s " %
+		(event_name, cpu, secs, nsecs, pid, comm),
+		end=' ')
 
 # print trace fields not included in handler args
 def print_uncommon(context):
-    print "common_preempt_count=%d, common_flags=%s, common_lock_depth=%d, " \
-        % (common_pc(context), trace_flag_str(common_flags(context)), \
-               common_lock_depth(context))
+	print("common_preempt_count=%d, common_flags=%s, "
+		"common_lock_depth=%d, " %
+		(common_pc(context), trace_flag_str(common_flags(context)),
+		common_lock_depth(context)))
 
 def print_unhandled():
-    keys = unhandled.keys()
-    if not keys:
-        return
+	keys = unhandled.keys()
+	if not keys:
+		return
 
-    print "\nunhandled events:\n\n",
+	print("\nunhandled events:\n")
 
-    print "%-40s  %10s\n" % ("event", "count"),
-    print "%-40s  %10s\n" % ("----------------------------------------", \
-                                 "-----------"),
+	print("%-40s  %10s" % ("event", "count"))
+	print("%-40s  %10s" % ("----------------------------------------",
+				"-----------"))
 
-    for event_name in keys:
-	print "%-40s  %10d\n" % (event_name, unhandled[event_name])
+	for event_name in keys:
+		print("%-40s  %10d\n" % (event_name, unhandled[event_name]))
diff --git a/tools/perf/scripts/python/compaction-times.py b/tools/perf/scripts/python/compaction-times.py
index 239cb0568ec3..2560a042dc6f 100644
--- a/tools/perf/scripts/python/compaction-times.py
+++ b/tools/perf/scripts/python/compaction-times.py
@@ -216,15 +216,15 @@ def compaction__mm_compaction_migratepages(event_name, context, common_cpu,
 		pair(nr_migrated, nr_failed), None, None)
 
 def compaction__mm_compaction_isolate_freepages(event_name, context, common_cpu,
-        common_secs, common_nsecs, common_pid, common_comm,
-        common_callchain, start_pfn, end_pfn, nr_scanned, nr_taken):
+	common_secs, common_nsecs, common_pid, common_comm,
+	common_callchain, start_pfn, end_pfn, nr_scanned, nr_taken):
 
 	chead.increment_pending(common_pid,
 		None, pair(nr_scanned, nr_taken), None)
 
 def compaction__mm_compaction_isolate_migratepages(event_name, context, common_cpu,
-        common_secs, common_nsecs, common_pid, common_comm,
-        common_callchain, start_pfn, end_pfn, nr_scanned, nr_taken):
+	common_secs, common_nsecs, common_pid, common_comm,
+	common_callchain, start_pfn, end_pfn, nr_scanned, nr_taken):
 
 	chead.increment_pending(common_pid,
 		None, None, pair(nr_scanned, nr_taken))
diff --git a/tools/perf/scripts/python/event_analyzing_sample.py b/tools/perf/scripts/python/event_analyzing_sample.py
index 4e843b9864ec..aa1e2cfa26a6 100644
--- a/tools/perf/scripts/python/event_analyzing_sample.py
+++ b/tools/perf/scripts/python/event_analyzing_sample.py
@@ -15,6 +15,8 @@
 # for a x86 HW PMU event: PEBS with load latency data.
 #
 
+from __future__ import print_function
+
 import os
 import sys
 import math
@@ -37,7 +39,7 @@ con = sqlite3.connect("/dev/shm/perf.db")
 con.isolation_level = None
 
 def trace_begin():
-	print "In trace_begin:\n"
+        print("In trace_begin:\n")
 
         #
         # Will create several tables at the start, pebs_ll is for PEBS data with
@@ -76,12 +78,12 @@ def process_event(param_dict):
         name       = param_dict["ev_name"]
 
         # Symbol and dso info are not always resolved
-        if (param_dict.has_key("dso")):
+        if ("dso" in param_dict):
                 dso = param_dict["dso"]
         else:
                 dso = "Unknown_dso"
 
-        if (param_dict.has_key("symbol")):
+        if ("symbol" in param_dict):
                 symbol = param_dict["symbol"]
         else:
                 symbol = "Unknown_symbol"
@@ -102,7 +104,7 @@ def insert_db(event):
                                 event.ip, event.status, event.dse, event.dla, event.lat))
 
 def trace_end():
-	print "In trace_end:\n"
+        print("In trace_end:\n")
         # We show the basic info for the 2 type of event classes
         show_general_events()
         show_pebs_ll()
@@ -123,29 +125,29 @@ def show_general_events():
         # Check the total record number in the table
         count = con.execute("select count(*) from gen_events")
         for t in count:
-                print "There is %d records in gen_events table" % t[0]
+                print("There is %d records in gen_events table" % t[0])
                 if t[0] == 0:
                         return
 
-        print "Statistics about the general events grouped by thread/symbol/dso: \n"
+        print("Statistics about the general events grouped by thread/symbol/dso: \n")
 
          # Group by thread
         commq = con.execute("select comm, count(comm) from gen_events group by comm order by -count(comm)")
-        print "\n%16s %8s %16s\n%s" % ("comm", "number", "histogram", "="*42)
+        print("\n%16s %8s %16s\n%s" % ("comm", "number", "histogram", "="*42))
         for row in commq:
-             print "%16s %8d     %s" % (row[0], row[1], num2sym(row[1]))
+             print("%16s %8d     %s" % (row[0], row[1], num2sym(row[1])))
 
         # Group by symbol
-        print "\n%32s %8s %16s\n%s" % ("symbol", "number", "histogram", "="*58)
+        print("\n%32s %8s %16s\n%s" % ("symbol", "number", "histogram", "="*58))
         symbolq = con.execute("select symbol, count(symbol) from gen_events group by symbol order by -count(symbol)")
         for row in symbolq:
-             print "%32s %8d     %s" % (row[0], row[1], num2sym(row[1]))
+             print("%32s %8d     %s" % (row[0], row[1], num2sym(row[1])))
 
         # Group by dso
-        print "\n%40s %8s %16s\n%s" % ("dso", "number", "histogram", "="*74)
+        print("\n%40s %8s %16s\n%s" % ("dso", "number", "histogram", "="*74))
         dsoq = con.execute("select dso, count(dso) from gen_events group by dso order by -count(dso)")
         for row in dsoq:
-             print "%40s %8d     %s" % (row[0], row[1], num2sym(row[1]))
+             print("%40s %8d     %s" % (row[0], row[1], num2sym(row[1])))
 
 #
 # This function just shows the basic info, and we could do more with the
@@ -156,35 +158,35 @@ def show_pebs_ll():
 
         count = con.execute("select count(*) from pebs_ll")
         for t in count:
-                print "There is %d records in pebs_ll table" % t[0]
+                print("There is %d records in pebs_ll table" % t[0])
                 if t[0] == 0:
                         return
 
-        print "Statistics about the PEBS Load Latency events grouped by thread/symbol/dse/latency: \n"
+        print("Statistics about the PEBS Load Latency events grouped by thread/symbol/dse/latency: \n")
 
         # Group by thread
         commq = con.execute("select comm, count(comm) from pebs_ll group by comm order by -count(comm)")
-        print "\n%16s %8s %16s\n%s" % ("comm", "number", "histogram", "="*42)
+        print("\n%16s %8s %16s\n%s" % ("comm", "number", "histogram", "="*42))
         for row in commq:
-             print "%16s %8d     %s" % (row[0], row[1], num2sym(row[1]))
+             print("%16s %8d     %s" % (row[0], row[1], num2sym(row[1])))
 
         # Group by symbol
-        print "\n%32s %8s %16s\n%s" % ("symbol", "number", "histogram", "="*58)
+        print("\n%32s %8s %16s\n%s" % ("symbol", "number", "histogram", "="*58))
         symbolq = con.execute("select symbol, count(symbol) from pebs_ll group by symbol order by -count(symbol)")
         for row in symbolq:
-             print "%32s %8d     %s" % (row[0], row[1], num2sym(row[1]))
+             print("%32s %8d     %s" % (row[0], row[1], num2sym(row[1])))
 
         # Group by dse
         dseq = con.execute("select dse, count(dse) from pebs_ll group by dse order by -count(dse)")
-        print "\n%32s %8s %16s\n%s" % ("dse", "number", "histogram", "="*58)
+        print("\n%32s %8s %16s\n%s" % ("dse", "number", "histogram", "="*58))
         for row in dseq:
-             print "%32s %8d     %s" % (row[0], row[1], num2sym(row[1]))
+             print("%32s %8d     %s" % (row[0], row[1], num2sym(row[1])))
 
         # Group by latency
         latq = con.execute("select lat, count(lat) from pebs_ll group by lat order by lat")
-        print "\n%32s %8s %16s\n%s" % ("latency", "number", "histogram", "="*58)
+        print("\n%32s %8s %16s\n%s" % ("latency", "number", "histogram", "="*58))
         for row in latq:
-             print "%32s %8d     %s" % (row[0], row[1], num2sym(row[1]))
+             print("%32s %8d     %s" % (row[0], row[1], num2sym(row[1])))
 
 def trace_unhandled(event_name, context, event_fields_dict):
-		print ' '.join(['%s=%s'%(k,str(v))for k,v in sorted(event_fields_dict.items())])
+        print (' '.join(['%s=%s'%(k,str(v))for k,v in sorted(event_fields_dict.items())]))
diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
index 30130213da7e..390a351d15ea 100644
--- a/tools/perf/scripts/python/export-to-postgresql.py
+++ b/tools/perf/scripts/python/export-to-postgresql.py
@@ -394,7 +394,8 @@ if perf_db_export_calls:
 		'call_id	bigint,'
 		'return_id	bigint,'
 		'parent_call_path_id	bigint,'
-		'flags		integer)')
+		'flags		integer,'
+		'parent_id	bigint)')
 
 do_query(query, 'CREATE VIEW machines_view AS '
 	'SELECT '
@@ -478,8 +479,9 @@ if perf_db_export_calls:
 			'branch_count,'
 			'call_id,'
 			'return_id,'
-			'CASE WHEN flags=0 THEN \'\' WHEN flags=1 THEN \'no call\' WHEN flags=2 THEN \'no return\' WHEN flags=3 THEN \'no call/return\' WHEN flags=6 THEN \'jump\' ELSE flags END AS flags,'
-			'parent_call_path_id'
+			'CASE WHEN flags=0 THEN \'\' WHEN flags=1 THEN \'no call\' WHEN flags=2 THEN \'no return\' WHEN flags=3 THEN \'no call/return\' WHEN flags=6 THEN \'jump\' ELSE CAST ( flags AS VARCHAR(6) ) END AS flags,'
+			'parent_call_path_id,'
+			'calls.parent_id'
 		' FROM calls INNER JOIN call_paths ON call_paths.id = call_path_id')
 
 do_query(query, 'CREATE VIEW samples_view AS '
@@ -575,6 +577,7 @@ def trace_begin():
 	sample_table(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
 	if perf_db_export_calls or perf_db_export_callchains:
 		call_path_table(0, 0, 0, 0)
+		call_return_table(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
 
 unhandled_count = 0
 
@@ -657,6 +660,7 @@ def trace_end():
 					'ADD CONSTRAINT returnfk    FOREIGN KEY (return_id)    REFERENCES samples    (id),'
 					'ADD CONSTRAINT parent_call_pathfk FOREIGN KEY (parent_call_path_id) REFERENCES call_paths (id)')
 		do_query(query, 'CREATE INDEX pcpid_idx ON calls (parent_call_path_id)')
+		do_query(query, 'CREATE INDEX pid_idx ON calls (parent_id)')
 
 	if (unhandled_count):
 		print datetime.datetime.today(), "Warning: ", unhandled_count, " unhandled events"
@@ -728,7 +732,7 @@ def call_path_table(cp_id, parent_id, symbol_id, ip, *x):
 	value = struct.pack(fmt, 4, 8, cp_id, 8, parent_id, 8, symbol_id, 8, ip)
 	call_path_file.write(value)
 
-def call_return_table(cr_id, thread_id, comm_id, call_path_id, call_time, return_time, branch_count, call_id, return_id, parent_call_path_id, flags, *x):
-	fmt = "!hiqiqiqiqiqiqiqiqiqiqii"
-	value = struct.pack(fmt, 11, 8, cr_id, 8, thread_id, 8, comm_id, 8, call_path_id, 8, call_time, 8, return_time, 8, branch_count, 8, call_id, 8, return_id, 8, parent_call_path_id, 4, flags)
+def call_return_table(cr_id, thread_id, comm_id, call_path_id, call_time, return_time, branch_count, call_id, return_id, parent_call_path_id, flags, parent_id, *x):
+	fmt = "!hiqiqiqiqiqiqiqiqiqiqiiiq"
+	value = struct.pack(fmt, 12, 8, cr_id, 8, thread_id, 8, comm_id, 8, call_path_id, 8, call_time, 8, return_time, 8, branch_count, 8, call_id, 8, return_id, 8, parent_call_path_id, 4, flags, 8, parent_id)
 	call_file.write(value)
diff --git a/tools/perf/scripts/python/export-to-sqlite.py b/tools/perf/scripts/python/export-to-sqlite.py
index ed237f2ed03f..eb63e6c7107f 100644
--- a/tools/perf/scripts/python/export-to-sqlite.py
+++ b/tools/perf/scripts/python/export-to-sqlite.py
@@ -222,7 +222,8 @@ if perf_db_export_calls:
 		'call_id	bigint,'
 		'return_id	bigint,'
 		'parent_call_path_id	bigint,'
-		'flags		integer)')
+		'flags		integer,'
+		'parent_id	bigint)')
 
 # printf was added to sqlite in version 3.8.3
 sqlite_has_printf = False
@@ -321,7 +322,8 @@ if perf_db_export_calls:
 			'call_id,'
 			'return_id,'
 			'CASE WHEN flags=0 THEN \'\' WHEN flags=1 THEN \'no call\' WHEN flags=2 THEN \'no return\' WHEN flags=3 THEN \'no call/return\' WHEN flags=6 THEN \'jump\' ELSE flags END AS flags,'
-			'parent_call_path_id'
+			'parent_call_path_id,'
+			'parent_id'
 		' FROM calls INNER JOIN call_paths ON call_paths.id = call_path_id')
 
 do_query(query, 'CREATE VIEW samples_view AS '
@@ -373,7 +375,7 @@ if perf_db_export_calls or perf_db_export_callchains:
 	call_path_query.prepare("INSERT INTO call_paths VALUES (?, ?, ?, ?)")
 if perf_db_export_calls:
 	call_query = QSqlQuery(db)
-	call_query.prepare("INSERT INTO calls VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")
+	call_query.prepare("INSERT INTO calls VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")
 
 def trace_begin():
 	print datetime.datetime.today(), "Writing records..."
@@ -388,6 +390,7 @@ def trace_begin():
 	sample_table(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
 	if perf_db_export_calls or perf_db_export_callchains:
 		call_path_table(0, 0, 0, 0)
+		call_return_table(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
 
 unhandled_count = 0
 
@@ -397,6 +400,7 @@ def trace_end():
 	print datetime.datetime.today(), "Adding indexes"
 	if perf_db_export_calls:
 		do_query(query, 'CREATE INDEX pcpid_idx ON calls (parent_call_path_id)')
+		do_query(query, 'CREATE INDEX pid_idx ON calls (parent_id)')
 
 	if (unhandled_count):
 		print datetime.datetime.today(), "Warning: ", unhandled_count, " unhandled events"
@@ -452,4 +456,4 @@ def call_path_table(*x):
 	bind_exec(call_path_query, 4, x)
 
 def call_return_table(*x):
-	bind_exec(call_query, 11, x)
+	bind_exec(call_query, 12, x)
diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 09ce73b07d35..afec9479ca7f 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -167,9 +167,10 @@ class Thread(QThread):
 
 class TreeModel(QAbstractItemModel):
 
-	def __init__(self, root, parent=None):
+	def __init__(self, glb, parent=None):
 		super(TreeModel, self).__init__(parent)
-		self.root = root
+		self.glb = glb
+		self.root = self.GetRoot()
 		self.last_row_read = 0
 
 	def Item(self, parent):
@@ -557,24 +558,12 @@ class CallGraphRootItem(CallGraphLevelItemBase):
 			self.child_items.append(child_item)
 			self.child_count += 1
 
-# Context-sensitive call graph data model
+# Context-sensitive call graph data model base
 
-class CallGraphModel(TreeModel):
+class CallGraphModelBase(TreeModel):
 
 	def __init__(self, glb, parent=None):
-		super(CallGraphModel, self).__init__(CallGraphRootItem(glb), parent)
-		self.glb = glb
-
-	def columnCount(self, parent=None):
-		return 7
-
-	def columnHeader(self, column):
-		headers = ["Call Path", "Object", "Count ", "Time (ns) ", "Time (%) ", "Branch Count ", "Branch Count (%) "]
-		return headers[column]
-
-	def columnAlignment(self, column):
-		alignment = [ Qt.AlignLeft, Qt.AlignLeft, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight ]
-		return alignment[column]
+		super(CallGraphModelBase, self).__init__(glb, parent)
 
 	def FindSelect(self, value, pattern, query):
 		if pattern:
@@ -594,34 +583,7 @@ class CallGraphModel(TreeModel):
 				match = " GLOB '" + str(value) + "'"
 		else:
 			match = " = '" + str(value) + "'"
-		QueryExec(query, "SELECT call_path_id, comm_id, thread_id"
-						" FROM calls"
-						" INNER JOIN call_paths ON calls.call_path_id = call_paths.id"
-						" INNER JOIN symbols ON call_paths.symbol_id = symbols.id"
-						" WHERE symbols.name" + match +
-						" GROUP BY comm_id, thread_id, call_path_id"
-						" ORDER BY comm_id, thread_id, call_path_id")
-
-	def FindPath(self, query):
-		# Turn the query result into a list of ids that the tree view can walk
-		# to open the tree at the right place.
-		ids = []
-		parent_id = query.value(0)
-		while parent_id:
-			ids.insert(0, parent_id)
-			q2 = QSqlQuery(self.glb.db)
-			QueryExec(q2, "SELECT parent_id"
-					" FROM call_paths"
-					" WHERE id = " + str(parent_id))
-			if not q2.next():
-				break
-			parent_id = q2.value(0)
-		# The call path root is not used
-		if ids[0] == 1:
-			del ids[0]
-		ids.insert(0, query.value(2))
-		ids.insert(0, query.value(1))
-		return ids
+		self.DoFindSelect(query, match)
 
 	def Found(self, query, found):
 		if found:
@@ -675,6 +637,201 @@ class CallGraphModel(TreeModel):
 	def FindDone(self, thread, callback, ids):
 		callback(ids)
 
+# Context-sensitive call graph data model
+
+class CallGraphModel(CallGraphModelBase):
+
+	def __init__(self, glb, parent=None):
+		super(CallGraphModel, self).__init__(glb, parent)
+
+	def GetRoot(self):
+		return CallGraphRootItem(self.glb)
+
+	def columnCount(self, parent=None):
+		return 7
+
+	def columnHeader(self, column):
+		headers = ["Call Path", "Object", "Count ", "Time (ns) ", "Time (%) ", "Branch Count ", "Branch Count (%) "]
+		return headers[column]
+
+	def columnAlignment(self, column):
+		alignment = [ Qt.AlignLeft, Qt.AlignLeft, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight ]
+		return alignment[column]
+
+	def DoFindSelect(self, query, match):
+		QueryExec(query, "SELECT call_path_id, comm_id, thread_id"
+						" FROM calls"
+						" INNER JOIN call_paths ON calls.call_path_id = call_paths.id"
+						" INNER JOIN symbols ON call_paths.symbol_id = symbols.id"
+						" WHERE symbols.name" + match +
+						" GROUP BY comm_id, thread_id, call_path_id"
+						" ORDER BY comm_id, thread_id, call_path_id")
+
+	def FindPath(self, query):
+		# Turn the query result into a list of ids that the tree view can walk
+		# to open the tree at the right place.
+		ids = []
+		parent_id = query.value(0)
+		while parent_id:
+			ids.insert(0, parent_id)
+			q2 = QSqlQuery(self.glb.db)
+			QueryExec(q2, "SELECT parent_id"
+					" FROM call_paths"
+					" WHERE id = " + str(parent_id))
+			if not q2.next():
+				break
+			parent_id = q2.value(0)
+		# The call path root is not used
+		if ids[0] == 1:
+			del ids[0]
+		ids.insert(0, query.value(2))
+		ids.insert(0, query.value(1))
+		return ids
+
+# Call tree data model level 2+ item base
+
+class CallTreeLevelTwoPlusItemBase(CallGraphLevelItemBase):
+
+	def __init__(self, glb, row, comm_id, thread_id, calls_id, time, branch_count, parent_item):
+		super(CallTreeLevelTwoPlusItemBase, self).__init__(glb, row, parent_item)
+		self.comm_id = comm_id
+		self.thread_id = thread_id
+		self.calls_id = calls_id
+		self.branch_count = branch_count
+		self.time = time
+
+	def Select(self):
+		self.query_done = True;
+		if self.calls_id == 0:
+			comm_thread = " AND comm_id = " + str(self.comm_id) + " AND thread_id = " + str(self.thread_id)
+		else:
+			comm_thread = ""
+		query = QSqlQuery(self.glb.db)
+		QueryExec(query, "SELECT calls.id, name, short_name, call_time, return_time - call_time, branch_count"
+					" FROM calls"
+					" INNER JOIN call_paths ON calls.call_path_id = call_paths.id"
+					" INNER JOIN symbols ON call_paths.symbol_id = symbols.id"
+					" INNER JOIN dsos ON symbols.dso_id = dsos.id"
+					" WHERE calls.parent_id = " + str(self.calls_id) + comm_thread +
+					" ORDER BY call_time, calls.id")
+		while query.next():
+			child_item = CallTreeLevelThreeItem(self.glb, self.child_count, self.comm_id, self.thread_id, query.value(0), query.value(1), query.value(2), query.value(3), int(query.value(4)), int(query.value(5)), self)
+			self.child_items.append(child_item)
+			self.child_count += 1
+
+# Call tree data model level three item
+
+class CallTreeLevelThreeItem(CallTreeLevelTwoPlusItemBase):
+
+	def __init__(self, glb, row, comm_id, thread_id, calls_id, name, dso, count, time, branch_count, parent_item):
+		super(CallTreeLevelThreeItem, self).__init__(glb, row, comm_id, thread_id, calls_id, time, branch_count, parent_item)
+		dso = dsoname(dso)
+		self.data = [ name, dso, str(count), str(time), PercentToOneDP(time, parent_item.time), str(branch_count), PercentToOneDP(branch_count, parent_item.branch_count) ]
+		self.dbid = calls_id
+
+# Call tree data model level two item
+
+class CallTreeLevelTwoItem(CallTreeLevelTwoPlusItemBase):
+
+	def __init__(self, glb, row, comm_id, thread_id, pid, tid, parent_item):
+		super(CallTreeLevelTwoItem, self).__init__(glb, row, comm_id, thread_id, 0, 0, 0, parent_item)
+		self.data = [str(pid) + ":" + str(tid), "", "", "", "", "", ""]
+		self.dbid = thread_id
+
+	def Select(self):
+		super(CallTreeLevelTwoItem, self).Select()
+		for child_item in self.child_items:
+			self.time += child_item.time
+			self.branch_count += child_item.branch_count
+		for child_item in self.child_items:
+			child_item.data[4] = PercentToOneDP(child_item.time, self.time)
+			child_item.data[6] = PercentToOneDP(child_item.branch_count, self.branch_count)
+
+# Call tree data model level one item
+
+class CallTreeLevelOneItem(CallGraphLevelItemBase):
+
+	def __init__(self, glb, row, comm_id, comm, parent_item):
+		super(CallTreeLevelOneItem, self).__init__(glb, row, parent_item)
+		self.data = [comm, "", "", "", "", "", ""]
+		self.dbid = comm_id
+
+	def Select(self):
+		self.query_done = True;
+		query = QSqlQuery(self.glb.db)
+		QueryExec(query, "SELECT thread_id, pid, tid"
+					" FROM comm_threads"
+					" INNER JOIN threads ON thread_id = threads.id"
+					" WHERE comm_id = " + str(self.dbid))
+		while query.next():
+			child_item = CallTreeLevelTwoItem(self.glb, self.child_count, self.dbid, query.value(0), query.value(1), query.value(2), self)
+			self.child_items.append(child_item)
+			self.child_count += 1
+
+# Call tree data model root item
+
+class CallTreeRootItem(CallGraphLevelItemBase):
+
+	def __init__(self, glb):
+		super(CallTreeRootItem, self).__init__(glb, 0, None)
+		self.dbid = 0
+		self.query_done = True;
+		query = QSqlQuery(glb.db)
+		QueryExec(query, "SELECT id, comm FROM comms")
+		while query.next():
+			if not query.value(0):
+				continue
+			child_item = CallTreeLevelOneItem(glb, self.child_count, query.value(0), query.value(1), self)
+			self.child_items.append(child_item)
+			self.child_count += 1
+
+# Call Tree data model
+
+class CallTreeModel(CallGraphModelBase):
+
+	def __init__(self, glb, parent=None):
+		super(CallTreeModel, self).__init__(glb, parent)
+
+	def GetRoot(self):
+		return CallTreeRootItem(self.glb)
+
+	def columnCount(self, parent=None):
+		return 7
+
+	def columnHeader(self, column):
+		headers = ["Call Path", "Object", "Call Time", "Time (ns) ", "Time (%) ", "Branch Count ", "Branch Count (%) "]
+		return headers[column]
+
+	def columnAlignment(self, column):
+		alignment = [ Qt.AlignLeft, Qt.AlignLeft, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight ]
+		return alignment[column]
+
+	def DoFindSelect(self, query, match):
+		QueryExec(query, "SELECT calls.id, comm_id, thread_id"
+						" FROM calls"
+						" INNER JOIN call_paths ON calls.call_path_id = call_paths.id"
+						" INNER JOIN symbols ON call_paths.symbol_id = symbols.id"
+						" WHERE symbols.name" + match +
+						" ORDER BY comm_id, thread_id, call_time, calls.id")
+
+	def FindPath(self, query):
+		# Turn the query result into a list of ids that the tree view can walk
+		# to open the tree at the right place.
+		ids = []
+		parent_id = query.value(0)
+		while parent_id:
+			ids.insert(0, parent_id)
+			q2 = QSqlQuery(self.glb.db)
+			QueryExec(q2, "SELECT parent_id"
+					" FROM calls"
+					" WHERE id = " + str(parent_id))
+			if not q2.next():
+				break
+			parent_id = q2.value(0)
+		ids.insert(0, query.value(2))
+		ids.insert(0, query.value(1))
+		return ids
+
 # Vertical widget layout
 
 class VBox():
@@ -693,28 +850,16 @@ class VBox():
 	def Widget(self):
 		return self.vbox
 
-# Context-sensitive call graph window
-
-class CallGraphWindow(QMdiSubWindow):
-
-	def __init__(self, glb, parent=None):
-		super(CallGraphWindow, self).__init__(parent)
-
-		self.model = LookupCreateModel("Context-Sensitive Call Graph", lambda x=glb: CallGraphModel(x))
-
-		self.view = QTreeView()
-		self.view.setModel(self.model)
-
-		for c, w in ((0, 250), (1, 100), (2, 60), (3, 70), (4, 70), (5, 100)):
-			self.view.setColumnWidth(c, w)
-
-		self.find_bar = FindBar(self, self)
+# Tree window base
 
-		self.vbox = VBox(self.view, self.find_bar.Widget())
+class TreeWindowBase(QMdiSubWindow):
 
-		self.setWidget(self.vbox.Widget())
+	def __init__(self, parent=None):
+		super(TreeWindowBase, self).__init__(parent)
 
-		AddSubWindow(glb.mainwindow.mdi_area, self, "Context-Sensitive Call Graph")
+		self.model = None
+		self.view = None
+		self.find_bar = None
 
 	def DisplayFound(self, ids):
 		if not len(ids):
@@ -747,6 +892,53 @@ class CallGraphWindow(QMdiSubWindow):
 		if not found:
 			self.find_bar.NotFound()
 
+
+# Context-sensitive call graph window
+
+class CallGraphWindow(TreeWindowBase):
+
+	def __init__(self, glb, parent=None):
+		super(CallGraphWindow, self).__init__(parent)
+
+		self.model = LookupCreateModel("Context-Sensitive Call Graph", lambda x=glb: CallGraphModel(x))
+
+		self.view = QTreeView()
+		self.view.setModel(self.model)
+
+		for c, w in ((0, 250), (1, 100), (2, 60), (3, 70), (4, 70), (5, 100)):
+			self.view.setColumnWidth(c, w)
+
+		self.find_bar = FindBar(self, self)
+
+		self.vbox = VBox(self.view, self.find_bar.Widget())
+
+		self.setWidget(self.vbox.Widget())
+
+		AddSubWindow(glb.mainwindow.mdi_area, self, "Context-Sensitive Call Graph")
+
+# Call tree window
+
+class CallTreeWindow(TreeWindowBase):
+
+	def __init__(self, glb, parent=None):
+		super(CallTreeWindow, self).__init__(parent)
+
+		self.model = LookupCreateModel("Call Tree", lambda x=glb: CallTreeModel(x))
+
+		self.view = QTreeView()
+		self.view.setModel(self.model)
+
+		for c, w in ((0, 230), (1, 100), (2, 100), (3, 70), (4, 70), (5, 100)):
+			self.view.setColumnWidth(c, w)
+
+		self.find_bar = FindBar(self, self)
+
+		self.vbox = VBox(self.view, self.find_bar.Widget())
+
+		self.setWidget(self.vbox.Widget())
+
+		AddSubWindow(glb.mainwindow.mdi_area, self, "Call Tree")
+
 # Child data item  finder
 
 class ChildDataItemFinder():
@@ -1327,8 +1519,7 @@ class BranchModel(TreeModel):
 	progress = Signal(object)
 
 	def __init__(self, glb, event_id, where_clause, parent=None):
-		super(BranchModel, self).__init__(BranchRootItem(), parent)
-		self.glb = glb
+		super(BranchModel, self).__init__(glb, parent)
 		self.event_id = event_id
 		self.more = True
 		self.populated = 0
@@ -1352,6 +1543,9 @@ class BranchModel(TreeModel):
 		self.fetcher.done.connect(self.Update)
 		self.fetcher.Fetch(glb_chunk_sz)
 
+	def GetRoot(self):
+		return BranchRootItem()
+
 	def columnCount(self, parent=None):
 		return 8
 
@@ -1863,10 +2057,10 @@ def GetEventList(db):
 
 # Is a table selectable
 
-def IsSelectable(db, table):
+def IsSelectable(db, table, sql = ""):
 	query = QSqlQuery(db)
 	try:
-		QueryExec(query, "SELECT * FROM " + table + " LIMIT 1")
+		QueryExec(query, "SELECT * FROM " + table + " " + sql + " LIMIT 1")
 	except:
 		return False
 	return True
@@ -2275,9 +2469,10 @@ p.c2 {
 </style>
 <p class=c1><a href=#reports>1. Reports</a></p>
 <p class=c2><a href=#callgraph>1.1 Context-Sensitive Call Graph</a></p>
-<p class=c2><a href=#allbranches>1.2 All branches</a></p>
-<p class=c2><a href=#selectedbranches>1.3 Selected branches</a></p>
-<p class=c2><a href=#topcallsbyelapsedtime>1.4 Top calls by elapsed time</a></p>
+<p class=c2><a href=#calltree>1.2 Call Tree</a></p>
+<p class=c2><a href=#allbranches>1.3 All branches</a></p>
+<p class=c2><a href=#selectedbranches>1.4 Selected branches</a></p>
+<p class=c2><a href=#topcallsbyelapsedtime>1.5 Top calls by elapsed time</a></p>
 <p class=c1><a href=#tables>2. Tables</a></p>
 <h1 id=reports>1. Reports</h1>
 <h2 id=callgraph>1.1 Context-Sensitive Call Graph</h2>
@@ -2313,7 +2508,10 @@ v- ls
 <h3>Find</h3>
 Ctrl-F displays a Find bar which finds function names by either an exact match or a pattern match.
 The pattern matching symbols are ? for any character and * for zero or more characters.
-<h2 id=allbranches>1.2 All branches</h2>
+<h2 id=calltree>1.2 Call Tree</h2>
+The Call Tree report is very similar to the Context-Sensitive Call Graph, but the data is not aggregated.
+Also the 'Count' column, which would be always 1, is replaced by the 'Call Time'.
+<h2 id=allbranches>1.3 All branches</h2>
 The All branches report displays all branches in chronological order.
 Not all data is fetched immediately. More records can be fetched using the Fetch bar provided.
 <h3>Disassembly</h3>
@@ -2339,10 +2537,10 @@ sudo ldconfig
 Ctrl-F displays a Find bar which finds substrings by either an exact match or a regular expression match.
 Refer to Python documentation for the regular expression syntax.
 All columns are searched, but only currently fetched rows are searched.
-<h2 id=selectedbranches>1.3 Selected branches</h2>
+<h2 id=selectedbranches>1.4 Selected branches</h2>
 This is the same as the <a href=#allbranches>All branches</a> report but with the data reduced
 by various selection criteria. A dialog box displays available criteria which are AND'ed together.
-<h3>1.3.1 Time ranges</h3>
+<h3>1.4.1 Time ranges</h3>
 The time ranges hint text shows the total time range. Relative time ranges can also be entered in
 ms, us or ns. Also, negative values are relative to the end of trace.  Examples:
 <pre>
@@ -2353,7 +2551,7 @@ ms, us or ns. Also, negative values are relative to the end of trace.  Examples:
 	-10ms-			The last 10ms
 </pre>
 N.B. Due to the granularity of timestamps, there could be no branches in any given time range.
-<h2 id=topcallsbyelapsedtime>1.4 Top calls by elapsed time</h2>
+<h2 id=topcallsbyelapsedtime>1.5 Top calls by elapsed time</h2>
 The Top calls by elapsed time report displays calls in descending order of time elapsed between when the function was called and when it returned.
 The data is reduced by various selection criteria. A dialog box displays available criteria which are AND'ed together.
 If not all data is fetched, a Fetch bar is provided. Ctrl-F displays a Find bar.
@@ -2489,6 +2687,9 @@ class MainWindow(QMainWindow):
 		if IsSelectable(glb.db, "calls"):
 			reports_menu.addAction(CreateAction("Context-Sensitive Call &Graph", "Create a new window containing a context-sensitive call graph", self.NewCallGraph, self))
 
+		if IsSelectable(glb.db, "calls", "WHERE parent_id >= 0"):
+			reports_menu.addAction(CreateAction("Call &Tree", "Create a new window containing a call tree", self.NewCallTree, self))
+
 		self.EventMenu(GetEventList(glb.db), reports_menu)
 
 		if IsSelectable(glb.db, "calls"):
@@ -2549,6 +2750,9 @@ class MainWindow(QMainWindow):
 	def NewCallGraph(self):
 		CallGraphWindow(self.glb, self)
 
+	def NewCallTree(self):
+		CallTreeWindow(self.glb, self)
+
 	def NewTopCalls(self):
 		dialog = TopCallsDialog(self.glb, self)
 		ret = dialog.exec_()
diff --git a/tools/perf/scripts/python/failed-syscalls-by-pid.py b/tools/perf/scripts/python/failed-syscalls-by-pid.py
index 3648e8b986ec..310efe5e7e23 100644
--- a/tools/perf/scripts/python/failed-syscalls-by-pid.py
+++ b/tools/perf/scripts/python/failed-syscalls-by-pid.py
@@ -58,22 +58,22 @@ def syscalls__sys_exit(event_name, context, common_cpu,
 	raw_syscalls__sys_exit(**locals())
 
 def print_error_totals():
-    if for_comm is not None:
-	    print("\nsyscall errors for %s:\n" % (for_comm))
-    else:
-	    print("\nsyscall errors:\n")
-
-    print("%-30s  %10s" % ("comm [pid]", "count"))
-    print("%-30s  %10s" % ("------------------------------", "----------"))
-
-    comm_keys = syscalls.keys()
-    for comm in comm_keys:
-	    pid_keys = syscalls[comm].keys()
-	    for pid in pid_keys:
-		    print("\n%s [%d]" % (comm, pid))
-		    id_keys = syscalls[comm][pid].keys()
-		    for id in id_keys:
-			    print("  syscall: %-16s" % syscall_name(id))
-			    ret_keys = syscalls[comm][pid][id].keys()
-			    for ret, val in sorted(syscalls[comm][pid][id].items(), key = lambda kv: (kv[1], kv[0]),  reverse = True):
-				    print("    err = %-20s  %10d" % (strerror(ret), val))
+	if for_comm is not None:
+		print("\nsyscall errors for %s:\n" % (for_comm))
+	else:
+		print("\nsyscall errors:\n")
+
+	print("%-30s  %10s" % ("comm [pid]", "count"))
+	print("%-30s  %10s" % ("------------------------------", "----------"))
+
+	comm_keys = syscalls.keys()
+	for comm in comm_keys:
+		pid_keys = syscalls[comm].keys()
+		for pid in pid_keys:
+			print("\n%s [%d]" % (comm, pid))
+			id_keys = syscalls[comm][pid].keys()
+			for id in id_keys:
+				print("  syscall: %-16s" % syscall_name(id))
+				ret_keys = syscalls[comm][pid][id].keys()
+				for ret, val in sorted(syscalls[comm][pid][id].items(), key = lambda kv: (kv[1], kv[0]), reverse = True):
+					print("    err = %-20s  %10d" % (strerror(ret), val))
diff --git a/tools/perf/scripts/python/futex-contention.py b/tools/perf/scripts/python/futex-contention.py
index 0f5cf437b602..0c4841acf75d 100644
--- a/tools/perf/scripts/python/futex-contention.py
+++ b/tools/perf/scripts/python/futex-contention.py
@@ -10,6 +10,8 @@
 #
 # Measures futex contention
 
+from __future__ import print_function
+
 import os, sys
 sys.path.append(os.environ['PERF_EXEC_PATH'] + '/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
 from Util import *
@@ -33,18 +35,18 @@ def syscalls__sys_enter_futex(event, ctxt, cpu, s, ns, tid, comm, callchain,
 
 def syscalls__sys_exit_futex(event, ctxt, cpu, s, ns, tid, comm, callchain,
 			     nr, ret):
-	if thread_blocktime.has_key(tid):
+	if tid in thread_blocktime:
 		elapsed = nsecs(s, ns) - thread_blocktime[tid]
 		add_stats(lock_waits, (tid, thread_thislock[tid]), elapsed)
 		del thread_blocktime[tid]
 		del thread_thislock[tid]
 
 def trace_begin():
-	print "Press control+C to stop and show the summary"
+	print("Press control+C to stop and show the summary")
 
 def trace_end():
 	for (tid, lock) in lock_waits:
 		min, max, avg, count = lock_waits[tid, lock]
-		print "%s[%d] lock %x contended %d times, %d avg ns" % \
-		      (process_names[tid], tid, lock, count, avg)
+		print("%s[%d] lock %x contended %d times, %d avg ns" %
+			(process_names[tid], tid, lock, count, avg))
 
diff --git a/tools/perf/scripts/python/intel-pt-events.py b/tools/perf/scripts/python/intel-pt-events.py
index b19172d673af..a73847c8f548 100644
--- a/tools/perf/scripts/python/intel-pt-events.py
+++ b/tools/perf/scripts/python/intel-pt-events.py
@@ -10,6 +10,8 @@
 # FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
 # more details.
 
+from __future__ import print_function
+
 import os
 import sys
 import struct
@@ -22,34 +24,34 @@ sys.path.append(os.environ['PERF_EXEC_PATH'] + \
 #from Core import *
 
 def trace_begin():
-	print "Intel PT Power Events and PTWRITE"
+	print("Intel PT Power Events and PTWRITE")
 
 def trace_end():
-	print "End"
+	print("End")
 
 def trace_unhandled(event_name, context, event_fields_dict):
-		print ' '.join(['%s=%s'%(k,str(v))for k,v in sorted(event_fields_dict.items())])
+		print(' '.join(['%s=%s'%(k,str(v))for k,v in sorted(event_fields_dict.items())]))
 
 def print_ptwrite(raw_buf):
 	data = struct.unpack_from("<IQ", raw_buf)
 	flags = data[0]
 	payload = data[1]
 	exact_ip = flags & 1
-	print "IP: %u payload: %#x" % (exact_ip, payload),
+	print("IP: %u payload: %#x" % (exact_ip, payload), end=' ')
 
 def print_cbr(raw_buf):
 	data = struct.unpack_from("<BBBBII", raw_buf)
 	cbr = data[0]
 	f = (data[4] + 500) / 1000
 	p = ((cbr * 1000 / data[2]) + 5) / 10
-	print "%3u  freq: %4u MHz  (%3u%%)" % (cbr, f, p),
+	print("%3u  freq: %4u MHz  (%3u%%)" % (cbr, f, p), end=' ')
 
 def print_mwait(raw_buf):
 	data = struct.unpack_from("<IQ", raw_buf)
 	payload = data[1]
 	hints = payload & 0xff
 	extensions = (payload >> 32) & 0x3
-	print "hints: %#x extensions: %#x" % (hints, extensions),
+	print("hints: %#x extensions: %#x" % (hints, extensions), end=' ')
 
 def print_pwre(raw_buf):
 	data = struct.unpack_from("<IQ", raw_buf)
@@ -57,13 +59,14 @@ def print_pwre(raw_buf):
 	hw = (payload >> 7) & 1
 	cstate = (payload >> 12) & 0xf
 	subcstate = (payload >> 8) & 0xf
-	print "hw: %u cstate: %u sub-cstate: %u" % (hw, cstate, subcstate),
+	print("hw: %u cstate: %u sub-cstate: %u" % (hw, cstate, subcstate),
+		end=' ')
 
 def print_exstop(raw_buf):
 	data = struct.unpack_from("<I", raw_buf)
 	flags = data[0]
 	exact_ip = flags & 1
-	print "IP: %u" % (exact_ip),
+	print("IP: %u" % (exact_ip), end=' ')
 
 def print_pwrx(raw_buf):
 	data = struct.unpack_from("<IQ", raw_buf)
@@ -71,36 +74,39 @@ def print_pwrx(raw_buf):
 	deepest_cstate = payload & 0xf
 	last_cstate = (payload >> 4) & 0xf
 	wake_reason = (payload >> 8) & 0xf
-	print "deepest cstate: %u last cstate: %u wake reason: %#x" % (deepest_cstate, last_cstate, wake_reason),
+	print("deepest cstate: %u last cstate: %u wake reason: %#x" %
+		(deepest_cstate, last_cstate, wake_reason), end=' ')
 
 def print_common_start(comm, sample, name):
 	ts = sample["time"]
 	cpu = sample["cpu"]
 	pid = sample["pid"]
 	tid = sample["tid"]
-	print "%16s %5u/%-5u [%03u] %9u.%09u %7s:" % (comm, pid, tid, cpu, ts / 1000000000, ts %1000000000, name),
+	print("%16s %5u/%-5u [%03u] %9u.%09u %7s:" %
+		(comm, pid, tid, cpu, ts / 1000000000, ts %1000000000, name),
+		end=' ')
 
 def print_common_ip(sample, symbol, dso):
 	ip = sample["ip"]
-	print "%16x %s (%s)" % (ip, symbol, dso)
+	print("%16x %s (%s)" % (ip, symbol, dso))
 
 def process_event(param_dict):
-        event_attr = param_dict["attr"]
-        sample     = param_dict["sample"]
-        raw_buf    = param_dict["raw_buf"]
-        comm       = param_dict["comm"]
-        name       = param_dict["ev_name"]
-
-        # Symbol and dso info are not always resolved
-        if (param_dict.has_key("dso")):
-                dso = param_dict["dso"]
-        else:
-                dso = "[unknown]"
-
-        if (param_dict.has_key("symbol")):
-                symbol = param_dict["symbol"]
-        else:
-                symbol = "[unknown]"
+	event_attr = param_dict["attr"]
+	sample	 = param_dict["sample"]
+	raw_buf	= param_dict["raw_buf"]
+	comm	   = param_dict["comm"]
+	name	   = param_dict["ev_name"]
+
+	# Symbol and dso info are not always resolved
+	if "dso" in param_dict:
+		dso = param_dict["dso"]
+	else:
+		dso = "[unknown]"
+
+	if "symbol" in param_dict:
+		symbol = param_dict["symbol"]
+	else:
+		symbol = "[unknown]"
 
 	if name == "ptwrite":
 		print_common_start(comm, sample, name)
diff --git a/tools/perf/scripts/python/mem-phys-addr.py b/tools/perf/scripts/python/mem-phys-addr.py
index fb0bbcbfa0f0..1f332e72b9b0 100644
--- a/tools/perf/scripts/python/mem-phys-addr.py
+++ b/tools/perf/scripts/python/mem-phys-addr.py
@@ -44,12 +44,13 @@ def print_memory_type():
 	print("%-40s  %10s  %10s\n" % ("Memory type", "count", "percentage"), end='')
 	print("%-40s  %10s  %10s\n" % ("----------------------------------------",
 					"-----------", "-----------"),
-                                        end='');
+					end='');
 	total = sum(load_mem_type_cnt.values())
 	for mem_type, count in sorted(load_mem_type_cnt.most_common(), \
 					key = lambda kv: (kv[1], kv[0]), reverse = True):
-		print("%-40s  %10d  %10.1f%%\n" % (mem_type, count, 100 * count / total),
-                        end='')
+		print("%-40s  %10d  %10.1f%%\n" %
+			(mem_type, count, 100 * count / total),
+			end='')
 
 def trace_begin():
 	parse_iomem()
diff --git a/tools/perf/scripts/python/net_dropmonitor.py b/tools/perf/scripts/python/net_dropmonitor.py
index 212557a02c50..101059971738 100755
--- a/tools/perf/scripts/python/net_dropmonitor.py
+++ b/tools/perf/scripts/python/net_dropmonitor.py
@@ -7,7 +7,7 @@ import os
 import sys
 
 sys.path.append(os.environ['PERF_EXEC_PATH'] + \
-		'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
+	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
 
 from perf_trace_context import *
 from Core import *
diff --git a/tools/perf/scripts/python/netdev-times.py b/tools/perf/scripts/python/netdev-times.py
index 267bda49325d..ea0c8b90a783 100644
--- a/tools/perf/scripts/python/netdev-times.py
+++ b/tools/perf/scripts/python/netdev-times.py
@@ -124,14 +124,16 @@ def print_receive(hunk):
 		event = event_list[i]
 		if event['event_name'] == 'napi_poll':
 			print(PF_NAPI_POLL %
-			    (diff_msec(base_t, event['event_t']), event['dev']))
+				(diff_msec(base_t, event['event_t']),
+				event['dev']))
 			if i == len(event_list) - 1:
 				print("")
 			else:
 				print(PF_JOINT)
 		else:
 			print(PF_NET_RECV %
-			    (diff_msec(base_t, event['event_t']), event['skbaddr'],
+				(diff_msec(base_t, event['event_t']),
+				event['skbaddr'],
 				event['len']))
 			if 'comm' in event.keys():
 				print(PF_WJOINT)
@@ -256,7 +258,7 @@ def irq__irq_handler_exit(name, context, cpu, sec, nsec, pid, comm, callchain, i
 	all_event_list.append(event_info)
 
 def napi__napi_poll(name, context, cpu, sec, nsec, pid, comm, callchain, napi,
-                    dev_name, work=None, budget=None):
+		dev_name, work=None, budget=None):
 	event_info = (name, context, cpu, nsecs(sec, nsec), pid, comm,
 			napi, dev_name, work, budget)
 	all_event_list.append(event_info)
@@ -353,7 +355,7 @@ def handle_irq_softirq_exit(event_info):
 	if irq_list == [] or event_list == 0:
 		return
 	rec_data = {'sirq_ent_t':sirq_ent_t, 'sirq_ext_t':time,
-		    'irq_list':irq_list, 'event_list':event_list}
+			'irq_list':irq_list, 'event_list':event_list}
 	# merge information realted to a NET_RX softirq
 	receive_hunk_list.append(rec_data)
 
@@ -390,7 +392,7 @@ def handle_netif_receive_skb(event_info):
 		skbaddr, skblen, dev_name) = event_info
 	if cpu in net_rx_dic.keys():
 		rec_data = {'event_name':'netif_receive_skb',
-			    'event_t':time, 'skbaddr':skbaddr, 'len':skblen}
+				'event_t':time, 'skbaddr':skbaddr, 'len':skblen}
 		event_list = net_rx_dic[cpu]['event_list']
 		event_list.append(rec_data)
 		rx_skb_list.insert(0, rec_data)
diff --git a/tools/perf/scripts/python/sched-migration.py b/tools/perf/scripts/python/sched-migration.py
index 3984bf51f3c5..8196e3087c9e 100644
--- a/tools/perf/scripts/python/sched-migration.py
+++ b/tools/perf/scripts/python/sched-migration.py
@@ -14,10 +14,10 @@ import sys
 
 from collections import defaultdict
 try:
-    from UserList import UserList
+	from UserList import UserList
 except ImportError:
-    # Python 3: UserList moved to the collections package
-    from collections import UserList
+	# Python 3: UserList moved to the collections package
+	from collections import UserList
 
 sys.path.append(os.environ['PERF_EXEC_PATH'] + \
 	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
diff --git a/tools/perf/scripts/python/sctop.py b/tools/perf/scripts/python/sctop.py
index 987ffae7c8ca..6e0278dcb092 100644
--- a/tools/perf/scripts/python/sctop.py
+++ b/tools/perf/scripts/python/sctop.py
@@ -13,9 +13,9 @@ from __future__ import print_function
 import os, sys, time
 
 try:
-        import thread
+	import thread
 except ImportError:
-        import _thread as thread
+	import _thread as thread
 
 sys.path.append(os.environ['PERF_EXEC_PATH'] + \
 	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
@@ -75,11 +75,12 @@ def print_syscall_totals(interval):
 
 		print("%-40s  %10s" % ("event", "count"))
 		print("%-40s  %10s" %
-                        ("----------------------------------------",
-                        "----------"))
+			("----------------------------------------",
+			"----------"))
 
-		for id, val in sorted(syscalls.items(), key = lambda kv: (kv[1], kv[0]), \
-					      reverse = True):
+		for id, val in sorted(syscalls.items(),
+				key = lambda kv: (kv[1], kv[0]),
+				reverse = True):
 			try:
 				print("%-40s  %10d" % (syscall_name(id), val))
 			except TypeError:
diff --git a/tools/perf/scripts/python/stackcollapse.py b/tools/perf/scripts/python/stackcollapse.py
index 5e703efaddcc..b1c4def1410a 100755
--- a/tools/perf/scripts/python/stackcollapse.py
+++ b/tools/perf/scripts/python/stackcollapse.py
@@ -27,7 +27,7 @@ from collections import defaultdict
 from optparse import OptionParser, make_option
 
 sys.path.append(os.environ['PERF_EXEC_PATH'] + \
-                '/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
+    '/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
 
 from perf_trace_context import *
 from Core import *
diff --git a/tools/perf/scripts/python/syscall-counts-by-pid.py b/tools/perf/scripts/python/syscall-counts-by-pid.py
index 42782487b0e9..f254e40c6f0f 100644
--- a/tools/perf/scripts/python/syscall-counts-by-pid.py
+++ b/tools/perf/scripts/python/syscall-counts-by-pid.py
@@ -39,11 +39,10 @@ def trace_end():
 	print_syscall_totals()
 
 def raw_syscalls__sys_enter(event_name, context, common_cpu,
-	common_secs, common_nsecs, common_pid, common_comm,
-	common_callchain, id, args):
-
+		common_secs, common_nsecs, common_pid, common_comm,
+		common_callchain, id, args):
 	if (for_comm and common_comm != for_comm) or \
-	   (for_pid  and common_pid  != for_pid ):
+		(for_pid and common_pid != for_pid ):
 		return
 	try:
 		syscalls[common_comm][common_pid][id] += 1
@@ -51,26 +50,26 @@ def raw_syscalls__sys_enter(event_name, context, common_cpu,
 		syscalls[common_comm][common_pid][id] = 1
 
 def syscalls__sys_enter(event_name, context, common_cpu,
-	common_secs, common_nsecs, common_pid, common_comm,
-	id, args):
+		common_secs, common_nsecs, common_pid, common_comm,
+		id, args):
 	raw_syscalls__sys_enter(**locals())
 
 def print_syscall_totals():
-    if for_comm is not None:
-	    print("\nsyscall events for %s:\n" % (for_comm))
-    else:
-	    print("\nsyscall events by comm/pid:\n")
-
-    print("%-40s  %10s" % ("comm [pid]/syscalls", "count"))
-    print("%-40s  %10s" % ("----------------------------------------",
-                            "----------"))
-
-    comm_keys = syscalls.keys()
-    for comm in comm_keys:
-	    pid_keys = syscalls[comm].keys()
-	    for pid in pid_keys:
-		    print("\n%s [%d]" % (comm, pid))
-		    id_keys = syscalls[comm][pid].keys()
-		    for id, val in sorted(syscalls[comm][pid].items(), \
-				  key = lambda kv: (kv[1], kv[0]),  reverse = True):
-			    print("  %-38s  %10d" % (syscall_name(id), val))
+	if for_comm is not None:
+		print("\nsyscall events for %s:\n" % (for_comm))
+	else:
+		print("\nsyscall events by comm/pid:\n")
+
+	print("%-40s  %10s" % ("comm [pid]/syscalls", "count"))
+	print("%-40s  %10s" % ("----------------------------------------",
+				"----------"))
+
+	comm_keys = syscalls.keys()
+	for comm in comm_keys:
+		pid_keys = syscalls[comm].keys()
+		for pid in pid_keys:
+			print("\n%s [%d]" % (comm, pid))
+			id_keys = syscalls[comm][pid].keys()
+			for id, val in sorted(syscalls[comm][pid].items(),
+				key = lambda kv: (kv[1], kv[0]), reverse = True):
+				print("  %-38s  %10d" % (syscall_name(id), val))
diff --git a/tools/perf/scripts/python/syscall-counts.py b/tools/perf/scripts/python/syscall-counts.py
index 0ebd89cfd42c..8adb95ff1664 100644
--- a/tools/perf/scripts/python/syscall-counts.py
+++ b/tools/perf/scripts/python/syscall-counts.py
@@ -36,8 +36,8 @@ def trace_end():
 	print_syscall_totals()
 
 def raw_syscalls__sys_enter(event_name, context, common_cpu,
-	common_secs, common_nsecs, common_pid, common_comm,
-	common_callchain, id, args):
+		common_secs, common_nsecs, common_pid, common_comm,
+		common_callchain, id, args):
 	if for_comm is not None:
 		if common_comm != for_comm:
 			return
@@ -47,20 +47,19 @@ def raw_syscalls__sys_enter(event_name, context, common_cpu,
 		syscalls[id] = 1
 
 def syscalls__sys_enter(event_name, context, common_cpu,
-	common_secs, common_nsecs, common_pid, common_comm,
-	id, args):
+		common_secs, common_nsecs, common_pid, common_comm, id, args):
 	raw_syscalls__sys_enter(**locals())
 
 def print_syscall_totals():
-    if for_comm is not None:
-	    print("\nsyscall events for %s:\n" % (for_comm))
-    else:
-	    print("\nsyscall events:\n")
-
-    print("%-40s  %10s" % ("event", "count"))
-    print("%-40s  %10s" % ("----------------------------------------",
-                              "-----------"))
-
-    for id, val in sorted(syscalls.items(), key = lambda kv: (kv[1], kv[0]), \
-				  reverse = True):
-	    print("%-40s  %10d" % (syscall_name(id), val))
+	if for_comm is not None:
+		print("\nsyscall events for %s:\n" % (for_comm))
+	else:
+		print("\nsyscall events:\n")
+
+	print("%-40s  %10s" % ("event", "count"))
+	print("%-40s  %10s" % ("----------------------------------------",
+				"-----------"))
+
+	for id, val in sorted(syscalls.items(),
+			key = lambda kv: (kv[1], kv[0]), reverse = True):
+		print("%-40s  %10d" % (syscall_name(id), val))
diff --git a/tools/perf/trace/beauty/msg_flags.c b/tools/perf/trace/beauty/msg_flags.c
index d66c66315987..ea68db08b8e7 100644
--- a/tools/perf/trace/beauty/msg_flags.c
+++ b/tools/perf/trace/beauty/msg_flags.c
@@ -29,7 +29,7 @@ static size_t syscall_arg__scnprintf_msg_flags(char *bf, size_t size,
 		return scnprintf(bf, size, "NONE");
 #define	P_MSG_FLAG(n) \
 	if (flags & MSG_##n) { \
-		printed += scnprintf(bf + printed, size - printed, "%s%s", printed ? "|" : "", show_prefix ? prefix : "", #n); \
+		printed += scnprintf(bf + printed, size - printed, "%s%s%s", printed ? "|" : "", show_prefix ? prefix : "", #n); \
 		flags &= ~MSG_##n; \
 	}
 
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 11a8a447a3af..5f6dbbf5d749 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -198,18 +198,18 @@ static void ins__delete(struct ins_operands *ops)
 }
 
 static int ins__raw_scnprintf(struct ins *ins, char *bf, size_t size,
-			      struct ins_operands *ops)
+			      struct ins_operands *ops, int max_ins_name)
 {
-	return scnprintf(bf, size, "%-6s %s", ins->name, ops->raw);
+	return scnprintf(bf, size, "%-*s %s", max_ins_name, ins->name, ops->raw);
 }
 
 int ins__scnprintf(struct ins *ins, char *bf, size_t size,
-		  struct ins_operands *ops)
+		   struct ins_operands *ops, int max_ins_name)
 {
 	if (ins->ops->scnprintf)
-		return ins->ops->scnprintf(ins, bf, size, ops);
+		return ins->ops->scnprintf(ins, bf, size, ops, max_ins_name);
 
-	return ins__raw_scnprintf(ins, bf, size, ops);
+	return ins__raw_scnprintf(ins, bf, size, ops, max_ins_name);
 }
 
 bool ins__is_fused(struct arch *arch, const char *ins1, const char *ins2)
@@ -273,18 +273,18 @@ static int call__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 }
 
 static int call__scnprintf(struct ins *ins, char *bf, size_t size,
-			   struct ins_operands *ops)
+			   struct ins_operands *ops, int max_ins_name)
 {
 	if (ops->target.sym)
-		return scnprintf(bf, size, "%-6s %s", ins->name, ops->target.sym->name);
+		return scnprintf(bf, size, "%-*s %s", max_ins_name, ins->name, ops->target.sym->name);
 
 	if (ops->target.addr == 0)
-		return ins__raw_scnprintf(ins, bf, size, ops);
+		return ins__raw_scnprintf(ins, bf, size, ops, max_ins_name);
 
 	if (ops->target.name)
-		return scnprintf(bf, size, "%-6s %s", ins->name, ops->target.name);
+		return scnprintf(bf, size, "%-*s %s", max_ins_name, ins->name, ops->target.name);
 
-	return scnprintf(bf, size, "%-6s *%" PRIx64, ins->name, ops->target.addr);
+	return scnprintf(bf, size, "%-*s *%" PRIx64, max_ins_name, ins->name, ops->target.addr);
 }
 
 static struct ins_ops call_ops = {
@@ -388,15 +388,15 @@ static int jump__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 }
 
 static int jump__scnprintf(struct ins *ins, char *bf, size_t size,
-			   struct ins_operands *ops)
+			   struct ins_operands *ops, int max_ins_name)
 {
 	const char *c;
 
 	if (!ops->target.addr || ops->target.offset < 0)
-		return ins__raw_scnprintf(ins, bf, size, ops);
+		return ins__raw_scnprintf(ins, bf, size, ops, max_ins_name);
 
 	if (ops->target.outside && ops->target.sym != NULL)
-		return scnprintf(bf, size, "%-6s %s", ins->name, ops->target.sym->name);
+		return scnprintf(bf, size, "%-*s %s", max_ins_name, ins->name, ops->target.sym->name);
 
 	c = strchr(ops->raw, ',');
 	c = validate_comma(c, ops);
@@ -415,7 +415,7 @@ static int jump__scnprintf(struct ins *ins, char *bf, size_t size,
 			c++;
 	}
 
-	return scnprintf(bf, size, "%-6s %.*s%" PRIx64,
+	return scnprintf(bf, size, "%-*s %.*s%" PRIx64, max_ins_name,
 			 ins->name, c ? c - ops->raw : 0, ops->raw,
 			 ops->target.offset);
 }
@@ -483,16 +483,16 @@ static int lock__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 }
 
 static int lock__scnprintf(struct ins *ins, char *bf, size_t size,
-			   struct ins_operands *ops)
+			   struct ins_operands *ops, int max_ins_name)
 {
 	int printed;
 
 	if (ops->locked.ins.ops == NULL)
-		return ins__raw_scnprintf(ins, bf, size, ops);
+		return ins__raw_scnprintf(ins, bf, size, ops, max_ins_name);
 
-	printed = scnprintf(bf, size, "%-6s ", ins->name);
+	printed = scnprintf(bf, size, "%-*s ", max_ins_name, ins->name);
 	return printed + ins__scnprintf(&ops->locked.ins, bf + printed,
-					size - printed, ops->locked.ops);
+					size - printed, ops->locked.ops, max_ins_name);
 }
 
 static void lock__delete(struct ins_operands *ops)
@@ -564,9 +564,9 @@ static int mov__parse(struct arch *arch, struct ins_operands *ops, struct map_sy
 }
 
 static int mov__scnprintf(struct ins *ins, char *bf, size_t size,
-			   struct ins_operands *ops)
+			   struct ins_operands *ops, int max_ins_name)
 {
-	return scnprintf(bf, size, "%-6s %s,%s", ins->name,
+	return scnprintf(bf, size, "%-*s %s,%s", max_ins_name, ins->name,
 			 ops->source.name ?: ops->source.raw,
 			 ops->target.name ?: ops->target.raw);
 }
@@ -604,9 +604,9 @@ static int dec__parse(struct arch *arch __maybe_unused, struct ins_operands *ops
 }
 
 static int dec__scnprintf(struct ins *ins, char *bf, size_t size,
-			   struct ins_operands *ops)
+			   struct ins_operands *ops, int max_ins_name)
 {
-	return scnprintf(bf, size, "%-6s %s", ins->name,
+	return scnprintf(bf, size, "%-*s %s", max_ins_name, ins->name,
 			 ops->target.name ?: ops->target.raw);
 }
 
@@ -616,9 +616,9 @@ static struct ins_ops dec_ops = {
 };
 
 static int nop__scnprintf(struct ins *ins __maybe_unused, char *bf, size_t size,
-			  struct ins_operands *ops __maybe_unused)
+			  struct ins_operands *ops __maybe_unused, int max_ins_name)
 {
-	return scnprintf(bf, size, "%-6s", "nop");
+	return scnprintf(bf, size, "%-*s", max_ins_name, "nop");
 }
 
 static struct ins_ops nop_ops = {
@@ -1232,12 +1232,12 @@ void disasm_line__free(struct disasm_line *dl)
 	annotation_line__delete(&dl->al);
 }
 
-int disasm_line__scnprintf(struct disasm_line *dl, char *bf, size_t size, bool raw)
+int disasm_line__scnprintf(struct disasm_line *dl, char *bf, size_t size, bool raw, int max_ins_name)
 {
 	if (raw || !dl->ins.ops)
-		return scnprintf(bf, size, "%-6s %s", dl->ins.name, dl->ops.raw);
+		return scnprintf(bf, size, "%-*s %s", max_ins_name, dl->ins.name, dl->ops.raw);
 
-	return ins__scnprintf(&dl->ins, bf, size, &dl->ops);
+	return ins__scnprintf(&dl->ins, bf, size, &dl->ops, max_ins_name);
 }
 
 static void annotation_line__add(struct annotation_line *al, struct list_head *head)
@@ -2414,12 +2414,30 @@ static inline int width_jumps(int n)
 	return 1;
 }
 
+static int annotation__max_ins_name(struct annotation *notes)
+{
+	int max_name = 0, len;
+	struct annotation_line *al;
+
+        list_for_each_entry(al, &notes->src->source, node) {
+		if (al->offset == -1)
+			continue;
+
+		len = strlen(disasm_line(al)->ins.name);
+		if (max_name < len)
+			max_name = len;
+	}
+
+	return max_name;
+}
+
 void annotation__init_column_widths(struct annotation *notes, struct symbol *sym)
 {
 	notes->widths.addr = notes->widths.target =
 		notes->widths.min_addr = hex_width(symbol__size(sym));
 	notes->widths.max_addr = hex_width(sym->end);
 	notes->widths.jumps = width_jumps(notes->max_jump_sources);
+	notes->widths.max_ins_name = annotation__max_ins_name(notes);
 }
 
 void annotation__update_column_widths(struct annotation *notes)
@@ -2583,7 +2601,7 @@ static void disasm_line__write(struct disasm_line *dl, struct annotation *notes,
 		obj__printf(obj, "  ");
 	}
 
-	disasm_line__scnprintf(dl, bf, size, !notes->options->use_offset);
+	disasm_line__scnprintf(dl, bf, size, !notes->options->use_offset, notes->widths.max_ins_name);
 }
 
 static void ipc_coverage_string(char *bf, int size, struct annotation *notes)
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 95053cab41fe..df34fe483164 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -59,14 +59,14 @@ struct ins_ops {
 	void (*free)(struct ins_operands *ops);
 	int (*parse)(struct arch *arch, struct ins_operands *ops, struct map_symbol *ms);
 	int (*scnprintf)(struct ins *ins, char *bf, size_t size,
-			 struct ins_operands *ops);
+			 struct ins_operands *ops, int max_ins_name);
 };
 
 bool ins__is_jump(const struct ins *ins);
 bool ins__is_call(const struct ins *ins);
 bool ins__is_ret(const struct ins *ins);
 bool ins__is_lock(const struct ins *ins);
-int ins__scnprintf(struct ins *ins, char *bf, size_t size, struct ins_operands *ops);
+int ins__scnprintf(struct ins *ins, char *bf, size_t size, struct ins_operands *ops, int max_ins_name);
 bool ins__is_fused(struct arch *arch, const char *ins1, const char *ins2);
 
 #define ANNOTATION__IPC_WIDTH 6
@@ -219,7 +219,7 @@ int __annotation__scnprintf_samples_period(struct annotation *notes,
 					   struct perf_evsel *evsel,
 					   bool show_freq);
 
-int disasm_line__scnprintf(struct disasm_line *dl, char *bf, size_t size, bool raw);
+int disasm_line__scnprintf(struct disasm_line *dl, char *bf, size_t size, bool raw, int max_ins_name);
 size_t disasm__fprintf(struct list_head *head, FILE *fp);
 void symbol__calc_percent(struct symbol *sym, struct perf_evsel *evsel);
 
@@ -289,6 +289,7 @@ struct annotation {
 		u8		target;
 		u8		min_addr;
 		u8		max_addr;
+		u8		max_ins_name;
 	} widths;
 	bool			have_cycles;
 	struct annotated_source *src;
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 267e54df511b..fb76b6b232d4 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1918,7 +1918,8 @@ static struct dso *load_dso(const char *name)
 	if (!map)
 		return NULL;
 
-	map__load(map);
+	if (map__load(map) < 0)
+		pr_err("File '%s' not found or has no symbols.\n", name);
 
 	dso = dso__get(map->dso);
 
diff --git a/tools/perf/util/c++/clang.cpp b/tools/perf/util/c++/clang.cpp
index 39c0004f2886..fc361c3f8570 100644
--- a/tools/perf/util/c++/clang.cpp
+++ b/tools/perf/util/c++/clang.cpp
@@ -156,7 +156,7 @@ getBPFObjectFromModule(llvm::Module *Module)
 #endif
 	if (NotAdded) {
 		llvm::errs() << "TargetMachine can't emit a file of this type\n";
-		return std::unique_ptr<llvm::SmallVectorImpl<char>>(nullptr);;
+		return std::unique_ptr<llvm::SmallVectorImpl<char>>(nullptr);
 	}
 	PM.run(*Module);
 
diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 7bd5ddeb7a41..e098e189f93e 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -237,7 +237,7 @@ static int open_file(struct perf_data *data)
 	     open_file_read(data) : open_file_write(data);
 
 	if (fd < 0) {
-		free(data->file.path);
+		zfree(&data->file.path);
 		return -1;
 	}
 
@@ -270,7 +270,7 @@ int perf_data__open(struct perf_data *data)
 
 void perf_data__close(struct perf_data *data)
 {
-	free(data->file.path);
+	zfree(&data->file.path);
 	close(data->file.fd);
 }
 
diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index de9b4769d06c..d7315a00c731 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -510,18 +510,23 @@ int db_export__call_path(struct db_export *dbe, struct call_path *cp)
 	return 0;
 }
 
-int db_export__call_return(struct db_export *dbe, struct call_return *cr)
+int db_export__call_return(struct db_export *dbe, struct call_return *cr,
+			   u64 *parent_db_id)
 {
 	int err;
 
-	if (cr->db_id)
-		return 0;
-
 	err = db_export__call_path(dbe, cr->cp);
 	if (err)
 		return err;
 
-	cr->db_id = ++dbe->call_return_last_db_id;
+	if (!cr->db_id)
+		cr->db_id = ++dbe->call_return_last_db_id;
+
+	if (parent_db_id) {
+		if (!*parent_db_id)
+			*parent_db_id = ++dbe->call_return_last_db_id;
+		cr->parent_db_id = *parent_db_id;
+	}
 
 	if (dbe->export_call_return)
 		return dbe->export_call_return(dbe, cr);
diff --git a/tools/perf/util/db-export.h b/tools/perf/util/db-export.h
index 67bc6b8ad2d6..4e2424c89df9 100644
--- a/tools/perf/util/db-export.h
+++ b/tools/perf/util/db-export.h
@@ -104,6 +104,7 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 int db_export__branch_types(struct db_export *dbe);
 
 int db_export__call_path(struct db_export *dbe, struct call_path *cp);
-int db_export__call_return(struct db_export *dbe, struct call_return *cr);
+int db_export__call_return(struct db_export *dbe, struct call_return *cr,
+			   u64 *parent_db_id);
 
 #endif
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 08cedb643ea6..ed20f4379956 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -230,18 +230,33 @@ void perf_evlist__set_leader(struct perf_evlist *evlist)
 	}
 }
 
-void perf_event_attr__set_max_precise_ip(struct perf_event_attr *attr)
+void perf_event_attr__set_max_precise_ip(struct perf_event_attr *pattr)
 {
-	attr->precise_ip = 3;
+	struct perf_event_attr attr = {
+		.type		= PERF_TYPE_HARDWARE,
+		.config		= PERF_COUNT_HW_CPU_CYCLES,
+		.exclude_kernel	= 1,
+		.precise_ip	= 3,
+	};
 
-	while (attr->precise_ip != 0) {
-		int fd = sys_perf_event_open(attr, 0, -1, -1, 0);
+	event_attr_init(&attr);
+
+	/*
+	 * Unnamed union member, not supported as struct member named
+	 * initializer in older compilers such as gcc 4.4.7
+	 */
+	attr.sample_period = 1;
+
+	while (attr.precise_ip != 0) {
+		int fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
 		if (fd != -1) {
 			close(fd);
 			break;
 		}
-		--attr->precise_ip;
+		--attr.precise_ip;
 	}
+
+	pattr->precise_ip = attr.precise_ip;
 }
 
 int __perf_evlist__add_default(struct perf_evlist *evlist, bool precise)
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index dfe2958e6287..3bbf73e979c0 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -294,20 +294,12 @@ struct perf_evsel *perf_evsel__new_cycles(bool precise)
 
 	if (!precise)
 		goto new_event;
-	/*
-	 * Unnamed union member, not supported as struct member named
-	 * initializer in older compilers such as gcc 4.4.7
-	 *
-	 * Just for probing the precise_ip:
-	 */
-	attr.sample_period = 1;
 
 	perf_event_attr__set_max_precise_ip(&attr);
 	/*
 	 * Now let the usual logic to set up the perf_event_attr defaults
 	 * to kick in when we return and before perf_evsel__open() is called.
 	 */
-	attr.sample_period = 0;
 new_event:
 	evsel = perf_evsel__new(&attr);
 	if (evsel == NULL)
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 669f961316f0..f9eb95bf3938 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -396,11 +396,8 @@ static int hist_entry__init(struct hist_entry *he,
 		 * adding new entries.  So we need to save a copy.
 		 */
 		he->branch_info = malloc(sizeof(*he->branch_info));
-		if (he->branch_info == NULL) {
-			map__zput(he->ms.map);
-			free(he->stat_acc);
-			return -ENOMEM;
-		}
+		if (he->branch_info == NULL)
+			goto err;
 
 		memcpy(he->branch_info, template->branch_info,
 		       sizeof(*he->branch_info));
@@ -419,22 +416,16 @@ static int hist_entry__init(struct hist_entry *he,
 
 	if (he->raw_data) {
 		he->raw_data = memdup(he->raw_data, he->raw_size);
+		if (he->raw_data == NULL)
+			goto err_infos;
+	}
 
-		if (he->raw_data == NULL) {
-			map__put(he->ms.map);
-			if (he->branch_info) {
-				map__put(he->branch_info->from.map);
-				map__put(he->branch_info->to.map);
-				free(he->branch_info);
-			}
-			if (he->mem_info) {
-				map__put(he->mem_info->iaddr.map);
-				map__put(he->mem_info->daddr.map);
-			}
-			free(he->stat_acc);
-			return -ENOMEM;
-		}
+	if (he->srcline) {
+		he->srcline = strdup(he->srcline);
+		if (he->srcline == NULL)
+			goto err_rawdata;
 	}
+
 	INIT_LIST_HEAD(&he->pairs.node);
 	thread__get(he->thread);
 	he->hroot_in  = RB_ROOT_CACHED;
@@ -444,6 +435,24 @@ static int hist_entry__init(struct hist_entry *he,
 		he->leaf = true;
 
 	return 0;
+
+err_rawdata:
+	free(he->raw_data);
+
+err_infos:
+	if (he->branch_info) {
+		map__put(he->branch_info->from.map);
+		map__put(he->branch_info->to.map);
+		free(he->branch_info);
+	}
+	if (he->mem_info) {
+		map__put(he->mem_info->iaddr.map);
+		map__put(he->mem_info->daddr.map);
+	}
+err:
+	map__zput(he->ms.map);
+	free(he->stat_acc);
+	return -ENOMEM;
 }
 
 static void *hist_entry__zalloc(size_t size)
@@ -606,7 +615,7 @@ __hists__add_entry(struct hists *hists,
 			.map	= al->map,
 			.sym	= al->sym,
 		},
-		.srcline = al->srcline ? strdup(al->srcline) : NULL,
+		.srcline = (char *) al->srcline,
 		.socket	 = al->socket,
 		.cpu	 = al->cpu,
 		.cpumode = al->cpumode,
@@ -963,7 +972,7 @@ iter_add_next_cumulative_entry(struct hist_entry_iter *iter,
 			.map = al->map,
 			.sym = al->sym,
 		},
-		.srcline = al->srcline ? strdup(al->srcline) : NULL,
+		.srcline = (char *) al->srcline,
 		.parent = iter->parent,
 		.raw_data = sample->raw_data,
 		.raw_size = sample->raw_size,
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 0c0180c67574..47025bc727e1 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -328,35 +328,19 @@ static int intel_bts_get_next_insn(struct intel_bts_queue *btsq, u64 ip)
 {
 	struct machine *machine = btsq->bts->machine;
 	struct thread *thread;
-	struct addr_location al;
 	unsigned char buf[INTEL_PT_INSN_BUF_SZ];
 	ssize_t len;
-	int x86_64;
-	uint8_t cpumode;
+	bool x86_64;
 	int err = -1;
 
-	if (machine__kernel_ip(machine, ip))
-		cpumode = PERF_RECORD_MISC_KERNEL;
-	else
-		cpumode = PERF_RECORD_MISC_USER;
-
 	thread = machine__find_thread(machine, -1, btsq->tid);
 	if (!thread)
 		return -1;
 
-	if (!thread__find_map(thread, cpumode, ip, &al) || !al.map->dso)
-		goto out_put;
-
-	len = dso__data_read_addr(al.map->dso, al.map, machine, ip, buf,
-				  INTEL_PT_INSN_BUF_SZ);
+	len = thread__memcpy(thread, machine, buf, ip, INTEL_PT_INSN_BUF_SZ, &x86_64);
 	if (len <= 0)
 		goto out_put;
 
-	/* Load maps to ensure dso->is_64_bit has been updated */
-	map__load(al.map);
-
-	x86_64 = al.map->dso->is_64_bit;
-
 	if (intel_pt_get_insn(buf, len, x86_64, &btsq->intel_pt_insn))
 		goto out_put;
 
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 3b497bab4324..6d288237887b 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -2531,6 +2531,8 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 	}
 
 	pt->timeless_decoding = intel_pt_timeless_decoding(pt);
+	if (pt->timeless_decoding && !pt->tc.time_mult)
+		pt->tc.time_mult = 1;
 	pt->have_tsc = intel_pt_have_tsc(pt);
 	pt->sampling_mode = false;
 	pt->est_tsc = !pt->timeless_decoding;
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 51d437f55d18..6199a3174ab9 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -752,6 +752,19 @@ perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
 	return NULL;
 }
 
+static int pmu_max_precise(const char *name)
+{
+	char path[PATH_MAX];
+	int max_precise = -1;
+
+	scnprintf(path, PATH_MAX,
+		 "bus/event_source/devices/%s/caps/max_precise",
+		 name);
+
+	sysfs__read_int(path, &max_precise);
+	return max_precise;
+}
+
 static struct perf_pmu *pmu_lookup(const char *name)
 {
 	struct perf_pmu *pmu;
@@ -784,6 +797,7 @@ static struct perf_pmu *pmu_lookup(const char *name)
 	pmu->name = strdup(name);
 	pmu->type = type;
 	pmu->is_uncore = pmu_is_uncore(name);
+	pmu->max_precise = pmu_max_precise(name);
 	pmu_add_cpu_aliases(&aliases, pmu);
 
 	INIT_LIST_HEAD(&pmu->format);
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 47253c3daf55..bd9ec2704a57 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -26,6 +26,7 @@ struct perf_pmu {
 	__u32 type;
 	bool selectable;
 	bool is_uncore;
+	int max_precise;
 	struct perf_event_attr *default_config;
 	struct cpu_map *cpus;
 	struct list_head format;  /* HEAD struct perf_pmu_format -> list */
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 0030f9b9bf7e..a1b8d9649ca7 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -472,9 +472,12 @@ static struct debuginfo *open_debuginfo(const char *module, struct nsinfo *nsi,
 					strcpy(reason, "(unknown)");
 			} else
 				dso__strerror_load(dso, reason, STRERR_BUFSIZE);
-			if (!silent)
-				pr_err("Failed to find the path for %s: %s\n",
-					module ?: "kernel", reason);
+			if (!silent) {
+				if (module)
+					pr_err("Module %s is not loaded, please specify its full path name.\n", module);
+				else
+					pr_err("Failed to find the path for the kernel: %s\n", reason);
+			}
 			return NULL;
 		}
 		path = dso->long_name;
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 0e17db41b49b..09604c6508f0 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1173,7 +1173,7 @@ static int python_export_call_return(struct db_export *dbe,
 	u64 comm_db_id = cr->comm ? cr->comm->db_id : 0;
 	PyObject *t;
 
-	t = tuple_new(11);
+	t = tuple_new(12);
 
 	tuple_set_u64(t, 0, cr->db_id);
 	tuple_set_u64(t, 1, cr->thread->db_id);
@@ -1186,6 +1186,7 @@ static int python_export_call_return(struct db_export *dbe,
 	tuple_set_u64(t, 8, cr->return_ref);
 	tuple_set_u64(t, 9, cr->cp->parent->db_id);
 	tuple_set_s32(t, 10, cr->flags);
+	tuple_set_u64(t, 11, cr->parent_db_id);
 
 	call_object(tables->call_return_handler, t, "call_return_table");
 
@@ -1194,11 +1195,12 @@ static int python_export_call_return(struct db_export *dbe,
 	return 0;
 }
 
-static int python_process_call_return(struct call_return *cr, void *data)
+static int python_process_call_return(struct call_return *cr, u64 *parent_db_id,
+				      void *data)
 {
 	struct db_export *dbe = data;
 
-	return db_export__call_return(dbe, cr);
+	return db_export__call_return(dbe, cr, parent_db_id);
 }
 
 static void python_process_general_event(struct perf_sample *sample,
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index c764bbc91009..db643f3c2b95 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -140,7 +140,7 @@ struct perf_session *perf_session__new(struct perf_data *data,
 
 		if (perf_data__is_read(data)) {
 			if (perf_session__open(session) < 0)
-				goto out_close;
+				goto out_delete;
 
 			/*
 			 * set session attributes that are present in perf.data
@@ -181,8 +181,6 @@ struct perf_session *perf_session__new(struct perf_data *data,
 
 	return session;
 
- out_close:
-	perf_data__close(data);
  out_delete:
 	perf_session__delete(session);
  out:
diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index a8b45168513c..41942c2aaa18 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -49,6 +49,7 @@ enum retpoline_state_t {
  * @timestamp: timestamp (if known)
  * @ref: external reference (e.g. db_id of sample)
  * @branch_count: the branch count when the entry was created
+ * @db_id: id used for db-export
  * @cp: call path
  * @no_call: a 'call' was not seen
  * @trace_end: a 'call' but trace ended
@@ -59,6 +60,7 @@ struct thread_stack_entry {
 	u64 timestamp;
 	u64 ref;
 	u64 branch_count;
+	u64 db_id;
 	struct call_path *cp;
 	bool no_call;
 	bool trace_end;
@@ -280,12 +282,14 @@ static int thread_stack__call_return(struct thread *thread,
 		.comm = ts->comm,
 		.db_id = 0,
 	};
+	u64 *parent_db_id;
 
 	tse = &ts->stack[idx];
 	cr.cp = tse->cp;
 	cr.call_time = tse->timestamp;
 	cr.return_time = timestamp;
 	cr.branch_count = ts->branch_count - tse->branch_count;
+	cr.db_id = tse->db_id;
 	cr.call_ref = tse->ref;
 	cr.return_ref = ref;
 	if (tse->no_call)
@@ -295,7 +299,14 @@ static int thread_stack__call_return(struct thread *thread,
 	if (tse->non_call)
 		cr.flags |= CALL_RETURN_NON_CALL;
 
-	return crp->process(&cr, crp->data);
+	/*
+	 * The parent db_id must be assigned before exporting the child. Note
+	 * it is not possible to export the parent first because its information
+	 * is not yet complete because its 'return' has not yet been processed.
+	 */
+	parent_db_id = idx ? &(tse - 1)->db_id : NULL;
+
+	return crp->process(&cr, parent_db_id, crp->data);
 }
 
 static int __thread_stack__flush(struct thread *thread, struct thread_stack *ts)
@@ -484,7 +495,7 @@ void thread_stack__sample(struct thread *thread, int cpu,
 }
 
 struct call_return_processor *
-call_return_processor__new(int (*process)(struct call_return *cr, void *data),
+call_return_processor__new(int (*process)(struct call_return *cr, u64 *parent_db_id, void *data),
 			   void *data)
 {
 	struct call_return_processor *crp;
@@ -537,6 +548,7 @@ static int thread_stack__push_cp(struct thread_stack *ts, u64 ret_addr,
 	tse->no_call = no_call;
 	tse->trace_end = trace_end;
 	tse->non_call = false;
+	tse->db_id = 0;
 
 	return 0;
 }
diff --git a/tools/perf/util/thread-stack.h b/tools/perf/util/thread-stack.h
index b7c04e19ad41..9c45f947f5a9 100644
--- a/tools/perf/util/thread-stack.h
+++ b/tools/perf/util/thread-stack.h
@@ -55,6 +55,7 @@ enum {
  * @call_ref: external reference to 'call' sample (e.g. db_id)
  * @return_ref:  external reference to 'return' sample (e.g. db_id)
  * @db_id: id used for db-export
+ * @parent_db_id: id of parent call used for db-export
  * @flags: Call/Return flags
  */
 struct call_return {
@@ -67,6 +68,7 @@ struct call_return {
 	u64 call_ref;
 	u64 return_ref;
 	u64 db_id;
+	u64 parent_db_id;
 	u32 flags;
 };
 
@@ -79,7 +81,7 @@ struct call_return {
  */
 struct call_return_processor {
 	struct call_path_root *cpr;
-	int (*process)(struct call_return *cr, void *data);
+	int (*process)(struct call_return *cr, u64 *parent_db_id, void *data);
 	void *data;
 };
 
@@ -93,7 +95,7 @@ void thread_stack__free(struct thread *thread);
 size_t thread_stack__depth(struct thread *thread, int cpu);
 
 struct call_return_processor *
-call_return_processor__new(int (*process)(struct call_return *cr, void *data),
+call_return_processor__new(int (*process)(struct call_return *cr, u64 *parent_db_id, void *data),
 			   void *data);
 void call_return_processor__free(struct call_return_processor *crp);
 int thread_stack__process(struct thread *thread, struct comm *comm,
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 4c179fef442d..50678d318185 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -12,6 +12,7 @@
 #include "debug.h"
 #include "namespaces.h"
 #include "comm.h"
+#include "map.h"
 #include "symbol.h"
 #include "unwind.h"
 
@@ -393,3 +394,25 @@ struct thread *thread__main_thread(struct machine *machine, struct thread *threa
 
 	return machine__find_thread(machine, thread->pid_, thread->pid_);
 }
+
+int thread__memcpy(struct thread *thread, struct machine *machine,
+		   void *buf, u64 ip, int len, bool *is64bit)
+{
+       u8 cpumode = PERF_RECORD_MISC_USER;
+       struct addr_location al;
+       long offset;
+
+       if (machine__kernel_ip(machine, ip))
+               cpumode = PERF_RECORD_MISC_KERNEL;
+
+       if (!thread__find_map(thread, cpumode, ip, &al) || !al.map->dso ||
+	   al.map->dso->data.status == DSO_DATA_STATUS_ERROR ||
+	   map__load(al.map) < 0)
+               return -1;
+
+       offset = al.map->map_ip(al.map, ip);
+       if (is64bit)
+               *is64bit = al.map->dso->is_64_bit;
+
+       return dso__data_read_offset(al.map->dso, machine, offset, buf, len);
+}
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 8276ffeec556..cf8375c017a0 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -113,6 +113,9 @@ struct symbol *thread__find_symbol_fb(struct thread *thread, u8 cpumode,
 void thread__find_cpumode_addr_location(struct thread *thread, u64 addr,
 					struct addr_location *al);
 
+int thread__memcpy(struct thread *thread, struct machine *machine,
+		   void *buf, u64 ip, int len, bool *is64bit);
+
 static inline void *thread__priv(struct thread *thread)
 {
 	return thread->priv;
diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 6193b46050a5..0f53baec660e 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -11,6 +11,8 @@
 #include "perf.h"
 #include "debug.h"
 #include "time-utils.h"
+#include "session.h"
+#include "evlist.h"
 
 int parse_nsec_time(const char *str, u64 *ptime)
 {
@@ -374,7 +376,7 @@ bool perf_time__ranges_skip_sample(struct perf_time_interval *ptime_buf,
 	struct perf_time_interval *ptime;
 	int i;
 
-	if ((timestamp == 0) || (num == 0))
+	if ((!ptime_buf) || (timestamp == 0) || (num == 0))
 		return false;
 
 	if (num == 1)
@@ -396,6 +398,53 @@ bool perf_time__ranges_skip_sample(struct perf_time_interval *ptime_buf,
 	return (i == num) ? true : false;
 }
 
+int perf_time__parse_for_ranges(const char *time_str,
+				struct perf_session *session,
+				struct perf_time_interval **ranges,
+				int *range_size, int *range_num)
+{
+	struct perf_time_interval *ptime_range;
+	int size, num, ret;
+
+	ptime_range = perf_time__range_alloc(time_str, &size);
+	if (!ptime_range)
+		return -ENOMEM;
+
+	if (perf_time__parse_str(ptime_range, time_str) != 0) {
+		if (session->evlist->first_sample_time == 0 &&
+		    session->evlist->last_sample_time == 0) {
+			pr_err("HINT: no first/last sample time found in perf data.\n"
+			       "Please use latest perf binary to execute 'perf record'\n"
+			       "(if '--buildid-all' is enabled, please set '--timestamp-boundary').\n");
+			ret = -EINVAL;
+			goto error;
+		}
+
+		num = perf_time__percent_parse_str(
+				ptime_range, size,
+				time_str,
+				session->evlist->first_sample_time,
+				session->evlist->last_sample_time);
+
+		if (num < 0) {
+			pr_err("Invalid time string\n");
+			ret = -EINVAL;
+			goto error;
+		}
+	} else {
+		num = 1;
+	}
+
+	*range_size = size;
+	*range_num = num;
+	*ranges = ptime_range;
+	return 0;
+
+error:
+	free(ptime_range);
+	return ret;
+}
+
 int timestamp__scnprintf_usec(u64 timestamp, char *buf, size_t sz)
 {
 	u64  sec = timestamp / NSEC_PER_SEC;
diff --git a/tools/perf/util/time-utils.h b/tools/perf/util/time-utils.h
index 70b177d2b98c..b923de44e36f 100644
--- a/tools/perf/util/time-utils.h
+++ b/tools/perf/util/time-utils.h
@@ -23,6 +23,12 @@ bool perf_time__skip_sample(struct perf_time_interval *ptime, u64 timestamp);
 bool perf_time__ranges_skip_sample(struct perf_time_interval *ptime_buf,
 				   int num, u64 timestamp);
 
+struct perf_session;
+
+int perf_time__parse_for_ranges(const char *str, struct perf_session *session,
+				struct perf_time_interval **ranges,
+				int *range_size, int *range_num);
+
 int timestamp__scnprintf_usec(u64 timestamp, char *buf, size_t sz);
 
 int fetch_current_timestamp(char *buf, size_t sz);

