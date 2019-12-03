Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D64EC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 20:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A6E520661
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 20:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfLCU6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 15:58:52 -0500
Received: from mga18.intel.com ([134.134.136.126]:1643 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727244AbfLCU6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 15:58:51 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2019 12:58:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,274,1571727600"; 
   d="scan'208";a="205128882"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by orsmga008.jf.intel.com with ESMTP; 03 Dec 2019 12:58:51 -0800
Date:   Tue, 3 Dec 2019 12:58:51 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v5 2/4] x86/traps: Print address on #GP
Message-ID: <20191203205850.GF19877@linux.intel.com>
References: <20191127234916.31175-1-jannh@google.com>
 <20191127234916.31175-2-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127234916.31175-2-jannh@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 12:49:14AM +0100, Jann Horn wrote:

With a few nits below,

Reviewed-and-tested-by: Sean Christopherson <sean.j.christopherson@intel.com>

> +#define GPFSTR "general protection fault"
> +
>  dotraplinkage void
>  do_general_protection(struct pt_regs *regs, long error_code)
>  {
> -	const char *desc = "general protection fault";
>  	struct task_struct *tsk;
> +	char desc[sizeof(GPFSTR) + 50 + 2*sizeof(unsigned long) + 1] = GPFSTR;

Nit, x86 maintainers prefer inverse fir tree for variable declarations.

>  
>  	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
>  	cond_local_irq_enable(regs);
> @@ -540,6 +587,9 @@ do_general_protection(struct pt_regs *regs, long error_code)
>  
>  	tsk = current;
>  	if (!user_mode(regs)) {
> +		enum kernel_gp_hint hint = GP_NO_HINT;
> +		unsigned long gp_addr;
> +
>  		if (fixup_exception(regs, X86_TRAP_GP, error_code, 0))
>  			return;
>  
> @@ -556,8 +606,22 @@ do_general_protection(struct pt_regs *regs, long error_code)
>  			return;
>  
>  		if (notify_die(DIE_GPF, desc, regs, error_code,
> -			       X86_TRAP_GP, SIGSEGV) != NOTIFY_STOP)
> -			die(desc, regs, error_code);
> +			       X86_TRAP_GP, SIGSEGV) == NOTIFY_STOP)
> +			return;
> +
> +		if (error_code)
> +			snprintf(desc, sizeof(desc), "segment-related " GPFSTR);
> +		else
> +			hint = get_kernel_gp_address(regs, &gp_addr);
> +
> +		if (hint != GP_NO_HINT)
> +			snprintf(desc, sizeof(desc), GPFSTR " %s 0x%lx",

Nit, probably should have a comma before the hint, i.e. GPFSTR ", %s...".

    general protection fault maybe for address 0xffffc9000017cf58: 0000 [#1] SMP
    general protection fault probably for non-canonical address 0xdead000000000000: 0000 [#1] SMP

  vs. 

    general protection fault, maybe for address 0xffffc9000017cf58: 0000 [#1] SMP
    general protection fault, probably for non-canonical address 0xdead000000000000: 0000 [#1] SMP

> +				 (hint == GP_NON_CANONICAL) ?
> +				 "probably for non-canonical address" :
> +				 "maybe for address",
> +				 gp_addr);
> +
> +		die(desc, regs, error_code);
>  		return;
>  	}
>  
> -- 
> 2.24.0.432.g9d3f5f5b63-goog
> 
