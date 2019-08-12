Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AE8C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39B1B206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfHLOoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 10:44:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28552 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726909AbfHLOoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:44:38 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7CEggWA187887;
        Mon, 12 Aug 2019 10:44:01 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ub95cjtfe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Aug 2019 10:44:01 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7CEghGY187992;
        Mon, 12 Aug 2019 10:44:00 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ub95cjtex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Aug 2019 10:44:00 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7CEenRA019573;
        Mon, 12 Aug 2019 14:43:59 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma02dal.us.ibm.com with ESMTP id 2u9nj62a95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Aug 2019 14:43:59 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7CEhwNd42336682
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Aug 2019 14:43:58 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7EC12B2068;
        Mon, 12 Aug 2019 14:43:58 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51270B205F;
        Mon, 12 Aug 2019 14:43:58 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 12 Aug 2019 14:43:58 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 0392016C1B1A; Mon, 12 Aug 2019 07:44:01 -0700 (PDT)
Date:   Mon, 12 Aug 2019 07:44:01 -0700
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
Message-ID: <20190812144401.GG28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190806235631.GU28441@linux.ibm.com>
 <20190807094504.GB169551@google.com>
 <20190807175215.GE28441@linux.ibm.com>
 <20190810024232.GA183658@google.com>
 <20190810033814.GP28441@linux.ibm.com>
 <20190810042037.GA175783@google.com>
 <20190810182446.GT28441@linux.ibm.com>
 <20190811022658.GA177703@google.com>
 <20190811233504.GA28441@linux.ibm.com>
 <20190812131356.GD27552@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812131356.GD27552@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-12_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908120165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 09:13:56AM -0400, Joel Fernandes wrote:
> On Sun, Aug 11, 2019 at 04:35:04PM -0700, Paul E. McKenney wrote:
> > On Sat, Aug 10, 2019 at 10:26:58PM -0400, Joel Fernandes wrote:
> > > On Sat, Aug 10, 2019 at 11:24:46AM -0700, Paul E. McKenney wrote:
> > > > On Sat, Aug 10, 2019 at 12:20:37AM -0400, Joel Fernandes wrote:
> > > > > On Fri, Aug 09, 2019 at 08:38:14PM -0700, Paul E. McKenney wrote:
> > > > > > On Fri, Aug 09, 2019 at 10:42:32PM -0400, Joel Fernandes wrote:
> > > > > > > On Wed, Aug 07, 2019 at 10:52:15AM -0700, Paul E. McKenney wrote:
> > > > > > > [snip] 
> > > > > > > > > > > @@ -3459,6 +3645,8 @@ void __init rcu_init(void)
> > > > > > > > > > >  {
> > > > > > > > > > >  	int cpu;
> > > > > > > > > > >  
> > > > > > > > > > > +	kfree_rcu_batch_init();
> > > > > > > > > > 
> > > > > > > > > > What happens if someone does a kfree_rcu() before this point?  It looks
> > > > > > > > > > like it should work, but have you tested it?
> > > > > > > > > > 
> > > > > > > > > > >  	rcu_early_boot_tests();
> > > > > > > > > > 
> > > > > > > > > > For example, by testing it in rcu_early_boot_tests() and moving the
> > > > > > > > > > call to kfree_rcu_batch_init() here.
> > > > > > > > > 
> > > > > > > > > I have not tried to do the kfree_rcu() this early. I will try it out.
> > > > > > > > 
> > > > > > > > Yeah, well, call_rcu() this early came as a surprise to me back in the
> > > > > > > > day, so...  ;-)
> > > > > > > 
> > > > > > > I actually did get surprised as well!
> > > > > > > 
> > > > > > > It appears the timers are not fully initialized so the really early
> > > > > > > kfree_rcu() call from rcu_init() does cause a splat about an initialized
> > > > > > > timer spinlock (even though future kfree_rcu()s and the system are working
> > > > > > > fine all the way into the torture tests).
> > > > > > > 
> > > > > > > I think to resolve this, we can just not do batching until early_initcall,
> > > > > > > during which I have an initialization function which switches batching on.
> > > > > > > >From that point it is safe.
> > > > > > 
> > > > > > Just go ahead and batch, but don't bother with the timer until
> > > > > > after single-threaded boot is done.  For example, you could check
> > > > > > rcu_scheduler_active similar to how sync_rcu_exp_select_cpus() does.
> > > > > > (See kernel/rcu/tree_exp.h.)
> > > > > 
> > > > > Cool, that works nicely and I tested it. Actually I made it such that we
> > > > > don't need to batch even, before the scheduler is up. I don't see any benefit
> > > > > of that unless we can see a kfree_rcu() flood happening that early at boot
> > > > > which seems highly doubtful as a real world case.
> > > > 
> > > > The benefit is removing the kfree_rcu() special cases from the innards
> > > > of RCU, for example, in rcu_do_batch().  Another benefit is removing the
> > > > current restriction on the position of the rcu_head structure within the
> > > > enclosing data structure.
> > > > 
> > > > So it would be good to avoid the current kfree_rcu() special casing within
> > > > RCU itself.
> > > > 
> > > > Or are you using some trick that avoids both the batching and the current
> > > > kfree_rcu() special casing?
> > > 
> > > Oh. I see what you mean. Would it be Ok with you to have that be a follow up
> > > patch?  I am not getting rid (yet) of the special casing in rcu_do_batch in
> > > this patch, but can do that in another patch.
> > 
> > I am OK having that in another patch, and I will be looking over yours
> > and Byungchul's two patches tomorrow.  If they look OK, I will queue them.
> 
> Ok, some of the code comments are stale as Byungchul pointed, allow me to fix
> them and then you can look at v3 directly, to save you the time.

Works for me, thank you!

							Thanx, Paul

> > However, I won't send them upstream without a follow-on patch that gets
> > rid of the kfree_rcu() special casing within rcu_do_batch() and perhaps
> > elsewhere.  This follow-on patch would of course also need to change rcuperf
> > appropriately.
> 
> Sounds good.
> 
> > > For now I am just doing something like the following in kfree_call_rcu(). I
> > > was almost about to hit send on the v1 and I have been testing this a lot so
> > > I'll post it anyway; and we can discuss more about this point on that.
> > > 
> > > +void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > > +{
> > > +       unsigned long flags;
> > > +       struct kfree_rcu_cpu *krcp;
> > > +       bool monitor_todo;
> > > +
> > > +       /* kfree_call_rcu() batching requires timers to be up. If the scheduler
> > > +        * is not yet up, just skip batching and do non-batched kfree_call_rcu().
> > > +        */
> > > +       if (rcu_scheduler_active != RCU_SCHEDULER_RUNNING)
> > > +               return kfree_call_rcu_nobatch(head, func);
> > > +
> > 
> > As a stopgap until the follow-on patch, this looks fine.
> 
> Cool, thanks!
> 
> - Joel
> 
