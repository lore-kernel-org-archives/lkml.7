Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9111FCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70ABD2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437137AbfJRQi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 12:38:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:56208 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728368AbfJRQi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:38:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Oct 2019 09:38:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,312,1566889200"; 
   d="scan'208";a="397991951"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by fmsmga006.fm.intel.com with ESMTP; 18 Oct 2019 09:38:27 -0700
Date:   Fri, 18 Oct 2019 09:38:27 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Hellstrom <thellstrom@vmware.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 2/2] x86/cpu/vmware: Fix platform detection VMWARE_PORT
 macro
Message-ID: <20191018163827.GC26319@linux.intel.com>
References: <20191018134052.3023-1-thomas_os@shipmail.org>
 <20191018134052.3023-3-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191018134052.3023-3-thomas_os@shipmail.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 03:40:52PM +0200, Thomas Hellström (VMware) wrote:
> From: Thomas Hellstrom <thellstrom@vmware.com>
> 
> The platform detection VMWARE_PORT macro uses the VMWARE_HYPERVISOR_PORT
> definition, but expects it to be an integer. However, when it was moved
> to the new vmware.h include file, it was changed to be a string to better
> fit into the VMWARE_HYPERCALL set of macros. This obviously breaks the
> platform detection VMWARE_PORT functionality.
> 
> Change the VMWARE_HYPERVISOR_PORT and VMWARE_HYPERVISOR_PORT_HB
> definitions to be integers, and use __stringify() for their stringified
> form when needed.
> 
> Fixes: b4dd4f6e3648 ("Add a header file for hypercall definitions")
> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: x86-ml <x86@kernel.org>
> Cc: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/include/asm/vmware.h | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
> index f5fbe3778aef..d20eda0c6ed8 100644
> --- a/arch/x86/include/asm/vmware.h
> +++ b/arch/x86/include/asm/vmware.h
> @@ -4,6 +4,7 @@
>  
>  #include <asm/cpufeatures.h>
>  #include <asm/alternative.h>
> +#include <linux/stringify.h>
>  
>  /*
>   * The hypercall definitions differ in the low word of the %edx argument
> @@ -20,8 +21,8 @@
>   */
>  
>  /* Old port-based version */
> -#define VMWARE_HYPERVISOR_PORT    "0x5658"
> -#define VMWARE_HYPERVISOR_PORT_HB "0x5659"
> +#define VMWARE_HYPERVISOR_PORT    0x5658
> +#define VMWARE_HYPERVISOR_PORT_HB 0x5659
>  
>  /* Current vmcall / vmmcall version */
>  #define VMWARE_HYPERVISOR_HB   BIT(0)
> @@ -29,7 +30,7 @@
>  
>  /* The low bandwidth call. The low word of edx is presumed clear. */
>  #define VMWARE_HYPERCALL						\
> -	ALTERNATIVE_2("movw $" VMWARE_HYPERVISOR_PORT			\
> +	ALTERNATIVE_2("movw $" __stringify(VMWARE_HYPERVISOR_PORT)	\
>  		      ", %%dx; inl (%%dx), %%eax",			\
>  		      "vmcall", X86_FEATURE_VMCALL,			\
>  		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
> @@ -39,7 +40,8 @@
>   * HB and OUT bits set.
>   */
>  #define VMWARE_HYPERCALL_HB_OUT						\
> -	ALTERNATIVE_2("movw $" VMWARE_HYPERVISOR_PORT_HB ", %%dx; rep outsb", \
> +	ALTERNATIVE_2("movw $" __stringify(VMWARE_HYPERVISOR_PORT_HB)	\
> +		      ", %%dx; rep outsb",				\
>  		      "vmcall", X86_FEATURE_VMCALL,			\
>  		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
>  
> @@ -48,7 +50,8 @@
>   * HB bit set.
>   */
>  #define VMWARE_HYPERCALL_HB_IN						\
> -	ALTERNATIVE_2("movw $" VMWARE_HYPERVISOR_PORT_HB ", %%dx; rep insb", \
> +	ALTERNATIVE_2("movw $" __stringify(VMWARE_HYPERVISOR_PORT_HB)	\
> +		      ", %%dx; rep insb",				\

Same comment on wrapping in the middle of an instruction.  Wrapping after
movw will stick out, but only by a char or two.

>  		      "vmcall", X86_FEATURE_VMCALL,			\
>  		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
>  #endif
> -- 
> 2.21.0
> 
