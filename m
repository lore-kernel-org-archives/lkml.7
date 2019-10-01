Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A61ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD76221906
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569935669;
	bh=USjyyXfyKCbNO6tLGkaM43cTWlPVDGf+sgQmt+K7JEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sGWrXM/9KqkA/y29arY3Uv4KQc7Z5uRTFIcQcvM2qqvm2gvz0ioRpS9fYdvsGrTJH
	 ayhlIK/GvECORoZUQUfkVocloSNdD61Z90SCra8h/ahTOETuyhoZQSODWdkDxrjFr5
	 1SNB6L3CC/O0JS+wbCqLAdQDMukf+Htl3y+BbS2I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388050AbfJANO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:14:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbfJANO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:14:28 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D47320640;
        Tue,  1 Oct 2019 13:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569935667;
        bh=USjyyXfyKCbNO6tLGkaM43cTWlPVDGf+sgQmt+K7JEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XVdzqlbYrBfzwj0oKPB4Ei42Ra4tnPKM1W4qUXly4CNnSqC8uEjNLuzD+/nGLB+Uz
         OY/qQeLMUrvO9vRl/K8zArFDPV8wioU4UDLEMB9e9nKmv4d7V+vDkqcBaAtMJ6lpEp
         Xe+SVraz3XKSKwMGFdzITHT7q3zqYS1EOdnItJUc=
Date:   Tue, 1 Oct 2019 14:14:23 +0100
From:   Will Deacon <will@kernel.org>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, ndesaulniers@google.com,
        catalin.marinas@arm.com, tglx@linutronix.de
Subject: Re: [PATCH v3 1/5] arm64: vdso32: Introduce COMPAT_CC_IS_GCC
Message-ID: <20191001131420.y3fsydlo7pg6ykfs@willie-the-truck>
References: <20190920142738.qlsjwguc6bpnez63@willie-the-truck>
 <20190926214342.34608-1-vincenzo.frascino@arm.com>
 <20190926214342.34608-2-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926214342.34608-2-vincenzo.frascino@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 10:43:38PM +0100, Vincenzo Frascino wrote:
> As reported by Will Deacon the .config file and the generated
> include/config/auto.conf can end up out of sync after a set of
> commands since CONFIG_CROSS_COMPILE_COMPAT_VDSO is not updated
> correctly.
> 
> The sequence can be reproduced as follows:
> 
> $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig
> [...]
> $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- menuconfig
> [set CONFIG_CROSS_COMPILE_COMPAT_VDSO="arm-linux-gnueabihf-"]
> $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
> 
> Which results in:
> 
> arch/arm64/Makefile:62: CROSS_COMPILE_COMPAT not defined or empty,
> the compat vDSO will not be built
> 
> even though the compat vDSO has been built:
> 
> $ file arch/arm64/kernel/vdso32/vdso.so
> arch/arm64/kernel/vdso32/vdso.so: ELF 32-bit LSB pie executable, ARM,
> EABI5 version 1 (SYSV), dynamically linked,
> BuildID[sha1]=c67f6c786f2d2d6f86c71f708595594aa25247f6, stripped
> 
> A similar case that involves changing the configuration parameter multiple
> times can be reconducted to the same family of problems.
> 
> The reason behind it comes from the fact that the master Makefile includes
> that architecture Makefile twice, once before the syncconfig and one after.
> Since the synchronization of the files happens only upon syncconfig, the
> architecture Makefile included before this event does not see the change in
> configuration.
> 
> As a consequence of this it is not possible to handle the cross compiler
> definitions inside the architecture Makefile.
> 
> Address the problem removing CONFIG_CROSS_COMPILE_COMPAT_VDSO and moving
> the detection of the correct compiler into Kconfig via COMPAT_CC_IS_GCC.
> 
> As a consequence of this it is not possible anymore to set the compat
> cross compiler from menuconfig but it requires to be exported via
> command line.
> 
> E.g.:
> 
> $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
> CROSS_COMPILE_COMPAT=arm-linux-gnueabihf
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/arm64/Kconfig                |  5 ++++-
>  arch/arm64/Makefile               | 18 +++++-------------
>  arch/arm64/kernel/vdso32/Makefile |  2 --
>  3 files changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 37c610963eee..0e5beb928af5 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -110,7 +110,7 @@ config ARM64
>  	select GENERIC_STRNLEN_USER
>  	select GENERIC_TIME_VSYSCALL
>  	select GENERIC_GETTIMEOFDAY
> -	select GENERIC_COMPAT_VDSO if (!CPU_BIG_ENDIAN && COMPAT)
> +	select GENERIC_COMPAT_VDSO if (!CPU_BIG_ENDIAN && COMPAT && COMPATCC_IS_ARM_GCC)
>  	select HANDLE_DOMAIN_IRQ
>  	select HARDIRQS_SW_RESEND
>  	select HAVE_PCI
> @@ -313,6 +313,9 @@ config KASAN_SHADOW_OFFSET
>  	default 0xeffffff900000000 if ARM64_VA_BITS_36 && KASAN_SW_TAGS
>  	default 0xffffffffffffffff
>  
> +config COMPATCC_IS_ARM_GCC
> +	def_bool $(success,$(COMPATCC) --version | head -n 1 | grep -q "arm-.*-gcc")

I've seen toolchains where the first part of the tuple is "armv7-", so they
won't get detected here. However, do we really need to detect this? If
somebody passes a duff compiler, then the build will fail in the same way as
if they passed it to CROSS_COMPILE=.

I'd prefer to drop this check altogether.

Will
