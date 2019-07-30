Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10990C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92BA20693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731289AbfG3Rgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:36:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5012 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726713AbfG3Rgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:36:50 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6UHYNuL081993;
        Tue, 30 Jul 2019 13:36:39 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u2tdp02mt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jul 2019 13:36:39 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x6UHYWiI082521;
        Tue, 30 Jul 2019 13:36:39 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u2tdp02kx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jul 2019 13:36:39 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x6UHZGJ6024261;
        Tue, 30 Jul 2019 17:36:37 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma05wdc.us.ibm.com with ESMTP id 2u0e85tn6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jul 2019 17:36:37 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6UHabZg9699906
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 17:36:37 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 684FBB2066;
        Tue, 30 Jul 2019 17:36:37 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33B22B205F;
        Tue, 30 Jul 2019 17:36:37 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.181.16])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 30 Jul 2019 17:36:37 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E4CCF16C244D; Tue, 30 Jul 2019 10:36:37 -0700 (PDT)
Date:   Tue, 30 Jul 2019 10:36:37 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        peterz@infradead.org
Subject: Re: How to turn scheduler tick on for current nohz_full CPU?
Message-ID: <20190730173637.GG14271@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190724115331.GA29059@linux.ibm.com>
 <20190724132257.GA1029@lenoir>
 <20190724135219.GY14271@linux.ibm.com>
 <20190724143012.GB1029@lenoir>
 <20190725011243.GZ14271@linux.ibm.com>
 <20190729223238.GF14271@linux.ibm.com>
 <20190730164309.GA962@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730164309.GA962@lenoir>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907300184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 06:43:10PM +0200, Frederic Weisbecker wrote:
> On Mon, Jul 29, 2019 at 03:32:38PM -0700, Paul E. McKenney wrote:
> > On Wed, Jul 24, 2019 at 06:12:43PM -0700, Paul E. McKenney wrote:
> > 
> > The patch below (which includes your patch) does help considerably.
> > However, it does have some shortcomings:
> > 
> > 1.	Adds an atomic operation (albeit a cache-local one) to
> > 	the scheduler fastpath.  One approach would be to have
> > 	a way of testing this bit and clearing it only if set.
> > 
> > 	Another approach would be to instead clear it on the
> > 	transition to nohz_full userspace or to idle.
> 
> Well, the latter would be costly as it is going to restart the tick on every
> user -> kernel transitions.

You lost me on this one.  I would be turning off RCU's request to
maintain the tick on transition to nohz_full userspace or to idle.
Why would the tick get turned on by a later user->kernel transition?

> > 2.	There are a lot of other places in the kernel that are in
> > 	need of this bit being set.  I am therefore considering making
> > 	multi_cpu_stop() or its callers set this bit on all CPUs upon
> > 	entry and clear it upon exit.  While in this state, it is
> > 	likely necessary to disable clearing this bit.  Or it would
> > 	be necessary to make multi_cpu_stop() repeat clearing the bit
> > 	every so often.
> > 
> > 	As it stands, I have CPU hotplug removal operations taking
> > 	more than 400 seconds.
> > 
> > 3.	It was tempting to ask for this bit to be tracked on a per-task
> > 	basis, but from what I can see that adds at least as much
> > 	complexity as it removes.
> 
> Yeah I forgot to answer, you can use tick_dep_set_task() for that.

Ah, good, that would remove my need to clear things on the scheduler
fastpaths.  My guess is that I use both the per-CPU and the per-task
variant in different places, but testing will tell!  ;-)

Thank you!

							Thanx, Paul

> > Thoughts?
> > 
> > 							Thanx, Paul
> > 
> > PS.  Outage on @linux.ibm.com, hence the CC of my gmail address.
> > 
> > ------------------------------------------------------------------------
> > 
> > diff --git a/include/linux/tick.h b/include/linux/tick.h
> > index 196a0a7bfc4f..0dea6fb33a11 100644
> > --- a/include/linux/tick.h
> > +++ b/include/linux/tick.h
> > @@ -108,7 +108,8 @@ enum tick_dep_bits {
> >  	TICK_DEP_BIT_POSIX_TIMER	= 0,
> >  	TICK_DEP_BIT_PERF_EVENTS	= 1,
> >  	TICK_DEP_BIT_SCHED		= 2,
> > -	TICK_DEP_BIT_CLOCK_UNSTABLE	= 3
> > +	TICK_DEP_BIT_CLOCK_UNSTABLE	= 3,
> > +	TICK_DEP_BIT_RCU		= 4
> >  };
> >  
> >  #define TICK_DEP_MASK_NONE		0
> > @@ -116,6 +117,7 @@ enum tick_dep_bits {
> >  #define TICK_DEP_MASK_PERF_EVENTS	(1 << TICK_DEP_BIT_PERF_EVENTS)
> >  #define TICK_DEP_MASK_SCHED		(1 << TICK_DEP_BIT_SCHED)
> >  #define TICK_DEP_MASK_CLOCK_UNSTABLE	(1 << TICK_DEP_BIT_CLOCK_UNSTABLE)
> > +#define TICK_DEP_MASK_RCU		(1 << TICK_DEP_BIT_RCU)
> >  
> >  #ifdef CONFIG_NO_HZ_COMMON
> >  extern bool tick_nohz_enabled;
> > @@ -258,6 +260,9 @@ static inline bool tick_nohz_full_enabled(void) { return false; }
> >  static inline bool tick_nohz_full_cpu(int cpu) { return false; }
> >  static inline void tick_nohz_full_add_cpus_to(struct cpumask *mask) { }
> >  
> > +static inline void tick_nohz_dep_set_cpu(int cpu, enum tick_dep_bits bit) { }
> > +static inline void tick_nohz_dep_clear_cpu(int cpu, enum tick_dep_bits bit) { }
> 
> And I gave you the wrong APIs. Please consider_using tick_dep_set_cpu()
> and tick_dep_clear_cpu() that first check if the CPU uses nohz_full.
> 
> Those should have the !CONFIG_NO_HZ_FULL stub implemented as well.
> 
> Thanks.
> 
