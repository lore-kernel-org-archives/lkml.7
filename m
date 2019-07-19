Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E3AC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 19:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3404A2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 19:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbfGST5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 15:57:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2848 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727497AbfGST5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 15:57:34 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6JJuvX0103023
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 15:57:33 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tujs4411c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 15:57:32 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 19 Jul 2019 20:57:32 +0100
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 19 Jul 2019 20:57:29 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6JJvSwf49414430
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Jul 2019 19:57:28 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 601CBB2065;
        Fri, 19 Jul 2019 19:57:28 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E7D0B205F;
        Fri, 19 Jul 2019 19:57:28 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.185.217])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 19 Jul 2019 19:57:28 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 3B5D116C0E4B; Fri, 19 Jul 2019 12:57:28 -0700 (PDT)
Date:   Fri, 19 Jul 2019 12:57:28 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Byungchul Park <max.byungchul.park@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Byungchul Park <byungchul.park@lge.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@lge.com
Subject: Re: [PATCH] rcu: Make jiffies_till_sched_qs writable
Reply-To: paulmck@linux.ibm.com
References: <CANrsvRMh6L_sEmoF_K3Mx=1VcuGSwQAT8CZHep69aSZUTBvwpA@mail.gmail.com>
 <CAEXW_YTeAUuVqViBfiOTQhckMDH229oQdPXG6SNqGK0xYm-yzA@mail.gmail.com>
 <20190713151330.GE26519@linux.ibm.com>
 <20190713154257.GE133650@google.com>
 <20190713174111.GG26519@linux.ibm.com>
 <CAEXW_YTcL-nOfJXkChGhvQtqqfSLpAYr327PLu1SmGEEADCevw@mail.gmail.com>
 <20190719003942.GA28226@X58A-UD3R>
 <CAEXW_YQij-N2-NFjUQtsmYxVLtWxcQk_Kb16fGBzzPAZtWg+sg@mail.gmail.com>
 <20190719074329.GY14271@linux.ibm.com>
 <CANrsvRM7ehvqcPtKMV7RyRCiXwe_R_TsLZiNtxBPY_qnSg2LNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANrsvRM7ehvqcPtKMV7RyRCiXwe_R_TsLZiNtxBPY_qnSg2LNQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19071919-0052-0000-0000-000003E34560
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011458; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01234541; UDB=6.00650591; IPR=6.01015874;
 MB=3.00027804; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-19 19:57:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071919-0053-0000-0000-000061C3A421
Message-Id: <20190719195728.GF14271@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-19_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907190215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 06:57:58PM +0900, Byungchul Park wrote:
> On Fri, Jul 19, 2019 at 4:43 PM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
> >
> > On Thu, Jul 18, 2019 at 08:52:52PM -0400, Joel Fernandes wrote:
> > > On Thu, Jul 18, 2019 at 8:40 PM Byungchul Park <byungchul.park@lge.com> wrote:
> > > [snip]
> > > > > - There is a bug in the CPU stopper machinery itself preventing it
> > > > > from scheduling the stopper on Y. Even though Y is not holding up the
> > > > > grace period.
> > > >
> > > > Or any thread on Y is busy with preemption/irq disabled preventing the
> > > > stopper from being scheduled on Y.
> > > >
> > > > Or something is stuck in ttwu() to wake up the stopper on Y due to any
> > > > scheduler locks such as pi_lock or rq->lock or something.
> > > >
> > > > I think what you mentioned can happen easily.
> > > >
> > > > Basically we would need information about preemption/irq disabled
> > > > sections on Y and scheduler's current activity on every cpu at that time.
> > >
> > > I think all that's needed is an NMI backtrace on all CPUs. An ARM we
> > > don't have NMI solutions and only IPI or interrupt based backtrace
> > > works which should at least catch and the preempt disable and softirq
> > > disable cases.
> >
> > True, though people with systems having hundreds of CPUs might not
> > thank you for forcing an NMI backtrace on each of them.  Is it possible
> > to NMI only the ones that are holding up the CPU stopper?
> 
> What a good idea! I think it's possible!
> 
> But we need to think about the case NMI doesn't work when the
> holding-up was caused by IRQ disabled.
> 
> Though it's just around the corner of weekend, I will keep thinking
> on it during weekend!

Very good!

							Thanx, Paul

> Thanks,
> Byungchul
> 
> >                                                         Thanx, Paul
> >
> > > But yeah I don't see why just the stacks of those CPUs that are
> > > blocking the CPU X would not suffice for the trivial cases where a
> > > piece of misbehaving code disable interrupts / preemption and
> > > prevented the stopper thread from executing.
> > >
> > > May be once the test case is ready (no rush!) , then it will be more
> > > clear what can help.
> > >
> > > J.
> > >
> 
> 
> 
> -- 
> Thanks,
> Byungchul
> 

