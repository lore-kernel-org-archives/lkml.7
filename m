Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB348C3A5A4
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 21:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F3B122DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 21:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567027914;
	bh=DE5xcRtBhcPwIIVyo+yqSvWgeO3PywztY8NlSsooot4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=LVKhREJ2xkyc4BY4zf2OR8Mzj/To2yUtFIJ3mhgN4WSF+6irHAxKlT4BwmLbK7hkc
	 fyIuC6exGoHfbSU8hFdJLW4ad4In1BNdDgAEuWdlZDkHaBCbcRjvqmpENeyeGcu2ZC
	 vo5N/wz0V7LqMgyC+UnSwuedU3mvO9HZr6GGihek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfH1Vbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 17:31:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23380 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726658AbfH1Vbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 17:31:53 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7SLMBHm024778;
        Wed, 28 Aug 2019 17:31:19 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2up054ahyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 17:31:19 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7SLOkd7030269;
        Wed, 28 Aug 2019 17:31:19 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2up054ahyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 17:31:19 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7SLP3D1023602;
        Wed, 28 Aug 2019 21:31:18 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03wdc.us.ibm.com with ESMTP id 2ujvv6rcdt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 21:31:18 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7SLVId327656598
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 21:31:18 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08C15B2064;
        Wed, 28 Aug 2019 21:31:18 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDEDFB205F;
        Wed, 28 Aug 2019 21:31:17 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 28 Aug 2019 21:31:17 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B037E16C65BD; Wed, 28 Aug 2019 14:31:19 -0700 (PDT)
Date:   Wed, 28 Aug 2019 14:31:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, byungchul.park@lge.com,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        kernel-team@android.com
Subject: Re: [PATCH 3/5] rcu/tree: Add support for debug_objects debugging
 for kfree_rcu()
Message-ID: <20190828213119.GY26530@linux.ibm.com>
Reply-To: paulmck@kernel.org
References: <5d657e37.1c69fb81.54250.01df@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d657e37.1c69fb81.54250.01df@mx.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-28_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908280207
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 03:01:57PM -0400, Joel Fernandes (Google) wrote:
> Make use of RCU's debug_objects debugging support
> (CONFIG_DEBUG_OBJECTS_RCU_HEAD) similar to call_rcu() and other flavors.

Other flavors?  Ah, call_srcu(), rcu_barrier(), and srcu_barrier(),
right?

> We queue the object during the kfree_rcu() call and dequeue it during
> reclaim.
> 
> Tested that enabling CONFIG_DEBUG_OBJECTS_RCU_HEAD successfully detects
> double kfree_rcu() calls.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

The code looks good!

							Thanx, Paul

> ---
>  kernel/rcu/tree.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 9b9ae4db1c2d..64568f12641d 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2757,6 +2757,7 @@ static void kfree_rcu_work(struct work_struct *work)
>  	for (; head; head = next) {
>  		next = head->next;
>  		/* Could be possible to optimize with kfree_bulk in future */
> +		debug_rcu_head_unqueue(head);
>  		__rcu_reclaim(rcu_state.name, head);
>  		cond_resched_tasks_rcu_qs();
>  	}
> @@ -2868,6 +2869,13 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  	if (rcu_scheduler_active != RCU_SCHEDULER_RUNNING)
>  		return kfree_call_rcu_nobatch(head, func);
>  
> +	if (debug_rcu_head_queue(head)) {
> +		/* Probable double kfree_rcu() */
> +		WARN_ONCE(1, "kfree_call_rcu(): Double-freed call. rcu_head %p\n",
> +			  head);
> +		return;
> +	}
> +
>  	head->func = func;
>  
>  	local_irq_save(flags);	/* For safely calling this_cpu_ptr(). */
> -- 
> 2.23.0.187.g17f5b7556c-goog
> 
