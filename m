Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6C0C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D5D222FC
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389073AbfHGRxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 13:53:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41908 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389042AbfHGRxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 13:53:07 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x77HqOoI028228;
        Wed, 7 Aug 2019 13:52:30 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u824xu8dm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Aug 2019 13:52:29 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x77HqS3D028783;
        Wed, 7 Aug 2019 13:52:28 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u824xu83h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Aug 2019 13:52:28 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x77HoF2R031019;
        Wed, 7 Aug 2019 17:52:15 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma05wdc.us.ibm.com with ESMTP id 2u51w6btsk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Aug 2019 17:52:15 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x77HqE6830605652
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Aug 2019 17:52:14 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3E84B2075;
        Wed,  7 Aug 2019 17:52:14 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DD7BB2074;
        Wed,  7 Aug 2019 17:52:14 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  7 Aug 2019 17:52:14 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 4D51C16C5DA7; Wed,  7 Aug 2019 10:52:15 -0700 (PDT)
Date:   Wed, 7 Aug 2019 10:52:15 -0700
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
Message-ID: <20190807175215.GE28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190806212041.118146-1-joel@joelfernandes.org>
 <20190806235631.GU28441@linux.ibm.com>
 <20190807094504.GB169551@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807094504.GB169551@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-07_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908070168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 05:45:04AM -0400, Joel Fernandes wrote:
> On Tue, Aug 06, 2019 at 04:56:31PM -0700, Paul E. McKenney wrote:
> > On Tue, Aug 06, 2019 at 05:20:40PM -0400, Joel Fernandes (Google) wrote:

[ . . . ]

> > > +	for (; head; head = next) {
> > > +		next = head->next;
> > > +		head->next = NULL;
> > > +		__call_rcu(head, head->func, -1, 1);
> > 
> > We need at least a cond_resched() here.  200,000 times through this loop
> > in a PREEMPT=n kernel might not always be pretty.  Except that this is
> > invoked directly from kfree_rcu() which might be invoked with interrupts
> > disabled, which precludes calls to cond_resched().  So the realtime guys
> > are not going to be at all happy with this loop.
> 
> Ok, will add this here.
> 
> > And this loop could be avoided entirely by having a third rcu_head list
> > in the kfree_rcu_cpu structure.  Yes, some of the batches would exceed
> > KFREE_MAX_BATCH, but given that they are invoked from a workqueue, that
> > should be OK, or at least more OK than queuing 200,000 callbacks with
> > interrupts disabled.  (If it turns out not to be OK, an array of rcu_head
> > pointers can be used to reduce the probability of oversized batches.)
> > This would also mean that the equality comparisons with KFREE_MAX_BATCH
> > need to become greater-or-equal comparisons or some such.
> 
> Yes, certainly we can do these kinds of improvements after this patch, and
> then add more tests to validate the improvements.

Out of pity for people bisecting, we need this fixed up front.

My suggestion is to just allow ->head to grow until ->head_free becomes
available.  That way you are looping with interrupts and preemption
enabled in workqueue context, which is much less damaging than doing so
with interrupts disabled, and possibly even from hard-irq context.

But please feel free to come up with a better solution!

[ . . . ]

> > > @@ -3459,6 +3645,8 @@ void __init rcu_init(void)
> > >  {
> > >  	int cpu;
> > >  
> > > +	kfree_rcu_batch_init();
> > 
> > What happens if someone does a kfree_rcu() before this point?  It looks
> > like it should work, but have you tested it?
> > 
> > >  	rcu_early_boot_tests();
> > 
> > For example, by testing it in rcu_early_boot_tests() and moving the
> > call to kfree_rcu_batch_init() here.
> 
> I have not tried to do the kfree_rcu() this early. I will try it out.

Yeah, well, call_rcu() this early came as a surprise to me back in the
day, so...  ;-)

							Thanx, Paul
