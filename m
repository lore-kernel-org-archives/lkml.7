Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B117BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D412173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="LM483Zxf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfC1NIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 09:08:53 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:56585 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfC1NIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 09:08:52 -0400
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x2SD8f3O003839;
        Thu, 28 Mar 2019 22:08:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x2SD8f3O003839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1553778522;
        bh=nNDy7x/HQuHXlxZ1crpYzQdxixf+oAWzGu1wozRJaz4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LM483ZxfzDx0TGjAmkP4ofZlwCDUYO5s2K+c3zm3alPiVlaHmrMlrHR3oeTE/sMcn
         C5z4uf+1iGfcSNvXpp08yo9V7nhdeqCWizlE20ZGq919HPbu97iUrNLpK/6g+NOz7g
         fFCLV/3323w+F1LSnZzb9Rr4Y64VjgycrXv31eluifA9vBxwhL+IbluwXedvPjcm1i
         zBakQTiRO+YF73Ynz496lirycJYU1Cmmba2SnfVbMYQ4AMh5YM04lrrblsf2Cvy5yF
         AbE9ZnWuUb/lx3dCNuRL/b7dw443f6agPMjbjXY2cPyeGCjw9oC25JNcqmzwVUg2Ks
         sOinS2y/O41Fw==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id f22so8359255vso.7;
        Thu, 28 Mar 2019 06:08:42 -0700 (PDT)
X-Gm-Message-State: APjAAAXv81lcT9ac+JF+rBfrmBMbZntAi5x9GF6ePZl6AthEVpHoF4cW
        m56LNNDKynkh1oz1rwNwN3cATN57RYXLSqK1Im4=
X-Google-Smtp-Source: APXvYqze54vyOIYL0L88wXMtvls5ZGOxFoeXcW2Oah/RPdLLeaRx2zD55fkwLOrlLseCRO00m6VQTWEOSlE5xj5V3As=
X-Received: by 2002:a67:f105:: with SMTP id n5mr26171042vsk.181.1553778521498;
 Thu, 28 Mar 2019 06:08:41 -0700 (PDT)
MIME-Version: 1.0
References: <1553321671-27749-1-git-send-email-wen.yang99@zte.com.cn>
 <179bbdd1-3fcb-bba5-52b3-7f96973c7650@web.de> <alpine.DEB.2.21.1903232104030.5660@hadrien>
 <20190326084512.GC32590@kadam> <alpine.DEB.2.20.1903261037320.5021@hadrien>
 <20190326101103.GH32613@kadam> <alpine.DEB.2.20.1903261115300.5021@hadrien>
In-Reply-To: <alpine.DEB.2.20.1903261115300.5021@hadrien>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 28 Mar 2019 22:08:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT9gKvEX9520Sd50vrS7Gug1JQCMx_TJO_KPQjhjPORXw@mail.gmail.com>
Message-ID: <CAK7LNAT9gKvEX9520Sd50vrS7Gug1JQCMx_TJO_KPQjhjPORXw@mail.gmail.com>
Subject: Re: [PATCH] coccinelle: put_device: reduce false positives
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Yi Wang <wang.yi59@zte.com.cn>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        cocci@systeme.lip6.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 7:16 PM Julia Lawall <julia.lawall@lip6.fr> wrote:
>
>
>
> On Tue, 26 Mar 2019, Dan Carpenter wrote:
>
> > On Tue, Mar 26, 2019 at 10:38:43AM +0100, Julia Lawall wrote:
> > >
> > >
> > > On Tue, 26 Mar 2019, Dan Carpenter wrote:
> > >
> > > > On Sat, Mar 23, 2019 at 09:06:54PM +0100, Julia Lawall wrote:
> > > > >
> > > > >
> > > > > On Sat, 23 Mar 2019, Markus Elfring wrote:
> > > > >
> > > > > > > Don't complain about a return when this function returns "&pd=
ev->dev".
> > > > > >
> > > > > > Would this information qualify to add the tag =E2=80=9CFixes=E2=
=80=9D to the commit message?
> > > > >
> > > > > Fixes tags relate to stable kernels, so that one can see which st=
able
> > > > > kernels a particular patch should be propagated to.  There is no =
need to
> > > > > propagate patches on semantic patches to stable kernels.  People =
who run
> > > > > stable kernels are interested in their behavior, not the bug find=
ing
> > > > > rules that they contain.
> > > >
> > > > The Fixes tag is not just about stable...  For example, we use them=
 for
> > > > statistics to see how quickly bugs get fixed etc.
> > >
> > > OK.  But still do we need fixes tags for bug finding rules?  Perhaps =
if
> > > the previous version was really broken, and it would be really undesi=
rable
> > > to use it.
> >
> > It's not worth resending a patch for that, but I probably would use the
> > fixes tag.  It depends on your definition of "bug" really...  I tell
> > people not to use Fixes for spelling mistakes and unused variables.  Bu=
t
> > I do use the Fixes tag for things like "an off by one in a sanity check
> > which doesn't affect run time because the index is always correct".
>
> OK, thanks.
>
> julia

I added Fixes: tag,
and applied to linux-kbuild/fixes.

Thanks.

--=20
Best Regards
Masahiro Yamada
