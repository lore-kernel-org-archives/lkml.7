Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000EAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F922190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDcr2xGW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfCVV6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 17:58:11 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36372 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbfCVV6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 17:58:11 -0400
Received: by mail-oi1-f195.google.com with SMTP id t206so2876561oib.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 14:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=KWMT6xCPa3JNohfq0P0+VfV8CBC12ANXNjneyNv1qzk=;
        b=MDcr2xGWyebINcCmfRCpEb2HGO/mvGidGYOdadFwdQPei4XFUyfMngBw8OvjT0ZVN3
         mNTpjFn4Sj8HkyOXob/AfsWcRHAe7Gn9Nk+Ipo8bktbuGSu2AEqOp4dkiXMrezA+pBO3
         IDZPhxbJpfy1wru+wYC9mbtn5shzNU/ukO/NV0Oh3FQ/gNKO9I4HANg+dAXQnC+oZCS9
         A2Px+Wa+0J3LDSgo2p6Fghn/NhQWhEAzMgr4Y+VlPRRSlaqH1tYCqIsdE0Lm3vQv5JNM
         ctHIzYg+HvOg/UPRjt3D9r4Hd4wbJiio9QemSS4s6EO6/3mZkjHYL1x+v19+95ea+cuM
         oCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=KWMT6xCPa3JNohfq0P0+VfV8CBC12ANXNjneyNv1qzk=;
        b=e39oFqaDzSY697Ht3xNwqpklcJgYE/EXntHOkEldLQOM8LW+liaEpstdyRA1piZuR6
         qZtKk5B3V5d2cviEg7oRa6tvr2pjifhLKuIzrYSkqaBGWABxPxTWKtJWoLLfCNA7LTpo
         v1ug2vXrzljSgCGSQ1Q5zMgE8wCR5LiDdG5wnQDeJhQIfoN54Adzm/ehYnOTRAo4S9v2
         mU2dHd7ddboxA6KSGDZtn2TKcJF2w4NUHLUfm/VwFkmGs+opwI+SI/lhEZHVsdTignTs
         V6lwY2DOfdTbmzDBchjdu0XoOLVvxsDHmb8AJvzkHFuNof8dizkhubunM3Kgkave108v
         TXzQ==
X-Gm-Message-State: APjAAAWWTH/4uUJPzGUeJaas1yBYS2CXoHrecpy6NGXtIjzVI4+DRjQv
        AX62RmI0PvBT33IEaNxfRzq6Ivvb87bSY5ujuxUGFxPC4UY=
X-Google-Smtp-Source: APXvYqzjMtkU5bfN/boI3OCQnxfF9b0j0Lf+hHha+lt6Ir7pFORjMUhkbjq/QP1cbMSyBsJgxNPUPSEt4uOwRODjaBw=
X-Received: by 2002:aca:5512:: with SMTP id j18mr3583190oib.65.1553291890007;
 Fri, 22 Mar 2019 14:58:10 -0700 (PDT)
MIME-Version: 1.0
From:   Radu Rendec <radu.rendec@gmail.com>
Date:   Fri, 22 Mar 2019 17:57:59 -0400
Message-ID: <CAD5jUk9s6+dXxAGWNWGbNRZ60QUKN0B37R=pYwci=SDOSSFmFg@mail.gmail.com>
Subject: pick_next_task() picking the wrong task [v4.9.163]
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Everyone,

I believe I'm seeing a weird behavior of pick_next_task() where it
chooses a lower priority task over a higher priority one. The scheduling
class of the two tasks is also different ('fair' vs. 'rt'). The culprit
seems to be the optimization at the beginning of the function, where
fair_sched_class.pick_next_task() is called directly.  I'm running
v4.9.163, but that piece of code is very similar in recent kernels.

My use case is quite simple: I have a real-time thread that is woken up
by a GPIO hardware interrupt. The thread sleeps most of the time in
poll(), waiting for gpio_sysfs_irq() to wake it. The latency between the
interrupt and the thread being woken up/scheduled is very important for
the application. Note that I backported my own commit 03c0a9208bb1, so
the thread is always woken up synchronously from HW interrupt context.

Most of the time things work as expected, but sometimes the scheduler
picks kworker and even the idle task before my real-time thread. I used
the trace infrastructure to figure out what happens and I'm including a
snippet below (I apologize for the wide lines).

     <idle>-0     [000] d.h2   161.202970: gpio_sysfs_irq
<-__handle_irq_event_percpu
     <idle>-0     [000] d.h2   161.202981: kernfs_notify <-gpio_sysfs_irq
     <idle>-0     [000] d.h4   161.202998: sched_waking:
comm=irqWorker pid=1141 prio=9 target_cpu=000
     <idle>-0     [000] d.h5   161.203025: sched_wakeup:
comm=irqWorker pid=1141 prio=9 target_cpu=000
     <idle>-0     [000] d.h3   161.203047: workqueue_queue_work: work
struct=806506b8 function=kernfs_notify_workfn workqueue=8f5dae60
req_cpu=1 cpu=0
     <idle>-0     [000] d.h3   161.203049: workqueue_activate_work:
work struct 806506b8
     <idle>-0     [000] d.h4   161.203061: sched_waking:
comm=kworker/0:1 pid=134 prio=120 target_cpu=000
     <idle>-0     [000] d.h5   161.203083: sched_wakeup:
comm=kworker/0:1 pid=134 prio=120 target_cpu=000
     <idle>-0     [000] d..2   161.203201: sched_switch:
prev_comm=swapper prev_pid=0 prev_prio=120 prev_state=R+ ==>
next_comm=kworker/0:1 next_pid=134 next_prio=120
kworker/0:1-134   [000] ....   161.203222: workqueue_execute_start:
work struct 806506b8: function kernfs_notify_workfn
kworker/0:1-134   [000] ...1   161.203286: schedule <-worker_thread
kworker/0:1-134   [000] d..2   161.203329: sched_switch:
prev_comm=kworker/0:1 prev_pid=134 prev_prio=120 prev_state=S ==>
next_comm=swapper next_pid=0 next_prio=120
     <idle>-0     [000] .n.1   161.230287: schedule <-schedule_preempt_disabled
     <idle>-0     [000] d..2   161.230310: sched_switch:
prev_comm=swapper prev_pid=0 prev_prio=120 prev_state=R+ ==>
next_comm=irqWorker next_pid=1141 next_prio=9
  irqWorker-1141  [000] d..3   161.230316: finish_task_switch <-schedule

The system is Freescale MPC8378 (PowerPC, single processor).

I instrumented pick_next_task() with trace_printk() and I am sure that
every time the wrong task is picked, flow goes through the optimization
path and idle_sched_class.pick_next_task() is called directly. When the
right task is eventually picked, flow goes through the bottom block that
iterates over all scheduling classes. This probably makes sense: when
the scheduler runs in the context of the idle task, prev->sched_class is
no longer fair_sched_class, so the bottom block with the full iteration
is used. Note that in v4.9.163 the optimization path is taken only when
prev->sched_class is fair_sched_class, whereas in recent kernels it is
taken for both fair_sched_class and idle_sched_class.

Any help or feedback would be much appreciated. In the meantime, I will
experiment with commenting out the optimization (at the expense of a
slower scheduler, of course).

Best regards,
Radu Rendec
