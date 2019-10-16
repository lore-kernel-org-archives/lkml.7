Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C784BFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D52520854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="1HVgYGrg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404804AbfJPLDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 07:03:47 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:36167 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfJPLDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 07:03:47 -0400
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x9GB3Ka9025407;
        Wed, 16 Oct 2019 20:03:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x9GB3Ka9025407
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1571223801;
        bh=CZS/GBm12+BcQahpwNBxwpIrzDOrM5ncaaZ4Hdi5fxQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1HVgYGrgJuqrnsFm151Rr+/Ybj/6G/6A5CDaKqgjkNSW6mBkkrOdP+bIIbGO3HOoJ
         WnTqwTDHR2MnEEuHR3UiBAZmidhAQF05xoY3OLg83RY1CCBZr8JmLtEAnNIjYo9fdE
         1zVqX5OgWlTDstIUkdpQ1WaSztMdZibwcbal9Qg+x3GWdF1dgDlwU/F5uT5Gsn2VUN
         D42EaCMOj+qH4AsLbpQbTjumFONOBmarRGWxBCzTSR1sLkssX2kYWAigly4G6FIl2r
         aYrHG2aF9qCQ3tCD7nrGHOi7GohhOlhh2LbBpRW2R24a/nkdtx2DlK9gLfFsS+Fgsk
         5rknQ5sUraqFQ==
X-Nifty-SrcIP: [209.85.217.43]
Received: by mail-vs1-f43.google.com with SMTP id y129so15296207vsc.6;
        Wed, 16 Oct 2019 04:03:20 -0700 (PDT)
X-Gm-Message-State: APjAAAVfu0ALrjk8WuhlJ8a9IAS2DSSrPFW/4Y2PF1bQelVwE7wSyXV6
        EYs8GlC26IXKTx6dg0ARMS40rGgTN6bKt+GPkHs=
X-Google-Smtp-Source: APXvYqwi2NOARFdiIeiefPcsQM9QE7f5KDMvhzleVf/yNku4VncLL4mmJysOK+WrOjI4KTTDWV6CdUJJKviU0KwCJo0=
X-Received: by 2002:a67:ff86:: with SMTP id v6mr23079325vsq.181.1571223799384;
 Wed, 16 Oct 2019 04:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190617162123.24920-1-yamada.masahiro@socionext.com>
 <CAK7LNATtqhxPcDneW0QOkw-5NyPNP06Qv0bYTe7A_gCiHMiU7A@mail.gmail.com> <CAK7LNASMwqy0ZUZ=kTJ7MJ6OJNa=+vbj5444xzmubJ8+6vO=sg@mail.gmail.com>
In-Reply-To: <CAK7LNASMwqy0ZUZ=kTJ7MJ6OJNa=+vbj5444xzmubJ8+6vO=sg@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 16 Oct 2019 20:01:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS=9yGqMQ9eoM4L0hhvuFRYhg6S4i6J3Ou9vcB1Npj4BQ@mail.gmail.com>
Message-ID: <CAK7LNAS=9yGqMQ9eoM4L0hhvuFRYhg6S4i6J3Ou9vcB1Npj4BQ@mail.gmail.com>
Subject: Re: [PATCH] libfdt: reduce the number of headers included from libfdt_env.h
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Could you pick up this to akpm tree?
https://lore.kernel.org/patchwork/patch/1089856/

I believe this is correct, and a good clean-up.

I pinged the DT maintainers, but they did not respond.

Thanks.




On Mon, Aug 19, 2019 at 1:36 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Thu, Aug 1, 2019 at 11:30 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > On Tue, Jun 18, 2019 at 1:21 AM Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> > >
> > > Currently, libfdt_env.h includes <linux/kernel.h> just for INT_MAX.
> > >
> > > <linux/kernel.h> pulls in a lots of broat.
> > >
> > > Thanks to commit 54d50897d544 ("linux/kernel.h: split *_MAX and *_MIN
> > > macros into <linux/limits.h>"), <linux/kernel.h> can be replaced with
> > > <linux/limits.h>.
> > >
> > > This saves including dozens of headers.
> > >
> > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > ---
> >
> > ping?
>
> ping x2.
>
>
>
>
> >
> >
> > >  include/linux/libfdt_env.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/libfdt_env.h b/include/linux/libfdt_env.h
> > > index edb0f0c30904..2231eb855e8f 100644
> > > --- a/include/linux/libfdt_env.h
> > > +++ b/include/linux/libfdt_env.h
> > > @@ -2,7 +2,7 @@
> > >  #ifndef LIBFDT_ENV_H
> > >  #define LIBFDT_ENV_H
> > >
> > > -#include <linux/kernel.h>      /* For INT_MAX */
> > > +#include <linux/limits.h>      /* For INT_MAX */
> > >  #include <linux/string.h>
> > >
> > >  #include <asm/byteorder.h>
> > > --
> > > 2.17.1
> > >
> >
> >
> > --
> > Best Regards
> > Masahiro Yamada
>
>
>
> --
> Best Regards
> Masahiro Yamada



-- 
Best Regards
Masahiro Yamada
