Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174E1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D738A21019
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AWsPH1VG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfCMSLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:11:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37284 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbfCMSLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 14:11:42 -0400
Received: by mail-pf1-f195.google.com with SMTP id s22so1945453pfh.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 11:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T643AOotQu5+CznGzie/WvJ4IouEOakV1gIrCGRusns=;
        b=AWsPH1VGoVtomMV6b/wshDYrfx2K+j5wDf1QAFKROe53Tpi9mUg8rXpu6e1PuOoLRF
         sQGQjwpkDuO7RFy7WrqAY77FWg6QC5642dZ8EYGfIHO5F/WnDktBp7fnonTnqzjmYDG9
         OA1YDRrkLN8cwhC07zoaw2VwmdPDuGQb1d09wCytCJRsiVppzm9xCPG79/irp/i/HcOw
         bA0hKCmbPy8ZP9XMjL/Cn9H88eWOpHejiEBwPH0UTSm07ObXYdrsW1zsR3vTUoDL/Cbn
         Xo5mHWF8m7IB07V80nJPDfmmOxOFoFkun8N7myq9Zba8kn5Yi/KeG1y6T/iAqkqNGul2
         y3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T643AOotQu5+CznGzie/WvJ4IouEOakV1gIrCGRusns=;
        b=hY8olClNnYHEh78ac5LFpPoFduvizoNTDlxPBcIeuivljw7J9Hpitwpyqwg+DTeX2j
         pvky17WwuLbzvOXm34etZ7OS6I64XnmdKIAzyYf2jfQg+T3cClNYoqyxAGmoy/uatnd9
         UwCLtbEdwYdw5FsOa/nbpTd/1xwD/yWmlD9ghc8fonHYVe5WitnMfXgTzu/h1rBv6XoG
         iYwzu9K98grn0brP68jUWcIhvW90z+Co1jZiNEXL0Lu8Lype/MilEWeMs9U7MzFAaIk1
         HFU1U9u44Gv2yTZep2Hb99vAEPn92LAqwjYujftoTirUuoI7/I+KR8WO2UW+1+itfDTp
         7uJA==
X-Gm-Message-State: APjAAAV72RHdR/+bei7MiP6sBwXsxJsEVesNnIICGI+FZ4uoP+dY8UD7
        1BclAnrsx0wxx5Ez17NslQcgGSVUc4c20nKzcmaxmg==
X-Google-Smtp-Source: APXvYqzWf3o2X4lomAdzayBb9eMJ47Y3fc24aOdnCLG1gAcipSwUUxL9RznxQuWWsXaRgPG/7BQgLVNOM5O1Ze/BCj0=
X-Received: by 2002:a17:902:8e82:: with SMTP id bg2mr46987986plb.217.1552500701263;
 Wed, 13 Mar 2019 11:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOd=8rAZi3ZT8qEupmS6xY2U10cKT7kPtB=gYfWsJEJ0GSQ@mail.gmail.com>
 <20190313180239.261938-1-ndesaulniers@google.com>
In-Reply-To: <20190313180239.261938-1-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 13 Mar 2019 11:11:30 -0700
Message-ID: <CAKwvOdmdEH1U9vOmVKo2Fn+hMPF9AB1enZ2rkpJcU9XHgR8Wng@mail.gmail.com>
Subject: Re: [PATCH] lib/string.c: implement a basic bcmp
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     clang-built-linux@googlegroups.com,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        James Y Knight <jyknight@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 11:02 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> A recent optimization in Clang (r355672) lowers comparisons of the
> return value of memcmp against zero to comparisons of the return value
> of bcmp against zero.  This helps some platforms that implement bcmp
> more efficiently than memcmp. glibc simply aliases bcmp to memcmp, but
> an optimized implementation is in the works.
>
> This results in linkage failures for all targets with Clang due to the
> undefined symbol.  For now, just implement bcmp as a tailcail to memcmp
> to unbreak the build.  This routine can be further optimized in the
> future.
>
> Other ideas discussed:
> * A weak alias was discussed, but breaks for architectures that define
> their own implementations of memcmp since aliases to declarations are
> not permitted (only definitions).  Arch-specific memcmp implementations
> typically declare memcmp in C headers, but implement them in assembly.
> * -ffreestanding also is used sporadically throughout the kernel.
> * -fno-builtin-bcmp doesn't work when doing LTO.
>
> Link: https://bugs.llvm.org/show_bug.cgi?id=41035
> Link: https://code.woboq.org/userspace/glibc/string/memcmp.c.html#bcmp
> Link: https://github.com/llvm/llvm-project/commit/8e16d73346f8091461319a7dfc4ddd18eedcff13
> Link: https://github.com/ClangBuiltLinux/linux/issues/416
> Cc: stable@vger.kernel.org
> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> Reported-by: Adhemerval Zanella <adhemerval.zanella@linaro.org>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Suggested-by: James Y Knight <jyknight@google.com>
> Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  lib/string.c | 15 +++++++++++++++

ah, looks like I should provide a declaration in
include/linux/string.h, too, in case others within the kernel would
like to use bcmp.  WIll send a v2.

>  1 file changed, 15 insertions(+)
>
> diff --git a/lib/string.c b/lib/string.c
> index 38e4ca08e757..5b2377d7143f 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -866,6 +866,21 @@ __visible int memcmp(const void *cs, const void *ct, size_t count)
>  EXPORT_SYMBOL(memcmp);
>  #endif
>
> +#ifndef __HAVE_ARCH_BCMP
> +/**
> + * bcmp - Like memcmp but the return code simply indicates a non-match.
> + * @cs: One area of memory.
> + * @ct: Another area of memory.
> + * @count: The size of the areas.
> + */
> +#undef bcmp
> +int bcmp(const void *cs, const void *ct, size_t count)
> +{
> +       return memcmp(cs, ct, count);
> +}
> +EXPORT_SYMBOL(bcmp);
> +#endif
> +
>  #ifndef __HAVE_ARCH_MEMSCAN
>  /**
>   * memscan - Find a character in an area of memory.
> --
> 2.21.0.360.g471c308f928-goog
>


-- 
Thanks,
~Nick Desaulniers
