Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE93C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60AFE21841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553071565;
	bh=btRyjQpK7yxpBhZugLt+6V0RHkBriw83jEf8jL4OmUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Fvx4p0gzRlfW07yUR6dyK8xOoT/KuAwcoxY7bCPlaZyEz4DOhkjjyOmb8VKnN7seA
	 XTothRh3iQEYRKEhBCkFHC10O6C2w29KY0EisvnYRQXLZJH0gIkE4tYBF3heKx8Y+y
	 UgjBNmJl6X6DTEXR4vsnWlALk4UIIo5ip0steFac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfCTIqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 04:46:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:56874 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726417AbfCTIqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 04:46:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5A0E0ADE1;
        Wed, 20 Mar 2019 08:46:01 +0000 (UTC)
Date:   Wed, 20 Mar 2019 09:46:00 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        osalvador@suse.de, david@redhat.com, richard.weiyang@gmail.com,
        rppt@linux.ibm.com
Subject: Re: [PATCH] mm, memory_hotplug: Fix the wrong usage of N_HIGH_MEMORY
Message-ID: <20190320084600.GG30433@dhcp22.suse.cz>
References: <20190320080732.14933-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320080732.14933-1-bhe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20-03-19 16:07:32, Baoquan He wrote:
> In function node_states_check_changes_online(), N_HIGH_MEMORY is used
> to substitute ZONE_HIGHMEM directly. This is not right. N_HIGH_MEMORY
> always has value '3' if CONFIG_HIGHMEM=y, while ZONE_HIGHMEM's value
> is not. It depends on whether CONFIG_ZONE_DMA/CONFIG_ZONE_DMA32 are
> enabled. Obviously it's not true for CONFIG_ZONE_DMA32 on 32bit system,
> and CONFIG_ZONE_DMA is also optional.
> 
> Replace it with ZONE_HIGHMEM.

N*MEMORY is confusing as hell but I am really curious whether we have
ZONE_DMA32 and ZONE_HIGMEM together?

That being said N.*MEMORY is intended to check for nodes rather than
zones so the patch looks good to me but I think the above explanation is
misleading and will add even more mud to the picture when somebody tries
to understand what the heck is going on here.

> Fixes: 8efe33f40f3e ("mm/memory_hotplug.c: simplify node_states_check_changes_online")
> Signed-off-by: Baoquan He <bhe@redhat.com>
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

-- 
Michal Hocko
SUSE Labs
