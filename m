Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E55C606A8
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F9B20651
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbfGHJXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 05:23:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38849 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729152AbfGHJWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 05:22:46 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hkPr5-0004pL-2c; Mon, 08 Jul 2019 11:22:39 +0200
Date:   Mon, 08 Jul 2019 09:05:37 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/cpu for 5.3-rc1
References: <156257673794.14831.1593297636367057887.tglx@nanos.tec.linutronix.de>
Message-ID: <156257673796.14831.10023086664920231810.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-cpu-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cpu-for-linus

up to:  049331f277fe: x86/fsgsbase: Revert FSGSBASE support

Updates for x86 CPU features:

  - Support for UMWAIT/UMONITOR, which allows to use MWAIT and MONITOR
    instructions in user space to save power e.g. in HPC workloads which
    spin wait on synchronization points.

    The maximum time a MWAIT can halt in userspace is controlled by the
    kernel and can be adjusted by the sysadmin.

  - Speed up the MTRR handling code on CPUs which support cache
    self-snooping correctly.

    On those CPUs the wbinvd() invocations can be omitted which speeds up
    the MTRR setup by a factor of 50.

  - Support for the new x86 vendor Zhaoxin who develops processors based on
    the VIA Centaur technology.

  - Prevent 'cat /proc/cpuinfo' from affecting isolated NOHZ_FULL CPUs by
    sending IPIs to retrieve the CPU frequency and use the cached values
    instead.

  - The addition and late revert of the FSGSBASE support. The revert was
    required as it turned out that the code still has hard to diagnose
    issues. Yet another engineering trainwreck...

  - Small fixes, cleanups, improvements and the usual new Intel CPU
    family/model addons.

Thanks,

	tglx

------------------>
Aaron Lewis (1):
      x86/cpufeatures: Add FDP_EXCPTN_ONLY and ZERO_FCS_FDS

Andi Kleen (2):
      x86/fsgsbase/64: Add intrinsics for FSGSBASE instructions
      x86/elf: Enumerate kernel FSGSBASE capability in AT_HWCAP2

Andy Lutomirski (8):
      x86/cpu: Add 'unsafe_fsgsbase' to enable CR4.FSGSBASE
      x86/process/64: Use FSBSBASE in switch_to() if available
      selftests/x86/fsgsbase: Test RD/WRGSBASE
      x86/cpu: Enable FSGSBASE on 64bit by default and add a chicken bit
      selftests/x86: Test SYSCALL and SYSENTER manually with TF set
      x86/entry/64: Don't compile ignore_sysret if 32-bit emulation is enabled
      x86/entry/64: Fix and clean up paranoid_exit
      selftests/x86/fsgsbase: Fix some test case bugs

Andy Shevchenko (1):
      x86/cpu: Split Tremont based Atoms from the rest

Borislav Petkov (1):
      x86/cpufeatures: Carve out CQM features retrieval

Chang S. Bae (10):
      x86/ptrace: Prevent ptrace from clearing the FS/GS selector
      selftests/x86/fsgsbase: Test ptracer-induced GSBASE write
      kbuild: Raise the minimum required binutils version to 2.21
      x86/fsgsbase/64: Enable FSGSBASE instructions in helper functions
      x86/process/64: Use FSGSBASE instructions on thread copy and ptrace
      x86/entry/64: Switch CR3 before SWAPGS in paranoid entry
      x86/entry/64: Introduce the FIND_PERCPU_BASE macro
      x86/entry/64: Handle FSGSBASE enabled paranoid entry/exit
      x86/entry/64: Document GSBASE handling in the paranoid path
      selftests/x86/fsgsbase: Test ptracer-induced GSBASE write with FSGSBASE

Fenghua Yu (7):
      x86/cpufeatures: Combine word 11 and 12 into a new scattered features word
      x86/cpufeatures: Enumerate the new AVX512 BFLOAT16 instructions
      x86/cpufeatures: Enumerate user wait instructions
      x86/umwait: Initialize umwait control values
      x86/umwait: Add sysfs interface to control umwait C0.2 state
      x86/umwait: Add sysfs interface to control umwait maximum time
      Documentation/ABI: Document umwait control sysfs interfaces

Konstantin Khlebnikov (1):
      x86/cpu: Disable frequency requests via aperfmperf IPI for nohz_full CPUs

Qian Cai (1):
      x86/cacheinfo: Fix a -Wtype-limits warning

Rajneesh Bhardwaj (2):
      x86/cpu: Add Ice Lake NNPI to Intel family
      perf/x86: Add Intel Ice Lake NNPI uncore support

Ricardo Neri (2):
      x86/cpu/intel: Clear cache self-snoop capability in CPUs with known errata
      x86/mtrr: Skip cache flushes on CPUs with cache self-snooping

Thomas Gleixner (2):
      Documentation/x86/64: Add documentation for GS/FS addressing mode
      x86/fsgsbase: Revert FSGSBASE support

Tony W Wang-oc (3):
      x86/cpu: Create Zhaoxin processors architecture support file
      ACPI, x86: Add Zhaoxin processors support for NONSTOP TSC
      x86/acpi/cstate: Add Zhaoxin processors support for cache flush policy in C3


 Documentation/ABI/testing/sysfs-devices-system-cpu |  23 +++
 Documentation/process/changes.rst                  |   6 +-
 MAINTAINERS                                        |   6 +
 arch/x86/Kconfig.cpu                               |  13 ++
 arch/x86/entry/entry_64.S                          |   6 +
 arch/x86/events/intel/uncore.c                     |   1 +
 arch/x86/include/asm/cpufeature.h                  |   4 +-
 arch/x86/include/asm/cpufeatures.h                 |  21 +-
 arch/x86/include/asm/intel-family.h                |   2 +
 arch/x86/include/asm/msr-index.h                   |   9 +
 arch/x86/include/asm/processor.h                   |   3 +-
 arch/x86/kernel/acpi/cstate.c                      |  15 ++
 arch/x86/kernel/cpu/Makefile                       |   2 +
 arch/x86/kernel/cpu/aperfmperf.c                   |  12 +-
 arch/x86/kernel/cpu/cacheinfo.c                    |   3 +-
 arch/x86/kernel/cpu/common.c                       |  58 +++---
 arch/x86/kernel/cpu/cpuid-deps.c                   |   4 +
 arch/x86/kernel/cpu/intel.c                        |  27 +++
 arch/x86/kernel/cpu/mtrr/generic.c                 |  15 +-
 arch/x86/kernel/cpu/scattered.c                    |   4 +
 arch/x86/kernel/cpu/umwait.c                       | 200 ++++++++++++++++++
 arch/x86/kernel/cpu/zhaoxin.c                      | 167 +++++++++++++++
 arch/x86/kernel/ptrace.c                           |  14 +-
 arch/x86/kvm/cpuid.h                               |   2 -
 drivers/acpi/acpi_pad.c                            |   1 +
 drivers/acpi/processor_idle.c                      |   1 +
 tools/testing/selftests/x86/Makefile               |   5 +-
 tools/testing/selftests/x86/fsgsbase.c             | 223 +++++++++++++++++++--
 tools/testing/selftests/x86/syscall_arg_fault.c    | 112 ++++++++++-
 29 files changed, 871 insertions(+), 88 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/umwait.c
 create mode 100644 arch/x86/kernel/cpu/zhaoxin.c

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 1528239f69b2..923fe2001472 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -538,3 +538,26 @@ Description:	Intel Energy and Performance Bias Hint (EPB)
 
 		This attribute is present for all online CPUs supporting the
 		Intel EPB feature.
+
+What:		/sys/devices/system/cpu/umwait_control
+		/sys/devices/system/cpu/umwait_control/enable_c02
+		/sys/devices/system/cpu/umwait_control/max_time
+Date:		May 2019
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:	Umwait control
+
+		enable_c02: Read/write interface to control umwait C0.2 state
+			Read returns C0.2 state status:
+				0: C0.2 is disabled
+				1: C0.2 is enabled
+
+			Write 'y' or '1'  or 'on' to enable C0.2 state.
+			Write 'n' or '0'  or 'off' to disable C0.2 state.
+
+			The interface is case insensitive.
+
+		max_time: Read/write interface to control umwait maximum time
+			  in TSC-quanta that the CPU can reside in either C0.1
+			  or C0.2 state. The time is an unsigned 32-bit number.
+			  Note that a value of zero means there is no limit.
+			  Low order two bits must be zero.
diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index 18735dc460a0..0a18075c485e 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -31,7 +31,7 @@ you probably needn't concern yourself with isdn4k-utils.
 ====================== ===============  ========================================
 GNU C                  4.6              gcc --version
 GNU make               3.81             make --version
