Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63543C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 07:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3632E222C7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 07:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569483903;
	bh=pZy0b91IcGDUU/4dO2zwKPGS3d79Rbor1u62MgztOHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qxoqkA2aLcjsofxOi1NrKxzc12KqRa193S//l5qt+jgyFikrf1srhPF9gYi/O2HbM
	 sAfRAin1DAZ7Jxkpse1JZrFP5zDDdhjJvmyytUcDWRPhUSwBnBN7FmBrsYfNxXt1Lh
	 +q+ECBGwMwSb1/YNjG3Y2OyXkb5kdwPSVjJhw+w8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731237AbfIZHpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 03:45:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:39076 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729053AbfIZHpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 03:45:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 50C9CAE0C;
        Thu, 26 Sep 2019 07:44:59 +0000 (UTC)
Date:   Thu, 26 Sep 2019 09:44:58 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alastair D'Silva <alastair@au1.ibm.com>
Cc:     alastair@d-silva.org, Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] memory_hotplug: Add a bounds check to __add_pages
Message-ID: <20190926074458.GE20255@dhcp22.suse.cz>
References: <20190926013406.16133-1-alastair@au1.ibm.com>
 <20190926013406.16133-2-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926013406.16133-2-alastair@au1.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26-09-19 11:34:05, Alastair D'Silva wrote:
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

Yes, this looks better to me. E2BIG is a new error code for this path
but no callers seem to be deeply concerned about a specific error codes
so this should be safe.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memory_hotplug.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index c73f09913165..212804c0f7f5 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -278,6 +278,22 @@ static int check_pfn_span(unsigned long pfn, unsigned long nr_pages,
>  	return 0;
>  }
>  
> +static int check_hotplug_memory_addressable(unsigned long pfn,
> +					    unsigned long nr_pages)
> +{
> +	unsigned long max_addr = ((pfn + nr_pages) << PAGE_SHIFT) - 1;
> +
> +	if (max_addr >> MAX_PHYSMEM_BITS) {
> +		WARN(1,
> +		     "Hotplugged memory exceeds maximum addressable address, range=%#lx-%#lx, maximum=%#lx\n",
> +		     pfn << PAGE_SHIFT, max_addr,
> +		     (1ul << (MAX_PHYSMEM_BITS + 1)) - 1);
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
