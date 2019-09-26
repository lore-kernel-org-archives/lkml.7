Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9C3C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E98B222BE
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TmWMbgV6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfIZJeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 05:34:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52830 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfIZJeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 05:34:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IgpJgxzcHm9XDmS7YEzGLjkHhdNQdLD97J3rDH2Q9Ak=; b=TmWMbgV6adMAABVj339Y5jtJY
        HUOQcd4sjVe5CWDqhQE6HX2GgHIlBA3W+70BeUOrgH6G0/POHHylLvjuPBjK5DTbZ6qqzc0jSU+F5
        mf3wrbVoXWXR5KCQqyMbc2GH1Dg5wfAIjdkU988bAOKtbVYYZCFbwc2FNDl5odN9WMiiFl2HGdRmv
        LarQc2hoWemRsb/FBFwJ8adGp3RnJiNWJ1r6jubm9Bm9DPJWPaX1I5qxQcLLNmdkj06XVZKobij5S
        Qc1XujsxCMrniwPKAO+ejLpdDe+CTCS55SmEibX7z34cKG2dT8HgY8Nhu/8g+XnlVMEq1NNf+tpZp
        F0On/lYog==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iDQAA-0002Yp-2l; Thu, 26 Sep 2019 09:34:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7ABBC30589D;
        Thu, 26 Sep 2019 11:33:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9FD1A2013B759; Thu, 26 Sep 2019 11:34:10 +0200 (CEST)
Date:   Thu, 26 Sep 2019 11:34:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mathieu Malaterre <malat@debian.org>,
        Davidlohr Bueso <dave@stgolabs.net>, manfred@colorfullife.com
Subject: Re: [PATCH] ipc/sem: Fix race between to-be-woken task and waker
Message-ID: <20190926093410.GJ4553@hirez.programming.kicks-ass.net>
References: <20190920155402.28996-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920155402.28996-1-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 11:54:02AM -0400, Waiman Long wrote:
> While looking at a customr bug report about potential missed wakeup in
> the system V semaphore code, I spot a potential problem.  The fact that
> semaphore waiter stays in TASK_RUNNING state while checking queue status
> may lead to missed wakeup if a spurious wakeup happens in the right
> moment as try_to_wake_up() will do nothing if the task state isn't right.
> 
> To eliminate this possibility, the task state is now reset to
> TASK_INTERRUPTIBLE immediately after wakeup before checking the queue
> status. This should eliminate the race condition on the interaction
> between the queue status and the task state and fix the potential missed
> wakeup problem.

Bah, this code always makes my head hurt.

Yes, AFAICT the pattern it uses has been broken since 0a2b9d4c7967,
since that removed doing the actual wakeup from under the sem_lock(),
which is what it relies on.

> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  ipc/sem.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/ipc/sem.c b/ipc/sem.c
> index 7da4504bcc7c..1bcd424be047 100644
> --- a/ipc/sem.c
> +++ b/ipc/sem.c
> @@ -2146,11 +2146,11 @@ static long do_semtimedop(int semid, struct sembuf __user *tsops,
>  		sma->complex_count++;
>  	}
>  
> +	__set_current_state(TASK_INTERRUPTIBLE);

This can use a comment; this relies on the fact that this is in the
same sem_lock() section that added us to the queue.

>  	do {
>  		WRITE_ONCE(queue.status, -EINTR);
>  		queue.sleeper = current;
>  
> -		__set_current_state(TASK_INTERRUPTIBLE);
>  		sem_unlock(sma, locknum);
>  		rcu_read_unlock();
>  
> @@ -2159,6 +2159,24 @@ static long do_semtimedop(int semid, struct sembuf __user *tsops,
>  		else
>  			schedule();
>  
> +		/*
> +		 * A spurious wakeup at the right moment can cause race
> +		 * between the to-be-woken task and the waker leading to
> +		 * missed wakeup. Setting state back to TASK_INTERRUPTIBLE
> +		 * before checking queue.status will ensure that the race
> +		 * won't happen.
> +		 *
> +		 *	CPU0				CPU1
> +		 *
> +		 *  <spurious wakeup>		wake_up_sem_queue_prepare():
> +		 *  state = TASK_INTERRUPTIBLE    status = error
> +		 *				try_to_wake_up():
> +		 *  smp_mb()			  smp_mb()
> +		 *  if (status == -EINTR)	  if (!(p->state & state))
> +		 *    schedule()		    goto out
> +		 */
> +		set_current_state(TASK_INTERRUPTIBLE);
> +
>  		/*
>  		 * fastpath: the semop has completed, either successfully or
>  		 * not, from the syscall pov, is quite irrelevant to us at this
> @@ -2210,6 +2228,7 @@ static long do_semtimedop(int semid, struct sembuf __user *tsops,
>  	sem_unlock(sma, locknum);
>  	rcu_read_unlock();
>  out_free:
> +	__set_current_state(TASK_RUNNING);
>  	if (sops != fast_sops)
>  		kvfree(sops);
>  	return error;
> -- 
> 2.18.1
> 
