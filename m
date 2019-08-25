Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02427C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 09:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEAA321848
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 09:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfHYJpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 05:45:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37985 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfHYJpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 05:45:18 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i1p5F-0004tS-UF; Sun, 25 Aug 2019 11:45:14 +0200
Date:   Sun, 25 Aug 2019 09:43:00 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for 5.3-rc5
References: <156672618029.19810.8479315461492191933.tglx@nanos.tec.linutronix.de>
Message-ID: <156672618029.19810.9732807383797358917.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

up to:  b63f20a778c8: x86/retpoline: Don't clobber RFLAGS during CALL_NOSPEC on i386

A few fixes for x86:

  - Fix a boot regression caused by the recent bootparam sanitizing change,
    which was escaped the attention of all people who reviewed that code.

  - Address a boot problem on machines with broken E820 tables caused by an
    underflow which ended up placing the trampoline start at physical
    address 0.
    
  - Handle machines which do not advertise a legacy timer of any form, but
    need calibration of the local APIC timer gracefully by making the
    calibration routine independent from the tick interrupt. Marked for
    stable as well as there seems to be quite some new laptops rolled out
    which expose this.

  - Clear the RDRAND CPUID bit on AMD family 15h and 16h CPUs which are
    affected by broken firmware which does not initialize RDRAND correctly
    after resume. Add a command line parameter to override this for machine
    which either do not use suspend/resume or have a fixed
    BIOS. Unfortunately there is no way to detect this on boot, so the only
    safe decision is to turn it off by default.

  - Prevent RFLAGS from being clobbers in CALL_NOSPEC on 32bit which caused
    fast KVM instruction emulation to break.

  - Explain the Intel CPU model naming convention so that the repeating
    discussions come to an end.

Thanks,

	tglx

------------------>
John Hubbard (1):
      x86/boot: Fix boot regression caused by bootparam sanitizing

Kirill A. Shutemov (1):
      x86/boot/compressed/64: Fix boot on machines with broken E820 table

Sean Christopherson (1):
      x86/retpoline: Don't clobber RFLAGS during CALL_NOSPEC on i386

Thomas Gleixner (1):
      x86/apic: Handle missing global clockevent gracefully

Tom Lendacky (1):
      x86/CPU/AMD: Clear RDRAND CPUID bit on AMD family 15h/16h

Tony Luck (1):
      x86/cpu: Explain Intel model naming convention


 Documentation/admin-guide/kernel-parameters.txt |  7 ++
 arch/x86/boot/compressed/pgtable_64.c           | 13 +++-
 arch/x86/include/asm/bootparam_utils.h          |  2 +-
 arch/x86/include/asm/intel-family.h             | 15 +++++
 arch/x86/include/asm/msr-index.h                |  1 +
 arch/x86/include/asm/nospec-branch.h            |  2 +-
 arch/x86/kernel/apic/apic.c                     | 68 ++++++++++++++-----
 arch/x86/kernel/cpu/amd.c                       | 66 +++++++++++++++++++
 arch/x86/power/cpu.c                            | 86 +++++++++++++++++++++----
 9 files changed, 227 insertions(+), 33 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 47d981a86e2f..4c1971960afa 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4090,6 +4090,13 @@
 			Run specified binary instead of /init from the ramdisk,
 			used for early userspace startup. See initrd.
 
+	rdrand=		[X86]
+			force - Override the decision by the kernel to hide the
+				advertisement of RDRAND support (this affects
+				certain AMD processors because of buggy BIOS
+				support, specifically around the suspend/resume
+				path).
+
 	rdt=		[HW,X86,RDT]
 			Turn on/off individual RDT features. List is:
 			cmt, mbmtotal, mbmlocal, l3cat, l3cdp, l2cat, l2cdp,
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 5f2d03067ae5..2faddeb0398a 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -72,6 +72,8 @@ static unsigned long find_trampoline_placement(void)
 
 	/* Find the first usable memory region under bios_start. */
 	for (i = boot_params->e820_entries - 1; i >= 0; i--) {
+		unsigned long new;
+
 		entry = &boot_params->e820_table[i];
 
 		/* Skip all entries above bios_start. */
@@ -84,15 +86,20 @@ static unsigned long find_trampoline_placement(void)
 
 		/* Adjust bios_start to the end of the entry if needed. */
 		if (bios_start > entry->addr + entry->size)
-			bios_start = entry->addr + entry->size;
+			new = entry->addr + entry->size;
 
 		/* Keep bios_start page-aligned. */
-		bios_start = round_down(bios_start, PAGE_SIZE);
+		new = round_down(new, PAGE_SIZE);
 
 		/* Skip the entry if it's too small. */
-		if (bios_start - TRAMPOLINE_32BIT_SIZE < entry->addr)
+		if (new - TRAMPOLINE_32BIT_SIZE < entry->addr)
 			continue;
 
+		/* Protect against underflow. */
+		if (new - TRAMPOLINE_32BIT_SIZE > bios_start)
+			break;
+
+		bios_start = new;
 		break;
 	}
 
