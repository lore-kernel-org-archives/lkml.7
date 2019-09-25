Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58F9C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B066E205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439703AbfIYP3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 11:29:17 -0400
Received: from mga03.intel.com ([134.134.136.65]:20435 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731744AbfIYP27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 11:28:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2019 08:28:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,548,1559545200"; 
   d="scan'208";a="196032279"
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
Subject: [PATCH 3/6] x86/fpu/xstate: Separate user and supervisor xfeatures mask
Date:   Wed, 25 Sep 2019 08:10:19 -0700
Message-Id: <20190925151022.21688-4-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190925151022.21688-1-yu-cheng.yu@intel.com>
References: <20190925151022.21688-1-yu-cheng.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before the introduction of XSAVES supervisor states, 'xfeatures_mask' is
used at various places to determine XSAVE buffer components and XCR0 bits.
It contains only user xstates.  To support supervisor xstates, it is
necessary to separate user and supervisor xstates:

- First, change 'xfeatures_mask' to 'xfeatures_mask_all', which represents
  the full set of bits that should ever be set in a kernel XSAVE buffer.
- Introduce xfeature_mask_supervisor() and xfeatures_mask_user() to
  extract relevant xfeatures from xfeatures_mask_all.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/fpu/internal.h |  2 +-
 arch/x86/include/asm/fpu/xstate.h   |  8 ++-
 arch/x86/kernel/fpu/signal.c        | 15 ++++--
 arch/x86/kernel/fpu/xstate.c        | 78 +++++++++++++++++------------
 4 files changed, 65 insertions(+), 38 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 4c95c365058a..f56ad1248b5d 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -92,7 +92,7 @@ static inline void fpstate_init_xstate(struct xregs_state *xsave)
 	 * XRSTORS requires these bits set in xcomp_bv, or it will
 	 * trigger #GP:
 	 */
-	xsave->header.xcomp_bv = XCOMP_BV_COMPACTED_FORMAT | xfeatures_mask;
+	xsave->header.xcomp_bv = XCOMP_BV_COMPACTED_FORMAT | xfeatures_mask_all;
 }
 
 static inline void fpstate_init_fxstate(struct fxregs_state *fx)
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 014c386deaa3..5954bd97da16 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -51,7 +51,13 @@
 #define REX_PREFIX
 #endif
 
