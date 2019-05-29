Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2FFC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51C0423AC7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559144321;
	bh=2h4jPxea/5I2VngCX9PTTko6VbGJBROb8nCLl8FwGws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bolLcnObGQwWpvfp7IKU0Jm/x4MUs5bxgG+Sp/CHHTk64LxY2UrtN0EkCd++1OguH
	 aRLzJt6IP0S7P6+9Rdc+KBeEf6Nfx5O45w3lp9svo7Fz1OeaoChAlzXR9eVBxXF74I
	 uqziRnHA3UNPniX1OcRzJJfMkszPrmNCCRny9N0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfE2Pik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 11:38:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:42932 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726012AbfE2Pij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 11:38:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A3677AC50;
        Wed, 29 May 2019 15:38:38 +0000 (UTC)
Date:   Wed, 29 May 2019 17:38:36 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     akpm@linux-foundation.org, daniel.m.jordan@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Fix recent_rotated history
Message-ID: <20190529153836.GF18589@dhcp22.suse.cz>
References: <155905972210.26456.11178359431724024112.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155905972210.26456.11178359431724024112.stgit@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28-05-19 19:09:02, Kirill Tkhai wrote:
> Johannes pointed that after commit 886cf1901db9
> we lost all zone_reclaim_stat::recent_rotated
> history. This commit fixes that.
> 
> Fixes: 886cf1901db9 "mm: move recent_rotated pages calculation to shrink_inactive_list()"
> Reported-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>

I didn't get to review the original bug series but this one looks
obviously correct.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/vmscan.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index d9c3e873eca6..1d49329a4d7d 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1953,8 +1953,8 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
>  	if (global_reclaim(sc))
>  		__count_vm_events(item, nr_reclaimed);
>  	__count_memcg_events(lruvec_memcg(lruvec), item, nr_reclaimed);
> -	reclaim_stat->recent_rotated[0] = stat.nr_activate[0];
> -	reclaim_stat->recent_rotated[1] = stat.nr_activate[1];
> +	reclaim_stat->recent_rotated[0] += stat.nr_activate[0];
> +	reclaim_stat->recent_rotated[1] += stat.nr_activate[1];
>  
>  	move_pages_to_lru(lruvec, &page_list);
>  
> 

-- 
Michal Hocko
SUSE Labs
