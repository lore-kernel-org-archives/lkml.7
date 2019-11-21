Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B349C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 18:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0191206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 18:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574362541;
	bh=hdgGfyrEBsEGbrq5K54yZQL5cyj6V7SennlQoknCEtA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=dNa3lqHrc8O2PB6flvX8xCpfqnLTxT8EvNL6AiX2aZnaAIVdN8uPNZabiiehn29Pz
	 uFJTrl8i/4AgpQp/4H/r5SmgTqGPAbpK7ajkGRDW8DKgb9ANX62KKJKQ3t3ODP0O/P
	 sxsrXRooSTh1so7iv01rAG9pzIhatumG7Y5XBD4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfKUSzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 13:55:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:44982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfKUSzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 13:55:39 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [199.201.64.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A27A020672;
        Thu, 21 Nov 2019 18:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574362537;
        bh=hdgGfyrEBsEGbrq5K54yZQL5cyj6V7SennlQoknCEtA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=thZM53uNG5cN4CusMREaRAm8FUy6Xu25yMbkOyrxIxKFpNfOb7eK/lLbYTLd7Vz//
         mjSYx8iOHYCud2jknqoVYX6oN3g96qkLJl15RbC0qTLeKnzj7nqCBpUBdXDKWXdRnY
         pnufMeIPZq/Kgvm3KBEjAh5mGEb7IvtRqDx71sXs=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3DA0835217E5; Thu, 21 Nov 2019 10:55:37 -0800 (PST)
Date:   Thu, 21 Nov 2019 10:55:37 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     josh@joshtriplett.org, joel@joelfernandes.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        pkondeti@codeaurora.org, prsood@codeaurora.org,
        gkohli@codeaurora.org
Subject: Re: [PATCH] rcu: Fix missed wakeup of exp_wq waiters
Message-ID: <20191121185537.GG2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <0101016e7f644106-90b40f19-ba9e-4974-bdbe-1062b52222a2-000000@us-west-2.amazonses.com>
 <20191118172401.GO2889@paulmck-ThinkPad-P72>
 <0101016e81ba8865-028ac62b-3fcd-481b-b657-be8519c4edf5-000000@us-west-2.amazonses.com>
 <20191119040533.GS2889@paulmck-ThinkPad-P72>
 <0101016e8278f225-9df7f507-2b6d-45e4-9c4d-d37141a1c5c6-000000@us-west-2.amazonses.com>
 <20191119150931.GX2889@paulmck-ThinkPad-P72>
 <20191119200647.GC2889@paulmck-ThinkPad-P72>
 <eeb7de82-c24b-c914-05fb-683088c9f8e2@codeaurora.org>
 <20191121041034.GZ2889@paulmck-ThinkPad-P72>
 <71de1f25-75c5-a4bb-49d9-19af5f8ae4fe@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71de1f25-75c5-a4bb-49d9-19af5f8ae4fe@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 10:06:40AM +0530, Neeraj Upadhyay wrote:
> 
> 
> On 11/21/2019 9:40 AM, Paul E. McKenney wrote:
> > On Wed, Nov 20, 2019 at 10:38:56AM +0530, Neeraj Upadhyay wrote:
> > > 
> > > 
> > > On 11/20/2019 1:36 AM, Paul E. McKenney wrote:
> > > > On Tue, Nov 19, 2019 at 07:09:31AM -0800, Paul E. McKenney wrote:
> > > > > On Tue, Nov 19, 2019 at 07:03:14AM +0000, Neeraj Upadhyay wrote:
> > > > > > Hi Paul,
> > > > > > 
> > > > > > On 11/19/2019 9:35 AM, Paul E. McKenney wrote:
> > > > > > > On Tue, Nov 19, 2019 at 03:35:15AM +0000, Neeraj Upadhyay wrote:
> > > > > > > > Hi Paul,
> > > > > > > > 
> > > > > > > > On 11/18/2019 10:54 PM, Paul E. McKenney wrote:
> > > > > > > > > On Mon, Nov 18, 2019 at 04:41:47PM +0000, Neeraj Upadhyay wrote:
> > > > > > > > > > Hi Paul,
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > On 11/18/2019 8:38 PM, Paul E. McKenney wrote:
> > > > > > > > > > > On Mon, Nov 18, 2019 at 09:28:39AM +0000, Neeraj Upadhyay wrote:
> > > > > > > > > > > > Hi Paul,
> > > > > > > > > > > > 
> > > > > > > > > > > > On 11/18/2019 3:06 AM, Paul E. McKenney wrote:
> > > > > > > > > > > > > On Fri, Nov 15, 2019 at 10:58:14PM +0530, Neeraj Upadhyay wrote:
> > > > > > > > > > > > > > For the tasks waiting in exp_wq inside exp_funnel_lock(),
> > > > > > > > > > > > > > there is a chance that they might be indefinitely blocked
> > > > > > > > > > > > > > in below scenario:
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > 1. There is a task waiting on exp sequence 0b'100' inside
> > > > > > > > > > > > > >          exp_funnel_lock().
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > >          _synchronize_rcu_expedited()
> > > > > > > > > > > > > 
> > > > > > > > > > > > > This symbol went away a few versions back, but let's see how this
> > > > > > > > > > > > > plays out in current -rcu.
> > > > > > > > > > > > > 
> > > > > > > > > > > > 
> > > > > > > > > > > > Sorry; for us this problem is observed on 4.19 stable version; I had
> > > > > > > > > > > > checked against the -rcu code, and the relevant portions were present
> > > > > > > > > > > > there.
> > > > > > > > > > > > 
> > > > > > > > > > > > > >            s = 0b'100
> > > > > > > > > > > > > >            exp_funnel_lock()
> > > > > > > > > > > > > >              wait_event(rnp->exp_wq[rcu_seq_ctr(s) & 0x3]
> > > > > > > > > > > > > 
> > > > > > > > > > > > > All of the above could still happen if the expedited grace
> > > > > > > > > > > > > period number was zero (or a bit less) when that task invoked
> > > > > > > > > > > > 
> > > > > > > > > > > > Yes
> > > > > > > > > > > > 
> > > > > > > > > > > > > synchronize_rcu_expedited().  What is the relation, if any,
> > > > > > > > > > > > > between this task and "task1" below?  Seems like you want them to
> > > > > > > > > > > > > be different tasks.
> > > > > > > > > > > > > 
> > > > > > > > > > > > 
> > > > > > > > > > > > This task is the one which is waiting for the expedited sequence, which
> > > > > > > > > > > > "task1" completes ("task1" holds the exp_mutex for it). "task1" would
> > > > > > > > > > > > wake up this task, on exp GP completion.
> > > > > > > > > > > > 
> > > > > > > > > > > > > Does this task actually block, or is it just getting ready
> > > > > > > > > > > > > to block?  Seems like you need it to have actually blocked.
> > > > > > > > > > > > > 
> > > > > > > > > > > > 
> > > > > > > > > > > > Yes, it actually blocked in wait queue.
> > > > > > > > > > > > 
> > > > > > > > > > > > > > 2. The Exp GP completes and task (task1) holding exp_mutex queues
> > > > > > > > > > > > > >          worker and schedules out.
> > > > > > > > > > > > > 
> > > > > > > > > > > > > "The Exp GP" being the one that was initiated when the .expedited_sequence
> > > > > > > > > > > > > counter was zero, correct?  (Looks that way below.)
> > > > > > > > > > > > > 
> > > > > > > > > > > > Yes, correct.
> > > > > > > > > > > > 
> > > > > > > > > > > > > >          _synchronize_rcu_expedited()
> > > > > > > > > > > > > >            s = 0b'100
> > > > > > > > > > > > > >            queue_work(rcu_gp_wq, &rew.rew_work)
> > > > > > > > > > > > > >              wake_up_worker()
> > > > > > > > > > > > > >                schedule()
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > 3. kworker A picks up the queued work and completes the exp gp
> > > > > > > > > > > > > >          sequence.
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > >          rcu_exp_wait_wake()
> > > > > > > > > > > > > >            rcu_exp_wait_wake()
> > > > > > > > > > > > > >              rcu_exp_gp_seq_end(rsp) // rsp->expedited_sequence is incremented
> > > > > > > > > > > > > >                                      // to 0b'100'
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > 4. task1 does not enter wait queue, as sync_exp_work_done() returns true,
> > > > > > > > > > > > > >          and releases exp_mutex.
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > >          wait_event(rnp->exp_wq[rcu_seq_ctr(s) & 0x3],
> > > > > > > > > > > > > >            sync_exp_work_done(rsp, s));
> > > > > > > > > > > > > >          mutex_unlock(&rsp->exp_mutex);
> > > > > > > > > > > > > 
> > > > > > > > > > > > > So task1 is the one that initiated the expedited grace period that
> > > > > > > > > > > > > started when .expedited_sequence was zero, right?
> > > > > > > > > > > > > 
> > > > > > > > > > > > 
> > > > > > > > > > > > Yes, right.
> > > > > > > > > > > > 
> > > > > > > > > > > > > > 5. Next exp GP completes, and sequence number is incremented:
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > >          rcu_exp_wait_wake()
> > > > > > > > > > > > > >            rcu_exp_wait_wake()
> > > > > > > > > > > > > >              rcu_exp_gp_seq_end(rsp) // rsp->expedited_sequence = 0b'200'
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > 6. As kworker A uses current expedited_sequence, it wakes up workers
> > > > > > > > > > > > > >          from wrong wait queue index - it should have worken wait queue
> > > > > > > > > > > > > >          corresponding to 0b'100' sequence, but wakes up the ones for
> > > > > > > > > > > > > >          0b'200' sequence. This results in task at step 1 indefinitely blocked.
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > >          rcu_exp_wait_wake()
> > > > > > > > > > > > > >            wake_up_all(&rnp->exp_wq[rcu_seq_ctr(rsp->expedited_sequence) & 0x3]);
> > > > > > > > > > > > > 
> > > > > > > > > > > > > So the issue is that the next expedited RCU grace period might
> > > > > > > > > > > > > have completed before the completion of the wakeups for the previous
> > > > > > > > > > > > > expedited RCU grace period, correct?  Then expedited grace periods have
> > > > > > > > > > > > 
> > > > > > > > > > > > Yes. Actually from the ftraces, I saw that next expedited RCU grace
> > > > > > > > > > > > period completed while kworker A was in D state, while waiting for
> > > > > > > > > > > > exp_wake_mutex. This led to kworker A using sequence 2 (instead of 1) for
> > > > > > > > > > > > its wake_up_all() call; so, task (point 1) was never woken up, as it was
> > > > > > > > > > > > waiting on wq index 1.
> > > > > > > > > > > > 
> > > > > > > > > > > > > to have stopped to prevent any future wakeup from happening, correct?
> > > > > > > > > > > > > (Which would make it harder for rcutorture to trigger this, though it
> > > > > > > > > > > > > really does have code that attempts to trigger this sort of thing.)
> > > > > > > > > > > > > 
> > > > > > > > > > > > > Is this theoretical in nature, or have you actually triggered it?
> > > > > > > > > > > > > If actually triggered, what did you do to make this happen?
> > > > > > > > > > > > 
> > > > > > > > > > > > This issue, we had seen previously - 1 instance in May 2018 (on 4.9 kernel),
> > > > > > > > > > > > another instance in Nov 2018 (on 4.14 kernel), in our customer reported
> > > > > > > > > > > > issues. Both instances were in downstream drivers and we didn't have RCU
> > > > > > > > > > > > traces. Now 2 days back, it was reported on 4.19 kernel, with RCU traces
> > > > > > > > > > > > enabled, where it was observed in suspend scenario, where we are observing
> > > > > > > > > > > > "DPM device timeout" [1], as scsi device is stuck in
> > > > > > > > > > > > _synchronize_rcu_expedited().
> > > > > > > > > > > > 
> > > > > > > > > > > > schedule+0x70/0x90
> > > > > > > > > > > > _synchronize_rcu_expedited+0x590/0x5f8
> > > > > > > > > > > > synchronize_rcu+0x50/0xa0
> > > > > > > > > > > > scsi_device_quiesce+0x50/0x120
> > > > > > > > > > > > scsi_bus_suspend+0x70/0xe8
> > > > > > > > > > > > dpm_run_callback+0x148/0x388
> > > > > > > > > > > > __device_suspend+0x430/0x8a8
> > > > > > > > > > > > 
> > > > > > > > > > > > [1]
> > > > > > > > > > > > https://github.com/torvalds/linux/blob/master/drivers/base/power/main.c#L489
> > > > > > > > > > > > 
> > > > > > > > > > > > > What have you done to test the change?
> > > > > > > > > > > > > 
> > > > > > > > > > > > 
> > > > > > > > > > > > I have given this for testing; will share the results . Current analysis
> > > > > > > > > > > > and patch is based on going through ftrace and code review.
> > > > > > > > > > > 
> > > > > > > > > > > OK, very good.  Please include the failure information in the changelog
> > > > > > > > > > > of the next version of this patch.
> > > > > > > > 
> > > > > > > > Done.
> > > > > > > > 
> > > > > > > > > > > 
> > > > > > > > > > > I prefer your original patch, that just uses "s", over the one below
> > > > > > > > > > > that moves the rcu_exp_gp_seq_end().  The big advantage of your original
> > > > > > > > > > > patch is that it allow more concurrency between a consecutive pair of
> > > > > > > > > > > expedited RCU grace periods.  Plus it would not be easy to convince
> > > > > > > > > > > myself that moving rcu_exp_gp_seq_end() down is safe, so your original
> > > > > > > > > > > is also conceptually simpler with a more manageable state space.
> > > > > > > > 
> > > > > > > > The reason for highlighting the alternate approach of doing gp end inside
> > > > > > > > exp_wake_mutex is the requirement of 3 wqs. Now, this is a theoretical case;
> > > > > > > > please correct me if I am wrong here:
> > > > > > > > 
> > > > > > > > 1. task0 holds exp_wake_mutex, and is preempted.
> > > > > > > 
> > > > > > > Presumably after it has awakened the kthread that initiated the prior
> > > > > > > expedited grace period (the one with seq number = -4).
> > > > > > > 
> > > > > > > > 2. task1 initiates new GP (current seq number = 0).
> > > > > > > 
> > > > > > > Yes, this can happen.
> > > > > > > 
> > > > > > > > 3. task1 queues worker kworker1 and schedules out.
> > > > > > > 
> > > > > > > And thus still holds .exp_mutex, but yes.
> > > > > > > 
> > > > > > > > 4. kworker1 sets exp GP to 1 and waits on exp_wake_mutex
> > > > > > > 
> > > > > > > And thus cannot yet have awakened task1.
> > > > > > > 
> > > > > > > > 5. task1 releases exp mutex, w/o entering waitq.
> > > > > > > 
> > > > > > > So I do not believe that we can get to #5.  What am I missing here?
> > > > > > > 
> > > > > > 
> > > > > > As mentioned in this patch, task1 could have scheduled out after queuing
> > > > > > work:
> > > > > > 
> > > > > > queue_work(rcu_gp_wq, &rew.rew_work)
> > > > > >              wake_up_worker()
> > > > > >                schedule()
> > > > > > 
> > > > > > kworker1 runs and picks up this queued work, and sets exp GP to 1 and waits
> > > > > > on exp_wake_mutex.
> > > > > > 
> > > > > > task1 gets scheduled in and checks sync_exp_work_done(rsp, s), which return
> > > > > > true and it does not enter wait queue and releases exp_mutex.
> > > > > > 
> > > > > > wait_event(rnp->exp_wq[rcu_seq_ctr(s) & 0x3],
> > > > > >            sync_exp_work_done(rsp, s));
> > > > > 
> > > > > Well, I have certainly given enough people a hard time about missing the
> > > > > didn't-actually-sleep case, so good show on finding one in my code!  ;-)
> > > > > 
> > > > > Which also explains why deferring the rcu_exp_gp_seq_end() is safe:
> > > > > The .exp_mutex won't be released until after it happens, and the
> > > > > next manipulation of the sequence number cannot happen until after
> > > > > .exp_mutex is next acquired.
> > > > > 
> > > > > Good catch!  And keep up the good work!!!
> > > > 
> > > > And here is the commit corresponding to your earlier patch.  Please let
> > > > me know of any needed adjustments.
> > > > 
> > > > 							Thanx, Paul
> > > > 
> > > > ------------------------------------------------------------------------
> > > > 
> > > > commit 3ec440b52831eea172061c5db3d2990b22904863
> > > > Author: Neeraj Upadhyay <neeraju@codeaurora.org>
> > > > Date:   Tue Nov 19 11:50:52 2019 -0800
> > > > 
> > > >       rcu: Allow only one expedited GP to run concurrently with wakeups
> > > >       The current expedited RCU grace-period code expects that a task
> > > >       requesting an expedited grace period cannot awaken until that grace
> > > >       period has reached the wakeup phase.  However, it is possible for a long
> > > >       preemption to result in the waiting task never sleeping.  For example,
> > > >       consider the following sequence of events:
> > > >       1.      Task A starts an expedited grace period by invoking
> > > >               synchronize_rcu_expedited().  It proceeds normally up to the
> > > >               wait_event() near the end of that function, and is then preempted
> > > >               (or interrupted or whatever).
> > > >       2.      The expedited grace period completes, and a kworker task starts
> > > >               the awaken phase, having incremented the counter and acquired
> > > >               the rcu_state structure's .exp_wake_mutex.  This kworker task
> > > >               is then preempted or interrupted or whatever.
> > > >       3.      Task A resumes and enters wait_event(), which notes that the
> > > >               expedited grace period has completed, and thus doesn't sleep.
> > > >       4.      Task B starts an expedited grace period exactly as did Task A,
> > > >               complete with the preemption (or whatever delay) just before
> > > >               the call to wait_event().
> > > >       5.      The expedited grace period completes, and another kworker
> > > >               task starts the awaken phase, having incremented the counter.
> > > >               However, it blocks when attempting to acquire the rcu_state
> > > >               structure's .exp_wake_mutex because step 2's kworker task has
> > > >               not yet released it.
> > > >       6.      Steps 4 and 5 repeat, resulting in overflow of the rcu_node
> > > >               structure's ->exp_wq[] array.
> > > >       In theory, this is harmless.  Tasks waiting on the various ->exp_wq[]
> > > >       array will just be spuriously awakened, but they will just sleep again
> > > >       on noting that the rcu_state structure's ->expedited_sequence value has
> > > >       not advanced far enough.
> > > >       In practice, this wastes CPU time and is an accident waiting to happen.
> > > >       This commit therefore moves the rcu_exp_gp_seq_end() call that officially
> > > >       ends the expedited grace period (along with associate tracing) until
> > > >       after the ->exp_wake_mutex has been acquired.  This prevents Task A from
> > > >       awakening prematurely, thus preventing more than one expedited grace
> > > >       period from being in flight during a previous expedited grace period's
> > > >       wakeup phase.
> > > 
> > > I am not sure, if a "fixes" tag is required for it.
> > 
> > If you have a suggested commit, I would be happy to add it.
> > 
> 
> I think either or below 2 - first one is on the tree_exp.h file, second
> one looks to be the original commit.
> 
> 1. https://github.com/torvalds/linux/commit/3549c2bc2c4ea8ecfeb9d21cb81cb00c6002b011
> 
> 2. https://github.com/torvalds/linux/commit/3b5f668e715bc19610ad967ef97a7e8c55a186ec

Agreed, this second commit is the one that introduced the bug.  I placed
"Fixes:" tags on both of your commits for this one.  And thank you for
digging them both up!

							Thanx, Paul

> Thanks
> Neeraj
> 
> > > >       Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> > > >       [ paulmck: Added updated comment. ]
> > > >       Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > 
> > > > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > > > index 4433d00a..8840729 100644
> > > > --- a/kernel/rcu/tree_exp.h
> > > > +++ b/kernel/rcu/tree_exp.h
> > > > @@ -539,14 +539,13 @@ static void rcu_exp_wait_wake(unsigned long s)
> > > >    	struct rcu_node *rnp;
> > > >    	synchronize_sched_expedited_wait();
> > > > -	rcu_exp_gp_seq_end();
> > > > -	trace_rcu_exp_grace_period(rcu_state.name, s, TPS("end"));
> > > > -	/*
> > > > -	 * Switch over to wakeup mode, allowing the next GP, but -only- the
> > > > -	 * next GP, to proceed.
> > > > -	 */
> > > > +	// Switch over to wakeup mode, allowing the next GP to proceed.
> > > > +	// End the previous grace period only after acquiring the mutex
> > > > +	// to ensure that only one GP runs concurrently with wakeups.
> > > 
> > > Should comment style be changed to below?
> > > 
> > > /* Switch over to wakeup mode, allowing the next GP to proceed.
> > >   * End the previous grace period only after acquiring the mutex
> > >   * to ensure that only one GP runs concurrently with wakeups.
> > >   */
> > 
> > No.  "//" is acceptable comment format, aside from docbook headers.
> > The "//" approach saves three characters per line compared to "/* ... */"
> > single-line comments and a line compared to the style you show above.
> > 
> > So yes, some maintainers prefer the style you show, but not me.
> > 
> > 							Thanx, Paul
> > 
> > > >    	mutex_lock(&rcu_state.exp_wake_mutex);
> > > > +	rcu_exp_gp_seq_end();
> > > > +	trace_rcu_exp_grace_period(rcu_state.name, s, TPS("end"));
> > > >    	rcu_for_each_node_breadth_first(rnp) {
> > > >    		if (ULONG_CMP_LT(READ_ONCE(rnp->exp_seq_rq), s)) {
> > > > 
> > > 
> > > -- 
> > > QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of
> > > the Code Aurora Forum, hosted by The Linux Foundation
> 
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of
> the Code Aurora Forum, hosted by The Linux Foundation
