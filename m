Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88D0C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 20:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A60C20869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 20:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555100790;
	bh=rjhB8UjPeZnu94O3vvme0y7e8H+YC/jSVruP5QkTLIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BZodClQUmfMUBFbARwks7LnOSUflEmHZ0Z82O3yukhwHbvz2EuXj1zUMY45yPCs0M
	 G/03PSlSV8ZWcPzDZ0y7X87g7kbVMRXkPJuktyFLVlwkthd1ktLH1zuW1QeaQre4PU
	 uhKVYuW76DOj8RME/2sNHeKEgSGQIMLwov8JKzl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfDLU02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 16:26:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:57878 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726755AbfDLU02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 16:26:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BBE92AED0;
        Fri, 12 Apr 2019 20:26:26 +0000 (UTC)
Date:   Fri, 12 Apr 2019 22:26:25 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, osalvador@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/hotplug: treat CMA pages as unmovable
Message-ID: <20190412202625.GJ5223@dhcp22.suse.cz>
References: <20190412152659.3916-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190412152659.3916-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 12-04-19 11:26:59, Qian Cai wrote:
[...]
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d96ca5bc555b..a9d2b0236167 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8005,7 +8005,10 @@ void *__init alloc_large_system_hash(const char *tablename,
>  bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
>  			 int migratetype, int flags)
>  {
> -	unsigned long pfn, iter, found;
> +	unsigned long found;
> +	unsigned long iter = 0;
> +	unsigned long pfn = page_to_pfn(page);
> +	char reason[] = "unmovable page";

	const char *reason = "unovable page";
>  
>  	/*
>  	 * TODO we could make this much more efficient by not checking every
> @@ -8015,17 +8018,20 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
>  	 * can still lead to having bootmem allocations in zone_movable.
>  	 */
>  
> -	/*
> -	 * CMA allocations (alloc_contig_range) really need to mark isolate
> -	 * CMA pageblocks even when they are not movable in fact so consider
> -	 * them movable here.
> -	 */
> -	if (is_migrate_cma(migratetype) &&
> -			is_migrate_cma(get_pageblock_migratetype(page)))
> -		return false;
> +	if (is_migrate_cma(get_pageblock_migratetype(page))) {
> +		/*
> +		 * CMA allocations (alloc_contig_range) really need to mark
> +		 * isolate CMA pageblocks even when they are not movable in fact
> +		 * so consider them movable here.
> +		 */
> +		if (is_migrate_cma(migratetype))
> +			return false;
> +
> +		strscpy(reason, "CMA page", 9);

		reason = "CMA page";

> +		goto unmovable;
> +	}

Other than that looks good. After fixing the above, feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>

-- 
Michal Hocko
SUSE Labs
