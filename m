Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53110C4740A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 02:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E65FC222C8
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 02:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="wVKBzv/i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfJFC1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 22:27:07 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:26134 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfJFC1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 22:27:06 -0400
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x962R0ZZ019679
        for <linux-kernel@vger.kernel.org>; Sun, 6 Oct 2019 11:27:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x962R0ZZ019679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1570328821;
        bh=Zwa7ZYrRM42iQB+mkyBG2Fb39lSv6+kwOgrD7wa5OmY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wVKBzv/iOZks4ISSt6WX9U4IyGCE4oVlRwVe9645VpGmw3O605wo3mGLuAzEW9wXc
         2nZYjiHt0D9f+mZFqJBxNrTL2v2NWZTD1DtA2lkAW8pl3oGgO1cFNBLoD30bzScHZK
         5eskc36ax7oSkdWyRlVxCP7r2gBuHLCnqaN1Dd1lp6MiIvia6mgYBlJusciZOSqLhL
         NSWoHu8Tyj/NWfb3jyppDHAckFJHNz17fbae8duDsEgqOJPgmWF+KFGfBttzu3rJGF
         SKmc2jWDB9V5AQFsv1379/l2SmQ6h48ReDxeBucjr3qu9kiMuAz47b/mm5Vwr3sz3o
         4UwuK5XUwCsfg==
X-Nifty-SrcIP: [209.85.221.175]
Received: by mail-vk1-f175.google.com with SMTP id q25so2253333vkn.12
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 19:27:00 -0700 (PDT)
X-Gm-Message-State: APjAAAUzUAQjej9To0ZmNgcMz3FFdebY5fqFsFdXxSdWDfQ5TAdQUhwp
        0ddjnq/1jskcCwqcdn1W3DWCK7BzE3dPYVapCMQ=
X-Google-Smtp-Source: APXvYqxAcl3ui4KK4AcJ5t15tFYtaN1Gx1mYNOs1pfEznTUT7Se1kAV8xawW66Hv2AU8XCaMf2zCJ44PSRZPEjuS9Fg=
X-Received: by 2002:a1f:5f51:: with SMTP id t78mr11652117vkb.66.1570328819687;
 Sat, 05 Oct 2019 19:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190801230358.4193-1-rikard.falkeborn@gmail.com>
 <20190811184938.1796-1-rikard.falkeborn@gmail.com> <20190811184938.1796-3-rikard.falkeborn@gmail.com>
In-Reply-To: <20190811184938.1796-3-rikard.falkeborn@gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 6 Oct 2019 11:26:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNARvyRgPWVzbG_9xoJUebJx46phwEp9-nJFVQYYZBsxJdw@mail.gmail.com>
Message-ID: <CAK7LNARvyRgPWVzbG_9xoJUebJx46phwEp9-nJFVQYYZBsxJdw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] linux/build_bug.h: Change type to int
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 3:50 AM Rikard Falkeborn
<rikard.falkeborn@gmail.com> wrote:
>
> Having BUILD_BUG_ON_ZERO produce a value of type size_t leads to awkward
> casts in cases where the result needs to be signed, or of smaller type
> than size_t. To avoid this, cast the value to int instead and rely on
> implicit type conversions when a larger or unsigned type is needed.
>
> Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>

> Changes in v3:
>   - This patch is new in v3
>
>  include/linux/build_bug.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/build_bug.h b/include/linux/build_bug.h
> index 0fe5426f2bdc..e3a0be2c90ad 100644
> --- a/include/linux/build_bug.h
> +++ b/include/linux/build_bug.h
> @@ -9,11 +9,11 @@
>  #else /* __CHECKER__ */
>  /*
>   * Force a compilation error if condition is true, but also produce a
> - * result (of value 0 and type size_t), so the expression can be used
> + * result (of value 0 and type int), so the expression can be used
>   * e.g. in a structure initializer (or where-ever else comma expressions
>   * aren't permitted).
>   */
> -#define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:(-!!(e)); }))
> +#define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
>  #endif /* __CHECKER__ */
>
>  /* Force a compilation error if a constant expression is not a power of 2 */
> --
> 2.22.0
>


-- 
Best Regards
Masahiro Yamada
