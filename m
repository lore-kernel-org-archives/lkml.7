Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12728C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 19:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBAD921D7F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 19:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574192311;
	bh=x+LXJDSXbRwcDrTH4cs98Hy1yNN8huFUYkaCicbVnro=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=QPWgeUmODp9oGC1yO15PeCljvsRgeTJiI7y0LI7cy9JzdaKIwD91swj0C8kPOcT7w
	 3XA+D0S4QeMoy49l9N6H14P3uBvtC+X2KYtO9yuP0vQqA/jlPZFUB729lj1hiOrkSe
	 e5pY7nGfeh2E7gNYYx2NqqMOGzGergqFajRllG+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfKSTia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 14:38:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:41258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726836AbfKSTi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 14:38:29 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [199.201.64.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24E412186D;
        Tue, 19 Nov 2019 19:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574192308;
        bh=x+LXJDSXbRwcDrTH4cs98Hy1yNN8huFUYkaCicbVnro=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=V2sF2OoRgtaO2uWvugrC84bX6d9WnU7x1dwdvdr23QvkKB7YVxK1ILU/kxI4ZWJxh
         utE1gFOXb4YQ8zIn0uDmm4lt75QT35Ok0IRBnGkxcxse34sUcYh9Z8YBulAbm6Zv+I
         7z5PyBIGPNCL4HW4kiNh2+xyRnR5CVOGWpfuUYp4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 821CE3520FA7; Tue, 19 Nov 2019 11:38:27 -0800 (PST)
Date:   Tue, 19 Nov 2019 11:38:27 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        gkohli@codeaurora.org, prsood@codeaurora.org,
        pkondeti@codeaurora.org, rcu@vger.kernel.org
Subject: Re: [PATCH v2] rcu: Fix missed wakeup of exp_wq waiters
Message-ID: <20191119193827.GB2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <0101016e81a9ecb9-ce4a6425-f21d-4166-96ed-32d3700717f1-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0101016e81a9ecb9-ce4a6425-f21d-4166-96ed-32d3700717f1-000000@us-west-2.amazonses.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 03:17:07AM +0000, Neeraj Upadhyay wrote:
> For the tasks waiting in exp_wq inside exp_funnel_lock(),
> there is a chance that they might be indefinitely blocked
> in below scenario:
> 
> 1. There is a task waiting on exp sequence 0b'100' inside
>    exp_funnel_lock(). This task blocks at wq index 1.
> 
>    synchronize_rcu_expedited()
>      s = 0b'100'
>      exp_funnel_lock()
>        wait_event(rnp->exp_wq[rcu_seq_ctr(s) & 0x3]
> 
> 2. The expedited grace period (which above task blocks for)
>    completes and task (task1) holding exp_mutex queues
>    worker and schedules out.
> 
>    synchronize_rcu_expedited()
>      s = 0b'100'
>      queue_work(rcu_gp_wq, &rew.rew_work)
>        wake_up_worker()
>          schedule()
> 
> 3. kworker A picks up the queued work and completes the exp gp
>    sequence and then blocks on exp_wake_mutex, which is held
>    by another kworker, which is doing wakeups for expedited_sequence
>    0.
> 
>    rcu_exp_wait_wake()
>      rcu_exp_wait_wake()
>        rcu_exp_gp_seq_end(rsp) // rsp->expedited_sequence is incremented
>                                // to 0b'100'
>        mutex_lock(&rcu_state.exp_wake_mutex)
> 
> 4. task1 does not enter wait queue, as sync_exp_work_done() returns true,
>    and releases exp_mutex.
> 
>    wait_event(rnp->exp_wq[rcu_seq_ctr(s) & 0x3],
>      sync_exp_work_done(rsp, s));
>    mutex_unlock(&rsp->exp_mutex);
> 
> 5. Next exp GP completes, and sequence number is incremented:
> 
>    rcu_exp_wait_wake()
>      rcu_exp_wait_wake()
>        rcu_exp_gp_seq_end(rsp) // rsp->expedited_sequence = 0b'200'
> 
> 6. kworker A acquires exp_wake_mutex. As it uses current
>    expedited_sequence, it wakes up workers from wrong wait queue
>    index - it should have worken wait queue corresponding to
>    0b'100' sequence, but wakes up the ones for 0b'200' sequence.
>    This results in task at step 1 indefinitely blocked.
> 
>    rcu_exp_wait_wake()
>      wake_up_all(&rnp->exp_wq[rcu_seq_ctr(rsp->expedited_sequence) & 0x3]);
> 
> This issue manifested as DPM device timeout during suspend, as scsi
> device was stuck in _synchronize_rcu_expedited().
> 
> schedule()
> synchronize_rcu_expedited()
> synchronize_rcu()
> scsi_device_quiesce()
> scsi_bus_suspend()
> dpm_run_callback()
> __device_suspend()
> 
> Fix this by using the correct exp sequence number, the one which
> owner of the exp_mutex initiated and passed to kworker,
> to index the wait queue, inside rcu_exp_wait_wake().
> 
> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>

Queued, thank you!

I reworked the commit message to make it easier to follow the sequence
of events.  Please see below and let me know if I messed anything up.

							Thanx, Paul

------------------------------------------------------------------------

commit d887fd2a66861f51ed93b5dde894b9646a5569dd
Author: Neeraj Upadhyay <neeraju@codeaurora.org>
Date:   Tue Nov 19 03:17:07 2019 +0000

    rcu: Fix missed wakeup of exp_wq waiters
    
    Tasks waiting within exp_funnel_lock() for an expedited grace period to
    elapse can be starved due to the following sequence of events:
    
    1.      Tasks A and B both attempt to start an expedited grace
            period at about the same time.  This grace period will have
            completed when the lower four bits of the rcu_state structure's
            ->expedited_sequence field are 0b'0100', for example, when the
            initial value of this counter is zero.  Task A wins, and thus
            does the actual work of starting the grace period, including
            acquiring the rcu_state structure's .exp_mutex and sets the
            counter to 0b'0001'.
    
    2.      Because task B lost the race to start the grace period, it
            waits on ->expedited_sequence to reach 0b'0100' inside of
            exp_funnel_lock(). This task therefore blocks on the rcu_node
            structure's ->exp_wq[1] field, keeping in mind that the
            end-of-grace-period value of ->expedited_sequence (0b'0100')
            is shifted down two bits before indexing the ->exp_wq[] field.
    
    3.      Task C attempts to start another expedited grace period,
            but blocks on ->exp_mutex, which is still held by Task A.
    
    4.      The aforementioned expedited grace period completes, so that
            ->expedited_sequence now has the value 0b'0100'.  A kworker task
            therefore acquires the rcu_state structure's ->exp_wake_mutex
            and starts awakening any tasks waiting for this grace period.
    
    5.      One of the first tasks awakened happens to be Task A.  Task A
            therefore releases the rcu_state structure's ->exp_mutex,
            which allows Task C to start the next expedited grace period,
            which causes the lower four bits of the rcu_state structure's
            ->expedited_sequence field to become 0b'0101'.
    
    6.      Task C's expedited grace period completes, so that the lower four
            bits of the rcu_state structure's ->expedited_sequence field now
            become 0b'1000'.
    
    7.      The kworker task from step 4 above continues its wakeups.
            Unfortunately, the wake_up_all() refetches the rcu_state
            structure's .expedited_sequence field:
    
            wake_up_all(&rnp->exp_wq[rcu_seq_ctr(rcu_state.expedited_sequence) & 0x3]);
    
            This results in the wakeup being applied to the rcu_node
            structure's ->exp_wq[2] field, which is unfortunate given that
            Task B is instead waiting on ->exp_wq[1].
    
    On a busy system, no harm is done (or at least no permanent harm is done).
    Some later expedited grace period will redo the wakeup.  But on a quiet
    system, such as many embedded systems, it might be a good long time before
    there was another expedited grace period.  On such embedded systems,
    this situation could therefore result in a system hang.
    
    This issue manifested as DPM device timeout during suspend (which
    usually qualifies as a quiet time) due to a SCSI device being stuck in
    _synchronize_rcu_expedited(), with the following stack trace:
    
            schedule()
            synchronize_rcu_expedited()
            synchronize_rcu()
            scsi_device_quiesce()
            scsi_bus_suspend()
            dpm_run_callback()
            __device_suspend()
    
    This commit therefore prevents such delays, timeouts, and hangs by
    making rcu_exp_wait_wake() use its "s" argument consistently instead of
    refetching from rcu_state.expedited_sequence.
    
    Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 6ce598d..4433d00a 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -557,7 +557,7 @@ static void rcu_exp_wait_wake(unsigned long s)
 			spin_unlock(&rnp->exp_lock);
 		}
 		smp_mb(); /* All above changes before wakeup. */
-		wake_up_all(&rnp->exp_wq[rcu_seq_ctr(rcu_state.expedited_sequence) & 0x3]);
+		wake_up_all(&rnp->exp_wq[rcu_seq_ctr(s) & 0x3]);
 	}
 	trace_rcu_exp_grace_period(rcu_state.name, s, TPS("endwake"));
 	mutex_unlock(&rcu_state.exp_wake_mutex);
