Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B0BC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 02:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4732A205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 02:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Ip3T/FmO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbfHACvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 22:51:22 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:48880 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfHACvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 22:51:21 -0400
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x712pDvX024730
        for <linux-kernel@vger.kernel.org>; Thu, 1 Aug 2019 11:51:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x712pDvX024730
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1564627874;
        bh=6TJM9VDYF9EtQNeGWDC4vgS6nHe+nk5JsaYmJiVXyBI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ip3T/FmOcMM0Xe1G9kF0kVoTwbrk8BewSMJnPxRispVgtY50AhB8uFI3rOG3M9/QM
         XLjmSx3URsrphsgwvgQdUY57MfeEMzr8IKvwp2zJljTdnoCYQ/FTmf/AqqA90Mq5CE
         Rc/shGko8O6Sozs4Pnx9H0Wd/zCHvt4HvA4Lav7j6IoMWkHTd9w80ZWJqStvYT8nhj
         TpiwvOOmJy8UalIPDjzobDQqg6bSLmAnMSbMQLF0SY7nAtoXj2AWy0NJXLOGP3jbaU
         mzSot8oistN5lDod77IzhazhuL2o27wHMpat6HsD6Xb9wHOHYk8H5pZHZ9mZIM+kHS
         qyumrdtP1ZZDQ==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id 2so47771454vso.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 19:51:13 -0700 (PDT)
X-Gm-Message-State: APjAAAXBrmW+T8baILD1sT6AzUDhnorG+VJ4Nr3P9hgvLfqgsobVGKnj
        C/U9KdjE58CRiRYEHhr8BsydGg9YSrmVXhPcyAY=
X-Google-Smtp-Source: APXvYqwHhHB2zdOBNLzdxW0bRxUMu2FfZ44yc107C8w3WGao4L0NcTxQPnTBuBwfLpd397ee2X7kKqxcaDQTatWMN2E=
X-Received: by 2002:a67:d46:: with SMTP id 67mr81172763vsn.181.1564627872707;
 Wed, 31 Jul 2019 19:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <0306bec0ec270b01b09441da3200252396abed27.camel@perches.com> <20190731190309.19909-1-rikard.falkeborn@gmail.com>
In-Reply-To: <20190731190309.19909-1-rikard.falkeborn@gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 1 Aug 2019 11:50:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT2r8J+4C8bAPDZ1R4Xk7Psr+fAS9wcs_c+JhuUqj-uAw@mail.gmail.com>
Message-ID: <CAK7LNAT2r8J+4C8bAPDZ1R4Xk7Psr+fAS9wcs_c+JhuUqj-uAw@mail.gmail.com>
Subject: Re: [PATCH] linux/bits.h: Add compile time sanity check of GENMASK inputs
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 1, 2019 at 4:04 AM Rikard Falkeborn
<rikard.falkeborn@gmail.com> wrote:
>
> GENMASK() and GENMASK_ULL() are supposed to be called with the high bit
> as the first argument and the low bit as the second argument. Mixing
> them will return a mask with zero bits set.
>
> Recent commits show getting this wrong is not uncommon, see e.g.
> commit aa4c0c9091b0 ("net: stmmac: Fix misuses of GENMASK macro") and
> commit 9bdd7bb3a844 ("clocksource/drivers/npcm: Fix misuse of GENMASK
> macro").
>
> To prevent such mistakes from appearing again, add compile time sanity
> checking to the arguments of GENMASK() and GENMASK_ULL(). If both the
> arguments are known at compile time, and the low bit is higher than the
> high bit, break the build to detect the mistake immediately.
>
> Since GENMASK() is used in declarations, BUILD_BUG_OR_ZERO() must be
> used instead of BUILD_BUG_ON(), and __is_constexpr() must be used instead
> of __builtin_constant_p().
>
> Commit 95b980d62d52 ("linux/bits.h: make BIT(), GENMASK(), and friends
> available in assembly") made the macros in linux/bits.h available in
> assembly. Since neither BUILD_BUG_OR_ZERO() or __is_constexpr() are asm
> compatible, disable the checks if the file is included in an asm file.
>
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---
> Joe Perches sent a series to fix the existing misuses of GENMASK() that
> needs to be merged before this to avoid build failures. Currently, 7 of
> the patches were not in Linus tree, and 2 were not in linux-next.
>
> Also, there's currently no asm users of bits.h, but since it was made
> asm-compatible just two weeks ago it would be a shame to break it right
> away...
>
>  include/linux/bits.h | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/bits.h b/include/linux/bits.h
> index 669d69441a62..73489579eef9 100644
> --- a/include/linux/bits.h
> +++ b/include/linux/bits.h
> @@ -18,12 +18,22 @@
>   * position @h. For example
>   * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
>   */
> +#ifndef __ASSEMBLY__
> +#include <linux/build_bug.h>
> +#define GENMASK_INPUT_CHECK(h, l)  BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> +               __is_constexpr(h) && __is_constexpr(l), (l) > (h), 0))
> +#else
> +#define GENMASK_INPUT_CHECK(h, l) 0
> +#endif
> +
>  #define GENMASK(h, l) \
> +       (GENMASK_INPUT_CHECK(h, l) + \
>         (((~UL(0)) - (UL(1) << (l)) + 1) & \
> -        (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
> +        (~UL(0) >> (BITS_PER_LONG - 1 - (h)))))
>
>  #define GENMASK_ULL(h, l) \
> +       (GENMASK_INPUT_CHECK(h, l) + \
>         (((~ULL(0)) - (ULL(1) << (l)) + 1) & \
> -        (~ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h))))
> +        (~ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h)))))


This is getting cluttered with so many parentheses.

One way of clean-up is to rename the current macros as follows:

   GENMASK()    ->  __GENMASK()
   GENMASK_UL() ->  __GENMASK_ULL()

Then,

#define GENMASK(h, l)       (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
#define GENMASK_ULL(h, l)   (GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))




-- 
Best Regards
Masahiro Yamada
