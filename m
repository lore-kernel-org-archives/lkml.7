Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7645EC04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 08:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE9A20B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 08:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iag1iqkl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbfE2Ixp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 04:53:45 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:39549 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfE2Ixo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 04:53:44 -0400
Received: by mail-it1-f196.google.com with SMTP id 9so2275539itf.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 01:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fk93ITL8R4mrLU9REN4UKK4IhmKV6EO0365BfuSaHXw=;
        b=iag1iqklG59C7CBe1Q1yLiAwrdIea1ur40jUv0F6T5dEfMY0jxy+j++u5JmUBuntoa
         EwUGR6EkVeDx7XcFiDHZsKB495YcnzJoAArBNdkNW4RU2DfJ77hULVO9OsQhthuc2j18
         R/bC8O07j3uVjmmzTeABEZZIjNCjaC95M+bimnrGjlhNPegpFdCacpo8SW5INIF0Isog
         hMAuYUUq10E3RD5FJL6QV5ovsTZePNTA0Z25SfUIKy1eCMeM7oWOZyAHr7X4gSVs6NRX
         KLhadZKjYWWkGnCpOLSTt6DCK+sMm5rQpAswy1Gn0wiuv4Tg2Tv6I1FZuLC3fEdSklSe
         zleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fk93ITL8R4mrLU9REN4UKK4IhmKV6EO0365BfuSaHXw=;
        b=KfDBgDElx5ZCwbWSwOelb1F00C1/k/P3LLAVEKxt/kWV+ixwQtjE/tISXTzhfknLo1
         qE35CZ0e50syWo627yffqQ58RdKKCDxcr+XjEVUWBco7w7jSUDQjhLjc6X8rs0X99kGp
         qY4k09Vw3zNszhALSQRmQ/JRgu/WQvCUg0J0t/RkQYZTH6O0VRAD1nal8TAGKILnvQVt
         2SOsRu0/G2SQp88AbyWSSnUk2fkxWfKFo+KGGyYl1xJoPOz/dlU88RIDf6uY9vx5205w
         Nsjz1D2TUadLM+PbHpmm3ihuHW6Ppqy38dYCNg55IeofcHrkhYaWbCXUE6AJr919oEHg
         v3kA==
X-Gm-Message-State: APjAAAUjvqc1E9qGrgeg11VFbl5yf/GFAba7XWGtpTWphM/oQrSQw6ed
        lmMi6YpO7u63+csThEhrfjMNnaN36jbh3er/RNDQAg==
X-Google-Smtp-Source: APXvYqwRV1Ecj1ZeYKU14oETte/gMkEfiRo03ta+hp/7w0IznzXuOVxdCcfxGLTebV18JF/VozM9amvKpyRnIkPc1M4=
X-Received: by 2002:a24:91d2:: with SMTP id i201mr6764834ite.88.1559120023781;
 Wed, 29 May 2019 01:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190528163258.260144-1-elver@google.com> <20190528163258.260144-3-elver@google.com>
 <20190528165036.GC28492@lakrids.cambridge.arm.com>
In-Reply-To: <20190528165036.GC28492@lakrids.cambridge.arm.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 29 May 2019 10:53:32 +0200
Message-ID: <CACT4Y+bV0CczjRWgHQq3kvioLaaKgN+hnYEKCe5wkbdngrm+8g@mail.gmail.com>
Subject: Re: [PATCH 3/3] asm-generic, x86: Add bitops instrumentation for KASAN
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Marco Elver <elver@google.com>,
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

On Tue, May 28, 2019 at 6:50 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, May 28, 2019 at 06:32:58PM +0200, Marco Elver wrote:
> > This adds a new header to asm-generic to allow optionally instrumenting
> > architecture-specific asm implementations of bitops.
> >
> > This change includes the required change for x86 as reference and
> > changes the kernel API doc to point to bitops-instrumented.h instead.
> > Rationale: the functions in x86's bitops.h are no longer the kernel API
> > functions, but instead the arch_ prefixed functions, which are then
> > instrumented via bitops-instrumented.h.
> >
> > Other architectures can similarly add support for asm implementations of
> > bitops.
> >
> > The documentation text has been copied/moved, and *no* changes to it
> > have been made in this patch.
> >
> > Tested: using lib/test_kasan with bitops tests (pre-requisite patch).
> >
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=198439
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> >  Documentation/core-api/kernel-api.rst     |   2 +-
> >  arch/x86/include/asm/bitops.h             | 210 ++++----------
> >  include/asm-generic/bitops-instrumented.h | 327 ++++++++++++++++++++++
> >  3 files changed, 380 insertions(+), 159 deletions(-)
> >  create mode 100644 include/asm-generic/bitops-instrumented.h
>
> [...]
>
> > +#if !defined(BITOPS_INSTRUMENT_RANGE)
> > +/*
> > + * This may be defined by an arch's bitops.h, in case bitops do not operate on
> > + * single bytes only. The default version here is conservative and assumes that
> > + * bitops operate only on the byte with the target bit.
> > + */
> > +#define BITOPS_INSTRUMENT_RANGE(addr, nr)                                  \
> > +     (const volatile char *)(addr) + ((nr) / BITS_PER_BYTE), 1
> > +#endif
>
> I was under the impression that logically, all the bitops operated on
> the entire long the bit happend to be contained in, so checking the
> entire long would make more sense to me.
>
> FWIW, arm64's atomic bit ops are all implemented atop of atomic_long_*
> functions, which are instrumented, and always checks at the granularity
> of a long. I haven't seen splats from that when fuzzing with Syzkaller.
>
> Are you seeing bugs without this?

bitops are not instrumented on x86 at all at the moment, so we have
not seen any splats. What we've seen are assorted crashes caused by
previous silent memory corruptions by incorrect bitops :)

Good point. If arm already does this, I guess we also need to check
whole long's.
