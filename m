Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72501C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 14:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4578820656
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 14:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfDVOnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 10:43:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48764 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726132AbfDVOnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 10:43:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0FD6830917EF;
        Mon, 22 Apr 2019 14:43:44 +0000 (UTC)
Received: from carbon (ovpn-200-19.brq.redhat.com [10.40.200.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F12161D06;
        Mon, 22 Apr 2019 14:43:35 +0000 (UTC)
Date:   Mon, 22 Apr 2019 16:43:33 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>,
        Brendan Gregg <brendan.d.gregg@gmail.com>
Cc:     brouer@redhat.com, Pekka Enberg <penberg@iki.fi>,
        "Tobin C. Harding" <me@tobin.cc>, Vlastimil Babka <vbabka@suse.cz>,
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
Message-ID: <20190422164333.4e838ad6@carbon>
In-Reply-To: <20190417133852.GL5878@dhcp22.suse.cz>
References: <20190410024714.26607-1-tobin@kernel.org>
        <f06aaeae-28c0-9ea4-d795-418ec3362d17@suse.cz>
        <20190410081618.GA25494@eros.localdomain>
        <20190411075556.GO10383@dhcp22.suse.cz>
        <262df687-c934-b3e2-1d5f-548e8a8acb74@iki.fi>
        <20190417105018.78604ad8@carbon>
        <20190417133852.GL5878@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 22 Apr 2019 14:43:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2019 15:38:52 +0200
Michal Hocko <mhocko@kernel.org> wrote:

> On Wed 17-04-19 10:50:18, Jesper Dangaard Brouer wrote:
> > On Thu, 11 Apr 2019 11:27:26 +0300
> > Pekka Enberg <penberg@iki.fi> wrote:
> >   
> > > Hi,
> > > 
> > > On 4/11/19 10:55 AM, Michal Hocko wrote:  
> > > > Please please have it more rigorous then what happened when SLUB was
> > > > forced to become a default    
> > > 
> > > This is the hard part.
> > > 
> > > Even if you are able to show that SLUB is as fast as SLAB for all the 
> > > benchmarks you run, there's bound to be that one workload where SLUB 
> > > regresses. You will then have people complaining about that (rightly so) 
> > > and you're again stuck with two allocators.
> > > 
> > > To move forward, I think we should look at possible *pathological* cases 
> > > where we think SLAB might have an advantage. For example, SLUB had much 
> > > more difficulties with remote CPU frees than SLAB. Now I don't know if 
> > > this is the case, but it should be easy to construct a synthetic 
> > > benchmark to measure this.  
> > 
> > I do think SLUB have a number of pathological cases where SLAB is
> > faster.  If was significantly more difficult to get good bulk-free
> > performance for SLUB.  SLUB is only fast as long as objects belong to
> > the same page.  To get good bulk-free performance if objects are
> > "mixed", I coded this[1] way-too-complex fast-path code to counter
> > act this (joined work with Alex Duyck).
> > 
> > [1] https://github.com/torvalds/linux/blob/v5.1-rc5/mm/slub.c#L3033-L3113  
> 
> How often is this a real problem for real workloads?

First let me point out that I have a benchmark[2] that test this
worse-case behavior, and micro-benchmark wise it was a big win.  I did
limit the "lookahead" based on this benchmark balance/bound worse-case
behavior.

 [2] https://github.com/netoptimizer/prototype-kernel/blob/master/kernel/mm/slab_bulk_test03.c#L4-L8

Second, I do think this happens for real workloads. As production
systems will have many sockets where SKBs (SLAB objects) can be queued,
and an unpredictable traffic pattern, that could cause this "mixed"
SLAB-object from different pages. The skbuff_head_cache size is 256 and
is using a order-1 page (8192/256=) 32 objects per page.  Netstack bulk
free mostly happens from (DMA) TX completion which have ring-sizes
usually between 512 to 1024 packets, although we do limit bulk free to
64 objects.


> > > For example, have a userspace process that does networking, which is 
> > > often memory allocation intensive, so that we know that SKBs traverse 
> > > between CPUs. You can do this by making sure that the NIC queues are 
> > > mapped to CPU N (so that network softirqs have to run on that CPU) but 
> > > the process is pinned to CPU M.  
> > 
> > If someone want to test this with SKBs then be-aware that we netdev-guys
> > have a number of optimizations where we try to counter act this. (As
> > minimum disable TSO and GRO).
> > 
> > It might also be possible for people to get inspired by and adapt the
> > micro benchmarking[2] kernel modules that I wrote when developing the
> > SLUB and SLAB optimizations:
> > 
> > [2] https://github.com/netoptimizer/prototype-kernel/tree/master/kernel/mm  
> 
> While microbenchmarks are good to see pathological behavior, I would be
> really interested to see some numbers for real world usecases.

Yes, I would love to see that too, but there is a gap between kernel
developers with the knowledge to diagnose/make-sense of this, and
people running production systems...

(Cc Brendan Gregg)
Maybe we should create some tracepoints that makes it possible to
measure, e.g. how often SLUB fast-path vs slow-path is hit (or other
behavior _you_ want to know about), and then create some easy to use
trace-tools that sysadms can run.  I bet Brendan could write some
bpftrace[3] script that does this, if someone can describe what we want
to measure...

[3] https://github.com/iovisor/bpftrace

 
> > > It's, of course, worth thinking about other pathological cases too. 
> > > Workloads that cause large allocations is one. Workloads that cause lots 
> > > of slab cache shrinking is another.  
> > 
> > I also worry about long uptimes when SLUB objects/pages gets too
> > fragmented... as I said SLUB is only efficient when objects are
> > returned to the same page, while SLAB is not.  
> 
> Is this something that has been actually measured in a real deployment?

This is also something that would be interesting to have a tool for,
that can answer: how fragmented are the SLUB objects in my production
system(?)

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
