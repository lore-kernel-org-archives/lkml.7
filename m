Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309DAC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 20:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F3120880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 20:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfDHUDB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 16:03:01 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53818 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfDHUDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 16:03:01 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hDaTm-0007JB-0T; Mon, 08 Apr 2019 22:02:54 +0200
Date:   Mon, 8 Apr 2019 22:02:53 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 24/27] x86/fpu: Add a fastpath to __fpu__restore_sig()
Message-ID: <20190408200253.xdt5ejtm26gpcu23@linutronix.de>
References: <20190403164156.19645-1-bigeasy@linutronix.de>
 <20190403164156.19645-25-bigeasy@linutronix.de>
 <alpine.DEB.2.21.1904081905170.2352@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <alpine.DEB.2.21.1904081905170.2352@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-08 19:05:56 [+0200], Thomas Gleixner wrote:
> > diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
> > index a5b086ec426a5..f20e1d1fffa29 100644
> > --- a/arch/x86/kernel/fpu/signal.c
> > +++ b/arch/x86/kernel/fpu/signal.c
> > @@ -242,10 +242,10 @@ sanitize_restored_xstate(union fpregs_state *state,
> >  /*
> >   * Restore the extended state if present. Otherwise, restore the FP/SSE state.
> >   */
> > -static inline int copy_user_to_fpregs_zeroing(void __user *buf, u64 xbv, int fx_only)
> > +static int copy_user_to_fpregs_zeroing(void __user *buf, u64 xbv, int fx_only)
> >  {
> >  	if (use_xsave()) {
> > -		if ((unsigned long)buf % 64 || fx_only) {
> > +		if (fx_only) {
> 
> This change is weird and not mentioned in the changelog....

if you scroll up there is this:
|          * to loaded again on return to userland (overriding last_cpu avoids the
|          * optimisation).
|          */
|         set_thread_flag(TIF_NEED_FPU_LOAD);
|         __fpu_invalidate_fpregs_state(fpu);
| 
|         if ((unsigned long)buf_fx % 64)
|                 fx_only = 1;
…
|                 ret = copy_user_to_fpregs_zeroing(buf_fx, xfeatures, fx_only);
|                 pagefault_enable();


so I just removed that part because it was already done earlier.
Is it still weird and should be mentioned in the changelog?

Sebastian
