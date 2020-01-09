Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62415C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 21:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3982077C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 21:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578605421;
	bh=e0TltHaxY5qwZ235nyJbGXeMfpJO87KKMsKlVA2GmvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rEzLoXFZfbHegKbRdK83MgkE0QVSH4ee0a/oV83Wor8z4gQ8w577UQ6yPzSSn4lpM
	 il/tnjHKzN/baC/nEUhZK8zzuvOaBJkYZHL6K9pWFrdCM5LLqSb8IG83uBCxnLFW11
	 VY11tBqG2SKtRaAijQvY2mU0raTuySavqnAflrdM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgAIVaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 16:30:20 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55843 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgAIVaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 16:30:19 -0500
Received: by mail-wm1-f68.google.com with SMTP id q9so4571385wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 13:30:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=opP4AiEbQ4+4R4cSYrpmUsBuH43MT66L8dsex+GXkto=;
        b=g3b2fGrdLv98XLy856tuVrC80p2O+CeSkHkd3SJbOtSuMWZ/A/JC14I9TZLynfk1bB
         MHCkfwmirSILwCwSaeJvHq6DpNIOpZ7VmUPn/DogRqt4hq7tifK14s/Mm0WQwXa2ftgj
         uSQizjwu+z8vsVa/ppq9D6Yt0px1Nil+VFq46IL4KHcdrJ6JQ4yaTMyQQFGRtmVYdwIk
         KJDMHFaQ7VmwU5zKgH3oq7L8ZoO0WlEAtC5mTOibWcnGS2gRC8gDiATAifKylNU8Tfz8
         yfbYpcwsJECwbq/qM7TZSagabVKqPvQ2nyEuY3t3sksLylDgpOdvqu2EwYeAgQRSP0qG
         YvVw==
X-Gm-Message-State: APjAAAX4Ei8BH9Lo9bOi0Ff+5j3Fb/BHEQ1QPrcspJH/M6CuGe3zzlFa
        DmrDd8cxDQieNiOuUS4zZAA=
X-Google-Smtp-Source: APXvYqwGxQeljwiZyxUtA/sXImY0oZrP8pcF16NC6nURdZGcgcRjjf/gopu5oja5ec5TIc0eAiGCtw==
X-Received: by 2002:a7b:cb91:: with SMTP id m17mr24303wmi.146.1578605417524;
        Thu, 09 Jan 2020 13:30:17 -0800 (PST)
Received: from localhost (ip-37-188-146-105.eurotel.cz. [37.188.146.105])
        by smtp.gmail.com with ESMTPSA id p18sm4272660wmb.8.2020.01.09.13.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 13:30:16 -0800 (PST)
Date:   Thu, 9 Jan 2020 22:30:14 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Scott Cheloha <cheloha@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        nathanl@linux.ibm.com, ricklind@linux.vnet.ibm.com,
        Scott Cheloha <cheloha@linux.ibm.com>
Subject: Re: [PATCH] drivers/base/memory.c: cache blocks in radix tree to
 accelerate lookup
Message-ID: <20200109213014.GC23620@dhcp22.suse.cz>
References: <20191217193238-1-cheloha@linux.vnet.ibm.com>
 <20200109211952.12747-1-cheloha@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109211952.12747-1-cheloha@linux.vnet.ibm.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 09-01-20 15:19:52, Scott Cheloha wrote:
> Searching for a particular memory block by id is an O(n) operation
> because each memory block's underlying device is kept in an unsorted
> linked list on the subsystem bus.
> 
> We can cut the lookup cost to O(log n) if we cache the memory blocks in
> a radix tree.  With a radix tree cache in place both memory subsystem
> initialization and memory hotplug run palpably faster on systems with a
> large number of memory blocks.
> 
> Signed-off-by: Scott Cheloha <cheloha@linux.ibm.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Nathan Lynch <nathanl@linux.ibm.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> ---
> v2 incorporates suggestions from David Hildenbrand.
> 
> v3 changes:
>   - Rebase atop "drivers/base/memory.c: drop the mem_sysfs_mutex"
> 
>   - Be conservative: don't use radix_tree_for_each_slot() in
>     walk_memory_blocks() yet.  It introduces RCU which could
>     change behavior.  Walking the tree "by hand" with
>     find_memory_block_by_id() is slower but keeps the patch
>     simple.
> 
> v4 changes:
>   - Rewrite commit message to explicitly note the time
>     complexity improvements.
> 
>   - Provide anecdotal accounts of time-savings in the changelog
>     (see below).
> 
> mhocko@suse.com has asked for additional details on time
> savings, so here are some results I've collected when measuring
> memory_dev_init() with/without the patch.

