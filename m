Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE1EC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F237721871
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555508339;
	bh=Qrbr9ajyoRynwBDr2KXufB8q8RMJWCOj2bSwTuNyw3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UFAbEppzS2rHikw7o/9Mco87jfOAHwnAn2K2fzgb0oB4m4olVQBWSSu+Iw+ztFVEr
	 wJMuaAb25QrJJhYXwJVgHwfpw6P/UAibPN/sLzXVX86uoWbh/fhtqlahOe/qHlPQOo
	 QqMKP71g30elZbiu8jmkTAOejkkNxkNbmndecACE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732281AbfDQNi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 09:38:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:35126 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729356AbfDQNi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 09:38:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7D129B174;
        Wed, 17 Apr 2019 13:38:54 +0000 (UTC)
Date:   Wed, 17 Apr 2019 15:38:52 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jesper Dangaard Brouer <netdev@brouer.com>
Cc:     Pekka Enberg <penberg@iki.fi>, "Tobin C. Harding" <me@tobin.cc>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Tejun Heo <tj@kernel.org>, Qian Cai <cai@lca.pw>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [PATCH 0/1] mm: Remove the SLAB allocator
Message-ID: <20190417133852.GL5878@dhcp22.suse.cz>
References: <20190410024714.26607-1-tobin@kernel.org>
 <f06aaeae-28c0-9ea4-d795-418ec3362d17@suse.cz>
 <20190410081618.GA25494@eros.localdomain>
 <20190411075556.GO10383@dhcp22.suse.cz>
 <262df687-c934-b3e2-1d5f-548e8a8acb74@iki.fi>
 <20190417105018.78604ad8@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417105018.78604ad8@carbon>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-04-19 10:50:18, Jesper Dangaard Brouer wrote:
> On Thu, 11 Apr 2019 11:27:26 +0300
> Pekka Enberg <penberg@iki.fi> wrote:
> 
> > Hi,
> > 
> > On 4/11/19 10:55 AM, Michal Hocko wrote:
> > > Please please have it more rigorous then what happened when SLUB was
> > > forced to become a default  
> > 
> > This is the hard part.
> > 
> > Even if you are able to show that SLUB is as fast as SLAB for all the 
> > benchmarks you run, there's bound to be that one workload where SLUB 
> > regresses. You will then have people complaining about that (rightly so) 
> > and you're again stuck with two allocators.
> > 
> > To move forward, I think we should look at possible *pathological* cases 
> > where we think SLAB might have an advantage. For example, SLUB had much 
> > more difficulties with remote CPU frees than SLAB. Now I don't know if 
> > this is the case, but it should be easy to construct a synthetic 
> > benchmark to measure this.
> 
> I do think SLUB have a number of pathological cases where SLAB is
> faster.  If was significantly more difficult to get good bulk-free
> performance for SLUB.  SLUB is only fast as long as objects belong to
> the same page.  To get good bulk-free performance if objects are
> "mixed", I coded this[1] way-too-complex fast-path code to counter
> act this (joined work with Alex Duyck).
> 
> [1] https://github.com/torvalds/linux/blob/v5.1-rc5/mm/slub.c#L3033-L3113

How often is this a real problem for real workloads?

> > For example, have a userspace process that does networking, which is 
> > often memory allocation intensive, so that we know that SKBs traverse 
> > between CPUs. You can do this by making sure that the NIC queues are 
> > mapped to CPU N (so that network softirqs have to run on that CPU) but 
> > the process is pinned to CPU M.
> 
> If someone want to test this with SKBs then be-aware that we netdev-guys
> have a number of optimizations where we try to counter act this. (As
> minimum disable TSO and GRO).
> 
> It might also be possible for people to get inspired by and adapt the
> micro benchmarking[2] kernel modules that I wrote when developing the
> SLUB and SLAB optimizations:
> 
> [2] https://github.com/netoptimizer/prototype-kernel/tree/master/kernel/mm

While microbenchmarks are good to see pathological behavior, I would be
really interested to see some numbers for real world usecases.
 
> > It's, of course, worth thinking about other pathological cases too. 
> > Workloads that cause large allocations is one. Workloads that cause lots 
> > of slab cache shrinking is another.
> 
> I also worry about long uptimes when SLUB objects/pages gets too
> fragmented... as I said SLUB is only efficient when objects are
> returned to the same page, while SLAB is not.

Is this something that has been actually measured in a real deployment?
-- 
Michal Hocko
SUSE Labs
