Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F463C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044AD206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="YO0r1N+8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbfH0M4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 08:56:45 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36316 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbfH0M4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:56:44 -0400
Received: from zn.tnic (p200300EC2F0CD000F02F6C1468024718.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:d000:f02f:6c14:6802:4718])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A023A1EC0965;
        Tue, 27 Aug 2019 14:56:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1566910602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VuIKwTM8o13fXgQOHtIipKiKdXhIk+F+ObNMdFSRjGE=;
        b=YO0r1N+8dwF+voB3H9nrb96DNKYZIOueZgyGYwNLAJmh+wF9OAy4j2uLYNU9YmpYSZQ1az
        QgiwojSVAI463F2ZjkbWLOippMueRkokjnS8yfTKaLZPSa6QNuNVLTEV/A79MwsDZLVw2Y
        SV7CYSU+43qUXbVEcNeC5PWv6tNO2cw=
Date:   Tue, 27 Aug 2019 14:56:36 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas =?utf-8?Q?Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     linux-kernel@vger.kernel.org, pv-drivers@vmware.com,
        linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        dri-devel@lists.freedekstop.org, Doug Covelli <dcovelli@vmware.com>
Subject: Re: [PATCH v2 1/4] x86/vmware: Update platform detection code for
 VMCALL/VMMCALL hypercalls
Message-ID: <20190827125636.GE29752@zn.tnic>
References: <20190823081316.28478-1-thomas_os@shipmail.org>
 <20190823081316.28478-2-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190823081316.28478-2-thomas_os@shipmail.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 10:13:13AM +0200, Thomas Hellström (VMware) wrote:
> From: Thomas Hellstrom <thellstrom@vmware.com>
> 
> Vmware has historically used an "inl" instruction for this, but recent
> hardware versions support using VMCALL/VMMCALL instead, so use this method
> if supported at platform detection time. We explicitly need to code

Pls use passive voice in your commit message: no "we" or "I", etc, and
describe your changes in imperative mood.

> separate macro versions since the alternatives self-patching has not
> been performed at platform detection time.
> 
> Also put tighter constraints on the assembly input parameters.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: <x86@kernel.org>
> Cc: <dri-devel@lists.freedekstop.org>
> Co-developed-by: Doug Covelli <dcovelli@vmware.com>
> Signed-off-by: Doug Covelli <dcovelli@vmware.com>
> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
> Reviewed-by: Doug Covelli <dcovelli@vmware.com>
> ---
>  arch/x86/kernel/cpu/vmware.c | 88 +++++++++++++++++++++++++++++-------
>  1 file changed, 71 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
> index 3c648476d4fb..fcb84b1e099e 100644
> --- a/arch/x86/kernel/cpu/vmware.c
> +++ b/arch/x86/kernel/cpu/vmware.c
> @@ -30,34 +30,70 @@
>  #include <asm/hypervisor.h>
>  #include <asm/timer.h>
>  #include <asm/apic.h>
> +#include <asm/svm.h>

That include is for?

