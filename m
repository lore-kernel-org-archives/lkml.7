Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037C4C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 09:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD4420679
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 09:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404798AbfFKJoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 05:44:19 -0400
Received: from foss.arm.com ([217.140.110.172]:56628 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391206AbfFKJoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 05:44:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA080337;
        Tue, 11 Jun 2019 02:44:17 -0700 (PDT)
Received: from [10.1.29.141] (e121487-lin.cambridge.arm.com [10.1.29.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9EE73F73C;
        Tue, 11 Jun 2019 02:45:58 -0700 (PDT)
Subject: Re: [PATCH 01/15] binfmt_flat: remove flat_reloc_valid
To:     Christoph Hellwig <hch@lst.de>, Greg Ungerer <gerg@linux-m68k.org>
Cc:     uclinux-h8-devel@lists.sourceforge.jp,
        linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>,
        linux-c6x-dev@linux-c6x.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20190610212015.9157-1-hch@lst.de>
 <20190610212015.9157-2-hch@lst.de>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <885910f9-9153-4ea6-d060-996b099c520d@arm.com>
Date:   Tue, 11 Jun 2019 10:44:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610212015.9157-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/19 10:20 PM, Christoph Hellwig wrote:
> This helper is the same for all architectures, open code it in the only
> caller.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm/include/asm/flat.h        | 1 -
>  arch/c6x/include/asm/flat.h        | 1 -
>  arch/h8300/include/asm/flat.h      | 1 -
>  arch/m68k/include/asm/flat.h       | 1 -
>  arch/microblaze/include/asm/flat.h | 1 -
>  arch/sh/include/asm/flat.h         | 1 -
>  arch/xtensa/include/asm/flat.h     | 1 -
>  fs/binfmt_flat.c                   | 2 +-
>  8 files changed, 1 insertion(+), 8 deletions(-)

For ARM bits:

Tested-by: Vladimir Murzin <vladimir.murzin@arm.com>
Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>


> 
> diff --git a/arch/arm/include/asm/flat.h b/arch/arm/include/asm/flat.h
> index f0c75ddeea23..10cce9ecf151 100644
> --- a/arch/arm/include/asm/flat.h
> +++ b/arch/arm/include/asm/flat.h
> @@ -10,7 +10,6 @@
>  
>  #define	flat_argvp_envp_on_stack()		1
>  #define	flat_old_ram_flag(flags)		(flags)
> -#define	flat_reloc_valid(reloc, size)		((reloc) <= (size))
>  
>  static inline int flat_get_addr_from_rp(u32 __user *rp, u32 relval, u32 flags,
>  					u32 *addr, u32 *persistent)
> diff --git a/arch/c6x/include/asm/flat.h b/arch/c6x/include/asm/flat.h
> index 76fd0bb962a3..ecc6aea6606c 100644
> --- a/arch/c6x/include/asm/flat.h
> +++ b/arch/c6x/include/asm/flat.h
> @@ -6,7 +6,6 @@
>  
>  #define flat_argvp_envp_on_stack()			0
>  #define flat_old_ram_flag(flags)			(flags)
> -#define flat_reloc_valid(reloc, size)			((reloc) <= (size))
>  static inline int flat_get_addr_from_rp(u32 __user *rp, u32 relval, u32 flags,
>  					u32 *addr, u32 *persistent)
>  {
> diff --git a/arch/h8300/include/asm/flat.h b/arch/h8300/include/asm/flat.h
> index f4cdfcbdd2ba..dcc7775115dd 100644
> --- a/arch/h8300/include/asm/flat.h
> +++ b/arch/h8300/include/asm/flat.h
> @@ -10,7 +10,6 @@
>  
>  #define	flat_argvp_envp_on_stack()		1
>  #define	flat_old_ram_flag(flags)		1
> -#define	flat_reloc_valid(reloc, size)		((reloc) <= (size))
>  #define	flat_set_persistent(relval, p)		0
>  
>  /*
> diff --git a/arch/m68k/include/asm/flat.h b/arch/m68k/include/asm/flat.h
> index 4f1d1e373420..a631caf5e18f 100644
> --- a/arch/m68k/include/asm/flat.h
> +++ b/arch/m68k/include/asm/flat.h
> @@ -10,7 +10,6 @@
>  
>  #define	flat_argvp_envp_on_stack()		1
>  #define	flat_old_ram_flag(flags)		(flags)
> -#define	flat_reloc_valid(reloc, size)		((reloc) <= (size))
>  static inline int flat_get_addr_from_rp(u32 __user *rp, u32 relval, u32 flags,
>  					u32 *addr, u32 *persistent)
>  {
> diff --git a/arch/microblaze/include/asm/flat.h b/arch/microblaze/include/asm/flat.h
> index 3d2747d4c967..34be5ed011be 100644
> --- a/arch/microblaze/include/asm/flat.h
> +++ b/arch/microblaze/include/asm/flat.h
> @@ -15,7 +15,6 @@
>  
>  #define	flat_argvp_envp_on_stack()	0
>  #define	flat_old_ram_flag(flags)	(flags)
> -#define	flat_reloc_valid(reloc, size)	((reloc) <= (size))
>  #define	flat_set_persistent(relval, p)		0
>  
>  /*
> diff --git a/arch/sh/include/asm/flat.h b/arch/sh/include/asm/flat.h
> index 843d458b8329..8f2929b32f2e 100644
> --- a/arch/sh/include/asm/flat.h
> +++ b/arch/sh/include/asm/flat.h
> @@ -13,7 +13,6 @@
>  
>  #define	flat_argvp_envp_on_stack()		0
>  #define	flat_old_ram_flag(flags)		(flags)
> -#define	flat_reloc_valid(reloc, size)		((reloc) <= (size))
>  static inline int flat_get_addr_from_rp(u32 __user *rp, u32 relval, u32 flags,
>  					u32 *addr, u32 *persistent)
>  {
> diff --git a/arch/xtensa/include/asm/flat.h b/arch/xtensa/include/asm/flat.h
> index b8532d7877b3..6ee5a35eb0ec 100644
> --- a/arch/xtensa/include/asm/flat.h
> +++ b/arch/xtensa/include/asm/flat.h
> @@ -6,7 +6,6 @@
>  
>  #define flat_argvp_envp_on_stack()			0
>  #define flat_old_ram_flag(flags)			(flags)
> -#define flat_reloc_valid(reloc, size)			((reloc) <= (size))
>  static inline int flat_get_addr_from_rp(u32 __user *rp, u32 relval, u32 flags,
>  					u32 *addr, u32 *persistent)
>  {
> diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
> index 82a48e830018..afddea583999 100644
> --- a/fs/binfmt_flat.c
> +++ b/fs/binfmt_flat.c
> @@ -345,7 +345,7 @@ calc_reloc(unsigned long r, struct lib_info *p, int curid, int internalp)
>  	start_code = p->lib_list[id].start_code;
>  	text_len = p->lib_list[id].text_len;
>  
> -	if (!flat_reloc_valid(r, start_brk - start_data + text_len)) {
> +	if (r > start_brk - start_data + text_len) {
>  		pr_err("reloc outside program 0x%lx (0 - 0x%lx/0x%lx)",
>  		       r, start_brk-start_data+text_len, text_len);
>  		goto failed;
> 

