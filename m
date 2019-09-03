Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0D0C3A5A7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A36621883
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567541363;
	bh=2S1ugzrRfUoCQWpMgrCIVBGux1os/vbskHOt0uIeyU4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=OC/qhRa/Of7+LyuDs3Wks6iY2z+UpHkes/YQS23d+RzxeKR9YvVTlTVlU15S0htWQ
	 t23nqbvosSeJ3alOBfDb8kfTiP1W+Ito53bDkztdS8UzptRRN87KagHu2KuO4347Ti
	 eAf4EY2a6U1GZExfPJ4Dxr/l21Xo4JHA8MK5tZWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfICUJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 16:09:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27290 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725882AbfICUJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:09:21 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x83K7haO121886;
        Tue, 3 Sep 2019 16:08:48 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2usx1nsqkr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Sep 2019 16:08:48 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x83K84SE123175;
        Tue, 3 Sep 2019 16:08:47 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2usx1nsqjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Sep 2019 16:08:47 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x83K4l70021669;
        Tue, 3 Sep 2019 20:08:46 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma04dal.us.ibm.com with ESMTP id 2uqgh6svj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Sep 2019 20:08:46 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x83K8jNW13173434
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Sep 2019 20:08:45 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 77DB2B2066;
        Tue,  3 Sep 2019 20:08:45 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 486B3B205F;
        Tue,  3 Sep 2019 20:08:45 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  3 Sep 2019 20:08:45 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 7174B16C1074; Tue,  3 Sep 2019 13:08:49 -0700 (PDT)
Date:   Tue, 3 Sep 2019 13:08:49 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, byungchul.park@lge.com,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/5] rcu/rcuperf: Add kfree_rcu() performance Tests
Message-ID: <20190903200849.GF4125@linux.ibm.com>
Reply-To: paulmck@kernel.org
References: <5d657e33.1c69fb81.54250.01dd@mx.google.com>
 <20190828211226.GW26530@linux.ibm.com>
 <20190829205637.GA162830@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829205637.GA162830@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-03_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909030201
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 04:56:37PM -0400, Joel Fernandes wrote:
> On Wed, Aug 28, 2019 at 02:12:26PM -0700, Paul E. McKenney wrote:

[ . . . ]

> > > +static int
> > > +kfree_perf_thread(void *arg)
> > > +{
> > > +	int i, loop = 0;
> > > +	long me = (long)arg;
> > > +	struct kfree_obj *alloc_ptr;
> > > +	u64 start_time, end_time;
> > > +
> > > +	VERBOSE_PERFOUT_STRING("kfree_perf_thread task started");
> > > +	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
> > > +	set_user_nice(current, MAX_NICE);
> > > +
> > > +	start_time = ktime_get_mono_fast_ns();
> > > +
> > > +	if (atomic_inc_return(&n_kfree_perf_thread_started) >= kfree_nrealthreads) {
> > > +		if (gp_exp)
> > > +			b_rcu_gp_test_started = cur_ops->exp_completed() / 2;
> > 
> > At some point, it would be good to use the new grace-period
> > sequence-counter functions (rcuperf_seq_diff(), for example) instead of
> > the open-coded division by 2.  I freely admit that you are just copying
> > my obsolete hack in this case, so not needed in this patch.
> 
> But I am using rcu_seq_diff() below in the pr_alert().
> 
> Anyway, I agree this can be a follow-on since this pattern is borrowed from
> another part of rcuperf. However, I am also confused about the pattern
> itself.
> 
> If I understand, you are doing the "/ 2" because expedited_sequence
> progresses by 2 for every expedited batch.
> 
> But does rcu_seq_diff() really work on these expedited GP numbers, and will
> it be immune to changes in RCU_SEQ_STATE_MASK? Sorry for the silly questions,
> but admittedly I have not looked too much yet into expedited RCU so I could
> be missing the point.

Yes, expedited grace periods use the common sequence-number functions.
Oddly enough, normal grace periods were the last to make use of these.

> > > +		else
> > > +			b_rcu_gp_test_finished = cur_ops->get_gp_seq();
> > > +
> > > +		pr_alert("Total time taken by all kfree'ers: %llu ns, loops: %d, batches: %ld\n",
> > > +		       (unsigned long long)(end_time - start_time), kfree_loops,
> > > +		       rcuperf_seq_diff(b_rcu_gp_test_finished, b_rcu_gp_test_started));
> > > +		if (shutdown) {
> > > +			smp_mb(); /* Assign before wake. */
> > > +			wake_up(&shutdown_wq);
> > > +		}
> > > +	}
> > > +
> > > +	torture_kthread_stopping("kfree_perf_thread");
> > > +	return 0;
> > > +}
> > > +
> > > +static void
> > > +kfree_perf_cleanup(void)
> > > +{
> > > +	int i;
> > > +
> > > +	if (torture_cleanup_begin())
> > > +		return;
> > > +
> > > +	if (kfree_reader_tasks) {
> > > +		for (i = 0; i < kfree_nrealthreads; i++)
> > > +			torture_stop_kthread(kfree_perf_thread,
> > > +					     kfree_reader_tasks[i]);
> > > +		kfree(kfree_reader_tasks);
> > > +	}
> > > +
> > > +	torture_cleanup_end();
> > > +}
> > > +
> > > +/*
> > > + * shutdown kthread.  Just waits to be awakened, then shuts down system.
> > > + */
> > > +static int
> > > +kfree_perf_shutdown(void *arg)
> > > +{
> > > +	do {
> > > +		wait_event(shutdown_wq,
> > > +			   atomic_read(&n_kfree_perf_thread_ended) >=
> > > +			   kfree_nrealthreads);
> > > +	} while (atomic_read(&n_kfree_perf_thread_ended) < kfree_nrealthreads);
> > > +
> > > +	smp_mb(); /* Wake before output. */
> > > +
> > > +	kfree_perf_cleanup();
> > > +	kernel_power_off();
> > > +	return -EINVAL;
> > 
> > These last four lines should be combined with those of
> > rcu_perf_shutdown().  Actually, you could fold the two functions together
> > with only a pair of arguments and two one-line wrapper functions, which
> > would be even better.
> 
> But the cleanup() function is different in the 2 cases and will have to be
> passed in as a function pointer. I believe we discussed this last review as
> well.

Calling through a pointer should be a non-problem in this case.  We are
nowhere near a fastpath.

							Thanx, Paul
