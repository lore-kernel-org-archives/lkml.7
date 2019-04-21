Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E78C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 19:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61BA20870
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 19:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfDUTml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 15:42:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33414 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725767AbfDUTml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 15:42:41 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3LJd4ug073730
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2019 15:42:39 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s0gujbh3k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2019 15:42:39 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 21 Apr 2019 20:42:38 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 21 Apr 2019 20:42:33 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3LJgWpa32637010
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 21 Apr 2019 19:42:33 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D30D5B2068;
        Sun, 21 Apr 2019 19:42:32 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A951DB2065;
        Sun, 21 Apr 2019 19:42:32 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.191.223])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 21 Apr 2019 19:42:32 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 1502016C623E; Sun, 21 Apr 2019 12:38:29 -0700 (PDT)
Date:   Sun, 21 Apr 2019 12:38:29 -0700
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
 <20190419180641.GD14111@linux.ibm.com>
 <516794a4-7a3c-4a82-6e45-de650a02a1de@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <516794a4-7a3c-4a82-6e45-de650a02a1de@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19042119-0052-0000-0000-000003AF217A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010969; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01192414; UDB=6.00625002; IPR=6.00973219;
 MB=3.00026537; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-21 19:42:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042119-0053-0000-0000-00006095319C
Message-Id: <20190421193829.GF24840@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-21_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904210154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 11:50:14PM +0900, Akira Yokosawa wrote:
> On Fri, 19 Apr 2019 11:06:41 -0700, Paul E. McKenney wrote:
> > On Sat, Apr 20, 2019 at 12:06:58AM +0900, Akira Yokosawa wrote:
> >> Hi Paul,
> >>
> [...]
> > 
> >>> +     (1) The compiler can reorder the load from a to precede the
> >>> +     atomic_dec(), (2) Because x86 smp_mb__before_atomic() is only a
> >>> +     compiler barrier, the CPU can reorder the preceding store to
> >>> +     obj->dead with the later load from a.
> >>> +
> >>> +     This could be avoided by using READ_ONCE(), which would prevent the
> >>> +     compiler from reordering due to both atomic_dec() and READ_ONCE()
> >>> +     being volatile accesses, and is usually preferable for loads from
> >>> +     shared variables.  However, weakly ordered CPUs would still be
> >>> +     free to reorder the atomic_dec() with the load from a, so a more
> >>> +     readable option is to also use smp_mb__after_atomic() as follows:
> >>
> >> The point here is not just "readability", but also the portability of the
> >> code, isn't it?
> > 
> > As Andrea noted, in this particular case, the guarantee that the
> > store to obj->dead precedes the load from x is portable.  Either the
> > smp_mb__before_atomic() or the atomic_dec() must provide the ordering.
> 
> I think I understood this. What I wanted to say was the code for x86 implied
> in the subjunctive sentence:
> 
> 	obj->dead = 1;
> 	smp_mb__before_atomic();
> 	atomic_dec(&obj->ref_count);
> 	r1 = READ_ONCE(x);
> 
> , which was not spelled out, is not portable if we expect the ordering of
> atomic_dec() with READ_ONCE().

I now understand that you understood.  ;-)

> > However, you are right that there is some non-portability.  But this
> > non-portability involves the order of the atomic_dec() and the store to x.
> 
> Yes, you've guessed it right.

Don't worry, it won't happen again!

> > So what I did was ...
> > 
> >>         Thanks, Akira
> >>
> >>> +
> >>> +	WRITE_ONCE(obj->dead, 1);
> >>> +	smp_mb__before_atomic();
> >>> +	atomic_dec(&obj->ref_count);
> >>> +	smp_mb__after_atomic();
> >>> +	r1 = READ_ONCE(a);
> >>> +
> >>> +     This orders all three accesses against each other, and also makes
> >>> +     the intent quite clear.
> > 
> > ... change the above paragraph to read as follows:
> > 
> >      In addition, the example without the smp_mb__after_atomic() does
> >      not necessarily order the atomic_dec() with the load from x.
> >      In contrast, the example with both smp_mb__before_atomic() and
> >      smp_mb__after_atomic() orders all three accesses against each other,
> >      and also makes the intent quite clear.
> > 
> > Does that help?
> 
> This looks a little bit redundant to me. The original one is clear
> enough.
> 
> How about editing the leading sentence above:
> 
> >>> +     shared variables.  However, weakly ordered CPUs would still be
> >>> +     free to reorder the atomic_dec() with the load from a, so a more
> >>> +     readable option is to also use smp_mb__after_atomic() as follows:
> 
> to read as follows?
> 
>      shared variables.  However, weakly ordered CPUs would still be
>      free to reorder the atomic_dec() with the load from x, so a
>      portable and more readable option is to also use
>      smp_mb__after_atomic() as follows:

Adding "portable and", correct?  Makes sense, so I applied this change.

> Obviously, the interesting discussion going on in another thread will
> surely affect this patch.

Quite possibly!  ;-)


							Thanx, Paul

> >>>       See Documentation/atomic_{t,bitops}.txt for more information.
> >>>  
> >>> diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
> >>> index 8dcb37835b61..b6866f93abb8 100644
> >>> --- a/tools/memory-model/linux-kernel.cat
> >>> +++ b/tools/memory-model/linux-kernel.cat
> >>> @@ -28,8 +28,8 @@ include "lock.cat"
> >>>  let rmb = [R \ Noreturn] ; fencerel(Rmb) ; [R \ Noreturn]
> >>>  let wmb = [W] ; fencerel(Wmb) ; [W]
> >>>  let mb = ([M] ; fencerel(Mb) ; [M]) |
> >>> -	([M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]) |
> >>> -	([M] ; po? ; [RMW] ; fencerel(After-atomic) ; [M]) |
> >>> +	([M] ; fencerel(Before-atomic) ; [RMW]) |
> >>> +	([RMW] ; fencerel(After-atomic) ; [M]) |
> >>>  	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
> >>>  	([M] ; po ; [UL] ; (co | po) ; [LKW] ;
> >>>  		fencerel(After-unlock-lock) ; [M])
> >>>
> >>
> > 
> 

