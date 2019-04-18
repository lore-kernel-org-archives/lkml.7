Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEE4C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAAAE214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387920AbfDRGPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 02:15:06 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60359 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfDRGPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 02:15:05 -0400
Received: from pd9ef12d2.dip0.t-ipconnect.de ([217.239.18.210] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hH0Jt-0006T4-RM; Thu, 18 Apr 2019 08:14:50 +0200
Date:   Thu, 18 Apr 2019 08:14:48 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Nadav Amit <nadav.amit@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Khalid Aziz <khalid.aziz@oracle.com>, juergh@gmail.com,
        Tycho Andersen <tycho@tycho.ws>, jsteckli@amazon.de,
        Kees Cook <keescook@google.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        deepa.srinivasan@oracle.com, chris.hyser@oracle.com,
        Tyler Hicks <tyhicks@canonical.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Jon Masters <jcm@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        iommu <iommu@lists.linux-foundation.org>,
        X86 ML <x86@kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Khalid Aziz <khalid@gonehiking.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Dave Hansen <dave@sr71.net>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arjan van de Ven <arjan@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
 Ownership (XPFO)
In-Reply-To: <CAHk-=whUwOjFW6RjHVM8kNOv1QVLJuHj2Dda0=mpLPdJ1UyatQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1904180811570.3174@nanos.tec.linutronix.de>
References: <cover.1554248001.git.khalid.aziz@oracle.com> <f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com> <20190417161042.GA43453@gmail.com> <e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com> <20190417170918.GA68678@gmail.com>
 <56A175F6-E5DA-4BBD-B244-53B786F27B7F@gmail.com> <20190417172632.GA95485@gmail.com> <063753CC-5D83-4789-B594-019048DE22D9@gmail.com> <alpine.DEB.2.21.1904172317460.3174@nanos.tec.linutronix.de> <CAHk-=wgBMg9P-nYQR2pS0XwVdikPCBqLsMFqR9nk=wSmAd4_5g@mail.gmail.com>
 <alpine.DEB.2.21.1904180129000.3174@nanos.tec.linutronix.de> <CAHk-=whUwOjFW6RjHVM8kNOv1QVLJuHj2Dda0=mpLPdJ1UyatQ@mail.gmail.com>
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

On Wed, 17 Apr 2019, Linus Torvalds wrote:
> On Wed, Apr 17, 2019 at 4:42 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Wed, 17 Apr 2019, Linus Torvalds wrote:
> > > With SMEP, user space pages are always NX.
> >
> > We talk past each other. The user space page in the ring3 valid virtual
> > address space (non negative) is of course protected by SMEP.
> >
> > The attack utilizes the kernel linear mapping of the physical
> > memory. I.e. user space address 0x43210 has a kernel equivalent at
> > 0xfxxxxxxxxxx. So if the attack manages to trick the kernel to that valid
> > kernel address and that is mapped X --> game over. SMEP does not help
> > there.
> 
> Oh, agreed.
> 
> But that would simply be a kernel bug. We should only map kernel pages
> executable when we have kernel code in them, and we should certainly
> not allow those pages to be mapped writably in user space.
> 
> That kind of "executable in kernel, writable in user" would be a
> horrendous and major bug.
> 
> So i think it's a non-issue.

Pretty much.

> > From the top of my head I'd say this is a non issue as those kernel address
> > space mappings _should_ be NX, but we got bitten by _should_ in the past:)
> 
> I do agree that bugs can happen, obviously, and we might have missed something.
>
> But in the context of XPFO, I would argue (*very* strongly) that the
> likelihood of the above kind of bug is absolutely *miniscule* compared
> to the likelihood that we'd have something wrong in the software
> implementation of XPFO.
> 
> So if the argument is "we might have bugs in software", then I think
> that's an argument _against_ XPFO rather than for it.

No argument from my side. We better spend time to make sure that a bogus
kernel side X mapping is caught, like we catch other things.

Thanks,

	tglx

