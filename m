Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55438C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 12:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F3B82084F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 12:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="tMBcI+9p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbfIKMWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 08:22:36 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:43591 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbfIKMWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 08:22:36 -0400
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x8BCMJ2M020161
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 21:22:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x8BCMJ2M020161
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1568204540;
        bh=CVh/5EnZyxNyamVX+P7ZAjgLLbsfL+GIO+jUVTk44yE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tMBcI+9pCDKjlr/m6niHSn3MsRRRlFojc9WCle5gyjR+lCmEzDKFgWHwMHJ1udsmL
         qnNzf7N7sVt9iTCaRX59E1z7iR5zvuFVigmXc2EMUxfrF2beIbzOpLh3ipKCPePdtW
         k6BqeS8sdwRGj4L7A2XQ8A1kfZRsFux2pxwfAb7JwR/oVT5T8ThoJXgkHWfo4JEyW5
         zHGvlT6kphoRqRI41Jk0FOwkE1RHbioacBdGB5DRDYfcTETDqalW0ajZlVL9+FtJki
         l1t5ru/kgwaQoddJN59gjHNSCkKJWRyYgQed6c99GtQsas+Nn9cKUvpEjQ3KwgvwGw
         wji7ZYjtbX4Nw==
X-Nifty-SrcIP: [209.85.217.52]
Received: by mail-vs1-f52.google.com with SMTP id y62so13557962vsb.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 05:22:20 -0700 (PDT)
X-Gm-Message-State: APjAAAVcnd5KFrSr/AAONjuzOmT9gZWin2TPz74k0BhzKLiq5Mg+Ck3C
        KtVFf53ZMwu9fKOeLubvVL3jHAoaFxLPx5rJ84Y=
X-Google-Smtp-Source: APXvYqwY32PG1UjsfS36XubSd3rbCs8Nt70vUerGMDswZg6dZ49BVVzOES6GjPIt/QmeqFOYjOjHflvflYoUSK3VdJE=
X-Received: by 2002:a67:1a41:: with SMTP id a62mr20356117vsa.54.1568204539234;
 Wed, 11 Sep 2019 05:22:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190909110408.21832-1-yamada.masahiro@socionext.com> <20190911114559.GA6189@linux-8ccs.fritz.box>
In-Reply-To: <20190911114559.GA6189@linux-8ccs.fritz.box>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 11 Sep 2019 21:21:42 +0900
X-Gmail-Original-Message-ID: <CAK7LNATn3Gde_52uhv683_tWPrL3amHAbc5g-_WyHRR7TVh9sw@mail.gmail.com>
Message-ID: <CAK7LNATn3Gde_52uhv683_tWPrL3amHAbc5g-_WyHRR7TVh9sw@mail.gmail.com>
Subject: Re: [PATCH 1/2] module: remove redundant 'depends on MODULES'
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 8:46 PM Jessica Yu <jeyu@kernel.org> wrote:
>
> +++ Masahiro Yamada [09/09/19 20:04 +0900]:
> >These are located in the 'if MODULES' ... 'endif' block.
> >
> >Remove the redundant dependencies.
> >
> >Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Acked-by: Jessica Yu <jeyu@kernel.org>
>

Could you queue these two patches to your tree?

Thanks.


--
Best Regards

Masahiro Yamada
