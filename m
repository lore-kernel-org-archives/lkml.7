Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4856FC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 19:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EDEE20708
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 19:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574452774;
	bh=CuVuqLAFq+91+XI1syQAK8SoTKh5EKVG19Bm0nXqz6E=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=EkAseI12cWxJjHSgEVt3mAxejmPEV5Sm2wlOfqHnIMBAnU4TAAs6/3sNgtb8IpUOF
	 xKMaditvMeeQjjFIcZq+IsU6S1VgiMmQ5TKQppXilRxwb/4LOOs4jmmiLAUUpF+bN0
	 ONoJZmHSgQTbZGJjM9WbhFs6n7sWMKLgDBFJgw/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfKVT7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 14:59:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:60578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbfKVT7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 14:59:32 -0500
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 257CD20704;
        Fri, 22 Nov 2019 19:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574452771;
        bh=CuVuqLAFq+91+XI1syQAK8SoTKh5EKVG19Bm0nXqz6E=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=g5MAeRzpM1Xl64PGuBdI0c+qk+7bFJiLqssQ7I8du3IF73Y42nBDy/LdXSuIGue2D
         Ng06Q1UnkbqaSEPSjRzpe9zHCgwTMQ+tbphRu2R24S0JPm3zNVoIlw6cZjZbwXMTP9
         C67z5KO+jMWiXW6eA80zDm60iXci0SqFVhxiaii0=
Date:   Fri, 22 Nov 2019 11:59:29 -0800 (PST)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
cc:     jmorris@namei.org, sashal@kernel.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, steve.capper@arm.com,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com, mark.rutland@arm.com,
        tglx@linutronix.de, gregkh@linuxfoundation.org,
        allison@lohutok.net, info@metux.net, alexios.zavras@intel.com,
        sstabellini@kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, stefan@agner.ch, yamada.masahiro@socionext.com,
        xen-devel@lists.xenproject.org, linux@armlinux.org.uk
Subject: Re: [PATCH v2 1/3] arm/arm64/xen: use C inlines for privcmd_call
In-Reply-To: <20191122022406.590141-2-pasha.tatashin@soleen.com>
Message-ID: <alpine.DEB.2.21.1911221159160.11302@sstabellini-ThinkPad-T480s>
References: <20191122022406.590141-1-pasha.tatashin@soleen.com> <20191122022406.590141-2-pasha.tatashin@soleen.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2019, Pavel Tatashin wrote:
> privcmd_call requires to enable access to userspace for the
> duration of the hypercall.
> 
> Currently, this is done via assembly macros. Change it to C
> inlines instead.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>

I am OK with this.

