Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FE9C10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C24D721473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554283610;
	bh=tfdIUtLGYKCaCqgO9Ezcj/35gv6Qyf9WI+WDqlh7CjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dfTngJTnfFGnmXRjt3U47wqQH82J1Pl/aYQT9JHBs4MxQGAwWkW8Iz4Pk5z1wimCS
	 P6VnWxo5Um8fiURXIiURQtsTsOgGi5L0ye6oUjXRoG55CsFEfmmFSOYYEupIXwWMU9
	 btRjaZcYPCLnvWEh937eMylP6YH8j0XVgdEwbnv0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbfDCJ0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:26:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:59174 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725940AbfDCJ0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:26:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E3EE1AD62;
        Wed,  3 Apr 2019 09:26:46 +0000 (UTC)
Date:   Wed, 3 Apr 2019 11:26:44 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, will.deacon@arm.com,
        catalin.marinas@arm.com, mgorman@techsingularity.net,
        james.morse@arm.com, mark.rutland@arm.com, robin.murphy@arm.com,
        cpandya@codeaurora.org, arunks@codeaurora.org,
        dan.j.williams@intel.com, osalvador@suse.de, logang@deltatee.com,
        pasha.tatashin@oracle.com, david@redhat.com, cai@lca.pw
Subject: Re: [PATCH 5/6] mm/memremap: Rename and consolidate SECTION_SIZE
Message-ID: <20190403092644.GH15605@dhcp22.suse.cz>
References: <1554265806-11501-1-git-send-email-anshuman.khandual@arm.com>
 <1554265806-11501-6-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554265806-11501-6-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 03-04-19 10:00:05, Anshuman Khandual wrote:
> From: Robin Murphy <robin.murphy@arm.com>
> 
> Enabling ZONE_DEVICE (through ARCH_HAS_ZONE_DEVICE) for arm64 reveals that
> memremap's internal helpers for sparsemem sections conflict with arm64's
> definitions for hugepages which inherit the name of "sections" from earlier
> versions of the ARM architecture.
> 
> Disambiguate memremap by propagating sparsemem's PA_ prefix, to clarify
> that these values are in terms of addresses rather than PFNs (and
> because it's a heck of a lot easier than changing all the arch code).
> SECTION_MASK is unused, so it can just go. While here consolidate single
> instance of PA_SECTION_SIZE from mm/hmm.c as well.
> 
> [anshuman: Consolidated mm/hmm.c instance and updated the commit message]

Agreed. mremap shouldn't have redefined SECTION_SIZE in the first place.
This just adds a confusion.

> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/mmzone.h |  1 +
>  kernel/memremap.c      | 10 ++++------
>  mm/hmm.c               |  2 --
>  3 files changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index fba7741..ed7dd27 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1081,6 +1081,7 @@ static inline unsigned long early_pfn_to_nid(unsigned long pfn)
>   * PFN_SECTION_SHIFT		pfn to/from section number
>   */
>  #define PA_SECTION_SHIFT	(SECTION_SIZE_BITS)
> +#define PA_SECTION_SIZE		(1UL << PA_SECTION_SHIFT)
>  #define PFN_SECTION_SHIFT	(SECTION_SIZE_BITS - PAGE_SHIFT)
>  
>  #define NR_MEM_SECTIONS		(1UL << SECTIONS_SHIFT)
> diff --git a/kernel/memremap.c b/kernel/memremap.c
> index a856cb5..dda1367 100644
> --- a/kernel/memremap.c
> +++ b/kernel/memremap.c
> @@ -14,8 +14,6 @@
>  #include <linux/hmm.h>
>  
>  static DEFINE_XARRAY(pgmap_array);
> -#define SECTION_MASK ~((1UL << PA_SECTION_SHIFT) - 1)
> -#define SECTION_SIZE (1UL << PA_SECTION_SHIFT)
>  
>  #if IS_ENABLED(CONFIG_DEVICE_PRIVATE)
>  vm_fault_t device_private_entry_fault(struct vm_area_struct *vma,
> @@ -98,8 +96,8 @@ static void devm_memremap_pages_release(void *data)
>  		put_page(pfn_to_page(pfn));
>  
>  	/* pages are dead and unused, undo the arch mapping */
> -	align_start = res->start & ~(SECTION_SIZE - 1);
> -	align_size = ALIGN(res->start + resource_size(res), SECTION_SIZE)
> +	align_start = res->start & ~(PA_SECTION_SIZE - 1);
> +	align_size = ALIGN(res->start + resource_size(res), PA_SECTION_SIZE)
>  		- align_start;
>  
>  	nid = page_to_nid(pfn_to_page(align_start >> PAGE_SHIFT));
> @@ -154,8 +152,8 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
>  	if (!pgmap->ref || !pgmap->kill)
>  		return ERR_PTR(-EINVAL);
>  
> -	align_start = res->start & ~(SECTION_SIZE - 1);
> -	align_size = ALIGN(res->start + resource_size(res), SECTION_SIZE)
> +	align_start = res->start & ~(PA_SECTION_SIZE - 1);
> +	align_size = ALIGN(res->start + resource_size(res), PA_SECTION_SIZE)
>  		- align_start;
>  	align_end = align_start + align_size - 1;
>  
> diff --git a/mm/hmm.c b/mm/hmm.c
> index fe1cd87..ef9e4e6 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -33,8 +33,6 @@
>  #include <linux/mmu_notifier.h>
>  #include <linux/memory_hotplug.h>
>  
> -#define PA_SECTION_SIZE (1UL << PA_SECTION_SHIFT)
> -
>  #if IS_ENABLED(CONFIG_HMM_MIRROR)
>  static const struct mmu_notifier_ops hmm_mmu_notifier_ops;
>  
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs
