Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BCCCA9ED4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 01:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F051A2080F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 01:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRuLbt2Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbfKEBU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 20:20:58 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43461 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728602AbfKEBU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 20:20:57 -0500
Received: by mail-qt1-f196.google.com with SMTP id l24so8713402qtp.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 17:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AAx0c4BlkqqAv5iyK1pTv8OHUKODmcRUTPFUJZtwohY=;
        b=PRuLbt2ZiMAsffYSDPknnMSHcECuDpVi42LYZVfgQOQ3XVTsZ8AuBKj3MibHChxzah
         tnkG6ozuIB5IZGG/Y/BHM5s0w8eJZ1aW2xWdA7U5+LY6BEa270nLLkwyFLRPjIWn0iQE
         UKqcKSdHioORnVE0GaDIz5zDWTcbkznTwumHo1ILzz4u4AYWkLtBrXNCLtwCRY/NOgw6
         alD7VYGchWiF7WCHO085mpGs3zClvMEjvMowLob7MBROQrXf/KWXxAzE9xVVTg4dMnJX
         /hZeMfVSi7zAG4d+SU3yI5BQKJu4lMPkXHEv070rT7hG/H3VowRVpfS12kjwCFXPtki4
         YLng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AAx0c4BlkqqAv5iyK1pTv8OHUKODmcRUTPFUJZtwohY=;
        b=ltf2X0/+bl8ztY8Yfow70BxTfHxynhkREILwB1W0vYpQ0KNDrkRWYgR6FK6Ttu0rDH
         p2/HgvN5RrkkqelLO+ZfQMuUEw8Z1BsVs/dW4bZOQ52t8x+u3+YieGe7iZCU4xmdt7zU
         lAWYPQMnbjh3hrc/ylttKZ/WB5XsNcLO0BjIoq0zZGP5UljI1H0mNz/m+DzvLmFD9VX+
         rSl1aZKRZqaltWMOI2QESeUpF8+1UHvUqv2jOdIm9FQMy426//86lllLq++Z7jwnztXt
         vBUNXKIWTSfUmdX+OY5TwY16qMjU7yi0BWlAe0CIfREfOpSA1jUIwFC/wiS2EMKYtDGT
         erbg==
X-Gm-Message-State: APjAAAV0QgXzBCcJCS62ZHVR07XQvxsCzMgGV4TadtzQBP4WjKU33681
        iNDk893vw29+sK/PLx492w==
X-Google-Smtp-Source: APXvYqxqijwxbCog6Lz7ywOXVCxPB0dR8j66Rshr1ECQ9Xy4jSSwczpseu1KzCwN6XNsxmcdcVJX4g==
X-Received: by 2002:ad4:43e9:: with SMTP id f9mr25344103qvu.66.1572916855954;
        Mon, 04 Nov 2019 17:20:55 -0800 (PST)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id x133sm9109741qka.44.2019.11.04.17.20.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Nov 2019 17:20:55 -0800 (PST)
Date:   Mon, 4 Nov 2019 20:20:50 -0500
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Tang Chen <tangchen@cn.fujitsu.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Keith Busch <keith.busch@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH v3] mm/memory_hotplug: Fix try_offline_node()
Message-ID: <20191105012049.x2k4v2xizd2tim5b@gabell>
References: <20191102120221.7553-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191102120221.7553-1-david@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.4-rc5 with this patch works for memory-hotadd and remove, thanks!
Please feel free to add:

    Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Without this patch, memory hotplug fails as panic:

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 ...
 Call Trace:
  remove_memory_block_devices+0x81/0xc0
  try_remove_memory+0xb4/0x130
  ? walk_memory_blocks+0x75/0xa0
  __remove_memory+0xa/0x20
  acpi_memory_device_remove+0x84/0x100
  acpi_bus_trim+0x57/0x90
  acpi_bus_trim+0x2e/0x90
  acpi_device_hotplug+0x2b2/0x4d0
  acpi_hotplug_work_fn+0x1a/0x30
  process_one_work+0x171/0x380
  worker_thread+0x49/0x3f0
  kthread+0xf8/0x130
  ? max_active_store+0x80/0x80
  ? kthread_bind+0x10/0x10
  ret_from_fork+0x35/0x40

- Masa

