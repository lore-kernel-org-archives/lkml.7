Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C9BC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B682084E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfDMUzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 16:55:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59653 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfDMUzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 16:55:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3DKrZ7S2265986
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Apr 2019 13:53:35 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3DKrYqn2265983;
        Sat, 13 Apr 2019 13:53:34 -0700
Date:   Sat, 13 Apr 2019 13:53:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-abd16d68d65229e5acafdadc32704239131bf2ea@git.kernel.org>
Cc:     x86@kernel.org, peterz@infradead.org,
        Siarhei.Liakh@concurrent-rt.com, mingo@redhat.com,
        rkrcmar@redhat.com, luto@kernel.org, bigeasy@linutronix.de,
        mhiramat@kernel.org, bp@suse.de, kvm@vger.kernel.org,
        riel@surriel.com, hpa@zytor.com, sergey.senozhatsky@gmail.com,
        dave.hansen@linux.intel.com, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, Jason@zx2c4.com,
        pbonzini@redhat.com, jannh@google.com, tglx@linutronix.de,
        linux@rasmusvillemoes.dk, ebiederm@xmission.com
Reply-To: ebiederm@xmission.com, riel@surriel.com,
          linux@rasmusvillemoes.dk, kvm@vger.kernel.org,
          tglx@linutronix.de, jannh@google.com, bp@suse.de,
          mhiramat@kernel.org, sergey.senozhatsky@gmail.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, Siarhei.Liakh@concurrent-rt.com,
          mingo@redhat.com, dave.hansen@intel.com, peterz@infradead.org,
          x86@kernel.org, dave.hansen@linux.intel.com, pbonzini@redhat.com,
          Jason@zx2c4.com, bigeasy@linutronix.de, rkrcmar@redhat.com,
          mingo@kernel.org, luto@kernel.org
In-Reply-To: <20190403164156.19645-12-bigeasy@linutronix.de>
References: <20190403164156.19645-12-bigeasy@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/fpu] x86/fpu: Use a feature number instead of mask in two
 more helpers
Git-Commit-ID: abd16d68d65229e5acafdadc32704239131bf2ea
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

Commit-ID:  abd16d68d65229e5acafdadc32704239131bf2ea
Gitweb:     https://git.kernel.org/tip/abd16d68d65229e5acafdadc32704239131bf2ea
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Wed, 3 Apr 2019 18:41:40 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 10 Apr 2019 18:20:27 +0200

x86/fpu: Use a feature number instead of mask in two more helpers

After changing the argument of __raw_xsave_addr() from a mask to
number Dave suggested to check if it makes sense to do the same for
get_xsave_addr(). As it turns out it does.

Only get_xsave_addr() needs the mask to check if the requested feature
is part of what is supported/saved and then uses the number again. The
shift operation is cheaper compared to fls64() (find last bit set).
Also, the feature number uses less opcode space compared to the mask. :)

Make the get_xsave_addr() argument a xfeature number instead of a mask
and fix up its callers.

Furthermore, use xfeature_nr and xfeature_mask consistently.

This results in the following changes to the kvm code:

  feature -> xfeature_mask
  index -> xfeature_nr

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: kvm ML <kvm@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Rik van Riel <riel@surriel.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Siarhei Liakh <Siarhei.Liakh@concurrent-rt.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190403164156.19645-12-bigeasy@linutronix.de
---
 arch/x86/include/asm/fpu/xstate.h |  4 ++--
 arch/x86/kernel/fpu/xstate.c      | 22 ++++++++++------------
 arch/x86/kernel/traps.c           |  2 +-
 arch/x86/kvm/x86.c                | 28 ++++++++++++++--------------
 arch/x86/mm/mpx.c                 |  6 +++---
 5 files changed, 30 insertions(+), 32 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 48581988d78c..fbe41f808e5d 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -46,8 +46,8 @@ extern void __init update_regset_xstate_info(unsigned int size,
 					     u64 xstate_mask);
 
 void fpu__xstate_clear_all_cpu_caps(void);
-void *get_xsave_addr(struct xregs_state *xsave, int xstate);
-const void *get_xsave_field_ptr(int xstate_field);
+void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr);
+const void *get_xsave_field_ptr(int xfeature_nr);
 int using_compacted_format(void);
 int copy_xstate_to_kernel(void *kbuf, struct xregs_state *xsave, unsigned int offset, unsigned int size);
 int copy_xstate_to_user(void __user *ubuf, struct xregs_state *xsave, unsigned int offset, unsigned int size);
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 4f7f3c5d0d0c..9c459fd1d38e 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -830,15 +830,14 @@ static void *__raw_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
  *
  * Inputs:
  *	xstate: the thread's storage area for all FPU data
