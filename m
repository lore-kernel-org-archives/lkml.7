Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35D6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E632184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfCTM1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:27:52 -0400
Received: from nat.nue.novell.com ([195.135.221.2]:61697 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725996AbfCTM1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:27:51 -0400
Received: by suse.de (Postfix, from userid 1000)
        id 8E8A84627; Wed, 20 Mar 2019 13:27:50 +0100 (CET)
Date:   Wed, 20 Mar 2019 13:27:50 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mhocko@suse.com, david@redhat.com, richard.weiyang@gmail.com,
        rppt@linux.ibm.com
Subject: Re: [PATCH] mm, memory_hotplug: Fix the wrong usage of N_HIGH_MEMORY
Message-ID: <20190320122750.u7rnbbsyhhte3eww@d104.suse.de>
References: <20190320080732.14933-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320080732.14933-1-bhe@redhat.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 04:07:32PM +0800, Baoquan He wrote:
> In function node_states_check_changes_online(), N_HIGH_MEMORY is used
> to substitute ZONE_HIGHMEM directly. This is not right. N_HIGH_MEMORY
> always has value '3' if CONFIG_HIGHMEM=y, while ZONE_HIGHMEM's value
> is not. It depends on whether CONFIG_ZONE_DMA/CONFIG_ZONE_DMA32 are
> enabled. Obviously it's not true for CONFIG_ZONE_DMA32 on 32bit system,
> and CONFIG_ZONE_DMA is also optional.
> 
> Replace it with ZONE_HIGHMEM.
> 
> Fixes: 8efe33f40f3e ("mm/memory_hotplug.c: simplify node_states_check_changes_online")
> Signed-off-by: Baoquan He <bhe@redhat.com>

Yeah, that was an oversight.
I got it right in node_states_check_changes_offline but not here.

Thanks to catch this.

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/memory_hotplug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 6b05576fb4ec..09911d34a3be 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -712,7 +712,7 @@ static void node_states_check_changes_online(unsigned long nr_pages,
>  	if (zone_idx(zone) <= ZONE_NORMAL && !node_state(nid, N_NORMAL_MEMORY))
>  		arg->status_change_nid_normal = nid;
>  #ifdef CONFIG_HIGHMEM
> -	if (zone_idx(zone) <= N_HIGH_MEMORY && !node_state(nid, N_HIGH_MEMORY))
> +	if (zone_idx(zone) <= ZONE_HIGHMEM && !node_state(nid, N_HIGH_MEMORY))
>  		arg->status_change_nid_high = nid;
>  #endif
>  }
> -- 
> 2.17.2
> 

-- 
Oscar Salvador
SUSE L3
