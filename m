Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1146C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 07:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F902087C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 07:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfCNHz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 03:55:27 -0400
Received: from charybdis-ext.suse.de ([195.135.221.2]:11999 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726465AbfCNHz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 03:55:26 -0400
Received: by suse.de (Postfix, from userid 1000)
        id 56248456D; Thu, 14 Mar 2019 08:55:25 +0100 (CET)
Date:   Thu, 14 Mar 2019 08:55:25 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, mhocko@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: fix a wrong flag in set_migratetype_isolate()
Message-ID: <20190314075521.mp6k63bpwprqhtmh@d104.suse.de>
References: <20190313212507.49852-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313212507.49852-1-cai@lca.pw>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 05:25:07PM -0400, Qian Cai wrote:
> Due to has_unmovable_pages() takes an incorrect irqsave flag instead of
> the isolation flag in set_migratetype_isolate(), it causes issues with
> HWPOSION and error reporting where dump_page() is not called when there
> is an unmoveable page.
> 
> Fixes: d381c54760dc ("mm: only report isolation failures when offlining memory")
> Signed-off-by: Qian Cai <cai@lca.pw>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/page_isolation.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index bf67b63227ca..0f5c92fdc7f1 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -59,7 +59,8 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
>  	 * FIXME: Now, memory hotplug doesn't call shrink_slab() by itself.
>  	 * We just check MOVABLE pages.
>  	 */
> -	if (!has_unmovable_pages(zone, page, arg.pages_found, migratetype, flags))
> +	if (!has_unmovable_pages(zone, page, arg.pages_found, migratetype,
> +				 isol_flags))
>  		ret = 0;
>  
>  	/*
> -- 
> 2.17.2 (Apple Git-113)
> 

-- 
Oscar Salvador
SUSE L3
