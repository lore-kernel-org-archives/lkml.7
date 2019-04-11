Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DBBC10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 00:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B80892133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 00:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfDKAGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 20:06:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57380 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725982AbfDKAGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 20:06:14 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3ANwuhT147153
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 20:06:13 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rsr63wm0v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 20:06:13 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 11 Apr 2019 01:06:12 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 11 Apr 2019 01:06:10 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3B0692K34144408
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Apr 2019 00:06:09 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02988B2068;
        Thu, 11 Apr 2019 00:06:09 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA2FAB2064;
        Thu, 11 Apr 2019 00:06:08 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 11 Apr 2019 00:06:08 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id CDA3C16C3648; Wed, 10 Apr 2019 17:06:10 -0700 (PDT)
Date:   Wed, 10 Apr 2019 17:06:10 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Alleged fix for writer stall on -rcu branch dev
Reply-To: paulmck@linux.ibm.com
References: <20190409221426.GA11212@linux.ibm.com>
 <20190410181538.3ocva5lmh7ghrisr@linutronix.de>
 <20190410184105.GR14111@linux.ibm.com>
 <20190410191918.g2yqnsmuqukmzdfe@linutronix.de>
 <20190410203302.GT14111@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410203302.GT14111@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19041100-0064-0000-0000-000003C936B4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010905; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01187284; UDB=6.00621895; IPR=6.00968048;
 MB=3.00026384; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-11 00:06:11
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041100-0065-0000-0000-00003D04E308
Message-Id: <20190411000610.GA3867@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-10_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904100157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 01:33:02PM -0700, Paul E. McKenney wrote:
> On Wed, Apr 10, 2019 at 09:19:18PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2019-04-10 11:41:05 [-0700], Paul E. McKenney wrote:
> > > On Wed, Apr 10, 2019 at 08:15:38PM +0200, Sebastian Andrzej Siewior wrote:
> > > > On 2019-04-09 15:14:26 [-0700], Paul E. McKenney wrote:
> > > > > Hello, Sebastian,
> > > > Hi Paul,
> > > > 
> > > > > A few commits later, I finally have something that might work.  ;-)
> > > > 
> > > > Okay. I started with 33e04e4512797b5e0242f452d0027b096d43d006. The first
> > > > batch of 18 completed and this
> > > > 	https://breakpoint.cc/console-tree1.2.log
> > > 
> > > Another new one on me!  ;-)
> > > 
> > > It looks like CPU 11 got stuck in the cpu_stopper_thread trying to
> > > offline CPU 6.  Unfortunately, CPU 6 is not in the list receiving an
> > > NMI, perhaps because it looked like it was already offline.  It does
> > > eventually finish going offline quite some time later.
> > > 
> > > Perhaps my forward-progress testing is interacting badly with CPU
> > > hotplug, but only very occasionally?
> > 
> > Somehow, yes.
> > 
> > [ 8433.835292] Unregister pv shared memory for cpu 6
> > [ 8433.864122] smpboot: CPU 6 is now offline
> > 
> > CPU6 is offline.
> > 
> > [ 8434.934765] smpboot: Booting Node 0 Processor 6 APIC 0x6
> > [ 8434.950632] kvm-clock: cpu 6, msr 17155a181, secondary cpu clock
> > [ 8434.989124] KVM setup async PF for cpu 6
> > [ 8434.990801] kvm-stealtime: cpu 6, msr 17b195380
> > 
> > CPU6 is booting again.
> > 
> > [ 8436.035269] Unregister pv shared memory for cpu 6
> > 
> > going down again
> > 
> > [ 8462.032468] rcu: INFO: rcu_preempt self-detected stall on CPU
> > [ 8462.037385] rcu: 	11-...!: (25587 ticks this GP) idle=57e/1/0x4000000000000002 softirq=418067/418067 fqs=1 last_accelerate: 2456/89e6, Nonlazy posted: .LD
> > 
> > 25587 ticks is ~25secs with HZ=1k. And the stall occurred on CPU11,
> > correct?
> 
> Yes to both.
> 
> > [ 8525.041031] smpboot: CPU 6 is now offline
> > 
> > 63 secs later, the CPU is down. So that is too long.
> 
> Ah, I did miss the down-then-up, thank you!
> 
> > > Something for me to look at, anyway!
> > 
> > There is also
> > [ 8556.907804] WARNING: CPU: 35 PID: 833 at /home/bigeasy/linux-rt/kernel/rcu/rcutorture.c:1827 rcu_torture_fwd_prog+0x5c4/0x630
> > 
> > but I'm not sure what it is :)
> 
> The forward-progress test exceeded eight seconds, but pushed fewer
> than 100 callbacks through the system.  One way that could happen is
> if the forward-progress kthread was delayed during that eight seconds.
> Another is if grace periods were insanely fast (which they are not).
> 
> > > > I should have been alone on that server but I can't guarantee it. I try
> > > > to throw the rcu-torture at a little smaller box and check how it goes.
> > > 
> > > Even if you were not alone, I would guess that preempting a runnable
> > > process for 92 seconds would have been a visible event on the host.
> > 
> > 92 seconds?! Okay, that should have been visible on the host side. And I
> > see nothing in dmesg on the host side.
> > But why 92? 25 for RCU stall + 63 between starting to go down and
> > finishing?
> 
> Because I missed the momentary up-then-down that you spotted.  Your 63
> seconds is correct.
> 
> > > But maybe not?  The watchdog timer is still 120 seconds?  Or does your
> > > host set it to 22 seconds?
> > 
> > I didn't fiddle with it and host runs 4.19.12-1~bpo9+1. So it should be
> > the default value.
> 
> Which I believe to be 22 seconds.  Hmmm...
> 
> Either way, thank you very much for the testing!!!