This data should be part of the changelog. Thanks!

> 1. A 32GB POWER9 VM with 16MB memblocks has 2048 blocks:
> 
> # Unpatched
> [    0.005121] adding memory block 0... ok
> [...]
> [    0.095230] adding memory block 1024... ok
> [...]
> [    0.304248] adding memory block 2047... ok
> [    0.304508] added all memory blocks
> 
> # Patched
> [    0.004701] adding memory block 0... ok
> [...]
> [    0.033383] adding memory block 1024... ok
> [...]
> [    0.061387] adding memory block 2047... ok
> [    0.061414] added all memory blocks
> 
>    Unpatched, memory_dev_init() runs in about 0.299 seconds.  Patched,
>    it runs in about 0.057 seconds.  Savings of .242 seconds, or nearly
>    a quarter of a second.
> 
> 2. A 32TB POWER9 LPAR with 256MB memblocks has 131072 blocks:
> 
> # Unpatched
> [   13.703907] memory_dev_init: adding blocks
> [   13.703931] memory_dev_init: added block 0
> [   13.762678] memory_dev_init: added block 1024
> [   13.910359] memory_dev_init: added block 2048
> [   14.146941] memory_dev_init: added block 3072
> [...]
> [  218.516235] memory_dev_init: added block 57344
> [  229.310467] memory_dev_init: added block 58368
> [  240.590857] memory_dev_init: added block 59392
> [  252.351665] memory_dev_init: added block 60416
> [...]
> [ 2152.023248] memory_dev_init: added block 128000
> [ 2196.464430] memory_dev_init: added block 129024
> [ 2241.746515] memory_dev_init: added block 130048
> [ 2287.406099] memory_dev_init: added all blocks
> 
> # Patched
> [   13.696898] memory_dev_init: adding blocks
> [   13.696920] memory_dev_init: added block 0
> [   13.710966] memory_dev_init: added block 1024
> [   13.724865] memory_dev_init: added block 2048
> [   13.738802] memory_dev_init: added block 3072
> [...]
> [   14.520999] memory_dev_init: added block 57344
> [   14.536355] memory_dev_init: added block 58368
> [   14.551747] memory_dev_init: added block 59392
> [   14.567128] memory_dev_init: added block 60416
> [...]
> [   15.595638] memory_dev_init: added block 126976
> [   15.611761] memory_dev_init: added block 128000
> [   15.627889] memory_dev_init: added block 129024
> [   15.644048] memory_dev_init: added block 130048
> [   15.660035] memory_dev_init: added all blocks
> 
>    Unpatched, memory_dev_init() runs in about 2275 seconds,
>    or ~37 minutes.  Patched, memory_dev_init() runs in about
>    1.97 seconds.  Savings of ~37 minutes.
> 
>    I did not actually measure walk_memory_blocks(), but during
>    boot on this machine without the patch I got the following
>    (abbreviated) traces:
> 
> [ 2347.494986] [c000000014c5bb60] [c000000000869af4] walk_memory_blocks+0x94/0x160
> [ 2527.625378] [c000000014c5bb60] [c000000000869af4] walk_memory_blocks+0x94/0x160
> [ 2707.761977] [c000000014c5bb60] [c000000000869af4] walk_memory_blocks+0x94/0x160
> [ 2887.899975] [c000000014c5bb60] [c000000000869af4] walk_memory_blocks+0x94/0x160
> [ 3068.028318] [c000000014c5bb60] [c000000000869af4] walk_memory_blocks+0x94/0x160
> [ 3248.158764] [c000000014c5bb60] [c000000000869af4] walk_memory_blocks+0x94/0x160
> [ 3428.287296] [c000000014c5bb60] [c000000000869af4] walk_memory_blocks+0x94/0x160
> [ 3608.425357] [c000000014c5bb60] [c000000000869af4] walk_memory_blocks+0x94/0x160
> [ 3788.554572] [c000000014c5bb60] [c000000000869af4] walk_memory_blocks+0x94/0x160
> [ 3968.695071] [c000000014c5bb60] [c000000000869af4] walk_memory_blocks+0x94/0x160
> [ 4148.823970] [c000000014c5bb60] [c000000000869af4] walk_memory_blocks+0x94/0x160
> 
>    Those traces disappeared with the patch, so I'm pretty sure
>    this patch shaves ~30 minutes off of walk_memory_blocks()
>    at boot.
> 
> Given the above results I think it is safe to say that this patch will
> dramatically improve boot times on large POWER systems.
> 
>  drivers/base/memory.c | 36 +++++++++++++++++++++++-------------
>  1 file changed, 23 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 799b43191dea..8902930d5ef2 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -19,6 +19,7 @@
>  #include <linux/memory.h>
>  #include <linux/memory_hotplug.h>
>  #include <linux/mm.h>
> +#include <linux/radix-tree.h>
>  #include <linux/stat.h>
>  #include <linux/slab.h>
>  
> @@ -56,6 +57,13 @@ static struct bus_type memory_subsys = {
>  	.offline = memory_subsys_offline,
>  };
>  
> +/*
> + * Memory blocks are cached in a local radix tree to avoid
> + * a costly linear search for the corresponding device on
> + * the subsystem bus.
> + */
> +static RADIX_TREE(memory_blocks, GFP_KERNEL);
> +
>  static BLOCKING_NOTIFIER_HEAD(memory_chain);
>  
>  int register_memory_notifier(struct notifier_block *nb)
> @@ -572,20 +580,14 @@ int __weak arch_get_memory_phys_device(unsigned long start_pfn)
>  /* A reference for the returned memory block device is acquired. */
>  static struct memory_block *find_memory_block_by_id(unsigned long block_id)
>  {
> -	struct device *dev;
> +	struct memory_block *mem;
>  
> -	dev = subsys_find_device_by_id(&memory_subsys, block_id, NULL);
> -	return dev ? to_memory_block(dev) : NULL;
> +	mem = radix_tree_lookup(&memory_blocks, block_id);
> +	if (mem)
> +		get_device(&mem->dev);
> +	return mem;
>  }
>  
> -/*
> - * For now, we have a linear search to go find the appropriate
> - * memory_block corresponding to a particular phys_index. If
> - * this gets to be a real problem, we can always use a radix
> - * tree or something here.
> - *
> - * This could be made generic for all device subsystems.
> - */
>  struct memory_block *find_memory_block(struct mem_section *section)
>  {
>  	unsigned long block_id = base_memory_block_id(__section_nr(section));
> @@ -628,9 +630,15 @@ int register_memory(struct memory_block *memory)
>  	memory->dev.offline = memory->state == MEM_OFFLINE;
>  
>  	ret = device_register(&memory->dev);
> -	if (ret)
> +	if (ret) {
>  		put_device(&memory->dev);
> -
> +		return ret;
> +	}
> +	ret = radix_tree_insert(&memory_blocks, memory->dev.id, memory);
> +	if (ret) {
> +		put_device(&memory->dev);
> +		device_unregister(&memory->dev);
> +	}
>  	return ret;
>  }
>  
> @@ -688,6 +696,8 @@ static void unregister_memory(struct memory_block *memory)
>  	if (WARN_ON_ONCE(memory->dev.bus != &memory_subsys))
>  		return;
>  
> +	WARN_ON(radix_tree_delete(&memory_blocks, memory->dev.id) == NULL);
> +
>  	/* drop the ref. we got via find_memory_block() */
>  	put_device(&memory->dev);
>  	device_unregister(&memory->dev);
> -- 
> 2.24.1

-- 
Michal Hocko
SUSE Labs
