Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B008C742BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A6F20665
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfGLMuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:50:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:40692 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727027AbfGLMuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:50:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 80A04AC3F;
        Fri, 12 Jul 2019 12:50:50 +0000 (UTC)
Date:   Fri, 12 Jul 2019 13:50:47 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     huang ying <huang.ying.caritas@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, jhladky@redhat.com,
        lvenanci@redhat.com, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH -mm] autonuma: Fix scan period updating
Message-ID: <20190712125047.GL13484@suse.de>
References: <20190624025604.30896-1-ying.huang@intel.com>
 <20190624140950.GF2947@suse.de>
 <CAC=cRTNYUxGUcSUvXa-g9hia49TgrjkzE-b06JbBtwSn2zWYsw@mail.gmail.com>
 <20190703091747.GA13484@suse.de>
 <87ef3663nd.fsf@yhuang-dev.intel.com>
 <20190712082710.GH13484@suse.de>
 <87d0ifwmu2.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <87d0ifwmu2.fsf@yhuang-dev.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 06:48:05PM +0800, Huang, Ying wrote:
> > Ordinarily I would hope that the patch was motivated by observed
> > behaviour so you have a metric for goodness. However, for NUMA balancing
> > I would typically run basic workloads first -- dbench, tbench, netperf,
> > hackbench and pipetest. The objective would be to measure the degree
> > automatic NUMA balancing is interfering with a basic workload to see if
> > they patch reduces the number of minor faults incurred even though there
> > is no NUMA balancing to be worried about. This measures the general
> > overhead of a patch. If your reasoning is correct, you'd expect lower
> > overhead.
> >
> > For balancing itself, I usually look at Andrea's original autonuma
> > benchmark, NAS Parallel Benchmark (D class usually although C class for
> > much older or smaller machines) and spec JBB 2005 and 2015. Of the JBB
> > benchmarks, 2005 is usually more reasonable for evaluating NUMA balancing
> > than 2015 is (which can be unstable for a variety of reasons). In this
> > case, I would be looking at whether the overhead is reduced, whether the
> > ratio of local hits is the same or improved and the primary metric of
> > each (time to completion for Andrea's and NAS, throughput for JBB).
> >
> > Even if there is no change to locality and the primary metric but there
> > is less scanning and overhead overall, it would still be an improvement.
> 
> Thanks a lot for your detailed guidance.
> 

No problem.

> > If you have trouble doing such an evaluation, I'll queue tests if they
> > are based on a patch that addresses the specific point of concern (scan
> > period not updated) as it's still not obvious why flipping the logic of
> > whether shared or private is considered was necessary.
> 
> I can do the evaluation, but it will take quite some time for me to
> setup and run all these benchmarks.  So if these benchmarks have already
> been setup in your environment, so that your extra effort is minimal, it
> will be great if you can queue tests for the patch.  Feel free to reject
> me for any inconvenience.
> 

They're not setup as such, but my testing infrastructure is heavily
automated so it's easy to do and I think it's worth looking at. If you
update your patch to target just the scan period aspects, I'll queue it
up and get back to you. It usually takes a few days for the automation
to finish whatever it's doing and pick up a patch for evaluation.

-- 
Mel Gorman
SUSE Labs
