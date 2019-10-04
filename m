Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D3DC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 08:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D7882084D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 08:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570176856;
	bh=8bLGvd62yyXJEEM75akm9KRsOhNqib/V80CUazhK6OE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J6EBhbm2XpFUs9GcNX8nsWq8eHvypFdCIIrPU1dkBL4jF745HXACd4md/9NuuvNhR
	 MnYP6QQvFb1xhFi+dViE1UF9v8qiC/uxp0XdLOBm3Eqi+Kijr4bnIwEXxfmkKDYbdC
	 MmZ64QSaHpKr5YT3toosi4B6IV9i87vXq9R1hehQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387801AbfJDIOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 04:14:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:34936 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387631AbfJDIOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 04:14:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6495EB16B;
        Fri,  4 Oct 2019 08:14:12 +0000 (UTC)
Date:   Fri, 4 Oct 2019 10:13:58 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, tj@kernel.org, vdavydov.dev@gmail.com,
        hannes@cmpxchg.org, guro@fb.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: fix a deadlock in show_slab_objects()
Message-ID: <20191004081358.GA9578@dhcp22.suse.cz>
References: <1570131869-2545-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570131869-2545-1-git-send-email-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03-10-19 15:44:29, Qian Cai wrote:
> Long time ago, there fixed a similar deadlock in show_slab_objects()
> [1]. However, it is apparently due to the commits like 01fb58bcba63
> ("slab: remove synchronous synchronize_sched() from memcg cache
> deactivation path") and 03afc0e25f7f ("slab: get_online_mems for
> kmem_cache_{create,destroy,shrink}"), this kind of deadlock is back by
> just reading files in /sys/kernel/slab will generate a lockdep splat
> below.
> 
> Since the "mem_hotplug_lock" here is only to obtain a stable online node
> mask while racing with NUMA node hotplug, it is probably fine to do
> without it.

"It is probably fine" is not a proper justification. Please have a look
at my older email where I've exaplained why I believe it is safe.

> WARNING: possible circular locking dependency detected
> ------------------------------------------------------

I pressume the deadlock is real. If that is the case then Cc: stable and
Fixes tag would be really appreciated.

> Signed-off-by: Qian Cai <cai@lca.pw>

Anyway, I do agree that this is the right thing to do. With the improved
changelog, fixed up the comment alignment feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/slub.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 42c1b3af3c98..922cdcf5758a 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4838,7 +4838,15 @@ static ssize_t show_slab_objects(struct kmem_cache *s,
>  		}
>  	}
>  
> -	get_online_mems();
> +/*
> + * It is not possible to take "mem_hotplug_lock" here, as it has already held
> + * "kernfs_mutex" which could race with the lock order:
> + *
> + * mem_hotplug_lock->slab_mutex->kernfs_mutex
> + *
> + * In the worest case, it might be mis-calculated while doing NUMA node
> + * hotplug, but it shall be corrected by later reads of the same files.
> + */
>  #ifdef CONFIG_SLUB_DEBUG
>  	if (flags & SO_ALL) {
>  		struct kmem_cache_node *n;
> @@ -4879,7 +4887,6 @@ static ssize_t show_slab_objects(struct kmem_cache *s,
>  			x += sprintf(buf + x, " N%d=%lu",
>  					node, nodes[node]);
>  #endif
> -	put_online_mems();
>  	kfree(nodes);
>  	return x + sprintf(buf + x, "\n");
>  }
> -- 
> 1.8.3.1
> 

-- 
Michal Hocko
SUSE Labs
