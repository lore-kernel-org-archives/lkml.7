Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6B8C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 06:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F49621835
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 06:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfK2GDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 01:03:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48092 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbfK2GDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 01:03:16 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iaZMs-0008MD-9W; Fri, 29 Nov 2019 07:03:02 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BC93F1C2109;
        Fri, 29 Nov 2019 07:02:52 +0100 (CET)
Date:   Fri, 29 Nov 2019 06:02:52 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf maps: Merge 'struct maps' with 'struct map_groups'
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <tip-hom6639ro7020o708trhxh59@git.kernel.org>
References: <tip-hom6639ro7020o708trhxh59@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157500737262.21853.2149320185370888915.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     79b6bb73f888933cbcd20b0ef3976cde67951b72
Gitweb:        https://git.kernel.org/tip/79b6bb73f888933cbcd20b0ef3976cde67951b72
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 25 Nov 2019 21:58:33 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 26 Nov 2019 11:07:46 -03:00

perf maps: Merge 'struct maps' with 'struct map_groups'

And pick the shortest name: 'struct maps'.

The split existed because we used to have two groups of maps, one for
functions and one for variables, but that only complicated things,
sometimes we needed to figure out what was at some address and then had
to first try it on the functions group and if that failed, fall back to
the variables one.

That split is long gone, so for quite a while we had only one struct
maps per struct map_groups, simplify things by combining those structs.

First patch is the minimum needed to merge both, follow up patches will
rename 'thread->mg' to 'thread->maps', etc.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-hom6639ro7020o708trhxh59@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/tests/dwarf-unwind.c     |   2 +-
 tools/perf/arch/arm64/tests/dwarf-unwind.c   |   2 +-
 tools/perf/arch/powerpc/tests/dwarf-unwind.c |   2 +-
 tools/perf/arch/s390/annotate/instructions.c |   2 +-
 tools/perf/arch/x86/tests/dwarf-unwind.c     |   2 +-
 tools/perf/arch/x86/util/event.c             |   5 +-
 tools/perf/builtin-report.c                  |   7 +-
 tools/perf/tests/map_groups.c                |  16 +--
 tools/perf/tests/thread-mg-share.c           |   6 +-
 tools/perf/tests/vmlinux-kallsyms.c          |   9 +--
 tools/perf/ui/stdio/hist.c                   |   2 +-
 tools/perf/util/annotate.c                   |   6 +-
 tools/perf/util/bpf-event.c                  |   4 +-
 tools/perf/util/cs-etm.c                     |   2 +-
 tools/perf/util/event.c                      |   4 +-
 tools/perf/util/intel-pt.c                   |   2 +-
 tools/perf/util/machine.c                    |  66 +++++------
 tools/perf/util/machine.h                    |   8 +-
 tools/perf/util/map.c                        | 105 ++++++------------
 tools/perf/util/map.h                        |   4 +-
 tools/perf/util/map_groups.h                 |  60 +++-------
 tools/perf/util/map_symbol.h                 |   4 +-
 tools/perf/util/probe-event.c                |   2 +-
 tools/perf/util/symbol-elf.c                 |  14 +-
 tools/perf/util/symbol.c                     |  67 +++++------
 tools/perf/util/symbol.h                     |   6 +-
 tools/perf/util/synthetic-events.c           |   2 +-
 tools/perf/util/thread.c                     |  24 +---
 tools/perf/util/thread.h                     |   4 +-
 tools/perf/util/unwind-libunwind-local.c     |   6 +-
 tools/perf/util/unwind-libunwind.c           |  10 +--
 tools/perf/util/unwind.h                     |  27 ++---
 tools/perf/util/vdso.c                       |   2 +-
 33 files changed, 209 insertions(+), 275 deletions(-)

