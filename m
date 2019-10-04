Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237DAC10F14
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 02:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF83120862
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 02:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="VdYXhZrc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731858AbfJDCct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 22:32:49 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:50400 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730554AbfJDCcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 22:32:48 -0400
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x942WgKm028652
        for <linux-kernel@vger.kernel.org>; Fri, 4 Oct 2019 11:32:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x942WgKm028652
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1570156363;
        bh=7YN++JqV7jyOcxkopUQJqoctW6E3dcZKj7/HVqXQvuw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VdYXhZrcqJtrPI/G0jK+Re7Lymhlu2McrcbMp9VM5Ff3Mv9Z/SXheONw5MnH2zCKH
         gMNUaTlGKIcHjgiYKB35c/Zal1mQbzlNcxjfKl9TKrSwD5NlmFrsTAueaBXBgxWZsm
         kscgxgSGbSZGlxT8BCLbiNj0MgEqnTqqdctpuzQXhwd9sFB+/0bUXTBn10AGSqA7xa
         O9XdpkkZzvIf+7Qe5HXQUeKPmQ1TJZtrQhTly4WTS81LFnccy2N1oXV65LTlz8NmWd
         LtPgo3dh0mm3j+SoEinzd50WRW0C/TgbRifnrF+YXcErTTe0pVDlgpsI0M4vKm+4Xr
         duwxLN3yrEJrA==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id z14so3109384vsz.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 19:32:43 -0700 (PDT)
X-Gm-Message-State: APjAAAU4TRSl0pK8BiTR2G1qvW12RhyMbCIeXxTaMW8WA/wD529dOUq+
        62loqVbT3p55P/oEaxfuSA3yO/XxML64bFI0Xk8=
X-Google-Smtp-Source: APXvYqxCHsOHAoD11ZZo+llQqdvKhHrk5Nz6ASOFGNVH1oFClIKa5Ad3vrezVer68OIOVqzlzLQ/CwUbHiOfz5xghKQ=
X-Received: by 2002:a67:88c9:: with SMTP id k192mr6718255vsd.181.1570156362283;
 Thu, 03 Oct 2019 19:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190928094245.45696-1-yuehaibing@huawei.com> <alpine.DEB.2.21.1909280542490.2168@hadrien>
 <2c109d6b-45ad-b3ca-1951-bde4dac91d2a@huawei.com> <alpine.DEB.2.21.1909291810300.3346@hadrien>
 <ac79cb42-1713-8801-37e4-edde540f101c@huawei.com> <alpine.DEB.2.21.1910011500470.13162@hadrien>
 <CAK7LNATAqM9QHRqotFQsmh64rww_AxNm4gdV2t5TuYxHA++zSg@mail.gmail.com> <alpine.DEB.2.21.1910031422240.2406@hadrien>
In-Reply-To: <alpine.DEB.2.21.1910031422240.2406@hadrien>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 4 Oct 2019 11:32:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS2K6i+s2A_xTyRq730M6_=tyjtfwHAnEHF37_nrJa4Eg@mail.gmail.com>
Message-ID: <CAK7LNAS2K6i+s2A_xTyRq730M6_=tyjtfwHAnEHF37_nrJa4Eg@mail.gmail.com>
Subject: Re: [RFC PATCH] scripts: Fix coccicheck failed
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Yuehaibing <yuehaibing@huawei.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Matthias Maennich <maennich@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Coccinelle <cocci@systeme.lip6.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 3, 2019 at 9:23 PM Julia Lawall <julia.lawall@lip6.fr> wrote:
>
>
>
> On Thu, 3 Oct 2019, Masahiro Yamada wrote:
>
> > On Tue, Oct 1, 2019 at 10:01 PM Julia Lawall <julia.lawall@lip6.fr> wrote:
> > > > diff --git a/scripts/coccinelle/misc/add_namespace.cocci b/scripts/coccinelle/misc/add_namespace.cocci
> > > > index c832bb6445a8..99e93a6c2e24 100644
> > > > --- a/scripts/coccinelle/misc/add_namespace.cocci
> > > > +++ b/scripts/coccinelle/misc/add_namespace.cocci
> > > > @@ -6,6 +6,8 @@
> > > >  /// add a missing namespace tag to a module source file.
> > > >  ///
> > > >
> > > > +virtual report
> > > > +
> > > >  @has_ns_import@
> > > >  declarer name MODULE_IMPORT_NS;
> > > >  identifier virtual.ns;
> > > >
> > > >
> > > >
> > > > Adding virtual report make the coccicheck go ahead smoothly.
> > >
> > > Acked-by: Julia Lawall <julia.lawall@lip6.fr>
> > >
> >
> >
> > Was this patch posted somewhere?
>
> It was probably waiting for moderation in the cocci mailing list.  Do you
> have it now (or in a few minutes)?

No. I do not see it yet.

I want to pick the patch from LKML Patchwork
https://lore.kernel.org/patchwork/project/lkml/list/

You gave Acked-by to the one-liner fix "virtual report",
and I am happy to apply it to my tree.

YueHaibing, could you submit it as a patch?


-- 
Best Regards
Masahiro Yamada
