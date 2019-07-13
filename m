Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF82C742A7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 14:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C28D720830
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 14:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfGMOTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 10:19:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30726 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727504AbfGMOTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 10:19:36 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6DEHvId021437;
        Sat, 13 Jul 2019 10:18:54 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tq86bm8ft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 13 Jul 2019 10:18:53 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x6DEIrwh023291;
        Sat, 13 Jul 2019 10:18:53 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tq86bm8fk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 13 Jul 2019 10:18:53 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x6DEErnG020195;
        Sat, 13 Jul 2019 14:18:52 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma01dal.us.ibm.com with ESMTP id 2tq6x62vmk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 13 Jul 2019 14:18:52 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6DEIpjY46661898
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Jul 2019 14:18:51 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 387EDB2065;
        Sat, 13 Jul 2019 14:18:51 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00F2AB2064;
        Sat, 13 Jul 2019 14:18:50 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.158.189])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 13 Jul 2019 14:18:50 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id ABD1116C8E80; Sat, 13 Jul 2019 07:18:50 -0700 (PDT)
Date:   Sat, 13 Jul 2019 07:18:50 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Byungchul Park <byungchul.park@lge.com>,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        kernel-team@android.com
Subject: Re: [PATCH] rcuperf: Make rcuperf kernel test more robust for
 !expedited mode
Message-ID: <20190713141850.GC26519@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190704043431.208689-1-joel@joelfernandes.org>
 <20190704174044.GK26519@linux.ibm.com>
 <20190705035231.GA31088@X58A-UD3R>
 <20190705122450.GA82532@google.com>
 <20190705150932.GO26519@linux.ibm.com>
 <20190705200003.GB134527@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705200003.GB134527@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-13_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907130175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 05, 2019 at 04:00:03PM -0400, Joel Fernandes wrote:
> On Fri, Jul 05, 2019 at 08:09:32AM -0700, Paul E. McKenney wrote:
> > On Fri, Jul 05, 2019 at 08:24:50AM -0400, Joel Fernandes wrote:
> > > On Fri, Jul 05, 2019 at 12:52:31PM +0900, Byungchul Park wrote:
> > > > On Thu, Jul 04, 2019 at 10:40:44AM -0700, Paul E. McKenney wrote:
> > > > > On Thu, Jul 04, 2019 at 12:34:30AM -0400, Joel Fernandes (Google) wrote:
> > > > > > It is possible that the rcuperf kernel test runs concurrently with init
> > > > > > starting up.  During this time, the system is running all grace periods
> > > > > > as expedited.  However, rcuperf can also be run for normal GP tests.
> > > > > > Right now, it depends on a holdoff time before starting the test to
> > > > > > ensure grace periods start later. This works fine with the default
> > > > > > holdoff time however it is not robust in situations where init takes
> > > > > > greater than the holdoff time to finish running. Or, as in my case:
> > > > > > 
> > > > > > I modified the rcuperf test locally to also run a thread that did
> > > > > > preempt disable/enable in a loop. This had the effect of slowing down
> > > > > > init. The end result was that the "batches:" counter in rcuperf was 0
> > > > > > causing a division by 0 error in the results. This counter was 0 because
> > > > > > only expedited GPs seem to happen, not normal ones which led to the
> > > > > > rcu_state.gp_seq counter remaining constant across grace periods which
> > > > > > unexpectedly happen to be expedited. The system was running expedited
> > > > > > RCU all the time because rcu_unexpedited_gp() would not have run yet
> > > > > > from init.  In other words, the test would concurrently with init
> > > > > > booting in expedited GP mode.
> > > > > > 
> > > > > > To fix this properly, let us check if system_state if SYSTEM_RUNNING
> > > > > > is set before starting the test. The system_state approximately aligns
> > > > 
> > > > Just minor typo..
> > > > 
> > > > To fix this properly, let us check if system_state if SYSTEM_RUNNING
> > > > is set before starting the test. ...
> > > > 
> > > > Should be
> > > > 
> > > > To fix this properly, let us check if system_state is set to
> > > > SYSTEM_RUNNING before starting the test. ...
> > > 
> > > That's a fair point. I wonder if Paul already fixed it up in his tree,
> > > however I am happy to resend if he hasn't. Paul, how would you like to handle
> > > this commit log nit?
> > > 
> > > it is just 'if ..' to 'is SYSTEM_RUNNING'
> > 
> > It now reads as follows:
> > 
> > 	To fix this properly, this commit waits until system_state is
> > 	set to SYSTEM_RUNNING before starting the test.  This change is
> > 	made just before kernel_init() invokes rcu_end_inkernel_boot(),
> > 	and this latter is what turns off boot-time expediting of RCU
> > 	grace periods.
> 
> Ok, looks good to me, thanks.
> 
> And for below patch,
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Applied, thank you!

							Thnax, Paul

> > I dropped the last paragraph about late_initcall().  And I suspect that
> > the last clause from rcu_gp_is_expedited() can be dropped:
> > 
> > bool rcu_gp_is_expedited(void)
> > {
> > 	return rcu_expedited || atomic_read(&rcu_expedited_nesting) ||
> > 	       rcu_scheduler_active == RCU_SCHEDULER_INIT;
> > }
> > 
> > This is because rcu_expedited_nesting is initialized to 1, and is
> > decremented in rcu_end_inkernel_boot(), which is called long after
> > rcu_scheduler_active has been set to RCU_SCHEDULER_RUNNING, which
> > happens at core_initcall() time.  So if the last clause says "true",
> > so does the second-to-last clause.
> > 
> > The similar check in rcu_gp_is_normal() is still need, however, to allow
> > the power-management subsystem to invoke synchronize_rcu() just after
> > the scheduler has been initialized, but before RCU is aware of this.
> > 
> > So, how about the commit shown below?
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit 1f7e72efe3c761c2b34da7b59e01ad69c657db10
> > Author: Paul E. McKenney <paulmck@linux.ibm.com>
> > Date:   Fri Jul 5 08:05:10 2019 -0700
> > 
> >     rcu: Remove redundant "if" condition from rcu_gp_is_expedited()
> >     
> >     Because rcu_expedited_nesting is initialized to 1 and not decremented
> >     until just before init is spawned, rcu_expedited_nesting is guaranteed
> >     to be non-zero whenever rcu_scheduler_active == RCU_SCHEDULER_INIT.
> >     This commit therefore removes this redundant "if" equality test.
> >     
> >     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > 
> > diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> > index 249517058b13..64e9cc8609e7 100644
> > --- a/kernel/rcu/update.c
> > +++ b/kernel/rcu/update.c
> > @@ -136,8 +136,7 @@ static atomic_t rcu_expedited_nesting = ATOMIC_INIT(1);
> >   */
> >  bool rcu_gp_is_expedited(void)
> >  {
> > -	return rcu_expedited || atomic_read(&rcu_expedited_nesting) ||
> > -	       rcu_scheduler_active == RCU_SCHEDULER_INIT;
> > +	return rcu_expedited || atomic_read(&rcu_expedited_nesting);
> >  }
> >  EXPORT_SYMBOL_GPL(rcu_gp_is_expedited);
> >  
> > 
> 