diff --git a/tools/perf/arch/arm/tests/dwarf-unwind.c b/tools/perf/arch/arm/tests/dwarf-unwind.c
index 2c35e53..0267372 100644
--- a/tools/perf/arch/arm/tests/dwarf-unwind.c
+++ b/tools/perf/arch/arm/tests/dwarf-unwind.c
@@ -26,7 +26,7 @@ static int sample_ustack(struct perf_sample *sample,
 
 	sp = (unsigned long) regs[PERF_REG_ARM_SP];
 
-	map = map_groups__find(thread->mg, (u64)sp);
+	map = maps__find(thread->mg, (u64)sp);
 	if (!map) {
 		pr_debug("failed to get stack map\n");
 		free(buf);
diff --git a/tools/perf/arch/arm64/tests/dwarf-unwind.c b/tools/perf/arch/arm64/tests/dwarf-unwind.c
index a6a407f..8864896 100644
--- a/tools/perf/arch/arm64/tests/dwarf-unwind.c
+++ b/tools/perf/arch/arm64/tests/dwarf-unwind.c
@@ -26,7 +26,7 @@ static int sample_ustack(struct perf_sample *sample,
 
 	sp = (unsigned long) regs[PERF_REG_ARM64_SP];
 
-	map = map_groups__find(thread->mg, (u64)sp);
+	map = maps__find(thread->mg, (u64)sp);
 	if (!map) {
 		pr_debug("failed to get stack map\n");
 		free(buf);
diff --git a/tools/perf/arch/powerpc/tests/dwarf-unwind.c b/tools/perf/arch/powerpc/tests/dwarf-unwind.c
index 5c178e4..b38117c 100644
--- a/tools/perf/arch/powerpc/tests/dwarf-unwind.c
+++ b/tools/perf/arch/powerpc/tests/dwarf-unwind.c
@@ -27,7 +27,7 @@ static int sample_ustack(struct perf_sample *sample,
 
 	sp = (unsigned long) regs[PERF_REG_POWERPC_R1];
 
-	map = map_groups__find(thread->mg, (u64)sp);
+	map = maps__find(thread->mg, (u64)sp);
 	if (!map) {
 		pr_debug("failed to get stack map\n");
 		free(buf);
diff --git a/tools/perf/arch/s390/annotate/instructions.c b/tools/perf/arch/s390/annotate/instructions.c
index 2a6662e..57be973 100644
--- a/tools/perf/arch/s390/annotate/instructions.c
+++ b/tools/perf/arch/s390/annotate/instructions.c
@@ -38,7 +38,7 @@ static int s390_call__parse(struct arch *arch, struct ins_operands *ops,
 		return -1;
 	target.addr = map__objdump_2mem(map, ops->target.addr);
 
-	if (map_groups__find_ams(ms->mg, &target) == 0 &&
+	if (maps__find_ams(ms->mg, &target) == 0 &&
 	    map__rip_2objdump(target.ms.map, map->map_ip(target.ms.map, target.addr)) == ops->target.addr)
 		ops->target.sym = target.ms.sym;
 
diff --git a/tools/perf/arch/x86/tests/dwarf-unwind.c b/tools/perf/arch/x86/tests/dwarf-unwind.c
index 6ad0a1c..f52132e 100644
--- a/tools/perf/arch/x86/tests/dwarf-unwind.c
+++ b/tools/perf/arch/x86/tests/dwarf-unwind.c
@@ -27,7 +27,7 @@ static int sample_ustack(struct perf_sample *sample,
 
 	sp = (unsigned long) regs[PERF_REG_X86_SP];
 
-	map = map_groups__find(thread->mg, (u64)sp);
+	map = maps__find(thread->mg, (u64)sp);
 	if (!map) {
 		pr_debug("failed to get stack map\n");
 		free(buf);
diff --git a/tools/perf/arch/x86/util/event.c b/tools/perf/arch/x86/util/event.c
index d1044df..ac45015 100644
--- a/tools/perf/arch/x86/util/event.c
+++ b/tools/perf/arch/x86/util/event.c
@@ -18,8 +18,7 @@ int perf_event__synthesize_extra_kmaps(struct perf_tool *tool,
 {
 	int rc = 0;
 	struct map *pos;
-	struct map_groups *kmaps = &machine->kmaps;
-	struct maps *maps = &kmaps->maps;
+	struct maps *kmaps = &machine->kmaps;
 	union perf_event *event = zalloc(sizeof(event->mmap) +
 					 machine->id_hdr_size);
 
@@ -29,7 +28,7 @@ int perf_event__synthesize_extra_kmaps(struct perf_tool *tool,
 		return -1;
 	}
 
-	maps__for_each_entry(maps, pos) {
+	maps__for_each_entry(kmaps, pos) {
 		struct kmap *kmap;
 		size_t size;
 
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index ab0f6e5..729d684 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -780,11 +780,6 @@ static size_t maps__fprintf_task(struct maps *maps, int indent, FILE *fp)
 	return printed;
 }
 
-static int map_groups__fprintf_task(struct map_groups *mg, int indent, FILE *fp)
-{
-	return maps__fprintf_task(&mg->maps, indent, fp);
-}
-
 static void task__print_level(struct task *task, FILE *fp, int level)
 {
 	struct thread *thread = task->thread;
@@ -795,7 +790,7 @@ static void task__print_level(struct task *task, FILE *fp, int level)
 
 	fprintf(fp, "%s\n", thread__comm_str(thread));
 
-	map_groups__fprintf_task(thread->mg, comm_indent, fp);
+	maps__fprintf_task(thread->mg, comm_indent, fp);
 
 	if (!list_empty(&task->children)) {
 		list_for_each_entry(child, &task->children, list)
diff --git a/tools/perf/tests/map_groups.c b/tools/perf/tests/map_groups.c
index 6b9f1cd..db806e5 100644
--- a/tools/perf/tests/map_groups.c
+++ b/tools/perf/tests/map_groups.c
@@ -13,12 +13,12 @@ struct map_def {
 	u64 end;
 };
 
-static int check_maps(struct map_def *merged, unsigned int size, struct map_groups *mg)
+static int check_maps(struct map_def *merged, unsigned int size, struct maps *maps)
 {
 	struct map *map;
 	unsigned int i = 0;
 
-	map_groups__for_each_entry(mg, map) {
+	maps__for_each_entry(maps, map) {
 		if (i > 0)
 			TEST_ASSERT_VAL("less maps expected", (map && i < size) || (!map && i == size));
 
@@ -35,7 +35,7 @@ static int check_maps(struct map_def *merged, unsigned int size, struct map_grou
 
 int test__map_groups__merge_in(struct test *t __maybe_unused, int subtest __maybe_unused)
 {
-	struct map_groups mg;
+	struct maps mg;
 	unsigned int i;
 	struct map_def bpf_progs[] = {
 		{ "bpf_prog_1", 200, 300 },
@@ -64,7 +64,7 @@ int test__map_groups__merge_in(struct test *t __maybe_unused, int subtest __mayb
 	struct map *map_kcore1, *map_kcore2, *map_kcore3;
 	int ret;
 
-	map_groups__init(&mg, NULL);
+	maps__init(&mg, NULL);
 
 	for (i = 0; i < ARRAY_SIZE(bpf_progs); i++) {
 		struct map *map;
@@ -74,7 +74,7 @@ int test__map_groups__merge_in(struct test *t __maybe_unused, int subtest __mayb
 
 		map->start = bpf_progs[i].start;
 		map->end   = bpf_progs[i].end;
-		map_groups__insert(&mg, map);
+		maps__insert(&mg, map);
 		map__put(map);
 	}
 
@@ -99,19 +99,19 @@ int test__map_groups__merge_in(struct test *t __maybe_unused, int subtest __mayb
 	map_kcore3->start = 880;
 	map_kcore3->end   = 1100;
 
-	ret = map_groups__merge_in(&mg, map_kcore1);
+	ret = maps__merge_in(&mg, map_kcore1);
 	TEST_ASSERT_VAL("failed to merge map", !ret);
 
 	ret = check_maps(merged12, ARRAY_SIZE(merged12), &mg);
 	TEST_ASSERT_VAL("merge check failed", !ret);
 
-	ret = map_groups__merge_in(&mg, map_kcore2);
+	ret = maps__merge_in(&mg, map_kcore2);
 	TEST_ASSERT_VAL("failed to merge map", !ret);
 
 	ret = check_maps(merged12, ARRAY_SIZE(merged12), &mg);
 	TEST_ASSERT_VAL("merge check failed", !ret);
 
-	ret = map_groups__merge_in(&mg, map_kcore3);
+	ret = maps__merge_in(&mg, map_kcore3);
 	TEST_ASSERT_VAL("failed to merge map", !ret);
 
 	ret = check_maps(merged3, ARRAY_SIZE(merged3), &mg);
diff --git a/tools/perf/tests/thread-mg-share.c b/tools/perf/tests/thread-mg-share.c
index cbac717..7f15eed 100644
--- a/tools/perf/tests/thread-mg-share.c
+++ b/tools/perf/tests/thread-mg-share.c
@@ -12,16 +12,16 @@ int test__thread_mg_share(struct test *test __maybe_unused, int subtest __maybe_
 	/* thread group */
 	struct thread *leader;
 	struct thread *t1, *t2, *t3;
-	struct map_groups *mg;
+	struct maps *mg;
 
 	/* other process */
 	struct thread *other, *other_leader;
-	struct map_groups *other_mg;
+	struct maps *other_mg;
 
 	/*
 	 * This test create 2 processes abstractions (struct thread)
 	 * with several threads and checks they properly share and
-	 * maintain map groups info (struct map_groups).
+	 * maintain maps info (struct maps).
 	 *
 	 * thread group (pid: 0, tids: 0, 1, 2, 3)
 	 * other  group (pid: 4, tids: 4, 5)
diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index ff64907..193b7c9 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -190,10 +190,9 @@ next_pair:
 		 * so use the short name, less descriptive but the same ("[kernel]" in
 		 * both cases.
 		 */
-		pair = map_groups__find_by_name(&kallsyms.kmaps,
-						(map->dso->kernel ?
-							map->dso->short_name :
-							map->dso->name));
+		pair = maps__find_by_name(&kallsyms.kmaps, (map->dso->kernel ?
+								map->dso->short_name :
+								map->dso->name));
 		if (pair) {
 			pair->priv = 1;
 		} else {
@@ -213,7 +212,7 @@ next_pair:
 		mem_start = vmlinux_map->unmap_ip(vmlinux_map, map->start);
 		mem_end = vmlinux_map->unmap_ip(vmlinux_map, map->end);
 
-		pair = map_groups__find(&kallsyms.kmaps, mem_start);
+		pair = maps__find(&kallsyms.kmaps, mem_start);
 		if (pair == NULL || pair->priv)
 			continue;
 
diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index 132056c..2d9c484 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -885,7 +885,7 @@ size_t hists__fprintf(struct hists *hists, bool show_header, int max_rows,
 		}
 
 		if (h->ms.map == NULL && verbose > 1) {
-			map_groups__fprintf(h->thread->mg, fp);
+			maps__fprintf(h->thread->mg, fp);
 			fprintf(fp, "%.10s end\n", graph_dotted_line);
 		}
 	}
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 5ea9a45..1b0980a 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -271,7 +271,7 @@ static int call__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 find_target:
 	target.addr = map__objdump_2mem(map, ops->target.addr);
 
-	if (map_groups__find_ams(ms->mg, &target) == 0 &&
+	if (maps__find_ams(ms->mg, &target) == 0 &&
 	    map__rip_2objdump(target.ms.map, map->map_ip(target.ms.map, target.addr)) == ops->target.addr)
 		ops->target.sym = target.ms.sym;
 
@@ -391,7 +391,7 @@ static int jump__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 	 * Actual navigation will come next, with further understanding of how
 	 * the symbol searching and disassembly should be done.
 	 */
-	if (map_groups__find_ams(ms->mg, &target) == 0 &&
+	if (maps__find_ams(ms->mg, &target) == 0 &&
 	    map__rip_2objdump(target.ms.map, map->map_ip(target.ms.map, target.addr)) == ops->target.addr)
 		ops->target.sym = target.ms.sym;
 
@@ -1545,7 +1545,7 @@ static int symbol__parse_objdump_line(struct symbol *sym,
 			.ms = { .map = map, },
 		};
 
-		if (!map_groups__find_ams(args->ms.mg, &target) &&
+		if (!maps__find_ams(args->ms.mg, &target) &&
 		    target.ms.sym->start == target.al_addr)
 			dl->ops.target.sym = target.ms.sym;
 	}
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index f7ed5d1..a3207d9 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -52,9 +52,7 @@ static int machine__process_bpf_event_load(struct machine *machine,
 	for (i = 0; i < info_linear->info.nr_jited_ksyms; i++) {
 		u64 *addrs = (u64 *)(uintptr_t)(info_linear->info.jited_ksyms);
 		u64 addr = addrs[i];
-		struct map *map;
-
-		map = map_groups__find(&machine->kmaps, addr);
+		struct map *map = maps__find(&machine->kmaps, addr);
 
 		if (map) {
 			map->dso->binary_type = DSO_BINARY_TYPE__BPF_PROG_INFO;
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index f5f855f..5471045 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2569,7 +2569,7 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	if (err)
 		goto err_delete_thread;
 
-	if (thread__init_map_groups(etm->unknown_thread, etm->machine)) {
+	if (thread__init_maps(etm->unknown_thread, etm->machine)) {
 		err = -ENOMEM;
 		goto err_delete_thread;
 	}
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 0141b26..0181790 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -457,7 +457,7 @@ int perf_event__process(struct perf_tool *tool __maybe_unused,
 struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 			     struct addr_location *al)
 {
-	struct map_groups *mg = thread->mg;
+	struct maps *mg = thread->mg;
 	struct machine *machine = mg->machine;
 	bool load_map = false;
 
@@ -500,7 +500,7 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 		return NULL;
 	}
 
-	al->map = map_groups__find(mg, al->addr);
+	al->map = maps__find(mg, al->addr);
 	if (al->map != NULL) {
 		/*
 		 * Kernel maps might be changed when loading symbols so loading
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 409afc6..33cf892 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -3296,7 +3296,7 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 	err = thread__set_comm(pt->unknown_thread, "unknown", 0);
 	if (err)
 		goto err_delete_thread;
-	if (thread__init_map_groups(pt->unknown_thread, pt->machine)) {
+	if (thread__init_maps(pt->unknown_thread, pt->machine)) {
 		err = -ENOMEM;
 		goto err_delete_thread;
 	}
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index e2a312c..d646aea 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -86,7 +86,7 @@ int machine__init(struct machine *machine, const char *root_dir, pid_t pid)
 	int err = -ENOMEM;
 
 	memset(machine, 0, sizeof(*machine));
-	map_groups__init(&machine->kmaps, machine);
+	maps__init(&machine->kmaps, machine);
 	RB_CLEAR_NODE(&machine->rb_node);
 	dsos__init(&machine->dsos);
 
@@ -217,7 +217,7 @@ void machine__exit(struct machine *machine)
 		return;
 
 	machine__destroy_kernel_maps(machine);
-	map_groups__exit(&machine->kmaps);
+	maps__exit(&machine->kmaps);
 	dsos__exit(&machine->dsos);
 	machine__exit_vdso(machine);
 	zfree(&machine->root_dir);
@@ -413,7 +413,7 @@ static void machine__update_thread_pid(struct machine *machine,
 		goto out_err;
 
 	if (!leader->mg)
-		leader->mg = map_groups__new(machine);
+		leader->mg = maps__new(machine);
 
 	if (!leader->mg)
 		goto out_err;
@@ -427,13 +427,13 @@ static void machine__update_thread_pid(struct machine *machine,
 		 * tid.  Consequently there never should be any maps on a thread
 		 * with an unknown pid.  Just print an error if there are.
 		 */
-		if (!map_groups__empty(th->mg))
+		if (!maps__empty(th->mg))
 			pr_err("Discarding thread maps for %d:%d\n",
 			       th->pid_, th->tid);
-		map_groups__put(th->mg);
+		maps__put(th->mg);
 	}
 
-	th->mg = map_groups__get(leader->mg);
+	th->mg = maps__get(leader->mg);
 out_put:
 	thread__put(leader);
 	return;
@@ -536,14 +536,13 @@ static struct thread *____machine__findnew_thread(struct machine *machine,
 		rb_insert_color_cached(&th->rb_node, &threads->entries, leftmost);
 
 		/*
-		 * We have to initialize map_groups separately
-		 * after rb tree is updated.
+		 * We have to initialize maps separately after rb tree is updated.
 		 *
 		 * The reason is that we call machine__findnew_thread
-		 * within thread__init_map_groups to find the thread
+		 * within thread__init_maps to find the thread
 		 * leader and that would screwed the rb tree.
 		 */
-		if (thread__init_map_groups(th, machine)) {
+		if (thread__init_maps(th, machine)) {
 			rb_erase_cached(&th->rb_node, &threads->entries);
 			RB_CLEAR_NODE(&th->rb_node);
 			thread__put(th);
@@ -724,9 +723,8 @@ static int machine__process_ksymbol_register(struct machine *machine,
 					     struct perf_sample *sample __maybe_unused)
 {
 	struct symbol *sym;
-	struct map *map;
+	struct map *map = maps__find(&machine->kmaps, event->ksymbol.addr);
 
-	map = map_groups__find(&machine->kmaps, event->ksymbol.addr);
 	if (!map) {
 		map = dso__new_map(event->ksymbol.name);
 		if (!map)
@@ -734,7 +732,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
 
 		map->start = event->ksymbol.addr;
 		map->end = map->start + event->ksymbol.len;
-		map_groups__insert(&machine->kmaps, map);
+		maps__insert(&machine->kmaps, map);
 	}
 
 	sym = symbol__new(map->map_ip(map, map->start),
@@ -752,9 +750,9 @@ static int machine__process_ksymbol_unregister(struct machine *machine,
 {
 	struct map *map;
 
-	map = map_groups__find(&machine->kmaps, event->ksymbol.addr);
+	map = maps__find(&machine->kmaps, event->ksymbol.addr);
 	if (map)
-		map_groups__remove(&machine->kmaps, map);
+		maps__remove(&machine->kmaps, map);
 
 	return 0;
 }
@@ -790,9 +788,9 @@ static struct map *machine__addnew_module_map(struct machine *machine, u64 start
 	if (map == NULL)
 		goto out;
 
-	map_groups__insert(&machine->kmaps, map);
+	maps__insert(&machine->kmaps, map);
 
-	/* Put the map here because map_groups__insert alread got it */
+	/* Put the map here because maps__insert alread got it */
 	map__put(map);
 out:
 	/* put the dso here, corresponding to  machine__findnew_module_dso */
@@ -977,7 +975,7 @@ int machine__create_extra_kernel_map(struct machine *machine,
 	kmap->kmaps = &machine->kmaps;
 	strlcpy(kmap->name, xm->name, KMAP_NAME_LEN);
 
-	map_groups__insert(&machine->kmaps, map);
+	maps__insert(&machine->kmaps, map);
 
 	pr_debug2("Added extra kernel map %s %" PRIx64 "-%" PRIx64 "\n",
 		  kmap->name, map->start, map->end);
@@ -1022,8 +1020,7 @@ static u64 find_entry_trampoline(struct dso *dso)
 int machine__map_x86_64_entry_trampolines(struct machine *machine,
 					  struct dso *kernel)
 {
-	struct map_groups *kmaps = &machine->kmaps;
-	struct maps *maps = &kmaps->maps;
+	struct maps *kmaps = &machine->kmaps;
 	int nr_cpus_avail, cpu;
 	bool found = false;
 	struct map *map;
@@ -1033,14 +1030,14 @@ int machine__map_x86_64_entry_trampolines(struct machine *machine,
 	 * In the vmlinux case, pgoff is a virtual address which must now be
 	 * mapped to a vmlinux offset.
 	 */
-	maps__for_each_entry(maps, map) {
+	maps__for_each_entry(kmaps, map) {
 		struct kmap *kmap = __map__kmap(map);
 		struct map *dest_map;
 
 		if (!kmap || !is_entry_trampoline(kmap->name))
 			continue;
 
-		dest_map = map_groups__find(kmaps, map->pgoff);
+		dest_map = maps__find(kmaps, map->pgoff);
 		if (dest_map != map)
 			map->pgoff = dest_map->map_ip(dest_map, map->pgoff);
 		found = true;
@@ -1102,7 +1099,7 @@ __machine__create_kernel_maps(struct machine *machine, struct dso *kernel)
 		return -1;
 
 	kmap->kmaps = &machine->kmaps;
-	map_groups__insert(&machine->kmaps, map);
+	maps__insert(&machine->kmaps, map);
 
 	return 0;
 }
@@ -1116,7 +1113,7 @@ void machine__destroy_kernel_maps(struct machine *machine)
 		return;
 
 	kmap = map__kmap(map);
-	map_groups__remove(&machine->kmaps, map);
+	maps__remove(&machine->kmaps, map);
 	if (kmap && kmap->ref_reloc_sym) {
 		zfree((char **)&kmap->ref_reloc_sym->name);
 		zfree(&kmap->ref_reloc_sym);
@@ -1211,7 +1208,7 @@ int machine__load_kallsyms(struct machine *machine, const char *filename)
 		 * kernel, with modules between them, fixup the end of all
 		 * sections.
 		 */
-		map_groups__fixup_end(&machine->kmaps);
+		maps__fixup_end(&machine->kmaps);
 	}
 
 	return ret;
@@ -1262,11 +1259,10 @@ static bool is_kmod_dso(struct dso *dso)
 	       dso->symtab_type == DSO_BINARY_TYPE__GUEST_KMODULE;
 }
 
-static int map_groups__set_module_path(struct map_groups *mg, const char *path,
-				       struct kmod_path *m)
+static int maps__set_module_path(struct maps *mg, const char *path, struct kmod_path *m)
 {
 	char *long_name;
-	struct map *map = map_groups__find_by_name(mg, m->name);
+	struct map *map = maps__find_by_name(mg, m->name);
 
 	if (map == NULL)
 		return 0;
@@ -1290,8 +1286,7 @@ static int map_groups__set_module_path(struct map_groups *mg, const char *path,
 	return 0;
 }
 
-static int map_groups__set_modules_path_dir(struct map_groups *mg,
-				const char *dir_name, int depth)
+static int maps__set_modules_path_dir(struct maps *mg, const char *dir_name, int depth)
 {
 	struct dirent *dent;
 	DIR *dir = opendir(dir_name);
@@ -1323,8 +1318,7 @@ static int map_groups__set_modules_path_dir(struct map_groups *mg,
 					continue;
 			}
 
-			ret = map_groups__set_modules_path_dir(mg, path,
-							       depth + 1);
+			ret = maps__set_modules_path_dir(mg, path, depth + 1);
 			if (ret < 0)
 				goto out;
 		} else {
@@ -1335,7 +1329,7 @@ static int map_groups__set_modules_path_dir(struct map_groups *mg,
 				goto out;
 
 			if (m.kmod)
-				ret = map_groups__set_module_path(mg, path, &m);
+				ret = maps__set_module_path(mg, path, &m);
 
 			zfree(&m.name);
 
@@ -1362,7 +1356,7 @@ static int machine__set_modules_path(struct machine *machine)
 		 machine->root_dir, version);
 	free(version);
 
-	return map_groups__set_modules_path_dir(&machine->kmaps, modules_path, 0);
+	return maps__set_modules_path_dir(&machine->kmaps, modules_path, 0);
 }
 int __weak arch__fix_module_text_start(u64 *start __maybe_unused,
 				u64 *size __maybe_unused,
@@ -1435,11 +1429,11 @@ static void machine__update_kernel_mmap(struct machine *machine,
 	struct map *map = machine__kernel_map(machine);
 
 	map__get(map);
-	map_groups__remove(&machine->kmaps, map);
+	maps__remove(&machine->kmaps, map);
 
 	machine__set_kernel_mmap(machine, start, end);
 
-	map_groups__insert(&machine->kmaps, map);
+	maps__insert(&machine->kmaps, map);
 	map__put(map);
 }
 
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 499be20..fe602cf 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -51,7 +51,7 @@ struct machine {
 	struct vdso_info  *vdso_info;
 	struct perf_env   *env;
 	struct dsos	  dsos;
-	struct map_groups kmaps;
+	struct maps	  kmaps;
 	struct map	  *vmlinux_map;
 	u64		  kernel_start;
 	pid_t		  *current_tid;
@@ -83,7 +83,7 @@ struct map *machine__kernel_map(struct machine *machine)
 static inline
 struct maps *machine__kernel_maps(struct machine *machine)
 {
-	return &machine->kmaps.maps;
+	return &machine->kmaps;
 }
 
 int machine__get_kernel_start(struct machine *machine);
@@ -212,7 +212,7 @@ static inline
 struct symbol *machine__find_kernel_symbol(struct machine *machine, u64 addr,
 					   struct map **mapp)
 {
-	return map_groups__find_symbol(&machine->kmaps, addr, mapp);
+	return maps__find_symbol(&machine->kmaps, addr, mapp);
 }
 
 static inline
@@ -220,7 +220,7 @@ struct symbol *machine__find_kernel_symbol_by_name(struct machine *machine,
 						   const char *name,
 						   struct map **mapp)
 {
-	return map_groups__find_symbol_by_name(&machine->kmaps, name, mapp);
+	return maps__find_symbol_by_name(&machine->kmaps, name, mapp);
 }
 
 int arch__fix_module_text_start(u64 *start, u64 *size, const char *name);
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 267d951..4c9fd06 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -512,15 +512,10 @@ u64 map__objdump_2mem(struct map *map, u64 ip)
 	return ip + map->reloc;
 }
 
-static void maps__init(struct maps *maps)
+void maps__init(struct maps *mg, struct machine *machine)
 {
-	maps->entries = RB_ROOT;
-	init_rwsem(&maps->lock);
-}
-
-void map_groups__init(struct map_groups *mg, struct machine *machine)
-{
-	maps__init(&mg->maps);
+	mg->entries = RB_ROOT;
+	init_rwsem(&mg->lock);
 	mg->machine = machine;
 	mg->last_search_by_name = NULL;
 	mg->nr_maps = 0;
@@ -528,7 +523,7 @@ void map_groups__init(struct map_groups *mg, struct machine *machine)
 	refcount_set(&mg->refcnt, 1);
 }
 
-static void __map_groups__free_maps_by_name(struct map_groups *mg)
+static void __maps__free_maps_by_name(struct maps *mg)
 {
 	/*
 	 * Free everything to try to do it from the rbtree in the next search
@@ -537,9 +532,9 @@ static void __map_groups__free_maps_by_name(struct map_groups *mg)
 	mg->nr_maps_allocated = 0;
 }
 
-void map_groups__insert(struct map_groups *mg, struct map *map)
+void maps__insert(struct maps *mg, struct map *map)
 {
-	struct maps *maps = &mg->maps;
+	struct maps *maps = mg;
 
 	down_write(&maps->lock);
 	__maps__insert(maps, map);
@@ -555,7 +550,7 @@ void map_groups__insert(struct map_groups *mg, struct map *map)
 			struct map **maps_by_name = realloc(mg->maps_by_name, nr_allocate * sizeof(map));
 
 			if (maps_by_name == NULL) {
-				__map_groups__free_maps_by_name(mg);
+				__maps__free_maps_by_name(maps);
 				return;
 			}
 
@@ -563,7 +558,7 @@ void map_groups__insert(struct map_groups *mg, struct map *map)
 			mg->nr_maps_allocated = nr_allocate;
 		}
 		mg->maps_by_name[mg->nr_maps - 1] = map;
-		__map_groups__sort_by_name(mg);
+		__maps__sort_by_name(maps);
 	}
 	up_write(&maps->lock);
 }
@@ -574,9 +569,9 @@ static void __maps__remove(struct maps *maps, struct map *map)
 	map__put(map);
 }
 
-void map_groups__remove(struct map_groups *mg, struct map *map)
+void maps__remove(struct maps *mg, struct map *map)
 {
-	struct maps *maps = &mg->maps;
+	struct maps *maps = mg;
 	down_write(&maps->lock);
 	if (mg->last_search_by_name == map)
 		mg->last_search_by_name = NULL;
@@ -584,7 +579,7 @@ void map_groups__remove(struct map_groups *mg, struct map *map)
 	__maps__remove(maps, map);
 	--mg->nr_maps;
 	if (mg->maps_by_name)
-		__map_groups__free_maps_by_name(mg);
+		__maps__free_maps_by_name(maps);
 	up_write(&maps->lock);
 }
 
@@ -598,50 +593,44 @@ static void __maps__purge(struct maps *maps)
 	}
 }
 
-static void maps__exit(struct maps *maps)
+void maps__exit(struct maps *maps)
 {
 	down_write(&maps->lock);
 	__maps__purge(maps);
 	up_write(&maps->lock);
 }
 
-void map_groups__exit(struct map_groups *mg)
+bool maps__empty(struct maps *maps)
 {
-	maps__exit(&mg->maps);
+	return !maps__first(maps);
 }
 
-bool map_groups__empty(struct map_groups *mg)
+struct maps *maps__new(struct machine *machine)
 {
-	return !maps__first(&mg->maps);
-}
-
-struct map_groups *map_groups__new(struct machine *machine)
-{
-	struct map_groups *mg = zalloc(sizeof(*mg));
+	struct maps *mg = zalloc(sizeof(*mg)), *maps = mg;
 
 	if (mg != NULL)
-		map_groups__init(mg, machine);
+		maps__init(maps, machine);
 
 	return mg;
 }
 
-void map_groups__delete(struct map_groups *mg)
+void maps__delete(struct maps *mg)
 {
-	map_groups__exit(mg);
+	maps__exit(mg);
 	unwind__finish_access(mg);
 	free(mg);
 }
 
-void map_groups__put(struct map_groups *mg)
+void maps__put(struct maps *mg)
 {
 	if (mg && refcount_dec_and_test(&mg->refcnt))
-		map_groups__delete(mg);
+		maps__delete(mg);
 }
 
-struct symbol *map_groups__find_symbol(struct map_groups *mg,
-				       u64 addr, struct map **mapp)
+struct symbol *maps__find_symbol(struct maps *mg, u64 addr, struct map **mapp)
 {
-	struct map *map = map_groups__find(mg, addr);
+	struct map *map = maps__find(mg, addr);
 
 	/* Ensure map is loaded before using map->map_ip */
 	if (map != NULL && map__load(map) >= 0) {
@@ -660,8 +649,7 @@ static bool map__contains_symbol(struct map *map, struct symbol *sym)
 	return ip >= map->start && ip < map->end;
 }
 
-static struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name,
-						struct map **mapp)
+struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name, struct map **mapp)
 {
 	struct symbol *sym;
 	struct map *pos;
@@ -688,19 +676,12 @@ out:
 	return sym;
 }
 
-struct symbol *map_groups__find_symbol_by_name(struct map_groups *mg,
-					       const char *name,
-					       struct map **mapp)
-{
-	return maps__find_symbol_by_name(&mg->maps, name, mapp);
-}
-
-int map_groups__find_ams(struct map_groups *mg, struct addr_map_symbol *ams)
+int maps__find_ams(struct maps *mg, struct addr_map_symbol *ams)
 {
 	if (ams->addr < ams->ms.map->start || ams->addr >= ams->ms.map->end) {
 		if (mg == NULL)
 			return -1;
-		ams->ms.map = map_groups__find(mg, ams->addr);
+		ams->ms.map = maps__find(mg, ams->addr);
 		if (ams->ms.map == NULL)
 			return -1;
 	}
@@ -711,7 +692,7 @@ int map_groups__find_ams(struct map_groups *mg, struct addr_map_symbol *ams)
 	return ams->ms.sym ? 0 : -1;
 }
 
-static size_t maps__fprintf(struct maps *maps, FILE *fp)
+size_t maps__fprintf(struct maps *maps, FILE *fp)
 {
 	size_t printed = 0;
 	struct map *pos;
@@ -732,19 +713,8 @@ static size_t maps__fprintf(struct maps *maps, FILE *fp)
 	return printed;
 }
 
-size_t map_groups__fprintf(struct map_groups *mg, FILE *fp)
+int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 {
-	return maps__fprintf(&mg->maps, fp);
-}
-
-static void __map_groups__insert(struct map_groups *mg, struct map *map)
-{
-	__maps__insert(&mg->maps, map);
-}
-
-int map_groups__fixup_overlappings(struct map_groups *mg, struct map *map, FILE *fp)
-{
-	struct maps *maps = &mg->maps;
 	struct rb_root *root;
 	struct rb_node *next, *first;
 	int err = 0;
@@ -809,7 +779,7 @@ int map_groups__fixup_overlappings(struct map_groups *mg, struct map *map, FILE 
 			}
 
 			before->end = map->start;
-			__map_groups__insert(mg, before);
+			__maps__insert(maps, before);
 			if (verbose >= 2 && !use_browser)
 				map__fprintf(before, fp);
 			map__put(before);
@@ -826,7 +796,7 @@ int map_groups__fixup_overlappings(struct map_groups *mg, struct map *map, FILE 
 			after->start = map->end;
 			after->pgoff += map->end - pos->start;
 			assert(pos->map_ip(pos, map->end) == after->map_ip(after, map->end));
-			__map_groups__insert(mg, after);
+			__maps__insert(maps, after);
 			if (verbose >= 2 && !use_browser)
 				map__fprintf(after, fp);
 			map__put(after);
@@ -847,16 +817,15 @@ out:
 /*
  * XXX This should not really _copy_ te maps, but refcount them.
  */
-int map_groups__clone(struct thread *thread, struct map_groups *parent)
+int maps__clone(struct thread *thread, struct maps *parent)
 {
-	struct map_groups *mg = thread->mg;
+	struct maps *mg = thread->mg;
 	int err = -ENOMEM;
 	struct map *map;
-	struct maps *maps = &parent->maps;
 
-	down_read(&maps->lock);
+	down_read(&parent->lock);
 
-	maps__for_each_entry(maps, map) {
+	maps__for_each_entry(parent, map) {
 		struct map *new = map__clone(map);
 		if (new == NULL)
 			goto out_unlock;
@@ -865,13 +834,13 @@ int map_groups__clone(struct thread *thread, struct map_groups *parent)
 		if (err)
 			goto out_unlock;
 
-		map_groups__insert(mg, new);
+		maps__insert(mg, new);
 		map__put(new);
 	}
 
 	err = 0;
 out_unlock:
-	up_read(&maps->lock);
+	up_read(&parent->lock);
 	return err;
 }
 
@@ -959,7 +928,7 @@ struct kmap *map__kmap(struct map *map)
 	return kmap;
 }
 
-struct map_groups *map__kmaps(struct map *map)
+struct maps *map__kmaps(struct map *map)
 {
 	struct kmap *kmap = map__kmap(map);
 
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index aafaea2..067036e 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -12,7 +12,7 @@
 #include <linux/types.h>
 
 struct dso;
-struct map_groups;
+struct maps;
 struct machine;
 
 struct map {
@@ -42,7 +42,7 @@ struct kmap;
 
 struct kmap *__map__kmap(struct map *map);
 struct kmap *map__kmap(struct map *map);
-struct map_groups *map__kmaps(struct map *map);
+struct maps *map__kmaps(struct map *map);
 
 static inline u64 map__map_ip(struct map *map, u64 ip)
 {
diff --git a/tools/perf/util/map_groups.h b/tools/perf/util/map_groups.h
index f627024..8a45994 100644
--- a/tools/perf/util/map_groups.h
+++ b/tools/perf/util/map_groups.h
@@ -12,13 +12,9 @@
 struct ref_reloc_sym;
 struct machine;
 struct map;
+struct maps;
 struct thread;
 
-struct maps {
-	struct rb_root      entries;
-	struct rw_semaphore lock;
-};
-
 struct map *maps__find(struct maps *maps, u64 addr);
 struct map *maps__first(struct maps *maps);
 struct map *map__next(struct map *map);
@@ -29,8 +25,9 @@ struct map *map__next(struct map *map);
 #define maps__for_each_entry_safe(maps, map, next) \
 	for (map = maps__first(maps), next = map__next(map); map; map = next, next = map__next(map))
 
-struct map_groups {
-	struct maps	 maps;
+struct maps {
+	struct rb_root      entries;
+	struct rw_semaphore lock;
 	struct machine	 *machine;
 	struct map	 *last_search_by_name;
 	struct map	 **maps_by_name;
@@ -47,55 +44,44 @@ struct map_groups {
 
 struct kmap {
 	struct ref_reloc_sym *ref_reloc_sym;
-	struct map_groups    *kmaps;
+	struct maps	     *kmaps;
 	char		     name[KMAP_NAME_LEN];
 };
 
-struct map_groups *map_groups__new(struct machine *machine);
-void map_groups__delete(struct map_groups *mg);
-bool map_groups__empty(struct map_groups *mg);
+struct maps *maps__new(struct machine *machine);
+void maps__delete(struct maps *mg);
+bool maps__empty(struct maps *mg);
 
-static inline struct map_groups *map_groups__get(struct map_groups *mg)
+static inline struct maps *maps__get(struct maps *mg)
 {
 	if (mg)
 		refcount_inc(&mg->refcnt);
 	return mg;
 }
 
-void map_groups__put(struct map_groups *mg);
-void map_groups__init(struct map_groups *mg, struct machine *machine);
-void map_groups__exit(struct map_groups *mg);
-int map_groups__clone(struct thread *thread, struct map_groups *parent);
-size_t map_groups__fprintf(struct map_groups *mg, FILE *fp);
-
-void map_groups__insert(struct map_groups *mg, struct map *map);
-
-void map_groups__remove(struct map_groups *mg, struct map *map);
-
-static inline struct map *map_groups__find(struct map_groups *mg, u64 addr)
-{
-	return maps__find(&mg->maps, addr);
-}
+void maps__put(struct maps *mg);
+void maps__init(struct maps *mg, struct machine *machine);
+void maps__exit(struct maps *mg);
+int maps__clone(struct thread *thread, struct maps *parent);
+size_t maps__fprintf(struct maps *mg, FILE *fp);
 
-#define map_groups__for_each_entry(mg, map) \
-	for (map = maps__first(&mg->maps); map; map = map__next(map))
+void maps__insert(struct maps *mg, struct map *map);
 
-#define map_groups__for_each_entry_safe(mg, map, next) \
-	for (map = maps__first(&mg->maps), next = map__next(map); map; map = next, next = map__next(map))
+void maps__remove(struct maps *mg, struct map *map);
 
-struct symbol *map_groups__find_symbol(struct map_groups *mg, u64 addr, struct map **mapp);
-struct symbol *map_groups__find_symbol_by_name(struct map_groups *mg, const char *name, struct map **mapp);
+struct symbol *maps__find_symbol(struct maps *mg, u64 addr, struct map **mapp);
+struct symbol *maps__find_symbol_by_name(struct maps *mg, const char *name, struct map **mapp);
 
 struct addr_map_symbol;
 
-int map_groups__find_ams(struct map_groups *mg, struct addr_map_symbol *ams);
+int maps__find_ams(struct maps *mg, struct addr_map_symbol *ams);
 
-int map_groups__fixup_overlappings(struct map_groups *mg, struct map *map, FILE *fp);
+int maps__fixup_overlappings(struct maps *mg, struct map *map, FILE *fp);
 
-struct map *map_groups__find_by_name(struct map_groups *mg, const char *name);
+struct map *maps__find_by_name(struct maps *mg, const char *name);
 
-int map_groups__merge_in(struct map_groups *kmaps, struct map *new_map);
+int maps__merge_in(struct maps *kmaps, struct map *new_map);
 
-void __map_groups__sort_by_name(struct map_groups *mg);
+void __maps__sort_by_name(struct maps *mg);
 
 #endif // __PERF_MAP_GROUPS_H
diff --git a/tools/perf/util/map_symbol.h b/tools/perf/util/map_symbol.h
index 2964d97..bd985c1 100644
--- a/tools/perf/util/map_symbol.h
+++ b/tools/perf/util/map_symbol.h
@@ -4,12 +4,12 @@
 
 #include <linux/types.h>
 
-struct map_groups;
+struct maps;
 struct map;
 struct symbol;
 
 struct map_symbol {
-	struct map_groups *mg;
+	struct maps   *mg;
 	struct map    *map;
 	struct symbol *sym;
 };
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 52b2d16..c06cc97 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -321,7 +321,7 @@ static int kernel_get_module_dso(const char *module, struct dso **pdso)
 		char module_name[128];
 
 		snprintf(module_name, sizeof(module_name), "[%s]", module);
-		map = map_groups__find_by_name(&host_machine->kmaps, module_name);
+		map = maps__find_by_name(&host_machine->kmaps, module_name);
 		if (map) {
 			dso = map->dso;
 			goto found;
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 16776d5..fac3f58 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -844,7 +844,7 @@ void __weak arch__sym_update(struct symbol *s __maybe_unused,
 
 static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 				      GElf_Sym *sym, GElf_Shdr *shdr,
-				      struct map_groups *kmaps, struct kmap *kmap,
+				      struct maps *kmaps, struct kmap *kmap,
 				      struct dso **curr_dsop, struct map **curr_mapp,
 				      const char *section_name,
 				      bool adjust_kernel_syms, bool kmodule, bool *remap_kernel)
@@ -876,8 +876,8 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 			/* Ensure maps are correctly ordered */
 			if (kmaps) {
 				map__get(map);
-				map_groups__remove(kmaps, map);
-				map_groups__insert(kmaps, map);
+				maps__remove(kmaps, map);
+				maps__insert(kmaps, map);
 				map__put(map);
 			}
 		}
@@ -902,7 +902,7 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 
 	snprintf(dso_name, sizeof(dso_name), "%s%s", dso->short_name, section_name);
 
-	curr_map = map_groups__find_by_name(kmaps, dso_name);
+	curr_map = maps__find_by_name(kmaps, dso_name);
 	if (curr_map == NULL) {
 		u64 start = sym->st_value;
 
@@ -928,7 +928,7 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 			curr_map->map_ip = curr_map->unmap_ip = identity__map_ip;
 		}
 		curr_dso->symtab_type = dso->symtab_type;
-		map_groups__insert(kmaps, curr_map);
+		maps__insert(kmaps, curr_map);
 		/*
 		 * Add it before we drop the referece to curr_map, i.e. while
 		 * we still are sure to have a reference to this DSO via
@@ -950,7 +950,7 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 		  struct symsrc *runtime_ss, int kmodule)
 {
 	struct kmap *kmap = dso->kernel ? map__kmap(map) : NULL;
-	struct map_groups *kmaps = kmap ? map__kmaps(map) : NULL;
+	struct maps *kmaps = kmap ? map__kmaps(map) : NULL;
 	struct map *curr_map = map;
 	struct dso *curr_dso = dso;
 	Elf_Data *symstrs, *secstrs;
@@ -1162,7 +1162,7 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 			 * We need to fixup this here too because we create new
 			 * maps here, for things like vsyscall sections.
 			 */
-			map_groups__fixup_end(kmaps);
+			maps__fixup_end(kmaps);
 		}
 	}
 	err = nr;
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index db9667a..c705636 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -239,9 +239,9 @@ void symbols__fixup_end(struct rb_root_cached *symbols)
 		curr->end = roundup(curr->start, 4096) + 4096;
 }
 
-void map_groups__fixup_end(struct map_groups *mg)
+void maps__fixup_end(struct maps *mg)
 {
-	struct maps *maps = &mg->maps;
+	struct maps *maps = mg;
 	struct map *prev = NULL, *curr;
 
 	down_write(&maps->lock);
@@ -698,7 +698,7 @@ static int dso__load_all_kallsyms(struct dso *dso, const char *filename)
 	return kallsyms__parse(filename, dso, map__process_kallsym_symbol);
 }
 
-static int map_groups__split_kallsyms_for_kcore(struct map_groups *kmaps, struct dso *dso)
+static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
 {
 	struct map *curr_map;
 	struct symbol *pos;
@@ -724,7 +724,7 @@ static int map_groups__split_kallsyms_for_kcore(struct map_groups *kmaps, struct
 		if (module)
 			*module = '\0';
 
-		curr_map = map_groups__find(kmaps, pos->start);
+		curr_map = maps__find(kmaps, pos->start);
 
 		if (!curr_map) {
 			symbol__delete(pos);
@@ -751,8 +751,8 @@ static int map_groups__split_kallsyms_for_kcore(struct map_groups *kmaps, struct
  * kernel range is broken in several maps, named [kernel].N, as we don't have
  * the original ELF section names vmlinux have.
  */
-static int map_groups__split_kallsyms(struct map_groups *kmaps, struct dso *dso, u64 delta,
-				      struct map *initial_map)
+static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
+				struct map *initial_map)
 {
 	struct machine *machine;
 	struct map *curr_map = initial_map;
@@ -797,7 +797,7 @@ static int map_groups__split_kallsyms(struct map_groups *kmaps, struct dso *dso,
 					dso__set_loaded(curr_map->dso);
 				}
 
-				curr_map = map_groups__find_by_name(kmaps, module);
+				curr_map = maps__find_by_name(kmaps, module);
 				if (curr_map == NULL) {
 					pr_debug("%s/proc/{kallsyms,modules} "
 					         "inconsistency while looking "
@@ -864,7 +864,7 @@ static int map_groups__split_kallsyms(struct map_groups *kmaps, struct dso *dso,
 			}
 
 			curr_map->map_ip = curr_map->unmap_ip = identity__map_ip;
-			map_groups__insert(kmaps, curr_map);
+			maps__insert(kmaps, curr_map);
 			++kernel_range;
 		} else if (delta) {
 			/* Kernel was relocated at boot time */
@@ -1049,8 +1049,7 @@ out_delete_from:
 	return ret;
 }
 
-static int do_validate_kcore_modules(const char *filename,
-				  struct map_groups *kmaps)
+static int do_validate_kcore_modules(const char *filename, struct maps *kmaps)
 {
 	struct rb_root modules = RB_ROOT;
 	struct map *old_map;
@@ -1060,7 +1059,7 @@ static int do_validate_kcore_modules(const char *filename,
 	if (err)
 		return err;
 
-	map_groups__for_each_entry(kmaps, old_map) {
+	maps__for_each_entry(kmaps, old_map) {
 		struct module_info *mi;
 
 		if (!__map__is_kmodule(old_map)) {
@@ -1107,7 +1106,7 @@ static bool filename_from_kallsyms_filename(char *filename,
 static int validate_kcore_modules(const char *kallsyms_filename,
 				  struct map *map)
 {
-	struct map_groups *kmaps = map__kmaps(map);
+	struct maps *kmaps = map__kmaps(map);
 	char modules_filename[PATH_MAX];
 
 	if (!kmaps)
@@ -1167,15 +1166,15 @@ static int kcore_mapfn(u64 start, u64 len, u64 pgoff, void *data)
 }
 
 /*
- * Merges map into map_groups by splitting the new map
- * within the existing map regions.
+ * Merges map into maps by splitting the new map within the existing map
+ * regions.
  */
-int map_groups__merge_in(struct map_groups *kmaps, struct map *new_map)
+int maps__merge_in(struct maps *kmaps, struct map *new_map)
 {
 	struct map *old_map;
 	LIST_HEAD(merged);
 
-	map_groups__for_each_entry(kmaps, old_map) {
+	maps__for_each_entry(kmaps, old_map) {
 		/* no overload with this one */
 		if (new_map->end < old_map->start ||
 		    new_map->start >= old_map->end)
@@ -1232,12 +1231,12 @@ int map_groups__merge_in(struct map_groups *kmaps, struct map *new_map)
 	while (!list_empty(&merged)) {
 		old_map = list_entry(merged.next, struct map, node);
 		list_del_init(&old_map->node);
-		map_groups__insert(kmaps, old_map);
+		maps__insert(kmaps, old_map);
 		map__put(old_map);
 	}
 
 	if (new_map) {
-		map_groups__insert(kmaps, new_map);
+		maps__insert(kmaps, new_map);
 		map__put(new_map);
 	}
 	return 0;
@@ -1246,7 +1245,7 @@ int map_groups__merge_in(struct map_groups *kmaps, struct map *new_map)
 static int dso__load_kcore(struct dso *dso, struct map *map,
 			   const char *kallsyms_filename)
 {
-	struct map_groups *kmaps = map__kmaps(map);
+	struct maps *kmaps = map__kmaps(map);
 	struct kcore_mapfn_data md;
 	struct map *old_map, *new_map, *replacement_map = NULL, *next;
 	struct machine *machine;
@@ -1295,14 +1294,14 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 	}
 
 	/* Remove old maps */
-	map_groups__for_each_entry_safe(kmaps, old_map, next) {
+	maps__for_each_entry_safe(kmaps, old_map, next) {
 		/*
 		 * We need to preserve eBPF maps even if they are
 		 * covered by kcore, because we need to access
 		 * eBPF dso for source data.
 		 */
 		if (old_map != map && !__map__is_bpf_prog(old_map))
-			map_groups__remove(kmaps, old_map);
+			maps__remove(kmaps, old_map);
 	}
 	machine->trampolines_mapped = false;
 
@@ -1331,8 +1330,8 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 			map->unmap_ip	= new_map->unmap_ip;
 			/* Ensure maps are correctly ordered */
 			map__get(map);
-			map_groups__remove(kmaps, map);
-			map_groups__insert(kmaps, map);
+			maps__remove(kmaps, map);
+			maps__insert(kmaps, map);
 			map__put(map);
 			map__put(new_map);
 		} else {
@@ -1341,7 +1340,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 			 * and ensure that current maps (eBPF)
 			 * stay intact.
 			 */
-			if (map_groups__merge_in(kmaps, new_map))
+			if (maps__merge_in(kmaps, new_map))
 				goto out_err;
 		}
 	}
@@ -1433,9 +1432,9 @@ int __dso__load_kallsyms(struct dso *dso, const char *filename,
 		dso->symtab_type = DSO_BINARY_TYPE__KALLSYMS;
 
 	if (!no_kcore && !dso__load_kcore(dso, map, filename))
-		return map_groups__split_kallsyms_for_kcore(kmap->kmaps, dso);
+		return maps__split_kallsyms_for_kcore(kmap->kmaps, dso);
 	else
-		return map_groups__split_kallsyms(kmap->kmaps, dso, delta, map);
+		return maps__split_kallsyms(kmap->kmaps, dso, delta, map);
 }
 
 int dso__load_kallsyms(struct dso *dso, const char *filename,
@@ -1772,12 +1771,12 @@ static int map__strcmp_name(const void *name, const void *b)
 	return strcmp(name, map->dso->short_name);
 }
 
-void __map_groups__sort_by_name(struct map_groups *mg)
+void __maps__sort_by_name(struct maps *mg)
 {
 	qsort(mg->maps_by_name, mg->nr_maps, sizeof(struct map *), map__strcmp);
 }
 
-static int map__groups__sort_by_name_from_rbtree(struct map_groups *mg)
+static int map__groups__sort_by_name_from_rbtree(struct maps *mg)
 {
 	struct map *map;
 	struct map **maps_by_name = realloc(mg->maps_by_name, mg->nr_maps * sizeof(map));
@@ -1789,14 +1788,14 @@ static int map__groups__sort_by_name_from_rbtree(struct map_groups *mg)
 	mg->maps_by_name = maps_by_name;
 	mg->nr_maps_allocated = mg->nr_maps;
 
-	maps__for_each_entry(&mg->maps, map)
+	maps__for_each_entry(mg, map)
 		maps_by_name[i++] = map;
 
-	__map_groups__sort_by_name(mg);
+	__maps__sort_by_name(mg);
 	return 0;
 }
 
-static struct map *__map_groups__find_by_name(struct map_groups *mg, const char *name)
+static struct map *__maps__find_by_name(struct maps *mg, const char *name)
 {
 	struct map **mapp;
 
@@ -1810,9 +1809,9 @@ static struct map *__map_groups__find_by_name(struct map_groups *mg, const char 
 	return NULL;
 }
 
-struct map *map_groups__find_by_name(struct map_groups *mg, const char *name)
+struct map *maps__find_by_name(struct maps *mg, const char *name)
 {
-	struct maps *maps = &mg->maps;
+	struct maps *maps = mg;
 	struct map *map;
 
 	down_read(&maps->lock);
@@ -1826,7 +1825,7 @@ struct map *map_groups__find_by_name(struct map_groups *mg, const char *name)
 	 * as mg->maps_by_name mirrors the rbtree when lookups by name are
 	 * made.
 	 */
-	map = __map_groups__find_by_name(mg, name);
+	map = __maps__find_by_name(mg, name);
 	if (map || mg->maps_by_name != NULL)
 		goto out_unlock;
 
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 0b718cc..d3e8fae 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -21,7 +21,7 @@
 
 struct dso;
 struct map;
-struct map_groups;
+struct maps;
 struct option;
 
 /*
@@ -108,7 +108,7 @@ struct ref_reloc_sym {
 
 struct addr_location {
 	struct thread *thread;
-	struct map_groups *mg;
+	struct maps   *mg;
 	struct map    *map;
 	struct symbol *sym;
 	const char    *srcline;
@@ -186,7 +186,7 @@ void __symbols__insert(struct rb_root_cached *symbols, struct symbol *sym,
 void symbols__insert(struct rb_root_cached *symbols, struct symbol *sym);
 void symbols__fixup_duplicate(struct rb_root_cached *symbols);
 void symbols__fixup_end(struct rb_root_cached *symbols);
-void map_groups__fixup_end(struct map_groups *mg);
+void maps__fixup_end(struct maps *mg);
 
 typedef int (*mapfn_t)(u64 start, u64 len, u64 pgoff, void *data);
 int file__read_maps(int fd, bool exe, mapfn_t mapfn, void *data,
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 48c3f8b..c423298 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -493,7 +493,7 @@ static int __event__synthesize_thread(union perf_event *comm_event,
 
 		/*
 		 * send mmap only for thread group leader
-		 * see thread__init_map_groups
+		 * see thread__init_maps()
 		 */
 		if (pid == tgid &&
 		    perf_event__synthesize_mmap_events(tool, mmap_event, pid, tgid,
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 0a277a9..b672a2a 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -19,16 +19,16 @@
 
 #include <api/fs/fs.h>
 
-int thread__init_map_groups(struct thread *thread, struct machine *machine)
+int thread__init_maps(struct thread *thread, struct machine *machine)
 {
 	pid_t pid = thread->pid_;
 
 	if (pid == thread->tid || pid == -1) {
-		thread->mg = map_groups__new(machine);
+		thread->mg = maps__new(machine);
 	} else {
 		struct thread *leader = __machine__findnew_thread(machine, pid, pid);
 		if (leader) {
-			thread->mg = map_groups__get(leader->mg);
+			thread->mg = maps__get(leader->mg);
 			thread__put(leader);
 		}
 	}
@@ -87,7 +87,7 @@ void thread__delete(struct thread *thread)
 	thread_stack__free(thread);
 
 	if (thread->mg) {
-		map_groups__put(thread->mg);
+		maps__put(thread->mg);
 		thread->mg = NULL;
 	}
 	down_write(&thread->namespaces_lock);
@@ -324,7 +324,7 @@ int thread__comm_len(struct thread *thread)
 size_t thread__fprintf(struct thread *thread, FILE *fp)
 {
 	return fprintf(fp, "Thread %d %s\n", thread->tid, thread__comm_str(thread)) +
-	       map_groups__fprintf(thread->mg, fp);
+	       maps__fprintf(thread->mg, fp);
 }
 
 int thread__insert_map(struct thread *thread, struct map *map)
@@ -335,8 +335,8 @@ int thread__insert_map(struct thread *thread, struct map *map)
 	if (ret)
 		return ret;
 
-	map_groups__fixup_overlappings(thread->mg, map, stderr);
-	map_groups__insert(thread->mg, map);
+	maps__fixup_overlappings(thread->mg, map, stderr);
+	maps__insert(thread->mg, map);
 
 	return 0;
 }
@@ -345,7 +345,7 @@ static int __thread__prepare_access(struct thread *thread)
 {
 	bool initialized = false;
 	int err = 0;
-	struct maps *maps = &thread->mg->maps;
+	struct maps *maps = thread->mg;
 	struct map *map;
 
 	down_read(&maps->lock);
@@ -371,9 +371,7 @@ static int thread__prepare_access(struct thread *thread)
 	return err;
 }
 
-static int thread__clone_map_groups(struct thread *thread,
-				    struct thread *parent,
-				    bool do_maps_clone)
+static int thread__clone_maps(struct thread *thread, struct thread *parent, bool do_maps_clone)
 {
 	/* This is new thread, we share map groups for process. */
 	if (thread->pid_ == parent->pid_)
@@ -385,7 +383,7 @@ static int thread__clone_map_groups(struct thread *thread,
 		return 0;
 	}
 	/* But this one is new process, copy maps. */
-	return do_maps_clone ? map_groups__clone(thread, parent->mg) : 0;
+	return do_maps_clone ? maps__clone(thread, parent->mg) : 0;
 }
 
 int thread__fork(struct thread *thread, struct thread *parent, u64 timestamp, bool do_maps_clone)
@@ -401,7 +399,7 @@ int thread__fork(struct thread *thread, struct thread *parent, u64 timestamp, bo
 	}
 
 	thread->ppid = parent->tid;
-	return thread__clone_map_groups(thread, parent, do_maps_clone);
+	return thread__clone_maps(thread, parent, do_maps_clone);
 }
 
 void thread__find_cpumode_addr_location(struct thread *thread, u64 addr,
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 51bdb9a..4735d92 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -25,7 +25,7 @@ struct thread {
 		struct rb_node	 rb_node;
 		struct list_head node;
 	};
-	struct map_groups	*mg;
+	struct maps		*mg;
 	pid_t			pid_; /* Not all tools update this */
 	pid_t			tid;
 	pid_t			ppid;
@@ -53,7 +53,7 @@ struct namespaces;
 struct comm;
 
 struct thread *thread__new(pid_t pid, pid_t tid);
-int thread__init_map_groups(struct thread *thread, struct machine *machine);
+int thread__init_maps(struct thread *thread, struct machine *machine);
 void thread__delete(struct thread *thread);
 
 struct thread *thread__get(struct thread *thread);
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index 6d53347..31f77f8 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -616,7 +616,7 @@ static unw_accessors_t accessors = {
 	.get_proc_name		= get_proc_name,
 };
 
-static int _unwind__prepare_access(struct map_groups *mg)
+static int _unwind__prepare_access(struct maps *mg)
 {
 	mg->addr_space = unw_create_addr_space(&accessors, 0);
 	if (!mg->addr_space) {
@@ -628,12 +628,12 @@ static int _unwind__prepare_access(struct map_groups *mg)
 	return 0;
 }
 
-static void _unwind__flush_access(struct map_groups *mg)
+static void _unwind__flush_access(struct maps *mg)
 {
 	unw_flush_cache(mg->addr_space, 0, 0);
 }
 
-static void _unwind__finish_access(struct map_groups *mg)
+static void _unwind__finish_access(struct maps *mg)
 {
 	unw_destroy_addr_space(mg->addr_space);
 }
diff --git a/tools/perf/util/unwind-libunwind.c b/tools/perf/util/unwind-libunwind.c
index a24fb57..3769ae9 100644
--- a/tools/perf/util/unwind-libunwind.c
+++ b/tools/perf/util/unwind-libunwind.c
@@ -12,14 +12,12 @@ struct unwind_libunwind_ops __weak *local_unwind_libunwind_ops;
 struct unwind_libunwind_ops __weak *x86_32_unwind_libunwind_ops;
 struct unwind_libunwind_ops __weak *arm64_unwind_libunwind_ops;
 
-static void unwind__register_ops(struct map_groups *mg,
-			  struct unwind_libunwind_ops *ops)
+static void unwind__register_ops(struct maps *mg, struct unwind_libunwind_ops *ops)
 {
 	mg->unwind_libunwind_ops = ops;
 }
 
-int unwind__prepare_access(struct map_groups *mg, struct map *map,
-			   bool *initialized)
+int unwind__prepare_access(struct maps *mg, struct map *map, bool *initialized)
 {
 	const char *arch;
 	enum dso_type dso_type;
@@ -68,13 +66,13 @@ out_register:
 	return err;
 }
 
-void unwind__flush_access(struct map_groups *mg)
+void unwind__flush_access(struct maps *mg)
 {
 	if (mg->unwind_libunwind_ops)
 		mg->unwind_libunwind_ops->flush_access(mg);
 }
 
-void unwind__finish_access(struct map_groups *mg)
+void unwind__finish_access(struct maps *mg)
 {
 	if (mg->unwind_libunwind_ops)
 		mg->unwind_libunwind_ops->finish_access(mg);
diff --git a/tools/perf/util/unwind.h b/tools/perf/util/unwind.h
index 50337c9..ab8ad46 100644
--- a/tools/perf/util/unwind.h
+++ b/tools/perf/util/unwind.h
@@ -6,7 +6,7 @@
 #include <linux/types.h>
 #include "util/map_symbol.h"
 
-struct map_groups;
+struct maps;
 struct perf_sample;
 struct thread;
 
@@ -18,9 +18,9 @@ struct unwind_entry {
 typedef int (*unwind_entry_cb_t)(struct unwind_entry *entry, void *arg);
 
 struct unwind_libunwind_ops {
-	int (*prepare_access)(struct map_groups *mg);
-	void (*flush_access)(struct map_groups *mg);
-	void (*finish_access)(struct map_groups *mg);
+	int (*prepare_access)(struct maps *maps);
+	void (*flush_access)(struct maps *maps);
+	void (*finish_access)(struct maps *maps);
 	int (*get_entries)(unwind_entry_cb_t cb, void *arg,
 			   struct thread *thread,
 			   struct perf_sample *data, int max_stack);
@@ -45,20 +45,19 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
 #endif
 
 int LIBUNWIND__ARCH_REG_ID(int regnum);
-int unwind__prepare_access(struct map_groups *mg, struct map *map,
-			   bool *initialized);
-void unwind__flush_access(struct map_groups *mg);
-void unwind__finish_access(struct map_groups *mg);
+int unwind__prepare_access(struct maps *maps, struct map *map, bool *initialized);
+void unwind__flush_access(struct maps *maps);
+void unwind__finish_access(struct maps *maps);
 #else
-static inline int unwind__prepare_access(struct map_groups *mg __maybe_unused,
+static inline int unwind__prepare_access(struct maps *maps __maybe_unused,
 					 struct map *map __maybe_unused,
 					 bool *initialized __maybe_unused)
 {
 	return 0;
 }
 
-static inline void unwind__flush_access(struct map_groups *mg __maybe_unused) {}
-static inline void unwind__finish_access(struct map_groups *mg __maybe_unused) {}
+static inline void unwind__flush_access(struct maps *maps __maybe_unused) {}
+static inline void unwind__finish_access(struct maps *maps __maybe_unused) {}
 #endif
 #else
 static inline int
@@ -71,14 +70,14 @@ unwind__get_entries(unwind_entry_cb_t cb __maybe_unused,
 	return 0;
 }
 
-static inline int unwind__prepare_access(struct map_groups *mg __maybe_unused,
+static inline int unwind__prepare_access(struct maps *maps __maybe_unused,
 					 struct map *map __maybe_unused,
 					 bool *initialized __maybe_unused)
 {
 	return 0;
 }
 
-static inline void unwind__flush_access(struct map_groups *mg __maybe_unused) {}
-static inline void unwind__finish_access(struct map_groups *mg __maybe_unused) {}
+static inline void unwind__flush_access(struct maps *maps __maybe_unused) {}
+static inline void unwind__finish_access(struct maps *maps __maybe_unused) {}
 #endif /* HAVE_DWARF_UNWIND_SUPPORT */
 #endif /* __UNWIND_H */
diff --git a/tools/perf/util/vdso.c b/tools/perf/util/vdso.c
index 6e00793..765b29a 100644
--- a/tools/perf/util/vdso.c
+++ b/tools/perf/util/vdso.c
@@ -144,7 +144,7 @@ static enum dso_type machine__thread_dso_type(struct machine *machine,
 	enum dso_type dso_type = DSO__TYPE_UNKNOWN;
 	struct map *map;
 
-	map_groups__for_each_entry(thread->mg, map) {
+	maps__for_each_entry(thread->mg, map) {
 		struct dso *dso = map->dso;
 		if (!dso || dso->long_name[0] != '/')
 			continue;
