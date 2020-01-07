Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DF0C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 20:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E00D222D9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 20:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgAGUYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 15:24:11 -0500
Received: from outbound-smtp26.blacknight.com ([81.17.249.194]:45962 "EHLO
        outbound-smtp26.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728358AbgAGUYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 15:24:11 -0500
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp26.blacknight.com (Postfix) with ESMTPS id E6868B88B4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jan 2020 20:24:08 +0000 (GMT)
Received: (qmail 1110 invoked from network); 7 Jan 2020 20:24:08 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 7 Jan 2020 20:24:08 -0000
Date:   Tue, 7 Jan 2020 20:24:06 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched, fair: Allow a small degree of load imbalance
 between SD_NUMA domains v2
Message-ID: <20200107202406.GJ3466@techsingularity.net>
References: <20191220084252.GL3178@techsingularity.net>
 <CAKfTPtDp624geHEnPmHki70L=ZrBuz6zJG3zW0VFy+_S064Etw@mail.gmail.com>
 <20200103143051.GA3027@techsingularity.net>
 <CAKfTPtCGm7-mq3duxi=ugy+mn=Yutw6w9c35+cSHK8aZn7rzNQ@mail.gmail.com>
 <20200106145225.GB3466@techsingularity.net>
 <CAKfTPtBa74nd4VP3+7V51Jv=-UpqNyEocyTzMYwjopCgfWPSXg@mail.gmail.com>
 <20200107095655.GF3466@techsingularity.net>
 <CAKfTPtAtJSWGPC1t+0xj_Daid0fZaWnN+b53WQ_a1-Js5fJ6sg@mail.gmail.com>
 <20200107115646.GI3466@techsingularity.net>
 <CAKfTPtAacdmxniM9yZUrQPW39LAvhpBQt6ZiGiwk5qpEx7zicA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtAacdmxniM9yZUrQPW39LAvhpBQt6ZiGiwk5qpEx7zicA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 05:00:29PM +0100, Vincent Guittot wrote:
> > > Taking into account child domain makes sense to me, but shouldn't we
> > > take into account the number of child group instead ? This should
> > > reflect the number of different LLC caches.
> >
> > I guess it would but why is it inherently better? The number of domains
> > would yield a similar result if we assume that all the lower domains
> > have equal weight so it simply because the weight of the SD_NUMA domain
> > divided by the number of child domains.
> 
> but that's not what you are doing in your proposal. You are using
> directly child->span_weight which reflects the number of CPUs in the
> child and not the number of group
> 
> you should do something like  sds->busiest->span_weight /
> sds->busiest->child->span_weight which gives you an approximation of
> the number of independent group inside the busiest numa node from a
> shared resource pov
> 

Now I get you, but unfortunately it also would not work out. The number
of groups is not related to the LLC except in some specific cases.
It's possible to use the first CPU to find the size of an LLC but now I
worry that it would lead to unpredictable behaviour. AMD has different
numbers of LLCs per node depending on the CPU family and while Intel
generally has one LLC per node, I imagine there are counter examples.
This means that load balancing on different machines with similar core
counts will behave differently due to the LLC size. It might be possible
to infer it if the intermediate domain was DIE instead of MC but I doubt
that's guaranteed and it would still be unpredictable. It may be the type
of complexity that should only be introduced with a separate patch with
clear rationale as to why it's necessary and we are not at that threshold
so I withdraw the suggestion.

-- 
Mel Gorman
SUSE Labs
