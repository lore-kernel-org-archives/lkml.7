Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D710CC04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9703F24894
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hn4Q0Lbm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbfFCIix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 04:38:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49766 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfFCIix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 04:38:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PB3xGZced/1uwatVXqFMqerQ1qgEDmtxsfjbArKoqJw=; b=hn4Q0LbmRFOFC+4v7LUhJWzl9
        Q0JhgvQ2P/pn+KWp+Wb/9Csz/beg4cYcYI+Aal4Sn6BLa4Ud9dWv/YKwst6z5m/eC8uGeQQqtwzZ8
        hS2U+pgMtp/9teOpGnKCxChGYK9EkcNyxmn5+XWtvqPzqSA59XsKANngUIcsZo4PaCbgwj8v65NDG
        v8E0lOSoABKn2qrFRHWysYD4B6eQgWMFJh8OC2WJT13TfhZ0S0W+dRSZcGCbyJ46S3mWqWzStRz/Y
        ff2N5y7Ls+NNupivi72s9g4uQYcraEenJmk6Ox06x5qIHQrO+TXZ3NCBi8VLIEzODO8+2KXYv7/TR
        o0r8gATfQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hXiUU-0000FB-6o; Mon, 03 Jun 2019 08:38:50 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2B6932029F880; Mon,  3 Jun 2019 10:38:48 +0200 (CEST)
Date:   Mon, 3 Jun 2019 10:38:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, jpoimboe@redhat.com,
        mojha@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH HACK RFC] cpu: Prevent late-arriving interrupts from
 disrupting offline
Message-ID: <20190603083848.GB3436@hirez.programming.kicks-ass.net>
References: <20190602011253.GA6167@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190602011253.GA6167@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 01, 2019 at 06:12:53PM -0700, Paul E. McKenney wrote:
> Scheduling-clock interrupts can arrive late in the CPU-offline process,
> after idle entry and the subsequent call to cpuhp_report_idle_dead().
> Once execution passes the call to rcu_report_dead(), RCU is ignoring
> the CPU, which results in lockdep complaints when the interrupt handler
> uses RCU:

> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 448efc06bb2d..3b33d83b793d 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -930,6 +930,7 @@ void cpuhp_report_idle_dead(void)
>  	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
>  
>  	BUG_ON(st->state != CPUHP_AP_OFFLINE);
> +	local_irq_disable();
>  	rcu_report_dead(smp_processor_id());
>  	st->state = CPUHP_AP_IDLE_DEAD;
>  	udelay(1000);

Urgh... I'd almost suggest we do something like the below.


But then I started looking at the various arch_cpu_idle_dead()
implementations and ran into arm's implementation, which is calling
complete() where generic code already established this isn't possible
(see for example cpuhp_report_idle_dead()).

And then there's powerpc which for some obscure reason thinks it needs
to enable preemption when dying ?! pseries_cpu_die() actually calls
msleep() ?!?!

Sparc64 agains things it should enable preemption when playing dead.

So clearly this isn't going to work well :/

---
 include/linux/tick.h | 10 ----------
 kernel/sched/idle.c  |  5 +++--
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index f92a10b5e112..196a0a7bfc4f 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -134,14 +134,6 @@ extern unsigned long tick_nohz_get_idle_calls(void);
 extern unsigned long tick_nohz_get_idle_calls_cpu(int cpu);
 extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
 extern u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time);
-
-static inline void tick_nohz_idle_stop_tick_protected(void)
-{
-	local_irq_disable();
-	tick_nohz_idle_stop_tick();
-	local_irq_enable();
-}
-
 #else /* !CONFIG_NO_HZ_COMMON */
 #define tick_nohz_enabled (0)
 static inline int tick_nohz_tick_stopped(void) { return 0; }
@@ -164,8 +156,6 @@ static inline ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
 }
 static inline u64 get_cpu_idle_time_us(int cpu, u64 *unused) { return -1; }
 static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
-
-static inline void tick_nohz_idle_stop_tick_protected(void) { }
 #endif /* !CONFIG_NO_HZ_COMMON */
 
 #ifdef CONFIG_NO_HZ_FULL
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 80940939b733..e4bc4aa739b8 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -241,13 +241,14 @@ static void do_idle(void)
 		check_pgt_cache();
 		rmb();
 
+		local_irq_disable();
+
 		if (cpu_is_offline(cpu)) {
-			tick_nohz_idle_stop_tick_protected();
+			tick_nohz_idle_stop_tick();
 			cpuhp_report_idle_dead();
 			arch_cpu_idle_dead();
 		}
 
-		local_irq_disable();
 		arch_cpu_idle_enter();
 
 		/*
