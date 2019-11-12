Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75D5C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 15:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C616B21872
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 15:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfKLPGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 10:06:41 -0500
Received: from outbound-smtp10.blacknight.com ([46.22.139.15]:34689 "EHLO
        outbound-smtp10.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726952AbfKLPGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 10:06:41 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp10.blacknight.com (Postfix) with ESMTPS id 38CAF1C2223
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 15:06:39 +0000 (GMT)
Received: (qmail 12763 invoked from network); 12 Nov 2019 15:06:39 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.23.195])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 12 Nov 2019 15:06:38 -0000
Date:   Tue, 12 Nov 2019 15:06:36 +0000
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
Message-ID: <20191112150636.GX3016@techsingularity.net>
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
 <1571405198-27570-5-git-send-email-vincent.guittot@linaro.org>
 <20191030154534.GJ3016@techsingularity.net>
 <CAKfTPtB_6kBq69E=-YFuon6fg21CxHneMpncpbLcPGk6uoVcMQ@mail.gmail.com>
 <20191031101544.GP3016@techsingularity.net>
 <CAKfTPtByO7oLQZxF_+-FxZ9u1JhO24-rujW3j-QDqr+PFDOQ=Q@mail.gmail.com>
 <20191031114020.GQ3016@techsingularity.net>
 <20191108163501.GA26528@linaro.org>
 <20191108183730.GU3016@techsingularity.net>
 <20191112105830.GA8765@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20191112105830.GA8765@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 11:58:30AM +0100, Vincent Guittot wrote:
> > This roughly matches what I've seen. The interesting part to me for
> > netperf is the next section of the report that reports the locality of
> > numa hints. With netperf on a 2-socket machine, it's generally around
> > 50% as the client/server are pulled apart. Because netperf is not
> > heavily memory bound, it doesn't have much impact on the overall
> > performance but it's good at catching the cross-node migrations.
> 
> Ok. I didn't want to make my reply too long. I have put them below for 
> the netperf-tcp results:
>                                         5.3-rc2        5.3-rc2
>                                             tip      +rwk+fix
> Ops NUMA alloc hit                  60077762.00    60387907.00
> Ops NUMA alloc miss                        0.00           0.00
> Ops NUMA interleave hit                    0.00           0.00
> Ops NUMA alloc local                60077571.00    60387798.00
> Ops NUMA base-page range updates        5948.00       17223.00
> Ops NUMA PTE updates                    5948.00       17223.00
> Ops NUMA PMD updates                       0.00           0.00
> Ops NUMA hint faults                    4639.00       14050.00
> Ops NUMA hint local faults %            2073.00        6515.00
> Ops NUMA hint local percent               44.69          46.37
> Ops NUMA pages migrated                 1528.00        4306.00
> Ops AutoNUMA cost                         23.27          70.45
> 

Thanks -- it was "NUMA hint local percent" I was interested in and the
46.37% local hinting faults is likely indicative of the client/server
being load balanced across SD_NUMA domains without NUMA Balancing being
aggressive enough to fix it. At least I know I am not just seriously
unlucky or testing magical machines!

-- 
Mel Gorman
SUSE Labs
