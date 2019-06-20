Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BECC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 22:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC362082C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 22:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfFTWNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 18:13:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51002 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725906AbfFTWNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 18:13:40 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5KM2v5A128682
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 18:13:39 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t8hte1w2f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 18:13:38 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 20 Jun 2019 23:13:38 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 20 Jun 2019 23:13:35 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5KMDYjU44630378
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jun 2019 22:13:34 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9755AB20B5;
        Thu, 20 Jun 2019 22:13:34 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 68821B20B4;
        Thu, 20 Jun 2019 22:13:34 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 20 Jun 2019 22:13:34 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 716CF16C6AC7; Thu, 20 Jun 2019 15:13:36 -0700 (PDT)
Date:   Thu, 20 Jun 2019 15:13:36 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        frederic@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH] time/tick-broadcast: Fix tick_broadcast_offline()
 lockdep complaint
Reply-To: paulmck@linux.ibm.com
References: <20190619181903.GA14233@linux.ibm.com>
 <20190620121032.GU3436@hirez.programming.kicks-ass.net>
 <20190620160118.GQ26519@linux.ibm.com>
 <20190620211019.GA3436@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620211019.GA3436@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19062022-0052-0000-0000-000003D35A43
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011299; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01220888; UDB=6.00642286; IPR=6.01002026;
 MB=3.00027398; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-20 22:13:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062022-0053-0000-0000-00006165A359
Message-Id: <20190620221336.GZ26519@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-20_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906200158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 11:10:19PM +0200, Peter Zijlstra wrote:
> On Thu, Jun 20, 2019 at 09:01:18AM -0700, Paul E. McKenney wrote:
> 
> > > > +#define TICK_SCHED_REMOTE_OFFLINE	0
> > > > +#define TICK_SCHED_REMOTE_RUNNING	1
> > > > +#define TICK_SCHED_REMOTE_OFFLINING	2
> > > 
> > > That seems a daft set of values; consider { RUNNING, OFFLINING, OFFLINE }
> > > and see below.
> > 
> > As in make it an enum?  I could do that.
> 
> Enum or define, I don't much care, but the 'natural' ordering of the
> states is either: running -> offlining -> offline, or the other way
> around, the given order in the patch just didn't make sense.
> 
> The one with running=0 just seems to work out nicer.

Aside from now needing to be initialized, but so it goes.  Which is
why TICK_SCHED_REMOTE_OFFLINE was zero in my version, in case you were
wondering.  ;-)

> > > > +
> > > > +// State diagram for ->state:
> > > > +//
> > > > +//
> > > > +//      +----->OFFLINE--------------------------+
> > > > +//      |                                       |
> > > > +//      |                                       |
> > > > +//      |                                       | sched_tick_start()
> > > > +//      | sched_tick_remote()                   |
> > > > +//      |                                       |
> > > > +//      |                                       V
> > > > +//      |                        +---------->RUNNING
> > > > +//      |                        |              |
> > > > +//      |                        |              |
> > > > +//      |                        |              |
> > > > +//      |     sched_tick_start() |              | sched_tick_stop()
> > > > +//      |                        |              |
> > > > +//      |                        |              |
> > > > +//      |                        |              |
> > > > +//      +--------------------OFFLINING<---------+
> > > > +//
> > > > +//
> > > > +// Other transitions get WARN_ON_ONCE(), except that sched_tick_remote()
> > > > +// and sched_tick_start() are happy to leave the state in RUNNING.
> 
> > > Also, I find it harder to read that needed, maybe a little something
> > > like so:
> > > 
> > > /*
> > >  *              OFFLINE
> > >  *               |   ^
> > >  *               |   | tick_remote()
> > >  *               |   |
> > >  *               +--OFFLINING
> > >  *               |   ^
> > >  *  tick_start() |   | tick_stop()
> > >  *               v   |
> > >  *              RUNNING
> > >  */
> > 
> > As in remove the leading "sched_" from the function names?  (The names
> > were already there, so I left them be.)
> 
> That was just me being lazy, the main part being getting the states in a
> linear order, instead of spread around a 2d grid.

