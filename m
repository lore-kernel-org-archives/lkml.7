Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC98BC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 02:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E2822CE8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 02:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbfHTCvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 22:51:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45270 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728669AbfHTCvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 22:51:42 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7K2lo6H070584;
        Mon, 19 Aug 2019 22:50:59 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ug8atg83m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Aug 2019 22:50:58 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7K2lnG8070521;
        Mon, 19 Aug 2019 22:50:58 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ug8atg833-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Aug 2019 22:50:58 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7K2osOc011661;
        Tue, 20 Aug 2019 02:50:57 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01wdc.us.ibm.com with ESMTP id 2ue976h9kt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Aug 2019 02:50:57 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7K2ouma12976806
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Aug 2019 02:50:56 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97E7FB2065;
        Tue, 20 Aug 2019 02:50:56 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62962B205F;
        Tue, 20 Aug 2019 02:50:56 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.233.250])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 20 Aug 2019 02:50:56 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2EA4516C1BB1; Mon, 19 Aug 2019 19:50:56 -0700 (PDT)
Date:   Mon, 19 Aug 2019 19:50:56 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, byungchul.park@lge.com,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        kernel-team@lge.com, Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        max.byungchul.park@gmail.com, Rao Shoaib <rao.shoaib@oracle.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v4 2/2] rcuperf: Add kfree_rcu() performance Tests
Message-ID: <20190820025056.GL28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190814160411.58591-1-joel@joelfernandes.org>
 <20190814160411.58591-2-joel@joelfernandes.org>
 <20190814225850.GZ28441@linux.ibm.com>
 <20190819193327.GF117548@google.com>
 <20190819222330.GH28441@linux.ibm.com>
 <20190819235123.GA185164@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819235123.GA185164@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-20_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908200025
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 07:51:23PM -0400, Joel Fernandes wrote:
> On Mon, Aug 19, 2019 at 03:23:30PM -0700, Paul E. McKenney wrote:
> [snip]
> > > [snip]
> > > > > @@ -592,6 +593,175 @@ rcu_perf_shutdown(void *arg)
> > > > >  	return -EINVAL;
> > > > >  }
> > > > >  
> > > > > +/*
> > > > > + * kfree_rcu performance tests: Start a kfree_rcu loop on all CPUs for number
> > > > > + * of iterations and measure total time and number of GP for all iterations to complete.
> > > > > + */
> > > > > +
> > > > > +torture_param(int, kfree_nthreads, -1, "Number of threads running loops of kfree_rcu().");
> > > > > +torture_param(int, kfree_alloc_num, 8000, "Number of allocations and frees done in an iteration.");
> > > > > +torture_param(int, kfree_loops, 10, "Number of loops doing kfree_alloc_num allocations and frees.");
> > > > > +torture_param(int, kfree_no_batch, 0, "Use the non-batching (slower) version of kfree_rcu.");
> > > > > +
> > > > > +static struct task_struct **kfree_reader_tasks;
> > > > > +static int kfree_nrealthreads;
> > > > > +static atomic_t n_kfree_perf_thread_started;
> > > > > +static atomic_t n_kfree_perf_thread_ended;
> > > > > +
> > > > > +struct kfree_obj {
> > > > > +	char kfree_obj[8];
> > > > > +	struct rcu_head rh;
> > > > > +};
> > > > 
> > > > (Aside from above, no need to change this part of the patch, at least not
> > > > that I know of at the moment.)
> > > > 
> > > > 24 bytes on a 64-bit system, 16 on a 32-bit system.  So there might
> > > > have been 10 million extra objects awaiting free in the batching case
> > > > given the 400M-50M=350M excess for the batching approach.  If freeing
> > > > each object took about 100ns, that could account for the additional
> > > > wall-clock time for the batching approach.
> > > 
> > > Makes sense, and this comes down to 200-220MB range with the additional list.
> > 
> > Which might even match the observed numbers?
> 
> Yes, they would. Since those *are* the observed numbers :-D ;-) ;-)

;-)

> > > > > +	do {
> > > > > +		for (i = 0; i < kfree_alloc_num; i++) {
> > > > > +			alloc_ptrs[i] = kmalloc(sizeof(struct kfree_obj), GFP_KERNEL);
> > > > > +			if (!alloc_ptrs[i])
> > > > > +				return -ENOMEM;
> > > > > +		}
> > > > > +
> > > > > +		for (i = 0; i < kfree_alloc_num; i++) {
> > > > > +			if (!kfree_no_batch) {
> > > > > +				kfree_rcu(alloc_ptrs[i], rh);
> > > > > +			} else {
> > > > > +				rcu_callback_t cb;
> > > > > +
> > > > > +				cb = (rcu_callback_t)(unsigned long)offsetof(struct kfree_obj, rh);
> > > > > +				kfree_call_rcu_nobatch(&(alloc_ptrs[i]->rh), cb);
> > > > > +			}
> > > > > +		}
> > > > 
> > > > The point of allocating a large batch and then kfree_rcu()ing them in a
> > > > loop is to defeat the per-CPU pool optimization?  Either way, a comment
> > > > would be very good!
> > > 
> > > It was a reasoning like this, added it as a comment:
> > > 
> > > 	/* While measuring kfree_rcu() time, we also end up measuring kmalloc()
> > > 	 * time. So the strategy here is to do a few (kfree_alloc_num) number
> > > 	 * of kmalloc() and kfree_rcu() every loop so that the current loop's
> > > 	 * deferred kfree()ing overlaps with the next loop's kmalloc().
> > > 	 */
> > 
> > The thought being that the CPU will be executing the two loops
> > concurrently?  Up to a point, agreed, but how much of an effect is
> > that, really?
> 
> Yes it may not matter much. It was just a small thought when I added the
> loop, I had to start somewhere, so I did it this way.
> 
> > Or is the idea to time the kfree_rcu() loop separately?  (I don't see
> > any such separate timing, though.)
> 
> The kmalloc() times are included within the kfree loop. The timing of
> kfree_rcu() is not separate in my patch.

You lost me on this one.  What happens when you just interleave the
kmalloc() and kfree_rcu(), without looping, compared to the looping
above?  Does this get more expensive?  Cheaper?  More vulnerable to OOM?
Something else?

							Thanx, Paul
