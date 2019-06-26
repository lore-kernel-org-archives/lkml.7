Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A15C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454A12133F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfFZMoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 08:44:20 -0400
Received: from foss.arm.com ([217.140.110.172]:60448 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbfFZMoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 08:44:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9535DD6E;
        Wed, 26 Jun 2019 05:44:18 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E28603F718;
        Wed, 26 Jun 2019 05:44:16 -0700 (PDT)
Date:   Wed, 26 Jun 2019 13:44:14 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     aryabinin@virtuozzo.com, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/4] mm/kasan: Introduce __kasan_check_{read,write}
Message-ID: <20190626124414.GC20635@lakrids.cambridge.arm.com>
References: <20190626122018.171606-1-elver@google.com>
 <20190626122018.171606-2-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626122018.171606-2-elver@google.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 02:20:16PM +0200, Marco Elver wrote:
> This introduces __kasan_check_{read,write} which return a bool if the
> access was valid or not. __kasan_check functions may be used from
> anywhere, even compilation units that disable instrumentation
> selectively. For consistency, kasan_check_{read,write} have been changed
> to also return a bool.
> 
> This change eliminates the need for the __KASAN_INTERNAL definition.

I'm very happy to see __KASAN_INTERNAL go away!

It might be worth splitting that change from the return type change,
since the two are logically unrelated.

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
> Cc: kasan-dev@googlegroups.com
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
>  include/linux/kasan-checks.h | 35 ++++++++++++++++++++++++++++-------
>  mm/kasan/common.c            | 14 ++++++--------
>  mm/kasan/generic.c           | 13 +++++++------
>  mm/kasan/kasan.h             | 10 +++++++++-
>  mm/kasan/tags.c              | 12 +++++++-----
>  5 files changed, 57 insertions(+), 27 deletions(-)
> 
> diff --git a/include/linux/kasan-checks.h b/include/linux/kasan-checks.h
> index a61dc075e2ce..b8cf8a7cad34 100644
> --- a/include/linux/kasan-checks.h
> +++ b/include/linux/kasan-checks.h
> @@ -2,14 +2,35 @@
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
> +bool __kasan_check_read(const volatile void *p, unsigned int size);
> +bool __kasan_check_write(const volatile void *p, unsigned int size);
>  #else
> -static inline void kasan_check_read(const volatile void *p, unsigned int size)
> -{ }
> -static inline void kasan_check_write(const volatile void *p, unsigned int size)
> -{ }
> +static inline bool __kasan_check_read(const volatile void *p, unsigned int size)
> +{ return true; }
> +static inline bool __kasan_check_write(const volatile void *p, unsigned int size)
> +{ return true; }
> +#endif
> +
> +/*
> + * kasan_check_*: Only available when the particular compilation unit has KASAN
> + * instrumentation enabled. May be used in header files.
> + */
> +#ifdef __SANITIZE_ADDRESS__
> +static inline bool kasan_check_read(const volatile void *p, unsigned int size)
> +{ return __kasan_check_read(p, size); }
> +static inline bool kasan_check_write(const volatile void *p, unsigned int size)
> +{ return __kasan_check_read(p, size); }
> +#else
> +static inline bool kasan_check_read(const volatile void *p, unsigned int size)
> +{ return true; }
> +static inline bool kasan_check_write(const volatile void *p, unsigned int size)
> +{ return true; }

As the body doesn't fit on the same line as the prototype, please follow
the usual coding style:

#ifdef ____SANITIZE_ADDRESS__
static inline bool kasan_check_read(const volatile void *p, unsigned int size)
{
	return __kasan_check_read(p, size);
}

static inline bool kasan_check_write(const volatile void *p, unsigned int size)
{
	return __kasan_check_read(p, size);
}
#else
static inline bool kasan_check_read(const volatile void *p, unsigned int size)
{
	return true;
}

static inline bool kasan_check_write(const volatile void *p, unsigned int size)
{
	return true;
}
#endif

... or use __is_defined() to do the check within the body, .e.g

static inline bool kasan_check_read(const volatile void *p, unsigned int size)
{
	if (__is_defined(__SANITIZE_ADDRESS__))
		return __kasan_check_read(p, size);
	else
		return true;
}

Thanks,
Mark.

