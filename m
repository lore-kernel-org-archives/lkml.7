Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B951DC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 927D820B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rtsUS66O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfE2K5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 06:57:33 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:35680 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfE2K5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 06:57:33 -0400
Received: by mail-it1-f195.google.com with SMTP id u186so2809871ith.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 03:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j0vRsAP/7oCPDaNFunzfNnWkHNHD3PczMiRqJpFCS8w=;
        b=rtsUS66OXMb2mbLSKawrplR44Ksq1THB3HNVn1DNseo+u89Ythl4ZA2z6G+pEceOyh
         k/Ujhdfy++i5sHhkxmId2PeU6nf7C/H0JkrXQ4NKtvxy9jNs9QGtgLmqXvgaKG7Q6uE9
         COzzdK3rqRrk1kF3xmfAZNC6OAxhCtx3+Ufs6FqeHIl/+5FLLO8wiupl+RIxRJ2xRRh/
         JWgrneJjIv/Cjn/VMPYhERQzIS36u6n5j/PtHggx8SA8mSnnfS9Iq+gsQssSHINbnoYb
         x0TI0mOzhl6XeH2zgr/NbP7SdbKBLRHnV6kQLVCDD+ffvQrBM/J+z7yjbi9AVNCJlI1B
         wFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j0vRsAP/7oCPDaNFunzfNnWkHNHD3PczMiRqJpFCS8w=;
        b=CslLbRhGQ0M5zwlyPd+2vEslAv3pKgI+kmpQmgO/fHOjerBS6gZvm34qXqDO7VEFN9
         0KfmXCsCtXBA6tYRNrE6OF1zIeHnKaUSk2zxrd4510fZcWhsivcR0goAbVbzvIPORvd5
         SwThH8ozFsYNvNADjARdUj2g4lF+ZuVnrHvVnf2GTAdKX8lN8TkYMeiyHRhsPzPgpNfS
         DZobHjBw8pAbTzjCVgODbxW3H7IJ6lwZMSm6aQYW/cNuUfub7FRGIIBfUxlP1sCcO5/G
         LwPjvalEP2uyHQx92PdGoUQQn8wjWTJoIMVEQdhgHBAFYdlpwQfwsLm7mirXCfUleNIq
         k8oQ==
X-Gm-Message-State: APjAAAUK0ymBcYIfa3rN2XkV7VCI/8rpYxuUY+9jZV5ZJi42Os6mCnIp
        r7IkG2krlRhFIbnkxM0dgO9iuDJQi0KTqSKC4xbfTQ==
X-Google-Smtp-Source: APXvYqzNQqwEEgQdlwddRMtunB+fpJEWQo9KIVGLWRhkJXU6lluRsHXz3n6M5jRDu9uzYR1I0xbnnWgv6pfB98UiDSM=
X-Received: by 2002:a24:c204:: with SMTP id i4mr6670043itg.83.1559127447315;
 Wed, 29 May 2019 03:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190528163258.260144-1-elver@google.com> <20190528163258.260144-3-elver@google.com>
 <20190528165036.GC28492@lakrids.cambridge.arm.com> <CACT4Y+bV0CczjRWgHQq3kvioLaaKgN+hnYEKCe5wkbdngrm+8g@mail.gmail.com>
 <CANpmjNNtjS3fUoQ_9FQqANYS2wuJZeFRNLZUq-ku=v62GEGTig@mail.gmail.com>
 <20190529100116.GM2623@hirez.programming.kicks-ass.net> <CANpmjNMvwAny54udYCHfBw1+aphrQmiiTJxqDq7q=h+6fvpO4w@mail.gmail.com>
 <20190529103010.GP2623@hirez.programming.kicks-ass.net>
In-Reply-To: <20190529103010.GP2623@hirez.programming.kicks-ass.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 29 May 2019 12:57:15 +0200
Message-ID: <CACT4Y+aVB3jK_M0-2D_QTq=nncVXTsNp77kjSwBwjqn-3hAJmA@mail.gmail.com>
Subject: Re: [PATCH 3/3] asm-generic, x86: Add bitops instrumentation for KASAN
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
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

On Wed, May 29, 2019 at 12:30 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, May 29, 2019 at 12:16:31PM +0200, Marco Elver wrote:
> > On Wed, 29 May 2019 at 12:01, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Wed, May 29, 2019 at 11:20:17AM +0200, Marco Elver wrote:
> > > > For the default, we decided to err on the conservative side for now,
> > > > since it seems that e.g. x86 operates only on the byte the bit is on.
> > >
> > > This is not correct, see for instance set_bit():
> > >
> > > static __always_inline void
> > > set_bit(long nr, volatile unsigned long *addr)
> > > {
> > >         if (IS_IMMEDIATE(nr)) {
> > >                 asm volatile(LOCK_PREFIX "orb %1,%0"
> > >                         : CONST_MASK_ADDR(nr, addr)
> > >                         : "iq" ((u8)CONST_MASK(nr))
> > >                         : "memory");
> > >         } else {
> > >                 asm volatile(LOCK_PREFIX __ASM_SIZE(bts) " %1,%0"
> > >                         : : RLONG_ADDR(addr), "Ir" (nr) : "memory");
> > >         }
> > > }
> > >
> > > That results in:
> > >
> > >         LOCK BTSQ nr, (addr)
> > >
> > > when @nr is not an immediate.
> >
> > Thanks for the clarification. Given that arm64 already instruments
> > bitops access to whole words, and x86 may also do so for some bitops,
> > it seems fine to instrument word-sized accesses by default. Is that
> > reasonable?
>
> Eminently -- the API is defined such; for bonus points KASAN should also
> do alignment checks on atomic ops. Future hardware will #AC on unaligned
> [*] LOCK prefix instructions.
>
> (*) not entirely accurate, it will only trap when crossing a line.
>     https://lkml.kernel.org/r/1556134382-58814-1-git-send-email-fenghua.yu@intel.com

Interesting. Does an address passed to bitops also should be aligned,
or alignment is supposed to be handled by bitops themselves?

This probably should be done as a separate config as not related to
KASAN per se. But obviously via the same
{atomicops,bitops}-instrumented.h hooks which will make it
significantly easier.
