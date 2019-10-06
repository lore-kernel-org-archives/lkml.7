Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14395C47404
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 02:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD74218AC
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 02:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="NMSncqY+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfJFCbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 22:31:10 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:41204 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfJFCbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 22:31:09 -0400
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x962Upd6006790
        for <linux-kernel@vger.kernel.org>; Sun, 6 Oct 2019 11:30:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x962Upd6006790
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1570329052;
        bh=kuS/GKnKklmRpPbyJCs/1Gxnnvpl6N+X6d6FVhIH0Qo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NMSncqY+lYiIafmLeCg29z6tSGWnOQyxBeDOQUCICpmoSO2H+mY3MieP07YEtYz2r
         kcEGoO/zSgshDc1GL257RVEDRF5ow4oVzFwOG/yhfzoBRry73o56uU+n19yfUr92+T
         UVrA32h4EPz0f/vHjEBw4vy9GaH0PwfgIj6kTrmAmgvvulXC39kJ9dfzDNb74kY37I
         u/Jxyeq/J+JWmEEt1bLlvPGN+mtIKCxy1MdNkOuGaCybGUHOMw8a+cbEH1WfjI2vpn
         Gw2q3rYjz4RKVphCJIpF/XMTQgsS/5U96Vrax4ytpr+ZNZy0JJGStzvs9H7Yk33VuF
         yJ3pZQfH7RELg==
X-Nifty-SrcIP: [209.85.221.169]
Received: by mail-vk1-f169.google.com with SMTP id w3so2281700vkm.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 19:30:51 -0700 (PDT)
X-Gm-Message-State: APjAAAUY4tDX6WLAgZnKKNom5jemLlKO8wwad+6aSfTnPlBGrV5STc+o
        ZUNQ1WC1INyFlnLeGJ/iPbd5urzff4Ru5UCMyAI=
X-Google-Smtp-Source: APXvYqx3bSTblZRYno1+Rvd64tc+kjphZrmb8vrW7f9tgdcP/7FB0Zj9I5meeZ8rp53YdnxijfZF1+0ji0xeXyPrkLw=
X-Received: by 2002:a1f:d483:: with SMTP id l125mr11392682vkg.12.1570329050468;
 Sat, 05 Oct 2019 19:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190801230358.4193-1-rikard.falkeborn@gmail.com>
 <20190811184938.1796-1-rikard.falkeborn@gmail.com> <20190811184938.1796-4-rikard.falkeborn@gmail.com>
In-Reply-To: <20190811184938.1796-4-rikard.falkeborn@gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 6 Oct 2019 11:30:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS_ya0LRvheguU678G5YSPQrOk9wTbq+-kVoFdbxR++kA@mail.gmail.com>
Message-ID: <CAK7LNAS_ya0LRvheguU678G5YSPQrOk9wTbq+-kVoFdbxR++kA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] linux/bits.h: Add compile time sanity check of
 GENMASK inputs
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 3:50 AM Rikard Falkeborn
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
> checking to the arguments of GENMASK() and GENMASK_ULL(). If both
> arguments are known at compile time, and the low bit is higher than the
> high bit, break the build to detect the mistake immediately.
>
> Since GENMASK() is used in declarations, BUILD_BUG_ON_ZERO() must be
> used instead of BUILD_BUG_ON().
>
> __builtin_constant_p does not evaluate is argument, it only checks if it
> is a constant or not at compile time, and __builtin_choose_expr does not
> evaluate the expression that is not chosen. Therefore, GENMASK(x++, 0)
> does only evaluate x++ once.
>
> Commit 95b980d62d52 ("linux/bits.h: make BIT(), GENMASK(), and friends
> available in assembly") made the macros in linux/bits.h available in
> assembly. Since BUILD_BUG_OR_ZERO() is not asm compatible, disable the
> checks if the file is included in an asm file.
>
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>


Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>


> ---
> Changes in v3:
>   - Changed back to shorter macro argument names
>   - Remove casts and use 0 instead of UL(0) in GENMASK_INPUT_CHECK(),
>     since all results in GENMASK_INPUT_CHECK() are now ints. Update
>     commit message to reflect that.
>
> Changes in v2:
>   - Add comment about why inputs are not checked when used in asm file
>   - Use UL(0) instead of 0
>   - Extract mask creation in a separate macro to improve readability
>   - Use high and low instead of h and l (part of this was extracted to a
>     separate patch)
>   - Updated commit message
>
> Joe Perches sent a series to fix the existing misuses of GENMASK() that
> needs to be merged before this to avoid build failures. Currently, 5 of
> the patches are not in Linus tree, and 2 are not in linux-next. There is
> also a patch pending by Nathan Chancellor that also needs to be merged
> before this patch is merged to avoid build failures.
>
>  include/linux/bits.h | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/bits.h b/include/linux/bits.h
> index 669d69441a62..4ba0fb609239 100644
> --- a/include/linux/bits.h
> +++ b/include/linux/bits.h
> @@ -18,12 +18,29 @@
>   * position @h. For example
>   * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
>   */
> -#define GENMASK(h, l) \
> +#ifndef __ASSEMBLY__
> +#include <linux/build_bug.h>
> +#define GENMASK_INPUT_CHECK(h, l) \
> +       (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> +               __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> +#else
> +/*
> + * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
> + * disable the input check if that is the case.
> + */
> +#define GENMASK_INPUT_CHECK(h, l) 0
> +#endif
> +
> +#define __GENMASK(h, l) \
>         (((~UL(0)) - (UL(1) << (l)) + 1) & \
>          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
> +#define GENMASK(h, l) \
> +       (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
>
> -#define GENMASK_ULL(h, l) \
> +#define __GENMASK_ULL(h, l) \
>         (((~ULL(0)) - (ULL(1) << (l)) + 1) & \
>          (~ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h))))
> +#define GENMASK_ULL(h, l) \
> +       (GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
>
>  #endif /* __LINUX_BITS_H */
> --
> 2.22.0
>


-- 
Best Regards
Masahiro Yamada
