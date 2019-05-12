Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF7EC04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 03:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B3B2146F
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 03:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfELD2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 23:28:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59592 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726190AbfELD2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 23:28:49 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4C3QTIv060312;
        Sat, 11 May 2019 23:28:29 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2se9fuud3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 May 2019 23:28:28 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x4BLT2Ew021972;
        Sat, 11 May 2019 21:32:44 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01dal.us.ibm.com with ESMTP id 2sdp144ybv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 May 2019 21:32:44 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4C3SQNE24248476
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 May 2019 03:28:26 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8BBD5B2066;
        Sun, 12 May 2019 03:28:26 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56494B2064;
        Sun, 12 May 2019 03:28:26 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.145.78])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 12 May 2019 03:28:26 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 249C016C6B88; Sat, 11 May 2019 20:28:27 -0700 (PDT)
Date:   Sat, 11 May 2019 20:28:27 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] Documentation: atomic_t.txt: Explain ordering
 provided by smp_mb__{before,after}_atomic()
Message-ID: <20190512032827.GG3923@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190503163411.GH2606@hirez.programming.kicks-ass.net>
 <Pine.LNX.4.44L0.1905031309300.1437-100000@iolanthe.rowland.org>
 <20190506164238.GA4956@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506164238.GA4956@andrea>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-12_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905120024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 06:42:38PM +0200, Andrea Parri wrote:
> On Fri, May 03, 2019 at 01:13:44PM -0400, Alan Stern wrote:
> > The description of smp_mb__before_atomic() and smp_mb__after_atomic()
> > in Documentation/atomic_t.txt is slightly terse and misleading.  It
> > does not clearly state which other instructions are ordered by these
> > barriers.
> > 
> > This improves the text to make the actual ordering implications clear,
> > and also to explain how these barriers differ from a RELEASE or
> > ACQUIRE ordering.
> > 
> > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > CC: Peter Zijlstra <peterz@infradead.org>
> 
> I understand that this does indeed better describe the intended semantics:
> 
> Acked-by: Andrea Parri <andrea.parri@amarulasolutions.com>

I reverted the original and applied this one.  It will become visible
at the next rebase.

> Now we would only need to fix the implementations and a few (mis)uses. ;-)

You do have a start on this task!  ;-)

							Thanx, Paul

>   Andrea
> 
> 
> > 
> > ---
> > 
> > v2: Update the explanation: These barriers do provide order for 
> > accesses on the far side of the atomic RMW operation.
> > 
> > 
> >  Documentation/atomic_t.txt |   17 +++++++++++++----
> >  1 file changed, 13 insertions(+), 4 deletions(-)
> > 
> > Index: usb-devel/Documentation/atomic_t.txt
> > ===================================================================
> > --- usb-devel.orig/Documentation/atomic_t.txt
> > +++ usb-devel/Documentation/atomic_t.txt
> > @@ -170,8 +170,14 @@ The barriers:
> >  
> >    smp_mb__{before,after}_atomic()
> >  
> > -only apply to the RMW ops and can be used to augment/upgrade the ordering
> > -inherent to the used atomic op. These barriers provide a full smp_mb().
> > +only apply to the RMW atomic ops and can be used to augment/upgrade the
> > +ordering inherent to the op. These barriers act almost like a full smp_mb():
> > +smp_mb__before_atomic() orders all earlier accesses against the RMW op
> > +itself and all accesses following it, and smp_mb__after_atomic() orders all
> > +later accesses against the RMW op and all accesses preceding it. However,
> > +accesses between the smp_mb__{before,after}_atomic() and the RMW op are not
> > +ordered, so it is advisable to place the barrier right next to the RMW atomic
> > +op whenever possible.
> >  
> >  These helper barriers exist because architectures have varying implicit
> >  ordering on their SMP atomic primitives. For example our TSO architectures
> > @@ -195,7 +201,9 @@ Further, while something like:
> >    atomic_dec(&X);
> >  
> >  is a 'typical' RELEASE pattern, the barrier is strictly stronger than
> > -a RELEASE. Similarly for something like:
> > +a RELEASE because it orders preceding instructions against both the read
> > +and write parts of the atomic_dec(), and against all following instructions
> > +as well. Similarly, something like:
> >  
> >    atomic_inc(&X);
> >    smp_mb__after_atomic();
> > @@ -227,7 +235,8 @@ strictly stronger than ACQUIRE. As illus
> >  
> >  This should not happen; but a hypothetical atomic_inc_acquire() --
> >  (void)atomic_fetch_inc_acquire() for instance -- would allow the outcome,
> > -since then:
> > +because it would not order the W part of the RMW against the following
> > +WRITE_ONCE.  Thus:
> >  
> >    P1			P2
> >  
> > 
> 