diff --git a/arch/x86/include/asm/bootparam_utils.h b/arch/x86/include/asm/bootparam_utils.h
index f5e90a849bca..9e5f3c722c33 100644
--- a/arch/x86/include/asm/bootparam_utils.h
+++ b/arch/x86/include/asm/bootparam_utils.h
@@ -59,7 +59,6 @@ static void sanitize_boot_params(struct boot_params *boot_params)
 			BOOT_PARAM_PRESERVE(apm_bios_info),
 			BOOT_PARAM_PRESERVE(tboot_addr),
 			BOOT_PARAM_PRESERVE(ist_info),
-			BOOT_PARAM_PRESERVE(acpi_rsdp_addr),
 			BOOT_PARAM_PRESERVE(hd0_info),
 			BOOT_PARAM_PRESERVE(hd1_info),
 			BOOT_PARAM_PRESERVE(sys_desc_table),
@@ -71,6 +70,7 @@ static void sanitize_boot_params(struct boot_params *boot_params)
 			BOOT_PARAM_PRESERVE(eddbuf_entries),
 			BOOT_PARAM_PRESERVE(edd_mbr_sig_buf_entries),
 			BOOT_PARAM_PRESERVE(edd_mbr_sig_buffer),
+			BOOT_PARAM_PRESERVE(hdr),
 			BOOT_PARAM_PRESERVE(e820_table),
 			BOOT_PARAM_PRESERVE(eddbuf),
 		};
diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 0278aa66ef62..fe7c205233f1 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -11,6 +11,21 @@
  * While adding a new CPUID for a new microarchitecture, add a new
  * group to keep logically sorted out in chronological order. Within
  * that group keep the CPUID for the variants sorted by model number.
+ *
+ * The defined symbol names have the following form:
+ *	INTEL_FAM6{OPTFAMILY}_{MICROARCH}{OPTDIFF}
+ * where:
+ * OPTFAMILY	Describes the family of CPUs that this belongs to. Default
+ *		is assumed to be "_CORE" (and should be omitted). Other values
+ *		currently in use are _ATOM and _XEON_PHI
+ * MICROARCH	Is the code name for the micro-architecture for this core.
+ *		N.B. Not the platform name.
+ * OPTDIFF	If needed, a short string to differentiate by market segment.
+ *		Exact strings here will vary over time. _DESKTOP, _MOBILE, and
+ *		_X (short for Xeon server) should be used when they are
+ *		appropriate.
+ *
+ * The #define line may optionally include a comment including platform names.
  */
 
 #define INTEL_FAM6_CORE_YONAH		0x0E
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 6b4fc2788078..271d837d69a8 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -381,6 +381,7 @@
 #define MSR_AMD64_PATCH_LEVEL		0x0000008b
 #define MSR_AMD64_TSC_RATIO		0xc0000104
 #define MSR_AMD64_NB_CFG		0xc001001f
+#define MSR_AMD64_CPUID_FN_1		0xc0011004
 #define MSR_AMD64_PATCH_LOADER		0xc0010020
 #define MSR_AMD64_OSVW_ID_LENGTH	0xc0010140
 #define MSR_AMD64_OSVW_STATUS		0xc0010141
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 109f974f9835..80bc209c0708 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -192,7 +192,7 @@
 	"    	lfence;\n"					\
 	"       jmp    902b;\n"					\
 	"       .align 16\n"					\
