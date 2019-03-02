Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB88CC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 02:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A40C22075B
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 02:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbfCBCxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 21:53:51 -0500
Received: from mga04.intel.com ([192.55.52.120]:49764 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727800AbfCBCwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 21:52:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Mar 2019 18:52:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,430,1544515200"; 
   d="scan'208";a="148572607"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga004.fm.intel.com with ESMTP; 01 Mar 2019 18:52:28 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Xiaoyao Li " <xiaoyao.li@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, kvm@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v4 07/17] x86/split_lock: Enumerate #AC for split lock by MSR IA32_CORE_CAPABILITY
Date:   Fri,  1 Mar 2019 18:45:01 -0800
Message-Id: <1551494711-213533-8-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1551494711-213533-1-git-send-email-fenghua.yu@intel.com>
References: <1551494711-213533-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bits in MSR IA32_CORE_CAPABILITY enumerate features that are not
enumerated through CPUID. Currently bit 5 is defined to enumerate
feature of #AC for split lock accesses. All other bits are reserved now.

When the bit 5 is 1, the feature is supported and feature bit
X86_FEATURE_SPLIT_LOCK_DETECT is set. Otherwise, the feature is not
available.

The MSR IA32_CORE_CAPABILITY itself is enumerated by
CPUID.(EAX=0x7,ECX=0):EDX[30].

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/include/asm/cpu.h         |  5 +++++
 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/kernel/cpu/common.c       |  1 +
 arch/x86/kernel/cpu/cpuid-deps.c   |  1 +
 arch/x86/kernel/cpu/intel.c        | 21 +++++++++++++++++++++
 5 files changed, 29 insertions(+)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index adc6cc86b062..e241abce1a2a 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -40,4 +40,9 @@ int mwait_usable(const struct cpuinfo_x86 *);
 unsigned int x86_family(unsigned int sig);
 unsigned int x86_model(unsigned int sig);
 unsigned int x86_stepping(unsigned int sig);
+#ifdef CONFIG_CPU_SUP_INTEL
+void init_core_capability(struct cpuinfo_x86 *c);
+#else
+static inline void init_core_capability(struct cpuinfo_x86 *c) {}
+#endif
 #endif /* _ASM_X86_CPU_H */
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 350eeccd0ce9..54c73e74213d 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -221,6 +221,7 @@
 #define X86_FEATURE_ZEN			( 7*32+28) /* "" CPU is AMD family 0x17 (Zen) */
 #define X86_FEATURE_L1TF_PTEINV		( 7*32+29) /* "" L1TF workaround PTE inversion */
 #define X86_FEATURE_IBRS_ENHANCED	( 7*32+30) /* Enhanced IBRS */
+#define X86_FEATURE_SPLIT_LOCK_DETECT	( 7*32+31) /* #AC for split lock */
 
 /* Virtualization flags: Linux defined, word 8 */
 #define X86_FEATURE_TPR_SHADOW		( 8*32+ 0) /* Intel TPR Shadow */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 51ab37ba5f64..79e7cc0c4c85 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -897,6 +897,7 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 
 	init_scattered_cpuid_features(c);
 	init_speculation_control(c);
+	init_core_capability(c);
 
 	/*
 	 * Clear/Set all flags overridden by options, after probe.
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index 2c0bd38a44ab..5ba11ce99f92 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -59,6 +59,7 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_AVX512_4VNNIW,	X86_FEATURE_AVX512F   },
 	{ X86_FEATURE_AVX512_4FMAPS,	X86_FEATURE_AVX512F   },
 	{ X86_FEATURE_AVX512_VPOPCNTDQ, X86_FEATURE_AVX512F   },
+	{ X86_FEATURE_SPLIT_LOCK_DETECT, X86_FEATURE_CORE_CAPABILITY},
 	{}
 };
 
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index fc3c07fe7df5..0c44c49f6005 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1029,3 +1029,24 @@ static const struct cpu_dev intel_cpu_dev = {
 
 cpu_dev_register(intel_cpu_dev);
 
+/**
+ * init_core_capability - enumerate features supported in IA32_CORE_CAPABILITY
+ * @c: pointer to cpuinfo_x86
+ *
+ * Return: void
+ */
+void init_core_capability(struct cpuinfo_x86 *c)
+{
+	/*
+	 * If MSR_IA32_CORE_CAPABILITY exists, enumerate features that are
+	 * reported in the MSR.
+	 */
+	if (c == &boot_cpu_data && cpu_has(c, X86_FEATURE_CORE_CAPABILITY)) {
+		u64 val;
+
+		rdmsrl(MSR_IA32_CORE_CAPABILITY, val);
+
+		if (val & CORE_CAP_SPLIT_LOCK_DETECT)
+			setup_force_cpu_cap(X86_FEATURE_SPLIT_LOCK_DETECT);
+	}
+}
-- 
2.7.4

