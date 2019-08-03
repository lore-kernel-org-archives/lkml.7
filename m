Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32414C31E40
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 16:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF9C2166E
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 16:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388830AbfHCQiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 12:38:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41003 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388068AbfHCQiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 12:38:16 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1htx2p-0000ob-1X; Sat, 03 Aug 2019 18:38:11 +0200
Date:   Sat, 03 Aug 2019 16:36:53 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] perf/urgent for 5.3-rc3
References: <156485021326.28964.12573754498454150320.tglx@nanos.tec.linutronix.de>
Message-ID: <156485021326.28964.10885839492269973900.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

up to:  b3c303be4c35: Merge tag 'perf-urgent-for-mingo-5.3-20190729' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent

A set of updates for perf tools and documentation:

 tools:
   perf header:
     - Prevent a division by zero
     - Deal with an uninitialized warning proper

  libbpf:
    - Fix the missiong __WORDSIZE definition for musl & al

  UAPI headers:
    - Synchronize kernel headers

 Documentation:
   - Fix the memory units for perf.data size
  
Thanks,

	tglx

------------------>
Andrii Nakryiko (1):
      libbpf: fix missing __WORDSIZE definition

Arnaldo Carvalho de Melo (8):
      tools include UAPI: Sync x86's syscalls_64.tbl and generic unistd.h to pick up clone3 and pidfd_open
      tools headers UAPI: Update tools's copy of kvm.h headers
      tools headers UAPI: Update tools's copy of mman.h headers
      tools headers UAPI: Update tools's copy of drm.h headers
      tools perf beauty: Fix usbdevfs_ioctl table generator to handle _IOC()
      tools headers UAPI: Sync usbdevice_fs.h with the kernels to get new ioctl
      tools headers UAPI: Sync sched.h with the kernel
      tools headers UAPI: Sync if_link.h with the kernel

Numfor Mbiziwo-Tiapo (1):
      perf header: Fix use of unitialized value warning

Vince Weaver (2):
      perf header: Fix divide by zero error if f_header.attr_size==0
      perf tools: Fix perf.data documentation units for memory size


 tools/arch/arm/include/uapi/asm/kvm.h              |  12 ++
 tools/arch/arm64/include/uapi/asm/kvm.h            |  10 +
 tools/arch/powerpc/include/uapi/asm/mman.h         |   4 -
 tools/arch/sparc/include/uapi/asm/mman.h           |   4 -
 tools/arch/x86/include/uapi/asm/kvm.h              |  22 ++-
 tools/arch/x86/include/uapi/asm/vmx.h              |   1 -
 tools/include/uapi/asm-generic/mman-common.h       |  15 +-
 tools/include/uapi/asm-generic/mman.h              |  10 +-
 tools/include/uapi/asm-generic/unistd.h            |   8 +-
 tools/include/uapi/drm/drm.h                       |   1 +
 tools/include/uapi/drm/i915_drm.h                  | 209 ++++++++++++++++++++-
 tools/include/uapi/linux/if_link.h                 |   5 +
 tools/include/uapi/linux/kvm.h                     |   3 +
 tools/include/uapi/linux/sched.h                   |  30 ++-
 tools/include/uapi/linux/usbdevice_fs.h            |  26 +++
 tools/lib/bpf/hashmap.h                            |   5 +
 tools/perf/Documentation/perf.data-file-format.txt |   2 +-
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |   2 +
 tools/perf/trace/beauty/usbdevfs_ioctl.sh          |   9 +-
 tools/perf/util/header.c                           |   9 +-
 20 files changed, 352 insertions(+), 35 deletions(-)

diff --git a/tools/arch/arm/include/uapi/asm/kvm.h b/tools/arch/arm/include/uapi/asm/kvm.h
index 4602464ebdfb..a4217c1a5d01 100644
--- a/tools/arch/arm/include/uapi/asm/kvm.h
+++ b/tools/arch/arm/include/uapi/asm/kvm.h
@@ -214,6 +214,18 @@ struct kvm_vcpu_events {
 #define KVM_REG_ARM_FW_REG(r)		(KVM_REG_ARM | KVM_REG_SIZE_U64 | \
 					 KVM_REG_ARM_FW | ((r) & 0xffff))
 #define KVM_REG_ARM_PSCI_VERSION	KVM_REG_ARM_FW_REG(0)
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1	KVM_REG_ARM_FW_REG(1)
+	/* Higher values mean better protection. */
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_AVAIL		0
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_AVAIL		1
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_REQUIRED	2
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2	KVM_REG_ARM_FW_REG(2)
+	/* Higher values mean better protection. */
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_AVAIL		0
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_UNKNOWN		1
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_AVAIL		2
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_REQUIRED	3
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_ENABLED	(1U << 4)
 
 /* Device Control API: ARM VGIC */
 #define KVM_DEV_ARM_VGIC_GRP_ADDR	0
