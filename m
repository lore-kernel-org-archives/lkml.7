Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9C6C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 01:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34CA52166E
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 01:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbfHJBvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 21:51:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:28007 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726870AbfHJBvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 21:51:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 18:51:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,367,1559545200"; 
   d="scan'208";a="193505036"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga001.fm.intel.com with ESMTP; 09 Aug 2019 18:51:41 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Valdis Kletnieks" <valdis.kletnieks@vt.edu>,
        "x86" <x86@kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH] x86/umwait: Fix error handling in umwait_init()
Date:   Fri,  9 Aug 2019 18:40:37 -0700
Message-Id: <1565401237-60936-1-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, failure of cpuhp_setup_state() is ignored and the syscore
ops and the control interfaces can still be added even after the
failure. But, this error handling will cause a few issues:

1. The CPUs may have different values in the IA32_UMWAIT_CONTROL
   MSR because there is no way to roll back the control MSR on
   the CPUs which already set the MSR before the failure.
2. If the sysfs interface is added successfully, there will be a mismatch
   between the global control value and the control MSR:
   - The interface shows the default global control value. But,
     the control MSR is not set to the value because the CPU online
     function, which is supposed to set the MSR to the value,
     is not installed.
   - If the sysadmin changes the global control value through
     the interface, the control MSR on all current online CPUs is
     set to the new value. But, the control MSR on newly onlined CPUs
     after the value change will not be set to the new value due to
     lack of the CPU online function.
3. On resume from suspend/hibernation, the boot CPU restores the control
   MSR to the global control value through the syscore ops. But, the
   control MSR on all APs is not set due to lake of the CPU online
   function.

To solve the issues and enforce consistent behavior on the failure
of the CPU hotplug setup, make the following changes:

1. Cache the original control MSR value which is configured by
   hardware or BIOS before kernel boot. This value is likely to
   be 0. But it could be a different number as well. Cache the
   control MSR only once before the MSR is changed.
2. Add the CPU offline function so that the MSR is restored to the
   original control value on all CPUs on the failure.
3. On the failure, exit from cpumait_init() so that the syscore ops
   and the control interfaces are not added.

Reported-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/kernel/cpu/umwait.c | 39 +++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/umwait.c b/arch/x86/kernel/cpu/umwait.c
index 6a204e7336c1..95581f4cf6d8 100644
--- a/arch/x86/kernel/cpu/umwait.c
+++ b/arch/x86/kernel/cpu/umwait.c
@@ -17,6 +17,12 @@
  */
 static u32 umwait_control_cached = UMWAIT_CTRL_VAL(100000, UMWAIT_C02_ENABLE);
 
+/*
+ * Cache the original IA32_UMWAIT_CONTROL MSR value which is configured by
+ * hardware or BIOS before kernel boot.
+ */
+static u32 orig_umwait_control_cached __read_mostly;
+
 /*
  * Serialize access to umwait_control_cached and IA32_UMWAIT_CONTROL MSR in
  * the sysfs write functions.
@@ -52,6 +58,23 @@ static int umwait_cpu_online(unsigned int cpu)
 	return 0;
 }
 
+/*
+ * The CPU hotplug callback sets the control MSR to the original control
+ * value.
+ */
+static int umwait_cpu_offline(unsigned int cpu)
+{
+	/*
+	 * This code is protected by the CPU hotplug already and
+	 * orig_umwait_control_cached is never changed after it caches
+	 * the original control MSR value in umwait_init(). So there
+	 * is no race condition here.
+	 */
+	wrmsr(MSR_IA32_UMWAIT_CONTROL, orig_umwait_control_cached, 0);
+
+	return 0;
+}
+
 /*
  * On resume, restore IA32_UMWAIT_CONTROL MSR on the boot processor which
  * is the only active CPU at this time. The MSR is set up on the APs via the
@@ -185,8 +208,22 @@ static int __init umwait_init(void)
 	if (!boot_cpu_has(X86_FEATURE_WAITPKG))
 		return -ENODEV;
 
+	/*
+	 * Cache the original control MSR value before the control MSR is
+	 * changed. This is the only place where orig_umwait_control_cached
+	 * is modified.
+	 */
+	rdmsrl(MSR_IA32_UMWAIT_CONTROL, orig_umwait_control_cached);
+
 	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "umwait:online",
-				umwait_cpu_online, NULL);
+				umwait_cpu_online, umwait_cpu_offline);
+	if (ret < 0) {
+		/*
+		 * On failure, the control MSR on all CPUs has the
+		 * original control value.
+		 */
+		return ret;
+	}
 
 	register_syscore_ops(&umwait_syscore_ops);
 
-- 
2.19.1

