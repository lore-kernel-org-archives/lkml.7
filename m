Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AEBC32756
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 18:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6240C208C3
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 18:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbfHJSZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 14:25:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29728 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725862AbfHJSZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 14:25:24 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7AIMFxO072270;
        Sat, 10 Aug 2019 14:24:47 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ua2y0g8w1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 10 Aug 2019 14:24:47 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7AIOlRC076284;
        Sat, 10 Aug 2019 14:24:47 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ua2y0g8vm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 10 Aug 2019 14:24:47 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7AIK5KU019855;
        Sat, 10 Aug 2019 18:24:46 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03dal.us.ibm.com with ESMTP id 2u9nj6btxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 10 Aug 2019 18:24:46 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7AIOjLH27197714
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Aug 2019 18:24:45 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58346B2064;
        Sat, 10 Aug 2019 18:24:45 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 221E7B205F;
        Sat, 10 Aug 2019 18:24:45 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.138.198])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 10 Aug 2019 18:24:45 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 1CC3F16C9A7A; Sat, 10 Aug 2019 11:24:46 -0700 (PDT)
Date:   Sat, 10 Aug 2019 11:24:46 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Rao Shoaib <rao.shoaib@oracle.com>,
        max.byungchul.park@gmail.com, byungchul.park@lge.com,
        kernel-team@android.com, kernel-team@lge.com,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC v1 1/2] rcu/tree: Add basic support for kfree_rcu
 batching
Message-ID: <20190810182446.GT28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190806212041.118146-1-joel@joelfernandes.org>
 <20190806235631.GU28441@linux.ibm.com>
 <20190807094504.GB169551@google.com>
 <20190807175215.GE28441@linux.ibm.com>
 <20190810024232.GA183658@google.com>
 <20190810033814.GP28441@linux.ibm.com>
 <20190810042037.GA175783@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190810042037.GA175783@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-10_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908100204
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 10, 2019 at 12:20:37AM -0400, Joel Fernandes wrote:
> On Fri, Aug 09, 2019 at 08:38:14PM -0700, Paul E. McKenney wrote:
> > On Fri, Aug 09, 2019 at 10:42:32PM -0400, Joel Fernandes wrote:
> > > On Wed, Aug 07, 2019 at 10:52:15AM -0700, Paul E. McKenney wrote:
> > > [snip] 
> > > > > > > @@ -3459,6 +3645,8 @@ void __init rcu_init(void)
> > > > > > >  {
> > > > > > >  	int cpu;
> > > > > > >  
> > > > > > > +	kfree_rcu_batch_init();
> > > > > > 
> > > > > > What happens if someone does a kfree_rcu() before this point?  It looks
> > > > > > like it should work, but have you tested it?
> > > > > > 
> > > > > > >  	rcu_early_boot_tests();
> > > > > > 
> > > > > > For example, by testing it in rcu_early_boot_tests() and moving the
> > > > > > call to kfree_rcu_batch_init() here.
> > > > > 
> > > > > I have not tried to do the kfree_rcu() this early. I will try it out.
> > > > 
> > > > Yeah, well, call_rcu() this early came as a surprise to me back in the
> > > > day, so...  ;-)
> > > 
> > > I actually did get surprised as well!
> > > 
> > > It appears the timers are not fully initialized so the really early
> > > kfree_rcu() call from rcu_init() does cause a splat about an initialized
> > > timer spinlock (even though future kfree_rcu()s and the system are working
> > > fine all the way into the torture tests).
> > > 
> > > I think to resolve this, we can just not do batching until early_initcall,
> > > during which I have an initialization function which switches batching on.
> > > >From that point it is safe.
> > 
> > Just go ahead and batch, but don't bother with the timer until
> > after single-threaded boot is done.  For example, you could check
> > rcu_scheduler_active similar to how sync_rcu_exp_select_cpus() does.
> > (See kernel/rcu/tree_exp.h.)
> 
> Cool, that works nicely and I tested it. Actually I made it such that we
> don't need to batch even, before the scheduler is up. I don't see any benefit
> of that unless we can see a kfree_rcu() flood happening that early at boot
> which seems highly doubtful as a real world case.

The benefit is removing the kfree_rcu() special cases from the innards
of RCU, for example, in rcu_do_batch().  Another benefit is removing the
current restriction on the position of the rcu_head structure within the
enclosing data structure.

So it would be good to avoid the current kfree_rcu() special casing within
RCU itself.

Or are you using some trick that avoids both the batching and the current
kfree_rcu() special casing?

> > If needed, use an early_initcall() to handle the case where early boot
> > kfree_rcu() calls needed to set the timer but could not.
> 
> And it would also need this complexity of early_initcall.

It would, but that (1) should not be all that complex, (2) only executes
the one time at boot rather than being an extra check on each callback,
and (3) is in memory that can be reclaimed (though I confess that I am
not sure how many architectures still do this).

> > > Below is the diff on top of this patch, I think this should be good but let
> > > me know if anything looks odd to you. I tested it and it works.
> > 
> > Keep in mind that a call_rcu() callback can't possibly be invoked until
> > quite some time after the scheduler is up and running.  So it will be
> > a lot simpler to just skip setting the timer during early boot.
> 
> Sure. Skipping batching would skip the timer too :-D

Yes, but if I understand your approach correctly, it is unfortunately
not managing to avoid getting rid of the kfree_rcu() special casing.

> If in the future, batching is needed this early, then I am happy to add an
> early_initcall to setup the timer for any batched calls that could not setup
> the timer. Hope that is ok with you?

If you have some trick to nevertheless get rid of the current kfree_rcu()
special casing within RCU proper, sure!

							Thanx, Paul
