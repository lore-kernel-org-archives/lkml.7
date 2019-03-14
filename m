Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51739C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 05:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187EA217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 05:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ZA8xNhq7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfCNFBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 01:01:22 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:24677 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfCNFBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 01:01:21 -0400
X-Greylist: delayed 64920 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Mar 2019 01:01:19 EDT
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x2E516tS028942;
        Thu, 14 Mar 2019 14:01:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x2E516tS028942
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552539667;
        bh=Uo4E4mUuPURHNRf7HqEPeFupT8psefdD/4LAQaEeYgg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZA8xNhq7E8zd3cIGx6zNmYa+Uu2wFjFQ3wrwWPhG4NGhcadgli1YjWh4HVU8RzX0W
         H5fOCJQOFICrQT8nh4hoYCpfxVwxuXabHriR3ZMZjn0gWr7lZo/o6AerBBhftTT729
         XNftp/yAmRejUIWPeVepNYpvS4vrH4FHTFV5XK9q6hK3SfAxae6yw/nEo0VHo9Tyu3
         IptNQZ3sdndV0unCThGMVJX89Y/IR5h48flFrwpursnKUtFI3o9Vb070LQ6GZ4w380
         1BQtyCB9Td6vpURZ1Q248A+bSGTvFbyVxaek0KeXFFwv0ZYU9eL9i8z9k4QXrXBCGY
         JFH9rDRLlEevw==
X-Nifty-SrcIP: [209.85.221.180]
Received: by mail-vk1-f180.google.com with SMTP id r189so1076219vkb.0;
        Wed, 13 Mar 2019 22:01:07 -0700 (PDT)
X-Gm-Message-State: APjAAAUhWDDC+gPX2zPffYM/NHpVCBI9EQ61Br3jNF65a6u3FSnhab0R
        pYK4hjledI7wvWLGDXDOGFgQKDRDZKETCdDHr/c=
X-Google-Smtp-Source: APXvYqw4fUUMOGM6rJhNqJIc3smfephevtXH7cZOhpfLHdO5pQP3EdMjch9ysVSuxxAs1v4mdZRUlA4D8BznnmwslPM=
X-Received: by 2002:a1f:ae07:: with SMTP id x7mr2779005vke.74.1552539666061;
 Wed, 13 Mar 2019 22:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <7549EE7E-4172-467D-815A-63664A33D410@goodmis.org> <20190313211335.165605-1-ndesaulniers@google.com>
In-Reply-To: <20190313211335.165605-1-ndesaulniers@google.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 14 Mar 2019 14:00:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNASS4T3r94yWXWvgCFcrfh=pp=p7oqA7=sN88XrJ5UT7uw@mail.gmail.com>
Message-ID: <CAK7LNASS4T3r94yWXWvgCFcrfh=pp=p7oqA7=sN88XrJ5UT7uw@mail.gmail.com>
Subject: Re: [PATCH v4] lib/string.c: implement a basic bcmp
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        clang-built-linux@googlegroups.com,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        James Y Knight <jyknight@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 6:13 AM Nick Desaulniers
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
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>


Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>




> ---
> Changes V3 -> V4:
> * Include the entirety of Rasmus' sugguestion, as per Steven.
> * Change formal parameter identifiers to match the comment.
> Changes V2 -> V3:
> * Adjust comment as per Steven to Rasmus' sugguestion.
> * Pick up Steven's Ack.
> Changes V1 -> V2:
> * Add declaration to include/linux/string.h.
> * Reword comment above bcmp.
>
>  include/linux/string.h |  3 +++
>  lib/string.c           | 20 ++++++++++++++++++++
>  2 files changed, 23 insertions(+)
>
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 7927b875f80c..6ab0a6fa512e 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -150,6 +150,9 @@ extern void * memscan(void *,int,__kernel_size_t);
>  #ifndef __HAVE_ARCH_MEMCMP
>  extern int memcmp(const void *,const void *,__kernel_size_t);
>  #endif
> +#ifndef __HAVE_ARCH_BCMP
> +extern int bcmp(const void *,const void *,__kernel_size_t);
> +#endif
>  #ifndef __HAVE_ARCH_MEMCHR
>  extern void * memchr(const void *,int,__kernel_size_t);
>  #endif
> diff --git a/lib/string.c b/lib/string.c
> index 38e4ca08e757..3ab861c1a857 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -866,6 +866,26 @@ __visible int memcmp(const void *cs, const void *ct, size_t count)
>  EXPORT_SYMBOL(memcmp);
>  #endif
>
> +#ifndef __HAVE_ARCH_BCMP
> +/**
> + * bcmp - returns 0 if and only if the buffers have identical contents.
> + * @a: pointer to first buffer.
> + * @b: pointer to second buffer.
> + * @len: size of buffers.
> + *
> + * The sign or magnitude of a non-zero return value has no particular
> + * meaning, and architectures may implement their own more efficient bcmp(). So
> + * while this particular implementation is a simple (tail) call to memcmp, do
> + * not rely on anything but whether the return value is zero or non-zero.
> + */
> +#undef bcmp
> +int bcmp(const void *a, const void *b, size_t len)
> +{
> +       return memcmp(a, b, len);
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
Best Regards
Masahiro Yamada
