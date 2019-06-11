Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1159AC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 09:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29E7214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 09:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404987AbfFKJ7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 05:59:52 -0400
Received: from foss.arm.com ([217.140.110.172]:57148 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727641AbfFKJ7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 05:59:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25EB4337;
        Tue, 11 Jun 2019 02:59:51 -0700 (PDT)
Received: from [10.1.29.141] (e121487-lin.cambridge.arm.com [10.1.29.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18C923F73C;
        Tue, 11 Jun 2019 03:01:31 -0700 (PDT)
Subject: Re: [PATCH 09/15] binfmt_flat: add a ARCH_HAS_BINFMT_FLAT option
To:     Christoph Hellwig <hch@lst.de>, Greg Ungerer <gerg@linux-m68k.org>
Cc:     uclinux-h8-devel@lists.sourceforge.jp,
        linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>,
        linux-c6x-dev@linux-c6x.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20190610212015.9157-1-hch@lst.de>
 <20190610212015.9157-10-hch@lst.de>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <416fd8cc-6721-ff40-d90e-6755e490fd61@arm.com>
Date:   Tue, 11 Jun 2019 10:59:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610212015.9157-10-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/19 10:20 PM, Christoph Hellwig wrote:
> Allow architectures to opt into ARCH_HAS_BINFMT_FLAT support instead of
> assuming that all nommu ports support the format.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm/Kconfig        | 1 +
>  arch/c6x/Kconfig        | 1 +
>  arch/h8300/Kconfig      | 1 +
>  arch/m68k/Kconfig       | 1 +
>  arch/microblaze/Kconfig | 1 +
>  arch/sh/Kconfig         | 1 +
>  arch/xtensa/Kconfig     | 1 +
>  fs/Kconfig.binfmt       | 5 ++++-
>  8 files changed, 11 insertions(+), 1 deletion(-)


For ARM bits:

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>


> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index b1b48c0bde76..695a26c68064 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -4,6 +4,7 @@ config ARM
>  	default y
>  	select ARCH_32BIT_OFF_T
>  	select ARCH_CLOCKSOURCE_DATA
> +	select ARCH_HAS_BINFMT_FLAT
>  	select ARCH_HAS_DEBUG_VIRTUAL if MMU
>  	select ARCH_HAS_DEVMEM_IS_ALLOWED
>  	select ARCH_HAS_ELF_RANDOMIZE
> diff --git a/arch/c6x/Kconfig b/arch/c6x/Kconfig
> index eeb0471268a0..78dfe186d708 100644
> --- a/arch/c6x/Kconfig
> +++ b/arch/c6x/Kconfig
> @@ -7,6 +7,7 @@
>  config C6X
>  	def_bool y
>  	select ARCH_32BIT_OFF_T
> +	select ARCH_HAS_BINFMT_FLAT
>  	select ARCH_HAS_SYNC_DMA_FOR_CPU
>  	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
>  	select CLKDEV_LOOKUP
> diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
> index 7457f190caaa..ec800e9d5aad 100644
> --- a/arch/h8300/Kconfig
> +++ b/arch/h8300/Kconfig
> @@ -2,6 +2,7 @@
>  config H8300
>          def_bool y
>  	select ARCH_32BIT_OFF_T
> +	select ARCH_HAS_BINFMT_FLAT
>  	select BINFMT_FLAT_ARGVP_ENVP_ON_STACK
>  	select BINFMT_FLAT_OLD_ALWAYS_RAM
>  	select GENERIC_ATOMIC64
> diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
> index fd69ee5ad6ab..c0c43c624afa 100644
> --- a/arch/m68k/Kconfig
> +++ b/arch/m68k/Kconfig
> @@ -3,6 +3,7 @@ config M68K
>  	bool
>  	default y
>  	select ARCH_32BIT_OFF_T
> +	select ARCH_HAS_BINFMT_FLAT
>  	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if HAS_DMA
>  	select ARCH_MIGHT_HAVE_PC_PARPORT if ISA
>  	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
> diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
> index f11433daab4a..d411de05b628 100644
> --- a/arch/microblaze/Kconfig
> +++ b/arch/microblaze/Kconfig
> @@ -3,6 +3,7 @@ config MICROBLAZE
>  	def_bool y
>  	select ARCH_32BIT_OFF_T
>  	select ARCH_NO_SWAP
> +	select ARCH_HAS_BINFMT_FLAT if !MMU
>  	select ARCH_HAS_DMA_COHERENT_TO_PFN if MMU
>  	select ARCH_HAS_GCOV_PROFILE_ALL
>  	select ARCH_HAS_SYNC_DMA_FOR_CPU
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index b77f512bb176..df3e6215b78c 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  config SUPERH
>  	def_bool y
> +	select ARCH_HAS_BINFMT_FLAT if !MMU
>  	select ARCH_HAS_PTE_SPECIAL
>  	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>  	select ARCH_MIGHT_HAVE_PC_PARPORT
> diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
> index 6ec1b75eabc5..ebc135bda921 100644
> --- a/arch/xtensa/Kconfig
> +++ b/arch/xtensa/Kconfig
> @@ -2,6 +2,7 @@
>  config XTENSA
>  	def_bool y
>  	select ARCH_32BIT_OFF_T
> +	select ARCH_HAS_BINFMT_FLAT if !MMU
>  	select ARCH_HAS_SYNC_DMA_FOR_CPU
>  	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
>  	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
> diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
> index 82f7d7f234f3..286b425b30b9 100644
> --- a/fs/Kconfig.binfmt
> +++ b/fs/Kconfig.binfmt
> @@ -91,9 +91,12 @@ config BINFMT_SCRIPT
>  
>  	  Most systems will not boot if you say M or N here.  If unsure, say Y.
>  
> +config ARCH_HAS_BINFMT_FLAT
> +	bool
> +
>  config BINFMT_FLAT
>  	bool "Kernel support for flat binaries"
> -	depends on !MMU || ARM || M68K
> +	depends on ARCH_HAS_BINFMT_FLAT
>  	help
>  	  Support uClinux FLAT format binaries.
>  
> 

