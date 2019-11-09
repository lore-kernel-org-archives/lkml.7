Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AADC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 00:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C74762085B
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 00:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573347415;
	bh=TqQM3a2mjtenhKkD4XLjxa4RUDKOtzbHzKfilSIPSE4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=iimUPMnzELuFyfQiV9ydGsVNy9bCzOTd3qufRWY6xs64I2sBXVKzFibh4KLQhtHI0
	 unKqlBHrhoBosKTavDUTueGD+j62MLxjwS+8WEdHVHkA7JFPjSbUBuXscx1SGgxiJv
	 0nr+iKJsBQUiPF7oHIBev8aq6OCzRHXRxw9IHMQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfKJA42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 19:56:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:38754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbfKJA42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 19:56:28 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [216.9.110.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5901F2085B;
        Sun, 10 Nov 2019 00:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573347386;
        bh=TqQM3a2mjtenhKkD4XLjxa4RUDKOtzbHzKfilSIPSE4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jMJToyWzfwbDatpSCGNfYdQF5wcL37fADS30N4zuxsO8CTuNJznmsnRr3595pPxKH
         szsfolH7Ck1w/+A3WYGyVpbNlwFnh6lZ4F7ealpJjwqat+OoiuEaKN5/xdz6koKOD2
         HA1EAMOWaaudhY/ooqfUeWb8cmUnJmRY+9Sq9yHw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 689C33520639; Sat,  9 Nov 2019 09:54:40 -0800 (PST)
Date:   Sat, 9 Nov 2019 09:54:40 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH 1/2] list: add hlist_unhashed_lockless()
Message-ID: <20191109175440.GJ20975@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191107193738.195914-1-edumazet@google.com>
 <20191108192448.GB20975@paulmck-ThinkPad-P72>
 <CANn89iKNLESN7U7BtyzkC6WLVn__Hm727A5cRm6PDuzG5+E4vA@mail.gmail.com>
 <20191108234224.GF20975@paulmck-ThinkPad-P72>
 <CANn89iJsh5X4k2SsT0iNdRJPs4k2Hun3EJak1iomcKahmEJJwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iJsh5X4k2SsT0iNdRJPs4k2Hun3EJak1iomcKahmEJJwg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 07:15:16PM -0800, Eric Dumazet wrote:
