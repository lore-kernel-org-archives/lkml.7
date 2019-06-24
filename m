Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF600C4646B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 23:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C65F720663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 23:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbfFXXo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 19:44:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12492 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728499AbfFXXo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 19:44:26 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5ONhMe8127404
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 19:44:24 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tb5ysnn46-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 19:44:24 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 25 Jun 2019 00:44:23 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 25 Jun 2019 00:44:20 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5ONiJ1F41746830
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 23:44:19 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15AFEB2064;
        Mon, 24 Jun 2019 23:44:19 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ECF2CB205F;
        Mon, 24 Jun 2019 23:44:18 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 24 Jun 2019 23:44:18 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 73EFB16C5D9C; Mon, 24 Jun 2019 16:44:22 -0700 (PDT)
Date:   Mon, 24 Jun 2019 16:44:22 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de
Subject: Re: [PATCH] time/tick-broadcast: Fix tick_broadcast_offline()
 lockdep complaint
Reply-To: paulmck@linux.ibm.com
References: <20190620211019.GA3436@hirez.programming.kicks-ass.net>
 <20190620221336.GZ26519@linux.ibm.com>
 <20190621105503.GI3436@hirez.programming.kicks-ass.net>
 <20190621121630.GE26519@linux.ibm.com>
 <20190621122927.GV3402@hirez.programming.kicks-ass.net>
 <20190621133414.GF26519@linux.ibm.com>
 <20190621174104.GA7519@linux.ibm.com>
 <20190621175027.GA23260@linux.ibm.com>
 <20190621234602.GA16286@linux.ibm.com>
 <20190624231222.GA17497@lerouge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624231222.GA17497@lerouge>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19062423-0072-0000-0000-0000044068DF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011323; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01222816; UDB=6.00643456; IPR=6.01003976;
 MB=3.00027451; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-24 23:44:22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062423-0073-0000-0000-00004CB089EF
Message-Id: <20190624234422.GP26519@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-24_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906240187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 01:12:23AM +0200, Frederic Weisbecker wrote:
> On Fri, Jun 21, 2019 at 04:46:02PM -0700, Paul E. McKenney wrote:
> > @@ -3097,13 +3126,21 @@ static void sched_tick_remote(struct work_struct *work)
> >  	/*
> >  	 * Run the remote tick once per second (1Hz). This arbitrary
> >  	 * frequency is large enough to avoid overload but short enough
> > -	 * to keep scheduler internal stats reasonably up to date.
> > +	 * to keep scheduler internal stats reasonably up to date.  But
> > +	 * first update state to reflect hotplug activity if required.
> >  	 */
> > +	os = atomic_read(&twork->state);
> > +	if (os) {
> > +		WARN_ON_ONCE(os != TICK_SCHED_REMOTE_OFFLINING);
> > +		if (atomic_inc_not_zero(&twork->state))
> > +			return;
> 
> Using inc makes me a bit nervous here. If we do so, we should somewhow
> make sure that we never exceed a value higher than TICK_SCHED_REMOTE_OFFLINE
> by accident.
> 
> atomic_xchg() is probably a bit costlier but also safer as it allows
> us to check both the old and the new value. That path shouldn't be critically fast
> after all.

It would need to be cmpxchg() to avoid messing with the state if
the state were somehow TICK_SCHED_REMOTE_RUNNING, right?

> > +	}
> >  	queue_delayed_work(system_unbound_wq, dwork, HZ);
> >  }
> >  
> >  static void sched_tick_start(int cpu)
> >  {
> > +	int os;
> >  	struct tick_work *twork;
> >  
> >  	if (housekeeping_cpu(cpu, HK_FLAG_TICK))
> > @@ -3112,15 +3149,20 @@ static void sched_tick_start(int cpu)
> >  	WARN_ON_ONCE(!tick_work_cpu);
> >  
> >  	twork = per_cpu_ptr(tick_work_cpu, cpu);
> > -	twork->cpu = cpu;
> > -	INIT_DELAYED_WORK(&twork->work, sched_tick_remote);
> > -	queue_delayed_work(system_unbound_wq, &twork->work, HZ);
> > +	os = atomic_xchg(&twork->state, TICK_SCHED_REMOTE_RUNNING);
> > +	WARN_ON_ONCE(os == TICK_SCHED_REMOTE_RUNNING);
> 
> See if we use atomic_inc(), we would need to also WARN(os > TICK_SCHED_REMOTE_OFFLINE).

How about if I put that WARN() between the atomic_inc_not_zero() and
the return, presumably also adding braces?

							Thanx, Paul

> > +	if (os == TICK_SCHED_REMOTE_OFFLINE) {
> > +		twork->cpu = cpu;
> > +		INIT_DELAYED_WORK(&twork->work, sched_tick_remote);
> > +		queue_delayed_work(system_unbound_wq, &twork->work, HZ);
> > +	}
> >  }
> 
> Thanks.
> 

