Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00441C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 17:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7ACB2184E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 17:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390970AbfGWRIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 13:08:00 -0400
Received: from foss.arm.com ([217.140.110.172]:57698 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbfGWRIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 13:08:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64CD7337;
        Tue, 23 Jul 2019 10:07:59 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A6533F71A;
        Tue, 23 Jul 2019 10:07:57 -0700 (PDT)
Subject: Re: [PATCH v2 3/4] arm64: Make debug exception handlers visible from
 RCU
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Dan Rue <dan.rue@linaro.org>,
        Matt Hart <matthew.hart@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Daniel Diaz <daniel.diaz@linaro.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
References: <156378170297.12011.17385386326930403235.stgit@devnote2>
 <156378173770.12011.3832608237079432765.stgit@devnote2>
From:   James Morse <james.morse@arm.com>
Message-ID: <0290c71b-6ed3-c455-eb4a-3f6a670f5e37@arm.com>
Date:   Tue, 23 Jul 2019 18:07:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <156378173770.12011.3832608237079432765.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22/07/2019 08:48, Masami Hiramatsu wrote:
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

> So make debug exception visible to RCU can fix this warning.

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

Would moving entry.S's context_tracking_user_exit() call to be before do_debug_exception()
also fix this?

I don't know the reason its done 'after' debug exception handling. Its always been like
this: commit 6c81fe7925cc4c42 ("arm64: enable context tracking").


> +	} else {
> +		/*
> +		 * We might have interrupted pretty much anything.  In
> +		 * fact, if we're a debug exception, we can even interrupt
> +		 * NMI processing.

> +		 * We don't want in_nmi() to return true,
> +		 * but we need to notify RCU.

How come? If you interrupted an SError or pseudo-nmi, it already is. Those paths should
all be painted no-kprobe, but I'm sure there are gaps. The hw-breakpoints can almost
certainly hook them.


> +		 */
> +		rcu_nmi_enter();

Can we interrupt printk()? Do we need printk_nmi_enter()? ... What about ftrace?

Because SError and pseudo-nmi can interrupt interrupt-masked code, we describe them as
NMI. The only difference here is these exceptions are synchronous.


I suspect we should make these debug exceptions nmi for EL1. We can then use this for the
kprobe-re-entrance stuff so the pre/post hooks don't get run if they interrupted something
also described as NMI.


> +	}
> +
> +	preempt_disable();
> +
> +	/* This code is a bit fragile.  Test it. */
> +	RCU_LOCKDEP_WARN(!rcu_is_watching(), "exception_enter didn't work");
> +}
> +NOKPROBE_SYMBOL(debug_exception_enter);


Thanks,

James
