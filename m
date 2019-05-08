Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C842C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 23:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D53216C8
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 23:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfEHXPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 19:15:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:35348 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725910AbfEHXPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 19:15:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7B7EAAF0C;
        Wed,  8 May 2019 23:15:51 +0000 (UTC)
Message-ID: <1557357332.3028.42.camel@suse.de>
Subject: Re: [PATCH v8 09/12] mm/sparsemem: Support sub-section hotplug
From:   Oscar Salvador <osalvador@suse.de>
To:     Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org
Cc:     Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 09 May 2019 01:15:32 +0200
In-Reply-To: <155718601407.130019.14248061058774128227.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <155718596657.130019.17139634728875079809.stgit@dwillia2-desk3.amr.corp.intel.com>
         <155718601407.130019.14248061058774128227.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-05-06 at 16:40 -0700, Dan Williams wrote:
> @@ -741,49 +895,31 @@ int __meminit sparse_add_section(int nid,
> unsigned long start_pfn,
>  		unsigned long nr_pages, struct vmem_altmap *altmap)
>  {
>  	unsigned long section_nr = pfn_to_section_nr(start_pfn);
> -	struct mem_section_usage *usage;
>  	struct mem_section *ms;
>  	struct page *memmap;
>  	int ret;

I already pointed this out in v7, but:

>  
> -	/*
> -	 * no locking for this, because it does its own
> -	 * plus, it does a kmalloc
> -	 */
>  	ret = sparse_index_init(section_nr, nid);
>  	if (ret < 0 && ret != -EEXIST)
>  		return ret;

sparse_index_init() only returns either -ENOMEM or 0, so the above can
be:

	if (ret < 0) or if (ret)

> -	ret = 0;
> -	memmap = populate_section_memmap(start_pfn,
> PAGES_PER_SECTION, nid,
> -			altmap);
> -	if (!memmap)
> -		return -ENOMEM;
> -	usage = kzalloc(mem_section_usage_size(), GFP_KERNEL);
> -	if (!usage) {
> -		depopulate_section_memmap(start_pfn,
> PAGES_PER_SECTION, altmap);
> -		return -ENOMEM;
> -	}
>  
> -	ms = __pfn_to_section(start_pfn);
> -	if (ms->section_mem_map & SECTION_MARKED_PRESENT) {
> -		ret = -EEXIST;
> -		goto out;
> -	}
> +	memmap = section_activate(nid, start_pfn, nr_pages, altmap);
> +	if (IS_ERR(memmap))
> +		return PTR_ERR(memmap);
> +	ret = 0;

If we got here, sparse_index_init must have returned 0, so ret already
contains 0.
We can remove the assignment.

>  
>  	/*
>  	 * Poison uninitialized struct pages in order to catch
> invalid flags
>  	 * combinations.
>  	 */
> -	page_init_poison(memmap, sizeof(struct page) *
> PAGES_PER_SECTION);
> +	page_init_poison(pfn_to_page(start_pfn), sizeof(struct page)
> * nr_pages);
>  
> +	ms = __pfn_to_section(start_pfn);
>  	section_mark_present(ms);
> -	sparse_init_one_section(ms, section_nr, memmap, usage);
> +	sparse_init_one_section(ms, section_nr, memmap, ms->usage);
>  
> -out:
> -	if (ret < 0) {
> -		kfree(usage);
> -		depopulate_section_memmap(start_pfn,
> PAGES_PER_SECTION, altmap);
> -	}
> +	if (ret < 0)
> +		section_deactivate(start_pfn, nr_pages, nid,
> altmap);

AFAICS, ret is only set by the return code from sparse_index_init, so
we cannot really get to this code being ret different than 0.
So we can remove the above two lines.

I will start reviewing the patches that lack review from this version
soon.

-- 
Oscar Salvador
SUSE L3
