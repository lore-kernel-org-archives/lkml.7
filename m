Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7875DC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 12:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E20920673
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 12:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Uc6WYHXL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731867AbfJNMEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 08:04:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44740 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731086AbfJNME3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 08:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BmOPp+taOY8BR2ZI4WdO4QCUS5J7kKdc3aPpY7kmwn8=; b=Uc6WYHXLwfjraqivEtUghKj+Q
        liuPacftC6E9Kj4e210AAaELBD8U9RTvKqc5qtKAY22DB83lPFlXKHUdM29+MY4QWkaOQ8XQjm7Zt
        EgqVXwm/990d10P74/CiMNTqzLYXkDcxVTKaJIp+VpX98Coxtzcg/pPA/ZSAZ/a2XC2RMSlTIC0qu
        Gg6BZKvGHuPJFrs2hqbd74b1TyK3itJ9lQT+LqtMCyIA0ZYKmebuyKcJPjIAPIwxjIXo9/PyGk5zS
        JWGpjkSXVzzF1SDfulKWazjjW4KcoMKQnnBifQTQQT+G7eKt4eoPAPvv0T6I2OTt8tTrbcG7LyX6b
        CHhAvKUiw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iJz5O-0004Ef-Il; Mon, 14 Oct 2019 12:04:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6BF57305E42;
        Mon, 14 Oct 2019 14:03:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4900C2829A4C5; Mon, 14 Oct 2019 14:04:23 +0200 (CEST)
Date:   Mon, 14 Oct 2019 14:04:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>, 1vier1@web.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 1/6] wake_q: Cleanup + Documentation update.
Message-ID: <20191014120423.GD2328@hirez.programming.kicks-ass.net>
References: <20191012054958.3624-1-manfred@colorfullife.com>
 <20191012054958.3624-2-manfred@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191012054958.3624-2-manfred@colorfullife.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2019 at 07:49:53AM +0200, Manfred Spraul wrote:
> 1) wake_q_add() contains a memory barrier, and callers such as
> ipc/mqueue.c rely on this barrier.
> Unfortunately, this is documented in ipc/mqueue.c, and not in the
> description of wake_q_add().
> Therefore: Update the documentation.
> Removing/updating ipc/mqueue.c will happen with the next patch in the
> series.
> 
> 2) wake_q_add() ends with get_task_struct(), which is an
> unordered refcount increase. Add a clear comment that the callers
> are responsible for a barrier: most likely spin_unlock() or
> smp_store_release().
> 
> 3) wake_up_q() relies on the memory barrier in try_to_wake_up().
> Add a comment, to simplify searching.
> 
> 4) wake_q.next is accessed without synchroniyation by wake_q_add(),
> using cmpxchg_relaxed(), and by wake_up_q().
> Therefore: Use WRITE_ONCE in wake_up_q(), to ensure that the
> compiler doesn't perform any tricks.
> 
> Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  kernel/sched/core.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index dd05a378631a..60ae574317fd 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -440,8 +440,16 @@ static bool __wake_q_add(struct wake_q_head *head, struct task_struct *task)
>   * @task: the task to queue for 'later' wakeup
>   *
>   * Queue a task for later wakeup, most likely by the wake_up_q() call in the
> - * same context, _HOWEVER_ this is not guaranteed, the wakeup can come
> - * instantly.
> + * same context, _HOWEVER_ this is not guaranteed. Especially, the wakeup
> + * may happen before the function returns.
> + *
> + * What is guaranteed is that there is a memory barrier before the wakeup,
> + * callers may rely on this barrier.

I would like to stress that this (wake_q_add) provides the same ordering
guarantees as a 'normal' wakeup.

> + *
> + * On the other hand, the caller must guarantee that @task does not disappear
> + * before wake_q_add() completed. wake_q_add() does not contain any memory
> + * barrier to ensure ordering, thus the caller may need to use
> + * smp_store_release().

Like Davidlohr, I'm slightly puzzled by this last paragraph.

>   *
>   * This function must be used as-if it were wake_up_process(); IOW the task
>   * must be ready to be woken at this location.
> @@ -486,11 +494,14 @@ void wake_up_q(struct wake_q_head *head)
>  		BUG_ON(!task);
>  		/* Task can safely be re-inserted now: */
>  		node = node->next;
> -		task->wake_q.next = NULL;
> +
> +		WRITE_ONCE(task->wake_q.next, NULL);
>  
>  		/*
>  		 * wake_up_process() executes a full barrier, which pairs with
>  		 * the queueing in wake_q_add() so as not to miss wakeups.
> +		 * The barrier is the smp_mb__after_spinlock() in
> +		 * try_to_wake_up().

We already have wake_up_process() documented as implying this barrier;
why do we want to mention the specifics here? That is, have a look at
the comments before try_to_wake_up().

>  		 */
>  		wake_up_process(task);
>  		put_task_struct(task);
> -- 
> 2.21.0
> 