- *	xstate_feature: state which is defined in xsave.h (e.g.
- *	XFEATURE_MASK_FP, XFEATURE_MASK_SSE, etc...)
+ *	xfeature_nr: state which is defined in xsave.h (e.g. XFEATURE_FP,
+ *	XFEATURE_SSE, etc...)
  * Output:
  *	address of the state in the xsave area, or NULL if the
  *	field is not present in the xsave buffer.
  */
-void *get_xsave_addr(struct xregs_state *xsave, int xstate_feature)
+void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
 {
-	int xfeature_nr;
 	/*
 	 * Do we even *have* xsave state?
 	 */
@@ -850,11 +849,11 @@ void *get_xsave_addr(struct xregs_state *xsave, int xstate_feature)
 	 * have not enabled.  Remember that pcntxt_mask is
 	 * what we write to the XCR0 register.
 	 */
-	WARN_ONCE(!(xfeatures_mask & xstate_feature),
+	WARN_ONCE(!(xfeatures_mask & BIT_ULL(xfeature_nr)),
 		  "get of unsupported state");
 	/*
 	 * This assumes the last 'xsave*' instruction to
-	 * have requested that 'xstate_feature' be saved.
+	 * have requested that 'xfeature_nr' be saved.
 	 * If it did not, we might be seeing and old value
 	 * of the field in the buffer.
 	 *
@@ -863,10 +862,9 @@ void *get_xsave_addr(struct xregs_state *xsave, int xstate_feature)
 	 * or because the "init optimization" caused it
 	 * to not be saved.
 	 */
-	if (!(xsave->header.xfeatures & xstate_feature))
+	if (!(xsave->header.xfeatures & BIT_ULL(xfeature_nr)))
 		return NULL;
 
-	xfeature_nr = fls64(xstate_feature) - 1;
 	return __raw_xsave_addr(xsave, xfeature_nr);
 }
 EXPORT_SYMBOL_GPL(get_xsave_addr);
@@ -882,13 +880,13 @@ EXPORT_SYMBOL_GPL(get_xsave_addr);
  * Note that this only works on the current task.
  *
  * Inputs:
- *	@xsave_state: state which is defined in xsave.h (e.g. XFEATURE_MASK_FP,
- *	XFEATURE_MASK_SSE, etc...)
+ *	@xfeature_nr: state which is defined in xsave.h (e.g. XFEATURE_FP,
+ *	XFEATURE_SSE, etc...)
  * Output:
  *	address of the state in the xsave area or NULL if the state
  *	is not present or is in its 'init state'.
  */
-const void *get_xsave_field_ptr(int xsave_state)
+const void *get_xsave_field_ptr(int xfeature_nr)
 {
 	struct fpu *fpu = &current->thread.fpu;
 
@@ -898,7 +896,7 @@ const void *get_xsave_field_ptr(int xsave_state)
 	 */
 	fpu__save(fpu);
 
-	return get_xsave_addr(&fpu->state.xsave, xsave_state);
+	return get_xsave_addr(&fpu->state.xsave, xfeature_nr);
 }
 
 #ifdef CONFIG_ARCH_HAS_PKEYS
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index d26f9e9c3d83..8b6d03e55d2f 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -456,7 +456,7 @@ dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
 	 * which is all zeros which indicates MPX was not
 	 * responsible for the exception.
 	 */
-	bndcsr = get_xsave_field_ptr(XFEATURE_MASK_BNDCSR);
+	bndcsr = get_xsave_field_ptr(XFEATURE_BNDCSR);
 	if (!bndcsr)
 		goto exit_trap;
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 099b851dabaf..8022e7769b3a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3674,15 +3674,15 @@ static void fill_xsave(u8 *dest, struct kvm_vcpu *vcpu)
 	 */
 	valid = xstate_bv & ~XFEATURE_MASK_FPSSE;
 	while (valid) {
-		u64 feature = valid & -valid;
-		int index = fls64(feature) - 1;
-		void *src = get_xsave_addr(xsave, feature);
+		u64 xfeature_mask = valid & -valid;
+		int xfeature_nr = fls64(xfeature_mask) - 1;
+		void *src = get_xsave_addr(xsave, xfeature_nr);
 
 		if (src) {
 			u32 size, offset, ecx, edx;
-			cpuid_count(XSTATE_CPUID, index,
+			cpuid_count(XSTATE_CPUID, xfeature_nr,
 				    &size, &offset, &ecx, &edx);
-			if (feature == XFEATURE_MASK_PKRU)
+			if (xfeature_nr == XFEATURE_PKRU)
 				memcpy(dest + offset, &vcpu->arch.pkru,
 				       sizeof(vcpu->arch.pkru));
 			else
@@ -3690,7 +3690,7 @@ static void fill_xsave(u8 *dest, struct kvm_vcpu *vcpu)
 
 		}
 
-		valid -= feature;
+		valid -= xfeature_mask;
 	}
 }
 
@@ -3717,22 +3717,22 @@ static void load_xsave(struct kvm_vcpu *vcpu, u8 *src)
 	 */
 	valid = xstate_bv & ~XFEATURE_MASK_FPSSE;
 	while (valid) {
-		u64 feature = valid & -valid;
-		int index = fls64(feature) - 1;
-		void *dest = get_xsave_addr(xsave, feature);
+		u64 xfeature_mask = valid & -valid;
+		int xfeature_nr = fls64(xfeature_mask) - 1;
+		void *dest = get_xsave_addr(xsave, xfeature_nr);
 
 		if (dest) {
 			u32 size, offset, ecx, edx;
-			cpuid_count(XSTATE_CPUID, index,
+			cpuid_count(XSTATE_CPUID, xfeature_nr,
 				    &size, &offset, &ecx, &edx);
-			if (feature == XFEATURE_MASK_PKRU)
+			if (xfeature_nr == XFEATURE_PKRU)
 				memcpy(&vcpu->arch.pkru, src + offset,
 				       sizeof(vcpu->arch.pkru));
 			else
 				memcpy(dest, src + offset, size);
 		}
 
-		valid -= feature;
+		valid -= xfeature_mask;
 	}
 }
 
@@ -8850,11 +8850,11 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 		if (init_event)
 			kvm_put_guest_fpu(vcpu);
 		mpx_state_buffer = get_xsave_addr(&vcpu->arch.guest_fpu->state.xsave,
-					XFEATURE_MASK_BNDREGS);
+					XFEATURE_BNDREGS);
 		if (mpx_state_buffer)
 			memset(mpx_state_buffer, 0, sizeof(struct mpx_bndreg_state));
 		mpx_state_buffer = get_xsave_addr(&vcpu->arch.guest_fpu->state.xsave,
-					XFEATURE_MASK_BNDCSR);
+					XFEATURE_BNDCSR);
 		if (mpx_state_buffer)
 			memset(mpx_state_buffer, 0, sizeof(struct mpx_bndcsr));
 		if (init_event)
