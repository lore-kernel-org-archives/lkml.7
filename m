Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CD6C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 11:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF3620727
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 11:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbfKZLWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 06:22:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:60924 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727218AbfKZLWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 06:22:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DBAEBAC10;
        Tue, 26 Nov 2019 11:22:44 +0000 (UTC)
Date:   Tue, 26 Nov 2019 12:22:34 +0100
From:   Borislav Petkov <bp@suse.de>
To:     x86-ml <x86@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] x86: Filter MSR writes from luserspace
Message-ID: <20191126112234.GA22393@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

so this has been on my TODO list for a while. I'd like to disable writes
to certain MSRs and MSR ranges because luserspace has no job poking at
those at all. If there's a need for poking at MSRs, a proper userspace
interface needs to be designed instead of plain writes into the MSRs.

There's a "msr.allow_writes" root-only param for the use case where CPU
folks want to be poking at MSRs. And yes, that is a valid use case -
they wanna be poking at their MSRs.

In any case, writes do taint the kernel now so that it is known that
something has been poking at the MSRs.

Thoughts?

---

... to certain important MSRs.

v0: add allow_writes param for root.

Not-yet-signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/events/amd/power.c      |   4 -
 arch/x86/events/intel/knc.c      |   4 -
 arch/x86/include/asm/msr-index.h |   8 ++
 arch/x86/include/asm/processor.h |   2 +
 arch/x86/kernel/cpu/bugs.c       |   2 +-
 arch/x86/kernel/cpu/common.c     | 165 +++++++++++++++++++++++++++++++
 arch/x86/kernel/msr.c            |  20 +++-
 drivers/hwmon/fam15h_power.c     |   4 -
 8 files changed, 195 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/amd/power.c b/arch/x86/events/amd/power.c
index abef51320e3a..0a6a31aff792 100644
--- a/arch/x86/events/amd/power.c
+++ b/arch/x86/events/amd/power.c
@@ -13,10 +13,6 @@
 #include <asm/cpu_device_id.h>
 #include "../perf_event.h"
 
-#define MSR_F15H_CU_PWR_ACCUMULATOR     0xc001007a
-#define MSR_F15H_CU_MAX_PWR_ACCUMULATOR 0xc001007b
-#define MSR_F15H_PTSC			0xc0010280
-
 /* Event code: LSB 8 bits, passed in attr->config any other bit is reserved. */
 #define AMD_POWER_EVENT_MASK		0xFFULL
 
diff --git a/arch/x86/events/intel/knc.c b/arch/x86/events/intel/knc.c
index 618001c208e8..68ab91524242 100644
--- a/arch/x86/events/intel/knc.c
+++ b/arch/x86/events/intel/knc.c
@@ -148,10 +148,6 @@ static struct event_constraint knc_event_constraints[] =
 	EVENT_CONSTRAINT_END
 };
 
-#define MSR_KNC_IA32_PERF_GLOBAL_STATUS		0x0000002d
-#define MSR_KNC_IA32_PERF_GLOBAL_OVF_CONTROL	0x0000002e
-#define MSR_KNC_IA32_PERF_GLOBAL_CTRL		0x0000002f
-
 #define KNC_ENABLE_COUNTER0			0x00000001
 #define KNC_ENABLE_COUNTER1			0x00000002
 
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 084e98da04a7..04cc381246fd 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -388,6 +388,10 @@
 #define MSR_KNC_EVNTSEL0               0x00000028
 #define MSR_KNC_EVNTSEL1               0x00000029
 
+#define MSR_KNC_IA32_PERF_GLOBAL_STATUS		0x0000002d
+#define MSR_KNC_IA32_PERF_GLOBAL_OVF_CONTROL	0x0000002e
+#define MSR_KNC_IA32_PERF_GLOBAL_CTRL		0x0000002f
+
 /* Alternative perfctr range with full access. */
 #define MSR_IA32_PMC0			0x000004c1
 
@@ -472,6 +476,10 @@
 #define MSR_F15H_IC_CFG			0xc0011021
 #define MSR_F15H_EX_CFG			0xc001102c
 
