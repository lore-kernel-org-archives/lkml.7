Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9477AFC6197
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 22:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69071214DA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 22:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730509AbfKHWcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 17:32:51 -0500
Received: from relay.sw.ru ([185.231.240.75]:40440 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfKHWcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 17:32:50 -0500
Received: from [192.168.15.61]
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1iTCnz-0006wD-JO; Sat, 09 Nov 2019 01:32:35 +0300
Subject: Re: [PATCH v3 1/2] kasan: detect negative size in memory operation
 function
To:     Walter Wu <walter-zh.wu@mediatek.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>
References: <20191104020519.27988-1-walter-zh.wu@mediatek.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <34bf9c08-d2f2-a6c6-1dbe-29b1456d8284@virtuozzo.com>
Date:   Sat, 9 Nov 2019 01:31:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191104020519.27988-1-walter-zh.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/4/19 5:05 AM, Walter Wu wrote:

> 
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 6814d6d6a023..4ff67e2fd2db 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -99,10 +99,14 @@ bool __kasan_check_write(const volatile void *p, unsigned int size)
>  }
>  EXPORT_SYMBOL(__kasan_check_write);
>  
> +extern bool report_enabled(void);
> +
>  #undef memset
>  void *memset(void *addr, int c, size_t len)
>  {
> -	check_memory_region((unsigned long)addr, len, true, _RET_IP_);
> +	if (report_enabled() &&
> +	    !check_memory_region((unsigned long)addr, len, true, _RET_IP_))
> +		return NULL;
>  
>  	return __memset(addr, c, len);
>  }
> @@ -110,8 +114,10 @@ void *memset(void *addr, int c, size_t len)
>  #undef memmove
>  void *memmove(void *dest, const void *src, size_t len)
>  {
> -	check_memory_region((unsigned long)src, len, false, _RET_IP_);
> -	check_memory_region((unsigned long)dest, len, true, _RET_IP_);
> +	if (report_enabled() &&
> +	   (!check_memory_region((unsigned long)src, len, false, _RET_IP_) ||
> +	    !check_memory_region((unsigned long)dest, len, true, _RET_IP_)))
> +		return NULL;
>  
>  	return __memmove(dest, src, len);
>  }
> @@ -119,8 +125,10 @@ void *memmove(void *dest, const void *src, size_t len)
>  #undef memcpy
>  void *memcpy(void *dest, const void *src, size_t len)
>  {
> -	check_memory_region((unsigned long)src, len, false, _RET_IP_);
> -	check_memory_region((unsigned long)dest, len, true, _RET_IP_);
> +	if (report_enabled() &&

            report_enabled() checks seems to be useless.

> +	   (!check_memory_region((unsigned long)src, len, false, _RET_IP_) ||
> +	    !check_memory_region((unsigned long)dest, len, true, _RET_IP_)))
> +		return NULL;
>  
>  	return __memcpy(dest, src, len);
>  }
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index 616f9dd82d12..02148a317d27 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -173,6 +173,11 @@ static __always_inline bool check_memory_region_inline(unsigned long addr,
>  	if (unlikely(size == 0))
>  		return true;
>  
> +	if (unlikely((long)size < 0)) {

        if (unlikely(addr + size < addr)) {

> +		kasan_report(addr, size, write, ret_ip);
> +		return false;
> +	}
> +
>  	if (unlikely((void *)addr <
>  		kasan_shadow_to_mem((void *)KASAN_SHADOW_START))) {
>  		kasan_report(addr, size, write, ret_ip);
> diff --git a/mm/kasan/generic_report.c b/mm/kasan/generic_report.c
> index 36c645939bc9..52a92c7db697 100644
> --- a/mm/kasan/generic_report.c
> +++ b/mm/kasan/generic_report.c
> @@ -107,6 +107,24 @@ static const char *get_wild_bug_type(struct kasan_access_info *info)
>  
>  const char *get_bug_type(struct kasan_access_info *info)
>  {
> +	/*
> +	 * If access_size is negative numbers, then it has three reasons
> +	 * to be defined as heap-out-of-bounds bug type.
> +	 * 1) Casting negative numbers to size_t would indeed turn up as
> +	 *    a large size_t and its value will be larger than ULONG_MAX/2,
> +	 *    so that this can qualify as out-of-bounds.
> +	 * 2) If KASAN has new bug type and user-space passes negative size,
> +	 *    then there are duplicate reports. So don't produce new bug type
> +	 *    in order to prevent duplicate reports by some systems
> +	 *    (e.g. syzbot) to report the same bug twice.
> +	 * 3) When size is negative numbers, it may be passed from user-space.
> +	 *    So we always print heap-out-of-bounds in order to prevent that
> +	 *    kernel-space and user-space have the same bug but have duplicate
> +	 *    reports.
> +	 */
 
Completely fail to understand 2) and 3). 2) talks something about *NOT* producing new bug
type, but at the same time you code actually does that.
3) says something about user-space which have nothing to do with kasan.

> +	if ((long)info->access_size < 0)

        if (info->access_addr + info->access_size < info->access_addr)

> +		return "heap-out-of-bounds";
> +
>  	if (addr_has_shadow(info->access_addr))
>  		return get_shadow_bug_type(info);
>  	return get_wild_bug_type(info);
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 621782100eaa..c79e28814e8f 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -446,7 +446,7 @@ static void print_shadow_for_address(const void *addr)
>  	}
>  }
>  
> -static bool report_enabled(void)
> +bool report_enabled(void)
>  {
>  	if (current->kasan_depth)
>  		return false;
> diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
> index 0e987c9ca052..b829535a3ad7 100644
> --- a/mm/kasan/tags.c
> +++ b/mm/kasan/tags.c
> @@ -86,6 +86,11 @@ bool check_memory_region(unsigned long addr, size_t size, bool write,
>  	if (unlikely(size == 0))
>  		return true;
>  
> +	if (unlikely((long)size < 0)) {

        if (unlikely(addr + size < addr)) {

> +		kasan_report(addr, size, write, ret_ip);
> +		return false;
> +	}
> +
>  	tag = get_tag((const void *)addr);
>  
>  	/*
> diff --git a/mm/kasan/tags_report.c b/mm/kasan/tags_report.c
> index 969ae08f59d7..f7ae474aef3a 100644
> --- a/mm/kasan/tags_report.c
> +++ b/mm/kasan/tags_report.c
> @@ -36,6 +36,24 @@
>  
>  const char *get_bug_type(struct kasan_access_info *info)
>  {
> +	/*
> +	 * If access_size is negative numbers, then it has three reasons
> +	 * to be defined as heap-out-of-bounds bug type.
> +	 * 1) Casting negative numbers to size_t would indeed turn up as
> +	 *    a large size_t and its value will be larger than ULONG_MAX/2,
> +	 *    so that this can qualify as out-of-bounds.
> +	 * 2) If KASAN has new bug type and user-space passes negative size,
> +	 *    then there are duplicate reports. So don't produce new bug type
> +	 *    in order to prevent duplicate reports by some systems
> +	 *    (e.g. syzbot) to report the same bug twice.
> +	 * 3) When size is negative numbers, it may be passed from user-space.
> +	 *    So we always print heap-out-of-bounds in order to prevent that
> +	 *    kernel-space and user-space have the same bug but have duplicate
> +	 *    reports.
> +	 */
> +	if ((long)info->access_size < 0)

        if (info->access_addr + info->access_size < info->access_addr)

> +		return "heap-out-of-bounds";
> +
>  #ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
>  	struct kasan_alloc_meta *alloc_meta;
>  	struct kmem_cache *cache;
> 
