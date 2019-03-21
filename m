Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC342C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6960721902
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F9TL621M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbfCURCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 13:02:49 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44150 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfCURCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 13:02:49 -0400
Received: by mail-pg1-f193.google.com with SMTP id i2so4595533pgj.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 10:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8FvlX1Vi7LFnY+PSbgCPmyrwV7mTvsGmDb329diW3Iw=;
        b=F9TL621Mlh4kA0pgnVP7WfKx6x9VFVvcyUsclgQhlbx2pf/oXGBSGzllTlSs8mFELc
         QbGw8clMTXg8lcO04J9PQ42miLlsT9b9I+BuuqvX7FgAMOXlvIPLQ8Oyr2y+5NfYr1iw
         WQcxbiDN3mX567wFXvkqI+fPzDsva1n7x5Swu8J6BTp4uo2eNtsOeMGo5AYLWELoglxF
         WpsILtwv1xeB8VNjlKQABYgBrMtWl5Yk2m1YWhf+WWYGFLD2MOmwWeC1ll2sbdyATuE6
         rOfe9gb89WY8pt2cOFH2ei4HHlKRenNiP5acxLDsGOTZ3Lo1pFGey7E4B5Xc5lXG1Jtq
         irmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8FvlX1Vi7LFnY+PSbgCPmyrwV7mTvsGmDb329diW3Iw=;
        b=jk9c2CDMPoxK4hWXfH/wQdW77Z5IO25ybrMpjZL1L3kbm6G5fJKs0yV4F9vw+MgH8r
         3dQORwvEuXDSvrnedBaOtlsQvxBAV10YChwC176Pfnv1MzKjJGw00mRaPm/WI/nsRzGX
         uLvV+x4/ZGqXHFfi60urYS5bWam0GTFuYjCYBR/3hejTBtU5IbXFCMzWdxhyyv8jS24F
         u0lRITTaUePmwJjn9LAiEQSa37/nNC2YSV1vEp6pB5xsUaCLiO290/fwEUIhwqrJzu9c
         dPdy1jjzQJWjguNwMjacnPIxh6Oq/2oE8I/JSpW7DIOxngNoJ5djbPXo3l6v78Tvnv8b
         WXuQ==
X-Gm-Message-State: APjAAAXy7+ODy7qvmobrKsdq9cYuWdeZUcg5ib7ssXNdhrUyE6yk5MCa
        zp9x9XCZSJ6p1/zVeZLUDXx/5VAMNe5w8eWj274GCg==
X-Google-Smtp-Source: APXvYqzpN6TDP6yHGP6IR5Pa0WXGNiHBBu89LV58BDSjVxC/GYjxJ4p+Dy7j0w5BydQkbLexcmSySRo/rjwcAMYPAgE=
X-Received: by 2002:a63:f544:: with SMTP id e4mr4297929pgk.145.1553187768232;
 Thu, 21 Mar 2019 10:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <7549EE7E-4172-467D-815A-63664A33D410@goodmis.org>
 <20190313211335.165605-1-ndesaulniers@google.com> <20190320191135.e49e976a8258c8ac0bb428c9@linux-foundation.org>
In-Reply-To: <20190320191135.e49e976a8258c8ac0bb428c9@linux-foundation.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 21 Mar 2019 10:02:37 -0700
Message-ID: <CAKwvOdn84HNEB3u4XO-V_+c=txmDd1061G_7K0zZVS4MfF--Lg@mail.gmail.com>
Subject: Re: [PATCH v4] lib/string.c: implement a basic bcmp
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     clang-built-linux@googlegroups.com,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        James Y Knight <jyknight@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 7:11 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 13 Mar 2019 14:13:31 -0700 Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> > A recent optimization in Clang (r355672) lowers comparisons of the
> > return value of memcmp against zero to comparisons of the return value
> > of bcmp against zero.  This helps some platforms that implement bcmp
> > more efficiently than memcmp. glibc simply aliases bcmp to memcmp, but
> > an optimized implementation is in the works.
> >
> > This results in linkage failures for all targets with Clang due to the
> > undefined symbol.  For now, just implement bcmp as a tailcail to memcmp
> > to unbreak the build.  This routine can be further optimized in the
> > future.
> >
> > Other ideas discussed:
> > * A weak alias was discussed, but breaks for architectures that define
> > their own implementations of memcmp since aliases to declarations are
> > not permitted (only definitions).  Arch-specific memcmp implementations
> > typically declare memcmp in C headers, but implement them in assembly.
> > * -ffreestanding also is used sporadically throughout the kernel.
> > * -fno-builtin-bcmp doesn't work when doing LTO.
>
> I guess we should backport this into -stable so that older kernels can
> be built with newer Clang.

Ah, you're right.  I always forget.  Is it too late to add

Cc: stable@vger.kernel.org

to the patch in your tree?

>
> > ...
> >
> > --- a/lib/string.c
> > +++ b/lib/string.c
> > @@ -866,6 +866,26 @@ __visible int memcmp(const void *cs, const void *ct, size_t count)
> >  EXPORT_SYMBOL(memcmp);
> >  #endif
> >
> > +#ifndef __HAVE_ARCH_BCMP
> > +/**
> > + * bcmp - returns 0 if and only if the buffers have identical contents.
> > + * @a: pointer to first buffer.
> > + * @b: pointer to second buffer.
> > + * @len: size of buffers.
> > + *
> > + * The sign or magnitude of a non-zero return value has no particular
> > + * meaning, and architectures may implement their own more efficient bcmp(). So
> > + * while this particular implementation is a simple (tail) call to memcmp, do
> > + * not rely on anything but whether the return value is zero or non-zero.
> > + */
> > +#undef bcmp
>
> What is the undef for?

Used the same convention as memcpy.  Looking at the rest of the
translation unit, I see that there's a mix of functions that do or do
not undef their symbol.  Rasmus pointed out that memcpy is implemented
as a macro for x86 (arch/x86/include/asm/string_32.h).  But looking
closer now, I suspect it's not needed (anyone declaring memcmp as a
macro should be setting __HAVE_ARCH_MEMCMP).

Shall I send you a cleanup removing the undefs for bcmp, memcmp,
strcat, strcpy, and strcmp?  Of those, I only see memcmp being
`#defined` in arch/m68k/include/asm/string.h, arch/x86/boot/string.h,
and arch/x86/include/asm/string_32.h.

Further, I can drop some of the __GNUC__ < 4 code in
arch/x86/include/asm/string_32.h. (grepping for __GNUC__, looks like
there's a fair amount of code that can be cleaned up).  We should
probably check it since Clang lies about being GCC 4.2 compatible,
which will surely break in horrific ways at some point.

-- 
Thanks,
~Nick Desaulniers