-binutils               2.20             ld -v
+binutils               2.21             ld -v
 flex                   2.5.35           flex --version
 bison                  2.0              bison --version
 util-linux             2.10o            fdformat --version
@@ -77,9 +77,7 @@ You will need GNU make 3.81 or later to build the kernel.
 Binutils
 --------
 
-The build system has, as of 4.13, switched to using thin archives (`ar T`)
-rather than incremental linking (`ld -r`) for built-in.a intermediate steps.
-This requires binutils 2.20 or newer.
+Binutils 2.21 or newer is needed to build the kernel.
 
 pkg-config
 ----------
diff --git a/MAINTAINERS b/MAINTAINERS
index 57f496cff999..dfdefc6cb3a2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17477,6 +17477,12 @@ Q:	https://patchwork.linuxtv.org/project/linux-media/list/
 S:	Maintained
 F:	drivers/media/dvb-frontends/zd1301_demod*
 
+ZHAOXIN PROCESSOR SUPPORT
+M:	Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	arch/x86/kernel/cpu/zhaoxin.c
+
 ZPOOL COMPRESSED PAGE STORAGE API
 M:	Dan Streetman <ddstreet@ieee.org>
 L:	linux-mm@kvack.org
diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 6adce15268bd..8e29c991ba3e 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -480,3 +480,16 @@ config CPU_SUP_UMC_32
 	  CPU might render the kernel unbootable.
 
 	  If unsure, say N.
+
+config CPU_SUP_ZHAOXIN
+	default y
+	bool "Support Zhaoxin processors" if PROCESSOR_SELECT
+	help
+	  This enables detection, tunings and quirks for Zhaoxin processors
+
+	  You need this enabled if you want your kernel to run on a
+	  Zhaoxin CPU. Disabling this option on other types of CPUs
+	  makes the kernel a tiny bit smaller. Disabling it on a Zhaoxin
+	  CPU might render the kernel unbootable.
+
+	  If unsure, say N.
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 11aa3b2afa4d..3b7a0e8d3bc0 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1670,11 +1670,17 @@ nmi_restore:
 	iretq
 END(nmi)
 
+#ifndef CONFIG_IA32_EMULATION
+/*
+ * This handles SYSCALL from 32-bit code.  There is no way to program
+ * MSRs to fully disable 32-bit SYSCALL.
+ */
 ENTRY(ignore_sysret)
 	UNWIND_HINT_EMPTY
 	mov	$-ENOSYS, %eax
 	sysret
 END(ignore_sysret)
+#endif
 
 ENTRY(rewind_stack_do_exit)
 	UNWIND_HINT_FUNC
diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 9e3fbd47cb56..089bfcdf2f7f 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1400,6 +1400,7 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_KABYLAKE_MOBILE, skl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_KABYLAKE_DESKTOP, skl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_MOBILE, icl_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_NNPI, icl_uncore_init),
 	{},
 };
 
diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 1d337c51f7e6..58acda503817 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -22,8 +22,8 @@ enum cpuid_leafs
 	CPUID_LNX_3,
 	CPUID_7_0_EBX,
 	CPUID_D_1_EAX,
-	CPUID_F_0_EDX,
-	CPUID_F_1_EDX,
+	CPUID_LNX_4,
+	CPUID_7_1_EAX,
 	CPUID_8000_0008_EBX,
 	CPUID_6_EAX,
 	CPUID_8000_000A_EDX,
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 75f27ee2c263..998c2cc08363 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -239,12 +239,14 @@
 #define X86_FEATURE_BMI1		( 9*32+ 3) /* 1st group bit manipulation extensions */
 #define X86_FEATURE_HLE			( 9*32+ 4) /* Hardware Lock Elision */
 #define X86_FEATURE_AVX2		( 9*32+ 5) /* AVX2 instructions */
+#define X86_FEATURE_FDP_EXCPTN_ONLY	( 9*32+ 6) /* "" FPU data pointer updated only on x87 exceptions */
 #define X86_FEATURE_SMEP		( 9*32+ 7) /* Supervisor Mode Execution Protection */
 #define X86_FEATURE_BMI2		( 9*32+ 8) /* 2nd group bit manipulation extensions */
 #define X86_FEATURE_ERMS		( 9*32+ 9) /* Enhanced REP MOVSB/STOSB instructions */
 #define X86_FEATURE_INVPCID		( 9*32+10) /* Invalidate Processor Context ID */
 #define X86_FEATURE_RTM			( 9*32+11) /* Restricted Transactional Memory */
 #define X86_FEATURE_CQM			( 9*32+12) /* Cache QoS Monitoring */
+#define X86_FEATURE_ZERO_FCS_FDS	( 9*32+13) /* "" Zero out FPU CS and FPU DS */
 #define X86_FEATURE_MPX			( 9*32+14) /* Memory Protection Extension */
 #define X86_FEATURE_RDT_A		( 9*32+15) /* Resource Director Technology Allocation */
 #define X86_FEATURE_AVX512F		( 9*32+16) /* AVX-512 Foundation */
@@ -269,13 +271,19 @@
 #define X86_FEATURE_XGETBV1		(10*32+ 2) /* XGETBV with ECX = 1 instruction */
 #define X86_FEATURE_XSAVES		(10*32+ 3) /* XSAVES/XRSTORS instructions */
 
-/* Intel-defined CPU QoS Sub-leaf, CPUID level 0x0000000F:0 (EDX), word 11 */
-#define X86_FEATURE_CQM_LLC		(11*32+ 1) /* LLC QoS if 1 */
+/*
+ * Extended auxiliary flags: Linux defined - for features scattered in various
+ * CPUID levels like 0xf, etc.
+ *
+ * Reuse free bits when adding new feature flags!
+ */
+#define X86_FEATURE_CQM_LLC		(11*32+ 0) /* LLC QoS if 1 */
+#define X86_FEATURE_CQM_OCCUP_LLC	(11*32+ 1) /* LLC occupancy monitoring */
+#define X86_FEATURE_CQM_MBM_TOTAL	(11*32+ 2) /* LLC Total MBM monitoring */
+#define X86_FEATURE_CQM_MBM_LOCAL	(11*32+ 3) /* LLC Local MBM monitoring */
 
-/* Intel-defined CPU QoS Sub-leaf, CPUID level 0x0000000F:1 (EDX), word 12 */
-#define X86_FEATURE_CQM_OCCUP_LLC	(12*32+ 0) /* LLC occupancy monitoring */
-#define X86_FEATURE_CQM_MBM_TOTAL	(12*32+ 1) /* LLC Total MBM monitoring */
-#define X86_FEATURE_CQM_MBM_LOCAL	(12*32+ 2) /* LLC Local MBM monitoring */
+/* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
+#define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
 
 /* AMD-defined CPU features, CPUID level 0x80000008 (EBX), word 13 */
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* CLZERO instruction */
@@ -322,6 +330,7 @@
 #define X86_FEATURE_UMIP		(16*32+ 2) /* User Mode Instruction Protection */
 #define X86_FEATURE_PKU			(16*32+ 3) /* Protection Keys for Userspace */
 #define X86_FEATURE_OSPKE		(16*32+ 4) /* OS Protection Keys Enable */
+#define X86_FEATURE_WAITPKG		(16*32+ 5) /* UMONITOR/UMWAIT/TPAUSE Instructions */
 #define X86_FEATURE_AVX512_VBMI2	(16*32+ 6) /* Additional AVX512 Vector Bit Manipulation Instructions */
 #define X86_FEATURE_GFNI		(16*32+ 8) /* Galois Field New Instructions */
 #define X86_FEATURE_VAES		(16*32+ 9) /* Vector AES */
diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 9f15384c504a..c92a367a4a7a 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -53,6 +53,7 @@
 #define INTEL_FAM6_CANNONLAKE_MOBILE	0x66
 
 #define INTEL_FAM6_ICELAKE_MOBILE	0x7E
+#define INTEL_FAM6_ICELAKE_NNPI		0x9D
 
 /* "Small Core" Processors (Atom) */
 
