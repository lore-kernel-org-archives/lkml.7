Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EC2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4642221019
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nz6JrS0P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfCMRWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 13:22:00 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38687 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfCMRV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 13:21:59 -0400
Received: by mail-pf1-f193.google.com with SMTP id n125so1845973pfn.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 10:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EVzpsJPsLWWRe8SdNEk77QGx3gE296uGMKc5cAQJywM=;
        b=nz6JrS0PyR7mFqq2muQhn+E3oJy1ht9B4c8IKQbojqVUKaQd4agTplM3m9BUIssxJ2
         +Mm7vJXmwwIRGsFcr65DwSf871v2R3LUwtsMsV7iRf2/tHGxgOJ2ntSJ+78BNhW6zz/4
         4CGynfJXXXTjzlBnr04QFDnKz36A5svRFQtvlw4kw5qqOOPCkYoKdTeoSu1bkCwvwMM1
         j9nh3+lx5pFO2WQfYpMuXqAw5bz1RLIY0h+r+efzWeSYD6I4F4f7Z6jF42CKq2Vp4f5o
         fHGHsod9KjLaEH6Ld50foFT1jdnqr0xtPfTaQBwOgSyHiwlJh0x2v+aRqMVqGDgvERBw
         X7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EVzpsJPsLWWRe8SdNEk77QGx3gE296uGMKc5cAQJywM=;
        b=Xbjk+OLUDlLCPkOHua9UF6wNBcLc377aMjUhAi77O31aeKmWAAXbmqIhIwSeEmNmcs
         w+seAk93c2XM84UkaawvxhZnGN+ab/PBCPzrMtPiPbRwML5xMMO9cOqgGTG/ncswHRWb
         yO//+OaS13qFWOSR8MzIkWGGzJvkOAfCQlks5mdk/JSACgkraVh5uW83+yWFavTPLbVa
         UnOtrCz2vmrbfHyu5eTUtzDdkmX+ODEAQkFLD336JaTDiOLTwOJ2JWOPIcwd/8+WNqbT
         yPOBy3KL9HoMqokIW7KVrWFIq67iAUXLkrUK5XmwdGjxci5FLIzPyX95NcBnI/qWfxkb
         pWmg==
X-Gm-Message-State: APjAAAUrmNlQ3B9eVbXFgDMd3OQzCzU09fO4rPQCKsUPTi4dEhZD+Kqv
        mK1M9LaC+YVKQmxn43fSooPLax9CS/sRuf4nYBCS6g==
X-Google-Smtp-Source: APXvYqx08CF7ho8zm3L2vL8drddu/W9Qnbk7vX5lOKgEPRp0gY9UKvqVA4+3rZdqAs4PJ9ofIijw6aanQpmyneBtMzg=
X-Received: by 2002:a17:902:380c:: with SMTP id l12mr34998528plc.238.1552497718394;
 Wed, 13 Mar 2019 10:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190312215203.27643-1-natechancellor@gmail.com>
 <80fb5b7f-42f9-4fd1-00cf-bfa7965ff8f7@rasmusvillemoes.dk> <20190313134447.GA19066@archlinux-ryzen>
 <CAK8P3a344k=MDAX-d21U4+H+mv7Vcd9YhAN4NPEJm1CXv76tkw@mail.gmail.com> <20190313153209.GA14098@archlinux-ryzen>
In-Reply-To: <20190313153209.GA14098@archlinux-ryzen>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 13 Mar 2019 10:21:47 -0700
Message-ID: <CAKwvOd=UYEtQC9T2K=O0rxrDKug4XzsA6dHjSKmogFa7whE7Zw@mail.gmail.com>
Subject: Re: [PATCH] Makefile: Add '-fno-builtin-bcmp' to CLANG_FLAGS
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
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

On Wed, Mar 13, 2019 at 8:32 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Wed, Mar 13, 2019 at 02:48:49PM +0100, Arnd Bergmann wrote:
> > On Wed, Mar 13, 2019 at 2:44 PM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > > On Wed, Mar 13, 2019 at 09:13:11AM +0100, Rasmus Villemoes wrote:
> > > > Wouldn't it be better to just define bcmp as an alias for memcmp? They
> > > > seem to have compatible prototypes, and then somebody might someday sit
> > > > down and implement some word-at-a-time version of bcmp making use of the
> > > > weaker guarantees about the return value to gain some performance. But I
> > > > suppose that can also be done later.
> > >
> > > Thank you much for the review, I didn't even realize this was possible :)
> > >
> > > I'd certainly like to explore it as that is what glibc does. How would
> > > you suggest going about it here?
> >
> > I suggested a possible implementation (likely contains bugs) and
> > an alias for architectures that require strict alignment, see
> > https://bugs.llvm.org/show_bug.cgi?id=41035#c11
> >
> > We could start out with just the alias.
> >
> >        Arnd
>
> So I've been messing around with this for a bit (forgive me, I'm still
> learning all of the intricacies around here) and this is what I came up
> with for when __ARCH_HAVE_MEMCMP is unset (not particularly difficult
> obviously). I can compile, link, and boot an x86 in QEMU.
>
> However, I am not sure how to handle memcmp definitions that are written
> in assembly like arm64, as the alias attribute only works when the alias
> is defined in the same translation unit. Thoughts?

I hit this, too:
./arch/arm64/include/asm/string.h:40:15: error: alias must point to a
defined variable
      or function

since memcmp is only declared (not defined) in that header, clang is
not happy to alias to memcmp.  If __HAVE_ARCH_MEMCMP is defined, then
we can just return a call to memcmp.  Thoughts (I need to add comments
above bcmp, anything else)?  Do we like the typeof trick (stolen from
glibc) or no?

diff --git a/lib/string.c b/lib/string.c
index 38e4ca08e757..e6c1954f2716 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -845,7 +845,13 @@ void *memmove(void *dest, const void *src, size_t count)
 EXPORT_SYMBOL(memmove);
 #endif

-#ifndef __HAVE_ARCH_MEMCMP
+#ifdef __HAVE_ARCH_MEMCMP
+int bcmp(const void *cs, const void *ct, size_t n)
+{
+       return memcmp(cs, ct, n);
+}
+EXPORT_SYMBOL(bcmp);
+#else
 /**
  * memcmp - Compare two areas of memory
  * @cs: One area of memory
@@ -864,6 +870,8 @@ __visible int memcmp(const void *cs, const void
*ct, size_t count)
        return res;
 }
 EXPORT_SYMBOL(memcmp);
+__weak __alias(memcmp) typeof(memcmp) bcmp;
+EXPORT_SYMBOL(bcmp);
 #endif

 #ifndef __HAVE_ARCH_MEMSCAN


-- 
Thanks,
~Nick Desaulniers
