Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E78C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 407C2214D9
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569311270;
	bh=nuIKYLARAcl5wfPIwucPYK+YnO8wEx2SBifLuWdrWDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R2Xoeka1/sFJkvNwLBwskc20otJMvT5oLsLDCQuQxp3q4lghB/f57FVPL9+TpNFGj
	 xHDCkX9/9dZ5Mw6MHnyXknqjzAwVGIiBvlig9WDWSLGbQOkDXX0NTp6mY4XtsMxvWV
	 EXqfdeUIigZrzdRZHIXclq2mhvTKyUBrcrfdpjcg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504011AbfIXHrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 03:47:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:51944 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391136AbfIXHrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 03:47:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2179AAFA5;
        Tue, 24 Sep 2019 07:47:46 +0000 (UTC)
Date:   Tue, 24 Sep 2019 09:47:44 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, alastair@d-silva.org, cai@lca.pw,
        dan.j.williams@intel.com, david@redhat.com, ira.weiny@intel.com,
        jgg@ziepe.ca, logang@deltatee.com, mm-commits@vger.kernel.org,
        osalvador@suse.com, pasha.tatashin@soleen.com,
        richard.weiyang@gmail.com, torvalds@linux-foundation.org
Subject: Re: [patch 066/134] mm/memory_hotplug.c: add a bounds check to
 check_hotplug_memory_range()
Message-ID: <20190924074744.GA23050@dhcp22.suse.cz>
References: <20190923223612.gJ-_DTlay%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923223612.gJ-_DTlay%akpm@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 23-09-19 15:36:12, Andrew Morton wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> Subject: mm/memory_hotplug.c: add a bounds check to check_hotplug_memory_range()
> 
> Patch series "Add bounds check for Hotplugged memory", v3.
> 
> This series adds bounds checks for hotplugged memory, ensuring that it is
> within the physically addressable range (for platforms that define
> MAX_(POSSIBLE_)PHYSMEM_BITS.
> 
> This allows for early failure, rather than attempting to access bogus
> section numbers.
> 
> 
> This patch (of 2):
> 
> On PowerPC, the address ranges allocated to OpenCAPI LPC memory are
> allocated from firmware.  These address ranges may be higher than what
> older kernels permit, as we increased the maximum permissable address in
> commit 4ffe713b7587 ("powerpc/mm: Increase the max addressable memory to
> 2PB").  It is possible that the addressable range may change again in the
> future.
> 
> In this scenario, we end up with a bogus section returned from
> __section_nr (see the discussion on the thread "mm: Trigger bug on if a
> section is not found in __section_nr").
> 
> Adding a check here means that we fail early and have an opportunity to
> handle the error gracefully, rather than rumbling on and potentially
> accessing an incorrect section.
> 
> Further discussion is also on the thread ("powerpc: Perform a bounds check
> in arch_add_memory").
> 
> David said:
> 
> : I guess checking for address space wrapping would be overkill.  This
> : change makes sense for architecture-independent device drivers that make
> : use of the add/remove memory infrastructure (e.g., virtio-mem I am working
> : on).

Isn't this rushed a bit? I've had a review feedback just yesterday
http://lkml.kernel.org/r/20190923122513.GO6016@dhcp22.suse.cz and had
some concerns.

> Link: http://lkml.kernel.org/r/20190917010752.28395-2-alastair@au1.ibm.com
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Cc: Oscar Salvador <osalvador@suse.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  include/linux/memory_hotplug.h |    1 +
>  mm/memory_hotplug.c            |   13 ++++++++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> --- a/include/linux/memory_hotplug.h~memory_hotplug-add-a-bounds-check-to-check_hotplug_memory_range
> +++ a/include/linux/memory_hotplug.h
> @@ -110,6 +110,7 @@ extern void __online_page_increment_coun
>  extern void __online_page_free(struct page *page);
>  
>  extern int try_online_node(int nid);
> +int check_hotplug_memory_addressable(u64 start, u64 size);
>  
>  extern int arch_add_memory(int nid, u64 start, u64 size,
>  			struct mhp_restrictions *restrictions);
> --- a/mm/memory_hotplug.c~memory_hotplug-add-a-bounds-check-to-check_hotplug_memory_range
> +++ a/mm/memory_hotplug.c
> @@ -1023,6 +1023,17 @@ int try_online_node(int nid)
>  	return ret;
>  }
>  
> +int check_hotplug_memory_addressable(u64 start, u64 size)
> +{
> +#ifdef MAX_PHYSMEM_BITS
> +	if ((start + size - 1) >> MAX_PHYSMEM_BITS)
> +		return -E2BIG;
> +#endif
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(check_hotplug_memory_addressable);
> +
>  static int check_hotplug_memory_range(u64 start, u64 size)
>  {
>  	/* memory range must be block size aligned */
> @@ -1033,7 +1044,7 @@ static int check_hotplug_memory_range(u6
>  		return -EINVAL;
>  	}
>  
> -	return 0;
> +	return check_hotplug_memory_addressable(start, size);
>  }
>  
>  static int online_memory_block(struct memory_block *mem, void *arg)
> _

-- 
Michal Hocko
SUSE Labs
