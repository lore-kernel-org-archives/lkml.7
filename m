Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02719C32756
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 23:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47BA20820
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 23:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfHKXfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 19:35:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61676 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725730AbfHKXfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 19:35:47 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7BNVhHA135977;
        Sun, 11 Aug 2019 19:35:03 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uatghk9x5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 11 Aug 2019 19:35:03 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7BNZ37A143945;
        Sun, 11 Aug 2019 19:35:03 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uatghk9ws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 11 Aug 2019 19:35:03 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7BNTmnU027667;
        Sun, 11 Aug 2019 23:35:02 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04dal.us.ibm.com with ESMTP id 2u9nj6b7p7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 11 Aug 2019 23:35:02 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7BNZ1J128967272
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 11 Aug 2019 23:35:01 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C2F7B2066;
        Sun, 11 Aug 2019 23:35:01 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55A84B205F;
        Sun, 11 Aug 2019 23:35:01 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.138.198])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 11 Aug 2019 23:35:01 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 26D9416C1B1A; Sun, 11 Aug 2019 16:35:04 -0700 (PDT)
Date:   Sun, 11 Aug 2019 16:35:04 -0700
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
Message-ID: <20190811233504.GA28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190806212041.118146-1-joel@joelfernandes.org>
 <20190806235631.GU28441@linux.ibm.com>
 <20190807094504.GB169551@google.com>
 <20190807175215.GE28441@linux.ibm.com>
 <20190810024232.GA183658@google.com>
 <20190810033814.GP28441@linux.ibm.com>
 <20190810042037.GA175783@google.com>
 <20190810182446.GT28441@linux.ibm.com>
 <20190811022658.GA177703@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811022658.GA177703@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-11_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908110263
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 10, 2019 at 10:26:58PM -0400, Joel Fernandes wrote:
> On Sat, Aug 10, 2019 at 11:24:46AM -0700, Paul E. McKenney wrote:
> > On Sat, Aug 10, 2019 at 12:20:37AM -0400, Joel Fernandes wrote:
> > > On Fri, Aug 09, 2019 at 08:38:14PM -0700, Paul E. McKenney wrote:
> > > > On Fri, Aug 09, 2019 at 10:42:32PM -0400, Joel Fernandes wrote:
> > > > > On Wed, Aug 07, 2019 at 10:52:15AM -0700, Paul E. McKenney wrote:
> > > > > [snip] 
> > > > > > > > > @@ -3459,6 +3645,8 @@ void __init rcu_init(void)
> > > > > > > > >  {
> > > > > > > > >  	int cpu;
> > > > > > > > >  
> > > > > > > > > +	kfree_rcu_batch_init();
> > > > > > > > 
> > > > > > > > What happens if someone does a kfree_rcu() before this point?  It looks
> > > > > > > > like it should work, but have you tested it?
> > > > > > > > 
> > > > > > > > >  	rcu_early_boot_tests();
> > > > > > > > 
> > > > > > > > For example, by testing it in rcu_early_boot_tests() and moving the
> > > > > > > > call to kfree_rcu_batch_init() here.
> > > > > > > 
> > > > > > > I have not tried to do the kfree_rcu() this early. I will try it out.
> > > > > > 
> > > > > > Yeah, well, call_rcu() this early came as a surprise to me back in the
> > > > > > day, so...  ;-)
> > > > > 
> > > > > I actually did get surprised as well!
> > > > > 
> > > > > It appears the timers are not fully initialized so the really early
> > > > > kfree_rcu() call from rcu_init() does cause a splat about an initialized
> > > > > timer spinlock (even though future kfree_rcu()s and the system are working
> > > > > fine all the way into the torture tests).
> > > > > 
> > > > > I think to resolve this, we can just not do batching until early_initcall,
> > > > > during which I have an initialization function which switches batching on.
> > > > > >From that point it is safe.
> > > > 
> > > > Just go ahead and batch, but don't bother with the timer until
> > > > after single-threaded boot is done.  For example, you could check
> > > > rcu_scheduler_active similar to how sync_rcu_exp_select_cpus() does.
> > > > (See kernel/rcu/tree_exp.h.)
> > > 
> > > Cool, that works nicely and I tested it. Actually I made it such that we
> > > don't need to batch even, before the scheduler is up. I don't see any benefit
> > > of that unless we can see a kfree_rcu() flood happening that early at boot
> > > which seems highly doubtful as a real world case.
> > 
> > The benefit is removing the kfree_rcu() special cases from the innards
> > of RCU, for example, in rcu_do_batch().  Another benefit is removing the
> > current restriction on the position of the rcu_head structure within the
> > enclosing data structure.
> > 
> > So it would be good to avoid the current kfree_rcu() special casing within
> > RCU itself.
> > 
> > Or are you using some trick that avoids both the batching and the current
> > kfree_rcu() special casing?
> 
> Oh. I see what you mean. Would it be Ok with you to have that be a follow up
> patch?  I am not getting rid (yet) of the special casing in rcu_do_batch in
> this patch, but can do that in another patch.

I am OK having that in another patch, and I will be looking over yours
and Byungchul's two patches tomorrow.  If they look OK, I will queue them.

However, I won't send them upstream without a follow-on patch that gets
rid of the kfree_rcu() special casing within rcu_do_batch() and perhaps
elsewhere.  This follow-on patch would of course also need to change rcuperf
appropriately.

> For now I am just doing something like the following in kfree_call_rcu(). I
> was almost about to hit send on the v1 and I have been testing this a lot so
> I'll post it anyway; and we can discuss more about this point on that.
> 
> +void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> +{
> +       unsigned long flags;
> +       struct kfree_rcu_cpu *krcp;
> +       bool monitor_todo;
> +
> +       /* kfree_call_rcu() batching requires timers to be up. If the scheduler
> +        * is not yet up, just skip batching and do non-batched kfree_call_rcu().
> +        */
> +       if (rcu_scheduler_active != RCU_SCHEDULER_RUNNING)
> +               return kfree_call_rcu_nobatch(head, func);
> +

As a stopgap until the follow-on patch, this looks fine.

							Thanx, Paul