+#define MSR_F15H_CU_PWR_ACCUMULATOR     0xc001007a
+#define MSR_F15H_CU_MAX_PWR_ACCUMULATOR 0xc001007b
+#define MSR_F15H_PTSC			0xc0010280
+
 /* Fam 10h MSRs */
 #define MSR_FAM10H_MMIO_CONF_BASE	0xc0010058
 #define FAM10H_MMIO_CONF_ENABLE		(1<<0)
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 54f5d54280f6..77ccb268c545 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -970,6 +970,8 @@ bool xen_set_default_idle(void);
 void stop_this_cpu(void *dummy);
 void df_debug(struct pt_regs *regs, long error_code);
 void microcode_check(void);
+void msr_write_callback(int cpu, u32 reg, u32 low, u32 hi);
+int msr_filter_write(u32 reg);
 
 enum l1tf_mitigations {
 	L1TF_MITIGATION_OFF,
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 4c7b0fa15a19..86b8cdeb3caa 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -56,7 +56,7 @@ static u64 __ro_after_init x86_spec_ctrl_mask = SPEC_CTRL_IBRS;
  * AMD specific MSR info for Speculative Store Bypass control.
  * x86_amd_ls_cfg_ssbd_mask is initialized in identify_boot_cpu().
  */
-u64 __ro_after_init x86_amd_ls_cfg_base;
+u64 x86_amd_ls_cfg_base;
 u64 __ro_after_init x86_amd_ls_cfg_ssbd_mask;
 
 /* Control conditional STIBP in switch_to() */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index fffe21945374..0974d0b0feb4 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -53,6 +53,7 @@
 #include <asm/microcode_intel.h>
 #include <asm/intel-family.h>
 #include <asm/cpu_device_id.h>
+#include <asm/spec-ctrl.h>
 
 #ifdef CONFIG_X86_LOCAL_APIC
 #include <asm/uv/uv.h>
@@ -2000,3 +2001,167 @@ void arch_smt_update(void)
 	/* Check whether IPI broadcasting can be enabled */
 	apic_smt_update();
 }
