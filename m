Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC9EC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6180721901
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbfGVMHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 08:07:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15992 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728266AbfGVMHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 08:07:41 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6MC5Owd103815
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 08:07:40 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2twcct1ccc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 08:07:40 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 22 Jul 2019 13:07:39 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 22 Jul 2019 13:07:35 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6MC7Y7F52560152
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Jul 2019 12:07:34 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A64ACB205F;
        Mon, 22 Jul 2019 12:07:34 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7AEF8B2065;
        Mon, 22 Jul 2019 12:07:34 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.189.166])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 22 Jul 2019 12:07:34 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C0C1816C0D7D; Mon, 22 Jul 2019 05:07:35 -0700 (PDT)
Date:   Mon, 22 Jul 2019 05:07:35 -0700
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
Subject: Re: [PATCH v2 3/4] arm64: Make debug exception handlers visible from
 RCU
Reply-To: paulmck@linux.ibm.com
References: <156378170297.12011.17385386326930403235.stgit@devnote2>
 <156378173770.12011.3832608237079432765.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156378173770.12011.3832608237079432765.stgit@devnote2>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19072212-0052-0000-0000-000003E3FA13
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011474; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01235804; UDB=6.00651291; IPR=6.01017153;
 MB=3.00027836; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-22 12:07:38
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072212-0053-0000-0000-000061CB59F5
Message-Id: <20190722120735.GA14271@linux.ibm.com>
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

On Mon, Jul 22, 2019 at 04:48:58PM +0900, Masami Hiramatsu wrote:
> Make debug exceptions visible from RCU so that synchronize_rcu()
> correctly track the debug exception handler.
> 
> This also introduces sanity checks for user-mode exceptions as same
> as x86's ist_enter()/ist_exit().
> 
> The debug exception can interrupt in idle task. For example, it warns
> if we put a kprobe on a function called from idle task as below.
> The warning message showed that the rcu_read_lock() caused this
> problem. But actually, this means the RCU is lost the context which
> is already in NMI/IRQ.
> 
>   /sys/kernel/debug/tracing # echo p default_idle_call >> kprobe_events
>   /sys/kernel/debug/tracing # echo 1 > events/kprobes/enable
>   /sys/kernel/debug/tracing # [  135.122237]
>   [  135.125035] =============================
>   [  135.125310] WARNING: suspicious RCU usage
>   [  135.125581] 5.2.0-08445-g9187c508bdc7 #20 Not tainted
>   [  135.125904] -----------------------------
>   [  135.126205] include/linux/rcupdate.h:594 rcu_read_lock() used illegally while idle!
>   [  135.126839]
>   [  135.126839] other info that might help us debug this:
>   [  135.126839]
>   [  135.127410]
>   [  135.127410] RCU used illegally from idle CPU!
>   [  135.127410] rcu_scheduler_active = 2, debug_locks = 1
>   [  135.128114] RCU used illegally from extended quiescent state!
>   [  135.128555] 1 lock held by swapper/0/0:
>   [  135.128944]  #0: (____ptrval____) (rcu_read_lock){....}, at: call_break_hook+0x0/0x178
>   [  135.130499]
>   [  135.130499] stack backtrace:
>   [  135.131192] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.2.0-08445-g9187c508bdc7 #20
>   [  135.131841] Hardware name: linux,dummy-virt (DT)
>   [  135.132224] Call trace:
>   [  135.132491]  dump_backtrace+0x0/0x140
>   [  135.132806]  show_stack+0x24/0x30
>   [  135.133133]  dump_stack+0xc4/0x10c
>   [  135.133726]  lockdep_rcu_suspicious+0xf8/0x108
>   [  135.134171]  call_break_hook+0x170/0x178
>   [  135.134486]  brk_handler+0x28/0x68
>   [  135.134792]  do_debug_exception+0x90/0x150
>   [  135.135051]  el1_dbg+0x18/0x8c
>   [  135.135260]  default_idle_call+0x0/0x44
>   [  135.135516]  cpu_startup_entry+0x2c/0x30
>   [  135.135815]  rest_init+0x1b0/0x280
>   [  135.136044]  arch_call_rest_init+0x14/0x1c
>   [  135.136305]  start_kernel+0x4d4/0x500
>   [  135.136597]
> 
> So make debug exception visible to RCU can fix this warning.
> 
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Cc: Paul E. McKenney <paulmck@linux.ibm.com>

From an RCU viewpoint:

Acked-by: Paul E. McKenney <paulmck@linux.ibm.com>

> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  arch/arm64/mm/fault.c |   40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 9568c116ac7f..a6b244240db6 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -777,6 +777,42 @@ void __init hook_debug_fault_code(int nr,
>  	debug_fault_info[nr].name	= name;
>  }
>  
> +/*
> + * In debug exception context, we explicitly disable preemption.
> + * This serves two purposes: it makes it much less likely that we would
> + * accidentally schedule in exception context and it will force a warning
> + * if we somehow manage to schedule by accident.
> + */
> +static void debug_exception_enter(struct pt_regs *regs)
> +{
> +	if (user_mode(regs)) {
> +		RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
> +	} else {
> +		/*
> +		 * We might have interrupted pretty much anything.  In
> +		 * fact, if we're a debug exception, we can even interrupt
> +		 * NMI processing.  We don't want in_nmi() to return true,
> +		 * but we need to notify RCU.
> +		 */
> +		rcu_nmi_enter();
> +	}
> +
> +	preempt_disable();
> +
> +	/* This code is a bit fragile.  Test it. */
> +	RCU_LOCKDEP_WARN(!rcu_is_watching(), "exception_enter didn't work");
> +}
> +NOKPROBE_SYMBOL(debug_exception_enter);
> +
> +static void debug_exception_exit(struct pt_regs *regs)
> +{
> +	preempt_enable_no_resched();
> +
> +	if (!user_mode(regs))
> +		rcu_nmi_exit();
> +}
> +NOKPROBE_SYMBOL(debug_exception_exit);
> +
>  #ifdef CONFIG_ARM64_ERRATUM_1463225
>  DECLARE_PER_CPU(int, __in_cortex_a76_erratum_1463225_wa);
>  
> @@ -824,6 +860,8 @@ asmlinkage void __exception do_debug_exception(unsigned long addr_if_watchpoint,
>  	if (interrupts_enabled(regs))
>  		trace_hardirqs_off();
>  
> +	debug_exception_enter(regs);
> +
>  	if (user_mode(regs) && !is_ttbr0_addr(pc))
>  		arm64_apply_bp_hardening();
>  
> @@ -832,6 +870,8 @@ asmlinkage void __exception do_debug_exception(unsigned long addr_if_watchpoint,
>  				 inf->sig, inf->code, (void __user *)pc, esr);
>  	}
>  
> +	debug_exception_exit(regs);
> +
>  	if (interrupts_enabled(regs))
>  		trace_hardirqs_on();
>  }
> 

