Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4986C282DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5A4217F4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfDIJSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:18:51 -0400
Received: from nat.nue.novell.com ([195.135.221.2]:31438 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726162AbfDIJSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 05:18:50 -0400
Received: by suse.de (Postfix, from userid 1000)
        id 726B048B2; Tue,  9 Apr 2019 11:18:48 +0200 (CEST)
Date:   Tue, 9 Apr 2019 11:18:48 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Banman <andrew.banman@hpe.com>, mike.travis@hpe.com,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Wei Yang <richard.weiyang@gmail.com>, Qian Cai <cai@lca.pw>,
        Arun KS <arunks@codeaurora.org>,
        Mathieu Malaterre <malat@debian.org>, linux-mm@kvack.org,
        dan.j.williams@intel.com
Subject: Re: [PATCH RFC 3/3] mm/memory_hotplug: Remove memory block devices
 before arch_remove_memory()
Message-ID: <20190409091844.yvjmglawf2fmiy3o@d104.suse.de>
References: <20190408101226.20976-1-david@redhat.com>
 <20190408101226.20976-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408101226.20976-4-david@redhat.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 12:12:26PM +0200, David Hildenbrand wrote:
> Let's factor out removing of memory block devices, which is only
> necessary for memory added via add_memory() and friends that created
> memory block devices. Remove the devices before calling
> arch_remove_memory().
> 
> TODO: We should try to get rid of the errors that could be reported by
> unregister_memory_block_under_nodes(). Ignoring failures is not that
> nice.

Hi David,

I am sorry but I will not have to look into this until next week as I am
up to my ears with work plus I am in the middle of a move.

I remember I was once trying to simplify unregister_mem_sect_under_nodes (your
new unregister_memory_block_under_nodes), and I checked whether we could get
rid of the NODEMASK_ALLOC there, something like:

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 8598fcbd2a17..f4294a2928dd 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -805,16 +805,10 @@ int register_mem_sect_under_node(struct memory_block *mem_blk, void *arg)
 int unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
                                    unsigned long phys_index)
 {
-       NODEMASK_ALLOC(nodemask_t, unlinked_nodes, GFP_KERNEL);
+       nodemask_t unlinked_nodes;
        unsigned long pfn, sect_start_pfn, sect_end_pfn;
 
-       if (!mem_blk) {
-               NODEMASK_FREE(unlinked_nodes);
-               return -EFAULT;
-       }
-       if (!unlinked_nodes)
-               return -ENOMEM;
-       nodes_clear(*unlinked_nodes);
+       nodes_clear(unlinked_nodes);
 
        sect_start_pfn = section_nr_to_pfn(phys_index);
        sect_end_pfn = sect_start_pfn + PAGES_PER_SECTION - 1;
@@ -826,14 +820,13 @@ int unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
                        continue;
                if (!node_online(nid))
                        continue;
-               if (node_test_and_set(nid, *unlinked_nodes))
+               if (node_test_and_set(nid, unlinked_nodes))
                        continue;
                sysfs_remove_link(&node_devices[nid]->dev.kobj,
                         kobject_name(&mem_blk->dev.kobj));
                sysfs_remove_link(&mem_blk->dev.kobj,
                         kobject_name(&node_devices[nid]->dev.kobj));
        }
-       NODEMASK_FREE(unlinked_nodes);
        return 0;
 }


nodemask_t is 128bytes when CONFIG_NODES_SHIFT is 10 , which is the maximum value.
We just need to check whether we can overflow the stack or not.

AFAICS, it is not really a shore stack but it might not be that deep either.

> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/base/memory.c  | 41 +++++++++++++++--------------------------
>  drivers/base/node.c    |  7 +++----
>  include/linux/memory.h |  2 +-
>  include/linux/node.h   |  6 ++----
>  mm/memory_hotplug.c    | 10 ++++------
>  5 files changed, 25 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 847b33061e2e..fd8940c37129 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -752,40 +752,29 @@ int hotplug_memory_register(unsigned long start, unsigned long size)
>  }
>  
>  #ifdef CONFIG_MEMORY_HOTREMOVE
> -static int remove_memory_section(struct mem_section *section)
> +void hotplug_memory_unregister(unsigned long start, unsigned long size)
>  {
> +	unsigned long block_nr_pages = memory_block_size_bytes() >> PAGE_SHIFT;
> +	unsigned long start_pfn = PFN_DOWN(start);
> +	unsigned long end_pfn = start_pfn + (size >> PAGE_SHIFT);
>  	struct memory_block *mem;
> +	unsigned long pfn;
>  
> -	mutex_lock(&mem_sysfs_mutex);
> -
> -	/*
> -	 * Some users of the memory hotplug do not want/need memblock to
> -	 * track all sections. Skip over those.
> -	 */
> -	mem = find_memory_block(section);
> -	if (!mem)
> -		goto out_unlock;
> -
> -	unregister_mem_sect_under_nodes(mem, __section_nr(section));
> +	BUG_ON(!IS_ALIGNED(start, memory_block_size_bytes()));
> +	BUG_ON(!IS_ALIGNED(size, memory_block_size_bytes()));
>  
> -	mem->section_count--;
> -	if (mem->section_count == 0)
> +	mutex_lock(&mem_sysfs_mutex);
> +	for (pfn = start_pfn; pfn != end_pfn; pfn += block_nr_pages) {
> +		mem = find_memory_block(__pfn_to_section(pfn));
> +		if (!mem)
> +			continue;
> +		mem->section_count = 0;
> +		unregister_memory_block_under_nodes(mem);
>  		unregister_memory(mem);
> -	else
> -		put_device(&mem->dev);
> -
> -out_unlock:
> +	}
>  	mutex_unlock(&mem_sysfs_mutex);
> -	return 0;
>  }
>  
> -int unregister_memory_section(struct mem_section *section)
> -{
> -	if (!present_section(section))
> -		return -EINVAL;
> -
> -	return remove_memory_section(section);
> -}
>  #endif /* CONFIG_MEMORY_HOTREMOVE */
>  
>  /* return true if the memory block is offlined, otherwise, return false */
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 8598fcbd2a17..f9997770ac15 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -802,8 +802,7 @@ int register_mem_sect_under_node(struct memory_block *mem_blk, void *arg)
>  }
>  
>  /* unregister memory section under all nodes that it spans */
> -int unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
> -				    unsigned long phys_index)
> +int unregister_memory_block_under_nodes(struct memory_block *mem_blk)
>  {
>  	NODEMASK_ALLOC(nodemask_t, unlinked_nodes, GFP_KERNEL);
>  	unsigned long pfn, sect_start_pfn, sect_end_pfn;
> @@ -816,8 +815,8 @@ int unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
>  		return -ENOMEM;
>  	nodes_clear(*unlinked_nodes);
>  
> -	sect_start_pfn = section_nr_to_pfn(phys_index);
> -	sect_end_pfn = sect_start_pfn + PAGES_PER_SECTION - 1;
> +	sect_start_pfn = section_nr_to_pfn(mem_blk->start_section_nr);
> +	sect_end_pfn = section_nr_to_pfn(mem_blk->end_section_nr);
>  	for (pfn = sect_start_pfn; pfn <= sect_end_pfn; pfn++) {
>  		int nid;
>  
> diff --git a/include/linux/memory.h b/include/linux/memory.h
> index e275dc775834..414e43ab0881 100644
> --- a/include/linux/memory.h
> +++ b/include/linux/memory.h
> @@ -113,7 +113,7 @@ extern int register_memory_isolate_notifier(struct notifier_block *nb);
>  extern void unregister_memory_isolate_notifier(struct notifier_block *nb);
>  int hotplug_memory_register(unsigned long start, unsigned long size);
>  #ifdef CONFIG_MEMORY_HOTREMOVE
> -extern int unregister_memory_section(struct mem_section *);
> +void hotplug_memory_unregister(unsigned long start, unsigned long size);
>  #endif
>  extern int memory_dev_init(void);
>  extern int memory_notify(unsigned long val, void *v);
> diff --git a/include/linux/node.h b/include/linux/node.h
> index 1a557c589ecb..02a29e71b175 100644
> --- a/include/linux/node.h
> +++ b/include/linux/node.h
> @@ -139,8 +139,7 @@ extern int register_cpu_under_node(unsigned int cpu, unsigned int nid);
>  extern int unregister_cpu_under_node(unsigned int cpu, unsigned int nid);
>  extern int register_mem_sect_under_node(struct memory_block *mem_blk,
>  						void *arg);
> -extern int unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
> -					   unsigned long phys_index);
> +extern int unregister_memory_block_under_nodes(struct memory_block *mem_blk);
>  
>  extern int register_memory_node_under_compute_node(unsigned int mem_nid,
>  						   unsigned int cpu_nid,
> @@ -176,8 +175,7 @@ static inline int register_mem_sect_under_node(struct memory_block *mem_blk,
>  {
>  	return 0;
>  }
> -static inline int unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
> -						  unsigned long phys_index)
> +static inline int unregister_memory_block_under_nodes(struct memory_block *mem_blk)
>  {
>  	return 0;
>  }
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 13ee0a26e034..041b93c5eede 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -518,14 +518,9 @@ static int __remove_section(struct zone *zone, struct mem_section *ms,
>  {
>  	unsigned long start_pfn;
>  	int scn_nr;
> -	int ret = -EINVAL;
>  
>  	if (!valid_section(ms))
> -		return ret;
> -
> -	ret = unregister_memory_section(ms);
> -	if (ret)
> -		return ret;
> +		return -EINVAL;
>  
>  	scn_nr = __section_nr(ms);
>  	start_pfn = section_nr_to_pfn((unsigned long)scn_nr);
> @@ -1875,6 +1870,9 @@ void __ref __remove_memory(int nid, u64 start, u64 size)
>  	memblock_free(start, size);
>  	memblock_remove(start, size);
>  
> +	/* remove memory block devices before removing memory */
> +	hotplug_memory_unregister(start, size);
> +
>  	arch_remove_memory(nid, start, size, NULL);
>  
>  	try_offline_node(nid);
> -- 
> 2.17.2
> 

-- 
Oscar Salvador
SUSE L3
