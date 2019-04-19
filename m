Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8783BC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C9120645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729884AbfDSTKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:10:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46874 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728638AbfDSTKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:10:15 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3JI3th7039821
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 14:06:45 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ryjx1rr77-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 14:06:45 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 19 Apr 2019 19:06:44 +0100
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 19 Apr 2019 19:06:40 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3JI6d5222872270
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Apr 2019 18:06:39 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9EA21B2066;
        Fri, 19 Apr 2019 18:06:39 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6FDB6B2064;
        Fri, 19 Apr 2019 18:06:39 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 19 Apr 2019 18:06:39 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 3AACF16C0828; Fri, 19 Apr 2019 11:06:41 -0700 (PDT)
Date:   Fri, 19 Apr 2019 11:06:41 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Alan Stern <stern@rowland.harvard.edu>,
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
 <20190419005302.GA5311@andrea>
 <20190419124720.GU14111@linux.ibm.com>
 <2827195a-f203-b9cd-444d-cf6425cef06f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2827195a-f203-b9cd-444d-cf6425cef06f@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19041918-0060-0000-0000-0000032F4FFA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010957; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01191425; UDB=6.00624407; IPR=6.00972227;
 MB=3.00026518; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-19 18:06:44
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041918-0061-0000-0000-0000490327B8
Message-Id: <20190419180641.GD14111@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-19_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904190130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 12:06:58AM +0900, Akira Yokosawa wrote:
> Hi Paul,
> 
> Please find inline comments below.
> 
> On Fri, 19 Apr 2019 05:47:20 -0700, Paul E. McKenney wrote:
> > On Fri, Apr 19, 2019 at 02:53:02AM +0200, Andrea Parri wrote:
> >>> Are you saying that on x86, atomic_inc() acts as a full memory barrier 
> >>> but not as a compiler barrier, and vice versa for 
> >>> smp_mb__after_atomic()?  Or that neither atomic_inc() nor 
> >>> smp_mb__after_atomic() implements a full memory barrier?
> >>
> >> I'd say the former; AFAICT, these boil down to:
> >>
> >>   https://elixir.bootlin.com/linux/v5.1-rc5/source/arch/x86/include/asm/atomic.h#L95
> >>   https://elixir.bootlin.com/linux/v5.1-rc5/source/arch/x86/include/asm/barrier.h#L84
> > 
> > OK, how about the following?
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit 19d166dadc4e1bba4b248fb46d32ca4f2d10896b
> > Author: Paul E. McKenney <paulmck@linux.ibm.com>
> > Date:   Fri Apr 19 05:20:30 2019 -0700
> > 
> >     tools/memory-model: Make smp_mb__{before,after}_atomic() match x86
> >     
> >     Read-modify-write atomic operations that do not return values need not
> >     provide any ordering guarantees, and this means that both the compiler
> >     and the CPU are free to reorder accesses across things like atomic_inc()
> >     and atomic_dec().  The stronger systems such as x86 allow the compiler
> >     to do the reordering, but prevent the CPU from so doing, and these
> >     systems implement smp_mb__{before,after}_atomic() as compiler barriers.
> >     The weaker systems such as Power allow both the compiler and the CPU
> >     to reorder accesses across things like atomic_inc() and atomic_dec(),
> >     and implement smp_mb__{before,after}_atomic() as full memory barriers.
> >     
> >     This means that smp_mb__before_atomic() only orders the atomic operation
> >     itself with accesses preceding the smp_mb__before_atomic(), and does
> >     not necessarily provide any ordering whatsoever against accesses
> >     folowing the atomic operation.  Similarly, smp_mb__after_atomic()
> 
> s/folowing/following/

Good eyes, fixed!

