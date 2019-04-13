Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8392AC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C2852084E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfDMUvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 16:51:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58395 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbfDMUvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 16:51:17 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3DKo4KN2265429
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Apr 2019 13:50:04 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3DKo3Ss2265422;
        Sat, 13 Apr 2019 13:50:03 -0700
Date:   Sat, 13 Apr 2019 13:50:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-39388e80f9b0c3788bfb6efe3054bdce0c3ead45@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        jannh@google.com, bigeasy@linutronix.de, rkrcmar@redhat.com,
        hpa@zytor.com, mingo@kernel.org, luto@kernel.org, riel@surriel.com,
        Jason@zx2c4.com, tglx@linutronix.de, pbonzini@redhat.com,
        x86@kernel.org, bp@suse.de, mingo@redhat.com, dave.hansen@intel.com
Reply-To: tglx@linutronix.de, Jason@zx2c4.com, riel@surriel.com,
          luto@kernel.org, mingo@kernel.org, dave.hansen@intel.com,
          mingo@redhat.com, bp@suse.de, x86@kernel.org,
          pbonzini@redhat.com, jannh@google.com, kvm@vger.kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, rkrcmar@redhat.com,
          bigeasy@linutronix.de
In-Reply-To: <20190403164156.19645-7-bigeasy@linutronix.de>
References: <20190403164156.19645-7-bigeasy@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/fpu] x86/fpu: Don't save fxregs for ia32 frames in
 copy_fpstate_to_sigframe()
Git-Commit-ID: 39388e80f9b0c3788bfb6efe3054bdce0c3ead45
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

Commit-ID:  39388e80f9b0c3788bfb6efe3054bdce0c3ead45
Gitweb:     https://git.kernel.org/tip/39388e80f9b0c3788bfb6efe3054bdce0c3ead45
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Wed, 3 Apr 2019 18:41:35 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 10 Apr 2019 14:46:35 +0200

x86/fpu: Don't save fxregs for ia32 frames in copy_fpstate_to_sigframe()

In commit

  72a671ced66db ("x86, fpu: Unify signal handling code paths for x86 and x86_64 kernels")

the 32bit and 64bit path of the signal delivery code were merged.

The 32bit version:

  int save_i387_xstate_ia32(void __user *buf)
  …
         if (cpu_has_xsave)
                 return save_i387_xsave(fp);
         if (cpu_has_fxsr)
                 return save_i387_fxsave(fp);

The 64bit version:

  int save_i387_xstate(void __user *buf)
  …
         if (user_has_fpu()) {
                 if (use_xsave())
                         err = xsave_user(buf);
                 else
                         err = fxsave_user(buf);

                 if (unlikely(err)) {
                         __clear_user(buf, xstate_size);
                         return err;

The merge:

  int save_xstate_sig(void __user *buf, void __user *buf_fx, int size)
  …
         if (user_has_fpu()) {
                 /* Save the live register state to the user directly. */
                 if (save_user_xstate(buf_fx))
                         return -1;
                 /* Update the thread's fxstate to save the fsave header. */
                 if (ia32_fxstate)
                         fpu_fxsave(&tsk->thread.fpu);

I don't think that we needed to save the FPU registers to ->thread.fpu
because the registers were stored in buf_fx. Today the state will be
restored from buf_fx after the signal was handled (I assume that this
was also the case with lazy-FPU).

Since commit

  66463db4fc560 ("x86, fpu: shift drop_init_fpu() from save_xstate_sig() to handle_signal()")

it is ensured that the signal handler starts with clear/fresh set of FPU
registers which means that the previous store is futile.

Remove the copy_fxregs_to_kernel() call because task's FPU state is
cleared later in handle_signal() via fpu__clear().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: kvm ML <kvm@vger.kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190403164156.19645-7-bigeasy@linutronix.de
---
 arch/x86/kernel/fpu/signal.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index c1a5999affa0..34989d2a8893 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -155,7 +155,6 @@ static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
  */
 int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 {
-	struct fpu *fpu = &current->thread.fpu;
 	struct task_struct *tsk = current;
 	int ia32_fxstate = (buf != buf_fx);
 
@@ -173,9 +172,6 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 	/* Save the live registers state to the user frame directly. */
 	if (copy_fpregs_to_sigframe(buf_fx))
 		return -1;
-	/* Update the thread's fxstate to save the fsave header. */
-	if (ia32_fxstate)
-		copy_fxregs_to_kernel(fpu);
 
 	/* Save the fsave header for the 32-bit frames. */
 	if ((ia32_fxstate || !use_fxsr()) && save_fsave_header(tsk, buf))
