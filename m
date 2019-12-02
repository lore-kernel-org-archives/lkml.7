Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919BBC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 23:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65023206F0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 23:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575329987;
	bh=qqdz0QPUftlIudgRH8VulW6uYgac9ztwFIHPkQoNkQI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=AuIiuSpd/GRiVk5WRgmOLEwJatpNyU127MVyKLZfC93FLFAcZKl+aQUSSvIF4Bx9R
	 MXfxGOKAkzOPZYbOSPfl6qDcjGGsFSJW2Ctkfhamxd6s+EtImNA8b/x7zr5iioo/3N
	 dO8E/6zJIIrnlrmXDztVau7FZmwo0RR+GIFBrXBU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbfLBXjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 18:39:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:39690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbfLBXjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 18:39:45 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CD31206E1;
        Mon,  2 Dec 2019 23:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575329984;
        bh=qqdz0QPUftlIudgRH8VulW6uYgac9ztwFIHPkQoNkQI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dU0F7N2KoYVK18M+qtzhbnpyjhcrifcyCQNPICu60isLzc1hL178kpP69oZdP0GBF
         OZcOPuyLGVrb/1F3glWETVhcZKSbXBz02yfRCCXsw+mv6/6xmhWCNSRmkoR3jtCaal
         IiEhUgMxDhftcxjYNDqClG1ZTDf812gGqd6Ur2QM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7539C3522783; Mon,  2 Dec 2019 15:39:44 -0800 (PST)
Date:   Mon, 2 Dec 2019 15:39:44 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Workqueues splat due to ending up on wrong CPU
Message-ID: <20191202233944.GY2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191125230312.GP2889@paulmck-ThinkPad-P72>
 <20191126183334.GE2867037@devbig004.ftw2.facebook.com>
 <20191126220533.GU2889@paulmck-ThinkPad-P72>
 <20191127155027.GA15170@paulmck-ThinkPad-P72>
 <20191128161823.GA24667@paulmck-ThinkPad-P72>
 <20191129155850.GA17002@paulmck-ThinkPad-P72>
 <20191202015548.GA13391@paulmck-ThinkPad-P72>
 <20191202201338.GH16681@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202201338.GH16681@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2019 at 12:13:38PM -0800, Tejun Heo wrote:
> Hello, Paul.
> 
> (cc'ing scheduler folks - workqueue rescuer is very occassionally
> triggering a warning which says that it isn't on the cpu it should be
> on under rcu cpu hotplug torture test.  It's checking smp_processor_id
> is the expected one after a successful set_cpus_allowed_ptr() call.)
> 
> On Sun, Dec 01, 2019 at 05:55:48PM -0800, Paul E. McKenney wrote:
> > > And hyperthreading seems to have done the trick!  One splat thus far,
> > > shown below.  The run should complete this evening, Pacific Time.
> > 
> > That was the only one for that run, but another 24*56-hour run got three
> > more.  All of them expected to be on CPU 0 (which never goes offline, so
> > why?) and the "XXX" diagnostic never did print.
> 
> Heh, I didn't expect that, so maybe set_cpus_allowed_ptr() is
> returning 0 while not migrating the rescuer task to the target cpu for
> some reason?
> 
> The rescuer is always calling to migrate itself, so it must always be
> running.  set_cpus_allowed_ptr() migrates live ones by calling
> stop_one_cpu() which schedules a migration function which runs from a
> highpri task on the target cpu.  Please take a look at the following.
> 
>   static bool cpu_stop_queue_work(unsigned int cpu, struct cpu_stop_work *work)
>   {
>           ...
> 	  enabled = stopper->enabled;
> 	  if (enabled)
> 		  __cpu_stop_queue_work(stopper, work, &wakeq);
> 	  else if (work->done)
> 		  cpu_stop_signal_done(work->done);
>           ...
>   }
> 
> So, if stopper->enabled is clear, it'll signal completion without
> running the work.  stopper->enabled is cleared during cpu hotunplug
> and restored from bringup_cpu() while cpu is being brought back up.
> 
>   static int bringup_wait_for_ap(unsigned int cpu)
>   {
>           ...
> 	  stop_machine_unpark(cpu);
>           ....
>   }
> 
>   static int bringup_cpu(unsigned int cpu)
>   {
> 	  ...
> 	  ret = __cpu_up(cpu, idle);
>           ...
> 	  return bringup_wait_for_ap(cpu);
>   }
> 
> __cpu_up() is what marks the cpu online and once the cpu is online,
> kthreads are free to migrate into the cpu, so it looks like there's a
> brief window where a cpu is marked online but the stopper thread is
> still disabled meaning that a kthread may schedule into the cpu but
> not out of it, which would explain the symptom that you were seeing.
> 
> This makes the cpumask and the cpu the task is actually on disagree
> and retries would become noops.  I can work around it by excluding
> rescuer attachments against hotplugs but this looks like a genuine cpu
> hotplug bug.
> 
> It could be that I'm misreading the code.  What do you guys think?

I think that I do not understand the code, but I never let that stop
me from asking stupid questions!  ;-)

Suppose that a given worker is bound to a particular CPU, but has no
work pending, and is therefore sleeping in the schedule() call near the
end of worker_thread().  During this time, its CPU goes offline and then
comes back online.  Doesn't this break that task's affinity to that CPU?
Then the call to workqueue_online_cpu() is supposed to rebind all the
tasks that might have been affected, correct?

I could imagine putting a trace_printk() or two in workqueue_online_cpu()
and adding the task_struct pointer (or PID) to the WARN_ONCE(), though I
am worried that this might decrease the race probability.

Is there a better way to proceed?

							Thanx, Paul
