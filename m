Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECEFC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB032147A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vch2kdmh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbfD2RdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 13:33:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42587 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728816AbfD2RdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:33:11 -0400
Received: by mail-pf1-f195.google.com with SMTP id w25so5647796pfi.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 10:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zpbyIVAlhMbRdeAB1M3cn6Wkwo9TF52AlNw1cUUTqHY=;
        b=vch2kdmhm3l/dYckKUYwTvyy6uXkMyZ9o3lJstXxJLuYnD3TbLEy3yWlSDh0vKuwif
         Kf3mGYGdG2QKV02tpYo0oG0vO8JNt2F9ZFLumLfRWLRu21hlnPQe9ewIidI/KUGZfDH8
         chQPhoRQgf7tS+IC+9XCrZ81Me0OjI762s90xxvqBvoi1g/GTsKSdHa2JyVk0JvbAUKx
         kr2ArBxjThj4+xSh8X/91M+uhfjGs1fAPcvHBex1n8hYIz9Ck9xbIyFCTWKa57hw0ZYW
         nU0iHKd57k3x2C8Z0I5rRs4gFqm1k0c8tfNQX+FbjDAFH0hA/y+0iJzwzY5RKb2CXuKs
         FpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zpbyIVAlhMbRdeAB1M3cn6Wkwo9TF52AlNw1cUUTqHY=;
        b=bec4txDHxMEXKD6xWDxFOWy4wV0Qpiz3p64Yro7cuLaThiVtQvclKLbsajGAuo9ff+
         6FAy7HXY11O9n98zNqOes5ohG7FXUcSpdQmqzEFFq4ZIPXw+4gD82GcIDoRvbQQD5FDa
         nb+k6/TLKSQW5zrna5zq0JxQ6dsG4w9qDVbMDpPb+JtaX3Txf1AhxfjSlnGdrPxurN66
         7fJm3PnqBhYFQn30mxkdoRfT59SiLipYZ4797t0C+WwQbaYys6iF42kVPfYVUk7p1k85
         bOQ5jE2inOU0dfQmG5eXKXRibNoMyOniT0nCTx2Og36kMog0HJi/9MXeaA8OQl44PZiV
         r3zQ==
X-Gm-Message-State: APjAAAXFUxvKzUcrSiUpE3Iw71y9LQZM7cJb8HFyGB/27PRbNdX2I7SO
        /JcIUCA9CZejjp+6+dpOkPm28RdD+PqspKtYCtFogg==
X-Google-Smtp-Source: APXvYqyhzVkgB0sNyP0pJLGAsn93Af3fptKn4jl6xD7tGPX4gYaGIpx/DliKHjfrKnMpDxgiLG5/DVCAaTylqLuA5Wo=
X-Received: by 2002:a63:c702:: with SMTP id n2mr21510100pgg.255.1556559190626;
 Mon, 29 Apr 2019 10:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190426130015.GA12483@archlinux-i9> <20190426190603.5982-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20190426190603.5982-1-linux@rasmusvillemoes.dk>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 29 Apr 2019 10:32:59 -0700
Message-ID: <CAKwvOd=Qzs8gAenS6-GkiSmrwxwJA7wChJ6FUE5+=LPAj4XSfQ@mail.gmail.com>
Subject: Re: [PATCH 11/10] arm64: unbreak DYNAMIC_DEBUG=y build with clang
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Jason Baron <jbaron@akamai.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 12:06 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> Current versions of clang does not like the %c modifier in inline
> assembly for targets other than x86, so any DYNAMIC_DEBUG=y build
> fails on arm64. A fix is likely to land in 9.0 (see
> https://github.com/ClangBuiltLinux/linux/issues/456), but unbreak the
> build for older versions.
>
> Fixes: arm64: select DYNAMIC_DEBUG_RELATIVE_POINTERS
> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
> Andrew, please apply and/or fold into 9/10.
>
>  arch/arm64/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index d0871d523d5d..315992e33b17 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -83,7 +83,7 @@ config ARM64
>         select CRC32
>         select DCACHE_WORD_ACCESS
>         select DMA_DIRECT_REMAP
> -       select DYNAMIC_DEBUG_RELATIVE_POINTERS
> +       select DYNAMIC_DEBUG_RELATIVE_POINTERS if CC_IS_GCC || CLANG_VERSION >= 90000

I just landed the fix for this in Clang, I think around the time you
sent the patch.  Should ship in Clang 9.  Thanks for unbreaking our
build.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>         select EDAC_SUPPORT
>         select FRAME_POINTER
>         select GENERIC_ALLOCATOR
> --
> 2.20.1
>


-- 
Thanks,
~Nick Desaulniers
