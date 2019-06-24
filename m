Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BE2C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 039E9205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbfFXPWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 11:22:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63010 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728380AbfFXPWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 11:22:16 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5OFJ7dF079998;
        Mon, 24 Jun 2019 11:21:26 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tb0dr2tx5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 11:21:26 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5OFKPau089251;
        Mon, 24 Jun 2019 11:21:25 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tb0dr2tw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 11:21:25 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x5OFFCJe007963;
        Mon, 24 Jun 2019 15:21:24 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03dal.us.ibm.com with ESMTP id 2t9by6pk57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 15:21:24 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5OFLN6741484764
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 15:21:23 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7EE51B2065;
        Mon, 24 Jun 2019 15:21:23 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50977B205F;
        Mon, 24 Jun 2019 15:21:23 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 24 Jun 2019 15:21:23 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 4987816C5D98; Mon, 24 Jun 2019 08:21:26 -0700 (PDT)
Date:   Mon, 24 Jun 2019 08:21:26 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] tools: memory-model: Improve data-race detection
Message-ID: <20190624152126.GA828@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <91a9c6f8-7bbf-376d-b1e0-0e2693c84ee8@gmail.com>
 <Pine.LNX.4.44L0.1906231112300.24649-100000@netrider.rowland.org>
 <20190624043455.GB26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624043455.GB26519@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-24_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906240123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 23, 2019 at 09:34:55PM -0700, Paul E. McKenney wrote:
> On Sun, Jun 23, 2019 at 11:15:06AM -0400, Alan Stern wrote:
> > On Sun, 23 Jun 2019, Akira Yokosawa wrote:
> > 
> > > Hi Paul and Alan,
> > > 
> > > On 2019/06/22 8:54, Paul E. McKenney wrote:
> > > > On Fri, Jun 21, 2019 at 10:25:23AM -0400, Alan Stern wrote:
> > > >> On Fri, 21 Jun 2019, Andrea Parri wrote:
> > > >>
> > > >>> On Thu, Jun 20, 2019 at 11:55:58AM -0400, Alan Stern wrote:
> > > >>>> Herbert Xu recently reported a problem concerning RCU and compiler
> > > >>>> barriers.  In the course of discussing the problem, he put forth a
> > > >>>> litmus test which illustrated a serious defect in the Linux Kernel
> > > >>>> Memory Model's data-race-detection code.
> > > 
> > > I was not involved in the mail thread and wondering what the litmus test
> > > looked like. Some searching of the archive has suggested that Alan presented
> > > a properly formatted test based on Herbert's idea in [1].
> > > 
> > > [1]: https://lore.kernel.org/lkml/Pine.LNX.4.44L0.1906041026570.1731-100000@iolanthe.rowland.org/
> > 
> > Yes, that's it.  The test is also available at:
> > 
> > https://github.com/paulmckrcu/litmus/blob/master/manual/plain/C-S-rcunoderef-2.litmus
> > 
> > Alan
> > 
> > > If this is the case, adding the link (or message id) in the change
> > > log would help people see the circumstances, I suppose.
> > > Paul, can you amend the change log?
> > > 
> > > I ran herd7 on said litmus test at both "lkmm" and "dev" of -rcu and
> > > confirmed that this patch fixes the result.
> > > 
> > > So,
> > > 
> > > Tested-by: Akira Yokosawa <akiyks@gmail.com>
> 
> Thank you both!  I will apply these changes tomorrow morning, Pacific Time.

And done.  Please see below for the updated commit.

							Thanx, Paul

------------------------------------------------------------------------

commit 46a020e9464aff884df56e5fd483134c8801e39f
Author: Alan Stern <stern@rowland.harvard.edu>
Date:   Thu Jun 20 11:55:58 2019 -0400

    tools/memory-model: Improve data-race detection
    
    Herbert Xu recently reported a problem concerning RCU and compiler
    barriers.  In the course of discussing the problem, he put forth a
    litmus test which illustrated a serious defect in the Linux Kernel
    Memory Model's data-race-detection code [1].
    
    The defect was that the LKMM assumed visibility and executes-before
    ordering of plain accesses had to be mediated by marked accesses.  In
    Herbert's litmus test this wasn't so, and the LKMM claimed the litmus
    test was allowed and contained a data race although neither is true.
    
    In fact, plain accesses can be ordered by fences even in the absence
    of marked accesses.  In most cases this doesn't matter, because most
    fences only order accesses within a single thread.  But the rcu-fence
    relation is different; it can order (and induce visibility between)
    accesses in different threads -- events which otherwise might be
    concurrent.  This makes it relevant to data-race detection.
    
    This patch makes two changes to the memory model to incorporate the
    new insight:
    
            If a store is separated by a fence from another access,
            the store is necessarily visible to the other access (as
            reflected in the ww-vis and wr-vis relations).  Similarly,
            if a load is separated by a fence from another access then
            the load necessarily executes before the other access (as
            reflected in the rw-xbstar relation).
    
            If a store is separated by a strong fence from a marked access
            then it is necessarily visible to any access that executes
            after the marked access (as reflected in the ww-vis and wr-vis
            relations).
    
    With these changes, the LKMM gives the desired result for Herbert's
    litmus test and other related ones [2].
    
    [1]     https://lore.kernel.org/lkml/Pine.LNX.4.44L0.1906041026570.1731-100000@iolanthe.rowland.org/
    
    [2]     https://github.com/paulmckrcu/litmus/blob/master/manual/plain/C-S-rcunoderef-1.litmus
            https://github.com/paulmckrcu/litmus/blob/master/manual/plain/C-S-rcunoderef-2.litmus
            https://github.com/paulmckrcu/litmus/blob/master/manual/plain/C-S-rcunoderef-3.litmus
            https://github.com/paulmckrcu/litmus/blob/master/manual/plain/C-S-rcunoderef-4.litmus
    
    Reported-by: Herbert Xu <herbert@gondor.apana.org.au>
    Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
    Acked-by: Andrea Parri <andrea.parri@amarulasolutions.com>
    Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
    Tested-by: Akira Yokosawa <akiyks@gmail.com>

diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index ca2f4297b4e6..ea2ff4b94074 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -179,9 +179,11 @@ let r-post-bounded = (nonrw-fence | ([~Noreturn] ; fencerel(Rmb) ; [R4rmb]))? ;
 	[Marked]
 
 (* Visibility and executes-before for plain accesses *)
-let ww-vis = w-post-bounded ; vis ; w-pre-bounded
-let wr-vis = w-post-bounded ; vis ; r-pre-bounded
-let rw-xbstar = r-post-bounded ; xbstar ; w-pre-bounded
+let ww-vis = fence | (strong-fence ; xbstar ; w-pre-bounded) |
+	(w-post-bounded ; vis ; w-pre-bounded)
+let wr-vis = fence | (strong-fence ; xbstar ; r-pre-bounded) |
+	(w-post-bounded ; vis ; r-pre-bounded)
+let rw-xbstar = fence | (r-post-bounded ; xbstar ; w-pre-bounded)
 
 (* Potential races *)
 let pre-race = ext & ((Plain * M) | ((M \ IW) * Plain))
