Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFC2C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCFF0216F4
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EGAXu6Ma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfHEPnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 11:43:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33518 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfHEPnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 11:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QerNwwXIfcVqiUxVIQqRP9I819cRghlSQ0iNJulxaCk=; b=EGAXu6MaYf4Vv4pd0s/b/SV5go
        rFYmS2peBb1Dus950jsiA9TjNwOJiAiPbPgVTas3HVRBvlgOl0ESqn2KxV6Uc/9INM2JrMzcNJqZl
        9O/+wHgCgm1NIw9mKJ07jXaadhLaaA8ChicH7Ffo8RvKu63HQ5eORSZjc8sWAqdA+vW89EALgMgXK
        47mrGqvcJeVBX4WIjwN3PKuVNLhHfWolFnCuUv5ljlUJM6I1wF+0PUJIkflRJCJu+F7E2swvG98Wu
        Nh8QA+vD4zvoBe4inUBzA2a+cWQfDhmNG698Qn6nwKcGE535N+UW9zlclffBqHUIck7K8UwvILBuS
        LljtTLIQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1huf90-0000bY-As; Mon, 05 Aug 2019 15:43:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6FFDA201F0990; Mon,  5 Aug 2019 17:43:28 +0200 (CEST)
Date:   Mon, 5 Aug 2019 17:43:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, Will Deacon <will@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        juri.lelli@redhat.com, williams@redhat.com, bristot@redhat.com,
        longman@redhat.com, dave@stgolabs.net, jack@suse.com
Subject: Re: [PATCH] locking/percpu_rwsem: Rewrite to not use rwsem
Message-ID: <20190805154328.GJ2332@hirez.programming.kicks-ass.net>
References: <20190805140241.GI2332@hirez.programming.kicks-ass.net>
 <20190805144318.GA972@tardis>
 <20190805145813.GB972@tardis>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190805145813.GB972@tardis>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 10:58:13PM +0800, Boqun Feng wrote:
> On Mon, Aug 05, 2019 at 10:43:18PM +0800, Boqun Feng wrote:
> > On Mon, Aug 05, 2019 at 04:02:41PM +0200, Peter Zijlstra wrote:
> > [...]
> > > =20
> > >  static inline void percpu_up_read(struct percpu_rw_semaphore *sem)
> > >  {
> > > +	rwsem_release(&sem->dep_map, 1, _RET_IP_);
> > > +
> > >  	preempt_disable();
> > >  	/*
> > >  	 * Same as in percpu_down_read().
> > >  	 */
> > > -	if (likely(rcu_sync_is_idle(&sem->rss)))
> > > +	if (likely(rcu_sync_is_idle(&sem->rss))) {
> > >  		__this_cpu_dec(*sem->read_count);
> > > -	else
> > > -		__percpu_up_read(sem); /* Unconditional memory barrier */
> > > -	preempt_enable();
> > > +		preempt_enable();
> > > +		return;
> > > +	}
> > > =20
> > > -	rwsem_release(&sem->rw_sem.dep_map, 1, _RET_IP_);
> >=20
> > Missing a preempt_enable() here?
> >=20
>=20
> Ah.. you modified the semantics of __percpu_up_read() to imply a
> preempt_enable(), sorry for the noise...

Yes indeed; I suppose I should've noted that in the Changlog. The reason
is that waitqueues use spin_lock() which change into a sleepable lock on
RT and thus cannot be used with preeption disabled. We also cannot
(easily) switch to swait because we use both exclusive and !exclusive
waits.
