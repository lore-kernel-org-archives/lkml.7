Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618C0C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 07:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12035208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 07:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="PBP5wU9t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfFUHaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 03:30:02 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45110 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfFUHaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 03:30:02 -0400
Received: by mail-qk1-f194.google.com with SMTP id s22so3718637qkj.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 00:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WkEaRfmJ2lxB4cHAZsrZusAKPE5Z2Z71MkZUO31Jx1E=;
        b=PBP5wU9tISPGu63i2R9PbxfTJtcQFFou7Ba8+cA4XCF0cCZw0gPKoZMDS+pFGeC9X1
         EkS5TJRYu13Jv8LU8D3BtRk6eFaLYrM9fmePkuo6gL3pGWztZRoVh5lhYCitvaoYqgKT
         JebB4ZRbWfOwWfVfHetepvBktv8YN5n1VqX24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WkEaRfmJ2lxB4cHAZsrZusAKPE5Z2Z71MkZUO31Jx1E=;
        b=Kh9hFfbObVRMS3iuhRqBPdCnW6wsomiLCTY71bh1sKa1dS4BqbqO5CnEOiic4km7hA
         eKqgDdoYBW3qAhLxQf+QFdGf8UPpwqNjACD3tjg3xW7aXdtIX8GwQLOXKfcyGR5rGnpB
         RfRbTIN3t56/nHZvC4UA0Ivam7lZOE7e77GVdldvA5H99pyM18wVjfy0rAWTSKZO5ePL
         LXpyYpnR3JCHIOdfFw7I1clFHG0c0aWJPSDGunsf531yAf1dcG0wnjOcGM2FsMJc6SUy
         38FDpGLd6rNqEC2JNktnmDLt/+xPdJcZYoS8K9hoUnA4HT+fdte0DqrQXT4oG/pVPk9j
         fvBQ==
X-Gm-Message-State: APjAAAUIiH88xC2ORqR18ZFnVkcDCZi3q0iWteQXFs+OBP/JzXRz7RSb
        37Ys/WwuDH0G9+Lap8d6yTHBjVkn0WqUuo4btu4=
X-Google-Smtp-Source: APXvYqxexvdzv8wMFI7/+0MMKKue+8G4GIfPwAZsaxvkV7vkjuQW1Mf3UgQ1yYV0Al23wlw3lNbsU4MWWJOxSLbcjXs=
X-Received: by 2002:a37:b0c6:: with SMTP id z189mr60239543qke.208.1561102200763;
 Fri, 21 Jun 2019 00:30:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190621071342.17897-1-malat@debian.org>
In-Reply-To: <20190621071342.17897-1-malat@debian.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 21 Jun 2019 07:29:48 +0000
Message-ID: <CACPK8XcJgtCHqrHuNe6f2eLDKWvHRP-uEq1ozOdEnsmED-KL2Q@mail.gmail.com>
Subject: Re: [PATCH] crypto: Fix build for clang
To:     Mathieu Malaterre <malat@debian.org>
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

On Fri, 21 Jun 2019 at 07:13, Mathieu Malaterre <malat@debian.org> wrote:
>
> The header file `longlong.h` makes uses of GNU extensions, this trigger
> an error when compiling this code with clang. Add a special flag to make
> clang tolerate this syntax.

Another old copy of longlong.h in the kernel!

This looks similar to another clang related warnings I fixed in the
powerpc math-emu code. There's an updated version of these macros in
GCC, and we updated the kernel version to match the GCC version. Can
you see if a similar change would work here?

https://lore.kernel.org/linuxppc-dev/43BCRQ6ZqDz9s55@ozlabs.org/
https://git.kernel.org/torvalds/c/b682c8692442711684befe413cf93cf01c5324ea

Cheers,

Joel

>
> Silence the following warnings triggered using W=1:
>
>     CC      lib/mpi/generic_mpih-mul1.o
>   ../lib/mpi/generic_mpih-mul1.c:37:13: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with
>         -fheinous-gnu-extensions
>                   umul_ppmm(prod_high, prod_low, s1_ptr[j], s2_limb);
>                   ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   ../lib/mpi/longlong.h:824:20: note: expanded from macro 'umul_ppmm'
>           : "=r" ((USItype) ph) \
>                   ~~~~~~~~~~^~
>
> and
>
>     CC      lib/mpi/generic_mpih-mul2.o
>   ../lib/mpi/generic_mpih-mul2.c:36:13: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with
>         -fheinous-gnu-extensions
>                   umul_ppmm(prod_high, prod_low, s1_ptr[j], s2_limb);
>                   ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   ../lib/mpi/longlong.h:824:20: note: expanded from macro 'umul_ppmm'
>           : "=r" ((USItype) ph) \
>                   ~~~~~~~~~~^~
>
>   1 warning generated.
>     CC      lib/mpi/generic_mpih-mul3.o
>   ../lib/mpi/generic_mpih-mul3.c:36:13: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with
>         -fheinous-gnu-extensions
>                   umul_ppmm(prod_high, prod_low, s1_ptr[j], s2_limb);
>                   ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   ../lib/mpi/longlong.h:824:20: note: expanded from macro 'umul_ppmm'
>           : "=r" ((USItype) ph) \
>                   ~~~~~~~~~~^~
>
> Or even:
>
>   ../lib/mpi/mpih-div.c:99:16: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
>                                   sub_ddmmss(n1, n0, n1, n0, d1, d0);
>                                   ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  lib/mpi/Makefile | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/lib/mpi/Makefile b/lib/mpi/Makefile
> index d5874a7f5ff9..de4d96e988a3 100644
> --- a/lib/mpi/Makefile
> +++ b/lib/mpi/Makefile
> @@ -5,6 +5,13 @@
>
>  obj-$(CONFIG_MPILIB) = mpi.o
>
> +ifdef CONFIG_CC_IS_CLANG
> +CFLAGS_generic_mpih-mul1.o  += -fheinous-gnu-extensions
> +CFLAGS_generic_mpih-mul2.o  += -fheinous-gnu-extensions
> +CFLAGS_generic_mpih-mul3.o  += -fheinous-gnu-extensions
> +CFLAGS_mpih-div.o  += -fheinous-gnu-extensions
> +endif
> +
>  mpi-y = \
>         generic_mpih-lshift.o           \
>         generic_mpih-mul1.o             \
> --
> 2.20.1
>
