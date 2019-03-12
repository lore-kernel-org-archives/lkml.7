Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A155C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ED182054F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbfCLPUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:20:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35264 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726728AbfCLPUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:20:40 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2CFFQiq147177
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 11:20:39 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r6f510rqc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 11:20:38 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 12 Mar 2019 15:20:37 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Mar 2019 15:20:33 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2CFKVgj20840534
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Mar 2019 15:20:32 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8B48B206B;
        Tue, 12 Mar 2019 15:20:31 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B311B2065;
        Tue, 12 Mar 2019 15:20:31 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 12 Mar 2019 15:20:31 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6206416C1F8E; Tue, 12 Mar 2019 08:20:34 -0700 (PDT)
Date:   Tue, 12 Mar 2019 08:20:34 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        rostedt@goodmis.org, luto@kernel.org, byungchul.park@lge.com
Subject: Re: [PATCH tip/core/rcu 06/19] rcu: Add warning to detect
 half-interrupts
Reply-To: paulmck@linux.ibm.com
References: <20180829222021.GA29944@linux.vnet.ibm.com>
 <20180829222047.319-6-paulmck@linux.vnet.ibm.com>
 <20190311133939.GA29747@google.com>
 <20190311222903.GR13351@linux.ibm.com>
 <20190312150514.GB249405@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312150514.GB249405@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19031215-0064-0000-0000-000003B8A433
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010745; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01173336; UDB=6.00613460; IPR=6.00953996;
 MB=3.00025946; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-12 15:20:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031215-0065-0000-0000-00003CB2301E