On Sat, Nov 02, 2019 at 01:02:21PM +0100, David Hildenbrand wrote:
> try_offline_node() is pretty much broken right now:
> - The node span is updated when onlining memory, not when adding it. We
>   ignore memory that was mever onlined. Bad.
> - We touch possible garbage memmaps. The pfn_to_nid(pfn) can easily
>   trigger a kernel panic. Bad for memory that is offline but also bad
>   for subsection hotadd with ZONE_DEVICE, whereby the memmap of the first
>   PFN of a section might contain garbage.
> - Sections belonging to mixed nodes are not properly considered.
> 
> As memory blocks might belong to multiple nodes, we would have to walk all
> pageblocks (or at least subsections) within present sections. However,
> we don't have a way to identify whether a memmap that is not online was
> initialized (relevant for ZONE_DEVICE). This makes things more complicated.
> 
> Luckily, we can piggy pack on the node span and the nid stored in
> memory blocks. Currently, the node span is grown when calling
> move_pfn_range_to_zone() - e.g., when onlining memory, and shrunk when
> removing memory, before calling try_offline_node(). Sysfs links are
> created via link_mem_sections(), e.g., during boot or when adding memory.
> 
> If the node still spans memory or if any memory block belongs to the
> nid, we don't set the node offline. As memory blocks that span multiple
> nodes cannot get offlined, the nid stored in memory blocks is reliable
> enough (for such online memory blocks, the node still spans the memory).
> 
> Introduce for_each_memory_block() to efficiently walk all memory blocks.
> 
> Note: We will soon stop shrinking the ZONE_DEVICE zone and the node span
> when removing ZONE_DEVICE memory to fix similar issues (access of garbage
> memmaps) - until we have a reliable way to identify whether these memmaps
> were properly initialized. This implies later, that once a node had
> ZONE_DEVICE memory, we won't be able to set a node offline -
> which should be acceptable.
> 
> Since commit f1dd2cd13c4b ("mm, memory_hotplug: do not associate hotadded
> memory to zones until online") memory that is added is not assoziated
> with a zone/node (memmap not initialized). The introducing
> commit 60a5a19e7419 ("memory-hotplug: remove sysfs file of node") already
> missed that we could have multiple nodes for a section and that the
> zone/node span is updated when onlining pages, not when adding them.
> 
> I tested this by hotplugging two DIMMs to a memory-less and cpu-less NUMA
> node. The node is properly onlined when adding the DIMMs. When removing
> the DIMMs, the node is properly offlined.
> 
> Fixes: 60a5a19e7419 ("memory-hotplug: remove sysfs file of node")
> Fixes: f1dd2cd13c4b ("mm, memory_hotplug: do not associate hotadded memory to zones until online") # visiable after d0dc12e86b319
> Cc: Tang Chen <tangchen@cn.fujitsu.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: Nayna Jain <nayna@linux.ibm.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> v2 -> v3:
> - Introduce and use for_each_memory_block(), which will run significantly
>   faster than walk_memory_blocks()
> 
> v1 -> v2:
> - Drop sysfs handling, simplify, and add a comment
> - Make sure to include last section fully
> 
> We stop shrinking the ZONE_DEVICE zone after the following patch:
>  [PATCH v6 04/10] mm/memory_hotplug: Don't access uninitialized memmaps
>  in shrink_zone_span()
> This implies, the above note regarding ZONE_DEVICE on a node blocking a
> node from getting offlined until we sorted out how to properly shrink
> the ZONE_DEVICE zone.
> 
> This patch is especially important for:
>  [PATCH v6 05/10] mm/memory_hotplug: Shrink zones when offlining
>  memory
> As the BUG fixed with this patch becomes now easier to observe when memory
> is offlined (in contrast to when memory would never have been onlined
> before).
> 
> As both patches are stable fixes and in next/master for a long time, we
> should probably pull this patch in front of both and also backport this
> patch at least to
>  Cc: stable@vger.kernel.org # v4.13+
> I have not checked yet if there are real blockers to do that. I guess not.
> 
> ---
>  drivers/base/memory.c  | 36 +++++++++++++++++++++++++++++++++++
>  include/linux/memory.h |  1 +
>  mm/memory_hotplug.c    | 43 ++++++++++++++++++++++++++----------------
>  3 files changed, 64 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index a757d9ed88a7..d65ecdeb83e8 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -867,3 +867,39 @@ int walk_memory_blocks(unsigned long start, unsigned long size,
>  	}
>  	return ret;
>  }
> +
> +struct for_each_memory_block_cb_data {
> +	walk_memory_blocks_func_t func;
> +	void *arg;
> +};
> +
> +static int for_each_memory_block_cb(struct device *dev, void *data)
> +{
> +	struct memory_block *mem = to_memory_block(dev);
> +	struct for_each_memory_block_cb_data *cb_data = data;
> +
> +	return cb_data->func(mem, cb_data->arg);
> +}
> +
> +/**
> + * for_each_memory_block - walk through all present memory blocks
> + *
> + * @arg: argument passed to func
> + * @func: callback for each memory block walked
> + *
> + * This function walks through all present memory blocks, calling func on
> + * each memory block.
> + *
> + * In case func() returns an error, walking is aborted and the error is
> + * returned.
> + */
> +int for_each_memory_block(void *arg, walk_memory_blocks_func_t func)
> +{
> +	struct for_each_memory_block_cb_data cb_data = {
> +		.func = func,
> +		.arg = arg,
> +	};
> +
> +	return bus_for_each_dev(&memory_subsys, NULL, &cb_data,
> +				for_each_memory_block_cb);
> +}
> diff --git a/include/linux/memory.h b/include/linux/memory.h
> index 0ebb105eb261..4c75dae8dd29 100644
> --- a/include/linux/memory.h
> +++ b/include/linux/memory.h
> @@ -119,6 +119,7 @@ extern struct memory_block *find_memory_block(struct mem_section *);
>  typedef int (*walk_memory_blocks_func_t)(struct memory_block *, void *);
>  extern int walk_memory_blocks(unsigned long start, unsigned long size,
>  			      void *arg, walk_memory_blocks_func_t func);
> +extern int for_each_memory_block(void *arg, walk_memory_blocks_func_t func);
>  #define CONFIG_MEM_BLOCK_SIZE	(PAGES_PER_SECTION<<PAGE_SHIFT)
>  #endif /* CONFIG_MEMORY_HOTPLUG_SPARSE */
>  
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 0140c20837b6..46b2e056a43f 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1634,6 +1634,18 @@ static int check_cpu_on_node(pg_data_t *pgdat)
>  	return 0;
>  }
>  
> +static int check_no_memblock_for_node_cb(struct memory_block *mem, void *arg)
> +{
> +	int nid = *(int *)arg;
> +
> +	/*
> +	 * If a memory block belongs to multiple nodes, the stored nid is not
> +	 * reliable. However, such blocks are always online (e.g., cannot get
> +	 * offlined) and, therefore, are still spanned by the node.
> +	 */
> +	return mem->nid == nid ? -EEXIST : 0;
> +}
> +
>  /**
>   * try_offline_node
>   * @nid: the node ID
> @@ -1646,25 +1658,24 @@ static int check_cpu_on_node(pg_data_t *pgdat)
>  void try_offline_node(int nid)
>  {
>  	pg_data_t *pgdat = NODE_DATA(nid);
> -	unsigned long start_pfn = pgdat->node_start_pfn;
> -	unsigned long end_pfn = start_pfn + pgdat->node_spanned_pages;
> -	unsigned long pfn;
> -
> -	for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
> -		unsigned long section_nr = pfn_to_section_nr(pfn);
> -
> -		if (!present_section_nr(section_nr))
> -			continue;
> +	int rc;
>  
> -		if (pfn_to_nid(pfn) != nid)
> -			continue;
> +	/*
> +	 * If the node still spans pages (especially ZONE_DEVICE), don't
> +	 * offline it. A node spans memory after move_pfn_range_to_zone(),
> +	 * e.g., after the memory block was onlined.
> +	 */
> +	if (pgdat->node_spanned_pages)
> +		return;
>  
> -		/*
> -		 * some memory sections of this node are not removed, and we
> -		 * can't offline node now.
> -		 */
> +	/*
> +	 * Especially offline memory blocks might not be spanned by the
> +	 * node. They will get spanned by the node once they get onlined.
> +	 * However, they link to the node in sysfs and can get onlined later.
> +	 */
> +	rc = for_each_memory_block(&nid, check_no_memblock_for_node_cb);
> +	if (rc)
>  		return;
> -	}
>  
>  	if (check_cpu_on_node(pgdat))
>  		return;
> -- 
> 2.21.0
> 
> 