diff --git a/tools/arch/arm64/include/uapi/asm/kvm.h b/tools/arch/arm64/include/uapi/asm/kvm.h
index d819a3e8b552..9a507716ae2f 100644
--- a/tools/arch/arm64/include/uapi/asm/kvm.h
+++ b/tools/arch/arm64/include/uapi/asm/kvm.h
@@ -229,6 +229,16 @@ struct kvm_vcpu_events {
 #define KVM_REG_ARM_FW_REG(r)		(KVM_REG_ARM64 | KVM_REG_SIZE_U64 | \
 					 KVM_REG_ARM_FW | ((r) & 0xffff))
 #define KVM_REG_ARM_PSCI_VERSION	KVM_REG_ARM_FW_REG(0)
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1	KVM_REG_ARM_FW_REG(1)
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_AVAIL		0
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_AVAIL		1
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_REQUIRED	2
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2	KVM_REG_ARM_FW_REG(2)
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_AVAIL		0
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_UNKNOWN		1
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_AVAIL		2
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_REQUIRED	3
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_ENABLED     	(1U << 4)
 
 /* SVE registers */
 #define KVM_REG_ARM64_SVE		(0x15 << KVM_REG_ARM_COPROC_SHIFT)
diff --git a/tools/arch/powerpc/include/uapi/asm/mman.h b/tools/arch/powerpc/include/uapi/asm/mman.h
index f33105bc5ca6..8601d824a9c6 100644
--- a/tools/arch/powerpc/include/uapi/asm/mman.h
+++ b/tools/arch/powerpc/include/uapi/asm/mman.h
@@ -4,12 +4,8 @@
 #define MAP_DENYWRITE	0x0800
 #define MAP_EXECUTABLE	0x1000
 #define MAP_GROWSDOWN	0x0100
-#define MAP_HUGETLB	0x40000
 #define MAP_LOCKED	0x80
-#define MAP_NONBLOCK	0x10000
 #define MAP_NORESERVE   0x40
-#define MAP_POPULATE	0x8000
-#define MAP_STACK	0x20000
 #include <uapi/asm-generic/mman-common.h>
 /* MAP_32BIT is undefined on powerpc, fix it for perf */
 #define MAP_32BIT	0
diff --git a/tools/arch/sparc/include/uapi/asm/mman.h b/tools/arch/sparc/include/uapi/asm/mman.h
index 38920eed8cbf..7b94dccc843d 100644
--- a/tools/arch/sparc/include/uapi/asm/mman.h
+++ b/tools/arch/sparc/include/uapi/asm/mman.h
@@ -4,12 +4,8 @@
 #define MAP_DENYWRITE	0x0800
 #define MAP_EXECUTABLE	0x1000
 #define MAP_GROWSDOWN	0x0200
-#define MAP_HUGETLB	0x40000
 #define MAP_LOCKED      0x100
-#define MAP_NONBLOCK	0x10000
 #define MAP_NORESERVE   0x40
-#define MAP_POPULATE	0x8000
-#define MAP_STACK	0x20000
 #include <uapi/asm-generic/mman-common.h>
 /* MAP_32BIT is undefined on sparc, fix it for perf */
 #define MAP_32BIT	0
diff --git a/tools/arch/x86/include/uapi/asm/kvm.h b/tools/arch/x86/include/uapi/asm/kvm.h
index d6ab5b4d15e5..503d3f42da16 100644
--- a/tools/arch/x86/include/uapi/asm/kvm.h
+++ b/tools/arch/x86/include/uapi/asm/kvm.h
@@ -378,10 +378,11 @@ struct kvm_sync_regs {
 	struct kvm_vcpu_events events;
 };
 
-#define KVM_X86_QUIRK_LINT0_REENABLED	(1 << 0)
-#define KVM_X86_QUIRK_CD_NW_CLEARED	(1 << 1)
-#define KVM_X86_QUIRK_LAPIC_MMIO_HOLE	(1 << 2)
-#define KVM_X86_QUIRK_OUT_7E_INC_RIP	(1 << 3)
+#define KVM_X86_QUIRK_LINT0_REENABLED	   (1 << 0)
+#define KVM_X86_QUIRK_CD_NW_CLEARED	   (1 << 1)
+#define KVM_X86_QUIRK_LAPIC_MMIO_HOLE	   (1 << 2)
+#define KVM_X86_QUIRK_OUT_7E_INC_RIP	   (1 << 3)
+#define KVM_X86_QUIRK_MISC_ENABLE_NO_MWAIT (1 << 4)
 
 #define KVM_STATE_NESTED_FORMAT_VMX	0
 #define KVM_STATE_NESTED_FORMAT_SVM	1	/* unused */
@@ -432,4 +433,17 @@ struct kvm_nested_state {
 	} data;
 };
 
+/* for KVM_CAP_PMU_EVENT_FILTER */
+struct kvm_pmu_event_filter {
+	__u32 action;
+	__u32 nevents;
+	__u32 fixed_counter_bitmap;
+	__u32 flags;
+	__u32 pad[4];
+	__u64 events[0];
+};
+
+#define KVM_PMU_EVENT_ALLOW 0
+#define KVM_PMU_EVENT_DENY 1
+
 #endif /* _ASM_X86_KVM_H */
