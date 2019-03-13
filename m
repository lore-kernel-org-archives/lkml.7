Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05AAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C17E2213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="aAAongqc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfCMRgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 13:36:31 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:32914 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfCMRga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 13:36:30 -0400
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x2DHaGSZ018083;
        Thu, 14 Mar 2019 02:36:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x2DHaGSZ018083
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552498577;
        bh=uVOI0GFg89NRHVnsOdKYr/Ew+boYsLjMjr/Ih1QBEw0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aAAongqcmg8Rccgl9/u+I+Mgvl3wUow7E3eGVMI2Lc3zHdpzfghQyZyWgPxiDjkzs
         GxLqntiyPt17UoNJ7QxIhEE1+0KMcofJLEJWlWk3AeIaHJYu6KJXlMbWvjh8dX3OET
         xRrf2HOrsm+7DYydJhAwaodhAkXOVf30P7V+C6UVJP6H9mTxRN7IdXOJgiSI0fYr7x
         GcRup07VQSGe1t+LtZnADM2k3pYcE9jKpjiPW9D5CzSuw+Ecx3opkX/oVohSTg4Aaw
         REEEgrFKPejjjrkQ/dLDPSqW1y/MzZizWitrLI/PVc96YjufcHkFQEq0AgtanegfOo
         eDdr2LWHDbBIw==
X-Nifty-SrcIP: [209.85.217.50]
Received: by mail-vs1-f50.google.com with SMTP id n14so1516488vsp.12;
        Wed, 13 Mar 2019 10:36:16 -0700 (PDT)
X-Gm-Message-State: APjAAAVmavO7NrYS8Y5lHEl8Mm7raUYAkkaJFQgPL3nVVDRyeLBJSo5A
        CLOJMqS2eabua6fQHoEEPZu9Xdr4bmxYRR50zes=
X-Google-Smtp-Source: APXvYqzSr1MJQCpSG1BeoWBJ8Q//KTk/GjPknU2vsjmh+jN+RINuUMmVsALM7VIbthYqiIX9DEZZiZN0z8vzrBTqK+E=
X-Received: by 2002:a67:f90e:: with SMTP id t14mr23676462vsq.181.1552498575728;
 Wed, 13 Mar 2019 10:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <1548387699-9222-1-git-send-email-yamada.masahiro@socionext.com> <CAK7LNAQ6bRxhXuSgVS0DqZ_izMyKuujmQe9TVV8pDXve-gs90g@mail.gmail.com>
In-Reply-To: <CAK7LNAQ6bRxhXuSgVS0DqZ_izMyKuujmQe9TVV8pDXve-gs90g@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 14 Mar 2019 02:35:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNASfATE2zgm7Qz3i2Hm1vxTg_jE-jDwDDJ8ASVg19EdCXQ@mail.gmail.com>
Message-ID: <CAK7LNASfATE2zgm7Qz3i2Hm1vxTg_jE-jDwDDJ8ASVg19EdCXQ@mail.gmail.com>
Subject: Re: [PATCH] libfdt: prefix header search paths with $(srctree)/
To:     DTML <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 10:43 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi Rob,
>
>
> On Fri, Jan 25, 2019 at 12:42 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > Currently, the Kbuild core manipulates header search paths in a crazy
> > way [1].
> >
> > To fix this mess, I want all Makefiles to add explicit $(srctree)/ to
> > the search paths in the srctree. Some Makefiles are already written in
> > that way, but not all. The goal of this work is to make the notation
> > consistent, and finally get rid of the gross hacks.
> >
> > Having whitespaces after -I does not matter since commit 48f6e3cf5bc6
> > ("kbuild: do not drop -I without parameter").
> >
> > [1]: https://patchwork.kernel.org/patch/9632347/
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
>
> Could you apply this to your tree?


Anyway, this one is trivial Makefile change.

Applied to linux-kbuild now.





> Thanks.
>
> Masahiro
>
>
> > ---
> >
> >  lib/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/lib/Makefile b/lib/Makefile
> > index e1b59da..05973c1 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -208,7 +208,7 @@ KCOV_INSTRUMENT_stackdepot.o := n
> >  libfdt_files = fdt.o fdt_ro.o fdt_wip.o fdt_rw.o fdt_sw.o fdt_strerror.o \
> >                fdt_empty_tree.o
> >  $(foreach file, $(libfdt_files), \
> > -       $(eval CFLAGS_$(file) = -I$(src)/../scripts/dtc/libfdt))
> > +       $(eval CFLAGS_$(file) = -I $(srctree)/scripts/dtc/libfdt))
> >  lib-$(CONFIG_LIBFDT) += $(libfdt_files)
> >
> >  obj-$(CONFIG_RBTREE_TEST) += rbtree_test.o
> > --
> > 2.7.4
> >
>
>
> --
> Best Regards
> Masahiro Yamada



-- 
Best Regards
Masahiro Yamada