-extern u64 xfeatures_mask;
+extern u64 xfeatures_mask_all;
+
+static inline u64 xfeatures_mask_user(void)
+{
+	return xfeatures_mask_all & SUPPORTED_XFEATURES_MASK_USER;
+}
+
 extern u64 xstate_fx_sw_bytes[USER_XSTATE_FX_SW_WORDS];
 
 extern void __init update_regset_xstate_info(unsigned int size,
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 0071b794ed19..c1f0688f35cf 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -254,11 +254,14 @@ static int copy_user_to_fpregs_zeroing(void __user *buf, u64 xbv, int fx_only)
 {
 	if (use_xsave()) {
 		if (fx_only) {
-			u64 init_bv = xfeatures_mask & ~XFEATURE_MASK_FPSSE;
+			u64 init_bv;
+
+			init_bv = xfeatures_mask_user() & ~XFEATURE_MASK_FPSSE;
 			copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
 			return copy_user_to_fxregs(buf);
 		} else {
-			u64 init_bv = xfeatures_mask & ~xbv;
+			u64 init_bv = xfeatures_mask_user() & ~xbv;
+
 			if (unlikely(init_bv))
 				copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
 			return copy_user_to_xregs(buf, xbv);
@@ -357,7 +360,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 
 
 	if (use_xsave() && !fx_only) {
-		u64 init_bv = xfeatures_mask & ~xfeatures;
+		u64 init_bv = xfeatures_mask_user() & ~xfeatures;
 
 		if (using_compacted_format()) {
 			ret = copy_user_to_xstate(&fpu->state.xsave, buf_fx);
@@ -388,7 +391,9 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 
 		fpregs_lock();
 		if (use_xsave()) {
-			u64 init_bv = xfeatures_mask & ~XFEATURE_MASK_FPSSE;
+			u64 init_bv;
+
+			init_bv = xfeatures_mask_user() & ~XFEATURE_MASK_FPSSE;
 			copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
 		}
 
@@ -462,7 +467,7 @@ void fpu__init_prepare_fx_sw_frame(void)
 
 	fx_sw_reserved.magic1 = FP_XSTATE_MAGIC1;
 	fx_sw_reserved.extended_size = size;
-	fx_sw_reserved.xfeatures = xfeatures_mask;
+	fx_sw_reserved.xfeatures = xfeatures_mask_user();
 	fx_sw_reserved.xstate_size = fpu_user_xstate_size;
 
 	if (IS_ENABLED(CONFIG_IA32_EMULATION) ||
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 4f99a747b4f1..b7f2808dd3f4 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -54,13 +54,14 @@ static short xsave_cpuid_features[] __initdata = {
 };
 
 /*
- * Mask of xstate features supported by the CPU and the kernel:
+ * This represents the full set of bits that should ever be set in a kernel
+ * XSAVE buffer, both supervisor and user xstates.
  */
-u64 xfeatures_mask __read_mostly;
+u64 xfeatures_mask_all __read_mostly;
 
 static unsigned int xstate_offsets[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] = -1};
 static unsigned int xstate_sizes[XFEATURE_MAX]   = { [ 0 ... XFEATURE_MAX - 1] = -1};
-static unsigned int xstate_comp_offsets[sizeof(xfeatures_mask) * 8];
+static unsigned int xstate_comp_offsets[sizeof(xfeatures_mask_all) * 8];
 
 /*
  * The XSAVE area of kernel can be in standard or compacted format;
@@ -76,7 +77,7 @@ unsigned int fpu_user_xstate_size;
  */
 int cpu_has_xfeatures(u64 xfeatures_needed, const char **feature_name)
 {
-	u64 xfeatures_missing = xfeatures_needed & ~xfeatures_mask;
+	u64 xfeatures_missing = xfeatures_needed & ~xfeatures_mask_all;
 
 	if (unlikely(feature_name)) {
 		long xfeature_idx, max_idx;
@@ -154,7 +155,7 @@ void fpstate_sanitize_xstate(struct fpu *fpu)
 	 * None of the feature bits are in init state. So nothing else
 	 * to do for us, as the memory layout is up to date.
 	 */
-	if ((xfeatures & xfeatures_mask) == xfeatures_mask)
+	if ((xfeatures & xfeatures_mask_all) == xfeatures_mask_all)
 		return;
 
 	/*
@@ -181,7 +182,7 @@ void fpstate_sanitize_xstate(struct fpu *fpu)
 	 * in a special way already:
 	 */
 	feature_bit = 0x2;
-	xfeatures = (xfeatures_mask & ~xfeatures) >> 2;
+	xfeatures = (xfeatures_mask_user() & ~xfeatures) >> 2;
 
 	/*
 	 * Update all the remaining memory layouts according to their
@@ -203,25 +204,35 @@ void fpstate_sanitize_xstate(struct fpu *fpu)
 	}
 }
 
+static inline u64 xfeatures_mask_supervisor(void)
+{
+	return xfeatures_mask_all & SUPPORTED_XFEATURES_MASK_SUPERVISOR;
+}
+
 /*
  * Enable the extended processor state save/restore feature.
  * Called once per CPU onlining.
  */
 void fpu__init_cpu_xstate(void)
 {
-	if (!boot_cpu_has(X86_FEATURE_XSAVE) || !xfeatures_mask)
+	if (!boot_cpu_has(X86_FEATURE_XSAVE) || !xfeatures_mask_all)
 		return;
 	/*
 	 * Unsupported supervisor xstates should not be found in
 	 * the xfeatures mask.
 	 */
-	WARN_ONCE((xfeatures_mask & UNSUPPORTED_XFEATURES_MASK_SUPERVISOR),
+	WARN_ONCE((xfeatures_mask_all & UNSUPPORTED_XFEATURES_MASK_SUPERVISOR),
 		  "x86/fpu: Found unsupported supervisor xstates.\n");
 
-	xfeatures_mask &= ~UNSUPPORTED_XFEATURES_MASK_SUPERVISOR;
+	xfeatures_mask_all &= ~UNSUPPORTED_XFEATURES_MASK_SUPERVISOR;
 
 	cr4_set_bits(X86_CR4_OSXSAVE);
-	xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask);
+	/*
+	 * XCR_XFEATURE_ENABLED_MASK (aka. XCR0) sets user features
+	 * managed by XSAVE{C, OPT, S} and XRSTOR{S}.  Only XSAVE user
+	 * states can be set here.
+	 */
+	xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask_user());
 }
 
 /*
@@ -231,7 +242,7 @@ void fpu__init_cpu_xstate(void)
  */
 static int xfeature_enabled(enum xfeature xfeature)
 {
-	return !!(xfeatures_mask & (1UL << xfeature));
+	return !!(xfeatures_mask_all & (1UL << xfeature));
 }
 
 /*
@@ -337,7 +348,7 @@ static int xfeature_is_aligned(int xfeature_nr)
  */
 static void __init setup_xstate_comp(void)
 {
-	unsigned int xstate_comp_sizes[sizeof(xfeatures_mask) * 8];
+	unsigned int xstate_comp_sizes[sizeof(xfeatures_mask_all) * 8];
 	int i;
 
 	/*
@@ -411,7 +422,7 @@ static void __init setup_init_fpu_buf(void)
 
 	if (boot_cpu_has(X86_FEATURE_XSAVES))
 		init_fpstate.xsave.header.xcomp_bv = XCOMP_BV_COMPACTED_FORMAT |
-						     xfeatures_mask;
+						     xfeatures_mask_all;
 
 	/*
 	 * Init all the features state with header.xfeatures being 0x0
@@ -471,7 +482,7 @@ int using_compacted_format(void)
 int validate_xstate_header(const struct xstate_header *hdr)
 {
 	/* No unknown or supervisor features may be set */
-	if (hdr->xfeatures & ~(xfeatures_mask & SUPPORTED_XFEATURES_MASK_USER))
+	if (hdr->xfeatures & ~xfeatures_mask_user())
 		return -EINVAL;
 
 	/* Userspace must use the uncompacted format */
@@ -606,7 +617,7 @@ static void do_extra_xstate_size_checks(void)
 
 
 /*
- * Get total size of enabled xstates in XCR0/xfeatures_mask.
+ * Get total size of enabled xstates in XCR0 | IA32_XSS.
  *
  * Note the SDM's wording here.  "sub-function 0" only enumerates
  * the size of the *user* states.  If we use it to size a buffer
@@ -696,7 +707,7 @@ static int __init init_xstate_size(void)
  */
 static void fpu__init_disable_system_xstate(void)
 {
-	xfeatures_mask = 0;
+	xfeatures_mask_all = 0;
 	cr4_clear_bits(X86_CR4_OSXSAVE);
 	setup_clear_cpu_cap(X86_FEATURE_XSAVE);
 }
@@ -731,16 +742,22 @@ void __init fpu__init_system_xstate(void)
 		return;
 	}
 
+	/*
+	 * Find user xstates supported by the processor.
+	 */
 	cpuid_count(XSTATE_CPUID, 0, &eax, &ebx, &ecx, &edx);
-	xfeatures_mask = eax + ((u64)edx << 32);
+	xfeatures_mask_all = eax + ((u64)edx << 32);
+
+	/* Place supervisor features in xfeatures_mask_all here */
 
-	if ((xfeatures_mask & XFEATURE_MASK_FPSSE) != XFEATURE_MASK_FPSSE) {
+	if ((xfeatures_mask_user() & XFEATURE_MASK_FPSSE) != XFEATURE_MASK_FPSSE) {
 		/*
 		 * This indicates that something really unexpected happened
 		 * with the enumeration.  Disable XSAVE and try to continue
 		 * booting without it.  This is too early to BUG().
 		 */
-		pr_err("x86/fpu: FP/SSE not present amongst the CPU's xstate features: 0x%llx.\n", xfeatures_mask);
+		pr_err("x86/fpu: FP/SSE not present amongst the CPU's xstate features: 0x%llx.\n",
+		       xfeatures_mask_all);
 		goto out_disable;
 	}
 
@@ -749,10 +766,10 @@ void __init fpu__init_system_xstate(void)
 	 */
 	for (i = 0; i < ARRAY_SIZE(xsave_cpuid_features); i++) {
 		if (!boot_cpu_has(xsave_cpuid_features[i]))
-			xfeatures_mask &= ~BIT(i);
+			xfeatures_mask_all &= ~BIT_ULL(i);
 	}
 
-	xfeatures_mask &= fpu__get_supported_xfeatures_mask();
+	xfeatures_mask_all &= fpu__get_supported_xfeatures_mask();
 
 	/* Enable xstate instructions to be able to continue with initialization: */
 	fpu__init_cpu_xstate();
@@ -764,16 +781,16 @@ void __init fpu__init_system_xstate(void)
 	 * Update info used for ptrace frames; use standard-format size and no
 	 * supervisor xstates:
 	 */
-	update_regset_xstate_info(fpu_user_xstate_size,
-				  xfeatures_mask & SUPPORTED_XFEATURES_MASK_USER);
+	update_regset_xstate_info(fpu_user_xstate_size, xfeatures_mask_user());
 
 	fpu__init_prepare_fx_sw_frame();
 	setup_init_fpu_buf();
 	setup_xstate_comp();
 	print_xstate_offset_size();
 
-	pr_info("x86/fpu: Enabled xstate features 0x%llx, context size is %d bytes, using '%s' format.\n",
-		xfeatures_mask,
+	pr_info("x86/fpu: Enabled xstate features 0x%llx: user 0x%llx, context size is %d bytes, using '%s' format.\n",
+		xfeatures_mask_all,
+		xfeatures_mask_user(),
 		fpu_kernel_xstate_size,
 		boot_cpu_has(X86_FEATURE_XSAVES) ? "compacted" : "standard");
 	return;
@@ -792,7 +809,7 @@ void fpu__resume_cpu(void)
 	 * Restore XCR0 on xsave capable CPUs:
 	 */
 	if (boot_cpu_has(X86_FEATURE_XSAVE))
-		xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask);
+		xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask_user());
 }
 
 /*
@@ -837,10 +854,9 @@ void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
 
 	/*
 	 * We should not ever be requesting features that we
-	 * have not enabled.  Remember that pcntxt_mask is
-	 * what we write to the XCR0 register.
+	 * have not enabled.
 	 */
-	WARN_ONCE(!(xfeatures_mask & BIT_ULL(xfeature_nr)),
+	WARN_ONCE(!(xfeatures_mask_all & BIT_ULL(xfeature_nr)),
 		  "get of unsupported state");
 	/*
 	 * This assumes the last 'xsave*' instruction to
@@ -988,7 +1004,7 @@ int copy_xstate_to_kernel(void *kbuf, struct xregs_state *xsave, unsigned int of
 	 */
 	memset(&header, 0, sizeof(header));
 	header.xfeatures = xsave->header.xfeatures;
-	header.xfeatures &= SUPPORTED_XFEATURES_MASK_USER;
+	header.xfeatures &= xfeatures_mask_user();
 
 	/*
 	 * Copy xregs_state->header:
@@ -1072,7 +1088,7 @@ int copy_xstate_to_user(void __user *ubuf, struct xregs_state *xsave, unsigned i
 	 */
 	memset(&header, 0, sizeof(header));
 	header.xfeatures = xsave->header.xfeatures;
-	header.xfeatures &= SUPPORTED_XFEATURES_MASK_USER;
+	header.xfeatures &= xfeatures_mask_user();
 
 	/*
 	 * Copy xregs_state->header:
-- 
2.17.1

