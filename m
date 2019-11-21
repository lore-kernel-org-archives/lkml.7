Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE046C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 01:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8279F20730
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 01:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfKUBqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 20:46:07 -0500
Received: from mga05.intel.com ([192.55.52.43]:49098 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726500AbfKUBpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 20:45:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 17:45:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,224,1571727600"; 
   d="scan'208";a="407025907"
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
Subject: [PATCH v10 4/6] x86/split_lock: Enumerate split lock detection if the IA32_CORE_CAPABILITIES MSR is not supported
Date:   Wed, 20 Nov 2019 16:53:21 -0800
Message-Id: <1574297603-198156-5-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1574297603-198156-1-git-send-email-fenghua.yu@intel.com>
References: <1574297603-198156-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Architecturally the split lock detection feature is enumerated by
IA32_CORE_CAPABILITIES MSR and future CPU models will indicate presence
of the feature by setting bit 5. But the feature is present in a few
older models where split lock detection is enumerated by the CPU models.

Use a "x86_cpu_id" table to list the older CPU models with the feature.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/intel.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index ce87e2c68767..2614616fb6d3 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -19,6 +19,7 @@
 #include <asm/microcode_intel.h>
 #include <asm/hwcap2.h>
 #include <asm/elf.h>
+#include <asm/cpu_device_id.h>
 
 #ifdef CONFIG_X86_64
 #include <linux/topology.h>
@@ -1034,15 +1035,31 @@ static void __init split_lock_setup(void)
 	setup_force_cpu_cap(X86_FEATURE_SPLIT_LOCK_DETECT);
 }
 
+#define SPLIT_LOCK_CPU(model) {X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY}
+
+/*
+ * The following processors have split lock detection feature. But since they
+ * don't have MSR IA32_CORE_CAPABILITIES, the feature cannot be enumerated by
+ * the MSR. So enumerate the feature by family and model on these processors.
+ */
+static const struct x86_cpu_id split_lock_cpu_ids[] __initconst = {
+	SPLIT_LOCK_CPU(INTEL_FAM6_ICELAKE_X),
+	SPLIT_LOCK_CPU(INTEL_FAM6_ICELAKE_L),
+	{}
+};
+
 void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c)
 {
 	u64 ia32_core_caps = 0;
 
-	if (!cpu_has(c, X86_FEATURE_CORE_CAPABILITIES))
-		return;
-
-	/* Enumerate features reported in IA32_CORE_CAPABILITIES MSR. */
-	rdmsrl(MSR_IA32_CORE_CAPABILITIES, ia32_core_caps);
+	if (cpu_has(c, X86_FEATURE_CORE_CAPABILITIES)) {
+		/* Enumerate features reported in IA32_CORE_CAPABILITIES MSR. */
+		rdmsrl(MSR_IA32_CORE_CAPABILITIES, ia32_core_caps);
+	} else {
+		/* Enumerate split lock detection by family and model. */
+		if (x86_match_cpu(split_lock_cpu_ids))
+			ia32_core_caps |= MSR_IA32_CORE_CAPABILITIES_SPLIT_LOCK_DETECT;
+	}
 
 	if (ia32_core_caps & MSR_IA32_CORE_CAPABILITIES_SPLIT_LOCK_DETECT)
 		split_lock_setup();
-- 
2.19.1

