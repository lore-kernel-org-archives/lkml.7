Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4E1C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32DA021D81
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="jxSl5GBY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbfJCL6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 07:58:36 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:63779 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfJCL6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 07:58:36 -0400
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x93BwLW8002306
        for <linux-kernel@vger.kernel.org>; Thu, 3 Oct 2019 20:58:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x93BwLW8002306
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1570103902;
        bh=zCd51wQccV5gCP/s+G8hMogXPErk6qWPCtDB4gKUwAg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jxSl5GBYZ47LoeuI94u7/1pbamdvKCjWyxwIPVR7GQDRLs1SwBT51qQOYHt4DeCWJ
         ci4+Gvecenow8EXNQ4ZhG6rbMB0hsD2GcogNnkl3FAzeN0jG7iNVTvssEjI3oBJQKm
         lqeoq476TsoWYldR0irpAm0inuNMqJxtD9GvwcEvAlJAphYk8xAvOpde0H7F16ZKBZ
         OvXQRqFaNoQ3/vuJ7hflU+vuyeIj385S9xurGq2FKy1hHQtPa94mM7XOD1pMcLos2t
         YCrIlsmWwZMtbGt0aEN6B7DCTl2vf4eQ0F+GDDBEmufK13jkqfF/sPErKHn8XlJCwD
         qmqJ36Jw9ehCg==
X-Nifty-SrcIP: [209.85.221.172]
Received: by mail-vk1-f172.google.com with SMTP id p189so539159vkf.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 04:58:22 -0700 (PDT)
X-Gm-Message-State: APjAAAUaWpYeaFe++Vj3NRsiVjVNq+zeqGv63i8ZIGVJVCxkuOAlwMe7
        PjQLsM7w5H1A1JejaAzC3awUzGEnVv5WvCiI0Xo=
X-Google-Smtp-Source: APXvYqzZHz8CSCVCVlLQNQD0edqz1ZrjTUCeWnebM1P72kAuAJyMwfOJJKqkQ8DvnM8O25hZbWzEXqQJs7TrE0eVaGE=
X-Received: by 2002:a1f:2343:: with SMTP id j64mr4670136vkj.84.1570103901321;
 Thu, 03 Oct 2019 04:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190928094245.45696-1-yuehaibing@huawei.com> <alpine.DEB.2.21.1909280542490.2168@hadrien>
 <2c109d6b-45ad-b3ca-1951-bde4dac91d2a@huawei.com> <alpine.DEB.2.21.1909291810300.3346@hadrien>
 <ac79cb42-1713-8801-37e4-edde540f101c@huawei.com> <alpine.DEB.2.21.1910011500470.13162@hadrien>
In-Reply-To: <alpine.DEB.2.21.1910011500470.13162@hadrien>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 3 Oct 2019 20:57:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNATAqM9QHRqotFQsmh64rww_AxNm4gdV2t5TuYxHA++zSg@mail.gmail.com>
Message-ID: <CAK7LNATAqM9QHRqotFQsmh64rww_AxNm4gdV2t5TuYxHA++zSg@mail.gmail.com>
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

On Tue, Oct 1, 2019 at 10:01 PM Julia Lawall <julia.lawall@lip6.fr> wrote:
> > diff --git a/scripts/coccinelle/misc/add_namespace.cocci b/scripts/coccinelle/misc/add_namespace.cocci
> > index c832bb6445a8..99e93a6c2e24 100644
> > --- a/scripts/coccinelle/misc/add_namespace.cocci
> > +++ b/scripts/coccinelle/misc/add_namespace.cocci
> > @@ -6,6 +6,8 @@
> >  /// add a missing namespace tag to a module source file.
> >  ///
> >
> > +virtual report
> > +
> >  @has_ns_import@
> >  declarer name MODULE_IMPORT_NS;
> >  identifier virtual.ns;
> >
> >
> >
> > Adding virtual report make the coccicheck go ahead smoothly.
>
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>
>


Was this patch posted somewhere?



-- 
Best Regards
Masahiro Yamada
