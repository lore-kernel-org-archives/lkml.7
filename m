Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F875C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 22:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51B12081B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 22:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QhV0HmO5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731439AbfI3WTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 18:19:21 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46569 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbfI3WTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 18:19:20 -0400
Received: by mail-pl1-f196.google.com with SMTP id q24so4427948plr.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 15:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3oWqyfWTP37SD+PlmYVges0YN8RxVQW6vfcfcw8zHDs=;
        b=QhV0HmO5jThUuDSONZ0Gwfst06GK/Tanlz1FJWN+f/CZoc4LkISoHqY9JE4hw0FxO2
         jC4+tsOfh3HBlM98oTJ9p9UOVH79DzzJa5gUTmKsYr+bbD42dNJuGwEOer03aaUmpaLw
         eoEY23iP1sQUj0A9W6zq2Oo/l/T9Ollwslh4bpuHOkH2NDTTK4NmPGwfkvz0tixLyfpQ
         9I4RmNXA6ZEe1B1kcOrZAyvXu5dzrUONSF2taIHHTGZtSEnSA3bA/38q95WfzCv8gncV
         FcxJ270m3K35a2clJLUZdXxOd9zDP/4IQOoV7c3/ZVJOqMB6Xo9UbRFUUhEjs65NL/8V
         mvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3oWqyfWTP37SD+PlmYVges0YN8RxVQW6vfcfcw8zHDs=;
        b=mLTJifgtYliceFPIv/tTLfMbnPgCV8oNElV2ty3CAdif2gzOiBSTLuJ0mDpOd97mb3
         /jbZkLi5h6+ZkK6JUT9Gmk8jF3JQF/NS8aGem4XaqYo/zfXEhXOzx5Ag18KNYk5utaX+
         8oilhquo2luEmHW0vro7qYBftdF+XDNFtN3CFnD1AWDfK5M+nFj+gAQSinxOEVDVV4cK
         4wDxCnJfsuu6KNgP6a+pHZ0GXpANlk0BcoFsYokj/xq3CVEoBjFqfhwziGZqyrPecikx
         un8t/X+RlERqRjcuSDlYRbXrLSzuAp2himsXCUPOsQA0MtofGcfPXr3SA4kIjjAs9BjN
         OVcg==
X-Gm-Message-State: APjAAAVEYlry3ddWn9R2DgYjahDyMJ/odDpjnYTq9/IIEaGiGrw7wbqL
        K9zF/oGtyJXV2hUmg3btPUk4/dLMu1UWrFEIaZcqrA==
X-Google-Smtp-Source: APXvYqyG+eTU5eoURz3A6I1Oi2WUYBcxtn/xMioYPodkxhQPxLm0cWZlBIGnlKCfDVHIastd7l/4gdZrcllqpZUussM=
X-Received: by 2002:a17:902:820e:: with SMTP id x14mr22386750pln.223.1569881959520;
 Mon, 30 Sep 2019 15:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190930055925.25842-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190930055925.25842-1-yamada.masahiro@socionext.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 30 Sep 2019 15:19:08 -0700
Message-ID: <CAKwvOdk4VKK-Z0ZRKb0aV9yH=jtqVp0aYaqMaL7dOq7-jaGX4A@mail.gmail.com>
Subject: Re: [PATCH] ARM: fix __get_user_check() in case uaccess_* calls are
 not inlined
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
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

On Sun, Sep 29, 2019 at 11:00 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> KernelCI reports that bcm2835_defconfig is no longer booting since
> commit ac7c3e4ff401 ("compiler: enable CONFIG_OPTIMIZE_INLINING
> forcibly"):
>
>   https://lkml.org/lkml/2019/9/26/825
>
> I also received a regression report from Nicolas Saenz Julienne:
>
>   https://lkml.org/lkml/2019/9/27/263
>
> This problem has cropped up on arch/arm/config/bcm2835_defconfig
> because it enables CONFIG_CC_OPTIMIZE_FOR_SIZE. The compiler tends
> to prefer not inlining functions with -Os. I was able to reproduce
> it with other boards and defconfig files by manually enabling
> CONFIG_CC_OPTIMIZE_FOR_SIZE.
>
> The __get_user_check() specifically uses r0, r1, r2 registers.

Yep, that part is obvious, but...

> So, uaccess_save_and_enable() and uaccess_restore() must be inlined
> in order to avoid those registers being overwritten in the callees.

Right, r0, r1, r2 are caller saved, meaning that __get_user_check must
save/restore them when making function calls. So
uaccess_save_and_enable() and uaccess_restore() should either be made
into macros (macros and typecheck (see include/linux/typecheck.h) are
peanut butter and chocolate), or occur at different points in the
function when those register variables are no longer in use.

>
> Prior to commit 9012d011660e ("compiler: allow all arches to enable
> CONFIG_OPTIMIZE_INLINING"), the 'inline' marker was always enough for
> inlining functions, except on x86.
>
> Since that commit, all architectures can enable CONFIG_OPTIMIZE_INLINING.
> So, __always_inline is now the only guaranteed way of forcible inlining.
>
> I want to keep as much compiler's freedom as possible about the inlining
> decision. So, I changed the function call order instead of adding
> __always_inline around.
>
> Call uaccess_save_and_enable() before assigning the __p ("r0"), and
> uaccess_restore() after evacuating the __e ("r0").
>
> Fixes: 9012d011660e ("compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING")
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Reported-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  arch/arm/include/asm/uaccess.h | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
> index 303248e5b990..559f252d7e3c 100644
> --- a/arch/arm/include/asm/uaccess.h
> +++ b/arch/arm/include/asm/uaccess.h
> @@ -191,11 +191,12 @@ extern int __get_user_64t_4(void *);
>  #define __get_user_check(x, p)                                         \
>         ({                                                              \
>                 unsigned long __limit = current_thread_info()->addr_limit - 1; \
> +               unsigned int __ua_flags = uaccess_save_and_enable();    \
>                 register typeof(*(p)) __user *__p asm("r0") = (p);      \
>                 register __inttype(x) __r2 asm("r2");                   \
>                 register unsigned long __l asm("r1") = __limit;         \
>                 register int __e asm("r0");                             \

What does it mean for there to be two different local variables pinned
to the same register? Ie. it looks like __e and __p are defined to
exist in r0.  Would having one variable and an explicit cast result in
differing storage?

> -               unsigned int __ua_flags = uaccess_save_and_enable();    \
> +               unsigned int __err;                                     \
>                 switch (sizeof(*(__p))) {                               \
>                 case 1:                                                 \
>                         if (sizeof((x)) >= 8)                           \
> @@ -223,9 +224,10 @@ extern int __get_user_64t_4(void *);
>                         break;                                          \
>                 default: __e = __get_user_bad(); break;                 \

^ I think this assignment to __e should be replaced with an assignment
to __err?  We no longer need the register at this point and could skip
the assignment of x.

>                 }                                                       \
> -               uaccess_restore(__ua_flags);                            \
> +               __err = __e;                                            \
>                 x = (typeof(*(p))) __r2;                                \
> -               __e;                                                    \
> +               uaccess_restore(__ua_flags);                            \
> +               __err;                                                  \
>         })
>
>  #define get_user(x, p)                                                 \
> --
> 2.17.1
>


-- 
Thanks,
~Nick Desaulniers
