Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C6AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8472084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731913AbfDAHdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:33:32 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58176 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731769AbfDAHdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:33:31 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hArRh-0004hO-Di; Mon, 01 Apr 2019 09:33:29 +0200
Date:   Mon, 1 Apr 2019 09:33:28 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [patch 04/14] x86/exceptions: Make IST index zero based
In-Reply-To: <20190401073024.GB11158@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1904010931480.2476@nanos.tec.linutronix.de>
References: <20190331214020.836098943@linutronix.de> <20190331215135.133741719@linutronix.de> <20190401073024.GB11158@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Apr 2019, Peter Zijlstra wrote:

> On Sun, Mar 31, 2019 at 11:40:24PM +0200, Thomas Gleixner wrote:
> > --- a/arch/x86/include/asm/page_64_types.h
> > +++ b/arch/x86/include/asm/page_64_types.h
> > @@ -25,11 +25,14 @@
> >  #define IRQ_STACK_ORDER (2 + KASAN_STACK_ORDER)
> >  #define IRQ_STACK_SIZE (PAGE_SIZE << IRQ_STACK_ORDER)
> >  
> > -#define DOUBLEFAULT_STACK 1
> > -#define NMI_STACK 2
> > -#define DEBUG_STACK 3
> > -#define MCE_STACK 4
> > -#define N_EXCEPTION_STACKS 4  /* hw limit: 7 */
> > +/*
> > + * The index for the tss.ist[] array. The hardware limit is 7 entries.
> > + */
> > +#define	DOUBLEFAULT_IST		0
> > +#define	NMI_IST			1
> > +#define	DEBUG_IST		2
> > +#define	MCE_IST			3
> > +#define	N_EXCEPTION_STACKS	4
> 
> Would it make sense to use an enum here?

Yes, but ASM code hates enums. We could solve that by moving it to a
different header and exposing the necessary define via asm-offsets. I'll
have a look.

Thanks,

	tglx

