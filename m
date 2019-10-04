Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32B6C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC1F5222BE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570190933;
	bh=gLxPNnkWrmtqLu5CnUUY7nr+OKJpt4EKiQzmO8NfSfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ehJ3jZsWE4RCarQJC/sM+tfJFf2mDk6FIfKO3Id0vctS3KYxMJEX/HVIhD4OYQZSB
	 3ki7NYLA2B2/Ndvx1W14RinKLG0szv4jtJ7vZWrLWM396P1/YdMTCxcbMmx80FMG81
	 n8aFRRvOzeki4zX64aoDUNDB3UkuF9zH1vzV8QEE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730888AbfJDMIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 08:08:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:40682 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729189AbfJDMIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 08:08:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 691DFAD7B;
        Fri,  4 Oct 2019 12:08:50 +0000 (UTC)
Date:   Fri, 4 Oct 2019 14:08:49 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alastair D'Silva <alastair@au1.ibm.com>
Cc:     alastair@d-silva.org, Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/1] memory_hotplug: Add a bounds check to __add_pages
Message-ID: <20191004120849.GG9578@dhcp22.suse.cz>
References: <20191001004617.7536-1-alastair@au1.ibm.com>
 <20191001004617.7536-2-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001004617.7536-2-alastair@au1.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 01-10-19 10:46:15, Alastair D'Silva wrote:
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

I am sorry to come late to the party. This looks better.
Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!
> ---
>  mm/memory_hotplug.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index c73f09913165..5af9f4466ad1 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -278,6 +278,22 @@ static int check_pfn_span(unsigned long pfn, unsigned long nr_pages,
>  	return 0;
>  }
>  
> +static int check_hotplug_memory_addressable(unsigned long pfn,
> +					    unsigned long nr_pages)
> +{
> +	const u64 max_addr = PFN_PHYS(pfn + nr_pages) - 1;
> +
> +	if (max_addr >> MAX_PHYSMEM_BITS) {
> +		const u64 max_allowed = (1ull << (MAX_PHYSMEM_BITS + 1)) - 1;
> +		WARN(1,
> +		     "Hotplugged memory exceeds maximum addressable address, range=%#llx-%#llx, maximum=%#llx\n",
> +		     (u64)PFN_PHYS(pfn), max_addr, max_allowed);
> +		return -E2BIG;
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * Reasonably generic function for adding memory.  It is
>   * expected that archs that support memory hotplug will
> @@ -291,6 +307,10 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
>  	unsigned long nr, start_sec, end_sec;
>  	struct vmem_altmap *altmap = restrictions->altmap;
>  
> +	err = check_hotplug_memory_addressable(pfn, nr_pages);
> +	if (err)
> +		return err;
> +
>  	if (altmap) {
>  		/*
>  		 * Validate altmap is within bounds of the total request
> -- 
> 2.21.0

-- 
Michal Hocko
SUSE Labs
