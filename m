Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E30C06510
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 07:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE68208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 07:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561966928;
	bh=IPcIAF6D+QsRv1M426NBDbly/iozKHGewpjp92ZybcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uAbNnnTV8hTuzuOPDqJpWlRla50HSQrQ0DuxXGDrw5VI05v3dDr0fAFZEjvZqUIje
	 +Edt+nGLTAJKJtagoKLREqnHMFdFg72PQy8/Xfv3O8UJ3TTWZ1VcLNBTEpi2wMpsWJ
	 MdOrqyZ8g2sgE/bf6WjQIhWga9hHNTXAVhVzSep8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbfGAHmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 03:42:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:50024 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726036AbfGAHmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 03:42:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5F478AFFA;
        Mon,  1 Jul 2019 07:42:04 +0000 (UTC)
Date:   Mon, 1 Jul 2019 09:42:02 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Qian Cai <cai@lca.pw>, Arun KS <arunks@codeaurora.org>,
        Mathieu Malaterre <malat@debian.org>,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH v3 01/11] mm/memory_hotplug: Simplify and fix
 check_hotplug_memory_range()
Message-ID: <20190701074202.GB6376@dhcp22.suse.cz>
References: <20190527111152.16324-1-david@redhat.com>
 <20190527111152.16324-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527111152.16324-2-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Sorry for a really late response]

On Mon 27-05-19 13:11:42, David Hildenbrand wrote:
> By converting start and size to page granularity, we actually ignore
> unaligned parts within a page instead of properly bailing out with an
> error.

I do not expect any code path would ever provide an unaligned address
and even if it did then rounding that to a pfn doesn't sound like a
terrible thing to do. Anyway this removes few lines so why not.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Cc: Arun KS <arunks@codeaurora.org>
> Cc: Mathieu Malaterre <malat@debian.org>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memory_hotplug.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index e096c987d261..762887b2358b 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1051,16 +1051,11 @@ int try_online_node(int nid)
>  
>  static int check_hotplug_memory_range(u64 start, u64 size)
>  {
> -	unsigned long block_sz = memory_block_size_bytes();
> -	u64 block_nr_pages = block_sz >> PAGE_SHIFT;
> -	u64 nr_pages = size >> PAGE_SHIFT;
> -	u64 start_pfn = PFN_DOWN(start);
> -
>  	/* memory range must be block size aligned */
> -	if (!nr_pages || !IS_ALIGNED(start_pfn, block_nr_pages) ||
> -	    !IS_ALIGNED(nr_pages, block_nr_pages)) {
> +	if (!size || !IS_ALIGNED(start, memory_block_size_bytes()) ||
> +	    !IS_ALIGNED(size, memory_block_size_bytes())) {
>  		pr_err("Block size [%#lx] unaligned hotplug range: start %#llx, size %#llx",
> -		       block_sz, start, size);
> +		       memory_block_size_bytes(), start, size);
>  		return -EINVAL;
>  	}
>  
> -- 
> 2.20.1
> 

-- 
Michal Hocko
SUSE Labs