>  #undef pr_fmt
>  #define pr_fmt(fmt)	"vmware: " fmt
>  
> -#define CPUID_VMWARE_INFO_LEAF	0x40000000
> +#define CPUID_VMWARE_INFO_LEAF               0x40000000
> +#define CPUID_VMWARE_FEATURES_LEAF           0x40000010
> +#define CPUID_VMWARE_FEATURES_ECX_VMMCALL    BIT(0)
> +#define CPUID_VMWARE_FEATURES_ECX_VMCALL     BIT(1)
> +
>  #define VMWARE_HYPERVISOR_MAGIC	0x564D5868
>  #define VMWARE_HYPERVISOR_PORT	0x5658
>  
> -#define VMWARE_PORT_CMD_GETVERSION	10
> -#define VMWARE_PORT_CMD_GETHZ		45
> -#define VMWARE_PORT_CMD_GETVCPU_INFO	68
> -#define VMWARE_PORT_CMD_LEGACY_X2APIC	3
> -#define VMWARE_PORT_CMD_VCPU_RESERVED	31
> +#define VMWARE_CMD_GETVERSION    10
> +#define VMWARE_CMD_GETHZ         45
> +#define VMWARE_CMD_GETVCPU_INFO  68
> +#define VMWARE_CMD_LEGACY_X2APIC  3
> +#define VMWARE_CMD_VCPU_RESERVED 31
>
>  #define VMWARE_PORT(cmd, eax, ebx, ecx, edx)				\
>  	__asm__("inl (%%dx)" :						\
> -			"=a"(eax), "=c"(ecx), "=d"(edx), "=b"(ebx) :	\
> -			"0"(VMWARE_HYPERVISOR_MAGIC),			\
> -			"1"(VMWARE_PORT_CMD_##cmd),			\
> -			"2"(VMWARE_HYPERVISOR_PORT), "3"(UINT_MAX) :	\
> -			"memory");
> +		"=a"(eax), "=c"(ecx), "=d"(edx), "=b"(ebx) :		\
> +		"a"(VMWARE_HYPERVISOR_MAGIC),				\
> +		"c"(VMWARE_CMD_##cmd),					\
> +		"d"(VMWARE_HYPERVISOR_PORT), "b"(UINT_MAX) :		\
> +		"memory")
> +
> +#define VMWARE_VMCALL(cmd, eax, ebx, ecx, edx)				\
> +	__asm__("vmcall" :						\
> +		"=a"(eax), "=c"(ecx), "=d"(edx), "=b"(ebx) :		\
> +		"a"(VMWARE_HYPERVISOR_MAGIC),				\
> +		"c"(VMWARE_CMD_##cmd),					\
> +		"d"(0), "b"(UINT_MAX) :					\
> +		"memory")
> +
> +#define VMWARE_VMMCALL(cmd, eax, ebx, ecx, edx)                         \
> +	__asm__("vmmcall" :						\
> +		"=a"(eax), "=c"(ecx), "=d"(edx), "=b"(ebx) :		\
> +		"a"(VMWARE_HYPERVISOR_MAGIC),				\
> +		"c"(VMWARE_CMD_##cmd),					\
> +		"d"(0), "b"(UINT_MAX) :					\
> +		"memory")
> +
> +#define VMWARE_CMD(cmd, eax, ebx, ecx, edx) do {		\
> +	switch (vmware_hypercall_mode) {			\
> +	case CPUID_VMWARE_FEATURES_ECX_VMCALL:			\
> +		VMWARE_VMCALL(cmd, eax, ebx, ecx, edx);		\
> +		break;						\
> +	case CPUID_VMWARE_FEATURES_ECX_VMMCALL:			\
> +		VMWARE_VMMCALL(cmd, eax, ebx, ecx, edx);	\
> +		break;						\
> +	default:						\

Please integrate scripts/checkpatch.pl into your patch creation
workflow. Some of the warnings/errors *actually* make sense:

WARNING: Possible switch case/default not preceded by break or fallthrough comment
#110: FILE: arch/x86/kernel/cpu/vmware.c:81:
+       case CPUID_VMWARE_FEATURES_ECX_VMMCALL:                 \

WARNING: Possible switch case/default not preceded by break or fallthrough comment
#113: FILE: arch/x86/kernel/cpu/vmware.c:84:
+       default:

In this case, we're going to enable -Wimplicit-fallthrough by default at
some point.

> +		VMWARE_PORT(cmd, eax, ebx, ecx, edx);		\
> +		break;						\
> +	}							\
> +	} while (0)
>  
>  static unsigned long vmware_tsc_khz __ro_after_init;
> +static u8 vmware_hypercall_mode     __ro_after_init;
>  
>  static inline int __vmware_platform(void)
>  {
>  	uint32_t eax, ebx, ecx, edx;
> -	VMWARE_PORT(GETVERSION, eax, ebx, ecx, edx);
> +	VMWARE_CMD(GETVERSION, eax, ebx, ecx, edx);
>  	return eax != (uint32_t)-1 && ebx == VMWARE_HYPERVISOR_MAGIC;
>  }
>  
> @@ -136,7 +172,7 @@ static void __init vmware_platform_setup(void)
>  	uint32_t eax, ebx, ecx, edx;
>  	uint64_t lpj, tsc_khz;
>  
> -	VMWARE_PORT(GETHZ, eax, ebx, ecx, edx);
> +	VMWARE_CMD(GETHZ, eax, ebx, ecx, edx);
>  
>  	if (ebx != UINT_MAX) {
>  		lpj = tsc_khz = eax | (((uint64_t)ebx) << 32);
> @@ -174,6 +210,16 @@ static void __init vmware_platform_setup(void)
>  	vmware_set_capabilities();
>  }
>  
> +static u8

No need for that linebreak here.

> +vmware_select_hypercall(void)
> +{
> +	int eax, ebx, ecx, edx;
> +
> +	cpuid(CPUID_VMWARE_FEATURES_LEAF, &eax, &ebx, &ecx, &edx);
> +	return (ecx & (CPUID_VMWARE_FEATURES_ECX_VMMCALL |
> +		       CPUID_VMWARE_FEATURES_ECX_VMCALL));
> +}
> +
>  /*
>   * While checking the dmi string information, just checking the product
>   * serial key should be enough, as this will always have a VMware
> @@ -187,8 +233,16 @@ static uint32_t __init vmware_platform(void)
>  
>  		cpuid(CPUID_VMWARE_INFO_LEAF, &eax, &hyper_vendor_id[0],
>  		      &hyper_vendor_id[1], &hyper_vendor_id[2]);
> -		if (!memcmp(hyper_vendor_id, "VMwareVMware", 12))
> +		if (!memcmp(hyper_vendor_id, "VMwareVMware", 12)) {
> +			if (eax >= CPUID_VMWARE_FEATURES_LEAF)
> +				vmware_hypercall_mode =
> +					vmware_select_hypercall();
> +
> +			pr_info("hypercall mode: 0x%02x\n",
> +				(unsigned int) vmware_hypercall_mode);

Is that supposed to be debug output? If so, pr_dbg().

> +
>  			return CPUID_VMWARE_INFO_LEAF;
> +		}
>  	} else if (dmi_available && dmi_name_in_serial("VMware") &&
>  		   __vmware_platform())

What sets vmware_hypercall_mode in this case? Or is the 0 magic to mean,
use the default: VMWARE_PORT inl call?

Also, you could restructure that function something like this to save yourself
an indentation level or two and make it more easily readable:

static uint32_t __init vmware_platform(void)
{
        unsigned int hyper_vendor_id[3];
        unsigned int eax;

        if (!boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
                if (dmi_available && dmi_name_in_serial("VMware") && __vmware_platform())
                        return 1;
        }

        cpuid(CPUID_VMWARE_INFO_LEAF, &eax, &hyper_vendor_id[0],
              &hyper_vendor_id[1], &hyper_vendor_id[2]);

        if (!memcmp(hyper_vendor_id, "VMwareVMware", 12)) {
                if (eax >= CPUID_VMWARE_FEATURES_LEAF)
                        vmware_hypercall_mode = vmware_select_hypercall();

                pr_info("hypercall mode: 0x%02x\n", (unsigned int) vmware_hypercall_mode);

                return CPUID_VMWARE_INFO_LEAF;
        }
        return 0;
}

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
