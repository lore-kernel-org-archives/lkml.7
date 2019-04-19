Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFDBC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814B520652
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfDSS01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:26:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37750 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727601AbfDSS0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:26:24 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3JINO1g066487
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 14:26:23 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ryjv21h4x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 14:26:23 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 19 Apr 2019 19:26:22 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 19 Apr 2019 19:26:19 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3JIQInd20512904
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Apr 2019 18:26:18 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E832B205F;
        Fri, 19 Apr 2019 18:26:18 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 605E9B206A;
        Fri, 19 Apr 2019 18:26:18 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 19 Apr 2019 18:26:18 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 315DF16C041F; Fri, 19 Apr 2019 11:26:20 -0700 (PDT)
Date:   Fri, 19 Apr 2019 11:26:20 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation: atomic_t.txt: Explain ordering provided
 by smp_mb__{before,after}_atomic()
Reply-To: paulmck@linux.ibm.com
References: <Pine.LNX.4.44L0.1904191312200.1406-100000@iolanthe.rowland.org>
 <20190419180017.GP4038@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419180017.GP4038@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19041918-0068-0000-0000-000003B79218
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010957; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01191432; UDB=6.00624411; IPR=6.00972233;
 MB=3.00026518; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-19 18:26:22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041918-0069-0000-0000-000048388FEC
Message-Id: <20190419182620.GF14111@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-19_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=820 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904190131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 08:00:17PM +0200, Peter Zijlstra wrote:
> On Fri, Apr 19, 2019 at 01:21:45PM -0400, Alan Stern wrote:
> > Index: usb-devel/Documentation/atomic_t.txt
> > ===================================================================
> > --- usb-devel.orig/Documentation/atomic_t.txt
> > +++ usb-devel/Documentation/atomic_t.txt
> > @@ -171,7 +171,10 @@ The barriers:
> >    smp_mb__{before,after}_atomic()
> >  
> >  only apply to the RMW ops and can be used to augment/upgrade the ordering
> > -inherent to the used atomic op. These barriers provide a full smp_mb().
> > +inherent to the used atomic op. Unlike normal smp_mb() barriers, they order
> > +only the RMW op itself against the instructions preceding the
> > +smp_mb__before_atomic() or following the smp_mb__after_atomic(); they do
> > +not order instructions on the other side of the RMW op at all.
> 
> Now it is I who is confused; what?
> 
> 	x = 1;
> 	smp_mb__before_atomic();
> 	atomic_add(1, &a);
> 	y = 1;
> 
> the stores to both x and y will be ordered as if an smp_mb() where
> there. There is no order between a and y otoh.

Let's look at x86.  And a slightly different example:

	x = 1;
	smp_mb__before_atomic();
	atomic_add(1, &a);
	r1 = y;

The atomic_add() asm does not have the "memory" constraint, which is
completely legitimate because atomic_add() does not return a value,
and thus guarantees no ordering.  The compiler is therefore within
its rights to transform the code into the following:

	x = 1;
	smp_mb__before_atomic();
	r1 = y;
	atomic_add(1, &a);

But x86's smp_mb__before_atomic() is just a compiler barrier, and
x86 is further allowed to reorder prior stores with later loads.
The CPU can therefore execute this code as follows:

	r1 = y;
	x = 1;
	smp_mb__before_atomic();
	atomic_add(1, &a);

So in general, the ordering is guaranteed only to the atomic itself,
not to accesses on the other side of the atomic.

							Thanx, Paul

