Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F62ECA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 12:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F90E21906
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 12:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h7xUFvV4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501928AbfJXMi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 08:38:57 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51142 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726620AbfJXMi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 08:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571920734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DauehknaynzkWxZALVHSqnUZ3BHzjJA1Tu7ZvxT94OQ=;
        b=h7xUFvV4ti4YRN+SFjFL7Mkywob68s5/IO038gaEG61avSoo11hx2IHWfqCG67C/rDkD7h
        Sk8GnQu2F/PM5JpdzR5uSbHk5dqyy5OfniiT0LYWPQdj8u/WfOxdlUvSrGNEElwiFbKnHk
        +e7L9A/OWAT+TK2ZgvmCPanC/FehFM0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-PfYhWTnIPKqTRSfaFrpA_w-1; Thu, 24 Oct 2019 08:38:50 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 550A0800D49;
        Thu, 24 Oct 2019 12:38:48 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 85E0B1001B20;
        Thu, 24 Oct 2019 12:38:46 +0000 (UTC)
Date:   Thu, 24 Oct 2019 08:38:44 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v4 00/10] sched/fair: rework the CFS load balance
Message-ID: <20191024123844.GB2708@pauld.bos.csb>
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
 <20191021075038.GA27361@gmail.com>
 <CAKfTPtCcvKuf1Gt0W-BeEbQxFP_co14jdv_L5zEpS==Ecibabg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKfTPtCcvKuf1Gt0W-BeEbQxFP_co14jdv_L5zEpS==Ecibabg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: PfYhWTnIPKqTRSfaFrpA_w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On Mon, Oct 21, 2019 at 10:44:20AM +0200 Vincent Guittot wrote:
