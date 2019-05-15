Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBDCC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 17:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A9020873
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 17:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfEOReo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 13:34:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:43061 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfEOReo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 13:34:44 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 May 2019 10:34:43 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga001.fm.intel.com with ESMTP; 15 May 2019 10:34:43 -0700
Date:   Wed, 15 May 2019 10:35:26 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: refactor __vunmap() to avoid duplicated call to
 find_vm_area()
Message-ID: <20190515173525.GB1888@iweiny-DESK2.sc.intel.com>
References: <20190514235111.2817276-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514235111.2817276-1-guro@fb.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  
> -/* Handle removing and resetting vm mappings related to the vm_struct. */
> -static void vm_remove_mappings(struct vm_struct *area, int deallocate_pages)
> +/* Handle removing and resetting vm mappings related to the va->vm vm_struct. */
> +static void vm_remove_mappings(struct vmap_area *va, int deallocate_pages)

Does this apply to 5.1?  I'm confused because I can't find vm_remove_mappings()
in 5.1.

Ira

>  {
> +	struct vm_struct *area = va->vm;
>  	unsigned long addr = (unsigned long)area->addr;
>  	unsigned long start = ULONG_MAX, end = 0;
>  	int flush_reset = area->flags & VM_FLUSH_RESET_PERMS;
> @@ -2138,7 +2143,7 @@ static void vm_remove_mappings(struct vm_struct *area, int deallocate_pages)
>  		set_memory_rw(addr, area->nr_pages);
>  	}
>  
> -	remove_vm_area(area->addr);
> +	__remove_vm_area(va);
>  
>  	/* If this is not VM_FLUSH_RESET_PERMS memory, no need for the below. */
>  	if (!flush_reset)
> @@ -2178,6 +2183,7 @@ static void vm_remove_mappings(struct vm_struct *area, int deallocate_pages)
>  static void __vunmap(const void *addr, int deallocate_pages)
>  {
>  	struct vm_struct *area;
> +	struct vmap_area *va;
>  
>  	if (!addr)
>  		return;
> @@ -2186,17 +2192,18 @@ static void __vunmap(const void *addr, int deallocate_pages)
>  			addr))
>  		return;
>  
> -	area = find_vm_area(addr);
> -	if (unlikely(!area)) {
> +	va = find_vmap_area((unsigned long)addr);
> +	if (unlikely(!va || !(va->flags & VM_VM_AREA))) {
>  		WARN(1, KERN_ERR "Trying to vfree() nonexistent vm area (%p)\n",
>  				addr);
>  		return;
>  	}
>  
> +	area = va->vm;
>  	debug_check_no_locks_freed(area->addr, get_vm_area_size(area));
>  	debug_check_no_obj_freed(area->addr, get_vm_area_size(area));
>  
> -	vm_remove_mappings(area, deallocate_pages);
> +	vm_remove_mappings(va, deallocate_pages);
>  
>  	if (deallocate_pages) {
>  		int i;
> @@ -2212,7 +2219,6 @@ static void __vunmap(const void *addr, int deallocate_pages)
>  	}
>  
>  	kfree(area);
> -	return;
>  }
>  
>  static inline void __vfree_deferred(const void *addr)
> -- 
> 2.20.1
> 
