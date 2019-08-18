Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26DDC3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 23:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5E0021852
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 23:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfHRXcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 19:32:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21850 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725889AbfHRXcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 19:32:08 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7INRW9M008028;
        Sun, 18 Aug 2019 19:31:36 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ufcxpd7e5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 18 Aug 2019 19:31:35 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7INTJim011680;
        Sun, 18 Aug 2019 19:31:35 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ufcxpd7ds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 18 Aug 2019 19:31:35 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7INTb3V005379;
        Sun, 18 Aug 2019 23:31:34 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma01wdc.us.ibm.com with ESMTP id 2ue976aat7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 18 Aug 2019 23:31:34 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7INVXag48300404
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 18 Aug 2019 23:31:33 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3C77B205F;
        Sun, 18 Aug 2019 23:31:33 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F6BDB2064;
        Sun, 18 Aug 2019 23:31:33 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.201.199])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 18 Aug 2019 23:31:33 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id F0B8016C16E2; Sun, 18 Aug 2019 16:31:35 -0700 (PDT)
Date:   Sun, 18 Aug 2019 16:31:35 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC v2] rcu/tree: Try to invoke_rcu_core() if in_irq() during
 unlock
Message-ID: <20190818233135.GQ28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190818214948.GA134430@google.com>
 <20190818221210.GP28441@linux.ibm.com>
 <20190818223230.GA143857@google.com>
 <20190818223511.GB143857@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190818223511.GB143857@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-18_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908180260
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2019 at 06:35:11PM -0400, Joel Fernandes wrote:
> On Sun, Aug 18, 2019 at 06:32:30PM -0400, Joel Fernandes wrote:
> > On Sun, Aug 18, 2019 at 03:12:10PM -0700, Paul E. McKenney wrote:
> > > On Sun, Aug 18, 2019 at 05:49:48PM -0400, Joel Fernandes (Google) wrote:
> > > > When we're in hard interrupt context in rcu_read_unlock_special(), we
> > > > can still benefit from invoke_rcu_core() doing wake ups of rcuc
> > > > threads when the !use_softirq parameter is passed.  This is safe
> > > > to do so because:
> > > > 
> > > > 1. We avoid the scheduler deadlock issues thanks to the deferred_qs bit
> > > > introduced in commit 23634ebc1d94 ("rcu: Check for wakeup-safe
> > > > conditions in rcu_read_unlock_special()") by checking for the same in
> > > > this patch.
> > > > 
> > > > 2. in_irq() implies in_interrupt() which implies raising softirq will
> > > > not do any wake ups.
> > > > 
> > > > The rcuc thread which is awakened will run when the interrupt returns.
> > > > 
> > > > We also honor 25102de ("rcu: Only do rcu_read_unlock_special() wakeups
> > > > if expedited") thus doing the rcuc awakening only when none of the
> > > > following are true:
> > > >   1. Critical section is blocking an expedited GP.
> > > >   2. A nohz_full CPU.
> > > > If neither of these cases are true (exp == false), then the "else" block
> > > > will run to do the irq_work stuff.
> > > > 
> > > > This commit is based on a partial revert of d143b3d1cd89 ("rcu: Simplify
> > > > rcu_read_unlock_special() deferred wakeups") with an additional in_irq()
> > > > check added.
> > > > 
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > 
> > > OK, I will bite...  If it is safe to wake up an rcuc kthread, why
> > > is it not safe to do raise_softirq()?
> > 
> > Because raise_softirq should not be done and/or doesn't do anything
> > if use_softirq == false. In fact, RCU_SOFTIRQ doesn't even existing if
> > use_softirq == false. The "else if" condition of this patch uses for
> > use_softirq.
> > 
> > Or, did I miss your point?

I am concerned that added "else if" condition might not be sufficient
to eliminate all possible cases of the caller holding a scheduler lock,
which could result in deadlock in the ensuing wakeup.  Might be me missing
something, but such deadlocks have been a recurring problem in the past.

Also, your commit log's point #2 is "in_irq() implies in_interrupt()
which implies raising softirq will not do any wake ups."  This mention
of softirq seems a bit odd, given that we are going to wake up a rcuc
kthread.  Of course, this did nothing to quell my suspicions.  ;-)

							Thanx, Paul

> > > And from the nit department, looks like some whitespace damage on the
> > > comments.
> > 
> > I will fix all of these in the change log, it was just a quick RFC I sent
> > with the idea, tagged as RFC and not yet for merging. I should also remove
> > the comment about " in_irq() implies in_interrupt() which implies raising
> > softirq" from the changelog since this patch is only concerned with the rcuc
> > kthread.
> 
> Ah, I see you mean the comments on the code. Perhaps something went wrong
> when I did 'git revert' on the original patch, or some such. Anyway, please
> consider this as RFC-grade only. And hopefully I have been writing better
> change logs (really trying!!).
> 
> thanks,
> 
>  - Joel
> 
