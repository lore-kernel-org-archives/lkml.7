Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBAEC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 05:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A9D217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 05:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566884621;
	bh=chMysLLacYvgN/hPklsN3lcWmtRimfzfHVWE42kvjG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C0IMvDnsUVDvFS13ujiC3Y0tIdKmB2psNkhPTek3zQdjUQAstjYq3P1GDxtDb1UVO
	 j1TTaFYJwMuSXPvw93X8cMCOWGgoiwjas1aoT6Bm0zzsmx/Qz/vUnTaXa0TWuYYEEW
	 9ax+qNwM3774h6YQZ0tTNR2IBz3qabLLrrGv0wl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfH0Fnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 01:43:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:49164 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725874AbfH0Fnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 01:43:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 20079ACC2;
        Tue, 27 Aug 2019 05:43:38 +0000 (UTC)
Date:   Tue, 27 Aug 2019 07:43:37 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pankaj Suryawanshi <pankajssuryawanshi@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        pankaj.suryawanshi@einfochips.com
Subject: Re: PageBlocks and Migrate Types
Message-ID: <20190827054337.GK7538@dhcp22.suse.cz>
References: <CACDBo57u+sgordDvFpTzJ=U4mT8uVz7ZovJ3qSZQCrhdYQTw0A@mail.gmail.com>
 <20190822125231.GJ12785@dhcp22.suse.cz>
 <CACDBo57OkND1LCokPLfyR09+oRTbA6+GAPc90xAEF6AM_LmbyQ@mail.gmail.com>
 <20190826070436.GA7538@dhcp22.suse.cz>
 <CACDBo555_pxZjixThUZcqnADVVcmH1Qtfrr5H-2AR12L0=Rx3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACDBo555_pxZjixThUZcqnADVVcmH1Qtfrr5H-2AR12L0=Rx3A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 26-08-19 22:35:08, Pankaj Suryawanshi wrote:
> On Mon, Aug 26, 2019 at 12:34 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Thu 22-08-19 23:54:19, Pankaj Suryawanshi wrote:
> > > On Thu, Aug 22, 2019 at 6:22 PM Michal Hocko <mhocko@kernel.org> wrote:
> > > >
> > > > On Wed 21-08-19 22:23:44, Pankaj Suryawanshi wrote:
> > > > > Hello,
> > > > >
> > > > > 1. What are Pageblocks and migrate types(MIGRATE_CMA) in Linux
> memory ?
> > > >
> > > > Pageblocks are a simple grouping of physically contiguous pages with
> > > > common set of flags. I haven't checked closely recently so I might
> > > > misremember but my recollection is that only the migrate type is
> stored
> > > > there. Normally we would store that information into page flags but
> > > > there is not enough room there.
> > > >
> > > > MIGRATE_CMA represent pages allocated for the CMA allocator. There are
> > > > other migrate types denoting unmovable/movable allocations or pages
> that
> > > > are isolated from the page allocator.
> > > >
> > > > Very broadly speaking, the migrate type groups pages with similar
> > > > movability properties to reduce fragmentation that compaction cannot
> > > > do anything about because there are objects of different properti
> > > > around. Please note that pageblock might contain objects of a
> different
> > > > migrate type in some cases (e.g. low on memory).
> > > >
> > > > Have a look at gfpflags_to_migratetype and how the gfp mask is
> converted
> > > > to a migratetype for the allocation. Also follow different
> MIGRATE_$TYPE
> > > > to see how it is used in the code.
> > > >
> > > > > How many movable/unmovable pages are defined by default?
> > > >
> > > > There is nothing like that. It depends on how many objects of a
> specific
> > > > type are allocated.
> > >
> > >
> > > It means that it started creating pageblocks after allocation of
> > > different objects, but from which block it allocate initially when
> > > there is nothing like pageblocks ? (when memory subsystem up)
> >
> > Pageblocks are just a way to group physically contiguous pages. They
> > just exist along with the physically contiguous memory. The migrate type
> > for most of the memory is set to MIGRATE_MOVABLE. Portion of the memory
> > might be reserved by CMA then that memory has MIGRATE_CMA. Following
> > set_pageblock_migratetype call paths will give you a good picture.
> 
> it means if i have 4096 continuous pages = 1 pageblock
> then all the 4096 pages of same type. but if any one page is different than
> block type then ? it changed the block type or something else ?

That really depends on the specific migrate type. CMA, ISOLATE migrate
types are all or nothing IIRC. I would have to check the code to tell
exactly when MOVABLE/UNMOVABLE pageblocks transitions are done.
steal_suitable_fallback sounds like a good start to look at.
-- 
Michal Hocko
SUSE Labs
