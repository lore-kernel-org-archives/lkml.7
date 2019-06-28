Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79999C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C9DB214DA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfF1PyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 11:54:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10960 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726830AbfF1PyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:54:10 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5SFqZJj080249
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 11:54:09 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tdk9dfeng-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 11:54:09 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 28 Jun 2019 16:54:08 +0100
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 28 Jun 2019 16:54:05 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5SFs47D21365184
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 15:54:04 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2671BB2068;
        Fri, 28 Jun 2019 15:54:04 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08788B205F;
        Fri, 28 Jun 2019 15:54:04 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 28 Jun 2019 15:54:03 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8A3F716C39B7; Fri, 28 Jun 2019 08:54:04 -0700 (PDT)
Date:   Fri, 28 Jun 2019 08:54:04 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Scott Wood <swood@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
Reply-To: paulmck@linux.ibm.com
References: <20190627103455.01014276@gandalf.local.home>
 <20190627153031.GA249127@google.com>
 <20190627155506.GU26519@linux.ibm.com>
 <CAEXW_YSEN_OL3ftTLN=M-W70WSuCgHJqU-R9VhS=A3uVj_AL+A@mail.gmail.com>
 <20190627173831.GW26519@linux.ibm.com>
 <20190627181638.GA209455@google.com>
 <20190627184107.GA26519@linux.ibm.com>
 <13761fee4b71cc004ad0d6709875ce917ff28fce.camel@redhat.com>
 <20190627203612.GD26519@linux.ibm.com>
 <20190628141522.GF3402@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628141522.GF3402@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19062815-0052-0000-0000-000003D810D5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011347; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01224538; UDB=6.00644510; IPR=6.01005731;
 MB=3.00027509; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-28 15:54:07
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062815-0053-0000-0000-0000617E8289
Message-Id: <20190628155404.GV26519@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-28_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=961 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906280183
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 04:15:22PM +0200, Peter Zijlstra wrote:
> On Thu, Jun 27, 2019 at 01:36:12PM -0700, Paul E. McKenney wrote:
> > On Thu, Jun 27, 2019 at 03:17:27PM -0500, Scott Wood wrote:
> > > On Thu, 2019-06-27 at 11:41 -0700, Paul E. McKenney wrote:
> > > > On Thu, Jun 27, 2019 at 02:16:38PM -0400, Joel Fernandes wrote:
> > > > > 
> > > > > I think the fix should be to prevent the wake-up not based on whether we
> > > > > are
> > > > > in hard/soft-interrupt mode but that we are doing the rcu_read_unlock()
> > > > > from
> > > > > a scheduler path (if we can detect that)
> > > > 
> > > > Or just don't do the wakeup at all, if it comes to that.  I don't know
> > > > of any way to determine whether rcu_read_unlock() is being called from
> > > > the scheduler, but it has been some time since I asked Peter Zijlstra
> > > > about that.
> > > > 
> > > > Of course, unconditionally refusing to do the wakeup might not be happy
> > > > thing for NO_HZ_FULL kernels that don't implement IRQ work.
> > > 
> > > Couldn't smp_send_reschedule() be used instead?
> > 
> > Good point.  If current -rcu doesn't fix things for Sebastian's case,
> > that would be well worth looking at.  But there must be some reason
> > why Peter Zijlstra didn't suggest it when he instead suggested using
> > the IRQ work approach.
> > 
> > Peter, thoughts?
> 
> I've not exactly kept up with the thread; but irq_work allows you to run
> some actual code on the remote CPU which is often useful and it is only
> a little more expensive than smp_send_reschedule().
> 
> Also, just smp_send_reschedule() doesn't really do anything without
> first poking TIF_NEED_RESCHED (or other scheduler state) and if you want
> to do both, there's other helpers you should use, like resched_cpu().

Thank you!  Plus it looks like scheduler_ipi() takes an early exit if
->wake_list is empty, regardless of TIF_NEED_RESCHED, right?

							Thanx, Paul

