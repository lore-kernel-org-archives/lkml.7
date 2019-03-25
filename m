Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F115C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28C7B20863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730679AbfCYKZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:25:53 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45552 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730491AbfCYKZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:25:52 -0400
Received: by mail-qt1-f195.google.com with SMTP id v20so9505308qtv.12;
        Mon, 25 Mar 2019 03:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uptj+eh0cd0E1jTQT2RebCWvCgUIjjYNwZDO+zjMQlo=;
        b=lUqOnEdOCoIcOKuT1HF4j/lsylMmEVt9nPiJFmiV1Y/7JRwPpD/l6qTbytC9TkmcLE
         BxWDgSMnpyIi3NsJ+G7VQTr26hppthKdT1NFaY//cet2wrGTAjF54YrMYbrYMVDMkZTI
         hZOo2Kuy9gYLzoAxFIIQx+cFGuYvqYDH+z/Tp1Oz6ZR3APcS8P3Cl4SHgQuETiXoiq5l
         ZHnBIz4cWofml2Ah1uC0+8anEi9VC0QfMR5p68ZHQomhGWMjLTtcVydjKj7mLbX1LZap
         7zVTsC7PTgNp2kGZHRFXsHMMMdxkveZ9iU7GzvRIuRpY9Z6BfANaNFo2FiZ8DmF8HynT
         bOPg==
X-Gm-Message-State: APjAAAXhYCm9kAo55Uf+i+sUPvZlbDQT8IfSnkhX9GS9UBgQBTP40kZz
        V9taWvfBJeUx1SraM3nPE9/2gOnnHeFCvIaQQo4=
X-Google-Smtp-Source: APXvYqzGC36CS17RsbRIMSM2NUx4KUTTuXGfJCXxY4s1a67ibbIU6+K0CM3qgDFINgtkxQIR4biGlim06jrN/EGtVB0=
X-Received: by 2002:ac8:2692:: with SMTP id 18mr19682479qto.343.1553509551667;
 Mon, 25 Mar 2019 03:25:51 -0700 (PDT)
MIME-Version: 1.0
References: <1553062828-27798-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK8P3a3BG_mxYxxCx4S_+ZKAer_+5FpmkzLk0VrACZekuD=2GQ@mail.gmail.com>
 <CAK8P3a0GEYTbw5XCwzVeZe_-pGF=7e=1kXhH3U+fidnMZeP0CA@mail.gmail.com>
 <CAK7LNAQvvCVsQtd9ZYkechOSCg4HAeZFaNXCgaBbWWxBYXOgaQ@mail.gmail.com>
 <CAK8P3a1P812avY8reSSguYB0jPzgjs+30dSJpKZCnWwzyLoSVQ@mail.gmail.com> <CAK7LNARatcRQ2u0JhiZHx4qU+mzS=SUv-kj7F-7-Vx--RFX5tw@mail.gmail.com>
In-Reply-To: <CAK7LNARatcRQ2u0JhiZHx4qU+mzS=SUv-kj7F-7-Vx--RFX5tw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 25 Mar 2019 11:25:33 +0100
Message-ID: <CAK8P3a1QQeK1cBN2O8=p+zceQ7tw-ovYtWq6sBeavDucDWA7Lg@mail.gmail.com>
Subject: Re: [PATCH] compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Dave Hansen <dave@sr71.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-mips@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 8:55 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Mon, Mar 25, 2019 at 4:33 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Mon, Mar 25, 2019 at 7:11 AM Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> > > I do not know why to reproduce it,
> > > but is "__init __noreturn" more sensible than
> > > "__always_inline" here?
> >
> > It's in a header file, so it has to be 'inline'. We could make it
> > static inline __init __noreturn,
>
> Yes, I like 'static inline __init __noreturn'
>
> > but I don't see an advantage over
> > __always_inline there.
>
> __always_inline takes away the compiler's freedom.
>
> I'd like to leave it up to the compiler where possible.

Ok, fair enough.

      Arnd
