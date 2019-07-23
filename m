Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BA0C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412472239F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390908AbfGWQyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 12:54:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34406 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729558AbfGWQyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 12:54:08 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6NGkhLf133413
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 12:54:07 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tx60rrcgh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 12:54:06 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 23 Jul 2019 17:54:05 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 23 Jul 2019 17:54:01 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6NGs0Qv49480110
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Jul 2019 16:54:00 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F63BB2064;
        Tue, 23 Jul 2019 16:54:00 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C709B2065;
        Tue, 23 Jul 2019 16:54:00 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.189.166])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 23 Jul 2019 16:54:00 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 68B4E16C1186; Tue, 23 Jul 2019 09:54:03 -0700 (PDT)
Date:   Tue, 23 Jul 2019 09:54:03 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Byungchul Park <max.byungchul.park@gmail.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@lge.com
Subject: Re: [PATCH] rcu: Make jiffies_till_sched_qs writable
Reply-To: paulmck@linux.ibm.com
References: <20190713174111.GG26519@linux.ibm.com>
 <CAEXW_YTcL-nOfJXkChGhvQtqqfSLpAYr327PLu1SmGEEADCevw@mail.gmail.com>
 <20190719003942.GA28226@X58A-UD3R>
 <CAEXW_YQij-N2-NFjUQtsmYxVLtWxcQk_Kb16fGBzzPAZtWg+sg@mail.gmail.com>
 <20190719074329.GY14271@linux.ibm.com>
 <CANrsvRM7ehvqcPtKMV7RyRCiXwe_R_TsLZiNtxBPY_qnSg2LNQ@mail.gmail.com>
 <20190719195728.GF14271@linux.ibm.com>
 <CAEXW_YQADrPRtJW7yJZyROH1_d2yOA7_1HVgm50wxpOC80+=Wg@mail.gmail.com>
 <20190723110521.GA28883@X58A-UD3R>
 <20190723134717.GT14271@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723134717.GT14271@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19072316-0064-0000-0000-00000402756E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011482; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01236372; UDB=6.00651636; IPR=6.01017729;
 MB=3.00027856; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-23 16:54:03
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072316-0065-0000-0000-00003E632B6B
Message-Id: <20190723165403.GA7239@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-23_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907230169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 06:47:17AM -0700, Paul E. McKenney wrote:
> On Tue, Jul 23, 2019 at 08:05:21PM +0900, Byungchul Park wrote:
> > On Fri, Jul 19, 2019 at 04:33:56PM -0400, Joel Fernandes wrote:
> > > On Fri, Jul 19, 2019 at 3:57 PM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
> > > >
> > > > On Fri, Jul 19, 2019 at 06:57:58PM +0900, Byungchul Park wrote:
> > > > > On Fri, Jul 19, 2019 at 4:43 PM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
> > > > > >
> > > > > > On Thu, Jul 18, 2019 at 08:52:52PM -0400, Joel Fernandes wrote:
> > > > > > > On Thu, Jul 18, 2019 at 8:40 PM Byungchul Park <byungchul.park@lge.com> wrote:
> > > > > > > [snip]
> > > > > > > > > - There is a bug in the CPU stopper machinery itself preventing it
> > > > > > > > > from scheduling the stopper on Y. Even though Y is not holding up the
> > > > > > > > > grace period.
> > > > > > > >
> > > > > > > > Or any thread on Y is busy with preemption/irq disabled preventing the
> > > > > > > > stopper from being scheduled on Y.
> > > > > > > >
> > > > > > > > Or something is stuck in ttwu() to wake up the stopper on Y due to any
> > > > > > > > scheduler locks such as pi_lock or rq->lock or something.
> > > > > > > >
> > > > > > > > I think what you mentioned can happen easily.
> > > > > > > >
> > > > > > > > Basically we would need information about preemption/irq disabled
> > > > > > > > sections on Y and scheduler's current activity on every cpu at that time.
> > > > > > >
> > > > > > > I think all that's needed is an NMI backtrace on all CPUs. An ARM we
> > > > > > > don't have NMI solutions and only IPI or interrupt based backtrace
> > > > > > > works which should at least catch and the preempt disable and softirq
> > > > > > > disable cases.
> > > > > >
> > > > > > True, though people with systems having hundreds of CPUs might not
> > > > > > thank you for forcing an NMI backtrace on each of them.  Is it possible
> > > > > > to NMI only the ones that are holding up the CPU stopper?
> > > > >
> > > > > What a good idea! I think it's possible!
> > > > >
> > > > > But we need to think about the case NMI doesn't work when the
> > > > > holding-up was caused by IRQ disabled.
> > > > >
> > > > > Though it's just around the corner of weekend, I will keep thinking
> > > > > on it during weekend!
> > > >
> > > > Very good!
> > > 
> > > Me too will think more about it ;-) Agreed with point about 100s of
> > > CPUs usecase,
> > > 
> > > Thanks, have a great weekend,
> > 
> > BTW, if there's any long code section with irq/preemption disabled, then
> > the problem would be not only about RCU stall. And we can also use
> > latency tracer or something to detect the bad situation.
> > 
> > So in this case, sending ipi/nmi to the CPUs where the stoppers cannot
> > to be scheduled does not give us additional meaningful information.
> > 
> > I think Paul started to think about this to solve some real problem. I
> > seriously love to help RCU and it's my pleasure to dig deep into kind of
> > RCU stuff, but I've yet to define exactly what problem is. Sorry.
> > 
> > Could you share the real issue? I think you don't have to reproduce it.
> > Just sharing the issue that you got inspired from is enough. Then I
> > might be able to develop 'how' with Joel! :-) It's our pleasure!
> 
> It is unfortunately quite intermittent.  I was hoping to find a way
> to make it happen more often.  Part of the underlying problem appears
> to be lock contention, in that reducing contention made it even more
> intermittent.  Which is good in general, but not for exercising the
> CPU-stopper issue.
> 
> But perhaps your hardware will make this happen more readily than does
> mine.  The repeat-by is simple, namely run TREE04 on branch "dev" on an
> eight-CPU system.  It appear that the number of CPUs used by the test
> should match the number available on the system that you are running on,
> though perhaps affinity could allow mismatches.
> 
> So why not try it and see what happens?

And another potential issue causing this is a CONFIG_NO_HZ_FULL=y
kernel running in kernel mode (rcutorture on the one hand and callback
invocation on the other) for extended periods of time with the scheduling
clock disabled.  Just started the tests for this.  They will be running
for quite some time, which this week is a good thing.  ;-)

							Thanx, Paul

