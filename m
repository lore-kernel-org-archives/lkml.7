Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2F3C31E40
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 00:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A685D214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 00:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfHGAft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 20:35:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2580 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726419AbfHGAfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 20:35:48 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x770VxAX064711;
        Tue, 6 Aug 2019 20:35:03 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u7hf851he-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Aug 2019 20:35:03 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x770W0Gl064841;
        Tue, 6 Aug 2019 20:35:02 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u7hf851h0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Aug 2019 20:35:02 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x770UJoq032480;
        Wed, 7 Aug 2019 00:35:01 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma02wdc.us.ibm.com with ESMTP id 2u51w633kc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Aug 2019 00:35:01 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x770Z1HA31654150
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Aug 2019 00:35:01 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D48EB205F;
        Wed,  7 Aug 2019 00:35:01 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E38A6B2064;
        Wed,  7 Aug 2019 00:35:00 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  7 Aug 2019 00:35:00 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id EBEE716C35DB; Tue,  6 Aug 2019 17:35:01 -0700 (PDT)
Date:   Tue, 6 Aug 2019 17:35:01 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com
Subject: Re: [PATCH RFC tip/core/rcu 02/14] rcu/nocb: Add bypass callback
 queueing
Message-ID: <20190807003501.GX28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190802151435.GA1081@linux.ibm.com>
 <20190802151501.13069-2-paulmck@linux.ibm.com>
 <20190807000313.GA161170@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807000313.GA161170@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-06_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908070002
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 08:03:13PM -0400, Joel Fernandes wrote:
> On Fri, Aug 02, 2019 at 08:14:49AM -0700, Paul E. McKenney wrote:
> > Use of the rcu_data structure's segmented ->cblist for no-CBs CPUs
> > takes advantage of unrelated grace periods, thus reducing the memory
> > footprint in the face of floods of call_rcu() invocations.  However,
> > the ->cblist field is a more-complex rcu_segcblist structure which must
> > be protected via locking.  Even though there are only three entities
> > which can acquire this lock (the CPU invoking call_rcu(), the no-CBs
> > grace-period kthread, and the no-CBs callbacks kthread), the contention
> > on this lock is excessive under heavy stress.
> > 
> > This commit therefore greatly reduces contention by provisioning
> > an rcu_cblist structure field named ->nocb_bypass within the
> > rcu_data structure.  Each no-CBs CPU is permitted only a limited
> > number of enqueues onto the ->cblist per jiffy, controlled by a new
> > nocb_nobypass_lim_per_jiffy kernel boot parameter that defaults to
> > about 16 enqueues per millisecond (16 * 1000 / HZ).  When that limit is
> > exceeded, the CPU instead enqueues onto the new ->nocb_bypass.
> 
> Looks quite interesting. I am guessing the not-no-CB (regular) enqueues don't
> need to use the same technique because both enqueues / callback execution are
> happening on same CPU..

That is the theory!  ;-)

