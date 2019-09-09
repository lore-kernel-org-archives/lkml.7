Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8947EC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58DCA21A4C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfIIPHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 11:07:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:34172 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725875AbfIIPHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 11:07:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 279F4B67D;
        Mon,  9 Sep 2019 15:07:06 +0000 (UTC)
Subject: Re: [PATCH 3/5] mm, slab: Remove unused kmalloc_size()
To:     Pengfei Li <lpf.vector@gmail.com>, akpm@linux-foundation.org
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190903160430.1368-1-lpf.vector@gmail.com>
 <20190903160430.1368-4-lpf.vector@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <d76b1486-78de-7f58-8cf1-a96689472932@suse.cz>
Date:   Mon, 9 Sep 2019 17:07:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903160430.1368-4-lpf.vector@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/19 6:04 PM, Pengfei Li wrote:
> The size of kmalloc can be obtained from kmalloc_info[],
> so remove kmalloc_size() that will not be used anymore.
> 
> Signed-off-by: Pengfei Li <lpf.vector@gmail.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>   include/linux/slab.h | 20 --------------------
>   mm/slab.c            |  5 +++--
>   mm/slab_common.c     |  5 ++---
>   3 files changed, 5 insertions(+), 25 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 56c9c7eed34e..e773e5764b7b 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -557,26 +557,6 @@ static __always_inline void *kmalloc(size_t size, gfp_t flags)
>   	return __kmalloc(size, flags);
>   }
>   
> -/*
> - * Determine size used for the nth kmalloc cache.
> - * return size or 0 if a kmalloc cache for that
> - * size does not exist
> - */
> -static __always_inline unsigned int kmalloc_size(unsigned int n)
> -{
> -#ifndef CONFIG_SLOB
> -	if (n > 2)
> -		return 1U << n;
> -
> -	if (n == 1 && KMALLOC_MIN_SIZE <= 32)
> -		return 96;
> -
> -	if (n == 2 && KMALLOC_MIN_SIZE <= 64)
> -		return 192;
> -#endif
> -	return 0;
> -}
> -
>   static __always_inline void *kmalloc_node(size_t size, gfp_t flags, int node)
>   {
>   #ifndef CONFIG_SLOB
> diff --git a/mm/slab.c b/mm/slab.c
> index c42b6211f42e..7bc4e90e1147 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -1248,8 +1248,9 @@ void __init kmem_cache_init(void)
>   	 */
>   	kmalloc_caches[KMALLOC_NORMAL][INDEX_NODE] = create_kmalloc_cache(
>   				kmalloc_info[INDEX_NODE].name[KMALLOC_NORMAL],
> -				kmalloc_size(INDEX_NODE), ARCH_KMALLOC_FLAGS,
> -				0, kmalloc_size(INDEX_NODE));
> +				kmalloc_info[INDEX_NODE].size,
> +				ARCH_KMALLOC_FLAGS, 0,
> +				kmalloc_info[INDEX_NODE].size);
>   	slab_state = PARTIAL_NODE;
>   	setup_kmalloc_cache_index_table();
>   
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 002e16673581..8b542cfcc4f2 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1239,11 +1239,10 @@ void __init create_kmalloc_caches(slab_flags_t flags)
>   		struct kmem_cache *s = kmalloc_caches[KMALLOC_NORMAL][i];
>   
>   		if (s) {
> -			unsigned int size = kmalloc_size(i);
> -
>   			kmalloc_caches[KMALLOC_DMA][i] = create_kmalloc_cache(
>   				kmalloc_info[i].name[KMALLOC_DMA],
> -				size, SLAB_CACHE_DMA | flags, 0, 0);
> +				kmalloc_info[i].size,
> +				SLAB_CACHE_DMA | flags, 0, 0);
>   		}
>   	}
>   #endif
> 