@@ -73,6 +74,7 @@
 #define INTEL_FAM6_ATOM_GOLDMONT	0x5C /* Apollo Lake */
 #define INTEL_FAM6_ATOM_GOLDMONT_X	0x5F /* Denverton */
 #define INTEL_FAM6_ATOM_GOLDMONT_PLUS	0x7A /* Gemini Lake */
+
 #define INTEL_FAM6_ATOM_TREMONT_X	0x86 /* Jacobsville */
 
 /* Xeon Phi */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 979ef971cc78..6b4fc2788078 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -61,6 +61,15 @@
 #define MSR_PLATFORM_INFO_CPUID_FAULT_BIT	31
 #define MSR_PLATFORM_INFO_CPUID_FAULT		BIT_ULL(MSR_PLATFORM_INFO_CPUID_FAULT_BIT)
 
+#define MSR_IA32_UMWAIT_CONTROL			0xe1
+#define MSR_IA32_UMWAIT_CONTROL_C02_DISABLE	BIT(0)
+#define MSR_IA32_UMWAIT_CONTROL_RESERVED	BIT(1)
+/*
+ * The time field is bit[31:2], but representing a 32bit value with
+ * bit[1:0] zero.
+ */
+#define MSR_IA32_UMWAIT_CONTROL_TIME_MASK	(~0x03U)
+
 #define MSR_PKG_CST_CONFIG_CONTROL	0x000000e2
 #define NHM_C3_AUTO_DEMOTE		(1UL << 25)
 #define NHM_C1_AUTO_DEMOTE		(1UL << 26)
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index c34a35c78618..e57d2ca2ed87 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -144,7 +144,8 @@ enum cpuid_regs_idx {
 #define X86_VENDOR_TRANSMETA	7
 #define X86_VENDOR_NSC		8
 #define X86_VENDOR_HYGON	9
-#define X86_VENDOR_NUM		10
+#define X86_VENDOR_ZHAOXIN	10
+#define X86_VENDOR_NUM		11
 
 #define X86_VENDOR_UNKNOWN	0xff
 
diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index a5e5484988fd..caf2edccbad2 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -64,6 +64,21 @@ void acpi_processor_power_init_bm_check(struct acpi_processor_flags *flags,
 		    c->x86_stepping >= 0x0e))
 			flags->bm_check = 1;
 	}
+
+	if (c->x86_vendor == X86_VENDOR_ZHAOXIN) {
+		/*
+		 * All Zhaoxin CPUs that support C3 share cache.
+		 * And caches should not be flushed by software while
+		 * entering C3 type state.
+		 */
+		flags->bm_check = 1;
+		/*
+		 * On all recent Zhaoxin platforms, ARB_DISABLE is a nop.
+		 * So, set bm_control to zero to indicate that ARB_DISABLE
+		 * is not required while entering C3 type state.
+		 */
+		flags->bm_control = 0;
+	}
 }
 EXPORT_SYMBOL(acpi_processor_power_init_bm_check);
 
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 5102bf7c8192..4b4eb06e117c 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -24,6 +24,7 @@ obj-y			+= match.o
 obj-y			+= bugs.o
 obj-y			+= aperfmperf.o
 obj-y			+= cpuid-deps.o
+obj-y			+= umwait.o
 
 obj-$(CONFIG_PROC_FS)	+= proc.o
 obj-$(CONFIG_X86_FEATURE_NAMES) += capflags.o powerflags.o
@@ -38,6 +39,7 @@ obj-$(CONFIG_CPU_SUP_CYRIX_32)		+= cyrix.o
 obj-$(CONFIG_CPU_SUP_CENTAUR)		+= centaur.o
 obj-$(CONFIG_CPU_SUP_TRANSMETA_32)	+= transmeta.o
 obj-$(CONFIG_CPU_SUP_UMC_32)		+= umc.o
+obj-$(CONFIG_CPU_SUP_ZHAOXIN)		+= zhaoxin.o
 
 obj-$(CONFIG_X86_MCE)			+= mce/
 obj-$(CONFIG_MTRR)			+= mtrr/
diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index e71a6ff8a67e..e2f319dc992d 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -13,6 +13,7 @@
 #include <linux/percpu.h>
 #include <linux/cpufreq.h>
 #include <linux/smp.h>
+#include <linux/sched/isolation.h>
 
 #include "cpu.h"
 
@@ -85,6 +86,9 @@ unsigned int aperfmperf_get_khz(int cpu)
 	if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
 		return 0;
 
+	if (!housekeeping_cpu(cpu, HK_FLAG_MISC))
+		return 0;
+
 	aperfmperf_snapshot_cpu(cpu, ktime_get(), true);
 	return per_cpu(samples.khz, cpu);
 }
@@ -101,9 +105,12 @@ void arch_freq_prepare_all(void)
 	if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
 		return;
 
-	for_each_online_cpu(cpu)
+	for_each_online_cpu(cpu) {
+		if (!housekeeping_cpu(cpu, HK_FLAG_MISC))
+			continue;
 		if (!aperfmperf_snapshot_cpu(cpu, now, false))
 			wait = true;
+	}
 
 	if (wait)
 		msleep(APERFMPERF_REFRESH_DELAY_MS);
@@ -117,6 +124,9 @@ unsigned int arch_freq_get_on_cpu(int cpu)
 	if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
 		return 0;
 
+	if (!housekeeping_cpu(cpu, HK_FLAG_MISC))
+		return 0;
+
 	if (aperfmperf_snapshot_cpu(cpu, ktime_get(), true))
 		return per_cpu(samples.khz, cpu);
 
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 395d46f78582..c7503be92f35 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -658,8 +658,7 @@ void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu, u8 node_id)
 	if (c->x86 < 0x17) {
 		/* LLC is at the node level. */
 		per_cpu(cpu_llc_id, cpu) = node_id;
-	} else if (c->x86 == 0x17 &&
-		   c->x86_model >= 0 && c->x86_model <= 0x1F) {
+	} else if (c->x86 == 0x17 && c->x86_model <= 0x1F) {
 		/*
 		 * LLC is at the core complex level.
 		 * Core complex ID is ApicId[3] for these processors.
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 2c57fffebf9b..dad20bc891d5 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -801,6 +801,30 @@ static void init_speculation_control(struct cpuinfo_x86 *c)
 	}
 }
 
+static void init_cqm(struct cpuinfo_x86 *c)
+{
+	if (!cpu_has(c, X86_FEATURE_CQM_LLC)) {
+		c->x86_cache_max_rmid  = -1;
+		c->x86_cache_occ_scale = -1;
+		return;
+	}
+
+	/* will be overridden if occupancy monitoring exists */
+	c->x86_cache_max_rmid = cpuid_ebx(0xf);
+
+	if (cpu_has(c, X86_FEATURE_CQM_OCCUP_LLC) ||
+	    cpu_has(c, X86_FEATURE_CQM_MBM_TOTAL) ||
+	    cpu_has(c, X86_FEATURE_CQM_MBM_LOCAL)) {
+		u32 eax, ebx, ecx, edx;
+
+		/* QoS sub-leaf, EAX=0Fh, ECX=1 */
+		cpuid_count(0xf, 1, &eax, &ebx, &ecx, &edx);
+
+		c->x86_cache_max_rmid  = ecx;
+		c->x86_cache_occ_scale = ebx;
+	}
+}
+
 void get_cpu_cap(struct cpuinfo_x86 *c)
 {
 	u32 eax, ebx, ecx, edx;
@@ -823,6 +847,12 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 		c->x86_capability[CPUID_7_0_EBX] = ebx;
 		c->x86_capability[CPUID_7_ECX] = ecx;
 		c->x86_capability[CPUID_7_EDX] = edx;
+
+		/* Check valid sub-leaf index before accessing it */
+		if (eax >= 1) {
+			cpuid_count(0x00000007, 1, &eax, &ebx, &ecx, &edx);
+			c->x86_capability[CPUID_7_1_EAX] = eax;
+		}
 	}
 
 	/* Extended state features: level 0x0000000d */
@@ -832,33 +862,6 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 		c->x86_capability[CPUID_D_1_EAX] = eax;
 	}
 
