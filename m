Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E31CA9EBD
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 06:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E7021928
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 06:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfJ0Grv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 02:47:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40936 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfJ0Grs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 02:47:48 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iOcL2-0002pY-Lw; Sun, 27 Oct 2019 07:47:44 +0100
Date:   Sun, 27 Oct 2019 06:46:26 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] perf/urgent for 5.4-rc5
References: <157215878694.13117.16411564430107054752.tglx@nanos.tec.linutronix.de>
Message-ID: <157215878694.13117.7140122778575612824.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

up to:  f3a519e4add9: perf/aux: Fix AUX output stopping

A set of perf fixes:

 kernel:
  - Unbreak the tracking of auxiliary buffer allocations which got
    imbalanced causing recource limit failures.

  - Fix the fallout of splitting of ToPA entries which missed to shift
    the base entry PA correctly.

  - Use the correct context to lookup the AUX event when unmapping the
    associated AUX buffer so the event can be stopped and the buffer
    reference dropped.

 tools:

  - Fix buildiid-cache mode setting in copyfile_mode_ns() when copying
    /proc/kcore

  - Fix freeing id arrays in the event list so the correct event is closed.
    
  - Sync sched.h anc kvm.h headers with the kernel sources.
    
  - Link jvmti against tools/lib/ctype.o to have weak strlcpy().
    
  - Fix multiple memory and file descriptor leaks, found by coverity in
    perf annotate.
    
  - Fix leaks in error handling paths in 'perf c2c', 'perf kmem', found by
    a static analysis tool.

Thanks,

	tglx

------------------>
Adrian Hunter (1):
      perf tools: Fix mode setting in copyfile_mode_ns()

Alexander Shishkin (1):
      perf/aux: Fix AUX output stopping

Andi Kleen (1):
      perf evlist: Fix fix for freed id arrays

Arnaldo Carvalho de Melo (4):
      tools headers kvm: Sync kvm headers with the kernel sources
      tools headers kvm: Sync kvm headers with the kernel sources
      tools headers kvm: Sync kvm.h headers with the kernel sources
      tools headers UAPI: Sync sched.h with the kernel

Gustavo A. R. Silva (1):
      perf annotate: Fix multiple memory and file descriptor leaks

Jiri Olsa (1):
      perf/x86/intel/pt: Fix base for single entry topa

Thomas Richter (2):
      perf jvmti: Link against tools/lib/ctype.h to have weak strlcpy()
      perf/aux: Fix tracking of auxiliary trace buffer allocation

Yunfeng Ye (3):
      perf tools: Fix resource leak of closedir() on the error paths
      perf c2c: Fix memory leak in build_cl_output()
      perf kmem: Fix memory leak in compact_gfp_flags()


 arch/x86/events/intel/pt.c            |  2 +-
 kernel/events/core.c                  |  8 +++++---
 tools/arch/x86/include/uapi/asm/svm.h |  1 +
 tools/arch/x86/include/uapi/asm/vmx.h |  6 +++++-
 tools/include/uapi/linux/kvm.h        |  2 ++
 tools/include/uapi/linux/sched.h      | 30 ++++++++++++++++++++++++++++--
 tools/perf/builtin-c2c.c              | 14 +++++++++-----
 tools/perf/builtin-kmem.c             |  1 +
 tools/perf/jvmti/Build                |  6 +++++-
 tools/perf/util/annotate.c            |  2 +-
 tools/perf/util/copyfile.c            |  8 +++++---
 tools/perf/util/evlist.c              |  2 +-
 tools/perf/util/header.c              |  4 +++-
 tools/perf/util/util.c                |  6 ++++--
 14 files changed, 71 insertions(+), 21 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 74e80ed9c6c4..05e43d0f430b 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -627,7 +627,7 @@ static struct topa *topa_alloc(int cpu, gfp_t gfp)
 	 * link as the 2nd entry in the table
 	 */
 	if (!intel_pt_validate_hw_cap(PT_CAP_topa_multiple_entries)) {
-		TOPA_ENTRY(&tp->topa, 1)->base = page_to_phys(p);
+		TOPA_ENTRY(&tp->topa, 1)->base = page_to_phys(p) >> TOPA_SHIFT;
 		TOPA_ENTRY(&tp->topa, 1)->end = 1;
 	}
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 9ec0b0bfddbd..bb3748d29b04 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5607,8 +5607,10 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 		perf_pmu_output_stop(event);
 
 		/* now it's safe to free the pages */
