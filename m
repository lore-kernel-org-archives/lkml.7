Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16019C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E989C20857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfCHSI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:08:56 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:33143 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfCHSI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:08:56 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1h2JvO-0001AH-5o; Fri, 08 Mar 2019 19:08:50 +0100
Date:   Fri, 8 Mar 2019 19:08:50 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 14/22] x86/fpu: Eager switch PKRU state
Message-ID: <20190308180849.hy22jejhffp4n6uh@linutronix.de>
References: <20190221115020.12385-1-bigeasy@linutronix.de>
 <20190221115020.12385-15-bigeasy@linutronix.de>
 <eedfbbbe-02d0-f977-2a64-e683b98d3904@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eedfbbbe-02d0-f977-2a64-e683b98d3904@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-25 10:16:24 [-0800], Dave Hansen wrote:
> On 2/21/19 3:50 AM, Sebastian Andrzej Siewior wrote:
> > diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
> > index 67e4805bccb6f..05f6fce62e9f1 100644
> > --- a/arch/x86/include/asm/fpu/internal.h
> > +++ b/arch/x86/include/asm/fpu/internal.h
> > @@ -562,8 +562,24 @@ switch_fpu_prepare(struct fpu *old_fpu, int cpu)
> >   */
> >  static inline void switch_fpu_finish(struct fpu *new_fpu, int cpu)
> >  {
> > -	if (static_cpu_has(X86_FEATURE_FPU))
> > -		__fpregs_load_activate(new_fpu, cpu);
> > +	struct pkru_state *pk;
> > +	u32 pkru_val = 0;
> > +
> > +	if (!static_cpu_has(X86_FEATURE_FPU))
> > +		return;
> > +
> > +	__fpregs_load_activate(new_fpu, cpu);
> 
> This is still a bit light on comments.
> 
> Maybe:
> 	/* PKRU state is switched eagerly because... */

okay, will update.

> > +	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
> > +		return;
> > +
> > +	if (current->mm) {
> > +		pk = get_xsave_addr(&new_fpu->state.xsave, XFEATURE_PKRU);
> > +		WARN_ON_ONCE(!pk);
> 
> This can trip on us of the 'init optimization' is in play because
> get_xsave_addr() checks xsave->header.xfeatures.  That's unlikely today
> because we usually set PKRU to a restrictive value.  But, it's also not
> *guaranteed*.
> 
> Userspace could easily do an XRSTOR that puts PKRU back in its init
> state if it wanted to, then this would end up with pk==NULL.
> 
> We might actually want a selftest that *does* that.  I don't think we
> have one.

So you are saying that the above warning might trigger and be "okay"?
My understanding is that the in-kernel XSAVE will always save everything
so we should never "lose" the XFEATURE_PKRU no matter what user space
does.

So as test case you want
	xsave (-1 & ~XFEATURE_PKRU)
	xrestore (-1 & ~XFEATURE_PKRU)

in userland and then a context switch to see if the warning above
triggers?

> > +		if (pk)
> > +			pkru_val = pk->pkru;
> > +	}> +	__write_pkru(pkru_val);
> >  }
> 
> A comment above __write_pkru() would be nice to say that it only
> actually does the slow instruction on changes to the value.

Could we please not do this? It is a comment above one of the callers
function and we have two or three. And we have that comment already
within __write_pkru().

> BTW, this has the implicit behavior of always trying to do a
> __write_pkru(0) on switches to kernel threads.  That seems a bit weird
> and it is likely to impose WRPKRU overhead on switches between user and
> kernel threads.
> 
> The 0 value is also the most permissive, which is not great considering
> that user mm's can be active the in page tables when running kernel
> threads if we're being lazy.
> 
> Seems like we should either leave PKRU alone or have 'init_pkru_value'
> be the default.  That gives good security properties and is likely to
> match the application value, removing the WRPKRU overhead.

Last time we talked about this we agreed (or this was my impression) that
0 should be written so that the kernel thread should always be able to
write to user space in case it borrowed its mm (otherwise it has none
and it would fail anyway).
We didn't want to leave PKRU alone because the outcome (whether or not
the write by the kernel thread succeeds) should not depend on the last
running task (and be random) but deterministic.

I am personally open to each outcome you decide :) I you want to use
`init_pkru_value' instead of 0 then I can change this. If you want to
skip the possible update for kernel threads then okay but maybe this
should be documented somehow.

Sebastian
