Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF02C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 04:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70EC822319
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 04:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574136337;
	bh=MZpsuPMjvYoV2kfWNP9HT35y4TsKlILZ8/jKiu9aWw0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=mbKojtAN4on0Apxlh/AU1M8njR7Zno3UruWriHeoP609Srhu9zsunAE311ZNaLUFK
	 IeftBIB4txM2Z1UiF1ZHAZ7QP7lKS6BUC5pAJGqzTYGZVwCvk9OUijn2D1aWGGsTv5
	 Vck0x5axRjjblHUP6ajwbLt9qZJmS1HCgmZORJzU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfKSEFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 23:05:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:33166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727217AbfKSEFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 23:05:36 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5542B22316;
        Tue, 19 Nov 2019 04:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574136334;
        bh=MZpsuPMjvYoV2kfWNP9HT35y4TsKlILZ8/jKiu9aWw0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=rzs9k6oOigkkByVbTXoftL+Ml54IKUDNnieyqPPZWjUPR9vSjOBO3YvY1H1DJ1xSW
         ROTDqOx+Zh8AkH7xo8ih4iHXVTwRBy6SaEjyzD6vIkKA+sxLW9J684A+eDh8wK2d9G
         FaAdtdokPTMs0CN51H1jK0fNX60f6OQd0pJTi6A0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E2C6E35227AF; Mon, 18 Nov 2019 20:05:33 -0800 (PST)
Date:   Mon, 18 Nov 2019 20:05:33 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     josh@joshtriplett.org, joel@joelfernandes.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        pkondeti@codeaurora.org, prsood@codeaurora.org,
        gkohli@codeaurora.org
Subject: Re: [PATCH] rcu: Fix missed wakeup of exp_wq waiters
Message-ID: <20191119040533.GS2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <1573838894-23027-1-git-send-email-neeraju@codeaurora.org>
 <20191117213624.GB2889@paulmck-ThinkPad-P72>
 <0101016e7dd7b824-50600058-ab5e-44d8-8d24-94cf095f1783-000000@us-west-2.amazonses.com>
 <20191118150856.GN2889@paulmck-ThinkPad-P72>
 <0101016e7f644106-90b40f19-ba9e-4974-bdbe-1062b52222a2-000000@us-west-2.amazonses.com>
 <20191118172401.GO2889@paulmck-ThinkPad-P72>
 <0101016e81ba8865-028ac62b-3fcd-481b-b657-be8519c4edf5-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0101016e81ba8865-028ac62b-3fcd-481b-b657-be8519c4edf5-000000@us-west-2.amazonses.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 03:35:15AM +0000, Neeraj Upadhyay wrote:
