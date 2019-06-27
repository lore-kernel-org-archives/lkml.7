Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC9AC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97E720644
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="BMRUuHbe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfF0RoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:44:10 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44159 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfF0RoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:44:07 -0400
Received: by mail-lj1-f193.google.com with SMTP id k18so3208576ljc.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 10:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GKpy0tHYE9nhG9KCIJ1rt25gfqZJRMTkcZ17Pqh1Sho=;
        b=BMRUuHbeHOgbvemMWjAUC3U4wv5WlJjNIvWKdmfOacm4DPudsDIucxbyW7uBf5gUEB
         lw4AofuFcjaj2oVQ/rvmCrpcOSy/612a5gzhX3sa5qcmm3l49t8sH4RZYglf3JXC15+8
         bCtvZ1g3erZV0rqxGhHkoDdV7ACLqtot7EOI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GKpy0tHYE9nhG9KCIJ1rt25gfqZJRMTkcZ17Pqh1Sho=;
        b=JQl7my+SDcIXAXj0DIk3wB2w2SIhv9TO8Klw3jk5m6RI7OddMHiDIGjWEjk2ogoKKm
         qcJipkATdgiZ9990cytxBB4gq9exFP0dlHlgG47NwLiRieYZB9Jz1Rsz/fyV+vPxehhw
         x6HoZVqcoI4RgcRy5LKdpI4NAV6Q5IiKEGvH/UAu5io03fcIXcGy+jdXJ1TU3raKEO9M
         Ln0jRg04JGLuZ+JW1DII7XIhIGEXKfdoV5jYDZ62VlU/3Uojz7nE9QfAscJJSNa2QGpA
         l68lnnUBIydIVZlNVT9jrYNvUBGBOuPNn8WohngX2st7qNk4PJkxchLsOpO+O9KAp2Jz
         NF7g==
X-Gm-Message-State: APjAAAW5gOvtHLWIUzzAUwhGqQt4jqJOG4iboWdHHLOp+2Xu1hAjzuGU
        JZGL10U0IAxbvFwZ10PTPRs3vOTQt6GpZAgxQq2LqQ==
X-Google-Smtp-Source: APXvYqy2sMCx76PjvAJ8JdpQiVH+KI9/d04UI1IRN8ZHk4CYnDwZ5OnCglBYKQXspDgNQ+EDjI2fdTBmMyotJOXNItg=
X-Received: by 2002:a2e:654d:: with SMTP id z74mr3422261ljb.111.1561657445370;
 Thu, 27 Jun 2019 10:44:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190626135447.y24mvfuid5fifwjc@linutronix.de>
 <20190626162558.GY26519@linux.ibm.com> <20190627142436.GD215968@google.com>
 <20190627103455.01014276@gandalf.local.home> <20190627153031.GA249127@google.com>
 <CAEXW_YT5LgdP_9SrachU4ZrhV9a7o_DM8eBfgxj=n7yRRyS-TQ@mail.gmail.com> <20190627154011.vbje64x6auaknhx4@linutronix.de>
In-Reply-To: <20190627154011.vbje64x6auaknhx4@linutronix.de>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 27 Jun 2019 13:43:54 -0400
Message-ID: <CAEXW_YTvkSTqwi_jOE2Pr+uD-GC4Xv0CtBEL9YO7=LvJcM3FBQ@mail.gmail.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 11:40 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2019-06-27 11:37:10 [-0400], Joel Fernandes wrote:
> > Sebastian it would be nice if possible to trace where the
> > t->rcu_read_unlock_special is set for this scenario of calling
> > rcu_read_unlock_special, to give a clear idea about whether it was
> > really because of an IPI. I guess we could also add additional RCU
> > debug fields to task_struct (just for debugging) to see where there
> > unlock_special is set.
> >
> > Is there a test to reproduce this, or do I just boot an intel x86_64
> > machine with "threadirqs" and run into it?
>
> Do you want to send me a patch or should I send you my kvm image which
> triggers the bug on boot?

