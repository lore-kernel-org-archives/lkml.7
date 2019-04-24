Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99427C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B392183E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387814AbfDXSbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:31:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43028 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733265AbfDXSbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 14:31:16 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3OIT0ZC159820
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 14:31:15 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s2u0axf3f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 14:31:15 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 24 Apr 2019 19:31:14 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 24 Apr 2019 19:31:09 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3OIV8Y727656242
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Apr 2019 18:31:08 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56264B206A;
        Wed, 24 Apr 2019 18:31:08 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2BC89B2068;
        Wed, 24 Apr 2019 18:31:08 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.231.45])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 24 Apr 2019 18:31:08 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id BB7EE16C5ED1; Wed, 24 Apr 2019 11:31:07 -0700 (PDT)
Date:   Wed, 24 Apr 2019 11:31:07 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 1/3] tools: memory-model: Prepare for data-race detection
Reply-To: paulmck@linux.ibm.com
References: <20190424082231.GF3923@linux.ibm.com>
 <Pine.LNX.4.44L0.1904241023380.1443-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1904241023380.1443-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19042418-0068-0000-0000-000003B976B3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010988; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01193812; UDB=6.00625852; IPR=6.00974635;
 MB=3.00026579; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-24 18:31:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042418-0069-0000-0000-00004847D2CB
Message-Id: <20190424183107.GN3923@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904240133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 10:24:42AM -0400, Alan Stern wrote:
> On Wed, 24 Apr 2019, Paul E. McKenney wrote:
> 
> > On Mon, Apr 22, 2019 at 12:17:45PM -0400, Alan Stern wrote:
> > > This patch makes some slight alterations to linux-kernel.cat in
> > > preparation for adding support for data-race detection to the
> > > Linux-Kernel Memory Model.
> > > 
> > > 	The definitions of relations involved in Acquire, Release, and
> > > 	unlock-lock ordering are moved up earlier in the source file.
> > > 
> > > 	The rmb relation is factored through the new R4rmb class: the
> > > 	class of reads to which rmb will apply.
> > > 
> > > 	The definition of the fence relation is moved earlier, and it
> > > 	is split up into read- and write-fences (rmb and wmb) and all
> > > 	the others.
> > > 
> > > This should not make any functional changes.
> > > 
> > > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > 
> > Thank you, Alan, I have queued all three onto -rcu for review and testing.
> > FYI, I rebased my smp_mb__{before,after}_atomic() patch on top of yours
> > to avoid the conflict.
> > 
> > Which demonstrates non-commutativity of patches.  Your patches conflict
> > with mine, but mine does not conflict with yours.  ;-)
> 
> :-)
> 
> Besides, who knows where we'll end up with the 
> smp_mb__{before,after}_atomic stuff once Peter is done with it, anyway?

True enough!

							Thanx, Paul

