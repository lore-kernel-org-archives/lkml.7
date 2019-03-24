Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E4DC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 14:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B87222E5
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 14:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbfCXOOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 10:14:45 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43622 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728697AbfCXOOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 10:14:44 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h83su-0001z3-Du; Sun, 24 Mar 2019 15:14:02 +0100
Date:   Sun, 24 Mar 2019 14:12:21 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] perf updates for 5.1
References: <155343674151.28403.7455818401538063350.tglx@nanos.tec.linutronix.de>
Message-ID: <155343674152.28403.2449766826580543141.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

A larger set of perf updates:

  Note, that not all of them are strictly fixes, but that's solely the tip
  maintainers fault as they let the timely -rc1 pull request fall through
  the cracks for various reasons including travel. So I'm sending this
  nevertheless because rebasing and distangling fixes and updates would be
  a mess and risky as well. As of tomorrow, a strict fixes separation is
  happening again. Sorry for the slip-up.

 - Kernel:

   - Handle RECORD_MMAP vs. RECORD_MMAP2 correctly so different consumers
     of the mmap event get what they requested.

 - Tools:

   - A larger set of updates to perf record/report/scripts vs. time stamp
     handling

   - More Python3 fixups

   - A pile of memory leak plumbing

   - perf BPF improvements and fixes

   - Finalize the perf.data directory storage

Thanks,

	tglx

------------------>
Adrian Hunter (1):
      perf probe: Fix getting the kernel map

Andi Kleen (22):
      perf script: Support insn output for normal samples
      perf report: Support output in nanoseconds
      perf time-utils: Add utility function to print time stamps in nanoseconds
      perf report: Parse time quantum
      perf report: Use less for scripts output
      perf script: Filter COMM/FORK/.. events by CPU
      perf report: Support time sort key
      perf report: Support running scripts for current time range
      perf report: Support builtin perf script in scripts menu
      perf report: Implement browsing of individual samples
      perf tools: Add some new tips describing the new options
      perf script: Add array bound checking to list_scripts
      perf ui browser: Fix ui popup argv browser for many entries
      perf tools report: Add custom scripts to script menu
      perf list: Filter metrics too
      perf record: Allow to limit number of reported perf.data files
      perf record: Clarify help for --switch-output
      perf report: Show all sort keys in help output
      perf report: Indicate JITed code better in report
      perf script: Support relative time
      perf stat: Fix --no-scale
      perf stat: Improve scaling

Arnaldo Carvalho de Melo (5):
      perf tools: Update x86's syscall_64.tbl, no change in tools/perf behaviour
      tools headers uapi: Sync copy of asm-generic/unistd.h with the kernel sources
      tools headers uapi: Update linux/in.h copy
      tools lib bpf: Fix the build by adding a missing stdarg.h include
      perf evsel: Free evsel->counts in perf_evsel__exit()

Changbin Du (15):
      perf tools: Add doc about how to build perf with Asan and UBSan
      perf list: Don't forget to drop the reference to the allocated thread_map
      perf tools: Fix errors under optimization level '-Og'
      perf config: Fix an error in the config template documentation
      perf config: Fix a memory leak in collect_config()
      perf build-id: Fix memory leak in print_sdt_events()
      perf top: Delete the evlist before perf_session, fixing heap-use-after-free issue
      perf top: Fix error handling in cmd_top()
      perf hist: Add missing map__put() in error case
      perf map: Remove map from 'names' tree in __maps__remove()
      perf maps: Purge all maps from the 'names' tree
      perf top: Fix global-buffer-overflow issue
      perf tests: Fix a memory leak of cpu_map object in the openat_syscall_event_on_all_cpus test
      perf tests: Fix memory leak by expr__find_other() in test__expr()
      perf tests: Fix a memory leak in test__perf_evsel__tp_sched_test()

Jiri Olsa (6):
      perf data: Support having perf.data stored as a directory
      perf data: Don't store auxtrace index for directory data file
      perf data: Add perf_data__update_dir() function
      perf data: Make perf_data__size() work over directory
      perf header: Add DIR_FORMAT feature to describe directory data
      perf session: Add process callback to reader object

Mamatha Inamdar (1):
      perf vendor events: Remove P8 HW events which are not supported

Martin Liška (1):
      perf vendor events amd: perf PMU events for AMD Family 17h

Song Liu (19):
      perf record: Replace option --bpf-event with --no-bpf-event
      tools lib bpf: Introduce bpf_program__get_prog_info_linear()
      bpftool: use bpf_program__get_prog_info_linear() in prog.c:do_dump()
      perf bpf: Synthesize bpf events with bpf_program__get_prog_info_linear()
      perf bpf: Make synthesize_bpf_events() receive perf_session pointer instead of perf_tool
      perf bpf: Save bpf_prog_info in a rbtree in perf_env
      perf bpf: Save bpf_prog_info information as headers to perf.data
      perf bpf: Save BTF in a rbtree in perf_env
      perf bpf: Save BTF information as headers to perf.data
      perf top: Add option --no-bpf-event
      perf feature detection: Add -lopcodes to feature-libbfd
      perf symbols: Introduce DSO_BINARY_TYPE__BPF_PROG_INFO
      perf bpf: Process PERF_BPF_EVENT_PROG_LOAD for annotation
      perf build: Check what binutils's 'disassembler()' signature to use
      perf annotate: Enable annotation of BPF programs
      perf evlist: Introduce side band thread
      perf tools: Save bpf_prog_info and BTF of new BPF programs
      perf bpf: Extract logic to create program names from perf_event__synthesize_one_bpf_prog()
      perf bpf: Show more BPF program info in print_bpf_prog_info()

Stephane Eranian (1):
      perf/core: Restore mmap record type correctly

