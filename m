Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8CBC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 10:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D162070B
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 10:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731155AbfCaKm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 06:42:26 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57215 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfCaKmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 06:42:24 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hAXut-0005Y0-UI; Sun, 31 Mar 2019 12:42:20 +0200
Date:   Sun, 31 Mar 2019 10:39:43 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] perf updates for 5.1
References: <155402878327.25983.10899882979692424898.tglx@nanos.tec.linutronix.de>
Message-ID: <155402878327.25983.14339659161296384728.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

up to:  22261fdf68f2 ("Merge tag 'perf-urgent-for-mingo-5.1-20190329' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent")

Perf tooling related fixes:

   Core libraries:
      - Fix max perf_event_attr.precise_ip detection.
      - Fix parser error for uncore event alias
      - Fixup ordering of kernel maps after obtaining the main kernel map address.
    
   Intel PT:
      - Fix TSC slip where A TSC packet can slip past MTC packets so that the
        timestamp appears to go backwards.
      - Fixes for exported-sql-viewer GUI conversion to python3.
    
   ARM coresight:
      - Fix the build by adding a missing case value for enumeration value introduced
        in newer library, that now is the required one.
    
   tool headers:
      - Syncronize kernel headers with the kernel, getting new io_uring and
        pidfd_send_signal syscalls so that 'perf trace' can handle them.


Thanks,

	tglx

------------------>
Adrian Hunter (3):
      perf intel-pt: Fix TSC slip
      perf scripts python: exported-sql-viewer.py: Fix never-ending loop
      perf scripts python: exported-sql-viewer.py: Fix python3 support

Arnaldo Carvalho de Melo (6):
      tools headers uapi: Sync asm-generic/mman-common.h and linux/mman.h
      tools headers uapi: Sync linux/fcntl.h to get the F_SEAL_FUTURE_WRITE addition
      tools arch x86: Sync asm/cpufeatures.h with the kernel sources
      tools headers uapi: Update drm/i915_drm.h
      tools headers: Update x86's syscall_64.tbl and uapi/asm-generic/unistd
      tools headers uapi: Sync powerpc's asm/kvm.h copy with the kernel sources

Jiri Olsa (1):
      perf evsel: Fix max perf_event_attr.precise_ip detection

Kan Liang (1):
      perf pmu: Fix parser error for uncore event alias

Solomon Tan (1):
      perf cs-etm: Add missing case value

Wei Li (1):
      perf machine: Update kernel map address and re-order properly


 tools/arch/alpha/include/uapi/asm/mman.h           |  2 -
 tools/arch/mips/include/uapi/asm/mman.h            |  2 -
 tools/arch/parisc/include/uapi/asm/mman.h          |  2 -
 tools/arch/powerpc/include/uapi/asm/kvm.h          |  2 +
 tools/arch/x86/include/asm/cpufeatures.h           |  1 +
 tools/arch/xtensa/include/uapi/asm/mman.h          |  2 -
 tools/build/feature/test-libopencsd.c              |  4 +-
 tools/include/uapi/asm-generic/mman-common-tools.h | 23 +++++++
 tools/include/uapi/asm-generic/mman-common.h       |  4 +-
 tools/include/uapi/asm-generic/mman.h              |  2 +-
 tools/include/uapi/asm-generic/unistd.h            | 11 +++-
 tools/include/uapi/drm/i915_drm.h                  | 64 ++++++++++++++++++
 tools/include/uapi/linux/fcntl.h                   |  1 +
 tools/include/uapi/linux/mman.h                    |  4 ++
 tools/perf/Makefile.perf                           |  4 +-
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |  4 ++
 tools/perf/check-headers.sh                        |  2 +-
 tools/perf/scripts/python/exported-sql-viewer.py   | 77 ++++++++++++++++++----
 tools/perf/trace/beauty/mmap_flags.sh              | 14 +++-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |  1 +
 tools/perf/util/evlist.c                           | 29 --------
 tools/perf/util/evlist.h                           |  2 -
 tools/perf/util/evsel.c                            | 72 ++++++++++++++++----
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  | 20 +++---
 tools/perf/util/machine.c                          | 32 +++++----
 tools/perf/util/pmu.c                              | 10 +++
 26 files changed, 288 insertions(+), 103 deletions(-)
 create mode 100644 tools/include/uapi/asm-generic/mman-common-tools.h

diff --git a/tools/arch/alpha/include/uapi/asm/mman.h b/tools/arch/alpha/include/uapi/asm/mman.h
index c317d3e6867a..ea6a255ae61f 100644
--- a/tools/arch/alpha/include/uapi/asm/mman.h
+++ b/tools/arch/alpha/include/uapi/asm/mman.h
@@ -27,8 +27,6 @@
 #define MAP_NONBLOCK	0x40000
 #define MAP_NORESERVE	0x10000
 #define MAP_POPULATE	0x20000
