Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF161C32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 03:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A05C9217F4
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 03:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfHJDkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 23:40:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49760 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725927AbfHJDke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 23:40:34 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7A3adH7123590
        for <linux-kernel@vger.kernel.org>; Fri, 9 Aug 2019 23:40:33 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u9eyxvwx7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 23:40:33 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 10 Aug 2019 04:40:32 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 10 Aug 2019 04:40:28 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7A3eR2P49414614
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Aug 2019 03:40:27 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6E19B205F;
        Sat, 10 Aug 2019 03:40:27 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A18A8B206A;
        Sat, 10 Aug 2019 03:40:27 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.138.198])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 10 Aug 2019 03:40:27 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B2D6616C9A73; Fri,  9 Aug 2019 20:40:27 -0700 (PDT)
Date:   Fri, 9 Aug 2019 20:40:27 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Byungchul Park <byungchul.park@lge.com>,
        linux-kernel@vger.kernel.org, Rao Shoaib <rao.shoaib@oracle.com>,
        max.byungchul.park@gmail.com, kernel-team@android.com,
        kernel-team@lge.com, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC v1 1/2] rcu/tree: Add basic support for kfree_rcu
 batching
Reply-To: paulmck@linux.ibm.com
References: <20190807175215.GE28441@linux.ibm.com>
 <20190808095232.GA30401@X58A-UD3R>
 <20190808125607.GB261256@google.com>
 <20190808233014.GA184373@google.com>
 <20190809151619.GD28441@linux.ibm.com>
 <20190809153924.GB211412@google.com>
 <20190809163346.GF28441@linux.ibm.com>
 <20190809202226.GC255533@google.com>
 <20190809204217.GN28441@linux.ibm.com>
 <20190809213643.GG255533@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809213643.GG255533@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19081003-0064-0000-0000-000004073C44
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011577; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01244612; UDB=6.00656653; IPR=6.01026096;
 MB=3.00028115; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-10 03:40:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081003-0065-0000-0000-00003E9CFA87
Message-Id: <20190810034027.GR28441@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-10_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908100038
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 05:36:43PM -0400, Joel Fernandes wrote:
> On Fri, Aug 09, 2019 at 01:42:17PM -0700, Paul E. McKenney wrote:
> > > Also, I can go back to 500M if I just keep KFREE_DRAIN_JIFFIES at HZ/50. So I
> > > am quite happy about that. I think I can declare that the "let list grow
> > > indefinitely" design works quite well even with an insanely heavily loaded
> > > case of every CPU in a 16CPU system with 500M memory, indefinitely doing
> > > kfree_rcu()in a tight loop with appropriate cond_resched(). And I am like
> > > thinking - wow how does this stuff even work at such insane scales :-D
> > 
> > A lot of work by a lot of people over a long period of time.  On their
> > behalf, I thank you for the implied compliment.  So once this patch gets
> > in, perhaps you will have complimented yourself as well.  ;-)
> > 
> > But more work is needed, and will continue to be as new workloads,
> > compiler optimizations, and hardware appears.  And it would be good to
> > try this on a really big system at some point.
> 
> Cool!
> 
> > > > > > o	Along with the above boot parameter, use "rcutree.use_softirq=0"
> > > > > > 	to cause RCU to use kthreads instead of softirq.  (You might well
> > > > > > 	find issues in priority setting as well, but might as well find
> > > > > > 	them now if so!)
> > > > > 
> > > > > Doesn't think one actually reduce the priority of the core RCU work? softirq
> > > > > will always have higher priority than any there. So wouldn't that have the
> > > > > effect of not reclaiming things fast enough? (Or, in my case not scheduling
> > > > > the rcu_work which does the reclaim).
> > > > 
> > > > For low kfree_rcu() loads, yes, it increases overhead due to the need
> > > > for context switches instead of softirq running at the tail end of an
> > > > interrupt.  But for high kfree_rcu() loads, it gets you realtime priority
> > > > (in conjunction with "rcutree.kthread_prio=", that is).
> > > 
> > > I meant for high kfree_rcu() loads, a softirq context executing RCU callback
> > > is still better from the point of view of the callback running because the
> > > softirq will run above all else (higher than the highest priority task) so
> > > use_softirq=0 would be a down grade from that perspective if something higher
> > > than rcutree.kthread_prio is running on the CPU. So unless kthread_prio is
> > > set to the highest prio, then softirq running would work better. Did I miss
> > > something?
> > 
> > Under heavy load, softirq stops running at the tail end of interrupts and
> > is instead run within the context of a per-CPU ksoftirqd kthread.  At normal
> > SCHED_OTHER priority.
> 
> Ah, yes. Agreed!
> 
> > > > > > o	With any of the above, invoke rcu_momentary_dyntick_idle() along
> > > > > > 	with cond_resched() in your kfree_rcu() loop.  This simulates
> > > > > > 	a trip to userspace for nohz_full CPUs, so if this helps for
> > > > > > 	non-nohz_full CPUs, adjustments to the kernel might be called for.
> > > 
> > > I did not try this yet. But I am thinking why would this help in nohz_idle
> > > case? In nohz_idle we already have the tick active when CPU is idle. I guess
> > > it is because there may be a long time that elapses before
> > > rcu_data.rcu_need_heavy_qs == true ?
> > 
> > Under your heavy rcuperf load, none of the CPUs would ever be idle.  Nor
> > would they every be in nohz_full userspace context, either.
> 
> Sorry I made a typo, I meant 'tick active when CPU is non-idle for NOHZ_IDLE
> systems' above.
> 
> > In contrast, a heavy duty userspace-driven workload would transition to
> > and from userspace for each kfree_rcu(), and that would increment the
> > dyntick-idle count on each transition to and from userspace.  Adding the
> > rcu_momentary_dyntick_idle() emulates a pair of such transitions.
> 
> But even if we're in kernel mode and not transitioning, I thought the FQS
> loop (rcu_implicit_dynticks_qs() function) would set need_heavy_qs to true at
> 2 * jiffies_to_sched_qs.
> 
> Hmm, I forgot that jiffies_to_sched_qs can be quite large I guess. You're
> right, we could call rcu_momentary_dyntick_idle() in advance before waiting
> for FQS loop to do the setting of need_heavy_qs.
> 
> Or, am I missing something with the rcu_momentary_dyntick_idle() point you
> made?

The trick is that rcu_momentary_dyntick_idle() directly increments the
CPU's dyntick counter, so that the next FQS loop will note that the CPU
passed through a quiescent state.  No need for need_heavy_qs in this case.

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> 
> > 
> > 							Thanx, Paul
> > 
> > > > > Ok, will try it.
> > > > > 
> > > > > Save these bullet points for future reference! ;-)  thanks,
> > > > 
> > > > I guess this is helping me to prepare for Plumbers.  ;-)
> > > 
> > > :-)
> > > 
> > > thanks, Paul!
> > > 
> > >  - Joel
> > > 
> > 
> 

