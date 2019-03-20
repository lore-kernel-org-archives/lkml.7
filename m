Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A976FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 07:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8077621908
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 07:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbfCTH6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 03:58:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43542 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfCTH6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 03:58:02 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F400130820DD;
        Wed, 20 Mar 2019 07:58:01 +0000 (UTC)
Received: from localhost (ovpn-12-38.pek2.redhat.com [10.72.12.38])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F4FD6058F;
        Wed, 20 Mar 2019 07:58:01 +0000 (UTC)
Date:   Wed, 20 Mar 2019 15:57:59 +0800
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, osalvador@suse.de, mhocko@suse.com,
        rppt@linux.vnet.ibm.com, richard.weiyang@gmail.com,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm/sparse: Rename function related to section memmap
 allocation/free
Message-ID: <20190320075759.GJ18740@MiWiFi-R3L-srv>
References: <20190320075301.13994-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320075301.13994-1-bhe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 20 Mar 2019 07:58:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/20/19 at 03:53pm, Baoquan He wrote:
> These functions are used allocate/free section memmap, have nothing
> to do with kmalloc/free during the handling. Rename them to remove
> the confusion.

Sorry, wrong git operation caused this one sent. I intended to send out
other single patch.

Please ignore this one. It has been included in previous patchset.


> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  mm/sparse.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 054b99f74181..374206212d01 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -579,13 +579,13 @@ void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
>  #endif
>  
>  #ifdef CONFIG_SPARSEMEM_VMEMMAP
> -static inline struct page *kmalloc_section_memmap(unsigned long pnum, int nid,
> +static inline struct page *alloc_section_memmap(unsigned long pnum, int nid,
>  		struct vmem_altmap *altmap)
>  {
>  	/* This will make the necessary allocations eventually. */
>  	return sparse_mem_map_populate(pnum, nid, altmap);
>  }
> -static void __kfree_section_memmap(struct page *memmap,
> +static void __free_section_memmap(struct page *memmap,
>  		struct vmem_altmap *altmap)
>  {
>  	unsigned long start = (unsigned long)memmap;
> @@ -603,7 +603,7 @@ static void free_map_bootmem(struct page *memmap)
>  }
>  #endif /* CONFIG_MEMORY_HOTREMOVE */
>  #else
> -static struct page *__kmalloc_section_memmap(void)
> +static struct page *__alloc_section_memmap(void)
>  {
>  	struct page *page, *ret;
>  	unsigned long memmap_size = sizeof(struct page) * PAGES_PER_SECTION;
> @@ -624,13 +624,13 @@ static struct page *__kmalloc_section_memmap(void)
>  	return ret;
>  }
>  
> -static inline struct page *kmalloc_section_memmap(unsigned long pnum, int nid,
> +static inline struct page *alloc_section_memmap(unsigned long pnum, int nid,
>  		struct vmem_altmap *altmap)
>  {
> -	return __kmalloc_section_memmap();
> +	return __alloc_section_memmap();
>  }
>  
> -static void __kfree_section_memmap(struct page *memmap,
> +static void __free_section_memmap(struct page *memmap,
>  		struct vmem_altmap *altmap)
>  {
>  	if (is_vmalloc_addr(memmap))
> @@ -701,7 +701,7 @@ int __meminit sparse_add_one_section(int nid, unsigned long start_pfn,
>  	usemap = __kmalloc_section_usemap();
>  	if (!usemap)
>  		return -ENOMEM;
> -	memmap = kmalloc_section_memmap(section_nr, nid, altmap);
> +	memmap = alloc_section_memmap(section_nr, nid, altmap);
>  	if (!memmap) {
>  		kfree(usemap);
>  		return -ENOMEM;
> @@ -726,7 +726,7 @@ int __meminit sparse_add_one_section(int nid, unsigned long start_pfn,
>  out:
>  	if (ret < 0) {
>  		kfree(usemap);
> -		__kfree_section_memmap(memmap, altmap);
> +		__free_section_memmap(memmap, altmap);
>  	}
>  	return ret;
>  }
> @@ -777,7 +777,7 @@ static void free_section_usemap(struct page *memmap, unsigned long *usemap,
>  	if (PageSlab(usemap_page) || PageCompound(usemap_page)) {
>  		kfree(usemap);
>  		if (memmap)
> -			__kfree_section_memmap(memmap, altmap);
> +			__free_section_memmap(memmap, altmap);
>  		return;
>  	}
>  
> -- 
> 2.17.2
> 
