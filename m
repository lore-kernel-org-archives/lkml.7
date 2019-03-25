Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E854EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 02:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C10B20830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 02:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3ZMG+s/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbfCYCRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 22:17:51 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37170 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729262AbfCYCRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 22:17:50 -0400
Received: by mail-io1-f68.google.com with SMTP id x7so6368832ioh.4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 19:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Y+KEPd1TMopOl3z+MjHOYAas7qBgfzTSWefGqZyhty8=;
        b=F3ZMG+s/oknWvDj8tDHBVrFa1Y9QJU8kridAF37F2wxQxu837pn3VK5J4CPnJ8RI7R
         4WUNQCKLgr/uDZQNsLFeAeJnzuAfXr/TkVYBTiP9Ufl/LSHj56mdRrjCCtN3WOpbRFh9
         sc1lfyCgPjoCveOlYOYVJ3k+Vakz838Ca2R0kRfQaF7lt28Q5KFtC6cGNGYL4hgnbKLR
         kUNuWKHzSFNaYWptsEpkYFSi528fhx6RzMpDwNbmoth3fJRNPAeVfWydjan3tTGHPpjl
         grU0Uhb8hdu64GAd6JFtDiVR6Tw9KK9zj7IkUmoHHelaC16mUEJSJgF3KQTiw7Ed1eKa
         gj0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Y+KEPd1TMopOl3z+MjHOYAas7qBgfzTSWefGqZyhty8=;
        b=AUZsBZseyKO+Pqv3yq4DpEfIkGtTc95sfYDZYnrvCLRBXwugj5iO5TczIz7RJLQC+o
         45NjjYuZuJ2k7Ds5sF1q67ly3mEUwPnrJ+rTIuDL+dWRLBJdfRiCgX5Tp8tyoU8kjML9
         hkSUUlPW8yEZlqrMbnqPH7gzS8Dcq0qNWkoeAAjJlUjIWjRGuXQ1lV9/WHbOBlrSvq0+
         IfzSRG32dsTc6RNHB4qCBtpIW9EjiY2+4oeWjXIjTroiDDMcwPaTw0lvbJupI3YZStxo
         4QiBUvENtTqauw8bPKdbH1mNP7cKAsqLb+eoOjCbnhOMOddvCzX3XKXSwDIvjV2IPejD
         6XJQ==
X-Gm-Message-State: APjAAAXQUGlV9yE1EgpDcvk63d7mI7y/zBy8GH4tU259dsCM2hEJgjfe
        U+vmTIkScUWqQIRjpKifKmpc0VIbwjw=
X-Google-Smtp-Source: APXvYqye1QiINLZlgqnVBUcM3lD3jjygO+yP0CQWNHtz7ZjPO4O5Rf0ZChbhk4MpIE57OzrPLUwCnQ==
X-Received: by 2002:a5e:8e45:: with SMTP id r5mr12171877ioo.221.1553480269390;
        Sun, 24 Mar 2019 19:17:49 -0700 (PDT)
Received: from bat.mindbit.ro (CPE00fc8d79db03-CM00fc8d79db00.cpe.net.fido.ca. [72.140.67.131])
        by smtp.gmail.com with ESMTPSA id k18sm6801095iob.60.2019.03.24.19.17.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 24 Mar 2019 19:17:48 -0700 (PDT)
Message-ID: <b906290273a29628c986d1ef9bb527e16e681f71.camel@gmail.com>
Subject: Re: pick_next_task() picking the wrong task [v4.9.163]
From:   Radu Rendec <radu.rendec@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Date:   Sun, 24 Mar 2019 22:17:46 -0400
In-Reply-To: <20190323101540.GC6058@hirez.programming.kicks-ass.net>
References: <CAD5jUk9s6+dXxAGWNWGbNRZ60QUKN0B37R=pYwci=SDOSSFmFg@mail.gmail.com>
         <20190323101540.GC6058@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-03-23 at 11:15 +0100, Peter Zijlstra wrote:
> On Fri, Mar 22, 2019 at 05:57:59PM -0400, Radu Rendec wrote:
> > Hi Everyone,
> > 
> > I believe I'm seeing a weird behavior of pick_next_task() where it
> > chooses a lower priority task over a higher priority one. The scheduling
> > class of the two tasks is also different ('fair' vs. 'rt'). The culprit
> > seems to be the optimization at the beginning of the function, where
> > fair_sched_class.pick_next_task() is called directly.  I'm running
> > v4.9.163, but that piece of code is very similar in recent kernels.
> > 
> > My use case is quite simple: I have a real-time thread that is woken up
> > by a GPIO hardware interrupt. The thread sleeps most of the time in
> > poll(), waiting for gpio_sysfs_irq() to wake it. The latency between the
> > interrupt and the thread being woken up/scheduled is very important for
> > the application. Note that I backported my own commit 03c0a9208bb1, so
> > the thread is always woken up synchronously from HW interrupt context.
> > 
> > Most of the time things work as expected, but sometimes the scheduler
> > picks kworker and even the idle task before my real-time thread. I used
> > the trace infrastructure to figure out what happens and I'm including a
> > snippet below (I apologize for the wide lines).
> 
> If only they were wide :/ I had to unwrap them myself..

Sorry about that! Wonders of using the gmail web interface. I'll pay
more attention in the future.

> >      <idle>-0     [000] d.h2   161.202970: gpio_sysfs_irq  <-__handle_irq_event_percpu
> >      <idle>-0     [000] d.h2   161.202981: kernfs_notify <-gpio_sysfs_irq
> >      <idle>-0     [000] d.h4   161.202998: sched_waking: comm=irqWorker pid=1141 prio=9 target_cpu=000
> >      <idle>-0     [000] d.h5   161.203025: sched_wakeup: comm=irqWorker pid=1141 prio=9 target_cpu=000
> 
> weird how the next line doesn't have 'n/N' set:
> 
> >      <idle>-0     [000] d.h3   161.203047: workqueue_queue_work: work struct=806506b8 function=kernfs_notify_workfn workqueue=8f5dae60 req_cpu=1 cpu=0
> >      <idle>-0     [000] d.h3   161.203049: workqueue_activate_work: work struct 806506b8
> >      <idle>-0     [000] d.h4   161.203061: sched_waking: comm=kworker/0:1 pid=134 prio=120 target_cpu=000
> >      <idle>-0     [000] d.h5   161.203083: sched_wakeup: comm=kworker/0:1 pid=134 prio=120 target_cpu=000
> 
> There's that kworker wakeup.
> 
> >      <idle>-0     [000] d..2   161.203201: sched_switch: prev_comm=swapper prev_pid=0 prev_prio=120 prev_state=R+ ==> next_comm=kworker/0:1 next_pid=134 next_prio=120
> 
> And I agree that that is weird.
> 
> > kworker/0:1-134   [000] ....   161.203222: workqueue_execute_start: work struct 806506b8: function kernfs_notify_workfn
> > kworker/0:1-134   [000] ...1   161.203286: schedule <-worker_thread
> > kworker/0:1-134   [000] d..2   161.203329: sched_switch: prev_comm=kworker/0:1 prev_pid=134 prev_prio=120 prev_state=S ==> next_comm=swapper next_pid=0 next_prio=120
> >      <idle>-0     [000] .n.1   161.230287: schedule <-schedule_preempt_disabled
> 
> Only here do I see 'n'.

Looking at other captures I can see 'n' starting at sched_wakeup for
irqWorker. Perhaps there was something wrong with this one or I copied
the wrong line.

> >      <idle>-0     [000] d..2   161.230310: sched_switch: prev_comm=swapper prev_pid=0 prev_prio=120 prev_state=R+ ==> next_comm=irqWorker next_pid=1141 next_prio=9
> >   irqWorker-1141  [000] d..3   161.230316: finish_task_switch <-schedule
> > 
> > The system is Freescale MPC8378 (PowerPC, single processor).
> > 
> > I instrumented pick_next_task() with trace_printk() and I am sure that
> > every time the wrong task is picked, flow goes through the optimization
> 
> That's weird, because when you wake a RT task, the:
> 
>   rq->nr_running == rq->cfs.h_nr_running
> 
> condition should not be true. Maybe try adding trace_printk() to all
> rq->nr_running manipulation to see what goes wobbly?

Sure, I will try that and come back with the results.

FWIW, I tried to comment out the entire optimization and force the
"slow" path that goes through every scheduling class. Surprisingly,
rt_sched_class.pick_next_task() returns NULL.

> > path and idle_sched_class.pick_next_task() is called directly. When the
> > right task is eventually picked, flow goes through the bottom block that
> > iterates over all scheduling classes. This probably makes sense: when
> > the scheduler runs in the context of the idle task, prev->sched_class is
> > no longer fair_sched_class, so the bottom block with the full iteration
> > is used. Note that in v4.9.163 the optimization path is taken only when
> > prev->sched_class is fair_sched_class, whereas in recent kernels it is
> > taken for both fair_sched_class and idle_sched_class.
> > 
> > Any help or feedback would be much appreciated. In the meantime, I will
> > experiment with commenting out the optimization (at the expense of a
> > slower scheduler, of course).
> 
> It would be very good if you could confirm on the very latest kernel,
> instead of on 4.9.

