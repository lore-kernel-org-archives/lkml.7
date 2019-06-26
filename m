Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A21C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3A5217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfFZQRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 12:17:53 -0400
Received: from foss.arm.com ([217.140.110.172]:36476 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbfFZQRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 12:17:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 458BE2B;
        Wed, 26 Jun 2019 09:17:52 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93CED3F706;
        Wed, 26 Jun 2019 09:17:50 -0700 (PDT)
Date:   Wed, 26 Jun 2019 17:17:48 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org
Subject: Re: [PATCH v3 1/5] mm/kasan: Introduce __kasan_check_{read,write}
Message-ID: <20190626161748.GH20635@lakrids.cambridge.arm.com>
References: <20190626142014.141844-1-elver@google.com>
 <20190626142014.141844-2-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626142014.141844-2-elver@google.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 04:20:10PM +0200, Marco Elver wrote:
> This introduces __kasan_check_{read,write}. __kasan_check functions may
> be used from anywhere, even compilation units that disable
> instrumentation selectively.
> 
> This change eliminates the need for the __KASAN_INTERNAL definition.
> 
> Signed-off-by: Marco Elver <elver@google.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@google.com>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: kasan-dev@googlegroups.com
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org

Logically this makes sense to me, so FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> ---
> v3:
> * Fix Formatting and split introduction of __kasan_check_* and returning
>   bool into 2 patches.
> ---
>  include/linux/kasan-checks.h | 31 ++++++++++++++++++++++++++++---
>  mm/kasan/common.c            | 10 ++++------
>  2 files changed, 32 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/kasan-checks.h b/include/linux/kasan-checks.h
> index a61dc075e2ce..19a0175d2452 100644
> --- a/include/linux/kasan-checks.h
> +++ b/include/linux/kasan-checks.h
> @@ -2,9 +2,34 @@
>  #ifndef _LINUX_KASAN_CHECKS_H
>  #define _LINUX_KASAN_CHECKS_H
>  
> -#if defined(__SANITIZE_ADDRESS__) || defined(__KASAN_INTERNAL)
> -void kasan_check_read(const volatile void *p, unsigned int size);
> -void kasan_check_write(const volatile void *p, unsigned int size);
> +/*
> + * __kasan_check_*: Always available when KASAN is enabled. This may be used
> + * even in compilation units that selectively disable KASAN, but must use KASAN
> + * to validate access to an address.   Never use these in header files!
> + */
> +#ifdef CONFIG_KASAN
> +void __kasan_check_read(const volatile void *p, unsigned int size);
> +void __kasan_check_write(const volatile void *p, unsigned int size);
> +#else
> +static inline void __kasan_check_read(const volatile void *p, unsigned int size)
> +{ }
> +static inline void __kasan_check_write(const volatile void *p, unsigned int size)
> +{ }
> +#endif
> +
> +/*
> + * kasan_check_*: Only available when the particular compilation unit has KASAN
> + * instrumentation enabled. May be used in header files.
> + */
> +#ifdef __SANITIZE_ADDRESS__
> +static inline void kasan_check_read(const volatile void *p, unsigned int size)
> +{
> +	__kasan_check_read(p, size);
> +}
> +static inline void kasan_check_write(const volatile void *p, unsigned int size)
> +{
> +	__kasan_check_read(p, size);
> +}
>  #else
>  static inline void kasan_check_read(const volatile void *p, unsigned int size)
>  { }
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 242fdc01aaa9..6bada42cc152 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -14,8 +14,6 @@
>   *
>   */
>  
> -#define __KASAN_INTERNAL
> -
>  #include <linux/export.h>
>  #include <linux/interrupt.h>
>  #include <linux/init.h>
> @@ -89,17 +87,17 @@ void kasan_disable_current(void)
>  	current->kasan_depth--;
>  }
>  
> -void kasan_check_read(const volatile void *p, unsigned int size)
> +void __kasan_check_read(const volatile void *p, unsigned int size)
>  {
>  	check_memory_region((unsigned long)p, size, false, _RET_IP_);
>  }
> -EXPORT_SYMBOL(kasan_check_read);
> +EXPORT_SYMBOL(__kasan_check_read);
>  
> -void kasan_check_write(const volatile void *p, unsigned int size)
> +void __kasan_check_write(const volatile void *p, unsigned int size)
>  {
>  	check_memory_region((unsigned long)p, size, true, _RET_IP_);
>  }
> -EXPORT_SYMBOL(kasan_check_write);
> +EXPORT_SYMBOL(__kasan_check_write);
>  
>  #undef memset
>  void *memset(void *addr, int c, size_t len)
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 
