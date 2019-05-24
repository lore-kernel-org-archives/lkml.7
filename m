Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20C7C282E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 13:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB182217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 13:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403837AbfEXNao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 09:30:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38502 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391359AbfEXNan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 09:30:43 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4ODUZSl139757
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 09:30:42 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2spe8ja8w2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 09:30:38 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 24 May 2019 14:29:15 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 24 May 2019 14:29:11 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4ODTAaQ24707516
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 May 2019 13:29:10 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B02AFB2064;
        Fri, 24 May 2019 13:29:10 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8222EB2065;
        Fri, 24 May 2019 13:29:10 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 24 May 2019 13:29:10 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id BF94316C3609; Fri, 24 May 2019 06:29:11 -0700 (PDT)
Date:   Fri, 24 May 2019 06:29:11 -0700
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
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] rcu: Prevent evaluation of rcu_assign_pointer()
Reply-To: paulmck@linux.ibm.com
References: <1558694197-19295-1-git-send-email-andrea.parri@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558694197-19295-1-git-send-email-andrea.parri@amarulasolutions.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19052413-0052-0000-0000-000003C67251
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011154; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01207923; UDB=6.00634413; IPR=6.00988913;
 MB=3.00027032; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-24 13:29:15
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052413-0053-0000-0000-000061074ABD
Message-Id: <20190524132911.GV28207@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-24_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905240091
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 12:36:37PM +0200, Andrea Parri wrote:
> Quoting Paul [1]:
> 
>  "Given that a quick (and perhaps error-prone) search of the uses
>   of rcu_assign_pointer() in v5.1 didn't find a single use of the
>   return value, let's please instead change the documentation and
>   implementation to eliminate the return value."
> 
> [1] https://lkml.kernel.org/r/20190523135013.GL28207@linux.ibm.com

Thank you!  A few comments below.

							Thanx, Paul

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
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Sasha Levin <sashal@kernel.org>
> ---
> Matthew, Sasha:
> 
> The patch is based on -rcu/dev; I took the liberty of applying the
> same change to your #defines in:
> 
>  tools/testing/radix-tree/linux/rcupdate.h
>  tools/include/linux/rcu.h
> 
> but I admit that I'm not familiar with their uses: please shout if
> you have any objections with it.
> ---
>  Documentation/RCU/whatisRCU.txt           |  8 ++++----
>  include/linux/rcupdate.h                  |  5 ++---
>  tools/include/linux/rcu.h                 | 11 +++++++++--
>  tools/testing/radix-tree/linux/rcupdate.h |  5 ++++-
>  4 files changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/RCU/whatisRCU.txt b/Documentation/RCU/whatisRCU.txt
> index 981651a8b65d2..f99a87b9a88fa 100644
> --- a/Documentation/RCU/whatisRCU.txt
> +++ b/Documentation/RCU/whatisRCU.txt
> @@ -212,7 +212,7 @@ synchronize_rcu()
>  
>  rcu_assign_pointer()
>  
> -	typeof(p) rcu_assign_pointer(p, typeof(p) v);
> +	rcu_assign_pointer(p, typeof(p) v);

Please add the "void", similar to synchronize_rcu() above.

>  	Yes, rcu_assign_pointer() -is- implemented as a macro, though it
>  	would be cool to be able to declare a function in this manner.
> @@ -220,9 +220,9 @@ rcu_assign_pointer()
>  
>  	The updater uses this function to assign a new value to an
>  	RCU-protected pointer, in order to safely communicate the change
> -	in value from the updater to the reader.  This function returns
> -	the new value, and also executes any memory-barrier instructions
> -	required for a given CPU architecture.
> +	in value from the updater to the reader.  This macro does not
> +	evaluate to an rvalue, but it does execute any memory-barrier
> +	instructions required for a given CPU architecture.
>  
>  	Perhaps just as important, it serves to document (1) which
>  	pointers are protected by RCU and (2) the point at which a
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 915460ec08722..a5f61a08e65fc 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -367,7 +367,7 @@ static inline void rcu_preempt_sleep_check(void) { }
>   * other macros that it invokes.
>   */
>  #define rcu_assign_pointer(p, v)					      \
> -({									      \
> +do {									      \
>  	uintptr_t _r_a_p__v = (uintptr_t)(v);				      \
>  	rcu_check_sparse(p, __rcu);				      \
>  									      \
> @@ -375,8 +375,7 @@ static inline void rcu_preempt_sleep_check(void) { }
>  		WRITE_ONCE((p), (typeof(p))(_r_a_p__v));		      \
>  	else								      \
>  		smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
> -	_r_a_p__v;							      \
> -})
> +} while (0)
>  
>  /**
>   * rcu_swap_protected() - swap an RCU and a regular pointer
> diff --git a/tools/include/linux/rcu.h b/tools/include/linux/rcu.h
> index 7d02527e5bcea..01a435ee48cd6 100644
> --- a/tools/include/linux/rcu.h
> +++ b/tools/include/linux/rcu.h
> @@ -19,7 +19,14 @@ static inline bool rcu_is_watching(void)
>  	return false;
>  }
>  
> -#define rcu_assign_pointer(p, v) ((p) = (v))
> -#define RCU_INIT_POINTER(p, v) p=(v)
> +#define rcu_assign_pointer(p, v)				\
> +do {								\
> +	(p) = (v);						\
> +} while (0)
> +
> +#define RCU_INIT_POINTER(p, v)					\
> +do {								\
> +	(p) = (v);						\
> +} while (0)

These two each fit nicely on one line:

	#define rcu_assign_pointer(p, v) do { (p) = (v); } while (0)
	#define RCU_INIT_POINTER(p, v)   do { (p) = (v); } while (0)

>  
>  #endif
> diff --git a/tools/testing/radix-tree/linux/rcupdate.h b/tools/testing/radix-tree/linux/rcupdate.h
> index fd280b070fdb1..48212f3a758e6 100644
> --- a/tools/testing/radix-tree/linux/rcupdate.h
> +++ b/tools/testing/radix-tree/linux/rcupdate.h
> @@ -7,6 +7,9 @@
>  #define rcu_dereference_raw(p) rcu_dereference(p)
>  #define rcu_dereference_protected(p, cond) rcu_dereference(p)
>  #define rcu_dereference_check(p, cond) rcu_dereference(p)
> -#define RCU_INIT_POINTER(p, v)	(p) = (v)
> +#define RCU_INIT_POINTER(p, v)					\
> +do {								\
> +	(p) = (v);						\
> +} while (0)

As does this one.

>  #endif
> -- 
> 2.7.4
> 

