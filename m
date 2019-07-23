Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB49EC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 12:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD1B121903
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 12:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="y5jaj7Xk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732104AbfGWMAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 08:00:48 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43672 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728418AbfGWMAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 08:00:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gmiHbDmQgRJyupB0h+YiNeBmvO2d011WLm2rijkrC04=; b=y5jaj7Xkbg1GV+a264d+CpXrn
        YoHWakWbWqJzMFA2yIRldadcZuo62D6PkTpqg6RlBlDxfEiUKONAJMNeds3OOJNGn4+mroH75yrns
        1y/MZVh06gluem57bOjHVrDEbRyT+kVGxFrD8KkrNxOFFt35TcI2zka3nmqPeG/Kpf7XEbD9S+JDj
        uiM8trIe1dFn1OYu4NEpC9RCSvbcXf6Jj/0Tx2LuMNQ/pVUI+6JjxtVFcLQ8XBUVcaDsFISrj1stM
        /YPtOyTC2wCxDJXOrMMx9HPPsAGhYrKR0v1GjV3Hp6LrV7TVR70Qm6ItFvWojBPrIa0y2Wd00ZR1i
        v9Lhd7teg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hptT8-0007P5-Np; Tue, 23 Jul 2019 12:00:35 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E3B8D201A57EF; Tue, 23 Jul 2019 14:00:30 +0200 (CEST)
Date:   Tue, 23 Jul 2019 14:00:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Matt Fleming <matt@codeblueprint.co.uk>,
        linux-kernel@vger.kernel.org,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3] sched/topology: Improve load balancing on AMD EPYC
Message-ID: <20190723120030.GN3419@hirez.programming.kicks-ass.net>
References: <20190723104830.26623-1-matt@codeblueprint.co.uk>
 <20190723114248.GJ24383@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723114248.GJ24383@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 12:42:48PM +0100, Mel Gorman wrote:
> On Tue, Jul 23, 2019 at 11:48:30AM +0100, Matt Fleming wrote:
> > SD_BALANCE_{FORK,EXEC} and SD_WAKE_AFFINE are stripped in sd_init()
> > for any sched domains with a NUMA distance greater than 2 hops
> > (RECLAIM_DISTANCE). The idea being that it's expensive to balance
> > across domains that far apart.
> > 
> > However, as is rather unfortunately explained in
> > 
> >   commit 32e45ff43eaf ("mm: increase RECLAIM_DISTANCE to 30")
> > 
> > the value for RECLAIM_DISTANCE is based on node distance tables from
> > 2011-era hardware.
> > 
> > Current AMD EPYC machines have the following NUMA node distances:
> > 
> > node distances:
> > node   0   1   2   3   4   5   6   7
> >   0:  10  16  16  16  32  32  32  32
> >   1:  16  10  16  16  32  32  32  32
> >   2:  16  16  10  16  32  32  32  32
> >   3:  16  16  16  10  32  32  32  32
> >   4:  32  32  32  32  10  16  16  16
> >   5:  32  32  32  32  16  10  16  16
> >   6:  32  32  32  32  16  16  10  16
> >   7:  32  32  32  32  16  16  16  10
> > 
> > where 2 hops is 32.
> > 
> > The result is that the scheduler fails to load balance properly across
> > NUMA nodes on different sockets -- 2 hops apart.
> > 
> > For example, pinning 16 busy threads to NUMA nodes 0 (CPUs 0-7) and 4
> > (CPUs 32-39) like so,
> > 
> >   $ numactl -C 0-7,32-39 ./spinner 16
> > 
> > causes all threads to fork and remain on node 0 until the active
> > balancer kicks in after a few seconds and forcibly moves some threads
> > to node 4.
> > 
> > Override node_reclaim_distance for AMD Zen.
> > 
> > Signed-off-by: Matt Fleming <matt@codeblueprint.co.uk>
> > Cc: "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
> > Cc: Mel Gorman <mgorman@techsingularity.net>
> > Cc: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> 
> Acked-by: Mel Gorman <mgorman@techsingularity.net>
> 
> The only caveat I can think of is that a future generation of Zen might
> take a different magic number than 32 as their remote distance. If or
> when this happens, it'll need additional smarts but lacking a crystal
> ball, we can cross that bridge when we come to it.

I just suggested to Matt on IRC we could do something along these lines,
but we can do that later.

--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1611,6 +1611,12 @@ void sched_init_numa(void)
 	}
 
 	/*
+	 * Set the reclaim distance at 2 hops instead of at a fixed distance value.
+	 */
+	if (level >= 2)
+		node_reclaim_distance = sched_domains_numa_distance[2];
+
+	/*
 	 * 'level' contains the number of unique distances
 	 *
 	 * The sched_domains_numa_distance[] array includes the actual distance
