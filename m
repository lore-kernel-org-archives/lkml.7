Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07181C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 09:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6ED321E6A
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 09:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbfHGJ5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 05:57:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35962 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727733AbfHGJ5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 05:57:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B4ADFC0718B8;
        Wed,  7 Aug 2019 09:57:14 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id D71655D704;
        Wed,  7 Aug 2019 09:56:58 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed,  7 Aug 2019 11:57:14 +0200 (CEST)
Date:   Wed, 7 Aug 2019 11:56:58 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will.deacon@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        juri.lelli@redhat.com, williams@redhat.com, bristot@redhat.com,
        longman@redhat.com, dave@stgolabs.net, jack@suse.com
Subject: Re: [PATCH] locking/percpu_rwsem: Rewrite to not use rwsem
Message-ID: <20190807095657.GA24112@redhat.com>
References: <20190805140241.GI2332@hirez.programming.kicks-ass.net>
 <20190806161741.GC21454@redhat.com>
 <20190806171515.GR2349@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806171515.GR2349@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 07 Aug 2019 09:57:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06, Peter Zijlstra wrote:
>
> On Tue, Aug 06, 2019 at 06:17:42PM +0200, Oleg Nesterov wrote:
>
> > but this will also wake all the pending readers up. Every reader will burn
> > CPU for no reason and likely delay the writer.
> >
> > In fact I'm afraid this can lead to live-lock, because every reader in turn
> > will call __percpu_up_read().
>
> I didn't really consider that case important; because of how heavy the
> write side is, it should be relatively rare.

Well yes, but down_read() should not stress the system.

However I was wrong, it is not that bad as I thought, I forgot that the
pending reader won't return from wait_event(sem->block) if another reader
comes.

Still I think we should try to avoid the unnecessary wakeups. See below.

> > How about 2 wait queues?
>
> That said, I can certainly try that.

and either way, with or without 2 queues, what do you think about the code
below?

This way the new reader does wake_up() only in the very unlikely case when
it races with the new writer which sets sem->block = 1 right after
this_cpu_inc().

Oleg.
-------------------------------------------------------------------------------

static inline void percpu_down_read(struct percpu_rw_semaphore *sem)
{
	might_sleep();
	rwsem_acquire_read(&sem->dep_map, 0, 0, _RET_IP_);

	preempt_disable();

	if (likely(rcu_sync_is_idle(&sem->rss)))
		__this_cpu_inc(*sem->read_count);
	else
		__percpu_down_read(sem, false);

	preempt_enable();
}

static inline void percpu_up_read(struct percpu_rw_semaphore *sem)
{
	rwsem_release(&sem->dep_map, 1, _RET_IP_);

	preempt_disable();

	if (likely(rcu_sync_is_idle(&sem->rss)))
		__this_cpu_dec(*sem->read_count);
	else
		__percpu_up_read(sem);

	preempt_enable();
}

// both called and return with preemption disabled

bool __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)
{

	if (atomic_read_acquire(&sem->block)) {
again:
		preempt_enable();
		__wait_event(sem->waiters, !atomic_read_acquire(&sem->block));
		preempt_disable();
	}

	__this_cpu_inc(*sem->read_count);

	smp_mb();

	if (likely(!atomic_read_acquire(&sem->block)))
		return true;

	__percpu_up_read(sem);

	if (try)
		return false;

	goto again;
}

void __percpu_up_read(struct percpu_rw_semaphore *sem)
{
	smp_mb();

	__this_cpu_dec(*sem->read_count);

	wake_up(&sem->waiters);
}

