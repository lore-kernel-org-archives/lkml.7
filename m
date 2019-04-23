Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1048FC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D393F21850
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfDWUUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 16:20:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40904 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726088AbfDWUUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 16:20:03 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3NK8xPs016161
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 16:20:01 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s28whsyqh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 16:20:01 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 23 Apr 2019 21:20:00 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 23 Apr 2019 21:19:56 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3NKJt7836044940
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Apr 2019 20:19:55 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8332B2066;
        Tue, 23 Apr 2019 20:19:55 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A13DEB2064;
        Tue, 23 Apr 2019 20:19:55 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.223.68])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 23 Apr 2019 20:19:55 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 3FE9B16C2A4D; Tue, 23 Apr 2019 13:19:55 -0700 (PDT)
Date:   Tue, 23 Apr 2019 13:19:55 -0700
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
 <20190423133010.GK3923@linux.ibm.com>
 <20190423134003.GV4038@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423134003.GV4038@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19042320-0072-0000-0000-0000041DA8EE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010982; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01193371; UDB=6.00625585; IPR=6.00974191;
 MB=3.00026562; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-23 20:19:59
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042320-0073-0000-0000-00004BEEAA24
Message-Id: <20190423201955.GX3923@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-23_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=673 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904230142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 03:40:03PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 23, 2019 at 06:30:10AM -0700, Paul E. McKenney wrote:
> > There are a great many that look like this:
> > 
> > 	smp_mb__before_atomic();
> > 	clear_bit(NFSD4_CLIENT_UPCALL_LOCK, &clp->cl_flags);
> > 	smp_mb__after_atomic();
> 
> Ooh, marvel at the comment describing the ordering there. Oh wait :-(
> So much for checkpatch.pl I suppose.

Especially if the code was in the kernel before checkpatch.pl started
asking for comments.  Which might or might not be the case with this
code.  No idea either way.

> I think the first is a release order for the 'LOCK' bit and the second
> is because of wake_up_bit() being a shitty interface.
> 
> So maybe that should've been:
> 
> 	clear_bit_unlock(NFSD4_CLIENT_UPCALL_LOCK, &clp->cl_flags);
> 	smp_mb__after_atomic();
> 	wake_up_bit(&clp->cl_flags, NFSD4_CLIENT_UPCALL_LOCK);
> 
> instead?

Quite possibly, but my brain is too fried to be sure.

							Thanx, Paul

