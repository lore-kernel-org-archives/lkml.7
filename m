Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA330C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D7C120857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfCSMd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:33:57 -0400
Received: from outbound-smtp25.blacknight.com ([81.17.249.193]:51512 "EHLO
        outbound-smtp25.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726002AbfCSMd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:33:57 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp25.blacknight.com (Postfix) with ESMTPS id B78F9B8700
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 12:33:55 +0000 (GMT)
Received: (qmail 19748 invoked from network); 19 Mar 2019 12:33:55 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[213.151.95.130])
  by 81.17.254.9 with ESMTPSA (DHE-RSA-AES256-SHA encrypted, authenticated); 19 Mar 2019 12:33:55 -0000
Date:   Tue, 19 Mar 2019 12:33:54 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Do not re-read h_load_next during hierarchical
 load calculation
Message-ID: <20190319123354.qnsazogerjqa2dmv@techsingularity.net>
References: <20190319091709.lqrtbn76sjx73hnv@techsingularity.net>
 <20190319120609.GD5996@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190319120609.GD5996@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 01:06:09PM +0100, Peter Zijlstra wrote:
> > ---
> >  kernel/sched/fair.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 310d0637fe4b..34aeb40e69d2 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7726,7 +7726,7 @@ static void update_cfs_rq_h_load(struct cfs_rq *cfs_rq)
> >  		cfs_rq->last_h_load_update = now;
> >  	}
> >  
> > -	while ((se = cfs_rq->h_load_next) != NULL) {
> > +	while ((se = READ_ONCE(cfs_rq->h_load_next)) != NULL) {
> >  		load = cfs_rq->h_load;
> >  		load = div64_ul(load * se->avg.load_avg,
> >  			cfs_rq_load_avg(cfs_rq) + 1);
> 
> Where there is a READ_ONCE there should also be a corresponding
> WRITE_ONCE(). Otherwise the compiler can still screw us over by doing
> store-tearing.
> 
> So something like the below. But looking at this, we probably also want
> ONCE treatment on cfs_rq->h_load itself, but that's another patch.
> 
> And I think we can do something with cfs_rq->last_h_load_update.
> 

Ok, I hadn't taken into account the possibility of store tearing but you're
right, it is a possibility depending on the architecture and your patch
is better. While there are some potential issues around h_load, I had
treated it as data that is approximate and only considered the potential
NULL dereference to be relevant.

I'll send a v2 shortly.
