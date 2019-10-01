Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AABC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 08:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FED621783
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 08:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="xHIO6PTo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733027AbfJAI1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 04:27:19 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:59334 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfJAI1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 04:27:19 -0400
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x918REXh004109
        for <linux-kernel@vger.kernel.org>; Tue, 1 Oct 2019 17:27:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x918REXh004109
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1569918435;
        bh=NTKx0xB9QLkRSTJJgxF9CkFFxM/Hw6/XWymFcoefPgo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xHIO6PToKh8HStqdGTKKiwVU5/yWuKLzrG5Vjt7XN4dEueUCPLVedcPtxhjqBD0Wa
         0afoxJyKitPb06woYCQugANA6BTIt4VU2yZOEaZKy5wjOgGfu3oaEGJQIU9ESnWGV8
         Wa3QqWCzPDb0qe/CRPIacggdClsRXponVJD7HNsveec65KSk5uTHdlHyjeUDqCfILI
         eiJwsME65DxsyVboxd1/w94iMYr2h1QyDQhz/AGfYxWWr1aDjBFstCAJ2JU9/IKWB0
         h1BFXLOO6uTq3riXaqrXo33tlwDK+7+KvJZH1YO2/wYwTQXfcd3JMpue5PMIHuM3Cj
         gxycpTjXDEV5g==
X-Nifty-SrcIP: [209.85.221.178]
Received: by mail-vk1-f178.google.com with SMTP id w3so3303991vkm.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 01:27:15 -0700 (PDT)
X-Gm-Message-State: APjAAAXcFXZPmO6HUszrotYbVoYH8l/nn6RJEgPSMHikzACN3ojTDg2s
        jx3hLqiz5s4y90rytFxaN6KV7DbrDeHFHZyQioY=
X-Google-Smtp-Source: APXvYqyiSCioWKRLdsi5vTtLFl0O+IRnkrPUciETyrvHuFQkqEcvD1cMecSdku0rISUlgI0fA7A1/xDzTMxf83f1/j0=
X-Received: by 2002:a1f:2343:: with SMTP id j64mr6852228vkj.84.1569918433967;
 Tue, 01 Oct 2019 01:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190930055925.25842-1-yamada.masahiro@socionext.com> <20190930175009.GH25745@shell.armlinux.org.uk>
In-Reply-To: <20190930175009.GH25745@shell.armlinux.org.uk>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 1 Oct 2019 17:26:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNATYXUrzNFLZpzAN2U1Ep+RvYccEsqSXUhhF2k9ONwJN1g@mail.gmail.com>
Message-ID: <CAK7LNATYXUrzNFLZpzAN2U1Ep+RvYccEsqSXUhhF2k9ONwJN1g@mail.gmail.com>
Subject: Re: [PATCH] ARM: fix __get_user_check() in case uaccess_* calls are
 not inlined
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Olof Johansson <olof@lixom.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On Tue, Oct 1, 2019 at 2:50 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Mon, Sep 30, 2019 at 02:59:25PM +0900, Masahiro Yamada wrote:
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
> > So, uaccess_save_and_enable() and uaccess_restore() must be inlined
> > in order to avoid those registers being overwritten in the callees.
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
> >  #define __get_user_check(x, p)                                               \
> >       ({                                                              \
> >               unsigned long __limit = current_thread_info()->addr_limit - 1; \
> > +             unsigned int __ua_flags = uaccess_save_and_enable();    \
>
> If the compiler is moving uaccess_save_and_enable(), that's something
> we really don't want

Hmm, based on my poor knowledge about compilers,
I do not know if this re-arrangement happens...

> - the idea is to _minimise_ the number of kernel
> memory accesses between enabling userspace access and performing the
> actual access.
>
> Fixing it in this way widens the window for the kernel to be doing
> something it shoulding in userspace.
>
> So, the right solution is to ensure that the compiler always inlines
> the uaccess_*() helpers - which should be nothing more than four
> instructions for uaccess_save_and_enable() and two for the
> restore.
>

OK, I will use __always_inline to avoid
any potential behavior change.

Thanks.


-- 
Best Regards
Masahiro Yamada
