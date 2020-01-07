Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD62C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A1E724679
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578433688;
	bh=HYXtPWiExIvmXN8sRzAJ6Hbzti2Pmd9+VN7SsmWvlIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Nxsjpy8pjWxtCp2xAUzlRzlD6bgfLc6SusPjKX0rMeVIu8SCryFyw9WpZX/wYYzIj
	 +igMoGF91//Soy9y6E/ELe3cfALpCwU7bWQcFYKvZ5VNEEVZLzSr4YvxcsIP1ct0Kk
	 dIeloJH/Pkc561ECbWr3vdndf9wFnaVk6p6z0PKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbgAGVsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:48:06 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33973 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbgAGVsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:48:05 -0500
Received: by mail-wr1-f65.google.com with SMTP id t2so1262965wrr.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 13:48:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uqTwG7GMHoSbizcHPVACfQSquX5LQFYhMQGPdUwVoLA=;
        b=DmT/GATU1hrdenP5n6EOV2K3ufSP2/cYjmZ6rO9LJU64LNot2+Ws3F6e3nGyZUdUBL
         WadCmZ+ABTJXu5cfpwdgucmvjngN05gMSqtRRpRw+Wd2bgskfZ0hZZV1K/XieiysyvYZ
         FPhG56VC4CjSNkDNuybppT3qL+RXRV8hWu9Qu6UwhzfO+i42P/2WXSJxTkBMYfk1VSp1
         yQkGNiTTrWi6KdZJ+49xSp2/DHREgoAwS0u/fn3Yu0ZiGwo5LW5N0VhQGYnLmbfQtmIW
         zGRynRCiNE8gxAoiZeN8X6YkWufMlWECuxytx6dvkfcgANmlDV7kRLqeEP4vka+KS2gt
         iRqw==
X-Gm-Message-State: APjAAAWtzVP4B7bhOkgP5CaFwnTF0Gj9PoPPcwlUV/NdIG0yloKU8WXv
        R9tNYY8unKVKwrV24qyGgLI=
X-Google-Smtp-Source: APXvYqygQ0cxb/6LjxaayZ1X+wFAyHADcfaZhdbJwv5f6EUAo/Ymo4f4sXzagKrpZf9MMBK33u6wyw==
X-Received: by 2002:adf:c145:: with SMTP id w5mr1095296wre.205.1578433683614;
        Tue, 07 Jan 2020 13:48:03 -0800 (PST)
Received: from localhost (ip-37-188-146-105.eurotel.cz. [37.188.146.105])
        by smtp.gmail.com with ESMTPSA id s8sm1434644wrt.57.2020.01.07.13.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 13:48:02 -0800 (PST)
Date:   Tue, 7 Jan 2020 22:48:01 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Scott Cheloha <cheloha@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Hildenbrand <david@redhat.com>, nathanl@linux.ibm.com,
        ricklind@linux.vnet.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] drivers/base/memory.c: cache blocks in radix tree to
 accelerate lookup
Message-ID: <20200107214801.GN32178@dhcp22.suse.cz>
References: <20191121195952.3728-1-cheloha@linux.vnet.ibm.com>
 <20191217193238.3098-1-cheloha@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217193238.3098-1-cheloha@linux.vnet.ibm.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc Andrew]

On Tue 17-12-19 13:32:38, Scott Cheloha wrote:
> Searching for a particular memory block by id is slow because each block
> device is kept in an unsorted linked list on the subsystem bus.

Noting that this is O(N^2) would be useful.

> Lookup is much faster if we cache the blocks in a radix tree.

While this is really easy and straightforward, is there any reason why
subsys_find_device_by_id has to use such a slow lookup? I suspect nobody
simply needed a more optimized data structure for that purpose yet.
Would it be too hard to use radix tree for all lookups rather than
adding a shadow copy for memblocks?

> Memory
> subsystem initialization and hotplug/hotunplug is at least a little faster
> for any machine with more than ~100 blocks, and the speedup grows with
> the block count.

If we are onlining one memblock after another and there are many of them
then this is going to help a some. Some numbers would be really nice.
If there are too many blocks then the biggest part of the overhead is
still there when registering each memblock though because that operation
is just very expensinve (e.g. udev notification).

> Signed-off-by: Scott Cheloha <cheloha@linux.vnet.ibm.com>
> Acked-by: David Hildenbrand <david@redhat.com>
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
> 2.24.0
> 

-- 
Michal Hocko
SUSE Labs
