Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A52C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 03:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C702467E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 03:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ao+PP2so"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfLSDiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 22:38:52 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:44186 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfLSDiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 22:38:51 -0500
Received: by mail-yb1-f193.google.com with SMTP id j6so1680724ybc.11;
        Wed, 18 Dec 2019 19:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jtkWS/yjiMKfkbXKI3WL2bmYpx2cmC+C53/JYQWDpLg=;
        b=Ao+PP2soFSK8LjCVBNMuoENGjdv4ZjnJclCDXm2GoMoycYi65cRSoPgrrIYTg6FHql
         CsgY38bOHWXTG2PcoR0wfm88F0yKdeSRVAHmeyMJY9KgFHb7/JDOKhMvmmgisRQpp9oJ
         wdFnMKtiOIs1EUgvRnqV2/a+ISd4GNVNwkywdi3oVkclNuZMYNs6BaTMymEuY22Jvhg3
         yCOh60yi0BUwyz26hyL33VKSsKxyadoRCi98fP+lhpMKfRI5GBR7VHp3LczGJ9nAr4vF
         ZmCS+5qNupDRmej5HWlk/PHFGvc9MVVCO7mbvXGHXGI6+PtN8A8rymOtscnYBd2RzvJ0
         fDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jtkWS/yjiMKfkbXKI3WL2bmYpx2cmC+C53/JYQWDpLg=;
        b=sJFycAJf30pBRZWTagUeSpCVEMctaemzZGKnmvEOJe3BSYBjVwRQYBeqd/jrJ7mVH6
         76D2WnuLYxqb76RYCe921BONH+p8w8P8oIFwzFOQSAk0uCvMmmVJCEBoXVB69zPm+hsS
         NfQYwqd+IFy2wxRUwk01sUiCp8Ad1b1e+Xc+WYfM8j7ycTLPgYEeLQ7JKhIP63T+iSD+
         JIVhTviOj/GU3qtZ04WazTjM4Wy4hdCIv7GdL22zyL6qWWhcRcwZoPT8Eu9oeOdL8Gzx
         t79rb9tS0ph1k0UnW2UehatjIWUO6Gg5ViO6K5BycllksBpJU80sNCX3mkfi9xG//D5Z
         D2WQ==
X-Gm-Message-State: APjAAAX/xno8zPUJvsggyLdkaVHHDjjfKZoz5qaMfjwIreO/gYTSXgeG
        OKhd+McZp4G1GDkv3YHh+Uk=
X-Google-Smtp-Source: APXvYqyoE6Ngf4u83Jj2Vxp2qtUNRbQ9N2YgAOGdR2TzcOIFgS39rDf1SN/qdXTr8IC1ynOpXy4IlQ==
X-Received: by 2002:a5b:d4f:: with SMTP id f15mr4685436ybr.134.1576726729988;
        Wed, 18 Dec 2019 19:38:49 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id y129sm1877181ywd.40.2019.12.18.19.38.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Dec 2019 19:38:49 -0800 (PST)
Subject: Re: [PATCH] of: Rework and simplify phandle cache to use a fixed size
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Chintan Pandya <cpandya@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>
References: <20191211232345.24810-1-robh@kernel.org>
 <9a0c89aa-4d16-a8b8-8643-40bb130d0cc5@gmail.com>
Message-ID: <da376ece-1c1c-c074-4b5d-9ec3aae637d8@gmail.com>
Date:   Wed, 18 Dec 2019 21:38:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <9a0c89aa-4d16-a8b8-8643-40bb130d0cc5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


-Chintan

On 12/12/19 5:50 AM, Frank Rowand wrote:
> 
> +Chintan
> 
> Hi Chintan,
> 
> On 12/11/19 5:23 PM, Rob Herring wrote:
>> The phandle cache was added to speed up of_find_node_by_phandle() by
>> avoiding walking the whole DT to find a matching phandle. The
>> implementation has several shortcomings:
>>
>>   - The cache is designed to work on a linear set of phandle values.
>>     This is true for dtc generated DTs, but not for other cases such as
>>     Power.
>>   - The cache isn't enabled until of_core_init() and a typical system
>>     may see hundreds of calls to of_find_node_by_phandle() before that
>>     point.
>>   - The cache is freed and re-allocated when the number of phandles
>>     changes.
>>   - It takes a raw spinlock around a memory allocation which breaks on
>>     RT.
>>
>> Change the implementation to a fixed size and use hash_32() as the
>> cache index. This greatly simplifies the implementation. It avoids
>> the need for any re-alloc of the cache and taking a reference on nodes
>> in the cache. We only have a single source of removing cache entries
>> which is of_detach_node().
> 
> Can you check this patch on the system that you reported phandle lookup
> overhead issues for?

