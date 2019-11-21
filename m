Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC241C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 01:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D9E020878
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 01:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfKUBqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 20:46:03 -0500
Received: from mga05.intel.com ([192.55.52.43]:49101 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbfKUBpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 20:45:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 17:45:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,224,1571727600"; 
   d="scan'208";a="407025914"
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
Subject: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by kernel parameter
Date:   Wed, 20 Nov 2019 16:53:23 -0800
Message-Id: <1574297603-198156-7-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1574297603-198156-1-git-send-email-fenghua.yu@intel.com>
References: <1574297603-198156-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split lock detection is disabled by default. Enable the feature by
kernel parameter "split_lock_detect".

Usually it is enabled in real time when expensive split lock issues
cannot be tolerated so should be fatal errors, or for debugging and
fixing the split lock issues to improve performance.

Please note: enabling this feature will cause kernel panic or SIGBUS
to user application when a split lock issue is detected.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 .../admin-guide/kernel-parameters.txt         | 10 ++++++
 arch/x86/kernel/cpu/intel.c                   | 34 +++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 8dee8f68fe15..1ed313891f44 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3166,6 +3166,16 @@
 
 	nosoftlockup	[KNL] Disable the soft-lockup detector.
 
+	split_lock_detect
+			[X86] Enable split lock detection
+			This is a real time or debugging feature. When enabled
+			(and if hardware support is present), atomic
+			instructions that access data across cache line
+			boundaries will result in an alignment check exception.
+			When triggered in applications the kernel will send
+			SIGBUS. The kernel will panic for a split lock in
+			OS code.
+
 	nosync		[HW,M68K] Disables sync negotiation for all devices.
 
 	nowatchdog	[KNL] Disable both lockup detectors, i.e.
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index bc0c2f288509..9bf6daf185b9 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -20,6 +20,7 @@
 #include <asm/hwcap2.h>
 #include <asm/elf.h>
 #include <asm/cpu_device_id.h>
+#include <asm/cmdline.h>
 
 #ifdef CONFIG_X86_64
 #include <linux/topology.h>
@@ -655,6 +656,26 @@ static void init_intel_misc_features(struct cpuinfo_x86 *c)
 	wrmsrl(MSR_MISC_FEATURES_ENABLES, msr);
 }
 
+static void split_lock_init(void)
+{
+	if (split_lock_detect_enabled) {
+		u64 test_ctrl_val;
+
+		/*
+		 * The TEST_CTRL MSR is per core. So multiple threads can
+		 * read/write the MSR in parallel. But it's possible to
+		 * simplify the read/write without locking and without
+		 * worry about overwriting the MSR because only bit 29
+		 * is implemented in the MSR and the bit is set as 1 by all
+		 * threads. Locking may be needed in the future if situation
+		 * is changed e.g. other bits are implemented.
+		 */
+		rdmsrl(MSR_TEST_CTRL, test_ctrl_val);
+		test_ctrl_val |= MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
+		wrmsrl(MSR_TEST_CTRL, test_ctrl_val);
+	}
+}
+
 static void init_intel(struct cpuinfo_x86 *c)
 {
 	early_init_intel(c);
@@ -770,6 +791,8 @@ static void init_intel(struct cpuinfo_x86 *c)
 		tsx_enable();
 	if (tsx_ctrl_state == TSX_CTRL_DISABLE)
 		tsx_disable();
+
+	split_lock_init();
 }
 
 #ifdef CONFIG_X86_32
@@ -1032,9 +1055,20 @@ static const struct cpu_dev intel_cpu_dev = {
 
 cpu_dev_register(intel_cpu_dev);
 
+#undef pr_fmt
+#define pr_fmt(fmt) "x86/split lock detection: " fmt
+
 static void __init split_lock_setup(void)
 {
 	setup_force_cpu_cap(X86_FEATURE_SPLIT_LOCK_DETECT);
+
+	if (cmdline_find_option_bool(boot_command_line,
+				     "split_lock_detect")) {
+		split_lock_detect_enabled = true;
+		pr_info("enabled\n");
+	} else {
+		pr_info("disabled\n");
+	}
 }
 
 #define SPLIT_LOCK_CPU(model) {X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY}
-- 
2.19.1

