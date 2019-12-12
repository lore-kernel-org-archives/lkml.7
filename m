Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9211CC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 08:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6044C2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 08:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hTI5TD5u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbfLLI6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 03:58:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50914 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbfLLI6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 03:58:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UYXNX80R84IuQhMypgalm96ZyeTH5BvfJvjUVx9LbmM=; b=hTI5TD5udC3lGr9CTWri81MWv
        alYXJ/Eja1uWKBpYFfybYPThtxlb/i2+2McSUPn/56MN4FMW8wescfPTQ2ya1qxxFRMKeeyH8mnlJ
        y8pzmxv32d9Wqi1IR8JgxrHlNuL65GOFw4F9v/cxU/E2nezXB5pF32RQKddjlm0e2nMHQyfAoJkt/
        Ji00iycF6DnZ+/STvnDkxnXB7RqE8WLbid/g29uaxeP409M0CYa+aTiLYbckReP/GFeA7XXKa331D
        gxxW1U6/fGrfQjVScuWNkO3kKJvjM9lVjyJq3mjArC/0zzi36wbMOGq7sKPcUDr+3qi66fZKtqbwD
        /gDYxnqIg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifKIH-0008UQ-6W; Thu, 12 Dec 2019 08:57:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C6401305E21;
        Thu, 12 Dec 2019 09:56:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 15C792B18D262; Thu, 12 Dec 2019 09:57:55 +0100 (CET)
Date:   Thu, 12 Dec 2019 09:57:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Message-ID: <20191212085755.GR2827@hirez.programming.kicks-ass.net>
References: <20191121060444.GA55272@gmail.com>
 <20191121130153.GS4097@hirez.programming.kicks-ass.net>
 <20191121171214.GD12042@gmail.com>
 <20191121173444.GA5581@agluck-desk2.amr.corp.intel.com>
 <20191122105141.GY4114@hirez.programming.kicks-ass.net>
 <20191122152715.GA1909@hirez.programming.kicks-ass.net>
 <3908561D78D1C84285E8C5FCA982C28F7F4DD20D@ORSMSX115.amr.corp.intel.com>
 <20191122202345.GC2844@hirez.programming.kicks-ass.net>
 <20191122204204.GA192370@romley-ivt3.sc.intel.com>
 <CALCETrUBomb2_2xyX-tZUD84smtDWH6e16zSN1qupkv-DWu5kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUBomb2_2xyX-tZUD84smtDWH6e16zSN1qupkv-DWu5kw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 01:25:45PM -0800, Andy Lutomirski wrote:
> On Fri, Nov 22, 2019 at 12:29 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
> >
> > On Fri, Nov 22, 2019 at 09:23:45PM +0100, Peter Zijlstra wrote:
> > > On Fri, Nov 22, 2019 at 06:02:04PM +0000, Luck, Tony wrote:
> > > > > it requires we get the kernel and firmware clean, but only warns about
> > > > > dodgy userspace, which I really don't think there is much of.
> > > > >
> > > > > getting the kernel clean should be pretty simple.
> > > >
> > > > Fenghua has a half dozen additional patches (I think they were
> > > > all posted in previous iterations of the patch) that were found by
> > > > code inspection, rather than by actually hitting them.
> > >
> > > I thought we merged at least some of that, but maybe my recollection is
> > > faulty.
> >
> > At least 2 key fixes are in TIP tree:
> > https://lore.kernel.org/lkml/157384597983.12247.8995835529288193538.tip-bot2@tip-bot2/
> > https://lore.kernel.org/lkml/157384597947.12247.7200239597382357556.tip-bot2@tip-bot2/
> 
> I do not like these patches at all.  I would *much* rather see the
> bitops fixed and those patches reverted.
> 
> Is there any Linux architecture that doesn't have 32-bit atomic
> operations?

Of course! The right question is if there's any architecture that has
SMP and doesn't have 32bit atomic instructions, and then I'd have to
tell you that yes we have those too :/

Personally I'd love to mandate any SMP system has proper atomic ops, but
for now we sorta have to make PARISC and SPARC32 (and some ARC variant
IIRC) limp along.

PARISC and SPARC32 only have the equivalent of an xchgb or something.
Using that you can build a test-and-set spinlock, and then you have to
build atomic primitives using a hashtable of spinlocks.

Awesome, right?

> If all architectures can support them, then we should add
> set_bit_u32(), etc and/or make x86's set_bit() work for a
> 4-byte-aligned pointer.

I object to _u32() variants of the atomic bitops; the bitops interface
is a big enough trainwreck already, lets not make it worse. Making the
existing bitops use 32bit atomics on the inside should be fine though.

If anything we could switch the entire bitmap interface to unsigned int,
but I'm not sure that'd actually help much.

Anyway, many of the unaligned usages appear not to require atomicicity
in the first place, see the other patches he sent [*]. And like pointed out
elsewhere, any code that casts random pointers to (unsigned long *) is
probably already broken due to endian issues. Just making the unaligned
check go away isn't fixing it.

[*] https://lkml.kernel.org/r/1574710984-208305-1-git-send-email-fenghua.yu@intel.com


