Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0F4C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84FCD20833
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="J4au0++M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbfEPNsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 09:48:54 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:17218 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfEPNsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 09:48:54 -0400
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x4GDmg9c011254
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 22:48:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x4GDmg9c011254
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1558014522;
        bh=X0frcOGR3psV+x7WGdjxWUl7hWweQjiB+M+DnkVeiMQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J4au0++MIH43N4htFxGoX3FUWhZPH1Fz35ZI3VhdAJEXvAuwD3E4aOJjqMDtB4FBA
         RBenJQeoH0bAYPWx6WWWrJaN5IMs/GZoKEnF1voWdwQDjB9a+coFGewuNRC3JMSZAA
         mvRxHEQHdVvH6dgi2ljuQ0s+VWh2+FLochMicjMYtBof+dmKaIpXQ+0FYFm6EQsosZ
         DwWYHP2ASUZT8LNMffM3XGkXL4LeZ8t64ZrbCmgZ7nYaiP3o0F+Blbb0JuW1DPMjGj
         CQqfaCQrS+36V6rUW33TdDbXpcTEgu2uNFgyOyErdzIfPgZV92G4eYQpTuSKCzhUZ3
         f2Iiny8+JYTwg==
X-Nifty-SrcIP: [209.85.222.44]
Received: by mail-ua1-f44.google.com with SMTP id e9so1299021uar.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 06:48:42 -0700 (PDT)
X-Gm-Message-State: APjAAAW5XzlmR7J2pSi4ud83uHoce9WsVWsRzENlgh6OAp0NUJ+fmD3s
        oHufNzeaeIaujZgf/UoECg/inYEOZrg6mBbs6vI=
X-Google-Smtp-Source: APXvYqySVnD3fxjOiZxmSe2ykSqlWEPVQWZ6yLxADtqLjyOwi5GOjJRaPyCAfKg3sxUjS0eAdXUcdeymDecaWzWeY8A=
X-Received: by 2002:a9f:3381:: with SMTP id p1mr60360uab.40.1558014521478;
 Thu, 16 May 2019 06:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190515194824.5641-1-labbott@redhat.com> <CAK7LNASZnRrSsZSrnw41kintGfmpyj3iz-Vjduk7w3k9iSih-w@mail.gmail.com>
 <20190516104619.GA29705@fuggles.cambridge.arm.com>
In-Reply-To: <20190516104619.GA29705@fuggles.cambridge.arm.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 16 May 2019 22:48:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNARn+mzQNaVrkFqsxOfJ4xeXB5dSnfNWGCjQ=AenVcT50A@mail.gmail.com>
Message-ID: <CAK7LNARn+mzQNaVrkFqsxOfJ4xeXB5dSnfNWGCjQ=AenVcT50A@mail.gmail.com>
Subject: Re: [PATCH] arm64: vdso: Explicitly add build-id option
To:     Will Deacon <will.deacon@arm.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 7:48 PM Will Deacon <will.deacon@arm.com> wrote:
>
> On Thu, May 16, 2019 at 01:58:56PM +0900, Masahiro Yamada wrote:
> > On Thu, May 16, 2019 at 4:51 AM Laura Abbott <labbott@redhat.com> wrote:
> > >
> > > Commit 691efbedc60d ("arm64: vdso: use $(LD) instead of $(CC) to
> > > link VDSO") switched to using LD explicitly. The --build-id option
> > > needs to be passed explicitly, similar to x86. Add this option.
> > >
> > > Fixes: 691efbedc60d ("arm64: vdso: use $(LD) instead of $(CC) to link VDSO")
> > > Signed-off-by: Laura Abbott <labbott@redhat.com>
> > > ---
> > >  arch/arm64/kernel/vdso/Makefile | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
> > > index 744b9dbaba03..ca209103cd06 100644
> > > --- a/arch/arm64/kernel/vdso/Makefile
> > > +++ b/arch/arm64/kernel/vdso/Makefile
> > > @@ -13,6 +13,7 @@ targets := $(obj-vdso) vdso.so vdso.so.dbg
> > >  obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
> > >
> > >  ldflags-y := -shared -nostdlib -soname=linux-vdso.so.1 \
> > > +               $(call ld-option, --build-id) \
> > >                 $(call ld-option, --hash-style=sysv) -n -T
> > >
> > >  # Disable gcov profiling for VDSO code
> >
> >
> > I missed that. Sorry.
> >
> > You can add  --build-id without $(call ld-option,...)
> > because it is supported by our minimal version of toolchain.
> >
> > See commit log of 1e0221374e for example.
>
> Ok, so I'm ok folding in the diff below on top?


Looks good to me too.

Thanks.


> Will
>
> --->8
>
> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
> index ca209103cd06..fa230ff09aa1 100644
> --- a/arch/arm64/kernel/vdso/Makefile
> +++ b/arch/arm64/kernel/vdso/Makefile
> @@ -12,9 +12,8 @@ obj-vdso := gettimeofday.o note.o sigreturn.o
>  targets := $(obj-vdso) vdso.so vdso.so.dbg
>  obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
>
> -ldflags-y := -shared -nostdlib -soname=linux-vdso.so.1 \
> -               $(call ld-option, --build-id) \
> -               $(call ld-option, --hash-style=sysv) -n -T
> +ldflags-y := -shared -nostdlib -soname=linux-vdso.so.1 --hash-style=sysv \
> +               --build-id -n -T
>
>  # Disable gcov profiling for VDSO code
>  GCOV_PROFILE := n



-- 
Best Regards
Masahiro Yamada