Of course. I spent quite some time on this and fortunately I've got
something. I can now reproduce the problem on 5.0.3 with a 250 lines
test program on a Raspberry Pi 1B. IMO this is far better than what I
had on Friday (4.9.x with a huge proprietary application, running on
custom hardware). Not quite "the very latest kernel", but pretty close.
That's the latest thing that I could run on the Pi, as it requires a
whole bunch of custom patches that they haven't upstreamed yet (ugh!)

I can upload the full trace log and the test program and post the links
if you find any value in that. In the meantime, I'm including the log
around the HW IRQ below (this time with unfolded lines, I promise).
Thread names are different in the test program. The "interesting" thread
is now called "gpio-irq-lat".

Thank you for looking into this. I really appreciate it!

Best regards,
Radu Rendec


<idle>-0     [000] d.h1   290.675001: gpio_sysfs_irq <-__handle_irq_event_percpu
<idle>-0     [000] d.h1   290.675003: preempt_count_add <-gpio_sysfs_irq
<idle>-0     [000] d.h2   290.675005: ktime_get <-gpio_sysfs_irq
<idle>-0     [000] d.h2   290.675007: clocksource_mmio_readl_up <-ktime_get
<idle>-0     [000] d.h2   290.675022: gpio_sysfs_irq: new 290569083832 0
<idle>-0     [000] d.h2   290.675028: preempt_count_sub <-gpio_sysfs_irq
<idle>-0     [000] d.h1   290.675031: kernfs_notify <-gpio_sysfs_irq
<idle>-0     [000] d.h1   290.675033: preempt_count_add <-kernfs_notify
<idle>-0     [000] d.h2   290.675036: __wake_up <-kernfs_notify
<idle>-0     [000] d.h2   290.675038: __wake_up_common_lock <-__wake_up
<idle>-0     [000] d.h2   290.675040: preempt_count_add <-__wake_up_common_lock
<idle>-0     [000] d.h3   290.675042: __wake_up_common <-__wake_up_common_lock
<idle>-0     [000] d.h3   290.675045: pollwake <-__wake_up_common
<idle>-0     [000] d.h3   290.675048: default_wake_function <-pollwake
<idle>-0     [000] d.h3   290.675050: try_to_wake_up <-default_wake_function
<idle>-0     [000] d.h3   290.675052: preempt_count_add <-try_to_wake_up
<idle>-0     [000] d.h4   290.675056: sched_waking: comm=gpio-irq-lat pid=1164 prio=9 target_cpu=000
<idle>-0     [000] d.h4   290.675060: preempt_count_add <-try_to_wake_up
<idle>-0     [000] d.h5   290.675063: update_rq_clock <-try_to_wake_up
<idle>-0     [000] d.h5   290.675066: activate_task <-try_to_wake_up
<idle>-0     [000] d.h5   290.675069: enqueue_task_rt <-activate_task
<idle>-0     [000] d.h5   290.675072: dequeue_rt_stack <-enqueue_task_rt
<idle>-0     [000] d.h5   290.675074: dequeue_top_rt_rq.constprop.10 <-dequeue_rt_stack
<idle>-0     [000] d.h5   290.675079: preempt_count_add <-enqueue_task_rt
<idle>-0     [000] d.h6   290.675082: preempt_count_sub <-enqueue_task_rt
<idle>-0     [000] d.h5   290.675084: enqueue_top_rt_rq.constprop.12 <-enqueue_task_rt
<idle>-0     [000] d.h5   290.675087: ttwu_do_wakeup.constprop.30 <-try_to_wake_up
<idle>-0     [000] d.h5   290.675089: check_preempt_curr <-ttwu_do_wakeup.constprop.30
<idle>-0     [000] d.h5   290.675092: resched_curr <-check_preempt_curr
<idle>-0     [000] dnh5   290.675099: sched_wakeup: comm=gpio-irq-lat pid=1164 prio=9 target_cpu=000
<idle>-0     [000] dnh5   290.675101: preempt_count_sub <-try_to_wake_up
<idle>-0     [000] dnh4   290.675104: ttwu_stat.constprop.32 <-try_to_wake_up
<idle>-0     [000] dnh4   290.675106: preempt_count_sub <-try_to_wake_up
<idle>-0     [000] dnh3   290.675110: preempt_count_sub <-__wake_up_common_lock
<idle>-0     [000] dnh2   290.675114: preempt_count_sub <-kernfs_notify
<idle>-0     [000] dnh1   290.675117: preempt_count_add <-kernfs_notify
<idle>-0     [000] dnh2   290.675119: kernfs_get <-kernfs_notify
<idle>-0     [000] dnh2   290.675122: queue_work_on <-kernfs_notify
<idle>-0     [000] dnh2   290.675125: __queue_work <-queue_work_on
<idle>-0     [000] dnh2   290.675128: get_work_pool <-__queue_work
<idle>-0     [000] dnh2   290.675132: preempt_count_add <-__queue_work
<idle>-0     [000] dnh3   290.675136: workqueue_queue_work: work struct=4b4b2bdf function=kernfs_notify_workfn workqueue=8231353a req_cpu=1 cpu=0
<idle>-0     [000] dnh3   290.675141: workqueue_activate_work: work struct 4b4b2bdf
<idle>-0     [000] dnh3   290.675146: insert_work <-__queue_work
<idle>-0     [000] dnh3   290.675148: get_pwq <-insert_work
<idle>-0     [000] dnh3   290.675151: wake_up_process <-insert_work
<idle>-0     [000] dnh3   290.675153: try_to_wake_up <-wake_up_process
<idle>-0     [000] dnh3   290.675155: preempt_count_add <-try_to_wake_up
<idle>-0     [000] dnh4   290.675157: sched_waking: comm=kworker/0:2 pid=57 prio=120 target_cpu=000
<idle>-0     [000] dnh4   290.675160: preempt_count_add <-try_to_wake_up
<idle>-0     [000] dnh5   290.675162: update_rq_clock <-try_to_wake_up
<idle>-0     [000] dnh5   290.675164: activate_task <-try_to_wake_up
<idle>-0     [000] dnh5   290.675167: enqueue_task_fair <-activate_task
<idle>-0     [000] dnh5   290.675170: update_curr <-enqueue_task_fair
<idle>-0     [000] dnh5   290.675174: update_cfs_group <-enqueue_task_fair
<idle>-0     [000] dnh5   290.675178: check_spread <-enqueue_task_fair
<idle>-0     [000] dnh5   290.675180: __enqueue_entity <-enqueue_task_fair
<idle>-0     [000] dnh5   290.675184: hrtick_update <-enqueue_task_fair
<idle>-0     [000] dnh5   290.675186: wq_worker_waking_up <-try_to_wake_up
<idle>-0     [000] dnh5   290.675188: kthread_data <-wq_worker_waking_up
<idle>-0     [000] dnh5   290.675191: ttwu_do_wakeup.constprop.30 <-try_to_wake_up
<idle>-0     [000] dnh5   290.675193: check_preempt_curr <-ttwu_do_wakeup.constprop.30
<idle>-0     [000] dnh5   290.675195: resched_curr <-check_preempt_curr
<idle>-0     [000] dnh5   290.675198: sched_wakeup: comm=kworker/0:2 pid=57 prio=120 target_cpu=000
<idle>-0     [000] dnh5   290.675200: preempt_count_sub <-try_to_wake_up
<idle>-0     [000] dnh4   290.675202: ttwu_stat.constprop.32 <-try_to_wake_up
<idle>-0     [000] dnh4   290.675204: preempt_count_sub <-try_to_wake_up
<idle>-0     [000] dnh3   290.675206: preempt_count_sub <-__queue_work
<idle>-0     [000] dnh2   290.675209: preempt_count_sub <-kernfs_notify
<idle>-0     [000] dnh1   290.675212: irq_handler_exit: irq=160 ret=handled
<idle>-0     [000] dnh1   290.675215: add_interrupt_randomness <-handle_irq_event_percpu
<idle>-0     [000] dnh1   290.675218: read_current_timer <-add_interrupt_randomness
<idle>-0     [000] dnh1   290.675221: note_interrupt <-handle_irq_event_percpu
<idle>-0     [000] dnh1   290.675223: preempt_count_add <-handle_irq_event
<idle>-0     [000] dnh2   290.675226: preempt_count_sub <-handle_edge_irq
<idle>-0     [000] dnh1   290.675229: armctrl_unmask_irq <-bcm2835_gpio_irq_handler
<idle>-0     [000] dnh1   290.675231: irq_exit <-__handle_domain_irq
<idle>-0     [000] dnh1   290.675233: preempt_count_sub <-irq_exit
<idle>-0     [000] dn.1   290.675237: idle_cpu <-irq_exit
<idle>-0     [000] dn.1   290.675240: rcu_irq_exit <-irq_exit
<idle>-0     [000] dn.1   290.675242: get_next_armctrl_hwirq <-bcm2835_handle_irq
<idle>-0     [000] dn.2   290.675246: __srcu_read_lock <-trace_hardirqs_on
<idle>-0     [000] dn.2   290.675248: rcu_irq_enter_irqson <-trace_hardirqs_on
<idle>-0     [000] dn.2   290.675250: rcu_irq_enter <-rcu_irq_enter_irqson
<idle>-0     [000] dn.1   290.675253: irq_enable: caller=__irq_svc+0x78/0x94 parent=do_idle+0xc4/0x138
<idle>-0     [000] dn.2   290.675255: rcu_irq_exit_irqson <-trace_hardirqs_on
<idle>-0     [000] dn.2   290.675257: rcu_irq_exit <-rcu_irq_exit_irqson
<idle>-0     [000] dn.2   290.675259: __srcu_read_unlock <-trace_hardirqs_on
<idle>-0     [000] .n.1   290.675262: arch_cpu_idle_exit <-do_idle
<idle>-0     [000] .n.1   290.675264: ledtrig_cpu <-arch_cpu_idle_exit
<idle>-0     [000] .n.1   290.675266: led_trigger_event <-ledtrig_cpu
<idle>-0     [000] .n.1   290.675268: preempt_count_add <-led_trigger_event
<idle>-0     [000] .n.2   290.675270: preempt_count_sub <-led_trigger_event
<idle>-0     [000] .n.1   290.675273: led_trigger_event <-ledtrig_cpu
<idle>-0     [000] .n.1   290.675275: preempt_count_add <-led_trigger_event
<idle>-0     [000] .n.2   290.675277: preempt_count_sub <-led_trigger_event
<idle>-0     [000] .n.1   290.675279: tick_nohz_idle_exit <-do_idle
<idle>-0     [000] dn.2   290.675282: __srcu_read_lock <-trace_hardirqs_off
<idle>-0     [000] dn.2   290.675284: rcu_irq_enter_irqson <-trace_hardirqs_off
<idle>-0     [000] dn.2   290.675286: rcu_irq_enter <-rcu_irq_enter_irqson
<idle>-0     [000] dn.1   290.675288: irq_disable: caller=tick_nohz_idle_exit+0x24/0x130 parent=do_idle+0xcc/0x138
<idle>-0     [000] dn.2   290.675290: rcu_irq_exit_irqson <-trace_hardirqs_off
<idle>-0     [000] dn.2   290.675292: rcu_irq_exit <-rcu_irq_exit_irqson
<idle>-0     [000] dn.2   290.675294: __srcu_read_unlock <-trace_hardirqs_off
<idle>-0     [000] dn.1   290.675296: ktime_get <-tick_nohz_idle_exit
<idle>-0     [000] dn.1   290.675298: clocksource_mmio_readl_up <-ktime_get
<idle>-0     [000] dn.1   290.675301: __tick_nohz_idle_restart_tick.constprop.4 <-tick_nohz_idle_exit
<idle>-0     [000] dn.1   290.675304: timer_clear_idle <-__tick_nohz_idle_restart_tick.constprop.4
<idle>-0     [000] dn.1   290.675306: calc_load_nohz_stop <-__tick_nohz_idle_restart_tick.constprop.4
<idle>-0     [000] dn.1   290.675309: hrtimer_cancel <-__tick_nohz_idle_restart_tick.constprop.4
<idle>-0     [000] dn.1   290.675311: hrtimer_try_to_cancel <-hrtimer_cancel
<idle>-0     [000] dn.1   290.675313: preempt_count_add <-hrtimer_try_to_cancel
<idle>-0     [000] dn.2   290.675317: hrtimer_cancel: hrtimer=f8522568
<idle>-0     [000] dn.2   290.675319: __remove_hrtimer <-hrtimer_try_to_cancel
<idle>-0     [000] dn.2   290.675324: preempt_count_sub <-hrtimer_try_to_cancel
<idle>-0     [000] dn.1   290.675327: hrtimer_forward <-__tick_nohz_idle_restart_tick.constprop.4
<idle>-0     [000] dn.1   290.675331: hrtimer_start_range_ns <-__tick_nohz_idle_restart_tick.constprop.4
<idle>-0     [000] dn.1   290.675333: preempt_count_add <-hrtimer_start_range_ns
<idle>-0     [000] dn.2   290.675337: enqueue_hrtimer <-hrtimer_start_range_ns
<idle>-0     [000] dn.2   290.675341: hrtimer_start: hrtimer=f8522568 function=tick_sched_timer expires=290570000000 softexpires=290570000000 mode=ABS|PINNED
<idle>-0     [000] dn.2   290.675346: hrtimer_reprogram.constprop.7 <-hrtimer_start_range_ns
<idle>-0     [000] dn.2   290.675352: tick_program_event <-hrtimer_reprogram.constprop.7
<idle>-0     [000] dn.2   290.675356: clockevents_program_event <-tick_program_event
<idle>-0     [000] dn.2   290.675358: ktime_get <-clockevents_program_event
<idle>-0     [000] dn.2   290.675360: clocksource_mmio_readl_up <-ktime_get
<idle>-0     [000] dn.2   290.675365: bcm2835_time_set_next_event <-clockevents_program_event
<idle>-0     [000] dn.2   290.675368: preempt_count_sub <-hrtimer_start_range_ns
<idle>-0     [000] dn.1   290.675370: account_idle_ticks <-__tick_nohz_idle_restart_tick.constprop.4
<idle>-0     [000] dn.1   290.675373: account_idle_time <-account_idle_ticks
<idle>-0     [000] dn.2   290.675376: __srcu_read_lock <-trace_hardirqs_on
<idle>-0     [000] dn.2   290.675378: rcu_irq_enter_irqson <-trace_hardirqs_on
<idle>-0     [000] dn.2   290.675380: rcu_irq_enter <-rcu_irq_enter_irqson
<idle>-0     [000] dn.1   290.675382: irq_enable: caller=tick_nohz_idle_exit+0xc0/0x130 parent=do_idle+0xcc/0x138
<idle>-0     [000] dn.2   290.675385: rcu_irq_exit_irqson <-trace_hardirqs_on
<idle>-0     [000] dn.2   290.675387: rcu_irq_exit <-rcu_irq_exit_irqson
<idle>-0     [000] dn.2   290.675389: __srcu_read_unlock <-trace_hardirqs_on
<idle>-0     [000] .n.1   290.675391: schedule_idle <-do_idle
<idle>-0     [000] dn.2   290.675395: __srcu_read_lock <-trace_hardirqs_off
<idle>-0     [000] dn.2   290.675398: rcu_irq_enter_irqson <-trace_hardirqs_off
<idle>-0     [000] dn.2   290.675400: rcu_irq_enter <-rcu_irq_enter_irqson
<idle>-0     [000] dn.1   290.675402: irq_disable: caller=__schedule+0x68/0x8f0 parent=schedule_idle+0x44/0x88
<idle>-0     [000] dn.2   290.675404: rcu_irq_exit_irqson <-trace_hardirqs_off
<idle>-0     [000] dn.2   290.675406: rcu_irq_exit <-rcu_irq_exit_irqson
<idle>-0     [000] dn.2   290.675408: __srcu_read_unlock <-trace_hardirqs_off
<idle>-0     [000] dn.1   290.675410: rcu_note_context_switch <-__schedule
<idle>-0     [000] dn.1   290.675414: rcu_utilization: Start context switch
<idle>-0     [000] dn.1   290.675417: rcu_preempt_deferred_qs <-rcu_note_context_switch
<idle>-0     [000] dn.1   290.675419: rcu_qs <-rcu_note_context_switch
<idle>-0     [000] dn.1   290.675422: rcu_utilization: End context switch
<idle>-0     [000] dn.1   290.675424: preempt_count_add <-__schedule
<idle>-0     [000] dn.2   290.675427: update_rq_clock <-__schedule
<idle>-0     [000] dn.2   290.675430: pick_next_task_fair <-__schedule
<idle>-0     [000] dn.2   290.675432: put_prev_task_idle <-pick_next_task_fair
<idle>-0     [000] dn.2   290.675434: pick_next_entity <-pick_next_task_fair
<idle>-0     [000] dn.2   290.675437: clear_buddies <-pick_next_entity
<idle>-0     [000] dn.2   290.675440: set_next_entity <-pick_next_task_fair
<idle>-0     [000] d..2   290.675450: sched_switch: prev_comm=swapper prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=kworker/0:2 next_pid=57 next_prio=120

