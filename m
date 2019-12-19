Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C73C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 182E6222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfLSOW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 09:22:26 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60103 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbfLSOWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 09:22:25 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ihwgz-0005lY-97; Thu, 19 Dec 2019 15:22:17 +0100
Date:   Thu, 19 Dec 2019 15:22:17 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Rik van Riel <riel@surriel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 3/3] x86/fpu/xstate: Invalidate fpregs when
 __fpu_restore_sig() fails
Message-ID: <20191219142217.axgpqlb7zzluoxnf@linutronix.de>
References: <20191212210855.19260-1-yu-cheng.yu@intel.com>
 <20191212210855.19260-4-yu-cheng.yu@intel.com>
 <20191218155449.sk4gjabtynh67jqb@linutronix.de>
 <587463c4e5fa82dff8748e5f753890ac390e993e.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <587463c4e5fa82dff8748e5f753890ac390e993e.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-18 12:53:59 [-0800], Yu-cheng Yu wrote:
> I could have explained this better, sorry!  I will explain the first
> case below; other cases are similar.
> 
> In copy_user_to_fpregs_zeroing(), we have:
> 
>     if (user_xsave()) {
>         ...
>         if (unlikely(init_bv))
>             copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
>         return copy_user_to_xregs(buf, xbv);
>         ...
>     }
> 
> The copy_user_to_xregs() may fail, and when that happens, before going to
> the slow path, there is fpregs_unlock() and context switches may happen.

The context switch may only happen after fpregs_unlock().

> However, at this point, fpu_fpregs_owner_ctx has not been changed; it could
> still be another task's FPU.

TIF_NEED_FPU_LOAD is set for the task in __fpu__restore_sig() and its
context (__fpu_invalidate_fpregs_state()) has been invalidated. So the
FPU register may contain another task's content and
fpu_fpregs_owner_ctx points to another context.

>                               For this to happen and to be detected, the user
> stack page needs to be non-present, fpu_fpregs_owner_ctx need to be another task,
> and that other task needs to be able to detect its registers are modified.
> The last factor is not easy to reproduce, and a CET control-protection fault
> helps.

So far everything is legal. However. If there is a context switch before
fpregs_lock() then this is bad before we don't account for that.
So that:

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -352,6 +352,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 			fpregs_unlock();
 			return 0;
 		}
+		fpregs_deactivate(fpu);
 		fpregs_unlock();
 	}
 
@@ -403,6 +404,8 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 	}
 	if (!ret)
 		fpregs_mark_activate();
+	else
+		fpregs_deactivate(fpu);
 	fpregs_unlock();
 
 err_out:


Should be enough.

> > Can you tell me which glibc test? I would like to reproduce this.
> > 
> > > The introduction of supervisor xstates and CET, while not contributing to
> > > the problem, makes it more detectable.  After init_fpstate and the Shadow
> > > Stack pointer have been restored to xregs, the XRSTOR from user stack
> > > fails and fpu_fpregs_owner_ctx is not updated.  The task currently owning
> > > fpregs then uses the corrupted Shadow Stack pointer and triggers a control-
> > > protection fault.
> > 
> > So I don't need new HW with supervisor and CET? A plain KVM box with
> > SSE2 and so should be enough?
> 
> What I do is, clone the whole glibc source, and run mutiple copies of
> "make check".  In about 40 minutes or so, there are unexplained seg faults,
> or a few control-protection faults (if you enable CET).  Please let me
> know if more clarification is needed.

Okay. Can you please try the above and if not, I try that glibc thing myself.

> Thanks,
> Yu-cheng

Sebastian
