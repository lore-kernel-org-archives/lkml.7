Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA00C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 04:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F0520811
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 04:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553661077;
	bh=IQffYDPnde+Eh2G6P9uQ5Q9qKXTu+AggMJa55y70DX0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=E0lR0eg0C0W2K9VkyV/dCxfDMycVdg8/CXxlGNJJC8jxQIwN0ARFiiVCq1SxieYRQ
	 o0MdSzmFQAV8bIMm23r2VorKrD4EHUfnDAYcWc/2RVFS+xjPm8R7wxzqevNU5G8X4w
	 bqTrB7xER1qN+DNw3EIK1Ufmw14BhKs1akGMhBHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731701AbfC0EbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 00:31:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbfC0EbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 00:31:15 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D11692173C
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 04:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553661074;
        bh=IQffYDPnde+Eh2G6P9uQ5Q9qKXTu+AggMJa55y70DX0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QSoLLF/E0JlsD5wR04lImeidBbZUu7jI4slY6TDyLdExkc+vjlCASt5oxYtzCbIlg
         Si5RVp+0XLDEEgZR9TGqIlYEi5UqtVsscD51zRVprxRfDypNKPy7mICZSq2rir+nlC
         V/tEu3MM0T35bmIaatn2A3afHJkzsD17WcdCFvtA=
Received: by mail-wr1-f53.google.com with SMTP id r4so9156796wrq.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 21:31:13 -0700 (PDT)
X-Gm-Message-State: APjAAAWPh1DopnNl4zHutfI4u25UwBs74itKdzd3OOeMxx96h+72ayCa
        9KTlNJyLkbYwNNUYsAAcmyjXdPO1XXMLabrk7SU/Mw==
X-Google-Smtp-Source: APXvYqyHDglPQyFxSIxu8cP0ad5WAv8ksHHsN3v3hQ1CNXGuhkHpH5LkGsFa3XE+8DcJu6jI4BUK+LT1YKeNUXV734o=
X-Received: by 2002:adf:f344:: with SMTP id e4mr20835294wrp.77.1553661072327;
 Tue, 26 Mar 2019 21:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190318094128.1488-1-elena.reshetova@intel.com>
 <CALCETrUxhzHyUQCAjPQcPNWwAw5UTxUX4ZaeGxpbf9VSCDdcPg@mail.gmail.com>
 <CAGXu5jLQaa2FYMOpQPLdRPmUPNY8jq7whM6Wa_YGjfH7oHwx4Q@mail.gmail.com> <2236FBA76BA1254E88B949DDB74E612BA4C19A55@IRSMSX102.ger.corp.intel.com>
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612BA4C19A55@IRSMSX102.ger.corp.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 26 Mar 2019 21:31:01 -0700
X-Gmail-Original-Message-ID: <CALCETrXnfk5zYWmpdLvYbcJ7hhFM13+LPq14MF7s99iqtS4-jg@mail.gmail.com>
Message-ID: <CALCETrXnfk5zYWmpdLvYbcJ7hhFM13+LPq14MF7s99iqtS4-jg@mail.gmail.com>
Subject: Re: [RFC PATCH] x86/entry/64: randomize kernel stack offset upon syscall
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jann Horn <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 3:35 AM Reshetova, Elena
<elena.reshetova@intel.com> wrote:
>
> > On Mon, Mar 18, 2019 at 1:16 PM Andy Lutomirski <luto@kernel.org> wrote:
> > > On Mon, Mar 18, 2019 at 2:41 AM Elena Reshetova
> > > <elena.reshetova@intel.com> wrote:
> > > > Performance:
> > > >
> > > > 1) lmbench: ./lat_syscall -N 1000000 null
> > > >     base:                     Simple syscall: 0.1774 microseconds
> > > >     random_offset (rdtsc):     Simple syscall: 0.1803 microseconds
> > > >     random_offset (rdrand): Simple syscall: 0.3702 microseconds
> > > >
> > > > 2)  Andy's tests, misc-tests: ./timing_test_64 10M sys_enosys
> > > >     base:                     10000000 loops in 1.62224s = 162.22 nsec / loop
> > > >     random_offset (rdtsc):     10000000 loops in 1.64660s = 164.66 nsec / loop
> > > >     random_offset (rdrand): 10000000 loops in 3.51315s = 351.32 nsec / loop
> > > >
> > >
> > > Egads!  RDTSC is nice and fast but probably fairly easy to defeat.
> > > RDRAND is awful.  I had hoped for better.
> >
> > RDRAND can also fail.
> >
> > > So perhaps we need a little percpu buffer that collects 64 bits of
> > > randomness at a time, shifts out the needed bits, and refills the
> > > buffer when we run out.
> >
> > I'd like to avoid saving the _exact_ details of where the next offset
> > will be, but if nothing else works, this should be okay. We can use 8
> > bits at a time and call prandom_u32() every 4th call. Something like
> > prandom_bytes(), but where it doesn't throw away the unused bytes.
>
> Actually I think this would make the end result even worse security-wise
> than simply using rdtsc() on every syscall. Saving the randomness in percpu
> buffer, which is probably easily accessible and can be probed if needed,
> would supply attacker with much more knowledge about the next 3-4
> random offsets that what he would get if we use "weak" rdtsc. Given
> that for a successful exploit, an attacker would need to have stack aligned
> once only, having a knowledge of 3-4 next offsets sounds like a present to an
> exploit writer...  Additionally it creates complexity around the code that I
> have issues justifying with "security" argument because of above...
>
> I have the patch now with alloca() and rdtsc() working, I can post it
> (albeit it is very simple), but I am really hesitating on adding the percpu
> buffer randomness storage to it...
>

Hmm.  I guess it depends on what types of attack you care about.  I
bet that, if you do a bunch of iterations of mfence;rdtsc;syscall,
you'll discover that the offset between the user rdtsc and the
syscall's rdtsc has several values that occur with high probability.

--Andy
