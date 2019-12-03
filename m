Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48B0C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 09:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A85C420675
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 09:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1FZDNl87"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfLCJzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 04:55:33 -0500
Received: from merlin.infradead.org ([205.233.59.134]:50276 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfLCJzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 04:55:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eF/WrQZnJQmBzVjTVYwqD09kkKPWxMNLd8gvp2wBnTo=; b=1FZDNl87jk79c9ZWj+ObQc2Tp
        XJJS87FZgf+DXj0gDSSjlMZX4c+yeOAfDDmrltHXvvDht/VS/Ks0nzq3PjW1p0MRTWsbmDgESZmKa
        147LsuPCnK8lYanN2+unBDuKVJ50HoQMuAFWO7knQfO+ILR4aOSI+le8M5wFZUQzA7IiD70bluz7K
        aFbF+0Z11MWMpkddwgqNcunBG2z/4QqHENRkbubMvC0lX9dm7YbIBZI1ORUJb0mS3f2fOxTmax5Tg
        FjeyQu7p5e0bGqHyrZKinztm1watCmDqayFR33xzpNHLN9jSQJF+6qUggmfHZBikk82PfNALVp7m4
        nj+N0Mivw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ic4tx-0005uE-EC; Tue, 03 Dec 2019 09:55:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BC84D301A79;
        Tue,  3 Dec 2019 10:54:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F202820230B0A; Tue,  3 Dec 2019 10:55:21 +0100 (CET)
Date:   Tue, 3 Dec 2019 10:55:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Workqueues splat due to ending up on wrong CPU
Message-ID: <20191203095521.GH2827@hirez.programming.kicks-ass.net>
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
User-Agent: Mutt/1.10.1 (2018-07-13)
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
> running the work.

Is there ever a valid case for this? That is, why isn't that a WARN()?

> stopper->enabled is cleared during cpu hotunplug
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

Yes.

> It could be that I'm misreading the code.  What do you guys think?

The below seems to not insta explode...

---
 kernel/cpu.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index a59cc980adad..9eaedd002f41 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -525,8 +525,7 @@ static int bringup_wait_for_ap(unsigned int cpu)
 	if (WARN_ON_ONCE((!cpu_online(cpu))))
 		return -ECANCELED;
 
-	/* Unpark the stopper thread and the hotplug thread of the target cpu */
-	stop_machine_unpark(cpu);
+	/* Unpark the hotplug thread of the target cpu */
 	kthread_unpark(st->thread);
 
 	/*
@@ -1089,8 +1088,8 @@ void notify_cpu_starting(unsigned int cpu)
 
 /*
  * Called from the idle task. Wake up the controlling task which brings the
- * stopper and the hotplug thread of the upcoming CPU up and then delegates
- * the rest of the online bringup to the hotplug thread.
+ * hotplug thread of the upcoming CPU up and then delegates the rest of the
+ * online bringup to the hotplug thread.
  */
 void cpuhp_online_idle(enum cpuhp_state state)
 {
@@ -1100,6 +1099,12 @@ void cpuhp_online_idle(enum cpuhp_state state)
 	if (state != CPUHP_AP_ONLINE_IDLE)
 		return;
 
+	/*
+	 * Unpark the stopper thread before we start the idle thread; this
+	 * ensures the stopper is always available.
+	 */
+	stop_machine_unpark(smp_processor_id());
+
 	st->state = CPUHP_AP_ONLINE_IDLE;
 	complete_ap_thread(st, true);
 }
