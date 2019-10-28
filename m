Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929EDCA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 10:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64265214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 10:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572260391;
	bh=vnID9+Oo8Ba/7JkP4NlkjT8aLuIOGGl8S6SiOMEIGLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MUmdci9mVLawZ1sek10VKuv9P0iT4QCZXG9aWHZ39UTfLgOKZqjlL+GnkPa1nAVC2
	 3X6rIOKtq8VUaJNIw0vNzMugOs0riLg9KxyrYBjD7l00XOXhku1YQ0yjUAvgMBYSoz
	 CD9W1spyoB3QBtNj8J4dGqA8tbrp2bHFRag/V/tw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388437AbfJ1K7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 06:59:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728554AbfJ1K7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 06:59:50 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE75C20873;
        Mon, 28 Oct 2019 10:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572260389;
        bh=vnID9+Oo8Ba/7JkP4NlkjT8aLuIOGGl8S6SiOMEIGLM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZOynHkfmFX06vNr8sfpvCZQtP+oE9c+n01F6NmlPDm8xnwdvq8mtNOSlkhGKdWkJV
         5SNqE4Kw+KgkfR4LHBMn9kxVbXVJ0JAgzHWvt6ug5g6HreFNmQX5REz2u8FRKNnYtL
         l8HASqabKNYlo51wBS0ALEHgahupJhoOVPcDmWvw=
Date:   Mon, 28 Oct 2019 10:59:44 +0000
From:   Will Deacon <will@kernel.org>
To:     Candle Sun <candlesea@gmail.com>
Cc:     mark.rutland@arm.com, linux@armlinux.org.uk, orson.zhai@unisoc.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Candle Sun <candle.sun@unisoc.com>,
        Nianfu Bai <nianfu.bai@unisoc.com>
Subject: Re: [PATCH v2] ARM/hw_breakpoint: add more ARMv8 debug architecture
 versions support
Message-ID: <20191028105943.GA4122@willie-the-truck>
References: <20191024080539.9187-1-candlesea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024080539.9187-1-candlesea@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 04:05:39PM +0800, Candle Sun wrote:
> From: Candle Sun <candle.sun@unisoc.com>
> 
> When ARMv8 cores are used in AArch32 mode, arch_hw_breakpoint_init()
> in arch/arm/kernel/hw_breakpoint.c will be used.
> 
> From ARMv8 specification, v8 debug architecture versions defined:
> * 0110 ARMv8, v8 Debug architecture.
> * 0111 ARMv8.1, v8 Debug architecture, with Virtualization Host
>   Extensions.
> * 1000 ARMv8.2, v8.2 Debug architecture.
> * 1001 ARMv8.4, v8.4 Debug architecture.
> 
> So missing ARMv8.1/ARMv8.2/ARMv8.4 cases will cause
> enable_monitor_mode() returns -ENODEV,and eventually
> arch_hw_breakpoint_init() will fail.
> 
> Signed-off-by: Candle Sun <candle.sun@unisoc.com>
> Signed-off-by: Nianfu Bai <nianfu.bai@unisoc.com>
> ---
> Changes in v2:
> - Add ARMv8.4 debug architecture case
> - Update patch description
> ---
>  arch/arm/include/asm/hw_breakpoint.h | 3 +++
>  arch/arm/kernel/hw_breakpoint.c      | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/arch/arm/include/asm/hw_breakpoint.h b/arch/arm/include/asm/hw_breakpoint.h
> index ac54c06764e6..62358d3ca0a8 100644
> --- a/arch/arm/include/asm/hw_breakpoint.h
> +++ b/arch/arm/include/asm/hw_breakpoint.h
> @@ -53,6 +53,9 @@ static inline void decode_ctrl_reg(u32 reg,
>  #define ARM_DEBUG_ARCH_V7_MM	4
>  #define ARM_DEBUG_ARCH_V7_1	5
>  #define ARM_DEBUG_ARCH_V8	6
> +#define ARM_DEBUG_ARCH_V8_1	7
> +#define ARM_DEBUG_ARCH_V8_2	8
> +#define ARM_DEBUG_ARCH_V8_4	9
>  
>  /* Breakpoint */
>  #define ARM_BREAKPOINT_EXECUTE	0
> diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
> index b0c195e3a06d..02ca7adf5375 100644
> --- a/arch/arm/kernel/hw_breakpoint.c
> +++ b/arch/arm/kernel/hw_breakpoint.c
> @@ -246,6 +246,9 @@ static int enable_monitor_mode(void)
>  	case ARM_DEBUG_ARCH_V7_ECP14:
>  	case ARM_DEBUG_ARCH_V7_1:
>  	case ARM_DEBUG_ARCH_V8:
> +	case ARM_DEBUG_ARCH_V8_1:
> +	case ARM_DEBUG_ARCH_V8_2:
> +	case ARM_DEBUG_ARCH_V8_4:
>  		ARM_DBG_WRITE(c0, c2, 2, (dscr | ARM_DSCR_MDBGEN));
>  		isb();
>  		break;

Acked-by: Will Deacon <will@kernel.org>

Will
