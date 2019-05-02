Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5DCC04AA9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A1F208C4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfEBHsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 03:48:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:51664 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726159AbfEBHsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 03:48:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5EA80AD6D;
        Thu,  2 May 2019 07:48:12 +0000 (UTC)
Date:   Thu, 2 May 2019 09:48:08 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jane Chu <jane.chu@oracle.com>, linux-nvdimm@lists.01.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 03/12] mm/sparsemem: Add helpers track active portions
 of a section at boot
Message-ID: <20190502074803.GA3495@linux>
References: <155677652226.2336373.8700273400832001094.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155677653785.2336373.11131100812252340469.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155677653785.2336373.11131100812252340469.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 10:55:37PM -0700, Dan Williams wrote:
> Prepare for hot{plug,remove} of sub-ranges of a section by tracking a
> section active bitmask, each bit representing 2MB (SECTION_SIZE (128M) /
> map_active bitmask length (64)). If it turns out that 2MB is too large
> of an active tracking granularity it is trivial to increase the size of
> the map_active bitmap.
> 
> The implications of a partially populated section is that pfn_valid()
> needs to go beyond a valid_section() check and read the sub-section
> active ranges from the bitmask.
> 
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Tested-by: Jane Chu <jane.chu@oracle.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Unfortunately I did not hear back about the comments/questions I made for this
in the previous version.

> ---
>  include/linux/mmzone.h |   29 ++++++++++++++++++++++++++++-
>  mm/page_alloc.c        |    4 +++-
>  mm/sparse.c            |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 79 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 6726fc175b51..cffde898e345 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1175,6 +1175,8 @@ struct mem_section_usage {
>  	unsigned long pageblock_flags[0];
>  };
>  
> +void section_active_init(unsigned long pfn, unsigned long nr_pages);
> +
>  struct page;
>  struct page_ext;
>  struct mem_section {
> @@ -1312,12 +1314,36 @@ static inline struct mem_section *__pfn_to_section(unsigned long pfn)
>  
>  extern int __highest_present_section_nr;
>  
> +static inline int section_active_index(phys_addr_t phys)
> +{
> +	return (phys & ~(PA_SECTION_MASK)) / SECTION_ACTIVE_SIZE;
> +}
> +
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> +static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
> +{
> +	int idx = section_active_index(PFN_PHYS(pfn));
> +
> +	return !!(ms->usage->map_active & (1UL << idx));

section_active_mask() also converts the value to address/size.
Why do we need to convert the values and we cannot work with pfn/pages instead?
It should be perfectly possible unless I am missing something.

The only thing required would be to export earlier your:

+#define PAGES_PER_SUB_SECTION (SECTION_ACTIVE_SIZE / PAGE_SIZE)
+#define PAGE_SUB_SECTION_MASK (~(PAGES_PER_SUB_SECTION-1))

and change section_active_index to:

static inline int section_active_index(unsigned long pfn)
{
	return (pfn & ~(PAGE_SECTION_MASK)) / SUB_SECTION_ACTIVE_PAGES;
}

In this way we do need to shift the values every time and we can work with them
directly.
Maybe you made it work this way because a reason I am missing.

> +static unsigned long section_active_mask(unsigned long pfn,
> +		unsigned long nr_pages)
> +{
> +	int idx_start, idx_size;
> +	phys_addr_t start, size;
> +
> +	if (!nr_pages)
> +		return 0;
> +
> +	start = PFN_PHYS(pfn);
> +	size = PFN_PHYS(min(nr_pages, PAGES_PER_SECTION
> +				- (pfn & ~PAGE_SECTION_MASK)));

It seems to me that we already picked the lowest value back in
section_active_init, so we should be fine if we drop the min() here?

Another thing is why do we need to convert the values to address/size, and we
cannot work with pfns/pages.
Unless I am missing something it should be possible.

> +	size = ALIGN(size, SECTION_ACTIVE_SIZE);
> +
> +	idx_start = section_active_index(start);
> +	idx_size = section_active_index(size);
> +
> +	if (idx_size == 0)
> +		return -1;

Maybe we would be better off converting that -1 into something like "FULL_SECTION",
or at least dropping a comment there that "-1" means that the section is fully
populated.

> +	return ((1UL << idx_size) - 1) << idx_start;
> +}
> +
> +void section_active_init(unsigned long pfn, unsigned long nr_pages)
> +{
> +	int end_sec = pfn_to_section_nr(pfn + nr_pages - 1);
> +	int i, start_sec = pfn_to_section_nr(pfn);
> +
> +	if (!nr_pages)
> +		return;
> +
> +	for (i = start_sec; i <= end_sec; i++) {
> +		struct mem_section *ms;
> +		unsigned long mask;
> +		unsigned long pfns;
> +
> +		pfns = min(nr_pages, PAGES_PER_SECTION
> +				- (pfn & ~PAGE_SECTION_MASK));
> +		mask = section_active_mask(pfn, pfns);
> +
> +		ms = __nr_to_section(i);
> +		ms->usage->map_active |= mask;
> +		pr_debug("%s: sec: %d mask: %#018lx\n", __func__, i, ms->usage->map_active);
> +
> +		pfn += pfns;
> +		nr_pages -= pfns;
> +	}
> +}
> +
>  /* Record a memory area against a node. */
>  void __init memory_present(int nid, unsigned long start, unsigned long end)
>  {
> 

-- 
Oscar Salvador
SUSE L3
