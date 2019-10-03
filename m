Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CC4C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 06:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA9A218DE
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 06:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="hofJGP1d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbfJCGNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 02:13:16 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42165 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfJCGNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 02:13:15 -0400
Received: by mail-pg1-f193.google.com with SMTP id z12so1059588pgp.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 23:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9fRETY9RhiSOxgTnFBCjm3tx4YRlm+tuITEEPXz0fHs=;
        b=hofJGP1dDwI/zMraZPgIDB7r+urEJr38V9lTkIlvnQ4Qwc379JIATzV445w46l5Klr
         v4Idt4E3INifQhykaiI9ED8gy6lyhKGoWl9d7ZXBFT2Og3bn7jOXWTtgl7OowyR3VkNm
         OKqgH/0hDWA2XK9qdexD8/0M7CUam4MiVCtLbQ9ebjf26H6IPhvPjO/v8r8VakwvdBB2
         I6lmirdfDNzUpR8zrbHa82HbGeyduCnx0sIuMc2L5yQFymT8yq9cV3Fmb3tR5RBVl5lA
         hLNLXfl2p3Ce/pLp2VZbf6Sr/8u+F0BlfqGzFW1/g16vic2hpGFfkMCY2U8HT+Qh/Hxh
         +WtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9fRETY9RhiSOxgTnFBCjm3tx4YRlm+tuITEEPXz0fHs=;
        b=g+fZSu8ohApGZw3rhH+maS6rc2I+BcJ4SNrh9Ei5zxc90zUEIx4rHX3WCVOKmCPY35
         JskdgrGF6yF6mZInZLXGI1dLolukH9Y8ZvPawEFFhEiwxALRSZ19Ppc9i7DBxtD/tw4U
         skGQ4VbtQUzZsPOZq7YqBt9ZeWG2MV7jIf+76C2STlmT952GkZfEB/Zy1bu9q4L8OiLq
         f4EN+tTyh7+1rdrWO7Bm+1vpTDny8P8ge6YxUEJWrujrVIdTnddwAl2xne/driH2rE2r
         pPcr6WbkKufx3dFuA8jcMtmRP8RshApz4rJkgbZ/RW04pa1qXFaG5/SpB/QL68B2hV4Q
         2EqA==
X-Gm-Message-State: APjAAAVDFjd8FK2QWfrpDsXggxmVKranuzVicd/xIUlVy6GxEG9Xogpc
        4GZCZyUbHWTbfUUgzUiUuJkrUw==
X-Google-Smtp-Source: APXvYqyrKIzQ0rLqFPmScv1MHIRJPSmEIABPoYhl9vPaeMBHXV879E7ePh3E0xebyadyfzuySRjBhA==
X-Received: by 2002:a17:90a:8b8c:: with SMTP id z12mr8926915pjn.100.1570083193215;
        Wed, 02 Oct 2019 23:13:13 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10])
        by smtp.gmail.com with ESMTPSA id 19sm1004217pjd.23.2019.10.02.23.13.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2019 23:13:12 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] mm: kmemleak: Make the tool tolerant to struct
 scan_area allocation failures
To:     Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Qian Cai <cai@lca.pw>
References: <20190812160642.52134-1-catalin.marinas@arm.com>
 <20190812160642.52134-2-catalin.marinas@arm.com>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <2ac37341-097e-17a2-fb6b-7912da9fa38e@ozlabs.ru>
Date:   Thu, 3 Oct 2019 16:13:07 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20190812160642.52134-2-catalin.marinas@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/08/2019 02:06, Catalin Marinas wrote:
> Object scan areas are an optimisation aimed to decrease the false
> positives and slightly improve the scanning time of large objects known
> to only have a few specific pointers. If a struct scan_area fails to
> allocate, kmemleak can still function normally by scanning the full
> object.
> 
> Introduce an OBJECT_FULL_SCAN flag and mark objects as such when
> scan_area allocation fails.