-#define MAP_PRIVATE	0x02
-#define MAP_SHARED	0x01
 #define MAP_STACK	0x80000
 #define PROT_EXEC	0x4
 #define PROT_GROWSDOWN	0x01000000
diff --git a/tools/arch/mips/include/uapi/asm/mman.h b/tools/arch/mips/include/uapi/asm/mman.h
index de2206883abc..c8acaa138d46 100644
--- a/tools/arch/mips/include/uapi/asm/mman.h
+++ b/tools/arch/mips/include/uapi/asm/mman.h
@@ -28,8 +28,6 @@
 #define MAP_NONBLOCK	0x20000
 #define MAP_NORESERVE	0x0400
 #define MAP_POPULATE	0x10000
-#define MAP_PRIVATE	0x002
-#define MAP_SHARED	0x001
 #define MAP_STACK	0x40000
 #define PROT_EXEC	0x04
 #define PROT_GROWSDOWN	0x01000000
diff --git a/tools/arch/parisc/include/uapi/asm/mman.h b/tools/arch/parisc/include/uapi/asm/mman.h
index 1bd78758bde9..f9fd1325f5bd 100644
--- a/tools/arch/parisc/include/uapi/asm/mman.h
+++ b/tools/arch/parisc/include/uapi/asm/mman.h
@@ -27,8 +27,6 @@
 #define MAP_NONBLOCK	0x20000
 #define MAP_NORESERVE	0x4000
 #define MAP_POPULATE	0x10000
-#define MAP_PRIVATE	0x02
-#define MAP_SHARED	0x01
 #define MAP_STACK	0x40000
 #define PROT_EXEC	0x4
 #define PROT_GROWSDOWN	0x01000000
diff --git a/tools/arch/powerpc/include/uapi/asm/kvm.h b/tools/arch/powerpc/include/uapi/asm/kvm.h
index 8c876c166ef2..26ca425f4c2c 100644
--- a/tools/arch/powerpc/include/uapi/asm/kvm.h
+++ b/tools/arch/powerpc/include/uapi/asm/kvm.h
@@ -463,10 +463,12 @@ struct kvm_ppc_cpu_char {
 #define KVM_PPC_CPU_CHAR_BR_HINT_HONOURED	(1ULL << 58)
 #define KVM_PPC_CPU_CHAR_MTTRIG_THR_RECONF	(1ULL << 57)
 #define KVM_PPC_CPU_CHAR_COUNT_CACHE_DIS	(1ULL << 56)
+#define KVM_PPC_CPU_CHAR_BCCTR_FLUSH_ASSIST	(1ull << 54)
 
 #define KVM_PPC_CPU_BEHAV_FAVOUR_SECURITY	(1ULL << 63)
 #define KVM_PPC_CPU_BEHAV_L1D_FLUSH_PR		(1ULL << 62)
 #define KVM_PPC_CPU_BEHAV_BNDS_CHK_SPEC_BAR	(1ULL << 61)
+#define KVM_PPC_CPU_BEHAV_FLUSH_COUNT_CACHE	(1ull << 58)
 
 /* Per-vcpu XICS interrupt controller state */
 #define KVM_REG_PPC_ICP_STATE	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0x8c)
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 6d6122524711..981ff9479648 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -344,6 +344,7 @@
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EDX), word 18 */
 #define X86_FEATURE_AVX512_4VNNIW	(18*32+ 2) /* AVX-512 Neural Network Instructions */
 #define X86_FEATURE_AVX512_4FMAPS	(18*32+ 3) /* AVX-512 Multiply Accumulation Single precision */
+#define X86_FEATURE_TSX_FORCE_ABORT	(18*32+13) /* "" TSX_FORCE_ABORT */
 #define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
 #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
 #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
diff --git a/tools/arch/xtensa/include/uapi/asm/mman.h b/tools/arch/xtensa/include/uapi/asm/mman.h
index 34dde6f44dae..f2b08c990afc 100644
--- a/tools/arch/xtensa/include/uapi/asm/mman.h
+++ b/tools/arch/xtensa/include/uapi/asm/mman.h
@@ -27,8 +27,6 @@
 #define MAP_NONBLOCK	0x20000
 #define MAP_NORESERVE	0x0400
 #define MAP_POPULATE	0x10000
-#define MAP_PRIVATE	0x002
-#define MAP_SHARED	0x001
 #define MAP_STACK	0x40000
 #define PROT_EXEC	0x4
 #define PROT_GROWSDOWN	0x01000000
diff --git a/tools/build/feature/test-libopencsd.c b/tools/build/feature/test-libopencsd.c
index d68eb4fb40cc..2b0e02c38870 100644
--- a/tools/build/feature/test-libopencsd.c
+++ b/tools/build/feature/test-libopencsd.c
@@ -4,9 +4,9 @@
 /*
  * Check OpenCSD library version is sufficient to provide required features
  */
-#define OCSD_MIN_VER ((0 << 16) | (10 << 8) | (0))
+#define OCSD_MIN_VER ((0 << 16) | (11 << 8) | (0))
 #if !defined(OCSD_VER_NUM) || (OCSD_VER_NUM < OCSD_MIN_VER)
