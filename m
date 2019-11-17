Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1794CC432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 23:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E61E320730
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 23:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574032543;
	bh=D2RyGGI4kf5oyf75rDRe1iQ+snJQeX3sBq0XIFYSzxo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=B5Zw2Hxw/FiK2vZm6ak1wKEG9YyGvU3aHHvlLcs7cITglscVpJYowlYc1dcuQLTdj
	 LbMfu615Vmquh+z7bCgsxgpGi31PyGxFN7W9NA77lzrqxL/yv0PXyPVS44egh9eZ0v
	 H+IL1+gcAYxPlXQZi+xmXy34SnsP78ci1GyDc8Z0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfKQXPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 18:15:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:55910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbfKQXPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 18:15:41 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BD1420729;
        Sun, 17 Nov 2019 23:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574032539;
        bh=D2RyGGI4kf5oyf75rDRe1iQ+snJQeX3sBq0XIFYSzxo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BKS6+E1HOzOevh27LSyAl0FDDeAg8lL2JL7hQTHlvva/5EdYVQxkXpNMLNOphHr7l
         2yqUcC5J9YYU/gJg2jNjIA1BAQ0Db6yl3dpZGtsBAjTAYxbuVgmJwjOU96a1FpCJr2
         g0NflupZ2ygbp/tj+BKYmR2Bn6oMBlhkoyQynmiM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 64C853522859; Sun, 17 Nov 2019 13:36:24 -0800 (PST)
Date:   Sun, 17 Nov 2019 13:36:24 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     josh@joshtriplett.org, joel@joelfernandes.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        pkondeti@codeaurora.org, prsood@codeaurora.org,
        gkohli@codeaurora.org
Subject: Re: [PATCH] rcu: Fix missed wakeup of exp_wq waiters
Message-ID: <20191117213624.GB2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <1573838894-23027-1-git-send-email-neeraju@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573838894-23027-1-git-send-email-neeraju@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 10:58:14PM +0530, Neeraj Upadhyay wrote:
> For the tasks waiting in exp_wq inside exp_funnel_lock(),
> there is a chance that they might be indefinitely blocked
> in below scenario:
> 
> 1. There is a task waiting on exp sequence 0b'100' inside
>    exp_funnel_lock().
> 
>    _synchronize_rcu_expedited()

This symbol went away a few versions back, but let's see how this
plays out in current -rcu.

>      s = 0b'100
>      exp_funnel_lock()
>        wait_event(rnp->exp_wq[rcu_seq_ctr(s) & 0x3]

All of the above could still happen if the expedited grace
period number was zero (or a bit less) when that task invoked
synchronize_rcu_expedited().  What is the relation, if any,
between this task and "task1" below?  Seems like you want them to
be different tasks.

Does this task actually block, or is it just getting ready
to block?  Seems like you need it to have actually blocked.

> 2. The Exp GP completes and task (task1) holding exp_mutex queues
>    worker and schedules out.

"The Exp GP" being the one that was initiated when the .expedited_sequence
counter was zero, correct?  (Looks that way below.)

>    _synchronize_rcu_expedited()
>      s = 0b'100
>      queue_work(rcu_gp_wq, &rew.rew_work)
>        wake_up_worker()
>          schedule()
> 
> 3. kworker A picks up the queued work and completes the exp gp
>    sequence.
> 
>    rcu_exp_wait_wake()
>      rcu_exp_wait_wake()
>        rcu_exp_gp_seq_end(rsp) // rsp->expedited_sequence is incremented
>                                // to 0b'100'
> 
> 4. task1 does not enter wait queue, as sync_exp_work_done() returns true,
>    and releases exp_mutex.
> 
>    wait_event(rnp->exp_wq[rcu_seq_ctr(s) & 0x3],
>      sync_exp_work_done(rsp, s));
>    mutex_unlock(&rsp->exp_mutex);

So task1 is the one that initiated the expedited grace period that
started when .expedited_sequence was zero, right?

> 5. Next exp GP completes, and sequence number is incremented:
> 
>    rcu_exp_wait_wake()
>      rcu_exp_wait_wake()
>        rcu_exp_gp_seq_end(rsp) // rsp->expedited_sequence = 0b'200'
> 
> 6. As kworker A uses current expedited_sequence, it wakes up workers
>    from wrong wait queue index - it should have worken wait queue
>    corresponding to 0b'100' sequence, but wakes up the ones for
>    0b'200' sequence. This results in task at step 1 indefinitely blocked.
> 
>    rcu_exp_wait_wake()
>      wake_up_all(&rnp->exp_wq[rcu_seq_ctr(rsp->expedited_sequence) & 0x3]);

So the issue is that the next expedited RCU grace period might
have completed before the completion of the wakeups for the previous
expedited RCU grace period, correct?  Then expedited grace periods have
to have stopped to prevent any future wakeup from happening, correct?
(Which would make it harder for rcutorture to trigger this, though it
really does have code that attempts to trigger this sort of thing.)

Is this theoretical in nature, or have you actually triggered it?
If actually triggered, what did you do to make this happen?
What have you done to test the change?

(Using a WARN_ON() to check for the lower bits of the counter portion
of rcu_state.expedited_sequence differing from the same bits of s
would be one way to detect this problem.)

							Thanx, Paul

> Fix this by using the correct sequence number for wake_up_all() inside
> rcu_exp_wait_wake().
> 
> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> ---
>  kernel/rcu/tree_exp.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index e4b77d3..28979d3 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -557,7 +557,7 @@ static void rcu_exp_wait_wake(unsigned long s)
>  			spin_unlock(&rnp->exp_lock);
>  		}
>  		smp_mb(); /* All above changes before wakeup. */
> -		wake_up_all(&rnp->exp_wq[rcu_seq_ctr(rcu_state.expedited_sequence) & 0x3]);
> +		wake_up_all(&rnp->exp_wq[rcu_seq_ctr(s) & 0x3]);
>  	}
>  	trace_rcu_exp_grace_period(rcu_state.name, s, TPS("endwake"));
>  	mutex_unlock(&rcu_state.exp_wake_mutex);
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
> member of the Code Aurora Forum, hosted by The Linux Foundation
> 
