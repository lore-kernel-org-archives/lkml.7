Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBC5C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 18:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755FD2083B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 18:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfF1SXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 14:23:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15936 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726525AbfF1SXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 14:23:34 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5SILuCF171371
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 14:23:31 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tdndgp457-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 14:23:31 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 28 Jun 2019 19:23:30 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 28 Jun 2019 19:23:26 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5SINPpS48169446
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 18:23:25 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1251AB2064;
        Fri, 28 Jun 2019 18:23:25 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9131B2066;
        Fri, 28 Jun 2019 18:23:24 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 28 Jun 2019 18:23:24 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8F9E816C5DA7; Fri, 28 Jun 2019 11:23:25 -0700 (PDT)
Date:   Fri, 28 Jun 2019 11:23:25 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
Reply-To: paulmck@linux.ibm.com
References: <20190627153031.GA249127@google.com>
 <20190627155506.GU26519@linux.ibm.com>
 <CAEXW_YSEN_OL3ftTLN=M-W70WSuCgHJqU-R9VhS=A3uVj_AL+A@mail.gmail.com>
 <20190627173831.GW26519@linux.ibm.com>
 <20190627181638.GA209455@google.com>
 <20190627184107.GA26519@linux.ibm.com>
 <20190628164008.GB240964@google.com>
 <20190628164559.GC240964@google.com>
 <20190628173011.GX26519@linux.ibm.com>
 <20190628180537.GD240964@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628180537.GD240964@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19062818-2213-0000-0000-000003A64CA7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011348; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01224588; UDB=6.00644540; IPR=6.01005780;
 MB=3.00027510; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-28 18:23:28
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062818-2214-0000-0000-00005F081ADA
Message-Id: <20190628182325.GZ26519@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-28_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906280207
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 02:05:37PM -0400, Joel Fernandes wrote:
> On Fri, Jun 28, 2019 at 10:30:11AM -0700, Paul E. McKenney wrote:
> > On Fri, Jun 28, 2019 at 12:45:59PM -0400, Joel Fernandes wrote:
> > > On Fri, Jun 28, 2019 at 12:40:08PM -0400, Joel Fernandes wrote:
> > > > On Thu, Jun 27, 2019 at 11:41:07AM -0700, Paul E. McKenney wrote:
> > > > [snip]
> > > > > > > > And we should document this somewhere for future sanity preservation
> > > > > > > > :-D
> > > > > > > 
> > > > > > > Or adjust the code and requirements to make it more sane, if feasible.
> > > > > > > 
> > > > > > > My current (probably wildly unreliable) guess that the conditions in
> > > > > > > rcu_read_unlock_special() need adjusting.  I was assuming that in_irq()
> > > > > > > implies a hardirq context, in other words that in_irq() would return
> > > > > > > false from a threaded interrupt handler.  If in_irq() instead returns
> > > > > > > true from within a threaded interrupt handler, then this code in
> > > > > > > rcu_read_unlock_special() needs fixing:
> > > > > > > 
> > > > > > > 		if ((exp || in_irq()) && irqs_were_disabled && use_softirq &&
> > > > > > > 		    (in_irq() || !t->rcu_read_unlock_special.b.deferred_qs)) {
> > > > > > > 			// Using softirq, safe to awaken, and we get
> > > > > > > 			// no help from enabling irqs, unlike bh/preempt.
> > > > > > > 			raise_softirq_irqoff(RCU_SOFTIRQ);
> > > > > > > 
> > > > > > > The fix would be replacing the calls to in_irq() with something that
> > > > > > > returns true only if called from within a hardirq context.
> > > > > > > Thoughts?
> > > > > > 
> > > > > > I am not sure if this will fix all cases though?
> > > > > > 
> > > > > > I think the crux of the problem is doing a recursive wake up. The threaded
> > > > > > IRQ probably just happens to be causing it here, it seems to me this problem
> > > > > > can also occur on a non-threaded irq system (say current_reader() in your
> > > > > > example executed in a scheduler path in process-context and not from an
> > > > > > interrupt). Is that not possible?
> > > > > 
> > > > > In the non-threaded case, invoking raise_softirq*() from hardirq context
> > > > > just sets a bit in a per-CPU variable.  Now, to Sebastian's point, we
> > > > > are only sort of in hardirq context in this case due to being called
> > > > > from irq_exit(), but the failure we are seeing might well be a ways
> > > > > downstream of the actual root-cause bug.
> > > > 
> > > > Hi Paul,
> > > > I was talking about calling of rcu_read_unlock_special from a normal process
> > > > context from the scheduler.
> > > > 
> > > > In the below traces, it shows that only the PREEMPT_MASK offset is set at the
> > > > time of the issue. Both HARD AND SOFT IRQ masks are not enabled, which means
> > > > the lock up is from a normal process context.
> > > > 
> > > > I think I finally understood why the issue shows up only with threadirqs in
> > > > my setup. If I build x86_64_defconfig, the CONFIG_IRQ_FORCED_THREADING=y
> > > > option is set. And booting this with threadirqs, it always tries to
> > > > wakeup_ksoftirqd in invoke_softirq.
> > > > 
> > > > I believe what happens is, at an in-opportune time when the .blocked field is
> > > > set for the preempted task, an interrupt is received. This timing is quite in
> > > > auspicious because t->rcu_read_unlock_special just happens to have its
> > > > .blocked field set even though it is not in a reader-section.
> > 
> > Thank you for tracing through this!
> 
> My pleasure ;)
> 
> > > I believe the .blocked field remains set even though we are not any more in a
> > > reader section because of deferred processing of the blocked lists that you
> > > mentioned yesterday.
> > 
> > That can indeed happen.  However, in current -rcu, that would mean
> > that .deferred_qs is also set, which (if in_irq()) would prevent
> > the raise_softirq_irqsoff() from being invoked.  Which was why I was
> > asking the questions about whether in_irq() returns true within threaded
> > interrupts yesterday.  If it does, I need to find if there is some way
> > of determining whether rcu_read_unlock_special() is being called from
> > a threaded interrupt in order to suppress the call to raise_softirq()
> > in that case.
> 
> Thanks. I will take a look at the -rcu tree a bit and reply to this.
> 
> > But which version of the kernel are you using here?  Current -rcu?
> > v5.2-rc1?  Something else?
> 
> This is v5.2-rc6 kernel version from Linus tree which was showing the issue.

OK, that version does not contain the alleged fixes that are in -rcu.

							Thanx, Paul

