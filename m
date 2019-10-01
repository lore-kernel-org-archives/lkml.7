Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76F1C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 21:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AECDC2133F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 21:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GR21Dtnb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbfJAVyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 17:54:36 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43590 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728425AbfJAVya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 17:54:30 -0400
Received: by mail-pg1-f196.google.com with SMTP id v27so10628813pgk.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 14:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ENE8lCt1crf8LnnzzVk3RdzghYu9Y7qjMvfHyutZqEM=;
        b=GR21DtnbEA+kE+k0vTIHmfnhDfZIY2DCbYDDM9cr2SMWYDc646u3WaARyfEPa6KztD
         cvlh3UXseCaxYmoqq8aHPohxyGr1cYzO8eSy+rpjsk18BLmbU7BJy9npjiDEzWdaZIku
         IadqA5LQZ0CBF3kZm8h2e2JgPPz89cPl67PE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ENE8lCt1crf8LnnzzVk3RdzghYu9Y7qjMvfHyutZqEM=;
        b=cJw1JPQkEORmKz4hZu6GPcYPWtkbRxkldTrktQVFlL4jAvuAhsYFeyxa2geKsjWLIx
         wFCsJ1zl6zjjd3075xRFqXnWqghDBPGGF6e3S4pWsg5deYtvIM9zII/6URglCSENreTv
         GMVioJok30Trm4K2CtGqLQxZ5GywSXe+LtBWGM6m0teCWFvVcExJqDvwVP4o11zvTsJq
         UrA2FIVSHiB7N5Iky/VYqmxXnDpvtbh1Br68frAAIA5nfqJpt3aZ2LFW78ViPqrd+wF8
         DaklFplpG6ufweGpScB8Q2ouPrugVMLcZcKrCLb87DzMJi2hSiMGY8/e+szG6bGRAiwa
         3lmw==
X-Gm-Message-State: APjAAAWJrkjg6V9lA6UKUmuugzyvCl5cXXlb10fOhf2OUChYD9KVtVTn
        tXmTYLI5nQv9EqA9Gl6sLfI1eQ==
X-Google-Smtp-Source: APXvYqynDNpZsGHGKSmI8DACWshnS2LNeZcLSDFiHhvjfnDhCaVpMBz/yjaQFBaT1mFxvnQmvG24OQ==
X-Received: by 2002:a62:b40a:: with SMTP id h10mr601438pfn.88.1569966869584;
        Tue, 01 Oct 2019 14:54:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b73sm8535469pga.36.2019.10.01.14.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 14:54:28 -0700 (PDT)
Date:   Tue, 1 Oct 2019 14:54:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Bill Metzenthen <billm@melbpc.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86: math-emu: limit MATH_EMULATION to 486SX
 compatibles
Message-ID: <201910011454.3B8E504091@keescook>
References: <20191001142344.1274185-1-arnd@arndb.de>
 <20191001142344.1274185-2-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191001142344.1274185-2-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 04:23:35PM +0200, Arnd Bergmann wrote:
