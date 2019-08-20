Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F5BC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C97214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566307622;
	bh=1hPEl4SSmvnbgbuDJZCUpRpxFHYm3yfVh4Ax14pHbdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eAeYrdd4zkdJiKyD1jK5ssmKM56hYY01ABtizp4XRzjGNjupsCAMUG4NqfFbKHRF1
	 ILzRfIpOglK0ZUuon66coqpodogukOLDqTwDN33XAiF2qePbP547vJWskiewqrGvNA
	 BNPgTDGTZvJt04yxQHZE548zldO6+vY7hVnFyK74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbfHTN1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:27:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:59958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728248AbfHTN1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:27:01 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 288EA22CF7;
        Tue, 20 Aug 2019 13:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566307619;
        bh=1hPEl4SSmvnbgbuDJZCUpRpxFHYm3yfVh4Ax14pHbdE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CzLou++RPTmg8Flwf+H4cChKWdWqcZJRRrM8hWhQfdWaqDui13XXhkIAKqC7Joy3Q
         b4jwONxz/qBlE8R75HdqEYaGO2PipYoomdWLVGqJoonKR3y5QFOozzAYRVTTG1BDbD
         W10CPMkeWpl42y2j9nwzRD8VX3dGkX5jCprdUDG0=
Date:   Tue, 20 Aug 2019 15:26:57 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     bigeasy@linutronix.de, peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, anna-maria@linutronix.de,
        tglx@linutronix.de, hpa@zytor.com
Cc:     linux-tip-commits@vger.kernel.org
Subject: Re: [tip:timers/core] hrtimer: Prepare support for PREEMPT_RT
Message-ID: <20190820132656.GC2093@lenoir>
References: <20190726185753.737767218@linutronix.de>
 <tip-f61eff83cec9cfab31fd30a2ca8856be379cdcd5@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-f61eff83cec9cfab31fd30a2ca8856be379cdcd5@git.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 12:04:03PM -0700, tip-bot for Anna-Maria Gleixner wrote:
> Commit-ID:  f61eff83cec9cfab31fd30a2ca8856be379cdcd5
> Gitweb:     https://git.kernel.org/tip/f61eff83cec9cfab31fd30a2ca8856be379cdcd5
> Author:     Anna-Maria Gleixner <anna-maria@linutronix.de>
> AuthorDate: Fri, 26 Jul 2019 20:30:59 +0200
> Committer:  Thomas Gleixner <tglx@linutronix.de>
> CommitDate: Thu, 1 Aug 2019 20:51:22 +0200
> 
> hrtimer: Prepare support for PREEMPT_RT
> 
> When PREEMPT_RT is enabled, the soft interrupt thread can be preempted.  If
> the soft interrupt thread is preempted in the middle of a timer callback,
> then calling hrtimer_cancel() can lead to two issues:
> 
>   - If the caller is on a remote CPU then it has to spin wait for the timer
>     handler to complete. This can result in unbound priority inversion.
> 
>   - If the caller originates from the task which preempted the timer
>     handler on the same CPU, then spin waiting for the timer handler to
>     complete is never going to end.

[...]
> +/*
> + * This function is called on PREEMPT_RT kernels when the fast path
> + * deletion of a timer failed because the timer callback function was
> + * running.
> + *
> + * This prevents priority inversion, if the softirq thread on a remote CPU
> + * got preempted, and it prevents a life lock when the task which tries to
> + * delete a timer preempted the softirq thread running the timer callback
> + * function.
> + */
> +void hrtimer_cancel_wait_running(const struct hrtimer *timer)
> +{
> +	struct hrtimer_clock_base *base = timer->base;
> +
> +	if (!timer->is_soft || !base || !base->cpu_base) {
> +		cpu_relax();
> +		return;
> +	}
> +
> +	/*
> +	 * Mark the base as contended and grab the expiry lock, which is
> +	 * held by the softirq across the timer callback. Drop the lock
> +	 * immediately so the softirq can expire the next timer. In theory
> +	 * the timer could already be running again, but that's more than
> +	 * unlikely and just causes another wait loop.
> +	 */
> +	atomic_inc(&base->cpu_base->timer_waiters);
> +	spin_lock_bh(&base->cpu_base->softirq_expiry_lock);
> +	atomic_dec(&base->cpu_base->timer_waiters);
> +	spin_unlock_bh(&base->cpu_base->softirq_expiry_lock);
> +}

So, while reviewing the posix timers series, I stumbled upon timer_wait_running() which
lacked any explanation, which led me to hrtimer_cancel_wait_running() that was
a bit more helpful but still had blurry explanation.

In the end I found the approrpiate infomation in this commit changelog.
It might be helpful for future reviewers to apply this:

---
From ef9a4d87b6e7c43899248c376c5959f4e0bcd309 Mon Sep 17 00:00:00 2001
From: Frederic Weisbecker <frederic@kernel.org>
Date: Tue, 20 Aug 2019 15:12:23 +0200
Subject: [PATCH] hrtimer: Improve comments on handling priority inversion
 against softirq kthread

The handling of a priority inversion between timer cancelling and a
a not well defined possible preemption of softirq kthread is not very
clear. Especially in the posix timers side where we don't even know why
there is a specific RT wait callback.

All the nice explanations can be found in the initial changelog of
f61eff83cec9cfab31fd30a2ca8856be379cdcd5
(hrtimer: Prepare support for PREEMPT_RT"). So lets extract the detailed
informations from there.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/hrtimer.c      | 14 ++++++++++----
 kernel/time/posix-timers.c |  5 +++++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 499122752649..833353732554 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1201,10 +1201,16 @@ static void hrtimer_sync_wait_running(struct hrtimer_cpu_base *cpu_base,
  * deletion of a timer failed because the timer callback function was
  * running.
  *
- * This prevents priority inversion, if the softirq thread on a remote CPU
- * got preempted, and it prevents a life lock when the task which tries to
- * delete a timer preempted the softirq thread running the timer callback
- * function.
+ * This prevents priority inversion: if the soft irq thread is preempted
+ * in the middle of a timer callback, then calling del_timer_sync() can
+ * lead to two issues:
+ *
+ *  - If the caller is on a remote CPU then it has to spin wait for the timer
+ *    handler to complete. This can result in unbound priority inversion.
+ *
+ *  - If the caller originates from the task which preempted the timer
+ *    handler on the same CPU, then spin waiting for the timer handler to
+ *    complete is never going to end.
  */
 void hrtimer_cancel_wait_running(const struct hrtimer *timer)
 {
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index a71c1aab071c..f6713a41e4e0 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -806,6 +806,11 @@ static int common_hrtimer_try_to_cancel(struct k_itimer *timr)
 }
 
 #ifdef CONFIG_PREEMPT_RT
+/*
+ * Prevent from priority inversion against softirq kthread in case
+ * it gets preempted while executing an htimer callback. See
+ * comments in hrtimer_cancel_wait_running.
+ */
 static struct k_itimer *timer_wait_running(struct k_itimer *timer,
 					   unsigned long *flags)
 {
-- 
2.21.0



