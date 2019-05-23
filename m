Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E01C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 13:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF9721773
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 13:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730824AbfEWNwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 09:52:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47892 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730323AbfEWNwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 09:52:17 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4NDn21n121341;
        Thu, 23 May 2019 09:51:30 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2snunr3s69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 May 2019 09:51:30 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x4NDn55p121840;
        Thu, 23 May 2019 09:51:29 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2snunr3s5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 May 2019 09:51:29 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x4N7mSO7021521;
        Thu, 23 May 2019 07:56:08 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma01dal.us.ibm.com with ESMTP id 2sn84n1kgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 May 2019 07:56:08 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4NDoCSq23003300
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 May 2019 13:50:12 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E0B0B208A;
        Thu, 23 May 2019 13:50:12 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A045B208B;
        Thu, 23 May 2019 13:50:12 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 23 May 2019 13:50:12 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 985A416C0FB0; Thu, 23 May 2019 06:50:13 -0700 (PDT)
Date:   Thu, 23 May 2019 06:50:13 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH] rcu: Make 'rcu_assign_pointer(p, v)' of type
 'typeof(p)'
Message-ID: <20190523135013.GL28207@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <1558618340-17254-1-git-send-email-andrea.parri@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1558618340-17254-1-git-send-email-andrea.parri@amarulasolutions.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-23_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905230096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 03:32:20PM +0200, Andrea Parri wrote:
> The expression
> 
>   rcu_assign_pointer(p, typeof(p) v)
> 
> is reported to be of type 'typeof(p)' in the documentation (c.f., e.g.,
> Documentation/RCU/whatisRCU.txt) but this is not the case: for example,
> the following snippet
> 
>   int **y;
>   int *x;
>   int *r0;
> 
>   ...
> 
>   r0 = rcu_assign_pointer(*y, x);
> 
> can currently result in the compiler warning
> 
>   warning: assignment to ‘int *’ from ‘uintptr_t’ {aka ‘long unsigned int’} makes pointer from integer without a cast [-Wint-conversion]
> 
> Cast the uintptr_t value to a typeof(p) value.
> 
> Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: rcu@vger.kernel.org
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> ---
> NOTE:
> 
> TBH, I'm not sure this is 'the right patch' (hence the RFC...): in
> fact, I'm currently missing the motivations for allowing assignments
> such as the "r0 = ..." assignment above in generic code.  (BTW, it's
> not currently possible to use such assignments in litmus tests...)

Given that a quick (and perhaps error-prone) search of the uses of
rcu_assign_pointer() in v5.1 didn't find a single use of the return
value, let's please instead change the documentation and implementation
to eliminate the return value.

> The usual concern is, of course, that if something is allowed (read
> 'compile!' ;/) then people will soon or later use it and they'll do
> it in all sorts of 'creative' ways, such as 'to extend dependencies
> across rcu_assign_pointer() calls' as in
> 
>   x = READ_ONCE(*z);
>   r0 = rcu_assign_pointer(*y, x);
>   WRITE_ONCE(*w, r0);
> 
> Notice that using a 'do { ... } while (0)', say, would prevent such
> tricks/rvalues. (The same approach is used by smp_store_release().)

As you in fact suggest here.  ;-)

							Thanx, Paul

> For a related discussion, please see:
> 
>   https://lkml.kernel.org/r/20190523083013.GA4616@andrea
> 
> Thoughts?
> 
>   Andrea
> ---
>  include/linux/rcupdate.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 915460ec08722..b94ba5de78fba 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -375,7 +375,7 @@ static inline void rcu_preempt_sleep_check(void) { }
>  		WRITE_ONCE((p), (typeof(p))(_r_a_p__v));		      \
>  	else								      \
>  		smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
> -	_r_a_p__v;							      \
> +	((typeof(p))_r_a_p__v);						      \
>  })
>  
>  /**
> -- 
> 2.7.4
> 
