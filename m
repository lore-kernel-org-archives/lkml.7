Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E65C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 16:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F76421473
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 16:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbfGAQBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 12:01:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7578 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728142AbfGAQBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 12:01:11 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x61FvauR115900
        for <linux-kernel@vger.kernel.org>; Mon, 1 Jul 2019 12:01:10 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tfma43unx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 12:01:10 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 1 Jul 2019 17:01:09 +0100
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 1 Jul 2019 17:01:05 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x61G14Yh10289498
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Jul 2019 16:01:04 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B4085B2067;
        Mon,  1 Jul 2019 16:01:04 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 956AFB2066;
        Mon,  1 Jul 2019 16:01:04 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  1 Jul 2019 16:01:04 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 7054916C0B88; Mon,  1 Jul 2019 09:01:07 -0700 (PDT)
Date:   Mon, 1 Jul 2019 09:01:07 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Scott Wood <swood@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
Reply-To: paulmck@linux.ibm.com
References: <13761fee4b71cc004ad0d6709875ce917ff28fce.camel@redhat.com>
 <20190627203612.GD26519@linux.ibm.com>
 <20190628141522.GF3402@hirez.programming.kicks-ass.net>
 <20190628155404.GV26519@linux.ibm.com>
 <20190628160408.GH32547@worktop.programming.kicks-ass.net>
 <20190628172056.GW26519@linux.ibm.com>
 <20190701094215.GR3402@hirez.programming.kicks-ass.net>
 <20190701102442.35grdpcsbrwyyaco@linutronix.de>
 <20190701122305.GB26519@linux.ibm.com>
 <20190701140053.GV3402@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701140053.GV3402@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19070116-0060-0000-0000-000003579D17
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011360; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01225960; UDB=6.00645376; IPR=6.01007172;
 MB=3.00027538; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-01 16:01:09
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070116-0061-0000-0000-000049F9B055
Message-Id: <20190701160107.GG26519@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-01_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=830 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907010192
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 04:00:53PM +0200, Peter Zijlstra wrote:
> On Mon, Jul 01, 2019 at 05:23:05AM -0700, Paul E. McKenney wrote:
> > On Mon, Jul 01, 2019 at 12:24:42PM +0200, Sebastian Andrzej Siewior wrote:
> > > On 2019-07-01 11:42:15 [+0200], Peter Zijlstra wrote:
> > > > I'm not sure if smp_send_reschedule() can be used as self-IPI, some
> > > > hardware doesn't particularly like that IIRC. That is, hardware might
> > > > only have interfaces to IPI _other_ CPUs, but not self.
> > > > 
> > > > The normal scheduler code takes care to not call smp_send_reschedule()
> > > > to self.
> > > 
> > > and irq_work:
> > >   471ba0e686cb1 ("irq_work: Do not raise an IPI when queueing work on the local CPU")
> > 
> > OK, so it looks like I will need to use something else.  But thank you
> > for calling my attention to this commit.
> 
> I think that commit is worded slight confusing -- sorry I should've paid
> more attention.
> 
> irq_work _does_ work locally, and arch_irq_work_raise() must self-IPI,
> otherwise everything is horribly broken.
> 
> But what happened, was that irq_work_queue() and irq_work_queue_on(.cpu
> = smp_processor_id()) wasn't using the same code, and the latter would
> try to self-IPI through arch_send_call_function_single_ipi().
> 
> Nick fixed that so that irq_work_queue() and irq_work_queue_on(.cpu =
> smp_processor_id() now both use arch_raise_irq_work() and remote stuff
> uses arch_send_call_function_single_ipi().

OK, thank you for looking into this!

I therefore continue relying on IRQ work.  Should there be problems with
kernels not supporting IRQ work, and if there is a legitimate reason
why they should not support IRQ work, I can look into things like timers
for those kernels.

							Thanx, Paul

