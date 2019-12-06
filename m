Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD8AC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 21:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A319D206DB
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 21:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfLFVAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 16:00:23 -0500
Received: from gate.crashing.org ([63.228.1.57]:47481 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfLFVAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 16:00:23 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id xB6KxtJD020157;
        Fri, 6 Dec 2019 14:59:55 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id xB6Kxrxp020154;
        Fri, 6 Dec 2019 14:59:53 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 6 Dec 2019 14:59:53 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 2/2] powerpc/irq: inline call_do_irq() and call_do_softirq()
Message-ID: <20191206205953.GQ3152@gate.crashing.org>
References: <5ca6639b7c1c21ee4b4138b7cfb31d6245c4195c.1570684298.git.christophe.leroy@c-s.fr> <877e3tbvsa.fsf@mpe.ellerman.id.au> <20191121101552.GR16031@gate.crashing.org> <87y2w49rgo.fsf@mpe.ellerman.id.au> <20191125142556.GU9491@gate.crashing.org> <5fdb1c92-8bf4-01ca-f81c-214870c33be3@c-s.fr> <20191127145958.GG9491@gate.crashing.org> <2072e066-1ffb-867e-60ec-04a6bb9075c1@c-s.fr> <20191129184658.GR9491@gate.crashing.org> <ebc67964-e5a9-acd0-0011-61ba23692f7e@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ebc67964-e5a9-acd0-0011-61ba23692f7e@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 05:32:54AM +0100, Christophe Leroy wrote:
> Le 29/11/2019 à 19:46, Segher Boessenkool a écrit :
> >The existing call_do_irq isn't C code.  It doesn't do anything with r2,
> >as far as I can see; __do_irq just gets whatever the caller of call_do_irq
> >has.
> >
> >So I guess all the callers of call_do_irq have the correct r2 value always
> >already?  In that case everything Just Works.
> 
> Indeed, there is only one caller for call_do_irq() which is do_IRQ().
> And do_IRQ() is also calling __do_irq() directly (when the stack pointer 
> is already set to IRQ stack). do_IRQ() and __do_irq() are both in 
> arch/powerpc/kernel/irq.c
> 
> As far as I can see when replacing the call to call_do_irq() by a call 
> to __do_irq(), the compiler doesn't do anything special with r2, and 
> doesn't add any nop after the bl either, whereas for all calls outside 
> irq.c, there is a nop added. So I guess that's ok ?

If the compiler can see the callee wants the same TOC as the caller has,
it does not arrange to set (and restore) it, no.  If it sees it may be
different, it does arrange for that (and the linker then will check if
it actually needs to do anything, and do that if needed).

In this case, the compiler cannot know the callee wants the same TOC,
which complicates thing a lot -- but it all works out.

> Now that call_do_irq() is inlined, we can even define __do_irq() as static.
> 
> And that's the same for do_softirq_own_stack(), it is only called from 
> do_softirq() which is defined in the same file as __do_softirq() 
> (kernel/softirq.c)

I think things can still go wrong if any of this is inlined into a kernel
module?  Is there anything that prevents this / can this not happen for
some fundamental reason I don't see?


Segher
