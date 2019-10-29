Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C52CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B8120830
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xzc0mhG4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731985AbfJ2Srz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 14:47:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33168 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731891AbfJ2Srz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 14:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zh4u1dcrzBGR4ZvN1uvb2zziYEDifxIIp9YgvuWCPno=; b=Xzc0mhG4IG4lbteBYs05SzxLG
        6YFSJk7AU0FjJV6oDtz9kmkpB1UCzo4aeZFpn0tPwguldBTHRMusxf8EtO4Y7aZ1ZPf15LoLZanj6
        Pfyg2nEgyZj97hfl/vMKd/39Onj/hgL3EU5P5ZWaptdFWEmmYhCDgtC59v4F1JQMs2UWyLhAybMD6
        lHM8sEdN6YPn/xAYrZ0ArKiQTar8AxW+aeJrbqb6OK8iMviaOlUUmgyGSMACEln+9tWmApd70aWFl
        KfYW25mlKanPJAlFu1vrNzK+9/23pafr0tgMx0DwuQgpJ+rWmBJqbdRuOiChD7MXMPX2RJOirXCDl
        6PDbnlIVg==;
Received: from [188.207.73.209] (helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iPWX1-0006QP-D6; Tue, 29 Oct 2019 18:47:51 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B459F9802EA; Tue, 29 Oct 2019 19:47:39 +0100 (CET)
Date:   Tue, 29 Oct 2019 19:47:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Will Deacon <will.deacon@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        juri.lelli@redhat.com, williams@redhat.com, bristot@redhat.com,
        longman@redhat.com, dave@stgolabs.net, jack@suse.com
Subject: Re: [PATCH] locking/percpu_rwsem: Rewrite to not use rwsem
Message-ID: <20191029184739.GA3079@worktop.programming.kicks-ass.net>
References: <20190805140241.GI2332@hirez.programming.kicks-ass.net>
 <20190806161741.GC21454@redhat.com>
 <20190806171515.GR2349@hirez.programming.kicks-ass.net>
 <20190807095657.GA24112@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807095657.GA24112@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 11:56:58AM +0200, Oleg Nesterov wrote:

> and either way, with or without 2 queues, what do you think about the code
> below?

Sorry for being so tardy with this thread.. having once again picked up
the patch, I found your email.

> This way the new reader does wake_up() only in the very unlikely case when
> it races with the new writer which sets sem->block = 1 right after
> this_cpu_inc().

Ah, by waiting early, you avoid spurious wakeups when
__percpu_down_read() happens after a successful percpu_down_write().
Nice!

I've made these changes. Now let me go have a play with that second
waitqueue.

> -------------------------------------------------------------------------------
> 
> static inline void percpu_down_read(struct percpu_rw_semaphore *sem)
> {
> 	might_sleep();
> 	rwsem_acquire_read(&sem->dep_map, 0, 0, _RET_IP_);
> 
> 	preempt_disable();
> 
> 	if (likely(rcu_sync_is_idle(&sem->rss)))
> 		__this_cpu_inc(*sem->read_count);
> 	else
> 		__percpu_down_read(sem, false);
> 
> 	preempt_enable();
> }
> 
> static inline void percpu_up_read(struct percpu_rw_semaphore *sem)
> {
> 	rwsem_release(&sem->dep_map, 1, _RET_IP_);
> 
> 	preempt_disable();
> 
> 	if (likely(rcu_sync_is_idle(&sem->rss)))
> 		__this_cpu_dec(*sem->read_count);
> 	else
> 		__percpu_up_read(sem);
> 
> 	preempt_enable();
> }

I like that symmetry, but see below ...

> // both called and return with preemption disabled
> 
> bool __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)
> {
> 
> 	if (atomic_read_acquire(&sem->block)) {
> again:
> 		preempt_enable();
> 		__wait_event(sem->waiters, !atomic_read_acquire(&sem->block));
> 		preempt_disable();
> 	}
> 
> 	__this_cpu_inc(*sem->read_count);
> 
> 	smp_mb();
> 
> 	if (likely(!atomic_read_acquire(&sem->block)))
> 		return true;
> 
> 	__percpu_up_read(sem);
> 
> 	if (try)
> 		return false;
> 
> 	goto again;
> }
> 
> void __percpu_up_read(struct percpu_rw_semaphore *sem)
> {
> 	smp_mb();
> 
> 	__this_cpu_dec(*sem->read_count);
> 
	preempt_enable();
> 	wake_up(&sem->waiters);
	preempt_disable()

and this (sadly) means there's a bunch of back-to-back
preempt_disable()+preempt_enable() calls. Leaving out the
preempt_disable() here makes it ugly again :/

Admittedly, this is PREEMPT_RT only, but given that is >< close to
mainline we'd better get it right.

> }
> 
