Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAF3C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 08:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB38208CA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 08:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbfD0Ihw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 04:37:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54310 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726019AbfD0Ihv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 04:37:51 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3R8YG0s088963
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2019 04:37:50 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s4km487k5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2019 04:37:50 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 27 Apr 2019 09:37:49 +0100
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 27 Apr 2019 09:37:45 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3R8aUCw34799754
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 27 Apr 2019 08:36:30 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33855B2064;
        Sat, 27 Apr 2019 08:36:30 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B67CB205F;
        Sat, 27 Apr 2019 08:36:30 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.147.138])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 27 Apr 2019 08:36:30 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9963216C1355; Sat, 27 Apr 2019 01:36:29 -0700 (PDT)
Date:   Sat, 27 Apr 2019 01:36:29 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
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
 <20190423133010.GK3923@linux.ibm.com>
 <20190427081738.GA11149@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190427081738.GA11149@andrea>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19042708-0060-0000-0000-000003355F4E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011003; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01195033; UDB=6.00626597; IPR=6.00975875;
 MB=3.00026620; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-27 08:37:48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042708-0061-0000-0000-0000491D6C2B
Message-Id: <20190427083629.GJ3923@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-27_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904270064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 10:17:38AM +0200, Andrea Parri wrote:
> On Tue, Apr 23, 2019 at 06:30:10AM -0700, Paul E. McKenney wrote:
> > On Tue, Apr 23, 2019 at 02:32:09PM +0200, Peter Zijlstra wrote:
> > > On Sat, Apr 20, 2019 at 01:54:40AM -0700, Paul E. McKenney wrote:
> > > > 	And atomic_set(): set_preempt_state().	This fails
> > > > 	on x86, s390, and TSO friends, does it not?  Or is
> > > > 	this ARM-only?	Still, why not just smp_mb() before and
> > > > 	after?	Same issue in __kernfs_new_node(), bio_cnt_set(),
> > > > 	sbitmap_queue_update_wake_batch(), 
> > > > 
> > > > 	Ditto for atomic64_set() in __ceph_dir_set_complete().
> > > > 
> > > > 	Ditto for atomic_read() in rvt_qp_is_avail().  This function
> > > > 	has a couple of other oddly placed smp_mb__before_atomic().
> > > 
> > > That are just straight up bugs. The atomic_t.txt file clearly specifies
> > > the barriers only apply to RmW ops and both _set() and _read() are
> > > specified to not be a RmW.
> > 
> > Agreed.  The "Ditto" covers my atomic_set() consternation.  ;-)
> 
> I was working on some of these before the Easter break [1, 2]: the plan
> was to continue next week, but by addressing the remaining cases with a
> conservative s/that barrier/smp_mb at first; unless you've other plans?
> 
>   Andrea
> 
> [1] http://lkml.kernel.org/r/1555417031-27356-1-git-send-email-andrea.parri@amarulasolutions.com
> [2] http://lkml.kernel.org/r/1555404968-39927-1-git-send-email-pbonzini@redhat.com

Sounds good to me!  ;-)

								Thanx, Paul

