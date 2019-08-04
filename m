Return-Path: <SRS0=geQ9=WA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EFBC19759
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 20:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42D2206C1
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 20:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfHDUZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 16:25:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63702 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726392AbfHDUZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 16:25:39 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x74KMBpc018760;
        Sun, 4 Aug 2019 16:24:46 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u5qn6g5u0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 04 Aug 2019 16:24:46 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x74KMcs7019432;
        Sun, 4 Aug 2019 16:24:46 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u5qn6g5tr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 04 Aug 2019 16:24:45 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x74KOjE3004344;
        Sun, 4 Aug 2019 20:24:45 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02wdc.us.ibm.com with ESMTP id 2u51w612af-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 04 Aug 2019 20:24:45 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x74KOi8A10945276
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 4 Aug 2019 20:24:44 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBC96B205F;
        Sun,  4 Aug 2019 20:24:44 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 86269B2064;
        Sun,  4 Aug 2019 20:24:44 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.150.228])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun,  4 Aug 2019 20:24:44 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id EEA0016C9A2E; Sun,  4 Aug 2019 13:24:46 -0700 (PDT)
Date:   Sun, 4 Aug 2019 13:24:46 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH RFC tip/core/rcu 14/14] rcu/nohz: Make multi_cpu_stop()
 enable tick on all online CPUs
Message-ID: <20190804202446.GA25634@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190802151435.GA1081@linux.ibm.com>
 <20190802151501.13069-14-paulmck@linux.ibm.com>
 <20190804144317.GF2349@hirez.programming.kicks-ass.net>
 <20190804144835.GB2386@hirez.programming.kicks-ass.net>
 <20190804184159.GC28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190804184159.GC28441@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-04_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908040238
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 04, 2019 at 11:41:59AM -0700, Paul E. McKenney wrote:
> On Sun, Aug 04, 2019 at 04:48:35PM +0200, Peter Zijlstra wrote:
> > On Sun, Aug 04, 2019 at 04:43:17PM +0200, Peter Zijlstra wrote:
> > > On Fri, Aug 02, 2019 at 08:15:01AM -0700, Paul E. McKenney wrote:
> > > > The multi_cpu_stop() function relies on the scheduler to gain control from
> > > > whatever is running on the various online CPUs, including any nohz_full
> > > > CPUs running long loops in kernel-mode code.  Lack of the scheduler-clock
> > > > interrupt on such CPUs can delay multi_cpu_stop() for several minutes
> > > > and can also result in RCU CPU stall warnings.  This commit therefore
> > > > causes multi_cpu_stop() to enable the scheduler-clock interrupt on all
> > > > online CPUs.
> > > 
> > > This sounds wrong; should we be fixing sched_can_stop_tick() instead to
> > > return false when the stop task is runnable?
> 
> Agreed.  However, it is proving surprisingly hard to come up with a
> code sequence that has the effect of rcu_nocb without nohz_full.
> And rcu_nocb works just fine.  With nohz_full also in place, I am
> decreasing the failure rate, but it still fails, perhaps a few times
> per hour of TREE04 rcutorture on an eight-CPU system.  (My 12-CPU
> system stubbornly refuses to fail.  Good thing I kept the eight-CPU
> system around, I guess.)
> 
> When I arrive at some sequence of actions that actually work reliably,
> then by all means let's put it somewhere in the NO_HZ_FULL machinery!
> 
> > And even without that; I don't understand how we're not instantly
> > preempted the moment we enqueue the stop task.
> 
> There is no preemption because CONFIG_PREEMPT=n for the scenarios still
> having trouble.  Yes, there are cond_resched() calls, but they don't do
> anything unless the appropriate flags are set, which won't always happen
> without the tick, apparently.  Or without -something- that isn't always
> happening as it should.
> 
> > Any enqueue, should go through check_preempt_curr() which will be an
> > instant resched_curr() when we just woke the stop class.
> 
> I did try hitting all of the CPUs with resched_cpu().  Ten times on each
> CPU with a ten-jiffy wait between each.  This might have decreased the
> probability of excessively long CPU-stopper waits by a factor of two or
> three, but it did not eliminate the excessively long waits.
> 
> What else should I try?
> 
> For example, are there any diagnostics I could collect, say from within
> the CPU stopper when things are taking too long?  I see CPU-stopper
> delays in excess of five -minutes-, so this is anything but subtle.

For whatever it is worth, the things on my list include using 25 rounds
of resched_cpu() on each CPU with ten-jiffy wait between each (instead of
merely 10 rounds), using waitqueues or some such to actually force a
meaningful context switch on the other CPUs, etc.

							Thanx, Paul