> On Fri, Nov 8, 2019 at 3:42 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Fri, Nov 08, 2019 at 12:17:49PM -0800, Eric Dumazet wrote:
> > > On Fri, Nov 8, 2019 at 11:24 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > On Thu, Nov 07, 2019 at 11:37:37AM -0800, Eric Dumazet wrote:
> > > > > We would like to use hlist_unhashed() from timer_pending(),
> > > > > which runs without protection of a lock.
> > > > >
> > > > > Note that other callers might also want to use this variant.
> > > > >
> > > > > Instead of forcing a READ_ONCE() for all hlist_unhashed()
> > > > > callers, add a new helper with an explicit _lockless suffix
> > > > > in the name to better document what is going on.
> > > > >
> > > > > Also add various WRITE_ONCE() in __hlist_del(), hlist_add_head()
> > > > > and hlist_add_before()/hlist_add_behind() to pair with
> > > > > the READ_ONCE().
> > > > >
> > > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > >
> > > > I have queued this, but if you prefer it go some other way:
> > > >
> > > > Acked-by: Paul E. McKenney <paulmck@kernel.org>
> > > >
> > > > But shouldn't the uses in include/linux/rculist.h also be converted
> > > > into the patch below?  If so, I will squash the following into your
> > > > patch.
> > > >
> > > >                                                 Thanx, Paul
> > > >
> > > > ------------------------------------------------------------------------
> > >
> > > Agreed, thanks for the addition of this Paul.
> >
> > Very good, squashed and pushed, thank you!
> >
> 
> I have another KCSAN report of a bug that will force us to use
> hlist_unhashed_lockless() from sk_unhashed()
> 
> (Meaning we also need to add some WRITE_ONCE() annotations to
> include/linux/list_nulls.h )
> 
> BUG: KCSAN: data-race in inet_unhash / inet_unhash
> 
> write to 0xffff8880a69a0170 of 8 bytes by interrupt on cpu 1:
>  __hlist_nulls_del include/linux/list_nulls.h:88 [inline]
>  hlist_nulls_del_init_rcu include/linux/rculist_nulls.h:36 [inline]
>  __sk_nulls_del_node_init_rcu include/net/sock.h:676 [inline]
>  inet_unhash+0x38f/0x4a0 net/ipv4/inet_hashtables.c:612
>  tcp_set_state+0xfa/0x3e0 net/ipv4/tcp.c:2249
>  tcp_done+0x93/0x1e0 net/ipv4/tcp.c:3854
>  tcp_write_err+0x7e/0xc0 net/ipv4/tcp_timer.c:56
>  tcp_retransmit_timer+0x9b8/0x16d0 net/ipv4/tcp_timer.c:479
>  tcp_write_timer_handler+0x42d/0x510 net/ipv4/tcp_timer.c:599
>  tcp_write_timer+0xd1/0xf0 net/ipv4/tcp_timer.c:619
>  call_timer_fn+0x5f/0x2f0 kernel/time/timer.c:1404
>  expire_timers kernel/time/timer.c:1449 [inline]
>  __run_timers kernel/time/timer.c:1773 [inline]
>  __run_timers kernel/time/timer.c:1740 [inline]
>  run_timer_softirq+0xc0c/0xcd0 kernel/time/timer.c:1786
>  __do_softirq+0x115/0x33f kernel/softirq.c:292
>  invoke_softirq kernel/softirq.c:373 [inline]
>  irq_exit+0xbb/0xe0 kernel/softirq.c:413
>  exiting_irq arch/x86/include/asm/apic.h:536 [inline]
>  smp_apic_timer_interrupt+0xe6/0x280 arch/x86/kernel/apic/apic.c:1137
>  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:830
>  native_safe_halt+0xe/0x10 arch/x86/kernel/paravirt.c:71
>  arch_cpu_idle+0x1f/0x30 arch/x86/kernel/process.c:571
>  default_idle_call+0x1e/0x40 kernel/sched/idle.c:94
>  cpuidle_idle_call kernel/sched/idle.c:154 [inline]
>  do_idle+0x1af/0x280 kernel/sched/idle.c:263
>  cpu_startup_entry+0x1b/0x20 kernel/sched/idle.c:355
>  start_secondary+0x208/0x260 arch/x86/kernel/smpboot.c:264
>  secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:241
> 
> read to 0xffff8880a69a0170 of 8 bytes by interrupt on cpu 0:
>  sk_unhashed include/net/sock.h:607 [inline]
>  inet_unhash+0x3d/0x4a0 net/ipv4/inet_hashtables.c:592
>  tcp_set_state+0xfa/0x3e0 net/ipv4/tcp.c:2249
>  tcp_done+0x93/0x1e0 net/ipv4/tcp.c:3854
>  tcp_write_err+0x7e/0xc0 net/ipv4/tcp_timer.c:56
>  tcp_retransmit_timer+0x9b8/0x16d0 net/ipv4/tcp_timer.c:479
>  tcp_write_timer_handler+0x42d/0x510 net/ipv4/tcp_timer.c:599
>  tcp_write_timer+0xd1/0xf0 net/ipv4/tcp_timer.c:619
>  call_timer_fn+0x5f/0x2f0 kernel/time/timer.c:1404
>  expire_timers kernel/time/timer.c:1449 [inline]
>  __run_timers kernel/time/timer.c:1773 [inline]
>  __run_timers kernel/time/timer.c:1740 [inline]
>  run_timer_softirq+0xc0c/0xcd0 kernel/time/timer.c:1786
>  __do_softirq+0x115/0x33f kernel/softirq.c:292
>  invoke_softirq kernel/softirq.c:373 [inline]
>  irq_exit+0xbb/0xe0 kernel/softirq.c:413
>  exiting_irq arch/x86/include/asm/apic.h:536 [inline]
>  smp_apic_timer_interrupt+0xe6/0x280 arch/x86/kernel/apic/apic.c:1137
>  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:830
>  native_safe_halt+0xe/0x10 arch/x86/kernel/paravirt.c:71
>  arch_cpu_idle+0x1f/0x30 arch/x86/kernel/process.c:571
>  default_idle_call+0x1e/0x40 kernel/sched/idle.c:94
>  cpuidle_idle_call kernel/sched/idle.c:154 [inline]
>  do_idle+0x1af/0x280 kernel/sched/idle.c:263
>  cpu_startup_entry+0x1b/0x20 kernel/sched/idle.c:355
>  rest_init+0xec/0xf6 init/main.c:452
>  arch_call_rest_init+0x17/0x37
>  start_kernel+0x838/0x85e init/main.c:786
>  x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:490
>  x86_64_start_kernel+0x72/0x76 arch/x86/kernel/head64.c:471
>  secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:241
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.4.0-rc6+ #0
> Hardware name: Google Google Compute Engine/Google Compute Engine,
> BIOS Google 01/01/2011

