Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263CBC10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F23792184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfCNId5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 04:33:57 -0400
Received: from mga03.intel.com ([134.134.136.65]:55879 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726629AbfCNId4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 04:33:56 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Mar 2019 01:33:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,477,1544515200"; 
   d="scan'208";a="327206014"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga006.fm.intel.com with ESMTP; 14 Mar 2019 01:33:51 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h4LoD-0002G2-A6; Thu, 14 Mar 2019 10:33:49 +0200
Date:   Thu, 14 Mar 2019 10:33:49 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     akpm@linux-foundation.org, clang-built-linux@googlegroups.com,
        linux-kbuild@vger.kernel.org, stable@vger.kernel.org,
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] lib/string.c: implement a basic bcmp
Message-ID: <20190314083349.GT9224@smile.fi.intel.com>
References: <7549EE7E-4172-467D-815A-63664A33D410@goodmis.org>
 <20190313211335.165605-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313211335.165605-1-ndesaulniers@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
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

Thanks!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

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

-- 
With Best Regards,
Andy Shevchenko


