Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3FDC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF372146E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfLRPy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 10:54:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58036 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfLRPy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 10:54:57 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ihbez-0005Xb-Pq; Wed, 18 Dec 2019 16:54:49 +0100
Date:   Wed, 18 Dec 2019 16:54:49 +0100
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
Message-ID: <20191218155449.sk4gjabtynh67jqb@linutronix.de>
References: <20191212210855.19260-1-yu-cheng.yu@intel.com>
 <20191212210855.19260-4-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191212210855.19260-4-yu-cheng.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-12 13:08:55 [-0800], Yu-cheng Yu wrote:
> In __fpu_restore_sig(),'init_fpstate.xsave' and part of 'fpu->state.xsave'
> are restored separately to xregs.  However, as stated in __cpu_invalidate_
> fpregs_state(),
> 
>   Any code that clobbers the FPU registers or updates the in-memory
>   FPU state for a task MUST let the rest of the kernel know that the
>   FPU registers are no longer valid for this task.
> 
> and this code violates that rule.  Should the restoration fail, the other
> task's context is corrupted.
> 
> This problem does not occur very often because copy_*_to_xregs() succeeds
> most of the time.  

why "most of the time"? It should always succeed. We talk here about
__fpu__restore_sig() correct? Using init_fpstate as part of restore
process isn't the "default" case. If the restore _here_ fails then it
fails.

>                    It occurs, for instance, in copy_user_to_fpregs_
> zeroing() when the first half of the restoration succeeds and the other
> half fails.  This can be triggered by running glibc tests, where a non-
> present user stack page causes the XRSTOR to fail.

So if copy_user_to_fpregs_zeroing() fails then we go to the slowpath.
Then we load the FPU register with copy_kernel_to_xregs_err().
In the end they are either enabled (fpregs_mark_activate()) or cleared
if it failed (fpu__clear()). Don't see here a problem.

Can you tell me which glibc test? I would like to reproduce this.

> The introduction of supervisor xstates and CET, while not contributing to
> the problem, makes it more detectable.  After init_fpstate and the Shadow
> Stack pointer have been restored to xregs, the XRSTOR from user stack
> fails and fpu_fpregs_owner_ctx is not updated.  The task currently owning
> fpregs then uses the corrupted Shadow Stack pointer and triggers a control-
> protection fault.

So I don't need new HW with supervisor and CET? A plain KVM box with
SSE2 and so should be enough?

Sebastian
