Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFE0C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8A4206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfDCQbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:31:00 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41599 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbfDCQbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:31:00 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hBimv-0003mf-M8; Wed, 03 Apr 2019 18:30:58 +0200
Date:   Wed, 3 Apr 2019 18:30:57 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [patch 00/14] x86/exceptions: Add guard patches to IST stacks
In-Reply-To: <CALCETrX1ZtZE2JUgXD55vZgwxpO2pTiUJb_GKDXAJJd4VTyGSw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1904031826560.1967@nanos.tec.linutronix.de>
References: <20190331214020.836098943@linutronix.de> <CALCETrX1ZtZE2JUgXD55vZgwxpO2pTiUJb_GKDXAJJd4VTyGSw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Mar 2019, Andy Lutomirski wrote:
> On Sun, Mar 31, 2019 at 3:10 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > While looking for something different I stumbled over the comment in struct
> > cpu_entry_area:
> >
> >          * Exception stacks used for IST entries.
> >          *
> >          * In the future, this should have a separate slot for each stack
> >          * with guard pages between them.
> >
> > As usual with such comments they are added in good faith and then
> > forgotten. Looking what it takes to fix that let me stumble over some other
> > leftovers like orig_ist[], now unused macros, useless defines and a bunch
> > of assumptions about the exception stacks being a big lump. Aside of that I
> > found a too broad check of the exception stack in the x86/64 stack overflow
> > detector.
> >
> > The following series cleans that up and gradually prepares for guard pages
> > between the IST stacks.
> 
> Thanks!  I'll review this over the next couple days.
> 
> Meanwhile, if you're inspired, I have a WIP series to do the same
> thing to the IRQ stacks here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/log/?h=x86/guard_pages
> 
> Want to take a look or pick it up if you want to keep working on this?

I grabbed the lot and addressed the todo's there. Not completely done
though, but it builds and boots :)

With all stacks having guard pages now, the stack_overflow_check() in
irq_64.c is kind of pointless. When the kernel overflows any of the stacks
independent of what we do with DB (we at least split it into 2 different
valid stacks) then it hits a guard page and dies. Mission accomplished....

Thanks,

	tglx



