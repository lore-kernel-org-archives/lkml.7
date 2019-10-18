Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B8BCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D32E22089C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571403730;
	bh=PgfarnClYjx8IXJcBwzxci1xDOFT0ttGWxv7Fk1YkRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VPNbYxQEIBRvii21UCaNCG0JX4WAXmudGHu8tJM46KecYFOu7krEUffB5OXcGU3J1
	 JbNrZw02FBMQJM5uV0VZva+LEvW3efamLHC9eDckfdntIlLjgo8VDSOAeDGP9ojIyH
	 KB9MWGyTXquMGTzQhvrSY/4AXCEGSkOWCg/lHKMA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634062AbfJRNCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 09:02:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:45326 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2410200AbfJRNCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 09:02:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 857B0B193;
        Fri, 18 Oct 2019 13:02:05 +0000 (UTC)
Date:   Fri, 18 Oct 2019 15:02:05 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Borislav Petkov <bp@alien8.de>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] mm, pcpu: Make zone pcp updates and reset internal
 to the mm
Message-ID: <20191018130205.GQ5017@dhcp22.suse.cz>
References: <20191018105606.3249-1-mgorman@techsingularity.net>
 <20191018105606.3249-4-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018105606.3249-4-mgorman@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 18-10-19 11:56:06, Mel Gorman wrote:
> Memory hotplug needs to be able to reset and reinit the pcpu allocator
> batch and high limits but this action is internal to the VM. Move
> the declaration to internal.h
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/mm.h | 3 ---
>  mm/internal.h      | 3 +++
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index cc292273e6ba..22d6104f2341 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2219,9 +2219,6 @@ void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...);
>  
>  extern void setup_per_cpu_pageset(void);
>  
> -extern void zone_pcp_update(struct zone *zone);
> -extern void zone_pcp_reset(struct zone *zone);
> -
>  /* page_alloc.c */
>  extern int min_free_kbytes;
>  extern int watermark_boost_factor;
> diff --git a/mm/internal.h b/mm/internal.h
> index 0d5f720c75ab..0a3d41c7b3c5 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -165,6 +165,9 @@ extern void post_alloc_hook(struct page *page, unsigned int order,
>  					gfp_t gfp_flags);
>  extern int user_min_free_kbytes;
>  
> +extern void zone_pcp_update(struct zone *zone);
> +extern void zone_pcp_reset(struct zone *zone);
> +
>  #if defined CONFIG_COMPACTION || defined CONFIG_CMA
>  
>  /*
> -- 
> 2.16.4
> 

-- 
Michal Hocko
SUSE Labs
