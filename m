Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FD5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A232133F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OqF4J2Qd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfCRSJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 14:09:22 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32880 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfCRSJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 14:09:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id i19so11819433pfd.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 11:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wc4IBKZzoFUmNxqwDBjREywNh5yvAGOoUY7N9ja6+hM=;
        b=OqF4J2QdVlFX4h5Bafo5NX+njt6tGaePpnocmZVcU/B5Pf7dKOI2d7dlj3MYo7salc
         M++KFHQUXGUVBV1e01UMZjzZkLuT9IZThj8Ctp4saEy0YmefVqPT8xkWI8RiIgWhbVrI
         I+LfpUxwihQFZx207sDYGGEkErp+1oPk3J1wrahKFw4V9q6EuX7fKPA4/qXPXBPKuWAZ
         HbmVcSFpp87QnMdBgmodmqHpQEs2U3BjuG8iaucxEmO89IurBJDr9lDGzC8ubfYIkEOg
         QJuSU88DtwEkBhnjaMv4i+70nf75g0PsR2YC4nCutBFl8YVQ9rfoLtS0W0FCFHhPjr9+
         yasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wc4IBKZzoFUmNxqwDBjREywNh5yvAGOoUY7N9ja6+hM=;
        b=bibqZrB9q83TbzC/+okKymZQFXqwO3Ra74DaW+4Tm9SDjMvqzoZO5kruG9SSkM3ZXo
         SvVL1oMAxyAVvEojjtP+Eq8i8GgpnXv7jzQ5dOlXMqKm3jRZVjAMkReC3Y+g4VdE4KSX
         3kUGJSG8ECJnid2hJwvF82R96YhCAdfYMUuAJJ+G7gf8oSmfx4NEWOWHTjBhaNMSchFM
         UR4VflE4he/uckQNU/DQ2sA8NZl4wCqkAZOlClUeVSLpkFXr/psV60xOMz+KmDqlRH84
         ZTHcXO09m3hAmgayzyNYcTQ29cLoMU5xQOfNJvxvkNRkSEY8A3Zs2P/xh7rCy2M234g5
         7dew==
X-Gm-Message-State: APjAAAWZ5ygQRU2gprwhQxEe3HXF27UIVSZsfu3spUO6ruVxzTITu/4r
        JcItXLeDeBZUyWmk7HQ3EiE0f0I5w1dKfYCB/MNPuA==
X-Google-Smtp-Source: APXvYqyE7OPBvM4fHYCTOJYbl2/Bcz4Xte8Gt4zbIxBemUiPWGJgFWRwWxgZ4f8UBvvt7qRUMGJg9ypeFje/BfSCX98=
X-Received: by 2002:a63:c511:: with SMTP id f17mr18822980pgd.202.1552932561279;
 Mon, 18 Mar 2019 11:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <e3f3bf27430712ee88c0b600f3d62cb86d327b75.1552863571.git.stefan@agner.ch>
In-Reply-To: <e3f3bf27430712ee88c0b600f3d62cb86d327b75.1552863571.git.stefan@agner.ch>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 18 Mar 2019 11:09:10 -0700
Message-ID: <CAKwvOdnE93+TGwxNiKRdksZseKP_-qF2D=2dUWE_bRX_FpQLmg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ARM: drop WASM to work around LLVM issue
To:     Stefan Agner <stefan@agner.ch>
Cc:     Russell King <linux@armlinux.org.uk>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        julien.thierry@arm.com, Mark Rutland <mark.rutland@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 4:05 PM Stefan Agner <stefan@agner.ch> wrote:
>
> Currently LLVM's integrated assembler does not recognize .w form
> of the pld instructions (LLVM Bug 40972 [0]):
>
>   ./arch/arm/include/asm/processor.h:133:5: error: invalid instruction
>                           "pldw.w\t%a0 \n"
>                            ^
>   <inline asm>:2:1: note: instantiated into assembly here
>   pldw.w  [r0]
>   ^
>   1 error generated.
>
> The W macro for generating wide instructions when targeting Thumb-2
> is not strictly required for the preload data instructions (pld, pldw)
> since they are only available as wide instructions. The GNU assembler
> works with or without the .w appended when compiling an Thumb-2 kernel.
>
> Drop the macro to work around LLVM Bug 40972 issue.
>
> [0] https://bugs.llvm.org/show_bug.cgi?id=40972
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Thanks for the bug report and patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Just curious, there are only 3 other expansion sites of this macro.
Are any of those problematic?  Looks like nop.w, sev.w and b.w?

> ---
> Changes in v2:
> - Reword commit message to reflect the fact that this is a work around
>   for LLVM.
>
>  arch/arm/include/asm/processor.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
> index 57fe73ea0f72..5d06f75ffad4 100644
> --- a/arch/arm/include/asm/processor.h
> +++ b/arch/arm/include/asm/processor.h
> @@ -135,8 +135,8 @@ static inline void prefetchw(const void *ptr)
>         __asm__ __volatile__(
>                 ".arch_extension        mp\n"
>                 __ALT_SMP_ASM(
> -                       WASM(pldw)              "\t%a0",
> -                       WASM(pld)               "\t%a0"
> +                       "pldw\t%a0",
> +                       "pld\t%a0"
>                 )
>                 :: "p" (ptr));
>  }
> --
> 2.21.0
>


-- 
Thanks,
~Nick Desaulniers
