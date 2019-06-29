Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE5BC5B579
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 00:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C32208E3
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 00:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfF2AGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 20:06:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59900 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726707AbfF2AGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 20:06:33 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5T01vKZ118939
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 20:06:32 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tdtv13t3w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 20:06:32 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 29 Jun 2019 01:06:31 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 29 Jun 2019 01:06:27 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5T06Qou48562592
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Jun 2019 00:06:26 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 739F4B2064;
        Sat, 29 Jun 2019 00:06:26 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45B2AB205F;
        Sat, 29 Jun 2019 00:06:26 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 29 Jun 2019 00:06:26 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 5163F16C39C0; Fri, 28 Jun 2019 17:06:27 -0700 (PDT)
Date:   Fri, 28 Jun 2019 17:06:27 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
Reply-To: paulmck@linux.ibm.com
References: <20190627184107.GA26519@linux.ibm.com>
 <20190628135433.GE3402@hirez.programming.kicks-ass.net>
 <20190628153050.GU26519@linux.ibm.com>
 <20190628184026.fds6scgi2pnjnc5p@linutronix.de>
 <20190628185219.GA26519@linux.ibm.com>
 <20190628192407.GA89956@google.com>
 <20190628200423.GB26519@linux.ibm.com>
 <20190628214018.GB249127@google.com>
 <20190628222547.GE26519@linux.ibm.com>
 <20190628231241.GA9243@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628231241.GA9243@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19062900-0064-0000-0000-000003F508CD
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011348; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01224702; UDB=6.00644609; IPR=6.01005895;
 MB=3.00027513; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-29 00:06:30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062900-0065-0000-0000-00003E11EF63
Message-Id: <20190629000627.GF26519@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-28_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906280278
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 07:12:41PM -0400, Joel Fernandes wrote:
> On Fri, Jun 28, 2019 at 03:25:47PM -0700, Paul E. McKenney wrote:
> > On Fri, Jun 28, 2019 at 05:40:18PM -0400, Joel Fernandes wrote:
> > > Hi Paul,
> > > 
> > > On Fri, Jun 28, 2019 at 01:04:23PM -0700, Paul E. McKenney wrote:
> > > [snip]
> > > > > > > Commit
> > > > > > > - 23634ebc1d946 ("rcu: Check for wakeup-safe conditions in
> > > > > > >    rcu_read_unlock_special()") does not trigger the bug within 94
> > > > > > >    attempts.
> > > > > > > 
> > > > > > > - 48d07c04b4cc1 ("rcu: Enable elimination of Tree-RCU softirq
> > > > > > >   processing") needed 12 attempts to trigger the bug.
> > > > > > 
> > > > > > That matches my belief that 23634ebc1d946 ("rcu: Check for wakeup-safe
> > > > > > conditions in rcu_read_unlock_special()") will at least greatly decrease
> > > > > > the probability of this bug occurring.
> > > > > 
> > > > > I was just typing a reply that I can't reproduce it with:
> > > > >   rcu: Check for wakeup-safe conditions in rcu_read_unlock_special()
> > > > > 
> > > > > I am trying to revert enough of this patch to see what would break things,
> > > > > however I think a better exercise might be to understand more what the patch
> > > > > does why it fixes things in the first place ;-) It is probably the
> > > > > deferred_qs thing.
> > > > 
> > > > The deferred_qs flag is part of it!  Looking forward to hearing what
> > > > you come up with as being the critical piece of this commit.
> > > 
> > > The new deferred_qs flag indeed saves the machine from the dead-lock.
> > > 
> > > If we don't want the deferred_qs, then the below patch also fixes the issue.
> > > However, I am more sure than not that it does not handle all cases (such as
> > > what if we previously had an expedited grace period IPI in a previous reader
> > > section and had to to defer processing. Then it seems a similar deadlock
> > > would present. But anyway, the below patch does fix it for me! It is based on
> > > your -rcu tree commit 23634ebc1d946f19eb112d4455c1d84948875e31 (rcu: Check
> > > for wakeup-safe conditions in rcu_read_unlock_special()).
> > 
> > The point here being that you rely on .b.blocked rather than
> > .b.deferred_qs.  Hmmm...  There are a number of places that check all
> > the bits via the .s leg of the rcu_special union.  The .s check in
> > rcu_preempt_need_deferred_qs() should be OK because it is conditioned
> > on t->rcu_read_lock_nesting of zero or negative.
> > Do rest of those also work out OK?
> > 
> > It would be nice to remove the flag, but doing so clearly needs careful
> > review and testing.
> 
> Agreed. I am planning to do an audit of this code within the next couple of
> weeks so I will be on the look out for any optimization opportunities related
> to this. Will let you know if this can work. For now I like your patch better
> because it is more conservative and doesn't cause any space overhead.

Fixing the bug in a maintainable manner is the priority, to be sure.
However, simplifications, assuming that they work, are very much worth
considering as well.

And Murphy says that there are still a number of bugs and optimization
opportunities.  ;-)

> If you'd like, please free to included my Tested-by on it:
> 
> Tested-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Will do, thank you!

> If you had a chance, could you also point to me any tests that show
> performance improvement with the irqwork patch, on the expedited GP usecase?
> I'd like to try it out as well. I guess rcuperf should have some?

As a first thing to try, I suggest running rcuperf with both readers and
writers, with only expedited grace periods, and with most (or maybe even
all) CPUs having nohz_full enabled.

							Thanx, Paul

