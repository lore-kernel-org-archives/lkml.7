Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E6CC2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 15:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4736A206EC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 15:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+eXG3JS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfLSPv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 10:51:26 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46790 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbfLSPvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 10:51:25 -0500
Received: by mail-yb1-f194.google.com with SMTP id v15so2330103ybp.13;
        Thu, 19 Dec 2019 07:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y04k/X8P1HevYByohJ8MsRDsBGn7Xg9/YVO/qGFZjfE=;
        b=K+eXG3JSpCfqKt1P34atDQFSa+e/OzWnbYeLnxaRUag57oE+E82sgOzwOl1JbBp9mu
         jVhybPb51oaeRnDiYM+tXrgGaFYALXgfoX/8R8mcBdmgn/9erXMoTt2h70zsHOcg2ExG
         TSl93Cd8RhKcbK6NYABFIOyFitqUy1lnYGdNnnYmbbnXvoouxwHmIzvIyUHMT+2wQ4l4
         4JByCCwM/4tLkLXeCxfsfnpKDBrOdcl4z/6LGc14YfD703BrR309PZaC+z7EJUSpoaa+
         /D+vOUAuGz8vLzjwgZc+hU4M2DojiVKD8zcJuPKmjSS5QBBkSC+ev93ZGJzErzjCnQ4R
         1SCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y04k/X8P1HevYByohJ8MsRDsBGn7Xg9/YVO/qGFZjfE=;
        b=tm8/e8AQPG7wcX/MHc+UbGPqHmZ43ibzIvQpYga0T5uNiScbScXZG0xguIeBWKhVZi
         N2Qa2Q0pWpOnQNBp31mcDYqhVVOcOZWARxsk83PowTD138sSG6pPGxnejiPUUyoPq8Gt
         KetYBmHuy176RCZ2s1ii2j2I378jGio6jUz1dpGhRbNWyruRa3LpmAnvrAVeLFfhAkWS
         8ltHiVu5trqyRMkY6Yl2fUldirCTRJHkMifznuO86d1CX3RwvBW/yiXI1roEGcKvbQxO
         CxZDziLSR9OMagxp9UhKIAOtM4dvXGgcvM6znp5uQZuZGl+jiY+XHgK5ihLQc3YZOmRc
         flzw==
X-Gm-Message-State: APjAAAVagr48FNfHiZBvs7FEKM61+pnErSpU1ghv7lr4L9JlZvoH7Wxj
        LmN3eYfTKk1nWbpfKxgkDb0=
X-Google-Smtp-Source: APXvYqwsgJqThuZiCb5UcLws3EtwPqcad+PySJRsZqmpnxq3ohfufM16nbgRNM+jCI7T62dE/Pq+XA==
X-Received: by 2002:a25:3c87:: with SMTP id j129mr6331397yba.400.1576770684650;
        Thu, 19 Dec 2019 07:51:24 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id w74sm2651146ywa.71.2019.12.19.07.51.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 07:51:24 -0800 (PST)
Subject: Re: [PATCH] of: Rework and simplify phandle cache to use a fixed size
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>
References: <20191211232345.24810-1-robh@kernel.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <fbeb2d11-9a6a-9f56-8a78-231136f349a7@gmail.com>
Date:   Thu, 19 Dec 2019 09:51:23 -0600
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

The patch changes phandle_cache to be a statically declared object, not
a dynamically allocated object, so I don't see why the cache populating
could not be moved earlier.  Not a big deal though.

On another note...
I am not happy that no one has bothered to check the performance impact
on the system that was the justification for finally implementing the
phandle cache.  I added the person who reported the performance problem
(Chintan Pandya) to the distribution list for the patch, but that address
bounced and no one else from Qualcomm has commented in this thread or
the related thread that led to this patch.  I am not unhappy enough
to delay this patch.

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

This results in gcc and sparse warnings for drivers/of/base.c when
CONFIG_OF_DYNAMIC is not defined because base.c does not wrap the
function with the same "#if defined(".

Should the "# if defined(" be removed from of_private.h?  Or
added to base.c?


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

Reviewed-by: Frank Rowand <frowand.list@gmail.com>
Tested-by: Frank Rowand <frowand.list@gmail.com>
