Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C920C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4104E217D8
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfEIRhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 13:37:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39260 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726576AbfEIRhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 13:37:00 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x49HakTa067240
        for <linux-kernel@vger.kernel.org>; Thu, 9 May 2019 13:36:59 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2scpwq51hr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 13:36:58 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 9 May 2019 18:36:58 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 9 May 2019 18:36:55 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x49Hasn830015696
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 May 2019 17:36:54 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2041B205F;
        Thu,  9 May 2019 17:36:54 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75041B2066;
        Thu,  9 May 2019 17:36:54 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  9 May 2019 17:36:54 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A602616C3968; Thu,  9 May 2019 10:36:54 -0700 (PDT)
Date:   Thu, 9 May 2019 10:36:54 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, andrea.parri@amarulasolutions.com
Subject: Re: Question about sched_setaffinity()
Reply-To: paulmck@linux.ibm.com
References: <20190427180246.GA15502@linux.ibm.com>
 <20190430100318.GP2623@hirez.programming.kicks-ass.net>
 <20190430105129.GA3923@linux.ibm.com>
 <20190430115551.GT2623@hirez.programming.kicks-ass.net>
 <20190501191213.GX3923@linux.ibm.com>
 <20190501151655.51469a4c@gandalf.local.home>
 <20190501202713.GY3923@linux.ibm.com>
 <20190507221613.GA11057@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507221613.GA11057@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19050917-0052-0000-0000-000003BD00E0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011077; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01200919; UDB=6.00630155; IPR=6.00981810;
 MB=3.00026815; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-09 17:36:57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050917-0053-0000-0000-000060D554E4
Message-Id: <20190509173654.GA23530@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-09_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905090101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 03:16:13PM -0700, Paul E. McKenney wrote:
> On Wed, May 01, 2019 at 01:27:13PM -0700, Paul E. McKenney wrote:
> > On Wed, May 01, 2019 at 03:16:55PM -0400, Steven Rostedt wrote:
> > > On Wed, 1 May 2019 12:12:13 -0700
> > > "Paul E. McKenney" <paulmck@linux.ibm.com> wrote:
> > > 
> > > 
> > > > OK, what I did was to apply the patch at the end of this email to -rcu
> > > > branch dev, then run rcutorture as follows:
> > > > 
> > > > nohup tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 8 --duration 2 --configs "TRIVIAL" --bootargs "trace_event=sched:sched_switch,sched:sched_wakeup ftrace=function_graph ftrace_graph_filter=sched_setaffinity,migration_cpu_stop"
> > > > 
> > > > This resulted in the console output that I placed here:
> > > > 
> > > > http://www2.rdrop.com/~paulmck/submission/console.log.gz
> > > > 
> > > > But I don't see calls to sched_setaffinity() or migration_cpu_stop().
> > > > Steve, is something else needed on the kernel command line in addition to
> > > > the following?
> > > > 
> > > > ftrace=function_graph ftrace_graph_filter=sched_setaffinity,migration_cpu_stop
> > > 
> > > Do you have function graph enabled in the config?
> > > 
> > > [    2.098303] ftrace bootup tracer 'function_graph' not registered.
> > 
> > I guess I don't!  Thank you, will fix.
> > 
> > Let's see...
> > 
> > My .config has CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y.  It looks like I
> > need CONFIG_FUNCTION_GRAPH_TRACER=y, which I don't have.  And it looks
> > like that needs CONFIG_FUNCTION_TRACER=y, which I also don't have.
> > But I do have CONFIG_HAVE_FUNCTION_TRACER=y.  So I should add this
> > to my rcutorture command line:
> > 
> > --kconfig "CONFIG_FUNCTION_TRACER=y CONFIG_FUNCTION_GRAPH_TRACER=y".
> > 
> > I fired this up.  Here is hoping!  ;-)
> > 
> > And it does have sched_setaffinity(), woo-hoo!!!  I overwrote the old file:
> > 
> > 	http://www2.rdrop.com/~paulmck/submission/console.log.gz
> 
> And I reran after adding a trace_printk(), which shows up as follows:
> 
> [  211.409565]  6)               |  /* On unexpected CPU 6, expected 4!!! */
> 
> I placed the console log here:
> 
> 	http://www2.rdrop.com/~paulmck/submission/console.tpk.log.gz
> 
> Just in case the earlier log proves useful.
> 
> And it is acting as if the destination CPU proved to be offline.  Except
> that this rcutorture scenario doesn't offline anything, and I don't see
> any CPU-hotplug removal messages.  So I added another trace_printk() to
> print out cpu_online_mask.  This gets me the following:
> 
> [   31.565605]  0)               |  /* On unexpected CPU 0, expected 1!!! */
> [   31.565605]  0)               |  /* Online CPUs: 0-7 */
> 
> So we didn't make it to CPU 1 despite its being online.  I placed the
> console log here:
> 
> 	http://www2.rdrop.com/~paulmck/submission/console.tpkol.log.gz
> 
> Thoughts?
> 
> Updated patch against -rcu below in case it is useful.

