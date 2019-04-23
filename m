Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEE4C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286A92077C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbfDWNaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:30:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59140 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727666AbfDWNaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:30:20 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3NDTb5Q066966
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 09:30:19 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s23501n66-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 09:30:19 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 23 Apr 2019 14:30:17 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 23 Apr 2019 14:30:12 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3NDUBvo36110492
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Apr 2019 13:30:11 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46C2BB205F;
        Tue, 23 Apr 2019 13:30:11 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 040BAB2066;
        Tue, 23 Apr 2019 13:30:10 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.109])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 23 Apr 2019 13:30:10 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 98A0C16C062B; Tue, 23 Apr 2019 06:30:10 -0700 (PDT)
Date:   Tue, 23 Apr 2019 06:30:10 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
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
 <20190420085440.GK14111@linux.ibm.com>
 <20190423123209.GR4038@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423123209.GR4038@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19042313-0040-0000-0000-000004E482AC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010981; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01193234; UDB=6.00625504; IPR=6.00974055;
 MB=3.00026557; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-23 13:30:15
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042313-0041-0000-0000-000008EF917D
Message-Id: <20190423133010.GK3923@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-23_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904230092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 02:32:09PM +0200, Peter Zijlstra wrote:
> On Sat, Apr 20, 2019 at 01:54:40AM -0700, Paul E. McKenney wrote:
> > 	And atomic_set(): set_preempt_state().	This fails
> > 	on x86, s390, and TSO friends, does it not?  Or is
> > 	this ARM-only?	Still, why not just smp_mb() before and
> > 	after?	Same issue in __kernfs_new_node(), bio_cnt_set(),
> > 	sbitmap_queue_update_wake_batch(), 
> > 
> > 	Ditto for atomic64_set() in __ceph_dir_set_complete().
> > 
> > 	Ditto for atomic_read() in rvt_qp_is_avail().  This function
> > 	has a couple of other oddly placed smp_mb__before_atomic().
> 
> That are just straight up bugs. The atomic_t.txt file clearly specifies
> the barriers only apply to RmW ops and both _set() and _read() are
> specified to not be a RmW.

Agreed.  The "Ditto" covers my atomic_set() consternation.  ;-)

> > 	And atomic_cmpxchg(): msc_buffer_alloc().  This instance
> > 	of smp_mb__before_atomic() can be removed unless I am missing
> > 	something subtle.  Ditto for kvm_vcpu_exiting_guest_mode(),
> > 	pv_kick_node(), __sbq_wake_up(), 
> 
> Note that pv_kick_node() uses cmpxchg_relaxed(), which does not
> otherwise imply barriers.

Good point, my eyes must have been going funny.

> > 	And lock acquisition??? acm_read_bulk_callback().
> 
> I think it goes with the set_bit() earlier, but what do I know.

Quite possibly!  In that case it should be smp_mb__after_atomic(),
and it would be nice if it immediately followed the set_bit().

> > 	In nfnl_acct_fill_info(), a smp_mb__before_atomic() after
> > 	a atomic64_xchg()???  Also before a clear_bit(), but the
> > 	clear_bit() is inside an "if".
> 
> Since it is _before, I'm thinking the pairing was intended with the
> clear_bit(), and yes, then I would expect the smp_mb__before_atomic() to
> be part of that same branch.

It is quite possible that this one is a leftover, where the atomic
operation was removed but the smp_mb__{before,after}_atomic() lived on.
I had one of those in RCU, which now has a patch in -rcu.

> > 	There are a few cases that would see added overhead.  For example,
> > 	svc_get_next_xprt() has the following:
> > 
> > 		smp_mb__before_atomic();
> > 		clear_bit(SP_CONGESTED, &pool->sp_flags);
> > 		clear_bit(RQ_BUSY, &rqstp->rq_flags);
> > 		smp_mb__after_atomic();
> > 
> > 	And xs_sock_reset_connection_flags() has this:
> > 
> > 		smp_mb__before_atomic();
> > 		clear_bit(XPRT_CLOSE_WAIT, &xprt->state);
> > 		clear_bit(XPRT_CLOSING, &xprt->state);
> > 		xs_sock_reset_state_flags(xprt);  /* Also a clear_bit(). */
> > 		smp_mb__after_atomic();
> > 
> > 	Yeah, there are more than a few misuses, aren't there?  :-/
> > 	A coccinelle script seems in order.  In 0day test robot.
> 
> If we can get it to flag the right patterns, then yes that might be
> useful regardless of the issue at hand, people seem to get this one
> wrong a lot.

To be fair, the odd-looking ones are maybe 5% of the total.  Still too
many wrong, but the vast majority look OK.

> > 	But there are a number of helper functions whose purpose
> > 	seems to be to wrap an atomic in smp_mb__before_atomic() and
> > 	smp_mb__after_atomic(), so some of the atomic_xxx_mb() functions
> > 	might be a good idea just for improved readability.
> 
> Are there really sites where _mb() makes sense? The above is just a lot
> of buggy code.

There are a great many that look like this:

	smp_mb__before_atomic();
	clear_bit(NFSD4_CLIENT_UPCALL_LOCK, &clp->cl_flags);
	smp_mb__after_atomic();

Replacing these three lines with this would not be a bad thing:

	clear_bit_mb(NFSD4_CLIENT_UPCALL_LOCK, &clp->cl_flags);

							Thanx, Paul