Message-Id: <20190312152034.GZ13351@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-12_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903120107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 11:05:14AM -0400, Joel Fernandes wrote:
> On Mon, Mar 11, 2019 at 03:29:03PM -0700, Paul E. McKenney wrote:
> > On Mon, Mar 11, 2019 at 09:39:39AM -0400, Joel Fernandes wrote:
> > > On Wed, Aug 29, 2018 at 03:20:34PM -0700, Paul E. McKenney wrote:
> > > > RCU's dyntick-idle code is written to tolerate half-interrupts, that it,
> > > > either an interrupt that invokes rcu_irq_enter() but never invokes the
> > > > corresponding rcu_irq_exit() on the one hand, or an interrupt that never
> > > > invokes rcu_irq_enter() but does invoke the "corresponding" rcu_irq_exit()
> > > > on the other.  These things really did happen at one time, as evidenced
> > > > by this ca-2011 LKML post:
> > > > 
> > > > http://lkml.kernel.org/r/20111014170019.GE2428@linux.vnet.ibm.com
> > > > 
> > > > The reason why RCU tolerates half-interrupts is that usermode helpers
> > > > used exceptions to invoke a system call from within the kernel such that
> > > > the system call did a normal return (not a return from exception) to
> > > > the calling context.  This caused rcu_irq_enter() to be invoked without
> > > > a matching rcu_irq_exit().  However, usermode helpers have since been
> > > > rewritten to make much more housebroken use of workqueues, kernel threads,
> > > > and do_execve(), and therefore should no longer produce half-interrupts.
> > > > No one knows of any other source of half-interrupts, but then again,
> > > > no one seems insane enough to go audit the entire kernel to verify that
> > > > half-interrupts really are a relic of the past.
> > > > 
> > > > This commit therefore adds a pair of WARN_ON_ONCE() calls that will
> > > > trigger in the presence of half interrupts, which the code will continue
> > > > to handle correctly.  If neither of these WARN_ON_ONCE() trigger by
> > > > mid-2021, then perhaps RCU can stop handling half-interrupts, which
> > > > would be a considerable simplification.
> > > 
> > > Hi Paul and everyone,
> > > I was thinking some more about this patch and whether we can simplify this code
> > > much in 2021. Since 2021 is a bit far away, I thought working on it in again to
> > > keep it fresh in memory is a good idea ;-)
> > 
> > Indeed, easy to forget.  ;-)
> > 
> > > To me it seems we cannot easily combine the counters (dynticks_nesting and
> > > dynticks_nmi_nesting) even if we confirmed that there is no possibility of a
> > > half-interrupt scenario (assuming simplication means counter combining like
> > > Byungchul tried to do in https://goo.gl/X1U77X). The reason is because these
> > > 2 counters need to be tracked separately as they are used differently in the
> > > following function:
> > > 
> > > static int rcu_is_cpu_rrupt_from_idle(void)
> > > {
> > >         return __this_cpu_read(rcu_data.dynticks_nesting) <= 0 &&
> > >                __this_cpu_read(rcu_data.dynticks_nmi_nesting) <= 1;
> > > }
> > > 
> > > dynticks_nesting actually tracks if we entered/exited idle or user mode.
> > 
> > True, though it tracks user mode only in CONFIG_NO_HZ_FULL kernels.
> > 
> > > dynticks_nmi_nesting tracks if we entered/exited interrupts.
> > 
> > Including NMIs, yes.
> > 
> > > We have to do the "dynticks_nmi_nesting <= 1" check because
> > > rcu_is_cpu_rrupt_from_idle() can possibly be called from an interrupt itself
> > > (like timer) so we discount 1 interrupt, and, the "dynticks_nesting <= 0"
> > > check is because the CPU MUST be in user or idle for the check to return
> > > true. We can't really combine these two into one counter then I think because
> > > they both convey different messages.
> > > 
> > > The only simplication we can do, is probably the "crowbar" updates to
> > > dynticks_nmi_nesting can be removed from rcu_eqs_enter/exit once we confirm
> > > no more half-interrupts are possible. Which might still be a worthwhile thing
> > > to do (while still keeping both counters separate).
> > > 
> > > However, I think we could combine the counters and lead to simplying the code
> > > in case we implement rcu_is_cpu_rrupt_from_idle differently such that it does
> > > not need the counters but NOHZ_FULL may take issue with that since it needs
> > > rcu_user_enter->rcu_eqs_enter to convey that the CPU is "RCU"-idle.
> > 
> > I haven't gone through it in detail, but it seems like we should be able
> > to treat in-kernel process-level execution like an interrupt from idle
> > or userspace, as the case might be.  If we did that, shouldn't we be
> > able to just do this?
> > 
> > static int rcu_is_cpu_rrupt_from_idle(void)
> > {
> >         return __this_cpu_read(rcu_data.dynticks_nmi_nesting) <= 1;
> > }
> 
> I think that would work only if this function is always called from an
> interrupt:
> 
> The comments on this function says:
>  * If the current CPU is idle or running at a first-level (not nested)
>  * interrupt from idle, return true.  The caller must have at least
>  * disabled preemption.
>  */
> 
> According to this comment rcu_is_cpu_rrupt_from_idle can be called from
> somewhere other than an interrupt although from code-reading that does not
> seem to be.
> 
> If it is ever possible to call rcu_is_cpu_rrupt_from_idle from anywhere but
> an interrupt, then we would have a scenario like:
> rcu_eqs_exit()   (Called say from rcu_idle_exit)
> rcu_is_cpu_rrupt_from_idle  (now nesting counter is 1, so the <=1 check
>                              returns true).
> 
> This would result in the function falsely claiming the CPU was idle from an
> RCU standpoint I think.
> 
> However both from testing and from code reading, I don't see such a scenario
> happening.

Agreed!

>            Could we be more explicit in the code that this function can only
> be called from an interrupt, and also we change the code comment to be more
> clear about it (like the following diff)?

That would be good!

Nice trick on using dyntick state to check for interrupt nesting, but
wouldn't consolidating the counters break that?  But is there a lockdep
check for being in a hardware interrupt handler?  If not, could one
be added?  This would have the benefit of not adding overhead to the
scheduling-clock interrupt in production builds of the Linux kernel,
while still finding this bug in testing.

(Another approach would be to use IS_ENABLED(CONFIG_PROVE_RCU), but
a lockdep check would be cleaner.)

> I made the following change and it didn't seem to blow up and also makes the
> code more clear. The only change I would make if we were considering merging
> this is to change the BUG_ON to WARN_ON_ONCE but I want to check first if you
> think this change is useful to do. I think being explicit about the intention
> is a good thing. I also specifically check for first-level of interrupt
> nesting (==1).
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index a45c45a4a09b..531c63c40001 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -377,14 +377,19 @@ static void __maybe_unused rcu_momentary_dyntick_idle(void)
>  /**
>   * rcu_is_cpu_rrupt_from_idle - see if idle or immediately interrupted from idle
>   *
> - * If the current CPU is idle or running at a first-level (not nested)
> + * If the current CPU is idle and running at a first-level (not nested)
>   * interrupt from idle, return true.  The caller must have at least
>   * disabled preemption.
>   */
>  static int rcu_is_cpu_rrupt_from_idle(void)
>  {
> -	return __this_cpu_read(rcu_data.dynticks_nesting) <= 0 &&
> -	       __this_cpu_read(rcu_data.dynticks_nmi_nesting) <= 1;
> +	int dynticks_nesting = __this_cpu_read(rcu_data.dynticks_nesting);
> +	int dynticks_nmi_nesting = __this_cpu_read(rcu_data.dynticks_nmi_nesting);
> +
> +	/* This function should only be called from an interrupt */
> +	BUG_ON(dynticks_nmi_nesting < 1);
> +
> +	return dynticks_nmi_nesting == 1 && dynticks_nesting <= 0;
>  }
>  
>  #define DEFAULT_RCU_BLIMIT 10     /* Maximum callbacks per rcu_do_batch. */
> 
> 
> > > Actually, I had another question... rcu_user_enter() is a NOOP in !NOHZ_FULL config.
> > > In this case I was wondering if the the warning Paul added (in the patch I'm replying to)
> > > will really get fired for half-interrupts. The vast majority of the systems I believe are
> > > NOHZ_IDLE not NOHZ_FULL.
> > > This is what a half-interrupt really looks like right? Please correct me if I'm wrong:
> > > rcu_irq_enter()   [half interrupt causes an exception and thus rcu_irq_enter]
> > > rcu_user_enter()  [due to usermode upcall]
> > > rcu_user_exit()
> > > (no more rcu_irq_exit() - hence half an interrupt)
> > > 
> > > But the rcu_user_enter()/exit is a NOOP in some configs, so will the warning in
> > > rcu_eqs_e{xit,nter} really do anything?
> > 
> > Yes, because these are also called from rcu_idle_enter() and
> > rcu_idle_exit(), which is invoked even in !NO_HZ_FULL kernels.
> 
> Got it.
> 
> > > Or was the idea with adding the new warnings, that they would fire the next
> > > time rcu_idle_enter/exit is called? Like for example:
> > > 
> > > rcu_irq_enter()   [This is due to half-interrupt]
> > > rcu_idle_enter()  [Eventually we enter the idle loop at some point
> > > 		   after the half-interrupt and the rcu_eqs_enter()
> > > 		   would "crowbar" the dynticks_nmi_nesting counter to 0].
> > 
> > You got it!  ;-)
> 
> Thanks a lot for confirming,

Thank you for looking into this!

								Thanx, Paul

