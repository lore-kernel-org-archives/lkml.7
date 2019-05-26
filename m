Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1ABC282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 19:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0AC620815
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 19:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfEZThB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 15:37:01 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:46462 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbfEZThA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 15:37:00 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hUywt-00040n-BE; Sun, 26 May 2019 21:36:51 +0200
Date:   Sun, 26 May 2019 21:36:51 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Pavel Machek <pavel@ucw.cz>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] mm/gup: continue VM_FAULT_RETRY processing event for
 pre-faults
Message-ID: <20190526193651.spvm2vtrwxlhsjrv@linutronix.de>
References: <1557844195-18882-1-git-send-email-rppt@linux.ibm.com>
 <20190522122113.a2edc8aba32f0fad189bae21@linux-foundation.org>
 <20190522194322.5k52docwgp5zkdcj@linutronix.de>
 <alpine.LSU.2.11.1905241429460.1141@eggly.anvils>
 <20190525084546.fap2wkefepeia22f@linutronix.de>
 <alpine.LSU.2.11.1905251033230.1112@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <alpine.LSU.2.11.1905251033230.1112@eggly.anvils>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-05-25 11:09:15 [-0700], Hugh Dickins wrote:
> On Sat, 25 May 2019, Sebastian Andrzej Siewior wrote:
> > On 2019-05-24 15:22:51 [-0700], Hugh Dickins wrote:
> > > I've now run a couple of hours of load successfully with Mike's patch
> > > to GUP, no problem; but whatever the merits of that patch in general,
> > > I agree with Andrew that fault_in_pages_writeable() seems altogether
> > > more appropriate for copy_fpstate_to_sigframe(), and have now run a
> > > couple of hours of load successfully with this instead (rewrite to taste):
> > 
> > so this patch instead of Mike's GUP patch fixes the issue you observed?
> 
> Yes.
> 
> > Is this just a taste question or limitation of the function in general?
> 
> I'd say it's just a taste question. Though the the fact that your
> usage showed up a bug in the get_user_pages_unlocked() implementation,
> demanding a fix, does indicate that it's a more fragile and complex
> route, better avoided if there's a good simple alternative. If it were
> not already on your slowpath, I'd also argue fault_in_pages_writeable()
> is a more efficient way to do it.

Okay. The GUP functions are not properly documented for my taste. There
is no indication whether or not the mm_sem has to be acquired prior
invoking it. Following the call chain of get_user_pages() I ended up in
__get_user_pages_locked() `locked = NULL' indicated that mm_sem is no
acquired and then I saw this:
|                 if (!locked)
|                         /* VM_FAULT_RETRY couldn't trigger, bypass */
|                         return ret;

kind of suggesting that it is okay to invoke it without holding the
mm_sem prefault. It passed a few tests and then
	https://lkml.kernel.org/r/1556657902.6132.13.camel@lca.pw

happened. After that, I switched to the locked variant and the problem
disappeared (also I noticed that MPX code is invoked within ->mmap()).

> > I'm asking because it has been suggested and is used in MPX code (in the
> > signal path but .mmap) and I'm not aware of any limitation. But as I
> > wrote earlier to akpm, if the MM folks suggest to use this instead I am
> > happy to switch.
> 
> I know nothing of MPX, beyond that Dave Hansen has posted patches to
> remove that support entirely, so I'm surprised arch/x86/mm/mpx.c is
> still in the tree.
I need to poke at that. I has been removed but then KVM folks complained
that they kind of depend on that if it has been exposed to the guest. We
need to fade it out slowly…

>                    But peering at it now, it looks as if it's using
> get_user_pages() while holding mmap_sem, whereas you (sensibly enough)
> used get_user_pages_unlocked() to handle the mmap_sem for you -
> the trouble with that is that since it knows it's in control of
> mmap_sem, it feels free to drop it internally, and that takes it
> down the path of the premature return when pages NULL that Mike is
> fixing. MPX's get_user_pages() is not free to go that way.
oki.

> > > --- 5.2-rc1/arch/x86/kernel/fpu/signal.c
> > > +++ linux/arch/x86/kernel/fpu/signal.c
> > > @@ -3,6 +3,7 @@
> > >   * FPU signal frame handling routines.
> > >   */
> > >  
> > > +#include <linux/pagemap.h>
> > >  #include <linux/compat.h>
> > >  #include <linux/cpu.h>
> > >  
> > > @@ -189,15 +190,7 @@ retry:
> > >  	fpregs_unlock();
> > >  
> > >  	if (ret) {
> > > -		int aligned_size;
> > > -		int nr_pages;
> > > -
> > > -		aligned_size = offset_in_page(buf_fx) + fpu_user_xstate_size;
> > > -		nr_pages = DIV_ROUND_UP(aligned_size, PAGE_SIZE);
> > > -
> > > -		ret = get_user_pages_unlocked((unsigned long)buf_fx, nr_pages,
> > > -					      NULL, FOLL_WRITE);
> > > -		if (ret == nr_pages)
> > > +		if (!fault_in_pages_writeable(buf_fx, fpu_user_xstate_size))
> > >  			goto retry;
> > >  		return -EFAULT;
> > >  	}
> > > 
> > > (I did wonder whether there needs to be an access_ok() check on buf_fx;
> > > but if so, then I think it would already have been needed before the
> > > earlier copy_fpregs_to_sigframe(); but I didn't get deep enough into
> > > that to be sure, nor into whether access_ok() check on buf covers buf_fx.)
> > 
> > There is an access_ok() at the begin of copy_fpregs_to_sigframe(). The
> > memory is allocated from user's stack and there is (later) an
> > access_ok() for the whole region (which can be more than the memory used
> > by the FPU code).
> 
> Yes, but remember I know nothing of this FPU signal code, so I cannot
> tell whether an access_ok(buf, size) is good enough to cover the range
> of an access_ok(buf_fx, fpu_user_xstate_size).

yes, because size >= fpu_user_xstate_size

> Your "(later)" worries me a little - I hope you're not writing first
> and checking the limits later; but what you're doing may be perfectly
> correct, I'm just too far from understanding the details to say; but
> raised the matter because (I think) get_user_pages_unlocked() would
> entail an access_ok() check where fault_in_pages_writable() would not.

no, we first check the range and then write. It is later checked again
after the size has been extended.

> Hugh

Sebastian