Adding Chintan to the distribution list was not successful -- his email
address bounces.

If anyone else from Qualcomm wants to look at this, the system Chintan
was measuring was:

https://source.codeaurora.org/quic/la/kernel/msm-4.9/tree/arch/arm64/boot/dts/qcom/sda670-mtp.dts?h=msm-4.9

The various email threads were in January and February 2018.

-Frank

> 
> -Frank
> 
> 
>>
>> Using hash_32() removes any assumption on phandle values improving
>> the hit rate for non-linear phandle values. The effect on linear values
>> using hash_32() is about a 10% collision. The chances of thrashing on
>> colliding values seems to be low.
>>
>> To compare performance, I used a RK3399 board which is a pretty typical
>> system. I found that just measuring boot time as done previously is
>> noisy and may be impacted by other things. Also bringing up secondary
>> cores causes some issues with measuring, so I booted with 'nr_cpus=1'.
>> With no caching, calls to of_find_node_by_phandle() take about 20124 us
>> for 1248 calls. There's an additional 288 calls before time keeping is
>> up. Using the average time per hit/miss with the cache, we can calculate
>> these calls to take 690 us (277 hit / 11 miss) with a 128 entry cache
>> and 13319 us with no cache or an uninitialized cache.
>>
>> Comparing the 3 implementations the time spent in
>> of_find_node_by_phandle() is:
>>
>> no cache:        20124 us (+ 13319 us)
>> 128 entry cache:  5134 us (+ 690 us)
>> current cache:     819 us (+ 13319 us)
>>
>> We could move the allocation of the cache earlier to improve the
>> current cache, but that just further complicates the situation as it
>> needs to be after slab is up, so we can't do it when unflattening (which
>> uses memblock).
>>
>> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Segher Boessenkool <segher@kernel.crashing.org>
>> Cc: Frank Rowand <frowand.list@gmail.com>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>>  drivers/of/base.c       | 133 ++++++++--------------------------------
>>  drivers/of/dynamic.c    |   2 +-
>>  drivers/of/of_private.h |   4 +-
>>  drivers/of/overlay.c    |  10 ---
>>  4 files changed, 28 insertions(+), 121 deletions(-)
>>
>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>> index db7fbc0c0893..f7da162f126d 100644
>> --- a/drivers/of/base.c
>> +++ b/drivers/of/base.c
>> @@ -135,115 +135,38 @@ int __weak of_node_to_nid(struct device_node *np)
>>  }
>>  #endif
>>  
>> -/*
>> - * Assumptions behind phandle_cache implementation:
>> - *   - phandle property values are in a contiguous range of 1..n
>> - *
>> - * If the assumptions do not hold, then
>> - *   - the phandle lookup overhead reduction provided by the cache
>> - *     will likely be less
>> - */
>> +#define OF_PHANDLE_CACHE_BITS	7
>> +#define OF_PHANDLE_CACHE_SZ	BIT(OF_PHANDLE_CACHE_BITS)
>>  
>> -static struct device_node **phandle_cache;
>> -static u32 phandle_cache_mask;
>> +static struct device_node *phandle_cache[OF_PHANDLE_CACHE_SZ];
>>  
>> -/*
>> - * Caller must hold devtree_lock.
>> - */
>> -static void __of_free_phandle_cache(void)
>> +static u32 of_phandle_cache_hash(phandle handle)
>>  {
>> -	u32 cache_entries = phandle_cache_mask + 1;
>> -	u32 k;
>> -
>> -	if (!phandle_cache)
>> -		return;
>> -
>> -	for (k = 0; k < cache_entries; k++)
>> -		of_node_put(phandle_cache[k]);
>> -
>> -	kfree(phandle_cache);
>> -	phandle_cache = NULL;
>> +	return hash_32(handle, OF_PHANDLE_CACHE_BITS);
>>  }
>>  
>> -int of_free_phandle_cache(void)
>> -{
>> -	unsigned long flags;
>> -
>> -	raw_spin_lock_irqsave(&devtree_lock, flags);
>> -
>> -	__of_free_phandle_cache();
>> -
>> -	raw_spin_unlock_irqrestore(&devtree_lock, flags);
>> -
>> -	return 0;
>> -}
>> -#if !defined(CONFIG_MODULES)
>> -late_initcall_sync(of_free_phandle_cache);
>> -#endif
>> -
>>  /*
>>   * Caller must hold devtree_lock.
>>   */
>> -void __of_free_phandle_cache_entry(phandle handle)
>> +void __of_phandle_cache_inv_entry(phandle handle)
>>  {
>> -	phandle masked_handle;
>> +	u32 handle_hash;
>>  	struct device_node *np;
>>  
>>  	if (!handle)
>>  		return;
>>  
>> -	masked_handle = handle & phandle_cache_mask;
>> +	handle_hash = of_phandle_cache_hash(handle);
>>  
>> -	if (phandle_cache) {
>> -		np = phandle_cache[masked_handle];
>> -		if (np && handle == np->phandle) {
>> -			of_node_put(np);
>> -			phandle_cache[masked_handle] = NULL;
>> -		}
>> -	}
>> -}
>> -
>> -void of_populate_phandle_cache(void)
>> -{
>> -	unsigned long flags;
>> -	u32 cache_entries;
>> -	struct device_node *np;
>> -	u32 phandles = 0;
>> -
>> -	raw_spin_lock_irqsave(&devtree_lock, flags);
>> -
>> -	__of_free_phandle_cache();
>> -
>> -	for_each_of_allnodes(np)
>> -		if (np->phandle && np->phandle != OF_PHANDLE_ILLEGAL)
>> -			phandles++;
>> -
>> -	if (!phandles)
>> -		goto out;
>> -
>> -	cache_entries = roundup_pow_of_two(phandles);
>> -	phandle_cache_mask = cache_entries - 1;
>> -
>> -	phandle_cache = kcalloc(cache_entries, sizeof(*phandle_cache),
>> -				GFP_ATOMIC);
>> -	if (!phandle_cache)
>> -		goto out;
>> -
>> -	for_each_of_allnodes(np)
>> -		if (np->phandle && np->phandle != OF_PHANDLE_ILLEGAL) {
>> -			of_node_get(np);
>> -			phandle_cache[np->phandle & phandle_cache_mask] = np;
>> -		}
>> -
>> -out:
>> -	raw_spin_unlock_irqrestore(&devtree_lock, flags);
>> +	np = phandle_cache[handle_hash];
>> +	if (np && handle == np->phandle)
>> +		phandle_cache[handle_hash] = NULL;
>>  }
>>  
>>  void __init of_core_init(void)
>>  {
>>  	struct device_node *np;
>>  
>> -	of_populate_phandle_cache();
>>  
>>  	/* Create the kset, and register existing nodes */
>>  	mutex_lock(&of_mutex);
>> @@ -253,8 +176,11 @@ void __init of_core_init(void)
>>  		pr_err("failed to register existing nodes\n");
>>  		return;
>>  	}
>> -	for_each_of_allnodes(np)
>> +	for_each_of_allnodes(np) {
>>  		__of_attach_node_sysfs(np);
>> +		if (np->phandle && !phandle_cache[of_phandle_cache_hash(np->phandle)])
>> +			phandle_cache[of_phandle_cache_hash(np->phandle)] = np;
>> +	}
>>  	mutex_unlock(&of_mutex);
>>  
>>  	/* Symlink in /proc as required by userspace ABI */
>> @@ -1235,36 +1161,29 @@ struct device_node *of_find_node_by_phandle(phandle handle)
>>  {
>>  	struct device_node *np = NULL;
>>  	unsigned long flags;
>> -	phandle masked_handle;
>> +	u32 handle_hash;
>>  
>>  	if (!handle)
>>  		return NULL;
>>  
>> +	handle_hash = of_phandle_cache_hash(handle);
>> +
>>  	raw_spin_lock_irqsave(&devtree_lock, flags);
>>  
>> -	masked_handle = handle & phandle_cache_mask;
>> -
>> -	if (phandle_cache) {
>> -		if (phandle_cache[masked_handle] &&
>> -		    handle == phandle_cache[masked_handle]->phandle)
>> -			np = phandle_cache[masked_handle];
>> -		if (np && of_node_check_flag(np, OF_DETACHED)) {
>> -			WARN_ON(1); /* did not uncache np on node removal */
>> -			of_node_put(np);
>> -			phandle_cache[masked_handle] = NULL;
>> -			np = NULL;
>> -		}
>> +	if (phandle_cache[handle_hash] &&
>> +	    handle == phandle_cache[handle_hash]->phandle)
>> +		np = phandle_cache[handle_hash];
>> +	if (np && of_node_check_flag(np, OF_DETACHED)) {
>> +		WARN_ON(1); /* did not uncache np on node removal */
>> +		phandle_cache[handle_hash] = NULL;
>> +		np = NULL;
>>  	}
>>  
>>  	if (!np) {
>>  		for_each_of_allnodes(np)
>>  			if (np->phandle == handle &&
>>  			    !of_node_check_flag(np, OF_DETACHED)) {
>> -				if (phandle_cache) {
>> -					/* will put when removed from cache */
>> -					of_node_get(np);
>> -					phandle_cache[masked_handle] = np;
>> -				}
>> +				phandle_cache[handle_hash] = np;
>>  				break;
>>  			}
>>  	}
>> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
>> index 49b16f76d78e..08fd823edac9 100644
>> --- a/drivers/of/dynamic.c
>> +++ b/drivers/of/dynamic.c
>> @@ -276,7 +276,7 @@ void __of_detach_node(struct device_node *np)
>>  	of_node_set_flag(np, OF_DETACHED);
>>  
>>  	/* race with of_find_node_by_phandle() prevented by devtree_lock */
>> -	__of_free_phandle_cache_entry(np->phandle);
>> +	__of_phandle_cache_inv_entry(np->phandle);
>>  }
>>  
>>  /**
>> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
>> index 66294d29942a..582844c158ae 100644
>> --- a/drivers/of/of_private.h
>> +++ b/drivers/of/of_private.h
>> @@ -85,14 +85,12 @@ int of_resolve_phandles(struct device_node *tree);
>>  #endif
>>  
>>  #if defined(CONFIG_OF_DYNAMIC)
>> -void __of_free_phandle_cache_entry(phandle handle);
>> +void __of_phandle_cache_inv_entry(phandle handle);
>>  #endif
>>  
>>  #if defined(CONFIG_OF_OVERLAY)
>>  void of_overlay_mutex_lock(void);
>>  void of_overlay_mutex_unlock(void);
>> -int of_free_phandle_cache(void);
>> -void of_populate_phandle_cache(void);
>>  #else
>>  static inline void of_overlay_mutex_lock(void) {};
>>  static inline void of_overlay_mutex_unlock(void) {};
>> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
>> index 9617b7df7c4d..97fe92c1f1d2 100644
>> --- a/drivers/of/overlay.c
>> +++ b/drivers/of/overlay.c
>> @@ -974,8 +974,6 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
>>  		goto err_free_overlay_changeset;
>>  	}
>>  
>> -	of_populate_phandle_cache();
>> -
>>  	ret = __of_changeset_apply_notify(&ovcs->cset);
>>  	if (ret)
>>  		pr_err("overlay apply changeset entry notify error %d\n", ret);
>> @@ -1218,17 +1216,9 @@ int of_overlay_remove(int *ovcs_id)
>>  
>>  	list_del(&ovcs->ovcs_list);
>>  
>> -	/*
>> -	 * Disable phandle cache.  Avoids race condition that would arise
>> -	 * from removing cache entry when the associated node is deleted.
>> -	 */
>> -	of_free_phandle_cache();
>> -
>>  	ret_apply = 0;
>>  	ret = __of_changeset_revert_entries(&ovcs->cset, &ret_apply);
>>  
>> -	of_populate_phandle_cache();
>> -
>>  	if (ret) {
>>  		if (ret_apply)
>>  			devicetree_state_flags |= DTSF_REVERT_FAIL;
>>
> 
> 

