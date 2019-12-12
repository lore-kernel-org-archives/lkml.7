Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA3EC2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 11:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEAA024654
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 11:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToYstsOd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbfLLLuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 06:50:22 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34936 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfLLLuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 06:50:22 -0500
Received: by mail-pf1-f194.google.com with SMTP id b19so646495pfo.2;
        Thu, 12 Dec 2019 03:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e/toC+dvTXQ1hDrN0GnAWBSu4hu7Hq1vN81t7xIKMQk=;
        b=ToYstsOdyU7FO4wrwAnK8FSK4Rwdw6O5kTvUWgUjwdyLi5Mzy5On6Op4sQaIaWGEaE
         Z46NzQt2mZomOe/zmKQ8sdJwp8f5hfqjOAVvJrDYFOgqSHHipD8DVlTp4bKyX0l0/V6x
         +/GIKhuiVyz+dAvYfV2Hwsw346yELEzANSBUjDH+veSs/zS/0hVwjJ7ArTJidDifnlKE
         NE2dDq8MOeDxxe9qLYdensFw0RfJ63cuPc/+mYmI5SbcjYYYHVy4chII0upjhKw/TEDE
         uydsrO9CkJWzueReE+39UFbFF4Laeurot8V2thQNWEjPoUZfH8sKijnsn3C19Li9HDr+
         Zb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e/toC+dvTXQ1hDrN0GnAWBSu4hu7Hq1vN81t7xIKMQk=;
        b=JLeTqCdNzdQOJ3fT2CY+BQvn7qgz0ue+KClISpJVWZiPsQIXpML/6Kyi85R20KMjg0
         A6pocveGM825ze9is2IuhhsjO7GmTB68LcvFtbqqFNT/o1pzPauduNv9IcVGAnuEq+8J
         VLULt/RYhugPJCB+S80SEPPb+6nwaAnZGDwMYUHz07cy2YrL1q4lTT14mYX4LoIgUgrG
         IdMaE7bNU2j1CiSN9qlQxqUvWqFXeDzzaVJFdoxUltJLJa3KXJA5aN9M3Qw/V0oxnEdC
         LeQGK0La/dSVkq1cmBtf8rXegzcBEb1AvqohqZdS15bayo7Fm0Eu3nhGPpdQW78mXXsE
         OYRw==
X-Gm-Message-State: APjAAAU1si+VrqGkzCJ7Frzdqxe+2GgAbuvDJKi3ZuQsKkJIv7fhRcOW
        GEp8t3PAFNFejdSb3Bbbl60=
X-Google-Smtp-Source: APXvYqxiripHsHcQ9sOH6YYuhCPQqnbR536XDjtqYwJWOCXAHDtSKnde40qr+ds+uWeFtS51fxo31g==
X-Received: by 2002:aa7:8f16:: with SMTP id x22mr9420631pfr.120.1576151421714;
        Thu, 12 Dec 2019 03:50:21 -0800 (PST)
Received: from [10.231.110.95] ([125.29.25.186])
        by smtp.gmail.com with ESMTPSA id u11sm5829265pjr.9.2019.12.12.03.50.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 03:50:21 -0800 (PST)
Subject: Re: [PATCH] of: Rework and simplify phandle cache to use a fixed size
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Chintan Pandya <cpandya@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>
References: <20191211232345.24810-1-robh@kernel.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <9a0c89aa-4d16-a8b8-8643-40bb130d0cc5@gmail.com>
Date:   Thu, 12 Dec 2019 05:50:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191211232345.24810-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


+Chintan

Hi Chintan,

On 12/11/19 5:23 PM, Rob Herring wrote:
> The phandle cache was added to speed up of_find_node_by_phandle() by
> avoiding walking the whole DT to find a matching phandle. The
> implementation has several shortcomings:
> 
>   - The cache is designed to work on a linear set of phandle values.
>     This is true for dtc generated DTs, but not for other cases such as
>     Power.
>   - The cache isn't enabled until of_core_init() and a typical system
>     may see hundreds of calls to of_find_node_by_phandle() before that
>     point.
>   - The cache is freed and re-allocated when the number of phandles
>     changes.
>   - It takes a raw spinlock around a memory allocation which breaks on
>     RT.
> 
> Change the implementation to a fixed size and use hash_32() as the
> cache index. This greatly simplifies the implementation. It avoids
> the need for any re-alloc of the cache and taking a reference on nodes
> in the cache. We only have a single source of removing cache entries
> which is of_detach_node().

Can you check this patch on the system that you reported phandle lookup
overhead issues for?

-Frank


