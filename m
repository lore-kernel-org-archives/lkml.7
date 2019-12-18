Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D846C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73EFF218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfLRVMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:12:45 -0500
Received: from mga03.intel.com ([134.134.136.65]:34672 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbfLRVMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:12:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2019 13:12:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,330,1571727600"; 
   d="scan'208";a="210223283"
Received: from yyu32-desk.sc.intel.com ([143.183.136.51])
  by orsmga008.jf.intel.com with ESMTP; 18 Dec 2019 13:12:43 -0800
Message-ID: <587463c4e5fa82dff8748e5f753890ac390e993e.camel@intel.com>
Subject: Re: [PATCH v2 3/3] x86/fpu/xstate: Invalidate fpregs when
 __fpu_restore_sig() fails
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
Date:   Wed, 18 Dec 2019 12:53:59 -0800
In-Reply-To: <20191218155449.sk4gjabtynh67jqb@linutronix.de>
References: <20191212210855.19260-1-yu-cheng.yu@intel.com>
         <20191212210855.19260-4-yu-cheng.yu@intel.com>
         <20191218155449.sk4gjabtynh67jqb@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-12-18 at 16:54 +0100, Sebastian Andrzej Siewior wrote:
> On 2019-12-12 13:08:55 [-0800], Yu-cheng Yu wrote:
> > In __fpu_restore_sig(),'init_fpstate.xsave' and part of 'fpu->state.xsave'
> > are restored separately to xregs.  However, as stated in __cpu_invalidate_
> > fpregs_state(),
> > 
> >   Any code that clobbers the FPU registers or updates the in-memory
> >   FPU state for a task MUST let the rest of the kernel know that the
> >   FPU registers are no longer valid for this task.
> > 
> > and this code violates that rule.  Should the restoration fail, the other
> > task's context is corrupted.
> > 
> > This problem does not occur very often because copy_*_to_xregs() succeeds
> > most of the time.  
> 
> why "most of the time"? It should always succeed. We talk here about
> __fpu__restore_sig() correct? Using init_fpstate as part of restore
> process isn't the "default" case. If the restore _here_ fails then it
> fails.
> 
> >                    It occurs, for instance, in copy_user_to_fpregs_
> > zeroing() when the first half of the restoration succeeds and the other
> > half fails.  This can be triggered by running glibc tests, where a non-
> > present user stack page causes the XRSTOR to fail.
> 
> So if copy_user_to_fpregs_zeroing() fails then we go to the slowpath.
> Then we load the FPU register with copy_kernel_to_xregs_err().
> In the end they are either enabled (fpregs_mark_activate()) or cleared
> if it failed (fpu__clear()). Don't see here a problem.

I could have explained this better, sorry!  I will explain the first
case below; other cases are similar.

In copy_user_to_fpregs_zeroing(), we have:

    if (user_xsave()) {
        ...
        if (unlikely(init_bv))
            copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
        return copy_user_to_xregs(buf, xbv);
        ...
    }

The copy_user_to_xregs() may fail, and when that happens, before going to
the slow path, there is fpregs_unlock() and context switches may happen.
However, at this point, fpu_fpregs_owner_ctx has not been changed; it could
still be another task's FPU.  For this to happen and to be detected, the user
stack page needs to be non-present, fpu_fpregs_owner_ctx need to be another task,
and that other task needs to be able to detect its registers are modified.
The last factor is not easy to reproduce, and a CET control-protection fault
helps.

> 
> Can you tell me which glibc test? I would like to reproduce this.
> 
> > The introduction of supervisor xstates and CET, while not contributing to
> > the problem, makes it more detectable.  After init_fpstate and the Shadow
> > Stack pointer have been restored to xregs, the XRSTOR from user stack
> > fails and fpu_fpregs_owner_ctx is not updated.  The task currently owning
> > fpregs then uses the corrupted Shadow Stack pointer and triggers a control-
> > protection fault.
> 
> So I don't need new HW with supervisor and CET? A plain KVM box with
> SSE2 and so should be enough?

What I do is, clone the whole glibc source, and run mutiple copies of
"make check".  In about 40 minutes or so, there are unexplained seg faults,
or a few control-protection faults (if you enable CET).  Please let me
know if more clarification is needed.

Thanks,
Yu-cheng