OK, I will expand them.  Including the ones where I was being lazy.

> > > While not wrong, it seems overly complicated; can't we do something
> > > like:
> > > 
> > > tick:
> > 
> > As in sched_tick_remote(), right?
> > 
> > > 	state = atomic_read(->state);
> > > 	if (state) {
> > 
> > You sure you don't want "if (state != RUNNING)"?  But I guess you need
> > to understand that RUNNING==0 to understand the atomic_inc_not_zero().
> 
> Right..
> 
> > 
> > > 		WARN_ON_ONCE(state != OFFLINING);
> > > 		if (atomic_inc_not_zero(->state))
> > 
> > This assumes that there cannot be concurrent calls to sched_tick_remote(),
> > otherwise, you can end up with ->state==3.  Which is a situation that
> > my version does a WARN_ON_ONCE() for, so I guess the only difference is
> > that mine would be guaranteed to complain and yours would complain with
> > high probability.  So fair enough!
> 
> I was assuming there was only a single work per CPU and there'd not be
> concurrency on this path.
> 
> > > 			return;
> > > 	}
> > > 	queue_delayed_work();
> > > 
> > > 
> > > stop:
> > > 	/*
> > > 	 * This is hotplug; even without stop-machine, there cannot be
> > > 	 * concurrency on offlining specific CPUs.
> > > 	 */
> > > 	state = atomic_read(->state);
> > 
> > There cannot be a sched_tick_stop() or sched_tick_stop(), but there really
> > can be a sched_tick_remote() right here in the absence of stop-machine,
> > can't there?  Or am I missing something other than stop-machine that
> > prevents this?
> 
> There can be a remote tick, indeed.
> 
> > Now, you could argue that concurrency is safe: Either sched_tick_remote()
> > sees RUNNING and doesn't touch the value, or it sees offlining and
> > sched_tick_stop() makes no further changes,
> 
> That was indeed the thinking.
> 
> > but I am not sure that this qualifies as simpler...
> 
> There is that I suppose. I think my initial version was a little more
> complicated, but after a few passes this happened :-)
> 
> > > 	WARN_ON_ONCE(state != RUNNING);
> > > 	atomic_set(->state, OFFLINING);
> > 
> > Another option would be to use atomic_xchg() as below instead of the
> > atomic_read()/atomic_set() pair.  Would that work for you?
> 
> Yes, that works I suppose. Is more expensive, but I don't think we
> particularly care about that here.

Not on this code path, agreed.

> > > start:
> > > 	state = atomic_xchg(->state, RUNNING);
> > > 	WARN_ON_ONCE(state == RUNNING);
> > > 	if (state == OFFLINE) {
> > > 		// ...
> > > 		queue_delayed_work();
> > > 	}
> > 
> > This one looks to be an improvement on mine regardless of the other two.

So how about the following patch, which passes very light rcutorture
testing but should otherwise be regarded as being under suspicion?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 874c427742a9..36631d2eff05 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3051,8 +3051,36 @@ void scheduler_tick(void)
 
 struct tick_work {
 	int			cpu;
+	atomic_t		state;
 	struct delayed_work	work;
 };
+/* Values for ->state, see diagram below. */
+#define TICK_SCHED_REMOTE_RUNNING	0
+#define TICK_SCHED_REMOTE_OFFLINING	1
+#define TICK_SCHED_REMOTE_OFFLINE	2
+
+/*
+ * State diagram for ->state:
+ *
+ *
+ *          TICK_SCHED_REMOTE_OFFLINE
+ *                    |   ^
+ *                    |   |
+ *                    |   | sched_tick_remote()
+ *                    |   |
+ *                    |   |
+ *                    +--TICK_SCHED_REMOTE_OFFLINING
+ *                    |   ^
+ *                    |   |
+ * sched_tick_start() |   | sched_tick_stop()
+ *                    |   |
+ *                    V   |
+ *          TICK_SCHED_REMOTE_RUNNING
+ *
+ *
+ * Other transitions get WARN_ON_ONCE(), except that sched_tick_remote()
+ * and sched_tick_start() are happy to leave the state in RUNNING.
+ */
 
 static struct tick_work __percpu *tick_work_cpu;
 
