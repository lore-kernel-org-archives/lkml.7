Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D30C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 02:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7481B20857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 02:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfCRCx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 22:53:58 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:42304 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbfCRCx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 22:53:57 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 6318727ACE;
        Sun, 17 Mar 2019 22:53:51 -0400 (EDT)
Date:   Mon, 18 Mar 2019 13:53:51 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Andreas Schwab <schwab@linux-m68k.org>,
        kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [m68k:master 1174/1174] arch/m68k/include/asm/string.h:72:25:
 warning: '__builtin_memcpy' forming offset 8 is out of the bounds [0, 7]
In-Reply-To: <alpine.LNX.2.21.1903120856310.282@nippy.intranet>
Message-ID: <alpine.LNX.2.21.1903181202440.9@nippy.intranet>
References: <201903042049.npxcZzps%fengguang.wu@intel.com> <CAMuHMdX365qmWiii=gQLADpW49EMkdDrVJDPWNBpAZuZM0WQFQ@mail.gmail.com> <alpine.LNX.2.21.1903051154200.135@nippy.intranet> <alpine.LNX.2.21.1903051357410.135@nippy.intranet>
 <CAMuHMdUuwudbk15GUPPxL+-Gt4zhhSomk-wMAHeTOkoaDOCUAA@mail.gmail.com> <alpine.LNX.2.21.1903051948290.147@nippy.intranet> <mvmh8chzo7j.fsf@linux-m68k.org> <alpine.LNX.2.21.1903071329140.513@nippy.intranet> <CAMuHMdVzLTO-yYJJ=HqVySX6gqes9cnyspungsB5maduzNt0RA@mail.gmail.com>
 <alpine.LNX.2.21.1903080838260.595@nippy.intranet> <CAMuHMdWr-Y7mfH3gFXfK0fWpEhhdoW9VUkOEwf0nFN8kfr4zrg@mail.gmail.com> <mvmo96hvin9.fsf@linux-m68k.org> <CAMuHMdU9gke1=5PfjpJWuUbSBQ=bPQjpEVD3+t3F3tHvh9szWg@mail.gmail.com> <mvmimwpvhv0.fsf@linux-m68k.org>
 <CAMuHMdXztDOGWDSKyOuaQzK9WxWoDPz-AJFRVyF7PyRiM68ugg@mail.gmail.com> <alpine.LNX.2.21.1903120856310.282@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2019, I wrote:

> ... I did another experiment with the latter (forced inline) approach, 
> to see if some optimizations can still be used with -ffreestanding.
> 
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 7927b875f80c..25b5bf689018 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -436,6 +436,58 @@ __FORTIFY_INLINE char *strcpy(char *p, const char *q)
>  	return p;
>  }
>  
> +#else
> +
> +//__FORTIFY_INLINE char *strncpy(char *p, const char *q, __kernel_size_t size)
> +//{
> +//	return __builtin_strncpy(p, q, size);
> +//}
> +
> +__FORTIFY_INLINE char *strcat(char *p, const char *q)
> +{
> +	return __builtin_strcat(p, q);
> +}
> +
> +__FORTIFY_INLINE __kernel_size_t strlen(const char *p)
> +{
> +	return __builtin_strlen(p);
> +}
> +
> +__FORTIFY_INLINE char *strncat(char *p, const char *q, __kernel_size_t count)
> +{
> +	return __builtin_strncat(p, q, count);
> +}
> +
> +__FORTIFY_INLINE void *memset(void *p, int c, __kernel_size_t size)
> +{
> +	return __builtin_memset(p, c, size);
> +}
> +
> +//__FORTIFY_INLINE void *memcpy(void *p, const void *q, __kernel_size_t size)
> +//{
> +//	return __builtin_memcpy(p, q, size);
> +//}
> +
> +__FORTIFY_INLINE void *memmove(void *p, const void *q, __kernel_size_t size)
> +{
> +	return __builtin_memmove(p, q, size);
> +}
> +
> +__FORTIFY_INLINE int memcmp(const void *p, const void *q, __kernel_size_t size)
> +{
> +	return __builtin_memcmp(p, q, size);
> +}
> +
> +__FORTIFY_INLINE void *memchr(const void *p, int c, __kernel_size_t size)
> +{
> +	return __builtin_memchr(p, c, size);
> +}
> +
> +__FORTIFY_INLINE char *strcpy(char *p, const char *q)
> +{
> +	return __builtin_strcpy(p, q);
> +}
> +
>  #endif
>  
>  /**
> 
> 
> The result of this patch really is confusing. It still suppresses the 
> warning you raised:
> 
> arch/m68k/include/asm/string.h:72:25: warning: '__builtin_memcpy' forming
> offset 8 is out of the bounds [0, 7] [-Warray-bounds]
>     #define memcpy(d, s, n) __builtin_memcpy(d, s, n)
>                             ^~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/string.h:456:3: note: in expansion of macro 'memcpy'
>       memcpy(dest, src, dest_len);
>       ^~~~~~
> 
> But it also causes new ones, because of __builtin_memset():
> 
> drivers/video/fbdev/core/fbcvt.c: In function 'fb_find_mode_cvt':
> drivers/video/fbdev/core/fbcvt.c:312:16: warning: 'cvt.flags' may be used uninit                                                                     ialized in this function [-Wmaybe-uninitialized]
>       cvt.flags |= FB_CVT_FLAG_MARGINS;
>                 ^~
> 
> Apparently the compiler doesn't understand that __builtin_memset() has 
> the effect of initialization. Weird.
> 

The other weird thing is that this warning doesn't show up when 
CONFIG_FORTIFY_SOURCE=y, even though the technique is much the same, that 
is, __builtin_memset() gets wrapped in a static inline memset() function.

Anyway, a quick and dirty microbenchmark under qemu-m68k shows that this 
patch reduces system time for 'time find / -false' by approx. 10%.

Interestingly, the -ffreestanding option doesn't make much difference to 
this particular microbenchmark.

-- 
