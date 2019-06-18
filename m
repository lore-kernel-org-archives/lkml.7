Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DCEC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 22:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 466232082C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 22:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731220AbfFRWwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 18:52:32 -0400
Received: from mga05.intel.com ([192.55.52.43]:51708 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730853AbfFRWvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 18:51:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2019 15:51:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,390,1557212400"; 
   d="scan'208";a="358009377"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga005.fm.intel.com with ESMTP; 18 Jun 2019 15:51:12 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Radim Krcmar" <rkrcmar@redhat.com>,
        "Christopherson Sean J" <sean.j.christopherson@intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        "Xiaoyao Li " <xiaoyao.li@intel.com>,
        "Sai Praneeth Prakhya" <sai.praneeth.prakhya@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, kvm@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v9 12/17] x86/split_lock: Enable split lock detection by default
Date:   Tue, 18 Jun 2019 15:41:14 -0700
Message-Id: <1560897679-228028-13-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1560897679-228028-1-git-send-email-fenghua.yu@intel.com>
References: <1560897679-228028-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A split locked access locks bus and degrades overall memory access
performance. When split lock detection feature is enumerated, enable
the feature by default by writing 1 to bit 29 in MSR TEST_CTL to find
any split lock issue.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/kernel/cpu/intel.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 16cf1631b7f9..4ccd890a45b0 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -627,6 +627,13 @@ static void init_intel_misc_features(struct cpuinfo_x86 *c)
 	wrmsrl(MSR_MISC_FEATURES_ENABLES, msr);
 }
 
+static void split_lock_update_msr(void)
+{
+	/* Enable split lock detection */
+	this_cpu_or(msr_test_ctl_cached, MSR_TEST_CTL_SPLIT_LOCK_DETECT);
+	wrmsrl(MSR_TEST_CTL, this_cpu_read(msr_test_ctl_cached));
+}
+
 static void split_lock_init(struct cpuinfo_x86 *c)
 {
 	if (cpu_has(c, X86_FEATURE_SPLIT_LOCK_DETECT)) {
@@ -635,6 +642,8 @@ static void split_lock_init(struct cpuinfo_x86 *c)
 		/* Cache MSR TEST_CTL */
 		rdmsrl(MSR_TEST_CTL, test_ctl_val);
 		this_cpu_write(msr_test_ctl_cached, test_ctl_val);
+
+		split_lock_update_msr();
 	}
 }
 
@@ -1012,9 +1021,13 @@ static const struct cpu_dev intel_cpu_dev = {
 
 cpu_dev_register(intel_cpu_dev);
 
+#undef pr_fmt
+#define pr_fmt(fmt) "x86/split lock detection: " fmt
+
 static void __init split_lock_setup(void)
 {
 	setup_force_cpu_cap(X86_FEATURE_SPLIT_LOCK_DETECT);
+	pr_info("enabled\n");
 }
 
 void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c)
-- 
2.19.1