diff --git a/tools/arch/x86/include/uapi/asm/vmx.h b/tools/arch/x86/include/uapi/asm/vmx.h
index d213ec5c3766..f0b0c90dd398 100644
--- a/tools/arch/x86/include/uapi/asm/vmx.h
+++ b/tools/arch/x86/include/uapi/asm/vmx.h
@@ -146,7 +146,6 @@
 
 #define VMX_ABORT_SAVE_GUEST_MSR_FAIL        1
 #define VMX_ABORT_LOAD_HOST_PDPTE_FAIL       2
-#define VMX_ABORT_VMCS_CORRUPTED             3
 #define VMX_ABORT_LOAD_HOST_MSR_FAIL         4
 
 #endif /* _UAPIVMX_H */
diff --git a/tools/include/uapi/asm-generic/mman-common.h b/tools/include/uapi/asm-generic/mman-common.h
index abd238d0f7a4..63b1f506ea67 100644
--- a/tools/include/uapi/asm-generic/mman-common.h
+++ b/tools/include/uapi/asm-generic/mman-common.h
@@ -19,15 +19,18 @@
 #define MAP_TYPE	0x0f		/* Mask for type of mapping */
 #define MAP_FIXED	0x10		/* Interpret addr exactly */
 #define MAP_ANONYMOUS	0x20		/* don't use a file */
-#ifdef CONFIG_MMAP_ALLOW_UNINITIALIZED
-# define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be uninitialized */
-#else
-# define MAP_UNINITIALIZED 0x0		/* Don't support this flag */
-#endif
 
-/* 0x0100 - 0x80000 flags are defined in asm-generic/mman.h */
+/* 0x0100 - 0x4000 flags are defined in asm-generic/mman.h */
+#define MAP_POPULATE		0x008000	/* populate (prefault) pagetables */
+#define MAP_NONBLOCK		0x010000	/* do not block on IO */
+#define MAP_STACK		0x020000	/* give out an address that is best suited for process/thread stacks */
+#define MAP_HUGETLB		0x040000	/* create a huge page mapping */
+#define MAP_SYNC		0x080000 /* perform synchronous page faults for the mapping */
 #define MAP_FIXED_NOREPLACE	0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
 
+#define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be
+					 * uninitialized */
+
 /*
  * Flags for mlock
  */
diff --git a/tools/include/uapi/asm-generic/mman.h b/tools/include/uapi/asm-generic/mman.h
index 36c197fc44a0..406f7718f9ad 100644
--- a/tools/include/uapi/asm-generic/mman.h
+++ b/tools/include/uapi/asm-generic/mman.h
@@ -9,13 +9,11 @@
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_LOCKED	0x2000		/* pages are locked */
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
-#define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
-#define MAP_NONBLOCK	0x10000		/* do not block on IO */
-#define MAP_STACK	0x20000		/* give out an address that is best suited for process/thread stacks */
-#define MAP_HUGETLB	0x40000		/* create a huge page mapping */
-#define MAP_SYNC	0x80000		/* perform synchronous page faults for the mapping */
 
-/* Bits [26:31] are reserved, see mman-common.h for MAP_HUGETLB usage */
+/*
+ * Bits [26:31] are reserved, see asm-generic/hugetlb_encode.h
+ * for MAP_HUGETLB usage
+ */
 
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index a87904daf103..1be0e798e362 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -844,9 +844,15 @@ __SYSCALL(__NR_fsconfig, sys_fsconfig)
 __SYSCALL(__NR_fsmount, sys_fsmount)
 #define __NR_fspick 433
 __SYSCALL(__NR_fspick, sys_fspick)
+#define __NR_pidfd_open 434
+__SYSCALL(__NR_pidfd_open, sys_pidfd_open)
+#ifdef __ARCH_WANT_SYS_CLONE3
+#define __NR_clone3 435
+__SYSCALL(__NR_clone3, sys_clone3)
+#endif
 
 #undef __NR_syscalls
-#define __NR_syscalls 434
+#define __NR_syscalls 436
 
 /*
  * 32 bit systems traditionally used different
diff --git a/tools/include/uapi/drm/drm.h b/tools/include/uapi/drm/drm.h
index 661d73f9a919..8a5b2f8f8eb9 100644
--- a/tools/include/uapi/drm/drm.h
+++ b/tools/include/uapi/drm/drm.h
@@ -50,6 +50,7 @@ typedef unsigned int drm_handle_t;
 
 #else /* One of the BSDs */
 
+#include <stdint.h>
 #include <sys/ioccom.h>
 #include <sys/types.h>
 typedef int8_t   __s8;
