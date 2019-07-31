Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E426C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B7820657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZAzihXzP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbfGaJfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 05:35:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60052 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfGaJfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 05:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zJoP3Rg2fAIDmBPa+QFXOhQhKDK0+45L1xRuX7JQPgU=; b=ZAzihXzPUv9OGfnAq5ECib+Jw
        Z502cCgNGjSsVNNP2hHOMyZQJoz+OhuOXaS4+xcCVecnaaQSIJkb5DcqKZsEx3rVZM1TN/B1N3Df9
        xYQAX0BnGjynhMfc7h7A2sCWwDXW9Z2Eu6t5o3MUlPrWGIUhasrDLGSDxEOyLR+SgN7XjYA5LhRNv
        wjG/iN86Ivp350AQBoIq1BvXKERlARWZk+yd6DZojiKJ3VC9L/i/L6Gw5FcOOMBV+XGflhcicysJK
        3QAVNrSe+tDGU4KTGLMQaOTWraGKXVi/LpRgZPJjux+9kZQdE+be2IlKc26njDADIJB9hdjbaRzFM
        omruSilKA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsl15-0007MJ-SR; Wed, 31 Jul 2019 09:35:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 052EA2029FD58; Wed, 31 Jul 2019 11:35:26 +0200 (CEST)
Date:   Wed, 31 Jul 2019 11:35:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        dietmar.eggemann@arm.com, mingo@redhat.com,
        morten.rasmussen@arm.com, tglx@linutronix.de,
        mgorman@techsingularity.net, vincent.guittot@linaro.org
Subject: Re: [PATCH 09/14] sched,fair: refactor enqueue/dequeue_entity
Message-ID: <20190731093525.GH31425@hirez.programming.kicks-ass.net>
References: <20190722173348.9241-1-riel@surriel.com>
 <20190722173348.9241-10-riel@surriel.com>
 <20190730093617.GV31398@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730093617.GV31398@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 11:36:17AM +0200, Peter Zijlstra wrote:
> On Mon, Jul 22, 2019 at 01:33:43PM -0400, Rik van Riel wrote:

> > +static bool
> > +enqueue_entity_groups(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> > +{
> > +	/*
> > +	 * When enqueuing a sched_entity, we must:
> > +	 *   - Update loads to have both entity and cfs_rq synced with now.
> > +	 *   - Add its load to cfs_rq->runnable_avg
> > +	 *   - For group_entity, update its weight to reflect the new share of
> > +	 *     its group cfs_rq
> > +	 *   - Add its new weight to cfs_rq->load.weight
> > +	 */
> > +	if (!update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH))
> > +		return false;
> > +
> > +	update_cfs_group(se);
> > +	return true;
> > +}

> No functional, but you did make update_cfs_group() conditional. Now that
> looks OK, but maybe you can do that part in a separate patch with a
> little justification of its own.

To record (and extend) our discussion from IRC yesterday; I now do think
the above is in fact a problem.

The thing is that update_cfs_group() does not soly rely on the tg state;
it also contains magic to deal with ramp up; for which you later
introduce that max_h_load thing.

Specifically (re)read the second part of the comment describing
calc_group_shares() where it explains the ramp up:

 * The problem with it is that because the average is slow -- it was designed
 * to be exactly that of course -- this leads to transients in boundary
 * conditions. In specific, the case where the group was idle and we start the
 * one task. It takes time for our CPU's grq->avg.load_avg to build up,
 * yielding bad latency etc..

 (and further)

So by not always calling this (and not updating h_load) you fail to take
advantage of this.

So I would suggest keeping update_cfs_group() unconditional, and
recomputing the h_load for the entire hierarchy on enqueue.
