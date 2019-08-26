Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6832BC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2DA2184D
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566821194;
	bh=ZXqKUrKoc3XvWsVOR9tThsSaHUCIG5VakBqZox5EhWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JRpYcVNme4w024eK2guIzags6nK4FJKHXggcBGxtejrXOTKmisSCfCxF1bM3GCsAn
	 tGpVTDj34iZGHkYvjbe0KpZ/duaoJiMuctICynYSj+1Er6W75l6NRsZQynP9DqRPap
	 FsoywMesSGNXgWQb4wNlIe3FJXph01sC/FfZhvz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbfHZMGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 08:06:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:43858 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726945AbfHZMGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 08:06:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ED07DAFCC;
        Mon, 26 Aug 2019 12:06:31 +0000 (UTC)
Date:   Mon, 26 Aug 2019 14:06:30 +0200
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
Message-ID: <20190826120630.GI7538@dhcp22.suse.cz>
References: <20190730123935.GB184615@google.com>
 <20190730125751.GS9330@dhcp22.suse.cz>
 <20190731054447.GB155569@google.com>
 <20190731072101.GX9330@dhcp22.suse.cz>
 <20190806105509.GA94582@google.com>
 <20190809124305.GQ18351@dhcp22.suse.cz>
 <20190809183424.GA22347@cmpxchg.org>
 <20190812080947.GA5117@dhcp22.suse.cz>
 <20190812150725.GA3684@cmpxchg.org>
 <20190813105143.GG17933@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813105143.GG17933@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 13-08-19 12:51:43, Michal Hocko wrote:
> On Mon 12-08-19 11:07:25, Johannes Weiner wrote:
> > On Mon, Aug 12, 2019 at 10:09:47AM +0200, Michal Hocko wrote:
[...]
> > > > Maybe the refaults will be fine - but latency expectations around
> > > > mapped page cache certainly are a lot higher than unmapped cache.
> > > >
> > > > So I'm a bit reluctant about this patch. If Minchan can be happy with
> > > > the lock batching, I'd prefer that.
> > > 
> > > Yes, it seems that the regular lock drop&relock helps in Minchan's case
> > > but this is a kind of change that might have other subtle side effects.
> > > E.g. will-it-scale has noticed a regression [1], likely because the
> > > critical section is shorter and the overal throughput of the operation
> > > decreases. Now, the w-i-s is an artificial benchmark so I wouldn't lose
> > > much sleep over it normally but we have already seen real regressions
> > > when the locking pattern has changed in the past so I would by a bit
> > > cautious.
> > 
> > I'm much more concerned about fundamentally changing the aging policy
> > of mapped page cache then about the lock breaking scheme. With locking
> > we worry about CPU effects; with aging we worry about additional IO.
> 
> But the later is observable and debuggable little bit easier IMHO.
> People are quite used to watch for major faults from my experience
> as that is an easy metric to compare.
>  
> > > As I've said, this RFC is mostly to open a discussion. I would really
> > > like to weigh the overhead of mark_page_accessed and potential scenario
> > > when refaults would be visible in practice. I can imagine that a short
> > > lived statically linked applications have higher chance of being the
> > > only user unlike libraries which are often being mapped via several
> > > ptes. But the main problem to evaluate this is that there are many other
> > > external factors to trigger the worst case.
> > 
> > We can discuss the pros and cons, but ultimately we simply need to
> > test it against real workloads to see if changing the promotion rules
> > regresses the amount of paging we do in practice.
> 
> Agreed. Do you see other option than to try it out and revert if we see
> regressions? We would get a workload description which would be helpful
> for future regression testing when touching this area. We can start
> slower and keep it in linux-next for a release cycle to catch any
> fallouts early.
> 
> Thoughts?

ping...

-- 
Michal Hocko
SUSE Labs
