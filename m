Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73060C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 13:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E4E620838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 13:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729739AbfHANvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 09:51:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49604 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725930AbfHANvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 09:51:13 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71DcHYt071709;
        Thu, 1 Aug 2019 09:51:05 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u40xq9527-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 09:51:05 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x71DcXuW072724;
        Thu, 1 Aug 2019 09:51:04 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u40xq9515-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 09:51:04 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x71DeMrq020157;
        Thu, 1 Aug 2019 13:51:03 GMT
Received: from b01cxnp22035.gho.pok.ibm.com ([9.57.198.25])
        by ppma01wdc.us.ibm.com with ESMTP id 2u0e86vvxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 13:51:03 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71Dp3eT43057458
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 13:51:03 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AED3DB206A;
        Thu,  1 Aug 2019 13:51:02 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91097B2065;
        Thu,  1 Aug 2019 13:51:02 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 13:51:02 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id AF9B216C998B; Thu,  1 Aug 2019 06:51:03 -0700 (PDT)
Date:   Thu, 1 Aug 2019 06:51:03 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH 2/5] rcu/tree: Fix SCHED_FIFO params
Message-ID: <20190801135103.GI5913@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190801111348.530242235@infradead.org>
 <20190801111541.742613597@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801111541.742613597@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 01:13:50PM +0200, Peter Zijlstra wrote:
> A rather embarrasing mistake had us call sched_setscheduler() before
> initializing the parameters passed to it.
> 
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>

Thank you for having CCed me this time.  ;-)

Reviewed-by: Paul E. McKenney <paulmck@linux.ibm.com>

> Fixes: 1a763fd7c633 ("rcu/tree: Call setschedule() gp ktread to SCHED_FIFO outside of atomic region")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/rcu/tree.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3234,13 +3234,13 @@ static int __init rcu_spawn_gp_kthread(v
>  	t = kthread_create(rcu_gp_kthread, NULL, "%s", rcu_state.name);
>  	if (WARN_ONCE(IS_ERR(t), "%s: Could not start grace-period kthread, OOM is now expected behavior\n", __func__))
>  		return 0;
> -	if (kthread_prio)
> +	if (kthread_prio) {
> +		sp.sched_priority = kthread_prio;
>  		sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
> +	}
>  	rnp = rcu_get_root();
>  	raw_spin_lock_irqsave_rcu_node(rnp, flags);
>  	rcu_state.gp_kthread = t;
> -	if (kthread_prio)
> -		sp.sched_priority = kthread_prio;
>  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  	wake_up_process(t);
>  	rcu_spawn_nocb_kthreads();
> 
> 