@@ -3065,6 +3093,7 @@ static void sched_tick_remote(struct work_struct *work)
 	struct task_struct *curr;
 	struct rq_flags rf;
 	u64 delta;
+	int os;
 
 	/*
 	 * Handle the tick only if it appears the remote CPU is running in full
@@ -3078,7 +3107,7 @@ static void sched_tick_remote(struct work_struct *work)
 
 	rq_lock_irq(rq, &rf);
 	curr = rq->curr;
-	if (is_idle_task(curr))
+	if (is_idle_task(curr) || cpu_is_offline(cpu))
 		goto out_unlock;
 
 	update_rq_clock(rq);
@@ -3098,13 +3127,21 @@ static void sched_tick_remote(struct work_struct *work)
 	/*
 	 * Run the remote tick once per second (1Hz). This arbitrary
 	 * frequency is large enough to avoid overload but short enough
-	 * to keep scheduler internal stats reasonably up to date.
+	 * to keep scheduler internal stats reasonably up to date.  But
+	 * first update state to reflect hotplug activity if required.
 	 */
+	os = atomic_read(&twork->state);
+	if (os) {
+		WARN_ON_ONCE(os != TICK_SCHED_REMOTE_OFFLINING);
+		if (atomic_inc_not_zero(&twork->state))
+			return;
+	}
 	queue_delayed_work(system_unbound_wq, dwork, HZ);
 }
 
 static void sched_tick_start(int cpu)
 {
+	int os;
 	struct tick_work *twork;
 
 	if (housekeeping_cpu(cpu, HK_FLAG_TICK))
@@ -3113,15 +3150,20 @@ static void sched_tick_start(int cpu)
 	WARN_ON_ONCE(!tick_work_cpu);
 
 	twork = per_cpu_ptr(tick_work_cpu, cpu);
-	twork->cpu = cpu;
-	INIT_DELAYED_WORK(&twork->work, sched_tick_remote);
-	queue_delayed_work(system_unbound_wq, &twork->work, HZ);
+	os = atomic_xchg(&twork->state, TICK_SCHED_REMOTE_RUNNING);
+	WARN_ON_ONCE(os == TICK_SCHED_REMOTE_RUNNING);
+	if (os == TICK_SCHED_REMOTE_OFFLINE) {
+		twork->cpu = cpu;
+		INIT_DELAYED_WORK(&twork->work, sched_tick_remote);
+		queue_delayed_work(system_unbound_wq, &twork->work, HZ);
+	}
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
 static void sched_tick_stop(int cpu)
 {
 	struct tick_work *twork;
+	int os;
 
 	if (housekeeping_cpu(cpu, HK_FLAG_TICK))
 		return;
@@ -3129,14 +3171,21 @@ static void sched_tick_stop(int cpu)
 	WARN_ON_ONCE(!tick_work_cpu);
 
 	twork = per_cpu_ptr(tick_work_cpu, cpu);
-	cancel_delayed_work_sync(&twork->work);
+	/* There cannot be competing actions, but don't rely on stop-machine. */
+	os = atomic_xchg(&twork->state, TICK_SCHED_REMOTE_OFFLINING);
+	WARN_ON_ONCE(os != TICK_SCHED_REMOTE_RUNNING);
+	/* Don't cancel, as this would mess up the state machine. */
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
 int __init sched_tick_offload_init(void)
 {
+	int cpu;
+
 	tick_work_cpu = alloc_percpu(struct tick_work);
 	BUG_ON(!tick_work_cpu);
+	for_each_possible_cpu(cpu)
+		atomic_set(&per_cpu(tick_work_cpu, cpu)->state, TICK_SCHED_REMOTE_OFFLINE);
 
 	return 0;
 }

