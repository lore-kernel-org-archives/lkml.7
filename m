Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6FFC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 07:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11CB206BF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 07:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfEOHlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 03:41:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37564 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfEOHlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 03:41:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 941F1374;
        Wed, 15 May 2019 00:41:41 -0700 (PDT)
Received: from [10.163.1.137] (unknown [10.163.1.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B9F93F71E;
        Wed, 15 May 2019 00:41:36 -0700 (PDT)
Subject: Re: [PATCH] mm: refactor __vunmap() to avoid duplicated call to
 find_vm_area()
To:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
References: <20190514235111.2817276-1-guro@fb.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <7ad2b16d-c1a3-b826-df4d-6d9ed1d9fc9f@arm.com>
Date:   Wed, 15 May 2019 13:11:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190514235111.2817276-1-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/15/2019 05:21 AM, Roman Gushchin wrote:
> __vunmap() calls find_vm_area() twice without an obvious reason:
> first directly to get the area pointer, second indirectly by calling
> vm_remove_mappings()->remove_vm_area(), which is again searching
> for the area.
> 
> To remove this redundancy, let's split remove_vm_area() into
> __remove_vm_area(struct vmap_area *), which performs the actual area
> removal, and remove_vm_area(const void *addr) wrapper, which can
> be used everywhere, where it has been used before. Let's pass
> a pointer to the vm_area instead of vm_struct to vm_remove_mappings(),
> so it can pass it to __remove_vm_area() and avoid the redundant area
> lookup.
> 
> On my test setup, I've got 5-10% speed up on vfree()'ing 1000000
> of 4-pages vmalloc blocks.
> 
> Perf report before:
>   29.44%  cat      [kernel.kallsyms]  [k] free_unref_page
>   11.88%  cat      [kernel.kallsyms]  [k] find_vmap_area
>    9.28%  cat      [kernel.kallsyms]  [k] __free_pages
>    7.44%  cat      [kernel.kallsyms]  [k] __slab_free
>    7.28%  cat      [kernel.kallsyms]  [k] vunmap_page_range
>    4.56%  cat      [kernel.kallsyms]  [k] __vunmap
>    3.64%  cat      [kernel.kallsyms]  [k] __purge_vmap_area_lazy
>    3.04%  cat      [kernel.kallsyms]  [k] __free_vmap_area
> 
> Perf report after:
>   32.41%  cat      [kernel.kallsyms]  [k] free_unref_page
>    7.79%  cat      [kernel.kallsyms]  [k] find_vmap_area
>    7.40%  cat      [kernel.kallsyms]  [k] __slab_free
>    7.31%  cat      [kernel.kallsyms]  [k] vunmap_page_range
>    6.84%  cat      [kernel.kallsyms]  [k] __free_pages
>    6.01%  cat      [kernel.kallsyms]  [k] __vunmap
>    3.98%  cat      [kernel.kallsyms]  [k] smp_call_function_single
>    3.81%  cat      [kernel.kallsyms]  [k] __purge_vmap_area_lazy
>    2.77%  cat      [kernel.kallsyms]  [k] __free_vmap_area
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/vmalloc.c | 52 +++++++++++++++++++++++++++++-----------------------
>  1 file changed, 29 insertions(+), 23 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index c42872ed82ac..8d4907865614 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2075,6 +2075,22 @@ struct vm_struct *find_vm_area(const void *addr)
>  	return NULL;
>  }
>  
> +static struct vm_struct *__remove_vm_area(struct vmap_area *va)
> +{
> +	struct vm_struct *vm = va->vm;
> +
> +	spin_lock(&vmap_area_lock);
> +	va->vm = NULL;
> +	va->flags &= ~VM_VM_AREA;
> +	va->flags |= VM_LAZY_FREE;
> +	spin_unlock(&vmap_area_lock);
> +
> +	kasan_free_shadow(vm);
> +	free_unmap_vmap_area(va);
> +
> +	return vm;
> +}
> +
>  /**
>   * remove_vm_area - find and remove a continuous kernel virtual area
>   * @addr:	    base address
> @@ -2087,26 +2103,14 @@ struct vm_struct *find_vm_area(const void *addr)
>   */
>  struct vm_struct *remove_vm_area(const void *addr)
>  {
> +	struct vm_struct *vm = NULL;
>  	struct vmap_area *va;
>  
> -	might_sleep();

Is not this necessary any more ?

> -
>  	va = find_vmap_area((unsigned long)addr);
> -	if (va && va->flags & VM_VM_AREA) {
> -		struct vm_struct *vm = va->vm;
> -
> -		spin_lock(&vmap_area_lock);
> -		va->vm = NULL;
> -		va->flags &= ~VM_VM_AREA;
> -		va->flags |= VM_LAZY_FREE;
> -		spin_unlock(&vmap_area_lock);
> -
> -		kasan_free_shadow(vm);
> -		free_unmap_vmap_area(va);
> +	if (va && va->flags & VM_VM_AREA)
> +		vm = __remove_vm_area(va);
>  
> -		return vm;
> -	}
> -	return NULL;
> +	return vm;
>  }

Other callers of remove_vm_area() cannot use __remove_vm_area() directly as well
to save a look up ?
