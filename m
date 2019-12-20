Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD4EC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 20:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1AE20866
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 20:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfLTUQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 15:16:26 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34176 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbfLTUQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 15:16:25 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iiOhB-00087w-Lp; Fri, 20 Dec 2019 21:16:21 +0100
Date:   Fri, 20 Dec 2019 21:16:21 +0100
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
Message-ID: <20191220201621.riyrptl5vwdukztc@linutronix.de>
References: <20191212210855.19260-1-yu-cheng.yu@intel.com>
 <20191212210855.19260-4-yu-cheng.yu@intel.com>
 <20191218155449.sk4gjabtynh67jqb@linutronix.de>
 <587463c4e5fa82dff8748e5f753890ac390e993e.camel@intel.com>
 <20191219142217.axgpqlb7zzluoxnf@linutronix.de>
 <19a94f88f1bc66bb81dbf5dd72083d03ca5090e9.camel@intel.com>
 <20191219171635.phdsfkvsyazwaq7s@linutronix.de>
 <1607597639a6c6255127fef07704ee9193e33166.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1607597639a6c6255127fef07704ee9193e33166.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-19 09:40:06 [-0800], Yu-cheng Yu wrote:
> On Thu, 2019-12-19 at 18:16 +0100, Sebastian Andrzej Siewior wrote:
> > On 2019-12-19 08:44:08 [-0800], Yu-cheng Yu wrote:
> > > Yes, this works.  But then everywhere that calls copy_*_to_xregs_*() etc. needs to be checked.
> > > Are there other alternatives?
> > 
> > I don't like the big hammer approach of your very much. It might make
> > all it "correct" but then it might lead to more "invalids" then needed.
> > It also required to export the symbol which I would like to avoid.
> 
> Copying to registers invalids current fpregs context.  It might not cause
> extra register loading, because registers are in fact already invalidated
> and any task owning the context needs to reload anyway.  Setting
> fpu_fpregs_owner_ctx is only to let the rest of the kernel know the
> fact that already happened.
> 
> But, I agree with you the patch does look biggish.

Now that I looked at it:
All kernel loads don't fail. If they fail we end up in the handler and
restore to init-state. So no need to reset `fpu_fpregs_owner_ctx' in this
case. The variable is actually set to task's FPU state so resetting is
not required.
fpu__save() invokes copy_kernel_to_fpregs() (on older boxes) and by
resetting `fpu_fpregs_owner_ctx' we would load it twice (in fpu__save()
and on return to userland).

So far I can tell, the only problematic case is the signal code because
here the state restore *may* fail and we *may* do it in two steps. The
error happens only if both `may' are true.

> > So if this patch works for you and you don't find anything else where it
> > falls apart then I will audit tomorrow all callers which got the
> > "invalidator" added and check for that angle.
> 
> Yes, that works for me.  Also, most of these call sites are under fpregs_lock(),
> and we could use __cpu_invalidate_fpregs_state().
> I was also thinking maybe add warnings when any new code re-introduces the issue,
> but not sure where to add that.  Do you think that is needed?

I was thinking about it. So the `read-FPU-state' function must be
invoked within the fpregs_lock() section. This could be easily
enforced. At fpregs_unlock() time `fpu_fpregs_owner_ctx' must be NULL or
pointing to task's FPU.
My brain is fried for today so I'm sure if this is a sane approach. But
it might be a start.

> Thanks,
> Yu-cheng

Sebastian
