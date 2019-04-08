Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39823C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B63321473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="E6ggRi1i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfDHPAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:00:16 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47076 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbfDHPAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:00:16 -0400
Received: from zn.tnic (p200300EC2F07270021E2DB6109CF2936.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:2700:21e2:db61:9cf:2936])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4BCEB1EC086F;
        Mon,  8 Apr 2019 17:00:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554735615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=CzkhWpRYPOmlT9VD2G/d+dI/JEzYpliXkcMuNXJzuQo=;
        b=E6ggRi1ip1hNuyNkwrTySvTH5TJ+H2uj1rpYnjUKr2WACi0+E40h20rI0pUnY3TuHxgS//
        NnNgIe1+sQ/Kv8TcDHpda7bgH1HwvfWuldW48ngwGV5iGYUN/VXKF3J+5vWKwU4NVucYPM
        vfwRnSzVd5j6PoCkYtUnBjS9WsGdVnU=
Date:   Mon, 8 Apr 2019 17:00:11 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Zhao Yakui <yakui.zhao@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        Jason Chen CJ <jason.cj.chen@intel.com>
Subject: Re: [RFC PATCH v3 3/4] x86: Use HYPERVISOR_CALLBACK_VECTOR for
 acrn_guest upcall vector
Message-ID: <20190408150011.GH15689@zn.tnic>
References: <1554711131-21514-1-git-send-email-yakui.zhao@intel.com>
 <1554711131-21514-4-git-send-email-yakui.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1554711131-21514-4-git-send-email-yakui.zhao@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You can prefix your subject now like this:

x86/acrn: Use ...

On Mon, Apr 08, 2019 at 04:12:10PM +0800, Zhao Yakui wrote:
> Linux kernel uses the HYPERVISOR_CALLBACK_VECTOR for hypervisor upcall
> vector. And it is already used for Xen and HyperV.
> After Acrn hypervisor is detected, it will also use this defined vector
> to notify kernel.
> 
> Co-developed-by: Jason Chen CJ <jason.cj.chen@intel.com>
> Signed-off-by: Jason Chen CJ <jason.cj.chen@intel.com>
> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> ---
> V1->V2: Remove the unused API definition of acrn_setup_intr_handler and
> acrn_remove_intr_handler.
>         Adjust the order of header file
>         Add the declaration of acrn_hv_vector_handler and tracing
> definition of acrn_hv_callback_vector.
> ---
>  arch/x86/Kconfig                 |  1 +
>  arch/x86/entry/entry_64.S        |  5 +++++
>  arch/x86/include/asm/acrnhyper.h | 19 +++++++++++++++++++
>  arch/x86/kernel/cpu/acrn.c       | 22 ++++++++++++++++++++++
>  4 files changed, 47 insertions(+)
>  create mode 100644 arch/x86/include/asm/acrnhyper.h
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index d77d215..ae4d38b 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -848,6 +848,7 @@ config JAILHOUSE_GUEST
>  config ACRN_GUEST
>  	bool "ACRN Guest support"
>  	depends on X86_64
> +	select X86_HV_CALLBACK_VECTOR
>  	help
>  	  This option allows to run Linux as guest in ACRN hypervisor. Enabling
>  	  this will allow the kernel to boot in virtualized environment under
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 1f0efdb..d1b8ad3 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -1129,6 +1129,11 @@ apicinterrupt3 HYPERV_STIMER0_VECTOR \
>  	hv_stimer0_callback_vector hv_stimer0_vector_handler
>  #endif /* CONFIG_HYPERV */
>  
> +#if IS_ENABLED(CONFIG_ACRN_GUEST)
> +apicinterrupt3 HYPERVISOR_CALLBACK_VECTOR \
> +	acrn_hv_callback_vector acrn_hv_vector_handler
> +#endif
> +
>  idtentry debug			do_debug		has_error_code=0	paranoid=1 shift_ist=DEBUG_STACK
>  idtentry int3			do_int3			has_error_code=0
>  idtentry stack_segment		do_stack_segment	has_error_code=1
> diff --git a/arch/x86/include/asm/acrnhyper.h b/arch/x86/include/asm/acrnhyper.h
> new file mode 100644
> index 0000000..9f9c239
> --- /dev/null
> +++ b/arch/x86/include/asm/acrnhyper.h

Simply

	.../acrn.h

I'd say.

> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_ACRNHYPER_H
> +#define _ASM_X86_ACRNHYPER_H
> +
> +#include <linux/types.h>
> +#include <linux/atomic.h>
> +#include <linux/nmi.h>
> +#include <asm/io.h>
> +
> +#ifdef CONFIG_ACRN_GUEST

Why is that ifdef needed?

> +void acrn_hv_callback_vector(void);
> +#ifdef CONFIG_TRACING
> +#define trace_acrn_hv_callback_vector acrn_hv_callback_vector
> +#endif
> +
> +void acrn_hv_vector_handler(struct pt_regs *regs);

end marker:

#endif /* _ASM_X86_ACRNHYPER_H */

> diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
> index 3956567..7a233b5 100644
> --- a/arch/x86/kernel/cpu/acrn.c
> +++ b/arch/x86/kernel/cpu/acrn.c
> @@ -9,7 +9,11 @@
>   *
>   */
>  
> +#include <linux/interrupt.h>
>  #include <asm/hypervisor.h>
> +#include <asm/acrnhyper.h>
> +#include <asm/desc.h>
> +#include <asm/irq_regs.h>

What's the sorting order here? Length or alphabetic? Or none? :)

linux/ path includes still need to come first, of course.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
