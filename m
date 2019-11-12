Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE86C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13363206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfKLRpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 12:45:14 -0500
Received: from outbound-smtp15.blacknight.com ([46.22.139.232]:35392 "EHLO
        outbound-smtp15.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726718AbfKLRpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 12:45:14 -0500
Received: from mail.blacknight.com (unknown [81.17.255.152])
        by outbound-smtp15.blacknight.com (Postfix) with ESMTPS id 519D11C23AC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 17:45:11 +0000 (GMT)
Received: (qmail 15920 invoked from network); 12 Nov 2019 17:45:11 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.23.195])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 12 Nov 2019 17:45:11 -0000
Date:   Tue, 12 Nov 2019 17:45:08 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v4 04/11] sched/fair: rework load_balance
Message-ID: <20191112174508.GY3016@techsingularity.net>
References: <20191030154534.GJ3016@techsingularity.net>
 <CAKfTPtB_6kBq69E=-YFuon6fg21CxHneMpncpbLcPGk6uoVcMQ@mail.gmail.com>
 <20191031101544.GP3016@techsingularity.net>
 <CAKfTPtByO7oLQZxF_+-FxZ9u1JhO24-rujW3j-QDqr+PFDOQ=Q@mail.gmail.com>
 <20191031114020.GQ3016@techsingularity.net>
 <20191108163501.GA26528@linaro.org>
 <20191108183730.GU3016@techsingularity.net>
 <20191112105830.GA8765@linaro.org>
 <20191112150636.GX3016@techsingularity.net>
 <CAKfTPtCVdG1zcd4kyU4d+K_+VdW7TZn+RSDKt4Hk28B366NPOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtCVdG1zcd4kyU4d+K_+VdW7TZn+RSDKt4Hk28B366NPOQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 04:40:20PM +0100, Vincent Guittot wrote:
> On Tue, 12 Nov 2019 at 16:06, Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > On Tue, Nov 12, 2019 at 11:58:30AM +0100, Vincent Guittot wrote:
> > > > This roughly matches what I've seen. The interesting part to me for
> > > > netperf is the next section of the report that reports the locality of
> > > > numa hints. With netperf on a 2-socket machine, it's generally around
> > > > 50% as the client/server are pulled apart. Because netperf is not
> > > > heavily memory bound, it doesn't have much impact on the overall
> > > > performance but it's good at catching the cross-node migrations.
> > >
> > > Ok. I didn't want to make my reply too long. I have put them below for
> > > the netperf-tcp results:
> > >                                         5.3-rc2        5.3-rc2
> > >                                             tip      +rwk+fix
> > > Ops NUMA alloc hit                  60077762.00    60387907.00
> > > Ops NUMA alloc miss                        0.00           0.00
> > > Ops NUMA interleave hit                    0.00           0.00
> > > Ops NUMA alloc local                60077571.00    60387798.00
> > > Ops NUMA base-page range updates        5948.00       17223.00
> > > Ops NUMA PTE updates                    5948.00       17223.00
> > > Ops NUMA PMD updates                       0.00           0.00
> > > Ops NUMA hint faults                    4639.00       14050.00
> > > Ops NUMA hint local faults %            2073.00        6515.00
> > > Ops NUMA hint local percent               44.69          46.37
> > > Ops NUMA pages migrated                 1528.00        4306.00
> > > Ops AutoNUMA cost                         23.27          70.45
> > >
> >
> > Thanks -- it was "NUMA hint local percent" I was interested in and the
> > 46.37% local hinting faults is likely indicative of the client/server
> > being load balanced across SD_NUMA domains without NUMA Balancing being
> > aggressive enough to fix it. At least I know I am not just seriously
> > unlucky or testing magical machines!
> 
> I agree that the collaboration between load balanced across SD_NUMA
> level and NUMA balancing should be improved
> 
> It's also interesting to notice that the patchset doesn't seem to do
> worse than the baseline: 46.37% vs 44.69%
> 

Yes, I should have highlighted that. The series appears to improve a
number of areas while being performance neutral with respect to SD_NUMA.
If this turns out to be wrong in some case, it should be semi-obvious even
if the locality looks ok. It'll be a headline regression with increased
NUMA pte scanning and increased frequency of migrations indicating that
NUMA balancing is taken excessive corrective action. I'll know it when
I see it :P

-- 
Mel Gorman
SUSE Labs
