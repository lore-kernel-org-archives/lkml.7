Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4757FC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D8122DD3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BEhNKnjI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbfHUShX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 14:37:23 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49656 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfHUShX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 14:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kf5RXBkUmZn7pYyHjsUy7iUP0/zAm+AtDOJimInXYXs=; b=BEhNKnjIl46aLd+b4OgF/NX5h
        ViFJqdjHv2mz1fZq9Ct4OdFlbFaTh/+EY5D4JsJOLnbizBXD2BsHmoUaIbPBUSMjPodqk7/g7LNmp
        1uxQjBeGnINhsh9WmGcBH69M3N4RtkBqn8o3ahkrevXa4z3MU9P2yQisVu/1cQbQxpnUxhTewbP5h
        YJVraVRCnStM8Z5Vu5E2pVzO2AKRp6+U/qyivZfCd8L+rzQUBJ6Mh1m9XeFHnrAXBE50x+c/3Rwkh
        +RhygbFOwCMDeachMiUjqAUhAo201m3r19dlg6ont+NIiHacLx1cB8QmitQOML8Ky2SzPvzkpX24C
        3a+t0A1Ig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i0VTx-0002D2-G4; Wed, 21 Aug 2019 18:37:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6AD5F307456;
        Wed, 21 Aug 2019 20:36:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 040CD20A978FE; Wed, 21 Aug 2019 20:37:13 +0200 (CEST)
Date:   Wed, 21 Aug 2019 20:37:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Peng Liu <iwtbavbm@gmail.com>, linux-kernel@vger.kernel.org,
        mingo@redhat.com
Subject: Re: [PATCH] sched/fair: eliminate redundant code in sched_slice()
Message-ID: <20190821183713.GF2349@hirez.programming.kicks-ass.net>
References: <20190816141202.GA3135@iZj6chx1xj0e0buvshuecpZ>
 <20190821151523.lwazjd2d6rp5otdh@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821151523.lwazjd2d6rp5otdh@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 04:15:24PM +0100, Qais Yousef wrote:
> On 08/16/19 22:12, Peng Liu wrote:
> > Since sched_slice() is used in high frequency,
> > small change should also make sense.
> > 
> > Signed-off-by: Peng Liu <iwtbavbm@gmail.com>
> > ---
> >  kernel/sched/fair.c | 11 ++++-------
> >  1 file changed, 4 insertions(+), 7 deletions(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 1054d2cf6aaa..6ae2a507aac0 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -694,19 +694,16 @@ static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
> >  	u64 slice = __sched_period(cfs_rq->nr_running + !se->on_rq);
> >  
> >  	for_each_sched_entity(se) {
> > -		struct load_weight *load;
> >  		struct load_weight lw;
> >  
> >  		cfs_rq = cfs_rq_of(se);
> > -		load = &cfs_rq->load;
> > +		lw = cfs_rq->load;
> >  
> > -		if (unlikely(!se->on_rq)) {
> > +		if (unlikely(!se->on_rq))
> >  			lw = cfs_rq->load;
> >  
> > -			update_load_add(&lw, se->load.weight);
> > -			load = &lw;
> > -		}
> > -		slice = __calc_delta(slice, se->load.weight, load);
> > +		update_load_add(&lw, se->load.weight);
> > +		slice = __calc_delta(slice, se->load.weight, &lw);
> 
> Unless I misread the diff, you changed the behavior.
> 
> update_load_add() is only called if (unlikely(!se->on_rq)), but with your
> change it is called unconditionally. And lw is set twice.
> 
> I think what you intended is this?

So I'd really rather hold off on this; Rik is poking at getting rid of
all of this hierarchical crud in one go.