-	"903:	addl   $4, %%esp;\n"				\
+	"903:	lea    4(%%esp), %%esp;\n"			\
 	"       pushl  %[thunk_target];\n"			\
 	"       ret;\n"						\
 	"       .align 16\n"					\
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index f5291362da1a..aa5495d0f478 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -722,7 +722,7 @@ static __initdata unsigned long lapic_cal_pm1, lapic_cal_pm2;
 static __initdata unsigned long lapic_cal_j1, lapic_cal_j2;
 
 /*
- * Temporary interrupt handler.
+ * Temporary interrupt handler and polled calibration function.
  */
 static void __init lapic_cal_handler(struct clock_event_device *dev)
 {
@@ -851,7 +851,8 @@ bool __init apic_needs_pit(void)
 static int __init calibrate_APIC_clock(void)
 {
 	struct clock_event_device *levt = this_cpu_ptr(&lapic_events);
-	void (*real_handler)(struct clock_event_device *dev);
+	u64 tsc_perj = 0, tsc_start = 0;
+	unsigned long jif_start;
 	unsigned long deltaj;
 	long delta, deltatsc;
 	int pm_referenced = 0;
@@ -878,28 +879,64 @@ static int __init calibrate_APIC_clock(void)
 	apic_printk(APIC_VERBOSE, "Using local APIC timer interrupts.\n"
 		    "calibrating APIC timer ...\n");
 
+	/*
+	 * There are platforms w/o global clockevent devices. Instead of
+	 * making the calibration conditional on that, use a polling based
+	 * approach everywhere.
+	 */
 	local_irq_disable();
 
-	/* Replace the global interrupt handler */
-	real_handler = global_clock_event->event_handler;
-	global_clock_event->event_handler = lapic_cal_handler;
-
 	/*
 	 * Setup the APIC counter to maximum. There is no way the lapic
 	 * can underflow in the 100ms detection time frame
 	 */
 	__setup_APIC_LVTT(0xffffffff, 0, 0);
 
-	/* Let the interrupts run */
+	/*
+	 * Methods to terminate the calibration loop:
+	 *  1) Global clockevent if available (jiffies)
+	 *  2) TSC if available and frequency is known
+	 */
+	jif_start = READ_ONCE(jiffies);
+
+	if (tsc_khz) {
+		tsc_start = rdtsc();
+		tsc_perj = div_u64((u64)tsc_khz * 1000, HZ);
+	}
+
+	/*
+	 * Enable interrupts so the tick can fire, if a global
+	 * clockevent device is available
+	 */
 	local_irq_enable();
 
-	while (lapic_cal_loops <= LAPIC_CAL_LOOPS)
-		cpu_relax();
+	while (lapic_cal_loops <= LAPIC_CAL_LOOPS) {
+		/* Wait for a tick to elapse */
+		while (1) {
+			if (tsc_khz) {
+				u64 tsc_now = rdtsc();
+				if ((tsc_now - tsc_start) >= tsc_perj) {
+					tsc_start += tsc_perj;
+					break;
+				}
+			} else {
+				unsigned long jif_now = READ_ONCE(jiffies);
 
-	local_irq_disable();
+				if (time_after(jif_now, jif_start)) {
+					jif_start = jif_now;
+					break;
+				}
+			}
+			cpu_relax();
+		}
 
-	/* Restore the real event handler */
-	global_clock_event->event_handler = real_handler;
+		/* Invoke the calibration routine */
+		local_irq_disable();
+		lapic_cal_handler(NULL);
+		local_irq_enable();
+	}
+
+	local_irq_disable();
 
 	/* Build delta t1-t2 as apic timer counts down */
 	delta = lapic_cal_t1 - lapic_cal_t2;
@@ -943,10 +980,11 @@ static int __init calibrate_APIC_clock(void)
 	levt->features &= ~CLOCK_EVT_FEAT_DUMMY;
 
 	/*
-	 * PM timer calibration failed or not turned on
-	 * so lets try APIC timer based calibration
+	 * PM timer calibration failed or not turned on so lets try APIC
+	 * timer based calibration, if a global clockevent device is
+	 * available.
 	 */
-	if (!pm_referenced) {
+	if (!pm_referenced && global_clock_event) {
 		apic_printk(APIC_VERBOSE, "... verify APIC timer\n");
 
 		/*
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 8d4e50428b68..68c363c341bf 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -804,6 +804,64 @@ static void init_amd_ln(struct cpuinfo_x86 *c)
 	msr_set_bit(MSR_AMD64_DE_CFG, 31);
 }
 
+static bool rdrand_force;
+
+static int __init rdrand_cmdline(char *str)
+{
+	if (!str)
+		return -EINVAL;
+
+	if (!strcmp(str, "force"))
+		rdrand_force = true;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+early_param("rdrand", rdrand_cmdline);
+
+static void clear_rdrand_cpuid_bit(struct cpuinfo_x86 *c)
+{
+	/*
+	 * Saving of the MSR used to hide the RDRAND support during
+	 * suspend/resume is done by arch/x86/power/cpu.c, which is
+	 * dependent on CONFIG_PM_SLEEP.
+	 */
+	if (!IS_ENABLED(CONFIG_PM_SLEEP))
+		return;
+
+	/*
+	 * The nordrand option can clear X86_FEATURE_RDRAND, so check for
+	 * RDRAND support using the CPUID function directly.
+	 */
+	if (!(cpuid_ecx(1) & BIT(30)) || rdrand_force)
+		return;
+
+	msr_clear_bit(MSR_AMD64_CPUID_FN_1, 62);
+
+	/*
+	 * Verify that the CPUID change has occurred in case the kernel is
+	 * running virtualized and the hypervisor doesn't support the MSR.
+	 */
+	if (cpuid_ecx(1) & BIT(30)) {
+		pr_info_once("BIOS may not properly restore RDRAND after suspend, but hypervisor does not support hiding RDRAND via CPUID.\n");
+		return;
+	}
+
+	clear_cpu_cap(c, X86_FEATURE_RDRAND);
+	pr_info_once("BIOS may not properly restore RDRAND after suspend, hiding RDRAND via CPUID. Use rdrand=force to reenable.\n");
+}
+
+static void init_amd_jg(struct cpuinfo_x86 *c)
+{
+	/*
+	 * Some BIOS implementations do not restore proper RDRAND support
+	 * across suspend and resume. Check on whether to hide the RDRAND
+	 * instruction support via CPUID.
+	 */
+	clear_rdrand_cpuid_bit(c);
+}
+
 static void init_amd_bd(struct cpuinfo_x86 *c)
 {
 	u64 value;
@@ -818,6 +876,13 @@ static void init_amd_bd(struct cpuinfo_x86 *c)
 			wrmsrl_safe(MSR_F15H_IC_CFG, value);
 		}
 	}
+
+	/*
+	 * Some BIOS implementations do not restore proper RDRAND support
+	 * across suspend and resume. Check on whether to hide the RDRAND
+	 * instruction support via CPUID.
+	 */
+	clear_rdrand_cpuid_bit(c);
 }
 
 static void init_amd_zn(struct cpuinfo_x86 *c)
@@ -860,6 +925,7 @@ static void init_amd(struct cpuinfo_x86 *c)
 	case 0x10: init_amd_gh(c); break;
 	case 0x12: init_amd_ln(c); break;
 	case 0x15: init_amd_bd(c); break;
+	case 0x16: init_amd_jg(c); break;
 	case 0x17: init_amd_zn(c); break;
 	}
 
diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 24b079e94bc2..c9ef6a7a4a1a 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -12,6 +12,7 @@
 #include <linux/smp.h>
 #include <linux/perf_event.h>
 #include <linux/tboot.h>
+#include <linux/dmi.h>
 
 #include <asm/pgtable.h>
 #include <asm/proto.h>
@@ -23,7 +24,7 @@
 #include <asm/debugreg.h>
 #include <asm/cpu.h>
 #include <asm/mmu_context.h>
-#include <linux/dmi.h>
+#include <asm/cpu_device_id.h>
 
 #ifdef CONFIG_X86_32
 __visible unsigned long saved_context_ebx;
@@ -397,15 +398,14 @@ static int __init bsp_pm_check_init(void)
 
 core_initcall(bsp_pm_check_init);
 
-static int msr_init_context(const u32 *msr_id, const int total_num)
+static int msr_build_context(const u32 *msr_id, const int num)
 {
-	int i = 0;
+	struct saved_msrs *saved_msrs = &saved_context.saved_msrs;
 	struct saved_msr *msr_array;
+	int total_num;
+	int i, j;
 
-	if (saved_context.saved_msrs.array || saved_context.saved_msrs.num > 0) {
-		pr_err("x86/pm: MSR quirk already applied, please check your DMI match table.\n");
-		return -EINVAL;
-	}
+	total_num = saved_msrs->num + num;
 
 	msr_array = kmalloc_array(total_num, sizeof(struct saved_msr), GFP_KERNEL);
 	if (!msr_array) {
@@ -413,19 +413,30 @@ static int msr_init_context(const u32 *msr_id, const int total_num)
 		return -ENOMEM;
 	}
 
-	for (i = 0; i < total_num; i++) {
-		msr_array[i].info.msr_no	= msr_id[i];
+	if (saved_msrs->array) {
+		/*
+		 * Multiple callbacks can invoke this function, so copy any
+		 * MSR save requests from previous invocations.
+		 */
+		memcpy(msr_array, saved_msrs->array,
+		       sizeof(struct saved_msr) * saved_msrs->num);
+
+		kfree(saved_msrs->array);
+	}
+
+	for (i = saved_msrs->num, j = 0; i < total_num; i++, j++) {
+		msr_array[i].info.msr_no	= msr_id[j];
 		msr_array[i].valid		= false;
 		msr_array[i].info.reg.q		= 0;
 	}
-	saved_context.saved_msrs.num	= total_num;
-	saved_context.saved_msrs.array	= msr_array;
+	saved_msrs->num   = total_num;
+	saved_msrs->array = msr_array;
 
 	return 0;
 }
 
 /*
- * The following section is a quirk framework for problematic BIOSen:
+ * The following sections are a quirk framework for problematic BIOSen:
  * Sometimes MSRs are modified by the BIOSen after suspended to
  * RAM, this might cause unexpected behavior after wakeup.
  * Thus we save/restore these specified MSRs across suspend/resume
@@ -440,7 +451,7 @@ static int msr_initialize_bdw(const struct dmi_system_id *d)
 	u32 bdw_msr_id[] = { MSR_IA32_THERM_CONTROL };
 
 	pr_info("x86/pm: %s detected, MSR saving is needed during suspending.\n", d->ident);
-	return msr_init_context(bdw_msr_id, ARRAY_SIZE(bdw_msr_id));
+	return msr_build_context(bdw_msr_id, ARRAY_SIZE(bdw_msr_id));
 }
 
 static const struct dmi_system_id msr_save_dmi_table[] = {
@@ -455,9 +466,58 @@ static const struct dmi_system_id msr_save_dmi_table[] = {
 	{}
 };
 
+static int msr_save_cpuid_features(const struct x86_cpu_id *c)
+{
+	u32 cpuid_msr_id[] = {
+		MSR_AMD64_CPUID_FN_1,
+	};
+
+	pr_info("x86/pm: family %#hx cpu detected, MSR saving is needed during suspending.\n",
+		c->family);
+
+	return msr_build_context(cpuid_msr_id, ARRAY_SIZE(cpuid_msr_id));
+}
+
+static const struct x86_cpu_id msr_save_cpu_table[] = {
+	{
+		.vendor = X86_VENDOR_AMD,
+		.family = 0x15,
+		.model = X86_MODEL_ANY,
+		.feature = X86_FEATURE_ANY,
+		.driver_data = (kernel_ulong_t)msr_save_cpuid_features,
+	},
+	{
+		.vendor = X86_VENDOR_AMD,
+		.family = 0x16,
+		.model = X86_MODEL_ANY,
+		.feature = X86_FEATURE_ANY,
+		.driver_data = (kernel_ulong_t)msr_save_cpuid_features,
+	},
+	{}
+};
+
+typedef int (*pm_cpu_match_t)(const struct x86_cpu_id *);
+static int pm_cpu_check(const struct x86_cpu_id *c)
+{
+	const struct x86_cpu_id *m;
+	int ret = 0;
+
+	m = x86_match_cpu(msr_save_cpu_table);
+	if (m) {
+		pm_cpu_match_t fn;
+
+		fn = (pm_cpu_match_t)m->driver_data;
+		ret = fn(m);
+	}
+
+	return ret;
+}
+
 static int pm_check_save_msr(void)
 {
 	dmi_check_system(msr_save_dmi_table);
+	pm_cpu_check(msr_save_cpu_table);
+
 	return 0;
 }
 