> >     only orders the atomic operation itself with accesses following the
> >     smp_mb__after_atomic(), and does not necessarily provide any ordering
> >     whatsoever against accesses preceding the atomic operation.  Full ordering
> >     therefore requires both an smp_mb__before_atomic() before the atomic
> >     operation and an smp_mb__after_atomic() after the atomic operation.
> >     
> >     Therefore, linux-kernel.cat's current model of Before-atomic
> >     and After-atomic is too strong, as it guarantees ordering of
> >     accesses on the other side of the atomic operation from the
> >     smp_mb__{before,after}_atomic().  This commit therefore weakens
> >     the guarantee to match the semantics called out above.
> >     
> >     Reported-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> >     Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> >     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > 
> > diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> > index 169d938c0b53..e5b97c3e8e39 100644
> > --- a/Documentation/memory-barriers.txt
> > +++ b/Documentation/memory-barriers.txt
> > @@ -1888,7 +1888,37 @@ There are some more advanced barrier functions:
> >  	atomic_dec(&obj->ref_count);
> >  
> >       This makes sure that the death mark on the object is perceived to be set
> > -     *before* the reference counter is decremented.
> > +     *before* the reference counter is decremented.  However, please note
> > +     that smp_mb__before_atomic()'s ordering guarantee does not necessarily
> > +     extend beyond the atomic operation.  For example:
> > +
> > +	obj->dead = 1;
> > +	smp_mb__before_atomic();
> > +	atomic_dec(&obj->ref_count);
> > +	r1 = a;
> > +
> > +     Here the store to obj->dead is not guaranteed to be ordered with
> > +     with the load from a.  This reordering can happen on x86 as follows:
> 
> s/with//

Fixed fixed.  ;-)

> And I beg you to avoid using the single letter variable "a".
> It's confusing.

Good point!  I changed it to "x".

> > +     (1) The compiler can reorder the load from a to precede the
> > +     atomic_dec(), (2) Because x86 smp_mb__before_atomic() is only a
> > +     compiler barrier, the CPU can reorder the preceding store to
> > +     obj->dead with the later load from a.
> > +
> > +     This could be avoided by using READ_ONCE(), which would prevent the
> > +     compiler from reordering due to both atomic_dec() and READ_ONCE()
> > +     being volatile accesses, and is usually preferable for loads from
> > +     shared variables.  However, weakly ordered CPUs would still be
> > +     free to reorder the atomic_dec() with the load from a, so a more
> > +     readable option is to also use smp_mb__after_atomic() as follows:
> 
> The point here is not just "readability", but also the portability of the
> code, isn't it?

As Andrea noted, in this particular case, the guarantee that the
store to obj->dead precedes the load from x is portable.  Either the
smp_mb__before_atomic() or the atomic_dec() must provide the ordering.
However, you are right that there is some non-portability.  But this
non-portability involves the order of the atomic_dec() and the store to x.

So what I did was ...

>         Thanks, Akira
> 
> > +
> > +	WRITE_ONCE(obj->dead, 1);
> > +	smp_mb__before_atomic();
> > +	atomic_dec(&obj->ref_count);
> > +	smp_mb__after_atomic();
> > +	r1 = READ_ONCE(a);
> > +
> > +     This orders all three accesses against each other, and also makes
> > +     the intent quite clear.

... change the above paragraph to read as follows:

     In addition, the example without the smp_mb__after_atomic() does
     not necessarily order the atomic_dec() with the load from x.
     In contrast, the example with both smp_mb__before_atomic() and
     smp_mb__after_atomic() orders all three accesses against each other,
     and also makes the intent quite clear.

Does that help?

							Thanx, Paul

> >       See Documentation/atomic_{t,bitops}.txt for more information.
> >  
> > diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
> > index 8dcb37835b61..b6866f93abb8 100644
> > --- a/tools/memory-model/linux-kernel.cat
> > +++ b/tools/memory-model/linux-kernel.cat
> > @@ -28,8 +28,8 @@ include "lock.cat"
> >  let rmb = [R \ Noreturn] ; fencerel(Rmb) ; [R \ Noreturn]
> >  let wmb = [W] ; fencerel(Wmb) ; [W]
> >  let mb = ([M] ; fencerel(Mb) ; [M]) |
> > -	([M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]) |
> > -	([M] ; po? ; [RMW] ; fencerel(After-atomic) ; [M]) |
> > +	([M] ; fencerel(Before-atomic) ; [RMW]) |
> > +	([RMW] ; fencerel(After-atomic) ; [M]) |
> >  	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
> >  	([M] ; po ; [UL] ; (co | po) ; [LKW] ;
> >  		fencerel(After-unlock-lock) ; [M])
> > 
> 

