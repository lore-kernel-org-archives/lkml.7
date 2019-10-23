Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E06CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 18:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97A62173B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 18:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571853685;
	bh=9R76XrSlanvE+CtPnZ46pRl03ZNvfxdYcMWHSH4TuRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=buABacV2bYgT4Qm3vZ2AKN9jsoB6leeDpq3OQaBPRpNPSJHjuFetQQlbgx8VSdTIR
	 HwmpbjDS9uTXksjCLGBJI2O3R88tOjxjOwDCupVWyN/fGa3EWDpBtBIQd+JgvAG5l/
	 kkzg+ZgjdHzy+HoBMuvEaryxfgQMBQ40kZcwQPjY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387630AbfJWSBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 14:01:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:52602 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387516AbfJWSBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 14:01:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A13E4AD46;
        Wed, 23 Oct 2019 18:01:22 +0000 (UTC)
Date:   Wed, 23 Oct 2019 20:01:21 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH 1/2] mm, vmstat: Release zone lock more frequently when
 reading /proc/pagetypeinfo
Message-ID: <20191023180121.GN17610@dhcp22.suse.cz>
References: <20191023102737.32274-3-mhocko@kernel.org>
 <20191023173423.12532-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023173423.12532-1-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 23-10-19 13:34:22, Waiman Long wrote:
> With a threshold of 100000, it is still possible that the zone lock
> will be held for a very long time in the worst case scenario where all
> the counts are just below the threshold. With up to 6 migration types
> and 11 orders, it means up to 6.6 millions.
> 
> Track the total number of list iterations done since the acquisition
> of the zone lock and release it whenever 100000 iterations or more have
> been completed. This will cap the lock hold time to no more than 200,000
> list iterations.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  mm/vmstat.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 57ba091e5460..c5b82fdf54af 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1373,6 +1373,7 @@ static void pagetypeinfo_showfree_print(struct seq_file *m,
>  					pg_data_t *pgdat, struct zone *zone)
>  {
>  	int order, mtype;
> +	unsigned long iteration_count = 0;
>  
>  	for (mtype = 0; mtype < MIGRATE_TYPES; mtype++) {
>  		seq_printf(m, "Node %4d, zone %8s, type %12s ",
> @@ -1397,15 +1398,24 @@ static void pagetypeinfo_showfree_print(struct seq_file *m,
>  				 * of pages in this order should be more than
>  				 * sufficient
>  				 */
> -				if (++freecount >= 100000) {
> +				if (++freecount > 100000) {
>  					overflow = true;
> -					spin_unlock_irq(&zone->lock);
> -					cond_resched();
> -					spin_lock_irq(&zone->lock);
> +					freecount--;
>  					break;
>  				}
>  			}
>  			seq_printf(m, "%s%6lu ", overflow ? ">" : "", freecount);
> +			/*
> +			 * Take a break and release the zone lock when
> +			 * 100000 or more entries have been iterated.
> +			 */
> +			iteration_count += freecount;
> +			if (iteration_count >= 100000) {
> +				iteration_count = 0;
> +				spin_unlock_irq(&zone->lock);
> +				cond_resched();
> +				spin_lock_irq(&zone->lock);
> +			}

Aren't you overengineering this a bit? If you are still worried then we
can simply cond_resched for each order
diff --git a/mm/vmstat.c b/mm/vmstat.c
index c156ce24a322..ddb89f4e0486 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1399,13 +1399,13 @@ static void pagetypeinfo_showfree_print(struct seq_file *m,
 				 */
 				if (++freecount >= 100000) {
 					overflow = true;
-					spin_unlock_irq(&zone->lock);
-					cond_resched();
-					spin_lock_irq(&zone->lock);
 					break;
 				}
 			}
 			seq_printf(m, "%s%6lu ", overflow ? ">" : "", freecount);
+			spin_unlock_irq(&zone->lock);
+			cond_resched();
+			spin_lock_irq(&zone->lock);
 		}
 		seq_putc(m, '\n');
 	}

I do not have a strong opinion here but I can fold this into my patch 2.
-- 
Michal Hocko
SUSE Labs