diff --git a/tools/include/uapi/drm/i915_drm.h b/tools/include/uapi/drm/i915_drm.h
index 3a73f5316766..328d05e77d9f 100644
--- a/tools/include/uapi/drm/i915_drm.h
+++ b/tools/include/uapi/drm/i915_drm.h
@@ -136,6 +136,8 @@ enum drm_i915_gem_engine_class {
 struct i915_engine_class_instance {
 	__u16 engine_class; /* see enum drm_i915_gem_engine_class */
 	__u16 engine_instance;
+#define I915_ENGINE_CLASS_INVALID_NONE -1
+#define I915_ENGINE_CLASS_INVALID_VIRTUAL -2
 };
 
 /**
@@ -355,6 +357,8 @@ typedef struct _drm_i915_sarea {
 #define DRM_I915_PERF_ADD_CONFIG	0x37
 #define DRM_I915_PERF_REMOVE_CONFIG	0x38
 #define DRM_I915_QUERY			0x39
+#define DRM_I915_GEM_VM_CREATE		0x3a
+#define DRM_I915_GEM_VM_DESTROY		0x3b
 /* Must be kept compact -- no holes */
 
 #define DRM_IOCTL_I915_INIT		DRM_IOW( DRM_COMMAND_BASE + DRM_I915_INIT, drm_i915_init_t)
@@ -415,6 +419,8 @@ typedef struct _drm_i915_sarea {
 #define DRM_IOCTL_I915_PERF_ADD_CONFIG	DRM_IOW(DRM_COMMAND_BASE + DRM_I915_PERF_ADD_CONFIG, struct drm_i915_perf_oa_config)
 #define DRM_IOCTL_I915_PERF_REMOVE_CONFIG	DRM_IOW(DRM_COMMAND_BASE + DRM_I915_PERF_REMOVE_CONFIG, __u64)
 #define DRM_IOCTL_I915_QUERY			DRM_IOWR(DRM_COMMAND_BASE + DRM_I915_QUERY, struct drm_i915_query)
+#define DRM_IOCTL_I915_GEM_VM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_I915_GEM_VM_CREATE, struct drm_i915_gem_vm_control)
+#define DRM_IOCTL_I915_GEM_VM_DESTROY	DRM_IOW (DRM_COMMAND_BASE + DRM_I915_GEM_VM_DESTROY, struct drm_i915_gem_vm_control)
 
 /* Allow drivers to submit batchbuffers directly to hardware, relying
  * on the security mechanisms provided by hardware.
@@ -598,6 +604,12 @@ typedef struct drm_i915_irq_wait {
  */
 #define I915_PARAM_MMAP_GTT_COHERENT	52
 
+/*
+ * Query whether DRM_I915_GEM_EXECBUFFER2 supports coordination of parallel
+ * execution through use of explicit fence support.
+ * See I915_EXEC_FENCE_OUT and I915_EXEC_FENCE_SUBMIT.
+ */
+#define I915_PARAM_HAS_EXEC_SUBMIT_FENCE 53
 /* Must be kept compact -- no holes and well documented */
 
 typedef struct drm_i915_getparam {
@@ -1120,7 +1132,16 @@ struct drm_i915_gem_execbuffer2 {
  */
 #define I915_EXEC_FENCE_ARRAY   (1<<19)
 
-#define __I915_EXEC_UNKNOWN_FLAGS (-(I915_EXEC_FENCE_ARRAY<<1))
+/*
+ * Setting I915_EXEC_FENCE_SUBMIT implies that lower_32_bits(rsvd2) represent
+ * a sync_file fd to wait upon (in a nonblocking manner) prior to executing
+ * the batch.
+ *
+ * Returns -EINVAL if the sync_file fd cannot be found.
+ */
+#define I915_EXEC_FENCE_SUBMIT		(1 << 20)
+
+#define __I915_EXEC_UNKNOWN_FLAGS (-(I915_EXEC_FENCE_SUBMIT << 1))
 
 #define I915_EXEC_CONTEXT_ID_MASK	(0xffffffff)
 #define i915_execbuffer2_set_context_id(eb2, context) \
@@ -1464,8 +1485,9 @@ struct drm_i915_gem_context_create_ext {
 	__u32 ctx_id; /* output: id of new context*/
 	__u32 flags;
 #define I915_CONTEXT_CREATE_FLAGS_USE_EXTENSIONS	(1u << 0)
+#define I915_CONTEXT_CREATE_FLAGS_SINGLE_TIMELINE	(1u << 1)
 #define I915_CONTEXT_CREATE_FLAGS_UNKNOWN \
-	(-(I915_CONTEXT_CREATE_FLAGS_USE_EXTENSIONS << 1))
+	(-(I915_CONTEXT_CREATE_FLAGS_SINGLE_TIMELINE << 1))
 	__u64 extensions;
 };
 
@@ -1507,6 +1529,41 @@ struct drm_i915_gem_context_param {
  * On creation, all new contexts are marked as recoverable.
  */
 #define I915_CONTEXT_PARAM_RECOVERABLE	0x8
+
+	/*
+	 * The id of the associated virtual memory address space (ppGTT) of
+	 * this context. Can be retrieved and passed to another context
+	 * (on the same fd) for both to use the same ppGTT and so share
+	 * address layouts, and avoid reloading the page tables on context
+	 * switches between themselves.
+	 *
+	 * See DRM_I915_GEM_VM_CREATE and DRM_I915_GEM_VM_DESTROY.
+	 */
+#define I915_CONTEXT_PARAM_VM		0x9
+
+/*
+ * I915_CONTEXT_PARAM_ENGINES:
+ *
+ * Bind this context to operate on this subset of available engines. Henceforth,
+ * the I915_EXEC_RING selector for DRM_IOCTL_I915_GEM_EXECBUFFER2 operates as
+ * an index into this array of engines; I915_EXEC_DEFAULT selecting engine[0]
+ * and upwards. Slots 0...N are filled in using the specified (class, instance).
+ * Use
+ *	engine_class: I915_ENGINE_CLASS_INVALID,
+ *	engine_instance: I915_ENGINE_CLASS_INVALID_NONE
+ * to specify a gap in the array that can be filled in later, e.g. by a
+ * virtual engine used for load balancing.
+ *
+ * Setting the number of engines bound to the context to 0, by passing a zero
+ * sized argument, will revert back to default settings.
+ *
+ * See struct i915_context_param_engines.
+ *
+ * Extensions:
+ *   i915_context_engines_load_balance (I915_CONTEXT_ENGINES_EXT_LOAD_BALANCE)
+ *   i915_context_engines_bond (I915_CONTEXT_ENGINES_EXT_BOND)
+ */
+#define I915_CONTEXT_PARAM_ENGINES	0xa
 /* Must be kept compact -- no holes and well documented */
 
 	__u64 value;
@@ -1540,9 +1597,10 @@ struct drm_i915_gem_context_param_sseu {
 	struct i915_engine_class_instance engine;
 
 	/*
-	 * Unused for now. Must be cleared to zero.
+	 * Unknown flags must be cleared to zero.
 	 */
 	__u32 flags;
+#define I915_CONTEXT_SSEU_FLAG_ENGINE_INDEX (1u << 0)
 
 	/*
 	 * Mask of slices to enable for the context. Valid values are a subset
@@ -1570,12 +1628,115 @@ struct drm_i915_gem_context_param_sseu {
 	__u32 rsvd;
 };
 
+/*
+ * i915_context_engines_load_balance:
+ *
+ * Enable load balancing across this set of engines.
+ *
+ * Into the I915_EXEC_DEFAULT slot [0], a virtual engine is created that when
+ * used will proxy the execbuffer request onto one of the set of engines
+ * in such a way as to distribute the load evenly across the set.
+ *
+ * The set of engines must be compatible (e.g. the same HW class) as they
+ * will share the same logical GPU context and ring.
+ *
+ * To intermix rendering with the virtual engine and direct rendering onto
+ * the backing engines (bypassing the load balancing proxy), the context must
+ * be defined to use a single timeline for all engines.
+ */
+struct i915_context_engines_load_balance {
+	struct i915_user_extension base;
+
+	__u16 engine_index;
+	__u16 num_siblings;
+	__u32 flags; /* all undefined flags must be zero */
+
+	__u64 mbz64; /* reserved for future use; must be zero */
+
+	struct i915_engine_class_instance engines[0];
+} __attribute__((packed));
+
+#define I915_DEFINE_CONTEXT_ENGINES_LOAD_BALANCE(name__, N__) struct { \
+	struct i915_user_extension base; \
+	__u16 engine_index; \
+	__u16 num_siblings; \
+	__u32 flags; \
+	__u64 mbz64; \
+	struct i915_engine_class_instance engines[N__]; \
+} __attribute__((packed)) name__
+
+/*
+ * i915_context_engines_bond:
+ *
+ * Constructed bonded pairs for execution within a virtual engine.
+ *
+ * All engines are equal, but some are more equal than others. Given
+ * the distribution of resources in the HW, it may be preferable to run
+ * a request on a given subset of engines in parallel to a request on a
+ * specific engine. We enable this selection of engines within a virtual
+ * engine by specifying bonding pairs, for any given master engine we will
+ * only execute on one of the corresponding siblings within the virtual engine.
+ *
+ * To execute a request in parallel on the master engine and a sibling requires
+ * coordination with a I915_EXEC_FENCE_SUBMIT.
+ */
+struct i915_context_engines_bond {
+	struct i915_user_extension base;
+
+	struct i915_engine_class_instance master;
+
+	__u16 virtual_index; /* index of virtual engine in ctx->engines[] */
+	__u16 num_bonds;
+
+	__u64 flags; /* all undefined flags must be zero */
+	__u64 mbz64[4]; /* reserved for future use; must be zero */
+
+	struct i915_engine_class_instance engines[0];
+} __attribute__((packed));
+
+#define I915_DEFINE_CONTEXT_ENGINES_BOND(name__, N__) struct { \
+	struct i915_user_extension base; \
+	struct i915_engine_class_instance master; \
+	__u16 virtual_index; \
+	__u16 num_bonds; \
+	__u64 flags; \
+	__u64 mbz64[4]; \
+	struct i915_engine_class_instance engines[N__]; \
+} __attribute__((packed)) name__
+
+struct i915_context_param_engines {
+	__u64 extensions; /* linked chain of extension blocks, 0 terminates */
+#define I915_CONTEXT_ENGINES_EXT_LOAD_BALANCE 0 /* see i915_context_engines_load_balance */
+#define I915_CONTEXT_ENGINES_EXT_BOND 1 /* see i915_context_engines_bond */
+	struct i915_engine_class_instance engines[0];
+} __attribute__((packed));
+
+#define I915_DEFINE_CONTEXT_PARAM_ENGINES(name__, N__) struct { \
+	__u64 extensions; \
+	struct i915_engine_class_instance engines[N__]; \
+} __attribute__((packed)) name__
+
 struct drm_i915_gem_context_create_ext_setparam {
 #define I915_CONTEXT_CREATE_EXT_SETPARAM 0
 	struct i915_user_extension base;
 	struct drm_i915_gem_context_param param;
 };
 
+struct drm_i915_gem_context_create_ext_clone {
+#define I915_CONTEXT_CREATE_EXT_CLONE 1
+	struct i915_user_extension base;
+	__u32 clone_id;
+	__u32 flags;
+#define I915_CONTEXT_CLONE_ENGINES	(1u << 0)
+#define I915_CONTEXT_CLONE_FLAGS	(1u << 1)
+#define I915_CONTEXT_CLONE_SCHEDATTR	(1u << 2)
+#define I915_CONTEXT_CLONE_SSEU		(1u << 3)
+#define I915_CONTEXT_CLONE_TIMELINE	(1u << 4)
+#define I915_CONTEXT_CLONE_VM		(1u << 5)
+#define I915_CONTEXT_CLONE_UNKNOWN -(I915_CONTEXT_CLONE_VM << 1)
+	__u64 rsvd;
+};
+
 struct drm_i915_gem_context_destroy {
 	__u32 ctx_id;
 	__u32 pad;
@@ -1821,6 +1982,7 @@ struct drm_i915_perf_oa_config {
 struct drm_i915_query_item {
 	__u64 query_id;
 #define DRM_I915_QUERY_TOPOLOGY_INFO    1
+#define DRM_I915_QUERY_ENGINE_INFO	2
 /* Must be kept compact -- no holes and well documented */
 
 	/*
@@ -1919,6 +2081,47 @@ struct drm_i915_query_topology_info {
 	__u8 data[];
 };
 
+/**
+ * struct drm_i915_engine_info
+ *
+ * Describes one engine and it's capabilities as known to the driver.
+ */
+struct drm_i915_engine_info {
+	/** Engine class and instance. */
+	struct i915_engine_class_instance engine;
+
+	/** Reserved field. */
+	__u32 rsvd0;
+
+	/** Engine flags. */
+	__u64 flags;
+
+	/** Capabilities of this engine. */
+	__u64 capabilities;
+#define I915_VIDEO_CLASS_CAPABILITY_HEVC		(1 << 0)
+#define I915_VIDEO_AND_ENHANCE_CLASS_CAPABILITY_SFC	(1 << 1)
+
+	/** Reserved fields. */
+	__u64 rsvd1[4];
+};
+
+/**
+ * struct drm_i915_query_engine_info
+ *
+ * Engine info query enumerates all engines known to the driver by filling in
+ * an array of struct drm_i915_engine_info structures.
+ */
+struct drm_i915_query_engine_info {
+	/** Number of struct drm_i915_engine_info structs following. */
+	__u32 num_engines;
+
+	/** MBZ */
+	__u32 rsvd[3];
+
+	/** Marker for drm_i915_engine_info structures. */
+	struct drm_i915_engine_info engines[];
+};
+
 #if defined(__cplusplus)
 }
 #endif
diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index 7d113a9602f0..4a8c02cafa9a 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -695,6 +695,7 @@ enum {
 	IFLA_VF_IB_NODE_GUID,	/* VF Infiniband node GUID */
 	IFLA_VF_IB_PORT_GUID,	/* VF Infiniband port GUID */
 	IFLA_VF_VLAN_LIST,	/* nested list of vlans, option for QinQ */
+	IFLA_VF_BROADCAST,	/* VF broadcast */
 	__IFLA_VF_MAX,
 };
 
@@ -705,6 +706,10 @@ struct ifla_vf_mac {
 	__u8 mac[32]; /* MAX_ADDR_LEN */
 };
 
+struct ifla_vf_broadcast {
+	__u8 broadcast[32];
+};
+
 struct ifla_vf_vlan {
 	__u32 vf;
 	__u32 vlan; /* 0 - 4095, 0 disables VLAN filter */
diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index e7c67be7c15f..5e3f12d5359e 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -995,6 +995,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_ARM_SVE 170
 #define KVM_CAP_ARM_PTRAUTH_ADDRESS 171
 #define KVM_CAP_ARM_PTRAUTH_GENERIC 172
+#define KVM_CAP_PMU_EVENT_FILTER 173
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1329,6 +1330,8 @@ struct kvm_s390_ucas_mapping {
 #define KVM_PPC_GET_RMMU_INFO	  _IOW(KVMIO,  0xb0, struct kvm_ppc_rmmu_info)
 /* Available with KVM_CAP_PPC_GET_CPU_CHAR */
 #define KVM_PPC_GET_CPU_CHAR	  _IOR(KVMIO,  0xb1, struct kvm_ppc_cpu_char)
+/* Available with KVM_CAP_PMU_EVENT_FILTER */
+#define KVM_SET_PMU_EVENT_FILTER  _IOW(KVMIO,  0xb2, struct kvm_pmu_event_filter)
 
 /* ioctl for vm fd */
 #define KVM_CREATE_DEVICE	  _IOWR(KVMIO,  0xe0, struct kvm_create_device)
diff --git a/tools/include/uapi/linux/sched.h b/tools/include/uapi/linux/sched.h
index ed4ee170bee2..b3105ac1381a 100644
--- a/tools/include/uapi/linux/sched.h
+++ b/tools/include/uapi/linux/sched.h
@@ -2,6 +2,8 @@
 #ifndef _UAPI_LINUX_SCHED_H
 #define _UAPI_LINUX_SCHED_H
 
+#include <linux/types.h>
+
 /*
  * cloning flags:
  */
@@ -31,6 +33,20 @@
 #define CLONE_NEWNET		0x40000000	/* New network namespace */
 #define CLONE_IO		0x80000000	/* Clone io context */
 
+/*
+ * Arguments for the clone3 syscall
+ */
+struct clone_args {
+	__aligned_u64 flags;
+	__aligned_u64 pidfd;
+	__aligned_u64 child_tid;
+	__aligned_u64 parent_tid;
+	__aligned_u64 exit_signal;
+	__aligned_u64 stack;
+	__aligned_u64 stack_size;
+	__aligned_u64 tls;
+};
+
 /*
  * Scheduling policies
  */
@@ -51,9 +67,21 @@
 #define SCHED_FLAG_RESET_ON_FORK	0x01
 #define SCHED_FLAG_RECLAIM		0x02
 #define SCHED_FLAG_DL_OVERRUN		0x04
+#define SCHED_FLAG_KEEP_POLICY		0x08
+#define SCHED_FLAG_KEEP_PARAMS		0x10
+#define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
+#define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
+
+#define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
+				 SCHED_FLAG_KEEP_PARAMS)
+
+#define SCHED_FLAG_UTIL_CLAMP	(SCHED_FLAG_UTIL_CLAMP_MIN | \
+				 SCHED_FLAG_UTIL_CLAMP_MAX)
 
 #define SCHED_FLAG_ALL	(SCHED_FLAG_RESET_ON_FORK	| \
 			 SCHED_FLAG_RECLAIM		| \
-			 SCHED_FLAG_DL_OVERRUN)
+			 SCHED_FLAG_DL_OVERRUN		| \
+			 SCHED_FLAG_KEEP_ALL		| \
+			 SCHED_FLAG_UTIL_CLAMP)
 
 #endif /* _UAPI_LINUX_SCHED_H */
diff --git a/tools/include/uapi/linux/usbdevice_fs.h b/tools/include/uapi/linux/usbdevice_fs.h
index 964e87217be4..78efe870c2b7 100644
--- a/tools/include/uapi/linux/usbdevice_fs.h
+++ b/tools/include/uapi/linux/usbdevice_fs.h
@@ -76,6 +76,26 @@ struct usbdevfs_connectinfo {
 	unsigned char slow;
 };
 
+struct usbdevfs_conninfo_ex {
+	__u32 size;		/* Size of the structure from the kernel's */
+				/* point of view. Can be used by userspace */
+				/* to determine how much data can be       */
+				/* used/trusted.                           */
+	__u32 busnum;           /* USB bus number, as enumerated by the    */
+				/* kernel, the device is connected to.     */
+	__u32 devnum;           /* Device address on the bus.              */
+	__u32 speed;		/* USB_SPEED_* constants from ch9.h        */
+	__u8 num_ports;		/* Number of ports the device is connected */
+				/* to on the way to the root hub. It may   */
+				/* be bigger than size of 'ports' array so */
+				/* userspace can detect overflows.         */
+	__u8 ports[7];		/* List of ports on the way from the root  */
+				/* hub to the device. Current limit in     */
+				/* USB specification is 7 tiers (root hub, */
+				/* 5 intermediate hubs, device), which     */
+				/* gives at most 6 port entries.           */
+};
+
 #define USBDEVFS_URB_SHORT_NOT_OK	0x01
 #define USBDEVFS_URB_ISO_ASAP		0x02
 #define USBDEVFS_URB_BULK_CONTINUATION	0x04
@@ -137,6 +157,7 @@ struct usbdevfs_hub_portinfo {
 #define USBDEVFS_CAP_REAP_AFTER_DISCONNECT	0x10
 #define USBDEVFS_CAP_MMAP			0x20
 #define USBDEVFS_CAP_DROP_PRIVILEGES		0x40
+#define USBDEVFS_CAP_CONNINFO_EX		0x80
 
 /* USBDEVFS_DISCONNECT_CLAIM flags & struct */
 
@@ -197,5 +218,10 @@ struct usbdevfs_streams {
 #define USBDEVFS_FREE_STREAMS      _IOR('U', 29, struct usbdevfs_streams)
 #define USBDEVFS_DROP_PRIVILEGES   _IOW('U', 30, __u32)
 #define USBDEVFS_GET_SPEED         _IO('U', 31)
+/*
+ * Returns struct usbdevfs_conninfo_ex; length is variable to allow
+ * extending size of the data returned.
+ */
+#define USBDEVFS_CONNINFO_EX(len)  _IOC(_IOC_READ, 'U', 32, len)
 
 #endif /* _UAPI_LINUX_USBDEVICE_FS_H */
diff --git a/tools/lib/bpf/hashmap.h b/tools/lib/bpf/hashmap.h
index 03748a742146..bae8879cdf58 100644
--- a/tools/lib/bpf/hashmap.h
+++ b/tools/lib/bpf/hashmap.h
@@ -10,6 +10,11 @@
 
 #include <stdbool.h>
 #include <stddef.h>
+#ifdef __GLIBC__
+#include <bits/wordsize.h>
+#else
+#include <bits/reg.h>
+#endif
 #include "libbpf_internal.h"
 
 static inline size_t hash_bits(size_t h, int bits)
diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index 5f54feb19977..d030c87ed9f5 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -126,7 +126,7 @@ vendor,family,model,stepping. For example: GenuineIntel,6,69,1
 
 	HEADER_TOTAL_MEM = 10,
 
-An uint64_t with the total memory in bytes.
+An uint64_t with the total memory in kilobytes.
 
 	HEADER_CMDLINE = 11,
 
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index b4e6f9e6204a..c29976eca4a8 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -355,6 +355,8 @@
 431	common	fsconfig		__x64_sys_fsconfig
 432	common	fsmount			__x64_sys_fsmount
 433	common	fspick			__x64_sys_fspick
+434	common	pidfd_open		__x64_sys_pidfd_open
+435	common	clone3			__x64_sys_clone3/ptregs
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/tools/perf/trace/beauty/usbdevfs_ioctl.sh b/tools/perf/trace/beauty/usbdevfs_ioctl.sh
index 930b80f422e8..aa597ae53747 100755
--- a/tools/perf/trace/beauty/usbdevfs_ioctl.sh
+++ b/tools/perf/trace/beauty/usbdevfs_ioctl.sh
@@ -3,10 +3,13 @@
 
 [ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/
 
+# also as:
+# #define USBDEVFS_CONNINFO_EX(len)  _IOC(_IOC_READ, 'U', 32, len)
+
 printf "static const char *usbdevfs_ioctl_cmds[] = {\n"
-regex="^#[[:space:]]*define[[:space:]]+USBDEVFS_(\w+)[[:space:]]+_IO[WR]{0,2}\([[:space:]]*'U'[[:space:]]*,[[:space:]]*([[:digit:]]+).*"
-egrep $regex ${header_dir}/usbdevice_fs.h | egrep -v 'USBDEVFS_\w+32[[:space:]]' | \
-	sed -r "s/$regex/\2 \1/g"	| \
+regex="^#[[:space:]]*define[[:space:]]+USBDEVFS_(\w+)(\(\w+\))?[[:space:]]+_IO[CWR]{0,2}\([[:space:]]*(_IOC_\w+,[[:space:]]*)?'U'[[:space:]]*,[[:space:]]*([[:digit:]]+).*"
+egrep "$regex" ${header_dir}/usbdevice_fs.h | egrep -v 'USBDEVFS_\w+32[[:space:]]' | \
+	sed -r "s/$regex/\4 \1/g"	| \
 	sort | xargs printf "\t[%s] = \"%s\",\n"
 printf "};\n\n"
 printf "#if 0\n"
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 20111f8da5cb..1903d7ec9797 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3559,6 +3559,13 @@ int perf_session__read_header(struct perf_session *session)
 			   data->file.path);
 	}
 
+	if (f_header.attr_size == 0) {
+		pr_err("ERROR: The %s file's attr size field is 0 which is unexpected.\n"
+		       "Was the 'perf record' command properly terminated?\n",
+		       data->file.path);
+		return -EINVAL;
+	}
+
 	nr_attrs = f_header.attrs.size / f_header.attr_size;
 	lseek(fd, f_header.attrs.offset, SEEK_SET);
 
@@ -3639,7 +3646,7 @@ int perf_event__synthesize_attr(struct perf_tool *tool,
 	size += sizeof(struct perf_event_header);
 	size += ids * sizeof(u64);
 
-	ev = malloc(size);
+	ev = zalloc(size);
 
 	if (ev == NULL)
 		return -ENOMEM;