-		atomic_long_sub(rb->aux_nr_pages, &mmap_user->locked_vm);
-		atomic64_sub(rb->aux_mmap_locked, &vma->vm_mm->pinned_vm);
+		if (!rb->aux_mmap_locked)
+			atomic_long_sub(rb->aux_nr_pages, &mmap_user->locked_vm);
+		else
+			atomic64_sub(rb->aux_mmap_locked, &vma->vm_mm->pinned_vm);
 
 		/* this has to be the last one */
 		rb_free_aux(rb);
@@ -6947,7 +6949,7 @@ static void __perf_event_output_stop(struct perf_event *event, void *data)
 static int __perf_pmu_output_stop(void *info)
 {
 	struct perf_event *event = info;
-	struct pmu *pmu = event->pmu;
+	struct pmu *pmu = event->ctx->pmu;
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);
 	struct remote_output ro = {
 		.rb	= event->rb,
diff --git a/tools/arch/x86/include/uapi/asm/svm.h b/tools/arch/x86/include/uapi/asm/svm.h
index a9731f8a480f..2e8a30f06c74 100644
--- a/tools/arch/x86/include/uapi/asm/svm.h
+++ b/tools/arch/x86/include/uapi/asm/svm.h
@@ -75,6 +75,7 @@
 #define SVM_EXIT_MWAIT         0x08b
 #define SVM_EXIT_MWAIT_COND    0x08c
 #define SVM_EXIT_XSETBV        0x08d
+#define SVM_EXIT_RDPRU         0x08e
 #define SVM_EXIT_NPF           0x400
 #define SVM_EXIT_AVIC_INCOMPLETE_IPI		0x401
 #define SVM_EXIT_AVIC_UNACCELERATED_ACCESS	0x402
diff --git a/tools/arch/x86/include/uapi/asm/vmx.h b/tools/arch/x86/include/uapi/asm/vmx.h
index f01950aa7fae..3eb8411ab60e 100644
--- a/tools/arch/x86/include/uapi/asm/vmx.h
+++ b/tools/arch/x86/include/uapi/asm/vmx.h
@@ -86,6 +86,8 @@
 #define EXIT_REASON_PML_FULL            62
 #define EXIT_REASON_XSAVES              63
 #define EXIT_REASON_XRSTORS             64
+#define EXIT_REASON_UMWAIT              67
+#define EXIT_REASON_TPAUSE              68
 
 #define VMX_EXIT_REASONS \
 	{ EXIT_REASON_EXCEPTION_NMI,         "EXCEPTION_NMI" }, \
@@ -144,7 +146,9 @@
 	{ EXIT_REASON_RDSEED,                "RDSEED" }, \
 	{ EXIT_REASON_PML_FULL,              "PML_FULL" }, \
 	{ EXIT_REASON_XSAVES,                "XSAVES" }, \
-	{ EXIT_REASON_XRSTORS,               "XRSTORS" }
+	{ EXIT_REASON_XRSTORS,               "XRSTORS" }, \
+	{ EXIT_REASON_UMWAIT,                "UMWAIT" }, \
+	{ EXIT_REASON_TPAUSE,                "TPAUSE" }
 
 #define VMX_ABORT_SAVE_GUEST_MSR_FAIL        1
 #define VMX_ABORT_LOAD_HOST_PDPTE_FAIL       2
diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 233efbb1c81c..52641d8ca9e8 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -999,6 +999,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_ARM_PTRAUTH_GENERIC 172
 #define KVM_CAP_PMU_EVENT_FILTER 173
 #define KVM_CAP_ARM_IRQ_LINE_LAYOUT_2 174
+#define KVM_CAP_HYPERV_DIRECT_TLBFLUSH 175
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1145,6 +1146,7 @@ struct kvm_dirty_tlb {
 #define KVM_REG_S390		0x5000000000000000ULL
 #define KVM_REG_ARM64		0x6000000000000000ULL
 #define KVM_REG_MIPS		0x7000000000000000ULL
+#define KVM_REG_RISCV		0x8000000000000000ULL
 
 #define KVM_REG_SIZE_SHIFT	52
 #define KVM_REG_SIZE_MASK	0x00f0000000000000ULL
diff --git a/tools/include/uapi/linux/sched.h b/tools/include/uapi/linux/sched.h
index b3105ac1381a..99335e1f4a27 100644
--- a/tools/include/uapi/linux/sched.h
+++ b/tools/include/uapi/linux/sched.h
@@ -33,8 +33,31 @@
 #define CLONE_NEWNET		0x40000000	/* New network namespace */
 #define CLONE_IO		0x80000000	/* Clone io context */
 
-/*
- * Arguments for the clone3 syscall
+#ifndef __ASSEMBLY__
+/**
+ * struct clone_args - arguments for the clone3 syscall
+ * @flags:       Flags for the new process as listed above.
+ *               All flags are valid except for CSIGNAL and
+ *               CLONE_DETACHED.
+ * @pidfd:       If CLONE_PIDFD is set, a pidfd will be
+ *               returned in this argument.
+ * @child_tid:   If CLONE_CHILD_SETTID is set, the TID of the
+ *               child process will be returned in the child's
+ *               memory.
+ * @parent_tid:  If CLONE_PARENT_SETTID is set, the TID of
+ *               the child process will be returned in the
+ *               parent's memory.
+ * @exit_signal: The exit_signal the parent process will be
+ *               sent when the child exits.
+ * @stack:       Specify the location of the stack for the
+ *               child process.
+ * @stack_size:  The size of the stack for the child process.
+ * @tls:         If CLONE_SETTLS is set, the tls descriptor
+ *               is set to tls.
+ *
+ * The structure is versioned by size and thus extensible.
+ * New struct members must go at the end of the struct and
+ * must be properly 64bit aligned.
  */
 struct clone_args {
 	__aligned_u64 flags;
@@ -46,6 +69,9 @@ struct clone_args {
 	__aligned_u64 stack_size;
 	__aligned_u64 tls;
 };
+#endif
+
+#define CLONE_ARGS_SIZE_VER0 64 /* sizeof first published struct */
 
 /*
  * Scheduling policies
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 3542b6ab9813..e69f44941aad 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2635,6 +2635,7 @@ static int build_cl_output(char *cl_sort, bool no_source)
 	bool add_sym   = false;
 	bool add_dso   = false;
 	bool add_src   = false;
+	int ret = 0;
 
 	if (!buf)
 		return -ENOMEM;
@@ -2653,7 +2654,8 @@ static int build_cl_output(char *cl_sort, bool no_source)
 			add_dso = true;
 		} else if (strcmp(tok, "offset")) {
 			pr_err("unrecognized sort token: %s\n", tok);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err;
 		}
 	}
 
@@ -2676,13 +2678,15 @@ static int build_cl_output(char *cl_sort, bool no_source)
 		add_sym ? "symbol," : "",
 		add_dso ? "dso," : "",
 		add_src ? "cl_srcline," : "",
-		"node") < 0)
-		return -ENOMEM;
+		"node") < 0) {
+		ret = -ENOMEM;
+		goto err;
+	}
 
 	c2c.show_src = add_src;
-
+err:
 	free(buf);
-	return 0;
+	return ret;
 }
 
 static int setup_coalesce(const char *coalesce, bool no_source)
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 1e61e353f579..9661671cc26e 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -691,6 +691,7 @@ static char *compact_gfp_flags(char *gfp_flags)
 			new = realloc(new_flags, len + strlen(cpt) + 2);
 			if (new == NULL) {
 				free(new_flags);
+				free(orig_flags);
 				return NULL;
 			}
 
diff --git a/tools/perf/jvmti/Build b/tools/perf/jvmti/Build
index 1e148bbdf820..202cadaaf097 100644
--- a/tools/perf/jvmti/Build
+++ b/tools/perf/jvmti/Build
@@ -2,7 +2,7 @@ jvmti-y += libjvmti.o
 jvmti-y += jvmti_agent.o
 
 # For strlcpy
-jvmti-y += libstring.o
+jvmti-y += libstring.o libctype.o
 
 CFLAGS_jvmti         = -fPIC -DPIC -I$(JDIR)/include -I$(JDIR)/include/linux
 CFLAGS_REMOVE_jvmti  = -Wmissing-declarations
@@ -15,3 +15,7 @@ CFLAGS_libstring.o += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ETC_PE
 $(OUTPUT)jvmti/libstring.o: ../lib/string.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
+
+$(OUTPUT)jvmti/libctype.o: ../lib/ctype.c FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 4036c7f7b0fb..e42bf572358c 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1758,7 +1758,7 @@ static int symbol__disassemble_bpf(struct symbol *sym,
 	info_node = perf_env__find_bpf_prog_info(dso->bpf_prog.env,
 						 dso->bpf_prog.id);
 	if (!info_node) {
-		return SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
+		ret = SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
 		goto out;
 	}
 	info_linear = info_node->info_linear;
diff --git a/tools/perf/util/copyfile.c b/tools/perf/util/copyfile.c
index 3fa0db136667..47e03de7c235 100644
--- a/tools/perf/util/copyfile.c
+++ b/tools/perf/util/copyfile.c
@@ -101,14 +101,16 @@ static int copyfile_mode_ns(const char *from, const char *to, mode_t mode,
 	if (tofd < 0)
 		goto out;
 
-	if (fchmod(tofd, mode))
-		goto out_close_to;
-
 	if (st.st_size == 0) { /* /proc? do it slowly... */
 		err = slow_copyfile(from, tmp, nsi);
+		if (!err && fchmod(tofd, mode))
+			err = -1;
 		goto out_close_to;
 	}
 
+	if (fchmod(tofd, mode))
+		goto out_close_to;
+
 	nsinfo__mountns_enter(nsi, &nsc);
 	fromfd = open(from, O_RDONLY);
 	nsinfo__mountns_exit(&nsc);
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index d277a98e62df..de79c735e441 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1659,7 +1659,7 @@ struct evsel *perf_evlist__reset_weak_group(struct evlist *evsel_list,
 			is_open = false;
 		if (c2->leader == leader) {
 			if (is_open)
-				perf_evsel__close(&evsel->core);
+				perf_evsel__close(&c2->core);
 			c2->leader = c2;
 			c2->core.nr_members = 0;
 		}
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 86d9396cb131..becc2d109423 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1296,8 +1296,10 @@ static int build_mem_topology(struct memory_node *nodes, u64 size, u64 *cntp)
 			continue;
 
 		if (WARN_ONCE(cnt >= size,
-			      "failed to write MEM_TOPOLOGY, way too many nodes\n"))
+			"failed to write MEM_TOPOLOGY, way too many nodes\n")) {
+			closedir(dir);
 			return -1;
+		}
 
 		ret = memory_node__read(&nodes[cnt++], idx);
 	}
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 5eda6e19c947..ae56c766eda1 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -154,8 +154,10 @@ static int rm_rf_depth_pat(const char *path, int depth, const char **pat)
 		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
 			continue;
 
-		if (!match_pat(d->d_name, pat))
-			return -2;
+		if (!match_pat(d->d_name, pat)) {
+			ret =  -2;
+			break;
+		}
 
 		scnprintf(namebuf, sizeof(namebuf), "%s/%s",
 			  path, d->d_name);


