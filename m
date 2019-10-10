Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B8BC47404
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 02:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682ED206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 02:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ubZZhCQg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732659AbfJJCZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 22:25:09 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:32086 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfJJCZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 22:25:08 -0400
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x9A2P043031114
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 11:25:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x9A2P043031114
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1570674301;
        bh=uAYAlfm4I1nuexyDN7gOVUdZQWvIy84+ATaXpAvlJI4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ubZZhCQga6eTUmSm6lVevSCPPlLS9xjbohJljRiDmwO5dXhugLcPuxtiMiIP2tz6n
         hy4NEAnJ9Sd1nT/2rRywjbA8tWpURZJFq96c61sWwnyA8Jwx0vzJP5f5B3sMjzPLwg
         TWURmkctSyinFGAiYbUmItws4+5ujpwbvkGX/HoHHCG6AfgU7e3tHCVzZAFTqB54zB
         z1rNtbvEL48VmxLrGLpiC4RBHu893Rd68IBdxHUF1BCA+JhvJYqVVs0iCYRGqYEIn7
         2r1STnUpB/YoF13vhNFzN56QNFA034FuZLY53n9nnKWl8QU9noIlPF965w5aIvOCt6
         tBnx9/yfRNOQQ==
X-Nifty-SrcIP: [209.85.217.46]
Received: by mail-vs1-f46.google.com with SMTP id w195so2862225vsw.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 19:25:00 -0700 (PDT)
X-Gm-Message-State: APjAAAUrXWn5lKPzVhdyEnLUZhvzEIz4FbBftDsrk0xbn3xaqczjhyb7
        DyEl417WDUl6WYQT1vKVapzAo2sdy7oIXOFYClM=
X-Google-Smtp-Source: APXvYqwssDuxB9ZpZp9504VgABsJ5XwuyUqMbmaC2qDT8E2b8FltAisFnRI5dPw1JVsHMKXVp22c9OlQChyZ/3eePN8=
X-Received: by 2002:a67:ff14:: with SMTP id v20mr3832680vsp.215.1570674299760;
 Wed, 09 Oct 2019 19:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190811184938.1796-1-rikard.falkeborn@gmail.com>
 <20191009214502.637875-1-rikard.falkeborn@gmail.com> <20191009214502.637875-3-rikard.falkeborn@gmail.com>
In-Reply-To: <20191009214502.637875-3-rikard.falkeborn@gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 10 Oct 2019 11:24:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNARmYFxoWJqkSO+Fd9PkxoisU3ri=yULjvb6_XsZzh07hg@mail.gmail.com>
Message-ID: <CAK7LNARmYFxoWJqkSO+Fd9PkxoisU3ri=yULjvb6_XsZzh07hg@mail.gmail.com>
Subject: Re: [Patch v4 2/2] linux/bits.h: Add compile time sanity check of
 GENMASK inputs
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>, Joe Perches <joe@perches.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Haren Myneni <haren@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 6:45 AM Rikard Falkeborn
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
> Due to bugs in GCC versions before 4.9 [0], disable the check if
> building with a too old GCC compiler.
>
> [0]: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=19449
>
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>



> ---
> Geert, can you check if this works better? I do not have gcc 4.6-4.8
> readily installed.
>
> Kees, Masahiro, since I changed this patch, I didn't include your
> reviewed-by tags.
>
> Changes in v4:
>   - Disable the argument check for GCC < 4.9 due to a compiler bug.
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
> Joe Perches sent a series to fix the existing misuses of GENMASK().
> Those patches have been merged into Linus tree except two places where
> the GENMASK misuse is in unused macros, which will not fail to build.
> There was also a patch by Nathan Chancellor that have now been merged.
>
>  include/linux/bits.h | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/bits.h b/include/linux/bits.h
> index 669d69441a62..f108302a3121 100644
> --- a/include/linux/bits.h
> +++ b/include/linux/bits.h
> @@ -18,12 +18,30 @@
>   * position @h. For example
>   * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
>   */
> -#define GENMASK(h, l) \
> +#if !defined(__ASSEMBLY__) && \
> +       (!defined(CONFIG_CC_IS_GCC) || CONFIG_GCC_VERSION >= 49000)
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
> 2.23.0
>


-- 
Best Regards
Masahiro Yamada
