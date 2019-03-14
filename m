Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1558CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 03:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C826C20854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 03:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+H3yalP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfCNDPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 23:15:37 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39763 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfCNDPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 23:15:36 -0400
Received: by mail-ed1-f67.google.com with SMTP id p27so3331248edc.6;
        Wed, 13 Mar 2019 20:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w6tTH8LHrpkeFIvESsQeWU08KFpl98E7IcxYbXr9Pzs=;
        b=I+H3yalPQvE1XM5roeTlEz235MZ3rHeexoAorISDeN6dTLGINpb3r4Hdmi7r3BdKLw
         kWHthXDXZgNBqjt7VU4+ie+DdWcdw82rCbG2UtdtOQlMzq4ChuY/ZuYTZ4zpMS6Hec/6
         z2KVuFPpDPrenocZxjDf+frHUz3prWXeocSzXWoDG8HVvG8AX6CK7evxVx8DPmbhFD6m
         dXzFWGIlroHUugwy4rWXArV4EW1aCtKEKhzf1JpTDRgLM05iZPGK4e7Osf7UVjCQV1o6
         o19r50zzePtV8o8t5AWhYorJa64vcnXzZS+jEfhfgIxkgZhCGCA3lirCBn+1nXEQLPLv
         r6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w6tTH8LHrpkeFIvESsQeWU08KFpl98E7IcxYbXr9Pzs=;
        b=ZJbbTwk/xWzallFSg9LoDuucG+HKHw9I/qET712Oe99JSW9mc6W59PNSr4VC80q5Q1
         MUKUB60jNfWiEbX2kgrIPa48LbdA5Hpv9k9VVXhZpkgQJOlDz6Nj5hE2xF8YvpIT1rcv
         x+rzdE/i3vxBh+JBPn9hyRf1NaWXMJWMCO7MfV6KiwIsgY/oUe1uB//PNA5jfK7r10pm
         3c/ZDtDJmbmrNn9GaLyPNsCiYCvEwu3DMZ+21UH80oR7MYKNS6k0PN1HE566REsCAPs7
         XsCbbrRc44eHgm9bZNWwj0iaE0WWJ1KegIAGjAY29o0OkSMJhCeRwmAst7KQxmqnxNPJ
         HdzA==
X-Gm-Message-State: APjAAAWCRNYekOrAi2j5lTvECX0Ntoxxkg+dxD9a99XHfF3ZCxKNklLt
        ASV5aM4YcP41m+z1I2wpFrs=
X-Google-Smtp-Source: APXvYqwz5szNib+ok+DvL6/VQ+HRwf4y2kR0kamI3yar6UIcVR5BOSrrnk1r5UHnD0ICz45QEhZcQg==
X-Received: by 2002:aa7:cfc7:: with SMTP id r7mr9484252edy.46.1552533333582;
        Wed, 13 Mar 2019 20:15:33 -0700 (PDT)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id 41sm1099284edu.85.2019.03.13.20.15.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 13 Mar 2019 20:15:32 -0700 (PDT)
Date:   Wed, 13 Mar 2019 20:15:30 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     akpm@linux-foundation.org, clang-built-linux@googlegroups.com,
        linux-kbuild@vger.kernel.org, stable@vger.kernel.org,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        James Y Knight <jyknight@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] lib/string.c: implement a basic bcmp
Message-ID: <20190314031530.GA9264@archlinux-ryzen>
References: <7549EE7E-4172-467D-815A-63664A33D410@goodmis.org>
 <20190313211335.165605-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313211335.165605-1-ndesaulniers@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 02:13:31PM -0700, Nick Desaulniers wrote:
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

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>

Thanks for fixing this better than I did (or tried to)!

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
> +	return memcmp(a, b, len);
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
