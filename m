Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9777C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88DD3217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554972106;
	bh=NFsPXDOOKvAmCl5t4TVldD4cwQi5ReOYebcbkrXXt6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uAsSzPXAHnvdA0ivn0Q6BO/zUp8GJJCab6UtNmnmE/ARYGmVExONU7ICLbR4vQ5UN
	 IaboMLtH4AjrGs5y82sgbFVc/YJuAbvuRtnL7gIrPKps+KrD15gVTaP7rQp9iLgAfL
	 ldWuiGB0OoueamO22HMTdLSW58hNBd5WFybn8fmU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfDKIlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:41:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:33768 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726106AbfDKIlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 04:41:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B8AC1AD65;
        Thu, 11 Apr 2019 08:41:43 +0000 (UTC)
Date:   Thu, 11 Apr 2019 10:41:41 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Wei Yang <richard.weiyang@gmail.com>, Qian Cai <cai@lca.pw>,
        Arun KS <arunks@codeaurora.org>,
        Mathieu Malaterre <malat@debian.org>
Subject: Re: [PATCH] mm/memory_hotplug: Drop memory device reference after
 find_memory_block()
Message-ID: <20190411084141.GQ10383@dhcp22.suse.cz>
References: <20190410101455.17338-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410101455.17338-1-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 10-04-19 12:14:55, David Hildenbrand wrote:
> While current node handling is probably terribly broken for memory block
> devices that span several nodes (only possible when added during boot,
> and something like that should be blocked completely), properly put the
> device reference we obtained via find_memory_block() to get the nid.

The changelog could see some improvements I believe. (Half) stating
broken status of multinode memblock is not really useful without a wider
context so I would simply remove it. More to the point, it would be much
better to actually describe the actual problem and the user visible
effect.

"
d0dc12e86b31 ("mm/memory_hotplug: optimize memory hotplug") has started
using find_memory_block to get a nodeid for the beginnig of the onlined
pfn range. The commit has missed that the memblock contains a reference
counted object and a missing put_device will leak the kobject behind
which ADD THE USER VISIBLE EFFECT HERE.
"

> Fixes: d0dc12e86b31 ("mm/memory_hotplug: optimize memory hotplug")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Arun KS <arunks@codeaurora.org>
> Cc: Mathieu Malaterre <malat@debian.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Other than that
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memory_hotplug.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 5eb4a4c7c21b..328878b6799d 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -854,6 +854,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages, int online_typ
>  	 */
>  	mem = find_memory_block(__pfn_to_section(pfn));
>  	nid = mem->nid;
> +	put_device(&mem->dev);
>  
>  	/* associate pfn range with the zone */
>  	zone = move_pfn_range(online_type, nid, pfn, nr_pages);
> -- 
> 2.20.1

-- 
Michal Hocko
SUSE Labs
