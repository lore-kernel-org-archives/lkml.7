Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320BCC10F05
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 02:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3546218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 02:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553134299;
	bh=AonDmoYZelCcWAw5ScpI+F4N74eg11aCaqjATNFvi+o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ljjZaZZ4R/zgAOgzEbrqcB3zArhPEnefyvtvvnFS1UD+jzK6vQrZfrMBBNm05kb71
	 U+aDjBTBzp+mq89WKnpBEbML6dljTshc1Wv1dd4C8OlUungD96JGNnCHOEQxWKp8q9
	 LfyOdhpXQUM2My66HMfG6CNWvURWwc+R7o5k+aKM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfCUCLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 22:11:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33930 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727661AbfCUCLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 22:11:37 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1ACC29BA;
        Thu, 21 Mar 2019 02:11:36 +0000 (UTC)
Date:   Wed, 20 Mar 2019 19:11:35 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     clang-built-linux@googlegroups.com, linux-kbuild@vger.kernel.org,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
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
Message-Id: <20190320191135.e49e976a8258c8ac0bb428c9@linux-foundation.org>
In-Reply-To: <20190313211335.165605-1-ndesaulniers@google.com>
References: <7549EE7E-4172-467D-815A-63664A33D410@goodmis.org>
        <20190313211335.165605-1-ndesaulniers@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2019 14:13:31 -0700 Nick Desaulniers <ndesaulniers@google.com> wrote:

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

I guess we should backport this into -stable so that older kernels can
be built with newer Clang.

> ...
>
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

What is the undef for?

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
