Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0664C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 08:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 980A52087F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 08:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfDTIyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 04:54:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58034 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725910AbfDTIyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 04:54:49 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3K8sHWv049122
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 04:54:48 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ryvabntk7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 04:54:48 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 20 Apr 2019 09:54:47 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 20 Apr 2019 09:54:41 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3K8se7e21168184
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 Apr 2019 08:54:40 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 470D6B2065;
        Sat, 20 Apr 2019 08:54:40 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1205BB2064;
        Sat, 20 Apr 2019 08:54:40 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.173.11])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 20 Apr 2019 08:54:40 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8F88B16C07B7; Sat, 20 Apr 2019 01:54:40 -0700 (PDT)
Date:   Sat, 20 Apr 2019 01:54:40 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Luc Maranget <luc.maranget@inria.fr>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] Documentation: atomic_t.txt: Explain ordering provided
 by smp_mb__{before,after}_atomic()
Reply-To: paulmck@linux.ibm.com
References: <Pine.LNX.4.44L0.1904191312200.1406-100000@iolanthe.rowland.org>
 <20190419180017.GP4038@hirez.programming.kicks-ass.net>
 <20190419182620.GF14111@linux.ibm.com>
 <1555719429.t9n8gkf70y.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555719429.t9n8gkf70y.astroid@bobo.none>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19042008-0068-0000-0000-000003B7C171
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010960; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01191720; UDB=6.00624584; IPR=6.00972522;
 MB=3.00026523; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-20 08:54:45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042008-0069-0000-0000-0000483A4EB9
Message-Id: <20190420085440.GK14111@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-20_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904200068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 10:26:15AM +1000, Nicholas Piggin wrote:
> Paul E. McKenney's on April 20, 2019 4:26 am:
> > On Fri, Apr 19, 2019 at 08:00:17PM +0200, Peter Zijlstra wrote:
> >> On Fri, Apr 19, 2019 at 01:21:45PM -0400, Alan Stern wrote:
> >> > Index: usb-devel/Documentation/atomic_t.txt
> >> > ===================================================================
> >> > --- usb-devel.orig/Documentation/atomic_t.txt
> >> > +++ usb-devel/Documentation/atomic_t.txt
> >> > @@ -171,7 +171,10 @@ The barriers:
> >> >    smp_mb__{before,after}_atomic()
> >> >  
> >> >  only apply to the RMW ops and can be used to augment/upgrade the ordering
> >> > -inherent to the used atomic op. These barriers provide a full smp_mb().
> >> > +inherent to the used atomic op. Unlike normal smp_mb() barriers, they order
> >> > +only the RMW op itself against the instructions preceding the
> >> > +smp_mb__before_atomic() or following the smp_mb__after_atomic(); they do
> >> > +not order instructions on the other side of the RMW op at all.
> >> 
> >> Now it is I who is confused; what?
> >> 
> >> 	x = 1;
> >> 	smp_mb__before_atomic();
> >> 	atomic_add(1, &a);
> >> 	y = 1;
> >> 
> >> the stores to both x and y will be ordered as if an smp_mb() where
> >> there. There is no order between a and y otoh.
> > 
> > Let's look at x86.  And a slightly different example:
> > 
> > 	x = 1;
> > 	smp_mb__before_atomic();
> > 	atomic_add(1, &a);
> > 	r1 = y;
> > 
> > The atomic_add() asm does not have the "memory" constraint, which is
> > completely legitimate because atomic_add() does not return a value,
> > and thus guarantees no ordering.  The compiler is therefore within
> > its rights to transform the code into the following:
> > 
> > 	x = 1;
> > 	smp_mb__before_atomic();
> > 	r1 = y;
> > 	atomic_add(1, &a);
> > 
> > But x86's smp_mb__before_atomic() is just a compiler barrier, and
> > x86 is further allowed to reorder prior stores with later loads.
> > The CPU can therefore execute this code as follows:
> > 
> > 	r1 = y;
> > 	x = 1;
> > 	smp_mb__before_atomic();
> > 	atomic_add(1, &a);
> > 
> > So in general, the ordering is guaranteed only to the atomic itself,
> > not to accesses on the other side of the atomic.
> 
> That's interesting. I don't think that's what all our code expects.
> I had the same idea as Peter.
> 
> IIRC the primitive was originally introduced exactly so x86 would not
> need to have the unnecessary hardware barrier with sequences like
> 
>   smp_mb();
>   ...
>   atomic_inc(&v);
> 
> The "new" semantics are a bit subtle. One option might be just to
> replace it entirely with atomic_xxx_mb() ?

Hmmm...  There are more than 2,000 uses of atomic_inc() in the kernel.
There are about 300-400 total between smp_mb__before_atomic() and
smp_mb__after_atomic().

So what are our options?

1.	atomic_xxx_mb() as you say.

	From a quick scan of smp_mb__before_atomic() uses, we need this
	for atomic_inc(), atomic_dec(), atomic_add(), atomic_sub(),
	clear_bit(), set_bit(), test_bit(), atomic_long_dec(),
	atomic_long_add(), refcount_dec(), cmpxchg_relaxed(),
	set_tsk_thread_flag(), clear_bit_unlock().

	Another random look identifies atomic_andnot().

	And atomic_set(): set_preempt_state().	This fails
	on x86, s390, and TSO friends, does it not?  Or is
	this ARM-only?	Still, why not just smp_mb() before and
	after?	Same issue in __kernfs_new_node(), bio_cnt_set(),
	sbitmap_queue_update_wake_batch(), 

	Ditto for atomic64_set() in __ceph_dir_set_complete().

	Ditto for atomic_read() in rvt_qp_is_avail().  This function
	has a couple of other oddly placed smp_mb__before_atomic().

	And atomic_cmpxchg(): msc_buffer_alloc().  This instance
	of smp_mb__before_atomic() can be removed unless I am missing
	something subtle.  Ditto for kvm_vcpu_exiting_guest_mode(),
	pv_kick_node(), __sbq_wake_up(), 

	And lock acquisition??? acm_read_bulk_callback().

	In nfnl_acct_fill_info(), a smp_mb__before_atomic() after
	a atomic64_xchg()???  Also before a clear_bit(), but the
	clear_bit() is inside an "if".

	There are a few cases that would see added overhead.  For example,
	svc_get_next_xprt() has the following:

		smp_mb__before_atomic();
		clear_bit(SP_CONGESTED, &pool->sp_flags);
		clear_bit(RQ_BUSY, &rqstp->rq_flags);
		smp_mb__after_atomic();

	And xs_sock_reset_connection_flags() has this:

		smp_mb__before_atomic();
		clear_bit(XPRT_CLOSE_WAIT, &xprt->state);
		clear_bit(XPRT_CLOSING, &xprt->state);
		xs_sock_reset_state_flags(xprt);  /* Also a clear_bit(). */
		smp_mb__after_atomic();

	Yeah, there are more than a few misuses, aren't there?  :-/
	A coccinelle script seems in order.  In 0day test robot.

	But there are a number of helper functions whose purpose
	seems to be to wrap an atomic in smp_mb__before_atomic() and
	smp_mb__after_atomic(), so some of the atomic_xxx_mb() functions
	might be a good idea just for improved readability.

2.	Add something to checkpatch.pl warning about non-total ordering,
	with the error message explaining that the ordering is partial.

3.	Make non-value-returning atomics provide full ordering.
	This would of course need some benchmarking, but would be a
	simple change to make and would eliminate a large class of
	potential bugs.  My guess is that the loss in performance
	would be non-negligible, but who knows?

4.	Your idea here!

							Thanx, Paul

