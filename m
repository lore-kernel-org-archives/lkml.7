Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F94C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D1120700
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfDCQZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:25:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54742 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725990AbfDCQZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:25:59 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x33GMXvD082056
        for <linux-kernel@vger.kernel.org>; Wed, 3 Apr 2019 12:25:58 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rn019h3he-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 12:25:57 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 3 Apr 2019 17:25:57 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 3 Apr 2019 17:25:51 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x33GPoF722347998
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Apr 2019 16:25:50 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0CC8B205F;
        Wed,  3 Apr 2019 16:25:50 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D900B2065;
        Wed,  3 Apr 2019 16:25:50 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.202.55])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  3 Apr 2019 16:25:50 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 602A916C2A41; Wed,  3 Apr 2019 09:25:50 -0700 (PDT)
Date:   Wed, 3 Apr 2019 09:25:50 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH tip/core/rcu 2/2] rcu: Check for wakeup-safe conditions
 in rcu_read_unlock_special()
Reply-To: paulmck@linux.ibm.com
References: <20190329182608.GA23877@linux.ibm.com>
 <20190329182634.24994-2-paulmck@linux.ibm.com>
 <20190401083211.GD11158@hirez.programming.kicks-ass.net>
 <20190401172257.GN4102@linux.ibm.com>
 <20190402070953.GG12232@hirez.programming.kicks-ass.net>
 <20190402131853.GV4102@linux.ibm.com>
 <20190403095046.GD4038@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403095046.GD4038@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19040316-0072-0000-0000-00000414F999
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010867; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01183800; UDB=6.00619789; IPR=6.00964551;
 MB=3.00026279; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-03 16:25:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040316-0073-0000-0000-00004BB2CAF9
Message-Id: <20190403162550.GB14111@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-03_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=818 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904030111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 11:50:46AM +0200, Peter Zijlstra wrote:
> On Tue, Apr 02, 2019 at 06:18:53AM -0700, Paul E. McKenney wrote:
> > On Tue, Apr 02, 2019 at 09:09:53AM +0200, Peter Zijlstra wrote:
> > > On Mon, Apr 01, 2019 at 10:22:57AM -0700, Paul E. McKenney wrote:
> 
> > > > Or am I missing something that gets the scheduler on the job faster?
> > > 
> > > Oh urgh, yah. So normally we only twiddle with the need_resched state:
> > > 
> > >  - while preempt_disabl(), such that preempt_enable() will reschedule
> > >  - from interrupt context, such that interrupt return will reschedule
> > > 
> > > But the usage here 'violates' those rules and then there is an
> > > unspecified latency between setting the state and it getting observed,
> > > but no longer than 1 tick I would think.
> > 
> > In general, yes, which is fine (famous last words) for normal grace
> > periods but not so good for expedited grace periods.
> > 
> > > I don't think we can go NOHZ with need_resched set, because the moment
> > > we hit the idle loop with that set, we _will_ reschedule.
> > 
> > Agreed, and I believe that transitioning to usermode execution also
> > gives the scheduler a chance to take action.
> > 
> > The one exception to this is when a nohz_full CPU running in nohz_full
> > mode does a system call that decides to execute for a very long time.
> > Last I checked, the scheduling-clock interrupt did -not- get retriggered
> > in this case, and the delay could be indefinite, as in bad even for
> > normal grace periods.
> 
> Right, there is that.
> 
> > > So in that respect the irq_work suggestion I made would fix things
> > > properly.
> > 
> > But wouldn't the current use of set_tsk_need_resched(current) followed by
> > set_preempt_need_resched() work just as well in that case?  The scheduler
> > would react to these at the next scheduler-clock interrupt on their
> > own, right?  Or am I being scheduler-naive again?
> 
> Well, you have that unspecified delay. By forcing the (self) interrupt
> you enforce a timely response.

Good point!  I will give this a go, thank you!

							Thanx, Paul

