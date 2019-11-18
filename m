Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063A8C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 19:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD2412230E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 19:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfKRT5Z convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 14:57:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:34022 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726250AbfKRT5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 14:57:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 06B3AB0AE;
        Mon, 18 Nov 2019 19:57:22 +0000 (UTC)
Date:   Mon, 18 Nov 2019 11:53:04 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, will@kernel.org, oleg@redhat.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, juri.lelli@redhat.com, williams@redhat.com,
        bristot@redhat.com, longman@redhat.com, jack@suse.com
Subject: Re: [PATCH 5/5] locking/percpu-rwsem: Remove the embedded rwsem
Message-ID: <20191118195304.b3d6fg4jmmj7kmfh@linux-p48b>
References: <20191113102115.116470462@infradead.org>
 <20191113102855.925208237@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20191113102855.925208237@infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Nov 2019, Peter Zijlstra wrote:
>@@ -54,23 +52,23 @@ static bool __percpu_down_read_trylock(s
> 	 * the same CPU as the increment, avoiding the
> 	 * increment-on-one-CPU-and-decrement-on-another problem.

Nit: Now that you've made read_count more symmetric, maybe this first
paragraph can be moved down to __percpu_rwsem_trylock() reader side,
as such:

	/*
	 * Due to having preemption disabled the decrement happens on
	 * the same CPU as the increment, avoiding the
	 * increment-on-one-CPU-and-decrement-on-another problem.
	 */
	preempt_disable();
	ret = __percpu_down_read_trylock(sem);
	preempt_enable();

> 	 *
>-	 * If the reader misses the writer's assignment of readers_block, then
>-	 * the writer is guaranteed to see the reader's increment.
>+	 * If the reader misses the writer's assignment of sem->block, then the
>+	 * writer is guaranteed to see the reader's increment.

...

> bool __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)
> {
> 	if (__percpu_down_read_trylock(sem))
>@@ -89,20 +156,10 @@ bool __percpu_down_read(struct percpu_rw
> 	if (try)
> 		return false;
>
>-	/*
>-	 * We either call schedule() in the wait, or we'll fall through
>-	 * and reschedule on the preempt_enable() in percpu_down_read().
>-	 */
>-	preempt_enable_no_resched();
>-
>-	/*
>-	 * Avoid lockdep for the down/up_read() we already have them.
>-	 */
>-	__down_read(&sem->rw_sem);
>-	this_cpu_inc(*sem->read_count);
>-	__up_read(&sem->rw_sem);
>-
>+	preempt_enable();
>+	percpu_rwsem_wait(sem, /* .reader = */ true );
> 	preempt_disable();
>+
> 	return true;
> }
> EXPORT_SYMBOL_GPL(__percpu_down_read);

Do we really need to export symbol here? This function is only called
from percpu-rwsem.h.

>@@ -117,7 +174,7 @@ void __percpu_up_read(struct percpu_rw_s
> 	 */
> 	__this_cpu_dec(*sem->read_count);
>
>-	/* Prod writer to recheck readers_active */
>+	/* Prod writer to re-evaluate readers_active_check() */
> 	rcuwait_wake_up(&sem->writer);
> }
> EXPORT_SYMBOL_GPL(__percpu_up_read);
>@@ -137,6 +194,8 @@ EXPORT_SYMBOL_GPL(__percpu_up_read);
>  * zero.  If this sum is zero, then it is stable due to the fact that if any
>  * newly arriving readers increment a given counter, they will immediately
>  * decrement that same counter.
>+ *
>+ * Assumes sem->block is set.
>  */
> static bool readers_active_check(struct percpu_rw_semaphore *sem)
> {
>@@ -160,23 +219,22 @@ void percpu_down_write(struct percpu_rw_
> 	/* Notify readers to take the slow path. */
> 	rcu_sync_enter(&sem->rss);
>
>-	__down_write(&sem->rw_sem);
>-
> 	/*
>-	 * Notify new readers to block; up until now, and thus throughout the
>-	 * longish rcu_sync_enter() above, new readers could still come in.
>+	 * Try set sem->block; this provides writer-writer exclusion.
>+	 * Having sem->block set makes new readers block.
> 	 */
>-	WRITE_ONCE(sem->readers_block, 1);
>+	if (!__percpu_down_write_trylock(sem))
>+		percpu_rwsem_wait(sem, /* .reader = */ false);
>
>-	smp_mb(); /* D matches A */
>+	/* smp_mb() implied by __percpu_down_writer_trylock() on success -- D matches A */
                                               ^^^
					       write
...

>--- a/kernel/locking/rwsem.h
>+++ b/kernel/locking/rwsem.h
>@@ -1,12 +0,0 @@
>-/* SPDX-License-Identifier: GPL-2.0 */
>-
>-#ifndef __INTERNAL_RWSEM_H
>-#define __INTERNAL_RWSEM_H
>-#include <linux/rwsem.h>
>-
>-extern void __down_read(struct rw_semaphore *sem);
>-extern void __up_read(struct rw_semaphore *sem);
>-extern void __down_write(struct rw_semaphore *sem);
>-extern void __up_write(struct rw_semaphore *sem);

This is a nice side effect.

Thanks,
Davidlohr
