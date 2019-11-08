Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6839DFC6196
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EEAF215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q+of8ZJx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbfKHUty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 15:49:54 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57854 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfKHUtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 15:49:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+OQ0mKAT8YcDsu48iWgScPcjStVBrGF5BQwSrPXTmnI=; b=Q+of8ZJxHcSftLfmHZpXCD4Yc
        b+W3C/xFjDh97snZfWDTmgrXu4SmTL+NlkUPMRU0Z6MVaqs1bb5eXVwPv97i+n7SgcQF9pl+DH4Ej
        yHwwGcKwrNIKT/dHaUzqN2Po/43lWYFuiN78bpX6igPwiHQvMy1Z6Sjz0wjaCeuwoB5edx8qY4Osj
        NyUqMWJfzLhnneLT2ZkLtAnOvcm9Wd6O+Ohy/fPRwkcfVO0ENJhi/vjTwd2hmAn951TFckPpCmzZX
        DvzWX4WPn6Hgqt1sd17U5vxvC+ZYmuAEWySh6WvG5TRvXQgppHS9Iwn/KXpJRX6HIrtsDq6+K6wyP
        rj2rs87WA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iTBCQ-0007N5-4Z; Fri, 08 Nov 2019 20:49:42 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C3BE8980E2D; Fri,  8 Nov 2019 21:49:40 +0100 (CET)
Date:   Fri, 8 Nov 2019 21:49:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, qperret@google.com,
        qais.yousef@arm.com, ktkhai@virtuozzo.com
Subject: Re: [PATCH 1/7] sched: Fix pick_next_task() vs change pattern race
Message-ID: <20191108204940.GL3079@worktop.programming.kicks-ass.net>
References: <20191108131553.027892369@infradead.org>
 <20191108131909.428842459@infradead.org>
 <e19c566b-dc14-a5aa-de4f-c67cdb17620c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e19c566b-dc14-a5aa-de4f-c67cdb17620c@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 04:05:25PM +0000, Valentin Schneider wrote:
> On 08/11/2019 13:15, Peter Zijlstra wrote:
> > +static int balance_rt(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
> > +{
> > +	if (!on_rt_rq(&p->rt) && need_pull_rt_task(rq, p)) {
> > +		/*
> > +		 * This is OK, because current is on_cpu, which avoids it being
> > +		 * picked for load-balance and preemption/IRQs are still
> > +		 * disabled avoiding further scheduler activity on it and we've
> > +		 * not yet started the picking loop.
> > +		 */
> > +		rq_unpin_lock(rq, rf);
> > +		pull_rt_task(rq);
> > +		rq_repin_lock(rq, rf);
> > +	}
> > +
> > +	return sched_stop_runnable(rq) || sched_dl_runnable(rq) || sched_rt_runnable(rq);
> 
> So we already have some dependencies on the class ordering (e.g. fair->idle),
> but I'm wondering if would it make sense to have these runnable functions be
> defined as sched_class callbacks?
> 
> e.g.
> 
>   rt_sched_class.runnable = rt_runnable
> 
> w/ rt_runnable() just being a non-inlined sched_rt_runnable() you define
> further down the patch (or a wrapper to it). The balance return pattern could
> then become:
> 
>   for_class_range(class, sched_class_highest, rt_sched_class->next)
>   	if (class->runnable(rq))
> 		return true;
>   return false;
> 
> (and replace rt_sched_class by whatever class' balance callback this is)
> 
> It's a bit neater, but I'm pretty sure it's going to run worse :/
> The only unaffected one would be fair, since newidle_balance() already does
> that "for free".

Yeah, it'll be pretty terrible :/

That said, I might have some clues on how to get rid of all the indirect
calls, but I need to play around a bit. It'll be invasive though :/
(like that ever stopped me).
