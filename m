Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3A8C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 037EA20678
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578563312;
	bh=m+UQ+q1bLF1ujlcVSbh8EpQonTNkNaBCgnDIa9dh3hY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t7hyQwuAA9I8JGm2vnNREflXYi2EC6clHHynBjdMSgMSkGWqdoGGVc4GYwBuFnjbs
	 5VOjW2g7eIwGuPRvAiHxT/0elyJ2pjT48UzaCLjdSxaFueDjzyHPVgYksGF0nLJ79G
	 5R+hS0Frd1udrSu2FHeA8ygJOCqB9e1/Dzu9muEg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbgAIJsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:48:30 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55504 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729170AbgAIJsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:48:30 -0500
Received: by mail-wm1-f65.google.com with SMTP id q9so2126621wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 01:48:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VpQvERxakUZ1UL5EKNg0L8sNveIoCSm0oaTrp1MgJb4=;
        b=q36hY4oBiccRb1WYx1L3KBZ+kr5sR2hq8ivrdm06+it2Ldtyx6V5d3A0SbNQD1tFOu
         eAZOlYdb7WJTy4ykYrJ4T4SJ4IPl3Ty8I85dUyCMICfP0iJD82vzOYXTk+9cnCXw2GS4
         d4xpYgbLf/BjopSzd7DgBAtYSc348hiMCohwwINxa2w/jnO6zfpbx73yv7UuhzwhIr6D
         bjWe02eUuwoefdqd4deoju3kAgTtks05+k2ZlM5DNuE72K+NU0akl1u/ZXtxgRiT5RsT
         KFojJmJ5vQx4e1NhjWf0hAwSUjBOkS2ix4YtifP1ovhps6iL7bK/SRXVbS13FRFwluna
         zHhQ==
X-Gm-Message-State: APjAAAWivccyKqQaObcx8jNV6B1zx6d9i9b9bi3fS8UkwMojohzHCAsf
        wEa8G/6h485oSMQmOSHsj6o=
X-Google-Smtp-Source: APXvYqz4ON2jA2tWcodHRXkhlMmnRg1j/DLkhL9fuPcAPKIuylCJPzptCS14N8LmSw9VHitEKQrWOQ==
X-Received: by 2002:a1c:22c6:: with SMTP id i189mr3954852wmi.15.1578563308233;
        Thu, 09 Jan 2020 01:48:28 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id d10sm7798233wrw.64.2020.01.09.01.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 01:48:27 -0800 (PST)
Date:   Thu, 9 Jan 2020 10:48:26 +0100
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
Message-ID: <20200109094826.GL4951@dhcp22.suse.cz>
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

On Tue 17-12-19 13:32:38, Scott Cheloha wrote:
> Searching for a particular memory block by id is slow because each block
> device is kept in an unsorted linked list on the subsystem bus.
> 
> Lookup is much faster if we cache the blocks in a radix tree.  Memory
> subsystem initialization and hotplug/hotunplug is at least a little faster
> for any machine with more than ~100 blocks, and the speedup grows with
> the block count.
> 
> Signed-off-by: Scott Cheloha <cheloha@linux.vnet.ibm.com>
> Acked-by: David Hildenbrand <david@redhat.com>

OK, Greg doesn't see demand for abstracting a faster lookup into the
core so making a memory subsystem thing sounds like the way to go.
Please add more information about time savings into the changelog and
then feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>

Do not forget to add Andrew to the Cc when resubmitting.

Thanks!

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
