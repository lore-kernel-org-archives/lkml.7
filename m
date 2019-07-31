Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE31C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73544206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564581235;
	bh=D9W38JEMvrGlFGnAextQJoYrU/oY9PRlqWlq7dx5HrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bf5QD/XRmjI5h1N25asyXTuM+ReT5qLER7FdfrilmQUAA04dkuUzz5d1U2Lv0rOxV
	 l/B6q3bDF+/4xvH9ECPVqZd3LI0JcNcUwr1lNXJEGFNJ2r0oMksW1eFXdrnbAQkWyM
	 OyCwBcyyCdtL/PwFovdFbj+i+M3AVsxYSrpaWe60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbfGaNxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 09:53:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:42774 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727540AbfGaNxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 09:53:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5EA40AE22;
        Wed, 31 Jul 2019 13:53:52 +0000 (UTC)
Date:   Wed, 31 Jul 2019 15:53:51 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, miles.chen@mediatek.com,
        hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm/memcg: fix a -Wparentheses compilation warning
Message-ID: <20190731135351.GT9330@dhcp22.suse.cz>
References: <1564580753-17531-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564580753-17531-1-git-send-email-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 31-07-19 09:45:53, Qian Cai wrote:
> The linux-next commit ("mm/memcontrol.c: fix use after free in
> mem_cgroup_iter()") [1] introduced a compilation warning,
> 
> mm/memcontrol.c:1160:17: warning: using the result of an assignment as a
> condition without parentheses [-Wparentheses]
>         } while (memcg = parent_mem_cgroup(memcg));
>                  ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~
> mm/memcontrol.c:1160:17: note: place parentheses around the assignment
> to silence this warning
>         } while (memcg = parent_mem_cgroup(memcg));
>                        ^
>                  (                               )
> mm/memcontrol.c:1160:17: note: use '==' to turn this assignment into an
> equality comparison
>         } while (memcg = parent_mem_cgroup(memcg));
>                        ^
>                        ==
> 
> Fix it by adding a pair of parentheses.
> 
> [1] https://lore.kernel.org/linux-mm/20190730015729.4406-1-miles.chen@mediatek.com/
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

Thanks for the fix. I assume Andrew is going to squash it into the
original patch.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 694b6f8776dc..4f66a8305ae0 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1157,7 +1157,7 @@ static void invalidate_reclaim_iterators(struct mem_cgroup *dead_memcg)
>  	do {
>  		__invalidate_reclaim_iterators(memcg, dead_memcg);
>  		last = memcg;
> -	} while (memcg = parent_mem_cgroup(memcg));
> +	} while ((memcg = parent_mem_cgroup(memcg)));
>  
>  	/*
>  	 * When cgruop1 non-hierarchy mode is used,
> -- 
> 1.8.3.1

-- 
Michal Hocko
SUSE Labs
