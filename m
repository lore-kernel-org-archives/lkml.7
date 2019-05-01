Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882C2C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 19:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536622081C
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 19:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbfEATMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 15:12:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42744 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726019AbfEATMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 15:12:20 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x41JBhLJ056834
        for <linux-kernel@vger.kernel.org>; Wed, 1 May 2019 15:12:18 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s7es8ycw0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 15:12:18 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 1 May 2019 20:12:18 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 1 May 2019 20:12:14 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x41JCDbq29294592
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 May 2019 19:12:14 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9711B205F;
        Wed,  1 May 2019 19:12:13 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DD8AB2065;
        Wed,  1 May 2019 19:12:13 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  1 May 2019 19:12:13 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A88BF16C1656; Wed,  1 May 2019 12:12:13 -0700 (PDT)
Date:   Wed, 1 May 2019 12:12:13 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, andrea.parri@amarulasolutions.com,
        rostedt@goodmis.org
Subject: Re: Question about sched_setaffinity()
Reply-To: paulmck@linux.ibm.com
References: <20190427180246.GA15502@linux.ibm.com>
 <20190430100318.GP2623@hirez.programming.kicks-ass.net>
 <20190430105129.GA3923@linux.ibm.com>
 <20190430115551.GT2623@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430115551.GT2623@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19050119-0040-0000-0000-000004E9B45D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011030; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01197153; UDB=6.00627876; IPR=6.00978007;
 MB=3.00026686; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-01 19:12:16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050119-0041-0000-0000-000008F5B899
Message-Id: <20190501191213.GX3923@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905010119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 01:55:51PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 30, 2019 at 03:51:30AM -0700, Paul E. McKenney wrote:
> > > Then I'm not entirely sure how we can return 0 and not run on the
> > > expected CPU. If we look at __set_cpus_allowed_ptr(), the only paths out
> > > to 0 are:
> > > 
> > >  - if the mask didn't change
> > >  - if we already run inside the new mask
> > >  - if we migrated ourself with the stop-task
> > >  - if we're not in fact running
> > > 
> > > That last case should never trigger in your circumstances, since @p ==
> > > current and current is obviously running. But for completeness, the
> > > wakeup of @p would do the task placement in that case.
> > 
> > Are there some diagnostics I could add that would help track this down,
> > be it my bug or yours?
> 
> Maybe limited function trace combined with the scheduling tracepoints
> would give clue.
> 
> Trouble is, I forever forget how to set that up properly :/ Maybe
> something along these lines:
> 
> $ trace-cmd record -p function_graph -g sched_setaffinity -g migration_cpu_stop -e
> sched_migirate_task -e sched_switch -e sched_wakeup
> 
> Also useful would be:
> 
> echo 1 > /proc/sys/kernel/traceoff_on_warning
> 
> which ensures the trace stops the moment we find fail.

OK, what I did was to apply the patch at the end of this email to -rcu
branch dev, then run rcutorture as follows:

nohup tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 8 --duration 2 --configs "TRIVIAL" --bootargs "trace_event=sched:sched_switch,sched:sched_wakeup ftrace=function_graph ftrace_graph_filter=sched_setaffinity,migration_cpu_stop"

This resulted in the console output that I placed here:

http://www2.rdrop.com/~paulmck/submission/console.log.gz

But I don't see calls to sched_setaffinity() or migration_cpu_stop().
Steve, is something else needed on the kernel command line in addition to
the following?

ftrace=function_graph ftrace_graph_filter=sched_setaffinity,migration_cpu_stop

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index da04b5073dc3..ceae80522d64 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -680,12 +680,18 @@ static struct rcu_torture_ops tasks_ops = {
 static void synchronize_rcu_trivial(void)
 {
 	int cpu;
+	static int dont_trace;
 
 	for_each_online_cpu(cpu) {
-		while (raw_smp_processor_id() != cpu)
-			rcutorture_sched_setaffinity(current->pid,
-						     cpumask_of(cpu));
-		WARN_ON_ONCE(raw_smp_processor_id() != cpu);
+		if (!READ_ONCE(dont_trace))
+			tracing_on();
+		rcutorture_sched_setaffinity(current->pid, cpumask_of(cpu));
+		tracing_off();
+		if (raw_smp_processor_id() != cpu) {
+			WRITE_ONCE(dont_trace, 1);
+			WARN_ON_ONCE(1);
+			ftrace_dump(DUMP_ALL);
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

