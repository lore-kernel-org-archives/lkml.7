Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E25C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 00:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5200320878
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 00:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="juG6XlKZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbfDZAli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 20:41:38 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:52272 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfDZAlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 20:41:37 -0400
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x3Q0fM9e006091;
        Fri, 26 Apr 2019 09:41:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x3Q0fM9e006091
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1556239283;
        bh=B2BY+4uy73OfVMbPyRb8bs4BvjcV9oPqEcBy0fGq99A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=juG6XlKZx3lIQNmlQF9PS7qnZuZSJL8tLifhJXz8TTBPSYU0gdx3IPF0UFgUHZeAm
         fojaDuc3P65aZmmU5YYYIw4D+yNX1ZhuKj5k7X9N4/dinXZNHnRZX9Bhe2WuWw38pN
         ZXPoAIx9zklyKuSIVzdSWZY52wIpVubhqytpiEa1VOjzyzcvScNMYGMOXFfu3xdmhq
         7IKmqscYn2e82GiZTgbXgz0wum6ZZR0NJgViDR6gQzxv1RpDVgP7IOKkDqCHBYYKuy
         4/z+qb/Tp3Y7w/gKQL79+QX2SqNpcV9k61tOU+nigk7DQwZireH9QzFPU66GoPGPXM
         FZtiYblpQn3vQ==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id t23so950060vso.10;
        Thu, 25 Apr 2019 17:41:23 -0700 (PDT)
X-Gm-Message-State: APjAAAWbTUCJOY1Lfha7pEaXqClix8mJlMHxht6Dfe9QcyXeB731ENM4
        5kwAn2DsuatjNHQNvQF2xjtCzTMIg2N08kxrcVc=
X-Google-Smtp-Source: APXvYqzrvI62wAyV3oztFTcHZnYotQQXzdfnfZ8pfvebs68g2Ue5temtL2tlvSYuWGmEjw19B7nv02QGC82Gb3dzSGs=
X-Received: by 2002:a67:7a43:: with SMTP id v64mr23427590vsc.54.1556239282077;
 Thu, 25 Apr 2019 17:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <1554280344-10741-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1554280344-10741-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 26 Apr 2019 09:40:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQL0GFHRkYmvTT=Oa8PPkF0FBdgUK_BUQvjwrwNRBEBnQ@mail.gmail.com>
Message-ID: <CAK7LNAQL0GFHRkYmvTT=Oa8PPkF0FBdgUK_BUQvjwrwNRBEBnQ@mail.gmail.com>
Subject: Re: [PATCH] sparc: vdso: add FORCE to the build rule of %.so
To:     "David S . Miller" <davem@davemloft.net>,
        sparclinux <sparclinux@vger.kernel.org>
Cc:     "ndesaulniers@google.com" <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,


On Wed, Apr 3, 2019 at 5:34 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> $(call if_changed,...) must have FORCE as a prerequisite.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Ping?


>  arch/sparc/vdso/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
> index 74e97f7..83c4b46 100644
> --- a/arch/sparc/vdso/Makefile
> +++ b/arch/sparc/vdso/Makefile
> @@ -68,7 +68,7 @@ CFLAGS_REMOVE_vdso-note.o = -pg
>  CFLAGS_REMOVE_vclock_gettime.o = -pg
>
>  $(obj)/%.so: OBJCOPYFLAGS := -S
> -$(obj)/%.so: $(obj)/%.so.dbg
> +$(obj)/%.so: $(obj)/%.so.dbg FORCE
>         $(call if_changed,objcopy)
>
>  CPPFLAGS_vdso32.lds = $(CPPFLAGS_vdso.lds)
> --
> 2.7.4
>


--
Best Regards
Masahiro Yamada
