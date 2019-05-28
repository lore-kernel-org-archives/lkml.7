Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EF9C072B1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 11:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C84208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 11:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559042590;
	bh=xCTbSkA9E2ZK9Qb5B/KmXzjAxM64rKW0LvN/KmsTp44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=n7H8pfGQs5UQRCDPpoImUC+ThJOc6N7IHco06awGR/JpPIDjkyxx9l1MKpz1CdupY
	 8B2HI6gXx9S3svu+8HVfWCpLLSEq9KuZewT499G5ZzXYCxt27xwKdi0uNSvlPKBXyX
	 xz5KhNdu4AlUvPgY1v5C1LF/Y/1+W8zRszvPro8c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfE1LXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 07:23:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:47690 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726313AbfE1LXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 07:23:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1EFA0AF42;
        Tue, 28 May 2019 11:23:07 +0000 (UTC)
Date:   Tue, 28 May 2019 13:23:05 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nvdimm@lists.01.org,
        akpm@linux-foundation.org, dave.hansen@linux.intel.com,
        dan.j.williams@intel.com, keith.busch@intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com, zwisler@kernel.org,
        thomas.lendacky@amd.com, ying.huang@intel.com,
        fengguang.wu@intel.com, bp@suse.de, bhelgaas@google.com,
        baiyaowei@cmss.chinamobile.com, tiwai@suse.de, jglisse@redhat.com,
        david@redhat.com
Subject: Re: [v6 2/3] mm/hotplug: make remove_memory() interface useable
Message-ID: <20190528112305.GX1658@dhcp22.suse.cz>
References: <20190517215438.6487-1-pasha.tatashin@soleen.com>
 <20190517215438.6487-3-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517215438.6487-3-pasha.tatashin@soleen.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 17-05-19 17:54:37, Pavel Tatashin wrote:
> As of right now remove_memory() interface is inherently broken. It tries
> to remove memory but panics if some memory is not offline. The problem
> is that it is impossible to ensure that all memory blocks are offline as
> this function also takes lock_device_hotplug that is required to
> change memory state via sysfs.
> 
> So, between calling this function and offlining all memory blocks there
> is always a window when lock_device_hotplug is released, and therefore,
> there is always a chance for a panic during this window.
> 
> Make this interface to return an error if memory removal fails. This way
> it is safe to call this function without panicking machine, and also
> makes it symmetric to add_memory() which already returns an error.

I was about to object because of the acpi hotremove but looking closer
acpi_memory_remove_memory and few others already do use __remove_memory
instead of remove_memory so this is good to go. I really hate how we had
to BUG in remove_memory as well so this is definitely a good change.

> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/memory_hotplug.h |  8 +++--
>  mm/memory_hotplug.c            | 64 +++++++++++++++++++++++-----------
>  2 files changed, 49 insertions(+), 23 deletions(-)
> 
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index ae892eef8b82..988fde33cd7f 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -324,7 +324,7 @@ static inline void pgdat_resize_init(struct pglist_data *pgdat) {}
>  extern bool is_mem_section_removable(unsigned long pfn, unsigned long nr_pages);
>  extern void try_offline_node(int nid);
>  extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages);
> -extern void remove_memory(int nid, u64 start, u64 size);
> +extern int remove_memory(int nid, u64 start, u64 size);
>  extern void __remove_memory(int nid, u64 start, u64 size);
>  
>  #else
> @@ -341,7 +341,11 @@ static inline int offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>  	return -EINVAL;
>  }
>  
> -static inline void remove_memory(int nid, u64 start, u64 size) {}
> +static inline int remove_memory(int nid, u64 start, u64 size)
> +{
> +	return -EBUSY;
> +}
> +
>  static inline void __remove_memory(int nid, u64 start, u64 size) {}
>  #endif /* CONFIG_MEMORY_HOTREMOVE */
>  
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 328878b6799d..ace2cc614da4 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1735,9 +1735,10 @@ static int check_memblock_offlined_cb(struct memory_block *mem, void *arg)
>  		endpa = PFN_PHYS(section_nr_to_pfn(mem->end_section_nr + 1))-1;
>  		pr_warn("removing memory fails, because memory [%pa-%pa] is onlined\n",
>  			&beginpa, &endpa);
> -	}
>  
> -	return ret;
> +		return -EBUSY;
> +	}
> +	return 0;
>  }
>  
>  static int check_cpu_on_node(pg_data_t *pgdat)
> @@ -1820,19 +1821,9 @@ static void __release_memory_resource(resource_size_t start,
>  	}
>  }
>  
> -/**
> - * remove_memory
> - * @nid: the node ID
> - * @start: physical address of the region to remove
> - * @size: size of the region to remove
> - *
> - * NOTE: The caller must call lock_device_hotplug() to serialize hotplug
> - * and online/offline operations before this call, as required by
> - * try_offline_node().
> - */
> -void __ref __remove_memory(int nid, u64 start, u64 size)
> +static int __ref try_remove_memory(int nid, u64 start, u64 size)
>  {
> -	int ret;
> +	int rc = 0;
>  
>  	BUG_ON(check_hotplug_memory_range(start, size));
>  
> @@ -1840,13 +1831,13 @@ void __ref __remove_memory(int nid, u64 start, u64 size)
>  
>  	/*
>  	 * All memory blocks must be offlined before removing memory.  Check
> -	 * whether all memory blocks in question are offline and trigger a BUG()
> +	 * whether all memory blocks in question are offline and return error
>  	 * if this is not the case.
>  	 */
> -	ret = walk_memory_range(PFN_DOWN(start), PFN_UP(start + size - 1), NULL,
> -				check_memblock_offlined_cb);
> -	if (ret)
> -		BUG();
> +	rc = walk_memory_range(PFN_DOWN(start), PFN_UP(start + size - 1), NULL,
> +			       check_memblock_offlined_cb);
> +	if (rc)
> +		goto done;
>  
>  	/* remove memmap entry */
>  	firmware_map_remove(start, start + size, "System RAM");
> @@ -1858,14 +1849,45 @@ void __ref __remove_memory(int nid, u64 start, u64 size)
>  
>  	try_offline_node(nid);
>  
> +done:
>  	mem_hotplug_done();
> +	return rc;
>  }
>  
> -void remove_memory(int nid, u64 start, u64 size)
> +/**
> + * remove_memory
> + * @nid: the node ID
> + * @start: physical address of the region to remove
> + * @size: size of the region to remove
> + *
> + * NOTE: The caller must call lock_device_hotplug() to serialize hotplug
> + * and online/offline operations before this call, as required by
> + * try_offline_node().
> + */
> +void __remove_memory(int nid, u64 start, u64 size)
> +{
> +
> +	/*
> +	 * trigger BUG() is some memory is not offlined prior to calling this
> +	 * function
> +	 */
> +	if (try_remove_memory(nid, start, size))
> +		BUG();
> +}
> +
> +/*
> + * Remove memory if every memory block is offline, otherwise return -EBUSY is
> + * some memory is not offline
> + */
> +int remove_memory(int nid, u64 start, u64 size)
>  {
> +	int rc;
> +
>  	lock_device_hotplug();
> -	__remove_memory(nid, start, size);
> +	rc  = try_remove_memory(nid, start, size);
>  	unlock_device_hotplug();
> +
> +	return rc;
>  }
>  EXPORT_SYMBOL_GPL(remove_memory);
>  #endif /* CONFIG_MEMORY_HOTREMOVE */
> -- 
> 2.21.0
> 

-- 
Michal Hocko
SUSE Labs
