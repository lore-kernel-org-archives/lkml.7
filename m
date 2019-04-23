Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EDDC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF7B20674
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfDWKTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:19:31 -0400
Received: from foss.arm.com ([217.140.101.70]:53350 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbfDWKTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 06:19:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F3DB374;
        Tue, 23 Apr 2019 03:19:30 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E99243F557;
        Tue, 23 Apr 2019 03:19:26 -0700 (PDT)
Subject: Re: [PATCH 2/2] ARM: errata: add support for A12/A17 errata CR711784
To:     Douglas Anderson <dianders@chromium.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     mark.rutland@arm.com, Salva.Climent@arm.com,
        linux-rockchip@lists.infradead.org, sonnyrao@chromium.org,
        will.deacon@arm.com, bbatacha@arm.com, mka@chromium.org,
        heiko@sntech.de, Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Tony Lindgren <tony@atomide.com>
References: <20190419221803.99322-1-dianders@chromium.org>
 <20190419221803.99322-2-dianders@chromium.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <c28d37ab-b6d1-4bd0-9e03-dcf9ce499fc8@arm.com>
Date:   Tue, 23 Apr 2019 11:19:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190419221803.99322-2-dianders@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On 19/04/2019 23:18, Douglas Anderson wrote:
> This adds a code for turning on chicken bit 11, which appears to avoid
> a potential CPU deadlock that could occur.  The exact set of
> instruction needed to trigger this errata is not totaly known but we
> have a high level of confidence that the problem is fixed by setting
> chicken bit 11.
> 
> All details are in http://crbug.com/711784
> 
> This erratum has no known number and thus I have tagged it CR711784
> (after the Chrome OS bug number).  I have created separate A12 / A17
> configs to match how the rest of the A12 / A17 errata is handled.

The written-up workarounds for 85727[12] do actually say to set both 
bits 10 and 11 of the diagnostic register, so you could probably just 
fold this into the first patch and not have to worry about what to call it.

Robin.

> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>   arch/arm/Kconfig      | 18 ++++++++++++++++++
>   arch/arm/mm/proc-v7.S | 10 ++++++++++
>   2 files changed, 28 insertions(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 4376fe74f95e..34ec9039206b 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1181,6 +1181,13 @@ config ARM_ERRATA_857271
>   	  hang. The workaround is expected to have a negligible performance
>   	  impact.
>   
> +config ARM_ERRATA_CR711784_A12
> +	bool "ARM errata: A12: conditional instructions can lead to a CPU hang"
> +	depends on CPU_V7
> +	help
> +	  This option enables the workaround for a Cortex-A12 erratum without a
> +	  number. The problems are best described in https://crbug.com/711784
> +
>   config ARM_ERRATA_852421
>   	bool "ARM errata: A17: DMB ST might fail to create order between stores"
>   	depends on CPU_V7
> @@ -1212,6 +1219,17 @@ config ARM_ERRATA_857272
>   	  config option from the A12 erratum due to the way errata are checked
>   	  for and handled.
>   
> +config ARM_ERRATA_CR711784_A17
> +	bool "ARM errata: A17: conditional instructions can lead to a CPU hang"
> +	depends on CPU_V7
> +	help
> +	  This option enables the workaround for a Cortex-A17 erratum without a
> +	  number. The problems are best described in https://crbug.com/711784
> +	  This erratum is not known to be fixed in any A17 revision.
> +	  This is identical to Cortex-A12 erratum CR711784.  It is a separate
> +	  config option from the A12 erratum due to the way errata are checked
> +	  for and handled.
> +
>   endmenu
>   
>   source "arch/arm/common/Kconfig"
> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index cd2accbab844..a5156ea734ee 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -396,6 +396,11 @@ __ca12_errata:
>   	mrc	p15, 0, r10, c15, c0, 1		@ read diagnostic register
>   	orr	r10, r10, #1 << 10		@ set bit #10
>   	mcr	p15, 0, r10, c15, c0, 1		@ write diagnostic register
> +#endif
> +#ifdef CONFIG_ARM_ERRATA_CR711784_A12
> +	mrc	p15, 0, r10, c15, c0, 1		@ read diagnostic register
> +	orr	r10, r10, #1 << 11		@ set bit #11
> +	mcr	p15, 0, r10, c15, c0, 1		@ write diagnostic register
>   #endif
>   	b	__errata_finish
>   
> @@ -416,6 +421,11 @@ __ca17_errata:
>   	mrc	p15, 0, r10, c15, c0, 1		@ read diagnostic register
>   	orr	r10, r10, #1 << 10		@ set bit #10
>   	mcr	p15, 0, r10, c15, c0, 1		@ write diagnostic register
> +#endif
> +#ifdef CONFIG_ARM_ERRATA_CR711784_A17
> +	mrc	p15, 0, r10, c15, c0, 1		@ read diagnostic register
> +	orr	r10, r10, #1 << 11		@ set bit #11
> +	mcr	p15, 0, r10, c15, c0, 1		@ write diagnostic register
>   #endif
>   	b	__errata_finish
>   
> 
