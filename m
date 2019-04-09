Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E7BC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A67BC20880
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbfDIH1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 03:27:17 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54513 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfDIH1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 03:27:17 -0400
Received: from konstanz.wlan.tk-bodensee.net ([185.80.169.68] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hDl9z-0002tB-Kc; Tue, 09 Apr 2019 09:27:11 +0200
Date:   Tue, 9 Apr 2019 09:27:05 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 24/27] x86/fpu: Add a fastpath to __fpu__restore_sig()
In-Reply-To: <20190408200253.xdt5ejtm26gpcu23@linutronix.de>
Message-ID: <alpine.DEB.2.21.1904090926330.2069@nanos.tec.linutronix.de>
References: <20190403164156.19645-1-bigeasy@linutronix.de> <20190403164156.19645-25-bigeasy@linutronix.de> <alpine.DEB.2.21.1904081905170.2352@nanos.tec.linutronix.de> <20190408200253.xdt5ejtm26gpcu23@linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1042646380-1554794831=:2069"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1042646380-1554794831=:2069
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Mon, 8 Apr 2019, Sebastian Andrzej Siewior wrote:

> On 2019-04-08 19:05:56 [+0200], Thomas Gleixner wrote:
> > > diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
> > > index a5b086ec426a5..f20e1d1fffa29 100644
> > > --- a/arch/x86/kernel/fpu/signal.c
> > > +++ b/arch/x86/kernel/fpu/signal.c
> > > @@ -242,10 +242,10 @@ sanitize_restored_xstate(union fpregs_state *state,
> > >  /*
> > >   * Restore the extended state if present. Otherwise, restore the FP/SSE state.
> > >   */
> > > -static inline int copy_user_to_fpregs_zeroing(void __user *buf, u64 xbv, int fx_only)
> > > +static int copy_user_to_fpregs_zeroing(void __user *buf, u64 xbv, int fx_only)
> > >  {
> > >  	if (use_xsave()) {
> > > -		if ((unsigned long)buf % 64 || fx_only) {
> > > +		if (fx_only) {
> > 
> > This change is weird and not mentioned in the changelog....
> 
> if you scroll up there is this:
> |          * to loaded again on return to userland (overriding last_cpu avoids the
> |          * optimisation).
> |          */
> |         set_thread_flag(TIF_NEED_FPU_LOAD);
> |         __fpu_invalidate_fpregs_state(fpu);
> | 
> |         if ((unsigned long)buf_fx % 64)
> |                 fx_only = 1;
> …
> |                 ret = copy_user_to_fpregs_zeroing(buf_fx, xfeatures, fx_only);
> |                 pagefault_enable();
> 
> 
> so I just removed that part because it was already done earlier.
> Is it still weird and should be mentioned in the changelog?

Bah. Staring at this for too long. All good ...
--8323329-1042646380-1554794831=:2069--
