Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E8EC76195
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 13:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D2E621738
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 13:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfGUNT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 09:19:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:65148 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726275AbfGUNT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 09:19:56 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6LDIF5r092645;
        Sun, 21 Jul 2019 09:18:21 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tvg6x6psa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 Jul 2019 09:18:21 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x6LDIKVc093137;
        Sun, 21 Jul 2019 09:18:20 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tvg6x6pfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 Jul 2019 09:18:20 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x6LDEVKf018818;
        Sun, 21 Jul 2019 13:17:27 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01dal.us.ibm.com with ESMTP id 2tutk68tdb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 Jul 2019 13:17:27 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6LDHQsY32047514
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 21 Jul 2019 13:17:26 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E7A6B2066;
        Sun, 21 Jul 2019 13:17:26 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D093AB205F;
        Sun, 21 Jul 2019 13:17:25 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.189.166])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 21 Jul 2019 13:17:25 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A423316C265B; Sun, 21 Jul 2019 06:17:25 -0700 (PDT)
Date:   Sun, 21 Jul 2019 06:17:25 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     aarcange@redhat.com, akpm@linux-foundation.org,
        christian@brauner.io, davem@davemloft.net, ebiederm@xmission.com,
        elena.reshetova@intel.com, guro@fb.com, hch@infradead.org,
        james.bottomley@hansenpartnership.com, jasowang@redhat.com,
        jglisse@redhat.com, keescook@chromium.org, ldv@altlinux.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-parisc@vger.kernel.org,
        luto@amacapital.net, mhocko@suse.com, mingo@kernel.org,
        namit@vmware.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        wad@chromium.org
Subject: Re: RFC: call_rcu_outstanding (was Re: WARNING in __mmdrop)
Message-ID: <20190721131725.GR14271@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <0000000000008dd6bb058e006938@google.com>
 <000000000000964b0d058e1a0483@google.com>
 <20190721044615-mutt-send-email-mst@kernel.org>
 <20190721081933-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190721081933-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-21_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907210161
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2019 at 08:28:05AM -0400, Michael S. Tsirkin wrote:
> Hi Paul, others,
> 
> So it seems that vhost needs to call kfree_rcu from an ioctl. My worry
> is what happens if userspace starts cycling through lots of these
> ioctls.  Given we actually use rcu as an optimization, we could just
> disable the optimization temporarily - but the question would be how to
> detect an excessive rate without working too hard :) .
> 
> I guess we could define as excessive any rate where callback is
> outstanding at the time when new structure is allocated.  I have very
> little understanding of rcu internals - so I wanted to check that the
> following more or less implements this heuristic before I spend time
> actually testing it.
> 
> Could others pls take a look and let me know?

These look good as a way of seeing if there are any outstanding callbacks,
but in the case of Tree RCU, call_rcu_outstanding() would almost never
return false on a busy system.

Here are some alternatives:

o	RCU uses some pieces of Rao Shoaib kfree_rcu() patches.
	The idea is to make kfree_rcu() locally buffer requests into
	batches of (say) 1,000, but processing smaller batches when RCU
	is idle, or when some smallish amout of time has passed with
	no more kfree_rcu() request from that CPU.  RCU than takes in
	the batch using not call_rcu(), but rather queue_rcu_work().
	The resulting batch of kfree() calls would therefore execute in
	workqueue context rather than in softirq context, which should
	be much easier on the system.

	In theory, this would allow people to use kfree_rcu() without
	worrying quite so much about overload.  It would also not be
	that hard to implement.

o	Subsystems vulnerable to user-induced kfree_rcu() flooding use
	call_rcu() instead of kfree_rcu().  Keep a count of the number
	of things waiting for a grace period, and when this gets too
	large, disable the optimization.  It will then drain down, at
	which point the optimization can be re-enabled.

	But please note that callbacks are -not- guaranteed to run on
	the CPU that queued them.  So yes, you would need a per-CPU
	counter, but you would need to periodically sum it up to check
	against the global state.  Or keep track of the CPU that
	did the call_rcu() so that you can atomically decrement in
	the callback the same counter that was atomically incremented
	just before the call_rcu().  Or any number of other approaches.

Also, the overhead is important.  For example, as far as I know,
current RCU gracefully handles close(open(...)) in a tight userspace
loop.  But there might be trouble due to tight userspace loops around
lighter-weight operations.

So an important question is "Just how fast is your ioctl?"  If it takes
(say) 100 microseconds to execute, there should be absolutely no problem.
On the other hand, if it can execute in 50 nanoseconds, this very likely
does need serious attention.

Other thoughts?

							Thanx, Paul

> Thanks!
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> 
> diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> index 477b4eb44af5..067909521d72 100644
> --- a/kernel/rcu/tiny.c
> +++ b/kernel/rcu/tiny.c
> @@ -125,6 +125,25 @@ void synchronize_rcu(void)
>  }
>  EXPORT_SYMBOL_GPL(synchronize_rcu);
> 
> +/*
> + * Helpful for rate-limiting kfree_rcu/call_rcu callbacks.
> + */
> +bool call_rcu_outstanding(void)
> +{
> +	unsigned long flags;
> +	struct rcu_data *rdp;
> +	bool outstanding;
> +
> +	local_irq_save(flags);
> +	rdp = this_cpu_ptr(&rcu_data);
> +	outstanding = rcu_segcblist_empty(&rdp->cblist);
> +	outstanding = rcu_ctrlblk.donetail != rcu_ctrlblk.curtail;
> +	local_irq_restore(flags);
> +
> +	return outstanding;
> +}
> +EXPORT_SYMBOL_GPL(call_rcu_outstanding);
> +
>  /*
>   * Post an RCU callback to be invoked after the end of an RCU grace
>   * period.  But since we have but one CPU, that would be after any
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index a14e5fbbea46..d4b9d61e637d 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2482,6 +2482,24 @@ static void rcu_leak_callback(struct rcu_head *rhp)
>  {
>  }
> 
> +/*
> + * Helpful for rate-limiting kfree_rcu/call_rcu callbacks.
> + */
> +bool call_rcu_outstanding(void)
> +{
> +	unsigned long flags;
> +	struct rcu_data *rdp;
> +	bool outstanding;
> +
> +	local_irq_save(flags);
> +	rdp = this_cpu_ptr(&rcu_data);
> +	outstanding = rcu_segcblist_empty(&rdp->cblist);
> +	local_irq_restore(flags);
> +
> +	return outstanding;
> +}
> +EXPORT_SYMBOL_GPL(call_rcu_outstanding);
> +
>  /*
>   * Helper function for call_rcu() and friends.  The cpu argument will
>   * normally be -1, indicating "currently running CPU".  It may specify