+
+void msr_write_callback(int cpu, u32 reg, u32 lo, u32 hi)
+{
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
+		if (reg == MSR_AMD64_LS_CFG) {
+			u64 new = ((u64)hi << 32) | lo;
+			struct msr msr;
+
+			if (new != x86_amd_ls_cfg_base) {
+				x86_amd_ls_cfg_base = new;
+
+				msr.q = new;
+
+				wrmsr_on_cpus(cpu_online_mask, MSR_AMD64_LS_CFG, &msr);
+			}
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(msr_write_callback);
+
+int msr_filter_write(u32 reg)
+{
+	/* all perf counter MSRs */
+	switch (reg) {
+	case MSR_K7_EVNTSEL0:
+	case MSR_K7_PERFCTR0:
+	case MSR_F15H_PERF_CTL:
+	case MSR_F15H_PERF_CTR:
+	case MSR_AMD64_IBSBRTARGET:
+	case MSR_AMD64_IBSCTL:
+	case MSR_AMD64_IBSFETCHCTL:
+	case MSR_AMD64_IBSOPCTL:
+	case MSR_AMD64_IBSOPDATA4:
+	case MSR_AMD64_IBSOP_REG_COUNT:
+	case MSR_AMD64_IBSOP_REG_MASK:
+	case MSR_AMD64_IBS_REG_COUNT_MAX:
+	case MSR_ARCH_PERFMON_EVENTSEL0:
+	case MSR_ARCH_PERFMON_FIXED_CTR0:
+	case MSR_ARCH_PERFMON_FIXED_CTR_CTRL:
+	case MSR_ARCH_PERFMON_PERFCTR0:
+	case MSR_CORE_C1_RES:
+	case MSR_CORE_C3_RESIDENCY:
+	case MSR_CORE_C6_RESIDENCY:
+	case MSR_CORE_C7_RESIDENCY:
+	case MSR_CORE_PERF_GLOBAL_CTRL:
+	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
+	case MSR_CORE_PERF_GLOBAL_STATUS:
+	case MSR_DRAM_ENERGY_STATUS:
+	case MSR_F15H_CU_MAX_PWR_ACCUMULATOR:
+	case MSR_F15H_CU_PWR_ACCUMULATOR:
+	case MSR_F15H_NB_PERF_CTL:
+	case MSR_F15H_PTSC:
+	case MSR_F16H_L2I_PERF_CTL:
+	case MSR_F17H_IRPERF:
+	case MSR_IA32_APERF:
+	case MSR_IA32_DEBUGCTLMSR:
+	case MSR_IA32_DS_AREA:
+	case MSR_IA32_MISC_ENABLE:
+	case MSR_IA32_MPERF:
+	case MSR_IA32_PEBS_ENABLE:
+	case MSR_IA32_PERF_CAPABILITIES:
+	case MSR_IA32_PMC0:
+	case MSR_IA32_RTIT_ADDR0_A:
+	case MSR_IA32_RTIT_ADDR0_B:
+	case MSR_IA32_RTIT_ADDR1_A:
+	case MSR_IA32_RTIT_ADDR1_B:
+	case MSR_IA32_RTIT_ADDR2_A:
+	case MSR_IA32_RTIT_ADDR2_B:
+	case MSR_IA32_RTIT_ADDR3_A:
+	case MSR_IA32_RTIT_ADDR3_B:
+	case MSR_IA32_RTIT_CTL:
+	case MSR_IA32_RTIT_OUTPUT_BASE:
+	case MSR_IA32_RTIT_OUTPUT_MASK:
+	case MSR_IA32_RTIT_STATUS:
+	case MSR_IA32_THERM_STATUS:
+	case MSR_IA32_VMX_MISC:
+	case MSR_KNC_EVNTSEL0:
+	case MSR_KNC_IA32_PERF_GLOBAL_CTRL:
+	case MSR_KNC_IA32_PERF_GLOBAL_OVF_CONTROL:
+	case MSR_KNC_IA32_PERF_GLOBAL_STATUS:
+	case MSR_KNC_PERFCTR0:
+	case MSR_KNL_CORE_C6_RESIDENCY:
+	case MSR_LBR_CORE_FROM:
+	case MSR_LBR_CORE_TO:
+	case MSR_LBR_INFO_0:
+	case MSR_LBR_NHM_FROM:
+	case MSR_LBR_NHM_TO:
+	case MSR_LBR_SELECT:
+	case MSR_LBR_TOS:
+	case MSR_OFFCORE_RSP_0:
+	case MSR_OFFCORE_RSP_1:
+	case MSR_P4_ALF_ESCR0:
+	case MSR_P4_ALF_ESCR1:
+	case MSR_P4_BPU_CCCR0:
+	case MSR_P4_BPU_ESCR0:
+	case MSR_P4_BPU_ESCR1:
+	case MSR_P4_BPU_PERFCTR0:
+	case MSR_P4_BSU_ESCR0:
+	case MSR_P4_BSU_ESCR1:
+	case MSR_P4_CRU_ESCR0:
+	case MSR_P4_CRU_ESCR1:
+	case MSR_P4_CRU_ESCR2:
+	case MSR_P4_CRU_ESCR3:
+	case MSR_P4_CRU_ESCR4:
+	case MSR_P4_CRU_ESCR5:
+	case MSR_P4_DAC_ESCR0:
+	case MSR_P4_DAC_ESCR1:
+	case MSR_P4_FIRM_ESCR0:
+	case MSR_P4_FIRM_ESCR1:
+	case MSR_P4_FLAME_ESCR0:
+	case MSR_P4_FLAME_ESCR1:
+	case MSR_P4_FSB_ESCR0:
+	case MSR_P4_FSB_ESCR1:
+	case MSR_P4_IQ_ESCR0:
+	case MSR_P4_IQ_ESCR1:
+	case MSR_P4_IS_ESCR0:
+	case MSR_P4_IS_ESCR1:
+	case MSR_P4_ITLB_ESCR0:
+	case MSR_P4_ITLB_ESCR1:
+	case MSR_P4_IX_ESCR0:
+	case MSR_P4_IX_ESCR1:
+	case MSR_P4_MOB_ESCR0:
+	case MSR_P4_MOB_ESCR1:
+	case MSR_P4_MS_ESCR0:
+	case MSR_P4_MS_ESCR1:
+	case MSR_P4_PEBS_MATRIX_VERT:
+	case MSR_P4_PMH_ESCR0:
+	case MSR_P4_PMH_ESCR1:
+	case MSR_P4_RAT_ESCR0:
+	case MSR_P4_RAT_ESCR1:
+	case MSR_P4_SAAT_ESCR0:
+	case MSR_P4_SAAT_ESCR1:
+	case MSR_P4_SSU_ESCR0:
+	case MSR_P4_SSU_ESCR1:
+	case MSR_P4_TBPU_ESCR0:
+	case MSR_P4_TBPU_ESCR1:
+	case MSR_P4_TC_ESCR0:
+	case MSR_P4_TC_ESCR1:
+	case MSR_P4_U2L_ESCR0:
+	case MSR_P4_U2L_ESCR1:
+	case MSR_PEBS_FRONTEND:
+	case MSR_PEBS_LD_LAT_THRESHOLD:
+	case MSR_PKG_C10_RESIDENCY:
+	case MSR_PKG_C2_RESIDENCY:
+	case MSR_PKG_C3_RESIDENCY:
+	case MSR_PKG_C6_RESIDENCY:
+	case MSR_PKG_C7_RESIDENCY:
+	case MSR_PKG_C8_RESIDENCY:
+	case MSR_PKG_C9_RESIDENCY:
+	case MSR_PKG_ENERGY_STATUS:
+	case MSR_PLATFORM_ENERGY_STATUS:
+	case MSR_PLATFORM_INFO:
+	case MSR_PP0_ENERGY_STATUS:
+	case MSR_PP1_ENERGY_STATUS:
+	case MSR_PPERF:
+	case MSR_RAPL_POWER_UNIT:
+	case MSR_SMI_COUNT:
+		return -EPERM;
+
+	default:
+		return 0;
+	}
+}
+EXPORT_SYMBOL_GPL(msr_filter_write);
diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
index 1547be359d7f..8b87ea3ea680 100644
--- a/arch/x86/kernel/msr.c
+++ b/arch/x86/kernel/msr.c
@@ -41,6 +41,7 @@
 
 static struct class *msr_class;
 static enum cpuhp_state cpuhp_msr_state;
+static bool allow_writes;
 
 static ssize_t msr_read(struct file *file, char __user *buf,
 			size_t count, loff_t *ppos)
@@ -84,6 +85,12 @@ static ssize_t msr_write(struct file *file, const char __user *buf,
 	if (err)
 		return err;
 
+	if (!allow_writes) {
+		err = msr_filter_write(reg);
+		if (err)
+			return err;
+	}
+
 	if (count % 8)
 		return -EINVAL;	/* Invalid chunk size */
 
@@ -95,11 +102,20 @@ static ssize_t msr_write(struct file *file, const char __user *buf,
 		err = wrmsr_safe_on_cpu(cpu, reg, data[0], data[1]);
 		if (err)
 			break;
+
+		msr_write_callback(cpu, reg, data[0], data[1]);
+
 		tmp += 2;
 		bytes += 8;
 	}
 
-	return bytes ? bytes : err;
+	if (bytes) {
+		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
+
+		return bytes;
+	}
+
+	return err;
 }
 
 static long msr_ioctl(struct file *file, unsigned int ioc, unsigned long arg)
@@ -242,6 +258,8 @@ static void __exit msr_exit(void)
 }
 module_exit(msr_exit)
 
+module_param(allow_writes, bool, 0400);
+
 MODULE_AUTHOR("H. Peter Anvin <hpa@zytor.com>");
 MODULE_DESCRIPTION("x86 generic MSR driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
index 267eac00a3fb..29f5fed28c2a 100644
--- a/drivers/hwmon/fam15h_power.c
+++ b/drivers/hwmon/fam15h_power.c
@@ -41,10 +41,6 @@ MODULE_LICENSE("GPL");
 /* set maximum interval as 1 second */
 #define MAX_INTERVAL			1000
 
-#define MSR_F15H_CU_PWR_ACCUMULATOR	0xc001007a
-#define MSR_F15H_CU_MAX_PWR_ACCUMULATOR	0xc001007b
-#define MSR_F15H_PTSC			0xc0010280
-
 #define PCI_DEVICE_ID_AMD_15H_M70H_NB_F4 0x15b4
 
 struct fam15h_power_data {
-- 
2.21.0


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