[ Adding LKML back -- I think we dropped it due to an attachment? ]

One area of some concern is RCU_KTHREAD_YIELDING and the rcuc kthreads.
This shouldn't be a big deal for the intended use case (real-time
workloads with lightish load), but a two-jiffy delay could allow quite a
few callbacks to build up when doing forward-progress testing.  But not
a problem for use_softirq runs, which is what you were running.

But it might be that I need to either skip the forward-progress testing
if !use_softirq, skip the RCU_KTHREAD_YIELDING step if there are too
many callbacks, or some such.  Either way, though, I would need at least
a cond_resched() on each pass through the rcu_cpu_kthread() function.

Thoughts from a real-time perspective?

Oooh...  But in both use_softirq and !use_softirq runs, if the CPU to be
offlined has a huge number of callbacks pending (assuming callbacks are
not offloaded), there could be quite the delay imposed on the offlining
of that CPU.  Now 63 seconds seems a bit much, but there can be tens
of millions of callbacks queued up to be invoked.  It -could- happen,
I suppose, though I would guess more like a couple of seconds.

Maybe I need to ignore the ignoring of blimit for a CPU that is going
offline...  The theory is that the callbacks will just get dumped on
some other CPU if the CPU is going away, and on the other hand invoking
callbacks sparingly would help the CPU come back all the way online
more quickly.  Unless one of the callbacks on that CPU was the one from
the synchronize_rcu() in the CPU-hotplug offline path.  :-/

So I could start going slow on callbacks on the outgoing CPU as soon as
that synchronize_rcu() completes.  Horribly fragile, given the possibility
of synchronize_rcu() in other CPU-hotplug notifiers, though.  Plus it
looks like sched_cpu_deactivate() is about the first thing that happens
when removing a CPU.

But you know...  Ignoring the world while invoking up to LONG_MAX RCU
callbacks back to back probably never was an optimal plan.  So if that
splat is at all reproducible, could you please give the patch below a try?

I have just touch-tested this on TREE01 and TREE04.  I will be testing
the rest of the scenarios overnight, Pacific Time.

Of course, if you have more failures, please let me know!

							Thanx, Paul

------------------------------------------------------------------------

commit 3245c1860cb30f85ae42c25209217bac25104faf
Author: Paul E. McKenney <paulmck@linux.ibm.com>
Date:   Wed Apr 10 17:01:39 2019 -0700

    rcu: Set a maximum limit for back-to-back callback invocation
    
    Currently, if a CPU has more than 10,000 callbacks pending, it will
    increase rdp->blimit to LONG_MAX.  If you are lucky, LONG_MAX is only
    about two billion, but this is still a bit too many callbacks to invoke
    back-to-back while otherwise ignoring the world.
    
    This commit therefore sets a maximum limit of DEFAULT_MAX_RCU_BLIMIT,
    which is set to 10,000, for rdp->blimit.
    
    Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f53befdeecc1..afeb2751c94f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -401,7 +401,8 @@ static int rcu_is_cpu_rrupt_from_idle(void)
 	return __this_cpu_read(rcu_data.dynticks_nesting) == 0;
 }
 
-#define DEFAULT_RCU_BLIMIT 10     /* Maximum callbacks per rcu_do_batch. */
+#define DEFAULT_RCU_BLIMIT 10     /* Maximum callbacks per rcu_do_batch ... */
+#define DEFAULT_MAX_RCU_BLIMIT 10000 /* ... even during callback flood. */
 static long blimit = DEFAULT_RCU_BLIMIT;
 #define DEFAULT_RCU_QHIMARK 10000 /* If this many pending, ignore blimit. */
 static long qhimark = DEFAULT_RCU_QHIMARK;
@@ -2134,7 +2135,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 
 	/* Reinstate batch limit if we have worked down the excess. */
 	count = rcu_segcblist_n_cbs(&rdp->cblist);
-	if (rdp->blimit == LONG_MAX && count <= qlowmark)
+	if (rdp->blimit >= DEFAULT_MAX_RCU_BLIMIT && count <= qlowmark)
 		rdp->blimit = blimit;
 
 	/* Reset ->qlen_last_fqs_check trigger if enough CBs have drained. */
@@ -2464,7 +2465,7 @@ static void __call_rcu_core(struct rcu_data *rdp, struct rcu_head *head,
 			rcu_accelerate_cbs_unlocked(rdp->mynode, rdp);
 		} else {
 			/* Give the grace period a kick. */
-			rdp->blimit = LONG_MAX;
+			rdp->blimit = DEFAULT_MAX_RCU_BLIMIT;
 			if (rcu_state.n_force_qs == rdp->n_force_qs_snap &&
 			    rcu_segcblist_first_pend_cb(&rdp->cblist) != head)
 				rcu_force_quiescent_state();