-	/* Additional Intel-defined flags: level 0x0000000F */
-	if (c->cpuid_level >= 0x0000000F) {
-
-		/* QoS sub-leaf, EAX=0Fh, ECX=0 */
-		cpuid_count(0x0000000F, 0, &eax, &ebx, &ecx, &edx);
-		c->x86_capability[CPUID_F_0_EDX] = edx;
-
-		if (cpu_has(c, X86_FEATURE_CQM_LLC)) {
-			/* will be overridden if occupancy monitoring exists */
-			c->x86_cache_max_rmid = ebx;
-
-			/* QoS sub-leaf, EAX=0Fh, ECX=1 */
-			cpuid_count(0x0000000F, 1, &eax, &ebx, &ecx, &edx);
-			c->x86_capability[CPUID_F_1_EDX] = edx;
-
-			if ((cpu_has(c, X86_FEATURE_CQM_OCCUP_LLC)) ||
-			      ((cpu_has(c, X86_FEATURE_CQM_MBM_TOTAL)) ||
-			       (cpu_has(c, X86_FEATURE_CQM_MBM_LOCAL)))) {
-				c->x86_cache_max_rmid = ecx;
-				c->x86_cache_occ_scale = ebx;
-			}
-		} else {
-			c->x86_cache_max_rmid = -1;
-			c->x86_cache_occ_scale = -1;
-		}
-	}
-
 	/* AMD-defined flags: level 0x80000001 */
 	eax = cpuid_eax(0x80000000);
 	c->extended_cpuid_level = eax;
@@ -889,6 +892,7 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 
 	init_scattered_cpuid_features(c);
 	init_speculation_control(c);
+	init_cqm(c);
 
 	/*
 	 * Clear/Set all flags overridden by options, after probe.
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index 2c0bd38a44ab..a444028d8145 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -59,6 +59,10 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_AVX512_4VNNIW,	X86_FEATURE_AVX512F   },
 	{ X86_FEATURE_AVX512_4FMAPS,	X86_FEATURE_AVX512F   },
 	{ X86_FEATURE_AVX512_VPOPCNTDQ, X86_FEATURE_AVX512F   },
+	{ X86_FEATURE_CQM_OCCUP_LLC,	X86_FEATURE_CQM_LLC   },
+	{ X86_FEATURE_CQM_MBM_TOTAL,	X86_FEATURE_CQM_LLC   },
+	{ X86_FEATURE_CQM_MBM_LOCAL,	X86_FEATURE_CQM_LLC   },
+	{ X86_FEATURE_AVX512_BF16,	X86_FEATURE_AVX512VL  },
 	{}
 };
 
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index f17c1a714779..8d6d92ebeb54 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -66,6 +66,32 @@ void check_mpx_erratum(struct cpuinfo_x86 *c)
 	}
 }
 
+/*
+ * Processors which have self-snooping capability can handle conflicting
+ * memory type across CPUs by snooping its own cache. However, there exists
+ * CPU models in which having conflicting memory types still leads to
+ * unpredictable behavior, machine check errors, or hangs. Clear this
+ * feature to prevent its use on machines with known erratas.
+ */
+static void check_memory_type_self_snoop_errata(struct cpuinfo_x86 *c)
+{
+	switch (c->x86_model) {
+	case INTEL_FAM6_CORE_YONAH:
+	case INTEL_FAM6_CORE2_MEROM:
+	case INTEL_FAM6_CORE2_MEROM_L:
+	case INTEL_FAM6_CORE2_PENRYN:
+	case INTEL_FAM6_CORE2_DUNNINGTON:
+	case INTEL_FAM6_NEHALEM:
+	case INTEL_FAM6_NEHALEM_G:
+	case INTEL_FAM6_NEHALEM_EP:
+	case INTEL_FAM6_NEHALEM_EX:
+	case INTEL_FAM6_WESTMERE:
+	case INTEL_FAM6_WESTMERE_EP:
+	case INTEL_FAM6_SANDYBRIDGE:
+		setup_clear_cpu_cap(X86_FEATURE_SELFSNOOP);
+	}
+}
+
 static bool ring3mwait_disabled __read_mostly;
 
 static int __init ring3mwait_disable(char *__unused)
@@ -304,6 +330,7 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 	}
 
 	check_mpx_erratum(c);
+	check_memory_type_self_snoop_errata(c);
 
 	/*
 	 * Get the number of SMT siblings early from the extended topology
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 9356c1c9024d..aa5c064a6a22 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -743,7 +743,15 @@ static void prepare_set(void) __acquires(set_atomicity_lock)
 	/* Enter the no-fill (CD=1, NW=0) cache mode and flush caches. */
 	cr0 = read_cr0() | X86_CR0_CD;
 	write_cr0(cr0);
-	wbinvd();
+
+	/*
+	 * Cache flushing is the most time-consuming step when programming
+	 * the MTRRs. Fortunately, as per the Intel Software Development
+	 * Manual, we can skip it if the processor supports cache self-
+	 * snooping.
+	 */
+	if (!static_cpu_has(X86_FEATURE_SELFSNOOP))
+		wbinvd();
 
 	/* Save value of CR4 and clear Page Global Enable (bit 7) */
 	if (boot_cpu_has(X86_FEATURE_PGE)) {
@@ -760,7 +768,10 @@ static void prepare_set(void) __acquires(set_atomicity_lock)
 
 	/* Disable MTRRs, and set the default type to uncached */
 	mtrr_wrmsr(MSR_MTRRdefType, deftype_lo & ~0xcff, deftype_hi);
-	wbinvd();
+
+	/* Again, only flush caches if we have to. */
+	if (!static_cpu_has(X86_FEATURE_SELFSNOOP))
+		wbinvd();
 }
 
 static void post_set(void) __releases(set_atomicity_lock)
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 94aa1c72ca98..adf9b71386ef 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -26,6 +26,10 @@ struct cpuid_bit {
 static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_APERFMPERF,       CPUID_ECX,  0, 0x00000006, 0 },
 	{ X86_FEATURE_EPB,		CPUID_ECX,  3, 0x00000006, 0 },
+	{ X86_FEATURE_CQM_LLC,		CPUID_EDX,  1, 0x0000000f, 0 },
+	{ X86_FEATURE_CQM_OCCUP_LLC,	CPUID_EDX,  0, 0x0000000f, 1 },
+	{ X86_FEATURE_CQM_MBM_TOTAL,	CPUID_EDX,  1, 0x0000000f, 1 },
+	{ X86_FEATURE_CQM_MBM_LOCAL,	CPUID_EDX,  2, 0x0000000f, 1 },
 	{ X86_FEATURE_CAT_L3,		CPUID_EBX,  1, 0x00000010, 0 },
 	{ X86_FEATURE_CAT_L2,		CPUID_EBX,  2, 0x00000010, 0 },
 	{ X86_FEATURE_CDP_L3,		CPUID_ECX,  2, 0x00000010, 1 },
