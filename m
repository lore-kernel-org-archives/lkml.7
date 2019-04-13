Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94B2C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C2DB2084E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfDMUwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 16:52:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36925 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfDMUwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 16:52:42 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3DKpTjw2265844
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Apr 2019 13:51:29 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3DKpTPq2265841;
        Sat, 13 Apr 2019 13:51:29 -0700
Date:   Sat, 13 Apr 2019 13:51:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-0169f53e0d97bb675075506810494bd86b8c934e@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, bp@suse.de,
        nstange@suse.de, Jason@zx2c4.com, x86@kernel.org, riel@surriel.com,
        pbonzini@redhat.com, jannh@google.com, luto@kernel.org,
        dave.hansen@intel.com, mingo@redhat.com, bigeasy@linutronix.de,
        hpa@zytor.com, aubrey.li@intel.com, tglx@linutronix.de,
        rkrcmar@redhat.com, kvm@vger.kernel.org
Reply-To: bigeasy@linutronix.de, kvm@vger.kernel.org, rkrcmar@redhat.com,
          tglx@linutronix.de, aubrey.li@intel.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, bp@suse.de, mingo@kernel.org,
          Jason@zx2c4.com, nstange@suse.de, x86@kernel.org,
          riel@surriel.com, jannh@google.com, pbonzini@redhat.com,
          luto@kernel.org, dave.hansen@intel.com, mingo@redhat.com
In-Reply-To: <20190403164156.19645-9-bigeasy@linutronix.de>
References: <20190403164156.19645-9-bigeasy@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/fpu] x86/fpu: Remove user_fpu_begin()
Git-Commit-ID: 0169f53e0d97bb675075506810494bd86b8c934e
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

Commit-ID:  0169f53e0d97bb675075506810494bd86b8c934e
Gitweb:     https://git.kernel.org/tip/0169f53e0d97bb675075506810494bd86b8c934e
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Wed, 3 Apr 2019 18:41:37 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 10 Apr 2019 15:58:44 +0200

x86/fpu: Remove user_fpu_begin()

user_fpu_begin() sets fpu_fpregs_owner_ctx to task's fpu struct. This is
always the case since there is no lazy FPU anymore.

fpu_fpregs_owner_ctx is used during context switch to decide if it needs
to load the saved registers or if the currently loaded registers are
valid. It could be skipped during a

  taskA -> kernel thread -> taskA

switch because the switch to the kernel thread would not alter the CPU's
sFPU tate.

Since this field is always updated during context switch and
never invalidated, setting it manually (in user context) makes no
difference. A kernel thread with kernel_fpu_begin() block could
set fpu_fpregs_owner_ctx to NULL but a kernel thread does not use
user_fpu_begin().

This is a leftover from the lazy-FPU time.

Remove user_fpu_begin(), it does not change fpu_fpregs_owner_ctx's
content.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Aubrey Li <aubrey.li@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: kvm ML <kvm@vger.kernel.org>
Cc: Nicolai Stange <nstange@suse.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190403164156.19645-9-bigeasy@linutronix.de
---
 arch/x86/include/asm/fpu/internal.h | 17 -----------------
 arch/x86/kernel/fpu/core.c          |  4 +---
 arch/x86/kernel/fpu/signal.c        |  1 -
 3 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 04042eacc852..54f70cae2f15 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -532,23 +532,6 @@ static inline void switch_fpu_finish(struct fpu *new_fpu, int cpu)
 	}
 }
 
-/*
- * Needs to be preemption-safe.
- *
- * NOTE! user_fpu_begin() must be used only immediately before restoring
- * the save state. It does not do any saving/restoring on its own. In
- * lazy FPU mode, it is just an optimization to avoid a #NM exception,
- * the task can lose the FPU right after preempt_enable().
- */
-static inline void user_fpu_begin(void)
-{
-	struct fpu *fpu = &current->thread.fpu;
-
-	preempt_disable();
-	fpregs_activate(fpu);
-	preempt_enable();
-}
-
 /*
  * MXCSR and XCR definitions:
  */
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 97e27de2b7c0..739ca3ae2bdc 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -335,10 +335,8 @@ void fpu__clear(struct fpu *fpu)
 	 * Make sure fpstate is cleared and initialized.
 	 */
 	fpu__initialize(fpu);
-	if (static_cpu_has(X86_FEATURE_FPU)) {
-		user_fpu_begin();
+	if (static_cpu_has(X86_FEATURE_FPU))
 		copy_init_fpstate_to_fpregs();
-	}
 }
 
 /*
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 34989d2a8893..155f4552413e 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -322,7 +322,6 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 		 * For 64-bit frames and 32-bit fsave frames, restore the user
 		 * state to the registers directly (with exceptions handled).
 		 */
-		user_fpu_begin();
 		if (copy_user_to_fpregs_zeroing(buf_fx, xfeatures, fx_only)) {
 			fpu__clear(fpu);
 			return -1;