-#error "OpenCSD >= 0.10.0 is required"
+#error "OpenCSD >= 0.11.0 is required"
 #endif
 
 int main(void)
diff --git a/tools/include/uapi/asm-generic/mman-common-tools.h b/tools/include/uapi/asm-generic/mman-common-tools.h
new file mode 100644
index 000000000000..af7d0d3a3182
--- /dev/null
+++ b/tools/include/uapi/asm-generic/mman-common-tools.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __ASM_GENERIC_MMAN_COMMON_TOOLS_ONLY_H
+#define __ASM_GENERIC_MMAN_COMMON_TOOLS_ONLY_H
+
+#include <asm-generic/mman-common.h>
+
+/* We need this because we need to have tools/include/uapi/ included in the tools
+ * header search path to get access to stuff that is not yet in the system's
+ * copy of the files in that directory, but since this cset:
+ *
+ *     746c9398f5ac ("arch: move common mmap flags to linux/mman.h")
+ *
+ * We end up making sys/mman.h, that is in the system headers, to not find the
+ * MAP_SHARED and MAP_PRIVATE defines because they are not anymore in our copy
+ * of asm-generic/mman-common.h. So we define them here and include this header
+ * from each of the per arch mman.h headers.
+ */
+#ifndef MAP_SHARED
+#define MAP_SHARED	0x01		/* Share changes */
+#define MAP_PRIVATE	0x02		/* Changes are private */
+#define MAP_SHARED_VALIDATE 0x03	/* share + validate extension flags */
+#endif
+#endif // __ASM_GENERIC_MMAN_COMMON_TOOLS_ONLY_H
diff --git a/tools/include/uapi/asm-generic/mman-common.h b/tools/include/uapi/asm-generic/mman-common.h
index e7ee32861d51..abd238d0f7a4 100644
--- a/tools/include/uapi/asm-generic/mman-common.h
+++ b/tools/include/uapi/asm-generic/mman-common.h
@@ -15,9 +15,7 @@
 #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
 #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
 
-#define MAP_SHARED	0x01		/* Share changes */
-#define MAP_PRIVATE	0x02		/* Changes are private */
-#define MAP_SHARED_VALIDATE 0x03	/* share + validate extension flags */
+/* 0x01 - 0x03 are defined in linux/mman.h */
 #define MAP_TYPE	0x0f		/* Mask for type of mapping */
 #define MAP_FIXED	0x10		/* Interpret addr exactly */
 #define MAP_ANONYMOUS	0x20		/* don't use a file */
diff --git a/tools/include/uapi/asm-generic/mman.h b/tools/include/uapi/asm-generic/mman.h
index 653687d9771b..36c197fc44a0 100644
--- a/tools/include/uapi/asm-generic/mman.h
+++ b/tools/include/uapi/asm-generic/mman.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_GENERIC_MMAN_H
 #define __ASM_GENERIC_MMAN_H
 
-#include <asm-generic/mman-common.h>
+#include <asm-generic/mman-common-tools.h>
 
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index 12cdf611d217..dee7292e1df6 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -824,8 +824,17 @@ __SYSCALL(__NR_futex_time64, sys_futex)
 __SYSCALL(__NR_sched_rr_get_interval_time64, sys_sched_rr_get_interval)
 #endif
 
+#define __NR_pidfd_send_signal 424
+__SYSCALL(__NR_pidfd_send_signal, sys_pidfd_send_signal)
+#define __NR_io_uring_setup 425
+__SYSCALL(__NR_io_uring_setup, sys_io_uring_setup)
+#define __NR_io_uring_enter 426
+__SYSCALL(__NR_io_uring_enter, sys_io_uring_enter)
+#define __NR_io_uring_register 427
+__SYSCALL(__NR_io_uring_register, sys_io_uring_register)
+
 #undef __NR_syscalls
-#define __NR_syscalls 424
+#define __NR_syscalls 428
 
 /*
  * 32 bit systems traditionally used different
diff --git a/tools/include/uapi/drm/i915_drm.h b/tools/include/uapi/drm/i915_drm.h
index 298b2e197744..397810fa2d33 100644
--- a/tools/include/uapi/drm/i915_drm.h
+++ b/tools/include/uapi/drm/i915_drm.h
@@ -1486,9 +1486,73 @@ struct drm_i915_gem_context_param {
 #define   I915_CONTEXT_MAX_USER_PRIORITY	1023 /* inclusive */
 #define   I915_CONTEXT_DEFAULT_PRIORITY		0
 #define   I915_CONTEXT_MIN_USER_PRIORITY	-1023 /* inclusive */
+	/*
+	 * When using the following param, value should be a pointer to
+	 * drm_i915_gem_context_param_sseu.
+	 */
+#define I915_CONTEXT_PARAM_SSEU		0x7
 	__u64 value;
 };
 
