Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C582AC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD952086A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571127652;
	bh=XmcovdrD1RGNH7NPN9KzFHx/SGLCdAr9jIAH26+We6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nJYqTBC0Xympy5V278J8Q6iJXlUPe3dNDi5EpUJ8JlVwiAWt30FfyIWhVp9C8+h5B
	 Nvs0CoS2gAS6keHwGc0w32m4qBAJ5uEdkfpzsEZ+7SEllRgZiQM2mabE+KRA/p+Msh
	 xPey96IJaK83qdnYEj1igLmia4oIVs/5rLxEIyuE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbfJOIUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 04:20:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:38462 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726220AbfJOIUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 04:20:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D1171B01F;
        Tue, 15 Oct 2019 08:20:48 +0000 (UTC)
Date:   Tue, 15 Oct 2019 10:20:48 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm/memcontrol: update lruvec counters in
 mem_cgroup_move_account
Message-ID: <20191015082048.GU317@dhcp22.suse.cz>
References: <157112699975.7360.1062614888388489788.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157112699975.7360.1062614888388489788.stgit@buzz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 15-10-19 11:09:59, Konstantin Khlebnikov wrote:
> Mapped, dirty and writeback pages are also counted in per-lruvec stats.
> These counters needs update when page is moved between cgroups.

Please describe the user visible effect.

> Fixes: 00f3ca2c2d66 ("mm: memcontrol: per-lruvec stats infrastructure")
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

We want Cc: stable I suspect because broken stats might be really
misleading.

The patch looks ok to me otherwise
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c |   18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index bdac56009a38..363106578876 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5420,6 +5420,8 @@ static int mem_cgroup_move_account(struct page *page,
>  				   struct mem_cgroup *from,
>  				   struct mem_cgroup *to)
>  {
> +	struct lruvec *from_vec, *to_vec;
> +	struct pglist_data *pgdat;
>  	unsigned long flags;
>  	unsigned int nr_pages = compound ? hpage_nr_pages(page) : 1;
>  	int ret;
> @@ -5443,11 +5445,15 @@ static int mem_cgroup_move_account(struct page *page,
>  
>  	anon = PageAnon(page);
>  
> +	pgdat = page_pgdat(page);
> +	from_vec = mem_cgroup_lruvec(pgdat, from);
> +	to_vec = mem_cgroup_lruvec(pgdat, to);
> +
>  	spin_lock_irqsave(&from->move_lock, flags);
>  
>  	if (!anon && page_mapped(page)) {
> -		__mod_memcg_state(from, NR_FILE_MAPPED, -nr_pages);
> -		__mod_memcg_state(to, NR_FILE_MAPPED, nr_pages);
> +		__mod_lruvec_state(from_vec, NR_FILE_MAPPED, -nr_pages);
> +		__mod_lruvec_state(to_vec, NR_FILE_MAPPED, nr_pages);
>  	}
>  
>  	/*
> @@ -5459,14 +5465,14 @@ static int mem_cgroup_move_account(struct page *page,
>  		struct address_space *mapping = page_mapping(page);
>  
>  		if (mapping_cap_account_dirty(mapping)) {
> -			__mod_memcg_state(from, NR_FILE_DIRTY, -nr_pages);
> -			__mod_memcg_state(to, NR_FILE_DIRTY, nr_pages);
> +			__mod_lruvec_state(from_vec, NR_FILE_DIRTY, -nr_pages);
> +			__mod_lruvec_state(to_vec, NR_FILE_DIRTY, nr_pages);
>  		}
>  	}
>  
>  	if (PageWriteback(page)) {
> -		__mod_memcg_state(from, NR_WRITEBACK, -nr_pages);
> -		__mod_memcg_state(to, NR_WRITEBACK, nr_pages);
> +		__mod_lruvec_state(from_vec, NR_WRITEBACK, -nr_pages);
> +		__mod_lruvec_state(to_vec, NR_WRITEBACK, nr_pages);
>  	}
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE

-- 
Michal Hocko
SUSE Labs