> Hi Paul,
> 
> On 11/18/2019 10:54 PM, Paul E. McKenney wrote:
> > On Mon, Nov 18, 2019 at 04:41:47PM +0000, Neeraj Upadhyay wrote:
> > > Hi Paul,
> > > 
> > > 
> > > On 11/18/2019 8:38 PM, Paul E. McKenney wrote:
> > > > On Mon, Nov 18, 2019 at 09:28:39AM +0000, Neeraj Upadhyay wrote:
> > > > > Hi Paul,
> > > > > 
> > > > > On 11/18/2019 3:06 AM, Paul E. McKenney wrote:
> > > > > > On Fri, Nov 15, 2019 at 10:58:14PM +0530, Neeraj Upadhyay wrote:
> > > > > > > For the tasks waiting in exp_wq inside exp_funnel_lock(),
> > > > > > > there is a chance that they might be indefinitely blocked
> > > > > > > in below scenario:
> > > > > > > 
> > > > > > > 1. There is a task waiting on exp sequence 0b'100' inside
> > > > > > >       exp_funnel_lock().
> > > > > > > 
> > > > > > >       _synchronize_rcu_expedited()
> > > > > > 
> > > > > > This symbol went away a few versions back, but let's see how this
> > > > > > plays out in current -rcu.
> > > > > > 
> > > > > 
> > > > > Sorry; for us this problem is observed on 4.19 stable version; I had
> > > > > checked against the -rcu code, and the relevant portions were present
> > > > > there.
> > > > > 
> > > > > > >         s = 0b'100
> > > > > > >         exp_funnel_lock()
> > > > > > >           wait_event(rnp->exp_wq[rcu_seq_ctr(s) & 0x3]
> > > > > > 
> > > > > > All of the above could still happen if the expedited grace
> > > > > > period number was zero (or a bit less) when that task invoked
> > > > > 
> > > > > Yes
> > > > > 
> > > > > > synchronize_rcu_expedited().  What is the relation, if any,
> > > > > > between this task and "task1" below?  Seems like you want them to
> > > > > > be different tasks.
> > > > > > 
> > > > > 
> > > > > This task is the one which is waiting for the expedited sequence, which
> > > > > "task1" completes ("task1" holds the exp_mutex for it). "task1" would
> > > > > wake up this task, on exp GP completion.
> > > > > 
> > > > > > Does this task actually block, or is it just getting ready
> > > > > > to block?  Seems like you need it to have actually blocked.
> > > > > > 
> > > > > 
> > > > > Yes, it actually blocked in wait queue.
> > > > > 
> > > > > > > 2. The Exp GP completes and task (task1) holding exp_mutex queues
> > > > > > >       worker and schedules out.
> > > > > > 
> > > > > > "The Exp GP" being the one that was initiated when the .expedited_sequence
> > > > > > counter was zero, correct?  (Looks that way below.)
> > > > > > 
> > > > > Yes, correct.
> > > > > 
> > > > > > >       _synchronize_rcu_expedited()
> > > > > > >         s = 0b'100
> > > > > > >         queue_work(rcu_gp_wq, &rew.rew_work)
> > > > > > >           wake_up_worker()
> > > > > > >             schedule()
> > > > > > > 
> > > > > > > 3. kworker A picks up the queued work and completes the exp gp
> > > > > > >       sequence.
> > > > > > > 
> > > > > > >       rcu_exp_wait_wake()
> > > > > > >         rcu_exp_wait_wake()
> > > > > > >           rcu_exp_gp_seq_end(rsp) // rsp->expedited_sequence is incremented
> > > > > > >                                   // to 0b'100'
> > > > > > > 
> > > > > > > 4. task1 does not enter wait queue, as sync_exp_work_done() returns true,
> > > > > > >       and releases exp_mutex.
> > > > > > > 
> > > > > > >       wait_event(rnp->exp_wq[rcu_seq_ctr(s) & 0x3],
> > > > > > >         sync_exp_work_done(rsp, s));
> > > > > > >       mutex_unlock(&rsp->exp_mutex);
> > > > > > 
> > > > > > So task1 is the one that initiated the expedited grace period that
> > > > > > started when .expedited_sequence was zero, right?
> > > > > > 
> > > > > 
> > > > > Yes, right.
> > > > > 
> > > > > > > 5. Next exp GP completes, and sequence number is incremented:
> > > > > > > 
> > > > > > >       rcu_exp_wait_wake()
> > > > > > >         rcu_exp_wait_wake()
> > > > > > >           rcu_exp_gp_seq_end(rsp) // rsp->expedited_sequence = 0b'200'
> > > > > > > 
> > > > > > > 6. As kworker A uses current expedited_sequence, it wakes up workers
> > > > > > >       from wrong wait queue index - it should have worken wait queue
> > > > > > >       corresponding to 0b'100' sequence, but wakes up the ones for
> > > > > > >       0b'200' sequence. This results in task at step 1 indefinitely blocked.
> > > > > > > 
> > > > > > >       rcu_exp_wait_wake()
> > > > > > >         wake_up_all(&rnp->exp_wq[rcu_seq_ctr(rsp->expedited_sequence) & 0x3]);
> > > > > > 
> > > > > > So the issue is that the next expedited RCU grace period might
> > > > > > have completed before the completion of the wakeups for the previous
> > > > > > expedited RCU grace period, correct?  Then expedited grace periods have
> > > > > 
> > > > > Yes. Actually from the ftraces, I saw that next expedited RCU grace
> > > > > period completed while kworker A was in D state, while waiting for
> > > > > exp_wake_mutex. This led to kworker A using sequence 2 (instead of 1) for
> > > > > its wake_up_all() call; so, task (point 1) was never woken up, as it was
> > > > > waiting on wq index 1.
> > > > > 
> > > > > > to have stopped to prevent any future wakeup from happening, correct?
> > > > > > (Which would make it harder for rcutorture to trigger this, though it
> > > > > > really does have code that attempts to trigger this sort of thing.)
> > > > > > 
> > > > > > Is this theoretical in nature, or have you actually triggered it?
> > > > > > If actually triggered, what did you do to make this happen?
> > > > > 
> > > > > This issue, we had seen previously - 1 instance in May 2018 (on 4.9 kernel),
> > > > > another instance in Nov 2018 (on 4.14 kernel), in our customer reported
> > > > > issues. Both instances were in downstream drivers and we didn't have RCU
> > > > > traces. Now 2 days back, it was reported on 4.19 kernel, with RCU traces
> > > > > enabled, where it was observed in suspend scenario, where we are observing
> > > > > "DPM device timeout" [1], as scsi device is stuck in
> > > > > _synchronize_rcu_expedited().
> > > > > 
> > > > > schedule+0x70/0x90
> > > > > _synchronize_rcu_expedited+0x590/0x5f8
> > > > > synchronize_rcu+0x50/0xa0
> > > > > scsi_device_quiesce+0x50/0x120
> > > > > scsi_bus_suspend+0x70/0xe8
> > > > > dpm_run_callback+0x148/0x388
> > > > > __device_suspend+0x430/0x8a8
> > > > > 
> > > > > [1]
> > > > > https://github.com/torvalds/linux/blob/master/drivers/base/power/main.c#L489
> > > > > 
> > > > > > What have you done to test the change?
> > > > > > 
> > > > > 
> > > > > I have given this for testing; will share the results . Current analysis
> > > > > and patch is based on going through ftrace and code review.
> > > > 
> > > > OK, very good.  Please include the failure information in the changelog
> > > > of the next version of this patch.
> 
> Done.
> 
> > > > 
> > > > I prefer your original patch, that just uses "s", over the one below
> > > > that moves the rcu_exp_gp_seq_end().  The big advantage of your original
> > > > patch is that it allow more concurrency between a consecutive pair of
> > > > expedited RCU grace periods.  Plus it would not be easy to convince
> > > > myself that moving rcu_exp_gp_seq_end() down is safe, so your original
> > > > is also conceptually simpler with a more manageable state space.
> 
> The reason for highlighting the alternate approach of doing gp end inside
> exp_wake_mutex is the requirement of 3 wqs. Now, this is a theoretical case;
> please correct me if I am wrong here:
> 
> 1. task0 holds exp_wake_mutex, and is preempted.

Presumably after it has awakened the kthread that initiated the prior
expedited grace period (the one with seq number = -4).

> 2. task1 initiates new GP (current seq number = 0).

Yes, this can happen.

> 3. task1 queues worker kworker1 and schedules out.

And thus still holds .exp_mutex, but yes.

> 4. kworker1 sets exp GP to 1 and waits on exp_wake_mutex

And thus cannot yet have awakened task1.

> 5. task1 releases exp mutex, w/o entering waitq.

So I do not believe that we can get to #5.  What am I missing here?

> 6. task2 initiates new GP (current seq number = 1).
> 7. task2 queues worker kworker1 and schedules out.
> 8. kworker 2 sets exp GP to 2 and waits on exp_wake_mutex.
> ...
> 
> This sequence would break the requirement of max 3 wqs.
> 
> If we hold the exp_wake_mutex before exp seq end, there will be atmost three
> pending GPs - 1. GP which current owner is doing wakeups for,
> 2. GP which the waiter of exp_wake_mutex would complete, 3. Next GP
> waiters, which started after GP @ point 2 had started. This also is inline
> with the statement in [1]:
> 
> "he key point is that the ->exp_mutex is not released until
> the first wakeup is complete, which means that the ->exp_wake_mutex
> has already been acquired at that point"
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/tree/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst?h=dev

And I believe that this still holds.  The task holding .exp_mutex cannot
release it until it has been awakened, and it won't be awakened until after
the .exp_wake_mutex has been acquired.  Again, what am I missing here?

> > > > Please also add the WARN_ON(), though at first glance your change seems
> > > > to have lost the wakeup.  (But it is early, so maybe it is just that I
> > > > am not yet fully awake.)
> > > 
> > > My bad, I posted incomplete diff in previous mail:
> > > 
> > >   static void rcu_exp_wait_wake(struct rcu_state *rsp, unsigned long s)
> > >   {
> > >   	struct rcu_node *rnp;
> > > +	unsigned long exp_low;
> > > +	unsigned long s_low = rcu_seq_ctr(s) & 0x3;
> > > 
> > >   	synchronize_sched_expedited_wait(rsp);
> > >   	rcu_exp_gp_seq_end(rsp);
> > > @@ -613,7 +615,9 @@ static void rcu_exp_wait_wake(struct rcu_state *rsp,
> > > unsigned long s)
> > >   			spin_unlock(&rnp->exp_lock);
> > >   		}
> > >   		smp_mb(); /* All above changes before wakeup. */
> > > -		wake_up_all(&rnp->exp_wq[rcu_seq_ctr(rsp->expedited_sequence) & 0x3]);
> > > +		exp_low = rcu_seq_ctr(rsp->expedited_sequence) & 0x3;
> > > +		WARN_ON(s_low != exp_low);
> > > +		wake_up_all(&rnp->exp_wq[exp_low]);
> > 
> > Much better!
> > 
> > But I suggest using s_low in the wake_up_all.  This hunk is of course
> > only for testing purposes, not for actual inclusion.  (My earlier email
> > didn't make that clear.)
> > 
> > 							Thanx, Paul
> > 
> 
> Ok sure, got it. I will share the results, once the issue is reproduced.

Sounds good!

							Thanx, Paul

> Thanks
> Neeraj
> 
> > >   	}
> > > 
> > > 
> > > Thanks
> > > Neeraj
> > > 
> > > > 
> > > > 							Thanx, Paul
> > > > 
> > > > > I was thinking of another way of addressing this problem: Doing exp seq end
> > > > > inside exp_wake_mutex. This will also ensure that, if we extend the current
> > > > > scenario and there are multiple expedited GP sequence, which have completed,
> > > > > before exp_wake_mutex is held, we need to preserve the requirement of 3 wq
> > > > > entries [2].
> > > > > 
> > > > > 
> > > > > [2] https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/tree/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst?h=dev
> > > > > 
> > > > > 
> > > > > @@ -595,8 +595,6 @@ static void rcu_exp_wait_wake(struct rcu_state *rsp,
> > > > > unsigned long s)
> > > > >           struct rcu_node *rnp;
> > > > > 
> > > > >           synchronize_sched_expedited_wait(rsp);
> > > > > -       rcu_exp_gp_seq_end(rsp);
> > > > > -       trace_rcu_exp_grace_period(rsp->name, s, TPS("end"));
> > > > > 
> > > > >           /*
> > > > >            * Switch over to wakeup mode, allowing the next GP, but -only- the
> > > > > @@ -604,6 +602,9 @@ static void rcu_exp_wait_wake(struct rcu_state *rsp,
> > > > > unsigned long s)
> > > > >            */
> > > > >           mutex_lock(&rsp->exp_wake_mutex);
> > > > > 
> > > > > +       rcu_exp_gp_seq_end(rsp);
> > > > > +       trace_rcu_exp_grace_period(rsp->name, s, TPS("end"));
> > > > > +
> > > > > 
> > > > > 
> > > > > 
> > > > > > (Using a WARN_ON() to check for the lower bits of the counter portion
> > > > > > of rcu_state.expedited_sequence differing from the same bits of s
> > > > > > would be one way to detect this problem.)
> > > > > > 
> > > > > > 							Thanx, Paul
> > > > > > 
> > > > > 
> > > > > I have also given the patch for this, for testing:
> > > > > 
> > > > >    static void rcu_exp_wait_wake(struct rcu_state *rsp, unsigned long s)
> > > > >    {
> > > > >           struct rcu_node *rnp;
> > > > > +       unsigned long exp_low;
> > > > > +       unsigned long s_low = rcu_seq_ctr(s) & 0x3;
> > > > > 
> > > > >           synchronize_sched_expedited_wait(rsp);
> > > > >           rcu_exp_gp_seq_end(rsp);
> > > > > @@ -613,7 +615,9 @@ static void rcu_exp_wait_wake(struct rcu_state *rsp,
> > > > > unsigned long s)
> > > > >                           spin_unlock(&rnp->exp_lock);
> > > > >                   }
> > > > >                   smp_mb(); /* All above changes before wakeup. */
> > > > > - wake_up_all(&rnp->exp_wq[rcu_seq_ctr(rsp->expedited_sequence) & 0x3]);
> > > > > +               exp_low = rcu_seq_ctr(rsp->expedited_sequence) & 0x3;
> > > > > +               WARN_ON(s_low != exp_low);
> > > > > +
> > > > > 
> > > > > Thanks
> > > > > Neeraj
> > > > > 
> > > > > > > Fix this by using the correct sequence number for wake_up_all() inside
> > > > > > > rcu_exp_wait_wake().
> > > > > > > 
> > > > > > > Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> > > > > > > ---
> > > > > > >     kernel/rcu/tree_exp.h | 2 +-
> > > > > > >     1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > 
> > > > > > > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > > > > > > index e4b77d3..28979d3 100644
> > > > > > > --- a/kernel/rcu/tree_exp.h
> > > > > > > +++ b/kernel/rcu/tree_exp.h
> > > > > > > @@ -557,7 +557,7 @@ static void rcu_exp_wait_wake(unsigned long s)
> > > > > > >     			spin_unlock(&rnp->exp_lock);
> > > > > > >     		}
> > > > > > >     		smp_mb(); /* All above changes before wakeup. */
> > > > > > > -		wake_up_all(&rnp->exp_wq[rcu_seq_ctr(rcu_state.expedited_sequence) & 0x3]);
> > > > > > > +		wake_up_all(&rnp->exp_wq[rcu_seq_ctr(s) & 0x3]);
> > > > > > >     	}
> > > > > > >     	trace_rcu_exp_grace_period(rcu_state.name, s, TPS("endwake"));
> > > > > > >     	mutex_unlock(&rcu_state.exp_wake_mutex);
> > > > > > > -- 
> > > > > > > QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
> > > > > > > member of the Code Aurora Forum, hosted by The Linux Foundation
> > > > > > > 
> > > > > 
> > > > > -- 
> > > > > QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of
> > > > > the Code Aurora Forum, hosted by The Linux Foundation
> > > 
> > > -- 
> > > QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of
> > > the Code Aurora Forum, hosted by The Linux Foundation
> 
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of
> the Code Aurora Forum, hosted by The Linux Foundation
