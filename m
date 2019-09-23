Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A716FC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 837F820578
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393931AbfIWOJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 10:09:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58430 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389738AbfIWOJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 10:09:42 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iCP1R-0006LT-48; Mon, 23 Sep 2019 16:09:01 +0200
Date:   Mon, 23 Sep 2019 16:09:00 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Yunfeng Cui <cui.yunfeng@zte.com.cn>, christian@brauner.io,
        keescook@chromium.org, luto@amacapital.net, wad@chromium.org,
        akpm@linux-foundation.org, mingo@kernel.org, mhocko@suse.com,
        elena.reshetova@intel.com, aarcange@redhat.com, ldv@altlinux.org,
        arunks@codeaurora.org, guro@fb.com, joel@joelfernandes.org,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        jiang.xuexin@zte.com.cn
Subject: Re: [PATCH] futex: robust futex maybe never be awaked, on rare
 situation.
In-Reply-To: <20190923130519.GH2332@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1909231545560.2003@nanos.tec.linutronix.de>
References: <1569208700-24044-1-git-send-email-cui.yunfeng@zte.com.cn> <20190923130519.GH2332@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Sep 2019, Peter Zijlstra wrote:
> On Mon, Sep 23, 2019 at 11:18:20AM +0800, Yunfeng Cui wrote:
> > I use model checker find a issue of robust and pi futex. On below
> > situation, the owner can't find something in pi_state_list, while
> > the requester will be blocked, never be awaked.
> > 
> > CPU0                       CPU1
> >                            futex_lock_pi
> >                            /*some cs code*/
> > futex_lock_pi
> >   futex_lock_pi_atomic
> >     ...
> >     newval = uval | FUTEX_WAITERS;
> >     ret = lock_pi_update_atomic(uaddr, uval, newval);
> >     ...
> >     attach_to_pi_owner
> >      ....
> >      p = find_get_task_by_vpid(pid);
> >      if (!p)
> >        return handle_exit_race(uaddr, uval, NULL);
> >        ....
> >        raw_spin_lock_irq(&p->pi_lock);
> >        ....
> >        pi_state = alloc_pi_state();
> >        ....
> >                            do_exit->mm_release
> >                            if (unlikely(tsk->robust_list)) {
> >                              exit_robust_list(tsk);
> >                              tsk->robust_list = NULL;
> >                            }
> >                            if (unlikely(!list_empty(&tsk->pi_state_list)))
> >                              exit_pi_state_list(tsk); /*WILL MISS*/
> >       list_add(&pi_state->list, &p->pi_state_list);
> >     WILL BLOCKED, NEVER WAKEUP!
> 
> Did you forget/overlook the pi_lock fiddling in do_exit() ? I'm thinking
> that would make the above impossible.

Right. I was trying to construct a case which allows the above, but failed
to do so.

Let's look at the exiting task:

   exit()
     exit_signals()
       tsk->flags |= PF_EXITING;

     smp_mb();

     raw_spin_lock_irq(&tsk->pi_lock);
(1)
     raw_spin_unlock_irq(&tsk->pi_lock);

     exit_mm()
       mm_release()
         exit_robust_list()

         if (!list_empty(&tsk->pi_state_list)))
            exit_pi_state_list(tsk);

And now at the attaching task:

attach_to_pi_owner()
  raw_spin_lock_irq(tsk->pi_lock);
    if (tsk->flags & PF_EXITING)
      return;

  pi_state = alloc_pi_state()

  list_add(pi_state, tsk->pi_state_list);

See (1) above. That's the crucial point.

Once the exiting task has set PF_EXITING and acquired tsk->pi_lock, it is
impossible for the attaching task to queue itself as it _must_ observe
PF_EXITING after it acquired tsk->pi_lock.

If it manages to acquire tsk->pi_lock _before_ the existing task does that,
then it either observes PF_EXITING or not.

If it does, it goes out. If it does not, it queues itself on
tsk->pi_state_list and will be cleaned up by the exiting task.

Simplified concurrency picture:

Case 1: Attacher does not see PF_EXITING

CPU 0				CPU 1

    				lock(&tsk->pi_lock);
 tsk->flags |= PF_EXITING;	if (!(tsk->flags & PF_EXITING))
				   queue(pi_state, tsk);
 smp_mb();			   unlock(&tsk->pi_lock); 	       			
 lock(&tsk->pi_lock);
(1)
 unlock(&tsk->pi_lock);

 if (!list_empty(&tsk->pi_state_list)))
   exit_pi_state_list(tsk);

Case 2: Attacher does see PF_EXITING before (1)

CPU 0				CPU 1

    				lock(&tsk->pi_lock);
 tsk->flags |= PF_EXITING;	if (tsk->flags & PF_EXITING) {
 	    			   unlock(&tsk->pi_lock);
 smp_mb();			   return;
 lock(&tsk->pi_lock);           }
(1) 
 unlock(&tsk->pi_lock);

The attacher CANNOT be queued in tsk->pi_state_list

Case 2: Attacher does see PF_EXITING after (1)

CPU 0				CPU 1

 tsk->flags |= PF_EXITING;	
 smp_mb();
 lock(&tsk->pi_lock);
				lock(&tsk->pi_lock);
(1) 
 unlock(&tsk->pi_lock);
				if (tsk->flags & PF_EXITING) {
 	    			   unlock(&tsk->pi_lock);
				   return;
				}

There are no other cases possible. If the attacher can observe

      !(tsk->flags & PF_EXITING)

_after_ (1) then there is something seriously wrong, but not in the futex
code. That would be a massive memory ordering issue.

Thanks,

	tglx
