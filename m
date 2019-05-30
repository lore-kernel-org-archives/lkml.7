Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AE3C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 23:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A4A6262C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 23:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mc8IVN+J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfE3XAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 19:00:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37535 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfE3XAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 19:00:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id a23so4903493pff.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 16:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J3Ml1kVDfcGNXRU8AMdpUqA4MON/FUbb6KbQvnG2TAY=;
        b=Mc8IVN+Jet472ysNby9MRU/0w5bKhDiKU1ycaA76ZU/WvYmTz7sKUGtHPAKH9XKKSH
         x4icaO4oUeyANR1j313ji8wynv9/sYM+cUvppQG2TsRXbkwgPV5GaUX7DVgXUh5kf1g5
         iJ5Un2qIVCDon0Xtc3QkyM65CA0t93sesy6Y/ApOimfCK7G3oTMIz9nuZ18kzHjI59N2
         fTjHSHnELbvtgIe/DxhTQn11QaRPliYD5s/2HL8srtLfhrdcy7yh36ifrSS7/5xoIxHH
         dTjHcURfUTD88d+2ZZM33lXC3xPuAv02x2Q176F8Co4hQ8RGJG6jWviV0Nw70X20+gw3
         Bprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J3Ml1kVDfcGNXRU8AMdpUqA4MON/FUbb6KbQvnG2TAY=;
        b=rki5wba+dbc6dGbBG9mn5gqfqVH//U2YVNPlCFbocJot2SdcoGDFI0zJNSxOe9UkOW
         MZ19aU9tCVMNQg16ftIS6vKW/3EKwupGZGBDrYa7Xl9laCuJ6hoQH9TPgMR3eCesfzuG
         jGHrnZKU8oqx6QFurweWUmdapEBahT3HaxXyZ9LM+0pYV7swCF2NvBxJSiL/Zpdtg5Vb
         yVE/SYLV7M+E/AwOatJC4KYVSlzuMbZEa3yNzWS0fhdR2i4/OYBL4B9sTd6k1gSJrYbV
         CrHhBxIeSiuYGq2waY5ajX60/c0LgpAIRmUJvwDRIPSdCS9cfxTL2x6npMCKB0liFBQI
         X0aQ==
X-Gm-Message-State: APjAAAVFgzx/PUMdKyxn2Q1jQdMmGjOmuiPTA892UBfyFGxrVXRSSkaI
        zaGXkb0NSbqcZniFhGFg38kz2fVxh05vJ9udFsCRbA==
X-Google-Smtp-Source: APXvYqxnliwS0y68lZKpmGnvf7C3CCbfTbvNyAthaZZoO/VviHLzQUhXFyPt+J70SIH4/nMod7UH5Zp975sz1t8EUXI=
X-Received: by 2002:a17:90a:2308:: with SMTP id f8mr5548309pje.123.1559257223506;
 Thu, 30 May 2019 16:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190528235742.105510-1-natechancellor@gmail.com>
In-Reply-To: <20190528235742.105510-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 30 May 2019 16:00:12 -0700
Message-ID: <CAKwvOdngj29-W-FvUVtqgrkDof_oDU6+Z9kTbyha=OZi_XAKJQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: xor-neon: Replace __GNUC__ checks with CONFIG_CC_IS_GCC
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Stefan Agner <stefan@agner.ch>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 4:57 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Currently, when compiling this code with clang, the following warning is
> emitted:
>
>     CC      arch/arm/lib/xor-neon.o
>   arch/arm/lib/xor-neon.c:33:2: warning: This code requires at least
>   version 4.6 of GCC [-W#warnings]
>
> This is because clang poses as GCC 4.2.1 with its __GNUC__ conditionals
> for glibc compatibility[1]:
>
> $ echo | clang -dM -E -x c /dev/null | grep GNUC | awk '{print $2" "$3}'
> __GNUC_MINOR__ 2
> __GNUC_PATCHLEVEL__ 1
> __GNUC_STDC_INLINE__ 1
> __GNUC__ 4
>
> As pointed out by Ard Biesheuvel and Arnd Bergmann in an earlier
> thread[2], the oldest version of GCC that is currently supported is gcc
> 4.6 after commit cafa0010cd51 ("Raise the minimum required gcc version
> to 4.6") so we do not need to check for anything older anymore.
>
> However, just removing the version check is not enough to silence clang
> because it does not recognize '#pragma GCC optimize':
>
>   arch/arm/lib/xor-neon.c:25:13: warning: unknown pragma ignored
>   [-Wunknown-pragmas]
>   #pragma GCC optimize "tree-vectorize"
>
> Looking into it further, -ftree-vectorize (which '#pragma GCC optimize
> "tree-vectorize"' enables) is an alias in clang for -fvectorize[3],
> which according to the documentation is on by default[4] (at least at
> -O2 or -Os).
>
> Just add the pragma when compiling with GCC so that clang does not
> unnecessarily warn.
>
> [1]: https://reviews.llvm.org/D51011#1206981
> [2]: https://lore.kernel.org/lkml/CAK8P3a3NjTCgFd2dQ9KbHP8DpXf6s-ULfeU6acAYC4SDi+2qvw@mail.gmail.com/
> [3]: https://github.com/llvm/llvm-project/blob/eafe8ef6f2b44ba/clang/include/clang/Driver/Options.td#L1729
> [4]: https://llvm.org/docs/Vectorizers.html#usage
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/496
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

LGTM, thanks Nathan.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/arm/lib/xor-neon.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c
> index c691b901092f..d532bc072ee4 100644
> --- a/arch/arm/lib/xor-neon.c
> +++ b/arch/arm/lib/xor-neon.c
> @@ -22,15 +22,8 @@ MODULE_LICENSE("GPL");
>   * -ftree-vectorize) to attempt to exploit implicit parallelism and emit
>   * NEON instructions.
>   */
> -#if __GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 6)
> +#ifdef CONFIG_CC_IS_GCC
>  #pragma GCC optimize "tree-vectorize"
> -#else
> -/*
> - * While older versions of GCC do not generate incorrect code, they fail to
> - * recognize the parallel nature of these functions, and emit plain ARM code,
> - * which is known to be slower than the optimized ARM code in asm-arm/xor.h.
> - */
> -#warning This code requires at least version 4.6 of GCC
>  #endif
>
>  #pragma GCC diagnostic ignored "-Wunused-variable"
> --
> 2.22.0.rc1
>


-- 
Thanks,
~Nick Desaulniers
