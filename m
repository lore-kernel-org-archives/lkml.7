Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16B2C7618A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 06:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A62B120868
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 06:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbfGOGtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 02:49:41 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:35277 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbfGOGtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 02:49:40 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45nDfV4TBTz9sND;
        Mon, 15 Jul 2019 16:49:38 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Oliver O'Halloran <oohall@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/4] powerpc/32: activate ARCH_HAS_PMEM_API and ARCH_HAS_UACCESS_FLUSHCACHE
In-Reply-To: <0e779b35cf66fd4aa5ec0ec09fb7820f6c518cb3.1557824379.git.christophe.leroy@c-s.fr>
References: <239d1c8f15b8bedc161a234f9f1a22a07160dbdf.1557824379.git.christophe.leroy@c-s.fr> <0e779b35cf66fd4aa5ec0ec09fb7820f6c518cb3.1557824379.git.christophe.leroy@c-s.fr>
Date:   Mon, 15 Jul 2019 16:49:38 +1000
Message-ID: <87y30z94hp.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> PPC32 also have flush_dcache_range() so it can also support
> ARCH_HAS_PMEM_API and ARCH_HAS_UACCESS_FLUSHCACHE without changes.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index d7996cfaceca..cf6e30f637be 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -127,13 +127,13 @@ config PPC
>  	select ARCH_HAS_KCOV
>  	select ARCH_HAS_MMIOWB			if PPC64
>  	select ARCH_HAS_PHYS_TO_DMA
> -	select ARCH_HAS_PMEM_API                if PPC64
> +	select ARCH_HAS_PMEM_API
>  	select ARCH_HAS_PTE_SPECIAL
>  	select ARCH_HAS_MEMBARRIER_CALLBACKS
>  	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE && PPC64
>  	select ARCH_HAS_STRICT_KERNEL_RWX	if ((PPC_BOOK3S_64 || PPC32) && !RELOCATABLE && !HIBERNATION)
>  	select ARCH_HAS_TICK_BROADCAST		if GENERIC_CLOCKEVENTS_BROADCAST
> -	select ARCH_HAS_UACCESS_FLUSHCACHE	if PPC64
> +	select ARCH_HAS_UACCESS_FLUSHCACHE
>  	select ARCH_HAS_UBSAN_SANITIZE_ALL
>  	select ARCH_HAS_ZONE_DEVICE		if PPC_BOOK3S_64
>  	select ARCH_HAVE_NMI_SAFE_CMPXCHG

This didn't build for me, probably due to something that's changed in
the long period between you posting it and me applying it?

corenet32_smp_defconfig:

  powerpc64-unknown-linux-gnu-ld: lib/iov_iter.o: in function `_copy_from_iter_flushcache':
  powerpc64-unknown-linux-gnu-ld: /scratch/michael/build/maint/build~/../lib/iov_iter.c:825: undefined reference to `memcpy_page_flushcache'
  powerpc64-unknown-linux-gnu-ld: /scratch/michael/build/maint/build~/../lib/iov_iter.c:825: undefined reference to `memcpy_flushcache'
  powerpc64-unknown-linux-gnu-ld: /scratch/michael/build/maint/build~/../lib/iov_iter.c:825: undefined reference to `__copy_from_user_flushcache'
  powerpc64-unknown-linux-gnu-ld: /scratch/michael/build/maint/build~/../lib/iov_iter.c:825: undefined reference to `memcpy_flushcache'

cheers
