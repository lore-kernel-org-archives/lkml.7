Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89127C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C3DB206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576516988;
	bh=fHbcvtzu1VdzlX9c5s4eLAvXwpMi1r6jDqkn5p32s8I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=D1zYBf2k2N3nsZhqlAaICxBX6cDzcrt1m/KH7onaiFaxCMMNdiMkcqHjI2c1q96qX
	 dmdmWybPKP7y10bbJfQvUEcTsW5vqGhLoSBPF2kEAgdwwZdEnWLh/8eTw26CA4q2mL
	 QyLbbNKr1mlfBVWh5pzvLnlTD0cRxEF6jZgbfDd0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfLPRXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:23:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:53790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbfLPRXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:23:07 -0500
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64A772146E
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 17:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576516985;
        bh=fHbcvtzu1VdzlX9c5s4eLAvXwpMi1r6jDqkn5p32s8I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kzCagTQkaLc2KKySRv+XTR9MWdy2/jBk5Dzbx3U1Lfll5mI+fo7ihWR/ZTDUDc6S6
         8Hhv/qDkoOn1qITZyTTIebN1ayGL6lVpfOBp7/ksfb3F7CLcSjMZY7NUE8Ba1aV/p0
         8TG+HNAZ0jikMTLywSXKLJ2Csh1QuSN1xpjKFBpM=
Received: by mail-wr1-f43.google.com with SMTP id g17so8298563wro.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 09:23:05 -0800 (PST)
X-Gm-Message-State: APjAAAWpbyXdIeu2AS3V3nnPuv1KRz2S2/TF+qbAOWqRr6bTc8YBsN8z
        o+upQ0eF78DOBo9zN72CdMBIjUTP/wVQW2in+OdTWQ==
X-Google-Smtp-Source: APXvYqzlPAu/PDh35DVHlZKmUKrrLPrawvOthGSWQnF5wzroTS23lOPMVJr5VXH3MmM7DF5D+Bxfw48zWe4raz1YCuY=
X-Received: by 2002:adf:f20b:: with SMTP id p11mr30784935wro.195.1576516983627;
 Mon, 16 Dec 2019 09:23:03 -0800 (PST)
MIME-Version: 1.0
References: <CALCETrW+qxrE633qetS4c1Rn2AX_hk5OgneZRtoZPFN1J395Ng@mail.gmail.com>
 <20191121185303.GB199273@romley-ivt3.sc.intel.com> <20191121202508.GZ4097@hirez.programming.kicks-ass.net>
 <CALCETrXbe_q07kL1AyaNaAqgUHsdN6rEDzzZ0CEtv-k9VvQL0A@mail.gmail.com>
 <20191122092555.GA4097@hirez.programming.kicks-ass.net> <3908561D78D1C84285E8C5FCA982C28F7F4DD19F@ORSMSX115.amr.corp.intel.com>
 <20191122203105.GE2844@hirez.programming.kicks-ass.net> <CALCETrVjXC7RHZCkAcWEeCrJq7DPeVBooK8S3mG0LT8q9AxvPw@mail.gmail.com>
 <20191211175202.GQ2827@hirez.programming.kicks-ass.net> <CALCETrXUZ790WFk9SEzuiKg-wMva=RpWhZNYPf+MqzT0xdu+gg@mail.gmail.com>
 <20191211223407.GT2844@hirez.programming.kicks-ass.net> <CALCETrUr+LwpQm5caeKgXGhaZ87HmcNn4wTsmkPzTEptp6sC6g@mail.gmail.com>
 <8d880a468c6242b9a951a83716ddeb07@AcuMS.aculab.com>
