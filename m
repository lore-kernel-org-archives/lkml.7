Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF7BC4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 05:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB852168B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 05:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbfI3FyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 01:54:05 -0400
Received: from ushosting.nmnhosting.com ([66.55.73.32]:59674 "EHLO
        ushosting.nmnhosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbfI3FyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 01:54:04 -0400
Received: from mail2.nmnhosting.com (unknown [202.78.40.170])
        by ushosting.nmnhosting.com (Postfix) with ESMTPS id 8E0E72DC006C;
        Mon, 30 Sep 2019 01:54:03 -0400 (EDT)
Received: from adsilva.ozlabs.ibm.com (static-82-10.transact.net.au [122.99.82.10] (may be forged))
        (authenticated bits=0)
        by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTPSA id x8U5rh60025864
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 30 Sep 2019 15:53:59 +1000 (AEST)
        (envelope-from alastair@d-silva.org)
Message-ID: <fe92ffd261cf9d98d7d0e8e123cea29e781b9061.camel@d-silva.org>
Subject: Re: [PATCH v5 1/1] memory_hotplug: Add a bounds check to __add_pages
From:   "Alastair D'Silva" <alastair@d-silva.org>
To:     "Alastair D'Silva" <alastair@au1.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 30 Sep 2019 15:53:42 +1000
In-Reply-To: <20190930022152.14114-2-alastair@au1.ibm.com>
References: <20190930022152.14114-1-alastair@au1.ibm.com>
         <20190930022152.14114-2-alastair@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail2.nmnhosting.com [10.0.1.20]); Mon, 30 Sep 2019 15:54:00 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-09-30 at 12:21 +1000, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> On PowerPC, the address ranges allocated to OpenCAPI LPC memory
> are allocated from firmware. These address ranges may be higher
> than what older kernels permit, as we increased the maximum
> permissable address in commit 4ffe713b7587
> ("powerpc/mm: Increase the max addressable memory to 2PB"). It is
> possible that the addressable range may change again in the
> future.
> 
> In this scenario, we end up with a bogus section returned from
> __section_nr (see the discussion on the thread "mm: Trigger bug on
> if a section is not found in __section_nr").
> 
> Adding a check here means that we fail early and have an
> opportunity to handle the error gracefully, rather than rumbling
> on and potentially accessing an incorrect section.
> 
> Further discussion is also on the thread ("powerpc: Perform a bounds
> check in arch_add_memory")
> http://lkml.kernel.org/r/20190827052047.31547-1-alastair@au1.ibm.com
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>  mm/memory_hotplug.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index c73f09913165..1909607da640 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -278,6 +278,22 @@ static int check_pfn_span(unsigned long pfn,
> unsigned long nr_pages,
>  	return 0;
>  }
>  
> +static int check_hotplug_memory_addressable(unsigned long pfn,
> +					    unsigned long nr_pages)
> +{
> +	const u64 max_addr = PFN_PHYS(pfn + nr_pages) - 1;
> +
> +	if (max_addr >> MAX_PHYSMEM_BITS) {
> +		const u64 max_allowed = (1ull << (MAX_PHYSMEM_BITS +
> 1)) - 1;
> +		WARN(1,
> +		     "Hotplugged memory exceeds maximum addressable
> address, range=%#lx-%#lx, maximum=%#lx\n",
Gah, these should all be %#llx.

> +		     PFN_PHYS(pfn), max_addr, max_allowed);
> +		return -E2BIG;
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * Reasonably generic function for adding memory.  It is
>   * expected that archs that support memory hotplug will
> @@ -291,6 +307,10 @@ int __ref __add_pages(int nid, unsigned long
> pfn, unsigned long nr_pages,
>  	unsigned long nr, start_sec, end_sec;
>  	struct vmem_altmap *altmap = restrictions->altmap;
>  
> +	err = check_hotplug_memory_addressable(pfn, nr_pages);
> +	if (err)
> +		return err;
> +
>  	if (altmap) {
>  		/*
>  		 * Validate altmap is within bounds of the total
> request

