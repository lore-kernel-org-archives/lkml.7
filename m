Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D60C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B711022C7E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfGZI6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 04:58:09 -0400
Received: from foss.arm.com ([217.140.110.172]:39838 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfGZI6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 04:58:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1849F344;
        Fri, 26 Jul 2019 01:58:08 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.194.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE0A83F71A;
        Fri, 26 Jul 2019 01:58:06 -0700 (PDT)
Date:   Fri, 26 Jul 2019 09:58:04 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] sched/deadline: Cleanup on_dl_rq() handling
Message-ID: <20190726085804.akigyryogf7lcx6m@e107158-lin.cambridge.arm.com>
References: <20190726082756.5525-1-dietmar.eggemann@arm.com>
 <20190726082756.5525-5-dietmar.eggemann@arm.com>
 <0f460dba-4677-00de-59a2-5cd31ffe6e4b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0f460dba-4677-00de-59a2-5cd31ffe6e4b@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/26/19 09:37, Valentin Schneider wrote:
> On 26/07/2019 09:27, Dietmar Eggemann wrote:
> > Remove BUG_ON() in __enqueue_dl_entity() since there is already one in
> > enqueue_dl_entity().
> > 
> > Move the check that the dl_se is not on the dl_rq from
> > __dequeue_dl_entity() to dequeue_dl_entity() to align with the enqueue
> > side and use the on_dl_rq() helper function.
> > 
> > Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > ---
> >  kernel/sched/deadline.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> > 
> > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > index 1fa005f79307..a9cb52ceb761 100644
> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> > @@ -1407,8 +1407,6 @@ static void __enqueue_dl_entity(struct sched_dl_entity *dl_se)
> >  	struct sched_dl_entity *entry;
> >  	int leftmost = 1;
> >  
> > -	BUG_ON(!RB_EMPTY_NODE(&dl_se->rb_node));
> > -
> >  	while (*link) {
> >  		parent = *link;
> >  		entry = rb_entry(parent, struct sched_dl_entity, rb_node);
> > @@ -1430,9 +1428,6 @@ static void __dequeue_dl_entity(struct sched_dl_entity *dl_se)
> >  {
> >  	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
> >  
> > -	if (RB_EMPTY_NODE(&dl_se->rb_node))
> > -		return;
> > -
> 
> Any idea why a similar error leads to a BUG_ON() in the enqueue path but
> only a silent return on the dequeue path? I would expect the handling to be
> almost identical.

nit: s/BUG_ON/WARN_ON/

--
Qais Yousef
