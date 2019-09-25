Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8651BC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56F4C21D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439564AbfIYP27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 11:28:59 -0400
Received: from mga03.intel.com ([134.134.136.65]:20433 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727489AbfIYP26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 11:28:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2019 08:28:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,548,1559545200"; 
   d="scan'208";a="196032276"
Received: from yyu32-desk1.sc.intel.com ([10.144.153.205])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Sep 2019 08:28:57 -0700
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
Subject: [PATCH 2/6] x86/fpu/xstate: Define new macros for supervisor and user xstates
Date:   Wed, 25 Sep 2019 08:10:18 -0700
Message-Id: <20190925151022.21688-3-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190925151022.21688-1-yu-cheng.yu@intel.com>
References: <20190925151022.21688-1-yu-cheng.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fenghua Yu <fenghua.yu@intel.com>

XCNTXT_MASK is 'all supported xfeatures' before introducing supervisor
xstates.  It is hereby renamed to SUPPORTED_XFEATURES_MASK_USER to make it
clear that these are user xstates.

XFEATURE_MASK_SUPERVISOR is replaced with the following:
- SUPPORTED_XFEATURES_MASK_SUPERVISOR: Currently nothing.  ENQCMD and
  Control-flow Enforcement Technology (CET) will be introduced in separate
  series.
- UNSUPPORTED_XFEATURES_MASK_SUPERVISOR: Currently only Processor Trace.
- ALL_XFEATURES_MASK_SUPERVISOR: the combination of above.

Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/fpu/xstate.h | 36 ++++++++++++++++++++-----------
 arch/x86/kernel/fpu/init.c        |  3 ++-
 arch/x86/kernel/fpu/xstate.c      | 26 +++++++++++-----------
 3 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index c6136d79f8c0..014c386deaa3 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -21,19 +21,29 @@
 #define XSAVE_YMM_SIZE	    256
 #define XSAVE_YMM_OFFSET    (XSAVE_HDR_SIZE + XSAVE_HDR_OFFSET)
 
-/* Supervisor features */
-#define XFEATURE_MASK_SUPERVISOR (XFEATURE_MASK_PT)
-
-/* All currently supported features */
-#define XCNTXT_MASK		(XFEATURE_MASK_FP | \
-				 XFEATURE_MASK_SSE | \
-				 XFEATURE_MASK_YMM | \
-				 XFEATURE_MASK_OPMASK | \
-				 XFEATURE_MASK_ZMM_Hi256 | \
-				 XFEATURE_MASK_Hi16_ZMM	 | \
-				 XFEATURE_MASK_PKRU | \
-				 XFEATURE_MASK_BNDREGS | \
-				 XFEATURE_MASK_BNDCSR)
+/* All currently supported user features */
+#define SUPPORTED_XFEATURES_MASK_USER (XFEATURE_MASK_FP | \
+				       XFEATURE_MASK_SSE | \
+				       XFEATURE_MASK_YMM | \
+				       XFEATURE_MASK_OPMASK | \
+				       XFEATURE_MASK_ZMM_Hi256 | \
+				       XFEATURE_MASK_Hi16_ZMM	 | \
+				       XFEATURE_MASK_PKRU | \
+				       XFEATURE_MASK_BNDREGS | \
+				       XFEATURE_MASK_BNDCSR)
+
+/* All currently supported supervisor features */
+#define SUPPORTED_XFEATURES_MASK_SUPERVISOR (0)
+
+/*
+ * Unsupported supervisor features. When a supervisor feature in this mask is
+ * supported in the future, move it to the supported supervisor feature mask.
+ */
+#define UNSUPPORTED_XFEATURES_MASK_SUPERVISOR (XFEATURE_MASK_PT)
+
+/* All supervisor states including supported and unsupported states. */
+#define ALL_XFEATURES_MASK_SUPERVISOR (SUPPORTED_XFEATURES_MASK_SUPERVISOR | \
+				       UNSUPPORTED_XFEATURES_MASK_SUPERVISOR)
 
 #ifdef CONFIG_X86_64
 #define REX_PREFIX	"0x48, "
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 6ce7e0a23268..ba3705d25162 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -224,7 +224,8 @@ static void __init fpu__init_system_xstate_size_legacy(void)
  */
 u64 __init fpu__get_supported_xfeatures_mask(void)
 {
-	return XCNTXT_MASK;
+	return SUPPORTED_XFEATURES_MASK_USER |
+	       SUPPORTED_XFEATURES_MASK_SUPERVISOR;
 }
 
 /* Legacy code to initialize eager fpu mode. */
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index b793fc2156b9..4f99a747b4f1 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -212,14 +212,13 @@ void fpu__init_cpu_xstate(void)
 	if (!boot_cpu_has(X86_FEATURE_XSAVE) || !xfeatures_mask)
 		return;
 	/*
-	 * Make it clear that XSAVES supervisor states are not yet
-	 * implemented should anyone expect it to work by changing
-	 * bits in XFEATURE_MASK_* macros and XCR0.
+	 * Unsupported supervisor xstates should not be found in
+	 * the xfeatures mask.
 	 */