> 
> Using hash_32() removes any assumption on phandle values improving
> the hit rate for non-linear phandle values. The effect on linear values
> using hash_32() is about a 10% collision. The chances of thrashing on
> colliding values seems to be low.
> 
> To compare performance, I used a RK3399 board which is a pretty typical
> system. I found that just measuring boot time as done previously is
> noisy and may be impacted by other things. Also bringing up secondary
> cores causes some issues with measuring, so I booted with 'nr_cpus=1'.
> With no caching, calls to of_find_node_by_phandle() take about 20124 us
> for 1248 calls. There's an additional 288 calls before time keeping is
> up. Using the average time per hit/miss with the cache, we can calculate
> these calls to take 690 us (277 hit / 11 miss) with a 128 entry cache
> and 13319 us with no cache or an uninitialized cache.
> 
> Comparing the 3 implementations the time spent in
> of_find_node_by_phandle() is:
> 
> no cache:        20124 us (+ 13319 us)
> 128 entry cache:  5134 us (+ 690 us)
> current cache:     819 us (+ 13319 us)
> 
> We could move the allocation of the cache earlier to improve the
> current cache, but that just further complicates the situation as it
> needs to be after slab is up, so we can't do it when unflattening (which
> uses memblock).
> 
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Segher Boessenkool <segher@kernel.crashing.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/of/base.c       | 133 ++++++++--------------------------------
>  drivers/of/dynamic.c    |   2 +-
>  drivers/of/of_private.h |   4 +-
>  drivers/of/overlay.c    |  10 ---
>  4 files changed, 28 insertions(+), 121 deletions(-)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index db7fbc0c0893..f7da162f126d 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -135,115 +135,38 @@ int __weak of_node_to_nid(struct device_node *np)
>  }
>  #endif
>  
> -/*
> - * Assumptions behind phandle_cache implementation:
> - *   - phandle property values are in a contiguous range of 1..n
> - *
> - * If the assumptions do not hold, then
> - *   - the phandle lookup overhead reduction provided by the cache
> - *     will likely be less
> - */
> +#define OF_PHANDLE_CACHE_BITS	7
> +#define OF_PHANDLE_CACHE_SZ	BIT(OF_PHANDLE_CACHE_BITS)
>  
> -static struct device_node **phandle_cache;
> -static u32 phandle_cache_mask;
> +static struct device_node *phandle_cache[OF_PHANDLE_CACHE_SZ];
>  
> -/*
> - * Caller must hold devtree_lock.
> - */
> -static void __of_free_phandle_cache(void)
> +static u32 of_phandle_cache_hash(phandle handle)
>  {
> -	u32 cache_entries = phandle_cache_mask + 1;
> -	u32 k;
> -
> -	if (!phandle_cache)
> -		return;
> -
> -	for (k = 0; k < cache_entries; k++)
> -		of_node_put(phandle_cache[k]);
> -
> -	kfree(phandle_cache);
> -	phandle_cache = NULL;
> +	return hash_32(handle, OF_PHANDLE_CACHE_BITS);
>  }
>  
> -int of_free_phandle_cache(void)
> -{
> -	unsigned long flags;
> -
> -	raw_spin_lock_irqsave(&devtree_lock, flags);
> -
> -	__of_free_phandle_cache();
> -
> -	raw_spin_unlock_irqrestore(&devtree_lock, flags);
> -
> -	return 0;
> -}
> -#if !defined(CONFIG_MODULES)
> -late_initcall_sync(of_free_phandle_cache);
> -#endif
> -
>  /*
>   * Caller must hold devtree_lock.
>   */
> -void __of_free_phandle_cache_entry(phandle handle)
> +void __of_phandle_cache_inv_entry(phandle handle)
>  {
> -	phandle masked_handle;
> +	u32 handle_hash;
>  	struct device_node *np;
>  
>  	if (!handle)
>  		return;
>  
> -	masked_handle = handle & phandle_cache_mask;
> +	handle_hash = of_phandle_cache_hash(handle);
>  
> -	if (phandle_cache) {
> -		np = phandle_cache[masked_handle];
> -		if (np && handle == np->phandle) {
> -			of_node_put(np);
> -			phandle_cache[masked_handle] = NULL;
> -		}
> -	}
> -}
> -
> -void of_populate_phandle_cache(void)
> -{
> -	unsigned long flags;
> -	u32 cache_entries;
> -	struct device_node *np;
> -	u32 phandles = 0;
> -
> -	raw_spin_lock_irqsave(&devtree_lock, flags);
> -
> -	__of_free_phandle_cache();
> -
> -	for_each_of_allnodes(np)
> -		if (np->phandle && np->phandle != OF_PHANDLE_ILLEGAL)
> -			phandles++;
> -
> -	if (!phandles)
> -		goto out;
> -
> -	cache_entries = roundup_pow_of_two(phandles);
> -	phandle_cache_mask = cache_entries - 1;
> -
> -	phandle_cache = kcalloc(cache_entries, sizeof(*phandle_cache),
> -				GFP_ATOMIC);
> -	if (!phandle_cache)
> -		goto out;
> -
> -	for_each_of_allnodes(np)
> -		if (np->phandle && np->phandle != OF_PHANDLE_ILLEGAL) {
> -			of_node_get(np);
> -			phandle_cache[np->phandle & phandle_cache_mask] = np;
> -		}
> -
> -out:
> -	raw_spin_unlock_irqrestore(&devtree_lock, flags);
> +	np = phandle_cache[handle_hash];
> +	if (np && handle == np->phandle)
> +		phandle_cache[handle_hash] = NULL;
>  }
>  
>  void __init of_core_init(void)
>  {
>  	struct device_node *np;
>  
> -	of_populate_phandle_cache();
>  
>  	/* Create the kset, and register existing nodes */
>  	mutex_lock(&of_mutex);
> @@ -253,8 +176,11 @@ void __init of_core_init(void)
>  		pr_err("failed to register existing nodes\n");
>  		return;
>  	}
> -	for_each_of_allnodes(np)
> +	for_each_of_allnodes(np) {
>  		__of_attach_node_sysfs(np);
> +		if (np->phandle && !phandle_cache[of_phandle_cache_hash(np->phandle)])
> +			phandle_cache[of_phandle_cache_hash(np->phandle)] = np;
> +	}
>  	mutex_unlock(&of_mutex);
>  
>  	/* Symlink in /proc as required by userspace ABI */
> @@ -1235,36 +1161,29 @@ struct device_node *of_find_node_by_phandle(phandle handle)
>  {
>  	struct device_node *np = NULL;
>  	unsigned long flags;
> -	phandle masked_handle;
> +	u32 handle_hash;
>  
>  	if (!handle)
>  		return NULL;
>  
> +	handle_hash = of_phandle_cache_hash(handle);
> +
>  	raw_spin_lock_irqsave(&devtree_lock, flags);
>  
> -	masked_handle = handle & phandle_cache_mask;
> -
> -	if (phandle_cache) {
> -		if (phandle_cache[masked_handle] &&
> -		    handle == phandle_cache[masked_handle]->phandle)
> -			np = phandle_cache[masked_handle];
> -		if (np && of_node_check_flag(np, OF_DETACHED)) {
> -			WARN_ON(1); /* did not uncache np on node removal */
> -			of_node_put(np);
> -			phandle_cache[masked_handle] = NULL;
> -			np = NULL;
> -		}
> +	if (phandle_cache[handle_hash] &&
> +	    handle == phandle_cache[handle_hash]->phandle)
> +		np = phandle_cache[handle_hash];
> +	if (np && of_node_check_flag(np, OF_DETACHED)) {
> +		WARN_ON(1); /* did not uncache np on node removal */
> +		phandle_cache[handle_hash] = NULL;
> +		np = NULL;
>  	}
>  
>  	if (!np) {
>  		for_each_of_allnodes(np)
>  			if (np->phandle == handle &&
>  			    !of_node_check_flag(np, OF_DETACHED)) {
> -				if (phandle_cache) {
> -					/* will put when removed from cache */
> -					of_node_get(np);
> -					phandle_cache[masked_handle] = np;
> -				}
> +				phandle_cache[handle_hash] = np;
>  				break;
>  			}
>  	}
> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> index 49b16f76d78e..08fd823edac9 100644
> --- a/drivers/of/dynamic.c
> +++ b/drivers/of/dynamic.c
> @@ -276,7 +276,7 @@ void __of_detach_node(struct device_node *np)
>  	of_node_set_flag(np, OF_DETACHED);
>  
>  	/* race with of_find_node_by_phandle() prevented by devtree_lock */
> -	__of_free_phandle_cache_entry(np->phandle);
> +	__of_phandle_cache_inv_entry(np->phandle);
>  }
>  
>  /**
> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
> index 66294d29942a..582844c158ae 100644
> --- a/drivers/of/of_private.h
> +++ b/drivers/of/of_private.h
> @@ -85,14 +85,12 @@ int of_resolve_phandles(struct device_node *tree);
>  #endif
>  
>  #if defined(CONFIG_OF_DYNAMIC)
> -void __of_free_phandle_cache_entry(phandle handle);
> +void __of_phandle_cache_inv_entry(phandle handle);
>  #endif
>  
>  #if defined(CONFIG_OF_OVERLAY)
>  void of_overlay_mutex_lock(void);
>  void of_overlay_mutex_unlock(void);
> -int of_free_phandle_cache(void);
> -void of_populate_phandle_cache(void);
>  #else
>  static inline void of_overlay_mutex_lock(void) {};
>  static inline void of_overlay_mutex_unlock(void) {};
> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> index 9617b7df7c4d..97fe92c1f1d2 100644
> --- a/drivers/of/overlay.c
> +++ b/drivers/of/overlay.c
> @@ -974,8 +974,6 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
>  		goto err_free_overlay_changeset;
>  	}
>  
> -	of_populate_phandle_cache();
> -
>  	ret = __of_changeset_apply_notify(&ovcs->cset);
>  	if (ret)
>  		pr_err("overlay apply changeset entry notify error %d\n", ret);
> @@ -1218,17 +1216,9 @@ int of_overlay_remove(int *ovcs_id)
>  
>  	list_del(&ovcs->ovcs_list);
>  
> -	/*
> -	 * Disable phandle cache.  Avoids race condition that would arise
> -	 * from removing cache entry when the associated node is deleted.
> -	 */
> -	of_free_phandle_cache();
> -
>  	ret_apply = 0;
>  	ret = __of_changeset_revert_entries(&ovcs->cset, &ret_apply);
>  
> -	of_populate_phandle_cache();
> -
>  	if (ret) {
>  		if (ret_apply)
>  			devicetree_state_flags |= DTSF_REVERT_FAIL;
> 

