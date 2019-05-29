Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAFBC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 005AD2075B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uPCsWh9f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfE2KQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 06:16:44 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33959 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfE2KQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 06:16:43 -0400
Received: by mail-ot1-f66.google.com with SMTP id l17so1481281otq.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 03:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Abxu/H1sImqXuhwWhYSOk5xvOYnoBkkpjqInhihBcCI=;
        b=uPCsWh9fRkWJuwlKpXHz/RZG8nW7YVKwC5/i0AHmBQAElVNCKYPnYDRGPWr2Sdiy7J
         FGbrAZmtywaEWHYlECjBy38lyCo+kUWgsOoyLdN9JcCHLXuHsVfd0CNld++/Ri8YnZAJ
         /wEL+fD8DmpH+o4Nkygolmx0hfSISheT3J6qbDzFobiY0PK2bQiYhh7ywr38sKK0BfCi
         bKrsgKW4qELWcwep0HGbl3J/E2D/Bx3IVrWqSQnvtjtFNFIflWwXuZAN5zDPK0liW9L8
         JPaEVv4Vgk0MKUmIcicVi2gUce7F86R9k6BO/LqHPVAm0TaPXLX2Ht8Eb3X9GKl6IB8C
         Gp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Abxu/H1sImqXuhwWhYSOk5xvOYnoBkkpjqInhihBcCI=;
        b=McniaomAJ3Ykw8rd1oRN392cJu6+2Hi2NPh8PEIfZF41cFt7OUX71aZKlOK42q+6cf
         ZFF2n/zXHIIW7OFqkJjCfi4dbtsqWyuF5DRPE+URHGBZ0HHQQOYXUxbdSVZn+H6CwOxN
         s9eJ+vCwce+nBgLq0WivpYtcS9g0gMcRvRmRJ9MJeC480nLl6NXaJoSnOT925zyroIuW
         ybhus7w3MaDAxVWNcNqjPYouN1sTcrXRLaodrvGRmAVgH/JYfEiMko7HOtaVsYIaSlEC
         oxEZGXxcYuRD+UzbEPdjy/ArZYeN0OzQ1neRegm8eV2row8l66rbgvOH9pTPKkc42v/G
         sgeg==
X-Gm-Message-State: APjAAAVFGb+JT6WrjQEVGtm3fD+AB36zbajEkqs5ZHgbDuo7bTvAhh3P
        HwkHa6mSZj2izHBrS+d40Zmwi+1pERb6hsXxOIr0Jg==
X-Google-Smtp-Source: APXvYqyIW+HHgmO4UbA1lWAYQ9U1IvOgE1sk2LyiOyRvq+lk+NzeDhjzN0ojhEHe/Jj7gOCSDDh+51NrikrTdytRzS0=
X-Received: by 2002:a9d:362:: with SMTP id 89mr37406316otv.17.1559125002323;
 Wed, 29 May 2019 03:16:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190528163258.260144-1-elver@google.com> <20190528163258.260144-3-elver@google.com>
 <20190528165036.GC28492@lakrids.cambridge.arm.com> <CACT4Y+bV0CczjRWgHQq3kvioLaaKgN+hnYEKCe5wkbdngrm+8g@mail.gmail.com>
 <CANpmjNNtjS3fUoQ_9FQqANYS2wuJZeFRNLZUq-ku=v62GEGTig@mail.gmail.com> <20190529100116.GM2623@hirez.programming.kicks-ass.net>
In-Reply-To: <20190529100116.GM2623@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Wed, 29 May 2019 12:16:31 +0200
Message-ID: <CANpmjNMvwAny54udYCHfBw1+aphrQmiiTJxqDq7q=h+6fvpO4w@mail.gmail.com>
Subject: Re: [PATCH 3/3] asm-generic, x86: Add bitops instrumentation for KASAN
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
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

On Wed, 29 May 2019 at 12:01, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, May 29, 2019 at 11:20:17AM +0200, Marco Elver wrote:
> > For the default, we decided to err on the conservative side for now,
> > since it seems that e.g. x86 operates only on the byte the bit is on.
>
> This is not correct, see for instance set_bit():
>
> static __always_inline void
> set_bit(long nr, volatile unsigned long *addr)
> {
>         if (IS_IMMEDIATE(nr)) {
>                 asm volatile(LOCK_PREFIX "orb %1,%0"
>                         : CONST_MASK_ADDR(nr, addr)
>                         : "iq" ((u8)CONST_MASK(nr))
>                         : "memory");
>         } else {
>                 asm volatile(LOCK_PREFIX __ASM_SIZE(bts) " %1,%0"
>                         : : RLONG_ADDR(addr), "Ir" (nr) : "memory");
>         }
> }
>
> That results in:
>
>         LOCK BTSQ nr, (addr)
>
> when @nr is not an immediate.

Thanks for the clarification. Given that arm64 already instruments
bitops access to whole words, and x86 may also do so for some bitops,
it seems fine to instrument word-sized accesses by default. Is that
reasonable?
