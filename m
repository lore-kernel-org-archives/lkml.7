Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39B7C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 10:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78FDC20874
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 10:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565693508;
	bh=xG3aF0XmOiu5BGc++wjXnmrV4Zc8GkPnXTQx4cJH/8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VgvQNjO2TSbrd+81uyvRhIB4yU/IiemjZU78b3qxc2T7mSasPYAK5iLM+Bycda9Oa
	 aEnJW/PtwmTgu8fc8IcZYV0efO9CNEptritIIOd5JGe4ya7cdhYsW3CmdMqezDyAvX
	 mTu4EP5gBFOri2IQMnK4O6qq80XbGRs8/nELKA7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbfHMKvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 06:51:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:59842 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726298AbfHMKvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 06:51:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A7B68AD7F;
        Tue, 13 Aug 2019 10:51:44 +0000 (UTC)
Date:   Tue, 13 Aug 2019 12:51:43 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Miguel de Dios <migueldedios@google.com>,
        Wei Wang <wvw@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH] mm: drop mark_page_access from the unmap path
Message-ID: <20190813105143.GG17933@dhcp22.suse.cz>
References: <20190730123237.GR9330@dhcp22.suse.cz>
 <20190730123935.GB184615@google.com>
 <20190730125751.GS9330@dhcp22.suse.cz>
 <20190731054447.GB155569@google.com>
 <20190731072101.GX9330@dhcp22.suse.cz>
 <20190806105509.GA94582@google.com>
 <20190809124305.GQ18351@dhcp22.suse.cz>
 <20190809183424.GA22347@cmpxchg.org>
 <20190812080947.GA5117@dhcp22.suse.cz>
 <20190812150725.GA3684@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812150725.GA3684@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 12-08-19 11:07:25, Johannes Weiner wrote:
> On Mon, Aug 12, 2019 at 10:09:47AM +0200, Michal Hocko wrote:
[...]
> > Btw. can we promote PageReferenced pages with zero mapcount? I am
> > throwing that more as an idea because I haven't really thought that
> > through yet.
> 
> That flag implements a second-chance policy, see this commit:
> 
> commit 645747462435d84c6c6a64269ed49cc3015f753d
> Author: Johannes Weiner <hannes@cmpxchg.org>
> Date:   Fri Mar 5 13:42:22 2010 -0800
> 
>     vmscan: detect mapped file pages used only once
> 
> We had an application that would checksum large files using mmapped IO
> to avoid double buffering. The VM used to activate mapped cache
> directly, and it trashed the actual workingset.
> 
> In response I added support for use-once mapped pages using this flag.
> SetPageReferenced signals the VM that we're not sure about the page
> yet and give it another round trip on the LRU.
> 
> If you activate on this flag, it would restore the initial problem of
> use-once pages trashing the workingset.

You are right of course. I should have realized that! We really need
another piece of information to store to the struct page or maybe xarray
to reflect that.
 
> > > Maybe the refaults will be fine - but latency expectations around
> > > mapped page cache certainly are a lot higher than unmapped cache.
> > >
> > > So I'm a bit reluctant about this patch. If Minchan can be happy with
> > > the lock batching, I'd prefer that.
> > 
> > Yes, it seems that the regular lock drop&relock helps in Minchan's case
> > but this is a kind of change that might have other subtle side effects.
> > E.g. will-it-scale has noticed a regression [1], likely because the
> > critical section is shorter and the overal throughput of the operation
> > decreases. Now, the w-i-s is an artificial benchmark so I wouldn't lose
> > much sleep over it normally but we have already seen real regressions
> > when the locking pattern has changed in the past so I would by a bit
> > cautious.
> 
> I'm much more concerned about fundamentally changing the aging policy
> of mapped page cache then about the lock breaking scheme. With locking
> we worry about CPU effects; with aging we worry about additional IO.

But the later is observable and debuggable little bit easier IMHO.
People are quite used to watch for major faults from my experience
as that is an easy metric to compare.
 
> > As I've said, this RFC is mostly to open a discussion. I would really
> > like to weigh the overhead of mark_page_accessed and potential scenario
> > when refaults would be visible in practice. I can imagine that a short
> > lived statically linked applications have higher chance of being the
> > only user unlike libraries which are often being mapped via several
> > ptes. But the main problem to evaluate this is that there are many other
> > external factors to trigger the worst case.
> 
> We can discuss the pros and cons, but ultimately we simply need to
> test it against real workloads to see if changing the promotion rules
> regresses the amount of paging we do in practice.

Agreed. Do you see other option than to try it out and revert if we see
regressions? We would get a workload description which would be helpful
for future regression testing when touching this area. We can start
slower and keep it in linux-next for a release cycle to catch any
fallouts early.

Thoughts?

-- 
Michal Hocko
SUSE Labs
