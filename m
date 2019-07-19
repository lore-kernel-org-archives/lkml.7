Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8DAC76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 08:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE5020665
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 08:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563525764;
	bh=jhJGjFRrEBaSto+HrhVMX0SSprqv1MNR//aklp0Q9tM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r3ZQMZpQ0DpohLl2xj2yyiKtG4qoF1Y9c7B64sse0A9b5zgCx+tQoXLW8f8dG15Ah
	 x0XYlP7kzfeFM4NcS5aDL9ASobYU4SPtjnEQNWNOtaY/kKPM2TP3w3Xs0V04vZVWAT
	 rJzrktiHT3xZCQ6vK6a8cr3v3PKRVElLmgYAFeS0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfGSImm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 04:42:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:36696 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726036AbfGSImm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 04:42:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 58622ACD1;
        Fri, 19 Jul 2019 08:42:40 +0000 (UTC)
Date:   Fri, 19 Jul 2019 10:42:39 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v1] drivers/base/node.c: Simplify
 unregister_memory_block_under_nodes()
Message-ID: <20190719084239.GO30461@dhcp22.suse.cz>
References: <20190718142239.7205-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718142239.7205-1-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 18-07-19 16:22:39, David Hildenbrand wrote:
> We don't allow to offline memory block devices that belong to multiple
> numa nodes. Therefore, such devices can never get removed. It is
> sufficient to process a single node when removing the memory block.
> 
> Remember for each memory block if it belongs to no, a single, or mixed
> nodes, so we can use that information to skip unregistering or print a
> warning (essentially a safety net to catch BUGs).

I do not really like NUMA_NO_NODE - 1 thing. This is yet another invalid
node that is magic. Why should we even care? In other words why is this
patch an improvement?

> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/base/memory.c  |  1 +
>  drivers/base/node.c    | 40 ++++++++++++++++------------------------
>  include/linux/memory.h |  4 +++-
>  3 files changed, 20 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 20c39d1bcef8..154d5d4a0779 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -674,6 +674,7 @@ static int init_memory_block(struct memory_block **memory,
>  	mem->state = state;
>  	start_pfn = section_nr_to_pfn(mem->start_section_nr);
>  	mem->phys_device = arch_get_memory_phys_device(start_pfn);
> +	mem->nid = NUMA_NO_NODE;
>  
>  	ret = register_memory(mem);
>  
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 75b7e6f6535b..29d27b8d5fda 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -759,8 +759,6 @@ static int register_mem_sect_under_node(struct memory_block *mem_blk,
>  	int ret, nid = *(int *)arg;
>  	unsigned long pfn, sect_start_pfn, sect_end_pfn;
>  
> -	mem_blk->nid = nid;
> -
>  	sect_start_pfn = section_nr_to_pfn(mem_blk->start_section_nr);
>  	sect_end_pfn = section_nr_to_pfn(mem_blk->end_section_nr);
>  	sect_end_pfn += PAGES_PER_SECTION - 1;
> @@ -789,6 +787,13 @@ static int register_mem_sect_under_node(struct memory_block *mem_blk,
>  			if (page_nid != nid)
>  				continue;
>  		}
> +
> +		/* this memory block spans this node */
> +		if (mem_blk->nid == NUMA_NO_NODE)
> +			mem_blk->nid = nid;
> +		else
> +			mem_blk->nid = NUMA_NO_NODE - 1;
> +
>  		ret = sysfs_create_link_nowarn(&node_devices[nid]->dev.kobj,
>  					&mem_blk->dev.kobj,
>  					kobject_name(&mem_blk->dev.kobj));
> @@ -804,32 +809,19 @@ static int register_mem_sect_under_node(struct memory_block *mem_blk,
>  }
>  
>  /*
> - * Unregister memory block device under all nodes that it spans.
> - * Has to be called with mem_sysfs_mutex held (due to unlinked_nodes).
> + * Unregister a memory block device under the node it spans. Memory blocks
> + * with multiple nodes cannot be offlined and therefore also never be removed.
>   */
>  void unregister_memory_block_under_nodes(struct memory_block *mem_blk)
>  {
> -	unsigned long pfn, sect_start_pfn, sect_end_pfn;
> -	static nodemask_t unlinked_nodes;
> -
> -	nodes_clear(unlinked_nodes);
> -	sect_start_pfn = section_nr_to_pfn(mem_blk->start_section_nr);
> -	sect_end_pfn = section_nr_to_pfn(mem_blk->end_section_nr);
> -	for (pfn = sect_start_pfn; pfn <= sect_end_pfn; pfn++) {
> -		int nid;
> +	if (mem_blk->nid == NUMA_NO_NODE ||
> +	    WARN_ON_ONCE(mem_blk->nid == NUMA_NO_NODE - 1))
> +		return;
>  
> -		nid = get_nid_for_pfn(pfn);
> -		if (nid < 0)
> -			continue;
> -		if (!node_online(nid))
> -			continue;
> -		if (node_test_and_set(nid, unlinked_nodes))
> -			continue;
> -		sysfs_remove_link(&node_devices[nid]->dev.kobj,
> -			 kobject_name(&mem_blk->dev.kobj));
> -		sysfs_remove_link(&mem_blk->dev.kobj,
> -			 kobject_name(&node_devices[nid]->dev.kobj));
> -	}
> +	sysfs_remove_link(&node_devices[mem_blk->nid]->dev.kobj,
> +		 kobject_name(&mem_blk->dev.kobj));
> +	sysfs_remove_link(&mem_blk->dev.kobj,
> +		 kobject_name(&node_devices[mem_blk->nid]->dev.kobj));
>  }
>  
>  int link_mem_sections(int nid, unsigned long start_pfn, unsigned long end_pfn)
> diff --git a/include/linux/memory.h b/include/linux/memory.h
> index 02e633f3ede0..c91af10d5fb4 100644
> --- a/include/linux/memory.h
> +++ b/include/linux/memory.h
> @@ -33,7 +33,9 @@ struct memory_block {
>  	void *hw;			/* optional pointer to fw/hw data */
>  	int (*phys_callback)(struct memory_block *);
>  	struct device dev;
> -	int nid;			/* NID for this memory block */
> +	int nid;			/* NID for this memory block.
> +					   - NUMA_NO_NODE: uninitialized
> +					   - NUMA_NO_NODE - 1: mixed nodes */
>  };
>  
>  int arch_get_memory_phys_device(unsigned long start_pfn);
> -- 
> 2.21.0

-- 
Michal Hocko
SUSE Labs
