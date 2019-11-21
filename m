Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E70DC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 01:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D224208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 01:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfKUBpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 20:45:55 -0500
Received: from mga05.intel.com ([192.55.52.43]:49101 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbfKUBpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 20:45:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 17:45:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,224,1571727600"; 
   d="scan'208";a="407025904"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga005.fm.intel.com with ESMTP; 20 Nov 2019 17:45:50 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Tony Luck" <tony.luck@intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v10 3/6] x86/split_lock: Enumerate split lock detection by the IA32_CORE_CAPABILITIES MSR
Date:   Wed, 20 Nov 2019 16:53:20 -0800
Message-Id: <1574297603-198156-4-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1574297603-198156-1-git-send-email-fenghua.yu@intel.com>
References: <1574297603-198156-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bits in the IA32_CORE_CAPABILITIES MSR enumerate a few features that are
not enumerated through CPUID. Currently bit 5 is defined to enumerate
the feature of split lock detection. All other bits are reserved now.

When bit 5 is 1, the feature is supported and feature bit
X86_FEATURE_SPLIT_LOCK_DETECT is set. Otherwise, the feature is not
available.

The flag shown in /proc/cpuinfo is "split_lock_detect".

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/cpu.h         |  5 +++++
 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/kernel/cpu/common.c       |  2 ++
 arch/x86/kernel/cpu/intel.c        | 19 +++++++++++++++++++
 4 files changed, 27 insertions(+)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index adc6cc86b062..4e03f53fc079 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -40,4 +40,9 @@ int mwait_usable(const struct cpuinfo_x86 *);
 unsigned int x86_family(unsigned int sig);
 unsigned int x86_model(unsigned int sig);
 unsigned int x86_stepping(unsigned int sig);
+#ifdef CONFIG_CPU_SUP_INTEL
+void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c);
+#else
+static inline void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c) {}
+#endif
 #endif /* _ASM_X86_CPU_H */
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index d708a1f83f40..92be003c02ba 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -220,6 +220,7 @@
 #define X86_FEATURE_ZEN			( 7*32+28) /* "" CPU is AMD family 0x17 (Zen) */
 #define X86_FEATURE_L1TF_PTEINV		( 7*32+29) /* "" L1TF workaround PTE inversion */
 #define X86_FEATURE_IBRS_ENHANCED	( 7*32+30) /* Enhanced IBRS */
+#define X86_FEATURE_SPLIT_LOCK_DETECT	( 7*32+31) /* #AC for split lock */
 
 /* Virtualization flags: Linux defined, word 8 */
 #define X86_FEATURE_TPR_SHADOW		( 8*32+ 0) /* Intel TPR Shadow */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index fffe21945374..2ee5fd49266f 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1235,6 +1235,8 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 
 	cpu_set_bug_bits(c);
 
+	cpu_set_core_cap_bits(c);
+
 	fpu__init_system(c);
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 11d5c5950e2d..ce87e2c68767 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1028,3 +1028,22 @@ static const struct cpu_dev intel_cpu_dev = {
 };
 
 cpu_dev_register(intel_cpu_dev);
+
+static void __init split_lock_setup(void)
+{
+	setup_force_cpu_cap(X86_FEATURE_SPLIT_LOCK_DETECT);
+}
+
+void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c)
+{
+	u64 ia32_core_caps = 0;
+
+	if (!cpu_has(c, X86_FEATURE_CORE_CAPABILITIES))
+		return;
+
+	/* Enumerate features reported in IA32_CORE_CAPABILITIES MSR. */
+	rdmsrl(MSR_IA32_CORE_CAPABILITIES, ia32_core_caps);
+
+	if (ia32_core_caps & MSR_IA32_CORE_CAPABILITIES_SPLIT_LOCK_DETECT)
+		split_lock_setup();
+}
-- 
2.19.1

