Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1554BC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC1220665
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QQZVTGNC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfE2JUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 05:20:30 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37354 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfE2JU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 05:20:29 -0400
Received: by mail-ot1-f67.google.com with SMTP id r10so1323222otd.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 02:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tOlYVVLvf1bFW7DEqIy65vvXcvlYUsyO7Mq7IqL0SoQ=;
        b=QQZVTGNCg3LioVwsXAFHwhg2CoTZJaD4RO2ICM7XB4FazwBQnOUAkd0k7haRz4Vtoa
         N9bMaDJ//2/wBo+8QMhJKKs/OOsDRgE/4zCnH3bDVEYM55a6t/XuV5Vf9P+vPH8zCRiD
         LLTEv9TrSkxF/Fsht32uuFrlbQnUMuS52I7vT385+XUNEUmbs/Aj/WgVxdzPy+HX1IUQ
         2D9rSBv8i3As2qGZdLneX32AU6lpqJNU4ZFNnkNfb4c+TYwzMtXaqv/VEA8Vlonr7jMY
         C/mCazc7hKNsmc6QRqqr3PKyRV3CqD/HK6SABQr+EFlPNw9v0zq0LZaC9TEZVU2eFGoK
         pLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tOlYVVLvf1bFW7DEqIy65vvXcvlYUsyO7Mq7IqL0SoQ=;
        b=GFiiuC//cOMzG2azHNc4vGHqulib7VGCNZKeu/YILPOWw8XsDQ2BmB3ZsJgAri5w66
         w9B9nIgR7x6DB2X/Fo5ZwYPDQmM9AJbyARfiexzB1wUBuJkfARftxzila7/17XSNMOEZ
         vRTNcOKJmQDafso8qMMQszfSSWYjo/+jPU+YvTbXa/IDI4uGRfFtVDqvWUA5YcSHRave
         Ixe0ftVUIMJTg7n5ugqdbO4YFjYqOMBPKba1cSQAvJSdqnmKfd662sE+IWoXIp8f03ot
         Dv+S4AjTPfWXnPsmTmmNZKmzLWGTtv0hSh9CB9gxpSIXw/A2JtV4GujMF3etoTyBMNU5
         BiRA==
X-Gm-Message-State: APjAAAUBmyeCytaO19NVIhP7BwHJcHM0iT+ZPrP41T6SNrHWpuhpbWQG
        7M4YRX+IKY9eJSI+S4jjN5bSYqNBdNYYrQPYyqGzFA==
X-Google-Smtp-Source: APXvYqwgN+ncNU0IwOIo9jHKQMn0C4Gxk5MYFtrkjPm6C0A/k1IQNZrOKxjDYzrsSLBm80TaHVkC2Rho0AowXhc+Rho=
X-Received: by 2002:a9d:6f8a:: with SMTP id h10mr28904206otq.2.1559121628572;
 Wed, 29 May 2019 02:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190528163258.260144-1-elver@google.com> <20190528163258.260144-3-elver@google.com>
 <20190528165036.GC28492@lakrids.cambridge.arm.com> <CACT4Y+bV0CczjRWgHQq3kvioLaaKgN+hnYEKCe5wkbdngrm+8g@mail.gmail.com>
In-Reply-To: <CACT4Y+bV0CczjRWgHQq3kvioLaaKgN+hnYEKCe5wkbdngrm+8g@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 29 May 2019 11:20:17 +0200
Message-ID: <CANpmjNNtjS3fUoQ_9FQqANYS2wuJZeFRNLZUq-ku=v62GEGTig@mail.gmail.com>
Subject: Re: [PATCH 3/3] asm-generic, x86: Add bitops instrumentation for KASAN
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2019 at 10:53, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Tue, May 28, 2019 at 6:50 PM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Tue, May 28, 2019 at 06:32:58PM +0200, Marco Elver wrote:
> > > This adds a new header to asm-generic to allow optionally instrumenting
> > > architecture-specific asm implementations of bitops.
> > >
> > > This change includes the required change for x86 as reference and
> > > changes the kernel API doc to point to bitops-instrumented.h instead.
> > > Rationale: the functions in x86's bitops.h are no longer the kernel API
> > > functions, but instead the arch_ prefixed functions, which are then
> > > instrumented via bitops-instrumented.h.
> > >
> > > Other architectures can similarly add support for asm implementations of
> > > bitops.
> > >
> > > The documentation text has been copied/moved, and *no* changes to it
> > > have been made in this patch.
> > >
> > > Tested: using lib/test_kasan with bitops tests (pre-requisite patch).
> > >
> > > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=198439
> > > Signed-off-by: Marco Elver <elver@google.com>
> > > ---
> > >  Documentation/core-api/kernel-api.rst     |   2 +-
> > >  arch/x86/include/asm/bitops.h             | 210 ++++----------
> > >  include/asm-generic/bitops-instrumented.h | 327 ++++++++++++++++++++++
> > >  3 files changed, 380 insertions(+), 159 deletions(-)
> > >  create mode 100644 include/asm-generic/bitops-instrumented.h
> >
> > [...]
> >
> > > +#if !defined(BITOPS_INSTRUMENT_RANGE)
> > > +/*
> > > + * This may be defined by an arch's bitops.h, in case bitops do not operate on
> > > + * single bytes only. The default version here is conservative and assumes that
> > > + * bitops operate only on the byte with the target bit.
> > > + */
> > > +#define BITOPS_INSTRUMENT_RANGE(addr, nr)                                  \
> > > +     (const volatile char *)(addr) + ((nr) / BITS_PER_BYTE), 1
> > > +#endif
> >
> > I was under the impression that logically, all the bitops operated on
> > the entire long the bit happend to be contained in, so checking the
> > entire long would make more sense to me.
> >
> > FWIW, arm64's atomic bit ops are all implemented atop of atomic_long_*
> > functions, which are instrumented, and always checks at the granularity
> > of a long. I haven't seen splats from that when fuzzing with Syzkaller.
> >
> > Are you seeing bugs without this?
>
> bitops are not instrumented on x86 at all at the moment, so we have
> not seen any splats. What we've seen are assorted crashes caused by
> previous silent memory corruptions by incorrect bitops :)
>
> Good point. If arm already does this, I guess we also need to check
> whole long's.

For the default, we decided to err on the conservative side for now,
since it seems that e.g. x86 operates only on the byte the bit is on.
Other architectures that need bitops-instrumented.h may redefine
BITOPS_INSTRUMENT_RANGE.

Let me know what you prefer.

Thanks,
-- Marco