diff --git a/arch/x86/kernel/cpu/umwait.c b/arch/x86/kernel/cpu/umwait.c
new file mode 100644
index 000000000000..6a204e7336c1
--- /dev/null
+++ b/arch/x86/kernel/cpu/umwait.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/syscore_ops.h>
+#include <linux/suspend.h>
+#include <linux/cpu.h>
+
+#include <asm/msr.h>
+
+#define UMWAIT_C02_ENABLE	0
+
+#define UMWAIT_CTRL_VAL(max_time, c02_disable)				\
+	(((max_time) & MSR_IA32_UMWAIT_CONTROL_TIME_MASK) |		\
+	((c02_disable) & MSR_IA32_UMWAIT_CONTROL_C02_DISABLE))
+
+/*
+ * Cache IA32_UMWAIT_CONTROL MSR. This is a systemwide control. By default,
+ * umwait max time is 100000 in TSC-quanta and C0.2 is enabled
+ */
+static u32 umwait_control_cached = UMWAIT_CTRL_VAL(100000, UMWAIT_C02_ENABLE);
+
+/*
+ * Serialize access to umwait_control_cached and IA32_UMWAIT_CONTROL MSR in
+ * the sysfs write functions.
+ */
+static DEFINE_MUTEX(umwait_lock);
+
+static void umwait_update_control_msr(void * unused)
+{
+	lockdep_assert_irqs_disabled();
+	wrmsr(MSR_IA32_UMWAIT_CONTROL, READ_ONCE(umwait_control_cached), 0);
+}
+
+/*
+ * The CPU hotplug callback sets the control MSR to the global control
+ * value.
+ *
+ * Disable interrupts so the read of umwait_control_cached and the WRMSR
+ * are protected against a concurrent sysfs write. Otherwise the sysfs
+ * write could update the cached value after it had been read on this CPU
+ * and issue the IPI before the old value had been written. The IPI would
+ * interrupt, write the new value and after return from IPI the previous
+ * value would be written by this CPU.
+ *
+ * With interrupts disabled the upcoming CPU either sees the new control
+ * value or the IPI is updating this CPU to the new control value after
+ * interrupts have been reenabled.
+ */
+static int umwait_cpu_online(unsigned int cpu)
+{
+	local_irq_disable();
+	umwait_update_control_msr(NULL);
+	local_irq_enable();
+	return 0;
+}
+
+/*
+ * On resume, restore IA32_UMWAIT_CONTROL MSR on the boot processor which
+ * is the only active CPU at this time. The MSR is set up on the APs via the
+ * CPU hotplug callback.
+ *
+ * This function is invoked on resume from suspend and hibernation. On
+ * resume from suspend the restore should be not required, but we neither
+ * trust the firmware nor does it matter if the same value is written
+ * again.
+ */
+static void umwait_syscore_resume(void)
+{
+	umwait_update_control_msr(NULL);
+}
+
+static struct syscore_ops umwait_syscore_ops = {
+	.resume	= umwait_syscore_resume,
+};
+
+/* sysfs interface */
+
+/*
+ * When bit 0 in IA32_UMWAIT_CONTROL MSR is 1, C0.2 is disabled.
+ * Otherwise, C0.2 is enabled.
+ */
+static inline bool umwait_ctrl_c02_enabled(u32 ctrl)
+{
+	return !(ctrl & MSR_IA32_UMWAIT_CONTROL_C02_DISABLE);
+}
+
+static inline u32 umwait_ctrl_max_time(u32 ctrl)
+{
+	return ctrl & MSR_IA32_UMWAIT_CONTROL_TIME_MASK;
+}
+
+static inline void umwait_update_control(u32 maxtime, bool c02_enable)
+{
+	u32 ctrl = maxtime & MSR_IA32_UMWAIT_CONTROL_TIME_MASK;
+
+	if (!c02_enable)
+		ctrl |= MSR_IA32_UMWAIT_CONTROL_C02_DISABLE;
+
+	WRITE_ONCE(umwait_control_cached, ctrl);
+	/* Propagate to all CPUs */
+	on_each_cpu(umwait_update_control_msr, NULL, 1);
+}
+
+static ssize_t
+enable_c02_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	u32 ctrl = READ_ONCE(umwait_control_cached);
+
+	return sprintf(buf, "%d\n", umwait_ctrl_c02_enabled(ctrl));
+}
+
+static ssize_t enable_c02_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	bool c02_enable;
+	u32 ctrl;
+	int ret;
+
+	ret = kstrtobool(buf, &c02_enable);
+	if (ret)
+		return ret;
+
+	mutex_lock(&umwait_lock);
+
+	ctrl = READ_ONCE(umwait_control_cached);
+	if (c02_enable != umwait_ctrl_c02_enabled(ctrl))
+		umwait_update_control(ctrl, c02_enable);
+
+	mutex_unlock(&umwait_lock);
+
+	return count;
+}
+static DEVICE_ATTR_RW(enable_c02);
+
+static ssize_t
+max_time_show(struct device *kobj, struct device_attribute *attr, char *buf)
+{
+	u32 ctrl = READ_ONCE(umwait_control_cached);
+
+	return sprintf(buf, "%u\n", umwait_ctrl_max_time(ctrl));
+}
+
+static ssize_t max_time_store(struct device *kobj,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	u32 max_time, ctrl;
+	int ret;
+
+	ret = kstrtou32(buf, 0, &max_time);
+	if (ret)
+		return ret;
+
+	/* bits[1:0] must be zero */
+	if (max_time & ~MSR_IA32_UMWAIT_CONTROL_TIME_MASK)
+		return -EINVAL;
+
+	mutex_lock(&umwait_lock);
+
+	ctrl = READ_ONCE(umwait_control_cached);
+	if (max_time != umwait_ctrl_max_time(ctrl))
+		umwait_update_control(max_time, umwait_ctrl_c02_enabled(ctrl));
+
+	mutex_unlock(&umwait_lock);
+
+	return count;
+}
+static DEVICE_ATTR_RW(max_time);
+
+static struct attribute *umwait_attrs[] = {
+	&dev_attr_enable_c02.attr,
+	&dev_attr_max_time.attr,
+	NULL
+};
+
+static struct attribute_group umwait_attr_group = {
+	.attrs = umwait_attrs,
+	.name = "umwait_control",
+};
+
+static int __init umwait_init(void)
+{
+	struct device *dev;
+	int ret;
+
+	if (!boot_cpu_has(X86_FEATURE_WAITPKG))
+		return -ENODEV;
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "umwait:online",
+				umwait_cpu_online, NULL);
+
+	register_syscore_ops(&umwait_syscore_ops);
+
+	/*
+	 * Add umwait control interface. Ignore failure, so at least the
+	 * default values are set up in case the machine manages to boot.
+	 */
+	dev = cpu_subsys.dev_root;
+	return sysfs_create_group(&dev->kobj, &umwait_attr_group);
+}
+device_initcall(umwait_init);
diff --git a/arch/x86/kernel/cpu/zhaoxin.c b/arch/x86/kernel/cpu/zhaoxin.c
new file mode 100644
index 000000000000..8e6f2f4b4afe
--- /dev/null
+++ b/arch/x86/kernel/cpu/zhaoxin.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/sched.h>
+#include <linux/sched/clock.h>
+
+#include <asm/cpufeature.h>
+
+#include "cpu.h"
+
+#define MSR_ZHAOXIN_FCR57 0x00001257
+
+#define ACE_PRESENT	(1 << 6)
+#define ACE_ENABLED	(1 << 7)
+#define ACE_FCR		(1 << 7)	/* MSR_ZHAOXIN_FCR */
+
+#define RNG_PRESENT	(1 << 2)
+#define RNG_ENABLED	(1 << 3)
+#define RNG_ENABLE	(1 << 8)	/* MSR_ZHAOXIN_RNG */
+
+#define X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW	0x00200000
+#define X86_VMX_FEATURE_PROC_CTLS_VNMI		0x00400000
+#define X86_VMX_FEATURE_PROC_CTLS_2ND_CTLS	0x80000000
+#define X86_VMX_FEATURE_PROC_CTLS2_VIRT_APIC	0x00000001
+#define X86_VMX_FEATURE_PROC_CTLS2_EPT		0x00000002
+#define X86_VMX_FEATURE_PROC_CTLS2_VPID		0x00000020
+
+static void init_zhaoxin_cap(struct cpuinfo_x86 *c)
+{
+	u32  lo, hi;
+
+	/* Test for Extended Feature Flags presence */
+	if (cpuid_eax(0xC0000000) >= 0xC0000001) {
+		u32 tmp = cpuid_edx(0xC0000001);
+
+		/* Enable ACE unit, if present and disabled */
+		if ((tmp & (ACE_PRESENT | ACE_ENABLED)) == ACE_PRESENT) {
+			rdmsr(MSR_ZHAOXIN_FCR57, lo, hi);
+			/* Enable ACE unit */
+			lo |= ACE_FCR;
+			wrmsr(MSR_ZHAOXIN_FCR57, lo, hi);
+			pr_info("CPU: Enabled ACE h/w crypto\n");
+		}
+
+		/* Enable RNG unit, if present and disabled */
+		if ((tmp & (RNG_PRESENT | RNG_ENABLED)) == RNG_PRESENT) {
+			rdmsr(MSR_ZHAOXIN_FCR57, lo, hi);
+			/* Enable RNG unit */
+			lo |= RNG_ENABLE;
+			wrmsr(MSR_ZHAOXIN_FCR57, lo, hi);
+			pr_info("CPU: Enabled h/w RNG\n");
+		}
+
+		/*
+		 * Store Extended Feature Flags as word 5 of the CPU
+		 * capability bit array
+		 */
+		c->x86_capability[CPUID_C000_0001_EDX] = cpuid_edx(0xC0000001);
+	}
+
+	if (c->x86 >= 0x6)
+		set_cpu_cap(c, X86_FEATURE_REP_GOOD);
+
+	cpu_detect_cache_sizes(c);
+}
+
+static void early_init_zhaoxin(struct cpuinfo_x86 *c)
+{
+	if (c->x86 >= 0x6)
+		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
+#ifdef CONFIG_X86_64
+	set_cpu_cap(c, X86_FEATURE_SYSENTER32);
+#endif
+	if (c->x86_power & (1 << 8)) {
+		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
+		set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
+	}
+
+	if (c->cpuid_level >= 0x00000001) {
+		u32 eax, ebx, ecx, edx;
+
+		cpuid(0x00000001, &eax, &ebx, &ecx, &edx);
+		/*
+		 * If HTT (EDX[28]) is set EBX[16:23] contain the number of
+		 * apicids which are reserved per package. Store the resulting
+		 * shift value for the package management code.
+		 */
+		if (edx & (1U << 28))
+			c->x86_coreid_bits = get_count_order((ebx >> 16) & 0xff);
+	}
+
+}
+
+static void zhaoxin_detect_vmx_virtcap(struct cpuinfo_x86 *c)
+{
+	u32 vmx_msr_low, vmx_msr_high, msr_ctl, msr_ctl2;
+
+	rdmsr(MSR_IA32_VMX_PROCBASED_CTLS, vmx_msr_low, vmx_msr_high);
+	msr_ctl = vmx_msr_high | vmx_msr_low;
+
+	if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW)
+		set_cpu_cap(c, X86_FEATURE_TPR_SHADOW);
+	if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_VNMI)
+		set_cpu_cap(c, X86_FEATURE_VNMI);
+	if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_2ND_CTLS) {
+		rdmsr(MSR_IA32_VMX_PROCBASED_CTLS2,
+		      vmx_msr_low, vmx_msr_high);
+		msr_ctl2 = vmx_msr_high | vmx_msr_low;
+		if ((msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_VIRT_APIC) &&
+		    (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW))
+			set_cpu_cap(c, X86_FEATURE_FLEXPRIORITY);
+		if (msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_EPT)
+			set_cpu_cap(c, X86_FEATURE_EPT);
+		if (msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_VPID)
+			set_cpu_cap(c, X86_FEATURE_VPID);
+	}
+}
+
+static void init_zhaoxin(struct cpuinfo_x86 *c)
+{
+	early_init_zhaoxin(c);
+	init_intel_cacheinfo(c);
+	detect_num_cpu_cores(c);
+#ifdef CONFIG_X86_32
+	detect_ht(c);
+#endif
+
+	if (c->cpuid_level > 9) {
+		unsigned int eax = cpuid_eax(10);
+
+		/*
+		 * Check for version and the number of counters
+		 * Version(eax[7:0]) can't be 0;
+		 * Counters(eax[15:8]) should be greater than 1;
+		 */
+		if ((eax & 0xff) && (((eax >> 8) & 0xff) > 1))
+			set_cpu_cap(c, X86_FEATURE_ARCH_PERFMON);
+	}
+
+	if (c->x86 >= 0x6)
+		init_zhaoxin_cap(c);
+#ifdef CONFIG_X86_64
+	set_cpu_cap(c, X86_FEATURE_LFENCE_RDTSC);
+#endif
+
+	if (cpu_has(c, X86_FEATURE_VMX))
+		zhaoxin_detect_vmx_virtcap(c);
+}
+
+#ifdef CONFIG_X86_32
+static unsigned int
+zhaoxin_size_cache(struct cpuinfo_x86 *c, unsigned int size)
+{
+	return size;
+}
+#endif
+
+static const struct cpu_dev zhaoxin_cpu_dev = {
+	.c_vendor	= "zhaoxin",
+	.c_ident	= { "  Shanghai  " },
+	.c_early_init	= early_init_zhaoxin,
+	.c_init		= init_zhaoxin,
+#ifdef CONFIG_X86_32
+	.legacy_cache_size = zhaoxin_size_cache,
+#endif
+	.c_x86_vendor	= X86_VENDOR_ZHAOXIN,
+};
+
+cpu_dev_register(zhaoxin_cpu_dev);
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index a166c960bc9e..3108cdc00b29 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -397,22 +397,12 @@ static int putreg(struct task_struct *child,
 	case offsetof(struct user_regs_struct,fs_base):
 		if (value >= TASK_SIZE_MAX)
 			return -EIO;
-		/*
-		 * When changing the FS base, use do_arch_prctl_64()
-		 * to set the index to zero and to set the base
-		 * as requested.
-		 */
-		if (child->thread.fsbase != value)
-			return do_arch_prctl_64(child, ARCH_SET_FS, value);
+		x86_fsbase_write_task(child, value);
 		return 0;
 	case offsetof(struct user_regs_struct,gs_base):
-		/*
-		 * Exactly the same here as the %fs handling above.
-		 */
 		if (value >= TASK_SIZE_MAX)
 			return -EIO;
-		if (child->thread.gsbase != value)
-			return do_arch_prctl_64(child, ARCH_SET_GS, value);
+		x86_gsbase_write_task(child, value);
 		return 0;
 #endif
 	}
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index 9a327d5b6d1f..d78a61408243 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -47,8 +47,6 @@ static const struct cpuid_reg reverse_cpuid[] = {
 	[CPUID_8000_0001_ECX] = {0x80000001, 0, CPUID_ECX},
 	[CPUID_7_0_EBX]       = {         7, 0, CPUID_EBX},
 	[CPUID_D_1_EAX]       = {       0xd, 1, CPUID_EAX},
-	[CPUID_F_0_EDX]       = {       0xf, 0, CPUID_EDX},
-	[CPUID_F_1_EDX]       = {       0xf, 1, CPUID_EDX},
 	[CPUID_8000_0008_EBX] = {0x80000008, 0, CPUID_EBX},
 	[CPUID_6_EAX]         = {         6, 0, CPUID_EAX},
 	[CPUID_8000_000A_EDX] = {0x8000000a, 0, CPUID_EDX},
diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index 6b3f1217a237..e7dc0133f817 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -64,6 +64,7 @@ static void power_saving_mwait_init(void)
 	case X86_VENDOR_HYGON:
 	case X86_VENDOR_AMD:
 	case X86_VENDOR_INTEL:
+	case X86_VENDOR_ZHAOXIN:
 		/*
 		 * AMD Fam10h TSC will tick in all
 		 * C/P/S0/S1 states when this bit is set.
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index e387a258d649..ed56c6d20b08 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -196,6 +196,7 @@ static void tsc_check_state(int state)
 	case X86_VENDOR_AMD:
 	case X86_VENDOR_INTEL:
 	case X86_VENDOR_CENTAUR:
+	case X86_VENDOR_ZHAOXIN:
 		/*
 		 * AMD Fam10h TSC will tick in all
 		 * C/P/S0/S1 states when this bit is set.
diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 186520198de7..fa07d526fe39 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -12,8 +12,9 @@ CAN_BUILD_WITH_NOPIE := $(shell ./check_cc.sh $(CC) trivial_program.c -no-pie)
 
 TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
 			check_initial_reg_state sigreturn iopl mpx-mini-test ioperm \
-			protection_keys test_vdso test_vsyscall mov_ss_trap
-TARGETS_C_32BIT_ONLY := entry_from_vm86 syscall_arg_fault test_syscall_vdso unwind_vdso \
+			protection_keys test_vdso test_vsyscall mov_ss_trap \
+			syscall_arg_fault
+TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
 TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip
diff --git a/tools/testing/selftests/x86/fsgsbase.c b/tools/testing/selftests/x86/fsgsbase.c
index af85bd4752a5..5ab4c60c100e 100644
--- a/tools/testing/selftests/x86/fsgsbase.c
+++ b/tools/testing/selftests/x86/fsgsbase.c
@@ -23,6 +23,10 @@
 #include <pthread.h>
 #include <asm/ldt.h>
 #include <sys/mman.h>
+#include <stddef.h>
+#include <sys/ptrace.h>
+#include <sys/wait.h>
+#include <setjmp.h>
 
 #ifndef __x86_64__
 # error This test is 64-bit only
@@ -31,6 +35,8 @@
 static volatile sig_atomic_t want_segv;
 static volatile unsigned long segv_addr;
 
+static unsigned short *shared_scratch;
+
 static int nerrs;
 
 static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
@@ -71,6 +77,43 @@ static void sigsegv(int sig, siginfo_t *si, void *ctx_void)
 
 }
 
+static jmp_buf jmpbuf;
+
+static void sigill(int sig, siginfo_t *si, void *ctx_void)
+{
+	siglongjmp(jmpbuf, 1);
+}
+
+static bool have_fsgsbase;
+
+static inline unsigned long rdgsbase(void)
+{
+	unsigned long gsbase;
+
+	asm volatile("rdgsbase %0" : "=r" (gsbase) :: "memory");
+
+	return gsbase;
+}
+
+static inline unsigned long rdfsbase(void)
+{
+	unsigned long fsbase;
+
+	asm volatile("rdfsbase %0" : "=r" (fsbase) :: "memory");
+
+	return fsbase;
+}
+
+static inline void wrgsbase(unsigned long gsbase)
+{
+	asm volatile("wrgsbase %0" :: "r" (gsbase) : "memory");
+}
+
+static inline void wrfsbase(unsigned long fsbase)
+{
+	asm volatile("wrfsbase %0" :: "r" (fsbase) : "memory");
+}
+
 enum which_base { FS, GS };
 
 static unsigned long read_base(enum which_base which)
@@ -199,16 +242,13 @@ static void do_remote_base()
 	       to_set, hard_zero ? " and clear gs" : "", sel);
 }
 
-void do_unexpected_base(void)
+static __thread int set_thread_area_entry_number = -1;
+
+static unsigned short load_gs(void)
 {
 	/*
-	 * The goal here is to try to arrange for GS == 0, GSBASE !=
-	 * 0, and for the the kernel the think that GSBASE == 0.
-	 *
-	 * To make the test as reliable as possible, this uses
-	 * explicit descriptorss.  (This is not the only way.  This
-	 * could use ARCH_SET_GS with a low, nonzero base, but the
-	 * relevant side effect of ARCH_SET_GS could change.)
+	 * Sets GS != 0 and GSBASE != 0 but arranges for the kernel to think
+	 * that GSBASE == 0 (i.e. thread.gsbase == 0).
 	 */
 
 	/* Step 1: tell the kernel that we have GSBASE == 0. */
@@ -228,8 +268,9 @@ void do_unexpected_base(void)
 		.useable         = 0
 	};
 	if (syscall(SYS_modify_ldt, 1, &desc, sizeof(desc)) == 0) {
-		printf("\tother thread: using LDT slot 0\n");
+		printf("\tusing LDT slot 0\n");
 		asm volatile ("mov %0, %%gs" : : "rm" ((unsigned short)0x7));
+		return 0x7;
 	} else {
 		/* No modify_ldt for us (configured out, perhaps) */
 
@@ -239,7 +280,7 @@ void do_unexpected_base(void)
 			MAP_PRIVATE | MAP_ANONYMOUS | MAP_32BIT, -1, 0);
 		memcpy(low_desc, &desc, sizeof(desc));
 
