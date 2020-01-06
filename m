Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36BEC2D0D1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 10:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9113720731
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 10:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RYFVFEjG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgAFK2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 05:28:35 -0500
Received: from merlin.infradead.org ([205.233.59.134]:40422 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgAFK2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 05:28:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Lz46G6qRS0iXyjoqa8gTgIUca8qdvcSqxaUA8OlqGiA=; b=RYFVFEjG2yG4Q+Y7aFP46IKAz
        ndmqMBU4hVaUjfQZ0ot9M7T5I6lXeU2ZXGFx3UkRkssrcOF0/hSvq1H8Nge9H7xH1A0LMEphTq3Ec
        xRGZ2h82ux/ALJpOnxEMhXQLxevkaPIg2pqELwDJGNpwVAzd4RaLvGG+zqZ5R4u4MQW8JRLVi94aO
        D1v4XPBlq1C0uE/mSrdEy4PsnO8NrqG/ApcQurqx22kjAPan+nL3TdzrPAb0FusoNqqQjBDd7e1kP
        DyF9hEAmMTzOQV9fr6ysxgMSJsZ5f0PaQ0WR/BXg+qmvBxztf5SLKDmhuCf55oMkvB4XpjuO+lU6L
        vyEZY4T4A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ioPcQ-0000wS-9o; Mon, 06 Jan 2020 10:28:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B3420306368;
        Mon,  6 Jan 2020 11:26:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B72F62B27B121; Mon,  6 Jan 2020 11:28:16 +0100 (CET)
Date:   Mon, 6 Jan 2020 11:28:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peng Liu <iwtbavbm@gmail.com>, linux-kernel@vger.kernel.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, qais.yousef@arm.com,
        morten.rasmussen@arm.com, valentin.schneider@arm.com
Subject: Re: [PATCH v2] sched/fair: fix sgc->{min,max}_capacity miscalculate
Message-ID: <20200106102816.GN2810@hirez.programming.kicks-ass.net>
References: <20200104130828.GA7718@iZj6chx1xj0e0buvshuecpZ>
 <e034b806-bb3d-98c0-5d60-53610bfe6ca0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e034b806-bb3d-98c0-5d60-53610bfe6ca0@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2020 at 10:25:49AM +0100, Dietmar Eggemann wrote:
> On 04/01/2020 14:08, Peng Liu wrote:
> 
> Could you add a hint that this is about the SD_OVERLAP path? Something
> like 'Fix sgc->{min,max}_capacity calculation for SD_OVERLAP'
> 
> > commit bf475ce0a3dd ("sched/fair: Add per-CPU min capacity to
> > sched_group_capacity") introduced per-cpu min_capacity.
> > 
> > commit e3d6d0cb66f2 ("sched/fair: Add sched_group per-CPU max capacity")
> > introduced per-cpu max_capacity.
> > 
> > Here, capacity is the accumulated sum of (maybe) many CPUs' capacity.
> > Compare with capacity to get {min,max}_capacity makes no sense. Instead,
> > we should compare one by one in each iteration to get
> > sgc->{min,max}_capacity of the group.
> > 
> > Also, the only CPU in rq->sd->groups should be rq's CPU. Thus,
> > capacity_of(cpu_of(rq)) should be equal to rq->sd->groups->sgc->capacity.
> > Code can be simplified by removing the if/else.
> 
> Could we improve the description of the issue and the change a little
> bit? Something like:
> 
> In the SD_OVERLAP case, the local variable 'capacity' represents the sum
> of CPU capacity of all CPUs in the first sched group (sg) of the sched
> domain (sd).
> 
> It is erroneously used to calculate sg's min and max CPU capacity.
> To fix this use capacity_of(cpu) instead of 'capacity'.
> 
> The code which achieves this via cpu_rq(cpu)->sd->groups->sgc->capacity
> (for rq->sd != NULL) can be removed since it delivers the same value as
> capacity_of(cpu) which is currently only used for the (!rq->sd) case
> (see update_cpu_capacity()).
> A sg of the lowest sd (rq->sd or sd->child == NULL) represents a single
> CPU (and hence sg->sgc->capacity == capacity_of(cpu)).
> 

I've made it like so.

---
Subject: sched/fair: Fix sgc->{min,max}_capacity calculation for SD_OVERLAP
From: Peng Liu <iwtbavbm@gmail.com>
Date: Sat, 4 Jan 2020 21:08:28 +0800

commit bf475ce0a3dd ("sched/fair: Add per-CPU min capacity to
sched_group_capacity") introduced per-cpu min_capacity.

commit e3d6d0cb66f2 ("sched/fair: Add sched_group per-CPU max capacity")
introduced per-cpu max_capacity.

In the SD_OVERLAP case, the local variable 'capacity' represents the sum
of CPU capacity of all CPUs in the first sched group (sg) of the sched
domain (sd).

It is erroneously used to calculate sg's min and max CPU capacity.
To fix this use capacity_of(cpu) instead of 'capacity'.

The code which achieves this via cpu_rq(cpu)->sd->groups->sgc->capacity
(for rq->sd != NULL) can be removed since it delivers the same value as
capacity_of(cpu) which is currently only used for the (!rq->sd) case
(see update_cpu_capacity()).
An sg of the lowest sd (rq->sd or sd->child == NULL) represents a single
CPU (and hence sg->sgc->capacity == capacity_of(cpu)).

Signed-off-by: Peng Liu <iwtbavbm@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20200104130828.GA7718@iZj6chx1xj0e0buvshuecpZ
---
 kernel/sched/fair.c |   26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7855,29 +7855,11 @@ void update_group_capacity(struct sched_
 		 */
 
 		for_each_cpu(cpu, sched_group_span(sdg)) {
-			struct sched_group_capacity *sgc;
-			struct rq *rq = cpu_rq(cpu);
+			unsigned long cpu_cap = capacity_of(cpu);
 
-			/*
-			 * build_sched_domains() -> init_sched_groups_capacity()
-			 * gets here before we've attached the domains to the
-			 * runqueues.
-			 *
-			 * Use capacity_of(), which is set irrespective of domains
-			 * in update_cpu_capacity().
-			 *
-			 * This avoids capacity from being 0 and
-			 * causing divide-by-zero issues on boot.
-			 */
-			if (unlikely(!rq->sd)) {
-				capacity += capacity_of(cpu);
-			} else {
-				sgc = rq->sd->groups->sgc;
-				capacity += sgc->capacity;
-			}
-
-			min_capacity = min(capacity, min_capacity);
-			max_capacity = max(capacity, max_capacity);
+			capacity += cpu_cap;
+			min_capacity = min(cpu_cap, min_capacity);
+			max_capacity = max(cpu_cap, max_capacity);
 		}
 	} else  {
 		/*
