Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D396CECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A79B72168B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tQeowPI5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731315AbfJAREK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 13:04:10 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36725 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730011AbfJAREC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 13:04:02 -0400
Received: by mail-pf1-f194.google.com with SMTP id y22so8455563pfr.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 10:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EcBrAvMosjOG+UozMLy1mX7WITMjOIgSIxKt9S1MY78=;
        b=tQeowPI5FGxOFELVxn4y0uIrJzC5WdQ10Icig06ZTrO0qKSy0zxsNCHYx7PmJoHS7p
         dog98eiYC996iI878c1DE9kDWe1n3D3glN7bCP3v+0GjdRobfuD6Wz5/LnugQCizZyKk
         3t+GPMpzdPfo1HbVPk7aMWwpYS3e2/yiAtXINj1ZEEPjJ/r4rXi1mw3kWiTZbGtX2HY7
         3Y64wTqHn2rZkQswmnTCus2NmKzKuBV5mD8CYr2MtWGQn0+L9J4dAcrgVi5Nhlx1+AK/
         SQdt2fRwKidwBzn6oVp/ixyPx3dK1TWxMMj4ReQ25zrY85m6rZ9BTXSs2fD6sD4snKLA
         M4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EcBrAvMosjOG+UozMLy1mX7WITMjOIgSIxKt9S1MY78=;
        b=AYdz6a3OXXOU9KI976ROpOciQbzrHbO83E4c3iMM4CIgHFbYUjSAQEr052Cnkz1yBz
         1SfekutJIkX4a9w9yrY3HM2uyox4yFLrSfeZztDD+/eNTqoYKbQpDJODMfWRsl1xqGtQ
         bacE3PUgvNChglz2upeTSGRv69kjL26X0n1Dn/Reai1zqdHNlYuQKBucuvfmJV96sisV
         3SMQvyA11Zjxl9zDGtUczNrfMxXB3/diJttJ8fzwYDDjMGPDO0XToz5F7WkldtHErdw9
         V0Q+c+lNAWjcTpqfa7lwY+sfEDnzofMwAXV/Scgl0YXkmca0wRmlRKoqw4nbgGvfHoSi
         PAsQ==
X-Gm-Message-State: APjAAAW7k009MAU8uk6NrVlPmPYmyao1iiAGGnq800+IpaukQystxiR8
        h8AKgXfNRd98AHGvkL8qqlDRnbhue8GwCZ7c4aZo3A==
X-Google-Smtp-Source: APXvYqw3A/RUIhbvi9tHej5gK5Ducu/8QWOwZ72fe1dUcSs00OVimHuao8TGBKT2Q9Yr+5x6YGdZ13lsQb3fiV6nTWk=
X-Received: by 2002:a62:798e:: with SMTP id u136mr29331106pfc.3.1569949441392;
 Tue, 01 Oct 2019 10:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <20191001083701.27207-1-yamada.masahiro@socionext.com>
In-Reply-To: <20191001083701.27207-1-yamada.masahiro@socionext.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 1 Oct 2019 10:03:50 -0700
Message-ID: <CAKwvOd=NObDXDL3jz9ZX9wo4tn747peBJPTj0DXyLerixgL+wQ@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: add __always_inline to functions called from __get_user_check()
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
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

On Tue, Oct 1, 2019 at 1:37 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> KernelCI reports that bcm2835_defconfig is no longer booting since
> commit ac7c3e4ff401 ("compiler: enable CONFIG_OPTIMIZE_INLINING
> forcibly") (https://lkml.org/lkml/2019/9/26/825).
>
> I also received a regression report from Nicolas Saenz Julienne
> (https://lkml.org/lkml/2019/9/27/263).
>
> This problem has cropped up on bcm2835_defconfig because it enables
> CONFIG_CC_OPTIMIZE_FOR_SIZE. The compiler tends to prefer not inlining
> functions with -Os. I was able to reproduce it with other boards and
> defconfig files by manually enabling CONFIG_CC_OPTIMIZE_FOR_SIZE.
>
> The __get_user_check() specifically uses r0, r1, r2 registers.
> So, uaccess_save_and_enable() and uaccess_restore() must be inlined.
> Otherwise, those register assignments would be entirely dropped,
> according to my analysis of the disassembly.
>
> Prior to commit 9012d011660e ("compiler: allow all arches to enable
> CONFIG_OPTIMIZE_INLINING"), the 'inline' marker was always enough for
> inlining functions, except on x86.
>
> Since that commit, all architectures can enable CONFIG_OPTIMIZE_INLINING.
> So, __always_inline is now the only guaranteed way of forcible inlining.

No, the C preprocessor is the only guaranteed way of inlining.  I
preferred v1; if you're going to <strikethrough>play with
fire</strikethrough>write assembly, don't get burned.

>
> I also added __always_inline to 4 functions in the call-graph from the
> __get_user_check() macro.
>
> Fixes: 9012d011660e ("compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING")
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Reported-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> Changes in v2:
>   - Use __always_inline instead of changing the function call places
>      (per Russell King)
>   - The previous submission is: https://lore.kernel.org/patchwork/patch/1132459/
>
>  arch/arm/include/asm/domain.h  | 8 ++++----
>  arch/arm/include/asm/uaccess.h | 4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/include/asm/domain.h b/arch/arm/include/asm/domain.h
> index 567dbede4785..f1d0a7807cd0 100644
> --- a/arch/arm/include/asm/domain.h
> +++ b/arch/arm/include/asm/domain.h
> @@ -82,7 +82,7 @@
>  #ifndef __ASSEMBLY__
>
>  #ifdef CONFIG_CPU_CP15_MMU
> -static inline unsigned int get_domain(void)
> +static __always_inline unsigned int get_domain(void)
>  {
>         unsigned int domain;
>
> @@ -94,7 +94,7 @@ static inline unsigned int get_domain(void)
>         return domain;
>  }
>
> -static inline void set_domain(unsigned val)
> +static __always_inline void set_domain(unsigned int val)
>  {
>         asm volatile(
>         "mcr    p15, 0, %0, c3, c0      @ set domain"
> @@ -102,12 +102,12 @@ static inline void set_domain(unsigned val)
>         isb();
>  }
>  #else
> -static inline unsigned int get_domain(void)
> +static __always_inline unsigned int get_domain(void)
>  {
>         return 0;
>  }
>
> -static inline void set_domain(unsigned val)
> +static __always_inline void set_domain(unsigned int val)
>  {
>  }
>  #endif
> diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
> index 303248e5b990..98c6b91be4a8 100644
> --- a/arch/arm/include/asm/uaccess.h
> +++ b/arch/arm/include/asm/uaccess.h
> @@ -22,7 +22,7 @@
>   * perform such accesses (eg, via list poison values) which could then
>   * be exploited for priviledge escalation.
>   */
> -static inline unsigned int uaccess_save_and_enable(void)
> +static __always_inline unsigned int uaccess_save_and_enable(void)
>  {
>  #ifdef CONFIG_CPU_SW_DOMAIN_PAN
>         unsigned int old_domain = get_domain();
> @@ -37,7 +37,7 @@ static inline unsigned int uaccess_save_and_enable(void)
>  #endif
>  }
>
> -static inline void uaccess_restore(unsigned int flags)
> +static __always_inline void uaccess_restore(unsigned int flags)
>  {
>  #ifdef CONFIG_CPU_SW_DOMAIN_PAN
>         /* Restore the user access mask */
> --
> 2.17.1
>


-- 
Thanks,
~Nick Desaulniers
