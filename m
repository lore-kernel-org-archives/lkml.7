Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F197CC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C309221841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="RTJVU+0Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfDHOkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:40:03 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43972 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726850AbfDHOkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:40:02 -0400
Received: from zn.tnic (p200300EC2F0727000D4943AED098453F.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:2700:d49:43ae:d098:453f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 465511EC06F3;
        Mon,  8 Apr 2019 16:40:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554734400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zPPL88bTqaro1loC1ic0SwxZFy3jBWc3ogrqMeMrrhE=;
        b=RTJVU+0ZbMtgMU1SB1KaWKrrehKNTOOfgn1GdU2nMWIRTcP8oD+8/K4ahVUmObbJE1u4hz
        ZZRqgY5S68uYpGLbtXJPldrBtHM7AseYfhV9lLddhZItl06jnpcmATytqE0j4cihbySekl
        CmMWXZl8s8lHJFHwQxxMjeVcnf20vjE=
Date:   Mon, 8 Apr 2019 16:39:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Zhao Yakui <yakui.zhao@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        Jason Chen CJ <jason.cj.chen@intel.com>
Subject: Re: [RFC PATCH v3 2/4] x86: Add the support of ACRN guest
Message-ID: <20190408143952.GF15689@zn.tnic>
References: <1554711131-21514-1-git-send-email-yakui.zhao@intel.com>
 <1554711131-21514-3-git-send-email-yakui.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1554711131-21514-3-git-send-email-yakui.zhao@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 04:12:09PM +0800, Zhao Yakui wrote:
> ACRN is an open-source hypervisor maintained by Linuxfoundation.

I think tglx wanted to say "by the Linux Foundation" here.

> This is to add the Linux guest support on acrn-hypervisor.

I think you were told already:

"Please do not use 'This is to add' or 'This adds'. Just say:

Add ...."

So please take your time, work in *all* review feedback instead of
hurrying the next version out without addressing all review comments.

> Add x86_hyper_acrn into supported hypervisors array, which enables
> Linux ACRN guest running on ACRN hypervisor. It is restricted to X86_64.

So this all talks about *what* the patch does. But that is visible from
the diff below and doesn't belong in the commit message.

Rather, your commit message should talk about *why* a change is being
done.

> Co-developed-by: Jason Chen CJ <jason.cj.chen@intel.com>
> Signed-off-by: Jason Chen CJ <jason.cj.chen@intel.com>
> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> ---
> v1->v2: Change the CONFIG_ACRN to CONFIG_ACRN_GUEST, which makes it easy to
> understand.
>         Remove the export of x86_hyper_acrn.
> 
> v2->v3: Remove the unnecessary dependency of PARAVIRT
> ---
>  arch/x86/Kconfig                  |  8 ++++++++
>  arch/x86/include/asm/hypervisor.h |  1 +
>  arch/x86/kernel/cpu/Makefile      |  1 +
>  arch/x86/kernel/cpu/acrn.c        | 35 +++++++++++++++++++++++++++++++++++
>  arch/x86/kernel/cpu/hypervisor.c  |  4 ++++
>  5 files changed, 49 insertions(+)
>  create mode 100644 arch/x86/kernel/cpu/acrn.c
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 54d1fbc..d77d215 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -845,6 +845,14 @@ config JAILHOUSE_GUEST
>  	  cell. You can leave this option disabled if you only want to start
>  	  Jailhouse and run Linux afterwards in the root cell.
>  
> +config ACRN_GUEST
> +	bool "ACRN Guest support"
> +	depends on X86_64
> +	help
> +	  This option allows to run Linux as guest in ACRN hypervisor. Enabling
> +	  this will allow the kernel to boot in virtualized environment under
> +	  the ACRN hypervisor.

WARNING: please write a paragraph that describes the config symbol fully
#47: FILE: arch/x86/Kconfig:848:
+config ACRN_GUEST

That help text above could use some of the explanation what ACRN is from
your 0/4 message.

> +
>  endif #HYPERVISOR_GUEST
>  
>  source "arch/x86/Kconfig.cpu"
> diff --git a/arch/x86/include/asm/hypervisor.h b/arch/x86/include/asm/hypervisor.h
> index 8c5aaba..50a30f6 100644
> --- a/arch/x86/include/asm/hypervisor.h
> +++ b/arch/x86/include/asm/hypervisor.h
> @@ -29,6 +29,7 @@ enum x86_hypervisor_type {
>  	X86_HYPER_XEN_HVM,
>  	X86_HYPER_KVM,
>  	X86_HYPER_JAILHOUSE,
> +	X86_HYPER_ACRN,
>  };
>  
>  #ifdef CONFIG_HYPERVISOR_GUEST
> diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
> index cfd24f9..17a7cdf 100644
> --- a/arch/x86/kernel/cpu/Makefile
> +++ b/arch/x86/kernel/cpu/Makefile
> @@ -44,6 +44,7 @@ obj-$(CONFIG_X86_CPU_RESCTRL)		+= resctrl/
>  obj-$(CONFIG_X86_LOCAL_APIC)		+= perfctr-watchdog.o
>  
>  obj-$(CONFIG_HYPERVISOR_GUEST)		+= vmware.o hypervisor.o mshyperv.o
> +obj-$(CONFIG_ACRN_GUEST)		+= acrn.o
>  
>  ifdef CONFIG_X86_FEATURE_NAMES
>  quiet_cmd_mkcapflags = MKCAP   $@
> diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
> new file mode 100644
> index 0000000..3956567
> --- /dev/null
> +++ b/arch/x86/kernel/cpu/acrn.c
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ACRN detection support
> + *
> + * Copyright (C) 2019 Intel Corporation. All rights reserved.
> + *
> + * Jason Chen CJ <jason.cj.chen@intel.com>
> + * Zhao Yakui <yakui.zhao@intel.com>
> + *
> + */
> +
> +#include <asm/hypervisor.h>
> +
> +static uint32_t __init acrn_detect(void)
> +{
> +	return hypervisor_cpuid_base("ACRNACRNACRN\0\0", 0);
> +}
> +
> +static void __init acrn_init_platform(void)
> +{
> +}
> +
> +static bool acrn_x2apic_available(void)
> +{
> +	/* do not support x2apic */

Why?

This comment could explain why that choice has been made.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
