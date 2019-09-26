Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58531C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 07:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 382AB222C5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 07:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfIZHxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 03:53:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:41402 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725815AbfIZHxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 03:53:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2265DAED6;
        Thu, 26 Sep 2019 07:53:10 +0000 (UTC)
Date:   Thu, 26 Sep 2019 09:53:07 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Alastair D'Silva <alastair@au1.ibm.com>
Cc:     alastair@d-silva.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] memory_hotplug: Add a bounds check to __add_pages
Message-ID: <20190926075307.GB17200@linux>
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

On Thu, Sep 26, 2019 at 11:34:05AM +1000, Alastair D'Silva wrote:
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

Reviewed-by: Oscar Salvador <osalvador@suse.de>

Just a nit-picking below:

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

I would use PFN_PHYS instead:

	unsigned long max_addr = PFN_PHYS(pfn + nr_pages) - 1;

> +
> +	if (max_addr >> MAX_PHYSMEM_BITS) {
> +		WARN(1,
> +		     "Hotplugged memory exceeds maximum addressable address, range=%#lx-%#lx, maximum=%#lx\n",
> +		     pfn << PAGE_SHIFT, max_addr,

Same here.

> +		     (1ul << (MAX_PHYSMEM_BITS + 1)) - 1);

I would use a local variable to hold this computation.

> +		return -E2BIG;
> +	}
> +
> +	return 0;

-- 
Oscar Salvador
SUSE L3
