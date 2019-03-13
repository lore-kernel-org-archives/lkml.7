Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD39C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9E320657
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uesIYn0A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbfCMTbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:31:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33302 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbfCMTbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eT5PPu8zGFQ87wtv0HuoZLW/3/b9KTRTD/vmD77hqHc=; b=uesIYn0AJYbI1o0Xkgi2upvC0
        lN0PmaY8K4bKtrExQNwf6U00NkKS2Wx0bCWvL/XcsbaDTLb163slbHcbhna4KXC5hFcONKOnn4p3B
        P1NV0DaKUh4MX6YaTR1ZokKd6Yh/vhb7Sa7FWaThoxZkgy6zN9FwWUuiiOSxdMBdomQvq+t869cgz
        /ptvxcaTrFihZHXLPC/bGRYO3rRDLhHQwJIIkBiMUe1z9Rr/QmMg+kYjzlCV88PfyQzYdqTEYOI5g
        d0hoNdHlXaCbbDkXHsaUL4zvtnJxsEz4rYWyqjfO2U1jaRlQwlNnAs2CrA6XGEesRQ1IUIKvgjxPc
        rv+/NCH4w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h49ae-0004wP-Gt; Wed, 13 Mar 2019 19:31:00 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B18879826C0; Wed, 13 Mar 2019 20:30:56 +0100 (CET)
Date:   Wed, 13 Mar 2019 20:30:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v7 01/15] sched/core: uclamp: Add CPU's clamp buckets
 refcounting
Message-ID: <20190313193056.GP2482@worktop.programming.kicks-ass.net>
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
 <20190208100554.32196-2-patrick.bellasi@arm.com>
 <20190313135238.GC5922@hirez.programming.kicks-ass.net>
 <20190313155954.jse2tyn5iqxm6wle@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313155954.jse2tyn5iqxm6wle@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 03:59:54PM +0000, Patrick Bellasi wrote:
> On 13-Mar 14:52, Peter Zijlstra wrote:
> > > +static inline void uclamp_rq_dec_id(struct task_struct *p, struct rq *rq,
> > > +				    unsigned int clamp_id)
> > > +{
> > > +	unsigned int bucket_id = p->uclamp[clamp_id].bucket_id;
> > > +	unsigned int rq_clamp, bkt_clamp;
> > > +
> > > +	SCHED_WARN_ON(!rq->uclamp[clamp_id].bucket[bucket_id].tasks);
> > > +	if (likely(rq->uclamp[clamp_id].bucket[bucket_id].tasks))
> > > +		rq->uclamp[clamp_id].bucket[bucket_id].tasks--;
> > > +
> > > +	/*
> > > +	 * Keep "local clamping" simple and accept to (possibly) overboost
> > > +	 * still RUNNABLE tasks in the same bucket.
> > > +	 */
> > > +	if (likely(rq->uclamp[clamp_id].bucket[bucket_id].tasks))
> > > +		return;
> > 
> > (Oh man, I hope that generates semi sane code; long live CSE passes I
> > suppose)
> 
> What do you mean ?

that does: 'rq->uclamp[clamp_id].bucket[bucket_id].tasks' three times in
a row. And yes the compiler _should_ dtrt, but....
