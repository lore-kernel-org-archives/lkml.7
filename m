Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38CEC0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 17:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD125218A3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 17:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfGDRl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 13:41:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31160 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726120AbfGDRl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 13:41:27 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x64HbXPZ112546;
        Thu, 4 Jul 2019 13:40:46 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2thku24be1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Jul 2019 13:40:46 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x64HboBk113564;
        Thu, 4 Jul 2019 13:40:45 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2thku24bdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Jul 2019 13:40:45 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x64HXabT001148;
        Thu, 4 Jul 2019 17:40:45 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03dal.us.ibm.com with ESMTP id 2tdym7ektc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Jul 2019 17:40:45 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x64HeiJr49086918
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Jul 2019 17:40:44 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4BB1AB2066;
        Thu,  4 Jul 2019 17:40:44 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2AE84B205F;
        Thu,  4 Jul 2019 17:40:44 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.225.224])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  4 Jul 2019 17:40:44 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D9D3B16C8EB0; Thu,  4 Jul 2019 10:40:44 -0700 (PDT)
Date:   Thu, 4 Jul 2019 10:40:44 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        kernel-team@android.com
Subject: Re: [PATCH] rcuperf: Make rcuperf kernel test more robust for
 !expedited mode
Message-ID: <20190704174044.GK26519@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190704043431.208689-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704043431.208689-1-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-04_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907040225
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 12:34:30AM -0400, Joel Fernandes (Google) wrote:
> It is possible that the rcuperf kernel test runs concurrently with init
> starting up.  During this time, the system is running all grace periods
> as expedited.  However, rcuperf can also be run for normal GP tests.
> Right now, it depends on a holdoff time before starting the test to
> ensure grace periods start later. This works fine with the default
> holdoff time however it is not robust in situations where init takes
> greater than the holdoff time to finish running. Or, as in my case:
> 
> I modified the rcuperf test locally to also run a thread that did
> preempt disable/enable in a loop. This had the effect of slowing down
> init. The end result was that the "batches:" counter in rcuperf was 0
> causing a division by 0 error in the results. This counter was 0 because
> only expedited GPs seem to happen, not normal ones which led to the
> rcu_state.gp_seq counter remaining constant across grace periods which
> unexpectedly happen to be expedited. The system was running expedited
> RCU all the time because rcu_unexpedited_gp() would not have run yet
> from init.  In other words, the test would concurrently with init
> booting in expedited GP mode.
> 
> To fix this properly, let us check if system_state if SYSTEM_RUNNING
> is set before starting the test. The system_state approximately aligns
> with when rcu_unexpedited_gp() is called and works well in practice.
> 
> I also tried late_initcall however it is still too early to be
> meaningful for this case.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Good catch, queued, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/rcuperf.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
> index 4513807cd4c4..5a879d073c1c 100644
> --- a/kernel/rcu/rcuperf.c
> +++ b/kernel/rcu/rcuperf.c
> @@ -375,6 +375,14 @@ rcu_perf_writer(void *arg)
>  	if (holdoff)
>  		schedule_timeout_uninterruptible(holdoff * HZ);
>  
> +	/*
> +	 * Wait until rcu_end_inkernel_boot() is called for normal GP tests
> +	 * so that RCU is not always expedited for normal GP tests.
> +	 * The system_state test is approximate, but works well in practice.
> +	 */
> +	while (!gp_exp && system_state != SYSTEM_RUNNING)
> +		schedule_timeout_uninterruptible(1);
> +
>  	t = ktime_get_mono_fast_ns();
>  	if (atomic_inc_return(&n_rcu_perf_writer_started) >= nrealwriters) {
>  		t_rcu_perf_writer_started = t;
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 