I added more debug and got this:

[  215.097318]  4)               |  /* On unexpected CPU 4, expected 5!!! */
[  215.098285]  4)               |  /* Online CPUs: 0-7  Active CPUs: 0-7 */
[  215.099283]  4)               |  /* ret = 0, ->cpus_allowed 0-4,6-7 */

http://www.rdrop.com/~paulmck/submission/console.tpkm.log.gz

The task's ->cpus_allowed got set to the bitwise not of the requested
mask.  I took a quick scan through the code but don't see how this
happens.

Very strange.

Any suggestions for further debugging?  Left to myself, I would copy
the requested cpumask to a per-task location and insert checks in the
sched_setaffinity() code path, crude and ugly though that might seem.
(Ugly enough that I will wait until tomorrow to try it out.)

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index da04b5073dc3..51db19543012 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -680,12 +680,31 @@ static struct rcu_torture_ops tasks_ops = {
 static void synchronize_rcu_trivial(void)
 {
 	int cpu;
+	int destcpu;
+	static int dont_trace;
+	static cpumask_t my_cpumask;
+	static DEFINE_SPINLOCK(my_cpumask_lock);
+	int ret;
 
 	for_each_online_cpu(cpu) {
-		while (raw_smp_processor_id() != cpu)
-			rcutorture_sched_setaffinity(current->pid,
-						     cpumask_of(cpu));
-		WARN_ON_ONCE(raw_smp_processor_id() != cpu);
+		if (!READ_ONCE(dont_trace))
+			tracing_on();
+		rcutorture_sched_setaffinity(current->pid, cpumask_of(cpu));
+		destcpu = raw_smp_processor_id();
+		if (destcpu == cpu) {
+			tracing_off();
+		} else {
+			trace_printk("On unexpected CPU %d, expected %d!!!\n", destcpu, cpu);
+			trace_printk("Online CPUs: %*pbl  Active CPUs: %*pbl\n", cpumask_pr_args(cpu_online_mask), cpumask_pr_args(cpu_active_mask));
+			spin_lock(&my_cpumask_lock);
+			ret = sched_getaffinity(current->pid, &my_cpumask);
+			trace_printk("ret = %d, ->cpus_allowed %*pbl\n", ret, cpumask_pr_args(&my_cpumask));
+			spin_unlock(&my_cpumask_lock);
+			tracing_stop();
+			WRITE_ONCE(dont_trace, 1);
+			WARN_ON_ONCE(1);
+			rcu_ftrace_dump(DUMP_ALL);
+		}
 	}
 }
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index caffee644932..edaf0ca22ff7 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3495,6 +3495,7 @@ void __init rcu_init(void)
 	rcu_par_gp_wq = alloc_workqueue("rcu_par_gp", WQ_MEM_RECLAIM, 0);
 	WARN_ON(!rcu_par_gp_wq);
 	srcu_init();
+	tracing_off();
 }
 
 #include "tree_stall.h"

