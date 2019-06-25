Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27E9C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75270213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfFYNyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 09:54:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15580 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726659AbfFYNym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 09:54:42 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5PDsCQu146881
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 09:54:41 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tbm3ptb1q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 09:54:39 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 25 Jun 2019 14:54:33 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 25 Jun 2019 14:54:31 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5PDsUh341419078
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 13:54:30 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C410B2066;
        Tue, 25 Jun 2019 13:54:30 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F4A8B2064;
        Tue, 25 Jun 2019 13:54:30 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 25 Jun 2019 13:54:30 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 19B1716C2A6E; Tue, 25 Jun 2019 06:54:30 -0700 (PDT)
Date:   Tue, 25 Jun 2019 06:54:30 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de
Subject: Re: [PATCH] time/tick-broadcast: Fix tick_broadcast_offline()
 lockdep complaint
Reply-To: paulmck@linux.ibm.com
References: <20190621122927.GV3402@hirez.programming.kicks-ass.net>
 <20190621133414.GF26519@linux.ibm.com>
 <20190621174104.GA7519@linux.ibm.com>
 <20190621175027.GA23260@linux.ibm.com>
 <20190621234602.GA16286@linux.ibm.com>
 <20190624231222.GA17497@lerouge>
 <20190624234422.GP26519@linux.ibm.com>
 <20190625004300.GB17497@lerouge>
 <20190625075139.GT3436@hirez.programming.kicks-ass.net>
 <20190625122514.GA23880@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625122514.GA23880@lenoir>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19062513-0072-0000-0000-00000440CEED
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011327; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01223080; UDB=6.00643623; IPR=6.01004253;
 MB=3.00027460; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-25 13:54:33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062513-0073-0000-0000-00004CB0F3B9
Message-Id: <20190625135430.GW26519@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-25_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906250109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 02:25:16PM +0200, Frederic Weisbecker wrote:
> On Tue, Jun 25, 2019 at 09:51:39AM +0200, Peter Zijlstra wrote:
> > On Tue, Jun 25, 2019 at 02:43:00AM +0200, Frederic Weisbecker wrote:
> > > Yeah, unfortunately there is no atomic_add_not_zero_return().
> > 
> > There is atomic_fetch_add_unless().
> 
> Ah, that could work!

And it allows dispensing with the initialization.  How about like
the following?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 102dfcf0a29a..d7be6d4b6a0a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3050,8 +3050,36 @@ void scheduler_tick(void)
 
 struct tick_work {
 	int			cpu;
+	atomic_t		state;
 	struct delayed_work	work;
 };
+/* Values for ->state, see diagram below. */
+#define TICK_SCHED_REMOTE_OFFLINE	0
+#define TICK_SCHED_REMOTE_OFFLINING	1
+#define TICK_SCHED_REMOTE_RUNNING	2
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
 
@@ -3064,6 +3092,7 @@ static void sched_tick_remote(struct work_struct *work)
 	struct task_struct *curr;
 	struct rq_flags rf;
 	u64 delta;
+	int os;
 
 	/*
 	 * Handle the tick only if it appears the remote CPU is running in full
@@ -3077,7 +3106,7 @@ static void sched_tick_remote(struct work_struct *work)
 
 	rq_lock_irq(rq, &rf);
 	curr = rq->curr;
-	if (is_idle_task(curr))
+	if (is_idle_task(curr) || cpu_is_offline(cpu))
 		goto out_unlock;
 
 	update_rq_clock(rq);
@@ -3097,13 +3126,18 @@ static void sched_tick_remote(struct work_struct *work)
 	/*
 	 * Run the remote tick once per second (1Hz). This arbitrary
 	 * frequency is large enough to avoid overload but short enough
-	 * to keep scheduler internal stats reasonably up to date.
+	 * to keep scheduler internal stats reasonably up to date.  But
+	 * first update state to reflect hotplug activity if required.
 	 */
-	queue_delayed_work(system_unbound_wq, dwork, HZ);
+	os = atomic_fetch_add_unless(&twork->state, -1, TICK_SCHED_REMOTE_RUNNING);
+	WARN_ON_ONCE(os == TICK_SCHED_REMOTE_OFFLINE);
+	if (os == TICK_SCHED_REMOTE_RUNNING)
+		queue_delayed_work(system_unbound_wq, dwork, HZ);
 }
 
 static void sched_tick_start(int cpu)
 {
+	int os;
 	struct tick_work *twork;
 
 	if (housekeeping_cpu(cpu, HK_FLAG_TICK))
@@ -3112,15 +3146,20 @@ static void sched_tick_start(int cpu)
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
@@ -3128,7 +3167,10 @@ static void sched_tick_stop(int cpu)
 	WARN_ON_ONCE(!tick_work_cpu);
 
 	twork = per_cpu_ptr(tick_work_cpu, cpu);
-	cancel_delayed_work_sync(&twork->work);
+	/* There cannot be competing actions, but don't rely on stop-machine. */
+	os = atomic_xchg(&twork->state, TICK_SCHED_REMOTE_OFFLINING);
+	WARN_ON_ONCE(os != TICK_SCHED_REMOTE_RUNNING);
+	/* Don't cancel, as this would mess up the state machine. */
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
@@ -3136,7 +3178,6 @@ int __init sched_tick_offload_init(void)
 {
 	tick_work_cpu = alloc_percpu(struct tick_work);
 	BUG_ON(!tick_work_cpu);
-
 	return 0;
 }
 

