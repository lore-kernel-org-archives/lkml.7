Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E584C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC552083B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfFURuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 13:50:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35330 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726017AbfFURut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 13:50:49 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5LHlF5i040290;
        Fri, 21 Jun 2019 13:50:28 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t9245vs7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jun 2019 13:50:27 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x5LHkeKD018149;
        Fri, 21 Jun 2019 17:50:26 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma04dal.us.ibm.com with ESMTP id 2t8hrp5v4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jun 2019 17:50:26 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5LHoQJ714877672
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jun 2019 17:50:26 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14243B2065;
        Fri, 21 Jun 2019 17:50:26 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB212B2067;
        Fri, 21 Jun 2019 17:50:25 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 21 Jun 2019 17:50:25 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 1118F16C1854; Fri, 21 Jun 2019 10:50:27 -0700 (PDT)
Date:   Fri, 21 Jun 2019 10:50:27 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        frederic@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH] time/tick-broadcast: Fix tick_broadcast_offline()
 lockdep complaint
Message-ID: <20190621175027.GA23260@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190619181903.GA14233@linux.ibm.com>
 <20190620121032.GU3436@hirez.programming.kicks-ass.net>
 <20190620160118.GQ26519@linux.ibm.com>
 <20190620211019.GA3436@hirez.programming.kicks-ass.net>
 <20190620221336.GZ26519@linux.ibm.com>
 <20190621105503.GI3436@hirez.programming.kicks-ass.net>
 <20190621121630.GE26519@linux.ibm.com>
 <20190621122927.GV3402@hirez.programming.kicks-ass.net>
 <20190621133414.GF26519@linux.ibm.com>
 <20190621174104.GA7519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621174104.GA7519@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-21_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906210139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 10:41:04AM -0700, Paul E. McKenney wrote:
> On Fri, Jun 21, 2019 at 06:34:14AM -0700, Paul E. McKenney wrote:
> > On Fri, Jun 21, 2019 at 02:29:27PM +0200, Peter Zijlstra wrote:
> > > On Fri, Jun 21, 2019 at 05:16:30AM -0700, Paul E. McKenney wrote:
> > > > A pair of full hangs at boot (TASKS03 and TREE04), no console output
> > > > whatsoever.  Not sure how these changes could cause that, but suspicion
> > > > falls on sched_tick_offload_init().  Though even that is a bit strange
> > > > because if so, why didn't TREE01 and TREE07 also hang?  Again, looking
> > > > into it.
> > > 
> > > Pesky details ;-)
> > 
> > And backing out to the earlier patch removes the hangs, though statistical
> > insignificance and all that.
> 
> And purists might argue that four failures out of four attempts does not
> constitute true statistical significance, but too bad.  If I interpose
> a twork pointer in sched_tick_offload_init()'s initialization, it seems
> to work fine, give or take lack of statistical significance.  This is
> surprising, so I am rerunning with added parentheses in the atomic_set()
> expression.

Huh.  This works, albeit only once:

	int __init sched_tick_offload_init(void)
	{
		struct tick_work *twork;
		int cpu;

		tick_work_cpu = alloc_percpu(struct tick_work);
		BUG_ON(!tick_work_cpu);
		for_each_possible_cpu(cpu) {
			twork = per_cpu_ptr(tick_work_cpu, cpu);
			atomic_set(&twork->state, TICK_SCHED_REMOTE_OFFLINE);
		}

		return 0;
	}

This does not work:

	int __init sched_tick_offload_init(void)
	{
		int cpu;

		tick_work_cpu = alloc_percpu(struct tick_work);
		BUG_ON(!tick_work_cpu);
		for_each_possible_cpu(cpu)
			atomic_set(&(per_cpu(tick_work_cpu, cpu)->state), TICK_SCHED_REMOTE_OFFLINE);

		return 0;
	}

I will run more tests on the one that worked only once.  In the meantime,
feel free to tell me what stupid thing I did with the parentheses.

								Thanx, Paul
