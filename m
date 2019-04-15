Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AB9C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF0720825
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfDONfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 09:35:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60158 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727129AbfDONfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 09:35:39 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3FDYLwN171509
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 09:35:38 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rvt3c2wan-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 09:35:37 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 15 Apr 2019 14:35:37 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 15 Apr 2019 14:35:32 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3FDZVIV30474312
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 13:35:31 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E957B2066;
        Mon, 15 Apr 2019 13:35:31 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F050B205F;
        Mon, 15 Apr 2019 13:35:31 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 15 Apr 2019 13:35:31 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 11AD716C265F; Mon, 15 Apr 2019 06:35:35 -0700 (PDT)
Date:   Mon, 15 Apr 2019 06:35:35 -0700
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
        Daniel Kroening <kroening@cs.ox.ac.uk>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Adding plain accesses and detecting data races in the LKMM
Reply-To: paulmck@linux.ibm.com
References: <20190408055117.GA25135@andrea>
 <Pine.LNX.4.44L0.1904081010090.1440-100000@iolanthe.rowland.org>
 <20190409013618.GA3824@andrea>
 <20190409150132.GB14111@linux.ibm.com>
 <20190413213938.GA4371@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190413213938.GA4371@andrea>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19041513-0040-0000-0000-000004E1198C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010932; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01189443; UDB=6.00623208; IPR=6.00970229;
 MB=3.00026451; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-15 13:35:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041513-0041-0000-0000-000008EC2346
Message-Id: <20190415133535.GU14111@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-15_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=917 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904150094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 11:39:38PM +0200, Andrea Parri wrote:
> On Tue, Apr 09, 2019 at 08:01:32AM -0700, Paul E. McKenney wrote:
> > On Tue, Apr 09, 2019 at 03:36:18AM +0200, Andrea Parri wrote:
> > > > > The formula was more along the line of "do not assume either of these
> > > > > cases to hold; use barrier() is you need an unconditional barrier..."
> > > > > AFAICT, all current implementations of smp_mb__{before,after}_atomic()
> > > > > provides a compiler barrier with either barrier() or "memory" clobber.
> > > > 
> > > > Well, we have two reasonable choices: Say that 
> > > > smp_mb__{before,after}_atomic will always provide a compiler barrier, 
> > > > or don't say this.  I see no point in saying that the combination of 
> > > > Before-atomic followed by RMW provides a barrier.
> > > 
> > > ;-/ I'm fine with the first choice. I don't see how the second choice
> > > (this proposal/patch) would be consistent with some documentation and
> > > with the current implementations; for example,
> > > 
> > > 1) Documentation/atomic_t.txt says:
> > > 
> > > Thus:
> > > 
> > >   atomic_fetch_add();
> > > 
> > > is equivalent to:
> > > 
> > >   smp_mb__before_atomic();
> > >   atomic_fetch_add_relaxed();
> > >   smp_mb__after_atomic();
> > > 
> > > [...]
> > > 
> > > 2) Some implementations of the _relaxed() variants do not provide any
> > > compiler barrier currently.
> > 
> > But don't all implementations of smp_mb__before_atomic() and
> > smp_mb__after_atomic() currently supply a compiler barrier?
> 
> Yes, AFAICS, all implementations of smp_mb__{before,after}_atomic() currently
> supply a compiler barrier.
> 
> Nevertheless, there's a difference between:  (1) Specify that these barriers
> supply a compiler barrier,  (2) Specify that (certain) combinations of these
> barriers and RMWs supply a compiler barrier, and  (3) This patch...  ;-)
> 
> FWIW, I'm not aware of current/informal documentation following (the arguably
> simpler but slightly stronger) (1).  But again (amending my last remark): (1)
> and (2) both make sense to me.

Another question is "should the kernel permit smp_mb__{before,after}*()
anywhere other than immediately before or after the primitive being
strengthened?"

Thoughts?

							Thanx, Paul