-		low_desc->entry_number = -1;
+		low_desc->entry_number = set_thread_area_entry_number;
 
 		/* 32-bit set_thread_area */
 		long ret;
@@ -251,18 +292,43 @@ void do_unexpected_base(void)
 
 		if (ret != 0) {
 			printf("[NOTE]\tcould not create a segment -- test won't do anything\n");
-			return;
+			return 0;
 		}
-		printf("\tother thread: using GDT slot %d\n", desc.entry_number);
-		asm volatile ("mov %0, %%gs" : : "rm" ((unsigned short)((desc.entry_number << 3) | 0x3)));
+		printf("\tusing GDT slot %d\n", desc.entry_number);
+		set_thread_area_entry_number = desc.entry_number;
+
+		unsigned short gs = (unsigned short)((desc.entry_number << 3) | 0x3);
+		asm volatile ("mov %0, %%gs" : : "rm" (gs));
+		return gs;
 	}
+}
 
-	/*
-	 * Step 3: set the selector back to zero.  On AMD chips, this will
-	 * preserve GSBASE.
-	 */
+void test_wrbase(unsigned short index, unsigned long base)
+{
+	unsigned short newindex;
+	unsigned long newbase;
 
-	asm volatile ("mov %0, %%gs" : : "rm" ((unsigned short)0));
+	printf("[RUN]\tGS = 0x%hx, GSBASE = 0x%lx\n", index, base);
+
+	asm volatile ("mov %0, %%gs" : : "rm" (index));
+	wrgsbase(base);
+
+	remote_base = 0;
+	ftx = 1;
+	syscall(SYS_futex, &ftx, FUTEX_WAKE, 0, NULL, NULL, 0);
+	while (ftx != 0)
+		syscall(SYS_futex, &ftx, FUTEX_WAIT, 1, NULL, NULL, 0);
+
+	asm volatile ("mov %%gs, %0" : "=rm" (newindex));
+	newbase = rdgsbase();
+
+	if (newindex == index && newbase == base) {
+		printf("[OK]\tIndex and base were preserved\n");
+	} else {
+		printf("[FAIL]\tAfter switch, GS = 0x%hx and GSBASE = 0x%lx\n",
+		       newindex, newbase);
+		nerrs++;
+	}
 }
 
 static void *threadproc(void *ctx)
