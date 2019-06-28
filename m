Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CB8C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 20:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91159208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 20:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfF1UEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 16:04:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46194 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726809AbfF1UEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 16:04:32 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5SK1OBH006425
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 16:04:30 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tdpffp8sw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 16:04:30 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 28 Jun 2019 21:04:28 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 28 Jun 2019 21:04:23 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5SK4NtT13238566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 20:04:23 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7CAEB2064;
        Fri, 28 Jun 2019 20:04:22 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B95C4B205F;
        Fri, 28 Jun 2019 20:04:22 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 28 Jun 2019 20:04:22 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 86B0B16C5D5C; Fri, 28 Jun 2019 13:04:23 -0700 (PDT)
Date:   Fri, 28 Jun 2019 13:04:23 -0700
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
References: <20190627155506.GU26519@linux.ibm.com>
 <CAEXW_YSEN_OL3ftTLN=M-W70WSuCgHJqU-R9VhS=A3uVj_AL+A@mail.gmail.com>
 <20190627173831.GW26519@linux.ibm.com>
 <20190627181638.GA209455@google.com>
 <20190627184107.GA26519@linux.ibm.com>
 <20190628135433.GE3402@hirez.programming.kicks-ass.net>
 <20190628153050.GU26519@linux.ibm.com>
 <20190628184026.fds6scgi2pnjnc5p@linutronix.de>
 <20190628185219.GA26519@linux.ibm.com>
 <20190628192407.GA89956@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628192407.GA89956@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19062820-0060-0000-0000-00000356CDE9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011348; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01224622; UDB=6.00644560; IPR=6.01005814;
 MB=3.00027511; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-28 20:04:27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062820-0061-0000-0000-000049F1606E
Message-Id: <20190628200423.GB26519@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-28_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906280229
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 03:24:07PM -0400, Joel Fernandes wrote:
> On Fri, Jun 28, 2019 at 11:52:19AM -0700, Paul E. McKenney wrote:
> > On Fri, Jun 28, 2019 at 08:40:26PM +0200, Sebastian Andrzej Siewior wrote:
> > > On 2019-06-28 08:30:50 [-0700], Paul E. McKenney wrote:
> > > > On Fri, Jun 28, 2019 at 03:54:33PM +0200, Peter Zijlstra wrote:
> > > > > On Thu, Jun 27, 2019 at 11:41:07AM -0700, Paul E. McKenney wrote:
> > > > > > Or just don't do the wakeup at all, if it comes to that.  I don't know
> > > > > > of any way to determine whether rcu_read_unlock() is being called from
> > > > > > the scheduler, but it has been some time since I asked Peter Zijlstra
> > > > > > about that.
> > > > > 
> > > > > There (still) is no 'in-scheduler' state.
> > > > 
> > > > Well, my TREE03 + threadirqs rcutorture test ran for ten hours last
> > > > night with no problems, so we just might be OK.
> > > > 
> > > > The apparent fix is below, though my approach would be to do backports
> > > > for the full set of related changes.
> > > > 
> > > > Joel, Sebastian, how goes any testing from your end?  Any reason
> > > > to believe that this does not represent a fix?  (Me, I am still
> > > > concerned about doing raise_softirq() from within a threaded
> > > > interrupt, but am not seeing failures.)
> 
> Are you concerned also about a regular process context executing in the
> scheduler and using RCU, having this issue?
> (not anything with threaded or not threaded IRQs, but just a path in the
> scheduler that uses RCU).
> 
> I don't think Sebastian's lock up has to do with the fact that an interrupt
> is threaded or not, except that ksoftirqd is awakened in the case where
> threadirqs is passed.

In current -rcu, the checks should suffice in the absence of threaded
interrupts.  They might also suffice for threaded interrupts, but a more
direct approach would be better, hence the in_interrupt() patch.

> > > For some reason it does not trigger as good as it did yesterday.
> > 
> > I swear that I wasn't watching!!!  ;-)
> > 
> > But I do know that feeling.
> 
> :-)
> 
> > > Commit
> > > - 23634ebc1d946 ("rcu: Check for wakeup-safe conditions in
> > >    rcu_read_unlock_special()") does not trigger the bug within 94
> > >    attempts.
> > > 
> > > - 48d07c04b4cc1 ("rcu: Enable elimination of Tree-RCU softirq
> > >   processing") needed 12 attempts to trigger the bug.
> > 
> > That matches my belief that 23634ebc1d946 ("rcu: Check for wakeup-safe
> > conditions in rcu_read_unlock_special()") will at least greatly decrease
> > the probability of this bug occurring.
> 
> I was just typing a reply that I can't reproduce it with:
>   rcu: Check for wakeup-safe conditions in rcu_read_unlock_special()
> 
> I am trying to revert enough of this patch to see what would break things,
> however I think a better exercise might be to understand more what the patch
> does why it fixes things in the first place ;-) It is probably the
> deferred_qs thing.

The deferred_qs flag is part of it!  Looking forward to hearing what
you come up with as being the critical piece of this commit.

							Thanx, Paul

