Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD5CC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 23:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2697020665
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 23:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfHLXX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 19:23:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36448 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726144AbfHLXX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 19:23:57 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7CNLsl6087075;
        Mon, 12 Aug 2019 19:23:15 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ubh68s0aj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Aug 2019 19:23:15 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7CNMrfI089904;
        Mon, 12 Aug 2019 19:23:14 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ubh68s09u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Aug 2019 19:23:14 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7CNKZf6031273;
        Mon, 12 Aug 2019 23:23:13 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma04wdc.us.ibm.com with ESMTP id 2u9nj6a6hc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Aug 2019 23:23:13 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7CNNCsK48431482
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Aug 2019 23:23:12 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89582B2066;
        Mon, 12 Aug 2019 23:23:12 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A263B2064;
        Mon, 12 Aug 2019 23:23:12 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 12 Aug 2019 23:23:12 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A127D16C0783; Mon, 12 Aug 2019 16:23:16 -0700 (PDT)
Date:   Mon, 12 Aug 2019 16:23:16 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH RFC tip/core/rcu 14/14] rcu/nohz: Make multi_cpu_stop()
 enable tick on all online CPUs
Message-ID: <20190812232316.GT28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190802151435.GA1081@linux.ibm.com>
 <20190802151501.13069-14-paulmck@linux.ibm.com>
 <20190812210232.GA3648@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812210232.GA3648@lenoir>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-12_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=779 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908120229
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 11:02:33PM +0200, Frederic Weisbecker wrote:
> On Fri, Aug 02, 2019 at 08:15:01AM -0700, Paul E. McKenney wrote:
> > The multi_cpu_stop() function relies on the scheduler to gain control from
> > whatever is running on the various online CPUs, including any nohz_full
> > CPUs running long loops in kernel-mode code.  Lack of the scheduler-clock
> > interrupt on such CPUs can delay multi_cpu_stop() for several minutes
> > and can also result in RCU CPU stall warnings.  This commit therefore
> > causes multi_cpu_stop() to enable the scheduler-clock interrupt on all
> > online CPUs.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > ---
> >  kernel/stop_machine.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
> > index b4f83f7bdf86..a2659f61ed92 100644
> > --- a/kernel/stop_machine.c
> > +++ b/kernel/stop_machine.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/smpboot.h>
> >  #include <linux/atomic.h>
> >  #include <linux/nmi.h>
> > +#include <linux/tick.h>
> >  #include <linux/sched/wake_q.h>
> >  
> >  /*
> > @@ -187,15 +188,19 @@ static int multi_cpu_stop(void *data)
> >  {
> >  	struct multi_stop_data *msdata = data;
> >  	enum multi_stop_state curstate = MULTI_STOP_NONE;
> > -	int cpu = smp_processor_id(), err = 0;
> > +	int cpu, err = 0;
> >  	const struct cpumask *cpumask;
> >  	unsigned long flags;
> >  	bool is_active;
> >  
> > +	for_each_online_cpu(cpu)
> > +		tick_nohz_dep_set_cpu(cpu, TICK_DEP_MASK_RCU);
> 
> Looks like it's not the right fix but, should you ever need to set an
> all-CPUs (system wide) tick dependency in the future, you can use tick_set_dep().

Indeed, I have dropped this patch, but I now do something similar in
RCU's CPU-hotplug notifiers.  Which does have an effect, especially on
the system that isn't subject to the insane-latency cpu_relax().

Plus I am having to put a similar workaround into RCU's quiescent-state
forcing logic.

But how should this really be done?

Isn't there some sort of monitoring of nohz_full CPUs for accounting
purposes?  If so, would it make sense for this monitoring to check for
long-duration kernel execution and enable the tick in this case?  The
RCU dyntick machinery can be used to remotely detect the long-duration
kernel execution using something like the following:

	int nohz_in_kernel_snap = rcu_dynticks_snap_cpu(cpu);

	...

	if (rcu_dynticks_in_eqs_cpu(cpu, nohz_in_kernel_snap)
		nohz_in_kernel_snap = rcu_dynticks_snap_cpu(cpu);
	else
		/* Turn on the tick! */

I would supply rcu_dynticks_snap_cpu() and rcu_dynticks_in_eqs_cpu(),
which would be simple wrappers around RCU's private rcu_dynticks_snap()
and rcu_dynticks_in_eqs() functions.

Would this make sense as a general solution, or am I missing a corner
case or three?

							Thanx, Paul