Acked-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  arch/arm/include/asm/assembler.h       |  2 +-
>  arch/arm/include/asm/xen/hypercall.h   | 10 +++++++++
>  arch/arm/xen/enlighten.c               |  2 +-
>  arch/arm/xen/hypercall.S               |  4 ++--
>  arch/arm64/include/asm/xen/hypercall.h | 28 ++++++++++++++++++++++++++
>  arch/arm64/xen/hypercall.S             | 19 ++---------------
>  include/xen/arm/hypercall.h            | 12 +++++------
>  7 files changed, 50 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
> index 99929122dad7..8e9262a0f016 100644
> --- a/arch/arm/include/asm/assembler.h
> +++ b/arch/arm/include/asm/assembler.h
> @@ -480,7 +480,7 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
>  	.macro	uaccess_disable, tmp, isb=1
>  #ifdef CONFIG_CPU_SW_DOMAIN_PAN
>  	/*
> -	 * Whenever we re-enter userspace, the domains should always be
> +	 * Whenever we re-enter kernel, the domains should always be
>  	 * set appropriately.
>  	 */
>  	mov	\tmp, #DACR_UACCESS_DISABLE
> diff --git a/arch/arm/include/asm/xen/hypercall.h b/arch/arm/include/asm/xen/hypercall.h
> index 3522cbaed316..cac5bd9ef519 100644
> --- a/arch/arm/include/asm/xen/hypercall.h
> +++ b/arch/arm/include/asm/xen/hypercall.h
> @@ -1 +1,11 @@
> +#ifndef _ASM_ARM_XEN_HYPERCALL_H
> +#define _ASM_ARM_XEN_HYPERCALL_H
>  #include <xen/arm/hypercall.h>
> +
> +static inline long privcmd_call(unsigned int call, unsigned long a1,
> +				unsigned long a2, unsigned long a3,
> +				unsigned long a4, unsigned long a5)
> +{
> +	return arch_privcmd_call(call, a1, a2, a3, a4, a5);
> +}
> +#endif /* _ASM_ARM_XEN_HYPERCALL_H */
> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> index dd6804a64f1a..e87280c6d25d 100644
> --- a/arch/arm/xen/enlighten.c
> +++ b/arch/arm/xen/enlighten.c
> @@ -440,4 +440,4 @@ EXPORT_SYMBOL_GPL(HYPERVISOR_platform_op_raw);
>  EXPORT_SYMBOL_GPL(HYPERVISOR_multicall);
>  EXPORT_SYMBOL_GPL(HYPERVISOR_vm_assist);
>  EXPORT_SYMBOL_GPL(HYPERVISOR_dm_op);
> -EXPORT_SYMBOL_GPL(privcmd_call);
> +EXPORT_SYMBOL_GPL(arch_privcmd_call);
> diff --git a/arch/arm/xen/hypercall.S b/arch/arm/xen/hypercall.S
> index b11bba542fac..277078c7da49 100644
> --- a/arch/arm/xen/hypercall.S
> +++ b/arch/arm/xen/hypercall.S
> @@ -94,7 +94,7 @@ HYPERCALL2(multicall);
>  HYPERCALL2(vm_assist);
>  HYPERCALL3(dm_op);
>  
> -ENTRY(privcmd_call)
> +ENTRY(arch_privcmd_call)
>  	stmdb sp!, {r4}
>  	mov r12, r0
>  	mov r0, r1
> @@ -119,4 +119,4 @@ ENTRY(privcmd_call)
>  
>  	ldm sp!, {r4}
>  	ret lr
> -ENDPROC(privcmd_call);
> +ENDPROC(arch_privcmd_call);
> diff --git a/arch/arm64/include/asm/xen/hypercall.h b/arch/arm64/include/asm/xen/hypercall.h
> index 3522cbaed316..1a74fb28607f 100644
> --- a/arch/arm64/include/asm/xen/hypercall.h
> +++ b/arch/arm64/include/asm/xen/hypercall.h
> @@ -1 +1,29 @@
> +#ifndef _ASM_ARM64_XEN_HYPERCALL_H
> +#define _ASM_ARM64_XEN_HYPERCALL_H
>  #include <xen/arm/hypercall.h>
> +#include <linux/uaccess.h>
> +
> +static inline long privcmd_call(unsigned int call, unsigned long a1,
> +				unsigned long a2, unsigned long a3,
> +				unsigned long a4, unsigned long a5)
> +{
> +	long rv;
> +
> +	/*
> +	 * Privcmd calls are issued by the userspace. The kernel needs to
> +	 * enable access to TTBR0_EL1 as the hypervisor would issue stage 1
> +	 * translations to user memory via AT instructions. Since AT
> +	 * instructions are not affected by the PAN bit (ARMv8.1), we only
> +	 * need the explicit uaccess_enable/disable if the TTBR0 PAN emulation
> +	 * is enabled (it implies that hardware UAO and PAN disabled).
> +	 */
> +	uaccess_ttbr0_enable();
> +	rv = arch_privcmd_call(call, a1, a2, a3, a4, a5);
> +	/*
> +	 * Disable userspace access from kernel once the hyp call completed.
> +	 */
> +	uaccess_ttbr0_disable();
> +
> +	return rv;
> +}
> +#endif /* _ASM_ARM64_XEN_HYPERCALL_H */
> diff --git a/arch/arm64/xen/hypercall.S b/arch/arm64/xen/hypercall.S
> index c5f05c4a4d00..921611778d2a 100644
> --- a/arch/arm64/xen/hypercall.S
> +++ b/arch/arm64/xen/hypercall.S
> @@ -49,7 +49,6 @@
>  
>  #include <linux/linkage.h>
>  #include <asm/assembler.h>
> -#include <asm/asm-uaccess.h>
>  #include <xen/interface/xen.h>
>  
>  
> @@ -86,27 +85,13 @@ HYPERCALL2(multicall);
>  HYPERCALL2(vm_assist);
>  HYPERCALL3(dm_op);
>  
> -ENTRY(privcmd_call)
> +ENTRY(arch_privcmd_call)
>  	mov x16, x0
>  	mov x0, x1
>  	mov x1, x2
>  	mov x2, x3
>  	mov x3, x4
>  	mov x4, x5
> -	/*
> -	 * Privcmd calls are issued by the userspace. The kernel needs to
> -	 * enable access to TTBR0_EL1 as the hypervisor would issue stage 1
> -	 * translations to user memory via AT instructions. Since AT
> -	 * instructions are not affected by the PAN bit (ARMv8.1), we only
> -	 * need the explicit uaccess_enable/disable if the TTBR0 PAN emulation
> -	 * is enabled (it implies that hardware UAO and PAN disabled).
> -	 */
> -	uaccess_ttbr0_enable x6, x7, x8
>  	hvc XEN_IMM
> -
> -	/*
> -	 * Disable userspace access from kernel once the hyp call completed.
> -	 */
> -	uaccess_ttbr0_disable x6, x7
>  	ret
> -ENDPROC(privcmd_call);
> +ENDPROC(arch_privcmd_call);
> diff --git a/include/xen/arm/hypercall.h b/include/xen/arm/hypercall.h
> index b40485e54d80..624c8ad7e42a 100644
> --- a/include/xen/arm/hypercall.h
> +++ b/include/xen/arm/hypercall.h
> @@ -30,8 +30,8 @@
>   * IN THE SOFTWARE.
>   */
>  
> -#ifndef _ASM_ARM_XEN_HYPERCALL_H
> -#define _ASM_ARM_XEN_HYPERCALL_H
> +#ifndef _ARM_XEN_HYPERCALL_H
> +#define _ARM_XEN_HYPERCALL_H
>  
>  #include <linux/bug.h>
>  
> @@ -41,9 +41,9 @@
>  
>  struct xen_dm_op_buf;
>  
> -long privcmd_call(unsigned call, unsigned long a1,
> -		unsigned long a2, unsigned long a3,
> -		unsigned long a4, unsigned long a5);
> +long arch_privcmd_call(unsigned int call, unsigned long a1,
> +		       unsigned long a2, unsigned long a3,
> +		       unsigned long a4, unsigned long a5);
>  int HYPERVISOR_xen_version(int cmd, void *arg);
>  int HYPERVISOR_console_io(int cmd, int count, char *str);
>  int HYPERVISOR_grant_table_op(unsigned int cmd, void *uop, unsigned int count);
> @@ -88,4 +88,4 @@ MULTI_mmu_update(struct multicall_entry *mcl, struct mmu_update *req,
>  	BUG();
>  }
>  
> -#endif /* _ASM_ARM_XEN_HYPERCALL_H */
> +#endif /* _ARM_XEN_HYPERCALL_H */
> -- 
> 2.24.0
> 
