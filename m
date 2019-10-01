Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA26C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 08:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0762521783
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 08:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="cK0920T8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732849AbfJAI3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 04:29:37 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:50112 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfJAI3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 04:29:36 -0400
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x918TUBZ026576
        for <linux-kernel@vger.kernel.org>; Tue, 1 Oct 2019 17:29:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x918TUBZ026576
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1569918571;
        bh=js7jLpstY+bD7D39QxN+sPmHytiad2GlmiLmccMGu30=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cK0920T8vARsG3qEuhifZYpBjDGp97raapPMW4j1gzTD77IUFm3Nijw5ZuSSW62JJ
         ahY4//UPyASJwbwHn4x1XsBLuJQYQPdysT9NWOvG8sJJkrb31ag6jbkUw0394M69pG
         0JASsJCBrxjTED9uj/5OPj8gBpdURJp4qubIw7MSJuv2WGkJP8BtmtqfiVgnQj4/XJ
         Ormfsj/u7Uc82nTGhNxpgRHc6Ygkzd/G4IGVndjD06N52Ato2tTorinlMkbl2aWash
         D1XTGl+IokGWWtb52FJjaPWm+Upl27/Zz/39YdPD5iwjVNCOyjCVhnXKSj7Tp9+6Iw
         V5iBUy7B5IgXQ==
X-Nifty-SrcIP: [209.85.217.46]
Received: by mail-vs1-f46.google.com with SMTP id z14so8720062vsz.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 01:29:31 -0700 (PDT)
X-Gm-Message-State: APjAAAX8vx+zGgsn+aKYyTC9VIuXw4W8uJA5AlmCH2YNL1RJJ5E7mgqp
        rmDjsnC8v2+Q3rDojPdc+PXIHhaqLlllgpMkbWo=
X-Google-Smtp-Source: APXvYqwe3DWk1KyGZe1vQgAdH5a4ChbwR1N6Zj2tLFju2cB5Fx7mHwXpeq18GiAtG3kLmP/cZFU5+5nHhcFG6ellfPM=
X-Received: by 2002:a67:88c9:: with SMTP id k192mr12215131vsd.181.1569918569917;
 Tue, 01 Oct 2019 01:29:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190930055925.25842-1-yamada.masahiro@socionext.com> <CAKwvOdk4VKK-Z0ZRKb0aV9yH=jtqVp0aYaqMaL7dOq7-jaGX4A@mail.gmail.com>
In-Reply-To: <CAKwvOdk4VKK-Z0ZRKb0aV9yH=jtqVp0aYaqMaL7dOq7-jaGX4A@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 1 Oct 2019 17:28:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNARzNNUcHOTrcp7ni4AdQK+qqDsG3fzQO4AkmDrAsFQA9g@mail.gmail.com>
Message-ID: <CAK7LNARzNNUcHOTrcp7ni4AdQK+qqDsG3fzQO4AkmDrAsFQA9g@mail.gmail.com>
Subject: Re: [PATCH] ARM: fix __get_user_check() in case uaccess_* calls are
 not inlined
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Stefan Agner <stefan@agner.ch>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Tue, Oct 1, 2019 at 7:19 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Sun, Sep 29, 2019 at 11:00 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > KernelCI reports that bcm2835_defconfig is no longer booting since
> > commit ac7c3e4ff401 ("compiler: enable CONFIG_OPTIMIZE_INLINING
> > forcibly"):
> >
> >   https://lkml.org/lkml/2019/9/26/825
> >
> > I also received a regression report from Nicolas Saenz Julienne:
> >
> >   https://lkml.org/lkml/2019/9/27/263
> >
> > This problem has cropped up on arch/arm/config/bcm2835_defconfig
> > because it enables CONFIG_CC_OPTIMIZE_FOR_SIZE. The compiler tends
> > to prefer not inlining functions with -Os. I was able to reproduce
> > it with other boards and defconfig files by manually enabling
> > CONFIG_CC_OPTIMIZE_FOR_SIZE.
> >
> > The __get_user_check() specifically uses r0, r1, r2 registers.
>
> Yep, that part is obvious, but...
>
> > So, uaccess_save_and_enable() and uaccess_restore() must be inlined
> > in order to avoid those registers being overwritten in the callees.
>
> Right, r0, r1, r2 are caller saved, meaning that __get_user_check must
> save/restore them when making function calls. So
> uaccess_save_and_enable() and uaccess_restore() should either be made
> into macros (macros and typecheck (see include/linux/typecheck.h) are
> peanut butter and chocolate), or occur at different points in the
> function when those register variables are no longer in use.
>
> >
> > Prior to commit 9012d011660e ("compiler: allow all arches to enable
> > CONFIG_OPTIMIZE_INLINING"), the 'inline' marker was always enough for
> > inlining functions, except on x86.
> >
> > Since that commit, all architectures can enable CONFIG_OPTIMIZE_INLINING.
> > So, __always_inline is now the only guaranteed way of forcible inlining.
> >
> > I want to keep as much compiler's freedom as possible about the inlining
> > decision. So, I changed the function call order instead of adding
> > __always_inline around.
> >
> > Call uaccess_save_and_enable() before assigning the __p ("r0"), and
> > uaccess_restore() after evacuating the __e ("r0").
> >
> > Fixes: 9012d011660e ("compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING")
> > Reported-by: "kernelci.org bot" <bot@kernelci.org>
> > Reported-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> >  arch/arm/include/asm/uaccess.h | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
> > index 303248e5b990..559f252d7e3c 100644
> > --- a/arch/arm/include/asm/uaccess.h
> > +++ b/arch/arm/include/asm/uaccess.h
> > @@ -191,11 +191,12 @@ extern int __get_user_64t_4(void *);
> >  #define __get_user_check(x, p)                                         \
> >         ({                                                              \
> >                 unsigned long __limit = current_thread_info()->addr_limit - 1; \
> > +               unsigned int __ua_flags = uaccess_save_and_enable();    \
> >                 register typeof(*(p)) __user *__p asm("r0") = (p);      \
> >                 register __inttype(x) __r2 asm("r2");                   \
> >                 register unsigned long __l asm("r1") = __limit;         \
> >                 register int __e asm("r0");                             \
>
> What does it mean for there to be two different local variables pinned
> to the same register? Ie. it looks like __e and __p are defined to
> exist in r0.  Would having one variable and an explicit cast result in
> differing storage?

In my understanding,
__p is input (a pointer to the user-space)
__e is output (return value)

Maybe, does it use two variables for clarification?


>
> > -               unsigned int __ua_flags = uaccess_save_and_enable();    \
> > +               unsigned int __err;                                     \
> >                 switch (sizeof(*(__p))) {                               \
> >                 case 1:                                                 \
> >                         if (sizeof((x)) >= 8)                           \
> > @@ -223,9 +224,10 @@ extern int __get_user_64t_4(void *);
> >                         break;                                          \
> >                 default: __e = __get_user_bad(); break;                 \
>
> ^ I think this assignment to __e should be replaced with an assignment
> to __err?  We no longer need the register at this point and could skip
> the assignment of x.

Right, but '__err = __e' is necessary for non-default cases.




-- 
Best Regards
Masahiro Yamada
