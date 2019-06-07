Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5838DC468BC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E1B207E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731534AbfFGWKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 18:10:06 -0400
Received: from mga06.intel.com ([134.134.136.31]:58792 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731385AbfFGWKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 18:10:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2019 15:10:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,564,1557212400"; 
   d="scan'208";a="182814104"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga002.fm.intel.com with ESMTP; 07 Jun 2019 15:10:03 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v4 2/5] x86/umwait: Initialize umwait control values
Date:   Fri,  7 Jun 2019 15:00:34 -0700
Message-Id: <1559944837-149589-3-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1559944837-149589-1-git-send-email-fenghua.yu@intel.com>
References: <1559944837-149589-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

umwait or tpause allows processor to enter a light-weight
power/performance optimized state (C0.1 state) or an improved
power/performance optimized state (C0.2 state) for a period
specified by the instruction or until the system time limit or until
a store to the monitored address range in umwait.

IA32_UMWAIT_CONTROL MSR register allows kernel to enable/disable C0.2
on the processor and set maximum time the processor can reside in
C0.1 or C0.2.

By default C0.2 is enabled so the user wait instructions can enter the
C0.2 state to save more power with slower wakeup time.

Default maximum umwait time is 100000 cycles. A later patch provides
a sysfs interface to adjust this value.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/include/asm/msr-index.h |  4 +++
 arch/x86/power/Makefile          |  1 +
 arch/x86/power/umwait.c          | 56 ++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)
 create mode 100644 arch/x86/power/umwait.c

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 979ef971cc78..af502e947298 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -61,6 +61,10 @@
 #define MSR_PLATFORM_INFO_CPUID_FAULT_BIT	31
 #define MSR_PLATFORM_INFO_CPUID_FAULT		BIT_ULL(MSR_PLATFORM_INFO_CPUID_FAULT_BIT)
 
+#define MSR_IA32_UMWAIT_CONTROL			0xe1
+#define MSR_IA32_UMWAIT_CONTROL_C02		BIT(0)
+#define MSR_IA32_UMWAIT_CONTROL_MAX_TIME	0xfffffffc
+
 #define MSR_PKG_CST_CONFIG_CONTROL	0x000000e2
 #define NHM_C3_AUTO_DEMOTE		(1UL << 25)
 #define NHM_C1_AUTO_DEMOTE		(1UL << 26)
diff --git a/arch/x86/power/Makefile b/arch/x86/power/Makefile
index 37923d715741..62e2c609d1fe 100644
--- a/arch/x86/power/Makefile
+++ b/arch/x86/power/Makefile
@@ -8,3 +8,4 @@ CFLAGS_cpu.o	:= $(nostackp)
 
 obj-$(CONFIG_PM_SLEEP)		+= cpu.o
 obj-$(CONFIG_HIBERNATION)	+= hibernate_$(BITS).o hibernate_asm_$(BITS).o hibernate.o
+obj-y				+= umwait.o
diff --git a/arch/x86/power/umwait.c b/arch/x86/power/umwait.c
new file mode 100644
index 000000000000..23151e77c138
--- /dev/null
+++ b/arch/x86/power/umwait.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/syscore_ops.h>
+#include <linux/suspend.h>
+#include <linux/cpu.h>
+#include <asm/msr.h>
+
+/*
+ * Cache IA32_UMWAIT_CONTROL MSR in this variable. All CPUs have the same
+ * MSR value. By default, umwait max time is 100000 in TSC-quanta and C0.2
+ * is enabled
+ */
+static u32 umwait_control_cached = 100000;
+
+/* Set up IA32_UMWAIT_CONTROL MSR on CPU using the current global setting. */
+static int umwait_cpu_online(unsigned int cpu)
+{
+	wrmsr(MSR_IA32_UMWAIT_CONTROL, umwait_control_cached, 0);
+
+	return 0;
+}
+
+/*
+ * On resume, set up IA32_UMWAIT_CONTROL MSR on BP which is the only active
+ * CPU at this time. Setting up the MSR on APs when they are re-added later
+ * using CPU hotplug.
+ * The MSR on BP is supposed not to be changed during suspend and thus it's
+ * unnecessary to set it again during resume from suspend. But at this point
+ * we don't know resume is from suspend or hibernation. To simplify the
+ * situation, just set up the MSR on resume from suspend.
+ */
+static void umwait_syscore_resume(void)
+{
+	wrmsr(MSR_IA32_UMWAIT_CONTROL, umwait_control_cached, 0);
+}
+
+static struct syscore_ops umwait_syscore_ops = {
+	.resume	= umwait_syscore_resume,
+};
+
+static int __init umwait_init(void)
+{
+	int ret;
+
+	if (!boot_cpu_has(X86_FEATURE_WAITPKG))
+		return -ENODEV;
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "umwait/intel:online",
+				umwait_cpu_online, NULL);
+	if (ret < 0)
+		return ret;
+
+	register_syscore_ops(&umwait_syscore_ops);
+
+	return 0;
+}
+device_initcall(umwait_init);
-- 
2.19.1

