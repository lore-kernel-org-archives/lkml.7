Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C5AC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 05:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A9E218A6
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 05:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="JA7eWF6d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfC3FNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 01:13:16 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:39161 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfC3FNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 01:13:15 -0400
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x2U5D8Vg014349;
        Sat, 30 Mar 2019 14:13:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x2U5D8Vg014349
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1553922789;
        bh=t7TyDUY81lBPi6ENn3MikPu7eYnfN/pWe8GuycbfvAs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JA7eWF6diP8J41HXBJjFbmyQWlvQ5WqOcv0JVAC0CH51mkh6D+wKDBhtKLrzAOX5V
         8MFOMCoNgbLSCW7sBruUjsTDbcy8a28fzeqdO/4j8IgJdz6j24i1Ii6SaMDkFpLPpP
         XbkgzKHz7qZzdrpiMv56U8uxd/3bSp21GSLOYQQkx9cAtwu6Xj3vE6ZHPpbTJERLJn
         Z6yz/wv3JVWhpQhgKYG7Qg02L6UcAvLaeSE7WxzR9cL6p271S1PAZ/7alVmzyJBIWK
         g+D3jGn7ntH3Ng3Kp5fkb+oA3A36S+dBS0sjXUCXLiV/DSiUDD2tCRICIfeaU99WY5
         ktHve3GoAcLeA==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id j184so2537111vsd.11;
        Fri, 29 Mar 2019 22:13:09 -0700 (PDT)
X-Gm-Message-State: APjAAAW3K6dzgzMt7MacT5lf/6Z/s92OMtR1eqMXHppMdpjgi4QiIyWp
        ehH1lGjqicnX7bIaZaxrC4Yk8hogslQRxAcqhmM=
X-Google-Smtp-Source: APXvYqye5EL2t2ErpQ2MTBTuMK/Evt8RcNfFRnFt0/CUfflSc96pjFkhLb7cZPi4VVDhavei/DJGRCUO4MEcT1Qwkzo=
X-Received: by 2002:a67:7a43:: with SMTP id v64mr32268528vsc.54.1553922788056;
 Fri, 29 Mar 2019 22:13:08 -0700 (PDT)
MIME-Version: 1.0
References: <1553581936-6476-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1553581936-6476-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 30 Mar 2019 14:12:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNARSXgBOPiSNm6mByTWhijTaxq=Omo5FsEju-_Fbe0uLKw@mail.gmail.com>
Message-ID: <CAK7LNARSXgBOPiSNm6mByTWhijTaxq=Omo5FsEju-_Fbe0uLKw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: fix warning "overriding recipe for target 'Makefile'"
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 3:46 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> If you do "make Makefile" with GNU Make 3.x, the following warning
> is displayed:
>
>   $ make Makefile
>   Makefile:165: warning: overriding recipe for target 'Makefile'
>   Makefile:51: warning: ignoring old recipe for target 'Makefile'
>   make[1]: Nothing to be done for 'Makefile'.
>   make: Nothing to be done for 'Makefile'.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to linux-kbuild.



>
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 70fc778..1b361bd 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -161,7 +161,7 @@ ifeq ($(need-sub-make),1)
>
>  PHONY += $(MAKECMDGOALS) sub-make
>
> -$(filter-out _all sub-make $(CURDIR)/Makefile, $(MAKECMDGOALS)) _all: sub-make
> +$(filter-out _all sub-make $(lastword $(MAKEFILE_LIST)), $(MAKECMDGOALS)) _all: sub-make
>         @:
>
>  # Invoke a second make in the output directory, passing relevant variables
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
