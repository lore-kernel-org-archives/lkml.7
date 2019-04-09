Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549DBC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B6420833
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfDIPBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 11:01:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53070 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726372AbfDIPBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 11:01:42 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x39EuQfX131763
        for <linux-kernel@vger.kernel.org>; Tue, 9 Apr 2019 11:01:41 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rrv9rvwth-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 11:01:38 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 9 Apr 2019 16:01:37 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 9 Apr 2019 16:01:32 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x39F1VTv27787500
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Apr 2019 15:01:31 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59F1CB2071;
        Tue,  9 Apr 2019 15:01:31 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3AC18B2064;
        Tue,  9 Apr 2019 15:01:31 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  9 Apr 2019 15:01:31 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 3AD7516C3620; Tue,  9 Apr 2019 08:01:32 -0700 (PDT)
Date:   Tue, 9 Apr 2019 08:01:32 -0700
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409013618.GA3824@andrea>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19040915-0060-0000-0000-0000032A8347
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010896; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01186627; UDB=6.00621498; IPR=6.00967387;
 MB=3.00026363; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-09 15:01:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040915-0061-0000-0000-000048E38D87
Message-Id: <20190409150132.GB14111@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-09_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=481 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904090094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 03:36:18AM +0200, Andrea Parri wrote:
> > > The formula was more along the line of "do not assume either of these
> > > cases to hold; use barrier() is you need an unconditional barrier..."
> > > AFAICT, all current implementations of smp_mb__{before,after}_atomic()
> > > provides a compiler barrier with either barrier() or "memory" clobber.
> > 
> > Well, we have two reasonable choices: Say that 
> > smp_mb__{before,after}_atomic will always provide a compiler barrier, 
> > or don't say this.  I see no point in saying that the combination of 
> > Before-atomic followed by RMW provides a barrier.
> 
> ;-/ I'm fine with the first choice. I don't see how the second choice
> (this proposal/patch) would be consistent with some documentation and
> with the current implementations; for example,
> 
> 1) Documentation/atomic_t.txt says:
> 
> Thus:
> 
>   atomic_fetch_add();
> 
> is equivalent to:
> 
>   smp_mb__before_atomic();
>   atomic_fetch_add_relaxed();
>   smp_mb__after_atomic();
> 
> [...]
> 
> 2) Some implementations of the _relaxed() variants do not provide any
> compiler barrier currently.

But don't all implementations of smp_mb__before_atomic() and
smp_mb__after_atomic() currently supply a compiler barrier?

							Thanx, Paul

