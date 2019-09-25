Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7F7C4360D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCEDE21D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439644AbfIYP3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 11:29:02 -0400
Received: from mga03.intel.com ([134.134.136.65]:20433 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731748AbfIYP3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 11:29:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2019 08:28:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,548,1559545200"; 
   d="scan'208";a="196032282"
Received: from yyu32-desk1.sc.intel.com ([10.144.153.205])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Sep 2019 08:28:58 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Rik van Riel <riel@surriel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH 4/6] x86/fpu/xstate: Introduce XSAVES supervisor states
Date:   Wed, 25 Sep 2019 08:10:20 -0700
Message-Id: <20190925151022.21688-5-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190925151022.21688-1-yu-cheng.yu@intel.com>
References: <20190925151022.21688-1-yu-cheng.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable XSAVES supervisor states by setting MSR_IA32_XSS bits according to
CPUID enumeration results.  Also revise comments at various places.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/fpu/xstate.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index b7f2808dd3f4..a183c319d808 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -233,13 +233,14 @@ void fpu__init_cpu_xstate(void)
 	 * states can be set here.
 	 */
 	xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask_user());
+
+	/*
+	 * MSR_IA32_XSS sets supervisor states managed by XSAVES.
+	 */
+	if (boot_cpu_has(X86_FEATURE_XSAVES))
+		wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor());
 }
 
-/*
- * Note that in the future we will likely need a pair of
- * functions here: one for user xstates and the other for
- * system xstates.  For now, they are the same.
- */
 static int xfeature_enabled(enum xfeature xfeature)
 {
 	return !!(xfeatures_mask_all & (1UL << xfeature));
@@ -623,9 +624,6 @@ static void do_extra_xstate_size_checks(void)
  * the size of the *user* states.  If we use it to size a buffer
  * that we use 'XSAVES' on, we could potentially overflow the
  * buffer because 'XSAVES' saves system states too.
- *
- * Note that we do not currently set any bits on IA32_XSS so
- * 'XCR0 | IA32_XSS == XCR0' for now.
  */
 static unsigned int __init get_xsaves_size(void)
 {
@@ -748,7 +746,11 @@ void __init fpu__init_system_xstate(void)
 	cpuid_count(XSTATE_CPUID, 0, &eax, &ebx, &ecx, &edx);
 	xfeatures_mask_all = eax + ((u64)edx << 32);
 
-	/* Place supervisor features in xfeatures_mask_all here */
+	/*
+	 * Find supervisor xstates supported by the processor.
+	 */
+	cpuid_count(XSTATE_CPUID, 1, &eax, &ebx, &ecx, &edx);
+	xfeatures_mask_all |= ecx + ((u64)edx << 32);
 
 	if ((xfeatures_mask_user() & XFEATURE_MASK_FPSSE) != XFEATURE_MASK_FPSSE) {
 		/*
@@ -788,9 +790,10 @@ void __init fpu__init_system_xstate(void)
 	setup_xstate_comp();
 	print_xstate_offset_size();
 
-	pr_info("x86/fpu: Enabled xstate features 0x%llx: user 0x%llx, context size is %d bytes, using '%s' format.\n",
+	pr_info("x86/fpu: Enabled xstate features 0x%llx: user 0x%llx and supervisor %llx, context size is %d bytes, using '%s' format.\n",
 		xfeatures_mask_all,
 		xfeatures_mask_user(),
+		xfeatures_mask_supervisor(),
 		fpu_kernel_xstate_size,
 		boot_cpu_has(X86_FEATURE_XSAVES) ? "compacted" : "standard");
 	return;
@@ -810,6 +813,13 @@ void fpu__resume_cpu(void)
 	 */
 	if (boot_cpu_has(X86_FEATURE_XSAVE))
 		xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask_user());
+
+	/*
+	 * Restore IA32_XSS. The same CPUID bit enumerates support
+	 * of XSAVES and MSR_IA32_XSS.
+	 */
+	if (boot_cpu_has(X86_FEATURE_XSAVES))
+		wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor());
 }
 
 /*
-- 
2.17.1

