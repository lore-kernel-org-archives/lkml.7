Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5AAC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E122190D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730206AbfGVMII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 08:08:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62906 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728715AbfGVMIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 08:08:07 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6MC6fB3068161;
        Mon, 22 Jul 2019 08:07:59 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tw9qu8u7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Jul 2019 08:07:59 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x6MC4jnC006189;
        Mon, 22 Jul 2019 12:07:57 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma04dal.us.ibm.com with ESMTP id 2tutk6puhx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Jul 2019 12:07:57 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6MC7vws41484688
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Jul 2019 12:07:57 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2032B2066;
        Mon, 22 Jul 2019 12:07:56 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0831B2065;
        Mon, 22 Jul 2019 12:07:56 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.189.166])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 22 Jul 2019 12:07:56 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 125E516C0D7D; Mon, 22 Jul 2019 05:07:58 -0700 (PDT)
Date:   Mon, 22 Jul 2019 05:07:58 -0700
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
Subject: Re: [PATCH v2 4/4] arm64: Remove unneeded rcu_read_lock from debug
 handlers
Message-ID: <20190722120758.GB14271@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <156378170297.12011.17385386326930403235.stgit@devnote2>
 <156378175027.12011.5591853683946780785.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156378175027.12011.5591853683946780785.stgit@devnote2>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-22_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907220144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 04:49:11PM +0900, Masami Hiramatsu wrote:
> Remove rcu_read_lock()/rcu_read_unlock() from debug exception
> handlers since we are sure those are not preemptible and
> interrupts are off.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Paul E. McKenney <paulmck@linux.ibm.com>

From an RCU viewpoint:

Acked-by: Paul E. McKenney <paulmck@linux.ibm.com>

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
