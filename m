Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48696C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 12:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AFB22173C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 12:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MDs2QHjl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfEIMbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 08:31:33 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57890 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfEIMbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 08:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=STuNDqhHWk4xUPlw4l8ibpyKNVMs8YJpESd8dG0MbCA=; b=MDs2QHjlE/RbLxY2I/iid5ZpW
        GshO7LKO+WxIhPVZCajrx7EVEqK+CKKczBKtK5Or3RAXVoh0TFWiI2fNxWfmCZsjee/oDW3qHCHK8
        cxwH951iYsoPvcVFDFeE9+o5qu8Ahk5UESKy70qrO4dz3jLNxDrzgVuPqGQ/+JMTevEtjWWkN3vyP
        IG1owGFEZWKeVgJUFNjzV0pep/I7uBW47bzY7K6wxYDN/SRHIAUA2LatMcitFhfjuV1YnPF5SlOYF
        8lGAoQNRLs+HqgKOBPZHRmTrrvhfc9kKPgig33rBKnGdg8Q0Kxrjxy/0ZzbuaXnk4nHvT3nM2NOI9
        operbSoww==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOiCX-00033y-Vv; Thu, 09 May 2019 12:31:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 76A562029F884; Thu,  9 May 2019 14:31:04 +0200 (CEST)
Date:   Thu, 9 May 2019 14:31:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RFC: console: hack up console_lock more v3
Message-ID: <20190509123104.GQ2589@hirez.programming.kicks-ass.net>
References: <20190509120903.28939-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509120903.28939-1-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2019 at 02:09:03PM +0200, Daniel Vetter wrote:
> Fix this by creating a prinkt_safe_up() which calls wake_up_process
> outside of the spinlock. This isn't correct in full generality, but
> good enough for console_lock:
> 
> - console_lock doesn't use interruptible or killable or timeout down()
>   calls, hence an up() is the only thing that can wake up a process.

Wrong :/ Any task can be woken at any random time. We must, at all
times, assume spurious wakeups will happen.

> +void printk_safe_up(struct semaphore *sem)
> +{
> +	unsigned long flags;
> +	struct semaphore_waiter *waiter = NULL;
> +
> +	raw_spin_lock_irqsave(&sem->lock, flags);
> +	if (likely(list_empty(&sem->wait_list))) {
> +		sem->count++;
> +	} else {
> +		waiter = list_first_entry(&sem->wait_list,
> +					  struct semaphore_waiter, list);
> +		list_del(&waiter->list);
> +		waiter->up = true;
> +	}
> +	raw_spin_unlock_irqrestore(&sem->lock, flags);
> +
> +	if (waiter) /* protected by being sole wake source */
> +		wake_up_process(waiter->task);
> +}
> +EXPORT_SYMBOL(printk_safe_up);

Since its only used from printk, that EXPORT really isn't needed.

Something like the below might work.

---
 kernel/locking/semaphore.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/locking/semaphore.c b/kernel/locking/semaphore.c
index 561acdd39960..ac0a67e95aac 100644
--- a/kernel/locking/semaphore.c
+++ b/kernel/locking/semaphore.c
@@ -38,7 +38,6 @@ static noinline void __down(struct semaphore *sem);
 static noinline int __down_interruptible(struct semaphore *sem);
 static noinline int __down_killable(struct semaphore *sem);
 static noinline int __down_timeout(struct semaphore *sem, long timeout);
-static noinline void __up(struct semaphore *sem);
 
 /**
  * down - acquire the semaphore
@@ -178,14 +177,24 @@ EXPORT_SYMBOL(down_timeout);
  */
 void up(struct semaphore *sem)
 {
+	struct semaphore_waiter *waiter;
+	DEFINE_WAKE_Q(wake_q);
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&sem->lock, flags);
-	if (likely(list_empty(&sem->wait_list)))
+	if (likely(list_empty(&sem->wait_list))) {
 		sem->count++;
-	else
-		__up(sem);
+		goto unlock;
+	}
+
+	waiter = list_first_entry(&sem->wait_list, struct semaphore_waiter, list);
+	list_del(&waiter->list);
+	waiter->up = true;
+	wake_q_add(&wake_q, waiter->task);
+unlock:
 	raw_spin_unlock_irqrestore(&sem->lock, flags);
+
+	wake_up_q(&wake_q);
 }
 EXPORT_SYMBOL(up);
 
@@ -252,12 +261,3 @@ static noinline int __sched __down_timeout(struct semaphore *sem, long timeout)
 {
 	return __down_common(sem, TASK_UNINTERRUPTIBLE, timeout);
 }
-
-static noinline void __sched __up(struct semaphore *sem)
-{
-	struct semaphore_waiter *waiter = list_first_entry(&sem->wait_list,
-						struct semaphore_waiter, list);
-	list_del(&waiter->list);
-	waiter->up = true;
-	wake_up_process(waiter->task);
-}
