Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB68EC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 07:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EAE82083B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 07:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfFUHpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 03:45:00 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35273 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfFUHo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 03:44:59 -0400
Received: by mail-ot1-f68.google.com with SMTP id j19so5452443otq.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 00:44:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jCjaVoKTyPRR78eS0nlxQJdxhx1Fm/kEmVMEp327nwU=;
        b=pXzOCqz/yX1uJSyIzG1B6ekq8FlBG4tBdYXTtmedGEBrrQ+Ox91y7R/ebVaHjuHvu4
         Ssb4R+9q5Beq1dCHyyu1CEYBYKKAn6YlI5dt2dfPo0c2IPKW21jfRFb1JhWdftCqIacW
         kWuCzsO/dLkd8kbLV9r5ilKVWwnvPPAPWQE/mEQRaWPpjc0h8bi/qmnZKPa8usHJ/kSi
         KZkQuaqkjGFt3LwPMh7+uGDj7GYzQrsJwvXNjsx54Gsq4jA9wkgVN5NYLi1MZ2+VVw4h
         1Pd94n/5fMjYArvUaYyJiWLqKDa+tGsNGdklFPXuShW/TWjWp5m1NhpfoQWTkulcvOyf
         Y20Q==
X-Gm-Message-State: APjAAAU/R+arhDHiv/a6hXJEWAlAEdUhzMngLU2EP0FNCszTgysvqj7H
        CUnLl2qspmfoIMmSlFhJ7xdpIzXLbix0Bw4DZI0=
X-Google-Smtp-Source: APXvYqyiXaZZrxUSiFqnv2LX1/K2WincSSLALOTvnJFwWkSwZhsmv9FWSuxx/pw/7sQzFXNQl9KWgKF2Lg1rvdvWq1c=
X-Received: by 2002:a05:6830:12c7:: with SMTP id a7mr8978645otq.284.1561103098787;
 Fri, 21 Jun 2019 00:44:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190621071342.17897-1-malat@debian.org> <CACPK8XcJgtCHqrHuNe6f2eLDKWvHRP-uEq1ozOdEnsmED-KL2Q@mail.gmail.com>
In-Reply-To: <CACPK8XcJgtCHqrHuNe6f2eLDKWvHRP-uEq1ozOdEnsmED-KL2Q@mail.gmail.com>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Fri, 21 Jun 2019 09:44:47 +0200
Message-ID: <CA+7wUsxW1D3k+Vfe_sh9816jQLutd0K2QRTesRtKkCBwwWax2g@mail.gmail.com>
Subject: Re: [PATCH] crypto: Fix build for clang
To:     Joel Stanley <joel@jms.id.au>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joel,

On Fri, Jun 21, 2019 at 9:30 AM Joel Stanley <joel@jms.id.au> wrote:
>
> On Fri, 21 Jun 2019 at 07:13, Mathieu Malaterre <malat@debian.org> wrote:
> >
> > The header file `longlong.h` makes uses of GNU extensions, this trigger
> > an error when compiling this code with clang. Add a special flag to make
> > clang tolerate this syntax.
>
> Another old copy of longlong.h in the kernel!
>
> This looks similar to another clang related warnings I fixed in the
> powerpc math-emu code. There's an updated version of these macros in
> GCC, and we updated the kernel version to match the GCC version. Can
> you see if a similar change would work here?
>
> https://lore.kernel.org/linuxppc-dev/43BCRQ6ZqDz9s55@ozlabs.org/
> https://git.kernel.org/torvalds/c/b682c8692442711684befe413cf93cf01c5324ea

Great ! Thanks for the pointer. Looks like a much bettter solution in
the long term. Will try asap.

> Cheers,
>
> Joel
>
> >
> > Silence the following warnings triggered using W=1:
> >
> >     CC      lib/mpi/generic_mpih-mul1.o
> >   ../lib/mpi/generic_mpih-mul1.c:37:13: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with
> >         -fheinous-gnu-extensions
> >                   umul_ppmm(prod_high, prod_low, s1_ptr[j], s2_limb);
> >                   ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   ../lib/mpi/longlong.h:824:20: note: expanded from macro 'umul_ppmm'
> >           : "=r" ((USItype) ph) \
> >                   ~~~~~~~~~~^~
> >
> > and
> >
> >     CC      lib/mpi/generic_mpih-mul2.o
> >   ../lib/mpi/generic_mpih-mul2.c:36:13: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with
> >         -fheinous-gnu-extensions
> >                   umul_ppmm(prod_high, prod_low, s1_ptr[j], s2_limb);
> >                   ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   ../lib/mpi/longlong.h:824:20: note: expanded from macro 'umul_ppmm'
> >           : "=r" ((USItype) ph) \
> >                   ~~~~~~~~~~^~
> >
> >   1 warning generated.
> >     CC      lib/mpi/generic_mpih-mul3.o
> >   ../lib/mpi/generic_mpih-mul3.c:36:13: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with
> >         -fheinous-gnu-extensions
> >                   umul_ppmm(prod_high, prod_low, s1_ptr[j], s2_limb);
> >                   ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   ../lib/mpi/longlong.h:824:20: note: expanded from macro 'umul_ppmm'
> >           : "=r" ((USItype) ph) \
> >                   ~~~~~~~~~~^~
> >
> > Or even:
> >
> >   ../lib/mpi/mpih-div.c:99:16: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
> >                                   sub_ddmmss(n1, n0, n1, n0, d1, d0);
> >                                   ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
> >
> > Cc: Joel Stanley <joel@jms.id.au>
> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Signed-off-by: Mathieu Malaterre <malat@debian.org>
> > ---
> >  lib/mpi/Makefile | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/lib/mpi/Makefile b/lib/mpi/Makefile
> > index d5874a7f5ff9..de4d96e988a3 100644
> > --- a/lib/mpi/Makefile
> > +++ b/lib/mpi/Makefile
> > @@ -5,6 +5,13 @@
> >
> >  obj-$(CONFIG_MPILIB) = mpi.o
> >
> > +ifdef CONFIG_CC_IS_CLANG
> > +CFLAGS_generic_mpih-mul1.o  += -fheinous-gnu-extensions
> > +CFLAGS_generic_mpih-mul2.o  += -fheinous-gnu-extensions
> > +CFLAGS_generic_mpih-mul3.o  += -fheinous-gnu-extensions
> > +CFLAGS_mpih-div.o  += -fheinous-gnu-extensions
> > +endif
> > +
> >  mpi-y = \
> >         generic_mpih-lshift.o           \
> >         generic_mpih-mul1.o             \
> > --
> > 2.20.1
> >
