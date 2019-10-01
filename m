Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699DFC388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 09:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DC07215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 09:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="0GyxRT2L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbfJAJlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 05:41:10 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:55733 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbfJAJlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 05:41:10 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x919f20O011246
        for <linux-kernel@vger.kernel.org>; Tue, 1 Oct 2019 18:41:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x919f20O011246
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1569922863;
        bh=z8ce72/SMhyC4NzYpXxLNBlQ7Qfn61j6lff6zp0DVOE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0GyxRT2LzLXiEGk8kojVVJ5Rz/GHgaHl0RTyayGqGY+rYUj4+CLIuTcL4OTbJgDgF
         jZuZfqWqo5VzCAqAvyJPODX8XF+dnaI+9mwtq25PEd6t6m4S+uh8C2i4jl6X340Wya
         vLORtMoeyQqOJapAm35q2n2Ga4dRJ/XeLYRn8Ps8IbVI7mtwsNCYnaZJii7ooqblwF
         xplKIZteg0vuOBHyqg6z7gLVTc2JTN5ra/wGSshmz/SpJtA2oIv3yGsYnGhhHSMXHM
         NMmFcgbW2x+x5g+ENBu3RZfQiWUlZaVshgbcueGFVVSGYaohvH/RkaOFJ7Xa0R6U+Y
         X/+HobsXeYmJw==
X-Nifty-SrcIP: [209.85.160.175]
Received: by mail-qt1-f175.google.com with SMTP id j31so20763208qta.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 02:41:03 -0700 (PDT)
X-Gm-Message-State: APjAAAVH27FZp0OJsRpEA2s3LXdbWyNXQUvD7X8jeLKE1cBC7vUyZHxV
        dQQ6MSdxuq2wJoZLi0qSEUuu2nqvwtZYaZqyyj8=
X-Google-Smtp-Source: APXvYqw4HPSuPHj4nSnk6b30lQH9FYHYECl9wV7YCqH1JINjSAyxWQplenn8GktKxxsyXwcX4liXdofXt2eOLDTzaWc=
X-Received: by 2002:ac8:1639:: with SMTP id p54mr29615937qtj.290.1569922862203;
 Tue, 01 Oct 2019 02:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190930114540.27498-1-will@kernel.org>
In-Reply-To: <20190930114540.27498-1-will@kernel.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 1 Oct 2019 18:40:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNARWkQ-z02RYv3XQ69KkWdmEVaZge07qiYC8_kyMrFzCTg@mail.gmail.com>
Message-ID: <CAK7LNARWkQ-z02RYv3XQ69KkWdmEVaZge07qiYC8_kyMrFzCTg@mail.gmail.com>
Subject: Re: [PATCH] Partially revert "compiler: enable CONFIG_OPTIMIZE_INLINING
 forcibly"
To:     Will Deacon <will@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 8:45 PM Will Deacon <will@kernel.org> wrote:
>
> This reverts commit ac7c3e4ff401b304489a031938dbeaab585bfe0a for ARM and
> arm64.
>
> Building an arm64 kernel with CONFIG_OPTIMIZE_INLINING=y has been shown
> to violate fixed register allocations of local variables passed to
> inline assembly with GCC prior to version 9 which can lead to subtle
> failures at runtime:
>
>   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=91111
>
> A very similar has been reported for 32-bit ARM as well:
>
>   https://lkml.kernel.org/r/f5c221f5749e5768c9f0d909175a14910d349456.camel@suse.de


For reviewers:
The main discussion is here:

https://lore.kernel.org/patchwork/patch/1122097/



> Although GCC 9.1 appears to work for the specific case in the bugzilla
> above, the exact issue has not been root-caused so play safe and disable
> the option for now on these architectures.
>
> Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  lib/Kconfig.debug | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 93d97f9b0157..c37c72adaeff 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -312,6 +312,7 @@ config HEADERS_CHECK
>
>  config OPTIMIZE_INLINING
>         def_bool y
> +       depends on !(ARM || ARM64) # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=91111


This is a too big hammer.

For ARM, it is not a compiler bug, so I am trying to fix the kernel code.

For ARM64, even if it is a compiler bug, you can add __always_inline
to the functions in question.
(arch_atomic64_dec_if_positive in this case).

You do not need to force __always_inline globally.




>         help
>           This option determines if the kernel forces gcc to inline the functions
>           developers have marked 'inline'. Doing so takes away freedom from gcc to
> --
> 2.23.0.444.g18eeb5a265-goog
>




--
Best Regards
Masahiro Yamada
