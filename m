Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4472CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47C920640
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405934AbfJWNio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 09:38:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49418 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390436AbfJWNio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:38:44 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iNGqX-0002jw-6r; Wed, 23 Oct 2019 15:38:41 +0200
Date:   Wed, 23 Oct 2019 15:38:40 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Cyrill Gorcunov <gorcunov@gmail.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [BUG -tip] kmemleak and stacktrace cause page faul
In-Reply-To: <20191023133204.GH12121@uranus.lan>
Message-ID: <alpine.DEB.2.21.1910231536220.2308@nanos.tec.linutronix.de>
References: <20191019114421.GK9698@uranus.lan> <20191022142325.GD12121@uranus.lan> <20191022145619.GE12121@uranus.lan> <alpine.DEB.2.21.1910231457400.2308@nanos.tec.linutronix.de> <20191023133204.GH12121@uranus.lan>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2019, Cyrill Gorcunov wrote:
> On Wed, Oct 23, 2019 at 03:21:05PM +0200, Thomas Gleixner wrote:
> > Errm. estack_pages is statically initialized and it's an array of:.
> > 
> > struct estack_pages {
> >         u32     offs;
> >         u16     size;
> >         u16     type;
> > };
> > 
> > [0,2,4,5,6,8,10,12] are guard pages so 0 is not that crappy at all
> 
> Wait, Thomas, I might be wrong, but per-cpu is initialized to the pointer,
> the memory for this estack_pages has not yet been allocated, no?

static const
struct estack_pages estack_pages[CEA_ESTACK_PAGES] ____cacheline_aligned = {
        EPAGERANGE(DF),
	EPAGERANGE(NMI),
	EPAGERANGE(DB1),
	EPAGERANGE(DB),
        EPAGERANGE(MCE),
};

It's statically allocated. So it's available from the very beginning.

> The diff I made to fetch the values are
> 
> diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
> index 753b8cfe8b8a..bf0d755b6079 100644
> --- a/arch/x86/kernel/dumpstack_64.c
> +++ b/arch/x86/kernel/dumpstack_64.c
> @@ -101,8 +101,18 @@ static bool in_exception_stack(unsigned long *stack, struct stack_info *info)
>  
>  	/* Calc page offset from start of exception stacks */
>  	k = (stk - begin) >> PAGE_SHIFT;
> +
>  	/* Lookup the page descriptor */
>  	ep = &estack_pages[k];
> +
> +	printk("stk 0x%lx k %u begin 0x%lx end 0x%lx estack_pages 0x%lx ep 0x%lx\n",
> +	       stk, k, begin, end, (long)(void *)&estack_pages[0], (long)(void *)ep);
> +
> +	for (k = 0; k < CEA_ESTACK_PAGES; k++) {
> +		long v = *(long *)(void *)&estack_pages[k];
> +		printk("estack_pages[%d] = 0x%lx\n", k, v);

And as I explained to you properly decoded the values _ARE_ correct and
make sense.

> +	}
> +
>  	/* Guard page? */
>  	if (!ep->size)
>  		return false;
> 
> 
> > 
> > e.g. 0x51000 00001000
> > 
> >      bit  0-31: 00001000		Offset 0x1000: 1 Page
> >      bit 32-47: 1000			Size 0x1000:   1 Page
> >      bit 48-63: 5			Type 5: STACK_TYPE_EXCEPTION + ESTACK_DF
> > 
> > So, no. This is NOT the problem.
> 
> I drop the left of your reply. True, I agreed with anything you said.
>
> You know I didn't manage to dive more into this problem yesterday
> but if time permits I'll continue today. It is easily triggering
> under kvm (the kernel I'm building is almost without modules so
> I simply upload bzImage into the guest). FWIW, the config I'm
> using is https://gist.github.com/cyrillos/7cd5d2510a99af8ea872f07ac6f9095b

That's helpful because I enabled kmemleak and the kernel comes up just fine.

Thanks,

	tglx
