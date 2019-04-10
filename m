Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60730C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E8F206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kRkY43id"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732643AbfDJQfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:35:16 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37999 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731740AbfDJQfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:35:15 -0400
Received: by mail-pl1-f193.google.com with SMTP id f36so1758490plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 09:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DvkoIOHYmOjjYe/DVRnxS6aDlA+Kc2YrCvjKr2JO37s=;
        b=kRkY43idbGpEqF3rB0mFL+JPjFVyr1TDFFtc9qQNHHLdpruN2CidZ8NsSoEQQPOtKF
         2e+GsL/EF6zdlk3fp4KcFuA0Z1Ajx/HGaYZO5RI3PYi2xu36VZyjQVW1KzLruix2yxPk
         3aOoP+6UQbuL9MLasCHK13NP8CN01s4FUMjyWUQngPUVG6jGRZgkpvxDylILERV/3IQh
         wQl8VzkIjGUZFFnKpQRNAv9D+dj2jxZlwBZXrtW1EH46O8M6EeT1U2ZboiAg3VELdqOU
         kj+aogE/n1fjuKfh8wr+m5ll1J0fmR54l0Gzsalo57fZm3H2f7gCAE4wEfVXO068tsCY
         BkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DvkoIOHYmOjjYe/DVRnxS6aDlA+Kc2YrCvjKr2JO37s=;
        b=V3fXZsCfebJCGe+Qd0bepci+QEaz77Qfx44b3YeT84zXjS9bfYe9tmLD5NFtxohLRX
         I3pM2qXEsFijuUi90wIJit04eLHdajT/NO2gZsKxedQZmPbFgFNDgFWMwjFAdYM0Wn+g
         oc7K6DDKH9IJ5tLkIhGh2iQV93TX7PB392mG/WCBrmzwUSnMmY7qYOFK04tccILe4L7F
         dcSfM+iqFddJWtz+3S/Yl5QWNGj/mniPTgCfX5ly4DjQAzm12itXoSE7bCW/mnd/NYDf
         8jfF3jXJ5lFbCFit5dJ2YGNJCW/BbtgbCGLS5mHUfKisxDm2fhFs9v/3A4kFoFTYfn6R
         wJ/w==
X-Gm-Message-State: APjAAAXpFtwJ+PhYuhhclhexK9xs643zD3gCHZudCRaiFzW0u1baqx5r
        8Qapbxw4tgAXFxVjl0zBMKmn84liwju/DPdjQ7wuww==
X-Google-Smtp-Source: APXvYqx1uvjiGKIXmyVKCQs/UGt6qcu+3hcSvcSEaOo8ka1SRQr5KqUoLap5gCRovdtxcp7VEU5smMwH9brBFjuPZbk=
X-Received: by 2002:a17:902:31a4:: with SMTP id x33mr45175197plb.24.1554914114047;
 Wed, 10 Apr 2019 09:35:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190408212648.2407234-1-arnd@arndb.de> <20190408212648.2407234-12-arnd@arndb.de>
 <20190410155513.1609f1a1@mschwideX1>
