Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30517C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D61420657
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfCMTjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:39:12 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40191 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfCMTjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:39:11 -0400
Received: by mail-qt1-f196.google.com with SMTP id f11so3354235qti.7;
        Wed, 13 Mar 2019 12:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A7JQr0JGaN+W0Q7mnIiCjoAyiLQ/UjVlHc6QOtDTbWE=;
        b=r3X8QZrwO2ewL1p+aBUG16q6bm1ixsnaOpsDGpjoRWHV+FhgaUMYJcT55A/PM9AlXI
         DiIsQsS6dje/Jvj0KP5LpMzwdFKjLK5Ax1OuSpSa5O8Df5UB/8gaBn01hN2dsljlEdxB
         l5nN2fNmUPgpDI8RjfCOa6lGDbhDKeA+m6IHzgroM4ziETHVVTsljlkhc/ihLtTBa7pT
         s9f0BAuOR+mMQ4EHMQX7SIU27yAcVMsVvDjeSHYiLLzBbq2Fau0T7JpgXkZopvRU/s1n
         5pKgLx1UleVxvsTp3Kj1h3Fb6wbZDbzQxIenRHMaT7RvXw+K+xuu9h479ehSVIfF2RC2
         zO9Q==
X-Gm-Message-State: APjAAAW0n06Bx4ZRtwJjDLCl6Mt2qxkVRR47XbSja2IVT28tzkrn/c1J
        hw17sjvyWB+qIK+NnXS5bzEnmYfUVg2Qe4OHy40=
X-Google-Smtp-Source: APXvYqz3VRkPyb12xYl1BRqEkYYVIZuOmds6oK6s9qBbcXE87jZKdT80tIsqMtX9XKF9OYlHMfT5/t3nc6le2t1I2co=
X-Received: by 2002:a0c:b501:: with SMTP id d1mr36375592qve.115.1552505950419;
 Wed, 13 Mar 2019 12:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190312215203.27643-1-natechancellor@gmail.com>
 <80fb5b7f-42f9-4fd1-00cf-bfa7965ff8f7@rasmusvillemoes.dk> <20190313134447.GA19066@archlinux-ryzen>
 <CAK8P3a344k=MDAX-d21U4+H+mv7Vcd9YhAN4NPEJm1CXv76tkw@mail.gmail.com>
 <20190313153209.GA14098@archlinux-ryzen> <CAKwvOd=UYEtQC9T2K=O0rxrDKug4XzsA6dHjSKmogFa7whE7Zw@mail.gmail.com>
 <CAKwvOd=8rAZi3ZT8qEupmS6xY2U10cKT7kPtB=gYfWsJEJ0GSQ@mail.gmail.com>
In-Reply-To: <CAKwvOd=8rAZi3ZT8qEupmS6xY2U10cKT7kPtB=gYfWsJEJ0GSQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 13 Mar 2019 20:38:52 +0100
Message-ID: <CAK8P3a206PXqaqv-B=S-4+sP04y5ZFkuP4XoN0bQNxrx56asKg@mail.gmail.com>
Subject: Re: [PATCH] Makefile: Add '-fno-builtin-bcmp' to CLANG_FLAGS
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        James Y Knight <jyknight@google.com>,
        clang-built-linux@googlegroups.com,
        "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 6:27 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:

> > diff --git a/lib/string.c b/lib/string.c
> > index 38e4ca08e757..e6c1954f2716 100644
> > --- a/lib/string.c
> > +++ b/lib/string.c
> > @@ -845,7 +845,13 @@ void *memmove(void *dest, const void *src, size_t count)
> >  EXPORT_SYMBOL(memmove);
> >  #endif
> >
> > -#ifndef __HAVE_ARCH_MEMCMP
> > +#ifdef __HAVE_ARCH_MEMCMP
> > +int bcmp(const void *cs, const void *ct, size_t n)
> > +{
> > +       return memcmp(cs, ct, n);
> > +}
> > +EXPORT_SYMBOL(bcmp);
> > +#else
> >  /**
> >   * memcmp - Compare two areas of memory
> >   * @cs: One area of memory
> > @@ -864,6 +870,8 @@ __visible int memcmp(const void *cs, const void
> > *ct, size_t count)
> >         return res;
> >  }
> >  EXPORT_SYMBOL(memcmp);
> > +__weak __alias(memcmp) typeof(memcmp) bcmp;
> > +EXPORT_SYMBOL(bcmp);
> >  #endif
> >
> >  #ifndef __HAVE_ARCH_MEMSCAN
>
> Alternatively, just not worrying about __alias makes this simpler and
> seems to work (need to add comments, thoughts?):

Either way seems fine to me. If we don't plan to provide an
optimized version, I'd go with the simpler definition rather than
the alias.

       Arnd
