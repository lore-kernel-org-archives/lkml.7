Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2E7C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 17:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0696C2083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 17:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbfFFRbB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 13:31:01 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47542 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbfFFRbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 13:31:00 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hYwDn-0003iG-8I; Thu, 06 Jun 2019 19:30:39 +0200
Date:   Thu, 6 Jun 2019 19:30:39 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Borislav Petkov <bp@suse.de>, Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        kvm ML <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Rik van Riel <riel@surriel.com>, x86-ml <x86@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [5.2 regression] copy_fpstate_to_sigframe() change causing crash
 in 32-bit process
Message-ID: <20190606173026.ty7c4cvftrvfrwy3@linutronix.de>
References: <20190604185358.GA820@sol.localdomain>
 <20190605140405.2nnpqslnjpfe2ig2@linutronix.de>
 <20190605173256.GA86462@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190605173256.GA86462@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-05 10:32:57 [-0700], Eric Biggers wrote:
> As I said, the commit looks broken to me.  save_fsave_header() reads from
> tsk->thread.fpu.state.fxsave, which due to that commit isn't being updated with
> the latest registers.  Am I missing something?  Note the comment you deleted:

So if your system uses fxsr() then that function shouldn't matter. If
your system uses xsave() (which I believe it does) then the first
section is the "fxregs state" which is the same as in fxsr's case (see
struct xregs_state). So it shouldn't make a difference and that is why I
strongly assumed it is a miss-merge. However it makes a difference…

So the hunk at the end should make things work again (my FPU test case
passes). I don't know why we convert things forth and back in the signal
handler but I think something here is different for xsave's legacy area
vs fxsave.

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 060d6188b4533..c653c9920c5e0 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -62,16 +62,7 @@ static inline int save_fsave_header(struct task_struct *tsk, void __user *buf)
 		struct user_i387_ia32_struct env;
 		struct _fpstate_32 __user *fp = buf;
 
-		convert_from_fxsr(&env, tsk);
-
-		if (__copy_to_user(buf, &env, sizeof(env)) ||
-		    __put_user(xsave->i387.swd, &fp->status) ||
-		    __put_user(X86_FXSR_MAGIC, &fp->magic))
-			return -1;
-	} else {
-		struct fregs_state __user *fp = buf;
-		u32 swd;
-		if (__get_user(swd, &fp->swd) || __put_user(swd, &fp->status))
+		if (__put_user(X86_FXSR_MAGIC, &fp->magic))
 			return -1;
 	}
 
@@ -236,9 +227,6 @@ sanitize_restored_xstate(union fpregs_state *state,
 		 * reasons.
 		 */
 		xsave->i387.mxcsr &= mxcsr_feature_mask;
-
-		if (ia32_env)
-			convert_to_fxsr(&state->fxsave, ia32_env);
 	}
 }
 

> - Eric

Sebastian
