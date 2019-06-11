Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290A2C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D772086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405162AbfFKKBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 06:01:52 -0400
Received: from foss.arm.com ([217.140.110.172]:57220 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404406AbfFKKBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 06:01:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA8BF337;
        Tue, 11 Jun 2019 03:01:50 -0700 (PDT)
Received: from [10.1.29.141] (e121487-lin.cambridge.arm.com [10.1.29.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C929B3F73C;
        Tue, 11 Jun 2019 03:03:31 -0700 (PDT)
Subject: Re: [PATCH 11/15] binfmt_flat: provide an asm-generic/flat.h
To:     Christoph Hellwig <hch@lst.de>, Greg Ungerer <gerg@linux-m68k.org>
Cc:     uclinux-h8-devel@lists.sourceforge.jp,
        linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>,
        linux-c6x-dev@linux-c6x.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20190610212015.9157-1-hch@lst.de>
 <20190610212015.9157-12-hch@lst.de>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <e6a00ae6-3359-0f20-138c-4469df598c3e@arm.com>
Date:   Tue, 11 Jun 2019 11:01:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610212015.9157-12-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/19 10:20 PM, Christoph Hellwig wrote:
> This file implements the flat get/put reloc helpers for architectures
> that do not need to overload the relocs by simply using get_user/put_user.
> 
> Note that many nommu architectures currently use {get,put}_unaligned, which
> looks a little bogus and should probably later be switched over to this
> version as well.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm/include/asm/Kbuild                   |  1 +
>  arch/m68k/include/asm/flat.h                  | 21 +------------------
>  .../asm => include/asm-generic}/flat.h        | 12 ++++-------
>  3 files changed, 6 insertions(+), 28 deletions(-)
>  rename {arch/arm/include/asm => include/asm-generic}/flat.h (73%)

FWIW:

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>

> 
> diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
> index a8f149ab45b8..6b2dc15b6dff 100644
> --- a/arch/arm/include/asm/Kbuild
> +++ b/arch/arm/include/asm/Kbuild
> @@ -5,6 +5,7 @@ generic-y += early_ioremap.h
>  generic-y += emergency-restart.h
>  generic-y += exec.h
>  generic-y += extable.h
> +generic-y += flat.h
>  generic-y += irq_regs.h
>  generic-y += kdebug.h
>  generic-y += local.h
> diff --git a/arch/m68k/include/asm/flat.h b/arch/m68k/include/asm/flat.h
> index d7102fcd43eb..46379e08cdd6 100644
> --- a/arch/m68k/include/asm/flat.h
> +++ b/arch/m68k/include/asm/flat.h
> @@ -6,26 +6,7 @@
>  #ifndef __M68KNOMMU_FLAT_H__
>  #define __M68KNOMMU_FLAT_H__
>  
> -#include <linux/uaccess.h>
> -
> -static inline int flat_get_addr_from_rp(u32 __user *rp, u32 relval, u32 flags,
> -					u32 *addr, u32 *persistent)
> -{
> -#ifdef CONFIG_CPU_HAS_NO_UNALIGNED
> -	return copy_from_user(addr, rp, 4) ? -EFAULT : 0;
> -#else
> -	return get_user(*addr, rp);
> -#endif
> -}
> -
> -static inline int flat_put_addr_at_rp(u32 __user *rp, u32 addr, u32 rel)
> -{
> -#ifdef CONFIG_CPU_HAS_NO_UNALIGNED
> -	return copy_to_user(rp, &addr, 4) ? -EFAULT : 0;
> -#else
> -	return put_user(addr, rp);
> -#endif
> -}
> +#include <asm-generic/flat.h>
>  
>  #define FLAT_PLAT_INIT(regs) \
>  	do { \
> diff --git a/arch/arm/include/asm/flat.h b/include/asm-generic/flat.h
> similarity index 73%
> rename from arch/arm/include/asm/flat.h
> rename to include/asm-generic/flat.h
> index bbc27901446f..fcd2b45c0735 100644
> --- a/arch/arm/include/asm/flat.h
> +++ b/include/asm-generic/flat.h
> @@ -1,15 +1,11 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * arch/arm/include/asm/flat.h -- uClinux flat-format executables
> - */
> -
> -#ifndef __ARM_FLAT_H__
> -#define __ARM_FLAT_H__
> +#ifndef _ASM_GENERIC_FLAT_H
> +#define _ASM_GENERIC_FLAT_H
>  
>  #include <linux/uaccess.h>
>  
>  static inline int flat_get_addr_from_rp(u32 __user *rp, u32 relval, u32 flags,
> -					u32 *addr, u32 *persistent)
> +		u32 *addr, u32 *persistent)
>  {
>  #ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
>  	return copy_from_user(addr, rp, 4) ? -EFAULT : 0;
> @@ -27,4 +23,4 @@ static inline int flat_put_addr_at_rp(u32 __user *rp, u32 addr, u32 rel)
>  #endif
>  }
>  
> -#endif /* __ARM_FLAT_H__ */
> +#endif /* _ASM_GENERIC_FLAT_H */
> 

