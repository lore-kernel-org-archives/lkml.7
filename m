Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FCCCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D0642173B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405315AbfJWNVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 09:21:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49283 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbfJWNVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:21:09 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iNGZV-0002MI-Uz; Wed, 23 Oct 2019 15:21:06 +0200
Date:   Wed, 23 Oct 2019 15:21:05 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Cyrill Gorcunov <gorcunov@gmail.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [BUG -tip] kmemleak and stacktrace cause page faul
In-Reply-To: <20191022145619.GE12121@uranus.lan>
Message-ID: <alpine.DEB.2.21.1910231457400.2308@nanos.tec.linutronix.de>
References: <20191019114421.GK9698@uranus.lan> <20191022142325.GD12121@uranus.lan> <20191022145619.GE12121@uranus.lan>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2019, Cyrill Gorcunov wrote:
> On Tue, Oct 22, 2019 at 05:23:25PM +0300, Cyrill Gorcunov wrote:
> > 
> > I presume the kmemleak tries to save stack trace too early when estack_pages are not
> > yet filled.
> 
> Indeed, at this stage of boot the percpu_setup_exception_stacks has not been called
> yet and estack_pages full of crap
> 
> [    0.157502] stk 0x1008 k 1 begin 0x0 end 0xd000 estack_pages 0xffffffff82014880 ep 0xffffffff82014888
> [    0.159395] estack_pages[0] = 0x0
> [    0.160046] estack_pages[1] = 0x5100000001000
> [    0.160881] estack_pages[2] = 0x0
> [    0.161530] estack_pages[3] = 0x6100000003000
> [    0.162343] estack_pages[4] = 0x0
> [    0.162962] estack_pages[5] = 0x0
> [    0.163523] estack_pages[6] = 0x0
> [    0.164065] estack_pages[7] = 0x8100000007000
> [    0.164978] estack_pages[8] = 0x0
> [    0.165624] estack_pages[9] = 0x9100000009000
> [    0.166448] estack_pages[10] = 0x0
> [    0.167064] estack_pages[11] = 0xa10000000b000
> [    0.168055] estack_pages[12] = 0x0

Errm. estack_pages is statically initialized and it's an array of:.

struct estack_pages {
        u32     offs;
        u16     size;
        u16     type;
};

[0,2,4,5,6,8,10,12] are guard pages so 0 is not that crappy at all

The rest looks completely valid if you actually decode it proper.

e.g. 0x51000 00001000

     bit  0-31: 00001000		Offset 0x1000: 1 Page
     bit 32-47: 1000			Size 0x1000:   1 Page
     bit 48-63: 5			Type 5: STACK_TYPE_EXCEPTION + ESTACK_DF

So, no. This is NOT the problem.

But yes, you are right that percpu_setup_exception_stacks() has not yet
been called simply because the percpu entry area has not been mapped yet.

So lets look at the full context:

        begin = (unsigned long)__this_cpu_read(cea_exception_stacks);

When percpu_setup_exception_stacks() has not been called yet, then begin
should be 0.

        end = begin + sizeof(struct cea_exception_stacks);

end should be 0 + sizeof(struct cea_exception_stacks);

        /* Bail if @stack is outside the exception stack area. */
        if (stk < begin || stk >= end)
                return false;

So 'begin <= stk < end' must be true to get to the below:

        /* Calc page offset from start of exception stacks */
        k = (stk - begin) >> PAGE_SHIFT;

which gives a valid 'k' no matter what 'begin' is. And obviously 'k' cannot
be outside of the array size of estack_pages.

        /* Lookup the page descriptor */
        ep = &estack_pages[k];

Ergo ep must be a valid pointer pointing to the statically allocated and
statically initialized estack_pages array.

        /* Guard page? */
        if (!ep->size)

How on earth can dereferencing ep crash the machine?

                return false;

That does not make any sense.

Surely, we should not even try to decode exception stack when
cea_exception_stacks is not yet initialized, but that does not explain
anything what you are observing.

Thanks,

	tglx
