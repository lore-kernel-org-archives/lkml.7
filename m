Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A53C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24862070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfG2I4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 04:56:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:56542 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726830AbfG2I4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 04:56:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D8379B5EC;
        Mon, 29 Jul 2019 08:56:48 +0000 (UTC)
Date:   Mon, 29 Jul 2019 09:56:46 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Rik van Riel <riel@redhat.com>,
        jhladky@redhat.com, lvenanci@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RESEND] autonuma: Fix scan period updating
Message-ID: <20190729085646.GG2708@suse.de>
References: <20190725080124.494-1-ying.huang@intel.com>
 <20190725173516.GA16399@linux.vnet.ibm.com>
 <87y30l5jdo.fsf@yhuang-dev.intel.com>
 <20190726092021.GA5273@linux.vnet.ibm.com>
 <87ef295yn9.fsf@yhuang-dev.intel.com>
 <20190729072845.GC7168@linux.vnet.ibm.com>
 <87wog145nn.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <87wog145nn.fsf@yhuang-dev.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 04:16:28PM +0800, Huang, Ying wrote:
> Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
> 
> >> >> 
> >> >> if (lr_ratio >= NUMA_PERIOD_THRESHOLD)
> >> >>     slow down scanning
> >> >> else if (sp_ratio >= NUMA_PERIOD_THRESHOLD) {
> >> >>     if (NUMA_PERIOD_SLOTS - lr_ratio >= NUMA_PERIOD_THRESHOLD)
> >> >>         speed up scanning
> >> 
> >> Thought about this again.  For example, a multi-threads workload runs on
> >> a 4-sockets machine, and most memory accesses are shared.  The optimal
> >> situation will be pseudo-interleaving, that is, spreading memory
> >> accesses evenly among 4 NUMA nodes.  Where "share" >> "private", and
> >> "remote" > "local".  And we should slow down scanning to reduce the
> >> overhead.
> >> 
> >> What do you think about this?
> >
> > If all 4 nodes have equal access, then all 4 nodes will be active nodes.
> >
> > From task_numa_fault()
> >
> > 	if (!priv && !local && ng && ng->active_nodes > 1 &&
> > 				numa_is_active_node(cpu_node, ng) &&
> > 				numa_is_active_node(mem_node, ng))
> > 		local = 1;
> >
> > Hence all accesses will be accounted as local. Hence scanning would slow
> > down.
> 
> Yes.  You are right!  Thanks a lot!
> 
> There may be another case.  For example, a workload with 9 threads runs
> on a 2-sockets machine, and most memory accesses are shared.  7 threads
> runs on the node 0 and 2 threads runs on the node 1 based on CPU load
> balancing.  Then the 2 threads on the node 1 will have "share" >>
> "private" and "remote" >> "local".  But it doesn't help to speed up
> scanning.
> 

Ok, so the results from the patch are mostly neutral. There are some
small differences in scan rates depending on the workload but it's not
universal and the headline performance is sometimes worse. I couldn't
find something that would justify the change on its own. I think in the
short term -- just fix the comments.

For the shared access consideration, the scan rate is important but so too
is the decision on when pseudo interleaving should be used. Both should
probably be taken into account when making changes in this area. The
current code may not be optimal but it also has not generated bug reports,
high CPU usage or obviously bad locality decision in the field.  Hence,
for this patch or a similar series, it is critical that some workloads are
selected that really care about the locality of shared access and evaluate
based on that. Initially it was done with a large battery of tests run
by different people but some of those people have changed role since and
would not be in a position to rerun the tests. There also was the issue
that when those were done, NUMA balancing was new so it's comparative
baseline was "do nothing at all".

-- 
Mel Gorman
SUSE Labs