@@ -273,12 +339,19 @@ static void *threadproc(void *ctx)
 		if (ftx == 3)
 			return NULL;
 
-		if (ftx == 1)
+		if (ftx == 1) {
 			do_remote_base();
-		else if (ftx == 2)
-			do_unexpected_base();
-		else
+		} else if (ftx == 2) {
+			/*
+			 * On AMD chips, this causes GSBASE != 0, GS == 0, and
+			 * thread.gsbase == 0.
+			 */
+
+			load_gs();
+			asm volatile ("mov %0, %%gs" : : "rm" ((unsigned short)0));
+		} else {
 			errx(1, "helper thread got bad command");
+		}
 
 		ftx = 0;
 		syscall(SYS_futex, &ftx, FUTEX_WAKE, 0, NULL, NULL, 0);
@@ -367,10 +440,99 @@ static void test_unexpected_base(void)
 	}
 }
 
+#define USER_REGS_OFFSET(r) offsetof(struct user_regs_struct, r)
+
+static void test_ptrace_write_gsbase(void)
+{
+	int status;
+	pid_t child = fork();
+
+	if (child < 0)
+		err(1, "fork");
+
+	if (child == 0) {
+		printf("[RUN]\tPTRACE_POKE(), write GSBASE from ptracer\n");
+
+		*shared_scratch = load_gs();
+
+		if (ptrace(PTRACE_TRACEME, 0, NULL, NULL) != 0)
+			err(1, "PTRACE_TRACEME");
+
+		raise(SIGTRAP);
+		_exit(0);
+	}
+
+	wait(&status);
+
+	if (WSTOPSIG(status) == SIGTRAP) {
+		unsigned long gs, base;
+		unsigned long gs_offset = USER_REGS_OFFSET(gs);
+		unsigned long base_offset = USER_REGS_OFFSET(gs_base);
+
+		gs = ptrace(PTRACE_PEEKUSER, child, gs_offset, NULL);
+
+		if (gs != *shared_scratch) {
+			nerrs++;
+			printf("[FAIL]\tGS is not prepared with nonzero\n");
+			goto END;
+		}
+
+		if (ptrace(PTRACE_POKEUSER, child, base_offset, 0xFF) != 0)
+			err(1, "PTRACE_POKEUSER");
+
+		gs = ptrace(PTRACE_PEEKUSER, child, gs_offset, NULL);
+		base = ptrace(PTRACE_PEEKUSER, child, base_offset, NULL);
+
+		/*
+		 * In a non-FSGSBASE system, the nonzero selector will load
+		 * GSBASE (again). But what is tested here is whether the
+		 * selector value is changed or not by the GSBASE write in
+		 * a ptracer.
+		 */
+		if (gs != *shared_scratch) {
+			nerrs++;
+			printf("[FAIL]\tGS changed to %lx\n", gs);
+
+			/*
+			 * On older kernels, poking a nonzero value into the
+			 * base would zero the selector.  On newer kernels,
+			 * this behavior has changed -- poking the base
+			 * changes only the base and, if FSGSBASE is not
+			 * available, this may have no effect.
+			 */
+			if (gs == 0)
+				printf("\tNote: this is expected behavior on older kernels.\n");
+		} else if (have_fsgsbase && (base != 0xFF)) {
+			nerrs++;
+			printf("[FAIL]\tGSBASE changed to %lx\n", base);
+		} else {
+			printf("[OK]\tGS remained 0x%hx%s", *shared_scratch, have_fsgsbase ? " and GSBASE changed to 0xFF" : "");
+			printf("\n");
+		}
+	}
+
+END:
+	ptrace(PTRACE_CONT, child, NULL, NULL);
+}
+
 int main()
 {
 	pthread_t thread;
 
+	shared_scratch = mmap(NULL, 4096, PROT_READ | PROT_WRITE,
+			      MAP_ANONYMOUS | MAP_SHARED, -1, 0);
+
+	/* Probe FSGSBASE */
+	sethandler(SIGILL, sigill, 0);
+	if (sigsetjmp(jmpbuf, 1) == 0) {
+		rdfsbase();
+		have_fsgsbase = true;
+		printf("\tFSGSBASE instructions are enabled\n");
+	} else {
+		printf("\tFSGSBASE instructions are disabled\n");
+	}
+	clearhandler(SIGILL);
+
 	sethandler(SIGSEGV, sigsegv, 0);
 
 	check_gs_value(0);
@@ -417,11 +579,28 @@ int main()
 
 	test_unexpected_base();
 
+	if (have_fsgsbase) {
+		unsigned short ss;
+
+		asm volatile ("mov %%ss, %0" : "=rm" (ss));
+
+		test_wrbase(0, 0);
+		test_wrbase(0, 1);
+		test_wrbase(0, 0x200000000);
+		test_wrbase(0, 0xffffffffffffffff);
+		test_wrbase(ss, 0);
+		test_wrbase(ss, 1);
+		test_wrbase(ss, 0x200000000);
+		test_wrbase(ss, 0xffffffffffffffff);
+	}
+
 	ftx = 3;  /* Kill the thread. */
 	syscall(SYS_futex, &ftx, FUTEX_WAKE, 0, NULL, NULL, 0);
 
 	if (pthread_join(thread, NULL) != 0)
 		err(1, "pthread_join");
 
+	test_ptrace_write_gsbase();
+
 	return nerrs == 0 ? 0 : 1;
 }
