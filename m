Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF6AC2D0C0
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 01:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C75D320643
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 01:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1UuMupM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfLXBf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 20:35:29 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:35156 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbfLXBf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 20:35:28 -0500
Received: by mail-io1-f65.google.com with SMTP id v18so17870748iol.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 17:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9lmC0cEb7NijnFrwroELGHeSVAX59tyGYC7C4mWEi2k=;
        b=B1UuMupMzU6CvsK1M8U19051nfyVhd1G/xTieA9RShOJcjMhmLMUZIfe6A42Cdauwe
         twErhsT6BCAnhKC5dqqhfxBw3UA+c0i9F7mMX9w2odxxx7vC/onGDursDbiXi23r+zgz
         hzTBTPHIZTvO1/7BR9JjbMLag7xt/kR4L3q4+Om+9WarzYjTejq8Z4YgrBjzd6KRxYst
         gFqaeZIaIEyY/gblrioTxzia0VRRLVg5PBX7pHVwiOgE3tj+Owk24iMDyj2hjHXoUueW
         h7ayQf3MSpnF5O8VTmXeypm/GGN68OwpnMic09yKrVzwGbCSGy3h4V6NZaviJbRsh9Zz
         gebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9lmC0cEb7NijnFrwroELGHeSVAX59tyGYC7C4mWEi2k=;
        b=hz2/3I420F4lrByX4aGNzZY72lF3N8xuieddQ/FR8Zlt6bBFOWltY1URkUm1Uw0bYV
         hHBOk1g0OchC2/vOgM7mvO/OPPg0DcZ4EEElEqdegJ4b2ksgsRPTMIcIPfX+uyCdaAGQ
         fWOcIxgCxpZmUBCAxxrvEB9gZ8AXq91hm/3leUdMHU2J/dFCz+0meu7d2+bBO+Tswf8l
         wEgo0ZTWc/bl3m3Ed1UVnvysH5lhU+zyff9Dur6L5o817LqZwY8l68VPhzB0yBceN8Mk
         7mCzpgk5TcNwC9nbwQN9DZ4JxBk7ztow/1gPPAtV+TlZBKF3qBmvlcBt5x1V2JDWGmOs
         Qk5g==
X-Gm-Message-State: APjAAAXMRKYK6/w7xHE5x6zXRWoqpMs64t3VjFDVzaGCKHPwSHYuzC8q
        XvdslB7C9CSDVfynwop8zkXjUmgoRvthTL8CpqE=
X-Google-Smtp-Source: APXvYqyANcx7D97M/9YZtBXmDKHROxQ6MY2zr+nlO+rOorkbsUyKV+d0LGUBSaX2CbaKZFMWuBmHum1Pqwx/EVjcefQ=
X-Received: by 2002:a5d:9f4f:: with SMTP id u15mr6520488iot.129.1577151327920;
 Mon, 23 Dec 2019 17:35:27 -0800 (PST)
MIME-Version: 1.0
References: <1574694943-7883-1-git-send-email-yingjie_bai@126.com> <87pngglmxg.fsf@mpe.ellerman.id.au>
In-Reply-To: <87pngglmxg.fsf@mpe.ellerman.id.au>
From:   Yingjie Bai <byj.tea@gmail.com>
Date:   Tue, 24 Dec 2019 09:35:16 +0800
Message-ID: <CAFAt38F-YQUVNXEnLut0tMivYUy_OTK7G4wAHfddcmncsEpREQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/mpc85xx: also write addr_h to spin table for
 64bit boot entry
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     yingjie_bai@126.com, Scott Wood <oss@buserror.net>,
        Kumar Gala <galak@kernel.crashing.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,
Thanks for pointing out the issue. My mistake...
This patch should indeed make sense only when
CONFIG_PHYS_64BIT=y

I could not find corenet32_smp_defconfig, but I guess in your config,
CONFIG_PHYS_64BIT=n ?
I will update the patch later today

On Sun, Dec 22, 2019 at 5:38 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> yingjie_bai@126.com writes:
> > From: Bai Yingjie <byj.tea@gmail.com>
> >
> > CPU like P4080 has 36bit physical address, its DDR physical
> > start address can be configured above 4G by LAW registers.
> >
> > For such systems in which their physical memory start address was
> > configured higher than 4G, we need also to write addr_h into the spin
> > table of the target secondary CPU, so that addr_h and addr_l together
> > represent a 64bit physical address.
> > Otherwise the secondary core can not get correct entry to start from.
> >
> > This should do no harm for normal case where addr_h is all 0.
> >
> > Signed-off-by: Bai Yingjie <byj.tea@gmail.com>
> > ---
> >  arch/powerpc/platforms/85xx/smp.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
> > index 8c7ea2486bc0..f12cdd1e80ff 100644
> > --- a/arch/powerpc/platforms/85xx/smp.c
> > +++ b/arch/powerpc/platforms/85xx/smp.c
> > @@ -252,6 +252,14 @@ static int smp_85xx_start_cpu(int cpu)
> >       out_be64((u64 *)(&spin_table->addr_h),
> >               __pa(ppc_function_entry(generic_secondary_smp_init)));
> >  #else
> > +     /*
> > +      * We need also to write addr_h to spin table for systems
> > +      * in which their physical memory start address was configured
> > +      * to above 4G, otherwise the secondary core can not get
> > +      * correct entry to start from.
> > +      * This does no harm for normal case where addr_h is all 0.
> > +      */
> > +     out_be32(&spin_table->addr_h, __pa(__early_start) >> 32);
> >       out_be32(&spin_table->addr_l, __pa(__early_start));
>
> This breaks the corenet32_smp_defconfig build:
>
>   /linux/arch/powerpc/platforms/85xx/smp.c: In function 'smp_85xx_start_cpu':
>   /linux/arch/powerpc/platforms/85xx/smp.c:262:52: error: right shift count >= width of type [-Werror=shift-count-overflow]
>     262 |  out_be32(&spin_table->addr_h, __pa(__early_start) >> 32);
>         |                                                    ^~
>   cc1: all warnings being treated as errors
>
> cheers
