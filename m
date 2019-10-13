Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E340C4CECE
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 15:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB7320869
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 15:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570979692;
	bh=xlBZIMxKPhX8ZEEqQWR7S70s74HhMxf0myYKSRcrhv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EzB/uG30dN5zqisI7LC3PH1pXYiYNUvsnM9KbT9g/c7nbH1SZyCE/X6N3g3+HhBnY
	 A7+wnSt5sbuK+U9itn+dtQZmtyNyRF1445tNRaoVnbL7G9h31mmOfWQLQmYuIShqGZ
	 QHwNXkJW0EaFYAr+NWt5nvnUU9dpus//0/4MBwiA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbfJMPOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 11:14:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50534 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbfJMPOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 11:14:38 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5666381F18;
        Sun, 13 Oct 2019 15:14:37 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-28.brq.redhat.com [10.40.204.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 40B39600C6;
        Sun, 13 Oct 2019 15:14:34 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 2/3] perf tools: Separate shareable part of 'struct map' into 'struct map_shared'
Date:   Sun, 13 Oct 2019 17:14:26 +0200
Message-Id: <20191013151427.11941-3-jolsa@kernel.org>
In-Reply-To: <20191013151427.11941-1-jolsa@kernel.org>
References: <20191013151427.11941-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Sun, 13 Oct 2019 15:14:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is preparation for truly sharing the 'struct map_shared'.
So far it's statically added inside 'struct map', so there's
no functional change expected other than compilation fail.

Link: http://lkml.kernel.org/n/tip-5gfhdwgqzq8eau12caairka3@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/arch/arm/tests/dwarf-unwind.c      |   2 +-
 tools/perf/arch/arm64/tests/dwarf-unwind.c    |   2 +-
 tools/perf/arch/powerpc/tests/dwarf-unwind.c  |   2 +-
 .../arch/powerpc/util/skip-callchain-idx.c    |   4 +-
 tools/perf/arch/powerpc/util/sym-handling.c   |   4 +-
 tools/perf/arch/s390/annotate/instructions.c  |   2 +-
 tools/perf/arch/x86/tests/dwarf-unwind.c      |   2 +-
 tools/perf/arch/x86/util/event.c              |   6 +-
 tools/perf/builtin-annotate.c                 |   8 +-
 tools/perf/builtin-inject.c                   |  10 +-
 tools/perf/builtin-kallsyms.c                 |   7 +-
 tools/perf/builtin-kmem.c                     |   2 +-
 tools/perf/builtin-mem.c                      |   6 +-
 tools/perf/builtin-report.c                   |  19 +-
 tools/perf/builtin-script.c                   |  16 +-
 tools/perf/builtin-top.c                      |  15 +-
 tools/perf/builtin-trace.c                    |   2 +-
 tools/perf/tests/code-reading.c               |  34 ++--
 tools/perf/tests/hists_common.c               |   4 +-
 tools/perf/tests/hists_cumulate.c             |   4 +-
 tools/perf/tests/hists_filter.c               |   4 +-
 tools/perf/tests/hists_output.c               |   2 +-
 tools/perf/tests/map_groups.c                 |  22 +--
 tools/perf/tests/mmap-thread-lookup.c         |   2 +-
 tools/perf/tests/vmlinux-kallsyms.c           |  36 ++--
 tools/perf/ui/browsers/annotate.c             |   4 +-
 tools/perf/ui/browsers/hists.c                |  10 +-
 tools/perf/ui/browsers/map.c                  |   4 +-
 tools/perf/ui/gtk/annotate.c                  |   2 +-
 tools/perf/util/annotate.c                    |  34 ++--
 tools/perf/util/auxtrace.c                    |   2 +-
 tools/perf/util/bpf-event.c                   |   8 +-
 tools/perf/util/build-id.c                    |   2 +-
 tools/perf/util/callchain.c                   |   6 +-
 tools/perf/util/db-export.c                   |   4 +-
 tools/perf/util/dso.c                         |   2 +-
 tools/perf/util/event.c                       |   6 +-
 tools/perf/util/evsel_fprintf.c               |   2 +-
 tools/perf/util/hist.c                        |  10 +-
 tools/perf/util/intel-pt.c                    |  42 +++--
 tools/perf/util/machine.c                     |  76 ++++----
 tools/perf/util/map.c                         | 168 ++++++++++--------
 tools/perf/util/map.h                         |  29 +--
 tools/perf/util/probe-event.c                 |  32 ++--
 .../util/scripting-engines/trace-event-perl.c |   8 +-
 .../scripting-engines/trace-event-python.c    |  12 +-
 tools/perf/util/sort.c                        |  58 +++---
 tools/perf/util/symbol-elf.c                  |  28 +--
 tools/perf/util/symbol.c                      |  78 ++++----
 tools/perf/util/symbol_fprintf.c              |   2 +-
 tools/perf/util/synthetic-events.c            |  14 +-
 tools/perf/util/thread.c                      |  14 +-
 tools/perf/util/unwind-libdw.c                |  16 +-
 tools/perf/util/unwind-libunwind-local.c      |  37 ++--
 tools/perf/util/unwind-libunwind.c            |   4 +-
 tools/perf/util/vdso.c                        |   2 +-
 56 files changed, 489 insertions(+), 444 deletions(-)

diff --git a/tools/perf/arch/arm/tests/dwarf-unwind.c b/tools/perf/arch/arm/tests/dwarf-unwind.c
index 2c35e532bc9a..0b2cf5a1651f 100644
--- a/tools/perf/arch/arm/tests/dwarf-unwind.c
+++ b/tools/perf/arch/arm/tests/dwarf-unwind.c
@@ -33,7 +33,7 @@ static int sample_ustack(struct perf_sample *sample,
 		return -1;
 	}
 
-	stack_size = map->end - sp;
+	stack_size = map_sh(map)->end - sp;
 	stack_size = stack_size > STACK_SIZE ? STACK_SIZE : stack_size;
 
 	memcpy(buf, (void *) sp, stack_size);
diff --git a/tools/perf/arch/arm64/tests/dwarf-unwind.c b/tools/perf/arch/arm64/tests/dwarf-unwind.c
index a6a407fa1b8b..d4e33a53f91c 100644
--- a/tools/perf/arch/arm64/tests/dwarf-unwind.c
+++ b/tools/perf/arch/arm64/tests/dwarf-unwind.c
@@ -33,7 +33,7 @@ static int sample_ustack(struct perf_sample *sample,
 		return -1;
 	}
 
-	stack_size = map->end - sp;
+	stack_size = map_sh(map)->end - sp;
 	stack_size = stack_size > STACK_SIZE ? STACK_SIZE : stack_size;
 
 	memcpy(buf, (void *) sp, stack_size);
diff --git a/tools/perf/arch/powerpc/tests/dwarf-unwind.c b/tools/perf/arch/powerpc/tests/dwarf-unwind.c
index 5c178e4a1995..d5d8817d8363 100644
--- a/tools/perf/arch/powerpc/tests/dwarf-unwind.c
+++ b/tools/perf/arch/powerpc/tests/dwarf-unwind.c
@@ -34,7 +34,7 @@ static int sample_ustack(struct perf_sample *sample,
 		return -1;
 	}
 
-	stack_size = map->end - sp;
+	stack_size = map_sh(map)->end - sp;
 	stack_size = stack_size > STACK_SIZE ? STACK_SIZE : stack_size;
 
 	memcpy(buf, (void *) sp, stack_size);
diff --git a/tools/perf/arch/powerpc/util/skip-callchain-idx.c b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
index 3018a054526a..3e26e66e2999 100644
--- a/tools/perf/arch/powerpc/util/skip-callchain-idx.c
+++ b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
@@ -255,14 +255,14 @@ int arch_skip_callchain_idx(struct thread *thread, struct ip_callchain *chain)
 	thread__find_symbol(thread, PERF_RECORD_MISC_USER, ip, &al);
 
 	if (al.map)
-		dso = al.map->dso;
+		dso = map_sh(al.map)->dso;
 
 	if (!dso) {
 		pr_debug("%" PRIx64 " dso is NULL\n", ip);
 		return skip_slot;
 	}
 
-	rc = check_return_addr(dso, al.map->start, ip);
+	rc = check_return_addr(dso, map_sh(al.map)->start, ip);
 
 	pr_debug("[DSO %s, sym %s, ip 0x%" PRIx64 "] rc %d\n",
 				dso->long_name, al.sym->name, ip, rc);
diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
index abb7a12d8f93..d069e7a60b23 100644
--- a/tools/perf/arch/powerpc/util/sym-handling.c
+++ b/tools/perf/arch/powerpc/util/sym-handling.c
@@ -114,7 +114,7 @@ void arch__fix_tev_from_maps(struct perf_probe_event *pev,
 
 	lep_offset = PPC64_LOCAL_ENTRY_OFFSET(sym->arch_sym);
 
-	if (map->dso->symtab_type == DSO_BINARY_TYPE__KALLSYMS)
+	if (map_sh(map)->dso->symtab_type == DSO_BINARY_TYPE__KALLSYMS)
 		tev->point.offset += PPC64LE_LEP_OFFSET;
 	else if (lep_offset) {
 		if (pev->uprobes)
@@ -141,7 +141,7 @@ void arch__post_process_probe_trace_events(struct perf_probe_event *pev,
 	for (i = 0; i < ntevs; i++) {
 		tev = &pev->tevs[i];
 		map__for_each_symbol(map, sym, tmp) {
-			if (map->unmap_ip(map, sym->start) == tev->point.address) {
+			if (map_sh(map)->unmap_ip(map, sym->start) == tev->point.address) {
 				arch__fix_tev_from_maps(pev, tev, map, sym);
 				break;
 			}
diff --git a/tools/perf/arch/s390/annotate/instructions.c b/tools/perf/arch/s390/annotate/instructions.c
index a50e70baf918..2b3980be78c6 100644
--- a/tools/perf/arch/s390/annotate/instructions.c
+++ b/tools/perf/arch/s390/annotate/instructions.c
@@ -39,7 +39,7 @@ static int s390_call__parse(struct arch *arch, struct ins_operands *ops,
 	target.addr = map__objdump_2mem(map, ops->target.addr);
 
 	if (map_groups__find_ams(&target) == 0 &&
-	    map__rip_2objdump(target.map, map->map_ip(target.map, target.addr)) == ops->target.addr)
+	    map__rip_2objdump(target.map, map_sh(map)->map_ip(target.map, target.addr)) == ops->target.addr)
 		ops->target.sym = target.sym;
 
 	return 0;
diff --git a/tools/perf/arch/x86/tests/dwarf-unwind.c b/tools/perf/arch/x86/tests/dwarf-unwind.c
index 6ad0a1cedb13..37d9f41ef572 100644
--- a/tools/perf/arch/x86/tests/dwarf-unwind.c
+++ b/tools/perf/arch/x86/tests/dwarf-unwind.c
@@ -34,7 +34,7 @@ static int sample_ustack(struct perf_sample *sample,
 		return -1;
 	}
 
-	stack_size = map->end - sp;
+	stack_size = map_sh(map)->end - sp;
 	stack_size = stack_size > STACK_SIZE ? STACK_SIZE : stack_size;
 
 	memcpy(buf, (void *) sp, stack_size);
diff --git a/tools/perf/arch/x86/util/event.c b/tools/perf/arch/x86/util/event.c
index d357c625c09f..b3243d8db038 100644
--- a/tools/perf/arch/x86/util/event.c
+++ b/tools/perf/arch/x86/util/event.c
@@ -57,9 +57,9 @@ int perf_event__synthesize_extra_kmaps(struct perf_tool *tool,
 
 		event->mmap.header.size = size;
 
-		event->mmap.start = pos->start;
-		event->mmap.len   = pos->end - pos->start;
-		event->mmap.pgoff = pos->pgoff;
+		event->mmap.start = map_sh(pos)->start;
+		event->mmap.len   = map_sh(pos)->end - map_sh(pos)->start;
+		event->mmap.pgoff = map_sh(pos)->pgoff;
 		event->mmap.pid   = machine->pid;
 
 		strlcpy(event->mmap.filename, kmap->name, PATH_MAX);
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 8db8fc9bddef..3036f6a8ecb7 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -199,7 +199,7 @@ static int process_branch_callback(struct evsel *evsel,
 		return 0;
 
 	if (a.map != NULL)
-		a.map->dso->hit = 1;
+		map_sh(a.map)->dso->hit = 1;
 
 	hist__account_cycles(sample->branch_stack, al, sample, false);
 
@@ -233,9 +233,9 @@ static int perf_evsel__add_sample(struct evsel *evsel,
 		 */
 		if (al->sym != NULL) {
 			rb_erase_cached(&al->sym->rb_node,
-				 &al->map->dso->symbols);
+				 &map_sh(al->map)->dso->symbols);
 			symbol__delete(al->sym);
-			dso__reset_find_symbol_cache(al->map->dso);
+			dso__reset_find_symbol_cache(map_sh(al->map)->dso);
 		}
 		return 0;
 	}
@@ -317,7 +317,7 @@ static void hists__find_annotations(struct hists *hists,
 		struct hist_entry *he = rb_entry(nd, struct hist_entry, rb_node);
 		struct annotation *notes;
 
-		if (he->ms.sym == NULL || he->ms.map->dso->annotate_warned)
+		if (he->ms.sym == NULL || map_sh(he->ms.map)->dso->annotate_warned)
 			goto find_next;
 
 		if (ann->sym_hist_filter &&
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 372ecb3e2c06..1a5c49dcb13b 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -440,10 +440,12 @@ static int perf_event__inject_buildid(struct perf_tool *tool,
 	}
 
 	if (thread__find_map(thread, sample->cpumode, sample->ip, &al)) {
-		if (!al.map->dso->hit) {
-			al.map->dso->hit = 1;
+		struct map_shared *sh = map_sh(al.map);
+
+		if (!sh->dso->hit) {
+			sh->dso->hit = 1;
 			if (map__load(al.map) >= 0) {
-				dso__inject_build_id(al.map->dso, tool, machine);
+				dso__inject_build_id(sh->dso, tool, machine);
 				/*
 				 * If this fails, too bad, let the other side
 				 * account this as unresolved.
@@ -452,7 +454,7 @@ static int perf_event__inject_buildid(struct perf_tool *tool,
 #ifdef HAVE_LIBELF_SUPPORT
 				pr_warning("no symbols found in %s, maybe "
 					   "install a debug package?\n",
-					   al.map->dso->long_name);
+					   sh->dso->long_name);
 #endif
 			}
 		}
diff --git a/tools/perf/builtin-kallsyms.c b/tools/perf/builtin-kallsyms.c
index c08ee81529e8..36b6f6adbda6 100644
--- a/tools/perf/builtin-kallsyms.c
+++ b/tools/perf/builtin-kallsyms.c
@@ -28,6 +28,7 @@ static int __cmd_kallsyms(int argc, const char **argv)
 
 	for (i = 0; i < argc; ++i) {
 		struct map *map;
+		struct map_shared *sh;
 		struct symbol *symbol = machine__find_kernel_symbol_by_name(machine, argv[i], &map);
 
 		if (symbol == NULL) {
@@ -35,9 +36,11 @@ static int __cmd_kallsyms(int argc, const char **argv)
 			continue;
 		}
 
+		sh = map_sh(map);
+
 		printf("%s: %s %s %#" PRIx64 "-%#" PRIx64 " (%#" PRIx64 "-%#" PRIx64")\n",
-			symbol->name, map->dso->short_name, map->dso->long_name,
-			map->unmap_ip(map, symbol->start), map->unmap_ip(map, symbol->end),
+			symbol->name, sh->dso->short_name, sh->dso->long_name,
+			sh->unmap_ip(map, symbol->start), sh->unmap_ip(map, symbol->end),
 			symbol->start, symbol->end);
 	}
 
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 1e61e353f579..1f4087051894 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -1016,7 +1016,7 @@ static void __print_slab_result(struct rb_root *root,
 
 		if (sym != NULL)
 			snprintf(buf, sizeof(buf), "%s+%" PRIx64 "", sym->name,
-				 addr - map->unmap_ip(map, sym->start));
+				 addr - map_sh(map)->unmap_ip(map, sym->start));
 		else
 			snprintf(buf, sizeof(buf), "%#" PRIx64 "", addr);
 		printf(" %-34s |", buf);
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index a13f5817d6fc..ca456fb663a4 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -169,7 +169,7 @@ dump_raw_samples(struct perf_tool *tool,
 		goto out_put;
 
 	if (al.map != NULL)
-		al.map->dso->hit = 1;
+		map_sh(al.map)->dso->hit = 1;
 
 	if (mem->phys_addr) {
 		if (symbol_conf.field_sep) {
@@ -197,7 +197,7 @@ dump_raw_samples(struct perf_tool *tool,
 			symbol_conf.field_sep,
 			sample->data_src,
 			symbol_conf.field_sep,
-			al.map ? (al.map->dso ? al.map->dso->long_name : "???") : "???",
+			al.map ? (map_sh(al.map)->dso ? map_sh(al.map)->dso->long_name : "???") : "???",
 			al.sym ? al.sym->name : "???");
 	} else {
 		if (symbol_conf.field_sep) {
@@ -222,7 +222,7 @@ dump_raw_samples(struct perf_tool *tool,
 			symbol_conf.field_sep,
 			sample->data_src,
 			symbol_conf.field_sep,
-			al.map ? (al.map->dso ? al.map->dso->long_name : "???") : "???",
+			al.map ? (map_sh(al.map)->dso ? map_sh(al.map)->dso->long_name : "???") : "???",
 			al.sym ? al.sym->name : "???");
 	}
 out_put:
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index aae0e57c60fb..9e8f85a58826 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -288,7 +288,7 @@ static int process_sample_event(struct perf_tool *tool,
 	}
 
 	if (al.map != NULL)
-		al.map->dso->hit = 1;
+		map_sh(al.map)->dso->hit = 1;
 
 	if (ui__has_annotation() || rep->symbol_ipc) {
 		hist__account_cycles(sample->branch_stack, &al, sample,
@@ -524,7 +524,7 @@ static void report__warn_kptr_restrict(const struct report *rep)
 		return;
 
 	if (kernel_map == NULL ||
-	    (kernel_map->dso->hit &&
+	    (map_sh(kernel_map)->dso->hit &&
 	     (kernel_kmap->ref_reloc_sym == NULL ||
 	      kernel_kmap->ref_reloc_sym->addr == 0))) {
 		const char *desc =
@@ -724,15 +724,16 @@ static size_t maps__fprintf_task(struct maps *maps, int indent, FILE *fp)
 
 	for (nd = rb_first(&maps->entries); nd; nd = rb_next(nd)) {
 		struct map *map = rb_entry(nd, struct map, rb_node);
+		struct map_shared *sh = map_sh(map);
 
 		printed += fprintf(fp, "%*s  %" PRIx64 "-%" PRIx64 " %c%c%c%c %08" PRIx64 " %" PRIu64 " %s\n",
-				   indent, "", map->start, map->end,
-				   map->prot & PROT_READ ? 'r' : '-',
-				   map->prot & PROT_WRITE ? 'w' : '-',
-				   map->prot & PROT_EXEC ? 'x' : '-',
-				   map->flags & MAP_SHARED ? 's' : 'p',
-				   map->pgoff,
-				   map->ino, map->dso->name);
+				   indent, "", sh->start, sh->end,
+				   sh->prot  & PROT_READ ?  'r' : '-',
+				   sh->prot  & PROT_WRITE ? 'w' : '-',
+				   sh->prot  & PROT_EXEC ?  'x' : '-',
+				   sh->flags & MAP_SHARED ? 's' : 'p',
+				   sh->pgoff,
+				   sh->ino, sh->dso->name);
 	}
 
 	return printed;
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 1c797a948ada..018ccc2aedb5 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -842,11 +842,11 @@ static int perf_sample__fprintf_brstackoff(struct perf_sample *sample,
 		to   = br->entries[i].to;
 
 		if (thread__find_map_fb(thread, sample->cpumode, from, &alf) &&
-		    !alf.map->dso->adjust_symbols)
+		    !map_sh(alf.map)->dso->adjust_symbols)
 			from = map__map_ip(alf.map, from);
 
 		if (thread__find_map_fb(thread, sample->cpumode, to, &alt) &&
-		    !alt.map->dso->adjust_symbols)
+		    !map_sh(alt.map)->dso->adjust_symbols)
 			to = map__map_ip(alt.map, to);
 
 		printed += fprintf(fp, " 0x%"PRIx64, from);
@@ -909,11 +909,11 @@ static int grab_bb(u8 *buffer, u64 start, u64 end,
 		return 0;
 	}
 
-	if (!thread__find_map(thread, *cpumode, start, &al) || !al.map->dso) {
+	if (!thread__find_map(thread, *cpumode, start, &al) || !map_sh(al.map)->dso) {
 		pr_debug("\tcannot resolve %" PRIx64 "-%" PRIx64 "\n", start, end);
 		return 0;
 	}
-	if (al.map->dso->data.status == DSO_DATA_STATUS_ERROR) {
+	if (map_sh(al.map)->dso->data.status == DSO_DATA_STATUS_ERROR) {
 		pr_debug("\tcannot resolve %" PRIx64 "-%" PRIx64 "\n", start, end);
 		return 0;
 	}
@@ -921,11 +921,11 @@ static int grab_bb(u8 *buffer, u64 start, u64 end,
 	/* Load maps to ensure dso->is_64_bit has been updated */
 	map__load(al.map);
 
-	offset = al.map->map_ip(al.map, start);
-	len = dso__data_read_offset(al.map->dso, machine, offset, (u8 *)buffer,
+	offset = map_sh(al.map)->map_ip(al.map, start);
+	len = dso__data_read_offset(map_sh(al.map)->dso, machine, offset, (u8 *)buffer,
 				    end - start + MAXINSN);
 
-	*is64bit = al.map->dso->is_64_bit;
+	*is64bit = map_sh(al.map)->dso->is_64_bit;
 	if (len <= 0)
 		pr_debug("\tcannot fetch code for block at %" PRIx64 "-%" PRIx64 "\n",
 			start, end);
@@ -992,7 +992,7 @@ static int ip__fprintf_sym(uint64_t addr, struct thread *thread,
 	if (al.addr < al.sym->end)
 		off = al.addr - al.sym->start;
 	else
-		off = al.addr - al.map->start - al.sym->start;
+		off = al.addr - map_sh(al.map)->start - al.sym->start;
 	printed += fprintf(fp, "\t%s", al.sym->name);
 	if (off)
 		printed += fprintf(fp, "%+d", off);
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index d96f24c8770d..5665a7e4fc2e 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -124,8 +124,8 @@ static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
 	/*
 	 * We can't annotate with just /proc/kallsyms
 	 */
-	if (map->dso->symtab_type == DSO_BINARY_TYPE__KALLSYMS &&
-	    !dso__is_kcore(map->dso)) {
+	if (map_sh(map)->dso->symtab_type == DSO_BINARY_TYPE__KALLSYMS &&
+	    !dso__is_kcore(map_sh(map)->dso)) {
 		pr_err("Can't annotate %s: No vmlinux file was found in the "
 		       "path\n", sym->name);
 		sleep(1);
@@ -164,6 +164,7 @@ static void __zero_source_counters(struct hist_entry *he)
 
 static void ui__warn_map_erange(struct map *map, struct symbol *sym, u64 ip)
 {
+	struct map_shared *sh = map_sh(map);
 	struct utsname uts;
 	int err = uname(&uts);
 
@@ -177,8 +178,8 @@ static void ui__warn_map_erange(struct map *map, struct symbol *sym, u64 ip)
 		    "Tools:  %s\n\n"
 		    "Not all samples will be on the annotation output.\n\n"
 		    "Please report to linux-kernel@vger.kernel.org\n",
-		    ip, map->dso->long_name, dso__symtab_origin(map->dso),
-		    map->start, map->end, sym->start, sym->end,
+		    ip, sh->dso->long_name, dso__symtab_origin(sh->dso),
+		    sh->start, sh->end, sym->start, sym->end,
 		    sym->binding == STB_GLOBAL ? 'g' :
 		    sym->binding == STB_LOCAL  ? 'l' : 'w', sym->name,
 		    err ? "[unknown]" : uts.machine,
@@ -186,7 +187,7 @@ static void ui__warn_map_erange(struct map *map, struct symbol *sym, u64 ip)
 	if (use_browser <= 0)
 		sleep(5);
 
-	map->erange_warned = true;
+	sh->erange_warned = true;
 }
 
 static void perf_top__record_precise_ip(struct perf_top *top,
@@ -219,7 +220,7 @@ static void perf_top__record_precise_ip(struct perf_top *top,
 		 */
 		pthread_mutex_unlock(&he->hists->lock);
 
-		if (err == -ERANGE && !he->ms.map->erange_warned)
+		if (err == -ERANGE && !map_sh(he->ms.map)->erange_warned)
 			ui__warn_map_erange(he->ms.map, sym, ip);
 		else if (err == -ENOMEM) {
 			pr_err("Not enough memory for annotating '%s' symbol!\n",
@@ -798,7 +799,7 @@ static void perf_event__process_sample(struct perf_tool *tool,
 		    __map__is_kernel(al.map) && map__has_symbols(al.map)) {
 			if (symbol_conf.vmlinux_name) {
 				char serr[256];
-				dso__strerror_load(al.map->dso, serr, sizeof(serr));
+				dso__strerror_load(map_sh(al.map)->dso, serr, sizeof(serr));
 				ui__warning("The %s file can't be used: %s\n%s",
 					    symbol_conf.vmlinux_name, serr, msg);
 			} else {
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 144d417ddb22..b5f5c79389bc 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2619,7 +2619,7 @@ static void print_location(FILE *f, struct perf_sample *sample,
 {
 
 	if ((verbose > 0 || print_dso) && al->map)
-		fprintf(f, "%s@", al->map->dso->long_name);
+		fprintf(f, "%s@", map_sh(al->map)->dso->long_name);
 
 	if ((verbose > 0 || print_sym) && al->sym)
 		fprintf(f, "%s+0x%" PRIx64, al->sym->name,
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 1f017e1b2a55..d2be7c9e1798 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -236,6 +236,7 @@ static void dump_buf(unsigned char *buf, size_t len)
 static int read_object_code(u64 addr, size_t len, u8 cpumode,
 			    struct thread *thread, struct state *state)
 {
+	struct map_shared *sh;
 	struct addr_location al;
 	unsigned char buf1[BUFSZ];
 	unsigned char buf2[BUFSZ];
@@ -248,7 +249,7 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 
 	pr_debug("Reading object code for memory address: %#"PRIx64"\n", addr);
 
-	if (!thread__find_map(thread, cpumode, addr, &al) || !al.map->dso) {
+	if (!thread__find_map(thread, cpumode, addr, &al) || !map_sh(al.map)->dso) {
 		if (cpumode == PERF_RECORD_MISC_HYPERVISOR) {
 			pr_debug("Hypervisor address can not be resolved - skipping\n");
 			return 0;
@@ -258,10 +259,11 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 		return -1;
 	}
 
-	pr_debug("File is: %s\n", al.map->dso->long_name);
+	sh = map_sh(al.map);
+	pr_debug("File is: %s\n", sh->dso->long_name);
 
-	if (al.map->dso->symtab_type == DSO_BINARY_TYPE__KALLSYMS &&
-	    !dso__is_kcore(al.map->dso)) {
+	if (sh->dso->symtab_type == DSO_BINARY_TYPE__KALLSYMS &&
+	    !dso__is_kcore(sh->dso)) {
 		pr_debug("Unexpected kernel address - skipping\n");
 		return 0;
 	}
@@ -272,11 +274,11 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 		len = BUFSZ;
 
 	/* Do not go off the map */
-	if (addr + len > al.map->end)
-		len = al.map->end - addr;
+	if (addr + len > sh->end)
+		len = sh->end - addr;
 
 	/* Read the object code using perf */
-	ret_len = dso__data_read_offset(al.map->dso, thread->mg->machine,
+	ret_len = dso__data_read_offset(sh->dso, thread->mg->machine,
 					al.addr, buf1, len);
 	if (ret_len != len) {
 		pr_debug("dso__data_read_offset failed\n");
@@ -291,11 +293,11 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 		return -1;
 
 	/* objdump struggles with kcore - try each map only once */
-	if (dso__is_kcore(al.map->dso)) {
+	if (dso__is_kcore(sh->dso)) {
 		size_t d;
 
 		for (d = 0; d < state->done_cnt; d++) {
-			if (state->done[d] == al.map->start) {
+			if (state->done[d] == sh->start) {
 				pr_debug("kcore map tested already");
 				pr_debug(" - skipping\n");
 				return 0;
@@ -305,12 +307,12 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 			pr_debug("Too many kcore maps - skipping\n");
 			return 0;
 		}
-		state->done[state->done_cnt++] = al.map->start;
+		state->done[state->done_cnt++] = sh->start;
 	}
 
-	objdump_name = al.map->dso->long_name;
-	if (dso__needs_decompress(al.map->dso)) {
-		if (dso__decompress_kmodule_path(al.map->dso, objdump_name,
+	objdump_name = sh->dso->long_name;
+	if (dso__needs_decompress(sh->dso)) {
+		if (dso__decompress_kmodule_path(sh->dso, objdump_name,
 						 decomp_name,
 						 sizeof(decomp_name)) < 0) {
 			pr_debug("decompression failed\n");
@@ -338,7 +340,7 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 			len -= ret;
 			if (len) {
 				pr_debug("Reducing len to %zu\n", len);
-			} else if (dso__is_kcore(al.map->dso)) {
+			} else if (dso__is_kcore(sh->dso)) {
 				/*
 				 * objdump cannot handle very large segments
 				 * that may be found in kcore.
@@ -596,8 +598,8 @@ static int do_test_code_reading(bool try_kcore)
 		pr_debug("map__load failed\n");
 		goto out_err;
 	}
-	have_vmlinux = dso__is_vmlinux(map->dso);
-	have_kcore = dso__is_kcore(map->dso);
+	have_vmlinux = dso__is_vmlinux(map_sh(map)->dso);
+	have_kcore = dso__is_kcore(map_sh(map)->dso);
 
 	/* 2nd time through we just try kcore */
 	if (try_kcore && !have_kcore)
diff --git a/tools/perf/tests/hists_common.c b/tools/perf/tests/hists_common.c
index 6f34d08b84e5..51eed6b32f49 100644
--- a/tools/perf/tests/hists_common.c
+++ b/tools/perf/tests/hists_common.c
@@ -181,7 +181,7 @@ void print_hists_in(struct hists *hists)
 		if (!he->filtered) {
 			pr_info("%2d: entry: %-8s [%-8s] %20s: period = %"PRIu64"\n",
 				i, thread__comm_str(he->thread),
-				he->ms.map->dso->short_name,
+				map_sh(he->ms.map)->dso->short_name,
 				he->ms.sym->name, he->stat.period);
 		}
 
@@ -208,7 +208,7 @@ void print_hists_out(struct hists *hists)
 		if (!he->filtered) {
 			pr_info("%2d: entry: %8s:%5d [%-8s] %20s: period = %"PRIu64"/%"PRIu64"\n",
 				i, thread__comm_str(he->thread), he->thread->tid,
-				he->ms.map->dso->short_name,
+				map_sh(he->ms.map)->dso->short_name,
 				he->ms.sym->name, he->stat.period,
 				he->stat_acc ? he->stat_acc->period : 0);
 		}
diff --git a/tools/perf/tests/hists_cumulate.c b/tools/perf/tests/hists_cumulate.c
index 6367c8f6ca22..3cd68f13caea 100644
--- a/tools/perf/tests/hists_cumulate.c
+++ b/tools/perf/tests/hists_cumulate.c
@@ -150,12 +150,12 @@ static void del_hist_entries(struct hists *hists)
 typedef int (*test_fn_t)(struct evsel *, struct machine *);
 
 #define COMM(he)  (thread__comm_str(he->thread))
-#define DSO(he)   (he->ms.map->dso->short_name)
+#define DSO(he)   (map_sh(he->ms.map)->dso->short_name)
 #define SYM(he)   (he->ms.sym->name)
 #define CPU(he)   (he->cpu)
 #define PID(he)   (he->thread->tid)
 #define DEPTH(he) (he->callchain->max_depth)
-#define CDSO(cl)  (cl->ms.map->dso->short_name)
+#define CDSO(cl)  (map_sh(cl->ms.map)->dso->short_name)
 #define CSYM(cl)  (cl->ms.sym->name)
 
 struct result {
diff --git a/tools/perf/tests/hists_filter.c b/tools/perf/tests/hists_filter.c
index 618b51ffcc01..d9cd6146392e 100644
--- a/tools/perf/tests/hists_filter.c
+++ b/tools/perf/tests/hists_filter.c
@@ -194,7 +194,7 @@ int test__hists_filter(struct test *test __maybe_unused, int subtest __maybe_unu
 		hists__filter_by_thread(hists);
 
 		/* now applying dso filter for 'kernel' */
-		hists->dso_filter = fake_samples[0].map->dso;
+		hists->dso_filter = map_sh(fake_samples[0].map)->dso;
 		hists__filter_by_dso(hists);
 
 		if (verbose > 2) {
@@ -288,7 +288,7 @@ int test__hists_filter(struct test *test __maybe_unused, int subtest __maybe_unu
 
 		/* now applying all filters at once. */
 		hists->thread_filter = fake_samples[1].thread;
-		hists->dso_filter = fake_samples[1].map->dso;
+		hists->dso_filter = map_sh(fake_samples[1].map)->dso;
 		hists__filter_by_thread(hists);
 		hists__filter_by_dso(hists);
 
diff --git a/tools/perf/tests/hists_output.c b/tools/perf/tests/hists_output.c
index 38f804ff6452..a6aa54ec3dd1 100644
--- a/tools/perf/tests/hists_output.c
+++ b/tools/perf/tests/hists_output.c
@@ -116,7 +116,7 @@ static void del_hist_entries(struct hists *hists)
 typedef int (*test_fn_t)(struct evsel *, struct machine *);
 
 #define COMM(he)  (thread__comm_str(he->thread))
-#define DSO(he)   (he->ms.map->dso->short_name)
+#define DSO(he)   (map_sh(he->ms.map)->dso->short_name)
 #define SYM(he)   (he->ms.sym->name)
 #define CPU(he)   (he->cpu)
 #define PID(he)   (he->thread->tid)
diff --git a/tools/perf/tests/map_groups.c b/tools/perf/tests/map_groups.c
index 594fdaca4f71..dd75661993ad 100644
--- a/tools/perf/tests/map_groups.c
+++ b/tools/perf/tests/map_groups.c
@@ -20,9 +20,9 @@ static int check_maps(struct map_def *merged, unsigned int size, struct map_grou
 
 	map = map_groups__first(mg);
 	while (map) {
-		TEST_ASSERT_VAL("wrong map start",  map->start == merged[i].start);
-		TEST_ASSERT_VAL("wrong map end",    map->end == merged[i].end);
-		TEST_ASSERT_VAL("wrong map name",  !strcmp(map->dso->name, merged[i].name));
+		TEST_ASSERT_VAL("wrong map start",  map_sh(map)->start == merged[i].start);
+		TEST_ASSERT_VAL("wrong map end",    map_sh(map)->end == merged[i].end);
+		TEST_ASSERT_VAL("wrong map name",  !strcmp(map_sh(map)->dso->name, merged[i].name));
 		TEST_ASSERT_VAL("wrong map refcnt", refcount_read(&map->refcnt) == 2);
 
 		i++;
@@ -73,8 +73,8 @@ int test__map_groups__merge_in(struct test *t __maybe_unused, int subtest __mayb
 		map = dso__new_map(bpf_progs[i].name);
 		TEST_ASSERT_VAL("failed to create map", map);
 
-		map->start = bpf_progs[i].start;
-		map->end   = bpf_progs[i].end;
+		map_sh(map)->start = bpf_progs[i].start;
+		map_sh(map)->end   = bpf_progs[i].end;
 		map_groups__insert(&mg, map);
 		map__put(map);
 	}
@@ -89,16 +89,16 @@ int test__map_groups__merge_in(struct test *t __maybe_unused, int subtest __mayb
 	TEST_ASSERT_VAL("failed to create map", map_kcore3);
 
 	/* kcore1 map overlaps over all bpf maps */
-	map_kcore1->start = 100;
-	map_kcore1->end   = 1000;
+	map_sh(map_kcore1)->start = 100;
+	map_sh(map_kcore1)->end   = 1000;
 
 	/* kcore2 map hides behind bpf_prog_2 */
-	map_kcore2->start = 550;
-	map_kcore2->end   = 570;
+	map_sh(map_kcore2)->start = 550;
+	map_sh(map_kcore2)->end   = 570;
 
 	/* kcore3 map hides behind bpf_prog_3, kcore1 and adds new map */
-	map_kcore3->start = 880;
-	map_kcore3->end   = 1100;
+	map_sh(map_kcore3)->start = 880;
+	map_sh(map_kcore3)->end   = 1100;
 
 	ret = map_groups__merge_in(&mg, map_kcore1);
 	TEST_ASSERT_VAL("failed to merge map", !ret);
diff --git a/tools/perf/tests/mmap-thread-lookup.c b/tools/perf/tests/mmap-thread-lookup.c
index 8d9d4cbff76d..6fd81c545787 100644
--- a/tools/perf/tests/mmap-thread-lookup.c
+++ b/tools/perf/tests/mmap-thread-lookup.c
@@ -202,7 +202,7 @@ static int mmap_events(synth_cb synth)
 			break;
 		}
 
-		pr_debug("map %p, addr %" PRIx64 "\n", al.map, al.map->start);
+		pr_debug("map %p, addr %" PRIx64 "\n", al.map, map_sh(al.map)->start);
 	}
 
 	machine__delete_threads(machine);
diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index aa296ffea6d1..c68c234ee193 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -12,7 +12,7 @@
 #include "debug.h"
 #include "machine.h"
 
-#define UM(x) kallsyms_map->unmap_ip(kallsyms_map, (x))
+#define UM(x) map_sh(kallsyms_map)->unmap_ip(kallsyms_map, (x))
 
 int test__vmlinux_matches_kallsyms(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
@@ -117,8 +117,8 @@ int test__vmlinux_matches_kallsyms(struct test *test __maybe_unused, int subtest
 		if (sym->start == sym->end)
 			continue;
 
-		mem_start = vmlinux_map->unmap_ip(vmlinux_map, sym->start);
-		mem_end = vmlinux_map->unmap_ip(vmlinux_map, sym->end);
+		mem_start = map_sh(vmlinux_map)->unmap_ip(vmlinux_map, sym->start);
+		mem_end = map_sh(vmlinux_map)->unmap_ip(vmlinux_map, sym->end);
 
 		first_pair = machine__find_kernel_symbol(&kallsyms, mem_start, NULL);
 		pair = first_pair;
@@ -163,7 +163,7 @@ int test__vmlinux_matches_kallsyms(struct test *test __maybe_unused, int subtest
 
 				continue;
 			}
-		} else if (mem_start == kallsyms.vmlinux_map->end) {
+		} else if (mem_start == map_sh(kallsyms.vmlinux_map)->end) {
 			/*
 			 * Ignore aliases to _etext, i.e. to the end of the kernel text area,
 			 * such as __indirect_thunk_end.
@@ -191,11 +191,11 @@ int test__vmlinux_matches_kallsyms(struct test *test __maybe_unused, int subtest
 		 * both cases.
 		 */
 		pair = map_groups__find_by_name(&kallsyms.kmaps,
-						(map->dso->kernel ?
-							map->dso->short_name :
-							map->dso->name));
+						(map_sh(map)->dso->kernel ?
+							map_sh(map)->dso->short_name :
+							map_sh(map)->dso->name));
 		if (pair) {
-			pair->priv = 1;
+			map_sh(pair)->priv = 1;
 		} else {
 			if (!header_printed) {
 				pr_info("WARN: Maps only in vmlinux:\n");
@@ -210,26 +210,26 @@ int test__vmlinux_matches_kallsyms(struct test *test __maybe_unused, int subtest
 	for (map = maps__first(maps); map; map = map__next(map)) {
 		struct map *pair;
 
-		mem_start = vmlinux_map->unmap_ip(vmlinux_map, map->start);
-		mem_end = vmlinux_map->unmap_ip(vmlinux_map, map->end);
+		mem_start = map_sh(vmlinux_map)->unmap_ip(vmlinux_map, map_sh(map)->start);
+		mem_end = map_sh(vmlinux_map)->unmap_ip(vmlinux_map, map_sh(map)->end);
 
 		pair = map_groups__find(&kallsyms.kmaps, mem_start);
-		if (pair == NULL || pair->priv)
+		if (pair == NULL || map_sh(pair)->priv)
 			continue;
 
-		if (pair->start == mem_start) {
+		if (map_sh(pair)->start == mem_start) {
 			if (!header_printed) {
 				pr_info("WARN: Maps in vmlinux with a different name in kallsyms:\n");
 				header_printed = true;
 			}
 
 			pr_info("WARN: %" PRIx64 "-%" PRIx64 " %" PRIx64 " %s in kallsyms as",
-				map->start, map->end, map->pgoff, map->dso->name);
-			if (mem_end != pair->end)
+				map_sh(map)->start, map_sh(map)->end, map_sh(map)->pgoff, map_sh(map)->dso->name);
+			if (mem_end != map_sh(pair)->end)
 				pr_info(":\nWARN: *%" PRIx64 "-%" PRIx64 " %" PRIx64,
-					pair->start, pair->end, pair->pgoff);
-			pr_info(" %s\n", pair->dso->name);
-			pair->priv = 1;
+					map_sh(pair)->start, map_sh(pair)->end, map_sh(pair)->pgoff);
+			pr_info(" %s\n", map_sh(pair)->dso->name);
+			map_sh(pair)->priv = 1;
 		}
 	}
 
@@ -238,7 +238,7 @@ int test__vmlinux_matches_kallsyms(struct test *test __maybe_unused, int subtest
 	maps = machine__kernel_maps(&kallsyms);
 
 	for (map = maps__first(maps); map; map = map__next(map)) {
-		if (!map->priv) {
+		if (!map_sh(map)->priv) {
 			if (!header_printed) {
 				pr_info("WARN: Maps only in kallsyms:\n");
 				header_printed = true;
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 82207db8f97c..dc82996775b3 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -393,7 +393,7 @@ static void ui_browser__init_asm_mode(struct ui_browser *browser)
 static int sym_title(struct symbol *sym, struct map *map, char *title,
 		     size_t sz, int percent_type)
 {
-	return snprintf(title, sz, "%s  %s [Percent: %s]", sym->name, map->dso->long_name,
+	return snprintf(title, sz, "%s  %s [Percent: %s]", sym->name, map_sh(map)->dso->long_name,
 			percent_type_str(percent_type));
 }
 
@@ -915,7 +915,7 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 	if (sym == NULL)
 		return -1;
 
-	if (map->dso->annotate_warned)
+	if (map_sh(map)->dso->annotate_warned)
 		return -1;
 
 	err = symbol__annotate2(sym, map, evsel, opts, &browser.arch);
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 7a7187e069b4..47bca2dcf86a 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2402,7 +2402,7 @@ add_annotate_opt(struct hist_browser *browser __maybe_unused,
 		 struct popup_action *act, char **optstr,
 		 struct map *map, struct symbol *sym)
 {
-	if (sym == NULL || map->dso->annotate_warned)
+	if (sym == NULL || map_sh(map)->dso->annotate_warned)
 		return 0;
 
 	if (asprintf(optstr, "Annotate %s", sym->name) < 0)
@@ -2491,8 +2491,8 @@ do_zoom_dso(struct hist_browser *browser, struct popup_action *act)
 		ui_helpline__pop();
 	} else {
 		ui_helpline__fpush("To zoom out press ESC or ENTER + \"Zoom out of %s DSO\"",
-				   __map__is_kernel(map) ? "the Kernel" : map->dso->short_name);
-		browser->hists->dso_filter = map->dso;
+				   __map__is_kernel(map) ? "the Kernel" : map_sh(map)->dso->short_name);
+		browser->hists->dso_filter = map_sh(map)->dso;
 		perf_hpp__set_elide(HISTC_DSO, true);
 		pstack__push(browser->pstack, &browser->hists->dso_filter);
 	}
@@ -2511,7 +2511,7 @@ add_dso_opt(struct hist_browser *browser, struct popup_action *act,
 
 	if (asprintf(optstr, "Zoom %s %s DSO",
 		     browser->hists->dso_filter ? "out of" : "into",
-		     __map__is_kernel(map) ? "the Kernel" : map->dso->short_name) < 0)
+		     __map__is_kernel(map) ? "the Kernel" : map_sh(map)->dso->short_name) < 0)
 		return 0;
 
 	act->ms.map = map;
@@ -2939,7 +2939,7 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
 
 			if (browser->selection == NULL ||
 			    browser->selection->sym == NULL ||
-			    browser->selection->map->dso->annotate_warned)
+			    map_sh(browser->selection->map)->dso->annotate_warned)
 				continue;
 
 			actions->ms.map = browser->selection->map;
diff --git a/tools/perf/ui/browsers/map.c b/tools/perf/ui/browsers/map.c
index 3d49b916c9e4..640a5e3304ef 100644
--- a/tools/perf/ui/browsers/map.c
+++ b/tools/perf/ui/browsers/map.c
@@ -76,7 +76,7 @@ static int map_browser__run(struct map_browser *browser)
 {
 	int key;
 
-	if (ui_browser__show(&browser->b, browser->map->dso->long_name,
+	if (ui_browser__show(&browser->b, map_sh(browser->map)->dso->long_name,
 			     "Press ESC to exit, %s / to search",
 			     verbose > 0 ? "" : "restart with -v to use") < 0)
 		return -1;
@@ -106,7 +106,7 @@ int map__browse(struct map *map)
 {
 	struct map_browser mb = {
 		.b = {
-			.entries = &map->dso->symbols,
+			.entries = &map_sh(map)->dso->symbols,
 			.refresh = ui_browser__rb_tree_refresh,
 			.seek	 = ui_browser__rb_tree_seek,
 			.write	 = map_browser__write,
diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
index 8e744af24f7c..764c0c29e58d 100644
--- a/tools/perf/ui/gtk/annotate.c
+++ b/tools/perf/ui/gtk/annotate.c
@@ -170,7 +170,7 @@ static int symbol__gtk_annotate(struct symbol *sym, struct map *map,
 	GtkWidget *tab_label;
 	int err;
 
-	if (map->dso->annotate_warned)
+	if (map_sh(map)->dso->annotate_warned)
 		return -1;
 
 	err = symbol__annotate(sym, map, evsel, 0, &annotation__default_options, NULL);
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 2b856b6b46f6..add668e50078 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -271,7 +271,7 @@ static int call__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 	target.addr = map__objdump_2mem(map, ops->target.addr);
 
 	if (map_groups__find_ams(&target) == 0 &&
-	    map__rip_2objdump(target.map, map->map_ip(target.map, target.addr)) == ops->target.addr)
+	    map__rip_2objdump(target.map, map_sh(map)->map_ip(target.map, target.addr)) == ops->target.addr)
 		ops->target.sym = target.sym;
 
 	return 0;
@@ -367,8 +367,8 @@ static int jump__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 	}
 
 	target.addr = map__objdump_2mem(map, ops->target.addr);
-	start = map->unmap_ip(map, sym->start),
-	end = map->unmap_ip(map, sym->end);
+	start = map_sh(map)->unmap_ip(map, sym->start),
+	end = map_sh(map)->unmap_ip(map, sym->end);
 
 	ops->target.outside = target.addr < start || target.addr > end;
 
@@ -391,7 +391,7 @@ static int jump__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 	 * the symbol searching and disassembly should be done.
 	 */
 	if (map_groups__find_ams(&target) == 0 &&
-	    map__rip_2objdump(target.map, map->map_ip(target.map, target.addr)) == ops->target.addr)
+	    map__rip_2objdump(target.map, map_sh(map)->map_ip(target.map, target.addr)) == ops->target.addr)
 		ops->target.sym = target.sym;
 
 	if (!ops->target.outside) {
@@ -871,7 +871,7 @@ static int __symbol__inc_addr_samples(struct symbol *sym, struct map *map,
 	unsigned offset;
 	struct sym_hist *h;
 
-	pr_debug3("%s: addr=%#" PRIx64 "\n", __func__, map->unmap_ip(map, addr));
+	pr_debug3("%s: addr=%#" PRIx64 "\n", __func__, map_sh(map)->unmap_ip(map, addr));
 
 	if ((addr < sym->start || addr >= sym->end) &&
 	    (addr != sym->end || sym->start != sym->end)) {
@@ -998,13 +998,13 @@ int addr_map_symbol__account_cycles(struct addr_map_symbol *ams,
 	if (start &&
 		(start->sym == ams->sym ||
 		 (ams->sym &&
-		   start->addr == ams->sym->start + ams->map->start)))
+		   start->addr == ams->sym->start + map_sh(ams->map)->start)))
 		saddr = start->al_addr;
 	if (saddr == 0)
 		pr_debug2("BB with bad start: addr %"PRIx64" start %"PRIx64" sym %"PRIx64" saddr %"PRIx64"\n",
 			ams->addr,
 			start ? start->addr : 0,
-			ams->sym ? ams->sym->start + ams->map->start : 0,
+			ams->sym ? ams->sym->start + map_sh(ams->map)->start : 0,
 			saddr);
 	err = symbol__account_cycles(ams->al_addr, saddr, ams->sym, cycles);
 	if (err)
@@ -1604,7 +1604,7 @@ static void delete_last_nop(struct symbol *sym)
 int symbol__strerror_disassemble(struct symbol *sym __maybe_unused, struct map *map,
 			      int errnum, char *buf, size_t buflen)
 {
-	struct dso *dso = map->dso;
+	struct dso *dso = map_sh(map)->dso;
 
 	BUG_ON(buflen == 0);
 
@@ -1724,7 +1724,7 @@ static int symbol__disassemble_bpf(struct symbol *sym,
 	disassembler_ftype disassemble;
 	struct map *map = args->ms.map;
 	struct disassemble_info info;
-	struct dso *dso = map->dso;
+	struct dso *dso = map_sh(map)->dso;
 	int pc = 0, count, sub_id;
 	struct btf *btf = NULL;
 	char tpath[PATH_MAX];
@@ -1865,7 +1865,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 {
 	struct annotation_options *opts = args->options;
 	struct map *map = args->ms.map;
-	struct dso *dso = map->dso;
+	struct dso *dso = map_sh(map)->dso;
 	char *command;
 	FILE *file;
 	char symfs_filename[PATH_MAX];
@@ -1882,8 +1882,8 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 		return err;
 
 	pr_debug("%s: filename=%s, sym=%s, start=%#" PRIx64 ", end=%#" PRIx64 "\n", __func__,
-		 symfs_filename, sym->name, map->unmap_ip(map, sym->start),
-		 map->unmap_ip(map, sym->end));
+		 symfs_filename, sym->name, map_sh(map)->unmap_ip(map, sym->start),
+		 map_sh(map)->unmap_ip(map, sym->end));
 
 	pr_debug("annotating [%p] %30s : [%p] %30s\n",
 		 dso, dso->long_name, sym, sym->name);
@@ -2271,7 +2271,7 @@ int symbol__annotate_printf(struct symbol *sym, struct map *map,
 			    struct evsel *evsel,
 			    struct annotation_options *opts)
 {
-	struct dso *dso = map->dso;
+	struct dso *dso = map_sh(map)->dso;
 	char *filename;
 	const char *d_filename;
 	const char *evsel_name = perf_evsel__name(evsel);
@@ -2454,7 +2454,7 @@ int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evsel,
 	}
 
 	fprintf(fp, "%s() %s\nEvent: %s\n\n",
-		ms->sym->name, ms->map->dso->long_name, ev_name);
+		ms->sym->name, map_sh(ms->map)->dso->long_name, ev_name);
 	symbol__annotate_fprintf2(ms->sym, fp, opts);
 
 	fclose(fp);
@@ -2666,7 +2666,7 @@ static void annotation__calc_lines(struct annotation *notes, struct map *map,
 		if (percent_max <= 0.5)
 			continue;
 
-		al->path = get_srcline(map->dso, notes->start + al->offset, NULL,
+		al->path = get_srcline(map_sh(map)->dso, notes->start + al->offset, NULL,
 				       false, true, notes->start + al->offset);
 		insert_source_line(&tmp_root, al, opts);
 	}
@@ -2687,7 +2687,7 @@ int symbol__tty_annotate2(struct symbol *sym, struct map *map,
 			  struct evsel *evsel,
 			  struct annotation_options *opts)
 {
-	struct dso *dso = map->dso;
+	struct dso *dso = map_sh(map)->dso;
 	struct rb_root source_line = RB_ROOT;
 	struct hists *hists = evsel__hists(evsel);
 	char buf[1024];
@@ -2715,7 +2715,7 @@ int symbol__tty_annotate(struct symbol *sym, struct map *map,
 			 struct evsel *evsel,
 			 struct annotation_options *opts)
 {
-	struct dso *dso = map->dso;
+	struct dso *dso = map_sh(map)->dso;
 	struct rb_root source_line = RB_ROOT;
 
 	if (symbol__annotate(sym, map, evsel, 0, opts, NULL) < 0)
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 8470dfe9fe97..6de6fbfc3bf6 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1929,7 +1929,7 @@ static struct dso *load_dso(const char *name)
 	if (map__load(map) < 0)
 		pr_err("File '%s' not found or has no symbols.\n", name);
 
-	dso = dso__get(map->dso);
+	dso = dso__get(map_sh(map)->dso);
 
 	map__put(map);
 
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index f7ed5d122e22..cd80876f9b3d 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -57,10 +57,10 @@ static int machine__process_bpf_event_load(struct machine *machine,
 		map = map_groups__find(&machine->kmaps, addr);
 
 		if (map) {
-			map->dso->binary_type = DSO_BINARY_TYPE__BPF_PROG_INFO;
-			map->dso->bpf_prog.id = id;
-			map->dso->bpf_prog.sub_id = i;
-			map->dso->bpf_prog.env = env;
+			map_sh(map)->dso->binary_type = DSO_BINARY_TYPE__BPF_PROG_INFO;
+			map_sh(map)->dso->bpf_prog.id = id;
+			map_sh(map)->dso->bpf_prog.sub_id = i;
+			map_sh(map)->dso->bpf_prog.env = env;
 		}
 	}
 	return 0;
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index c076fc7fe025..65d9215750be 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -53,7 +53,7 @@ int build_id__mark_dso_hit(struct perf_tool *tool __maybe_unused,
 	}
 
 	if (thread__find_map(thread, sample->cpumode, sample->ip, &al))
-		al.map->dso->hit = 1;
+		map_sh(al.map)->dso->hit = 1;
 
 	thread__put(thread);
 	return 0;
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 9a9b56ed3f0a..1b2cd3382e66 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -695,8 +695,8 @@ static enum match_result match_chain_strings(const char *left,
 static enum match_result match_chain_dso_addresses(struct map *left_map, u64 left_ip,
 						   struct map *right_map, u64 right_ip)
 {
-	struct dso *left_dso = left_map ? left_map->dso : NULL;
-	struct dso *right_dso = right_map ? right_map->dso : NULL;
+	struct dso *left_dso = left_map ? map_sh(left_map)->dso : NULL;
+	struct dso *right_dso = right_map ? map_sh(right_map)->dso : NULL;
 
 	if (left_dso != right_dso)
 		return left_dso < right_dso ? MATCH_LT : MATCH_GT;
@@ -1167,7 +1167,7 @@ char *callchain_list__sym_name(struct callchain_list *cl,
 	if (show_dso)
 		scnprintf(bf + printed, bfsize - printed, " %s",
 			  cl->ms.map ?
-			  cl->ms.map->dso->short_name :
+			  map_sh(cl->ms.map)->dso->short_name :
 			  "unknown");
 
 	return bf;
diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 752227b265e7..917b388ce609 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -179,7 +179,7 @@ static int db_ids_from_al(struct db_export *dbe, struct addr_location *al,
 	int err;
 
 	if (al->map) {
-		struct dso *dso = al->map->dso;
+		struct dso *dso = map_sh(al->map)->dso;
 
 		err = db_export__dso(dbe, dso, al->machine);
 		if (err)
@@ -255,7 +255,7 @@ static struct call_path *call_path_from_sample(struct db_export *dbe,
 		al.addr = node->ip;
 
 		if (al.map && !al.sym)
-			al.sym = dso__find_symbol(al.map->dso, al.addr);
+			al.sym = dso__find_symbol(map_sh(al.map)->dso, al.addr);
 
 		db_ids_from_al(dbe, &al, &dso_db_id, &sym_db_id, &offset);
 
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index e11ddf86f2b3..d6e671bdd947 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1061,7 +1061,7 @@ ssize_t dso__data_read_addr(struct dso *dso, struct map *map,
 			    struct machine *machine, u64 addr,
 			    u8 *data, ssize_t size)
 {
-	u64 offset = map->map_ip(map, addr);
+	u64 offset = map_sh(map)->map_ip(map, addr);
 	return dso__data_read_offset(dso, machine, offset, data, size);
 }
 
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index fc1e5a991008..80b9e6fb2a10 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -508,7 +508,7 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 		 */
 		if (load_map)
 			map__load(al->map);
-		al->addr = al->map->map_ip(al->map, al->addr);
+		al->addr = map_sh(al->map)->map_ip(al->map, al->addr);
 	}
 
 	return al->map;
@@ -566,7 +566,7 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
 	dump_printf(" ... thread: %s:%d\n", thread__comm_str(thread), thread->tid);
 	thread__find_map(thread, sample->cpumode, sample->ip, al);
 	dump_printf(" ...... dso: %s\n",
-		    al->map ? al->map->dso->long_name :
+		    al->map ? map_sh(al->map)->dso->long_name :
 			al->level == 'H' ? "[hypervisor]" : "<not found>");
 
 	if (thread__is_filtered(thread))
@@ -585,7 +585,7 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
 	}
 
 	if (al->map) {
-		struct dso *dso = al->map->dso;
+		struct dso *dso = map_sh(al->map)->dso;
 
 		if (symbol_conf.dso_list &&
 		    (!dso || !(strlist__has_entry(symbol_conf.dso_list,
diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index 028df7afb0dc..13912f8f173a 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -143,7 +143,7 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 				printed += fprintf(fp, "%c%16" PRIx64, s, node->ip);
 
 			if (node->map)
-				addr = node->map->map_ip(node->map, node->ip);
+				addr = map_sh(node->map)->map_ip(node->map, node->ip);
 
 			if (print_sym) {
 				printed += fprintf(fp, " ");
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 679a1d75090c..ad1b02ea8d59 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -101,7 +101,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 		hists__set_col_len(hists, HISTC_THREAD, len + 8);
 
 	if (h->ms.map) {
-		len = dso__name_len(h->ms.map->dso);
+		len = dso__name_len(map_sh(h->ms.map)->dso);
 		hists__new_col_len(hists, HISTC_DSO, len);
 	}
 
@@ -115,7 +115,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 				symlen += BITS_PER_LONG / 4 + 2 + 3;
 			hists__new_col_len(hists, HISTC_SYMBOL_FROM, symlen);
 
-			symlen = dso__name_len(h->branch_info->from.map->dso);
+			symlen = dso__name_len(map_sh(h->branch_info->from.map)->dso);
 			hists__new_col_len(hists, HISTC_DSO_FROM, symlen);
 		} else {
 			symlen = unresolved_col_width + 4 + 2;
@@ -129,7 +129,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 				symlen += BITS_PER_LONG / 4 + 2 + 3;
 			hists__new_col_len(hists, HISTC_SYMBOL_TO, symlen);
 
-			symlen = dso__name_len(h->branch_info->to.map->dso);
+			symlen = dso__name_len(map_sh(h->branch_info->to.map)->dso);
 			hists__new_col_len(hists, HISTC_DSO_TO, symlen);
 		} else {
 			symlen = unresolved_col_width + 4 + 2;
@@ -173,7 +173,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 		}
 
 		if (h->mem_info->daddr.map) {
-			symlen = dso__name_len(h->mem_info->daddr.map->dso);
+			symlen = dso__name_len(map_sh(h->mem_info->daddr.map)->dso);
 			hists__new_col_len(hists, HISTC_MEM_DADDR_DSO,
 					   symlen);
 		} else {
@@ -2041,7 +2041,7 @@ static bool hists__filter_entry_by_dso(struct hists *hists,
 				       struct hist_entry *he)
 {
 	if (hists->dso_filter != NULL &&
-	    (he->ms.map == NULL || he->ms.map->dso != hists->dso_filter)) {
+	    (he->ms.map == NULL || map_sh(he->ms.map)->dso != hists->dso_filter)) {
 		he->filtered |= (1 << HIST_FILTER__DSO);
 		return true;
 	}
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index a1c9eb6d4f40..7eb59dc545a4 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -520,6 +520,7 @@ static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
 	struct machine *machine = ptq->pt->machine;
 	struct thread *thread;
 	struct addr_location al;
+	struct map_shared *sh;
 	unsigned char buf[INTEL_PT_INSN_BUF_SZ];
 	ssize_t len;
 	int x86_64;
@@ -543,20 +544,22 @@ static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
 	}
 
 	while (1) {
-		if (!thread__find_map(thread, cpumode, *ip, &al) || !al.map->dso)
+		if (!thread__find_map(thread, cpumode, *ip, &al) || !map_sh(al.map)->dso)
 			return -EINVAL;
 
-		if (al.map->dso->data.status == DSO_DATA_STATUS_ERROR &&
-		    dso__data_status_seen(al.map->dso,
+		sh = map_sh(al.map);
+
+		if (sh->dso->data.status == DSO_DATA_STATUS_ERROR &&
+		    dso__data_status_seen(sh->dso,
 					  DSO_DATA_STATUS_SEEN_ITRACE))
 			return -ENOENT;
 
-		offset = al.map->map_ip(al.map, *ip);
+		offset = sh->map_ip(al.map, *ip);
 
 		if (!to_ip && one_map) {
 			struct intel_pt_cache_entry *e;
 
-			e = intel_pt_cache_lookup(al.map->dso, machine, offset);
+			e = intel_pt_cache_lookup(sh->dso, machine, offset);
 			if (e &&
 			    (!max_insn_cnt || e->insn_cnt <= max_insn_cnt)) {
 				*insn_cnt_ptr = e->insn_cnt;
@@ -578,10 +581,10 @@ static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
 		/* Load maps to ensure dso->is_64_bit has been updated */
 		map__load(al.map);
 
-		x86_64 = al.map->dso->is_64_bit;
+		x86_64 = sh->dso->is_64_bit;
 
 		while (1) {
-			len = dso__data_read_offset(al.map->dso, machine,
+			len = dso__data_read_offset(sh->dso, machine,
 						    offset, buf,
 						    INTEL_PT_INSN_BUF_SZ);
 			if (len <= 0)
@@ -605,7 +608,7 @@ static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
 			if (to_ip && *ip == to_ip)
 				goto out_no_cache;
 
-			if (*ip >= al.map->end)
+			if (*ip >= sh->end)
 				break;
 
 			offset += intel_pt_insn->length;
@@ -625,13 +628,13 @@ static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
 	if (to_ip) {
 		struct intel_pt_cache_entry *e;
 
-		e = intel_pt_cache_lookup(al.map->dso, machine, start_offset);
+		e = intel_pt_cache_lookup(sh->dso, machine, start_offset);
 		if (e)
 			return 0;
 	}
 
 	/* Ignore cache errors */
-	intel_pt_cache_add(al.map->dso, machine, start_offset, insn_cnt,
+	intel_pt_cache_add(sh->dso, machine, start_offset, insn_cnt,
 			   *ip - start_ip, intel_pt_insn);
 
 	return 0;
@@ -696,13 +699,13 @@ static int __intel_pt_pgd_ip(uint64_t ip, void *data)
 	if (!thread)
 		return -EINVAL;
 
-	if (!thread__find_map(thread, cpumode, ip, &al) || !al.map->dso)
+	if (!thread__find_map(thread, cpumode, ip, &al) || !map_sh(al.map)->dso)
 		return -EINVAL;
 
-	offset = al.map->map_ip(al.map, ip);
+	offset = map_sh(al.map)->map_ip(al.map, ip);
 
 	return intel_pt_match_pgd_ip(ptq->pt, ip, offset,
-				     al.map->dso->long_name);
+				     map_sh(al.map)->dso->long_name);
 }
 
 static bool intel_pt_pgd_ip(uint64_t ip, void *data)
@@ -2018,6 +2021,7 @@ static u64 intel_pt_switch_ip(struct intel_pt *pt, u64 *ptss_ip)
 {
 	struct machine *machine = pt->machine;
 	struct map *map;
+	struct map_shared *sh;
 	struct symbol *sym, *start;
 	u64 ip, switch_ip = 0;
 	const char *ptss;
@@ -2032,13 +2036,15 @@ static u64 intel_pt_switch_ip(struct intel_pt *pt, u64 *ptss_ip)
 	if (map__load(map))
 		return 0;
 
-	start = dso__first_symbol(map->dso);
+	sh = map_sh(map);
+
+	start = dso__first_symbol(sh->dso);
 
 	for (sym = start; sym; sym = dso__next_symbol(sym)) {
 		if (sym->binding == STB_GLOBAL &&
 		    !strcmp(sym->name, "__switch_to")) {
-			ip = map->unmap_ip(map, sym->start);
-			if (ip >= map->start && ip < map->end) {
+			ip = sh->unmap_ip(map, sym->start);
+			if (ip >= sh->start && ip < sh->end) {
 				switch_ip = ip;
 				break;
 			}
@@ -2055,8 +2061,8 @@ static u64 intel_pt_switch_ip(struct intel_pt *pt, u64 *ptss_ip)
 
 	for (sym = start; sym; sym = dso__next_symbol(sym)) {
 		if (!strcmp(sym->name, ptss)) {
-			ip = map->unmap_ip(map, sym->start);
-			if (ip >= map->start && ip < map->end) {
+			ip = sh->unmap_ip(map, sym->start);
+			if (ip >= sh->start && ip < sh->end) {
 				*ptss_ip = ip;
 				break;
 			}
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 70a9f8716a4b..14b63ac4fe7b 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -727,17 +727,17 @@ static int machine__process_ksymbol_register(struct machine *machine,
 		if (!map)
 			return -ENOMEM;
 
-		map->start = event->ksymbol.addr;
-		map->end = map->start + event->ksymbol.len;
+		map_sh(map)->start = event->ksymbol.addr;
+		map_sh(map)->end = map_sh(map)->start + event->ksymbol.len;
 		map_groups__insert(&machine->kmaps, map);
 	}
 
-	sym = symbol__new(map->map_ip(map, map->start),
+	sym = symbol__new(map_sh(map)->map_ip(map, map_sh(map)->start),
 			  event->ksymbol.len,
 			  0, 0, event->ksymbol.name);
 	if (!sym)
 		return -ENOMEM;
-	dso__insert_symbol(map->dso, sym);
+	dso__insert_symbol(map_sh(map)->dso, sym);
 	return 0;
 }
 
@@ -802,7 +802,7 @@ struct map *machine__findnew_module_map(struct machine *machine, u64 start,
 		 * a chance to find the file path of that module by fixing
 		 * long_name.
 		 */
-		dso__adjust_kmod_long_name(map->dso, filename);
+		dso__adjust_kmod_long_name(map_sh(map)->dso, filename);
 		goto out;
 	}
 
@@ -861,7 +861,7 @@ size_t machine__fprintf_vmlinux_path(struct machine *machine, FILE *fp)
 {
 	int i;
 	size_t printed = 0;
-	struct dso *kdso = machine__kernel_map(machine)->dso;
+	struct dso *kdso = map_sh(machine__kernel_map(machine))->dso;
 
 	if (kdso->has_build_id) {
 		char filename[PATH_MAX];
@@ -993,8 +993,8 @@ int machine__create_extra_kernel_map(struct machine *machine,
 	if (!map)
 		return -1;
 
-	map->end   = xm->end;
-	map->pgoff = xm->pgoff;
+	map_sh(map)->end   = xm->end;
+	map_sh(map)->pgoff = xm->pgoff;
 
 	kmap = map__kmap(map);
 
@@ -1004,7 +1004,7 @@ int machine__create_extra_kernel_map(struct machine *machine,
 	map_groups__insert(&machine->kmaps, map);
 
 	pr_debug2("Added extra kernel map %s %" PRIx64 "-%" PRIx64 "\n",
-		  kmap->name, map->start, map->end);
+		  kmap->name, map_sh(map)->start, map_sh(map)->end);
 
 	map__put(map);
 
@@ -1064,9 +1064,9 @@ int machine__map_x86_64_entry_trampolines(struct machine *machine,
 		if (!kmap || !is_entry_trampoline(kmap->name))
 			continue;
 
-		dest_map = map_groups__find(kmaps, map->pgoff);
+		dest_map = map_groups__find(kmaps, map_sh(map)->pgoff);
 		if (dest_map != map)
-			map->pgoff = dest_map->map_ip(dest_map, map->pgoff);
+			map_sh(map)->pgoff = map_sh(dest_map)->map_ip(dest_map, map_sh(map)->pgoff);
 		found = true;
 	}
 	if (found || machine->trampolines_mapped)
@@ -1119,7 +1119,7 @@ __machine__create_kernel_maps(struct machine *machine, struct dso *kernel)
 	if (machine->vmlinux_map == NULL)
 		return -1;
 
-	machine->vmlinux_map->map_ip = machine->vmlinux_map->unmap_ip = identity__map_ip;
+	map_sh(machine->vmlinux_map)->map_ip = map_sh(machine->vmlinux_map)->unmap_ip = identity__map_ip;
 	map = machine__kernel_map(machine);
 	kmap = map__kmap(map);
 	if (!kmap)
@@ -1226,10 +1226,10 @@ int machines__create_kernel_maps(struct machines *machines, pid_t pid)
 int machine__load_kallsyms(struct machine *machine, const char *filename)
 {
 	struct map *map = machine__kernel_map(machine);
-	int ret = __dso__load_kallsyms(map->dso, filename, map, true);
+	int ret = __dso__load_kallsyms(map_sh(map)->dso, filename, map, true);
 
 	if (ret > 0) {
-		dso__set_loaded(map->dso);
+		dso__set_loaded(map_sh(map)->dso);
 		/*
 		 * Since /proc/kallsyms will have multiple sessions for the
 		 * kernel, with modules between them, fixup the end of all
@@ -1244,10 +1244,10 @@ int machine__load_kallsyms(struct machine *machine, const char *filename)
 int machine__load_vmlinux_path(struct machine *machine)
 {
 	struct map *map = machine__kernel_map(machine);
-	int ret = dso__load_vmlinux_path(map->dso, map);
+	int ret = dso__load_vmlinux_path(map_sh(map)->dso, map);
 
 	if (ret > 0)
-		dso__set_loaded(map->dso);
+		dso__set_loaded(map_sh(map)->dso);
 
 	return ret;
 }
@@ -1299,16 +1299,16 @@ static int map_groups__set_module_path(struct map_groups *mg, const char *path,
 	if (long_name == NULL)
 		return -ENOMEM;
 
-	dso__set_long_name(map->dso, long_name, true);
-	dso__kernel_module_get_build_id(map->dso, "");
+	dso__set_long_name(map_sh(map)->dso, long_name, true);
+	dso__kernel_module_get_build_id(map_sh(map)->dso, "");
 
 	/*
 	 * Full name could reveal us kmod compression, so
 	 * we need to update the symtab_type if needed.
 	 */
-	if (m->comp && is_kmod_dso(map->dso)) {
-		map->dso->symtab_type++;
-		map->dso->comp = m->comp;
+	if (m->comp && is_kmod_dso(map_sh(map)->dso)) {
+		map_sh(map)->dso->symtab_type++;
+		map_sh(map)->dso->comp = m->comp;
 	}
 
 	return 0;
@@ -1407,9 +1407,9 @@ static int machine__create_module(void *arg, const char *name, u64 start,
 	map = machine__findnew_module_map(machine, start, name);
 	if (map == NULL)
 		return -1;
-	map->end = start + size;
+	map_sh(map)->end = start + size;
 
-	dso__kernel_module_get_build_id(map->dso, machine->root_dir);
+	dso__kernel_module_get_build_id(map_sh(map)->dso, machine->root_dir);
 
 	return 0;
 }
@@ -1443,14 +1443,14 @@ static int machine__create_modules(struct machine *machine)
 static void machine__set_kernel_mmap(struct machine *machine,
 				     u64 start, u64 end)
 {
-	machine->vmlinux_map->start = start;
-	machine->vmlinux_map->end   = end;
+	map_sh(machine->vmlinux_map)->start = start;
+	map_sh(machine->vmlinux_map)->end   = end;
 	/*
 	 * Be a bit paranoid here, some perf.data file came with
 	 * a zero sized synthesized MMAP event for the kernel.
 	 */
 	if (start == 0 && end == 0)
-		machine->vmlinux_map->end = ~0ULL;
+		map_sh(machine->vmlinux_map)->end = ~0ULL;
 }
 
 static void machine__update_kernel_mmap(struct machine *machine,
@@ -1513,7 +1513,7 @@ int machine__create_kernel_maps(struct machine *machine)
 		/* update end address of the kernel map using adjacent module address */
 		map = map__next(machine__kernel_map(machine));
 		if (map)
-			machine__set_kernel_mmap(machine, start, map->start);
+			machine__set_kernel_mmap(machine, start, map_sh(map)->start);
 	}
 
 out_put:
@@ -1544,7 +1544,7 @@ static int machine__process_extra_kernel_map(struct machine *machine,
 					     union perf_event *event)
 {
 	struct map *kernel_map = machine__kernel_map(machine);
-	struct dso *kernel = kernel_map ? kernel_map->dso : NULL;
+	struct dso *kernel = kernel_map ? map_sh(kernel_map)->dso : NULL;
 	struct extra_kernel_map xm = {
 		.start = event->mmap.start,
 		.end   = event->mmap.start + event->mmap.len,
@@ -1585,7 +1585,7 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
 		if (map == NULL)
 			goto out_problem;
 
-		map->end = map->start + event->mmap.len;
+		map_sh(map)->end = map_sh(map)->start + event->mmap.len;
 	} else if (is_kernel_mmap) {
 		const char *symbol_name = (event->mmap.filename +
 				strlen(machine->mmap_name));
@@ -2009,14 +2009,14 @@ static char *callchain_srcline(struct map *map, struct symbol *sym, u64 ip)
 	if (!map || callchain_param.key == CCKEY_FUNCTION)
 		return srcline;
 
-	srcline = srcline__tree_find(&map->dso->srclines, ip);
+	srcline = srcline__tree_find(&map_sh(map)->dso->srclines, ip);
 	if (!srcline) {
 		bool show_sym = false;
 		bool show_addr = callchain_param.key == CCKEY_ADDRESS;
 
-		srcline = get_srcline(map->dso, map__rip_2objdump(map, ip),
+		srcline = get_srcline(map_sh(map)->dso, map__rip_2objdump(map, ip),
 				      sym, show_sym, show_addr, ip);
-		srcline__tree_insert(&map->dso->srclines, ip, srcline);
+		srcline__tree_insert(&map_sh(map)->dso->srclines, ip, srcline);
 	}
 
 	return srcline;
@@ -2458,12 +2458,12 @@ static int append_inlines(struct callchain_cursor *cursor,
 	addr = map__map_ip(map, ip);
 	addr = map__rip_2objdump(map, addr);
 
-	inline_node = inlines__tree_find(&map->dso->inlined_nodes, addr);
+	inline_node = inlines__tree_find(&map_sh(map)->dso->inlined_nodes, addr);
 	if (!inline_node) {
-		inline_node = dso__parse_addr_inlines(map->dso, addr, sym);
+		inline_node = dso__parse_addr_inlines(map_sh(map)->dso, addr, sym);
 		if (!inline_node)
 			return ret;
-		inlines__tree_insert(&map->dso->inlined_nodes, inline_node);
+		inlines__tree_insert(&map_sh(map)->dso->inlined_nodes, inline_node);
 	}
 
 	list_for_each_entry(ilist, &inline_node->val, list) {
@@ -2693,7 +2693,7 @@ int machine__get_kernel_start(struct machine *machine)
 		 * kernel_start = 1ULL << 63 for x86_64.
 		 */
 		if (!err && !machine__is(machine, "x86_64"))
-			machine->kernel_start = map->start;
+			machine->kernel_start = map_sh(map)->start;
 	}
 	return err;
 }
@@ -2739,7 +2739,7 @@ char *machine__resolve_kernel_addr(void *vmachine, unsigned long long *addrp, ch
 	if (sym == NULL)
 		return NULL;
 
-	*modp = __map__is_kmodule(map) ? (char *)map->dso->short_name : NULL;
-	*addrp = map->unmap_ip(map, sym->start);
+	*modp = __map__is_kmodule(map) ? (char *)map_sh(map)->dso->short_name : NULL;
+	*addrp = map_sh(map)->unmap_ip(map, sym->start);
 	return sym->name;
 }
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index eec9b282c047..98c56714f1ae 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -132,16 +132,18 @@ static inline bool replace_android_lib(const char *filename, char *newfilename)
 
 void map__init(struct map *map, u64 start, u64 end, u64 pgoff, struct dso *dso)
 {
-	map->start    = start;
-	map->end      = end;
-	map->pgoff    = pgoff;
-	map->reloc    = 0;
-	map->dso      = dso__get(dso);
-	map->map_ip   = map__map_ip;
-	map->unmap_ip = map__unmap_ip;
+	struct map_shared *sh = map_sh(map);
+
+	sh->start    = start;
+	sh->end      = end;
+	sh->pgoff    = pgoff;
+	sh->reloc    = 0;
+	sh->dso      = dso__get(dso);
+	sh->map_ip   = map__map_ip;
+	sh->unmap_ip = map__unmap_ip;
 	RB_CLEAR_NODE(&map->rb_node);
 	map->groups   = NULL;
-	map->erange_warned = false;
+	sh->erange_warned = false;
 	refcount_set(&map->refcnt, 1);
 }
 
@@ -158,18 +160,19 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 		char newfilename[PATH_MAX];
 		struct dso *dso;
 		int anon, no_dso, vdso, android;
+		struct map_shared *sh = map_sh(map);
 
 		android = is_android_lib(filename);
 		anon = is_anon_memory(filename, flags);
 		vdso = is_vdso_map(filename);
 		no_dso = is_no_dso_memory(filename);
 
-		map->maj = d_maj;
-		map->min = d_min;
-		map->ino = ino;
-		map->ino_generation = ino_gen;
-		map->prot = prot;
-		map->flags = flags;
+		sh->maj = d_maj;
+		sh->min = d_min;
+		sh->ino = ino;
+		sh->ino_generation = ino_gen;
+		sh->prot = prot;
+		sh->flags = flags;
 		nsi = nsinfo__get(thread->nsinfo);
 
 		if ((anon || no_dso) && nsi && (prot & PROT_EXEC)) {
@@ -205,7 +208,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 		map__init(map, start, start + len, pgoff, dso);
 
 		if (anon || no_dso) {
-			map->map_ip = map->unmap_ip = identity__map_ip;
+			sh->map_ip = sh->unmap_ip = identity__map_ip;
 
 			/*
 			 * Set memory without DSO as loaded. All map__find_*
@@ -269,7 +272,7 @@ bool __map__is_bpf_prog(const struct map *map)
 {
 	const char *name;
 
-	if (map->dso->binary_type == DSO_BINARY_TYPE__BPF_PROG_INFO)
+	if (map_sh(map)->dso->binary_type == DSO_BINARY_TYPE__BPF_PROG_INFO)
 		return true;
 
 	/*
@@ -277,19 +280,19 @@ bool __map__is_bpf_prog(const struct map *map)
 	 * type of DSO_BINARY_TYPE__BPF_PROG_INFO. In such cases, we can
 	 * guess the type based on name.
 	 */
-	name = map->dso->short_name;
+	name = map_sh(map)->dso->short_name;
 	return name && (strstr(name, "bpf_prog_") == name);
 }
 
 bool map__has_symbols(const struct map *map)
 {
-	return dso__has_symbols(map->dso);
+	return dso__has_symbols(map_sh(map)->dso);
 }
 
 static void map__exit(struct map *map)
 {
 	BUG_ON(!RB_EMPTY_NODE(&map->rb_node));
-	dso__zput(map->dso);
+	dso__zput(map_sh(map)->dso);
 }
 
 void map__delete(struct map *map)
@@ -306,21 +309,21 @@ void map__put(struct map *map)
 
 void map__fixup_start(struct map *map)
 {
-	struct rb_root_cached *symbols = &map->dso->symbols;
+	struct rb_root_cached *symbols = &map_sh(map)->dso->symbols;
 	struct rb_node *nd = rb_first_cached(symbols);
 	if (nd != NULL) {
 		struct symbol *sym = rb_entry(nd, struct symbol, rb_node);
-		map->start = sym->start;
+		map_sh(map)->start = sym->start;
 	}
 }
 
 void map__fixup_end(struct map *map)
 {
-	struct rb_root_cached *symbols = &map->dso->symbols;
+	struct rb_root_cached *symbols = &map_sh(map)->dso->symbols;
 	struct rb_node *nd = rb_last(&symbols->rb_root);
 	if (nd != NULL) {
 		struct symbol *sym = rb_entry(nd, struct symbol, rb_node);
-		map->end = sym->end;
+		map_sh(map)->end = sym->end;
 	}
 }
 
@@ -328,19 +331,19 @@ void map__fixup_end(struct map *map)
 
 int map__load(struct map *map)
 {
-	const char *name = map->dso->long_name;
+	const char *name = map_sh(map)->dso->long_name;
 	int nr;
 
-	if (dso__loaded(map->dso))
+	if (dso__loaded(map_sh(map)->dso))
 		return 0;
 
-	nr = dso__load(map->dso, map);
+	nr = dso__load(map_sh(map)->dso, map);
 	if (nr < 0) {
-		if (map->dso->has_build_id) {
+		if (map_sh(map)->dso->has_build_id) {
 			char sbuild_id[SBUILD_ID_SIZE];
 
-			build_id__sprintf(map->dso->build_id,
-					  sizeof(map->dso->build_id),
+			build_id__sprintf(map_sh(map)->dso->build_id,
+					  sizeof(map_sh(map)->dso->build_id),
 					  sbuild_id);
 			pr_debug("%s with build id %s not found", name, sbuild_id);
 		} else
@@ -373,7 +376,7 @@ struct symbol *map__find_symbol(struct map *map, u64 addr)
 	if (map__load(map) < 0)
 		return NULL;
 
-	return dso__find_symbol(map->dso, addr);
+	return dso__find_symbol(map_sh(map)->dso, addr);
 }
 
 struct symbol *map__find_symbol_by_name(struct map *map, const char *name)
@@ -381,10 +384,10 @@ struct symbol *map__find_symbol_by_name(struct map *map, const char *name)
 	if (map__load(map) < 0)
 		return NULL;
 
-	if (!dso__sorted_by_name(map->dso))
-		dso__sort_by_name(map->dso);
+	if (!dso__sorted_by_name(map_sh(map)->dso))
+		dso__sort_by_name(map_sh(map)->dso);
 
-	return dso__find_symbol_by_name(map->dso, name);
+	return dso__find_symbol_by_name(map_sh(map)->dso, name);
 }
 
 struct map *map__clone(struct map *from)
@@ -394,7 +397,7 @@ struct map *map__clone(struct map *from)
 	if (map != NULL) {
 		refcount_set(&map->refcnt, 1);
 		RB_CLEAR_NODE(&map->rb_node);
-		dso__get(map->dso);
+		dso__get(map_sh(map)->dso);
 		map->groups = NULL;
 	}
 
@@ -403,20 +406,23 @@ struct map *map__clone(struct map *from)
 
 size_t map__fprintf(struct map *map, FILE *fp)
 {
+	struct map_shared *sh = map_sh(map);
+
 	return fprintf(fp, " %" PRIx64 "-%" PRIx64 " %" PRIx64 " %s\n",
-		       map->start, map->end, map->pgoff, map->dso->name);
+		       sh->start, sh->end, sh->pgoff, sh->dso->name);
 }
 
 size_t map__fprintf_dsoname(struct map *map, FILE *fp)
 {
+	struct map_shared *sh = map_sh(map);
 	char buf[symbol_conf.pad_output_len_dso + 1];
 	const char *dsoname = "[unknown]";
 
-	if (map && map->dso) {
-		if (symbol_conf.show_kernel_path && map->dso->long_name)
-			dsoname = map->dso->long_name;
+	if (map && sh->dso) {
+		if (symbol_conf.show_kernel_path && sh->dso->long_name)
+			dsoname = sh->dso->long_name;
 		else
-			dsoname = map->dso->name;
+			dsoname = sh->dso->name;
 	}
 
 	if (symbol_conf.pad_output_len_dso) {
@@ -431,7 +437,7 @@ char *map__srcline(struct map *map, u64 addr, struct symbol *sym)
 {
 	if (map == NULL)
 		return SRCLINE_UNKNOWN;
-	return get_srcline(map->dso, map__rip_2objdump(map, addr), sym, true, true, addr);
+	return get_srcline(map_sh(map)->dso, map__rip_2objdump(map, addr), sym, true, true, addr);
 }
 
 int map__fprintf_srcline(struct map *map, u64 addr, const char *prefix,
@@ -439,7 +445,7 @@ int map__fprintf_srcline(struct map *map, u64 addr, const char *prefix,
 {
 	int ret = 0;
 
-	if (map && map->dso) {
+	if (map && map_sh(map)->dso) {
 		char *srcline = map__srcline(map, addr, NULL);
 		if (srcline != SRCLINE_UNKNOWN)
 			ret = fprintf(fp, "%s%s", prefix, srcline);
@@ -458,9 +464,9 @@ int map__fprintf_srccode(struct map *map, u64 addr,
 	int len;
 	char *srccode;
 
-	if (!map || !map->dso)
+	if (!map || !map_sh(map)->dso)
 		return 0;
-	srcfile = get_srcline_split(map->dso,
+	srcfile = get_srcline_split(map_sh(map)->dso,
 				    map__rip_2objdump(map, addr),
 				    &line);
 	if (!srcfile)
@@ -512,6 +518,7 @@ void srccode_state_free(struct srccode_state *state)
  */
 u64 map__rip_2objdump(struct map *map, u64 rip)
 {
+	struct map_shared *sh = map_sh(map);
 	struct kmap *kmap = __map__kmap(map);
 
 	/*
@@ -526,20 +533,20 @@ u64 map__rip_2objdump(struct map *map, u64 rip)
 			map = kernel_map;
 	}
 
-	if (!map->dso->adjust_symbols)
+	if (!sh->dso->adjust_symbols)
 		return rip;
 
-	if (map->dso->rel)
-		return rip - map->pgoff;
+	if (sh->dso->rel)
+		return rip - sh->pgoff;
 
 	/*
 	 * kernel modules also have DSO_TYPE_USER in dso->kernel,
 	 * but all kernel modules are ET_REL, so won't get here.
 	 */
-	if (map->dso->kernel == DSO_TYPE_USER)
-		return rip + map->dso->text_offset;
+	if (sh->dso->kernel == DSO_TYPE_USER)
+		return rip + sh->dso->text_offset;
 
-	return map->unmap_ip(map, rip) - map->reloc;
+	return sh->unmap_ip(map, rip) - sh->reloc;
 }
 
 /**
@@ -556,20 +563,22 @@ u64 map__rip_2objdump(struct map *map, u64 rip)
  */
 u64 map__objdump_2mem(struct map *map, u64 ip)
 {
-	if (!map->dso->adjust_symbols)
-		return map->unmap_ip(map, ip);
+	struct map_shared *sh = map_sh(map);
+
+	if (!sh->dso->adjust_symbols)
+		return sh->unmap_ip(map, ip);
 
-	if (map->dso->rel)
-		return map->unmap_ip(map, ip + map->pgoff);
+	if (sh->dso->rel)
+		return sh->unmap_ip(map, ip + sh->pgoff);
 
 	/*
 	 * kernel modules also have DSO_TYPE_USER in dso->kernel,
 	 * but all kernel modules are ET_REL, so won't get here.
 	 */
-	if (map->dso->kernel == DSO_TYPE_USER)
-		return map->unmap_ip(map, ip - map->dso->text_offset);
+	if (sh->dso->kernel == DSO_TYPE_USER)
+		return sh->unmap_ip(map, ip - sh->dso->text_offset);
 
-	return ip + map->reloc;
+	return ip + sh->reloc;
 }
 
 static void maps__init(struct maps *maps)
@@ -670,7 +679,7 @@ struct symbol *map_groups__find_symbol(struct map_groups *mg,
 	if (map != NULL && map__load(map) >= 0) {
 		if (mapp != NULL)
 			*mapp = map;
-		return map__find_symbol(map, map->map_ip(map, addr));
+		return map__find_symbol(map, map_sh(map)->map_ip(map, addr));
 	}
 
 	return NULL;
@@ -678,9 +687,10 @@ struct symbol *map_groups__find_symbol(struct map_groups *mg,
 
 static bool map__contains_symbol(struct map *map, struct symbol *sym)
 {
-	u64 ip = map->unmap_ip(map, sym->start);
+	struct map_shared *sh = map_sh(map);
+	u64 ip = sh->unmap_ip(map, sym->start);
 
-	return ip >= map->start && ip < map->end;
+	return ip >= sh->start && ip < sh->end;
 }
 
 struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name,
@@ -722,7 +732,9 @@ struct symbol *map_groups__find_symbol_by_name(struct map_groups *mg,
 
 int map_groups__find_ams(struct addr_map_symbol *ams)
 {
-	if (ams->addr < ams->map->start || ams->addr >= ams->map->end) {
+	struct map_shared *sh = map_sh(ams->map);
+
+	if (ams->addr < sh->start || ams->addr >= sh->end) {
 		if (ams->map->groups == NULL)
 			return -1;
 		ams->map = map_groups__find(ams->map->groups, ams->addr);
@@ -730,7 +742,7 @@ int map_groups__find_ams(struct addr_map_symbol *ams)
 			return -1;
 	}
 
-	ams->al_addr = ams->map->map_ip(ams->map, ams->addr);
+	ams->al_addr = sh->map_ip(ams->map, ams->addr);
 	ams->sym = map__find_symbol(ams->map, ams->al_addr);
 
 	return ams->sym ? 0 : -1;
@@ -748,7 +760,7 @@ static size_t maps__fprintf(struct maps *maps, FILE *fp)
 		printed += fprintf(fp, "Map:");
 		printed += map__fprintf(pos, fp);
 		if (verbose > 2) {
-			printed += dso__fprintf(pos->dso, fp);
+			printed += dso__fprintf(map_sh(pos)->dso, fp);
 			printed += fprintf(fp, "--\n");
 		}
 	}
@@ -789,9 +801,9 @@ static int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp
 	while (next) {
 		struct map *pos = rb_entry(next, struct map, rb_node);
 
-		if (pos->end > map->start) {
+		if (map_sh(pos)->end > map_sh(map)->start) {
 			first = next;
-			if (pos->start <= map->start)
+			if (map_sh(pos)->start <= map_sh(map)->start)
 				break;
 			next = next->rb_left;
 		} else
@@ -807,14 +819,14 @@ static int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp
 		 * Stop if current map starts after map->end.
 		 * Maps are ordered by start: next will not overlap for sure.
 		 */
-		if (pos->start >= map->end)
+		if (map_sh(pos)->start >= map_sh(map)->end)
 			break;
 
 		if (verbose >= 2) {
 
 			if (use_browser) {
 				pr_debug("overlapping maps in %s (disable tui for more info)\n",
-					   map->dso->name);
+					   map_sh(map)->dso->name);
 			} else {
 				fputs("overlapping maps:\n", fp);
 				map__fprintf(map, fp);
@@ -827,7 +839,7 @@ static int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp
 		 * Now check if we need to create new maps for areas not
 		 * overlapped by the new map:
 		 */
-		if (map->start > pos->start) {
+		if (map_sh(map)->start > map_sh(pos)->start) {
 			struct map *before = map__clone(pos);
 
 			if (before == NULL) {
@@ -835,14 +847,14 @@ static int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp
 				goto put_map;
 			}
 
-			before->end = map->start;
+			map_sh(before)->end = map_sh(map)->start;
 			__map_groups__insert(pos->groups, before);
 			if (verbose >= 2 && !use_browser)
 				map__fprintf(before, fp);
 			map__put(before);
 		}
 
-		if (map->end < pos->end) {
+		if (map_sh(map)->end < map_sh(pos)->end) {
 			struct map *after = map__clone(pos);
 
 			if (after == NULL) {
@@ -850,9 +862,9 @@ static int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp
 				goto put_map;
 			}
 
-			after->start = map->end;
-			after->pgoff += map->end - pos->start;
-			assert(pos->map_ip(pos, map->end) == after->map_ip(after, map->end));
+			map_sh(after)->start  = map_sh(map)->end;
+			map_sh(after)->pgoff += map_sh(map)->end - map_sh(pos)->start;
+			assert(map_sh(pos)->map_ip(pos, map_sh(map)->end) == map_sh(after)->map_ip(after, map_sh(map)->end));
 			__map_groups__insert(pos->groups, after);
 			if (verbose >= 2 && !use_browser)
 				map__fprintf(after, fp);
@@ -912,13 +924,13 @@ static void __maps__insert(struct maps *maps, struct map *map)
 {
 	struct rb_node **p = &maps->entries.rb_node;
 	struct rb_node *parent = NULL;
-	const u64 ip = map->start;
+	const u64 ip = map_sh(map)->start;
 	struct map *m;
 
 	while (*p != NULL) {
 		parent = *p;
 		m = rb_entry(parent, struct map, rb_node);
-		if (ip < m->start)
+		if (ip < map_sh(m)->start)
 			p = &(*p)->rb_left;
 		else
 			p = &(*p)->rb_right;
@@ -939,7 +951,7 @@ static void __maps__insert_name(struct maps *maps, struct map *map)
 	while (*p != NULL) {
 		parent = *p;
 		m = rb_entry(parent, struct map, rb_node_name);
-		rc = strcmp(m->dso->short_name, map->dso->short_name);
+		rc = strcmp(map_sh(m)->dso->short_name, map_sh(map)->dso->short_name);
 		if (rc < 0)
 			p = &(*p)->rb_left;
 		else
@@ -984,9 +996,9 @@ struct map *maps__find(struct maps *maps, u64 ip)
 	p = maps->entries.rb_node;
 	while (p != NULL) {
 		m = rb_entry(p, struct map, rb_node);
-		if (ip < m->start)
+		if (ip < map_sh(m)->start)
 			p = p->rb_left;
-		else if (ip >= m->end)
+		else if (ip >= map_sh(m)->end)
 			p = p->rb_right;
 		else
 			goto out;
@@ -1018,7 +1030,7 @@ struct map *map__next(struct map *map)
 
 struct kmap *__map__kmap(struct map *map)
 {
-	if (!map->dso || !map->dso->kernel)
+	if (!map_sh(map)->dso || !map_sh(map)->dso->kernel)
 		return NULL;
 	return (struct kmap *)(map + 1);
 }
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index c3614195ddc7..297e8f9d1c4c 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -17,13 +17,9 @@ struct ref_reloc_sym;
 struct map_groups;
 struct machine;
 struct evsel;
+struct map;
 
-struct map {
-	union {
-		struct rb_node	rb_node;
-		struct list_head node;
-	};
-	struct rb_node          rb_node_name;
+struct map_shared {
 	u64			start;
 	u64			end;
 	bool			erange_warned;
@@ -42,10 +38,21 @@ struct map {
 	u64			(*unmap_ip)(struct map *, u64);
 
 	struct dso		*dso;
+};
+
+struct map {
+	union {
+		struct rb_node   rb_node;
+		struct list_head node;
+	};
+	struct rb_node		 rb_node_name;
+	struct map_shared	 shared;
 	struct map_groups	*groups;
-	refcount_t		refcnt;
+	refcount_t		 refcnt;
 };
 
+#define map_sh(__m)  (&((__m)->shared))
+
 struct kmap;
 
 struct kmap *__map__kmap(struct map *map);
@@ -54,12 +61,12 @@ struct map_groups *map__kmaps(struct map *map);
 
 static inline u64 map__map_ip(struct map *map, u64 ip)
 {
-	return ip - map->start + map->pgoff;
+	return ip - map_sh(map)->start + map_sh(map)->pgoff;
 }
 
 static inline u64 map__unmap_ip(struct map *map, u64 ip)
 {
-	return ip + map->start - map->pgoff;
+	return ip + map_sh(map)->start - map_sh(map)->pgoff;
 }
 
 static inline u64 identity__map_ip(struct map *map __maybe_unused, u64 ip)
@@ -69,7 +76,7 @@ static inline u64 identity__map_ip(struct map *map __maybe_unused, u64 ip)
 
 static inline size_t map__size(const struct map *map)
 {
-	return map->end - map->start;
+	return map_sh(map)->end - map_sh(map)->start;
 }
 
 /* rip/ip <-> addr suitable for passing to `objdump --start-address=` */
@@ -89,7 +96,7 @@ struct thread;
  * Note: caller must ensure map->dso is not NULL (map is loaded).
  */
 #define map__for_each_symbol(map, pos, n)	\
-	dso__for_each_symbol(map->dso, pos, n)
+	dso__for_each_symbol(map_sh(map)->dso, pos, n)
 
 /* map__for_each_symbol_with_name - iterate over the symbols in the given map
  *                                  that have the given name
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 91cab5f669d2..e32c453ba756 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -132,9 +132,9 @@ static int kernel_get_symbol_address_by_name(const char *name, u64 *addr,
 		sym = machine__find_kernel_symbol_by_name(host_machine, name, &map);
 		if (!sym)
 			return -ENOENT;
-		*addr = map->unmap_ip(map, sym->start) -
-			((reloc) ? 0 : map->reloc) -
-			((reladdr) ? map->start : 0);
+		*addr = map_sh(map)->unmap_ip(map, sym->start) -
+			((reloc) ? 0 : map_sh(map)->reloc) -
+			((reladdr) ? map_sh(map)->start : 0);
 	}
 	return 0;
 }
@@ -155,9 +155,9 @@ static struct map *kernel_get_module_map(const char *module)
 
 	for (pos = maps__first(maps); pos; pos = map__next(pos)) {
 		/* short_name is "[module]" */
-		if (strncmp(pos->dso->short_name + 1, module,
-			    pos->dso->short_name_len - 2) == 0 &&
-		    module[pos->dso->short_name_len - 2] == '\0') {
+		if (strncmp(map_sh(pos)->dso->short_name + 1, module,
+			    map_sh(pos)->dso->short_name_len - 2) == 0 &&
+		    module[map_sh(pos)->dso->short_name_len - 2] == '\0') {
 			return map__get(pos);
 		}
 	}
@@ -171,8 +171,8 @@ struct map *get_target_map(const char *target, struct nsinfo *nsi, bool user)
 		struct map *map;
 
 		map = dso__new_map(target);
-		if (map && map->dso)
-			map->dso->nsinfo = nsinfo__get(nsi);
+		if (map && map_sh(map)->dso)
+			map_sh(map)->dso->nsinfo = nsinfo__get(nsi);
 		return map;
 	} else {
 		return kernel_get_module_map(target);
@@ -323,7 +323,7 @@ static int kernel_get_module_dso(const char *module, struct dso **pdso)
 		snprintf(module_name, sizeof(module_name), "[%s]", module);
 		map = map_groups__find_by_name(&host_machine->kmaps, module_name);
 		if (map) {
-			dso = map->dso;
+			dso = map_sh(map)->dso;
 			goto found;
 		}
 		pr_debug("Failed to find module %s.\n", module);
@@ -331,7 +331,7 @@ static int kernel_get_module_dso(const char *module, struct dso **pdso)
 	}
 
 	map = machine__kernel_map(host_machine);
-	dso = map->dso;
+	dso = map_sh(map)->dso;
 
 	vmlinux_name = symbol_conf.vmlinux_name;
 	dso->load_errno = 0;
@@ -373,7 +373,7 @@ static int find_alternative_probe_point(struct debuginfo *dinfo,
 		if (uprobes)
 			address = sym->start;
 		else
-			address = map->unmap_ip(map, sym->start) - map->reloc;
+			address = map_sh(map)->unmap_ip(map, sym->start) - map_sh(map)->reloc;
 		break;
 	}
 	if (!address) {
@@ -2123,7 +2123,7 @@ static int find_perf_probe_point_from_map(struct probe_trace_point *tp,
 		goto out;
 
 	pp->retprobe = tp->retprobe;
-	pp->offset = addr - map->unmap_ip(map, sym->start);
+	pp->offset = addr - map_sh(map)->unmap_ip(map, sym->start);
 	pp->function = strdup(sym->name);
 	ret = pp->function ? 0 : -ENOMEM;
 
@@ -2958,7 +2958,7 @@ static int find_probe_trace_events_from_map(struct perf_probe_event *pev,
 			goto err_out;
 		}
 		/* Add one probe point */
-		tp->address = map->unmap_ip(map, sym->start) + pp->offset;
+		tp->address = map_sh(map)->unmap_ip(map, sym->start) + pp->offset;
 
 		/* Check the kprobe (not in module) is within .text  */
 		if (!pev->uprobes && !pev->target &&
@@ -3528,13 +3528,13 @@ int show_available_funcs(const char *target, struct nsinfo *nsi,
 			       (target) ? : "kernel");
 		goto end;
 	}
-	if (!dso__sorted_by_name(map->dso))
-		dso__sort_by_name(map->dso);
+	if (!dso__sorted_by_name(map_sh(map)->dso))
+		dso__sort_by_name(map_sh(map)->dso);
 
 	/* Show all (filtered) symbols */
 	setup_pager();
 
-	for (nd = rb_first_cached(&map->dso->symbol_names); nd;
+	for (nd = rb_first_cached(&map_sh(map)->dso->symbol_names); nd;
 	     nd = rb_next(nd)) {
 		struct symbol_name_rb_node *pos = rb_entry(nd, struct symbol_name_rb_node, rb_node);
 
diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
index 15961854ba67..f525f6477af7 100644
--- a/tools/perf/util/scripting-engines/trace-event-perl.c
+++ b/tools/perf/util/scripting-engines/trace-event-perl.c
@@ -315,11 +315,11 @@ static SV *perl_process_callchain(struct perf_sample *sample,
 		if (node->map) {
 			struct map *map = node->map;
 			const char *dsoname = "[unknown]";
-			if (map && map->dso) {
-				if (symbol_conf.show_kernel_path && map->dso->long_name)
-					dsoname = map->dso->long_name;
+			if (map && map_sh(map)->dso) {
+				if (symbol_conf.show_kernel_path && map_sh(map)->dso->long_name)
+					dsoname = map_sh(map)->dso->long_name;
 				else
-					dsoname = map->dso->name;
+					dsoname = map_sh(map)->dso->name;
 			}
 			if (!hv_stores(elem, "dso", newSVpv(dsoname,0))) {
 				hv_undef(elem);
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 5d341efc3237..34365ca07a56 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -381,11 +381,11 @@ static const char *get_dsoname(struct map *map)
 {
 	const char *dsoname = "[unknown]";
 
-	if (map && map->dso) {
-		if (symbol_conf.show_kernel_path && map->dso->long_name)
-			dsoname = map->dso->long_name;
+	if (map && map_sh(map)->dso) {
+		if (symbol_conf.show_kernel_path && map_sh(map)->dso->long_name)
+			dsoname = map_sh(map)->dso->long_name;
 		else
-			dsoname = map->dso->name;
+			dsoname = map_sh(map)->dso->name;
 	}
 
 	return dsoname;
@@ -525,7 +525,7 @@ static unsigned long get_offset(struct symbol *sym, struct addr_location *al)
 	if (al->addr < sym->end)
 		offset = al->addr - sym->start;
 	else
-		offset = al->addr - al->map->start - sym->start;
+		offset = al->addr - map_sh(al->map)->start - sym->start;
 
 	return offset;
 }
@@ -769,7 +769,7 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 			_PyUnicode_FromString(thread__comm_str(al->thread)));
 	if (al->map) {
 		pydict_set_item_string_decref(dict, "dso",
-			_PyUnicode_FromString(al->map->dso->name));
+			_PyUnicode_FromString(map_sh(al->map)->dso->name));
 	}
 	if (al->sym) {
 		pydict_set_item_string_decref(dict, "symbol",
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 43d1d410854a..8d0edad5b4a6 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -167,8 +167,8 @@ struct sort_entry sort_comm = {
 
 static int64_t _sort__dso_cmp(struct map *map_l, struct map *map_r)
 {
-	struct dso *dso_l = map_l ? map_l->dso : NULL;
-	struct dso *dso_r = map_r ? map_r->dso : NULL;
+	struct dso *dso_l = map_l ? map_sh(map_l)->dso : NULL;
+	struct dso *dso_r = map_r ? map_sh(map_r)->dso : NULL;
 	const char *dso_name_l, *dso_name_r;
 
 	if (!dso_l || !dso_r)
@@ -194,9 +194,9 @@ sort__dso_cmp(struct hist_entry *left, struct hist_entry *right)
 static int _hist_entry__dso_snprintf(struct map *map, char *bf,
 				     size_t size, unsigned int width)
 {
-	if (map && map->dso) {
-		const char *dso_name = verbose > 0 ? map->dso->long_name :
-			map->dso->short_name;
+	if (map && map_sh(map)->dso) {
+		const char *dso_name = verbose > 0 ? map_sh(map)->dso->long_name :
+			map_sh(map)->dso->short_name;
 		return repsep_snprintf(bf, size, "%-*.*s", width, width, dso_name);
 	}
 
@@ -216,7 +216,7 @@ static int hist_entry__dso_filter(struct hist_entry *he, int type, const void *a
 	if (type != HIST_FILTER__DSO)
 		return -1;
 
-	return dso && (!he->ms.map || he->ms.map->dso != dso);
+	return dso && (!he->ms.map || map_sh(he->ms.map)->dso != dso);
 }
 
 struct sort_entry sort_dso = {
@@ -294,7 +294,7 @@ static int _hist_entry__sym_snprintf(struct map *map, struct symbol *sym,
 	size_t ret = 0;
 
 	if (verbose > 0) {
-		char o = map ? dso__symtab_origin(map->dso) : '!';
+		char o = map ? dso__symtab_origin(map_sh(map)->dso) : '!';
 		ret += repsep_snprintf(bf, size, "%-#*llx %c ",
 				       BITS_PER_LONG / 4 + 2, ip, o);
 	}
@@ -304,7 +304,7 @@ static int _hist_entry__sym_snprintf(struct map *map, struct symbol *sym,
 		if (sym->type == STT_OBJECT) {
 			ret += repsep_snprintf(bf + ret, size - ret, "%s", sym->name);
 			ret += repsep_snprintf(bf + ret, size - ret, "+0x%llx",
-					ip - map->unmap_ip(map, sym->start));
+					ip - map_sh(map)->unmap_ip(map, sym->start));
 		} else {
 			ret += repsep_snprintf(bf + ret, size - ret, "%.*s",
 					       width - ret,
@@ -504,7 +504,7 @@ static char *hist_entry__get_srcfile(struct hist_entry *e)
 	if (!map)
 		return no_srcfile;
 
-	sf = __get_srcline(map->dso, map__rip_2objdump(map, e->ip),
+	sf = __get_srcline(map_sh(map)->dso, map__rip_2objdump(map, e->ip),
 			 e->ms.sym, false, true, true, e->ip);
 	if (!strcmp(sf, SRCLINE_UNKNOWN))
 		return no_srcfile;
@@ -792,7 +792,7 @@ static int hist_entry__dso_from_filter(struct hist_entry *he, int type,
 		return -1;
 
 	return dso && (!he->branch_info || !he->branch_info->from.map ||
-		       he->branch_info->from.map->dso != dso);
+		       map_sh(he->branch_info->from.map)->dso != dso);
 }
 
 static int64_t
@@ -824,7 +824,7 @@ static int hist_entry__dso_to_filter(struct hist_entry *he, int type,
 		return -1;
 
 	return dso && (!he->branch_info || !he->branch_info->to.map ||
-		       he->branch_info->to.map->dso != dso);
+		       map_sh(he->branch_info->to.map)->dso != dso);
 }
 
 static int64_t
@@ -1200,6 +1200,7 @@ sort__dcacheline_cmp(struct hist_entry *left, struct hist_entry *right)
 {
 	u64 l, r;
 	struct map *l_map, *r_map;
+	struct map_shared *ls_map, *rs_map;
 
 	if (!left->mem_info)  return -1;
 	if (!right->mem_info) return 1;
@@ -1218,17 +1219,20 @@ sort__dcacheline_cmp(struct hist_entry *left, struct hist_entry *right)
 	if (!l_map) return -1;
 	if (!r_map) return 1;
 
-	if (l_map->maj > r_map->maj) return -1;
-	if (l_map->maj < r_map->maj) return 1;
+	ls_map = map_sh(l_map);
+	rs_map = map_sh(r_map);
 
-	if (l_map->min > r_map->min) return -1;
-	if (l_map->min < r_map->min) return 1;
+	if (ls_map->maj > rs_map->maj) return -1;
+	if (ls_map->maj < rs_map->maj) return 1;
 
-	if (l_map->ino > r_map->ino) return -1;
-	if (l_map->ino < r_map->ino) return 1;
+	if (ls_map->min > rs_map->min) return -1;
+	if (ls_map->min < rs_map->min) return 1;
 
-	if (l_map->ino_generation > r_map->ino_generation) return -1;
-	if (l_map->ino_generation < r_map->ino_generation) return 1;
+	if (ls_map->ino > rs_map->ino) return -1;
+	if (ls_map->ino < rs_map->ino) return 1;
+
+	if (ls_map->ino_generation > rs_map->ino_generation) return -1;
+	if (ls_map->ino_generation < rs_map->ino_generation) return 1;
 
 	/*
 	 * Addresses with no major/minor numbers are assumed to be
@@ -1239,9 +1243,9 @@ sort__dcacheline_cmp(struct hist_entry *left, struct hist_entry *right)
 	 */
 
 	if ((left->cpumode != PERF_RECORD_MISC_KERNEL) &&
-	    (!(l_map->flags & MAP_SHARED)) &&
-	    !l_map->maj && !l_map->min && !l_map->ino &&
-	    !l_map->ino_generation) {
+	    (!(ls_map->flags & MAP_SHARED)) &&
+	    !ls_map->maj && !ls_map->min && !ls_map->ino &&
+	    !ls_map->ino_generation) {
 		/* userspace anonymous */
 
 		if (left->thread->pid_ > right->thread->pid_) return -1;
@@ -1275,10 +1279,10 @@ static int hist_entry__dcacheline_snprintf(struct hist_entry *he, char *bf,
 
 		/* print [s] for shared data mmaps */
 		if ((he->cpumode != PERF_RECORD_MISC_KERNEL) &&
-		     map && !(map->prot & PROT_EXEC) &&
-		    (map->flags & MAP_SHARED) &&
-		    (map->maj || map->min || map->ino ||
-		     map->ino_generation))
+		     map && !(map_sh(map)->prot & PROT_EXEC) &&
+		    (map_sh(map)->flags & MAP_SHARED) &&
+		    (map_sh(map)->maj || map_sh(map)->min || map_sh(map)->ino ||
+		     map_sh(map)->ino_generation))
 			level = 's';
 		else if (!map)
 			level = 'X';
@@ -1629,7 +1633,7 @@ sort__dso_size_cmp(struct hist_entry *left, struct hist_entry *right)
 static int _hist_entry__dso_size_snprintf(struct map *map, char *bf,
 					  size_t bf_size, unsigned int width)
 {
-	if (map && map->dso)
+	if (map && map_sh(map)->dso)
 		return repsep_snprintf(bf, bf_size, "%*d", width,
 				       map__size(map));
 
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 66f4be1df573..3a67f1145dd3 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -868,11 +868,11 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 		 */
 		if (*remap_kernel && dso->kernel) {
 			*remap_kernel = false;
-			map->start = shdr->sh_addr + ref_reloc(kmap);
-			map->end = map->start + shdr->sh_size;
-			map->pgoff = shdr->sh_offset;
-			map->map_ip = map__map_ip;
-			map->unmap_ip = map__unmap_ip;
+			map_sh(map)->start = shdr->sh_addr + ref_reloc(kmap);
+			map_sh(map)->end = map_sh(map)->start + shdr->sh_size;
+			map_sh(map)->pgoff = shdr->sh_offset;
+			map_sh(map)->map_ip = map__map_ip;
+			map_sh(map)->unmap_ip = map__unmap_ip;
 			/* Ensure maps are correctly ordered */
 			if (kmaps) {
 				map__get(map);
@@ -889,7 +889,7 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 		 */
 		if (*remap_kernel && kmodule) {
 			*remap_kernel = false;
-			map->pgoff = shdr->sh_offset;
+			map_sh(map)->pgoff = shdr->sh_offset;
 		}
 
 		*curr_mapp = map;
@@ -907,7 +907,7 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 		u64 start = sym->st_value;
 
 		if (kmodule)
-			start += map->start + shdr->sh_offset;
+			start += map_sh(map)->start + shdr->sh_offset;
 
 		curr_dso = dso__new(dso_name);
 		if (curr_dso == NULL)
@@ -921,11 +921,11 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 			return -1;
 
 		if (adjust_kernel_syms) {
-			curr_map->start  = shdr->sh_addr + ref_reloc(kmap);
-			curr_map->end	 = curr_map->start + shdr->sh_size;
-			curr_map->pgoff	 = shdr->sh_offset;
+			map_sh(curr_map)->start  = shdr->sh_addr + ref_reloc(kmap);
+			map_sh(curr_map)->end	 = map_sh(curr_map)->start + shdr->sh_size;
+			map_sh(curr_map)->pgoff	 = shdr->sh_offset;
 		} else {
-			curr_map->map_ip = curr_map->unmap_ip = identity__map_ip;
+			map_sh(curr_map)->map_ip = map_sh(curr_map)->unmap_ip = identity__map_ip;
 		}
 		curr_dso->symtab_type = dso->symtab_type;
 		map_groups__insert(kmaps, curr_map);
@@ -941,7 +941,7 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 		*curr_mapp = curr_map;
 		*curr_dsop = curr_dso;
 	} else
-		*curr_dsop = curr_map->dso;
+		*curr_dsop = map_sh(curr_map)->dso;
 
 	return 0;
 }
@@ -1041,7 +1041,7 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 			if (strcmp(elf_name, kmap->ref_reloc_sym->name))
 				continue;
 			kmap->ref_reloc_sym->unrelocated_addr = sym.st_value;
-			map->reloc = kmap->ref_reloc_sym->addr -
+			map_sh(map)->reloc = kmap->ref_reloc_sym->addr -
 				     kmap->ref_reloc_sym->unrelocated_addr;
 			break;
 		}
@@ -1052,7 +1052,7 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 	 * attempted to prelink vdso to its virtual address.
 	 */
 	if (dso__is_vdso(dso))
-		map->reloc = map->start - dso->text_offset;
+		map_sh(map)->reloc = map_sh(map)->start - dso->text_offset;
 
 	dso->adjust_symbols = runtime_ss->adjust_symbols || ref_reloc(kmap);
 	/*
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index a8f80e427674..80c4429304f0 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -251,8 +251,8 @@ void map_groups__fixup_end(struct map_groups *mg)
 		goto out_unlock;
 
 	for (next = map__next(curr); next; next = map__next(curr)) {
-		if (!curr->end)
-			curr->end = next->start;
+		if (!map_sh(curr)->end)
+			map_sh(curr)->end = map_sh(next)->start;
 		curr = next;
 	}
 
@@ -260,8 +260,8 @@ void map_groups__fixup_end(struct map_groups *mg)
 	 * We still haven't the actual symbols, so guess the
 	 * last map final address.
 	 */
-	if (!curr->end)
-		curr->end = ~0ULL;
+	if (!map_sh(curr)->end)
+		map_sh(curr)->end = ~0ULL;
 
 out_unlock:
 	up_write(&maps->lock);
@@ -735,12 +735,12 @@ static int map_groups__split_kallsyms_for_kcore(struct map_groups *kmaps, struct
 			continue;
 		}
 
-		pos->start -= curr_map->start - curr_map->pgoff;
-		if (pos->end > curr_map->end)
-			pos->end = curr_map->end;
+		pos->start -= map_sh(curr_map)->start - map_sh(curr_map)->pgoff;
+		if (pos->end > map_sh(curr_map)->end)
+			pos->end = map_sh(curr_map)->end;
 		if (pos->end)
-			pos->end -= curr_map->start - curr_map->pgoff;
-		symbols__insert(&curr_map->dso->symbols, pos);
+			pos->end -= map_sh(curr_map)->start - map_sh(curr_map)->pgoff;
+		symbols__insert(&map_sh(curr_map)->dso->symbols, pos);
 		++count;
 	}
 
@@ -787,7 +787,7 @@ static int map_groups__split_kallsyms(struct map_groups *kmaps, struct dso *dso,
 
 			*module++ = '\0';
 
-			if (strcmp(curr_map->dso->short_name, module)) {
+			if (strcmp(map_sh(curr_map)->dso->short_name, module)) {
 				if (curr_map != initial_map &&
 				    dso->kernel == DSO_TYPE_GUEST_KERNEL &&
 				    machine__is_default_guest(machine)) {
@@ -798,7 +798,7 @@ static int map_groups__split_kallsyms(struct map_groups *kmaps, struct dso *dso,
 					 * symbols are in its kmap. Mark it as
 					 * loaded.
 					 */
-					dso__set_loaded(curr_map->dso);
+					dso__set_loaded(map_sh(curr_map)->dso);
 				}
 
 				curr_map = map_groups__find_by_name(kmaps, module);
@@ -811,7 +811,7 @@ static int map_groups__split_kallsyms(struct map_groups *kmaps, struct dso *dso,
 					goto discard_symbol;
 				}
 
-				if (curr_map->dso->loaded &&
+				if (map_sh(curr_map)->dso->loaded &&
 				    !machine__is_default_guest(machine))
 					goto discard_symbol;
 			}
@@ -819,8 +819,8 @@ static int map_groups__split_kallsyms(struct map_groups *kmaps, struct dso *dso,
 			 * So that we look just like we get from .ko files,
 			 * i.e. not prelinked, relative to initial_map->start.
 			 */
-			pos->start = curr_map->map_ip(curr_map, pos->start);
-			pos->end   = curr_map->map_ip(curr_map, pos->end);
+			pos->start = map_sh(curr_map)->map_ip(curr_map, pos->start);
+			pos->end   = map_sh(curr_map)->map_ip(curr_map, pos->end);
 		} else if (x86_64 && is_entry_trampoline(pos->name)) {
 			/*
 			 * These symbols are not needed anymore since the
@@ -867,7 +867,7 @@ static int map_groups__split_kallsyms(struct map_groups *kmaps, struct dso *dso,
 				return -1;
 			}
 
-			curr_map->map_ip = curr_map->unmap_ip = identity__map_ip;
+			map_sh(curr_map)->map_ip = map_sh(curr_map)->unmap_ip = identity__map_ip;
 			map_groups__insert(kmaps, curr_map);
 			++kernel_range;
 		} else if (delta) {
@@ -878,7 +878,7 @@ static int map_groups__split_kallsyms(struct map_groups *kmaps, struct dso *dso,
 add_symbol:
 		if (curr_map != initial_map) {
 			rb_erase_cached(&pos->rb_node, root);
-			symbols__insert(&curr_map->dso->symbols, pos);
+			symbols__insert(&map_sh(curr_map)->dso->symbols, pos);
 			++moved;
 		} else
 			++count;
@@ -892,7 +892,7 @@ static int map_groups__split_kallsyms(struct map_groups *kmaps, struct dso *dso,
 	if (curr_map != initial_map &&
 	    dso->kernel == DSO_TYPE_GUEST_KERNEL &&
 	    machine__is_default_guest(kmaps->machine)) {
-		dso__set_loaded(curr_map->dso);
+		dso__set_loaded(map_sh(curr_map)->dso);
 	}
 
 	return count + moved;
@@ -1080,8 +1080,8 @@ static int do_validate_kcore_modules(const char *filename,
 		}
 
 		/* Module must be in memory at the same address */
-		mi = find_module(old_map->dso->short_name, &modules);
-		if (!mi || mi->start != old_map->start) {
+		mi = find_module(map_sh(old_map)->dso->short_name, &modules);
+		if (!mi || mi->start != map_sh(old_map)->start) {
 			err = -EINVAL;
 			goto out;
 		}
@@ -1172,8 +1172,8 @@ static int kcore_mapfn(u64 start, u64 len, u64 pgoff, void *data)
 	if (map == NULL)
 		return -ENOMEM;
 
-	map->end = map->start + len;
-	map->pgoff = pgoff;
+	map_sh(map)->end = map_sh(map)->start + len;
+	map_sh(map)->pgoff = pgoff;
 
 	list_add(&map->node, &md->maps);
 
@@ -1193,21 +1193,21 @@ int map_groups__merge_in(struct map_groups *kmaps, struct map *new_map)
 	     old_map = map_groups__next(old_map)) {
 
 		/* no overload with this one */
-		if (new_map->end < old_map->start ||
-		    new_map->start >= old_map->end)
+		if (map_sh(new_map)->end < map_sh(old_map)->start ||
+		    map_sh(new_map)->start >= map_sh(old_map)->end)
 			continue;
 
-		if (new_map->start < old_map->start) {
+		if (map_sh(new_map)->start < map_sh(old_map)->start) {
 			/*
 			 * |new......
 			 *       |old....
 			 */
-			if (new_map->end < old_map->end) {
+			if (map_sh(new_map)->end < map_sh(old_map)->end) {
 				/*
 				 * |new......|     -> |new..|
 				 *       |old....| ->       |old....|
 				 */
-				new_map->end = old_map->start;
+				map_sh(new_map)->end = map_sh(old_map)->start;
 			} else {
 				/*
 				 * |new.............| -> |new..|       |new..|
@@ -1218,16 +1218,16 @@ int map_groups__merge_in(struct map_groups *kmaps, struct map *new_map)
 				if (!m)
 					return -ENOMEM;
 
-				m->end = old_map->start;
+				map_sh(m)->end = map_sh(old_map)->start;
 				list_add_tail(&m->node, &merged);
-				new_map->start = old_map->end;
+				map_sh(new_map)->start = map_sh(old_map)->end;
 			}
 		} else {
 			/*
 			 *      |new......
 			 * |old....
 			 */
-			if (new_map->end < old_map->end) {
+			if (map_sh(new_map)->end < map_sh(old_map)->end) {
 				/*
 				 *      |new..|   -> x
 				 * |old.........| -> |old.........|
@@ -1240,7 +1240,7 @@ int map_groups__merge_in(struct map_groups *kmaps, struct map *new_map)
 				 *      |new......| ->         |new...|
 				 * |old....|        -> |old....|
 				 */
-				new_map->start = old_map->end;
+				map_sh(new_map)->start = map_sh(old_map)->end;
 			}
 		}
 	}
@@ -1299,7 +1299,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 	}
 
 	/* Read new maps into temporary lists */
-	err = file__read_maps(fd, map->prot & PROT_EXEC, kcore_mapfn, &md,
+	err = file__read_maps(fd, map_sh(map)->prot & PROT_EXEC, kcore_mapfn, &md,
 			      &is_64_bit);
 	if (err)
 		goto out_err;
@@ -1329,7 +1329,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 	/* Find the kernel map using the '_stext' symbol */
 	if (!kallsyms__get_function_start(kallsyms_filename, "_stext", &stext)) {
 		list_for_each_entry(new_map, &md.maps, node) {
-			if (stext >= new_map->start && stext < new_map->end) {
+			if (stext >= map_sh(new_map)->start && stext < map_sh(new_map)->end) {
 				replacement_map = new_map;
 				break;
 			}
@@ -1344,11 +1344,11 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 		new_map = list_entry(md.maps.next, struct map, node);
 		list_del_init(&new_map->node);
 		if (new_map == replacement_map) {
-			map->start	= new_map->start;
-			map->end	= new_map->end;
-			map->pgoff	= new_map->pgoff;
-			map->map_ip	= new_map->map_ip;
-			map->unmap_ip	= new_map->unmap_ip;
+			map_sh(map)->start	= map_sh(new_map)->start;
+			map_sh(map)->end	= map_sh(new_map)->end;
+			map_sh(map)->pgoff	= map_sh(new_map)->pgoff;
+			map_sh(map)->map_ip	= map_sh(new_map)->map_ip;
+			map_sh(map)->unmap_ip	= map_sh(new_map)->unmap_ip;
 			/* Ensure maps are correctly ordered */
 			map__get(map);
 			map_groups__remove(kmaps, map);
@@ -1391,7 +1391,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 
 	close(fd);
 
-	if (map->prot & PROT_EXEC)
+	if (map_sh(map)->prot & PROT_EXEC)
 		pr_debug("Using %s for kernel object code\n", kcore_filename);
 	else
 		pr_debug("Using %s for kernel data\n", kcore_filename);
@@ -1797,7 +1797,7 @@ struct map *map_groups__find_by_name(struct map_groups *mg, const char *name)
 
 		map = rb_entry(node, struct map, rb_node_name);
 
-		rc = strcmp(map->dso->short_name, name);
+		rc = strcmp(map_sh(map)->dso->short_name, name);
 		if (rc < 0)
 			node = node->rb_left;
 		else if (rc > 0)
diff --git a/tools/perf/util/symbol_fprintf.c b/tools/perf/util/symbol_fprintf.c
index 35c936ce33ef..d4722b727423 100644
--- a/tools/perf/util/symbol_fprintf.c
+++ b/tools/perf/util/symbol_fprintf.c
@@ -30,7 +30,7 @@ size_t __symbol__fprintf_symname_offs(const struct symbol *sym,
 			if (al->addr < sym->end)
 				offset = al->addr - sym->start;
 			else
-				offset = al->addr - al->map->start - sym->start;
+				offset = al->addr - map_sh(al->map)->start - sym->start;
 			length += fprintf(fp, "+0x%lx", offset);
 		}
 		return length;
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 807cbca403a7..6eb956e2dff0 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -444,18 +444,18 @@ int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t
 		if (!__map__is_kmodule(pos))
 			continue;
 
-		size = PERF_ALIGN(pos->dso->long_name_len + 1, sizeof(u64));
+		size = PERF_ALIGN(map_sh(pos)->dso->long_name_len + 1, sizeof(u64));
 		event->mmap.header.type = PERF_RECORD_MMAP;
 		event->mmap.header.size = (sizeof(event->mmap) -
 				        (sizeof(event->mmap.filename) - size));
 		memset(event->mmap.filename + size, 0, machine->id_hdr_size);
 		event->mmap.header.size += machine->id_hdr_size;
-		event->mmap.start = pos->start;
-		event->mmap.len   = pos->end - pos->start;
+		event->mmap.start = map_sh(pos)->start;
+		event->mmap.len   = map_sh(pos)->end - map_sh(pos)->start;
 		event->mmap.pid   = machine->pid;
 
-		memcpy(event->mmap.filename, pos->dso->long_name,
-		       pos->dso->long_name_len + 1);
+		memcpy(event->mmap.filename, map_sh(pos)->dso->long_name,
+		       map_sh(pos)->dso->long_name_len + 1);
 		if (perf_tool__process_synth_event(tool, event, machine, process) != 0) {
 			rc = -1;
 			break;
@@ -856,8 +856,8 @@ static int __perf_event__synthesize_kernel_mmap(struct perf_tool *tool,
 	event->mmap.header.size = (sizeof(event->mmap) -
 			(sizeof(event->mmap.filename) - size) + machine->id_hdr_size);
 	event->mmap.pgoff = kmap->ref_reloc_sym->addr;
-	event->mmap.start = map->start;
-	event->mmap.len   = map->end - event->mmap.start;
+	event->mmap.start = map_sh(map)->start;
+	event->mmap.len   = map_sh(map)->end - event->mmap.start;
 	event->mmap.pid   = machine->pid;
 
 	err = perf_tool__process_synth_event(tool, event, machine, process);
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index b64e9e049636..419817e0a55e 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -443,14 +443,14 @@ int thread__memcpy(struct thread *thread, struct machine *machine,
        if (machine__kernel_ip(machine, ip))
                cpumode = PERF_RECORD_MISC_KERNEL;
 
-       if (!thread__find_map(thread, cpumode, ip, &al) || !al.map->dso ||
-	   al.map->dso->data.status == DSO_DATA_STATUS_ERROR ||
+	if (!thread__find_map(thread, cpumode, ip, &al) || !map_sh(al.map)->dso ||
+	   map_sh(al.map)->dso->data.status == DSO_DATA_STATUS_ERROR ||
 	   map__load(al.map) < 0)
-               return -1;
+		return -1;
 
-       offset = al.map->map_ip(al.map, ip);
-       if (is64bit)
-               *is64bit = al.map->dso->is_64_bit;
+	offset = map_sh(al.map)->map_ip(al.map, ip);
+	if (is64bit)
+		*is64bit = map_sh(al.map)->dso->is_64_bit;
 
-       return dso__data_read_offset(al.map->dso, machine, offset, buf, len);
+	return dso__data_read_offset(map_sh(al.map)->dso, machine, offset, buf, len);
 }
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 15f6e46d7124..7cce30e3d40b 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -31,6 +31,8 @@ static int __report_module(struct addr_location *al, u64 ip,
 {
 	Dwfl_Module *mod;
 	struct dso *dso = NULL;
+	struct map_shared *sh;
+
 	/*
 	 * Some callers will use al->sym, so we can't just use the
 	 * cheaper thread__find_map() here.
@@ -38,23 +40,25 @@ static int __report_module(struct addr_location *al, u64 ip,
 	thread__find_symbol(ui->thread, PERF_RECORD_MISC_USER, ip, al);
 
 	if (al->map)
-		dso = al->map->dso;
+		dso = map_sh(al->map)->dso;
 
 	if (!dso)
 		return 0;
 
+	sh = map_sh(al->map);
+
 	mod = dwfl_addrmodule(ui->dwfl, ip);
 	if (mod) {
 		Dwarf_Addr s;
 
 		dwfl_module_info(mod, NULL, &s, NULL, NULL, NULL, NULL, NULL);
-		if (s != al->map->start - al->map->pgoff)
+		if (s != sh->start - sh->pgoff)
 			mod = 0;
 	}
 
 	if (!mod)
 		mod = dwfl_report_elf(ui->dwfl, dso->short_name,
-				      (dso->symsrc_filename ? dso->symsrc_filename : dso->long_name), -1, al->map->start - al->map->pgoff,
+				      (dso->symsrc_filename ? dso->symsrc_filename : dso->long_name), -1, sh->start - sh->pgoff,
 				      false);
 
 	return mod && dwfl_addrmodule(ui->dwfl, ip) == mod ? 0 : -1;
@@ -87,7 +91,7 @@ static int entry(u64 ip, struct unwind_info *ui)
 	pr_debug("unwind: %s:ip = 0x%" PRIx64 " (0x%" PRIx64 ")\n",
 		 al.sym ? al.sym->name : "''",
 		 ip,
-		 al.map ? al.map->map_ip(al.map, ip) : (u64) 0);
+		 al.map ? map_sh(al.map)->map_ip(al.map, ip) : (u64) 0);
 	return 0;
 }
 
@@ -112,10 +116,10 @@ static int access_dso_mem(struct unwind_info *ui, Dwarf_Addr addr,
 		return -1;
 	}
 
-	if (!al.map->dso)
+	if (!map_sh(al.map)->dso)
 		return -1;
 
-	size = dso__data_read_addr(al.map->dso, al.map, ui->machine,
+	size = dso__data_read_addr(map_sh(al.map)->dso, al.map, ui->machine,
 				   addr, (u8 *) data, sizeof(*data));
 
 	return !(size == sizeof(*data));
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index 1800887b2255..a1fcde1d0266 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -376,25 +376,28 @@ find_proc_info(unw_addr_space_t as, unw_word_t ip, unw_proc_info_t *pi,
 {
 	struct unwind_info *ui = arg;
 	struct map *map;
+	struct map_shared *sh;
 	unw_dyn_info_t di;
 	u64 table_data, segbase, fde_count;
 	int ret = -EINVAL;
 
 	map = find_map(ip, ui);
-	if (!map || !map->dso)
+	if (!map || !map_sh(map)->dso)
 		return -EINVAL;
 
-	pr_debug("unwind: find_proc_info dso %s\n", map->dso->name);
+	sh = map_sh(map);
+
+	pr_debug("unwind: find_proc_info dso %s\n", sh->dso->name);
 
 	/* Check the .eh_frame section for unwinding info */
-	if (!read_unwind_spec_eh_frame(map->dso, ui->machine,
+	if (!read_unwind_spec_eh_frame(sh->dso, ui->machine,
 				       &table_data, &segbase, &fde_count)) {
 		memset(&di, 0, sizeof(di));
 		di.format   = UNW_INFO_FORMAT_REMOTE_TABLE;
-		di.start_ip = map->start;
-		di.end_ip   = map->end;
-		di.u.rti.segbase    = map->start + segbase - map->pgoff;
-		di.u.rti.table_data = map->start + table_data - map->pgoff;
+		di.start_ip = sh->start;
+		di.end_ip   = sh->end;
+		di.u.rti.segbase    = sh->start + segbase - sh->pgoff;
+		di.u.rti.table_data = sh->start + table_data - sh->pgoff;
 		di.u.rti.table_len  = fde_count * sizeof(struct table_entry)
 				      / sizeof(unw_word_t);
 		ret = dwarf_search_unwind_table(as, ip, &di, pi,
@@ -404,20 +407,20 @@ find_proc_info(unw_addr_space_t as, unw_word_t ip, unw_proc_info_t *pi,
 #ifndef NO_LIBUNWIND_DEBUG_FRAME
 	/* Check the .debug_frame section for unwinding info */
 	if (ret < 0 &&
-	    !read_unwind_spec_debug_frame(map->dso, ui->machine, &segbase)) {
-		int fd = dso__data_get_fd(map->dso, ui->machine);
-		int is_exec = elf_is_exec(fd, map->dso->name);
-		unw_word_t base = is_exec ? 0 : map->start;
+	    !read_unwind_spec_debug_frame(sh->dso, ui->machine, &segbase)) {
+		int fd = dso__data_get_fd(sh->dso, ui->machine);
+		int is_exec = elf_is_exec(fd, sh->dso->name);
+		unw_word_t base = is_exec ? 0 : sh->start;
 		const char *symfile;
 
 		if (fd >= 0)
-			dso__data_put_fd(map->dso);
+			dso__data_put_fd(sh->dso);
 
-		symfile = map->dso->symsrc_filename ?: map->dso->name;
+		symfile = sh->dso->symsrc_filename ?: sh->dso->name;
 
 		memset(&di, 0, sizeof(di));
 		if (dwarf_find_debug_frame(0, &di, ip, base, symfile,
-					   map->start, map->end))
+					   sh->start, sh->end))
 			return dwarf_search_unwind_table(as, ip, &di, pi,
 							 need_unwind_info, arg);
 	}
@@ -473,10 +476,10 @@ static int access_dso_mem(struct unwind_info *ui, unw_word_t addr,
 		return -1;
 	}
 
-	if (!map->dso)
+	if (!map_sh(map)->dso)
 		return -1;
 
-	size = dso__data_read_addr(map->dso, map, ui->machine,
+	size = dso__data_read_addr(map_sh(map)->dso, map, ui->machine,
 				   addr, (u8 *) data, sizeof(*data));
 
 	return !(size == sizeof(*data));
@@ -582,7 +585,7 @@ static int entry(u64 ip, struct thread *thread,
 	pr_debug("unwind: %s:ip = 0x%" PRIx64 " (0x%" PRIx64 ")\n",
 		 al.sym ? al.sym->name : "''",
 		 ip,
-		 al.map ? al.map->map_ip(al.map, ip) : (u64) 0);
+		 al.map ? map_sh(al.map)->map_ip(al.map, ip) : (u64) 0);
 
 	return cb(&e, arg);
 }
diff --git a/tools/perf/util/unwind-libunwind.c b/tools/perf/util/unwind-libunwind.c
index a24fb57c9b2c..d7b90bc99188 100644
--- a/tools/perf/util/unwind-libunwind.c
+++ b/tools/perf/util/unwind-libunwind.c
@@ -31,7 +31,7 @@ int unwind__prepare_access(struct map_groups *mg, struct map *map,
 
 	if (mg->addr_space) {
 		pr_debug("unwind: thread map already set, dso=%s\n",
-			 map->dso->name);
+			 map_sh(map)->dso->name);
 		if (initialized)
 			*initialized = true;
 		return 0;
@@ -41,7 +41,7 @@ int unwind__prepare_access(struct map_groups *mg, struct map *map,
 	if (!mg->machine->env || !mg->machine->env->arch)
 		goto out_register;
 
-	dso_type = dso__type(map->dso, mg->machine);
+	dso_type = dso__type(map_sh(map)->dso, mg->machine);
 	if (dso_type == DSO__TYPE_UNKNOWN)
 		return 0;
 
diff --git a/tools/perf/util/vdso.c b/tools/perf/util/vdso.c
index ba4b4395f35d..fb5c053d4da3 100644
--- a/tools/perf/util/vdso.c
+++ b/tools/perf/util/vdso.c
@@ -145,7 +145,7 @@ static enum dso_type machine__thread_dso_type(struct machine *machine,
 	struct map *map = map_groups__first(thread->mg);
 
 	for (; map ; map = map_groups__next(map)) {
-		struct dso *dso = map->dso;
+		struct dso *dso = map_sh(map)->dso;
 		if (!dso || dso->long_name[0] != '/')
 			continue;
 		dso_type = dso__type(dso, machine);
-- 
2.21.0

