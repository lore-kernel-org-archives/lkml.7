Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4D1C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 21:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A71AA208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 21:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbfGRVe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 17:34:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30328 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727767AbfGRVe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 17:34:26 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6ILVwCO105300
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 17:34:24 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tu0s302cp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 17:34:24 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 18 Jul 2019 22:34:23 +0100
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 18 Jul 2019 22:34:21 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6ILYKks38011172
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jul 2019 21:34:20 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F98BB205F;
        Thu, 18 Jul 2019 21:34:20 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC7C8B2066;
        Thu, 18 Jul 2019 21:34:19 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.219.160])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 18 Jul 2019 21:34:19 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id AA0E916C0E4B; Thu, 18 Jul 2019 14:34:19 -0700 (PDT)
Date:   Thu, 18 Jul 2019 14:34:19 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Byungchul Park <max.byungchul.park@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@lge.com
Subject: Re: [PATCH] rcu: Make jiffies_till_sched_qs writable
Reply-To: paulmck@linux.ibm.com
References: <20190711164818.GA260447@google.com>
 <20190711195839.GA163275@google.com>
 <20190712063240.GD7702@X58A-UD3R>
 <20190712125116.GB92297@google.com>
 <CANrsvRMh6L_sEmoF_K3Mx=1VcuGSwQAT8CZHep69aSZUTBvwpA@mail.gmail.com>
 <CAEXW_YTeAUuVqViBfiOTQhckMDH229oQdPXG6SNqGK0xYm-yzA@mail.gmail.com>
 <20190713151330.GE26519@linux.ibm.com>
 <20190713154257.GE133650@google.com>
 <20190713174111.GG26519@linux.ibm.com>
 <CAEXW_YTcL-nOfJXkChGhvQtqqfSLpAYr327PLu1SmGEEADCevw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YTcL-nOfJXkChGhvQtqqfSLpAYr327PLu1SmGEEADCevw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19071821-0052-0000-0000-000003E2EA26
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011454; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01234098; UDB=6.00650323; IPR=6.01015426;
 MB=3.00027787; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-18 21:34:22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071821-0053-0000-0000-000061C09707
Message-Id: <20190718213419.GV14271@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-18_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907180218
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 12:14:22PM -0400, Joel Fernandes wrote:
> Trimming the list a bit to keep my noise level low,
> 
> On Sat, Jul 13, 2019 at 1:41 PM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
> [snip]
> > > It still feels like you guys are hyperfocusing on this one particular
> > > > knob.  I instead need you to look at the interrelating knobs as a group.
> > >
> > > Thanks for the hints, we'll do that.
> > >
> > > > On the debugging side, suppose someone gives you an RCU bug report.
> > > > What information will you need?  How can you best get that information
> > > > without excessive numbers of over-and-back interactions with the guy
> > > > reporting the bug?  As part of this last question, what information is
> > > > normally supplied with the bug?  Alternatively, what information are
> > > > bug reporters normally expected to provide when asked?
> > >
> > > I suppose I could dig out some of our Android bug reports of the past where
> > > there were RCU issues but if there's any fires you are currently fighting do
> > > send it our way as debugging homework ;-)
> >
> >   Suppose that you were getting RCU CPU stall
> > warnings featuring multi_cpu_stop() called from cpu_stopper_thread().
> > Of course, this really means that some other CPU/task is holding up
> > multi_cpu_stop() without also blocking the current grace period.
> >
> 
> So I took a shot at this trying to learn how CPU stoppers work in
> relation to this problem.
> 
> I am assuming here say CPU X has entered MULTI_STOP_DISABLE_IRQ state
> in multi_cpu_stop() but another CPU Y has not yet entered this state.
> So CPU X is stalling RCU but it is really because of CPU Y. Now in the
> problem statement, you mentioned CPU Y is not holding up the grace
> period, which means Y doesn't have any of IRQ, BH or preemption
> disabled ; but is still somehow stalling RCU indirectly by troubling
> X.
> 
> This can only happen if :
> - CPU Y has a thread executing on it that is higher priority than CPU
> X's stopper thread which prevents it from getting scheduled. - but the
> CPU stopper thread (migration/..) is highest priority RT so this would
> be some kind of an odd scheduler bug.
> - There is a bug in the CPU stopper machinery itself preventing it
> from scheduling the stopper on Y. Even though Y is not holding up the
> grace period.

- CPU Y might have already passed through its quiescent state for
  the current grace period, then disabled IRQs indefinitely.
  Now, CPU Y would block a later grace period, but CPU X is
  preventing the current grace period from ending, so no such
  later grace period can start.

> Did I get that right? Would be exciting to run the rcutorture test
> once Paul has it available to reproduce this problem.

Working on it!  Slow, I know!

							Thanx, Paul

