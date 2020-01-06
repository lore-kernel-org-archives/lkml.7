Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC7AC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F9ED2081E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578326035;
	bh=q26J3QlY/73GTjSeqGt5ILPslc/aboevqBOVHLOibYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Hhqf2+85b+hqj3r0WD+5jqMcb7urdvjBXAC+68UopfLOM+gmTN6fuoER5yw6/cGRS
	 aFpRrl8qxjQCc8y4qvEigcTUOwoTsvC5/t7iSvP9nI037oeuSG7R/kFL+4TUWvAtuk
	 l8cPzH2exSLzVFM5sI72nTDnQPy2TnUnijqDZdqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgAFPxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 10:53:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:55444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgAFPxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 10:53:54 -0500
Received: from localhost (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42C6420731;
        Mon,  6 Jan 2020 15:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578326033;
        bh=q26J3QlY/73GTjSeqGt5ILPslc/aboevqBOVHLOibYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=14tfk//wuGRjLmzbUK3Hwb4vnfxssFK6IMlPhrZvwrfZa/e8FiN7S/acqsUY0hF+x
         Hx+SVgoCjRuqc+tVTRLm1B3LpUc9tjfX4W5oMre9X9a7u14+1WLQCMPlh85/FaRtg6
         vzGMXX4sNqVfiCaxiwv3K3wwpFBNy8r+CJIrK/vo=
Date:   Mon, 6 Jan 2020 16:53:51 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] sched/cputime: code cleanup in
 irqtime_account_process_tick
Message-ID: <20200106155350.GB26097@lenoir>
References: <1577959674-255537-1-git-send-email-alex.shi@linux.alibaba.com>
 <1577959674-255537-2-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577959674-255537-2-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2020 at 06:07:53PM +0800, Alex Shi wrote:
> In this func, since account_system_time() considers guest time account
> and other system time.  we could fold the account_guest_time into
> account_system_time() to simply the code.
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Frederic Weisbecker <fweisbec@gmail.com>
> Cc: Wanpeng Li <wanpeng.li@hotmail.com>
> Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-kernel@vger.kernel.org
> ---
>  kernel/sched/cputime.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index cff3e656566d..46b837e94fce 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -381,13 +381,10 @@ static void irqtime_account_process_tick(struct task_struct *p, int user_tick,
>  		account_system_index_time(p, cputime, CPUTIME_SOFTIRQ);
>  	} else if (user_tick) {
>  		account_user_time(p, cputime);
> -	} else if (p == this_rq()->idle) {
> +	} else if ((p != this_rq()->idle) || (irq_count() != HARDIRQ_OFFSET))
> +		account_system_time(p, HARDIRQ_OFFSET, cputime);
> +	else

I fear we can't really play the exact same game as account_process_tick() here.
Since this is irqtime precise accounting, we have already computed the
irqtime delta in account_other_time() (or we will at some point in the future)
and substracted it from the ticks to account. This means that the remaining cputime
to account has to be either utime/stime/gtime/idle-time but not interrupt time, or
we may account interrupt time twice. And account_system_time() tries to account
irq time, for example if we interrupt a softirq.

Thanks.


>  		account_idle_time(cputime);
> -	} else if (p->flags & PF_VCPU) { /* System time or guest time */
> -		account_guest_time(p, cputime);
> -	} else {
> -		account_system_index_time(p, cputime, CPUTIME_SYSTEM);
> -	}
>  }
>  
>  static void irqtime_account_idle_ticks(int ticks)
> -- 
> 1.8.3.1
> 