> On Mon, 21 Oct 2019 at 09:50, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Vincent Guittot <vincent.guittot@linaro.org> wrote:
> >
> > > Several wrong task placement have been raised with the current load
> > > balance algorithm but their fixes are not always straight forward and
> > > end up with using biased values to force migrations. A cleanup and re=
work
> > > of the load balance will help to handle such UCs and enable to fine g=
rain
> > > the behavior of the scheduler for other cases.
> > >
> > > Patch 1 has already been sent separately and only consolidate asym po=
licy
> > > in one place and help the review of the changes in load_balance.
> > >
> > > Patch 2 renames the sum of h_nr_running in stats.
> > >
> > > Patch 3 removes meaningless imbalance computation to make review of
> > > patch 4 easier.
> > >
> > > Patch 4 reworks load_balance algorithm and fixes some wrong task plac=
ement
> > > but try to stay conservative.
> > >
> > > Patch 5 add the sum of nr_running to monitor non cfs tasks and take t=
hat
> > > into account when pulling tasks.
> > >
> > > Patch 6 replaces runnable_load by load now that the signal is only us=
ed
> > > when overloaded.
> > >
> > > Patch 7 improves the spread of tasks at the 1st scheduling level.
> > >
> > > Patch 8 uses utilization instead of load in all steps of misfit task
> > > path.
> > >
> > > Patch 9 replaces runnable_load_avg by load_avg in the wake up path.
> > >
> > > Patch 10 optimizes find_idlest_group() that was using both runnable_l=
oad
> > > and load. This has not been squashed with previous patch to ease the
> > > review.
> > >
> > > Patch 11 reworks find_idlest_group() to follow the same steps as
> > > find_busiest_group()
> > >
> > > Some benchmarks results based on 8 iterations of each tests:
> > > - small arm64 dual quad cores system
> > >
> > >            tip/sched/core        w/ this patchset    improvement
> > > schedpipe      53125 +/-0.18%        53443 +/-0.52%   (+0.60%)
> > >
> > > hackbench -l (2560/#grp) -g #grp
> > >  1 groups      1.579 +/-29.16%       1.410 +/-13.46% (+10.70%)
> > >  4 groups      1.269 +/-9.69%        1.205 +/-3.27%   (+5.00%)
> > >  8 groups      1.117 +/-1.51%        1.123 +/-1.27%   (+4.57%)
> > > 16 groups      1.176 +/-1.76%        1.164 +/-2.42%   (+1.07%)
> > >
> > > Unixbench shell8
> > >   1 test     1963.48 +/-0.36%       1902.88 +/-0.73%    (-3.09%)
> > > 224 tests    2427.60 +/-0.20%       2469.80 +/-0.42%  (1.74%)
> > >
> > > - large arm64 2 nodes / 224 cores system
> > >
> > >            tip/sched/core        w/ this patchset    improvement
> > > schedpipe     124084 +/-1.36%       124445 +/-0.67%   (+0.29%)
> > >
> > > hackbench -l (256000/#grp) -g #grp
> > >   1 groups    15.305 +/-1.50%       14.001 +/-1.99%   (+8.52%)
> > >   4 groups     5.959 +/-0.70%        5.542 +/-3.76%   (+6.99%)
> > >  16 groups     3.120 +/-1.72%        3.253 +/-0.61%   (-4.92%)
> > >  32 groups     2.911 +/-0.88%        2.837 +/-1.16%   (+2.54%)
> > >  64 groups     2.805 +/-1.90%        2.716 +/-1.18%   (+3.17%)
> > > 128 groups     3.166 +/-7.71%        3.891 +/-6.77%   (+5.82%)
> > > 256 groups     3.655 +/-10.09%       3.185 +/-6.65%  (+12.87%)
> > >
> > > dbench
> > >   1 groups   328.176 +/-0.29%      330.217 +/-0.32%   (+0.62%)
> > >   4 groups   930.739 +/-0.50%      957.173 +/-0.66%   (+2.84%)
> > >  16 groups  1928.292 +/-0.36%     1978.234 +/-0.88%   (+0.92%)
> > >  32 groups  2369.348 +/-1.72%     2454.020 +/-0.90%   (+3.57%)
> > >  64 groups  2583.880 +/-3.39%     2618.860 +/-0.84%   (+1.35%)
> > > 128 groups  2256.406 +/-10.67%    2392.498 +/-2.13%   (+6.03%)
> > > 256 groups  1257.546 +/-3.81%     1674.684 +/-4.97%  (+33.17%)
> > >
> > > Unixbench shell8
> > >   1 test     6944.16 +/-0.02     6605.82 +/-0.11      (-4.87%)
> > > 224 tests   13499.02 +/-0.14    13637.94 +/-0.47%     (+1.03%)
> > > lkp reported a -10% regression on shell8 (1 test) for v3 that
> > > seems that is partially recovered on my platform with v4.
> > >
> > > tip/sched/core sha1:
> > >   commit 563c4f85f9f0 ("Merge branch 'sched/rt' into sched/core, to p=
ick up -rt changes")
> > >
> > > Changes since v3:
> > > - small typo and variable ordering fixes
> > > - add some acked/reviewed tag
> > > - set 1 instead of load for migrate_misfit
> > > - use nr_h_running instead of load for asym_packing
> > > - update the optimization of find_idlest_group() and put back somes
> > >  conditions when comparing load
> > > - rework find_idlest_group() to match find_busiest_group() behavior
> > >
> > > Changes since v2:
> > > - fix typo and reorder code
> > > - some minor code fixes
> > > - optimize the find_idles_group()
> > >
> > > Not covered in this patchset:
> > > - Better detection of overloaded and fully busy state, especially for=
 cases
> > >   when nr_running > nr CPUs.
> > >
> > > Vincent Guittot (11):
> > >   sched/fair: clean up asym packing
> > >   sched/fair: rename sum_nr_running to sum_h_nr_running
> > >   sched/fair: remove meaningless imbalance calculation
> > >   sched/fair: rework load_balance
> > >   sched/fair: use rq->nr_running when balancing load
> > >   sched/fair: use load instead of runnable load in load_balance
> > >   sched/fair: evenly spread tasks when not overloaded
> > >   sched/fair: use utilization to select misfit task
> > >   sched/fair: use load instead of runnable load in wakeup path
> > >   sched/fair: optimize find_idlest_group
> > >   sched/fair: rework find_idlest_group
> > >
> > >  kernel/sched/fair.c | 1181 +++++++++++++++++++++++++++++------------=
----------
> > >  1 file changed, 682 insertions(+), 499 deletions(-)
> >
> > Thanks, that's an excellent series!
> >
> > I've queued it up in sched/core with a handful of readability edits to
> > comments and changelogs.
>=20
> Thanks
>=20
> >
> > There are some upstreaming caveats though, I expect this series to be a
> > performance regression magnet:
> >
> >  - load_balance() and wake-up changes invariably are such: some workloa=
ds
> >    only work/scale well by accident, and if we touch the logic it might
> >    flip over into a less advantageous scheduling pattern.
> >
> >  - In particular the changes from balancing and waking on runnable load
> >    to full load that includes blocking *will* shift IO-intensive
> >    workloads that you tests don't fully capture I believe. You also mad=
e
> >    idle balancing more aggressive in essence - which might reduce cache
> >    locality for some workloads.
> >
> > A full run on Mel Gorman's magic scalability test-suite would be super
> > useful ...
> >
> > Anyway, please be on the lookout for such performance regression report=
s.
>=20
> Yes I monitor the regressions on the mailing list


Our kernel perf tests show good results across the board for v4.=20

The issue we hit on the 8-node system is fixed. Thanks!

As we didn't see the fairness issue I don't expect the results to be
that different on v4a (with the followup patch) but those tests are
queued up now and we'll see what they look like.=20

Numbers for my specific testcase (the cgroup imbalance) are basically=20
the same as I posted for v3 (plus the better 8-node numbers). I.e. this
series solves that issue.=20


Cheers,
Phil


>=20
> >
> > Also, we seem to have grown a fair amount of these TODO entries:
> >
> >   kernel/sched/fair.c: * XXX borrowed from update_sg_lb_stats
> >   kernel/sched/fair.c: * XXX: only do this for the part of runnable > r=
unning ?
> >   kernel/sched/fair.c:     * XXX illustrate
> >   kernel/sched/fair.c:    } else if (sd_flag & SD_BALANCE_WAKE) { /* XX=
X always ? */
> >   kernel/sched/fair.c: * can also include other factors [XXX].
> >   kernel/sched/fair.c: * [XXX expand on:
> >   kernel/sched/fair.c: * [XXX more?]
> >   kernel/sched/fair.c: * [XXX write more on how we solve this.. _after_=
 merging pjt's patches that
> >   kernel/sched/fair.c:             * XXX for now avg_load is not comput=
ed and always 0 so we
> >   kernel/sched/fair.c:            /* XXX broken for overlapping NUMA gr=
oups */
> >
>=20
> I will have a look :-)
>=20
> > :-)
> >
> > Thanks,
> >
> >         Ingo

--=20