> Still looking through patch but I understood the basic idea. Some nits below:
> 
> [snip]
> > diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> > index 2c3e9068671c..e4df86db8137 100644
> > --- a/kernel/rcu/tree.h
> > +++ b/kernel/rcu/tree.h
> > @@ -200,18 +200,26 @@ struct rcu_data {
> >  	atomic_t nocb_lock_contended;	/* Contention experienced. */
> >  	int nocb_defer_wakeup;		/* Defer wakeup of nocb_kthread. */
> >  	struct timer_list nocb_timer;	/* Enforce finite deferral. */
> > +	unsigned long nocb_gp_adv_time;	/* Last call_rcu() CB adv (jiffies). */
> > +
> > +	/* The following fields are used by call_rcu, hence own cacheline. */
> > +	raw_spinlock_t nocb_bypass_lock ____cacheline_internodealigned_in_smp;
> > +	struct rcu_cblist nocb_bypass;	/* Lock-contention-bypass CB list. */
> > +	unsigned long nocb_bypass_first; /* Time (jiffies) of first enqueue. */
> > +	unsigned long nocb_nobypass_last; /* Last ->cblist enqueue (jiffies). */
> > +	int nocb_nobypass_count;	/* # ->cblist enqueues at ^^^ time. */
> 
> Can these and below fields be ifdef'd out if !CONFIG_RCU_NOCB_CPU so as to
> keep the size of struct smaller for benefit of systems that don't use NOCB?

Please see below...

> >  	/* The following fields are used by GP kthread, hence own cacheline. */
> >  	raw_spinlock_t nocb_gp_lock ____cacheline_internodealigned_in_smp;
> > -	bool nocb_gp_sleep;
> > -					/* Is the nocb GP thread asleep? */
> > +	struct timer_list nocb_bypass_timer; /* Force nocb_bypass flush. */
> > +	bool nocb_gp_sleep;		/* Is the nocb GP thread asleep? */
> 
> And these too, I think.
> 
> 
> >  	struct swait_queue_head nocb_gp_wq; /* For nocb kthreads to sleep on. */
> >  	bool nocb_cb_sleep;		/* Is the nocb CB thread asleep? */
> >  	struct task_struct *nocb_cb_kthread;
> >  	struct rcu_data *nocb_next_cb_rdp;
> >  					/* Next rcu_data in wakeup chain. */
> >  
> > -	/* The following fields are used by CB kthread, hence new cachline. */
> > +	/* The following fields are used by CB kthread, hence new cacheline. */
> >  	struct rcu_data *nocb_gp_rdp ____cacheline_internodealigned_in_smp;
> >  					/* GP rdp takes GP-end wakeups. */
> >  #endif /* #ifdef CONFIG_RCU_NOCB_CPU */

I believe that they in fact are all under CONFIG_RCU_NOCB_CPU.

> [snip]
> > +static void rcu_nocb_try_flush_bypass(struct rcu_data *rdp, unsigned long j)
> > +{
> > +	rcu_lockdep_assert_cblist_protected(rdp);
> > +	if (!rcu_segcblist_is_offloaded(&rdp->cblist) ||
> > +	    !rcu_nocb_bypass_trylock(rdp))
> > +		return;
> > +	WARN_ON_ONCE(!rcu_nocb_do_flush_bypass(rdp, NULL, j));
> > +}
> > +
> > +/*
> > + * See whether it is appropriate to use the ->nocb_bypass list in order
> > + * to control contention on ->nocb_lock.  A limited number of direct
> > + * enqueues are permitted into ->cblist per jiffy.  If ->nocb_bypass
> > + * is non-empty, further callbacks must be placed into ->nocb_bypass,
> > + * otherwise rcu_barrier() breaks.  Use rcu_nocb_flush_bypass() to switch
> > + * back to direct use of ->cblist.  However, ->nocb_bypass should not be
> > + * used if ->cblist is empty, because otherwise callbacks can be stranded
> > + * on ->nocb_bypass because we cannot count on the current CPU ever again
> > + * invoking call_rcu().  The general rule is that if ->nocb_bypass is
> > + * non-empty, the corresponding no-CBs grace-period kthread must not be
> > + * in an indefinite sleep state.
> > + *
> > + * Finally, it is not permitted to use the bypass during early boot,
> > + * as doing so would confuse the auto-initialization code.  Besides
> > + * which, there is no point in worrying about lock contention while
> > + * there is only one CPU in operation.
> > + */
> > +static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> > +				bool *was_alldone, unsigned long flags)
> > +{
> > +	unsigned long c;
> > +	unsigned long cur_gp_seq;
> > +	unsigned long j = jiffies;
> > +	long ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
> > +
> > +	if (!rcu_segcblist_is_offloaded(&rdp->cblist)) {
> > +		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
> > +		return false; /* Not offloaded, no bypassing. */
> > +	}
> > +	lockdep_assert_irqs_disabled();
> > +
> > +	// Don't use ->nocb_bypass during early boot.
> 
> Very minor nit: comment style should be /* */

I thought that Linus said that "//" was now OK.  Am I confused?

							Thanx, Paul