In-Reply-To: <8d880a468c6242b9a951a83716ddeb07@AcuMS.aculab.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 16 Dec 2019 09:22:50 -0800
X-Gmail-Original-Message-ID: <CALCETrW1LDuzcnvav=MY1bUv4jQ25n30La5m5x8tXfDknfV_cQ@mail.gmail.com>
Message-ID: <CALCETrW1LDuzcnvav=MY1bUv4jQ25n30La5m5x8tXfDknfV_cQ@mail.gmail.com>
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
To:     David Laight <David.Laight@aculab.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 1:59 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Andy Lutomirski
> > Sent: 12 December 2019 19:41
> > On Wed, Dec 11, 2019 at 2:34 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Wed, Dec 11, 2019 at 10:12:56AM -0800, Andy Lutomirski wrote:
> >
> > > > > Sure, but we're talking two cpus here.
> > > > >
> > > > >         u32 var = 0;
> > > > >         u8 *ptr = &var;
> > > > >
> > > > >         CPU0                    CPU1
> > > > >
> > > > >                                 xchg(ptr, 1)
> > > > >
> > > > >         xchg((ptr+1, 1);
> > > > >         r = READ_ONCE(var);
> > > > >
> > > > > AFAICT nothing guarantees r == 0x0101. The CPU1 store can be stuck in
> > > > > CPU1's store-buffer. CPU0's xchg() does not overlap and therefore
> > > > > doesn't force a snoop or forward.
> > > >
> > > > I think I don't quite understand.  The final value of var had better
> > > > be 0x0101 or something is severely wrong.
> > >
> > > > But r can be 0x0100 because
> > > > nothing in this example guarantees that the total order of the locked
> > > > instructions has CPU 1's instruction first.
> > >
> > > Assuming CPU1 goes first, why would the load from CPU0 see CPU1's
> > > ptr[0]? It can be in CPU1 store buffer, and TSO allows regular reads to
> > > ignore (remote) store-buffers.
> >
> > What I'm saying is: if CPU0 goes first, then the three operations order as:
> >
> >
> >
> > xchg(ptr+1, 1);
> > r = READ_ONCE(var);  /* 0x0100 */
> > xchg(ptr, 1);
> >
> > Anyway, this is all a bit too hypothetical for me.  Is there a clear
> > example where the total ordering of LOCKed instructions is observable?
> >  That is, is there a sequence of operations on, presumably, two or
> > three CPUs, such that LOCKed instructions being only partially ordered
> > allows an outcome that is disallowed by a total ordering?  I suspect
> > there is, but I haven't come up with it yet.  (I mean in an x86-like
> > memory model.  Getting this in a relaxed atomic model is easy.)
> >
> > As a probably bad example:
> >
> > u32 x0, x1, a1, b0, b1;
> >
> > CPU 0:
> > xchg(&x0, 1);
> > barrier();
> > a1 = READ_ONCE(x1);
> >
> > CPU 1:
> > xchg(&b, 1);
> >
> > CPU 2:
> > b1 = READ_ONCE(x1);
> > smp_rmb();  /* which is just barrier() on x86 */
> > b0 = READ_ONCE(x0);
> >
> > Suppose a1 == 0 and b1 == 1.  Then we know that CPU0's READ_ONCE
> > happened before CPU1's xchg and hence CPU0's xchg happened before
> > CPU1's xchg.  We also know that CPU2's first read observed the write
> > from CPU1's xchg, which means that CPU2's second read should have been
> > after CPU0's xchg (because the xchg operations have a total order
> > according to the SDM).  This means that b0 can't be 0.
> >
> > Hence the outcome (a1, b1, b0) == (0, 1, 0) is disallowed.
> >
> > It's entirely possible that I screwed up the analysis.  But I think
> > this means that the cache coherency mechanism is doing something more
> > intelligent than just shoving the x0=1 write into the store buffer and
> > letting it hang out there.  Something needs to make sure that CPU 2
> > observes everything in the same order that CPU 0 observes, and, as far
> > as I know it, there is a considerable amount of complexity in the CPUs
> > that makes sure this happens.
> >
> > So here's my question: do you have a concrete example of a series of
> > operations and an outcome that you suspect Intel CPUs allow but that
> > is disallowed in the SDM?
>
> I'm not sure that example is at all relevant.
> READ_ONCE() doesn't have any sequencing requirements on the cpu, just on the compiler.
> (The same is true of any 'atomic read'.)

I'm talking specifically about x86 here, where, for example, "Reads
are not reordered with other reads".  So READ_ONCE *does* have
sequencing requirements on the CPUs.

Feel free to replace READ_ONCE with MOV in your head if you like :)
