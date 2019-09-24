Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58FEC432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 14:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7770D2053B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 14:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569335763;
	bh=0AU/wDGgwUDHd8smkAVguK1ugghVDtA6O74RkGOU6tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0qCaRvAMOAZZnbwBH6iXOhcd98gB0ugiBG7P2cS+cmKDNItKzO59JToXJ+fqOLl+j
	 IKmECDhJriS8RuJqLLF1S3gANbBUT5x8ZjCjxJ4OpCaWn6MXx1luXIF/hHAq/r1Nq2
	 P+dtXZls5kC71F8wreayi9oiT4UmGKIJx+pMvj8k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441389AbfIXOgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 10:36:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:43214 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389297AbfIXOgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 10:36:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BF31EAD35;
        Tue, 24 Sep 2019 14:36:00 +0000 (UTC)
Date:   Tue, 24 Sep 2019 16:36:00 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mircea CIRJALIU - MELIU <mcirjaliu@bitdefender.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cl@linux.com" <cl@linux.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] slab, memcontrol: undefined reference to
 `memcg_kmem_get_cache'
Message-ID: <20190924143600.GY23050@dhcp22.suse.cz>
References: <DB7PR02MB397977A2959BFFA89AA67538BB840@DB7PR02MB3979.eurprd02.prod.outlook.com>
 <20190924120400.GN23050@dhcp22.suse.cz>
 <DB7PR02MB39799BF26E394AE30D710308BB840@DB7PR02MB3979.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB7PR02MB39799BF26E394AE30D710308BB840@DB7PR02MB3979.eurprd02.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 24-09-19 14:08:33, Mircea CIRJALIU - MELIU wrote:
> > On Tue 24-09-19 08:46:48, Mircea CIRJALIU - MELIU wrote:
> > > Having CONFIG_MEMCG turned off causes these issues:
> > > 	mm/slub.o: In function `slab_pre_alloc_hook':
> > > 	/home/mircea/build/mm/slab.h:425: undefined reference to
> > `memcg_kmem_get_cache'
> > > 	mm/slub.o: In function `slab_post_alloc_hook':
> > > 	/home/mircea/build/mm/slab.h:444: undefined reference to
> > `memcg_kmem_put_cache'
> > 
> > You should be adding your Sign-off-by to every patch you post to the kernel
> > mailing list (see Documentation/SubmittingPatches).
> > 
> > It is also really important to mention which tree does this apply to and ideally
> > also note which change has broken the code. In this particular case I have
> > tried the current Linus tree (4c07e2ddab5b) and $ grep
> > 'CONFIG_SLUB\|CONFIG_MEMCG' .config # CONFIG_MEMCG is not set
> > CONFIG_SLUB_DEBUG=y CONFIG_SLUB=y CONFIG_SLUB_CPU_PARTIAL=y
> > # CONFIG_SLUB_DEBUG_ON is not set # CONFIG_SLUB_STATS is not set
> > 
> > which means CONFIG_MEMCG_KMEM is not enabled as well. And the
> > compilation succeeds. What is your config file?
> 
> The config file is not the problem (figured it out).
> I am lowering the optimization level on certain files for debug purposes.
> In my case: CFLAGS_slub.o += -O1 -fno-inline
> 
> The code which causes the problem looks like this:
> static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
> 						     gfp_t flags)
> {
> 	...
> 
> 	if (memcg_kmem_enabled() &&
> 	    ((flags & __GFP_ACCOUNT) || (s->flags & SLAB_ACCOUNT)))
> 		return memcg_kmem_get_cache(s);
> 
> 	...
> }
> 
> Under normal circumstances memcg_kmem_enabled() returns false and the
> statement is evaluated as unreachable and removed entirely.
> It seems -O1 keeps the call to memcg_kmem_get_cache().

OK, this makes more sense now. Is it the only problem to make your
kernel compile with O1? We do rely on dead code elimination quite
heavily. I do not think we want add a lot of code for something that we
are unlikely to be able to support. This particular patch is quite small
but I am not really supper happy to add more boilerplate code...

> The change that introduced this is here: 
> 	commit 452647784b2fccfdeeb976f6f842c6719fb2daac
> 	Author: Vladimir Davydov <vdavydov@virtuozzo.com>
> 	Date:   Tue Jul 26 15:24:21 2016 -0700
> Although I had the same problem before with other header files.
> 

-- 
Michal Hocko
SUSE Labs
