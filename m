Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D339C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1A3420733
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbfKOJJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 04:09:45 -0500
Received: from foss.arm.com ([217.140.110.172]:55392 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfKOJJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 04:09:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D5F4328;
        Fri, 15 Nov 2019 01:09:44 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CBF883F6C4;
        Fri, 15 Nov 2019 01:09:42 -0800 (PST)
Date:   Fri, 15 Nov 2019 09:09:40 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        Tejun Heo <tj@kernel.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>
Subject: Re: [PATCH] sched/uclamp: Fix overzealous type replacement
Message-ID: <20191115090939.6ku6cc44iaoanjph@e107158-lin.cambridge.arm.com>
References: <20191113165334.14291-1-valentin.schneider@arm.com>
 <CAKfTPtCeGPS57wdyVjA7mnQTW4EeTrd0LX-_1f_+MWp--1FRNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtCeGPS57wdyVjA7mnQTW4EeTrd0LX-_1f_+MWp--1FRNQ@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/19 09:12, Vincent Guittot wrote:
> On Wed, 13 Nov 2019 at 17:55, Valentin Schneider
> <valentin.schneider@arm.com> wrote:
> >
> > Some uclamp helpers had their return type changed from 'unsigned int' to
> > 'enum uclamp_id' by commit
> >
> >   0413d7f33e60 ("sched/uclamp: Always use 'enum uclamp_id' for clamp_id values")
> >
> > but it happens that some *actually* do return an unsigned int value. Those
> > are the helpers that return a utilization value: uclamp_rq_max_value() and
> > uclamp_eff_value(). Fix those up.
> >
> > Note that this doesn't lead to any obj diff using a relatively recent
> > aarch64 compiler (8.3-2019.03). The current code of e.g. uclamp_eff_value()
> > already figures out that the return value is 11 bits (bits_per(1024)) and
> > doesn't seem to do anything funny. I'm still marking this as fixing the
> > above commit to be on the safe side.
> >
> > Fixes: 0413d7f33e60 ("sched/uclamp: Always use 'enum uclamp_id' for clamp_id values")
> > Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> > ---
> >  kernel/sched/core.c  | 4 ++--
> >  kernel/sched/sched.h | 2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 513a4794ff36..71a45025cd2e 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -853,7 +853,7 @@ static inline void uclamp_idle_reset(struct rq *rq, enum uclamp_id clamp_id,
> >  }
> >
> >  static inline
> > -enum uclamp_id uclamp_rq_max_value(struct rq *rq, enum uclamp_id clamp_id,
> > +unsigned int uclamp_rq_max_value(struct rq *rq, enum uclamp_id clamp_id,
> >                                    unsigned int clamp_value)
> >  {
> >         struct uclamp_bucket *bucket = rq->uclamp[clamp_id].bucket;
> > @@ -918,7 +918,7 @@ uclamp_eff_get(struct task_struct *p, enum uclamp_id clamp_id)
> >         return uc_req;
> >  }
> >
> > -enum uclamp_id uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id)
> > +unsigned int uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id)
> >  {
> >         struct uclamp_se uc_eff;
> >
> 
> And static inline enum uclamp_id uclamp_none(enum uclamp_id clamp_id) ?
> 
> Should it be fixed as well as it can return SCHED_CAPACITY_SCALE ?

Indeed. That should return unsigned int too as it's returning the uclamp value.

Thanks

--
Qais Yousef