-	WARN_ONCE((xfeatures_mask & XFEATURE_MASK_SUPERVISOR),
-		"x86/fpu: XSAVES supervisor states are not yet implemented.\n");
+	WARN_ONCE((xfeatures_mask & UNSUPPORTED_XFEATURES_MASK_SUPERVISOR),
+		  "x86/fpu: Found unsupported supervisor xstates.\n");
 
-	xfeatures_mask &= ~XFEATURE_MASK_SUPERVISOR;
+	xfeatures_mask &= ~UNSUPPORTED_XFEATURES_MASK_SUPERVISOR;
 
 	cr4_set_bits(X86_CR4_OSXSAVE);
 	xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask);
@@ -435,7 +434,7 @@ static int xfeature_uncompacted_offset(int xfeature_nr)
 	 * format. Checking a supervisor state's uncompacted offset is
 	 * an error.
 	 */
-	if (XFEATURE_MASK_SUPERVISOR & BIT_ULL(xfeature_nr)) {
+	if (ALL_XFEATURES_MASK_SUPERVISOR & BIT_ULL(xfeature_nr)) {
 		WARN_ONCE(1, "No fixed offset for xstate %d\n", xfeature_nr);
 		return -1;
 	}
@@ -472,7 +471,7 @@ int using_compacted_format(void)
 int validate_xstate_header(const struct xstate_header *hdr)
 {
 	/* No unknown or supervisor features may be set */
-	if (hdr->xfeatures & (~xfeatures_mask | XFEATURE_MASK_SUPERVISOR))
+	if (hdr->xfeatures & ~(xfeatures_mask & SUPPORTED_XFEATURES_MASK_USER))
 		return -EINVAL;
 
 	/* Userspace must use the uncompacted format */
@@ -765,7 +764,8 @@ void __init fpu__init_system_xstate(void)
 	 * Update info used for ptrace frames; use standard-format size and no
 	 * supervisor xstates:
 	 */
-	update_regset_xstate_info(fpu_user_xstate_size,	xfeatures_mask & ~XFEATURE_MASK_SUPERVISOR);
+	update_regset_xstate_info(fpu_user_xstate_size,
+				  xfeatures_mask & SUPPORTED_XFEATURES_MASK_USER);
 
 	fpu__init_prepare_fx_sw_frame();
 	setup_init_fpu_buf();
@@ -988,7 +988,7 @@ int copy_xstate_to_kernel(void *kbuf, struct xregs_state *xsave, unsigned int of
 	 */
 	memset(&header, 0, sizeof(header));
 	header.xfeatures = xsave->header.xfeatures;
-	header.xfeatures &= ~XFEATURE_MASK_SUPERVISOR;
+	header.xfeatures &= SUPPORTED_XFEATURES_MASK_USER;
 
 	/*
 	 * Copy xregs_state->header:
@@ -1072,7 +1072,7 @@ int copy_xstate_to_user(void __user *ubuf, struct xregs_state *xsave, unsigned i
 	 */
 	memset(&header, 0, sizeof(header));
 	header.xfeatures = xsave->header.xfeatures;
-	header.xfeatures &= ~XFEATURE_MASK_SUPERVISOR;
+	header.xfeatures &= SUPPORTED_XFEATURES_MASK_USER;
 
 	/*
 	 * Copy xregs_state->header:
@@ -1165,7 +1165,7 @@ int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
 	 * The state that came in from userspace was user-state only.
 	 * Mask all the user states out of 'xfeatures':
 	 */
-	xsave->header.xfeatures &= XFEATURE_MASK_SUPERVISOR;
+	xsave->header.xfeatures &= ALL_XFEATURES_MASK_SUPERVISOR;
 
 	/*
 	 * Add back in the features that came in from userspace:
@@ -1221,7 +1221,7 @@ int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf)
 	 * The state that came in from userspace was user-state only.
 	 * Mask all the user states out of 'xfeatures':
 	 */
-	xsave->header.xfeatures &= XFEATURE_MASK_SUPERVISOR;
+	xsave->header.xfeatures &= ALL_XFEATURES_MASK_SUPERVISOR;
 
 	/*
 	 * Add back in the features that came in from userspace:
-- 
2.17.1

