Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0034CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B4F20863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553618042;
	bh=/HyRtG2JJ2e9eJTzDRtCjNBy/LXhKiM/DS1QmnVTQHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aL9eoEV56mRg34uAQjEHFsaRmrHvF/nUGmZlakCa8I2Uc+GBwrnkHVAFzpdXB2gpW
	 KQxy3Du24lqTJIBnIJLue4eXvfaZjz6GMaODMmAxQwFA9frzxgfQYLexSD1k5iwFSe
	 OEeM4CJdpCU/CqUjATCY1TGtBkM0S44LtVrJdFdM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731621AbfCZQeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:34:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:43340 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726175AbfCZQeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:34:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9CD33ABC1;
        Tue, 26 Mar 2019 16:33:59 +0000 (UTC)
Date:   Tue, 26 Mar 2019 17:33:56 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Qian Cai <cai@lca.pw>,
        akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] kmemleaak: survive in a low-memory situation
Message-ID: <20190326163356.GS28406@dhcp22.suse.cz>
References: <20190326154338.20594-1-cai@lca.pw>
 <20190326160536.GO10344@bombadil.infradead.org>
 <20190326162038.GH33308@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326162038.GH33308@arrakis.emea.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 26-03-19 16:20:41, Catalin Marinas wrote:
> On Tue, Mar 26, 2019 at 09:05:36AM -0700, Matthew Wilcox wrote:
> > On Tue, Mar 26, 2019 at 11:43:38AM -0400, Qian Cai wrote:
> > > Unless there is a brave soul to reimplement the kmemleak to embed it's
> > > metadata into the tracked memory itself in a foreseeable future, this
> > > provides a good balance between enabling kmemleak in a low-memory
> > > situation and not introducing too much hackiness into the existing
> > > code for now.
> > 
> > I don't understand kmemleak.  Kirill pointed me at this a few days ago:
> > 
> > https://gist.github.com/kiryl/3225e235fea390aa2e49bf625bbe83ec
> > 
> > It's caused by the XArray allocating memory using GFP_NOWAIT | __GFP_NOWARN.
> > kmemleak then decides it needs to allocate memory to track this memory.
> > So it calls kmem_cache_alloc(object_cache, gfp_kmemleak_mask(gfp));
> > 
> > #define gfp_kmemleak_mask(gfp)  (((gfp) & (GFP_KERNEL | GFP_ATOMIC)) | \
> >                                  __GFP_NORETRY | __GFP_NOMEMALLOC | \
> >                                  __GFP_NOWARN | __GFP_NOFAIL)
> > 
> > then the page allocator gets to see GFP_NOFAIL | GFP_NOWAIT and gets angry.
> > 
> > But I don't understand why kmemleak needs to mess with the GFP flags at
> > all.
> 
> Originally, it was just preserving GFP_KERNEL | GFP_ATOMIC. Starting
> with commit 6ae4bd1f0bc4 ("kmemleak: Allow kmemleak metadata allocations
> to fail"), this mask changed, aimed at making kmemleak allocation
> failures less verbose (i.e. just disable it since it's a debug tool).
> 
> Commit d9570ee3bd1d ("kmemleak: allow to coexist with fault injection")
> introduced __GFP_NOFAIL but this came with its own problems which have
> been previously reported (the warning you mentioned is another one of
> these). We didn't get to any clear conclusion on how best to allow
> allocations to fail with fault injection but not for the kmemleak
> metadata. Your suggestion below would probably do the trick.

I have objected to that on several occasions. An implicit __GFP_NOFAIL
is simply broken and __GFP_NOWAIT allocations are a shiny example of
that. You cannot loop inside the allocator for an unbound amount of time
potentially with locks held. I have heard that there are some plans to
deal with that but nothing has really materialized AFAIK. d9570ee3bd1d
should be reverted I believe.

The proper way around is to keep a pool objects and keep spare objects
for restrected allocation contexts.
-- 
Michal Hocko
SUSE Labs
