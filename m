Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3F0C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 19:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C28822253D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 19:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576179664;
	bh=3mdH5uJVVqe6b0uV/b7ne6K15jv7ISIqE7RpR8fkSo8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eE9NvUgHI1Lsbx35i4mgeAUHyc4ZxFRItMMMZTEWzG9s8Pj0z5CE6aKJ8cm55vSyR
	 3Qjqff0ie1hJGtjPGTFZyBUiABEWpAg0ZTZ8glGeCJ7y+hapjeL7omHiiMI24zxK0M
	 HcozHqL75/DfjAYN1Vp8Ih/Q7N9T5XhC3hO5dHDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbfLLTlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 14:41:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:44732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730284AbfLLTlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 14:41:03 -0500
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 673D3227BF
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 19:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576179662;
        bh=3mdH5uJVVqe6b0uV/b7ne6K15jv7ISIqE7RpR8fkSo8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OZovex24FGJneMwgx2EDsdJl+8WhEdW3+H1iZrlBGsvnanfDpx+cPqP1UJ9mO27tw
         BUhYuW86mpRdbQfo1Mvjs9gHHFSB5h0iy06YDKFGhQU6g0uZbDvW1OBkii78WPrScR
         18WphFUqKkunluSkP37QdHdgcSL+sJkBFJ0zbyuE=
Received: by mail-wr1-f51.google.com with SMTP id q10so4012994wrm.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 11:41:02 -0800 (PST)
X-Gm-Message-State: APjAAAU5OFMxeJv6cxlqQu9YQlDnQ6WgeQpMLVOkRGXYobjpW9VwWoKD
        lrPJCEDJD6kKNUAYMEo39xboRYahLWdRwxrsw03zLg==
X-Google-Smtp-Source: APXvYqzI/kwPwq2F8DDKlhALkyGBDaEmukQnDgvmTxM5D0RNlH70QBZtezYOEVACQL/pNf1U1rC/RbBDjFfhxcf9CGU=
X-Received: by 2002:adf:eb09:: with SMTP id s9mr8477929wrn.61.1576179660775;
 Thu, 12 Dec 2019 11:41:00 -0800 (PST)
MIME-Version: 1.0
References: <CALCETrW+qxrE633qetS4c1Rn2AX_hk5OgneZRtoZPFN1J395Ng@mail.gmail.com>
 <20191121185303.GB199273@romley-ivt3.sc.intel.com> <20191121202508.GZ4097@hirez.programming.kicks-ass.net>
 <CALCETrXbe_q07kL1AyaNaAqgUHsdN6rEDzzZ0CEtv-k9VvQL0A@mail.gmail.com>
 <20191122092555.GA4097@hirez.programming.kicks-ass.net> <3908561D78D1C84285E8C5FCA982C28F7F4DD19F@ORSMSX115.amr.corp.intel.com>
 <20191122203105.GE2844@hirez.programming.kicks-ass.net> <CALCETrVjXC7RHZCkAcWEeCrJq7DPeVBooK8S3mG0LT8q9AxvPw@mail.gmail.com>
 <20191211175202.GQ2827@hirez.programming.kicks-ass.net> <CALCETrXUZ790WFk9SEzuiKg-wMva=RpWhZNYPf+MqzT0xdu+gg@mail.gmail.com>
 <20191211223407.GT2844@hirez.programming.kicks-ass.net>
In-Reply-To: <20191211223407.GT2844@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 12 Dec 2019 11:40:48 -0800
X-Gmail-Original-Message-ID: <CALCETrUr+LwpQm5caeKgXGhaZ87HmcNn4wTsmkPzTEptp6sC6g@mail.gmail.com>
Message-ID: <CALCETrUr+LwpQm5caeKgXGhaZ87HmcNn4wTsmkPzTEptp6sC6g@mail.gmail.com>
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        David Laight <David.Laight@aculab.com>,
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

On Wed, Dec 11, 2019 at 2:34 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Dec 11, 2019 at 10:12:56AM -0800, Andy Lutomirski wrote:

> > > Sure, but we're talking two cpus here.
> > >
> > >         u32 var = 0;
> > >         u8 *ptr = &var;
> > >
> > >         CPU0                    CPU1
> > >
> > >                                 xchg(ptr, 1)
> > >
> > >         xchg((ptr+1, 1);
> > >         r = READ_ONCE(var);
> > >
> > > AFAICT nothing guarantees r == 0x0101. The CPU1 store can be stuck in
> > > CPU1's store-buffer. CPU0's xchg() does not overlap and therefore
> > > doesn't force a snoop or forward.
> >
> > I think I don't quite understand.  The final value of var had better
> > be 0x0101 or something is severely wrong.
>
> > But r can be 0x0100 because
> > nothing in this example guarantees that the total order of the locked
> > instructions has CPU 1's instruction first.
>
> Assuming CPU1 goes first, why would the load from CPU0 see CPU1's
> ptr[0]? It can be in CPU1 store buffer, and TSO allows regular reads to
> ignore (remote) store-buffers.

What I'm saying is: if CPU0 goes first, then the three operations order as:



xchg(ptr+1, 1);
r = READ_ONCE(var);  /* 0x0100 */
xchg(ptr, 1);

Anyway, this is all a bit too hypothetical for me.  Is there a clear
example where the total ordering of LOCKed instructions is observable?
 That is, is there a sequence of operations on, presumably, two or
three CPUs, such that LOCKed instructions being only partially ordered
allows an outcome that is disallowed by a total ordering?  I suspect
there is, but I haven't come up with it yet.  (I mean in an x86-like
memory model.  Getting this in a relaxed atomic model is easy.)

As a probably bad example:

u32 x0, x1, a1, b0, b1;

CPU 0:
xchg(&x0, 1);
barrier();
a1 = READ_ONCE(x1);

CPU 1:
xchg(&b, 1);

CPU 2:
b1 = READ_ONCE(x1);
smp_rmb();  /* which is just barrier() on x86 */
b0 = READ_ONCE(x0);

Suppose a1 == 0 and b1 == 1.  Then we know that CPU0's READ_ONCE
happened before CPU1's xchg and hence CPU0's xchg happened before
CPU1's xchg.  We also know that CPU2's first read observed the write
from CPU1's xchg, which means that CPU2's second read should have been
after CPU0's xchg (because the xchg operations have a total order
according to the SDM).  This means that b0 can't be 0.

Hence the outcome (a1, b1, b0) == (0, 1, 0) is disallowed.

It's entirely possible that I screwed up the analysis.  But I think
this means that the cache coherency mechanism is doing something more
intelligent than just shoving the x0=1 write into the store buffer and
letting it hang out there.  Something needs to make sure that CPU 2
observes everything in the same order that CPU 0 observes, and, as far
as I know it, there is a considerable amount of complexity in the CPUs
that makes sure this happens.

So here's my question: do you have a concrete example of a series of
operations and an outcome that you suspect Intel CPUs allow but that
is disallowed in the SDM?

--Andy