> The fpu emulation code is old and fragile in places, try to limit its
> use to builds for CPUs that actually use it. As far as I can tell,
> this is only true for i486sx compatibles, including the Cyrix 486SLC,
> AMD Am486SX and ÉLAN SC410, UMC U5S amd DM&P VortexSX86, all of which
> were relatively short-lived and got replaced with i486DX compatible
> processors soon after introduction, though the some of the embedded
> versions remained available much longer.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Nice, I like carving out CONFIG space for 486SX; this makes sense to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/x86/Kconfig              |  2 +-
>  arch/x86/Kconfig.cpu          | 25 ++++++++++++++++---------
>  arch/x86/Makefile_32.cpu      |  1 +
>  arch/x86/include/asm/module.h |  2 ++
>  4 files changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index f4d9d1e55e5c..77b02387bd0c 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1751,7 +1751,7 @@ config X86_RESERVE_LOW
>  config MATH_EMULATION
>  	bool
>  	depends on MODIFY_LDT_SYSCALL
> -	prompt "Math emulation" if X86_32
> +	prompt "Math emulation" if X86_32 && (M486SX || MELAN)
>  	---help---
>  	  Linux can emulate a math coprocessor (used for floating point
>  	  operations) if you don't have one. 486DX and Pentium processors have
> diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
> index 228705a1232a..5f7bff9885a1 100644
> --- a/arch/x86/Kconfig.cpu
> +++ b/arch/x86/Kconfig.cpu
> @@ -50,12 +50,19 @@ choice
>  	  See each option's help text for additional details. If you don't know
>  	  what to do, choose "486".
>  
> +config M486SX
> +	bool "486SX"
> +	depends on X86_32
> +	---help---
> +	  Select this for an 486-class CPU without an FPU such as
> +	  AMD/Cyrix/IBM/Intel SL/SLC/SLC2/SLC3/SX/SX2 and UMC U5S.
> +
>  config M486
> -	bool "486"
> +	bool "486DX"
>  	depends on X86_32
>  	---help---
>  	  Select this for an 486-class CPU such as AMD/Cyrix/IBM/Intel
> -	  486DX/DX2/DX4 or SL/SLC/SLC2/SLC3/SX/SX2 and UMC U5D or U5S.
> +	  486DX/DX2/DX4 and UMC U5D.
>  
>  config M586
>  	bool "586/K5/5x86/6x86/6x86MX"
> @@ -313,20 +320,20 @@ config X86_L1_CACHE_SHIFT
>  	int
>  	default "7" if MPENTIUM4 || MPSC
>  	default "6" if MK7 || MK8 || MPENTIUMM || MCORE2 || MATOM || MVIAC7 || X86_GENERIC || GENERIC_CPU
> -	default "4" if MELAN || M486 || MGEODEGX1
> +	default "4" if MELAN || M486SX || M486 || MGEODEGX1
>  	default "5" if MWINCHIP3D || MWINCHIPC6 || MCRUSOE || MEFFICEON || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2 || MGEODE_LX
>  
>  config X86_F00F_BUG
>  	def_bool y
> -	depends on M586MMX || M586TSC || M586 || M486
> +	depends on M586MMX || M586TSC || M586 || M486SX || M486
>  
>  config X86_INVD_BUG
>  	def_bool y
> -	depends on M486
> +	depends on M486SX || M486
>  
>  config X86_ALIGNMENT_16
>  	def_bool y
> -	depends on MWINCHIP3D || MWINCHIPC6 || MCYRIXIII || MELAN || MK6 || M586MMX || M586TSC || M586 || M486 || MVIAC3_2 || MGEODEGX1
> +	depends on MWINCHIP3D || MWINCHIPC6 || MCYRIXIII || MELAN || MK6 || M586MMX || M586TSC || M586 || M486SX || M486 || MVIAC3_2 || MGEODEGX1
>  
>  config X86_INTEL_USERCOPY
>  	def_bool y
> @@ -379,7 +386,7 @@ config X86_MINIMUM_CPU_FAMILY
>  
>  config X86_DEBUGCTLMSR
>  	def_bool y
> -	depends on !(MK6 || MWINCHIPC6 || MWINCHIP3D || MCYRIXIII || M586MMX || M586TSC || M586 || M486) && !UML
> +	depends on !(MK6 || MWINCHIPC6 || MWINCHIP3D || MCYRIXIII || M586MMX || M586TSC || M586 || M486SX || M486) && !UML
>  
>  menuconfig PROCESSOR_SELECT
>  	bool "Supported processor vendors" if EXPERT
> @@ -403,7 +410,7 @@ config CPU_SUP_INTEL
>  config CPU_SUP_CYRIX_32
>  	default y
>  	bool "Support Cyrix processors" if PROCESSOR_SELECT
> -	depends on M486 || M586 || M586TSC || M586MMX || (EXPERT && !64BIT)
> +	depends on M486SX || M486 || M586 || M586TSC || M586MMX || (EXPERT && !64BIT)
>  	---help---
>  	  This enables detection, tunings and quirks for Cyrix processors
>  
> @@ -471,7 +478,7 @@ config CPU_SUP_TRANSMETA_32
>  config CPU_SUP_UMC_32
>  	default y
>  	bool "Support UMC processors" if PROCESSOR_SELECT
> -	depends on M486 || (EXPERT && !64BIT)
> +	depends on M486SX || M486 || (EXPERT && !64BIT)
>  	---help---
>  	  This enables detection, tunings and quirks for UMC processors
>  
> diff --git a/arch/x86/Makefile_32.cpu b/arch/x86/Makefile_32.cpu
> index 1f5faf8606b4..cd3056759880 100644
> --- a/arch/x86/Makefile_32.cpu
> +++ b/arch/x86/Makefile_32.cpu
> @@ -10,6 +10,7 @@ else
>  tune		= $(call cc-option,-mcpu=$(1),$(2))
>  endif
>  
> +cflags-$(CONFIG_M486SX)		+= -march=i486
>  cflags-$(CONFIG_M486)		+= -march=i486
>  cflags-$(CONFIG_M586)		+= -march=i586
>  cflags-$(CONFIG_M586TSC)	+= -march=i586
> diff --git a/arch/x86/include/asm/module.h b/arch/x86/include/asm/module.h
> index 7948a17febb4..c215d2762488 100644
> --- a/arch/x86/include/asm/module.h
> +++ b/arch/x86/include/asm/module.h
> @@ -15,6 +15,8 @@ struct mod_arch_specific {
>  
>  #ifdef CONFIG_X86_64
>  /* X86_64 does not define MODULE_PROC_FAMILY */
> +#elif defined CONFIG_M486SX
> +#define MODULE_PROC_FAMILY "486SX "
>  #elif defined CONFIG_M486
>  #define MODULE_PROC_FAMILY "486 "
>  #elif defined CONFIG_M586
> -- 
> 2.20.0
> 

-- 
Kees Cook
