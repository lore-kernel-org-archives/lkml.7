Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A2AC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85005206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XUzcJcbF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfLJJIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 04:08:51 -0500
Received: from merlin.infradead.org ([205.233.59.134]:39840 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbfLJJIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 04:08:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7Np3mYI/hWzH1a0mhGdWsn2rtKh/CYj0rX2+UZwec7c=; b=XUzcJcbFozAchROC4whTC1LIT
        PyOtRisPGCsrmkFBb9Zt5n7IEnp7nfU/eilqDEwZf12rWEnP1cidCIBjgkOiUdRblxeaLyykYeGkz
        cI1fNjwI3JZf4ZOIjHaY2BfhdZGK4Qf8Tg48sX21a0XhziM3BrBQzMmxnyGqAh6/NxJaazBjw8Nya
        9vizoZJlm6Z9kogvJwVLeUBOo0pUtKBdnSt5xQXzlR+EMC5nTR1nnf5nLO23ZccPHNiX9NKdsd2tw
        9wRSBSTVmRkfJBqd0ZB8FZrkK5ASHKKMET+vFR5XfRBo72z6mbO1LRb2i6DfJxOechfbgMqCbNeG6
        PB06DGH8g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iebVb-0001V1-7U; Tue, 10 Dec 2019 09:08:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 52256306011;
        Tue, 10 Dec 2019 10:07:20 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B51F529DE18D2; Tue, 10 Dec 2019 10:08:39 +0100 (CET)
Date:   Tue, 10 Dec 2019 10:08:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Workqueues splat due to ending up on wrong CPU
Message-ID: <20191210090839.GJ2844@hirez.programming.kicks-ass.net>
References: <20191202015548.GA13391@paulmck-ThinkPad-P72>
 <20191202201338.GH16681@devbig004.ftw2.facebook.com>
 <20191203095521.GH2827@hirez.programming.kicks-ass.net>
 <20191204201150.GA14040@paulmck-ThinkPad-P72>
 <20191205102928.GG2810@hirez.programming.kicks-ass.net>
 <20191205103213.GB2871@hirez.programming.kicks-ass.net>
 <20191205144805.GR2889@paulmck-ThinkPad-P72>
 <20191206185208.GA25636@paulmck-ThinkPad-P72>
 <20191206220020.GA27511@paulmck-ThinkPad-P72>
 <20191209185908.GA8470@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209185908.GA8470@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 10:59:08AM -0800, Paul E. McKenney wrote:
> And it survived!  ;-)
> 
> Peter, could I please have your Signed-off-by?  Or take my Tested-by if
> you would prefer to send it up some other way.

How's this?

---
Subject: cpu/hotplug, stop_machine: Fix stop_machine vs hotplug order
From: Peter Zijlstra <peterz@infradead.org>
Date: Tue Dec 10 09:34:54 CET 2019

Paul reported a very sporadic, rcutorture induced, workqueue failure.
When the planets align, the workqueue rescuer's self-migrate fails and
then triggers a WARN for running a work on the wrong CPU.

Tejun then figured that set_cpus_allowed_ptr()'s stop_one_cpu() call
could be ignored! When stopper->enabled is false, stop_machine will
insta complete the work, without actually doing the work. Worse, it
will not WARN about this (we really should fix this).

It turns out there is a small window where a freshly online'ed CPU is
marked 'online' but doesn't yet have the stopper task running:

	BP				AP

	bringup_cpu()
	  __cpu_up(cpu, idle)	 -->	start_secondary()
					...
					cpu_startup_entry()
	  bringup_wait_for_ap()
	    wait_for_ap_thread() <--	  cpuhp_online_idle()
					  while (1)
					    do_idle()

					... available to run kthreads ...

	    stop_machine_unpark()
	      stopper->enable = true;

Close this by moving the stop_machine_unpark() into
cpuhp_online_idle(), such that the stopper thread is ready before we
start the idle loop and schedule.

Reported-by: "Paul E. McKenney" <paulmck@kernel.org>
Debugged-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -525,8 +525,7 @@ static int bringup_wait_for_ap(unsigned
 	if (WARN_ON_ONCE((!cpu_online(cpu))))
 		return -ECANCELED;
 
-	/* Unpark the stopper thread and the hotplug thread of the target cpu */
-	stop_machine_unpark(cpu);
+	/* Unpark the hotplug thread of the target cpu */
 	kthread_unpark(st->thread);
 
 	/*
@@ -1089,8 +1088,8 @@ void notify_cpu_starting(unsigned int cp
 
 /*
  * Called from the idle task. Wake up the controlling task which brings the
- * stopper and the hotplug thread of the upcoming CPU up and then delegates
- * the rest of the online bringup to the hotplug thread.
+ * hotplug thread of the upcoming CPU up and then delegates the rest of the
+ * online bringup to the hotplug thread.
  */
 void cpuhp_online_idle(enum cpuhp_state state)
 {
@@ -1100,6 +1099,12 @@ void cpuhp_online_idle(enum cpuhp_state
 	if (state != CPUHP_AP_ONLINE_IDLE)
 		return;
 
+	/*
+	 * Unpart the stopper thread before we start the idle loop (and start
+	 * scheduling); this ensures the stopper task is always available.
+	 */
+	stop_machine_unpark(smp_processor_id());
+
 	st->state = CPUHP_AP_ONLINE_IDLE;
 	complete_ap_thread(st, true);
 }
