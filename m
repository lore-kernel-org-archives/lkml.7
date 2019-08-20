Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08589C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBAC122DBF
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566311223;
	bh=jn5EIQYTfnL7kT2uFRexp3uroFZFJi3/TChlzHDffOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X/KC0pOGeRhtiBCtIjHQxlr9WDrWe6O6vMGzfZdWTXW+zznnT3QJE9ERAeDNvl624
	 5kvDmcWm1yH6Du3VR8lcTBflmSgRM15ri+o5OYNd2EJfU1U2lPVyohPmfhu3Bck4hH
	 pV9cDIwVUPORiLfbJNO8cpv9N0U3wHp+IjZzWgrs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbfHTO1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 10:27:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729137AbfHTO1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:27:02 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B6D020673;
        Tue, 20 Aug 2019 14:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566311222;
        bh=jn5EIQYTfnL7kT2uFRexp3uroFZFJi3/TChlzHDffOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sPgETCJJQlPAnebI++BWzP6UA3XCG0c/Q8AyImpS039QWzdEBJNWHkjMTLHYT4iiT
         5uqA5NRKW6jwFTjLbBjHp4ze1nvwCOCsEKN3+Myusssj2iO2lqLOyJqu2dOqoAZPdR
         aWssNAj1tVRe/r6FmBmDrFCYpI/GosdMjsOm4WxU=
Date:   Tue, 20 Aug 2019 16:26:59 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [patch 04/44] posix-cpu-timers: Fixup stale comment
Message-ID: <20190820142658.GG2093@lenoir>
References: <20190819143141.221906747@linutronix.de>
 <20190819143801.747233612@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819143801.747233612@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 04:31:45PM +0200, Thomas Gleixner wrote:
> The comment above cleanup_timers() is outdated. The timers are only removed
> from the task/process list heads but not modified in any other way.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/time/posix-cpu-timers.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> --- a/kernel/time/posix-cpu-timers.c
> +++ b/kernel/time/posix-cpu-timers.c
> @@ -412,9 +412,10 @@ static void cleanup_timers_list(struct l
>  }
>  
>  /*
> - * Clean out CPU timers still ticking when a thread exited.  The task
> - * pointer is cleared, and the expiry time is replaced with the residual
> - * time for later timer_gettime calls to return.
> + * Clean out CPU timers which are still armed when a thread exits. The
> + * timers are only removed from the list. No other updates are done. The
> + * corresponding posix timers are still accessible, but cannot be rearmed.
> + *
>   * This must be called with the siglock held.
>   */
>  static void cleanup_timers(struct list_head *head)

Indeed and I believe we could avoid that step. We remove the sighand at the same
time so those can't be accessed anymore anyway.

exit_itimers() takes care of the last call release and could force remove from
the list (although it might be taken care of in your series, haven't checked yet):

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 0a426f4e3125..f8f4a07025fd 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -383,11 +383,7 @@ static int posix_cpu_timer_del(struct k_itimer *timer)
 	 */
 	sighand = lock_task_sighand(p, &flags);
 	if (unlikely(sighand == NULL)) {
-		/*
-		 * We raced with the reaping of the task.
-		 * The deletion should have cleared us off the list.
-		 */
-		WARN_ON_ONCE(!list_empty(&timer->it.cpu.entry));
+		list_del(&timer->it.cpu.entry);
 	} else {
 		if (timer->it.cpu.firing)
 			ret = TIMER_RETRY;


Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
