Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9693ACA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E6D2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfJaLk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 07:40:26 -0400
Received: from outbound-smtp12.blacknight.com ([46.22.139.17]:44012 "EHLO
        outbound-smtp12.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726513AbfJaLkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:40:25 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp12.blacknight.com (Postfix) with ESMTPS id 341891C25E7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 11:40:23 +0000 (GMT)
Received: (qmail 27763 invoked from network); 31 Oct 2019 11:40:23 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.19.210])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 31 Oct 2019 11:40:23 -0000
Date:   Thu, 31 Oct 2019 11:40:20 +0000
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
Message-ID: <20191031114020.GQ3016@techsingularity.net>
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
 <1571405198-27570-5-git-send-email-vincent.guittot@linaro.org>
 <20191030154534.GJ3016@techsingularity.net>
 <CAKfTPtB_6kBq69E=-YFuon6fg21CxHneMpncpbLcPGk6uoVcMQ@mail.gmail.com>
 <20191031101544.GP3016@techsingularity.net>
 <CAKfTPtByO7oLQZxF_+-FxZ9u1JhO24-rujW3j-QDqr+PFDOQ=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtByO7oLQZxF_+-FxZ9u1JhO24-rujW3j-QDqr+PFDOQ=Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 12:13:09PM +0100, Vincent Guittot wrote:
> > > > On the last one, spreading tasks evenly across NUMA domains is not
> > > > necessarily a good idea. If I have 2 tasks running on a 2-socket machine
> > > > with 24 logical CPUs per socket, it should not automatically mean that
> > > > one task should move cross-node and I have definitely observed this
> > > > happening. It's probably bad in terms of locality no matter what but it's
> > > > especially bad if the 2 tasks happened to be communicating because then
> > > > load balancing will pull apart the tasks while wake_affine will push
> > > > them together (and potentially NUMA balancing as well). Note that this
> > > > also applies for some IO workloads because, depending on the filesystem,
> > > > the task may be communicating with workqueues (XFS) or a kernel thread
> > > > (ext4 with jbd2).
> > >
> > > This rework doesn't touch the NUMA_BALANCING part and NUMA balancing
> > > still gives guidances with fbq_classify_group/queue.
> >
> > I know the NUMA_BALANCING part is not touched, I'm talking about load
> > balancing across SD_NUMA domains which happens independently of
> > NUMA_BALANCING. In fact, there is logic in NUMA_BALANCING that tries to
> > override the load balancer when it moves tasks away from the preferred
> > node.
> 
> Yes. this patchset relies on this override for now to prevent moving task away.

Fair enough, netperf hits the corner case where it does not work but
that is also true without your series.

> I agree that additional patches are probably needed to improve load
> balance at NUMA level and I expect that this rework will make it
> simpler to add.
> I just wanted to get the output of some real use cases before defining
> more numa level specific conditions. Some want to spread on there numa
> nodes but other want to keep everything together. The preferred node
> and fbq_classify_group was the only sensible metrics to me when he
> wrote this patchset but changes can be added if they make sense.
> 

That's fair. While it was possible to address the case before your
series, it was a hatchet job. If the changelog simply notes that some
special casing may still be required for SD_NUMA but it's outside the
scope of the series, then I'd be happy. At least there is a good chance
then if there is follow-up work that it won't be interpreted as an
attempt to reintroduce hacky heuristics.

> >
> > > But the latter could also take advantage of the new type of group. For
> > > example, what I did in the fix for find_idlest_group : checking
> > > numa_preferred_nid when the group has capacity and keep the task on
> > > preferred node if possible. Similar behavior could also be beneficial
> > > in periodic load_balance case.
> > >
> >
> > And this is the catch -- numa_preferred_nid is not guaranteed to be set at
> > all. NUMA balancing might be disabled, the task may not have been running
> > long enough to pick a preferred NID or NUMA balancing might be unable to
> > pick a preferred NID. The decision to avoid unnecessary migrations across
> > NUMA domains should be made independently of NUMA balancing. The netperf
> > configuration from mmtests is great at illustrating the point because it'll
> > also say what the average local/remote access ratio is. 2 communicating
> > tasks running on an otherwise idle NUMA machine should not have the load
> > balancer move the server to one node and the client to another.
> 
> I'm going to make it a try on my setup to see the results
> 

Thanks.

-- 
Mel Gorman
SUSE Labs
