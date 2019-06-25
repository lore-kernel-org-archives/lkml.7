Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A2FC4646B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 02:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA5E205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 02:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbfFYCFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 22:05:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39752 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729601AbfFYCFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 22:05:46 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5P23buQ111765;
        Mon, 24 Jun 2019 22:05:08 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tbadf86ad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 22:05:08 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x5P24pEh004714;
        Tue, 25 Jun 2019 02:05:07 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01dal.us.ibm.com with ESMTP id 2t9by6vkc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jun 2019 02:05:07 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5P256HA11993670
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 02:05:06 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB304B2064;
        Tue, 25 Jun 2019 02:05:06 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8AA16B205F;
        Tue, 25 Jun 2019 02:05:06 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.154.244])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 25 Jun 2019 02:05:06 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 4B2C016C2F90; Mon, 24 Jun 2019 19:05:06 -0700 (PDT)
Date:   Mon, 24 Jun 2019 19:05:06 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de
Subject: Re: [PATCH] time/tick-broadcast: Fix tick_broadcast_offline()
 lockdep complaint
Message-ID: <20190625020506.GQ26519@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190621105503.GI3436@hirez.programming.kicks-ass.net>
 <20190621121630.GE26519@linux.ibm.com>
 <20190621122927.GV3402@hirez.programming.kicks-ass.net>
 <20190621133414.GF26519@linux.ibm.com>
 <20190621174104.GA7519@linux.ibm.com>
 <20190621175027.GA23260@linux.ibm.com>
 <20190621234602.GA16286@linux.ibm.com>
 <20190624231222.GA17497@lerouge>
 <20190624234422.GP26519@linux.ibm.com>
 <20190625004300.GB17497@lerouge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625004300.GB17497@lerouge>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-25_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906250014
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 02:43:00AM +0200, Frederic Weisbecker wrote:
> On Mon, Jun 24, 2019 at 04:44:22PM -0700, Paul E. McKenney wrote:
> > On Tue, Jun 25, 2019 at 01:12:23AM +0200, Frederic Weisbecker wrote:
> > > On Fri, Jun 21, 2019 at 04:46:02PM -0700, Paul E. McKenney wrote:
> > > > @@ -3097,13 +3126,21 @@ static void sched_tick_remote(struct work_struct *work)
> > > >  	/*
> > > >  	 * Run the remote tick once per second (1Hz). This arbitrary
> > > >  	 * frequency is large enough to avoid overload but short enough
> > > > -	 * to keep scheduler internal stats reasonably up to date.
> > > > +	 * to keep scheduler internal stats reasonably up to date.  But
> > > > +	 * first update state to reflect hotplug activity if required.
> > > >  	 */
> > > > +	os = atomic_read(&twork->state);
> > > > +	if (os) {
> > > > +		WARN_ON_ONCE(os != TICK_SCHED_REMOTE_OFFLINING);
> > > > +		if (atomic_inc_not_zero(&twork->state))
> > > > +			return;
> > > 
> > > Using inc makes me a bit nervous here. If we do so, we should somewhow
> > > make sure that we never exceed a value higher than TICK_SCHED_REMOTE_OFFLINE
> > > by accident.
> > > 
> > > atomic_xchg() is probably a bit costlier but also safer as it allows
> > > us to check both the old and the new value. That path shouldn't be critically fast
> > > after all.
> > 
> > It would need to be cmpxchg() to avoid messing with the state if
> > the state were somehow TICK_SCHED_REMOTE_RUNNING, right?
> 
> Ah indeed! Nevermind, let's keep things as they are then.
> 
> > > > +	}
> > > >  	queue_delayed_work(system_unbound_wq, dwork, HZ);
> > > >  }
> > > >  
> > > >  static void sched_tick_start(int cpu)
> > > >  {
> > > > +	int os;
> > > >  	struct tick_work *twork;
> > > >  
> > > >  	if (housekeeping_cpu(cpu, HK_FLAG_TICK))
> > > > @@ -3112,15 +3149,20 @@ static void sched_tick_start(int cpu)
> > > >  	WARN_ON_ONCE(!tick_work_cpu);
> > > >  
> > > >  	twork = per_cpu_ptr(tick_work_cpu, cpu);
> > > > -	twork->cpu = cpu;
> > > > -	INIT_DELAYED_WORK(&twork->work, sched_tick_remote);
> > > > -	queue_delayed_work(system_unbound_wq, &twork->work, HZ);
> > > > +	os = atomic_xchg(&twork->state, TICK_SCHED_REMOTE_RUNNING);
> > > > +	WARN_ON_ONCE(os == TICK_SCHED_REMOTE_RUNNING);
> > > 
> > > See if we use atomic_inc(), we would need to also WARN(os > TICK_SCHED_REMOTE_OFFLINE).
> > 
> > How about if I put that WARN() between the atomic_inc_not_zero() and
> > the return, presumably also adding braces?
> 
> Yeah, unfortunately there is no atomic_add_not_zero_return().
> I guess we can live with a check using atomic_read(). In the best
> case it returns the fresh increment, otherwise it should be REMOTE_RUNNING.
> 
> In any case the (os > TICK_SCHED_REMOTE_OFFLINE) check applies.

True, so with high probability a warning would be emitted.  Fair enough?

							Thanx, Paul