I came across this one while bisecting sudden drop in throughput of a 100Gbit Mellanox CX4 ethernet card in a PPC POWER9
system, the speed dropped from 100Gbit to about 40Gbit. Bisect pointed at dba82d943177, this are the relevant config
options:

[fstn1-p1 kernel]$ grep KMEMLEAK ~/pbuild/kernel-le-4g/.config
CONFIG_HAVE_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE=16000
# CONFIG_DEBUG_KMEMLEAK_TEST is not set
# CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y

Setting CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=400 or even 4000 (this is what KMEMLEAK_EARLY_LOG_SIZE is now in the master)
produces soft lockups on the recent upstream (sha1 a3c0e7b1fe1f):

[c000001fde64fb60] [c000000000c24ed4] _raw_write_unlock_irqrestore+0x54/0x70
[c000001fde64fb90] [c0000000004117e4] find_and_remove_object+0xa4/0xd0
[c000001fde64fbe0] [c000000000411c74] delete_object_full+0x24/0x50
[c000001fde64fc00] [c000000000411d28] __kmemleak_do_cleanup+0x88/0xd0
[c000001fde64fc40] [c00000000012a1a4] process_one_work+0x374/0x6a0
[c000001fde64fd20] [c00000000012a548] worker_thread+0x78/0x5a0
[c000001fde64fdb0] [c000000000135508] kthread+0x198/0x1a0
[c000001fde64fe20] [c00000000000b980] ret_from_kernel_thread+0x5c/0x7c

KMEMLEAK_EARLY_LOG_SIZE=8000 works but slow.

Interestingly KMEMLEAK_EARLY_LOG_SIZE=400 on dba82d943177 still worked and I saw my 100Gbit. Disabling KMEMLEAK also
fixes the speed (apparently).

Is that something expected? Thanks,



> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  mm/kmemleak.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index f6e602918dac..5ba7fad00fda 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -168,6 +168,8 @@ struct kmemleak_object {
>  #define OBJECT_REPORTED		(1 << 1)
>  /* flag set to not scan the object */
>  #define OBJECT_NO_SCAN		(1 << 2)
> +/* flag set to fully scan the object when scan_area allocation failed */
> +#define OBJECT_FULL_SCAN	(1 << 3)
>  
>  #define HEX_PREFIX		"    "
>  /* number of bytes to print per line; must be 16 or 32 */
> @@ -773,12 +775,14 @@ static void add_scan_area(unsigned long ptr, size_t size, gfp_t gfp)
>  	}
>  
>  	area = kmem_cache_alloc(scan_area_cache, gfp_kmemleak_mask(gfp));
> -	if (!area) {
> -		pr_warn("Cannot allocate a scan area\n");
> -		goto out;
> -	}
>  
>  	spin_lock_irqsave(&object->lock, flags);
> +	if (!area) {
> +		pr_warn_once("Cannot allocate a scan area, scanning the full object\n");
> +		/* mark the object for full scan to avoid false positives */
> +		object->flags |= OBJECT_FULL_SCAN;
> +		goto out_unlock;
> +	}
>  	if (size == SIZE_MAX) {
>  		size = object->pointer + object->size - ptr;
>  	} else if (ptr + size > object->pointer + object->size) {
> @@ -795,7 +799,6 @@ static void add_scan_area(unsigned long ptr, size_t size, gfp_t gfp)
>  	hlist_add_head(&area->node, &object->area_list);
>  out_unlock:
>  	spin_unlock_irqrestore(&object->lock, flags);
> -out:
>  	put_object(object);
>  }
>  
> @@ -1408,7 +1411,8 @@ static void scan_object(struct kmemleak_object *object)
>  	if (!(object->flags & OBJECT_ALLOCATED))
>  		/* already freed object */
>  		goto out;
> -	if (hlist_empty(&object->area_list)) {
> +	if (hlist_empty(&object->area_list) ||
> +	    object->flags & OBJECT_FULL_SCAN) {
>  		void *start = (void *)object->pointer;
>  		void *end = (void *)(object->pointer + object->size);
>  		void *next;
> 

-- 
Alexey
