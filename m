Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8B3C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA8C122CF6
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="kdogjt88"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfFXBky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 21:40:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43987 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbfFXBkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 21:40:53 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5O01p6W2861525
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 23 Jun 2019 17:01:51 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5O01p6W2861525
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561334512;
        bh=aImPNQPSJVZ+L+HHQH6bS0b24PMJZ4rvKoB2Rx14N5U=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=kdogjt88x9Ox5YXN9vCu0oZZP6vly/yykmjvp5y1w/N0BifcaBWCp9AWqCEXYoYPI
         FLmg3GJpsnVg3eYJq0qJx2DwZeqCG8Ed36TLGqp6OqveHkhWlA87YcApjO2r1IMAbs
         CDd7MSpOGgjlfVQp25fd/rcIXrdJcT0L1U9YEey+99X90MMKPjXHW2RSHOiO30MZkz
         6r0gz8NkxQ++S/JwwKYR5lmnLBqi7/m+G3j5FtIrn9W3O3jebYI+9/xV+bRdRDxNy4
         B1oin3H1DV0tfMX4+v7/cReOfJc7hOrqasgBL4cpjHqiUWPDx3y0S2gu2Zr+pXaOF/
         HYgmHCpVOZ/Yw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5O01pSn2861522;
        Sun, 23 Jun 2019 17:01:51 -0700
Date:   Sun, 23 Jun 2019 17:01:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Fenghua Yu <tipbot@zytor.com>
Message-ID: <tip-bd688c69b7e6693de3bd78f38fd63f7850c2711e@git.kernel.org>
Cc:     hpa@zytor.com, bp@alien8.de, tony.luck@intel.com,
        fenghua.yu@intel.com, ravi.v.shankar@intel.com, tglx@linutronix.de,
        mingo@kernel.org, luto@kernel.org, peterz@infradead.org,
        ashok.raj@intel.com, linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, bp@alien8.de, tony.luck@intel.com,
          fenghua.yu@intel.com, ravi.v.shankar@intel.com,
          tglx@linutronix.de, mingo@kernel.org, luto@kernel.org,
          peterz@infradead.org, ashok.raj@intel.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <1560994438-235698-3-git-send-email-fenghua.yu@intel.com>
References: <1560994438-235698-3-git-send-email-fenghua.yu@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/umwait: Initialize umwait control values
Git-Commit-ID: bd688c69b7e6693de3bd78f38fd63f7850c2711e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  bd688c69b7e6693de3bd78f38fd63f7850c2711e
Gitweb:     https://git.kernel.org/tip/bd688c69b7e6693de3bd78f38fd63f7850c2711e
Author:     Fenghua Yu <fenghua.yu@intel.com>
AuthorDate: Wed, 19 Jun 2019 18:33:55 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 24 Jun 2019 01:44:19 +0200

x86/umwait: Initialize umwait control values

umwait or tpause allows the processor to enter a light-weight
power/performance optimized state (C0.1 state) or an improved
power/performance optimized state (C0.2 state) for a period specified by
the instruction or until the system time limit or until a store to the
monitored address range in umwait.

IA32_UMWAIT_CONTROL MSR register allows the OS to enable/disable C0.2 on
the processor and to set the maximum time the processor can reside in C0.1
or C0.2.

By default C0.2 is enabled so the user wait instructions can enter the
C0.2 state to save more power with slower wakeup time.

Andy Lutomirski proposed to set the maximum umwait time to 100000 cycles by
default. A quote from Andy:

  "What I want to avoid is the case where it works dramatically differently
   on NO_HZ_FULL systems as compared to everything else. Also, UMWAIT may
   behave a bit differently if the max timeout is hit, and I'd like that
   path to get exercised widely by making it happen even on default
   configs."

A sysfs interface to adjust the time and the C0.2 enablement is provided in
a follow up change.

[ tglx: Renamed MSR_IA32_UMWAIT_CONTROL_MAX_TIME to
  	MSR_IA32_UMWAIT_CONTROL_TIME_MASK because the constant is used as
  	mask throughout the code.
	Massaged comments and changelog ]

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Cc: "Borislav Petkov" <bp@alien8.de>
Cc: "H Peter Anvin" <hpa@zytor.com>
Cc: "Peter Zijlstra" <peterz@infradead.org>
Cc: "Tony Luck" <tony.luck@intel.com>
Cc: "Ravi V Shankar" <ravi.v.shankar@intel.com>
Link: https://lkml.kernel.org/r/1560994438-235698-3-git-send-email-fenghua.yu@intel.com

---
 arch/x86/include/asm/msr-index.h |  9 ++++++
 arch/x86/kernel/cpu/Makefile     |  1 +
 arch/x86/kernel/cpu/umwait.c     | 62 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+)

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
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index a7d9a4cb3ab6..4b4eb06e117c 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -24,6 +24,7 @@ obj-y			+= match.o
 obj-y			+= bugs.o
 obj-y			+= aperfmperf.o
 obj-y			+= cpuid-deps.o
+obj-y			+= umwait.o
 
 obj-$(CONFIG_PROC_FS)	+= proc.o
 obj-$(CONFIG_X86_FEATURE_NAMES) += capflags.o powerflags.o
diff --git a/arch/x86/kernel/cpu/umwait.c b/arch/x86/kernel/cpu/umwait.c
new file mode 100644
index 000000000000..0a113c731df3
--- /dev/null
+++ b/arch/x86/kernel/cpu/umwait.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/syscore_ops.h>
+#include <linux/suspend.h>
+#include <linux/cpu.h>
+
+#include <asm/msr.h>
+
+#define UMWAIT_C02_ENABLE	0
+
+#define UMWAIT_CTRL_VAL(maxtime, c02_disable)				\
+	(((maxtime) & MSR_IA32_UMWAIT_CONTROL_TIME_MASK) |		\
+	((c02_disable) & MSR_IA32_UMWAIT_CONTROL_C02_DISABLE))
+
+/*
+ * Cache IA32_UMWAIT_CONTROL MSR. This is a systemwide control. By default,
+ * umwait max time is 100000 in TSC-quanta and C0.2 is enabled
+ */
+static u32 umwait_control_cached = UMWAIT_CTRL_VAL(100000, UMWAIT_C02_ENABLE);
+
+/* Set IA32_UMWAIT_CONTROL MSR on this CPU to the current global setting. */
+static int umwait_cpu_online(unsigned int cpu)
+{
+	wrmsr(MSR_IA32_UMWAIT_CONTROL, umwait_control_cached, 0);
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
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "umwait:online",
+				umwait_cpu_online, NULL);
+	if (ret < 0)
+		return ret;
+
+	register_syscore_ops(&umwait_syscore_ops);
+
+	return 0;
+}
+device_initcall(umwait_init);
