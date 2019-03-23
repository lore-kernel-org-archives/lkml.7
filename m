Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663F9C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 15:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 331492190A
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 15:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfCWPRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 11:17:18 -0400
Received: from mga18.intel.com ([134.134.136.126]:38947 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727267AbfCWPRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 11:17:18 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Mar 2019 08:17:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="136649002"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by orsmga003.jf.intel.com with ESMTP; 23 Mar 2019 08:17:17 -0700
Date:   Sat, 23 Mar 2019 08:17:17 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Zhao Yakui <yakui.zhao@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Jason Chen CJ <jason.cj.chen@intel.com>
Subject: Re: [RFC PATCH 1/3] arch/x86: add ACRN hypervisor guest
Message-ID: <20190323151717.GA22376@linux.intel.com>
References: <1551924251-19466-1-git-send-email-yakui.zhao@intel.com>
 <1551924251-19466-2-git-send-email-yakui.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551924251-19466-2-git-send-email-yakui.zhao@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 10:04:09AM +0800, Zhao Yakui wrote:
> ACRN is one open-source hypervisour, which is maintained by Linux
> foundation. This is to add the para-virtualization support so that
> it allows to enable the Linux guest on acrn-hypervisor.
> 
> This adds x86_hyper_acrn into supported hypervisors array, which
> enables ACRN services guest running on ACRN hypervisor. It is
> restricted to X86_64.
> 
> Signed-off-by: Jason Chen CJ <jason.cj.chen@intel.com>
> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> ---
>  arch/x86/Kconfig                  |  8 ++++++++
>  arch/x86/include/asm/hypervisor.h |  1 +
>  arch/x86/kernel/cpu/Makefile      |  1 +
>  arch/x86/kernel/cpu/acrn.c        | 36 ++++++++++++++++++++++++++++++++++++
>  arch/x86/kernel/cpu/hypervisor.c  |  4 ++++
>  5 files changed, 50 insertions(+)
>  create mode 100644 arch/x86/kernel/cpu/acrn.c
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 90b562a..c7b64e7 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -843,6 +843,14 @@ config JAILHOUSE_GUEST
>  	  cell. You can leave this option disabled if you only want to start
>  	  Jailhouse and run Linux afterwards in the root cell.
>  
> +config ACRN

My personal preference would be to use ACRN_GUEST.  Inevitably there will
be a need to wrap ACRN code with an ifdef, and seeing "GUEST" in such
cases immediately lets readers know the code in question is related to
running as a guest without having to remember that ACRN is a hypervisor.
This is especially true for readers that have never heard of ACRN.

> +	bool "Enable services on ACRN hypervisor"
> +	depends on X86_64 && PARAVIRT
> +	help
> +	  This option allows to run Linux as guest in ACRN hypervisor.
> +	  It is needed if you want to run ACRN services linux on top of
> +	  ACRN hypervisor.
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
> index cfd24f9..cde1436 100644
> --- a/arch/x86/kernel/cpu/Makefile
> +++ b/arch/x86/kernel/cpu/Makefile
> @@ -44,6 +44,7 @@ obj-$(CONFIG_X86_CPU_RESCTRL)		+= resctrl/
>  obj-$(CONFIG_X86_LOCAL_APIC)		+= perfctr-watchdog.o
>  
>  obj-$(CONFIG_HYPERVISOR_GUEST)		+= vmware.o hypervisor.o mshyperv.o
> +obj-$(CONFIG_ACRN)			+= acrn.o
>  
>  ifdef CONFIG_X86_FEATURE_NAMES
>  quiet_cmd_mkcapflags = MKCAP   $@
> diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
> new file mode 100644
> index 0000000..ddeaafb
> --- /dev/null
> +++ b/arch/x86/kernel/cpu/acrn.c
> @@ -0,0 +1,36 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ACRN hypervisor support
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
> +	return false;
> +}
> +
> +const struct hypervisor_x86 x86_hyper_acrn = {
> +	.name                   = "ACRN",
> +	.detect                 = acrn_detect,
> +	.type			= X86_HYPER_ACRN,
> +	.init.init_platform     = acrn_init_platform,
> +	.init.x2apic_available  = acrn_x2apic_available,
> +};
> +EXPORT_SYMBOL(x86_hyper_acrn);
> diff --git a/arch/x86/kernel/cpu/hypervisor.c b/arch/x86/kernel/cpu/hypervisor.c
> index 479ca47..5a6f072 100644
> --- a/arch/x86/kernel/cpu/hypervisor.c
> +++ b/arch/x86/kernel/cpu/hypervisor.c
> @@ -32,6 +32,7 @@ extern const struct hypervisor_x86 x86_hyper_xen_pv;
>  extern const struct hypervisor_x86 x86_hyper_xen_hvm;
>  extern const struct hypervisor_x86 x86_hyper_kvm;
>  extern const struct hypervisor_x86 x86_hyper_jailhouse;
> +extern const struct hypervisor_x86 x86_hyper_acrn;
>  
>  static const __initconst struct hypervisor_x86 * const hypervisors[] =
>  {
> @@ -49,6 +50,9 @@ static const __initconst struct hypervisor_x86 * const hypervisors[] =
>  #ifdef CONFIG_JAILHOUSE_GUEST
>  	&x86_hyper_jailhouse,
>  #endif
> +#ifdef CONFIG_ACRN
> +	&x86_hyper_acrn,
> +#endif
>  };
>  
>  enum x86_hypervisor_type x86_hyper_type;
> -- 
> 2.7.4
> 
