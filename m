Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF02ECA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 14:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A4221925
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 14:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571841533;
	bh=QvkMVPs839hryNItFmVVgak2DpaIaNQemGE6s0yfJus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Wia2sZB8+hWceVonII8xr7vSSr5ibijeVvgPmaVtzohcmmaK7AOINQFj0rr/lZ2sS
	 S4ozJu1YHEvZyzrU/7VnFJcYkJ+D6Fvj1yKZZl9PXAI7vhc/7gZthJZxKqy07HNlTd
	 6E9nqlflJfX5Am2zUgu3sfUo2GH/HeYtD4+U5tU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392283AbfJWOiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 10:38:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:49386 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389921AbfJWOiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 10:38:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5178AAC10;
        Wed, 23 Oct 2019 14:38:50 +0000 (UTC)
Date:   Wed, 23 Oct 2019 16:38:47 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, osalvador@suse.de,
        mgorman@techsingularity.net, rppt@linux.ibm.com,
        dan.j.williams@intel.com, alexander.h.duyck@linux.intel.com,
        anshuman.khandual@arm.com, pavel.tatashin@microsoft.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: fix gcc compile warning
Message-ID: <20191023143847.GJ17610@dhcp22.suse.cz>
References: <1571838508-117928-1-git-send-email-chenwandun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571838508-117928-1-git-send-email-chenwandun@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 23-10-19 21:48:28, Chen Wandun wrote:
> From: Chenwandun <chenwandun@huawei.com>
> 
> mm/page_alloc.o: In function `page_alloc_init_late':
> mm/page_alloc.c:1956: undefined reference to `zone_pcp_update'
> mm/page_alloc.o:(.debug_addr+0x8350): undefined reference to `zone_pcp_update'
> make: *** [vmlinux] Error 1
> 
> zone_pcp_update is defined in CONFIG_MEMORY_HOTPLUG,
> so add ifdef when calling zone_pcp_update.

David has already pointed out that this has been fixed already but let
me note one more thing. This patch is wrong at two levels. The first one
that it simply does a wrong thing. The comment above the code explains
why zone_pcp_update is called and ifdef makes it depend on
MEMORY_HOTPLUG support which has nothing to do with that code.
The second problem and I find it as a reoccuring problem (and that's why
I am writing this reply) that the changelog explains what but it doesn't
say why. It would certainly be unsatisfactory to say "because compiler
complains". So there would have to be a clarification that
zone_pcp_update is only available for CONFIG_MEMORY_HOTPLUG and why the
code only applies to those configuration. That would be much harder to
justify because there is no real connection.

That being said, a proper changelog with a good explanation of what and
why can help to discover a wrong patch early.

> Signed-off-by: Chenwandun <chenwandun@huawei.com>
> ---
>  mm/page_alloc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index f9488ef..8513150 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1952,8 +1952,10 @@ void __init page_alloc_init_late(void)
>  	 * so the pcpu batch and high limits needs to be updated or the limits
>  	 * will be artificially small.
>  	 */
> +#ifdef CONFIG_MEMORY_HOTPLUG
>  	for_each_populated_zone(zone)
>  		zone_pcp_update(zone);
> +#endif
>  
>  	/*
>  	 * We initialized the rest of the deferred pages.  Permanently disable
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
