Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF5CC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 04:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724D521872
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 04:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555562511;
	bh=ZzJFjyGToYfbKAC7a2m7yS86J4A8OLDkslCG6xa8cQM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fRgzOan6ephZT36HS/fq+FoYbKXtu45xdpMto2F7TNuZC1eHSvB2A+o6Z5L4CYjzM
	 6Sw1R5m+Xs8v7Oekww2YEoD9k4GGDQesEdEeeMEBlgKOo1vk6bi0ucLPf4SGYCbHh+
	 QVRJP/U62xbHHze+2LvV7PILSNZDnM3Sgl11rgNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfDRElu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 00:41:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbfDRElt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 00:41:49 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1752D21908
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 04:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555562508;
        bh=ZzJFjyGToYfbKAC7a2m7yS86J4A8OLDkslCG6xa8cQM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QVWUihYIOED3b6sf++tgY3iRdj8kiMHZVbckG4nNfCAClSFzLnTcPH+IgFSB9PrKC
         Z2tMpLhiQqQpdAO8Vqghyo+PaFXtDr9TPVxG3ICymGFgejmh9f9/1/nnjg3BTRsxMd
         IElW3sPpwA7MwJfgB7BILSJAa6MZxHiR0qJmXz6w=
Received: by mail-wr1-f44.google.com with SMTP id w10so1161926wrm.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 21:41:48 -0700 (PDT)
X-Gm-Message-State: APjAAAXB2qEqFTGgtwLfzw3ZoC32LtB8JijivdO/w+IEZDGYFMBv7ePl
        8NZeUVwJFV8bvmd5fjqc1C6Nmm1I+HGWn/JV8i9emQ==
X-Google-Smtp-Source: APXvYqyfUEuC3mEmPG9s4i6tESlRo9oZEsPzue7aX/a76mK2HZr1+EEwlvQomlchaeb55fwDfrvGp+xyZoI6blk5d70=
X-Received: by 2002:adf:efc1:: with SMTP id i1mr59073183wrp.199.1555562504832;
 Wed, 17 Apr 2019 21:41:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1554248001.git.khalid.aziz@oracle.com> <f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com>
 <20190417161042.GA43453@gmail.com> <e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com>
 <20190417170918.GA68678@gmail.com> <56A175F6-E5DA-4BBD-B244-53B786F27B7F@gmail.com>
 <20190417172632.GA95485@gmail.com> <063753CC-5D83-4789-B594-019048DE22D9@gmail.com>
 <alpine.DEB.2.21.1904172317460.3174@nanos.tec.linutronix.de>
 <CAHk-=wgBMg9P-nYQR2pS0XwVdikPCBqLsMFqR9nk=wSmAd4_5g@mail.gmail.com>
 <alpine.DEB.2.21.1904180129000.3174@nanos.tec.linutronix.de> <CAHk-=whUwOjFW6RjHVM8kNOv1QVLJuHj2Dda0=mpLPdJ1UyatQ@mail.gmail.com>
In-Reply-To: <CAHk-=whUwOjFW6RjHVM8kNOv1QVLJuHj2Dda0=mpLPdJ1UyatQ@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 17 Apr 2019 21:41:33 -0700
X-Gmail-Original-Message-ID: <CALCETrXm9PuUTEEmzA8bQJmg=PHC_2XSywECittVhXbMJS1rSA@mail.gmail.com>
Message-ID: <CALCETrXm9PuUTEEmzA8bQJmg=PHC_2XSywECittVhXbMJS1rSA@mail.gmail.com>
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
 Ownership (XPFO)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Juerg Haefliger <juergh@gmail.com>,
        Tycho Andersen <tycho@tycho.ws>, jsteckli@amazon.de,
        Kees Cook <keescook@google.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        deepa.srinivasan@oracle.com, chris hyser <chris.hyser@oracle.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 5:00 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Apr 17, 2019 at 4:42 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Wed, 17 Apr 2019, Linus Torvalds wrote:
> >
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
>
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
>

I don't think this type of NX goof was ever the argument for XPFO.
The main argument I've heard is that a malicious user program writes a
ROP payload into user memory (regular anonymous user memory) and then
gets the kernel to erroneously set RSP (*not* RIP) to point there.

I find this argument fairly weak for a couple reasons.  First, if
we're worried about this, let's do in-kernel CFI, not XPFO, to
mitigate it.  Second, I don't see why the exact same attack can't be
done using, say, page cache, and unless I'm missing something, XPFO
doesn't protect page cache.  Or network buffers, or pipe buffers, etc.
