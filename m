Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA49C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 14:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF1120870
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 14:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567607870;
	bh=AURl+now+exn+Zs3pGDr5syzuGKEWUyFYcrIcX+Jppk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ey+OsXun2ytSD0015YaamALb2GwzGnzTMWpoIZz3WNz/bYTQ+0JUFXaVoaBQF0Lhi
	 ql2ZBR+gPwizYkES5hrvW6vIsBVogaVST2r/gXeUMLqd0SXWL+Ij/65d44JAYh7INg
	 LdGs1pwi14Kv3Wcam6rA6wyuduaGz4uSc2nCuTqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731100AbfIDOhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 10:37:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:53754 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730258AbfIDOht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 10:37:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 43F1EAFFA;
        Wed,  4 Sep 2019 14:37:48 +0000 (UTC)
Date:   Wed, 4 Sep 2019 16:37:47 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v1 0/7] mm/memcontrol: recharge mlocked pages
Message-ID: <20190904143747.GA3838@dhcp22.suse.cz>
References: <156760509382.6560.17364256340940314860.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156760509382.6560.17364256340940314860.stgit@buzz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 04-09-19 16:53:08, Konstantin Khlebnikov wrote:
> Currently mlock keeps pages in cgroups where they were accounted.
> This way one container could affect another if they share file cache.
> Typical case is writing (downloading) file in one container and then
> locking in another. After that first container cannot get rid of cache.
> Also removed cgroup stays pinned by these mlocked pages.
> 
> This patchset implements recharging pages to cgroup of mlock user.
> 
> There are three cases:
> * recharging at first mlock
> * recharging at munlock to any remaining mlock
> * recharging at 'culling' in reclaimer to any existing mlock
> 
> To keep things simple recharging ignores memory limit. After that memory
> usage temporary could be higher than limit but cgroup will reclaim memory
> later or trigger oom, which is valid outcome when somebody mlock too much.

I assume that this is mlock specific because the pagecache which has the
same problem is reclaimable and the problem tends to resolve itself
after some time.

Anyway, how big of a problem this really is? A lingering memcg is
certainly not nice but pages are usually not mlocked for ever. Or is
this a way to protect from an hostile actor?

> Konstantin Khlebnikov (7):
>       mm/memcontrol: move locking page out of mem_cgroup_move_account
>       mm/memcontrol: add mem_cgroup_recharge
>       mm/mlock: add vma argument for mlock_vma_page()
>       mm/mlock: recharge memory accounting to first mlock user
>       mm/mlock: recharge memory accounting to second mlock user at munlock
>       mm/vmscan: allow changing page memory cgroup during reclaim
>       mm/mlock: recharge mlocked pages at culling by vmscan
> 
> 
>  Documentation/admin-guide/cgroup-v1/memory.rst |    5 +
>  include/linux/memcontrol.h                     |    9 ++
>  include/linux/rmap.h                           |    3 -
>  mm/gup.c                                       |    2 
>  mm/huge_memory.c                               |    4 -
>  mm/internal.h                                  |    6 +
>  mm/ksm.c                                       |    2 
>  mm/memcontrol.c                                |  104 ++++++++++++++++--------
>  mm/migrate.c                                   |    2 
>  mm/mlock.c                                     |   14 +++
>  mm/rmap.c                                      |    5 +
>  mm/vmscan.c                                    |   17 ++--
>  12 files changed, 121 insertions(+), 52 deletions(-)
> 
> --
> Signature

-- 
Michal Hocko
SUSE Labs