diff --git a/tools/testing/selftests/x86/syscall_arg_fault.c b/tools/testing/selftests/x86/syscall_arg_fault.c
index 4e25d38c8bbd..bc0ecc2e862e 100644
--- a/tools/testing/selftests/x86/syscall_arg_fault.c
+++ b/tools/testing/selftests/x86/syscall_arg_fault.c
@@ -15,9 +15,30 @@
 #include <setjmp.h>
 #include <errno.h>
 
+#ifdef __x86_64__
+# define WIDTH "q"
+#else
+# define WIDTH "l"
+#endif
+
 /* Our sigaltstack scratch space. */
 static unsigned char altstack_data[SIGSTKSZ];
 
+static unsigned long get_eflags(void)
+{
+	unsigned long eflags;
+	asm volatile ("pushf" WIDTH "\n\tpop" WIDTH " %0" : "=rm" (eflags));
+	return eflags;
+}
+
+static void set_eflags(unsigned long eflags)
+{
+	asm volatile ("push" WIDTH " %0\n\tpopf" WIDTH
+		      : : "rm" (eflags) : "flags");
+}
+
+#define X86_EFLAGS_TF (1UL << 8)
+
 static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
 		       int flags)
 {
@@ -35,13 +56,22 @@ static sigjmp_buf jmpbuf;
 
 static volatile sig_atomic_t n_errs;
 
+#ifdef __x86_64__
+#define REG_AX REG_RAX
+#define REG_IP REG_RIP
+#else
+#define REG_AX REG_EAX
+#define REG_IP REG_EIP
+#endif
+
 static void sigsegv_or_sigbus(int sig, siginfo_t *info, void *ctx_void)
 {
 	ucontext_t *ctx = (ucontext_t*)ctx_void;
+	long ax = (long)ctx->uc_mcontext.gregs[REG_AX];
 
-	if (ctx->uc_mcontext.gregs[REG_EAX] != -EFAULT) {
-		printf("[FAIL]\tAX had the wrong value: 0x%x\n",
-		       ctx->uc_mcontext.gregs[REG_EAX]);
+	if (ax != -EFAULT && ax != -ENOSYS) {
+		printf("[FAIL]\tAX had the wrong value: 0x%lx\n",
+		       (unsigned long)ax);
 		n_errs++;
 	} else {
 		printf("[OK]\tSeems okay\n");
@@ -50,9 +80,42 @@ static void sigsegv_or_sigbus(int sig, siginfo_t *info, void *ctx_void)
 	siglongjmp(jmpbuf, 1);
 }
 
+static volatile sig_atomic_t sigtrap_consecutive_syscalls;
+
+static void sigtrap(int sig, siginfo_t *info, void *ctx_void)
+{
+	/*
+	 * KVM has some bugs that can cause us to stop making progress.
+	 * detect them and complain, but don't infinite loop or fail the
+	 * test.
+	 */
+
+	ucontext_t *ctx = (ucontext_t*)ctx_void;
+	unsigned short *ip = (unsigned short *)ctx->uc_mcontext.gregs[REG_IP];
+
+	if (*ip == 0x340f || *ip == 0x050f) {
+		/* The trap was on SYSCALL or SYSENTER */
+		sigtrap_consecutive_syscalls++;
+		if (sigtrap_consecutive_syscalls > 3) {
+			printf("[WARN]\tGot stuck single-stepping -- you probably have a KVM bug\n");
+			siglongjmp(jmpbuf, 1);
+		}
+	} else {
+		sigtrap_consecutive_syscalls = 0;
+	}
+}
+
 static void sigill(int sig, siginfo_t *info, void *ctx_void)
 {
-	printf("[SKIP]\tIllegal instruction\n");
+	ucontext_t *ctx = (ucontext_t*)ctx_void;
+	unsigned short *ip = (unsigned short *)ctx->uc_mcontext.gregs[REG_IP];
+
+	if (*ip == 0x0b0f) {
+		/* one of the ud2 instructions faulted */
+		printf("[OK]\tSYSCALL returned normally\n");
+	} else {
+		printf("[SKIP]\tIllegal instruction\n");
+	}
 	siglongjmp(jmpbuf, 1);
 }
 
@@ -120,9 +183,48 @@ int main()
 			"movl $-1, %%ebp\n\t"
 			"movl $-1, %%esp\n\t"
 			"syscall\n\t"
-			"pushl $0"	/* make sure we segfault cleanly */
+			"ud2"		/* make sure we recover cleanly */
+			: : : "memory", "flags");
+	}
+
+	printf("[RUN]\tSYSENTER with TF and invalid state\n");
+	sethandler(SIGTRAP, sigtrap, SA_ONSTACK);
+
+	if (sigsetjmp(jmpbuf, 1) == 0) {
+		sigtrap_consecutive_syscalls = 0;
+		set_eflags(get_eflags() | X86_EFLAGS_TF);
+		asm volatile (
+			"movl $-1, %%eax\n\t"
+			"movl $-1, %%ebx\n\t"
+			"movl $-1, %%ecx\n\t"
+			"movl $-1, %%edx\n\t"
+			"movl $-1, %%esi\n\t"
+			"movl $-1, %%edi\n\t"
+			"movl $-1, %%ebp\n\t"
+			"movl $-1, %%esp\n\t"
+			"sysenter"
+			: : : "memory", "flags");
+	}
+	set_eflags(get_eflags() & ~X86_EFLAGS_TF);
+
+	printf("[RUN]\tSYSCALL with TF and invalid state\n");
+	if (sigsetjmp(jmpbuf, 1) == 0) {
+		sigtrap_consecutive_syscalls = 0;
+		set_eflags(get_eflags() | X86_EFLAGS_TF);
+		asm volatile (
+			"movl $-1, %%eax\n\t"
+			"movl $-1, %%ebx\n\t"
+			"movl $-1, %%ecx\n\t"
+			"movl $-1, %%edx\n\t"
+			"movl $-1, %%esi\n\t"
+			"movl $-1, %%edi\n\t"
+			"movl $-1, %%ebp\n\t"
+			"movl $-1, %%esp\n\t"
+			"syscall\n\t"
+			"ud2"		/* make sure we recover cleanly */
 			: : : "memory", "flags");
 	}
+	set_eflags(get_eflags() & ~X86_EFLAGS_TF);
 
 	return 0;
 }

