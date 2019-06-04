Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74ACDC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A2D24146
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfFDIg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:36:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36788 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726793AbfFDIg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:36:57 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x548XDXT134515;
        Tue, 4 Jun 2019 04:36:30 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2swkssuyua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jun 2019 04:36:30 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x542cumf012105;
        Tue, 4 Jun 2019 02:41:32 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma01dal.us.ibm.com with ESMTP id 2suh097dk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jun 2019 02:41:32 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x548aSf339452998
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Jun 2019 08:36:28 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B47C7B205F;
        Tue,  4 Jun 2019 08:36:28 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5EC86B2066;
        Tue,  4 Jun 2019 08:36:28 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.171.86])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  4 Jun 2019 08:36:28 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2E81416C63E5; Tue,  4 Jun 2019 01:14:35 -0700 (PDT)
Date:   Tue, 4 Jun 2019 01:14:35 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, jpoimboe@redhat.com,
        mojha@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH HACK RFC] cpu: Prevent late-arriving interrupts from
 disrupting offline
Message-ID: <20190604081435.GQ28207@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190602011253.GA6167@linux.ibm.com>
 <20190603083848.GB3436@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603083848.GB3436@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-04_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906040058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 10:38:48AM +0200, Peter Zijlstra wrote:
> On Sat, Jun 01, 2019 at 06:12:53PM -0700, Paul E. McKenney wrote:
> > Scheduling-clock interrupts can arrive late in the CPU-offline process,
> > after idle entry and the subsequent call to cpuhp_report_idle_dead().
> > Once execution passes the call to rcu_report_dead(), RCU is ignoring
> > the CPU, which results in lockdep complaints when the interrupt handler
> > uses RCU:
> 
> > diff --git a/kernel/cpu.c b/kernel/cpu.c
> > index 448efc06bb2d..3b33d83b793d 100644
> > --- a/kernel/cpu.c
> > +++ b/kernel/cpu.c
> > @@ -930,6 +930,7 @@ void cpuhp_report_idle_dead(void)
> >  	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
> >  
> >  	BUG_ON(st->state != CPUHP_AP_OFFLINE);
> > +	local_irq_disable();
> >  	rcu_report_dead(smp_processor_id());
> >  	st->state = CPUHP_AP_IDLE_DEAD;
> >  	udelay(1000);
> 
> Urgh... I'd almost suggest we do something like the below.
> 
> 
> But then I started looking at the various arch_cpu_idle_dead()
> implementations and ran into arm's implementation, which is calling
> complete() where generic code already established this isn't possible
> (see for example cpuhp_report_idle_dead()).

Yeah, my patch that would have changed that never was acked or taken
by the maintainer, as discussed later in this thread.

> And then there's powerpc which for some obscure reason thinks it needs
> to enable preemption when dying ?! pseries_cpu_die() actually calls
> msleep() ?!?!

Isn't pseries_cpu_die() invoked via the smp_ops->cpu_die() function
pointer, whch is invoked from __cpu_die() in arch/powerpc/kernel/smp.c?
Then, if I am reading the code correctly, __cpu_die() is invoked from
takedown_cpu(), which is invoked not from the dying CPU but rather from
a surviving CPU.  Or am I misreading the code?

> Sparc64 agains things it should enable preemption when playing dead.
> 
> So clearly this isn't going to work well :/

Well, it looks like it will work at least as well as my patch.  I will
test it out this evening, ten timezones east of my usual location.  ;-)

							Thanx, Paul

> ---
>  include/linux/tick.h | 10 ----------
>  kernel/sched/idle.c  |  5 +++--
>  2 files changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/tick.h b/include/linux/tick.h
> index f92a10b5e112..196a0a7bfc4f 100644
> --- a/include/linux/tick.h
> +++ b/include/linux/tick.h
> @@ -134,14 +134,6 @@ extern unsigned long tick_nohz_get_idle_calls(void);
>  extern unsigned long tick_nohz_get_idle_calls_cpu(int cpu);
>  extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
>  extern u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time);
> -
> -static inline void tick_nohz_idle_stop_tick_protected(void)
> -{
> -	local_irq_disable();
> -	tick_nohz_idle_stop_tick();
> -	local_irq_enable();
> -}
> -
>  #else /* !CONFIG_NO_HZ_COMMON */
>  #define tick_nohz_enabled (0)
>  static inline int tick_nohz_tick_stopped(void) { return 0; }
> @@ -164,8 +156,6 @@ static inline ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
>  }
>  static inline u64 get_cpu_idle_time_us(int cpu, u64 *unused) { return -1; }
>  static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
> -
> -static inline void tick_nohz_idle_stop_tick_protected(void) { }
>  #endif /* !CONFIG_NO_HZ_COMMON */
>  
>  #ifdef CONFIG_NO_HZ_FULL
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index 80940939b733..e4bc4aa739b8 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -241,13 +241,14 @@ static void do_idle(void)
>  		check_pgt_cache();
>  		rmb();
>  
> +		local_irq_disable();
> +
>  		if (cpu_is_offline(cpu)) {
> -			tick_nohz_idle_stop_tick_protected();
> +			tick_nohz_idle_stop_tick();
>  			cpuhp_report_idle_dead();
>  			arch_cpu_idle_dead();
>  		}
>  
> -		local_irq_disable();
>  		arch_cpu_idle_enter();
>  
>  		/*
> 
