Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0E7C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 11:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E942B20B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 11:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YbJT7VLF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfE2LaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 07:30:04 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44285 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfE2LaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 07:30:03 -0400
Received: by mail-io1-f65.google.com with SMTP id f22so1465295iol.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 04:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3AdnAOZFu4T3VBLgV3Cb7hGxak9UusYOHweQj/woqpE=;
        b=YbJT7VLF4EXpOP4frqI3h2ZWg+MvdYl1EcxcxoPpSvysi9/h8uPfj9huYGacHLliwq
         lXKJ5Nt8YwVeF2GdICbcjzR1wYLcB0INTyrcb/spYH/BGMoQUR1eYDu0fovRTsEj2+8H
         JAnoXuBFtr2BZZZLuXm9cNAcKYRHASNNO7YEs7iKIwzwCv2lKvEW8MZcUXginzp0sHFh
         tFYcM402isNrOPv26jbdmbaSG7wbEShXq2neN6NSl6sKVpoXZ6rGomBKbemce1H3IOL2
         aT775e4lQJ0z6fLkdelGmbf3nU5fRPwfJsaOA9vTdNE6cezbRgRYTOdsaZXZrbQ6gqoF
         1DJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3AdnAOZFu4T3VBLgV3Cb7hGxak9UusYOHweQj/woqpE=;
        b=Opwd0aC1urr8tPlgOkx8AowcRfuFtdho5bHsLI2MZqoHaMwUAcaKEihvGYqMsL3Lgq
         OobwAYGRDs/GAJxf7iTGsuBpHKk5b39hDTPkDSEB+w38KXc26beD5hYdhamAyBs0hoLp
         W2tQrSluxSwLqE3MRhhEhZbY3sWAMYgyTz1pCMAqDRa/uuq14OVw5E2K0MImMXzG9nuM
         xXWp4jIdxYWaXRprBuvDzRNKtbJJVC/oBWAWeiBYKwlfraYq8OwceRaRvY0EVzYtu5ki
         YEQR6VnV0SH75LfcDwDmMq+EtCtbZ1SAsPomVPJ0N7My98VKknuEJ3MrYKH8A/Qd54GB
         a+Vw==
X-Gm-Message-State: APjAAAW6m/pdG4e5BZhgPQbDc/lRZaw+/yZtO8MPXnOcTmrSJIXtnAop
        kWOYTpHov1Aebkjfb3xSmxny61ngSyYRhtF9P7NA7Q==
X-Google-Smtp-Source: APXvYqyVwPDd95rHfY9i4aGvRmgXfEv3sLVceDCkw8CTOnp9BwIu5MYpLT9fOo4M9LLzrdVhRoRmAEORzUqoTj/eBx4=
X-Received: by 2002:a6b:e711:: with SMTP id b17mr12875963ioh.3.1559129402345;
 Wed, 29 May 2019 04:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190528163258.260144-1-elver@google.com> <20190528163258.260144-3-elver@google.com>
 <20190528165036.GC28492@lakrids.cambridge.arm.com> <CACT4Y+bV0CczjRWgHQq3kvioLaaKgN+hnYEKCe5wkbdngrm+8g@mail.gmail.com>
 <CANpmjNNtjS3fUoQ_9FQqANYS2wuJZeFRNLZUq-ku=v62GEGTig@mail.gmail.com>
 <20190529100116.GM2623@hirez.programming.kicks-ass.net> <CANpmjNMvwAny54udYCHfBw1+aphrQmiiTJxqDq7q=h+6fvpO4w@mail.gmail.com>
 <20190529103010.GP2623@hirez.programming.kicks-ass.net> <CACT4Y+aVB3jK_M0-2D_QTq=nncVXTsNp77kjSwBwjqn-3hAJmA@mail.gmail.com>
 <377465ba-3b31-31e7-0f9d-e0a5ab911ca4@virtuozzo.com>
In-Reply-To: <377465ba-3b31-31e7-0f9d-e0a5ab911ca4@virtuozzo.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 29 May 2019 13:29:51 +0200
Message-ID: <CACT4Y+ZDmqqM6YW72Q-=kAurta5ctscLT5p=nQJ5y=82yVMq=w@mail.gmail.com>
Subject: Re: [PATCH 3/3] asm-generic, x86: Add bitops instrumentation for KASAN
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
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

On Wed, May 29, 2019 at 1:23 PM Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
> On 5/29/19 1:57 PM, Dmitry Vyukov wrote:
> > On Wed, May 29, 2019 at 12:30 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >>
> >> On Wed, May 29, 2019 at 12:16:31PM +0200, Marco Elver wrote:
> >>> On Wed, 29 May 2019 at 12:01, Peter Zijlstra <peterz@infradead.org> wrote:
> >>>>
> >>>> On Wed, May 29, 2019 at 11:20:17AM +0200, Marco Elver wrote:
> >>>>> For the default, we decided to err on the conservative side for now,
> >>>>> since it seems that e.g. x86 operates only on the byte the bit is on.
> >>>>
> >>>> This is not correct, see for instance set_bit():
> >>>>
> >>>> static __always_inline void
> >>>> set_bit(long nr, volatile unsigned long *addr)
> >>>> {
> >>>>         if (IS_IMMEDIATE(nr)) {
> >>>>                 asm volatile(LOCK_PREFIX "orb %1,%0"
> >>>>                         : CONST_MASK_ADDR(nr, addr)
> >>>>                         : "iq" ((u8)CONST_MASK(nr))
> >>>>                         : "memory");
> >>>>         } else {
> >>>>                 asm volatile(LOCK_PREFIX __ASM_SIZE(bts) " %1,%0"
> >>>>                         : : RLONG_ADDR(addr), "Ir" (nr) : "memory");
> >>>>         }
> >>>> }
> >>>>
> >>>> That results in:
> >>>>
> >>>>         LOCK BTSQ nr, (addr)
> >>>>
> >>>> when @nr is not an immediate.
> >>>
> >>> Thanks for the clarification. Given that arm64 already instruments
> >>> bitops access to whole words, and x86 may also do so for some bitops,
> >>> it seems fine to instrument word-sized accesses by default. Is that
> >>> reasonable?
> >>
> >> Eminently -- the API is defined such; for bonus points KASAN should also
> >> do alignment checks on atomic ops. Future hardware will #AC on unaligned
> >> [*] LOCK prefix instructions.
> >>
> >> (*) not entirely accurate, it will only trap when crossing a line.
> >>     https://lkml.kernel.org/r/1556134382-58814-1-git-send-email-fenghua.yu@intel.com
> >
> > Interesting. Does an address passed to bitops also should be aligned,
> > or alignment is supposed to be handled by bitops themselves?
> >
>
> It should be aligned. This even documented in Documentation/core-api/atomic_ops.rst:
>
>         Native atomic bit operations are defined to operate on objects aligned
>         to the size of an "unsigned long" C data type, and are least of that
>         size.  The endianness of the bits within each "unsigned long" are the
>         native endianness of the cpu.
>
>
> > This probably should be done as a separate config as not related to
> > KASAN per se. But obviously via the same
> > {atomicops,bitops}-instrumented.h hooks which will make it
> > significantly easier.
> >
>
> Agreed.

Thanks. I've filed https://bugzilla.kernel.org/show_bug.cgi?id=203751
for checking alignment with all the points and references, so that
it's not lost.
