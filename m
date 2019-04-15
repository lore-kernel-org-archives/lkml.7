Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1D0C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8DF820880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfDOQHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:07:55 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:46398 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbfDOQHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 12:07:53 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hG497-0004wf-Ez; Mon, 15 Apr 2019 18:07:49 +0200
Date:   Mon, 15 Apr 2019 18:07:44 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [patch V4 01/32] mm/slab: Fix broken stack trace storage
In-Reply-To: <20190415132339.wiqyzygqklliyml7@treble>
Message-ID: <alpine.DEB.2.21.1904151804460.1895@nanos.tec.linutronix.de>
References: <20190414155936.679808307@linutronix.de> <20190414160143.591255977@linutronix.de> <CALCETrUhVc_u3HL-x7wMnk9ukEbwQPvc9N5Na-Q55se0VwcCpw@mail.gmail.com> <alpine.DEB.2.21.1904141832400.4917@nanos.tec.linutronix.de> <alpine.DEB.2.21.1904151101100.1729@nanos.tec.linutronix.de>
 <20190415132339.wiqyzygqklliyml7@treble>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Apr 2019, Josh Poimboeuf wrote:
> On Mon, Apr 15, 2019 at 11:02:58AM +0200, Thomas Gleixner wrote:
> >  	addr = (unsigned long *)&((char *)addr)[obj_offset(cachep)];
> >  
> > -	if (size < 5 * sizeof(unsigned long))
> > +	if (size < 5)
> >  		return;
> >  
> >  	*addr++ = 0x12345678;
> >  	*addr++ = caller;
> >  	*addr++ = smp_processor_id();
> > -	size -= 3 * sizeof(unsigned long);
> > +	size -= 3;
> > +#ifdef CONFIG_STACKTRACE
> >  	{
> > -		unsigned long *sptr = &caller;
> > -		unsigned long svalue;
> > -
> > -		while (!kstack_end(sptr)) {
> > -			svalue = *sptr++;
> > -			if (kernel_text_address(svalue)) {
> > -				*addr++ = svalue;
> > -				size -= sizeof(unsigned long);
> > -				if (size <= sizeof(unsigned long))
> > -					break;
> > -			}
> > -		}
> > +		struct stack_trace trace = {
> > +			/* Leave one for the end marker below */
> > +			.max_entries	= size - 1,
> > +			.entries	= addr,
> > +			.skip		= 3,
> > +		};
> >  
> > +		save_stack_trace(&trace);
> > +		addr += trace.nr_entries;
> >  	}
> > -	*addr++ = 0x87654321;
> > +#endif
> > +	*addr = 0x87654321;
> 
> Looks like stack_trace.nr_entries isn't initialized?  (though this code
> gets eventually replaced by a later patch)

struct initializer initialized the non mentioned fields to 0, if I'm not
totally mistaken.

> Who actually reads this stack trace?  I couldn't find a consumer.

It's stored directly in the memory pointed to by @addr and that's the freed
cache memory. If that is used later (UAF) then the stack trace can be
printed to see where it was freed.

Thanks,

	tglx
