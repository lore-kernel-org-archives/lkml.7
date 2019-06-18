Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBED5C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 905F1206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbfFRIhT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 04:37:19 -0400
Received: from ZXSHCAS2.zhaoxin.com ([203.148.12.82]:28486 "EHLO
        ZXSHCAS2.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729198AbfFRIhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 04:37:17 -0400
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Tue, 18 Jun
 2019 16:37:05 +0800
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Tue, 18 Jun
 2019 16:37:05 +0800
Received: from zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d]) by
 zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d%16]) with mapi id
 15.01.1261.035; Tue, 18 Jun 2019 16:37:05 +0800
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>
CC:     David Wang <DavidWang@zhaoxin.com>,
        "Cooper Yan(BJ-RD)" <CooperYan@zhaoxin.com>,
        "Qiyuan Wang(BJ-RD)" <QiyuanWang@zhaoxin.com>,
        "Herry Yang(BJ-RD)" <HerryYang@zhaoxin.com>
Subject: [PATCH v2 1/3] x86/cpu: Create Zhaoxin processors architecture
 support file
Thread-Topic: [PATCH v2 1/3] x86/cpu: Create Zhaoxin processors architecture
 support file
Thread-Index: AdUlrVQqG9C5jqhgRwSqY2j/rQ+alA==
Date:   Tue, 18 Jun 2019 08:37:05 +0000
Message-ID: <01042674b2f741b2aed1f797359bdffb@zhaoxin.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.32.64.75]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add x86 architecture support for new Zhaoxin processors.
Carve out initialization code needed by Zhaoxin processors into
a separate compilation unit.

To identify Zhaoxin CPU, add a new vendor type X86_VENDOR_ZHAOXIN
for system recognition.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 MAINTAINERS                      |   6 ++
 arch/x86/Kconfig.cpu             |  13 ++++
 arch/x86/include/asm/processor.h |   3 +-
 arch/x86/kernel/cpu/Makefile     |   1 +
 arch/x86/kernel/cpu/zhaoxin.c    | 164 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 186 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/kernel/cpu/zhaoxin.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ff7c2b7e..0f10f68 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17562,6 +17562,12 @@ Q:	https://patchwork.linuxtv.org/project/linux-media/list/
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
index 6adce15..8e29c99 100644
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
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 6aba36b..3eab6ec 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -146,7 +146,8 @@ enum cpuid_regs_idx {
 #define X86_VENDOR_TRANSMETA	7
 #define X86_VENDOR_NSC		8
 #define X86_VENDOR_HYGON	9
-#define X86_VENDOR_NUM		10
+#define X86_VENDOR_ZHAOXIN	10
+#define X86_VENDOR_NUM		11
 
 #define X86_VENDOR_UNKNOWN	0xff
 
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 3ffe1b0..fab4378 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_CPU_SUP_CYRIX_32)		+= cyrix.o
 obj-$(CONFIG_CPU_SUP_CENTAUR)		+= centaur.o
 obj-$(CONFIG_CPU_SUP_TRANSMETA_32)	+= transmeta.o
 obj-$(CONFIG_CPU_SUP_UMC_32)		+= umc.o
+obj-$(CONFIG_CPU_SUP_ZHAOXIN)		+= zhaoxin.o
 
 obj-$(CONFIG_X86_MCE)			+= mce/
 obj-$(CONFIG_MTRR)			+= mtrr/
diff --git a/arch/x86/kernel/cpu/zhaoxin.c b/arch/x86/kernel/cpu/zhaoxin.c
new file mode 100644
index 0000000..d9d7de3
--- /dev/null
+++ b/arch/x86/kernel/cpu/zhaoxin.c
@@ -0,0 +1,164 @@
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
+		/* enable ACE unit, if present and disabled */
+		if ((tmp & (ACE_PRESENT | ACE_ENABLED)) == ACE_PRESENT) {
+			rdmsr(MSR_ZHAOXIN_FCR57, lo, hi);
+			lo |= ACE_FCR;		/* enable ACE unit */
+			wrmsr(MSR_ZHAOXIN_FCR57, lo, hi);
+			pr_info("CPU: Enabled ACE h/w crypto\n");
+		}
+
+		/* enable RNG unit, if present and disabled */
+		if ((tmp & (RNG_PRESENT | RNG_ENABLED)) == RNG_PRESENT) {
+			rdmsr(MSR_ZHAOXIN_FCR57, lo, hi);
+			lo |= RNG_ENABLE;	/* enable RNG unit */
+			wrmsr(MSR_ZHAOXIN_FCR57, lo, hi);
+			pr_info("CPU: Enabled h/w RNG\n");
+		}
+
+		/* store Extended Feature Flags as
+		 * word 5 of the CPU capability bit array
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
-- 
2.7.4