>  #endif
>  
>  #endif
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 242fdc01aaa9..2277b82902d8 100644
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
> +bool __kasan_check_read(const volatile void *p, unsigned int size)
>  {
> -	check_memory_region((unsigned long)p, size, false, _RET_IP_);
> +	return check_memory_region((unsigned long)p, size, false, _RET_IP_);
>  }
> -EXPORT_SYMBOL(kasan_check_read);
> +EXPORT_SYMBOL(__kasan_check_read);
>  
> -void kasan_check_write(const volatile void *p, unsigned int size)
> +bool __kasan_check_write(const volatile void *p, unsigned int size)
>  {
> -	check_memory_region((unsigned long)p, size, true, _RET_IP_);
> +	return check_memory_region((unsigned long)p, size, true, _RET_IP_);
>  }
> -EXPORT_SYMBOL(kasan_check_write);
> +EXPORT_SYMBOL(__kasan_check_write);
>  
>  #undef memset
>  void *memset(void *addr, int c, size_t len)
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index 504c79363a34..616f9dd82d12 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -166,29 +166,30 @@ static __always_inline bool memory_is_poisoned(unsigned long addr, size_t size)
>  	return memory_is_poisoned_n(addr, size);
>  }
>  
> -static __always_inline void check_memory_region_inline(unsigned long addr,
> +static __always_inline bool check_memory_region_inline(unsigned long addr,
>  						size_t size, bool write,
>  						unsigned long ret_ip)
>  {
>  	if (unlikely(size == 0))
> -		return;
> +		return true;
>  
>  	if (unlikely((void *)addr <
>  		kasan_shadow_to_mem((void *)KASAN_SHADOW_START))) {
>  		kasan_report(addr, size, write, ret_ip);
> -		return;
> +		return false;
>  	}
>  
>  	if (likely(!memory_is_poisoned(addr, size)))
> -		return;
> +		return true;
>  
>  	kasan_report(addr, size, write, ret_ip);
> +	return false;
>  }
>  
> -void check_memory_region(unsigned long addr, size_t size, bool write,
> +bool check_memory_region(unsigned long addr, size_t size, bool write,
>  				unsigned long ret_ip)
>  {
> -	check_memory_region_inline(addr, size, write, ret_ip);
> +	return check_memory_region_inline(addr, size, write, ret_ip);
>  }
>  
>  void kasan_cache_shrink(struct kmem_cache *cache)
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 3ce956efa0cb..e62ea45d02e3 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -123,7 +123,15 @@ static inline bool addr_has_shadow(const void *addr)
>  
>  void kasan_poison_shadow(const void *address, size_t size, u8 value);
>  
> -void check_memory_region(unsigned long addr, size_t size, bool write,
> +/**
> + * check_memory_region - Check memory region, and report if invalid access.
> + * @addr: the accessed address
> + * @size: the accessed size
> + * @write: true if access is a write access
> + * @ret_ip: return address
> + * @return: true if access was valid, false if invalid
> + */
> +bool check_memory_region(unsigned long addr, size_t size, bool write,
>  				unsigned long ret_ip);
>  
>  void *find_first_bad_addr(void *addr, size_t size);
> diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
> index 63fca3172659..0e987c9ca052 100644
> --- a/mm/kasan/tags.c
> +++ b/mm/kasan/tags.c
> @@ -76,7 +76,7 @@ void *kasan_reset_tag(const void *addr)
>  	return reset_tag(addr);
>  }
>  
> -void check_memory_region(unsigned long addr, size_t size, bool write,
> +bool check_memory_region(unsigned long addr, size_t size, bool write,
>  				unsigned long ret_ip)
>  {
>  	u8 tag;
> @@ -84,7 +84,7 @@ void check_memory_region(unsigned long addr, size_t size, bool write,
>  	void *untagged_addr;
>  
>  	if (unlikely(size == 0))
> -		return;
> +		return true;
>  
>  	tag = get_tag((const void *)addr);
>  
> @@ -106,22 +106,24 @@ void check_memory_region(unsigned long addr, size_t size, bool write,
>  	 * set to KASAN_TAG_KERNEL (0xFF)).
>  	 */
>  	if (tag == KASAN_TAG_KERNEL)
> -		return;
> +		return true;
>  
>  	untagged_addr = reset_tag((const void *)addr);
>  	if (unlikely(untagged_addr <
>  			kasan_shadow_to_mem((void *)KASAN_SHADOW_START))) {
>  		kasan_report(addr, size, write, ret_ip);
> -		return;
> +		return false;
>  	}
>  	shadow_first = kasan_mem_to_shadow(untagged_addr);
>  	shadow_last = kasan_mem_to_shadow(untagged_addr + size - 1);
>  	for (shadow = shadow_first; shadow <= shadow_last; shadow++) {
>  		if (*shadow != tag) {
>  			kasan_report(addr, size, write, ret_ip);
> -			return;
> +			return false;
>  		}
>  	}
> +
> +	return true;
>  }
>  
>  #define DEFINE_HWASAN_LOAD_STORE(size)					\
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 
