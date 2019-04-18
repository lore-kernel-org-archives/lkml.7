Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F4FC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 633E9214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389934AbfDRSj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:39:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50120 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389757AbfDRSj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:39:26 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3IITYpp145167
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 14:39:25 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rxv7ky41g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 14:39:25 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 18 Apr 2019 19:39:24 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 18 Apr 2019 19:39:19 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3IIdIdj8716410
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Apr 2019 18:39:18 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49B08B2067;
        Thu, 18 Apr 2019 18:39:18 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BCAEB2065;
        Thu, 18 Apr 2019 18:39:18 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 18 Apr 2019 18:39:18 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 4A01D16C363D; Thu, 18 Apr 2019 11:39:19 -0700 (PDT)
Date:   Thu, 18 Apr 2019 11:39:19 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Daniel Kroening <kroening@cs.ox.ac.uk>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Adding plain accesses and detecting data races in the LKMM
Reply-To: paulmck@linux.ibm.com
References: <20190418125412.GA10817@andrea>
 <Pine.LNX.4.44L0.1904181324420.1303-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1904181324420.1303-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19041818-0052-0000-0000-000003AE27DD
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010951; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01190960; UDB=6.00624125; IPR=6.00971758;
 MB=3.00026504; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-18 18:39:23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041818-0053-0000-0000-0000608CA21D
Message-Id: <20190418183919.GO14111@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-18_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=932 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904180115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 01:44:36PM -0400, Alan Stern wrote:
> On Thu, 18 Apr 2019, Andrea Parri wrote:
> 
> > > Another question is "should the kernel permit smp_mb__{before,after}*()
> > > anywhere other than immediately before or after the primitive being
> > > strengthened?"
> > 
> > Mmh, I do think that keeping these barriers "immediately before or after
> > the primitive being strengthened" is a good practice (readability, and
> > all that), if this is what you're suggesting.
> > 
> > However, a first auditing of the callsites showed that this practice is
> > in fact not always applied, notably... ;-)
> > 
> > 	kernel/rcu/tree_exp.h:sync_exp_work_done
> > 	kernel/sched/cpupri.c:cpupri_set
> > 
> > So there appear, at least, to be some exceptions/reasons for not always
> > following it?  Thoughts?
> > 
> > BTW, while auditing these callsites, I've stumbled across the following
> > snippet (from kernel/futex.c):
> > 
> > 	*futex = newval;
> > 	sys_futex(WAKE, futex);
> >           futex_wake(futex);
> >           smp_mb(); (B)
> > 	  if (waiters)
> > 	    ...
> > 
> > where B is actually (c.f., futex_get_mm()):
> > 
> > 	atomic_inc(...->mm_count);
> > 	smp_mb__after_atomic();
> > 
> > It seems worth mentioning the fact that, AFAICT, this sequence does not
> > necessarily provide ordering when plain accesses are involved: consider,
> > e.g., the following variant of the snippet:
> > 
> > 	A:*x = 1;
> > 	/*
> > 	 * I've "ignored" the syscall, which should provide
> > 	 * (at least) a compiler barrier...
> > 	 */
> > 	atomic_inc(u);
> > 	smp_mb__after_atomic();
> > 	B:r0 = *y;
> > 
> > On x86, AFAICT, the compiler can do this:
> > 
> > 	atomic_inc(u);
> > 	A:*x = 1;
> > 	smp_mb__after_atomic();
> > 	B:r0 = *y;
> > 
> > (the implementation of atomic_inc() contains no compiler barrier), then
> > the CPU can "reorder" A and B (smp_mb__after_atomic() being #defined to
> > a compiler barrier).
> 
> Are you saying that on x86, atomic_inc() acts as a full memory barrier 
> but not as a compiler barrier, and vice versa for 
> smp_mb__after_atomic()?  Or that neither atomic_inc() nor 
> smp_mb__after_atomic() implements a full memory barrier?
> 
> Either one seems like a very dangerous situation indeed.

If I am following the macro-name breadcrumb trails correctly, x86's
atomic_inc() does have a compiler barrier.  But this is an accident
of implementation -- from what I can see, it is not required to do so.

So smb_mb__after_atomic() is only guaranteed to order the atomic_inc()
before B, not A.  To order A before B in the above example, an
smp_mb__before_atomic() is also needed.

But now that I look, LKMM looks to be stating a stronger guarantee:

	([M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]) |
	([M] ; po? ; [RMW] ; fencerel(After-atomic) ; [M]) |
	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
	([M] ; po ; [UL] ; (co | po) ; [LKW] ;
		fencerel(After-unlock-lock) ; [M])

Maybe something like this?

	([M] ; fencerel(Before-atomic) ; [RMW] ; fencerel(After-atomic) ; [M]) |
	([M] ; fencerel(Before-atomic) ; [RMW] |
	( [RMW] ; fencerel(After-atomic) ; [M]) |
	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
	([M] ; po ; [UL] ; (co | po) ; [LKW] ;
		fencerel(After-unlock-lock) ; [M])

Who is the lead maintainer for this stuff, anyway???  ;-)

							Thanx, Paul

> Alan
> 
> > The mips implementation seems also affected by such "reorderings": I am
> > not familiar with this implementation but, AFAICT, it does not enforce
> > ordering from A to B in the following snippet:
> > 
> > 	A:*x = 1;
> > 	atomic_inc(u);
> > 	smp_mb__after_atomic();
> > 	B:WRITE_ONCE(*y, 1);
> > 
> > when CONFIG_WEAK_ORDERING=y, CONFIG_WEAK_REORDERING_BEYOND_LLSC=n.
> > 
> > Do these observations make sense to you?  Thoughts?
> > 
> >   Andrea
> 