Like this?

						Thanx, Paul

------------------------------------------------------------------------

commit fef2da9c0cfa4f9ec405ff059fceb00d29de34dc
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Sat Nov 9 09:42:13 2019 -0800

    rcu: Use WRITE_ONCE() for assignments to ->pprev for hlist_nulls
    
    Eric Dumazet supplied a KCSAN report of a bug that forces use
    of hlist_unhashed_lockless() from sk_unhashed():
    
    ------------------------------------------------------------------------
    
    BUG: KCSAN: data-race in inet_unhash / inet_unhash
    
    write to 0xffff8880a69a0170 of 8 bytes by interrupt on cpu 1:
     __hlist_nulls_del include/linux/list_nulls.h:88 [inline]
     hlist_nulls_del_init_rcu include/linux/rculist_nulls.h:36 [inline]
     __sk_nulls_del_node_init_rcu include/net/sock.h:676 [inline]
     inet_unhash+0x38f/0x4a0 net/ipv4/inet_hashtables.c:612
     tcp_set_state+0xfa/0x3e0 net/ipv4/tcp.c:2249
     tcp_done+0x93/0x1e0 net/ipv4/tcp.c:3854
     tcp_write_err+0x7e/0xc0 net/ipv4/tcp_timer.c:56
     tcp_retransmit_timer+0x9b8/0x16d0 net/ipv4/tcp_timer.c:479
     tcp_write_timer_handler+0x42d/0x510 net/ipv4/tcp_timer.c:599
     tcp_write_timer+0xd1/0xf0 net/ipv4/tcp_timer.c:619
     call_timer_fn+0x5f/0x2f0 kernel/time/timer.c:1404
     expire_timers kernel/time/timer.c:1449 [inline]
     __run_timers kernel/time/timer.c:1773 [inline]
     __run_timers kernel/time/timer.c:1740 [inline]
     run_timer_softirq+0xc0c/0xcd0 kernel/time/timer.c:1786
     __do_softirq+0x115/0x33f kernel/softirq.c:292
     invoke_softirq kernel/softirq.c:373 [inline]
     irq_exit+0xbb/0xe0 kernel/softirq.c:413
     exiting_irq arch/x86/include/asm/apic.h:536 [inline]
     smp_apic_timer_interrupt+0xe6/0x280 arch/x86/kernel/apic/apic.c:1137
     apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:830
     native_safe_halt+0xe/0x10 arch/x86/kernel/paravirt.c:71
     arch_cpu_idle+0x1f/0x30 arch/x86/kernel/process.c:571
     default_idle_call+0x1e/0x40 kernel/sched/idle.c:94
     cpuidle_idle_call kernel/sched/idle.c:154 [inline]
     do_idle+0x1af/0x280 kernel/sched/idle.c:263
     cpu_startup_entry+0x1b/0x20 kernel/sched/idle.c:355
     start_secondary+0x208/0x260 arch/x86/kernel/smpboot.c:264
     secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:241
    
    read to 0xffff8880a69a0170 of 8 bytes by interrupt on cpu 0:
     sk_unhashed include/net/sock.h:607 [inline]
     inet_unhash+0x3d/0x4a0 net/ipv4/inet_hashtables.c:592
     tcp_set_state+0xfa/0x3e0 net/ipv4/tcp.c:2249
     tcp_done+0x93/0x1e0 net/ipv4/tcp.c:3854
     tcp_write_err+0x7e/0xc0 net/ipv4/tcp_timer.c:56
     tcp_retransmit_timer+0x9b8/0x16d0 net/ipv4/tcp_timer.c:479
     tcp_write_timer_handler+0x42d/0x510 net/ipv4/tcp_timer.c:599
     tcp_write_timer+0xd1/0xf0 net/ipv4/tcp_timer.c:619
     call_timer_fn+0x5f/0x2f0 kernel/time/timer.c:1404
     expire_timers kernel/time/timer.c:1449 [inline]
     __run_timers kernel/time/timer.c:1773 [inline]
     __run_timers kernel/time/timer.c:1740 [inline]
     run_timer_softirq+0xc0c/0xcd0 kernel/time/timer.c:1786
     __do_softirq+0x115/0x33f kernel/softirq.c:292
     invoke_softirq kernel/softirq.c:373 [inline]
     irq_exit+0xbb/0xe0 kernel/softirq.c:413
     exiting_irq arch/x86/include/asm/apic.h:536 [inline]
     smp_apic_timer_interrupt+0xe6/0x280 arch/x86/kernel/apic/apic.c:1137
     apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:830
     native_safe_halt+0xe/0x10 arch/x86/kernel/paravirt.c:71
     arch_cpu_idle+0x1f/0x30 arch/x86/kernel/process.c:571
     default_idle_call+0x1e/0x40 kernel/sched/idle.c:94
     cpuidle_idle_call kernel/sched/idle.c:154 [inline]
     do_idle+0x1af/0x280 kernel/sched/idle.c:263
     cpu_startup_entry+0x1b/0x20 kernel/sched/idle.c:355
     rest_init+0xec/0xf6 init/main.c:452
     arch_call_rest_init+0x17/0x37
     start_kernel+0x838/0x85e init/main.c:786
     x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:490
     x86_64_start_kernel+0x72/0x76 arch/x86/kernel/head64.c:471
     secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:241
    
    Reported by Kernel Concurrency Sanitizer on:
    CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.4.0-rc6+ #0
    Hardware name: Google Google Compute Engine/Google Compute Engine,
    BIOS Google 01/01/2011
    
    ------------------------------------------------------------------------
    
    This commit therefore replaces C-language assignments with WRITE_ONCE()
    in include/linux/list_nulls.h and include/linux/rculist_nulls.h.
    
    Reported-by: Eric Dumazet <edumazet@google.com> # For KCSAN
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/include/linux/list_nulls.h b/include/linux/list_nulls.h
index 3ef9674..1ecd356 100644
--- a/include/linux/list_nulls.h
+++ b/include/linux/list_nulls.h
@@ -72,10 +72,10 @@ static inline void hlist_nulls_add_head(struct hlist_nulls_node *n,
 	struct hlist_nulls_node *first = h->first;
 
 	n->next = first;
-	n->pprev = &h->first;
+	WRITE_ONCE(n->pprev, &h->first);
 	h->first = n;
 	if (!is_a_nulls(first))
-		first->pprev = &n->next;
+		WRITE_ONCE(first->pprev, &n->next);
 }
 
 static inline void __hlist_nulls_del(struct hlist_nulls_node *n)
