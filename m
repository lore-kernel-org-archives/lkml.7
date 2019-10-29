Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F34CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 577FB21479
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="YAUcy1Z7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388046AbfJ2Msz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 08:48:55 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:29211 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbfJ2Msw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 08:48:52 -0400
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x9TCmfFx027174
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 21:48:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x9TCmfFx027174
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1572353322;
        bh=ycMbZtUGC8hAeSAW/0e73NsiRHYVtXuSSSSislazCQo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YAUcy1Z7BHMXba9aS3kuTWqBizqxh2nsY6KKf8NqU/9TG693QjR5ULDjRjcvElSX5
         9hT3mLy2Rw33xULiDMG3PH6KeK4EfjHmaK+0AkkCezyfRCuup6N5dny5jlhrIhTn6X
         bI65yK1I+qo82aZPAE593wmgQCG4+fM+2JaHN8FqINCunqwHK2+SwKHQPPmzw3pYZl
         iWCCTbt74GJkAoJPcE/qHpiDL+MISObsQyKctJ7kO0vFGuLwBlFk+C86fmr59KV9uk
         KdZ4EeqdKNng2wgNTbaTjgGkG+UPa7Iull+7lZf1bQsUFYBL1ep34iFskJNzPeafG/
         Iw4Xh3aI/RF8A==
X-Nifty-SrcIP: [209.85.222.52]
Received: by mail-ua1-f52.google.com with SMTP id o3so1995846ual.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 05:48:41 -0700 (PDT)
X-Gm-Message-State: APjAAAVzDgSWsmOFIQldRxz0hoMpBU4JMeXgb/p8oUbxnCIYviiAn5Sw
        e03feQJBV8D924cb8m70pF/Ahj0xRli1E1tUd+w=
X-Google-Smtp-Source: APXvYqwr5SQI/7GdRsDbwEwuTxIFeXAUGqui3bP5McMb++nicmAXwWPWoN0k7BAhA8CV+C1CSgivkmADZo9q3Yux+C4=
X-Received: by 2002:a9f:3e81:: with SMTP id x1mr11462917uai.121.1572353320421;
 Tue, 29 Oct 2019 05:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <20191028151427.31612-1-jeyu@kernel.org>
In-Reply-To: <20191028151427.31612-1-jeyu@kernel.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 29 Oct 2019 21:48:03 +0900
X-Gmail-Original-Message-ID: <CAK7LNASzJEFw7Qo1e7qfNj0prZGrvN-DZs1wLkykaH=J03wXgw@mail.gmail.com>
Message-ID: <CAK7LNASzJEFw7Qo1e7qfNj0prZGrvN-DZs1wLkykaH=J03wXgw@mail.gmail.com>
Subject: Re: [PATCH 1/4] scripts/nsdeps: use $MODORDER to obtain correct
 modules.order path
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Maennich <maennich@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 12:14 AM Jessica Yu <jeyu@kernel.org> wrote:
>
> The nsdeps script calls generate_deps() for every module in the
> modules.order file. It prepends $objtree to obtain the full path of the
> top-level modules.order file. This produces incorrect results when
> calling nsdeps for an external module, as only the ns dependencies for
> in-tree modules listed in $objtree/modules.order are generated rather
> than the ns dependencies for the external module. To fix this, just use
> the MODORDER variable provided by kbuild - it uses the correct path for
> the relevant modules.order file (either in-tree or the one produced by
> the external module build).
>
> Signed-off-by: Jessica Yu <jeyu@kernel.org>
> ---
>
> So, not being too familiar with kbuild, I am not sure if MODORDER was the
> appropriate kbuild variable to use, but I could not find anything else that
> gives us the modules.order path. Masahiro, please let me know if this is
> appropriate usage.

Right, MODORDER allows you to get access to
the right modules.order depending on what you are building
although this patch alone is not useful since nsdeps does not work with
external modules.



>  scripts/nsdeps | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/nsdeps b/scripts/nsdeps
> index dda6fbac016e..54d2ab8f9e5c 100644
> --- a/scripts/nsdeps
> +++ b/scripts/nsdeps
> @@ -52,7 +52,7 @@ generate_deps() {
>         done
>  }
>
> -for f in `cat $objtree/modules.order`; do
> +for f in `cat $MODORDER`; do
>         generate_deps $f
>  done
>
> --
> 2.16.4
>


--
Best Regards
Masahiro Yamada
