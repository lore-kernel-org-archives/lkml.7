Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9288C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 09:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C518120679
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 09:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404860AbfFKJqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 05:46:22 -0400
Received: from foss.arm.com ([217.140.110.172]:56722 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404803AbfFKJqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 05:46:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2E7B337;
        Tue, 11 Jun 2019 02:46:20 -0700 (PDT)
Received: from [10.1.29.141] (e121487-lin.cambridge.arm.com [10.1.29.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C24713F73C;
        Tue, 11 Jun 2019 02:48:01 -0700 (PDT)
Subject: Re: [PATCH 03/15] binfmt_flat: provide a default version of
 flat_get_relocate_addr
To:     Christoph Hellwig <hch@lst.de>, Greg Ungerer <gerg@linux-m68k.org>
Cc:     uclinux-h8-devel@lists.sourceforge.jp,
        linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>,
        linux-c6x-dev@linux-c6x.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20190610212015.9157-1-hch@lst.de>
 <20190610212015.9157-4-hch@lst.de>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <6b676893-3b79-ed8f-01c9-8ab2d3acec65@arm.com>
Date:   Tue, 11 Jun 2019 10:46:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610212015.9157-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/19 10:20 PM, Christoph Hellwig wrote:
> This way only the two architectures that do masking need to provide
> the helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm/include/asm/flat.h    | 2 --
>  arch/c6x/include/asm/flat.h    | 1 -
>  arch/m68k/include/asm/flat.h   | 1 -
>  arch/sh/include/asm/flat.h     | 1 -
>  arch/xtensa/include/asm/flat.h | 1 -
>  fs/binfmt_flat.c               | 4 ++++
>  6 files changed, 4 insertions(+), 6 deletions(-)


For ARM bits:

Tested-by: Vladimir Murzin <vladimir.murzin@arm.com>
Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>


> 
> diff --git a/arch/arm/include/asm/flat.h b/arch/arm/include/asm/flat.h
> index 576241d74704..a185fe023b60 100644
> --- a/arch/arm/include/asm/flat.h
> +++ b/arch/arm/include/asm/flat.h
> @@ -30,6 +30,4 @@ static inline int flat_put_addr_at_rp(u32 __user *rp, u32 addr, u32 rel)
>  #endif
>  }
>  
> -#define	flat_get_relocate_addr(rel)		(rel)
> -
>  #endif /* __ARM_FLAT_H__ */
> diff --git a/arch/c6x/include/asm/flat.h b/arch/c6x/include/asm/flat.h
> index ac87368efad1..c4d703b454c6 100644
> --- a/arch/c6x/include/asm/flat.h
> +++ b/arch/c6x/include/asm/flat.h
> @@ -17,6 +17,5 @@ static inline int flat_put_addr_at_rp(u32 __user *rp, u32 addr, u32 rel)
>  	put_unaligned(addr, (__force u32 *)rp);
>  	return 0;
>  }
> -#define flat_get_relocate_addr(rel)			(rel)
>  
>  #endif /* __ASM_C6X_FLAT_H */
> diff --git a/arch/m68k/include/asm/flat.h b/arch/m68k/include/asm/flat.h
> index 955617bb937b..217fa89c8e34 100644
> --- a/arch/m68k/include/asm/flat.h
> +++ b/arch/m68k/include/asm/flat.h
> @@ -28,7 +28,6 @@ static inline int flat_put_addr_at_rp(u32 __user *rp, u32 addr, u32 rel)
>  	return put_user(addr, rp);
>  #endif
>  }
> -#define	flat_get_relocate_addr(rel)		(rel)
>  
>  #define FLAT_PLAT_INIT(regs) \
>  	do { \
> diff --git a/arch/sh/include/asm/flat.h b/arch/sh/include/asm/flat.h
> index 6f3b18679a98..0d520b4cc5ea 100644
> --- a/arch/sh/include/asm/flat.h
> +++ b/arch/sh/include/asm/flat.h
> @@ -24,7 +24,6 @@ static inline int flat_put_addr_at_rp(u32 __user *rp, u32 addr, u32 rel)
>  	put_unaligned(addr, (__force u32 *)rp);
>  	return 0;
>  }
> -#define	flat_get_relocate_addr(rel)		(rel)
>  
>  #define FLAT_PLAT_INIT(_r) \
>    do { _r->regs[0]=0; _r->regs[1]=0; _r->regs[2]=0; _r->regs[3]=0; \
> diff --git a/arch/xtensa/include/asm/flat.h b/arch/xtensa/include/asm/flat.h
> index b1bc0d9a8d4e..a1d88aa3ef8a 100644
> --- a/arch/xtensa/include/asm/flat.h
> +++ b/arch/xtensa/include/asm/flat.h
> @@ -17,6 +17,5 @@ static inline int flat_put_addr_at_rp(u32 __user *rp, u32 addr, u32 rel)
>  	put_unaligned(addr, (__force u32 *)rp);
>  	return 0;
>  }
> -#define flat_get_relocate_addr(rel)			(rel)
>  
>  #endif /* __ASM_XTENSA_FLAT_H */
> diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
> index a4c0b245ab1f..c0e4535dc1ec 100644
> --- a/fs/binfmt_flat.c
> +++ b/fs/binfmt_flat.c
> @@ -43,6 +43,10 @@
>  #include <asm/cacheflush.h>
>  #include <asm/page.h>
>  
> +#ifndef flat_get_relocate_addr
> +#define flat_get_relocate_addr(rel)	(rel)
> +#endif
> +
>  /****************************************************************************/
>  
>  /*
> 

