Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41922C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D9120867
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569241518;
	bh=stwjbMfH/x1TcMe4XsjzI2eHaLZ1XHq1GRqGaZ4lnsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jlFfGfHnedjGkxL/s80pAdkLihoxiroy81r3Cb0YvA1W3KOLjqvJw3qP91cj7f1zr
	 637H1PqSFy3gZsktcuC4hRvBkJV1CwQuFmv0uWJNXzf++iNvSCJUsMC2AV5FUUt9OZ
	 X+3a2BadH5TptuACE2dL0psU+S7PdmFj4ujtJ52g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732272AbfIWMZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 08:25:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:48890 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730431AbfIWMZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 08:25:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A54DEAEAE;
        Mon, 23 Sep 2019 12:25:14 +0000 (UTC)
Date:   Mon, 23 Sep 2019 14:25:13 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alastair D'Silva <alastair@au1.ibm.com>
Cc:     alastair@d-silva.org, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>, Qian Cai <cai@lca.pw>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] memory_hotplug: Add a bounds check to
 check_hotplug_memory_range()
Message-ID: <20190923122513.GO6016@dhcp22.suse.cz>
References: <20190917010752.28395-1-alastair@au1.ibm.com>
 <20190917010752.28395-2-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917010752.28395-2-alastair@au1.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 17-09-19 11:07:47, Alastair D'Silva wrote:
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
> check in arch_add_memory").

It would be nicer to refer to this by a message-id based url.
E.g. http://lkml.kernel.org/r/20190827052047.31547-1-alastair@au1.ibm.com

 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>  include/linux/memory_hotplug.h |  1 +
>  mm/memory_hotplug.c            | 13 ++++++++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index f46ea71b4ffd..bc477e98a310 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -110,6 +110,7 @@ extern void __online_page_increment_counters(struct page *page);
>  extern void __online_page_free(struct page *page);
>  
>  extern int try_online_node(int nid);
> +int check_hotplug_memory_addressable(u64 start, u64 size);
>  
>  extern int arch_add_memory(int nid, u64 start, u64 size,
>  			struct mhp_restrictions *restrictions);
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index c73f09913165..02cb9a74f561 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1030,6 +1030,17 @@ int try_online_node(int nid)
>  	return ret;
>  }
>  
> +int check_hotplug_memory_addressable(u64 start, u64 size)
> +{
> +#ifdef MAX_PHYSMEM_BITS
> +	if ((start + size - 1) >> MAX_PHYSMEM_BITS)
> +		return -E2BIG;
> +#endif

Is there any arch which doesn't define this? We seemed to be using this
in sparsemem code without any ifdefs.

> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(check_hotplug_memory_addressable);

If you squashed the patch 2 then it would become clear why this needs to
be exported because you would have a driver user. I find it a bit
unfortunate to expect that any driver which uses the hotplug code is
expected to know that this check should be called. This sounds too error
prone. Why hasn't been this done at __add_pages layer?

> +
>  static int check_hotplug_memory_range(u64 start, u64 size)
>  {
>  	/* memory range must be block size aligned */
> @@ -1040,7 +1051,7 @@ static int check_hotplug_memory_range(u64 start, u64 size)
>  		return -EINVAL;
>  	}
>  
> -	return 0;
> +	return check_hotplug_memory_addressable(start, size);

This will result in a silent failure (unlike misaligned case). Is this
what we want?

>  }
>  
>  static int online_memory_block(struct memory_block *mem, void *arg)
> -- 
> 2.21.0
> 

-- 
Michal Hocko
SUSE Labs
