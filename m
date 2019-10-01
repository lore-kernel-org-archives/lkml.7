Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E019EECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B34F920842
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569936406;
	bh=8AYODUkLIhWgx1CLwLKwmalHpwZd+Q1qNbypTTN8BA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tpMhIySVrDkgnmUyMh2eaKUUqeMLiuxnaVWlm/hPRYmNW+mB5/Hf3gLFeTgr1tKfJ
	 rEO1gyqlW6tesINqmSoWRz6W5nV85rzBRz5kn6A2s+YePuryzAcKfga1gWTzRjBfSI
	 wEYeZ7YYDJUnyGetR2a5Ebuc0hpHudp+2VWelmwI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388386AbfJAN0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:26:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:57042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388261AbfJAN0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:26:45 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9840D205F4;
        Tue,  1 Oct 2019 13:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569936405;
        bh=8AYODUkLIhWgx1CLwLKwmalHpwZd+Q1qNbypTTN8BA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UXd0w/I5aELR21rcXWrbb71PaZrP98X1Anl3gA8DKH6zugoz0yNvo54azsQLSY/tg
         s7tggAZBvV8cfVt1IpjNFUUW3hGD8J4DUZ7gi3ZVQnyYnVx0l32rbxn0XfDYY3LIzZ
         z/K8THG6o5F+HXl8uDRmBicNsWl2C45WcZstVkig=
Date:   Tue, 1 Oct 2019 14:26:40 +0100
From:   Will Deacon <will@kernel.org>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, ndesaulniers@google.com,
        catalin.marinas@arm.com, tglx@linutronix.de
Subject: Re: [PATCH v3 2/5] arm64: vdso32: Detect binutils support for dmb
 ishld
Message-ID: <20191001132640.plowjzi5nmajs72x@willie-the-truck>
References: <20190920142738.qlsjwguc6bpnez63@willie-the-truck>
 <20190926214342.34608-1-vincenzo.frascino@arm.com>
 <20190926214342.34608-3-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926214342.34608-3-vincenzo.frascino@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 10:43:39PM +0100, Vincenzo Frascino wrote:
> As reported by Will Deacon, older versions of binutils that do not
> support certain types of memory barriers can cause build failure of the
> vdso32 library.
> 
> Add a compilation time mechanism that detects if binutils supports those
> instructions and configure the kernel accordingly.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/arm64/include/asm/vdso/compat_barrier.h | 2 +-
>  arch/arm64/kernel/vdso32/Makefile            | 9 +++++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/vdso/compat_barrier.h b/arch/arm64/include/asm/vdso/compat_barrier.h
> index fb60a88b5ed4..3fd8fd6d8fc2 100644
> --- a/arch/arm64/include/asm/vdso/compat_barrier.h
> +++ b/arch/arm64/include/asm/vdso/compat_barrier.h
> @@ -20,7 +20,7 @@
>  
>  #define dmb(option) __asm__ __volatile__ ("dmb " #option : : : "memory")
>  
> -#if __LINUX_ARM_ARCH__ >= 8
> +#if __LINUX_ARM_ARCH__ >= 8 && defined(CONFIG_AS_DMB_ISHLD)
>  #define aarch32_smp_mb()	dmb(ish)
>  #define aarch32_smp_rmb()	dmb(ishld)
>  #define aarch32_smp_wmb()	dmb(ishst)
> diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
> index 19e0d3115ffe..77aa61340374 100644
> --- a/arch/arm64/kernel/vdso32/Makefile
> +++ b/arch/arm64/kernel/vdso32/Makefile
> @@ -15,6 +15,8 @@ cc32-disable-warning = $(call try-run,\
>  	$(COMPATCC) -W$(strip $(1)) -c -x c /dev/null -o "$$TMP",-Wno-$(strip $(1)))
>  cc32-ldoption = $(call try-run,\
>          $(COMPATCC) $(1) -nostdlib -x c /dev/null -o "$$TMP",$(1),$(2))
> +cc32-as-instr = $(call try-run,\
> +	printf "%b\n" "$(1)" | $(COMPATCC) $(VDSO_AFLAGS) -c -x assembler -o "$$TMP" -,$(2),$(3))

It's a shame that we have to duplicate the logic from scripts/Kbuild.include
here. Is there a way to reuse those helpers by temporarily overriding things
like CC and KBUILD_AFLAGS? If not, no bother, but thought I'd better ask.

Will