diff --git a/arch/x86/mm/mpx.c b/arch/x86/mm/mpx.c
index c805db6236b4..59726aaf4671 100644
--- a/arch/x86/mm/mpx.c
+++ b/arch/x86/mm/mpx.c
@@ -142,7 +142,7 @@ int mpx_fault_info(struct mpx_fault_info *info, struct pt_regs *regs)
 		goto err_out;
 	}
 	/* get bndregs field from current task's xsave area */
-	bndregs = get_xsave_field_ptr(XFEATURE_MASK_BNDREGS);
+	bndregs = get_xsave_field_ptr(XFEATURE_BNDREGS);
 	if (!bndregs) {
 		err = -EINVAL;
 		goto err_out;
@@ -190,7 +190,7 @@ static __user void *mpx_get_bounds_dir(void)
 	 * The bounds directory pointer is stored in a register
 	 * only accessible if we first do an xsave.
 	 */
-	bndcsr = get_xsave_field_ptr(XFEATURE_MASK_BNDCSR);
+	bndcsr = get_xsave_field_ptr(XFEATURE_BNDCSR);
 	if (!bndcsr)
 		return MPX_INVALID_BOUNDS_DIR;
 
@@ -376,7 +376,7 @@ static int do_mpx_bt_fault(void)
 	const struct mpx_bndcsr *bndcsr;
 	struct mm_struct *mm = current->mm;
 
-	bndcsr = get_xsave_field_ptr(XFEATURE_MASK_BNDCSR);
+	bndcsr = get_xsave_field_ptr(XFEATURE_BNDCSR);
 	if (!bndcsr)
 		return -EINVAL;
 	/*
