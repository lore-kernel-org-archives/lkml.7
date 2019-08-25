Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3D8C3A59E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 01:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00D95205C9
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 01:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="m5vQdDBV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbfHYBfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 21:35:46 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:54903 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbfHYBfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 21:35:46 -0400
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x7P1ZYEN023349;
        Sun, 25 Aug 2019 10:35:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x7P1ZYEN023349
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566696935;
        bh=OpRvhuRH68ASL9MC0ScI0w+3eBuQHdBQJqkQRbLn2+I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m5vQdDBVBltKGZxBXxjeKQCIfZ5iD3J8weg+6tc33iVqN6OCa7xv9Dl5XLMXmCNwW
         C/3Osi6b6pTtXtzybqroPLdtVMCUzAlQzr4Ddtgn85MU4oDDerHkuijtmA5NhLuGrO
         BnkS6Gjs/xI0lakYYdFhxY+W/xad4vVfYTUwrjspuYwJDXf3EyJz6KRe2N2l9B5P4o
         ElJGGwHMGmQyDr1txv6nPfFXTcUXCNeN2woesAI5IAOJ+ZqzC4WSPKIbuPW665uirF
         sEYLMGlVwx0M4eteG1LJgIoyMaO94JOFAGEmRtuxEQKR/W2CGJpmZBwvQbjbMI8V+M
         bgCCjwp+5i4hA==
X-Nifty-SrcIP: [209.85.222.48]
Received: by mail-ua1-f48.google.com with SMTP id b2so3201413uak.3;
        Sat, 24 Aug 2019 18:35:34 -0700 (PDT)
X-Gm-Message-State: APjAAAXtUFqcpbwJNyhyMlb26tPNpYxdI0Zmlb4191DZmCWalCaEXUUz
        A0aEm/iI8CVJCPEIjA60/VW4gYZZ+jiH/KOzo9U=
X-Google-Smtp-Source: APXvYqw2XfZWHXx4lllQ4mQGMyqo7CKbkbWJ0BX0afI4yxsmkaVVhBsA6J2cIyjgO7AH5sLDthaiJBt1ysGpo05LRvU=
X-Received: by 2002:ab0:32d8:: with SMTP id f24mr5972124uao.121.1566696933668;
 Sat, 24 Aug 2019 18:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190819041807.11433-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190819041807.11433-1-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 25 Aug 2019 10:34:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS9UoQYsreSSW4EJ4JtQengZ8VQtUO_PWGZC3O9axiT0A@mail.gmail.com>
Message-ID: <CAK7LNAS9UoQYsreSSW4EJ4JtQengZ8VQtUO_PWGZC3O9axiT0A@mail.gmail.com>
Subject: Re: [PATCH] .gitignore: ignore modules.order explicitly
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 1:18 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> The pattern '*.order' was added by commit c6025f4c8bbe ("kbuild: ignore
> *.order files") to ignore modules.order files.
>
> I do not see any other user of the '.order' extension.
>
> Ignore 'modules.order' explicitly instead of '*.order'.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to linux-kbuild.




> ---
>
>  .gitignore | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/.gitignore b/.gitignore
> index 2030c7a4d2f8..ce2c6348d372 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -34,7 +34,6 @@
>  *.mod.c
>  *.o
>  *.o.*
> -*.order
>  *.patch
>  *.s
>  *.so
> @@ -46,6 +45,7 @@
>  *.xz
>  Module.symvers
>  modules.builtin
> +modules.order
>
>  #
>  # Top-level generic files
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