+/**
+ * Context SSEU programming
+ *
+ * It may be necessary for either functional or performance reason to configure
+ * a context to run with a reduced number of SSEU (where SSEU stands for Slice/
+ * Sub-slice/EU).
+ *
+ * This is done by configuring SSEU configuration using the below
+ * @struct drm_i915_gem_context_param_sseu for every supported engine which
+ * userspace intends to use.
+ *
+ * Not all GPUs or engines support this functionality in which case an error
+ * code -ENODEV will be returned.
+ *
+ * Also, flexibility of possible SSEU configuration permutations varies between
+ * GPU generations and software imposed limitations. Requesting such a
+ * combination will return an error code of -EINVAL.
+ *
+ * NOTE: When perf/OA is active the context's SSEU configuration is ignored in
+ * favour of a single global setting.
+ */
+struct drm_i915_gem_context_param_sseu {
+	/*
+	 * Engine class & instance to be configured or queried.
+	 */
+	__u16 engine_class;
+	__u16 engine_instance;
+
+	/*
+	 * Unused for now. Must be cleared to zero.
+	 */
+	__u32 flags;
+
+	/*
+	 * Mask of slices to enable for the context. Valid values are a subset
+	 * of the bitmask value returned for I915_PARAM_SLICE_MASK.
+	 */
+	__u64 slice_mask;
+
+	/*
+	 * Mask of subslices to enable for the context. Valid values are a
+	 * subset of the bitmask value return by I915_PARAM_SUBSLICE_MASK.
+	 */
+	__u64 subslice_mask;
+
+	/*
+	 * Minimum/Maximum number of EUs to enable per subslice for the
+	 * context. min_eus_per_subslice must be inferior or equal to
+	 * max_eus_per_subslice.
+	 */
+	__u16 min_eus_per_subslice;
+	__u16 max_eus_per_subslice;
+
+	/*
+	 * Unused for now. Must be cleared to zero.
+	 */
+	__u32 rsvd;
+};
+
 enum drm_i915_oa_format {
 	I915_OA_FORMAT_A13 = 1,	    /* HSW only */
 	I915_OA_FORMAT_A29,	    /* HSW only */
diff --git a/tools/include/uapi/linux/fcntl.h b/tools/include/uapi/linux/fcntl.h
index 6448cdd9a350..a2f8658f1c55 100644
--- a/tools/include/uapi/linux/fcntl.h
+++ b/tools/include/uapi/linux/fcntl.h
@@ -41,6 +41,7 @@
 #define F_SEAL_SHRINK	0x0002	/* prevent file from shrinking */
 #define F_SEAL_GROW	0x0004	/* prevent file from growing */
 #define F_SEAL_WRITE	0x0008	/* prevent writes */
+#define F_SEAL_FUTURE_WRITE	0x0010  /* prevent future writes while mapped */
 /* (1U << 31) is reserved for signed error codes */
 
 /*
diff --git a/tools/include/uapi/linux/mman.h b/tools/include/uapi/linux/mman.h
index d0f515d53299..fc1a64c3447b 100644
--- a/tools/include/uapi/linux/mman.h
+++ b/tools/include/uapi/linux/mman.h
@@ -12,6 +12,10 @@
 #define OVERCOMMIT_ALWAYS		1
 #define OVERCOMMIT_NEVER		2
 
+#define MAP_SHARED	0x01		/* Share changes */
+#define MAP_PRIVATE	0x02		/* Changes are private */
+#define MAP_SHARED_VALIDATE 0x03	/* share + validate extension flags */
+
 /*
  * Huge page size encoding when MAP_HUGETLB is specified, and a huge page
  * size other than the default is desired.  See hugetlb_encode.h.
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 01f7555fd933..e8c9f77e9010 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -481,8 +481,8 @@ $(madvise_behavior_array): $(madvise_hdr_dir)/mman-common.h $(madvise_behavior_t
 mmap_flags_array := $(beauty_outdir)/mmap_flags_array.c
 mmap_flags_tbl := $(srctree)/tools/perf/trace/beauty/mmap_flags.sh
 
-$(mmap_flags_array): $(asm_generic_uapi_dir)/mman.h $(asm_generic_uapi_dir)/mman-common.h $(mmap_flags_tbl)
-	$(Q)$(SHELL) '$(mmap_flags_tbl)' $(asm_generic_uapi_dir) $(arch_asm_uapi_dir) > $@
+$(mmap_flags_array): $(linux_uapi_dir)/mman.h $(asm_generic_uapi_dir)/mman.h $(asm_generic_uapi_dir)/mman-common.h $(mmap_flags_tbl)
+	$(Q)$(SHELL) '$(mmap_flags_tbl)' $(linux_uapi_dir) $(asm_generic_uapi_dir) $(arch_asm_uapi_dir) > $@
 
 mount_flags_array := $(beauty_outdir)/mount_flags_array.c
 mount_flags_tbl := $(srctree)/tools/perf/trace/beauty/mount_flags.sh
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index 2ae92fddb6d5..92ee0b4378d4 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -345,6 +345,10 @@
 334	common	rseq			__x64_sys_rseq
 # don't use numbers 387 through 423, add new calls after the last
 # 'common' entry
+424	common	pidfd_send_signal	__x64_sys_pidfd_send_signal
+425	common	io_uring_setup		__x64_sys_io_uring_setup
+426	common	io_uring_enter		__x64_sys_io_uring_enter
+427	common	io_uring_register	__x64_sys_io_uring_register
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 7b55613924de..c68ee06cae63 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -103,7 +103,7 @@ done
 # diff with extra ignore lines
 check arch/x86/lib/memcpy_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>"'
 check arch/x86/lib/memset_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>"'
-check include/uapi/asm-generic/mman.h '-I "^#include <\(uapi/\)*asm-generic/mman-common.h>"'
+check include/uapi/asm-generic/mman.h '-I "^#include <\(uapi/\)*asm-generic/mman-common\(-tools\)*.h>"'
 check include/uapi/linux/mman.h       '-I "^#include <\(uapi/\)*asm/mman.h>"'
 
 # diff non-symmetric files
diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index e38518cdcbc3..74ef92f1d19a 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -107,6 +107,7 @@ import os
 from PySide.QtCore import *
 from PySide.QtGui import *
 from PySide.QtSql import *
+pyside_version_1 = True
 from decimal import *
 from ctypes import *
 from multiprocessing import Process, Array, Value, Event
@@ -1526,6 +1527,19 @@ def BranchDataPrep(query):
 			" (" + dsoname(query.value(15)) + ")")
 	return data
 
+def BranchDataPrepWA(query):
+	data = []
+	data.append(query.value(0))
+	# Workaround pyside failing to handle large integers (i.e. time) in python3 by converting to a string
+	data.append("{:>19}".format(query.value(1)))
+	for i in xrange(2, 8):
+		data.append(query.value(i))
+	data.append(tohex(query.value(8)).rjust(16) + " " + query.value(9) + offstr(query.value(10)) +
+			" (" + dsoname(query.value(11)) + ")" + " -> " +
+			tohex(query.value(12)) + " " + query.value(13) + offstr(query.value(14)) +
+			" (" + dsoname(query.value(15)) + ")")
+	return data
+
 # Branch data model
 
 class BranchModel(TreeModel):
@@ -1553,7 +1567,11 @@ class BranchModel(TreeModel):
 			" AND evsel_id = " + str(self.event_id) +
 			" ORDER BY samples.id"
 			" LIMIT " + str(glb_chunk_sz))
-		self.fetcher = SQLFetcher(glb, sql, BranchDataPrep, self.AddSample)
+		if pyside_version_1 and sys.version_info[0] == 3:
+			prep = BranchDataPrepWA
+		else:
+			prep = BranchDataPrep
+		self.fetcher = SQLFetcher(glb, sql, prep, self.AddSample)
 		self.fetcher.done.connect(self.Update)
 		self.fetcher.Fetch(glb_chunk_sz)
 
@@ -2079,14 +2097,6 @@ def IsSelectable(db, table, sql = ""):
 		return False
 	return True
 
-# SQL data preparation
-
-def SQLTableDataPrep(query, count):
-	data = []
-	for i in xrange(count):
-		data.append(query.value(i))
-	return data
-
 # SQL table data model item
 
 class SQLTableItem():
@@ -2110,7 +2120,7 @@ class SQLTableModel(TableModel):
 		self.more = True
 		self.populated = 0
 		self.column_headers = column_headers
-		self.fetcher = SQLFetcher(glb, sql, lambda x, y=len(column_headers): SQLTableDataPrep(x, y), self.AddSample)
+		self.fetcher = SQLFetcher(glb, sql, lambda x, y=len(column_headers): self.SQLTableDataPrep(x, y), self.AddSample)
 		self.fetcher.done.connect(self.Update)
 		self.fetcher.Fetch(glb_chunk_sz)
 
@@ -2154,6 +2164,12 @@ class SQLTableModel(TableModel):
 	def columnHeader(self, column):
 		return self.column_headers[column]
 
+	def SQLTableDataPrep(self, query, count):
+		data = []
+		for i in xrange(count):
+			data.append(query.value(i))
+		return data
+
 # SQL automatic table data model
 
 class SQLAutoTableModel(SQLTableModel):
@@ -2182,8 +2198,32 @@ class SQLAutoTableModel(SQLTableModel):
 			QueryExec(query, "SELECT column_name FROM information_schema.columns WHERE table_schema = '" + schema + "' and table_name = '" + select_table_name + "'")
 			while query.next():
 				column_headers.append(query.value(0))
+		if pyside_version_1 and sys.version_info[0] == 3:
+			if table_name == "samples_view":
+				self.SQLTableDataPrep = self.samples_view_DataPrep
+			if table_name == "samples":
+				self.SQLTableDataPrep = self.samples_DataPrep
 		super(SQLAutoTableModel, self).__init__(glb, sql, column_headers, parent)
 
+	def samples_view_DataPrep(self, query, count):
+		data = []
+		data.append(query.value(0))
+		# Workaround pyside failing to handle large integers (i.e. time) in python3 by converting to a string
+		data.append("{:>19}".format(query.value(1)))
+		for i in xrange(2, count):
+			data.append(query.value(i))
+		return data
+
+	def samples_DataPrep(self, query, count):
+		data = []
+		for i in xrange(9):
+			data.append(query.value(i))
+		# Workaround pyside failing to handle large integers (i.e. time) in python3 by converting to a string
+		data.append("{:>19}".format(query.value(9)))
+		for i in xrange(10, count):
+			data.append(query.value(i))
+		return data
+
 # Base class for custom ResizeColumnsToContents
 
 class ResizeColumnsToContentsBase(QObject):
@@ -2868,9 +2908,13 @@ class LibXED():
 		ok = self.xed_format_context(2, inst.xedp, inst.bufferp, sizeof(inst.buffer), ip, 0, 0)
 		if not ok:
 			return 0, ""
+		if sys.version_info[0] == 2:
+			result = inst.buffer.value
+		else:
+			result = inst.buffer.value.decode()
 		# Return instruction length and the disassembled instruction text
 		# For now, assume the length is in byte 166
-		return inst.xedd[166], inst.buffer.value
+		return inst.xedd[166], result
 
 def TryOpen(file_name):
 	try:
@@ -2886,9 +2930,14 @@ def Is64Bit(f):
 	header = f.read(7)
 	f.seek(pos)
 	magic = header[0:4]
-	eclass = ord(header[4])
-	encoding = ord(header[5])
-	version = ord(header[6])
+	if sys.version_info[0] == 2:
+		eclass = ord(header[4])
+		encoding = ord(header[5])
+		version = ord(header[6])
+	else:
+		eclass = header[4]
+		encoding = header[5]
+		version = header[6]
 	if magic == chr(127) + "ELF" and eclass > 0 and eclass < 3 and encoding > 0 and encoding < 3 and version == 1:
 		result = True if eclass == 2 else False
 	return result
diff --git a/tools/perf/trace/beauty/mmap_flags.sh b/tools/perf/trace/beauty/mmap_flags.sh
index 32bac9c0d694..5f5eefcb3c74 100755
--- a/tools/perf/trace/beauty/mmap_flags.sh
+++ b/tools/perf/trace/beauty/mmap_flags.sh
@@ -1,15 +1,18 @@
 #!/bin/sh
 # SPDX-License-Identifier: LGPL-2.1
 
-if [ $# -ne 2 ] ; then
+if [ $# -ne 3 ] ; then
 	[ $# -eq 1 ] && hostarch=$1 || hostarch=`uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/`
+	linux_header_dir=tools/include/uapi/linux
 	header_dir=tools/include/uapi/asm-generic
 	arch_header_dir=tools/arch/${hostarch}/include/uapi/asm
 else
-	header_dir=$1
-	arch_header_dir=$2
+	linux_header_dir=$1
+	header_dir=$2
+	arch_header_dir=$3
 fi
 
+linux_mman=${linux_header_dir}/mman.h
 arch_mman=${arch_header_dir}/mman.h
 
 # those in egrep -vw are flags, we want just the bits
@@ -20,6 +23,11 @@ egrep -q $regex ${arch_mman} && \
 (egrep $regex ${arch_mman} | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n")
+egrep -q $regex ${linux_mman} && \
+(egrep $regex ${linux_mman} | \
+	egrep -vw 'MAP_(UNINITIALIZED|TYPE|SHARED_VALIDATE)' | \
+	sed -r "s/$regex/\2 \1/g"	| \
+	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n")
 ([ ! -f ${arch_mman} ] || egrep -q '#[[:space:]]*include[[:space:]]+<uapi/asm-generic/mman.*' ${arch_mman}) &&
 (egrep $regex ${header_dir}/mman-common.h | \
 	egrep -vw 'MAP_(UNINITIALIZED|TYPE|SHARED_VALIDATE)' | \
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index ba4c623cd8de..39fe21e1cf93 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -387,6 +387,7 @@ cs_etm_decoder__buffer_range(struct cs_etm_decoder *decoder,
 		break;
 	case OCSD_INSTR_ISB:
 	case OCSD_INSTR_DSB_DMB:
+	case OCSD_INSTR_WFI_WFE:
 	case OCSD_INSTR_OTHER:
 	default:
 		packet->last_instr_taken_branch = false;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index ec78e93085de..6689378ee577 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -231,35 +231,6 @@ void perf_evlist__set_leader(struct perf_evlist *evlist)
 	}
 }
 
-void perf_event_attr__set_max_precise_ip(struct perf_event_attr *pattr)
-{
-	struct perf_event_attr attr = {
-		.type		= PERF_TYPE_HARDWARE,
-		.config		= PERF_COUNT_HW_CPU_CYCLES,
-		.exclude_kernel	= 1,
-		.precise_ip	= 3,
-	};
-
-	event_attr_init(&attr);
-
-	/*
-	 * Unnamed union member, not supported as struct member named
-	 * initializer in older compilers such as gcc 4.4.7
-	 */
-	attr.sample_period = 1;
-
-	while (attr.precise_ip != 0) {
-		int fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
-		if (fd != -1) {
-			close(fd);
-			break;
-		}
-		--attr.precise_ip;
-	}
-
-	pattr->precise_ip = attr.precise_ip;
-}
-
 int __perf_evlist__add_default(struct perf_evlist *evlist, bool precise)
 {
 	struct perf_evsel *evsel = perf_evsel__new_cycles(precise);
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index dcb68f34d2cd..6a94785b9100 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -315,8 +315,6 @@ void perf_evlist__to_front(struct perf_evlist *evlist,
 void perf_evlist__set_tracking_event(struct perf_evlist *evlist,
 				     struct perf_evsel *tracking_evsel);
 
-void perf_event_attr__set_max_precise_ip(struct perf_event_attr *attr);
-
 struct perf_evsel *
 perf_evlist__find_evsel_by_str(struct perf_evlist *evlist, const char *str);
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 7835e05f0c0a..66d066f18b5b 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -295,7 +295,6 @@ struct perf_evsel *perf_evsel__new_cycles(bool precise)
 	if (!precise)
 		goto new_event;
 
-	perf_event_attr__set_max_precise_ip(&attr);
 	/*
 	 * Now let the usual logic to set up the perf_event_attr defaults
 	 * to kick in when we return and before perf_evsel__open() is called.
@@ -305,6 +304,8 @@ struct perf_evsel *perf_evsel__new_cycles(bool precise)
 	if (evsel == NULL)
 		goto out;
 
+	evsel->precise_max = true;
+
 	/* use asprintf() because free(evsel) assumes name is allocated */
 	if (asprintf(&evsel->name, "cycles%s%s%.*s",
 		     (attr.precise_ip || attr.exclude_kernel) ? ":" : "",
@@ -1083,7 +1084,7 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 	}
 
 	if (evsel->precise_max)
-		perf_event_attr__set_max_precise_ip(attr);
+		attr->precise_ip = 3;
 
 	if (opts->all_user) {
 		attr->exclude_kernel = 1;
@@ -1749,6 +1750,59 @@ static bool ignore_missing_thread(struct perf_evsel *evsel,
 	return true;
 }
 
+static void display_attr(struct perf_event_attr *attr)
+{
+	if (verbose >= 2) {
+		fprintf(stderr, "%.60s\n", graph_dotted_line);
+		fprintf(stderr, "perf_event_attr:\n");
+		perf_event_attr__fprintf(stderr, attr, __open_attr__fprintf, NULL);
+		fprintf(stderr, "%.60s\n", graph_dotted_line);
+	}
+}
+
+static int perf_event_open(struct perf_evsel *evsel,
+			   pid_t pid, int cpu, int group_fd,
+			   unsigned long flags)
+{
+	int precise_ip = evsel->attr.precise_ip;
+	int fd;
+
+	while (1) {
+		pr_debug2("sys_perf_event_open: pid %d  cpu %d  group_fd %d  flags %#lx",
+			  pid, cpu, group_fd, flags);
+
+		fd = sys_perf_event_open(&evsel->attr, pid, cpu, group_fd, flags);
+		if (fd >= 0)
+			break;
+
+		/*
+		 * Do quick precise_ip fallback if:
+		 *  - there is precise_ip set in perf_event_attr
+		 *  - maximum precise is requested
+		 *  - sys_perf_event_open failed with ENOTSUP error,
+		 *    which is associated with wrong precise_ip
+		 */
+		if (!precise_ip || !evsel->precise_max || (errno != ENOTSUP))
+			break;
+
+		/*
+		 * We tried all the precise_ip values, and it's
+		 * still failing, so leave it to standard fallback.
+		 */
+		if (!evsel->attr.precise_ip) {
+			evsel->attr.precise_ip = precise_ip;
+			break;
+		}
+
+		pr_debug2("\nsys_perf_event_open failed, error %d\n", -ENOTSUP);
+		evsel->attr.precise_ip--;
+		pr_debug2("decreasing precise_ip by one (%d)\n", evsel->attr.precise_ip);
+		display_attr(&evsel->attr);
+	}
+
+	return fd;
+}
+
 int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
 		     struct thread_map *threads)
 {
@@ -1824,12 +1878,7 @@ int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
 	if (perf_missing_features.sample_id_all)
 		evsel->attr.sample_id_all = 0;
 
-	if (verbose >= 2) {
-		fprintf(stderr, "%.60s\n", graph_dotted_line);
-		fprintf(stderr, "perf_event_attr:\n");
-		perf_event_attr__fprintf(stderr, &evsel->attr, __open_attr__fprintf, NULL);
-		fprintf(stderr, "%.60s\n", graph_dotted_line);
-	}
+	display_attr(&evsel->attr);
 
 	for (cpu = 0; cpu < cpus->nr; cpu++) {
 
@@ -1841,13 +1890,10 @@ int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
 
 			group_fd = get_group_fd(evsel, cpu, thread);
 retry_open:
-			pr_debug2("sys_perf_event_open: pid %d  cpu %d  group_fd %d  flags %#lx",
-				  pid, cpus->map[cpu], group_fd, flags);
-
 			test_attr__ready();
 
-			fd = sys_perf_event_open(&evsel->attr, pid, cpus->map[cpu],
-						 group_fd, flags);
+			fd = perf_event_open(evsel, pid, cpus->map[cpu],
+					     group_fd, flags);
 
 			FD(evsel, cpu, thread) = fd;
 
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 6e03db142091..872fab163585 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -251,19 +251,15 @@ struct intel_pt_decoder *intel_pt_decoder_new(struct intel_pt_params *params)
 		if (!(decoder->tsc_ctc_ratio_n % decoder->tsc_ctc_ratio_d))
 			decoder->tsc_ctc_mult = decoder->tsc_ctc_ratio_n /
 						decoder->tsc_ctc_ratio_d;
-
-		/*
-		 * Allow for timestamps appearing to backwards because a TSC
-		 * packet has slipped past a MTC packet, so allow 2 MTC ticks
-		 * or ...
-		 */
-		decoder->tsc_slip = multdiv(2 << decoder->mtc_shift,
-					decoder->tsc_ctc_ratio_n,
-					decoder->tsc_ctc_ratio_d);
 	}
-	/* ... or 0x100 paranoia */
-	if (decoder->tsc_slip < 0x100)
-		decoder->tsc_slip = 0x100;
+
+	/*
+	 * A TSC packet can slip past MTC packets so that the timestamp appears
+	 * to go backwards. One estimate is that can be up to about 40 CPU
+	 * cycles, which is certainly less than 0x1000 TSC ticks, but accept
+	 * slippage an order of magnitude more to be on the safe side.
+	 */
+	decoder->tsc_slip = 0x10000;
 
 	intel_pt_log("timestamp: mtc_shift %u\n", decoder->mtc_shift);
 	intel_pt_log("timestamp: tsc_ctc_ratio_n %u\n", decoder->tsc_ctc_ratio_n);
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 61959aba7e27..3c520baa198c 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1421,6 +1421,20 @@ static void machine__set_kernel_mmap(struct machine *machine,
 		machine->vmlinux_map->end = ~0ULL;
 }
 
+static void machine__update_kernel_mmap(struct machine *machine,
+				     u64 start, u64 end)
+{
+	struct map *map = machine__kernel_map(machine);
+
+	map__get(map);
+	map_groups__remove(&machine->kmaps, map);
+
+	machine__set_kernel_mmap(machine, start, end);
+
+	map_groups__insert(&machine->kmaps, map);
+	map__put(map);
+}
+
 int machine__create_kernel_maps(struct machine *machine)
 {
 	struct dso *kernel = machine__get_kernel(machine);
@@ -1453,17 +1467,11 @@ int machine__create_kernel_maps(struct machine *machine)
 			goto out_put;
 		}
 
-		/* we have a real start address now, so re-order the kmaps */
-		map = machine__kernel_map(machine);
-
-		map__get(map);
-		map_groups__remove(&machine->kmaps, map);
-
-		/* assume it's the last in the kmaps */
-		machine__set_kernel_mmap(machine, addr, ~0ULL);
-
-		map_groups__insert(&machine->kmaps, map);
-		map__put(map);
+		/*
+		 * we have a real start address now, so re-order the kmaps
+		 * assume it's the last in the kmaps
+		 */
+		machine__update_kernel_mmap(machine, addr, ~0ULL);
 	}
 
 	if (machine__create_extra_kernel_maps(machine, kernel))
@@ -1599,7 +1607,7 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
 		if (strstr(kernel->long_name, "vmlinux"))
 			dso__set_short_name(kernel, "[kernel.vmlinux]", false);
 
-		machine__set_kernel_mmap(machine, event->mmap.start,
+		machine__update_kernel_mmap(machine, event->mmap.start,
 					 event->mmap.start + event->mmap.len);
 
 		/*
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 6199a3174ab9..e0429f4ef335 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -732,10 +732,20 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
 
 		if (!is_arm_pmu_core(name)) {
 			pname = pe->pmu ? pe->pmu : "cpu";
+
+			/*
+			 * uncore alias may be from different PMU
+			 * with common prefix
+			 */
+			if (pmu_is_uncore(name) &&
+			    !strncmp(pname, name, strlen(pname)))
+				goto new_alias;
+
 			if (strcmp(pname, name))
 				continue;
 		}
 
+new_alias:
 		/* need type casts to override 'const' */
 		__perf_pmu__new_alias(head, NULL, (char *)pe->name,
 				(char *)pe->desc, (char *)pe->event,

