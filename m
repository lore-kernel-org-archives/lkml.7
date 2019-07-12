Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D1FC742A8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 08:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC8AA21019
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 08:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfGLI1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 04:27:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:44392 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726057AbfGLI1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 04:27:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DAC5BAC4C;
        Fri, 12 Jul 2019 08:27:12 +0000 (UTC)
Date:   Fri, 12 Jul 2019 09:27:10 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     huang ying <huang.ying.caritas@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, jhladky@redhat.com,
        lvenanci@redhat.com, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH -mm] autonuma: Fix scan period updating
Message-ID: <20190712082710.GH13484@suse.de>
References: <20190624025604.30896-1-ying.huang@intel.com>
 <20190624140950.GF2947@suse.de>
 <CAC=cRTNYUxGUcSUvXa-g9hia49TgrjkzE-b06JbBtwSn2zWYsw@mail.gmail.com>
 <20190703091747.GA13484@suse.de>
 <87ef3663nd.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <87ef3663nd.fsf@yhuang-dev.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 08:32:06AM +0800, Huang, Ying wrote:
> Mel Gorman <mgorman@suse.de> writes:
> 
> > On Tue, Jun 25, 2019 at 09:23:22PM +0800, huang ying wrote:
> >> On Mon, Jun 24, 2019 at 10:25 PM Mel Gorman <mgorman@suse.de> wrote:
> >> >
> >> > On Mon, Jun 24, 2019 at 10:56:04AM +0800, Huang Ying wrote:
> >> > > The autonuma scan period should be increased (scanning is slowed down)
> >> > > if the majority of the page accesses are shared with other processes.
> >> > > But in current code, the scan period will be decreased (scanning is
> >> > > speeded up) in that situation.
> >> > >
> >> > > This patch fixes the code.  And this has been tested via tracing the
> >> > > scan period changing and /proc/vmstat numa_pte_updates counter when
> >> > > running a multi-threaded memory accessing program (most memory
> >> > > areas are accessed by multiple threads).
> >> > >
> >> >
> >> > The patch somewhat flips the logic on whether shared or private is
> >> > considered and it's not immediately obvious why that was required. That
> >> > aside, other than the impact on numa_pte_updates, what actual
> >> > performance difference was measured and on on what workloads?
> >> 
> >> The original scanning period updating logic doesn't match the original
> >> patch description and comments.  I think the original patch
> >> description and comments make more sense.  So I fix the code logic to
> >> make it match the original patch description and comments.
> >> 
> >> If my understanding to the original code logic and the original patch
> >> description and comments were correct, do you think the original patch
> >> description and comments are wrong so we need to fix the comments
> >> instead?  Or you think we should prove whether the original patch
> >> description and comments are correct?
> >> 
> >
> > I'm about to get knocked offline so cannot answer properly. The code may
> > indeed be wrong and I have observed higher than expected NUMA scanning
> > behaviour than expected although not enough to cause problems. A comment
> > fix is fine but if you're changing the scanning behaviour, it should be
> > backed up with data justifying that the change both reduces the observed
> > scanning and that it has no adverse performance implications.
> 
> Got it!  Thanks for comments!  As for performance testing, do you have
> some candidate workloads?
> 

Ordinarily I would hope that the patch was motivated by observed
behaviour so you have a metric for goodness. However, for NUMA balancing
I would typically run basic workloads first -- dbench, tbench, netperf,
hackbench and pipetest. The objective would be to measure the degree
automatic NUMA balancing is interfering with a basic workload to see if
they patch reduces the number of minor faults incurred even though there
is no NUMA balancing to be worried about. This measures the general
overhead of a patch. If your reasoning is correct, you'd expect lower
overhead.

For balancing itself, I usually look at Andrea's original autonuma
benchmark, NAS Parallel Benchmark (D class usually although C class for
much older or smaller machines) and spec JBB 2005 and 2015. Of the JBB
benchmarks, 2005 is usually more reasonable for evaluating NUMA balancing
than 2015 is (which can be unstable for a variety of reasons). In this
case, I would be looking at whether the overhead is reduced, whether the
ratio of local hits is the same or improved and the primary metric of
each (time to completion for Andrea's and NAS, throughput for JBB).

Even if there is no change to locality and the primary metric but there
is less scanning and overhead overall, it would still be an improvement.

If you have trouble doing such an evaluation, I'll queue tests if they
are based on a patch that addresses the specific point of concern (scan
period not updated) as it's still not obvious why flipping the logic of
whether shared or private is considered was necessary.

-- 
Mel Gorman
SUSE Labs
