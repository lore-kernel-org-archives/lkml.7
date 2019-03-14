Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB514C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 07:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 821752087C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 07:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfCNH4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 03:56:30 -0400
Received: from nat.nue.novell.com ([195.135.221.2]:11604 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726083AbfCNH43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 03:56:29 -0400
Received: by suse.de (Postfix, from userid 1000)
        id 96CDD456F; Thu, 14 Mar 2019 08:56:28 +0100 (CET)
Date:   Thu, 14 Mar 2019 08:56:28 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, mhocko@kernel.org,
        anshuman.khandual@arm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hotplug: fix notification in offline error path
Message-ID: <20190314075628.kb6j4de3thm6gezq@d104.suse.de>
References: <20190313210939.49628-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313210939.49628-1-cai@lca.pw>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 05:09:39PM -0400, Qian Cai wrote:
> Fixes: 7960509329c2 ("mm, memory_hotplug: print reason for the offlining failure")
> Signed-off-by: Qian Cai <cai@lca.pw>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/memory_hotplug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 8ffe844766da..1559c1605072 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1703,12 +1703,12 @@ static int __ref __offline_pages(unsigned long start_pfn,
>  
>  failed_removal_isolated:
>  	undo_isolate_page_range(start_pfn, end_pfn, MIGRATE_MOVABLE);
> +	memory_notify(MEM_CANCEL_OFFLINE, &arg);
>  failed_removal:
>  	pr_debug("memory offlining [mem %#010llx-%#010llx] failed due to %s\n",
>  		 (unsigned long long) start_pfn << PAGE_SHIFT,
>  		 ((unsigned long long) end_pfn << PAGE_SHIFT) - 1,
>  		 reason);
> -	memory_notify(MEM_CANCEL_OFFLINE, &arg);
>  	/* pushback to free area */
>  	mem_hotplug_done();
>  	return ret;
> -- 
> 2.17.2 (Apple Git-113)
> 

-- 
Oscar Salvador
SUSE L3
