Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CCFC73C76
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 07:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE2B20838
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 07:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562742312;
	bh=OvHOLk31LU5PHwE9O5BOcj+gIa36yQzZRYPmZhFFFpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r3rkwALnVPEOeE6eZ5zm9zidlZzfq+IdzU6EJDgkqx3qxqfuhYkMPoTpJUaEpMDRL
	 4qgN+ox2lMg9MxOmSLbkNxqMKX2Uuvu03hh1juyYPoTSiFJGbXbAqNgxV5G7YpgEYS
	 efNk3xYAXhG/Jm9Z9gxuaW17wyibAsCPNfSZHM/M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfGJHFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 03:05:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:33350 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726151AbfGJHFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 03:05:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3615DAC4C;
        Wed, 10 Jul 2019 07:05:10 +0000 (UTC)
Date:   Wed, 10 Jul 2019 09:05:09 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20190710070509.GB29695@dhcp22.suse.cz>
References: <20190709211559.6ffd2f4e@canb.auug.org.au>
 <20190709134233.b50814f5a789244b9bdb573e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709134233.b50814f5a789244b9bdb573e@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 09-07-19 13:42:33, Andrew Morton wrote:
> On Tue, 9 Jul 2019 21:15:59 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> > Hi all,
> > 
> > After merging the akpm-current tree, today's linux-next build (arm
> > multi_v7_defconfig) failed like this:
> > 
> > arm-linux-gnueabi-ld: mm/list_lru.o: in function `list_lru_add':
> > list_lru.c:(.text+0x1a0): undefined reference to `memcg_set_shrinker_bit'
> > 
> > Caused by commit
> > 
> >   ca37e9e5f18d ("mm-shrinker-make-shrinker-not-depend-on-memcg-kmem-fix-2")
> > 
> > CONFIG_MEMCG is not set for this build.
> > 
> > I have reverted that commit for today.
> 
> Thanks.  This, I suppose:
> 
> --- a/include/linux/memcontrol.h~mm-shrinker-make-shrinker-not-depend-on-memcg-kmem-fix-2-fix
> +++ a/include/linux/memcontrol.h
> @@ -1259,6 +1259,8 @@ static inline bool mem_cgroup_under_sock
>  	} while ((memcg = parent_mem_cgroup(memcg)));
>  	return false;
>  }
> +extern void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
> +                                  int nid, int shrinker_id);
>  #else
>  #define mem_cgroup_sockets_enabled 0
>  static inline void mem_cgroup_sk_alloc(struct sock *sk) { };
> @@ -1267,6 +1269,10 @@ static inline bool mem_cgroup_under_sock
>  {
>  	return false;
>  }
> +static inline void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
> +					  int nid, int shrinker_id)
> +{
> +}
>  #endif

Can we get the full series resent please. I have completely lost track
of all the follow up fixes.

Thanks!
-- 
Michal Hocko
SUSE Labs
