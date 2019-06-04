Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D03FC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F5C24146
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfFDIgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:36:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58324 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726872AbfFDIge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:36:34 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x548Xj0Q120975
        for <linux-kernel@vger.kernel.org>; Tue, 4 Jun 2019 04:36:33 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2swjwvpexa-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 04:36:33 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 4 Jun 2019 09:36:32 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 4 Jun 2019 09:36:29 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x548aS8h19726796
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Jun 2019 08:36:28 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF2E7B2068;
        Tue,  4 Jun 2019 08:36:28 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D1C9B206A;
        Tue,  4 Jun 2019 08:36:28 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.171.86])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  4 Jun 2019 08:36:28 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D2BED16C5D9E; Tue,  4 Jun 2019 00:45:49 -0700 (PDT)
Date:   Tue, 4 Jun 2019 00:45:49 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        mingo@kernel.org, jpoimboe@redhat.com, mojha@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH HACK RFC] cpu: Prevent late-arriving interrupts from
 disrupting offline
Reply-To: paulmck@linux.ibm.com
References: <20190602011253.GA6167@linux.ibm.com>
 <20190603083848.GB3436@hirez.programming.kicks-ass.net>
 <20190603114455.GA16119@lakrids.cambridge.arm.com>
 <ea4887fb-cc77-59d4-3ba7-a59f5237ca40@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea4887fb-cc77-59d4-3ba7-a59f5237ca40@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19060408-0040-0000-0000-000004F85F29
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011212; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01213024; UDB=6.00637520; IPR=6.00994092;
 MB=3.00027177; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-04 08:36:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060408-0041-0000-0000-000009047D28
Message-Id: <20190604074549.GP28207@linux.ibm.com>
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

On Mon, Jun 03, 2019 at 03:39:18PM +0200, Dietmar Eggemann wrote:
> On 6/3/19 1:44 PM, Mark Rutland wrote:
> >On Mon, Jun 03, 2019 at 10:38:48AM +0200, Peter Zijlstra wrote:
> >>On Sat, Jun 01, 2019 at 06:12:53PM -0700, Paul E. McKenney wrote:
> >>>Scheduling-clock interrupts can arrive late in the CPU-offline process,
> >>>after idle entry and the subsequent call to cpuhp_report_idle_dead().
> >>>Once execution passes the call to rcu_report_dead(), RCU is ignoring
> >>>the CPU, which results in lockdep complaints when the interrupt handler
> >>>uses RCU:
> >>
> >>>diff --git a/kernel/cpu.c b/kernel/cpu.c
> >>>index 448efc06bb2d..3b33d83b793d 100644
> >>>--- a/kernel/cpu.c
> >>>+++ b/kernel/cpu.c
> >>>@@ -930,6 +930,7 @@ void cpuhp_report_idle_dead(void)
> >>>  	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
> >>>  	BUG_ON(st->state != CPUHP_AP_OFFLINE);
> >>>+	local_irq_disable();
> >>>  	rcu_report_dead(smp_processor_id());
> >>>  	st->state = CPUHP_AP_IDLE_DEAD;
> >>>  	udelay(1000);
> >>
> >>Urgh... I'd almost suggest we do something like the below.
> >>
> >>
> >>But then I started looking at the various arch_cpu_idle_dead()
> >>implementations and ran into arm's implementation, which is calling
> >>complete() where generic code already established this isn't possible
> >>(see for example cpuhp_report_idle_dead()).
> >
> >IIRC, that should have been migrated over to cpu_report_death(), as
> >arm64 was in commit:
> >
> >   05981277a4de1ad6 ("arm64: Use common outgoing-CPU-notification code")
> >
> >... but it looks like Paul's patch to do so [1] fell through the cracks;
> >I'm not aware of any reason that shouldn't have been taken.
> >[1] https://lore.kernel.org/lkml/1431467407-1223-8-git-send-email-paulmck@linux.vnet.ibm.com/
> >
> >Paul, do you want to resend that?
> 
> Please do. We're carrying this patch out-of-tree for while now in
> our EAS integration to get cpu hotplug tests passing on TC2 (arm).

Huh.  It still applies.  But I have no means of testing it.

And it looks like the reason I dropped it was that I didn't get any
response from the maintainer.  I sent a message to this effect to
linux-arm-kernel@lists.infradead.org and linux@arm.linux.org.uk on May
21, 2015.

So here it is again.  ;-)

I have queued this locally.  Left to myself, I add the two of you on its
Cc: list and run it through my normal process.  But given the history,
I would still want either an ack from the maintainer or, better, for
the maintainer to take the patch.

Or is there a better way for us to proceed on this?

							Thanx, Paul

------------------------------------------------------------------------

arm: Use common outgoing-CPU-notification code

This commit removes the open-coded CPU-offline notification with new
common code.  In particular, this change avoids calling scheduler code
using RCU from an offline CPU that RCU is ignoring.  This is a minimal
change.  A more intrusive change might invoke the cpu_check_up_prepare()
and cpu_set_state_online() functions at CPU-online time, which would
allow onlining throw an error if the CPU did not go offline properly.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index ebc53804d57b..8687d619260f 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -267,15 +267,13 @@ int __cpu_disable(void)
 	return 0;
 }
 
-static DECLARE_COMPLETION(cpu_died);
-
 /*
  * called on the thread which is asking for a CPU to be shutdown -
  * waits until shutdown has completed, or it is timed out.
  */
 void __cpu_die(unsigned int cpu)
 {
-	if (!wait_for_completion_timeout(&cpu_died, msecs_to_jiffies(5000))) {
+	if (!cpu_wait_death(cpu, 5)) {
 		pr_err("CPU%u: cpu didn't die\n", cpu);
 		return;
 	}
@@ -322,7 +320,7 @@ void arch_cpu_idle_dead(void)
 	 * this returns, power and/or clocks can be removed at any point
 	 * from this CPU and its cache by platform_cpu_kill().
 	 */
-	complete(&cpu_died);
+	(void)cpu_report_death();
 
 	/*
 	 * Ensure that the cache lines associated with that completion are

