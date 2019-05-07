Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359D7C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 22:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE0420675
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 22:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfEGWRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 18:17:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54606 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725843AbfEGWRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 18:17:34 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x47MHHhv112796
        for <linux-kernel@vger.kernel.org>; Tue, 7 May 2019 18:17:32 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sbfbn806y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 18:17:32 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 7 May 2019 23:17:32 +0100
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 7 May 2019 23:17:29 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x47MGDPM29163620
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 May 2019 22:16:13 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79E6CB2087;
        Tue,  7 May 2019 22:16:13 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4DA94B2085;
        Tue,  7 May 2019 22:16:13 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  7 May 2019 22:16:13 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6EDA816C1E98; Tue,  7 May 2019 15:16:13 -0700 (PDT)
Date:   Tue, 7 May 2019 15:16:13 -0700
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501202713.GY3923@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19050722-0060-0000-0000-0000033C7253
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011068; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01200063; UDB=6.00629637; IPR=6.00980945;
 MB=3.00026778; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-07 22:17:30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050722-0061-0000-0000-00004942CFD9
Message-Id: <20190507221613.GA11057@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-07_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905070139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 01:27:13PM -0700, Paul E. McKenney wrote:
> On Wed, May 01, 2019 at 03:16:55PM -0400, Steven Rostedt wrote:
> > On Wed, 1 May 2019 12:12:13 -0700
> > "Paul E. McKenney" <paulmck@linux.ibm.com> wrote:
> > 
> > 
> > > OK, what I did was to apply the patch at the end of this email to -rcu
> > > branch dev, then run rcutorture as follows:
> > > 
> > > nohup tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 8 --duration 2 --configs "TRIVIAL" --bootargs "trace_event=sched:sched_switch,sched:sched_wakeup ftrace=function_graph ftrace_graph_filter=sched_setaffinity,migration_cpu_stop"
> > > 
> > > This resulted in the console output that I placed here:
> > > 
> > > http://www2.rdrop.com/~paulmck/submission/console.log.gz
> > > 
> > > But I don't see calls to sched_setaffinity() or migration_cpu_stop().
> > > Steve, is something else needed on the kernel command line in addition to
> > > the following?
> > > 
> > > ftrace=function_graph ftrace_graph_filter=sched_setaffinity,migration_cpu_stop
> > 
> > Do you have function graph enabled in the config?
> > 
> > [    2.098303] ftrace bootup tracer 'function_graph' not registered.
> 
> I guess I don't!  Thank you, will fix.
> 
> Let's see...
> 
> My .config has CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y.  It looks like I
> need CONFIG_FUNCTION_GRAPH_TRACER=y, which I don't have.  And it looks
> like that needs CONFIG_FUNCTION_TRACER=y, which I also don't have.
> But I do have CONFIG_HAVE_FUNCTION_TRACER=y.  So I should add this
> to my rcutorture command line:
> 
> --kconfig "CONFIG_FUNCTION_TRACER=y CONFIG_FUNCTION_GRAPH_TRACER=y".
> 
> I fired this up.  Here is hoping!  ;-)
> 
> And it does have sched_setaffinity(), woo-hoo!!!  I overwrote the old file:
> 
> 	http://www2.rdrop.com/~paulmck/submission/console.log.gz

And I reran after adding a trace_printk(), which shows up as follows:

[  211.409565]  6)               |  /* On unexpected CPU 6, expected 4!!! */

I placed the console log here:

	http://www2.rdrop.com/~paulmck/submission/console.tpk.log.gz

Just in case the earlier log proves useful.

And it is acting as if the destination CPU proved to be offline.  Except
that this rcutorture scenario doesn't offline anything, and I don't see
any CPU-hotplug removal messages.  So I added another trace_printk() to
print out cpu_online_mask.  This gets me the following:

[   31.565605]  0)               |  /* On unexpected CPU 0, expected 1!!! */
[   31.565605]  0)               |  /* Online CPUs: 0-7 */

So we didn't make it to CPU 1 despite its being online.  I placed the
console log here:

	http://www2.rdrop.com/~paulmck/submission/console.tpkol.log.gz

Thoughts?

Updated patch against -rcu below in case it is useful.

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index da04b5073dc3..23ec8ec7eddd 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -680,12 +680,24 @@ static struct rcu_torture_ops tasks_ops = {
 static void synchronize_rcu_trivial(void)
 {
 	int cpu;
+	int destcpu;
+	static int dont_trace;
 
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
+			trace_printk("Online CPUs: %*pbl\n", cpumask_pr_args(cpu_online_mask));
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

