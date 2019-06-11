Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DD5C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 06:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCC9920896
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 06:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391295AbfFKGEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 02:04:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:51484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391051AbfFKGEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 02:04:44 -0400
Received: from [10.44.0.22] (unknown [103.48.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90ED520679;
        Tue, 11 Jun 2019 06:04:41 +0000 (UTC)
Subject: Re: [PATCH 04/15] binfmt_flat: remove flat_old_ram_flag
To:     Christoph Hellwig <hch@lst.de>
Cc:     Michal Simek <monstr@monstr.eu>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org
References: <20190610212015.9157-1-hch@lst.de>
 <20190610212015.9157-5-hch@lst.de>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <b1ce6fc6-343c-7686-b4f4-35a305dc2adb@linux-m68k.org>
Date:   Tue, 11 Jun 2019 16:04:39 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610212015.9157-5-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 11/6/19 7:20 am, Christoph Hellwig wrote:
> Instead add a Kconfig variable that only h8300 selects.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/arm/include/asm/flat.h        | 1 -
>   arch/c6x/include/asm/flat.h        | 1 -
>   arch/h8300/Kconfig                 | 1 +
>   arch/h8300/include/asm/flat.h      | 1 -
>   arch/m68k/include/asm/flat.h       | 1 -
>   arch/microblaze/include/asm/flat.h | 1 -
>   arch/sh/include/asm/flat.h         | 1 -
>   arch/xtensa/include/asm/flat.h     | 1 -
>   fs/Kconfig.binfmt                  | 3 +++
>   fs/binfmt_flat.c                   | 3 ++-
>   10 files changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/include/asm/flat.h b/arch/arm/include/asm/flat.h
> index a185fe023b60..acf162111ee2 100644
> --- a/arch/arm/include/asm/flat.h
> +++ b/arch/arm/include/asm/flat.h
> @@ -9,7 +9,6 @@
>   #include <linux/uaccess.h>
>   
>   #define	flat_argvp_envp_on_stack()		1
> -#define	flat_old_ram_flag(flags)		(flags)
>   
>   static inline int flat_get_addr_from_rp(u32 __user *rp, u32 relval, u32 flags,
>   					u32 *addr, u32 *persistent)
> diff --git a/arch/c6x/include/asm/flat.h b/arch/c6x/include/asm/flat.h
> index c4d703b454c6..353e4d06e8c0 100644
> --- a/arch/c6x/include/asm/flat.h
> +++ b/arch/c6x/include/asm/flat.h
> @@ -5,7 +5,6 @@
>   #include <asm/unaligned.h>
>   
>   #define flat_argvp_envp_on_stack()			0
> -#define flat_old_ram_flag(flags)			(flags)
>   static inline int flat_get_addr_from_rp(u32 __user *rp, u32 relval, u32 flags,
>   					u32 *addr, u32 *persistent)
>   {
> diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
> index ecfc4b4b6373..d30e8727b02d 100644
> --- a/arch/h8300/Kconfig
> +++ b/arch/h8300/Kconfig
> @@ -2,6 +2,7 @@
>   config H8300
>           def_bool y
>   	select ARCH_32BIT_OFF_T
> +	select BINFMT_FLAT_OLD_ALWAYS_RAM
>   	select GENERIC_ATOMIC64
>   	select HAVE_UID16
>   	select VIRT_TO_BUS
> diff --git a/arch/h8300/include/asm/flat.h b/arch/h8300/include/asm/flat.h
> index 7ef7eefded3d..14cc928d5478 100644
> --- a/arch/h8300/include/asm/flat.h
> +++ b/arch/h8300/include/asm/flat.h
> @@ -9,7 +9,6 @@
>   #include <asm/unaligned.h>
>   
>   #define	flat_argvp_envp_on_stack()		1
> -#define	flat_old_ram_flag(flags)		1
>   
>   /*
>    * on the H8 a couple of the relocations have an instruction in the
> diff --git a/arch/m68k/include/asm/flat.h b/arch/m68k/include/asm/flat.h
> index 217fa89c8e34..7b1fb5c2809e 100644
> --- a/arch/m68k/include/asm/flat.h
> +++ b/arch/m68k/include/asm/flat.h
> @@ -9,7 +9,6 @@
>   #include <linux/uaccess.h>
>   
>   #define	flat_argvp_envp_on_stack()		1
> -#define	flat_old_ram_flag(flags)		(flags)
>   static inline int flat_get_addr_from_rp(u32 __user *rp, u32 relval, u32 flags,
>   					u32 *addr, u32 *persistent)
>   {
> diff --git a/arch/microblaze/include/asm/flat.h b/arch/microblaze/include/asm/flat.h
> index 846084fa7f04..1cd8d7f4cf12 100644
> --- a/arch/microblaze/include/asm/flat.h
> +++ b/arch/microblaze/include/asm/flat.h
> @@ -14,7 +14,6 @@
>   #include <asm/unaligned.h>
>   
>   #define	flat_argvp_envp_on_stack()	0
> -#define	flat_old_ram_flag(flags)	(flags)
>   
>   /*
>    * Microblaze works a little differently from other arches, because
> diff --git a/arch/sh/include/asm/flat.h b/arch/sh/include/asm/flat.h
> index 0d520b4cc5ea..015678d7b771 100644
> --- a/arch/sh/include/asm/flat.h
> +++ b/arch/sh/include/asm/flat.h
> @@ -12,7 +12,6 @@
>   #include <asm/unaligned.h>
>   
>   #define	flat_argvp_envp_on_stack()		0
> -#define	flat_old_ram_flag(flags)		(flags)
>   static inline int flat_get_addr_from_rp(u32 __user *rp, u32 relval, u32 flags,
>   					u32 *addr, u32 *persistent)
>   {
> diff --git a/arch/xtensa/include/asm/flat.h b/arch/xtensa/include/asm/flat.h
> index a1d88aa3ef8a..b215c1e66958 100644
> --- a/arch/xtensa/include/asm/flat.h
> +++ b/arch/xtensa/include/asm/flat.h
> @@ -5,7 +5,6 @@
>   #include <asm/unaligned.h>
>   
>   #define flat_argvp_envp_on_stack()			0
> -#define flat_old_ram_flag(flags)			(flags)
>   static inline int flat_get_addr_from_rp(u32 __user *rp, u32 relval, u32 flags,
>   					u32 *addr, u32 *persistent)
>   {
> diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
> index f87ddd1b6d72..5658e12ad944 100644
> --- a/fs/Kconfig.binfmt
> +++ b/fs/Kconfig.binfmt
> @@ -97,6 +97,9 @@ config BINFMT_FLAT
>   	help
>   	  Support uClinux FLAT format binaries.
>   
> +config BINFMT_FLAT_OLD_ALWAYS_RAM
> +	bool
> +
>   config BINFMT_ZFLAT
>   	bool "Enable ZFLAT support"
>   	depends on BINFMT_FLAT
> diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
> index c0e4535dc1ec..18d82fd5f57c 100644
> --- a/fs/binfmt_flat.c
> +++ b/fs/binfmt_flat.c
> @@ -488,7 +488,8 @@ static int load_flat_file(struct linux_binprm *bprm,
>   	 * fix up the flags for the older format,  there were all kinds
>   	 * of endian hacks,  this only works for the simple cases
>   	 */
> -	if (rev == OLD_FLAT_VERSION && flat_old_ram_flag(flags))
> +	if (IS_ENABLED(CONFIG_BINFMT_FLAT_OLD_ALWAYS_RAM) &&
> +	    rev == OLD_FLAT_VERSION)

The flags are from the binary file header here, so this is going to lose
that check for most platforms (except h8300 where it would always have
been true).

Regards
Greg

