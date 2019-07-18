Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC23C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 12:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF909217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 12:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390145AbfGRMMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 08:12:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54830 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726715AbfGRMMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 08:12:19 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6IC2gvA087001;
        Thu, 18 Jul 2019 08:12:07 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ttqje2m6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jul 2019 08:12:07 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x6IC2ri4088019;
        Thu, 18 Jul 2019 08:12:06 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ttqje2m5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jul 2019 08:12:06 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x6IC5tm0030585;
        Thu, 18 Jul 2019 12:12:05 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma01dal.us.ibm.com with ESMTP id 2tq6x7787m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jul 2019 12:12:05 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6ICC5HV42140018
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jul 2019 12:12:05 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22A9FB2066;
        Thu, 18 Jul 2019 12:12:05 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C7E4B205F;
        Thu, 18 Jul 2019 12:12:04 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.169.29])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 18 Jul 2019 12:12:04 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id EF89116C0DA2; Thu, 18 Jul 2019 05:12:03 -0700 (PDT)
Date:   Thu, 18 Jul 2019 05:12:03 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Jan Stancek <jstancek@redhat.com>
Cc:     Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
        linux-kernel@vger.kernel.org, dbueso@suse.de, peterz@infradead.org,
        mingo@redhat.com, jade alglave <jade.alglave@arm.com>
Subject: Re: [PATCH v2] locking/rwsem: add acquire barrier to read_slowpath
 exit when queue is empty
Message-ID: <20190718121203.GL14271@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190716185807.GJ3402@hirez.programming.kicks-ass.net>
 <a524cf95ab0dbdd1eb65e9decb9283e73d416b1d.1563352912.git.jstancek@redhat.com>
 <20190717131335.b2ry43t2ov7ba4t4@willie-the-truck>
 <21ff5905-198b-6ea5-6c2a-9fb10cb48ea7@redhat.com>
 <20190717192200.GA17687@dustball.usersys.redhat.com>
 <20190718092640.52oliw3sid7gxyh6@willie-the-truck>
 <79224323.853324.1563447052432.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79224323.853324.1563447052432.JavaMail.zimbra@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-18_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907180129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 06:50:52AM -0400, Jan Stancek wrote:
> 
> ----- Original Message -----
> > Hi Jan, Waiman, [+Jade and Paul for the litmus test at the end]
> > 
> > On Wed, Jul 17, 2019 at 09:22:00PM +0200, Jan Stancek wrote:
> > > On Wed, Jul 17, 2019 at 10:19:04AM -0400, Waiman Long wrote:
> > > > > If you add a comment to the code outlining the issue (preferably as a
> > > > > litmus
> > > > > test involving sem->count and some shared data which happens to be
> > > > > vmacache_seqnum in your test)), then:
> > > > > 
> > > > > Reviewed-by: Will Deacon <will@kernel.org>
> > > > > 
> > > > > Thanks,
> > > > > 
> > > > > Will
> > > > 
> > > > Agreed. A comment just above smp_acquire__after_ctrl_dep() on why this
> > > > is needed will be great.
> > > > 
> > > > Other than that,
> > > > 
> > > > Acked-by: Waiman Long <longman@redhat.com>
> > > > 
> > > 
> > > litmus test looks a bit long, would following be acceptable?
> > > 
> > > diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> > > index 37524a47f002..d9c96651bfc7 100644
> > > --- a/kernel/locking/rwsem.c
> > > +++ b/kernel/locking/rwsem.c
> > > @@ -1032,6 +1032,13 @@ static inline bool rwsem_reader_phase_trylock(struct
> > > rw_semaphore *sem,
> > >  		 */
> > >  		if (adjustment && !(atomic_long_read(&sem->count) &
> > >  		     (RWSEM_WRITER_MASK | RWSEM_FLAG_HANDOFF))) {
> > > +			/*
> > > +			 * down_read() issued ACQUIRE on enter, but we can race
> > > +			 * with writer who did RELEASE only after us.
> > > +			 * ACQUIRE here makes sure reader operations happen only
> > > +			 * after all writer ones.
> > > +			 */
> > 
> > How about an abridged form of the litmus test here, just to show the cod
> > flow? e.g.:
> > 
> > /*
> >  * We need to ensure ACQUIRE semantics when reading sem->count so that
> >  * we pair with the RELEASE store performed by an unlocking/downgrading
> >  * writer.
> >  *
> >  * P0 (writer)			P1 (reader)
> >  *
> >  * down_write(sem);
> >  * <write shared data>
> >  * downgrade_write(sem);
> >  * -> fetch_add_release(&sem->count)
> >  *
> >  *				down_read_slowpath(sem);
> >  *				-> atomic_read(&sem->count)
> >  *				   <ctrl dep>
> >  *				   smp_acquire__after_ctrl_dep()
> >  *				<read shared data>
> >  */
> 
> Works for me. The code is at 3 level of indentation, but I can try
> to squeeze it in for v4.
> 
> > 
> > In writing this, I also noticed that we don't have any explicit ordering
> > at the end of the reader slowpath when we wait on the queue but get woken
> > immediately:
> > 
> > 	if (!waiter.task)
> > 		break;
> > 
> > Am I missing something?
> 
> I'm assuming this isn't problem, because set_current_state() on line above
> is using smp_store_mb().
> 
> > 
> > > +			smp_acquire__after_ctrl_dep();
> > >  			raw_spin_unlock_irq(&sem->wait_lock);
> > >  			rwsem_set_reader_owned(sem);
> > >  			lockevent_inc(rwsem_rlock_fast);
> > > 
> > > 
> > > with litmus test in commit log:
> > > ----------------------------------- 8< ------------------------------------
> > > C rwsem
> > > 
> > > {
> > > 	atomic_t rwsem_count = ATOMIC_INIT(1);
> > > 	int vmacache_seqnum = 10;
> > > }
> > > 
> > > P0(int *vmacache_seqnum, atomic_t *rwsem_count)
> > > {
> > > 	r0 = READ_ONCE(*vmacache_seqnum);
> > > 	WRITE_ONCE(*vmacache_seqnum, r0 + 1);
> > > 	/* downgrade_write */
> > > 	r1 = atomic_fetch_add_release(-1+256, rwsem_count);
> > > }
> > > 
> > > P1(int *vmacache_seqnum, atomic_t *rwsem_count, spinlock_t *sem_wait_lock)
> > > {
> > > 	/* rwsem_read_trylock */
> > > 	r0 = atomic_add_return_acquire(256, rwsem_count);
> > > 	/* rwsem_down_read_slowpath */
> > > 	spin_lock(sem_wait_lock);
> > > 	r0 = atomic_read(rwsem_count);
> > > 	if ((r0 & 1) == 0) {
> > > 		// BUG: needs barrier
> > > 		spin_unlock(sem_wait_lock);
> > > 		r1 = READ_ONCE(*vmacache_seqnum);
> > > 	}
> > > }
> > > exists (1:r1=10)
> > > ----------------------------------- 8< ------------------------------------
> > 
> > Thanks for writing this! It's definitely worth sticking it in the commit
> > log, but Paul and Jade might also like to include it as part of their litmus
> > test repository too.

Thank you for forwarding this!  It may now be found at:

https://github.com/paulmckrcu/litmus/blob/master/manual/kernel/C-JanStancek-rwsem.litmus

							Thanx, Paul