In-Reply-To: <20190410155513.1609f1a1@mschwideX1>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 10 Apr 2019 09:35:02 -0700
Message-ID: <CAKwvOdkgogaC9mmg1J4W3tXwCzfwP15NZNVUGvPeBqrDwx0wUg@mail.gmail.com>
Subject: Re: [PATCH 12/12] [PROBABLY WRONG] s390: void '0' constraint in
 inline assembly
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 6:55 AM Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
>
> On Mon,  8 Apr 2019 23:26:25 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
>
> > clang does not understand the contraint "0" in the CALL_ON_STACK()
> > macro:
> >
> > ../arch/s390/mm/maccess.c:117:10: error: invalid input constraint '0' in asm
> >                 return CALL_ON_STACK(_memcpy_real, S390_lowcore.nodat_stack,
> >                        ^
> > ../arch/s390/include/asm/processor.h:292:20: note: expanded from macro 'CALL_ON_STACK'
> >                   [_fn] "X" (fn) CALL_FMT_##nr : CALL_CLOBBER_##nr);    \
> >                                  ^
> > <scratch space>:207:1: note: expanded from here
> > CALL_FMT_3
> > ^
> > ../arch/s390/include/asm/processor.h:267:20: note: expanded from macro 'CALL_FMT_3'
> >  #define CALL_FMT_3 CALL_FMT_2, "d" (r4)
> >                    ^
> > ../arch/s390/include/asm/processor.h:266:20: note: expanded from macro 'CALL_FMT_2'
> >  #define CALL_FMT_2 CALL_FMT_1, "d" (r3)
> >                    ^
> > ../arch/s390/include/asm/processor.h:265:32: note: expanded from macro 'CALL_FMT_1'
> >  #define CALL_FMT_1 CALL_FMT_0, "0" (r2)
> >                                ^
> >
> > I don't know what the correct fix here would be, changing it to "d" made
> > it build, since clang does understand this one.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  arch/s390/include/asm/processor.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
> > index 700c650ffd4f..84c59c99668a 100644
> > --- a/arch/s390/include/asm/processor.h
> > +++ b/arch/s390/include/asm/processor.h
> > @@ -262,7 +262,7 @@ static __no_kasan_or_inline unsigned short stap(void)
> >       register unsigned long r4 asm("6") = (unsigned long)(arg5)
> >
> >  #define CALL_FMT_0
> > -#define CALL_FMT_1 CALL_FMT_0, "0" (r2)
> > +#define CALL_FMT_1 CALL_FMT_0, "d" (r2)
> >  #define CALL_FMT_2 CALL_FMT_1, "d" (r3)
> >  #define CALL_FMT_3 CALL_FMT_2, "d" (r4)
> >  #define CALL_FMT_4 CALL_FMT_3, "d" (r5)
>
> This is (slightly) wrong. %r2 is used as the input register for the first argument
> and the result value for the call. With your patch you force the compiler to load
> the first argument in two registers. One solution would be to CALL_FMT1 as
>
>         #define CALL_FMT1 CALL_FMT_0
>
> It still is not optimal though as for CALL_FMT_0 the "+&d" (r2) indicates an
> input but CALL_ARGS_0 does not initialize r2.
>
> I am thinking about the following patch to cover all cases:
> --
> From 91a4abbec91a9f26f84f7386f2c0f96de669b0eb Mon Sep 17 00:00:00 2001
> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Date: Wed, 10 Apr 2019 15:48:43 +0200
> Subject: [PATCH] s390: fine-tune stack switch helper

Thanks for the patch. Just some minor typos in the commit.

>
> The CALL_ON_STACK helper currently does not work with clang and for
> calls without arguments it does not initialize r2 although the contraint

- calls without arguments it ...
+ calls without arguments.  It ...

- although the contraint
+ although the constraint

`:set spell` in vim (I wonder if there's a way to set that when
writing commit messages automatically)

> is "+&d". Rework the CALL_FMT_x and the CALL_ON_STACK macros to work
> with clang and produce optimal code in all cases.
>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> ---
>  arch/s390/include/asm/processor.h | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
> index 81038ab357ce..0ee022247580 100644
> --- a/arch/s390/include/asm/processor.h
> +++ b/arch/s390/include/asm/processor.h
> @@ -261,12 +261,12 @@ static __no_kasan_or_inline unsigned short stap(void)
>         CALL_ARGS_4(arg1, arg2, arg3, arg4);                            \
>         register unsigned long r4 asm("6") = (unsigned long)(arg5)
>
> -#define CALL_FMT_0
> -#define CALL_FMT_1 CALL_FMT_0, "0" (r2)
> -#define CALL_FMT_2 CALL_FMT_1, "d" (r3)
> -#define CALL_FMT_3 CALL_FMT_2, "d" (r4)
> -#define CALL_FMT_4 CALL_FMT_3, "d" (r5)
> -#define CALL_FMT_5 CALL_FMT_4, "d" (r6)
> +#define CALL_FMT_0 "=&d" (r2) :
> +#define CALL_FMT_1 "+&d" (r2) :
> +#define CALL_FMT_2 CALL_FMT_1 "d" (r3),
> +#define CALL_FMT_3 CALL_FMT_2 "d" (r4),
> +#define CALL_FMT_4 CALL_FMT_3 "d" (r5),
> +#define CALL_FMT_5 CALL_FMT_4 "d" (r6),
>
>  #define CALL_CLOBBER_5 "0", "1", "14", "cc", "memory"
>  #define CALL_CLOBBER_4 CALL_CLOBBER_5
> @@ -286,10 +286,10 @@ static __no_kasan_or_inline unsigned short stap(void)
>                 "       stg     %[_prev],%[_bc](15)\n"                  \
>                 "       brasl   14,%[_fn]\n"                            \
>                 "       la      15,0(%[_prev])\n"                       \
> -               : "+&d" (r2), [_prev] "=&a" (prev)                      \
> -               : [_stack] "a" (stack),                                 \
> +               : [_prev] "=&a" (prev), CALL_FMT_##nr                   \
> +                 [_stack] "a" (stack),                                 \
>                   [_bc] "i" (offsetof(struct stack_frame, back_chain)), \
> -                 [_fn] "X" (fn) CALL_FMT_##nr : CALL_CLOBBER_##nr);    \
> +                 [_fn] "X" (fn) : CALL_CLOBBER_##nr);                  \
>         r2;                                                             \
>  })
>
> --
> 2.16.4
> --
> blue skies,
>    Martin.
>
> "Reality continues to ruin my life." - Calvin.
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To post to this group, send email to clang-built-linux@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20190410155513.1609f1a1%40mschwideX1.
> For more options, visit https://groups.google.com/d/optout.



-- 
Thanks,
~Nick Desaulniers
