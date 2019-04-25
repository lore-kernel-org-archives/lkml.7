Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A528C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D302081C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfDYOnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 10:43:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:33236 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725900AbfDYOne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 10:43:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9078BAEF6;
        Thu, 25 Apr 2019 14:43:32 +0000 (UTC)
Message-ID: <1556203394.3587.4.camel@suse.de>
Subject: Re: [PATCH v6 03/12] mm/sparsemem: Add helpers track active
 portions of a section at boot
From:   Oscar Salvador <osalvador@suse.de>
To:     Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org
Cc:     Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        david@redhat.com
Date:   Thu, 25 Apr 2019 16:43:14 +0200
In-Reply-To: <155552635098.2015392.5460028594173939000.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
         <155552635098.2015392.5460028594173939000.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-04-17 at 11:39 -0700, Dan Williams wrote:
> Prepare for hot{plug,remove} of sub-ranges of a section by tracking a
> section active bitmask, each bit representing 2MB (SECTION_SIZE
> (128M) /
> map_active bitmask length (64)). If it turns out that 2MB is too
> large
> of an active tracking granularity it is trivial to increase the size
> of
> the map_active bitmap.
> 
> The implications of a partially populated section is that pfn_valid()
> needs to go beyond a valid_section() check and read the sub-section
> active ranges from the bitmask.
> 
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Hi Dan,

I am still going through the patchset but:
 
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

We already picked the lowest value in section_active_init, didn't we?
This min() operations seems redundant to me here.

> +	size = ALIGN(size, SECTION_ACTIVE_SIZE);
> +
> +	idx_start = section_active_index(start);
> +	idx_size = section_active_index(size);
> +
> +	if (idx_size == 0)
> +		return -1;
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

s/pfns/nr_pfns/ instead?

> +		pfns = min(nr_pages, PAGES_PER_SECTION
> +				- (pfn & ~PAGE_SECTION_MASK));
> +		mask = section_active_mask(pfn, pfns);
> +
> +		ms = __nr_to_section(i);
> +		pr_debug("%s: sec: %d mask: %#018lx\n", __func__, i,
> mask);
> +		ms->usage->map_active = mask;
> +
> +		pfn += pfns;
> +		nr_pages -= pfns;
> +	}
> +}

Although the code is not very complicated, it could use some comments
here and there I think.

> +
>  /* Record a memory area against a node. */
>  void __init memory_present(int nid, unsigned long start, unsigned
> long end)
>  {
> 
-- 
Oscar Salvador
SUSE L3
