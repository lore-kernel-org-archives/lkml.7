Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5CDC48BE3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 20:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 544BF20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 20:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfF0Up2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 16:45:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44112 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726441AbfF0Up1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 16:45:27 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5RKhLb6011920
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 16:45:26 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2td1tcgx3f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 16:45:26 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 27 Jun 2019 21:45:25 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 27 Jun 2019 21:45:20 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5RKjJY515795034
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 20:45:19 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2DE2B2065;
        Thu, 27 Jun 2019 20:45:19 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95697B2066;
        Thu, 27 Jun 2019 20:45:19 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 27 Jun 2019 20:45:19 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C05EF16C5DA5; Thu, 27 Jun 2019 13:45:21 -0700 (PDT)
Date:   Thu, 27 Jun 2019 13:45:21 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
Reply-To: paulmck@linux.ibm.com
References: <20190626162558.GY26519@linux.ibm.com>
 <20190627142436.GD215968@google.com>
 <20190627103455.01014276@gandalf.local.home>
 <20190627153031.GA249127@google.com>
 <CAEXW_YT5LgdP_9SrachU4ZrhV9a7o_DM8eBfgxj=n7yRRyS-TQ@mail.gmail.com>
 <20190627154011.vbje64x6auaknhx4@linutronix.de>
 <CAEXW_YTvkSTqwi_jOE2Pr+uD-GC4Xv0CtBEL9YO7=LvJcM3FBQ@mail.gmail.com>
 <CAEXW_YTmx3wFKuiLyrQO6uSPYAL179EPa6N3WO7qZahccCs-pg@mail.gmail.com>
 <20190627181112.GY26519@linux.ibm.com>
 <20190627183022.GZ26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627183022.GZ26519@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19062720-0064-0000-0000-000003F48ADB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011342; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01224159; UDB=6.00644281; IPR=6.01005348;
 MB=3.00027495; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-27 20:45:23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062720-0065-0000-0000-00003E0E58F5
Message-Id: <20190627204521.GA31499@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-27_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906270238
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 11:30:22AM -0700, Paul E. McKenney wrote:
> On Thu, Jun 27, 2019 at 11:11:12AM -0700, Paul E. McKenney wrote:
> > On Thu, Jun 27, 2019 at 01:46:27PM -0400, Joel Fernandes wrote:
> > > On Thu, Jun 27, 2019 at 1:43 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > >
> > > > On Thu, Jun 27, 2019 at 11:40 AM Sebastian Andrzej Siewior
> > > > <bigeasy@linutronix.de> wrote:
> > > > >
> > > > > On 2019-06-27 11:37:10 [-0400], Joel Fernandes wrote:
> > > > > > Sebastian it would be nice if possible to trace where the
> > > > > > t->rcu_read_unlock_special is set for this scenario of calling
> > > > > > rcu_read_unlock_special, to give a clear idea about whether it was
> > > > > > really because of an IPI. I guess we could also add additional RCU
> > > > > > debug fields to task_struct (just for debugging) to see where there
> > > > > > unlock_special is set.
> > > > > >
> > > > > > Is there a test to reproduce this, or do I just boot an intel x86_64
> > > > > > machine with "threadirqs" and run into it?
> > > > >
> > > > > Do you want to send me a patch or should I send you my kvm image which
> > > > > triggers the bug on boot?
> > > >
> > > > I could reproduce this as well just booting Linus tree with threadirqs
> > > > command line and running rcutorture. In 15 seconds or so it locks
> > > > up... gdb backtrace shows the recursive lock:
> > > 
> > > Sorry that got badly wrapped, so I pasted it here:
> > > https://hastebin.com/ajivofomik.shell
> > 
> > Which rcutorture scenario would that be?  TREE03 is thus far refusing
> > to fail for me when run this way:
> > 
> > $ tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 8 --duration 5 --trust-make --configs "TREE03" --bootargs "threadirqs"
> 
> Ah, but I was running -rcu.  TREE03 fails at 38 seconds for me on v5.2.
> 
> Now to find out which -rcu commit fixed it.  Or at least made it much
> less probable, to Sebastian's point.

And it still works before this one:

a69987a515c8 ("rcu: Simplify rcu_read_unlock_special() deferred wakeups")
	(This is included in the dev branch of the -rcu tree, and is
	currently slated for v5.4.)

And it works at these commits:

0864f057b050 ("rcu: Use irq_work to get scheduler's attention in clean context")
385b599e8c04 ("rcu: Allow rcu_read_unlock_special() to raise_softirq() if in_irq()")
25102de65fdd ("rcu: Only do rcu_read_unlock_special() wakeups if expedited")
23634ebc1d94 ("rcu: Check for wakeup-safe conditions in rcu_read_unlock_special()")
	I checked the last one twice, both completing without problems
	other than false positives due to security-induced pointer
	obfuscation.  (These will be included in my v5.3 pull request.)

But not at this commit:

48d07c04b4cc ("rcu: Enable elimination of Tree-RCU softirq processing")
	This gets RCU CPU stall warnings rather than the double wakeup
	of ksoftirqd.  Works fine without traceirqs.

v5.2-rc1 locks up hard at early boot (three of three attempts):

	[    2.525153] clocksource: Switched to clocksource tsc
	[    2.878858] random: fast init done
	[    2.881122] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input3
	[    2.884183] probe of serio1 returned 1 after 671008 usecs
	[    9.969474] hrtimer: interrupt took 3992554 ns

v5.1 gets the double wakeup of ksoftirqd.

So it looks like I need to get that pull request sent out, doesn't it?  ;-)

							Thanx, Paul

