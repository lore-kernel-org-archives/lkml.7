Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42A6C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 14:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3EE920850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 14:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Cxh/P7Po"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfDKOY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 10:24:59 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:61880 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfDKOY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 10:24:58 -0400
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x3BEOrFb017487;
        Thu, 11 Apr 2019 23:24:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x3BEOrFb017487
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554992694;
        bh=+1aaN2g5fGIPYt15Gmzb0ZZaU/lOwLJRq+hcEmAcUUY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Cxh/P7PoQAEdldkAasOyvg2p41VfTLFL6c65bxy+otOwSIXASDTA5B6RW/VIqP7V2
         s700BYRaa4BWrjcB0Z9+dgFWWcWNfiR92BIdHciWHc6Fn3C3ZOl13Ui9QI7cd9bsso
         OiqY5c5a629cyNAk56ZmUbg0Q3DmFbUcFghZ+ycu6qSlcEMNcJ/+c4Dq43o2Gi7xC0
         X2WwGNcYn8vGQFzRlodeQ24P+DrGu2yQ7nXLQvVTA1loNlh2hn+SiWjXdJhEEYHIaQ
         ngXFC4HMG+7lwri5S8oLPrIG5P2kurm4OXweFTLoHo3FPJYQd/jGo/D8cUPWOGhLAN
         VhdTecv9BjFAw==
X-Nifty-SrcIP: [209.85.217.45]
Received: by mail-vs1-f45.google.com with SMTP id a190so3600588vsd.0;
        Thu, 11 Apr 2019 07:24:54 -0700 (PDT)
X-Gm-Message-State: APjAAAWPQuHjnjrCQmhQd41WBAZIZFvXpk9WAk6DHCq4mYkoEZvRAeXj
        dDIMFzdxyYE1yhvY965A8xkpaHTW5tf3SeUWXAA=
X-Google-Smtp-Source: APXvYqw2Pak4Wm0rPBRo9+17F8EAI0l5I8adikX9qm5nj5XZWYkCDWSEzbZDVQWXvcBUuczgHSVHL42lfgfkxN+KWeY=
X-Received: by 2002:a67:fbcc:: with SMTP id o12mr29256418vsr.60.1554992693153;
 Thu, 11 Apr 2019 07:24:53 -0700 (PDT)
MIME-Version: 1.0
References: <1554631398-29297-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1554631398-29297-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 11 Apr 2019 23:24:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNATZOhGAF0d5fvwHb4ATYYdtkmZNjtSMvcM+bv8CsPWfhw@mail.gmail.com>
Message-ID: <CAK7LNATZOhGAF0d5fvwHb4ATYYdtkmZNjtSMvcM+bv8CsPWfhw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: remove unneeded dependency for include/config/kernel.release
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 7, 2019 at 7:03 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> This is unneeded since commit 43fee2b23895 ("kbuild: do not redirect
> the first prerequisite for filechk").
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to linux-kbuild.


> ---
>
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 895022b..10643c3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1067,7 +1067,7 @@ filechk_kernel.release = \
>         echo "$(KERNELVERSION)$$($(CONFIG_SHELL) $(srctree)/scripts/setlocalversion $(srctree))"
>
>  # Store (new) KERNELRELEASE string in include/config/kernel.release
> -include/config/kernel.release: $(srctree)/Makefile FORCE
> +include/config/kernel.release: FORCE
>         $(call filechk,kernel.release)
>
>  # Additional helpers built in scripts/
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
