Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E898C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 06:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EE4D204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 06:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfGRGWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 02:22:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54326 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726090AbfGRGWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 02:22:51 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6I6Mend041227;
        Thu, 18 Jul 2019 02:22:40 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tthu4418h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jul 2019 02:22:39 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x6I6B77g003381;
        Thu, 18 Jul 2019 06:22:16 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01wdc.us.ibm.com with ESMTP id 2tq6x6dfft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jul 2019 06:22:16 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6I6MFNg11600468
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jul 2019 06:22:16 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8CA7B2065;
        Thu, 18 Jul 2019 06:22:15 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B70A6B2064;
        Thu, 18 Jul 2019 06:22:15 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.167.28])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 18 Jul 2019 06:22:15 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id BC45B16C998C; Wed, 17 Jul 2019 23:22:15 -0700 (PDT)
Date:   Wed, 17 Jul 2019 23:22:15 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Dan Rue <dan.rue@linaro.org>,
        Matt Hart <matthew.hart@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Daniel Diaz <daniel.diaz@linaro.org>
Subject: Re: [PATCH 3/3] arm64: debug: Remove rcu_read_lock from debug
 exception
Message-ID: <20190718062215.GG14271@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <156342860634.8565.14804606041960884732.stgit@devnote2>
 <156342863822.8565.7624877983728871995.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156342863822.8565.7624877983728871995.stgit@devnote2>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-18_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907180072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 02:43:58PM +0900, Masami Hiramatsu wrote:
> Remove rcu_read_lock()/rcu_read_unlock() from debug exception
> handlers since the software breakpoint can be hit on idle task.

The exception entry and exit use irq_enter() and irq_exit(), in this
case, correct?  Otherwise RCU will be ignoring this CPU.

							Thanx, Paul

> Actually, we don't need it because those handlers run in exception
> context where the interrupts are disabled. This means those are never
> preempted.
> 
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Cc: Paul E. McKenney <paulmck@linux.ibm.com>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  arch/arm64/kernel/debug-monitors.c |   14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
> index f8719bd30850..48222a4760c2 100644
> --- a/arch/arm64/kernel/debug-monitors.c
> +++ b/arch/arm64/kernel/debug-monitors.c
> @@ -207,16 +207,16 @@ static int call_step_hook(struct pt_regs *regs, unsigned int esr)
>  
>  	list = user_mode(regs) ? &user_step_hook : &kernel_step_hook;
>  
> -	rcu_read_lock();
> -
> +	/*
> +	 * Since single-step exception disables interrupt, this function is
> +	 * entirely not preemptible, and we can use rcu list safely here.
> +	 */
>  	list_for_each_entry_rcu(hook, list, node)	{
>  		retval = hook->fn(regs, esr);
>  		if (retval == DBG_HOOK_HANDLED)
>  			break;
>  	}
>  
> -	rcu_read_unlock();
> -
>  	return retval;
>  }
>  NOKPROBE_SYMBOL(call_step_hook);
> @@ -305,14 +305,16 @@ static int call_break_hook(struct pt_regs *regs, unsigned int esr)
>  
>  	list = user_mode(regs) ? &user_break_hook : &kernel_break_hook;
>  
> -	rcu_read_lock();
> +	/*
> +	 * Since brk exception disables interrupt, this function is
> +	 * entirely not preemptible, and we can use rcu list safely here.
> +	 */
>  	list_for_each_entry_rcu(hook, list, node) {
>  		unsigned int comment = esr & ESR_ELx_BRK64_ISS_COMMENT_MASK;
>  
>  		if ((comment & ~hook->mask) == hook->imm)
>  			fn = hook->fn;
>  	}
> -	rcu_read_unlock();
>  
>  	return fn ? fn(regs, esr) : DBG_HOOK_ERROR;
>  }
> 
