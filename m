Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03F7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892F020879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbfCYJCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:02:46 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45037 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfCYJCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 05:02:45 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h8LV5-0005pu-PN; Mon, 25 Mar 2019 10:02:35 +0100
Date:   Mon, 25 Mar 2019 10:02:35 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
cc:     Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [RESEND PATCH v6 07/12] x86/fsgsbase/64: Introduce the
 FIND_PERCPU_BASE macro
In-Reply-To: <1552680405-5265-8-git-send-email-chang.seok.bae@intel.com>
Message-ID: <alpine.DEB.2.21.1903250954110.1798@nanos.tec.linutronix.de>
References: <1552680405-5265-1-git-send-email-chang.seok.bae@intel.com> <1552680405-5265-8-git-send-email-chang.seok.bae@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2019, Chang S. Bae wrote:

> GSBASE is used to find per-CPU data in the kernel.

It's not used to find per cpu data. per cpu data access is using GS based
addressing.

> But when it is unknown,

What is unknown?

> the per-CPU base can be found from the per_cpu_offset table with a CPU NR.
> The CPU NR is extracted from the limit field of the CPUNODE entry in GDT,
> or by the RDPID instruction.
> 
> Also, add the GAS-compatible RDPID macro.
> 
> The new macro will be used on a following patch.

So this is yet another changelog which describes the WHAT and not the WHY
and lacks any form of sensible context.
 
> diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
> index aefd53767a5d..5e3dfbe8c1bf 100644
> --- a/arch/x86/include/asm/fsgsbase.h
> +++ b/arch/x86/include/asm/fsgsbase.h
> @@ -78,6 +78,47 @@ extern void x86_gsbase_write_cpu_inactive(unsigned long gsbase);
>  
>  #endif /* CONFIG_X86_64 */
>  
> +#else /* __ASSEMBLY__ */
> +
> +#ifdef CONFIG_X86_64
> +
> +#include <asm/inst.h>

Is there are good reason why this ASM MACRO maze needs to be in a global
visible header. AFAICT this is only used in the entry code. So why can't it
be added to the other entry code macros in calling.h or some other sensible
place?

> +#ifdef CONFIG_SMP
> +
> +/*
> + * CPU/node NR is loaded from the limit (size) field of a special segment
> + * descriptor entry in GDT.
> + */
> +.macro LOAD_CPU_AND_NODE_SEG_LIMIT reg:req
> +	movq	$__CPUNODE_SEG, \reg
> +	lsl	\reg, \reg
> +.endm
> +
> +/*
> + * Fetch the per-CPU GSBASE value for this processor and put it in @reg.
> + * We normally use %gs for accessing per-CPU data, but we are setting up
> + * %gs here and obviously can not use %gs itself to access per-CPU data.
> + */
> +.macro FIND_PERCPU_BASE reg:req

This is a complete misnomer. It's not searching for the per cpu base, it's
retrieving the per cpu base from a known place. So something like
GET_PERCPU_BASE would be appropriate.

> +	ALTERNATIVE \
> +		"LOAD_CPU_AND_NODE_SEG_LIMIT \reg", \
> +		"RDPID	\reg", \
> +		X86_FEATURE_RDPID
> +	andq	$VDSO_CPUNODE_MASK, \reg
> +	movq	__per_cpu_offset(, \reg, 8), \reg
> +.endm

> diff --git a/arch/x86/include/asm/inst.h b/arch/x86/include/asm/inst.h
> index f5a796da07f8..d063841a17e3 100644
> --- a/arch/x86/include/asm/inst.h
> +++ b/arch/x86/include/asm/inst.h
> @@ -306,6 +306,21 @@
>  	.endif
>  	MODRM 0xc0 movq_r64_xmm_opd1 movq_r64_xmm_opd2
>  	.endm
> +
> +.macro RDPID opd

So the update to require binutils >= 2.21 does not cover RDPID?

Thanks,

	tglx
