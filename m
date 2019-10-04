Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FA6C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A78C222CB
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570191508;
	bh=OpLJ+K6cdgUUKujMupmx1WO6n2LtvTIGdPBYR/GYASg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FW/JpRJV63HhiTRzpXckxY3MgyeLaOI1ihdSrUvEcCLgSdrSoLZICtqsFywU9yGCV
	 3UpG/I8Jx5w0di16oAYAfb5sAxP4Lk6/bExbirLfL/SQ/q6SWl9HvrXCcBxq28OcQn
	 Izag2bLIeeUmynKt1ip5+QfcnriENRVNtcLnecao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730477AbfJDMS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 08:18:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:44864 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725826AbfJDMS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 08:18:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2A22EAD7B;
        Fri,  4 Oct 2019 12:18:25 +0000 (UTC)
Date:   Fri, 4 Oct 2019 14:18:24 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Rientjes <rientjes@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [patch for-5.3 0/4] revert immediate fallback to remote hugepages
Message-ID: <20191004121824.GH9578@dhcp22.suse.cz>
References: <20190927074803.GB26848@dhcp22.suse.cz>
 <CAHk-=wgba5zOJtGBFCBP3Oc1m4ma+AR+80s=hy=BbvNr3GqEmA@mail.gmail.com>
 <20190930112817.GC15942@dhcp22.suse.cz>
 <20191001054343.GA15624@dhcp22.suse.cz>
 <fac13297-424f-33b0-e01d-d72b949a73fe@suse.cz>
 <alpine.DEB.2.21.1910011318050.38265@chino.kir.corp.google.com>
 <a5abc877-26de-ed3c-eb33-71474301c852@suse.cz>
 <20191002103422.GJ15624@dhcp22.suse.cz>
 <alpine.DEB.2.21.1910021525180.63052@chino.kir.corp.google.com>
 <788d3e5b-40e6-916a-9e3f-7f03fa9d618d@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <788d3e5b-40e6-916a-9e3f-7f03fa9d618d@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03-10-19 10:00:08, Vlastimil Babka wrote:
> On 10/3/19 12:32 AM, David Rientjes wrote:
> > On Wed, 2 Oct 2019, Michal Hocko wrote:
> > 
> >>>> If 
> >>>> hugetlb wants to stress this to the fullest extent possible, it already 
> >>>> appropriately uses __GFP_RETRY_MAYFAIL.
> >>>
> >>> Which doesn't work anymore right now, and should again after this patch.
> >>
> >> I didn't get to fully digest the patch Vlastimil is proposing. (Ab)using
> >> __GFP_NORETRY is quite subtle but it is already in place with some
> >> explanation and a reference to THPs. So while I am not really happy it
> >> is at least something you can reason about.
> >>
> > 
> > It's a no-op:
> > 
> >         /* Do not loop if specifically requested */
> >         if (gfp_mask & __GFP_NORETRY)
> >                 goto nopage;
> > 
> >         /*
> >          * Do not retry costly high order allocations unless they are
> >          * __GFP_RETRY_MAYFAIL
> >          */
> >         if (costly_order && !(gfp_mask & __GFP_RETRY_MAYFAIL))
> >                 goto nopage;
> > 
> > So I'm not sure we should spend too much time discussing a hunk of a patch 
> > that doesn't do anything.
> 
> I believe Michal was talking about my (ab)use of __GFP_NORETRY, where it
> controls the earlier 'goto nopage' condition.

That is correct. From a maintainability point of view it would be better
to have only a single bailout of an optimistic compaction attempt. If we
go with [1] then we have two different criterion to bail out and
that is really messy and error prone. While sticking __GFP_RETRY_MAYFAIL
as suggest in [1] fixes up the immediate regression in the simplest way
this all really begs for a proper analysis and a _real_ fix. Can we move
that direction finally, please?

I would really love to conduct further testing but I haven't really
heard anything to results presented so far. I have no idea whether
that is even remotely resembling anything David needs for his claimed
regression.

[1] http://lkml.kernel.org/r/alpine.DEB.2.21.1910021556270.187014@chino.kir.corp.google.com

-- 
Michal Hocko
SUSE Labs
