Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4576C47404
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 06:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1756206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 06:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbfJNGft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 02:35:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:51028 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726406AbfJNGft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 02:35:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7FB56AD5F;
        Mon, 14 Oct 2019 06:35:47 +0000 (UTC)
Date:   Sun, 13 Oct 2019 23:34:33 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Waiman Long <longman@redhat.com>, 1vier1@web.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 1/6] wake_q: Cleanup + Documentation update.
Message-ID: <20191014063433.dy72ybjikfnxcufv@linux-p48b>
References: <20191012054958.3624-1-manfred@colorfullife.com>
 <20191012054958.3624-2-manfred@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191012054958.3624-2-manfred@colorfullife.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Oct 2019, Manfred Spraul wrote:

>1) wake_q_add() contains a memory barrier, and callers such as
>ipc/mqueue.c rely on this barrier.
>Unfortunately, this is documented in ipc/mqueue.c, and not in the
>description of wake_q_add().
>Therefore: Update the documentation.
>Removing/updating ipc/mqueue.c will happen with the next patch in the
>series.
>
>2) wake_q_add() ends with get_task_struct(), which is an
>unordered refcount increase. Add a clear comment that the callers
>are responsible for a barrier: most likely spin_unlock() or
>smp_store_release().
>
>3) wake_up_q() relies on the memory barrier in try_to_wake_up().
>Add a comment, to simplify searching.
>
>4) wake_q.next is accessed without synchroniyation by wake_q_add(),
>using cmpxchg_relaxed(), and by wake_up_q().
>Therefore: Use WRITE_ONCE in wake_up_q(), to ensure that the
>compiler doesn't perform any tricks.
>
>Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
>Cc: Davidlohr Bueso <dave@stgolabs.net>
>---
> kernel/sched/core.c | 17 ++++++++++++++---
> 1 file changed, 14 insertions(+), 3 deletions(-)
>
>diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>index dd05a378631a..60ae574317fd 100644
>--- a/kernel/sched/core.c
>+++ b/kernel/sched/core.c
>@@ -440,8 +440,16 @@ static bool __wake_q_add(struct wake_q_head *head, struct task_struct *task)
>  * @task: the task to queue for 'later' wakeup
>  *
>  * Queue a task for later wakeup, most likely by the wake_up_q() call in the
>- * same context, _HOWEVER_ this is not guaranteed, the wakeup can come
>- * instantly.
>+ * same context, _HOWEVER_ this is not guaranteed. Especially, the wakeup
>+ * may happen before the function returns.
>+ *
>+ * What is guaranteed is that there is a memory barrier before the wakeup,
>+ * callers may rely on this barrier.
>+ *
>+ * On the other hand, the caller must guarantee that @task does not disappear
>+ * before wake_q_add() completed. wake_q_add() does not contain any memory
>+ * barrier to ensure ordering, thus the caller may need to use
>+ * smp_store_release().

This is why we have wake_q_add_safe(). I think this last paragraph is unnecessary
and confusing.

Thanks,
Davidlohr

>  *
>  * This function must be used as-if it were wake_up_process(); IOW the task
>  * must be ready to be woken at this location.
>@@ -486,11 +494,14 @@ void wake_up_q(struct wake_q_head *head)
> 		BUG_ON(!task);
> 		/* Task can safely be re-inserted now: */
> 		node = node->next;
>-		task->wake_q.next = NULL;
>+
>+		WRITE_ONCE(task->wake_q.next, NULL);
>
> 		/*
> 		 * wake_up_process() executes a full barrier, which pairs with
> 		 * the queueing in wake_q_add() so as not to miss wakeups.
>+		 * The barrier is the smp_mb__after_spinlock() in
>+		 * try_to_wake_up().
> 		 */
> 		wake_up_process(task);
> 		put_task_struct(task);
>-- 
>2.21.0
>