@@ -85,13 +85,13 @@ static inline void __hlist_nulls_del(struct hlist_nulls_node *n)
 
 	WRITE_ONCE(*pprev, next);
 	if (!is_a_nulls(next))
-		next->pprev = pprev;
+		WRITE_ONCE(next->pprev, pprev);
 }
 
 static inline void hlist_nulls_del(struct hlist_nulls_node *n)
 {
 	__hlist_nulls_del(n);
-	n->pprev = LIST_POISON2;
+	WRITE_ONCE(n->pprev, LIST_POISON2);
 }
 
 /**
diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
index bc8206a..517a06f 100644
--- a/include/linux/rculist_nulls.h
+++ b/include/linux/rculist_nulls.h
@@ -34,7 +34,7 @@ static inline void hlist_nulls_del_init_rcu(struct hlist_nulls_node *n)
 {
 	if (!hlist_nulls_unhashed(n)) {
 		__hlist_nulls_del(n);
-		n->pprev = NULL;
+		WRITE_ONCE(n->pprev, NULL);
 	}
 }
 
@@ -66,7 +66,7 @@ static inline void hlist_nulls_del_init_rcu(struct hlist_nulls_node *n)
 static inline void hlist_nulls_del_rcu(struct hlist_nulls_node *n)
 {
 	__hlist_nulls_del(n);
-	n->pprev = LIST_POISON2;
+	WRITE_ONCE(n->pprev, LIST_POISON2);
 }
 
 /**
@@ -94,10 +94,10 @@ static inline void hlist_nulls_add_head_rcu(struct hlist_nulls_node *n,
 	struct hlist_nulls_node *first = h->first;
 
 	n->next = first;
-	n->pprev = &h->first;
+	WRITE_ONCE(n->pprev, &h->first);
 	rcu_assign_pointer(hlist_nulls_first_rcu(h), n);
 	if (!is_a_nulls(first))
-		first->pprev = &n->next;
+		WRITE_ONCE(first->pprev, &n->next);
 }
 
 /**
