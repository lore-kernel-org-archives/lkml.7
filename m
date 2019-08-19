Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F5BC3A589
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 01:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA36E2054F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 01:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfHSBV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 21:21:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22508 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726132AbfHSBV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 21:21:57 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7J1GdOs117408
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 21:21:55 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uffa14grp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 21:21:55 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 19 Aug 2019 02:21:55 +0100
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 19 Aug 2019 02:21:51 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7J1LoTC51511588
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Aug 2019 01:21:50 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8BB5B2067;
        Mon, 19 Aug 2019 01:21:50 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 943B4B205F;
        Mon, 19 Aug 2019 01:21:50 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.201.199])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 19 Aug 2019 01:21:50 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 3CA4A16C16E2; Sun, 18 Aug 2019 18:21:53 -0700 (PDT)
Date:   Sun, 18 Aug 2019 18:21:53 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC v2] rcu/tree: Try to invoke_rcu_core() if in_irq() during
 unlock
Reply-To: paulmck@linux.ibm.com
References: <20190818214948.GA134430@google.com>
 <20190818221210.GP28441@linux.ibm.com>
 <20190818223230.GA143857@google.com>
 <20190818223511.GB143857@google.com>
 <20190818233135.GQ28441@linux.ibm.com>
 <20190818233839.GA160903@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190818233839.GA160903@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19081901-0072-0000-0000-000004539294
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011613; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01248841; UDB=6.00659210; IPR=6.01030364;
 MB=3.00028226; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-19 01:21:53
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081901-0073-0000-0000-00004CC4B01E
Message-Id: <20190819012153.GR28441@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-18_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908190012
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2019 at 07:38:39PM -0400, Joel Fernandes wrote:
> On Sun, Aug 18, 2019 at 04:31:35PM -0700, Paul E. McKenney wrote:
> > On Sun, Aug 18, 2019 at 06:35:11PM -0400, Joel Fernandes wrote:
> > > On Sun, Aug 18, 2019 at 06:32:30PM -0400, Joel Fernandes wrote:
> > > > On Sun, Aug 18, 2019 at 03:12:10PM -0700, Paul E. McKenney wrote:
> > > > > On Sun, Aug 18, 2019 at 05:49:48PM -0400, Joel Fernandes (Google) wrote:
> > > > > > When we're in hard interrupt context in rcu_read_unlock_special(), we
> > > > > > can still benefit from invoke_rcu_core() doing wake ups of rcuc
> > > > > > threads when the !use_softirq parameter is passed.  This is safe
> > > > > > to do so because:
> > > > > > 
> > > > > > 1. We avoid the scheduler deadlock issues thanks to the deferred_qs bit
> > > > > > introduced in commit 23634ebc1d94 ("rcu: Check for wakeup-safe
> > > > > > conditions in rcu_read_unlock_special()") by checking for the same in
> > > > > > this patch.
> > > > > > 
> > > > > > 2. in_irq() implies in_interrupt() which implies raising softirq will
> > > > > > not do any wake ups.
> > > > > > 
> > > > > > The rcuc thread which is awakened will run when the interrupt returns.
> > > > > > 
> > > > > > We also honor 25102de ("rcu: Only do rcu_read_unlock_special() wakeups
> > > > > > if expedited") thus doing the rcuc awakening only when none of the
> > > > > > following are true:
> > > > > >   1. Critical section is blocking an expedited GP.
> > > > > >   2. A nohz_full CPU.
> > > > > > If neither of these cases are true (exp == false), then the "else" block
> > > > > > will run to do the irq_work stuff.
> > > > > > 
> > > > > > This commit is based on a partial revert of d143b3d1cd89 ("rcu: Simplify
> > > > > > rcu_read_unlock_special() deferred wakeups") with an additional in_irq()
> > > > > > check added.
> > > > > > 
> > > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > 
> > > > > OK, I will bite...  If it is safe to wake up an rcuc kthread, why
> > > > > is it not safe to do raise_softirq()?
> > > > 
> > > > Because raise_softirq should not be done and/or doesn't do anything
> > > > if use_softirq == false. In fact, RCU_SOFTIRQ doesn't even existing if
> > > > use_softirq == false. The "else if" condition of this patch uses for
> > > > use_softirq.
> > > > 
> > > > Or, did I miss your point?
> > 
> > I am concerned that added "else if" condition might not be sufficient
> > to eliminate all possible cases of the caller holding a scheduler lock,
> > which could result in deadlock in the ensuing wakeup.  Might be me missing
> > something, but such deadlocks have been a recurring problem in the past.
> 
> I thought that was the whole point of the
> rcu_read_unlock_special.b.deferred_qs bit that was introduced in
> 23634ebc1d94. We are checking that bit in the "else if" here as well. So this
> should be no less immune to scheduler deadlocks any more than the preceding
> "else if" where we are checking this bit.

I would have much more confidence in a line of reasoning that led to
"immune to scheduler deadlocks" than one that led to "no less immune to
scheduler deadlocks".  ;-)

> > Also, your commit log's point #2 is "in_irq() implies in_interrupt()
> > which implies raising softirq will not do any wake ups."  This mention
> > of softirq seems a bit odd, given that we are going to wake up a rcuc
> > kthread.  Of course, this did nothing to quell my suspicions.  ;-)
> 
> Yes, I should delete this #2 from the changelog since it is not very relevant
> (I feel now). My point with #2 was that even if were to raise a softirq
> (which we are not), a scheduler wakeup of ksoftirqd is impossible in this
> path anyway since in_irq() implies in_interrupt().

Please!  Could you also add a first-principles explanation of why
the added condition is immune from scheduler deadlocks?

							Thanx, Paul

