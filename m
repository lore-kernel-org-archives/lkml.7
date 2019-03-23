Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7B7C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 10:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F41E1218A5
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 10:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1SfRDidD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfCWKQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 06:16:05 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54924 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfCWKQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 06:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SRXdbli0DEUn+XCo/CZo5taRbIAvgVjrLLmxoDEsoYU=; b=1SfRDidDFuag6bPQPTJE5yo+s
        jVDXQNgTF1VJeSOk3/AjZhXyFAexTDzFO/F0JcIj4Aq4lQqaKB16libDWTsBN0VoXIUEJKmRDwnK9
        sjDbc5LcAwQf8ZPul0ePpSj2VuokG/p6SAUOsuZc8SZAHUP93u0CPjEQPfZTCHD2gTki8WlR1H96o
        4sLwjZJmfQiB3Pu84BDirO+ukzG0gZpgqRqJH4XWXQaPkZdTCvb/adIVuN5PF7ptgKkV5Vl4QFu9r
        1nQNCpj2Ku0UU0OhgAai8R2ouJvzAMHY+31oGXied1XqAhYbzOM3GyYqJA+BcDEHMGBuoATw8SyW3
        TzJgzKgYQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h7dgl-0003Lo-94; Sat, 23 Mar 2019 10:16:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 51D31203CBE17; Sat, 23 Mar 2019 11:15:40 +0100 (CET)
Date:   Sat, 23 Mar 2019 11:15:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Radu Rendec <radu.rendec@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: pick_next_task() picking the wrong task [v4.9.163]
Message-ID: <20190323101540.GC6058@hirez.programming.kicks-ass.net>
References: <CAD5jUk9s6+dXxAGWNWGbNRZ60QUKN0B37R=pYwci=SDOSSFmFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD5jUk9s6+dXxAGWNWGbNRZ60QUKN0B37R=pYwci=SDOSSFmFg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 05:57:59PM -0400, Radu Rendec wrote:
> Hi Everyone,
> 
> I believe I'm seeing a weird behavior of pick_next_task() where it
> chooses a lower priority task over a higher priority one. The scheduling
> class of the two tasks is also different ('fair' vs. 'rt'). The culprit
> seems to be the optimization at the beginning of the function, where
> fair_sched_class.pick_next_task() is called directly.  I'm running
> v4.9.163, but that piece of code is very similar in recent kernels.
> 
> My use case is quite simple: I have a real-time thread that is woken up
> by a GPIO hardware interrupt. The thread sleeps most of the time in
> poll(), waiting for gpio_sysfs_irq() to wake it. The latency between the
> interrupt and the thread being woken up/scheduled is very important for
> the application. Note that I backported my own commit 03c0a9208bb1, so
> the thread is always woken up synchronously from HW interrupt context.
> 
> Most of the time things work as expected, but sometimes the scheduler
> picks kworker and even the idle task before my real-time thread. I used
> the trace infrastructure to figure out what happens and I'm including a
> snippet below (I apologize for the wide lines).

If only they were wide :/ I had to unwrap them myself..

>      <idle>-0     [000] d.h2   161.202970: gpio_sysfs_irq  <-__handle_irq_event_percpu
>      <idle>-0     [000] d.h2   161.202981: kernfs_notify <-gpio_sysfs_irq
>      <idle>-0     [000] d.h4   161.202998: sched_waking: comm=irqWorker pid=1141 prio=9 target_cpu=000
>      <idle>-0     [000] d.h5   161.203025: sched_wakeup: comm=irqWorker pid=1141 prio=9 target_cpu=000

weird how the next line doesn't have 'n/N' set:

>      <idle>-0     [000] d.h3   161.203047: workqueue_queue_work: work struct=806506b8 function=kernfs_notify_workfn workqueue=8f5dae60 req_cpu=1 cpu=0
>      <idle>-0     [000] d.h3   161.203049: workqueue_activate_work: work struct 806506b8
>      <idle>-0     [000] d.h4   161.203061: sched_waking: comm=kworker/0:1 pid=134 prio=120 target_cpu=000
>      <idle>-0     [000] d.h5   161.203083: sched_wakeup: comm=kworker/0:1 pid=134 prio=120 target_cpu=000

There's that kworker wakeup.

>      <idle>-0     [000] d..2   161.203201: sched_switch: prev_comm=swapper prev_pid=0 prev_prio=120 prev_state=R+ ==> next_comm=kworker/0:1 next_pid=134 next_prio=120

And I agree that that is weird.

> kworker/0:1-134   [000] ....   161.203222: workqueue_execute_start: work struct 806506b8: function kernfs_notify_workfn
> kworker/0:1-134   [000] ...1   161.203286: schedule <-worker_thread
> kworker/0:1-134   [000] d..2   161.203329: sched_switch: prev_comm=kworker/0:1 prev_pid=134 prev_prio=120 prev_state=S ==> next_comm=swapper next_pid=0 next_prio=120
>      <idle>-0     [000] .n.1   161.230287: schedule <-schedule_preempt_disabled

Only here do I see 'n'.

>      <idle>-0     [000] d..2   161.230310: sched_switch: prev_comm=swapper prev_pid=0 prev_prio=120 prev_state=R+ ==> next_comm=irqWorker next_pid=1141 next_prio=9
>   irqWorker-1141  [000] d..3   161.230316: finish_task_switch <-schedule
> 
> The system is Freescale MPC8378 (PowerPC, single processor).
> 
> I instrumented pick_next_task() with trace_printk() and I am sure that
> every time the wrong task is picked, flow goes through the optimization

That's weird, because when you wake a RT task, the:

  rq->nr_running == rq->cfs.h_nr_running

condition should not be true. Maybe try adding trace_printk() to all
rq->nr_running manipulation to see what goes wobbly?

> path and idle_sched_class.pick_next_task() is called directly. When the
> right task is eventually picked, flow goes through the bottom block that
> iterates over all scheduling classes. This probably makes sense: when
> the scheduler runs in the context of the idle task, prev->sched_class is
> no longer fair_sched_class, so the bottom block with the full iteration
> is used. Note that in v4.9.163 the optimization path is taken only when
> prev->sched_class is fair_sched_class, whereas in recent kernels it is
> taken for both fair_sched_class and idle_sched_class.
> 
> Any help or feedback would be much appreciated. In the meantime, I will
> experiment with commenting out the optimization (at the expense of a
> slower scheduler, of course).

It would be very good if you could confirm on the very latest kernel,
instead of on 4.9.