I could reproduce this as well just booting Linus tree with threadirqs
command line and running rcutorture. In 15 seconds or so it locks
up... gdb backtrace shows the recursive lock:

(gdb) bt
#0  queued_spin_lock_slowpath (lock=0xffff88813af16b44, val=0) at
kernel/locking/qspinlock.c:381
#1  0xffffffff81a75a0f in queued_spin_lock (lock=<optimized out>) at
./include/asm-generic/qspinlock.h:81
#2  do_raw_spin_lock_flags (flags=<optimized out>, lock=<optimized
out>) at ./include/linux/spinlock.h:193
#3  __raw_spin_lock_irqsave (lock=<optimized out>) at
./include/linux/spinlock_api_smp.h:119
#4  _raw_spin_lock_irqsave (lock=0xffff88813af16b44) at
kernel/locking/spinlock.c:159
#5  0xffffffff81092158 in try_to_wake_up (p=0xffff88813af16400,
state=3, wake_flags=0) at kernel/sched/core.c:2000
#6  0xffffffff8109265c in wake_up_process (p=<optimized out>) at
kernel/sched/core.c:2114
#7  0xffffffff8106b019 in wakeup_softirqd () at kernel/softirq.c:76
#8  0xffffffff8106b8ef in raise_softirq_irqoff (nr=<optimized out>) at
kernel/softirq.c:437
#9  0xffffffff810d080d in rcu_read_unlock_special (t=<optimized out>)
at kernel/rcu/tree_plugin.h:632
#10 0xffffffff810d0868 in __rcu_read_unlock () at kernel/rcu/tree_plugin.h:414
#11 0xffffffff810aa58e in rcu_read_unlock () at ./include/linux/rcupdate.h:646
#12 cpuacct_charge (tsk=<optimized out>, cputime=<optimized out>) at
kernel/sched/cpuacct.c:352
#13 0xffffffff81097994 in cgroup_account_cputime
(delta_exec=<optimized out>, task=<optimized out>) at
./include/linux/cgroup.h:764
#14 update_curr (cfs_rq=<optimized out>) at kernel/sched/fair.c:843
#15 0xffffffff8109a882 in enqueue_entity (flags=<optimized out>,
se=<optimized out>, cfs_rq=<optimized out>) at
kernel/sched/fair.c:3901
#16 enqueue_task_fair (rq=<optimized out>, p=<optimized out>, flags=9)
at kernel/sched/fair.c:5194
#17 0xffffffff81091699 in enqueue_task (flags=<optimized out>,
p=<optimized out>, rq=<optimized out>) at kernel/sched/core.c:774
#18 activate_task (rq=0xffff88813af16b44, p=0x0 <fixed_percpu_data>,
flags=<optimized out>) at kernel/sched/core.c:795
#19 0xffffffff81091a1a in ttwu_do_activate (rq=0xffff88813af16b44,
p=0x0 <fixed_percpu_data>, wake_flags=0, rf=<optimized out>) at
kernel/sched/core.c:1737
#20 0xffffffff810924b3 in ttwu_queue (wake_flags=<optimized out>,
cpu=<optimized out>, p=<optimized out>) at kernel/sched/core.c:1882
#21 try_to_wake_up (p=0xffff88813af16400, state=<optimized out>,
wake_flags=0) at kernel/sched/core.c:2092
#22 0xffffffff8109265c in wake_up_process (p=<optimized out>) at
kernel/sched/core.c:2114
#23 0xffffffff8106b019 in wakeup_softirqd () at kernel/softirq.c:76
#24 0xffffffff8106b843 in invoke_softirq () at kernel/softirq.c:383
#25 irq_exit () at kernel/softirq.c:413
#26 0xffffffff81c01f8e in exiting_irq () at ./arch/x86/include/asm/apic.h:536


>
> Sebastian
