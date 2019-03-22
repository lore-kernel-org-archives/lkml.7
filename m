Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB4AC10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C3C2183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfCVPop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:44:45 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41340 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfCVPon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:44:43 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h7MLW-0004nB-H2; Fri, 22 Mar 2019 16:44:38 +0100
Date:   Fri, 22 Mar 2019 16:44:37 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Zhao Yakui <yakui.zhao@intel.com>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Jason Chen CJ <jason.cj.chen@intel.com>
Subject: Re: [RFC PATCH 2/3] arch/x86/acrn: Use HYPERVISOR_CALLBACK_VECTOR
 for Acrn upcall vector
In-Reply-To: <1551924251-19466-3-git-send-email-yakui.zhao@intel.com>
Message-ID: <alpine.DEB.2.21.1903221620150.1729@nanos.tec.linutronix.de>
References: <1551924251-19466-1-git-send-email-yakui.zhao@intel.com> <1551924251-19466-3-git-send-email-yakui.zhao@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Mar 2019, Zhao Yakui wrote:

> WHen it works in hypervisor guest mode, Linux kernel uses the
> HYPERVISOR_CALLBACK_VECTOR for hypervisor upcall vector. And it is already
> used for Xen and HyperV. After Acrn hypervisor is detected, it will also
> use this defined vector as notify vector to kernel.
> And two APIs are added so that the other module can add/remove the
> hypervisor callback irq handler.

Which other module?

> Signed-off-by: Jason Chen CJ <jason.cj.chen@intel.com>
> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>

Same SOB issue.

> +#if IS_ENABLED(CONFIG_ACRN)
> +apicinterrupt3 HYPERVISOR_CALLBACK_VECTOR \
> +	acrn_hv_callback_vector acrn_hv_vector_handler
> +#endif
> +
>  idtentry debug			do_debug		has_error_code=0	paranoid=1 shift_ist=DEBUG_STACK
>  idtentry int3			do_int3			has_error_code=0
>  idtentry stack_segment		do_stack_segment	has_error_code=1
> diff --git a/arch/x86/include/asm/acrnhyper.h b/arch/x86/include/asm/acrnhyper.h
> new file mode 100644
> index 0000000..2562a82
> --- /dev/null
> +++ b/arch/x86/include/asm/acrnhyper.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_ACRNHYPER_H
> +#define _ASM_X86_ACRNHYPER_H
> +
> +#include <linux/types.h>
> +#include <asm/io.h>
> +
> +#ifdef CONFIG_ACRN
> +/* ACRN Hypervisor callback */
> +void acrn_hv_callback_vector(void);

What declares acrn_hv_vector_handler() ?

>  #include <asm/hypervisor.h>
> +#include <asm/acrnhyper.h>
> +#include <asm/irq_vectors.h>
> +#include <asm/irq_regs.h>
> +#include <asm/desc.h>
> +#include <linux/interrupt.h>

First of all the include order is always:

 #include <linux/...>
 #include <linux/...>

 #include <asm/...>

Aside of that including 'linux/irq.h' should include everything you
need. No need for gazillion of includes.

>  static bool acrn_x2apic_available(void)
> @@ -26,6 +33,37 @@ static bool acrn_x2apic_available(void)
>  	return false;
>  }
>  
> +

Stray newline

> +static void (*acrn_intr_handler)(void);
> +/*

Which should have been above this comment. Glueing stuff together makes it
unreadable.

> + * Handler for ACRN_HV_CALLBACK.

Err? This handles the HYPERVISOR_CALLBACK_VECTOR

> + */
> +__visible void __irq_entry acrn_hv_vector_handler(struct pt_regs *regs)
> +{
> +	struct pt_regs *old_regs = set_irq_regs(regs);
> +
> +	entering_ack_irq();
> +	inc_irq_stat(irq_hv_callback_count);
> +
> +	if (acrn_intr_handler)
> +		acrn_intr_handler();
> +
> +	exiting_irq();
> +	set_irq_regs(old_regs);
> +}
> +
> +void acrn_setup_intr_irq(void (*handler)(void))
> +{
> +	acrn_intr_handler = handler;
> +}
> +EXPORT_SYMBOL(acrn_setup_intr_irq);
> +
> +void acrn_remove_intr_irq(void)
> +{
> +	acrn_intr_handler = NULL;
> +}
> +EXPORT_SYMBOL(acrn_remove_intr_irq);

Where is the code which uses these exports? We are not adding exports just
because or for consumption by out of tree modules.

Thanks,

	tglx