Tony Jones (4):
      perf script python: Add Python3 support to exported-sql-viewer.py
      perf script python: Add Python3 support to export-to-postgresql.py
      perf script python: Add Python3 support to export-to-sqlite.py
      perf script python: Add printdate function to SQL exporters


 kernel/events/core.c                               |   2 +
 tools/arch/arm64/include/uapi/asm/unistd.h         |   2 +
 tools/bpf/bpftool/prog.c                           | 266 ++-------
 tools/build/Makefile.feature                       |   6 +-
 tools/build/feature/test-all.c                     |   5 +
 tools/include/uapi/asm-generic/unistd.h            | 149 ++++--
 tools/include/uapi/linux/in.h                      |   9 +-
 tools/lib/bpf/libbpf.c                             | 253 ++++++++-
 tools/lib/bpf/libbpf.h                             |  64 +++
 tools/lib/bpf/libbpf.map                           |   3 +
 tools/perf/Documentation/Build.txt                 |  24 +
 tools/perf/Documentation/perf-config.txt           |  16 +-
 tools/perf/Documentation/perf-record.txt           |   4 +
 tools/perf/Documentation/perf-report.txt           |  13 +
 tools/perf/Documentation/perf-script.txt           |   3 +
 tools/perf/Documentation/perf-stat.txt             |   5 +-
 tools/perf/Documentation/tips.txt                  |   7 +
 tools/perf/Makefile.config                         |  15 +-
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |   6 +-
 tools/perf/arch/x86/util/Build                     |   1 +
 tools/perf/arch/x86/util/archinsn.c                |  26 +
 tools/perf/bench/epoll-ctl.c                       |   2 +-
 tools/perf/bench/epoll-wait.c                      |   2 +-
 tools/perf/builtin-list.c                          |   2 +-
 tools/perf/builtin-record.c                        |  54 +-
 tools/perf/builtin-report.c                        |  50 +-
 tools/perf/builtin-script.c                        | 129 +++--
 tools/perf/builtin-stat.c                          |   3 +-
 tools/perf/builtin-top.c                           |  62 ++-
 tools/perf/builtin.h                               |   3 +-
 tools/perf/perf.c                                  |   1 +
 tools/perf/perf.h                                  |   2 +-
 .../perf/pmu-events/arch/powerpc/power8/other.json | 594 ---------------------
 .../perf/pmu-events/arch/x86/amdfam17h/branch.json |  12 +
 .../perf/pmu-events/arch/x86/amdfam17h/cache.json  | 287 ++++++++++
 tools/perf/pmu-events/arch/x86/amdfam17h/core.json | 134 +++++
 .../arch/x86/amdfam17h/floating-point.json         | 168 ++++++
 .../perf/pmu-events/arch/x86/amdfam17h/memory.json | 162 ++++++
 .../perf/pmu-events/arch/x86/amdfam17h/other.json  |  65 +++
 tools/perf/pmu-events/arch/x86/mapfile.csv         |   1 +
 tools/perf/scripts/python/export-to-postgresql.py  |  61 ++-
 tools/perf/scripts/python/export-to-sqlite.py      |  26 +-
 tools/perf/scripts/python/exported-sql-viewer.py   |  42 +-
 tools/perf/tests/attr/test-record-C0               |   2 +-
 tools/perf/tests/attr/test-record-basic            |   2 +-
 tools/perf/tests/attr/test-record-branch-any       |   2 +-
 .../perf/tests/attr/test-record-branch-filter-any  |   2 +-
 .../tests/attr/test-record-branch-filter-any_call  |   2 +-
 .../tests/attr/test-record-branch-filter-any_ret   |   2 +-
 tools/perf/tests/attr/test-record-branch-filter-hv |   2 +-
 .../tests/attr/test-record-branch-filter-ind_call  |   2 +-
 tools/perf/tests/attr/test-record-branch-filter-k  |   2 +-
 tools/perf/tests/attr/test-record-branch-filter-u  |   2 +-
 tools/perf/tests/attr/test-record-count            |   2 +-
 tools/perf/tests/attr/test-record-data             |   2 +-
 tools/perf/tests/attr/test-record-freq             |   2 +-
 tools/perf/tests/attr/test-record-graph-default    |   2 +-
 tools/perf/tests/attr/test-record-graph-dwarf      |   2 +-
 tools/perf/tests/attr/test-record-graph-fp         |   2 +-
 tools/perf/tests/attr/test-record-group            |   2 +-
 tools/perf/tests/attr/test-record-group-sampling   |   2 +-
 tools/perf/tests/attr/test-record-group1           |   2 +-
 tools/perf/tests/attr/test-record-no-buffering     |   2 +-
 tools/perf/tests/attr/test-record-no-inherit       |   2 +-
 tools/perf/tests/attr/test-record-no-samples       |   2 +-
 tools/perf/tests/attr/test-record-period           |   2 +-
 tools/perf/tests/attr/test-record-raw              |   2 +-
 tools/perf/tests/backward-ring-buffer.c            |   2 +-
 tools/perf/tests/evsel-tp-sched.c                  |   1 +
 tools/perf/tests/expr.c                            |   5 +-
 tools/perf/tests/openat-syscall-all-cpus.c         |   4 +-
 tools/perf/ui/browser.c                            |  10 +-
 tools/perf/ui/browsers/Build                       |   1 +
 tools/perf/ui/browsers/annotate.c                  |   2 +-
 tools/perf/ui/browsers/hists.c                     | 141 ++++-
 tools/perf/ui/browsers/res_sample.c                |  91 ++++
 tools/perf/ui/browsers/scripts.c                   | 274 +++++-----
 tools/perf/util/annotate.c                         | 163 +++++-
 tools/perf/util/annotate.h                         |   1 +
 tools/perf/util/archinsn.h                         |  12 +
 tools/perf/util/bpf-event.c                        | 425 +++++++++++----
 tools/perf/util/bpf-event.h                        |  42 +-
 tools/perf/util/build-id.c                         |   1 +
 tools/perf/util/config.c                           |   3 +-
 tools/perf/util/data.c                             | 107 +++-
 tools/perf/util/data.h                             |  14 +-
 tools/perf/util/dso.c                              |  43 +-
 tools/perf/util/dso.h                              |   8 +
 tools/perf/util/env.c                              | 155 ++++++
 tools/perf/util/env.h                              |  24 +
 tools/perf/util/evlist.c                           | 119 +++++
 tools/perf/util/evlist.h                           |  12 +
 tools/perf/util/evsel.c                            |   8 +-
 tools/perf/util/evsel.h                            |   6 +
 tools/perf/util/header.c                           | 295 +++++++++-
 tools/perf/util/header.h                           |   7 +
 tools/perf/util/hist.c                             |  54 +-
 tools/perf/util/hist.h                             |  31 +-
 tools/perf/util/map.c                              |  18 +
 tools/perf/util/ordered-events.c                   |   2 +
 tools/perf/util/parse-events.c                     |   2 +
 tools/perf/util/probe-event.c                      |   6 +-
 tools/perf/util/session.c                          |  28 +-
 tools/perf/util/sort.c                             |  91 ++++
 tools/perf/util/sort.h                             |  12 +
 tools/perf/util/stat.c                             |  12 +-
 tools/perf/util/symbol.c                           |   5 +
 tools/perf/util/symbol_conf.h                      |   3 +
 tools/perf/util/time-utils.c                       |   8 +
 tools/perf/util/time-utils.h                       |   1 +
 110 files changed, 3724 insertions(+), 1314 deletions(-)
 create mode 100644 tools/perf/arch/x86/util/archinsn.c
 create mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/branch.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/core.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/other.json
 create mode 100644 tools/perf/ui/browsers/res_sample.c
 create mode 100644 tools/perf/util/archinsn.h

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1032a16bd186..72d06e302e99 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7189,6 +7189,7 @@ static void perf_event_mmap_output(struct perf_event *event,
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
 	int size = mmap_event->event_id.header.size;
+	u32 type = mmap_event->event_id.header.type;
 	int ret;
 
 	if (!perf_event_mmap_match(event, data))
@@ -7232,6 +7233,7 @@ static void perf_event_mmap_output(struct perf_event *event,
 	perf_output_end(&handle);
 out:
 	mmap_event->event_id.header.size = size;
+	mmap_event->event_id.header.type = type;
 }
 
 static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
diff --git a/tools/arch/arm64/include/uapi/asm/unistd.h b/tools/arch/arm64/include/uapi/asm/unistd.h
index dae1584cf017..4703d218663a 100644
--- a/tools/arch/arm64/include/uapi/asm/unistd.h
+++ b/tools/arch/arm64/include/uapi/asm/unistd.h
@@ -17,5 +17,7 @@
 
 #define __ARCH_WANT_RENAMEAT
 #define __ARCH_WANT_NEW_STAT
+#define __ARCH_WANT_SET_GET_RLIMIT
+#define __ARCH_WANT_TIME32_SYSCALLS
 
 #include <asm-generic/unistd.h>
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 8ef80d65a474..d2be5a06c339 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -401,41 +401,31 @@ static int do_show(int argc, char **argv)
 
 static int do_dump(int argc, char **argv)
 {
-	unsigned int finfo_rec_size, linfo_rec_size, jited_linfo_rec_size;
-	void *func_info = NULL, *linfo = NULL, *jited_linfo = NULL;
-	unsigned int nr_finfo, nr_linfo = 0, nr_jited_linfo = 0;
+	struct bpf_prog_info_linear *info_linear;
 	struct bpf_prog_linfo *prog_linfo = NULL;
-	unsigned long *func_ksyms = NULL;
-	struct bpf_prog_info info = {};
-	unsigned int *func_lens = NULL;
+	enum {DUMP_JITED, DUMP_XLATED} mode;
 	const char *disasm_opt = NULL;
-	unsigned int nr_func_ksyms;
-	unsigned int nr_func_lens;
+	struct bpf_prog_info *info;
 	struct dump_data dd = {};
-	__u32 len = sizeof(info);
+	void *func_info = NULL;
 	struct btf *btf = NULL;
-	unsigned int buf_size;
 	char *filepath = NULL;
 	bool opcodes = false;
 	bool visual = false;
 	char func_sig[1024];
 	unsigned char *buf;
 	bool linum = false;
-	__u32 *member_len;
-	__u64 *member_ptr;
+	__u32 member_len;
+	__u64 arrays;
 	ssize_t n;
-	int err;
 	int fd;
 
 	if (is_prefix(*argv, "jited")) {
 		if (disasm_init())
 			return -1;
-
-		member_len = &info.jited_prog_len;
-		member_ptr = &info.jited_prog_insns;
+		mode = DUMP_JITED;
 	} else if (is_prefix(*argv, "xlated")) {
-		member_len = &info.xlated_prog_len;
-		member_ptr = &info.xlated_prog_insns;
+		mode = DUMP_XLATED;
 	} else {
 		p_err("expected 'xlated' or 'jited', got: %s", *argv);
 		return -1;
@@ -474,175 +464,50 @@ static int do_dump(int argc, char **argv)
 		return -1;
 	}
 
-	err = bpf_obj_get_info_by_fd(fd, &info, &len);
-	if (err) {
-		p_err("can't get prog info: %s", strerror(errno));
-		return -1;
-	}
-
-	if (!*member_len) {
-		p_info("no instructions returned");
-		close(fd);
-		return 0;
-	}
+	if (mode == DUMP_JITED)
+		arrays = 1UL << BPF_PROG_INFO_JITED_INSNS;
+	else
+		arrays = 1UL << BPF_PROG_INFO_XLATED_INSNS;
 
-	buf_size = *member_len;
+	arrays |= 1UL << BPF_PROG_INFO_JITED_KSYMS;
+	arrays |= 1UL << BPF_PROG_INFO_JITED_FUNC_LENS;
+	arrays |= 1UL << BPF_PROG_INFO_FUNC_INFO;
+	arrays |= 1UL << BPF_PROG_INFO_LINE_INFO;
+	arrays |= 1UL << BPF_PROG_INFO_JITED_LINE_INFO;
 
-	buf = malloc(buf_size);
-	if (!buf) {
-		p_err("mem alloc failed");
-		close(fd);
+	info_linear = bpf_program__get_prog_info_linear(fd, arrays);
+	close(fd);
+	if (IS_ERR_OR_NULL(info_linear)) {
+		p_err("can't get prog info: %s", strerror(errno));
 		return -1;
 	}
 
-	nr_func_ksyms = info.nr_jited_ksyms;
-	if (nr_func_ksyms) {
-		func_ksyms = malloc(nr_func_ksyms * sizeof(__u64));
-		if (!func_ksyms) {
-			p_err("mem alloc failed");
-			close(fd);
-			goto err_free;
-		}
-	}
-
-	nr_func_lens = info.nr_jited_func_lens;
-	if (nr_func_lens) {
-		func_lens = malloc(nr_func_lens * sizeof(__u32));
-		if (!func_lens) {
-			p_err("mem alloc failed");
-			close(fd);
+	info = &info_linear->info;
+	if (mode == DUMP_JITED) {
+		if (info->jited_prog_len == 0) {
+			p_info("no instructions returned");
 			goto err_free;
 		}
-	}
-
-	nr_finfo = info.nr_func_info;
-	finfo_rec_size = info.func_info_rec_size;
-	if (nr_finfo && finfo_rec_size) {
-		func_info = malloc(nr_finfo * finfo_rec_size);
-		if (!func_info) {
-			p_err("mem alloc failed");
-			close(fd);
+		buf = (unsigned char *)(info->jited_prog_insns);
+		member_len = info->jited_prog_len;
+	} else {	/* DUMP_XLATED */
+		if (info->xlated_prog_len == 0) {
+			p_err("error retrieving insn dump: kernel.kptr_restrict set?");
 			goto err_free;
 		}
+		buf = (unsigned char *)info->xlated_prog_insns;
+		member_len = info->xlated_prog_len;
 	}
 
-	linfo_rec_size = info.line_info_rec_size;
-	if (info.nr_line_info && linfo_rec_size && info.btf_id) {
-		nr_linfo = info.nr_line_info;
-		linfo = malloc(nr_linfo * linfo_rec_size);
-		if (!linfo) {
-			p_err("mem alloc failed");
-			close(fd);
-			goto err_free;
-		}
-	}
-
-	jited_linfo_rec_size = info.jited_line_info_rec_size;
-	if (info.nr_jited_line_info &&
-	    jited_linfo_rec_size &&
-	    info.nr_jited_ksyms &&
-	    info.nr_jited_func_lens &&
-	    info.btf_id) {
-		nr_jited_linfo = info.nr_jited_line_info;
-		jited_linfo = malloc(nr_jited_linfo * jited_linfo_rec_size);
-		if (!jited_linfo) {
-			p_err("mem alloc failed");
-			close(fd);
-			goto err_free;
-		}
-	}
-
-	memset(&info, 0, sizeof(info));
-
-	*member_ptr = ptr_to_u64(buf);
-	*member_len = buf_size;
-	info.jited_ksyms = ptr_to_u64(func_ksyms);
-	info.nr_jited_ksyms = nr_func_ksyms;
-	info.jited_func_lens = ptr_to_u64(func_lens);
-	info.nr_jited_func_lens = nr_func_lens;
-	info.nr_func_info = nr_finfo;
-	info.func_info_rec_size = finfo_rec_size;
-	info.func_info = ptr_to_u64(func_info);
-	info.nr_line_info = nr_linfo;
-	info.line_info_rec_size = linfo_rec_size;
-	info.line_info = ptr_to_u64(linfo);
-	info.nr_jited_line_info = nr_jited_linfo;
-	info.jited_line_info_rec_size = jited_linfo_rec_size;
-	info.jited_line_info = ptr_to_u64(jited_linfo);
-
-	err = bpf_obj_get_info_by_fd(fd, &info, &len);
-	close(fd);
-	if (err) {
-		p_err("can't get prog info: %s", strerror(errno));
-		goto err_free;
-	}
-
-	if (*member_len > buf_size) {
-		p_err("too many instructions returned");
-		goto err_free;
-	}
-
-	if (info.nr_jited_ksyms > nr_func_ksyms) {
-		p_err("too many addresses returned");
-		goto err_free;
-	}
-
-	if (info.nr_jited_func_lens > nr_func_lens) {
-		p_err("too many values returned");
-		goto err_free;
-	}
-
-	if (info.nr_func_info != nr_finfo) {
-		p_err("incorrect nr_func_info %d vs. expected %d",
-		      info.nr_func_info, nr_finfo);
-		goto err_free;
-	}
-
-	if (info.func_info_rec_size != finfo_rec_size) {
-		p_err("incorrect func_info_rec_size %d vs. expected %d",
-		      info.func_info_rec_size, finfo_rec_size);
-		goto err_free;
-	}
-
-	if (linfo && info.nr_line_info != nr_linfo) {
-		p_err("incorrect nr_line_info %u vs. expected %u",
-		      info.nr_line_info, nr_linfo);
-		goto err_free;
-	}
-
-	if (info.line_info_rec_size != linfo_rec_size) {
-		p_err("incorrect line_info_rec_size %u vs. expected %u",
-		      info.line_info_rec_size, linfo_rec_size);
-		goto err_free;
-	}
-
-	if (jited_linfo && info.nr_jited_line_info != nr_jited_linfo) {
-		p_err("incorrect nr_jited_line_info %u vs. expected %u",
-		      info.nr_jited_line_info, nr_jited_linfo);
-		goto err_free;
-	}
-
-	if (info.jited_line_info_rec_size != jited_linfo_rec_size) {
-		p_err("incorrect jited_line_info_rec_size %u vs. expected %u",
-		      info.jited_line_info_rec_size, jited_linfo_rec_size);
-		goto err_free;
-	}
-
-	if ((member_len == &info.jited_prog_len &&
-	     info.jited_prog_insns == 0) ||
-	    (member_len == &info.xlated_prog_len &&
-	     info.xlated_prog_insns == 0)) {
-		p_err("error retrieving insn dump: kernel.kptr_restrict set?");
-		goto err_free;
-	}
-
-	if (info.btf_id && btf__get_from_id(info.btf_id, &btf)) {
+	if (info->btf_id && btf__get_from_id(info->btf_id, &btf)) {
 		p_err("failed to get btf");
 		goto err_free;
 	}
 
-	if (nr_linfo) {
-		prog_linfo = bpf_prog_linfo__new(&info);
+	func_info = (void *)info->func_info;
+
+	if (info->nr_line_info) {
+		prog_linfo = bpf_prog_linfo__new(info);
 		if (!prog_linfo)
 			p_info("error in processing bpf_line_info.  continue without it.");
 	}
@@ -655,9 +520,9 @@ static int do_dump(int argc, char **argv)
 			goto err_free;
 		}
 
-		n = write(fd, buf, *member_len);
+		n = write(fd, buf, member_len);
 		close(fd);
-		if (n != *member_len) {
+		if (n != member_len) {
 			p_err("error writing output file: %s",
 			      n < 0 ? strerror(errno) : "short write");
 			goto err_free;
@@ -665,19 +530,19 @@ static int do_dump(int argc, char **argv)
 
 		if (json_output)
 			jsonw_null(json_wtr);
-	} else if (member_len == &info.jited_prog_len) {
+	} else if (mode == DUMP_JITED) {
 		const char *name = NULL;
 
-		if (info.ifindex) {
-			name = ifindex_to_bfd_params(info.ifindex,
-						     info.netns_dev,
-						     info.netns_ino,
+		if (info->ifindex) {
+			name = ifindex_to_bfd_params(info->ifindex,
+						     info->netns_dev,
+						     info->netns_ino,
 						     &disasm_opt);
 			if (!name)
 				goto err_free;
 		}
 
-		if (info.nr_jited_func_lens && info.jited_func_lens) {
+		if (info->nr_jited_func_lens && info->jited_func_lens) {
 			struct kernel_sym *sym = NULL;
 			struct bpf_func_info *record;
 			char sym_name[SYM_MAX_NAME];
@@ -685,17 +550,16 @@ static int do_dump(int argc, char **argv)
 			__u64 *ksyms = NULL;
 			__u32 *lens;
 			__u32 i;
-
-			if (info.nr_jited_ksyms) {
+			if (info->nr_jited_ksyms) {
 				kernel_syms_load(&dd);
-				ksyms = (__u64 *) info.jited_ksyms;
+				ksyms = (__u64 *) info->jited_ksyms;
 			}
 
 			if (json_output)
 				jsonw_start_array(json_wtr);
 
-			lens = (__u32 *) info.jited_func_lens;
-			for (i = 0; i < info.nr_jited_func_lens; i++) {
+			lens = (__u32 *) info->jited_func_lens;
+			for (i = 0; i < info->nr_jited_func_lens; i++) {
 				if (ksyms) {
 					sym = kernel_syms_search(&dd, ksyms[i]);
 					if (sym)
@@ -707,7 +571,7 @@ static int do_dump(int argc, char **argv)
 				}
 
 				if (func_info) {
-					record = func_info + i * finfo_rec_size;
+					record = func_info + i * info->func_info_rec_size;
 					btf_dumper_type_only(btf, record->type_id,
 							     func_sig,
 							     sizeof(func_sig));
@@ -744,49 +608,37 @@ static int do_dump(int argc, char **argv)
 			if (json_output)
 				jsonw_end_array(json_wtr);
 		} else {
-			disasm_print_insn(buf, *member_len, opcodes, name,
+			disasm_print_insn(buf, member_len, opcodes, name,
 					  disasm_opt, btf, NULL, 0, 0, false);
 		}
 	} else if (visual) {
 		if (json_output)
 			jsonw_null(json_wtr);
 		else
-			dump_xlated_cfg(buf, *member_len);
+			dump_xlated_cfg(buf, member_len);
 	} else {
 		kernel_syms_load(&dd);
-		dd.nr_jited_ksyms = info.nr_jited_ksyms;
-		dd.jited_ksyms = (__u64 *) info.jited_ksyms;
+		dd.nr_jited_ksyms = info->nr_jited_ksyms;
+		dd.jited_ksyms = (__u64 *) info->jited_ksyms;
 		dd.btf = btf;
 		dd.func_info = func_info;
-		dd.finfo_rec_size = finfo_rec_size;
+		dd.finfo_rec_size = info->func_info_rec_size;
 		dd.prog_linfo = prog_linfo;
 
 		if (json_output)
-			dump_xlated_json(&dd, buf, *member_len, opcodes,
+			dump_xlated_json(&dd, buf, member_len, opcodes,
 					 linum);
 		else
-			dump_xlated_plain(&dd, buf, *member_len, opcodes,
+			dump_xlated_plain(&dd, buf, member_len, opcodes,
 					  linum);
 		kernel_syms_destroy(&dd);
 	}
 
-	free(buf);
-	free(func_ksyms);
-	free(func_lens);
-	free(func_info);
-	free(linfo);
-	free(jited_linfo);
-	bpf_prog_linfo__free(prog_linfo);
+	free(info_linear);
 	return 0;
 
 err_free:
-	free(buf);
-	free(func_ksyms);
-	free(func_lens);
-	free(func_info);
-	free(linfo);
-	free(jited_linfo);
-	bpf_prog_linfo__free(prog_linfo);
+	free(info_linear);
 	return -1;
 }
 
diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 61e46d54a67c..8d3864b061f3 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -66,7 +66,8 @@ FEATURE_TESTS_BASIC :=                  \
         sched_getcpu			\
         sdt				\
         setns				\
-        libaio
+        libaio				\
+        disassembler-four-args
 
 # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
 # of all feature tests
@@ -118,7 +119,8 @@ FEATURE_DISPLAY ?=              \
          lzma                   \
          get_cpuid              \
          bpf			\
-         libaio
+         libaio			\
+         disassembler-four-args
 
 # Set FEATURE_CHECK_(C|LD)FLAGS-all for all FEATURE_TESTS features.
 # If in the future we need per-feature checks/flags for features not
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index e903b86b742f..7853e6d91090 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -178,6 +178,10 @@
 # include "test-reallocarray.c"
 #undef main
 
+#define main main_test_disassembler_four_args
+# include "test-disassembler-four-args.c"
+#undef main
+
 int main(int argc, char *argv[])
 {
 	main_test_libpython();
@@ -219,6 +223,7 @@ int main(int argc, char *argv[])
 	main_test_setns();
 	main_test_libaio();
 	main_test_reallocarray();
+	main_test_disassembler_four_args();
 
 	return 0;
 }
diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index d90127298f12..12cdf611d217 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -38,8 +38,10 @@ __SYSCALL(__NR_io_destroy, sys_io_destroy)
 __SC_COMP(__NR_io_submit, sys_io_submit, compat_sys_io_submit)
 #define __NR_io_cancel 3
 __SYSCALL(__NR_io_cancel, sys_io_cancel)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_io_getevents 4
-__SC_COMP(__NR_io_getevents, sys_io_getevents, compat_sys_io_getevents)
+__SC_3264(__NR_io_getevents, sys_io_getevents_time32, sys_io_getevents)
+#endif
 
 /* fs/xattr.c */
 #define __NR_setxattr 5
@@ -179,7 +181,7 @@ __SYSCALL(__NR_fchownat, sys_fchownat)
 #define __NR_fchown 55
 __SYSCALL(__NR_fchown, sys_fchown)
 #define __NR_openat 56
-__SC_COMP(__NR_openat, sys_openat, compat_sys_openat)
+__SYSCALL(__NR_openat, sys_openat)
 #define __NR_close 57
 __SYSCALL(__NR_close, sys_close)
 #define __NR_vhangup 58
@@ -222,10 +224,12 @@ __SC_COMP(__NR_pwritev, sys_pwritev, compat_sys_pwritev)
 __SYSCALL(__NR3264_sendfile, sys_sendfile64)
 
 /* fs/select.c */
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_pselect6 72
-__SC_COMP(__NR_pselect6, sys_pselect6, compat_sys_pselect6)
+__SC_COMP_3264(__NR_pselect6, sys_pselect6_time32, sys_pselect6, compat_sys_pselect6_time32)
 #define __NR_ppoll 73
-__SC_COMP(__NR_ppoll, sys_ppoll, compat_sys_ppoll)
+__SC_COMP_3264(__NR_ppoll, sys_ppoll_time32, sys_ppoll, compat_sys_ppoll_time32)
+#endif
 
 /* fs/signalfd.c */
 #define __NR_signalfd4 74
@@ -269,16 +273,20 @@ __SC_COMP(__NR_sync_file_range, sys_sync_file_range, \
 /* fs/timerfd.c */
 #define __NR_timerfd_create 85
 __SYSCALL(__NR_timerfd_create, sys_timerfd_create)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_timerfd_settime 86
-__SC_COMP(__NR_timerfd_settime, sys_timerfd_settime, \
-	  compat_sys_timerfd_settime)
+__SC_3264(__NR_timerfd_settime, sys_timerfd_settime32, \
+	  sys_timerfd_settime)
 #define __NR_timerfd_gettime 87
-__SC_COMP(__NR_timerfd_gettime, sys_timerfd_gettime, \
-	  compat_sys_timerfd_gettime)
+__SC_3264(__NR_timerfd_gettime, sys_timerfd_gettime32, \
+	  sys_timerfd_gettime)
+#endif
 
 /* fs/utimes.c */
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_utimensat 88
-__SC_COMP(__NR_utimensat, sys_utimensat, compat_sys_utimensat)
+__SC_3264(__NR_utimensat, sys_utimensat_time32, sys_utimensat)
+#endif
 
 /* kernel/acct.c */
 #define __NR_acct 89
@@ -309,8 +317,10 @@ __SYSCALL(__NR_set_tid_address, sys_set_tid_address)
 __SYSCALL(__NR_unshare, sys_unshare)
 
 /* kernel/futex.c */
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_futex 98
-__SC_COMP(__NR_futex, sys_futex, compat_sys_futex)
+__SC_3264(__NR_futex, sys_futex_time32, sys_futex)
+#endif
 #define __NR_set_robust_list 99
 __SC_COMP(__NR_set_robust_list, sys_set_robust_list, \
 	  compat_sys_set_robust_list)
@@ -319,8 +329,10 @@ __SC_COMP(__NR_get_robust_list, sys_get_robust_list, \
 	  compat_sys_get_robust_list)
 
 /* kernel/hrtimer.c */
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_nanosleep 101
-__SC_COMP(__NR_nanosleep, sys_nanosleep, compat_sys_nanosleep)
+__SC_3264(__NR_nanosleep, sys_nanosleep_time32, sys_nanosleep)
+#endif
 
 /* kernel/itimer.c */
 #define __NR_getitimer 102
@@ -341,23 +353,29 @@ __SYSCALL(__NR_delete_module, sys_delete_module)
 /* kernel/posix-timers.c */
 #define __NR_timer_create 107
 __SC_COMP(__NR_timer_create, sys_timer_create, compat_sys_timer_create)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_timer_gettime 108
-__SC_COMP(__NR_timer_gettime, sys_timer_gettime, compat_sys_timer_gettime)
+__SC_3264(__NR_timer_gettime, sys_timer_gettime32, sys_timer_gettime)
+#endif
 #define __NR_timer_getoverrun 109
 __SYSCALL(__NR_timer_getoverrun, sys_timer_getoverrun)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_timer_settime 110
-__SC_COMP(__NR_timer_settime, sys_timer_settime, compat_sys_timer_settime)
+__SC_3264(__NR_timer_settime, sys_timer_settime32, sys_timer_settime)
+#endif
 #define __NR_timer_delete 111
 __SYSCALL(__NR_timer_delete, sys_timer_delete)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_clock_settime 112
-__SC_COMP(__NR_clock_settime, sys_clock_settime, compat_sys_clock_settime)
+__SC_3264(__NR_clock_settime, sys_clock_settime32, sys_clock_settime)
 #define __NR_clock_gettime 113
-__SC_COMP(__NR_clock_gettime, sys_clock_gettime, compat_sys_clock_gettime)
+__SC_3264(__NR_clock_gettime, sys_clock_gettime32, sys_clock_gettime)
 #define __NR_clock_getres 114
-__SC_COMP(__NR_clock_getres, sys_clock_getres, compat_sys_clock_getres)
+__SC_3264(__NR_clock_getres, sys_clock_getres_time32, sys_clock_getres)
 #define __NR_clock_nanosleep 115
-__SC_COMP(__NR_clock_nanosleep, sys_clock_nanosleep, \
-	  compat_sys_clock_nanosleep)
+__SC_3264(__NR_clock_nanosleep, sys_clock_nanosleep_time32, \
+	  sys_clock_nanosleep)
+#endif
 
 /* kernel/printk.c */
 #define __NR_syslog 116
@@ -388,9 +406,11 @@ __SYSCALL(__NR_sched_yield, sys_sched_yield)
 __SYSCALL(__NR_sched_get_priority_max, sys_sched_get_priority_max)
 #define __NR_sched_get_priority_min 126
 __SYSCALL(__NR_sched_get_priority_min, sys_sched_get_priority_min)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_sched_rr_get_interval 127
-__SC_COMP(__NR_sched_rr_get_interval, sys_sched_rr_get_interval, \
-	  compat_sys_sched_rr_get_interval)
+__SC_3264(__NR_sched_rr_get_interval, sys_sched_rr_get_interval_time32, \
+	  sys_sched_rr_get_interval)
+#endif
 
 /* kernel/signal.c */
 #define __NR_restart_syscall 128
@@ -411,9 +431,11 @@ __SC_COMP(__NR_rt_sigaction, sys_rt_sigaction, compat_sys_rt_sigaction)
 __SC_COMP(__NR_rt_sigprocmask, sys_rt_sigprocmask, compat_sys_rt_sigprocmask)
 #define __NR_rt_sigpending 136
 __SC_COMP(__NR_rt_sigpending, sys_rt_sigpending, compat_sys_rt_sigpending)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_rt_sigtimedwait 137
-__SC_COMP(__NR_rt_sigtimedwait, sys_rt_sigtimedwait, \
-	  compat_sys_rt_sigtimedwait)
+__SC_COMP_3264(__NR_rt_sigtimedwait, sys_rt_sigtimedwait_time32, \
+	  sys_rt_sigtimedwait, compat_sys_rt_sigtimedwait_time32)
+#endif
 #define __NR_rt_sigqueueinfo 138
 __SC_COMP(__NR_rt_sigqueueinfo, sys_rt_sigqueueinfo, \
 	  compat_sys_rt_sigqueueinfo)
@@ -467,10 +489,15 @@ __SYSCALL(__NR_uname, sys_newuname)
 __SYSCALL(__NR_sethostname, sys_sethostname)
 #define __NR_setdomainname 162
 __SYSCALL(__NR_setdomainname, sys_setdomainname)
+
+#ifdef __ARCH_WANT_SET_GET_RLIMIT
+/* getrlimit and setrlimit are superseded with prlimit64 */
 #define __NR_getrlimit 163
 __SC_COMP(__NR_getrlimit, sys_getrlimit, compat_sys_getrlimit)
 #define __NR_setrlimit 164
 __SC_COMP(__NR_setrlimit, sys_setrlimit, compat_sys_setrlimit)
+#endif
+
 #define __NR_getrusage 165
 __SC_COMP(__NR_getrusage, sys_getrusage, compat_sys_getrusage)
 #define __NR_umask 166
@@ -481,12 +508,14 @@ __SYSCALL(__NR_prctl, sys_prctl)
 __SYSCALL(__NR_getcpu, sys_getcpu)
 
 /* kernel/time.c */
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_gettimeofday 169
 __SC_COMP(__NR_gettimeofday, sys_gettimeofday, compat_sys_gettimeofday)
 #define __NR_settimeofday 170
 __SC_COMP(__NR_settimeofday, sys_settimeofday, compat_sys_settimeofday)
 #define __NR_adjtimex 171
-__SC_COMP(__NR_adjtimex, sys_adjtimex, compat_sys_adjtimex)
+__SC_3264(__NR_adjtimex, sys_adjtimex_time32, sys_adjtimex)
+#endif
 
 /* kernel/timer.c */
 #define __NR_getpid 172
@@ -511,11 +540,13 @@ __SC_COMP(__NR_sysinfo, sys_sysinfo, compat_sys_sysinfo)
 __SC_COMP(__NR_mq_open, sys_mq_open, compat_sys_mq_open)
 #define __NR_mq_unlink 181
 __SYSCALL(__NR_mq_unlink, sys_mq_unlink)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_mq_timedsend 182
-__SC_COMP(__NR_mq_timedsend, sys_mq_timedsend, compat_sys_mq_timedsend)
+__SC_3264(__NR_mq_timedsend, sys_mq_timedsend_time32, sys_mq_timedsend)
 #define __NR_mq_timedreceive 183
-__SC_COMP(__NR_mq_timedreceive, sys_mq_timedreceive, \
-	  compat_sys_mq_timedreceive)
+__SC_3264(__NR_mq_timedreceive, sys_mq_timedreceive_time32, \
+	  sys_mq_timedreceive)
+#endif
 #define __NR_mq_notify 184
 __SC_COMP(__NR_mq_notify, sys_mq_notify, compat_sys_mq_notify)
 #define __NR_mq_getsetattr 185
@@ -536,8 +567,10 @@ __SC_COMP(__NR_msgsnd, sys_msgsnd, compat_sys_msgsnd)
 __SYSCALL(__NR_semget, sys_semget)
 #define __NR_semctl 191
 __SC_COMP(__NR_semctl, sys_semctl, compat_sys_semctl)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_semtimedop 192
-__SC_COMP(__NR_semtimedop, sys_semtimedop, compat_sys_semtimedop)
+__SC_COMP(__NR_semtimedop, sys_semtimedop, sys_semtimedop_time32)
+#endif
 #define __NR_semop 193
 __SYSCALL(__NR_semop, sys_semop)
 
@@ -658,8 +691,10 @@ __SC_COMP(__NR_rt_tgsigqueueinfo, sys_rt_tgsigqueueinfo, \
 __SYSCALL(__NR_perf_event_open, sys_perf_event_open)
 #define __NR_accept4 242
 __SYSCALL(__NR_accept4, sys_accept4)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_recvmmsg 243
-__SC_COMP(__NR_recvmmsg, sys_recvmmsg, compat_sys_recvmmsg)
+__SC_COMP_3264(__NR_recvmmsg, sys_recvmmsg_time32, sys_recvmmsg, compat_sys_recvmmsg_time32)
+#endif
 
 /*
  * Architectures may provide up to 16 syscalls of their own
@@ -667,8 +702,10 @@ __SC_COMP(__NR_recvmmsg, sys_recvmmsg, compat_sys_recvmmsg)
  */
 #define __NR_arch_specific_syscall 244
 
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_wait4 260
 __SC_COMP(__NR_wait4, sys_wait4, compat_sys_wait4)
+#endif
 #define __NR_prlimit64 261
 __SYSCALL(__NR_prlimit64, sys_prlimit64)
 #define __NR_fanotify_init 262
@@ -678,10 +715,11 @@ __SYSCALL(__NR_fanotify_mark, sys_fanotify_mark)
 #define __NR_name_to_handle_at         264
 __SYSCALL(__NR_name_to_handle_at, sys_name_to_handle_at)
 #define __NR_open_by_handle_at         265
-__SC_COMP(__NR_open_by_handle_at, sys_open_by_handle_at, \
-	  compat_sys_open_by_handle_at)
+__SYSCALL(__NR_open_by_handle_at, sys_open_by_handle_at)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_clock_adjtime 266
-__SC_COMP(__NR_clock_adjtime, sys_clock_adjtime, compat_sys_clock_adjtime)
+__SC_3264(__NR_clock_adjtime, sys_clock_adjtime32, sys_clock_adjtime)
+#endif
 #define __NR_syncfs 267
 __SYSCALL(__NR_syncfs, sys_syncfs)
 #define __NR_setns 268
@@ -734,15 +772,60 @@ __SYSCALL(__NR_pkey_alloc,    sys_pkey_alloc)
 __SYSCALL(__NR_pkey_free,     sys_pkey_free)
 #define __NR_statx 291
 __SYSCALL(__NR_statx,     sys_statx)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_io_pgetevents 292
-__SC_COMP(__NR_io_pgetevents, sys_io_pgetevents, compat_sys_io_pgetevents)
+__SC_COMP_3264(__NR_io_pgetevents, sys_io_pgetevents_time32, sys_io_pgetevents, compat_sys_io_pgetevents)
+#endif
 #define __NR_rseq 293
 __SYSCALL(__NR_rseq, sys_rseq)
 #define __NR_kexec_file_load 294
 __SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
+/* 295 through 402 are unassigned to sync up with generic numbers, don't use */
+#if __BITS_PER_LONG == 32
+#define __NR_clock_gettime64 403
+__SYSCALL(__NR_clock_gettime64, sys_clock_gettime)
+#define __NR_clock_settime64 404
+__SYSCALL(__NR_clock_settime64, sys_clock_settime)
+#define __NR_clock_adjtime64 405
+__SYSCALL(__NR_clock_adjtime64, sys_clock_adjtime)
+#define __NR_clock_getres_time64 406
+__SYSCALL(__NR_clock_getres_time64, sys_clock_getres)
+#define __NR_clock_nanosleep_time64 407
+__SYSCALL(__NR_clock_nanosleep_time64, sys_clock_nanosleep)
+#define __NR_timer_gettime64 408
+__SYSCALL(__NR_timer_gettime64, sys_timer_gettime)
+#define __NR_timer_settime64 409
+__SYSCALL(__NR_timer_settime64, sys_timer_settime)
+#define __NR_timerfd_gettime64 410
+__SYSCALL(__NR_timerfd_gettime64, sys_timerfd_gettime)
+#define __NR_timerfd_settime64 411
+__SYSCALL(__NR_timerfd_settime64, sys_timerfd_settime)
+#define __NR_utimensat_time64 412
+__SYSCALL(__NR_utimensat_time64, sys_utimensat)
+#define __NR_pselect6_time64 413
+__SC_COMP(__NR_pselect6_time64, sys_pselect6, compat_sys_pselect6_time64)
+#define __NR_ppoll_time64 414
+__SC_COMP(__NR_ppoll_time64, sys_ppoll, compat_sys_ppoll_time64)
+#define __NR_io_pgetevents_time64 416
+__SYSCALL(__NR_io_pgetevents_time64, sys_io_pgetevents)
+#define __NR_recvmmsg_time64 417
+__SC_COMP(__NR_recvmmsg_time64, sys_recvmmsg, compat_sys_recvmmsg_time64)
+#define __NR_mq_timedsend_time64 418
+__SYSCALL(__NR_mq_timedsend_time64, sys_mq_timedsend)
+#define __NR_mq_timedreceive_time64 419
+__SYSCALL(__NR_mq_timedreceive_time64, sys_mq_timedreceive)
+#define __NR_semtimedop_time64 420
+__SYSCALL(__NR_semtimedop_time64, sys_semtimedop)
+#define __NR_rt_sigtimedwait_time64 421
+__SC_COMP(__NR_rt_sigtimedwait_time64, sys_rt_sigtimedwait, compat_sys_rt_sigtimedwait_time64)
+#define __NR_futex_time64 422
+__SYSCALL(__NR_futex_time64, sys_futex)
+#define __NR_sched_rr_get_interval_time64 423
+__SYSCALL(__NR_sched_rr_get_interval_time64, sys_sched_rr_get_interval)
+#endif
 
 #undef __NR_syscalls
-#define __NR_syscalls 295
+#define __NR_syscalls 424
 
 /*
  * 32 bit systems traditionally used different
diff --git a/tools/include/uapi/linux/in.h b/tools/include/uapi/linux/in.h
index a55cb8b10165..e7ad9d350a28 100644
--- a/tools/include/uapi/linux/in.h
+++ b/tools/include/uapi/linux/in.h
@@ -292,10 +292,11 @@ struct sockaddr_in {
 #define	IN_LOOPBACK(a)		((((long int) (a)) & 0xff000000) == 0x7f000000)
 
 /* Defines for Multicast INADDR */
-#define INADDR_UNSPEC_GROUP   	0xe0000000U	/* 224.0.0.0   */
-#define INADDR_ALLHOSTS_GROUP 	0xe0000001U	/* 224.0.0.1   */
-#define INADDR_ALLRTRS_GROUP    0xe0000002U	/* 224.0.0.2 */
-#define INADDR_MAX_LOCAL_GROUP  0xe00000ffU	/* 224.0.0.255 */
+#define INADDR_UNSPEC_GROUP		0xe0000000U	/* 224.0.0.0   */
+#define INADDR_ALLHOSTS_GROUP		0xe0000001U	/* 224.0.0.1   */
+#define INADDR_ALLRTRS_GROUP		0xe0000002U	/* 224.0.0.2 */
+#define INADDR_ALLSNOOPERS_GROUP	0xe000006aU	/* 224.0.0.106 */
+#define INADDR_MAX_LOCAL_GROUP		0xe00000ffU	/* 224.0.0.255 */
 #endif
 
 /* <asm/byteorder.h> contains the htonl type stuff.. */
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index d5b830d60601..e6ad87512519 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -112,6 +112,11 @@ void libbpf_print(enum libbpf_print_level level, const char *format, ...)
 # define LIBBPF_ELF_C_READ_MMAP ELF_C_READ
 #endif
 
+static inline __u64 ptr_to_u64(const void *ptr)
+{
+	return (__u64) (unsigned long) ptr;
+}
+
 struct bpf_capabilities {
 	/* v4.14: kernel support for program & map names. */
 	__u32 name:1;
@@ -622,7 +627,7 @@ bpf_object__init_maps(struct bpf_object *obj, int flags)
 	bool strict = !(flags & MAPS_RELAX_COMPAT);
 	int i, map_idx, map_def_sz, nr_maps = 0;
 	Elf_Scn *scn;
-	Elf_Data *data;
+	Elf_Data *data = NULL;
 	Elf_Data *symbols = obj->efile.symbols;
 
 	if (obj->efile.maps_shndx < 0)
@@ -2999,3 +3004,249 @@ bpf_perf_event_read_simple(void *mmap_mem, size_t mmap_size, size_t page_size,
 	ring_buffer_write_tail(header, data_tail);
 	return ret;
 }
+
+struct bpf_prog_info_array_desc {
+	int	array_offset;	/* e.g. offset of jited_prog_insns */
+	int	count_offset;	/* e.g. offset of jited_prog_len */
+	int	size_offset;	/* > 0: offset of rec size,
+				 * < 0: fix size of -size_offset
+				 */
+};
+
+static struct bpf_prog_info_array_desc bpf_prog_info_array_desc[] = {
+	[BPF_PROG_INFO_JITED_INSNS] = {
+		offsetof(struct bpf_prog_info, jited_prog_insns),
+		offsetof(struct bpf_prog_info, jited_prog_len),
+		-1,
+	},
+	[BPF_PROG_INFO_XLATED_INSNS] = {
+		offsetof(struct bpf_prog_info, xlated_prog_insns),
+		offsetof(struct bpf_prog_info, xlated_prog_len),
+		-1,
+	},
+	[BPF_PROG_INFO_MAP_IDS] = {
+		offsetof(struct bpf_prog_info, map_ids),
+		offsetof(struct bpf_prog_info, nr_map_ids),
+		-(int)sizeof(__u32),
+	},
+	[BPF_PROG_INFO_JITED_KSYMS] = {
+		offsetof(struct bpf_prog_info, jited_ksyms),
+		offsetof(struct bpf_prog_info, nr_jited_ksyms),
+		-(int)sizeof(__u64),
+	},
+	[BPF_PROG_INFO_JITED_FUNC_LENS] = {
+		offsetof(struct bpf_prog_info, jited_func_lens),
+		offsetof(struct bpf_prog_info, nr_jited_func_lens),
+		-(int)sizeof(__u32),
+	},
+	[BPF_PROG_INFO_FUNC_INFO] = {
+		offsetof(struct bpf_prog_info, func_info),
+		offsetof(struct bpf_prog_info, nr_func_info),
+		offsetof(struct bpf_prog_info, func_info_rec_size),
+	},
+	[BPF_PROG_INFO_LINE_INFO] = {
+		offsetof(struct bpf_prog_info, line_info),
+		offsetof(struct bpf_prog_info, nr_line_info),
+		offsetof(struct bpf_prog_info, line_info_rec_size),
+	},
+	[BPF_PROG_INFO_JITED_LINE_INFO] = {
+		offsetof(struct bpf_prog_info, jited_line_info),
+		offsetof(struct bpf_prog_info, nr_jited_line_info),
+		offsetof(struct bpf_prog_info, jited_line_info_rec_size),
+	},
+	[BPF_PROG_INFO_PROG_TAGS] = {
+		offsetof(struct bpf_prog_info, prog_tags),
+		offsetof(struct bpf_prog_info, nr_prog_tags),
+		-(int)sizeof(__u8) * BPF_TAG_SIZE,
+	},
+
+};
+
+static __u32 bpf_prog_info_read_offset_u32(struct bpf_prog_info *info, int offset)
+{
+	__u32 *array = (__u32 *)info;
+
+	if (offset >= 0)
+		return array[offset / sizeof(__u32)];
+	return -(int)offset;
+}
+
+static __u64 bpf_prog_info_read_offset_u64(struct bpf_prog_info *info, int offset)
+{
+	__u64 *array = (__u64 *)info;
+
+	if (offset >= 0)
+		return array[offset / sizeof(__u64)];
+	return -(int)offset;
+}
+
+static void bpf_prog_info_set_offset_u32(struct bpf_prog_info *info, int offset,
+					 __u32 val)
+{
+	__u32 *array = (__u32 *)info;
+
+	if (offset >= 0)
+		array[offset / sizeof(__u32)] = val;
+}
+
+static void bpf_prog_info_set_offset_u64(struct bpf_prog_info *info, int offset,
+					 __u64 val)
+{
+	__u64 *array = (__u64 *)info;
+
+	if (offset >= 0)
+		array[offset / sizeof(__u64)] = val;
+}
+
+struct bpf_prog_info_linear *
+bpf_program__get_prog_info_linear(int fd, __u64 arrays)
+{
+	struct bpf_prog_info_linear *info_linear;
+	struct bpf_prog_info info = {};
+	__u32 info_len = sizeof(info);
+	__u32 data_len = 0;
+	int i, err;
+	void *ptr;
+
+	if (arrays >> BPF_PROG_INFO_LAST_ARRAY)
+		return ERR_PTR(-EINVAL);
+
+	/* step 1: get array dimensions */
+	err = bpf_obj_get_info_by_fd(fd, &info, &info_len);
+	if (err) {
+		pr_debug("can't get prog info: %s", strerror(errno));
+		return ERR_PTR(-EFAULT);
+	}
+
+	/* step 2: calculate total size of all arrays */
+	for (i = BPF_PROG_INFO_FIRST_ARRAY; i < BPF_PROG_INFO_LAST_ARRAY; ++i) {
+		bool include_array = (arrays & (1UL << i)) > 0;
+		struct bpf_prog_info_array_desc *desc;
+		__u32 count, size;
+
+		desc = bpf_prog_info_array_desc + i;
+
+		/* kernel is too old to support this field */
+		if (info_len < desc->array_offset + sizeof(__u32) ||
+		    info_len < desc->count_offset + sizeof(__u32) ||
+		    (desc->size_offset > 0 && info_len < desc->size_offset))
+			include_array = false;
+
+		if (!include_array) {
+			arrays &= ~(1UL << i);	/* clear the bit */
+			continue;
+		}
+
+		count = bpf_prog_info_read_offset_u32(&info, desc->count_offset);
+		size  = bpf_prog_info_read_offset_u32(&info, desc->size_offset);
+
+		data_len += count * size;
+	}
+
+	/* step 3: allocate continuous memory */
+	data_len = roundup(data_len, sizeof(__u64));
+	info_linear = malloc(sizeof(struct bpf_prog_info_linear) + data_len);
+	if (!info_linear)
+		return ERR_PTR(-ENOMEM);
+
+	/* step 4: fill data to info_linear->info */
+	info_linear->arrays = arrays;
+	memset(&info_linear->info, 0, sizeof(info));
+	ptr = info_linear->data;
+
+	for (i = BPF_PROG_INFO_FIRST_ARRAY; i < BPF_PROG_INFO_LAST_ARRAY; ++i) {
+		struct bpf_prog_info_array_desc *desc;
+		__u32 count, size;
+
+		if ((arrays & (1UL << i)) == 0)
+			continue;
+
+		desc  = bpf_prog_info_array_desc + i;
+		count = bpf_prog_info_read_offset_u32(&info, desc->count_offset);
+		size  = bpf_prog_info_read_offset_u32(&info, desc->size_offset);
+		bpf_prog_info_set_offset_u32(&info_linear->info,
+					     desc->count_offset, count);
+		bpf_prog_info_set_offset_u32(&info_linear->info,
+					     desc->size_offset, size);
+		bpf_prog_info_set_offset_u64(&info_linear->info,
+					     desc->array_offset,
+					     ptr_to_u64(ptr));
+		ptr += count * size;
+	}
+
+	/* step 5: call syscall again to get required arrays */
+	err = bpf_obj_get_info_by_fd(fd, &info_linear->info, &info_len);
+	if (err) {
+		pr_debug("can't get prog info: %s", strerror(errno));
+		free(info_linear);
+		return ERR_PTR(-EFAULT);
+	}
+
+	/* step 6: verify the data */
+	for (i = BPF_PROG_INFO_FIRST_ARRAY; i < BPF_PROG_INFO_LAST_ARRAY; ++i) {
+		struct bpf_prog_info_array_desc *desc;
+		__u32 v1, v2;
+
+		if ((arrays & (1UL << i)) == 0)
+			continue;
+
+		desc = bpf_prog_info_array_desc + i;
+		v1 = bpf_prog_info_read_offset_u32(&info, desc->count_offset);
+		v2 = bpf_prog_info_read_offset_u32(&info_linear->info,
+						   desc->count_offset);
+		if (v1 != v2)
+			pr_warning("%s: mismatch in element count\n", __func__);
+
+		v1 = bpf_prog_info_read_offset_u32(&info, desc->size_offset);
+		v2 = bpf_prog_info_read_offset_u32(&info_linear->info,
+						   desc->size_offset);
+		if (v1 != v2)
+			pr_warning("%s: mismatch in rec size\n", __func__);
+	}
+
+	/* step 7: update info_len and data_len */
+	info_linear->info_len = sizeof(struct bpf_prog_info);
+	info_linear->data_len = data_len;
+
+	return info_linear;
+}
+
+void bpf_program__bpil_addr_to_offs(struct bpf_prog_info_linear *info_linear)
+{
+	int i;
+
+	for (i = BPF_PROG_INFO_FIRST_ARRAY; i < BPF_PROG_INFO_LAST_ARRAY; ++i) {
+		struct bpf_prog_info_array_desc *desc;
+		__u64 addr, offs;
+
+		if ((info_linear->arrays & (1UL << i)) == 0)
+			continue;
+
+		desc = bpf_prog_info_array_desc + i;
+		addr = bpf_prog_info_read_offset_u64(&info_linear->info,
+						     desc->array_offset);
+		offs = addr - ptr_to_u64(info_linear->data);
+		bpf_prog_info_set_offset_u64(&info_linear->info,
+					     desc->array_offset, offs);
+	}
+}
+
+void bpf_program__bpil_offs_to_addr(struct bpf_prog_info_linear *info_linear)
+{
+	int i;
+
+	for (i = BPF_PROG_INFO_FIRST_ARRAY; i < BPF_PROG_INFO_LAST_ARRAY; ++i) {
+		struct bpf_prog_info_array_desc *desc;
+		__u64 addr, offs;
+
+		if ((info_linear->arrays & (1UL << i)) == 0)
+			continue;
+
+		desc = bpf_prog_info_array_desc + i;
+		offs = bpf_prog_info_read_offset_u64(&info_linear->info,
+						     desc->array_offset);
+		addr = offs + ptr_to_u64(info_linear->data);
+		bpf_prog_info_set_offset_u64(&info_linear->info,
+					     desc->array_offset, addr);
+	}
+}
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index b4652aa1a58a..c70785cc8ef5 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -10,6 +10,7 @@
 #ifndef __LIBBPF_LIBBPF_H
 #define __LIBBPF_LIBBPF_H
 
+#include <stdarg.h>
 #include <stdio.h>
 #include <stdint.h>
 #include <stdbool.h>
@@ -377,6 +378,69 @@ LIBBPF_API bool bpf_probe_map_type(enum bpf_map_type map_type, __u32 ifindex);
 LIBBPF_API bool bpf_probe_helper(enum bpf_func_id id,
 				 enum bpf_prog_type prog_type, __u32 ifindex);
 
+/*
+ * Get bpf_prog_info in continuous memory
+ *
+ * struct bpf_prog_info has multiple arrays. The user has option to choose
+ * arrays to fetch from kernel. The following APIs provide an uniform way to
+ * fetch these data. All arrays in bpf_prog_info are stored in a single
+ * continuous memory region. This makes it easy to store the info in a
+ * file.
+ *
+ * Before writing bpf_prog_info_linear to files, it is necessary to
+ * translate pointers in bpf_prog_info to offsets. Helper functions
+ * bpf_program__bpil_addr_to_offs() and bpf_program__bpil_offs_to_addr()
+ * are introduced to switch between pointers and offsets.
+ *
+ * Examples:
+ *   # To fetch map_ids and prog_tags:
+ *   __u64 arrays = (1UL << BPF_PROG_INFO_MAP_IDS) |
+ *           (1UL << BPF_PROG_INFO_PROG_TAGS);
+ *   struct bpf_prog_info_linear *info_linear =
+ *           bpf_program__get_prog_info_linear(fd, arrays);
+ *
+ *   # To save data in file
+ *   bpf_program__bpil_addr_to_offs(info_linear);
+ *   write(f, info_linear, sizeof(*info_linear) + info_linear->data_len);
+ *
+ *   # To read data from file
+ *   read(f, info_linear, <proper_size>);
+ *   bpf_program__bpil_offs_to_addr(info_linear);
+ */
+enum bpf_prog_info_array {
+	BPF_PROG_INFO_FIRST_ARRAY = 0,
+	BPF_PROG_INFO_JITED_INSNS = 0,
+	BPF_PROG_INFO_XLATED_INSNS,
+	BPF_PROG_INFO_MAP_IDS,
+	BPF_PROG_INFO_JITED_KSYMS,
+	BPF_PROG_INFO_JITED_FUNC_LENS,
+	BPF_PROG_INFO_FUNC_INFO,
+	BPF_PROG_INFO_LINE_INFO,
+	BPF_PROG_INFO_JITED_LINE_INFO,
+	BPF_PROG_INFO_PROG_TAGS,
+	BPF_PROG_INFO_LAST_ARRAY,
+};
+
+struct bpf_prog_info_linear {
+	/* size of struct bpf_prog_info, when the tool is compiled */
+	__u32			info_len;
+	/* total bytes allocated for data, round up to 8 bytes */
+	__u32			data_len;
+	/* which arrays are included in data */
+	__u64			arrays;
+	struct bpf_prog_info	info;
+	__u8			data[];
+};
+
+LIBBPF_API struct bpf_prog_info_linear *
+bpf_program__get_prog_info_linear(int fd, __u64 arrays);
+
+LIBBPF_API void
+bpf_program__bpil_addr_to_offs(struct bpf_prog_info_linear *info_linear);
+
+LIBBPF_API void
+bpf_program__bpil_offs_to_addr(struct bpf_prog_info_linear *info_linear);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 778a26702a70..f3ce50500cf2 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -153,4 +153,7 @@ LIBBPF_0.0.2 {
 		xsk_socket__delete;
 		xsk_umem__fd;
 		xsk_socket__fd;
+		bpf_program__get_prog_info_linear;
+		bpf_program__bpil_addr_to_offs;
+		bpf_program__bpil_offs_to_addr;
 } LIBBPF_0.0.1;
diff --git a/tools/perf/Documentation/Build.txt b/tools/perf/Documentation/Build.txt
index f6fc6507ba55..3766886c4bca 100644
--- a/tools/perf/Documentation/Build.txt
+++ b/tools/perf/Documentation/Build.txt
@@ -47,3 +47,27 @@ Those objects are then used in final linking:
 
 NOTE this description is omitting other libraries involved, only
      focusing on build framework outcomes
+
+3) Build with ASan or UBSan
+==========================
+  $ cd tools/perf
+  $ make DESTDIR=/usr
+  $ make DESTDIR=/usr install
+
+AddressSanitizer (or ASan) is a GCC feature that detects memory corruption bugs
+such as buffer overflows and memory leaks.
+
+  $ cd tools/perf
+  $ make DEBUG=1 EXTRA_CFLAGS='-fno-omit-frame-pointer -fsanitize=address'
+  $ ASAN_OPTIONS=log_path=asan.log ./perf record -a
+
+ASan outputs all detected issues into a log file named 'asan.log.<pid>'.
+
+UndefinedBehaviorSanitizer (or UBSan) is a fast undefined behavior detector
+supported by GCC. UBSan detects undefined behaviors of programs at runtime.
+
+  $ cd tools/perf
+  $ make DEBUG=1 EXTRA_CFLAGS='-fno-omit-frame-pointer -fsanitize=undefined'
+  $ UBSAN_OPTIONS=print_stacktrace=1 ./perf record -a
+
+If UBSan detects any problem at runtime, it outputs a “runtime error:” message.
diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 86f3dcc15f83..462b3cde0675 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -114,7 +114,7 @@ Given a $HOME/.perfconfig like this:
 
 	[report]
 		# Defaults
-		sort-order = comm,dso,symbol
+		sort_order = comm,dso,symbol
 		percent-limit = 0
 		queue-size = 0
 		children = true
@@ -584,6 +584,20 @@ llvm.*::
 	llvm.opts::
 		Options passed to llc.
 
+samples.*::
+
+	samples.context::
+		Define how many ns worth of time to show
+		around samples in perf report sample context browser.
+
+scripts.*::
+
+	Any option defines a script that is added to the scripts menu
+	in the interactive perf browser and whose output is displayed.
+	The name of the option is the name, the value is a script command line.
+	The script gets the same options passed as a full perf script,
+	in particular -i perfdata file, --cpu, --tid
+
 SEE ALSO
 --------
 linkperf:perf[1]
diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 8f0c2be34848..8fe4dffcadd0 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -495,6 +495,10 @@ overhead. You can still switch them on with:
 
   --switch-output --no-no-buildid  --no-no-buildid-cache
 
+--switch-max-files=N::
+
+When rotating perf.data with --switch-output, only keep N files.
+
 --dry-run::
 Parse options then exit. --dry-run can be used to detect errors in cmdline
 options.
diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 1a27bfe05039..f441baa794ce 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -105,6 +105,8 @@ OPTIONS
 	guest machine
 	- sample: Number of sample
 	- period: Raw number of event count of sample
+	- time: Separate the samples by time stamp with the resolution specified by
+	--time-quantum (default 100ms). Specify with overhead and before it.
 
 	By default, comm, dso and symbol keys are used.
 	(i.e. --sort comm,dso,symbol)
@@ -459,6 +461,10 @@ include::itrace.txt[]
 --socket-filter::
 	Only report the samples on the processor socket that match with this filter
 
+--samples=N::
+	Save N individual samples for each histogram entry to show context in perf
+	report tui browser.
+
 --raw-trace::
 	When displaying traceevent output, do not use print fmt or plugins.
 
@@ -477,6 +483,9 @@ include::itrace.txt[]
 	Please note that not all mmaps are stored, options affecting which ones
 	are include 'perf record --data', for instance.
 
+--ns::
+	Show time stamps in nanoseconds.
+
 --stats::
 	Display overall events statistics without any further processing.
 	(like the one at the end of the perf report -D command)
@@ -494,6 +503,10 @@ include::itrace.txt[]
 	The period/hits keywords set the base the percentage is computed
 	on - the samples period or the number of samples (hits).
 
+--time-quantum::
+	Configure time quantum for time sort key. Default 100ms.
+	Accepts s, us, ms, ns units.
+
 include::callchain-overhead-calculation.txt[]
 
 SEE ALSO
diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 2e19fd7ffe35..9b0d04dd2a61 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -380,6 +380,9 @@ include::itrace.txt[]
 	Set the maximum number of program blocks to print with brstackasm for
 	each sample.
 
+--reltime::
+	Print time stamps relative to trace start.
+
 --per-event-dump::
 	Create per event files with a "perf.data.EVENT.dump" name instead of
         printing to stdout, useful, for instance, for generating flamegraphs.
diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 4bc2085e5197..39c05f89104e 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -72,9 +72,8 @@ report::
 --all-cpus::
         system-wide collection from all CPUs (default if no target is specified)
 
--c::
---scale::
-	scale/normalize counter values
+--no-scale::
+	Don't scale/normalize counter values
 
 -d::
 --detailed::
diff --git a/tools/perf/Documentation/tips.txt b/tools/perf/Documentation/tips.txt
index 849599f39c5e..869965d629ce 100644
--- a/tools/perf/Documentation/tips.txt
+++ b/tools/perf/Documentation/tips.txt
@@ -15,6 +15,7 @@ To see callchains in a more compact form: perf report -g folded
 Show individual samples with: perf script
 Limit to show entries above 5% only: perf report --percent-limit 5
 Profiling branch (mis)predictions with: perf record -b / perf report
+To show assembler sample contexts use perf record -b / perf script -F +brstackinsn --xed
 Treat branches as callchains: perf report --branch-history
 To count events in every 1000 msec: perf stat -I 1000
 Print event counts in CSV format with: perf stat -x,
@@ -34,3 +35,9 @@ Show current config key-value pairs: perf config --list
 Show user configuration overrides: perf config --user --list
 To add Node.js USDT(User-Level Statically Defined Tracing): perf buildid-cache --add `which node`
 To report cacheline events from previous recording: perf c2c report
+To browse sample contexts use perf report --sample 10 and select in context menu
+To separate samples by time use perf report --sort time,overhead,sym
+To set sample time separation other than 100ms with --sort time use --time-quantum
+Add -I to perf report to sample register values visible in perf report context.
+To show IPC for sampling periods use perf record -e '{cycles,instructions}:S' and then browse context
+To show context switches in perf report sample context add --switch-events to perf record.
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 0f11d5891301..fe3f97e342fa 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -227,6 +227,8 @@ FEATURE_CHECK_LDFLAGS-libpython-version := $(PYTHON_EMBED_LDOPTS)
 
 FEATURE_CHECK_LDFLAGS-libaio = -lrt
 
+FEATURE_CHECK_LDFLAGS-disassembler-four-args = -lbfd -lopcodes
+
 CFLAGS += -fno-omit-frame-pointer
 CFLAGS += -ggdb3
 CFLAGS += -funwind-tables
@@ -713,7 +715,7 @@ else
 endif
 
 ifeq ($(feature-libbfd), 1)
-  EXTLIBS += -lbfd
+  EXTLIBS += -lbfd -lopcodes
 else
   # we are on a system that requires -liberty and (maybe) -lz
   # to link against -lbfd; test each case individually here
@@ -724,12 +726,15 @@ else
   $(call feature_check,libbfd-liberty-z)
 
   ifeq ($(feature-libbfd-liberty), 1)
-    EXTLIBS += -lbfd -liberty
+    EXTLIBS += -lbfd -lopcodes -liberty
+    FEATURE_CHECK_LDFLAGS-disassembler-four-args += -liberty -ldl
   else
     ifeq ($(feature-libbfd-liberty-z), 1)
-      EXTLIBS += -lbfd -liberty -lz
+      EXTLIBS += -lbfd -lopcodes -liberty -lz
+      FEATURE_CHECK_LDFLAGS-disassembler-four-args += -liberty -lz -ldl
     endif
   endif
+  $(call feature_check,disassembler-four-args)
 endif
 
 ifdef NO_DEMANGLE
@@ -808,6 +813,10 @@ ifdef HAVE_KVM_STAT_SUPPORT
     CFLAGS += -DHAVE_KVM_STAT_SUPPORT
 endif
 
+ifeq ($(feature-disassembler-four-args), 1)
+    CFLAGS += -DDISASM_FOUR_ARGS_SIGNATURE
+endif
+
 ifeq (${IS_64_BIT}, 1)
   ifndef NO_PERF_READ_VDSO32
     $(call feature_check,compile-32)
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index f0b1709a5ffb..2ae92fddb6d5 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -343,6 +343,8 @@
 332	common	statx			__x64_sys_statx
 333	common	io_pgetevents		__x64_sys_io_pgetevents
 334	common	rseq			__x64_sys_rseq
+# don't use numbers 387 through 423, add new calls after the last
+# 'common' entry
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
@@ -361,7 +363,7 @@
 520	x32	execve			__x32_compat_sys_execve/ptregs
 521	x32	ptrace			__x32_compat_sys_ptrace
 522	x32	rt_sigpending		__x32_compat_sys_rt_sigpending
-523	x32	rt_sigtimedwait		__x32_compat_sys_rt_sigtimedwait
+523	x32	rt_sigtimedwait		__x32_compat_sys_rt_sigtimedwait_time64
 524	x32	rt_sigqueueinfo		__x32_compat_sys_rt_sigqueueinfo
 525	x32	sigaltstack		__x32_compat_sys_sigaltstack
 526	x32	timer_create		__x32_compat_sys_timer_create
@@ -375,7 +377,7 @@
 534	x32	preadv			__x32_compat_sys_preadv64
 535	x32	pwritev			__x32_compat_sys_pwritev64
 536	x32	rt_tgsigqueueinfo	__x32_compat_sys_rt_tgsigqueueinfo
-537	x32	recvmmsg		__x32_compat_sys_recvmmsg
+537	x32	recvmmsg		__x32_compat_sys_recvmmsg_time64
 538	x32	sendmmsg		__x32_compat_sys_sendmmsg
 539	x32	process_vm_readv	__x32_compat_sys_process_vm_readv
 540	x32	process_vm_writev	__x32_compat_sys_process_vm_writev
diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
index 7aab0be5fc5f..47f9c56e744f 100644
--- a/tools/perf/arch/x86/util/Build
+++ b/tools/perf/arch/x86/util/Build
@@ -14,5 +14,6 @@ perf-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind.o
 perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
 
 perf-$(CONFIG_AUXTRACE) += auxtrace.o
+perf-$(CONFIG_AUXTRACE) += archinsn.o
 perf-$(CONFIG_AUXTRACE) += intel-pt.o
 perf-$(CONFIG_AUXTRACE) += intel-bts.o
diff --git a/tools/perf/arch/x86/util/archinsn.c b/tools/perf/arch/x86/util/archinsn.c
new file mode 100644
index 000000000000..4237bb2e7fa2
--- /dev/null
+++ b/tools/perf/arch/x86/util/archinsn.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "perf.h"
+#include "archinsn.h"
+#include "util/intel-pt-decoder/insn.h"
+#include "machine.h"
+#include "thread.h"
+#include "symbol.h"
+
+void arch_fetch_insn(struct perf_sample *sample,
+		     struct thread *thread,
+		     struct machine *machine)
+{
+	struct insn insn;
+	int len;
+	bool is64bit = false;
+
+	if (!sample->ip)
+		return;
+	len = thread__memcpy(thread, machine, sample->insn, sample->ip, sizeof(sample->insn), &is64bit);
+	if (len <= 0)
+		return;
+	insn_init(&insn, sample->insn, len, is64bit);
+	insn_get_length(&insn);
+	if (insn_complete(&insn) && insn.length <= len)
+		sample->insn_len = insn.length;
+}
diff --git a/tools/perf/bench/epoll-ctl.c b/tools/perf/bench/epoll-ctl.c
index 0c0a6e824934..2af067859966 100644
--- a/tools/perf/bench/epoll-ctl.c
+++ b/tools/perf/bench/epoll-ctl.c
@@ -224,7 +224,7 @@ static int do_threads(struct worker *worker, struct cpu_map *cpu)
 	pthread_attr_t thread_attr, *attrp = NULL;
 	cpu_set_t cpuset;
 	unsigned int i, j;
-	int ret;
+	int ret = 0;
 
 	if (!noaffinity)
 		pthread_attr_init(&thread_attr);
diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
index 5a11534e96a0..fe85448abd45 100644
--- a/tools/perf/bench/epoll-wait.c
+++ b/tools/perf/bench/epoll-wait.c
@@ -293,7 +293,7 @@ static int do_threads(struct worker *worker, struct cpu_map *cpu)
 	pthread_attr_t thread_attr, *attrp = NULL;
 	cpu_set_t cpuset;
 	unsigned int i, j;
-	int ret, events = EPOLLIN;
+	int ret = 0, events = EPOLLIN;
 
 	if (oneshot)
 		events |= EPOLLONESHOT;
diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index c9f98d00c0e9..a8394b4f1167 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -119,7 +119,7 @@ int cmd_list(int argc, const char **argv)
 						details_flag);
 			print_tracepoint_events(NULL, s, raw_dump);
 			print_sdt_events(NULL, s, raw_dump);
-			metricgroup__print(true, true, NULL, raw_dump, details_flag);
+			metricgroup__print(true, true, s, raw_dump, details_flag);
 			free(s);
 		}
 	}
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index f3f7f3100336..4e2d953d4bc5 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -62,6 +62,9 @@ struct switch_output {
 	unsigned long	 time;
 	const char	*str;
 	bool		 set;
+	char		 **filenames;
+	int		 num_files;
+	int		 cur_file;
 };
 
 struct record {
@@ -392,7 +395,7 @@ static int record__process_auxtrace(struct perf_tool *tool,
 	size_t padding;
 	u8 pad[8] = {0};
 
-	if (!perf_data__is_pipe(data)) {
+	if (!perf_data__is_pipe(data) && !perf_data__is_dir(data)) {
 		off_t file_offset;
 		int fd = perf_data__fd(data);
 		int err;
@@ -837,6 +840,8 @@ static void record__init_features(struct record *rec)
 	if (!(rec->opts.use_clockid && rec->opts.clockid_res_ns))
 		perf_header__clear_feat(&session->header, HEADER_CLOCKID);
 
+	perf_header__clear_feat(&session->header, HEADER_DIR_FORMAT);
+
 	perf_header__clear_feat(&session->header, HEADER_STAT);
 }
 
@@ -890,6 +895,7 @@ record__switch_output(struct record *rec, bool at_exit)
 {
 	struct perf_data *data = &rec->data;
 	int fd, err;
+	char *new_filename;
 
 	/* Same Size:      "2015122520103046"*/
 	char timestamp[] = "InvalidTimestamp";
@@ -910,7 +916,7 @@ record__switch_output(struct record *rec, bool at_exit)
 
 	fd = perf_data__switch(data, timestamp,
 				    rec->session->header.data_offset,
-				    at_exit);
+				    at_exit, &new_filename);
 	if (fd >= 0 && !at_exit) {
 		rec->bytes_written = 0;
 		rec->session->header.data_size = 0;
@@ -920,6 +926,21 @@ record__switch_output(struct record *rec, bool at_exit)
 		fprintf(stderr, "[ perf record: Dump %s.%s ]\n",
 			data->path, timestamp);
 
+	if (rec->switch_output.num_files) {
+		int n = rec->switch_output.cur_file + 1;
+
+		if (n >= rec->switch_output.num_files)
+			n = 0;
+		rec->switch_output.cur_file = n;
+		if (rec->switch_output.filenames[n]) {
+			remove(rec->switch_output.filenames[n]);
+			free(rec->switch_output.filenames[n]);
+		}
+		rec->switch_output.filenames[n] = new_filename;
+	} else {
+		free(new_filename);
+	}
+
 	/* Output tracking events */
 	if (!at_exit) {
 		record__synthesize(rec, false);
@@ -1093,7 +1114,7 @@ static int record__synthesize(struct record *rec, bool tail)
 		return err;
 	}
 
-	err = perf_event__synthesize_bpf_events(tool, process_synthesized_event,
+	err = perf_event__synthesize_bpf_events(session, process_synthesized_event,
 						machine, opts);
 	if (err < 0)
 		pr_warning("Couldn't synthesize bpf events.\n");
@@ -1116,6 +1137,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	struct perf_data *data = &rec->data;
 	struct perf_session *session;
 	bool disabled = false, draining = false;
+	struct perf_evlist *sb_evlist = NULL;
 	int fd;
 
 	atexit(record__sig_exit);
@@ -1216,6 +1238,14 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		goto out_child;
 	}
 
+	if (!opts->no_bpf_event)
+		bpf_event__add_sb_event(&sb_evlist, &session->header.env);
+
+	if (perf_evlist__start_sb_thread(sb_evlist, &rec->opts.target)) {
+		pr_debug("Couldn't start the BPF side band thread:\nBPF programs starting from now on won't be annotatable\n");
+		opts->no_bpf_event = true;
+	}
+
 	err = record__synthesize(rec, false);
 	if (err < 0)
 		goto out_child;
@@ -1466,6 +1496,9 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 
 out_delete_session:
 	perf_session__delete(session);
+
+	if (!opts->no_bpf_event)
+		perf_evlist__stop_sb_thread(sb_evlist);
 	return status;
 }
 
@@ -1870,7 +1903,7 @@ static struct option __record_options[] = {
 	OPT_BOOLEAN(0, "tail-synthesize", &record.opts.tail_synthesize,
 		    "synthesize non-sample events at the end of output"),
 	OPT_BOOLEAN(0, "overwrite", &record.opts.overwrite, "use overwrite mode"),
-	OPT_BOOLEAN(0, "bpf-event", &record.opts.bpf_event, "record bpf events"),
+	OPT_BOOLEAN(0, "no-bpf-event", &record.opts.no_bpf_event, "record bpf events"),
 	OPT_BOOLEAN(0, "strict-freq", &record.opts.strict_freq,
 		    "Fail if the specified frequency can't be used"),
 	OPT_CALLBACK('F', "freq", &record.opts, "freq or 'max'",
@@ -1968,9 +2001,11 @@ static struct option __record_options[] = {
 	OPT_BOOLEAN(0, "timestamp-boundary", &record.timestamp_boundary,
 		    "Record timestamp boundary (time of first/last samples)"),
 	OPT_STRING_OPTARG_SET(0, "switch-output", &record.switch_output.str,
-			  &record.switch_output.set, "signal,size,time",
-			  "Switch output when receive SIGUSR2 or cross size,time threshold",
+			  &record.switch_output.set, "signal or size[BKMG] or time[smhd]",
+			  "Switch output when receiving SIGUSR2 (signal) or cross a size or time threshold",
 			  "signal"),
+	OPT_INTEGER(0, "switch-max-files", &record.switch_output.num_files,
+		   "Limit number of switch output generated files"),
 	OPT_BOOLEAN(0, "dry-run", &dry_run,
 		    "Parse options then exit"),
 #ifdef HAVE_AIO_SUPPORT
@@ -2057,6 +2092,13 @@ int cmd_record(int argc, const char **argv)
 		alarm(rec->switch_output.time);
 	}
 
+	if (rec->switch_output.num_files) {
+		rec->switch_output.filenames = calloc(sizeof(char *),
+						      rec->switch_output.num_files);
+		if (!rec->switch_output.filenames)
+			return -EINVAL;
+	}
+
 	/*
 	 * Allow aliases to facilitate the lookup of symbols for address
 	 * filters. Refer to auxtrace_parse_filters().
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index ee93c18a6685..4054eb1f98ac 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -47,9 +47,11 @@
 #include <errno.h>
 #include <inttypes.h>
 #include <regex.h>
+#include "sane_ctype.h"
 #include <signal.h>
 #include <linux/bitmap.h>
 #include <linux/stringify.h>
+#include <linux/time64.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
@@ -926,6 +928,43 @@ report_parse_callchain_opt(const struct option *opt, const char *arg, int unset)
 	return parse_callchain_report_opt(arg);
 }
 
+static int
+parse_time_quantum(const struct option *opt, const char *arg,
+		   int unset __maybe_unused)
+{
+	unsigned long *time_q = opt->value;
+	char *end;
+
+	*time_q = strtoul(arg, &end, 0);
+	if (end == arg)
+		goto parse_err;
+	if (*time_q == 0) {
+		pr_err("time quantum cannot be 0");
+		return -1;
+	}
+	while (isspace(*end))
+		end++;
+	if (*end == 0)
+		return 0;
+	if (!strcmp(end, "s")) {
+		*time_q *= NSEC_PER_SEC;
+		return 0;
+	}
+	if (!strcmp(end, "ms")) {
+		*time_q *= NSEC_PER_MSEC;
+		return 0;
+	}
+	if (!strcmp(end, "us")) {
+		*time_q *= NSEC_PER_USEC;
+		return 0;
+	}
+	if (!strcmp(end, "ns"))
+		return 0;
+parse_err:
+	pr_err("Cannot parse time quantum `%s'\n", arg);
+	return -1;
+}
+
 int
 report_parse_ignore_callees_opt(const struct option *opt __maybe_unused,
 				const char *arg, int unset __maybe_unused)
@@ -1044,10 +1083,9 @@ int cmd_report(int argc, const char **argv)
 	OPT_BOOLEAN(0, "header-only", &report.header_only,
 		    "Show only data header."),
 	OPT_STRING('s', "sort", &sort_order, "key[,key2...]",
-		   "sort by key(s): pid, comm, dso, symbol, parent, cpu, srcline, ..."
-		   " Please refer the man page for the complete list."),
+		   sort_help("sort by key(s):")),
 	OPT_STRING('F', "fields", &field_order, "key[,keys...]",
-		   "output field(s): overhead, period, sample plus all of sort keys"),
+		   sort_help("output field(s): overhead period sample ")),
 	OPT_BOOLEAN(0, "show-cpu-utilization", &symbol_conf.show_cpu_utilization,
 		    "Show sample percentage for different cpu modes"),
 	OPT_BOOLEAN_FLAG(0, "showcpuutilization", &symbol_conf.show_cpu_utilization,
@@ -1120,6 +1158,8 @@ int cmd_report(int argc, const char **argv)
 	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
 		    "Enable kernel symbol demangling"),
 	OPT_BOOLEAN(0, "mem-mode", &report.mem_mode, "mem access profile"),
+	OPT_INTEGER(0, "samples", &symbol_conf.res_sample,
+		    "Number of samples to save per histogram entry for individual browsing"),
 	OPT_CALLBACK(0, "percent-limit", &report, "percent",
 		     "Don't show entries under that percent", parse_percent_limit),
 	OPT_CALLBACK(0, "percentage", NULL, "relative|absolute",
@@ -1147,6 +1187,10 @@ int cmd_report(int argc, const char **argv)
 	OPT_CALLBACK(0, "percent-type", &report.annotation_opts, "local-period",
 		     "Set percent type local/global-period/hits",
 		     annotate_parse_percent_type),
+	OPT_BOOLEAN(0, "ns", &symbol_conf.nanosecs, "Show times in nanosecs"),
+	OPT_CALLBACK(0, "time-quantum", &symbol_conf.time_quantum, "time (ms|us|ns|s)",
+		     "Set time quantum for time sort key (default 100ms)",
+		     parse_time_quantum),
 	OPT_END()
 	};
 	struct perf_data data = {
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 53f78cf3113f..61cfd8f70989 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -29,10 +29,12 @@
 #include "util/time-utils.h"
 #include "util/path.h"
 #include "print_binary.h"
+#include "archinsn.h"
 #include <linux/bitmap.h>
 #include <linux/kernel.h>
 #include <linux/stringify.h>
 #include <linux/time64.h>
+#include <sys/utsname.h>
 #include "asm/bug.h"
 #include "util/mem-events.h"
 #include "util/dump-insn.h"
@@ -51,6 +53,8 @@
 
 static char const		*script_name;
 static char const		*generate_script_lang;
+static bool			reltime;
+static u64			initial_time;
 static bool			debug_mode;
 static u64			last_timestamp;
 static u64			nr_unordered;
@@ -58,11 +62,11 @@ static bool			no_callchain;
 static bool			latency_format;
 static bool			system_wide;
 static bool			print_flags;
-static bool			nanosecs;
 static const char		*cpu_list;
 static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
 static struct perf_stat_config	stat_config;
 static int			max_blocks;
+static bool			native_arch;
 
 unsigned int scripting_max_stack = PERF_MAX_STACK_DEPTH;
 
@@ -684,15 +688,21 @@ static int perf_sample__fprintf_start(struct perf_sample *sample,
 	}
 
 	if (PRINT_FIELD(TIME)) {
-		nsecs = sample->time;
+		u64 t = sample->time;
+		if (reltime) {
+			if (!initial_time)
+				initial_time = sample->time;
+			t = sample->time - initial_time;
+		}
+		nsecs = t;
 		secs = nsecs / NSEC_PER_SEC;
 		nsecs -= secs * NSEC_PER_SEC;
 
-		if (nanosecs)
+		if (symbol_conf.nanosecs)
 			printed += fprintf(fp, "%5lu.%09llu: ", secs, nsecs);
 		else {
 			char sample_time[32];
-			timestamp__scnprintf_usec(sample->time, sample_time, sizeof(sample_time));
+			timestamp__scnprintf_usec(t, sample_time, sizeof(sample_time));
 			printed += fprintf(fp, "%12s: ", sample_time);
 		}
 	}
@@ -1227,6 +1237,12 @@ static int perf_sample__fprintf_callindent(struct perf_sample *sample,
 	return len + dlen;
 }
 
+__weak void arch_fetch_insn(struct perf_sample *sample __maybe_unused,
+			    struct thread *thread __maybe_unused,
+			    struct machine *machine __maybe_unused)
+{
+}
+
 static int perf_sample__fprintf_insn(struct perf_sample *sample,
 				     struct perf_event_attr *attr,
 				     struct thread *thread,
@@ -1234,9 +1250,12 @@ static int perf_sample__fprintf_insn(struct perf_sample *sample,
 {
 	int printed = 0;
 
+	if (sample->insn_len == 0 && native_arch)
+		arch_fetch_insn(sample, thread, machine);
+
 	if (PRINT_FIELD(INSNLEN))
 		printed += fprintf(fp, " ilen: %d", sample->insn_len);
-	if (PRINT_FIELD(INSN)) {
+	if (PRINT_FIELD(INSN) && sample->insn_len) {
 		int i;
 
 		printed += fprintf(fp, " insn:");
@@ -1922,6 +1941,13 @@ static int cleanup_scripting(void)
 	return scripting_ops ? scripting_ops->stop_script() : 0;
 }
 
+static bool filter_cpu(struct perf_sample *sample)
+{
+	if (cpu_list)
+		return !test_bit(sample->cpu, cpu_bitmap);
+	return false;
+}
+
 static int process_sample_event(struct perf_tool *tool,
 				union perf_event *event,
 				struct perf_sample *sample,
@@ -1956,7 +1982,7 @@ static int process_sample_event(struct perf_tool *tool,
 	if (al.filtered)
 		goto out_put;
 
-	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
+	if (filter_cpu(sample))
 		goto out_put;
 
 	if (scripting_ops)
@@ -2041,9 +2067,11 @@ static int process_comm_event(struct perf_tool *tool,
 		sample->tid = event->comm.tid;
 		sample->pid = event->comm.pid;
 	}
-	perf_sample__fprintf_start(sample, thread, evsel,
+	if (!filter_cpu(sample)) {
+		perf_sample__fprintf_start(sample, thread, evsel,
 				   PERF_RECORD_COMM, stdout);
-	perf_event__fprintf(event, stdout);
+		perf_event__fprintf(event, stdout);
+	}
 	ret = 0;
 out:
 	thread__put(thread);
@@ -2077,9 +2105,11 @@ static int process_namespaces_event(struct perf_tool *tool,
 		sample->tid = event->namespaces.tid;
 		sample->pid = event->namespaces.pid;
 	}
-	perf_sample__fprintf_start(sample, thread, evsel,
-				   PERF_RECORD_NAMESPACES, stdout);
-	perf_event__fprintf(event, stdout);
+	if (!filter_cpu(sample)) {
+		perf_sample__fprintf_start(sample, thread, evsel,
+					   PERF_RECORD_NAMESPACES, stdout);
+		perf_event__fprintf(event, stdout);
+	}
 	ret = 0;
 out:
 	thread__put(thread);
@@ -2111,9 +2141,11 @@ static int process_fork_event(struct perf_tool *tool,
 		sample->tid = event->fork.tid;
 		sample->pid = event->fork.pid;
 	}
-	perf_sample__fprintf_start(sample, thread, evsel,
-				   PERF_RECORD_FORK, stdout);
-	perf_event__fprintf(event, stdout);
+	if (!filter_cpu(sample)) {
+		perf_sample__fprintf_start(sample, thread, evsel,
+					   PERF_RECORD_FORK, stdout);
+		perf_event__fprintf(event, stdout);
+	}
 	thread__put(thread);
 
 	return 0;
@@ -2141,9 +2173,11 @@ static int process_exit_event(struct perf_tool *tool,
 		sample->tid = event->fork.tid;
 		sample->pid = event->fork.pid;
 	}
-	perf_sample__fprintf_start(sample, thread, evsel,
-				   PERF_RECORD_EXIT, stdout);
-	perf_event__fprintf(event, stdout);
+	if (!filter_cpu(sample)) {
+		perf_sample__fprintf_start(sample, thread, evsel,
+					   PERF_RECORD_EXIT, stdout);
+		perf_event__fprintf(event, stdout);
+	}
 
 	if (perf_event__process_exit(tool, event, sample, machine) < 0)
 		err = -1;
@@ -2177,9 +2211,11 @@ static int process_mmap_event(struct perf_tool *tool,
 		sample->tid = event->mmap.tid;
 		sample->pid = event->mmap.pid;
 	}
-	perf_sample__fprintf_start(sample, thread, evsel,
-				   PERF_RECORD_MMAP, stdout);
-	perf_event__fprintf(event, stdout);
+	if (!filter_cpu(sample)) {
+		perf_sample__fprintf_start(sample, thread, evsel,
+					   PERF_RECORD_MMAP, stdout);
+		perf_event__fprintf(event, stdout);
+	}
 	thread__put(thread);
 	return 0;
 }
@@ -2209,9 +2245,11 @@ static int process_mmap2_event(struct perf_tool *tool,
 		sample->tid = event->mmap2.tid;
 		sample->pid = event->mmap2.pid;
 	}
-	perf_sample__fprintf_start(sample, thread, evsel,
-				   PERF_RECORD_MMAP2, stdout);
-	perf_event__fprintf(event, stdout);
+	if (!filter_cpu(sample)) {
+		perf_sample__fprintf_start(sample, thread, evsel,
+					   PERF_RECORD_MMAP2, stdout);
+		perf_event__fprintf(event, stdout);
+	}
 	thread__put(thread);
 	return 0;
 }
@@ -2236,9 +2274,11 @@ static int process_switch_event(struct perf_tool *tool,
 		return -1;
 	}
 
-	perf_sample__fprintf_start(sample, thread, evsel,
-				   PERF_RECORD_SWITCH, stdout);
-	perf_event__fprintf(event, stdout);
+	if (!filter_cpu(sample)) {
+		perf_sample__fprintf_start(sample, thread, evsel,
+					   PERF_RECORD_SWITCH, stdout);
+		perf_event__fprintf(event, stdout);
+	}
 	thread__put(thread);
 	return 0;
 }
@@ -2259,9 +2299,11 @@ process_lost_event(struct perf_tool *tool,
 	if (thread == NULL)
 		return -1;
 
-	perf_sample__fprintf_start(sample, thread, evsel,
-				   PERF_RECORD_LOST, stdout);
-	perf_event__fprintf(event, stdout);
+	if (!filter_cpu(sample)) {
+		perf_sample__fprintf_start(sample, thread, evsel,
+					   PERF_RECORD_LOST, stdout);
+		perf_event__fprintf(event, stdout);
+	}
 	thread__put(thread);
 	return 0;
 }
@@ -2948,7 +2990,8 @@ static int check_ev_match(char *dir_name, char *scriptname,
  * will list all statically runnable scripts, select one, execute it and
  * show the output in a perf browser.
  */
-int find_scripts(char **scripts_array, char **scripts_path_array)
+int find_scripts(char **scripts_array, char **scripts_path_array, int num,
+		 int pathlen)
 {
 	struct dirent *script_dirent, *lang_dirent;
 	char scripts_path[MAXPATHLEN], lang_path[MAXPATHLEN];
@@ -2993,7 +3036,10 @@ int find_scripts(char **scripts_array, char **scripts_path_array)
 			/* Skip those real time scripts: xxxtop.p[yl] */
 			if (strstr(script_dirent->d_name, "top."))
 				continue;
-			sprintf(scripts_path_array[i], "%s/%s", lang_path,
+			if (i >= num)
+				break;
+			snprintf(scripts_path_array[i], pathlen, "%s/%s",
+				lang_path,
 				script_dirent->d_name);
 			temp = strchr(script_dirent->d_name, '.');
 			snprintf(scripts_array[i],
@@ -3232,7 +3278,7 @@ static int parse_insn_trace(const struct option *opt __maybe_unused,
 {
 	parse_output_fields(NULL, "+insn,-event,-period", 0);
 	itrace_parse_synth_opts(opt, "i0ns", 0);
-	nanosecs = true;
+	symbol_conf.nanosecs = true;
 	return 0;
 }
 
@@ -3250,7 +3296,7 @@ static int parse_call_trace(const struct option *opt __maybe_unused,
 {
 	parse_output_fields(NULL, "-ip,-addr,-event,-period,+callindent", 0);
 	itrace_parse_synth_opts(opt, "cewp", 0);
-	nanosecs = true;
+	symbol_conf.nanosecs = true;
 	return 0;
 }
 
@@ -3260,7 +3306,7 @@ static int parse_callret_trace(const struct option *opt __maybe_unused,
 {
 	parse_output_fields(NULL, "-ip,-addr,-event,-period,+callindent,+flags", 0);
 	itrace_parse_synth_opts(opt, "crewp", 0);
-	nanosecs = true;
+	symbol_conf.nanosecs = true;
 	return 0;
 }
 
@@ -3277,6 +3323,7 @@ int cmd_script(int argc, const char **argv)
 		.set = false,
 		.default_no_sample = true,
 	};
+	struct utsname uts;
 	char *script_path = NULL;
 	const char **__argv;
 	int i, j, err = 0;
@@ -3374,6 +3421,7 @@ int cmd_script(int argc, const char **argv)
 		     "Set the maximum stack depth when parsing the callchain, "
 		     "anything beyond the specified depth will be ignored. "
 		     "Default: kernel.perf_event_max_stack or " __stringify(PERF_MAX_STACK_DEPTH)),
+	OPT_BOOLEAN(0, "reltime", &reltime, "Show time stamps relative to start"),
 	OPT_BOOLEAN('I', "show-info", &show_full_info,
 		    "display extended information from perf.data file"),
 	OPT_BOOLEAN('\0', "show-kernel-path", &symbol_conf.show_kernel_path,
@@ -3395,7 +3443,7 @@ int cmd_script(int argc, const char **argv)
 	OPT_BOOLEAN('f', "force", &symbol_conf.force, "don't complain, do it"),
 	OPT_INTEGER(0, "max-blocks", &max_blocks,
 		    "Maximum number of code blocks to dump with brstackinsn"),
-	OPT_BOOLEAN(0, "ns", &nanosecs,
+	OPT_BOOLEAN(0, "ns", &symbol_conf.nanosecs,
 		    "Use 9 decimal places when displaying time"),
 	OPT_CALLBACK_OPTARG(0, "itrace", &itrace_synth_opts, NULL, "opts",
 			    "Instruction Tracing options\n" ITRACE_HELP,
@@ -3448,6 +3496,11 @@ int cmd_script(int argc, const char **argv)
 		}
 	}
 
+	if (script.time_str && reltime) {
+		fprintf(stderr, "Don't combine --reltime with --time\n");
+		return -1;
+	}
+
 	if (itrace_synth_opts.callchain &&
 	    itrace_synth_opts.callchain_sz > scripting_max_stack)
 		scripting_max_stack = itrace_synth_opts.callchain_sz;
@@ -3615,6 +3668,12 @@ int cmd_script(int argc, const char **argv)
 	if (symbol__init(&session->header.env) < 0)
 		goto out_delete;
 
+	uname(&uts);
+	if (!strcmp(uts.machine, session->header.env.arch) ||
+	    (!strcmp(uts.machine, "x86_64") &&
+	     !strcmp(session->header.env.arch, "i386")))
+		native_arch = true;
+
 	script.session = session;
 	script__setup_sample_type(&script);
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 7b8f09b0b8bf..49ee3c2033ec 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -718,7 +718,8 @@ static struct option stat_options[] = {
 		    "system-wide collection from all CPUs"),
 	OPT_BOOLEAN('g', "group", &group,
 		    "put the counters into a counter group"),
-	OPT_BOOLEAN('c', "scale", &stat_config.scale, "scale/normalize counters"),
+	OPT_BOOLEAN(0, "scale", &stat_config.scale,
+		    "Use --no-scale to disable counter scaling for multiplexing"),
 	OPT_INCR('v', "verbose", &verbose,
 		    "be more verbose (show counter open errors, etc)"),
 	OPT_INTEGER('r', "repeat", &stat_config.run_count,
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 231a90daa958..1999d6533d12 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1189,30 +1189,26 @@ static int __cmd_top(struct perf_top *top)
 	pthread_t thread, thread_process;
 	int ret;
 
-	top->session = perf_session__new(NULL, false, NULL);
-	if (top->session == NULL)
-		return -1;
-
 	if (!top->annotation_opts.objdump_path) {
 		ret = perf_env__lookup_objdump(&top->session->header.env,
 					       &top->annotation_opts.objdump_path);
 		if (ret)
-			goto out_delete;
+			return ret;
 	}
 
 	ret = callchain_param__setup_sample_type(&callchain_param);
 	if (ret)
-		goto out_delete;
+		return ret;
 
 	if (perf_session__register_idle_thread(top->session) < 0)
-		goto out_delete;
+		return ret;
 
 	if (top->nr_threads_synthesize > 1)
 		perf_set_multithreaded();
 
 	init_process_thread(top);
 
-	ret = perf_event__synthesize_bpf_events(&top->tool, perf_event__process,
+	ret = perf_event__synthesize_bpf_events(top->session, perf_event__process,
 						&top->session->machines.host,
 						&top->record_opts);
 	if (ret < 0)
@@ -1227,13 +1223,18 @@ static int __cmd_top(struct perf_top *top)
 
 	if (perf_hpp_list.socket) {
 		ret = perf_env__read_cpu_topology_map(&perf_env);
-		if (ret < 0)
-			goto out_err_cpu_topo;
+		if (ret < 0) {
+			char errbuf[BUFSIZ];
+			const char *err = str_error_r(-ret, errbuf, sizeof(errbuf));
+
+			ui__error("Could not read the CPU topology map: %s\n", err);
+			return ret;
+		}
 	}
 
 	ret = perf_top__start_counters(top);
 	if (ret)
-		goto out_delete;
+		return ret;
 
 	top->session->evlist = top->evlist;
 	perf_session__set_id_hdr_size(top->session);
@@ -1252,7 +1253,7 @@ static int __cmd_top(struct perf_top *top)
 	ret = -1;
 	if (pthread_create(&thread_process, NULL, process_thread, top)) {
 		ui__error("Could not create process thread.\n");
-		goto out_delete;
+		return ret;
 	}
 
 	if (pthread_create(&thread, NULL, (use_browser > 0 ? display_thread_tui :
@@ -1296,19 +1297,7 @@ static int __cmd_top(struct perf_top *top)
 out_join_thread:
 	pthread_cond_signal(&top->qe.cond);
 	pthread_join(thread_process, NULL);
-out_delete:
-	perf_session__delete(top->session);
-	top->session = NULL;
-
 	return ret;
-
-out_err_cpu_topo: {
-	char errbuf[BUFSIZ];
-	const char *err = str_error_r(-ret, errbuf, sizeof(errbuf));
-
-	ui__error("Could not read the CPU topology map: %s\n", err);
-	goto out_delete;
-}
 }
 
 static int
@@ -1480,6 +1469,7 @@ int cmd_top(int argc, const char **argv)
 		    "Display raw encoding of assembly instructions (default)"),
 	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
 		    "Enable kernel symbol demangling"),
+	OPT_BOOLEAN(0, "no-bpf-event", &top.record_opts.no_bpf_event, "do not record bpf events"),
 	OPT_STRING(0, "objdump", &top.annotation_opts.objdump_path, "path",
 		    "objdump binary to use for disassembly and annotations"),
 	OPT_STRING('M', "disassembler-style", &top.annotation_opts.disassembler_style, "disassembler style",
@@ -1511,6 +1501,7 @@ int cmd_top(int argc, const char **argv)
 			"number of thread to run event synthesize"),
 	OPT_END()
 	};
+	struct perf_evlist *sb_evlist = NULL;
 	const char * const top_usage[] = {
 		"perf top [<options>]",
 		NULL
@@ -1628,8 +1619,9 @@ int cmd_top(int argc, const char **argv)
 	annotation_config__init();
 
 	symbol_conf.try_vmlinux_path = (symbol_conf.vmlinux_name == NULL);
-	if (symbol__init(NULL) < 0)
-		return -1;
+	status = symbol__init(NULL);
+	if (status < 0)
+		goto out_delete_evlist;
 
 	sort__setup_elide(stdout);
 
@@ -1639,10 +1631,28 @@ int cmd_top(int argc, const char **argv)
 		signal(SIGWINCH, winch_sig);
 	}
 
+	top.session = perf_session__new(NULL, false, NULL);
+	if (top.session == NULL) {
+		status = -1;
+		goto out_delete_evlist;
+	}
+
+	if (!top.record_opts.no_bpf_event)
+		bpf_event__add_sb_event(&sb_evlist, &perf_env);
+
+	if (perf_evlist__start_sb_thread(sb_evlist, target)) {
+		pr_debug("Couldn't start the BPF side band thread:\nBPF programs starting from now on won't be annotatable\n");
+		opts->no_bpf_event = true;
+	}
+
 	status = __cmd_top(&top);
 
+	if (!opts->no_bpf_event)
+		perf_evlist__stop_sb_thread(sb_evlist);
+
 out_delete_evlist:
 	perf_evlist__delete(top.evlist);
+	perf_session__delete(top.session);
 
 	return status;
 }
diff --git a/tools/perf/builtin.h b/tools/perf/builtin.h
index 05745f3ce912..999fe9170122 100644
--- a/tools/perf/builtin.h
+++ b/tools/perf/builtin.h
@@ -40,5 +40,6 @@ int cmd_mem(int argc, const char **argv);
 int cmd_data(int argc, const char **argv);
 int cmd_ftrace(int argc, const char **argv);
 
-int find_scripts(char **scripts_array, char **scripts_path_array);
+int find_scripts(char **scripts_array, char **scripts_path_array, int num,
+		 int pathlen);
 #endif
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index a11cb006f968..72df4b6fa36f 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -298,6 +298,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 		use_pager = 1;
 	commit_pager_choice();
 
+	perf_env__init(&perf_env);
 	perf_env__set_cmdline(&perf_env, argc, argv);
 	status = p->fn(argc, argv);
 	perf_config__exit();
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index b120e547ddc7..c59743def8d3 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -66,7 +66,7 @@ struct record_opts {
 	bool	     ignore_missing_thread;
 	bool	     strict_freq;
 	bool	     sample_id;
-	bool	     bpf_event;
+	bool	     no_bpf_event;
 	unsigned int freq;
 	unsigned int mmap_pages;
 	unsigned int auxtrace_mmap_pages;
diff --git a/tools/perf/pmu-events/arch/powerpc/power8/other.json b/tools/perf/pmu-events/arch/powerpc/power8/other.json
index 704302c3e67d..9dc2f6b70354 100644
--- a/tools/perf/pmu-events/arch/powerpc/power8/other.json
+++ b/tools/perf/pmu-events/arch/powerpc/power8/other.json
@@ -347,18 +347,6 @@
     "BriefDescription": "CO mach 0 Busy. Used by PMU to sample ave RC livetime(mach0 used as sample point)",
     "PublicDescription": ""
   },
-  {,
-    "EventCode": "0x517082",
-    "EventName": "PM_CO_DISP_FAIL",
-    "BriefDescription": "CO dispatch failed due to all CO machines being busy",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x527084",
-    "EventName": "PM_CO_TM_SC_FOOTPRINT",
-    "BriefDescription": "L2 did a cleanifdirty CO to the L3 (ie created an SC line in the L3)",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x3608a",
     "EventName": "PM_CO_USAGE",
@@ -1577,36 +1565,12 @@
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Shared (S) data from another core's L3 on the same chip due to a instruction side request",
     "PublicDescription": ""
   },
-  {,
-    "EventCode": "0x617082",
-    "EventName": "PM_ISIDE_DISP",
-    "BriefDescription": "All i-side dispatch attempts",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x627084",
-    "EventName": "PM_ISIDE_DISP_FAIL",
-    "BriefDescription": "All i-side dispatch attempts that failed due to a addr collision with another machine",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x627086",
-    "EventName": "PM_ISIDE_DISP_FAIL_OTHER",
-    "BriefDescription": "All i-side dispatch attempts that failed due to a reason other than addrs collision",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x4608e",
     "EventName": "PM_ISIDE_L2MEMACC",
     "BriefDescription": "valid when first beat of data comes in for an i-side fetch where data came from mem(or L4)",
     "PublicDescription": ""
   },
-  {,
-    "EventCode": "0x44608e",
-    "EventName": "PM_ISIDE_MRU_TOUCH",
-    "BriefDescription": "Iside L2 MRU touch",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x30ac",
     "EventName": "PM_ISU_REF_FX0",
@@ -1733,222 +1697,36 @@
     "BriefDescription": "Instruction Demand sectors wriittent into IL1",
     "PublicDescription": ""
   },
-  {,
-    "EventCode": "0x417080",
-    "EventName": "PM_L2_CASTOUT_MOD",
-    "BriefDescription": "L2 Castouts - Modified (M, Mu, Me)",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x417082",
-    "EventName": "PM_L2_CASTOUT_SHR",
-    "BriefDescription": "L2 Castouts - Shared (T, Te, Si, S)",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x27084",
     "EventName": "PM_L2_CHIP_PUMP",
     "BriefDescription": "RC requests that were local on chip pump attempts",
     "PublicDescription": ""
   },
-  {,
-    "EventCode": "0x427086",
-    "EventName": "PM_L2_DC_INV",
-    "BriefDescription": "Dcache invalidates from L2",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x44608c",
-    "EventName": "PM_L2_DISP_ALL_L2MISS",
-    "BriefDescription": "All successful Ld/St dispatches for this thread that were an L2miss",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x27086",
     "EventName": "PM_L2_GROUP_PUMP",
     "BriefDescription": "RC requests that were on Node Pump attempts",
     "PublicDescription": ""
   },
-  {,
-    "EventCode": "0x626084",
-    "EventName": "PM_L2_GRP_GUESS_CORRECT",
-    "BriefDescription": "L2 guess grp and guess was correct (data intra-6chip AND ^on-chip)",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x626086",
-    "EventName": "PM_L2_GRP_GUESS_WRONG",
-    "BriefDescription": "L2 guess grp and guess was not correct (ie data on-chip OR beyond-6chip)",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x427084",
-    "EventName": "PM_L2_IC_INV",
-    "BriefDescription": "Icache Invalidates from L2",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x436088",
-    "EventName": "PM_L2_INST",
-    "BriefDescription": "All successful I-side dispatches for this thread (excludes i_l2mru_tch reqs)",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x43608a",
-    "EventName": "PM_L2_INST_MISS",
-    "BriefDescription": "All successful i-side dispatches that were an L2miss for this thread (excludes i_l2mru_tch reqs)",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x416080",
-    "EventName": "PM_L2_LD",
-    "BriefDescription": "All successful D-side Load dispatches for this thread",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x437088",
-    "EventName": "PM_L2_LD_DISP",
-    "BriefDescription": "All successful load dispatches",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x43708a",
-    "EventName": "PM_L2_LD_HIT",
-    "BriefDescription": "All successful load dispatches that were L2 hits",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x426084",
-    "EventName": "PM_L2_LD_MISS",
-    "BriefDescription": "All successful D-Side Load dispatches that were an L2miss for this thread",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x616080",
-    "EventName": "PM_L2_LOC_GUESS_CORRECT",
-    "BriefDescription": "L2 guess loc and guess was correct (ie data local)",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x616082",
-    "EventName": "PM_L2_LOC_GUESS_WRONG",
-    "BriefDescription": "L2 guess loc and guess was not correct (ie data not on chip)",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x516080",
-    "EventName": "PM_L2_RCLD_DISP",
-    "BriefDescription": "L2 RC load dispatch attempt",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x516082",
-    "EventName": "PM_L2_RCLD_DISP_FAIL_ADDR",
-    "BriefDescription": "L2 RC load dispatch attempt failed due to address collision with RC/CO/SN/SQ",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x526084",
-    "EventName": "PM_L2_RCLD_DISP_FAIL_OTHER",
-    "BriefDescription": "L2 RC load dispatch attempt failed due to other reasons",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x536088",
-    "EventName": "PM_L2_RCST_DISP",
-    "BriefDescription": "L2 RC store dispatch attempt",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x53608a",
-    "EventName": "PM_L2_RCST_DISP_FAIL_ADDR",
-    "BriefDescription": "L2 RC store dispatch attempt failed due to address collision with RC/CO/SN/SQ",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x54608c",
-    "EventName": "PM_L2_RCST_DISP_FAIL_OTHER",
-    "BriefDescription": "L2 RC store dispatch attempt failed due to other reasons",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x537088",
-    "EventName": "PM_L2_RC_ST_DONE",
-    "BriefDescription": "RC did st to line that was Tx or Sx",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x63708a",
-    "EventName": "PM_L2_RTY_LD",
-    "BriefDescription": "RC retries on PB for any load from core",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x3708a",
     "EventName": "PM_L2_RTY_ST",
     "BriefDescription": "RC retries on PB for any store from core",
     "PublicDescription": ""
   },
-  {,
-    "EventCode": "0x54708c",
-    "EventName": "PM_L2_SN_M_RD_DONE",
-    "BriefDescription": "SNP dispatched for a read and was M",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x54708e",
-    "EventName": "PM_L2_SN_M_WR_DONE",
-    "BriefDescription": "SNP dispatched for a write and was M",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x53708a",
-    "EventName": "PM_L2_SN_SX_I_DONE",
-    "BriefDescription": "SNP dispatched and went from Sx or Tx to Ix",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x17080",
     "EventName": "PM_L2_ST",
     "BriefDescription": "All successful D-side store dispatches for this thread",
     "PublicDescription": ""
   },
-  {,
-    "EventCode": "0x44708c",
-    "EventName": "PM_L2_ST_DISP",
-    "BriefDescription": "All successful store dispatches",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x44708e",
-    "EventName": "PM_L2_ST_HIT",
-    "BriefDescription": "All successful store dispatches that were L2Hits",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x17082",
     "EventName": "PM_L2_ST_MISS",
     "BriefDescription": "All successful D-side store dispatches for this thread that were L2 Miss",
     "PublicDescription": ""
   },
-  {,
-    "EventCode": "0x636088",
-    "EventName": "PM_L2_SYS_GUESS_CORRECT",
-    "BriefDescription": "L2 guess sys and guess was correct (ie data beyond-6chip)",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x63608a",
-    "EventName": "PM_L2_SYS_GUESS_WRONG",
-    "BriefDescription": "L2 guess sys and guess was not correct (ie data ^beyond-6chip)",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x617080",
-    "EventName": "PM_L2_SYS_PUMP",
-    "BriefDescription": "RC requests that were system pump attempts",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x1e05e",
     "EventName": "PM_L2_TM_REQ_ABORT",
@@ -1961,36 +1739,12 @@
     "BriefDescription": "TM marked store abort",
     "PublicDescription": ""
   },
-  {,
-    "EventCode": "0x23808a",
-    "EventName": "PM_L3_CINJ",
-    "BriefDescription": "l3 ci of cache inject",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x128084",
-    "EventName": "PM_L3_CI_HIT",
-    "BriefDescription": "L3 Castins Hit (total count",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x128086",
-    "EventName": "PM_L3_CI_MISS",
-    "BriefDescription": "L3 castins miss (total count",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x819082",
     "EventName": "PM_L3_CI_USAGE",
     "BriefDescription": "rotating sample of 16 CI or CO actives",
     "PublicDescription": ""
   },
-  {,
-    "EventCode": "0x438088",
-    "EventName": "PM_L3_CO",
-    "BriefDescription": "l3 castout occurring ( does not include casthrough or log writes (cinj/dmaw)",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x83908b",
     "EventName": "PM_L3_CO0_ALLOC",
@@ -2009,120 +1763,18 @@
     "BriefDescription": "L3 CO to L3.1 OR of port 0 and 1 ( lossy)",
     "PublicDescription": ""
   },
-  {,
-    "EventCode": "0x238088",
-    "EventName": "PM_L3_CO_LCO",
-    "BriefDescription": "Total L3 castouts occurred on LCO",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x28084",
     "EventName": "PM_L3_CO_MEM",
     "BriefDescription": "L3 CO to memory OR of port 0 and 1 ( lossy)",
     "PublicDescription": ""
   },
-  {,
-    "EventCode": "0xb19082",
-    "EventName": "PM_L3_GRP_GUESS_CORRECT",
-    "BriefDescription": "Initial scope=group and data from same group (near) (pred successful)",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0xb3908a",
-    "EventName": "PM_L3_GRP_GUESS_WRONG_HIGH",
-    "BriefDescription": "Initial scope=group but data from local node. Predition too high",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0xb39088",
-    "EventName": "PM_L3_GRP_GUESS_WRONG_LOW",
-    "BriefDescription": "Initial scope=group but data from outside group (far or rem). Prediction too Low",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x218080",
-    "EventName": "PM_L3_HIT",
-    "BriefDescription": "L3 Hits",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x138088",
-    "EventName": "PM_L3_L2_CO_HIT",
-    "BriefDescription": "L2 castout hits",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x13808a",
-    "EventName": "PM_L3_L2_CO_MISS",
-    "BriefDescription": "L2 castout miss",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x14808c",
-    "EventName": "PM_L3_LAT_CI_HIT",
-    "BriefDescription": "L3 Lateral Castins Hit",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x14808e",
-    "EventName": "PM_L3_LAT_CI_MISS",
-    "BriefDescription": "L3 Lateral Castins Miss",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x228084",
-    "EventName": "PM_L3_LD_HIT",
-    "BriefDescription": "L3 demand LD Hits",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x228086",
-    "EventName": "PM_L3_LD_MISS",
-    "BriefDescription": "L3 demand LD Miss",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x1e052",
     "EventName": "PM_L3_LD_PREF",
     "BriefDescription": "L3 Load Prefetches",
     "PublicDescription": ""
   },
-  {,
-    "EventCode": "0xb19080",
-    "EventName": "PM_L3_LOC_GUESS_CORRECT",
-    "BriefDescription": "initial scope=node/chip and data from local node (local) (pred successful)",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0xb29086",
-    "EventName": "PM_L3_LOC_GUESS_WRONG",
-    "BriefDescription": "Initial scope=node but data from out side local node (near or far or rem). Prediction too Low",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x218082",
-    "EventName": "PM_L3_MISS",
-    "BriefDescription": "L3 Misses",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x54808c",
-    "EventName": "PM_L3_P0_CO_L31",
-    "BriefDescription": "l3 CO to L3.1 (lco) port 0",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x538088",
-    "EventName": "PM_L3_P0_CO_MEM",
-    "BriefDescription": "l3 CO to memory port 0",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x929084",
-    "EventName": "PM_L3_P0_CO_RTY",
-    "BriefDescription": "L3 CO received retry port 0",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0xa29084",
     "EventName": "PM_L3_P0_GRP_PUMP",
@@ -2147,120 +1799,6 @@
     "BriefDescription": "L3 LCO received retry port 0",
     "PublicDescription": ""
   },
-  {,
-    "EventCode": "0xa19080",
-    "EventName": "PM_L3_P0_NODE_PUMP",
-    "BriefDescription": "L3 pf sent with nodal scope port 0",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x919080",
-    "EventName": "PM_L3_P0_PF_RTY",
-    "BriefDescription": "L3 PF received retry port 0",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x939088",
-    "EventName": "PM_L3_P0_SN_HIT",
-    "BriefDescription": "L3 snoop hit port 0",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x118080",
-    "EventName": "PM_L3_P0_SN_INV",
-    "BriefDescription": "Port0 snooper detects someone doing a store to a line thats Sx",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x94908c",
-    "EventName": "PM_L3_P0_SN_MISS",
-    "BriefDescription": "L3 snoop miss port 0",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0xa39088",
-    "EventName": "PM_L3_P0_SYS_PUMP",
-    "BriefDescription": "L3 pf sent with sys scope port 0",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x54808e",
-    "EventName": "PM_L3_P1_CO_L31",
-    "BriefDescription": "l3 CO to L3.1 (lco) port 1",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x53808a",
-    "EventName": "PM_L3_P1_CO_MEM",
-    "BriefDescription": "l3 CO to memory port 1",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x929086",
-    "EventName": "PM_L3_P1_CO_RTY",
-    "BriefDescription": "L3 CO received retry port 1",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0xa29086",
-    "EventName": "PM_L3_P1_GRP_PUMP",
-    "BriefDescription": "L3 pf sent with grp scope port 1",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x528086",
-    "EventName": "PM_L3_P1_LCO_DATA",
-    "BriefDescription": "lco sent with data port 1",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x518082",
-    "EventName": "PM_L3_P1_LCO_NO_DATA",
-    "BriefDescription": "dataless l3 lco sent port 1",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0xa4908e",
-    "EventName": "PM_L3_P1_LCO_RTY",
-    "BriefDescription": "L3 LCO received retry port 1",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0xa19082",
-    "EventName": "PM_L3_P1_NODE_PUMP",
-    "BriefDescription": "L3 pf sent with nodal scope port 1",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x919082",
-    "EventName": "PM_L3_P1_PF_RTY",
-    "BriefDescription": "L3 PF received retry port 1",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x93908a",
-    "EventName": "PM_L3_P1_SN_HIT",
-    "BriefDescription": "L3 snoop hit port 1",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x118082",
-    "EventName": "PM_L3_P1_SN_INV",
-    "BriefDescription": "Port1 snooper detects someone doing a store to a line thats Sx",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x94908e",
-    "EventName": "PM_L3_P1_SN_MISS",
-    "BriefDescription": "L3 snoop miss port 1",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0xa3908a",
-    "EventName": "PM_L3_P1_SYS_PUMP",
-    "BriefDescription": "L3 pf sent with sys scope port 1",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x84908d",
     "EventName": "PM_L3_PF0_ALLOC",
@@ -2273,12 +1811,6 @@
     "BriefDescription": "lifetime, sample of PF machine 0 valid",
     "PublicDescription": ""
   },
-  {,
-    "EventCode": "0x428084",
-    "EventName": "PM_L3_PF_HIT_L3",
-    "BriefDescription": "l3 pf hit in l3",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x18080",
     "EventName": "PM_L3_PF_MISS_L3",
@@ -2369,42 +1901,12 @@
     "BriefDescription": "Data stream touchto L3",
     "PublicDescription": ""
   },
-  {,
-    "EventCode": "0xb29084",
-    "EventName": "PM_L3_SYS_GUESS_CORRECT",
-    "BriefDescription": "Initial scope=system and data from outside group (far or rem)(pred successful)",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0xb4908c",
-    "EventName": "PM_L3_SYS_GUESS_WRONG",
-    "BriefDescription": "Initial scope=system but data from local or near. Predction too high",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x24808e",
-    "EventName": "PM_L3_TRANS_PF",
-    "BriefDescription": "L3 Transient prefetch",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x18081",
     "EventName": "PM_L3_WI0_ALLOC",
     "BriefDescription": "lifetime, sample of Write Inject machine 0 valid",
     "PublicDescription": "0.0"
   },
-  {,
-    "EventCode": "0x418080",
-    "EventName": "PM_L3_WI0_BUSY",
-    "BriefDescription": "lifetime, sample of Write Inject machine 0 valid",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x418082",
-    "EventName": "PM_L3_WI_USAGE",
-    "BriefDescription": "rotating sample of 8 WI actives",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0xc080",
     "EventName": "PM_LD_REF_L1_LSU0",
@@ -3311,12 +2813,6 @@
     "BriefDescription": "Dispatch time non favored tbegin",
     "PublicDescription": ""
   },
-  {,
-    "EventCode": "0x328084",
-    "EventName": "PM_NON_TM_RST_SC",
-    "BriefDescription": "non tm snp rst tm sc",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x2001a",
     "EventName": "PM_NTCG_ALL_FIN",
@@ -3419,24 +2915,6 @@
     "BriefDescription": "Continuous 16 cycle(2to1) window where this signals rotates thru sampling each L2 RC machine busy. PMU uses this wave to then do 16 cyc count to sample total number of machs running",
     "PublicDescription": ""
   },
-  {,
-    "EventCode": "0x34808e",
-    "EventName": "PM_RD_CLEARING_SC",
-    "BriefDescription": "rd clearing sc",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x34808c",
-    "EventName": "PM_RD_FORMING_SC",
-    "BriefDescription": "rd forming sc",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x428086",
-    "EventName": "PM_RD_HIT_PF",
-    "BriefDescription": "rd machine hit l3 pf machine",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x20004",
     "EventName": "PM_REAL_SRQ_FULL",
@@ -3503,18 +2981,6 @@
     "BriefDescription": "TLBIE snoop",
     "PublicDescription": "TLBIE snoopSnoop TLBIE"
   },
-  {,
-    "EventCode": "0x338088",
-    "EventName": "PM_SNP_TM_HIT_M",
-    "BriefDescription": "snp tm st hit m mu",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x33808a",
-    "EventName": "PM_SNP_TM_HIT_T",
-    "BriefDescription": "snp tm_st_hit t tn te",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x4608c",
     "EventName": "PM_SN_USAGE",
@@ -3533,12 +2999,6 @@
     "BriefDescription": "STCX executed reported at sent to nest",
     "PublicDescription": "STCX executed reported at sent to nest42"
   },
-  {,
-    "EventCode": "0x717080",
-    "EventName": "PM_ST_CAUSED_FAIL",
-    "BriefDescription": "Non TM St caused any thread to fail",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x3090",
     "EventName": "PM_SWAP_CANCEL",
@@ -3623,18 +3083,6 @@
     "BriefDescription": "Tm any tbegin",
     "PublicDescription": ""
   },
-  {,
-    "EventCode": "0x318082",
-    "EventName": "PM_TM_CAM_OVERFLOW",
-    "BriefDescription": "l3 tm cam overflow during L2 co of SC",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x74708c",
-    "EventName": "PM_TM_CAP_OVERFLOW",
-    "BriefDescription": "TM Footprint Capactiy Overflow",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x20ba",
     "EventName": "PM_TM_END_ALL",
@@ -3689,48 +3137,6 @@
     "BriefDescription": "Transactional conflict from LSU, whatever gets reported to texas",
     "PublicDescription": "Transactional conflict from LSU, whatever gets reported to texas 42"
   },
-  {,
-    "EventCode": "0x727086",
-    "EventName": "PM_TM_FAV_CAUSED_FAIL",
-    "BriefDescription": "TM Load (fav) caused another thread to fail",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x717082",
-    "EventName": "PM_TM_LD_CAUSED_FAIL",
-    "BriefDescription": "Non TM Ld caused any thread to fail",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x727084",
-    "EventName": "PM_TM_LD_CONF",
-    "BriefDescription": "TM Load (fav or non-fav) ran into conflict (failed)",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x328086",
-    "EventName": "PM_TM_RST_SC",
-    "BriefDescription": "tm snp rst tm sc",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x318080",
-    "EventName": "PM_TM_SC_CO",
-    "BriefDescription": "l3 castout tm Sc line",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x73708a",
-    "EventName": "PM_TM_ST_CAUSED_FAIL",
-    "BriefDescription": "TM Store (fav or non-fav) caused another thread to fail",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x737088",
-    "EventName": "PM_TM_ST_CONF",
-    "BriefDescription": "TM Store (fav or non-fav) ran into conflict (failed)",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x20bc",
     "EventName": "PM_TM_TBEGIN",
diff --git a/tools/perf/pmu-events/arch/x86/amdfam17h/branch.json b/tools/perf/pmu-events/arch/x86/amdfam17h/branch.json
new file mode 100644
index 000000000000..93ddfd8053ca
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdfam17h/branch.json
@@ -0,0 +1,12 @@
+[
+  {
+    "EventName": "bp_l1_btb_correct",
+    "EventCode": "0x8a",
+    "BriefDescription": "L1 BTB Correction."
+  },
+  {
+    "EventName": "bp_l2_btb_correct",
+    "EventCode": "0x8b",
+    "BriefDescription": "L2 BTB Correction."
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdfam17h/cache.json b/tools/perf/pmu-events/arch/x86/amdfam17h/cache.json
new file mode 100644
index 000000000000..fad4af9142cb
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdfam17h/cache.json
@@ -0,0 +1,287 @@
+[
+  {
+    "EventName": "ic_fw32",
+    "EventCode": "0x80",
+    "BriefDescription": "The number of 32B fetch windows transferred from IC pipe to DE instruction decoder (includes non-cacheable and cacheable fill responses)."
+  },
+  {
+    "EventName": "ic_fw32_miss",
+    "EventCode": "0x81",
+    "BriefDescription": "The number of 32B fetch windows tried to read the L1 IC and missed in the full tag."
+  },
+  {
+    "EventName": "ic_cache_fill_l2",
+    "EventCode": "0x82",
+    "BriefDescription": "The number of 64 byte instruction cache line was fulfilled from the L2 cache."
+  },
+  {
+    "EventName": "ic_cache_fill_sys",
+    "EventCode": "0x83",
+    "BriefDescription": "The number of 64 byte instruction cache line fulfilled from system memory or another cache."
+  },
+  {
+    "EventName": "bp_l1_tlb_miss_l2_hit",
+    "EventCode": "0x84",
+    "BriefDescription": "The number of instruction fetches that miss in the L1 ITLB but hit in the L2 ITLB."
+  },
+  {
+    "EventName": "bp_l1_tlb_miss_l2_miss",
+    "EventCode": "0x85",
+    "BriefDescription": "The number of instruction fetches that miss in both the L1 and L2 TLBs."
+  },
+  {
+    "EventName": "bp_snp_re_sync",
+    "EventCode": "0x86",
+    "BriefDescription": "The number of pipeline restarts caused by invalidating probes that hit on the instruction stream currently being executed. This would happen if the active instruction stream was being modified by another processor in an MP system - typically a highly unlikely event."
+  },
+  {
+    "EventName": "ic_fetch_stall.ic_stall_any",
+    "EventCode": "0x87",
+    "BriefDescription": "IC pipe was stalled during this clock cycle for any reason (nothing valid in pipe ICM1).",
+    "PublicDescription": "Instruction Pipe Stall. IC pipe was stalled during this clock cycle for any reason (nothing valid in pipe ICM1).",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "ic_fetch_stall.ic_stall_dq_empty",
+    "EventCode": "0x87",
+    "BriefDescription": "IC pipe was stalled during this clock cycle (including IC to OC fetches) due to DQ empty.",
+    "PublicDescription": "Instruction Pipe Stall. IC pipe was stalled during this clock cycle (including IC to OC fetches) due to DQ empty.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ic_fetch_stall.ic_stall_back_pressure",
+    "EventCode": "0x87",
+    "BriefDescription": "IC pipe was stalled during this clock cycle (including IC to OC fetches) due to back-pressure.",
+    "PublicDescription": "Instruction Pipe Stall. IC pipe was stalled during this clock cycle (including IC to OC fetches) due to back-pressure.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ic_cache_inval.l2_invalidating_probe",
+    "EventCode": "0x8c",
+    "BriefDescription": "IC line invalidated due to L2 invalidating probe (external or LS).",
+    "PublicDescription": "The number of instruction cache lines invalidated. A non-SMC event is CMC (cross modifying code), either from the other thread of the core or another core. IC line invalidated due to L2 invalidating probe (external or LS).",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ic_cache_inval.fill_invalidated",
+    "EventCode": "0x8c",
+    "BriefDescription": "IC line invalidated due to overwriting fill response.",
+    "PublicDescription": "The number of instruction cache lines invalidated. A non-SMC event is CMC (cross modifying code), either from the other thread of the core or another core. IC line invalidated due to overwriting fill response.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "bp_tlb_rel",
+    "EventCode": "0x99",
+    "BriefDescription": "The number of ITLB reload requests."
+  },
+  {
+    "EventName": "l2_request_g1.rd_blk_l",
+    "EventCode": "0x60",
+    "BriefDescription": "Requests to L2 Group1.",
+    "PublicDescription": "Requests to L2 Group1.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "l2_request_g1.rd_blk_x",
+    "EventCode": "0x60",
+    "BriefDescription": "Requests to L2 Group1.",
+    "PublicDescription": "Requests to L2 Group1.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "l2_request_g1.ls_rd_blk_c_s",
+    "EventCode": "0x60",
+    "BriefDescription": "Requests to L2 Group1.",
+    "PublicDescription": "Requests to L2 Group1.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "l2_request_g1.cacheable_ic_read",
+    "EventCode": "0x60",
+    "BriefDescription": "Requests to L2 Group1.",
+    "PublicDescription": "Requests to L2 Group1.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "l2_request_g1.change_to_x",
+    "EventCode": "0x60",
+    "BriefDescription": "Requests to L2 Group1.",
+    "PublicDescription": "Requests to L2 Group1.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "l2_request_g1.prefetch_l2",
+    "EventCode": "0x60",
+    "BriefDescription": "Requests to L2 Group1.",
+    "PublicDescription": "Requests to L2 Group1.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "l2_request_g1.l2_hw_pf",
+    "EventCode": "0x60",
+    "BriefDescription": "Requests to L2 Group1.",
+    "PublicDescription": "Requests to L2 Group1.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "l2_request_g1.other_requests",
+    "EventCode": "0x60",
+    "BriefDescription": "Events covered by l2_request_g2.",
+    "PublicDescription": "Requests to L2 Group1. Events covered by l2_request_g2.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "l2_request_g2.group1",
+    "EventCode": "0x61",
+    "BriefDescription": "All Group 1 commands not in unit0.",
+    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous. All Group 1 commands not in unit0.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "l2_request_g2.ls_rd_sized",
+    "EventCode": "0x61",
+    "BriefDescription": "RdSized, RdSized32, RdSized64.",
+    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous. RdSized, RdSized32, RdSized64.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "l2_request_g2.ls_rd_sized_nc",
+    "EventCode": "0x61",
+    "BriefDescription": "RdSizedNC, RdSized32NC, RdSized64NC.",
+    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous. RdSizedNC, RdSized32NC, RdSized64NC.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "l2_request_g2.ic_rd_sized",
+    "EventCode": "0x61",
+    "BriefDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
+    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "l2_request_g2.ic_rd_sized_nc",
+    "EventCode": "0x61",
+    "BriefDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
+    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "l2_request_g2.smc_inval",
+    "EventCode": "0x61",
+    "BriefDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
+    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "l2_request_g2.bus_locks_originator",
+    "EventCode": "0x61",
+    "BriefDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
+    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "l2_request_g2.bus_locks_responses",
+    "EventCode": "0x61",
+    "BriefDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
+    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "l2_latency.l2_cycles_waiting_on_fills",
+    "EventCode": "0x62",
+    "BriefDescription": "Total cycles spent waiting for L2 fills to complete from L3 or memory, divided by four. Event counts are for both threads. To calculate average latency, the number of fills from both threads must be used.",
+    "PublicDescription": "Total cycles spent waiting for L2 fills to complete from L3 or memory, divided by four. Event counts are for both threads. To calculate average latency, the number of fills from both threads must be used.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "l2_wcb_req.wcb_write",
+    "EventCode": "0x63",
+    "PublicDescription": "LS (Load/Store unit) to L2 WCB (Write Combining Buffer) write requests.",
+    "BriefDescription": "LS to L2 WCB write requests.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "l2_wcb_req.wcb_close",
+    "EventCode": "0x63",
+    "BriefDescription": "LS to L2 WCB close requests.",
+    "PublicDescription": "LS (Load/Store unit) to L2 WCB (Write Combining Buffer) close requests.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "l2_wcb_req.zero_byte_store",
+    "EventCode": "0x63",
+    "BriefDescription": "LS to L2 WCB zero byte store requests.",
+    "PublicDescription": "LS (Load/Store unit) to L2 WCB (Write Combining Buffer) zero byte store requests.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "l2_wcb_req.cl_zero",
+    "EventCode": "0x63",
+    "PublicDescription": "LS to L2 WCB cache line zeroing requests.",
+    "BriefDescription": "LS (Load/Store unit) to L2 WCB (Write Combining Buffer) cache line zeroing requests.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ls_rd_blk_cs",
+    "EventCode": "0x64",
+    "BriefDescription": "LS ReadBlock C/S Hit.",
+    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. LS ReadBlock C/S Hit.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ls_rd_blk_l_hit_x",
+    "EventCode": "0x64",
+    "BriefDescription": "LS Read Block L Hit X.",
+    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. LS Read Block L Hit X.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ls_rd_blk_l_hit_s",
+    "EventCode": "0x64",
+    "BriefDescription": "LsRdBlkL Hit Shared.",
+    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. LsRdBlkL Hit Shared.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ls_rd_blk_x",
+    "EventCode": "0x64",
+    "BriefDescription": "LsRdBlkX/ChgToX Hit X.  Count RdBlkX finding Shared as a Miss.",
+    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. LsRdBlkX/ChgToX Hit X.  Count RdBlkX finding Shared as a Miss.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ls_rd_blk_c",
+    "EventCode": "0x64",
+    "BriefDescription": "LS Read Block C S L X Change to X Miss.",
+    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. LS Read Block C S L X Change to X Miss.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_fill_hit_x",
+    "EventCode": "0x64",
+    "BriefDescription": "IC Fill Hit Exclusive Stale.",
+    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. IC Fill Hit Exclusive Stale.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_fill_hit_s",
+    "EventCode": "0x64",
+    "BriefDescription": "IC Fill Hit Shared.",
+    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. IC Fill Hit Shared.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_fill_miss",
+    "EventCode": "0x64",
+    "BriefDescription": "IC Fill Miss.",
+    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. IC Fill Miss.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "l2_fill_pending.l2_fill_busy",
+    "EventCode": "0x6d",
+    "BriefDescription": "Total cycles spent with one or more fill requests in flight from L2.",
+    "PublicDescription": "Total cycles spent with one or more fill requests in flight from L2.",
+    "UMask": "0x1"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdfam17h/core.json b/tools/perf/pmu-events/arch/x86/amdfam17h/core.json
new file mode 100644
index 000000000000..7b285b0a7f35
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdfam17h/core.json
@@ -0,0 +1,134 @@
+[
+  {
+    "EventName": "ex_ret_instr",
+    "EventCode": "0xc0",
+    "BriefDescription": "Retired Instructions."
+  },
+  {
+    "EventName": "ex_ret_cops",
+    "EventCode": "0xc1",
+    "BriefDescription": "Retired Uops.",
+    "PublicDescription": "The number of uOps retired. This includes all processor activity (instructions, exceptions, interrupts, microcode assists, etc.). The number of events logged per cycle can vary from 0 to 4."
+  },
+  {
+    "EventName": "ex_ret_brn",
+    "EventCode": "0xc2",
+    "BriefDescription": "[Retired Branch Instructions.",
+    "PublicDescription": "The number of branch instructions retired. This includes all types of architectural control flow changes, including exceptions and interrupts."
+  },
+  {
+    "EventName": "ex_ret_brn_misp",
+    "EventCode": "0xc3",
+    "BriefDescription": "Retired Branch Instructions Mispredicted.",
+    "PublicDescription": "The number of branch instructions retired, of any type, that were not correctly predicted. This includes those for which prediction is not attempted (far control transfers, exceptions and interrupts)."
+  },
+  {
+    "EventName": "ex_ret_brn_tkn",
+    "EventCode": "0xc4",
+    "BriefDescription": "Retired Taken Branch Instructions.",
+    "PublicDescription": "The number of taken branches that were retired. This includes all types of architectural control flow changes, including exceptions and interrupts."
+  },
+  {
+    "EventName": "ex_ret_brn_tkn_misp",
+    "EventCode": "0xc5",
+    "BriefDescription": "Retired Taken Branch Instructions Mispredicted.",
+    "PublicDescription": "The number of retired taken branch instructions that were mispredicted."
+  },
+  {
+    "EventName": "ex_ret_brn_far",
+    "EventCode": "0xc6",
+    "BriefDescription": "Retired Far Control Transfers.",
+    "PublicDescription": "The number of far control transfers retired including far call/jump/return, IRET, SYSCALL and SYSRET, plus exceptions and interrupts. Far control transfers are not subject to branch prediction."
+  },
+  {
+    "EventName": "ex_ret_brn_resync",
+    "EventCode": "0xc7",
+    "BriefDescription": "Retired Branch Resyncs.",
+    "PublicDescription": "The number of resync branches. These reflect pipeline restarts due to certain microcode assists and events such as writes to the active instruction stream, among other things. Each occurrence reflects a restart penalty similar to a branch mispredict. This is relatively rare."
+  },
+  {
+    "EventName": "ex_ret_near_ret",
+    "EventCode": "0xc8",
+    "BriefDescription": "Retired Near Returns.",
+    "PublicDescription": "The number of near return instructions (RET or RET Iw) retired."
+  },
+  {
+    "EventName": "ex_ret_near_ret_mispred",
+    "EventCode": "0xc9",
+    "BriefDescription": "Retired Near Returns Mispredicted.",
+    "PublicDescription": "The number of near returns retired that were not correctly predicted by the return address predictor. Each such mispredict incurs the same penalty as a mispredicted conditional branch instruction."
+  },
+  {
+    "EventName": "ex_ret_brn_ind_misp",
+    "EventCode": "0xca",
+    "BriefDescription": "Retired Indirect Branch Instructions Mispredicted.",
+    "PublicDescription": "Retired Indirect Branch Instructions Mispredicted."
+  },
+  {
+    "EventName": "ex_ret_mmx_fp_instr.sse_instr",
+    "EventCode": "0xcb",
+    "BriefDescription": "SSE instructions (SSE, SSE2, SSE3, SSSE3, SSE4A, SSE41, SSE42, AVX).",
+    "PublicDescription": "The number of MMX, SSE or x87 instructions retired. The UnitMask allows the selection of the individual classes of instructions as given in the table. Each increment represents one complete instruction. Since this event includes non-numeric instructions it is not suitable for measuring MFLOPS. SSE instructions (SSE, SSE2, SSE3, SSSE3, SSE4A, SSE41, SSE42, AVX).",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "ex_ret_mmx_fp_instr.mmx_instr",
+    "EventCode": "0xcb",
+    "BriefDescription": "MMX instructions.",
+    "PublicDescription": "The number of MMX, SSE or x87 instructions retired. The UnitMask allows the selection of the individual classes of instructions as given in the table. Each increment represents one complete instruction. Since this event includes non-numeric instructions it is not suitable for measuring MFLOPS. MMX instructions.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ex_ret_mmx_fp_instr.x87_instr",
+    "EventCode": "0xcb",
+    "BriefDescription": "x87 instructions.",
+    "PublicDescription": "The number of MMX, SSE or x87 instructions retired. The UnitMask allows the selection of the individual classes of instructions as given in the table. Each increment represents one complete instruction. Since this event includes non-numeric instructions it is not suitable for measuring MFLOPS. x87 instructions.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ex_ret_cond",
+    "EventCode": "0xd1",
+    "BriefDescription": "Retired Conditional Branch Instructions."
+  },
+  {
+    "EventName": "ex_ret_cond_misp",
+    "EventCode": "0xd2",
+    "BriefDescription": "Retired Conditional Branch Instructions Mispredicted."
+  },
+  {
+    "EventName": "ex_div_busy",
+    "EventCode": "0xd3",
+    "BriefDescription": "Div Cycles Busy count."
+  },
+  {
+    "EventName": "ex_div_count",
+    "EventCode": "0xd4",
+    "BriefDescription": "Div Op Count."
+  },
+  {
+    "EventName": "ex_tagged_ibs_ops.ibs_count_rollover",
+    "EventCode": "0x1cf",
+    "BriefDescription": "Number of times an op could not be tagged by IBS because of a previous tagged op that has not retired.",
+    "PublicDescription": "Tagged IBS Ops. Number of times an op could not be tagged by IBS because of a previous tagged op that has not retired.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "ex_tagged_ibs_ops.ibs_tagged_ops_ret",
+    "EventCode": "0x1cf",
+    "BriefDescription": "Number of Ops tagged by IBS that retired.",
+    "PublicDescription": "Tagged IBS Ops. Number of Ops tagged by IBS that retired.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ex_tagged_ibs_ops.ibs_tagged_ops",
+    "EventCode": "0x1cf",
+    "BriefDescription": "Number of Ops tagged by IBS.",
+    "PublicDescription": "Tagged IBS Ops. Number of Ops tagged by IBS.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ex_ret_fus_brnch_inst",
+    "EventCode": "0x1d0",
+    "BriefDescription": "The number of fused retired branch instructions retired per cycle. The number of events logged per cycle can vary from 0 to 3."
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdfam17h/floating-point.json b/tools/perf/pmu-events/arch/x86/amdfam17h/floating-point.json
new file mode 100644
index 000000000000..ea4711983d1d
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdfam17h/floating-point.json
@@ -0,0 +1,168 @@
+[
+  {
+    "EventName": "fpu_pipe_assignment.dual",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number multi-pipe uOps.",
+    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to Pipe 3.",
+    "UMask": "0xf0"
+  },
+  {
+    "EventName": "fpu_pipe_assignment.total",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number uOps.",
+    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number uOps assigned to Pipe 3.",
+    "UMask": "0xf"
+  },
+  {
+    "EventName": "fp_sched_empty",
+    "EventCode": "0x01",
+    "BriefDescription": "This is a speculative event. The number of cycles in which the FPU scheduler is empty. Note that some Ops like FP loads bypass the scheduler."
+  },
+  {
+    "EventName": "fp_retx87_fp_ops.all",
+    "EventCode": "0x02",
+    "BriefDescription": "All Ops.",
+    "PublicDescription": "The number of x87 floating-point Ops that have retired. The number of events logged per cycle can vary from 0 to 8.",
+    "UMask": "0x7"
+  },
+  {
+    "EventName": "fp_retx87_fp_ops.div_sqr_r_ops",
+    "EventCode": "0x02",
+    "BriefDescription": "Divide and square root Ops.",
+    "PublicDescription": "The number of x87 floating-point Ops that have retired. The number of events logged per cycle can vary from 0 to 8. Divide and square root Ops.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "fp_retx87_fp_ops.mul_ops",
+    "EventCode": "0x02",
+    "BriefDescription": "Multiply Ops.",
+    "PublicDescription": "The number of x87 floating-point Ops that have retired. The number of events logged per cycle can vary from 0 to 8. Multiply Ops.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "fp_retx87_fp_ops.add_sub_ops",
+    "EventCode": "0x02",
+    "BriefDescription": "Add/subtract Ops.",
+    "PublicDescription": "The number of x87 floating-point Ops that have retired. The number of events logged per cycle can vary from 0 to 8. Add/subtract Ops.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.all",
+    "EventCode": "0x03",
+    "BriefDescription": "All FLOPS.",
+    "PublicDescription": "This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.dp_mult_add_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Double precision multiply-add FLOPS. Multiply-add counts as 2 FLOPS.",
+    "PublicDescription": "This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15. Double precision multiply-add FLOPS. Multiply-add counts as 2 FLOPS.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.dp_div_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Double precision divide/square root FLOPS.",
+    "PublicDescription": "This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15. Double precision divide/square root FLOPS.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.dp_mult_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Double precision multiply FLOPS.",
+    "PublicDescription": "This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15. Double precision multiply FLOPS.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.dp_add_sub_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Double precision add/subtract FLOPS.",
+    "PublicDescription": "This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15. Double precision add/subtract FLOPS.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.sp_mult_add_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Single precision multiply-add FLOPS. Multiply-add counts as 2 FLOPS.",
+    "PublicDescription": "This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15. Single precision multiply-add FLOPS. Multiply-add counts as 2 FLOPS.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.sp_div_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Single-precision divide/square root FLOPS.",
+    "PublicDescription": "This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15. Single-precision divide/square root FLOPS.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.sp_mult_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Single-precision multiply FLOPS.",
+    "PublicDescription": "This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15. Single-precision multiply FLOPS.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.sp_add_sub_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Single-precision add/subtract FLOPS.",
+    "PublicDescription": "This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15. Single-precision add/subtract FLOPS.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "fp_num_mov_elim_scal_op.optimized",
+    "EventCode": "0x04",
+    "BriefDescription": "Number of Scalar Ops optimized.",
+    "PublicDescription": "This is a dispatch based speculative event, and is useful for measuring the effectiveness of the Move elimination and Scalar code optimization schemes. Number of Scalar Ops optimized.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "fp_num_mov_elim_scal_op.opt_potential",
+    "EventCode": "0x04",
+    "BriefDescription": "Number of Ops that are candidates for optimization (have Z-bit either set or pass).",
+    "PublicDescription": "This is a dispatch based speculative event, and is useful for measuring the effectiveness of the Move elimination and Scalar code optimization schemes. Number of Ops that are candidates for optimization (have Z-bit either set or pass).",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "fp_num_mov_elim_scal_op.sse_mov_ops_elim",
+    "EventCode": "0x04",
+    "BriefDescription": "Number of SSE Move Ops eliminated.",
+    "PublicDescription": "This is a dispatch based speculative event, and is useful for measuring the effectiveness of the Move elimination and Scalar code optimization schemes. Number of SSE Move Ops eliminated.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "fp_num_mov_elim_scal_op.sse_mov_ops",
+    "EventCode": "0x04",
+    "BriefDescription": "Number of SSE Move Ops.",
+    "PublicDescription": "This is a dispatch based speculative event, and is useful for measuring the effectiveness of the Move elimination and Scalar code optimization schemes. Number of SSE Move Ops.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "fp_retired_ser_ops.x87_ctrl_ret",
+    "EventCode": "0x05",
+    "BriefDescription": "x87 control word mispredict traps due to mispredictions in RC or PC, or changes in mask bits.",
+    "PublicDescription": "The number of serializing Ops retired. x87 control word mispredict traps due to mispredictions in RC or PC, or changes in mask bits.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "fp_retired_ser_ops.x87_bot_ret",
+    "EventCode": "0x05",
+    "BriefDescription": "x87 bottom-executing uOps retired.",
+    "PublicDescription": "The number of serializing Ops retired. x87 bottom-executing uOps retired.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "fp_retired_ser_ops.sse_ctrl_ret",
+    "EventCode": "0x05",
+    "BriefDescription": "SSE control word mispredict traps due to mispredictions in RC, FTZ or DAZ, or changes in mask bits.",
+    "PublicDescription": "The number of serializing Ops retired. SSE control word mispredict traps due to mispredictions in RC, FTZ or DAZ, or changes in mask bits.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "fp_retired_ser_ops.sse_bot_ret",
+    "EventCode": "0x05",
+    "BriefDescription": "SSE bottom-executing uOps retired.",
+    "PublicDescription": "The number of serializing Ops retired. SSE bottom-executing uOps retired.",
+    "UMask": "0x1"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdfam17h/memory.json b/tools/perf/pmu-events/arch/x86/amdfam17h/memory.json
new file mode 100644
index 000000000000..fa2d60d4def0
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdfam17h/memory.json
@@ -0,0 +1,162 @@
+[
+  {
+    "EventName": "ls_locks.bus_lock",
+    "EventCode": "0x25",
+    "BriefDescription": "Bus lock when a locked operations crosses a cache boundary or is done on an uncacheable memory type.",
+    "PublicDescription": "Bus lock when a locked operations crosses a cache boundary or is done on an uncacheable memory type.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ls_dispatch.ld_st_dispatch",
+    "EventCode": "0x29",
+    "BriefDescription": "Load-op-Stores.",
+    "PublicDescription": "Counts the number of operations dispatched to the LS unit. Unit Masks ADDed. Load-op-Stores.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "ls_dispatch.store_dispatch",
+    "EventCode": "0x29",
+    "BriefDescription": "Counts the number of operations dispatched to the LS unit. Unit Masks ADDed.",
+    "PublicDescription": "Counts the number of operations dispatched to the LS unit. Unit Masks ADDed.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ls_dispatch.ld_dispatch",
+    "EventCode": "0x29",
+    "BriefDescription": "Counts the number of operations dispatched to the LS unit. Unit Masks ADDed.",
+    "PublicDescription": "Counts the number of operations dispatched to the LS unit. Unit Masks ADDed.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ls_stlf",
+    "EventCode": "0x35",
+    "BriefDescription": "Number of STLF hits."
+  },
+  {
+    "EventName": "ls_dc_accesses",
+    "EventCode": "0x40",
+    "BriefDescription": "The number of accesses to the data cache for load and store references. This may include certain microcode scratchpad accesses, although these are generally rare. Each increment represents an eight-byte access, although the instruction may only be accessing a portion of that. This event is a speculative event."
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.all",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Miss or Reload off all sizes.",
+    "PublicDescription": "L1 DTLB Miss or Reload off all sizes.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_1g_l2_miss",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Miss of a page of 1G size.",
+    "PublicDescription": "L1 DTLB Miss of a page of 1G size.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_2m_l2_miss",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Miss of a page of 2M size.",
+    "PublicDescription": "L1 DTLB Miss of a page of 2M size.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_32k_l2_miss",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Miss of a page of 32K size.",
+    "PublicDescription": "L1 DTLB Miss of a page of 32K size.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_4k_l2_miss",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Miss of a page of 4K size.",
+    "PublicDescription": "L1 DTLB Miss of a page of 4K size.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_1g_l2_hit",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Reload of a page of 1G size.",
+    "PublicDescription": "L1 DTLB Reload of a page of 1G size.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_2m_l2_hit",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Reload of a page of 2M size.",
+    "PublicDescription": "L1 DTLB Reload of a page of 2M size.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_32k_l2_hit",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Reload of a page of 32K size.",
+    "PublicDescription": "L1 DTLB Reload of a page of 32K size.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_4k_l2_hit",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Reload of a page of 4K size.",
+    "PublicDescription": "L1 DTLB Reload of a page of 4K size.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ls_tablewalker.perf_mon_tablewalk_alloc_iside",
+    "EventCode": "0x46",
+    "BriefDescription": "Tablewalker allocation.",
+    "PublicDescription": "Tablewalker allocation.",
+    "UMask": "0xc"
+  },
+  {
+    "EventName": "ls_tablewalker.perf_mon_tablewalk_alloc_dside",
+    "EventCode": "0x46",
+    "BriefDescription": "Tablewalker allocation.",
+    "PublicDescription": "Tablewalker allocation.",
+    "UMask": "0x3"
+  },
+  {
+    "EventName": "ls_misal_accesses",
+    "EventCode": "0x47",
+    "BriefDescription": "Misaligned loads."
+  },
+  {
+    "EventName": "ls_pref_instr_disp.prefetch_nta",
+    "EventCode": "0x4b",
+    "BriefDescription": "Software Prefetch Instructions (PREFETCHNTA instruction) Dispatched.",
+    "PublicDescription": "Software Prefetch Instructions (PREFETCHNTA instruction) Dispatched.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "ls_pref_instr_disp.store_prefetch_w",
+    "EventCode": "0x4b",
+    "BriefDescription": "Software Prefetch Instructions (3DNow PREFETCHW instruction) Dispatched.",
+    "PublicDescription": "Software Prefetch Instructions (3DNow PREFETCHW instruction) Dispatched.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ls_pref_instr_disp.load_prefetch_w",
+    "EventCode": "0x4b",
+    "BriefDescription": "Prefetch, Prefetch_T0_T1_T2.",
+    "PublicDescription": "Software Prefetch Instructions Dispatched. Prefetch, Prefetch_T0_T1_T2.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ls_inef_sw_pref.mab_mch_cnt",
+    "EventCode": "0x52",
+    "BriefDescription": "The number of software prefetches that did not fetch data outside of the processor core.",
+    "PublicDescription": "The number of software prefetches that did not fetch data outside of the processor core.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ls_inef_sw_pref.data_pipe_sw_pf_dc_hit",
+    "EventCode": "0x52",
+    "BriefDescription": "The number of software prefetches that did not fetch data outside of the processor core.",
+    "PublicDescription": "The number of software prefetches that did not fetch data outside of the processor core.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ls_not_halted_cyc",
+    "EventCode": "0x76",
+    "BriefDescription": "Cycles not in Halt."
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdfam17h/other.json b/tools/perf/pmu-events/arch/x86/amdfam17h/other.json
new file mode 100644
index 000000000000..b26a00d05a2e
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdfam17h/other.json
@@ -0,0 +1,65 @@
+[
+  {
+    "EventName": "ic_oc_mode_switch.oc_ic_mode_switch",
+    "EventCode": "0x28a",
+    "BriefDescription": "OC to IC mode switch.",
+    "PublicDescription": "OC Mode Switch. OC to IC mode switch.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ic_oc_mode_switch.ic_oc_mode_switch",
+    "EventCode": "0x28a",
+    "BriefDescription": "IC to OC mode switch.",
+    "PublicDescription": "OC Mode Switch. IC to OC mode switch.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls0.retire_token_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "RETIRE Tokens unavailable.",
+    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. RETIRE Tokens unavailable.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls0.agsq_token_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "AGSQ Tokens unavailable.",
+    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. AGSQ Tokens unavailable.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls0.alu_token_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "ALU tokens total unavailable.",
+    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALU tokens total unavailable.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls0.alsq3_0_token_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall.",
+    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls0.alsq3_token_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "ALSQ 3 Tokens unavailable.",
+    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALSQ 3 Tokens unavailable.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls0.alsq2_token_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "ALSQ 2 Tokens unavailable.",
+    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALSQ 2 Tokens unavailable.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls0.alsq1_token_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "ALSQ 1 Tokens unavailable.",
+    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALSQ 1 Tokens unavailable.",
+    "UMask": "0x1"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index e05c2c8458fc..d6984a3017e0 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -33,3 +33,4 @@ GenuineIntel-6-25,v2,westmereep-sp,core
 GenuineIntel-6-2F,v2,westmereex,core
 GenuineIntel-6-55-[01234],v1,skylakex,core
 GenuineIntel-6-55-[56789ABCDEF],v1,cascadelakex,core
+AuthenticAMD-23-[[:xdigit:]]+,v1,amdfam17h,core
diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
index 390a351d15ea..c3eae1d77d36 100644
--- a/tools/perf/scripts/python/export-to-postgresql.py
+++ b/tools/perf/scripts/python/export-to-postgresql.py
@@ -10,6 +10,8 @@
 # FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
 # more details.
 
+from __future__ import print_function
+
 import os
 import sys
 import struct
@@ -199,6 +201,18 @@ import datetime
 
 from PySide.QtSql import *
 
+if sys.version_info < (3, 0):
+	def toserverstr(str):
+		return str
+	def toclientstr(str):
+		return str
+else:
+	# Assume UTF-8 server_encoding and client_encoding
+	def toserverstr(str):
+		return bytes(str, "UTF_8")
+	def toclientstr(str):
+		return bytes(str, "UTF_8")
+
 # Need to access PostgreSQL C library directly to use COPY FROM STDIN
 from ctypes import *
 libpq = CDLL("libpq.so.5")
@@ -234,12 +248,17 @@ perf_db_export_mode = True
 perf_db_export_calls = False
 perf_db_export_callchains = False
 
+def printerr(*args, **kw_args):
+	print(*args, file=sys.stderr, **kw_args)
+
+def printdate(*args, **kw_args):
+        print(datetime.datetime.today(), *args, sep=' ', **kw_args)
 
 def usage():
-	print >> sys.stderr, "Usage is: export-to-postgresql.py <database name> [<columns>] [<calls>] [<callchains>]"
-	print >> sys.stderr, "where:	columns		'all' or 'branches'"
-	print >> sys.stderr, "		calls		'calls' => create calls and call_paths table"
-	print >> sys.stderr, "		callchains	'callchains' => create call_paths table"
+	printerr("Usage is: export-to-postgresql.py <database name> [<columns>] [<calls>] [<callchains>]")
+	printerr("where:	columns		'all' or 'branches'")
+	printerr("		calls		'calls' => create calls and call_paths table")
+	printerr("		callchains	'callchains' => create call_paths table")
 	raise Exception("Too few arguments")
 
 if (len(sys.argv) < 2):
@@ -273,7 +292,7 @@ def do_query(q, s):
 		return
 	raise Exception("Query failed: " + q.lastError().text())
 
-print datetime.datetime.today(), "Creating database..."
+printdate("Creating database...")
 
 db = QSqlDatabase.addDatabase('QPSQL')
 query = QSqlQuery(db)
@@ -506,12 +525,12 @@ do_query(query, 'CREATE VIEW samples_view AS '
 	' FROM samples')
 
 
-file_header = struct.pack("!11sii", "PGCOPY\n\377\r\n\0", 0, 0)
-file_trailer = "\377\377"
+file_header = struct.pack("!11sii", b"PGCOPY\n\377\r\n\0", 0, 0)
+file_trailer = b"\377\377"
 
 def open_output_file(file_name):
 	path_name = output_dir_name + "/" + file_name
-	file = open(path_name, "w+")
+	file = open(path_name, "wb+")
 	file.write(file_header)
 	return file
 
@@ -526,13 +545,13 @@ def copy_output_file_direct(file, table_name):
 
 # Use COPY FROM STDIN because security may prevent postgres from accessing the files directly
 def copy_output_file(file, table_name):
-	conn = PQconnectdb("dbname = " + dbname)
+	conn = PQconnectdb(toclientstr("dbname = " + dbname))
 	if (PQstatus(conn)):
 		raise Exception("COPY FROM STDIN PQconnectdb failed")
 	file.write(file_trailer)
 	file.seek(0)
 	sql = "COPY " + table_name + " FROM STDIN (FORMAT 'binary')"
-	res = PQexec(conn, sql)
+	res = PQexec(conn, toclientstr(sql))
 	if (PQresultStatus(res) != 4):
 		raise Exception("COPY FROM STDIN PQexec failed")
 	data = file.read(65536)
@@ -566,7 +585,7 @@ if perf_db_export_calls:
 	call_file		= open_output_file("call_table.bin")
 
 def trace_begin():
-	print datetime.datetime.today(), "Writing to intermediate files..."
+	printdate("Writing to intermediate files...")
 	# id == 0 means unknown.  It is easier to create records for them than replace the zeroes with NULLs
 	evsel_table(0, "unknown")
 	machine_table(0, 0, "unknown")
@@ -582,7 +601,7 @@ def trace_begin():
 unhandled_count = 0
 
 def trace_end():
-	print datetime.datetime.today(), "Copying to database..."
+	printdate("Copying to database...")
 	copy_output_file(evsel_file,		"selected_events")
 	copy_output_file(machine_file,		"machines")
 	copy_output_file(thread_file,		"threads")
@@ -597,7 +616,7 @@ def trace_end():
 	if perf_db_export_calls:
 		copy_output_file(call_file,		"calls")
 
-	print datetime.datetime.today(), "Removing intermediate files..."
+	printdate("Removing intermediate files...")
 	remove_output_file(evsel_file)
 	remove_output_file(machine_file)
 	remove_output_file(thread_file)
@@ -612,7 +631,7 @@ def trace_end():
 	if perf_db_export_calls:
 		remove_output_file(call_file)
 	os.rmdir(output_dir_name)
-	print datetime.datetime.today(), "Adding primary keys"
+	printdate("Adding primary keys")
 	do_query(query, 'ALTER TABLE selected_events ADD PRIMARY KEY (id)')
 	do_query(query, 'ALTER TABLE machines        ADD PRIMARY KEY (id)')
 	do_query(query, 'ALTER TABLE threads         ADD PRIMARY KEY (id)')
@@ -627,7 +646,7 @@ def trace_end():
 	if perf_db_export_calls:
 		do_query(query, 'ALTER TABLE calls           ADD PRIMARY KEY (id)')
 
-	print datetime.datetime.today(), "Adding foreign keys"
+	printdate("Adding foreign keys")
 	do_query(query, 'ALTER TABLE threads '
 					'ADD CONSTRAINT machinefk  FOREIGN KEY (machine_id)   REFERENCES machines   (id),'
 					'ADD CONSTRAINT processfk  FOREIGN KEY (process_id)   REFERENCES threads    (id)')
@@ -663,8 +682,8 @@ def trace_end():
 		do_query(query, 'CREATE INDEX pid_idx ON calls (parent_id)')
 
 	if (unhandled_count):
-		print datetime.datetime.today(), "Warning: ", unhandled_count, " unhandled events"
-	print datetime.datetime.today(), "Done"
+		printdate("Warning: ", unhandled_count, " unhandled events")
+	printdate("Done")
 
 def trace_unhandled(event_name, context, event_fields_dict):
 	global unhandled_count
@@ -674,12 +693,14 @@ def sched__sched_switch(*x):
 	pass
 
 def evsel_table(evsel_id, evsel_name, *x):
+	evsel_name = toserverstr(evsel_name)
 	n = len(evsel_name)
 	fmt = "!hiqi" + str(n) + "s"
 	value = struct.pack(fmt, 2, 8, evsel_id, n, evsel_name)
 	evsel_file.write(value)
 
 def machine_table(machine_id, pid, root_dir, *x):
+	root_dir = toserverstr(root_dir)
 	n = len(root_dir)
 	fmt = "!hiqiii" + str(n) + "s"
 	value = struct.pack(fmt, 3, 8, machine_id, 4, pid, n, root_dir)
@@ -690,6 +711,7 @@ def thread_table(thread_id, machine_id, process_id, pid, tid, *x):
 	thread_file.write(value)
 
 def comm_table(comm_id, comm_str, *x):
+	comm_str = toserverstr(comm_str)
 	n = len(comm_str)
 	fmt = "!hiqi" + str(n) + "s"
 	value = struct.pack(fmt, 2, 8, comm_id, n, comm_str)
@@ -701,6 +723,9 @@ def comm_thread_table(comm_thread_id, comm_id, thread_id, *x):
 	comm_thread_file.write(value)
 
 def dso_table(dso_id, machine_id, short_name, long_name, build_id, *x):
+	short_name = toserverstr(short_name)
+	long_name = toserverstr(long_name)
+	build_id = toserverstr(build_id)
 	n1 = len(short_name)
 	n2 = len(long_name)
 	n3 = len(build_id)
@@ -709,12 +734,14 @@ def dso_table(dso_id, machine_id, short_name, long_name, build_id, *x):
 	dso_file.write(value)
 
 def symbol_table(symbol_id, dso_id, sym_start, sym_end, binding, symbol_name, *x):
+	symbol_name = toserverstr(symbol_name)
 	n = len(symbol_name)
 	fmt = "!hiqiqiqiqiii" + str(n) + "s"
 	value = struct.pack(fmt, 6, 8, symbol_id, 8, dso_id, 8, sym_start, 8, sym_end, 4, binding, n, symbol_name)
 	symbol_file.write(value)
 
 def branch_type_table(branch_type, name, *x):
+	name = toserverstr(name)
 	n = len(name)
 	fmt = "!hiii" + str(n) + "s"
 	value = struct.pack(fmt, 2, 4, branch_type, n, name)
diff --git a/tools/perf/scripts/python/export-to-sqlite.py b/tools/perf/scripts/python/export-to-sqlite.py
index eb63e6c7107f..3b71902a5a21 100644
--- a/tools/perf/scripts/python/export-to-sqlite.py
+++ b/tools/perf/scripts/python/export-to-sqlite.py
@@ -10,6 +10,8 @@
 # FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
 # more details.
 
+from __future__ import print_function
+
 import os
 import sys
 import struct
@@ -60,11 +62,17 @@ perf_db_export_mode = True
 perf_db_export_calls = False
 perf_db_export_callchains = False
 
+def printerr(*args, **keyword_args):
+	print(*args, file=sys.stderr, **keyword_args)
+
+def printdate(*args, **kw_args):
+        print(datetime.datetime.today(), *args, sep=' ', **kw_args)
+
 def usage():
-	print >> sys.stderr, "Usage is: export-to-sqlite.py <database name> [<columns>] [<calls>] [<callchains>]"
-	print >> sys.stderr, "where:	columns		'all' or 'branches'"
-	print >> sys.stderr, "		calls		'calls' => create calls and call_paths table"
-	print >> sys.stderr, "		callchains	'callchains' => create call_paths table"
+	printerr("Usage is: export-to-sqlite.py <database name> [<columns>] [<calls>] [<callchains>]");
+	printerr("where:	columns		'all' or 'branches'");
+	printerr("		calls		'calls' => create calls and call_paths table");
+	printerr("		callchains	'callchains' => create call_paths table");
 	raise Exception("Too few arguments")
 
 if (len(sys.argv) < 2):
@@ -100,7 +108,7 @@ def do_query_(q):
 		return
 	raise Exception("Query failed: " + q.lastError().text())
 
-print datetime.datetime.today(), "Creating database..."
+printdate("Creating database ...")
 
 db_exists = False
 try:
@@ -378,7 +386,7 @@ if perf_db_export_calls:
 	call_query.prepare("INSERT INTO calls VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")
 
 def trace_begin():
-	print datetime.datetime.today(), "Writing records..."
+	printdate("Writing records...")
 	do_query(query, 'BEGIN TRANSACTION')
 	# id == 0 means unknown.  It is easier to create records for them than replace the zeroes with NULLs
 	evsel_table(0, "unknown")
@@ -397,14 +405,14 @@ unhandled_count = 0
 def trace_end():
 	do_query(query, 'END TRANSACTION')
 
-	print datetime.datetime.today(), "Adding indexes"
+	printdate("Adding indexes")
 	if perf_db_export_calls:
 		do_query(query, 'CREATE INDEX pcpid_idx ON calls (parent_call_path_id)')
 		do_query(query, 'CREATE INDEX pid_idx ON calls (parent_id)')
 
 	if (unhandled_count):
-		print datetime.datetime.today(), "Warning: ", unhandled_count, " unhandled events"
-	print datetime.datetime.today(), "Done"
+		printdate("Warning: ", unhandled_count, " unhandled events")
+	printdate("Done")
 
 def trace_unhandled(event_name, context, event_fields_dict):
 	global unhandled_count
diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index afec9479ca7f..e38518cdcbc3 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -88,11 +88,20 @@
 #                                                                              7fab593ea956 48 89 15 3b 13 22 00                            movq  %rdx, 0x22133b(%rip)
 # 8107675243232  2    ls       22011  22011  hardware interrupt     No         7fab593ea956 _dl_start+0x26 (ld-2.19.so) -> ffffffff86a012e0 page_fault ([kernel])
 
+from __future__ import print_function
+
 import sys
 import weakref
 import threading
 import string
-import cPickle
+try:
+	# Python2
+	import cPickle as pickle
+	# size of pickled integer big enough for record size
+	glb_nsz = 8
+except ImportError:
+	import pickle
+	glb_nsz = 16
 import re
 import os
 from PySide.QtCore import *
@@ -102,6 +111,15 @@ from decimal import *
 from ctypes import *
 from multiprocessing import Process, Array, Value, Event
 
+# xrange is range in Python3
+try:
+	xrange
+except NameError:
+	xrange = range
+
+def printerr(*args, **keyword_args):
+	print(*args, file=sys.stderr, **keyword_args)
+
 # Data formatting helpers
 
 def tohex(ip):
@@ -1004,10 +1022,6 @@ class ChildDataItemFinder():
 
 glb_chunk_sz = 10000
 
-# size of pickled integer big enough for record size
-
-glb_nsz = 8
-
 # Background process for SQL data fetcher
 
 class SQLFetcherProcess():
@@ -1066,7 +1080,7 @@ class SQLFetcherProcess():
 				return True
 			if space >= glb_nsz:
 				# Use 0 (or space < glb_nsz) to mean there is no more at the top of the buffer
-				nd = cPickle.dumps(0, cPickle.HIGHEST_PROTOCOL)
+				nd = pickle.dumps(0, pickle.HIGHEST_PROTOCOL)
 				self.buffer[self.local_head : self.local_head + len(nd)] = nd
 			self.local_head = 0
 		if self.local_tail - self.local_head > sz:
@@ -1084,9 +1098,9 @@ class SQLFetcherProcess():
 			self.wait_event.wait()
 
 	def AddToBuffer(self, obj):
-		d = cPickle.dumps(obj, cPickle.HIGHEST_PROTOCOL)
+		d = pickle.dumps(obj, pickle.HIGHEST_PROTOCOL)
 		n = len(d)
-		nd = cPickle.dumps(n, cPickle.HIGHEST_PROTOCOL)
+		nd = pickle.dumps(n, pickle.HIGHEST_PROTOCOL)
 		sz = n + glb_nsz
 		self.WaitForSpace(sz)
 		pos = self.local_head
@@ -1198,12 +1212,12 @@ class SQLFetcher(QObject):
 		pos = self.local_tail
 		if len(self.buffer) - pos < glb_nsz:
 			pos = 0
-		n = cPickle.loads(self.buffer[pos : pos + glb_nsz])
+		n = pickle.loads(self.buffer[pos : pos + glb_nsz])
 		if n == 0:
 			pos = 0
-			n = cPickle.loads(self.buffer[0 : glb_nsz])
+			n = pickle.loads(self.buffer[0 : glb_nsz])
 		pos += glb_nsz
-		obj = cPickle.loads(self.buffer[pos : pos + n])
+		obj = pickle.loads(self.buffer[pos : pos + n])
 		self.local_tail = pos + n
 		return obj
 
@@ -2973,7 +2987,7 @@ class DBRef():
 
 def Main():
 	if (len(sys.argv) < 2):
-		print >> sys.stderr, "Usage is: exported-sql-viewer.py {<database name> | --help-only}"
+		printerr("Usage is: exported-sql-viewer.py {<database name> | --help-only}");
 		raise Exception("Too few arguments")
 
 	dbname = sys.argv[1]
@@ -2986,8 +3000,8 @@ def Main():
 
 	is_sqlite3 = False
 	try:
-		f = open(dbname)
-		if f.read(15) == "SQLite format 3":
+		f = open(dbname, "rb")
+		if f.read(15) == b'SQLite format 3':
 			is_sqlite3 = True
 		f.close()
 	except:
diff --git a/tools/perf/tests/attr/test-record-C0 b/tools/perf/tests/attr/test-record-C0
index cb0a3138fa54..93818054ae20 100644
--- a/tools/perf/tests/attr/test-record-C0
+++ b/tools/perf/tests/attr/test-record-C0
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = -C 0 kill >/dev/null 2>&1
+args    = --no-bpf-event -C 0 kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
diff --git a/tools/perf/tests/attr/test-record-basic b/tools/perf/tests/attr/test-record-basic
index 85a23cf35ba1..b0ca42a5ecc9 100644
--- a/tools/perf/tests/attr/test-record-basic
+++ b/tools/perf/tests/attr/test-record-basic
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = kill >/dev/null 2>&1
+args    = --no-bpf-event kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
diff --git a/tools/perf/tests/attr/test-record-branch-any b/tools/perf/tests/attr/test-record-branch-any
index 81f839e2fad0..1a99b3ce6b89 100644
--- a/tools/perf/tests/attr/test-record-branch-any
+++ b/tools/perf/tests/attr/test-record-branch-any
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = -b kill >/dev/null 2>&1
+args    = --no-bpf-event -b kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
diff --git a/tools/perf/tests/attr/test-record-branch-filter-any b/tools/perf/tests/attr/test-record-branch-filter-any
index 357421f4dfce..709768b508c6 100644
--- a/tools/perf/tests/attr/test-record-branch-filter-any
+++ b/tools/perf/tests/attr/test-record-branch-filter-any
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = -j any kill >/dev/null 2>&1
+args    = --no-bpf-event -j any kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
diff --git a/tools/perf/tests/attr/test-record-branch-filter-any_call b/tools/perf/tests/attr/test-record-branch-filter-any_call
index dbc55f2ab845..f943221f7825 100644
--- a/tools/perf/tests/attr/test-record-branch-filter-any_call
+++ b/tools/perf/tests/attr/test-record-branch-filter-any_call
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = -j any_call kill >/dev/null 2>&1
+args    = --no-bpf-event -j any_call kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
diff --git a/tools/perf/tests/attr/test-record-branch-filter-any_ret b/tools/perf/tests/attr/test-record-branch-filter-any_ret
index a0824ff8e131..fd4f5b4154a9 100644
--- a/tools/perf/tests/attr/test-record-branch-filter-any_ret
+++ b/tools/perf/tests/attr/test-record-branch-filter-any_ret
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = -j any_ret kill >/dev/null 2>&1
+args    = --no-bpf-event -j any_ret kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
diff --git a/tools/perf/tests/attr/test-record-branch-filter-hv b/tools/perf/tests/attr/test-record-branch-filter-hv
index f34d6f120181..4e52d685ebe1 100644
--- a/tools/perf/tests/attr/test-record-branch-filter-hv
+++ b/tools/perf/tests/attr/test-record-branch-filter-hv
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = -j hv kill >/dev/null 2>&1
+args    = --no-bpf-event -j hv kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
diff --git a/tools/perf/tests/attr/test-record-branch-filter-ind_call b/tools/perf/tests/attr/test-record-branch-filter-ind_call
index b86a35232248..e08c6ab3796e 100644
--- a/tools/perf/tests/attr/test-record-branch-filter-ind_call
+++ b/tools/perf/tests/attr/test-record-branch-filter-ind_call
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = -j ind_call kill >/dev/null 2>&1
+args    = --no-bpf-event -j ind_call kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
diff --git a/tools/perf/tests/attr/test-record-branch-filter-k b/tools/perf/tests/attr/test-record-branch-filter-k
index d3fbc5e1858a..b4b98f84fc2f 100644
--- a/tools/perf/tests/attr/test-record-branch-filter-k
+++ b/tools/perf/tests/attr/test-record-branch-filter-k
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = -j k kill >/dev/null 2>&1
+args    = --no-bpf-event -j k kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
diff --git a/tools/perf/tests/attr/test-record-branch-filter-u b/tools/perf/tests/attr/test-record-branch-filter-u
index a318f0dda173..fb9610edbb0d 100644
--- a/tools/perf/tests/attr/test-record-branch-filter-u
+++ b/tools/perf/tests/attr/test-record-branch-filter-u
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = -j u kill >/dev/null 2>&1
+args    = --no-bpf-event -j u kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
diff --git a/tools/perf/tests/attr/test-record-count b/tools/perf/tests/attr/test-record-count
index 34f6cc577263..5e9b9019d786 100644
--- a/tools/perf/tests/attr/test-record-count
+++ b/tools/perf/tests/attr/test-record-count
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = -c 123 kill >/dev/null 2>&1
+args    = --no-bpf-event -c 123 kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
diff --git a/tools/perf/tests/attr/test-record-data b/tools/perf/tests/attr/test-record-data
index a9cf2233b0ce..a99bb13149c2 100644
--- a/tools/perf/tests/attr/test-record-data
+++ b/tools/perf/tests/attr/test-record-data
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = -d kill >/dev/null 2>&1
+args    = --no-bpf-event -d kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
diff --git a/tools/perf/tests/attr/test-record-freq b/tools/perf/tests/attr/test-record-freq
index bf4cb459f0d5..89e29f6b2ae0 100644
--- a/tools/perf/tests/attr/test-record-freq
+++ b/tools/perf/tests/attr/test-record-freq
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = -F 100 kill >/dev/null 2>&1
+args    = --no-bpf-event -F 100 kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
diff --git a/tools/perf/tests/attr/test-record-graph-default b/tools/perf/tests/attr/test-record-graph-default
index 0b216e69760c..5d8234d50845 100644
--- a/tools/perf/tests/attr/test-record-graph-default
+++ b/tools/perf/tests/attr/test-record-graph-default
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = -g kill >/dev/null 2>&1
+args    = --no-bpf-event -g kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
diff --git a/tools/perf/tests/attr/test-record-graph-dwarf b/tools/perf/tests/attr/test-record-graph-dwarf
index da2fa73bd0a2..ae92061d611d 100644
--- a/tools/perf/tests/attr/test-record-graph-dwarf
+++ b/tools/perf/tests/attr/test-record-graph-dwarf
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = --call-graph dwarf -- kill >/dev/null 2>&1
+args    = --no-bpf-event --call-graph dwarf -- kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
diff --git a/tools/perf/tests/attr/test-record-graph-fp b/tools/perf/tests/attr/test-record-graph-fp
index 625d190bb798..5630521c0b0f 100644
--- a/tools/perf/tests/attr/test-record-graph-fp
+++ b/tools/perf/tests/attr/test-record-graph-fp
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = --call-graph fp kill >/dev/null 2>&1
+args    = --no-bpf-event --call-graph fp kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
diff --git a/tools/perf/tests/attr/test-record-group b/tools/perf/tests/attr/test-record-group
index 618ba1c17474..14ee60fd3f41 100644
--- a/tools/perf/tests/attr/test-record-group
+++ b/tools/perf/tests/attr/test-record-group
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = --group -e cycles,instructions kill >/dev/null 2>&1
+args    = --no-bpf-event --group -e cycles,instructions kill >/dev/null 2>&1
 ret     = 1
 
 [event-1:base-record]
diff --git a/tools/perf/tests/attr/test-record-group-sampling b/tools/perf/tests/attr/test-record-group-sampling
index f0729c454f16..300b9f7e6d69 100644
--- a/tools/perf/tests/attr/test-record-group-sampling
+++ b/tools/perf/tests/attr/test-record-group-sampling
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = -e '{cycles,cache-misses}:S' kill >/dev/null 2>&1
+args    = --no-bpf-event -e '{cycles,cache-misses}:S' kill >/dev/null 2>&1
 ret     = 1
 
 [event-1:base-record]
diff --git a/tools/perf/tests/attr/test-record-group1 b/tools/perf/tests/attr/test-record-group1
index 48e8bd12fe46..3ffe246e0228 100644
--- a/tools/perf/tests/attr/test-record-group1
+++ b/tools/perf/tests/attr/test-record-group1
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = -e '{cycles,instructions}' kill >/dev/null 2>&1
+args    = --no-bpf-event -e '{cycles,instructions}' kill >/dev/null 2>&1
 ret     = 1
 
 [event-1:base-record]
diff --git a/tools/perf/tests/attr/test-record-no-buffering b/tools/perf/tests/attr/test-record-no-buffering
index aa3956d8fe20..583dcbb078ba 100644
--- a/tools/perf/tests/attr/test-record-no-buffering
+++ b/tools/perf/tests/attr/test-record-no-buffering
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = --no-buffering kill >/dev/null 2>&1
+args    = --no-bpf-event --no-buffering kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
diff --git a/tools/perf/tests/attr/test-record-no-inherit b/tools/perf/tests/attr/test-record-no-inherit
index 560943decb87..15d1dc162e1c 100644
--- a/tools/perf/tests/attr/test-record-no-inherit
+++ b/tools/perf/tests/attr/test-record-no-inherit
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = -i kill >/dev/null 2>&1
+args    = --no-bpf-event -i kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
diff --git a/tools/perf/tests/attr/test-record-no-samples b/tools/perf/tests/attr/test-record-no-samples
index 8eb73ab639e0..596fbd6d5a2c 100644
--- a/tools/perf/tests/attr/test-record-no-samples
+++ b/tools/perf/tests/attr/test-record-no-samples
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = -n kill >/dev/null 2>&1
+args    = --no-bpf-event -n kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
diff --git a/tools/perf/tests/attr/test-record-period b/tools/perf/tests/attr/test-record-period
index 69bc748f0f27..119101154c5e 100644
--- a/tools/perf/tests/attr/test-record-period
+++ b/tools/perf/tests/attr/test-record-period
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = -c 100 -P kill >/dev/null 2>&1
+args    = --no-bpf-event -c 100 -P kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
diff --git a/tools/perf/tests/attr/test-record-raw b/tools/perf/tests/attr/test-record-raw
index a188a614a44c..13a5f7860c78 100644
--- a/tools/perf/tests/attr/test-record-raw
+++ b/tools/perf/tests/attr/test-record-raw
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = -R kill >/dev/null 2>&1
+args    = --no-bpf-event -R kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
index 6d598cc071ae..1a9c3becf5ff 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -18,7 +18,7 @@ static void testcase(void)
 	int i;
 
 	for (i = 0; i < NR_ITERS; i++) {
-		char proc_name[10];
+		char proc_name[15];
 
 		snprintf(proc_name, sizeof(proc_name), "p:%d\n", i);
 		prctl(PR_SET_NAME, proc_name);
diff --git a/tools/perf/tests/evsel-tp-sched.c b/tools/perf/tests/evsel-tp-sched.c
index ea7acf403727..71f60c0f9faa 100644
--- a/tools/perf/tests/evsel-tp-sched.c
+++ b/tools/perf/tests/evsel-tp-sched.c
@@ -85,5 +85,6 @@ int test__perf_evsel__tp_sched_test(struct test *test __maybe_unused, int subtes
 	if (perf_evsel__test_field(evsel, "target_cpu", 4, true))
 		ret = -1;
 
+	perf_evsel__delete(evsel);
 	return ret;
 }
diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 01f0706995a9..9acc1e80b936 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -19,7 +19,7 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 	const char *p;
 	const char **other;
 	double val;
-	int ret;
+	int i, ret;
 	struct parse_ctx ctx;
 	int num_other;
 
@@ -56,6 +56,9 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 	TEST_ASSERT_VAL("find other", !strcmp(other[1], "BAZ"));
 	TEST_ASSERT_VAL("find other", !strcmp(other[2], "BOZO"));
 	TEST_ASSERT_VAL("find other", other[3] == NULL);
+
+	for (i = 0; i < num_other; i++)
+		free((void *)other[i]);
 	free((void *)other);
 
 	return 0;
diff --git a/tools/perf/tests/openat-syscall-all-cpus.c b/tools/perf/tests/openat-syscall-all-cpus.c
index c531e6deb104..493ecb611540 100644
--- a/tools/perf/tests/openat-syscall-all-cpus.c
+++ b/tools/perf/tests/openat-syscall-all-cpus.c
@@ -45,7 +45,7 @@ int test__openat_syscall_event_on_all_cpus(struct test *test __maybe_unused, int
 	if (IS_ERR(evsel)) {
 		tracing_path__strerror_open_tp(errno, errbuf, sizeof(errbuf), "syscalls", "sys_enter_openat");
 		pr_debug("%s\n", errbuf);
-		goto out_thread_map_delete;
+		goto out_cpu_map_delete;
 	}
 
 	if (perf_evsel__open(evsel, cpus, threads) < 0) {
@@ -119,6 +119,8 @@ int test__openat_syscall_event_on_all_cpus(struct test *test __maybe_unused, int
 	perf_evsel__close_fd(evsel);
 out_evsel_delete:
 	perf_evsel__delete(evsel);
+out_cpu_map_delete:
+	cpu_map__put(cpus);
 out_thread_map_delete:
 	thread_map__put(threads);
 	return err;
diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
index 4f75561424ed..4ad37d8c7d6a 100644
--- a/tools/perf/ui/browser.c
+++ b/tools/perf/ui/browser.c
@@ -611,14 +611,16 @@ void ui_browser__argv_seek(struct ui_browser *browser, off_t offset, int whence)
 		browser->top = browser->entries;
 		break;
 	case SEEK_CUR:
-		browser->top = browser->top + browser->top_idx + offset;
+		browser->top = (char **)browser->top + offset;
 		break;
 	case SEEK_END:
-		browser->top = browser->top + browser->nr_entries - 1 + offset;
+		browser->top = (char **)browser->entries + browser->nr_entries - 1 + offset;
 		break;
 	default:
 		return;
 	}
+	assert((char **)browser->top < (char **)browser->entries + browser->nr_entries);
+	assert((char **)browser->top >= (char **)browser->entries);
 }
 
 unsigned int ui_browser__argv_refresh(struct ui_browser *browser)
@@ -630,7 +632,9 @@ unsigned int ui_browser__argv_refresh(struct ui_browser *browser)
 		browser->top = browser->entries;
 
 	pos = (char **)browser->top;
-	while (idx < browser->nr_entries) {
+	while (idx < browser->nr_entries &&
+	       row < (unsigned)SLtt_Screen_Rows - 1) {
+		assert(pos < (char **)browser->entries + browser->nr_entries);
 		if (!browser->filter || !browser->filter(browser, *pos)) {
 			ui_browser__gotorc(browser, row, 0);
 			browser->write(browser, pos, row);
diff --git a/tools/perf/ui/browsers/Build b/tools/perf/ui/browsers/Build
index 8fee56b46502..fdf86f7981ca 100644
--- a/tools/perf/ui/browsers/Build
+++ b/tools/perf/ui/browsers/Build
@@ -3,6 +3,7 @@ perf-y += hists.o
 perf-y += map.o
 perf-y += scripts.o
 perf-y += header.o
+perf-y += res_sample.o
 
 CFLAGS_annotate.o += -DENABLE_SLFUTURE_CONST
 CFLAGS_hists.o    += -DENABLE_SLFUTURE_CONST
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 35bdfd8b1e71..98d934a36d86 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -750,7 +750,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 			continue;
 		case 'r':
 			{
-				script_browse(NULL);
+				script_browse(NULL, NULL);
 				continue;
 			}
 		case 'k':
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index aef800d97ea1..3421ecbdd3f0 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -7,6 +7,7 @@
 #include <string.h>
 #include <linux/rbtree.h>
 #include <sys/ttydefaults.h>
+#include <linux/time64.h>
 
 #include "../../util/callchain.h"
 #include "../../util/evsel.h"
@@ -30,6 +31,7 @@
 #include "srcline.h"
 #include "string2.h"
 #include "units.h"
+#include "time-utils.h"
 
 #include "sane_ctype.h"
 
@@ -1224,6 +1226,8 @@ void hist_browser__init_hpp(void)
 				hist_browser__hpp_color_overhead_guest_us;
 	perf_hpp__format[PERF_HPP__OVERHEAD_ACC].color =
 				hist_browser__hpp_color_overhead_acc;
+
+	res_sample_init();
 }
 
 static int hist_browser__show_entry(struct hist_browser *browser,
@@ -2338,9 +2342,12 @@ static int switch_data_file(void)
 }
 
 struct popup_action {
+	unsigned long		time;
 	struct thread 		*thread;
 	struct map_symbol 	ms;
 	int			socket;
+	struct perf_evsel	*evsel;
+	enum rstype		rstype;
 
 	int (*fn)(struct hist_browser *browser, struct popup_action *act);
 };
@@ -2527,45 +2534,136 @@ static int
 do_run_script(struct hist_browser *browser __maybe_unused,
 	      struct popup_action *act)
 {
-	char script_opt[64];
-	memset(script_opt, 0, sizeof(script_opt));
+	char *script_opt;
+	int len;
+	int n = 0;
 
+	len = 100;
+	if (act->thread)
+		len += strlen(thread__comm_str(act->thread));
+	else if (act->ms.sym)
+		len += strlen(act->ms.sym->name);
+	script_opt = malloc(len);
+	if (!script_opt)
+		return -1;
+
+	script_opt[0] = 0;
 	if (act->thread) {
-		scnprintf(script_opt, sizeof(script_opt), " -c %s ",
+		n = scnprintf(script_opt, len, " -c %s ",
 			  thread__comm_str(act->thread));
 	} else if (act->ms.sym) {
-		scnprintf(script_opt, sizeof(script_opt), " -S %s ",
+		n = scnprintf(script_opt, len, " -S %s ",
 			  act->ms.sym->name);
 	}
 
-	script_browse(script_opt);
+	if (act->time) {
+		char start[32], end[32];
+		unsigned long starttime = act->time;
+		unsigned long endtime = act->time + symbol_conf.time_quantum;
+
+		if (starttime == endtime) { /* Display 1ms as fallback */
+			starttime -= 1*NSEC_PER_MSEC;
+			endtime += 1*NSEC_PER_MSEC;
+		}
+		timestamp__scnprintf_usec(starttime, start, sizeof start);
+		timestamp__scnprintf_usec(endtime, end, sizeof end);
+		n += snprintf(script_opt + n, len - n, " --time %s,%s", start, end);
+	}
+
+	script_browse(script_opt, act->evsel);
+	free(script_opt);
 	return 0;
 }
 
 static int
-add_script_opt(struct hist_browser *browser __maybe_unused,
+do_res_sample_script(struct hist_browser *browser __maybe_unused,
+		     struct popup_action *act)
+{
+	struct hist_entry *he;
+
+	he = hist_browser__selected_entry(browser);
+	res_sample_browse(he->res_samples, he->num_res, act->evsel, act->rstype);
+	return 0;
+}
+
+static int
+add_script_opt_2(struct hist_browser *browser __maybe_unused,
 	       struct popup_action *act, char **optstr,
-	       struct thread *thread, struct symbol *sym)
+	       struct thread *thread, struct symbol *sym,
+	       struct perf_evsel *evsel, const char *tstr)
 {
+
 	if (thread) {
-		if (asprintf(optstr, "Run scripts for samples of thread [%s]",
-			     thread__comm_str(thread)) < 0)
+		if (asprintf(optstr, "Run scripts for samples of thread [%s]%s",
+			     thread__comm_str(thread), tstr) < 0)
 			return 0;
 	} else if (sym) {
-		if (asprintf(optstr, "Run scripts for samples of symbol [%s]",
-			     sym->name) < 0)
+		if (asprintf(optstr, "Run scripts for samples of symbol [%s]%s",
+			     sym->name, tstr) < 0)
 			return 0;
 	} else {
-		if (asprintf(optstr, "Run scripts for all samples") < 0)
+		if (asprintf(optstr, "Run scripts for all samples%s", tstr) < 0)
 			return 0;
 	}
 
 	act->thread = thread;
 	act->ms.sym = sym;
+	act->evsel = evsel;
 	act->fn = do_run_script;
 	return 1;
 }
 
+static int
+add_script_opt(struct hist_browser *browser,
+	       struct popup_action *act, char **optstr,
+	       struct thread *thread, struct symbol *sym,
+	       struct perf_evsel *evsel)
+{
+	int n, j;
+	struct hist_entry *he;
+
+	n = add_script_opt_2(browser, act, optstr, thread, sym, evsel, "");
+
+	he = hist_browser__selected_entry(browser);
+	if (sort_order && strstr(sort_order, "time")) {
+		char tstr[128];
+
+		optstr++;
+		act++;
+		j = sprintf(tstr, " in ");
+		j += timestamp__scnprintf_usec(he->time, tstr + j,
+					       sizeof tstr - j);
+		j += sprintf(tstr + j, "-");
+		timestamp__scnprintf_usec(he->time + symbol_conf.time_quantum,
+				          tstr + j, sizeof tstr - j);
+		n += add_script_opt_2(browser, act, optstr, thread, sym,
+					  evsel, tstr);
+		act->time = he->time;
+	}
+	return n;
+}
+
+static int
+add_res_sample_opt(struct hist_browser *browser __maybe_unused,
+		   struct popup_action *act, char **optstr,
+		   struct res_sample *res_sample,
+		   struct perf_evsel *evsel,
+		   enum rstype type)
+{
+	if (!res_sample)
+		return 0;
+
+	if (asprintf(optstr, "Show context for individual samples %s",
+		type == A_ASM ? "with assembler" :
+		type == A_SOURCE ? "with source" : "") < 0)
+		return 0;
+
+	act->fn = do_res_sample_script;
+	act->evsel = evsel;
+	act->rstype = type;
+	return 1;
+}
+
 static int
 do_switch_data(struct hist_browser *browser __maybe_unused,
 	       struct popup_action *act __maybe_unused)
@@ -3031,7 +3129,7 @@ static int perf_evsel__hists_browse(struct perf_evsel *evsel, int nr_events,
 				nr_options += add_script_opt(browser,
 							     &actions[nr_options],
 							     &options[nr_options],
-							     thread, NULL);
+							     thread, NULL, evsel);
 			}
 			/*
 			 * Note that browser->selection != NULL
@@ -3046,11 +3144,24 @@ static int perf_evsel__hists_browse(struct perf_evsel *evsel, int nr_events,
 				nr_options += add_script_opt(browser,
 							     &actions[nr_options],
 							     &options[nr_options],
-							     NULL, browser->selection->sym);
+							     NULL, browser->selection->sym,
+							     evsel);
 			}
 		}
 		nr_options += add_script_opt(browser, &actions[nr_options],
-					     &options[nr_options], NULL, NULL);
+					     &options[nr_options], NULL, NULL, evsel);
+		nr_options += add_res_sample_opt(browser, &actions[nr_options],
+						 &options[nr_options],
+				 hist_browser__selected_entry(browser)->res_samples,
+				 evsel, A_NORMAL);
+		nr_options += add_res_sample_opt(browser, &actions[nr_options],
+						 &options[nr_options],
+				 hist_browser__selected_entry(browser)->res_samples,
+				 evsel, A_ASM);
+		nr_options += add_res_sample_opt(browser, &actions[nr_options],
+						 &options[nr_options],
+				 hist_browser__selected_entry(browser)->res_samples,
+				 evsel, A_SOURCE);
 		nr_options += add_switch_opt(browser, &actions[nr_options],
 					     &options[nr_options]);
 skip_scripting:
diff --git a/tools/perf/ui/browsers/res_sample.c b/tools/perf/ui/browsers/res_sample.c
new file mode 100644
index 000000000000..c0dd73176d42
--- /dev/null
+++ b/tools/perf/ui/browsers/res_sample.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Display a menu with individual samples to browse with perf script */
+#include "util.h"
+#include "hist.h"
+#include "evsel.h"
+#include "hists.h"
+#include "sort.h"
+#include "config.h"
+#include "time-utils.h"
+#include <linux/time64.h>
+
+static u64 context_len = 10 * NSEC_PER_MSEC;
+
+static int res_sample_config(const char *var, const char *value, void *data __maybe_unused)
+{
+	if (!strcmp(var, "samples.context"))
+		return perf_config_u64(&context_len, var, value);
+	return 0;
+}
+
+void res_sample_init(void)
+{
+	perf_config(res_sample_config, NULL);
+}
+
+int res_sample_browse(struct res_sample *res_samples, int num_res,
+		      struct perf_evsel *evsel, enum rstype rstype)
+{
+	char **names;
+	int i, n;
+	int choice;
+	char *cmd;
+	char pbuf[256], tidbuf[32], cpubuf[32];
+	const char *perf = perf_exe(pbuf, sizeof pbuf);
+	char trange[128], tsample[64];
+	struct res_sample *r;
+	char extra_format[256];
+
+	names = calloc(num_res, sizeof(char *));
+	if (!names)
+		return -1;
+	for (i = 0; i < num_res; i++) {
+		char tbuf[64];
+
+		timestamp__scnprintf_nsec(res_samples[i].time, tbuf, sizeof tbuf);
+		if (asprintf(&names[i], "%s: CPU %d tid %d", tbuf,
+			     res_samples[i].cpu, res_samples[i].tid) < 0) {
+			while (--i >= 0)
+				free(names[i]);
+			free(names);
+			return -1;
+		}
+	}
+	choice = ui__popup_menu(num_res, names);
+	for (i = 0; i < num_res; i++)
+		free(names[i]);
+	free(names);
+
+	if (choice < 0 || choice >= num_res)
+		return -1;
+	r = &res_samples[choice];
+
+	n = timestamp__scnprintf_nsec(r->time - context_len, trange, sizeof trange);
+	trange[n++] = ',';
+	timestamp__scnprintf_nsec(r->time + context_len, trange + n, sizeof trange - n);
+
+	timestamp__scnprintf_nsec(r->time, tsample, sizeof tsample);
+
+	attr_to_script(extra_format, &evsel->attr);
+
+	if (asprintf(&cmd, "%s script %s%s --time %s %s%s %s%s --ns %s %s %s %s %s | less +/%s",
+		     perf,
+		     input_name ? "-i " : "",
+		     input_name ? input_name : "",
+		     trange,
+		     r->cpu >= 0 ? "--cpu " : "",
+		     r->cpu >= 0 ? (sprintf(cpubuf, "%d", r->cpu), cpubuf) : "",
+		     r->tid ? "--tid " : "",
+		     r->tid ? (sprintf(tidbuf, "%d", r->tid), tidbuf) : "",
+		     extra_format,
+		     rstype == A_ASM ? "-F +insn --xed" :
+		     rstype == A_SOURCE ? "-F +srcline,+srccode" : "",
+		     symbol_conf.inline_name ? "--inline" : "",
+		     "--show-lost-events ",
+		     r->tid ? "--show-switch-events --show-task-events " : "",
+		     tsample) < 0)
+		return -1;
+	run_script(cmd);
+	free(cmd);
+	return 0;
+}
diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
index 90a32ac69e76..27cf3ab88d13 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -1,34 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <elf.h>
-#include <inttypes.h>
-#include <sys/ttydefaults.h>
-#include <string.h>
 #include "../../util/sort.h"
 #include "../../util/util.h"
 #include "../../util/hist.h"
 #include "../../util/debug.h"
 #include "../../util/symbol.h"
 #include "../browser.h"
-#include "../helpline.h"
 #include "../libslang.h"
-
-/* 2048 lines should be enough for a script output */
-#define MAX_LINES		2048
-
-/* 160 bytes for one output line */
-#define AVERAGE_LINE_LEN	160
-
-struct script_line {
-	struct list_head node;
-	char line[AVERAGE_LINE_LEN];
-};
-
-struct perf_script_browser {
-	struct ui_browser b;
-	struct list_head entries;
-	const char *script_name;
-	int nr_lines;
-};
+#include "config.h"
 
 #define SCRIPT_NAMELEN	128
 #define SCRIPT_MAX_NO	64
@@ -40,149 +18,169 @@ struct perf_script_browser {
  */
 #define SCRIPT_FULLPATH_LEN	256
 
+struct script_config {
+	const char **names;
+	char **paths;
+	int index;
+	const char *perf;
+	char extra_format[256];
+};
+
+void attr_to_script(char *extra_format, struct perf_event_attr *attr)
+{
+	extra_format[0] = 0;
+	if (attr->read_format & PERF_FORMAT_GROUP)
+		strcat(extra_format, " -F +metric");
+	if (attr->sample_type & PERF_SAMPLE_BRANCH_STACK)
+		strcat(extra_format, " -F +brstackinsn --xed");
+	if (attr->sample_type & PERF_SAMPLE_REGS_INTR)
+		strcat(extra_format, " -F +iregs");
+	if (attr->sample_type & PERF_SAMPLE_REGS_USER)
+		strcat(extra_format, " -F +uregs");
+	if (attr->sample_type & PERF_SAMPLE_PHYS_ADDR)
+		strcat(extra_format, " -F +phys_addr");
+}
+
+static int add_script_option(const char *name, const char *opt,
+			     struct script_config *c)
+{
+	c->names[c->index] = name;
+	if (asprintf(&c->paths[c->index],
+		     "%s script %s -F +metric %s %s",
+		     c->perf, opt, symbol_conf.inline_name ? " --inline" : "",
+		     c->extra_format) < 0)
+		return -1;
+	c->index++;
+	return 0;
+}
+
+static int scripts_config(const char *var, const char *value, void *data)
+{
+	struct script_config *c = data;
+
+	if (!strstarts(var, "scripts."))
+		return -1;
+	if (c->index >= SCRIPT_MAX_NO)
+		return -1;
+	c->names[c->index] = strdup(var + 7);
+	if (!c->names[c->index])
+		return -1;
+	if (asprintf(&c->paths[c->index], "%s %s", value,
+		     c->extra_format) < 0)
+		return -1;
+	c->index++;
+	return 0;
+}
+
 /*
  * When success, will copy the full path of the selected script
  * into  the buffer pointed by script_name, and return 0.
  * Return -1 on failure.
  */
-static int list_scripts(char *script_name)
+static int list_scripts(char *script_name, bool *custom,
+			struct perf_evsel *evsel)
 {
-	char *buf, *names[SCRIPT_MAX_NO], *paths[SCRIPT_MAX_NO];
-	int i, num, choice, ret = -1;
+	char *buf, *paths[SCRIPT_MAX_NO], *names[SCRIPT_MAX_NO];
+	int i, num, choice;
+	int ret = 0;
+	int max_std, custom_perf;
+	char pbuf[256];
+	const char *perf = perf_exe(pbuf, sizeof pbuf);
+	struct script_config scriptc = {
+		.names = (const char **)names,
+		.paths = paths,
+		.perf = perf
+	};
+
+	script_name[0] = 0;
 
 	/* Preset the script name to SCRIPT_NAMELEN */
 	buf = malloc(SCRIPT_MAX_NO * (SCRIPT_NAMELEN + SCRIPT_FULLPATH_LEN));
 	if (!buf)
-		return ret;
+		return -1;
 
-	for (i = 0; i < SCRIPT_MAX_NO; i++) {
-		names[i] = buf + i * (SCRIPT_NAMELEN + SCRIPT_FULLPATH_LEN);
+	if (evsel)
+		attr_to_script(scriptc.extra_format, &evsel->attr);
+	add_script_option("Show individual samples", "", &scriptc);
+	add_script_option("Show individual samples with assembler", "-F +insn --xed",
+			  &scriptc);
+	add_script_option("Show individual samples with source", "-F +srcline,+srccode",
+			  &scriptc);
+	perf_config(scripts_config, &scriptc);
+	custom_perf = scriptc.index;
+	add_script_option("Show samples with custom perf script arguments", "", &scriptc);
+	i = scriptc.index;
+	max_std = i;
+
+	for (; i < SCRIPT_MAX_NO; i++) {
+		names[i] = buf + (i - max_std) * (SCRIPT_NAMELEN + SCRIPT_FULLPATH_LEN);
 		paths[i] = names[i] + SCRIPT_NAMELEN;
 	}
 
-	num = find_scripts(names, paths);
-	if (num > 0) {
-		choice = ui__popup_menu(num, names);
-		if (choice < num && choice >= 0) {
-			strcpy(script_name, paths[choice]);
-			ret = 0;
-		}
+	num = find_scripts(names + max_std, paths + max_std, SCRIPT_MAX_NO - max_std,
+			SCRIPT_FULLPATH_LEN);
+	if (num < 0)
+		num = 0;
+	choice = ui__popup_menu(num + max_std, (char * const *)names);
+	if (choice < 0) {
+		ret = -1;
+		goto out;
 	}
+	if (choice == custom_perf) {
+		char script_args[50];
+		int key = ui_browser__input_window("perf script command",
+				"Enter perf script command line (without perf script prefix)",
+				script_args, "", 0);
+		if (key != K_ENTER)
+			return -1;
+		sprintf(script_name, "%s script %s", perf, script_args);
+	} else if (choice < num + max_std) {
+		strcpy(script_name, paths[choice]);
+	}
+	*custom = choice >= max_std;
 
+out:
 	free(buf);
+	for (i = 0; i < max_std; i++)
+		free(paths[i]);
 	return ret;
 }
 
-static void script_browser__write(struct ui_browser *browser,
-				   void *entry, int row)
+void run_script(char *cmd)
 {
-	struct script_line *sline = list_entry(entry, struct script_line, node);
-	bool current_entry = ui_browser__is_current_entry(browser, row);
-
-	ui_browser__set_color(browser, current_entry ? HE_COLORSET_SELECTED :
-						       HE_COLORSET_NORMAL);
-
-	ui_browser__write_nstring(browser, sline->line, browser->width);
+	pr_debug("Running %s\n", cmd);
+	SLang_reset_tty();
+	if (system(cmd) < 0)
+		pr_warning("Cannot run %s\n", cmd);
+	/*
+	 * SLang doesn't seem to reset the whole terminal, so be more
+	 * forceful to get back to the original state.
+	 */
+	printf("\033[c\033[H\033[J");
+	fflush(stdout);
+	SLang_init_tty(0, 0, 0);
+	SLsmg_refresh();
 }
 
-static int script_browser__run(struct perf_script_browser *browser)
+int script_browse(const char *script_opt, struct perf_evsel *evsel)
 {
-	int key;
+	char *cmd, script_name[SCRIPT_FULLPATH_LEN];
+	bool custom = false;
 
-	if (ui_browser__show(&browser->b, browser->script_name,
-			     "Press ESC to exit") < 0)
+	memset(script_name, 0, SCRIPT_FULLPATH_LEN);
+	if (list_scripts(script_name, &custom, evsel))
 		return -1;
 
-	while (1) {
-		key = ui_browser__run(&browser->b, 0);
-
-		/* We can add some special key handling here if needed */
-		break;
-	}
-
-	ui_browser__hide(&browser->b);
-	return key;
-}
-
-
-int script_browse(const char *script_opt)
-{
-	char cmd[SCRIPT_FULLPATH_LEN*2], script_name[SCRIPT_FULLPATH_LEN];
-	char *line = NULL;
-	size_t len = 0;
-	ssize_t retlen;
-	int ret = -1, nr_entries = 0;
-	FILE *fp;
-	void *buf;
-	struct script_line *sline;
-
-	struct perf_script_browser script = {
-		.b = {
-			.refresh    = ui_browser__list_head_refresh,
-			.seek	    = ui_browser__list_head_seek,
-			.write	    = script_browser__write,
-		},
-		.script_name = script_name,
-	};
-
-	INIT_LIST_HEAD(&script.entries);
-
-	/* Save each line of the output in one struct script_line object. */
-	buf = zalloc((sizeof(*sline)) * MAX_LINES);
-	if (!buf)
+	if (asprintf(&cmd, "%s%s %s %s%s 2>&1 | less",
+			custom ? "perf script -s " : "",
+			script_name,
+			script_opt ? script_opt : "",
+			input_name ? "-i " : "",
+			input_name ? input_name : "") < 0)
 		return -1;
-	sline = buf;
-
-	memset(script_name, 0, SCRIPT_FULLPATH_LEN);
-	if (list_scripts(script_name))
-		goto exit;
-
-	sprintf(cmd, "perf script -s %s ", script_name);
 
-	if (script_opt)
-		strcat(cmd, script_opt);
+	run_script(cmd);
+	free(cmd);
 
-	if (input_name) {
-		strcat(cmd, " -i ");
-		strcat(cmd, input_name);
-	}
-
-	strcat(cmd, " 2>&1");
-
-	fp = popen(cmd, "r");
-	if (!fp)
-		goto exit;
-
-	while ((retlen = getline(&line, &len, fp)) != -1) {
-		strncpy(sline->line, line, AVERAGE_LINE_LEN);
-
-		/* If one output line is very large, just cut it short */
-		if (retlen >= AVERAGE_LINE_LEN) {
-			sline->line[AVERAGE_LINE_LEN - 1] = '\0';
-			sline->line[AVERAGE_LINE_LEN - 2] = '\n';
-		}
-		list_add_tail(&sline->node, &script.entries);
-
-		if (script.b.width < retlen)
-			script.b.width = retlen;
-
-		if (nr_entries++ >= MAX_LINES - 1)
-			break;
-		sline++;
-	}
-
-	if (script.b.width > AVERAGE_LINE_LEN)
-		script.b.width = AVERAGE_LINE_LEN;
-
-	free(line);
-	pclose(fp);
-
-	script.nr_lines = nr_entries;
-	script.b.nr_entries = nr_entries;
-	script.b.entries = &script.entries;
-
-	ret = script_browser__run(&script);
-exit:
-	free(buf);
-	return ret;
+	return 0;
 }
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 5f6dbbf5d749..c8b01176c9e1 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -10,6 +10,10 @@
 #include <errno.h>
 #include <inttypes.h>
 #include <libgen.h>
+#include <bpf/bpf.h>
+#include <bpf/btf.h>
+#include <bpf/libbpf.h>
+#include <linux/btf.h>
 #include "util.h"
 #include "ui/ui.h"
 #include "sort.h"
@@ -24,6 +28,7 @@
 #include "annotate.h"
 #include "evsel.h"
 #include "evlist.h"
+#include "bpf-event.h"
 #include "block-range.h"
 #include "string2.h"
 #include "arch/common.h"
@@ -31,6 +36,7 @@
 #include <pthread.h>
 #include <linux/bitops.h>
 #include <linux/kernel.h>
+#include <bpf/libbpf.h>
 
 /* FIXME: For the HE_COLORSET */
 #include "ui/browser.h"
@@ -1615,6 +1621,9 @@ int symbol__strerror_disassemble(struct symbol *sym __maybe_unused, struct map *
 			  "  --vmlinux vmlinux\n", build_id_msg ?: "");
 	}
 		break;
+	case SYMBOL_ANNOTATE_ERRNO__NO_LIBOPCODES_FOR_BPF:
+		scnprintf(buf, buflen, "Please link with binutils's libopcode to enable BPF annotation");
+		break;
 	default:
 		scnprintf(buf, buflen, "Internal error: Invalid %d error code\n", errnum);
 		break;
@@ -1674,6 +1683,156 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 	return 0;
 }
 
+#if defined(HAVE_LIBBFD_SUPPORT) && defined(HAVE_LIBBPF_SUPPORT)
+#define PACKAGE "perf"
+#include <bfd.h>
+#include <dis-asm.h>
+
+static int symbol__disassemble_bpf(struct symbol *sym,
+				   struct annotate_args *args)
+{
+	struct annotation *notes = symbol__annotation(sym);
+	struct annotation_options *opts = args->options;
+	struct bpf_prog_info_linear *info_linear;
+	struct bpf_prog_linfo *prog_linfo = NULL;
+	struct bpf_prog_info_node *info_node;
+	int len = sym->end - sym->start;
+	disassembler_ftype disassemble;
+	struct map *map = args->ms.map;
+	struct disassemble_info info;
+	struct dso *dso = map->dso;
+	int pc = 0, count, sub_id;
+	struct btf *btf = NULL;
+	char tpath[PATH_MAX];
+	size_t buf_size;
+	int nr_skip = 0;
+	int ret = -1;
+	char *buf;
+	bfd *bfdf;
+	FILE *s;
+
+	if (dso->binary_type != DSO_BINARY_TYPE__BPF_PROG_INFO)
+		return -1;
+
+	pr_debug("%s: handling sym %s addr %lx len %lx\n", __func__,
+		 sym->name, sym->start, sym->end - sym->start);
+
+	memset(tpath, 0, sizeof(tpath));
+	perf_exe(tpath, sizeof(tpath));
+
+	bfdf = bfd_openr(tpath, NULL);
+	assert(bfdf);
+	assert(bfd_check_format(bfdf, bfd_object));
+
+	s = open_memstream(&buf, &buf_size);
+	if (!s)
+		goto out;
+	init_disassemble_info(&info, s,
+			      (fprintf_ftype) fprintf);
+
+	info.arch = bfd_get_arch(bfdf);
+	info.mach = bfd_get_mach(bfdf);
+
+	info_node = perf_env__find_bpf_prog_info(dso->bpf_prog.env,
+						 dso->bpf_prog.id);
+	if (!info_node)
+		goto out;
+	info_linear = info_node->info_linear;
+	sub_id = dso->bpf_prog.sub_id;
+
+	info.buffer = (void *)(info_linear->info.jited_prog_insns);
+	info.buffer_length = info_linear->info.jited_prog_len;
+
+	if (info_linear->info.nr_line_info)
+		prog_linfo = bpf_prog_linfo__new(&info_linear->info);
+
+	if (info_linear->info.btf_id) {
+		struct btf_node *node;
+
+		node = perf_env__find_btf(dso->bpf_prog.env,
+					  info_linear->info.btf_id);
+		if (node)
+			btf = btf__new((__u8 *)(node->data),
+				       node->data_size);
+	}
+
+	disassemble_init_for_target(&info);
+
+#ifdef DISASM_FOUR_ARGS_SIGNATURE
+	disassemble = disassembler(info.arch,
+				   bfd_big_endian(bfdf),
+				   info.mach,
+				   bfdf);
+#else
+	disassemble = disassembler(bfdf);
+#endif
+	assert(disassemble);
+
+	fflush(s);
+	do {
+		const struct bpf_line_info *linfo = NULL;
+		struct disasm_line *dl;
+		size_t prev_buf_size;
+		const char *srcline;
+		u64 addr;
+
+		addr = pc + ((u64 *)(info_linear->info.jited_ksyms))[sub_id];
+		count = disassemble(pc, &info);
+
+		if (prog_linfo)
+			linfo = bpf_prog_linfo__lfind_addr_func(prog_linfo,
+								addr, sub_id,
+								nr_skip);
+
+		if (linfo && btf) {
+			srcline = btf__name_by_offset(btf, linfo->line_off);
+			nr_skip++;
+		} else
+			srcline = NULL;
+
+		fprintf(s, "\n");
+		prev_buf_size = buf_size;
+		fflush(s);
+
+		if (!opts->hide_src_code && srcline) {
+			args->offset = -1;
+			args->line = strdup(srcline);
+			args->line_nr = 0;
+			args->ms.sym  = sym;
+			dl = disasm_line__new(args);
+			if (dl) {
+				annotation_line__add(&dl->al,
+						     &notes->src->source);
+			}
+		}
+
+		args->offset = pc;
+		args->line = buf + prev_buf_size;
+		args->line_nr = 0;
+		args->ms.sym  = sym;
+		dl = disasm_line__new(args);
+		if (dl)
+			annotation_line__add(&dl->al, &notes->src->source);
+
+		pc += count;
+	} while (count > 0 && pc < len);
+
+	ret = 0;
+out:
+	free(prog_linfo);
+	free(btf);
+	fclose(s);
+	bfd_close(bfdf);
+	return ret;
+}
+#else // defined(HAVE_LIBBFD_SUPPORT) && defined(HAVE_LIBBPF_SUPPORT)
+static int symbol__disassemble_bpf(struct symbol *sym __maybe_unused,
+				   struct annotate_args *args __maybe_unused)
+{
+	return SYMBOL_ANNOTATE_ERRNO__NO_LIBOPCODES_FOR_BPF;
+}
+#endif // defined(HAVE_LIBBFD_SUPPORT) && defined(HAVE_LIBBPF_SUPPORT)
+
 static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 {
 	struct annotation_options *opts = args->options;
@@ -1701,7 +1860,9 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	pr_debug("annotating [%p] %30s : [%p] %30s\n",
 		 dso, dso->long_name, sym, sym->name);
 
-	if (dso__is_kcore(dso)) {
+	if (dso->binary_type == DSO_BINARY_TYPE__BPF_PROG_INFO) {
+		return symbol__disassemble_bpf(sym, args);
+	} else if (dso__is_kcore(dso)) {
 		kce.kcore_filename = symfs_filename;
 		kce.addr = map__rip_2objdump(map, sym->start);
 		kce.offs = sym->start;
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index df34fe483164..5bc0cf655d37 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -369,6 +369,7 @@ enum symbol_disassemble_errno {
 	__SYMBOL_ANNOTATE_ERRNO__START		= -10000,
 
 	SYMBOL_ANNOTATE_ERRNO__NO_VMLINUX	= __SYMBOL_ANNOTATE_ERRNO__START,
+	SYMBOL_ANNOTATE_ERRNO__NO_LIBOPCODES_FOR_BPF,
 
 	__SYMBOL_ANNOTATE_ERRNO__END,
 };
diff --git a/tools/perf/util/archinsn.h b/tools/perf/util/archinsn.h
new file mode 100644
index 000000000000..448cbb6b8d7e
--- /dev/null
+++ b/tools/perf/util/archinsn.h
@@ -0,0 +1,12 @@
+#ifndef INSN_H
+#define INSN_H 1
+
+struct perf_sample;
+struct machine;
+struct thread;
+
+void arch_fetch_insn(struct perf_sample *sample,
+		     struct thread *thread,
+		     struct machine *machine);
+
+#endif
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 028c8ec1f62a..2a4a0da35632 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -3,11 +3,17 @@
 #include <stdlib.h>
 #include <bpf/bpf.h>
 #include <bpf/btf.h>
+#include <bpf/libbpf.h>
 #include <linux/btf.h>
+#include <linux/err.h>
 #include "bpf-event.h"
 #include "debug.h"
 #include "symbol.h"
 #include "machine.h"
+#include "env.h"
+#include "session.h"
+#include "map.h"
+#include "evlist.h"
 
 #define ptr_to_u64(ptr)    ((__u64)(unsigned long)(ptr))
 
@@ -21,15 +27,122 @@ static int snprintf_hex(char *buf, size_t size, unsigned char *data, size_t len)
 	return ret;
 }
 
+static int machine__process_bpf_event_load(struct machine *machine,
+					   union perf_event *event,
+					   struct perf_sample *sample __maybe_unused)
+{
+	struct bpf_prog_info_linear *info_linear;
+	struct bpf_prog_info_node *info_node;
+	struct perf_env *env = machine->env;
+	int id = event->bpf_event.id;
+	unsigned int i;
+
+	/* perf-record, no need to handle bpf-event */
+	if (env == NULL)
+		return 0;
+
+	info_node = perf_env__find_bpf_prog_info(env, id);
+	if (!info_node)
+		return 0;
+	info_linear = info_node->info_linear;
+
+	for (i = 0; i < info_linear->info.nr_jited_ksyms; i++) {
+		u64 *addrs = (u64 *)(uintptr_t)(info_linear->info.jited_ksyms);
+		u64 addr = addrs[i];
+		struct map *map;
+
+		map = map_groups__find(&machine->kmaps, addr);
+
+		if (map) {
+			map->dso->binary_type = DSO_BINARY_TYPE__BPF_PROG_INFO;
+			map->dso->bpf_prog.id = id;
+			map->dso->bpf_prog.sub_id = i;
+			map->dso->bpf_prog.env = env;
+		}
+	}
+	return 0;
+}
+
 int machine__process_bpf_event(struct machine *machine __maybe_unused,
 			       union perf_event *event,
 			       struct perf_sample *sample __maybe_unused)
 {
 	if (dump_trace)
 		perf_event__fprintf_bpf_event(event, stdout);
+
+	switch (event->bpf_event.type) {
+	case PERF_BPF_EVENT_PROG_LOAD:
+		return machine__process_bpf_event_load(machine, event, sample);
+
+	case PERF_BPF_EVENT_PROG_UNLOAD:
+		/*
+		 * Do not free bpf_prog_info and btf of the program here,
+		 * as annotation still need them. They will be freed at
+		 * the end of the session.
+		 */
+		break;
+	default:
+		pr_debug("unexpected bpf_event type of %d\n",
+			 event->bpf_event.type);
+		break;
+	}
 	return 0;
 }
 
+static int perf_env__fetch_btf(struct perf_env *env,
+			       u32 btf_id,
+			       struct btf *btf)
+{
+	struct btf_node *node;
+	u32 data_size;
+	const void *data;
+
+	data = btf__get_raw_data(btf, &data_size);
+
+	node = malloc(data_size + sizeof(struct btf_node));
+	if (!node)
+		return -1;
+
+	node->id = btf_id;
+	node->data_size = data_size;
+	memcpy(node->data, data, data_size);
+
+	perf_env__insert_btf(env, node);
+	return 0;
+}
+
+static int synthesize_bpf_prog_name(char *buf, int size,
+				    struct bpf_prog_info *info,
+				    struct btf *btf,
+				    u32 sub_id)
+{
+	u8 (*prog_tags)[BPF_TAG_SIZE] = (void *)(uintptr_t)(info->prog_tags);
+	void *func_infos = (void *)(uintptr_t)(info->func_info);
+	u32 sub_prog_cnt = info->nr_jited_ksyms;
+	const struct bpf_func_info *finfo;
+	const char *short_name = NULL;
+	const struct btf_type *t;
+	int name_len;
+
+	name_len = snprintf(buf, size, "bpf_prog_");
+	name_len += snprintf_hex(buf + name_len, size - name_len,
+				 prog_tags[sub_id], BPF_TAG_SIZE);
+	if (btf) {
+		finfo = func_infos + sub_id * info->func_info_rec_size;
+		t = btf__type_by_id(btf, finfo->type_id);
+		short_name = btf__name_by_offset(btf, t->name_off);
+	} else if (sub_id == 0 && sub_prog_cnt == 1) {
+		/* no subprog */
+		if (info->name[0])
+			short_name = info->name;
+	} else
+		short_name = "F";
+	if (short_name)
+		name_len += snprintf(buf + name_len, size - name_len,
+				     "_%s", short_name);
+	return name_len;
+}
+
 /*
  * Synthesize PERF_RECORD_KSYMBOL and PERF_RECORD_BPF_EVENT for one bpf
  * program. One PERF_RECORD_BPF_EVENT is generated for the program. And
@@ -40,7 +153,7 @@ int machine__process_bpf_event(struct machine *machine __maybe_unused,
  *   -1 for failures;
  *   -2 for lack of kernel support.
  */
-static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
+static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
 					       perf_event__handler_t process,
 					       struct machine *machine,
 					       int fd,
@@ -49,102 +162,71 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
 {
 	struct ksymbol_event *ksymbol_event = &event->ksymbol_event;
 	struct bpf_event *bpf_event = &event->bpf_event;
-	u32 sub_prog_cnt, i, func_info_rec_size = 0;
-	u8 (*prog_tags)[BPF_TAG_SIZE] = NULL;
-	struct bpf_prog_info info = { .type = 0, };
-	u32 info_len = sizeof(info);
-	void *func_infos = NULL;
-	u64 *prog_addrs = NULL;
+	struct bpf_prog_info_linear *info_linear;
+	struct perf_tool *tool = session->tool;
+	struct bpf_prog_info_node *info_node;
+	struct bpf_prog_info *info;
 	struct btf *btf = NULL;
-	u32 *prog_lens = NULL;
-	bool has_btf = false;
-	char errbuf[512];
+	struct perf_env *env;
+	u32 sub_prog_cnt, i;
 	int err = 0;
+	u64 arrays;
+
+	/*
+	 * for perf-record and perf-report use header.env;
+	 * otherwise, use global perf_env.
+	 */
+	env = session->data ? &session->header.env : &perf_env;
 
-	/* Call bpf_obj_get_info_by_fd() to get sizes of arrays */
-	err = bpf_obj_get_info_by_fd(fd, &info, &info_len);
+	arrays = 1UL << BPF_PROG_INFO_JITED_KSYMS;
+	arrays |= 1UL << BPF_PROG_INFO_JITED_FUNC_LENS;
+	arrays |= 1UL << BPF_PROG_INFO_FUNC_INFO;
+	arrays |= 1UL << BPF_PROG_INFO_PROG_TAGS;
+	arrays |= 1UL << BPF_PROG_INFO_JITED_INSNS;
+	arrays |= 1UL << BPF_PROG_INFO_LINE_INFO;
+	arrays |= 1UL << BPF_PROG_INFO_JITED_LINE_INFO;
 
-	if (err) {
-		pr_debug("%s: failed to get BPF program info: %s, aborting\n",
-			 __func__, str_error_r(errno, errbuf, sizeof(errbuf)));
+	info_linear = bpf_program__get_prog_info_linear(fd, arrays);
+	if (IS_ERR_OR_NULL(info_linear)) {
+		info_linear = NULL;
+		pr_debug("%s: failed to get BPF program info. aborting\n", __func__);
 		return -1;
 	}
-	if (info_len < offsetof(struct bpf_prog_info, prog_tags)) {
+
+	if (info_linear->info_len < offsetof(struct bpf_prog_info, prog_tags)) {
 		pr_debug("%s: the kernel is too old, aborting\n", __func__);
 		return -2;
 	}
 
+	info = &info_linear->info;
+
 	/* number of ksyms, func_lengths, and tags should match */
-	sub_prog_cnt = info.nr_jited_ksyms;
-	if (sub_prog_cnt != info.nr_prog_tags ||
-	    sub_prog_cnt != info.nr_jited_func_lens)
+	sub_prog_cnt = info->nr_jited_ksyms;
+	if (sub_prog_cnt != info->nr_prog_tags ||
+	    sub_prog_cnt != info->nr_jited_func_lens)
 		return -1;
 
 	/* check BTF func info support */
-	if (info.btf_id && info.nr_func_info && info.func_info_rec_size) {
+	if (info->btf_id && info->nr_func_info && info->func_info_rec_size) {
 		/* btf func info number should be same as sub_prog_cnt */
-		if (sub_prog_cnt != info.nr_func_info) {
+		if (sub_prog_cnt != info->nr_func_info) {
 			pr_debug("%s: mismatch in BPF sub program count and BTF function info count, aborting\n", __func__);
-			return -1;
-		}
-		if (btf__get_from_id(info.btf_id, &btf)) {
-			pr_debug("%s: failed to get BTF of id %u, aborting\n", __func__, info.btf_id);
-			return -1;
+			err = -1;
+			goto out;
 		}
-		func_info_rec_size = info.func_info_rec_size;
-		func_infos = calloc(sub_prog_cnt, func_info_rec_size);
-		if (!func_infos) {
-			pr_debug("%s: failed to allocate memory for func_infos, aborting\n", __func__);
-			return -1;
+		if (btf__get_from_id(info->btf_id, &btf)) {
+			pr_debug("%s: failed to get BTF of id %u, aborting\n", __func__, info->btf_id);
+			err = -1;
+			btf = NULL;
+			goto out;
 		}
-		has_btf = true;
-	}
-
-	/*
-	 * We need address, length, and tag for each sub program.
-	 * Allocate memory and call bpf_obj_get_info_by_fd() again
-	 */
-	prog_addrs = calloc(sub_prog_cnt, sizeof(u64));
-	if (!prog_addrs) {
-		pr_debug("%s: failed to allocate memory for prog_addrs, aborting\n", __func__);
-		goto out;
-	}
-	prog_lens = calloc(sub_prog_cnt, sizeof(u32));
-	if (!prog_lens) {
-		pr_debug("%s: failed to allocate memory for prog_lens, aborting\n", __func__);
-		goto out;
-	}
-	prog_tags = calloc(sub_prog_cnt, BPF_TAG_SIZE);
-	if (!prog_tags) {
-		pr_debug("%s: failed to allocate memory for prog_tags, aborting\n", __func__);
-		goto out;
-	}
-
-	memset(&info, 0, sizeof(info));
-	info.nr_jited_ksyms = sub_prog_cnt;
-	info.nr_jited_func_lens = sub_prog_cnt;
-	info.nr_prog_tags = sub_prog_cnt;
-	info.jited_ksyms = ptr_to_u64(prog_addrs);
-	info.jited_func_lens = ptr_to_u64(prog_lens);
-	info.prog_tags = ptr_to_u64(prog_tags);
-	info_len = sizeof(info);
-	if (has_btf) {
-		info.nr_func_info = sub_prog_cnt;
-		info.func_info_rec_size = func_info_rec_size;
-		info.func_info = ptr_to_u64(func_infos);
-	}
-
-	err = bpf_obj_get_info_by_fd(fd, &info, &info_len);
-	if (err) {
-		pr_debug("%s: failed to get BPF program info, aborting\n", __func__);
-		goto out;
+		perf_env__fetch_btf(env, info->btf_id, btf);
 	}
 
 	/* Synthesize PERF_RECORD_KSYMBOL */
 	for (i = 0; i < sub_prog_cnt; i++) {
-		const struct bpf_func_info *finfo;
-		const char *short_name = NULL;
-		const struct btf_type *t;
+		__u32 *prog_lens = (__u32 *)(uintptr_t)(info->jited_func_lens);
+		__u64 *prog_addrs = (__u64 *)(uintptr_t)(info->jited_ksyms);
 		int name_len;
 
 		*ksymbol_event = (struct ksymbol_event){
@@ -157,26 +239,9 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
 			.ksym_type = PERF_RECORD_KSYMBOL_TYPE_BPF,
 			.flags = 0,
 		};
-		name_len = snprintf(ksymbol_event->name, KSYM_NAME_LEN,
-				    "bpf_prog_");
-		name_len += snprintf_hex(ksymbol_event->name + name_len,
-					 KSYM_NAME_LEN - name_len,
-					 prog_tags[i], BPF_TAG_SIZE);
-		if (has_btf) {
-			finfo = func_infos + i * info.func_info_rec_size;
-			t = btf__type_by_id(btf, finfo->type_id);
-			short_name = btf__name_by_offset(btf, t->name_off);
-		} else if (i == 0 && sub_prog_cnt == 1) {
-			/* no subprog */
-			if (info.name[0])
-				short_name = info.name;
-		} else
-			short_name = "F";
-		if (short_name)
-			name_len += snprintf(ksymbol_event->name + name_len,
-					     KSYM_NAME_LEN - name_len,
-					     "_%s", short_name);
 
+		name_len = synthesize_bpf_prog_name(ksymbol_event->name,
+						    KSYM_NAME_LEN, info, btf, i);
 		ksymbol_event->header.size += PERF_ALIGN(name_len + 1,
 							 sizeof(u64));
 
@@ -186,8 +251,8 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
 						     machine, process);
 	}
 
-	/* Synthesize PERF_RECORD_BPF_EVENT */
-	if (opts->bpf_event) {
+	if (!opts->no_bpf_event) {
+		/* Synthesize PERF_RECORD_BPF_EVENT */
 		*bpf_event = (struct bpf_event){
 			.header = {
 				.type = PERF_RECORD_BPF_EVENT,
@@ -195,25 +260,38 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
 			},
 			.type = PERF_BPF_EVENT_PROG_LOAD,
 			.flags = 0,
-			.id = info.id,
+			.id = info->id,
 		};
-		memcpy(bpf_event->tag, prog_tags[i], BPF_TAG_SIZE);
+		memcpy(bpf_event->tag, info->tag, BPF_TAG_SIZE);
 		memset((void *)event + event->header.size, 0, machine->id_hdr_size);
 		event->header.size += machine->id_hdr_size;
+
+		/* save bpf_prog_info to env */
+		info_node = malloc(sizeof(struct bpf_prog_info_node));
+		if (!info_node) {
+			err = -1;
+			goto out;
+		}
+
+		info_node->info_linear = info_linear;
+		perf_env__insert_bpf_prog_info(env, info_node);
+		info_linear = NULL;
+
+		/*
+		 * process after saving bpf_prog_info to env, so that
+		 * required information is ready for look up
+		 */
 		err = perf_tool__process_synth_event(tool, event,
 						     machine, process);
 	}
 
 out:
-	free(prog_tags);
-	free(prog_lens);
-	free(prog_addrs);
-	free(func_infos);
+	free(info_linear);
 	free(btf);
 	return err ? -1 : 0;
 }
 
-int perf_event__synthesize_bpf_events(struct perf_tool *tool,
+int perf_event__synthesize_bpf_events(struct perf_session *session,
 				      perf_event__handler_t process,
 				      struct machine *machine,
 				      struct record_opts *opts)
@@ -247,7 +325,7 @@ int perf_event__synthesize_bpf_events(struct perf_tool *tool,
 			continue;
 		}
 
-		err = perf_event__synthesize_one_bpf_prog(tool, process,
+		err = perf_event__synthesize_one_bpf_prog(session, process,
 							  machine, fd,
 							  event, opts);
 		close(fd);
@@ -261,3 +339,142 @@ int perf_event__synthesize_bpf_events(struct perf_tool *tool,
 	free(event);
 	return err;
 }
+
+static void perf_env__add_bpf_info(struct perf_env *env, u32 id)
+{
+	struct bpf_prog_info_linear *info_linear;
+	struct bpf_prog_info_node *info_node;
+	struct btf *btf = NULL;
+	u64 arrays;
+	u32 btf_id;
+	int fd;
+
+	fd = bpf_prog_get_fd_by_id(id);
+	if (fd < 0)
+		return;
+
+	arrays = 1UL << BPF_PROG_INFO_JITED_KSYMS;
+	arrays |= 1UL << BPF_PROG_INFO_JITED_FUNC_LENS;
+	arrays |= 1UL << BPF_PROG_INFO_FUNC_INFO;
+	arrays |= 1UL << BPF_PROG_INFO_PROG_TAGS;
+	arrays |= 1UL << BPF_PROG_INFO_JITED_INSNS;
+	arrays |= 1UL << BPF_PROG_INFO_LINE_INFO;
+	arrays |= 1UL << BPF_PROG_INFO_JITED_LINE_INFO;
+
+	info_linear = bpf_program__get_prog_info_linear(fd, arrays);
+	if (IS_ERR_OR_NULL(info_linear)) {
+		pr_debug("%s: failed to get BPF program info. aborting\n", __func__);
+		goto out;
+	}
+
+	btf_id = info_linear->info.btf_id;
+
+	info_node = malloc(sizeof(struct bpf_prog_info_node));
+	if (info_node) {
+		info_node->info_linear = info_linear;
+		perf_env__insert_bpf_prog_info(env, info_node);
+	} else
+		free(info_linear);
+
+	if (btf_id == 0)
+		goto out;
+
+	if (btf__get_from_id(btf_id, &btf)) {
+		pr_debug("%s: failed to get BTF of id %u, aborting\n",
+			 __func__, btf_id);
+		goto out;
+	}
+	perf_env__fetch_btf(env, btf_id, btf);
+
+out:
+	free(btf);
+	close(fd);
+}
+
+static int bpf_event__sb_cb(union perf_event *event, void *data)
+{
+	struct perf_env *env = data;
+
+	if (event->header.type != PERF_RECORD_BPF_EVENT)
+		return -1;
+
+	switch (event->bpf_event.type) {
+	case PERF_BPF_EVENT_PROG_LOAD:
+		perf_env__add_bpf_info(env, event->bpf_event.id);
+
+	case PERF_BPF_EVENT_PROG_UNLOAD:
+		/*
+		 * Do not free bpf_prog_info and btf of the program here,
+		 * as annotation still need them. They will be freed at
+		 * the end of the session.
+		 */
+		break;
+	default:
+		pr_debug("unexpected bpf_event type of %d\n",
+			 event->bpf_event.type);
+		break;
+	}
+
+	return 0;
+}
+
+int bpf_event__add_sb_event(struct perf_evlist **evlist,
+			    struct perf_env *env)
+{
+	struct perf_event_attr attr = {
+		.type	          = PERF_TYPE_SOFTWARE,
+		.config           = PERF_COUNT_SW_DUMMY,
+		.sample_id_all    = 1,
+		.watermark        = 1,
+		.bpf_event        = 1,
+		.size	   = sizeof(attr), /* to capture ABI version */
+	};
+
+	/*
+	 * Older gcc versions don't support designated initializers, like above,
+	 * for unnamed union members, such as the following:
+	 */
+	attr.wakeup_watermark = 1;
+
+	return perf_evlist__add_sb_event(evlist, &attr, bpf_event__sb_cb, env);
+}
+
+void bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
+				    struct perf_env *env,
+				    FILE *fp)
+{
+	__u32 *prog_lens = (__u32 *)(uintptr_t)(info->jited_func_lens);
+	__u64 *prog_addrs = (__u64 *)(uintptr_t)(info->jited_ksyms);
+	char name[KSYM_NAME_LEN];
+	struct btf *btf = NULL;
+	u32 sub_prog_cnt, i;
+
+	sub_prog_cnt = info->nr_jited_ksyms;
+	if (sub_prog_cnt != info->nr_prog_tags ||
+	    sub_prog_cnt != info->nr_jited_func_lens)
+		return;
+
+	if (info->btf_id) {
+		struct btf_node *node;
+
+		node = perf_env__find_btf(env, info->btf_id);
+		if (node)
+			btf = btf__new((__u8 *)(node->data),
+				       node->data_size);
+	}
+
+	if (sub_prog_cnt == 1) {
+		synthesize_bpf_prog_name(name, KSYM_NAME_LEN, info, btf, 0);
+		fprintf(fp, "# bpf_prog_info %u: %s addr 0x%llx size %u\n",
+			info->id, name, prog_addrs[0], prog_lens[0]);
+		return;
+	}
+
+	fprintf(fp, "# bpf_prog_info %u:\n", info->id);
+	for (i = 0; i < sub_prog_cnt; i++) {
+		synthesize_bpf_prog_name(name, KSYM_NAME_LEN, info, btf, i);
+
+		fprintf(fp, "# \tsub_prog %u: %s addr 0x%llx size %u\n",
+			i, name, prog_addrs[i], prog_lens[i]);
+	}
+}
diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
index 7890067e1a37..04c33b3bfe28 100644
--- a/tools/perf/util/bpf-event.h
+++ b/tools/perf/util/bpf-event.h
@@ -3,22 +3,45 @@
 #define __PERF_BPF_EVENT_H
 
 #include <linux/compiler.h>
+#include <linux/rbtree.h>
+#include <pthread.h>
+#include <api/fd/array.h>
 #include "event.h"
+#include <stdio.h>
 
 struct machine;
 union perf_event;
+struct perf_env;
 struct perf_sample;
-struct perf_tool;
 struct record_opts;
+struct evlist;
+struct target;
+
+struct bpf_prog_info_node {
+	struct bpf_prog_info_linear	*info_linear;
+	struct rb_node			rb_node;
+};
+
+struct btf_node {
+	struct rb_node	rb_node;
+	u32		id;
+	u32		data_size;
+	char		data[];
+};
 
 #ifdef HAVE_LIBBPF_SUPPORT
 int machine__process_bpf_event(struct machine *machine, union perf_event *event,
 			       struct perf_sample *sample);
 
-int perf_event__synthesize_bpf_events(struct perf_tool *tool,
+int perf_event__synthesize_bpf_events(struct perf_session *session,
 				      perf_event__handler_t process,
 				      struct machine *machine,
 				      struct record_opts *opts);
+int bpf_event__add_sb_event(struct perf_evlist **evlist,
+				 struct perf_env *env);
+void bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
+				    struct perf_env *env,
+				    FILE *fp);
 #else
 static inline int machine__process_bpf_event(struct machine *machine __maybe_unused,
 					     union perf_event *event __maybe_unused,
@@ -27,12 +50,25 @@ static inline int machine__process_bpf_event(struct machine *machine __maybe_unu
 	return 0;
 }
 
-static inline int perf_event__synthesize_bpf_events(struct perf_tool *tool __maybe_unused,
+static inline int perf_event__synthesize_bpf_events(struct perf_session *session __maybe_unused,
 						    perf_event__handler_t process __maybe_unused,
 						    struct machine *machine __maybe_unused,
 						    struct record_opts *opts __maybe_unused)
 {
 	return 0;
 }
+
+static inline int bpf_event__add_sb_event(struct perf_evlist **evlist __maybe_unused,
+					  struct perf_env *env __maybe_unused)
+{
+	return 0;
+}
+
+static inline void bpf_event__print_bpf_prog_info(struct bpf_prog_info *info __maybe_unused,
+						  struct perf_env *env __maybe_unused,
+						  FILE *fp __maybe_unused)
+{
+
+}
 #endif // HAVE_LIBBPF_SUPPORT
 #endif
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index bff0d17920ed..0c5517a8d0b7 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -185,6 +185,7 @@ char *build_id_cache__linkname(const char *sbuild_id, char *bf, size_t size)
 	return bf;
 }
 
+/* The caller is responsible to free the returned buffer. */
 char *build_id_cache__origname(const char *sbuild_id)
 {
 	char *linkname;
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index fa092511c52b..7e3c1b60120c 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -633,11 +633,10 @@ static int collect_config(const char *var, const char *value,
 	}
 
 	ret = set_value(item, value);
-	return ret;
 
 out_free:
 	free(key);
-	return -1;
+	return ret;
 }
 
 int perf_config_set__collect(struct perf_config_set *set, const char *file_name,
diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index e098e189f93e..6a64f713710d 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -14,6 +14,7 @@
 #include "data.h"
 #include "util.h"
 #include "debug.h"
+#include "header.h"
 
 static void close_dir(struct perf_data_file *files, int nr)
 {
@@ -34,12 +35,16 @@ int perf_data__create_dir(struct perf_data *data, int nr)
 	struct perf_data_file *files = NULL;
 	int i, ret = -1;
 
+	if (WARN_ON(!data->is_dir))
+		return -EINVAL;
+
 	files = zalloc(nr * sizeof(*files));
 	if (!files)
 		return -ENOMEM;
 
-	data->dir.files = files;
-	data->dir.nr    = nr;
+	data->dir.version = PERF_DIR_VERSION;
+	data->dir.files   = files;
+	data->dir.nr      = nr;
 
 	for (i = 0; i < nr; i++) {
 		struct perf_data_file *file = &files[i];
@@ -69,6 +74,13 @@ int perf_data__open_dir(struct perf_data *data)
 	DIR *dir;
 	int nr = 0;
 
+	if (WARN_ON(!data->is_dir))
+		return -EINVAL;
+
+	/* The version is provided by DIR_FORMAT feature. */
+	if (WARN_ON(data->dir.version != PERF_DIR_VERSION))
+		return -1;
+
 	dir = opendir(data->path);
 	if (!dir)
 		return -EINVAL;
@@ -118,6 +130,26 @@ int perf_data__open_dir(struct perf_data *data)
 	return ret;
 }
 
+int perf_data__update_dir(struct perf_data *data)
+{
+	int i;
+
+	if (WARN_ON(!data->is_dir))
+		return -EINVAL;
+
+	for (i = 0; i < data->dir.nr; i++) {
+		struct perf_data_file *file = &data->dir.files[i];
+		struct stat st;
+
+		if (fstat(file->fd, &st))
+			return -1;
+
+		file->size = st.st_size;
+	}
+
+	return 0;
+}
+
 static bool check_pipe(struct perf_data *data)
 {
 	struct stat st;
@@ -173,6 +205,16 @@ static int check_backup(struct perf_data *data)
 	return 0;
 }
 
+static bool is_dir(struct perf_data *data)
+{
+	struct stat st;
+
+	if (stat(data->path, &st))
+		return false;
+
+	return (st.st_mode & S_IFMT) == S_IFDIR;
+}
+
 static int open_file_read(struct perf_data *data)
 {
 	struct stat st;
@@ -254,6 +296,30 @@ static int open_file_dup(struct perf_data *data)
 	return open_file(data);
 }
 
+static int open_dir(struct perf_data *data)
+{
+	int ret;
+
+	/*
+	 * So far we open only the header, so we can read the data version and
+	 * layout.
+	 */
+	if (asprintf(&data->file.path, "%s/header", data->path) < 0)
+		return -1;
+
+	if (perf_data__is_write(data) &&
+	    mkdir(data->path, S_IRWXU) < 0)
+		return -1;
+
+	ret = open_file(data);
+
+	/* Cleanup whatever we managed to create so far. */
+	if (ret && perf_data__is_write(data))
+		rm_rf_perf_data(data->path);
+
+	return ret;
+}
+
 int perf_data__open(struct perf_data *data)
 {
 	if (check_pipe(data))
@@ -265,11 +331,18 @@ int perf_data__open(struct perf_data *data)
 	if (check_backup(data))
 		return -1;
 
-	return open_file_dup(data);
+	if (perf_data__is_read(data))
+		data->is_dir = is_dir(data);
+
+	return perf_data__is_dir(data) ?
+	       open_dir(data) : open_file_dup(data);
 }
 
 void perf_data__close(struct perf_data *data)
 {
+	if (perf_data__is_dir(data))
+		perf_data__close_dir(data);
+
 	zfree(&data->file.path);
 	close(data->file.fd);
 }
@@ -288,9 +361,9 @@ ssize_t perf_data__write(struct perf_data *data,
 
 int perf_data__switch(struct perf_data *data,
 			   const char *postfix,
-			   size_t pos, bool at_exit)
+			   size_t pos, bool at_exit,
+			   char **new_filepath)
 {
-	char *new_filepath;
 	int ret;
 
 	if (check_pipe(data))
@@ -298,15 +371,15 @@ int perf_data__switch(struct perf_data *data,
 	if (perf_data__is_read(data))
 		return -EINVAL;
 
-	if (asprintf(&new_filepath, "%s.%s", data->path, postfix) < 0)
+	if (asprintf(new_filepath, "%s.%s", data->path, postfix) < 0)
 		return -ENOMEM;
 
 	/*
 	 * Only fire a warning, don't return error, continue fill
 	 * original file.
 	 */
-	if (rename(data->path, new_filepath))
-		pr_warning("Failed to rename %s to %s\n", data->path, new_filepath);
+	if (rename(data->path, *new_filepath))
+		pr_warning("Failed to rename %s to %s\n", data->path, *new_filepath);
 
 	if (!at_exit) {
 		close(data->file.fd);
@@ -323,6 +396,22 @@ int perf_data__switch(struct perf_data *data,
 	}
 	ret = data->file.fd;
 out:
-	free(new_filepath);
 	return ret;
 }
+
+unsigned long perf_data__size(struct perf_data *data)
+{
+	u64 size = data->file.size;
+	int i;
+
+	if (!data->is_dir)
+		return size;
+
+	for (i = 0; i < data->dir.nr; i++) {
+		struct perf_data_file *file = &data->dir.files[i];
+
+		size += file->size;
+	}
+
+	return size;
+}
diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index 14b47be2bd69..259868a39019 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -19,10 +19,12 @@ struct perf_data {
 	const char		*path;
 	struct perf_data_file	 file;
 	bool			 is_pipe;
+	bool			 is_dir;
 	bool			 force;
 	enum perf_data_mode	 mode;
 
 	struct {
+		u64			 version;
 		struct perf_data_file	*files;
 		int			 nr;
 	} dir;
@@ -43,14 +45,14 @@ static inline int perf_data__is_pipe(struct perf_data *data)
 	return data->is_pipe;
 }
 
-static inline int perf_data__fd(struct perf_data *data)
+static inline bool perf_data__is_dir(struct perf_data *data)
 {
-	return data->file.fd;
+	return data->is_dir;
 }
 
-static inline unsigned long perf_data__size(struct perf_data *data)
+static inline int perf_data__fd(struct perf_data *data)
 {
-	return data->file.size;
+	return data->file.fd;
 }
 
 int perf_data__open(struct perf_data *data);
@@ -68,9 +70,11 @@ ssize_t perf_data_file__write(struct perf_data_file *file,
  */
 int perf_data__switch(struct perf_data *data,
 			   const char *postfix,
-			   size_t pos, bool at_exit);
+			   size_t pos, bool at_exit, char **new_filepath);
 
 int perf_data__create_dir(struct perf_data *data, int nr);
 int perf_data__open_dir(struct perf_data *data);
 void perf_data__close_dir(struct perf_data *data);
+int perf_data__update_dir(struct perf_data *data);
+unsigned long perf_data__size(struct perf_data *data);
 #endif /* __PERF_DATA_H */
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index ba58ba603b69..e059976d9d93 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -184,6 +184,7 @@ int dso__read_binary_type_filename(const struct dso *dso,
 	case DSO_BINARY_TYPE__KALLSYMS:
 	case DSO_BINARY_TYPE__GUEST_KALLSYMS:
 	case DSO_BINARY_TYPE__JAVA_JIT:
+	case DSO_BINARY_TYPE__BPF_PROG_INFO:
 	case DSO_BINARY_TYPE__NOT_FOUND:
 		ret = -1;
 		break;
@@ -1141,28 +1142,34 @@ void dso__set_short_name(struct dso *dso, const char *name, bool name_allocated)
 
 static void dso__set_basename(struct dso *dso)
 {
-       /*
-        * basename() may modify path buffer, so we must pass
-        * a copy.
-        */
-       char *base, *lname = strdup(dso->long_name);
+	char *base, *lname;
+	int tid;
 
-       if (!lname)
-               return;
-
-       /*
-        * basename() may return a pointer to internal
-        * storage which is reused in subsequent calls
-        * so copy the result.
-        */
-       base = strdup(basename(lname));
+	if (sscanf(dso->long_name, "/tmp/perf-%d.map", &tid) == 1) {
+		if (asprintf(&base, "[JIT] tid %d", tid) < 0)
+			return;
+	} else {
+	      /*
+	       * basename() may modify path buffer, so we must pass
+               * a copy.
+               */
+		lname = strdup(dso->long_name);
+		if (!lname)
+			return;
 
-       free(lname);
+		/*
+		 * basename() may return a pointer to internal
+		 * storage which is reused in subsequent calls
+		 * so copy the result.
+		 */
+		base = strdup(basename(lname));
 
-       if (!base)
-               return;
+		free(lname);
 
-       dso__set_short_name(dso, base, true);
+		if (!base)
+			return;
+	}
+	dso__set_short_name(dso, base, true);
 }
 
 int dso__name_len(const struct dso *dso)
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index bb417c54c25a..6e3f63781e51 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -14,6 +14,7 @@
 
 struct machine;
 struct map;
+struct perf_env;
 
 enum dso_binary_type {
 	DSO_BINARY_TYPE__KALLSYMS = 0,
@@ -35,6 +36,7 @@ enum dso_binary_type {
 	DSO_BINARY_TYPE__KCORE,
 	DSO_BINARY_TYPE__GUEST_KCORE,
 	DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO,
+	DSO_BINARY_TYPE__BPF_PROG_INFO,
 	DSO_BINARY_TYPE__NOT_FOUND,
 };
 
@@ -189,6 +191,12 @@ struct dso {
 		u64		 debug_frame_offset;
 		u64		 eh_frame_hdr_offset;
 	} data;
+	/* bpf prog information */
+	struct {
+		u32		id;
+		u32		sub_id;
+		struct perf_env	*env;
+	} bpf_prog;
 
 	union { /* Tool specific area */
 		void	 *priv;
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 4c23779e271a..c6351b557bb0 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -3,15 +3,163 @@
 #include "env.h"
 #include "sane_ctype.h"
 #include "util.h"
+#include "bpf-event.h"
 #include <errno.h>
 #include <sys/utsname.h>
+#include <bpf/libbpf.h>
 
 struct perf_env perf_env;
 
+void perf_env__insert_bpf_prog_info(struct perf_env *env,
+				    struct bpf_prog_info_node *info_node)
+{
+	__u32 prog_id = info_node->info_linear->info.id;
+	struct bpf_prog_info_node *node;
+	struct rb_node *parent = NULL;
+	struct rb_node **p;
+
+	down_write(&env->bpf_progs.lock);
+	p = &env->bpf_progs.infos.rb_node;
+
+	while (*p != NULL) {
+		parent = *p;
+		node = rb_entry(parent, struct bpf_prog_info_node, rb_node);
+		if (prog_id < node->info_linear->info.id) {
+			p = &(*p)->rb_left;
+		} else if (prog_id > node->info_linear->info.id) {
+			p = &(*p)->rb_right;
+		} else {
+			pr_debug("duplicated bpf prog info %u\n", prog_id);
+			goto out;
+		}
+	}
+
+	rb_link_node(&info_node->rb_node, parent, p);
+	rb_insert_color(&info_node->rb_node, &env->bpf_progs.infos);
+	env->bpf_progs.infos_cnt++;
+out:
+	up_write(&env->bpf_progs.lock);
+}
+
+struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
+							__u32 prog_id)
+{
+	struct bpf_prog_info_node *node = NULL;
+	struct rb_node *n;
+
+	down_read(&env->bpf_progs.lock);
+	n = env->bpf_progs.infos.rb_node;
+
+	while (n) {
+		node = rb_entry(n, struct bpf_prog_info_node, rb_node);
+		if (prog_id < node->info_linear->info.id)
+			n = n->rb_left;
+		else if (prog_id > node->info_linear->info.id)
+			n = n->rb_right;
+		else
+			break;
+	}
+
+	up_read(&env->bpf_progs.lock);
+	return node;
+}
+
+void perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node)
+{
+	struct rb_node *parent = NULL;
+	__u32 btf_id = btf_node->id;
+	struct btf_node *node;
+	struct rb_node **p;
+
+	down_write(&env->bpf_progs.lock);
+	p = &env->bpf_progs.btfs.rb_node;
+
+	while (*p != NULL) {
+		parent = *p;
+		node = rb_entry(parent, struct btf_node, rb_node);
+		if (btf_id < node->id) {
+			p = &(*p)->rb_left;
+		} else if (btf_id > node->id) {
+			p = &(*p)->rb_right;
+		} else {
+			pr_debug("duplicated btf %u\n", btf_id);
+			goto out;
+		}
+	}
+
+	rb_link_node(&btf_node->rb_node, parent, p);
+	rb_insert_color(&btf_node->rb_node, &env->bpf_progs.btfs);
+	env->bpf_progs.btfs_cnt++;
+out:
+	up_write(&env->bpf_progs.lock);
+}
+
+struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id)
+{
+	struct btf_node *node = NULL;
+	struct rb_node *n;
+
+	down_read(&env->bpf_progs.lock);
+	n = env->bpf_progs.btfs.rb_node;
+
+	while (n) {
+		node = rb_entry(n, struct btf_node, rb_node);
+		if (btf_id < node->id)
+			n = n->rb_left;
+		else if (btf_id > node->id)
+			n = n->rb_right;
+		else
+			break;
+	}
+
+	up_read(&env->bpf_progs.lock);
+	return node;
+}
+
+/* purge data in bpf_progs.infos tree */
+static void perf_env__purge_bpf(struct perf_env *env)
+{
+	struct rb_root *root;
+	struct rb_node *next;
+
+	down_write(&env->bpf_progs.lock);
+
+	root = &env->bpf_progs.infos;
+	next = rb_first(root);
+
+	while (next) {
+		struct bpf_prog_info_node *node;
+
+		node = rb_entry(next, struct bpf_prog_info_node, rb_node);
+		next = rb_next(&node->rb_node);
+		rb_erase(&node->rb_node, root);
+		free(node);
+	}
+
+	env->bpf_progs.infos_cnt = 0;
+
+	root = &env->bpf_progs.btfs;
+	next = rb_first(root);
+
+	while (next) {
+		struct btf_node *node;
+
+		node = rb_entry(next, struct btf_node, rb_node);
+		next = rb_next(&node->rb_node);
+		rb_erase(&node->rb_node, root);
+		free(node);
+	}
+
+	env->bpf_progs.btfs_cnt = 0;
+
+	up_write(&env->bpf_progs.lock);
+}
+
 void perf_env__exit(struct perf_env *env)
 {
 	int i;
 
+	perf_env__purge_bpf(env);
 	zfree(&env->hostname);
 	zfree(&env->os_release);
 	zfree(&env->version);
@@ -38,6 +186,13 @@ void perf_env__exit(struct perf_env *env)
 	zfree(&env->memory_nodes);
 }
 
+void perf_env__init(struct perf_env *env)
+{
+	env->bpf_progs.infos = RB_ROOT;
+	env->bpf_progs.btfs = RB_ROOT;
+	init_rwsem(&env->bpf_progs.lock);
+}
+
 int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[])
 {
 	int i;
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index d01b8355f4ca..4f8e2b485c01 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -3,7 +3,9 @@
 #define __PERF_ENV_H
 
 #include <linux/types.h>
+#include <linux/rbtree.h>
 #include "cpumap.h"
+#include "rwsem.h"
 
 struct cpu_topology_map {
 	int	socket_id;
@@ -64,8 +66,23 @@ struct perf_env {
 	struct memory_node	*memory_nodes;
 	unsigned long long	 memory_bsize;
 	u64                     clockid_res_ns;
+
+	/*
+	 * bpf_info_lock protects bpf rbtrees. This is needed because the
+	 * trees are accessed by different threads in perf-top
+	 */
+	struct {
+		struct rw_semaphore	lock;
+		struct rb_root		infos;
+		u32			infos_cnt;
+		struct rb_root		btfs;
+		u32			btfs_cnt;
+	} bpf_progs;
 };
 
+struct bpf_prog_info_node;
+struct btf_node;
+
 extern struct perf_env perf_env;
 
 void perf_env__exit(struct perf_env *env);
@@ -80,4 +97,11 @@ const char *perf_env__arch(struct perf_env *env);
 const char *perf_env__raw_arch(struct perf_env *env);
 int perf_env__nr_cpus_avail(struct perf_env *env);
 
+void perf_env__init(struct perf_env *env);
+void perf_env__insert_bpf_prog_info(struct perf_env *env,
+				    struct bpf_prog_info_node *info_node);
+struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
+							__u32 prog_id);
+void perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node);
+struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id);
 #endif /* __PERF_ENV_H */
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index ed20f4379956..ec78e93085de 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -19,6 +19,7 @@
 #include "debug.h"
 #include "units.h"
 #include "asm/bug.h"
+#include "bpf-event.h"
 #include <signal.h>
 #include <unistd.h>
 
@@ -1856,3 +1857,121 @@ struct perf_evsel *perf_evlist__reset_weak_group(struct perf_evlist *evsel_list,
 	}
 	return leader;
 }
+
+int perf_evlist__add_sb_event(struct perf_evlist **evlist,
+			      struct perf_event_attr *attr,
+			      perf_evsel__sb_cb_t cb,
+			      void *data)
+{
+	struct perf_evsel *evsel;
+	bool new_evlist = (*evlist) == NULL;
+
+	if (*evlist == NULL)
+		*evlist = perf_evlist__new();
+	if (*evlist == NULL)
+		return -1;
+
+	if (!attr->sample_id_all) {
+		pr_warning("enabling sample_id_all for all side band events\n");
+		attr->sample_id_all = 1;
+	}
+
+	evsel = perf_evsel__new_idx(attr, (*evlist)->nr_entries);
+	if (!evsel)
+		goto out_err;
+
+	evsel->side_band.cb = cb;
+	evsel->side_band.data = data;
+	perf_evlist__add(*evlist, evsel);
+	return 0;
+
+out_err:
+	if (new_evlist) {
+		perf_evlist__delete(*evlist);
+		*evlist = NULL;
+	}
+	return -1;
+}
+
+static void *perf_evlist__poll_thread(void *arg)
+{
+	struct perf_evlist *evlist = arg;
+	bool draining = false;
+	int i;
+
+	while (draining || !(evlist->thread.done)) {
+		if (draining)
+			draining = false;
+		else if (evlist->thread.done)
+			draining = true;
+
+		if (!draining)
+			perf_evlist__poll(evlist, 1000);
+
+		for (i = 0; i < evlist->nr_mmaps; i++) {
+			struct perf_mmap *map = &evlist->mmap[i];
+			union perf_event *event;
+
+			if (perf_mmap__read_init(map))
+				continue;
+			while ((event = perf_mmap__read_event(map)) != NULL) {
+				struct perf_evsel *evsel = perf_evlist__event2evsel(evlist, event);
+
+				if (evsel && evsel->side_band.cb)
+					evsel->side_band.cb(event, evsel->side_band.data);
+				else
+					pr_warning("cannot locate proper evsel for the side band event\n");
+
+				perf_mmap__consume(map);
+			}
+			perf_mmap__read_done(map);
+		}
+	}
+	return NULL;
+}
+
+int perf_evlist__start_sb_thread(struct perf_evlist *evlist,
+				 struct target *target)
+{
+	struct perf_evsel *counter;
+
+	if (!evlist)
+		return 0;
+
+	if (perf_evlist__create_maps(evlist, target))
+		goto out_delete_evlist;
+
+	evlist__for_each_entry(evlist, counter) {
+		if (perf_evsel__open(counter, evlist->cpus,
+				     evlist->threads) < 0)
+			goto out_delete_evlist;
+	}
+
+	if (perf_evlist__mmap(evlist, UINT_MAX))
+		goto out_delete_evlist;
+
+	evlist__for_each_entry(evlist, counter) {
+		if (perf_evsel__enable(counter))
+			goto out_delete_evlist;
+	}
+
+	evlist->thread.done = 0;
+	if (pthread_create(&evlist->thread.th, NULL, perf_evlist__poll_thread, evlist))
+		goto out_delete_evlist;
+
+	return 0;
+
+out_delete_evlist:
+	perf_evlist__delete(evlist);
+	evlist = NULL;
+	return -1;
+}
+
+void perf_evlist__stop_sb_thread(struct perf_evlist *evlist)
+{
+	if (!evlist)
+		return;
+	evlist->thread.done = 1;
+	pthread_join(evlist->thread.th, NULL);
+	perf_evlist__delete(evlist);
+}
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 744906dd4887..dcb68f34d2cd 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -54,6 +54,10 @@ struct perf_evlist {
 				       struct perf_sample *sample);
 	u64		first_sample_time;
 	u64		last_sample_time;
+	struct {
+		pthread_t		th;
+		volatile int		done;
+	} thread;
 };
 
 struct perf_evsel_str_handler {
@@ -87,6 +91,14 @@ int __perf_evlist__add_default_attrs(struct perf_evlist *evlist,
 
 int perf_evlist__add_dummy(struct perf_evlist *evlist);
 
+int perf_evlist__add_sb_event(struct perf_evlist **evlist,
+			      struct perf_event_attr *attr,
+			      perf_evsel__sb_cb_t cb,
+			      void *data);
+int perf_evlist__start_sb_thread(struct perf_evlist *evlist,
+				 struct target *target);
+void perf_evlist__stop_sb_thread(struct perf_evlist *evlist);
+
 int perf_evlist__add_newtp(struct perf_evlist *evlist,
 			   const char *sys, const char *name, void *handler);
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 3bbf73e979c0..7835e05f0c0a 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1036,7 +1036,7 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 	attr->mmap2 = track && !perf_missing_features.mmap2;
 	attr->comm  = track;
 	attr->ksymbol = track && !perf_missing_features.ksymbol;
-	attr->bpf_event = track && opts->bpf_event &&
+	attr->bpf_event = track && !opts->no_bpf_event &&
 		!perf_missing_features.bpf_event;
 
 	if (opts->record_namespaces)
@@ -1292,6 +1292,7 @@ void perf_evsel__exit(struct perf_evsel *evsel)
 {
 	assert(list_empty(&evsel->node));
 	assert(evsel->evlist == NULL);
+	perf_evsel__free_counts(evsel);
 	perf_evsel__free_fd(evsel);
 	perf_evsel__free_id(evsel);
 	perf_evsel__free_config_terms(evsel);
@@ -1342,10 +1343,9 @@ void perf_counts_values__scale(struct perf_counts_values *count,
 			count->val = 0;
 		} else if (count->run < count->ena) {
 			scaled = 1;
-			count->val = (u64)((double) count->val * count->ena / count->run + 0.5);
+			count->val = (u64)((double) count->val * count->ena / count->run);
 		}
-	} else
-		count->ena = count->run = 0;
+	}
 
 	if (pscaled)
 		*pscaled = scaled;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index cc578e02e08f..0f2c6c93d721 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -73,6 +73,8 @@ struct perf_evsel_config_term {
 
 struct perf_stat_evsel;
 
+typedef int (perf_evsel__sb_cb_t)(union perf_event *event, void *data);
+
 /** struct perf_evsel - event selector
  *
  * @evlist - evlist this evsel is in, if it is in one.
@@ -151,6 +153,10 @@ struct perf_evsel {
 	bool			collect_stat;
 	bool			weak_group;
 	const char		*pmu_name;
+	struct {
+		perf_evsel__sb_cb_t	*cb;
+		void			*data;
+	} side_band;
 };
 
 union u64_swap {
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 01b324c275b9..b9e693825873 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -18,6 +18,7 @@
 #include <sys/utsname.h>
 #include <linux/time64.h>
 #include <dirent.h>
+#include <bpf/libbpf.h>
 
 #include "evlist.h"
 #include "evsel.h"
@@ -40,6 +41,7 @@
 #include "time-utils.h"
 #include "units.h"
 #include "cputopo.h"
+#include "bpf-event.h"
 
 #include "sane_ctype.h"
 
@@ -861,6 +863,104 @@ static int write_clockid(struct feat_fd *ff,
 			sizeof(ff->ph->env.clockid_res_ns));
 }
 
+static int write_dir_format(struct feat_fd *ff,
+			    struct perf_evlist *evlist __maybe_unused)
+{
+	struct perf_session *session;
+	struct perf_data *data;
+
+	session = container_of(ff->ph, struct perf_session, header);
+	data = session->data;
+
+	if (WARN_ON(!perf_data__is_dir(data)))
+		return -1;
+
+	return do_write(ff, &data->dir.version, sizeof(data->dir.version));
+}
+
+#ifdef HAVE_LIBBPF_SUPPORT
+static int write_bpf_prog_info(struct feat_fd *ff,
+			       struct perf_evlist *evlist __maybe_unused)
+{
+	struct perf_env *env = &ff->ph->env;
+	struct rb_root *root;
+	struct rb_node *next;
+	int ret;
+
+	down_read(&env->bpf_progs.lock);
+
+	ret = do_write(ff, &env->bpf_progs.infos_cnt,
+		       sizeof(env->bpf_progs.infos_cnt));
+	if (ret < 0)
+		goto out;
+
+	root = &env->bpf_progs.infos;
+	next = rb_first(root);
+	while (next) {
+		struct bpf_prog_info_node *node;
+		size_t len;
+
+		node = rb_entry(next, struct bpf_prog_info_node, rb_node);
+		next = rb_next(&node->rb_node);
+		len = sizeof(struct bpf_prog_info_linear) +
+			node->info_linear->data_len;
+
+		/* before writing to file, translate address to offset */
+		bpf_program__bpil_addr_to_offs(node->info_linear);
+		ret = do_write(ff, node->info_linear, len);
+		/*
+		 * translate back to address even when do_write() fails,
+		 * so that this function never changes the data.
+		 */
+		bpf_program__bpil_offs_to_addr(node->info_linear);
+		if (ret < 0)
+			goto out;
+	}
+out:
+	up_read(&env->bpf_progs.lock);
+	return ret;
+}
+#else // HAVE_LIBBPF_SUPPORT
+static int write_bpf_prog_info(struct feat_fd *ff __maybe_unused,
+			       struct perf_evlist *evlist __maybe_unused)
+{
+	return 0;
+}
+#endif // HAVE_LIBBPF_SUPPORT
+
+static int write_bpf_btf(struct feat_fd *ff,
+			 struct perf_evlist *evlist __maybe_unused)
+{
+	struct perf_env *env = &ff->ph->env;
+	struct rb_root *root;
+	struct rb_node *next;
+	int ret;
+
+	down_read(&env->bpf_progs.lock);
+
+	ret = do_write(ff, &env->bpf_progs.btfs_cnt,
+		       sizeof(env->bpf_progs.btfs_cnt));
+
+	if (ret < 0)
+		goto out;
+
+	root = &env->bpf_progs.btfs;
+	next = rb_first(root);
+	while (next) {
+		struct btf_node *node;
+
+		node = rb_entry(next, struct btf_node, rb_node);
+		next = rb_next(&node->rb_node);
+		ret = do_write(ff, &node->id,
+			       sizeof(u32) * 2 + node->data_size);
+		if (ret < 0)
+			goto out;
+	}
+out:
+	up_read(&env->bpf_progs.lock);
+	return ret;
+}
+
 static int cpu_cache_level__sort(const void *a, const void *b)
 {
 	struct cpu_cache_level *cache_a = (struct cpu_cache_level *)a;
@@ -1341,6 +1441,63 @@ static void print_clockid(struct feat_fd *ff, FILE *fp)
 		ff->ph->env.clockid_res_ns * 1000);
 }
 
+static void print_dir_format(struct feat_fd *ff, FILE *fp)
+{
+	struct perf_session *session;
+	struct perf_data *data;
+
+	session = container_of(ff->ph, struct perf_session, header);
+	data = session->data;
+
+	fprintf(fp, "# directory data version : %"PRIu64"\n", data->dir.version);
+}
+
+static void print_bpf_prog_info(struct feat_fd *ff, FILE *fp)
+{
+	struct perf_env *env = &ff->ph->env;
+	struct rb_root *root;
+	struct rb_node *next;
+
+	down_read(&env->bpf_progs.lock);
+
+	root = &env->bpf_progs.infos;
+	next = rb_first(root);
+
+	while (next) {
+		struct bpf_prog_info_node *node;
+
+		node = rb_entry(next, struct bpf_prog_info_node, rb_node);
+		next = rb_next(&node->rb_node);
+
+		bpf_event__print_bpf_prog_info(&node->info_linear->info,
+					       env, fp);
+	}
+
+	up_read(&env->bpf_progs.lock);
+}
+
+static void print_bpf_btf(struct feat_fd *ff, FILE *fp)
+{
+	struct perf_env *env = &ff->ph->env;
+	struct rb_root *root;
+	struct rb_node *next;
+
+	down_read(&env->bpf_progs.lock);
+
+	root = &env->bpf_progs.btfs;
+	next = rb_first(root);
+
+	while (next) {
+		struct btf_node *node;
+
+		node = rb_entry(next, struct btf_node, rb_node);
+		next = rb_next(&node->rb_node);
+		fprintf(fp, "# btf info of id %u\n", node->id);
+	}
+
+	up_read(&env->bpf_progs.lock);
+}
+
 static void free_event_desc(struct perf_evsel *events)
 {
 	struct perf_evsel *evsel;
@@ -2373,6 +2530,139 @@ static int process_clockid(struct feat_fd *ff,
 	return 0;
 }
 
+static int process_dir_format(struct feat_fd *ff,
+			      void *_data __maybe_unused)
+{
+	struct perf_session *session;
+	struct perf_data *data;
+
+	session = container_of(ff->ph, struct perf_session, header);
+	data = session->data;
+
+	if (WARN_ON(!perf_data__is_dir(data)))
+		return -1;
+
+	return do_read_u64(ff, &data->dir.version);
+}
+
+#ifdef HAVE_LIBBPF_SUPPORT
+static int process_bpf_prog_info(struct feat_fd *ff, void *data __maybe_unused)
+{
+	struct bpf_prog_info_linear *info_linear;
+	struct bpf_prog_info_node *info_node;
+	struct perf_env *env = &ff->ph->env;
+	u32 count, i;
+	int err = -1;
+
+	if (ff->ph->needs_swap) {
+		pr_warning("interpreting bpf_prog_info from systems with endianity is not yet supported\n");
+		return 0;
+	}
+
+	if (do_read_u32(ff, &count))
+		return -1;
+
+	down_write(&env->bpf_progs.lock);
+
+	for (i = 0; i < count; ++i) {
+		u32 info_len, data_len;
+
+		info_linear = NULL;
+		info_node = NULL;
+		if (do_read_u32(ff, &info_len))
+			goto out;
+		if (do_read_u32(ff, &data_len))
+			goto out;
+
+		if (info_len > sizeof(struct bpf_prog_info)) {
+			pr_warning("detected invalid bpf_prog_info\n");
+			goto out;
+		}
+
+		info_linear = malloc(sizeof(struct bpf_prog_info_linear) +
+				     data_len);
+		if (!info_linear)
+			goto out;
+		info_linear->info_len = sizeof(struct bpf_prog_info);
+		info_linear->data_len = data_len;
+		if (do_read_u64(ff, (u64 *)(&info_linear->arrays)))
+			goto out;
+		if (__do_read(ff, &info_linear->info, info_len))
+			goto out;
+		if (info_len < sizeof(struct bpf_prog_info))
+			memset(((void *)(&info_linear->info)) + info_len, 0,
+			       sizeof(struct bpf_prog_info) - info_len);
+
+		if (__do_read(ff, info_linear->data, data_len))
+			goto out;
+
+		info_node = malloc(sizeof(struct bpf_prog_info_node));
+		if (!info_node)
+			goto out;
+
+		/* after reading from file, translate offset to address */
+		bpf_program__bpil_offs_to_addr(info_linear);
+		info_node->info_linear = info_linear;
+		perf_env__insert_bpf_prog_info(env, info_node);
+	}
+
+	return 0;
+out:
+	free(info_linear);
+	free(info_node);
+	up_write(&env->bpf_progs.lock);
+	return err;
+}
+#else // HAVE_LIBBPF_SUPPORT
+static int process_bpf_prog_info(struct feat_fd *ff __maybe_unused, void *data __maybe_unused)
+{
+	return 0;
+}
+#endif // HAVE_LIBBPF_SUPPORT
+
+static int process_bpf_btf(struct feat_fd *ff, void *data __maybe_unused)
+{
+	struct perf_env *env = &ff->ph->env;
+	u32 count, i;
+
+	if (ff->ph->needs_swap) {
+		pr_warning("interpreting btf from systems with endianity is not yet supported\n");
+		return 0;
+	}
+
+	if (do_read_u32(ff, &count))
+		return -1;
+
+	down_write(&env->bpf_progs.lock);
+
+	for (i = 0; i < count; ++i) {
+		struct btf_node *node;
+		u32 id, data_size;
+
+		if (do_read_u32(ff, &id))
+			return -1;
+		if (do_read_u32(ff, &data_size))
+			return -1;
+
+		node = malloc(sizeof(struct btf_node) + data_size);
+		if (!node)
+			return -1;
+
+		node->id = id;
+		node->data_size = data_size;
+
+		if (__do_read(ff, node->data, data_size)) {
+			free(node);
+			return -1;
+		}
+
+		perf_env__insert_btf(env, node);
+	}
+
+	up_write(&env->bpf_progs.lock);
+	return 0;
+}
+
 struct feature_ops {
 	int (*write)(struct feat_fd *ff, struct perf_evlist *evlist);
 	void (*print)(struct feat_fd *ff, FILE *fp);
@@ -2432,7 +2722,10 @@ static const struct feature_ops feat_ops[HEADER_LAST_FEATURE] = {
 	FEAT_OPN(CACHE,		cache,		true),
 	FEAT_OPR(SAMPLE_TIME,	sample_time,	false),
 	FEAT_OPR(MEM_TOPOLOGY,	mem_topology,	true),
-	FEAT_OPR(CLOCKID,       clockid,        false)
+	FEAT_OPR(CLOCKID,	clockid,	false),
+	FEAT_OPN(DIR_FORMAT,	dir_format,	false),
+	FEAT_OPR(BPF_PROG_INFO, bpf_prog_info,  false),
+	FEAT_OPR(BPF_BTF,       bpf_btf,        false),
 };
 
 struct header_print_data {
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 0d553ddca0a3..386da49e1bfa 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -39,6 +39,9 @@ enum {
 	HEADER_SAMPLE_TIME,
 	HEADER_MEM_TOPOLOGY,
 	HEADER_CLOCKID,
+	HEADER_DIR_FORMAT,
+	HEADER_BPF_PROG_INFO,
+	HEADER_BPF_BTF,
 	HEADER_LAST_FEATURE,
 	HEADER_FEAT_BITS	= 256,
 };
@@ -48,6 +51,10 @@ enum perf_header_version {
 	PERF_HEADER_VERSION_2,
 };
 
+enum perf_dir_version {
+	PERF_DIR_VERSION	= 1,
+};
+
 struct perf_file_section {
 	u64 offset;
 	u64 size;
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index f9eb95bf3938..7ace7a10054d 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -19,6 +19,7 @@
 #include <math.h>
 #include <inttypes.h>
 #include <sys/param.h>
+#include <linux/time64.h>
 
 static bool hists__filter_entry_by_dso(struct hists *hists,
 				       struct hist_entry *he);
@@ -192,6 +193,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 	hists__new_col_len(hists, HISTC_MEM_LVL, 21 + 3);
 	hists__new_col_len(hists, HISTC_LOCAL_WEIGHT, 12);
 	hists__new_col_len(hists, HISTC_GLOBAL_WEIGHT, 12);
+	hists__new_col_len(hists, HISTC_TIME, 12);
 
 	if (h->srcline) {
 		len = MAX(strlen(h->srcline), strlen(sort_srcline.se_header));
@@ -246,6 +248,14 @@ static void he_stat__add_cpumode_period(struct he_stat *he_stat,
 	}
 }
 
+static long hist_time(unsigned long htime)
+{
+	unsigned long time_quantum = symbol_conf.time_quantum;
+	if (time_quantum)
+		return (htime / time_quantum) * time_quantum;
+	return htime;
+}
+
 static void he_stat__add_period(struct he_stat *he_stat, u64 period,
 				u64 weight)
 {
@@ -426,6 +436,13 @@ static int hist_entry__init(struct hist_entry *he,
 			goto err_rawdata;
 	}
 
+	if (symbol_conf.res_sample) {
+		he->res_samples = calloc(sizeof(struct res_sample),
+					symbol_conf.res_sample);
+		if (!he->res_samples)
+			goto err_srcline;
+	}
+
 	INIT_LIST_HEAD(&he->pairs.node);
 	thread__get(he->thread);
 	he->hroot_in  = RB_ROOT_CACHED;
@@ -436,6 +453,9 @@ static int hist_entry__init(struct hist_entry *he,
 
 	return 0;
 
+err_srcline:
+	free(he->srcline);
+
 err_rawdata:
 	free(he->raw_data);
 
@@ -593,6 +613,32 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
 	return he;
 }
 
+static unsigned random_max(unsigned high)
+{
+	unsigned thresh = -high % high;
+	for (;;) {
+		unsigned r = random();
+		if (r >= thresh)
+			return r % high;
+	}
+}
+
+static void hists__res_sample(struct hist_entry *he, struct perf_sample *sample)
+{
+	struct res_sample *r;
+	int j;
+
+	if (he->num_res < symbol_conf.res_sample) {
+		j = he->num_res++;
+	} else {
+		j = random_max(symbol_conf.res_sample);
+	}
+	r = &he->res_samples[j];
+	r->time = sample->time;
+	r->cpu = sample->cpu;
+	r->tid = sample->tid;
+}
+
 static struct hist_entry*
 __hists__add_entry(struct hists *hists,
 		   struct addr_location *al,
@@ -635,10 +681,13 @@ __hists__add_entry(struct hists *hists,
 		.raw_data = sample->raw_data,
 		.raw_size = sample->raw_size,
 		.ops = ops,
+		.time = hist_time(sample->time),
 	}, *he = hists__findnew_entry(hists, &entry, al, sample_self);
 
 	if (!hists->has_callchains && he && he->callchain_size != 0)
 		hists->has_callchains = true;
+	if (he && symbol_conf.res_sample)
+		hists__res_sample(he, sample);
 	return he;
 }
 
@@ -1062,8 +1111,10 @@ int hist_entry_iter__add(struct hist_entry_iter *iter, struct addr_location *al,
 
 	err = sample__resolve_callchain(iter->sample, &callchain_cursor, &iter->parent,
 					iter->evsel, al, max_stack_depth);
-	if (err)
+	if (err) {
+		map__put(alm);
 		return err;
+	}
 
 	err = iter->ops->prepare_entry(iter, al);
 	if (err)
@@ -1162,6 +1213,7 @@ void hist_entry__delete(struct hist_entry *he)
 		mem_info__zput(he->mem_info);
 	}
 
+	zfree(&he->res_samples);
 	zfree(&he->stat_acc);
 	free_srcline(he->srcline);
 	if (he->srcfile && he->srcfile[0])
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 4af27fbab24f..76ff6c6d03b8 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -31,6 +31,7 @@ enum hist_filter {
 
 enum hist_column {
 	HISTC_SYMBOL,
+	HISTC_TIME,
 	HISTC_DSO,
 	HISTC_THREAD,
 	HISTC_COMM,
@@ -432,9 +433,18 @@ struct hist_browser_timer {
 };
 
 struct annotation_options;
+struct res_sample;
+
+enum rstype {
+	A_NORMAL,
+	A_ASM,
+	A_SOURCE
+};
 
 #ifdef HAVE_SLANG_SUPPORT
 #include "../ui/keysyms.h"
+void attr_to_script(char *buf, struct perf_event_attr *attr);
+
 int map_symbol__tui_annotate(struct map_symbol *ms, struct perf_evsel *evsel,
 			     struct hist_browser_timer *hbt,
 			     struct annotation_options *annotation_opts);
@@ -449,7 +459,13 @@ int perf_evlist__tui_browse_hists(struct perf_evlist *evlist, const char *help,
 				  struct perf_env *env,
 				  bool warn_lost_event,
 				  struct annotation_options *annotation_options);
-int script_browse(const char *script_opt);
+
+int script_browse(const char *script_opt, struct perf_evsel *evsel);
+
+void run_script(char *cmd);
+int res_sample_browse(struct res_sample *res_samples, int num_res,
+		      struct perf_evsel *evsel, enum rstype rstype);
+void res_sample_init(void);
 #else
 static inline
 int perf_evlist__tui_browse_hists(struct perf_evlist *evlist __maybe_unused,
@@ -478,11 +494,22 @@ static inline int hist_entry__tui_annotate(struct hist_entry *he __maybe_unused,
 	return 0;
 }
 
-static inline int script_browse(const char *script_opt __maybe_unused)
+static inline int script_browse(const char *script_opt __maybe_unused,
+				struct perf_evsel *evsel __maybe_unused)
 {
 	return 0;
 }
 
+static inline int res_sample_browse(struct res_sample *res_samples __maybe_unused,
+				    int num_res __maybe_unused,
+				    struct perf_evsel *evsel __maybe_unused,
+				    enum rstype rstype __maybe_unused)
+{
+	return 0;
+}
+
+static inline void res_sample_init(void) {}
+
 #define K_LEFT  -1000
 #define K_RIGHT -2000
 #define K_SWITCH_INPUT_DATA -3000
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index fbeb0c6efaa6..e32628cd20a7 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -577,10 +577,25 @@ static void __maps__purge(struct maps *maps)
 	}
 }
 
+static void __maps__purge_names(struct maps *maps)
+{
+	struct rb_root *root = &maps->names;
+	struct rb_node *next = rb_first(root);
+
+	while (next) {
+		struct map *pos = rb_entry(next, struct map, rb_node_name);
+
+		next = rb_next(&pos->rb_node_name);
+		rb_erase_init(&pos->rb_node_name, root);
+		map__put(pos);
+	}
+}
+
 static void maps__exit(struct maps *maps)
 {
 	down_write(&maps->lock);
 	__maps__purge(maps);
+	__maps__purge_names(maps);
 	up_write(&maps->lock);
 }
 
@@ -917,6 +932,9 @@ static void __maps__remove(struct maps *maps, struct map *map)
 {
 	rb_erase_init(&map->rb_node, &maps->entries);
 	map__put(map);
+
+	rb_erase_init(&map->rb_node_name, &maps->names);
+	map__put(map);
 }
 
 void maps__remove(struct maps *maps, struct map *map)
diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index ea523d3b248f..989fed6f43b5 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -270,6 +270,8 @@ static int __ordered_events__flush(struct ordered_events *oe, enum oe_flush how,
 		"FINAL",
 		"ROUND",
 		"HALF ",
+		"TOP  ",
+		"TIME ",
 	};
 	int err;
 	bool show_progress = false;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 4dcc01b2532c..5ef4939408f2 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2271,6 +2271,7 @@ static bool is_event_supported(u8 type, unsigned config)
 		perf_evsel__delete(evsel);
 	}
 
+	thread_map__put(tmap);
 	return ret;
 }
 
@@ -2341,6 +2342,7 @@ void print_sdt_events(const char *subsys_glob, const char *event_glob,
 				printf("  %-50s [%s]\n", buf, "SDT event");
 				free(buf);
 			}
+			free(path);
 		} else
 			printf("  %-50s [%s]\n", nd->s, "SDT event");
 		if (nd2) {
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index a1b8d9649ca7..198e09ff611e 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -160,8 +160,10 @@ static struct map *kernel_get_module_map(const char *module)
 	if (module && strchr(module, '/'))
 		return dso__new_map(module);
 
-	if (!module)
-		module = "kernel";
+	if (!module) {
+		pos = machine__kernel_map(host_machine);
+		return map__get(pos);
+	}
 
 	for (pos = maps__first(maps); pos; pos = map__next(pos)) {
 		/* short_name is "[module]" */
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index db643f3c2b95..b17f1c9bc965 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -132,6 +132,7 @@ struct perf_session *perf_session__new(struct perf_data *data,
 	ordered_events__init(&session->ordered_events,
 			     ordered_events__deliver_event, NULL);
 
+	perf_env__init(&session->header.env);
 	if (data) {
 		if (perf_data__open(data))
 			goto out_delete;
@@ -152,6 +153,10 @@ struct perf_session *perf_session__new(struct perf_data *data,
 			}
 
 			perf_evlist__init_trace_event_sample_raw(session->evlist);
+
+			/* Open the directory data. */
+			if (data->is_dir && perf_data__open_dir(data))
+				goto out_delete;
 		}
 	} else  {
 		session->machines.host.env = &perf_env;
@@ -1843,10 +1848,17 @@ fetch_mmaped_event(struct perf_session *session,
 #define NUM_MMAPS 128
 #endif
 
+struct reader;
+
+typedef s64 (*reader_cb_t)(struct perf_session *session,
+			   union perf_event *event,
+			   u64 file_offset);
+
 struct reader {
-	int	fd;
-	u64	data_size;
-	u64	data_offset;
+	int		 fd;
+	u64		 data_size;
+	u64		 data_offset;
+	reader_cb_t	 process;
 };
 
 static int
@@ -1917,7 +1929,7 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 	size = event->header.size;
 
 	if (size < sizeof(struct perf_event_header) ||
-	    (skip = perf_session__process_event(session, event, file_pos)) < 0) {
+	    (skip = rd->process(session, event, file_pos)) < 0) {
 		pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
 		       file_offset + head, event->header.size,
 		       event->header.type);
@@ -1943,12 +1955,20 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 	return err;
 }
 
+static s64 process_simple(struct perf_session *session,
+			  union perf_event *event,
+			  u64 file_offset)
+{
+	return perf_session__process_event(session, event, file_offset);
+}
+
 static int __perf_session__process_events(struct perf_session *session)
 {
 	struct reader rd = {
 		.fd		= perf_data__fd(session->data),
 		.data_size	= session->header.data_size,
 		.data_offset	= session->header.data_offset,
+		.process	= process_simple,
 	};
 	struct ordered_events *oe = &session->ordered_events;
 	struct perf_tool *tool = session->tool;
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index d2299e912e59..5d2518e89fc4 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -3,6 +3,7 @@
 #include <inttypes.h>
 #include <regex.h>
 #include <linux/mman.h>
+#include <linux/time64.h>
 #include "sort.h"
 #include "hist.h"
 #include "comm.h"
@@ -12,9 +13,11 @@
 #include "evsel.h"
 #include "evlist.h"
 #include "strlist.h"
+#include "strbuf.h"
 #include <traceevent/event-parse.h>
 #include "mem-events.h"
 #include "annotate.h"
+#include "time-utils.h"
 #include <linux/kernel.h>
 
 regex_t		parent_regex;
@@ -654,6 +657,42 @@ struct sort_entry sort_socket = {
 	.se_width_idx	= HISTC_SOCKET,
 };
 
+/* --sort time */
+
+static int64_t
+sort__time_cmp(struct hist_entry *left, struct hist_entry *right)
+{
+	return right->time - left->time;
+}
+
+static int hist_entry__time_snprintf(struct hist_entry *he, char *bf,
+				    size_t size, unsigned int width)
+{
+	unsigned long secs;
+	unsigned long long nsecs;
+	char he_time[32];
+
+	nsecs = he->time;
+	secs = nsecs / NSEC_PER_SEC;
+	nsecs -= secs * NSEC_PER_SEC;
+
+	if (symbol_conf.nanosecs)
+		snprintf(he_time, sizeof he_time, "%5lu.%09llu: ",
+			 secs, nsecs);
+	else
+		timestamp__scnprintf_usec(he->time, he_time,
+					  sizeof(he_time));
+
+	return repsep_snprintf(bf, size, "%-.*s", width, he_time);
+}
+
+struct sort_entry sort_time = {
+	.se_header      = "Time",
+	.se_cmp	        = sort__time_cmp,
+	.se_snprintf    = hist_entry__time_snprintf,
+	.se_width_idx	= HISTC_TIME,
+};
+
 /* --sort trace */
 
 static char *get_trace_output(struct hist_entry *he)
@@ -1634,6 +1673,7 @@ static struct sort_dimension common_sort_dimensions[] = {
 	DIM(SORT_DSO_SIZE, "dso_size", sort_dso_size),
 	DIM(SORT_CGROUP_ID, "cgroup_id", sort_cgroup_id),
 	DIM(SORT_SYM_IPC_NULL, "ipc_null", sort_sym_ipc_null),
+	DIM(SORT_TIME, "time", sort_time),
 };
 
 #undef DIM
@@ -3068,3 +3108,54 @@ void reset_output_field(void)
 	reset_dimensions();
 	perf_hpp__reset_output_field(&perf_hpp_list);
 }
+
+#define INDENT (3*8 + 1)
+
+static void add_key(struct strbuf *sb, const char *str, int *llen)
+{
+	if (*llen >= 75) {
+		strbuf_addstr(sb, "\n\t\t\t ");
+		*llen = INDENT;
+	}
+	strbuf_addf(sb, " %s", str);
+	*llen += strlen(str) + 1;
+}
+
+static void add_sort_string(struct strbuf *sb, struct sort_dimension *s, int n,
+			    int *llen)
+{
+	int i;
+
+	for (i = 0; i < n; i++)
+		add_key(sb, s[i].name, llen);
+}
+
+static void add_hpp_sort_string(struct strbuf *sb, struct hpp_dimension *s, int n,
+				int *llen)
+{
+	int i;
+
+	for (i = 0; i < n; i++)
+		add_key(sb, s[i].name, llen);
+}
+
+const char *sort_help(const char *prefix)
+{
+	struct strbuf sb;
+	char *s;
+	int len = strlen(prefix) + INDENT;
+
+	strbuf_init(&sb, 300);
+	strbuf_addstr(&sb, prefix);
+	add_hpp_sort_string(&sb, hpp_sort_dimensions,
+			    ARRAY_SIZE(hpp_sort_dimensions), &len);
+	add_sort_string(&sb, common_sort_dimensions,
+			    ARRAY_SIZE(common_sort_dimensions), &len);
+	add_sort_string(&sb, bstack_sort_dimensions,
+			    ARRAY_SIZE(bstack_sort_dimensions), &len);
+	add_sort_string(&sb, memory_sort_dimensions,
+			    ARRAY_SIZE(memory_sort_dimensions), &len);
+	s = strbuf_detach(&sb, NULL);
+	strbuf_release(&sb);
+	return s;
+}
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 2fbee0b1011c..ce376a73f964 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -47,6 +47,12 @@ extern struct sort_entry sort_srcline;
 extern enum sort_type sort__first_dimension;
 extern const char default_mem_sort_order[];
 
+struct res_sample {
+	u64 time;
+	int cpu;
+	int tid;
+};
+
 struct he_stat {
 	u64			period;
 	u64			period_sys;
@@ -135,10 +141,13 @@ struct hist_entry {
 	char			*srcfile;
 	struct symbol		*parent;
 	struct branch_info	*branch_info;
+	long			time;
 	struct hists		*hists;
 	struct mem_info		*mem_info;
 	void			*raw_data;
 	u32			raw_size;
+	int			num_res;
+	struct res_sample	*res_samples;
 	void			*trace_output;
 	struct perf_hpp_list	*hpp_list;
 	struct hist_entry	*parent_he;
@@ -231,6 +240,7 @@ enum sort_type {
 	SORT_DSO_SIZE,
 	SORT_CGROUP_ID,
 	SORT_SYM_IPC_NULL,
+	SORT_TIME,
 
 	/* branch stack specific sort keys */
 	__SORT_BRANCH_STACK,
@@ -286,6 +296,8 @@ void reset_output_field(void);
 void sort__setup_elide(FILE *fp);
 void perf_hpp__set_elide(int idx, bool elide);
 
+const char *sort_help(const char *prefix);
+
 int report_parse_ignore_callees_opt(const struct option *opt, const char *arg, int unset);
 
 bool is_strict_order(const char *order);
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 4d40515307b8..2856cc9d5a31 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -291,10 +291,8 @@ process_counter_values(struct perf_stat_config *config, struct perf_evsel *evsel
 		break;
 	case AGGR_GLOBAL:
 		aggr->val += count->val;
-		if (config->scale) {
-			aggr->ena += count->ena;
-			aggr->run += count->run;
-		}
+		aggr->ena += count->ena;
+		aggr->run += count->run;
 	case AGGR_UNSET:
 	default:
 		break;
@@ -442,10 +440,8 @@ int create_perf_stat_counter(struct perf_evsel *evsel,
 	struct perf_event_attr *attr = &evsel->attr;
 	struct perf_evsel *leader = evsel->leader;
 
-	if (config->scale) {
-		attr->read_format = PERF_FORMAT_TOTAL_TIME_ENABLED |
-				    PERF_FORMAT_TOTAL_TIME_RUNNING;
-	}
+	attr->read_format = PERF_FORMAT_TOTAL_TIME_ENABLED |
+			    PERF_FORMAT_TOTAL_TIME_RUNNING;
 
 	/*
 	 * The event is part of non trivial group, let's enable
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 758bf5f74e6e..5cbad55cd99d 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -6,6 +6,7 @@
 #include <string.h>
 #include <linux/kernel.h>
 #include <linux/mman.h>
+#include <linux/time64.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/param.h>
@@ -39,15 +40,18 @@ int vmlinux_path__nr_entries;
 char **vmlinux_path;
 
 struct symbol_conf symbol_conf = {
+	.nanosecs		= false,
 	.use_modules		= true,
 	.try_vmlinux_path	= true,
 	.demangle		= true,
 	.demangle_kernel	= false,
 	.cumulate_callchain	= true,
+	.time_quantum		= 100 * NSEC_PER_MSEC, /* 100ms */
 	.show_hist_headers	= true,
 	.symfs			= "",
 	.event_group		= true,
 	.inline_name		= true,
+	.res_sample		= 0,
 };
 
 static enum dso_binary_type binary_type_symtab[] = {
@@ -1451,6 +1455,7 @@ static bool dso__is_compatible_symtab_type(struct dso *dso, bool kmod,
 	case DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO:
 		return true;
 
+	case DSO_BINARY_TYPE__BPF_PROG_INFO:
 	case DSO_BINARY_TYPE__NOT_FOUND:
 	default:
 		return false;
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index fffea68c1203..6c55fa6fccec 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -8,6 +8,7 @@ struct strlist;
 struct intlist;
 
 struct symbol_conf {
+	bool		nanosecs;
 	unsigned short	priv_size;
 	bool		try_vmlinux_path,
 			init_annotation,
@@ -55,6 +56,7 @@ struct symbol_conf {
 			*sym_list_str,
 			*col_width_list_str,
 			*bt_stop_list_str;
+	unsigned long	time_quantum;
        struct strlist	*dso_list,
 			*comm_list,
 			*sym_list,
@@ -66,6 +68,7 @@ struct symbol_conf {
 	struct intlist	*pid_list,
 			*tid_list;
 	const char	*symfs;
+	int		res_sample;
 };
 
 extern struct symbol_conf symbol_conf;
diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 0f53baec660e..20663a460df3 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -453,6 +453,14 @@ int timestamp__scnprintf_usec(u64 timestamp, char *buf, size_t sz)
 	return scnprintf(buf, sz, "%"PRIu64".%06"PRIu64, sec, usec);
 }
 
+int timestamp__scnprintf_nsec(u64 timestamp, char *buf, size_t sz)
+{
+	u64 sec  = timestamp / NSEC_PER_SEC,
+	    nsec = timestamp % NSEC_PER_SEC;
+
+	return scnprintf(buf, sz, "%" PRIu64 ".%09" PRIu64, sec, nsec);
+}
+
 int fetch_current_timestamp(char *buf, size_t sz)
 {
 	struct timeval tv;
diff --git a/tools/perf/util/time-utils.h b/tools/perf/util/time-utils.h
index b923de44e36f..72a42ea1d513 100644
--- a/tools/perf/util/time-utils.h
+++ b/tools/perf/util/time-utils.h
@@ -30,6 +30,7 @@ int perf_time__parse_for_ranges(const char *str, struct perf_session *session,
 				int *range_size, int *range_num);
 
 int timestamp__scnprintf_usec(u64 timestamp, char *buf, size_t sz);
+int timestamp__scnprintf_nsec(u64 timestamp, char *buf, size_t sz);
 
 int fetch_current_timestamp(char *buf, size_t sz);
 

